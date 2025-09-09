unit DM_Variables_Valorizacion;


interface
uses DM_Variables_Menu;

{
const
  Max_Nro_Cupones = 400;           // Maximo de registros posibles
}
type
  // Defino un Registro para ocupar en la Valorización de Stock
  TReg_Stock = Record
              Empresa           : Variant;
              Transaccion       : Variant;
              Folio_Interno     : Variant;
              Item_Omd          : Variant;
              Emisor            : Variant;
              Instrumento       : Variant;
              Serie             : Variant;
              Nemotecnico       : Variant;
              Tipo_Instrum      : Variant;
              Valor_Nominal     : Variant;
              Tasa_Mercado      : Variant;
              Tasa_Emision      : Variant;
              Fecha_Emision     : Variant;
              Fecha_Vencimiento : Variant;
              Moneda_Instrum    : Variant;
              Tipo_Nominales    : Variant;
              Cartera           : Variant;
              Porcen_Valor_Par  : Variant;
              Fecha_Operacion   : Variant;
              End;

 TReg_Errores_Stock = Record
              Error         : Variant;
              Nemotecnico   : Variant;
              Emisor        : Variant;
              Instrumento   : Variant;
              Serie         : Variant;
              end;

  // Definicion de Registro y arreglo unico para tablas de desarrollo en memoria
  TRegArrayMemDesarr = Record
                       Nro_Cupon               : Double;
                       Tipo_Tasa               : String;
                       Tratamiento             : String;
                       Operacion               : String;
                       Factor                  : Double;
                       Interes                 : Double;
                       Amortizacion            : Double;
                       Reajuste_Capital_Pagado : Double;  // Nuevo Filigara  22/03/2005 Peru  Cupones que pagan reajuste de capital cuando no amortizan !!!
                       Valor_Cupon             : Double;
                       Valor_Cupon_Descontado  : Double;
                       Saldo_Insoluto          : Double;
                       Valor_Tasa              : Double;
                       Tasa_Flujo              : Double;
                       Factor_cap              : Double;
                       Capitalizado            : Double;
                       Capitalizado_Cupon      : Double;
                       Fecha_Vcto_Anterior     : TDateTime;
                       Fecha_Vcto              : TDateTime;
                       Dias_Al_Vcto            : Double;
                       Real_Estimado           : String;
                       Tasa_Basica             : Double;
                       Tasa_Riesgo             : Double;
                       Tasa_de_Descuento       : Double;
                       Factor_Descuento        : Double;
                       Valoriza_Con_TDesc      : String;
                       Interes_Original        : Double;
                       Amortizacion_Original   : Double;
                       Valor_Cupon_Original    : Double;
                       Saldo_Insoluto_Original : Double;
                       Fecha_Tasa              : TDateTime;
                       Cupon_Cortado           : Boolean;
                       //Variabled Para Tratamiento de Fecha de Tasa
                       Codigo_Tratam           : String;
                       Cantidad                : Double;
                       Unidad                  : String;
                       Habiles                 : String;
                       Antes_Despues           : String;
                       Referencia              : String;
                       Codigo_Pais             : String;
                       Factor_Varcam           : Double;
                       Cod_Moneda_Ind          : String;
                       Cod_Tratam_Inicio       : String;
                       Cod_Tratam_Termino      : String;
                       Valor_Ind_Inicio        : Double;
                       Valor_Ind_Termino       : Double;
                       Fecha_Inicio            : TDateTime;
                       Fecha_Termino           : TDateTime;
                       Dias_Base_PAR           : Integer;
                       Periodos_Tasa_Base_Variable : Double;
                       Saldo_insoluto_Sin_Capitalizaciones : Double;
                       Fecha_Tipo_Cambio       : TDateTime;
                       // 05-01-2010 F.I.
                       Amortizaciones_Segun_Fecha_de_Compra  : Double;   // Estas variables tienen los valores con respecto al
                       Saldo_Insoluto_Segun_Fecha_de_Compra  : Double;   // Capital residual a la compra. No consideran capitalizaciones
                       Capitalizado_Segun_Fecha_de_Compra    : Double;   // posteriores a ella.

                       // 08-01-2009 F.I.
                       Capitalizado_Entre_Compra_y_Calculo                          : Double;
                       Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo        : Double;
                       Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado  : Double;

                       //13-07-2011 D.C. & F.I.
                       Fecha_Tasa_Flotante     : TDateTime;
                       // 05-02-2015 F.I.
                       Curva_Proy_utilizada	                                    : String;
                       Dias_Proyeccion	                                            : Double;
                       Tasa_Proyeccion	                                            : Double;
                       FD_Proyeccion_fin	                                    : Double;
                       FD_Proyeccion_Inicio	                                    : Double;
                       Valor_Tasa_Descuento                                         : DOuble;
                       Fecha_Liquidacion       : TDateTime;
                       end;

  //Arreglo en memoria de tabla de desarrollo
//  TArray_Mem_Desarr = array[1..Max_Nro_Cupones] of TRegArrayMemDesarr;
  TArray_Mem_Desarr = array of TRegArrayMemDesarr;

////
  // Definicion de Registro y arreglo unico para tablas de desarrollo en memoria

  TArrayMemAmortizacionActualCost = Record
                       Nro_Cupon               : Double;
                       ValorPteCupon           : Double;
                       end;

  //Arreglo en memoria de tabla de desarrollo
  //TArray_Mem_Amortizacion_Actual_Cost = array[1..Max_Nro_Cupones] of TArrayMemAmortizacionActualCost;
  TArray_Mem_Amortizacion_Actual_Cost = array of TArrayMemAmortizacionActualCost;

////


  TReg_descriptor = Record
                    CODIGO_EMISOR      : String;
                    CODIGO_INSTRUMENTO : String;
                    SERIE              : String;
                    FECHA_VIG          : Tdatetime;
                    SERIE_BOLSA        : String;
                    FECHA_EMISION      : Tdatetime;
                    TASA_EMISION       : double;
                    TASA_EFECTIVA      : double;
                    TASA_VALOR_PAR     : String;
                    TASA_VALOR_PTE     : String;
                    UNIDAD_MON         : String;
                    PLAZO_EN_ANOS      : double;
                    TIPO_AMORTIZAC     : String;
                    NRO_CUPONES        : double;
                    PERIODO_PAGO       : double;
                    TIPO_VENCIMIENTO   : String;
                    DIA_VENCIMIENTO    : double;
                    DECIMAL_AJUSTE     : double;
                    TIPO_AJUSTE        : String;
                    BASE_ORIGINAL      : double;
                    BASE_CONVERSION    : double;
                    COD_CALC_PAR_D     : String;
                    COD_CALC_TIR_D     : String;
                    OPCION_PREPAGO     : String;
                    FECHA_PREPAGO      : Tdatetime;
                    PRECIO_PREPAGO     : double;
                    TASA_FLOTANTE      : String;
                    TIPO_NOMINALES     : String;
                    FECHAS_SINO        : String;
                    Tipo_pago          : String;
                    Periodo_Gracia     : Double;
                    Codigo_Emisor_Old      : String;
                    Codigo_Instrumento_Old : String;
                    Serie_Old              : String;
                    COD_CALC_PAR_D_Old     : String; //Para Restablecer formulas de calculo
                    COD_CALC_TIR_D_Old     : String; //que pueden ser modificadas
                    Fecha_Carga_Array_Mem  : TdateTime; // Fecha a la que fuer cargada por ultima vez la tablas de desarrollo
                    Variacion_Cambiaria    : Boolean;
                    fCupones_Cortados      : Double;
                    Dias_Base_Variables    : Boolean;
                    bSin_Tasa_en_Flujos    : Boolean;
                    end;

  TRegistro_Fechas = Record
                     Fecha_Tasa,
                     Fecha_Calculo,
                     Fecha_Emision,
                     Fecha_Compra,
                     Fecha_Inic_Periodo,
                     Fecha_Vcto_Periodo,
                     Fecha_Desde,  // Se utilizan en Variacion cambiaria con fechas fijas
                     Fecha_Hasta,
                     Fecha_Parametro,
                     Fecha_Vencimiento,
                     Fecha_Pago,
                     Fecha_Calculo_Original : TDateTime;
                     end;

  TRegistro_Montos = Record
                     fSaldo,
                     fBase,
                     fIntereses,
	             fCapital,
                     fValor_Cartera   : Double;
                     end;

  TRegistro_TasFlot = Record
                     Nro_Cupon           : Integer;
