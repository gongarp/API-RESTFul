unit DM_Global_Var;


interface
uses
  DM_Variables_Valorizacion,
  FireDAC.Comp.Client,
  DM_Base_Datos;

const
{$j+}
//  Fecha_Nula = '30/12/1899';  // Fecha considerada nula en el sistema
  Fecha_Nula : string = '30/12/1899';  // Fecha considerada nula en el sistema
{$j-}

//  sKey           : string = 'PMS-2009';
  Clave_Key_Reg  : string = 'Software\PMS\Software';

Type
  TArr100_String = Array[1..200] of String;

// Encripta
  TKey = Array[0..133] of String;
/// Informe IFRS Nota 8
   TRegArrayNodo = Record
              Nodo_Qs   : Double;
              Nivel1    : Double;
              Nivel2    : Double;
              Nivel3    : Double;
              Total     : Double;
              Libro     : Double;
              Efecto_RF    : Double;
              Efecto_RV    : Double;
             end;

  TArray_Nodo = array[1..1000] of TRegArrayNodo;
// Resgistro LOG
   TRegArrayLog = Record
                  Pid               : Double;
                  Fecha_hora        : TDateTime;
                  Item              : Integer;
                  Campo             : String;
                  Valor             : String;
                  end;

  TArray_Reg_Log = array[1..1000] of TRegArrayLog;

// Resgistro LOG Respaldo
   TRegArrayRes = Record
                  Campo             : String;
                  Valor             : String;
                  end;

   TArrayContab = Record
                  Clasificacion           : String;
                  Tipo_contab             : String;
                  end;

  TArray_Reg_Res = array[1..1000] of TRegArrayRes;

  TArray_Contab = array[1..100] of TArrayContab;

// Modificacion de Resgistro
   TRegArrayMod = Record
                  Pid               : Double;
                  Fecha_hora        : TDateTime;
                  Item              : Integer;
                  Campo             : String;
                  Descr_Campo       : String;
                  Valor_antes       : String;
                  Valor_despues     : String;
                  end;

  TArray_Reg_Mod = array[1..10000] of TRegArrayMod;

  TRegistro_Carteras = Record
                       sEmpresa     : Variant;
                       sCartera     : Variant;
                       end;

//// Registros Contables

  TReg_CodMonto = Record
               Cod_Detail       : Variant;
               Desc_Detail      : Variant;
               end;

  TRegArrayGrilla = Record
                    sLabel : Variant;
                    sMask  : Variant;
                    end;
var
  // Variables de Arreglos de Memoria
  ArrayValores : Variant;
  ArrayFechas  : Variant;
  Array_CodigoDivision : Variant;
  Array_AnoFeriado : Variant;
  Array_MesFeriado : Variant;
  Array_DiaFeriado : Variant;
  sQuienLlama,
  sCodigo_Impuesto_Instrumento,
  sTabla_Errores_Prdx : String;
  Reg_Tratam        : TReg_Tratam;
  Reg_Stock         : TReg_Stock;
  Reg_Errores_Stock : TReg_Errores_Stock;
