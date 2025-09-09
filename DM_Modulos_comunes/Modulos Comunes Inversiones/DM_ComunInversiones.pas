unit DM_ComunInversiones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DM_Variables_Valorizacion,DM_Global_Var,Variants, DateUtils,
  DM_FuncionesMemory, DM_Variables_Menu, IniFiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.VCLUI.Error, FireDAC.Comp.UI, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteVDataSet;

type

  TInterpolacion = Record
                   Nro_Cupon        : Double;
                   Limite_Inf       : Double;
                   Limite_Sup       : Double;
                   Tasa_Interpolada : Double;
                   end;

  TdmComunInversiones = class(TDataModule)
    QRY_General: TFDQuery;
    Qry_Varios: TFDQuery;
    Qry_Aux: TFDQuery;
    QRY_Unidad_Formulas: TFDQuery;
    Qry_Ventas: TFDQuery;
    Qry_Tesoreria: TFDQuery;
    Qry_Paradox: TFDQuery;
    Qry_Paradox2: TFDQuery;
    FDLocalSQL1: TFDLocalSQL;
    Tbl_Excedido: TFDMemTable;
    Qry_Clasif_Nodo: TFDQuery;
    Qry_ProvImp: TFDQuery;
    Qry_Div_Impagos: TFDQuery;
    Qry_Nem_Fechas: TFDQuery;
    Qry_Cupones_Impagos: TFDQuery;
    Qry_Numero_Titulos: TFDQuery;
    Qry_Determina_Titulos_Vendidos: TFDQuery;
    Qry_Prov_B2: TFDQuery;
    Qry_PE: TFDQuery;
    Qry_Emisor_Pagador: TFDQuery;
    QRY_TasBraiz: TFDQuery;
    Qry_Existe_Folio: TFDQuery;
    Qry_Tasa_Proyeccion_Simple_Anual: TFDQuery;
    Qry_Tasa_Proyeccion_Simple_NoAnual: TFDQuery;
    Qry_QS_FIN_TASA_MERCAD_2: TFDQuery;
    Qry_QS_FIN_TASA_MERCAD: TFDQuery;
    Qry_QS_FIN_TASA_MERCAD_SIN_ORIGEN: TFDQuery;
    QRY_TasBraiz_Cleas: TFDQuery;
    Qry_Param_Empresa: TFDQuery;
    Qry_Nom_Instrum: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  TExValorNoExiste = class(exception);

procedure Valor_Mercado_RV( sEmpresa
                           ,sCartera
                           ,sNemotecnico      : String;
                            dFecha_Cierre     : Tdatetime;
                        var fValor_Mercado_MC : Double;
                        var bResult           : Boolean
                          );

Procedure Leer_PROV_VOLUNTARIA_B2( sProceso,
                                   sEmpresa ,
                                   sCartera,
                                   sNemotecnico          : String;
                                   dFecha_Proceso        : TDatetime;
                                   sMoneda_Conversion    : string;
                                   var fValor            : Double;
                                   var sModelo_Propio    : String;
                                   var bResult           : Boolean
                                   );

  procedure Determina_FechaPrepago_Pacto( sEmpresa
                                       ,sTransaccion
                                       ,sFolio_Interno : String;
                                    var dFecha_Prepago : Tdatetime;
                                    var bResult         : Boolean
                                       );

procedure Nominales_Mercado_RV( sEmpresa
                               ,sCartera
                               ,sNemotecnico : String;
                            dFecha_Cierre    : Tdatetime;
                        var fNominales       : Double;
                        var bResult          : Boolean
                          );

procedure Nominales_Mercado_RF( sEmpresa
                               ,sCartera
                               ,sTransaccion
                               ,sFolio_Interno   : String;
                                fItem_Omd        : Double;
                                dFecha_Cierre    : Tdatetime;
                           var fNominales        : Double;
                           var bResult           : Boolean
                           );

Function  Vencimientos_Al_Dia(dFecha_Desde:TdateTime;Array_Mem_Desarr : TArray_Mem_Desarr):Boolean;

Function  Existe_Folio_Item_Venta_Pendiente( sEmpresa ,
                                             sTransaccion,
                                             sFolio_Interno  : String
                                           ) : Boolean;

function Existe_Moneda_Indice(sMoneda_Indice : String) : Boolean;

function Existe_Nemotecnico_RF(sNemotecnico : String) : Boolean;

function Existe_Gastos_en_Costos(sEmpresa : String) : Boolean;

Function  Existe_Folio_Item_Compra( sEmpresa ,
                                    sTransaccion,
                                    sFolio_Interno  : String;
                                    fItem_omd       : Double
                                   ) : Boolean;
Function  Existe_Folio_Item_Instrum( sEmpresa ,
                                    sTransaccion,
                                    sFolio_Interno  : String;
                                    fItem_omd       : Double;
                                var sInstrumento    : String
                                   ) : Boolean;
Procedure Leer_PROV_IMPAIRMENT( sProceso,
                                sEmpresa ,
                                sTransaccion,
                                sFolio_Interno          : String;
                                fItem_omd               : Double;
                                dFecha_Proceso          : TDatetime;
                                sMoneda_Conversion      : String;
                                var fValor              : Double;
                                var sModelo_Propio      : String;
                                var fDeterioro_Unitario : Double;
                                var sTipo_Carga         : String;
                                var bResult             : Boolean
                                );

Procedure Determina_Monto_Pasivos( sEmpresa
                                  ,sCartera
                                  ,sCodigo_Objeto : String;
                                   dFecha_Cierre  : TDatetime;
                                   fNodo          : Double;
                               var fMonto : Double
                                  );

Procedure Determina_Monto_Pasivos_11052(sEmpresa       : String;
                                        sCartera       : String;
                                        sCodigo_Objeto : String;
                                        dFecha_Cierre  : TDatetime;
                                        fNodo          : Double;
                                        sLista         : String;
                                    var fMonto         : Double;
                                    var fMonto_Activo  : Double);

procedure lee_proy_Fecha_Tope(  sTipo_Proceso  : String;
                                dFecha_Calculo : TDateTime;
                            var dFecha_Tope    : TDateTime;
                            var sAntes_Despues : String;
                            var Result         : Boolean
                             );

procedure Valor_Mercado(  sEmpresa
                         ,sCartera
                         ,sTransaccion
                         ,sFolio_Interno   : String;
                          fItem_Omd        : Double;
                          dFecha_Cierre    : Tdatetime;
                     var fValor_nominal    : Double;
                     var fValor_Pte_UM_MDO : Double;
                     var fValor_Pte_MC_MDO : Double;
                     var bResult           : Boolean
                     );

procedure Valor_Presente(sEmpresa
                        ,sCartera
                        ,sTransaccion
                        ,sFolio_Interno   : String;
                         fItem_Omd        : Double;
                         dFecha_Cierre    : Tdatetime;
                     var fValor_nominal    : Double;
                     var fValor_Pte_UM_Cpa : Double;
                     var fValor_Pte_MC_Cpa : Double;
                     var fPrecio_Cpa       : Double;
                     var bResult           : Boolean
                         );

procedure Valor_Interfaz_SUN_ACCOUNT(  sEmpresa
                                      ,sObjeto_Cuenta : String;
                                       fNodo_Cuenta   : Double;
                                       dFecha_Cierre  : Tdatetime;
                                       sColumna       : String;
                                  var sValor_Columna  : String
                                  );
  
procedure Porcentaje_Emisor_Holding(   sEmpresa
                                      ,sEmisor       : String;
                                       dFecha_Cierre : Tdatetime;
                                  var fPorcentaje    : Double;
                                  var bResult        : Boolean
                                  );
  
procedure Valor_Limite_Rubro(  sString_Empresas
                              ,sString_Carteras
                              ,sTipo_Limite
                              ,sRubro
                              ,sEmisor
                              ,sProceso      : String;
                              dFecha_Proceso : Tdatetime;
                          var fValor_Limite  : Double
                            );
  
procedure Valor_Limite_Emisor_Rubro(  sString_Empresas
                                     ,sString_Carteras
                                     ,sTipo_Limite
                                     ,sRubro
                                     ,sEmisor
                                     ,sProceso      : String;
                                     dFecha_Proceso : Tdatetime;
                                 var fValor_Limite  : Double
                                   );
//{         // Descomentado por E.S. 24-10-2012, para ser utilizado en B3, Circular 1835, 2078
Procedure Motivo_Nemotecnico_RV( sEmpresa,
                                 sCartera,
                                 sTransaccion  : String;
                                 dFecha_Cierre : TDatetime;
                                 sNemotecnico  : String;
                            var  sMotivo       : String;
                            var  Result        : Boolean
                               );
//}
Function Stock_Parcial_Cartera( sEmpresa,
                                sCartera      : String;
                                dFecha_Stock  : TDatetime
                              ) : Boolean;
  
function lee_tasa_mercado_a_Fecha( sNemotecnico     : String;
                                   sTipo_Instrum    : String;
                                   dFecha           : TDateTime;
                                   var sOrigen      : String) : Double;

Procedure Graba_Empresas_param_proceso( sCod_Proceso  : String;
                                        sParametro    : String
                                      );
  
procedure Leer_Nombre_Instrumento(sInstrumento  : String;
                              var sDescripcion  : String;
                              var Result        : Boolean
                                 );

function QueryToStringList(Qry:TFDQuery):TStringList;

function Nodos_Hijos(Objeto:String; Nodo_Padre:Double) :String;

function Nodo_Padre(Objeto:String; Nodo_Hijo:Double) :String;

procedure Busca_Hijos(Objeto:String;Nodo_Padre:Double);

procedure  Elemento_Clasif_Padre(   sObjeto        : String;
                                var fNodo_Elemento : Double;
                                var Result         : Boolean
                               );
Function Elemento_Clasificado( sObjeto             : String;
                               fNodo_Padre_Buscado : Double;
                               fNodo_Elemento      : Double
                              ) : Boolean;

Procedure Leer_Medio_Contacto( sCODIGO_IDENTIDAD : String;
                               fITEM_DIR         : Double;
                               fITEM_Contacto    : Double;
                               dFecha            : TDatetime;
                               sMedio            : String;
                              var sDescripcion_Medio     : String
                              );

Procedure Leer_Medio_Identidad( sCODIGO_IDENTIDAD : String;
                                fITEM_DIR         : Double;
                                dFecha            : TDatetime;
                                sMedio            : String;
                            var sDescripcion_Medio     : String
                              );

Procedure Leer_Contacto(sCODIGO_IDENTIDAD : String;
                        fITEM_DIR         : Double;
                        dFecha            : TDatetime;
                        sTipo_Contacto    : String;
                        fItem             : Double;
                        var sContacto     : String;
                        var fItem_Contacto: Double;
                        var sCargo        : String
                        );

Procedure Leer_Contacto_Cargo( sCODIGO_IDENTIDAD : String;
                               fITEM_DIR         : Double;
                               dFecha            : TDatetime;
                               sTipo_Contacto    : String;
                               sCargo            : String;
                               var sContacto     : String;
                               var fItem_Contacto: Double
                               );


Function Custodia_Actual(  sEmpresa,
                           sTransaccion,
                           sFolio_Interno : String;
                           fItem_Omd      : Double;
                           dFecha_Proceso : TDatetime
                         ) : String ;

function Es_Nemotecnico_Br(sNemotecnico: String): Boolean;

Function Leer_Tasa_Instrumento(sInstrumento : String;
                               dFechaCalculo,
                               dFechaVencimiento : TDatetime;
                               sOrigen : String;
                           var sTipo_TasPre : String
                               ) : Double;

procedure  Codigo_Identidad ( sRut              : String;
                          VAR sCodigo_Identidad : String
                             );

Procedure Busca_Cod_Sistema_Equiv( sCodigo_Proceso,
                                   sCodigo_Objeto,
                                   sEquivalencia : String;
                                   dFecha  : TDatetime;
                               Var sCodigo_Sistema : String
                                 );

procedure Tipo_Instrumento_RTPR(   sInstrumento : String;
                               var sCodigo_RTPR : String;
                               var Result       : Boolean
                               );

procedure Tipo_Emisor(sEmisor  : String;
                      dFecha   : TDateTime;
                  var sTipo_Emisor : String;
                  var Result       : Boolean
                      );

Function Lee_Emisor_Inst(sEmisor      : String;
                         sInstrumento : String;
                         dFecha       : TDateTime): Boolean;

function Participacion_Extranjera(sNemotecnico :String;
                                  dFecha       :TDateTime) :Boolean;

Function Busca_Prohibicion_Folios( const sEmpresa    : String;
                                   const sCartera     : String;
                                   const sTransaccion : String;
                                   const sFolio       : String;
                                   fItem_Omd          : Double;
                                   dFecha : TDatetime) : Boolean;

Function Busca_Prohibicion_Emisor_Nemotecnico(const sEmisor      :  String;
                                              const sNemotecnico : String ;
                                              dFecha : TDatetime ) : Boolean;

Function Determina_Cartera_Pid( sEmpresa_Usuario : String;
                                  fPid             : Double
                                 ) : String;

Function Existe_en_TSA(dFecha_TSA     : TDatetime;
                       sEmpresa,
                       sTransaccion,
                       sFolio_Interno : String;
                       fItem_Omd      : Double;
                       sNemotecnico   : String;
                       bProc_TSA      : Boolean;
                       sProceso_TSA   : String
                       ) : Boolean;

Function Existe_Rol_TSA(  dFecha_TSA     : TDatetime;
                          sEmpresa,
                          sRol           : String   ) : Boolean;
                       
Function Determina_Descripcion_nodo( sObjeto,
                                     sElemento,
                                     sCodigo_Clasif : String;
                                     var sDescripcion_Nodo  : String
                                     ) : Boolean;

procedure  Valores_Identidad ( sIdentidad     : String;
                           VAR fRut           : Double;
                           VAR sDigito        : String;
                           VAR sRazon_social  : String;
                           VAR Result         : Boolean
                             );

procedure  Valores_Identidad_2(sIdentidad    : String;
                           VAR sCredencial   : String;
                           VAR sRazon_social : String;
                           VAR Result        : Boolean);


  procedure Busca_Valor_Div_Impagos( sEmpresa,
                                   sCARTERA,
                                   sTransaccion,
                                   sFolio_Interno : String;
                                   fItem_Omd      : Double;
                                   dFECHA         : TDatetime;
                               Var fMonto_Impago_UM : Double;
                               Var fMonto_Impago_MC : Double;
                               Var fProvision_UM    : Double;
                               Var fProvision_MC    : Double;
                               Var fValor_Retasacion   : Double;
                               Var fNro_Cuotas_Impagas : Double;
                               Var dFecha_Retasacion : Tdatetime;
                               Var dFecha_Primer_Dividendo : Tdatetime;
                               //ggarcia 01-04-2015
                               var fSaldo_Insoluto          : Double;
                               var fRelacion_Deuda_Garantia : Double;
                               var fMorosidad_Dias          : Double;
                               var fDeuda_Vigente           : Double;
                               var fPorcentaje_Prepago      : Double
                                   );

 procedure Busca_Valor_Super( sPROCESO,
                             sEmpresa,
                             sCARTERA,
                             sPAIS,
                             sEMISOR,
                             sINSTRUMENTO,
                             sMOTIVO        : String;
                             dFECHA_DESDE   : TDatetime;
                           Var sVALORIZACION : String
                             );

 Procedure Emisor_Pagador( Var sEmisor_Origen  : String;
                      var sEmisor_Pagador : String;
                          dFecha : TDatetime;
                      var Result : Boolean
                         );

  Procedure  Determina_Valor_Pacto( sOwner : String;
                              Var fValorInvertidoUM_Cpa : Double;
                                  sMoneda_Instrum,
                                  sMoneda_Pacto      : String;
                                  dFecha_Operacion   : TDatetime;
                                  sMoneda_Conversion : String;
                              var sModulo_Error   : String;
                              var sString_Error   : String;
                              var Result          : Boolean
                                  );
  

  procedure Busca_Datos_Clasif_Riesgo(const sCodigo : String;
                                     var Nro_Riesgo    : Double;
                                     var Factor        : Double;
                                     var sTipo_Plazo   : String;
                                     var fValor_Riesgo : Double;
                                     var fNivel        : Double;
                                     var sModulo_Error : String;
                                     var sString_Error : String;
                                     var Result        : Boolean
                                     );

Function Activo_En_Margen(  sEmpresa,
                            sCartera : String;
                            dFecha_Proceso : TDatetime;
                            sTransaccion,
                            sFolio_Interno : String;
                            fItem_Omd      : Double
                          ) : Boolean;

Function Verifica_Pago_Omd( sEmpresa_Usuario
                           ,sCartera
                           ,sTransaccion
                           ,sFolio_Interno : String;
                            fItem_Omd
                           ,fNro_Cupon     : Double;
                            dFecha          : Tdatetime
                           ) : Boolean;

 Procedure Busca_Equivalencia( sCodigo_Proceso,
                              sCodigo_Objeto,
                              sCodigo_Sistema : String;
                              dFecha  : TDatetime;
                              Var sEquivalencia : String
                             );
  

 Function Emisores_Relacionado_Cia( sEmpresa
                                  ,sEmisor : String;
                                  dFecha  : TDatetime
                                  ) : Boolean;

  Procedure Determina_Nodo_Clasificacion( sObjeto,
                                          sElemento,
                                          sCodigo_Clasif  : String;
                                      var fNodo_Clasif : Double
                                        );

  Procedure Busca_QS_NODO_Clasificacion( sCodigo_Objeto   : String;
                                         fNodo            : Double;
                                         var fQS_Nodo     : Double
                                        );

  Function Busca_NODO_Clasificacion(sCodigo_Objeto : String;
                                     sValor_Buscado : String) :Double;

  Function Determina_Objeto_Clasificado( sEmpresa,
                                       sObjeto,
                                       sElemento,
                                       sCodigo_Clasif  : String;
                                       fNodo : Double;
                                       bConsidera_Nodo : Boolean) : Boolean;
  
  Procedure Busca_Descripcion_Clasificacion_Padre( sCodigo_Objeto  : String;
                                                  fNodo            : Double;
                                                  fQS_Nodo         : Double;
                                                  var sDescripcion : String
                                                  );

  Function Nro_Riesgo( sCodigo_Clasif : String ) : Double;
  function suma_lapso(dfecha_inicial : tdatetime;
                      wperiodo_pago,
                      wdia_pago      : word): tdatetime;
  {
  procedure Suma_dias(dFecha_Inicio     : TDateTime;
                      fDias             : Integer;
                      fBase_Mensual     : Integer;
                      var dFecha_Result : TDateTime);
  }
  function Existe_Emision_Implicita(sNemotecnico : String) : String;

  function Carga_Reg_Descriptor(sEmisor,
                                sInstrumento,
                                sSerie : String) : boolean;

  function Carga_Reg_Descriptor_Vig(sEmisor,
                                    sInstrumento,
                                    sSerie : String;
                                    dFecha_vig : TDatetime) : boolean;

  function siguiente_periodo(sNemotecnico       : String;
                             sTipo_vencimiento : String;
                             iNro_Cupon        : Integer;
                             wDia_Vencimiento  : word;
                             wPeriodo_Pago     : word;
                             sTasa_Flotante    : String;
                             dfecha : TDatetime) : boolean;

  procedure Proximo_vencimiento(sNemotecnico      : String;
                                sTipo_vencimiento : String;
                                iNro_Cupon        : Integer;
                                wDia_Vencimiento  : word;
                                wPeriodo_Pago     : word;
                                sTasa_Flotante    : String;
                            var dfecha            : TDatetime;
                            var Result            : boolean);

  procedure Proximo_vencimiento_Vig(sNemotecnico      : String;
                                    dfecha_Vig        : TDatetime;
                                    sTipo_vencimiento : String;
                                    iNro_Cupon        : Integer;
                                    wDia_Vencimiento  : word;
                                    wPeriodo_Pago     : word;
                                    sTasa_Flotante    : String;
                                var dfecha            : TDatetime;
                                var sModulo_Err       : String;
                                var sString_Err       : String;
                                var Result            : boolean);


  function elevacion(base
                    ,exponente : double) : double;

  function AgregaMeses_nva(Fecha:TDateTime; Meses:integer):TDateTime;

  function RestaMeses_Nva(Fecha:TDateTime; Meses:integer):TDateTime;

  function AgregaMeses(Fecha           : TDateTime;
                       Meses           : integer) : TDateTime;

  function RestaMeses(Fecha           : TDateTime;
                      Meses           : integer) : TDateTime;

  function Interes_Simple(dTasa,
                          dBase_Porcentual,
                          dDias,
                          dDias_Ref_Tasa : double) : double;

  function Interes_Compuesto(dTasa,
                             dBase_Porcentual,
                             dDias,
                             dDias_Ref_Tasa : double) : double;

  procedure leer_fecha_variable(sNemotecnico : String;
                                fNRO_CUPONES : Double;
                                var dFecha : Tdatetime;
                                var Result : Boolean);

  Procedure calculo_de_dias(fecha_menor,
                            fecha_mayor : Tdatetime;
                            sTipo_Calculo_Dias : String;
                            sPais_Tasa  : String;      
                            var dias_totales,
                                anos_enteros ,
                                anos_fraccion,
                                meses_enteros  : Double);

  procedure DeterminarCuponVigente(sNemotecnico,
                                   sTipo_Vencimiento : String;
                                   DiaPago        : word;
                                   LapsoPago      : integer;   //Periodo de pago
                                   FechaEmision   : TdateTime;
                                   FechaCalculo   : TDateTime;
                                   sTasa_Flotante : String;
                                   Con_Cupon      : Boolean;
                               var NroCupon       : integer;
                               var FechaMenor
                                 , FechaMayor     : TDateTime;
                               var Status_ok      : boolean);

  procedure Leer_Instrumento(sInstrumento         : String;
                             var sSi_No_Descriptor : String;
                             var sTasa_Base_Par    : String;
                             var sTasa_Base_Tir    : String;
                             var sFormula_Par      : String;
                             var sFormula_Tir      : String;
                             var Result           : Boolean);

  procedure Leer_Nemotecnico_Sin_Descriptor(sNemotecnico   : String;
                                            var sTasa_Base : String;
                                            var sFormula   : String;
                                            var sEmisor    : String;
                                            var Result     : Boolean);


  function Leer_Tipo_Instrumento(sCodigo_Instrumento       : String;
                                 var sTIPO_INSTRUMENTO     : String): Boolean;

 
  function Base_Mensual_Float(CodigoTasaBase : string): Double;

  procedure Obtener_Tasa_base(CodigoTasaBase      : string;
                              var BaseTasa        : integer;
                              var TipoInteres     : string;
                              var BaseMensual     : integer;
                              var TipoCalculoDias : String;
                              var VigenciaValor   : Integer;
                              var Vigencia_Meses  : Integer;
                              var sPais_Tasa      : String;
                              var Modulo_err      : String;
                              var String_err      : String;
                              var Result          : Boolean);


  procedure Obtener_Base_Conversion(sCod_Tasa_Base         : String;
                                    var sTipo              : String;
                                    var fPeriodo_Pago      : Double;
                                    var sAnualidad         : String;
                                    var fBase_Porcen       : Double;
                                    var sModulo_Err        : String;
                                    var sString_Err        : String;
                                    var Result             : Boolean);


  procedure Decodifica_Nemotecnico_Br(sNemotecnico             : String;
                                      var sTipo_Bono           : String;
                                      var dFecha_Emision,
                                          DFecha_Vencimiento   : TDateTime;
                                      var sModulo_Err          : String;
                                      var sString_Err          : String;
                                      var Result               : Boolean);

  function Monto_por_corte(sEmisor,
                           sInstrumento,
                           sSerie        : String;
                           fMonto_Origen : Double;
                     var fCorte        : Double;
                     var sCortes       : String) : Double;

  function Vencimiento_variable(sEmisor : String;
                                sInstrumento : String;
                                sSerie       : String) : Boolean;

  function Es_Br(sNemotecnico: String): Boolean;

  function lee_tasa_mercado(sNemotecnico      : String;
                            sTipo_Instrum     : String;
                            sInstrumento      : String;
                            Registro_Fechas   : TRegistro_Fechas;
                            sTipoTasa         : String;
                            dFecha            : TDateTime;
                        var sOrigen           : String;
                        var fTasaMercado      : Double;
                        var sTipo             : String) : Boolean;

//  function lee_tasa_mercado(sNemotecnico      : String;
//                            Registro_Fechas   : TRegistro_Fechas;
//                            dFecha            : TDateTime
//                            ) : Double;

{ function lee_tasa_mercado(sNemotecnico      : String;
                          sTipo_Instrumento : String;
                          dFecha            : TDateTime;
                          bBuscar           : Boolean
                         ) : Double;}

  function lee_precio_mercado(sNemotecnico : String;
                              dFecha       : TDateTime;
                              bBuscar      : Boolean;
                              sOrigen      : String;
                              var fprecio_mdo  : Double;
                              var sTipo        : String) : Boolean;

  function lee_precio_titulo(sNemotecnico : String;
                             dFecha       : TDateTime;
                             sOrigen      : String;
                             bBuscar      : Boolean) : Double;

  function Nominales_Vendidos_Antes(sEmpresa         : String;
                                    sFolio           : String;
                                    sTransaccion     : String;
                                    fItem_Omd        : Double;
                                    dFecha_Operacion : TDateTime;
                                    dFecha_Hora      : TDateTime) : Double;

  procedure Determina_Nominales_Vendidos(dFecha_Valorizacion :TDateTime;
                                         sEmpresa        :String;
                                         sTransaccion    :String;
                                         sFolio          :String;
                                         dItem_omd       :Double;
                                     var Nominales_Ventas: Double);

  procedure Determina_Nominales_Vendidos_Periodo(dFecha_Desde    : TDateTime;
                                                 dFecha_Hasta    : TDateTime;
                                                 sEmpresa        : String;
                                                 sTransaccion    : String;
                                                 sFolio          : String;
                                                 dItem_omd       : Double;
                                                 var Nominales_Ventas    : Double;
                                                 var fValor_Invertido_MC : Double);

  procedure Determina_Nominales_Vendidos_Por_Dia(dFecha_Dia    : TDateTime;
                                                 sEmpresa        : String;
                                                 sTransaccion    : String;
                                                 sFolio          : String;
                                                 dItem_omd       : Double;
                                                 var Nominales_Ventas    : Double);

  function Determina_Nro_Titulos(sEmpresa        : String;
                               sTransaccion    : String;
                               sFolio          : String;
                               fItem_omd       : Double;
                               dFecha          : TDateTime) : Double;

  function Determina_Titulos_Vendidos(sEmpresa        : String;
                                      sTransaccion    : String;
                                      sFolio          : String;
                                      fItem_omd       : Double;
                                      dFecha          : TDateTime) : Double;

  procedure Determina_Nominales_Pactados(dFecha_Valorizacion :TDateTime;
                                         sEmpresa        :String;
                                         sTransaccion    :String;
                                         sFolio          :String;
                                         dItem_omd       :Double;
                                     var Nominales_Pactos: Double);

  Procedure Carga_Descriptor(sEmisor      : String;
                             sInstrumento : String;
                             sSerie       : String;
                         var Registro     : TReg_descriptor;
                         var Modulo_Err   : String;
                         var String_Err   : String;
                         var Result       : Boolean );

  Procedure Carga_Descriptor_Vig(sEmisor      : String;
                             sInstrumento : String;
                             sSerie       : String;
                             dFecha_Vig   : TDateTime;
                         var Registro     : TReg_descriptor;
                         var Modulo_Err   : String;
                         var String_Err   : String;
                         var Result       : Boolean );

  procedure Determina_Spread(sEmpresa       : String;
                             sEmisor        : String;
                             sInstrumento   : String;
                             sSerie         : String;
                             dfecha_Emision : TDateTime;
                         var fSpread        : Double;
                         var Modulo_Err     : String;
                         var String_Err     : String;
                         var Result         : Boolean);

  procedure Actualiza_Valor_IPC(dFecha_Inicial : TdateTime;
                                var fMonto     : Double;
                                dFecha_Final   : TdateTime;
                                String_Error   : String;
                                Modulo_Error   : String;
                                Result         : Boolean);

  procedure Tratamiento_Fecha(sCodigo_Tratam   : String;
                              Registro_Fechas  : TRegistro_Fechas;
                              var Fecha_Result : TDateTime;
                              var Modulo_Err   : String;
                              var String_Err   : String;
                              var Result       : Boolean);
{ Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.
  procedure carga_parametros_formulas(sFormula_PAR    : String;
                                      sFormula_TIR    : String;
                                      var Reg_Formula_PAR : TRegFormulaPAR;
                                      var Reg_Formula_TIR : TRegFormulaTIR;
                                      var sModulo_Err     : String;
                                      var sString_Err     : String;
                                      var Result          : Boolean);
 }
  procedure conversion_tasas(sTipo                 : String;
                             fPeriodo              : Double;
                             sAnualidad            : String;
                             fBase_Porcen          : Double;
                             sTipo_New             : String;
                             fPeriodo_New          : Double;
                             sAnualidad_new        : String;
                             fBase_Porcen_new      : Double;
                             var fValor_Tasa       : Double;
                             var sModulo_Err       : String;
                             var sString_Err       : String;
                             var Result            : Boolean);

  procedure analiza_desagio(sEmisor                     : String;
                            sInstrumento                : String;
                            sSerie                      : String;
                            sCodigo_Tasa                : String;
                            iDiasBaseTasa               : Integer;
                            sTipoInteresTasa            : String;
                            iBaseMensualTasa            : Integer;
                            sTipoCalculoDiasTasa        : String;
                            sPais_Tasa                  : String;
                            dFecDesPeriodo              : TDateTime;
                            dFecHasPeriodo              : TDateTime;
                            fValor_Tasa                 : Double;
                            var dInicio                 : TDateTime;
                            var dTermino                : TDateTime;
                            var iVigenciaValorDesagio   : Integer;
                            var fValor_Tasa_new         : Double;
                            var sModulo_Err             : String;
                            var sString_Err             : String;
                            var bDesagio                : Boolean;
                            var Result                  : Boolean);

  procedure Convierte_Base(iDiasBase          : Integer;
                           sTipoInteres       : String;
                           fValorTasa         : Double;
                           iDiasBaseNew       : Integer;
                           sTipoInteresNew    : String;
                           var Valor_Tasa_New : Double;
                           var Modulo_Err     : String;
                           var String_Err     : String;
                           var Result         : Boolean);

  procedure Convierte_Base_Gestion(iDiasBase          : Integer;
                                   sTipoInteres       : String;
                                   fValorTasa         : Double;
                                   iDiasBaseNew       : Integer;
                                   sTipoInteresNew    : String;

                                   var Valor_Tasa_New : Double;
                                   var Modulo_Err     : String;
                                   var String_Err     : String;
                                   var Result         : Boolean);

  procedure Obtiene_Tasa_Flotante(var Reg_TasFlot         : TRegistro_TasFlot;
                                  Reg_Des                 : TReg_Descriptor;
                                  var Reg_Fechas          : TRegistro_Fechas;
                                  sMetodo_Tasa_Referencia : String;
                                  sTabla_Referencia       : String;
                                  iDiasBase_Descriptor    : Integer;
                                  sTipoInteres_Descriptor : String;
                                  var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                  var bTasas_Cargadas     : Boolean;
                                  var fValorTasa          : Double;
                                  var sModulo_Err         : String;
                                  var sString_Err         : String;
                                  var Result              : Boolean);

  procedure Tasa_Proyeccion_Simple(sCodigo_Tasa       : String;
                                   dFecha             : TDateTime;
                                   var dFecha_Tasa    : TDateTime;
                                   var sReal_Estimada : String;
                                   var fValor_Tasa    : Double;
                                   var sModulo_Err    : String;
                                   var sString_Err    : String;
                                   var Result         : Boolean );

  procedure Valor_Cambio_Proyeccion_Simple(sMon_Origen        : String;
                                           sMon_Paridad       : String;
                                           dFecha             : TDateTime;
                                           sTipo_Paridad      : String;
                                           var fValor_Paridad : Double;
                                           var sModulo_Err    : String;
                                           var sString_Err    : String;
                                           var Result         : Boolean );

  procedure Tasa_Futuros_Implicitos(sNombreTablaReferencia  : String;
                                    Reg_Fechas              : TRegistro_Fechas;
                                    iDiasBase_Descriptor    : Integer;
                                    sTipoInteres_Descriptor : String;
                                    Reg_Des                 : TReg_Descriptor;
                                    var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                    var Reg_TasFlot         : TRegistro_TasFlot;
                                    var bTasas_Cargadas     : Boolean;
                                    var sModulo_Err         : String;
                                    var sString_Err         : String;
                                    var Result              : Boolean );

  procedure Almacena_Valores_Futuros_Implicitos(sNombreTablaReferencia : String;
                                                sCodigo_Tasa           : String;
                                                dFecha_Valor           : TDateTime;
                                                fValor_Tasa            : Double;
                                                dFecha_Desde           : TDateTime;
                                                dFecha_Hasta           : TDateTime;
                                                var sModulo_Err        : String;
                                                var sString_Err        : String;
                                                var Result             : Boolean);

  procedure Impuesto_Instrumento(sCod_Instrumento    : String;
                                 sCod_Div_Geo        : String;
                                 dFecha              : TDateTime;
                                 Reg_Fechas          : TRegistro_Fechas;
                                 Reg_Montos          : TRegistro_Montos;
                                 var fValor_Impuesto : Double;
                                 var sModulo_Err     : String;
                                 var sString_Err     : String;
                                 var Result          : Boolean
                                 );

  function Impuesto_Div_Geo( sCod_Div_Geo: string;
                             dFecha: TDateTime;
                             fMonto: Double;
                             var fImpuesto: Double): Double;

  procedure Registra_Datos_Tasa_Encontrada(sNombreTabla        : String;
                                           sCodigo_Tasa        : String;
                                           dFecha_Calculo      : TDateTime;
                                           fValorTasa          : Double;
                                           dFecha_Inic_Periodo : TDateTime;
                                           dFecha_Vcto_Periodo : TDateTime);

  procedure Recupera_y_Almacena_Valores_Ult_Tasa(sNombreTabla : String;
                                                 sModulo_Err  : String;
                                                 sString_Err  : String;
                                                 Result       : Boolean);

  procedure Impuesto_Instrumento_Memory(sCod_Instrumento    : String;
                                 sCod_Div_Geo        : String;
                                 dFecha              : TDateTime;
                                 Reg_Montos          : TRegistro_Montos;
                                 var fValor_Impuesto : Double;
                                 var sModulo_Err     : String;
                                 var sString_Err     : String;
                                 var Result          : Boolean
                                 );

  function Tipo_Valores(sEmpresa     : String;
                        sTransaccion : String;
                        dFecha       : TDateTime) : String;

  procedure Indice_Reajuste(sInstrumento        : String;
                            dFecha              : TDateTime;
                            var sFechaTratam    : String;
                            var Ind_Reajuste    : String);

  procedure lee_proy_precio(sTipo_Proceso,
                           sNemotecnico,
                           sTabla       : String;
                           dFecha       : TDateTime;
                           sOrigen      : String;
                       var fValor       : Double;
                       var sTipo        : String;
                       var Result       : Boolean
                           );

  procedure Busca_Proy_Precio(sTipo_Proceso :String;
                          var fCantidad     : Double;
                          var sUnidad,
                              sAntes_Despues : String;
                          var Result         : Boolean
                              );

  procedure Tratamiento_Fecha_Memory(sCodigo_Tratam   : String;
                                   Registro_Fechas  : TRegistro_Fechas;
                                   var Fecha_Result : TDateTime;
                                   var Modulo_Err   : String;
                                   var String_Err   : String;
                                   var Result       : Boolean);

  procedure Carga_Valores_Feriados( sCodigo_Division : String );

  function Feriado_Memory(sCodigo_Division : String;
                          dFecha           : TDatetime) : Boolean;


{  procedure Carga_Base_Conversion( RegDes         : TReg_descriptor;
                                   iTotal_Tasas   : Integer;
                               var sModulo_Error  : String;
                               var sString_Error  : String;
                               var Result         : Boolean
                                 );

   procedure Obtener_Base_Conversion_Memory(sCod_Tasa_Base     : String;
                                          var sTipo              : String;
                                          var fPeriodo_Pago      : Double;
                                          var sAnualidad         : String;
                                          var fBase_Porcen       : Double
                                             );  }
  procedure Obtener_Tasa_base_Memory(CodigoTasaBase      : string;
                                   var BaseTasa        : integer;
                                   var TipoInteres     : string;
                                   var BaseMensual     : integer;
                                   var TipoCalculoDias : String;
                                   var VigenciaValor   : Integer;
                                   var Vigencia_Meses  : Integer;
                                   var Modulo_err      : String;
                                   var String_err      : String;
                                   var Result          : Boolean);

  procedure Carga_Valores_Tasa_Memory( sCodigo_Tasa   : String;
                                       dFecha_Inicial : TDatetime;
                                       dFecha_Final   : TDatetime
                                     );

  procedure Busca_Valor( dFecha_Tasa  : TDatetime;
                     var dValor_Tasa  : Double;
                     var Result       : Boolean);

  Procedure Valida_Descriptor_Flujos_Cargados( Var Reg_Val_In  : TRegistro_Valoriza_In;
                                              Var Reg_Val_Out : TRegistro_Valoriza_Out;
                                             sNemotecnico,
                                             sEmisor,
                                             sInstrumento,
                                             sSerie,
                                             sTipo_Instrum,
                                             sTransaccion  : String
                                          );

  function Leer_Tir_Mra( sNemotecnico        : String;
                         dFecha_Calculo      : TDatetime;
                         bBuscar_Ultima_Tasa : Boolean;
                     var sOrigen             : String;
                     var sTipo_TasPre        : String
                        ) : Double;

  function Leer_Tir_Mra_2(sNemotecnico        : String;
                          dFecha_Calculo      : TDatetime;
                          bBuscar_Ultima_Tasa : Boolean;
                      var sOrigen             : String;
                      var sTipo_TasPre        : String
                         ) : Double;

  procedure Decodifica_Nemotecnico_LH(var sNemotecnico   : String;
                                      dFecha_Operacion   : TdateTime;
                                      var dFecha_Emision : TdateTime;
                                      var sModulo_Err    : String;
                                      var sString_Err    : String;
                                      var Result         : Boolean);

  Procedure Determina_Tasa_Financiera( sPais        : String;
                                      sCartera     : String;
                                      sInstrumento : String;
                                      dFecha       : TDatetime;
                                  var sTipo_Tasa   : String;
                                  var Result       : Boolean ); //New_OJO
  {Se cambio a Memory ....  04-09-2014
  Procedure Determina_Dias_Efectivos_Pago( sPais,
                                           sEmisor,
                                           sInstrumento,
                                           sSerie,
                                           sNemotecnico   : String;
                                           dFecha         : TDatetime;
                                       var fCantidad	  : Double;
                                       var sUnidad 	  : String;
                                       var sHabiles	  : String;
                                       var sAntes_Despues : String;
                                       var sAfecta        : String;
                                       var Result         : Boolean );
  }
  procedure Busca_Valuacion( Reg_Val_In       : TRegistro_Valoriza_In;
                             var sTipo_Valuac : String;
                             var sFormula_Pte : String;
                             var fBase_Precio : Double;
                             var sMon_Ind     : String;
                             var sOrigen      : String;
                             var bValuacion   : Boolean); overload;

  procedure Busca_Valuacion( Reg_Val_In          : TRegistro_Valoriza_In;
                             var sTipo_Valuac    : String;
                             var sFormula_Pte    : String;
                             var fBase_Precio    : Double;
                             var sMon_Ind        : String;
                             var sOrigen         : String;
                             var sTasa_Base      : string;
                             var sCodigo_Formula : string;
                             var bValuacion      : Boolean) overload;

  procedure Cupones_Impagos(sEmpresa                 : String;
                            sTransaccion             : String;
                            sFolio                   : String;
                            fItem_Omd                : Double;
                            dFecha                   : TDateTime;
                            var fMonto_Impago_UM     : Double;
                            var fNro_Cupones_Impagos : Double);

  procedure provision_mutuo(iNro_Cupones_Impagos     : Double;
                            sMoneda_Instrum          : String;
                            fMonto_Impago_UM         : Double;
                            fValor_Tasacion          : Double;
                            fSaldo_Insoluto_UM       : Double;
                            fValor_Presente_UM       : Double;
                            var fProvision           : Double);

  function Tasacion_Omd_Braiz(sEmpresa                 : String;
                              sTransaccion             : String;
                              sFolio                   : String;
                              fItem_Omd                : Double;
                              dFecha                   : TDateTime;
                             var dFecha_Retasacion     : TDatetime;
                             var sMoneda_Tasacion     : String ) : Double;

  function Tasacion_Omd_Braiz_Cleas(sEmpresa                 : String;
                                    sTransaccion             : String;
                                    sFolio                   : String;
                                    fItem_Omd                : Double;
                                    dFecha                   : TDateTime;
                                   var dFecha_Retasacion     : TDatetime;
                                   var sMoneda_Tasacion     : String ) : Double;


  function Cupones_Cortados_Nemotecnico(sNemotecnico : String) : Double;

  function Cupones_Cortados_Nemotecnico_Vig( sNemotecnico : String;
                                             dFecha_vig   : TDateTime
                                             ) : Double;


   Procedure Busca_Tasa_TirMra(sCodigo_BR   : String;
                              dFecha_operacion : TDatetime;
                          var fTasa_TirMra : Double;
                          var Result       : Boolean
                              );

  procedure Busca_Rango_Tasa_Mercado( Codigo_Instrumento  : String;
                                     sNemotecnico         : String;
                                     dFecha_Calculo       : TDatetime;
                                     var fLimite_Inferior : Double;
                                     var fLimite_Superior : Double
                                    );

  procedure Elemento_Fecha(sReferencia     : String;
                           fAntes_Despues  : Double;
                           Reg_Fechas      : TRegistro_Fechas;
                           var wElemento   : Word;
                           var sModulo_Err : String;
                           var sString_Err : String;
                           var Result      : Boolean);

  procedure Cambia_Nemotecnico(var Array_Mem_Desarr         : TArray_Mem_Desarr;
                               dFecha                   : TDateTime;
                               dFecha_Emision           : TDateTime;
                               bConCupon                : Boolean;
                               var RegDes                   : TReg_Descriptor;
                               var sNemotecnico         : String;
                               var sModulo_Err          : String;
                               var sString_Err          : String;
                               var Result               : Boolean);

  procedure Obtiene_Fecha_Emision_Implicita(sNemotecnico                 : String;
                                            Reg_Fechas                   : TRegistro_Fechas;
                                            var dFecha_Emision_Implicita : TDateTime;
                                            var sModulo_Err              : String;
                                            var sString_Err              : String;
                                            var Result                   : Boolean);

 Procedure Emision_Implicita_Vig( sNemotecnico,
                                  sEmisor,
                                  sInstrumento,
                                  sSerie             : String;
                                  dFecha_Vig         : TDatetime;
                                  Registro_Fechas    : TRegistro_Fechas;
                                  sDescriptor_Cargado: String;
                                  Var dFecha_Emision : TDatetime;
                                  Var dFecha_Vencimiento : TDatetime;
                                  Var RegDes         : TReg_Descriptor;
                                  Var sModulo_Error  : String;
                                  Var sString_Error  : String;
                                  Var Result         : Boolean
                             );

 Procedure Emision_Implicita( sNemotecnico,
                              sEmisor,
                              sInstrumento,
                              sSerie : String;
                              Registro_Fechas    : TRegistro_Fechas;
                              sDescriptor_Cargado: String;
                              Var dFecha_Emision : TDatetime;
                              Var dFecha_Vencimiento : TDatetime;
                              Var RegDes         : TReg_Descriptor;
                              Var sModulo_Error  : String;
                              Var sString_Error  : String;
                              Var Result         : Boolean
                             );

 Procedure Busca_Descripcion_Clasificacion( sCodigo_Objeto   : String;
                                            fNodo            : Double;
                                            var sDescripcion : String
                                           );


  procedure Obtener_Tasa_base_Variable(sCodigoTasaBase  : string;
                                       Registro_Fechas  : TRegistro_Fechas;
                                   var RegDes           : TReg_descriptor;
                                   var Array_Mem_Desarr : TArray_Mem_Desarr;
                                       sPais_Tasa       : String;
                                   var fDiasBaseTasa    : Integer;
                                   var fPeriodos        : Double;
                                   var sModulo_error    : String;
                                   var sString_error    : String;
                                   var Result           : Boolean);

  procedure Registra_Movimiento_Confirmado_Ctacte(sEmpresa     : String;
                                                 sTransaccion : String;
                                                 sFolio       : String;
                                                 var sConfirmado_Por : String;
                                                 var Result          : Boolean);

  function Existe_Traspaso_Ctacte(sEmpresa     : String;
                                   dFecha       : TDateTime) : Boolean;


  procedure Leer_Precios_Renta_Variable( sNemotecnico  : String;
                                         dFecha        : TDateTime;
                                         sTipo_Precio  : String;
                                         var fPrecio   : Double;
                                         var sMoneda   : String;
                                         var Result    : Boolean);
  procedure Excluye_omd_ProyVctos( dFecha_Cierre   : Tdatetime;
                                   sEmpresa
                                  ,sTransaccion
                                  ,sFolio_Interno  : String;
                                   fItem_omd       : Double;
                               var bResult         : Boolean);


  function Numero_Titulos(sEmpresa       : String;
                          sTransaccion   : String;
                          sFolio_Interno : String;
                          fItem_Omd      : Double) : Double;


  function Calcula_Tramo_Por_Mes(dFecha_Desde   : Tdatetime;
                                 dFecha_Hasta   : Tdatetime) : Double;

  Procedure busca_cuenta_analitica(dfecha_compra          : TDateTime;
                                   dfecha_cierre          : TDateTime;
                                   sfolio_interno         : String;
                                   fitem_omd              : Double;
                                   stransaccion           : String;
                                   scartera               : String;
                                   sempresa               : String;
                               var sCuenta_Analitica : String);

  Procedure busca_cuenta_analitica_new(dFecha_Cierre     : TDateTime;
                                       sCod_Contab       : String;
                                       sTipo_Oper        : String;
                                       sProceso          : String;
                                       sOperacion        : String;
                                       sEmpresa          : String;
                                       sCartera          : String;
                                       sMotivo_Inversion : String;
                                       sMotivo_OMD       : String;
                                       sFolio_Interno    : String;
                                       sNemotecnico      : String;
                                       sEmisor           : String;
                                       sInstrumento      : String;
                                       sMoneda_Instrum   : String;
                                       sCustodia         : String;
                                       sContraparte      : String;
                                       sClasif_Contab    : String;
                                   var sCuenta_Analitica : String);

  function Obtiene_ItemClasif( sDesc_Cuenta: string; var sNum_Cta: string ): boolean;

  function Obtiene_Cuenta( sDesc_Cuenta: string; var sNum_Cta: string ): boolean;
  
  procedure Obtiene_Cuenta_Contable( sCuenta: string; var sCtaSinPunto: string );

  function Obtiene_Descripcion_Cuenta( sDesc_Cuenta: string; var sDescripcion_Cta: string ): boolean;

  function Obtiene_Cuenta_String( sDesc_Cuenta: string; var sNum_Cta: string ): boolean;

  function Valida_Limites_Transaccion(sTipo_Llamada     : String;
                                      sEmpresa          : String;
                                      sCartera          : String;
                                      sMoneda_Operacion : String;
                                      sTransaccion      : String;
                                      sFolio_Interno    : String;
                                      sOperador         : String;
                                      dFecha_Operacion  : TDateTime;
                                      sContraparte      : String;
                                      sPerfil           : String;
                                      Tabla_Detalle     : TFDMemTable):Boolean; overload
  function Valida_Limites_Transaccion(sTipo_Llamada     : String;
                                      sEmpresa          : String;
                                      sCartera          : String;
                                      sMoneda_Operacion : String;
                                      sTransaccion      : String;
                                      sFolio_Interno    : String;
                                      sOperador         : String;
                                      dFecha_Operacion  : TDateTime;
                                      sContraparte      : String;
                                      sPerfil           : String;
                                      Tabla_Detalle     : string ):Boolean; overload;
//                                      Tabla_Detalle     : TFDMemTable):Boolean;

  Procedure Valida_Limite_Operacion(sEmpresa           :String;
                                    sMoneda_Operacion  :String;
                                    dFecha_Operacion   :TDateTime;
                                    sTransaccion       :String;
                                    sFolio_Interno     :String;
                                    sCartera           :String;
                                    sOperador          :String;
                                    fMonto_Operacion :Double);
  Procedure Valida_Limite_Cartera(sEmpresa           :String;
                                  sMoneda_Operacion  :String;
                                  dFecha_Operacion   :TDateTime;
                                  sTransaccion       :String;
                                  sFolio_Interno     :String;
                                  sCartera           :String;
                                  sOperador          :String;
                                  fMonto_Operacion :Double);
  Procedure Valida_Limite_Emisor(sEmpresa           :String;
                                 sMoneda_Operacion  :String;
                                 dFecha_Operacion   :TDateTime;
                                 sTransaccion       :String;
                                 sFolio_Interno     :String;
                                 sCartera           :String;
                                 sOperador          :String;
                                 sEmisor            :String;
                                 fMonto_Operacion :Double);
  Procedure Valida_Limite_Contraparte(sEmpresa           :String;
                                      sMoneda_Operacion  :String;
                                      dFecha_Operacion   :TDateTime;
                                      sTransaccion       :String;
                                      sFolio_Interno     :String;
                                      sCartera           :String;
                                      sOperador          :String;
                                      sContraparte       :String;
                                      fMonto_Operacion   :Double);
  Procedure Valida_Limite_Clasificacion(sEmpresa           :String;
                                        sMoneda_Operacion  :String;
                                        dFecha_Operacion   :TDateTime;
                                        sTransaccion       :String;
                                        sFolio_Interno     :String;
                                        sCartera           :String;
                                        sOperador          :String;
                                        sInstrumento       :String);
  Procedure Valida_Limite_Instrumento(sEmpresa           :String;
                                      sMoneda_Operacion  :String;
                                      dFecha_Operacion   :TDateTime;
                                      sTransaccion       :String;
                                      sFolio_Interno     :String;
                                      sCartera           :String;
                                      sOperador          :String;
                                      sInstrumento       :String);
  function Valida_Limite_Perfil(sEmpresa          :String;
                                sMoneda_Operacion :String;
                                dFecha_Operacion  :TDateTime;
                                sTransaccion      :String;
                                sFolio_Interno    :String;
                                sCartera          :String;
                                sTipo_Instrum     :String;
                                sInstrumento      :String;
                                sMoneda_Instrum   :String;
                                fTipo_Cambio      :Double;
                                sPerfil           :String;
                                fMonto_Operacion  :Double) :Boolean;
  Procedure Exedio_Limite(sTipo              :String;
                          sCodigo_tipo       :String;
                          sLimite            :String;
                          sCodigo            :String;
                          sDescripcion       :String;
                          fMonto_Limite      :Double;
                          fMonto_Operacion   :Double;
                          fMonto_Transado    :Double;
                          fMonto_Excedido    :Double);

 function Busca_Monto_Transado(sEmpresa           :String;
                               sMoneda_Operacion  :String;
                               dFecha_Operacion   :TDateTime;
                               sTransaccion       :String;
                               sFolio_Interno     :String;
                               sNivel             :String;
                               sCodigo            :String;
                               sTipo              :String;
                               sValor             :String) :Double;
 function Busca_Monto_Transado_Perfil(sEmpresa          :String;
                                      sMoneda_Operacion :String;
                                      dFecha_Operacion  :TDateTime;
                                      sTransaccion      :String;
                                      sFolio_Interno    :String;
                                      sCartera          :String;
                                      sTipo_Instrum     :String;
                                      stipo_clasif      :String;
                                      sNodos_Hijos      :String;
                                      sMoneda_Instrum   :String;
                                      sPerfil           :String) :Double;
 function Existen_Limites(sEmpresa         :String;
                          sMoneda_Caja     :String;
                          sTransaccion     :String;
                          dFecha_Operacion :TDatetime) :Boolean;

 Procedure Aviso_Vigencia_Limites(sEmpresa     :String;
                                  sMoneda_Caja :String;
                                  sTransaccion :String);

 Procedure Llena_Seleccion_Carteras(sTipo_Clasif   : String;
                                    sClasificacion : String);

 Function Exedio_Limites(sEmpresa       :String;
                         sCartera       :String;
                         dFecha_Proceso :TDateTime;
                         sTransaccion   :String;
                         sFolio_Interno :String) : Boolean;

 Function Exedio_Limites_RV(sEmpresa      :String;
                           sCartera       :String;
                           dFecha_Proceso :TDateTime;
                           sNemotecnico   :String) : Boolean;

 Function Busca_Monto_excedido(sEmpresa       : String;
                               sTransaccion   : String;
                               sFolio_Interno : String) :Double;

 Function Empresas_Perfil(sEmpresa         :String;
                          sPerfil          :String) :String;
 Function String_Carteras(fPid  :Double) :String;
 Function String_Empresas(fPid  :Double) :String;
 Function String_Transaccion(sTransaccion:String) :String;
 function String_Implicancia(sImplicancia :String): String;
 function String_Implicancia_Inversa(sImplicancia :String): String;
 Function String_Seleccion(sParametro : String) :String; overload;
 Function String_Seleccion(sProceso   : String;
                           sParametro : String) :String; overload;
 Function String_Seleccion_New(sParametro : String) :String;
 Procedure String_Seleccion_Mult(sParametro         : String;
                                 sSeparador         : char;
                             var sString_Seleccion1 : String;
                             var sString_Seleccion2 : String);

 procedure Proyecta_Flujos_por_Curvas( RegDes                 : TReg_descriptor;
                                      Reg_Fechas              : TRegistro_Fechas;
                                      iCupon_a_proyectar      : Integer;
                                      sMetodo_Tasa_Referencia : String;
                                      var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                      var sModulo_Err         : String;
                                      var sString_Err         : String;
                                      var Result              : Boolean);

 Procedure Busca_Activo_En_Margen(dFecha            :TDateTime;   //ggarcia 21-07-2015
                                  sEmpresa          :String;

                                  sTransaccion      :String;
                                  sFolio_Interno    :String;
                                  fItem_Omd         :Double;
                              var sActivo_en_Margen :String);

 Function Transaccion_Anticipada(sEmpresa              : String;
                                 sTransaccion          : String;
                                 sFolio_Interno        : String;
                                 dFecha_Vcto_Cupon     : TDateTime;
                             var fValor_Nocional_Corto : Double;
                             var fValor_Nocional_Largo : Double;
                             var fAnticipado_dia_Corto : Double;
                             var fAnticipado_dia_Largo : Double) :Boolean;

 procedure Busca_Valores_Anticipo_Derivado(sEmpresa           :String;
                                           sTransaccion       :String;
                                           sFolio_interno     :String;
                                           dFecha_Calculo     :TDateTime;
                                       var dFecha_Anticipo    :TDateTime;
                                       var sMoneda_Anticipo   :String;
                                       var fTC_Anticipo       :Double;
                                       var fUnwind_por_Cobrar :Double;
                                       var fUnwind_por_Pagar  :Double);

 //ggarcia 11-01-2016
 procedure Busca_Fecha_Anticipo(sEmpresa            :String;
                               sTransaccion         :String;
                               sFolio_interno       :String;
                               fItem_OMD            :Double;
                               dFecha_Calculo       :TDateTime;
                           var fNocional_Anticipado :Double);

 function Calcula_Fecha_Efectiva(dfecha_paridad :TDatetime;
                                 sEmisor        :String;
                                 sInstrumento   :String;
                                 sSerie         :String;
                                 sNemotecnico   :String):TDatetime;

 Procedure Limpia_Tablas_TMP(sTransaccion   :String;
                             sFolio_interno :String);

 Procedure Pertenece_Clasificacion( sObjeto,
                                    sElemento,
                                    sCodigo_Clasif,
                                    sLista_Nodo,
                                    sOperacion       : String;
                                    var fNodo_Clasif : Double
                                       );

 procedure Busca_Antecedente_Emisor(sEmisor           :String;
                                    dFecha_Proceso    :TDateTime;
                                    Var sGRupo_Economico  : String;
                                    Var bResult           : Boolean);
 Procedure Busca_Cobertura_PMS( sEmpresa,
                                sTransaccion,
                                sFolio_Interno : String;
                                fItem_Omd      : Double;
                                Var sCobertura : String
                              );
 function leer_regulador(sEmisor      : String;
                         sInstrumento : String;
                         dFecha       : tDateTime): String;

 procedure Verifica_Proceso_En_Ejecucion(sProceso      : String;
                                         sEmpresa      : String;
                                         sUsuario_Win  : String;
                                     Var sUsuario_Win_Val : String;
                                     Var sUsuario_Pms_Val : String;
                                     Var sPid_Val         : String;
                                     Var sEmpresa_Val     : String;
                                     var bResult       : Boolean);

 Procedure Obtiene_MaxFec_Limite(sProceso             : String;
                                sCartera_Limite      : String;
                                Fecha_cierre         : TDateTime;
                                var dFecha_Cierre    : TDateTime;
                                var bresult          : Boolean);

 function valida_proy_vctos_RF(sEmpresa     :String;
                               sCartera     :String;
                               bConsolida   :Boolean;
                               dFecha_desde :TDateTime;
                               dFecha_hasta :TDateTime) :Boolean;
 function valida_proy_vctos_derivados(sEmpresa     :String;
                                      sCartera     :String;
                                      bConsolida   :Boolean;
                                      dFecha_desde :TDateTime;
                                      dFecha_hasta :TDateTime) :Boolean;
 Function Holding_Empresa(sEmpresa :String) :String;

 Function Existe_Activo_DPV(sTransaccion  :String;
                            sSerie        :String;
                            sMotivo       :String;
                            sCodigo_Clasif:String):Boolean;

 Function Existe_Activo_PEPS(sTransaccion     :String;
                             sSerie           :String;
                             sMotivo          :String;
                             dFecha_Operacion :TDateTime;
                             sCodigo_Clasif   :String;
                             sFolio_Interno   :String):Boolean;

 Function Existe_Activo_Cobertura(sEmpresa         :String;
                                  sTransaccion     :String;
                                  sFolio_Interno   :String;
                                  fItem_OMD        :Double;
                                  dFecha_Operacion :TDateTime;
                              var sTipo_cobertura  :String):Boolean;

Function Existen_transacciones_en_Margen(sEmpresa :String;
                                         dFecha : TDateTime):Boolean;

procedure Carga_Fechas_Variables_Vig(sNemotecnico     : String;
                                     dfecha_Vig       : TDatetime;
                                 var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 var Modulo_Err       : String;
                                 var sString_Err      : String;
                                 var Result           : Boolean);

procedure Busca_tasa_cupon(sEmpresa       :string;
                           sTransaccion   :string;
                           sFolio_Interno :string;
                           fItem_OMD      :Double;
                           fTasa_Compra   :Double;
                           iCupon_Vigente :Integer;
                       var fTasa_cupon    :Double;
                       var bResult        :Boolean);

procedure Graba_tasa_cupon(sEmpresa               :string;
                           sTransaccion           :string;
                           sFolio_Interno         :string;
                           fItem_OMD              :Double;
                           iCupon_Vigente         :Integer;
                           dFechaCalculo          :TDatetime;
                           fTasaCalculo           :Double;
                           fTasa_Calculo_Original :Double;
                       var bResult                :Boolean);

procedure Solicitud_Venta_al_Vcto(sEmpresa           :string;
                                  sCartera           :string;
                                  sTransaccion       :string;
                                  sFolio_Interno     :string;
                                  fItem_OMD          :Double;
                                  sNemotecnico       :string;
                                  fValor_Nominal     :Double;
                                  sUsuario_Solicita  :string;
                                  dFecha_Hora        :TDateTime;
                              var bResult            :Boolean);

function Existe_Solicitud_Venta(sEmpresa              :String;
                                sTransaccion          :String;
                                sFolio_Interno        :String;
                                fItem_OMD             :Double;
                                bAnulados             :Boolean; //incluye anulados
                            var dFecha_hora_solicitud :TDateTime;
                            var sEstado_Solicitud     :String) :Boolean;

Function Elementos_Clasificados(sObjeto         :string;
                                sCodigo_Clasif  :string;
                                fNodo           :Double) :string;

procedure Busca_Padre(Objeto:String;var Nodo:Double);


Procedure Graba_param_empresa(sEmpresa  : String;
                              sCartera  : String;
                              iPid      : Integer);

function EsNumero(const Valor: string): Boolean;

//function Busca_Origen_Precio( sTipo_Valuac_Mdo : String;
//                              sNemotecnico     : String
//                            ) : String;
var
  dmComunInversiones  : TdmComunInversiones;
  dFecha_Siguiente_Periodo : TDatetime;
  Reg_Descriptor           : TReg_Descriptor;
  GlobalTS                 : TStringList;
  sNombre_Tabla            : String;

implementation
Uses
    DM_Codigos_generales,
    DM_Identidad_Direccion,
    DM_Paises,
    DM_comun,
    DM_Threadvar,
    DMLeer_valor_Cambio,
    Math,
    DM_Base_Datos,
    DateUtil,
    DM_Ayuda_Nemotecnicos,
    Frm_Aprueba_Limites,
    Tabla_Mem_Desarr_TFija,
    Muestra_Mensaje,
    FrmConsolidaEmp;
{$R *.DFM}

 function AgregaMeses(Fecha:TDateTime; Meses:integer):TDateTime;
 var
  Ano,
  Mes,
  Dia,
  DiasDeMes : integer;
  A,
  M,
  D         : word;

 begin
  DecodeDate(Fecha,A,M,D);

  Ano := A;
  Mes := M;
  Dia := D;

  Ano := Ano + Meses div 12;
  Mes := Mes + (Meses mod 12);

  if Mes > 12 then
  begin
    Inc(Ano);
    Mes := Mes mod 12;
  end;

  if Mes < 1 then
  begin
    Dec(Ano);
    Mes := 12 + Mes;
  end;

  DiasDeMes:= ultimo_dia_mes(Mes,Ano);

  if (Dia > DiasDeMes) then
      Dia := DiasDeMes;
  Result := EncodeDate(Ano,Mes,Dia);
 end;

 function AgregaMeses_nva(Fecha:TDateTime; Meses:integer):TDateTime;
 var
  Ano,
  Mes  : integer;
  A,
  M,
  D         : word;

 begin
  DecodeDate(Fecha,A,M,D);

  Ano := A;
  Mes := M;
  //Dia := D;

  Ano := Ano + Meses div 12;
  Mes := Mes + (Meses mod 12);

  if Mes > 12 then
  begin
    Inc(Ano);
    Mes := Mes mod 12;
  end;

  if Mes < 1 then
  begin
    Dec(Ano);
    Mes := 12 + Mes;
  end;

  Result := EncodeDate(Ano,Mes,ultimo_dia_mes(Mes,Ano));
 end;

 function RestaMeses_Nva(Fecha:TDateTime; Meses:integer):TDateTime;
 var Ano,
     Mes : integer;
     A,
     M,
     D         : word;
 begin
    DecodeDate(Fecha,A,M,D);

    Ano := A;
    Mes := M;

    Ano := Ano - Meses div 12;
    Mes := Mes - (Meses mod 12);

    if Mes > 12 then
    begin
      Inc(Ano);
      Mes := Mes mod 12;
    end;

    if Mes < 1 then
    begin
      Dec(Ano);
      Mes := 12 + Mes;
    end;

    Result := EncodeDate(Ano,Mes,ultimo_dia_mes(Mes,Ano));
 end;

 function RestaMeses(Fecha:TDateTime; Meses:integer):TDateTime;
 var Ano,
     Mes,
     Dia,
     DiasDeMes : integer;
     A,
     M,
     D         : word;
 begin
    DecodeDate(Fecha,A,M,D);

    Ano := A;
    Mes := M;
    Dia := D;

    Ano := Ano - Meses div 12;
    Mes := Mes - (Meses mod 12);

    if Mes > 12 then
    begin
      Inc(Ano);
      Mes := Mes mod 12;
    end;

    if Mes < 1 then
    begin
      Dec(Ano);
      Mes := 12 + Mes;
    end;

    DiasDeMes:= ultimo_dia_mes(Mes,Ano);

    if (Dia > DiasDeMes) then
        Dia := DiasDeMes;
        
    Result := EncodeDate(Ano,Mes,Dia);
 end;

function elevacion(base,exponente:double):double;
 begin
       elevacion :=exp(exponente*ln(base))
 end;
//------------------------------------------------------------------------------
{
procedure Suma_dias(dFecha_Inicio     : TDateTime;
                    fDias             : Integer;
                    fBase_Mensual     : Integer;
                    var dFecha_Result : TDateTime);
var
  dMeses   : Integer;

begin
  if fBase_Mensual = 0 then
     dFecha_Result := IncDate(dFecha_Inicio,
                              fDias,
                              0,
                              0);
  if fBase_Mensual <> 0 then
     begin
       dMeses := fDias div fBase_Mensual;
       dFecha_Result := IncDate(dFecha_Inicio
                               ,0
                               ,dMeses
                               ,0);

       dFecha_Result := IncDate(dFecha_Result
                               ,(fDias mod fBase_Mensual)
                               ,0
                               ,0);
     end;
end;  // Suma_Dias
}
//------------------------------------------------------------------------------
function suma_lapso(dfecha_inicial   : tdatetime;
                   wperiodo_pago,
                   wdia_pago         : word): tdatetime;
var
  ano_calculado,
  mes_calculado,
  dia_calculado   : word;
//  anos_meses      : double;
  iAux: Longint;
begin
  DecodeDate(dfecha_inicial
            ,ano_calculado
            ,mes_calculado
            ,dia_calculado);

  ano_calculado := ano_calculado + round(int(wperiodo_pago / 12));

  if wperiodo_pago = 12 then
     iAux := 0
  else
     iAux := round(((wperiodo_pago / 12)- int(wperiodo_pago / 12)) * 12);

  mes_calculado := mes_calculado + iAux;
  // mes_calculado := mes_calculado + round(((wperiodo_pago / 12)- int(wperiodo_pago / 12)) * 12);

  if mes_calculado > 12 then
     begin
        mes_calculado := mes_calculado - 12;
        ano_calculado := ano_calculado + 1;
     end;

  if wdia_pago > ultimo_dia_mes(mes_calculado,ano_calculado) then
     wdia_pago := ultimo_dia_mes(mes_calculado,ano_calculado);

  if wdia_pago = 0 then
     wdia_pago := ultimo_dia_mes(mes_calculado,ano_calculado);

  Result := EncodeDate(ano_calculado
                      ,mes_calculado
                      ,wdia_pago);
end;

function Carga_Reg_Descriptor(sEmisor,
                              sInstrumento,
                              sSerie : String) : boolean;
begin
  Result := True;
  WITH dmComunInversiones.QRY_General
      ,Reg_Descriptor do
    begin
      SQL.Clear;
      SQL.Add('SELECT *'
             +'  FROM QS_FIN_DESCRIPTOR'
             +' WHERE Codigo_Emisor      = :Codigo_Emisor'
             +'   AND Codigo_Instrumento = :Codigo_Instrumento'
             +'   AND Serie              = :Serie'
             );
      ParamByname('Codigo_Emisor').asString      := Trim(sEmisor);
      ParamByname('Codigo_Instrumento').asString := Trim(sInstrumento);
      ParamByname('Serie').asString              := Trim(sSerie);
      Open;

      If Fieldbyname('Codigo_Emisor').IsNull  then
         Result := False
      else
      begin
        CODIGO_EMISOR      := FieldByName('CODIGO_EMISOR').AsString;
        CODIGO_INSTRUMENTO := FieldByName('CODIGO_INSTRUMENTO').AsString;
        SERIE              := FieldByName('SERIE').AsString;
        SERIE_BOLSA        := FieldByName('SERIE_BOLSA').AsString;
        FECHA_EMISION      := FieldByName('FECHA_EMISION').Asdatetime;
        TASA_EMISION       := FieldByName('TASA_EMISION').AsFloat;
        TASA_EFECTIVA      := FieldByName('TASA_EFECTIVA').AsFloat;
        TASA_VALOR_PAR     := FieldByName('TASA_VALOR_PAR').AsString;
        TASA_VALOR_PTE     := FieldByName('TASA_VALOR_PTE').AsString;
        UNIDAD_MON         := FieldByName('UNIDAD_MON').AsString;
        PLAZO_EN_ANOS      := FieldByName('PLAZO_EN_ANOS').AsFloat;
        TIPO_AMORTIZAC     := FieldByName('TIPO_AMORTIZAC').AsString;
        NRO_CUPONES        := FieldByName('NRO_CUPONES').AsFloat;
        PERIODO_PAGO       := FieldByName('PERIODO_PAGO').AsFloat;
        TIPO_VENCIMIENTO   := FieldByName('TIPO_VENCIMIENTO').AsString;
        DIA_VENCIMIENTO    := FieldByName('DIA_VENCIMIENTO').AsFloat;
        DECIMAL_AJUSTE     := FieldByName('DECIMAL_AJUSTE').AsFloat;
        TIPO_AJUSTE        := FieldByName('TIPO_AJUSTE').AsString;
        BASE_ORIGINAL      := FieldByName('BASE_ORIGINAL').AsFloat;
        BASE_CONVERSION    := FieldByName('BASE_CONVERSION').AsFloat;
        COD_CALC_PAR_D     := FieldByName('COD_CALC_PAR_D').AsString;
        COD_CALC_TIR_D     := FieldByName('COD_CALC_TIR_D').AsString;
        OPCION_PREPAGO     := FieldByName('OPCION_PREPAGO').AsString;
        if FieldByName('FECHA_PREPAGO').IsNull then
           FECHA_PREPAGO      := 0
        else
           FECHA_PREPAGO      := FieldByName('FECHA_PREPAGO').Asdatetime;

        if FieldByName('PRECIO_PREPAGO').IsNull then
           PRECIO_PREPAGO     := 0
        else
           PRECIO_PREPAGO     := FieldByName('PRECIO_PREPAGO').AsFloat;
        TASA_FLOTANTE      := FieldByName('TASA_FLOTANTE').AsString;
        TIPO_NOMINALES     := FieldByName('TIPO_NOMINALES').AsString;
        FECHAS_SINO        := FieldByName('FECHAS_SINO').AsString;
        TIPO_PAGO          := FieldByName('TIPO_PAGO').AsString;
      end;
      Close;
    end;
end;
//---------------------
// Edosan, cambiado por Fecha de Vigencia en Descriptor
function Carga_Reg_Descriptor_Vig(sEmisor,
                                  sInstrumento,
                                  sSerie : String;
                                  dFecha_Vig : TDateTime) : boolean;
begin
  Result := True;
  WITH dmComunInversiones.QRY_General
      ,Reg_Descriptor do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.*'
             +'  FROM QS_FIN_DESCRIPTOR a'
             +' WHERE a.Codigo_Emisor      = :Codigo_Emisor'
             +'   AND a.Codigo_Instrumento = :Codigo_Instrumento'
             +'   AND a.Serie              = :Serie');
      if sDriver = 'ORACLE' then
         SQL.Add('   AND TRUNC(a.Fecha_Vig) = (SELECT MAX(TRUNC(x.Fecha_Vig))')
      else
         SQL.Add('   AND CONVERT(CHAR(10),a.Fecha_Vig,103) = (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
      SQL.Add('                                 FROM QS_FIN_DESCRIPTOR x'
             +'                                WHERE x.Codigo_Emisor      = a.Codigo_Emisor'
             +'                                  AND x.Codigo_Instrumento = a.Codigo_Instrumento'
             +'                                  AND x.Serie              = a.Serie'
             +'                                  AND x.Fecha_Vig         <= :Fecha_Vig)'
             );
      ParamByname('Codigo_Emisor').asString      := Trim(sEmisor);
      ParamByname('Codigo_Instrumento').asString := Trim(sInstrumento);
      ParamByname('Serie').asString              := Trim(sSerie);
      ParamByname('Fecha_Vig').AsDate        := dFecha_Vig;
      Open;

      If Fieldbyname('Codigo_Emisor').IsNull  then
         Result := False
      else
      begin
        CODIGO_EMISOR      := FieldByName('CODIGO_EMISOR').AsString;
        CODIGO_INSTRUMENTO := FieldByName('CODIGO_INSTRUMENTO').AsString;
        SERIE              := FieldByName('SERIE').AsString;
        SERIE_BOLSA        := FieldByName('SERIE_BOLSA').AsString;
        FECHA_EMISION      := FieldByName('FECHA_EMISION').Asdatetime;
        TASA_EMISION       := FieldByName('TASA_EMISION').AsFloat;
        TASA_EFECTIVA      := FieldByName('TASA_EFECTIVA').AsFloat;
        TASA_VALOR_PAR     := FieldByName('TASA_VALOR_PAR').AsString;
        TASA_VALOR_PTE     := FieldByName('TASA_VALOR_PTE').AsString;
        UNIDAD_MON         := FieldByName('UNIDAD_MON').AsString;
        PLAZO_EN_ANOS      := FieldByName('PLAZO_EN_ANOS').AsFloat;
        TIPO_AMORTIZAC     := FieldByName('TIPO_AMORTIZAC').AsString;
        NRO_CUPONES        := FieldByName('NRO_CUPONES').AsFloat;
        PERIODO_PAGO       := FieldByName('PERIODO_PAGO').AsFloat;
        TIPO_VENCIMIENTO   := FieldByName('TIPO_VENCIMIENTO').AsString;
        DIA_VENCIMIENTO    := FieldByName('DIA_VENCIMIENTO').AsFloat;
        DECIMAL_AJUSTE     := FieldByName('DECIMAL_AJUSTE').AsFloat;
        TIPO_AJUSTE        := FieldByName('TIPO_AJUSTE').AsString;
        BASE_ORIGINAL      := FieldByName('BASE_ORIGINAL').AsFloat;
        BASE_CONVERSION    := FieldByName('BASE_CONVERSION').AsFloat;
        COD_CALC_PAR_D     := FieldByName('COD_CALC_PAR_D').AsString;
        COD_CALC_TIR_D     := FieldByName('COD_CALC_TIR_D').AsString;
        OPCION_PREPAGO     := FieldByName('OPCION_PREPAGO').AsString;
        if FieldByName('FECHA_PREPAGO').IsNull then
           FECHA_PREPAGO      := 0
        else
           FECHA_PREPAGO      := FieldByName('FECHA_PREPAGO').Asdatetime;

        if FindField('PRECIO_PREPAGO') <> Nil then
        begin
          if FieldByName('PRECIO_PREPAGO').IsNull then
             PRECIO_PREPAGO     := 0
          else
             PRECIO_PREPAGO     := FieldByName('PRECIO_PREPAGO').AsFloat;
        end
        else
          PRECIO_PREPAGO     := 0;

        TASA_FLOTANTE      := FieldByName('TASA_FLOTANTE').AsString;
        TIPO_NOMINALES     := FieldByName('TIPO_NOMINALES').AsString;
        FECHAS_SINO        := FieldByName('FECHAS_SINO').AsString;
        TIPO_PAGO          := FieldByName('TIPO_PAGO').AsString;
//        FECHA_VIG          := FieldByName('FECHA_VIG').Asdatetime;  // Ojo, Edosan
      end;
      Close;
    end;
end;
//------------------
function siguiente_periodo(sNemotecnico      : String;
                           sTipo_vencimiento : String;
                           iNro_Cupon        : Integer;
                           wDia_Vencimiento  : word;
                           wPeriodo_Pago     : word;
                           sTasa_Flotante    : String;
                           dfecha : TDatetime) : boolean;
var
  wdia,
  wmes,
  wano : word;
begin
  Result := True;
  if (sTipo_Vencimiento = 'UD') or
     (sTipo_Vencimiento = 'SD') then
     begin
       decodedate(dfecha,wano,wmes,wdia);

//       if sTasa_Flotante = 'N' then    // Si es tasa flotante se usa el dia de la emision
//          begin
           if (sTipo_Vencimiento = 'UD') then
               wdia := ultimo_dia_mes(wmes,wano)
           else
               wdia := wDia_Vencimiento;
//          end;

       dFecha_Siguiente_Periodo := suma_lapso(dfecha,
                                              wPeriodo_Pago,
                                              wdia);
     end
  else  {Tipo Vencimiento Variable VA}
  begin
     {   Queda comentado el acceso en memoria debido a la cantidad de estos registros en Auditoría y SVS
     if sValorizacion_Proceso = 'SI' then
     begin
        if Not Busca_Nem_Fechas(  sNemotecnico
                                 ,iNro_Cupon
                                 ,dFecha_Siguiente_Periodo ) then
           Result := False
        else
           dFecha_Siguiente_Periodo := dFecha;
     end
     else
     }
     begin
        WITH dmComunInversiones.QRY_General do   {Tabla de Fechas de vencimiento}
        begin
              SQL.Clear;
              SQL.Add('SELECT Fecha_Vencimiento'
                     +'  FROM QS_FIN_Nem_Fechas'
                     +' WHERE Codigo_Nemotecnico = :Nemotecnico '
                     +'   AND Nro_Cupon = :Cupon'
                     );
              ParamByName('Nemotecnico').AsString := sNemotecnico;
              ParamByName('Cupon').AsFloat        := iNro_Cupon;
              Open;
              if FieldByName('Fecha_Vencimiento').IsNull then
                 Result := False
              else
                 dFecha_Siguiente_Periodo :=
                               FieldByName('Fecha_Vencimiento').AsDatetime;
              Close;
        end;
     end;
   end;
end;

function Interes_Simple(dTasa,
                        dBase_Porcentual,
                        dDias,
                        dDias_Ref_Tasa : double) : double;
begin

  { Formula : (1 + (Tasa/100) * (Dias/Dias_Ref_Tasa)) }

  Result := 0;
  if dDias_Ref_Tasa = 0 then
     exit;

  if dBase_Porcentual = 0 then
     dBase_Porcentual := 100;

  Result := (1 + (dTasa/dBase_Porcentual) * (dDias/dDias_Ref_Tasa));
end;


function Interes_Compuesto(dTasa,
                           dBase_Porcentual,
                           dDias,
                           dDias_Ref_Tasa : double) : double;
//var
//  dexponente,
//  dbase : double;
begin

  { Formula : (1 + (Tasa/100)) ** (Dias/Dias_Ref_Tasa) }

  Result := 0;
  if dDias_Ref_Tasa = 0 then
     exit;

  if dBase_Porcentual = 0 then
     dBase_Porcentual := 100;

  try
    Result := power( (1 + (dTasa / dBase_Porcentual)),  // base
                     (dDias / dDias_Ref_Tasa) );       // exponente
  except
     Application.MessageBox(pchar( 'Operacion no permitida'+#10
                                  +'Tasa     : '+FloatToStr(dTasa)+#10
                                  +'Dias     : '+FloatToStr(dDias)+#10
                                  +'Dias Base: '+FloatToStr(dDias_Ref_Tasa)+#10
                                  +'Cheque los rangos de tasa definidos'
                                  )
                            ,'Calculo de Interes Compuesto'
                            , mb_OK+ Mb_IconError);
     Result := 0;

  end;
end;

procedure leer_fecha_variable(sNemotecnico : String;
                              fNRO_CUPONES : Double;
                              var dFecha : Tdatetime;
                              var Result : Boolean);
begin
  Result := True;
  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Fecha_Vencimiento'
             +'  FROM QS_FIN_NEM_FECHAS'
             +' WHERE Codigo_Nemotecnico = :pCodigo_Nemotecnico'
             +'   AND Nro_Cupon          = :pNro_Cupon'
             );

      ParamByName('pCodigo_Nemotecnico').AsString := sNemotecnico;
      ParamByName('pNro_Cupon').AsFloat           := fNRO_CUPONES;

      Prepare;
      Open;
      if FieldByName('Fecha_Vencimiento').IsNull then
         Result := FALSE
      else
         dFecha := FieldByName('Fecha_Vencimiento').AsDateTime;
      Close;
      Unprepare;
    end;
end;

Procedure Leer_PROV_VOLUNTARIA_B2( sProceso,
                                   sEmpresa ,
                                   sCartera,
                                   sNemotecnico          : String;
                                   dFecha_Proceso        : TDatetime;
                                   sMoneda_Conversion    : string;
                                   var fValor            : Double;
                                   var sModelo_Propio    : String;
                                   var bResult           : Boolean
                                   );
var bResul2 : Boolean;
    sModulo_Error,
    sString_Error : string;
begin
  WITH dmComunInversiones.Qry_Prov_B2 do
  begin

     ParamByName('Codigo_Proceso').AsString  := sProceso;
     ParamByName('Empresa').AsString         := sEmpresa;
     ParamByName('Cartera').AsString         := sCartera;
     ParamByName('Nemotecnico').AsString     := sNemotecnico;
     Parambyname('Fecha_Proceso').AsDate     := dFecha_Proceso;
     Open;

     if Not FieldByName('Valor').IsNull then
     begin
        fValor := Fieldbyname('Valor').asFloat;
        if FieldByName('Moneda').asString <> sMoneda_Conversion then
        begin
          conversion_unidad_mon(trim(Fieldbyname('Moneda').asString),
                                trim(sMoneda_Conversion),
                                'BC',
                                dFecha_Proceso,
                                Fieldbyname('Valor').asFloat,
                                fValor,
                                sModulo_Error,
                                sString_Error,
                                bResul2);
          if Not bResul2 then
          begin
            fValor              := 0;
            sModelo_Propio      := '';
            bResult             := False;
          end;
        end
        else
        begin
          sModelo_Propio      := FieldByName('Modelo_Propio').asString;
          bResult        := True;
        end;
     end
     else
     begin
        fValor              := 0;
        sModelo_Propio      := '';
        bResult             := False;
     end;
     Close;
  end;
end;

Procedure calculo_de_dias(fecha_menor,fecha_mayor:Tdatetime;
                          sTipo_Calculo_Dias : String;
                          sPais_Tasa : String;
                          var dias_totales,
                              anos_enteros ,
                              anos_fraccion,
                              meses_enteros: Double);
{ si la variable "Base" es 0 : dias exactos
                           1 : dias base 360
                           2 : dias base 365}
const
{$j+}
   dias_mes : array [1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
{$j-}
  var
   ano1,mes1,dia1 :word;
   ano2,mes2,dia2 :word;
   ano_auxiliar   :word;

   function Calcula_dias(mesmenor,mestope,ano:word; base:boolean):integer;
   { Esta funcion calcula los dias entre los meses de un ano }
   var
     i        :integer;
     resto    :integer;
   begin
   {determinacion de áno bisiesto }
     resto := ano div 4;
     if (ano * 4) = (resto * ano) then
     begin
        dias_mes[2]:=29;
     end;
     mesmenor    := mesmenor + 1;
//     calcula_dias:=0;
     i:=0;
     while mesmenor <= mestope do
     begin
     if base then
         i := i + dias_mes[mesmenor]
      else
         i := i + 30;
      mesmenor:=mesmenor + 1;
     end;
     calcula_dias:=i;
   end;{funcion }

begin
    decodedate(fecha_menor,ano1,mes1,dia1);
    decodedate(fecha_mayor,ano2,mes2,dia2);
    dias_totales:=0;

    {Calculo de días exactos  }
    if sTipo_Calculo_Dias = 'EXACTOS' then
       dias_totales := fecha_mayor - fecha_menor;


    if sTipo_Calculo_Dias = '360 HP' then
    begin
       // metodo US
         if dia1 > 30 then
            dia1 := 30;

         if (dia2 > 30) and
            (dia1 < 30) then
            begin
              dia2 := 1;
              mes2 := mes2 + 1;
              if mes2 > 12 then
                 begin
                   mes2 := 1;
                   ano2 := ano2 + 1;
                 end;
            end;
        {Calculo de los dias por los anos  }
         ano_auxiliar:=ano1;
         while ano_auxiliar <= ano2 do
         begin
             dias_totales :=dias_totales + 360;
             ano_auxiliar :=ano_auxiliar + 1;
         end;
         {Calculo de dias en base 360}

         {Se restan los dias transcurridos del ano hasta la fecha menor }
         if (dias_mes[mes1] <> dia1) or (mes1 = 2) then
            dias_totales:=dias_totales -(calcula_dias(0,mes1,ano1,false) - (30 - dia1))
         else
            dias_totales:=dias_totales - calcula_dias(0,mes1,ano1,false);

        {Se restan los dias que faltan para completar el ano de la fecha mayor }
         if (dias_mes[mes2] <> dia2) or (mes2 = 2) then
           dias_totales:=dias_totales - (calcula_dias(mes2-1,12,ano2,false) - dia2)
         else
           dias_totales:=dias_totales - (calcula_dias(mes2-1,12,ano2,false) - 30);
    end;


    if sTipo_Calculo_Dias = 'DIAS 365' then
    begin
       {Calculo de los dias por los anos }
         ano_auxiliar:=ano1;
         while ano_auxiliar <= ano2 do
         begin
             dias_totales :=dias_totales + 365;
             ano_auxiliar :=ano_auxiliar + 1;
         end;
      {Calculo de días en base 365 }
      {Se restan los dias transcurridos del ano hasta la fecha menor}
      dias_totales:=dias_totales -(calcula_dias(0,mes1,ano1,true) - (dias_mes[mes1] - dia1));
      {Se restan los dias que faltan para completar el ano de la fecha mayor }
      dias_totales:=dias_totales - (calcula_dias(mes2-1,12,ano2,true) - dia2);
    end;

    if sTipo_Calculo_Dias = '360 E' then
       dias_totales := dias360(fecha_menor,fecha_mayor,True);

    if sTipo_Calculo_Dias = '360 US' then
       dias_totales := dias360(fecha_menor,fecha_mayor,False);

    if sTipo_Calculo_Dias = 'HABILES' then
       dias_totales := diashabiles(fecha_menor,fecha_mayor,sPais_Tasa);

    if fecha_menor >= fecha_mayor then
       dias_totales := 0;

    anos_enteros  := ano2 - ano1;
    meses_enteros := mes2 - mes1;
    if meses_enteros < 0 then
    begin
      meses_enteros := meses_enteros + 12;
      anos_enteros  := anos_enteros  - 1;
    end;
    if anos_enteros < 0 then
       anos_enteros := 0;

    // anos_fraccion := anos_enteros + meses_enteros /12 + (dias_mes[mes1] - dia1)/365;
// Edosan, Cambie Linea de abajo segun ticket 1081 19-12-06, se reemplaza formula.
//anos_fraccion := anos_enteros + (meses_enteros /12) + (DaysPerMonth(ano1, mes1) - dia1)/365;
anos_fraccion := (fecha_mayor - fecha_menor) / StrToFloat( '365'+FormatSettings.DecimalSeparator+'25');
try
   if anos_fraccion <> 0 then
      //anos_fraccion := StrtoFloat(FormatFLoat('#####'+FormatSettings.DecimalSeparator+'##',anos_fraccion));
      anos_fraccion := RoundD(anos_fraccion,2);
except
//   Application.MessageBox('No pudo realizar StrtoFloat'
//                             ,'Calculo de Dias'
//                             , mb_OK+ Mb_IconError);
   anos_fraccion := 0;
end;


end;{procedure calculo de dias}

procedure DeterminarCuponVigente(sNemotecnico,
                                 sTipo_Vencimiento : String;
                                 DiaPago        : word;
                                 LapsoPago      : integer;   //Periodo de pago
                                 FechaEmision   : TdateTime;
                                 FechaCalculo   : TDateTime;
                                 sTasa_Flotante : String;
                                 Con_Cupon      : Boolean;
                             var NroCupon       : integer;
                             var FechaMenor
                               , FechaMayor: TDateTime;
                             var Status_ok : boolean);
var
  Result : boolean;
begin
 Status_ok := True;
 NroCupon   := 1;
 FechaMenor := FechaEmision;
 FechaMayor := FechaMenor;
 Proximo_vencimiento(sNemotecnico,
                     sTipo_vencimiento,
                     NroCupon,
                     DiaPago,
                     LapsoPago,
                     sTasa_Flotante,
                     FechaMayor,
                     Result);
 if Con_Cupon then
 Begin
   While (FechaCalculo > FechaMayor ) do
   begin
     Inc(NroCupon);
     FechaMenor := FechaMayor;
     Proximo_vencimiento(sNemotecnico,
                         sTipo_vencimiento,
                         NroCupon,
                         DiaPago,
                         LapsoPago,
                         sTasa_Flotante,
                         FechaMayor,
                         Result);
   end;
 end
 else
 begin
   While (FechaCalculo >= FechaMayor ) do
     begin
       Inc(NroCupon);
       FechaMenor := FechaMayor;
       Proximo_vencimiento(sNemotecnico,
                           sTipo_vencimiento,
                           NroCupon,
                           DiaPago,
                           LapsoPago,
                           sTasa_Flotante,
                           FechaMayor,
                           Result);
     end;
 end;
end;
//------------------------------------------------------------------------------
procedure Obtener_Tasa_base(CodigoTasaBase      : string;
                            var BaseTasa        : integer;
                            var TipoInteres     : string;
                            var BaseMensual     : integer;
                            var TipoCalculoDias : String;
                            var VigenciaValor   : Integer;
                            var Vigencia_Meses  : Integer;
                            var sPais_Tasa      : String;
                            var Modulo_err      : String;
                            var String_err      : String;
                            var Result          : Boolean);

begin
  if VarIsArray(Reg_Base_Conversion.Cod_Tasa_Base) then
  begin
     Obtener_Tasa_base_Mem(CodigoTasaBase
                          ,BaseTasa
                          ,TipoInteres
                          ,BaseMensual
                          ,TipoCalculoDias
                          ,VigenciaValor
                          ,Vigencia_Meses
                          ,sPais_Tasa
                          ,Modulo_err
                          ,String_err
                          ,Result);
     exit;
  end;




  Modulo_Err :='Obtener Tasa Base';
  BaseTasa   := 0;
  Result := True;
  with dmComunInversiones.QRY_General do
  begin
    Sql.clear;
    Sql.Add('SELECT a.DIAS_BASE_TASA As Dias_Base'
            +'     ,a.TIPO_INTERES_TASA As Tipo_Interes'
            +'     ,a.BASE_MENSUAL_TASA As Base_Mensual'
            +'     ,a.VIGENCIA_VALOR'
            +'     ,a.VIGENCIA_MESES'
            +'     ,a.TIPO_CALCULO_DIAS'
            +'     ,b.Nacion_moneda'
            +'     ,b.unidad_medida_mon'
            +'  FROM qs_fin_tasa_base a'
            +'      ,qs_sys_monedas b    '
            +' WHERE a.cod_tasa_base = :cod_tasa_base'
            +'   AND a.cod_tasa_base = b.cod_moneda'
            );

    ParamByName('cod_tasa_base').AsString := trim(CodigoTasaBase);
    try
      Open
    except
      begin
        String_Err := 'Error en acceso a Base de Datos';
        Result := False;
        Close;
        exit;
      end
    end;

    if (RecordCount = 0) then
       begin
         close;
         Unprepare;
         String_Err := 'Definición incorrecta para Tasa Base: '+trim(CodigoTasaBase);
         Result := False;
         exit;
       end;

    if (FieldByName('Dias_Base').AsInteger = 0) or
       (FieldByName('Dias_Base').IsNull)        then
    begin
      if Not FieldByName('Nacion_moneda').isNull then
         sPais_Tasa := FieldByName('Nacion_moneda').AsString;

      if not FieldByName('TIPO_CALCULO_DIAS').isNull then
         TipoCalculoDias := FieldByName('TIPO_CALCULO_DIAS').AsString;

      close;
      String_Err := 'Definición incorrecta para Tasa Base: '+trim(CodigoTasaBase)+' Dias Base';
      Result := False;
      exit;
    end;

    if (FieldByName('Tipo_interes').AsString = ' ') or
       (FieldByName('Tipo_interes').IsNull)         then
       begin
         close;
         Unprepare;
         String_Err := 'Definición incorrecta para Tasa Base: '+trim(CodigoTasaBase)+' Tipo Interes';
         Result := False;
         exit;
       end;

    if (FieldByName('TIPO_CALCULO_DIAS').AsString = ' ') or
       (FieldByName('TIPO_CALCULO_DIAS').IsNull)         then
    begin
      close;
      Unprepare;
      String_Err := 'Definición incorrecta para Tasa Base: '+trim(CodigoTasaBase)+' Tipo Calculo Dias';
      Result := False;
      exit;
    end;


    BaseTasa        := FieldByName('Dias_Base').AsInteger;
    TipoInteres     := FieldByName('Tipo_interes').AsString;
    BaseMensual     := FieldByName('Base_Mensual').AsInteger;
    VigenciaValor   := FieldByName('Vigencia_Valor').AsInteger;
    Vigencia_Meses  := FieldByName('Vigencia_Meses').AsInteger;
    TipoCalculoDias := FieldByName('TIPO_CALCULO_DIAS').AsString;
    sPais_Tasa      := FieldByName('Nacion_moneda').AsString;

    close;
    Unprepare;
 end;

 if NOT Result then
    begin
      String_Err := 'Definición incorrecta para Tasa Base: '+trim(CodigoTasaBase);
      exit;
    end;
(*
 case BaseMensual of
  25  : BaseCalculoDias := 4; //Prueba parcial
  29  : BaseCalculoDias := 3;{Diferencia en dias base 360 Metodo Europeo}
  30  : BaseCalculoDias := 1;{Diferencia en dias base 360}
  31  : BaseCalculoDias := 2;{Diferencia en dias base 365}
 else
        BaseCalculoDias := 0;{Diferencia en dias exactos}
 end;
*)

end;
//------------------------------------------------------------------------------
// Temporal solo para interpolacion
// Esto desaparece cuando se realize la
// incorporacion de funciones de interpolacion 20-Dic-2000

function Base_Mensual_Float(CodigoTasaBase : string): Double;
begin
  with dmComunInversiones.QRY_General do
  begin
    Sql.clear;
    Sql.Add('SELECT BASE_MENSUAL_TASA As Base_Mensual'
            +'  FROM qs_fin_tasa_base'
            +' WHERE cod_tasa_base = :cod_tasa_base'
            );

    ParamByName('cod_tasa_base').AsString := trim(CodigoTasaBase);
    prepare;
    Open;
    Result   := FieldByName('Base_Mensual').AsFloat;
    close;
    Unprepare;
 end;
end;
//------------------------------------------------------------------------------
procedure Obtener_Base_Conversion(sCod_Tasa_Base         : String;
                                  var sTipo              : String;
                                  var fPeriodo_Pago      : Double;
                                  var sAnualidad         : String;
                                  var fBase_Porcen       : Double;
                                  var sModulo_Err        : String;
                                  var sString_Err        : String;
                                  var Result             : Boolean);
begin

  Obtener_Base_Conversion_Mem(sCod_Tasa_Base
                             ,sTipo
                             ,fPeriodo_Pago
                             ,sAnualidad
                             ,fBase_Porcen
                             ,sModulo_Err
                             ,sString_Err
                             ,Result       );
  exit;


  Result := True;
  with dmComunInversiones.QRY_General do
  begin
    Sql.clear;
    Sql.Add('SELECT Cod_Tasa_Base'
           +'      ,Tipo'
           +'      ,Periodo_Pago'
           +'      ,Anualidad'
           +'      ,Base_Porcentual'
           +'  FROM QS_FIN_TASA_CONVER'
           +' WHERE Cod_Tasa_Base = :Cod_Tasa_Base'
           );
    ParamByName('Cod_Tasa_Base').AsString := trim(sCod_Tasa_Base);
    Prepare;
    Open;

    if (FieldByName('Cod_Tasa_Base').AsString <> trim(sCod_Tasa_Base))  or
       (FieldByName('Cod_Tasa_Base').IsNull)                           then
       begin
         sModulo_Err := 'Base Conversion Tasa';
         sString_Err := 'No se encontro Base de Conversión para : '
                        +sCod_Tasa_Base;
         Result := False;
         Close;
         exit;
       end;

    if (FieldByName('Base_Porcentual').AsFloat = 0)  or
       (FieldByName('Base_Porcentual').IsNull)       then
       begin
         sModulo_Err := 'Base Conversion Tasa';
         sString_Err := 'Error en definición de base porcentual para tasa : '
                        +sCod_Tasa_Base+#10
                        +'Base no puede ser igual a 0';
         Result := False;
         Close;
         exit;
       end;


    if (FieldByName('Periodo_Pago').AsFloat = 0)  or
       (FieldByName('Periodo_Pago').IsNull)       then
       begin
         sModulo_Err := 'Base Conversion Tasa';
         sString_Err := 'Error en definición de periodo para tasa : '
                        +sCod_Tasa_Base+#10
                        +'Periodo no puede ser igual a 0';
         Result := False;
         Close;
         exit;
       end;

    sTipo         := FieldByName('Tipo').AsString;
    fPeriodo_Pago := FieldByName('Periodo_Pago').AsFloat;
    sAnualidad    := FieldByName('Anualidad').AsString;
    fBase_Porcen  := FieldByName('Base_Porcentual').AsFloat;

    Close;
  end;  // end with
end;   // Obtener_Base_Conversion
//------------------------------------------------------------------------------
  procedure Decodifica_Nemotecnico_Br(sNemotecnico             : String;
                                      var sTipo_Bono           : String;
                                      var dFecha_Emision,
                                          DFecha_Vencimiento   : TDateTime;
                                      var sModulo_Err          : String;
                                      var sString_Err          : String;
                                      var Result               : Boolean);
var
  wdia,
  wmes,
  wano          : word;
  i             : Integer;
begin
  Result := True;
  sModulo_Err := 'Decodificación Nemotécnico Bono Reconocimiento';

  if length(sNemotecnico) <> 10 then
  begin
     sString_Err := '¡Código Nemotécnico: '''+sNemotecnico+'''.No tiene largo valido';
     {
     strpcopy(aux_pchar
             ,'¡Código Nemotécnico: '''+sNemotecnico+'''.No tiene largo valido');
     Application.MessageBox(aux_pchar
                          ,'Decodificación Nemotécnico BR'
                          , mb_OK + Mb_IconError);
     }
     Result := False;
     exit;
   end;

  // Complemento del Bono
  if (copy(sNemotecnico,1,4) = 'CBR-' ) or
     (copy(sNemotecnico,1,2) = 'CB'   ) then
  begin
     sTipo_Bono     := 'C';
     dFecha_Emision := StrtoDate('30/06/1979');
  end
  else
  begin
     Case sNemotecnico[1] of
          'A'..'C','D','E' : // Bono de Reconocimiento
              begin
                {dia emisión}
                wdia := 1;
                Case sNemotecnico[2] of
                     'A','B','R','D','E','C','L','M','N','O','P','Q','S','T','U','X','1','2','3' :
                     else
                     begin
                        sString_Err := '¡Caractér Nro.2 No es Valido! ('+sNemotecnico+')';
                        {
                        strpcopy(aux_pchar
                                ,'¡Caractér Nro.2 No es Valido!');
                        Application.MessageBox(aux_pchar
                                             ,'Decodificación Nemotécnico BR'
                                             , mb_OK + Mb_IconError);
                        }
                        Result := False;
                        exit;
                     end;
                end;
                {Mes emisión}
                Case sNemotecnico[3] of
                     '1'..'9' : wmes := strtoint(sNemotecnico[3]);
                     '0'      : wmes := 10;
                     'A'      : wmes := 11;
                     'B'      : wmes := 12;
                     else
                        begin
                           sString_Err := '¡Caractér Nro.3 (Mes Emisión). No es Valido! ('+sNemotecnico+')';
                           {
                           strpcopy(aux_pchar
                                   ,'¡Caractér Nro.3 (Mes Emisión). No es Valido!');
                           Application.MessageBox(aux_pchar
                                                ,'Decodificación Nemotécnico BR'
                                                , mb_OK+ Mb_IconError);
                           }
                           Result := False;
                           exit;
                        end;
                end;  {end case mes emisión}
                {Año Emisión}
                if NOT EsNumero(sNemotecnico[2]) then
                begin
                  Case sNemotecnico[4] of
                  '1' : wano := 1981;
                  '2' : wano := 1982;
                  '3' : wano := 1983;
                  '4' : wano := 1984;
                  '5' : wano := 1985;
                  '6' : wano := 1986;
                  '7' : wano := 1987;
                  '8' : wano := 1988;
                  '9' : wano := 1989;
                  '0' : wano := 1990;
                  'A' : wano := 1991;
                  'B' : wano := 1992;
                  'C' : wano := 1993;
                  'D' : wano := 1994;
                  'E' : wano := 1995;
                  'F' : wano := 1996;
                  'G' : wano := 1997;
                  'H' : wano := 1998;
                  'I' : wano := 1999;
                  'J' : wano := 2000;
                  'K' : wano := 2001;
                  'L' : wano := 2002;
                  'M' : wano := 2003;
                  'N' : wano := 2004;
                  'O' : wano := 2005;
                  'P' : wano := 2006;
                  'Q' : wano := 2007;
                  'R' : wano := 2008;
                  'S' : wano := 2009;
                  'T' : wano := 2010;
                  'U' : wano := 2011;
                  else
                      begin
                        Result := False;
                        exit;
                      end;
                  end; {case año emisión}
                end
                else
                begin
                  Case sNemotecnico[4] of
                  '1' : wano := 2017;
                  '2' : wano := 2018;
                  '3' : wano := 2019;
                  '4' : wano := 2020;
                  '5' : wano := 2021;
                  '6' : wano := 2022;
                  '7' : wano := 2023;
                  '8' : wano := 2024;
                  '9' : wano := 2025;
                  '0' : wano := 2026;
                  'A' : wano := 2027;
                  'B' : wano := 2028;
                  'C' : wano := 2029;
                  'D' : wano := 2030;
                  'E' : wano := 2031;
                  'F' : wano := 2032;
                  'G' : wano := 2033;
                  'H' : wano := 2034;
                  'I' : wano := 2035;
                  'J' : wano := 2036;
                  'K' : wano := 2037;
                  'L' : wano := 2038;
                  'M' : wano := 2039;
                  'N' : wano := 2040;
                  'O' : wano := 2041;
                  'P' : wano := 2042;
                  'Q' : wano := 2043;
                  'R' : wano := 2044;
                  'S' : wano := 2044;
                  'T' : wano := 2044;
                  'U' : wano := 2044;
                  'V' : wano := 2044;
                  'W' : wano := 2044;
                  'X' : wano := 2050;
                  'Y' : wano := 2051;
                  'Z' : wano := 2052;
                  else
                      begin
                        Result := False;
                        exit;
                      end;
                  end; {case año emisión}
                End;


                {fecha emisión}
                try
                  dFecha_Emision := encodedate(wano,wmes,wdia)
                except
                  begin
                    sString_Err := 'Fecha de Emisión no es valida ('+sNemotecnico+')';
                    {
                    Application.MessageBox('Fecha de Emisión no es valida'
                                          ,'Decodificación Nemotécnico BR'
                                          , mb_OK+ Mb_IconError);
                    }
                    Result := False;
                    exit;
                  end
                end;
                sTipo_Bono     := 'B';

              end; {end case Bono Reconocimiento}
          else  {else primer caracter no es 'B' ni 'C'}
           begin
              sString_Err := '¡Caractér inicial Nemotécnico: '''+sNemotecnico+'''.No es valido';
              {
              strpcopy(aux_pchar
                     ,'¡Caractér inicial Nemotécnico: '''+sNemotecnico+'''.No es valido');
              Application.MessageBox(aux_pchar
                                   ,'Decodificación Nemotécnico BR'
                                   , mb_OK+ Mb_IconError);
              }
              Result := False;
              exit;
           end;
     end;  {Case}
 end;

{Busco Fecha Vencimiento (Idem para Bono que Complemento}
  for i := 5 to 10 do
    if NOT (sNemotecnico[i] in ['0'..'9']) then
       begin
         sString_Err := '¡Caractér Nro.'+inttostr(i)+'debe ser numerico! ('+sNemotecnico+')';
         {
         strpcopy(aux_pchar
                 ,'¡Caractér Nro.'+inttostr(i)+'debe ser numerico!');
         Application.MessageBox(aux_pchar
                               ,'Decodificación Nemotécnico BR'
                               , mb_OK+ Mb_IconError);
         }
         Result := False;
         exit;
       end;

  {mes vencimiento}
  wmes := strtoint(sNemotecnico[7]+sNemotecnico[8]);
  if NOT wmes in [1..12] then
     begin
       sString_Err := '¡Mes de Vencimiento ('+inttostr(wmes)+').No es valido! ('+sNemotecnico+')';
       {
       strpcopy(aux_pchar
               ,'¡Mes de Vencimiento ('+inttostr(wmes)+').No es valido!');
       Application.MessageBox(aux_pchar
                             ,'Decodificación Nemotécnico BR'
                             , mb_OK+ Mb_IconError);
       }
       Result := False;
       exit;
     end;

  {año vencimiento}
  wano := strtoint(sNemotecnico[9]+sNemotecnico[10]);
  if wano in [80..99] then
     wano := wano + 1900
  else
     wano := wano + 2000;

  {día vencimiento}
  wdia := strtoint(sNemotecnico[5]+sNemotecnico[6]);
  if (wdia < 1) or
     (wdia > ultimo_dia_mes(wmes,wano)) then
     begin
        sString_Err := '¡Día de Vencimiento ('+inttostr(wdia)+').No es valido! ('+sNemotecnico+')';
        {
        strpcopy(aux_pchar
                ,'¡Día de Vencimiento ('+inttostr(wdia)+').No es valido!');
        Application.MessageBox(aux_pchar
                              ,'Decodificación Nemotécnico BR'
                              , mb_OK+ Mb_IconError);
        }
        Result := False;
        exit;
     end;

  {fecha vencimiento}
  try
    dFecha_Vencimiento := encodedate(wano,wmes,wdia)
  except
    begin
      sString_Err := 'Fecha de Vencimiento no es valida ('+sNemotecnico+')';
      {
      Application.MessageBox('Fecha de Vencimiento no es valida'
                            ,'Decodificación Nemotécnico BR'
                            , mb_OK+ Mb_IconError);
      }
      Result := False;
      exit;
    end
  end;
end;
//------------------------------------------------------------------------------
procedure Leer_Instrumento(sInstrumento         : String;
                           var sSi_No_Descriptor : String;
                           var sTasa_Base_Par    : String;
                           var sTasa_Base_Tir    : String;
                           var sFormula_Par      : String;
                           var sFormula_Tir      : String;
                           var Result           : Boolean);
begin
  Result := True;
  if (sInstrumento = '')  or
     (sInstrumento = ' ') then
     begin
        Result := False;
        exit;
     end;

  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Cod_instrumento'
             +'      ,SI_NO_DESCRIPTOR'
             +'      ,TIP_TAS_VALOR_PAR'
             +'      ,TIP_TAS_VALOR_PTE'
             +'      ,COD_CALC_PAR_INS '
             +'      ,COD_CALC_PTE_INS '
             +'  FROM QS_FIN_INSTRUM'
             +' WHERE Cod_Instrumento = :Cod_Instrumento'
             );

      ParamByName('Cod_Instrumento').AsString := trim(sInstrumento);

      Prepare;
      Open;

      if NOT FieldByName('Cod_Instrumento').IsNull then
         begin
           sSi_No_Descriptor := FieldByName('SI_NO_DESCRIPTOR').AsString;
           sTasa_Base_Par    := FieldByName('TIP_TAS_VALOR_PAR').AsString;
           sTasa_Base_Tir    := FieldByName('TIP_TAS_VALOR_PTE').AsString;
           sFormula_Par      := FieldByName('COD_CALC_PAR_INS').AsString;
           sFormula_Tir      := FieldByName('COD_CALC_PTE_INS').AsString;
         end
      else
         Result := False;;
      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
procedure Leer_Nemotecnico_Sin_Descriptor(sNemotecnico   : String;
                                          var sTasa_Base : String;
                                          var sFormula   : String;
                                          var sEmisor    : String;
                                          var Result     : Boolean);
begin
  Result := True;
  if (sNemotecnico = '')  or
     (sNemotecnico = ' ') then
     begin
        Result := False;
        exit;
     end;

  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Nemotecnico'
             +'      ,Tasa_Base'
             +'      ,Formula'
             +'      ,Codigo_Identidad'
             +'  FROM QS_FIN_NEM_RVARI'
             +' WHERE Codigo_Nemotecnico = :Nemotecnico'
             );

      ParamByName('Nemotecnico').AsString := trim(sNemotecnico);

      Prepare;
      Open;

      if NOT FieldByName('Codigo_Nemotecnico').IsNull then
         begin
           sTasa_Base := FieldByName('Tasa_Base').AsString;
           sFormula   := FieldByName('Formula').AsString;
           sEmisor    := FieldByName('Codigo_Identidad').AsString;
         end
      else
         Result := False;;
      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
function Leer_Tipo_Instrumento(sCodigo_Instrumento       : String;
                               var sTIPO_INSTRUMENTO     : String): Boolean;
begin
  Result := True;
  if (sCodigo_Instrumento = '')  or
     (sCodigo_Instrumento = ' ') then
     begin
        Result := False;
        exit;
     end;

    WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Cod_instrumento'
             +'      ,Tipo_Instrumento'
             +'  FROM QS_FIN_INSTRUM'
             +' WHERE Cod_Instrumento = :Cod_Instrumento'
             );

      ParamByName('Cod_Instrumento').AsString := trim(sCodigo_Instrumento);
      Open;

      if NOT FieldByName('Cod_Instrumento').IsNull then
      begin
        sTIPO_INSTRUMENTO := FieldByName('Tipo_instrumento').AsString;
      end
      else
         Result := False;;
      Close;
    end;
end;
//------------------------------------------------------------------------------
function Monto_por_corte(sEmisor,
                         sInstrumento,
                         sSerie        : String;
                         fMonto_Origen : Double;
                     var fCorte        : Double;
                     var sCortes       : String) : Double;
var
  Flag_Buscar : Boolean;
  acum_cortes : Double;
begin
  Flag_Buscar := True;
  sCortes     := '';

  WITH dmComunInversiones.QRY_General do
    While Flag_Buscar do
    begin
      SQL.Clear;
      SQL.Add('SELECT Instrumento'
             +'  FROM QS_FIN_CORTE'
             +' WHERE Emisor      = :Emisor'
             +'   AND Instrumento = :Instrumento'
             +'   AND Serie       = :Serie'
             );

      ParamByName('Emisor').AsString      := sEmisor;
      ParamByName('Instrumento').AsString := sInstrumento;

      if sSerie = '' then
         ParamByName('Serie').AsString := ' '
      else
         ParamByName('Serie').AsString := sSerie;

      Prepare;
      Open;

      if FieldByName('Instrumento').AsString <> sInstrumento then
         begin
           if sSerie <> ' ' then
              sSerie := ' '
           else
              begin
                Result := fMonto_Origen;
                Close;
                UnPrepare;
                exit;
              end;
         end
      else
         Flag_Buscar := False;

      Close;
      UnPrepare;
    end;  // while

  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Corte'
             +'  FROM QS_FIN_CORTE'
             +' WHERE Emisor      = :Emisor'
             +'   AND Instrumento = :Instrumento'
             +'   AND Serie       = :Serie'
             +' ORDER BY Corte DESC'
             );

      ParamByName('Emisor').AsString      := sEmisor;
      ParamByName('Instrumento').AsString := sInstrumento;

      if sSerie = '' then
         ParamByName('Serie').AsString := ' '
      else
         ParamByName('Serie').AsString := sSerie;

      Prepare;
      Open;
      First;

      acum_cortes := 0;
      Result := fMonto_Origen;

      While (fMonto_Origen > 0 ) and NOT EOF do
        begin
          if FieldByName('Corte').AsFloat > 0 then
             begin
               if scortes <> '' then
                  sCortes := sCortes + '-';

               sCortes := sCortes
                         +formatfloat( '###,###,###,###',FieldByName('Corte').AsFloat);

               acum_cortes := acum_cortes +
                             (truncado(Result /
                              FieldByName('Corte').AsFloat,0));

               Result := Result -
                       (FieldByName('Corte').AsFloat *
                        (truncado(Result /
                         FieldByName('Corte').AsFloat,0)));
             end; // if
          Next;
        end;  // While
      Close;
      UnPrepare;

      fCorte := acum_cortes;
      
      if acum_cortes = 0 then
         Result := 0
      else
         Result := fMonto_Origen - Result;
    end; // With
end;  // Monto por Corte

function Vencimiento_variable(sEmisor : String;
                              sInstrumento : String;
                              sSerie       : String) : Boolean;
begin

  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Tipo_Vencimiento'
             +'  FROM QS_FIN_Descriptor'
             +' WHERE Codigo_Emisor = :Codigo_Emisor'
             +'   AND Codigo_Instrumento = :Codigo_Instrumento'
             +'   AND Serie              = :Serie'
             );

      ParamByName('Codigo_Emisor').AsString := sEmisor;
      ParamByName('Codigo_Instrumento').AsString := sInstrumento;
      ParamByName('Serie').AsString := sSerie;

      Prepare;
      Open;
      if FieldByName('Tipo_Vencimiento').AsString = 'VA' then
         Result := True
      else
         Result := False;

      Close;
      Unprepare;
    end;
end;

function Es_Br(sNemotecnico: String): Boolean;
var
  wdia,wmes,wano     : word;
  i                  : Integer;
  dFecha_Vencimiento : TDateTime;
  dFecha_Emision     : TDateTime;
  aux_pchar          : Array[0..250] of Char;
begin
  Result := True;
  if length(sNemotecnico) <> 10 then
  begin
    Result := False;
    exit;
  end;

  // Complemento del Bono
  if (copy(sNemotecnico,1,4) <> 'CBR-') and
     (copy(sNemotecnico,1,2) <> 'CB'  ) then
  begin
     Case sNemotecnico[1] of
      'A'..'C','D' : // Bono de Reconocimiento
           begin
             wdia := 1;
             Case sNemotecnico[2] of
                     'A','B','R','D','E','C','L','M','N','O','P','Q','S','T','U','X' :
                 else
                    begin
                       strpcopy(aux_pchar
                               ,'¡Caractér Nro.2 No es Valido!');
                       Application.MessageBox(aux_pchar
                                            ,Pchar('Decodificación Nemotécnico BR : '+ sNemotecnico)
                                            , mb_OK);
                       Result := False;
                       exit;
                    end;
             end;
             Case sNemotecnico[3] of
             '1'..'9' : wmes := strtoint(sNemotecnico[3]);
             '0'      : wmes := 10;
             'A'      : wmes := 11;
             'B'      : wmes := 12;
             else
               begin
                 Result := False;
                 exit;
               end;
             end;  {end case mes emisión}
             Case sNemotecnico[4] of
             '1' : wano := 1981;
             '2' : wano := 1982;
             '3' : wano := 1983;
             '4' : wano := 1984;
             '5' : wano := 1985;
             '6' : wano := 1986;
             '7' : wano := 1987;
             '8' : wano := 1988;
             '9' : wano := 1989;
             '0' : wano := 1990;
             'A' : wano := 1991;
             'B' : wano := 1992;
             'C' : wano := 1993;
             'D' : wano := 1994;
             'E' : wano := 1995;
             'F' : wano := 1996;
             'G' : wano := 1997;
             'H' : wano := 1998;
             'I' : wano := 1999;
             'J' : wano := 2000;
             'K' : wano := 2001;
             'L' : wano := 2002;
             'M' : wano := 2003;
             'N' : wano := 2004;
             'O' : wano := 2005;
             'P' : wano := 2006;
             'Q' : wano := 2007;
             'R' : wano := 2008;
             'S' : wano := 2009;
             'T' : wano := 2010;
             'U' : wano := 2011;
             else
                 begin
                   Result := False;
                   exit;
                 end;
             end; {case año emisión}

            {fecha emisión}
             try
               dFecha_Emision := encodedate(wano,wmes,wdia)
             except
                begin
                  Result := False;
                  exit;
                end
             end;
           end; {end case Bono Reconocimiento}
       else  {else primer caracter no es 'B' ni 'C'}
         begin
              Result := False;
              exit;
         end;
       end;  {Case}
  end;

  {Busco Fecha Vencimiento (Idem para Bono que Complemento}
  for i := 5 to 10 do
    if NOT (sNemotecnico[i] in ['0'..'9']) then
    begin
      Result := False;
      exit;
    end;

  {mes vencimiento}
  wmes := strtoint(sNemotecnico[7]+sNemotecnico[8]);
  if NOT wmes in [1..12] then
  begin
    Result := False;
    exit;
  end;

  {año vencimiento}
  wano := strtoint(sNemotecnico[9]+sNemotecnico[10]);
  if wano in [80..99] then
     wano := wano + 1900
  else
     wano := wano + 2000;

  {día vencimiento}
  wdia := strtoint(sNemotecnico[5]+sNemotecnico[6]);
  if (wdia < 1) or (wdia > ultimo_dia_mes(wmes,wano)) then
  begin
     Result := False;
     exit;
  end;

  {fecha vencimiento}

  try
    dFecha_Vencimiento := EncodeDate(wano,wmes,wdia)
  except
    begin
      Result := False;
      exit;
    end
  end;
end;
//------------------------------------------------------------------------------
function lee_tasa_mercado(sNemotecnico      : String;
                          sTipo_Instrum     : String;
                          sInstrumento      : String;
                          Registro_Fechas   : TRegistro_Fechas;
                          sTipoTasa         : String;
                          dFecha            : TDateTime;
                      var sOrigen           : String;
                      var fTasaMercado      : Double;
                      var sTipo             : String) : Boolean;
var
  sUnidad,
  sAntes_Despues,
  sEmisor,
  sSerie,
  sEmision_Implicita : String;
//  sInstrumento     : String;
  dFecha_Emision,
  dFecha_Inicial   : TDatetime;
  bResultado       : Boolean;
  fCantidad        : Double;
begin

   fTasaMercado := 0;
   Result       := False;       // Result       := true;   // Solo lee la tasa de Mercado unicamente cuando estaba valorizando, ES 10-06-2010

   //Verifico si es BR y busco TIRMRA
   if sValorizacion_Proceso = 'SI' then
   begin
      if sTipo_Instrum = 'B' then
//      if Es_Nemotecnico_Br( sNemotecnico ) then
         if sTipoTasa = 'BRTASAMERC' then
            Result := lee_tasa_mercado_Mem(sNemotecnico
                                          ,dFecha
                                          ,False
                                          ,sOrigen
                                          ,fTasaMercado
                                          ,sTipo)
         else
            if sTipoTasa = 'TASMERBRTR' then
            begin
               fTasaMercado := Leer_Tir_Mra_2_Mem(sNemotecnico
                                                 ,dFecha
                                                 ,sOrigen
                                                 ,sTipo);
               if fTasaMercado = 0 then  Result := false;
            end
            else
            begin
               fTasaMercado := Leer_Tir_Mra_Mem(sNemotecnico
                                               ,dFecha
                                               ,sOrigen
                                               ,sTipo);
               if fTasaMercado = 0 then  Result := false;
            end
      else
         Result := lee_tasa_mercado_Mem(sNemotecnico
                                       ,dFecha
                                       ,False
                                       ,sOrigen
                                       ,fTasaMercado
                                       ,sTipo);
   end;

   if Result = false then
   begin
      Result := true;
      if (sTipo_Instrum = 'B') AND (sTipoTasa <> 'BRTASAMERC')then
            if sTipoTasa = 'TASMERBRTR' then
            begin
               fTasaMercado := Leer_Tir_Mra_2(sNemotecnico
                                             ,dFecha
                                             ,False // No Busca Hacia Atras
                                             ,sOrigen
                                             ,sTipo);
               if fTasaMercado = 0 then  Result := false;
            end
            else
            begin
               fTasaMercado := Leer_Tir_Mra(sNemotecnico
                                           ,dFecha
                                           ,False // No Busca Hacia Atras
                                           ,sOrigen
                                           ,sTipo);
               if fTasaMercado = 0 then  Result := false;
            end
      else
      begin
//    18-04-2023 F.I.
//         With dmComunInversiones.QRY_General do
//         begin
//            SQL.Clear;
//            SQL.Add(' SELECT Valor'
//                            ,Origen'
//                   +'  FROM QS_FIN_TASA_MERCAD'
//                   +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
//                   +'   AND Fecha              = :Fecha'
//                   +'   AND Origen             = :Origen'
//                   );

        if sOrigen = 'MUL-ORIGEN' then
            With dmComunInversiones.Qry_QS_FIN_TASA_MERCAD_SIN_ORIGEN do
            begin
                ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;
                ParamByName('Fecha').AsDate                := dFecha;
                Open;
                if eof then
                begin
                   fTasaMercado := 0;
                   Result := false;
                end
                else
                begin
                   fTasaMercado := FieldByName('Valor').AsFloat;
                   sOrigen       := FieldByName('Origen').AsString;
                end;
                Close;
             end
        else
            With dmComunInversiones.Qry_QS_FIN_TASA_MERCAD do
            begin
                ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;
                ParamByName('Fecha').AsDate                := dFecha;
                ParamByName('Origen').AsString             := sOrigen;
                Open;
                //if (FieldByName('Valor').IsNull) then
                //   (FieldByName('Valor').AsFloat = 0) then
                if eof then
                begin
                   fTasaMercado := 0;
                   Result := false;
                end
                else
                   fTasaMercado := FieldByName('Valor').AsFloat;
                Close;
             end

      end; // fin if
   end;

   if Result = false then
   begin
      Result := true;
      if sValorizacion_Proceso = 'SI' then
      begin
         if sTipo_Instrum = 'B' then
//         if Es_Nemotecnico_Br( sNemotecnico ) then
            if sTipoTasa = 'BRTASAMERC' then
            begin
{ // E.S. 24-07-2012, por cambios IFRS, desde ahora leera la ultima tasa de mercado que encuentre
               Result := lee_tasa_mercado_Mem(sNemotecnico
                                           ,dFecha
                                           ,False
                                           ,sOrigen
                                           ,fTasaMercado
                                           ,sTipo)
}
               Lee_LastTasa_mercado_Mem(sNemotecnico
                                       ,sOrigen
                                       ,fTasaMercado
                                       ,sTipo);
               if fTasaMercado = 0 then  Result := false;
            end
            else
               if sTipoTasa = 'TASMERBRTR' then
               begin
                  fTasaMercado := Leer_Tir_Mra_2(sNemotecnico
                                                ,dFecha
                                                ,False // No Busca Hacia Atras
                                                ,sOrigen
                                                ,sTipo);
                  if fTasaMercado = 0 then  Result := false;
               end
               else
               begin
                  fTasaMercado := Leer_Tir_Mra(sNemotecnico
                                              ,dFecha
                                              ,False  // No Busca Hacia Atras
                                              ,sOrigen
                                              ,sTipo);
                  if fTasaMercado = 0 then  Result := false;
               end
         else
         begin
            Lee_LastTasa_mercado_Mem(sNemotecnico
                                    ,sOrigen
                                    ,fTasaMercado
                                    ,sTipo);
            if fTasaMercado = 0 then  Result := false;
         end;

         //Busco Tasas por Instrumento si No Encientra Proyección
         if Result = false then
         begin
            Result := true;
            if sImplica_NOMEM = 'S' then
               Leer_Nemotecnico_Emision_Implicita( sNemotecnico
                                                 , ' '
                                                 ,dFecha_Emision
                                                 ,sEmisor
                                                 ,sInstrumento
                                                 ,sSerie
                                                 ,sEmision_Implicita
                                                 ,bResultado )
            else
                  fTasaMercado := Leer_Tasa_Instrumento_Mem(sInstrumento
                                                           ,dFecha
                                                           ,Registro_Fechas.Fecha_Vencimiento
                                                           ,sTipo
                                                           ,sOrigen);
               if fTasaMercado = 0 then
                  Result := false;
         end
      end
      else
      begin
         Busca_Proy_Precio( 'GESTION',
                            fCantidad,
                            sUnidad,
                            sAntes_Despues,
                            bResultado
                           );
         if bResultado then
         begin
            if sAntes_Despues = 'A' then
               dFecha_Inicial := Resta_dias_habiles(sPais_Usuario,
                                                    dFecha,
                                                    fCantidad
                                                    )
            else
               dFecha_Inicial := Suma_dias_habiles(sPais_Usuario,
                                                   dFecha,
                                                   fCantidad
                                                   );

//         18-04-2023 F.I.
//            With dmComunInversiones.QRY_General do
//            begin
////              SQL.Clear;
//              SQL.Add('SELECT Valor'
//                     +'  FROM QS_FIN_TASA_MERCAD'
//                     +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
//                     +'   AND Fecha IN ('
//                     +'                SELECT MAX(Fecha)'
//                     +'                FROM QS_FIN_TASA_MERCAD'
//                     +'                WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
//                     +'                  AND Fecha  BETWEEN :Fecha_Inicial AND :Fecha_Final'
//                     +'                 )'
//                     );

            With dmComunInversiones.Qry_QS_FIN_TASA_MERCAD_2 do
            begin
              ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;
              ParamByName('Fecha_Inicial').AsDate        := dFecha_Inicial;
              ParamByName('Fecha_Final').AsDate          := dFecha;
              Open;
              //if (FieldByName('Valor').IsNull) or
              //   (FieldByName('Valor').AsFloat = 0) then
              if eof then
              begin
                 fTasaMercado := 0;
                 Result       := false;
              end
              else
              begin
                 fTasaMercado := FieldByName('Valor').AsFloat;
                 sOrigen := FieldByName('Origen').AsString;
                 Close;
                 Exit;
              end;
              Close;
            end;
         end;
         // Si no Hay tasa Busco Por Instrumento
         {  // Se agregó Instrumento como parametro de esta funcion, asi puede leer tasas de instrumentos unicos
         Leer_Nemotecnico( sNemotecnico,
                           '',
                           dFecha_Emision,
                           sEmisor,
                           sInstrumento,
                           sSerie,
                           bResultado);
         if bResultado then
         begin }
            fTasaMercado := Leer_Tasa_Instrumento(sInstrumento
                                                 ,dFecha
                                                 ,Registro_Fechas.Fecha_Vencimiento
                                                 ,sOrigen
                                                 ,sTipo  );
            if fTasaMercado = 0 then  Result := false;
//         end;
      end; // end sValorizacion_Proceso
   end;
end;

//------------------------------------------------------------------------------
function lee_precio_mercado(sNemotecnico : String;
                            dFecha       : TDateTime;
                            bBuscar      : Boolean;
                            sOrigen      : String;
                            var fPrecio_Mdo  : Double;
                            var sTipo        : String) : Boolean;
var
  i : Integer;
begin
  Result := True;
  fPrecio_Mdo := 0;
{ Si buscar es True se busca una precio anterior
  se busca por 90 dias hacia atras si no cero }
  i := 90;
  if Not bBuscar then
     i := 1;
  While (i > 0 ) do
  begin
      With dmComunInversiones.QRY_General do
      begin
        SQL.Clear;
        SQL.Add('SELECT Valor, Tipo'
               +'  FROM QS_FIN_PREC_MERCAD'
               +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
               +'   AND Fecha              = :Fecha');
        if sOrigen <> 'MUL-ORIGEN' then
        begin
          SQL.Add(' AND Origen             = :Origen');
          ParamByName('Origen').AsString             := sOrigen;
        end;

        ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;
        ParamByName('Fecha').AsDate                := dFecha;
        Prepare;
        Open;

        if (FieldByName('Valor').IsNull) then
           Result := False
        else
        begin
          fPrecio_Mdo := FieldByName('Valor').AsFloat;
          sTipo       := FieldByName('Tipo').AsString;
          Result := True;
          i      := 1;
        end;
        Close;
        UnPrepare;
      end;
      dFecha := dFecha - 1;
      Dec(i);
  end;{while}
end;
//------------------------------------------------------------------------------
function lee_precio_titulo(sNemotecnico : String;
                           dFecha       : TDateTime;
                           sOrigen      : String;
                           bBuscar      : Boolean) : Double;
var
  i : Integer;
begin
  Result := 0;
{ Si buscar es True se busca una precio de titulo anterior
  se busca por 90 dias hacia atras si no cero }
  i := 90;
  if Not bBuscar then
     i := 1;
  While (i > 0 ) do
    begin
      With dmComunInversiones.QRY_General do
         begin
           SQL.Clear;
           SQL.Add('SELECT Valor'
                  +'  FROM QS_FIN_PREC_TITULO'
                  +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
                  +'   AND Fecha              = :Fecha');
            if sOrigen <> 'MUL-ORIGEN' then
                begin
                  SQL.Add(' AND Origen             = :Origen');
                  ParamByName('Origen').AsString             := sOrigen;
                end;

           ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;
           ParamByName('Fecha').AsDate                := dFecha;
           Prepare;
           Open;

           if (FieldByName('Valor').IsNull) or
              (FieldByName('Valor').AsFloat = 0) then
              Result := 0
           else
              begin
                Result := FieldByName('Valor').AsFloat;
                i      := 1;
              end;
           Close;
           UnPrepare;
         end;
         dFecha := dFecha - 1;
         Dec(i);
    end;{while}
end;
//------------------------------------------------------------------------------
function Nominales_Vendidos_Antes(sEmpresa         : String;
                                  sFolio           : String;
                                  sTransaccion     : String;
                                  fItem_Omd        : Double;
                                  dFecha_Operacion : TDateTime;
                                  dFecha_Hora      : TDateTime) : Double;
begin
  WITH dmComunInversiones.Qry_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM(a.Valor_Nominal) as Valor_Nominal');
    SQL.Add(' FROM QS_TRA_OMD_DET_RF a, ');
    SQL.Add('      QS_TRA_OMD d');
    SQL.Add(' WHERE a.Folio_Interno_Rel       = :Folio');
    SQL.Add('   AND a.Transaccion_Rel   = :Transaccion');
    SQL.Add('   AND a.Item_Omd_Rel = :Folio');
    SQL.Add('   AND a.Empresa_Rel      = :Empresa');
    SQL.Add('   AND a.Transaccion not in (SELECT b.Codigo_Transaccion');
    SQL.Add('                               FROM qs_sys_tran_implic b ');
    SQL.Add('                             WHERE b.Codigo_transaccion = a.transaccion');
    SQL.Add('                               AND b.implicancia = '''+'PACTO'+''')');
    SQL.Add('   AND a.Transaccion     in (SELECT c.Codigo_Transaccion');
    SQL.Add('                               FROM qs_sys_tran_implic c ');
    SQL.Add('                             WHERE c.Codigo_transaccion = a.transaccion');
    SQL.Add('                               AND c.implicancia = '''+'VENTA'+''')');
    SQL.Add('   AND a.Folio_Interno not in (SELECT f.Folio ');
    SQL.Add('                               FROM qs_ctr_anulacion f');
    SQL.Add('                             WHERE f.empresa     = a.empresa');
    SQL.Add('                               AND f.transaccion = a.Transaccion');
    SQL.Add('                               AND f.Folio       = a.Folio_interno)');
    SQL.Add('   AND d.Folio_Interno     = a.Folio_Interno ');
    SQL.Add('   AND d.Transaccion       = a.Transaccion ');
    SQL.Add('   AND d.empresa           = a.empresa ');
    SQL.Add('   AND d.Fecha_Operacion  <=  :Fecha_Operacion ' );
    SQL.Add('   AND d.Fecha_Hora        <   :Fecha_Hora ' );


     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := fItem_Omd;
     ParamByName('Fecha_Operacion').AsDate := dFecha_Operacion;
     ParamByName('Fecha_Hora').AsDate      := dFecha_Hora;
     Prepare;
     Open;
     if FieldByName('Valor_Nominal').IsNull then
           Result := 0
     else
           Result := FieldByName('Valor_Nominal').AsFloat;
    Close;
    UnPrepare;
  end;
end;
//------------------------------------------------------------------------------
procedure Determina_Nominales_Vendidos(dFecha_Valorizacion :TDateTime;
                                       sEmpresa        :String;
                                       sTransaccion    :String;
                                       sFolio          :String;
                                       dItem_omd       :Double;
                                   var Nominales_Ventas: Double);
begin
  WITH dmComunInversiones.Qry_Ventas do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM(a.Valor_Nominal) as Valor_Nominal'
           +' FROM QS_TRA_OMD_DET_RF a, '
           +'      QS_TRA_OMD d'
           +' WHERE a.Folio_Interno_Rel = :Folio'
           +'   AND a.Transaccion_Rel   = :Transaccion'
           +'   AND a.Item_Omd_Rel      = :Item'
           +'   AND a.Empresa_Rel       = :Empresa');

    SQL.Add('   AND a.Transaccion not in (SELECT b.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic b '
           +'                             WHERE b.Codigo_transaccion = a.transaccion'
           +'                               AND b.implicancia = '''+'PACTO'+''')');
    SQL.Add('   AND a.Transaccion     in (SELECT c.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic c '
           +'                             WHERE c.Codigo_transaccion = a.transaccion'
           +'                               AND c.implicancia = '''+'VENTA'+''')');
    SQL.Add('   AND a.Folio_Interno not in (SELECT f.Folio '
           +'                               FROM qs_ctr_anulacion f'
           +'                             WHERE f.empresa     = a.empresa'
           +'                               AND f.transaccion = a.Transaccion'
           +'                               AND f.Folio       = a.Folio_interno)');
    SQL.Add('   AND d.Folio_Interno     = a.Folio_Interno '   );
    SQL.Add('   AND d.Transaccion       = a.Transaccion '     );
    SQL.Add('   AND d.empresa           = a.empresa '         );
    SQL.Add('   AND d.Fecha_Operacion   <=  :Fecha '          );

     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := dItem_Omd;
     ParamByName('Fecha').AsDate         := dFecha_Valorizacion;
     Prepare;
     Open;
     if FieldByName('Valor_Nominal').IsNull then
           Nominales_Ventas := 0
     else
           Nominales_Ventas := FieldByName('Valor_Nominal').AsFloat;
    Close;
    UnPrepare;
    // Se hace porque con mas decimales daba problemas en la comparacion
    // Filigara: Si lo sacan me da problemas en GAAP .... Avisenme !!!!
    Nominales_Ventas := redondeo(Nominales_Ventas,10);
  end;
end;//Determina nominales vendidos
//------------------------------------------------------------------------------
procedure Determina_Nominales_Vendidos_Periodo(dFecha_Desde    : TDateTime;
                                               dFecha_Hasta    : TDateTime;
                                               sEmpresa        : String;
                                               sTransaccion    : String;
                                               sFolio          : String;
                                               dItem_omd       : Double;
                                               var Nominales_Ventas    : Double;
                                               var fValor_Invertido_MC : Double);
begin
  WITH dmComunInversiones.Qry_Ventas do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM(a.Valor_Nominal) as Valor_Nominal'
           +'      ,SUM(a.Valor_Invertido_MC) as Valor_Invertido_MC'
           +' FROM QS_TRA_OMD_DET_RF a, '
           +'      QS_TRA_OMD d'
           +' WHERE a.Folio_Interno_Rel = :Folio'
           +'   AND a.Transaccion_Rel   = :Transaccion'
           +'   AND a.Item_Omd_Rel      = :Item'
           +'   AND a.Empresa_Rel       = :Empresa');

    SQL.Add('   AND a.Transaccion not in (SELECT b.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic b '
           +'                             WHERE b.Codigo_transaccion = a.transaccion'
           +'                               AND b.implicancia = '''+'PACTO'+''')');
    SQL.Add('   AND a.Transaccion     in (SELECT c.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic c '
           +'                             WHERE c.Codigo_transaccion = a.transaccion'
           +'                               AND c.implicancia = '''+'VENTA'+''')');
    SQL.Add('   AND a.Folio_Interno not in (SELECT f.Folio '
           +'                               FROM qs_ctr_anulacion f'
           +'                             WHERE f.empresa     = a.empresa'
           +'                               AND f.transaccion = a.Transaccion'
           +'                               AND f.Folio       = a.Folio_interno)');

    SQL.Add('   AND d.empresa           = a.empresa '
           +'   AND d.Transaccion       = a.Transaccion '
           +'   AND d.Folio_Interno     = a.Folio_Interno '
           +'   AND d.Fecha_Operacion   >   :FechaDesde '
           +'   AND d.Fecha_Operacion   <=  :FechaHasta ' );

     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := dItem_Omd;
     ParamByName('FechaDesde').AsDate := dFecha_Desde;
     ParamByName('FechaHasta').AsDate := dFecha_Hasta;
     Prepare;
     Open;
     if FieldByName('Valor_Nominal').IsNull then
        begin
           Nominales_Ventas    := 0;
           fValor_Invertido_MC := 0;
        end
     else
        begin
           Nominales_Ventas    := FieldByName('Valor_Nominal').AsFloat;
           fValor_Invertido_MC := FieldByName('Valor_Invertido_MC').AsFloat;
        end;
    Close;
    UnPrepare;
  end;
end;//Determina nominales vendidos en Periodo
//------------------------------------------------------------------------------

procedure Determina_Nominales_Vendidos_Por_Dia(dFecha_Dia    : TDateTime;
                                               sEmpresa        : String;
                                               sTransaccion    : String;
                                               sFolio          : String;
                                               dItem_omd       : Double;
                                               var Nominales_Ventas    : Double);
begin
  WITH dmComunInversiones.Qry_Ventas do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM(a.Valor_Nominal) as Valor_Nominal'
           +'      ,SUM(a.Valor_Invertido_MC) as Valor_Invertido_MC'
           +' FROM QS_TRA_OMD_DET_RF a, '
           +'      QS_TRA_OMD d'
           +' WHERE a.Folio_Interno_Rel = :Folio'
           +'   AND a.Transaccion_Rel   = :Transaccion'
           +'   AND a.Item_Omd_Rel      = :Item'
           +'   AND a.Empresa_Rel       = :Empresa');
    SQL.Add('   AND a.Transaccion not in (SELECT b.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic b '
           +'                             WHERE b.Codigo_transaccion = a.transaccion'
           +'                               AND b.implicancia = '''+'PACTO'+''')');
    SQL.Add('   AND a.Transaccion     in (SELECT c.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic c '
           +'                             WHERE c.Codigo_transaccion = a.transaccion'
           +'                               AND c.implicancia = '''+'VENTA'+''')');
    SQL.Add('   AND a.Folio_Interno not in (SELECT f.Folio '
           +'                               FROM qs_ctr_anulacion f'
           +'                             WHERE f.empresa     = a.empresa'
           +'                               AND f.transaccion = a.Transaccion'
           +'                               AND f.Folio       = a.Folio_interno)');

    SQL.Add('   AND d.empresa           = a.empresa '
           +'   AND d.Transaccion       = a.Transaccion '
           +'   AND d.Folio_Interno     = a.Folio_Interno '
           +'   AND d.Fecha_Operacion   =  :FechaDia ');

     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := dItem_Omd;
     ParamByName('FechaDia').AsDate := dFecha_Dia;
     Prepare;
     Open;
     if FieldByName('Valor_Nominal').IsNull then
        begin
           Nominales_Ventas    := 0;
        end
     else
        begin
           Nominales_Ventas    := FieldByName('Valor_Nominal').AsFloat;
        end;
    Close;
    UnPrepare;
  end;
end;//Determina nominales vendidos en Periodo

function Determina_Nro_Titulos(sEmpresa        : String;
                               sTransaccion    : String;
                               sFolio          : String;
                               fItem_omd       : Double;
                               dFecha          : TDateTime) : Double;
begin
  WITH dmComunInversiones.Qry_Ventas do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM(b.Numero_Titulos) Numero_Titulos');
    SQL.Add(' FROM QS_TRA_OMD_DET_PP_REALLO b');
    SQL.Add('     ,QS_TRA_OMD_DET_RF e');
    SQL.Add('     ,QS_TRA_OMD d');
    SQL.Add(' WHERE e.Folio_Interno = :Folio');
    SQL.Add('   AND e.Transaccion   = :Transaccion');
    SQL.Add('   AND e.Item_Omd      = :Item');
    SQL.Add('   AND e.Empresa       = :Empresa');
    SQL.Add('   AND e.Folio_Interno not in (SELECT f.Folio ');
    SQL.Add('                               FROM qs_ctr_anulacion f');
    SQL.Add('                             WHERE f.Folio       = e.Folio_interno');
    SQL.Add('                               AND f.transaccion = e.Transaccion');
    SQL.Add('                               AND f.empresa     = e.empresa)');
    SQL.Add('   AND e.Transaccion not in (SELECT b.Codigo_Transaccion');
    SQL.Add('                               FROM qs_sys_tran_implic b ');
    SQL.Add('                              WHERE b.Codigo_transaccion = e.transaccion');
    SQL.Add('                                AND b.implicancia = '''+'PACTO'+''')');
    SQL.Add('   AND e.Transaccion     in (SELECT c.Codigo_Transaccion');
    SQL.Add('                               FROM qs_sys_tran_implic c ');
    SQL.Add('                             WHERE c.Codigo_transaccion = e.transaccion');
    SQL.Add('                               AND c.implicancia = '''+'COMPRA'+''')');
    SQL.Add('   AND e.Folio_Interno     = d.Folio_Interno ');
    SQL.Add('   AND e.Transaccion       = d.Transaccion ');
    SQL.Add('   AND e.empresa           = d.empresa ');
    SQL.Add('   AND d.Fecha_Operacion  <=  :Fecha ' );
    SQL.Add('   AND e.Folio_Interno     = b.Folio_Interno');
    SQL.Add('   AND e.Transaccion       = b.Transaccion');
    SQL.Add('   AND e.Item_Omd          = b.Item_Omd');
    SQL.Add('   AND e.empresa           = b.empresa ');


     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := fItem_Omd;
     ParamByName('Fecha').AsDate         := dFecha;

     Open;

     if FieldByName('Numero_Titulos').IsNull then
        Result := 0
     else
        Result := FieldByName('Numero_Titulos').AsFloat;
    Close;

  end;
end;//Determina_Nro_Titulos

function Determina_Titulos_Vendidos(sEmpresa        : String;
                                    sTransaccion    : String;
                                    sFolio          : String;
                                    fItem_omd       : Double;
                                    dFecha          : TDateTime) : Double;
begin
  WITH dmComunInversiones.Qry_Determina_Titulos_Vendidos do
  begin
//    SQL.Clear;
//    SQL.Add('SELECT SUM(b.Numero_Titulos) Numero_Titulos');
//    SQL.Add(' FROM QS_TRA_OMD_DET_PP b');
//    SQL.Add('     ,QS_TRA_OMD_DET_RF e');
//    SQL.Add('     ,QS_TRA_OMD d');
//    SQL.Add(' WHERE e.Folio_Interno_Rel = :Folio');
//    SQL.Add('   AND e.Transaccion_Rel   = :Transaccion');
//    SQL.Add('   AND e.Item_Omd_Rel      = :Item');
//    SQL.Add('   AND e.Empresa_Rel       = :Empresa');
//    SQL.Add('   AND e.Folio_Interno not in (SELECT f.Folio ');
//    SQL.Add('                               FROM qs_ctr_anulacion f');
//    SQL.Add('                             WHERE f.Folio       = e.Folio_interno');
//    SQL.Add('                               AND f.transaccion = e.Transaccion');
//    SQL.Add('                               AND f.empresa     = e.empresa)');
//    SQL.Add('   AND e.Transaccion not in (SELECT b.Codigo_Transaccion');
//    SQL.Add('                               FROM qs_sys_tran_implic b ');
//    SQL.Add('                              WHERE b.Codigo_transaccion = e.transaccion');
//    SQL.Add('                                AND b.implicancia = '''+'PACTO'+''')');
//    SQL.Add('   AND e.Transaccion     in (SELECT c.Codigo_Transaccion');
//    SQL.Add('                               FROM qs_sys_tran_implic c ');
//    SQL.Add('                             WHERE c.Codigo_transaccion = e.transaccion');
//    SQL.Add('                               AND c.implicancia = '''+'VENTA'+''')');
//    SQL.Add('   AND e.Folio_Interno     = d.Folio_Interno ');
//    SQL.Add('   AND e.Transaccion       = d.Transaccion ');
//    SQL.Add('   AND e.empresa           = d.empresa ');
//    SQL.Add('   AND d.Fecha_Operacion  <=  :Fecha ' );
//    SQL.Add('   AND e.Folio_Interno     = b.Folio_Interno');
//    SQL.Add('   AND e.Transaccion       = b.Transaccion');
//    SQL.Add('   AND e.Item_Omd          = b.Item_Omd');
//    SQL.Add('   AND e.empresa           = b.empresa ');
//

     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := fItem_Omd;
     ParamByName('Fecha').AsDate     := dFecha;
     Open;

     if FieldByName('Numero_Titulos').IsNull then
           Result := 0
     else
           Result := FieldByName('Numero_Titulos').AsFloat;
    Close;
  end;
end;//Determina Titulos Vendidos

//------------------------------------------------------------------------------
procedure Determina_Nominales_Pactados(dFecha_Valorizacion :TDateTime;
                                       sEmpresa        :String;
                                       sTransaccion    :String;
                                       sFolio          :String;
                                       dItem_omd       :Double;
                                   var Nominales_Pactos: Double);
begin
  WITH dmComunInversiones.Qry_Ventas do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM(a.Valor_Nominal) as Valor_Nominal'
           +' FROM QS_TRA_OMD_DET_RF a, '
           +'      QS_TRA_OMD d'
           +' WHERE a.Folio_Interno_Rel = :Folio'
           +'   AND a.Transaccion_Rel   = :Transaccion'
           +'   AND a.Item_Omd_Rel      = :Item'
           +'   AND a.Empresa_Rel       = :Empresa');
    SQL.Add('   AND a.Transaccion    in (SELECT b.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic b '
           +'                             WHERE b.Codigo_transaccion = a.transaccion'
           +'                               AND b.implicancia = '''+'PACTO'+''')');
    SQL.Add('   AND a.Transaccion     in (SELECT c.Codigo_Transaccion'
           +'                               FROM qs_sys_tran_implic c '
           +'                             WHERE c.Codigo_transaccion = a.transaccion'
           +'                               AND c.implicancia = '''+'VENTA'+''')');
    SQL.Add('   AND a.Folio_Interno not in (SELECT f.Folio '
           +'                               FROM qs_ctr_anulacion f'
           +'                             WHERE f.Folio       = a.Folio_interno'
           +'                               AND f.transaccion = a.Transaccion'
           +'                               AND f.empresa     = a.empresa)'
           +'   AND d.Folio_Interno     = a.Folio_Interno '
           +'   AND d.Transaccion       = a.Transaccion ');
    SQL.Add('   AND d.empresa           = a.empresa '
           +'   AND d.Fecha_Vcto_Pacto  >  :Fecha ' );
    SQL.Add('   AND d.Fecha_Operacion   <= :Fecha');

     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := dItem_Omd;
     ParamByName('Fecha').AsDate     := dFecha_Valorizacion;
     Prepare;
     Open;
     if FieldByName('Valor_Nominal').IsNull then
           Nominales_Pactos := 0
     else
           Nominales_Pactos := FieldByName('Valor_Nominal').AsFloat;
    Close;
    UnPrepare;
  end;
end;//Determina nominales Pactados
//------------------------------------------------------------------------------
Procedure Carga_Descriptor(sEmisor      : String;
                           sInstrumento : String;
                           sSerie       : String;
                       var Registro     : TReg_descriptor;
                       var Modulo_Err   : String;
                       var String_Err   : String;
                       var Result       : Boolean );
var
  bTasa_Depende_Periodos : Boolean;
  fPeriodos              : Double;
begin
  // Si encuentro que estan cargados en memoria no acceso las tablas
  if VarIsArray(Reg_Descriptores.CODIGO_Instrumento) then
  begin
     Carga_Descriptor_Mem(sEmisor
                         ,sInstrumento
                         ,sSerie
                         ,Registro
                         ,Modulo_Err
                         ,String_Err
                         ,Result);
     if result then
        exit;
  end;

  Result := True;
  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT *'
             +'  FROM QS_FIN_DESCRIPTOR'
             +' WHERE Serie              = :Serie'
             +'   AND Codigo_Emisor      = :Emisor'
             +'   AND Codigo_Instrumento = :Instrumento'
             );
      ParamByName('Emisor').AsString      := sEmisor;
      ParamByName('Instrumento').AsString := sInstrumento;
      ParamByName('Serie').AsString       := sSerie;
      Prepare;
      Open;
      If EOF then
         begin
           Result := False;
           Modulo_Err := 'Lectura de Descriptor';
           String_Err := 'No existe descriptor para: '
                         +sEmisor+' - '
                         +sInstrumento+' - '
                         +sSerie;
           Close;
         end
      else
         begin
          Registro.CODIGO_EMISOR      := FieldByName('CODIGO_EMISOR').AsString;
	        Registro.CODIGO_INSTRUMENTO := FieldByName('CODIGO_INSTRUMENTO').AsString;
	        Registro.SERIE              := FieldByName('SERIE').AsString;
	        Registro.SERIE_BOLSA        := FieldByName('SERIE_BOLSA').AsString;
	        Registro.FECHA_EMISION      := FieldByName('FECHA_EMISION').Asdatetime;
	        Registro.TASA_EMISION       := FieldByName('TASA_EMISION').AsFloat;
	        Registro.TASA_EFECTIVA      := FieldByName('TASA_EFECTIVA').AsFloat;
	        Registro.TASA_VALOR_PAR     := FieldByName('TASA_VALOR_PAR').AsString;
	        Registro.TASA_VALOR_PTE     := FieldByName('TASA_VALOR_PTE').AsString;
	        Registro.UNIDAD_MON         := FieldByName('UNIDAD_MON').AsString;
	        Registro.PLAZO_EN_ANOS      := FieldByName('PLAZO_EN_ANOS').AsFloat;
	        Registro.TIPO_AMORTIZAC     := FieldByName('TIPO_AMORTIZAC').AsString;
	        Registro.NRO_CUPONES        := FieldByName('NRO_CUPONES').AsFloat;
	        Registro.PERIODO_PAGO       := FieldByName('PERIODO_PAGO').AsFloat;
	        Registro.TIPO_VENCIMIENTO   := FieldByName('TIPO_VENCIMIENTO').AsString;
	        Registro.DIA_VENCIMIENTO    := FieldByName('DIA_VENCIMIENTO').AsFloat;
	        Registro.DECIMAL_AJUSTE     := FieldByName('DECIMAL_AJUSTE').AsFloat;
	        Registro.TIPO_AJUSTE        := FieldByName('TIPO_AJUSTE').AsString;
	        Registro.BASE_ORIGINAL      := FieldByName('BASE_ORIGINAL').AsFloat;
	        Registro.BASE_CONVERSION    := FieldByName('BASE_CONVERSION').AsFloat;
	        Registro.COD_CALC_PAR_D     := FieldByName('COD_CALC_PAR_D').AsString;
	        Registro.COD_CALC_TIR_D     := FieldByName('COD_CALC_TIR_D').AsString;
	        Registro.COD_CALC_PAR_D_OLD := FieldByName('COD_CALC_PAR_D').AsString;
	        Registro.COD_CALC_TIR_D_OLD := FieldByName('COD_CALC_TIR_D').AsString;
	        Registro.OPCION_PREPAGO     := FieldByName('OPCION_PREPAGO').AsString;
          if FieldByName('FECHA_PREPAGO').IsNull then
             Registro.FECHA_PREPAGO      := 0
          else
             Registro.FECHA_PREPAGO      := FieldByName('FECHA_PREPAGO').Asdatetime;
          if FieldByName('PRECIO_PREPAGO').IsNull then
             Registro.PRECIO_PREPAGO     := 0
          else
             Registro.PRECIO_PREPAGO     := FieldByName('PRECIO_PREPAGO').AsFloat;
	        Registro.TASA_FLOTANTE      := FieldByName('TASA_FLOTANTE').AsString;
	        Registro.TIPO_NOMINALES     := FieldByName('TIPO_NOMINALES').AsString;
	        Registro.FECHAS_SINO        := FieldByName('FECHAS_SINO').AsString;
	        Registro.TIPO_PAGO          := FieldByName('TIPO_PAGO').AsString;
          Registro.PERIODO_GRACIA     := FieldByName('Periodo_Gracia').AsFloat;
          Registro.fCupones_Cortados  := 0;

          Close;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) As Num_Regs                        ');
          SQL.Add('  FROM QS_FIN_EXCP_VARCAM                          ');
          SQL.Add(' WHERE Codigo_Emisor      = :Emisor                ');
          SQL.Add('   AND Codigo_Instrumento = :Instrumento           ');
          SQL.Add('   AND Serie              = :Serie                 ');

          ParamByName('Emisor'     ).AsString := sEmisor;
          ParamByName('Instrumento').AsString := sInstrumento;
          ParamByName('Serie'      ).AsString := sSerie;

          Open;
          if FieldByName('Num_Regs').AsInteger > 0 then
             Registro.Variacion_Cambiaria := True
          else
             Registro.Variacion_Cambiaria := False;
          Close;

          if Registro.TASA_FLOTANTE = 'S' then
          begin
             SQL.Clear;
             SQL.Add('SELECT COUNT(*) As Num_Regs                        ');
             SQL.Add('  FROM QS_FIN_DEF_DESFLOT                          ');
             SQL.Add(' WHERE SERIE              = :Serie                 ');
             SQL.Add('   AND CODIGO_INSTRUMENTO = :Instrumento           ');
             SQL.Add('   AND CODIGO_IDENTIDAD   = :Emisor                ');
             SQL.Add('   AND TIPO_TASA is NOT NULL                       ');
             if (sDriver = 'ORACLE') then
                SQL.Add('   AND TIPO_TASA <> '' ''                         ')
             else
                SQL.Add('   AND TIPO_TASA <> ''''                         ');

             ParamByName('Emisor'     ).AsString := sEmisor;
             ParamByName('Instrumento').AsString := sInstrumento;
             ParamByName('Serie'      ).AsString := sSerie;

             Open;
             if FieldByName('Num_Regs').AsInteger = 0 then
                Registro.bSin_Tasa_en_Flujos := True
             else
                Registro.bSin_Tasa_en_Flujos := False;
             Close;
          end
          else
            Registro.bSin_Tasa_en_Flujos := True;

         end;
      // Verifico base Variable
      SQL.Clear;
      SQL.Add('SELECT TASA_DEPENDE_PERIODOS          ');
      SQL.Add('  FROM QS_FIN_TASA_BASE_VARIABLE      ');
      SQL.Add(' WHERE COD_TASA_BASE = :COD_TASA_BASE ');

      ParamByName('COD_TASA_BASE').AsString := Registro.TASA_VALOR_PAR;

      bTasa_Depende_Periodos := False;
      try
        Open;
        if FieldByName('TASA_DEPENDE_PERIODOS').AsString = 'S' then
           bTasa_Depende_Periodos := True;
        Close;
      except
           bTasa_Depende_Periodos := False;
      end;

      if bTasa_Depende_Periodos then
      begin
         if Registro.PERIODO_PAGO = 0 then
            fPeriodos := 1
         else
            fPeriodos := 12 / Registro.PERIODO_PAGO;
        Registro.TASA_EFECTIVA := Registro.TASA_EFECTIVA / fPeriodos;
      end;
    end;
end;
//------------------------------------------------------------------------------
Procedure Carga_Descriptor_Vig(sEmisor      : String;
                               sInstrumento : String;
                               sSerie       : String;
                               dFecha_Vig   : TDateTime;
                           var Registro     : TReg_descriptor;
                           var Modulo_Err   : String;
                           var String_Err   : String;
                           var Result       : Boolean );
var
  bTasa_Depende_Periodos : Boolean;
  fPeriodos              : Double;
  iNro_Cupones           : Integer;
begin
  // Si encuentro que estan cargados en memoria no acceso las tablas
  if VarIsArray(Reg_Descriptores.CODIGO_Instrumento) then
  begin
     Carga_Descriptor_Vig_Mem(sEmisor
                             ,sInstrumento
                             ,sSerie
                             ,dFecha_Vig
                             ,Registro
                             ,Modulo_Err
                             ,String_Err
                             ,Result);
     if result then
        exit;
  end;

  Result := True;
  WITH dmComunInversiones.QRY_General,Registro do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.*'
             +'  FROM QS_FIN_DESCRIPTOR a'
             +' WHERE a.Serie              = :Serie'
             +'   AND a.Codigo_Emisor      = :Emisor'
             +'   AND a.Codigo_Instrumento = :Instrumento'
             +'   AND a.Tasa_Valor_PAR    <> ''TIX''');
      if sDriver = 'ORACLE' then
         SQL.Add('   AND TRUNC(a.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))')
      else
         SQL.Add('   AND CONVERT(CHAR(10),a.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
      SQL.Add('                         FROM qs_fin_descriptor x'
             +'                        WHERE x.Serie              = a.Serie'
             +'                          AND x.Codigo_Instrumento = a.Codigo_Instrumento'
             +'                          AND x.Codigo_Emisor      = a.Codigo_Emisor'
             +'                          AND x.Tasa_Valor_PAR     <> ''TIX'''
             +'      	       	         AND x.Fecha_Vig    <= :Fecha_Vig)'
             );
      ParamByName('Emisor').AsString          := sEmisor;
      ParamByName('Instrumento').AsString     := sInstrumento;
      ParamByName('Serie').AsString           := sSerie;
      ParamByName('Fecha_Vig').AsDate   := dFecha_Vig;
      Prepare;
      Open;
      If EOF then
         begin
           Result := False;
           Modulo_Err := 'Lectura de Descriptor';
           String_Err := 'No existe descriptor para: '
                         +sEmisor+' - '
                         +sInstrumento+' - '
                         +sSerie+' - '
                         +DateToStr(dFecha_Vig);
           Close;
         end
      else
         begin
          CODIGO_EMISOR      := FieldByName('CODIGO_EMISOR').AsString;
	  CODIGO_INSTRUMENTO := FieldByName('CODIGO_INSTRUMENTO').AsString;
	  SERIE              := FieldByName('SERIE').AsString;
	  Fecha_Vig          := FieldByName('Fecha_Vig').Asdatetime;
	  SERIE_BOLSA        := FieldByName('SERIE_BOLSA').AsString;
	  FECHA_EMISION      := FieldByName('FECHA_EMISION').Asdatetime;
	  TASA_EMISION       := FieldByName('TASA_EMISION').AsFloat;
	  TASA_EFECTIVA      := FieldByName('TASA_EFECTIVA').AsFloat;
	  TASA_VALOR_PAR     := FieldByName('TASA_VALOR_PAR').AsString;
	  TASA_VALOR_PTE     := FieldByName('TASA_VALOR_PTE').AsString;
	  UNIDAD_MON         := FieldByName('UNIDAD_MON').AsString;
	  PLAZO_EN_ANOS      := FieldByName('PLAZO_EN_ANOS').AsFloat;
	  TIPO_AMORTIZAC     := FieldByName('TIPO_AMORTIZAC').AsString;
	  NRO_CUPONES        := FieldByName('NRO_CUPONES').AsFloat;
	  PERIODO_PAGO       := FieldByName('PERIODO_PAGO').AsFloat;
	  TIPO_VENCIMIENTO   := FieldByName('TIPO_VENCIMIENTO').AsString;
	  DIA_VENCIMIENTO    := FieldByName('DIA_VENCIMIENTO').AsFloat;
	  DECIMAL_AJUSTE     := FieldByName('DECIMAL_AJUSTE').AsFloat;
	  TIPO_AJUSTE        := FieldByName('TIPO_AJUSTE').AsString;
	  BASE_ORIGINAL      := FieldByName('BASE_ORIGINAL').AsFloat;
	  BASE_CONVERSION    := FieldByName('BASE_CONVERSION').AsFloat;
	  COD_CALC_PAR_D     := FieldByName('COD_CALC_PAR_D').AsString;
	  COD_CALC_TIR_D     := FieldByName('COD_CALC_TIR_D').AsString;
	  COD_CALC_PAR_D_OLD := FieldByName('COD_CALC_PAR_D').AsString;
	  COD_CALC_TIR_D_OLD := FieldByName('COD_CALC_TIR_D').AsString;
	  OPCION_PREPAGO     := FieldByName('OPCION_PREPAGO').AsString;
          if FieldByName('FECHA_PREPAGO').IsNull then
             FECHA_PREPAGO      := 0
          else
             FECHA_PREPAGO      := FieldByName('FECHA_PREPAGO').Asdatetime;

          if FindField('PRECIO_PREPAGO') <> Nil then
          begin
            if FieldByName('PRECIO_PREPAGO').IsNull then
               PRECIO_PREPAGO     := 0
            else
               PRECIO_PREPAGO     := FieldByName('PRECIO_PREPAGO').AsFloat;
          end
          else
            PRECIO_PREPAGO     := 0;

	  TASA_FLOTANTE      := FieldByName('TASA_FLOTANTE').AsString;
	  TIPO_NOMINALES     := FieldByName('TIPO_NOMINALES').AsString;
	  FECHAS_SINO        := FieldByName('FECHAS_SINO').AsString;
	  TIPO_PAGO          := FieldByName('TIPO_PAGO').AsString;
          PERIODO_GRACIA     := FieldByName('Periodo_Gracia').AsFloat;
          Registro.fCupones_Cortados  := 0;

          // Para la SVS
          if (PERIODO_GRACIA <> 0) then
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT COUNT(*) As Num_Regs              ');
            SQL.Add('  FROM QS_FIN_DESARR a               ');
            SQL.Add(' WHERE a.Serie              = :Serie       ');
            SQL.Add('   AND a.Codigo_Instrumento = :Instrumento ');
            SQL.Add('   AND a.Codigo_Emisor      = :Emisor      ');

            if sDriver = 'ORACLE' then
               SQl.Add('    AND trunc(a.Fecha_Vig) in (SELECT MAX(trunc(x.Fecha_Vig)) ')
            else
               SQl.Add('    AND convert(CHAR(10),a.Fecha_Vig,103) in (SELECT MAX(convert(CHAR(10),x.Fecha_Vig,103)) ');

            SQl.Add('    FROM QS_FIN_DESARR x '
                                    +'                             WHERE x.serie = a.serie '
                                    +'                               AND x.Codigo_Instrumento = a.Codigo_Instrumento '
                                    +'                               AND x.codigo_emisor = a.codigo_emisor '
                                    +'                               AND x.Fecha_Vig <= :Fecha_Vig ) ');

            ParamByName('Emisor'     ).AsString := sEmisor;
            ParamByName('Instrumento').AsString := sInstrumento;
            ParamByName('Serie'      ).AsString := sSerie;
            ParamByName('Fecha_Vig'  ).AsDate   := dFecha_Vig;

            Open;
            // Para el tema de la SVS que no saben en el nunero de cupones estan incluidos los periodos de gracia
            iNro_Cupones := FieldByName('Num_Regs').AsInteger;
            Close;
            if (ROUND(NRO_CUPONES-PERIODO_GRACIA) = iNro_Cupones) then
            begin
              NRO_CUPONES := iNro_Cupones;
            end;
          end;


          Close;
          SQL.Clear;
          SQL.Add('SELECT COUNT(*) As Num_Regs              ');
          SQL.Add('  FROM QS_FIN_EXCP_VARCAM                ');
          SQL.Add(' WHERE Codigo_Emisor      = :Emisor      ');
          SQL.Add('   AND Codigo_Instrumento = :Instrumento ');
          SQL.Add('   AND Serie              = :Serie       ');
          SQL.Add('   AND Fecha_Vig          = :Fecha_Vig   ');

          ParamByName('Emisor'     ).AsString := sEmisor;
          ParamByName('Instrumento').AsString := sInstrumento;
          ParamByName('Serie'      ).AsString := sSerie;
          ParamByName('Fecha_Vig'  ).AsDate   := dFecha_Vig;

          Open;
          if FieldByName('Num_Regs').AsInteger > 0 then
             Variacion_Cambiaria := True
          else
             Variacion_Cambiaria := False;
          Close;

          if TASA_FLOTANTE = 'S' then
          begin
             SQL.Clear;
             SQL.Add('SELECT COUNT(*) As Num_Regs                ');
             SQL.Add('  FROM QS_FIN_DEF_DESFLOT                  ');
             SQL.Add(' WHERE SERIE              = :Serie         ');
             SQL.Add('   AND CODIGO_INSTRUMENTO = :Instrumento   ');
             SQL.Add('   AND CODIGO_IDENTIDAD   = :Emisor        ');
             SQL.Add('   AND TIPO_TASA is NOT NULL               ');
             if (sDriver = 'ORACLE') then
                SQL.Add('   AND TIPO_TASA <> '' ''               ')
             else
                SQL.Add('   AND TIPO_TASA <> ''''                ');
             SQL.Add('   AND Fecha_Vig   = :Fecha_Vig            ');

             ParamByName('Emisor'     ).AsString := sEmisor;
             ParamByName('Instrumento').AsString := sInstrumento;
             ParamByName('Serie'      ).AsString := sSerie;
             ParamByName('Fecha_Vig'  ).AsDate   := dFecha_Vig;

             Open;
             if FieldByName('Num_Regs').AsInteger = 0 then
                bSin_Tasa_en_Flujos := True
             else
                bSin_Tasa_en_Flujos := False;
             Close;
          end
          else
            bSin_Tasa_en_Flujos := True;

         end;
      // Verifico base Variable
      SQL.Clear;
      SQL.Add('SELECT TASA_DEPENDE_PERIODOS          ');
      SQL.Add('  FROM QS_FIN_TASA_BASE_VARIABLE      ');
      SQL.Add(' WHERE COD_TASA_BASE = :COD_TASA_BASE ');

      ParamByName('COD_TASA_BASE').AsString := TASA_VALOR_PAR;

      bTasa_Depende_Periodos := False;
      try
        Open;
        if FieldByName('TASA_DEPENDE_PERIODOS').AsString = 'S' then
           bTasa_Depende_Periodos := True;
        Close;
      except
           bTasa_Depende_Periodos := False;
      end;

      if bTasa_Depende_Periodos then
      begin
         if PERIODO_PAGO = 0 then
            fPeriodos := 1
         else
            fPeriodos := 12 / PERIODO_PAGO;
         TASA_EFECTIVA := TASA_EFECTIVA / fPeriodos;
      end;
    end;
end;
//------------------------------------------------------------------------------
procedure Proximo_vencimiento(sNemotecnico      : String;
                              sTipo_vencimiento : String;
                              iNro_Cupon        : Integer;
                              wDia_Vencimiento  : word;
                              wPeriodo_Pago     : word;
                              sTasa_Flotante    : String;
                          var dfecha            : TDatetime;
                          var Result            : Boolean);
var
  wdia, wmes, wano : word;
begin
  Result := True;
  if (sTipo_Vencimiento = 'UD') or
     (sTipo_Vencimiento = 'SD') or
     (sTipo_Vencimiento = 'CD') then
  begin

    if (sTipo_Vencimiento = 'UD') or (sTipo_Vencimiento = 'SD') then
    begin
       wdia   := 1;
       dFecha := suma_lapso(dfecha,wPeriodo_Pago,wdia);
       decodedate(dfecha,wano,wmes,wdia);
       if (sTipo_Vencimiento = 'UD') then
           wdia := ultimo_dia_mes(wmes,wano)
       else
       begin
          wdia := wDia_Vencimiento;
          if wDia_Vencimiento > ultimo_dia_mes(wmes,wano) then
             wdia := ultimo_dia_mes(wmes,wano);
       end;
       dfecha := encodedate(wano,wmes,wdia);
    end;

    if (sTipo_Vencimiento = 'CD') then
        dfecha := dfecha + wDia_Vencimiento;

  end
  else  {Tipo Vencimiento Variable VA}
     {   Queda comentado el acceso en memoria debido a la cantidad de estos registros en Auditoría y SVS
     if sValorizacion_Proceso = 'SI' then
        Result := Busca_Nem_Fechas( sNemotecnico,
                                    iNro_Cupon,
                                    dFecha )
     else
     }
     begin
       WITH dmComunInversiones.Qry_Nem_Fechas do
       begin
          {
          Sql.Clear;
          Sql.Add('SELECT Fecha_Vencimiento'
                 +' FROM QS_FIN_Nem_Fechas '
                 +' WHERE Codigo_Nemotecnico = :Nemotecnico'
                 +'  AND Nro_Cupon = :Cupon'
                 );
          }
          ParamByName('Nemotecnico').AsString := sNemotecnico;
          ParamByName('Cupon').AsFloat        := iNro_Cupon;
          try
              Open;
              if FieldByName('Fecha_Vencimiento').IsNull then
                 Result := False
              else
                 dFecha := FieldByName('Fecha_Vencimiento').AsDatetime;
          except on E: EFDDBEngineException do
              begin
                ShowError(E);
                Close;
                Exit;
              end;
          end;
          Close;
       end;
    end;// fin if
end;
//--------------------------------------------------------------------------------------
procedure Proximo_vencimiento_Vig(sNemotecnico      : String;
                                  dfecha_Vig        : TDatetime;
                                  sTipo_vencimiento : String;
                                  iNro_Cupon        : Integer;
                                  wDia_Vencimiento  : word;
                                  wPeriodo_Pago     : word;
                                  sTasa_Flotante    : String;
                              var dfecha            : TDatetime;
                              var sModulo_Err       : String;
                              var sString_Err       : String;
                              var Result            : Boolean);
var
  wdia, wmes, wano : word;
begin
  sString_Err := 'Proximo Vencimiento Vigente';
  Result := True;
  if (sTipo_Vencimiento = 'UD') or
     (sTipo_Vencimiento = 'SD') or
     (sTipo_Vencimiento = 'CD') then
  begin
     if (sTipo_Vencimiento = 'UD') or (sTipo_Vencimiento = 'SD') then
     begin
        wdia   := 1;
        dFecha := suma_lapso(dfecha,wPeriodo_Pago,wdia);
        decodedate(dfecha,wano,wmes,wdia);
        if (sTipo_Vencimiento = 'UD') then
            wdia := ultimo_dia_mes(wmes,wano)
        else
        begin
           wdia := wDia_Vencimiento;
           if wDia_Vencimiento > ultimo_dia_mes(wmes,wano) then
              wdia := ultimo_dia_mes(wmes,wano);
        end;
        dfecha := encodedate(wano,wmes,wdia);
     end;

     if (sTipo_Vencimiento = 'CD') then
         dfecha := dfecha + wDia_Vencimiento;
  end
  else  {Tipo Vencimiento Variable VA}
     {   Queda comentado el acceso en memoria debido a la cantidad de estos registros en Auditoría y SVS
     if sValorizacion_Proceso = 'SI' then
        Result := Busca_Nem_Fechas( sNemotecnico,
                                    iNro_Cupon,
                                    dFecha )
     else
     }
        begin
           WITH dmComunInversiones.QRY_General do
           begin
              Sql.Clear;
              Sql.Add( ' SELECT Fecha_Vencimiento'
                      +'   FROM QS_FIN_Nem_Fechas a'
                      +'  WHERE Codigo_Nemotecnico = :Nemotecnico');
              if sDriver = 'ORACLE' then
                 Sql.Add( '    AND TRUNC(a.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig)) ')
              else
                 Sql.Add( '    AND CONVERT(CHAR(10),a.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103)) ');
              Sql.Add( '                        FROM QS_FIN_Nem_Fechas x '
                      +'                       WHERE x.Codigo_Nemotecnico = a.Codigo_Nemotecnico '
                      +'                         AND x.Fecha_Vig <= :Fecha_Vig '
                      +'                         AND x.fecha_vencimiento IS NOT NULL'
                      +'                         ) '
                      +'    AND a.Nro_Cupon = :Cupon'
                      +'    AND a.fecha_vencimiento IS NOT NULL'
                      );
              ParamByName('Nemotecnico').AsString := sNemotecnico;
              ParamByName('Fecha_Vig').AsDate     := dFecha_Vig;
              ParamByName('Cupon').AsFloat        := iNro_Cupon;
              try
                  Open;
                  if FieldByName('Fecha_Vencimiento').IsNull then
                  begin
                     sString_Err := 'No se encontraron fechas variables para nemotecnico: '
                                    +sNemotecnico
                                    +' al '
                                    +FormatDateTime('dd/mm/yyyy',dFecha_Vig);
                     Result := False;
                  end
                  else
                     dFecha := FieldByName('Fecha_Vencimiento').AsDatetime;
              except on E: EFDDBEngineException do
                  begin
                    ShowError(E);
                    Close;
                    Exit;
                  end;
              end;
              Close;
          end;
    end;// fin if
end;
procedure Carga_Fechas_Variables_Vig(sNemotecnico     : String;
                                     dfecha_Vig       : TDatetime;
                                 var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 var Modulo_Err       : String;
                                 var sString_Err      : String;
                                 var Result           : Boolean);

Var i,Ant_i : integer;
begin
   Modulo_Err := 'Carga_Fechas_Variables_Vig';
   WITH dmComunInversiones.QRY_General do
   begin
      Sql.Clear;
      Sql.Add( ' SELECT Nro_Cupon '
              +'       ,Fecha_Vencimiento'
              +'   FROM QS_FIN_Nem_Fechas a'
              +'  WHERE Codigo_Nemotecnico = :Nemotecnico');
      if sDriver = 'ORACLE' then
         Sql.Add( '    AND TRUNC(a.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig)) ')
      else
         Sql.Add( '    AND CONVERT(CHAR(10),a.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103)) ');
      Sql.Add( '                        FROM QS_FIN_Nem_Fechas x '
              +'                       WHERE x.Codigo_Nemotecnico = a.Codigo_Nemotecnico '
              +'                         AND x.Fecha_Vig <= :Fecha_Vig '
              +'                         AND x.fecha_vencimiento IS NOT NULL'
              +'                         ) '
              +'    AND a.fecha_vencimiento IS NOT NULL'
              +'    ORDER BY 1'
              );
      ParamByName('Nemotecnico').AsString := sNemotecnico;
      ParamByName('Fecha_Vig').AsDate     := dFecha_Vig;
      try
          Ant_i := 0;
          Open;

          while NOT EOF do
          begin
              i:= Trunc(FieldByName('NRO_CUPON').AsFloat);

              if FieldByName('Fecha_Vencimiento').IsNull then
              begin
                 sString_Err := 'No se encontraron fechas variables para nemotecnico: '
                                +sNemotecnico
                                +' al '
                                +FormatDateTime('dd/mm/yyyy',dFecha_Vig);
                 Result := False;
                 break;
              end
              else
                 if i <> Ant_i + 1 then
                 begin
                    sString_Err := 'Error en secuencia fechas variables para nemotecnico: '
                                   +sNemotecnico
                                   +' al '
                                   +FormatDateTime('dd/mm/yyyy',dFecha_Vig);
                    Result := False;
                    break;
                 end
                 else
                    Array_Mem_Desarr[i].Fecha_Vcto := FieldByName('Fecha_Vencimiento').AsDatetime;

                 Ant_i := Ant_i + 1;
                 dmComunInversiones.QRY_General.Next;
          end;
      except on E: EFDDBEngineException do
          begin
            ShowError(E);
            Close;
            Exit;
          end;
      end;
      Close;
  end;
end;
//--------------------------------------------------------------------------------------
procedure Determina_Spread(sEmpresa       : String;
                           sEmisor        : String;
                           sInstrumento   : String;
                           sSerie         : String;
                           dfecha_Emision : TDateTime;
                       var fSpread        : Double;
                       var Modulo_Err     : String;
                       var String_Err     : String;
                       var Result         : Boolean);
begin
    Result := True;
    fSpread:= 0;
    With dmComunInversiones.QRY_General do
      begin
        SQL.Clear;
        SQL.Add('select sum(margen * valor_pte)/ sum(valor_pte) as spread from  '
               +' qs_tmp_ponderado '
               +' where  empresa     = :empresa  and '
      	       +'        emisor      = :emisor   and '
       	       +'        Instrumento = :Instrumento and '
	       +'        serie       = :serie and '
	       +'        Fecha_emision = :Fecha_Emision '
               );
        ParamByName('Empresa').AsString         := sEmpresa;
        ParamByName('emisor').AsString          := sEmisor;
        ParamByName('Instrumento').AsString     := sInstrumento;
        ParamByName('Serie').AsString           := sSerie;
        ParamByName('fecha_emision').AsDate := dFecha_emision;
        Prepare;
        Open;
        if FieldByName('spread').IsNull then
           begin
             Result := False;
             String_Err := 'No se encontró margen ponderado';
           end
        else
           fSpread := FieldByName('spread').AsFloat;
      end;//with
end;
{
procedure Lectura_Tasa_Plazo(sTasa   : string;
                             dfecha  : TDateTime;
                             fdias   : Double;
                         var fvalor  : Double);
var
 sUnidad_Medida : String;
 flimite_hasta  : Double;

begin
    // Buscar un registro de la tasa(sTasa) a la fecha (dFecha)
  fValor := 0;
  With dmComunInversiones.Qry_Varios do
      begin
        SQL.Clear;
        SQL.Add('select * from qs_fin_tas_plazo '
               +'where codigo_tasa   = :codigo_tasa and '
               +'      Fecha_Valor   = :fecha_valor'
               );
        ParamByName('codigo_tasa').AsString   := sTasa;
        ParamByName('fecha_valor').AsDateTime := dfecha;
        Prepare;
        Open;
        First;
        if FieldByName('codigo_tasa').IsNull then
           exit
        else
           sUnidad_Medida := FieldByName('Unidad_Medida').AsString;
        Close;
        Unprepare;
      end;

    With dmComunInversiones.Qry_Varios do
      begin
        SQL.Clear;
        SQL.Add('select max(limite_hasta) as reg from qs_fin_tas_plazo '
               +'where limite_hasta <= :plazo and '
               +'      codigo_tasa   = :codigo_tasa and '
               +'      Fecha_Valor   = :fecha_valor'
               );
        ParamByName('plazo').AsFloat          := fdias;
        ParamByName('codigo_tasa').AsString   := sTasa;
        ParamByName('fecha_valor').AsdateTime := dfecha;
        Prepare;
        Open;
        if FieldByName('reg').IsNull then
           Exit
        else
           flimite_hasta := FieldByName('reg').AsFloat;
        close;
        Unprepare;
     end;

    With dmComunInversiones.Qry_Varios do
      begin
        SQL.Clear;
        SQL.Add('select valor_tasa from qs_fin_tas_plazo '
               +'where limite_hasta  = :limite_hasta and '
               +'      codigo_tasa   = :codigo_tasa and '
               +'      Fecha_Valor   = :fecha_valor'
               );
        ParamByName('limite_hasta').AsFloat   := flimite_hasta;
        ParamByName('codigo_tasa').AsString   := sTasa;
        ParamByName('fecha_valor').AsDateTime := dfecha;
        Prepare;
        Open;
        if FieldByName('valor_tasa').IsNull then
           Exit
        else
           fValor := FieldByName('valor_tasa').AsFloat;
        close;
        Unprepare;
     end;
end;
}
//==============================================================================
procedure Actualiza_Valor_IPC(dFecha_Inicial : TdateTime;
                              var fMonto     : Double;
                              dFecha_Final   : TdateTime;
                              String_Error   : String;
                              Modulo_Error   : String;
                              Result         : Boolean);
var
  fValor_IPC_Inicial : Double;
  fValor_IPC_Final   : Double;
begin
  Leer_Valor_Indice('IPC'
                   ,dFecha_Inicial
                   ,fValor_IPC_Inicial
                   ,Result);

  if NOT Result then
     begin
       String_Error := 'No se encontro valor IPC a : '+datetostr(dFecha_Inicial);
       Modulo_Error := 'Leer Valor';
       exit;
     end;

  Leer_Valor_Indice('IPC'
                   ,dFecha_Final
                   ,fValor_IPC_Final
                   ,Result);

  if NOT Result then
     begin
       String_Error := 'No se encontro valor IPC a : '+datetostr(dFecha_Final);
       Modulo_Error := 'Leer Valor';
       exit;
     end;
  fMonto := (fValor_IPC_Final / fValor_IPC_Inicial) * fMonto;
end;
//------------------------------------------------------------------------------

procedure Tratamiento_Fecha(sCodigo_Tratam   : String;
                            Registro_Fechas  : TRegistro_Fechas;
                            var Fecha_Result : TDateTime;
                            var Modulo_Err   : String;
                            var String_Err   : String;
                            var Result       : Boolean);
var
   fCantidad                : Double;
   sUnidad                  : String;
   sHabiles                 : String;
   sAntes_Despues           : String;
   sReferencia              : String;
   sCodigo_Pais             : String;
   fDia                     : Double;
   sCondicion_Mes_Siguiente : String;

   iDias,
   iMeses,
   iAnos          : Integer;

   //dFecha    : TDateTime;
   AA,
   MM,
   DD         : word;
   Ano,
   Mes,
   Dia         : Integer;

   Fecha_Original : TDateTime;
   waa,
   wmm,
   wdd         : word;
   Mes_Ori,
   Mes_Cal     : Integer;

begin
    Result := True;
    Fecha_Result := strtodate(Fecha_Nula); //Fecha_Nula;

    Busca_Tratamiento_Fechas_Mem( trim(sCodigo_Tratam),
                                  fCantidad,
                                  sUnidad,
                                  sHabiles,
                                  sAntes_Despues,
                                  sReferencia,
                                  sCodigo_Pais,
                                  fDia,
                                  sCondicion_Mes_Siguiente
                                 );
{
    else
    begin
       With dmComunInversiones.Qry_Varios do
       begin
         SQL.Clear;
         SQL.Add('SELECT Codigo_Tratam'
                +'      ,Cantidad'
                +'      ,Unidad'
                +'      ,Habiles'
                +'      ,Antes_Despues'
                +'      ,Referencia'
                +'      ,Codigo_Pais'
                +'  FROM QS_SYS_TRATAM'
                +' WHERE Codigo_Tratam = :Codigo_Tratam'
                );
         ParamByName('Codigo_Tratam').AsString := trim(sCodigo_Tratam);
         Prepare;
         Open;
         if FieldByName('Codigo_Tratam').IsNull then
            begin
               Close;
               UnPrepare;
               Result := False;
               String_Err := 'No se encontro definición para código '+sCodigo_Tratam;
               Modulo_Err := 'Tratamiento Fechas';
               exit;
            end;
         fCantidad      := FieldByName('Cantidad').AsFloat;
         sUnidad        := FieldByName('Unidad').AsString;
         sHabiles       := FieldByName('Habiles').AsString;
         sAntes_Despues := FieldByName('Antes_Despues').AsString;
         sReferencia    := FieldByName('Referencia').AsString;
         sCodigo_Pais   := FieldByName('Codigo_Pais').AsString;
         Close;
         UnPrepare;
       end; // end with query
  end;
 }

  if sReferencia = 'FECCALC' then
     Fecha_Result := Registro_fechas.Fecha_Calculo;

  if sReferencia = 'FECOPERAC' then
     Fecha_Result := Registro_fechas.Fecha_Compra;

  if sReferencia = 'FECCOMP' then
     Fecha_Result := Registro_fechas.Fecha_Compra;

  if sReferencia = 'FECEMIS' then
     Fecha_Result := Registro_fechas.Fecha_Emision;

  if sReferencia = 'FECVCTPER' then
     Fecha_Result := Registro_fechas.Fecha_Vcto_Periodo;

  if sReferencia = 'FECINIPER' then
     Fecha_Result := Registro_fechas.Fecha_Inic_Periodo;

  if sReferencia = 'FECVCTO' then
     Fecha_Result := Registro_fechas.Fecha_Vencimiento;

  // Corresponde a fecha parametro
  if sReferencia = 'FECHA' then
     Fecha_Result := Registro_fechas.Fecha_Parametro;

  if sReferencia = 'FECPAGO' then
     Fecha_Result := Registro_fechas.Fecha_Pago;

  //if Fecha_Result = StrToDate(Fecha_Nula) then
  // OJO se detecto que cuando la variable esta sucia puede dar un valor del otden de 0.000000000005
  if Fecha_Result < 1 then
  begin
     Modulo_Err := 'Tratamiento Fecha (Modulo Comun Inversiones)';
     String_Err := 'No existe fecha para: '
                   +sCodigo_Tratam;
     Result := False;
     exit;
  end;

  Fecha_Original := Fecha_Result;

  if fDia <> 0 Then
  begin
     DecodeDate(Fecha_Result,AA,MM,DD);
     Ano   := AA;
     Mes   := MM;
     Dia   := StrToInt(FloatToStr(fDia));
     if fDia > ultimo_dia_mes(MM,AA) Then
        Dia := ultimo_dia_mes(MM,AA);
     Fecha_Result := EncodeDate(Ano,Mes,Dia);
  end;

// GG y FI 17-10-2019  se comenta ya que es valida la definicion 0 dias habil o no habil
//  if fCantidad = 0 then
//  begin
//     Result := True;
//     exit;
//  end;

  iDias  := 0;
  iMeses := 0;
  iAnos  := 0;

  if sAntes_Despues = 'A' then
     fCantidad := fCantidad * (-1);

  if sUnidad = 'DIA' then
     iDias := ROUND(fCantidad);

  if sUnidad = 'MES' then
     iMeses := ROUND(fCantidad);

  if sUnidad = 'ANO' then
     iAnos := ROUND(fCantidad);

  if (sUnidad = 'DIA') AND (sHabiles = 'S') then
  begin
    if sAntes_Despues = 'A' then
       Fecha_Result := Resta_dias_habiles(sCodigo_Pais
                                         ,Fecha_Result
                                         ,ABS(fCantidad))
    else
       Fecha_Result := suma_dias_habiles(sCodigo_Pais
                                        ,Fecha_Result
                                        ,ABS(fCantidad));

  end
  else
    Fecha_Result := IncDate(Fecha_Result
                           ,iDias
                           ,iMeses
                           ,iAnos);

  if sHabiles = 'N' then
  begin
     Result := True;
     exit;
  end;

  While (Feriado_Mem(sCodigo_Pais,Fecha_Result) or // OJO VA A MEMORIA DIRECTO
        (DayOfWeek(Fecha_Result) in [1,7]))     do
     if sAntes_Despues = 'A' then
        Fecha_Result := Fecha_Result - 1
     else
        Fecha_Result := Fecha_Result + 1;

  //ggarcia 04-10-2019 Si el resultado es el mes siguiente, se asigna el dia habil anterior de la fecha original
  if sCondicion_Mes_Siguiente = 'S' then
  begin
     DecodeDate(Fecha_Original,waa,wmm,wdd);
     Mes_Ori := wmm;

     DecodeDate(Fecha_Result,AA,MM,DD);
     Mes_Cal := MM;

     if Mes_Cal > Mes_Ori then
        Fecha_Result := Resta_dias_habiles(sCodigo_Pais
                                          ,Fecha_Original
                                          ,1)
  end;

  Result := True;
end;


(*
procedure Tratamiento_Fecha(sCodigo_Tratam   : String;
                            Registro_Fechas  : TRegistro_Fechas;
                            var Fecha_Result : TDateTime;
                            var Modulo_Err   : String;
                            var String_Err   : String;
                            var Result       : Boolean);
var
   fCantidad      : Double;
   sUnidad        : String;
   sHabiles       : String;
   sAntes_Despues : String;
   sReferencia    : String;
   sCodigo_Pais   : String;

   iDias,
   iMeses,
   iAnos          : Integer;

begin
    Result := True;
    Fecha_Result := strtodate(Fecha_Nula);
    Busca_Tratamiento_Fechas_Mem( trim(sCodigo_Tratam),
                                  fCantidad,
                                  sUnidad,
                                  sHabiles,
                                  sAntes_Despues,
                                  sReferencia,
                                  sCodigo_Pais
                                 );
{
    else
    begin
       With dmComunInversiones.Qry_Varios do
       begin
         SQL.Clear;
         SQL.Add('SELECT Codigo_Tratam'
                +'      ,Cantidad'
                +'      ,Unidad'
                +'      ,Habiles'
                +'      ,Antes_Despues'
                +'      ,Referencia'
                +'      ,Codigo_Pais'
                +'  FROM QS_SYS_TRATAM'
                +' WHERE Codigo_Tratam = :Codigo_Tratam'
                );
         ParamByName('Codigo_Tratam').AsString := trim(sCodigo_Tratam);
         Prepare;
         Open;
         if FieldByName('Codigo_Tratam').IsNull then
            begin
               Close;
               UnPrepare;
               Result := False;
               String_Err := 'No se encontro definición para código '+sCodigo_Tratam;
               Modulo_Err := 'Tratamiento Fechas';
               exit;
            end;
         fCantidad      := FieldByName('Cantidad').AsFloat;
         sUnidad        := FieldByName('Unidad').AsString;
         sHabiles       := FieldByName('Habiles').AsString;
         sAntes_Despues := FieldByName('Antes_Despues').AsString;
         sReferencia    := FieldByName('Referencia').AsString;
         sCodigo_Pais   := FieldByName('Codigo_Pais').AsString;
         Close;
         UnPrepare;
       end; // end with query
  end;
 }

  if sReferencia = 'FECCALC' then
     Fecha_Result := Registro_fechas.Fecha_Calculo;

  if sReferencia = 'FECOPERAC' then
     Fecha_Result := Registro_fechas.Fecha_Compra;

  if sReferencia = 'FECCOMP' then
     Fecha_Result := Registro_fechas.Fecha_Compra;

  if sReferencia = 'FECEMIS' then
     Fecha_Result := Registro_fechas.Fecha_Emision;

  if sReferencia = 'FECVCTPER' then
     Fecha_Result := Registro_fechas.Fecha_Vcto_Periodo;

  if sReferencia = 'FECINIPER' then
     Fecha_Result := Registro_fechas.Fecha_Inic_Periodo;

  if sReferencia = 'FECVCTO' then
     Fecha_Result := Registro_fechas.Fecha_Vencimiento;

  // Corresponde a fecha parametro
  if sReferencia = 'FECHA' then
     Fecha_Result := Registro_fechas.Fecha_Parametro;

  if sReferencia = 'FECPAGO' then
     Fecha_Result := Registro_fechas.Fecha_Pago;

  if Fecha_Result = StrToDate(Fecha_Nula) then
  begin
     Modulo_Err := 'Tratamiento Fecha (Modulo Comun Inversiones)';
     String_Err := 'No existe fecha para: '
                   +sCodigo_Tratam;
     Result := False;
     exit;
  end;

  if fCantidad = 0 then
  begin
     Result := True;
     exit;
  end;

  iDias  := 0;
  iMeses := 0;
  iAnos  := 0;

  if sAntes_Despues = 'A' then
     fCantidad := fCantidad * (-1);

  if sUnidad = 'DIA' then
     iDias := ROUND(fCantidad);

  if sUnidad = 'MES' then
     iMeses := ROUND(fCantidad);

  if sUnidad = 'ANO' then
     iAnos := ROUND(fCantidad);

  if (sUnidad = 'DIA') AND (sHabiles = 'S') then
  begin
    if sAntes_Despues = 'A' then
       Fecha_Result := Resta_dias_habiles(sCodigo_Pais
                                         ,Fecha_Result
                                         ,ABS(fCantidad))
    else
       Fecha_Result := suma_dias_habiles(sCodigo_Pais
                                        ,Fecha_Result
                                        ,ABS(fCantidad));

  end
  else
    Fecha_Result := IncDate(Fecha_Result
                           ,iDias
                           ,iMeses
                           ,iAnos);

  if sHabiles = 'N' then
  begin
     Result := True;
     exit;
  end;

  While (Feriado_Mem(sCodigo_Pais,Fecha_Result)  or // OJO VA A MEMORIA DIRECTO
         (DayOfWeek(Fecha_Result) in [1,7])) do
     if sAntes_Despues = 'A' then
        Fecha_Result := Fecha_Result - 1
     else
        Fecha_Result := Fecha_Result + 1;

  Result := True;
end;
*)
//------------------------------------------------------------------------------
// Carga_Parametros_Formulas: Deja en registros globales los parametros
// especificos de las formulas de valorización.
//------------------------------------------------------------------------------
{ Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.
procedure carga_parametros_formulas(sFormula_PAR    : String;
                                    sFormula_TIR    : String;
                                    var Reg_Formula_PAR : TRegFormulaPAR;
                                    var Reg_Formula_TIR : TRegFormulaTIR;
                                    var sModulo_Err     : String;
                                    var sString_Err     : String;
                                    var Result          : Boolean);

begin
     WITH Reg_Formula_PAR do
     begin
       Codigo_Formula     := '';
       Cod_Utiliza_tasa   := '';
       Cod_Utiliza_Precio := '';
       Codigo_Tasa        := '';
       Tratamiento        := '';
       Spread_Operacion   := '';
       Spread_Factor      := 0;
       Spread_Variable    := '';
       Valoriza_Acumulado := '';
       Dias_Habiles       := '';
       Valoriza_Sobre     := '';
       Aplica_Factor_Correccion := '';
       Mon_Ind_Correccion       := '';
       Fecha_Desde_Corr         := '';
       Fecha_Hasta_Corr         := '';
       Aplica_Devengamiento     := '';
       Tratam_Devengamiento     := '';
       Aplica_Redondeo_UM       := '';
     end;
     WITH Reg_Formula_TIR do
     begin
       Codigo_Formula     := '';
       Cod_Utiliza_tasa   := '';
       Cod_Utiliza_Precio := '';
       Codigo_Tasa        := '';
       Tratamiento        := '';
       Spread_Operacion   := '';
       Spread_Factor      := 0;
       Spread_Variable    := '';
       Valoriza_Acumulado := '';
       Dias_Habiles       := '';
       Valoriza_Sobre     := '';
       Aplica_Factor_Correccion := '';
       Mon_Ind_Correccion       := '';
       Fecha_Desde_Corr         := '';
       Fecha_Hasta_Corr         := '';
       Aplica_Devengamiento     := '';
       Tratam_Devengamiento     := '';
       Aplica_Redondeo_UM       := '';
     end;

     if VarIsArray(Reg_Formulas.Par_Pte) then
     begin
        carga_parametros_formulas_Mem(sFormula_PAR
                                     ,sFormula_TIR
                                     ,Reg_Formula_PAR
                                     ,Reg_Formula_TIR
                                     ,sModulo_Err
                                     ,sString_Err
                                     ,Result);
        exit;
     end;

     Result := True;
     WITH dmComunInversiones.QRY_General
          ,Reg_Formula_PAR do
     begin
       SQL.Clear;
       SQL.Add(' SELECT *'
              +'  FROM QS_FIN_FORMULA_PAR'
              +' WHERE Codigo_Formula = :Codigo_Formula'
              );

       ParamByName('Codigo_Formula').AsString := sFormula_PAR;
       Open;

       if (sFormula_PAR <> FieldByName('Codigo_Formula').AsString) or
          (FieldByName('Codigo_Formula').IsNull)                   then
       begin
         Close;
         sModulo_Err := 'Parametros para Formula';
         sString_Err := 'No se econtro definición de parametros para: '
                        +sFormula_PAR;
         Result := False;
         exit;
       end;

       Codigo_Formula     := FieldByName('Codigo_Formula').AsString;
       Cod_Utiliza_tasa   := FieldByName('Cod_Utiliza_tasa').AsString;
       Cod_Utiliza_Precio := FieldByName('Cod_Utiliza_Precio').AsString;
       Codigo_Tasa        := FieldByName('Codigo_Tasa').AsString;
       Tratamiento        := FieldByName('Tratamiento').AsString;
       Spread_Operacion   := FieldByName('Spread_Operacion').AsString;
       Spread_Factor      := FieldByName('Spread_Factor').AsFloat;
       Spread_Variable    := FieldByName('Spread_Variable').AsString;
       Valoriza_Acumulado := FieldByName('Valoriza_Acumulado').AsString;
       Dias_Habiles       := FieldByName('Dias_Habiles').AsString;
       Valoriza_Sobre     := FieldByName('Valoriza_Sobre').AsString;
       Aplica_Factor_Correccion := FieldByName('Aplica_Factor_Correccion').AsString;
       Mon_Ind_Correccion       := FieldByName('Mon_Ind_Correccion').AsString;
       Fecha_Desde_Corr         := FieldByName('Fecha_Desde_Corr').AsString;
       Fecha_Hasta_Corr         := FieldByName('Fecha_Hasta_Corr').AsString;

       Aplica_Devengamiento     := '';
       if FindField('Aplica_Devengamiento') <> Nil then
          Aplica_Devengamiento     := Fieldbyname('Aplica_Devengamiento').asString;

       Tratam_Devengamiento     := '';
       if FindField('Tratam_Devengamiento') <> Nil then
          Tratam_Devengamiento     := Fieldbyname('Tratam_Devengamiento').asString;

       Aplica_Redondeo_UM     := '';
       if FindField('Redondea_UM') <> Nil then
          Aplica_Redondeo_UM     := Fieldbyname('Redondea_UM').asString;
       Close;
     end;

     WITH dmComunInversiones.QRY_General
          ,Reg_Formula_TIR do
     begin
       SQL.Clear;
       SQL.Add(' SELECT *'
              +'  FROM QS_FIN_FORMULA_TIR'
              +' WHERE Codigo_Formula = :Codigo_Formula'
              );
       ParamByName('Codigo_Formula').AsString := sFormula_TIR;
       Open;

       if (sFormula_TIR <> FieldByName('Codigo_Formula').AsString) or
          (FieldByName('Codigo_Formula').IsNull)                   then
       begin
         Close;
         sModulo_Err := 'Parametros para Formula';
         sString_Err := 'No se econtro definición de parametros para: '
                        +sFormula_TIR;
         Result := False;
         exit;
       end;

       Codigo_Formula     := FieldByName('Codigo_Formula').AsString;
       Cod_Utiliza_tasa   := FieldByName('Cod_Utiliza_tasa').AsString;
       Cod_Utiliza_Precio := FieldByName('Cod_Utiliza_Precio').AsString;
       Codigo_Tasa        := FieldByName('Codigo_Tasa').AsString;
       Tratamiento        := FieldByName('Tratamiento').AsString;
       Spread_Operacion   := FieldByName('Spread_Operacion').AsString;
       Spread_Factor      := FieldByName('Spread_Factor').AsFloat;
       Spread_Variable    := FieldByName('Spread_Variable').AsString;
       Valoriza_Acumulado := FieldByName('Valoriza_Acumulado').AsString;
       Dias_Habiles       := FieldByName('Dias_Habiles').AsString;
       Valoriza_Sobre     := FieldByName('Valoriza_Sobre').AsString;
       Aplica_Factor_Correccion := FieldByName('Aplica_Factor_Correccion').AsString;
       Mon_Ind_Correccion       := FieldByName('Mon_Ind_Correccion').AsString;
       Fecha_Desde_Corr         := FieldByName('Fecha_Desde_Corr').AsString;
       Fecha_Hasta_Corr         := FieldByName('Fecha_Hasta_Corr').AsString;
       Aplica_Devengamiento     := '';
       if FindField('Aplica_Devengamiento') <> Nil then
          Aplica_Devengamiento     := Fieldbyname('Aplica_Devengamiento').asString;

       Tratam_Devengamiento     := '';
       if FindField('Tratam_Devengamiento') <> Nil then
          Tratam_Devengamiento     := Fieldbyname('Tratam_Devengamiento').asString;

       Aplica_Redondeo_UM     := '';
       if FindField('Redondea_UM') <> Nil then
          Aplica_Redondeo_UM     := Fieldbyname('Redondea_UM').asString;
       Close;
     end;
end;    // carga_parametros_formulas
}
//------------------------------------------------------------------------------
procedure conversion_tasas(sTipo                 : String;
                           fPeriodo              : Double;
                           sAnualidad            : String;
                           fBase_Porcen          : Double;
                           sTipo_New             : String;
                           fPeriodo_New          : Double;
                           sAnualidad_new        : String;
                           fBase_Porcen_new      : Double;
                           var fValor_Tasa       : Double;
                           var sModulo_Err       : String;
                           var sString_Err       : String;
                           var Result            : Boolean);
var
   Base           : Double;
   Exponente      : Double;
begin
   if sAnualidad = 'V' then
      begin
         Result := True;
         exit;
      end;

   if (sTipo      = sTipo_New)      and
      (fPeriodo   = fPeriodo_New)   and
      (sAnualidad = sAnualidad_New) then
      begin
         Result := True;
         exit;
      end;

   if (sTipo = 'N') then
      // Se lleva a tasa efectiva anual
      begin
         fValor_Tasa :=  (fValor_Tasa / fBase_Porcen) / (12 / fPeriodo);
         Base        := (1 - fValor_Tasa);
         Exponente   := (-1) * (12 / fPeriodo);
         fValor_Tasa := (power(Base,Exponente) - 1) * fBase_Porcen;
         sTipo    := 'E';
//         fPeriodo := 12;
      end;

   if sAnualidad_new = 'V' then
      begin
        // De efectiva a vencida
        Base := (1 + (fValor_Tasa / fBase_Porcen));
        Exponente := (1 / (12 / fPeriodo_New));
        fValor_Tasa := power(Base,Exponente) - 1;

        fValor_Tasa := fValor_Tasa * (12 / fPeriodo_New);

        fValor_Tasa := fValor_Tasa * fBase_Porcen_New;
      end;

   if sAnualidad_new = 'A' then
      begin
        // De efectiva a anticipada
        Base := (1 + (fValor_Tasa / fBase_Porcen));
        Exponente := (-1) * (1 / (12 / fPeriodo_New));
        fValor_Tasa := 1 - power(Base,Exponente);

        fValor_Tasa := fValor_Tasa * (12 / fPeriodo_New);

        fValor_Tasa := fValor_Tasa * fBase_Porcen_New;
      end;


   Result     := True;
end;   // conversion_tasas
//------------------------------------------------------------------------------
procedure analiza_desagio(sEmisor                     : String;
                          sInstrumento                : String;
                          sSerie                      : String;
                          sCodigo_Tasa                : String;
                          iDiasBaseTasa               : Integer;
                          sTipoInteresTasa            : String;
                          iBaseMensualTasa            : Integer;
                          sTipoCalculoDiasTasa        : String;
                          sPais_Tasa                  : String;
                          dFecDesPeriodo              : TDateTime;
                          dFecHasPeriodo              : TDateTime;
                          fValor_Tasa                 : Double;
                          var dInicio                 : TDateTime;
                          var dTermino                : TDateTime;
                          var iVigenciaValorDesagio   : Integer;
                          var fValor_Tasa_new         : Double;
                          var sModulo_Err             : String;
                          var sString_Err             : String;
                          var bDesagio                : Boolean;
                          var Result                  : Boolean);

var
  sNew_Tasa,
  //sCod_Pais,
  sOperador_logico        : String;
  iBaseDiasDesagio        : Integer;
  sTipoInteresDesagio     : String;
  iBaseMensualDesagio     : Integer;
  sTipoCalculoDiasDesagio : String;
  iVigenciaMesesDesagio   : Integer;

  sTipo                   : String;
  fPeriodo                : Double;
  sAnualidad              : String;
  fBase_Porcen            : Double;
  sTipo_New               : String;
  fPeriodo_New            : Double;
  sAnualidad_New          : String;
  fBase_Porcen_New        : Double;


begin
   Result   := True;
   bDesagio := False;

   Busca_Desagio_Mem ( sEmisor
                       ,sInstrumento
                       ,sSerie
                       ,dFecDesPeriodo
                       ,dFecHasPeriodo
                       ,sNew_Tasa
                       ,fValor_Tasa_New
                       ,sOperador_Logico
                       ,dInicio
                       ,dtermino
                       ,bDesagio
                      );
   if Not bDesagio then
      Exit;
  { end
   else
   begin
       pais_identidad(sEmisor
                     ,dFecDesPeriodo
                     ,sCod_Pais
                     ,sModulo_Err
                     ,sString_Err
                     ,Result);

       if NOT Result then
          exit;

       WITH dmComunInversiones.QRY_General do
       begin
           SQL.Clear;
           SQL.Add('SELECT Codigo_Tasa'
                  +'      ,Valor_Tasa'
                  +'      ,Operador_Logico'
                  +'      ,Fecha_Desde'
                  +'      ,Fecha_Hasta'
                  +'  FROM QS_FIN_DESAGIO'
                  +' WHERE Serie       = :Serie'
                  +'   AND Emisor      = :Emisor'
                  +'   AND Instrumento = :Instrumento'
                  +'   AND Pais        = :Pais'
                  +'   AND ('
                  +'           ((Fecha_Desde <= :D) AND ((Fecha_Hasta > :D) OR (Fecha_Hasta IS NULL)))'
                  +'        OR ((Fecha_Desde >= :D) AND (Fecha_Desde < :H))'
                  +'       )'
                  );

           ParamByName('Serie').AsString := sSerie;
           ParamByName('Emisor').AsString := sEmisor;
           ParamByName('Instrumento').AsString := sInstrumento;
           ParamByName('Pais').AsString := sCod_Pais;
           ParamByName('D').AsDate       := dFecDesPeriodo;
           ParamByName('H').AsDate       := dFecHasPeriodo;
           Prepare;
           Open;

           if FieldByName('Codigo_Tasa').IsNull then
              begin
                Close;
                UnPrepare;
                SQL.Clear;
                SQL.Add('SELECT Codigo_Tasa'
                       +'      ,Valor_Tasa'
                       +'      ,Operador_Logico'
                       +'      ,Fecha_Desde'
                       +'      ,Fecha_Hasta'
                       +'  FROM QS_FIN_DESAGIO'
                       +' WHERE (Serie      IS NULL OR Serie = '''')'
                       +'   AND Emisor      = :Emisor'
                       +'   AND Instrumento = :Instrumento'
                       +'   AND Pais        = :Pais'
                       +'   AND ('
                       +'           ((Fecha_Desde <= :D) AND ((Fecha_Hasta > :D) OR (Fecha_Hasta IS NULL)))'
                       +'        OR ((Fecha_Desde >= :D) AND (Fecha_Desde < :H))'
                       +'       )'
                       );

                ParamByName('Emisor').AsString := sEmisor;
                ParamByName('Instrumento').AsString := sInstrumento;
                ParamByName('Pais').AsString := sCod_Pais;
                ParamByName('D').AsDate       := dFecDesPeriodo;
                ParamByName('H').AsDate       := dFecHasPeriodo;
                Prepare;
                Open;

                if FieldByName('Codigo_Tasa').IsNull then
                   begin
                     Close;
                     UnPrepare;
                     SQL.Clear;
                     SQL.Add('SELECT Codigo_Tasa'
                            +'      ,Valor_Tasa'
                            +'      ,Operador_Logico'
                            +'      ,Fecha_Desde'
                            +'      ,Fecha_Hasta'
                            +'  FROM QS_FIN_DESAGIO'
                            +' WHERE (Serie      IS NULL OR Serie = '''')'
                            +'   AND (Emisor     IS NULL OR Emisor = '''')'
                            +'   AND Instrumento = :Instrumento'
                            +'   AND Pais        = :Pais'
                            +'   AND ('
                            +'           ((Fecha_Desde <= :D) AND ((Fecha_Hasta > :D) OR (Fecha_Hasta IS NULL)))'
                            +'        OR ((Fecha_Desde >= :D) AND (Fecha_Desde < :H))'
                            +'       )'
                            );

                     ParamByName('Instrumento').AsString := sInstrumento;
                     ParamByName('Pais').AsString := sCod_Pais;
                     ParamByName('D').AsDate       := dFecDesPeriodo;
                     ParamByName('H').AsDate       := dFecHasPeriodo;
                     Prepare;
                     Open;
                     if FieldByName('Codigo_Tasa').IsNull then
                        begin
                          Close;
                          UnPrepare;
                          SQL.Clear;
                          SQL.Add('SELECT Codigo_Tasa'
                                 +'      ,Valor_Tasa'
                                 +'      ,Operador_Logico'
                                 +'      ,Fecha_Desde'
                                 +'      ,Fecha_Hasta'
                                 +'  FROM QS_FIN_DESAGIO'
                                 +' WHERE (Serie       IS NULL OR Serie = '''')'
                                 +'   AND (Emisor      IS NULL OR Emisor = '''')'
                                 +'   AND (Instrumento IS NULL OR Instrumento = '''')'
                                 +'   AND Pais         = :Pais'
                                 +'   AND ('
                                 +'           ((Fecha_Desde <= :D) AND ((Fecha_Hasta > :D) OR (Fecha_Hasta IS NULL)))'
                                 +'        OR ((Fecha_Desde >= :D) AND (Fecha_Desde < :H))'
                                 +'       )'
                                 );

                          ParamByName('Pais').AsString := sCod_Pais;
                          ParamByName('D').AsDate       := dFecDesPeriodo;
                          ParamByName('H').AsDate       := dFecHasPeriodo;
                          Prepare;
                          Open;
                          if FieldByName('Codigo_Tasa').IsNull then
                             begin
                               Close;
                               UnPrepare;
                               bDesagio := False;
                               exit;
                             end;
                        end;
                   end;
              end;

           sNew_Tasa        := FieldByName('Codigo_Tasa').AsString;
           dInicio          := FieldByName('Fecha_Desde').AsDateTime;
           fValor_Tasa_New  := FieldByName('Valor_Tasa').AsFloat;
           sOperador_Logico := FieldByName('Operador_Logico').AsString;


           if FieldByName('Fecha_Hasta').IsNull then
              dTermino := dFecHasPeriodo
           else
              dTermino := FieldByName('Fecha_Hasta').AsDateTime;

           Close;
           UnPrepare;
       end;
   end;}

   if sValorizacion_Proceso = 'SI' then
      Obtener_Base_Conversion_Mem(sCodigo_Tasa
                             ,sTipo
                             ,fPeriodo
                             ,sAnualidad
                             ,fBase_Porcen
                             ,sModulo_Err
                             ,sString_Err
                             ,Result)
   else
      Obtener_Base_Conversion(sCodigo_Tasa
                             ,sTipo
                             ,fPeriodo
                             ,sAnualidad
                             ,fBase_Porcen
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
   if NOT Result then
      exit;

   if sValorizacion_Proceso = 'SI' then
      Obtener_Base_Conversion_Mem(sNew_Tasa
                             ,sTipo_New
                             ,fPeriodo_New
                             ,sAnualidad_New
                             ,fBase_Porcen_New
                             ,sModulo_Err
                             ,sString_Err
                             ,Result)
   else
      Obtener_Base_Conversion(sNew_Tasa
                             ,sTipo_New
                             ,fPeriodo_New
                             ,sAnualidad_New
                             ,fBase_Porcen_New
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
   if NOT Result then
      exit;

   conversion_tasas(sTipo_New
                   ,fPeriodo_New
                   ,sAnualidad_New
                   ,fBase_Porcen_New
                   ,sTipo
                   ,fPeriodo
                   ,sAnualidad
                   ,fBase_Porcen
                   ,fValor_Tasa_New
                   ,sModulo_Err
                   ,sString_Err
                   ,Result);

   if NOT Result then
      exit;

   if sValorizacion_Proceso = 'SI' then
      Obtener_Tasa_base_Mem(sNew_Tasa
                          ,iBaseDiasDesagio
                          ,sTipoInteresDesagio
                          ,iBaseMensualDesagio
                          ,sTipoCalculoDiasDesagio
                          ,iVigenciaValorDesagio
                          ,iVigenciaMesesDesagio
                          ,sPais_Tasa
                          ,sModulo_err
                          ,sString_err
                          ,Result)
   else
      Obtener_Tasa_base(sNew_Tasa
                       ,iBaseDiasDesagio
                       ,sTipoInteresDesagio
                       ,iBaseMensualDesagio
                       ,sTipoCalculoDiasDesagio
                       ,iVigenciaValorDesagio
                       ,iVigenciaMesesDesagio
                       ,sPais_Tasa
                       ,sModulo_err
                       ,sString_err
                       ,Result);

   if NOT Result then
      exit;

   Convierte_Base(iBaseDiasDesagio
                 ,sTipoInteresDesagio
                 ,fValor_Tasa_New
                 ,iDiasBaseTasa
                 ,sTipoInteresTasa
                 ,fValor_Tasa_New
                 ,sModulo_Err
                 ,sString_Err
                 ,Result);

   if NOT Result then
      exit;

   if dInicio < dFecDesPeriodo then
      dInicio := dFecDesPeriodo;

   if dTermino > dFecHasPeriodo then
      dTermino := dFecHasPeriodo;

   if sOperador_Logico = '>' then
      if fValor_Tasa > fValor_Tasa_New then
         bDesagio         := True;

   if sOperador_Logico = '<' then
      if fValor_Tasa < fValor_Tasa_New then
         bDesagio         := True;
end;
//------------------------------------------------------------------------------
procedure Convierte_Base(iDiasBase       : Integer;
                         sTipoInteres    : String;
                         fValorTasa      : Double;
                         iDiasBaseNew    : Integer;
                         sTipoInteresNew : String;
                         var Valor_Tasa_New : Double;
                         var Modulo_Err     : String;
                         var String_Err     : String;
                         var Result         : Boolean);
var
  base        : Double;
  exponente   : Double;
  fTasaDiaria : Double;
begin
   Result := True;
   Modulo_Err := 'Conversión Base Tasa';

   if iDiasBase = 0 then
   begin
        String_Err := 'Se detecto definición de dias Base para tasa = 0';
        Result := False;
   end;

   try

   if (iDiasBase    = iDiasBaseNew)    and
      (sTipoInteres = sTipoInteresNew) then
   begin
        Valor_Tasa_New := fValorTasa;
        exit;
   end;

   if sTipoInteres = 'S' then
   begin
        fTasaDiaria := fValorTasa * (1 / iDiasBase);
        if sTipoInteresNew = sTipoInteres then  // Simple
           Valor_Tasa_New := fTasaDiaria * iDiasBaseNew
        else
        begin
             base      := 1 + fTasaDiaria / 100;
             exponente := iDiasBaseNew;
             Valor_Tasa_New := (power(base,exponente) - 1) * 100;
        end;
   end
   else
   begin
        Base := 1 + fValorTasa / 100;
        Exponente := 1 / iDiasBase;
        if base = 0 then
           fTasaDiaria := (-1) * 100
        else
           fTasaDiaria := (power(Base,Exponente) - 1) * 100;
        if sTipoInteresNew = sTipoInteres then  // Compuesto
        begin
             base      := 1 + fTasaDiaria / 100;
             exponente := iDiasBaseNew;
             Valor_Tasa_New := (power(base,exponente) - 1) * 100;
        end
        else
           Valor_Tasa_New := fTasaDiaria * iDiasBaseNew;
   end;

   except
     Valor_Tasa_New := 0;
   end;
end;
//------------------------------------------------------------------------------
procedure Convierte_Base_Gestion(iDiasBase       : Integer;
                                 sTipoInteres    : String;
                                 fValorTasa      : Double;
                                 iDiasBaseNew    : Integer;
                                 sTipoInteresNew : String;
                                 var Valor_Tasa_New : Double;
                                 var Modulo_Err     : String;
                                 var String_Err     : String;
                                 var Result         : Boolean);
var
  base        : Double;
  exponente   : Double;
  fTasaDiaria : Double;
begin
   Result := True;
   Modulo_Err := 'Conversión Base Tasa';

   if iDiasBase = 0 then
   begin
        String_Err := 'Se detecto definición de dias Base para tasa = 0';
        Result := False;
   end;

   if sTipoInteres = 'S' then
   begin
        fTasaDiaria := fValorTasa * (1 / iDiasBase);
        if sTipoInteresNew = sTipoInteres then  // Simple
           Valor_Tasa_New := fTasaDiaria * iDiasBaseNew
        else
        begin
             base      := 1 + fTasaDiaria / 100;
             exponente := iDiasBaseNew;
             Valor_Tasa_New := (power(base,exponente) - 1) * 100;
        end;
   end
   else
   begin
        Base := 1 + fValorTasa / 100;
        Exponente := iDiasBaseNew / iDiasBase;
        Valor_Tasa_New := (power(base,exponente) - 1) * 100;
   end;

end;
//------------------------------------------------------------------------------
procedure Obtiene_Tasa_Flotante(var Reg_TasFlot         : TRegistro_TasFlot;
                                Reg_Des                 : TReg_Descriptor;
                                var Reg_Fechas          : TRegistro_Fechas;
                                sMetodo_Tasa_Referencia : String;
                                sTabla_Referencia       : String;
                                iDiasBase_Descriptor    : Integer;
                                sTipoInteres_Descriptor : String;
                                var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                var bTasas_Cargadas     : Boolean;
                                var fValorTasa          : Double;
                                var sModulo_Err         : String;
                                var sString_Err         : String;
                                var Result              : Boolean);
var
  dFecha_Result            : TDateTime;
  iDiasBase_TasFlot        : Integer;
  sTipoInteres_TasFlot,
  sPais_Tasa     : String;
  //sUnidad_Medida_Mon   : String;
  iBaseMensual_TasFlot     : Integer;
  sTipoCalculoDias_TasFlot : String;
  iVigenciaValor_TasFlot   : Integer;
  iVigenciaMeses_TasFlot,
  i                        : Integer;
  sTipo_Descriptor         : String;
  fPeriodo_Descriptor      : Double;
  sAnualidad_Descriptor    : String;
  fBase_Porcen_Descriptor  : Double;
  sTipo_Tasa_Flot          : String;
  fPeriodo_Tasa_Flot       : Double;
  sAnualidad_Tasa_Flot     : String;
  fBase_Porcen_Tasa_Flot   : Double;
  bSin_Tasa                : Boolean;
  sCod_Formula             : String;
  bResult_Cupon            : Boolean;
{
  s0Cod_Tratam_Inicio      : String;
  s1Cod_Tratam_Termino     : String;
  dFecha_Inicio_Tratamiento  : TDatetime;
  dFecha_Termino_Tratamiento : TDatetime;
  bPROMTAS                   : Boolean;
}
begin
   // Si tipo Tasa es '' entonces tasa = 0
   Reg_Fechas.Fecha_Tasa := 0;
   if (Reg_TasFlot.Codigo_Tasa = NULL) OR
      (Reg_TasFlot.Codigo_Tasa = '')   OR
      (Reg_TasFlot.Codigo_Tasa = ' ')  THEN
      begin
        fValorTasa := 0;
        bSin_Tasa  := True;
      end
   else

       { Inhabilitado mientras esta en desarrollo
       // 04-12-2006
       Verifica_Excepcion_PROMTAS_Vigente_Mem ( Reg_Des.Codigo_Emisor
                                               ,Reg_Des.Codigo_Instrumento
                                               ,Reg_Des.Serie
                                               ,Reg_TasFlot.Nro_Cupon
                                               ,Reg_Fechas.Fecha_Calculo
                                               ,s0Cod_Tratam_Inicio
                                               ,s1Cod_Tratam_Termino
                                               ,dFecha_Inicio_Tratamiento
                                               ,dFecha_Termino_Tratamiento
                                               ,bPROMTAS);

      if bPROMTAS then
      begin
        Calcula_PROMTAS( Reg_TasFlot.Codigo_Tasa
                        ,s0Cod_Tratam_Inicio
                        ,s1Cod_Tratam_Termino
                        ,Reg_Fechas
                        ,fValorTasa
                        ,dFecha_Inicio_Tratamiento
                        ,dFecha_Termino_Tratamiento
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);
        if NOT Result then
           exit;

      end;

      if NOT bPROMTAS then
      }



      begin
         // Obtengo fecha a la que se debe obtener el valor Tasa del cupon vigente
           bSin_Tasa := False;
           try
              Busca_Formula_Tasas_Mem(Reg_Fechas.Fecha_Calculo
                                     ,Reg_TasFlot.Codigo_Tasa
                                     ,sCod_Formula
                                     ,Result);
              if not Result then
                 sCod_Formula := '';
           except
              sCod_Formula := '';
           end;
           Result := True;

           if sCod_Formula <> '' then
//              dFecha_Result := Reg_TasFlot.Array_Mem_Desarr[Reg_TasFlot.Nro_Cupon].Fecha_Vcto_Anterior
              dFecha_Result := Array_Mem_Desarr[Reg_TasFlot.Nro_Cupon].Fecha_Vcto_Anterior
           else
           begin
             Tratamiento_Fecha(Reg_TasFlot.Tratamiento
                              ,Reg_Fechas
                              ,dFecha_Result
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);

             if NOT Result then
                exit;
             //D.C. & F.I. 13-07-2011
//             Reg_TasFlot.Array_Mem_Desarr[Reg_TasFlot.Nro_Cupon].Fecha_Tasa_Flotante := dFecha_Result;
             Array_Mem_Desarr[Reg_TasFlot.Nro_Cupon].Fecha_Tasa_Flotante := dFecha_Result;
         end;

         // Solo lee el valor de la tasa para las fechas anteriores a la fecha de calculo
         // esto se hizo para que cuando se reprocese mantenga los valores originales
         // a esa fecha.
         // Si reproceso en Febrero no puedo usar tasas que fueron ingresadas en Marzo
         sString_Err := '';
           // F.I. 01-12-2020
//         if (dFecha_Result <= Reg_Fechas.Fecha_Calculo) then
         if (dFecha_Result <= Reg_Fechas.Fecha_Calculo) and
            (dFecha_Result <= dfecha_hora ) then   // fecha_hora_Servidor 02-02-2023
         begin
            // F.I. 02-09-2020
           if sCod_Formula <> '' then
           begin
              //ggarcia 12-01-2021
              if Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Emision then
              begin
                 fValorTasa := 0;
                 Result     := True;
              end
              else
              begin
                 // Busco valor de tasa a fecha correspondiente
                 // ggarcia 10-12-2012 Si tiene definicion de formula, Calcula la tasa.
                 leer_valor_formula(Reg_TasFlot.Codigo_Tasa
                                   ,Array_Mem_Desarr[Reg_TasFlot.Nro_Cupon].Fecha_Vcto_Anterior
                                   ,Array_Mem_Desarr[Reg_TasFlot.Nro_Cupon].Fecha_Vcto
                                   ,sMetodo_Tasa_Referencia
                                   ,bResult_Cupon
                                   ,Reg_Des // Reg_TasFlot.RegDes
                                   ,Reg_TasFlot.ConCupon
                                   ,dFecha_Result
                                   ,Reg_Fechas.Fecha_Calculo
                                   ,sCod_Formula
                                   ,fValorTasa
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);
                 if NOT Result then
                    exit;

                 if fValorTasa = -999 then // Valor tasa -999 lo usamos para identificar caso
                                           // que debe proyectar valor tasa que no se pudo calcular.
                 begin
                    dFecha_Result := dfecha_hora;
                    Result := False;
                 end;
              end;
           end
           else
               leer_valor_cambio2(Reg_TasFlot.Codigo_Tasa
                                 ,Reg_TasFlot.Codigo_Tasa
                                 ,'BC'
                                 ,dFecha_Result
                                 ,fValorTasa
                                 ,Result);
            Reg_Fechas.Fecha_Tasa := dFecha_Result;
         end
         else
             Result := False;

         if Result then
            if sMetodo_Tasa_Referencia = 'FUTUROIMP' then
               begin       // Almacena valores para ser usados cuando no los encuentre
                 Registra_Datos_Tasa_Encontrada(sTabla_Referencia+'_Aux'
                                               ,Reg_TasFlot.Codigo_Tasa
                                               ,dFecha_Result
                                               ,fValorTasa
                                               ,Reg_Fechas.Fecha_Inic_Periodo
                                               ,Reg_Fechas.Fecha_Vcto_Periodo)
               end;


         if NOT Result then
            begin
              // Si no encontro tasa y la fecha en que se busca es anterior
              // a la fecha de calculo. ES UN ERROR ...
              // Deben haberse actualizado las tasas correspondientes al proceso
              if (dFecha_Result <= Reg_Fechas.Fecha_Calculo) AND (dFecha_Result <= dFecha_Hora) AND (fValorTasa <> -999) then
//              if (dFecha_Result <= Reg_Fechas.Fecha_Calculo) AND (dFecha_Result <= fecha_hora_Servidor) AND (fValorTasa <> -999) then
              begin
                sModulo_Err := 'Obtención de Valores Tasa';
                if sString_Err = '' then   // ggarcia 14-12-2012 Si es <> de blanco es que se lo asigno la funcion leer_valor_formula
                   sString_Err := 'No se encontro Valor para '+Reg_TasFlot.Codigo_Tasa
                                 +'. Con Fecha :'+DateToStr(dFecha_Result);
                exit;
              end;

              if sMetodo_Tasa_Referencia = 'FUTUROIMP' then
                 begin
                   if Reg_Fechas.Fecha_Vcto_Periodo >= Reg_Fechas.Fecha_Calculo then
                      begin
                        // Busco valor de tasa a fecha de calculo
                        // Solo si la fecha de calculo es posterior
                        // a la fecha de vencimiento del cupon
                        leer_valor_cambio2(Reg_TasFlot.Codigo_Tasa
                                          ,Reg_TasFlot.Codigo_Tasa
                                          ,'BC'
                                          ,Reg_Fechas.Fecha_Calculo
                                          ,fValorTasa
                                          ,Result);


                     if Result then
                        begin
                          Reg_Fechas.Fecha_Tasa := Reg_Fechas.Fecha_Calculo;
                          // Si encuentro valor de tasa a fecha de calculo
                          // Repaso tabla para Futuros Implicitos con esta tasa
                          Registra_Datos_Tasa_Encontrada(sTabla_Referencia+'_Aux'
                                                        ,Reg_TasFlot.Codigo_Tasa
                                                        ,Reg_Fechas.Fecha_Calculo
                                                        ,fValorTasa
                                                        ,Reg_Fechas.Fecha_Inic_Periodo
                                                        ,Reg_Fechas.Fecha_Vcto_Periodo)
                        end;
                     end;
                   // Aplica metodo Futuros Implicitos

                   // Cargo datos para calculo de Futuros Implicitos
                   Recupera_y_Almacena_Valores_Ult_Tasa(sTabla_Referencia
                                                       ,sModulo_Err
                                                       ,sString_Err
                                                       ,Result);

                   Tasa_Futuros_Implicitos(sTabla_Referencia
                                          ,Reg_Fechas
                                          ,iDiasBase_Descriptor
                                          ,sTipoInteres_Descriptor
                                          ,Reg_Des
                                          ,Array_Mem_Desarr
                                          ,Reg_TasFlot
                                          ,bTasas_Cargadas
                                          ,sModulo_Err
                                          ,sString_Err
                                          ,Result);
                   if NOT Result then
                      begin
                        exit;
                      end;
                 end
              else
              if (sMetodo_Tasa_Referencia = 'CURVAS')     or
                 (sMetodo_Tasa_Referencia = 'CURVA_FIJA') then
                 begin
                   Proyecta_Flujos_por_Curvas( Reg_Des // Reg_TasFlot.RegDes
                                              ,Reg_Fechas
                                              ,Reg_TasFlot.Nro_Cupon
                                              ,sMetodo_Tasa_Referencia
                                              ,Array_Mem_Desarr
                                              ,sModulo_Err
                                              ,sString_Err
                                              ,Result);
                   bTasas_Cargadas := True;
                   exit;
                 end
                 else
      //        if sMetodo_Tasa_Referencia = 'PROYSIMPLE' then

                 if (dFecha_Result >= Reg_Fechas.Fecha_Calculo) or
                    (dFecha_Result >= dfecha_hora) then
                    // (dFecha_Result >= fecha_hora_Servidor) then 12-9-2017 

                 begin
                   // Tratatando de rebaja los tiempos !!!! 19-05-2011 F.I.Lima
                      i                         := Reg_TasFlot.Nro_Cupon;
                      if i > 1 then
                      if (Array_Mem_Desarr[i-1].Real_Estimado = 'PROYSIMPLE') then
                      begin
                        // fValorTasa                := Reg_TasFlot.Array_Mem_Desarr[i-1].Valor_Tasa; MALO !!!! F.I. 08-08-2014
                        fValorTasa                := Array_Mem_Desarr[i-1].Tasa_Flujo;
                        Reg_Fechas.Fecha_Tasa     := Array_Mem_Desarr[i-1].Fecha_Tasa;
                        Reg_TasFlot.Tasa_Flujo    := Array_Mem_Desarr[i-1].Tasa_Flujo;
                        Reg_TasFlot.Real_Estimada := Array_Mem_Desarr[i-1].Real_Estimado;

                        // El while no servia ya que dejaria todos los cupones restantes iguales
                        // sin considerar que puede camfiar el factor en los siguientes cupones (spread)
                        //while Reg_TasFlot.Array_Mem_Desarr[i].Nro_Cupon <> 0 do
                        //begin
                           Array_Mem_Desarr[i].Valor_Tasa    := fValorTasa;
                           Array_Mem_Desarr[i].Fecha_Tasa    := Reg_Fechas.Fecha_Tasa;
                           Array_Mem_Desarr[i].Tasa_Flujo    := Reg_TasFlot.Tasa_Flujo;
                           Array_Mem_Desarr[i].Real_Estimado := Reg_TasFlot.Real_Estimada;
                        //   Inc(i);
                        //end;
                        // bTasas_Cargadas := True; --> No corresponde ya que con esto no hace los otros calculos
                        Result          := True;
                        // exit;   08-08-2014  Debe seguir para apolivar el "factor" (apread) y
                                   // hacer las conmversiones de tasas que estan mas abajo F.I.
                      end;

                   //ggarcia 28-11-2017
                   // Si se calcula la tasa por formula y el metodo es PROYSIMPLE se calculara de acuerdo al metodo ULTIMOVCTO.
                   //if sMetodo_Tasa_Referencia = 'ULTIMOVCTO' then
                   if  (sMetodo_Tasa_Referencia = 'ULTIMOVCTO') or
                      ((sMetodo_Tasa_Referencia = 'PROYSIMPLE') and (sCod_Formula <> '')) then
                   begin
                      i                         := Reg_TasFlot.Nro_Cupon;
                      if i > 1 then
                      begin
                        fValorTasa                := Array_Mem_Desarr[i-1].Valor_Tasa;
                        Reg_Fechas.Fecha_Tasa     := Array_Mem_Desarr[i-1].Fecha_Tasa;
                        Reg_TasFlot.Tasa_Flujo    := Array_Mem_Desarr[i-1].Tasa_Flujo;
                        Reg_TasFlot.Real_Estimada := sMetodo_Tasa_Referencia;

//                        while Reg_TasFlot.Array_Mem_Desarr[i].Nro_Cupon <> 0 do
                        While (i <=  Max_Nro_Cupones) do
                        begin
                           Array_Mem_Desarr[i].Valor_Tasa    := fValorTasa;
                           Array_Mem_Desarr[i].Fecha_Tasa    := Reg_Fechas.Fecha_Tasa;
                           Array_Mem_Desarr[i].Tasa_Flujo    := Reg_TasFlot.Tasa_Flujo;
                           Array_Mem_Desarr[i].Real_Estimado := Reg_TasFlot.Real_Estimada;
                           Inc(i);
                        end;
                        bTasas_Cargadas := True;
                        Result          := True;

                      end
                      else
                      begin
                        if dfecha_hora > Reg_Fechas.Fecha_Calculo then
                           dFecha_Result := Reg_Fechas.Fecha_Calculo
                        else
                           dFecha_Result := dfecha_hora;

                           Tasa_Proyeccion_Simple(Reg_TasFlot.Codigo_Tasa
//                           Tasa_Proyeccion_Simple_Mem(Reg_TasFlot.Codigo_Tasa
                                              ,dFecha_Result
                                              ,Reg_Fechas.Fecha_Tasa
                                              ,Reg_TasFlot.Real_Estimada
                                              ,fValorTasa
                                              ,sModulo_Err
                                              ,sString_Err
                                              ,Result);
                           if NOT Result then
                           begin
                              if sCod_Formula <> '' then
                                 sString_Err := sString_Err + '(Calcular)';
                              exit;
                           end;
                      end;
                   end
                   else
                   if (Array_Mem_Desarr[i].Real_Estimado <> 'PROYSIMPLE') then
                   begin
// E.S., lo comenté porque hace muchas veces lectura en la rutina fecha_hora_Servidor 12-08-2010
//                      if fecha_hora_Servidor > Reg_Fechas.Fecha_Calculo then
//                         dFecha_Result := Reg_Fechas.Fecha_Calculo
//                      else
//                         dFecha_Result := fecha_hora_Servidor;

//                      if dfecha_hora is Null then
//                         dfecha_hora := fecha_hora_Servidor;

                      if dfecha_hora > Reg_Fechas.Fecha_Calculo then
                         dFecha_Result := Reg_Fechas.Fecha_Calculo
                      else
                         dFecha_Result := dfecha_hora;

//                         Tasa_Proyeccion_Simple_Mem(Reg_TasFlot.Codigo_Tasa
                         Tasa_Proyeccion_Simple(Reg_TasFlot.Codigo_Tasa
                                            ,dFecha_Result
                                            ,Reg_Fechas.Fecha_Tasa
                                            ,Reg_TasFlot.Real_Estimada
                                            ,fValorTasa
                                            ,sModulo_Err
                                            ,sString_Err
                                            ,Result);
                      if NOT Result then
                           begin
                              if sCod_Formula <> '' then
                                 sString_Err := sString_Err + '(Calcular)';
                              exit;
                           end;
                   end;// FIN if sMetodo_Tasa_Referencia = 'ULTIMOVCTO' then
                 end;
            end;

         if NOT Result then
            begin
              sModulo_Err := 'Obtención Valor Tasa';
              if sCod_Formula <> '' then
                 sString_Err := 'No pudo calcular tasa '+Reg_TasFlot.Codigo_Tasa
                                +' con fecha : '+DateToStr(dFecha_Result)
              else
                 sString_Err := 'No pudo obtener tasa '+Reg_TasFlot.Codigo_Tasa
                                +' con fecha : '+DateToStr(dFecha_Result);

              exit;
            end;

         if bTasas_Cargadas then
            exit;
      end;

   Reg_TasFlot.Tasa_Flujo := fValorTasa;

   if NOT bSin_Tasa then
   begin
        if sValorizacion_Proceso = 'SI' then
          Obtener_Base_Conversion_Mem(
//                                      Reg_TasFlot.RegDes.TASA_VALOR_PAR   //Reg_Des.TASA_VALOR_PAR
                                      Reg_Des.TASA_VALOR_PAR   //Reg_Des.TASA_VALOR_PAR
                                     ,sTipo_Descriptor
                                     ,fPeriodo_Descriptor
                                     ,sAnualidad_Descriptor
                                     ,fBase_Porcen_Descriptor
                                     ,sModulo_Err
                                     ,sString_Err
                                     ,Result)

        else
           Obtener_Base_Conversion(
//                                   Reg_TasFlot.RegDes.TASA_VALOR_PAR   //Reg_Des.TASA_VALOR_PAR
                                   Reg_Des.TASA_VALOR_PAR
                                  ,sTipo_Descriptor
                                  ,fPeriodo_Descriptor
                                  ,sAnualidad_Descriptor
                                  ,fBase_Porcen_Descriptor
                                  ,sModulo_Err
                                  ,sString_Err
                                  ,Result);
        if NOT Result then
           exit;

        if sValorizacion_Proceso = 'SI' then
           Obtener_Base_Conversion_Mem(Reg_TasFlot.Codigo_Tasa
                                  ,sTipo_Tasa_Flot
                                  ,fPeriodo_Tasa_Flot
                                  ,sAnualidad_Tasa_Flot
                                  ,fBase_Porcen_Tasa_Flot
                                  ,sModulo_Err
                                  ,sString_Err
                                  ,Result)
        else
           Obtener_Base_Conversion(Reg_TasFlot.Codigo_Tasa
                                  ,sTipo_Tasa_Flot
                                  ,fPeriodo_Tasa_Flot
                                  ,sAnualidad_Tasa_Flot
                                  ,fBase_Porcen_Tasa_Flot
                                  ,sModulo_Err
                                  ,sString_Err
                                  ,Result);
        if NOT Result then
           exit;
      end;

   aplica_operacion(fValorTasa
                   ,Reg_TasFlot.Factor
                   ,Reg_TasFlot.Operacion
                   ,fBase_Porcen_Tasa_Flot
//                   ,Reg_TasFlot.RegDes.TIPO_AJUSTE   //Reg_Des.TIPO_AJUSTE
//                   ,Reg_TasFlot.RegDes.DECIMAL_AJUSTE     //Reg_Des.DECIMAL_AJUSTE
                   ,Reg_Des.TIPO_AJUSTE
                   ,Reg_Des.DECIMAL_AJUSTE
                   ,fValorTasa
                   ,sModulo_Err
                   ,sString_Err
                   ,Result);

  if NOT Result then
     exit;

  if bSin_Tasa then
     exit;

  // Si la operación es factorización NO DEBE CONVERTIR TASAS !!!
  // P.M. - D.Q. - F.I. 04-11-2010
  if (trim(Reg_TasFlot.Operacion) <> 'F*F') then
  begin
      // Convierte si corresponde de Nominales a Efectivas
      // y de Anticipadas a Vencidas
      // Lleva de la tasa flotante a la definida en el descriptor
      conversion_tasas(sTipo_Tasa_Flot
                      ,fPeriodo_Tasa_Flot
                      ,sAnualidad_Tasa_Flot
                      ,fBase_Porcen_Tasa_Flot
                      ,sTipo_Descriptor
                      ,fPeriodo_Descriptor
                      ,sAnualidad_Descriptor
                      ,fBase_Porcen_Descriptor
                      ,fValorTasa
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

      if NOT Result then
         exit;

      if sValorizacion_Proceso = 'SI' then
         Obtener_Tasa_base_Mem(Reg_TasFlot.Codigo_Tasa
                              ,iDiasBase_TasFlot
                              ,sTipoInteres_TasFlot
                              ,iBaseMensual_TasFlot
                              ,sTipoCalculoDias_TasFlot
                              ,iVigenciaValor_TasFlot
                              ,iVigenciaMeses_TasFlot
                              ,sPais_Tasa
                              ,sModulo_err
                              ,sString_err
                              ,Result)
      else
         Obtener_Tasa_base(Reg_TasFlot.Codigo_Tasa
                         ,iDiasBase_TasFlot
                         ,sTipoInteres_TasFlot
                         ,iBaseMensual_TasFlot
                         ,sTipoCalculoDias_TasFlot
                         ,iVigenciaValor_TasFlot
                         ,iVigenciaMeses_TasFlot
                         ,sPais_Tasa
                         ,sModulo_err
                         ,sString_err
                         ,Result);

      if NOT Result then
         exit;

      // Solo si la tasa flotante no es base variable
      // Se debe convertir la base
      // Recordar que CUANDO la tasa flotante es de base variable
      // los días Base descriptor ya vienen con los dias de la tasa flotante
      if NOT Reg_TasFlot.Base_TasFlot_Variable then
        Convierte_Base(iDiasBase_TasFlot             // de los dias base de la Tasa Flotante
                    ,sTipoInteres_TasFlot
                    ,fValorTasa
                    ,iDiasBase_Descriptor          // a los Dias Base del Descriptor
                    ,sTipoInteres_Descriptor
                    ,fValorTasa
                    ,sModulo_Err
                    ,sString_Err
                    ,Result);

      if NOT Result then
         exit;
  end;

//  fValorTasa := ajusta_decimales(Reg_TasFlot.RegDes.TIPO_AJUSTE       //Reg_Des.TIPO_AJUSTE
  fValorTasa := ajusta_decimales(Reg_Des.TIPO_AJUSTE
                                ,fValorTasa
                                ,Trunc(Reg_Des.DECIMAL_AJUSTE));

end;
//------------------------------------------------------------------------------
procedure Tasa_Proyeccion_Simple(sCodigo_Tasa       : String;
                                 dFecha             : TDateTime;
                                 var dFecha_Tasa    : TDateTime;
                                 var sReal_Estimada : String;
                                 var fValor_Tasa    : Double;
                                 var sModulo_Err    : String;
                                 var sString_Err    : String;
                                 var Result         : Boolean );
Var
   sTipo_variacion : String;
   sUnidad_Conversion : String;
   sTipo_Moneda       : String;
   sTipo_Unidad       : String;
   sUnidad            : String;

begin
  // Modificado para trabajar con indices !!!!
  Result := False;
  sModulo_Err := '';
  sString_Err := '';

  WITH dmComunInversiones.QRY_General do
    begin
       // E.S. & F.I. 24-05-2011 Buscando rapidesz
       sTipo_Variacion := '';
       Busca_Valores_Monedas_Periodo_Mem( sCodigo_Tasa,
                                          sUnidad_Conversion,
                                          sTipo_Moneda,
                                          sTipo_Unidad,
                                          sUnidad,
                                          sTipo_Variacion
                                          );
       if (sTipo_Variacion = '') then
       Begin
          sModulo_Err := 'Obtención Valor (PROYECCION SIMPLE)';
          sString_Err := 'No se encontro el tipo variación (periodos) para '+sCodigo_Tasa+#10
                        +'Con Fecha : '+DateToStr(dFecha)+'.';
       end
       else
       begin
          Result := True;
          //sTipo_variacion := FieldByName('tipo_variacion').AsString;
          //sUnidad_Conversion := FieldByName('Unidad_Conversion').AsString;
//          Close;     // Edosan
//          SQL.Clear;
//          SQL.Add('SELECT a.Valor_Moneda'
//                 +'      ,a.Fecha_Paridad'
//                 +'  FROM qs_sys_val_cambio a'
//                 +' WHERE a.Fecha_Paridad in (SELECT MAX(b.Fecha_Paridad)'
//                                            +'  FROM qs_sys_val_cambio b' );
//                                            If sTipo_variacion = 'A' Then
//                                               SQL.Add(' WHERE b.Fecha_Paridad < :Fecha'  )
//                                            Else
//                                               SQL.Add(' WHERE b.Fecha_Paridad <= :Fecha' );
//
//                                               SQL.Add(' AND b.Cod_Moneda      = :Cod_Moneda'
//                                                 +'   AND b.Moneda_Paridad  = :Moneda_Paridad'
//                                                 +'   AND b.Tipo_de_Paridad = :Tipo_de_Paridad)'
//                 +'   AND a.Cod_Moneda      = :Cod_Moneda'
//                 +'   AND a.Moneda_Paridad  = :Moneda_Paridad'
//                 +'   AND a.Tipo_de_Paridad = :Tipo_de_Paridad'
//                 );


          If sTipo_variacion = 'A' Then
          begin
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.ParamByName('Cod_Moneda').AsString := sCodigo_Tasa;
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.ParamByName('Moneda_Paridad').AsString := sUnidad_Conversion;
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.ParamByName('Tipo_de_Paridad').AsString := 'BC';
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.ParamByName('Fecha').AsDate        := dFecha;    //xxxDateTime 17-08-2018
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.Open;

                if (dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.FieldByName('Valor_Moneda').IsNull) then
                    begin
                      sReal_Estimada := '';
                      sModulo_Err := 'Obtención Valor Tasa (PROYECCION SIMPLE)';
                      sString_Err := 'No se encontro valor para '+sCodigo_Tasa+#10
                                    +'Con Fecha : '+DateToStr(dFecha)+'.';
                      Result := False;
                    end
                else
                   begin
                     fValor_Tasa := dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.FieldByName('Valor_Moneda').AsFloat;
                     dFecha_Tasa := dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.FieldByName('Fecha_Paridad').AsDateTime;
                     sReal_Estimada := 'PROYSIMPLE';
                     Result := True;
                   end;
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_Anual.Close;
          end
          else
          begin
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.ParamByName('Cod_Moneda').AsString      := sCodigo_Tasa;
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.ParamByName('Moneda_Paridad').AsString  := sUnidad_Conversion;
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.ParamByName('Tipo_de_Paridad').AsString := 'BC';
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.ParamByName('Fecha').AsDate             := dFecha;    //xxxDateTime 17-08-2018
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.Open;

                if (dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.FieldByName('Valor_Moneda').IsNull) then
                    begin
                      sReal_Estimada := '';
                      sModulo_Err := 'Obtención Valor Tasa (PROYECCION SIMPLE)';
                      sString_Err := 'No se encontro valor para '+sCodigo_Tasa+#10
                                    +'Con Fecha : '+DateToStr(dFecha)+'.';
                      Result := False;
                    end
                else
                   begin
                     fValor_Tasa := dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.FieldByName('Valor_Moneda').AsFloat;
                     dFecha_Tasa := dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.FieldByName('Fecha_Paridad').AsDateTime;
                     sReal_Estimada := 'PROYSIMPLE';
                     Result := True;
                   end;
                dmComunInversiones.Qry_Tasa_Proyeccion_Simple_NoAnual.Close;
          end;
       end;
    end;
end;
//------------------------------------------------------------------------------
procedure Valor_Cambio_Proyeccion_Simple(sMon_Origen        : String;
                                         sMon_Paridad       : String;
                                         dFecha             : TDateTime;
                                         sTipo_Paridad      : String;
                                         var fValor_Paridad : Double;
                                         var sModulo_Err    : String;
                                         var sString_Err    : String;
                                         var Result         : Boolean );
begin
  Result := False;
  sModulo_Err := '';
  sString_Err := '';

  // 03-01-2025 Si las monedas son iguales no hay que buscar nada la paridad es 1 (F.I.)
  if sMon_Origen = sMon_Paridad then
  begin
     fValor_Paridad := 1;
     Result := True;
     exit;
  end;


  WITH dmComunInversiones.QRY_General do
  begin
     Result := True;
     Close;
     SQL.Clear;
     SQL.Add('SELECT a.Valor_Moneda'
            +'  FROM qs_sys_val_cambio a'
            +' WHERE a.Fecha_Paridad in (SELECT MAX(b.Fecha_Paridad) '
                                       +'  FROM qs_sys_val_cambio b '
                                       +' WHERE b.Fecha_Paridad  <= :Fecha'
                                       +'   AND b.Cod_Moneda      = :Cod_Moneda'
                                       +'   AND b.Moneda_Paridad  = :Moneda_Paridad'
                                       +'   AND b.Tipo_de_Paridad = :Tipo_de_Paridad)'
            +'   AND a.Cod_Moneda      = :Cod_Moneda'
            +'   AND a.Moneda_Paridad  = :Moneda_Paridad'
            +'   AND a.Tipo_de_Paridad = :Tipo_de_Paridad'
            );
     ParamByName('Cod_Moneda'    ).AsString  := sMon_Origen;
     ParamByName('Moneda_Paridad').AsString  := sMon_Paridad;
     ParamByName('Tipo_de_Paridad').AsString := sTipo_Paridad;
     ParamByName('Fecha').AsDate             := dFecha;
     Prepare;
     Open;
     if (FieldByName('Valor_Moneda').IsNull) then
     begin
         {Busco a reves (solo una vez por re_llamado}
         if NOT re_llamado then
         begin
           re_llamado := True;
           Valor_Cambio_Proyeccion_Simple(sMon_Paridad
                                         ,sMon_Origen
                                         ,dFecha
                                         ,sTipo_Paridad
                                         ,fValor_Paridad
                                         ,sModulo_Err
                                         ,sString_Err
                                         ,Result);
           if Result then
           begin
              if fValor_Paridad <> 0 then
                 fValor_Paridad := 1 / fValor_Paridad
              else
                 fValor_Paridad := 0;
              Result := True;
           end
           else
           begin
              sModulo_Err := 'Obtención Tipo Cambio (PROYECCION SIMPLE)';
              sString_Err := 'No se registra paridad '+sTipo_Paridad+' de '+trim(sMon_Origen)
                             +' a '+trim(sMon_Paridad)+#10
                             +'con fecha: '+datetostr(dFecha);
              Result := False;
           end;
           re_llamado := False;
         end
         else
         begin
            sModulo_Err := 'Obtención Tipo Cambio (PROYECCION SIMPLE)';
            sString_Err := 'No se registra paridad '+sTipo_Paridad+' de '+trim(sMon_Paridad)
                           +' a '+trim(sMon_Origen)+#10
                           +'con fecha: '+datetostr(dFecha);
            Result := False;
         end;
     end
     else
     begin
        fValor_Paridad := FieldByName('Valor_Moneda').AsFloat;
        Result := True;
     end;
     Close;
     UnPrepare;
  end;
end;
//------------------------------------------------------------------------------
procedure Tasa_Futuros_Implicitos(sNombreTablaReferencia  : String;
                                  Reg_Fechas              : TRegistro_Fechas;
                                  iDiasBase_Descriptor    : Integer;
                                  sTipoInteres_Descriptor : String;
                                  Reg_Des                 : TReg_Descriptor;
                                  var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                  var Reg_TasFlot         : TRegistro_TasFlot;
                                  var bTasas_Cargadas     : Boolean;
                                  var sModulo_Err         : String;
                                  var sString_Err         : String;
                                  var Result              : Boolean );
var
  iDiasBase_TasFlot        : Integer;
  sTipoInteres_TasFlot,
  sPais_Tasa               : String;
  iBaseMensual_TasFlot     : Integer;
  sTipoCalculoDias_TasFlot : String;
  iVigenciaValor_TasFlot   : Integer;
  fVigenciaValor           : Double;
  iVigenciaMeses_TasFlot   : Integer;

  sTipo_Tasa_Flot          : String;
  fPeriodo_Tasa_Flot       : Double;
  sAnualidad_Tasa_Flot     : String;
  fBase_Porcen_Tasa_Flot   : Double;

  sTipo_Descriptor         : String;
  fPeriodo_Descriptor      : Double;
  sAnualidad_Descriptor    : String;
  fBase_Porcen_Descriptor  : Double;

  i                        : Integer;
  iCupon                   : Integer;
  iArray                   : Integer;
  iCuponVigente            : Integer;
  fDifDias                 : Double;

  fValor_Limite_Inferior   : Double;
  fValor_Limite_Superior   : Double;
//  Array_Interpolacion      : Array[1..Max_Nro_Cupones] of TInterpolacion;
  Array_Interpolacion      : Array of TInterpolacion;
  bInterpolar              : Boolean;
  bBuscar                  : Boolean;

  LimInf                   : Double;
  LimSup                   : Double;

  fPeriodo_Desde_Inferior  : Double;
  fPeriodo_Hasta_Inferior  : Double;

  fPeriodo_Desde_Superior  : Double;
  fPeriodo_Hasta_Superior  : Double;

  bDiferentes_Periodos     : Boolean;

  sTipo_Ajuste             : String;
  iDecimales_Redondeo      : Integer;

begin
  SetLength(Array_Interpolacion, Max_Nro_Cupones+1);

  bInterpolar := True; // Debe realizar interpolacion de tasas

  // Si no viene la tabla de referencias de tasas anteriores
  // no se puede aplicar el metodo
  // por lo tanto no almacena nada y retorna
  // Esto debido a que ese metodo se usa solo para estimacion de
  // flujos de la tabla de desarrollo

  if sNombreTablaReferencia = '' then
     begin
       Result := False;
       exit;
     end;

 if sValorizacion_Proceso = 'SI' then
    Leer_MonRedon_Mem(Reg_TasFlot.Codigo_Tasa
              ,Reg_Fechas.Fecha_Calculo
              ,sTipo_Ajuste
              ,iDecimales_Redondeo)
 else
    Leer_MonRedon(Reg_TasFlot.Codigo_Tasa
              ,Reg_Fechas.Fecha_Calculo
              ,sTipo_Ajuste
              ,iDecimales_Redondeo);

 if sValorizacion_Proceso = 'SI' then
    Obtener_Tasa_base_mem(Reg_TasFlot.Codigo_Tasa
                     ,iDiasBase_TasFlot
                     ,sTipoInteres_TasFlot
                     ,iBaseMensual_TasFlot
                     ,sTipoCalculoDias_TasFlot
                     ,iVigenciaValor_TasFlot
                     ,iVigenciaMeses_TasFlot
                     ,sPais_Tasa
                     ,sModulo_err
                     ,sString_err
                     ,Result)
 else
    Obtener_Tasa_base(Reg_TasFlot.Codigo_Tasa
                     ,iDiasBase_TasFlot
                     ,sTipoInteres_TasFlot
                     ,iBaseMensual_TasFlot
                     ,sTipoCalculoDias_TasFlot
                     ,iVigenciaValor_TasFlot
                     ,iVigenciaMeses_TasFlot
                     ,sPais_Tasa
                     ,sModulo_err
                     ,sString_err
                     ,Result);

  if NOT Result then
     exit;

  if iVigenciaValor_TasFlot = 0 then
     begin
       sModulo_Err := 'Calculo de Futuros Implicitos';
       sString_Err := 'Vigencia Tasa no puede ser cero ('
                     +Reg_TasFlot.Codigo_Tasa
                     +').';
       Result := False;
       exit;
     end;

  if sValorizacion_Proceso = 'SI' then
     Obtener_Base_Conversion_Mem(Reg_TasFlot.Codigo_Tasa
                            ,sTipo_Tasa_Flot
                            ,fPeriodo_Tasa_Flot
                            ,sAnualidad_Tasa_Flot
                            ,fBase_Porcen_Tasa_Flot
                            ,sModulo_Err
                            ,sString_Err
                            ,Result)
  else
     Obtener_Base_Conversion(Reg_TasFlot.Codigo_Tasa
                            ,sTipo_Tasa_Flot
                            ,fPeriodo_Tasa_Flot
                            ,sAnualidad_Tasa_Flot
                            ,fBase_Porcen_Tasa_Flot
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);

  if NOT Result then
     exit;

  if sValorizacion_Proceso = 'SI' then
    Obtener_Base_Conversion_mem(Reg_Des.TASA_VALOR_PAR
                         ,sTipo_Descriptor
                         ,fPeriodo_Descriptor
                         ,sAnualidad_Descriptor
                         ,fBase_Porcen_Descriptor
                         ,sModulo_Err
                         ,sString_Err
                         ,Result)
  else
    Obtener_Base_Conversion(Reg_Des.TASA_VALOR_PAR
                         ,sTipo_Descriptor
                         ,fPeriodo_Descriptor
                         ,sAnualidad_Descriptor
                         ,fBase_Porcen_Descriptor
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);

  if NOT Result then
     exit;


  // Inicializo para saber que valores cargue despues
  // O sea si Array_Interpolacion[i].Nro_Cupon = 0
  // Significa que no se ha guardado nada
  for i := 1 to Max_Nro_Cupones do
      Array_Interpolacion[i].Nro_Cupon   := 0;

  Cupon_Vigente(Array_Mem_Desarr
               ,Reg_Des
               ,Reg_Fechas.Fecha_Calculo
               ,Reg_TasFlot.ConCupon
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  iCupon := iCuponVigente;   // Indice para recorrer tabla de desarrollo

  // Cargo en tabla de desarrollo los dias al vencimiento a partir de la fecha de calculo
  // Si la fecha de emision o la fecha de vencimiento de cualquiera de los cupones
  // coincide con la fecha de calculo NO SE DEBE INTERPOLAR esto segun
  // los documentos de Colombia Filigara-Miami-01-Nov-2000

  if Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Emision then
     bInterpolar := False;

//  While (iCupon = Reg_TasFlot.Array_Mem_Desarr[iCupon].Nro_Cupon) do  // Recorre la tabla de desarrollo mientras existen cupones
  While (iCupon <= Max_Nro_Cupones) do  // Recorre la tabla de desarrollo mientras existen cupones
    begin
      fDifDias := Array_Mem_Desarr[iCupon].Fecha_Vcto - Reg_Fechas.Fecha_Calculo;
      Array_Mem_Desarr[iCupon].Dias_Al_Vcto := fDifDias;
      if fDifDias = 0 then
         bInterpolar := False;  // Si uno de los vencimientos coincide con la fecha
                                   // de calculo NO SE NECESITA INTERPOLAR

      iCupon := iCupon + 1;
    end;

  // Cargo arreglo con pares de limites por cupon
  iCupon := Reg_TasFlot.Nro_Cupon;  // Reg_TasFlot.Nro_Cupon es el Cupon para el que no encontre tasa
  iArray := 1;
//  While (iCupon = Reg_TasFlot.Array_Mem_Desarr[iCupon].Nro_Cupon) do  // Recorre la tabla de desarrollo mientras existen cupones
  While (iCupon <= Max_Nro_Cupones) do  // Recorre la tabla de desarrollo mientras existen cupones
    begin
       Array_Interpolacion[iArray].Nro_Cupon :=
                                 Array_Mem_Desarr[iCupon].Nro_Cupon;

       if (iCupon - 1 = 0) then
          Array_Interpolacion[iArray].Limite_Inf := 0
       else
          Array_Interpolacion[iArray].Limite_Inf := Array_Mem_Desarr[iCupon-1].Dias_Al_Vcto;

       Array_Interpolacion[iArray].Limite_Sup       := Array_Mem_Desarr[iCupon].Dias_Al_Vcto;
       Array_Interpolacion[iArray].Tasa_Interpolada := 0;
       iCupon := iCupon + 1;
       iArray := iArray + 1;
    end;


    bBuscar := True; // Para que busque valores de limites
    iArray := 1;
    While (Array_Interpolacion[iArray].Nro_Cupon <> 0) AND (iArray <= Max_Nro_Cupones)  do
      begin
        if bBuscar then  // Cuando es Buscar Calcula Interpolacion
           begin
             WITH dmComunInversiones.QRY_Paradox do
               begin
                 // Busco tasa para limite Inferior
                 SQL.Clear;
                 SQL.Add('SELECT Valor_Implicito');
                 SQL.Add('      ,Dias_Desde');
                 SQL.Add('      ,Dias_Hasta');
                 SQL.Add('  FROM '+sNombreTablaReferencia);
                 SQL.Add(' WHERE :Limite_Inf > Dias_Desde');
                 SQL.Add('   AND :Limite_Inf <= Dias_Hasta');

                 if Array_Interpolacion[iArray].Limite_Inf = 0 then
                    ParamByName('Limite_Inf').AsFloat := 1
                 else
                    ParamByName('Limite_Inf').AsFloat := Array_Interpolacion[iArray].Limite_Inf;

                 Prepare;
                 Open;

                 if FieldByName('Valor_Implicito').IsNUll then
                    begin
                      // Buscar es False para que mantenga el valor
                      bBuscar     := False;
                      bInterpolar := False;
                    end
                 else
                    begin
                      fValor_Limite_Inferior  := FieldByName('Valor_Implicito').AsFloat;
                      fPeriodo_Desde_Inferior := FieldByName('Dias_Desde').AsFloat;
                      fPeriodo_Hasta_Inferior := FieldByName('Dias_Hasta').AsFloat;
                    end;

                 Close;
                 UnPrepare;

                 // Temporal es para acercarse al los dias de la Normativa
                 // Esto desaparece cuando se realize la
                 // incorporacion de funciones de interpolacion 20-Dic-2000

                 if iBaseMensual_TasFlot > 0 then
                    fVigenciaValor := Base_Mensual_Float(Reg_TasFlot.Codigo_Tasa) *
                                      iVigenciaMeses_TasFlot
                 else
                    fVigenciaValor := iVigenciaValor_TasFlot;
                 ///////////////////////////////////////////////////////////////////


                 // Verifico si los limites se saltan algun periodo completo
                 // Para hacer la interpolacion se debe hacer contra el periodo
                 // siguiente

                 LimInf := Array_Interpolacion[iArray].Limite_Inf / fVigenciaValor;
                 LimSup := Array_Interpolacion[iArray].Limite_Sup / fVigenciaValor;

//                 LimInf := Array_Interpolacion[iArray].Limite_Inf / iVigenciaValor_TasFlot;
//                 LimSup := Array_Interpolacion[iArray].Limite_Sup / iVigenciaValor_TasFlot;

                 LimInf := Redondeo(LimInf,0);
                 LimSup := Redondeo(LimSup,0);

                 if (LimSup - LimInf) > 1 then
                    begin
                      // Limite superior debe ser igual al inferior mas
                      // El periodo de pago de la tasa
                      // En el documento toma 92 aca Periodo Pago

                      Array_Interpolacion[iArray].Limite_Sup := Array_Interpolacion[iArray].Limite_Inf +
                                                                fVigenciaValor;
//                                                              iVigenciaValor_TasFlot;

                    end;
                 SQL.Clear;
                 SQL.Add('SELECT Valor_Implicito');
                 SQL.Add('      ,Dias_Desde');
                 SQL.Add('      ,Dias_Hasta');
                 SQL.Add('  FROM '+sNombreTablaReferencia);
                 SQL.Add(' WHERE :Limite_Sup >= Dias_Desde');
                 SQL.Add('   AND :Limite_Sup <  Dias_Hasta');


                 ParamByName('Limite_Sup').AsFloat := Array_Interpolacion[iArray].Limite_Sup;

                 Prepare;
                 Open;

                 if FieldByName('Valor_Implicito').IsNull then
                    begin
                      fValor_Limite_Superior := 0;
                      bInterpolar := False;
                    end
                 else
                    begin
                      fPeriodo_Desde_Superior := FieldByName('Dias_Desde').AsFloat;
                      fPeriodo_Hasta_Superior := FieldByName('Dias_Hasta').AsFloat;
                      fValor_Limite_Superior := FieldByName('Valor_Implicito').AsFloat;
                    end;

                 Close;
                 UnPrepare;
               end;  // end With

               if (fPeriodo_Desde_Inferior = fPeriodo_Desde_Superior) and
                  (fPeriodo_Hasta_Inferior = fPeriodo_Hasta_Superior) then
                   bDiferentes_Periodos := False
               else
                   bDiferentes_Periodos := True;

           end ;// End bBuscar (el que trabaja buscando tasas)

        if NOT bBuscar then  // Pregunto otra vez por si no encontro en este ciclo
           begin
             WITH dmComunInversiones.QRY_Paradox do
                  begin
                    // Si ya no busca (es que en alguno no encontro !!!)
                    // Debe asignar la tasa interpolada para el numero de dias
                    // mas alto
                    SQL.Clear;
                    SQL.Add('SELECT Valor_Implicito');
                    SQL.Add('  FROM '+sNombreTablaReferencia);
                    SQL.Add(' WHERE Dias_Hasta = (SELECT MAX(Dias_Hasta)');
                    SQL.Add('                       FROM '+sNombreTablaReferencia+')');

                    Prepare;
                    Open;

                    if FieldByName('Valor_Implicito').IsNull then
                       fValor_Limite_Inferior := 0
                    else
                       fValor_Limite_Inferior := FieldByName('Valor_Implicito').AsFloat;

                    Close;
                    UnPrepare;
                  end;  // end With
           end;

        if bInterpolar and bDiferentes_Periodos then
           begin
             if bBuscar then
                begin
// INTERPOLACION
                  Array_Interpolacion[iArray].Tasa_Interpolada := fValor_Limite_Inferior +
                                                                (((fValor_Limite_Superior -
                                                                   fValor_Limite_Inferior
                                                                   ) /
                                                                   fVigenciaValor
                                                                  ) *
                                                                 (Array_Interpolacion[iArray].Limite_Sup -
                                                                  (Trunc(Array_Interpolacion[iArray].Limite_Sup /
                                                                         fVigenciaValor
                                                                         )*
                                                                   fVigenciaValor
                                                                   )
                                                                  )
                                                                 );
                end;
           end
        else
           Array_Interpolacion[iArray].Tasa_Interpolada := fValor_Limite_Inferior;
        iArray := iArray + 1;
      end;  // end While

  // Recorro la tabla de desarrollo asignado tasas

  iCupon := Reg_TasFlot.Nro_Cupon;  // Desde el cupon para el que no encontro tasa


//  While (iCupon = Reg_TasFlot.Array_Mem_Desarr[iCupon].Nro_Cupon) do  // Recorre la tabla de desarrollo mientras existen cupones
  While (iCupon <= Max_Nro_Cupones) do  // Recorre la tabla de desarrollo mientras existen cupones
    begin
      // Busco Tasa para el cupon
      iArray  := 1;
      bBuscar := True;
//      While (Array_Interpolacion[iArray].Nro_Cupon <> 0) and bBuscar do
      While (Array_Interpolacion[iArray].Nro_Cupon <> 0) AND (iArray <= Max_Nro_Cupones) and bBuscar do

        begin
          if Array_Interpolacion[iArray].Nro_Cupon = Array_Mem_Desarr[iCupon].Nro_Cupon then
             begin
               bBuscar := False;
               Continue;
             end;
          Inc(iArray);
        end;

      Array_Mem_Desarr[iCupon].Valor_Tasa := Array_Interpolacion[iArray].Tasa_Interpolada;
      Array_Mem_Desarr[iCupon].Tasa_Flujo := Array_Interpolacion[iArray].Tasa_Interpolada;
      Array_Mem_Desarr[iCupon].Real_Estimado := 'FUTUROIMP';

      aplica_operacion(Array_Mem_Desarr[iCupon].Valor_Tasa
                      ,Array_Mem_Desarr[iCupon].Factor
                      ,Array_Mem_Desarr[iCupon].Operacion
                      ,fBase_Porcen_Tasa_Flot
                      ,sTipo_Ajuste
                      ,iDecimales_Redondeo
                      ,Array_Mem_Desarr[iCupon].Valor_Tasa
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

      if NOT Result then
         exit;

      // Convierte si corresponde de Nominales a Efectivas
      // y de Anticipadas a Vencidas
      // Lleva de la tasa flotante a la definida en el descriptor
      conversion_tasas(sTipo_Tasa_Flot
                      ,fPeriodo_Tasa_Flot
                      ,sAnualidad_Tasa_Flot
                      ,fBase_Porcen_Tasa_Flot
                      ,sTipo_Descriptor
                      ,fPeriodo_Descriptor
                      ,sAnualidad_Descriptor
                      ,fBase_Porcen_Descriptor
                      ,Array_Mem_Desarr[iCupon].Valor_Tasa
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

      if NOT Result then
         exit;

      Convierte_Base(iDiasBase_TasFlot             // de los dias base de la Tasa Flotante
                    ,sTipoInteres_TasFlot
                    ,Array_Mem_Desarr[iCupon].Valor_Tasa
                    ,iDiasBase_Descriptor          // a los Dias Base del Descriptor
                    ,sTipoInteres_Descriptor
                    ,Array_Mem_Desarr[iCupon].Valor_Tasa
                    ,sModulo_Err
                    ,sString_Err
                    ,Result);

      if NOT Result then
         exit;
      iCupon := iCupon + 1;
    end;
    Result := True;
    bTasas_Cargadas := True;
end;
//------------------------------------------------------------------------------
procedure Almacena_Valores_Futuros_Implicitos(sNombreTablaReferencia : String;
                                              sCodigo_Tasa           : String;
                                              dFecha_Valor           : TDateTime;
                                              fValor_Tasa            : Double;
                                              dFecha_Desde           : TDateTime;
                                              dFecha_Hasta           : TDateTime;
                                              var sModulo_Err        : String;
                                              var sString_Err        : String;
                                              var Result             : Boolean);
var
  fDias_Periodo_Original        : Double;
  fBase_Porcentual_Original     : Double;
  sTasa_Equiv          : String;
  sAux_Cod_Tasa        : String;
  fDias                : Double;

  fValor_Ant           : Double;
  fValor_Post          : Double;
  fMax_Dias            : Double;

  fDias_Ant            : Double;
  fTasa_Ant            : Double;
  fBase_Porcentual_Ant : Double;
  fBase_Porcentual     : Double;

  fAux_Valor           : Double;
  fBase,
  fExponente           : Double;
  i                    : Integer;


begin
  // Si no viene la tabla de referencias de tasas anteriores
  // no se puede aplicar el metodo
  // por lo tanto no almacena nada y retorna
  if sNombreTablaReferencia = '' then
     begin
       Result := True;
       exit;
     end;

  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Vigencia_Valor');
      SQL.Add('      ,b.Base_Porcentual');
      SQL.Add('      ,b.Tasa_Equiv');
      SQL.Add('  FROM Qs_Fin_Tasa_Base a');
      SQL.Add('      ,Qs_Fin_Tasa_Conver b');
      SQL.Add(' WHERE a.Cod_Tasa_Base = :Cod_Tasa_Base');
      SQL.Add('   AND b.Cod_Tasa_Base = a.Cod_Tasa_Base');

      ParamByName('Cod_Tasa_Base').AsString := sCodigo_Tasa;
      Prepare;
      Open;

      if (FieldByName('Vigencia_Valor').AsFloat = 0) or
         (FieldByName('Vigencia_Valor').IsNull) then
         begin
           sModulo_Err := 'Metodo Obtención de Tasa "Futuros Implicitos"';
           sString_Err := 'No existe definición de Vigencia'+#10
                         +'Para tasa : '+sCodigo_Tasa;
           Close;
           UnPrepare;
           Result := False;
           exit;
         end;

      fDias_Periodo_Original := FieldByName('Vigencia_Valor').AsFloat;
      fBase_Porcentual_Original := FieldByName('Base_Porcentual').AsFloat;

      if FieldByName('Tasa_Equiv').IsNull then
         sTasa_Equiv := ''
      else
         sTasa_Equiv   := FieldByName('Tasa_Equiv').AsString;
      Close;
      UnPrepare;
    end;

  WITH dmComunInversiones.QRY_Paradox do
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM '+sNombreTablaReferencia);
      Prepare;
      ExecSQL;
      Close;
      UnPrepare;

      SQL.Clear;

      SQL.Add('INSERT INTO '+sNombreTablaReferencia);
      SQL.Add('(Dias_Hasta');
      SQL.Add(',Valor');
      SQL.Add(',Base_Porcentual)');
      SQL.Add(' VALUES ');
      SQL.Add('(:Dias_Hasta');
      SQL.Add(',:Valor');
      SQL.Add(',:Base_Porcentual)');

      ParamByName('Dias_Hasta'     ).AsFloat := fDias_Periodo_Original;
      ParamByName('Valor'          ).AsFloat := fValor_Tasa;
      ParamByName('Base_Porcentual').AsFloat := fBase_Porcentual_Original;
      Prepare;
      ExecSQL;
      Close;
      UnPrepare;
    end;

    WHILE sTasa_Equiv <> '' do
      begin
        sAux_Cod_Tasa := sTasa_Equiv;
        WITH dmComunInversiones.QRY_General do
          begin
            SQL.Clear;
            SQL.Add('SELECT a.Vigencia_Valor');
            SQL.Add('      ,b.Base_Porcentual');
            SQL.Add('      ,b.Tasa_Equiv');
            SQL.Add('  FROM Qs_Fin_Tasa_Base a');
            SQL.Add('      ,Qs_Fin_Tasa_Conver b');
            SQL.Add(' WHERE a.Cod_Tasa_Base = :Cod_Tasa_Base');
            SQL.Add('   AND b.Cod_Tasa_Base = a.Cod_Tasa_Base');

            ParamByName('Cod_Tasa_Base').AsString := sAux_Cod_Tasa;
            Prepare;
            Open;

            if (FieldByName('Vigencia_Valor').AsFloat = 0) or
               (FieldByName('Vigencia_Valor').IsNull) then
               begin
                 sModulo_Err := 'Metodo Obtención de Tasa "Futuros Implicitos"';
                 sString_Err := 'No existe definición de Vigencia'+#10
                               +'Para tasa : '+sCodigo_Tasa;
                 Close;
                 UnPrepare;
                 Result := False;
                 exit;
               end;

            fDias := FieldByName('Vigencia_Valor').AsFloat;

            if FieldByName('Tasa_Equiv').IsNull then
               sTasa_Equiv := ''
            else
               sTasa_Equiv   := FieldByName('Tasa_Equiv').AsString;

            fBase_Porcentual := FieldByName('Base_Porcentual').AsFloat;
            Close;
            UnPrepare;
          end;


        // Busco valor de tasa a fecha correspondiente
        leer_valor_cambio2(sAux_Cod_Tasa
                          ,sAux_Cod_Tasa
                          ,'BC'
                          ,dFecha_Valor
                          ,fValor_Tasa
                          ,Result);

        if NOT Result then
           Continue;

        WITH dmComunInversiones.QRY_Paradox do
           begin
             SQL.Clear;
             SQL.Add('INSERT INTO '+sNombreTablaReferencia);
             SQL.Add('(Dias_Hasta');
             SQL.Add(',Valor');
             SQL.Add(',Base_Porcentual)');
             SQL.Add(' VALUES ');
             SQL.Add('(:Dias_Hasta');
             SQL.Add(',:Valor');
             SQL.Add(',:Base_Porcentual)');

             ParamByName('Dias_Hasta'     ).AsFloat := fDias;
             ParamByName('Valor'          ).AsFloat := fValor_Tasa;
             ParamByName('Base_Porcentual').AsFloat := fBase_Porcentual;
             Prepare;
             ExecSQL;
             Close;
             UnPrepare;
           end;
      end;

        WITH dmComunInversiones.QRY_Paradox do
          begin
             SQL.Clear;
             SQL.Add('SELECT MAX(Dias_Hasta) As Max_Dias');
             SQL.Add('  FROM '+sNombreTablaReferencia);

             Prepare;
             Open;

             fMax_Dias := FieldByName('Max_Dias').AsFloat;

             Close;
             UnPrepare;
          end;

    fDias := fDias_Periodo_Original;

    While fDias <= fMax_Dias do
       begin
        WITH dmComunInversiones.QRY_Paradox do
           begin
             // Chequeo secuencia por periodos
             // Si falta un periodo se debe crear (Ejemplo el de 270 dias)
             SQL.Clear;
             SQL.Add('SELECT Valor');
             SQL.Add('  FROM '+sNombreTablaReferencia);
             SQL.Add(' WHERE Dias_Hasta = :dias');

             ParamByName('Dias').AsFloat := fDias;
             Prepare;
             Open;

             if FieldByName('Valor').IsNull then
                begin
                  Close;
                  UnPrepare;
                  SQL.Clear;
                  SQL.Add('SELECT Valor');
                  SQL.Add('  FROM '+sNombreTablaReferencia);
                  SQL.Add(' WHERE Dias_Hasta = (SELECT MAX(Dias_Hasta)');
                  SQL.Add('                       FROM '+sNombreTablaReferencia);
                  SQL.Add('                      WHERE Dias_Hasta < :dias)');

                  ParamByName('Dias').AsFloat := fDias;
                  Prepare;
                  Open;

                  fValor_Ant := FieldByName('Valor').AsFloat;
                  Close;
                  UnPrepare;
                  SQL.Clear;
                  SQL.Add('SELECT Valor');
                  SQL.Add('  FROM '+sNombreTablaReferencia);
                  SQL.Add(' WHERE Dias_Hasta = (SELECT MIN(Dias_Hasta)');
                  SQL.Add('                       FROM '+sNombreTablaReferencia);
                  SQL.Add('                      WHERE Dias_Hasta > :dias)');

                  ParamByName('Dias').AsFloat := fDias;
                  Prepare;
                  Open;

                  fValor_Post := FieldByName('Valor').AsFloat;

                  Close;
                  UnPrepare;

                  fValor_Tasa := (fValor_Ant + fValor_Post) / 2;

                  SQL.Clear;
                  SQL.Add('INSERT INTO '+sNombreTablaReferencia);
                  SQL.Add('(Dias_Hasta');
                  SQL.Add(',Valor');
                  SQL.Add(',Base_Porcentual)');
                  SQL.Add(' VALUES ');
                  SQL.Add('(:Dias_Hasta');
                  SQL.Add(',:Valor');
                  SQL.Add(',:Base_Porcentual)');

                  ParamByName('Dias_Hasta').AsFloat  := fDias;
                  ParamByName('Valor').AsFloat := fValor_Tasa;
                  ParamByName('Base_Porcentual').AsFloat := fBase_Porcentual;
                  Prepare;
                  ExecSQL;
                end;
             fDias := fDias + fDias_Periodo_Original;
             Close;
             UnPrepare;
           end;
       end;

  fDias_Ant := 0;
  fTasa_Ant  := 0;
  fBase_Porcentual_Ant := 0;
  i                    := 1;

  // Calculo Implicitos
  WITH dmComunInversiones.QRY_Paradox do
    begin
      SQL.Clear;
      SQL.Add('SELECT Dias_Hasta');
      SQL.Add('      ,Valor');
      SQL.Add('      ,Base_Porcentual');
      SQL.Add('  FROM '+sNombreTablaReferencia);
      SQL.Add(' ORDER BY Dias_Hasta');

      Prepare;
      Open;

      While NOT EOF do
        begin
          if fBase_Porcentual_Original = 0 then
             begin
               Result := False;
               exit;
             end;
          fBase      := 1 + (FieldByName('Valor').AsFloat /
                             FieldByName('Base_Porcentual').AsFloat);
          fExponente := FieldByName('Dias_Hasta').AsFloat /
                        fDias_Periodo_Original;

          fValor_Tasa := power(fBase,fExponente);


          if fBase_Porcentual_Ant = 0 then
             fBase := 1
          else
             fBase := 1 + (fTasa_Ant /
                           fBase_Porcentual_Ant);

          fExponente := fDias_ant / fDias_Periodo_Original;

          fAux_Valor := power(fBase,fExponente);

          fValor_Tasa := (fValor_Tasa / fAux_Valor) - 1;

          fValor_Tasa := fValor_Tasa * fBase_Porcentual_Original;

          dmComunInversiones.QRY_Paradox2.SQL.Clear;
          dmComunInversiones.QRY_Paradox2.SQL.Add('UPDATE '+sNombreTablaReferencia);
          dmComunInversiones.QRY_Paradox2.SQL.Add('   SET Valor_Implicito = :Valor_Implicito');
          dmComunInversiones.QRY_Paradox2.SQL.Add('      ,Dias_Desde      = :Dias_Desde');
          dmComunInversiones.QRY_Paradox2.SQL.Add('      ,Item            = :Item');
          dmComunInversiones.QRY_Paradox2.SQL.Add(' WHERE Dias_Hasta      = :Dias_Hasta');

          dmComunInversiones.QRY_Paradox2.ParamByName('Dias_Hasta').AsFloat := FieldByName('Dias_Hasta').AsFloat;

          dmComunInversiones.QRY_Paradox2.ParamByName('Valor_Implicito').AsFloat := fValor_Tasa;
          dmComunInversiones.QRY_Paradox2.ParamByName('Dias_Desde'     ).AsFloat := fDias_Ant;
          dmComunInversiones.QRY_Paradox2.ParamByName('Item'           ).AsFloat := i;
          dmComunInversiones.QRY_Paradox2.Prepare;
          dmComunInversiones.QRY_Paradox2.ExecSQL;
          dmComunInversiones.QRY_Paradox2.Close;
          dmComunInversiones.QRY_Paradox2.Unprepare;

          fDias_Ant            := FieldByName('Dias_Hasta').AsFloat;
          fTasa_Ant            := FieldByName('Valor').AsFloat;
          fBase_Porcentual_Ant := FieldByName('Base_Porcentual').AsFloat;
          Inc(i);
          Next;
        end;
    end;
  Result := True;
end;
//------------------------------------------------------------------------------
procedure Impuesto_Instrumento(sCod_Instrumento    : String;
                               sCod_Div_Geo        : String;
                               dFecha              : TDateTime;
                               Reg_Fechas          : TRegistro_Fechas;
                               Reg_Montos          : TRegistro_Montos;
                               var fValor_Impuesto : Double;
                               var sModulo_Err     : String;
                               var sString_Err     : String;
                               var Result          : Boolean
                               );
var
  sCod_Impuesto   : String;
  bBuscar         : Boolean;
  sDefinicion,
  sPais_Tasa,
  sCalculo        : String;
  fPorcentaje     : Double;
  fMonto          : Double;

  fValor_Origen   : Double;

  iBaseTasa       : Integer;
  sTipoInteres     : String;
  iBaseMensual     : Integer;
  sTipoCalculoDias : String;
  iVigenciaValor   : Integer;
  iVigencia_Meses  : Integer;


  sCod_Fecha_Desde
  ,sCod_Fecha_Hasta
  ,sTipo_Calculo     : String;

  dFecha_Result_Desde
  ,dFecha_Result_Hasta
  ,sFecha_Desde                : TDateTime;

  fDias                        : Double;
  fAnosEnteros                 : Double;
  fAnosFraccion                : Double;
  fMesesEnteros                : Double;



begin
  bBuscar := True;
  sModulo_Err := 'Impuestos por Instrumento';
  WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Cod_Impuesto');
      SQL.Add('  FROM Qs_Fin_Instrum_Imp');
      SQL.Add(' WHERE Cod_Instrumento = :Cod_Instrumento');
      SQL.Add('   AND Fecha_Desde    <= :Fecha');
      SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

      ParamByName('Cod_Instrumento').AsString := sCod_Instrumento;
      ParamByName('Fecha').AsDate         := dFecha;

      Prepare;
      Open;

      if FieldByName('Cod_Impuesto').IsNull then
         begin
           fValor_Impuesto := 0;
           Close;
           UnPrepare;
           exit;
         end;

      sCod_Impuesto := FieldByName('Cod_Impuesto').AsString;
      Close;
      Unprepare;

      While bBuscar do
        begin
          SQL.Clear;
          SQL.Add('SELECT Definicion');
          SQL.Add('      ,Calculo');
          SQL.Add('      ,Porcentaje');
          SQL.Add('      ,Monto');
          SQL.Add('  FROM QS_SYS_IMPUESTOS');
          SQL.Add('WHERE Cod_Impuesto = :Cod_Impuesto');
          SQL.Add('  AND Cod_Div_Geo  = :Cod_Div_Geo');
          SQL.Add('  AND Fecha_Desde <= :Fecha');
          SQL.Add('  AND (Fecha_Hasta Is Null OR Fecha_Hasta >= :Fecha)');

          ParamByName('Cod_Impuesto').AsString := sCod_Impuesto;
          ParamByName('Cod_Div_Geo').AsString  := sCod_Div_Geo;
          ParamByName('Fecha').AsDate      := dFecha;

          Prepare;
          Open;

          if (FieldByName('Definicion').AsString = '') or
             (FieldByName('Definicion').IsNull)        then
             begin
                Division_Geografica_Padre(sCod_Div_Geo
                                         ,Result);
                if Result then
                  begin
                     Close;
                     UnPrepare;
                     Continue;
                  end
                else
                  begin
                    sString_Err := 'No se encontro definición para código de impuesto: "'
                                  +sCod_Impuesto
                                  +'"';
                    exit;
                  end;
             end
          else
             begin
               sDefinicion := FieldByName('Definicion').AsString;
               sCalculo    := FieldByName('Calculo').AsString;
               fPorcentaje := FieldByName('Porcentaje').AsFloat;
               fMonto      := FieldByName('Monto').AsFloat;
               bBuscar     := False;
             end;
          Close;
          UnPrepare;
        end;  // end While

////////////////////////////////////////////////////////////////////////////////
// Para Impuestos Variables (IOF Brasil)
////////////////////////////////////////////////////////////////////////////////
        if sDefinicion = 'VA' then Begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT * ');
           SQL.Add('  FROM QS_SYS_IMPUESTOS_VAR');
           SQL.Add('WHERE Cod_Impuesto = :Cod_Impuesto');
           SQL.Add('  AND Cod_Div_Geo  = :Cod_Div_Geo');
           SQL.Add('  AND Fecha_Desde <= :Fecha');
           ParamByName('Cod_Impuesto').AsString := sCod_Impuesto;
           ParamByName('Cod_Div_Geo').AsString  := sCod_Div_Geo;
           ParamByName('Fecha').AsDate      := dFecha;
           Prepare;
           Open;

           If Eof Then Begin
              sString_Err := 'No se encontro definición para código de impuesto: "'
                             +sCod_Impuesto
                             +'"';
              Close;
              exit;
           End;

           sFecha_Desde     := FieldByName('Fecha_Desde').AsDateTime;
           sCod_Fecha_Desde := FieldByName('Cod_Fecha_Desde').AsString;
           sCod_Fecha_Hasta := FieldByName('Cod_Fecha_Hasta').AsString;
           sTipo_Calculo    := FieldByName('Tipo_Calculo').AsString;

           Tratamiento_Fecha(FieldByName('Cod_Fecha_Desde').AsString
                             ,Reg_Fechas
                             ,dFecha_Result_Desde
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

           if NOT Result then
              exit;

           Tratamiento_Fecha(FieldByName('Cod_Fecha_Hasta').AsString
                            ,Reg_Fechas
                            ,dFecha_Result_Hasta
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);

           if NOT Result then
              exit;

           Calculo_de_dias(dFecha_Result_Desde,
                           dFecha_Result_Hasta,
                           FieldByName('Tipo_Calculo').AsString,
                           sPais_Tasa,
                           fDias,
                           fAnosEnteros,
                           fAnosFraccion,
                           fMesesEnteros);

           Close;
           SQL.Clear;
           SQL.Add('SELECT * ');
           SQL.Add('  FROM QS_SYS_IMPUESTOS_VAR');
           SQL.Add('WHERE Cod_Impuesto = :Cod_Impuesto');
           SQL.Add('  AND Cod_Div_Geo  = :Cod_Div_Geo');
           SQL.Add('  AND Fecha_Desde  = :Fecha');
           SQL.Add('  AND Cod_Fecha_Desde  = :Cod_Fecha_Desde');
           SQL.Add('  AND Cod_Fecha_Hasta  = :Cod_Fecha_Hasta');
           SQL.Add('  AND Tipo_Calculo     = :Tipo_Calculo');
           SQL.Add('  AND (Dias_Desde       <= :fDias AND Dias_hasta  >= :fDias)');
           SQL.Add('  OR  (Dias_Desde       <= :fDias AND Dias_hasta  Is Null)');
           SQL.Add('  OR  (Dias_Desde       <= :fDias AND Dias_hasta  = 0)');
           ParamByName('Cod_Impuesto').AsString := sCod_Impuesto;
           ParamByName('Cod_Div_Geo').AsString  := sCod_Div_Geo;
           ParamByName('Fecha').AsDate      := sFecha_Desde;
           ParamByName('Cod_Fecha_Desde').AsString  := sCod_Fecha_Desde;
           ParamByName('Cod_Fecha_Hasta').AsString  := sCod_Fecha_Hasta;
           ParamByName('Tipo_Calculo').AsString     := sTipo_Calculo;
           ParamByName('fDias').AsFloat            := fDias;
           Prepare;
           Open;
           If Eof Then Begin
              Result := False;
              sString_Err := 'No se encontro definición para código de impuesto: "'
                             +sCod_Impuesto
                             +'"';
              Close;
              exit;
           End;
           sDefinicion := FieldByName('Definicion').AsString;
           sCalculo    := FieldByName('Calculo').AsString;
           fPorcentaje := FieldByName('Porcentaje').AsFloat;
           fMonto      := FieldByName('Monto').AsFloat;
           Close;
        End;


        if sDefinicion = 'MP' then
           begin
             fValor_Impuesto := fMonto;
             Result := True;
             exit;
           end;


        if sCalculo = '1' then
           fValor_Origen := Reg_Montos.fBase
        else
           if sCalculo = '2' then
              fValor_Origen := Reg_Montos.fSaldo
        else
           if sCalculo = '3' then
              fValor_Origen := Reg_Montos.fIntereses
           else
              if sCalculo = '4' then
                 fValor_Origen := Reg_Montos.fCapital
              else
                 fValor_Origen := 0;

        if sDefinicion = 'PP' then
           begin
             fValor_Impuesto := (fValor_Origen * fPorcentaje) / 100;
             Result := True;
             exit;
           end;

        if sDefinicion = 'TA' then
           begin
             Obtener_Tasa_base(sCod_Impuesto
                              ,iBaseTasa
                              ,sTipoInteres
                              ,iBaseMensual
                              ,sTipoCalculoDias
                              ,iVigenciaValor
                              ,iVigencia_Meses
                              ,sPais_Tasa
                              ,sModulo_err
                              ,sString_err
                              ,Result);

             if NOT Result then
                exit;

             fValor_Impuesto := (fValor_Origen *
                                 (
                                  (fPorcentaje / 100) *  // En porcentaje esta el valor tasa
                                  (1 /360)
                                 )
                                );
             Result := True;
             exit;
           end;
    end;  // With Qry_General
end;
//------------------------------------------------------------------------------
function Impuesto_Div_Geo( sCod_Div_Geo: string;
                           dFecha: TDateTime;
                           fMonto: Double;
                           var fImpuesto: Double): Double;
var
  bBuscar : Boolean;
  bResult : Boolean;

begin
   bBuscar := True;
   fImpuesto := 0;
   Result    := 0;

   with dmComunInversiones.Qry_Varios do
   While bBuscar do
   begin
      Close;
      SQL.Clear;
      SQL.Add('select * from qs_sys_impuestos');
      SQL.Add('where cod_div_geo = :Div_Geo');
      SQL.Add('  AND Fecha_Desde <= :Fecha');
      SQL.Add('  AND (Fecha_Hasta Is Null OR Fecha_Hasta >= :Fecha)');

      ParamByName('Div_Geo').AsString := sCod_Div_Geo;
      ParamByName('Fecha').AsDate := dFecha;

      Prepare;
      Open;

      if (FieldByName('Definicion').AsString = '') or
         (FieldByName('Definicion').IsNull)        then
         begin
           Division_Geografica_Padre(sCod_Div_Geo
                                    ,bResult);
           if bResult then
             begin
                Close;
                UnPrepare;
                Continue;
             end;
         end;
      bBuscar := False;

      if FieldByName('Definicion').AsString = 'PP' then
         if NOT FieldByName('Porcentaje').IsNull then
            begin
               fImpuesto := FieldByName('Porcentaje').AsFloat;
               Result    := fMonto * fImpuesto / 100;
            end;

      if FieldByName('Definicion').AsString = 'MP' then
           if NOT FieldByName('Monto').IsNull then
              begin
                fImpuesto := FieldByName('Monto').AsFloat;
                Result    := fMonto + fImpuesto;
              end;
      Close;
      UnPrepare;
   end;
end;
//------------------------------------------------------------------------------
procedure Registra_Datos_Tasa_Encontrada(sNombreTabla        : String;
                                         sCodigo_Tasa        : String;
                                         dFecha_Calculo      : TDateTime;
                                         fValorTasa          : Double;
                                         dFecha_Inic_Periodo : TDateTime;
                                         dFecha_Vcto_Periodo : TDateTime);

begin
  WITH dmComunInversiones.QRY_Paradox do
     begin
       SQL.Clear;
       SQL.Add('DELETE FROM '+sNombreTabla);
       Prepare;
       ExecSQL;
       Close;
       UnPrepare;

       SQL.Clear;
       SQL.Add('INSERT INTO '+sNombreTabla);
       SQL.Add(' Values (');
       SQL.Add(' :Codigo_Tasa');
       SQL.Add(',:Fecha_Calculo');
       SQL.Add(',:ValorTasa');
       SQL.Add(',:Fecha_Inic_Periodo');
       SQL.Add(',:Fecha_Vcto_Periodo)');

       ParamByName('Codigo_Tasa'       ).AsString   := sCodigo_Tasa;
       ParamByName('Fecha_Calculo'     ).AsDateTime := dFecha_Calculo;
       ParamByName('ValorTasa'         ).AsFloat    := fValorTasa;
       ParamByName('Fecha_Inic_Periodo').AsDateTime := dFecha_Inic_Periodo;
       ParamByName('Fecha_Vcto_Periodo').AsDateTime := dFecha_Vcto_Periodo;

       Prepare;
       ExecSQL;
       Close;
       UnPrepare;
     end;
end;
//------------------------------------------------------------------------------
procedure Recupera_y_Almacena_Valores_Ult_Tasa(sNombreTabla : String;
                                               sModulo_Err  : String;
                                               sString_Err  : String;
                                               Result       : Boolean);

var
  sCodigo_Tasa        : String;
  dFecha_Calculo      : TDateTime;
  fValorTasa          : Double;
  dFecha_Inic_Periodo : TDateTime;
  dFecha_Vcto_Periodo : TDateTime;

begin
  WITH dmComunInversiones.QRY_Paradox do
     begin
       SQL.Clear;
       SQL.Add('SELECT Codigo_Tasa');
       SQL.Add('      ,Fecha_Calculo');
       SQL.Add('      ,ValorTasa');
       SQL.Add('      ,Fecha_Inic_Periodo');
       SQL.Add('      ,Fecha_Vcto_Periodo');
       SQL.Add(' FROM '+sNombreTabla+'_Aux');

       Prepare;
       Open;

       sCodigo_Tasa        := FieldByName('Codigo_Tasa'       ).AsString;
       dFecha_Calculo      := FieldByName('Fecha_Calculo'     ).AsDateTime;
       fValorTasa          := FieldByName('ValorTasa'         ).AsFloat;
       dFecha_Inic_Periodo := FieldByName('Fecha_Inic_Periodo').AsDateTime;
       dFecha_Vcto_Periodo := FieldByName('Fecha_Vcto_Periodo').AsDateTime;

       Close;
       UnPrepare;
     end;

   Almacena_Valores_Futuros_Implicitos(sNombreTabla
                                      ,sCodigo_Tasa
                                      ,dFecha_Calculo
                                      ,fValorTasa
                                      ,dFecha_Inic_Periodo
                                      ,dFecha_Vcto_Periodo
                                      ,sModulo_Err
                                      ,sString_Err
                                      ,Result);
end;
//------------------------------------------------------------------------------
procedure Impuesto_Instrumento_Memory(sCod_Instrumento    : String;
                               sCod_Div_Geo        : String;
                               dFecha              : TDateTime;
                               Reg_Montos          : TRegistro_Montos;
                               var fValor_Impuesto : Double;
                               var sModulo_Err     : String;
                               var sString_Err     : String;
                               var Result          : Boolean
                               );
var
  bBuscar         : Boolean;
  sDefinicion,
  sPais_Tasa,
  sCalculo        : String;
  fPorcentaje     : Double;
  fMonto          : Double;
  fValor_Origen   : Double;
  iBaseTasa       : Integer;
  sTipoInteres     : String;
  iBaseMensual     : Integer;
  sTipoCalculoDias : String;
  iVigenciaValor   : Integer;
  iVigencia_Meses  : Integer;
begin
  bBuscar := True;
  sModulo_Err := 'Impuestos por Instrumento';  
  WITH dmComunInversiones.QRY_General do
    begin
      if sCodigo_Impuesto_Instrumento = EmptyStr then
      begin
        fValor_Impuesto := 0;
        Exit;
      end;

      While bBuscar do
        begin
          SQL.Clear;
          SQL.Add('SELECT Definicion');
          SQL.Add('      ,Calculo');
          SQL.Add('      ,Porcentaje');
          SQL.Add('      ,Monto');
          SQL.Add('  FROM QS_SYS_IMPUESTOS');
          SQL.Add('WHERE Cod_Impuesto = :Cod_Impuesto');
          SQL.Add('  AND Cod_Div_Geo  = :Cod_Div_Geo');
          SQL.Add('  AND Fecha_Desde <= :Fecha');
          SQL.Add('  AND (Fecha_Hasta Is Null OR Fecha_Hasta >= :Fecha)');

          ParamByName('Cod_Impuesto').AsString := sCodigo_Impuesto_Instrumento;
          ParamByName('Cod_Div_Geo').AsString  := sCod_Div_Geo;
          ParamByName('Fecha').AsDate      := dFecha;

          Prepare;
          Open;

          if (FieldByName('Definicion').AsString = '') or
             (FieldByName('Definicion').IsNull)        then
             begin
                Division_Geografica_Padre(sCod_Div_Geo
                                         ,Result);
                if Result then
                  begin
                     Close;
                     UnPrepare;
                     Continue;
                  end
                else
                  begin
                    sString_Err := 'No se encontro definición para código de impuesto: "'
                                  +sCodigo_Impuesto_Instrumento
                                  +'"';
                    exit;
                  end;
             end
          else
             begin
               sDefinicion := FieldByName('Definicion').AsString;
               sCalculo    := FieldByName('Calculo').AsString;
               fPorcentaje := FieldByName('Porcentaje').AsFloat;
               fMonto      := FieldByName('Monto').AsFloat;
               bBuscar     := False;
             end;
          Close;
          UnPrepare;
        end;  // end While

        if sDefinicion = 'MP' then
           begin
             fValor_Impuesto := fMonto;
             Result := True;
             exit;
           end;


        if sCalculo = '1' then
           fValor_Origen := Reg_Montos.fBase
        else
           if sCalculo = '2' then
              fValor_Origen := Reg_Montos.fSaldo
        else
           if sCalculo = '3' then
              fValor_Origen := Reg_Montos.fIntereses
           else
              if sCalculo = '4' then
                 fValor_Origen := Reg_Montos.fCapital
              else
                 fValor_Origen := 0;

        if sDefinicion = 'PP' then
           begin
             fValor_Impuesto := (fValor_Origen * fPorcentaje) / 100;
             Result := True;
             exit;
           end;

        if sDefinicion = 'TA' then
           begin
             Obtener_Tasa_base(sCodigo_Impuesto_Instrumento
                              ,iBaseTasa
                              ,sTipoInteres
                              ,iBaseMensual
                              ,sTipoCalculoDias
                              ,iVigenciaValor
                              ,iVigencia_Meses
                              ,sPais_Tasa
                              ,sModulo_err
                              ,sString_err
                              ,Result);

             if NOT Result then
                exit;

             fValor_Impuesto := (fValor_Origen *
                                 (
                                  (fPorcentaje / 100) *  // En porcentaje esta el valor tasa
                                  (1 /360)
                                 )
                                );
             Result := True;
             exit;
           end;
    end;  // With Qry_General
end;
//------------------------------------------------------------------------------
function Tipo_Valores(sEmpresa     : String;
                      sTransaccion : String;
                      dFecha       : TDateTime) : String;
begin
WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Tipo_Valor');
      SQL.Add('  FROM QS_FIN_TIP_VALORES');
      SQL.Add(' WHERE Empresa     = :Empresa');
      SQL.Add('   AND Transaccion = :Transaccion');
      SQL.Add('   AND Fecha_Desde <= :Fecha');
      SQL.Add('   AND (Fecha_Hasta > :Fecha OR Fecha_Hasta IS NULL)');

      ParamByName('Empresa'    ).AsString   := sEmpresa;
      ParamByName('Transaccion').AsString   := sTransaccion;
      ParamByName('Fecha'      ).AsDate := dFecha;

      Open;
      if FieldByName('Tipo_Valor').IsNull then
         Result := ''
      else
         Result := FieldByName('Tipo_Valor').AsString;
      Close;
    end;
end;
//------------------------------------------------------------------------------
procedure Indice_Reajuste(sInstrumento        : String;
                          dFecha              : TDateTime;
                          var sFechaTratam    : String;
                          var Ind_Reajuste    : String);

begin
WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Indice');
      SQL.Add('      ,Fecha_Tratam');
      SQL.Add('  FROM QS_SYS_IND_REAJUS');
      SQL.Add(' WHERE  Fecha_Desde <= :Fecha');
      SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');
      if Trim(sInstrumento) = '' then
         SQL.Add('  AND ( Instrumento IS NULL OR Instrumento = '' '')')
      else
      begin
         Sql.Add( ' AND Instrumento = :Instrumento' );
         ParamByName('Instrumento').AsString  := sInstrumento;
      end;

      ParamByName('Fecha'      ).AsDate := dFecha;

      Open;
      if FieldByName('Codigo_Indice').IsNull then
         Ind_Reajuste := ''
      else
         Ind_Reajuste := FieldByName('Codigo_Indice').AsString;

      sFechaTratam := FieldByName('Fecha_Tratam').AsString;
      Close;
    end;
end;
//------------------------------------------------------------------------------
procedure lee_proy_precio(sTipo_Proceso,
                         sNemotecnico,
                         sTabla    : String;
                         dFecha    : TDateTime;
                         sOrigen   : String;
                        var fValor : Double;
                        var sTipo  : String;
                        var Result : Boolean
                         );
var
  fCantidad : Double;
  sUnidad,
  sAntes_Despues : String;
  dFecha_Tope    : TDatetime;
  bExiste        : Boolean;
begin
  Result  := False;
  bExiste := True;   //False;

  if sValorizacion_Proceso = 'SI' then
  begin
     Busca_Proy_Precio_Mem( sTipo_Proceso,
                             fCantidad,
                             sUnidad,
                             sAntes_Despues,
                             bExiste);
    if Not bExiste then
       Exit;

  end
  else
  begin
      With dmComunInversiones.QRY_General do
      begin
        SQL.Clear;
        SQL.Add('  SELECT *'
               +'  FROM QS_FIN_PROY_PRECIOS'
               +' WHERE Tipo_Proceso = :Tipo_Proceso'
               );
        ParamByName('Tipo_Proceso').AsString := sTipo_Proceso;
        Prepare;
        Open;

        if FieldByName('Tipo_Proceso').IsNull then
        begin
           Close;
           Unprepare;
           Exit;
        end
        else
        begin
          fCantidad      := Fieldbyname('Cantidad').asFloat;
          sUnidad        := Fieldbyname('Unidad').asString;
          sAntes_Despues := FieldByName('Antes_Despues').AsString;
        end;

        Close;
        UnPrepare;
      end;
  end;

  if ( fCantidad      = 0 ) or
     ( sUnidad        = EmptyStr ) or
     ( sAntes_Despues = EmptyStr ) then
  begin
     Exit;
  end;

  if sAntes_Despues = 'A' then
     fCantidad := fCantidad * (-1);

  if sUnidad = 'DIA' then
     dFecha_Tope := (dFecha + fCantidad);

  if sUnidad = 'MES' then
     dFecha_Tope := (dFecha + (fCantidad*30));

  if sUnidad = 'ANO' then
     dFecha_Tope := (dFecha + (fCantidad*365));

  while True do // dFecha <> dFecha_Tope do
  begin
     With dmComunInversiones.QRY_General do
     begin
       SQL.Clear;
       SQL.Add('SELECT Valor ');
       if sTabla = 'QS_FIN_PREC_MERCAD' then
          SQL.Add('   ,Tipo ');
       SQL.Add('  FROM '+sTabla
              +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
              +'  AND  Fecha              = :Fecha'
              +'  AND  Origen             = :Origen'
              );
       ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;
       ParamByname('Fecha').AsDate            := dFecha;     //Edosan 010205
       ParamByName('Origen').AsString             := sOrigen;
       Open;

       if not FieldByName('Valor').IsNull then
       begin
          fValor := FieldByName('Valor').AsFloat;
          if sTabla = 'QS_FIN_PREC_MERCAD' then
             sTipo := FieldByName('Tipo').AsString
          else
             sTipo := '';
          Result := True;
          Close;
          Break;
       end;
       Close;
     end;

     if sAntes_Despues = 'A' then
     begin
        dFecha := dFecha - 1;
        if dFecha = (dFecha_Tope - 1 ) then
           break;
     end
     else
     begin
        dFecha := dFecha + 1;

        if dFecha = (dFecha_Tope + 1 ) then
           break;
     end;
  end;
end;

procedure Busca_Proy_Precio(  sTipo_Proceso  :String;
                          var fCantidad    : Double;
                          var sUnidad,
                              sAntes_Despues : String;
                          var Result         : Boolean
                              );
begin
  Result := True;
  fCantidad      := 0;
  sUnidad        := '';
  sAntes_Despues := '';
  With dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT *'
           +'  FROM QS_FIN_PROY_PRECIOS'
           +' WHERE Tipo_Proceso = :Tipo_Proceso'
           );
    ParamByName('Tipo_Proceso').AsString := sTipo_Proceso;
    Prepare;
    Open;

    if FieldByName('Tipo_Proceso').IsNull then
    begin
       Close;
       Unprepare;
       Result := False;
       Exit;
    end
    else
    begin
      fCantidad      := Fieldbyname('Cantidad').asFloat;
      sUnidad        := Fieldbyname('Unidad').asString;
      sAntes_Despues := FieldByName('Antes_Despues').AsString;
    end;
  end;// dmComunInversiones.QRY_General do
end;

procedure Tratamiento_Fecha_Memory(sCodigo_Tratam   : String;
                                   Registro_Fechas  : TRegistro_Fechas;
                                   var Fecha_Result : TDateTime;
                                   var Modulo_Err   : String;
                                   var String_Err   : String;
                                   var Result       : Boolean);
var
   iDias,
   iMeses,
   iAnos      : Integer;
   fCantidad  : Double; //No puedo utilizar la variable del Registro

   //dFecha    : TDateTime;
   AA,
   MM,
   DD         : word;
   Ano,
   Mes,
   Dia         : Integer;

begin
  Result := True;
  Fecha_Result := strtodate(Fecha_Nula); //Fecha_Nula;

  if Reg_Tratam.Referencia = 'FECCALC' then
     Fecha_Result := Registro_fechas.Fecha_Calculo;

  if Reg_Tratam.Referencia = 'FECCOMP' then
     Fecha_Result := Registro_fechas.Fecha_Compra;

  if Reg_Tratam.Referencia = 'FECEMIS' then
     Fecha_Result := Registro_fechas.Fecha_Emision;

  if Reg_Tratam.Referencia = 'FECVCTPER' then
     Fecha_Result := Registro_fechas.Fecha_Vcto_Periodo;

  if Reg_Tratam.Referencia = 'FECINIPER' then
     Fecha_Result := Registro_fechas.Fecha_Inic_Periodo;

  if Reg_Tratam.Referencia = 'FECPAGO' then
     Fecha_Result := Registro_fechas.Fecha_Pago;
     

  if Fecha_Result = strtodate(Fecha_Nula) then //Fecha_Nula then
  begin
     Modulo_Err := 'Tratamiento Fecha (ComunInversiones)';
     String_Err := 'No existe fecha para: '
                   +sCodigo_Tratam;
     Result := False;
     exit;
  end;

  if Reg_Tratam.Dia <> 0 Then
  begin
     DecodeDate(Fecha_Result,AA,MM,DD);
     Ano   := AA;
     Mes   := MM;
     Dia   := StrToInt(FloatToStr(Reg_Tratam.Dia));
     if Reg_Tratam.Dia > ultimo_dia_mes(MM,AA) Then
        Dia := ultimo_dia_mes(MM,AA);
     Fecha_Result := EncodeDate(Ano,Mes,Dia);
  end;

  if Reg_Tratam.Cantidad = 0 then
  begin
    Result := True;
    exit;
  end;

  iDias  := 0;
  iMeses := 0;
  iAnos  := 0;
  fCantidad := Reg_Tratam.Cantidad;

  if Reg_Tratam.Antes_Despues = 'A' then
     fCantidad := fCantidad * (-1);

  if Reg_Tratam.Unidad = 'DIA' then
     iDias := ROUND(fCantidad);

  if Reg_Tratam.Unidad = 'MES' then
     iMeses := ROUND(fCantidad);

  if Reg_Tratam.Unidad = 'ANO' then
     iAnos := ROUND(fCantidad);

  Fecha_Result := IncDate(Fecha_Result
                         ,iDias
                         ,iMeses
                         ,iAnos);

  if Reg_Tratam.Habiles = 'N' then
  begin
    Result := True;
    exit;
  end;

  //Aqui dudo si se puede usar el mismo codigo de Pais que el ya cargado
  While (feriado_Memory(Reg_Tratam.Codigo_Pais,Fecha_Result)  or
        (DayOfWeek(Fecha_Result) in [1,7])) do
     if Reg_Tratam.Antes_Despues = 'A' then
        Fecha_Result := Fecha_Result - 1
     else
        Fecha_Result := Fecha_Result + 1;

  Result := True;
end;

//------------------------------------------------------------------------------
procedure Carga_Valores_Feriados( sCodigo_Division : String );
var i : Integer;
begin
  With dmComunInversiones.Qry_General do
  begin
    //Ahora debo Dejar en memoria los arreglos de Feriados
    SQL.Clear;
    SQL.Add('SELECT *'
           +'  FROM QS_SYS_FERIADOS'
           +' WHERE Codigo_Division = '''+sCodigo_Division+''''
           );
    Prepare;
    Open;

    Reg_Feriados.Codigo_Division := VarArrayCreate([0, RecordCount], varOleStr);
    Reg_Feriados.Ano_Feriado     := VarArrayCreate([0, RecordCount], varDouble);
    Reg_Feriados.Mes_Feriado     := VarArrayCreate([0, RecordCount], varDouble);
    Reg_Feriados.Dia_Feriado     := VarArrayCreate([0, RecordCount], varDouble);

    i := 0;
    while not eof do
    begin
       Reg_Feriados.Codigo_Division[i] := Fieldbyname('Codigo_Division').asString;
       Reg_Feriados.Ano_Feriado[i]     := Fieldbyname('Ano_Feriado').asFloat;
       Reg_Feriados.Mes_Feriado[i]     := Fieldbyname('Mes_Feriado').asFloat;
       Reg_Feriados.Dia_Feriado[i]     := Fieldbyname('Dia_Feriado').asFloat;
       Next;
       Inc(i);
    end;
    Close;
    Unprepare;
  end;
end;

//------------------------------------------------------------------------------
function Feriado_Memory(sCodigo_Division : String;
                        dFecha           : TDatetime) : Boolean;
var
  wano,
  wmes,
  wdia : word;
  i    : Integer;
begin
  Result := False;
  if sCodigo_Division = EmptyStr then
     Exit;

  decodedate(dFecha,wano,wmes,wdia);

  for i := 0 to  VarArrayHighBound(Reg_Feriados.Codigo_Division, 1 ) do
  begin
     if ( (Reg_Feriados.Ano_Feriado[i] = 0) or (Reg_Feriados.Ano_Feriado[i] = wAno) ) and
          (Reg_Feriados.Mes_Feriado[i] = wMes) and
          (Reg_Feriados.Dia_Feriado[i] = wDia) then
     begin
       Result := True;
       Break;
     end;
  end;
end;

//------------------------------------------------------------------------------
procedure Carga_Base_Conversion( RegDes         : TReg_descriptor;
                                 iTotal_Tasas   : Integer;
                             var sModulo_Error  : String;
                             var sString_Error  : String;
                             var Result         : Boolean
                               );
var
    i              : Integer;
    sCod_Tasa_Base : String;
begin

  Result := True;
  //Base Conversion
  Reg_Base_Conversion.Cod_Tasa_Base   := VarArrayCreate([0, iTotal_Tasas], varOleStr);
  Reg_Base_Conversion.Tipo            := VarArrayCreate([0, iTotal_Tasas], varOleStr);
  Reg_Base_Conversion.Periodo_Pago    := VarArrayCreate([0, iTotal_Tasas], varDouble);
  Reg_Base_Conversion.Anualidad       := VarArrayCreate([0, iTotal_Tasas], varOleStr);
  Reg_Base_Conversion.Base_Porcentual := VarArrayCreate([0, iTotal_Tasas], varDouble);

  //Tasa Base
  Reg_Base_Conversion.Dias_Base      := VarArrayCreate([0, iTotal_Tasas], varDouble);
  Reg_Base_Conversion.Tipo_interes   := VarArrayCreate([0, iTotal_Tasas], varOleStr);
  Reg_Base_Conversion.Base_Mensual   := VarArrayCreate([0, iTotal_Tasas], varDouble);
  Reg_Base_Conversion.Vigencia_Valor := VarArrayCreate([0, iTotal_Tasas], varDouble);
  Reg_Base_Conversion.Vigencia_Meses := VarArrayCreate([0, iTotal_Tasas], varDouble);
  Reg_Base_Conversion.Tipo_Calculo_Dias:= VarArrayCreate([0, iTotal_Tasas], varOleStr);

  for i := 0 to (VarArrayHighBound(Reg_Base_Conversion.Cod_Tasa_Base, 1 ) -1) do
  begin
    //Tasa del Descriptor la primera vez
    if i = 0 then
       sCod_Tasa_Base := RegDes.TASA_VALOR_PAR
    else
       sCod_Tasa_Base := Reg_Proy_Simple.Codigo_Tasa[i-1];

    sModulo_Error :='Obtener Tasa Conversion';
    with dmComunInversiones.QRY_General do
    begin
       Sql.clear;
       Sql.Add('SELECT Cod_Tasa_Base'
              +'      ,Tipo'
              +'      ,Periodo_Pago'
              +'      ,Anualidad'
              +'      ,Base_Porcentual'
              +'  FROM QS_FIN_TASA_CONVER'
              +' WHERE Cod_Tasa_Base = :Cod_Tasa_Base'
              );
       ParamByName('Cod_Tasa_Base').AsString := trim(sCod_Tasa_Base);
       Prepare;
       Open;

       if (FieldByName('Cod_Tasa_Base').AsString <> trim(sCod_Tasa_Base))  or
          (FieldByName('Cod_Tasa_Base').IsNull)                           then
       begin
         sModulo_Error := 'Base Conversion Tasa';
         sString_Error := 'No se encontro Base de Conversión para : '
                          +sCod_Tasa_Base;
         Result := False;
         Exit;
       end;

       if (FieldByName('Base_Porcentual').AsFloat = 0)  or
          (FieldByName('Base_Porcentual').IsNull)       then
       begin
         sModulo_Error := 'Base Conversion Tasa';
         sString_Error := 'Error en definición de base porcentual para tasa : '
                        +sCod_Tasa_Base+#10
                        +'Base no puede ser igual a 0';
         Result := False;
         Exit;
       end;


       if (FieldByName('Periodo_Pago').AsFloat = 0)  or
          (FieldByName('Periodo_Pago').IsNull)       then
       begin
         sModulo_Error := 'Base Conversion Tasa';
         sString_Error := 'Error en definición de periodo para tasa : '
                        +sCod_Tasa_Base+#10
                        +'Periodo no puede ser igual a 0';
         Result := False;
         Exit;
       end;

       Reg_Base_Conversion.Cod_Tasa_Base[i]  := sCod_Tasa_Base;
       Reg_Base_Conversion.Tipo[i]           := FieldByName('Tipo').AsString;
       Reg_Base_Conversion.Periodo_Pago[i]   := FieldByName('Periodo_Pago').AsFloat;
       Reg_Base_Conversion.Anualidad[i]      := FieldByName('Anualidad').AsString;
       Reg_Base_Conversion.Base_Porcentual[i]:= FieldByName('Base_Porcentual').AsFloat;

       Close;
       UnPrepare;

       //Ahora Cargo valores de Tasa Base
       sModulo_Error :='Obtener Tasa Base';
       Sql.clear;
       Sql.Add('SELECT DIAS_BASE_TASA As Dias_Base'
              +'     ,TIPO_INTERES_TASA As Tipo_Interes'
              +'     ,BASE_MENSUAL_TASA As Base_Mensual'
              +'     ,VIGENCIA_VALOR'
              +'     ,VIGENCIA_MESES'
              +'     ,TIPO_CALCULO_DIAS'
              +'  FROM qs_fin_tasa_base'
              +' WHERE cod_tasa_base = :cod_tasa_base'
              );

       ParamByName('cod_tasa_base').AsString := trim(sCod_Tasa_Base);
       prepare;
       try
         Open
       except
         begin
           sString_Error := 'Error en acceso a Base de Datos';
           Result := False;
           exit;
         end
       end;

       if (FieldByName('Dias_Base').AsInteger = 0) or
          (FieldByName('Dias_Base').IsNull)        then
       begin
         close;
         Unprepare;
         sString_Error := 'Definición incorrecta para Tasa Base: '+trim(sCod_Tasa_Base)+' Dias_Base';
         Result        := False;
         exit;
       end;


       if (FieldByName('Tipo_interes').AsString = ' ') or
          (FieldByName('Tipo_interes').IsNull)         then
       begin
         close;
         Unprepare;
         sString_Error := 'Definición incorrecta para Tasa Base: '+trim(sCod_Tasa_Base)+' Tipo Interes';
         Result := False;
         exit;
       end;

       Reg_Base_Conversion.Dias_Base[i]      := FieldByName('Dias_Base').AsInteger;
       Reg_Base_Conversion.Tipo_interes[i]   := FieldByName('Tipo_interes').AsString;
       Reg_Base_Conversion.Base_Mensual[i]   := FieldByName('Base_Mensual').AsInteger;
       Reg_Base_Conversion.Vigencia_Valor[i] := FieldByName('Vigencia_Valor').AsInteger;
       Reg_Base_Conversion.Vigencia_Meses[i] := FieldByName('Vigencia_Meses').AsInteger;
       Reg_Base_Conversion.Tipo_Calculo_Dias[i] := FieldByName('TIPO_CALCULO_DIAS').AsString;


       Close;
       Unprepare;

       if NOT Result then
       begin
         sString_Error := 'Definición incorrecta para Tasa Base: '+trim(sCod_Tasa_Base);
         exit;
       end;
(*
       case Reg_Base_Conversion.Base_Mensual[i] of
        30  : Reg_Base_Conversion.BaseCalculoDias[i] := 1;{Diferencia en dias base 360}
        31  : Reg_Base_Conversion.BaseCalculoDias[i] := 2;{Diferencia en dias base 365}
       else
              Reg_Base_Conversion.BaseCalculoDias[i] := 0;{Diferencia en dias exactos}
       end;
*)
    end; //fin with

  end;// fin for
end;

procedure Obtener_Base_Conversion_Memory(sCod_Tasa_Base     : String;
                                        var sTipo              : String;
                                        var fPeriodo_Pago      : Double;
                                        var sAnualidad         : String;
                                        var fBase_Porcen       : Double
                                           );
var
      i : Integer;
begin
  for i := 0 to VarArrayHighBound(Reg_Base_Conversion.Cod_Tasa_Base, 1 ) do
  begin
     if Reg_Base_Conversion.Cod_Tasa_Base[i] = sCod_Tasa_Base then
     begin
        sTipo         := Reg_Base_Conversion.Tipo[i];
        fPeriodo_Pago := Reg_Base_Conversion.Periodo_Pago[i];
        sAnualidad    := Reg_Base_Conversion.Anualidad[i];
        fBase_Porcen  := Reg_Base_Conversion.Base_Porcentual[i];

        Break;
     end;
  end;
end;

procedure Obtener_Tasa_base_Memory(CodigoTasaBase      : string;
                                 var BaseTasa        : integer;
                                 var TipoInteres     : string;
                                 var BaseMensual     : integer;
                                 var TipoCalculoDias : String;
                                 var VigenciaValor   : Integer;
                                 var Vigencia_Meses  : Integer;
                                 var Modulo_err      : String;
                                 var String_err      : String;
                                 var Result          : Boolean);
var i : Integer;
begin
   for i := 0 to VarArrayHighBound(Reg_Base_Conversion.Cod_Tasa_Base, 1 ) do
   begin
      if Reg_Base_Conversion.Cod_Tasa_Base[i] = CodigoTasaBase then
      begin
         BaseTasa        := Reg_Base_Conversion.Dias_Base[i];
         TipoInteres     := Reg_Base_Conversion.Tipo_interes[i];
         BaseMensual     := Reg_Base_Conversion.Base_Mensual[i];
         VigenciaValor   := Reg_Base_Conversion.Vigencia_Valor[i];
         Vigencia_Meses  := Reg_Base_Conversion.Vigencia_Meses[i];
         TipoCalculoDias := Reg_Base_Conversion.Tipo_Calculo_Dias[i];
         Break;
      end;
   end;


 end;

 Procedure Carga_Valores_Tasa_Memory( sCodigo_Tasa   : String;
                                     dFecha_Inicial : TDatetime;
                                     dFecha_Final   : TDatetime
                                   );
Var
   i : Integer;                                   
begin
  With dmComunInversiones.Qry_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Fecha_Paridad'
           +'      ,Valor_Moneda'
           +'  FROM Qs_Sys_Val_Cambio'
           +' WHERE Cod_Moneda      = :Cod_Moneda'
           +'   AND Tipo_De_Paridad = ''BC'''
           +'   AND Fecha_Paridad >= :Fecha_Inicial'
           +'   AND Fecha_Paridad <= :Fecha_Final'
           +'  ORDER BY Fecha_Paridad'
           );
    Parambyname('Cod_Moneda').asString     := sCodigo_Tasa;
    Parambyname('Fecha_Inicial').AsDate:= dFecha_Inicial;
    Parambyname('Fecha_Final').AsDate  := dFecha_Final;
    Prepare;
    Open;

    //Creo Arreglo y Cargo Valores
    ArrayValores := VarArrayCreate([0, RecordCount], varDouble);
    ArrayFechas  := VarArrayCreate([0, RecordCount], varDate);
    i := 0;
    while not Eof do
    begin
      ArrayFechas[i]  := Fieldbyname('Fecha_Paridad').asDatetime;
      ArrayValores[i] := Fieldbyname('Valor_Moneda').asFloat;
      Next;
      Inc(i);
    end;

    Close;
    Unprepare;
  end;
end;

procedure Busca_Valor( dFecha_Tasa  : TDatetime;
                   var dValor_Tasa  : Double;
                   var Result       : Boolean);
var i : Integer;
begin
  Result := False;
  for i := 0 to VarArrayHighBound(ArrayFechas , 1 )  do
  begin
    if ArrayFechas[i] = dFecha_Tasa then
    begin
      dValor_Tasa := ArrayValores[i];
      Result := True;
      Break;
    end;
  end;
end;

function Cupones_Cortados_Nemotecnico(sNemotecnico : String) : Double;
begin
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Cupones_Cortados');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA');
    SQL.Add(' WHERE Codigo_Nemotecnico = :Nemotecnico');

    ParamByName('Nemotecnico').AsString := sNemotecnico;

    Open;
    if FieldByName('Cupones_Cortados').IsNull then
       Result := 0
    else
       Result := FieldByName('Cupones_Cortados').AsFloat;
    Close
  end;
end;
//------------------------------------------------------------------------------
function Cupones_Cortados_Nemotecnico_Vig( sNemotecnico : String;
                                           dFecha_vig   : TDateTime
                                           ) : Double;
begin
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Cupones_Cortados');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA a');
    SQL.Add(' WHERE Codigo_Nemotecnico = :Nemotecnico');
    if sDriver = 'ORACLE' then
       SQL.Add('   AND TRUNC(a.Fecha_Vig) = (SELECT MAX(TRUNC(x.Fecha_Vig))')
    else
       SQL.Add('   AND CONVERT(CHAR(10),a.Fecha_Vig,103) = (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
    SQL.Add('                                                 FROM QS_FIN_NEM_RFIJA x');
    SQL.Add('			                             WHERE x.Codigo_Nemotecnico = a.Codigo_Nemotecnico  ');
    SQL.Add('      		                               AND x.Fecha_Vig         <= :Fecha_Vig)');


    ParamByName('Nemotecnico').AsString := sNemotecnico;
    ParamByname('Fecha_Vig').AsDate := dFecha_Vig;


    Open;
    if FieldByName('Cupones_Cortados').IsNull then
       Result := 0
    else
       Result := FieldByName('Cupones_Cortados').AsFloat;
    Close
  end;
end;
//------------------------------------------------------------------------------
function Leer_Tir_Mra( sNemotecnico        : String;
                       dFecha_Calculo      : TDatetime;
                       bBuscar_Ultima_Tasa : Boolean;
                   var sOrigen             : String;
                   var sTipo_TasPre        : String
                      ) : Double;

var fDias,
    anos_enteros,
    anos_fraccion,
    meses_enteros,
    fValor : Double;
    aa,
    mm,
    dd : word;
    dFecha_Tasa : TDateTime;
    aMeses  : Array[1..12] of String;
    bExiste,
    Resultado  : Boolean;
    dFecha_Emision,
    dFecha_Vencimiento : TDatetime;
    sTipoBono : String;
    sModulo_Err : String;
    sString_Err : String;
begin
  aMeses[1]  := 'ENERO';
  aMeses[2]  := 'FEBRERO';
  aMeses[3]  := 'MARZO';
  aMeses[4]  := 'ABRIL';
  aMeses[5]  := 'MAYO';
  aMeses[6]  := 'JUNIO';
  aMeses[7]  := 'JULIO';
  aMeses[8]  := 'AGOSTO';
  aMeses[9]  := 'SEPTIEMBRE';
  aMeses[10] := 'OCTUBRE';
  aMeses[11] := 'NOVIEMBRE';
  aMeses[12] := 'DICIEMBRE';

  Decodifica_Nemotecnico_Br(sNemotecnico,
                           sTipoBono,
                           dFecha_Emision,
                           dFecha_Vencimiento,
                           sModulo_Err,
                           sString_Err,
                           Resultado);

  calculo_de_dias( dFecha_Calculo,
                   dfecha_Vencimiento,
                   'EXACTOS',
                   'CL',
                   fDias,
                   anos_enteros,
                   anos_fraccion,
                   meses_enteros);

  Leer_Tir_Mra := 0;
  Decodedate(dFecha_Calculo, aa,mm,dd);

  if dFecha_Calculo >= EncodeDate(1998,01,01) then
    fValor := fDias
  else
    fValor := anos_fraccion;

  //Busco TIRMRA a ultimo dia del mes
  // SOLO SI LA FECHA DE CALCULO ES MAYOR O IGUAL A ESE DIA
  try
    dFecha_Tasa := Encodedate(aa, mm, ultimo_dia_mes( mm, aa));
  except
  end;

  if dFecha_Calculo < dFecha_Tasa then
  begin
    mm := mm - 1;
    if mm < 1 then
    begin
       mm := 12;
       aa := aa - 1;
    end;
    dFecha_Tasa := Encodedate(aa, mm, ultimo_dia_mes( mm, aa));
  end;


  with dmComunInversiones.QRY_GENERAL do
  begin
     Sql.Clear;
     if NOT bBuscar_Ultima_Tasa then
     begin
        Sql.Add('SELECT * FROM QS_FIN_VALOR_TRAMO'
              +' WHERE Codigo = ''TIRMRA'''
              +' AND   Fecha  = :Fecha');
        if sOrigen <> 'MUL-ORIGEN' then
        begin
           Sql.Add(' AND   Origen = :Origen');
           Parambyname('Origen').asString      := sOrigen;
        end;
     end
     else
     begin
        Sql.Add(' SELECT a.* FROM QS_FIN_VALOR_TRAMO a'
              +'  WHERE a.Codigo = ''TIRMRA'''
              +'    AND a.Fecha in (SELECT MAX(b.Fecha)'
                              +'  FROM QS_FIN_VALOR_TRAMO b'
                              +' WHERE b.Fecha <= :Fecha'
                              +'   AND b.Codigo = ''TIRMRA'' ');
             if sOrigen <> 'MUL-ORIGEN' then
             begin
                Sql.Add('    AND b.Origen = :Origen )'
                       +'    AND a.Origen = :Origen');
                Parambyname('Origen').asString      := sOrigen;
             end
             else
                Sql.Add(' )' );
     end;

     Parambyname('Fecha').AsDate     := dFecha_Tasa;
     Open;

     if Fieldbyname('Valor').isnull then
        Exit;

     bExiste := False;
     First;
     while (not eof) and (not bExiste) do
     begin
        if ((fValor >= Fieldbyname('Dias_desde').asFloat) and
            (fValor <= Fieldbyname('Dias_hasta').asFloat)) then
        begin
           Leer_Tir_Mra := FieldByname('Valor').asFloat;
           sTipo_TasPre := FieldByname('Tipo').asString;
           sOrigen      := FieldByname('Origen').asString;
           bExiste      := True;
        end;
        Next;
     end;
  end;

end;

function Leer_Tir_Mra_2(sNemotecnico        : String;
                        dFecha_Calculo      : TDatetime;
                        bBuscar_Ultima_Tasa : Boolean;
                    var sOrigen             : String;
                    var sTipo_TasPre        : String
                        ) : Double;

var fDias,
    anos_enteros,
    anos_fraccion,
    meses_enteros,
    fValor : Double;
    aa,
    mm,
    dd : word;
    dFecha_Tasa : TDateTime;
    aMeses  : Array[1..12] of String;
    bExiste,
    Resultado  : Boolean;
    dFecha_Emision,
    dFecha_Vencimiento : TDatetime;
    sTipoBono : String;
    sModulo_Err : String;
    sString_Err : String;
begin
  aMeses[1]  := 'ENERO';
  aMeses[2]  := 'FEBRERO';
  aMeses[3]  := 'MARZO';
  aMeses[4]  := 'ABRIL';
  aMeses[5]  := 'MAYO';
  aMeses[6]  := 'JUNIO';
  aMeses[7]  := 'JULIO';
  aMeses[8]  := 'AGOSTO';
  aMeses[9]  := 'SEPTIEMBRE';
  aMeses[10] := 'OCTUBRE';
  aMeses[11] := 'NOVIEMBRE';
  aMeses[12] := 'DICIEMBRE';

  Decodifica_Nemotecnico_Br(sNemotecnico,
                           sTipoBono,
                           dFecha_Emision,
                           dFecha_Vencimiento,
                           sModulo_Err,
                           sString_Err,
                           Resultado);

  calculo_de_dias( dFecha_Calculo,
                   dfecha_Vencimiento,
                   'EXACTOS',
                   'CL',
                   fDias,
                   anos_enteros,
                   anos_fraccion,
                   meses_enteros);

  Leer_Tir_Mra_2 := 0;
  Decodedate(dFecha_Calculo, aa,mm,dd);

  if dFecha_Calculo >= EncodeDate(1998,01,01) then
    fValor := fDias
  else
    fValor := anos_fraccion;

  //Busco TIRMRA a ultimo dia del mes
  // SOLO SI LA FECHA DE CALCULO ES MAYOR O IGUAL A ESE DIA
  try
    dFecha_Tasa := Encodedate(aa, mm, ultimo_dia_mes( mm, aa));
  except
  end;

  if dFecha_Calculo < dFecha_Tasa then
  begin
    mm := mm - 1;
    if mm < 1 then
    begin
       mm := 12;
       aa := aa - 1;
    end;
    dFecha_Tasa := Encodedate(aa, mm, ultimo_dia_mes( mm, aa));
  end;


  with dmComunInversiones.QRY_GENERAL do
  begin
     Sql.Clear;
     if NOT bBuscar_Ultima_Tasa then
     begin
        Sql.Add('SELECT * FROM QS_FIN_VALOR_TRAMO'
              +'  WHERE Codigo = ''TIRMRA2'''
              +'    AND   Fecha  = :Fecha' );
             if sOrigen <> 'MUL-ORIGEN' then
                Sql.Add(' AND   Origen = :Origen');
     end
     else
     begin
        Sql.Add(' SELECT a.* FROM QS_FIN_VALOR_TRAMO a'
              +'  WHERE a.Codigo = ''TIRMRA2'''
              +'    AND a.Fecha in (SELECT MAX(b.Fecha)'
                                  +'  FROM QS_FIN_VALOR_TRAMO b'
                                  +' WHERE b.Fecha <= :Fecha'
                                  +'   AND b.Codigo = ''TIRMRA2'' ');
             if sOrigen <> 'MUL-ORIGEN' then
             begin
                Sql.Add('  AND b.Origen = :Origen )'
                       +'  AND a.Origen = :Origen');
                Parambyname('Origen').asString := sOrigen;
             end
             else
                Sql.Add(' ) ');
     end;
     Parambyname('Fecha').AsDate     := dFecha_Tasa;
     Open;

     if Fieldbyname('Valor').isnull then
        Exit;

     bExiste := False;
     First;
     while (not eof) and (not bExiste) do
     begin
        if ((fValor >= Fieldbyname('Dias_desde').asFloat) and
            (fValor <= Fieldbyname('Dias_hasta').asFloat)) then
        begin
           Leer_Tir_Mra_2 := FieldByname('Valor').asFloat;
           sTipo_TasPre := FieldByname('Tipo').asString;
           sOrigen      := FieldByname('Origen').asString;
           bExiste      := True;
        end;
        Next;
     end;
  end;

end;

//------------------------------------------------------------------------------
procedure Decodifica_Nemotecnico_LH(var sNemotecnico   : String;
                                    dFecha_Operacion   : TdateTime;
                                    var dFecha_Emision : TdateTime;
                                    var sModulo_Err    : String;
                                    var sString_Err    : String;
                                    var Result         : Boolean);
var
  mm : Word;
  aa : Word;
  mm_Compra : Word;
  dd_Compra : Word;
  aa_Compra : Word;

begin
  Result := True;
  if (copy(sNemotecnico,8,1) <> '&') and
     (copy(sNemotecnico,8,1) <> '*') then
     exit;

  sModulo_Err := 'Decodificación Nemotecnicos';
  DecodeDate(dFecha_Operacion,aa_Compra,mm_Compra,dd_Compra);

  if copy(sNemotecnico,8,1) = '&' then
     begin
       try
         mm := StrToInt(copy(sNemotecnico,9,2))
       except
         sString_Err := 'Mes de emisión no valido (Caracteres 9 y 10)';
         Result := False;
         exit;
       end;

       if (mm < 1) or (mm > 12) then
          begin
            sString_Err := 'Mes de emisión no valido (Caracteres 9 y 10)';
            Result := False;
          end;

       if mm > mm_Compra then
          aa := aa_Compra - 1
       else
          aa := aa_Compra;

       dFecha_Emision := EncodeDate(aa,mm,01);
     end;

  if copy(sNemotecnico,8,1) = '*' then
     begin
       try
         aa := StrToInt(copy(sNemotecnico,9,2))
       except
         sString_Err := 'Año de emisión no valido (Caracteres 9 y 10)';
         Result := False;
         exit;
       end;

       if aa >= 60 then
          aa := StrToInt('19'                            // Dos primeras cifras del año
                        +copy(sNemotecnico,9,2))        // dos ultimas cifras nemotecnico
       else
          aa := StrToInt('20'                            // Dos primeras cifras del año
                        +copy(sNemotecnico,9,2));        // dos ultimas cifras nemotecnico

       dFecha_Emision := EncodeDate(aa,01,01);
     end;
end;
//------------------------------------------------------------------------------
Procedure Determina_Tasa_Financiera( sPais       : String;
                                    sCartera     : String;
                                    sInstrumento : String;
                                    dFecha       : TDatetime;
                                var sTipo_Tasa   : String;
                                var Result       : Boolean ); //OJO
var sWhere_Pais : String;
begin
  Result := True;
  with dmComunInversiones.Qry_General do
  begin
     // Busco una vez...si no hay registro...Chaolin
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs'
             +' FROM QS_FIN_USO_TASA'
             );
      Open;
      if (FieldByName('Num_Regs').AsFloat = 0) or
         (FieldByName('Num_Regs').IsNull     ) then
      begin
         Close;
         Exit;
      end;

      //Verifica si existe definición de tasa para Pais
      // Solo ese caso agrega condicion
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs'
             +' FROM QS_FIN_USO_TASA'
             +' WHERE Pais_Emision  = :Pais_Emision'
             +'   AND Fecha_Desde  <= :Fecha'
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
             );
      ParamByName('Pais_Emision').AsString := sPais;
      ParamByName('Fecha').AsDate      := dFecha;
      Open;

      if (FieldByName('Num_Regs').AsFloat = 0) or
         (FieldByName('Num_Regs').IsNull     ) then
         sWhere_Pais := ''
      else
         sWhere_Pais := ' AND Pais_Emision = :Pais_Emision';

      Close;
      Unprepare;
      // Busco para Cartera, Instrumento
      SQL.Clear;
      SQL.Add('SELECT Tipo_Tasa'
             +'  FROM QS_FIN_USO_TASA'
             +' WHERE Cartera     = :Cartera'
             +'   AND Instrumento = :Instrumento'
             +'   AND Fecha_Desde  <= :Fecha'
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
             );
      SQL.Add(sWhere_Pais);

      ParamByName('Cartera').AsString     := sCartera;
      ParamByName('Instrumento').AsString := sInstrumento;
      ParamByName('Fecha').AsDate     := dFecha;
      if sWhere_Pais <> '' then
         ParamByName('Pais_Emision').AsString := sPais;

      Prepare;
      Open;

      if FieldByName('Tipo_Tasa').IsNull then
      begin
         Close;
         UnPrepare;
         // Busco para Cartera
         SQL.Clear;
         SQL.Add('SELECT Tipo_Tasa'
                +'  FROM QS_FIN_USO_TASA'
                +' WHERE Cartera     = :Cartera'
                +'   AND (Instrumento IS NULL OR Instrumento = '' '')'
                +'   AND Fecha_Desde  <= :Fecha'
                +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                );
         SQL.Add(sWhere_Pais);
         ParamByName('Cartera').asString := sCartera;
         Parambyname('Fecha').AsDate := dFecha;

         if sWhere_Pais <> '' then
            ParamByName('Pais_Emision').AsString := sPais;

         Prepare;
         Open;

         if FieldByName('Tipo_Tasa').IsNull then
         begin
            Close;
            Unprepare;
            // Busco para Instrumento
            SQL.Clear;
            SQL.Add('SELECT Tipo_Tasa'
                   +'  FROM QS_FIN_USO_TASA'
                   +' WHERE Instrumento = :Instrumento'
                   +'   AND (Cartera IS NULL OR Cartera = '' '')'
                   +'   AND Fecha_Desde  <= :Fecha'
                   +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                   );
            SQL.Add(sWhere_Pais);
            ParamByName('Instrumento').asString := sInstrumento;
            Parambyname('Fecha').AsDate     := dFecha;

            if sWhere_Pais <> '' then
               ParamByName('Pais_Emision').AsString := sPais;

            Prepare;
            Open;

            //Busco solo para pais
            if (FieldByName('Tipo_Tasa').IsNull) and
               (sWhere_Pais <> '') then
            begin
               Close;
               Unprepare;
               // Busco para Instrumento
               SQL.Clear;
               SQL.Add('SELECT Tipo_Tasa'
                      +'  FROM QS_FIN_USO_TASA'
                      +' WHERE (Instrumento IS NULL OR  Instrumento = '' '')'
                      +'   AND (Cartera IS NULL OR Cartera = '' '')'
                      +'   AND Fecha_Desde  <= :Fecha'
                      +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                      );
               SQL.Add(sWhere_Pais);
               Parambyname('Fecha').AsDate     := dFecha;

               if sWhere_Pais <> '' then
                  ParamByName('Pais_Emision').AsString := sPais;

               Prepare;
               Open;
            end;

            if FieldByName('Tipo_Tasa').IsNull then
               Result := False;

         end;
      end;

      if Result then
         sTipo_Tasa := Fieldbyname('Tipo_Tasa').asString;

      Close;
      Unprepare;
  end;
end;
{Se reemplza por la memory 04-09-2014
Procedure Determina_Dias_Efectivos_Pago( sPais,
                                         sEmisor,
                                         sInstrumento,
                                         sSerie,
                                         sNemotecnico   : String;
                                         dFecha         : TDatetime;
                                     var fCantidad	: Double;
                                     var sUnidad 	: String;
                                     var sHabiles	: String;
                                     var sAntes_Despues : String;
                                     var sAfecta        : String;
                                     var Result         : Boolean ); //New_OJO
var
sWhere_Pais: String;
sWhere_Emisor: String;
sWhere_Instrumento: String;
sWhere_Serie: String;
sWhere_Nemotecnico : String;
bExiste_QS_FIN_DIF_PAGO : Boolean;

bModulo_Error : String;
bString_Error : String;
bResult       : Boolean;

begin
  Result := False;
  Existe_Tabla_en_Base_de_datos( sDriver
                                ,'QS_FIN_DIF_PAGO'
                                ,bModulo_Error
                                ,bString_Error
                                ,bExiste_QS_FIN_DIF_PAGO
                                ,bResult);

  if not bExiste_QS_FIN_DIF_PAGO then
  begin
      Result := False;
      exit;
  end;

  with dmComunInversiones.Qry_General do
  begin
      sWhere_Pais        := '';
      sWhere_Emisor      := '';
      sWhere_Instrumento := '';
      sWhere_Serie       := '';
      sWhere_Nemotecnico := '';

      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs '
             +' FROM QS_FIN_DIF_PAGO       '
             );
      Open;
      if FieldByName('Num_Regs').AsFloat = 0  then
      begin
         Close;
         Result := False;
         exit;
      end;

// Existe Pais
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs '
             +' FROM QS_FIN_DIF_PAGO       '
             +' WHERE pais_emision <> '' ''   '
             +'   AND Fecha_Desde  <= :Fecha '
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL) '
             );
      ParamByName('Fecha').Asdatetime := dFecha;
      Open;
      if FieldByName('Num_Regs').AsFloat = 0  then
         sWhere_Pais        := ''
      else
         sWhere_Pais        := ' AND Pais_Emision = :Pais';
      Close;
      Unprepare;
// Existe Emisor
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs '
             +' FROM QS_FIN_DIF_PAGO       '
             +' WHERE emisor <> '' ''   '
             +'   AND Fecha_Desde  <= :Fecha '
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL) '
             );
      ParamByName('Fecha').Asdatetime := dFecha;
      Open;
      if FieldByName('Num_Regs').AsFloat = 0  then
         sWhere_Emisor        := ''
      else
         sWhere_Emisor      := ' AND emisor = :emisor';
      Close;
      Unprepare;
// Existe Instrumento
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs '
             +' FROM QS_FIN_DIF_PAGO       '
             +' WHERE Instrumento <> '' ''   '
             +'   AND Fecha_Desde  <= :Fecha '
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL) '
             );
      ParamByName('Fecha').Asdatetime := dFecha;
      Open;
      if FieldByName('Num_Regs').AsFloat = 0  then
         sWhere_Instrumento        := ''
      else
         sWhere_Instrumento := ' AND Instrumento = :Instrumento';
      Close;
      Unprepare;
// Existe serie
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs '
             +' FROM QS_FIN_DIF_PAGO       '
             +' WHERE serie <> '' ''   '
             +'   AND Fecha_Desde  <= :Fecha '
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL) '
             );
      ParamByName('Fecha').Asdatetime := dFecha;
      Open;
      if FieldByName('Num_Regs').AsFloat = 0  then
         sWhere_Serie       := ''
      else
         sWhere_Serie       := ' AND serie = :serie';
      Close;
      Unprepare;
// Existe Nemotecnico
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As Num_Regs '
             +' FROM QS_FIN_DIF_PAGO       '
             +' WHERE Nemotecnico <> '' ''   '
             +'   AND Fecha_Desde  <= :Fecha '
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL) '
             );
      ParamByName('Fecha').Asdatetime := dFecha;
      Open;
      if FieldByName('Num_Regs').AsFloat = 0  then
         sWhere_Nemotecnico       := ''
      else
         sWhere_Nemotecnico := ' AND Nemotecnico = :Nemotecnico';
      Close;
      Unprepare;


// Si no existe criterio de busqueda chao

      if (sWhere_Pais = '') And
         (sWhere_Emisor = '' ) And
         (sWhere_Instrumento = ''  ) And
         (sWhere_Serie = '' ) And
         (sWhere_Nemotecnico = '' ) Then
      begin
         Result := False;
         exit;
      end;

      SQL.Clear;
      SQL.Add('SELECT Cantidad'
             +'      ,Unidad'
             +'      ,Habiles'
             +'      ,Antes_Despues'
             +'      ,Afecta'
             +'  FROM  QS_FIN_DIF_PAGO'
             +'  WHERE Fecha_Desde  <= :Fecha'
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
             );
      if sWhere_Pais <> '' Then
         SQL.Add(sWhere_Pais);
      if sWhere_Emisor <> '' Then
         SQL.Add(sWhere_Emisor);
      if sWhere_Instrumento <> '' Then
         SQL.Add(sWhere_Instrumento);
      if sWhere_Serie <> '' Then
         SQL.Add(sWhere_Serie);
      if sWhere_Nemotecnico <> '' Then
         SQL.Add(sWhere_Nemotecnico);

      ParamByName('Fecha').Asdatetime     := dFecha;
      if sWhere_Pais <> '' Then
         ParamByName('Pais').AsString         := sPais;
      if sWhere_Emisor <> '' Then
         ParamByName('emisor').AsString       := sEmisor;
      if sWhere_Instrumento <> '' Then
         ParamByName('Instrumento').AsString  := sInstrumento;
      if sWhere_Serie <> '' Then
         ParamByName('serie').AsString        := sSerie;
      if sWhere_Nemotecnico <> '' Then
         ParamByName('Nemotecnico').AsString  := sNemotecnico;

      Open;
      if Not eof then
      begin
         fCantidad      := Fieldbyname('Cantidad').asFloat;
         sUnidad        := Fieldbyname('Unidad').asString;
         sHabiles       := Fieldbyname('Habiles').asString;
         sAntes_Despues := Fieldbyname('Antes_Despues').asString;
         sAfecta        := Fieldbyname('Afecta').asString;
         Result         := True;
      end;
      Close;
      Unprepare;

(*

      // Busco para Emisor, Instrumento, Serie, Nemotecnico
      SQL.Clear;
      SQL.Add('SELECT Cantidad'
             +'      ,Unidad'
             +'      ,Habiles'
             +'      ,Antes_Despues'
             +'  FROM QS_FIN_DIF_PAGO'
             +' WHERE Emisor      = :Emisor'
             +'   AND Serie       = :Serie'
             +'   AND Instrumento = :Instrumento'
             +'   AND Nemotecnico = :Nemotecnico'
             +'   AND Fecha_Desde  <= :Fecha'
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
             );
      SQL.Add(sWhere_Pais);
      ParamByName('Emisor'     ).AsString := sEmisor;
      ParamByName('Instrumento').AsString := sInstrumento;
      ParamByName('Serie'      ).AsString := sSerie;
      ParamByName('Nemotecnico').AsString := sNemotecnico;
      ParamByName('Fecha').Asdatetime     := dFecha;
      if sWhere_Pais <> '' then
         ParamByName('Pais').AsString     := sPais;

      Open;

      if FieldByName('Cantidad').IsNull then
      begin
         Close;
         UnPrepare;
         // Busco para Emisor, Instrumento, Serie
         SQL.Clear;
         SQL.Add('SELECT Cantidad'
                +'      ,Unidad'
                +'      ,Habiles'
                +'      ,Antes_Despues'
                +'  FROM QS_FIN_DIF_PAGO'
                +' WHERE Emisor      = :Emisor'
                +'   AND Serie       = :Serie'
                +'   AND Instrumento = :Instrumento'
                +'   AND (Nemotecnico IS NULL OR Nemotecnico = '' '')'
                +'   AND Fecha_Desde  <= :Fecha'
                +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                );
         SQL.Add(sWhere_Pais);
         ParamByName('Emisor'     ).AsString := sEmisor;
         ParamByName('Instrumento').AsString := sInstrumento;
         ParamByName('Serie'      ).AsString := sSerie;
         ParamByName('Fecha').Asdatetime     := dFecha;
         if sWhere_Pais <> '' then
            ParamByName('Pais').AsString     := sPais;

         Open;

         if FieldByName('Cantidad').IsNull then
         begin
            Close;
            Unprepare;
            // Busco para Emisor, Instrumento
            SQL.Clear;
            SQL.Add('SELECT Cantidad'
                   +'      ,Unidad'
                   +'      ,Habiles'
                   +'      ,Antes_Despues'
                   +'  FROM QS_FIN_DIF_PAGO'
                   +' WHERE Emisor      = :Emisor'
                   +'   AND Instrumento = :Instrumento'
                   +'   AND (Serie IS NULL OR Serie = '' '')'
                   +'   AND (Nemotecnico IS NULL OR Nemotecnico = '' '')'
                   +'   AND Fecha_Desde  <= :Fecha'
                   +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                   );
             SQL.Add(sWhere_Pais);
             ParamByName('Emisor'     ).AsString := sEmisor;
             ParamByName('Instrumento').AsString := sInstrumento;
             ParamByName('Fecha').Asdatetime     := dFecha;
             if sWhere_Pais <> '' then
                ParamByName('Pais').AsString     := sPais;
             Open;

             if (FieldByName('Cantidad').IsNull) then
             begin
               Close;
               Unprepare;
               // Busco para Emisor
               SQL.Clear;
               SQL.Add('SELECT Cantidad'
                      +'      ,Unidad'
                      +'      ,Habiles'
                      +'      ,Antes_Despues'
                      +'  FROM QS_FIN_DIF_PAGO'
                      +' WHERE Emisor      = :Emisor'
                      +'   AND (Instrumento IS NULL OR Instrumento = '' '')'
                      +'   AND (Serie IS NULL OR Serie = '' '')'
                      +'   AND (Nemotecnico IS NULL OR Nemotecnico = '' '')'
                      +'   AND Fecha_Desde  <= :Fecha'
                      +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                      );
                SQL.Add(sWhere_Pais);
                ParamByName('Emisor'     ).AsString := sEmisor;
                ParamByName('Fecha').Asdatetime     := dFecha;
                if sWhere_Pais <> '' then
                   ParamByName('Pais').AsString     := sPais;

               Open;

               if (FieldByName('Cantidad').IsNull) and
                  (sWhere_Pais <> '')              then
               begin
                  Close;
                  Unprepare;
                  // Busco para Pais
                  SQL.Clear;
                  SQL.Add('SELECT Cantidad'
                         +'      ,Unidad'
                         +'      ,Habiles'
                         +'      ,Antes_Despues'
                         +'  FROM QS_FIN_DIF_PAGO'
                         +' WHERE (Emisor IS NULL OR Emisor = '' '')'
                         +'   AND (Instrumento IS NULL OR Instrumento = '' '')'
                         +'   AND (Serie IS NULL OR Serie = '' '')'
                         +'   AND (Nemotecnico IS NULL OR Nemotecnico = '' '')'
                         +'   AND Fecha_Desde  <= :Fecha'
                         +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                         );
                   SQL.Add(sWhere_Pais);
                   ParamByName('Fecha').Asdatetime     := dFecha;
                   if sWhere_Pais <> '' then
                      ParamByName('Pais').AsString := sPais;
                  Open;
               end;

               if FieldByName('Cantidad').IsNull then
                  Result := False;

             end;
         end;
      end;
      if Result then
      begin
         fCantidad      := Fieldbyname('Cantidad').asFloat;
         sUnidad        := Fieldbyname('Unidad').asString;
         sHabiles       := Fieldbyname('Habiles').asString;
         sAntes_Despues := Fieldbyname('Antes_Despues').asString;
      end;
      Close;
      Unprepare;
*)
  end;
end;
}
//------------------------------------------------------------------------------
procedure Busca_Valuacion( Reg_Val_In   : TRegistro_Valoriza_In;
                           var sTipo_Valuac : String;
                           var sFormula_Pte : String;
                           var fBase_Precio : Double;
                           var sMon_Ind     : String;
                           var sOrigen      : String;
                           var bValuacion   : Boolean);
var sTasa_Base      : string;
    sCodigo_Formula : string;
begin

   sTasa_Base      := '';
   sCodigo_Formula := '';

   Busca_Valuacion(Reg_Val_In
                  ,sTipo_Valuac
                  ,sFormula_Pte
                  ,fBase_Precio
                  ,sMon_Ind
                  ,sOrigen
                  ,sTasa_Base
                  ,sCodigo_Formula
                  ,bValuacion);

end;

procedure Busca_Valuacion( Reg_Val_In          : TRegistro_Valoriza_In;
                           var sTipo_Valuac    : String;
                           var sFormula_Pte    : String;
                           var fBase_Precio    : Double;
                           var sMon_Ind        : String;
                           var sOrigen         : String;
                           var sTasa_Base      : string;
                           var sCodigo_Formula : string;
                           var bValuacion      : Boolean) overload;
var
  sWhere_Proceso     : String;
  sWhere_Transaccion : String;
  sWhere_Cartera     : String;
  sWhere_Pais        : String;

  bProceso     : boolean;
  bTransaccion : boolean;
  bCartera     : boolean;
  bPais        : boolean;

  y            : Integer;

begin
  bValuacion   := True;
  with dmComunInversiones.Qry_General do
  begin

    //Verifica si existe valuacion definida por proceso
    //bProceso := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As Num_Regs');
    SQL.Add('  FROM QS_FIN_MET_VALUAC');
    SQL.Add(' WHERE Proceso       = :Proceso');
    ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;
    Open;
    if (FieldByName('Num_Regs').AsFloat = 0) or
       (FieldByName('Num_Regs').IsNull     ) then
    begin
       // 31-05-2007 Se modifica para que si no encuentra proceso busque solo procesos en blanco
       // Antes si no encontraba el proceso buscado ocupaba el primero que encontraba
       sWhere_Proceso := 'AND (Proceso is null or Proceso = '''' )';
       bProceso := False;
    end
    else
    begin
       sWhere_Proceso := ' AND Proceso = :Proceso';
       bProceso := True;
    end;
    Close;

    //Verifica si existe valuacion definida por transaccion
    //bTransaccion := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As Num_Regs');
    SQL.Add('  FROM QS_FIN_MET_VALUAC');
    SQL.Add(' WHERE Transaccion = :Transaccion');
    SQL.Add(sWhere_Proceso);
    if bProceso then
       ParamByName('Proceso').AsString  := Reg_Val_In.Proceso_Valuacion;
    ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
    try
       Open;
    except on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;

    if (FieldByName('Num_Regs').AsFloat = 0) or
       (FieldByName('Num_Regs').IsNull     ) or
       (Trim(Reg_Val_In.Transaccion)   = '') then  // 17-01-2019
    begin
       sWhere_Transaccion := 'AND (Transaccion is null or Transaccion = '''' )';
       bTransaccion := False;
    end
    else
    begin
       sWhere_Transaccion := ' AND Transaccion = :Transaccion';
       bTransaccion := True;
    end;
    Close;

    //Verifica si existe valuacion definida por cartera
    // Solo ese caso agrega condicion
    bCartera := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As Num_Regs');
    SQL.Add('  FROM QS_FIN_MET_VALUAC');
    SQL.Add(' WHERE Cartera       = :Cartera');
    SQL.Add(sWhere_Proceso);
    if bProceso then
       ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;
    ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
    Open;
    if (FieldByName('Num_Regs').AsFloat = 0) or
       (FieldByName('Num_Regs').IsNull     ) then
       sWhere_Cartera := 'AND (Cartera is null or Cartera = '''' )'
    else
    begin
       sWhere_Cartera := ' AND Cartera = :Cartera';
       bCartera := True;
    end;
    Close;

    //Verifica si existe valuacion definida por pais
    // Solo ese caso agrega condicion
    bPais := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As Num_Regs');
    SQL.Add('  FROM QS_FIN_MET_VALUAC');
    SQL.Add(' WHERE Pais       = :Pais');
    SQL.Add(sWhere_Proceso);
    if bProceso then
       ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;
    ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
    try
       Open;
    except on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;

    if (FieldByName('Num_Regs').AsFloat = 0) or
       (FieldByName('Num_Regs').IsNull     ) then
       sWhere_Pais := 'AND (Pais is null or Pais = '''' )'
    else
    begin
       sWhere_Pais := ' AND Pais = :Pais';
       bPais := True;
    end;
    Close;

    for y := 1 to 2 do
    begin

       // Busco Valuacion para Emisor, Instrumento, Serie y Motivo
       SQL.Clear;
       SQL.Add('SELECT TIPO_VALUAC');
       SQL.Add('      ,FORMULA_PTE');
       SQL.Add('      ,BASE_PRECIO');
       SQL.Add('      ,MON_IND');
       SQL.Add('      ,ORIGEN');
       SQL.Add('      ,TASA_BASE_TABDESARR');
       SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
       SQL.Add('  FROM QS_FIN_MET_VALUAC');
       SQL.Add(' WHERE Serie       = :Serie');
       SQL.Add('   AND Instrumento = :Instrumento');
       SQL.Add('   AND Emisor      = :Emisor');
       SQL.Add('   AND Motivo      = :Motivo');
       if y = 1 then
          SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
       else
          SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

       SQL.Add('   AND Fecha_Desde <= :Fecha');
       SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

       SQL.Add(sWhere_Pais);
       SQL.Add(sWhere_Cartera);
       SQL.Add(sWhere_Transaccion);
       SQL.Add(sWhere_Proceso);

       ParamByName('Emisor'     ).AsString := Reg_Val_In.sEmisor;
       ParamByName('Instrumento').AsString := Reg_Val_In.sInstrumento;
       ParamByName('Serie'      ).AsString := Reg_Val_In.sSerie;
       ParamByName('Motivo'     ).AsString := Reg_Val_In.Motivo_Operacion;
       ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;
       if y = 1 then
          ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;

       If bPais Then
          ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
       If bCartera Then
          ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
       if bTransaccion Then
          ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
       if bProceso then
          ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;

       Open;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         // Busco Valuacion para Emisor,Instrumento y Serie
         SQL.Clear;
         SQL.Add('SELECT TIPO_VALUAC');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE Serie       = :Serie');
         SQL.Add('   AND Instrumento = :Instrumento');
         SQL.Add('   AND Emisor      = :Emisor');
         SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);
         ParamByName('Emisor'     ).AsString := Reg_Val_In.sEmisor;
         ParamByName('Instrumento').AsString := Reg_Val_In.sInstrumento;
         ParamByName('Serie'      ).AsString := Reg_Val_In.sSerie;
         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;

         Prepare;
         Open;
       end;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         UnPrepare;
         // Busco Valuacion para Emisor, Instrumento y Motivo
         SQL.Clear;
         SQL.Add('SELECT Tipo_Valuac');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
         SQL.Add('   AND Instrumento = :Instrumento');
         SQL.Add('   AND Emisor      = :Emisor');
         SQL.Add('   AND Motivo      = :Motivo');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);

         ParamByName('Emisor'     ).AsString := Reg_Val_In.sEmisor;
         ParamByName('Instrumento').AsString := Reg_Val_In.sInstrumento;
         ParamByName('Motivo'     ).AsString := Reg_Val_In.Motivo_Operacion;
         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;

         Prepare;
         Open;
       end;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         UnPrepare;
         // Busco Valuacion para Emisor y Instrumento
         SQL.Clear;
         SQL.Add('SELECT Tipo_Valuac');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
         SQL.Add('   AND Instrumento = :Instrumento');
         SQL.Add('   AND Emisor      = :Emisor');
         SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);

         ParamByName('Emisor'     ).AsString := Reg_Val_In.sEmisor;
         ParamByName('Instrumento').AsString := Reg_Val_In.sInstrumento;
         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;

         Prepare;
         Open;
       end;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         UnPrepare;
         // Busco Valuacion para Emisor y Motivo
         SQL.Clear;
         SQL.Add('SELECT Tipo_Valuac');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
         SQL.Add('   AND (Instrumento IS NULL OR Instrumento = '''')');
         SQL.Add('   AND Emisor      = :Emisor');
         SQL.Add('   AND Motivo      = :Motivo');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);

         ParamByName('Emisor'     ).AsString := Reg_Val_In.sEmisor;
         ParamByName('Motivo'     ).AsString := Reg_Val_In.Motivo_Operacion;
         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;


         Prepare;
         Open;
       end;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         UnPrepare;
         // Busco Valuacion para Emisor
         SQL.Clear;
         SQL.Add('SELECT Tipo_Valuac');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
         SQL.Add('   AND (Instrumento IS NULL OR Instrumento = '''')');
         SQL.Add('   AND Emisor      = :Emisor');
         SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);

         ParamByName('Emisor'     ).AsString := Reg_Val_In.sEmisor;
         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;

         Prepare;
         Open;
       end;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         UnPrepare;
         // Busco Valuacion para Instrumento
         SQL.Clear;
         SQL.Add('SELECT Tipo_Valuac');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
         SQL.Add('   AND Instrumento  = :Instrumento');
         SQL.Add('   AND (Emisor IS NULL OR Emisor = '''')');
         SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);

         ParamByName('Instrumento').AsString := Reg_Val_In.sInstrumento;
         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;

         Prepare;
         Open;
       end;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         UnPrepare;
         // Busco Valuacion para Motivo
         SQL.Clear;
         SQL.Add('SELECT Tipo_Valuac');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
         SQL.Add('   AND (Instrumento IS NULL OR Instrumento = '''')');
         SQL.Add('   AND (Emisor      IS NULL OR Emisor = '''')');
         SQL.Add('   AND Motivo      = :Motivo');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);

         ParamByName('Motivo'     ).AsString := Reg_Val_In.Motivo_Operacion;
         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;


         Prepare;
         Open;
       end;

       if FieldByName('Tipo_Valuac').IsNull then
       begin
         Close;
         UnPrepare;
         // Busco Valuacion para Moneda Instrumento
         SQL.Clear;
         SQL.Add('SELECT Tipo_Valuac');
         SQL.Add('      ,FORMULA_PTE');
         SQL.Add('      ,BASE_PRECIO');
         SQL.Add('      ,MON_IND');
         SQL.Add('      ,ORIGEN');
         SQL.Add('      ,TASA_BASE_TABDESARR');
         SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
         SQL.Add('  FROM QS_FIN_MET_VALUAC');
         SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
         SQL.Add('   AND (Instrumento IS NULL OR Instrumento = '''')');
         SQL.Add('   AND (Emisor      IS NULL OR Emisor = '''')');
         SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
         if y = 1 then
            SQL.Add('   AND Moneda_Instrum = :Moneda_Instrum')
         else
            SQL.Add('   AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');

         SQL.Add('   AND Fecha_Desde <= :Fecha');
         SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

         SQL.Add(sWhere_Pais);
         SQL.Add(sWhere_Cartera);
         SQL.Add(sWhere_Transaccion);
         SQL.Add(sWhere_Proceso);

         if y = 1 then
            ParamByName('Moneda_Instrum').AsString := Reg_Val_In.sUnidadMonetaria;
         ParamByName('Fecha'      ).AsDate   := Reg_Val_In.dFechaCalculo;

         If bPais Then
            ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
         If bCartera Then
            ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
         if bTransaccion Then
            ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
         if bProceso then
            ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;


         Prepare;
         Open;
       end;

       if not FieldByName('Tipo_Valuac').IsNull then
          Break
    end;

    if (FieldByName('Tipo_Valuac').IsNull) then
    begin
      Close;
      UnPrepare;
      // Busco Valuacion solo pais
      SQL.Clear;
      SQL.Add('SELECT Tipo_Valuac');
      SQL.Add('      ,FORMULA_PTE');
      SQL.Add('      ,BASE_PRECIO');
      SQL.Add('      ,MON_IND');
      SQL.Add('      ,ORIGEN');
      SQL.Add('      ,TASA_BASE_TABDESARR');
      SQL.Add('      ,CODIGO_FORMULA_TABDESARR');
      SQL.Add('  FROM QS_FIN_MET_VALUAC');
      SQL.Add(' WHERE (Serie IS NULL OR Serie = '''')');
      SQL.Add('   AND (Instrumento IS NULL OR Instrumento = '''')');
      SQL.Add('   AND (Emisor      IS NULL OR Emisor = '''')');
      SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');

      SQL.Add('   AND Fecha_Desde <= :Fecha');
      SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

      SQL.Add(sWhere_Pais);
      SQL.Add(sWhere_Cartera);
      SQL.Add(sWhere_Transaccion);
      SQL.Add(sWhere_Proceso);

      ParamByName('Fecha'      ).AsDate  := Reg_Val_In.dFechaCalculo;

      If bPais Then
         ParamByName('Pais').AsString := Reg_Val_In.Pais_Titulo;
      If bCartera Then
         ParamByName('Cartera').AsString := Reg_Val_In.Cartera;
      if bTransaccion Then
         ParamByName('Transaccion').AsString := Reg_Val_In.Transaccion;
      if bProceso then
         ParamByName('Proceso').AsString := Reg_Val_In.Proceso_Valuacion;

      Prepare;
      Open;
    end;

    if FieldByName('Tipo_Valuac').IsNull then
       bValuacion := False;

    if bValuacion then
    begin
      sTipo_Valuac    := FieldByName('Tipo_Valuac').AsString;
      sFormula_Pte    := FieldByName('Formula_Pte').AsString;
      fBase_Precio    := FieldByName('Base_Precio').AsFloat;
      sMon_Ind        := FieldByName('Mon_Ind'    ).AsString;
      sOrigen         := FieldByName('Origen'     ).AsString;
      sTasa_Base      := FieldByName('Tasa_Base_TabDesarr').AsString;
      sCodigo_Formula := FieldByName('Codigo_Formula_TabDesarr').AsString;
    end;
    Close;
    Unprepare;

  end; // With Query_General
end;

procedure Cupones_Impagos(sEmpresa                 : String;
                          sTransaccion             : String;
                          sFolio                   : String;
                          fItem_Omd                : Double;
                          dFecha                   : TDateTime;
                          var fMonto_Impago_UM     : Double;
                          var fNro_Cupones_Impagos : Double);
begin
  with dmComunInversiones.Qry_Cupones_Impagos do
  begin
//    SQL.Clear;
//    SQL.Add('SELECT sum(monto_um_movimiento) As Monto_Impago_UM                 ');
//    SQL.Add('      ,count(*)                 As Nro_Cupones_Impagos             ');
//    SQL.Add('  FROM qs_tes_egring a                                             ');
//    SQL.Add(' WHERE a.folio_interno_omd = :Folio_Interno                        ');
//    SQL.Add('   AND a.transaccion_omd   = :Transaccion                          ');
//    SQL.Add('   AND a.item_omd          = :Item_Omd                             ');
//    SQL.Add('   AND a.empresa           = :Empresa                              ');
//    SQL.Add('   AND a.fecha_mov        <= :Fecha                                ');
//    SQL.Add('   AND (a.fecha_pago      IS NULL                                  ');
//    SQL.Add('      OR a.Fecha_pago      >  :Fecha)                               ');

    ParamByName('Fecha'      ).AsDate := dFecha;
    ParamByName('Empresa'    ).AsString   := sEmpresa;
    ParamByName('Transaccion').AsString   := sTransaccion;
    ParamByName('Folio_Interno').AsString := sFolio;
    ParamByName('Item_Omd'   ).AsFloat    := fItem_Omd;
    Open;
    if FieldByName('Nro_Cupones_Impagos').AsFloat = 0  then
       begin
         fMonto_Impago_UM     := 0;
         fNro_Cupones_Impagos := 0;
       end
    else
       begin
         fMonto_Impago_UM     := FieldByName('Monto_Impago_UM').AsFloat;
         fNro_Cupones_Impagos := FieldByName('Nro_Cupones_Impagos').AsFloat;
       end;
    Close
  end;
end;
//------------------------------------------------------------------------------
procedure provision_mutuo(iNro_Cupones_Impagos     : Double;
                          sMoneda_Instrum          : String;
                          fMonto_Impago_UM         : Double;
                          fValor_Tasacion          : Double;
                          fSaldo_Insoluto_UM       : Double;
                          fValor_Presente_UM       : Double;
                          var fProvision           : Double);
begin
     if (iNro_Cupones_Impagos = 0) then
     begin
       fProvision := 0;
       Exit;
     end;

     if (iNro_Cupones_Impagos >  0) and
        (iNro_Cupones_Impagos <= 4) then
     begin
       if ((0.8 * fValor_Tasacion) <
           (fSaldo_Insoluto_UM + fMonto_Impago_UM)) then
          fProvision := fMonto_Impago_UM
       else
          fProvision := 0;
       Exit;
     end;

     if (iNro_Cupones_Impagos >= 5) and
        (iNro_Cupones_Impagos <  36) then
     begin
       if ((0.8 * fValor_Tasacion) < fSaldo_Insoluto_UM) then
          fProvision := fSaldo_Insoluto_UM +
                        fMonto_Impago_UM -
                        (fValor_Tasacion * 0.8 )
       else
          fProvision := fSaldo_Insoluto_UM +
                        fMonto_Impago_UM -
                        fSaldo_Insoluto_UM;
       Exit;
     end;

    if (iNro_Cupones_Impagos >= 36) then
//       fProvision := fValor_Presente_UM + fMonto_Impago_UM -1; // NO DEBO RESTAR 1 a Valor en UM 
       fProvision := fValor_Presente_UM + fMonto_Impago_UM;
end;
//------------------------------------------------------------------------------
function Tasacion_Omd_Braiz(sEmpresa                 : String;
                            sTransaccion             : String;
                            sFolio                   : String;
                            fItem_Omd                : Double;
                            dFecha                   : TDateTime;
                            var dFecha_Retasacion    : TDatetime;
                            var sMoneda_Tasacion     : String ) : Double;
begin
  with dmComunInversiones.QRY_TasBraiz do
  begin
    {
    SQL.Clear;
    SQL.Add('SELECT a.Tasacion_1 ');
    Sql.Add('      ,a.Fecha_Desde' );
    Sql.Add('      ,a.Moneda_Tas' );
    SQL.Add('  FROM QS_TRA_OMD_TAS_BRAIZ a         ');
    SQL.Add(' WHERE a.Folio_Interno = :Folio       ');
    SQL.Add('   AND a.Transaccion   = :Transaccion ');
    SQL.Add('   AND a.Item_Omd      = :Item_Omd    ');
    SQL.Add('   AND a.Empresa       = :Empresa     ');
    SQL.Add('   AND a.Fecha_Desde   =  (SELECT MAX(b.Fecha_Desde)                 ');
    SQL.Add('                             FROM QS_TRA_OMD_TAS_BRAIZ b             ');
    SQL.Add('                            WHERE b.Folio_Interno = a.Folio_Interno  ');
    SQL.Add('                              AND b.Transaccion   = a.Transaccion    ');
    SQL.Add('                              AND b.Item_Omd      = a.Item_Omd       ');
    SQL.Add('                              AND b.Empresa       = a.Empresa        ');
    SQL.Add('                              AND b.Fecha_Desde   <= :Fecha          ');
    SQL.Add('                              AND (b.Fecha_Hasta  IS NULL            ');
    SQL.Add('                                OR b.Fecha_Hasta >= :Fecha))         ');
    }
    ParamByName('Folio'      ).AsString   := sFolio;
    ParamByName('Transaccion').AsString   := sTransaccion;
    ParamByName('Item_Omd'   ).AsFloat    := fItem_Omd;
    ParamByName('Empresa'    ).AsString   := sEmpresa;
    ParamByName('Fecha'      ).AsDate := dFecha;

    Open;
    if FieldByName('Tasacion_1').IsNull then
    begin
       Result            := 0;
       dFecha_Retasacion := 0;
       sMoneda_Tasacion  := '';
    end
    else
    begin
       Result            := FieldByName('Tasacion_1').AsFloat;
       dFecha_Retasacion := Fieldbyname('Fecha_Desde').asDatetime;
       sMoneda_Tasacion  := Fieldbyname('Moneda_Tas').asString;
    end;
    Close;
  end;
end;

//------------------------------------------------------------------------------
function Tasacion_Omd_Braiz_Cleas(sEmpresa                 : String;
                                  sTransaccion             : String;
                                  sFolio                   : String;
                                  fItem_Omd                : Double;
                                  dFecha                   : TDateTime;
                                  var dFecha_Retasacion    : TDatetime;
                                  var sMoneda_Tasacion     : String ) : Double;
begin
  with dmComunInversiones.QRY_TasBraiz_Cleas do
  begin
    {
    SQL.Clear;
    SELECT b.Tasacion_1
          ,b.Fecha_Desde
          ,a.Moneda_Braiz as Moneda_Tas
      FROM QS_SUP_BRAIZ a
          ,QS_SUP_BRAIZ_TAS b
     WHERE a.Folio_Interno = '60797'
       AND a.Transaccion   = 'C'
       AND a.Item_Omd      = 1
       AND a.Empresa       = 'OHIO'
       AND b.Rol           = a.Rol
       AND b.Fecha_Desde_Master = a.Fecha_Desde
    --   AND b.Fecha_Desde = '31-07-2024'
       AND b.Fecha_Desde   =  (SELECT MAX(c.Fecha_Desde)
                                 FROM QS_SUP_BRAIZ_TAS c
                                WHERE c.Rol = a.Rol
                                  AND c.Fecha_Desde_Master   = b.Fecha_Desde_Master
                                  AND c.Fecha_Desde      = b.Fecha_Desde
                                  AND b.Fecha_Desde   <= '31-07-2024'
                                  AND (b.Fecha_Hasta  IS NULL
                                    OR b.Fecha_Hasta >= '31-07-2024' ))
    }
    ParamByName('Folio'      ).AsString   := sFolio;
    ParamByName('Transaccion').AsString   := sTransaccion;
    ParamByName('Item_Omd'   ).AsFloat    := fItem_Omd;
    ParamByName('Empresa'    ).AsString   := sEmpresa;
    ParamByName('Fecha'      ).AsDate := dFecha;

    Open;
    if FieldByName('Tasacion_1').IsNull then
    begin
       Result            := 0;
       dFecha_Retasacion := 0;
       sMoneda_Tasacion  := '';
    end
    else
    begin
       Result            := FieldByName('Tasacion_1').AsFloat;
       dFecha_Retasacion := Fieldbyname('Fecha_Desde').asDatetime;
       sMoneda_Tasacion  := Fieldbyname('Moneda_Tas').asString;
    end;
    Close;
  end;
end;

//------------------------------------------------------------------------------
Procedure Busca_Tasa_TirMra(sCodigo_BR   : String;
                           dFecha_operacion : TDatetime;
                           var fTasa_TirMra : Double;
                           var Result       : Boolean
                           );
var fDias,
    anos_enteros,
    anos_fraccion,
    meses_enteros,
    fValor : Double;
    aa,
    mm,
    dd : word;
    dFecha_Tasa : TDateTime;
    aMeses  : Array[1..12] of String;
    bExiste,
    Resultado  : Boolean;
    dFecha_Emision,
    dFecha_Vencimiento : TDatetime;
    sTipoBono : String;
    sModulo_Error   : String;
    sString_Error   : String;

begin
  fTasa_TirMra := 0;
  Result       :=  False;

  aMeses[1]  := 'ENERO';
  aMeses[2]  := 'FEBRERO';
  aMeses[3]  := 'MARZO';
  aMeses[4]  := 'ABRIL';
  aMeses[5]  := 'MAYO';
  aMeses[6]  := 'JUNIO';
  aMeses[7]  := 'JULIO';
  aMeses[8]  := 'AGOSTO';
  aMeses[9]  := 'SEPTIEMBRE';
  aMeses[10] := 'OCTUBRE';
  aMeses[11] := 'NOVIEMBRE';
  aMeses[12] := 'DICIEMBRE';

  Decodifica_Nemotecnico_Br(sCodigo_BR,
                           sTipoBono,
                           dFecha_Emision,
                           dFecha_Vencimiento,
                           sModulo_Error,
                           sString_Error,
                           Resultado);

  calculo_de_dias( dFecha_Operacion,
                   dfecha_Vencimiento,
                   'EXACTOS',
                   'CL',
                   fDias,
                   anos_enteros,
                   anos_fraccion,
                   meses_enteros);

  Decodedate(dFecha_Operacion, aa, mm, dd);

  if dFecha_Operacion >= EncodeDate(1998,01,01) then
  begin
    if mm = 1 then
    begin
       mm := 12;
       Dec(aa);
    end
    else
       Dec(mm);

    fValor := fDias;
  end
  else
    fValor := anos_fraccion;

  //Busco TIRMRA a ultimo dia del mes
  try
    dFecha_Tasa := Encodedate(aa, mm, ultimo_dia_mes( mm, aa));
  except
  end;

  with dmComunInversiones.QRY_General do
  begin
     Sql.Clear;
     Sql.Add('SELECT * FROM QS_FIN_VALOR_TRAMO'
           +' WHERE Codigo = :Codigo_Tasa'
           +' AND   Fecha  = :Fecha'
            );
    Parambyname('Codigo_Tasa').asString := 'TIRMRA';
    Parambyname('Fecha').AsDate     := dFecha_Tasa;
    Open;

    if Fieldbyname('Valor').isnull then
       Exit;

    bExiste := False;
    First;
    while (not eof) and (not bExiste) do
    begin
       if ((fValor >= Fieldbyname('Dias_desde').asFloat) and
           (fValor <= Fieldbyname('Dias_hasta').asFloat)) then
       begin
          fTasa_TirMra := FieldByname('Valor').asFloat;
          Result       := True;
       end;
       Next;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure Busca_Rango_Tasa_Mercado( Codigo_Instrumento  : String;
                                    sNemotecnico        : String;
                                    dFecha_Calculo      : TDatetime;
                                   var fLimite_Inferior : Double;
                                   var fLimite_Superior : Double
                                  );
begin
  with dmComunInversiones.Qry_General do
  begin
      //Verifica si existe definición de Instrumento y nemotecnico
      SQL.Clear;
      SQL.Add('SELECT Valor_Inicial, Valor_Final'
             +' FROM QS_FIN_RANGO_TASA'
             +' WHERE Instrumento = :Instrumento'
             +'   AND Nemotecnico = :Nemotecnico'
             +'   AND Fecha_Desde  <= :Fecha'
             +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
             );
      ParamByName('Instrumento').AsString   := Codigo_Instrumento;
      ParamByName('Nemotecnico').AsString   := sNemotecnico;
      ParamByName('Fecha').AsDate       := dFecha_Calculo;
      Open;

      if not FieldByName('Valor_Inicial').isNull then
      begin
         fLimite_Inferior := Fieldbyname('Valor_Inicial').asfloat;
         fLimite_Superior := Fieldbyname('Valor_Final').asfloat;
      end
      else
      begin
         Close;
         SQL.Clear;
         SQL.Add('SELECT Valor_Inicial, Valor_Final'
                +' FROM QS_FIN_RANGO_TASA'
                +' WHERE Nemotecnico = :Nemotecnico'
                +'   AND (Instrumento IS NULL OR Instrumento = '' '')'
                +'   AND Fecha_Desde  <= :Fecha'
                +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                );
         ParamByName('Nemotecnico').AsString   := sNemotecnico;
         ParamByName('Fecha').AsDate       := dFecha_Calculo;
         Open;
         if not FieldByName('Valor_Inicial').isNull then
         begin
            fLimite_Inferior := Fieldbyname('Valor_Inicial').asfloat;
            fLimite_Superior := Fieldbyname('Valor_Final').asfloat;
         end
         else
         begin
             Close;
             SQL.Clear;
             SQL.Add(' SELECT Valor_Inicial, Valor_Final'
                    +' FROM QS_FIN_RANGO_TASA'
                    +' WHERE Instrumento = :Instrumento'
                    +'   AND (Nemotecnico IS NULL OR Nemotecnico = '' '')'
                    +'   AND Fecha_Desde  <= :Fecha'
                    +'   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
                    );
             ParamByName('Instrumento').AsString   := Codigo_Instrumento;
             ParamByName('Fecha').AsDate       := dFecha_Calculo;
             Open;
             if not FieldByName('Valor_Inicial').isNull then
             begin
                fLimite_Inferior := Fieldbyname('Valor_Inicial').asfloat;
                fLimite_Superior := Fieldbyname('Valor_Final').asfloat;
             end
         end;
      end;
  end;
end;
//------------------------------------------------------------------------------
procedure Elemento_Fecha(sReferencia     : String;
                         fAntes_Despues  : Double;
                         Reg_Fechas      : TRegistro_Fechas;
                         var wElemento   : Word;
                         var sModulo_Err : String;
                         var sString_Err : String;
                         var Result      : Boolean);
var
  dd,mm,yy : Word;
begin
  sModulo_Err := 'Elemento Fecha';
  if sReferencia = 'DIA_COMPRA' then
     begin
       Try
         DecodeDate(Reg_Fechas.Fecha_Compra,yy,mm,wElemento)
       except
         sString_Err := 'Error en fecha de compra';
         Result := False;
         exit;
       end;
       wElemento := wElemento + Round(fAntes_Despues);
       if wElemento < 1 then
          wElemento := 1;
     end;

  if sReferencia = 'MES_COMPRA' then
     begin
       Try
         DecodeDate(Reg_Fechas.Fecha_Compra,yy,wElemento,dd)
       except
         sString_Err := 'Error en fecha de compra';
         Result := False;
         exit;
       end;
       wElemento := wElemento + Round(fAntes_Despues);
       if wElemento < 1 then
          wElemento := 1;
     end;

  if sReferencia = 'ANO_COMPRA' then
     begin
       Try
         DecodeDate(Reg_Fechas.Fecha_Compra,wElemento,mm,dd)
       except
         sString_Err := 'Error en fecha de compra';
         Result := False;
         exit;
       end;
       wElemento := wElemento + Round(fAntes_Despues);
     end;
  Result := True;
end;
//------------------------------------------------------------------------------
procedure Cambia_Nemotecnico(var Array_Mem_Desarr         : TArray_Mem_Desarr;
                             dFecha                   : TDateTime;
                             dFecha_Emision           : TDateTime;
                             bConCupon                : Boolean;
                             var RegDes                   : TReg_Descriptor;
                             var sNemotecnico         : String;
                             var sModulo_Err          : String;
                             var sString_Err          : String;
                             var Result               : Boolean);
var
  iCuponVigente : Integer;
  dd,mm,yy      : Word;
  sAno          : String;
  i             : Integer;
begin
  Result := True;
  if ( Copy(sNemotecnico,7,2) <> '**' ) and
     ( Copy(sNemotecnico,7,2) <> ' *' ) and
     ( Copy(sNemotecnico,7,2) <> ' &' ) then
     Exit;

{ Se reemplazo la llamada al Cupon Vigente, ya que tras el cambio
en el cual se considera vigente el siguiente cupon a pagar y no el cortado
nos impedia determinar se habia cambiado el nemotecnico, correctamente

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha
               ,bConCupon
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;
}

  // inicio Determinación del cupon vigente
  //iCuponVigente := 1;
//  While (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto < dFecha) do

  // FI & DC 01/08/2022
   if Array_Mem_Desarr[Max_Nro_Cupones].Fecha_Vcto < dFecha  then
   begin
      sModulo_Err := 'Cupon vigente en Tabla de Desarrollo';
      sString_Err := 'No se encontro cupon vigente con fecha:'
                   +datetostr(dFecha)+#10
                   +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                   +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                   +'     Serie       : '+RegDes.Serie+'.';
      Result := False;
      exit;
   end;
  // FI & DC 01/08/2022


  for i := 1 to Max_Nro_Cupones do
  begin
    if Array_Mem_Desarr[i].Fecha_Vcto >= dFecha  then
       Break;

//    if i > Max_Nro_Cupones then
//    begin
//       sModulo_Err := 'Cupon vigente en Tabla de Desarrollo';
//       sString_Err := 'Se detecto problema con maximo de cupones.'#10
//                    +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
//                    +'Se aborta proceso. Contactese con el Administrador';
//       Result := False;
//       exit;
//    end;
//
//    if Array_Mem_Desarr[i].Nro_Cupon = 0 then
//       begin
//          sModulo_Err := 'Cupon vigente en Tabla de Desarrollo';
//          sString_Err := 'No se encontro cupon vigente con fecha:'
//                       +datetostr(dFecha)+#10
//                       +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
//                       +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
//                       +'     Serie       : '+RegDes.Serie+'.';
//          Result := False;
//         exit;
//       end;
  end;
  iCuponVigente := i;

  if NOT bConCupon then
  begin
     if iCuponVigente < RegDes.Nro_Cupones then
        if Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = dFecha then
           iCuponVigente := iCuponVigente + 1
  end
  else
  begin
     // Si el cupon Viene Marcado Cortado !!!!!NO SE CONSIDERA!!!!!!
     if iCuponVigente < RegDes.Nro_Cupones then
        if (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = dFecha) and
           (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado)  then
           iCuponVigente := iCuponVigente + 1
  end;
  // fin Determinación del cupon vigente

  // Si siguientes dos cupones estan cortados deja el Nemotecnico igual
  if (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado) and
     (Array_Mem_Desarr[iCuponVigente + 1].Cupon_Cortado) then
     exit;

  // Si el cupon vigente esta cortado pero el siguiente no
  // Debe cambiar de ** a * o de && a & segun corresponda
  // O sea un blanco en la posición 7
  if (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado) then
     if (pos('&',sNemotecnico) = 7) or
        (pos('*',sNemotecnico) = 7) then   // Edosan , antes tenia el valor 0, (pos('*',sNemotecnico) = 0) then
     begin
        sNemotecnico[7] := ' ';
        exit;
     end;

  if NOT (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado) then
     begin
       if (sNemotecnico[8] = '&') then
          begin
            // Mes de emisión en caracteres 7 y 8
            sNemotecnico[7] := sNemotecnico[9];
            sNemotecnico[8] := sNemotecnico[10];
            // Año de emisión en caracteres 9 y 10
            try
              DecodeDate(dFecha_Emision,yy,mm,dd);
            Except
              sString_Err := 'Error en fecha de emisión al convertir Nemotecnico';
              Result      := False;
              exit;
            end;
            // Llevo a caracteres el año de emisión
            sAno := IntToStr(yy);
            // Asigno en caracteres 7 y 8 ultimas dos cifras del año de emisión
            sNemotecnico[9] := sAno[Length(sAno) -1];
            sNemotecnico[10] := sAno[Length(sAno)];
          end;
       // Para los asteriscos siempre es Enero
       if (sNemotecnico[8] = '*') then
          begin
           sNemotecnico[7] := '0';
           sNemotecnico[8] := '1';
          end;
     end;
end;
//------------------------------------------------------------------------------
procedure Obtiene_Fecha_Emision_Implicita(sNemotecnico                 : String;
                                          Reg_Fechas                   : TRegistro_Fechas;
                                          var dFecha_Emision_Implicita : TDateTime;
                                          var sModulo_Err              : String;
                                          var sString_Err              : String;
                                          var Result                   : Boolean);
var
  wDia_Emision
 ,wMes_Emision
 ,wAno_Emision : Word;
  wDia_Compra
 ,wMes_Compra
 ,wAno_Compra : Word;

begin
   Result := True;
   with dmComunInversiones.QRY_General do
     begin
       SQL.Clear;
       SQL.Add('SELECT *');
       SQL.Add('  FROM QS_FIN_NEM_EMI_DEF');
       SQL.Add(' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico');

       ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;

       Open;
       if NOT FieldByName('Dia').IsNull then
          wDia_Emision := FieldByName('Dia').AsInteger
       else
          begin
            Elemento_Fecha(FieldByName('Dia_Refer').AsString
                          ,FieldByName('Dia_Ant_Des').AsInteger
                          ,Reg_Fechas
                          ,wDia_Emision
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

            if NOT Result then
               exit;
          end;

       if NOT FieldByName('Mes').IsNull then
          wMes_Emision := FieldByName('Mes').AsInteger
       else
          begin
            Elemento_Fecha(FieldByName('Mes_Refer').AsString
                          ,FieldByName('Mes_Ant_Des').AsInteger
                          ,Reg_Fechas
                          ,wMes_Emision
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

            if NOT Result then
               exit;
          end;

       if NOT FieldByName('Ano').IsNull then
          wAno_Emision := FieldByName('Ano').AsInteger
       else
          begin
            Elemento_Fecha(FieldByName('Ano_Refer').AsString
                          ,FieldByName('Ano_Ant_Des').AsInteger
                          ,Reg_Fechas
                          ,wAno_Emision
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

            if NOT Result then
               exit;
          end;

       if FieldByName('Ano_Refer').AsString = 'ANO_COMPRA' then
          begin
            Try
              DecodeDate(Reg_Fechas.Fecha_Compra
                        ,wAno_Compra
                        ,wMes_Compra
                        ,wDia_Compra)
            Except
              sString_Err := 'Fecha de Compra no valida, para en emisión implicita';
              Result := False;
              exit;
            end;
            if wMes_Emision > wMes_Compra then
               wAno_Emision := wAno_Emision - 1;
          end;
       Close;
     end;
     Try
       dFecha_Emision_Implicita := EncodeDate(wAno_Emision,wMes_Emision,wDia_Emision)
     Except
       sString_Err := 'Error en obtención fecha emisión implicita';
       Result := False;
       exit;
     end;
     Result := True;
end;

//------------------------------------------------------------------------------
Procedure Emision_Implicita( sNemotecnico,
                             sEmisor,
                             sInstrumento,
                             sSerie : String;
                             Registro_Fechas    : TRegistro_Fechas;
                             sDescriptor_Cargado: String;
                             Var dFecha_Emision : TDatetime;
                             Var dFecha_Vencimiento : TDatetime;
                             Var RegDes         : TReg_Descriptor;
                             Var sModulo_Error  : String;
                             Var sString_Error  : String;
                             Var Result         : Boolean
                            );
Var fPeriodo_Pago : Double;
begin
    if sValorizacion_Proceso = 'SI' then
       Obtiene_Fecha_Emision_Implicita_Mem(sNemotecnico
                                       ,Registro_Fechas
                                       ,dFecha_Emision
                                       ,sModulo_Error
                                       ,sString_Error
                                       ,Result)
    else
       Obtiene_Fecha_Emision_Implicita(sNemotecnico
                                       ,Registro_Fechas
                                       ,dFecha_Emision
                                       ,sModulo_Error
                                       ,sString_Error
                                       ,Result);

    if Not Result then
       Exit;

    if sValorizacion_Proceso = 'SI' then
    begin
       if sDescriptor_Cargado <> 'SI' then
          Carga_Descriptor_Mem(sEmisor
                              ,sInstrumento
                              ,sSerie
                              ,RegDes
                              ,sModulo_Error
                              ,sString_Error
                              ,Result)
    end
    else
    begin
       if sDescriptor_Cargado <> 'SI' then
          Carga_Descriptor( sEmisor
                          ,sInstrumento
                          ,sSerie
                          ,RegDes
                          ,sModulo_Error
                          ,sString_Error
                          ,Result);
    end;
    if NOT Result then
       Exit;

    // Sumo a partir de la fecha de emision TODOS los periodos
    // para llegara a la fecha de vencimiento de los titulos con
    // fecha de emision implicita
    fPeriodo_Pago := RegDes.PERIODO_PAGO * RegDes.NRO_CUPONES;

    if NOT siguiente_periodo(sNemotecnico
                            ,RegDes.TIPO_VENCIMIENTO
                            ,ROUND(RegDes.NRO_CUPONES)
                            ,ROUND(RegDes.DIA_VENCIMIENTO)
                            ,ROUND(fPeriodo_Pago)
                            ,RegDes.TASA_FLOTANTE
                            ,dFecha_Emision) then
    begin
      sModulo_Error := 'Fecha de Emisión Implicita';
      sString_Error := 'Error en determinación de fecha vencimiento';
      Result        := False;
      Exit;
    end;
    dFecha_Vencimiento := dFecha_Siguiente_Periodo;
end;
//-----------------------------------------------------------------------------
Procedure Emision_Implicita_Vig( sNemotecnico,
                             sEmisor,
                             sInstrumento,
                             sSerie             : String;
                             dFecha_Vig         : TDatetime;
                             Registro_Fechas    : TRegistro_Fechas;
                             sDescriptor_Cargado: String;
                             Var dFecha_Emision : TDatetime;
                             Var dFecha_Vencimiento : TDatetime;
                             Var RegDes         : TReg_Descriptor;
                             Var sModulo_Error  : String;
                             Var sString_Error  : String;
                             Var Result         : Boolean
                            );
Var fPeriodo_Pago : Double;
begin
    if sValorizacion_Proceso = 'SI' then
       Obtiene_Fecha_Emision_Implicita_Mem(sNemotecnico
                                       ,Registro_Fechas
                                       ,dFecha_Emision
                                       ,sModulo_Error
                                       ,sString_Error
                                       ,Result)
    else
       Obtiene_Fecha_Emision_Implicita(sNemotecnico
                                       ,Registro_Fechas
                                       ,dFecha_Emision
                                       ,sModulo_Error
                                       ,sString_Error
                                       ,Result);

    if Not Result then
       Exit;

    if sValorizacion_Proceso = 'SI' then
    begin
       if sDescriptor_Cargado <> 'SI' then
          Carga_Descriptor_Vig_Mem(sEmisor
                                  ,sInstrumento
                                  ,sSerie
                                  ,dFecha_Vig
                                  ,RegDes
                                  ,sModulo_Error
                                  ,sString_Error
                                  ,Result)
    end
    else
    begin
       if sDescriptor_Cargado <> 'SI' then
          Carga_Descriptor_Vig( sEmisor
                               ,sInstrumento
                               ,sSerie
                               ,dFecha_Vig
                               ,RegDes
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    end;

    if NOT Result then
       Exit;

    // Sumo a partir de la fecha de emision TODOS los periodos
    // para llegara a la fecha de vencimiento de los titulos con
    // fecha de emision implicita
    fPeriodo_Pago := RegDes.PERIODO_PAGO * RegDes.NRO_CUPONES;

    if NOT siguiente_periodo(sNemotecnico
                            ,RegDes.TIPO_VENCIMIENTO
                            ,ROUND(RegDes.NRO_CUPONES)
                            ,ROUND(RegDes.DIA_VENCIMIENTO)
                            ,ROUND(fPeriodo_Pago)
                            ,RegDes.TASA_FLOTANTE
                            ,dFecha_Emision) then
    begin
      sModulo_Error := 'Fecha de Emisión Implicita';
      sString_Error := 'Error en determinación de fecha vencimiento';
      Result        := False;
      Exit;
    end;
    dFecha_Vencimiento := dFecha_Siguiente_Periodo;
end;

//-----------------------------------------------------------------------------
Procedure Valida_Descriptor_Flujos_Cargados( Var Reg_Val_In  : TRegistro_Valoriza_In;
                                             Var Reg_Val_Out : TRegistro_Valoriza_Out;
                                             sNemotecnico,
                                             sEmisor,
                                             sInstrumento,
                                             sSerie,
                                             sTipo_Instrum,
                                             sTransaccion  : String
                                          );
Var fNum_Cupones_Cortados : Double;
    bFecha_Vigencia       : Boolean;
begin
     bFecha_Vigencia := Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG');

     Reg_Val_In.Tabla_Desarr_Cargada  := 'NO';
     if (sNemotecnico = Reg_Val_Out.Nemotecnico) and
        (sTipo_Instrum <> 'U' ) then
         Reg_Val_In.Tabla_Desarr_Cargada  := 'SI';

     //Analizo cupones cortados ya que se debe volver a cargar la tabla de desarrollo
     //Analizo con nemotecnico Actual
     fNum_Cupones_Cortados := 0;
     if sTipo_Instrum = 'S' then
        if sImplica_NOMEM = 'S' then
        begin
           if bFecha_Vigencia then
              fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico_Vig(sNemotecnico,Reg_Val_In.dFechaCalculo)
           else
              fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico(sNemotecnico)
        end
        else
        begin
           if bFecha_Vigencia then
              fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico_Vig(sNemotecnico,Reg_Val_In.dFechaCalculo)
           else
              fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico_Mem(sNemotecnico);
        end;

     //Analizo Nemotecnico Original
     if (fNum_Cupones_Cortados = 0) and (Reg_Val_In.Nemotecnico_Original <> '') then    // if fNum_Cupones_Cortados = 0 then  E.S. & G.G. 25-11-2014
        if sImplica_NOMEM = 'S' then
           fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico(Reg_Val_In.Nemotecnico_Original)
        else
           fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico_Mem(Reg_Val_In.Nemotecnico_Original);

     //Estas variables permiten no cargar la tabla desarrollo de nuevo
     //pero si sus fecha de vencimiento
     Reg_Val_Out.RegDes.Codigo_Emisor_Old      := '';
     Reg_Val_Out.RegDes.Codigo_Instrumento_Old := '';
     Reg_Val_Out.RegDes.Serie_Old              := '';
     if (sEmisor         = Reg_Val_In.sEmisor)      and
        (sInstrumento    = Reg_Val_In.sInstrumento) and
        (sSerie          = Reg_Val_In.sSerie)       and
        (sTipo_Instrum   = 'S'              )       and
        (Reg_Val_Out.RegDes.Tasa_Flotante       = 'N')  and
        (fNum_Cupones_Cortados                  = 0)    and
        (Reg_Val_In.Tabla_Desarr_Cargada        = 'SI') then//Debe existir flujos Cargado
     begin
         Reg_Val_Out.RegDes.Codigo_Emisor_Old      := Reg_Val_Out.RegDes.Codigo_Emisor;
         Reg_Val_Out.RegDes.Codigo_Instrumento_Old := Reg_Val_Out.RegDes.Codigo_Instrumento;
         Reg_Val_Out.RegDes.Serie_Old              := Reg_Val_Out.RegDes.Serie
     end
     else
         Reg_Val_In.Tabla_Desarr_Cargada  := 'NO';

     Reg_Val_In.Descriptor_Cargado := 'NO';
     {//ggarcia 18-01-2019 se comenta ya que por ej en las LH la misma emision tienen flujos distintos.
     if (sEmisor        = Reg_Val_Out.RegDes.Codigo_Emisor)      and
        (sInstrumento   = Reg_Val_Out.RegDes.Codigo_Instrumento) and
        (sSerie         = Reg_Val_Out.RegDes.Serie) and
        (Not Transaccion_Implica_Mem(sTransaccion,'PACTO')) then
         Reg_Val_In.Descriptor_Cargado := 'SI';
     }
end;

function Existe_Emision_Implicita(sNemotecnico : String) : String;
begin
  Existe_Emision_Implicita := 'N';
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT EMISION_IMPLICITA');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA');
    SQL.Add(' WHERE Codigo_Nemotecnico = :Nemotecnico');
    ParamByName('Nemotecnico').AsString := sNemotecnico;

    Open;
    if Not FieldByName('EMISION_IMPLICITA').IsNull then
       Existe_Emision_Implicita := FieldByName('EMISION_IMPLICITA').asString;
       
    Close
  end;
end;

Procedure Busca_Descripcion_Clasificacion( sCodigo_Objeto   : String;
                                           fNodo            : Double;
                                           var sDescripcion : String
                                           );
begin
  sDescripcion := '';
   With DataModule_Comun.Qry_general do
   begin
      Close;
      Sql.Clear;
      Sql.Add( 'SELECT DESCRIPCION_NODO FROM  qs_sys_est_cla'
              +'  WHERE Nodo          = :Nodo'
              +'  AND   Codigo_Objeto = :Codigo_Objeto'
              );
      Parambyname('Nodo').asFloat           := fNodo;
      Parambyname('Codigo_Objeto').asString := sCodigo_Objeto;
      Open;

      if Not Fieldbyname('Descripcion_nodo').IsNull then
         sDescripcion := Fieldbyname('Descripcion_nodo').asString;

      Close;
   end;
end;

Procedure Busca_QS_NODO_Clasificacion( sCodigo_Objeto   : String;
                                       fNodo            : Double;
                                       var fQS_Nodo     : Double
                                       );
begin
   fQS_Nodo := 0;
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT QS_NODO FROM  qs_sys_est_cla'
              +'  WHERE Nodo          = :Nodo'
              +'  AND   Codigo_Objeto = :Codigo_Objeto'
              );
      Parambyname('Nodo').asFloat           := fNodo;
      Parambyname('Codigo_Objeto').asString := sCodigo_Objeto;
      Open;

      if Not Fieldbyname('QS_NODO').IsNull then
         fQS_Nodo := Fieldbyname('QS_Nodo').asFloat;

      Close;
   end;
end;

Function Busca_NODO_Clasificacion(sCodigo_Objeto : String;
                                  sValor_Buscado : String) :Double;
begin
   Result := 0;
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add('SELECT NODO '
             +'  FROM  qs_sys_est_cla '
             +' WHERE Codigo_Objeto = :Codigo_Objeto ');
      if sDriver = 'ORACLE' then
         sql.Add(' AND SUBSTR(descripcion_nodo,1,30)    = :Descripcion ')
      else
         sql.Add(' AND SUBSTRING(descripcion_nodo,1,30) = :Descripcion ');

      Parambyname('Codigo_Objeto').asString := sCodigo_Objeto;
      Parambyname('Descripcion').AsString := copy(sValor_Buscado,1,30);

      Open;

      if Not Fieldbyname('NODO').IsNull then
         Result := Fieldbyname('Nodo').asFloat;

      Close;
   end;
end;

Procedure Busca_Descripcion_Clasificacion_Padre( sCodigo_Objeto  : String;
                                                fNodo            : Double;
                                                fQS_Nodo         : Double;
                                                var sDescripcion : String
                                                );
begin
  sDescripcion := '';
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT DESCRIPCION_NODO FROM  qs_sys_est_cla'
              +'  WHERE Nodo          = :Nodo'
              +'  AND   QS_Nodo       = :QS_Nodo'
              +'  AND   Codigo_Objeto = :Codigo_Objeto'
              );
      Parambyname('Nodo').asFloat           := fNodo;
      Parambyname('QS_Nodo').asFloat        := fQS_Nodo;
      Parambyname('Codigo_Objeto').asString := sCodigo_Objeto;
      Open;

      if Not Fieldbyname('Descripcion_nodo').IsNull then
         sDescripcion := Fieldbyname('Descripcion_nodo').asString;

      Close;
   end;
end;


Function Nro_Riesgo( sCodigo_Clasif : String ) : Double;
begin
  Nro_Riesgo := 0;
  WITH dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Nro_Riesgo'
           +'  FROM QS_FIN_NRO_RIESGOS'
           +' WHERE Codigo = :Codigo'
           );

    ParamByName('Codigo').AsString := sCodigo_Clasif;
    Open;
    
    if Not FieldByName('Nro_Riesgo').IsNull then
       Nro_Riesgo := FieldByName('Nro_Riesgo').AsFloat;
       
    Close;
  end;
end;

Function Determina_Objeto_Clasificado( sEmpresa,
                                       sObjeto,
                                       sElemento,
                                       sCodigo_Clasif  : String;
                                       fNodo : Double;
                                       bConsidera_Nodo : Boolean) : Boolean;
begin
   Determina_Objeto_Clasificado := True;
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT NODO FROM  QS_SYS_CLASIF_OBJ'
              +' WHERE Objeto   = :Objeto'
              +'   AND Elemento = :Elemento'
              +'   AND Codigo_Clasif = :Codigo_Clasif'
              );
      if bConsidera_Nodo then
      begin
         Sql.Add('  AND   Nodo     = :Nodo' );
         Parambyname('Nodo').asFloat           := fNodo;
      end;
      Parambyname('Objeto').asString        := sObjeto;
      Parambyname('Elemento').asString      := sElemento;
      Parambyname('Codigo_Clasif').asString := sCodigo_Clasif;
      Open;

      if Fieldbyname('Nodo').IsNull then
         Determina_Objeto_Clasificado := False;

      Close;
   end;
end;

Function Determina_Descripcion_nodo( sObjeto,
                                     sElemento,
                                     sCodigo_Clasif : String;
                                     var sDescripcion_Nodo  : String
                                     ) : Boolean;
begin
   Determina_Descripcion_nodo := True;
   With dmComunInversiones.Qry_Clasif_Nodo do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT b.DESCRIPCION_NODO '
              +'  FROM QS_SYS_CLASIF_OBJ a'
              +'      ,QS_SYS_EST_CLA b'
              +' WHERE a.OBJETO        = :Objeto'         // 'CARTERA'
              +'   AND a.CODIGO_CLASIF = :Codigo_Clasif'  // 'CLAFON-132'
              +'   AND a.ELEMENTO      = :Elemento'       // 'VIDA'
              +'   AND b.CODIGO_OBJETO = a.CODIGO_CLASIF '
              +'   AND b.NODO          = a.NODO '
              );
      Parambyname('Objeto').asString        := sObjeto;
      Parambyname('Codigo_Clasif').asString := sCodigo_Clasif;
      Parambyname('Elemento').asString      := sElemento;
      Open;

      if Fieldbyname('DESCRIPCION_NODO').IsNull then
         Determina_Descripcion_nodo := False;

      sDescripcion_Nodo := Fieldbyname('DESCRIPCION_NODO').AsString;

      Close;
   end;
end;

Function Emisores_Relacionado_Cia( sEmpresa
                                  ,sEmisor : String;
                                  dFecha  : TDatetime
                                  ) : Boolean;
begin
    Emisores_Relacionado_Cia := False;
    WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT EMISOR'
            + '  FROM QS_SUP_EMISOR_REL'
            + ' WHERE Empresa =:Empresa'
            + '   AND Emisor  =:Emisor'
            + '   AND Fecha_Desde    <= :Fecha'
            + '   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
            );
      ParamByName('Empresa').AsString := sEmpresa;            
      Parambyname('Emisor').asString  := sEmisor;
      Parambyname('Fecha').AsDate := dFecha;
      Open;

      if Not FieldByName('EMISOR').IsNull then
         Emisores_Relacionado_Cia := True;

      Close;
   end;
end;

Procedure Busca_Equivalencia( sCodigo_Proceso,
                              sCodigo_Objeto,
                              sCodigo_Sistema : String;
                              dFecha  : TDatetime;
                              Var sEquivalencia : String
                             );
begin
    sEquivalencia := '';
    WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Codigo_Equiv'
            + '  FROM QS_SYS_EQUIVALEN a'
            + ' WHERE a.Codigo_Objeto   =:Codigo_Objeto'
            + '   AND a.Codigo_Proceso  =:Codigo_Proceso'
            + '   AND a.Codigo_Sistema  =:Codigo_Sistema'
            + '   AND a.Fecha_Desde    <= :Fecha'
            + '   AND (a.Fecha_Hasta >= :Fecha OR a.Fecha_Hasta IS NULL)'
            + '   AND a.Fecha_desde IN ( SELECT MAX(b.Fecha_desde)'
            + '                            FROM QS_SYS_EQUIVALEN b'
            + '                           WHERE a.Codigo_Objeto  = b.Codigo_Objeto'
            + '                             AND a.Codigo_Proceso = b.Codigo_Proceso'
            + '                             AND a.Codigo_Sistema = b.Codigo_Sistema'
            // ggarcia 25-01-2013 se agregan estas dos condiciones ya que no funcionaba cuando habian dos equivalencias
            //                    la primera con fecha hasta y la segunda sin fecha hasta
            + '                             AND b.Fecha_Desde    <= :Fecha'
            + '                             AND (b.Fecha_Hasta >= :Fecha OR b.Fecha_Hasta IS NULL) )'
            );
      ParamByName('Codigo_Proceso').AsString  := sCodigo_Proceso;
      ParamByName('Codigo_Objeto').AsString   := sCodigo_Objeto;
      Parambyname('Codigo_Sistema').asString  := sCodigo_Sistema;
      Parambyname('Fecha').AsDate         := dFecha;
      Open;

      if Not FieldByName('Codigo_Equiv').IsNull then
         sEquivalencia := FieldByName('Codigo_Equiv').asString;

      Close;
   end;
end;

Function Verifica_Pago_Omd( sEmpresa_Usuario
                           ,sCartera
                           ,sTransaccion
                           ,sFolio_Interno : String;
                            fItem_Omd    
                           ,fNro_Cupon     : Double;
                            dFecha          : Tdatetime
                           ) : Boolean;
begin
    Verifica_Pago_Omd := False;
    WITH dmComunInversiones.QRY_Tesoreria do
    begin
      Parambyname('FOLIO_INTERNO_OMD').asString := sFolio_Interno;
      Parambyname('Item_Omd').asFloat           := fItem_Omd;
      Parambyname('Nro_Cupon').asFloat          := fNro_Cupon;
      Parambyname('TRANSACCION_OMD').asString   := sTransaccion;
      ParamByName('Empresa').AsString           := sEmpresa_Usuario;
      Parambyname('Fecha').AsDate           := dFecha;
      Open;

      if Not FieldByName('EMPRESA').IsNull then
         Verifica_Pago_Omd := True;
      Close;
   end;
end;

Function Activo_En_Margen(  sEmpresa,
                            sCartera : String;
                            dFecha_Proceso : TDatetime;
                            sTransaccion,
                            sFolio_Interno : String;
                            fItem_Omd      : Double
                          ) : Boolean;
begin
    Activo_En_Margen := False;
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT EMPRESA'
             + '  FROM QS_SUP_251_DET'
             + ' WHERE Empresa          =:Empresa'
             + '   AND Cartera          =:Cartera'
             + '   AND TRANSACCION      =:TRANSACCION'
             + '   AND FOLIO_INTERNO    =:FOLIO_INTERNO'
             + '   AND ITEM_OMD         =:Item_Omd'
             + '   AND Fecha_Proceso    =:Fecha_Proceso'            
             );
       ParamByName('Empresa').AsString         := sEmpresa;
       ParamByName('Cartera').AsString         := sCartera;
       Parambyname('TRANSACCION').asString     := sTransaccion;
       Parambyname('FOLIO_INTERNO').asString   := sFolio_Interno;
       Parambyname('Item_Omd').asFloat         := fItem_Omd;
       Parambyname('Fecha_Proceso').AsDate := dFecha_Proceso;
       Open;

       if Not FieldByName('EMPRESA').IsNull then
          Activo_En_Margen := True;
       Close;
   end;
end;

Procedure Busca_Activo_En_Margen(dFecha            :TDateTime; //ggarcia 21-07-2015
                                 sEmpresa          :String;

                                 sTransaccion      :String;
                                 sFolio_Interno    :String;
                                 fItem_Omd         :Double;
                             var sActivo_en_Margen :String);
begin
    sActivo_En_Margen := 'N';
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT b.TIPO_DE_PAGO '
              +'  FROM QS_TRA_OMD_DET_RF a'
              +'      ,QS_TRA_OMD        b'
              +' WHERE a.Empresa_Rel       = :Empresa_Rel'
              +'   AND a.Transaccion_Rel   = :Transaccion_Rel'
              +'   AND a.Folio_Interno_Rel = :Folio_Interno_Rel'
              +'   AND a.Item_Omd_Rel      = :Item_Omd_Rel'
              +'   AND a.Transaccion       = ''MARGEN'''
              +'   AND a.folio_interno not in (SELECT e.folio '
              +'			                           FROM qs_ctr_anulacion e '
              +'			                         	WHERE e.folio       = a.folio_interno '
              +'  			                          AND e.transaccion = a.transaccion '
              +'				                          AND e.empresa     = a.empresa) '
              +'   AND b.Folio_Interno     = a.Folio_Interno'
              +'   AND b.Transaccion       = a.Transaccion'
              +'   AND b.Empresa           = a.Empresa'
              //ggarcia 21-07-2015
              +'   AND b.Fecha_Operacion   <= :Fecha '
              +'   AND b.Fecha_Vcto_Pacto  >= :Fecha '
              +'   AND a.folio_interno NOT IN (SELECT g.FOLIO_INTERNO_REL '
              +'                                 FROM QS_TRA_OMD_PREPAGO_PACTO g '
              +'                                WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno '
              +'                                  AND g.Transaccion_Rel   = a.Transaccion '
              +'                                  AND g.Empresa_Rel       = a.Empresa '
              +'                                  AND g.Fecha_Prepago    <= :Fecha '
              +'                                  AND g.folio_interno NOT IN (SELECT e.folio '
              +'                                                                FROM qs_ctr_anulacion e '
              +'                                                               WHERE e.folio       = g.folio_interno '
              +'                                                                 AND e.transaccion = g.transaccion '
              +'                                                                 AND e.empresa     = g.empresa)) '
              );

       ParamByName('Empresa_Rel').AsString       := sEmpresa;
       Parambyname('Transaccion_Rel').asString   := sTransaccion;
       Parambyname('Folio_Interno_Rel').asString := sFolio_Interno;
       Parambyname('Item_Omd_Rel').asFloat       := fItem_Omd;
       Parambyname('Fecha').AsDate               := dFecha;
       Open;
       if Not FieldByName('TIPO_DE_PAGO').IsNull then
          sActivo_En_Margen := FieldByName('TIPO_DE_PAGO').asString;
       Close;
   end;
end;

procedure Busca_Datos_Clasif_Riesgo(const sCodigo : String;
                                    var Nro_Riesgo    : Double;
                                    var Factor        : Double;
                                    var sTipo_Plazo   : String;
                                    var fValor_Riesgo : Double;
                                    var fNivel        : Double;
                                    var sModulo_Error : String;
                                    var sString_Error : String;
                                    var Result        : Boolean
                                    );
begin
    sModulo_Error := 'Clasificación de Riesgo';
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT *'
              +'  FROM QS_FIN_NRO_RIESGOS'
              +' WHERE Codigo = :Codigo'
              );
       Parambyname('Codigo').asString := sCodigo;
       Open;

       if Not FieldByName('Factor').IsNull then
       begin
          Nro_Riesgo    := FieldByName('NRO_RIESGO').asFloat;
          Factor        := FieldByName('Factor').asFloat;
          sTipo_Plazo   := FieldByName('TIPO_PLAZO').asString;
          fValor_Riesgo := FieldByName('VALOR_RIESGO').asFloat;
          fNivel        := FieldByName('NIVEL_EQUIV').asFloat;
       end
       else
          sString_Error := 'No Existen Valores Nro.Riesgos, para '+sCodigo;

       Close;
   end;
end;


Procedure  Determina_Valor_Pacto( sOwner : String;
                              Var fValorInvertidoUM_Cpa : Double;
                                  sMoneda_Instrum,
                                  sMoneda_Pacto      : String;
                                  dFecha_Operacion   : TDatetime;
                                  sMoneda_Conversion : String;
                              var sModulo_Error   : String;
                              var sString_Error   : String;
                              var Result          : Boolean
                                  );
begin
    Result := True;
    if sOwner = 'OMDORIG.CO' then //Carga Inicial
    begin
       if sMoneda_Pacto = 'USD' then
          Exit
       else
       begin
          conversion_unidad_mon(sMoneda_Pacto,
                                sMoneda_Conversion,
                                'BC',
                                dFecha_Operacion,
                                fValorInvertidoUM_Cpa,
                                fValorInvertidoUM_Cpa,
                                sModulo_Error,
                                sString_Error,
                                Result);
          if Not Result then
             Exit;
       end;
    end
    else
    begin
       // Convierto a Moneda PACTO
       conversion_unidad_mon(sMoneda_Instrum,
                             sMoneda_Pacto,
                             'BC',
                             dFecha_Operacion,
                             fValorInvertidoUM_Cpa,
                             fValorInvertidoUM_Cpa,
                             sModulo_Error,
                             sString_Error,
                             Result);
       if Not Result then
          Exit;
    end;
end;

Procedure Emisor_Pagador( Var sEmisor_Origen  : String;
                          var sEmisor_Pagador : String;
                              dFecha : TDatetime;
                          var Result : Boolean
                         );
var bBuscar : Boolean;
begin
     Result  := False;
     bBuscar := True;
     While bBuscar do
     begin
        WITH dmComunInversiones.Qry_Emisor_Pagador do
        begin
//           SQL.Clear;
//           SQL.Add('SELECT EMISOR_PAGADOR'
//                 + '  FROM QS_FIN_EMISOR_PAGO'
//                 + ' WHERE CODIGO_IDENTIDAD =:CODIGO_IDENTIDAD'
//                 +'  AND Fecha_Desde <= :Fecha'
//                 +'  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)'
//                 );
           Parambyname('CODIGO_IDENTIDAD').asString := sEmisor_Origen;
           Parambyname('Fecha').AsDate          := dFecha;
           Open;

           if Not FieldByName('EMISOR_PAGADOR').IsNull then
           begin
             sEmisor_Pagador := FieldByName('EMISOR_PAGADOR').asString;
             Result  := True;
             Close;
             Emisor_Pagador( sEmisor_Pagador,
                             sEmisor_Pagador,
                             dFecha,
                             bBuscar
                           );
             Result  := bBuscar;
          end
          else
             bBuscar := False;

          Close;
       end;
     end;
end;

procedure Busca_Valor_Super( sPROCESO,
                             sEmpresa,
                             sCARTERA,
                             sPAIS,
                             sEMISOR,
                             sINSTRUMENTO,
                             sMOTIVO        : String;
                             dFECHA_DESDE   : TDatetime;
                           Var sVALORIZACION : String
                             );
var
  sWhere_Proceso : String;
  sWhere_Cartera : String;
  sWhere_Empresa : String;  
  sWhere_Pais    : String;
  bValuacion     : Boolean;
begin
    bValuacion    := True;
    sVALORIZACION := '';
    with dmComunInversiones.Qry_General do
    begin
      sWhere_Empresa := '';
      if sEmpresa <> '' then
         sWhere_Empresa := ' AND Empresa = '''+sEmpresa+'''';
    
      sWhere_Cartera := '';
      if sCartera <> '' then
         sWhere_Cartera := ' AND Cartera = '''+sCartera+'''';

      sWhere_Proceso := '';
      if sProceso <> '' then
         sWhere_Proceso := ' AND Proceso = '''+sProceso+'''';

      sWhere_Pais    := '';

      // Busco Valuacion para Emisor, Instrumento, y Motivo
      SQL.Clear;
      SQL.Add('SELECT Valorizacion');
      SQL.Add('  FROM QS_SUP_VALUAC');
      SQL.Add(' WHERE Instrumento = :Instrumento');
      SQL.Add('   AND Emisor      = :Emisor');
      SQL.Add('   AND Motivo      = :Motivo');
      if sPais <> '' then
         SQL.Add(sWhere_Pais);
      if sEmpresa <> '' then
         SQL.Add(sWhere_Empresa);
      if sCartera <> '' then
         SQL.Add(sWhere_Cartera);
      if sProceso <> '' then 
         SQL.Add(sWhere_Proceso);
      ParamByName('Emisor'     ).AsString := sEmisor;
      ParamByName('Instrumento').AsString := sInstrumento;
      ParamByName('Motivo'     ).AsString := sMotivo;
      Open;

      if FieldByName('Valorizacion').IsNull then
      begin
        Close;
        // Busco Valuacion para Emisor,Instrumento
        SQL.Clear;
        SQL.Add('SELECT Valorizacion');
        SQL.Add('  FROM QS_SUP_VALUAC');
        SQL.Add(' WHERE Instrumento = :Instrumento');
        SQL.Add('   AND Emisor      = :Emisor');
        SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
        if sPais <> '' then
           SQL.Add(sWhere_Pais);
        if sEmpresa <> '' then
           SQL.Add(sWhere_Empresa);
        if sCartera <> '' then
           SQL.Add(sWhere_Cartera);
        if sProceso <> '' then 
           SQL.Add(sWhere_Proceso);
        ParamByName('Emisor'     ).AsString := sEmisor;
        ParamByName('Instrumento').AsString := sInstrumento;
        Open;
        if FieldByName('Valorizacion').IsNull then
        begin
           Close;
           // Busco Valuacion para Emisor
           SQL.Clear;
           SQL.Add('SELECT Valorizacion');
           SQL.Add('  FROM QS_SUP_VALUAC');
           SQL.Add(' WHERE  Emisor      = :Emisor');
           SQL.Add('   AND (Instrumento      IS NULL OR Instrumento = '''')');
           SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
           if sPais <> '' then
              SQL.Add(sWhere_Pais);
           if sEmpresa <> '' then
              SQL.Add(sWhere_Empresa);
           if sCartera <> '' then
              SQL.Add(sWhere_Cartera);
           if sProceso <> '' then
              SQL.Add(sWhere_Proceso);
           ParamByName('Emisor' ).AsString := sEmisor;
           Open;

           if FieldByName('Valorizacion').IsNull then
           begin
                Close;
                // Busco Valuacion para Instrumento
                SQL.Clear;
                SQL.Add('SELECT Valorizacion');
                SQL.Add('  FROM QS_SUP_VALUAC');
                SQL.Add(' WHERE (Emisor IS NULL OR Emisor = '''')');
                SQL.Add('   AND Instrumento = :Instrumento');
                SQL.Add('   AND (Motivo IS NULL OR Motivo = '''')');
                if sPais <> '' then
                   SQL.Add(sWhere_Pais);
                if sEmpresa <> '' then
                   SQL.Add(sWhere_Empresa);
                if sCartera <> '' then
                   SQL.Add(sWhere_Cartera);
                if sProceso <> '' then 
                   SQL.Add(sWhere_Proceso);
                ParamByName('Instrumento').AsString := sInstrumento;
                Open;
                if FieldByName('Valorizacion').IsNull then
                begin
                   Close;
                    // Busco Valuacion para Motivo
                    SQL.Clear;
                    SQL.Add('SELECT Valorizacion');
                    SQL.Add('  FROM QS_SUP_VALUAC');
                    SQL.Add(' WHERE (Instrumento IS NULL OR Instrumento = '''')');
                    SQL.Add('   AND (Emisor      IS NULL OR Emisor = '''')');
                    SQL.Add('   AND Motivo      = :Motivo');
                    if sPais <> '' then
                       SQL.Add(sWhere_Pais);
                    if sEmpresa <> '' then
                       SQL.Add(sWhere_Empresa);
                    if sCartera <> '' then
                       SQL.Add(sWhere_Cartera);
                    if sProceso <> '' then 
                       SQL.Add(sWhere_Proceso);
                    ParamByName('Motivo'     ).AsString := sMotivo;
                    Open;

                    if FieldByName('Valorizacion').IsNull then
                    begin
                       Close;
                       // Busco Valuacion para Emisor y Motivo
                       SQL.Clear;
                       SQL.Add('SELECT Valorizacion');
                       SQL.Add('  FROM QS_SUP_VALUAC');
                       SQL.Add(' WHERE (Instrumento IS NULL OR Instrumento = '''')');
                       SQL.Add('   AND Emisor      = :Emisor');
                       SQL.Add('   AND Motivo      = :Motivo');
                       if sPais <> '' then
                          SQL.Add(sWhere_Pais);
                       if sEmpresa <> '' then
                          SQL.Add(sWhere_Empresa);
                       if sCartera <> '' then
                          SQL.Add(sWhere_Cartera);
                       if sProceso <> '' then
                          SQL.Add(sWhere_Proceso);
                       ParamByName('Emisor'     ).AsString := sEmisor;
                       ParamByName('Motivo'     ).AsString := sMotivo;
                       Open;
                       if FieldByName('Valorizacion').IsNull then
                       begin
                         Close;
                         // Busco Valuacion Instrumento y Motivo
                         Sql.Clear;
                         SQL.Add('SELECT Valorizacion');
                         SQL.Add('  FROM QS_SUP_VALUAC');
                         SQL.Add(' WHERE (Motivo IS NULL OR Motivo = '''')');
                         SQL.Add('   AND Instrumento = :Instrumento');
                         SQL.Add('   AND Motivo      = :Motivo');
                         if sPais <> '' then
                            SQL.Add(sWhere_Pais);
                         if sEmpresa <> '' then
                            SQL.Add(sWhere_Empresa);
                         if sCartera <> '' then
                            SQL.Add(sWhere_Cartera);
                         if sProceso <> '' then
                            SQL.Add(sWhere_Proceso);
                         ParamByName('Instrumento') .AsString := sInstrumento;
                         ParamByName('Motivo'     ).AsString  := sMotivo;
                         Open;

                         if FieldByName('Valorizacion').IsNull then
                         begin
                            Close;
                            // Sólo datos de pais y cartera
                            SQL.Clear;
                            SQL.Add('SELECT Valorizacion');
                            SQL.Add('  FROM QS_SUP_VALUAC');
                            SQL.Add(' WHERE (Instrumento IS NULL OR Instrumento = '''')');
                            SQL.Add('   AND (Emisor      IS NULL OR Emisor = '''')');
                            SQL.Add('   AND (Motivo      IS NULL OR MOTIVO = '''')');
                            if sPais <> '' then
                               SQL.Add(sWhere_Pais);
                            if sEmpresa <> '' then
                               SQL.Add(sWhere_Empresa);
                            if sCartera <> '' then
                               SQL.Add(sWhere_Cartera);
                            if sProceso <> '' then 
                               SQL.Add(sWhere_Proceso);
                            Open;
                            if FieldByName('Valorizacion').IsNull then
                                bValuacion := False;

                         end;
                       end;
                    end;
                end;
           end;
         end;
      end;
      if bValuacion then
         sVALORIZACION := FieldByName('VALORIZACION').AsString;
      Close;
    end; // With Query_General
end;

procedure Busca_Valor_Div_Impagos( sEmpresa,
                                   sCARTERA,
                                   sTransaccion,
                                   sFolio_Interno : String;
                                   fItem_Omd      : Double;
                                   dFECHA         : TDatetime;
                               Var fMonto_Impago_UM : Double;
                               Var fMonto_Impago_MC : Double;
                               Var fProvision_UM    : Double;
                               Var fProvision_MC    : Double;
                               Var fValor_Retasacion   : Double;
                               Var fNro_Cuotas_Impagas : Double;
                               Var dFecha_Retasacion : Tdatetime;
                               Var dFecha_Primer_Dividendo : Tdatetime;
                               //ggarcia 01-04-2015
                               var fSaldo_Insoluto          : Double;
                               var fRelacion_Deuda_Garantia : Double;
                               var fMorosidad_Dias          : Double;
                               var fDeuda_Vigente           : Double;
                               var fPorcentaje_Prepago      : Double
                                   );
begin
    fMonto_Impago_UM        := 0;
    fMonto_Impago_MC        := 0;
    fProvision_UM           := 0;
    fProvision_MC           := 0;
    fValor_Retasacion       := 0;
    fNro_Cuotas_Impagas     := 0;
    fProvision_MC           := 0;
    dFecha_Retasacion       := 0;
    dFecha_Primer_Dividendo := 0;
    with dmComunInversiones.Qry_Div_Impagos do
    begin
       Sql.Clear;
       Sql.Add( ' SELECT DIVIDENDO_IMPAGO_UM'
               +'       ,DIVIDENDO_IMPAGO_MC'
               +'       ,PROVISION_UM'
               +'       ,PROVISION_MC'
               +'       ,VALOR_TASACION_UM'
               +'       ,NRO_DIVIDENDOS_IMP'
               +'       ,FECHA_RETASACION'
               +'       ,FECHA_PRIMER_DIV'
               //ggarcia 01-04-2015
               +'       ,SALDO_INSOLUTO'
               +'       ,RELACION_DEUDA_GARANTIA'
               +'       ,MOROSIDAD_DIAS'
               +'       ,DEUDA_VIGENTE'
               +'       ,PORCENTAJE_PREPAGO'
               +' FROM QS_RES_PROVISION'
               +' WHERE Fecha_Cierre  = :Fecha_Cierre'
               +'   AND Folio_Interno = :Folio_Interno'
               +'   AND Item_Omd      = :Item_Omd'
               +'   AND Transaccion   = :Transaccion'
               +'   AND empresa       = :empresa'
               +'   AND cartera       = :Cartera'
               );
       dmComunInversiones.Qry_Div_Impagos.Parambyname('Fecha_Cierre').asDate     := dFecha;
       dmComunInversiones.Qry_Div_Impagos.Parambyname('Folio_Interno').AsString  := sFolio_Interno;
       dmComunInversiones.Qry_Div_Impagos.Parambyname('Item_Omd').AsFloat        := fItem_Omd;
       dmComunInversiones.Qry_Div_Impagos.Parambyname('Transaccion').AsString    := sTransaccion;
       dmComunInversiones.Qry_Div_Impagos.Parambyname('Empresa').AsString        := sEmpresa;
       dmComunInversiones.Qry_Div_Impagos.Parambyname('Cartera').AsString        := sCartera;
       dmComunInversiones.Qry_Div_Impagos.Open;
       if Not dmComunInversiones.Qry_Div_Impagos.Fieldbyname('DIVIDENDO_IMPAGO_UM').IsNull then
       begin
          fMonto_Impago_UM        := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('DIVIDENDO_IMPAGO_UM').asFloat;
          fMonto_Impago_MC        := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('DIVIDENDO_IMPAGO_MC').asFloat;
          fProvision_UM           := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('PROVISION_UM').asFloat;
          fProvision_MC           := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('PROVISION_MC').asFloat;
          fValor_Retasacion       := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('VALOR_TASACION_UM').asFloat;
          fNro_Cuotas_Impagas     := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('NRO_DIVIDENDOS_IMP').asFloat;
          dFecha_Retasacion       := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('FECHA_RETASACION').asdatetime;
          dFecha_Primer_Dividendo := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('FECHA_PRIMER_DIV').asdatetime;
          //ggarcia 01-04-2015
          fSaldo_Insoluto          := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('SALDO_INSOLUTO').asFloat;
          fRelacion_Deuda_Garantia := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('RELACION_DEUDA_GARANTIA').asFloat;
          fMorosidad_Dias          := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('MOROSIDAD_DIAS').asFloat;
          fDeuda_Vigente           := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('DEUDA_VIGENTE').asFloat;
          fPorcentaje_Prepago      := dmComunInversiones.Qry_Div_Impagos.Fieldbyname('PORCENTAJE_PREPAGO').asFloat;
       end;
       dmComunInversiones.Qry_Div_Impagos.Close;
    end;
end;

procedure  Valores_Identidad ( sIdentidad     : String;
                           VAR fRut           : Double;
                           VAR sDigito        : String;
                           VAR sRazon_social  : String;
                           VAR Result         : Boolean
                             );
Var s : String;
begin
   Result         := True;
   fRut           := 0;
   sDigito        := '';
   sRazon_social  := '';
   with dmComunInversiones.Qry_General do
   begin
     Close;
     Sql.Clear;
     Sql.Add(' Select * from qs_sys_identidad where '
            +' codigo_identidad = :identidad '
            );
     ParambyName('identidad').AsSTring := sIdentidad;
     Open;
     if Eof then
     begin
        Result := False;
        Close;
        Exit;
     end;

     try
        sRazon_social := FieldByName('razon_social_pat').AsString;
        s             := FieldByName('credencial').AsString;
        fRut          := strtofloat(copy(s,1,pos('-',s)- 1));
        sDigito       := copy(s,pos('-',s)+1,1);
     except
        fRut          := 0;
        Result := False;
     end;
     close;
   end;
end;

procedure  Valores_Identidad_2(sIdentidad    : String;
                           VAR sCredencial   : String;
                           VAR sRazon_social : String;
                           VAR Result        : Boolean);
begin
   Result         := True;
   sCredencial    := '';
   sRazon_social  := '';
   with dmComunInversiones.Qry_General do
   begin
     Close;
     Sql.Clear;
     Sql.Add('Select * '
            +'  from qs_sys_identidad '
            +' where codigo_identidad = :identidad ');
     ParambyName('identidad').AsSTring := sIdentidad;
     Open;
     if Eof then
     begin
        Result := False;
        Close;
        Exit;
     end;
     try
        sRazon_social := FieldByName('razon_social_pat').AsString;
        sCredencial   := FieldByName('credencial').AsString;
     except
        Result := False;
     end;
     close;
   end;
end;

Function Determina_Cartera_Pid( sEmpresa_Usuario : String;
                                  fPid             : Double
                                 ) : String;
begin
   Determina_Cartera_Pid := '';
   with dmComunInversiones.Qry_General do
   begin
     Close;
     Sql.Clear;
     sql.add(' SELECT a.Cartera FROM QS_SYS_PARAM_EMPRESA a');
     sql.add('  WHERE  :empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
     sql.add('                      WHERE  pid = :pid ');
     sql.add('                         and z.empresa = a.empresa ');
     sql.add('                     ) ');
     Sql.Add('  AND pid = :pid ');
     ParamByName('pid').AsFloat       := fPid;
     ParamByName('Empresa').AsString  := sEmpresa_Usuario;
     Open;
     if Eof then
     begin
        Close;
        Exit;
     end;
     Determina_Cartera_Pid := Fieldbyname('Cartera').asString;
     close;
   end;
end;

Function Busca_Prohibicion_Emisor_Nemotecnico(const sEmisor      :  String;
                                              const sNemotecnico : String ;
                                              dFecha : TDatetime ) : Boolean;
//var i : Integer;
begin
   Result := False;
   WITH DMComunInversiones.QRY_General do
   begin
     Close;
     //Ubico Emisor y Nemotecnico
     Sql.Clear;
     Sql.Add( ' SELECT Fecha_Desde FROM QS_FIN_PROHIBICION_EMI'
             +' WHERE Fecha_Desde <= :Fecha'
             +'  AND (Fecha_Hasta <= :Fecha or  Fecha_Hasta is Null)'
             +'  AND Emisor      = :Emisor'
             +'  AND Nemotecnico = :Nemotecnico'
             );
     Parambyname('Fecha').AsDate      := dFecha;
     Parambyname('Emisor').asString       := sEmisor;
     Parambyname('Nemotecnico').asString  := sNemotecnico;
     Open;

     If Not Fieldbyname('Fecha_Desde').IsNull then
     begin
        Close;
        Result := True;
     end
     else
     begin
        Close;
        //Ubico Emisor
        Sql.Clear;
        Sql.Add( ' SELECT Fecha_Desde FROM QS_FIN_PROHIBICION_EMI'
                +' WHERE Fecha_Desde <= :Fecha'
                +'  AND (Fecha_Hasta <= :Fecha or  Fecha_Hasta is Null)'
                +'  AND Emisor      = :Emisor'
                );
        Parambyname('Fecha').AsDate      := dFecha;
        Parambyname('Emisor').asString       := sEmisor;
        Open;

        If Not Fieldbyname('Fecha_Desde').IsNull then
        begin
           Close;
           Result := True;
        end
        else
        begin
           Close;
           //Ubico Emisor
           Sql.Clear;
           Sql.Add( ' SELECT Fecha_Desde FROM QS_FIN_PROHIBICION_EMI'
                   +' WHERE Fecha_Desde <= :Fecha'
                   +'  AND (Fecha_Hasta <= :Fecha or  Fecha_Hasta is Null)'
                   +'  AND Nemotecnico   = :Nemotecnico'
                   );
           Parambyname('Fecha').AsDate      := dFecha;
           Parambyname('Nemotecnico').asString  := sNemotecnico;
           Open;
           If Not Fieldbyname('Fecha_Desde').IsNull then
           begin
              Close;
              Result := True;
           end;
           Close;
        end;
     end;
  end;   
end;

Function Busca_Prohibicion_Folios( const sEmpresa    : String;
                                   const sCartera     : String;
                                   const sTransaccion : String;
                                   const sFolio       : String;
                                   fItem_Omd          : Double;
                                   dFecha : TDatetime) : Boolean;
//var i : Integer;
begin
   Result := False;
   WITH DMComunInversiones.QRY_General do
   begin
     Close;
     Sql.Clear;
     Sql.Add( ' SELECT Fecha_Desde FROM QS_TRA_PROHIBICION_OMD'
             +' WHERE Fecha_Desde <= :Fecha'
             +'  AND (Fecha_Hasta <= :Fecha or  Fecha_Hasta is Null)'
             +'  AND Empresa       = :Empresa'
             +'  AND Cartera       = :Cartera'
             +'  AND Transaccion   = :Transaccion'
             +'  AND Folio_Interno = :Folio_Interno'
             +'  AND Item_Omd      = :Item_Omd'
             );
     Parambyname('Fecha').AsDate       := dFecha;
     Parambyname('Empresa').asString       := sEmpresa;
     Parambyname('Cartera').asString       := sCartera;
     Parambyname('Transaccion').asString   := sTransaccion;
     Parambyname('Folio_Interno').asString := sFolio;
     Parambyname('Item_Omd').asFloat       := fItem_Omd;
     Open;

     If Not Fieldbyname('Fecha_Desde').IsNull then
     begin
        Close;
        Result := True;
     end;
  end;
end;

//------------------------------------------------------------------------------
procedure Tipo_Emisor(sEmisor  : String;
                      dFecha   : TDateTime;
                  var sTipo_Emisor : String;
                  var Result       : Boolean
                      );
begin
    Result := False;
    WITH dmComunInversiones.QRY_General do
    begin
       Close;
       SQL.Clear;
       SQL.Add(' SELECT Tipo_Emisor');
       SQL.Add('  FROM QS_FIN_EMISOR_TIPO');
       SQL.Add(' WHERE CODIGO_IDENTIDAD = :CODIGO_IDENTIDAD');
       SQL.Add('  AND Fecha_Desde <= :Fecha');
       SQL.Add('  AND (Fecha_Hasta Is Null OR Fecha_Hasta >= :Fecha)');
       ParamByName('CODIGO_IDENTIDAD').AsString := sEmisor;
       ParamByName('Fecha').AsDate          := dFecha;
       Open;

       if Not FieldByName('Tipo_Emisor').isNull then
       begin
          Result       := True;
          sTipo_Emisor := FieldByName('Tipo_Emisor').asString;
       end;
       Close;
    end;
end;

Function Lee_Emisor_inst(sEmisor      : String;
                         sInstrumento : String;
                         dFecha       : TDateTime): Boolean;
begin
    Result := False;
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add(' SELECT Codigo_Instrumento');
       SQL.Add('  FROM QS_FIN_EMISOR_INST');
       SQL.Add(' WHERE CODIGO_IDENTIDAD  = :CODIGO_IDENTIDAD');
       SQL.Add('  AND Codigo_Instrumento = :Codigo_Instrumento');
       SQL.Add('  AND Fecha_Desde <= :Fecha');
       SQL.Add('  AND (Fecha_Hasta Is Null OR Fecha_Hasta >= :Fecha)');
       ParamByName('CODIGO_IDENTIDAD').AsString   := sEmisor;
       ParamByName('Codigo_Instrumento').AsString := sInstrumento;
       ParamByName('Fecha').AsDate            := dFecha;
       Open;
       if Not FieldByName('Codigo_Instrumento').isNull then
       begin
          Result       := True;
       end;
       Close;
    end;
end;

procedure Tipo_Instrumento_RTPR(   sInstrumento : String;
                               var sCodigo_RTPR : String;
                               var Result       : Boolean
                               );
begin
    Result := False;
    WITH dmComunInversiones.QRY_General do
    begin
       Sql.Clear;
       Sql.Add( ' SELECT CODIGO_RTPR FROM QS_SUP_251_RTPR_DET'
               +' WHERE Instrumento = :Instrumento'
               +' ORDER BY CODIGO_RTPR '   // Edosan
              );
       ParamByname('Instrumento').asString := sInstrumento;
       Open;
       if Not FieldByName('CODIGO_RTPR').isNull then
       begin
          Result       := True;
          sCodigo_RTPR := FieldByName('CODIGO_RTPR').asString;
       end;
       Close;
    end;
end;

// Esta funcion es llamada por cada cupon por lo cual entrega
// los dias base a ser utilizados en cada uno de ellos.
procedure Obtener_Tasa_base_Variable(sCodigoTasaBase  : string;
                                     Registro_Fechas  : TRegistro_Fechas;
                                 var RegDes           : TReg_descriptor;
                                 var Array_Mem_Desarr : TArray_Mem_Desarr;
                                     sPais_Tasa       : String;
                                 var fDiasBaseTasa    : Integer;
                                 var fPeriodos        : Double;
                                 var sModulo_error    : String;
                                 var sString_error    : String;
                                 var Result           : Boolean);
var  fAnosEnteros,
     fAnosFraccion,
     fMesesEnteros,
     fDias       : Double;
     //fTasa_Cupon : Double;
     sCOD_TRATAM_Inicio,
     sCOD_TRATAM_Termino,
     sTASA_DEPENDE_PERIODOS,
     sBASE_SEGUN_ANO,
     sTIPO_CALCULO_DIAS : String;
     iCuponVigente : Integer;
     dFecha_Inicial,
     dFecha_Final : TDatetime;
     fCupones_por_ano         : Double;
     fAno_Cupon               : Double;
     iNumero_Cupon_Final_Ano   : Integer;
     iNumero_Cupon_Inicial_Ano : Integer;

     // fDiasBaseTasa_Originales : Integer;
begin
  // fDiasBaseTasa_Originales := fDiasBaseTasa;
  sModulo_Error :='Obtener Tasa Base Variable';
  Result := True;
  with dmComunInversiones.QRY_General do
  begin
    Leer_Tasa_base_Variable_Mem(sCodigoTasaBase
                               ,dFecha_Inicial
                               ,dFecha_Final
                               ,sTIPO_CALCULO_DIAS
                               ,sCOD_TRATAM_INICIO
                               ,sCOD_TRATAM_TERMINO
                               ,sTASA_DEPENDE_PERIODOS
                               ,sBASE_SEGUN_ANO
                               ,sModulo_error
                               ,sString_error
                               ,Result);

    if NOT Result then
    begin
      sString_Error := 'No Existe Definición de Tasa Base Variable, Para : '+trim(sCodigoTasaBase);
      Result := False;
      exit;
    end;

    if (sTIPO_CALCULO_DIAS = EmptyStr) or (sTIPO_CALCULO_DIAS ='')  then
    begin
      sString_Error := 'No Existe Definición de Tipo Cálculo Días, Para : '+trim(sCodigoTasaBase);
      Result := False;
      exit;
    end;

    if sBASE_SEGUN_ANO <> 'S' then
    begin
       if (sCOD_TRATAM_INICIO = EmptyStr) or (sCOD_TRATAM_INICIO ='')  then
       begin
         sString_Error := 'No Existe Definición de Tratamiento Inicial, Para : '+trim(sCodigoTasaBase);
         Result := False;
         exit;
       end;

       if (sCOD_TRATAM_TERMINO = EmptyStr) or (sCOD_TRATAM_TERMINO ='')  then
       begin
         sString_Error := 'No Existe Definición de Tratamiento Término, Para : '+trim(sCodigoTasaBase);
         Result := False;
         exit;
       end;

       if (sTASA_DEPENDE_PERIODOS = EmptyStr) or (sTASA_DEPENDE_PERIODOS ='')  then
       begin
         sString_Error := 'No Existe Definición de Dependencia de Períodos, Para : '+trim(sCodigoTasaBase);
         Result := False;
         exit;
       end;
    end;
  end;

   //Cupon Vigente
   Cupon_Vigente( Array_Mem_Desarr
                , RegDes
                , Registro_Fechas.Fecha_Calculo
                , False//ConCupon
                , iCuponVigente
                , sModulo_Error
                , sString_Error
                , Result);
    if Not Result then
       Exit;

    fPeriodos := 1;
    if sBASE_SEGUN_ANO <> 'S' then
    begin
       if sTASA_DEPENDE_PERIODOS = 'S' then
          if RegDes.PERIODO_PAGO = 0 then
             fPeriodos := 1
          else
             fPeriodos := 12/RegDes.PERIODO_PAGO;

       // Cargo Fecha de Inicio y Termino del Periodo, osea fecha de Cupones
       Registro_fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto_Anterior;
       Registro_fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;

       Tratamiento_Fecha(sCOD_TRATAM_Inicio
                        ,Registro_Fechas
                        ,dFecha_Inicial
                        ,sModulo_Error
                        ,sString_Error
                        ,Result);
       if NOT Result then
          exit;

       Tratamiento_Fecha(sCOD_TRATAM_Termino
                        ,Registro_Fechas
                        ,dFecha_Final
                        ,sModulo_Error
                        ,sString_Error
                        ,Result);
       if NOT Result then
          exit;
    end
    else
    begin
      // Para el caso BASE_SEGUN_ANO los dias base corresponden a los dias del año
      // en que cae el cupon
      // Los años se refieren a los cupones que cortan en un alo calendario
      // Ejemplo si paga trimestralmente (4 cupones al año)
      // Para los primeros cuatro cupones los días base son los dias
      // entre la fecha de emision y la fecha de vencimiento del cuarto cupon
      // Para los siguientes 4 los dias entre la fecha de vencimiento del cuarto cupon
      // y la fecha de vencimiento del octavo cupon.

      // Si los cupones cortaran mensualmente los primeros 12 caen en el primer año
      // desde la fecha de vencimiento y asi sucecivamente.
      if RegDes.PERIODO_PAGO <= 0 then
      begin
        sModulo_Error := 'Obtener Tasa Base Variable';
        sString_Error := 'Error en definición de periodo de pago en descriptor (<=0)';
        Result        := False;
        exit;
      end;
      fCupones_por_ano := 12 / RegDes.PERIODO_PAGO;
      if (fCupones_por_ano <> Int(fCupones_por_ano)) or (fCupones_por_ano > 12) then
      begin
        sModulo_Error := 'Obtener Tasa Base Variable. Base segun Año';
        sString_Error := 'Periodo de pago en descriptor no es valido. Debe dar cupoones exactos en el año';
        Result        := False;
        exit;
      end;



      if ((iCuponVigente/fCupones_por_ano) <> Int(iCuponVigente/fCupones_por_ano)) then
          fAno_Cupon := Int(iCuponVigente/fCupones_por_ano) +1
      else
          fAno_Cupon := Int(iCuponVigente/fCupones_por_ano);

      //ggaarcia 21/01/2009
      iNumero_Cupon_Final_Ano   := Trunc(fAno_Cupon * fCupones_por_ano);
      iNumero_Cupon_Inicial_Ano := Trunc(iNumero_Cupon_Final_Ano - fCupones_por_ano + 1);
      dFecha_Inicial := Array_Mem_Desarr[iNumero_Cupon_Inicial_Ano].Fecha_Vcto_Anterior;
      dFecha_Final   := Array_Mem_Desarr[iNumero_Cupon_Final_Ano].Fecha_Vcto;
    end;

    //Calculo Días Entre Fechas
    Calculo_de_dias(dFecha_Inicial,
                    dFecha_Final,
                    sTIPO_CALCULO_DIAS,
                    sPais_Tasa,
                    fDias,
                    fAnosEnteros,
                    fAnosFraccion,
                    fMesesEnteros);
    fDiasBaseTasa := Trunc(fDias);

    // Con fecha 22/12/2004 a pedido de Daniel Quezada se inabilita
    // la restriccion que los dias base variables calculados no pueden
    // ser mayores a los dias base definidos en la pantalla principal
    // Originalmete se habia hecho asi para llagar a los valores de Bloomberg
    // if fDiasBaseTasa > fDiasBaseTasa_Originales then
    //    fDiasBaseTasa := fDiasBaseTasa_Originales;


{
    ///// Esto fue Movido directamente a la carga del descriptor !!!

    // Si es tasa flotante, la tasa es la tzsa del flujo
    if RegDes.Tasa_Flotante = 'N' then
       Regdes.TASA_EFECTIVA := Regdes.TASA_EFECTIVA / fPeriodos
    else
       Array_Mem_Desarr[iCuponVigente].Tasa_flujo := Array_Mem_Desarr[iCuponVigente].Tasa_flujo /fPeriodos;
}
end;

Procedure Busca_Cod_Sistema_Equiv( sCodigo_Proceso,
                                   sCodigo_Objeto,
                                   sEquivalencia : String;
                                   dFecha  : TDatetime;
                               Var sCodigo_Sistema : String
                                 );
begin
    sCodigo_Sistema := '';
    WITH dmComunInversiones.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Sistema'
            + '  FROM QS_SYS_EQUIVALEN'
            + ' WHERE Codigo_Objeto   =:Codigo_Objeto'
            + '   AND Codigo_Proceso  =:Codigo_Proceso'
            + '   AND Codigo_Equiv    =:Codigo_Equiv'
            + '   AND Fecha_Desde    <= :Fecha'
            + '   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)'
            );
      ParamByName('Codigo_Proceso').AsString  := sCodigo_Proceso;
      ParamByName('Codigo_Objeto').AsString   := sCodigo_Objeto;
      Parambyname('Codigo_Equiv').asString    := sEquivalencia;
      Parambyname('Fecha').AsDate         := dFecha;
      Open;

      if Not FieldByName('Codigo_Sistema').IsNull then
         sCodigo_Sistema := FieldByName('Codigo_Sistema').asString;

      Close;
   end;
end;

procedure Codigo_Identidad ( sRut              : String;
                         VAR sCodigo_Identidad : String
                           );
begin
   sCodigo_Identidad := '';
   with dmComunInversiones.Qry_General do
   begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT Codigo_Identidad FROM QS_SYS_IDENTIDAD '
            +' WHERE CREDENCIAL = :Rut'
            );
     ParambyName('Rut').AsString := sRut;
     Open;

     if Not Fieldbyname('Codigo_Identidad').IsNull then
        sCodigo_Identidad := Fieldbyname('Codigo_Identidad').asString;

     Close;
   end;
end;

Function Leer_Tasa_Instrumento(sInstrumento : String;
                               dFechaCalculo,
                               dFechaVencimiento : TDatetime;
                               sOrigen : String;
                           var sTipo_TasPre : String
                               ) : Double;
var fDias,
    fanos_enteros,
    fanos_fraccion,
    fValor,
    fmeses_enteros : Double;
    //iValor         : Integer;
    sUnidad        : String;
    dFecha         : TDatetime;
begin
   WITH dmComunInversiones.QRY_General do
   begin
      Close;
      Sql.Clear;

      SQL.Add(' SELECT a.Unidad_Medida                               ');
      SQL.Add('       ,a.Fecha                                       ');
      SQL.Add('   FROM QS_FIN_FECHA_TRAMO a                          ');
      SQL.Add('       ,QS_FIN_VALOR_TRAMO c                          ');
      SQL.Add('  WHERE a.Codigo = :Instrumento                       ');
      SQL.Add('    AND a.Origen = :Origen                            ');
      SQL.Add('    AND a.fecha  In ( SELECT MAX(x.fecha)             ');
      SQL.Add('                        FROM  QS_FIN_FECHA_TRAMO x    ');
      SQL.Add('                       WHERE x.Codigo = a.Codigo      ');
      SQL.Add('                         AND x.Origen = a.Origen      ');
      SQL.Add('                         AND x.Fecha <= :Fecha        ');
      SQL.Add('                     )                                ');
      SQL.Add('     AND c.Codigo = a.Codigo                          ');
      SQL.Add('     AND c.Fecha  = a.Fecha                           ');
      SQL.Add('     AND c.Origen = a.Origen                          ');

      { Optimizado 25-09-2009 E.S. % F.I.
      Sql.Add( 'SELECT a.Unidad_Medida'
              +'      ,a.Fecha'
              +' FROM  QS_FIN_FECHA_TRAMO a'
              +'      ,QS_FIN_INSTRUM b'
              +'      ,QS_FIN_VALOR_TRAMO c'
              +' WHERE a.Codigo = b.Cod_Instrumento'
              +'   AND a.Origen = :Origen'
              +'   AND a.Codigo = c.Codigo'
              +'   AND a.Fecha  = c.Fecha'
              +'   AND a.Origen = c.Origen'
              +'   AND b.Cod_Instrumento = :Instrumento'
              +'   AND a.fecha  In ( SELECT MAX(a.fecha) FROM  QS_FIN_FECHA_TRAMO a'
                                +'  ,QS_FIN_INSTRUM b'
                                +'  WHERE a.Codigo = b.Cod_Instrumento'
                                +'  AND a.Fecha <= :Fecha'
                                +'  )'
             );
      }
      ParamByName('Fecha').AsDate     := dFechaCalculo;
      ParamByName('Instrumento').AsString := sInstrumento;
      ParamByName('Origen').AsString      := sOrigen;
      Open;

      if FieldByname('Unidad_Medida').isNull then
      begin
         Result := 0;
         Close;
         Exit
      end
      else
      begin
         sUnidad := FieldByname('Unidad_Medida').asString;
         dFecha  := FieldByname('Fecha').asDatetime;
      end;

      calculo_de_dias( dFechaCalculo,
                       dFechaVencimiento,
                       'EXACTOS',
                       sPais_Usuario,
                       fDias,
                       fanos_enteros,
                       fanos_fraccion,
                       fmeses_enteros
                      );
      if sUnidad = 'DIA' then // Lobo
         fValor := ROUND(fDias);

      if sUnidad = 'MES' then
         fValor := ROUND(fMeses_Enteros);

      if sUnidad = 'ANO' then
         fValor := fDias/365;// Esto pq años fraccion no Funciona Correctamente

      Close;
      Sql.Clear;


      SQL.Add(' SELECT c.Dias_desde             ');
      SQL.Add('       ,c.Dias_hasta             ');
      SQL.Add('       ,c.Valor                  ');
      SQL.Add('       ,c.Tipo                   ');
      SQL.Add('   FROM QS_FIN_FECHA_TRAMO a     ');
      SQL.Add('       ,QS_FIN_VALOR_TRAMO c     ');
      SQL.Add('  WHERE a.Codigo = :Instrumento  ');
      SQL.Add('    AND a.Origen = :Origen       ');
      SQL.Add('    AND a.fecha  = :Fecha        ');
      SQL.Add('    AND c.Codigo = a.Codigo      ');
      SQL.Add('    AND c.Fecha  = a.Fecha       ');
      SQL.Add('    AND c.Origen = a.Origen      ');

      {
      Sql.Add( 'SELECT c.Dias_desde'
              +'      ,c.Dias_hasta'
              +'      ,c.Valor'
              +' FROM  QS_FIN_FECHA_TRAMO a'
              +'      ,QS_FIN_INSTRUM b'
              +'      ,QS_FIN_VALOR_TRAMO c'
              +' WHERE a.Codigo = b.Cod_Instrumento'
              +'   AND a.Origen = :Origen'
              +'   AND a.Codigo = c.Codigo'
              +'   AND a.Fecha  = c.Fecha'
              +'   AND a.Origen = c.Origen'
              +'   AND b.Cod_Instrumento = :Instrumento'
              +'   AND a.fecha  = :Fecha'
             );
      }
      ParamByName('Fecha').AsDate     := dFecha;
      ParamByName('Instrumento').AsString := sInstrumento;
      ParamByName('Origen').AsString      := sOrigen;
      Open;

      Result := 0;
      While Not Eof do
      begin
         if (fValor >= Fieldbyname('Dias_desde').asFloat) and
            (fValor <= Fieldbyname('Dias_hasta').asFloat) then
         begin
            sTipo_TasPre := FieldByname('Tipo').asString;
            Result := FieldByname('Valor').asFloat;
         end;
         Next;
      end;
      Close;
   end;
end;

function Es_Nemotecnico_Br(sNemotecnico: String): Boolean;
var
  wdia,wmes,wano     : word;
  i                  : Integer;
  dFecha_Vencimiento : TDateTime;
  dFecha_Emision     : TDateTime;
  //aux_pchar          : Array[0..250] of Char;
begin
  Result := True;
  if length(sNemotecnico) <> 10 then
  begin
    Result := False;
    exit;
  end;

  if (copy(sNemotecnico,1,4) <> 'CBR-') and
     (copy(sNemotecnico,1,2) <> 'CB'  ) then
  begin
    Case sNemotecnico[1] of
     'A'..'C','D','E' : // Bono de Reconocimiento
          begin
            wdia := 1;
            Case sNemotecnico[2] of
                     'A','B','R','D','E','C','L','M','N','O','P','Q','S','T','U','X','1','2','3' :
                else
                begin
                   Result := False;
                   exit;
                end;
            end;
            Case sNemotecnico[3] of
            '1'..'9' : wmes := strtoint(sNemotecnico[3]);
            '0'      : wmes := 10;
            'A'      : wmes := 11;
            'B'      : wmes := 12;
            else
              begin
                Result := False;
                exit;
              end;
            end;  {end case mes emisión}
            if NOT EsNumero(sNemotecnico[2]) then
            begin
              Case sNemotecnico[4] of
              '1' : wano := 1981;
              '2' : wano := 1982;
              '3' : wano := 1983;
              '4' : wano := 1984;
              '5' : wano := 1985;
              '6' : wano := 1986;
              '7' : wano := 1987;
              '8' : wano := 1988;
              '9' : wano := 1989;
              '0' : wano := 1990;
              'A' : wano := 1991;
              'B' : wano := 1992;
              'C' : wano := 1993;
              'D' : wano := 1994;
              'E' : wano := 1995;
              'F' : wano := 1996;
              'G' : wano := 1997;
              'H' : wano := 1998;
              'I' : wano := 1999;
              'J' : wano := 2000;
              'K' : wano := 2001;
              'L' : wano := 2002;
              'M' : wano := 2003;
              'N' : wano := 2004;
              'O' : wano := 2005;
              'P' : wano := 2006;
              'Q' : wano := 2007;
              'R' : wano := 2008;
              'S' : wano := 2009;
              'T' : wano := 2010;
              'U' : wano := 2011;
              else
                  begin
                    Result := False;
                    exit;
                  end;
              end; {case año emisión}
            end
            else
            begin
              Case sNemotecnico[4] of
              '1' : wano := 2017;
              '2' : wano := 2018;
              '3' : wano := 2019;
              '4' : wano := 2020;
              '5' : wano := 2021;
              '6' : wano := 2022;
              '7' : wano := 2023;
              '8' : wano := 2024;
              '9' : wano := 2025;
              '0' : wano := 2026;
              'A' : wano := 2027;
              'B' : wano := 2028;
              'C' : wano := 2029;
              'D' : wano := 2030;
              'E' : wano := 2031;
              'F' : wano := 2032;
              'G' : wano := 2033;
              'H' : wano := 2034;
              'I' : wano := 2035;
              'J' : wano := 2036;
              'K' : wano := 2037;
              'L' : wano := 2038;
              'M' : wano := 2039;
              'N' : wano := 2040;
              'O' : wano := 2041;
              'P' : wano := 2042;
              'Q' : wano := 2043;
              'R' : wano := 2044;
              'S' : wano := 2044;
              'T' : wano := 2044;
              'U' : wano := 2044;
              'V' : wano := 2044;
              'W' : wano := 2044;
              'X' : wano := 2050;
              'Y' : wano := 2051;
              'Z' : wano := 2052;
              else
                  begin
                    Result := False;
                    exit;
                  end;
              end; {case año emisión}
            End;

           {fecha emisión}
            try
              dFecha_Emision := encodedate(wano,wmes,wdia)
            except
               begin
                 Result := False;
                 exit;
               end
            end;
          end; {end case Bono Reconocimiento}
      else  {else primer caracter no es 'B' ni 'C'}
        begin
             Result := False;
             exit;
        end;
      end;  {Case}
  end;

{Busco Fecha Vencimiento (Idem para Bono que Complemento}
  for i := 5 to 10 do
    if NOT (sNemotecnico[i] in ['0'..'9']) then
    begin
      Result := False;
      exit;
    end;

  {mes vencimiento}
  wmes := strtoint(sNemotecnico[7]+sNemotecnico[8]);
  if NOT wmes in [1..12] then
  begin
    Result := False;
    exit;
  end;

  {año vencimiento}
  wano := strtoint(sNemotecnico[9]+sNemotecnico[10]);
  if wano in [80..99] then
     wano := wano + 1900
  else
     wano := wano + 2000;

  {día vencimiento}
  wdia := strtoint(sNemotecnico[5]+sNemotecnico[6]);
  if (wdia < 1) or (wdia > ultimo_dia_mes(wmes,wano)) then
  begin
        Result := False;
        exit;
  end;

  {fecha vencimiento}

  try
    dFecha_Vencimiento := EncodeDate(wano,wmes,wdia)
  except
    begin
      Result := False;
      exit;
    end
  end;
end;

Function Custodia_Actual(  sEmpresa,
                           sTransaccion,
                           sFolio_Interno : String;
                           fItem_Omd      : Double;
                           dFecha_Proceso : TDatetime
                         ) : String ;
begin
   WITH dmComunInversiones.QRY_General do
   begin
      Close;
      sql.clear;
      sql.add(' SELECT a.Custodia FROM QS_TRA_CUSTODIA a');
      sql.add(' WHERE a.EMPRESA        = :empresa');
      sql.add(' AND   a.Transaccion    = :Transaccion');
      sql.add(' AND   a.Folio_Interno  = :Folio_Interno');
      sql.add(' AND   a.Item_Omd       = :Item_Omd');
      sql.Add(' AND   a.Fecha IN ( ');
      sql.add(' SELECT MAX( b.Fecha ) FROM QS_TRA_CUSTODIA b');
      sql.add(' WHERE a.EMPRESA        = b.Empresa');
      sql.add(' AND   a.Transaccion    = b.Transaccion');
      sql.add(' AND   a.Folio_Interno  = b.Folio_Interno');
      sql.add(' AND   a.Item_Omd       = b.Item_Omd');
      sql.add(' AND   b.Fecha          <= :Fecha');
      sql.add('   ) ');
      ParamByName('Empresa').AsString       := sEmpresa;
      ParamByName('Transaccion').AsString   := sTransaccion;
      ParamByName('Folio_Interno').AsString := sFolio_Interno;
      ParamByName('Item_Omd').asFloat       := fItem_Omd;
      ParamByName('Fecha').AsDate       := dFecha_Proceso;
      Open;

      Custodia_Actual := '';
      if Not Fieldbyname('Custodia').isNull then
         Custodia_Actual := FieldByName('Custodia').AsString;

      Close;
   end;
end;

procedure Registra_Movimiento_Confirmado_Ctacte(sEmpresa     : String;
                                               sTransaccion : String;
                                               sFolio       : String;
                                               var sConfirmado_Por : String;
                                               var Result          : Boolean);
begin
   sConfirmado_Por := '';
   Result := False;
   WITH dmComunInversiones.QRY_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CONFIRMADO_POR ');
      SQL.Add('   FROM QS_TES_CTACTE   ');
      SQL.Add('  WHERE FOLIO_INTERNO_OMD = :FOLIO_INTERNO_OMD ');
      SQL.Add('    AND TRANSACCION_OMD   = :TRANSACCION_OMD   ');
      SQL.Add('    AND EMPRESA           = :EMPRESA           ');
      SQL.Add('    AND CONFIRMADO_POR <> ''''                ');
      SQL.Add('    AND NOT CONFIRMADO_POR IS NULL            ');


      ParamByName('FOLIO_INTERNO_OMD').AsString := sFolio;
      ParamByName('TRANSACCION_OMD'  ).AsString := sTransaccion;
      ParamByName('EMPRESA'          ).AsString := sEmpresa;

      Try
        Open;
        if NOT EOF then
           if (FieldByName('CONFIRMADO_POR').AsString <> '') and
              (NOT FieldByName('CONFIRMADO_POR').IsNull)        then
           begin
              Result := True;
              sConfirmado_Por := FieldByName('CONFIRMADO_POR').AsString;
           end
        else
           Result := False;
      except
         Result := False;
      end;
      Close;
   end;
end;

function Existe_Traspaso_Ctacte(sEmpresa     : String;
                                 dFecha       : TDateTime) : Boolean;
begin
   Result := False;
   WITH dmComunInversiones.QRY_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT Count(*) As Num_Regs ');
      SQL.Add('   FROM QS_TES_CTACTE   ');
      SQL.Add('  WHERE Fecha_Operacion = :Fecha_Operacion ');
      SQL.Add('    AND EMPRESA         = :EMPRESA           ');


      ParamByName('Fecha_Operacion' ).AsDate := dFecha;
      ParamByName('EMPRESA'         ).AsString   := sEmpresa;


      Try
        Open;
        if (FieldByName('Num_Regs').AsFloat > 0 ) then
           begin
              Result := True;
           end
        else
           Result := False;
      except
         Result := False;
      end;
      Close;
   end;
end;

Procedure Leer_Contacto(sCODIGO_IDENTIDAD : String;
                        fITEM_DIR         : Double;
                        dFecha            : TDatetime;
                        sTipo_Contacto    : String;
                        fItem             : Double;
                        var sContacto     : String;
                        var fItem_Contacto: Double;
                        var sCargo        : String
                        );
begin
  sContacto  := '';
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.CONTACTO'
           +'      ,a.Cargo'
           +'      ,a.Item'
           +'  FROM QS_SYS_ID_CONTACTO a'
           +' WHERE a.Codigo_identidad = :Codigo_Identidad'
           +'   AND a.Item_Dir         = :Item_Dir'
           );
    if fItem <> 0 then
       Sql.Add('  AND a.Item  <> :Item' );

    Sql.Add('   AND a.Tipo_Contacto    = :Tipo_Contacto'
           +'   AND a.Fecha_Desde     <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString  := sCODIGO_IDENTIDAD;
    ParamByName('Item_Dir').asFloat           := fItem_Dir;
    if fItem <> 0 then
       Parambyname('Item').asFloat            := fItem;
    ParamByName('Fecha').AsDate               := dFecha;
    ParamByName('Tipo_Contacto').AsString     := sTipo_Contacto;
    Open;

    if Not FieldByName('CONTACTO').isNull then
    begin
       sContacto      := FieldByName('CONTACTO').AsString;
       sCargo         := FieldByName('CARGO').AsString;
       fItem_Contacto := FieldByName('Item').Asfloat;
    end;
    Close;
  end;
  Screen.Cursor := crDefault;
end;

Procedure Leer_Medio_Contacto( sCODIGO_IDENTIDAD : String;
                               fITEM_DIR         : Double;
                               fITEM_Contacto    : Double;                               
                               dFecha            : TDatetime;
                               sMedio            : String;
                           var sDescripcion_Medio     : String
                             );
begin
  sDescripcion_Medio  := '';
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.DESCRIPCION'
           +'  FROM QS_SYS_ID_CON_MEDIO a'
           +' WHERE a.Codigo_identidad = :Codigo_Identidad'
           +'   AND a.Item_Dir         = :Item_Dir'
           +'   AND a.Item_Contacto    = :Item_Contacto'
           +'   AND a.Medio            = :Medio'
           +'   AND a.Fecha_Desde  <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString := sCODIGO_IDENTIDAD;
    ParamByName('Item_Dir').asFloat          := fItem_Dir;
    ParamByName('Item_Contacto').asFloat     := fItem_Contacto;
    ParamByName('Fecha').AsDate              := dFecha;
    ParamByName('Medio').AsString            := sMedio;
    Open;

    if Not FieldByName('DESCRIPCION').isNull then
       sDescripcion_Medio := FieldByName('DESCRIPCION').AsString;

    Close;
  end;
  Screen.Cursor := crDefault;
end;

Procedure Leer_Medio_Identidad( sCODIGO_IDENTIDAD : String;
                                fITEM_DIR         : Double;
                                dFecha            : TDatetime;
                                sMedio            : String;
                            var sDescripcion_Medio     : String
                              );
begin
  sDescripcion_Medio  := '';
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.DESCRIPCION'
           +'  FROM QS_SYS_ID_MEDIO a'
           +' WHERE a.Codigo_identidad = :Codigo_Identidad'
           +'   AND a.Item_Dir         = :Item_Dir'
           +'   AND a.Medio            = :Medio'
           +'   AND a.Fecha_Desde  <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString := sCODIGO_IDENTIDAD;
    ParamByName('Item_Dir').asFloat          := fItem_Dir;
    ParamByName('Fecha').AsDate              := dFecha;
    ParamByName('Medio').AsString            := sMedio;
    Open;

    if Not FieldByName('DESCRIPCION').isNull then
       sDescripcion_Medio := FieldByName('DESCRIPCION').AsString;

    Close;
  end;
  Screen.Cursor := crDefault;
end;

Procedure Leer_Contacto_Cargo(sCODIGO_IDENTIDAD : String;
                              fITEM_DIR         : Double;
                              dFecha            : TDatetime;
                              sTipo_Contacto    : String;
                              sCargo            : String;
                              var sContacto     : String;
                              var fItem_Contacto: Double
                              );
begin
  sContacto  := '';
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.CONTACTO'
           +'      ,a.Item'
           +'  FROM QS_SYS_ID_CONTACTO a'
           +' WHERE a.Codigo_identidad = :Codigo_Identidad'
           +'   AND a.Item_Dir         = :Item_Dir'
           +'   AND a.Tipo_Contacto    = :Tipo_Contacto'
           +'   AND a.Cargo            = :Cargo'           
           +'   AND a.Fecha_Desde     <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString := sCODIGO_IDENTIDAD;
    ParamByName('Item_Dir').asFloat          := fItem_Dir;
    ParamByName('Fecha').AsDate              := dFecha;
    ParamByName('Tipo_Contacto').AsString    := sTipo_Contacto;
    ParamByName('Cargo').AsString            := sCargo;
    Open;

    if Not FieldByName('CONTACTO').isNull then
    begin
       sContacto      := FieldByName('CONTACTO').AsString;
       fItem_Contacto := FieldByName('Item').Asfloat;
    end;
    Close;
  end;
  Screen.Cursor := crDefault;
end;
//------------------------------------------------------------------------------
procedure Leer_Precios_Renta_Variable( sNemotecnico  : String;
                                       dFecha        : TDateTime;
                                       sTipo_Precio  : String;
                                       var fPrecio   : Double;
                                       var sMoneda   : String;
                                       var Result    : Boolean);
begin
    Result := False;
    fPrecio := 0;
    sMoneda := '';

    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add(' SELECT Precio' );
       SQL.Add('       ,Moneda' );
       SQL.Add('  FROM QS_FIN_PRECIOS');
       SQL.Add(' WHERE Nemotecnico = :Nemotecnico    ');
       SQL.Add('   AND Fecha_Precio = :Fecha          ');
       SQL.Add('   AND TIPO_PRECIO = :TIPO_PRECIO    ');
       ParamByName('Nemotecnico').AsString   := sNemotecnico;
       ParamByName('Fecha'      ).AsDate := dFecha;
       ParamByName('TIPO_PRECIO').AsString   := sTipo_Precio;

       Open;
       if Not FieldByName('Moneda').isNull then
       begin
          Result       := True;
          fPrecio := FieldByName('Precio').AsFloat;
          sMoneda := FieldByName('Moneda').asString;
       end;
       Close;
    end;
end;

Procedure Determina_Nodo_Clasificacion( sObjeto,
                                        sElemento,
                                        sCodigo_Clasif  : String;
                                    var fNodo_Clasif : Double
                                      );
begin
   fNodo_Clasif := 0;
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT NODO FROM  QS_SYS_CLASIF_OBJ'
              +'  WHERE Objeto   = :Objeto'
              +'  AND   Elemento = :Elemento'
              +'  AND   Codigo_Clasif = :Codigo_Clasif'
              );
      Parambyname('Objeto').asString        := sObjeto;
      Parambyname('Elemento').asString      := sElemento;
      Parambyname('Codigo_Clasif').asString := sCodigo_Clasif;
      Open;

      if Not Fieldbyname('Nodo').IsNull then
         fNodo_Clasif := Fieldbyname('Nodo').asFloat;

      Close;
   end;
end;

//------------------------------------------------------------------------------
Function Elemento_Clasificado( sObjeto             : String;
                               fNodo_Padre_Buscado : Double;
                               fNodo_Elemento      : Double
                              ) : Boolean;
var Buscar             : Boolean;
    fNodo_Elemento_Ant : Double;
begin
  Result := False;
  Buscar := True;
  While Buscar do
  begin
      fNodo_Elemento_Ant := fNodo_Elemento;
      Elemento_Clasif_Padre(  sObjeto
                             ,fNodo_Elemento
                             ,Buscar
                           );
      if fNodo_Elemento_Ant = fNodo_Padre_Buscado then
      begin
         Buscar := False;
         Result := True;
      end;
   end;
end;

procedure  Elemento_Clasif_Padre(   sObjeto        : String;
                                var fNodo_Elemento : Double;
                                var Result         : Boolean
                               );
begin
   Result := True;
   With dmComunInversiones.Qry_general do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT QS_NODO'
              +'   FROM QS_SYS_EST_CLA'
              +'  WHERE Codigo_Objeto = :Objeto'
              +'    AND Nodo       = :Nodo'
              );
      Parambyname('Objeto').asString   := sObjeto;
      ParamByname('Nodo').asFloat      := fNodo_Elemento;
      Open;

      if FieldByName('QS_NODO').IsNull then
            Result := False
      else  if (NOT FieldByName('QS_NODO').isNull)  and
               (FieldByName('QS_NODO').asFloat = 0) then
            Result := False
      else  if NOT (FieldByName('QS_NODO').IsNull) then
            fNodo_Elemento := FieldByName('QS_NODO').asFloat;

      Close;
   end;
end;

function Nodo_Padre(Objeto:String; Nodo_Hijo:Double) :String;
begin
   with dmComunInversiones.Qry_general do
   begin
      close;
      SQL.clear;
      SQL.Add('select Qs_Nodo from qs_sys_est_cla'
             +' where codigo_objeto = :codigo_objeto '
             +'   and Nodo = :Nodo ');
      ParamByName('codigo_objeto').AsString := Objeto;
      ParamByName('Nodo').AsFloat           := Nodo_Hijo;
      Open; {ejecutamos el query buscando hijos }
      if not eof then
         Result := FieldByName('Qs_Nodo').AsString
      else
         Result := '0';
   end;
end;

function Nodos_Hijos(Objeto:String; Nodo_Padre:Double) :String;
var ListaClaves :String;
    i,j,NumReg  :longint;
begin
   GlobalTS := TStringList.create;
   Busca_Hijos(Objeto,Nodo_Padre);
   J := 0;
   NumReg := GlobalTS.Count - 1;
   ListaClaves := '';
   for i := J to NumReg do
   begin
       ListaClaves:= ListaClaves + GlobalTS[j] + ',';
       j:=j+1;
   end;
   ListaClaves:= ListaClaves + FloattoStr(Nodo_Padre);
   Result := ListaClaves;
end;

procedure Busca_Padre(Objeto:String;var Nodo:Double);
var
  fNodo:Double;
begin
   fNodo := 0;
   with dmComunInversiones.Qry_general do
   begin
        close;
        SQL.clear;
        SQL.Add('select qs_Nodo from qs_sys_est_cla'
               +' where codigo_objeto = :codigo_objeto '
               +' AND Qs_Nodo <> Nodo '
               +' AND QS_Nodo <> 1'
               +' AND Nodo = :Nodo ');
        ParamByName('codigo_objeto').AsString := Objeto;
        ParamByName('Nodo').AsFloat := Nodo;
        Open; {ejecutamos el query buscando hijos }
        fNodo := dmComunInversiones.Qry_general.FieldByName('qs_Nodo').AsFloat;
        Close;
   end;

   if fNodo = 0 then { Si no hay hijos entonces }
     {volver}
   else
   begin
     Busca_Padre(Objeto,fNodo);

     Nodo := fNodo;
   end;
end;

procedure Busca_Hijos(Objeto:String;Nodo_Padre:Double);
var
  TempString  : TStringList;
  i:longint;
begin
   with dmComunInversiones.Qry_general do
   begin
        close;
        SQL.clear;
        SQL.Add('select Nodo from qs_sys_est_cla'
               +' where codigo_objeto = :codigo_objeto '
               +' AND Qs_Nodo <> Nodo '
               +' AND Qs_Nodo = :Qs_Nodo ');
        ParamByName('codigo_objeto').AsString := Objeto;
        ParamByName('Qs_Nodo').AsFloat := Nodo_Padre;
        Open; {ejecutamos el query buscando hijos }
        first; {Busco el primer hijo }
   end;

   if dmComunInversiones.Qry_general.EOF then { Si no hay hijos entonces }
     {volver}
   else
   begin
     TempString := QueryToStringList(dmComunInversiones.Qry_general);

     for i:= 0 to TempString.Count-1 do {Para Todos lo hijos, busco más hijos }
        Busca_Hijos(Objeto,strtoint(TempString[i]));
     {Agrego los hijos a la lista global antes de borrar la lista local }

     for i:= 0 to TempString.Count-1 do
         GlobalTS.Add(TempString[i]);
     TempString.free; {Borro la lista local }
   end;
end;

function QueryToStringList(Qry:TFDQuery):TStringList;
 var
  TS : TStringList;
 begin
   TS := TStringList.create;
    with Qry do
    begin
      first;
      While not(EOF) do
       begin
         TS.Add(FieldByName('Nodo').AsString);
         next;
       end;
    end;
   Result := TS;
end;

procedure Leer_Nombre_Instrumento(sInstrumento  : String;
                              var sDescripcion  : String;
                              var Result        : Boolean
                                 );
begin
  Result := False;
  WITH dmComunInversiones.Qry_Nom_Instrum do
    begin
      Close;
      ParamByName('Cod_Instrumento').AsString := trim(sInstrumento);
      Open;

      if NOT FieldByName('Nom_Instrumento').IsNull then
      begin
         sDescripcion := FieldByName('Nom_Instrumento').AsString;
         Result       := True;
      end;
//      Close;
    end;
end;

Procedure Graba_Empresas_param_proceso( sCod_Proceso  : String;
                                        sParametro    : String
                                      );
begin
    with dmComunInversiones.Qry_General do
    begin
      sql.Clear;
      sql.Add('DELETE FROM qs_sys_param_proceso '
             +' WHERE Proceso   = :Proceso '
             +'   AND Parametro = :Parametro '
             );
      ParamByName('Proceso').AsString    := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      ExecSql;
      Close;

      Sql.Clear;
      Sql.Add( ' SELECT DISTINCT Empresa FROM QS_SYS_PARAM_EMPRESA'
              +' WHERE pid = :Pid'
             );
      ParamByName('Pid').AsFloat := StrToFloat(sCod_Proceso);
      Open;

      While Not EOF do
      begin
          dmComunInversiones.Qry_Varios.sql.Clear;
          dmComunInversiones.Qry_Varios.sql.Add('INSERT INTO qs_sys_param_proceso '
                                                 +'(Proceso    '
                                                 +',Parametro  '
                                                 +',Valor      '
                                                 +') VALUES (  '
                                                 +' :Proceso   '
                                                 +',:Parametro '
                                                 +',:Valor     '
                                                 +') '
                                                 );
          dmComunInversiones.Qry_Varios.ParamByName('Proceso').AsString    := sCod_Proceso;
          dmComunInversiones.Qry_Varios.ParamByName('Parametro').AsString  := sParametro;
          dmComunInversiones.Qry_Varios.ParamByName('Valor').AsString      := Fieldbyname('Empresa').asString;
          dmComunInversiones.Qry_Varios.ExecSql;
          dmComunInversiones.Qry_Varios.Close;
          Next;
      end;
      Close;
    end;
end;

Procedure Graba_param_empresa(sEmpresa  : String;
                              sCartera  : String;
                              iPid      : Integer);
begin
   dmComunInversiones.Qry_Param_Empresa.ParamByName('PID'    ).AsInteger  := iPid;
   dmComunInversiones.Qry_Param_Empresa.ParamByName('Empresa').AsString   := sEmpresa;
   dmComunInversiones.Qry_Param_Empresa.ParamByName('Cartera').AsString   := sCartera;
   dmComunInversiones.Qry_Param_Empresa.ExecSQL;
end;

function lee_tasa_mercado_a_Fecha( sNemotecnico     : String;
                                   sTipo_Instrum    : String;
                                   dFecha           : TDateTime;
                                   var sOrigen          : String) : Double;
var
  sTipo            : String;
begin
   if sTipo_Instrum = 'B' then
      Result := Leer_Tir_Mra( sNemotecnico
                             ,dFecha
                             ,False // No Busca Hacia Atras
                             ,sOrigen
                             ,sTipo
                             )
   else
   begin
       With dmComunInversiones.QRY_General do
       begin
         SQL.Clear;
         SQL.Add(' SELECT Valor'
                +'       ,Origen'
                +'  FROM QS_FIN_TASA_MERCAD'
                +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
                +'   AND Fecha              = :Fecha'
                );

         ParamByName('Codigo_Nemotecnico').AsString := sNemotecnico;
         ParamByName('Fecha').AsDate                := dFecha;
         Open;

         if (FieldByName('Valor').IsNull) or
            (FieldByName('Valor').AsFloat = 0) then
            Result := 0
         else
         begin
            sOrigen := FieldByName('Origen').AsString;
            Result  := FieldByName('Valor').AsFloat;
         end;
         Close;
       end;
  end; // fin if
end;

Function Stock_Parcial_Cartera( sEmpresa,
                                sCartera      : String;
                                dFecha_Stock  : TDatetime
                              ) : Boolean;
begin
     Result := False;
     With dmComunInversiones.QRY_General do
     begin
         Close;
         Sql.Clear;
         Sql.Add( 'SELECT Empresa FROM QS_TRA_OMD_STK_RF_LOG '
                +'  WHERE Empresa = :Empresa'
                +'    AND Cartera = :Cartera'
                +'    AND Fecha_Cierre = :Fecha_Cierre'
                );
         Parambyname('Empresa').asString        := sEmpresa;
         Parambyname('Cartera').asString        := sCartera;
         Parambyname('Fecha_Cierre').AsDate := dFecha_Stock;
         try
            Open;
          except on E: EFDDBEngineException do
            begin
              Result := False;
              Close;
              Exit;
            end;
         end;

         if NOT Fieldbyname('Empresa').IsNull then
            Result := True;

         Close;
     end;
end;
//(*    // Descomentado por E.S. 24-10-2012, para utilizarlo en la busqueda de Motivo para el B3 (Circ. 1835, 2078)
Procedure Motivo_Nemotecnico_RV( sEmpresa,
                                 sCartera,
                                 sTransaccion  : String;
                                 dFecha_Cierre : TDatetime;
                                 sNemotecnico  : String;
                            var  sMotivo       : String;
                            var  Result        : Boolean
                               );
begin
     Result := False;
     With dmComunInversiones.QRY_General do
     begin
        Sql.Clear;
        {
        Sql.Add(' SELECT a.Cod_Motivo'
               +'  FROM QS_TRA_OMD_MOTIVO a'
               +'      ,QS_TRA_OMD_DET_RF b'
               +' WHERE a.Empresa       = b.Empresa'
               +'  AND  a.Transaccion   = b.Transaccion'
               +'  AND  a.Folio_Interno = b.Folio_Interno'
               +'  AND  a.Item_Omd      = b.Item_Omd'
               +'  AND  a.Empresa      = :Empresa'
               +'  AND  a.Cartera      = :Cartera'
               +'  AND  b.Nemotecnico  = :Nemotecnico'
               +'  AND  a.Fecha_Desde <= :Fecha'
               +'  AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
               +'  AND a.folio_interno not in (SELECT e.folio               '
               +'				 FROM qs_ctr_anulacion e    '
               +'				WHERE e.folio   = a.folio_interno    '
               +'  				  AND e.empresa = a.empresa          '
               +'				  AND e.transaccion = a.transaccion) '
               );
        }
// Edosan 300605        Sql.Add(' SELECT a.Cod_Motivo                                                                                 ');
// Motivo afectaba Anexo 7 de Peru .., ojo con el anexo6 que utiliza esta funcion
// pero no se ve el motivo luego en el reporte
        Sql.Add(' SELECT a.Cod_Motivo  as Cod_Motivo, a.Fecha_Desde                           ');  // E.S.  24-10-2012, decia asi antes SELECT c.Motivo  as Cod_Motivo
        Sql.Add('   FROM QS_TRA_OMD_MOTIVO a                                                  ');
        Sql.Add('       ,QS_TRA_OMD_DET_RF b                                                  ');
        Sql.Add('       ,QS_TRA_OMD c                                                         ');
        Sql.Add('  WHERE a.Empresa        = b.Empresa                                         ');
        Sql.Add('    AND a.Transaccion   = b.Transaccion                                      ');
        Sql.Add('    AND a.Folio_Interno = b.Folio_Interno                                    ');
        Sql.Add('    AND a.Item_Omd      = b.Item_Omd                                         ');
        Sql.Add('    AND c.Folio_Interno = b.Folio_Interno                                    ');
        Sql.Add('    AND c.Transaccion   = b.Transaccion                                      ');
        Sql.Add('    AND c.Empresa       = b.Empresa                                          ');
        Sql.Add('    AND a.Empresa       = :Empresa                                           ');
        Sql.Add('    AND a.Cartera       = :Cartera                                           ');
        Sql.Add('    AND a.Fecha_Desde  <= :Fecha                                             ');
        Sql.Add('    AND a.transaccion IN (SELECT x.codigo_transaccion                        ');
        Sql.Add('                            FROM QS_SYS_TRAN_IMPLIC x                        ');
        Sql.Add('                           WHERE x.implicancia = ''COMPRA'')                 ');
        Sql.Add('    AND a.transaccion IN (SELECT x.codigo_transaccion                        ');
        Sql.Add('                            FROM QS_SYS_TRAN_IMPLIC x                        ');
        Sql.Add('                           WHERE x.implicancia = ''RV'')                     ');
        Sql.Add('    AND  b.Nemotecnico   = :Nemotecnico                                      ');
        Sql.Add('    AND  c.Fecha_Operacion  <= :Fecha                                        ');
        Sql.Add('    AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)                   ');
        Sql.Add('    AND  a.folio_interno NOT IN (SELECT e.folio                              ');
        Sql.Add(' 				    FROM qs_ctr_anulacion e                   ');
        Sql.Add(' 				   WHERE e.folio   = a.folio_interno          ');
        Sql.Add(' 				     AND e.empresa = a.empresa                ');
        Sql.Add(' 				     AND e.transaccion = a.transaccion)       ');
        Sql.Add('    AND c.Fecha_Operacion IN (SELECT MAX(f.Fecha_Operacion)                  ');
        Sql.Add(' 				 FROM QS_TRA_OMD f                            ');
        Sql.Add(' 				     ,QS_TRA_OMD_DET_RF g                     ');
        Sql.Add(' 				WHERE g.Nemotecnico = :Nemotecnico            ');
        Sql.Add(' 				  AND f.Folio_Interno = g.Folio_Interno       ');
        Sql.Add(' 				  AND f.Transaccion   = g.Transaccion         ');
        Sql.Add(' 				  AND f.Empresa       = g.Empresa             ');
        Sql.Add(' 				  AND f.Fecha_Operacion  <= :Fecha            ');
        Sql.Add(' 				  AND f.Folio_Interno NOT IN (SELECT h.folio  ');
        Sql.Add(' 				      				FROM qs_ctr_anulacion h              ');
        Sql.Add(' 				      			       WHERE h.folio   = g.folio_interno     ');
        Sql.Add(' 				      			         AND h.empresa = g.empresa           ');
        Sql.Add(' 				      			         AND h.transaccion = g.transaccion)) ');
        Sql.Add(' ORDER BY a.Fecha_Desde Desc ');

        Parambyname('Empresa').asString     := sEmpresa;
        Parambyname('Cartera').asString     := sCartera;
        Parambyname('Nemotecnico').asString := sNemotecnico;
        Parambyname('Fecha').AsDate     := dFecha_Cierre;
        Open;

        if NOT Fieldbyname('Cod_Motivo').IsNull then
        begin
           sMotivo := Fieldbyname('Cod_Motivo').asString;
           Close;
           Result  := True;
           Exit;
        end;
        Close;

        sMotivo := '';
        Result  := True;
        sMotivo := default_codgen( 'MOTINV'
                                  ,'FI'
                                  ,sTransaccion
                                  );
        if Trim(sMotivo) = '' then
           Result := False;
     end;
end;
//*)
procedure Valor_Limite_Rubro(  sString_Empresas
                              ,sString_Carteras
                              ,sTipo_Limite
                              ,sRubro
                              ,sEmisor
                              ,sProceso      : String;
                              dFecha_Proceso : Tdatetime;
                          var fValor_Limite  : Double
                            );
begin
  fValor_Limite := 0;
  With dmComunInversiones.Qry_General do
  begin
     Sql.Clear;
     Sql.Add(' SELECT DISTINCT a.Porcentaje'
            +'               ,a.Maximo_Permitido'
            +'    FROM QS_SUP_251 a'
            +'        ,QS_SUP_251_DET b'
            +'    WHERE a.FECHA_PROCESO = :Fecha_Proceso'
            +'      AND a.Empresa       = b.Empresa'
            +'      AND a.fecha_proceso = b.fecha_Proceso'
            +'      AND a.Proceso       = b.Proceso'
            +'      AND a.Codigo_Limite = b.Codigo_Limite'
            +'      AND a.Tipo_Limite   = :Tipo_Limite'
            +'      AND b.Codigo_RTPR   = :Codigo_RTPR');
     if sEmisor <> '' then
        Sql.Add('   AND b.Emisor        = :Emisor');
     Sql.Add('      AND b.Empresa IN ' + sString_Empresas
            +'      AND b.cartera IN ' + sString_Carteras
            );
     Parambyname('Fecha_Proceso').AsDate := dFecha_Proceso;
     Parambyname('Tipo_Limite').asString     := sTipo_Limite;
     Parambyname('Codigo_RTPR').asString     := sRubro;
     if sEmisor <> '' then
        Parambyname('Emisor').asString       := sEmisor;

     Open;
     While Not Eof do
     begin
        fValor_Limite := fValor_Limite + Fieldbyname('Maximo_Permitido').asFloat;
        Next;
     end;
     Close;
  end;

end;

procedure Valor_Limite_Emisor_Rubro(  sString_Empresas
                                     ,sString_Carteras
                                     ,sTipo_Limite
                                     ,sRubro
                                     ,sEmisor
                                     ,sProceso      : String;
                                     dFecha_Proceso : Tdatetime;
                                 var fValor_Limite  : Double
                                   );
var fValor_Pte_Cartera
   ,fMaximo_Permitido : Double;
begin
  fValor_Limite       := 0;
  fValor_Pte_Cartera  := 0;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT DISTINCT b.Emisor'
            +'        ,a.Maximo_Permitido'
	    +'	      ,SUM(b.VALOR_PTE_MC_CPA) as VALOR_PTE_MC_CPA'
            +'      FROM QS_SUP_251 a'
            +'          ,QS_SUP_251_DET b'
            +'      WHERE a.FECHA_PROCESO = :Fecha_Proceso'
            +'       AND a.Empresa       = b.Empresa'
            +'       AND a.fecha_proceso = b.fecha_Proceso'
            +'       AND a.Proceso       = b.Proceso'
            +'       AND a.Codigo_Limite = b.Codigo_Limite'
            +'       AND a.Emisor        = b.Emisor'
            +'       AND a.Tipo_Limite   = :Tipo_Limite'
            +'       AND b.Codigo_RTPR   = :Codigo_RTPR');
     if sEmisor <> '' then
        Sql.Add('    AND b.Emisor        = :Emisor');
     Sql.Add('       AND b.Empresa IN ' + sString_Empresas
            +'       AND b.cartera IN ' + sString_Carteras
            +'    GROUP BY b.Emisor'
            +'            ,a.Maximo_Permitido'
            );
     Parambyname('Fecha_Proceso').AsDate := dFecha_Proceso;
     Parambyname('Tipo_Limite').asString     := sTipo_Limite;
     Parambyname('Codigo_RTPR').asString     := sRubro;
     if sEmisor <> '' then
        Parambyname('Emisor').asString       := sEmisor;
     Open;

     // Debo Entregar el Minimo Entre lo permitido y lo la suma de lo invertido por
     // los emisores del rubro....
     if NOT Fieldbyname('Maximo_Permitido').IsNull then
        fMaximo_Permitido := Fieldbyname('Maximo_Permitido').asFloat;

     fValor_Limite := 0;        
     While Not Eof do
     begin
       {  // ggarcia 14-03-2014  solicitado por alicia en implantacion ohio
        fValor_Pte_Cartera := fMaximo_Permitido;
        if Fieldbyname('VALOR_PTE_MC_CPA').asFloat < fMaximo_Permitido then
           fValor_Pte_Cartera := Fieldbyname('VALOR_PTE_MC_CPA').asFloat;
        fValor_Limite := fValor_Limite + fValor_Pte_Cartera;
        }
         fValor_Limite := fValor_Limite + Fieldbyname('Maximo_Permitido').asFloat;
       Next;
     end;
     Close;
  end;
end;

procedure Porcentaje_Emisor_Holding(   sEmpresa
                                      ,sEmisor       : String;
                                       dFecha_Cierre : Tdatetime;
                                  var fPorcentaje    : Double;
                                  var bResult        : Boolean
                                  );
begin
  fPorcentaje := 0;
  bResult     := False;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT Porcen_Patrimonio'
            +'    FROM QS_SYS_DEF_HOLDING_FECHAS '
            +'      WHERE Codigo_Empresa     = :Codigo_Empresa'
            +'       AND  Sys_Codigo_Holding = :Sys_Codigo_Holding'
            +'       AND  Sys_Tipo_relacion  = ''FILIAL'''
            +'       AND  Fecha_Desde <= :Fecha_Cierre'
            +'      AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)'
            );
     Parambyname('Sys_Codigo_Holding').asString := sEmpresa;
     Parambyname('Codigo_Empresa').asString     := sEmisor;
     Parambyname('Fecha_Cierre').AsDate     := dFecha_Cierre;
     Open;

     if NOT Fieldbyname('Porcen_Patrimonio').IsNull then
     begin
        fPorcentaje := Fieldbyname('Porcen_Patrimonio').asFloat;
        bResult     := True;
     end;   

     Close;
  end;
end;

procedure Valor_Interfaz_SUN_ACCOUNT(  sEmpresa
                                      ,sObjeto_Cuenta : String;
                                       fNodo_Cuenta   : Double;
                                       dFecha_Cierre  : Tdatetime;
                                       sColumna       : String;
                                  var sValor_Columna  : String
                                  );
begin
  sValor_Columna := '';
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT  '+sColumna+ ' FROM QS_TRAS_PMS_SUN'
            +'      WHERE Empresa       = :Empresa'
            +'       AND  Objeto_Cuenta = :Objeto_Cuenta'
            +'       AND  Nodo_Cuenta   = :Nodo_Cuenta'
            +'       AND  Fecha_Desde <= :Fecha_Cierre'
            +'      AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)'
            );
     Parambyname('Empresa').asString        := sEmpresa;
     Parambyname('Objeto_Cuenta').asString  := sObjeto_Cuenta;
     Parambyname('Nodo_Cuenta').asFloat     := fNodo_Cuenta;
     Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;
     Open;

     if NOT Fieldbyname(sColumna).IsNull then
        sValor_Columna := Fieldbyname(sColumna).asString;

     Close;
  end;
end;

procedure Valor_Mercado(  sEmpresa
                         ,sCartera
                         ,sTransaccion
                         ,sFolio_Interno   : String;
                          fItem_Omd        : Double;
                          dFecha_Cierre    : Tdatetime;
                     var fValor_nominal    : Double;
                     var fValor_Pte_UM_MDO : Double;
                     var fValor_Pte_MC_MDO : Double;
                     var bResult           : Boolean
                     );
begin
  fValor_Pte_UM_MDO := 0;
  fValor_Pte_MC_MDO := 0;
  fValor_nominal    := 0;

  bResult           := False;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT Valor_Pte_UM_MDO'
            +'       ,Valor_Pte_MC_MDO'
            +'       ,Valor_Nominal'
            +'      FROM QS_RES_MERCADO '
            +'      WHERE Fecha_Cierre  = :Fecha_Cierre'
            +'       AND  Item_Omd      = :Item_Omd'
            +'       AND  Folio_Interno = :Folio_Interno'
            +'       AND  Transaccion   = :Transaccion'
            +'       AND  Cartera       = :Cartera'
            +'       AND  Empresa       = :Empresa'
            );
     Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;
     Parambyname('Item_Omd').asFloat        := fItem_Omd;
     Parambyname('Folio_Interno').asString  := sFolio_Interno;
     Parambyname('Transaccion').asString    := sTransaccion;
     Parambyname('Cartera').asString        := sCartera;
     Parambyname('Empresa').asString        := sEmpresa;
     Open;

     if NOT Fieldbyname('Valor_Pte_UM_MDO').IsNull then
     begin
        fValor_Pte_UM_MDO := Fieldbyname('Valor_Pte_UM_MDO').asFloat;
        fValor_Pte_MC_MDO := Fieldbyname('Valor_Pte_MC_MDO').asFloat;
        fValor_nominal    := Fieldbyname('Valor_Nominal'   ).asFloat;
        bResult           := True;
     end;

     Close;
  end;
end;

procedure Valor_Presente(sEmpresa
                        ,sCartera
                        ,sTransaccion
                        ,sFolio_Interno   : String;
                         fItem_Omd        : Double;
                         dFecha_Cierre    : Tdatetime;
                     var fValor_nominal    : Double;
                     var fValor_Pte_UM_Cpa : Double;
                     var fValor_Pte_MC_Cpa : Double;
                     var fPrecio_Cpa       : Double;
                     var bResult           : Boolean
                         );
begin
  fValor_Pte_UM_Cpa := 0;
  fValor_Pte_MC_Cpa := 0;
  fValor_nominal    := 0;
  fPrecio_Cpa       := 0;

  bResult           := False;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add('SELECT Valor_Pte_UM_Cpa'
            +'      ,Valor_Pte_MC_Cpa'
            +'      ,Valor_Nominal'
            +'      ,Tasa_Compra'
            +'  FROM QS_RES_MERCADO '
            +' WHERE Fecha_Cierre  = :Fecha_Cierre'
            +'   AND Item_Omd      = :Item_Omd'
            +'   AND Folio_Interno = :Folio_Interno'
            +'   AND Transaccion   = :Transaccion'
            +'   AND Cartera       = :Cartera'
            +'   AND Empresa       = :Empresa'
            );
     Parambyname('Fecha_Cierre').AsDate     := dFecha_Cierre;
     Parambyname('Item_Omd').asFloat        := fItem_Omd;
     Parambyname('Folio_Interno').asString  := sFolio_Interno;
     Parambyname('Transaccion').asString    := sTransaccion;
     Parambyname('Cartera').asString        := sCartera;
     Parambyname('Empresa').asString        := sEmpresa;
     Open;

     if NOT Fieldbyname('Valor_Pte_UM_Cpa').IsNull then
     begin
        fValor_Pte_UM_Cpa := Fieldbyname('Valor_Pte_UM_Cpa').asFloat;
        fValor_Pte_MC_Cpa := Fieldbyname('Valor_Pte_MC_Cpa').asFloat;
        fValor_nominal    := Fieldbyname('Valor_Nominal').asFloat;
        fPrecio_Cpa       := Fieldbyname('Tasa_Compra').asFloat;
        bResult           := True;
     end;

     Close;
  end;
end;

procedure lee_proy_Fecha_Tope(  sTipo_Proceso  : String;
                                dFecha_Calculo : TDateTime;
                            var dFecha_Tope    : TDateTime;
                            var sAntes_Despues : String;
                            var Result         : Boolean
                             );
var
  fCantidad      : Double;
  sUnidad        : String;
  bExiste        : Boolean;
begin
  Result  := False;
  bExiste := True;
  if sValorizacion_Proceso = 'SI' then
  begin
     Busca_Proy_Precio_Mem( sTipo_Proceso,
                            fCantidad,
                            sUnidad,
                            sAntes_Despues,
                            bExiste
                           );
    if Not bExiste then
       Exit;
  end
  else
  begin
      With dmComunInversiones.QRY_General do
      begin
        SQL.Clear;
        SQL.Add('  SELECT *'
               +'  FROM QS_FIN_PROY_PRECIOS'
               +' WHERE Tipo_Proceso = :Tipo_Proceso'
               );
        ParamByName('Tipo_Proceso').AsString := sTipo_Proceso;
        Open;

        if FieldByName('Tipo_Proceso').IsNull then
        begin
           Close;
           Exit;
        end
        else
        begin
          fCantidad      := Fieldbyname('Cantidad').asFloat;
          sUnidad        := Fieldbyname('Unidad').asString;
          sAntes_Despues := FieldByName('Antes_Despues').AsString;
        end;
        Close;
      end;
  end;

  if ( fCantidad      = 0        ) or
     ( sUnidad        = EmptyStr ) or
     ( sAntes_Despues = EmptyStr ) then
     Exit;

  if sAntes_Despues = 'A' then
     fCantidad := fCantidad * (-1);

  if sUnidad = 'DIA' then
     dFecha_Tope := (dFecha_Calculo + fCantidad);

  if sUnidad = 'MES' then
     dFecha_Tope := (dFecha_Calculo + (fCantidad*30));

  if sUnidad = 'ANO' then
     dFecha_Tope := (dFecha_Calculo + (fCantidad*365));

  Result := True;
end;

Procedure Determina_Monto_Pasivos( sEmpresa
                                  ,sCartera
                                  ,sCodigo_Objeto : String;
                                   dFecha_Cierre  : TDatetime;
                                   fNodo          : Double;
                               var fMonto : Double
                                  );
begin
    fMonto := 0;
    With dmComunInversiones.QRY_General do
    begin
       Close;
       Sql.Clear;
       Sql.Add(  ' SELECT Monto FROM QS_SBS_39_ANEXO2_PASIVOS'
                +' WHERE Empresa         = :Empresa'
                +'   AND Cartera_Proceso = :Cartera_Proceso'
                +'   AND Fecha_cierre    = :Fecha_Cierre'
                +'   AND Codigo_Objeto   = :Codigo_Objeto'
                +'   AND Nodo            = :Nodo'
               );
       Parambyname('Empresa').asString         := sEmpresa;
       Parambyname('Cartera_Proceso').asString := sCartera;
       Parambyname('Fecha_Cierre').AsDate  := dFecha_Cierre;
       Parambyname('Codigo_Objeto').asString   := sCodigo_Objeto;
       Parambyname('Nodo').asFloat             := fNodo;
       try
          Open;
       except on E:EFDDBEngineException do
          begin
             ShowError(E);
          end;
       end;

       if NOT Fieldbyname('Monto').IsNull then
          fMonto := Fieldbyname('Monto').asFloat;
       Close;
    end;
end;

Procedure Determina_Monto_Pasivos_11052(sEmpresa       : String;
                                        sCartera       : String;
                                        sCodigo_Objeto : String;
                                        dFecha_Cierre  : TDatetime;
                                        fNodo          : Double;
                                        sLista         : String;
                                    var fMonto         : Double;
                                    var fMonto_Activo  : Double);
begin
    fMonto := 0;
    With dmComunInversiones.QRY_General do
    begin
       Close;
       Sql.Clear;
       Sql.Add(  ' SELECT monto_pasivo,activo_asignado '
                +'   FROM QS_SBS_11052_ANEXO2_PASIVOS'
                +'  WHERE Empresa         = :Empresa'
                +'    AND Cartera_Proceso = :Cartera_Proceso'
                +'    AND Fecha_cierre    = :Fecha_Cierre'
                +'    AND Codigo_Objeto   = :Codigo_Objeto');
       if sLista <> '' then
          Sql.Add(  '   AND Nodo         in ('+sLista+')')
       else
          Sql.Add(  '   AND Nodo         = :Nodo');
       Parambyname('Empresa').asString         := sEmpresa;
       Parambyname('Cartera_Proceso').asString := sCartera;
       Parambyname('Fecha_Cierre').AsDate  := dFecha_Cierre;
       Parambyname('Codigo_Objeto').asString   := sCodigo_Objeto;
       if sLista = '' then
       Parambyname('Nodo').asFloat             := fNodo;
       try
          Open;
       except on E:EFDDBEngineException  do
          begin
             ShowError(E);
          end;
       end;
       while not eof do
       begin
          if NOT Fieldbyname('monto_pasivo').IsNull then
             if Fieldbyname('monto_pasivo').asFloat > fMonto then
             begin
                fMonto := Fieldbyname('monto_pasivo').asFloat;
                fMonto_Activo := Fieldbyname('activo_asignado').asFloat;
             end;
          Next;
       end;
       Close;
    end;
end;

Procedure Leer_PROV_IMPAIRMENT( sProceso,
                                sEmpresa ,
                                sTransaccion,
                                sFolio_Interno          : String;
                                fItem_omd               : Double;
                                dFecha_Proceso          : TDatetime;
                                sMoneda_Conversion      : string;
                                var fValor              : Double;
                                var sModelo_Propio      : String;
                                var fDeterioro_Unitario : Double;
                                var sTipo_Carga         : String; //SS 29-08-2022 Proyecto Mutual deterioro
                                var bResult             : Boolean
                                );
var bResul2 : Boolean;
    sModulo_Error,
    sString_Error : string;
begin
  WITH dmComunInversiones.Qry_ProvImp do
  begin

     ParamByName('Codigo_Proceso').AsString  := sProceso;
     ParamByName('Empresa').AsString         := sEmpresa;
     ParamByName('Transaccion').AsString     := sTransaccion;
     ParamByName('Folio').AsString           := sFolio_Interno;
     ParamByName('Item').AsFloat             := fItem_Omd;
     Parambyname('Fecha_Proceso').AsDate     := dFecha_Proceso;
     Open;

     if Not FieldByName('Valor').IsNull then
     begin
        fValor              := Fieldbyname('Valor').asFloat;
        sModelo_Propio      := FieldByName('Modelo_Propio').asString;
        fDeterioro_Unitario := FieldByName('DETERIORO_UNITARIO').asFloat;
        sTipo_Carga         := FieldByName('Tipo_Carga').asString;   //SS 29-08-2022 Proyecto Mutual deterioro
        bResult        := True;
        if FieldByName('Moneda').asString <> sMoneda_Conversion then
        begin
          conversion_unidad_mon(trim(Fieldbyname('Moneda').asString),
                                trim(sMoneda_Conversion),
                                'BC',
                                dFecha_Proceso,
                                Fieldbyname('Valor').asFloat,
                                fValor,
                                sModulo_Error,
                                sString_Error,
                                bResul2);
          if Not bResul2 then
          begin
            fValor              := 0;
            sModelo_Propio      := 'NO';
            fDeterioro_Unitario := 0;
            bResult             := False;
          end;
        end;
     end
     else
     begin
        fValor              := 0;
        sModelo_Propio      := '';
        fDeterioro_Unitario := 0;
        bResult             := False;
     end;
     Close;
  end;
end;//Determina nominales vendidos en Periodo

Function  Existe_Folio_Item_Compra( sEmpresa ,
                                    sTransaccion,
                                    sFolio_Interno  : String;
                                    fItem_omd       : Double
                                   ) : Boolean;
begin
  Result := False;
  WITH dmComunInversiones.Qry_Existe_Folio do
  begin
     {
     SQL.Clear;
     SQL.Add(' SELECT a.Empresa, a.Instrumento'
            +' FROM  QS_TRA_OMD_DET_RF a'
            //+'      ,QS_TRA_OMD d'
            +' WHERE a.Folio_Interno = :Folio'
            +'   AND a.Item_Omd      = :Item'
            +'   AND a.Transaccion   = :Transaccion'
            +'   AND a.Empresa       = :Empresa'
            +'   AND a.Transaccion IN (SELECT b.Codigo_Transaccion'
            +'                            FROM qs_sys_tran_implic b '
            +'                         WHERE b.Codigo_transaccion = a.transaccion'
            +'                            AND b.implicancia IN (''COMPRA'', ''DERIVADO'') '
            +'                         )'
            );
     }
     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio_Interno;
     ParamByName('Item').AsFloat         := fItem_Omd;
     Open;
     if Not FieldByName('Empresa').IsNull then
        Result := True;
     Close;
  end;
end;

Function  Existe_Folio_Item_Instrum( sEmpresa ,
                                    sTransaccion,
                                    sFolio_Interno  : String;
                                    fItem_omd       : Double;
                                var sInstrumento    : String
                                   ) : Boolean;
begin
  Result := False;
  sInstrumento := '';
  WITH dmComunInversiones.Qry_Existe_Folio do
  begin
     {
     SQL.Clear;
     SQL.Add(' SELECT a.Empresa, a.Instrumento'
            +' FROM  QS_TRA_OMD_DET_RF a'
            //+'      ,QS_TRA_OMD d'
            +' WHERE a.Folio_Interno = :Folio'
            +'   AND a.Item_Omd      = :Item'
            +'   AND a.Transaccion   = :Transaccion'
            +'   AND a.Empresa       = :Empresa'
            +'   AND a.Transaccion IN (SELECT b.Codigo_Transaccion'
            +'                            FROM qs_sys_tran_implic b '
            +'                         WHERE b.Codigo_transaccion = a.transaccion'
            +'                            AND b.implicancia IN (''COMPRA'', ''DERIVADO'') '
            +'                         )'
            );
     }
     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio_Interno;
     ParamByName('Item').AsFloat         := fItem_Omd;
     Open;
     if Not FieldByName('Empresa').IsNull then
     begin
        Result := True;
        sInstrumento := FieldByName('Instrumento').asString;
     end;
     Close;
  end;
end;

function Existe_Nemotecnico_RF(sNemotecnico : String) : Boolean;
begin
  Existe_Nemotecnico_RF := False;
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Codigo_Nemotecnico');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA');
    SQL.Add(' WHERE Codigo_Nemotecnico = :Nemotecnico');
    ParamByName('Nemotecnico').AsString := sNemotecnico;

    Open;
    if Not FieldByName('Codigo_Nemotecnico').IsNull then
       Existe_Nemotecnico_RF := True;

    Close
  end;
end;

function Existe_Gastos_en_Costos(sEmpresa : String) : Boolean;
begin
  Result := False;
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Empresa');
    SQL.Add('  FROM QS_FIN_GASTOS_EN_COSTO');
    SQL.Add(' WHERE Empresa = :Empresa');
    ParamByName('Empresa').AsString := sEmpresa;

    Open;
    if Not FieldByName('Empresa').IsNull then
       Result := True;

    Close
  end;
end;

function Existe_Moneda_Indice(sMoneda_Indice : String) : Boolean;
begin
  Existe_Moneda_Indice := False;
  with dmComunInversiones.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Cod_Moneda');
    SQL.Add('  FROM qs_sys_monedas');
    SQL.Add(' WHERE Cod_Moneda = :Cod_Moneda');
    ParamByName('Cod_Moneda').AsString := sMoneda_Indice;

    Open;
    if Not FieldByName('Cod_Moneda').IsNull then
       Existe_Moneda_Indice := True;

    Close
  end;
end;

Function  Existe_Folio_Item_Venta_Pendiente( sEmpresa ,
                                             sTransaccion,
                                             sFolio_Interno  : String
                                           ) : Boolean;
begin
  Result := False;
  WITH dmComunInversiones.Qry_General do
  begin
    { Lo cambie ya que no le encontre sentido a que se hiciera contra la tabla de detalle
      Ademas no estaba haciendo el join entre ambas tablas F.I. 22-09-2005
    SQL.Clear;
    SQL.Add(' SELECT a.Empresa'
           +' FROM  QS_TRA_OMD_DET_RF a'
           +'      ,QS_TRA_OMD d'
           +' WHERE a.Empresa       = :Empresa'
           +'   AND a.Transaccion   = :Transaccion'
           +'   AND a.Folio_Interno = :Folio_Interno'
           +'   AND a.Transaccion IN (SELECT b.Codigo_Transaccion'
           +'                            FROM qs_sys_tran_implic b '
           +'                         WHERE b.Codigo_transaccion = a.transaccion'
           +'                            AND b.implicancia = ''COMPV'''
           +'                         )'
           );
    }

    SQL.Clear;
    SQL.Add(' SELECT a.Empresa'
           +' FROM  QS_TRA_OMD a'
           +' WHERE a.Folio_Interno = :Folio_Interno'
           +'   AND a.Transaccion   = :Transaccion'
           +'   AND a.Empresa       = :Empresa'
           +'   AND a.Transaccion IN (SELECT b.Codigo_Transaccion'
           +'                            FROM qs_sys_tran_implic b '
           +'                         WHERE b.Codigo_transaccion = a.transaccion'
           +'                            AND b.implicancia = ''COMPV'''
           +'                         )'
           );
     ParamByName('Empresa').AsString       := sEmpresa;
     ParamByName('Transaccion').AsString   := sTransaccion;
     Parambyname('Folio_Interno').asString := sFolio_Interno;
     Open;

     if Not FieldByName('Empresa').IsNull then
        Result := True;
     Close;
  end;
end;//Determina nominales vendidos en Periodo

procedure Nominales_Mercado_RF(  sEmpresa
                            ,sCartera
                            ,sTransaccion
                            ,sFolio_Interno   : String;
                            fItem_Omd        : Double;
                            dFecha_Cierre    : Tdatetime;
                        var fNominales        : Double;
                        var bResult           : Boolean
                          );
begin
  fNominales := 0;
  bResult    := False;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT Valor_Nominal'
            +'      FROM QS_RES_MERCADO '
            +'      WHERE Fecha_Cierre  = :Fecha_Cierre'
            +'       AND  Item_Omd      = :Item_Omd'
            +'       AND  Folio_Interno = :Folio_Interno'
            +'       AND  Transaccion   = :Transaccion'
            +'       AND  Cartera       = :Cartera'
            +'       AND  Empresa       = :Empresa'
            );
     Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;
     Parambyname('Item_Omd').asFloat        := fItem_Omd;
     Parambyname('Folio_Interno').asString  := sFolio_Interno;
     Parambyname('Transaccion').asString    := sTransaccion;
     Parambyname('Cartera').asString        := sCartera;
     Parambyname('Empresa').asString        := sEmpresa;
     Open;

     if NOT Fieldbyname('Valor_Nominal').IsNull then
     begin
        fNominales := Fieldbyname('Valor_Nominal').asFloat;
        bResult    := True;
     end;

     Close;
  end;
end;


procedure Nominales_Mercado_RV( sEmpresa
                               ,sCartera
                               ,sNemotecnico : String;
                            dFecha_Cierre    : Tdatetime;
                        var fNominales       : Double;
                        var bResult          : Boolean
                          );
begin
  fNominales := 0;
  bResult    := False;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT CANTIDAD'
            +'      FROM QS_RES_VALORIZA_RV'
            +'      WHERE Fecha_Cierre  = :Fecha_Cierre'
            +'       AND  Nemotecnico   = :Nemotecnico'
            +'       AND  Cartera       = :Cartera'
            +'       AND  Empresa       = :Empresa'
            );
     Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;
     Parambyname('Nemotecnico').asString    := sNemotecnico;
     Parambyname('Cartera').asString        := sCartera;
     Parambyname('Empresa').asString        := sEmpresa;
     Open;

     if NOT Fieldbyname('CANTIDAD').IsNull then
     begin
        fNominales := Fieldbyname('CANTIDAD').asFloat;
        bResult    := True;
     end;

     Close;
  end;
end;

procedure Determina_FechaPrepago_Pacto( sEmpresa
                                  ,sTransaccion
                                  ,sFolio_Interno : String;
                               var dFecha_Prepago : Tdatetime;
                               var bResult         : Boolean
                                  );
begin
  bResult    := False;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT a.Fecha_Prepago'
            +'  FROM QS_TRA_OMD_PREPAGO a'
            +'  WHERE a.Empresa_Rel       = :Empresa'
            +'   AND  a.Transaccion_Rel   = :Transaccion'
            +'   AND  a.Folio_Interno_Rel = :Folio_Interno'
            +'   AND  a.folio_interno NOT in (SELECT e.folio'
                                     +'  FROM qs_ctr_anulacion e'
                                     +' WHERE e.folio       = a.folio_interno'
                                     +'   AND e.transaccion = a.transaccion'
                                     +'   AND e.empresa     = a.empresa)'
                                     );
     Parambyname('Empresa').asString        := sEmpresa;
     Parambyname('Transaccion').asString    := sTransaccion;
     Parambyname('Folio_Interno').asString  := sFolio_Interno;
     try
        Open;
     except
        Exit;
     end;

     if NOT Fieldbyname('Fecha_Prepago').IsNull then
     begin
        dFecha_Prepago := Fieldbyname('Fecha_Prepago').asDatetime;
        bResult    := True;
     end;
     Close;
  end;
end;

procedure Valor_Mercado_RV( sEmpresa
                           ,sCartera
                           ,sNemotecnico      : String;
                            dFecha_Cierre     : Tdatetime;
                        var fValor_Mercado_MC : Double;
                        var bResult           : Boolean
                          );
begin
  fValor_Mercado_MC := 0;
  bResult           := False;
  With dmComunInversiones.Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' SELECT Valor_Mercado_MC'
            +'      FROM QS_RES_VALORIZA_RV'
            +'      WHERE Fecha_Cierre  = :Fecha_Cierre'
            +'       AND  Nemotecnico   = :Nemotecnico'
            +'       AND  Cartera       = :Cartera'
            +'       AND  Empresa       = :Empresa'
            );
     Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;
     Parambyname('Nemotecnico').asString    := sNemotecnico;
     Parambyname('Cartera').asString        := sCartera;
     Parambyname('Empresa').asString        := sEmpresa;
     Open;

     if NOT Fieldbyname('Valor_Mercado_MC').IsNull then
     begin
        fValor_Mercado_MC := Fieldbyname('Valor_Mercado_MC').asFloat;
        bResult           := True;
     end;
     Close;
  end;
end;

Function Vencimientos_Al_Dia(dFecha_Desde:TdateTime;Array_Mem_Desarr : TArray_Mem_Desarr):Boolean;
Var i : integer;
Begin
   Vencimientos_Al_Dia := False;
   for i := 1 to Max_Nro_Cupones do
   Begin
      if Array_Mem_Desarr[i].Fecha_Vcto = dFecha_Desde Then
         Vencimientos_Al_Dia := True;
      if Array_Mem_Desarr[i].nro_cupon <> i Then
         exit;

      if Array_Mem_Desarr[i].Fecha_Vcto > dFecha_Desde  then
         Break;
   End;
End;

procedure Excluye_omd_ProyVctos( dFecha_Cierre : Tdatetime;
                                 sEmpresa
                                ,sTransaccion
                                ,sFolio_Interno  : String;
                                 fItem_omd       : Double;
                             var bResult         : Boolean);
begin

  WITH dmComunInversiones.QRY_General do
  begin
      SQL.Clear;
      SQL.Add(' SELECT a.Folio_Interno'
             +'   FROM QS_SUP_EXCLOMD_CALCE a'
             +'  WHERE a.Fecha_Cierre  = :Fecha_Cierre'
             +'    AND a.folio_interno = :folio_interno'
             +'    AND a.item_omd      = :item_omd'
             +'    AND a.transaccion   = :transaccion'
             +'    AND a.empresa       = :empresa'
             );
      ParamByname('Fecha_Cierre').AsDate     := dFecha_Cierre;
      ParamByname('folio_interno').asString  := Trim(sfolio_interno);
      ParamByname('transaccion').asString    := Trim(sTransaccion);
      ParamByname('empresa').asString        := Trim(sEmpresa);
      ParamByname('item_omd').asFloat        := fItem_omd;
      Open;

      bResult := True;
      If Fieldbyname('Folio_Interno').IsNull  then
         bResult := False;
      Close;
  end;
end;
//------------------------------------------------------------------------------
function Numero_Titulos(sEmpresa       : String;
                        sTransaccion   : String;
                        sFolio_Interno : String;
                        fItem_Omd      : Double) : Double;
begin
  With dmComunInversiones.Qry_Numero_Titulos do
    begin
//      F.I. 01-09-2020
//      SQL.Clear;
//      SQL.Add('SELECT Numero_Titulos');
//      SQL.Add('  FROM Qs_Tra_Omd_Det_PP');
//      SQL.Add(' WHERE Folio_Interno = :Folio_Interno');
//      SQL.Add('   AND Transaccion   = :Transaccion');
//      SQL.Add('   AND Item_Omd      = :Item_Omd');
//      SQL.Add('   AND Empresa       = :Empresa');

      ParamByName('Folio_Interno').AsString := sFolio_Interno;
      ParamByName('Transaccion').AsString   := sTransaccion;
      ParamByName('Item_Omd').AsFloat       := fItem_Omd;
      ParamByName('Empresa').AsString       := sEmpresa;

      //Prepare;
      Open;

      if FieldByName('Numero_Titulos').IsNull then
         Result := 0
      else
         Result := FieldByName('Numero_Titulos').AsFloat;

      Close;
      //UnPrepare;
    end;
end;

//------------------------------------------------------------------------------
Function Calcula_Tramo_Por_Mes(dFecha_Desde   : Tdatetime;
                               dFecha_Hasta   : Tdatetime) : Double;
Var
   //Fecha0, fecha1 : Tdatetime;
   aa_desde, aa_hasta, mm_desde, mm_hasta : Double;
begin
   dFecha_Desde := dFecha_Desde+1;
   aa_desde := strtofloat(copy(datetostr(dFecha_Desde),7,4));
   aa_hasta := strtofloat(copy(datetostr(dFecha_Hasta),7,4));
   mm_desde := strtofloat(copy(datetostr(dFecha_Desde),4,2));
   mm_hasta := strtofloat(copy(datetostr(dFecha_Hasta),4,2));
   Calcula_Tramo_Por_Mes :=  ((aa_hasta - aa_desde)*12) + ((mm_hasta - mm_desde)) + 1;
end;


Procedure busca_cuenta_analitica(dFecha_Compra          : TDateTime;
                                 dFecha_Cierre          : TDateTime;
                                 sFolio_Interno         : String;
                                 fItem_Omd              : Double;
                                 sTransaccion           : String;
                                 sCartera               : String;
                                 sEmpresa               : String;
                             var sCuenta_Analitica      : String);
var dFecha_Hasta :TDateTime;
    aa,mm,dd :Word;
begin
   Decodedate(dFecha_Compra,aa,mm,dd);
   dFecha_Hasta := Encodedate(aa, mm, ultimo_dia_mes( mm, aa));
   With dmComunInversiones.QRY_General do
   begin
      Sql.Clear;
      Sql.Add('select c.descripcion_nodo '
             +'  from qs_con_asiento         a '
             +'      ,qs_con_tipo_movimiento b '
             +'      ,qs_sys_est_cla         c '
             +' where a.fecha_cierre   between :fecha_desde and :fecha_hasta '
             +'   and a.folio_interno         = :folio_interno '
             +'   and a.item_omd              = :item_omd '
             +'   and a.transaccion           = :transaccion '
             +'   and a.cartera               = :cartera '
             +'   and a.empresa               = :empresa'
             +'   and a.cuenta                = b.cuenta '
             +'   and a.PLAN_CUENTA           = b.PLAN_CUENTA '
             +'   and (a.HECHO_ECON           = b.HECHO_ECON      or b.HECHO_ECON is null) '
             +'   and (a.COD_COLUMNA          = b.COLUMNA_PROCESO or b.COLUMNA_PROCESO is null) '
             +'   and (a.DEBE_HABER           = b.DEBE_HABER      or b.DEBE_HABER is null) '
             +'   and (a.CARTERA              = b.CARTERA         or b.CARTERA is null) '
             +'   and (a.EMPRESA              = b.EMPRESA         or b.EMPRESA is null)'
             +'   and b.FECHA_DESDE          <= :fecha_desde '
             +'   and (b.FECHA_HASTA IS NULL OR b.FECHA_HASTA >= :fecha_desde) '
             +'   and b.codigo_tom            = ''ANALITICA'' '
             +'   and c.codigo_objeto         = a.plan_cuenta '
             +'   and c.nodo                  = a.cuenta '
             );
      ParamByName('fecha_desde').AsDate           := dFecha_Compra;
      ParamByName('fecha_hasta').AsDate           := dFecha_Cierre; //dFecha_Hasta;
      Parambyname('folio_interno').asString           := sFolio_Interno;
      Parambyname('item_omd').asFloat                 := fItem_Omd;
      Parambyname('transaccion').asString             := sTransaccion;
      Parambyname('cartera').asString                 := sCartera;
      Parambyname('empresa').asString                 := sEmpresa;
      Open;
      if not Eof then
         if not Obtiene_Cuenta(FieldByName('descripcion_nodo').AsString, sCuenta_Analitica) then
            sCuenta_Analitica := '';
      Close;
   end;
end;

Procedure busca_cuenta_analitica_new(dFecha_Cierre     : TDateTime;
                                     sCod_Contab       : String;
                                     sTipo_Oper        : String;
                                     sProceso          : String;
                                     sOperacion        : String;
                                     sEmpresa          : String;
                                     sCartera          : String;
                                     sMotivo_Inversion : String;
                                     sMotivo_OMD       : String;
                                     sFolio_Interno    : String;
                                     sNemotecnico      : String;
                                     sEmisor           : String;
                                     sInstrumento      : String;
                                     sMoneda_Instrum   : String;
                                     sCustodia         : String;
                                     sContraparte      : String;
                                     sClasif_Contab    : String;
                                 var sCuenta_Analitica : String);
var Qry1, Qry2, Qry3: TFDQuery;
    sWhere_Part     :String;
    iPaso           :Integer;
    bEncontro       :Boolean;
    sCodigo_HC      :String;
    sMotivo         :String;
begin

   Qry1 := TFDQuery.Create(Application);
   Qry2 := TFDQuery.Create(Application);
   Qry3 := TFDQuery.Create(Application);
   Qry1.Connection := dmBaseDatos.Conexion_BaseDatos;
   Qry1.ConnectionName := 'PMSSERVER';
   Qry2.Connection := dmBaseDatos.Conexion_BaseDatos;
   Qry2.ConnectionName := 'PMSSERVER';
   Qry3.Connection := dmBaseDatos.Conexion_BaseDatos;
   Qry3.ConnectionName := 'PMSSERVER';

   // Busca Motivo inversion
   if Trim(sMotivo_Inversion) = '' then
   begin
     if NOT transaccion_implica_mem(sOperacion,'RV') then
        sMotivo := Busca_Motivo(sEmpresa
                               ,'' //Cartera
                               ,sOperacion
                               ,sFolio_Interno
                               ,0 // Item
                               ,dFecha_Cierre)
     else
        sMotivo := Busca_Motivo_Inversion_RV(sEmpresa
                                            ,sCartera
                                            ,'CRV'
                                            ,sNemotecnico
                                            ,dFecha_Cierre
                                            ,False);
   end
   else
      sMotivo := sMotivo_Inversion;

   // Con cartera ...
   // Paso 1 Motivo_OMD + Motivo Inversion + Cartera
   // Paso 2 SIN Motivo_OMD | Motivo Inversion + Cartera
   // Paso 3 Motivo_Omd | SIN Motivo Inversion | Cartera
   // Paso 4 SIN Motivo_OMD SIN Motivo Inversion | Cartera
   /// Sin Cartera ....
   // Paso 5 Motivo_OMD + Motivo Inversion SIN Cartera
   // Paso 6 SIN Motivo_OMD | Motivo Inversion SIN  Cartera
   // Paso 7 Motivo_Omd | SIN Motivo Inversion SIN Cartera
   // Paso 8 SIN Motivo_OMD SIN Motivo Inversion SIN Cartera

   // Revisa pasos
   iPaso := 1;
   while iPaso <= 8 do
   begin

      if iPaso = 1 then
         if (sMotivo <> '') and
            (sMotivo_OMD <> '') then
             sWhere_Part := 'AND Cartera = '''+ trim(sCartera) +''''
                          +' AND Motivo_Inversion = '''+ sMotivo+''''
                          +' AND Motivo_OMD = '''+ sMotivo_OMD+''''
         else
            begin
              Inc(iPaso);
              Continue;
            end;

      if iPaso = 2 then
         if (sMotivo <> '') then
             sWhere_Part := 'AND Cartera = '''+ trim(sCartera)+''''
                          +' AND Motivo_Inversion = '''+ sMotivo+''''
                          +' AND MOTIVO_OMD IS NULL'
         else
            begin
              Inc(iPaso);
              Continue;
            end;

      if iPaso = 3 then
         if (sMotivo_OMD <> '') then
             sWhere_Part := 'AND Cartera = '''+ trim(sCartera)+''''
                          +' AND Motivo_Inversion IS NULL'
                          +' AND MOTIVO_OMD = '''+ sMotivo_OMD+''''
         else
            begin
              Inc(iPaso);
              Continue;
            end;

      if iPaso = 4 then
         sWhere_Part := ' AND Cartera = '''+ trim(sCartera)+''''
                          +' AND Motivo_Inversion IS NULL'
                          +' AND MOTIVO_OMD       IS NULL';

      if iPaso = 5 then
         if (sMotivo <> '') and
            (sMotivo_OMD <> '') then
             sWhere_Part := 'AND Cartera IS NULL'
                          +' AND Motivo_Inversion = '''+ sMotivo+''''
                          +' AND Motivo_OMD = '''+ sMotivo_OMD+''''
         else
            begin
              Inc(iPaso);
              Continue;
            end;

      if iPaso = 6 then
         if (sMotivo <> '') then
             sWhere_Part := 'AND Cartera IS NULL'
                          +' AND Motivo_Inversion = '''+ sMotivo+''''
                          +' AND MOTIVO_OMD IS NULL'
         else
            begin
              Inc(iPaso);
              Continue;
            end;

      if iPaso = 7 then
         if (sMotivo_OMD <> '') then
             sWhere_Part := 'AND Cartera IS NULL'
                          +' AND Motivo_Inversion IS NULL'
                          +' AND MOTIVO_OMD = '''+ sMotivo_OMD+''''
         else
            begin
              Inc(iPaso);
              Continue;
            end;

      if iPaso = 8 then
         sWhere_Part := ' AND Cartera  IS NULL'
                       +' AND Motivo_Inversion IS NULL'
                       +' AND MOTIVO_OMD       IS NULL';

      with Qry1 do
      begin
         // Busco en la tabla master de enlaces por las condiciones de Paso 1 2, etc.
         // Si no existe no puede existir en el resto de las tablas
      //   DataBaseName := 'PMSSERVER';
         Close;
         SQL.Clear;
         SQL.Add('SELECT COUNT(*) AS NumRegs  ');
         SQL.Add('  FROM QS_CON_ENLACE        ');
         SQL.Add(' WHERE Cod_contabilidad = :Cod_Contab ');
         SQL.Add('   AND Tipo_operacion   = :Tipo_Oper ');
         SQL.Add('   AND proceso          = :Proceso ');
         SQL.Add('   AND operacion        = :Operacion ');
         SQL.Add( sWhere_Part);
         ParamByName('Cod_Contab').AsString   := sCod_Contab;
         ParamByName('Tipo_Oper' ).AsString   := sTipo_Oper;
         ParamByName('Proceso'   ).AsString   := sProceso;
         ParamByName('Operacion' ).AsString   := sOperacion;
         Open;
         if FieldByName('NumRegs').AsInteger = 0 then
         begin
           Close;
           Inc(iPaso);
           Continue;
         end;
         Close;

         bEncontro := False;
         //=========================================
         // POR NEMOTECNICO
         //=========================================
         if (sNemotecnico <> '') then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_NEMOTEC  ');
            SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND NEMOTECNICO      = :NEMOTECNICO');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
            ParamByName('Proceso'     ).AsString   := sProceso;
            ParamByName('Operacion'   ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
            ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC   := FieldByName('Hecho_Econ').AsString;
               bEncontro    := True;
            end;
         end;

         //=========================================
         // POR EMISOR - INSTRUMENTO - MONEDA INSTRUM
         //=========================================
         if (sEmisor <> '')      and
            (sInstrumento <> '') and
            (sMoneda_Instrum <> '') and
             NOT (bEncontro)  then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_EMISOR  ');
            SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND Emisor      = :Emisor');
            SQL.Add('  AND Instrumento = :Instrumento');
            SQL.Add('  AND Moneda_Instrum = :Moneda_Instrum');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'    ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'     ).AsString   := sTipo_Oper;
            ParamByName('Proceso'       ).AsString   := sProceso;
            ParamByName('Operacion'     ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre'  ).AsDate := dFecha_Cierre;
            ParamByName('Emisor'        ).AsString   := sEmisor;
            ParamByName('Instrumento'   ).AsString   := sInstrumento;
            ParamByName('Moneda_Instrum').AsString   := sMoneda_Instrum;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //=========================================
         // POR EMISOR - INSTRUMENTO
         //=========================================
         if (sEmisor <> '')      and
            (sInstrumento <> '') and
             NOT (bEncontro)  then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_EMISOR  ');
            SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND Emisor      = :Emisor');
            SQL.Add('  AND Instrumento = :Instrumento');
            SQL.Add('  AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
            ParamByName('Proceso'     ).AsString   := sProceso;
            ParamByName('Operacion'   ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
            ParamByName('Emisor'      ).AsString   := sEmisor;
            ParamByName('Instrumento' ).AsString   := sInstrumento;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //=========================================
         // POR EMISOR - MONEDA
         //=========================================
         if (sEmisor <> '')      and
            (sMoneda_Instrum <> '') and
             NOT (bEncontro)  then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_EMISOR  ');
            SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND Emisor      = :Emisor');
            SQL.Add('  AND (Instrumento IS NULL OR Instrumento = '''')');
            SQL.Add('  AND Moneda_Instrum = :Moneda_Instrum');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
            ParamByName('Proceso'     ).AsString   := sProceso;
            ParamByName('Operacion'   ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
            ParamByName('Emisor'      ).AsString   := sEmisor;
            ParamByName('Moneda_Instrum').AsString := sMoneda_Instrum;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //=========================================
         // POR EMISOR
         //=========================================
         if (sEmisor <> '')    and
            NOT (bEncontro) then
         begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT * FROM QS_CON_ENL_EMISOR  ');
           SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
           SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
           SQL.Add('  AND proceso          = :Proceso   ');
           SQL.Add('  AND operacion        = :Operacion ');
           SQL.Add( sWhere_Part);
           SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
           SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
           SQL.Add('  AND Emisor = :Emisor');
           SQL.Add('  AND (Instrumento IS NULL OR Instrumento = '''')');
           SQL.Add('  AND (Moneda_Instrum IS NULL OR Moneda_Instrum = '''')');
           SQL.Add(' ORDER BY Hecho_Econ');
           ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
           ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
           ParamByName('Proceso'     ).AsString   := sProceso;
           ParamByName('Operacion'   ).AsString   := sOperacion;
           ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
           ParamByName('Emisor'      ).AsString   := sEmisor;
           Open;
           sCodigo_HC := '';
           if not FieldByName('Hecho_Econ').IsNull then
           begin
              sCodigo_HC := FieldByName('Hecho_Econ').AsString;
              bEncontro  := True;
           end;
         end;

         //=========================================
         // POR CUSTODIA - INSTRUMENTO.
         //=========================================
         if (sCustodia <> '')    and
            (sInstrumento <> '') and
            (not bEncontro)   then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_IDENTIDAD  ');
            SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND Identidad   = :Custodia');
            SQL.Add('  AND Instrumento = :Instrumento');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
            ParamByName('Proceso'     ).AsString   := sProceso;
            ParamByName('Operacion'   ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
            ParamByName('Custodia'    ).AsString   := sCustodia;
            ParamByName('Instrumento' ).AsString   := sInstrumento;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //=========================================
         // POR CUSTODIA
         //=========================================
         if (sCustodia <> '')    and
            (not bEncontro)   then
         begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT * FROM QS_CON_ENL_IDENTIDAD  ');
           SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
           SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
           SQL.Add('  AND proceso          = :Proceso   ');
           SQL.Add('  AND operacion        = :Operacion ');
           SQL.Add( sWhere_Part);
           SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
           SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
           SQL.Add('  AND Identidad = :Custodia');
           SQL.Add('  AND (Instrumento IS NULL OR Instrumento = '''')');
           SQL.Add(' ORDER BY Hecho_Econ');
           ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
           ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
           ParamByName('Proceso'     ).AsString   := sProceso;
           ParamByName('Operacion'   ).AsString   := sOperacion;
           ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
           ParamByName('Custodia'    ).AsString   := sCustodia;
           Open;
           sCodigo_HC := '';
           if not FieldByName('Hecho_Econ').IsNull then
           begin
              sCodigo_HC := FieldByName('Hecho_Econ').AsString;
              bEncontro  := True;
           end;
         end;

         //=========================================
         // POR CONTRAPARTE - INSTRUMENTO
         //=========================================
         if (sContraparte <> '') and
            (sInstrumento <> '') and
            (not bEncontro)   then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_CONTRA  ');
            SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND Contraparte = :Contraparte');
            SQL.Add('  AND Instrumento = :Instrumento');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
            ParamByName('Proceso'     ).AsString   := sProceso;
            ParamByName('Operacion'   ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
            ParamByName('Instrumento' ).AsString   := sInstrumento;
            ParamByName('Contraparte' ).AsString   := sContraparte;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //=========================================
         // POR CONTRAPARTE
         //=========================================
         if (sContraparte <> '') and
            (not bEncontro)   then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_CONTRA');
            SQL.Add('WHERE Cod_Contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND Contraparte = :Contraparte');
            SQL.Add('  AND (Instrumento IS NULL OR Instrumento = '''')');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'  ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'   ).AsString   := sTipo_Oper;
            ParamByName('Proceso'     ).AsString   := sProceso;
            ParamByName('Operacion'   ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
            ParamByName('Contraparte' ).AsString   := sContraparte;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //----------------------------------------------
         //-------------> POR INSTRUMENTO <--------------
         //----------------------------------------------
         if (sInstrumento <> '') and
            (not bEncontro)   then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_INSTRUM');
            SQL.Add('WHERE Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND proceso          = :Proceso   ');
            SQL.Add('  AND Operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND Instrumento = :Instrumento');
            SQL.Add('  AND (moneda_instrum IS NULL OR moneda_instrum = :moneda_instrum)');
            SQL.Add(' ORDER BY Hecho_Econ');
            ParamByName('Cod_Contab'  ).AsString    := sCod_Contab;
            ParamByName('Tipo_Oper'   ).AsString    := sTipo_Oper;
            ParamByName('Proceso'     ).AsString    := sProceso;
            ParamByName('Operacion'   ).AsString    := sOperacion;
            ParamByName('Fecha_Cierre').AsDate  := dFecha_Cierre;
            ParamByName('Instrumento' ).AsString    := sInstrumento;
            ParamByName('moneda_instrum' ).AsString := sMoneda_Instrum;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //-------------------------------------------------------------
         //------------> POR CLASIFICACION NEMOTECNICO RF <-------------
         //-------------------------------------------------------------
         if (sNemotecnico <> '') and
            (not bEncontro) then
         begin
            Close;
      //      DataBaseName := 'PMSSERVER';
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_CLASIF a, QS_SYS_CLASIF_OBJ b');
            SQL.Add('WHERE a.Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND a.Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND a.Proceso          = :Proceso   ');
            SQL.Add('  AND a.Operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND a.Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND a.Codigo_Clasif = :Codigo_Clasif');
            SQL.Add('  AND a.Codigo_Clasif = b.Codigo_Clasif');
            SQL.Add('  AND a.Clasificacion = b.Nodo');
            SQL.Add('  AND b.Elemento      = :Nemotecnico');
            SQL.Add('  AND b.Objeto        = ''NEMOTECNIC''');
            SQL.Add(' ORDER BY a.Hecho_Econ');
            ParamByName('Cod_Contab'   ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'    ).AsString   := sTipo_Oper;
            ParamByName('Proceso'      ).AsString   := sProceso;
            ParamByName('Operacion'    ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre' ).AsDate := dFecha_Cierre;
            ParamByName('Nemotecnico'  ).AsString   := sNemotecnico;
            ParamByName('Codigo_Clasif').AsString   := sClasif_Contab;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //-------------------------------------------------------------
         //------------> POR CLASIFICACION NEMOTECNICO RV <-------------
         //-------------------------------------------------------------
         if (sNemotecnico <> '') and
            (not bEncontro) then
         begin
            Close;
        //    DataBaseName := 'PMSSERVER';
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_CLASIF a, QS_SYS_CLASIF_OBJ b');
            SQL.Add('WHERE a.Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND a.Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND a.Proceso          = :Proceso   ');
            SQL.Add('  AND a.Operacion        = :Operacion ');
            SQL.Add( sWhere_Part);
            SQL.Add('  AND a.Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND a.Codigo_Clasif = :Codigo_Clasif');
            SQL.Add('  AND a.Codigo_Clasif = b.Codigo_Clasif');
            SQL.Add('  AND a.Clasificacion = b.Nodo');
            SQL.Add('  AND b.Elemento      = :Nemotecnico');
            SQL.Add('  AND b.Objeto        = ''NEMRVAR''');
            SQL.Add(' ORDER BY a.Hecho_Econ');
            ParamByName('Cod_Contab'   ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'    ).AsString   := sTipo_Oper;
            ParamByName('Proceso'      ).AsString   := sProceso;
            ParamByName('Operacion'    ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre' ).AsDate := dFecha_Cierre;
            ParamByName('Nemotecnico'  ).AsString   := sNemotecnico;
            ParamByName('Codigo_Clasif').AsString   := sClasif_Contab;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;

         //----------------------------------------------------------
         //------------> POR CLASIFICACION INSTRUMENTO <-------------
         //----------------------------------------------------------
         if (sInstrumento <> '') and
            (not bEncontro) then
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM QS_CON_ENL_CLASIF a, QS_SYS_CLASIF_OBJ b');
            SQL.Add('WHERE a.Cod_contabilidad = :Cod_Contab');
            SQL.Add('  AND a.Tipo_operacion   = :Tipo_Oper ');
            SQL.Add('  AND a.Proceso          = :Proceso   ');
            SQL.Add('  AND a.Operacion        = :Operacion ');
            SQL.Add(   sWhere_Part);
            SQL.Add('  AND a.Fecha_Desde <= :Fecha_Cierre  ');
            SQL.Add('  AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha_Cierre)');
            SQL.Add('  AND a.Codigo_Clasif = :Codigo_Clasif');
            SQL.Add('  AND a.Codigo_Clasif = b.Codigo_Clasif');
            SQL.Add('  AND a.Clasificacion = b.Nodo');
            SQL.Add('  AND b.Elemento = :Instrumento');
            SQL.Add('  AND b.Objeto = ''INSTRUM''');
            SQL.Add(' ORDER BY a.Hecho_Econ');
            ParamByName('Cod_Contab'   ).AsString   := sCod_Contab;
            ParamByName('Tipo_Oper'    ).AsString   := sTipo_Oper;
            ParamByName('Proceso'      ).AsString   := sProceso;
            ParamByName('Operacion'    ).AsString   := sOperacion;
            ParamByName('Fecha_Cierre' ).AsDate := dFecha_Cierre;
            ParamByName('Instrumento'  ).AsString   := sInstrumento;
            ParamByName('Codigo_Clasif').AsString   := sClasif_Contab;
            Open;
            sCodigo_HC := '';
            if not FieldByName('Hecho_Econ').IsNull then
            begin
               sCodigo_HC := FieldByName('Hecho_Econ').AsString;
               bEncontro  := True;
            end;
         end;
         // Por cada enlace contable.
         while not Qry1.Eof do // (Qry1)
         begin
        //    Qry2.DataBaseName := 'PMSSERVER';
            Qry2.Close;
            Qry2.SQL.Clear;
            Qry2.SQL.Add('SELECT * ');
            Qry2.SQL.Add('  FROM QS_CON_H_ECON_DET');
            Qry2.SQL.Add(' WHERE Hecho_Econ = :Hecho_Econ');
            if sDriver = 'ORACLE' then
               Qry2.SQL.Add('ORDER BY Ajuste DESC')
            else
               Qry2.SQL.Add('ORDER BY Ajuste');
            Qry2.ParamByName('Hecho_Econ').AsString := Qry1.FieldByName('Hecho_Econ').AsString;
            Qry2.Open;
            // Busca Cuenta por Cuenta.
            while not Qry2.EOF do // Qry2
            begin
               With Qry3 do
               begin
             //     DataBaseName := 'PMSSERVER';
                  Qry3.Close;
                  Qry3.Sql.Clear;
                  Qry3.Sql.Add('select c.descripcion_nodo '
                         +'  from qs_con_tipo_movimiento b '
                         +'      ,qs_sys_est_cla         c '
                         +' where b.cuenta                = :cuenta '
                         +'   and b.Plan_Cuenta           = :Plan_Cuenta '
                         +'   and b.HECHO_ECON            is null '
                         +'   and b.COLUMNA_PROCESO       is null '
                         +'   and b.DEBE_HABER            is null '
                         +'   and b.CARTERA               is null '
                         +'   and b.EMPRESA               = :EMPRESA'
                         +'   and b.FECHA_DESDE          <= :Fecha_Cierre '
                         +'   and (b.FECHA_HASTA IS NULL OR b.FECHA_HASTA >= :Fecha_Cierre) '
                         +'   and b.codigo_tom            = ''ANALITICA'' '
                         +'   and c.codigo_objeto         = b.plan_cuenta '
                         +'   and c.nodo                  = b.cuenta ');
                  Parambyname('cuenta').AsFloat          := Qry2.FieldByName('Cuenta').AsFloat;
                  Parambyname('Plan_Cuenta').asString    := Qry2.FieldByName('Plan_Cuenta').AsString;
                  Parambyname('empresa').asString        := sEmpresa;
                  ParamByName('Fecha_Cierre').AsDate := dFecha_Cierre;
                  Qry3.Open;
                  if not Qry3.Eof then
                     if not Obtiene_Cuenta(Qry3.FieldByName('descripcion_nodo').AsString, sCuenta_Analitica) then
                        sCuenta_Analitica := ''
                     else
                     begin
                        iPaso := 9;
                        Qry3.Close;   //DC
                        Break;
                     end;
                  Qry3.Close;             //DC
               end;
               if iPaso = 9 then
               begin
                 Qry2.Close;
                 Break;
               end;
               Qry2.Next;
            end;
            Qry2.Close;
            if iPaso = 9 then
            begin
              Qry1.Close;
              Break;
            end;
            Qry1.Next;
         end;  // while not Eof do
         Qry1.Close;
      end; // with qry1
      Inc(iPaso);
   end; // While True
   Qry1.Close;
   Qry2.Close;
   Qry3.Close;
   Qry1.Free;
   Qry2.Free;
   Qry3.Free;

end;

Procedure Elegible_1041(sInstrumento  : String;
                        codigo_clasif : String;
                        var sElegible : String);
begin

  with dmComunInversiones.QRY_General do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT b.DESCRIPCION_NODO'
           +'  FROM QS_SYS_CLASIF_OBJ a'
           +'      ,QS_SYS_EST_CLA b '
           +' WHERE a.objeto        = :ObjetoIns'
           +'   AND a.codigo_clasif = :ClasifIns'
           +'   AND a.elemento      = :Instrumento'
           +'   AND b.CODIGO_OBJETO = a.CODIGO_CLASIF  '
           +'   AND b.NODO = a.NODO ' );

    ParamByName('ObjetoIns').AsString    := 'INSTRUM';
    ParamByName('ClasifIns').AsString    := codigo_clasif;
    ParamByName('Instrumento').AsString  := sInstrumento;

    Open;

    if not Obtiene_Cuenta(FieldByName('descripcion_nodo').AsString, sElegible) then
       sElegible := 'IEA';

    Close;
  end;

end;

function Obtiene_ItemClasif( sDesc_Cuenta: string; var sNum_Cta: string ): boolean;
var iPos_Guion : integer;
begin

   iPos_Guion  := Pos(')', sDesc_Cuenta) - 1;

   if iPos_Guion = -1 then
   begin
      Result := False;
      Exit;
   end;

   sNum_Cta := Copy( sDesc_Cuenta, 1, iPos_Guion);

   Result := True;
end;

function Obtiene_Cuenta( sDesc_Cuenta: string; var sNum_Cta: string ): boolean;
var iSeparador
   ,iPos_Guion
   ,iPos_Blanco
   ,iPos_Under: integer;
begin

   iPos_Guion  := Pos('-', sDesc_Cuenta) - 1;
   iPos_Blanco := Pos(' ', sDesc_Cuenta) - 1;
   iPos_Under  := Pos('_', sDesc_Cuenta) - 1;

   if iPos_Guion = -1 then
      iPos_Guion := 120;
   if iPos_Blanco = -1 then
      iPos_Blanco := 120;
   if iPos_Under = -1 then
      iPos_Under := 120;

   if (iPos_Guion < iPos_Blanco)and
      (iPos_Guion > 0          )then
      iSeparador := iPos_Guion
   else
      if (iPos_Under < iPos_Blanco)and
         (iPos_Under > 0          )then
         iSeparador := iPos_Under
      else
         iSeparador := iPos_Blanco;

   if iSeparador = -1 then
   begin
      Result := False;
      Exit;
   end;

   sNum_Cta := Copy( sDesc_Cuenta, 1, iSeparador);

   Result := True;
end;

procedure Obtiene_Cuenta_Contable( sCuenta: string; var sCtaSinPunto: string );
var i        : integer;
    sStr_nro : String;
begin
  i            := 1;
  sStr_nro     := '0123456789';

  sCtaSinPunto := '';
  while i <= length(sCuenta) do
  begin
    if pos(Copy(sCuenta,i,1),sStr_nro) > 0 then
        sCtaSinPunto := sCtaSinPunto+Copy(sCuenta,i,1);

    i := i + 1;
  end;
end;

function Obtiene_Descripcion_Cuenta( sDesc_Cuenta: string; var sDescripcion_Cta: string ): boolean;
var iSeparador
   ,iPos_Guion
   ,iPos_Blanco
   ,iPos_Under : integer;
begin

   iPos_Guion  := Pos('-', sDesc_Cuenta) - 1;
   iPos_Blanco := Pos(' ', sDesc_Cuenta) - 1;
   iPos_Under  := Pos('_', sDesc_Cuenta) - 1;

   if iPos_Guion = -1 then
      iPos_Guion := 120;
   if iPos_Blanco = -1 then
      iPos_Blanco := 120;
   if iPos_Under = -1 then
      iPos_Under := 120;

   if (iPos_Guion < iPos_Blanco)and
      (iPos_Guion > 0          )then
      iSeparador := iPos_Guion
   else
      if (iPos_Under < iPos_Blanco)and
         (iPos_Under > 0          )then
         iSeparador := iPos_Under
      else
         iSeparador := iPos_Blanco;

   if iSeparador = -1 then
   begin
      Result := False;
      Exit;
   end;

   sDescripcion_Cta := Copy( sDesc_Cuenta, iSeparador+2, 120);

   Result := True;
end;

function Obtiene_Cuenta_String( sDesc_Cuenta: string; var sNum_Cta: string ): boolean;
var iSeparador
   ,iPos_Guion
   ,iPos_Blanco
   ,iPos_Under : integer;
begin

   iPos_Guion  := Pos('-', sDesc_Cuenta) - 1;
   iPos_Blanco := Pos(' ', sDesc_Cuenta) - 1;
   iPos_Under  := Pos('_', sDesc_Cuenta) - 1;

   if iPos_Guion = -1 then
      iPos_Guion := 120;
   if iPos_Blanco = -1 then
      iPos_Blanco := 120;
   if iPos_Under = -1 then
      iPos_Under := 120;

   if (iPos_Guion < iPos_Blanco)and
      (iPos_Guion > 0          )then
      iSeparador := iPos_Guion
   else
      if (iPos_Under < iPos_Blanco)and
         (iPos_Under > 0          )then
         iSeparador := iPos_Under
      else
         iSeparador := iPos_Blanco;


   if iSeparador = -1 then
   begin
      Result := False;
      Exit;
   end;

   sNum_Cta := Copy( sDesc_Cuenta, iSeparador+1, length(sDesc_Cuenta)-1);

   Result := True;
end;

function Valida_Limites_Transaccion(sTipo_Llamada     : String;
                                    sEmpresa          : String;
                                    sCartera          : String;
                                    sMoneda_Operacion : String;
                                    sTransaccion      : String;
                                    sFolio_Interno    : String;
                                    sOperador         : String;
                                    dFecha_Operacion  : TDateTime;
                                    sContraparte      : String;
                                    sPerfil           : String;
                                    Tabla_Detalle     : TFDMemTable):Boolean;
var
    sTipo_Instrum      : String;
    sLogin_Supervisor  : String;
    sPerfil_Supervisor : String;
    bSalir             : Boolean;
    bTiene_Limites     : Boolean;
    fMonto_a_Aprobar   : Double;
begin
   Result := True;

//   Tbl_Excedido := TFDMemTable.Create(Application.Owner);
   with DmComunInversiones.Tbl_Excedido do
   begin
      with FieldDefs do
      begin
         Clear;
         Add('tipo'              ,ftString , 10, False);
         Add('codigo_tipo'       ,ftString , 10, False);
         Add('limite'            ,ftString ,250, False);
         Add('codigo'            ,ftString , 30, False);
         Add('descripcion'       ,ftString , 60, False);
         Add('monto_limite'      ,ftFloat  ,  0, False);
         Add('monto_operacion'   ,ftFloat  ,  0, False);
         Add('monto_transado'    ,ftFloat  ,  0, False);
         Add('monto_excedido'    ,ftFloat  ,  0, False);
      end;
      active := True;
      Open;
   end;

   DmComunInversiones.FDLocalSQL1.Active := true;

   with DmComunInversiones.Qry_Paradox2 do
   begin

      // limites a nivel de operacion
      Sql.Clear;
      Sql.Add('SELECT SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle.Name);
      Open;
      while not eof do
      begin
          Valida_Limite_Operacion(sEmpresa
                                 ,sMoneda_Operacion
                                 ,dFecha_Operacion
                                 ,sTransaccion
                                 ,sFolio_Interno
                                 ,sCartera
                                 ,sOperador
                                 ,FieldByName('Valor_Invertido_MC').asFloat);

          Valida_Limite_Cartera(sEmpresa
                               ,sMoneda_Operacion
                               ,dFecha_Operacion
                               ,sTransaccion
                               ,sFolio_Interno
                               ,sCartera
                               ,sOperador
                               ,FieldByName('Valor_Invertido_MC').asFloat);

          Valida_Limite_Contraparte(sEmpresa
                                   ,sMoneda_Operacion
                                   ,dFecha_Operacion
                                   ,sTransaccion
                                   ,sFolio_Interno
                                   ,sCartera
                                   ,sOperador
                                   ,sContraparte
                                   ,FieldByName('Valor_Invertido_MC').asFloat);
        Next;
      end;
      Close;

      // limites a nivel de instrumento
      Sql.Clear;
      Sql.Add('SELECT Instrumento '
             +'      ,SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle.Name
             +' GROUP BY Instrumento');
      Open;
      while not eof do
      begin
          Valida_Limite_Clasificacion(sEmpresa
                                     ,sMoneda_Operacion
                                     ,dFecha_Operacion
                                     ,sTransaccion
                                     ,sFolio_Interno
                                     ,sCartera
                                     ,sOperador
                                     ,FieldByName('Instrumento').asString);

          Valida_Limite_Instrumento(sEmpresa
                                   ,sMoneda_Operacion
                                   ,dFecha_Operacion
                                   ,sTransaccion
                                   ,sFolio_Interno
                                   ,sCartera
                                   ,sOperador
                                   ,FieldByName('Instrumento').asString);
        Next;
      end;
      Close;

      // limites a nivel de emisor
      Sql.Clear;
      Sql.Add('SELECT Emisor '
             +'      ,SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle.Name
             +' GROUP BY Emisor');
      Open;
      while not eof do
      begin
          Valida_Limite_Emisor(sEmpresa
                              ,sMoneda_Operacion
                              ,dFecha_Operacion
                              ,sTransaccion
                              ,sFolio_Interno
                              ,sCartera
                              ,sOperador
                              ,FieldByName('Emisor').asString
                              ,FieldByName('Valor_Invertido_MC').asFloat);
        Next;
      end;
      Close;

      // limites a nivel de perfil
      Sql.Clear;
      Sql.Add('SELECT Tipo_Instrum '
             +'      ,Instrumento '
             +'      ,Moneda_Instrum '
             +'      ,Tipo_Cambio '
             +'      ,SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle.Name
             +' GROUP BY Tipo_Instrum, Instrumento, Moneda_Instrum, Tipo_Cambio');
      Open;
      while not eof do
      begin
         if Leer_Tipo_Instrumento(FieldByName('Instrumento').asString
                                 ,sTipo_Instrum) then
            if sTipo_llamada = 'A' then
               fMonto_a_Aprobar := Busca_Monto_excedido(sEmpresa
                                                       ,sTransaccion
                                                       ,sFolio_Interno)
            else
               fMonto_a_Aprobar := FieldByName('Valor_Invertido_MC').asFloat;
            if Valida_Limite_Perfil(sEmpresa
                                   ,sMoneda_Operacion
                                   ,dFecha_Operacion
                                   ,sTransaccion
                                   ,sFolio_Interno
                                   ,sCartera
                                   ,sTipo_Instrum
                                   ,FieldByName('Instrumento').asString
                                   ,FieldByName('Moneda_Instrum').asString
                                   ,FieldByName('Tipo_Cambio').asFloat
                                   ,sPerfil
                                   ,fMonto_a_Aprobar) then //FieldByName('Valor_Invertido_MC').asFloat)then
               bTiene_Limites := true
            else
            begin
               bTiene_Limites := false;
               Exedio_Limite('D'
                            ,'DEFINICION'
                            ,'NO TIENE LIMITES DEFINIDOS PARA EL PERFIL DEL USUARIO'
                            ,sPerfil
                            ,'PERFIL '''+sPerfil+''''
                            ,0
                            ,0
                            ,0
                            ,0);  // Monto Excedido
            end;
         Next;
      end;
      Close;

   end;

   // Si excedio Limites despliega ventana para autorizacion
   if DmComunInversiones.Tbl_Excedido.RecordCount > 0 then
   begin
      if bTiene_Limites then
      begin
         if sTipo_llamada = 'O' then
            Application.MessageBox('¡Usted ha Excedido los Limites definidos para su Perfil!'
                                  ,'Verificación de Limites'
                                  , mb_OK+ Mb_IconError)
         else
            Application.MessageBox('¡Supervisor ha Excedido los Limites definidos para su Perfil!'
                                  ,'Verificación de Limites'
                                  , mb_OK+ Mb_IconError);
      end
      else
      begin
         if sTipo_llamada = 'O' then
            Application.MessageBox(pchar('¡No se han definido Limites para Perfil '''+sPerfil+'''!'+#10+'Operacion debe ser aprobada por un Supervisor.')
                                  ,'Verificación de Limites'
                                  ,mb_OK+ Mb_IconError)
         else
            Application.MessageBox(pchar('¡No se han definido Limites para Perfil '''+sPerfil+'''!'#10+'No puede aprobar Operacion.')
                                  ,'Verificación de Limites'
                                  ,mb_OK+ Mb_IconError);
      end;

      while not bSalir do
      begin

         if Not Aprueba_Limites(sTipo_llamada
                               ,DmComunInversiones.Tbl_Excedido.Name
                               ,sEmpresa
                               ,sOperador
                               ,sMoneda_Operacion
                               ,sTransaccion
                               ,sFolio_Interno
                               ,sLogin_Supervisor) then
         begin
            bSalir := True;
            Result := False;
         end
         else
         begin
            bSalir := False;
            // busca perfil supervisor
            with DmComunInversiones.QRY_General do
            begin
               SQL.Clear;
               SQL.Add('SELECT a.perfil '
                      +'  FROM QS_SYS_LOGIN a '
                      +' WHERE a.Login_sistema = :Login_sistema ');
               ParamByName('Login_sistema').asString := sLogin_Supervisor;
               Open;
               if not eof then
                  sPerfil_Supervisor := FieldByName('perfil').AsString;
               Close;
            end;
            /////////////////////////////////////////////////////////////////////////////
            //          V A L I D A  L I M I T E S  D E L  S U P E R V I S O R
            /////////////////////////////////////////////////////////////////////////////
            if NOT Valida_Limites_Transaccion('A' //llamado desde Aprobacion
                                             ,sEmpresa
                                             ,sCartera
                                             ,sMoneda_Operacion
                                             ,sTransaccion
                                             ,sFolio_Interno
                                             ,sLogin_Supervisor    //Operador
                                             ,dFecha_Operacion
                                             ,sContraparte
                                             ,sPerfil_Supervisor   //sPerfil_usuario
                                             ,Tabla_Detalle) then
               Result := False
            else
            begin
               Result := True;
               bSalir := True;
            end;
            /////////////////////////////////////////////////////////////////////////////
         end;
      end;
   end;

   DmComunInversiones.Tbl_Excedido.Close;
 //  Tbl_Excedido.DeleteTable;
end;
function Valida_Limites_Transaccion(sTipo_Llamada     : String;
                                    sEmpresa          : String;
                                    sCartera          : String;
                                    sMoneda_Operacion : String;
                                    sTransaccion      : String;
                                    sFolio_Interno    : String;
                                    sOperador         : String;
                                    dFecha_Operacion  : TDateTime;
                                    sContraparte      : String;
                                    sPerfil           : String;
                                    Tabla_Detalle     : string):Boolean;
var
//    Tbl_Detalle        : TFDMemTable;
//    Tbl_Excedido       : TFDMemTable;
//    FDLocalSQL1        : TFDLocalSQL;
//    FDConnection1      : TFDConnection;

    sTipo_Instrum      : String;
    sLogin_Supervisor  : String;
    sPerfil_Supervisor : String;
    bSalir             : Boolean;
    bTiene_Limites     : Boolean;
    fMonto_a_Aprobar   : Double;
begin
   Result := True;

//   Tbl_Excedido := TFDMemTable.Create(Application.Owner);
   with DmComunInversiones.Tbl_Excedido do
   begin
      with FieldDefs do
      begin
         Clear;
         Add('tipo'              ,ftString , 10, False);
         Add('codigo_tipo'       ,ftString , 10, False);
         Add('limite'            ,ftString ,250, False);
         Add('codigo'            ,ftString , 30, False);
         Add('descripcion'       ,ftString , 60, False);
         Add('monto_limite'      ,ftFloat  ,  0, False);
         Add('monto_operacion'   ,ftFloat  ,  0, False);
         Add('monto_transado'    ,ftFloat  ,  0, False);
         Add('monto_excedido'    ,ftFloat  ,  0, False);
      end;
      active := True;
      Open;
   end;

   DmComunInversiones.FDLocalSQL1.Active := true;

   with DmComunInversiones.Qry_Paradox2 do
   begin

      // limites a nivel de operacion
      Sql.Clear;
      Sql.Add('SELECT SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle); //Tabla_Detalle.Name);
      Open;
      while not eof do
      begin
          Valida_Limite_Operacion(sEmpresa
                                 ,sMoneda_Operacion
                                 ,dFecha_Operacion
                                 ,sTransaccion
                                 ,sFolio_Interno
                                 ,sCartera
                                 ,sOperador
                                 ,FieldByName('Valor_Invertido_MC').asFloat);

          Valida_Limite_Cartera(sEmpresa
                               ,sMoneda_Operacion
                               ,dFecha_Operacion
                               ,sTransaccion
                               ,sFolio_Interno
                               ,sCartera
                               ,sOperador
                               ,FieldByName('Valor_Invertido_MC').asFloat);

          Valida_Limite_Contraparte(sEmpresa
                                   ,sMoneda_Operacion
                                   ,dFecha_Operacion
                                   ,sTransaccion
                                   ,sFolio_Interno
                                   ,sCartera
                                   ,sOperador
                                   ,sContraparte
                                   ,FieldByName('Valor_Invertido_MC').asFloat);
        Next;
      end;
      Close;

      // limites a nivel de instrumento
      Sql.Clear;
      Sql.Add('SELECT Instrumento '
             +'      ,SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle //Tabla_Detalle.Name
             +' GROUP BY Instrumento');
      Open;
      while not eof do
      begin
          Valida_Limite_Clasificacion(sEmpresa
                                     ,sMoneda_Operacion
                                     ,dFecha_Operacion
                                     ,sTransaccion
                                     ,sFolio_Interno
                                     ,sCartera
                                     ,sOperador
                                     ,FieldByName('Instrumento').asString);

          Valida_Limite_Instrumento(sEmpresa
                                   ,sMoneda_Operacion
                                   ,dFecha_Operacion
                                   ,sTransaccion
                                   ,sFolio_Interno
                                   ,sCartera
                                   ,sOperador
                                   ,FieldByName('Instrumento').asString);
        Next;
      end;
      Close;

      // limites a nivel de emisor
      Sql.Clear;
      Sql.Add('SELECT Emisor '
             +'      ,SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle //Tabla_Detalle.Name
             +' GROUP BY Emisor');
      Open;
      while not eof do
      begin
          Valida_Limite_Emisor(sEmpresa
                              ,sMoneda_Operacion
                              ,dFecha_Operacion
                              ,sTransaccion
                              ,sFolio_Interno
                              ,sCartera
                              ,sOperador
                              ,FieldByName('Emisor').asString
                              ,FieldByName('Valor_Invertido_MC').asFloat);
        Next;
      end;
      Close;

      // limites a nivel de perfil
      Sql.Clear;
      Sql.Add('SELECT Tipo_Instrum '
             +'      ,Instrumento '
             +'      ,Moneda_Instrum '
             +'      ,Tipo_Cambio '
             +'      ,SUM(Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM '+Tabla_Detalle //Tabla_Detalle.Name
             +' GROUP BY Tipo_Instrum, Instrumento, Moneda_Instrum, Tipo_Cambio');
      Open;
      while not eof do
      begin
         if Leer_Tipo_Instrumento(FieldByName('Instrumento').asString
                                 ,sTipo_Instrum) then
            if sTipo_llamada = 'A' then
               fMonto_a_Aprobar := Busca_Monto_excedido(sEmpresa
                                                       ,sTransaccion
                                                       ,sFolio_Interno)
            else
               fMonto_a_Aprobar := FieldByName('Valor_Invertido_MC').asFloat;
            if Valida_Limite_Perfil(sEmpresa
                                   ,sMoneda_Operacion
                                   ,dFecha_Operacion
                                   ,sTransaccion
                                   ,sFolio_Interno
                                   ,sCartera
                                   ,sTipo_Instrum
                                   ,FieldByName('Instrumento').asString
                                   ,FieldByName('Moneda_Instrum').asString
                                   ,FieldByName('Tipo_Cambio').asFloat
                                   ,sPerfil
                                   ,fMonto_a_Aprobar) then //FieldByName('Valor_Invertido_MC').asFloat)then
               bTiene_Limites := true
            else
            begin
               bTiene_Limites := false;
               Exedio_Limite('D'
                            ,'DEFINICION'
                            ,'NO TIENE LIMITES DEFINIDOS PARA EL PERFIL DEL USUARIO'
                            ,sPerfil
                            ,'PERFIL '''+sPerfil+''''
                            ,0
                            ,0
                            ,0
                            ,0);  // Monto Excedido
            end;
         Next;
      end;
      Close;

   end;

   // Si excedio Limites despliega ventana para autorizacion
   if DmComunInversiones.Tbl_Excedido.RecordCount > 0 then
   begin
      if bTiene_Limites then
      begin
         if sTipo_llamada = 'O' then
            Application.MessageBox('¡Usted ha Excedido los Limites definidos para su Perfil!'
                                  ,'Verificación de Limites'
                                  , mb_OK+ Mb_IconError)
         else
            Application.MessageBox('¡Supervisor ha Excedido los Limites definidos para su Perfil!'
                                  ,'Verificación de Limites'
                                  , mb_OK+ Mb_IconError);
      end
      else
      begin
         if sTipo_llamada = 'O' then
            Application.MessageBox(pchar('¡No se han definido Limites para Perfil '''+sPerfil+'''!'+#10+'Operacion debe ser aprobada por un Supervisor.')
                                  ,'Verificación de Limites'
                                  ,mb_OK+ Mb_IconError)
         else
            Application.MessageBox(pchar('¡No se han definido Limites para Perfil '''+sPerfil+'''!'#10+'No puede aprobar Operacion.')
                                  ,'Verificación de Limites'
                                  ,mb_OK+ Mb_IconError);
      end;

      while not bSalir do
      begin

         if Not Aprueba_Limites(sTipo_llamada
                               ,DmComunInversiones.Tbl_Excedido.Name
                               ,sEmpresa
                               ,sOperador
                               ,sMoneda_Operacion
                               ,sTransaccion
                               ,sFolio_Interno
                               ,sLogin_Supervisor) then
         begin
            bSalir := True;
            Result := False;
         end
         else
         begin
            bSalir := False;
            // busca perfil supervisor
            with DmComunInversiones.QRY_General do
            begin
               SQL.Clear;
               SQL.Add('SELECT a.perfil '
                      +'  FROM QS_SYS_LOGIN a '
                      +' WHERE a.Login_sistema = :Login_sistema ');
               ParamByName('Login_sistema').asString := sLogin_Supervisor;
               Open;
               if not eof then
                  sPerfil_Supervisor := FieldByName('perfil').AsString;
               Close;
            end;
            /////////////////////////////////////////////////////////////////////////////
            //          V A L I D A  L I M I T E S  D E L  S U P E R V I S O R
            /////////////////////////////////////////////////////////////////////////////
            if NOT Valida_Limites_Transaccion('A' //llamado desde Aprobacion
                                             ,sEmpresa
                                             ,sCartera
                                             ,sMoneda_Operacion
                                             ,sTransaccion
                                             ,sFolio_Interno
                                             ,sLogin_Supervisor    //Operador
                                             ,dFecha_Operacion
                                             ,sContraparte
                                             ,sPerfil_Supervisor   //sPerfil_usuario
                                             ,Tabla_Detalle) then
               Result := False
            else
            begin
               Result := True;
               bSalir := True;
            end;
            /////////////////////////////////////////////////////////////////////////////
         end;
      end;
   end;

   DmComunInversiones.Tbl_Excedido.Close;
 //  Tbl_Excedido.DeleteTable;
end;

Procedure Valida_Limite_Operacion(sEmpresa           :String;
                                  sMoneda_Operacion  :String;
                                  dFecha_Operacion   :TDateTime;
                                  sTransaccion       :String;
                                  sFolio_Interno     :String;
                                  sCartera           :String;
                                  sOperador          :String;
                                  fMonto_Operacion   :Double);

var fMonto_Transado_Empresa  : Double;
    fMonto_Transado_Cartera  : Double;
    fMonto_Transado_Operador : Double;
begin
   fMonto_Transado_Empresa := Busca_Monto_Transado(sEmpresa
                                                  ,sMoneda_Operacion
                                                  ,dFecha_Operacion
                                                  ,sTransaccion
                                                  ,sFolio_interno
                                                  ,'E'  // Empresa
                                                  ,sEmpresa
                                                  ,'O'  //por Operacion diaria
                                                  ,'');
   fMonto_Transado_Cartera := Busca_Monto_Transado(sEmpresa
                                                  ,sMoneda_Operacion
                                                  ,dFecha_Operacion
                                                  ,sTransaccion
                                                  ,sFolio_interno
                                                  ,'C'  //Cartera
                                                  ,sCartera
                                                  ,'O'  //por Operacion diaria
                                                  ,'');
   fMonto_Transado_Operador := Busca_Monto_Transado(sEmpresa
                                                   ,sMoneda_Operacion
                                                   ,dFecha_Operacion
                                                   ,sTransaccion
                                                   ,sFolio_interno
                                                   ,'O'  //Operador
                                                   ,sOperador
                                                   ,'O'  //por Operacion diaria
                                                   ,'');

   with DmComunInversiones.Qry_General do
   begin
      sql.clear;
      sql.add('select a.tipo                         as tipo '
             +'      ,a.codigo_tipo                  as codigo_tipo'
             +'      ,''LIMITE TOTAL TRANSACCIONES'' as limite '
             +'      ,a.monto_limite                 as monto_limite '
             +'  from QS_SUP_LIMTRA_OPERACION a '
             +'      ,QS_SUP_LIMTRA_VIGENCIA  b '
             +' where a.EMPRESA     = :Empresa '
             +'   and a.MONEDA      = :Moneda '
             +'   and a.TRANSACCION = :Transaccion '
             +'   and a.TIPO        = :Tipo '
             +'   and a.CODIGO_TIPO = :Codigo_Tipo '
             +'   and b.EMPRESA     = a.EMPRESA '
             +'   and b.MONEDA      = a.MONEDA '
             +'   and b.TRANSACCION = a.TRANSACCION '
             +'   and b.TIPO        = a.TIPO '
             +'   and b.CODIGO_TIPO = a.CODIGO_TIPO '
             +'   and b.FECHA_DESDE = a.FECHA_DESDE '
             +'   and b.FECHA_DESDE <= :Fecha '
             +'   and (b.FECHA_HASTA >= :Fecha or b.FECHA_HASTA  is null) '
             );

      // Definicion a nivel de Empresa
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'E';
      ParamByName('Codigo_Tipo').asString := sEmpresa;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Empresa) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,''
                         ,''
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Empresa
                         ,(fMonto_Operacion + fMonto_Transado_Empresa) - FieldByName('Monto_Limite').asFloat
                         );
         end;
         Next;
      end;
      Close;

      // Definicion a nivel de Catera
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'C';
      ParamByName('Codigo_Tipo').asString := sCartera;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Cartera) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,''
                         ,''
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Cartera
                         ,(fMonto_Operacion + fMonto_Transado_Cartera) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                         );
         end;
         Next;
      end;
      Close;

      // Definicion a nivel de Operador
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'O';
      ParamByName('Codigo_Tipo').asString := sOperador;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Operador) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,''
                         ,''
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Operador
                         ,(fMonto_Operacion + fMonto_Transado_Operador) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                         );
         end;
         Next;
      end;
      Close;
   end;
end;


Procedure Valida_Limite_Cartera(sEmpresa           :String;
                                sMoneda_Operacion  :String;
                                dFecha_Operacion   :TDateTime;
                                sTransaccion       :String;
                                sFolio_Interno     :String;
                                sCartera           :String;
                                sOperador          :String;
                                fMonto_Operacion   :Double);

var
    fMonto_Transado_Operador : Double;
begin
   fMonto_Transado_Operador := Busca_Monto_Transado(sEmpresa
                                                   ,sMoneda_Operacion
                                                   ,dFecha_Operacion
                                                   ,sTransaccion
                                                   ,sFolio_interno
                                                   ,'O'   // Operador
                                                   ,sOperador     
                                                   ,'C'   // por Cartera
                                                   ,sCartera);

   with DmComunInversiones.Qry_General do
   begin
      sql.clear;
      sql.add('select a.tipo                        as tipo '
             +'      ,a.codigo_tipo                 as codigo_tipo'
             +'      ,''LIMITE POR CARTERA DIARIO'' as limite '
             +'      ,a.Cartera                     as codigo '
             +'      ,c.descripcion                 as descripcion'
             +'      ,a.monto_limite                as monto_limite '
             +'  from QS_SUP_LIMTRA_CARTERA  a '
             +'      ,QS_SUP_LIMTRA_VIGENCIA b '
             +'      ,QS_FIN_CARTERAS        c '
             +' where a.EMPRESA     = :Empresa '
             +'   and a.MONEDA      = :Moneda '
             +'   and a.TRANSACCION = :Transaccion '
             +'   and a.TIPO        = :Tipo '
             +'   and a.CODIGO_TIPO = :Codigo_Tipo '
             +'   and b.EMPRESA     = a.EMPRESA '
             +'   and b.MONEDA      = a.MONEDA '
             +'   and b.TRANSACCION = a.TRANSACCION '
             +'   and b.TIPO        = a.TIPO '
             +'   and b.CODIGO_TIPO = a.CODIGO_TIPO '
             +'   and b.FECHA_DESDE = a.FECHA_DESDE '
             +'   and b.FECHA_DESDE <= :Fecha '
             +'   and (b.FECHA_HASTA >= :Fecha or b.FECHA_HASTA  is null) '
             +'   and a.cartera     = :cartera '
             +'   and c.cod_cartera = a.cartera'
             );
      // Definicion a nivel de Operador
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'O';
      ParamByName('Codigo_Tipo').asString := sOperador;
      ParamByName('cartera').asString     := sCartera;
      Open;
      while not EOF do
      begin
            if (fMonto_Operacion + fMonto_Transado_Operador) > FieldByName('Monto_Limite').asFloat then
            begin
               Exedio_Limite(FieldByName('tipo').asString
                            ,FieldByName('codigo_tipo').asString
                            ,FieldByName('limite').asString
                            ,FieldByName('codigo').asString
                            ,FieldByName('descripcion').asString
                            ,FieldByName('monto_limite').asFloat
                            ,fMonto_Operacion
                            ,fMonto_Transado_Operador
                            ,(fMonto_Operacion + fMonto_Transado_Operador) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                            );
            end;
            Next;
      end;
      Close;
   end;
end;

Procedure Valida_Limite_Emisor(sEmpresa           :String;
                               sMoneda_Operacion  :String;
                               dFecha_Operacion   :TDateTime;
                               sTransaccion       :String;
                               sFolio_Interno     :String;
                               sCartera           :String;
                               sOperador          :String;
                               sEmisor            :String;
                               fMonto_Operacion :Double);
var fMonto_Transado_Empresa  : Double;
    fMonto_Transado_Cartera  : Double;
    fMonto_Transado_Operador : Double;
begin
   fMonto_Transado_Empresa := Busca_Monto_Transado(sEmpresa
                                                  ,sMoneda_Operacion
                                                  ,dFecha_Operacion
                                                  ,sTransaccion
                                                  ,sFolio_interno
                                                  ,'E'   // Empresa
                                                  ,sEmpresa
                                                  ,'E'   // por Emisor
                                                  ,sEmisor);
   fMonto_Transado_Cartera := Busca_Monto_Transado(sEmpresa
                                                  ,sMoneda_Operacion
                                                  ,dFecha_Operacion
                                                  ,sTransaccion
                                                  ,sFolio_interno
                                                  ,'C'   // Cartera
                                                  ,sCartera
                                                  ,'E'   // por Emisor
                                                  ,sEmisor);
   fMonto_Transado_Operador := Busca_Monto_Transado(sEmpresa
                                                   ,sMoneda_Operacion
                                                   ,dFecha_Operacion
                                                   ,sTransaccion
                                                   ,sFolio_interno
                                                   ,'O'   // Operador
                                                   ,sOperador     
                                                   ,'E'   // por Emisor
                                                   ,sEmisor);

   with DmComunInversiones.Qry_General do
   begin
      sql.clear;
      sql.add('select a.tipo                       as tipo '
             +'      ,a.codigo_tipo                as codigo_tipo'
             +'      ,''LIMITE POR EMISOR DIARIO'' as limite '
             +'      ,a.Emisor                     as Emisor '
             +'      ,c.Razon_Social_Pat           as descripcion '
             +'      ,a.monto_limite               as monto_limite '
             +'  from QS_SUP_LIMTRA_EMISOR    a '
             +'      ,QS_SUP_LIMTRA_VIGENCIA  b '
             +'      ,QS_SYS_IDENTIDAD        c '
             +' where a.EMPRESA     = :Empresa '
             +'   and a.MONEDA      = :Moneda '
             +'   and a.TRANSACCION = :Transaccion '
             +'   and a.TIPO        = :Tipo '
             +'   and a.CODIGO_TIPO = :Codigo_Tipo '
             +'   and b.EMPRESA     = a.EMPRESA '
             +'   and b.MONEDA      = a.MONEDA '
             +'   and b.TRANSACCION = a.TRANSACCION '
             +'   and b.TIPO        = a.TIPO '
             +'   and b.CODIGO_TIPO = a.CODIGO_TIPO '
             +'   and b.FECHA_DESDE = a.FECHA_DESDE '
             +'   and b.FECHA_DESDE <= :Fecha '
             +'   and (b.FECHA_HASTA >= :Fecha or b.FECHA_HASTA  is null) '
             +'   and a.Emisor           = :Emisor '
             +'   and c.Codigo_Identidad = a.Emisor '
             );

      // Definicion a nivel de Empresa
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'E';
      ParamByName('Codigo_Tipo').asString := sEmpresa;
      ParamByName('Emisor').asString      := sEmisor;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Empresa) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,FieldByName('Emisor').asString
                         ,FieldByName('descripcion').asString
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Empresa
                         ,(fMonto_Operacion + fMonto_Transado_Empresa) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                         );
         end;
         Next;
      end;
      Close;

      // Definicion a nivel de Catera
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'C';
      ParamByName('Codigo_Tipo').asString := sCartera;
      ParamByName('Emisor').asString      := sEmisor;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Cartera) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,FieldByName('Emisor').asString
                         ,FieldByName('descripcion').asString
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Cartera
                         ,(fMonto_Operacion + fMonto_Transado_Cartera) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                         );
         end;
         Next;
      end;
      Close;

      // Definicion a nivel de Operador
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'O';
      ParamByName('Codigo_Tipo').asString := sOperador;
      ParamByName('Emisor').asString      := sEmisor;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Operador) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,FieldByName('Emisor').asString
                         ,FieldByName('descripcion').asString
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Operador
                         ,(fMonto_Operacion + fMonto_Transado_Operador) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                         );
         end;
         Next;
      end;
      Close;
   end;
end;


Procedure Valida_Limite_Contraparte(sEmpresa           :String;
                                    sMoneda_Operacion  :String;
                                    dFecha_Operacion   :TDateTime;
                                    sTransaccion       :String;
                                    sFolio_Interno     :String;
                                    sCartera           :String;
                                    sOperador          :String;
                                    sContraparte       :String;
                                    fMonto_Operacion :Double);
var fMonto_Transado_Empresa  : Double;
    fMonto_Transado_Cartera  : Double;
    fMonto_Transado_Operador : Double;
begin
   fMonto_Transado_Empresa := Busca_Monto_Transado(sEmpresa
                                                  ,sMoneda_Operacion
                                                  ,dFecha_Operacion
                                                  ,sTransaccion
                                                  ,sFolio_interno
                                                  ,'E'   // Empresa
                                                  ,sEmpresa
                                                  ,'T'   // por Contraparte
                                                  ,sContraparte);
   fMonto_Transado_Cartera := Busca_Monto_Transado(sEmpresa
                                                  ,sMoneda_Operacion
                                                  ,dFecha_Operacion
                                                  ,sTransaccion
                                                  ,sFolio_interno
                                                  ,'C'   // Cartera
                                                  ,sCartera
                                                  ,'T'   // por Contraparte
                                                  ,sContraparte);
   fMonto_Transado_Operador := Busca_Monto_Transado(sEmpresa
                                                   ,sMoneda_Operacion
                                                   ,dFecha_Operacion
                                                   ,sTransaccion
                                                   ,sFolio_interno
                                                   ,'O'   // Operador
                                                   ,sOperador
                                                   ,'T'   // por Contraparte
                                                   ,sContraparte);

   with DmComunInversiones.Qry_General do
   begin
      sql.clear;
      sql.add('select a.tipo                            as tipo '
             +'      ,a.codigo_tipo                     as codigo_tipo'
             +'      ,''LIMITE POR CONTRAPARTE DIARIO'' as limite '
             +'      ,a.contraparte                     as contraparte '
             +'      ,c.Razon_Social_Pat                as descripcion'
             +'      ,a.monto_limite                    as monto_limite '
             +'  from QS_SUP_LIMTRA_CONTRAPARTE a '
             +'      ,QS_SUP_LIMTRA_VIGENCIA    b '
             +'      ,QS_SYS_IDENTIDAD          c '
             +' where a.EMPRESA     = :Empresa '
             +'   and a.MONEDA      = :Moneda '
             +'   and a.TRANSACCION = :Transaccion '
             +'   and a.TIPO        = :Tipo '
             +'   and a.CODIGO_TIPO = :Codigo_Tipo '
             +'   and b.EMPRESA     = a.EMPRESA '
             +'   and b.MONEDA      = a.MONEDA '
             +'   and b.TRANSACCION = a.TRANSACCION '
             +'   and b.TIPO        = a.TIPO '
             +'   and b.CODIGO_TIPO = a.CODIGO_TIPO '
             +'   and b.FECHA_DESDE = a.FECHA_DESDE '
             +'   and b.FECHA_DESDE <= :Fecha '
             +'   and (b.FECHA_HASTA >= :Fecha or b.FECHA_HASTA  is null) '
             +'   and a.Contraparte      = :Contraparte '
             +'   and c.Codigo_Identidad = a.contraparte '
             );

      // Definicion a nivel de Empresa
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'E';
      ParamByName('Codigo_Tipo').asString := sEmpresa;
      ParamByName('Contraparte').asString := sContraparte;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Empresa) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,FieldByName('contraparte').asString
                         ,FieldByName('descripcion').asString
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Empresa
                         ,(fMonto_Operacion + fMonto_Transado_Empresa) - FieldByName('Monto_Limite').asFloat);  // Monto Excedido
         end;
         Next;
      end;
      Close;

      // Definicion a nivel de Catera
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'C';
      ParamByName('Codigo_Tipo').asString := sCartera;
      ParamByName('Contraparte').asString := sContraparte;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Cartera) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,FieldByName('contraparte').asString
                         ,FieldByName('descripcion').asString
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Cartera
                         ,(fMonto_Operacion + fMonto_Transado_Cartera) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                         );
         end;
         Next;
      end;
      Close;

      // Definicion a nivel de Operador
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'O';
      ParamByName('Codigo_Tipo').asString := sOperador;
      ParamByName('Contraparte').asString := sContraparte;
      Open;
      while not EOF do
      begin
         if (fMonto_Operacion + fMonto_Transado_Operador) > FieldByName('Monto_Limite').asFloat then
         begin
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,FieldByName('contraparte').asString
                         ,FieldByName('descripcion').asString
                         ,FieldByName('monto_limite').asFloat
                         ,fMonto_Operacion
                         ,fMonto_Transado_Operador
                         ,(fMonto_Operacion + fMonto_Transado_Operador) - FieldByName('Monto_Limite').asFloat  // Monto Excedido
                         );
         end;
         Next;
      end;
      Close;
   end;
end;

Procedure Valida_Limite_Clasificacion(sEmpresa           :String;
                                      sMoneda_Operacion  :String;
                                      dFecha_Operacion   :TDateTime;
                                      sTransaccion       :String;
                                      sFolio_Interno     :String;
                                      sCartera           :String;
                                      sOperador          :String;
                                      sInstrumento       :String);
var fNodo_Clasif        : Double;
    bClasif             : Boolean;
    bResult             : Boolean;
    sNombre_Instrumento : String;
    sNodos_Hijos        : String;
    String_Dato         : TArr100_String;
    i                   : Integer;
begin

   with DmComunInversiones.Qry_Varios do
   begin
      sql.clear;
      sql.add('select a.tipo                              as tipo '
             +'      ,a.codigo_tipo                       as codigo_tipo'
             +'      ,''CLASIF. INSTRUMENTOS TRANSABLES'' as limite '
             +'      ,a.tipo_clasif                       as tipo_clasif '
             +'      ,a.Clasificacion                     as Clasificacion '
             +'      ,c.descripcion_nodo                  as descripcion '
             +'  from QS_SUP_LIMTRA_CLASIF   a '
             +'      ,QS_SUP_LIMTRA_VIGENCIA b '
             +'      ,QS_SYS_EST_CLA         c '
             +' where a.EMPRESA     = :Empresa '
             +'   and a.MONEDA      = :Moneda '
             +'   and a.TRANSACCION = :Transaccion '
             +'   and a.TIPO        = :Tipo '
             +'   and a.CODIGO_TIPO = :Codigo_Tipo '
             +'   and b.EMPRESA     = a.EMPRESA '
             +'   and b.MONEDA      = a.MONEDA '
             +'   and b.TRANSACCION = a.TRANSACCION '
             +'   and b.TIPO        = a.TIPO '
             +'   and b.CODIGO_TIPO = a.CODIGO_TIPO '
             +'   and b.FECHA_DESDE = a.FECHA_DESDE '
             +'   and b.FECHA_DESDE  <= :Fecha '
             +'   and (b.FECHA_HASTA >= :Fecha or b.FECHA_HASTA  is null) '
             +'   and c.Codigo_Objeto = a.Tipo_Clasif '
             +'   and c.Nodo          = a.Clasificacion '
             );

      // Definicion a nivel de Empresa
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'E';
      ParamByName('Codigo_Tipo').asString := sEmpresa;
      Open;
      bClasif := false;
      if not EOF then
      begin
         while not EOF do
         begin
            Determina_Nodo_Clasificacion('INSTRUM'
                                        ,sInstrumento
                                        ,FieldByName('tipo_clasif').asString
                                        ,fNodo_Clasif);
            sNodos_Hijos := Nodos_Hijos(FieldByName('tipo_clasif').asString
                                       ,FieldByName('Clasificacion').asFloat);
            Separa_Campos_String(',',' ',sNodos_Hijos,String_Dato);
            i := 1;
            while String_Dato[i] <> '' do
            begin
               if fNodo_Clasif = strtofloat(String_Dato[i]) then
                  bClasif := true;
               inc(i);
            end;
            Next;
         end;
         if not bClasif then
         begin
            Leer_Nombre_Instrumento(sInstrumento
                                   ,sNombre_Instrumento
                                   ,bResult);
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,sInstrumento
                         ,sNombre_Instrumento
                         ,0
                         ,0
                         ,0
                         ,0);  // Monto Excedido}
         end;
      end;
      Close;

      // Definicion a nivel de Catera
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'C';
      ParamByName('Codigo_Tipo').asString := sCartera;
      Open;
      bClasif := false;
      if not EOF then
      begin
         while not EOF do
         begin
            Determina_Nodo_Clasificacion('INSTRUM'
                                        ,sInstrumento
                                        ,FieldByName('tipo_clasif').asString
                                        ,fNodo_Clasif);
            sNodos_Hijos := Nodos_Hijos(FieldByName('tipo_clasif').asString
                                       ,FieldByName('Clasificacion').asFloat);
            Separa_Campos_String(',',' ',sNodos_Hijos,String_Dato);
            i := 1;
            while String_Dato[i] <> '' do
            begin
               if fNodo_Clasif = strtofloat(String_Dato[i]) then
                  bClasif := true;
               inc(i);
            end;
            Next;
         end;
         if not bClasif then
         begin
            Leer_Nombre_Instrumento(sInstrumento
                                   ,sNombre_Instrumento
                                   ,bResult);
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,sInstrumento
                         ,sNombre_Instrumento
                         ,0
                         ,0
                         ,0
                         ,0);  // Monto Excedido
         end;
      end;
      Close;

      // Definicion a nivel de Operador
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'O';
      ParamByName('Codigo_Tipo').asString := sOperador;
      Open;
      bClasif := false;
      if not EOF then
      begin
         while not EOF do
         begin
            Determina_Nodo_Clasificacion('INSTRUM'
                                        ,sInstrumento
                                        ,FieldByName('tipo_clasif').asString
                                        ,fNodo_Clasif);
            sNodos_Hijos := Nodos_Hijos(FieldByName('tipo_clasif').asString
                                       ,FieldByName('Clasificacion').asFloat);
            Separa_Campos_String(',',' ',sNodos_Hijos,String_Dato);
            i := 1;
            while String_Dato[i] <> '' do
            begin
               if fNodo_Clasif = strtofloat(String_Dato[i]) then
                  bClasif := true;
               inc(i);
            end;
            Next;
         end;
         if not bClasif then
         begin
            Leer_Nombre_Instrumento(sInstrumento
                                   ,sNombre_Instrumento
                                   ,bResult);
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,sInstrumento
                         ,sNombre_Instrumento
                         ,0
                         ,0
                         ,0
                         ,0);  // Monto Excedido
         end;
      end;
      Close;
   end;
end;

Procedure Valida_Limite_Instrumento(sEmpresa           :String;
                                    sMoneda_Operacion  :String;
                                    dFecha_Operacion   :TDateTime;
                                    sTransaccion       :String;
                                    sFolio_Interno     :String;
                                    sCartera           :String;
                                    sOperador          :String;
                                    sInstrumento       :String);
var bInstrum            : Boolean;
    bResult             : Boolean;
    sNombre_Instrumento : String;
begin

   with DmComunInversiones.Qry_Varios do
   begin
      sql.clear;
      sql.add('select a.tipo                     as tipo '
             +'      ,a.codigo_tipo              as codigo_tipo'
             +'      ,''INSTRUMENTOS TRANSABLES'' as limite '
             +'      ,a.Instrumento              as Instrumento '
             +'      ,c.Nom_Instrumento          as descripcion '
             +'  from QS_SUP_LIMTRA_INSTRUMENTO a '
             +'      ,QS_SUP_LIMTRA_VIGENCIA    b '
             +'      ,QS_FIN_INSTRUM            c '
             +' where a.EMPRESA     = :Empresa '
             +'   and a.MONEDA      = :Moneda '
             +'   and a.TRANSACCION = :Transaccion '
             +'   and a.TIPO        = :Tipo '
             +'   and a.CODIGO_TIPO = :Codigo_Tipo '
             +'   and b.EMPRESA     = a.EMPRESA '
             +'   and b.MONEDA      = a.MONEDA '
             +'   and b.TRANSACCION = a.TRANSACCION '
             +'   and b.TIPO        = a.TIPO '
             +'   and b.CODIGO_TIPO = a.CODIGO_TIPO '
             +'   and b.FECHA_DESDE = a.FECHA_DESDE '
             +'   and b.FECHA_DESDE  <= :Fecha '
             +'   and (b.FECHA_HASTA >= :Fecha or b.FECHA_HASTA  is null) '
             +'   and c.Cod_Instrumento = a.Instrumento '
             );

      // Definicion a nivel de Empresa
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'E';
      ParamByName('Codigo_Tipo').asString := sEmpresa;
      Open;
      bInstrum := false;
      if not EOF then
      begin
         while not EOF do
         begin
            if sInstrumento = FieldByName('Instrumento').asString then
               bInstrum := true;
            Next;
         end;
         if not bInstrum then
         begin
            Leer_Nombre_Instrumento(sInstrumento
                                   ,sNombre_Instrumento
                                   ,bResult);
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,sInstrumento
                         ,sNombre_Instrumento
                         ,0
                         ,0
                         ,0
                         ,0);  // Monto Excedido
         end;
      end;
      Close;

      // Definicion a nivel de Catera
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'C';
      ParamByName('Codigo_Tipo').asString := sCartera;
      Open;
      bInstrum := false;
      if not EOF then
      begin
         while not EOF do
         begin
            if sInstrumento = FieldByName('Instrumento').asString then
               bInstrum := true;
            Next;
         end;
         if not bInstrum then
         begin
            Leer_Nombre_Instrumento(sInstrumento
                                   ,sNombre_Instrumento
                                   ,bResult);
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,sInstrumento
                         ,sNombre_Instrumento
                         ,0
                         ,0
                         ,0
                         ,0);  // Monto Excedido
         end;
      end;
      Close;

      // Definicion a nivel de Operador
      ParamByName('Empresa').asString     := sEmpresa;
      ParamByName('Moneda').asString      := sMoneda_Operacion;
      ParamByName('Transaccion').asString := sTransaccion;
      ParamByName('Fecha').AsDate     := dFecha_Operacion;
      ParamByName('Tipo').asString        := 'O';
      ParamByName('Codigo_Tipo').asString := sOperador;
      Open;
      bInstrum := false;
      if not EOF then
      begin
         while not EOF do
         begin
            if sInstrumento = FieldByName('Instrumento').asString then
               bInstrum := true;
            Next;
         end;
         if not bInstrum then
         begin
            Leer_Nombre_Instrumento(sInstrumento
                                   ,sNombre_Instrumento
                                   ,bResult);
            Exedio_Limite(FieldByName('tipo').asString
                         ,FieldByName('codigo_tipo').asString
                         ,FieldByName('limite').asString
                         ,sInstrumento
                         ,sNombre_Instrumento
                         ,0
                         ,0
                         ,0
                         ,0);  // Monto Excedido
         end;
      end;
      Close;
   end;
end;

Function Valida_Limite_Perfil(sEmpresa            :String;
                              sMoneda_Operacion   :String;
                              dFecha_Operacion    :TDateTime;
                              sTransaccion        :String;
                              sFolio_Interno      :String;
                              sCartera            :String;
                              sTipo_Instrum       :String;
                              sInstrumento        :String;
                              sMoneda_Instrum     :String;
                              fTipo_Cambio        :Double;
                              sPerfil             :String;
                              fMonto_Operacion    :Double) :Boolean;
var fMonto_Transado_Perfil :Double;
    fNodo_Clasif           :Double;
    sNodos_Hijos           :String;
    bClasif                :Boolean;
    i                      :Integer;
    String_Dato            :TArr100_String;
    fMonto_Limite          :Double;
begin
   Result := false;
   with DmComunInversiones.Qry_Varios do
   begin
      sql.clear;
      sql.add('select ''P''                         as tipo '
             +'      ,a.perfil                      as codigo_tipo '
             +'      ,''LIMITES POR PERFIL DIARIO'' as limite '
             +'      ,'' ''                         as codigo ');
      if sDriver = 'ORACLE' then
         sql.add('      ,a.cartera||'' - ''||a.tipo_instrum||'' - ''||a.tipo_clasif||'' | ''||c.descripcion_nodo||'' - ''||a.moneda_limite||'' - ''||a.perfil as descripcion ')
      else
         sql.add('      ,a.cartera+'' - ''+a.tipo_instrum+'' - ''+a.tipo_clasif+'' | ''+c.descripcion_nodo+'' - ''+a.moneda_limite+'' - ''+a.perfil as descripcion ');
      sql.add('      ,a.tipo_clasif                 as tipo_clasif '
             +'      ,a.clasificacion               as clasificacion '
             +'      ,a.monto_limite                as monto_limite '
             +'  from QS_SUP_LIMTRA_PERFIL_PERFIL   a '
             +'      ,QS_SUP_LIMTRA_VIGENCIA_PERFIL b '
             +'      ,QS_SYS_EST_CLA                c '
             +'      ,QS_SYS_TRAN_IMPLIC            d '
             +' where a.EMPRESA            = :Empresa '
             +'   and a.MONEDA             = :Moneda '
             +'   and d.CODIGO_TRANSACCION = a.TRANSACCION '
             +'   and d.IMPLICANCIA        = :Transaccion '
             +'   and b.EMPRESA            = a.EMPRESA '
             +'   and b.MONEDA             = a.MONEDA '
             +'   and b.TRANSACCION        = a.TRANSACCION '
             +'   and b.FECHA_DESDE        = a.FECHA_DESDE '
             +'   and b.FECHA_DESDE        = (select max(x.fecha_desde) '
             +'                                 from QS_SUP_LIMTRA_VIGENCIA_PERFIL x '
             +'                                where x.EMPRESA            = b.EMPRESA '
             +'                                  and x.MONEDA             = b.MONEDA '
             +'                                  and x.TRANSACCION        = b.TRANSACCION '
             +'                                  and x.FECHA_DESDE       <= :Fecha '
             +'                                  and (x.FECHA_HASTA      >= :Fecha or x.FECHA_HASTA  is null) ) '
             +'   and (b.FECHA_HASTA      >= :Fecha or b.FECHA_HASTA  is null) '
             +'   and a.CARTERA            = :CARTERA '
             +'   and a.TIPO_INSTRUM       = :TIPO_INSTRUM '
             +'   and a.MONEDA_LIMITE      = :MONEDA_LIMITE '
             +'   and a.PERFIL             = :PERFIL '
             +'   and c.Codigo_Objeto      = a.Tipo_Clasif '
             +'   and c.Nodo               = a.Clasificacion '
             );
      ParamByName('Empresa').asString       := sEmpresa;
      ParamByName('Moneda').asString        := sMoneda_Operacion;
      ParamByName('Transaccion').asString   := sTransaccion;
      ParamByName('Fecha').AsDate       := dFecha_Operacion;
      ParamByName('Cartera').asString       := sCartera;
      ParamByName('Tipo_Instrum').asString  := sTipo_Instrum;
      if Transaccion_Implica(sTransaccion,'PACTO') then
         ParamByName('Moneda_Limite').asString := sMoneda_Operacion
      else
         ParamByName('Moneda_Limite').asString := sMoneda_Instrum;
      ParamByName('Perfil').asString        := sPerfil;
      Open;
      while not eof do
      begin
         Determina_Nodo_Clasificacion('INSTRUM'
                                     ,sInstrumento
                                     ,FieldByName('tipo_clasif').asString
                                     ,fNodo_Clasif);
         sNodos_Hijos := Nodos_Hijos(FieldByName('tipo_clasif').asString
                                    ,FieldByName('clasificacion').asFloat);
         Separa_Campos_String(',',' ',sNodos_Hijos,String_Dato);
         bClasif := false;
         i := 1;
         while String_Dato[i] <> '' do
         begin
            if fNodo_Clasif = strtofloat(String_Dato[i]) then
               bClasif := true;
            inc(i);
         end;
         if bClasif then
         begin
            Result := true;

            // Busca Monto Transado (en OMD's)
            DmComunInversiones.Qry_Aux.sql.clear;
            DmComunInversiones.Qry_Aux.sql.add('SELECT distinct a.implicancia as Transaccion '
                                              +'  FROM QS_SYS_TRAN_IMPLIC a '
                                              +' WHERE a.codigo_transaccion = :codigo_transaccion ');
            if Transaccion_Implica(sTransaccion,'PACTO') then
               DmComunInversiones.Qry_Aux.ParamByName('codigo_transaccion').asString := 'OPEPACTO'
            else
               DmComunInversiones.Qry_Aux.ParamByName('codigo_transaccion').asString := 'OPEFIN';
            DmComunInversiones.Qry_Aux.Open;
            fMonto_Transado_Perfil := 0;
            while not DmComunInversiones.Qry_Aux.eof do
            begin
               fMonto_Transado_Perfil := fMonto_Transado_Perfil + Busca_Monto_Transado_Perfil(sEmpresa
                                                                                             ,sMoneda_Operacion
                                                                                             ,dFecha_Operacion
                                                                                             ,DmComunInversiones.Qry_Aux.FieldByName('Transaccion').asstring
                                                                                             ,sFolio_interno
                                                                                             ,sCartera
                                                                                             ,sTipo_Instrum
                                                                                             ,FieldByName('tipo_clasif').asstring
                                                                                             ,sNodos_Hijos
                                                                                             ,sMoneda_Instrum
                                                                                             ,sPerfil);
               DmComunInversiones.Qry_Aux.Next;
            end;

            if (fTipo_Cambio >  1) and (not Transaccion_Implica(sTransaccion,'PACTO')) then
               fMonto_Limite := FieldByName('monto_limite').asFloat * fTipo_Cambio
            else
               fMonto_Limite := FieldByName('monto_limite').asFloat;
            if (fMonto_Operacion + fMonto_Transado_Perfil) > fMonto_Limite then
            begin
               Exedio_Limite(FieldByName('tipo').asString
                            ,FieldByName('codigo_tipo').asString
                            ,FieldByName('limite').asString
                            ,FieldByName('codigo').asString
                            ,FieldByName('descripcion').asString
                            ,fMonto_Limite
                            ,fMonto_Operacion
                            ,fMonto_Transado_Perfil
                            ,(fMonto_Operacion + fMonto_Transado_Perfil) - fMonto_Limite);  // Monto Excedido
            end;
         end;
         Next;
      end;
      Close;
   end;
end;

Procedure Exedio_Limite(sTipo              :String;
                        sCodigo_tipo       :String;
                        sLimite            :String;
                        sCodigo            :String;
                        sDescripcion       :String;
                        fMonto_Limite      :Double;
                        fMonto_Operacion   :Double;
                        fMonto_Transado    :Double;
                        fMonto_Excedido    :Double);
begin
   with DmComunInversiones.Qry_Paradox do
   begin
      sql.clear;
      sql.add('insert into '+DmComunInversiones.Tbl_Excedido.Name  //  sNombre_Tabla
             +'(tipo'
             +',codigo_tipo'
             +',limite'
             +',codigo'
             +',descripcion'
             +',monto_limite'
             +',monto_operacion'
             +',monto_transado'
             +',monto_excedido)'
             +' values '
             +'(:tipo'
             +',:codigo_tipo'
             +',:limite'
             +',:codigo'
             +',:descripcion'
             +',:monto_limite'
             +',:monto_operacion'
             +',:monto_transado'
             +',:monto_excedido)');
      ParamByName('Tipo').asString             := sTipo;
      ParamByName('Codigo_tipo').asString      := sCodigo_tipo;
      ParamByName('limite').asString           := slimite;
      ParamByName('codigo').asString           := scodigo;
      ParamByName('descripcion').asString      := sdescripcion;
      ParamByName('monto_limite').asFloat      := fmonto_limite;
      ParamByName('monto_operacion').asFloat   := fMonto_Operacion;
      ParamByName('monto_transado').asFloat    := fMonto_Transado;
      ParamByName('monto_excedido').asFloat    := fmonto_excedido;
      Prepare;
      ExecSQL;
      Close;
      UnPrepare;
   end;
end;

function Busca_Monto_Transado(sEmpresa           :String;
                              sMoneda_Operacion  :String;
                              dFecha_Operacion   :TDateTime;
                              sTransaccion       :String;
                              sFolio_Interno     :String;
                              sNivel             :String;
                              sCodigo            :String;
                              sTipo              :String;
                              sValor             :String) :Double;
var sCondicion1 : String;
    sCondicion2 : String;
begin
   Result := 0;

   if sNivel = 'E' then
      sCondicion1 := ' AND a.Empresa = '''+trim(sCodigo)+'''';

   if sNivel = 'C' then
      sCondicion1 := ' AND a.Cartera = '''+trim(sCodigo)+'''';

   if sNivel = 'O' then
      sCondicion1 := ' AND d.Operador = '''+trim(sCodigo)+'''';

   if sTipo = 'O' then
      sCondicion2 := '';

   if sTipo = 'C' then
      sCondicion2 := ' AND a.Cartera = '''+trim(sValor)+'''';

   if sTipo = 'E' then
      sCondicion2 := ' AND a.Emisor = '''+trim(sValor)+'''';

   if sTipo = 'T' then
      sCondicion2 := ' AND d.Contraparte = '''+trim(sValor)+'''';

   with DmComunInversiones.Qry_Varios do
   begin
      sql.clear;
      sql.add('SELECT SUM(a.Valor_Invertido_MC) as Valor_Invertido_MC '
             +'  FROM QS_TRA_OMD_DET_RF a '
             +'      ,QS_TRA_OMD        d '
             +' WHERE d.Empresa           = :Empresa '
             +'   AND d.Fecha_Operacion   = :Fecha_Operacion '
             +'   AND d.Moneda_Operacion  = :Moneda_Operacion '
             +'   AND d.Transaccion       = :Transaccion '
             +'   AND d.Folio_Interno not in (SELECT f.Folio '
             +'                                 FROM qs_ctr_anulacion f'
             +'                                WHERE f.empresa     = d.empresa'
             +'                                  AND f.transaccion = d.Transaccion'
             +'                                  AND f.Folio       = d.Folio_interno)'
             +'   AND d.empresa           = a.empresa '
             +'   AND d.Transaccion       = a.Transaccion '
             +'   AND d.Folio_Interno     = a.Folio_Interno '
             +sCondicion1
             +sCondicion2
             +'   AND d.Folio_Interno     <> :Folio_Interno '
            );
      ParamByName('Empresa').AsString           := sEmpresa;
      ParamByName('Fecha_Operacion').AsDate := dFecha_Operacion;
      ParamByName('Moneda_Operacion').AsString  := sMoneda_Operacion;
      ParamByName('Transaccion').AsString       := sTransaccion;
      ParamByName('Folio_Interno').AsString     := sFolio_Interno;
      Prepare;
      Open;
      if not eof then
         Result := FieldByName('Valor_Invertido_MC').AsFloat;
   end;

end;

function Busca_Monto_Transado_Perfil(sEmpresa          :String;
                                     sMoneda_Operacion :String;
                                     dFecha_Operacion  :TDateTime;
                                     sTransaccion      :String;
                                     sFolio_Interno    :String;
                                     sCartera          :String;
                                     sTipo_Instrum     :String;
                                     stipo_clasif      :String;
                                     sNodos_Hijos      :String;
                                     sMoneda_Instrum   :String;
                                     sPerfil           :String) :Double;
var fValor_invertido_mc : Double;
    fNodo_Clasif        : Double;
    bClasif             : Boolean;
    String_Dato         : TArr100_String;
    i                   : Integer;
begin
   with DmComunInversiones.Qry_General do
   begin
      sql.clear;
      sql.add(' SELECT a.Instrumento '
             +'       ,SUM(a.Valor_Invertido_MC) as Valor_Invertido_MC '
             +'   FROM QS_TRA_OMD_DET_RF a '
             +'       ,QS_TRA_OMD        d '
             +'       ,QS_SYS_LOGIN      c '
             +'       ,QS_FIN_INSTRUM    b '
             +'  WHERE d.Empresa           = :Empresa '
             +'    AND d.Fecha_Operacion   = :Fecha_Operacion '
             +'    AND d.Moneda_Operacion  = :Moneda_Operacion '
             +'    AND d.Transaccion       = :Transaccion '
             +'    AND d.Folio_Interno not in (SELECT f.Folio '
             +'                                  FROM qs_ctr_anulacion f'
             +'                                 WHERE f.empresa     = d.empresa'
             +'                                   AND f.transaccion = d.Transaccion'
             +'                                   AND f.Folio       = d.Folio_interno)'
             +'    AND d.empresa           = a.empresa '
             +'    AND d.Transaccion       = a.Transaccion '
             +'    AND d.Folio_Interno     = a.Folio_Interno '
             +'    AND a.Cartera           = :Cartera '
             +'    AND b.cod_instrumento   = a.instrumento '
             +'    AND b.Tipo_Instrumento  = :Tipo_Instrum ');
      if not Transaccion_Implica(sTransaccion,'PACTO') then
         sql.add(' AND a.Moneda_Instrum    = :Moneda_Instrum ');
      sql.add('    AND c.Login_Sistema     = d.Operador '
             +'    AND c.Perfil            = :Perfil '
             +'    AND d.Folio_Interno     <> :Folio_Interno '
             +'  GROUP BY a.Instrumento ');
      sql.add(' UNION ALL ');
      // Para el supervisor se le descuenta lo que ha aprobado tambien
      sql.add(' SELECT a.Instrumento '
             +'       ,SUM(e.monto_aprobado) as monto_aprobado '
             +'   FROM QS_TRA_OMD_DET_RF        a '
             +'       ,QS_TRA_OMD               d '
             +'       ,QS_FIN_INSTRUM           b '
             +'       ,QS_SUP_LIMITES_APROBADOS e '
             +'       ,QS_SYS_LOGIN             f '
             +'  WHERE d.Empresa           = :Empresa '
             +'    AND d.Fecha_Operacion   = :Fecha_Operacion '
             +'    AND d.Moneda_Operacion  = :Moneda_Operacion '
             +'    AND d.Transaccion       = :Transaccion '
             +'    AND d.Folio_Interno not in (SELECT f.Folio '
             +'                                  FROM qs_ctr_anulacion f '
             +'                                 WHERE f.empresa     = d.empresa '
             +'                                   AND f.transaccion = d.Transaccion '
             +'                                   AND f.Folio       = d.Folio_interno) '
             +'    AND d.empresa           = a.empresa '
             +'    AND d.Transaccion       = a.Transaccion '
             +'    AND d.Folio_Interno     = a.Folio_Interno '
             +'    AND a.Cartera           = :Cartera '
             +'    AND b.cod_instrumento   = a.instrumento '
             +'    AND b.Tipo_Instrumento  = :Tipo_Instrum ');
      if not Transaccion_Implica(sTransaccion,'PACTO') then
         sql.add(' AND a.Moneda_Instrum    = :Moneda_Instrum ');
      sql.add('    AND d.Folio_Interno     <> :Folio_Interno '
             +'    and e.empresa           = d.empresa '
             +'    and e.transaccion       = d.transaccion '
             +'    and e.folio_interno     = d.folio_interno '
             +'    AND e.tipo              = ''P'' '
             +'    and f.login_sistema     = e.login_supervisor '
             +'    and f.perfil            = :Perfil '
             +'  GROUP BY a.Instrumento ');
      ParamByName('Empresa').AsString           := sEmpresa;
      ParamByName('Fecha_Operacion').AsDate := dFecha_Operacion;
      ParamByName('Moneda_Operacion').AsString  := sMoneda_Operacion;
      ParamByName('Transaccion').AsString       := sTransaccion;
      ParamByName('Cartera').AsString           := sCartera;
      ParamByName('Tipo_Instrum').AsString      := sTipo_Instrum;
      if not Transaccion_Implica(sTransaccion,'PACTO') then
         ParamByName('Moneda_Instrum').AsString := sMoneda_Instrum;
      ParamByName('Perfil').AsString            := sPerfil;
      ParamByName('Folio_Interno').AsString     := sFolio_Interno;
      Prepare;
      Open;
      bClasif := false;
      fValor_invertido_mc := 0;
      while not eof do
      begin
         Determina_Nodo_Clasificacion('INSTRUM'
                                     ,FieldByName('Instrumento').AsString
                                     ,stipo_clasif
                                     ,fNodo_Clasif);
         Separa_Campos_String(',',' ',sNodos_Hijos,String_Dato);
         i := 1;
         while String_Dato[i] <> '' do
         begin
            if fNodo_Clasif = strtofloat(String_Dato[i]) then
               bClasif := true;
            inc(i);
         end;
         if bClasif then
            fValor_invertido_mc := fValor_invertido_mc + FieldByName('Valor_Invertido_MC').AsFloat;
         Next;
      end;
      Result := fValor_invertido_mc;
   end;
end;

function Existen_Limites(sEmpresa         :String;
                         sMoneda_Caja     :String;
                         sTransaccion     :String;
                         dFecha_Operacion :TDatetime) :Boolean;
begin
   Result := True;

   WITH DmComunInversiones.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('SELECT a.* '
            +'  FROM QS_SUP_LIMTRA_VIGENCIA a '
            +'      ,QS_SYS_TRAN_IMPLIC     d '
            +' WHERE a.Empresa            = :Empresa '
            +'   AND a.Moneda             = :Moneda '
            +'   AND a.Fecha_desde        <= :Fecha  '
            +'   AND (a.Fecha_Hasta       >= :Fecha OR a.Fecha_Hasta is null) '
            +'   AND d.Codigo_Transaccion = a.Transaccion '
            +'   AND d.IMPLICANCIA        = :Transaccion '
            );
     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Moneda').AsString      := sMoneda_Caja;
     ParamByName('Transaccion').asString := sTransaccion;
     ParamByName('Fecha').AsDate     := dFecha_Operacion;
     Open;
     if eof then
     begin
        Application.MessageBox('¡No Existen Limites Vigentes Definidos, No puede Ingresar Operación! '
                              ,'Transacción Financiera'
                              ,mb_OK);
        Result := False;
     end;
     Close;
   end;

end;

Procedure Aviso_Vigencia_Limites(sEmpresa     :String;
                                 sMoneda_Caja :String;
                                 sTransaccion :String);
var iDias     :Integer;
    sFecha    :String;
begin

   if sDriver = 'ORACLE' then
      sFecha := 'sysdate';
   if sDriver = 'MSSQL' then
      sFecha := 'GetDate()';
   if sDriver = 'INFORMIX' then
      sFecha := 'current';

   WITH DmComunInversiones.QRY_General do
   begin
      iDias := 0;
      SQL.Clear;
      SQL.Add('SELECT a.* '
             +'  FROM QS_SYS_PARAM_PROCESO a '
             +' WHERE a.Proceso = ''DIASMSJLIM'' ');
      Open;
      if not eof then
         iDias := FieldByName('Valor').AsInteger;
      Close;

      if iDias > 0 then
      begin
         SQL.Clear;
         SQL.Add('Select a.empresa '
                +'      ,a.moneda '
                +'      ,a.tipo,codigo_tipo '
                +'      ,a.fecha_desde '
                +'      ,a.fecha_hasta '
                +'      ,(a.fecha_hasta-'+sfecha+') as dias_para_vencer '
                +'  from QS_SUP_LIMTRA_VIGENCIA a '
                +' where a.empresa     = :Empresa '
                +'   and a.moneda      = :Moneda '
                +'   and a.transaccion = :Transaccion '
                +'   and a.fecha_desde = (select max(b.fecha_desde) '
                +'                          from QS_SUP_LIMTRA_VIGENCIA b '
                +'                         where b.empresa     = a.empresa '
                +'                           and b.moneda      = a.moneda '
                +'                           and b.tipo        = a.tipo '
                +'                           and b.codigo_tipo = a.codigo_tipo) '
                +'   and a.fecha_hasta is not null '
                +' group by a.empresa '
                +'         ,a.moneda '
                +'         ,a.tipo,codigo_tipo '
                +'         ,a.fecha_desde '
                +'         ,a.fecha_hasta '
                +'having (a.fecha_hasta-'+sfecha+') <= '+inttostr(iDias)
                );
         ParamByName('Empresa').AsString     := sEmpresa;
         ParamByName('Moneda').AsString      := sMoneda_Caja;
         ParamByName('Transaccion').AsString := sTransaccion;
         Open;
         if not eof then
         begin
            MuestraMensaje := TMuestraMensaje.Create(Application);
            MuestraMensaje.ListBox1.clear;
            MuestraMensaje.ListBox1.Items.add('');
            MuestraMensaje.ListBox1.Items.add('  A V I S O : ');
            MuestraMensaje.ListBox1.Items.add('');
            MuestraMensaje.ListBox1.Items.add('  !Hay definiciones de limites próximos a vencer!');
            MuestraMensaje.ListBox1.Items.add('');
            MuestraMensaje.ListBox1.Items.add('  Empresa | Moneda | Tipo | Codigo | F.Desde | F.Hasta');
            while not eof do
            begin
               MuestraMensaje.ListBox1.Items.add('  '+FieldByName('Empresa').AsString+' | '+FieldByName('Moneda').AsString+' | '
                                                +FieldByName('Tipo').AsString+' | '+FieldByName('Codigo_Tipo').AsString+' | '
                                                +FieldByName('Fecha_Desde').AsString+' | '+FieldByName('Fecha_Hasta').AsString);
               Next;
            end;
            MuestraMensaje.ShowModal;
         end;
         Close;
      end;
   end;
end;

Procedure Llena_Seleccion_Carteras(sTipo_Clasif   : String;
                                   sClasificacion : String);
var Empresa    : String;
    cartera    : String;
    sw_esta    : Boolean;
    sHolding   : String;
    i,k,p      : Integer;
    Sender     : TObject;
begin
   //inicio llena ventana carteras
   FrmConsolidaEmpresa := TFrmConsolidaEmpresa.Create(Application);
   with FrmConsolidaEmpresa do
   begin
      bClick_clasif              := True;
      sEmpresa_prg               := sEmpresa_Usuario;
      Ed_TipoClasif_Cartera.Text := sTipo_Clasif;
      Ed_Clasificacion.Text      := sClasificacion;
      With QRY_General do
      begin
         Sql.Clear;
         Sql.Add('SELECT  a.* '
                +'FROM qs_sys_perfil a '
                +'WHERE a.COD_PERFIL = '''+sperfil_usuario+''' ');
         Open;
         if not eof Then
         begin
            empresa := sEmpresa_Usuario;
            if FieldByname('CONSOLIDA').AsString = 'HOLDING' Then       // POR HOLDING
            begin
               Sql.Clear;
               Sql.Add(' SELECT a.CODIGO_HOLDING'
                      +'   FROM qs_sys_def_holding a'
                      +'  WHERE a.CODIGO_EMPRESA = :EMPRESA ');
               ParamByName('EMPRESA').AsString := sEmpresa_Usuario;
               Open;
               if eof then
               begin
                 Application.MessageBox(pchar('Empresa '+sEmpresa_Usuario+' no pertenece a ningun holding')
                                       ,' Informe Consolidado'
                                       , mb_OK);
                 Close;
                 exit;
               end;
               sHolding := FieldByName('CODIGO_HOLDING').AsString;
               Close;
               Sql.Clear;
               Sql.Add(' SELECT a.CODIGO_EMPRESA AS COD_EMPRESA, b.COD_CARTERA '
                      +' FROM   qs_sys_def_holding a, qs_fin_carteras b '
                      +' WHERE a.Codigo_Holding = :Codigo_Holding'
                      +'   AND a.CODIGO_EMPRESA = b.COD_EMPRESA ');
               ParamByName('Codigo_Holding').AsString := sHolding;
               Open;
            end
            else
               if FieldByname('CONSOLIDA').AsString = 'EMPRESA' Then       // POR EMPRESA
                begin
                   Sql.Clear;
                   Sql.Add(' SELECT a.COD_EMPRESA, a.COD_CARTERA '
                          +'   FROM qs_fin_carteras a '
                          +'  WHERE a.COD_EMPRESA = :empresa ');
                   ParamByname('empresa').AsString := empresa;
                   Open;
                end
             else
               If FieldByname('CONSOLIDA').AsString = 'MULTIEMP' Then       // POR HOLDING
                Begin
                   Sql.Clear;
                   Sql.Add(' SELECT a.COD_EMPRESA, a.COD_CARTERA '
                          +'   FROM qs_fin_carteras a '
                          );
                   Open;
                end
                else
                begin
                   Application.MessageBox('No se ha definido nivel de consolidación para este perfil de usuario '
                                         ,' Informe Consolidado'
                                         , mb_OK);

                   exit;
                end;
         end
         else
         begin
            Close;
            Sql.Clear;
            Sql.Add('SELECT a.COD_EMPRESA, a.COD_CARTERA '
                   +'  FROM QS_FIN_CARTERAS a'
                   +' WHERE a.COD_EMPRESA = :empresa '
                   );
            ParamByName('empresa').AsString := sEmpresa_Usuario;
            Open;
         end;
         with TIniFile.Create(sArchivo_Ini) do
         begin
            ReadSectionValues('Parametros Empresa',ListBox1.items);
            Free;
         end;
         For k := 0 to (ListBox1.items.count -1) do
         begin
            i := pos('=',ListBox1.items.strings[k]);
            p := pos('-',ListBox1.items.strings[k]);
            Empresa    := Trim(Copy(ListBox1.items.strings[k], i+1 ,p-i-1));
            cartera    := Trim(Copy(ListBox1.items.strings[k], p+1 ,20));
            ListTarget.Items.Add(empresa +' - '+cartera);
         end;
         while Not (EOF) do
         begin
            sw_esta := False;
            For k := 0 to (ListBox1.items.count -1) do
            begin
               i := pos('=',ListBox1.items.strings[k]);
               p := pos('-',ListBox1.items.strings[k]);
               Empresa    := Trim(Copy(ListBox1.items.strings[k], i+1 ,p-i-1));
               cartera    := Trim(Copy(ListBox1.items.strings[k], p+1 ,20));
               if (empresa +' - '+cartera) = (Trim(FieldByname('COD_EMPRESA').AsString)+' - '+Trim(FieldByname('COD_CARTERA').AsString)) Then
                  sw_esta := True;
            end;
            if Not sw_esta Then
               ListSource.Items.Add(Trim(FieldByname('COD_EMPRESA').AsString)+' - '+Trim(FieldByname('COD_CARTERA').AsString));
            Next;
         end;
         Close;
      end;
      Chk_ClasifCarteras.checked := true;
      Chk_ClasifCarterasClick(Sender);
      BTN_AceptarClick(Sender);
   end;
   FrmConsolidaEmpresa.Close;
   //fin llena ventana carteras
end;

Procedure Obtiene_MaxFec_Limite(sProceso             : String;
                                sCartera_Limite      : String;
                                Fecha_cierre         : TDateTime;
                                var dFecha_Cierre    : TDateTime;
                                var bresult          : Boolean);
begin
  bresult := True;
  with DmComunInversiones.qry_general do
  begin
    Close;
    Sql.Clear;
    Sql.Add( 'SELECT max(Fecha_proceso) as fecha_proceso FROM QS_TRA_251'
            +' WHERE Proceso           = :Proceso'
            +'   AND Fecha_proceso    <= :Fecha'
            +'   AND cartera           = :cartera ');

    Parambyname('Proceso').asString := sProceso;
    Parambyname('cartera').asString := sCartera_Limite;
    ParamByname('Fecha').AsDate := Fecha_Cierre;

    try
       Open;
       dFecha_Cierre := FieldByName('fecha_proceso').AsDateTime;
    except
       bresult := False;
    end;
  end;
end;

Function Exedio_Limites(sEmpresa       :String;
                        sCartera       :String;
                        dFecha_Proceso :TDateTime;
                        sTransaccion   :String;
                        sFolio_Interno :String) : Boolean;
begin
   with DmComunInversiones.QRY_General  do
   begin
      Close;
      SQL.Clear;
//// DC 17/05/2018
//      SQL.Add('select a.codigo_limite '
//             +'      ,((a.valor_pte_cartera - (select sum(y.valor_pte_mc_cpa) '
//             +'                                 from qs_tra_251_det y   '
//             +'				                         where y.fecha_proceso = :fecha_proceso '
//             +'				                           and exists ( select x.*'
//             +'				                                          from qs_tmp_vcto x '
//             +'				                                         where x.pid = :PID '
//             +'				        	                                 and x.fecha_proceso = y.fecha_proceso '
//             +'						                                       and x.proceso       = y.proceso '
//             +'						                                       and x.codigo_limite = y.codigo_limite '
//             +'						                               	       and x.folio_interno = y.folio_interno  '
//             +'						                               	       and x.transaccion   = y.transaccion)) )- a.Maximo_Permitido) as Monto_Exceso '
//// DC 17/05/2018
      SQL.Add('select a.* '
             +'  from qs_tra_251     a '
             +'      ,qs_tra_251_det c '
             +' where a.empresa           = :empresa '
             +'   and a.cartera           = :cartera '
             +'   and a.fecha_proceso     = :fecha_proceso '
             +'   and a.emisor            <> '''' '
             +'   and c.empresa           = a.empresa '
             +'   and c.fecha_proceso     = a.fecha_proceso '
             +'   and c.proceso           = a.proceso '
             +'   and c.codigo_limite     = a.codigo_limite '
             +'   and c.transaccion       = :transaccion '
             +'   and c.folio_interno     = :folio_interno '
             +'   and a.Maximo_Permitido < (select sum(y.valor_pte_mc_cpa) '
             +'                               from qs_tra_251_det y  '
             +'                              where y.empresa       = a.empresa  '
             +'				                         and y.fecha_proceso = a.fecha_proceso '
             +'				                         and y.proceso       = a.proceso '
             +'				                         and y.codigo_limite = a.codigo_limite '
             +'				                         and y.emisor        = a.emisor '
             +'				                         and not exists (select x.* '
             +'				                                           from qs_tmp_vcto x '
             +'				                                          where x.pid          = :PID '
             +'                                                   and x.fecha_proceso = y.fecha_proceso  '
             +'					                                          and x.proceso       = y.proceso    '
             +'					                                          and x.codigo_limite = y.codigo_limite  '
             +'					      	                                  and x.folio_interno = y.folio_interno '
             +'							                                      and x.transaccion   = y.transaccion) ) ' );
      SQL.Add(' UNION ');
      SQL.Add('select a.* '
             +'  from qs_tra_251     a '
             +'      ,qs_tra_251_det c '
             +' where a.empresa           = :empresa '
             +'   and a.cartera           = :cartera '
             +'   and a.fecha_proceso     = :fecha_proceso '
             +'   and a.emisor            = '''' '
             +'   and c.empresa           = a.empresa '
             +'   and c.fecha_proceso     = a.fecha_proceso '
             +'   and c.proceso           = a.proceso '
             +'   and c.codigo_limite     = a.codigo_limite '
             +'   and c.transaccion       = :transaccion '
             +'   and c.folio_interno     = :folio_interno '
             +'   and a.Maximo_Permitido < (select sum(y.valor_pte_mc_cpa) '
             +'                               from qs_tra_251_det y  '
             +'                              where y.empresa       = a.empresa  '
             +'				                         and y.fecha_proceso = a.fecha_proceso '
             +'				                         and y.proceso       = a.proceso '
             +'				                         and y.codigo_limite = a.codigo_limite '
             +'				                         and not exists (select x.* '
             +'				                                           from qs_tmp_vcto x '
             +'				                                          where x.pid          = :PID '
             +'                                                   and x.fecha_proceso = y.fecha_proceso  '
             +'					                                          and x.proceso       = y.proceso    '
             +'					                                          and x.codigo_limite = y.codigo_limite  '
             +'					      	                                  and x.folio_interno = y.folio_interno '
             +'							                                      and x.transaccion   = y.transaccion) ) ' );

      Parambyname('Empresa').asString         := sEmpresa;
      Parambyname('Cartera').asString         := sCartera;
      Parambyname('Fecha_Proceso').AsDate     := dFecha_Proceso;
      ParamByName('transaccion').asString     := stransaccion;
      ParamByName('folio_interno').asString   := sFolio_Interno;
      ParamByName('PID').AsFloat              := Application.handle;

      try
         Open;
      except on E: EFDDBEngineException do
        begin
           Result := False;
           ShowError(E);
           Close;
           Exit;
        end;
      end;

      if eof then
         Result := False
      else
         Result := True;
      Close;
   end;
end;

Function Exedio_Limites_RV(sEmpresa       :String;
                           sCartera       :String;
                           dFecha_Proceso :TDateTime;
                           sNemotecnico   :String) : Boolean;
begin
  with DmComunInversiones.QRY_General  do
   begin
      Close;
      SQL.Clear;
      SQL.Add('select a.Proceso '
             +'  from qs_tra_251     a '
             +'      ,qs_tra_251_det c '
             +' where a.empresa           = :empresa '
             +'   and a.cartera           = :cartera '
             +'   and a.fecha_proceso     = :fecha_proceso '
             +'   and a.valor_pte_cartera > a.Maximo_Permitido '
             +'   and c.empresa           = a.empresa '
             +'   and c.fecha_proceso     = a.fecha_proceso '
             +'   and c.proceso           = a.proceso '
             +'   and c.codigo_limite     = a.codigo_limite '
             +'   and c.nemotecnico      in '+sNemotecnico );

      Parambyname('Empresa').asString         := sEmpresa;
      Parambyname('Cartera').asString         := sCartera;
      Parambyname('Fecha_Proceso').AsDate := dFecha_Proceso;
//      ParamByName('nemotecnico').asString     := sNemotecnico;
      try
         Open;
      except on E: EFDDBEngineException do
        begin
           Result := False;
           ShowError(E);
           Close;
           Exit;
        end;
      end;
      if eof then
         Result := False
      else
         Result := True;
      Close;
   end;
end;

Function Busca_Monto_excedido(sEmpresa       : String;
                              sTransaccion   : String;
                              sFolio_Interno : String) :Double;
begin
   with DmComunInversiones.QRY_General  do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(Monto_Operacion) as Monto_Operacion '
             +'      ,SUM(Monto_Aprobado)  as Monto_Aprobado '
             +'  FROM qs_sup_limites_aprobados '
             +' WHERE Folio_interno = :Folio_interno '
             +'   AND Transaccion   = :Transaccion '
             +'   AND Empresa       = :Empresa '
             +'   AND Tipo          = ''P'' ');
      ParamByName('transaccion').asString        := sTransaccion;
      ParamByName('folio_interno').asString      := sFolio_Interno;
      ParamByName('empresa').asString            := sEmpresa;
      try
         Open;
      except on E: EFDDBEngineException do
        begin
           Result := 0;
           ShowError(E);
           Close;
           Exit;
        end;
      end;
      if eof then
         Result := 0
      else
         if FieldByName('Monto_Aprobado').asFloat > FieldByName('Monto_Operacion').asFloat then
            Result := FieldByName('Monto_Operacion').asFloat
         else
            Result := FieldByName('Monto_Aprobado').asFloat;
      Close;
   end;
end;

Function Empresas_Perfil(sEmpresa         :String;
                         sPerfil          :String) :String;
var sHolding         :String;
    sString_Empresas :String;
    fRegistros       : Double;
begin
   Result := '';

   with DmComunInversiones.QRY_General  do
   begin
      SQL.Clear;
      Sql.Clear;
      Sql.Add('SELECT a.* '
             +'  FROM qs_sys_perfil a '
             +' WHERE a.COD_PERFIL = '''+sperfil+''' ');
      Open;
      if not eof then
      begin
         if FieldByname('CONSOLIDA').AsString = 'HOLDING' then       // POR HOLDING
         begin
            Sql.Clear;
            Sql.Add('SELECT a.CODIGO_HOLDING'
                   +'  FROM qs_sys_def_holding a'
                   +' WHERE a.CODIGO_EMPRESA = :EMPRESA ');
            ParamByName('EMPRESA').AsString := sEmpresa;
            Open;
            if eof then
            begin
               Application.MessageBox(pchar('Empresa '+sEmpresa+' no pertenece a ningun holding')
                                     ,' Informe Consolidado'
                                     , mb_OK);
               Close;
               Result := '';
               exit;
            end;
            sHolding := FieldByName('CODIGO_HOLDING').AsString;
            Close;
            Sql.Clear;
            Sql.Add('SELECT COUNT(*) as Nro_Reg '
                   +'  FROM qs_fin_carteras a ' );
            Open;

            fRegistros := FieldByName('Nro_Reg').AsFloat;

            if fRegistros = 0 then
            begin
               Result := sEmpresa;  // Cualquier cosa sirve cuando no existen aun carteras en una empresa (nueva)
               exit;
            end;

            Close;
            Sql.Clear;
            Sql.Add('SELECT DISTINCT a.CODIGO_EMPRESA as COD_EMPRESA '
                   +'  FROM qs_sys_def_holding a '
                   +'      ,qs_fin_carteras    b '
                   +' WHERE a.Codigo_Holding = :Codigo_Holding'
                   +'   AND a.CODIGO_EMPRESA = b.COD_EMPRESA ');
            ParamByName('Codigo_Holding').AsString := sHolding;
            Open;
         end
         else
            if FieldByname('CONSOLIDA').AsString = 'EMPRESA' then       // POR EMPRESA
            begin
                Sql.Clear;
                Sql.Add('SELECT DISTINCT a.COD_EMPRESA '
                       +'  FROM qs_fin_carteras a '
                       +' WHERE a.COD_EMPRESA = :empresa ');
                ParamByname('empresa').AsString := sEmpresa;
                Open;

                if eof then    // Por si no existe ninguna
                begin
                   Result := sEmpresa;
                   exit;
                end;
             end
          else
            If FieldByname('CONSOLIDA').AsString = 'MULTIEMP' Then       // POR HOLDING
             Begin
                Sql.Clear;
                Sql.Add(' SELECT a.COD_EMPRESA, a.COD_CARTERA '
                       +'   FROM qs_fin_carteras a '
                       );
                Open;
             end
             else
             begin
                Application.MessageBox('No se ha definido nivel de consolidación para este perfil de usuario '
                                      ,' Informe Consolidado'
                                      , mb_OK);

                exit;
             end;
      end
      else
      begin
         Close;
         Sql.Clear;
         Sql.Add('SELECT DISTINCT a.COD_EMPRESA'
                +'  FROM QS_FIN_CARTERAS a'
                +' WHERE a.COD_EMPRESA = :empresa ');
         ParamByName('empresa').AsString := sEmpresa;
         Open;
      end;
      sString_Empresas := '(';
      while not eof do
      begin
         sString_Empresas := sString_Empresas+''''+FieldByName('COD_EMPRESA').AsString+'''';
         next;
         if not eof then
            sString_Empresas := sString_Empresas+',';
      end;
      sString_Empresas := sString_Empresas+')';
   end;

   Result := sString_Empresas;

end;

Function String_Empresas(fPid :Double) :String;
var sString_Empresas :String;
begin
   Result := '';
   with DmComunInversiones.QRY_General  do
   begin
      SQL.Clear;
      SQL.Clear;
      SQL.Add('SELECT Distinct a.Empresa '
             +'  FROM QS_SYS_PARAM_EMPRESA a'
             +'      ,QS_SYS_IDENTIDAD     b'
             +' WHERE a.pid = '+Floattostr(Application.Handle)
             +'   AND b.Codigo_Identidad = a.Empresa '
             +'   AND a.EMPRESA NOT IN (SELECT  x.CODIGO_OBJETO FROM QS_SYS_EST_CLA x WHERE x.CODIGO_OBJETO = a.EMPRESA)'
             +' ORDER BY Empresa');
      Open;
      sString_Empresas := '('' ''';
      while NOT EOF do
      begin
         sString_Empresas := sString_Empresas+','''+FieldByName('Empresa').AsString+'''';
         Next;
      end;
      sString_Empresas := sString_Empresas+')';
   end;
   Result := sString_Empresas;
end;

Function String_Seleccion(sParametro : String) :String;
var
  sString_Seleccion :String;
begin
  Result := '';
  with DmComunInversiones.QRY_General  do
  begin
    Close;
    SQL.Clear;
    Sql.Add('SELECT Distinct x.Valor FROM QS_SYS_PARAM_PROCESO x'
           +' WHERE x.Parametro = :Parametro'
           +'   AND x.Proceso   = :Proceso'
           +' ORDER BY x.Valor');

    Parambyname('Parametro').asString := sParametro;
    Parambyname('Proceso').asString   := IntToStr(Application.Handle);

    Open;

    sString_Seleccion := '('' ''';
    while NOT EOF do
    begin
      sString_Seleccion := sString_Seleccion+','''+FieldByName('Valor').AsString+'''';
      Next;
    end;
    sString_Seleccion := sString_Seleccion+')';
  end;
  Result := sString_Seleccion;
end;

Function String_Seleccion(sProceso   : String;
                          sParametro : String) :String;
var
  sString_Seleccion :String;
begin
  Result := '';
  with DmComunInversiones.QRY_General  do
  begin
    Close;
    SQL.Clear;
    Sql.Add('SELECT Distinct x.Valor FROM QS_SYS_PARAM_PROCESO x'
           +' WHERE x.Parametro = :Parametro'
           +'   AND x.Proceso   = :Proceso'
           +' ORDER BY x.Valor');

    Parambyname('Parametro').asString := sParametro;
    Parambyname('Proceso').asString   := sProceso;

    Open;

    sString_Seleccion := '('' ''';
    while NOT EOF do
    begin
      sString_Seleccion := sString_Seleccion+','''+FieldByName('Valor').AsString+'''';
      Next;
    end;
    sString_Seleccion := sString_Seleccion+')';
  end;
  Result := sString_Seleccion;
end;

Function String_Seleccion_New(sParametro : String) :String;
var
  sString_Seleccion :String;
begin
  with DmComunInversiones.QRY_General  do
  begin
    Close;
    SQL.Clear;
    Sql.Add('SELECT Distinct x.Valor FROM QS_SYS_PARAM_SELECCCION x'
           +' WHERE x.Pid       = :Pid'
           +'   AND x.Parametro = :Parametro'
           +' ORDER BY x.Valor');

    Parambyname('Pid').AsFloat        := Application.Handle;
    Parambyname('Parametro').asString := sParametro;

    Open;

    sString_Seleccion := '('' ''';
    while NOT EOF do
    begin
      sString_Seleccion := sString_Seleccion+','''+FieldByName('Valor').AsString+'''';
      Next;
    end;
    sString_Seleccion := sString_Seleccion+')';
  end;
  Result := sString_Seleccion;
end;

Procedure String_Seleccion_Mult(sParametro         : String;
                                 sSeparador         : char;
                             var sString_Seleccion1 : String;
                             var sString_Seleccion2 : String);
var String_Dato : TArr100_String;
begin
  with DmComunInversiones.QRY_General  do
  begin
    Close;
    SQL.Clear;
    Sql.Add('SELECT Distinct x.Valor FROM QS_SYS_PARAM_SELECCCION x'
           +' WHERE x.Pid       = :Pid'
           +'   AND x.Parametro = :Parametro'
           +' ORDER BY x.Valor');

    Parambyname('Pid').AsFloat        := Application.Handle;
    Parambyname('Parametro').asString := sParametro;

    Open;

    sString_Seleccion1 := '('' ''';
    sString_Seleccion2 := '('' ''';
    while NOT EOF do
    begin
      Separa_Campos_String(sSeparador,'@',FieldByName('Valor').AsString,String_Dato);
      if not BuscaStr(sString_Seleccion1,''''+Trim(String_Dato[1])+'''') then
         sString_Seleccion1 := sString_Seleccion1+','''+Trim(String_Dato[1])+'''';
      sString_Seleccion2 := sString_Seleccion2+','''+Trim(String_Dato[2])+'''';
      Next;
    end;
    sString_Seleccion1 := sString_Seleccion1+')';
    sString_Seleccion2 := sString_Seleccion2+')';
  end;
end;

Function String_Carteras(fPid :Double) :String;
var sString_Carteras :String;
begin
   Result := '';
   with DmComunInversiones.QRY_General  do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Distinct a.Cartera '
             +'  FROM QS_SYS_PARAM_EMPRESA a '
             +'      ,QS_FIN_CARTERAS      b '
             +' WHERE a.pid = '+Floattostr(Application.Handle)
             +'   AND b.Cod_Cartera = a.Cartera '
             +' ORDER BY Cartera');
      Open;
      sString_Carteras := '('' ''';
      while NOT EOF do
      begin
         sString_Carteras := sString_Carteras+','''+FieldByName('Cartera').AsString+'''';
         Next;
      end;
      sString_Carteras := sString_Carteras+')';
   end;
   Result := sString_Carteras;
end;

Function String_Transaccion(sTransaccion:String) :String;
var sString_Transaccion :String;
begin
   Result := '';
   with DmComunInversiones.QRY_General  do
   begin
      SQL.Clear;
      SQL.Clear;
      SQL.Add('SELECT Distinct Codigo_Transaccion FROM qs_sys_tran_implic WHERE implicancia = :implicancia ORDER BY Codigo_Transaccion');
      ParamByName('implicancia').AsString := sTransaccion;
      Open;
      sString_Transaccion := '('' ''';
      while NOT EOF do
      begin
         sString_Transaccion := sString_Transaccion+','''+FieldByName('Codigo_Transaccion').AsString+'''';
         Next;
      end;
      sString_Transaccion := sString_Transaccion+')';
   end;
   Result := sString_Transaccion;
end;

Function Existe_en_TSA(   dFecha_TSA     : TDatetime;
                          sEmpresa,
                          sTransaccion,
                          sFolio_Interno : String;
                          fItem_Omd      : Double;
                          sNemotecnico   : String;
                          bProc_TSA      : Boolean;
                          sProceso_Tsa   : String
                          ) : Boolean;
begin


  Result := False;

  if sNemotecnico <> '' then
  begin
     With DmComunInversiones.Qry_Varios do
     begin
         Sql.Clear;
         SQL.Add('SELECT a.Folio_Interno'
                +'  FROM QS_SUP_TSA_INCLUYE a'
                +'      ,QS_TRA_OMD_DET_RF b'
                +' WHERE a.Fecha_Cierre  = :Fecha_Cierre'
                +'   AND b.Folio_Interno = a.Folio_Interno'
                +'   AND b.Item_omd      = a.Item_omd'
                +'   AND b.Transaccion   = a.Transaccion'
                +'   AND b.Empresa       = a.Empresa'
                +'   AND b.Nemotecnico   = :Nemotecnico '  );
         if bProc_TSA then
         begin
            SQL.Add('   AND a.Proceso       = :Proceso' );
            ParamByName('Proceso').asString          := sProceso_Tsa;
         end;
         ParamByName('Fecha_Cierre').AsDate       := dFecha_TSA;
         ParamByName('Nemotecnico').AsString      := sNemotecnico;
         Open;
         if Not Fieldbyname('Folio_Interno').IsNull then
            Result := True;
         Close;
     end;
  end
  else
  begin
     With DmComunInversiones.Qry_Varios do
     begin
         Sql.Clear;
         SQL.Add('SELECT a.Folio_Interno'
                +'  FROM QS_SUP_TSA_INCLUYE a'
                +' WHERE a.Fecha_Cierre  = :Fecha_Cierre'
                +'   AND a.Empresa       = :Empresa'
                +'   AND a.Transaccion   = :Transaccion'
                +'   AND a.Folio_Interno = :Folio_Interno'
                +'   AND a.Item_Omd      = :Item_Omd' );
         if bProc_TSA then
         begin
            SQL.Add('   AND Proceso       = :Proceso' );
            ParamByName('Proceso').asString          := sProceso_Tsa;
         end;
         ParamByName('Fecha_Cierre').AsDate       := dFecha_TSA;
         ParamByName('Empresa').AsString          := sEmpresa_Usuario;
         ParamByName('Transaccion').asString      := sTransaccion;
         ParamByName('Folio_Interno').asString    := sFolio_Interno;
         ParamByName('Item_Omd').asFloat          := fItem_Omd;
         Open;
         if Not Fieldbyname('Folio_Interno').IsNull then
            Result := True;
         Close;
     end;
  end;
end;

Function Existe_Rol_TSA(  dFecha_TSA     : TDatetime;
                          sEmpresa,
                          sRol           : String   ) : Boolean;
begin

  Result := False;

  With DmComunInversiones.Qry_Varios do
  begin
     Sql.Clear;
     SQL.Add('SELECT a.Rol'
            +'  FROM QS_SUP_TSA_ROLES a'
            +' WHERE a.Fecha_Cierre  = :Fecha_Cierre'
            +'   AND a.Rol           = :Rol '
            +'   AND a.Empresa       = :Empresa '
            );
     ParamByName('Fecha_Cierre').AsDate   := dFecha_TSA;
     ParamByName('Rol').AsString              := sRol;
     ParamByName('Empresa').AsString          := sEmpresa;
     Open;
     if Not Fieldbyname('Rol').IsNull then
        Result := True;
     Close;
  end;
end;

function String_Implicancia(sImplicancia :String): String;
var
   sString_Implicancia : String;
begin
   with DmComunInversiones.QRY_General do
   begin
     Sql.Clear;
     SQL.Add('SELECT codigo_transaccion  '
            +'  FROM QS_SYS_TRAN_IMPLIC'
            +' WHERE IMPLICANCIA = :implicancia '
            );
     Parambyname('implicancia').AsString := sImplicancia;
     Open;
     sString_Implicancia := '';
     while NOT EOF do
     begin
        if sString_Implicancia = '' then
           sString_Implicancia := ' ((transaccion = '''+FieldByName('codigo_transaccion').AsString+''')'
        else
           sString_Implicancia := sString_Implicancia+' or (transaccion = '''+FieldByName('codigo_transaccion').AsString+''')';
        Next;
     end;
   end;
   if sString_Implicancia = '' then
      Result := '('''')'
   else
      Result := sString_Implicancia+')';

end;

function String_Implicancia_Inversa(sImplicancia :String): String;
var
   sString_Implicancia : String;
begin
   with DmComunInversiones.QRY_General do
   begin
     Sql.Clear;
     SQL.Add('SELECT codigo_transaccion  '
            +'  FROM QS_SYS_TRAN_IMPLIC'
            +' WHERE IMPLICANCIA = :implicancia '
            );
     Parambyname('implicancia').AsString := sImplicancia;
     Open;
     sString_Implicancia := '';
     while NOT EOF do
     begin
        if sString_Implicancia = '' then
           sString_Implicancia := ' ((transaccion <> '''+FieldByName('codigo_transaccion').AsString+''')'
        else
           sString_Implicancia := sString_Implicancia+' or (transaccion <> '''+FieldByName('codigo_transaccion').AsString+''')';
        Next;
     end;
   end;
   if sString_Implicancia = '' then
      Result := ''
   else
      Result := sString_Implicancia+')';

end;

procedure Proyecta_Flujos_por_Curvas( RegDes                  : TReg_descriptor;
                                      Reg_Fechas              : TRegistro_Fechas;
                                      iCupon_a_proyectar      : Integer;
                                      sMetodo_Tasa_Referencia : String;
                                      var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                      var sModulo_Err         : String;
                                      var sString_Err         : String;
                                      var Result              : Boolean);
var
 iBase_Tasa            : integer;
 sTipoInteres_Tasa     : string;
 iBaseMensual_Tasa     : integer;
 sTipoCalculoDias_Tasa : String;
 iVigenciaValor_Tasa   : Integer;
 iVigencia_Meses_Tasa  : Integer;
 sPais_Tasa            : String;

 sTipo_Tasa_Tasa       : String;
 fPeriodo_Tasa         : Double;
 sAnualidad_Tasa       : String;
 fBase_Porcen_Tasa     : Double;

 iBase_Curva            : integer;
 sTipoInteres_Curva     : string;
 iBaseMensual_Curva     : integer;
 sTipoCalculoDias_Curva : String;
 iVigenciaValor_Curva   : Integer;
 iVigencia_Meses_Curva  : Integer;
 sPais_Curva            : String;

 sTipo_Tasa_Curva       : String;
 fPeriodo_Curva         : Double;
 sAnualidad_Curva       : String;
 fBase_Porcen_Curva     : Double;

 iDias_Flujo            : Double;
 iDias_Al_Corte         : Double;
 iAnosEnteros           : Double;
 iAnosFraccion          : Double;
 iMesesEnteros          : Double;

 sTipo_Ajuste_Curva     : String;
 iDecimal_Ajuste_Curva  : Integer;

 bPrimero         : Boolean; // Para la primera proyeccion de flujo se necesita calcula el Factor de descuento final del cupon anterior.

 RegParamMargen   : TRegParamMargen;


begin
   if sMetodo_Tasa_Referencia <> 'CURVA_FIJA' then
   begin
     if (iCupon_a_proyectar = 1) then
     begin
        sModulo_Err := 'Proyección de flujos por curvas';
        sString_Err := 'No se puede proyectar el primer flujo';
        Result      := False;
        exit;
     end;

     Obtener_Tasa_base_Mem(Array_Mem_Desarr[iCupon_a_proyectar].Tipo_Tasa
                          ,iBase_Tasa
                          ,sTipoInteres_Tasa
                          ,iBaseMensual_Tasa
                          ,sTipoCalculoDias_Tasa
                          ,iVigenciaValor_Tasa
                          ,iVigencia_Meses_Tasa
                          ,sPais_Tasa
                          ,sModulo_err
                          ,sString_err
                          ,Result);
     if NOT Result then
        exit;

     if (iBase_Tasa = 0) then
     begin
        sModulo_Err := 'Proyección de flujos por curvas';
        sString_Err := 'Base días para '+Array_Mem_Desarr[iCupon_a_proyectar].Tipo_Tasa+' no puede ser cero';
        Result      := False;
        exit;
     end;

     Obtener_Base_Conversion_Mem(Array_Mem_Desarr[iCupon_a_proyectar].Tipo_Tasa
                                ,sTipo_Tasa_Tasa
                                ,fPeriodo_Tasa
                                ,sAnualidad_Tasa
                                ,fBase_Porcen_Tasa
                                ,sModulo_Err
                                ,sString_Err
                                ,Result
                                );
     if NOT Result then
        exit;
   end;

   WITH dmComunInversiones.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('SELECT b.Tasa_Equiv');
     SQL.Add('  FROM Qs_Fin_Tasa_Conver b');
     SQL.Add(' WHERE b.Cod_Tasa_Base = :Cod_Tasa_Base');

     ParamByName('Cod_Tasa_Base').AsString := Array_Mem_Desarr[iCupon_a_proyectar].Tipo_Tasa;
     Prepare;
     Open;

     if ((FieldByName('Tasa_Equiv').AsString = '') or (FieldByName('Tasa_Equiv').IsNull)) then
     begin
       sModulo_Err := 'Proyección de flujos por curvas';
       sString_Err := 'No esta definida tasa equivalente (curva proyección) para: '+Array_Mem_Desarr[iCupon_a_proyectar].Tipo_Tasa;
       Result      := False;
       Close;
       exit;
     end;

     Array_Mem_Desarr[iCupon_a_proyectar].Curva_Proy_utilizada := FieldByName('Tasa_Equiv').AsString;
     Close;
   end;

      Obtener_Tasa_base_Mem(Array_Mem_Desarr[iCupon_a_proyectar].Curva_Proy_utilizada
                           ,iBase_Curva
                           ,sTipoInteres_Curva
                           ,iBaseMensual_Curva
                           ,sTipoCalculoDias_Curva
                           ,iVigenciaValor_Curva
                           ,iVigencia_Meses_Curva
                           ,sPais_Curva
                           ,sModulo_err
                           ,sString_err
                           ,Result);
      if NOT Result then
         exit;

      if (iBase_Curva = 0) then
      begin
         sModulo_Err := 'Proyección de flujos por curvas';
         sString_Err := 'Base días para '+Array_Mem_Desarr[iCupon_a_proyectar].Curva_Proy_utilizada+' no puede ser cero';
         Result      := False;
         exit;
      end;

      Obtener_Base_Conversion_Mem(Array_Mem_Desarr[iCupon_a_proyectar].Tipo_Tasa
                                 ,sTipo_Tasa_Curva
                                 ,fPeriodo_Curva
                                 ,sAnualidad_Curva
                                 ,fBase_Porcen_Curva
                                 ,sModulo_Err
                                 ,sString_Err
                                 ,Result
                                 );
      if NOT Result then
         exit;

   Leer_MonRedon_Mem( Array_Mem_Desarr[iCupon_a_proyectar].Curva_Proy_utilizada
                     ,Reg_Fechas.Fecha_Calculo
                     ,sTipo_Ajuste_Curva
                     ,iDecimal_Ajuste_Curva);

   // Use el RegParamMargen ya que la funcion lee_Tasas_Tramos se hizo con ese parametro.
   RegParamMargen.Tasa_Base_1     := Array_Mem_Desarr[iCupon_a_proyectar].Curva_Proy_utilizada;
   RegParamMargen.Tasa_Base_2     := '';
   RegParamMargen.Interpolacion_1 := 'I';

      // Se devuelve al cupón anterior para calcular el factor de descuento
   bPrimero := True;
   if NOT (sMetodo_Tasa_Referencia = 'CURVA_FIJA') then  // Si es fija no es necesario que se devuelva F.I.30-05-2016 !!!
      iCupon_a_proyectar := iCupon_a_proyectar - 1;


   while (iCupon_a_proyectar = Array_Mem_Desarr[iCupon_a_proyectar].Nro_cupon) and
         (iCupon_a_proyectar <= Max_Nro_Cupones) do
   begin
     Calculo_de_dias(Reg_Fechas.Fecha_Calculo
                    ,Array_Mem_Desarr[iCupon_a_proyectar].Fecha_Vcto
                    ,sTipoCalculoDias_Curva
                    ,sPais_Curva
                    ,iDias_Al_Corte
                    ,iAnosEnteros
                    ,iAnosFraccion
                    ,iMesesEnteros);

     Array_Mem_Desarr[iCupon_a_proyectar].Dias_Proyeccion := iDias_Al_Corte;

     Lee_Tasa_Tramos( RegParamMargen
                     ,Reg_Fechas.Fecha_Calculo
                     ,iDias_Al_Corte
                     ,False         //bDia_Habil
                     ,Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Proyeccion
                     ,fNoUtilizado
                     ,sModulo_Err
                     ,sString_Err
                     ,Result);
     if NOT Result then
        exit;

     if sMetodo_Tasa_Referencia = 'CURVA_FIJA' then  // El metodo CURVA_FIJA, toma el valor de la tas directo de la tabla a diferencia del curvas que realizad un descuento
     begin
       Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Flujo := Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Proyeccion;
       Array_Mem_Desarr[iCupon_a_proyectar].Real_Estimado         := 'CURVA_FIJA';

     end
     else
     begin
       // Factor de descuento Proyeccion (BTG)
       Array_Mem_Desarr[iCupon_a_proyectar].Real_Estimado         := 'CURVAS';
       if sTipoInteres_Curva = 'C' then
          Array_Mem_Desarr[iCupon_a_proyectar].FD_Proyeccion_fin := 1 / Interes_Compuesto( Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Proyeccion
                                                                                       ,fBase_Porcen_Curva
                                                                                       ,iDias_Al_Corte
                                                                                       ,iBase_Curva)
       else
          Array_Mem_Desarr[iCupon_a_proyectar].FD_Proyeccion_fin := 1 / Interes_Simple( Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Proyeccion
                                                                                    ,fBase_Porcen_Curva
                                                                                    ,iDias_Al_Corte
                                                                                    ,iBase_Curva);

       Array_Mem_Desarr[iCupon_a_proyectar].Curva_Proy_utilizada  := RegParamMargen.Tasa_Base_1;

       if bPrimero then
       begin
         bPrimero := False;
         iCupon_a_proyectar := iCupon_a_proyectar + 1;
         Continue;
       end;

       Array_Mem_Desarr[iCupon_a_proyectar].FD_Proyeccion_Inicio := Array_Mem_Desarr[iCupon_a_proyectar-1].FD_Proyeccion_fin;

       if (Array_Mem_Desarr[iCupon_a_proyectar].FD_Proyeccion_fin) = 0 then
       begin
           sModulo_Err := 'Proyección de flujos por curvas';
           sString_Err := 'No se puede proyectar cupon '+IntToStr(iCupon_a_proyectar)+ 'Factor Descuento Final Proyeccion es cero';
           Result      := False;
           exit;
       end;

       Calculo_de_dias(Array_Mem_Desarr[iCupon_a_proyectar].Fecha_Vcto_Anterior
                      ,Array_Mem_Desarr[iCupon_a_proyectar].Fecha_Vcto
                      ,sTipoCalculoDias_Tasa
                      ,sPais_Tasa
                      ,iDias_Flujo
                      ,iAnosEnteros
                      ,iAnosFraccion
                      ,iMesesEnteros);

       Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Flujo := (Array_Mem_Desarr[iCupon_a_proyectar].FD_Proyeccion_Inicio /
                                                           Array_Mem_Desarr[iCupon_a_proyectar].FD_Proyeccion_fin -1) /
                                                           (iDias_Flujo/ iBase_Tasa) ;

       Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Flujo := Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Flujo * fBase_Porcen_Curva;

     end;

     Array_Mem_Desarr[iCupon_a_proyectar].Valor_Tasa := Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Flujo;

     aplica_operacion(Array_Mem_Desarr[iCupon_a_proyectar].Tasa_Flujo
                     ,Array_Mem_Desarr[iCupon_a_proyectar].Factor
                     ,Array_Mem_Desarr[iCupon_a_proyectar].Operacion
                     ,fBase_Porcen_Curva
                     ,sTipo_Ajuste_Curva
                     ,iDecimal_Ajuste_Curva
                     ,Array_Mem_Desarr[iCupon_a_proyectar].Valor_Tasa
                     ,sModulo_Err
                     ,sString_Err
                     ,Result);

    if NOT Result then
       exit;

     iCupon_a_proyectar := iCupon_a_proyectar + 1;
   end;
end;

Function Transaccion_Anticipada(sEmpresa              : String;
                                sTransaccion          : String;
                                sFolio_Interno        : String;
                                dFecha_Vcto_Cupon     : TDateTime;
                            var fValor_Nocional_Corto : Double;
                            var fValor_Nocional_Largo : Double;
                            var fAnticipado_dia_Corto : Double;
                            var fAnticipado_dia_Largo : Double) :Boolean;
begin
   Result := False;
   fValor_Nocional_Corto := 0;
   fValor_Nocional_Largo := 0;
   fAnticipado_dia_Corto := 0;
   fAnticipado_dia_Largo := 0;
   with dmComunInversiones.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Fecha_Prepago, sum(Valor_Nocional_Corto) as Valor_Nocional_Corto, sum(Valor_Nocional_Largo) as Valor_Nocional_Largo ');
      SQL.Add('  FROM QS_TRA_OMD_PREPAGO_PACTO a ');
      SQL.Add(' WHERE a.FOLIO_INTERNO_REL = :Folio_Interno_omd ');
      SQL.Add('   AND a.Transaccion_Rel   = :Transaccion_omd ');
      SQL.Add('   AND a.Empresa_Rel       = :Empresa ');
      if dFecha_Vcto_Cupon <> StrToDate(Fecha_Nula) then       // esto es para la ayuda de transacciones de RF
      begin
         //ggarcia 20-10-2021 SQL.Add('   AND a.Fecha_Prepago    <= :Fecha_Vcto ');
         SQL.Add('   AND a.Fecha_Prepago    < :Fecha_Vcto ');
         ParamByName('Fecha_Vcto').AsDate   := dFecha_Vcto_Cupon;
      end;
      SQL.Add('   AND a.folio_interno NOT IN (SELECT folio ');
      SQL.Add('                                 FROM qs_ctr_anulacion b ');
      SQL.Add('                                WHERE b.folio       = a.folio_interno ');
      SQL.Add('                                  AND b.transaccion = a.transaccion ');
      SQL.Add('                                  AND b.empresa     = a.empresa) ');
      SQL.Add('GROUP BY Fecha_Prepago');
      ParamByName('Folio_Interno_omd').AsString := sFolio_Interno;
      ParamByName('Transaccion_omd').AsString   := sTransaccion;
      ParamByName('Empresa').AsString           := sEmpresa;
      Open;
      while not eof do
      begin
         fValor_Nocional_Corto := fValor_Nocional_Corto + Fieldbyname('Valor_Nocional_Corto').AsFloat;
         fValor_Nocional_Largo := fValor_Nocional_Largo + Fieldbyname('Valor_Nocional_Largo').AsFloat;
         if Fieldbyname('Fecha_Prepago').AsDateTime = dFecha_Vcto_Cupon-1 then
         begin
            fAnticipado_dia_Corto := fAnticipado_dia_Corto + Fieldbyname('Valor_Nocional_Corto').AsFloat;
            fAnticipado_dia_Largo := fAnticipado_dia_Largo + Fieldbyname('Valor_Nocional_Largo').AsFloat;
         end;
         Result := True;
         Next;
      end;
      Close;
   end;
end;

procedure Busca_Valores_Anticipo_Derivado(sEmpresa           :String;
                                          sTransaccion       :String;
                                          sFolio_interno     :String;
                                          dFecha_Calculo     :TDateTime;
                                      var dFecha_Anticipo    :TDateTime;
                                      var sMoneda_Anticipo   :String;
                                      var fTC_Anticipo       :Double;
                                      var fUnwind_por_Cobrar :Double;
                                      var fUnwind_por_Pagar  :Double);
begin
   fUnwind_por_Cobrar := 0;
   fUnwind_por_Pagar  := 0;
   With dmComunInversiones.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT p.Fecha_Prepago    as Fecha_Prepago    ');
      SQL.Add('      ,p.Moneda_Anticipo  as Moneda_Anticipo  ');
      SQL.Add('      ,p.Valor_Pactado_UM as Valor_Empresa    ');
      SQL.Add('      ,p.Valor_Pactado_MC as Valor_Contraparte');
      SQL.Add('      ,q.valor            as Tipo_Cambio      ');
      SQL.Add('  FROM QS_TRA_OMD_PREPAGO_PACTO p             ');
      SQL.Add('       LEFT JOIN QS_TRA_OMD_DATADI_UNI q      ');
      SQL.Add('              ON q.Folio_Interno   = p.Folio_Interno_rel ');
      SQL.Add('             AND q.Item_OMD        = 1                   ');
      SQL.Add('             AND q.Transaccion     = p.Transaccion_rel   ');
      SQL.Add('             AND q.Empresa         = p.Empresa           ');
      SQL.Add('             AND q.Tipo_Dato       = ''TIPOCAMBIO''      ');
      SQL.Add(' WHERE p.Folio_Interno     = :Folio_Interno  ');
      SQL.Add('   AND p.Transaccion       = :Transaccion    ');
      SQL.Add('   AND p.Empresa           = :Empresa        ');
      SQL.Add('   AND p.Fecha_Prepago    <= :Fecha_Calculo  ');
      SQL.Add('   AND p.folio_interno NOT IN (SELECT q.folio                         ');
      SQL.Add('                                 FROM qs_ctr_anulacion q              ');
      SQL.Add('                                WHERE q.folio       = p.folio_interno ');
      SQL.Add('                                  AND q.transaccion = p.transaccion   ');
      SQL.Add('                                  AND q.empresa     = p.empresa )     ');
      ParamByName('Folio_Interno').asString   := sFolio_interno;
      ParamByName('Transaccion').asString     := sTransaccion;
      ParamByName('Empresa').asString         := sEmpresa;
      ParamByName('Fecha_Calculo').AsDate := dFecha_Calculo;
      Open;
      if not eof then
      begin
         dFecha_Anticipo    := FieldByName('Fecha_Prepago').asDateTime;
         sMoneda_Anticipo   := FieldByName('Moneda_Anticipo').asString;
         try
           fTC_Anticipo := Convierte_a_punto(FieldByName('Tipo_Cambio').asString);
         except
           fTC_Anticipo := 0;
         end;
         fUnwind_por_Cobrar := FieldByName('Valor_Empresa').asFloat;
         fUnwind_por_Pagar  := FieldByName('Valor_Contraparte').asFloat;
      end;
      Close;
   end;
end;

function Calcula_Fecha_Efectiva(dfecha_paridad :TDatetime;
                                sEmisor        :String;
                                sInstrumento   :String;
                                sSerie         :String;
                                sNemotecnico   :String):TDatetime;
var fCantidad         : Double;
    sUnidad           : String;
    sHabiles          : String;
    sAntes_Despues    : String;
    sAfecta           : String;
    DiasEfectivosPago : Boolean;
    iDias             : Integer;
    iMeses            : Integer;
    iAnos             : Integer;
    dfecha_efectiva   : TDatetime;
begin
   dfecha_efectiva := dfecha_paridad;
   Determina_Dias_Efectivos_Pago_Mem(sPais_Usuario,
                                     sEmisor,
                                     sInstrumento,
                                     sSerie,
                                     sNemotecnico,
                                     dfecha_efectiva,
                                     fCantidad,
                                     sUnidad,
                                     sHabiles,
                                     sAntes_Despues,
                                     sAfecta,
                                     DiasEfectivosPago);
   if DiasEfectivosPago Then
   begin
      if fCantidad > 0 then
      begin
         iDias  := 0;
         iMeses := 0;
         iAnos  := 0;
         if sUnidad = 'DIA' then
            if sAntes_Despues = 'A' then
               iDias := ROUND(fCantidad*(-1))
            else
               iDias := ROUND(fCantidad);
         if sUnidad = 'MES' then
            if sAntes_Despues = 'A' then
               iMeses := ROUND(fCantidad*(-1))
            else
               iMeses := ROUND(fCantidad);
         if sUnidad = 'ANO' then
            if sAntes_Despues = 'A' then
               iAnos := ROUND(fCantidad*(-1))
            else
               iAnos := ROUND(fCantidad);
         if (sUnidad = 'DIA') AND (sHabiles = 'S') then
         begin
           if sAntes_Despues = 'A' then
              dfecha_efectiva := Resta_dias_habiles(sPais_Usuario
                                                   ,dfecha_efectiva
                                                   ,ABS(fCantidad))
           else
              dfecha_efectiva := suma_dias_habiles(sPais_Usuario
                                                  ,dfecha_efectiva
                                                  ,ABS(fCantidad));
         end
         else
           dfecha_efectiva := IncDate(dfecha_efectiva
                                     ,iDias
                                     ,iMeses
                                     ,iAnos);
      end;
      if sHabiles = 'S' then
      begin
         While (Feriado_Mem(sPais_Usuario,dfecha_efectiva) or (DayOfWeek(dfecha_efectiva) in [1,7])) do
            if sAntes_Despues = 'A' then
               dfecha_efectiva := dfecha_efectiva - 1
            else
               dfecha_efectiva := dfecha_efectiva + 1;
      end;
      if sAfecta = 'TIPOCAMBIO' then
         dfecha_paridad := dfecha_efectiva;
   end;

   Result := dfecha_paridad;

end;

Procedure Limpia_Tablas_TMP(sTransaccion   :String;
                            sFolio_interno :String);
begin
   WITH dmComunInversiones.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('DELETE FROM QS_TMP_OMD '
            +' WHERE Empresa       = :Empresa'
            +'   AND Transaccion   = :Transaccion'
            +'   AND Folio_Interno = :Folio_Interno'
            );

     ParamByName('Empresa').AsString       := sEmpresa_Usuario;
     ParamByName('Transaccion').AsString   := sTransaccion;
     ParamByName('Folio_interno').AsString := sFolio_interno;
     try
        ExecSQL
     except on E: EFDDBEngineException do
       begin
          ShowError(E);
//          Result := False;
          Close;
          Exit;
       end;
     end;

     SQL.Clear;
     SQL.Add('DELETE FROM QS_TMP_OMD_DET_RF '
            +' WHERE Empresa       = :Empresa'
            +'   AND Transaccion   = :Transaccion'
            +'   AND Folio_Interno = :Folio_Interno'
            );

     ParamByName('Empresa').AsString       := sEmpresa_Usuario;
     ParamByName('Transaccion').AsString   := sTransaccion;
     ParamByName('Folio_interno').AsString := sFolio_interno;
     try
        ExecSQL
     except on E: EFDDBEngineException do
       begin
          ShowError(E);
//          Result := False;
          Close;
          Exit;
       end;
     end;

     Close;
   end;

end;

//ggarcia 11-01-2016
procedure Busca_Fecha_Anticipo(sEmpresa             :String;
                               sTransaccion         :String;
                               sFolio_interno       :String;
                               fItem_OMD            :Double;
                               dFecha_Calculo       :TDateTime;
                           var fNocional_Anticipado :Double);
begin
   With dmComunInversiones.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT SUM(p.Valor_Nocional_Corto) as Valor_Nocional_Corto ');
      SQL.Add('      ,SUM(p.Valor_Nocional_Largo) as Valor_Nocional_Largo ');
      SQL.Add('  FROM QS_TRA_OMD_PREPAGO_PACTO p           ');
      SQL.Add(' WHERE p.Fecha_Prepago    <= :Fecha_Calculo ');
      SQL.Add('   AND p.FOLIO_INTERNO_REL = :Folio_Interno ');
      SQL.Add('   AND p.Transaccion_Rel   = :Transaccion   ');
      SQL.Add('   AND p.Empresa_Rel       = :Empresa       ');
      SQL.Add('   AND p.folio_interno NOT IN (SELECT q.folio                         ');
      SQL.Add('                                 FROM qs_ctr_anulacion q              ');
      SQL.Add('                                WHERE q.folio       = p.folio_interno ');
      SQL.Add('                                  AND q.transaccion = p.transaccion   ');
      SQL.Add('                                  AND q.empresa     = p.empresa )     ');
      ParamByName('Fecha_Calculo').asDateTime := dFecha_Calculo;
      ParamByName('Folio_Interno').asString   := sFolio_interno;
      ParamByName('Transaccion').asString     := sTransaccion;
      ParamByName('Empresa').asString         := sEmpresa;
      Open;
      if not eof then
      begin
         if fItem_OMD = 1 then
            fNocional_Anticipado := FieldByName('Valor_Nocional_Corto').asFloat
         else
            fNocional_Anticipado := FieldByName('Valor_Nocional_Largo').asFloat;
      end;
      Close;
   end;
end;

Procedure Pertenece_Clasificacion( sObjeto,
                                   sElemento,
                                   sCodigo_Clasif,
                                   sLista_Nodo,
                                   sOperacion       : String;
                                   var fNodo_Clasif : Double
                                      );
begin
   fNodo_Clasif := 0;
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT NODO FROM  QS_SYS_CLASIF_OBJ'
              +'  WHERE Objeto   = :Objeto'
              +'  AND   Elemento = :Elemento'
              +'  AND   Codigo_Clasif = :Codigo_Clasif' );
      Sql.Add('  AND   Nodo IN ('+sLista_Nodo+')' );

      Parambyname('Objeto').asString        := sObjeto;
      Parambyname('Elemento').asString      := sElemento;
      Parambyname('Codigo_Clasif').asString := sCodigo_Clasif;
      Open;

      if sOperacion = '<>' then
      begin
         if Fieldbyname('Nodo').IsNull then
            fNodo_Clasif := 1;
      end
      else
      begin
         if Not Fieldbyname('Nodo').IsNull then
            fNodo_Clasif := Fieldbyname('Nodo').asFloat;
      end;
      Close;
   end;
end;

Function Elementos_Clasificados(sObjeto         :string;
                                sCodigo_Clasif  :string;
                                fNodo           :Double) :string;
begin
   Result := '';
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add('SELECT Elemento '
             +'  FROM QS_SYS_CLASIF_OBJ '
             +' WHERE Objeto        = :Objeto'
             +'   AND Codigo_Clasif = :Codigo_Clasif'
             +'   AND Nodo          = :Nodo ');
      Parambyname('Objeto').asString        := sObjeto;
      Parambyname('Codigo_Clasif').asString := sCodigo_Clasif;
      Parambyname('Nodo').AsFloat           := fNodo;
      Open;
      if NOT EOF then
         Result := Result +' ( '''+Fieldbyname('Elemento').asString;
      Next;
      while not eof do
      begin
        Result := Result+''','''+Fieldbyname('Elemento').asString;
        Next;
      end;
      Result := Result + ''' )';
      Close;
   end;
end;

procedure Busca_Antecedente_Emisor(sEmisor           :String;
                                   dFecha_Proceso    :TDateTime;
                                   Var sGrupo_Economico  : String;
                                   var bResult           : Boolean);
begin

   bResult := False;

   With dmComunInversiones.QRY_General do
   begin
      SQL.Clear;
      sql.add('SELECT *  ');
      sql.add('  FROM QS_FIN_ESTADO_EMI a ');
      sql.add(' WHERE a.Fecha_Desde <= :Fecha_Proceso  ');
      sql.add('   AND a.Fecha_Desde = (SELECT MAX(b.FECHA_DESDE)  ');
      sql.add('                          FROM QS_FIN_ESTADO_EMI b ');
      sql.add('                         WHERE b.emisor = a.emisor  ');  // Se agrega el emisor ya que sino cargaba solo los ultimos vigentes 08-06-2009
      sql.add('                           AND b.Fecha_Desde <= :Fecha_Proceso  ');
      sql.add('                           AND (b.Fecha_Hasta IS NULL OR b.Fecha_Hasta >= :Fecha_Proceso)  ');
      sql.add('	             )                                                               ');
      sql.add('   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha_Proceso)  ');
      sql.add('   AND a.Emisor = :Emisor  ');
      ParamByname('fecha_proceso').AsDate := dFecha_Proceso;
      ParamByName('Emisor').asString   := sEmisor;
      Open;
      if not eof then
      begin
         sGrupo_Economico := FieldByName('GRUPO_EMISOR').asString;
         bResult := True;
      end;
      Close;
   end;

end;

Procedure Busca_Cobertura_PMS( sEmpresa,
                               sTransaccion,
                               sFolio_Interno : String;
                               fItem_Omd      : Double;
                               Var sCobertura : String
                             );
begin
  sCobertura := 'N';
  With dmComunInversiones.QRY_General do
  begin
      Sql.Clear;
      SQL.Add('SELECT Transaccion'
             +'  FROM QS_TRA_FWD_DET_GARANTIA'
             +' WHERE Empresa_Rel       = :Empresa'
             +'   AND Transaccion_Rel   = :Transaccion'
             +'   AND Folio_Interno_Rel = :Folio_Interno'
             +'   AND Item_Omd_Rel      = :Item_Omd'
            );
      ParamByName('Empresa').AsString       := sEmpresa;
      ParamByName('Transaccion').asString   := sTransaccion;
      ParamByName('Folio_Interno').asString := sFolio_Interno;
      ParamByName('Item_Omd').asFloat       := fItem_Omd;
      Open;
      if Not Fieldbyname('Transaccion').IsNull then
         sCobertura := 'SFWV';


      Sql.Clear;
      SQL.Add('SELECT Transaccion'
             +'  FROM QS_TRA_OMD_DET_RF'
             +' WHERE Transaccion       = :Swap'
             +'   AND Empresa_Rel       = :Empresa'
             +'   AND Transaccion_Rel   = :Transaccion'
             +'   AND Folio_Interno_Rel = :Folio_Interno'
             +'   AND Item_Omd_Rel      = :Item_Omd'
            );
      ParamByName('Swap').AsString          := 'S';
      ParamByName('Empresa').AsString       := sEmpresa;
      ParamByName('Transaccion').asString   := sTransaccion;
      ParamByName('Folio_Interno').asString := sFolio_Interno;
      ParamByName('Item_Omd').asFloat       := fItem_Omd;
      Open;
      if Not Fieldbyname('Transaccion').IsNull then
         if sCobertura = 'N' then
            sCobertura := 'S'
         else
            sCobertura := 'SMIX';
      Close;
   end;
end;

function leer_regulador(sEmisor      : String;
                        sInstrumento : String;
                        dFecha       : tDateTime): String;
begin

   Result := '';
   With dmComunInversiones.QRY_General do
   begin
      Sql.Clear;
      Sql.Add('SELECT a.Emisor_Regulador'
             +'  FROM QS_FIN_EMISOR_REGULADOR a '
             +' WHERE a.Codigo_Identidad   = :Identidad ');
      Sql.Add('   AND a.Codigo_Instrumento = :Instrumento ');
      Sql.Add('   AND a.Fecha_Desde <= :Fecha ');
      Sql.Add('   AND (a.Fecha_Hasta >= :Fecha OR a.Fecha_Hasta is Null) ');

      ParamByName('Identidad').AsString    := sEmisor;
      ParamByName('Instrumento').AsString  := sInstrumento;
      ParamByName('Fecha').AsDate          := dFecha;
      Open;
      if NOT Fieldbyname('Emisor_Regulador').IsNull then
         Result := Fieldbyname('Emisor_Regulador').asString
      else
      begin
        Sql.Clear;
        Sql.Add('SELECT a.Emisor_Regulador'
               +'  FROM QS_FIN_EMISOR_REGULADOR a '
               +' WHERE a.Codigo_Identidad   = :Identidad ');
        Sql.Add('   AND a.Fecha_Desde <= :Fecha ');
        Sql.Add('   AND (a.Fecha_Hasta >= :Fecha OR a.Fecha_Hasta is Null) ');

        ParamByName('Identidad').AsString    := sEmisor;
        ParamByName('Fecha').AsDate          := dFecha;
        Open;
        if NOT Fieldbyname('Emisor_Regulador').IsNull then
           Result := Fieldbyname('Emisor_Regulador').asString
      end;
      Close;
   end;

end;

procedure Verifica_Proceso_En_Ejecucion(sProceso         : String;
                                        sEmpresa         : String;
                                        sUsuario_Win     : String;
                                    Var sUsuario_Win_Val : String;
                                    Var sUsuario_Pms_Val : String;
                                    Var sPid_Val         : String;
                                    Var sEmpresa_Val     : String;
                                    var bResult          : Boolean);
// Var Dia1, Dia2, Mes, Anio : Word;
begin

   bResult := False;
   sUsuario_Win_Val := '';

   With dmComunInversiones.QRY_General do
   begin
      SQL.Clear;
      sql.add('SELECT a.* ');
      sql.add('  FROM QS_SYS_LOG a ');
      sql.add('      ,QS_SYS_LOGIN b ');
      sql.add(' WHERE a.proceso    = :Proceso  ');
      sql.add('   AND a.fecha_hora = (SELECT MAX(x.fecha_hora) ');
      sql.add('                         FROM QS_SYS_LOG x ');
      sql.add('                        WHERE x.proceso = :Proceso ) ');
      sql.add('   AND b.login_sistema = a.Usuario_PMS ');
      sql.add('   AND b.Empresa_Login = :Empresa ');

      ParamByName('Proceso').asString  := sProceso;      // 'Valorizacion de Posicion'
      ParamByName('Empresa').asString  := sEmpresa;
      Open;
      if not eof then  // si encuentro significa que existe un proceso de valorizacion
      begin
         With dmComunInversiones.QRY_Aux do
         begin
            //ggarcia 09-01-2017  se reemplaza los parametros pid y fecha por la condicion de la cabecera, ya que el parametro datetime daba problemas en euroamerica
            {
            SQL.Clear;
            sql.add('SELECT a.* ');
            sql.add('  FROM QS_SYS_LOG a ');
            sql.add('      ,QS_SYS_LOG_DET b ');
            sql.add(' WHERE a.proceso    = :Proceso  ');
            sql.add('   AND a.Pid        = :Pid ');
            sql.add('   AND a.fecha_hora = :Fecha_Hora');
            sql.add('   AND b.pid        = a.pid ');
            sql.add('   AND b.fecha_hora = a.fecha_hora ');
            sql.add('   AND b.Valor IN ( ''Proceso Terminado Normalmente'', ''Proceso Abortado'' )  ');
            }
            SQL.Clear;
            sql.add('SELECT a.*, x.Empresa_Login ');
            sql.add('  FROM QS_SYS_LOG     a ');
            sql.add('      ,QS_SYS_LOGIN   x ');
            sql.add('      ,QS_SYS_LOG_DET b ');
//            sql.add('      ,QS_SYS_LOG_DET c ');
            sql.add(' WHERE a.proceso    = :Proceso  ');
            sql.add('   AND a.fecha_hora = (SELECT MAX(x.fecha_hora) ');
            sql.add('                         FROM QS_SYS_LOG x ');
            sql.add('                        WHERE x.proceso = :Proceso ) ');
            sql.add('   AND x.login_sistema = a.Usuario_PMS ');
            sql.add('   AND x.Empresa_Login = :Empresa ');
            sql.add('   AND b.pid        = a.pid ');
            sql.add('   AND b.fecha_hora = a.fecha_hora ');
            sql.add('   AND b.Valor IN (''Proceso Terminado Normalmente'',''Proceso Abortado'') ');
//            sql.add('   AND c.pid        = a.pid ');
//            sql.add('   AND c.fecha_hora = a.fecha_hora ');
//            sql.add('   AND c.Campo = ''Empresa'' ');
//            sql.add('   AND c.Valor = :Empresa ');

            ParamByName('Proceso').asString      := sProceso;      // 'Valorizacion de Posicion'
            //ParamByName('fecha_hora').AsDateTime := dmComunInversiones.QRY_General.FieldByName('Fecha_Hora').asDateTime;
            //ParamByName('Pid').asString          := dmComunInversiones.QRY_General.FieldByName('Pid').asString;
            ParamByName('Empresa').asString      := sEmpresa;

            Open;
            if not eof then  // si encuentro significa que terminó el proceso
               bResult := False
            else
            begin

               if sUsuario_Win <> dmComunInversiones.QRY_General.FieldByName('USUARIO_WIN').asString then
               begin
                  sUsuario_Win_Val := dmComunInversiones.QRY_General.FieldByName('USUARIO_WIN').asString;
                  sUsuario_Pms_Val := dmComunInversiones.QRY_General.FieldByName('USUARIO_PMS').asString;
                  sEmpresa_Val     := dmComunInversiones.QRY_Aux.FieldByName('Empresa_Login').asString;
                  sPid_Val         := dmComunInversiones.QRY_General.FieldByName('Pid').asString;
                  bResult := True;
               end;

            end;
         end;
         Close;
      end;
      Close;
   end;

end;

function valida_proy_vctos_RF(sEmpresa     :String;
                              sCartera     :String;
                              bConsolida   :Boolean;
                              dFecha_desde :TDateTime;
                              dFecha_hasta :TDateTime) :Boolean;
var fNum_Reg       :Double;
    fdias,
    anos_enteros ,
    anos_fraccion,
    meses_enteros  : Double;
begin
//   Result := False;

   calculo_de_dias(dFecha_desde,
                   dFecha_hasta,
                   'EXACTOS',
                   sPais_Usuario,
                   fDias,
                   anos_enteros,
                   anos_fraccion,
                   meses_enteros);
   fDias := fDias+1;

   if bConsolida then
   begin
      With dmComunInversiones.QRY_General do
      begin
         SQL.Clear;
         SQL.Add(' SELECT Distinct a.Cartera '
                +'   FROM QS_SYS_PARAM_EMPRESA a '
                +'       ,QS_FIN_CARTERAS      b '
                +'  WHERE a.pid         = '+Floattostr(Application.Handle)
                +'    AND b.Cod_Cartera = a.Cartera ');
         Open;
//         Last;
         fNum_Reg := fDias * RecordCount;
      end;
   end
   else
      fNum_Reg := fDias;

   With dmComunInversiones.QRY_General do
   begin
      SQL.Clear;
      sql.add('SELECT distinct cartera,fecha_vcto_cupon '
             +'  from qs_res_vencimientos '
             +' where fecha_vcto_cupon between :Fecha_Desde and :Fecha_Hasta ');
      if bConsolida then
         SQL.Add(' and cartera in (SELECT Distinct a.Cartera '
                +'                   FROM QS_SYS_PARAM_EMPRESA a '
                +'                       ,QS_FIN_CARTERAS      b '
                +'                  WHERE a.pid         = '+Floattostr(Application.Handle)
                +'                    AND b.Cod_Cartera = a.Cartera) ')
      else
      begin
         SQL.Add('and cartera = :Cartera ');
         ParamByName('cartera').asString := sCartera;
      end;
      ParamByName('Fecha_Desde').AsDate   := dFecha_desde;
      ParamByName('Fecha_Hasta').AsDate   := dFecha_hasta;
      Open;
//      Last;            // por cambio de parametro en query RecordCountMode
      if RecordCount <> fNum_Reg then
         Result := False
      else
         Result := true;
   end;
end;

function valida_proy_vctos_derivados(sEmpresa     :String;
                                     sCartera     :String;
                                     bConsolida   :Boolean;
                                     dFecha_desde :TDateTime;
                                     dFecha_hasta :TDateTime) :Boolean;
var fNum_Reg       :Double;
    fdias,
    anos_enteros ,
    anos_fraccion,
    meses_enteros  : Double;
begin
//   Result := False;

   calculo_de_dias(dFecha_desde,
                   dFecha_hasta,
                   'EXACTOS',
                   sPais_Usuario,
                   fDias,
                   anos_enteros,
                   anos_fraccion,
                   meses_enteros);
   fDias := fDias+1;

   if bConsolida then
   begin
      With dmComunInversiones.QRY_General do
      begin
         SQL.Clear;
         SQL.Add(' SELECT Distinct a.Cartera '
                +'   FROM QS_SYS_PARAM_EMPRESA a '
                +'       ,QS_FIN_CARTERAS      b '
                +'  WHERE a.pid         = '+Floattostr(Application.Handle)
                +'    AND b.Cod_Cartera = a.Cartera ');
         Open;
//         Last;
         fNum_Reg := fDias * RecordCount;
      end;
   end
   else
      fNum_Reg := fDias;

   With dmComunInversiones.QRY_General do
   begin
      SQL.Clear;
      sql.add('SELECT distinct cartera,fecha_vcto '
             +'  from qs_res_vencimientos_swap '
             +' where fecha_vcto between :Fecha_Desde and :Fecha_Hasta ');
      if bConsolida then
         SQL.Add(' and cartera in (SELECT Distinct a.Cartera '
                +'                   FROM QS_SYS_PARAM_EMPRESA a '
                +'                       ,QS_FIN_CARTERAS      b '
                +'                  WHERE a.pid         = '+Floattostr(Application.Handle)
                +'                    AND b.Cod_Cartera = a.Cartera) ')
      else
      begin
         SQL.Add('and cartera = :Cartera ');
         ParamByName('cartera').asString := sCartera;
      end;
      ParamByName('Fecha_Desde').AsDate   := dFecha_desde;
      ParamByName('Fecha_Hasta').AsDate   := dFecha_hasta;
      Open;
//      Last;
      if RecordCount <> fNum_Reg then
         Result := False
      else
         Result := true;
   end;
end;

Function Holding_Empresa(sEmpresa :String) :String;
begin
   Result := '';
   with DmComunInversiones.QRY_General  do
   begin
      Sql.Clear;
      Sql.Add('SELECT a.CODIGO_HOLDING'
             +'  FROM qs_sys_def_holding a'
             +' WHERE a.CODIGO_EMPRESA = :EMPRESA ');
      ParamByName('EMPRESA').AsString := sEmpresa;
      Open;
      if eof then
      begin
         Result := '';
         exit;
      end;
      Result := FieldByName('CODIGO_HOLDING').AsString;
      Close;
   end;
end;

function Existe_Activo_DPV(sTransaccion  :String;
                           sSerie        :String;
                           sMotivo       :String;
                           sCodigo_Clasif:String):Boolean;
begin
   Result := False;
   with DmComunInversiones.Qry_Aux do
   begin
     Sql.Clear;
     SQL.Add('SELECT a.* '
            +'  FROM QS_TRA_OMD_STK_RF a '
            +'      ,QS_SYS_CLASIF_OBJ b '
            +' WHERE a.TRANSACCION   = :Transaccion '
            +'   AND a.SERIE         = :Serie '
            +'   AND a.MOTIVO_INV   <> :Motivo '
            +'   AND b.OBJETO        = :Objeto '
            +'   AND b.CODIGO_CLASIF = :Codigo_Clasif '
            +'   AND b.ELEMENTO      = a.CARTERA ');
     ParamByName('Transaccion').AsString   := sTransaccion;
     ParamByName('Serie').AsString         := sSerie;
     ParamByName('Motivo').AsString        := sMotivo;
     ParamByName('Objeto').AsString        := 'CARTERA';
     ParamByName('Codigo_Clasif').AsString := sCodigo_Clasif;
     Open;
     if not Eof then
        Result := True;
     Close;
   end;
end;

function Existe_Activo_PEPS(sTransaccion     :String;
                            sSerie           :String;
                            sMotivo          :String;
                            dFecha_Operacion :TDateTime;
                            sCodigo_Clasif   :String;
                            sFolio_Interno   :String):Boolean;
begin
   Result := False;
   with DmComunInversiones.Qry_Aux do
   begin
     Sql.Clear;
     SQL.Add('SELECT a.* '
            +'  FROM QS_TRA_OMD_STK_RF a '
            +'      ,QS_SYS_CLASIF_OBJ b '
            +' WHERE a.TRANSACCION     = :Transaccion '
            +'   AND a.SERIE           = :Serie '
            +'   AND a.MOTIVO_INV      = :Motivo '
            +'   AND A.FECHA_OPERACION < :Fecha_operaion '
            +'   AND b.OBJETO          = :Objeto '
            +'   AND b.CODIGO_CLASIF   = :Codigo_Clasif '
            +'   AND b.ELEMENTO        = a.CARTERA ');
     ParamByName('Transaccion').AsString   := sTransaccion;
     ParamByName('Serie').AsString         := sSerie;
     ParamByName('Motivo').AsString        := sMotivo;
     ParamByName('Fecha_operaion').AsDate  := dFecha_Operacion;
     ParamByName('Objeto').AsString        := 'CARTERA';
     ParamByName('Codigo_Clasif').AsString := sCodigo_Clasif;
     Open;
     if not Eof then
     begin
        Result := True;
        Exit;
     end;

     Close;
     Sql.Clear;
     SQL.Add('SELECT MIN(a.Folio_Interno) as Folio_Interno '
            +'  FROM QS_TRA_OMD_STK_RF a '
            +'      ,QS_SYS_CLASIF_OBJ b '
            +' WHERE a.TRANSACCION     = :Transaccion '
            +'   AND a.SERIE           = :Serie '
            +'   AND a.MOTIVO_INV      = :Motivo '
            +'   AND A.FECHA_OPERACION = :Fecha_operaion '
            +'   AND b.OBJETO          = :Objeto '
            +'   AND b.CODIGO_CLASIF   = :Codigo_Clasif '
            +'   AND b.ELEMENTO        = a.CARTERA ');
     ParamByName('Transaccion').AsString   := sTransaccion;
     ParamByName('Serie').AsString         := sSerie;
     ParamByName('Motivo').AsString        := sMotivo;
     ParamByName('Fecha_operaion').AsDate  := dFecha_Operacion;
     ParamByName('Objeto').AsString        := 'CARTERA';
     ParamByName('Codigo_Clasif').AsString := sCodigo_Clasif;
     Open;
     if (not FieldByName('Folio_Interno').IsNull) and (sFolio_Interno <> FieldByName('Folio_Interno').AsString) then
        Result := True;

   end;
end;

Function Existe_Activo_Cobertura(sEmpresa         :String;
                                 sTransaccion     :String;
                                 sFolio_Interno   :String;
                                 fItem_OMD        :Double;
                                 dFecha_Operacion :TDateTime;
                             var sTipo_cobertura  :String):Boolean;
begin
   sTipo_cobertura := '';
   Result := False;
   with DmComunInversiones.Qry_Aux do
   begin
     Sql.Clear;
     SQL.Add('SELECT a.Derivado_Cobertura '
            +'  FROM QS_TRA_OMD_ACTIVO_COBERTURA a '
            +' WHERE a.FOLIO_INTERNO   = :Folio_Interno '
            +'   AND a.ITEM_OMD        = :Item_OMD '
            +'   AND a.TRANSACCION     = :Transaccion '
            +'   AND a.EMPRESA         = :Empresa '
            +'   AND a.FECHA_DESDE    <= :Fecha '
            +'   AND (a.FECHA_HASTA   >= :Fecha OR a.FECHA_HASTA IS NULL) ');
     ParamByName('Empresa').AsString       := sEmpresa;
     ParamByName('Transaccion').AsString   := sTransaccion;
     ParamByName('Folio_Interno').AsString := sFolio_Interno;
     ParamByName('Item_OMD').AsFloat       := fItem_OMD;
     ParamByName('Fecha').AsDate           := dFecha_Operacion;
     Open;
     if not Eof then
     begin
        sTipo_cobertura := FieldByName('Derivado_Cobertura').AsString;
        Result := True;
     end;
     Close;
   end;
end;
Function Existen_transacciones_en_Margen(sEmpresa :String;
                                         dFecha : TDateTime):Boolean;
begin
   Result := False;
   with DmComunInversiones.Qry_Aux do
   begin
     Sql.Clear;
     SQL.Add('SELECT a.Transaccion '
            +'  FROM QS_TRA_OMD a '
            +' WHERE a.EMPRESA   = :Empresa'
            +'   AND a.TRANSACCION = :Transaccion'
            +'   AND a.folio_interno NOT IN (SELECT e.folio '
            +'		                        		 FROM qs_ctr_anulacion e '
            +'		                         		WHERE e.folio       = a.folio_interno '
            +'				                          AND e.transaccion = a.transaccion '
            +'  				                        AND e.empresa     = a.empresa) '
            +'   AND a.Fecha_Operacion   <= :Fecha '
            +'   AND a.Fecha_Vcto_Pacto  >= :Fecha ' );
     ParamByName('Empresa').AsString       := sEmpresa;
     ParamByName('Transaccion').AsString   := 'MARGEN';
     ParamByName('Fecha').AsDate           := dFecha;
     Open;
     if not Eof then
     begin
        Result := True;
     end;
     Close;
   end;
end;

procedure Busca_tasa_cupon(sEmpresa       :string;
                           sTransaccion   :string;
                           sFolio_Interno :string;
                           fItem_OMD      :Double;
                           fTasa_Compra   :Double;
                           iCupon_Vigente :Integer;
                       var fTasa_cupon    :Double;
                       var bResult        :Boolean);
begin
   fTasa_cupon := 0;
   if iCupon_Vigente <= 1 then
   begin
      fTasa_cupon := fTasa_Compra;
      bResult     := True;
   end
   else
   begin
      with DmComunInversiones.Qry_Aux do
      begin
         sql.Clear;
         sql.add('select * '
                +'  from QS_TRA_OMD_TASA_REC '
                +' where Folio_interno = :Folio_interno '
                +'   and Item_Omd      = :Item_Omd '
                +'   and Nro_Cupon     = :Nro_Cupon'
                +'   and Transaccion   = :Transaccion '
                +'   and Empresa       = :Empresa '
                );
         ParamByName('Folio_interno').AsString := sFolio_Interno;
         ParamByName('Item_Omd').asFloat       := fItem_OMD;
         ParamByName('Nro_Cupon').asFloat      := iCupon_Vigente;
         ParamByName('Transaccion').AsString   := sTransaccion;
         ParamByName('Empresa').AsString       := sEmpresa;
         open;
         if not eof then
         begin
            fTasa_cupon := FieldByName('Tasa_Cpa_Recalculada').AsFloat;
            bResult     := True;
         end
         else
            bResult     := False;
      end;
   end;
end;

procedure Graba_tasa_cupon(sEmpresa               :string;
                           sTransaccion           :string;
                           sFolio_Interno         :string;
                           fItem_OMD              :Double;
                           iCupon_Vigente         :Integer;
                           dFechaCalculo          :TDatetime;
                           fTasaCalculo           :Double;
                           fTasa_Calculo_Original :Double;
                       var bResult                :Boolean);
begin

   with DmComunInversiones.Qry_Aux do
   begin
      sql.Clear;
      sql.add('delete from QS_TRA_OMD_TASA_REC '
                +' where Folio_interno = :Folio_interno '
                +'   and Item_Omd      = :Item_Omd '
                +'   and Nro_Cupon     = :Nro_Cupon'
                +'   and Transaccion   = :Transaccion '
                +'   and Empresa       = :Empresa '
             );
      ParamByName('Empresa').AsString               := sEmpresa;
      ParamByName('Transaccion').AsString           := sTransaccion;
      ParamByName('Folio_interno').AsString         := sFolio_Interno;
      ParamByName('Item_Omd').asFloat               := fItem_OMD;
      ParamByName('Nro_Cupon').asFloat              := iCupon_Vigente;
      try
         ExecSQL;
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           bResult := False;
           Close;
           Exit;
        end;
      end;

      sql.Clear;
      sql.add(' insert into QS_TRA_OMD_TASA_REC '
             +' (Empresa '
             +' ,Transaccion '
             +' ,Folio_interno '
             +' ,Item_Omd '
             +' ,Nro_Cupon '
             +' ,Fecha_Cupon '
             +' ,Tasa_Cpa_Recalculada '
             +' ,Tasa_Cupon '
             +' ,Fecha_Hora_Registro) '
             +' values '
             +' (:Empresa '
             +' ,:Transaccion '
             +' ,:Folio_interno '
             +' ,:Item_Omd '
             +' ,:Nro_Cupon '
             +' ,:Fecha_Cupon '
             +' ,:Tasa_Cpa_Recalculada '
             +' ,:Tasa_Cupon '
             +' ,:Fecha_Hora_Registro) '
             );
      ParamByName('Empresa').AsString               := sEmpresa;
      ParamByName('Transaccion').AsString           := sTransaccion;
      ParamByName('Folio_interno').AsString         := sFolio_Interno;
      ParamByName('Item_Omd').asFloat               := fItem_OMD;
      ParamByName('Nro_Cupon').asFloat              := iCupon_Vigente;
      ParamByName('Fecha_Cupon').asDatetime         := dFechaCalculo;
      ParamByName('Tasa_Cpa_Recalculada').asFloat   := fTasaCalculo;
      ParamByName('Tasa_Cupon').asFloat             := fTasa_Calculo_Original;
      ParamByName('Fecha_Hora_Registro').asDatetime := Fecha_Hora_Servidor;
      try
         ExecSQL;
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           bResult := False;
           Close;
           Exit;
        end;
      end;
   end;

   if dmBaseDatos.Conexion_BaseDatos.InTransaction then
   begin
      dmBaseDatos.Conexion_BaseDatos.Commit;
      dmBaseDatos.Conexion_BaseDatos.StartTransaction;
   end;
end;

procedure Solicitud_Venta_al_Vcto(sEmpresa          :string;
                                  sCartera          :string;
                                  sTransaccion      :string;
                                  sFolio_Interno    :string;
                                  fItem_OMD         :Double;
                                  sNemotecnico      :string;
                                  fValor_Nominal    :Double;
                                  sUsuario_Solicita :string;
                                  dFecha_Hora       :TDateTime;
                              var bResult           :Boolean);
var fFolio    : Double;
    aux_pchar : Array[0..250] of Char;
begin
  bResult := True;
  with DmComunInversiones.Qry_Aux do
  begin
    sql.Clear;
    sql.add(' insert into QS_TRA_OMD_APROBACION_VENTAS '
           +' (Empresa '
           +' ,Cartera '
           +' ,Transaccion '
           +' ,Folio_interno '
           +' ,Transaccion_omd '
           +' ,Folio_interno_omd '
           +' ,Item_Omd '
           +' ,Nemotecnico '
           +' ,Valor_Nominal '
           +' ,Usuario_Solicita '
           +' ,Fecha_Hora '
           +' ,Estado_Venta '
           +' ,Estado_Solicitud '
           +') '
           +' values '
           +' (:Empresa '
           +' ,:Cartera '
           +' ,:Transaccion '
           +' ,:Folio_interno '
           +' ,:Transaccion_omd '
           +' ,:Folio_interno_omd '
           +' ,:Item_Omd '
           +' ,:Nemotecnico '
           +' ,:Valor_Nominal '
           +' ,:Usuario_Solicita '
           +' ,:Fecha_Hora '
           +' ,:Estado_Venta '
           +' ,:Estado_Solicitud '
           +') '
           );

    bResult := True;

    Leer_Grabar_Folio(sEmpresa,
                      ' ',           // Entidad va en blanco para folio unico empresa
                      'AUTOVTA',
                      'I',
                      solo_fecha(fecha_hora_Servidor),
                      fFolio,
                      bResult);
    if NOT bResult then
    begin
      strpcopy(aux_pchar
              ,'No se encontró foliación vigente'#10
              +'Para: '
              +sEmpresa
              +' - '
              +'AUTOVTA'
              +''#10
              +'No se pudo generar solicitud de autorización'#10
              +'Avise al administrador del sistema');
      Application.MessageBox(aux_pchar
                            ,'Sistema'
                            ,mb_OK);
      bResult := False;
      exit;
    end;

    ParamByName('Empresa').AsString          := sEmpresa;
    ParamByName('Cartera').AsString          := sCartera;
    ParamByName('Transaccion').AsString      := 'AUTOVTA';
    ParamByName('Folio_interno').AsString    := trim(floattostr(fFolio));
    ParamByName('Transaccion_omd').AsString  := sTransaccion;
    ParamByName('Folio_interno_omd').AsString:= sFolio_Interno;
    ParamByName('Item_Omd').asFloat          := fItem_OMD;
    ParamByName('Nemotecnico').AsString      := sNemotecnico;
    ParamByName('Valor_Nominal').asFloat     := fValor_Nominal;
    ParamByName('Usuario_Solicita').AsString := sUsuario_Solicita;
    ParamByName('Fecha_Hora').asDatetime     := dFecha_Hora;
    ParamByName('Estado_Venta').AsString     := 'PENDIENTE';
    ParamByName('Estado_Solicitud').AsString := 'P';
    try
      ExecSQL;
    except on E: EFDDBEngineException do
      begin
        ShowError(E);
        bResult := False;
        Close;
        Exit;
      end;
    end;
  end;
end;

function Existe_Solicitud_Venta(sEmpresa              :String;
                                sTransaccion          :String;
                                sFolio_Interno        :String;
                                fItem_OMD             :Double;
                                bAnulados             :Boolean; //incluye anulados
                            var dFecha_hora_solicitud :TDateTime;
                            var sEstado_Solicitud     :String) :Boolean;
begin
   dFecha_hora_solicitud  := 0;
   sEstado_Solicitud      := '';

   with DmComunInversiones.Qry_Aux do
   begin
      sql.Clear;
      sql.add('select a.Estado_Solicitud '
             +'      ,a.Fecha_Hora '
             +'      ,'' '' as anulado '
             +'  from QS_TRA_OMD_APROBACION_VENTAS a '
             +' where a.Folio_interno_omd                = :Folio_interno '
             +'   and a.Item_Omd                         = :Item_Omd '
             +'   and a.Transaccion_omd                  = :Transaccion '
             +'   and a.Empresa                          = :Empresa '
             +'   and a.Usuario_Solicita                 = :Usuario_Solicita ');
             //+'   and a.Estado_venta                     = ''PENDIENTE'' ');
      if sDriver = 'ORACLE' then
         sql.add('and to_date(a.Fecha_Hora,''dd/mm/yy'') = :Fecha_Hora ')
      else
         sql.add('and CONVERT(DATE,a.Fecha_Hora)         = :Fecha_Hora ');
      sql.add('   and a.Folio_Interno not in (SELECT f.Folio '
             +'                                 FROM qs_ctr_anulacion f '
             +'                                WHERE f.Folio       = a.Folio_interno '
             +'                                  AND f.transaccion = a.transaccion '
             +'                                  AND f.empresa     = a.empresa) ');
      if bAnulados then
      begin
        sql.add(' union ');
        sql.add('select a.Estado_Solicitud '
               +'      ,a.Fecha_Hora '
               +'      ,''ANULADO'' as anulado '
               +'  from QS_TRA_OMD_APROBACION_VENTAS a '
               +' where a.Folio_interno_omd                = :Folio_interno '
               +'   and a.Item_Omd                         = :Item_Omd '
               +'   and a.Transaccion_omd                  = :Transaccion '
               +'   and a.Empresa                          = :Empresa '
               +'   and a.Usuario_Solicita                 = :Usuario_Solicita ');
               //+'   and a.Estado_venta                     = ''PENDIENTE'' ');
        if sDriver = 'ORACLE' then
           sql.add('and to_date(a.Fecha_Hora,''dd/mm/yy'') = :Fecha_Hora ')
        else
           sql.add('and CONVERT(DATE,a.Fecha_Hora)         = :Fecha_Hora ');
        sql.add('   and a.Folio_Interno in (SELECT f.Folio '
               +'                             FROM qs_ctr_anulacion f '
               +'                            WHERE f.Folio       = a.Folio_interno '
               +'                              AND f.transaccion = a.transaccion '
               +'                              AND f.empresa     = a.empresa) ');
      end;
      sql.add(' order by Fecha_Hora desc');
      ParamByName('Folio_interno').AsString    := sFolio_Interno;
      ParamByName('Item_Omd').asFloat          := fItem_OMD;
      ParamByName('Transaccion').AsString      := sTransaccion;
      ParamByName('Empresa').AsString          := sEmpresa;
      ParamByName('Usuario_Solicita').AsString := sLogin_sistema;
      ParamByName('Fecha_Hora').AsDate         := solo_fecha(fecha_hora_Servidor);
      open;
      if not eof then
      begin
         dFecha_hora_solicitud := FieldByName('Fecha_Hora').AsDateTime;
         sEstado_Solicitud     := FieldByName('Estado_Solicitud').AsString;
         if FieldByName('Anulado').AsString = 'ANULADO' then
            sEstado_Solicitud  := 'N';
         Result                := True;
      end
      else
         Result := False;
   end;
end;

function Participacion_Extranjera(sNemotecnico :String;
                                  dFecha       :TDateTime) :Boolean;
begin

   Result := False;
   With DmComunInversiones.Qry_PE do
   begin
      ParamByName('nemotecnico').AsString := sNemotecnico;
      ParamByName('Fecha').AsDate         := dFecha;
      Open;
      if not eof then
         Result := True;
      Close;
   end;

end;

//function Busca_Origen_Precio( sTipo_Valuac_Mdo : String;
//                              sNemotecnico     : String
//                            ) : String;
//begin
//
//
//end;

function EsNumero(const Valor: string): Boolean;
var
  Numero: Integer;
begin
  Result := TryStrToInt(Valor, Numero);
end;

end.