//                     Array_Mem_Desarr    : TArray_Mem_Desarr;
//                     RegDes              : TReg_descriptor;
                     Codigo_Tasa         : String;
                     Tratamiento         : String;
                     Factor              : Double;
                     Operacion           : String;
                     Real_Estimada       : String;
                     ConCupon            : Boolean;
                     Tasa_Flujo          : Double;
                     Base_TasFlot_Variable : Boolean;
                     end;

  TRegFormulaPAR = record
                     Codigo_Formula     : String;
                     Cod_Utiliza_tasa   : String;
                     Codigo_Tasa        : String;
                     Cod_Utiliza_Precio : String;
                     Tratamiento        : String;
                     Spread_Operacion   : String;
                     Spread_Factor      : Double;
                     Spread_Variable    : String;
                     Valoriza_Acumulado : String;
                     Dias_Habiles       : String;
                     Valoriza_Sobre     : String;
                     Aplica_Factor_Correccion : String;
                     Mon_Ind_Correccion       : String;
                     Fecha_Desde_Corr         : String;
                     Fecha_Hasta_Corr         : String;
                     Aplica_Devengamiento     : String;
                     Tratam_Devengamiento     : String;
                     Aplica_Redondeo_UM       : String;
                     Ajuste_Calculo_Intereses : String;
                   end;

  TRegParamMargen = record
                     Fecha_Aplica_1      : String;
                     Cod_Valor1          : String;
                     Tasa_Base_1         : String;
                     Interpolacion_1     : String;
                     Periodo_Aplica_D_1  : String;
                     Periodo_Aplica_H_1  : String;
                     Aplica_Flujo_1      : String;
                     Fecha_Aplica_2      : String;
                     Cod_Valor2          : String;
                     Tasa_Base_2         : String;
                     Interpolacion_2     : String;
                     Periodo_Aplica_D_2  : String;
                     Periodo_Aplica_H_2  : String;
                     Aplica_Flujo_2      : String;
                     Operacion           : String;
                     Operacion_1         : String;
                     Operacion_2         : String;
                     Redondeo_Truncado   : String;
                     Numero_Decimales    : Double;
                     Constante_1         : Double;
                     Constante_2         : Double;
                     Tasa_Conversion_1   : String;
                     Tasa_Conversion_2   : String;
                     Fecha_Desde         : TDatetime;  // LOBO
                     Fecha_Hasta         : TDatetime;
                     Fecha_Carga         : TDatetime;
                   end;

  TRegParamRangoCupon = record
                           Fecha_Desde : String;
                           Fecha_Hasta : String;
                        end;

  TRegFormulaTIR = record
                     Codigo_Formula     : String;
                     Cod_Utiliza_tasa   : String;
                     Cod_Utiliza_Precio : String;
                     Codigo_Tasa        : String;
                     Tratamiento        : String;
                     Spread_Operacion   : String;
                     Spread_Factor      : Double;
                     Spread_Variable    : String;
                     Valoriza_Acumulado : String;
                     Dias_Habiles       : String;
                     Valoriza_Sobre     : String;
                     Aplica_Factor_Correccion : String;
                     Mon_Ind_Correccion       : String;
                     Fecha_Desde_Corr         : String;
                     Fecha_Hasta_Corr         : String;
                     Aplica_Devengamiento     : String;
                     Tratam_Devengamiento     : String;
                     Aplica_Redondeo_UM       : String

                   end;

  TRegistro_Valoriza_In = record
                          Tipo_Instrumento       : String;
                          sEmisor                : String;
                          sInstrumento           : String;
                          sSerie                 : String;
                          dFecha_Vig             : TDateTime;
                          Nemotecnico            : String;
                          Nemotecnico_Original   : String;
                          dTasaEmision           : Double;
                          sUnidadMonetaria       : String;
                          sTipoNominales         : String;
                          dFechaEmision          : TDateTime;
                          dFechaVencimiento      : TDateTime;
                          dFechaCalculo          : TDateTime;
                          dFechaCalculoOriginal  : TDateTime;
                          dFechaCompra           : TDateTime;
                          dFechaOperacion        : TDateTime;
                          dFechaPago             : TDateTime;
                          sMoneda_Conversion     : String;
                          Con_Cupon              : boolean;
                          Valoriza_Par_Pte       : String;    // PAR - PTE - AMBOS - VAL (Valuacion)
                          Numero_Titulos         : Double;
                          Forzar_Uso_Formula_PAR : String;
                          Formula_PAR            : String;
                          Forzar_Uso_Formula_PTE : String;
                          Formula_PTE            : String;
                          Tabla_Desarr_Cargada   : String;
                          Pais_Titulo            : String;  // Parametros definidos para Metodos de Valuación
                          Motivo_Operacion       : String;  // No afecta si es que no estan cargados
                          Nominales_Compra       : Double;  // Se utilizan solo en la valorización de
                          ValorInvertidoUM_Compra : Double; // Colombia cuando se debe calcular TIR a Fecha de Compra
                          Re_Llamado             : String;
                          Tipo_Proceso           : String;
                          Tasa_Compra            : Double;
                          Spread                 : Double;
                          Descriptor_Cargado     : String;
                          Proceso_Valuacion      : String;  // Se utiliza para diferenciar entre valuacion a Mercado o Mixta
                          Cartera                : String;  // Para identificar valuaciones segun cartera
                          LLamado_por            : String;
                          Tasa_Base_Pacto        : String;
                          Emision_Implicita      : String;