//  Reg_Carteras      : TReg_Carteras;

  // Variable para cargar Feriados de Un Determinado codigo de división
  Reg_Feriados,
  Reg_Dias_Feriados : TReg_Feriados;

  // Variable para almacenar valor de tasa en proyeccion Simple
  Reg_Proy_Simple   : TReg_Proy_Simple;

  //Variables que contienen datos de base de conversion de descriptor y Tasa Flotante
  Reg_Base_Conversion : TReg_Base_Conversion;

  //Variables que contienen datos de base base variables
  Reg_Base_Variable  : TReg_Base_Variable;

  // Variable de tabla Desagio
  Reg_Desagio : TReg_Desagio;

  //Variable de Valuacion
  Reg_Valuacion      : TReg_Valuacion;
  Reg_Valuacion_Sup  : TReg_Valuacion_Sup;
  Reg_Valor_Contable : TReg_Valor_Contable;

  //Variables para Codigos TOM
  reg_codigos_tom  :   TReg_Codigos_Tom;

  //Variable de Amortizacion IncDec (Diferencia de Precio)
  Reg_Amortizacion_IncDec : TReg_Amortizacion_IncDec;

  Reg_Gastos_en_Costo     : TReg_Gastos_en_Costo;

  Reg_Formula_Tasas       : TReg_Formula_Tasas;

  Reg_Prob_Deterioro_Nemo : TReg_Prob_Deterioro_Nemo;
  Reg_Prob_Recupero_Nemo  : TReg_Prob_Recupero_Nemo;

  Reg_Prob_Deterioro_Clasif_Riesgo : TReg_Prob_Deterioro_Clasif_Riesgo;

  Reg_Recupero_Instrum    : TReg_Recupero_Instrum;

  Reg_Deterioro_Cl_Riesgo : TReg_Deterioro_Cl_Riesgo;

  Reg_Notching_Table      : TReg_Notching_Table;

  Reg_Loss_Given_Default  : TReg_Loss_Given_Default;

  var
   sKey               : string;
   sAD: string;

   sFileSCDP1         : String;
   sFileSCDP3         : String;
   sFileSCDAP3        : String;

   sFileSCDP1C        : String;
   sFileSCDAP1C       : String;

   sFileSCDP1P        : String;
   sFileSCDP3P        : String;
   sFileSCDP5P        : String;

   sFileSCDP1D        : String;
   sFileSCDP3D        : String;
   sFileSCDP5D        : String;

   sFileSCDPS         : String;

   sFileSCDP4         : String;
   sFileSCDP4_Anexo   : String;
   sFileSCDAP4         : String;
   sFileSCDAP4_Anexo   : String;

   sFileSCDP5         : String;
   sFileSCDP5_Anexo   : string;
   sFileSCDAP5        : string;
   sFileSCDAP5_Anexo  : string;
   sFileSCDAP1        : String;
   sFile_SCDP1AS1     : String;
   sFile_SCDP1AS2     : String;
   sFile_SCDP1AS1_CON : String;
   sFile_SCDP1AS2_CON : String;
   sFile_SCDSBC       : String;
   sFile_SCDAP2       : String;

   sFileSCDPBCO       : String;
   sFileSCDP3BCO      : String;
   sFileSCDAP3BCO     : String;
   sFileSCDP1BCO      : String;
   sFileSCDAP1BCO     : String;
   sFileSCDP4BCO      : String;
   sFileSCDAP4BCO     : String;
   sFileSCDP5BCO      : String;
   sFileSCDAP5BCO     : String;

   sFileSCDP1R        : String;
   sFileSCDAP1R       : String;
   sFile_SCDDBPART1   : String;
   sFile_SCDDBPART3   : String;
   sFile_SCDDBPART5   : String;

   sFile_SCDDPART3REA  : String;
   sFile_SCDDAPART3REA : String;
   sFile_SCDDPART4REA  : String;
   sFile_SCDDAPART4REA : String;
   sFile_SCDDPART5REA  : String;
   sFile_SCDDAPART5REA : String;

   sFile_SCDPARTDIF4   : String;
   sFile_SCDPARTDIF5   : String;
   sFile_SCDAPARTDIF4  : String;
   sFile_SCDAPARTDIF5  : String;

   sFile_SCDPART1DF   :String;
   sFile_SCDPART3DF   :String;
   sFile_SCDPART4DF   :String;
   sFile_SCDPART5DF   :String;
   sFile_SCDAPART1DF  :String;
   sFile_SCDAPART3DF  :String;
   sFile_SCDAPART4DF  :String;
   sFile_SCDAPART5DF  :String;
   sFile_SCDPART3RDF  :String;
   sFile_SCDPART4RDF  :String;
   sFile_SCDPART5RDF  :String;
   sFile_SCDAPART3RDF :String;
   sFile_SCDAPART4RDF :String;
   sFile_SCDAPART5RDF :String;

   sFileSCDPECLD :String;
   sFileSCDPECLR :String;
   sFileSCDPECLV :String;
   sFileSCDPECLA :String;
   sFile_SCDPART1H  :String;
   sFile_SCDPART3H  :String;
   sFile_SCDPART4H  :String;
   sFile_SCDPART5H  :String;
   sFile_SCDAPART1H :String;
   sFile_SCDAPART3H :String;
   sFile_SCDAPART4H :String;
   sFile_SCDAPART5H :String;
   sFile_SCINVPOCI  :String;
   sFile_SCRESULPOCI : String;

   sLog_File          : String;

   sFile_Datos_FIFO   : String;
   sFile_Errores_FIFO : String;

   sFile_Datos_FIFO_Ahorro   : String;
   sFile_Errores_FIFO_Ahorro : String;

   bOtros,
   bDpart1,
   bDpart3,
   bDApart3,
   bDpart4,
   bDpart4D,
   bDApart4,
   bDpart5,
   bDApart5,
   bDApart1,
   bDPart1P,
   bDPart3P,
   bDPart1C,
   bDAPart1C,
   bDPart5P,
   bDBPart3,
   bDBPart5,
   bDPart1_DI,
   bDPart3_DI,
   bDAPart5_DI,
   bDAPart4_DI,
   bDPart4_DI,
   bDPart5_DI,
   bDPart3_RE,
   bDPart4_RE,
   bDPart5_RE,
   bDAPart3_RE,
   bDAPart4_RE,
   bDAPart5_RE,
   bDBPart1,
   bDPart1Df,
   bDPart3Df,
   bDPart4Df,
   bDPart5Df,
   bDAPart1Df,
   bDAPart3Df,
   bDAPart4Df,
   bDAPart5Df,
   bDPart3RDf,
   bDPart4RDf,
   bDPart5RDf,
   bDAPart3RDf,
   bDAPart4RDf,
   bDAPart5RDf,
   bDPartECLD,
   bDPartECLR,
   bDpartECLV,
   bDpartECLA,
   bDPART1HAIR,
   bDPART3HAIR,
   bDPART4HAIR,
   bDPART5HAIR,
   bDAPART1HAIR,
   bDAPART3HAIR,
   bDAPART4HAIR,
   bDAPART5HAIR,
   bAnalitInvPOCI,
   bAnalitResPOCI : Boolean;

   //bDerivados,
   bCupones,
   bRecla_Dif,
   bRecla_ECL,
   bCupones_re,
   bPactos,
   bDPart1D,
   bDPart3D,
   bDPart5D,
   bReclasificacion,
   bHAIRCUT,
   bHAIRCUTINV,
   bECL                : Boolean;

   bAnalitInv,
   bAnalitRes          : Boolean;

   bDetalle_Reg        : Boolean;

   bRepCajBco          : Boolean;

   bDPart1R            : Boolean;
   bDAPart1R           : Boolean;

   bSpot               : Boolean;
   bForward            : Boolean;
   bDPartS             : Boolean;

   bDecimalesMoneda    : Boolean;
   iNumDecimalesCalculo : Integer;
   iNumDecimalesMoneda : Integer;
   bInformesExtra      : Boolean;
   bRenta_Fija         : Boolean;
   bRenta_Variable     : Boolean;
   bIncluyeAhorros     : Boolean;
   bIncluyeDividendos  : Boolean;
   bIncluyeDerivados   : Boolean;

   bCalculaMarketValueClean           : Boolean;
   bCalcula_Valor_Exposicion          : Boolean;
   bValor_exposicion_es_Market_Limpio : Boolean;
   bCalculaMarketValueDirty           : Boolean;
   bCalculaMarketValueDerivados       : Boolean;
   bMetodo_Amortizacion_IncDec        : Boolean;

   bBuscaDeterioro                    : Boolean;

   bGastos_Estimados        : Boolean;
   sCodigo_Gastos_Estimados : String;
   bAplica_Gastos_Estimados_a_Market_Value : Boolean;

   bGastos_Estimados_por_clasificacion     : Boolean;
   sTipoClasificacionGastosEstimados       : String;
   fIdClasificacion_Gastos_Estimados       : Integer;
   sClasificacionGastosEstimados           : String;

   bConversion_Avanzada                    : Boolean;
   bCierres_Diarios                        : Boolean;
   bCierres_Mensuales                      : Boolean;
   fInicio_Periodo,
   fFin_periodo                            : TDateTime;
   fFecha_Inicio                           : TDateTime;
   bCostoHistoricoFijo                     : Boolean;
   dFechaCostoFijo                         : TDateTime;
   bBook_Value_es_Valor_Libro              : Boolean;
   bBook_Value_es_Valor_Presente           : Boolean;
   bAnula_Devengamiento_INCDEC             : Boolean;

   bConsidera_Indexados_para_Book_Value_es_Valor_Presente : Boolean;

   bAccrued_Interest_por_reverso         : Boolean;

   bUnRea_By_Market_Value                  : Boolean;
   sTipo_Reajuste_en_Book_Value            : String;

   SAmortizacion_Actual_Cost_base              : String;
   SParametro_Amortizacion_Actual_Cost_base    : String; //15-11-2016 F.I.
   sRendimiento_para_titulos_nominales_finales : String;
   bMantiene_concepto_incdec_de_la_cpa         : Boolean;

   sTipo_Gastos_Estimados           : String;
   sDefinicion_Gastos_Estimados     : String;
   sCalculo_Gastos_Estimados        : String;
   fPorcentaje_Gastos_Estimados     : Double;
   fMonto_Gastos_Estimados          : Double;

   sTipo_Gastos_Estimados_ant           : String;
   sDefinicion_Gastos_Estimados_ant     : String;
   sCalculo_Gastos_Estimados_ant        : String;
   fPorcentaje_Gastos_Estimados_ant     : Double;
   fMonto_Gastos_Estimados_ant          : Double;