//                          dFechaTasaMercado      : TDateTime;
                          sValor_Cupon_Original  : String;  // Si es 'S' no se afecta por variacion cambiaria
                          sComponentes_Descuento : String;
                          fCupones_Cortados      : Double;
                          bIncluye_CC            : Boolean;
                          Considera_Devengamiento_Formula : String; // Si es 'NO' No usa el metodo definido
                          Modulo_Llamado         : String;
                          Fuerza_Tasa_Cero       : String;
                          Transaccion            : String;
                          Empresa                : String;
                          Folio_Interno          : String;
                          Item_OMD               : Double;
                          Tipo_Cambio            : String;
                          end;

  TRegistro_Valoriza_Out = record
                           Nominales                 : Double;
                           TasaCalculo               : Double;
                           PorcentajePar             : Double;
                           ValorInvertidoUM          : Double;
                           ValorInvertidoMC          : Double;
                           TasaEstimada              : Double;
                           Valor_Par_UM_Sin_Reajuste : Double;
                           Valor_Par_UM              : Double;
                           Valor_Par_MC              : Double;
                           fValor_Final_UM           : Double;
                           Valor_Par_Base            : Double;
                           Array_Mem_Desarr          : TArray_Mem_Desarr;
                           Precio_Titulo             : Double;
                           TIR_Desarr                : Double;
                           RegDes                    : TReg_Descriptor;
                           Tipo_Valuacion            : String;
                           Rate_Used_Valuacion       : Double;
                           Impuestos_Acc             : Double;
                           Precio                    : Double;
                           Nemotecnico               : String;
                           Result_Inst_Vencido       : Boolean;
                           Precio_Limpio             : Double;
                           Precio_Sucio              : Double;
                           Valor_Par_ya_Calculado    : Boolean;
                           Tipo_Tasa_Precio          : String;
                           Tipo_cambio               : Double;
                           FX_Points                 : Double;
                           Tipo_cambio_fwd           : Double;
                           Origen                    : String;
                           Valor_Razonable_Pos_Larga : Double;
                           Valor_Razonable_Pos_Corta : Double;
                           end;

 TReg_Tratam = Record
              Codigo_Tratam : String;
              Cantidad      : Double;
              Unidad        : String;
              Habiles       : String;
              Antes_Despues : String;
              Referencia    : String;
              Codigo_Pais   : String;
              Dia           : Double;
              end;

 TReg_Feriados = Record
               Codigo_Division : Variant;
               Ano_Feriado     : Variant;
               Mes_Feriado     : Variant;
               Dia_Feriado     : Variant;
                 end;

 TReg_Proy_Simple = Record
               Codigo_Tasa     : Variant;
               Fecha_Calculo   : Variant;
               Fecha_Tasa      : Variant;
               Real_Estimada   : Variant;
               Valor_Tasa      : Variant;
                 end;

 TReg_Base_Conversion = Record
               Cod_Tasa_Base   : Variant;
               Tipo            : Variant;
               Periodo_Pago    : Variant;
               Anualidad       : Variant;
               Base_Porcentual : Variant;

               // Variables de Tasa Base
               Dias_Base       : Variant;
               Tipo_interes    : Variant;
               Base_Mensual    : Variant;
               Vigencia_Valor  : Variant;
               Vigencia_Meses  : Variant;
               Tipo_Calculo_Dias : Variant;
               Pais_Tasa       : Variant;
               end;

 TReg_Base_Variable = Record
               Cod_Tasa_Base         : Variant;
               FECHA_DESDE           : Variant;
               FECHA_HASTA           : Variant;
               TIPO_CALCULO_DIAS     : Variant;
               COD_TRATAM_INICIO     : Variant;
               COD_TRATAM_TERMINO    : Variant;
               TASA_DEPENDE_PERIODOS : Variant;
               BASE_SEGUN_ANO        : Variant;
               end;

 TReg_Desagio = Record
               PAIS            : Variant;
               INSTRUMENTO     : Variant;
               EMISOR          : Variant;
               SERIE           : Variant;
               FECHA_DESDE     : Variant;
               FECHA_HASTA     : Variant;
               CODIGO_TASA     : Variant;
               VALOR_TASA      : Variant;
               OPERADOR_LOGICO : Variant;
               end;

TReg_Valuacion = Record
               PROCESO        : Variant;
               CARTERA        : Variant;
               PAIS           : Variant;
               EMISOR         : Variant;
               INSTRUMENTO    : Variant;
               MONEDA_INSTRUM : Variant;
               SERIE          : Variant;
               MOTIVO         : Variant;
               TIPO_VALUAC    : Variant;
               FECHA_DESDE    : Variant;
               FECHA_HASTA    : Variant;
               FORMULA_PTE    : Variant;
               BASE_PRECIO    : Variant;
               MON_IND        : Variant;
               ORIGEN         : Variant;
               TRANSACCION    : Variant;
               TASA_BASE      : Variant;
               CODIGO_FORMULA : Variant;
               end;

TReg_Valuacion_Sup = Record
               PROCESO      : Variant;
               EMPRESA      : Variant;
               CARTERA      : Variant;
               PAIS         : Variant;
               EMISOR       : Variant;
               INSTRUMENTO  : Variant;
               SERIE        : Variant;
               MOTIVO       : Variant;
               VALORIZACION : Variant;
               end;

TReg_Valor_Contable = Record
               EMPRESA          : Variant;
               CARTERA          : Variant;
               TIPO_CONTAB      : Variant;
               TIPO_INSTRUMENTO : Variant;
               MOTIVO_INV       : Variant;
               MOTIVO_OMD       : Variant;
               VALOR_CONTABLE   : Variant;
               end;

TReg_Codigos_Tom     = Record
               Empresa          : Variant;
               Cartera          : Variant;
               plan_cuenta      : Variant;
               cuenta           : Variant;
               columna_proceso  : Variant;
               debe_haber       : Variant;
               codigo_tom       : Variant;
               fecha_desde      : Variant;
               fecha_hasta      : Variant;
               hecho_econ       : Variant;
               End;

TReg_Amortizacion_IncDec = Record
                           PROCESO           : Variant;
                           CARTERA           : Variant;
                           EMISOR            : Variant;
                           INSTRUMENTO       : Variant;
                           SERIE             : Variant;
                           NEMOTECNICO       : Variant;
                           MOTIVO_INVERSION  : Variant;
                           TIPO_AMORTIZACION : Variant;
                           FECHA_DESDE : Variant;
                           FECHA_HASTA : Variant;
                           end;

TReg_Gastos_en_Costo = Record
                           EMPRESA           : Variant;
                           PROCESO           : Variant;
                           CARTERA           : Variant;
                           TIPO_INSTRUMENTO  : Variant;
                           MOTIVO_INVERSION  : Variant;
                           CODIGO_GASTOS     : Variant;
                           FECHA_DESDE : Variant;
                           FECHA_HASTA : Variant;
                           end;

 TReg_IPC     = Record
               Fecha_Paridad     : Variant;
               Valor_Moneda      : Variant;
               end;

 TReg_UF      = Record
               Fecha_Paridad     : Variant;
               Valor_Moneda      : Variant;
               end;

TReg_TasaMorosidadCreditosF251 = record
               Instrumento : Variant;
               Fecha       : Variant;
               Dias_Desde  : Variant;
               Dias_Hasta  : Variant;
               Tasa        : Variant;
               end;

 TReg_Nominales_Vendidos = Record
               Valor_Nominal     : Variant;
               Folio_Interno_Rel : Variant;
               Transaccion_Rel   : Variant;
               Item_Omd_Rel      : Variant;
               Fecha_Operacion   : Variant;
               Fecha_De_Pago     : Variant;
               end;

 TReg_Datos_Mercado = Record
               Cartera          : Variant;
               Folio_Interno    : Variant;
               Transaccion      : Variant;
               Item_Omd         : Variant;
               VALOR_PTE_MC_CPA : Variant;
               VALOR_PTE_MC_MDO : Variant;               
               end;
               
  TReg_Redondeo_Monedas = Record
               Cod_Moneda       : Variant;
               Decimal_Ajuste   : Variant;
               Tipo_Ajuste_Mon  : Variant;
               end;

  TReg_Haircut = Record
               instrumento : Variant;
               nemotecnico : Variant;
               fecha       : Variant;
               valor       : Variant;
               end;

  TReg_Monedas = Record
               COD_MONEDA      : Variant;
               TIPO_DE_PARIDAD : Variant;
               MONEDA_PARIDAD  : Variant;
               FECHA_PARIDAD   : Variant;
               VALOR_MONEDA    : Variant;
               TIPO            : Variant;
               end;

  TReg_Monedas_Tramo = Record
               COD_MONEDA      : Variant;
               ORIGEN          : Variant;
               TIPO_DE_PARIDAD : Variant;
               MONEDA_PARIDAD  : Variant;
               FECHA_PARIDAD   : Variant;
               DIAS_DESDE      : Variant;
               DIAS_HASTA      : Variant;
               VALOR_MONEDA    : Variant;
               end;

  TReg_Monedas_Periodo = Record
               Cod_Moneda        : Variant;
               Unidad_Conversion : Variant;
               Tipo_Moneda       : Variant;
               Tipo_Unidad       : Variant;
               Unidad            : Variant;
               Tipo_Variacion    : Variant;
               Descripcion_Moneda: Variant;
               end;

  TReg_Tipo_Cambio_Fijo = Record
               Mon_Origen  : Variant;
               Mon_Paridad : Variant;
               Fecha       : Variant;
               Tipo_Cambio : Variant;
               end;

  TReg_Descriptores = Record
                    CODIGO_EMISOR      : Variant;
                    CODIGO_INSTRUMENTO : Variant;
                    SERIE              : Variant;
                    FECHA_VIG          : Variant;
                    SERIE_BOLSA        : Variant;
                    FECHA_EMISION      : Variant;
                    TASA_EMISION       : Variant;
                    TASA_EFECTIVA      : Variant;
                    TASA_VALOR_PAR     : Variant;
                    TASA_VALOR_PTE     : Variant;
                    UNIDAD_MON         : Variant;
                    PLAZO_EN_ANOS      : Variant;
                    TIPO_AMORTIZAC     : Variant;
                    NRO_CUPONES        : Variant;
                    PERIODO_PAGO       : Variant;
                    TIPO_VENCIMIENTO   : Variant;
                    DIA_VENCIMIENTO    : Variant;
                    DECIMAL_AJUSTE     : Variant;
                    TIPO_AJUSTE        : Variant;
                    BASE_ORIGINAL      : Variant;
                    BASE_CONVERSION    : Variant;
                    COD_CALC_PAR_D     : Variant;
                    COD_CALC_TIR_D     : Variant;
                    OPCION_PREPAGO     : Variant;
                    FECHA_PREPAGO      : Variant;
                    PRECIO_PREPAGO     : Variant;
                    TASA_FLOTANTE      : Variant;
                    TIPO_NOMINALES     : Variant;
                    FECHAS_SINO        : Variant;
                    Tipo_pago          : Variant;
                    PERIODO_GRACIA     : Variant;
                    CODIGO_EMISOR_Old      : Variant; //OJO
                    CODIGO_INSTRUMENTO_Old : Variant;
                    SERIE_Old              : Variant;
                    end;

  TReg_Carteras = Record
                COD_EMPRESA    : Variant;
                Cod_Cartera    : Variant;
                DESCRIPCION    : Variant;
                TIPO_CARTERA   : Variant;
                GRUPO_CONSOL   : Variant;
                COD_ENT_CLI    : Variant;
                Moneda_Cartera : Variant;
                End;

 TReg_Instrumentos_Unicos = Record
               Cod_instrumento   : Variant;
               SI_NO_DESCRIPTOR  : Variant;
               TIP_TAS_VALOR_PAR : Variant;
               TIP_TAS_VALOR_PTE : Variant;
               COD_CALC_PAR_INS  : Variant;
               COD_CALC_PTE_INS  : Variant;
               Tipo_Instrumento  : Variant;
               Nom_Instrumento   : Variant;
               end;

 TReg_Tasas_Mercado = Record
            Codigo_Nemotecnico : Variant;
            Fecha              : Variant;
            Valor              : Variant;
            Origen             : Variant;
            Tipo               : Variant;
            End;

  TReg_Valores_Tirmra = Record
             Fecha_Calculo : Variant;  
             Dias_Desde  : Variant;
             Dias_Hasta  : Variant;
             Valor       : Variant;
             Origen      : Variant;
             Tipo        : Variant;
             end;

  TReg_Valores_Tirmra_2 = Record
             Fecha_Calculo : Variant;
             Dias_Desde  : Variant;
             Dias_Hasta  : Variant;
             Valor       : Variant;
             Origen      : Variant;
             Tipo        : Variant;
             end;

 TReg_Motivo = Record
               Empresa       : Variant;
               Transaccion   : Variant;
               Folio_Interno : Variant;
               Item_Omd      : Variant;               
               Fecha_Hora    : Variant;
               Fecha_Desde   : Variant;
               Fecha_Hasta   : Variant;
               Cod_Motivo    : Variant;
               end;

 TReg_Spread = Record
               Empresa       : Variant;
               Transaccion   : Variant;
               Folio_Interno : Variant;
               Item_Omd      : Variant;               
               Spread        : Variant;
               end;
               
 TReg_Estado = Record
               Empresa       : Variant;
               Transaccion   : Variant;
               Folio_Interno : Variant;
               Item_Omd      : Variant;               
               Fecha_Hora    : Variant;
               Fecha_Desde   : Variant;
               Fecha_Hasta   : Variant;
               Cod_Estado    : Variant;
               end;

TReg_Division_Geografica = Record
               COD_DESC_DIVISION  : Variant;
               IN__COD_DESC_DIVIS : Variant;
               end;

 TReg_Item_Direccion_Identidad =  Record
               Item_Dir         : Variant;
               Codigo_Identidad : Variant;
               Fecha_Desde      : Variant;
               Fecha_Hasta      : Variant;
               Codigo_Geo       : Variant;
              end;

  TReg_Folio_Stock = Record
               Empresa         : Variant;
               Transaccion     : Variant;
               Folio_Interno   : Variant;
               Item_OMD        : Variant;
               Valor_Nominal   : Variant;
               end;

  TReg_Folio_Mdo = Record
               Empresa          : Variant;
               cartera          : Variant;
               Transaccion      : Variant;
               Folio_Interno    : Variant;
               Item_OMD         : Variant;
               Valor_Nominal    : Variant;
               Valor_Pte_I_Cpa  : Variant;               
               Valor_Pte_I_Mer  : Variant;
               fecha_last_Cierre: Variant;
               end;


 TReg_Transaccion = Record
               Codigo_Transaccion : Variant;
               Relacion           : Variant;
               Codigo_Sistema     : Variant;
               Descripcion        : Variant;
               end;

   TReg_default_codgen = Record
             COD_GENERAL       : Variant;
             CODIGO_IDENTIDAD  : Variant;
             SISTEMA           : Variant;
             TRANSACCION       : Variant;
             COD_DETAIL        : Variant;
             end;

  TReg_Duration_Fijo  = Record
              Cod_Instrumento  : Variant;
              Fecha_Desde      : Variant;
              Fecha_Hasta      : Variant;
              Valor_Duration   : Variant;
              end;

  TReg_Nemotecnicos = Record
               Codigo_Identidad   : Variant;
               Codigo_Instrumento : Variant;
               Serie              : Variant;
               Codigo_Nemotecnico : Variant;
               Cupones_Cortados   : Variant;
               Fecha_Emision      : Variant;
               Fecha_Vencimiento  : Variant;
               Emision_Implicita  : Variant;
               end;

  TReg_Nemos_Cupones_Cortados = Record
               Codigo_Nemotecnico : Variant;
               Cupones_Cortados   : Variant;
               end;

  TReg_Nem_Fechas = Record
               Codigo_Nemotecnico : Variant;
               Cupon              : Variant;
               Fecha              : Variant;
               end;

 TReg_Formulas =  Record
               Par_Pte           : Variant;
               Codigo_Formula    : Variant;
               Cod_Utiliza_tasa  : Variant;
               Codigo_Tasa       : Variant;
               Cod_Utiliza_Precio : Variant;
               Tratamiento       : Variant;
               Spread_Operacion  : Variant;
               Spread_Factor     : Variant;
               Spread_Variable   : Variant;
               Valoriza_Acumulado: Variant;
               Dias_Habiles      : Variant;
               Valoriza_Sobre    : Variant;
               Aplica_Factor_Correccion : Variant;
               Mon_Ind_Correccion       : Variant;
               Fecha_Desde_Corr         : Variant;
               Fecha_Hasta_Corr         : Variant;
               Aplica_Devengamiento     : Variant;
               Tratam_Devengamiento     : Variant;
               Aplica_Redondeo_UM       : Variant;
               Ajuste_Calculo_Intereses : Variant
               end;

  TReg_Metodo_Sin_Tasa_Referencia = Record
             Cod_Formula       : Variant;
             Fecha_Desde       : Variant;
             Fecha_Hasta       : Variant;
             Metodo_Sin_T_Ref  : Variant;
             end;

  TReg_Proyeccion_Precios = Record
       Tipo_Proceso  : Variant;
       Cantidad      : Variant;
       Unidad        : Variant;
       Antes_Despues : Variant;
           end;

  TReg_MET_PMARGEN     = Record