//   bTC_a_la_Compra                      : Boolean;
   bNO_TC_a_la_Compra                   : Boolean;

// Para Proyeccion de Vctos.
   dFechaCierrePYV   : TDateTime;
   sCarteraPYV       : String;

// Para TSA
   dFechaCierreTSA   : TDateTime;
   sOpcion_Informe,
   sPlanCtaGaap,
   sCarteraTSA       : String;


   dFechaCierre,
   dFechaCierreAnterior,
   dFechaInicioCierreAnterior,
//   dFechaCierreAnteriorAlAnterior,
   dFechaInicioAnterior,
   dFechaDesdeActual       : TDateTime;
   sSistema_ContabGaap,
   sProceso_Programada,
   sTipoProcesoMercado     : String;
   bValorMensual           : Boolean;    //ggarcia 04-11-2015
   bCentralContab,
   bTraspasoContab,
   bGenera_Gaap,
   breporteDirectorio      : Boolean;    //pacuna  11/12/2018


   sClasif_SCDP1,
   sClasif_SCDSBC,
   sClasif_SCDP1AS1,
   sClasif_DP1AS1_CUR,
   sClasif_DP1AS1_PRI,
   sClasif_DP1AS1_PUB,
   sClasif_DP1AS1_PRV,
   sClasif_SCDP1AS2,
   sClasif_DP1AS2_CUR,
   sClasif_DP1AS2_PRI,
   sClasif_DP1AS2_PUB,
   sClasif_DP1AS2_PRV,
   sClasif_Pais,
   sClasif_Contab,
   sTipo_Contab,
   sPlan_Cta                    : String;
   sTipo_Valorizacion           : String;
   sProceso_ValuacionClean      : String;
   sProceso_ValuacionDerivados  : String;
   sProceso_ValorExposicion     : String;
   sProceso_ValuacionDirty      : String;
   sProceso_Amortizacion_IncDec : String;

   sPlan_Cuenta                 : String;

   sTransaccion_aud        : String;

   sClasif_Intermediario,
   sClasif_Moneda          : String;

   bError_Informe          : Boolean;

   sMoneda_Compara         : String;

   sMoneda_en_Informe      : String;
   sMoneda_Iteracion       : String;

   sTipo_de_Conversion        : String;
   sCartera                : String;
   sBaseDatosConsolidacion : String;
   sClasifica_Informe      : String;

   sString_Avance_Informe  : String;

   iMax_Num_Regs           : Integer;
   iNum_Reg                : Integer;

   bCierre                 : Boolean;
   bCierre_VarMem_Cargadas : Boolean;
   sTituloCierre           : String;

   // Reportes Argentina
   sTipo_Titulo            : string;
   iNodo_Titulo            : integer;

   // Libros Contables Brasil
   sFileBrasilInvestment   : String;
   sFileBrasilCompras_CP   : String;
   sFileBrasilCompras_LP   : String;
   sFileBrasilVentas_LP    : String;
   sFileBrasilVentas_CP    : String;
   sFileBrasilVctos_LP     : String;
   sFileBrasilVctos_CP     : String;
   sFileBrasilMayor_LP     : String;
   sFileBrasilMayor_CP     : String;

   // Libros Contables Colombia
   sFileColombiaInver,
   sFileColombiaCompras,
   sFileColombiaVentas,
   sFileColombiaVctos,
   sFileColombiaMayor      : string;

   sFileAutoRetencion,
   sFileAutoRetencionVigentes,
   sFileAutoRetencionVentas,
   sFileAutoRetencionVcto  : string;


   // Libros Contables Ecuador
   sFileEcuadorInver  ,
   sFileEcuadorCompras,
   sFileEcuadorVentas ,
   sFileEcuadorVctos  ,
   sFileEcuadorMayor       : string;

   // Libros Contables Renta Fija Argentina
   sFileArgentinaRentaFija,
   sFile_RF_ArgentinaCompras,
   sFile_RF_ArgentinaVentas ,
   sFile_RF_ArgentinaVctos  ,
   sFile_RF_ArgentinaMayor       : string;

   // Libros Contables Renta Variable Argentina
   sFileArgentinaRentaVari,
   sFile_RV_ArgentinaCompras,
   sFile_RV_ArgentinaVentas ,
   sFile_RV_ArgentinaVctos  ,
   sFile_RV_ArgentinaMayor       : string;

   // Libros Contables México
   sFileMexicoInver,
   sFileMexicoAnalitico,
   sFileMexicoCompras_CP,
   sFileMexicoVentas_CP ,
   sFileMexicoVctos_CP  ,
   sFileMexicoMayor_CP  ,
   sFileMexicoCompras_LP,
   sFileMexicoVentas_LP ,
   sFileMexicoVctos_LP  ,
   sFileMexicoMayor_LP  : string;

   Reg_CodMonto            : TReg_CodMonto;

   Reg_Ipc                 : TReg_Ipc;
   Reg_TasaMorosidadCreditosF251  : TReg_TasaMorosidadCreditosF251;
   Reg_Nominales_Vendidos  : TReg_Nominales_Vendidos;
   Reg_Nominales_Vendidos_Servidor : TReg_Nominales_Vendidos;
   Reg_Redondeo_Monedas    : TReg_Redondeo_Monedas;
   Reg_Haircut             : TReg_Haircut;
   Reg_Tipo_Emisor         : TReg_Tipo_Emisor;
   Reg_Monedas             : TReg_Monedas;
   Reg_Monedas_TRamo       : TReg_Monedas_Tramo;
   Reg_LastMonedas_Tramo   : TReg_Monedas_Tramo;
   Reg_Monedas_Periodo     : TReg_Monedas_Periodo;
   Reg_Tipo_Cambio_Fijo    : TReg_Tipo_Cambio_Fijo;
   Reg_Descriptores        : TReg_Descriptores;
   Reg_Carteras            : TReg_Carteras;
   Reg_Instrumentos_Unicos : TReg_Instrumentos_Unicos;
   Reg_Tasas_Mercado,
   Reg_LastTasas_Mercado   : TReg_Tasas_Mercado;
   Reg_Valores_Tirmra      : TReg_Valores_Tirmra;
   Reg_Valores_Tirmra_2    : TReg_Valores_Tirmra_2;
   Reg_Motivo              : TReg_Motivo;
   Reg_Motivo_OMD          : TReg_Motivo;
   Reg_Spread              : TReg_Spread;
   Reg_Estado              : TReg_Estado;
   Reg_Division_Geografica : TReg_Division_Geografica;
   Reg_Item_Direccion_Identidad : TReg_Item_Direccion_Identidad;
   Reg_Folio_Stock         : TReg_Folio_Stock;
   Reg_Transaccion         : TReg_Transaccion;
   Reg_default_codgen      : TReg_default_codgen;
   Reg_Duration_Fijo       : TReg_Duration_Fijo;
   Reg_Nemotecnicos        : TReg_Nemotecnicos;
   Reg_Nemos_Cupones_Cortados : TReg_Nemos_Cupones_Cortados;
   Reg_Emision_Implicita      : TReg_Emision_Implicita;
   Reg_Nem_Fechas             : TReg_Nem_Fechas;
   Reg_Formulas            : TReg_Formulas;
   Reg_Metodo_Sin_Tasa_Referencia : TReg_Metodo_Sin_Tasa_Referencia;
   Reg_Proyeccion_Precios  : TReg_Proyeccion_Precios;
   Reg_MET_PMARGEN         : TReg_MET_PMARGEN;
   Reg_Met_PRangoCupon     : TReg_Met_PRangoCupon;
   Reg_Excepcion_Cambiaria : TReg_Excepcion_Cambiaria;
   Reg_VarCamb_Operacion   : TReg_VarCamb_Operacion;
   Reg_Excepcion_PROMTAS   : TReg_Excepcion_PROMTAS;
   Reg_Tipo_Empresa        : TReg_Tipo_Empresa;
   Reg_Formula_Aplica_Devengamiento : TReg_Formula_Aplica_Devengamiento;
   Reg_Clasif_Riesgo,
   Reg_Clasif_Riesgo_Nem,
   Reg_Clasif_Riesgo_251   : TReg_Clasif_Riesgo;

   Reg_venta_dif            : TReg_venta_dif;
   Reg_Vtas_Diferida        : TReg_Ventas_Diferida;

   Reg_Clasif_Riesgo_EmpCla : TReg_Clasif_Riesgo_EmpCla;

   Reg_Nivel_Riesgo        : TReg_Nivel_Riesgo;
   Reg_Fin_Desarr          : TReg_Fin_Desarr;
   Reg_Tran_Implic         : TReg_Tran_Implic;
   Reg_Nominales_Pactados,
   Reg_Nominales_Pactados_Mdo : TReg_Nominales_Pactados;
   Reg_Nominales_Pactados_Servidor  : TReg_Nominales_Pactados;
   Reg_UF                  : TReg_UF;
   Reg_Equiv_Instrumento   : TReg_Equiv_Instrumento;
   Reg_Equiv_Moneda        : TReg_Equiv_Moneda;
   Reg_Equiv_Identidad     : TReg_Equiv_Identidad;
   Reg_tasacion            : TReg_tasacion;
   Reg_Folio_Impago        : TReg_Folio_Impago;
   Reg_Folio_Codigo_Externo: TReg_Folio_Codigo_Externo;
   Reg_Identidad_Credencial: TReg_Identidad_Credencial;
   Reg_Proh_Emisor_Nemotecnico : TReg_Proh_Emisor_Nemotecnico;
   Reg_Proh_Folio          : TReg_Proh_Folio;
   wValor_IPC_Calculo      : Double; // Esta variable se debe cargar al llamar a la valorizacion
                             //para que contenga el ipc del mes final del calculo del BR
   sValorizacion_Proceso         : String;
   sValorizacion_Interactiva     : String;
   sBuscar_Tabla_Desarrollo_Pdrx : String;
   sNombre_Tabla_Flujos_Pdrx         : String;
   sNombre_Tabla_Fechas_Nemotec_Pdrx : String;
   Reg_CON_ENL_EMISOR      : TReg_CON_ENL_EMISOR;
   Reg_CON_ENL_IDENTIDAD   : TReg_CON_ENL_IDENTIDAD;
   Reg_CON_ENL_Contraparte : TReg_CON_ENL_Contraparte;
   Reg_CON_ENL_Instrumento : TReg_CON_ENL_Instrumento;
   Reg_CON_ENL_Clasif      : TReg_CON_ENL_Clasif;
   Reg_Clasificacion       : TReg_Clasificacion;

   Reg_Tasa_Conver         : TReg_Tasa_Conver;
   Reg_Metodo_Tasa_Basica  : TReg_Metodo_Tasa_Basica;
   Reg_Flujos_Flot         : TReg_Flujos_Flot;
   Reg_Tratam_Fechas       : TReg_Tratam_Fechas;
   Reg_Monedas_Pais        : TReg_Monedas_Pais;
   Reg_Proy_Precios        : TReg_Proy_Precios;
   Reg_Rango_Tasas         : TReg_Rango_Tasas;
   Reg_Ultimo_Valor_Cambio : TReg_Ultimo_Valor_Cambio;

   Table_Ult_Tasa          : TFDMemTable; // Almacena Valores de Cuando se encontro la tasa Flotante
   Table_FutImplicit       : TFDMemTable; // Tabla para metodo de Futuros Implicitos
   Reg_Dias_Efec_Pago      : TReg_Dias_Efec_Pago;
   fNoUtilizado            : Double;
   Reg_Equivalencia_Instrum : TReg_Equivalencia_Instrum;
   Reg_EquivalenciaSBS     : TReg_Equivalencia;
   Reg_Equivalencia        : TReg_Equivalencia;
   Reg_Folio_Mdo           : TReg_Folio_Mdo;
   Reg_Nro_Riesgo          : TReg_Nro_Riesgo;
   Reg_Permisos            : TReg_Permisos;
   Reg_Carteras_Proceso    : TReg_Carteras_Proceso;
   Reg_Valores_Tasas_Instrumento : TReg_Valores_Tasas_Instrumento;
   Registro_Valores_Tasas  : TRegistro_Valores_Tasas;
   Reg_Dividendos_Imp      : TReg_Dividendos_Imp;
   Reg_Valores_Monedas     : TReg_Valores_Monedas;
   Reg_Datos_Mercado       : TReg_Datos_Mercado;
   Reg_Calce               : TReg_Calce;
   Reg_Clasifica_Var       : TReg_Clasifica_Var;
   Reg_Emisor_Pagador      : TReg_Emisor_Pagador;
   Reg_Emisor_Pagador_Ins  : TReg_Emisor_Pagador_Ins;
   Reg_Custodia            : TReg_Custodia;
   Reg_Movimientos_CtaCte  : TReg_Movimientos_CtaCte;
   Reg_Nemotecnicos_RV     : TReg_Nemotecnicos_RV;
   Reg_Valores_Indices     : TReg_Valores_Indices;
   Registro_RV             : TRegistro_RV;
   Registro_RV_Aho         : TRegistro_RV;
   Registro_Anexo2         : TReg_Anexo2;
   Reg_Ventas_RV           : TOmd_Ventas_RV;
   Reg_Folio_Tesoreria     : TReg_Folio_Tesoreria;
   Reg_Marca_Posicion      : TReg_Marca_Posicion;
   Registro_Procesos       : TRegistro_Procesos;
   Reg_Spread_Emi_Inst     : TReg_Spread_Emi_Inst;
   Reg_Param_proceso       : TReg_Param_proceso;
   Reg_Clasif_EmiInstMot   : TReg_Clasif_EmiInstMot;
   Reg_Default_TipEmp      : TReg_Default_TipEmp;

   Reg_ValCam_Tramo_Interpolacion : TReg_ValCam_Tramo_Interpolacion;
   Reg_Deterioro_Adicional        : TReg_Deterioro_Adicional;

   Array_Mem_Amortizacion_Actual_Cost : TArray_Mem_Amortizacion_Actual_Cost;

   // Globales para Proyeccion de Vencimientos y Nuevo panel de control en la Mesa
   ProVctoFecha_Inicial    : TDateTime;
   ProVctoFecha_Final      : TDateTime;
   ProVctoSwapOForward     : String;
   ProVctoConsolida        : Boolean;
   ProVctoInstrumentos     : Boolean;

   bBusca_Dias_Efectivos_Pago : Boolean;
// Encripta
   Key : Tkey;

// Debug de Errores de asignacion o rebaja de stock
   bDebugStock      : Boolean;


// Para controlar Parametros de gaap
   bTablaParametrosGaap      : Boolean;

// GAAP WEB
   sRespuestaContabilizaGaap        : String;
   sQuienPide                       : String;
   sArchivoErroresGaap              : String;
   sArchivoAvancesGaap              : String;
   sArchivoErroresContabilidadGaap  : String;
   sAplica_Cartera_Web              : String;
   fPid_Web                         : Double;

// TSA y Valorización de Flujos Ajustados
   sTipo_Proceso_TSA                : String;
   sModulo_Llama_TSA                : String;

   fPid                             : Double;
   sPrograma                        : String;
   sEvento                          : string;
   saccion                          : String;
   dfecha_hora                      : TDateTime;
   dfecha_hora_Cierre_Conta         : TDateTime;
   dfecha_hora_Inicio_Programa      : TDateTime;

   Array_Nodo                       : TArray_Nodo;
   Array_Reg_Log                    : TArray_Reg_Log;
   Array_Reg_Mod                    : TArray_Reg_Mod;
   Array_Reg_res                    : TArray_Reg_Res;
   Array_Contab                     : TArray_Contab;

   Edicion    : Boolean;
   fgDiasDesde,
   fgDiasHasta,
   fgValor      : Double;
   sgCod_Moneda,
   sgOrigen,
   sgTipo_Paridad,
   sgMoneda_Paridad: string;
   fgfecha     :TdateTime;
   bCalculo_Tributario    : Boolean;

/// limite transaccional
   bexiste_limite_final   : Boolean;

   sTIPO_VALUACION     : String;
   sORIGEN_PRECIO      : String;
   sCODIGO_CALCULO     : String;
   fBASE_TASA_PRECIO   : Double;
   sMON_IND_PRECIO     : String;

////  variable si existe libreria para generar archivos excel
   bExiste_Dll         : Boolean;
   bunsoloexcel        : Boolean;

implementation

end.