//            Fecha_carga         : Variant;
            Cod_Formula         : Variant;
            Fecha_Aplica_1      : Variant;
            Cod_Valor1          : Variant;
            Tasa_Base_1         : Variant;
            Interpolacion_1     : Variant;
            Periodo_Aplica_D_1  : Variant;
            Periodo_Aplica_H_1  : Variant;
            Aplica_Flujo_1      : Variant;
            Fecha_Aplica_2      : Variant;
            Cod_Valor2          : Variant;
            Tasa_Base_2         : Variant;
            Interpolacion_2     : Variant;
            Periodo_Aplica_D_2  : Variant;
            Periodo_Aplica_H_2  : Variant;
            Aplica_Flujo_2      : Variant;
            Operacion           : Variant;
            Operacion_1         : Variant;
            Operacion_2         : Variant;
            Redondeo_Truncado   : Variant;
            Numero_Decimales    : Variant;
            factor              : Variant;
            Constante_1         : Variant;
            Constante_2         : Variant;
            Tasa_Conversion_1   : Variant;
            Tasa_Conversion_2   : Variant;
            Fecha_Desde         : Variant;  // LOBO
            Fecha_Hasta         : Variant;
            end;

  TReg_Met_PRangoCupon = Record
                            Cod_Formula : Variant;
                            Fecha_Desde : Variant;
                            Fecha_Hasta : Variant;
                         end;

  TReg_Excepcion_Cambiaria  = Record
         Fecha_Calculo           : Variant;
         Codigo_Emisor           : Variant;
         Codigo_Instrumento      : Variant;
         Serie                   : Variant;
         Fecha_Vig               : Variant;
         Cupon_Desde             : Variant;
         Cupon_Hasta             : Variant;
         Fecha_Desde             : Variant;
         Fecha_Hasta             : Variant;
         COD_MONEDA_IND          : Variant;
         Ptje_Aplica_Reajuste    : Variant;
         COD_TRATAM_INICIO       : Variant;
         COD_TRATAM_TERMINO      : Variant;
         Fecha_Inicio_Tratam     : Variant;
         Fecha_Termino_Tratam    : Variant;
         PAGA_REAJUSTE_CAPITAL   : Variant;
         NO_CONSIDERA_EN_INTERES : Variant;
         SOLO_APLICA_EN_VCTOS    : Variant;
         NO_CONSIDERA_NEGATIVOS  : Variant;
         end;

  TReg_VarCamb_Operacion  = Record
         Codigo_Emisor      : Variant;
         Codigo_Instrumento : Variant;
         Serie              : Variant;
         end;

   TReg_Clasif_Riesgo = Record
             COD_EMP_SERIE  : Variant;
             COD_INST_SERIE : Variant;
             SERIE_CLASIF   : Variant;
             NEMOTECNICO    : Variant;
             F_CLASIF_SERIE : Variant;
             CLASIF_SERIE   : Variant;
             ORIGEN         : Variant;
             CLASIF_EMP     : Variant;
             TIPO_CLASIF    : Variant;
             end;

 TReg_Clasif_Riesgo_EmpCla = Record
             COD_EMP_SERIE  : Variant;
             COD_INST_SERIE : Variant;
             SERIE_CLASIF   : Variant;
             F_CLASIF_SERIE : Variant;
             CLASIF_SERIE   : Variant;
             ORIGEN         : Variant;
             CLASIF_EMP     : Variant;
             end;

   TReg_Nivel_Riesgo = Record
             COD_EMP_SERIE  : Variant;
             COD_INST_SERIE : Variant;
             SERIE_CLASIF   : Variant;
             F_CLASIF_SERIE : Variant;
             CLASIF_SERIE   : Variant;
             end;

                    
  TReg_Fin_Desarr = Record
               CODIGO_EMISOR      : Variant;
               CODIGO_INSTRUMENTO : Variant;
               SERIE              : Variant;
               NUMERO_DE_CUPON    : Variant;
               TIPO_AMORTIZ_CUPON : Variant;
               INTERES_CUPON      : Variant;
               AMORTIZ_CUPON      : Variant;
               SALDO_INSOL_CUPON  : Variant;
               end;

   TReg_Tran_Implic =  Record
              Codigo_Transaccion : Variant;
              Implicancia        : Variant;
              end;

 TReg_Nominales_Pactados = Record
               Empresa           : Variant;
               Cartera           : Variant;
               Transaccion_Tes   : Variant;
               Folio_Interno_Tes : Variant;
               Valor_Nominal     : Variant;
               Folio_Interno_Rel : Variant;
               Transaccion_Rel   : Variant;
               Item_Omd_Rel      : Variant;
               Fecha_Operacion   : Variant;
               Fecha_Vcto_Pacto  : Variant;
               Valor_Pactado_UM  : Variant;
               Valor_Pactado_MC  : Variant;
               Transaccion       : Variant;
               Folio_Interno     : Variant;
               Item_Omd          : Variant;
               Moneda_Contrato   : Variant;
               Moneda_Nocional   : Variant;
               Motivo            : Variant;
               Fecha_Tipo_Cambio : Variant;
               end;

 TReg_Equiv_Instrumento = Record
               Codigo_Proceso     : Variant;
               Codigo_Instrumento : Variant;
               Fecha_Desde        : Variant;
               Fecha_Hasta        : Variant;
               Codigo_Equiv       : Variant;
               end;

 TReg_Equiv_Moneda = Record
               Codigo_Proceso     : Variant;
               Codigo_Moneda      : Variant;
               Fecha_Desde        : Variant;
               Fecha_Hasta        : Variant;
               Codigo_Equiv       : Variant;
               end;

 TReg_Equiv_Identidad = Record
               Codigo_Proceso     : Variant;
               Codigo_Identidad   : Variant;
               Fecha_Desde        : Variant;
               Fecha_Hasta        : Variant;
               Codigo_Equiv       : Variant;
               end;

  TReg_tasacion = Record
               Empresa        : Variant;
               Transaccion    : Variant;
               fFolio         : Variant;
               fItem_Omd      : Variant;
               fTasacion      : Variant;
               fecha_Tasacion : Variant;
              end;

  TReg_Folio_Impago = Record
               Empresa         : Variant;
               Transaccion     : Variant;
               fFolio          : Variant;
               fItem_Omd       : Variant;
               fMonto_Impago_UM : Variant;
               fCantidad        : Variant;
              end;
              
  TReg_Folio_Codigo_Externo = Record
               Empresa         : Variant;
               Transaccion     : Variant;
               fFolio          : Variant;
               fItem_Omd       : Variant;
               Codigo_Externo  : Variant;
               Tipo_Deudor     : Variant;
              end;

  TReg_Identidad_Credencial = Record
               Codigo_Identidad: Variant;
               Credencial      : Variant;
              end;

  TReg_Proh_Emisor_Nemotecnico = Record
               Emisor       : Variant;
               Nemotecnico  : Variant;
              end;

  TReg_Proh_Folio = Record
               Empresa         : Variant;
               Cartera         : Variant;               
               Transaccion     : Variant;
               fFolio          : Variant;
               fItem_Omd       : Variant;
              end;

  TReg_CON_ENL_EMISOR =  Record
              Cod_Contabilidad : Variant;
              Proceso          : Variant;
              Tipo_Operacion   : Variant;
              Operacion        : Variant;
              Cartera          : Variant;
              Motivo_Inversion : Variant;
              Emisor           : Variant;
              Instrumento      : Variant;
              Moneda_Instrum   : Variant;
              Fecha_Desde      : Variant;
              Fecha_Hasta      : Variant;
              Hecho_Econ       : Variant;
              end;

  TReg_CON_ENL_IDENTIDAD =  Record
              Cod_Contabilidad : Variant;
              Proceso          : Variant;
              Tipo_Operacion   : Variant;
              Operacion        : Variant;
              Identidad        : Variant;
              Instrumento      : Variant;
              Fecha_Desde      : Variant;
              Fecha_Hasta      : Variant;
              Hecho_Econ       : Variant;
              Cartera          : Variant;
              Motivo_Inversion : Variant;
              end;

  TReg_CON_ENL_Contraparte =  Record
              Cod_Contabilidad : Variant;
              Proceso          : Variant;
              Tipo_Operacion   : Variant;
              Operacion        : Variant;
              Contraparte      : Variant;
              Instrumento      : Variant;
              Fecha_Desde      : Variant;
              Fecha_Hasta      : Variant;
              Hecho_Econ       : Variant;
              Cartera          : Variant;
              Motivo_Inversion : Variant;
              end;

  TReg_CON_ENL_Instrumento =  Record
              Cod_Contabilidad : Variant;
              Proceso          : Variant;
              Tipo_Operacion   : Variant;
              Operacion        : Variant;
              Instrumento      : Variant;
              Fecha_Desde      : Variant;
              Fecha_Hasta      : Variant;
              Hecho_Econ       : Variant;
              Cartera          : Variant;
              Motivo_Inversion : Variant;
              end;

  TReg_CON_ENL_Clasif =  Record
              Cod_Contabilidad : Variant;
              Proceso          : Variant;
              Tipo_Operacion   : Variant;
              Operacion        : Variant;
              Codigo_Clasif    : Variant;
              Nodo             : Variant;
              Elemento         : Variant;
              Fecha_Desde      : Variant;
              Fecha_Hasta      : Variant;
              Hecho_Econ       : Variant;
              Cartera          : Variant;
              Motivo_Inversion : Variant;
              end;

  TReg_Clasificacion = Record
              Codigo_Clasif  : Variant;
              Objeto         : Variant;
              Elemento       : Variant;
              Descripcion    : Variant;
              end;


  TReg_Emision_Implicita = Record
               Codigo_Nemotecnico : Variant;
               Dia                : Variant;
               Dia_Refer          : Variant;
               Dia_Ant_Des        : Variant;
               Mes                : Variant;
               Mes_Refer          : Variant;
               Mes_Ant_Des        : Variant;
               Ano                : Variant;
               Ano_Refer          : Variant;
               Ano_Ant_Des        : Variant;
               end;

 TReg_Tasa_Conver = Record
               Cod_Tasa_Base   : Variant;
               Tipo            : Variant;
               Periodo_Pago    : Variant;
               Anualidad       : Variant;
               Base_Porcentual : Variant;
               end;

 TReg_Metodo_Tasa_Basica = Record
          Cod_Formula   : Variant;
          METODO        : Variant;
          Dias_Promedio : Variant;
          Codigo_Tasa   : Variant;
          Mon_Nac_Ext   : Variant;
          end;

  TReg_Flujos_Flot  = Record
          Emisor      : Variant;
          Instrumento : Variant;
          Serie       : Variant;
          Cupon_Desde : Variant;
          Cupon_Hasta : Variant;
          Tipo_Tasa   : Variant;
          Tratamiento : Variant;
          Operacion   : Variant;
          Factor      : Variant;
          Amortizacion: Variant;
          Factor_Cap  : Variant;
          end;

  TReg_Tratam_Fechas = Record
         sCodigo_Tratam           : Variant;
         fCantidad                : Variant;
         sUnidad                  : Variant;
         sHabiles                 : Variant;
         sAntes_Despues           : Variant;
         sReferencia              : Variant;
         sCodigo_Pais             : Variant;
         fDia                     : Variant;
         sCondicion_Mes_Siguiente : Variant;
         end;

  TReg_Monedas_Pais = Record
         Cod_Moneda    : Variant;
         Nacion_Moneda : Variant;
         end;

  TReg_Proy_Precios = Record
         Tipo_Proceso  : Variant;
         Cantidad      : Variant;
         Unidad        : Variant;
         Antes_Despues : Variant;
         end;

   TReg_Rango_Tasas = Record
         Instrumento  : Variant;
         Nemotecnico  : Variant;
         Valor_Inicial: Variant;
         Valor_Final  : Variant;
         end;

    TReg_Ultimo_Valor_Cambio = Record
         COD_MONEDA    : Variant;
         VALOR_MONEDA  : Variant;
         Fecha_Paridad : Variant;
         end;

    TReg_Dias_Efec_Pago = Record
         Pais_Emision  : Variant;
         Emisor        : Variant;
         Instrumento   : Variant;
         Serie         : Variant;
         Nemotecnico   : Variant;
         Cantidad      : Variant;
         Unidad        : Variant;
         Habiles       : Variant;
         Antes_Despues : Variant;
         Afecta        : Variant;
         end;

     TReg_Equivalencia = Record
         Fecha_Calculo   : Variant;
         Codigo_Proceso  : Variant;
         Codigo_Objeto   : Variant;
         Codigo_Sistema  : Variant;
         Codigo_Equiv    : Variant;
         end;

  TReg_Tipo_Emisor = Record
               Codigo_Identidad : Variant;
               Tipo_Emisor      : Variant;
               Descripcion      : Variant;
               end;

   TReg_Nro_Riesgo = Record
                     Codigo       : Variant;
                     Nro_Riesgo   : Variant;
                     Factor       : Variant;
                     Valor_Riesgo : Variant;
                     Tipo_Plazo   : Variant;
                     Nivel        : Variant;
                     Tipo_Clasif  : Variant;
                     end;

   TReg_Permisos = Record
                   Nombre_programa : Variant;
                   ejecuta_sn      : Variant;
                   inserta_sn      : Variant;
                   elimina_sn      : Variant;
                   modifica_sn     : Variant;
                   end;

TReg_Carteras_Proceso = Record
                   Empresa  : Variant;
                   Cartera  : Variant;
                    end;

TReg_Valores_Tasas_Instrumento = Record
                   Unidad      : Variant;
                   Instrumento : Variant;
                   Dias_Desde  : Variant;
                   Dias_Hasta  : Variant;
                   Valor       : Variant;
                   Origen      : Variant;
                   Tipo        : Variant;
                   end;

TRegistro_Valores_Tasas = Record
                   Fecha : Variant;
                   Cod_Tasa : Variant;
                   Valor : variant;
                  End;

  TParametros = Record
                 sEmpresa                      : String;
                 bCarteras                     : Boolean;
                 bEmisores                     : Boolean;
                 bInstrumentos                 : Boolean;
                 bSerie                        : Boolean;
                 bNemotecnico                  : Boolean;
                 bFolios                       : Boolean;
                 bExcepcion                    : Boolean;
                 fFolio_desde                  : Integer;
                 fFolio_Hasta                  : Integer;
                 sTipo_de_Proceso              : String;  {A    : Automatico, M : Manual}
                 bImpresion_Directa            : Boolean; {False: Preview,   True: Print directo}
                 sCartera                      : String;
                 dFecha_Cierre                 : TDateTime;
                 dFecha_Cierre_Ant             : TDateTime;
                 dFecha_Comparativa            : TDateTime;
                 sContable_Mercado             : String; {'CONTABLE','MERCADO'}
                 bGenera_Stock                 : Boolean;
                 bCalcula_cm_rv                : Boolean;{ Solo para Renta Variable }
                 bSolo_Stock                   : Boolean;
                 sMoneda                       : String;
                 bSolo_Var                     : Boolean;
                 fPeriodo                      : Integer;
                 bCierre_mes                   : Boolean;{indica si es cierre, se está usando en rv }
                 sInstrumento                  : String;
                 bRecalcula_Posicion           : Boolean;
                 sConversion_Moneda_Avanzada   : String;  // SI O NO Conversion avanzada
                 sMoneda_de_Conversion_Externa : String;
                 sTipo_Conversion              : String;
                 sMoneda_Conversion            : String;
                 sValor_Libro_MC               : String; // Si igual a 'S' Valor Libro debe convertirse a la moneda de conversion.
                 Modulo_Llamado                : String;
                 sTipo_Clasificacion           : String;
                 sTipo_Precio_RV_Super         : String; // Utilizado solamente en cuadratura de renta variable.
                 iIncluye                      : Integer;
                end;

   TReg_Tramificacion = Record
                       Codigo_Tramo  : Variant;
                       end;

  TReg_Dividendos_Imp = Record
               Cartera       : Variant;
               Folio_Interno : Variant;
               Transaccion   : Variant;
               Item_Omd      : Variant;
               DIVIDENDO_IMPAGO_UM : Variant;
               DIVIDENDO_IMPAGO_MC : Variant;
               PROVISION_UM        : Variant;
               PROVISION_MC        : Variant;
               VALOR_TASACION_UM   : Variant;
               NRO_DIVIDENDOS_IMP  : Variant;
               FECHA_RETASACION    : Variant;
               FECHA_PRIMER_DIV    : Variant;
              end;

 TReg_Valores_Monedas = Record
                       Codigo_Moneda : Variant;
                       Valor         : Variant;
                       end;

 TReg_Calce = Record
              Codigo_Tramo : Variant;
              Rebalse      : Variant;
              end;
              
 TReg_Clasifica_Var = Record
              INSTRUMENTO   : Variant;
              MONEDA        : Variant;
              EMISOR        : Variant;
              COD_CLASIF    : Variant;
              CLASIFICACION : Variant;
              end;

 TReg_Emisor_Pagador = Record
              Codigo_Identidad   : Variant;
              Emisor_Pagador     : Variant;
              Fecha_Desde        : Variant;
              Codigo_Instrumento : Variant;
              end;

 TReg_Emisor_Pagador_Ins = Record
              Codigo_Instrumento : Variant;
              Codigo_Identidad   : Variant;
              Emisor_Pagador     : Variant;
              end;

  TReg_Custodia = Record
              Empresa           : Variant;
              Transaccion       : Variant;
              Folio_Interno     : Variant;
              Item_Omd          : Variant;
              Custodia          : Variant;
              End;

  TReg_Movimientos_CtaCte = Record
               Empresa          : Variant;
               Transaccion      : Variant;
               Folio_Interno    : Variant;
               Nro_Cupon        : Variant;
               end;

  TReg_Nemotecnicos_RV = Record
               Codigo_Instrumento: Variant;
               Codigo_Nemotecnico: Variant;
               DESCRIPCION       : Variant;
               Codigo_Identidad  : Variant;
               SERIE             : Variant;
               FECHA_DESDE       : Variant;
               SECTOR            : Variant;
               TIPO              : Variant;
               TASA_BASE         : Variant;
               FORMULA           : Variant;
               PAIS              : Variant;
               RUN               : Variant;
               MONEDA            : Variant;
               FECHA_VENCIMIENTO : Variant;
               end;

  TReg_Valores_Indices = Record
               Codigo_Indice     : Variant;
               Moneda_Paridad    : Variant;
               FECHA_PARIDAD     : Variant;
               Valor_Indice      : Variant;
               end;


    TRegistro_RV = Record
              sEmpresa            : Variant;
              sCartera            : Variant;
              sTransaccion        : Variant;
              sFolio_Interno      : Variant;
              fItem_Omd           : Variant;                            
              sInstrumento        : Variant;
              sNemotecnico        : Variant;
              sEmisor             : Variant;
              dFecha_Operacion    : Variant;
              fNominales          : Variant;
              fNominales_Mod      : Variant;
              fSaldo_Nominales    : Variant;
              fCosto_Promedio     : Variant;
              sMoneda_OMD         : Variant;
              fPrecio_Cpa         : Variant;
              fCosto_Compra_UM    : Variant;
              sMoneda_Instrum     : Variant;
              fTipo_de_cambio_OMD : Variant;
              End;

  TReg_Anexo2 = Record
              Empresa              : Variant;
              Cartera              : Variant;
              Transaccion          : Variant;
              Folio_Interno        : Variant;
              Item_Omd             : Variant;
              Emisor               : Variant;
              Instrumento          : Variant;
              Nemotecnico          : Variant;
              Isin_Cusip           : Variant;
              Valor_Final          : Variant;
              Valor_Asignado       : Variant;
              Valor_Nominal        : Variant;
              Clasif_Riesgo        : Variant;
              Empresa_Proceso      : Variant;
              Cartera_Proceso      : Variant;
              Codigo_Objeto_Pasivo : Variant;
              Rubro                : Variant;
              Rubro_txt            : Variant;
              Nodo_Pasivo          : Variant;
              Prioridad            : Variant;
              Seleccionado         : Variant;
              Tipo                 : Variant;
              Ambito               : Variant;
              end;

 TOmd_Ventas_RV = Record
             sEmpresa            : Variant;
             sCartera            : Variant;
             sTransaccion        : Variant;
             sNemotecnico        : Variant;
             sNemotecnico_Actual : Variant;
             sFolio              : Variant;
             fItem_Omd           : Variant;
             dFecha_Operacion    : Variant;
             fNominales          : Variant;
             fCosto_Promedio_UM        : Variant;
             fCosto_Promedio           : Variant;
             fCosto_Promedio_UM_SinRea : Variant;
             fCosto_Promedio_SinRea    : Variant;
             sInstrumento        : Variant;
             sMoneda_OMD         : Variant;
             fTipo_Cambio        : Variant;
             fPrecio_Cpa         : Variant;
             sMoneda_Ins         : Variant;
             sEspecifica_Reajuste : Variant;
             sIndice_Reajuste    : Variant;
             sProceso            : Variant;
             fTipo_Cambio_Original : Variant;
           end;

  TReg_Folio_Tesoreria = Record
             Empresa           : Variant;
             Folio_Interno_Omd : Variant;
             Transaccion_Omd   : Variant;
             fItem_Omd         : Variant;
             NRO_CUPON         : Variant;
             Fecha_Mov         : Variant;
             end;

TReg_Duplicados = Record
             sv_1010411     : Variant;
             sv_codigo_oper : Variant;
             sv_folio_oper  : Variant;
             end;

TReg_VARDuplicados = Record
             var_1010411     : Variant;
             var_cod_ope     : Variant;
             var_folio_ope   : Variant;
             end;

 TReg_Marca_Posicion = Record
               Empresa       : Variant;
               Transaccion   : Variant;
               Folio_Interno : Variant;
               Item_Omd      : Variant;
               Fecha_Hora    : Variant;
               Fecha_Desde   : Variant;
               Fecha_Hasta   : Variant;
               Cod_Marca     : Variant;
               end;

  TReg_ValCam_Tramo_Interpolacion  = Record
               Codigo   : Variant;
               Valor    : Variant;
               Desde    : Variant;
               Hasta    : Variant;
               end;

  TReg_Deterioro_Adicional = Record
               Fecha_Desde   : Variant;
               Fecha_Hasta   : Variant;
               Nemotecnico   : Variant;
               Base          : Variant;
               Porcentaje    : Variant;
               end;

  TRegistro_Procesos  = Record
             Proceso_Valuacion : Variant;
             end;

  TReg_Spread_Emi_Inst = Record
             Emisor      : Variant;
             Instrumento : Variant;
             Operacion   : Variant;
             Spread      : Variant;
             end;

  TReg_Param_proceso = Record
             Proceso   : Variant;
             Parametro : Variant;
             Valor     : Variant;
             end;

  TReg_Ahorros = Record
                    NEMOTECNICO             : String;
                    FECHA_DESDE             : TDateTime;
                    FECHA_HASTA             : TDateTime;
                    DESCRIPCION             : String;
                    EMISOR                  : String;
                    INSTRUMENTO             : String;
                    SERIE                   : String;
                    MONEDA                  : String;

{
                    VALORIZA_POR_TASA       : String;
                    CODIGO_TASA             : String;

                    TRATAMIENTO_TASA        : String;
                    OPERACION_TASA          : String;
                    FACTOR_TASA             : Double;
                    VALORIZA_SOBRE_TASA     : String;

                    VALORIZA_POR_PRECIO     : String;
                    DIAS_PRECIO             : Double;
                    DIAS_HABIL_PRECIO       : String;
                    ANTES_DESPUES_PRECIO    : String;
                    BASE_PRECIO             : Double;
                    MONEDA_PRECIO           : String;
}

                    VALORIZA_POR_TASA       : String;
                    CODIGO_TASA             : String;
                    VALORIZA_POR_PRECIO     : String;
                    BASE_PRECIO             : Double;
                    MONEDA_PRECIO           : String;

                    TRATAMIENTO             : String;
                    OPERACION               : String;
                    FACTOR                  : Double;
                    VALORIZA_SOBRE          : String;


                    PERIODO_DEFCAP          : String;
                    TIPO_VCTO_DEFCAP        : String;
                    DIA_DEFCAP              : Double;
                    DIAS_HABIL_DEFCAP       : String;
                    ANTES_DESPUES_DEFCAP    : String;

                    CAPITALIZA_PAGA_CAPEFE  : String;
                    DIAS_CAPEFE             : Double;
                    ANTES_DESPUES_CAPEFE    : String;
                    DIAS_HABIL_CAPEFE       : String;

                    APORTE_DEVENGA          : String;
                    RETIRO_DEVENGA          : String;

                    PAGA_INTERES_EN_VENTA   : String;

                    end;

  TReg_Excepcion_PROMTAS  = Record
         Fecha_Calculo      : Variant;
         Codigo_Emisor      : Variant;
         Codigo_Instrumento : Variant;
         Serie              : Variant;
         Cupon_Desde        : Variant;
         Cupon_Hasta        : Variant;
         Fecha_Desde        : Variant;
         Fecha_Hasta        : Variant;
         COD_TRATAM_INICIO  : Variant;
         COD_TRATAM_TERMINO   : Variant;
         Fecha_Inicio_Tratam  : Variant;
         Fecha_Termino_Tratam : Variant;
         end;

  TReg_Tipo_Empresa  = Record
         Codigo_Identidad  : Variant;
         TIPO_EMPRESA      : Variant;
         end;


  TReg_Formula_Aplica_Devengamiento = Record
                                      sFormula               : Variant;
                                      sAplica_Devengamiento  : Variant;
                                      sTratam_Devengamiento  : Variant;
                                      end;

  TReg_Equivalencia_Instrum = Record
                              Fecha_Calculo   : Variant;
                              PROCESO         : Variant;
                              INSTRUMENTO     : Variant;
                              TIPO_EMISOR     : Variant;
                              PAIS_EMISOR     : Variant;
                              EMISOR          : Variant;
                              SERIE           : Variant;
                              CODIGO_EQUIV    : Variant;
                              end;

  TReg_Formula_Tasas = Record
                       Cod_Moneda      : Variant;
                       Fecha_Desde     : Variant;
                       Cod_Formula     : Variant;
                       end;

  TReg_venta_dif = Record
                  Transaccion  : Variant;
                  Fecha_Desde  : Variant;
                  Motivo_Inver : Variant;
                  Motivo_OMD   : Variant;
                  Empresa      : Variant;
              end;

  TReg_Ventas_Diferida = Record
                 Fecha_de_cierre       : Variant;
                 Fecha_cierre_anterior : Variant;
                 Fecha_Inicio_anterior : Variant;
                 Tipo_conversion       : Variant;
                 Moneda_conversion     : Variant;
                 Empresa               : Variant;
                 Cartera               : Variant;
                 Contraparte           : Variant;
                 Fecha_Operacion       : Variant;
                 Transaccion           : Variant;
                 Folio_interno         : Variant;
                 item_omd              : Variant;
                 Emisor                : Variant;
                 Instrumento           : Variant;
                 Nemotecnico           : Variant;
                 Moneda_Instrum        : Variant;
                 Custodia_Destino      : Variant;
                 Motivo_OMD            : Variant;
                 Motivo_Inversion      : Variant;
                 Transaccion_rel       : Variant;
                 Folio_interno_rel     : Variant;
                 Item_Omd_rel          : Variant;
                 Dias_Al_Vcto          : Variant;
                 Fecha_Compra          : Variant;
                 Fecha_Vencimiento     : Variant;
                 Profit_Book_Value     : Variant;
                 Profit_Actual_Cost    : Variant;
                 Loss_Actual_Cost      : Variant;
                 Inc_Dec_Total_SinRea  : Variant;   
                 Fecha_hora            : Variant;
              end;

  TReg_Clasif_EmiInstMot =  Record
                            EMISOR           : Variant;
                            INSTRUMENTO      : Variant;
                            MOTIVO           : Variant;
                            FECHA_DESDE      : Variant;
                            CODIGO_CLASIF    : Variant;
                            CLASIFICACION    : Variant;
                            CLASIFICACION_CP : Variant;
                            DESC_CLASIFICACION    : Variant;
                            DESC_CLASIFICACION_CP : Variant;
                            end;

  TReg_Default_TipEmp =  Record
                         Codigo_Identidad : Variant;
                         Item_dir         : Variant;
                         Tipo_Empresa     : Variant;
                         Empresa          : Variant;
                         end;

  TReg_Prob_Deterioro_Nemo = Record
                             Nemotecnico    : Variant;
                             Prob_Deterioro : Variant;
                             End;

  TReg_Prob_Recupero_Nemo = Record
                             Nemotecnico    : Variant;
                             Prob_Recupero  : Variant;
                             End;

  TReg_Prob_Deterioro_Clasif_Riesgo = Record
                                      Nacionalidad   : Variant;
                                      Clasif_Riesgo  : Variant;
                                      Prob_Deterioro : Variant;
                                      End;

  TReg_Recupero_Instrum = Record
                          Instrumento : Variant;
                          Recupero    : Variant;
                          End;

  TReg_Deterioro_Cl_Riesgo = Record
                             Fecha         : Variant;
                             Clasif_Riesgo : Variant;
                             Stage_1_PD    : Variant;
                             Stage_2_PD    : Variant;
                             Long_Term_PD  : Variant;
                             End;

  TReg_Notching_Table = Record
                        Fecha             : Variant;
                        Clasif_Riesgo     : Variant;
                        Notch             : Variant;
                        Desde             : Variant;
                        Hasta             : Variant;
                        Trigger_Threshold : Variant;
                        End;

  TReg_Loss_Given_Default = Record
                            Fecha         : Variant;
                            Clasif_Riesgo : Variant;
                            Nodo          : Variant;
                            LGD           : Variant;
                            End;

  implementation


end.
