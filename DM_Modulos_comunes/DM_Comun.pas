unit DM_Comun;

////MIGRADO ///22/07/2014 13:20

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,Vcl.StdCtrls, Controls, Forms, Dialogs,
  DB,Math,IniFiles, DM_Variables_Menu, DM_FuncionesMemory,
  DM_Global_Var, Registry, DM_Paises, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Variants, FireDAC.Stan.ExprFuncs, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.Phys.SQLite, System.RegularExpressions;

const
  sStr1 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
  //ggarcia 14-01-2021
  //sStr2 = '\-_.,;:@#';
  sStr2 = '!"#$%&''()*,-.:;<=>?@[\]^_`{|}~';
  sStr3 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_';
  sStr_caracteres_premitidos_1835 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+-_#&%".,:;*()/$<>!=';

type
  TDataModule_Comun = class(TDataModule)
    FDMemTable1: TFDMemTable;
    Tabla_Log: TFDMemTable;
    Tabla_LogFecha: TDateTimeField;
    Tabla_LogFolio: TStringField;
    Tabla_LogTransaccion: TStringField;
    Tabla_LogItem_Omd: TFloatField;
    Tabla_LogMensaje: TStringField;
    Tabla_LogModulo: TStringField;
    Qry_Deterioro: TFDQuery;
    QRY_General: TFDQuery;
    QryLicencia: TFDQuery;
    Qry_Datos_Universales: TFDQuery;
    FDLocalSQL1: TFDLocalSQL;
    QRY_General2: TFDQuery;
    Qry_Unico: TFDQuery;
    QRY_General3: TFDQuery;
    Qry_Feriado: TFDQuery;
    Qry_Nominales_Venta: TFDQuery;
    QRY_General4: TFDQuery;
    Qry_Param_Proc: TFDQuery;
    Qry_Nem_Pas_Swap: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons; Captions: array of string; DefaultButton: TMsgDlgBtn): Integer; overload;
//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons; Captions: array of string): Integer; overload;
//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): Integer; overload;
//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons): Integer; overload;

  function SelectCountSql(const SqlQuery : string ; Parametros : array of String; TipoDatos : array of TFieldType
  ; Valores : array of string) : Integer;

  procedure Fechas_Tramos(dFecha_Input : TDateTime;
                          sUnidad      : STring;
                          iCantidad    : Integer;
                      var dFecha_Output: TDateTime
                          );

  function Busca_Motivo_OMD( sEmpresa,
                             sCartera,
                             sTransaccion,
                             sFolio          : string;
                             fItem_Omd       : Double;
                             dFecha: TDateTime): string;

  function Busca_Cartera_Clasif( sObjeto,
                                 sCodigo_Clasif : String): String;

  function Default_Cartera_Perfil( sPerfil : String): String;


  function EsValido(sContenido, sPatron: string): Boolean;  // validacion caracteres regulares

  //Se agrego un reallamado para buscar el motivo de inersion del nemotecnico equivalente F.I. 21-04-2015
  function Busca_Motivo_Inversion_RV( sEmpresa        : String;
                                    sCartera        : String;
                                    sTransaccion    : String;
                                    sNemotecnico    : String;
                                    dFecha_Cierre   : TDateTime;
                                    bRellamado      : Boolean) : String;

  function Busca_Contraparte_RV( sEmpresa        : String;
                                 sCartera        : String;
                                 sTransaccion    : String;
                                 sNemotecnico    : String;
                                 dFecha_Cierre   : TDateTime) : String;

  function Busca_Custodia_RV( sEmpresa        : String;
                               sCartera        : String;
                               sTransaccion    : String;
                               sNemotecnico    : String;
                               dFecha_Cierre   : TDateTime) : String;

  function Busca_Motivo_Inversion_Ahorro( sEmpresa        : String;
                                      sTransaccion    : String;
                                      sNemotecnico    : String;
                                      dFecha_Cierre   : TDateTime) : String;

  function Busca_Bolsa_RV( sEmpresa        : String;
                           sTransaccion    : String;
                           sNemotecnico    : String;
                           dFecha_Cierre   : TDateTime) : String;

  Function No_Custodiable(  sTransaccion,
                            sFolio_Interno : String;
                            fItem_Omd      : Double;
                            dFecha_Proceso : TdateTime
                         ) : Boolean;

  function Obtener_Tipo_Movimiento_Por_Hecho_Economico(  sEMPRESA
                                                        ,sCARTERA
                                                        ,sHecho_Econ : String;
                                                        dFECHA       : TDateTime
                                                      ) : String;

  Function Aplica_Operacion_lim( fValor_1
                                ,fValor_2  : Double;
                                 sOperacion : String
                                  ) : Boolean;
function RoundD(x: Double; d: Integer): Extended;
function Existe_Codigo_Folio_Cartera(sEmpresa,
                                     sCod_Transaccion : String) : Boolean;
function Existe_Perfil_Cartera(sCodigo_Perfil : String) : Boolean;
function Valida_Perfil_Cartera(sCodigo_Perfil, sCartera : String) : Boolean;

function moneda_nacional_pais_Usuario( sPais : String ) : String;
function Codigo_Transaccion( sCondicion : String ) : String;
function fecha_valida(sFecha : String):Boolean;
function FechaNemotecnico(sNemotecnico:String; Fecha:TDateTime ; FechaOperacion:TDateTime ):TDateTime;
{function VericaFechaNemotecnico(FechaEmision:TDateTime; FechaOperacion:Tdatetime):Boolean;}

procedure valida_permiso(xempresa,xperfil,xprograma : string;
          var
          xejecuta,
          xinserta,
          xelimina,
          xmodifica : boolean);



function existen_registros(stabla,swhere_part : string):boolean;
function instrumento_seriado(sCod_Instrumento : string):boolean;
function instrumento_rv(sCod_Instrumento : string):boolean;
function ultimo_dia_mes(wmes,wano : word) : word;
function dia(dFecha : TdateTime) : Word;
function mes(dFecha : TdateTime) : Word;
function ano(dFecha : TdateTime) : Word;
function primer_fecha_mes(dFecha : TDatetime) : TDatetime;
function ultima_fecha_mes(dFecha : TDatetime) : TDatetime;
function transaccion_implica(sTransaccion,
                             sImplicancia : String): Boolean;
function Cierre_Contable_Oper(sProceso     : String;
                              sEmpresa     : String;
                              sCartera     : String;
                              sTipo_Contab : String;
                              dFecha       : TDateTime): Boolean;
procedure graba_implicancia(sTransaccion,
                            sImplicancia : String);

procedure borra_implicancia(sTransaccion,
                            sImplicancia : String);

function Datos_Transaccion(sTransaccion     : String;
                           var sRelacion    : String;
                           var sSistema     : String;
                           var sDescripcion : String;
                           var sModulo_Err  : String;
                           var sString_Err  : String) : Boolean;

function feriado(sCodigo_Division : String;
                 dFecha           : TDatetime) : Boolean;
procedure pone_owner_MSSQL(var sNombre_Tabla : String;
                           var Resultado     : Boolean);
procedure Direccion_Padre(sEmpresa  : String;
                          var fItem_dir : Double;
                          var Result    : Boolean);
procedure Leer_Folio(sEmpresa,
                     sEntidad,
                     sTransaccion,
                     sInterno_Preimpreso : String;
                     dFecha       : TDatetime;
                     var fFolio   : Double;
                     var Result   : Boolean);

procedure Leer_Grabar_Folio(sEmpresa,
                            sEntidad,
                            sTransaccion,
                            sInterno_Preimpreso : String;
                            dFecha       : TDatetime;
                            var fFolio   : Double;
                            var Result   : Boolean);

procedure Grabar_Folio(sEmpresa            : String;
                       sEntidad            : String;
                       sTransaccion        : String;
                       sInterno_Preimpreso : String;
                       dFecha              : TDatetime;
                       fFolio              : Double;
                       var Result          : Boolean);

procedure Registra_Bitacora_Procesos(sEmpresa       : String;
                                     sCartera       : String;
                                     sCodigo_proceso: String;
                                     dFecha_Proceso : TDateTime;
                                     sDescripcion   : String;
                                     sUsuario       : String);

function Redondeo(X:extended; Dec:integer):double;
function Truncado(X:extended; Dec:integer):double;
function ajusta_decimales(Tipo_ajuste:String;X:extended; Dec:integer):double;

function dia_habil_siguiente(sCodigo_Division : String;
                             dFecha           : TDatetime) : TDatetime;

function dia_habil_anterior(sCodigo_Division : String;
                            dFecha           : TDatetime) : TDatetime;

function dia_habil_antes_despues(sCodigo_Division : String;
                                 dFecha           : TDatetime;
                                 sAntes_Despues   : String) : TDatetime;

function Resta_dias_habiles(sCodigo_Division    : String;
                           dFecha_Origen       : TDateTime;
                           fDias_Suma          : Double) : TDateTime;
                                 
function suma_dias_habiles(sCodigo_Division    : String;
                           dFecha_Origen       : TDateTime;
                           fDias_Suma          : Double) : TDateTime;
function Resta_dias_corridos(sCodigo_Division    : String;
                           dFecha_Origen       : TDateTime;
                           fDias_Suma          : Double) : TDateTime;

function suma_dias_corridos(sCodigo_Division    : String;
                           dFecha_Origen       : TDateTime;
                           fDias_Suma          : Double) : TDateTime;

function moneda_nacional : String;

function redondeo_moneda(sCod_Moneda     : String;
                         dFecha_Redondeo : TDatetime;
                         fValor_Original : Double) : Double;

function directorio_temp  : string;
//function directorio_bde   : string;
function directorio_windows : string;
function nombre_maquina : String;
function directorio_actual : string;

function leer_Comando(sDriver          : String;
                      sComando         : String) : String;

function fecha_hora_Servidor : TDateTime;
function solo_fecha(fechahora : TDateTime) : TDatetime;
procedure Nombre_Unico(var sNombre_Base : String;
                       sNombre_Source   : String;
                       var Result       : Boolean);

procedure ayuda_contexto(idxayuda : THelpContext);
function fecha_de_Stock(sCartera : String):TDateTime;
function fecha_de_Stock2(sCartera : String;
                         dFecha_Stock   : TdateTime):TDateTime;
function fecha_de_Stock_Derivado(sCartera : String):TDateTime;
// function Folio_Unico_Local: String;
procedure mascara_decimales(var sMascara : String;
                            num_decimales : Integer;
                            cChar         : String);

function decimales_moneda(sCod_Moneda : String;
                          dFecha      : TdateTime) : Integer;

function decimales_tasa(dFecha : TdateTime) : Integer;

function Decimales(sCod_Moneda     : String;
                   dFecha_Redondeo : TDatetime
                   ):Integer;

procedure Leer_MonRedon(sCod_Moneda : String;
                        dFecha      : TdateTime;
                        var sTipo_Ajuste    : String;
                        var iDecimal_Ajuste : Integer);

procedure Delay(msecs:integer);
function Pais_Emisor(sCodigo_Division : String): String;

procedure Pais_MonInd(sCodigo_MondInd : String;
                      var sCodigo_Pais : String;
                      var sModulo_Err  : String;
                      var sString_Err  : String;
                      var Result       : Boolean);

procedure aplica_operacion(fValor1           : Double;
                           fValor2           : Double;
                           sOperador         : String;
                           Base_Porcentual   : Double;
                           Redondeo_Truncado : String;
                           Numero_Decimales  : Double;
                           var fResultado    : Double;
                           var sModulo_Err   : String;
                           var sString_Err   : String;
                           var Result        : Boolean);


procedure ShowError(AExc: EFDDBEngineException);
procedure ShowError_SQL(AExc: EFDDBEngineException;
                        sSqlStrings : TStrings;
                        sMensaje    : String);
function Escribe_Txt( sFileName, sTxtLine: string; bDeleteFile: boolean ): boolean;
function Str_Is_Num( sNumero: string ): boolean;
function MensajeBox( sTitulo, sMensaje: string ): boolean;
function MensajeErr( sTitulo, sMensaje: string ): boolean;
function DialogoBox( sTitulo, sMensaje: string ): boolean;
function Escribe_Pdox( sFileName, sTxtLine: string; bDeleteFile: boolean ): boolean;

procedure Add_Log_Message(sFolio,
                         sTransaccion: string;
                         fItem_Omd: Double;
                         sMensaje,
                         sModulo: string );

function Busca_Motivo( sEmpresa,
                       sCartera,
                       sTransaccion,
                       sFolio          : string;
                       fItem_Omd       : Double;
                       dFecha: TDateTime): string;

function dias360(fInicial,fFinal:tdateTime;metodo:boolean):integer;

function Determina_Cartera_Vida( sEmpresa,
                                 sCartera : String
                               ) : Boolean;

Function ValidaCaracteresArchivo(Variable: String):String;

Function ValidaCaracteresNombreArchivo(Variable: String):String;
                               
Function ValidaCaracteresCirculares(Variable: String):String;

Function Elimina_Acentos_y_ñ(Variable: String):String;

function diasHabiles( dFecha_Inicial, dFecha_Final :tdateTime;
                      sCodigo_Division : String ):integer;

procedure Separa_Campos_String(cSeparador : Char;
                               cElimina   : Char;
                               S         : String;
                               var String_Arr : TArr100_String);
procedure Marca_Proceso_Valorizacion(sMarca : String);
procedure Marca_Proceso_Proy_Vctos_Mesa(sMarca : String; sLogin : String);
procedure Marca_Proceso_General(sMarca : String);

function Generando_stock(sMarca: String):Boolean;
function borrar_nemotecnico(sNemotecnico: String):Boolean;

function StrRemove(cString, cRemove: string): string;
function BuscaStr(cString, sBusca: string): Boolean;
function BuscaStrArray(sBusca: String; String_Arr : TArr100_String):Boolean;
function StrTran(cString, cSearch, cReplace: string): string;
procedure DateDiff(Date1, Date2: TDateTime; var Days, Months, Years: Word);
function MonthsBetween(Date1, Date2: TDateTime): Double;
procedure Busca_param_proceso_PMS_I(sCod_Proceso  : String;
                                    sParametro    : String;
                                    var sValor    : String;
                                    var result    : boolean);
procedure Busca_param_proceso(sCod_Proceso  : String;
                              sParametro    : String;
                              var sValor    : String;
                              var result    : boolean);
Procedure Busca_param_proceso_mult(sCod_Proceso  : String;
                                   sParametro    : String;
                                   var sValor    : String;
                                   var result    : boolean);
Procedure Graba_param_proceso(sCod_Proceso  : String;
                              sParametro    : String;
                              sValor        : String);
Procedure Agrega_param_proceso(sCod_Proceso  : String;
                              sParametro    : String;
                              sValor        : String);

Procedure Elimina_Param_proceso(sCod_Proceso  : String);
Procedure Elimina_Param_proceso2(sCod_Proceso  : String; sParametro : String);
Procedure Elimina_Param_Empresa(fPid          : Double);

function encripta_printeables(sString : String):String;

function Encripta(cadena,clave : string) : string;
function Implicancia( sTransaccion : String ) : String;

function valida_caracteres_password(sString : String): Boolean;

function valida_caracteres_grafico(sString : String): Boolean;

function reemplaza_caracteres_grafico(sString : String): String;

function valida_largo_minimo_password(sTitulo:String ; sString : String): Boolean;   // AB 20/7/2004
function valida_largo_maximo_password(sTitulo:String ; sString : String): Boolean;   // AB 20/7/2004

function Obtener_Tipo_Movimiento(sEMPRESA         : String;
                                 sCARTERA         : String;
                                 sPLAN_CUENTA     : String;
                                 fCUENTA          : Double;
                                 sHECHO_ECON      : String;
                                 sCOLUMNA_PROCESO : String;
                                 sDEBE_HABER	  : String;
                                 sFECHA           : TDateTime) : String;

function Convierte_a_punto(X:String):double;

function Busca_Cierre_Cont_Nvo(sProceso : String;
                               sEmpresa : String;
                               sCartera : String;
                               sTipo_Contab : String;
                               var dFecha   : TDatetime;
                               var sMensaje : String) : Boolean;

function Busca_Cierre_Contable(sProceso : String;
                               sEmpresa : String;
                               sCartera : String;
                               var dFecha   : TDatetime) : Boolean;

Procedure AsignaParametrosEmpresas(PID:Double);
Procedure EliminaParametrosEmpresas(PID:Double);

function Busca_Nombre_Menu(sNombre_Programa : string): string;

procedure Existe_Tabla_en_Base_de_datos( sDriver       : String;
                                         sNombre_Tabla : String;
                                         var sModulo_Err  : String;
                                         var sString_Err  : String;
                                         var bExiste      : Boolean;
                                         var Result       : Boolean);

function leer_cond_pago(sEmpresa:String;fDir:Double;sSistema:String;sCond_Pago:String): Boolean;

Procedure Existe_param_proceso(sCod_Proceso  : String;
                               sParametro    : String;
                               sValor        : String;
                               var result    : boolean);

Function CastigaMoneda_Tsa(Moneda : String; String_Arr : TArr100_String ):Boolean;

function Busca_Imp_Nem(sNemotecnico : String;
                       dFecha       : TDateTime): String;

Procedure leer_avaluo_nemotecnico(sNemotecnico : String;
                                  dFecha       : TDateTime;
                                  Var sMoneda_Avaluo : String;
                                  Var fMonto_Avaluo  : Double;
                                  var bResult        : Boolean);

Function Verifica_Licencia(sEmpresa,
                           sModulo :String):Boolean;



Procedure Graba_Archivo_Texto(sFile, sMensaje :String);

function Ano_Visiesto(ano:word): boolean;


Procedure Ubicacion_Funcional(sEmpresa        : String;
                              fNodo_Funcional : Double;
                          var sUbicacion      : String;
                          var result          : boolean);
                          
function valida_solocaract_password(spassword : String):Boolean;                          

function valida_caract_password(spassword : String):Boolean;
function existe_crypt(sEmpresa  : String) : Boolean;

Procedure Busca_Datos_Universales(Empresa           :String;
                                  Transaccion       :String;
                                  Folio             :String;
                                  Item              :double;
                                  Codigo            :String;
                                  Fecha_Proceso     :tdatetime;
                                  Var CodigoRetorno :String);

Function Graba_Datos_Universales(Empresa       :String;
                                 Transaccion   :String;
                                 Folio         :String;
                                 Item          :double;
                                 Codigo        :String;
                                 Fecha_Proceso :tdatetime;
                                 CodigoRetorno :String) :Boolean;

function Leer_Clasificacion(sClasificacion : String) :Boolean;

procedure Deterioro_Provision(sEmpresa,
                              sTransaccion,
                              sFolio_Interno : String;
                              fItem_Omd      : Double;
                              dFecha_Proceso : TdateTime;
                              var fDet_Prov  : Double);

procedure Detalle_OMD_Re_Allocation(dFecha     : TDateTime;
                                    sCondicion : String;
                                    bValorizacion,         // para saber si viene desde el proceso de valorizacion, si es True solo requerimos las compras
                                    bRenta_Variable,       // para saber si toma Renta Variable
                                    bPactos_RV,            // para saber si toma Pactos de Renta Variable
                                    bSeleccion_Ventas,     // para saber si Incluyo las ventas (libro de compras no debe incluirlas)
                                    bIncluye_Vencidos : Boolean);


procedure Borra_OMD_Re_Allocation(dFecha :TDateTime);

procedure recursivo_reallocation(sFolio_interno :string;
                                 fitem_omd       :Double;
                                 stransaccion    :string;
                                 sempresa        :string;
                                 dFecha          :TDateTime;
                             var fItem_recursivo :Double);

procedure Busca_OtrasClasif_Instrum(sInstrumentos : String;
                                    sTipoClasif   : String;
                                    sNodos_Hijos  : String;
                                    Var Result    : Boolean);

procedure Busca_Clasif_Nemotecnico(sObjeto       : String;
                                   sNemotecnico  : String;
                                   sTipoClasif   : String;
                                   sNodos_Hijos  : String;
                                   Var Result    : Boolean);

Function LLena_String_Implicancia(simplicancia : String) : String;

Function Llena_String_Proceso_provision(dFecha : TDateTime) : String;

function Escribe_Fisica( sFileName, sTxtLine: string; bDeleteFile: boolean): boolean;

Function Busca_Cartera_Re_Allocation(dFecha         : TDateTime;
                                     sFolio_Interno : String;
                                     fItem_OMD      : Double;
                                     sTransaccion   : String;
                                     sEmpresa       : String) : String;
procedure borra_historial_log(sLogin_Sistema : String;
                              fNro_Historia  : Integer);
function Parametro_encriptado( sProceso   : String;
                               sParametro : String) : Boolean;

Function Metodo_Clasificacion( sCartera,
                               sNemotecnico : String) : String;

function verifica_cierre(sProceso  :String;
                         bCarteras :Boolean;
                     var dFecha    :TDateTime;
                     var sMensaje  :String):Boolean;

function verifica_carteras(sProceso :String;
                       var sMensaje :String):Boolean;

Procedure Busca_Datos_Universales_RV(Empresa           : String    ;
                                     Cartera           : String    ;
                                     Transaccion       : String    ;
                                     Nemotecnico       : String    ;
                                     Codigo            : String    ;
                                     Fecha_Proceso     : tdatetime ;
                                     Var CodigoRetorno : String    );

function GetLocaleInformation(lcType : LCTYPE) : string;
Procedure Datos_Cobertura_Nemotecnico(sNemotecnico    : String;
                                      sCartera        : String;
                                      dFecha_Proceso  : TDateTime;
                                  var sValor  :String);
procedure Llena_Carteras_Lim(sProceso : String);

procedure Tiene_Limite(dfecha             : TDateTime;
                       var sString_RTPR   : String;
                       var sString_Limite : String);
function agrega_omd_excedida(sAux_transaccion    : String;
                              sAux_Folio_Interno  : String;
                              sAux_Empresa        : String;
                              sAux_Cartera        : String;
                              dAux_Fecha          : TDateTime;
                              sConLimite          : Boolean):Boolean;

function elimina_OMD_Limite_RF(sEmpresa       : String;
                               sTransaccion   : String;
                               sFolio_interno : String;
                               dfecha_hora    : TDateTime;
                               fValor_Pte_Mix : Double;
                               sNemotecnico   : String;
                               fValor_Nominal : Double;
                               sEstrategia    : String;
                               sAccion        : String): Boolean;

function elimina_OMD_Limite_RV(sEmpresa       : String;
                               sCartera       : String;
                               sTransaccion   : String;
                               sFolio_interno : String;
                               dfecha_hora    : TDateTime;
                               fValor_Pte_Mix : Double;
                               sNemotecnico   : String;
                               fValor_Nominal : Double;
                               sEstrategia    : String;
                               sAccion        : String): Boolean;

procedure Resta_limites(sAux_Empresa        : String;
                        dAux_Fecha          : TDateTime;
                        sAux_transaccion    : String;
                        sAux_Folio_Interno  : String;
                        bResult             : Boolean);


function StrFormatoMin(sString : String;
                       sTipo   : String): string;  //1 = Cada palabra comienza con Mayuscula //2 = Primera palabra del parrafo comienza con Mayuscula

function StrPrural(sString : String) :string;

Function Busca_Re_Allocation(dFecha         : TDateTime;
                             sFolio_Interno : String;
                             fItem_OMD      : Double;
                             sTransaccion   : String;
                             sEmpresa       : String) : Boolean;

Function Busca_Asignacion_Automatica(dFecha         : TDateTime;
                                     sFolio_Interno : String;
                                     fItem_OMD      : Double;
                                     sTransaccion   : String;
                                     sEmpresa       : String) : Boolean;
procedure habilita_mapeo();

procedure existe_dll_excel();

function Titulos_Vigentes(sEmpresa       : String;
                          sTransaccion   : string;
                          sFolio_interno : string;
                          fItem_omd      : Double;
                          dFecha_Cierre  : TDateTime) :Double;

function Busca_Campo_en_OMD(sEmpresa,
                            sTransaccion,
                            sFolio,
                            sCampo       : string) :string;

function Query_a_String(Query      :TFDQuery) :string;

function Leer_Unidad_Medida(sCod_Unidad : String;
                            sDet_Unidad : String) :Boolean;

procedure recursivo_ventas(sFolio_interno  :string;
                           fitem_omd       :Double;
                           stransaccion    :string;
                           sempresa        :string;
                           dFecha          :TDateTime;
                       var fItem_recursivo :Double);

procedure Genera_Ventas(sString_Empresas    :String;
                        sImplicancia_Venta  :String;
                        sImplicancia_Pacto  :String;
                        sImplicancia_Margen :String;
                        sImplicancia_RV     :String;
                        dFecha_Inicial      :TDAteTime
                       );

function Nominales_Vendidos(sEmpresa          :String;
                            sTransaccion      :String;
                            sFolio_interno    :String;
                            fItem_Omd         :Double;
                            dFecha_Vcto_Cupon :TDateTime) :Double;

function DatosUniversal(sEmpresa           : String;
                        sTransaccion_OMD   : String;
                        sFolio_Interno_OMD : String;
                        fItem_OMD          : Double;
                        fItem_Movimiento   : Double;
                        dFecha_Movimiento  : TDateTime):Boolean;

function Leer_fecha_Reallocation(sempresa         : String;
                                 stransaccion     : String;
                                 sFolio_interno   : String;
                                 fItem_omd        : Double;
                                 dfecha           : TDateTime;
                             var sCartera_realloc : String): TDateTime;

procedure Nemotecnico_Pasivo_Swap(sFolio_interno   : String;
                                  var sNemotecnico : String;
                                  var sSerie       : String;
                                  var sEmisor      : String;
                                  var sInstrumento : String);

Function Existe_Rol_Cartera(sEmpresa     : String;
                            sCartera     : String;
                            sRol         : String;
                            dFecha_Vig   : TDatetime;
                            var dFecha_Desde : TDatetime): Boolean;

function CarpetaExisteYEsAccesible(const ruta: string): Boolean;

var
  DataModule_Comun: TDataModule_Comun;

implementation

uses DM_Base_Datos,
     DM_Threadvar,
     DM_Encripta,
     MensajesDialog,
     DMLeer_valor_Cambio;
    // RPreview,
    // Informe_Errores;


{$R *.DFM}

function valida_caracteres_password(sString : String): Boolean;
var
i : Integer;
begin
Result := True;
for i := 1 to length(sString) do
  if pos(Copy(sString,i,1),sStr1) = 0 then
     if pos(Copy(sString,i,1),sStr2) = 0 then
        Result := False;
end;

function valida_caracteres_Grafico(sString : String): Boolean;
var
i : Integer;
begin
Result := True;
for i := 1 to length(sString) do
  if pos(Copy(sString,i,1),sStr3) = 0 then
     Result := False;
end;

function reemplaza_caracteres_Grafico(sString : String): String;
var i : Integer;
begin
   for i := 1 to Length(sString) do
       if not valida_caracteres_Grafico(sString[i]) then
          sString[i]:= '_';
   Result := sString;
end;

function valida_largo_minimo_password(sTitulo:String ; sString : String): Boolean;   //AB 20/7/2004
var
  p_largo_string,p_largo_int:integer;
  s_mensaje:string;
begin
Result := True;
p_largo_string:=length(sString);

With DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT valor AS p_largo'
             +'  FROM QS_SYS_PARAM_PROCESO '
             +' WHERE proceso   = ''VALLARPAS'' '
             +'   AND parametro = ''LARGOMIN'' '
             );
      Close;
      Prepare;
      Open;

      if not FieldByName('p_largo').isnull then
         begin
           p_largo_int:=strtoint(FieldByName('p_largo').AsString);

           if p_largo_string < p_largo_int then
              begin
                s_mensaje:='La longitud mínima de la contraseña debe ser de '+FieldByName('p_largo').AsString+' caracteres';
                MensajeBox(sTitulo, s_mensaje);
//                Application.MessageBox(pchar(s_mensaje)
//                                      ,pchar(Stitulo)
//                                      ,mb_Ok);
                Result := False;
              end;
         end;
      Close;
      UnPrepare;
    end;
end;

function valida_largo_maximo_password(sTitulo:String ; sString : String): Boolean;   //AB 20/7/2004
var
  p_largo_string,p_largo_int:integer;
  s_mensaje:string;
begin
Result := True;
p_largo_string:=length(sString);

With DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT valor AS p_largo'
             +'  FROM QS_SYS_PARAM_PROCESO '
             +' WHERE proceso   = ''VALLARPAS'' '
             +'   AND parametro = ''LARGOMAX'' '
             );
      Close;
      Prepare;
      Open;

      if not FieldByName('p_largo').isnull then
         begin
           p_largo_int:=strtoint(FieldByName('p_largo').AsString);

           if p_largo_string < p_largo_int then
              begin
                s_mensaje:='La longitud máxima de la contraseña debe ser de '+FieldByName('p_largo').AsString+' caracteres';
                MensajeBox(sTitulo, s_mensaje);
//                Application.MessageBox(pchar(s_mensaje)
//                                      ,pchar(Stitulo)
//                                      ,mb_Ok);
                Result := False;
              end;
         end;
      Close;
      UnPrepare;
    end;
end;

function encripta_printeables(sString : String):String;
var
  i : Integer;
  sStringKey2 : String;
  sStringKeyEspecial : String;

begin
  Result := '';
  sStringKey2 := '';
  sStringKeyEspecial := '';
  for i := length(sStr1) downto 1 do
    sStringKey2 := sStringKey2 + Copy(sStr1,i,1);
  for i := length(sStr2) downto 1 do
    sStringKeyEspecial := sStringKeyEspecial + Copy(sStr2,i,1);

  for i := 1 to length(sString) do
     if pos(Copy(sString,i,1),sStr1) <> 0 then
        Result:= Result + Copy(sStringKey2,Pos(sString[i],sStr1),1)
     else
        Result:= Result + Copy(sStringKeyEspecial,Pos(sString[i],sStr2),1);
end;

function Encripta(cadena,clave : string) : string;
var
  i : integer;
begin
  result:='';
  for i:=1 to length(cadena) do
    result:=result+chr(ord(cadena[i]) xor ord(clave[i mod length(clave)]));
end;

function fecha_valida(sFecha : String):Boolean;
const
   aa = 1899;
   mm = 12;
   dd = 30;
var
  Aux_fecha : TDateTime;
//  aa,mm,dd  :
begin
  try
    Aux_Fecha := StrToDate(sFecha)
  except
    Result := False;
    exit;
  end;


  if Aux_Fecha = EnCodeDate(aa,mm,dd) then
     begin
       Result := False;
       Exit;
     end;

  Result := True;

end;

function existen_registros(stabla,swhere_part : string):boolean;
begin
  Result := True;
  With DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS p_numero'
             +'  FROM ' + stabla
             +' WHERE '+ swhere_part
             );
      Close;
      Prepare;
      Open;
      if FieldByName('p_numero').AsInteger = 0 then
         Result := False;
      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
function instrumento_seriado(sCod_Instrumento : string):boolean;
begin
   Result := False;
   With DataModule_Comun.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('Select si_no_Descriptor AS sino_Descriptor'
             +'  FROM QS_FIN_INSTRUM'
             +' WHERE Cod_Instrumento = '''+sCod_Instrumento+''''
             );
      Prepare;
      Open;
      if FieldByName('sino_Descriptor').AsString = 'S' then
         Result := True;
      Close;
      UnPrepare;
   end;
end;
//------------------------------------------------------------------------------
function instrumento_rv(sCod_Instrumento : string):boolean;
begin
   Result := False;
   With DataModule_Comun.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('Select Tipo_Instrumento AS Tipo_Instrumento'
             +'  FROM QS_FIN_INSTRUM'
             +' WHERE Cod_Instrumento = '''+sCod_Instrumento+''''
             );
      Prepare;
      Open;
      if FieldByName('Tipo_Instrumento').AsString = 'RV' then
         Result := True;
      Close;
      UnPrepare;
   end;
end;
//------------------------------------------------------------------------------
function ultimo_dia_mes(wmes,wano : word) : word;
var
  dfecha : tdatetime;
//  wdia   : word;
begin
   wmes := wmes + 1;
   if wmes > 12 then
      begin
         wmes := 1;
         wano := wano + 1;
      end;
   dfecha := EncodeDate(wano,wmes,1);
   dfecha := dfecha - 1;
   decodeDate(dfecha,wano,wmes,Result);
end;
//------------------------------------------------------------------------------
function dia(dFecha : TdateTime) : Word;
var
   mm,aa : Word;
begin
  DecodeDate(dFecha,aa,mm,Result);
end;
//------------------------------------------------------------------------------
function mes(dFecha : TdateTime) : Word;
var
   dd,aa : Word;
begin
  DecodeDate(dFecha,aa,Result,dd);
end;
//------------------------------------------------------------------------------
function ano(dFecha : TdateTime) : Word;
var
   dd,mm : Word;
begin
  DecodeDate(dFecha,Result,mm,dd);
end;
//------------------------------------------------------------------------------
function primer_fecha_mes(dFecha : TDatetime) : TDatetime;
var
  wano,
  wmes,
  wdia   : word;

begin
   decodedate(dFecha,wano,wmes,wdia);
   Result := encodedate(wano,wmes,1);
end;
//------------------------------------------------------------------------------
function ultima_fecha_mes(dFecha : TDatetime) : TDatetime;
var
  wano,
  wmes,
  wdia   : word;

begin
   decodedate(dFecha,wano,wmes,wdia);
   Result := encodedate(wano,wmes,ultimo_dia_mes(wmes,wano));
end;
//------------------------------------------------------------------------------
function transaccion_implica(sTransaccion,
                             sImplicancia : String): Boolean;
begin
  //Result := False;

  Result := transaccion_implica_Mem( sTransaccion
                                    ,sImplicancia);
  {
  With DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Implicancia'
             +'  FROM QS_SYS_TRAN_IMPLIC'
             +' WHERE Codigo_Transaccion = :Codigo_Transaccion'
             +'   AND Implicancia        = :Implicancia'
             );

      ParamByName('Codigo_Transaccion').AsString := trim(sTransaccion);
      ParamByName('Implicancia').AsString        := trim(sImplicancia);
      Prepare;
      Open;

      if FieldByName('Implicancia').AsString = sImplicancia then
         Result := True;

      Close;
      UnPrepare;
    end;
  }
end;
//------------------------------------------------------------------------------
procedure graba_implicancia(sTransaccion,
                            sImplicancia : String);
begin
   With DataModule_Comun.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('DELETE FROM QS_SYS_TRAN_IMPLIC'
             +' WHERE Codigo_Transaccion = :Codigo_Transaccion'
             +'   AND Implicancia        = :Implicancia'
             );
      ParamByName('Codigo_Transaccion').AsString := trim(sTransaccion);
      ParamByName('Implicancia').AsString        := trim(sImplicancia);
      Prepare;
      ExecSQL;
      Close;
      UnPrepare;

      SQL.Clear;
      SQL.Add('INSERT INTO QS_SYS_TRAN_IMPLIC'
             +'(Codigo_Transaccion '
             +',Implicancia '
             +')'
             +'VALUES '
             +'(:Codigo_Transaccion'
             +',:Implicancia '
             +')');
      ParamByName('Codigo_Transaccion').AsString := trim(sTransaccion);
      ParamByName('Implicancia').AsString        := trim(sImplicancia);
      Prepare;
      ExecSQL;
      Close;
      UnPrepare;
   end;
end;
//------------------------------------------------------------------------------
procedure borra_implicancia(sTransaccion,
                            sImplicancia : String);
begin
   With DataModule_Comun.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('DELETE FROM QS_SYS_TRAN_IMPLIC'
             +' WHERE Codigo_Transaccion = :Codigo_Transaccion'
             +'   AND Implicancia        = :Implicancia'
             );
      ParamByName('Codigo_Transaccion').AsString := trim(sTransaccion);
      ParamByName('Implicancia').AsString        := trim(sImplicancia);
      Prepare;
      ExecSQL;
      Close;
      UnPrepare;
   end;
end;
//------------------------------------------------------------------------------
function Datos_Transaccion(sTransaccion     : String;
                           var sRelacion    : String;
                           var sSistema     : String;
                           var sDescripcion : String;
                           var sModulo_Err  : String;
                           var sString_Err  : String) : Boolean;
begin
     WITH DataModule_Comun.QRY_General do
       begin
         SQL.Clear;
         SQL.Add('SELECT Relacion'
                +'      ,Codigo_Sistema'
                +'      ,Descripcion'
                +'  FROM QS_SYS_TRANSACCION'
                +' WHERE Codigo_Transaccion = :Codigo_Transaccion'
                );

         ParamByName('Codigo_Transaccion').AsString := sTransaccion;
         Prepare;
         Open;
         if FieldByName('Relacion').IsNull then
            begin
              sModulo_Err := 'Definición de Transacciones';
              sString_Err := '¡Error en definición para transacción: '
                             +sTransaccion+'!';
              Close;
              UnPrepare;
              Result := False;
              exit;
            end;

         sRelacion    := FieldByName('Relacion').AsString;
         sSistema     := FieldByName('Codigo_Sistema').AsString;
         sDescripcion := FieldByName('Descripcion').AsString;
         Result := True;
         Close;
         UnPrepare;
       end;
end;
//------------------------------------------------------------------------------
(*  Valida permisos ...  *)
procedure valida_permiso(xempresa,xperfil,xprograma : string;
          var
          xejecuta,
          xinserta,
          xelimina,
          xmodifica : boolean);
begin
     xejecuta  := FALSE;
     xinserta  := FALSE;
     xelimina  := FALSE;
     xmodifica := FALSE;

     WITH DataModule_Comun.QRY_General do
       begin
            SQL.Clear;
            SQL.Add('SELECT ejecuta_sn  AS p_ejecuta'
                    +'     ,inserta_sn  AS p_inserta'
                    +'     ,elimina_sn  AS p_elimina'
                    +'     ,modifica_sn AS p_modifica'
                    +'  FROM qs_sys_perfil_opc'
                    +' WHERE nombre_programa = ''' + xprograma + ''''
                    +'   AND cod_perfil      = ''' + xperfil + ''''
                    );
            prepare;
            open;

            IF FieldByName('p_ejecuta').AsString = 'S' THEN
               xejecuta := TRUE;
            IF FieldByName('p_inserta').AsString = 'S' THEN
               xinserta := TRUE;
            IF FieldByName('p_elimina').AsString = 'S' THEN
               xelimina := TRUE;
            IF FieldByName('p_modifica').AsString = 'S' THEN
               xmodifica := TRUE;
            Close;
            UnPrepare;
       end;
end;
//------------------------------------------------------------------------------
{Pone el owner a la tabla para efectos de poder ver los indices en MSSQL}
procedure pone_owner_MSSQL(var sNombre_Tabla : String;
                           var Resultado     : Boolean);
begin
  Resultado := True;
  Exit;
  WITH DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('select b.name as Owner'
             +'  from sysobjects a'
             +'      ,sysusers b'
             +' where a.name = :Nombre_Tabla'
             +'   and a.uid = b.uid'
             );
      ParamByName('Nombre_Tabla').AsString := Trim(sNombre_Tabla);
      Prepare;
      Open;
      if FieldByName('Owner').IsNull then
         Resultado := False
      else
         sNombre_Tabla := FieldByName('Owner').AsString
                         +'.'
                         +Trim(sNombre_Tabla);
      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
{Procedimiento que retorna dirección del padre en la estructura física
 Retorna FALSE cuando no encuentra nodos superiores (CUANDO LLEGA A LA RAIZ) }
procedure Direccion_Padre(sEmpresa  : String;
                          var fItem_dir : Double;
                          var Result    : Boolean);
var
  aux_pchar       : Array[0..250] of Char;
  faux_Nodo_Padre : Double;
begin
  Result := True;
  WITH DataModule_Comun.QRY_General do  // Busco Registro en Estructura Jerárquica
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Nodo'
             +'      ,Nodo_Padre'
             +'  FROM QS_SYS_ID_ESTGERD'
             +' WHERE Codigo_Identidad = :Codigo_Identidad'
             +'   AND Item_Direccion   = :Item_Direccion'
             );

      ParamByName('Codigo_Identidad').AsString := sEmpresa;
      ParamByName('Item_Direccion').AsFloat    := fItem_dir;

      Prepare;
      Open;
      if FieldByName('Nodo_Padre').IsNull then
         begin
           Close;
           UnPrepare;
           strpcopy(aux_pchar
                   ,'Se detecto un error en definición de estructura jerárquica'#10
                   +'Para: '+sEmpresa+' Direccion : '+floattostr(fItem_dir)+''#10
                   +'Dirección no existe'#10
                   +'Avise al administrador del sistema'
                   );

           Application.MessageBox(aux_pchar
                                 ,'Sistema'
                                 , mb_OK);
           Result := False;
           exit;
         end;

      if FieldByName('Nodo_Padre').AsFloat = FieldByName('Codigo_Nodo').AsFloat then
         begin                  // Cuando Nodo = Padre es la Raiz
          Close;
          UnPrepare;
          Result := False;
          exit;
         end;

      faux_Nodo_Padre := FieldByName('Nodo_Padre').AsFloat;
      Close;
      UnPrepare;

      SQL.Clear;
      SQL.Add('SELECT Item_Direccion'
             +'  FROM QS_SYS_ID_ESTGERD'
             +' WHERE Codigo_Identidad = :Codigo_Identidad'
             +'   AND Codigo_Nodo      = :Codigo_Nodo'
             );

      ParamByName('Codigo_Identidad').AsString := sEmpresa;
      ParamByName('Codigo_Nodo').AsFloat       := faux_Nodo_Padre;

      Prepare;
      Open;

      if FieldByName('Item_Direccion').IsNull then
         begin
           Close;
           UnPrepare;
           strpcopy(aux_pchar
                   ,'Se detecto un error en definición de estructura jerárquica'#10
                   +'Para: '+sEmpresa+' Direccion : '+floattostr(fItem_dir)+''#10
                   +'Nodo padre no existe'#10
                   +'Avise al administrador del sistema'
                   );

           Application.MessageBox(aux_pchar
                                 ,'Sistema'
                                 , mb_OK);
           Result := False;
           exit;
         end;
      fItem_dir := FieldByName('Item_Direccion').AsFloat;
      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
{Entrega el Siguiente folio disponible}
procedure Leer_Folio(sEmpresa,
                     sEntidad,
                     sTransaccion,
                     sInterno_Preimpreso : String;
                     dFecha       : TDatetime;
                     var fFolio   : Double;
                     var Result   : Boolean);
var
  aux_pchar       : Array[0..250] of Char;
begin
  Result := True;
  fFolio := 0;
  WITH DataModule_Comun.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT codigo_identidad as empresa, Folio_Actual'
           +'      ,Folio_Hasta'
           +'  FROM QS_SYS_FOLIOS_DET'
           +' WHERE Codigo_Identidad   = :Codigo_Identidad'
           +'   AND Codigo_Transaccion = :Codigo_Transaccion'
           +'   AND Inter_Preim        = :Inter_Preim'
           +'   AND Codigo_Entidad     = :Codigo_Entidad'
           +'   AND Fecha_Desde        <= :Fecha'
           +'   AND (Fecha_Hasta is null OR Fecha_Hasta >= :Fecha)'
           );
    ParamByName('Codigo_Identidad').AsString   := sEmpresa;
    ParamByName('Codigo_Transaccion').AsString := sTransaccion;
    ParamByName('Inter_Preim').AsString        := sInterno_Preimpreso;
    ParamByName('Codigo_Entidad').AsString     := sEntidad;
    ParamByName('Fecha').AsDate                := dFecha;

    Prepare;
    Open;

    if FieldByName('Folio_Actual').IsNull then
       Result := False;

    if (NOT FieldByName('Folio_Hasta').IsNull) AND Result then
       if FieldByName('Folio_Actual').AsFloat > FieldByName('Folio_Hasta').AsFloat then
       begin
         strpcopy(aux_pchar
                 ,'No se encontró definición vigente para folio'#10
                 +'Para: '
                    +sEmpresa
                    +' - '
                    +sTransaccion
                    +' - '
                    +sInterno_Preimpreso
                    +' - '
                    +sEntidad
                    +''#10
                 +'Folio supero rango definido'#10
                 +'Avise al administrador del sistema'
                 );
         Application.MessageBox(aux_pchar
                               ,'Sistema'
                               , mb_OK);
         Result := False;
       end;

    if Result then
       fFolio := FieldByName('Folio_Actual').AsFloat;

    Close;
    UnPrepare;
  end;
end;
//------------------------------------------------------------------------------
procedure Leer_Grabar_Folio(sEmpresa,
                            sEntidad,
                            sTransaccion,
                            sInterno_Preimpreso : String;
                            dFecha       : TDatetime;
                            var fFolio   : Double;
                            var Result   : Boolean);
var
  flag_ok    : Boolean;
  daux_fecha : Tdatetime;
begin
  Result := True;

  Leer_Folio(sEmpresa,     // Lo uso para validar que exista la definición de foliación
             sEntidad,
             sTransaccion,
             sInterno_Preimpreso,
             dFecha,
             fFolio,
             Result);
  if NOT Result then
     exit;

//try

  WITH DataModule_Comun.QRY_General do
  begin
     SQL.Clear;
     SQL.Add('SELECT Fecha_Desde'
            +'  FROM QS_SYS_FOLIOS_DET'
            +' WHERE Codigo_Identidad   = :Codigo_Identidad'
            +'   AND Codigo_Transaccion = :Codigo_Transaccion'
            +'   AND Inter_Preim        = :Inter_Preim'
            +'   AND Codigo_Entidad     = :Codigo_Entidad'
            +'   AND Fecha_desde        <= :Fecha'
            +'   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)'
            );
     ParamByName('Codigo_Identidad').AsString   := sEmpresa;
     ParamByName('Codigo_Transaccion').AsString := sTransaccion;
     ParamByName('Inter_Preim').AsString        := sInterno_Preimpreso;
     ParamByName('Codigo_Entidad').AsString     := sEntidad;
     ParamByName('Fecha').AsDate                := dFecha;
     Open;

     daux_fecha := FieldByName('Fecha_Desde').AsDateTime; // Clave del registro folio
     Close;

     SQL.Clear;
     SQL.Add('UPDATE QS_SYS_FOLIOS_DET'
            +'   SET Folio_Actual = Folio_Actual + 1'
            +' WHERE Codigo_Identidad   = :Codigo_Identidad'
            +'   AND Codigo_Transaccion = :Codigo_Transaccion'
            +'   AND Inter_Preim        = :Inter_Preim'
            +'   AND Codigo_Entidad     = :Codigo_Entidad'
            +'   AND Fecha_desde        = :Fecha'
            );
     ParamByName('Codigo_Identidad').AsString   := sEmpresa;
     ParamByName('Codigo_Transaccion').AsString := sTransaccion;
     ParamByName('Inter_Preim').AsString        := sInterno_Preimpreso;
     ParamByName('Codigo_Entidad').AsString     := sEntidad;
     ParamByName('Fecha').AsDate                := daux_fecha;
     Prepare;
     flag_ok := False;
     while NOT flag_ok do
       try
         begin
           ExecSQL;
           flag_ok := True;
         end
       except
         begin
           flag_ok := False;
           Sleep (2000);
         end;
       end;

//   Close;

     SQL.Clear;
     SQL.Add('SELECT Folio_Actual'
            +'  FROM QS_SYS_FOLIOS_DET'
            +' WHERE Codigo_Identidad   = :Codigo_Identidad'
            +'   AND Codigo_Transaccion = :Codigo_Transaccion'
            +'   AND Inter_Preim        = :Inter_Preim'
            +'   AND Codigo_Entidad     = :Codigo_Entidad'
            +'   AND Fecha_desde        <= :Fecha'
            +'   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)'
            );
     ParamByName('Codigo_Identidad').AsString   := sEmpresa;
     ParamByName('Codigo_Transaccion').AsString := sTransaccion;
     ParamByName('Inter_Preim').AsString        := sInterno_Preimpreso;
     ParamByName('Codigo_Entidad').AsString     := sEntidad;
     ParamByName('Fecha').AsDate                := daux_fecha;
     Open;

     fFolio := FieldByName('Folio_Actual').AsFloat - 1;

     Close;
  end;

//except
//
//  Result := False;
//
//end;

end;
//------------------------------------------------------------------------------
procedure Grabar_Folio(sEmpresa,
                      sEntidad,
                      sTransaccion,
                      sInterno_Preimpreso : String;
                      dFecha              : TDatetime;
                      fFolio              : Double;
                      var Result          : Boolean);
var flag_ok    : Boolean;
    daux_fecha : Tdatetime;
begin
   Result := True;
   WITH DataModule_Comun.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Fecha_Desde'
             +'  FROM QS_SYS_FOLIOS_DET'
             +' WHERE Codigo_Identidad   = :Codigo_Identidad'
             +'   AND Codigo_Transaccion = :Codigo_Transaccion'
             +'   AND Inter_Preim        = :Inter_Preim'
             +'   AND Codigo_Entidad     = :Codigo_Entidad'
             +'   AND Fecha_desde        <= :Fecha'
             +'   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)'
             );
      ParamByName('Codigo_Identidad').AsString   := sEmpresa;
      ParamByName('Codigo_Transaccion').AsString := sTransaccion;
      ParamByName('Inter_Preim').AsString        := sInterno_Preimpreso;
      ParamByName('Codigo_Entidad').AsString     := sEntidad;
      ParamByName('Fecha').AsDate            := dFecha;
      Open;
      daux_fecha := FieldByName('Fecha_Desde').AsDateTime; // Clave del registro folio
      Close;
      SQL.Clear;
      SQL.Add('UPDATE QS_SYS_FOLIOS_DET'
             +'   SET Folio_Actual = :Folio_Actual'
             +' WHERE Codigo_Identidad   = :Codigo_Identidad'
             +'   AND Codigo_Transaccion = :Codigo_Transaccion'
             +'   AND Inter_Preim        = :Inter_Preim'
             +'   AND Codigo_Entidad     = :Codigo_Entidad'
             +'   AND Fecha_desde        = :Fecha'
             );
      ParamByName('Codigo_Identidad').AsString   := sEmpresa;
      ParamByName('Codigo_Transaccion').AsString := sTransaccion;
      ParamByName('Inter_Preim').AsString        := sInterno_Preimpreso;
      ParamByName('Codigo_Entidad').AsString     := sEntidad;
      ParamByName('Fecha').AsDate            := daux_fecha;
      ParamByName('Folio_Actual').AsFloat        := fFolio;
      Prepare;
      flag_ok := False;
      while NOT flag_ok do
      begin
         try
            begin
               ExecSQL;
               flag_ok := True;
            end
         except
            begin
               flag_ok := False;
               Sleep (2000);
            end;
         end;
      end;
      Close;
   end;
end;
//------------------------------------------------------------------------------
function ajusta_decimales(Tipo_ajuste:String;X:extended; Dec:integer):double;
begin
  if Tipo_Ajuste = 'N' then
     Result := X
  else
    if Tipo_Ajuste = 'R' then
       Result := Redondeo(X,Dec)
    else
       Result := Truncado(X,Dec);
end;
//------------------------------------------------------------------------------
function Redondeo(X:extended; Dec:integer):double;
  function Signo(X:extended): EXTENDED;
  begin
    if X>0 then
       Result := 1
    else
      if X<0 then
         Result := -1
      else
         Result := 0;
  end;
 begin
    try
    Result := RoundD (X,Dec);
    except
    end;
{   Entero := Int(x);
   Potencia :=IntPower(10,Dec);
   Fraccion := X + (Signo(X)* 0.50000/Potencia);
   sString := FloatToStr(Fraccion);
   i := Pos('.',sString);

   if ((length(sString) - i + 1) < Dec) then
      Dec := length(sString) - i + 1;

   if i = 0 then
      Result := Entero
   else
      Result := strtofloat(Copy(sString,1,i+Dec))
}
 end;
//------------------------------------------------------------------------------

function Truncado(X:extended; Dec:integer):double;
 var
  entero,
  Potencia,
  Fraccion: extended;
 begin
   Entero := Int(x);
   Potencia :=IntPower(10,Dec);

   Fraccion:=Int((X-Entero)*Potencia)/Potencia;
   Result :=Entero + Fraccion;
 end;
//------------------------------------------------------------------------------
function feriado(sCodigo_Division : String;
                 dFecha           : TDatetime) : Boolean;
var
  wano,
  wmes,
  wdia : word;
  Buscar : Boolean;
begin
  Result := False;
  Buscar := True;
  if (sCodigo_Division = ' ') or
     (sCodigo_Division = '')  then
     exit;

  WITH DataModule_Comun.Qry_Feriado do
    begin
      decodedate(dFecha,wano,wmes,wdia);
      While Buscar do
        begin
          {
          SQL.Clear;
          SQL.Add('SELECT Codigo_Division'
                 +'  FROM QS_SYS_FERIADOS'
                 +' WHERE Codigo_Division = :Codigo_Division'
                 +'   AND (Ano_Feriado = 0 or Ano_Feriado = :Ano)'
                 +'   AND Mes_Feriado  = :Mes'
                 +'   AND Dia_Feriado  = :Dia'
                 );
         }
         ParamByName('Ano').AsFloat := wAno;
         ParamByName('Mes').AsFloat := wMes;
         ParamByName('Dia').AsFloat := wDia;

         ParamByName('Codigo_Division').AsString := trim(sCodigo_Division);
         Prepare;
         Open;
         if FieldByName('Codigo_Division').AsString = sCodigo_Division then
            begin
             Result := True;
             Buscar := False;
           end;
         Close;
         UnPrepare;

         Division_Geografica_Padre(sCodigo_Division,
                                   Buscar);
        end;
    end;
end;
//------------------------------------------------------------------------------
function dia_habil_siguiente(sCodigo_Division : String;
                             dFecha           : TDatetime) : TDatetime;
var
  dia_habil : Boolean;
begin
   dia_habil := False;
   WHILE NOT dia_habil do
   begin
     if sValorizacion_Proceso = 'SI' then
     begin
        if NOT (DayOfWeek(dFecha) in [1,7]) then
           if NOT Feriado_Mem(sCodigo_Division,
                              dFecha) then
              dia_habil := True
           else
              dFecha := dFecha + 1
        else
           dFecha := dFecha + 1;
     end
     else
     begin
        if NOT (DayOfWeek(dFecha) in [1,7]) then
           if NOT Feriado(sCodigo_Division,
                          dFecha) then
              dia_habil := True
           else
              dFecha := dFecha + 1
        else
           dFecha := dFecha + 1;
     end;
   end;
   Result := dFecha;
end;
//------------------------------------------------------------------------------
function dia_habil_anterior(sCodigo_Division : String;
                            dFecha           : TDatetime) : TDatetime;
var
  dia_habil : Boolean;
begin
   dia_habil := False;
   dFecha := dFecha - 1;
   WHILE NOT dia_habil do
   begin
     if sValorizacion_Proceso = 'SI' then
     begin
         if NOT (DayOfWeek(dFecha) in [1,7]) then
            if NOT Feriado_Mem(sCodigo_Division,
                           dFecha) then
               dia_habil := True
            else
               dFecha := dFecha - 1
         else
            dFecha := dFecha - 1
     end
     else
     begin
         if NOT (DayOfWeek(dFecha) in [1,7]) then
            if NOT Feriado(sCodigo_Division,
                           dFecha) then
               dia_habil := True
            else
               dFecha := dFecha - 1
         else
            dFecha := dFecha - 1;
     end;
   end;
   Result := dFecha;
end;
//------------------------------------------------------------------------------
function dia_habil_antes_despues(sCodigo_Division : String;
                                 dFecha           : TDatetime;
                                 sAntes_Despues   : String) : TDatetime;
var
  dia_habil : Boolean;
begin
   dia_habil := False;
   WHILE NOT dia_habil do
   begin
     if sValorizacion_Proceso = 'SI' then
     begin
         if NOT (DayOfWeek(dFecha) in [1,7]) then
            if NOT Feriado_Mem(sCodigo_Division,
                           dFecha) then
               dia_habil := True
            else
               if sAntes_Despues = '-' then
                  dFecha := dFecha - 1
               else
                  dFecha := dFecha + 1
         else
            if sAntes_Despues = '-' then
               dFecha := dFecha - 1
            else
               dFecha := dFecha + 1
     end
     else
     begin
        if NOT (DayOfWeek(dFecha) in [1,7]) then
           if NOT Feriado(sCodigo_Division,
                          dFecha) then
              dia_habil := True
           else
              if sAntes_Despues = '-' then
                 dFecha := dFecha - 1
              else
                 dFecha := dFecha + 1
        else
           if sAntes_Despues = '-' then
              dFecha := dFecha - 1
           else
              dFecha := dFecha + 1
     end;
   end;
   Result := dFecha;
end;
//------------------------------------------------------------------------------
function suma_dias_corridos(sCodigo_Division    : String;
                            dFecha_Origen       : TDateTime;
                            fDias_Suma          : Double) : TDateTime;
begin
  Result := dFecha_Origen;
  While fDias_Suma > 0 do
  begin
     Result := Result + 1;
     fDias_Suma := fDias_Suma - 1;
  end;
end;
//------------------------------------------------------------------------------
function Resta_dias_corridos(sCodigo_Division    : String;
                             dFecha_Origen       : TDateTime;
                             fDias_Suma          : Double) : TDateTime;
begin
  Result := dFecha_Origen;
  While fDias_Suma > 0 do
  begin
     Result := Result - 1;
     fDias_Suma := fDias_Suma - 1;
  end;
end;
//------------------------------------------------------------------------------
function suma_dias_habiles(sCodigo_Division    : String;
                           dFecha_Origen       : TDateTime;
                           fDias_Suma          : Double) : TDateTime;
begin
  Result := dFecha_Origen;
  While fDias_Suma > 0 do
  begin
     Result := Result + 1;
     // Se comento la funcion memory ya que no estaba funcionando bien para la transaccion (Pago Mañana)
//   if sValorizacion_Proceso = 'SI' then
//   begin
//     if NOT (DayOfWeek(Result) in [1,7]) then
//        if NOT Feriado_Mem(sCodigo_Division,
//                       Result) then
//           fDias_Suma := fDias_Suma - 1;
//    end
//     else
//     begin
        if NOT (DayOfWeek(Result) in [1,7]) then
           if NOT Feriado(sCodigo_Division,
                          Result) then
              fDias_Suma := fDias_Suma - 1;
//     end;
  end;
end;
//------------------------------------------------------------------------------
function Resta_dias_habiles(sCodigo_Division    : String;
                           dFecha_Origen       : TDateTime;
                           fDias_Suma          : Double) : TDateTime;
begin
  Result := dFecha_Origen;
  While fDias_Suma > 0 do
  begin
     Result := Result - 1;
//   if sValorizacion_Proceso = 'SI' then
//   begin
    if NOT (DayOfWeek(Result) in [1,7]) then
       if NOT Feriado_Mem(sCodigo_Division,
                      Result) then
          fDias_Suma := fDias_Suma - 1;
{    end
     else
     begin
        if NOT (DayOfWeek(Result) in [1,7]) then
           if NOT Feriado(sCodigo_Division,
                          Result) then
              fDias_Suma := fDias_Suma - 1;
     end;}
  end;
end;
//------------------------------------------------------------------------------
function moneda_nacional : String;
begin
  Result := '';
  WITH DataModule_Comun.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT b.Cod_Moneda As Cod_Moneda'
              +'  FROM qs_sys_pais a'
              +'      ,qs_sys_monedas b'
              +' where nacion_pais     = ''N'''
              +'   and b.nacion_moneda = a.cod_pais'
              +'   and b.tipo_moneda   = ''M'''
              );

       Prepare;
       Open;
       if (FieldByName('Cod_Moneda').AsString = EmptyStr) or
          (FieldByName('Cod_Moneda').IsNull)              then
       begin
         Application.Messagebox('No se encontro definición de moneda nacional'
                               ,'Moneda Nacional'
                               ,mb_Ok);
         Result := 'NO DISPONIBLE';
       end
       else
         Result := FieldByName('Cod_Moneda').AsString;
       Close;
       UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
function redondeo_moneda(sCod_Moneda     : String;
                         dFecha_Redondeo : TDatetime;
                         fValor_Original : Double) : Double;
Var
  fDecimal_Ajuste : Integer;
  sTipo_Ajuste    : String;
  flag_Encontro   : Boolean;
begin
  fDecimal_Ajuste := 0;
  Flag_Encontro := False;

  // Si encuentro que estan cargados en memoria no acceso las tablas
  if VarIsArray(Reg_Redondeo_Monedas.Cod_Moneda) then
  begin
     Result := Redondeo_Moneda_Mem(sCod_Moneda
                                  ,dFecha_Redondeo
                                  ,fValor_Original);
     exit;
  end;



  WITH DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Max(Fecha_Desde_Ajuste) as Max_Fecha'
             +'  FROM QS_SYS_MON_REDON'
             +' WHERE Cod_Moneda = :Cod_Moneda'
             +'   AND Fecha_Desde_Ajuste <= :Fecha_Desde_Ajuste'
             );
      ParamByName('Cod_Moneda').AsString           := trim(sCod_Moneda);
      ParamByName('Fecha_Desde_Ajuste').AsDate := dFecha_Redondeo;
      Prepare;
      Open;
      if NOT (FieldByName('Max_Fecha').IsNull) then
         begin
           Flag_Encontro := True;
           dFecha_Redondeo := FieldByName('Max_Fecha').AsDatetime;
         end;

      Close;
      UnPrepare;

      if Flag_encontro then
         begin
            SQL.Clear;
            SQL.Add('SELECT Decimal_Ajuste'
                   +'      ,Tipo_Ajuste_Mon'
                   +'  FROM QS_SYS_MON_REDON'
                   +' WHERE Cod_Moneda = :Cod_Moneda'
                   +'   AND Fecha_Desde_Ajuste = :Fecha_Desde_Ajuste'
                   );
            ParamByName('Cod_Moneda').AsString           := trim(sCod_Moneda);
            ParamByName('Fecha_Desde_Ajuste').AsDate := dFecha_Redondeo;
            Prepare;
            Open;
            if NOT ((FieldByName('Decimal_Ajuste').IsNull) or
                    (FieldByName('Tipo_Ajuste_Mon').IsNull)) then
               begin
                  fDecimal_Ajuste := FieldByName('Decimal_Ajuste').AsInteger;
                  sTipo_Ajuste    := FieldByName('Tipo_Ajuste_Mon').AsString;
                  Flag_Encontro   := True;
               end;
            Close;
            UnPrepare;
         end;
    end;  // With

    if NOT Flag_Encontro then
       Result := fValor_Original
    else
       if sTipo_Ajuste = 'R' then
          Result := Redondeo(fValor_Original,fDecimal_Ajuste)
       else
          Result := Truncado(fValor_Original,fDecimal_Ajuste);
end;
//------------------------------------------------------------------------------
function directorio_windows : string;
var
  pWinPath    : PChar;
  aux_pchar    : array[1..254] of char;
begin
  pWinPath    := @aux_pchar[1];
  GetWindowsDirectory(pWinPath,250);
  Result       := StrPas(pWinPath);
end;
//------------------------------------------------------------------------------
function directorio_temp : string;
var
  pTempPath    : PChar;
  aux_pchar    : array[1..254] of char;
begin
  pTempPath    := @aux_pchar[1];
  GetTempPath(250,pTempPath);
  Result       := StrPas(pTempPath);
end;
//-comentada pnp 05-05-2015-----------------------------------------------------------------------------
//function directorio_bde : string;
//var
//  pTempPath    : PChar;
//  aux_pchar    : array[1..254] of char;
//  MyStringList : TStringList;
//  i : Integer;
//begin
//  pTempPath    := @aux_pchar[1];
//  try
//     MyStringList := TStringList.Create;
//     Session.GetAliasParams('Alias_Paradox',MyStringList);
//     for i :=0  to MyStringList.count -1 do
//     begin
//        if (copy(MyStringList[i],1,4) = 'PATH') then
//        begin
//           pTempPath := pchar(copy(MyStringList[i],6,length(MyStringList[i]))+'\');
//           Break;
//        end;
//     end;
//     Session.ModifyAlias('Alias_Paradox',MyStringList);
//  finally
//     MyStringList.Free;
//  end;
//
//  Result       := StrPas(pTempPath);
//end;
//------------------------------------------------------------------------------
function nombre_maquina : String;
var
   buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: Cardinal;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  Windows.GetComputerName(@buffer, Size);
  Result := StrPas(buffer);
end;
//------------------------------------------------------------------------------
function directorio_actual : string;
var
  pTempPath    : PChar;
  aux_pchar    : array[1..254] of char;
begin
  pTempPath    := @aux_pchar[1];
  GetCurrentDirectory(250,pTempPath);
  Result       := StrPas(pTempPath);
end;
//------------------------------------------------------------------------------
function fecha_hora_Servidor : TDateTime;
var
  sComando : String;
begin
  if sDriver = 'LOCAL' then
     Result := Date
  else
    begin
      if dmBaseDatos.Conexion_BaseDatos.Connected then
         DataModule_Comun.QRY_General.ConnectionName := 'PMSSERVER'
      else DataModule_Comun.QRY_General.ConnectionName := 'BASECLAVE';

      sComando := Leer_Comando(sDriver,'FECHAHORA');
      WITH DataModule_Comun.QRY_General do
      begin
        SQL.Clear;
        SQL.Add(sComando);
        Open;
        Result := FieldByName('Fecha_Servidor').AsDatetime;
        Close;
        UnPrepare;
      end;
    end;

end;
//------------------------------------------------------------------------------
function leer_Comando(sDriver          : String;
                      sComando         : String) : String;
Var
  aux_pchar : array[0..250] of char;
begin

  sDriver := UpperCase(sDriver);
  sComando := UpperCase(sComando);

  if sDriver = 'ORA' then
     sDriver := 'ORACLE';


  WITH DataModule_Comun.QRY_General do
  begin
      SQL.Clear;
      SQL.Add('SELECT Instruccion'
             +'  FROM QS_SYS_COMANDOS'
             +' WHERE Driver  = :Driver'
             +'   AND Comando = :Comando'
             );

      ParamByName('Driver').AsString := trim(sDriver);
      ParamByName('Comando').AsString := trim(sComando);

      //Prepare;
      Open;
      if FieldByName('Instruccion').IsNull then
      begin
           strpcopy(aux_pchar,
                    'ERROR FATAL !!!'+''#10
                   +'No se encontro comando "'+sComando+'"'#10
                   +'para driver "'+sDriver+'"'#10
                   +''#10
                   +'Se aborta ejecución del programa');

           Application.Messagebox(aux_pchar
                                 ,'Sistema'
                                 ,mb_Ok);
           Application.Terminate


      end;

      Result := trim(FieldByName('Instruccion').AsString);

      Close;
      UnPrepare;
  end;
end;
//------------------------------------------------------------------------------
// Elimina la hora quedando un datetime a las 00:00
function solo_fecha(fechahora : TDateTime) : TDatetime;
Var
  S : String;
begin
  S := datetostr(fechahora);
  Result := strtodate(S);
end;
//------------------------------------------------------------------------------
procedure Nombre_Unico(var sNombre_Base : String;
                       sNombre_Source   : String;
                       var Result       : Boolean);
var
  sTempPath    : string;
  pTempPath    : PChar;
  aux_pchar    : array[1..254] of char;
  fFilePoint   : TextFile;
  sSerial      : String;
  iSerial      : Integer;

begin
  pTempPath    := @aux_pchar[1];
  GetTempPath(250,pTempPath);
  sTempPath    := StrPas(pTempPath);
  Result       := True;

  if NOT FileExists(sTempPath+'\'+sNombre_Source+'.dat') then
     begin
        sSerial := '1';
        AssignFile(fFilePoint,sTempPath+'\'+sNombre_Source+'.dat');
        try
          begin
            ReWrite(fFilePoint);
            Writeln(fFilePoint,sSerial);
            CloseFile(fFilePoint);
          end
        except
          Result := False
        end;
     end
  else
     begin
       try
          begin
           AssignFile(fFilePoint,sTempPath+'\'+sNombre_Source+'.dat');  ;
           Reset(fFilePoint);
           Readln(fFilePoint,sSerial);
           iSerial := strtoint(sSerial);
           inc(iSerial);
           sSerial := inttostr(iSerial);
           ReWrite(fFilePoint);
           Writeln(fFilePoint,sSerial);
           CloseFile(fFilePoint);
          end
        except
          Result := False
        end;
     end;

  sNombre_Base := trim(sNombre_Base)+trim(sSerial);
end;
//------------------------------------------------------------------------------
procedure ayuda_contexto(idxayuda : THelpContext);
begin
    if not Application.HelpContext(idxayuda) then
     application.messagebox('No se encontro item de ayuda requerido'
                           ,'Ayuda en línea Front Office'
                           ,MB_Ok);
end;
//------------------------------------------------------------------------------
function fecha_de_Stock(sCartera : String):TDateTime;
begin
  Result := fecha_hora_Servidor;
  With DataModule_Comun.QRY_General do
  begin

      SQL.Clear;
      SQL.Add('SELECT MAX(a.fecha_stock) as fecha_stock'
             +'  FROM QS_TRA_OMD_STK_RF a');
      if sCartera <> 'CONSOLIDA' then
      begin
        SQL.Add(' WHERE a.Cartera = :Cartera');
        ParamByName('Cartera').AsString := sCartera;
      end
      else
      begin
         sql.add(' WHERE a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
         sql.add('                      WHERE  pid = :pid ');
         sql.add('                        and z.empresa = a.empresa ');
         sql.add('                     ) ');
         sql.add('   AND a.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
         sql.add('                      WHERE pid = :pid ');
         sql.add('                        and z.cartera = a.cartera ');
         sql.add('               ) ');
         ParamByName('pid').AsFloat := Application.Handle;
      end;
      Open;
      if NOT (FieldByName('fecha_stock').IsNull) then
         Result := FieldByName('fecha_stock').AsDateTime;

    {  else
         begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT fecha_stock'
                   +'  FROM QS_TRA_OMD_STK_RF');
           Open;
           if NOT FieldByName('fecha_stock').IsNull then
              Result := FieldByName('fecha_stock').AsDateTime;
          end;}
      Close;
    end;
end;
//------------------------------------------------------------------------------
function fecha_de_Stock_Derivado(sCartera : String):TDateTime;
begin
  Result := fecha_hora_Servidor;
  With DataModule_Comun.QRY_General do
  begin

      SQL.Clear;
      SQL.Add('SELECT MAX(a.fecha_stock) as fecha_stock'
             +'  FROM QS_TRA_OMD_STK_RF a');
      if sCartera <> 'CONSOLIDA' then
      begin
        SQL.Add(' WHERE a.Cartera = :Cartera');
        ParamByName('Cartera').AsString := sCartera;
      end
      else
      begin
         sql.add(' WHERE a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
         sql.add('                      WHERE  pid = :pid ');
         sql.add('                        and z.empresa = a.empresa ');
         sql.add('                     ) ');
         sql.add('   AND a.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
         sql.add('                      WHERE pid = :pid ');
         sql.add('                        and z.cartera = a.cartera ');
         sql.add('               ) ');
         ParamByName('pid').AsFloat := Application.Handle;
      end;
      SQL.Add('   AND a.Transaccion IN (SELECT Codigo_Transaccion ');
      SQL.Add('                           FROM QS_SYS_TRAN_IMPLIC ');
      SQL.Add('                          WHERE Implicancia = ''DERIVADO'') ');
      Open;
      if NOT (FieldByName('fecha_stock').IsNull) then
         Result := FieldByName('fecha_stock').AsDateTime;
      Close;
    end;
end;

function fecha_de_Stock2(sCartera : String; dfecha_stock : TDateTime):TDateTime;
begin
  Result := fecha_hora_Servidor;
  With DataModule_Comun.QRY_General do
  begin

      SQL.Clear;
      SQL.Add('SELECT fecha_stock'
             +'  FROM QS_TRA_OMD_STK_RF'
             +' WHERE fecha_stock = :fecha_stock');
      ParamByName('fecha_stock').AsDate := dfecha_stock;
      if sCartera <> 'CONSOLIDA' then
      begin
        SQL.Add(' AND Cartera = :Cartera');
        ParamByName('Cartera').AsString := sCartera;
      end;

      Open;
      if NOT (FieldByName('fecha_stock').IsNull) then
         Result := FieldByName('fecha_stock').AsDateTime
      else
      begin
         Close;
         SQL.Clear;
         SQL.Add('SELECT fecha_Cierre'
                +'  FROM QS_RES_MERCADO'
                +' WHERE fecha_Cierre = :fecha_Cierre');
         ParamByName('fecha_Cierre').AsDate := dfecha_stock;
         if sCartera <> 'CONSOLIDA' then
         begin
           SQL.Add(' AND Cartera = :Cartera');
           ParamByName('Cartera').AsString := sCartera;
         end;

         Open;
         if NOT (FieldByName('fecha_Cierre').IsNull) then
            Result := FieldByName('fecha_Cierre').AsDateTime;
      end;
      Close;
    end;
end;
//------------------------------------------------------------------------------
procedure mascara_decimales(var sMascara : String;
                            num_decimales : Integer;
                            cChar         : String);
begin
    if pos('.',sMascara) > 0 then
       sMascara := copy(sMascara
                       ,1
                       ,pos('.',sMascara)-1);

 if cChar = '0' then
   begin
    if num_decimales = 1 then
       sMascara := sMascara+'.0';
    if num_decimales = 2 then
       sMascara := sMascara+'.00';
    if num_decimales = 3 then
       sMascara := sMascara+'.000';
    if num_decimales = 4 then
       sMascara := sMascara+'.0000';
    if num_decimales = 5 then
       sMascara := sMascara+'.00000';
    if num_decimales = 6 then
       sMascara := sMascara+'.000000';
    if num_decimales = 7 then
       sMascara := sMascara+'.0000000';
    if num_decimales = 8 then
       sMascara := sMascara+'.00000000';
    if num_decimales = 9 then
       sMascara := sMascara+'.000000000';
    if num_decimales = 10 then
       sMascara := sMascara+'.0000000000';
    if num_decimales = 11 then
       sMascara := sMascara+'.00000000000';
    if num_decimales = 12 then
       sMascara := sMascara+'.000000000000';
    if num_decimales = 13 then
       sMascara := sMascara+'.0000000000000';
    if num_decimales = 14 then
       sMascara := sMascara+'.00000000000000';
    if num_decimales >= 15 then
       sMascara := sMascara+'.000000000000000';
   end;

 if cChar = '#' then
   begin
    if num_decimales = 1 then
       sMascara := sMascara+'.#';
    if num_decimales = 2 then
       sMascara := sMascara+'.##';
    if num_decimales = 3 then
       sMascara := sMascara+'.###';
    if num_decimales = 4 then
       sMascara := sMascara+'.####';
    if num_decimales = 5 then
       sMascara := sMascara+'.#####';
    if num_decimales = 6 then
       sMascara := sMascara+'.######';
    if num_decimales = 7 then
       sMascara := sMascara+'.#######';
    if num_decimales = 8 then
       sMascara := sMascara+'.########';
    if num_decimales = 9 then
       sMascara := sMascara+'.#########';
    if num_decimales = 10 then
       sMascara := sMascara+'.##########';
    if num_decimales = 11 then
       sMascara := sMascara+'.###########';
    if num_decimales = 12 then
       sMascara := sMascara+'.############';
    if num_decimales = 13 then
       sMascara := sMascara+'.#############';
    if num_decimales = 14 then
       sMascara := sMascara+'.##############';
    if num_decimales >= 15 then
       sMascara := sMascara+'.###############';
   end;
end;
//------------------------------------------------------------------------------
procedure Delay(msecs:integer);
var
   Inicio:longint;
begin
     Inicio:=GetTickCount;
     repeat
           Application.ProcessMessages; {permite realizar otras acciones}
     until ((GetTickCount-Inicio) >= Longint(msecs));
end;
//------------------------------------------------------------------------------
function decimales_moneda(sCod_Moneda : String;
                          dFecha      : TdateTime) : Integer;
begin
  With DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      // D.C. & F.I. 06-08-2015
      // Se detecto que estaba cargando redondeos que ya no estan vigentes
      // OJO: El MAX numero de decimales lo esta haciendo porque en gestion busca el maximo numero de decimales definido entre todas las monedas.
      SQL.Add('SELECT MAX(a.Decimal_Ajuste) As Decimal_Ajuste'

             +'  FROM QS_SYS_MON_REDON a'
             +'      ,QS_SYS_MONEDAS   b');
      if trim(sCod_Moneda) = '' then
         SQL.Add(' WHERE 1 = 1 ')
      else
         SQL.Add(' WHERE a.Cod_moneda = :Cod_Moneda');
      SQL.Add('   AND a.Cod_moneda          = b.Cod_Moneda');
      SQL.Add('   AND a.Fecha_desde_Ajuste IN (SELECT MAX(b.Fecha_desde_Ajuste)'
                                             +'  FROM QS_SYS_MON_REDON b'
                                             +' WHERE b.Cod_Moneda = a.Cod_Moneda'
                                             +'   AND a.Fecha_Desde_Ajuste <= :fecha )'
             );
      if trim(sCod_Moneda) <> '' then
         ParamByName('Cod_moneda').AsString := sCod_Moneda;
      ParamByName('fecha').AsDate    := dFecha;
      Prepare;
      Open;
      if FieldByName('Decimal_Ajuste').IsNull then
         Result := 0
      else
         Result := FieldByName('Decimal_Ajuste').AsInteger;

      Close;
      UnPrepare;
    end;
end;

function decimales_tasa(dFecha : TdateTime) : Integer;
begin
  With DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT max(c.Decimal_Ajuste) as Decimal_Ajuste'
             +'  from qs_fin_descriptor a '
             +'      ,qs_sys_monedas    b '
             +'      ,qs_sys_mon_redon  c '
             +' where b.cod_moneda = a.tasa_valor_par '
             +'   and b.tipo_moneda = ''T'' '
             +'   and c.cod_moneda = b.cod_moneda '
             +'   AND c.Fecha_Desde_Ajuste <= :fecha '
             +'   AND c.Fecha_desde_Ajuste IN (SELECT MAX(b.Fecha_desde_Ajuste) '
                                             +'  FROM QS_SYS_MON_REDON b '
                                             +' WHERE b.Cod_Moneda         = c.Cod_Moneda '
                                             +'   AND b.Fecha_Desde_Ajuste = c.Fecha_Desde_Ajuste) '
             +'UNION '
             +'select max(c.decimal_ajuste) as Decimal_Ajuste '
             +'  from qs_fin_descriptor a  '
             +'      ,qs_sys_monedas    b  '
             +'      ,qs_sys_mon_redon  c  '
             +' where b.cod_moneda = a.tasa_valor_pte '
             +'   and b.tipo_moneda = ''T'' '
             +'   and c.cod_moneda = b.cod_moneda '
             +'   AND c.Fecha_Desde_Ajuste <= :fecha '
             +'   AND c.Fecha_desde_Ajuste IN (SELECT MAX(b.Fecha_desde_Ajuste) '
                                             +'  FROM QS_SYS_MON_REDON b '
                                             +' WHERE b.Cod_Moneda         = c.Cod_Moneda '
                                             +'   AND b.Fecha_Desde_Ajuste = c.Fecha_Desde_Ajuste)'
             +'UNION '
             +'SELECT max(c.Decimal_Ajuste) as Decimal_Ajuste'
             +'  from qs_fin_instrum    a '
             +'      ,qs_sys_monedas    b '
             +'      ,qs_sys_mon_redon  c '
             +' where b.cod_moneda = a.tip_tas_valor_par '
             +'   and b.tipo_moneda = ''T'' '
             +'   and c.cod_moneda = b.cod_moneda '
             +'   AND c.Fecha_Desde_Ajuste <= :fecha '
             +'   AND c.Fecha_desde_Ajuste IN (SELECT MAX(b.Fecha_desde_Ajuste) '
                                             +'  FROM QS_SYS_MON_REDON b '
                                             +' WHERE b.Cod_Moneda         = c.Cod_Moneda '
                                             +'   AND b.Fecha_Desde_Ajuste = c.Fecha_Desde_Ajuste) '
             +'UNION '
             +'select max(c.decimal_ajuste) as Decimal_Ajuste '
             +'  from qs_fin_instrum    a  '
             +'      ,qs_sys_monedas    b  '
             +'      ,qs_sys_mon_redon  c  '
             +' where b.cod_moneda = a.tip_tas_valor_pte '
             +'   and b.tipo_moneda = ''T'' '
             +'   and c.cod_moneda = b.cod_moneda '
             +'   AND c.Fecha_Desde_Ajuste <= :fecha '
             +'   AND c.Fecha_desde_Ajuste IN (SELECT MAX(b.Fecha_desde_Ajuste) '
                                             +'  FROM QS_SYS_MON_REDON b '
                                             +' WHERE b.Cod_Moneda         = c.Cod_Moneda '
                                             +'   AND b.Fecha_Desde_Ajuste = c.Fecha_Desde_Ajuste)'
             );
      ParamByName('fecha').AsDate    := dFecha;
      Prepare;
      Open;
      if FieldByName('Decimal_Ajuste').IsNull then
         Result := 0
      else
         Result := FieldByName('Decimal_Ajuste').AsInteger;

      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
procedure Leer_MonRedon(sCod_Moneda : String;
                        dFecha      : TdateTime;
                        var sTipo_Ajuste    : String;
                        var iDecimal_Ajuste : Integer);
begin
  With DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Decimal_Ajuste');
      SQL.Add('      ,a.Tipo_Ajuste_Mon'
             +'  FROM QS_SYS_MON_REDON a'
             +' WHERE a.Cod_moneda = :Cod_Moneda'
             +'   AND a.Fecha_Desde_Ajuste <= :fecha'
             +'   AND a.Fecha_desde_Ajuste IN (SELECT MAX(b.Fecha_desde_Ajuste)'
                                             +'  FROM QS_SYS_MON_REDON b'
                                             +' WHERE b.Cod_Moneda = a.Cod_Moneda)'
             );
      ParamByName('Cod_moneda').AsString := sCod_Moneda;
      ParamByName('fecha').AsDate    := dFecha;
      Prepare;
      Open;
      if FieldByName('Decimal_Ajuste').IsNull then
         begin
           sTipo_Ajuste    := '';
           iDecimal_Ajuste := 0;
         end
      else
         begin
           sTipo_Ajuste    := FieldByName('Tipo_Ajuste_Mon').AsString;
           iDecimal_Ajuste := FieldByName('Decimal_Ajuste').AsInteger;
         end;
      Close;
      UnPrepare;
    end;
end;
//==============================================================================
function Pais_Emisor(sCodigo_Division : String): String;
var
  Buscar : Boolean;
begin
  Result := '';
  Buscar := True;
  if (sCodigo_Division = ' ') or
     (sCodigo_Division = '')  then
     exit;

  WITH DataModule_Comun do
    begin
      While Buscar do
        begin
          Division_Geografica_Padre(sCodigo_Division,
                                    Buscar);
        end;
      Result := sCodigo_Division;
    end;
end;


procedure Registra_Bitacora_Procesos(sEmpresa       : String;
                                     sCartera       : String;
                                     sCodigo_proceso: String;
                                     dFecha_Proceso : TDateTime;
                                     sDescripcion   : String;
                                     sUsuario       : String);
var
  aux_fecha :Tdatetime;
begin
  With DataModule_Comun.QRY_General do
     begin
        SQL.Clear;
        SQL.Add('DELETE FROM QS_CTR_BITACORA_PR'
               +' WHERE Fecha_Proceso  = :Fecha_Proceso'
               +'   AND Codigo_Proceso = :Codigo_proceso'
               +'   AND Cartera        = :Cartera'
               +'   AND Empresa        = :Empresa'
               );

        ParamByName('Empresa').AsString          := trim(sEmpresa);
        ParamByName('Cartera').AsString          := trim(sCartera);
        ParamByName('Codigo_Proceso').AsString   := trim(copy(sCodigo_Proceso,1,10));
        ParamByName('Fecha_Proceso').AsDate  := dFecha_Proceso;

        Prepare;
        ExecSQL;
        Close;
        UnPrepare;

        aux_fecha := fecha_hora_Servidor;

        SQL.Clear;
        SQL.Add('INSERT INTO QS_CTR_BITACORA_PR'
               +' (Empresa'
               +',Cartera'
               +',Codigo_Proceso'
               +',Fecha_Proceso'
               +',Fecha_registro'
               +',Descripcion'
               +',Usuario )'
               +' VALUES ('
               +' :Empresa'
               +',:Cartera'
               +',:Codigo_Proceso'
               +',:Fecha_Proceso'
               +',:Fecha_registro'
               +',:Descripcion'
               +',:Usuario)'
               );


        ParamByName('Empresa').AsString          := trim(sEmpresa);
        ParamByName('Cartera').AsString          := trim(sCartera);
        ParamByName('Codigo_Proceso').AsString   := trim(sCodigo_Proceso);
        ParamByName('Fecha_Proceso').AsDateTime  := dFecha_Proceso;
        ParamByName('Fecha_registro').AsDateTime := aux_fecha;
        ParamByName('Descripcion').AsString      := sDescripcion;
        ParamByName('Usuario').AsString          := sUsuario;

        Prepare;
        ExecSQL;
        Close;
        UnPrepare;
     end;
end;


//==============================================================================
function Decimales(sCod_Moneda     : String;
                   dFecha_Redondeo : TDatetime
                   ):Integer;
Var
  aux_pchar       : Array[0..250] of Char;
  fDecimal_Ajuste : Integer;
  sTipo_Ajuste    : String;
  flag_Encontro   : Boolean;
begin
  fDecimal_Ajuste := 0;
 // Result          := 0;

  Flag_Encontro := False;
  WITH DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Max(Fecha_Desde_Ajuste) as Max_Fecha'
             +'  FROM QS_SYS_MON_REDON'
             +' WHERE Cod_Moneda = :Cod_Moneda'
             +'   AND Fecha_Desde_Ajuste <= :Fecha_Desde_Ajuste'
             );
      ParamByName('Cod_Moneda').AsString           := trim(sCod_Moneda);
      ParamByName('Fecha_Desde_Ajuste').AsDate := dFecha_Redondeo;
      Prepare;
      Open;
      if NOT (FieldByName('Max_Fecha').IsNull) then
      begin
        Flag_Encontro := True;
        dFecha_Redondeo := FieldByName('Max_Fecha').AsDatetime;
      end;

      Close;
      UnPrepare;

      if Flag_encontro then
         begin
            SQL.Clear;
            SQL.Add('SELECT Decimal_Ajuste'
                   +'      ,Tipo_Ajuste_Mon'
                   +'  FROM QS_SYS_MON_REDON'
                   +' WHERE Cod_Moneda = :Cod_Moneda'
                   +'   AND Fecha_Desde_Ajuste = :Fecha_Desde_Ajuste'
                   );
            ParamByName('Cod_Moneda').AsString           := trim(sCod_Moneda);
            ParamByName('Fecha_Desde_Ajuste').AsDate := dFecha_Redondeo;
            Prepare;
            Open;
            if NOT ((FieldByName('Decimal_Ajuste').IsNull) or
                    (FieldByName('Tipo_Ajuste_Mon').IsNull)) then
               begin
                  fDecimal_Ajuste := FieldByName('Decimal_Ajuste').AsInteger;
                  sTipo_Ajuste    := FieldByName('Tipo_Ajuste_Mon').AsString;
                  Flag_Encontro   := True;
               end;
            Close;
            UnPrepare;
         end;
    end;  // With

    if NOT Flag_Encontro then
    begin
      strpcopy(aux_pchar
             ,'No existe definición de redondeo para: '
             +sCod_Moneda+''#10
             +'Se asume redondeo sin decimales ');
// Comentado por Edosan ..., por mensaje de error al imprimir papelete de Venta
{      Application.MessageBox(aux_pchar
                           ,'Redondeo de Moneda / Indice'
                           ,mb_Ok);  }
      fDecimal_Ajuste := 0;
      sTipo_Ajuste    := 'R';
    end;
    Result := fDecimal_Ajuste;
end;

function FechaNemotecnico(sNemotecnico:String; Fecha:TDateTime; FechaOperacion:Tdatetime) :TDateTime;
var
 wMes, wYear, wDia, wwMes, wwYear, wwDia :word;
begin
   DecodeDate( Fecha, wYear, wMes, wDia);
   DecodeDate( FechaOperacion, wwYear, wwMes, wwDia);
   if Copy( sNemotecnico, 8, 1 ) = '&' then
      Result := EncodeDate(wwYear, StrToInt(Copy( sNemotecnico, 9, 2 )), wDia )
   else
      Result := Fecha;//EnCodeDate(wwYear, wMes, wDia);
end;
{
function VericaFechaNemotecnico(FechaEmision:TDateTime; FechaOperacion:Tdatetime):Boolean;
var dFecha : TDateTime;
    wDay, wMonth, wYear : Word;
begin
   Result := True;
   DecodeDate(FechaOperacion, wYear, wMonth, wDay);
   if (wMonth - 2) < 1 then
      Dec(wYear);

   case wMonth of
      -0:
        wMonth := 12;
      -1:
        wMonth := 11;
      else
        wMonth := wMonth - 2;
   end;

   dFecha := EncodeDate(wYear, wMonth, 01);
   if not ( ( FechaEmision >= dFecha ) and
            ( FechaEmision <= FechaOperacion ) ) then
      Result := False;
end;
}
//------------------------------------------------------------------------------
procedure Pais_MonInd(sCodigo_MondInd  : String;
                      var sCodigo_Pais : String;
                      var sModulo_Err  : String;
                      var sString_Err  : String;
                      var Result       : Boolean);
begin
  WITH DataModule_Comun.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Nacion_Moneda'
             +'  FROM QS_SYS_MONEDAS'
             +' WHERE Cod_Moneda = :Cod_Moneda'
             );
      ParamByName('Cod_Moneda').AsString           := trim(sCodigo_MondInd);

      Prepare;
      Open;

      if FieldByName('Nacion_Moneda').IsNull then
         begin
           sModulo_Err := 'Busca país Moneda / Tasa / Indice';
           sString_Err := 'Error en definición de país para: '
                          +trim(sCodigo_MondInd)
                          +'.';
           Close;
           UnPrepare;
           Result := False;
           exit;
         end;

      sCodigo_Pais := FieldByName('Nacion_Moneda').AsString;
      Close;
      UnPrepare;
      Result := True;
    end;
end;
//------------------------------------------------------------------------------
procedure aplica_operacion(fValor1           : Double;
                           fValor2           : Double;
                           sOperador         : String;
                           Base_Porcentual   : Double;
                           Redondeo_Truncado : String;
                           Numero_Decimales  : Double;
                           var fResultado    : Double;
                           var sModulo_Err   : String;
                           var sString_Err   : String;
                           var Result        : Boolean);
begin
   if (sOperador = '+') then
       begin
         fResultado := fValor1 + fValor2;
         Result := True;
         exit;
       end;

   if (sOperador = '-') then
       begin
         fResultado := fValor1 - fValor2;
         Result := True;
         exit;
       end;

   if (sOperador = '*') then
       begin
         fResultado := fValor1 * fValor2;
         Result := True;
         exit;
       end;

   if (sOperador = '/') then
       begin
         if (fValor2 = 0) then
            begin
              sModulo_Err := 'Aplica Operación';
              sString_Err := 'Error en definición. Se produce división por cero.';
              Result := False;
              exit;
            end;
         fResultado := fValor1 / fValor2;
         Result := True;
         exit;
       end;

   if (sOperador = '%') then
       begin
//         fResultado := (fValor1 * fValor2) / 100;
//   E.S. reemplacé la linea de arriba por las 3 de abajo,  23-04-2013, la formula debe ser diferente para cuando la tasa es negativa
         fResultado := (abs(fValor1) * fValor2) / 100;
         fResultado := fResultado - abs(fValor1);
         fResultado := fResultado + fValor1;
         Result := True;
         exit;
       end;

   if (sOperador = '>') then
   begin
      if fValor1 > fValor2  then
         fResultado := fValor1
      else
         fResultado := fValor2;

      Result := True;
      exit;                
   end;

   if (sOperador = '<') then
   begin
      if fValor1 < fValor2  then
         fResultado := fValor1                  
      else
         fResultado := fValor2;

      Result := True;
      exit;
   end; 
   

   // Factorizacion de Valor1 por Factorización de Valor 2
   if (sOperador = 'F*F') then
      begin
        if (Base_Porcentual = 0) then
            begin
              sModulo_Err := 'Aplica Operación';
              sString_Err := 'Error en base porcentual de factorización. Se produce división por cero.';
              Result := False;
              exit;
            end;

        fValor1 := 1 + (fValor1 / Base_Porcentual);
        fValor2 := 1 + (fValor2 / Base_Porcentual);
        fResultado := ((fValor1 * fValor2)- 1) * Base_Porcentual;
        fResultado := ajusta_decimales(Redondeo_Truncado
                                      ,fResultado
                                      ,Trunc(Numero_Decimales));
       end;
 end;      // aplica_operacion

//------------------------------------------------------------------------------
procedure ShowError(AExc: EFDDBEngineException);
const
  EOL = #13;
var
  i: Integer;
  sError: string;
begin
  sError := '';
  sError := sError + 'Número de errores: ' + IntToStr(AExc.ErrorCount);
  sError := sError + EOL;
  for i := 0 to AExc.ErrorCount - 1 do begin
     sError := sError + 'Mensaje.........: ' + AExc.Errors[i].Message + EOL;
    // sError := sError + 'Categoría.......: ' + IntToStr(AExc.Errors[i].Category) + EOL;
    // sError := sError + 'Código de Error.: ' + IntToStr(AExc.Errors[i].ErrorCode) + EOL;
    // sError := sError + 'SubCódigo.......: ' + IntToStr(AExc.Errors[i].SubCode) + EOL;
    // sError := sError + 'Error Nativo....: ' + IntToStr(AExc.Errors[i].NativeError) + EOL;
  end;
  MessageBeep(MB_ICONEXCLAMATION);
  Application.MessageBox(PChar(sError), 'Error SQL', mb_OK+MB_APPLMODAL	);
end;
//------------------------------------------------------------------------------
procedure ShowError_SQL(AExc: EFDDBEngineException;
                        sSqlStrings : TStrings;
                        sMensaje    : String);
const
  EOL = #13;
var
  i: Integer;
  sError: string;
begin
  sError := '';
  sError := sError + 'Número de errores: ' + IntToStr(AExc.ErrorCount);
  sError := sError + EOL;
  for i := 0 to AExc.ErrorCount - 1 do begin
     sError := sError + 'Mensaje.........: ' + AExc.Errors[i].Message + EOL;
   //  sError := sError + 'Categoría.......: ' + IntToStr(AExc.Errors[i].Category) + EOL;
   //  sError := sError + 'Código de Error.: ' + IntToStr(AExc.Errors[i].ErrorCode) + EOL;
   //  sError := sError + 'SubCódigo.......: ' + IntToStr(AExc.Errors[i].SubCode) + EOL;
    // sError := sError + 'Error Nativo....: ' + IntToStr(AExc.Errors[i].NativeError) + EOL+EOL;
  end;

  sError := sError + 'El error se produjo en la instrucción'+EOL+EOL;

  for i :=0  to sSqlStrings.count -1 do
      sError := sError + sSqlStrings[i] + EOL;

  sError := sError + sMensaje + EOL;

  MessageBeep(MB_ICONEXCLAMATION);
  Application.MessageBox(PChar(sError), 'Error en Base de Datos', mb_OK+MB_APPLMODAL	);
end;
//------------------------------------------------------------------------------
function Escribe_Txt( sFileName, sTxtLine: string; bDeleteFile: boolean ): boolean;
var
   F: TextFile;
begin
   AssignFile(F, sFileName);

   if bDeleteFile then
      DeleteFile(sFileName);

   {$I-}
   if FileExists(sFileName) then
      Append(F)
   else
      Rewrite(F);
   {$I+}

   if (IOResult = 0) then
      Result := True
   else
   begin
      Result := False;
      Exit;
   end;

   WriteLn(F, sTxtLine);
   CloseFile(F);
end;

//------------------------------------------------------------------------------
function Str_Is_Num( sNumero: string ): boolean;
var
   iChar, iLargo: integer;
begin
   // Verifica que todos sean Números.
   Result := False;
   iLargo := Length(sNumero);
   if iLargo <= 0 then
      Exit;
   iChar  := 1;
   while iChar <= iLargo do
   begin
      if not ( sNumero[iChar] in ['0'..'9'] ) then
         Exit;
      Inc(iChar);
   end;
   Result := True;
end;

function MensajeBox( sTitulo, sMensaje: string ): boolean;
begin
        MyMessageDialog(sMensaje,
                        sTitulo,mtInformation,[mbOK]) ;
//   Application.MessageBox( PChar(sMensaje),
//                           PChar(sTitulo),
//                           MB_ICONINFORMATION+MB_OK);
   Result := True;
end;

function MensajeErr( sTitulo, sMensaje: string ): boolean;
begin
        MyMessageDialog(sMensaje,
                        sTitulo,mtError,[mbOK]) ;
//        Application.MessageBox( PChar(sMensaje),
//                           PChar(sTitulo),
//                           MB_ICONERROR+MB_OK);
   Result := True;
end;

function DialogoBox( sTitulo, sMensaje: string ): boolean;
begin
//   Result := Application.MessageBox( PChar(sMensaje),
//                                     PChar(sTitulo),
//                                     MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2) = IDYES;
   Result := MyMessageDialog(sMensaje,
                             sTitulo,mtConfirmation,mbYesNo,mbNo) = mrYes;
//                                     MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2) = IDYES;
end;

procedure Add_Log_Message( sFolio,
                           sTransaccion: string;
                           fItem_Omd: Double;
                           sMensaje,
                           sModulo: string );
//var
//   Tabla_Log : TFDMemTable;
  begin
//   try
//      Tabla_Log := TFDMemTable.Create(Application);
      with DataModule_Comun.Tabla_Log do
      begin
//         Close;
//         DataModule_Comun.FDLocalSQL1.DataSets[0].Name := sLOG_FILE;
         //TableType    := ttParadox;
         try
//            Open;
            Append;
            FieldByName('Fecha'      ).AsDateTime := Now;
            FieldByName('Folio'      ).AsString   := sFolio;
            FieldByName('Transaccion').AsString   := sTransaccion;
            FieldByName('Item_Omd'   ).AsFloat    := fItem_Omd;
            if bCierres_Diarios then
               sModulo := FormatDateTime('dd/mm/yyyy',dFechaCierre)+' '+sModulo;
            FieldByName('Mensaje'    ).AsString   := StrTran(sMensaje,#10,',');
            FieldByName('Modulo'     ).AsString   := sModulo;
            Post;
//            Close;
         except
            ShowMessage('No se puede abrir Tabla '+sLog_File );
         end;
//   finally
//      Tabla_Log.Close;
//      Tabla_Log.Free;
      end;
  end;

//------------------------------------------------------------------------------
function Escribe_Pdox( sFileName, sTxtLine: string; bDeleteFile: boolean ): boolean;
begin
   Result := True;
   {
   try
      Tbl := TFDMemTable.Create(Application);
      with Tbl do
      begin
         DataModule_Comun.FDLocalSQL1.DataSets[1].Name := sFileName;
         //DataBaseName := 'Alias_Paradox';
         //TableName    := sFileName;
         //Exclusive    := True;
         //if not FileExists(Directorio_Temp + sFileName) then
//         if not FileExists(Directorio_Bde + sFileName) then
//         begin
            with FieldDefs do
            begin
               Clear;
               Add('Linea', ftString  , 100, False);
            end;
            CreateDataSet;
//         end;
         Open;
         if bDeleteFile then
            EmptyDataSet;
         Append;
         FieldByName('Linea').AsString := sTxtLine;
         Post;
         Close;
         Free;
      end;
   except
      MensajeBox( 'Error de Apertura', 'No se puede abrir archivo de Errores: '+sFileName );
   end;
   }
end;

//------------------------------------------------------------------------------
function Escribe_Fisica( sFileName, sTxtLine: string; bDeleteFile: boolean): boolean;
begin

   if NOT dmBaseDatos.conexion_basedatos.InTransaction then
       dmBaseDatos.conexion_basedatos.StartTransaction;

   try
     WITH DataModule_Comun.QRY_General do
     begin
       if bDeleteFile then
       begin
         Close;
         Sql.Clear;
         Sql.Add('DELETE FROM QS_TMP_ERRORCONTAB '
                +' WHERE Pid   = :Pid '
                +'   AND Nombre = :Nombre');

         ParamByName('pid').AsFloat      := Application.Handle;
         Parambyname('Nombre').AsString  := sFileName;

         ExecSQL;
       end;

       Close;
       Sql.Clear;
       Sql.Add('INSERT INTO QS_TMP_ERRORCONTAB '
              +' VALUES (:Pid '
              +'        ,:Nombre '
              +'        ,:texto )');

       ParamByName('pid').AsFloat      := Application.Handle;
       Parambyname('Nombre').AsString  := sFileName;
       Parambyname('texto').AsString   := sTxtLine;

       ExecSQL;
       if dmBaseDatos.conexion_basedatos.InTransaction then
          dmBaseDatos.conexion_basedatos.Commit;
     end;
   except
      MensajeBox( 'Error ', 'No se pudo agregar registro de errores: '+sFileName );

      if dmBaseDatos.conexion_basedatos.InTransaction then
         dmBaseDatos.conexion_basedatos.Rollback;
   end;
end;

function Busca_Motivo( sEmpresa,
                       sCartera,
                       sTransaccion,
                       sFolio          : string;
                       fItem_Omd       : Double;
                       dFecha: TDateTime): string;
begin
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT a.Cod_Motivo ');
      SQL.Add('  FROM QS_TRA_OMD_MOTIVO a ');
      SQL.Add(' WHERE a.Folio_Interno = :Folio_Interno');
      SQL.Add('   AND a.Transaccion   = :Transaccion'  );
      SQL.Add('   AND a.Empresa       = :Empresa'      );
      SQL.Add('   AND a.Fecha_Desde  = (SELECT MAX(b.fecha_desde) ');
      SQL.Add('                           FROM QS_TRA_OMD_MOTIVO b ');
      SQL.Add('                          WHERE b.Folio_Interno = a.Folio_Interno ');
      SQL.Add('                            AND b.Item_omd      = a.Item_omd ');
      SQL.Add('                            AND b.Transaccion   = a.Transaccion ');
      SQL.Add('                            AND b.Cartera       = a.Cartera  ');
      SQL.Add('                            AND b.Empresa       = a.Empresa ');
      SQL.Add('                            AND b.Fecha_Desde <= :Fecha ');
      SQL.Add('                            AND (b.Fecha_Hasta IS NULL OR b.Fecha_Hasta >= :Fecha)) ');
      if sCartera <> '' then
      begin
         SQL.Add('   AND a.Cartera = :Cartera'  );
         ParamByName('Cartera').AsString   := sCartera;
      end;
      if fItem_Omd <> 0 then
      begin
         SQL.Add('   AND a.Item_Omd = :Item_Omd'  );
         ParamByName('Item_Omd').asFloat   := fItem_Omd;
      end;

      ParamByName('Empresa'      ).AsString   := sEmpresa;
      ParamByName('Transaccion'  ).AsString   := sTransaccion;
      ParamByName('Folio_Interno').AsString   := sFolio;
      ParamByName('Fecha'        ).AsDate     := dFecha;
      Open;

      if not FieldByName('Cod_Motivo').IsNull then
         Result := FieldByName('Cod_Motivo').AsString
      else
         Result := '';

      Close;
   end;
end;
//==============================================================================
function dias360(fInicial,fFinal:tdateTime;metodo:boolean):integer;
var
  an1,an2,m1,m2,d1,d2,resultado : word;
begin

  if fInicial>=fFinal then begin
    Result:=0;
    exit;
  end;

  DecodeDate(fInicial,an1,m1,d1);
  DecodeDate(fFinal  ,an2,m2,d2);

  {
  El metodo europeo indica que si el dia es 31, entonces se cambia a 30
  }

  if metodo then begin
    if d1=31 then d1:=30;
    if d2=31 then d2:=30;
  end else begin
  {
  El metodo americano indica que si el dia de la fecha inicial es 31
  se cambia a 30.
  Si el dia de la fecha final es 31, entonces hay que ver si
  el dia de la fecha inicial es menor de 30,
  entonces la fecha final sera el primer dia del mes siguiente,
  de lo contrario sera 30
  }
    // Se cambia la comparacion del día 31 a la comparacion con el ultimo día del mes
    // No se estaba llegando a excell para la diferencia del ultimo día de febrero el el ultimo de marzo
    // Excel esta difertente a calculadora HP (filigara 05/04/2005)       
    //if d1=31 then d1:=30;
    if d1=ultimo_dia_mes(m1,an1) then d1:=30;
    if (d2=31) then
      if (d1<30) then begin
        d2:=1;
        inc(m2);
        if m2=13 then begin
          m2:=1;
          inc(an2);
        end;
      end else
         d2:=30;
  end;
  if m2>=m1 then
    resultado:=(an2-an1)*360+(m2-m1-1)*30+(30-d1)+d2
  else
    resultado:=(an2-an1-1)*360+(12-m1+m2-1)*30+(30-d1)+d2;

  Result:=resultado;

end;
//==============================================================================
function Determina_Cartera_Vida( sEmpresa,
                                 sCartera : String
                               ) : Boolean;
begin
   With DataModule_Comun.Qry_general do
   begin
      Sql.Clear;
      Sql.Add( 'SELECT c.DESCRIPCION_NODO FROM  qs_sys_clasifica a'
              +'   ,qs_sys_clasif_obj b'
              +'   ,qs_sys_est_cla c'
              +'  WHERE a.Codigo_Objeto = b.Codigo_Clasif'
              +'  AND   b.objeto        = ''CARTERA'''
              +'  AND   b.elemento      = :Cartera'
              +'  AND   b.Codigo_Clasif = ''GRUPO'''
              +'  AND   c.Descripcion_Nodo = ''VIDA'''
              +'  AND   b.Nodo          = c.Nodo'
              +'  AND   b.CODIGO_CLASIF = c.CODIGO_OBJETO'
              );
      Parambyname('Cartera').asString := sCartera;
      Open;

      Determina_Cartera_Vida := False;
      if Not Fieldbyname('Descripcion_nodo').IsNull then
          Determina_Cartera_Vida := True;

      Close;
   end;
end;
//==============================================================================

Function ValidaCaracteresNombreArchivo(Variable: String):String;
Var
i : Integer;
Begin
     For i := 1 to Length(Variable) Do
         case Variable[i] of
              '/'     :  Variable[i] :=  '-';
              '\'     :  Variable[i] :=  '-';
              ':'     :  Variable[i] :=  ' ';
         end;
     ValidaCaracteresNombreArchivo := Variable;
End;

Function ValidaCaracteresArchivo(Variable: String):String;
Var
i : Integer;
Begin
     For i := 1 to Length(Variable) Do
         case Variable[i] of
              '/'     :  Variable[i] :=  '-';
              '\'     :  Variable[i] :=  '-';
              ':'     :  Variable[i] :=  '-';
              '*'     :  Variable[i] :=  '-';
              '"'     :  Variable[i] :=  '-';
              '<'     :  Variable[i] :=  '-';
              '>'     :  Variable[i] :=  '-';
              '['     :  Variable[i] :=  '-';
              ']'     :  Variable[i] :=  '-';
              '{'     :  Variable[i] :=  '-';
              '}'     :  Variable[i] :=  '-';
              '|'     :  Variable[i] :=  '-';
              ' '     :  Variable[i] :=  '_';
         end;
     ValidaCaracteresArchivo := Variable;
End;

//==============================================================================

Function ValidaCaracteresCirculares(Variable: String):String;
Var
i : Integer;
Begin

//     For i := 1 to Length(Variable) Do
//     begin
//        if Pos(Variable[i], sStr_caracteres_premitidos_1835) = 0 then // valida que los caracteres de variable esten contenido en sSctr_1835
//           Variable[i] := ' ';
//     end;
//     ValidaCaracteresCirculares := Variable;

     For i := 1 to Length(Variable) Do
         case Variable[i] of
//              'Ñ','ñ' :  Variable[i] :=  '#';  Modif. Circular 1835 año 2024
              'á'     :  Variable[i] :=  'a';
              'é'     :  Variable[i] :=  'e';
              'í'     :  Variable[i] :=  'i';
              'ó'     :  Variable[i] :=  'o';
              'ú'     :  Variable[i] :=  'u';
              'Á'     :  Variable[i] :=  'A';
              'É'     :  Variable[i] :=  'E';
              'Í'     :  Variable[i] :=  'I';
              'Ó'     :  Variable[i] :=  'O';
              'Ú'     :  Variable[i] :=  'U';
              'Ñ'     :  Variable[i] :=  'N';
              'ñ'     :  Variable[i] :=  'n';
//              '¿'     :  Variable[i] :=  ' ';
//              '°'     :  Variable[i] :=  ' ';
//              ''''    :  Variable[i] :=  ' ';
//              '?'     :  Variable[i] :=  ' ';
//              'ª'     :  Variable[i] :=  ' ';
//              'º'     :  Variable[i] :=  ' ';
              else if Pos(Variable[i], sStr_caracteres_premitidos_1835) = 0 then // valida que los caracteres de variable esten
                   Variable[i] := ' ';                                           // contenido en sStr_caracteres_premitidos_1835
         end;
     ValidaCaracteresCirculares := Variable;

End;

Function Elimina_Acentos_y_ñ(Variable: String):String;
Var
i : Integer;
Begin
   For i := 1 to Length(Variable) Do
     case Variable[i] of
          'Ñ','ñ' : Variable[i] := 'n';
          'á'     : Variable[i] := 'a';
          'é'     : Variable[i] := 'e';
          'í'     : Variable[i] := 'i';
          'ó'     : Variable[i] := 'o';
          'ú'     : Variable[i] := 'u';
          'Á'     : Variable[i] := 'A';
          'É'     : Variable[i] := 'E';
          'Í'     : Variable[i] := 'I';
          'Ó'     : Variable[i] := 'O';
          'Ú'     : Variable[i] := 'U';
     end;
   Elimina_Acentos_y_ñ := Variable;
End;

function diasHabiles( dFecha_Inicial, dFecha_Final :tdateTime;
                      sCodigo_Division : String ):integer;
var
  iTotal_Dias : Integer;
  dFecha_Aux  : Tdatetime;
begin
  if dFecha_Inicial > dFecha_Final then
  begin
    Result:=0;
    exit;
  end;

  //Calculo Días Totales entre ambas fechas
  Result := Trunc(dFecha_Final - dFecha_Inicial);

  //Calculo Dias sabados y Domingo
  iTotal_Dias := 0;
  dFecha_Aux  := dFecha_Final;
  While dFecha_Aux <> (dFecha_Inicial -1) do
  begin
     if (DayOfWeek(dFecha_Aux) in [1,7]) then
        Inc(iTotal_Dias);

     dFecha_Aux := dFecha_Aux - 1;
  end;
  Result := Result - iTotal_Dias;

  //Calculo Feriados entre ambas fechas
  //   Carga_Dias_Feriados_Mem;  30-11-2015 No es necesario cargarlo ya que lo hace la funcion  Feriado_Mem cuando lo necesita
  iTotal_Dias := 0;
  dFecha_Aux  := dFecha_Final;
  While dFecha_Aux <> (dFecha_Inicial -1) do
  begin
     if Not (DayOfWeek(dFecha_Aux) in [1,7]) then
        if Feriado_Mem(sCodigo_Division ,dFecha_Aux) then
           Inc(iTotal_Dias);

     dFecha_Aux := dFecha_Aux - 1;
  end;
  Result := Result - iTotal_Dias;

end;

procedure Separa_Campos_String(cSeparador: Char;
                               cElimina  : Char;
                               S         : String;
                               var String_Arr : TArr100_String);

var
  i               : Integer;
  iDesde          : Integer;

  iNroCampo       : Integer;

begin
  iDesde    := 1;
  iNroCampo := 1;

  for i := 1 to 200 do
    String_Arr[i] := '';

  //ggarcia 18-08-2016
  if S = '' then
     exit;

  For i := 1 to length(S) do
  begin
//       if (S[i] = ''+#9) OR
//          (S[i] = ''+#0) then

     if (S[i] = ''+#9) OR
        (S[i] = ''+#0) OR
        (S[i] = cSeparador) OR
        (i    = length(S)) then
     begin
        While iDesde <= i do
        begin
           if S[i] <> cElimina then
              String_Arr[iNroCampo] := String_Arr[iNroCampo] + S[iDesde];
           Inc(iDesde);
        end;
        iDesde := i + 1;
        String_Arr[iNroCampo] := StrRemove(String_Arr[iNroCampo],cElimina);
        Inc(iNroCampo);
     end;
  end;
end;

function StrRemove(cString, cRemove: string): string;
var
   i: integer;
begin
   Result := '';
   for i := 1 to Length(cString) do
      if cString[i] <> cRemove then
        Result := Result + cString[i];
end;

function BuscaStr(cString, sBusca: string): Boolean;
var
   i,j : integer;
begin
   Result := False;
   j := Length(sBusca);
   for i := 1 to Length(cString) do
      if copy(cString,i,j) = sBusca then
      begin
        Result := True;
        exit;
      end
      else
        Result := False;
end;

function BuscaStrArray(sBusca : string; String_Arr : TArr100_String): Boolean;
var
   i : integer;
begin
   Result := False;
   for i := 1 to 100 do
   begin
      if trim(String_Arr[i]) = '' then
         exit;
      if String_Arr[i] = sBusca then
      begin
        Result := True;
        exit;
      end
      else
        Result := False;
   end;
end;

//===========================================================================
function StrTran(cString, cSearch, cReplace: string): string;
var
   i: integer;
begin
   Result := '';
   for i := 1 to Length(cString) do
      if cString[i] = cSearch then
        Result := Result + cReplace[1]
      else
        Result := Result + cString[i];
end;
//===========================================================================
function Existe_Codigo_Folio_Cartera(sEmpresa,
                                     sCod_Transaccion : String) : Boolean;
begin
  with DataModule_Comun.QRY_General do
  begin
     SQL.Clear;
     SQL.Add('SELECT * FROM QS_SYS_FOLIOS'
            +' WHERE Codigo_Identidad   = :Empresa'
            +'   AND Codigo_Transaccion = :Codigo'
            );
     ParamByName('Empresa').AsString := sEmpresa;
     ParamByName('Codigo').AsString  := sCod_Transaccion;
     Prepare;
     Open;
     if not (FieldByName('Codigo_Identidad').IsNull) then
        Result := True
     else
        Result := False;

     Close;
     UnPrepare;
  end;
end;
//===========================================================================
function Existe_Perfil_Cartera(sCodigo_Perfil : String) : Boolean;
begin
  with DataModule_Comun.QRY_General do
  begin
     SQL.Clear;
     SQL.Add('SELECT * FROM QS_SYS_PERFIL_CARTERAS'
            +' WHERE Cod_Perfil   = :Cod_Perfil'
            );
     ParamByName('Cod_Perfil').AsString := sCodigo_Perfil;
     Prepare;
     Open;
     if not (FieldByName('Cod_Perfil').IsNull) then
        Result := True
     else
        Result := False;

     Close;
     UnPrepare;
  end;
end;
//===========================================================================
function Valida_Perfil_Cartera(sCodigo_Perfil, sCartera : String) : Boolean;
begin
  with DataModule_Comun.QRY_General do
  begin
     SQL.Clear;
     SQL.Add('SELECT * FROM QS_SYS_PERFIL_CARTERAS'
            +' WHERE Cod_Perfil = :Cod_Perfil'
            +'   AND Cartera    = :Cartera'
            );
     ParamByName('Cod_Perfil').AsString := sCodigo_Perfil;
     ParamByName('Cartera').AsString    := sCartera;
     Prepare;
     Open;
     if not (FieldByName('Cod_Perfil').IsNull) then
        Result := True
     else
        Result := False;

     Close;
     UnPrepare;
  end;
end;
//===========================================================================
{16-02-2012: Cambiamos la variable X de Extended a Double }
{Esto permitio que la funcion Frac utilizada en esta funcion entregara el valor correcto
     Antes Frac(1) = 0   Ahora Frac(1) = 1
Caso 3.425 en carga tasas de mercado (Quedaba commo 3.42)
E.S. & F.I.
}
function RoundD(x: Double; d: Integer): Extended;
var
  n: Extended;
begin
  n := Power(10, d);
  x := x * n;
  Result := (Int(x) + Int(Frac(x) * 2)) / n;
end;

function RoundN(X: Extended): Extended;
begin
   Result := Int(X) + Int(Frac(X) * 2);
end;


{ //ggarcia 03-06-2015 Ahora se marcan todas las empresas seleccionadas - para el caso de los perfiles holding que puden selecionar carteras de distintas empresas (informado por eurocorr)
procedure Marca_Proceso_Valorizacion(sMarca : String);
begin
  with DataModule_Comun.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('Delete from qs_sys_tran_implic        '
           +' where Codigo_Transaccion = :empresa  '
           +'   and Implicancia        = :estado   '
            );
    ParamByName('Empresa').AsString := sEmpresa_Usuario;
    ParamByName('estado').AsString  := 'VALORIZANDO';
    try
      ExecSql;
    except
    end;
    Close;

    if sMarca = 'VALORIZANDO' then
    begin
      SQL.Clear;
      SQL.Add('Insert into qs_sys_tran_implic '
             +' ( Codigo_Transaccion, Implicancia )  '
             +' values ( :empresa, :estado )  '
              );
      ParamByName('Empresa').AsString := sEmpresa_Usuario;
      ParamByName('estado').AsString  := sMarca;
      try
        ExecSql;
      except
      end;
      Close;
    end;
  end;
end;
}
procedure Marca_Proceso_Valorizacion(sMarca : String);
begin

  with DataModule_Comun.QRY_General2 do
  begin
     Close;
     Sql.Clear;
     SQL.Add('  SELECT Distinct valor As Empresa ');
     SQL.Add('         FROM QS_SYS_PARAM_PROCESO ');
     SQL.Add('  WHERE proceso  = :proceso       ');
     SQL.Add('  AND parametro  = ''EMPRESA'' ');
     Parambyname('Proceso').asString := IntToStr(Application.Handle);
     Open;

     if Not Fieldbyname('Empresa').IsNull then
     begin

        While Not Eof do
        begin
           DataModule_Comun.QRY_General.SQL.Clear;
           DataModule_Comun.QRY_General.SQL.Add('Delete from qs_sys_tran_implic        '
                                               +' where Codigo_Transaccion = :empresa  '
                                               +'   and Implicancia        = :estado   '
                                                );
           DataModule_Comun.QRY_General.ParamByName('Empresa').AsString := Fieldbyname('Empresa').asString;;
           DataModule_Comun.QRY_General.ParamByName('estado').AsString  := 'VALORIZANDO';
           try
             DataModule_Comun.QRY_General.ExecSql;
           except
           end;
           DataModule_Comun.QRY_General.Close;
           if sMarca = 'VALORIZANDO' then
           begin
             DataModule_Comun.QRY_General.SQL.Clear;
             DataModule_Comun.QRY_General.SQL.Add('Insert into qs_sys_tran_implic '
                                                 +' ( Codigo_Transaccion, Implicancia )  '
                                                 +' values ( :empresa, :estado )  '
                                                  );
             DataModule_Comun.QRY_General.Close;
             DataModule_Comun.QRY_General.ParamByName('Empresa').AsString := Fieldbyname('Empresa').asString;
             DataModule_Comun.QRY_General.ParamByName('estado').AsString  := sMarca;
             try
               DataModule_Comun.QRY_General.ExecSql;
             except
             end;
           end;
           Next;
        end;

     end
     else
     begin

        DataModule_Comun.QRY_General.SQL.Clear;
        DataModule_Comun.QRY_General.SQL.Add('Delete from qs_sys_tran_implic        '
                                            +' where Codigo_Transaccion = :empresa  '
                                            +'   and Implicancia        = :estado   '
                                             );
        DataModule_Comun.QRY_General.ParamByName('Empresa').AsString := sEmpresa_Usuario;
        DataModule_Comun.QRY_General.ParamByName('estado').AsString  := 'VALORIZANDO';
        try
          DataModule_Comun.QRY_General.ExecSql;
        except
        end;
        DataModule_Comun.QRY_General.Close;
        if sMarca = 'VALORIZANDO' then
        begin
          DataModule_Comun.QRY_General.SQL.Clear;
          DataModule_Comun.QRY_General.SQL.Add('Insert into qs_sys_tran_implic '
                                              +' ( Codigo_Transaccion, Implicancia )  '
                                              +' values ( :empresa, :estado )  '
                                               );
          DataModule_Comun.QRY_General.ParamByName('Empresa').AsString := sEmpresa_Usuario;
          DataModule_Comun.QRY_General.ParamByName('estado').AsString  := sMarca;
          try
            DataModule_Comun.QRY_General.ExecSql;
          except
          end;
          DataModule_Comun.QRY_General.Close;
        end;

     end;
  end;

end;
procedure Marca_Proceso_Proy_Vctos_Mesa(sMarca : String; sLogin : String);
begin
  if NOT (dmBaseDatos.Conexion_BaseDatos.inTransaction) then
     dmBaseDatos.Conexion_BaseDatos.StartTransaction;

  with DataModule_Comun.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('Delete from QS_SYS_PARAM_PROCESO '
           +' where Proceso   = :Proceso     '
           +'   and Parametro = :Parametro   '
           +'   and Valor     = :Valor       '
            );
    ParamByName('Proceso').AsString    := sEmpresa_Usuario;
    ParamByName('Parametro').AsString  := 'PROYVCTOS';
    ParamByName('Valor').AsString      := sLogin;
    try
      ExecSql;
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
         Close;
         Exit;
      end;
    end;

    if (sMarca = 'PROYVCTOS') then
    begin
      Close;
      SQL.Clear;
      SQL.Add('Insert into QS_SYS_PARAM_PROCESO '
             +' ( PROCESO, PARAMETRO, VALOR )  '
             +' values ( :Proceso, :Parametro, :Valor )  '
              );
      ParamByName('Proceso').AsString   := sEmpresa_Usuario;
      ParamByName('Parametro').AsString := 'PROYVCTOS';
      ParamByName('Valor').AsString     := sLogin;
      try
        ExecSql;
      except
      end;
      Close;
    end;
    Close;
  end;

  if dmBaseDatos.Conexion_BaseDatos.inTransaction then
     dmBaseDatos.Conexion_BaseDatos.Commit;
end;

procedure Limpia_Marca_Proceso_Proy_Vctos_Mesa;
begin
  with DataModule_Comun.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('Delete from QS_SYS_PARAM_PROCESO '
           +' where Proceso   = :Proceso     '
           +'   and Parametro = :Parametro   '
           +'   and Valor     = :Valor       '
            );
    ParamByName('Proceso').AsString    := sEmpresa_Usuario;
    ParamByName('Parametro').AsString  := 'PROYVCTOS';
    ParamByName('Valor').AsString      := sLogin_Sistema;
    try
      ExecSql;
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

procedure Marca_Proceso_General(sMarca : String);
begin
  with DataModule_Comun.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('Delete from qs_sys_tran_implic        '
           +' where Codigo_Transaccion = :empresa  '
           +'   and Implicancia        = :estado   '
            );
    ParamByName('Empresa').AsString := sEmpresa_Usuario;
    ParamByName('estado').AsString  := sMarca;
    try
      ExecSql;
    except
    end;
    Close;

    SQL.Clear;
    SQL.Add('Insert into qs_sys_tran_implic '
           +' ( Codigo_Transaccion, Implicancia )  '
           +' values ( :empresa, :estado )  '
            );
    ParamByName('Empresa').AsString := sEmpresa_Usuario;
    ParamByName('estado').AsString  := sMarca;
    try
      ExecSql;
    except
    end;
    Close;
  end;
end;

function Generando_stock(sMarca: String):Boolean;
begin
  with DataModule_Comun.QRY_General do
  begin
    Result := False;
    SQL.Clear;
    SQL.Add('Select * from qs_sys_tran_implic       '
           +' where Codigo_Transaccion = :empresa  '
           +'   and Implicancia        = :estado   '
            );
    ParamByName('Empresa').AsString := sEmpresa_Usuario;
    ParamByName('estado').AsString  := sMarca;
    Prepare;
    Open;
    if RecordCount <> 0 then
       if FieldByName('Implicancia').AsString = sMarca then
          Result := True;

    Close;
    Unprepare;
  end;
end;

function borrar_nemotecnico(sNemotecnico: String):Boolean;
begin
  with DataModule_Comun.QRY_General do
  begin
    Result := False;
    SQL.Clear;
    SQL.Add('Select * from QS_TRA_OMD_DET_RF a   '
           +' where a.nemotecnico = :nemotecnico  '
           +' and a.folio_interno not in (select x.folio from QS_CTR_ANULACION x'
           +'                             where x.folio = a.folio_interno '
           +'                             and x.transaccion = a.transaccion '
           +'                             and x.empresa = a.empresa) '
            );

    ParamByName('nemotecnico').AsString := sNemotecnico;

    Prepare;
    Open;

    if RecordCount = 0 then
       Result := True;

    Close;
    Unprepare;
  end;
end;

procedure DateDiff(Date1, Date2: TDateTime; var Days, Months, Years: Word);
var
  DtSwap: TDateTime;
  Day1, Day2, Month1, Month2, Year1, Year2: Word;
begin
  if Date1 > Date2 then begin
    DtSwap := Date1;
    Date1 := Date2;
    Date2 := DtSwap;
  end;
  DecodeDate(Date1, Year1, Month1, Day1);
  DecodeDate(Date2, Year2, Month2, Day2);
  if Day2 < Day1 then begin
    Dec(Month2);
    if Month2 = 0 then begin
      Month2 := 12;
      Dec(Year2);
    end;
//    Inc(Day2, DaysPerMonth(Year2, Month2));
    Inc(Day2, ultimo_dia_mes( Month2,Year2));
  end;
  Days := Day2 - Day1;
  if Month2 < Month1 then begin
    Inc(Month2, 12);
    Dec(Year2);
  end;
  Months := Month2 - Month1;
  Years := Year2 - Year1;
end;

function MonthsBetween(Date1, Date2: TDateTime): Double;
var
  D, M, Y: Word;
begin
  DateDiff(Date1, Date2, D, M, Y);
  Result := 12 * Y + M;
  if (D > 1) and (D < 7) then Result := Result + 0.25
  else if (D >= 7) and (D < 15) then Result := Result + 0.5
  else if (D >= 15) and (D < 21) then Result := Result + 0.75
  else if (D >= 21) then Result := Result + 1;
end;

Procedure Busca_param_proceso_PMS_I(sCod_Proceso  : String;
                                    sParametro    : String;
                                    var sValor    : String;
                                    var result    : boolean);
begin
    Result := False;
    svalor := '';
    With DataModule_Comun.QRY_General do
    begin
      sql.Clear;
      sql.Add('SELECT valor FROM qs_sys_param_proceso '
             +' WHERE Proceso   = :Proceso '
             +'   AND Parametro = :Parametro '
             );
      ParamByName('Proceso').AsString    := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      Open;

      if not eof then
      begin
         sValor := FieldByName('Valor').AsString ;
         result := True;
      end;
      Close;
    end;
end;

Procedure Busca_param_proceso(sCod_Proceso  : String;
                              sParametro    : String;
                              var sValor    : String;
                              var result    : boolean);
begin
    Result := False;
    svalor := '';
    with DataModule_Comun.Qry_Param_Proc do
    begin
      ParamByName('Proceso').AsString    := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      Open;

      if not eof then
      begin
         sValor := FieldByName('Valor').AsString ;
         result := True;
      end;
      Close;
    end;
end;

Procedure Busca_param_proceso_mult(sCod_Proceso  : String;
                                   sParametro    : String;
                                   var sValor    : String;
                                   var result    : boolean);
begin
   Result := False;
    with DataModule_Comun.Qry_General do
    begin
      sql.Clear;
      sql.Add('SELECT valor FROM qs_sys_param_proceso '
             +' WHERE Proceso   = :Proceso '
             +'   AND Parametro = :Parametro '
             );
      ParamByName('Proceso').AsString    := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      Open;
      sValor := '';
      While Not eof do
      Begin
         sValor := trim(sValor)+trim(FieldByName('Valor').AsString)+',';
         result := True;

        If Trim(svalor) = '' then
           Result := False;
         Next;
      end;
      Close;
    end;
end;

Procedure Graba_param_proceso(sCod_Proceso  : String;
                              sParametro    : String;
                              sValor        : String);
begin
    if NOT dmBaseDatos.conexion_basedatos.InTransaction then
       dmBaseDatos.conexion_basedatos.StartTransaction;

    with DataModule_Comun.Qry_General do
    begin
      sql.Clear;
      sql.Add('DELETE FROM qs_sys_param_proceso '
             +' WHERE Proceso   = :Proceso '
             +'   AND Parametro = :Parametro '
             );
      ParamByName('Proceso').AsString    := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      Prepare;
      ExecSql;
      Close;
      Unprepare;

      sql.Clear;
      sql.Add('INSERT INTO qs_sys_param_proceso '
             +'(Proceso    '
             +',Parametro  '
             +',Valor      '
             +') VALUES (  '
             +' :Proceso   '
             +',:Parametro '
             +',:Valor     '
             +') '
             );
      ParamByName('Proceso').AsString    := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      ParamByName('Valor').AsString      := sValor;
      Prepare;
      ExecSql;
      Close;
      Unprepare;
    end;
    if dmBaseDatos.conexion_basedatos.InTransaction then
       dmBaseDatos.conexion_basedatos.Commit;

end;

Procedure Agrega_param_proceso(sCod_Proceso  : String;
                              sParametro    : String;
                              sValor        : String);
begin
    if NOT dmBaseDatos.conexion_basedatos.InTransaction then
       dmBaseDatos.conexion_basedatos.StartTransaction;

    with DataModule_Comun.Qry_General do
    begin
      sql.Clear;
      sql.Add('INSERT INTO qs_sys_param_proceso '
             +'(Proceso    '
             +',Parametro  '
             +',Valor      '
             +') VALUES (  '
             +' :Proceso   '
             +',:Parametro '
             +',:Valor     '
             +') '
             );
      ParamByName('Proceso').AsString    := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      ParamByName('Valor').AsString      := sValor;
      Prepare;
      ExecSql;
      Close;
      Unprepare;
    end;
    if dmBaseDatos.conexion_basedatos.InTransaction then
       dmBaseDatos.conexion_basedatos.Commit;

end;

Procedure Elimina_Param_proceso(sCod_Proceso  : String);
begin
   with DataModule_Comun.Qry_General do
   begin
     sql.Clear;
     sql.Add('DELETE FROM qs_sys_param_proceso '
            +' WHERE Proceso   = :Proceso '
            );
     ParamByName('Proceso').AsString    := sCod_Proceso;
     try
       ExecSql;
       Close;
     except
     end;
   end;
end;

Procedure Elimina_Param_proceso2(sCod_Proceso  : String; sParametro : String);
begin
   with DataModule_Comun.Qry_General do
   begin
     sql.Clear;
     sql.Add('DELETE FROM qs_sys_param_proceso '
            +' WHERE Proceso   = :Proceso '
            +'   AND Parametro = :Parametro '
            );
     ParamByName('Proceso').AsString    := sCod_Proceso;
     ParamByName('Parametro').AsString  := sParametro;
     try
       ExecSql;
       Close;
     except
     end;
   end;
end;


Procedure Elimina_Param_Empresa(fPid  : Double);
begin
   with DataModule_Comun.Qry_General do
   begin
     sql.Clear;
     sql.Add('DELETE FROM QS_SYS_PARAM_EMPRESA '
            +' WHERE Pid   = :Pid '
            );
     ParamByName('Pid').AsFloat    := fPid;
     try
       ExecSql;
     except
     end;
   end;
end;


function Implicancia( sTransaccion : String ) : String;
begin
   Result := '';
   With DataModule_Comun.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('SELECT Implicancia'
            +'  FROM QS_SYS_TRAN_IMPLIC'
            +' WHERE Codigo_Transaccion = :Codigo_Transaccion'
            );

     ParamByName('Codigo_Transaccion').AsString := trim(sTransaccion);
     Open;

     if Not FieldByName('Implicancia').isNull then
        Result := FieldByName('Implicancia').AsString;

     Close;
   end;
end;

function Codigo_Transaccion( sCondicion : String ) : String;
begin
   Result := '';
   With DataModule_Comun.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('SELECT Codigo_Transaccion'
            +'  FROM QS_SYS_TRAN_IMPLIC'
            +' WHERE = '+sCondicion 
            );
     Open;
     if Not FieldByName('Implicancia').isNull then
        Result := FieldByName('Codigo_Transaccion').AsString;

     Close;
   end;
end;

function Obtener_Tipo_Movimiento(sEMPRESA         : String;
                                 sCARTERA         : String;
                                 sPLAN_CUENTA     : String;
                                 fCUENTA          : Double;
                                 sHECHO_ECON      : String;
                                 sCOLUMNA_PROCESO : String;
                                 sDEBE_HABER	    : String;
                                 sFECHA           : TDateTime) : String;
var
  bBuscar : Boolean;
  bDebe_Haber : Boolean;
  bCARTERA    : Boolean;
  bEMPRESA    : Boolean;
  bHecho_Econ : Boolean;
  bColumna    : Boolean;
  iPasada     : Integer;
  sWhere_part : String;
  sWhere_part1 : String;
  sWhere_part2 : String;
  sWhere_part3 : String;
  sWhere_part4 : String;
  sWhere_part5 : String;
  sWhere_part6 : String;
  sWhere_part7 : String;
  sWhere_part8 : String;

begin
   Result := '';
   bBuscar     := True;
   iPasada     := 1;

   // F.I. 01-09-2016  Si no existen registros para la empresa biusca con empresa en blanco
   With DataModule_Comun.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('SELECT Count(*) AS Num_Regs   ');
     SQL.Add('  FROM QS_CON_TIPO_MOVIMIENTO ');
     SQL.Add(' WHERE EMPRESA = :EMPRESA     ');
     ParamByName('EMPRESA').AsString := sEMPRESA;

     Open;
     if (FieldByName('Num_Regs').AsFloat = 0) then
        sEmpresa := '';
     Close;
   end;

   if sEMPRESA <> '' then
      bEMPRESA    := True
   else
      bEMPRESA    := False;


//   if fCUENTA  > 0 then
//      bCuenta    := True
//   else
//      bCuenta    := False;

   if sCOLUMNA_PROCESO <> '' then
      bColumna    := True
   else
      bColumna    := False;

   if sDebe_Haber <> '' then
      bDebe_Haber    := True
   else
      bDebe_Haber    := False;

   if sHECHO_ECON <> '' then
      bHecho_Econ := True
   else
      bHecho_Econ := False;

   if sCARTERA <> '' then
      bCARTERA := True
   else
      bCARTERA := False;


   if bHecho_Econ then
   begin
     if bColumna AND bDebe_Haber then
        sWhere_Part1 := ' AND HECHO_ECON  = '''+sHECHO_ECON+''' AND COLUMNA_PROCESO  = '''+sCOLUMNA_PROCESO+''' AND DEBE_HABER  = '''+sDEBE_HABER+''' ';

     if bColumna then
        sWhere_Part2 := ' AND HECHO_ECON  = '''+sHECHO_ECON+''' AND COLUMNA_PROCESO  = '''+sCOLUMNA_PROCESO+''' AND (DEBE_HABER  = '''' OR DEBE_HABER IS NULL) ' ;

     if bDebe_Haber then
        sWhere_Part3 := ' AND HECHO_ECON  = '''+sHECHO_ECON+''' AND (COLUMNA_PROCESO  = '''' OR COLUMNA_PROCESO IS NULL) AND DEBE_HABER  = '''+sDEBE_HABER+''' ';

     sWhere_Part5 := ' AND HECHO_ECON  = '''+sHECHO_ECON+''' AND (COLUMNA_PROCESO  = '''' OR COLUMNA_PROCESO IS NULL) AND (DEBE_HABER  = '''' OR DEBE_HABER IS NULL) ' ;
   end
   else
   begin
     sWhere_Part1 := '';
     sWhere_Part2 := '';
     sWhere_Part3 := '';
     sWhere_Part5 := '';
   end;

   if bColumna then
   begin
     if bDebe_Haber then
        sWhere_Part4 := ' AND (HECHO_ECON  = '''' OR HECHO_ECON IS NULL) AND COLUMNA_PROCESO  = '''+sCOLUMNA_PROCESO+''' AND DEBE_HABER  = '''+sDEBE_HABER+''' ';

     sWhere_Part6 := ' AND (HECHO_ECON  = '''' OR HECHO_ECON IS NULL) AND COLUMNA_PROCESO  = '''+sCOLUMNA_PROCESO+''' AND (DEBE_HABER  = '''' OR DEBE_HABER IS NULL)' ;
   end
   else
   begin
     sWhere_Part4 := '';
     sWhere_Part6 := '';
   end;

   if bColumna then
     if bDebe_Haber then
        sWhere_Part7 := ' AND (HECHO_ECON  = '''' OR HECHO_ECON IS NULL) AND (COLUMNA_PROCESO  = '''' OR COLUMNA_PROCESO IS NULL) AND DEBE_HABER  = '''+sDEBE_HABER+''' '
     else
        sWhere_Part7 := '';

   sWhere_Part8 := ' AND (HECHO_ECON  = '''' OR HECHO_ECON IS NULL) AND (COLUMNA_PROCESO  = '''' OR COLUMNA_PROCESO IS NULL) AND (DEBE_HABER  = '''' OR DEBE_HABER IS NULL)' ;


   WHILE bBuscar do
   begin
      With DataModule_Comun.QRY_General do
      begin

        SQL.Clear;
        SQL.Add('SELECT CODIGO_TOM'                  );
        SQL.Add('  FROM QS_CON_TIPO_MOVIMIENTO      ');
        SQL.Add(' WHERE CUENTA       = :CUENTA      ');
        SQL.Add('   AND PLAN_CUENTA  = :PLAN_CUENTA ');
        ParamByName('CUENTA').AsFloat := fCUENTA;
        ParamByName('PLAN_CUENTA').AsString := sPLAN_CUENTA;


        Case iPasada of
             1 : sWhere_part := sWhere_part1;
             2 : sWhere_part := sWhere_part2;
             3 : sWhere_part := sWhere_part3;
             4 : sWhere_part := sWhere_part4;
             5 : sWhere_part := sWhere_part5;
             6 : sWhere_part := sWhere_part6;
             7 : sWhere_part := sWhere_part7;
             8 : sWhere_part := sWhere_part8;
        end;

        if sWhere_part = '' then
        begin
           Inc(iPasada);
           Continue;
         end;
        SQL.Add(sWhere_part);

        if bCARTERA then
        begin
           SQL.Add(' AND CARTERA = :CARTERA                             ');
           ParamByName('CARTERA').AsString := sCARTERA;
        end
        else
           SQL.Add(' AND (CARTERA IS NULL OR CARTERA = '''')  ');

        if bEMPRESA then
        begin
           SQL.Add(' AND EMPRESA = :EMPRESA                             ');
           ParamByName('EMPRESA').AsString := sEMPRESA;
        end
        else
           SQL.Add(' AND (EMPRESA IS NULL OR EMPRESA = '''')    ');

        SQL.Add('   	AND (FECHA_DESDE <= :FECHA)                     ');
        SQL.Add('   	AND (FECHA_HASTA IS NULL OR FECHA_HASTA >= :FECHA)');

        ParamByName('FECHA').AsDate := sFECHA;
//        if bdesarrollo then
//           sql.savetofile('D:\TEMP\tmp.sql');
        Try
          Open;
        except
           begin
              bBuscar := False;
              Close;
              exit;
           end;
        end;

        if Not FieldByName('CODIGO_TOM').isNull then
        begin
           Result := FieldByName('CODIGO_TOM').AsString;
           bBuscar := False;
        end
        else
              Inc(iPasada);
              if iPasada > 8 then
                 if bCARTERA then
                 begin
                    iPasada := 1;
                    bCARTERA := False
                 end
                 else
                   bBuscar := False;
        Close;
      end;
   end;
end;
function Convierte_a_punto(X:String):double;
Var
fValor : String;
i      : Integer;
Begin
   fValor := x;
   if (trim(fValor) = '') or (trim(fValor) = '-') Then
      Convierte_a_punto := 0
   else
   begin
     if GetLocaleInformation(LOCALE_SDECIMAL) = '.' then
     begin
         i := Pos(',',x);
         if i <> 0 Then
         begin
            fValor          := trim(copy(fValor,1,i-1) + '.' + copy(fValor,i+1,10));
            Convierte_a_punto  := StrToFloat(fValor);
         end
         else
            Convierte_a_punto  := StrToFloat(fValor);
     end
     else
     begin
         i := Pos('.',x);
         if i <> 0 Then
         begin
            fValor          := trim(copy(fValor,1,i-1) + ',' + copy(fValor,i+1,10));
            Convierte_a_punto  := StrToFloat(fValor);
         end
         else
            Convierte_a_punto  := StrToFloat(fValor);
     end;
   end;

//
//function Convierte_a_punto(X:String):double;
//Var
//fValor : String;
//sX     : String;
//i      : Integer;
//Begin
//   fValor := x;
//   if (trim(fValor) = '') or (trim(fValor) = '-') Then
//      Convierte_a_punto := 0
//   else
//   begin
//      i := Pos(',',x);
//      if i <> 0 Then
//      begin
//         fValor          := trim(copy(fValor,1,i-1) + '.' + copy(fValor,i+1,10));
//         Convierte_a_punto  := StrToFloat(fValor);
//      end
//      else
//         Convierte_a_punto  := StrToFloat(fValor);
//   end;

// Se comento, ya que con valores con punto decimal "." Produce un error en el valor que entrega 500.000 = 500000

//   i      := 1;
//   sX     := Trim(X);
//   fValor := '';
//   while (i <= Length(sX)) do
//   begin
//     if sX[i] <> '.' then
//        fValor := fValor + sX[i];
//     inc(i);
//   end;
////   fValor := x;
//   if (trim(fValor) = '') or (trim(fValor) = '-') Then
//      Convierte_a_punto := 0
//   else
//   begin
//      i := Pos(',',fValor);
//      if i <> 0 Then
//      begin
//         fValor          := trim(copy(fValor,1,i-1) + '.' + copy(fValor,i+1,10));
//         Convierte_a_punto  := StrToFloat(fValor);
//      end
//      else
//         Convierte_a_punto  := StrToFloat(fValor);
//   end;
end;

Function Aplica_Operacion_lim( fValor_1
                              ,fValor_2  : Double;
                               sOperacion : String
                             ) : Boolean;
begin
   Result :=  False;
   if sOperacion = '=' then
      Aplica_Operacion_lim := ( fValor_1 = fValor_2 )
   else if sOperacion = '<' then
      Aplica_Operacion_lim := ( fValor_1  < fValor_2 )
   else if sOperacion = '<=' then
      Aplica_Operacion_lim := ( fValor_1 <= fValor_2 )
   else if sOperacion = '>' then
      Aplica_Operacion_lim := ( fValor_1 > fValor_2 )
   else if sOperacion = '>=' then
      Aplica_Operacion_lim := ( fValor_1 >= fValor_2 )
   else if sOperacion = '<>' then
      Aplica_Operacion_lim := ( fValor_1 <> fValor_2 );
end;

function moneda_nacional_pais_Usuario( sPais : String ) : String;
begin
  Result := '';
  WITH DataModule_Comun.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT b.Cod_Moneda As Cod_Moneda'
              +'  FROM qs_sys_pais a'
              +'      ,qs_sys_monedas b'
              +' where nacion_pais     = ''N'''
              +'   and b.nacion_moneda = a.cod_pais'
              +'   and a.cod_pais      = :Pais'
              +'   and b.tipo_moneda   = ''M'''
              );
       Parambyname('pais').asString := sPais;
       Open;
       if (FieldByName('Cod_Moneda').AsString = EmptyStr) or
          (FieldByName('Cod_Moneda').IsNull)              then
       begin
         Application.Messagebox(Pchar('No se encontro definición de moneda nacional para país: '+sPais)
                               ,'Moneda Nacional'
                               ,mb_Ok);
         Result := 'NO DISPONIBLE';
       end
       else
         Result := FieldByName('Cod_Moneda').AsString;
       Close;
    end;
end;
//------------------------------------------------------------------------------
function Busca_Cierre_Cont_Nvo(sProceso     : String;
                               sEmpresa     : String;
                               sCartera     : String;
                               sTipo_Contab : String;
                               var dFecha   : TDatetime;
                               var sMensaje : String ) : Boolean;
Var
  flag_Encontro   : Boolean;
  iIteracion      : Integer;
begin
  Result := False;
  iIteracion := 1;
  if sProceso = 'PARAME' then
  begin
     iIteracion := 5;
     sMensaje := ' con Cierre de Parametros ';
  end
  else  //SS 19-07-2022
    if sProceso = 'OPERAC' then
    begin
       iIteracion := 4;
       sMensaje := ' con Cierre Operacional ';
    end
    else
      if sProceso = 'CIERVAL' then
      begin
         iIteracion := 3;
         sMensaje := ' con Cierre de Valorización ';
      end
      else //fin - Se agrega nuevo parametro SS 19-07-2022
        if sProceso = 'TESORE' then
        begin
           iIteracion := 2;
           sMensaje := ' con Cierre de Tesoreria ';
        end
        else
          if sProceso = 'CONTAB' then
             sMensaje := ' con Cierre Contable '
          else
             sMensaje := ' con Cierre Proceso ';

  Flag_Encontro := False;

  WITH DataModule_Comun.QRY_General do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *'
           +'  FROM QS_CON_CIERRE'
           +' WHERE Empresa       = :Empresa');

    ParamByName('Empresa').AsString        := sEmpresa;

    try
      Open;
    except on E: EFDDBEngineException do
       begin
          Close;
          Exit;
       end;
    end;
  end;

  while (iIteracion > 0) do
  begin
    WITH DataModule_Comun.QRY_General do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT *'
             +'  FROM QS_CON_CIERRE'
             +' WHERE Empresa       = :Empresa');

      if trim(sCartera) <> '' then
         SQL.Add('AND Cartera  = :Cartera');

      if trim(sTipo_Contab) <> '' then
         SQL.Add('AND Tipo_Contabilidad  = :Tipo_Contab');

      SQL.Add('   AND Proceso       = :Proceso'
             +'   AND Estado        = :Estado'
             +'   AND Fecha_cierre >= :Fecha_cierre' );

      ParamByName('Empresa').AsString        := sEmpresa;

      if trim(sCartera) <> '' then
         ParamByName('Cartera').AsString     := sCartera;

      if trim(sTipo_Contab) <> '' then
         ParamByName('Tipo_Contab').AsString     := sTipo_Contab;

      ParamByName('Proceso').AsString        := sProceso;
      ParamByName('Estado').AsString         := 'VIGENTE';
      ParamByName('Fecha_cierre').AsDate := dFecha;

      try
          Open;
          if EOF then
          begin
             if (trim(sCartera) <> '') and (trim(sTipo_Contab) <> '') then
             begin
               SQL.Clear;
               SQL.Add('SELECT *'
                      +'  FROM QS_CON_CIERRE'
                      +' WHERE Empresa       = :Empresa'
                      +'   AND Tipo_Contabilidad  = :Tipo_Contab'
                      +'   AND ((Cartera = :Cartera) or (Cartera is null))'
                      +'   AND Proceso       = :Proceso'
                      +'   AND Estado        = :Estado'
                      +'   AND Fecha_cierre >= :Fecha_cierre');

               ParamByName('Empresa').AsString        := sEmpresa;
               ParamByName('Tipo_Contab').AsString    := sTipo_Contab;
               ParamByName('Cartera').AsString        := '';
               ParamByName('Proceso').AsString        := sProceso;
               ParamByName('Estado').AsString         := 'VIGENTE';
               ParamByName('Fecha_cierre').AsDate := dFecha;

               Open;

               if Not EOF then
                  Flag_Encontro   := True;
             end
             else
             begin
               if (trim(sCartera) <> '') and (trim(sTipo_Contab) = '') then
               begin
                 SQL.Clear;
                 SQL.Add('SELECT *'
                        +'  FROM QS_CON_CIERRE'
                        +' WHERE Empresa       = :Empresa'
                        +'   AND ((Cartera = :Cartera) or (Cartera is null))'
                        +'   AND Proceso       = :Proceso'
                        +'   AND Estado        = :Estado'
                        +'   AND Fecha_cierre >= :Fecha_cierre');

                 ParamByName('Empresa').AsString        := sEmpresa;
                 ParamByName('Cartera').AsString        := '';
                 ParamByName('Proceso').AsString        := sProceso;
                 ParamByName('Estado').AsString         := 'VIGENTE';
                 ParamByName('Fecha_cierre').AsDate := dFecha;

                 Open;

                 if Not EOF then
                    Flag_Encontro   := True;
               end
               else
               begin
                  if (trim(sCartera) = '') and (trim(sTipo_Contab) <> '') then
                  begin
                    SQL.Clear;
                    SQL.Add('SELECT *'
                           +'  FROM QS_CON_CIERRE'
                           +' WHERE Empresa       = :Empresa'
                           +'   AND ((Tipo_Contabilidad = :Tipo_Contab) or (Tipo_Contabilidad is null))'
                           +'   AND Proceso       = :Proceso'
                           +'   AND Estado        = :Estado'
                           +'   AND Fecha_cierre >= :Fecha_cierre');

                    ParamByName('Empresa').AsString        := sEmpresa;
                    ParamByName('Tipo_Contab').AsString    := '';
                    ParamByName('Proceso').AsString        := sProceso;
                    ParamByName('Estado').AsString         := 'VIGENTE';
                    ParamByName('Fecha_cierre').AsDate := dFecha;

                    Open;

                    if Not EOF then
                       Flag_Encontro   := True;
                  end;
               end;
             end;
          end
          else
             Flag_Encontro   := True;
      except
      end;

      Result := False;
      if Flag_Encontro then
      begin
         dFecha := FieldByname('Fecha_Cierre').asDatetime;
         iIteracion := 0;
         Result := True;
      end;
      Close;
    end;  // With

    iIteracion := iIteracion - 1;

    if Transaccion_implica_mem(sEmpresa_usuario,'PARAMNBLOC') then
      if iIteracion = 4 then
         iIteracion := 3;

    if iIteracion = 4 then
    begin
       sProceso := 'OPERAC';
       sMensaje := ' con Cierre Operacional ';
    end
    else
      if iIteracion = 3 then
      begin
         sProceso := 'CIERVAL';
         sMensaje := ' con Cierre Valorización ';
      end
      else
         if iIteracion = 2 then
         begin
           sProceso := 'TESORE';
            sMensaje := ' con Cierre de Tesoreria ';
         end
         else
            if (iIteracion = 1) and (sProceso = 'TESORE') then
            begin
              sProceso := 'CONTAB';
              sMensaje := ' con Cierre Contable ';
            end;


  end
end;
//------------------------------------------------------------------------------
function Busca_Cierre_Contable(sProceso : String;
                         sEmpresa : String;
                         sCartera : String;
                         var dFecha   : TDatetime) : Boolean;
Var
  flag_Encontro   : Boolean;
begin
  Flag_Encontro := False;
  WITH DataModule_Comun.QRY_General do
  begin
     SQL.Clear;
     SQL.Add('SELECT *'
            +'  FROM QS_CON_CIERRE'
            +' WHERE Empresa       = :Empresa'
            );
     if scartera <> '' then
        SQL.Add('AND Cartera       = :Cartera');
     SQL.Add('   AND Proceso       = :Proceso'
            +'   AND Estado        = :Estado'
            +'   AND Fecha_cierre >= :Fecha_cierre'
            );
     ParamByName('Empresa').AsString        := sEmpresa;
     if scartera <> '' then
        ParamByName('Cartera').AsString     := sCartera;
     ParamByName('Proceso').AsString        := sProceso;
     ParamByName('Estado').AsString         := 'VIGENTE';
     ParamByName('Fecha_cierre').AsDate := dFecha;

     try
         Open;
         if EOF then
         begin
            SQL.Clear;
            SQL.Add('SELECT *'
                   +'  FROM QS_CON_CIERRE'
                   +' WHERE Empresa       = :Empresa'
                   +'   AND ((Cartera = :Cartera) or (Cartera is null))'
                   +'   AND Proceso       = :Proceso'
                   +'   AND Estado        = :Estado'
                   +'   AND Fecha_cierre >= :Fecha_cierre'
                   );
            ParamByName('Empresa').AsString        := sEmpresa;
            ParamByName('Cartera').AsString        := '';
            ParamByName('Proceso').AsString        := sProceso;
            ParamByName('Estado').AsString         := 'VIGENTE';
            ParamByName('Fecha_cierre').AsDate := dFecha;
            Open;
            if Not EOF then
            begin
               Flag_Encontro   := True;
            end;
         end
         else
            Flag_Encontro   := True;
     except
     end;

     Result := False;
     if Flag_Encontro then
     begin
        dFecha := FieldByname('Fecha_Cierre').asDatetime;
        Result := True;
     end;
     Close;
  end;  // With

end;
//------------------------------------------------------------------------------

Procedure AsignaParametrosEmpresas(PID:Double);
Var
S     : String;
Empresa    : String;
cartera    : String;
i,p        : Integer;
F1         : TextFile;
Begin
   AssignFile(F1,directorio_windows+'\'+sArchivo_Ini);
   Reset(F1);
   while not Eof(F1) do
     Begin
        Readln(F1, S);
        If S = '[Parametros Empresa]' Then
           while (not eof(f1)) do
              Begin
                if copy(s,1,1) <> '[' then
                  Begin
                      i := pos('=',s);
                      p := pos('-',s);
                      Empresa    := Trim(Copy(s, i+1 ,p-i-1));
                      cartera    := Trim(Copy(s, p+1 ,20));
                      With DataModule_Comun.Qry_General do
                       Begin
                           Close;
                           Sql.Clear;
                           Sql.Add('INSERT INTO QS_SYS_PARAM_EMPRESA (PID,EMPRESA,CARTERA) '
                                  +'VALUES (:pid,:empresa,:cartera)                   '
                                  );
                           ParamByName('pid').AsFloat       := pid;
                           ParamByName('empresa').AsString  := empresa;
                           ParamByName('cartera').AsString  := cartera;
                           ExecSQL;
                           Close;
                       End;
                  end;
                  Readln(F1, S);
              End;
     End;
   CloseFile(F1);
End;

Procedure EliminaParametrosEmpresas(PID:double);
Begin
   With DataModule_Comun.Qry_General do
   Begin
       Close;
       Sql.Clear;
       Sql.Add('DELETE FROM QS_SYS_PARAM_EMPRESA '
              +'WHERE pid = :pid           '
              );
       ParamByName('pid').AsFloat       := pid;
       ExecSQL;
       Close;
   End;
End;

function Obtener_Tipo_Movimiento_Por_Hecho_Economico(  sEMPRESA
                                                      ,sCARTERA
                                                      ,sHecho_Econ : String;
                                                      dFECHA       : TDateTime
                                                    ) : String;
var
  bBuscar,
  bCARTERA : Boolean;
begin
   Result      := '';
   bBuscar     := True;
   bCARTERA    := True;

   WHILE bBuscar do
   begin
      With DataModule_Comun.QRY_General do
      begin
        SQL.Clear;
        SQL.Add(' SELECT CODIGO_TOM'
               +'  FROM QS_CON_TIPO_MOVIMIENTO_HECHO '
               +' WHERE Empresa    = :Empresa'
               +'   AND Hecho_Econ = :Hecho_Econ'
               +'   AND (FECHA_DESDE <= :FECHA) '
               +'   AND (FECHA_HASTA IS NULL OR FECHA_HASTA >= :FECHA)'
               );

        if bCARTERA then
        begin
           SQL.Add(' AND CARTERA = :CARTERA  ');
           ParamByName('CARTERA').AsString := sCARTERA;
        end
        else
           SQL.Add(' AND (CARTERA IS NULL OR CARTERA = '''')                                 ');

        ParamByName('EMPRESA').AsString    := sEMPRESA;
        ParamByName('Hecho_Econ').asString := sHecho_Econ;
        ParamByName('FECHA').AsDate    := dFECHA;
        try
           Open;
        except on E: EFDDBEngineException do
           begin
              ShowError(E);
              Close;
              Exit;
           end;
        end;


        if Not FieldByName('CODIGO_TOM').isNull then
        begin
           Result  := FieldByName('CODIGO_TOM').AsString;
           bBuscar := False;
        end
        else if bCARTERA then
                bCARTERA := False
             else
                bBuscar  := False;

        Close;
      end;
   end;
end;

function Busca_Motivo_OMD( sEmpresa,
                           sCartera,
                           sTransaccion,
                           sFolio          : string;
                           fItem_Omd       : Double;
                           dFecha: TDateTime): string;
begin
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT a.Cod_Motivo ');
      // E.S.  29-04-2010 Cambie la tabla por la nueva QS_TRA_OMD_MOTIVO_OMD
      SQL.Add('  FROM QS_TRA_OMD_MOTIVO_OMD a ');         //       SQL.Add('  FROM QS_TRA_OMD_MOTIVO_INV');
      SQL.Add(' WHERE a.Folio_Interno = :Folio_Interno');
      SQL.Add('   AND a.Transaccion   = :Transaccion'  );
      SQL.Add('   AND a.Empresa       = :Empresa'      );
      SQL.Add('   AND a.Fecha_Desde  = (SELECT MAX(b.fecha_desde) ');
      SQL.Add('                           FROM QS_TRA_OMD_MOTIVO_OMD b ');
      SQL.Add('                          WHERE b.Folio_Interno = a.Folio_Interno ');
      SQL.Add('                            AND b.Item_omd      = a.Item_omd ');
      SQL.Add('                            AND b.Transaccion   = a.Transaccion ');
      SQL.Add('                            AND b.Cartera       = a.Cartera  ');
      SQL.Add('                            AND b.Empresa       = a.Empresa ');
      SQL.Add('                            AND b.Fecha_Desde <= :Fecha ');
      SQL.Add('                            AND (b.Fecha_Hasta IS NULL OR b.Fecha_Hasta >= :Fecha)) ');
      if sCartera <> '' then
      begin
         SQL.Add('   AND a.Cartera = :Cartera'  );
         ParamByName('Cartera').AsString   := sCartera;
      end;
      if fItem_Omd <> 0 then
      begin
         SQL.Add('   AND a.Item_Omd = :Item_Omd'  );
         ParamByName('Item_Omd').asFloat   := fItem_Omd;
      end;

      ParamByName('Empresa'      ).AsString   := sEmpresa;
      ParamByName('Transaccion'  ).AsString   := sTransaccion;
      ParamByName('Folio_Interno').AsString   := sFolio;
      ParamByName('Fecha'        ).AsDate     := dFecha;
      Open;

      if not FieldByName('Cod_Motivo').IsNull then
         Result := FieldByName('Cod_Motivo').AsString
      else
      begin
         Close;
         SQL.Clear;
         SQL.Add('SELECT Motivo ');
         SQL.Add('  FROM QS_TRA_OMD');
         SQL.Add(' WHERE Folio_Interno = :Folio_Interno');
         SQL.Add('   AND Transaccion   = :Transaccion'  );
         SQL.Add('   AND Empresa       = :Empresa'      );

         ParamByName('Empresa'      ).AsString   := sEmpresa;
         ParamByName('Transaccion'  ).AsString   := sTransaccion;
         ParamByName('Folio_Interno').AsString   := sFolio;
         Open;
         if not FieldByName('Motivo').IsNull then
            Result := FieldByName('Motivo').AsString
         else
            Result := '';
      end;

      Close;
   end;
end;

function Busca_Cartera_Clasif( sObjeto,
                               sCodigo_Clasif : String): String;
begin

   Result := '';

   With DataModule_Comun.QRY_General do
   begin
      Sql.clear;
      sql.add('select a.ELEMENTO      '
             +'  from QS_SYS_CLASIF_OBJ a'
             +'      ,QS_FIN_CARTERAS   b'
             +' where a.OBJETO        = :Objeto '
             +'   and a.CODIGO_CLASIF = :Codigo_Clasif '
             +'   and a.ELEMENTO      = b.COD_CARTERA'
             );
      ParamByName('Objeto').AsString        := sObjeto;
      ParamByName('Codigo_Clasif').AsString := sCodigo_Clasif;
      Open;
      If Not Eof then
         Result := FieldByName('ELEMENTO').AsString;

   end;
end;

function Default_Cartera_Perfil( sPerfil : String): String;
begin


   Result := '';

   With DataModule_Comun.QRY_General do
   begin
      Sql.clear;
      sql.add('SELECT a.CARTERA '
             +'  FROM QS_SYS_PERFIL_CARTERAS a'
             +' WHERE a.COD_PERFIL      = :Perfil '
             +'   AND a.DEFAULT_CARTERA = :xDefault '
             );
      ParamByName('Perfil').AsString  := sPerfil;
      ParamByName('xDefault').AsString := 'S';
      Open;
      If Not Eof then
         Result := FieldByName('CARTERA').AsString;

   end;
end;

// Este es utilizado en la contabilidad
// COmo RV no tiene montivo de inversion en la tabla
// Se esta poniendo el registrado en la QS_TRA_OMD_MOTIVO
// Mas recientemente para el nemotecnico
  //Se agrego un reallamado para buscar el motivo de inersion del nemotecnico equivalente F.I. 21-04-2015
function Busca_Motivo_Inversion_RV( sEmpresa        : String;
                                    sCartera        : String;
                                    sTransaccion    : String;
                                    sNemotecnico    : String;
                                    dFecha_Cierre   : TDateTime;
                                    bRellamado      : Boolean) : String;
begin
    WITH DataModule_Comun.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT C.COD_MOTIVO,C.FOLIO_INTERNO  ');
       SQL.Add('  FROM QS_TRA_OMD_MOTIVO C           ');
       SQL.Add('      ,QS_TRA_OMD A                  ');
       SQL.Add('      ,QS_TRA_OMD_DET_RF B           ');
       if bRellamado then
       begin
          SQL.Add('      ,QS_SYS_EQUIVALEN  d       ');
          SQL.Add('  WHERE d.CODIGO_OBJETO = ''NEMOTEC''    ');
          SQL.Add('      AND d.CODIGO_PROCESO = ''RV''      ');
          SQL.Add('      AND d.CODIGO_EQUIV = :NEMOTECNICO  ');
          SQL.Add('      AND B.NEMOTECNICO = d.CODIGO_SISTEMA ');
       end
       else
       begin
          SQL.Add(' WHERE B.NEMOTECNICO = :NEMOTECNICO  ');
       end;
       SQL.Add('   AND B.TRANSACCION = :TRANSACCION  ');

       if sCartera <> '' then
          SQL.Add('   AND B.CARTERA     = :CARTERA  ');
       SQL.Add('   AND B.EMPRESA     = :EMPRESA      ');
       SQL.Add('   AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO                         ');
       SQL.Add('    				  FROM QS_CTR_ANULACION E             ');
       SQL.Add('    				 WHERE E.FOLIO = B.FOLIO_INTERNO      ');
       SQL.Add('    				   AND E.TRANSACCION = B.TRANSACCION  ');
       SQL.Add('    				   AND E.EMPRESA = B.EMPRESA          ');
       SQL.Add('    				)                                     ');
       SQL.Add('    AND A.FOLIO_INTERNO = B.FOLIO_INTERNO  ');
       SQL.Add('    AND A.TRANSACCION   = B.TRANSACCION    ');
       SQL.Add('    AND A.EMPRESA       = B.EMPRESA        ');
       SQL.Add('    AND C.FOLIO_INTERNO = B.FOLIO_INTERNO  ');
       SQL.Add('    AND C.TRANSACCION   = B.TRANSACCION    ');
       SQL.Add('    AND C.ITEM_OMD      = B.ITEM_OMD       ');
       SQL.Add('    AND C.EMPRESA       = B.EMPRESA        ');
       SQL.Add('    AND C.FECHA_DESDE   = (SELECT MAX(F.FECHA_DESDE)            ');
       SQL.Add('	  		      FROM QS_TRA_OMD_MOTIVO F          ');
       SQL.Add('			          ,QS_TRA_OMD_DET_RF H          ');
       SQL.Add('			     WHERE H.NEMOTECNICO = B.NEMOTECNICO ');
       SQL.Add('			       AND H.TRANSACCION = B.TRANSACCION ');
       if sCartera <> '' then
          SQL.Add('			       AND H.CARTERA     = :CARTERA     ');
       SQL.Add('			       AND H.EMPRESA     = :EMPRESA     ');
       SQL.Add('   			       AND H.FOLIO_INTERNO NOT IN (SELECT G.FOLIO                       ');
       SQL.Add('    				  		  	     FROM QS_CTR_ANULACION G            ');
       SQL.Add('    				 			    WHERE G.FOLIO = H.FOLIO_INTERNO     ');
       SQL.Add('    				   			      AND G.TRANSACCION = H.TRANSACCION ');
       SQL.Add('    				   			      AND G.EMPRESA = H.EMPRESA         ');
       SQL.Add('    							   )                                    ');
       SQL.Add('                              AND F.FOLIO_INTERNO = H.FOLIO_INTERNO ');
       SQL.Add('                              AND F.TRANSACCION = H.TRANSACCION     ');
       SQL.Add('                              AND F.ITEM_OMD = H.ITEM_OMD           ');
       SQL.Add('                              AND F.EMPRESA = H.EMPRESA             ');
       SQL.Add('                              AND F.FECHA_DESDE <= :FECHA           ');
       SQL.Add('                              AND (F.Fecha_Hasta >= :FECHA OR F.Fecha_Hasta IS NULL) ');
       SQL.Add('	                    )                                       ');
       // Se incluyo con fecha 15-11-2006 para que tomara el ultimo motivo (caso dos compras el mismo día)
       if sDriver = 'ORACLE' then
          SQL.Add(' ORDER BY TO_NUMBER(c.folio_interno) DESC ')
       else
          SQL.Add(' ORDER BY cast(c.folio_interno as integer) DESC                                           ');

       ParamByName('Nemotecnico').AsString   := sNemotecnico;
       ParamByName('Transaccion').AsString   := sTransaccion;
       if sCartera <> '' then
          ParamByName('Cartera' ).AsString   := sCartera;
       ParamByName('Empresa'    ).AsString   := sEmpresa;
       ParamByName('Fecha'      ).AsDate := dFecha_Cierre;

       Open;
       if FieldByName('COD_MOTIVO').IsNull then
          Result := ''
       else
          Result := FieldByName('COD_MOTIVO').AsString;
       Close;

       if (Result = '') then
          if NOT bReLLamado then
             Result := Busca_Motivo_Inversion_RV( sEmpresa
                                                 ,sCartera
                                                 ,sTransaccion
                                                 ,sNemotecnico
                                                 ,dFecha_Cierre
                                                 ,True);

    end;
end;


function Busca_Contraparte_RV( sEmpresa        : String;
                               sCartera        : String;
                               sTransaccion    : String;
                               sNemotecnico    : String;
                               dFecha_Cierre   : TDateTime) : String;

begin
    WITH DataModule_Comun.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT a.CONTRAPARTE,A.FOLIO_INTERNO  ');
       SQL.Add('  FROM QS_TRA_OMD A                  ');
       SQL.Add('      ,QS_TRA_OMD_DET_RF B           ');
       SQL.Add(' WHERE B.NEMOTECNICO = :NEMOTECNICO  ');
       SQL.Add('   AND B.TRANSACCION = :TRANSACCION  ');

       if sCartera <> '' then
          SQL.Add('   AND B.CARTERA     = :CARTERA  ');
       SQL.Add('   AND B.EMPRESA     = :EMPRESA      ');
       SQL.Add('   AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO                         ');
       SQL.Add('    				  FROM QS_CTR_ANULACION E             ');
       SQL.Add('    				 WHERE E.FOLIO = B.FOLIO_INTERNO      ');
       SQL.Add('    				   AND E.TRANSACCION = B.TRANSACCION  ');
       SQL.Add('    				   AND E.EMPRESA = B.EMPRESA          ');
       SQL.Add('    				)                                     ');
       SQL.Add('    AND A.FOLIO_INTERNO = B.FOLIO_INTERNO  ');
       SQL.Add('    AND A.TRANSACCION   = B.TRANSACCION    ');
       SQL.Add('    AND A.EMPRESA       = B.EMPRESA        ');
       SQL.Add('    AND A.FECHA_OPERACION = (SELECT MAX(F.FECHA_OPERACION)      ');
       SQL.Add('	  		      FROM QS_TRA_OMD F          ');
       SQL.Add('			          ,QS_TRA_OMD_DET_RF H          ');
       SQL.Add('			     WHERE H.NEMOTECNICO = :NEMOTECNICO ');
       SQL.Add('			       AND H.TRANSACCION = :TRANSACCION ');
       if sCartera <> '' then
          SQL.Add('			       AND H.CARTERA     = :CARTERA     ');
       SQL.Add('			       AND H.EMPRESA     = :EMPRESA     ');
       SQL.Add('   			       AND H.FOLIO_INTERNO NOT IN (SELECT G.FOLIO                       ');
       SQL.Add('    				  		  	     FROM QS_CTR_ANULACION G            ');
       SQL.Add('    				 			    WHERE G.FOLIO = H.FOLIO_INTERNO     ');
       SQL.Add('    				   			      AND G.TRANSACCION = H.TRANSACCION ');
       SQL.Add('    				   			      AND G.EMPRESA = H.EMPRESA         ');
       SQL.Add('    							   )                                    ');
       SQL.Add('                              AND F.FOLIO_INTERNO = H.FOLIO_INTERNO ');
       SQL.Add('                              AND F.TRANSACCION = H.TRANSACCION     ');
       SQL.Add('                              AND F.EMPRESA = H.EMPRESA             ');
       SQL.Add('                              AND F.FECHA_OPERACION <= :FECHA       ');
       SQL.Add('	                    )                                       ');
       // Se incluyo con fecha 15-11-2006 para que tomara el ultimo motivo (caso dos compras el mismo día)
       if sDriver = 'ORACLE' then
          SQL.Add(' ORDER BY TO_NUMBER(a.folio_interno) DESC ')
       else
          SQL.Add(' ORDER BY cast(a.folio_interno as integer) DESC                                           ');

       ParamByName('Nemotecnico').AsString   := sNemotecnico;
       ParamByName('Transaccion').AsString   := sTransaccion;
       if sCartera <> '' then
          ParamByName('Cartera' ).AsString   := sCartera;
       ParamByName('Empresa'    ).AsString   := sEmpresa;
       ParamByName('Fecha'      ).AsDate := dFecha_Cierre;

       Open;
       if FieldByName('CONTRAPARTE').IsNull then
          Result := ''
       else
          Result := FieldByName('CONTRAPARTE').AsString;
       Close;
    end;
end;

function Busca_Custodia_RV( sEmpresa        : String;
                               sCartera        : String;
                               sTransaccion    : String;
                               sNemotecnico    : String;
                               dFecha_Cierre   : TDateTime) : String;
Var sCodigo_Sistema : string;
begin
    WITH DataModule_Comun.QRY_General do
    begin
       SQL.Clear;
       SQL.Add(' SELECT x.codigo_sistema ');
       SQL.Add('   FROM qs_sys_equivalen x ');
       SQL.Add('  WHERE x.codigo_proceso = ''RV'' ' );
       SQL.Add('    AND x.codigo_objeto = ''NEMOTEC''  ');
       sql.Add('    AND x.fecha_desde <= :fecha       ');
       sql.Add('    AND (x.fecha_hasta >= :fecha or x.fecha_hasta is null) ');
       SQL.Add('    AND x.codigo_equiv = :NEMOTECNICO ');
       ParamByName('Nemotecnico').AsString   := sNemotecnico;
       ParamByName('Fecha'      ).AsDate := dFecha_Cierre;
       Open;
       sCodigo_Sistema := FieldByName('codigo_sistema').AsString;

       SQL.Clear;
       //SQL.Add('SELECT a.CUSTODIA_DESTINO,A.FOLIO_INTERNO,b.CUSTODIA_DEST  ');       //DC 15/12/2015

       SQL.Add('SELECT A.FOLIO_INTERNO, b.CUSTODIA_DEST as CUSTODIA_DESTINO ');
       SQL.Add('  FROM QS_TRA_OMD A                  ');
       SQL.Add('      ,QS_TRA_OMD_DET_RF B           ');
       SQL.Add(' WHERE (B.NEMOTECNICO = :NEMOTECNICO  OR B.NEMOTECNICO = :Codigo_Sistema) ');
//       SQL.Add(' WHERE (B.NEMOTECNICO = :NEMOTECNICO  ');

       ////DC Diciembre 2015
//       SQL.Add('    OR B.NEMOTECNICO IN (SELECT x.codigo_sistema from qs_sys_equivalen x ');
//       SQL.Add('                          where x.codigo_proceso = ''RV'' ' );
//       SQL.Add('                            and x.codigo_objeto = ''NEMOTEC''  ');
//       sql.Add('                            and x.fecha_desde <= :fecha       ');
//       sql.Add('                            and (x.fecha_hasta >= :fecha or x.fecha_hasta is null) ');
//       SQL.Add('                            and x.codigo_equiv = :NEMOTECNICO )) ');
       ////DC Diciembre 2015

       SQL.Add('   AND B.TRANSACCION = :TRANSACCION  ');

       if sCartera <> '' then
          SQL.Add('   AND B.CARTERA     = :CARTERA  ');
       SQL.Add('   AND B.EMPRESA     = :EMPRESA      ');
       SQL.Add('   AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO                         ');
       SQL.Add('    				  FROM QS_CTR_ANULACION E             ');
       SQL.Add('    				 WHERE E.FOLIO = B.FOLIO_INTERNO      ');
       SQL.Add('    				   AND E.TRANSACCION = B.TRANSACCION  ');
       SQL.Add('    				   AND E.EMPRESA = B.EMPRESA          ');
       SQL.Add('    				)                                     ');
       SQL.Add('    AND A.FOLIO_INTERNO = B.FOLIO_INTERNO  ');
       SQL.Add('    AND A.TRANSACCION   = B.TRANSACCION    ');
       SQL.Add('    AND A.EMPRESA       = B.EMPRESA        ');
       SQL.Add('    AND A.FECHA_OPERACION = (SELECT MAX(F.FECHA_OPERACION)      ');
       SQL.Add('	  		      FROM QS_TRA_OMD F          ');
       SQL.Add('			          ,QS_TRA_OMD_DET_RF H          ');
       SQL.Add('			     WHERE (H.NEMOTECNICO = :NEMOTECNICO OR H.NEMOTECNICO = :Codigo_Sistema)');
       SQL.Add('			       AND H.TRANSACCION = :TRANSACCION ');
       if sCartera <> '' then
          SQL.Add('			       AND H.CARTERA     = :CARTERA     ');
       SQL.Add('			       AND H.EMPRESA     = :EMPRESA     ');
       SQL.Add('   			       AND H.FOLIO_INTERNO NOT IN (SELECT G.FOLIO                       ');
       SQL.Add('    				  		  	     FROM QS_CTR_ANULACION G            ');
       SQL.Add('    				 			    WHERE G.FOLIO = H.FOLIO_INTERNO     ');
       SQL.Add('    				   			      AND G.TRANSACCION = H.TRANSACCION ');
       SQL.Add('    				   			      AND G.EMPRESA = H.EMPRESA         ');
       SQL.Add('    							   )                                    ');
       SQL.Add('                              AND F.FOLIO_INTERNO = H.FOLIO_INTERNO ');
       SQL.Add('                              AND F.TRANSACCION = H.TRANSACCION     ');
       SQL.Add('                              AND F.EMPRESA = H.EMPRESA             ');
       SQL.Add('                              AND F.FECHA_OPERACION <= :FECHA       ');
       SQL.Add('	                    )                                       ');
       // Se incluyo con fecha 15-11-2006 para que tomara el ultimo motivo (caso dos compras el mismo día)
//       if sDriver = 'ORACLE' then
//          SQL.Add(' ORDER BY TO_NUMBER(a.folio_interno) DESC ')
//       else
//          SQL.Add(' ORDER BY cast(a.folio_interno as integer) DESC                                           ');

       ParamByName('Nemotecnico').AsString   := sNemotecnico;
       ParamByName('Transaccion').AsString   := sTransaccion;
       if sCartera <> '' then
          ParamByName('Cartera' ).AsString   := sCartera;
       ParamByName('Empresa'    ).AsString   := sEmpresa;
       ParamByName('Fecha'      ).AsDate := dFecha_Cierre;
       ParamByName('Codigo_Sistema'    ).AsString := sCodigo_Sistema;

       Open;
       if FieldByName('CUSTODIA_DESTINO').IsNull then
          Result := ''
       else
          Result := FieldByName('CUSTODIA_DESTINO').AsString;
       Close;
    end;
end;


function Busca_Motivo_Inversion_Ahorro( sEmpresa        : String;
                                    sTransaccion    : String;
                                    sNemotecnico    : String;
                                    dFecha_Cierre   : TDateTime) : String;

begin
    WITH DataModule_Comun.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT *                                             ');
       SQL.Add('  FROM QS_AHORRO_MOTIVO                              ');
       SQL.Add(' WHERE NEMOTECNICO = :NEMOTECNICO                    ');
       SQL.Add(' AND Fecha_Desde >= :Fecha                           ');
       SQL.Add(' AND (Fecha_Hasta is null OR Fecha_Hasta <= :Fecha)  ');
       SQL.Add(' ORDER BY nemotecnico DESC                           ');

       ParamByName('Nemotecnico').AsString := sNemotecnico;
//       ParamByName('Transaccion').AsString := sTransaccion;
//       ParamByName('Empresa'    ).AsString := sEmpresa;
       ParamByName('Fecha'      ).AsDate := dFecha_Cierre;

       Open;
       if FieldByName('MOTIVO').IsNull then
          Result := ''
       else
          Result := FieldByName('MOTIVO').AsString;
       Close;
    end;
end;

//------------------------------------------------------------------------------

function Busca_Bolsa_RV( sEmpresa        : String;
                         sTransaccion    : String;
                         sNemotecnico    : String;
                         dFecha_Cierre   : TDateTime) : String;

begin
    WITH DataModule_Comun.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT A.CODIGO_BOLSA                                                                          ');
       SQL.Add('  FROM QS_TRA_OMD A                                                                            ');
       SQL.Add('      ,QS_TRA_OMD_DET_RF B                                                                     ');
       SQL.Add(' WHERE B.NEMOTECNICO = :NEMOTECNICO                                                            ');
       SQL.Add('   AND B.TRANSACCION = :TRANSACCION                                                            ');
       SQL.Add('   AND B.EMPRESA     = :EMPRESA                                                                ');
       SQL.Add('   AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO                                                  ');
       SQL.Add('    				  FROM QS_CTR_ANULACION E                                       ');
       SQL.Add('    				 WHERE E.FOLIO = B.FOLIO_INTERNO                                ');
       SQL.Add('    				   AND E.TRANSACCION = B.TRANSACCION                            ');
       SQL.Add('    				   AND E.EMPRESA = B.EMPRESA                                    ');
       SQL.Add('    				)                                                               ');
       SQL.Add('    AND A.FOLIO_INTERNO = B.FOLIO_INTERNO                                                      ');
       SQL.Add('    AND A.TRANSACCION   = B.TRANSACCION                                                        ');
       SQL.Add('    AND A.EMPRESA       = B.EMPRESA                                                            ');
       SQL.Add('    AND A.FECHA_OPERACION = (SELECT MAX(F.FECHA_OPERACION)                                     ');
       SQL.Add('	  		      FROM QS_TRA_OMD F                                                ');
       SQL.Add('			          ,QS_TRA_OMD_DET_RF H                                         ');
       SQL.Add('			     WHERE H.NEMOTECNICO = :NEMOTECNICO                                ');
       SQL.Add('			       AND H.TRANSACCION = :TRANSACCION                                ');
       SQL.Add('			       AND H.EMPRESA     = :EMPRESA                                    ');
       SQL.Add('   			       AND H.FOLIO_INTERNO NOT IN (SELECT G.FOLIO                       ');
       SQL.Add('    				  		  	     FROM QS_CTR_ANULACION G            ');
       SQL.Add('    				 			    WHERE G.FOLIO = H.FOLIO_INTERNO     ');
       SQL.Add('    				   			      AND G.TRANSACCION = H.TRANSACCION ');
       SQL.Add('    				   			      AND G.EMPRESA = H.EMPRESA         ');
       SQL.Add('    							   )                                    ');
       SQL.Add('                              AND F.FOLIO_INTERNO = H.FOLIO_INTERNO                            ');
       SQL.Add('                              AND F.TRANSACCION = H.TRANSACCION                                ');
       SQL.Add('                              AND F.EMPRESA = H.EMPRESA                                        ');
       SQL.Add('                              AND F.FECHA_OPERACION <= :FECHA                                  ');
       SQL.Add('	                    )                                                                   ');


       ParamByName('Nemotecnico').AsString := sNemotecnico;
       ParamByName('Transaccion').AsString := sTransaccion;
       ParamByName('Empresa'    ).AsString := sEmpresa;
       ParamByName('Fecha'      ).AsDate := dFecha_Cierre;

       Open;
       if FieldByName('CODIGO_BOLSA').IsNull then
          Result := ''
       else
          Result := FieldByName('CODIGO_BOLSA').AsString;
       Close;
    end;
end;
//------------------------------------------------------------------------------

function Busca_Nombre_Menu(sNombre_Programa : string): string;
begin
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Descripcion ');
      SQL.Add('  FROM QS_SYS_MENU');
      SQL.Add(' WHERE Nombre_Programa = :Nombre_Programa ');
      ParamByName('Nombre_Programa').AsString := sNombre_Programa;
      Open;
      if not FieldByName('Descripcion').IsNull then
         Result := FieldByName('Descripcion').AsString
      else
         Result := '';
      Close;
   end;
end;

procedure Fechas_Tramos(dFecha_Input : TDateTime;
                        sUnidad      : STring;
                        iCantidad    : Integer;
                    var dFecha_Output: TDateTime
                        );
var
  yy,mm,dd      : word;
  iAnos         : Integer;
begin
  if sUnidad = 'DIA' then
     dFecha_Output   := dFecha_Input + iCantidad;

  decodedate(dFecha_Input,yy,mm,dd);
  if sUnidad = 'ANO' then
  begin
    yy         := yy + iCantidad;
    case mm of
    2          :if dd > 28 then dFecha_Output := encodedate(yy,03,01) - 1
                           else dFecha_Output := encodedate(yy,mm,dd);

    4,6,9,11   :if dd = 31 then dFecha_Output := encodedate(yy,mm,30)
                           else dFecha_Output := encodedate(yy,mm,dd);
    else   dFecha_Output := encodedate(yy,mm,dd);
    end;{case}
  end;{año}

  if sUnidad = 'MES' then
  begin
    if iCantidad > 11 then
    begin
      iAnos     := Trunc(iCantidad / 12);
      yy        := yy + iAnos;
      iCantidad := iCantidad - Trunc(iAnos * 12);
    end;
    mm := mm + iCantidad;
    if mm > 12 then
    begin
      yy := yy + 1;
      mm := mm - 12;
    end;
    
    case mm of
    2 :
      if dd >= 28 then
         dFecha_Output := encodedate(yy,03,01) - 1
      else
         dFecha_Output := encodedate(yy,mm,dd);

    4,6,9,11:
      if dd >= 28 then
         dFecha_Output := encodedate(yy,mm,30)
      else
         dFecha_Output := encodedate(yy,mm,dd);
    1,3,5,7,8,10,12:
      if dd >= 28 then
         dFecha_Output := encodedate(yy,mm,31)
      else
         dFecha_Output := encodedate(yy,mm,dd)
    end;{case}
  end;{mes}
end;{procedure}

procedure Existe_Tabla_en_Base_de_datos( sDriver       : String;
                                         sNombre_Tabla : String;
                                         var sModulo_Err  : String;
                                         var sString_Err  : String;
                                         var bExiste      : Boolean;
                                         var Result       : Boolean);
begin
   Result := True;
   with DataModule_Comun.Qry_General do
   begin
      SQL.Clear;
      if sDriver = 'ORACLE' then
      begin
         bExiste := True;
         SQL.Add(' SELECT COUNT(*) AS NUM_REGS  ');
         SQL.Add('   FROM '+sNombre_Tabla        );
         try
           Open
         except
           bExiste := False;
         end;
         Close;
         exit;
      end
      else
        if sDriver = 'MSSQL' then
         begin
           SQL.Add(' SELECT COUNT(*) AS NUM_REGS  ');
           SQL.Add('   FROM sysobjects            ');
           SQL.Add('  WHERE UPPER(name) = UPPER(:Nombre_Tabla)  ');
         end
        else
         begin
            sModulo_Err := 'Sistema';
            sString_Err := 'No existe driver (Tipo de Base de Datos) o no esta definido '+sDriver;
            bExiste := False;
            Result  := False;
            exit;
         end;
      ParamByName('Nombre_Tabla').AsString := sNombre_Tabla;
      Open;
      bExiste := (FieldByName('NUM_REGS').AsFloat > 0);
      Close;
   end;
end;

function leer_cond_pago(sEmpresa:String;fDir:Double;sSistema:String;sCond_Pago:String): Boolean;
begin
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Descripcion ');
      SQL.Add('  FROM QS_SYS_COND_PAGO');
      SQL.Add(' WHERE Codigo_Identidad = :Empresa ');
      SQL.Add('   AND Item_Dir         = :Direccion ');
      SQL.Add('   AND Sistema          = :Sistema ');
      SQL.Add('   AND Condicion_Pago   = :Cond_Pago ');
      ParamByName('Empresa').AsString   := sEmpresa;
      ParamByName('Direccion').AsFLoat  := fDir;
      ParamByName('Sistema').AsString   := sSistema;
      ParamByName('Cond_Pago').AsString := sCond_Pago;
      Open;
      if not Eof then
         Result := True
      else
         Result := False;
      Close;
   end;
end;

Procedure Existe_param_proceso(sCod_Proceso  : String;
                               sParametro    : String;
                               sValor        : String;
                               var result    : boolean);
begin
    Result := False;
    with DataModule_Comun.Qry_General do
    begin
      sql.Clear;
      sql.Add('SELECT valor FROM qs_sys_param_proceso '
             +' WHERE Proceso   = :Proceso '
             +'   AND Parametro = :Parametro '
             );
      if sValor <> '' then
         sql.Add('   AND Valor     = :Valor '  );
      ParamByName('Proceso'  ).AsString  := sCod_Proceso;
      ParamByName('Parametro').AsString  := sParametro;
      if sValor <> '' then
         ParamByName('Valor'    ).AsString  := sValor;
      Open;

      if NOT FieldByName('Valor').IsNull then
         result := True;
      Close;
    end;
end;

Function CastigaMoneda_Tsa(Moneda : String; String_Arr : TArr100_String):Boolean;
Var i : Integer;
Begin
    CastigaMoneda_Tsa := True;
    for i := 1 to 100 do
    begin
        if String_Arr[i] = '' Then
           break;
        if Moneda = String_Arr[i] Then
        begin
           CastigaMoneda_Tsa := false;
           break;
        end;
    end;
end;

function Busca_Imp_Nem(sNemotecnico : String;
                       dFecha       : TDateTime): String;
begin
   WITH DataModule_Comun.QRY_General do
   begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT IMPUESTO ');
       SQL.Add('  FROM QS_CON_IMPUESTO_NEM ');
       SQL.Add(' WHERE NEMOTECNICO   = :NEMOTECNICO ');
       SQL.Add('   AND FECHA_DESDE  = (SELECT MAX(FECHA_DESDE)');
       SQL.Add('                         FROM QS_CON_IMPUESTO_NEM');
       SQL.Add('                        WHERE NEMOTECNICO   = :NEMOTECNICO');
       SQL.Add('                          AND FECHA_DESDE  <= :FECHA');
       SQL.Add('                          AND (FECHA_HASTA >= :FECHA OR FECHA_HASTA IS NULL))');
       SQL.Add('   AND (FECHA_HASTA >= :FECHA OR FECHA_HASTA IS NULL) ');
       ParamByName('NEMOTECNICO').AsString := sNemotecnico;
       ParamByName('FECHA').AsDate     := dFecha;
       Prepare;
       Open;
       if NOT FieldByName('IMPUESTO').IsNull then
          Result := FieldByName('IMPUESTO').AsString
       else
          Result := '';
       Close;
   end;
end;

Procedure leer_avaluo_nemotecnico(sNemotecnico : String;
                                  dFecha       : TDateTime;
                                  Var sMoneda_Avaluo : String;
                                  Var fMonto_Avaluo  : Double;
                                  var bResult        : Boolean);
begin
   bResult := False;
   WITH DataModule_Comun.QRY_General do
   begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT MONEDA, MONTO_AVALUO ');
       SQL.Add('  FROM QS_SUP_AVALUO_NEMOS ');
       SQL.Add(' WHERE NEMOTECNICO  = :NEMOTECNICO ');
       SQL.Add('   AND FECHA_DESDE  = (SELECT MAX(FECHA_DESDE)');
       SQL.Add('                         FROM QS_SUP_AVALUO_NEMOS');
       SQL.Add('                        WHERE NEMOTECNICO   = :NEMOTECNICO');
       SQL.Add('                          AND FECHA_DESDE  <= :FECHA');
       SQL.Add('                          AND (FECHA_HASTA >= :FECHA OR FECHA_HASTA IS NULL))');
       SQL.Add('   AND (FECHA_HASTA >= :FECHA OR FECHA_HASTA IS NULL) ');

       ParamByName('NEMOTECNICO').AsString := sNemotecnico;
       ParamByName('FECHA').AsDate         := dFecha;

       Open;
       if NOT FieldByName('MONEDA').IsNull then
       begin
          sMoneda_Avaluo := FieldByName('MONEDA').AsString;
          fMonto_Avaluo  := FieldByName('MONTO_AVALUO').AsFloat;
          bResult        := True;
       end;
       Close;
   end;
end;

Function Verifica_Licencia(sEmpresa,
                           sModulo :String):Boolean;
Var sDato : String;
    String_Dato : TArr100_String;
    dFecha_Licencia     : TDateTime;
    dFecha_Hoy          : TDateTime;
    Days, Month, Year   : Word;
    Licencia            : Boolean;

    sModulo_Err         : String;
    sString_Err         : String;
    bExiste             : Boolean;
    bExige_Licencia     : Boolean;
    sRazon_Social       : String;
Begin
   Licencia := False;

   // Verifica licencia de este modulo
   with DataModule_Comun.QryLicencia do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT EMPRESA_LOGIN FROM QS_SYS_LOGIN');
      Open;
      bExige_Licencia := False;
      WHILE NOT EOF do
      begin
         if (sEmpresa = 'PRINCIPAL')  or
            (sEmpresa = 'QBE_CHILE')  or
            (sEmpresa = 'ORION')      or
            //(sEmpresa = 'COFACE')     or
            (sEmpresa = 'RIGEL')      or
            (sEmpresa = 'OHIO-PERU')  or
            (sEmpresa = 'VIDACM')     or
            (sEmpresa = 'ALEMANA')    or
            (sEmpresa = 'SEGUROSCLC') or
            (sEmpresa = 'FCVIDA') or
            (sEmpresa = 'SUAVAL')     then
         begin
           bExige_Licencia := True;
           Break;
         end;
         Next;
      end;
      Close;
   end;

   if not bExige_Licencia then
   begin
      Licencia          := True;
      Verifica_Licencia := True;
   end
   else
   begin
      if sModulo <> '' then
         sRazon_Social := sModulo
      else
         with DataModule_Comun.QryLicencia do
         begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT RAZON_SOCIAL_PAT FROM QS_SYS_IDENTIDAD');
            SQL.Add(' WHERE CODIGO_IDENTIDAD = :empresa');
            ParamByName('empresa').AsString := sEmpresa_Usuario;
            Open;
            sRazon_Social := FieldByName('RAZON_SOCIAL_PAT').AsString;
            sModulo       := FieldByName('RAZON_SOCIAL_PAT').AsString;
            Close;
         end;
      Existe_Tabla_en_Base_de_datos( sDriver
                                    ,'QS_SYS_LICENCIAS'
                                    ,sModulo_Err
                                    ,sString_Err
                                    ,bExiste
                                    ,Result);
      if NOT bExiste then
      begin
         Verifica_Licencia := Licencia;
         exit;
      end;
      // Elimina caracteres no validos para encriptacion.
      sDato := StrRemove(sEmpresa, ' ');
      sEmpresa := sDato;
      sDato := StrRemove(sEmpresa, '.');
      sEmpresa := sDato;
      sDato := StrRemove(sModulo, ' ');
      sModulo := sDato;
      sDato := StrRemove(sModulo, '.');
      sModulo := sDato;
      With DataModule_Comun.QryLicencia do
      begin
         SQL.Clear;
         SQL.Add('SELECT * FROM QS_SYS_LICENCIAS');
         Close;
         Prepare;
         Open;
         While (Not eof) do // and Not Licencia   Do
         Begin
            sDato := encripta132('D',FieldByName('licencia').AsString);
            Separa_Campos_String(';',' ',sDato,String_Dato);
            Days  := strtoint(trim(copy(String_Dato[2],1,2)));
            Month := strtoint(trim(copy(String_Dato[2],4,2)));
            Year  := strtoint(trim(copy(String_Dato[2],7,4)));
            dFecha_Licencia := EncodeDate( Year, Month, Days);
            dFecha_Hoy      := fecha_hora_Servidor;
            dFecha_Hoy      := solo_fecha(fecha_hora_Servidor);
            if (trim(String_Dato[1])    =  trim(sEmpresa))     and
               (trim(String_Dato[3])    =  trim(sModulo))      and
               (dFecha_Licencia   >= dFecha_Hoy )  Then
            begin
                Licencia := True;
                Break;
            end;
            Next;
         end;
         Verifica_Licencia := Licencia;
         Close;
         UnPrepare;
      end;
   end;
   if not Licencia then
      Application.MessageBox(pChar(' No se encontró Licencia Vigente para: ' + sEmpresa_Usuario+' - '+sRazon_Social)
                            ,'Verifica Licencia'
                            ,Mb_ok + MB_ICONINFORMATION);
end;


Procedure Graba_Archivo_Texto(sFile, sMensaje :String);
Var
  ArchivoTexto : TextFile;

Begin
   AssignFile(ArchivoTexto, sFile);
   ReWrite(ArchivoTexto);
   Writeln(ArchivoTexto,Trim(sMensaje));
   CloseFile(ArchivoTexto);
End;

function Ano_Visiesto(ano:word): boolean;
 var resto  :integer;
begin
   Result := False;
   {determinacion de áno bisiesto}
   resto := ano div 4;
   if (ano * 4) = (resto * ano) then
      Result := true;
end;

Procedure Ubicacion_Funcional(sEmpresa        : String;
                              fNodo_Funcional : Double;
                          var sUbicacion      : String;
                          var result          : boolean);
begin
   Result     := False;
   sUbicacion := '';
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Descripcion ');
      SQL.Add('  FROM QS_SYS_ID_ESTFUND ');
      SQL.Add(' WHERE Codigo_Identidad = :Codigo_Identidad ');
      SQL.Add('   AND Codigo_Nodo      = :Codigo_Nodo ');        //SQL.Add('   AND Nodo_EstFun      = :Nodo_EstFun ');
      ParamByName('Codigo_Identidad').AsString := trim(sEmpresa);
      ParamByName('Codigo_Nodo').AsFloat       := fNodo_Funcional;   //      ParamByName('Nodo_EstFun').AsFloat       := fNodo_Funcional;
      Open;
      if NOT FieldByName('Descripcion').IsNull then
      begin
         Result     := True;
         sUbicacion := FieldByName('Descripcion').AsString;
      end;
      Close;
   end;
end;

function valida_solocaract_password(spassword : String):Boolean;   //DC 15/06/2011
var
  i            :integer;
  sStr_nro
 ,sStr_letra   :String;
  existe_nro   :Boolean;
begin
  Result       := False;
  i            := 1;
  existe_nro   := False;
  sStr_nro     := '0123456789';
  sStr_letra   := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

  while i <= length(spassword) do
  begin
    if pos(Copy(spassword,i,1),sStr_nro) > 0 then
       existe_nro := True;

    if pos(Copy(spassword,i,1),sStr_letra) = 0 then
       existe_nro := True;

    i := i + 1;
  end;

  if Not existe_nro then
     Result := True;
end;

function valida_caract_password(spassword : String):Boolean;   //DC 02/12/2008
var
  i             :integer;
  sStr_nro,sStr_letra   :String;
  existe_nro
 ,existe_letra  :Boolean;
begin
  Result       := False;
  i            := 1;
  existe_nro   := False;
  existe_letra := False;
  sStr_nro     := '0123456789';
  sStr_letra   := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

  while i <= length(spassword) do
  begin
    if not existe_nro then
       if pos(Copy(spassword,i,1),sStr_nro) > 0 then
          existe_nro := True;

    if not existe_letra then
       if pos(Copy(spassword,i,1),sStr_letra) > 0 then
          existe_letra := True;

    if (existe_nro and existe_letra) then
       Result := True;

    i := i + 1;
  end;
end;

function existe_crypt(sEmpresa  : String):Boolean;   //DC 09/1/2009
begin
   Result     := False;
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT valor ');
      SQL.Add('  FROM QS_SYS_PARAM_PROCESO ');
      SQL.Add(' WHERE parametro = :Parametro ');

      ParamByName('Parametro').AsString := 'PASSWORD';

      Open;

      if NOT FieldByName('valor').IsNull then
         Result     := True;

      Close;
   end;
end;

Procedure Busca_Datos_Universales(Empresa           :String;
                                  Transaccion       :String;
                                  Folio             :String;
                                  Item              :double;
                                  Codigo            :String;
                                  Fecha_Proceso     :tdatetime;
                                  Var CodigoRetorno :String);
//Var
//   Qry_Datos_Universales  : TFDQuery;
Begin
   try
//      Qry_Datos_Universales := TFDQuery.Create(Application);
      with DataModule_Comun.Qry_Datos_Universales do
      begin
//         Connection := dmBaseDatos.Conexion_BaseDatos;
//         SQL.Clear;
//         SQL.Add(' SELECT * FROM QS_TRA_OMD_DATADI_UNI  ');
//         SQL.Add('  WHERE Folio_Interno  = :Folio       ');
//         SQL.Add('    and item_omd       = :item        ');
//         SQL.Add('    and Transaccion    = :Transaccion ');
//         SQL.Add('    and empresa        = :empresa     ');
//         SQL.Add('    and tipo_dato      = :Codigo      ');
//         SQL.Add('    AND Fecha_Desde <= :Fecha_Proceso ');
//         SQL.Add('    AND (Fecha_Hasta >= :Fecha_Proceso OR Fecha_Hasta IS NULL)  ');

         Close;
         ParamByName('Folio').AsString           := Folio;
         ParamByName('Item').AsFloat             := Item;
         ParamByName('Transaccion').AsString     := Transaccion;
         ParamByName('Empresa').AsString         := Empresa;
         ParamByName('Codigo').AsString          := Codigo;
         ParamByName('Fecha_Proceso').AsDate := Fecha_Proceso;
         open;
         CodigoRetorno:='';
         if not eof then
            CodigoRetorno := FieldByName('VALOR').AsString;
      end;
   finally
      DataModule_Comun.Qry_Datos_Universales.Close;
//      Qry_Datos_Universales.UnPrepare;
//      Qry_Datos_Universales.Free;
   end;
End;

Procedure Busca_Datos_Universales_RV(Empresa           : String    ;
                                     Cartera           : String    ;
                                     Transaccion       : String    ;
                                     Nemotecnico       : String    ;
                                     Codigo            : String    ;
                                     Fecha_Proceso     : tdatetime ;
                                     Var CodigoRetorno : String    );
Var
   Qry_Datos_Universales  : TFDQuery;
Begin
   try
      Qry_Datos_Universales := TFDQuery.Create(Application);
      with Qry_Datos_Universales do
      begin
         Connection := dmBaseDatos.Conexion_BaseDatos;
         SQL.Clear;
         SQL.Add(' SELECT a.* ');
         SQL.Add('   FROM QS_TRA_OMD_DATADI_UNI a ');
         SQL.Add('       ,QS_TRA_OMD_DET_RF b ');
         SQL.Add('  WHERE a.empresa        = :empresa     ');
         SQL.Add('    and a.Transaccion    = :Transaccion ');
         SQL.Add('    and a.tipo_dato      = :Codigo      ');
         SQL.Add('    AND a.FOLIO_INTERNO NOT IN (SELECT E.FOLIO                      ');
         SQL.Add('    				  FROM QS_CTR_ANULACION E             ');
         SQL.Add('    				 WHERE E.FOLIO       = a.FOLIO_INTERNO');
         SQL.Add('    				   AND E.TRANSACCION = a.TRANSACCION  ');
         SQL.Add('    				   AND E.EMPRESA     = a.EMPRESA  )   ');
         SQL.Add('    and a.empresa        = b.empresa     ');
         SQL.Add('    and a.Transaccion    = b.Transaccion ');
         SQL.Add('    and a.folio_interno  = b.folio_interno ');
         SQL.Add('    and a.Item_Omd       = b.Item_Omd ');
         SQL.Add('    and b.Nemotecnico    = :Nemotecnico      ');
         if Cartera <> '' then
            SQL.Add(' AND b.CARTERA        = :CARTERA     ');
         SQL.Add('    AND a.FECHA_DESDE = (SELECT MAX(F.FECHA_OPERACION) ');
         SQL.Add('	  		      FROM QS_TRA_OMD F          ');
         SQL.Add('			          ,QS_TRA_OMD_DET_RF H          ');
         SQL.Add('			     WHERE H.NEMOTECNICO = b.nemotecnico ');
         SQL.Add('			       AND H.TRANSACCION = b.transaccion ');
         SQL.Add('			       AND H.Cartera     = b.Cartera     ');
         SQL.Add('			       AND H.EMPRESA     = b.EMPRESA     ');
         SQL.Add('   			       AND H.FOLIO_INTERNO NOT IN (SELECT G.FOLIO                       ');
         SQL.Add('    				  		  	     FROM QS_CTR_ANULACION G            ');
         SQL.Add('    				 			    WHERE G.FOLIO = H.FOLIO_INTERNO     ');
         SQL.Add('    				   			      AND G.TRANSACCION = H.TRANSACCION ');
         SQL.Add('    				   			      AND G.EMPRESA = H.EMPRESA )        ');
         SQL.Add('                              AND F.FOLIO_INTERNO = H.FOLIO_INTERNO ');
         SQL.Add('                              AND F.TRANSACCION = H.TRANSACCION     ');
         SQL.Add('                              AND F.EMPRESA = H.EMPRESA             ');
         SQL.Add('                              AND F.FECHA_OPERACION <= :FECHA       ');
         SQL.Add('	                    )                                       ');


         ParamByName('Empresa').AsString         := Empresa;
         ParamByName('Transaccion').AsString     := Transaccion;
         if Cartera <> '' then
            ParamByName('Cartera').AsString      := cartera;
         ParamByName('Nemotecnico').AsString     := Nemotecnico;
         ParamByName('Codigo').AsString          := Codigo;
         ParamByName('FECHA').AsDate         := Fecha_Proceso;
         open;
         CodigoRetorno:='';
         if not eof then
            CodigoRetorno := FieldByName('VALOR').AsString;
      end;
   finally
      Qry_Datos_Universales.Close;
      Qry_Datos_Universales.UnPrepare;
      Qry_Datos_Universales.Free;
   end;
End;

Function Graba_Datos_Universales(Empresa       :String;
                                 Transaccion   :String;
                                 Folio         :String;
                                 Item          :double;
                                 Codigo        :String;
                                 Fecha_Proceso :tdatetime;
                                 CodigoRetorno :String) :Boolean;
begin
  Result := True;
  With DataModule_Comun.Qry_General do
  begin
     SQL.Clear;
     SQL.Add('DELETE FROM QS_TRA_OMD_DATADI_UNI '
            +' WHERE Folio_Interno = :Folio_Interno '
            +'   AND Item_OMD      = :Item_OMD '
            +'   AND Transaccion   = :Transaccion '
            +'   AND Empresa       = :Empresa '
            +'   AND Tipo_Dato     = :Tipo_Dato ');
     ParamByName('Empresa'      ).AsString := Empresa;
     ParamByName('Transaccion'  ).AsString := Transaccion;
     ParamByName('Folio_Interno').AsString := Folio;
     ParamByName('Item_OMD'     ).AsFloat  := Item;
     ParamByName('Tipo_Dato'    ).AsString := Codigo;
     try
       ExecSql
      except on E: EFDDBEngineException do
       begin
          Result := True;
          ShowError(E);
          Close;
          Exit;
       end;
     end;
     Close;
     SQL.Clear;
     SQL.Add('INSERT INTO QS_TRA_OMD_DATADI_UNI '
            +'(EMPRESA'
            +',TRANSACCION'
            +',FOLIO_INTERNO'
            +',ITEM_OMD'
            +',TIPO_DATO'
            +',FECHA_DESDE');
     SQL.Add(',VALOR)'
            +'VALUES '
            +'(:EMPRESA'
            +',:TRANSACCION'
            +',:FOLIO_INTERNO'
            +',:ITEM_OMD'
            +',:TIPO_DATO'
            +',:FECHA_DESDE');
     SQL.Add(',:VALOR) ');
     ParamByName('Empresa'      ).AsString   := Empresa;
     ParamByName('Transaccion'  ).AsString   := Transaccion;
     ParamByName('Folio_Interno').AsString   := Folio;
     ParamByName('Item_OMD'     ).AsFloat    := Item;
     ParamByName('Tipo_Dato'    ).AsString   := Codigo;
     ParamByName('Fecha_Desde'  ).AsDateTime := Fecha_Proceso;
     ParamByName('VALOR'        ).AsString   := CodigoRetorno;
     Prepare;
     try
       ExecSql
      except on E: EFDDBEngineException do
       begin
          Result := True;
          ShowError(E);
          Close;
          Exit;
       end;
     end;
     Close;
  end;
end;

Function No_Custodiable(  sTransaccion,
                          sFolio_Interno : String;
                          fItem_Omd      : Double;
                          dFecha_Proceso : TdateTime
                          ) : Boolean;
begin
  Result :=  False;
  With DataModule_Comun.Qry_General do
  begin
      Sql.Clear;
      SQL.Add(' SELECT Folio_Interno'
             +'        FROM QS_SUP_EXCP_CUSTODIA'
             +' WHERE Empresa       = :Empresa'
             +'   AND Fecha_Cierre  = :Fecha_Cierre'
             +'   AND Transaccion   = :Transaccion'
             +'   AND Folio_Interno = :Folio_Interno'
             +'   AND Item_Omd      = :Item_Omd'
            );
      ParamByName('Empresa').AsString          := sEmpresa_Usuario;
      ParamByName('Fecha_Cierre'  ).AsDate := dFecha_Proceso;
      ParamByName('Transaccion').asString      := sTransaccion;
      ParamByName('Folio_Interno').asString    := sFolio_Interno;
      ParamByName('Item_Omd').asFloat          := fItem_Omd;
      Open;
      if Not Fieldbyname('Folio_Interno').IsNull then
         Result := True;
      Close;
   end;
end;

function Leer_Clasificacion(sClasificacion : String) :Boolean;
begin
  Result :=  False;
  With DataModule_Comun.Qry_General do
  begin
      Sql.Clear;
      SQL.Add(' SELECT *'
             +'   FROM QS_SYS_CLASIFICA '
             +' WHERE Codigo_Objeto = :Codigo_Objeto'
            );
      ParamByName('Codigo_Objeto').AsString := sClasificacion;
      Open;
      if Not eof then
         Result := True;
      Close;
   end;
end;

procedure Deterioro_Provision(sEmpresa,
                              sTransaccion,
                              sFolio_Interno : String;
                              fItem_Omd      : Double;
                              dFecha_Proceso : TdateTime;
                              var fDet_Prov  : Double);
var
  sModulo_Error,
  sString_Error,
  sMoneda_Nacional     :String;
  Result               :Boolean;
begin
  With DataModule_Comun.Qry_Deterioro do
  begin
    Close;
    Sql.Clear;
    SQL.Add(' SELECT a.*'
           +'   FROM QS_RES_PROV_IMPAIRMENT a '
           +' WHERE a.empresa       = :empresa'
           +'   AND a.transaccion   = :transaccion'
           +'   AND a.folio_interno = :folio_interno'
           +'   AND a.item_omd      = :item_omd'
           +'   AND a.fecha_desde  = :fecha_cierre'
          );

    ParamByName('empresa').AsString       := sEmpresa;
    ParamByName('transaccion').AsString   := sTransaccion;
    ParamByName('folio_interno').AsString := sFolio_Interno;
    ParamByName('item_omd').AsFloat       := fItem_Omd;
    ParamByName('fecha_cierre').AsDate:= dFecha_Proceso;
    Open;

    if recordcount = 0 then
    begin
      Sql.Clear;
      SQL.Add(' SELECT a.PROVISION_MC'
             +'   FROM QS_RES_PROVISION a '
             +'  WHERE a.empresa       = :empresa'
             +'    AND a.fecha_cierre  = :fecha_cierre'
             +'    AND a.transaccion   = :transaccion'
             +'    AND a.folio_interno = :folio_interno'
             +'    AND a.item_omd      = :item_omd'
            );

      ParamByName('empresa').AsString       := sEmpresa;
      ParamByName('transaccion').AsString   := sTransaccion;
      ParamByName('folio_interno').AsString := sFolio_Interno;
      ParamByName('item_omd').AsFloat       := fItem_Omd;
      ParamByName('fecha_cierre').AsDate  := dFecha_Proceso;
      Open;

      fDet_Prov := DataModule_Comun.Qry_Deterioro.FieldByName('PROVISION_MC').AsFloat;
    end
    else
    begin
      fDet_Prov        := DataModule_Comun.Qry_Deterioro.FieldByName('Valor').AsFloat;
      sMoneda_Nacional := moneda_nacional_pais_Usuario(sPais_Usuario);

      conversion_unidad_mon(DataModule_Comun.Qry_Deterioro.FieldByName('Moneda').AsString
                           ,sMoneda_Nacional
                           ,'BC'
                           ,dFecha_Proceso
                           ,fDet_Prov
                           ,fDet_Prov
                           ,sModulo_Error
                           ,sString_Error
                           ,Result);

      if DataModule_Comun.Qry_Deterioro.FieldByName('CODIGO_PROCESO').AsString = 'DET_ADIC' then
      begin
        Sql.Clear;
        SQL.Add(' SELECT a.PROVISION_MC'
               +'   FROM QS_RES_PROVISION a '
               +'  WHERE a.empresa       = :empresa'
               +'    AND a.fecha_cierre  = :fecha_cierre'
               +'    AND a.transaccion   = :transaccion'
               +'    AND a.folio_interno = :folio_interno'
               +'    AND a.item_omd      = :item_omd'
              );

        ParamByName('empresa').AsString       := sEmpresa;
        ParamByName('transaccion').AsString   := sTransaccion;
        ParamByName('folio_interno').AsString := sFolio_Interno;
        ParamByName('item_omd').AsFloat       := fItem_Omd;
        ParamByName('fecha_cierre').AsDate  := dFecha_Proceso;
        Open;

        fDet_Prov := fDet_Prov + DataModule_Comun.Qry_Deterioro.FieldByName('PROVISION_MC').AsFloat;
      end
      else
      begin
        if DataModule_Comun.Qry_Deterioro.FieldByName('CODIGO_PROCESO').AsString = 'DET_TOTAL' then
        begin
          Sql.Clear;
          SQL.Add(' SELECT a.PROVISION_MC'
                 +'   FROM QS_RES_PROVISION a '
                 +'  WHERE a.empresa       = :empresa'
                 +'    AND a.fecha_cierre  = :fecha_cierre'
                 +'    AND a.transaccion   = :transaccion'
                 +'    AND a.folio_interno = :folio_interno'
                 +'    AND a.item_omd      = :item_omd'
                );

          ParamByName('empresa').AsString       := sEmpresa;
          ParamByName('transaccion').AsString   := sTransaccion;
          ParamByName('folio_interno').AsString := sFolio_Interno;
          ParamByName('item_omd').AsFloat       := fItem_Omd;
          ParamByName('fecha_cierre').AsDate  := dFecha_Proceso;
          Open;

          if fDet_Prov < DataModule_Comun.Qry_Deterioro.FieldByName('PROVISION_MC').AsFloat then
             fDet_Prov := DataModule_Comun.Qry_Deterioro.FieldByName('PROVISION_MC').AsFloat;
        end;
      end;
    end;
    Close;
  end;
end;

procedure Detalle_OMD_Re_Allocation(dFecha     : TDateTime;
                                    sCondicion : String;
                                    bValorizacion,         // para saber si viene desde el proceso de valorizacion, si es True solo requerimos las compras
                                    bRenta_Variable,       // para saber si toma o no Renta Variable
                                    bPactos_RV,            // para saber si incluye Pactos de Renta Variable
                                    bSeleccion_Ventas,     // para saber si incluye las ventas con pacto de Renta Fija
                                    bIncluye_Vencidos : Boolean);
var bCondicion      : Boolean;
    dfecha_creacion : TDateTime;
    bTransaccion     : Boolean;
    sImplicancia_Compra : String;
    sImplicancia_RV     : String;
    sImplicancia_Derivado : String;
    sImplicancia_Venta  : String;
    sImplicancia_Pacto  : String;
    bInsertados         : Boolean;

    fItem_recursivo     : Double;

    String_Arr         : TArr100_String;
    sCondicion_Omd     : String;
    sCondicion_Traza   : String;
begin
   bTransaccion := false;
   if sCondicion = '1=1' then
      bCondicion := false
   else
   begin
      bCondicion := true;
      Separa_Campos_String('|'
                          ,'@'
                          ,sCondicion
                          ,String_Arr);
       sCondicion_Omd   := String_Arr[1];
       if (String_Arr[2] <> null) and (String_Arr[2] <> '') then
          sCondicion_Traza := String_Arr[2]
       else
          sCondicion_Traza := String_Arr[1];
   end;

   if bValorizacion then
   begin
      sImplicancia_Compra   := LLena_String_Implicancia('COMPRA');
      sImplicancia_RV       := LLena_String_Implicancia('RV');
      sImplicancia_Derivado := LLena_String_Implicancia('DERIVADO');
   end;
   sImplicancia_Venta    := LLena_String_Implicancia('VENTA');
   sImplicancia_Pacto    := LLena_String_Implicancia('PACTO');

   dfecha_creacion := fecha_hora_servidor;

   // Maneja transaccion corta 25-04-2012 G.G. & F.I.
   if (NOT dmBaseDatos.conexion_basedatos.InTransaction) then
      dmBaseDatos.conexion_basedatos.StartTransaction
   else
      bTransaccion := true;

   with DataModule_Comun.Qry_General do
   begin

      // Borra los registros anteriores
      Borra_OMD_Re_Allocation(dFecha);
      Application.ProcessMessages;


      if sDriver = 'MSSQL' then
      begin
         Sql.Clear;
         Sql.add(' SET DATEFORMAT dmy ');
         ExecSQL;
      end;

      // -- nunca fue reallocado
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLOCATION1 '
						+' SELECT B.EMPRESA'
            +'       ,B.CARTERA'
            +'       ,B.TRANSACCION'
            +'       ,B.FOLIO_INTERNO'
						+'	     ,B.ITEM_OMD'
            +'       ,C.FECHA_OPERACION'
            +'       ,C.FECHA_OPERACION'
						+'	     ,B.VALOR_NOMINAL'
            +'       ,:Pid '
            +'       ,:Fecha_Creacion '
						+'	 FROM QS_TRA_OMD_DET_RF B'
						+'	     ,QS_TRA_OMD        C'
						//+'	WHERE C.FECHA_OPERACION <= :Fecha'
						+'  WHERE C.FOLIO_INTERNO    = B.FOLIO_INTERNO'
						+'	  AND C.TRANSACCION      = B.TRANSACCION'
						+'	  AND C.EMPRESA          = B.EMPRESA');
      if bValorizacion then
      begin
         if NOT bRenta_Variable then
         begin
            SQL.Add(' AND (b.transaccion in '+sImplicancia_Compra+' OR b.transaccion in '+sImplicancia_Derivado +')' );
            SQL.Add(' AND b.TRANSACCION NOT IN '+sImplicancia_RV);
         end
         else
         begin
            SQL.Add(' AND b.TRANSACCION IN '+sImplicancia_Compra);     // Incluye RF y RV
         end;
         SQL.Add(' AND c.folio_interno NOT IN (SELECT e.folio');
         SQL.Add('                               FROM qs_ctr_anulacion e');
         SQL.Add('                              WHERE e.folio       = c.folio_interno');
         SQL.Add('                                AND e.empresa     = c.empresa');
         SQL.Add('                                AND e.transaccion = c.transaccion)');
      end;
			SQL.Add('	  AND NOT EXISTS (SELECT X.*'
             +'	                    FROM QS_TRA_OMD_TRAZA X'
				  	 +'	  				         WHERE X.FOLIO_INTERNO_OMD = B.FOLIO_INTERNO'
				 	   +'	  				           AND X.ITEM_MOVIMIENTO   = B.ITEM_OMD'
						 +'	  				           AND X.TRANSACCION_OMD   = B.TRANSACCION'
						 +'	  				           AND X.EMPRESA           = B.EMPRESA)');
      if bCondicion then
         SQL.Add(' AND '+sCondicion_Omd );
      //ParamByName('Fecha').AsDate              := dFecha;
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- nunca fue reallocado antes pero si en el futuro  (paso 1)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLOCATION1A '
						 +'SELECT A.EMPRESA'
             +'      ,A.TRANSACCION_OMD'
             +'      ,A.FOLIO_INTERNO_OMD'
						 +'      ,A.ITEM_OMD');
      if sDriver = 'ORACLE' then
         SQL.Add('   ,MIN(TO_NUMBER(A.FOLIO_INTERNO))')
      else
         SQL.Add('   ,MIN(CAST(A.FOLIO_INTERNO AS INTEGER))');
      SQL.Add('      ,NULL as FECHA_MOVIMIENTO'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
  					 +'	  FROM QS_TRA_OMD_TRAZA  A '
             +'       ,QS_TRA_OMD        C ');
      if sDriver = 'ORACLE' then
         SQL.Add(' WHERE TO_NUMBER(a.FOLIO_INTERNO_OMD) NOT IN (SELECT (TO_NUMBER(X.FOLIO_INTERNO_OMD))')
      else
         SQL.Add(' WHERE CAST(a.FOLIO_INTERNO_OMD AS INTEGER) NOT IN (SELECT (CAST(X.FOLIO_INTERNO_OMD AS INTEGER))');
			SQL.Add('		                                              FROM QS_TRA_OMD_TRAZA X'
						 +'			                                           WHERE X.FOLIO_INTERNO_OMD  = A.FOLIO_INTERNO_omd'
						 +'			 	                                           AND X.ITEM_OMD           = A.ITEM_OMD'
						 +'			 	                                           AND X.TRANSACCION_OMD    = A.TRANSACCION_OMD'
						 +'			 	                                           AND X.EMPRESA            = A.EMPRESA'
						 +'			 	                                           AND X.FECHA_MOVIMIENTO  <= :Fecha)'
             +'      AND A.ITEM_OMD NOT IN (SELECT x.ITEM_MOVIMIENTO'
             +'                               FROM QS_TRA_OMD_TRAZA x'
             +'                              WHERE x.FOLIO_INTERNO_OMD = A.FOLIO_INTERNO_OMD'
             +'                                AND x.ITEM_MOVIMIENTO   = A.ITEM_OMD'
             +'                                AND x.TRANSACCION_OMD   = A.TRANSACCION_OMD'
             +'                                AND x.EMPRESA_OMD       = A.EMPRESA_OMD'
             +'                                AND x.CARTERA_ORIGEN_MOV <> x.CARTERA_MOVIMIENTO'
             //+'                                AND x.ITEM_OMD         <> x.ITEM_MOVIMIENTO'
             //+'                                AND x.FECHA_MOVIMIENTO <= A.FECHA_MOVIMIENTO)');
             //ggarcia 20-07-2020
             //+'                                AND x.FECHA_MOVIMIENTO   < A.FECHA_MOVIMIENTO)');
             +'                                AND x.FECHA_MOVIMIENTO  <= A.FECHA_MOVIMIENTO');

      if sDriver = 'ORACLE' then
         SQL.Add('		                         AND TO_NUMBER(x.FOLIO_INTERNO) <  TO_NUMBER(A.FOLIO_INTERNO))')
      else
         SQL.Add('		                         AND CAST(x.FOLIO_INTERNO AS INTEGER) <  CAST(A.FOLIO_INTERNO AS INTEGER))');

      if bValorizacion then
      begin
         if NOT bRenta_Variable then
         begin
            SQL.Add(' AND a.TRANSACCION_OMD IN '+sImplicancia_Compra);
            SQL.Add(' AND a.TRANSACCION_OMD NOT IN '+sImplicancia_RV);
         end
         else
         begin
            SQL.Add(' AND a.TRANSACCION_OMD IN '+sImplicancia_Compra);     // Incluye RF y RV
         end;
         SQL.Add(' AND a.folio_interno_Omd NOT IN (SELECT e.folio');
         SQL.Add('                               FROM qs_ctr_anulacion e');
         SQL.Add('                              WHERE e.folio       = a.folio_interno_omd');
         SQL.Add('                                AND e.empresa     = a.empresa');
         SQL.Add('                                AND e.transaccion = a.transaccion_omd)');
      end;
      SQL.Add('   AND C.folio_interno = a.folio_interno_omd '
             +'   AND C.transaccion   = a.transaccion_omd '
             +'   AND C.empresa       = a.empresa_omd ');
      if bCondicion then
         SQL.Add(' AND '+sCondicion_Traza );
      SQL.Add('    GROUP BY A.EMPRESA'
             +'            ,A.TRANSACCION_OMD'
             +'            ,A.FOLIO_INTERNO_OMD'
             +'            ,A.ITEM_OMD');
      ParamByName('Fecha').AsDate              := dFecha;
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- nunca fue reallocado antes pero si en el futuro  (paso 2)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLOCATION1B '
             +'SELECT A.EMPRESA'
						 +'	     ,C.CARTERA_ORIGEN_MOV'
             +'      ,A.TRANSACCION_OMD'
             +'      ,A.FOLIO_INTERNO_OMD'
             +'      ,A.ITEM_OMD'
             +'      ,B.FECHA_OPERACION'
             +'      ,A.FOLIO_INTERNO'
             +'      ,C.FECHA_MOVIMIENTO'
             +'      ,SUM(C.VALOR_NOMINAL)'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'	 FROM QS_TEMP_REALLOCATION1A A'
						 +'      ,QS_TRA_OMD             B'
             +'      ,QS_TRA_OMD_TRAZA       C'
						 +' WHERE B.FECHA_OPERACION <= :Fecha '
						 +'   AND A.PID              = :pid '
             +'   AND B.FOLIO_INTERNO    = A.FOLIO_INTERNO_omd'
						 +'	  AND B.TRANSACCION      = A.TRANSACCION_omd'
						 +'	  AND B.EMPRESA          = A.EMPRESA'
					   +'	  AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION '
					 	 +'	                              FROM QS_SYS_TRAN_IMPLIC X '
						 +'	   				                   WHERE X.IMPLICANCIA = ''RV'') '
						 +'	  AND B.TRANSACCION IN (SELECT X.CODIGO_TRANSACCION '
						 +'	                          FROM QS_SYS_TRAN_IMPLIC X '
						 +'	  	 				             WHERE X.IMPLICANCIA = ''COMPRA'') '
						 +'	  AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION '
						 +'	                              FROM QS_SYS_TRAN_IMPLIC X '
						 +'	  					                 WHERE X.IMPLICANCIA = ''PACTO'') '
						 +'	  AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO '
						 +'	                                FROM QS_CTR_ANULACION E '
						 +'	                               WHERE E.FOLIO       = B.FOLIO_INTERNO '
						 +'	                                 AND E.EMPRESA     = B.EMPRESA '
						 +'	                                 AND E.TRANSACCION = B.TRANSACCION) '
             +'   AND C.FOLIO_INTERNO     = A.FOLIO_INTERNO'
             +'   AND C.FOLIO_INTERNO_OMD = A.FOLIO_INTERNO_OMD'
             +'   AND C.ITEM_OMD          = A.ITEM_OMD'
             +'   AND C.EMPRESA           = A.EMPRESA'
             +' GROUP BY A.EMPRESA'
						 +'         ,C.CARTERA_ORIGEN_MOV'
             +'         ,A.TRANSACCION_OMD'
             +'         ,A.FOLIO_INTERNO_OMD'
             +'         ,A.ITEM_OMD'
             +'         ,B.FECHA_OPERACION'
             +'         ,A.FOLIO_INTERNO'
             +'         ,C.FECHA_MOVIMIENTO') ;
      ParamByName('Fecha').AsDate              := dFecha;
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- nunca fue reallocado antes pero si en el futuro  (paso 3)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLOCATION1C '
             +'SELECT A.EMPRESA '
						 +'	     ,A.CARTERA '
             +'      ,A.TRANSACCION '
             +'      ,A.FOLIO_INTERNO '
             +'      ,A.ITEM_OMD '
             +'      ,A.FECHA_COMPRA '
             +'      ,A.FECHA_MOVIMIENTO '
             +'      ,A.VALOR_NOMINAL '
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'  FROM QS_TEMP_REALLOCATION1B A'
						 +' WHERE A.PID = :pid ');
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- nunca fue reallocado antes pero si en el futuro  (paso 4)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLOCATION1C  '
             +'SELECT A.EMPRESA '
						 +'      ,A.CARTERA '
             +'      ,A.TRANSACCION '
             +'      ,A.FOLIO_INTERNO  '
             +'      ,A.ITEM_OMD '
             +'      ,A.FECHA_COMPRA '
             +'      ,A.FECHA_MOVIMIENTO '
             +'      ,C.VALOR_NOMINAL '
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +' FROM QS_TEMP_REALLOCATION1B A '
						 +'     ,QS_TRA_OMD             B '
						 +'     ,QS_TRA_OMD_DET_RF      C '
						 +' WHERE A.PID               = :pid '
             +'   AND c.folio_interno_rel = a.folio_interno  '
						 +'   AND c.item_OMD_rel      = a.item_OMD '
						 +'   AND c.transaccion_rel   = a.transaccion  '
						 +'   AND c.empresa_rel       = a.empresa '
						 +'   AND b.folio_interno     = c.folio_interno '
						 +'   AND b.transaccion       = c.transaccion '
						 +'   AND b.empresa           = c.empresa  '
						 +'   AND b.TRANSACCION IN (SELECT X.CODIGO_TRANSACCION '
						 +'                          FROM QS_SYS_TRAN_IMPLIC X '
						 +' 	          				    WHERE X.IMPLICANCIA = ''VENTA'') '
						 +'   AND b.FOLIO_INTERNO NOT IN (SELECT E.FOLIO '
						 +'                                 FROM QS_CTR_ANULACION E '
						 +'                                WHERE E.FOLIO       = B.FOLIO_INTERNO '
						 +'                                  AND E.EMPRESA     = B.EMPRESA '
						 +'                                  AND E.TRANSACCION = B.TRANSACCION) '
						 +'   and b.fecha_hora < (select max(x.fecha_hora) from qs_TRA_omd_traza x '
						 +' 					             where x.folio_interno_omd = a.folio_interno '
						 +' 				                 AND x.item_OMD          = a.item_OMD '
						 +' 				                 AND x.transaccion_omd   = a.transaccion '
						 +' 				                 AND x.empresa_omd       = a.empresa '
						 +' 					               and x.folio_interno     = a.folio_traza) '
						 +'	   AND b.fecha_operacion <= a.fecha_movimiento AND b.fecha_operacion > :Fecha ');
      ParamByName('Fecha').AsDate              := dFecha;
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- nunca fue reallocado antes pero si en el futuro  (paso 5)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLOCATION1 '
             +'SELECT A.EMPRESA '
						 +'      ,A.CARTERA '
             +'      ,A.TRANSACCION '
             +'      ,A.FOLIO_INTERNO '
             +'      ,A.ITEM_OMD  '
             +'      ,A.FECHA_COMPRA '
             +'      ,A.FECHA_MOVIMIENTO '
             +'      ,SUM(A.VALOR_NOMINAL) '
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'  FROM QS_TEMP_REALLOCATION1C A '
						 +' WHERE A.PID = :pid '
             +' GROUP BY A.EMPRESA '
						 +'         ,A.CARTERA '
             +'         ,A.TRANSACCION  '
             +'         ,A.FOLIO_INTERNO '
             +'         ,A.ITEM_OMD  '
             +'         ,A.FECHA_COMPRA '
             +'         ,A.FECHA_MOVIMIENTO ');
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- no tengo reallocation en el futuro pero tengo antes (paso 1)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLO_CASO3_PASO1 '
		         +'SELECT A.EMPRESA'
             +'      ,A.TRANSACCION_OMD'
             +'      ,A.FOLIO_INTERNO_OMD'
  		 	     +'      ,A.ITEM_MOVIMIENTO');
      if sDriver = 'ORACLE' then
         SQL.Add('   ,MAX(TO_NUMBER(A.FOLIO_INTERNO))')
      else
         SQL.Add('   ,MAX(CAST(A.FOLIO_INTERNO AS INTEGER))');
      SQL.Add('      ,NULL'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
  			     +'  FROM QS_TRA_OMD_TRAZA  A'
			       //+'      ,QS_TRA_OMD_DET_RF C'); //ggarcia 12-12-2019
			       +'      ,QS_TRA_OMD        C');
      if sDriver = 'ORACLE' then
         SQL.Add(' WHERE TO_NUMBER(A.FOLIO_INTERNO) NOT IN (SELECT (TO_NUMBER(X.FOLIO_INTERNO))')
      else
         SQL.Add(' WHERE CAST(A.FOLIO_INTERNO AS INTEGER) NOT IN (SELECT (CAST(X.FOLIO_INTERNO AS INTEGER))');
			SQL.Add('		                                         FROM QS_TRA_OMD_TRAZA X'
						 +'							                     		      WHERE X.FOLIO_INTERNO_OMD  = A.FOLIO_INTERNO_OMD'
						 +'							                     			      AND X.ITEM_OMD           = A.ITEM_OMD'
						 +'							                     			      AND X.TRANSACCION_OMD    = A.TRANSACCION_OMD'
						 +'							                     			      AND X.EMPRESA            = A.EMPRESA'
						 +'							                     			      AND X.FECHA_MOVIMIENTO   > :fecha)'
             +'   AND A.ITEM_OMD NOT IN (SELECT X.ITEM_MOVIMIENTO'
             +'                            FROM QS_TRA_OMD_TRAZA X'
             +'                           WHERE X.FOLIO_INTERNO_OMD = A.FOLIO_INTERNO_OMD'
             +'                             AND X.ITEM_MOVIMIENTO   = A.ITEM_OMD'
             +'                             AND X.TRANSACCION_OMD   = A.TRANSACCION_OMD'
             +'                             AND X.EMPRESA_OMD       = A.EMPRESA_OMD'
             +'                             AND X.ITEM_OMD          <> X.ITEM_MOVIMIENTO'
             +'                             AND X.FECHA_MOVIMIENTO  > A.FECHA_MOVIMIENTO)');
			if bValorizacion then
      begin
         if NOT bRenta_Variable then
         begin
            SQL.Add(' AND a.TRANSACCION_OMD IN '+sImplicancia_Compra);
            SQL.Add(' AND a.TRANSACCION_OMD NOT IN '+sImplicancia_RV);
         end
         else
         begin
            SQL.Add(' AND a.TRANSACCION_OMD IN '+sImplicancia_Compra);     // Incluye RF y RV
         end;
         SQL.Add(' AND C.folio_interno NOT IN (SELECT e.folio');
         SQL.Add('                               FROM qs_ctr_anulacion e');
         SQL.Add('                              WHERE e.folio       = C.folio_interno');
         SQL.Add('                                AND e.empresa     = C.empresa');
         SQL.Add('                                AND e.transaccion = C.transaccion)');
      end;
      SQL.Add('   AND C.FOLIO_INTERNO = A.FOLIO_INTERNO_OMD'
				     +'   AND C.TRANSACCION   = A.TRANSACCION_OMD'
				     +'   AND C.EMPRESA       = A.EMPRESA');
      if bCondicion then
         SQL.Add(' AND '+sCondicion_Traza );
      SQL.Add(' GROUP BY A.EMPRESA'
             +'         ,A.TRANSACCION_OMD'
             +'         ,A.FOLIO_INTERNO_OMD'
             +'         ,A.ITEM_MOVIMIENTO');
      ParamByName('Fecha').AsDate              := dFecha;
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- no tengo reallocation en el futuro pero tengo antes (paso 2)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLO_CASO3_PASO2 '
             +'SELECT A.EMPRESA'
					   +'      ,C.CARTERA_MOVIMIENTO'
             +'      ,A.TRANSACCION_OMD'
             +'      ,A.FOLIO_INTERNO_OMD'
             +'      ,A.ITEM_OMD'
             +'      ,B.FECHA_OPERACION'
						 +'	     ,A.FOLIO_INTERNO'
             +'      ,C.FECHA_MOVIMIENTO'
             +'      ,SUM(C.VALOR_NOMINAL)'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'	 FROM QS_TEMP_REALLO_CASO3_PASO1 A'
						 +'	     ,QS_TRA_OMD                 B'
             +'      ,QS_TRA_OMD_TRAZA           C'
						 +' WHERE B.FECHA_OPERACION <= :fecha'
						 +'   AND A.PID              = :pid '
						 +'	  AND B.FOLIO_INTERNO    = A.FOLIO_INTERNO_OMD'
						 +'	  AND B.TRANSACCION      = A.TRANSACCION_OMD'
						 +'	  AND B.EMPRESA          = A.EMPRESA'
						 +'	  AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION'
						 +'	                              FROM QS_SYS_TRAN_IMPLIC X'
						 +'	   				                   WHERE X.IMPLICANCIA = ''RV'')'
						 +'	  AND B.TRANSACCION IN (SELECT X.CODIGO_TRANSACCION'
						 +'	                          FROM QS_SYS_TRAN_IMPLIC X'
						 +'	  	 				             WHERE X.IMPLICANCIA = ''COMPRA'')'
						 +'	  AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION'
						 +'	                              FROM QS_SYS_TRAN_IMPLIC X'
						 +'	  					                 WHERE X.IMPLICANCIA = ''PACTO'')'
						 +'	  AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO'
						 +'	                                FROM QS_CTR_ANULACION E'
						 +'	                               WHERE E.FOLIO       = B.FOLIO_INTERNO'
						 +'	                                 AND E.EMPRESA     = B.EMPRESA'
						 +'	                                 AND E.TRANSACCION = B.TRANSACCION)'
             +'   AND C.FOLIO_INTERNO     = A.FOLIO_INTERNO'
             +'   AND C.FOLIO_INTERNO_OMD = A.FOLIO_INTERNO_OMD'
             +'   AND C.ITEM_MOVIMIENTO   = A.ITEM_OMD'
             +'   AND C.EMPRESA           = A.EMPRESA'
             +' GROUP BY A.EMPRESA'
						 +'         ,C.CARTERA_MOVIMIENTO'
             +'         ,A.TRANSACCION_OMD'
             +'         ,A.FOLIO_INTERNO_OMD'
             +'         ,A.ITEM_OMD'
             +'         ,B.FECHA_OPERACION'
             +'         ,A.FOLIO_INTERNO'
             +'         ,C.FECHA_MOVIMIENTO');
      ParamByName('Fecha').AsDate              := dFecha;
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;     

      // -- no tengo reallocation en el futuro pero tengo antes (paso 3)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLO_CASO3_PASO3 '
             +'SELECT A.EMPRESA'
						 +'      ,A.CARTERA'
             +'      ,A.TRANSACCION'
             +'      ,A.FOLIO_INTERNO'
             +'      ,A.ITEM_OMD'
             +'      ,A.FECHA_COMPRA'
             +'      ,A.FECHA_MOVIMIENTO'
             +'      ,A.VALOR_NOMINAL'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'  FROM QS_TEMP_REALLO_CASO3_PASO2 A'
						 +' WHERE A.PID = :pid ');
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- no tengo reallocation en el futuro pero tengo antes (paso 4)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLO_CASO3_PASO3 '
             +'SELECT A.EMPRESA'
				     +'      ,A.CARTERA'
             +'      ,A.TRANSACCION'
             +'      ,A.FOLIO_INTERNO'
             +'      ,A.ITEM_OMD'
             +'      ,A.FECHA_COMPRA'
             +'      ,A.FECHA_MOVIMIENTO'
             +'      ,C.VALOR_NOMINAL *-1'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'  FROM QS_TEMP_REALLO_CASO3_PASO2 A'
						 +'      ,QS_TRA_OMD                 B'
						 +'      ,QS_TRA_OMD_DET_RF          C'
						 +'  WHERE A.PID               = :pid '
             +'    AND C.FOLIO_INTERNO_REL = A.FOLIO_INTERNO'
						 +'    AND C.ITEM_OMD_REL      = A.ITEM_OMD'
						 +'    AND C.TRANSACCION_REL   = A.TRANSACCION'
						 +'    AND C.EMPRESA_REL       = A.EMPRESA'
						 +'    AND B.FOLIO_INTERNO     = C.FOLIO_INTERNO'
						 +'    AND B.TRANSACCION       = C.TRANSACCION'
						 +'    AND B.EMPRESA           = C.EMPRESA'
						 +'	   AND B.TRANSACCION IN (SELECT X.CODIGO_TRANSACCION'
 						 +'	                           FROM QS_SYS_TRAN_IMPLIC X'
						 +'		 		        		        WHERE X.IMPLICANCIA = ''VENTA'')');
////gg & es 08-11-2023
         SQL.Add(' AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION'
						 +'	                              FROM QS_SYS_TRAN_IMPLIC X'
						 +'	  					                 WHERE X.IMPLICANCIA = ''PACTO'')');
////DC 26/10/2020
//      if not bValorizacion then    // COMENTADA POR ////gg & es 08-11-2023
         SQL.Add(' AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION'
 						 +'	                               FROM QS_SYS_TRAN_IMPLIC X'
						 +'		 		        		            WHERE X.IMPLICANCIA = ''MARGEN'')');
////DC 26/10/2020
			SQL.Add('	   AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO'
						 +'	                                 FROM QS_CTR_ANULACION E'
						 +'	                                WHERE E.FOLIO       = B.FOLIO_INTERNO'
						 +'	                                  AND E.EMPRESA     = B.EMPRESA'
						 +'	                                  AND E.TRANSACCION = B.TRANSACCION)'
						 +'    AND B.FECHA_HORA > (SELECT MAX(X.FECHA_HORA) FROM QS_TRA_OMD_TRAZA X'
						 +'						              WHERE X.FOLIO_INTERNO_OMD = A.FOLIO_INTERNO'
						 +'					                  AND X.ITEM_MOVIMIENTO   = A.ITEM_OMD'
						 +'					                  AND X.TRANSACCION_OMD   = A.TRANSACCION'
						 +'					                  AND X.EMPRESA_OMD       = A.EMPRESA'
						 +'						                AND X.FOLIO_INTERNO     = A.FOLIO_TRAZA)'
						 +'	   AND b.fecha_operacion = a.fecha_movimiento');
      SQL.Add(' UNION ALL ');
      SQL.Add('SELECT A.EMPRESA'
				     +'      ,A.CARTERA'
             +'      ,A.TRANSACCION'
             +'      ,A.FOLIO_INTERNO'
             +'      ,A.ITEM_OMD'
             +'      ,A.FECHA_COMPRA'
             +'      ,A.FECHA_MOVIMIENTO'
             +'      ,C.VALOR_NOMINAL *-1'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'  FROM QS_TEMP_REALLO_CASO3_PASO2 A'
						 +'      ,QS_TRA_OMD                 B'
						 +'      ,QS_TRA_OMD_DET_RF          C'
						 +'  WHERE A.PID               = :pid '
             +'    AND C.FOLIO_INTERNO_REL = A.FOLIO_INTERNO'
						 +'    AND C.ITEM_OMD_REL      = A.ITEM_OMD'
						 +'    AND C.TRANSACCION_REL   = A.TRANSACCION'
						 +'    AND C.EMPRESA_REL       = A.EMPRESA'
						 +'    AND B.FOLIO_INTERNO     = C.FOLIO_INTERNO'
						 +'    AND B.TRANSACCION       = C.TRANSACCION'
						 +'    AND B.EMPRESA           = C.EMPRESA'
						 +'	   AND B.TRANSACCION IN (SELECT X.CODIGO_TRANSACCION'
 						 +'	                           FROM QS_SYS_TRAN_IMPLIC X'
						 +'		 		        		        WHERE X.IMPLICANCIA = ''VENTA'')');
////gg & es 08-11-2023
         SQL.Add(' AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION'
						 +'	                              FROM QS_SYS_TRAN_IMPLIC X'
						 +'	  					                 WHERE X.IMPLICANCIA = ''PACTO'')');
////DC 26/10/2020
//      if not bValorizacion then    // COMENTADA POR ////gg & es 08-11-2023
         SQL.Add(' AND B.TRANSACCION NOT IN (SELECT X.CODIGO_TRANSACCION'
 						 +'	                               FROM QS_SYS_TRAN_IMPLIC X'
						 +'		 		        		            WHERE X.IMPLICANCIA = ''MARGEN'')');
////DC 26/10/2020
			SQL.Add('	   AND B.FOLIO_INTERNO NOT IN (SELECT E.FOLIO'
						 +'	                                 FROM QS_CTR_ANULACION E'
						 +'	                                WHERE E.FOLIO       = B.FOLIO_INTERNO'
						 +'	                                  AND E.EMPRESA     = B.EMPRESA'
						 +'	                                  AND E.TRANSACCION = B.TRANSACCION)'
						 +'	   AND b.fecha_operacion > a.fecha_movimiento AND b.fecha_operacion <= :Fecha ');
      ParamByName('Fecha').AsDate              := dFecha;
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- no tengo reallocation en el futuro pero tengo antes (paso 5)
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_REALLOCATION1 '
             +'SELECT A.EMPRESA'
						 +'	     ,A.CARTERA'
             +'      ,A.TRANSACCION'
             +'      ,A.FOLIO_INTERNO'
             +'      ,A.ITEM_OMD'
             +'      ,A.FECHA_COMPRA'
             +'      ,A.FECHA_MOVIMIENTO'
             +'      ,SUM(A.VALOR_NOMINAL)'
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
						 +'	 FROM QS_TEMP_REALLO_CASO3_PASO3 A'
						 +' WHERE A.PID = :pid '
             +' GROUP BY A.EMPRESA'
						 +'	        ,A.CARTERA'
             +'         ,A.TRANSACCION'
             +'         ,A.FOLIO_INTERNO'
             +'         ,A.ITEM_OMD'
             +'         ,A.FECHA_COMPRA'
             +'         ,A.FECHA_MOVIMIENTO');
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;

      // -- va a buscar el item original de los que fueron reallocados totalmente y que no existen en la OMD
      SQL.Clear;
      SQL.Add('SELECT A.EMPRESA '
             +'      ,A.TRANSACCION '
             +'      ,A.FOLIO_INTERNO '
		  			 +'	     ,A.ITEM_OMD '
             +'  FROM QS_TEMP_REALLOCATION1 A '
						 +' WHERE A.PID           = :pid '
             +'   AND NOT EXISTS (select *  '
		  			 +'	                    from QS_TRA_OMD_DET_RF B '
             +'                    where B.FOLIO_INTERNO = A.FOLIO_INTERNO  '
             +'                      AND B.TRANSACCION   = A.TRANSACCION  '
             +'                      AND B.ITEM_OMD      = A.ITEM_OMD  '
             +'                      AND B.EMPRESA       = A.EMPRESA) ');
      ParamByName('Pid').AsString          := IntToStr(Application.Handle).Trim;
      Open;
      Application.ProcessMessages;
      while not eof do
      begin
         fItem_recursivo := 0;
         recursivo_reallocation(FieldByName('Folio_interno').AsString
                               ,FieldByName('item_omd').Asfloat
                               ,FieldByName('transaccion').AsString
                               ,FieldByName('empresa').AsString
                               ,dFecha
                               ,fItem_recursivo);
         if fItem_recursivo > 0 then
         begin
            DataModule_Comun.Qry_General2.SQL.Clear;
            DataModule_Comun.Qry_General2.SQL.Add('INSERT INTO QS_TEMP_REALLOCATION2 '
                                                 +' VALUES (:empresa,:TRANSACCION,:FOLIO_INTERNO,:ITEM_OMD,:Item_recursivo,:Pid,:Fecha_Creacion ) ');
            DataModule_Comun.Qry_General2.ParamByName('empresa').AsString          := FieldByName('empresa').AsString ;
            DataModule_Comun.Qry_General2.ParamByName('TRANSACCION').AsString      := FieldByName('transaccion').AsString;
            DataModule_Comun.Qry_General2.ParamByName('Folio_interno').AsString    := FieldByName('Folio_interno').AsString;
            DataModule_Comun.Qry_General2.ParamByName('ITEM_OMD').AsFloat          := FieldByName('item_omd').Asfloat;
            DataModule_Comun.Qry_General2.ParamByName('Item_recursivo').AsFloat    := fItem_recursivo;
            DataModule_Comun.Qry_General2.ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
            DataModule_Comun.Qry_General2.ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
            DataModule_Comun.Qry_General2.ExecSQL;
         end;
         Next;
      end;

      Application.ProcessMessages;
      // -- Resultado Final
      SQL.Clear;
      SQL.Add('INSERT INTO QS_TEMP_OMD_DET_RF '
             +'SELECT b.EMPRESA '
             +'      ,b.TRANSACCION '
             +'      ,b.FOLIO_INTERNO '
             +'      ,a.ITEM_OMD '
             +'      ,a.ITEM_OMD '
             +'      ,b.NEMOTECNICO '
             +'      ,b.EMISOR '
             +'      ,b.INSTRUMENTO '
             +'      ,b.SERIE '
             +'      ,b.FECHA_EMISION '
             +'      ,b.FECHA_VENCIMIENTO '
             +'      ,b.TASA_EMISION '
             +'      ,b.TASA_BASE_PAR '
             +'      ,b.TASA_BASE_TIR '
             +'      ,b.MONEDA_INSTRUM '
             +'      ,b.TIPO_NOMINALES '
             +'      ,b.TIPO_INSTRUM '
             +'      ,A.VALOR_NOMINAL '
             +'      ,b.TASA_MERCADO '
             +'      ,b.PORCEN_VALOR_PAR '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PAR_UM)       / B.VALOR_NOMINAL  AS VALOR_PAR_UM '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PAR_MC)       / B.VALOR_NOMINAL  AS VALOR_PAR_MC '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_INVERTIDO_UM) / B.VALOR_NOMINAL  AS VALOR_INVERTIDO_UM'
             +'      ,(A.VALOR_NOMINAL * B.VALOR_INVERTIDO_MC) / B.VALOR_NOMINAL  AS VALOR_INVERTIDO_MC'
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PTE_CPA_UM)   / B.VALOR_NOMINAL  AS VALOR_PTE_CPA_UM '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PTE_CPA_MC)   / B.VALOR_NOMINAL  AS VALOR_PTE_CPA_MC '
             +'      ,(A.VALOR_NOMINAL * B.COMISION_MC)        / B.VALOR_NOMINAL  AS COMISION_MC '
             +'      ,(A.VALOR_NOMINAL * B.IMPUESTO_MC)        / B.VALOR_NOMINAL  AS IMPUESTO_MC '
             +'      ,b.TASA_PACTO '
             +'      ,b.TASA_BASE_PACTO '
             +'      ,b.MONEDA_PACTO '
             +'      ,b.FECHA_VCTO_PACTO '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PACTADO_UM)   / B.VALOR_NOMINAL  AS VALOR_PACTADO_UM '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PACTADO_MC)   / B.VALOR_NOMINAL  AS VALOR_PACTADO_MC '
             +'      ,b.TASA_ESTIMADA '
             +'      ,a.CARTERA '
             +'      ,b.CUSTODIA_DEST '
             +'      ,(A.VALOR_NOMINAL * B.V_INVERTIDO_ORIG)   / B.VALOR_NOMINAL  AS V_INVERTIDO_ORIG '
             +'      ,(A.VALOR_NOMINAL * B.V_INVERTIDO_COMPR)  / B.VALOR_NOMINAL  AS V_INVERTIDO_COMPR '
             +'      ,(A.VALOR_NOMINAL * B.SALDO_INSOLUTO)     / B.VALOR_NOMINAL  AS SALDO_INSOLUTO '
             +'      ,b.EMPRESA_REL '
             +'      ,b.TRANSACCION_REL '
             +'      ,b.FOLIO_INTERNO_REL '
             +'      ,b.ITEM_OMD_REL '
             +'      ,b.EMISOR_REL '
             +'      ,b.INSTRUMENTO_REL '
             +'      ,b.SERIE_REL '
             +'      ,b.FECHA_EMISION_REL '
             +'      ,b.FECHA_VCTO_REL '
             +'      ,b.TASA_EMISION_REL '
             +'      ,b.TASA_MERCADO_REL '
             +'      ,b.FIJA_AJUSTE '
             +'      ,b.FECHA_EMIMAT '
             +'      ,b.TASA_FINANCIERA '
             +'      ,b.CUPONES_CORTADOS '
             +'      ,b.TIPO_CAMBIO '
             +'      ,b.PRECIO_SUCIO '
             +'      ,b.PRECIO_LIMPIO '
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
             +'   FROM QS_TEMP_REALLOCATION1 A'
             +'       ,QS_TRA_OMD_DET_RF     B'
						 +'  WHERE A.PID           = :pid '
             +'    AND B.FOLIO_INTERNO = A.FOLIO_INTERNO'
             +'    AND B.TRANSACCION   = A.TRANSACCION'
             +'    AND B.ITEM_OMD      = A.ITEM_OMD'
             +'    AND B.EMPRESA       = A.EMPRESA'
// 17-07-2020 Edosan
             +'    AND b.VALOR_NOMINAL <> 0');
      SQL.Add('   AND b.folio_interno NOT IN (SELECT e.folio');
      SQL.Add('                                 FROM qs_ctr_anulacion e');
      SQL.Add('                                WHERE e.folio       = b.folio_interno');
      SQL.Add('                                  AND e.empresa     = b.empresa');
      SQL.Add('                                  AND e.transaccion = b.transaccion)');
// Fin 17-07-2020 Edosan
			SQL.Add(' UNION ');
      SQL.Add('SELECT b.EMPRESA '
             +'      ,b.TRANSACCION '
             +'      ,b.FOLIO_INTERNO '
             +'      ,a.ITEM_OMD '
             +'      ,a.ITEM_OMD '
             +'      ,b.NEMOTECNICO '
             +'      ,b.EMISOR '
             +'      ,b.INSTRUMENTO '
             +'      ,b.SERIE '
             +'      ,b.FECHA_EMISION '
             +'      ,b.FECHA_VENCIMIENTO '
             +'      ,b.TASA_EMISION '
             +'      ,b.TASA_BASE_PAR '
             +'      ,b.TASA_BASE_TIR '
             +'      ,b.MONEDA_INSTRUM '
             +'      ,b.TIPO_NOMINALES '
             +'      ,b.TIPO_INSTRUM '
             +'      ,A.VALOR_NOMINAL '
             +'      ,b.TASA_MERCADO '
             +'      ,b.PORCEN_VALOR_PAR '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PAR_UM)       / B.VALOR_NOMINAL  AS VALOR_PAR_UM '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PAR_MC)       / B.VALOR_NOMINAL  AS VALOR_PAR_MC '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_INVERTIDO_UM) / B.VALOR_NOMINAL  AS VALOR_INVERTIDO_UM'
             +'      ,(A.VALOR_NOMINAL * B.VALOR_INVERTIDO_MC) / B.VALOR_NOMINAL  AS VALOR_INVERTIDO_MC'
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PTE_CPA_UM)   / B.VALOR_NOMINAL  AS VALOR_PTE_CPA_UM '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PTE_CPA_MC)   / B.VALOR_NOMINAL  AS VALOR_PTE_CPA_MC '
             +'      ,(A.VALOR_NOMINAL * B.COMISION_MC)        / B.VALOR_NOMINAL  AS COMISION_MC '
             +'      ,(A.VALOR_NOMINAL * B.IMPUESTO_MC)        / B.VALOR_NOMINAL  AS IMPUESTO_MC '
             +'      ,b.TASA_PACTO '
             +'      ,b.TASA_BASE_PACTO '
             +'      ,b.MONEDA_PACTO '
             +'      ,b.FECHA_VCTO_PACTO '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PACTADO_UM)   / B.VALOR_NOMINAL  AS VALOR_PACTADO_UM '
             +'      ,(A.VALOR_NOMINAL * B.VALOR_PACTADO_MC)   / B.VALOR_NOMINAL  AS VALOR_PACTADO_MC '
             +'      ,b.TASA_ESTIMADA '
             +'      ,a.CARTERA '
             +'      ,b.CUSTODIA_DEST '
             +'      ,(A.VALOR_NOMINAL * B.V_INVERTIDO_ORIG)   / B.VALOR_NOMINAL  AS V_INVERTIDO_ORIG '
             +'      ,(A.VALOR_NOMINAL * B.V_INVERTIDO_COMPR)  / B.VALOR_NOMINAL  AS V_INVERTIDO_COMPR '
             +'      ,(A.VALOR_NOMINAL * B.SALDO_INSOLUTO)     / B.VALOR_NOMINAL  AS SALDO_INSOLUTO '
             +'      ,b.EMPRESA_REL '
             +'      ,b.TRANSACCION_REL '
             +'      ,b.FOLIO_INTERNO_REL '
             +'      ,b.ITEM_OMD_REL '
             +'      ,b.EMISOR_REL '
             +'      ,b.INSTRUMENTO_REL '
             +'      ,b.SERIE_REL '
             +'      ,b.FECHA_EMISION_REL '
             +'      ,b.FECHA_VCTO_REL '
             +'      ,b.TASA_EMISION_REL '
             +'      ,b.TASA_MERCADO_REL '
             +'      ,b.FIJA_AJUSTE '
             +'      ,b.FECHA_EMIMAT '
             +'      ,b.TASA_FINANCIERA '
             +'      ,b.CUPONES_CORTADOS '
             +'      ,b.TIPO_CAMBIO '
             +'      ,b.PRECIO_SUCIO '
             +'      ,b.PRECIO_LIMPIO '
             +'      ,:Pid '
             +'      ,:Fecha_Creacion '
             +'   FROM QS_TEMP_REALLOCATION1 A'
						 +'     	,QS_TEMP_REALLOCATION2 C'
             +'       ,QS_TRA_OMD_DET_RF     B'
						 +'  WHERE A.PID           = :pid '
             +'    AND c.PID           = A.PID'
             +'    AND c.FOLIO_INTERNO = A.FOLIO_INTERNO'
             +'    AND c.TRANSACCION   = A.TRANSACCION'
             +'    AND c.ITEM_OMD      = A.ITEM_OMD'
             +'    AND c.EMPRESA       = A.EMPRESA'
             +'    AND b.FOLIO_INTERNO = c.FOLIO_INTERNO'
             +'    AND b.TRANSACCION   = c.TRANSACCION'
             +'    AND b.ITEM_OMD      = c.ITEM_OMD_REA'
             +'    AND b.EMPRESA       = c.EMPRESA'
// 17-07-2020 Edosan
             +'    AND b.VALOR_NOMINAL <> 0');
      SQL.Add('   AND b.folio_interno NOT IN (SELECT e.folio');
      SQL.Add('                                 FROM qs_ctr_anulacion e');
      SQL.Add('                                WHERE e.folio       = b.folio_interno');
      SQL.Add('                                  AND e.empresa     = b.empresa');
      SQL.Add('                                  AND e.transaccion = b.transaccion)');
// Fin 17-07-2020 Edosan
      ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
      ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
      ExecSQL;
      Close;
      Application.ProcessMessages;


      // Debo incluir las ventas con pactos para que queden en el stock, E.S. 26-03-2014
      if bValorizacion AND bseleccion_Ventas then
      begin

         Sql.Clear;
         SQL.Add('INSERT INTO QS_TEMP_OMD_DET_RF '
                +'SELECT b.EMPRESA '
                +'      ,b.TRANSACCION '
                +'      ,b.FOLIO_INTERNO '
                +'      ,b.ITEM_OMD '
                +'      ,b.ITEM_ORDEN '
                +'      ,b.NEMOTECNICO '
                +'      ,b.EMISOR '
                +'      ,b.INSTRUMENTO '
                +'      ,b.SERIE '
                +'      ,b.FECHA_EMISION '
                +'      ,b.FECHA_VENCIMIENTO '
                +'      ,b.TASA_EMISION '
                +'      ,b.TASA_BASE_PAR '
                +'      ,b.TASA_BASE_TIR '
                +'      ,b.MONEDA_INSTRUM '
                +'      ,b.TIPO_NOMINALES '
                +'      ,b.TIPO_INSTRUM '
                +'      ,b.VALOR_NOMINAL '
                +'      ,b.TASA_MERCADO '
                +'      ,b.PORCEN_VALOR_PAR '
                +'      ,b.VALOR_PAR_UM '
                +'      ,b.VALOR_PAR_MC '
                +'      ,b.VALOR_INVERTIDO_UM '
                +'      ,b.VALOR_INVERTIDO_MC '
                +'      ,b.VALOR_PTE_CPA_UM '
                +'      ,b.VALOR_PTE_CPA_MC '
                +'      ,b.COMISION_MC '
                +'      ,b.IMPUESTO_MC '
                +'      ,b.TASA_PACTO '
                +'      ,b.TASA_BASE_PACTO '
                +'      ,b.MONEDA_PACTO '
                +'      ,b.FECHA_VCTO_PACTO '
                +'      ,b.VALOR_PACTADO_UM '
                +'      ,b.VALOR_PACTADO_MC'
                +'      ,b.TASA_ESTIMADA '
                +'      ,b.CARTERA '
                +'      ,b.CUSTODIA_DEST '
                +'      ,b.V_INVERTIDO_ORIG '
                +'      ,b.V_INVERTIDO_COMPR '
                +'      ,b.SALDO_INSOLUTO '
                +'      ,b.EMPRESA_REL '
                +'      ,b.TRANSACCION_REL '
                +'      ,b.FOLIO_INTERNO_REL '
                +'      ,b.ITEM_OMD_REL '
                +'      ,b.EMISOR_REL '
                +'      ,b.INSTRUMENTO_REL '
                +'      ,b.SERIE_REL '
                +'      ,b.FECHA_EMISION_REL '
                +'      ,b.FECHA_VCTO_REL '
                +'      ,b.TASA_EMISION_REL '
                +'      ,b.TASA_MERCADO_REL '
                +'      ,b.FIJA_AJUSTE '
                +'      ,b.FECHA_EMIMAT '
                +'      ,b.TASA_FINANCIERA  '
                +'      ,b.CUPONES_CORTADOS '
                +'      ,b.TIPO_CAMBIO '
                +'      ,b.PRECIO_SUCIO '
                +'      ,b.PRECIO_LIMPIO '
                +'      ,:Pid '
                +'      ,:Fecha_Creacion '
                +'  FROM QS_TRA_OMD_DET_RF b ');
         if bCondicion then
         SQL.Add('      ,QS_TRA_OMD        c ');
         SQL.Add(' WHERE b.Folio_Interno NOT IN (SELECT x.folio_interno_omd '
                +'                                 FROM QS_TRA_OMD_TRAZA x '
                +'                                WHERE x.folio_interno_omd  = b.folio_interno '
                +'                                  AND x.transaccion_omd    = b.transaccion '
                +'                                  AND x.item_movimiento    = b.item_omd '
                +'                                  AND x.empresa_omd        = b.empresa '
                +'                                  AND x.FECHA_MOVIMIENTO  <= :Fecha )');

            SQL.Add('   AND b.TRANSACCION IN '+sImplicancia_Venta);
            SQL.Add('   AND b.TRANSACCION IN '+sImplicancia_Pacto);
            SQL.Add('   AND b.TRANSACCION NOT IN '+sImplicancia_RV);
            SQL.Add('   AND b.folio_interno NOT IN (SELECT e.folio');
            SQL.Add('                                 FROM qs_ctr_anulacion e');
            SQL.Add('                                WHERE e.folio       = b.folio_interno');
            SQL.Add('                                  AND e.empresa     = b.empresa');
            SQL.Add('                                  AND e.transaccion = b.transaccion)');
         SQL.Add('   AND b.Tipo_Instrum = ''S'' ');

         if bCondicion then
         SQL.Add('   AND c.folio_interno = b.folio_interno '
                +'   AND c.transaccion   = b.transaccion '
                +'   AND c.empresa       = b.empresa '
                +'   AND '+sCondicion_Omd
                );
         ParamByName('Fecha').AsDate              := dFecha;
         ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
         ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
         Prepare;
         ExecSQL;
         Close;
         UnPrepare;
         Application.ProcessMessages;

         if bseleccion_Ventas then
         begin
            //SQL.Add('UNION '
            Sql.Clear;
            SQL.Add('INSERT INTO QS_TEMP_OMD_DET_RF '
                   +'SELECT b.EMPRESA '
                   +'      ,b.TRANSACCION '
                   +'      ,b.FOLIO_INTERNO '
                   +'      ,b.ITEM_OMD '
                   +'      ,b.ITEM_ORDEN '
                   +'      ,b.NEMOTECNICO '
                   +'      ,b.EMISOR '
                   +'      ,b.INSTRUMENTO '
                   +'      ,b.SERIE '
                   +'      ,b.FECHA_EMISION '
                   +'      ,b.FECHA_VENCIMIENTO '
                   +'      ,b.TASA_EMISION '
                   +'      ,b.TASA_BASE_PAR '
                   +'      ,b.TASA_BASE_TIR '
                   +'      ,b.MONEDA_INSTRUM '
                   +'      ,b.TIPO_NOMINALES '
                   +'      ,b.TIPO_INSTRUM '
                   +'      ,b.VALOR_NOMINAL '
                   +'      ,b.TASA_MERCADO '
                   +'      ,b.PORCEN_VALOR_PAR '
                   +'      ,b.VALOR_PAR_UM '
                   +'      ,b.VALOR_PAR_MC '
                   +'      ,b.VALOR_INVERTIDO_UM '
                   +'      ,b.VALOR_INVERTIDO_MC '
                   +'      ,b.VALOR_PTE_CPA_UM '
                   +'      ,b.VALOR_PTE_CPA_MC '
                   +'      ,b.COMISION_MC '
                   +'      ,b.IMPUESTO_MC '
                   +'      ,b.TASA_PACTO '
                   +'      ,b.TASA_BASE_PACTO '
                   +'      ,b.MONEDA_PACTO '
                   +'      ,b.FECHA_VCTO_PACTO '
                   +'      ,b.VALOR_PACTADO_UM '
                   +'      ,b.VALOR_PACTADO_MC'
                   +'      ,b.TASA_ESTIMADA '
                   +'      ,b.CARTERA '
                   +'      ,b.CUSTODIA_DEST '
                   +'      ,b.V_INVERTIDO_ORIG '
                   +'      ,b.V_INVERTIDO_COMPR '
                   +'      ,b.SALDO_INSOLUTO '
                   +'      ,b.EMPRESA_REL '
                   +'      ,b.TRANSACCION_REL '
                   +'      ,b.FOLIO_INTERNO_REL '
                   +'      ,b.ITEM_OMD_REL '
                   +'      ,b.EMISOR_REL '
                   +'      ,b.INSTRUMENTO_REL '
                   +'      ,b.SERIE_REL '
                   +'      ,b.FECHA_EMISION_REL '
                   +'      ,b.FECHA_VCTO_REL '
                   +'      ,b.TASA_EMISION_REL '
                   +'      ,b.TASA_MERCADO_REL '
                   +'      ,b.FIJA_AJUSTE '
                   +'      ,b.FECHA_EMIMAT '
                   +'      ,b.TASA_FINANCIERA  '
                   +'      ,b.CUPONES_CORTADOS '
                   +'      ,b.TIPO_CAMBIO '
                   +'      ,b.PRECIO_SUCIO '
                   +'      ,b.PRECIO_LIMPIO '
                   +'      ,:Pid '
                   +'      ,:Fecha_Creacion '
                   +'  FROM QS_TRA_OMD_DET_RF b ');
            if bCondicion then
               SQL.Add('      ,QS_TRA_OMD        c ');
            SQL.Add(' WHERE b.Folio_Interno NOT IN (SELECT x.folio_interno_omd '
                   +'                                 FROM QS_TRA_OMD_TRAZA x '
                   +'                                WHERE x.folio_interno_omd  = b.folio_interno '
                   +'                                  AND x.transaccion_omd    = b.transaccion '
                   +'                                  AND x.item_movimiento    = b.item_omd '
                   +'                                  AND x.empresa_omd        = b.empresa '
                   +'                                  AND x.FECHA_MOVIMIENTO  <= :Fecha )');
               SQL.Add('   AND b.TRANSACCION IN '+sImplicancia_Venta);
               SQL.Add('   AND b.TRANSACCION IN '+sImplicancia_Pacto);
               SQL.Add('   AND b.TRANSACCION NOT IN '+sImplicancia_RV);
               if NOT bIncluye_Vencidos then
                  SQL.Add('   AND b.Fecha_Vencimiento >= :Fecha ');
               SQL.Add('   AND b.folio_interno NOT IN (SELECT e.folio');
               SQL.Add('                                 FROM qs_ctr_anulacion e');
               SQL.Add('                                WHERE e.folio       = b.folio_interno');
               SQL.Add('                                  AND e.empresa     = b.empresa');
               SQL.Add('                                  AND e.transaccion = b.transaccion)');
            SQL.Add('   AND b.Tipo_Instrum <> ''S'' ');

            if bCondicion then
            SQL.Add('   AND c.folio_interno = b.folio_interno '
                   +'   AND c.transaccion   = b.transaccion '
                   +'   AND c.empresa       = b.empresa '
                   +'   AND '+sCondicion_Omd
                   );
            ParamByName('Fecha').AsDate              := dFecha;
            ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
            ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
            Prepare;
            ExecSQL;
            Close;
            UnPrepare;
         end;
         Application.ProcessMessages;

         if bPactos_RV then
         begin
            //SQL.Add('UNION '
            Sql.Clear;
            SQL.Add('INSERT INTO QS_TEMP_OMD_DET_RF '
                   +'SELECT b.EMPRESA '
                   +'      ,b.TRANSACCION '
                   +'      ,b.FOLIO_INTERNO '
                   +'      ,b.ITEM_OMD '
                   +'      ,b.ITEM_ORDEN '
                   +'      ,b.NEMOTECNICO '
                   +'      ,b.EMISOR '
                   +'      ,b.INSTRUMENTO '
                   +'      ,b.SERIE '
                   +'      ,b.FECHA_EMISION '
                   +'      ,b.FECHA_VENCIMIENTO '
                   +'      ,b.TASA_EMISION '
                   +'      ,b.TASA_BASE_PAR '
                   +'      ,b.TASA_BASE_TIR '
                   +'      ,b.MONEDA_INSTRUM '
                   +'      ,b.TIPO_NOMINALES '
                   +'      ,b.TIPO_INSTRUM '
                   +'      ,b.VALOR_NOMINAL '
                   +'      ,b.TASA_MERCADO '
                   +'      ,b.PORCEN_VALOR_PAR '
                   +'      ,b.VALOR_PAR_UM '
                   +'      ,b.VALOR_PAR_MC '
                   +'      ,b.VALOR_INVERTIDO_UM '
                   +'      ,b.VALOR_INVERTIDO_MC '
                   +'      ,b.VALOR_PTE_CPA_UM '
                   +'      ,b.VALOR_PTE_CPA_MC '
                   +'      ,b.COMISION_MC '
                   +'      ,b.IMPUESTO_MC '
                   +'      ,b.TASA_PACTO '
                   +'      ,b.TASA_BASE_PACTO '
                   +'      ,b.MONEDA_PACTO '
                   +'      ,b.FECHA_VCTO_PACTO '
                   +'      ,b.VALOR_PACTADO_UM '
                   +'      ,b.VALOR_PACTADO_MC'
                   +'      ,b.TASA_ESTIMADA '
                   +'      ,b.CARTERA '
                   +'      ,b.CUSTODIA_DEST '
                   +'      ,b.V_INVERTIDO_ORIG '
                   +'      ,b.V_INVERTIDO_COMPR '
                   +'      ,b.SALDO_INSOLUTO '
                   +'      ,b.EMPRESA_REL '
                   +'      ,b.TRANSACCION_REL '
                   +'      ,b.FOLIO_INTERNO_REL '
                   +'      ,b.ITEM_OMD_REL '
                   +'      ,b.EMISOR_REL '
                   +'      ,b.INSTRUMENTO_REL '
                   +'      ,b.SERIE_REL '
                   +'      ,b.FECHA_EMISION_REL '
                   +'      ,b.FECHA_VCTO_REL '
                   +'      ,b.TASA_EMISION_REL '
                   +'      ,b.TASA_MERCADO_REL '
                   +'      ,b.FIJA_AJUSTE '
                   +'      ,b.FECHA_EMIMAT '
                   +'      ,b.TASA_FINANCIERA  '
                   +'      ,b.CUPONES_CORTADOS '
                   +'      ,b.TIPO_CAMBIO '
                   +'      ,b.PRECIO_SUCIO '
                   +'      ,b.PRECIO_LIMPIO '
                   +'      ,:Pid '
                   +'      ,:Fecha_Creacion '
                   +'  FROM QS_TRA_OMD_DET_RF b ');
            if bCondicion then
               SQL.Add('   ,QS_TRA_OMD        c ');
            SQL.Add(' WHERE b.Folio_Interno NOT IN (SELECT x.folio_interno_omd '
                   +'                                 FROM QS_TRA_OMD_TRAZA x '
                   +'                                WHERE x.folio_interno_omd  = b.folio_interno '
                   +'                                  AND x.transaccion_omd    = b.transaccion '
                   +'                                  AND x.item_movimiento    = b.item_omd '
                   +'                                  AND x.empresa_omd        = b.empresa '
                   +'                                  AND x.FECHA_MOVIMIENTO  <= :Fecha )');
               SQL.Add('   AND b.TRANSACCION IN '+sImplicancia_RV);
               SQL.Add('   AND b.TRANSACCION IN '+sImplicancia_Pacto);
               if NOT bIncluye_Vencidos then
                  //SQL.Add('   AND b.Fecha_Vencimiento >= :Fecha ');  //ggracia 17-08-2016
                  SQL.Add('   AND b.Fecha_Vcto_pacto >= :Fecha ');
               SQL.Add('   AND b.folio_interno NOT IN (SELECT e.folio');
               SQL.Add('                                 FROM qs_ctr_anulacion e');
               SQL.Add('                                WHERE e.folio       = b.folio_interno');
               SQL.Add('                                  AND e.empresa     = b.empresa');
               SQL.Add('                                  AND e.transaccion = b.transaccion)');
            SQL.Add('   AND b.Tipo_Instrum =  ''R'' ');

            if bCondicion then
            SQL.Add('   AND c.folio_interno = b.folio_interno '
                   +'   AND c.transaccion   = b.transaccion '
                   +'   AND c.empresa       = b.empresa '
                   +'   AND '+sCondicion_Omd
                   );
            ParamByName('Fecha').AsDate              := dFecha;
            ParamByName('Pid').AsString              := IntToStr(Application.Handle).Trim;
            ParamByName('Fecha_Creacion').AsDateTime := dfecha_creacion;
            Prepare;
            ExecSQL;
            Close;
            UnPrepare;
            Application.ProcessMessages;
         end;
      end;

   end;

   if not bTransaccion then
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
         dmBaseDatos.Conexion_BaseDatos.Commit;
end;

procedure Borra_OMD_Re_Allocation(dFecha :TDateTime);
var dfecha_creacion  : TDateTime;
    bTransaccion     : Boolean;
begin
   bTransaccion := false;  //ggarcia 20-03-2017

   // Maneja transaccion corta 28-05-2012 F.I.
   if (NOT dmBaseDatos.conexion_basedatos.InTransaction) then
      dmBaseDatos.conexion_basedatos.StartTransaction
   else
      bTransaccion := true;

   dfecha_creacion := fecha_hora_servidor;

   with DataModule_Comun.Qry_General do
   begin
      Close;
      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1 WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;


      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1 WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;


      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1A WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1A WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;


      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1B WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1B WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;


      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1C WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1C WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1D WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION1D WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION2 WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLOCATION2 WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLO_CASO3_PASO1 WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLO_CASO3_PASO1 WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLO_CASO3_PASO2 WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLO_CASO3_PASO2 WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLO_CASO3_PASO3 WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_REALLO_CASO3_PASO3 WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_OMD_DET_RF WHERE Pid = :Pid ');
      ParamByName('Pid').AsString := IntToStr(Application.Handle).Trim;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;

      Sql.Clear;
      SQL.Add('DELETE FROM QS_TEMP_OMD_DET_RF WHERE fecha_creacion < :fecha_aux ');
      ParamByName('Fecha_aux').AsDate := dfecha_creacion - 1;
      Prepare;
      ExecSQL;
      UnPrepare;
      Close;
      Application.ProcessMessages;
   end;

   if not bTransaccion then
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
         dmBaseDatos.Conexion_BaseDatos.Commit;

end;

procedure recursivo_reallocation(sFolio_interno :string;
                                 fitem_omd       :Double;
                                 stransaccion    :string;
                                 sempresa        :string;
                                 dFecha          :TDateTime;
                             var fItem_recursivo :Double);
begin
   with DataModule_Comun.Qry_General3 do
   begin
      SQL.Clear;
      SQL.Add('select A.EMPRESA '
             +'      ,A.TRANSACCION_OMD '
             +'      ,A.FOLIO_INTERNO_OMD '
	 		       +'	     ,min(a.item_movimiento) as Item_recursivo'
             +'	from qs_tra_omd_traza a  '
             +' where a.Folio_interno_omd = :Folio_interno '
             +'   and a.item_omd          = :item_omd '
             +'   and a.transaccion_omd   = :transaccion '
             +'   and a.empresa           = :empresa '
             +'	  and a.item_omd         <> a.item_movimiento '
             +'	  and a.FECHA_MOVIMIENTO  > :Fecha '
             +' group by A.EMPRESA  '
             +'	        ,A.TRANSACCION_OMD '
             +'	        ,A.FOLIO_INTERNO_OMD '
	 			     +'	  	    ,a.item_omd ');
      ParamByName('empresa').AsString       := sempresa;
      ParamByName('TRANSACCION').AsString   := stransaccion;
      ParamByName('Folio_interno').AsString := sFolio_interno;
      ParamByName('ITEM_OMD').AsFloat       := fitem_omd;
      ParamByName('Fecha').AsDateTime       := dFecha;
      Open;
      if not eof then
      begin
         fItem_recursivo := FieldByName('Item_recursivo').Asfloat;
         recursivo_reallocation(FieldByName('Folio_interno_omd').AsString
                               ,FieldByName('Item_recursivo').Asfloat
                               ,FieldByName('transaccion_omd').AsString
                               ,FieldByName('empresa').AsString
                               ,dFecha
                               ,fItem_recursivo);
      end;
   end;
end;

procedure Busca_OtrasClasif_Instrum(sInstrumentos : String;
                                    sTipoClasif   : String;
                                    sNodos_Hijos  : String;
                                    Var Result    : Boolean);
begin
   Result := True;
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT a.* ');
      SQL.Add('  FROM QS_SYS_CLASIF_OBJ a'
             +'  WHERE a.objeto         = ''INSTRUM'' '
             +'    AND a.codigo_clasif  = :Clasif_Informe '
             +'    AND a.elemento       = :Instrumento'
             +'    AND a.Nodo NOT IN ('+sNodos_Hijos+')');

      ParamByName('Clasif_Informe').AsString := sTipoClasif;
      ParamByName('Instrumento').AsString    := sInstrumentos;

      Open;

      if NOT FieldByName('elemento').IsNull then
         Result := False;

      Close;
   end;
end;

procedure Busca_Clasif_Nemotecnico(sObjeto       : String;
                                   sNemotecnico  : String;
                                   sTipoClasif   : String;
                                   sNodos_Hijos  : String;
                                   var Result    : Boolean);
begin
   Result := True;
   with DataModule_Comun.Qry_General do
   begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT a.* ');
     SQL.Add('  FROM QS_SYS_CLASIF_OBJ a'
            +' WHERE a.objeto         = :objeto '
            +'   AND a.codigo_clasif  = :Clasif_Informe '
            +'   AND a.elemento       = :Nemotecnico '
            +'   AND a.Nodo NOT IN ('+sNodos_Hijos+')');

     ParamByName('objeto').AsString         := sObjeto;
     ParamByName('Clasif_Informe').AsString := sTipoClasif;
     ParamByName('Nemotecnico').AsString    := sNemotecnico;

     Open;

     if NOT DataModule_Comun.Qry_General.FieldByName('elemento').IsNull then
        Result := False;

      Close;
   end;
end;

Function LLena_String_Implicancia(simplicancia : String) : String;
var sResultado : String;
begin
   with DataModule_Comun.Qry_General do
   begin
       Close;
       Sql.Clear;
       SQL.Add(' SELECT z.Codigo_Transaccion FROM QS_SYS_TRAN_IMPLIC z'
              +' WHERE z.Implicancia IN (:Implicancia)'
              );
       Parambyname('Implicancia').asString := simplicancia;
       Open;
       sResultado := '';
       if Not Fieldbyname('Codigo_Transaccion').IsNull then
       begin
          if NOT EOF then
             sResultado := sResultado +' ( '''+Fieldbyname('Codigo_Transaccion').asString;
          Next;
          While Not Eof do
          begin
             sResultado := sResultado +''','''+Fieldbyname('Codigo_Transaccion').asString;
             Next;
          end;
          sResultado := sResultado + ''' )';
       end
       else
          sResultado := '(''X'')';
       Result := sResultado;
       Close;
   end;
end;

Function Llena_String_Proceso_provision(dFecha : TDateTime) : String;
var sResultado : String;
begin
   with DataModule_Comun.Qry_General do
   begin
       Close;
       Sql.Clear;
       SQL.Add('select distinct codigo_proceso '
              +'  from QS_RES_PROV_IMPAIRMENT '
              +' where fecha_desde = :Fecha_Cierre ');
       Parambyname('Fecha_Cierre').asDate := dFecha;
       Open;
       sResultado := '';
       if Not Fieldbyname('codigo_proceso').IsNull then
       begin
          if NOT EOF then
             sResultado := sResultado +' ( '''+Fieldbyname('codigo_proceso').asString;
          Next;
          While Not Eof do
          begin
             sResultado := sResultado +''','''+Fieldbyname('codigo_proceso').asString;
             Next;
          end;
          sResultado := sResultado + ''' )';
       end
       else
          sResultado := '(''X'')';
       Result := sResultado;
       Close;
   end;
end;

Function Busca_Cartera_Re_Allocation(dFecha         : TDateTime;
                                     sFolio_Interno : String;
                                     fItem_OMD      : Double;
                                     sTransaccion   : String;
                                     sEmpresa       : String) : String;
var dfecha_creacion : TDateTime;
begin
   dfecha_creacion := fecha_hora_servidor;
   Result := '';
   with DataModule_Comun.Qry_General do
   begin
      if sDriver = 'MSSQL' then
      begin
         Sql.Clear;
         Sql.add(' SET DATEFORMAT dmy ');
         ExecSQL;
      end;
      Sql.Clear;
      SQL.Add('SELECT a.CARTERA_MOVIMIENTO as Cartera'
             +'  FROM QS_TRA_OMD_TRAZA  a '
             +'      ,QS_TRA_OMD_DET_RF b ');
      SQL.Add(' WHERE a.FOLIO_INTERNO_OMD = :FOLIO_INTERNO '
             +'   AND a.ITEM_OMD          = :ITEM_OMD '
             +'   and a.TRANSACCION_OMD   = :TRANSACCION '
             +'   and a.EMPRESA           = :EMPRESA ');
      SQL.Add('   AND a.FECHA_MOVIMIENTO IN (SELECT MAX(x.FECHA_MOVIMIENTO) '
             +'                                FROM QS_TRA_OMD_TRAZA x '
             +'                               WHERE x.folio_interno_omd   = b.folio_interno '
             +'                                 AND x.transaccion_omd     = b.transaccion '
             +'                                 AND x.item_movimiento     = b.item_omd '
             +'                                 AND x.empresa_omd         = b.empresa '
             +'                                 AND x.FECHA_MOVIMIENTO   <= :Fecha ) ');
      if sDriver = 'ORACLE' then
      SQL.Add('   AND to_number(a.FOLIO_INTERNO) IN (SELECT MAX(to_number(x.FOLIO_INTERNO)) '
             +'                                        FROM QS_TRA_OMD_TRAZA x '
             +'                                       WHERE x.folio_interno_omd   = b.folio_interno '
             +'                                         AND x.transaccion_omd     = b.transaccion '
             +'                                         AND x.item_movimiento     = b.item_omd '
             +'                                         AND x.empresa_omd         = b.empresa '
             +'                                         AND x.FECHA_MOVIMIENTO    = a.FECHA_MOVIMIENTO) ')
      else
      SQL.Add('   AND cast(a.FOLIO_INTERNO as integer) IN (SELECT MAX(cast(x.FOLIO_INTERNO as integer)) '
             +'                                              FROM QS_TRA_OMD_TRAZA x '
             +'                                             WHERE x.folio_interno_omd   = b.folio_interno '
             +'                                               AND x.transaccion_omd     = b.transaccion '
             +'                                               AND x.item_movimiento     = b.item_omd '
             +'                                               AND x.empresa_omd         = b.empresa '
             +'                                               AND x.FECHA_MOVIMIENTO    = a.FECHA_MOVIMIENTO) ');
      SQL.Add('   AND b.folio_interno = a.folio_interno_omd '
             +'   AND b.transaccion   = a.transaccion_omd '
             +'   AND b.item_omd      = a.item_movimiento '
             +'   AND b.empresa       = a.empresa_omd ');
      Sql.Add('UNION ');
      SQL.Add('SELECT a.Cartera '
             +'  FROM QS_TRA_OMD_DET_RF a ');
      SQL.Add(' WHERE a.FOLIO_INTERNO = :FOLIO_INTERNO '
             +'   AND a.ITEM_OMD      = :ITEM_OMD '
             +'   AND a.TRANSACCION   = :TRANSACCION '
             +'   AND a.EMPRESA       = :EMPRESA ');
      SQL.Add('   AND a.Folio_Interno NOT IN (SELECT x.folio_interno_omd '
             +'                                 FROM QS_TRA_OMD_TRAZA x '
             +'                                WHERE x.folio_interno_omd  = a.folio_interno '
             +'                                  AND x.transaccion_omd    = a.transaccion '
             +'                                  AND x.item_movimiento    = a.item_omd '
             +'                                  AND x.empresa_omd        = a.empresa '
             +'                                  AND x.FECHA_MOVIMIENTO  <= :Fecha )');
      ParamByName('FOLIO_INTERNO').AsString    := sFOLIO_INTERNO;
      ParamByName('ITEM_OMD').AsFloat          := fITEM_OMD;
      ParamByName('TRANSACCION').AsString      := sTRANSACCION;
      ParamByName('EMPRESA').AsString          := sEMPRESA;
      ParamByName('Fecha').AsDate          := dFecha;
      Prepare;
      Open;
      if not eof then
         Result := FieldByName('Cartera').AsString;
      Close;
      UnPrepare;
   end;

end;

Function Busca_Re_Allocation(dFecha         : TDateTime;
                             sFolio_Interno : String;
                             fItem_OMD      : Double;
                             sTransaccion   : String;
                             sEmpresa       : String) : Boolean;
begin
   Result := false;
   with DataModule_Comun.Qry_General do
   begin
      Sql.Clear;
      SQL.Add('SELECT a.* '
             +'  FROM QS_TRA_OMD_TRAZA  a ');
      SQL.Add(' WHERE a.FOLIO_INTERNO_OMD = :FOLIO_INTERNO '
             +'   AND a.ITEM_OMD          = :ITEM_OMD '
             +'   and a.TRANSACCION_OMD   = :TRANSACCION '
             +'   and a.EMPRESA           = :EMPRESA '
             +'   and a.FECHA_MOVIMIENTO  > :FECHA ');
      ParamByName('FOLIO_INTERNO').AsString    := sFolio_Interno;
      ParamByName('ITEM_OMD').AsFloat          := fItem_OMD;
      ParamByName('TRANSACCION').AsString      := sTransaccion;
      ParamByName('EMPRESA').AsString          := sEmpresa;
      ParamByName('FECHA').AsDate          := dFecha;
      Prepare;
      Open;
      if not eof then
      begin
         Result := true;
         Close;
         UnPrepare;
         Exit;
      end;

      Sql.Clear;
      SQL.Add('SELECT a.* '
             +'  FROM QS_TRA_OMD_TRAZA  a ');
      SQL.Add(' WHERE a.FOLIO_INTERNO_OMD = :FOLIO_INTERNO '
             +'   AND a.ITEM_MOVIMIENTO   = :ITEM_OMD '
             +'   and a.TRANSACCION_OMD   = :TRANSACCION '
             +'   and a.EMPRESA           = :EMPRESA '
             +'   and a.FECHA_MOVIMIENTO  > :FECHA ');
      ParamByName('FOLIO_INTERNO').AsString    := sFolio_Interno;
      ParamByName('ITEM_OMD').AsFloat          := fItem_OMD;
      ParamByName('TRANSACCION').AsString      := sTransaccion;
      ParamByName('EMPRESA').AsString          := sEmpresa;
      ParamByName('FECHA').AsDate          := dFecha;
      Prepare;
      Open;
      if not eof then
         Result := true;
      Close;
      UnPrepare;
   end;
end;

Function Busca_Asignacion_Automatica(dFecha         : TDateTime;
                                     sFolio_Interno : String;
                                     fItem_OMD      : Double;
                                     sTransaccion   : String;
                                     sEmpresa       : String) : Boolean;
begin
   Result := false;
   with DataModule_Comun.Qry_General do
   begin
      Sql.Clear;
      SQL.Add('SELECT a.* '
             +'  FROM QS_TEMP_1041_ANEXO3A_OMD  a ');
      SQL.Add(' WHERE a.FOLIO_INTERNO = :FOLIO_INTERNO '
             +'   AND a.ITEM_OMD      = :ITEM_OMD '
             +'   and a.TRANSACCION   = :TRANSACCION '
             +'   and a.EMPRESA       = :EMPRESA ');
      ParamByName('FOLIO_INTERNO').AsString := sFolio_Interno;
      ParamByName('ITEM_OMD').AsFloat       := fItem_OMD;
      ParamByName('TRANSACCION').AsString   := sTransaccion;
      ParamByName('EMPRESA').AsString       := sEmpresa;
      try
        Open;
        if not eof then
           Result := true;
      except on E:EFDDBEngineException do
        begin
          Result := false;
        end;
      end;
      Close;
   end;
end;

procedure borra_historial_log(sLogin_Sistema : String;
                              fNro_Historia  : Integer);
var
  fNro_Reg,
  fCuenta      : Integer;
  sin_error    : Boolean;
  dFecha_Salir : TDateTime;
begin
  sin_error := True;
  with DataModule_Comun.Qry_General do
  begin
    Close;
    Sql.Clear;
    SQL.Add('SELECT *'
           +'  FROM QS_SYS_LOGIN_HIS '
           +' WHERE login_sistema = :Login_sistema ');

    ParamByName('Login_Sistema').AsString := sLogin_Sistema;
    open;
    fNro_Reg := 0;
    fNro_Reg := RecordCount;

    if fNro_Reg >= fNro_Historia then
    begin
      fNro_Reg := fNro_Reg - fNro_Historia;

      Close;
      Sql.Clear;
      SQL.Add('SELECT a.*'
             +'  FROM QS_SYS_LOGIN_HIS a'
             +' WHERE a.login_sistema = :Login_sistema '
             +' ORDER BY a.fecha_creacion desc');

      ParamByName('Login_Sistema').AsString := sLogin_Sistema;

      Open;
      fCuenta := 0;
      while not eof do
      begin
        fCuenta := fCuenta + 1;
        if fCuenta = fNro_Historia then
        begin
          dFecha_Salir := DataModule_Comun.Qry_General.FieldByName('Fecha_Creacion').AsDateTime;
          break;
        end;
        next;
      end;

      with DataModule_Comun.QryLicencia do
      begin
        Close;
        Sql.Clear;
        SQL.Add(' DELETE FROM QS_SYS_LOGIN_HIS '
               +' WHERE login_sistema  = :Login_sistema '
               +'   AND fecha_creacion <= :Fecha_Creacion ');

        ParamByName('Login_Sistema').AsString    := sLogin_Sistema;
        ParamByName('Fecha_Creacion').AsDate := dFecha_Salir;

        Try
          ExecSQL;
        except
        end;
      end;
    end;
    Close;
  end;
end;

function Parametro_encriptado( sProceso   : String;
                               sParametro : String) : Boolean;
begin
  with DataModule_Comun.Qry_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.*'
           +'  FROM QS_SYS_PARAM_PROCESO a'
           +' WHERE a.Proceso   = :Proceso'
           +'   AND a.Parametro = :Parametro'
           +'   AND a.Valor     = :Valor'
           );

      ParamByName('Proceso').AsString   := 'ZCRIPT';  // Le puse ZCRIPT solo para que ese parametro paraeciera al final en la ventana de ayuda
      ParamByName('Parametro').AsString := sProceso;
      ParamByName('Valor').AsString     := sParametro;

      Open;
      if FieldByName('Valor').IsNull then
         Result := False
      else
         Result := True;
      Close;
  end;
end;
function SelectCountSql(const SqlQuery: string; Parametros : array of string; TipoDatos : array of TFieldType
                        ; valores : array of string): Integer;
var
 i : Integer;
 QueryCount : TFDQuery;

begin
    QueryCount := TFDQuery.Create(nil);
    QueryCount.Connection := dmBaseDatos.Conexion_BaseDatos;
    QueryCount.SQL.Text := format('SELECT COUNT(*) FROM (%s) Z',[ SqlQuery]);

     for I := 0 to High(Parametros)  do
     case TipoDatos[i] of
       ftstring     :  QueryCount.ParamByName(parametros[i]).AsString := Valores[i];
       ftInteger    :  QueryCount.ParamByName(parametros[i]).AsFloat  := StrToInt(Valores[i]);
       ftFloat      :  QueryCount.ParamByName(parametros[i]).AsFloat  := StrToFloat(Valores[i]);
       ftDate       :  QueryCount.ParamByName(parametros[i]).AsDate   := StrToDate(Valores[i]);
       ftDateTime   :  QueryCount.ParamByName(parametros[i]).AsDateTime := StrToDateTime(Valores[i]);
     end;

     //QueryCount.SQL.SaveToFile('sqlcount.sql');
     QueryCount.Open;

     Result := QueryCount.Fields[0].AsInteger;
end;

//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons; Captions: array of string ;DefaultButton: TMsgDlgBtn): Integer; overload ;
//var
//   aMsgDlg: TForm;
//   i: Integer;
//   dlgButton: TButton;
//   CaptionIndex: Integer;
//begin
//   aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons,DefaultButton);
//   aMsgDlg.Caption := Titulo;
//   captionIndex := 0;
//   for i := 0 to aMsgDlg.ComponentCount - 1 do
//   begin
//     if (aMsgDlg.Components[i] is TButton) then
//     begin
//       dlgButton := TButton(aMsgDlg.Components[i]);
//       if CaptionIndex > High(Captions) then Break;
//       dlgButton.Caption := Captions[CaptionIndex];
//       Inc(CaptionIndex);
//     end;
//   end;
//   Result := aMsgDlg.ShowModal;
//end;
//
//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons; Captions: array of string): Integer; overload;
//var
//   DefaultButton: TMsgDlgBtn;
//
//begin
//  if mbOk in Buttons then DefaultButton := mbOk else
//    if mbYes in Buttons then DefaultButton := mbYes else
//      DefaultButton := mbRetry;
//   Result := myMessageDialog(Msg,Titulo, DlgType, Buttons,Captions,DefaultButton);
//end;
//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): Integer; overload;
//const
//  Captions_Es : array[0..11] of string = ('Si','No','Aceptar','Cancelar','Abortar','Reintentar','Ignorar','Todos','No a Todo','Si a Todos','Ayuda','Cerrar');
//var
//  CaptionIndex, i: Integer;
//  B : TMsgDlgBtn;
//  LCaptions : array of string;
//  valor : string;
//begin
//   i := 0;
//   SetLength(LCaptions,SizeOf(Buttons));
//   for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
//   begin
//     begin
//       if i = sizeof(Buttons) then break;
//       if B in Buttons then
//       begin
//       captionIndex := Ord(B);
//       valor := Captions_Es[captionIndex];
//       LCaptions[i] := Captions_Es[captionIndex];
//       Inc(i);
//
//       end;
//     end;
//   end;
//   Result := myMessageDialog(Msg,Titulo, DlgType, Buttons,LCaptions,DefaultButton);
//end;
//
//function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
//   Buttons: TMsgDlgButtons): Integer; overload;
//var
//  DefaultButton: TMsgDlgBtn;
//begin
//  if mbOk in Buttons then DefaultButton := mbOk else
//    if mbYes in Buttons then DefaultButton := mbYes else
//      DefaultButton := mbRetry;
//
//   Result := myMessageDialog(Msg,Titulo, DlgType, Buttons,DefaultButton);
//end;

Function Metodo_Clasificacion( sCartera,
                               sNemotecnico : String
                               ) : String;
begin

   Result := '';

  with DataModule_Comun,QRY_General2 do
   begin
      Close;
      Sql.clear;
      sql.add('SELECT c.DESCRIPCION      '
             +'      ,b.DESCRIPCION_NODO '
             +'  FROM QS_SYS_CLASIF_OBJ a'
             +'      ,QS_SYS_EST_CLA    b'
             +'      ,QS_FIN_CARTERAS   c'
             +' WHERE a.OBJETO        IN ( ''NEMOTECNIC'', ''NEMRVAR'') '
             +'   AND a.ELEMENTO      = :Nemotecnico '
             +'   AND a.CODIGO_CLASIF = :Codigo_Clasif'
             +'   AND a.CODIGO_CLASIF = b.CODIGO_OBJETO'
             +'   AND a.nodo          = b.nodo'
             +'   AND c.COD_EMPRESA   = :empresa '
             +'   AND c.COD_CARTERA   = :cartera '
             );
      ParamByName('empresa').AsString       := sEmpresa_Usuario;
      ParamByName('Nemotecnico').AsString   := sNemotecnico;
      ParamByName('cartera').AsString       := sCartera;
      ParamByName('Codigo_Clasif').AsString := 'MCV_EEFF';
      Open;
      If Not Eof then
         Result := FieldByName('DESCRIPCION_NODO').AsString;
   end;

end;


function verifica_cierre(sProceso  :String;
                         bCarteras :Boolean;
                     var dFecha    :TDateTime;
                     var sMensaje  :String):Boolean;
begin
   Result := false;
   if bCarteras then
   begin
      with DataModule_Comun,Qry_General2 do
      begin
         Close;
         Sql.Clear;
         SQL.Add('SELECT z.Empresa ,z.Cartera '
                +'  FROM QS_SYS_PARAM_EMPRESA z'
                +' WHERE z.Pid = :Pid');
         Parambyname('Pid').asFloat := Application.Handle;
         Open;
         while not eof do
         begin
            if Busca_Cierre_Cont_Nvo(sProceso
                                    ,FieldByNAme('Empresa').asString
                                    ,FieldByNAme('Cartera').asString
                                    ,'' //Tipo Contabilidad
                                    ,dFecha
                                    ,sMensaje) THEN
            begin
               Result := true;
               break;
            end;
            Next;
         end;
         Close;
      end;
   end
   else
   begin
      if Busca_Cierre_Cont_Nvo(sProceso
                              ,sEmpresa_usuario
                              ,'' //Cartera
                              ,'' //Tipo Contabilidad
                              ,dFecha
                              ,sMensaje) THEN
         Result := true;
   end;
end;

function verifica_carteras(sProceso :String;
                       var sMensaje :String):Boolean;
begin
   Result := false;
   with DataModule_Comun,Qry_General2 do
   begin
      Close;
      Sql.Clear;
      SQL.Add('SELECT z.Empresa ,z.Cartera '
             +'  FROM QS_SYS_PARAM_EMPRESA z'
             +' WHERE z.Pid = :Pid');
      Parambyname('Pid').asFloat := Application.Handle;
      Open;
      while not eof do
      begin
         if NOT Valida_Perfil_Cartera(sPerfil_Usuario, FieldByNAme('Cartera').asString) then
         begin
            sMensaje := 'Ha seleccionado cartera(s) NO válida(s) para Perfil de usuario '+sPerfil_Usuario+', consulte al Administrador ...';
            Result := true;
            break;
         end;
         Next;
      end;
      Close;
   end;

end;

procedure TDataModule_Comun.DataModuleCreate(Sender: TObject);
begin
   Tabla_Log.Open;
end;

function GetLocaleInformation(lcType : LCTYPE) : string;
var
  buffer  : PChar;
  cchData : Integer;
begin
//  cchData := GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, lcType, 0, 0);
  cchData := GetLocaleInfo(LOCALE_USER_DEFAULT, lcType, 0, 0);
  GetMem(buffer, cchData);
  try
    Result:='';
//    if GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, lcType, buffer, cchData) > 0 then
    if GetLocaleInfo(LOCALE_USER_DEFAULT, lcType, buffer, cchData) > 0 then
      Result := buffer;
  finally
    FreeMem(buffer);
  end;
end;

Procedure Datos_Cobertura_Nemotecnico(sNemotecnico    : String;
                                      sCartera        : String;
                                      dFecha_Proceso  : TDateTime;
                                      var sValor  :String);
begin
   sValor := 'N';
   with DataModule_Comun,Qry_General2 do
   begin
      Close;
      Sql.Clear;
      SQL.Add('SELECT a.Valor '
             +'  FROM QS_FIN_NEM_DATADI_UNI a'
             +' WHERE a.Nemotecnico = :Nemotecnico');
// E.S. & J.D. 11-01-2018, al no condicionar la cartera, traia siempre la cobertura para cualquier el nemo, independiente si estaba o no definido para la cartera
//      if sCartera <> '' then
//      begin
         SQL.Add(' AND a.Cartera = :Cartera');
         Parambyname('Cartera').asString := sCartera;
//      end;
      SQL.Add(' AND a.Fecha_Desde <= :Fecha');
      SQL.Add(' AND (a.Fecha_Hasta >= :Fecha OR a.Fecha_Hasta Is Null)');
      SQL.Add(' AND a.Tipo_Dato = :Tipo_Dato');
      Parambyname('Nemotecnico').asString := sNemotecnico;
      Parambyname('Fecha').AsDate     := dFecha_Proceso;
      Parambyname('Tipo_Dato').asString := 'TIPOCOB';
      Open;
      if FieldByName('Valor').asString <> '' then
         sValor := FieldByName('Valor').asString;
      Close;
   end;
end;

procedure Llena_Carteras_Lim(sProceso : String);
begin

//  if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
//     dmBaseDatos.Conexion_BaseDatos.StartTransaction;

  with DataModule_Comun,Qry_General2 do
  begin
    Close;
    Sql.Clear;
    Sql.Add('DELETE FROM QS_SYS_PARAM_EMPRESA '
           +' WHERE pid     = :Pid');

    ParamByName('pid').AsFloat := Application.Handle;

    try
      ExecSQL;
    except on E:EFDDBEngineException do
     begin
//       if dmBaseDatos.Conexion_BaseDatos.InTransaction then
//          dmBaseDatos.Conexion_BaseDatos.Rollback;
       ShowError(E);
       Close;
       Exit;
     end;
    end;

    Close;
    Sql.Clear;
    Sql.Add(' INSERT INTO QS_SYS_PARAM_EMPRESA ');
    Sql.Add(' SELECT DISTINCT :pid, :EMPRESA, a.CARTERA '
           +'   FROM QS_SUP_251_LIM_CARTERA a'
           +'  WHERE a.PROCESO = :PROCESO ');

    ParamByName('pid').AsFloat      := Application.Handle;
    ParamByName('EMPRESA').AsString := sEmpresa_Usuario;
    ParamByName('PROCESO').AsString := sProceso;

    try
       ExecSQL;
    except on E:EFDDBEngineException do
     begin
//       if dmBaseDatos.Conexion_BaseDatos.InTransaction then
//          dmBaseDatos.Conexion_BaseDatos.Rollback;
       ShowError(E);
       Close;
       Exit;
     end;
    end;
  end;

//  if dmBaseDatos.Conexion_BaseDatos.InTransaction then
//     dmBaseDatos.Conexion_BaseDatos.Commit;

end;

procedure Tiene_Limite(dfecha             : TDateTime;
                       var sString_RTPR   : String;
                       var sString_Limite : String);

var b_Existe   : Boolean;
//    aux_string : String;

begin

  b_Existe := false;
  with DataModule_Comun.QryLicencia do
  begin
    Close;
    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TMP_GRUPO '
           +'  WHERE pid = :pid ');

    ParamByName('PID').AsFloat := Application.handle;


    Try
      execSql;
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
      end;
    end;

    Close;
    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TMP_LIMITE '
           +'  WHERE pid = :pid ');

    ParamByName('PID').AsFloat := Application.handle;

    Try
      execSql;
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
      end;

    end;

    Close;
    Sql.Clear;
    Sql.Add(' INSERT INTO QS_TMP_GRUPO ');
    Sql.Add(' SELECT DISTINCT :PID,a.CODIGO_RTPR,a.FECHA_DESDE,c.CODIGO_LIMITE,c.FECHA_DESDE,c.PROCESO  ');
    Sql.Add('  FROM qs_sup_251_rtpr a  ' );
    Sql.Add('      ,qs_sup_251_rtpr_det b  ' );
    Sql.Add('      ,qs_sup_251_lim c  '  );
    Sql.Add('      ,qs_sup_251_lim_det d ' );
    Sql.Add('      ,qs_sup_251_lim_cartera e  ');
    Sql.Add('      ,qs_tmp_omd_limite f  ');
    Sql.Add(' WHERE f.pid            = :PID ');
    Sql.Add('   AND a.Fecha_Desde   <= :Fecha  ' );
    Sql.Add('   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha) ' );
    Sql.Add('   AND b.codigo_rtpr    = a.codigo_rtpr ' );
    Sql.Add('   AND b.fecha_desde    = a.fecha_desde  '  );
    Sql.Add('   AND b.instrumento    = f.instrumento ');
    Sql.Add('   AND c.proceso       in (SELECT VALOR FROM QS_SYS_PARAM_PROCESO WHERE PROCESO = ''LIMTRA'' AND PARAMETRO = f.empresa )' );
    Sql.Add('   AND c.Fecha_Desde   <= :Fecha');
    Sql.Add('   AND (c.Fecha_Hasta IS NULL OR c.Fecha_Hasta >= :Fecha) ' );
    Sql.Add('   AND d.PROCESO        = c.proceso  '   );
    Sql.Add('   AND d.CODIGO_LIMITE  = c.CODIGO_LIMITE ' );
    Sql.Add('   AND d.fecha_desde    = c.fecha_desde '   );
    Sql.Add('   AND d.codigo_rtpr    = b.CODIGO_RTPR  '  );
    Sql.Add('   AND (d.estrategia    = f.estrategia OR d.estrategia IS NULL OR RTRIM(d.estrategia) = '''')  ');
    Sql.Add('   AND e.codigo_limite  = c.codigo_limite '  );
    Sql.Add('   AND e.proceso        = c.proceso   '      );
    Sql.Add('   AND e.fecha_desde    = c.fecha_desde  '   );
    Sql.Add('   AND e.cartera        = f.cartera  ');

    ParamByName('PID').AsFloat      := Application.handle;
    Parambyname('fecha').AsDate := dFecha;

    Try
      ExecSql
     except on E: EFDDBEngineException do
      begin
         ShowError(E);
      end;
    end;

    Close;
    Sql.Clear;
    Sql.Add(' INSERT INTO QS_TMP_LIMITE ');
    Sql.Add(' SELECT DISTINCT :PID,x.CODIGO_RTPR,x.FECHA_DESDE,y.CODIGO_LIMITE,y.FECHA_DESDE_LIMITE,y.PROCESO ');
    Sql.Add('   FROM QS_SUP_251_RTPR     x ');
    Sql.Add('  	    ,QS_TMP_GRUPO	       y ');
    Sql.Add('	      ,QS_SUP_251_RTPR_DET z ');
    Sql.Add('       ,qs_tmp_omd_limite   h ');
    Sql.Add('  WHERE h.pid = :PID');
    Sql.Add('    AND y.PID = h.pid ');
    Sql.Add('    AND x.CODIGO_RTPR = y.CODIGO_RTPR ');
    Sql.Add('    AND x.FECHA_DESDE = y.FECHA_DESDE_GRUPO ');
    Sql.Add('    AND (X.NACION = '' '' OR X.NACION IS NULL OR (x.NACION IN ( SELECT D.NACION_PAIS ');
                      Sql.Add('	      FROM QS_SYS_PAIS D ');
                      Sql.Add('	     WHERE D.COD_PAIS IN (SELECT B.COD_PAIS ');
                                              Sql.Add('	    FROM QS_SYS_DESC_GEO B ');
                                              Sql.Add('	   WHERE B.COD_DESC_DIVISION IN (SELECT A.CODIGO_GEO ');
                                                                  Sql.Add('	           FROM QS_SYS_ID_DIR A ');
                                                                  Sql.Add('               WHERE A.CODIGO_IDENTIDAD = h.emisor ');
                                                                  Sql.Add('	            AND A.ITEM_DIR  IN (SELECT MIN(C.ITEM_DIR) ');
                                                                                                   Sql.Add('      FROM QS_SYS_ID_DIR C ');
                                                                                                   Sql.Add('     WHERE C.CODIGO_IDENTIDAD = A.CODIGO_IDENTIDAD ');
                                                                                                   Sql.Add('       AND C.FECHA_DESDE <= :fecha ');
                                                                                                    Sql.Add('      AND (C.FECHA_HASTA >= :fecha OR C.FECHA_HASTA IS NULL))))))) ');
    Sql.Add(' AND z.CODIGO_RTPR = x.CODIGO_RTPR ');
    Sql.Add(' AND z.FECHA_DESDE = x.FECHA_DESDE ');
    Sql.Add(' AND z.INSTRUMENTO = h.instrumento ');

    ParamByName('PID').AsFloat      := Application.handle;
    Parambyname('fecha').AsDate := dFecha;

    Try
      ExecSql
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
      end;
    end;


   // if bdesarrollo then
//       dmBaseDatos.Conexion_BaseDatos.Commit;
//       Exit;


//          aux_string := 'AHORA EJECUTEN LOS SELECT SIN SALIR DE LA OPERACION'+datetostr(dFecha)+' '+floattostr(Application.handle);
//          Application.MessageBox(pchar(aux_string)
//                                ,'Sistema'
//                                , mb_OK +  MB_ICONError
//                                );


    Close;
    Sql.Clear;
    Sql.Add(' SELECT DISTINCT a.CODIGO_RTPR, a.codigo_limite ');
    Sql.Add('   FROM QS_TMP_LIMITE A   ');
    Sql.Add('       ,QS_SUP_251_LIM_DET B ');
    Sql.Add('       ,qs_tmp_omd_limite h ');
    Sql.Add('       ,QS_SUP_251_LIM_NEMO c ');
    Sql.Add('  WHERE h.pid                = :PID');
    Sql.Add('    AND A.PID                = h.pid ');
    Sql.Add('    AND A.PROCESO            = B.PROCESO ');
    Sql.Add('    AND A.FECHA_DESDE_LIMITE = B.FECHA_DESDE ');
    Sql.Add('    AND A.CODIGO_LIMITE      = B.CODIGO_LIMITE ');
    Sql.Add('    AND (B.EMISOR = h.emisor OR B.EMISOR IS NULL) ');
    Sql.Add('    AND c.proceso            = b.proceso  ');
	  Sql.Add('    AND c.fecha_desde        = b.fecha_desde ');
	  Sql.Add('    AND c.codigo_limite      = b.codigo_limite ');
	  Sql.Add('    AND c.codigo_NEMOTECNICO = h.nemotecnico ');
    Sql.Add(' UNION ');
    Sql.Add(' SELECT DISTINCT a.CODIGO_RTPR, a.codigo_limite ');
    Sql.Add('   FROM QS_TMP_LIMITE A   ');
    Sql.Add('       ,QS_SUP_251_LIM_DET B ');
    Sql.Add('       ,qs_tmp_omd_limite h ');
    Sql.Add('  WHERE h.pid                = :PID');
    Sql.Add('    AND A.PID                = h.pid ');
    Sql.Add('    AND A.PROCESO            = B.PROCESO ');
    Sql.Add('    AND A.FECHA_DESDE_LIMITE = B.FECHA_DESDE ');
    Sql.Add('    AND A.CODIGO_LIMITE      = B.CODIGO_LIMITE ');
    Sql.Add('    AND (B.EMISOR = h.emisor OR B.EMISOR IS NULL) ');
    Sql.Add('    AND NOT EXISTS (SELECT c.proceso  ');
   	Sql.Add('   		  	           FROM QS_SUP_251_LIM_NEMO c ');
	  Sql.Add(' 			              WHERE c.proceso = b.proceso  ');
		Sql.Add('		                    AND c.fecha_desde = b.fecha_desde ');
		Sql.Add('	                    	AND c.codigo_limite = b.codigo_limite) ');

    ParamByName('PID').AsFloat := Application.handle;

    Try
      Open
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
      end;
    end;

    sString_RTPR   := '(''''';
    sString_Limite := '(''''';
    while not eof do
    begin
      b_Existe       := True;
      sString_RTPR   := sString_RTPR+','''+FieldByName('CODIGO_RTPR').AsString+'''';
      sString_Limite := sString_Limite+','''+FieldByName('codigo_limite').AsString+'''';
      next;
    end;
    sString_RTPR   := sString_RTPR+')';
    sString_Limite := sString_Limite+')';

    if Not b_Existe then
    begin
      sString_RTPR   := '';
      sString_Limite := '';
    end;


    Close;
    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TMP_GRUPO '
           +'  WHERE PID = :PID  ');

    ParamByName('PID').AsFloat              := Application.handle;

    Try
      execSql;
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
      end;
    end;

    Close;
    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TMP_LIMITE '
           +'  WHERE PID = :PID ');

    ParamByName('PID').AsFloat              := Application.handle;

    Try
      execSql;
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
      end;
    end;

    Close;
  end;
end;

function elimina_OMD_Limite_RV(sEmpresa       : String;
                               sCartera       : String;
                               sTransaccion   : String;
                               sFolio_interno : String;
                               dfecha_hora    : TDateTime;
                               fValor_Pte_Mix : Double;
                               sNemotecnico   : String;
                               fValor_Nominal : Double;
                               sEstrategia    : String;
                               sAccion        : String): Boolean;
var
  dFecha_proceso : TDateTime;
//  fvalor_final_svs_mc,
//  fvalor_pte_mc_mixta,
  fPrecio_limite,
  fValor_limite_prom,
  fValor_Nominal_Limite,
  fValor_Pte_Cartera : Double;
begin
//// sAccion
//// 'A' ---> anular Compra Rv
//// 'V' ---> venta Rv
//// 'N' ---> anula Vta Rv


  Result := TRUE;

  DataModule_Comun.QryLicencia.Close;
  DataModule_Comun.QryLicencia.Sql.Clear;
  DataModule_Comun.QryLicencia.Sql.Add('SELECT a.VALOR as Proceso '
                                      +'  FROM QS_SYS_PARAM_PROCESO a '
                                      +' WHERE a.PROCESO   = ''LIMTRA''  '
                                      +'   AND a.PARAMETRO = :Empresa ');

  DataModule_Comun.QryLicencia.ParamByName('Empresa').AsString := sEmpresa;

  DataModule_Comun.QryLicencia.Open;

  While Not DataModule_Comun.QryLicencia.eof do
  begin
    With DataModule_Comun.Qry_General2 do
    begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT MAX(a.fecha_proceso) as fecha_proceso'
             +'  FROM qs_tra_251_det a '
             +' WHERE a.empresa         = :empresa '
             +'   AND a.cartera         = :cartera'
             +'   AND a.proceso         = :proceso'
             +'   AND a.fecha_proceso  <= :fecha_proceso ');
      Sql.Add('   AND a.transaccion IN (SELECT x.codigo_transaccion    ');
      Sql.Add('                            FROM QS_SYS_TRAN_IMPLIC x   ');
      Sql.Add('                           WHERE x.implicancia = ''RV'') ');
      Sql.Add('   AND a.Nemotecnico     = :Nemotecnico ');

      ParamByName('empresa').AsString         := sempresa;
      ParamByName('cartera').AsString         := scartera;
      ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
      ParamByName('fecha_proceso').AsDate     := solo_fecha(dfecha_hora);
      ParamByName('Nemotecnico').AsString     := sNemotecnico;

      Try
        Open
      except on E: EFDDBEngineException do
        begin
          ShowError(E);
          Result := False;
          exit;
        end;
      end;

      dFecha_proceso := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;

      Close;
      Sql.Clear;
      Sql.Add('SELECT a.fecha_proceso'
             +'      ,a.proceso '
             +'      ,a.codigo_limite '
             +'      ,a.codigo_rtpr '
             +'      ,SUM(a.Valor_Pte_MC_Cpa) as Valor_Pte_MC_Cpa  '
             +'      ,SUM(a.Valor_Nominal) as Valor_Nominal  '
             +'  FROM qs_tra_251_det a '
             +' WHERE a.empresa       = :empresa '
             +'   AND a.cartera       = :cartera'
             +'   AND a.proceso       = :proceso'
             +'   AND a.fecha_proceso = :fecha_proceso ');
      Sql.Add('   AND a.transaccion IN (SELECT x.codigo_transaccion    ');
      Sql.Add('                            FROM QS_SYS_TRAN_IMPLIC x   ');
      Sql.Add('                           WHERE x.implicancia = ''RV'') ');
      Sql.Add('   AND a.Nemotecnico   = :Nemotecnico ');
      sql.Add(' GROUP BY a.fecha_proceso'
             +'         ,a.proceso '
             +'         ,a.codigo_limite '
             +'         ,a.codigo_rtpr ');

      ParamByName('empresa').AsString         := sempresa;
      ParamByName('cartera').AsString         := scartera;
      ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
      ParamByName('fecha_proceso').AsDate     := dFecha_proceso;
      ParamByName('Nemotecnico').AsString     := sNemotecnico;

      Open;

      while not eof do
      begin
        fValor_Pte_Cartera :=  0;
        fValor_Nominal_Limite := 0;
        fValor_limite_prom := fValor_Pte_Mix;
        with DataModule_Comun.Qry_Deterioro do
        begin
          if (sAccion = 'A') or (sAccion = 'V') then
          begin
            fValor_Nominal_Limite := DataModule_Comun.Qry_General2.FieldByName('Valor_Nominal').AsFloat - fValor_Nominal;

            if fValor_Nominal_Limite = 0 then
              fValor_Pte_Cartera := 0;

            if (fValor_Nominal_Limite > 0) then
            begin
              if (sAccion = 'V') then
              begin
                fPrecio_limite := DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat / DataModule_Comun.Qry_General2.FieldByName('Valor_Nominal').AsFloat;
                fValor_limite_prom := fPrecio_limite * fValor_Nominal;
                fValor_Pte_Cartera := DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat - fValor_limite_prom;
              end
              else
              begin
                fValor_Pte_Cartera := DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat - fValor_Pte_Mix;
              end;
            end;

            if fValor_Nominal_Limite >= 0 then
            begin
              Close;
              Sql.Clear;
              Sql.Add(' UPDATE QS_TRA_251 '
                     +'    SET Valor_Pte_Cartera = :Valor_OMD'
                     +' WHERE empresa       = :empresa '
                     +'   and proceso       = :proceso '
                     +'   AND fecha_proceso = :fecha '
                     +'   AND codigo_limite = :codigo_limite ');


              ParamByName('empresa').AsString       := sempresa;
              ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
              ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
              ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
              ParamByName('Valor_OMD').AsFloat      := fValor_Pte_Cartera;

              try
                ExecSQL
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;
            end
            else
            begin
              Result := False;
              exit;
            end;

            Close;
            Sql.Clear;
            Sql.Add('UPDATE qs_tra_251_det ');
            Sql.Add(' SET valor_nominal = valor_nominal - :nominal ' );
            if fValor_Nominal_Limite = 0 then
               Sql.Add(' ,valor_pte_mc_cpa = 0 ')
            else
               Sql.Add(' ,valor_pte_mc_cpa = valor_pte_mc_cpa - :valor_omd ') ;
            Sql.Add(' WHERE empresa       = :empresa '
                   +'   AND cartera       = :cartera'
                   +'   AND proceso       = :proceso'
                   +'   AND codigo_limite = :codigo_limite '
                   +'   AND codigo_rtpr   = :codigo_rtpr '
                   +'   AND fecha_proceso = :fecha_proceso ');
            Sql.Add('   AND transaccion   IN (SELECT x.codigo_transaccion    ');
            Sql.Add('                            FROM QS_SYS_TRAN_IMPLIC x   ');
            Sql.Add('                           WHERE x.implicancia = ''RV'') ');
            Sql.Add('   AND nemotecnico   = :nemotecnico ');

            ParamByName('empresa').AsString         := sempresa;
            ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
            ParamByName('codigo_limite').AsString   := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
            ParamByName('codigo_rtpr').AsString     := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
            ParamByName('fecha_proceso').AsDate     := dFecha_proceso;
            ParamByName('cartera').AsString         := scartera;
            ParamByName('nemotecnico').AsString     := snemotecnico;
            if fValor_Nominal_Limite <> 0 then
               ParamByName('valor_omd').AsFloat     := fValor_limite_prom; //fValor_Pte_Mix; DC 29/08/2017
            ParamByName('nominal').AsFloat          := fValor_Nominal;

            try
              ExecSQL
            except on E: EFDDBEngineException do
              begin
                 ShowError(E);
                 Result := False;
                 exit;
              end;
            end;
          end
          else
          begin
            if (sAccion = 'N') then
            begin
              if (DataModule_Comun.Qry_General2.FieldByName('Valor_Nominal').AsFloat > 0) and (DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat > 0) then
              begin
                fPrecio_limite := DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat / DataModule_Comun.Qry_General2.FieldByName('Valor_Nominal').AsFloat;
                fValor_limite_prom := fPrecio_limite * fValor_Nominal;
              end
              else
                fValor_limite_prom := fValor_Pte_Mix;

              Close;
              Sql.Clear;
              Sql.Add(' UPDATE QS_TRA_251 '
                     +'    SET Valor_Pte_Cartera = Valor_Pte_Cartera + :Valor_OMD'
                     +' WHERE empresa       = :empresa '
                     +'   and proceso       = :proceso '
                     +'   AND fecha_proceso = :fecha '
                     +'   AND codigo_limite = :codigo_limite ');


              ParamByName('empresa').AsString       := sempresa;
              ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
              ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
              ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
              ParamByName('Valor_OMD').AsFloat      := fValor_limite_prom; // fValor_Pte_Mix; DC 29/08/2017

              try
                ExecSQL
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;


              Close;
              Sql.Clear;
              Sql.Add('UPDATE qs_tra_251_det ');
              Sql.Add(' SET valor_nominal = valor_nominal + :nominal '
                     +'    ,valor_pte_mc_cpa = valor_pte_mc_cpa + :valor_omd ');
              Sql.Add(' WHERE empresa       = :empresa '
                     +'   AND cartera       = :cartera'
                     +'   AND proceso       = :proceso'
                     +'   AND codigo_limite = :codigo_limite '
                     +'   AND codigo_rtpr   = :codigo_rtpr '
                     +'   AND fecha_proceso = :fecha_proceso ');
              Sql.Add('   AND nemotecnico   = :nemotecnico ');

              ParamByName('empresa').AsString         := sempresa;
              ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
              ParamByName('codigo_limite').AsString   := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
              ParamByName('codigo_rtpr').AsString     := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
              ParamByName('fecha_proceso').AsDate     := dFecha_proceso;
              ParamByName('cartera').AsString         := scartera;
              ParamByName('nemotecnico').AsString     := snemotecnico;
              ParamByName('valor_omd').AsFloat        := fValor_limite_prom; // fValor_Pte_Mix; DC29/08/2017
              ParamByName('nominal').AsFloat          := fValor_Nominal;


              try
                ExecSQL
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;

              Close;
              Sql.Clear;
              Sql.Add(' INSERT INTO QS_TRA_251_OMD '
                     +' SELECT a.empresa '
                     +'       ,a.cartera '
                     +'       ,a.fecha_proceso '
                     +'       ,a.proceso '
                     +'       ,a.codigo_limite '
                     +'       ,a.codigo_rtpr '
                     +'       ,''CRV'' '
                     +'       ,:Folio_interno ' //'' '' '
                     +'       ,:estrategia '
                     +'       ,a.nemotecnico '
                     +'       ,:valor_OMD '
                     +'       ,:valor_OMD '
                     +'       ,b.maximo_permitido '
                     +'       ,b.valor_pte_cartera '
                     +'  FROM QS_TRA_251_DET a'
                     +'      ,QS_TRA_251 b'
                     +' WHERE a.empresa       = :empresa '
                     +'   and a.proceso       = :proceso '
                     +'   AND a.fecha_proceso = :fecha '
                     +'   AND a.codigo_limite = :codigo_limite '
                     +'   AND a.codigo_rtpr   = :codigo_rtpr '
                     +'   and b.empresa       = a.empresa '
                     +'   and b.proceso       = a.proceso '
                     +'   AND b.fecha_proceso = a.fecha_proceso '
                     +'   AND b.codigo_limite = a.codigo_limite '
                     +'   AND a.cartera       = :cartera '
                     +'   AND a.nemotecnico   = :nemotecnico '
                     +'   AND b.maximo_permitido <  b.valor_pte_cartera');

              ParamByName('empresa').AsString       := sempresa;
              ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
              ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
              ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
              ParamByName('codigo_rtpr').AsString   := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
              ParamByName('Folio_interno').AsString := sFolio_interno;
              ParamByName('cartera').AsString       := scartera;
              ParamByName('estrategia').AsString    := sestrategia;
              ParamByName('Nemotecnico').AsString   := sNemotecnico;
              ParamByName('valor_OMD').AsFloat      := fValor_Pte_Mix;

              try
                ExecSQL
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;

            end;
          end;
        end; ///with Qry_Aux do
        DataModule_Comun.Qry_General2.next;
      end;
      DataModule_Comun.Qry_General2.Close;
    end;

    if (sAccion = 'A') then
    begin
      DataModule_Comun.Qry_General2.Close;
      DataModule_Comun.Qry_General2.Sql.Clear;
      DataModule_Comun.Qry_General2.Sql.Add(' DELETE FROM QS_TRA_251_OMD '
                                           +' WHERE empresa       = :empresa '
                                           +'   and proceso       = :proceso '
                                           +'   AND transaccion   = :transaccion '
                                           +'   AND folio_interno = :folio_interno');

      DataModule_Comun.Qry_General2.ParamByName('empresa').AsString       := sempresa;
      DataModule_Comun.Qry_General2.ParamByName('proceso').AsString       := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
      DataModule_Comun.Qry_General2.ParamByName('transaccion').AsString   := sTransaccion;
      DataModule_Comun.Qry_General2.ParamByName('folio_interno').AsString := sFolio_interno;

      try
        DataModule_Comun.Qry_General2.ExecSQL
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           Result := False;
           exit;
        end;
      end;
    end;

    DataModule_Comun.QryLicencia.Next;
  end;
  DataModule_Comun.QryLicencia.Close;

end;

function elimina_OMD_Limite_RF(sEmpresa       : String;
                               sTransaccion   : String;
                               sFolio_interno : String;
                               dfecha_hora    : TDateTime;
                               fValor_Pte_Mix : Double;
                               sNemotecnico   : String;
                               fValor_Nominal : Double;
                               sEstrategia    : String;
                               sAccion        : String): Boolean;
var
  dFecha_proceso : TDateTime;
  fvalor_final_svs_mc,
  fvalor_pte_mc_mixta,
  fValor_Pte_Cartera : Double;
  bexcedida     : Boolean;
begin
//// sAccion
//// 'A' ---> anular Compra RF
//// 'V' ---> venta RF
//// 'N' ---> anula Vta RF


  Result := TRUE;

  DataModule_Comun.QryLicencia.Close;
  DataModule_Comun.QryLicencia.Sql.Clear;
  DataModule_Comun.QryLicencia.Sql.Add('SELECT a.VALOR as Proceso '
                                      +'  FROM QS_SYS_PARAM_PROCESO a '
                                      +' WHERE a.PROCESO   = ''LIMTRA''  '
                                      +'   AND a.PARAMETRO = :Empresa ');

  DataModule_Comun.QryLicencia.ParamByName('Empresa').AsString := sEmpresa;

  DataModule_Comun.QryLicencia.Open;

  While Not DataModule_Comun.QryLicencia.eof do
  begin
    With DataModule_Comun.Qry_General2 do
    begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT MAX(a.fecha_proceso) as fecha_proceso'
             +'  FROM qs_tra_251_det a '
             +' WHERE a.empresa       = :empresa '
             +'   AND a.proceso       = :proceso'
             +'   AND a.fecha_proceso <= :fecha_proceso ');
      Sql.Add('   AND a.transaccion   = :transaccion '
             +'   AND a.folio_interno = :folio_interno ');

      ParamByName('empresa').AsString         := sempresa;
      ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
      ParamByName('fecha_proceso').AsDate     := solo_fecha(dfecha_hora);
      ParamByName('transaccion').AsString     := stransaccion;
      ParamByName('folio_interno').AsString   := sfolio_interno;

      Try
        Open
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           Result := False;
           exit;
        end;
      end;

      dFecha_proceso := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;

      Close;
      Sql.Clear;
      Sql.Add('SELECT a.fecha_proceso'
             +'      ,a.proceso '
             +'      ,a.codigo_limite '
             +'      ,a.codigo_rtpr '
             +'      ,SUM(a.Valor_Pte_MC_Cpa) as Valor_Pte_MC_Cpa  '
             +'      ,SUM(a.Valor_Nominal) as Valor_Nominal  '
             +'  FROM qs_tra_251_det a '
             +' WHERE a.empresa       = :empresa '
             +'   AND a.proceso       = :proceso'
             +'   AND a.fecha_proceso = :fecha_proceso ');
      Sql.Add('   AND a.transaccion   = :transaccion '
             +'   AND a.folio_interno = :folio_interno ');

      if (sAccion = 'V') or (sAccion = 'N') then
      begin
         Sql.Add(' AND a.Nemotecnico   = :Nemotecnico ');
         ParamByName('Nemotecnico').AsString   := sNemotecnico;
      end;

      sql.Add(' GROUP BY a.fecha_proceso'
             +'         ,a.proceso '
             +'         ,a.codigo_limite '
             +'         ,a.codigo_rtpr ');

      ParamByName('empresa').AsString         := sempresa;
      ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
      ParamByName('fecha_proceso').AsDate     := dFecha_proceso;
      ParamByName('transaccion').AsString     := stransaccion;
      ParamByName('folio_interno').AsString   := sfolio_interno;

      Open;

      while not eof do
      begin
        with DataModule_Comun.Qry_Deterioro do
        begin
          Close;
          Sql.Clear;
          Sql.Add(' select Valor_Pte_Cartera from QS_TRA_251 '
                 +' WHERE empresa       = :empresa '
                 +'   and proceso       = :proceso '
                 +'   AND fecha_proceso = :fecha '
                 +'   AND codigo_limite = :codigo_limite ');

          ParamByName('empresa').AsString       := sempresa;
          ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
          ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
          ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;

          Try
            Open;
          except on E: EFDDBEngineException do
            begin
              ShowError(E);
              Result := False;
              exit;
            end;
          end;

          fValor_Pte_Cartera := FieldByName('Valor_Pte_Cartera').AsFloat;
          if sAccion = 'A' then
          begin
            fValor_Pte_Cartera := fValor_Pte_Cartera - DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat;
            if fValor_Pte_Cartera >= 0 then
            begin
              Close;
              Sql.Clear;
              Sql.Add(' UPDATE QS_TRA_251 '
                     +'    SET Valor_Pte_Cartera = :Valor_OMD'
                     +' WHERE empresa       = :empresa '
                     +'   and proceso       = :proceso '
                     +'   AND fecha_proceso = :fecha '
                     +'   AND codigo_limite = :codigo_limite ');


              ParamByName('empresa').AsString       := sempresa;
              ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
              ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
              ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
              ParamByName('Valor_OMD').AsFloat      := fValor_Pte_Cartera;

              try
                ExecSQL
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;
            end
            else
            begin
              Result := False;
              exit;
            end;
          end
          else
          begin
            if (sAccion = 'V') or (sAccion = 'N') then
            begin
              if (sAccion = 'V') then
              begin
                 if fValor_Pte_Cartera < fValor_Pte_Mix then
                 begin
                   Result := False;
                   exit;
                 end;
                 fValor_Pte_Cartera := fValor_Pte_Cartera - fValor_Pte_Mix
              end
              else
                 fValor_Pte_Cartera := fValor_Pte_Cartera + fValor_Pte_Mix;

              if fValor_Pte_Cartera >= 0 then
              begin
                Close;
                Sql.Clear;
                Sql.Add(' UPDATE QS_TRA_251 '
                       +'    SET Valor_Pte_Cartera = :Valor_OMD'
                       +' WHERE empresa       = :empresa '
                       +'   and proceso       = :proceso '
                       +'   AND fecha_proceso = :fecha '
                       +'   AND codigo_limite = :codigo_limite ');


                ParamByName('empresa').AsString       := sempresa;
                ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
                ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
                ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
                ParamByName('Valor_OMD').AsFloat      := fValor_Pte_Cartera;

                try
                  ExecSQL
                except on E: EFDDBEngineException do
                  begin
                     ShowError(E);
                     Result := False;
                  end;
                end;
              end
              else
              begin
                 Result := False;
                 exit;
              end;

              Close;
              Sql.Clear;
              Sql.Add(' SELECT * '
                     +'  FROM QS_TRA_251'
                     +' WHERE empresa       = :empresa '
                     +'   and proceso       = :proceso '
                     +'   AND fecha_proceso = :fecha '
                     +'   AND codigo_limite = :codigo_limite '
                     +'   AND maximo_permitido < valor_pte_cartera ');


              ParamByName('empresa').AsString       := sempresa;
              ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
              ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
              ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;

              try
                Open
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;

              bexcedida := false;
              if Not eof then
                 bexcedida := true;

              Close;
              Sql.Clear;
              Sql.Add(' SELECT valor_final_svs_mc,valor_pte_mc_mixta,valor_pte_cartera'
                     +'  FROM QS_TRA_251_OMD '
                     +' WHERE empresa       = :empresa '
                     +'   and proceso       = :proceso '
                     +'   AND fecha_proceso = :fecha '
                     +'   AND codigo_limite = :codigo_limite '
                     +'   AND codigo_rtpr   = :codigo_rtpr '
                     +'   AND transaccion   = :transaccion '
                     +'   AND folio_interno = :folio_interno'
                     +'   AND nemotecnico   = :nemotecnico ');

              ParamByName('empresa').AsString       := sempresa;
              ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
              ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
              ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
              ParamByName('codigo_rtpr').AsString   := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
              ParamByName('transaccion').AsString   := sTransaccion;
              ParamByName('folio_interno').AsString := sFolio_interno;
              ParamByName('Nemotecnico').AsString   := sNemotecnico;

              Try
                Open
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;

              if Not DataModule_Comun.Qry_Deterioro.eof then
              begin
                if (sAccion = 'V') then
                begin
                  fvalor_final_svs_mc := FieldByName('valor_final_svs_mc').AsFloat - fValor_Pte_Mix;
                  fvalor_pte_mc_mixta := FieldByName('valor_pte_mc_mixta').AsFloat - fValor_Pte_Mix;
                  fvalor_pte_cartera  := FieldByName('Valor_Pte_Cartera').AsFloat - fValor_Pte_Mix;
                end
                else
                begin
                  fvalor_final_svs_mc := FieldByName('valor_final_svs_mc').AsFloat + fValor_Pte_Mix;
                  fvalor_pte_mc_mixta := FieldByName('valor_pte_mc_mixta').AsFloat + fValor_Pte_Mix;
                  fvalor_pte_cartera  := FieldByName('Valor_Pte_Cartera').AsFloat + fValor_Pte_Mix;
                end;

                if (fvalor_final_svs_mc >= 0) and
                   (fvalor_pte_mc_mixta >= 0) and
                   (fvalor_pte_cartera >= 0) then
                begin
                  Close;
                  Sql.Clear;
                  Sql.Add(' UPDATE QS_TRA_251_OMD '
                         +'   SET valor_final_svs_mc = :valor_final '
                         +'      ,valor_pte_mc_mixta = :valor_pte '
                         +'      ,valor_pte_cartera  = :valor_cartera'
                         +' WHERE empresa       = :empresa '
                         +'   and proceso       = :proceso '
                         +'   AND fecha_proceso = :fecha '
                         +'   AND codigo_limite = :codigo_limite '
                         +'   AND codigo_rtpr   = :codigo_rtpr '
                         +'   AND transaccion   = :transaccion '
                         +'   AND folio_interno = :folio_interno'
                         +'   AND Nemotecnico   = :Nemotecnico');

                  ParamByName('empresa').AsString       := sempresa;
                  ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
                  ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
                  ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
                  ParamByName('codigo_rtpr').AsString   := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
                  ParamByName('transaccion').AsString   := sTransaccion;
                  ParamByName('folio_interno').AsString := sFolio_interno;
                  ParamByName('Nemotecnico').AsString   := sNemotecnico;
                  ParamByName('valor_final').AsFloat    := fvalor_final_svs_mc;
                  ParamByName('valor_pte').AsFloat      := fvalor_pte_mc_mixta;
                  ParamByName('valor_cartera').AsFloat  := fvalor_pte_cartera;

                  try
                    ExecSQL
                  except on E: EFDDBEngineException do
                    begin
                       ShowError(E);
                       Result := False;
                       exit;
                    end;
                  end;
                end
                else
                begin
                   Result := False;
                   exit;
                end;
              end
              else
                if (bexcedida) and (sAccion = 'N') then
                begin
                  Close;
                  Sql.Clear;
                  Sql.Add(' INSERT INTO QS_TRA_251_OMD '
                         +' SELECT a.empresa '
                         +'       ,a.cartera '
                         +'       ,a.fecha_proceso '
                         +'       ,a.proceso '
                         +'       ,a.codigo_limite '
                         +'       ,a.codigo_rtpr '
                         +'       ,a.transaccion '
                         +'       ,a.folio_interno '
                         +'       ,:estrategia '
                         +'       ,a.nemotecnico '
                         +'       ,a.valor_pte_mc_cpa '
                         +'       ,a.valor_pte_mc_cpa '
                         +'       ,b.maximo_permitido '
                         +'       ,b.valor_pte_cartera '
                         +'  FROM QS_TRA_251_DET a'
                         +'      ,QS_TRA_251 b'
                         +' WHERE a.empresa       = :empresa '
                         +'   and a.proceso       = :proceso '
                         +'   AND a.fecha_proceso = :fecha '
                         +'   AND a.codigo_limite = :codigo_limite '
                         +'   AND a.codigo_rtpr   = :codigo_rtpr '
                         +'   and b.empresa       = a.empresa '
                         +'   and b.proceso       = a.proceso '
                         +'   AND b.fecha_proceso = a.fecha_proceso '
                         +'   AND b.codigo_limite = a.codigo_limite '
                         +'   AND a.cartera       = :cartera '
                         +'   AND a.transaccion   = :transaccion '
                         +'   AND a.folio_interno = :folio_interno '
                         +'   AND a.nemotecnico   = :nemotecnico '
                         +'   AND b.maximo_permitido <  b.valor_pte_cartera');

                  ParamByName('empresa').AsString       := sempresa;
                  ParamByName('proceso').AsString       := DataModule_Comun.Qry_General2.FieldByName('Proceso').AsString;
                  ParamByName('fecha').AsDate           := DataModule_Comun.Qry_General2.FieldByName('Fecha_Proceso').AsDateTime;
                  ParamByName('codigo_limite').AsString := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
                  ParamByName('codigo_rtpr').AsString   := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
                  ParamByName('cartera').AsString       := scartera;
                  ParamByName('transaccion').AsString   := stransaccion;
                  ParamByName('folio_interno').AsString := sfolio_interno;
                  ParamByName('estrategia').AsString    := sestrategia;
                  ParamByName('Nemotecnico').AsString   := sNemotecnico;

                  try
                    ExecSQL
                  except on E: EFDDBEngineException do
                    begin
                       ShowError(E);
                       Result := False;
                       exit;
                    end;
                  end;
                end;

              if (sAccion = 'V') then
                 if (DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat - fValor_Pte_Mix) < 0 then
                 begin
                    fValor_Pte_Mix := DataModule_Comun.Qry_General2.FieldByName('Valor_Pte_MC_Cpa').AsFloat;
                 end;

              Close;
              Sql.Clear;
              Sql.Add('UPDATE qs_tra_251_det ');

              if (sAccion = 'V') then
                 Sql.Add(' SET valor_nominal = valor_nominal - :nominal '
                        +'    ,valor_pte_mc_cpa = valor_pte_mc_cpa - :valor_omd ')
              else
                 Sql.Add(' SET valor_nominal = valor_nominal + :nominal '
                        +'    ,valor_pte_mc_cpa = valor_pte_mc_cpa + :valor_omd ');

              Sql.Add(' WHERE empresa       = :empresa '
                     +'   AND proceso       = :proceso'
                     +'   AND codigo_limite = :codigo_limite '
                     +'   AND codigo_rtpr   = :codigo_rtpr '
                     +'   AND fecha_proceso = :fecha_proceso ');
              Sql.Add('   AND transaccion   = :transaccion '
                     +'   AND folio_interno = :folio_interno '
                     +'   AND nemotecnico   = :nemotecnico ');

              ParamByName('empresa').AsString         := sempresa;
              ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
              ParamByName('codigo_limite').AsString   := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
              ParamByName('codigo_rtpr').AsString     := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
              ParamByName('fecha_proceso').AsDate     := dFecha_proceso;
              ParamByName('transaccion').AsString     := stransaccion;
              ParamByName('folio_interno').AsString   := sfolio_interno;
              ParamByName('nemotecnico').AsString     := snemotecnico;
              ParamByName('valor_omd').AsFloat        := fValor_Pte_Mix;
              ParamByName('nominal').AsFloat          := fValor_Nominal;


              try
                ExecSQL
              except on E: EFDDBEngineException do
                begin
                   ShowError(E);
                   Result := False;
                   exit;
                end;
              end;

              if (sAccion = 'V') then
              begin
                Close;
                Sql.Clear;
                Sql.Add(' UPDATE qs_tra_251_det '
                       +'    SET valor_pte_mc_cpa = 0 ');
                Sql.Add('  WHERE empresa       = :empresa '
                       +'    AND proceso       = :proceso'
                       +'    AND codigo_limite = :codigo_limite '
                       +'    AND codigo_rtpr   = :codigo_rtpr '
                       +'    AND fecha_proceso = :fecha_proceso ');
                Sql.Add('    AND transaccion   = :transaccion '
                       +'    AND folio_interno = :folio_interno '
                       +'    AND nemotecnico   = :nemotecnico '
                       +'    AND valor_nominal = 0 ');

                ParamByName('empresa').AsString         := sempresa;
                ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
                ParamByName('codigo_limite').AsString   := DataModule_Comun.Qry_General2.FieldByName('Codigo_Limite').AsString;
                ParamByName('codigo_rtpr').AsString     := DataModule_Comun.Qry_General2.FieldByName('codigo_rtpr').AsString;
                ParamByName('fecha_proceso').AsDate     := dFecha_proceso;
                ParamByName('transaccion').AsString     := stransaccion;
                ParamByName('folio_interno').AsString   := sfolio_interno;
                ParamByName('nemotecnico').AsString     := snemotecnico;

                try
                  ExecSQL
                except on E: EFDDBEngineException do
                  begin
                     ShowError(E);
                     Result := False;
                     exit;
                  end;
                end;
              end;
            end;
          end;
        end; ///with Qry_Aux do
        DataModule_Comun.Qry_General2.next;
      end;
      DataModule_Comun.Qry_General2.Close;

      if sAccion = 'A' then
      begin
        DataModule_Comun.Qry_General2.Close;
        DataModule_Comun.Qry_General2.Sql.Clear;
        DataModule_Comun.Qry_General2.Sql.Add('DELETE FROM qs_tra_251_det '
                                             +' WHERE empresa       = :empresa '
                                             +'   AND proceso       = :proceso'
                                             +'   AND fecha_proceso = :fecha_proceso '
                                             +'   AND transaccion   = :transaccion '
                                             +'   AND folio_interno = :folio_interno ');

        DataModule_Comun.Qry_General2.ParamByName('empresa').AsString         := sempresa;
        DataModule_Comun.Qry_General2.ParamByName('proceso').AsString         := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
        DataModule_Comun.Qry_General2.ParamByName('fecha_proceso').AsDate     := dFecha_proceso;
        DataModule_Comun.Qry_General2.ParamByName('transaccion').AsString     := stransaccion;
        DataModule_Comun.Qry_General2.ParamByName('folio_interno').AsString   := sfolio_interno;

        try
          DataModule_Comun.Qry_General2.ExecSQL
        except on E: EFDDBEngineException do
          begin
             ShowError(E);
             Result := False;
             exit;
          end;
        end;

        DataModule_Comun.Qry_General2.Close;
        DataModule_Comun.Qry_General2.Sql.Clear;
        DataModule_Comun.Qry_General2.Sql.Add(' DELETE FROM QS_TRA_251_OMD '
                                             +' WHERE empresa       = :empresa '
                                             +'   and proceso       = :proceso '
                                             +'   AND transaccion   = :transaccion '
                                             +'   AND folio_interno = :folio_interno');

        DataModule_Comun.Qry_General2.ParamByName('empresa').AsString       := sempresa;
        DataModule_Comun.Qry_General2.ParamByName('proceso').AsString       := DataModule_Comun.QryLicencia.FieldByName('Proceso').AsString;
        DataModule_Comun.Qry_General2.ParamByName('transaccion').AsString   := sTransaccion;
        DataModule_Comun.Qry_General2.ParamByName('folio_interno').AsString := sFolio_interno;

        try
          DataModule_Comun.Qry_General2.ExecSQL
        except on E: EFDDBEngineException do
          begin
             ShowError(E);
             Result := False;
             exit;
          end;
        end;
        DataModule_Comun.Qry_General2.Close;

      end;
    end;
    DataModule_Comun.QryLicencia.Next;
  end;
  DataModule_Comun.QryLicencia.Close;

end;

procedure Resta_limites(sAux_Empresa        : String;
                        dAux_Fecha          : TDateTime;
                        sAux_transaccion    : String;
                        sAux_Folio_Interno  : String;
                        bResult             : Boolean);
var
 sProceso,
 sCodigo_Limite,
 sCartera,
 snemotecnico,
 sCodigo_rtpr     : string;
begin
  bResult := TRUE;

  with DataModule_Comun.Qry_Deterioro do
  begin
    if (NOT Transaccion_implica(sAux_transaccion,'RV')) then
    begin
      Close;
      Sql.Clear;
      Sql.Add(' update qs_tra_251 '
             +'    set valor_pte_cartera = valor_pte_cartera - (select sum(valor_pte_mc_cpa) from qs_tra_251_det '
                                                             +'  where qs_tra_251.fecha_proceso     = :fecha_proceso '
                                                                +' and qs_tra_251.empresa           = :empresa '
                                                                +' and qs_tra_251_det.FECHA_PROCESO = qs_tra_251.fecha_proceso '
                                                   				      +' and qs_tra_251_det.empresa       = qs_tra_251.empresa '
                                                   				      +' and qs_tra_251_det.proceso       = qs_tra_251.proceso '
                                                   				      +' and qs_tra_251_det.codigo_limite = qs_tra_251.codigo_limite '
                                                   				      +' and qs_tra_251_det.transaccion   = :transaccion  '
                                                   				      +' and qs_tra_251_det.folio_interno = :folio_interno) '
             +' where qs_tra_251.fecha_proceso = :fecha_proceso '
             +'   and qs_tra_251.empresa       = :empresa '
             +'   and exists (select * from qs_tra_251_det '
                            +' where qs_tra_251_det.FECHA_PROCESO = qs_tra_251.fecha_proceso '
                            +'	 and qs_tra_251_det.empresa       = qs_tra_251.empresa '
                            +'	 and qs_tra_251_det.proceso       = qs_tra_251.proceso '
                            +'	 and qs_tra_251_det.codigo_limite = qs_tra_251.codigo_limite '
                            +'	 and qs_tra_251_det.transaccion   = :transaccion '
                            +'	 and qs_tra_251_det.folio_interno = :folio_interno) ');

      ParamByName('transaccion').asString     := sAux_transaccion;
      ParamByName('folio_interno').asString   := sAux_Folio_Interno;
      ParamByName('empresa').asString         := sAux_Empresa;
      ParamByName('fecha_proceso').asDate := dAux_Fecha;

      try
        DataModule_Comun.Qry_Deterioro.ExecSQL
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           bResult := False;
        end;
      end;

      Close;
      Sql.Clear;
      Sql.Add(' delete qs_tra_251_det '
             +'  where qs_tra_251_det.fecha_proceso = :fecha_proceso '
             +'    and qs_tra_251_det.empresa       = :empresa '
             +'    and qs_tra_251_det.transaccion   = :transaccion  '
             +'    and qs_tra_251_det.folio_interno = :folio_interno ');

      ParamByName('transaccion').asString     := sAux_transaccion;
      ParamByName('folio_interno').asString   := sAux_Folio_Interno;
      ParamByName('empresa').asString         := sAux_Empresa;
      ParamByName('fecha_proceso').asDate := dAux_Fecha;

      try
        DataModule_Comun.Qry_Deterioro.ExecSQL
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           bResult := False;
        end;
      end;

    end
    else
    begin
      sProceso       := '';
      sCodigo_Limite := '';
      sCodigo_rtpr   := '';
      Close;
      Sql.Clear;
      Sql.Add(' select a.proceso '
             +'       ,a.codigo_limite '
             +'       ,a.codigo_rtpr '
             +'       ,c.cartera '
             +'       ,c.nemotecnico '
             +'   from qs_tra_251_det a'
             +'       ,qs_tmp_omd_limite c '
             +' where c.PID           = :PID '
             +'   and c.transaccion   = :transaccion '
             +'   and c.empresa       = :empresa '
             +'   and a.empresa       = c.empresa '
             +'   and a.fecha_proceso = :fecha_proceso'
             +'   and a.nemotecnico   = c.nemotecnico '
             +'   and a.transaccion   = c.transaccion '
             +'   and a.cartera       = c.cartera ');


      ParamByName('PID').AsFloat              := Application.handle;
      ParamByName('transaccion').asString     := sAux_transaccion;
      ParamByName('empresa').asString         := sAux_Empresa;
      ParamByName('fecha_proceso').asDate := dAux_Fecha;

      try
        DataModule_Comun.Qry_Deterioro.Open;

      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           bResult := False;
        end;
      end;

      while not DataModule_Comun.Qry_Deterioro.eof do
      begin
        sProceso       := DataModule_Comun.Qry_Deterioro.FieldByName('proceso').AsString;
        sCodigo_Limite := DataModule_Comun.Qry_Deterioro.FieldByName('codigo_limite').AsString;
        sCodigo_rtpr   := DataModule_Comun.Qry_Deterioro.FieldByName('codigo_rtpr').AsString;
        sCartera       := DataModule_Comun.Qry_Deterioro.FieldByName('cartera').AsString;
        snemotecnico   := DataModule_Comun.Qry_Deterioro.FieldByName('nemotecnico').AsString;

        with DataModule_Comun.Qry_Unico do
        begin
          Close;
          Sql.Clear;
          Sql.Add(' update qs_tra_251 '
                 +'    set valor_pte_cartera = valor_pte_cartera - (SELECT qs_tmp_omd_limite.VALOR_PTE_MC_CPA'
                                                                  +'  FROM qs_tmp_omd_limite '
                                                                  +' WHERE qs_tmp_omd_limite.PID         = :PID '
                                                                    +' AND qs_tmp_omd_limite.TRANSACCION = :TRANSACCION'
                                                                    +' AND qs_tmp_omd_limite.EMPRESA     = :EMPRESA'
                                                                    +' AND qs_tmp_omd_limite.nemotecnico = :nemotecnico)'
                 +'  where qs_tra_251.proceso       = :proceso  '
                 +'    and qs_tra_251.fecha_proceso = :fecha_proceso '
                 +'    and qs_tra_251.codigo_limite = :codigo_limite '
                 +'    and qs_tra_251.empresa       = :empresa ');

          ParamByName('proceso').asString         := sProceso;
          ParamByName('fecha_proceso').asDate := dAux_Fecha;
          ParamByName('codigo_limite').asString   := sCodigo_Limite;
          ParamByName('empresa').asString         := sAux_Empresa;
          ParamByName('PID').AsFloat              := Application.handle;
          ParamByName('transaccion').asString     := sAux_transaccion;
          ParamByName('empresa').asString         := sAux_Empresa;
          ParamByName('nemotecnico').asString     := snemotecnico;

          try
            DataModule_Comun.Qry_Unico.ExecSQL
          except on E: EFDDBEngineException do
            begin
               ShowError(E);
               bResult := False;
            end;
          end;

          Close;
          Sql.Clear;
          Sql.Add(' UPDATE qs_tra_251_det '
                 +'    set VALOR_PTE_MC_CPA = VALOR_PTE_MC_CPA - (SELECT qs_tmp_omd_limite.VALOR_PTE_MC_CPA'
                                                                +'  FROM qs_tmp_omd_limite '
                                                                +' WHERE qs_tmp_omd_limite.PID         = :PID '
                                                                  +' AND qs_tmp_omd_limite.TRANSACCION = :TRANSACCION'
                                                                  +' AND qs_tmp_omd_limite.EMPRESA     = :EMPRESA '
                                                                  +' AND qs_tmp_omd_limite.nemotecnico = :nemotecnico)'
                 +'       ,VALOR_NOMINAL = VALOR_NOMINAL - (SELECT qs_tmp_omd_limite.VALOR_NOMINAL'
                                                          +'  FROM qs_tmp_omd_limite '
                                                          +' WHERE qs_tmp_omd_limite.PID         = :PID '
                                                            +' AND qs_tmp_omd_limite.TRANSACCION = :TRANSACCION'
                                                            +' AND qs_tmp_omd_limite.EMPRESA     = :EMPRESA '
                                                            +' AND qs_tmp_omd_limite.nemotecnico = :nemotecnico)'
                 +'  where qs_tra_251_det.proceso       = :proceso  '
                 +'    and qs_tra_251_det.fecha_proceso = :fecha_proceso '
                 +'    and qs_tra_251_det.codigo_limite = :codigo_limite '
                 +'    AND qs_tra_251_det.CODIGO_RTPR   = :CODIGO_RTPR '
                 +'    and qs_tra_251_det.empresa       = :empresa '
                 +'    and qs_tra_251_det.cartera       = :cartera '
                 +'    AND qs_tra_251_det.nemotecnico   = :nemotecnico');

          ParamByName('proceso').asString         := sProceso;
          ParamByName('fecha_proceso').asDate := dAux_Fecha;
          ParamByName('codigo_limite').asString   := sCodigo_Limite;
          ParamByName('CODIGO_RTPR').asString     := sCODIGO_RTPR;
          ParamByName('empresa').asString         := sAux_Empresa;
          ParamByName('PID').AsFloat              := Application.handle;
          ParamByName('transaccion').asString     := sAux_transaccion;
          ParamByName('empresa').asString         := sAux_Empresa;
          ParamByName('cartera').asString         := sCartera;
          ParamByName('nemotecnico').asString     := snemotecnico;

          try
            DataModule_Comun.Qry_Unico.ExecSQL
          except on E: EFDDBEngineException do
            begin
               ShowError(E);
               bResult := False;
            end;
          end;
          DataModule_Comun.Qry_Unico.Close;
        end;
        DataModule_Comun.Qry_Deterioro.Next;
      end;

    end;

    DataModule_Comun.Qry_Deterioro.Close;
  end;

end;

function agrega_omd_excedida(sAux_transaccion    : String;
                             sAux_Folio_Interno  : String;
                             sAux_Empresa        : String;
                             sAux_Cartera        : String;
                             dAux_Fecha          : TDateTime;
                             sConLimite          : Boolean):Boolean;
begin
  Result := TRUE;

  with DataModule_Comun.Qry_Deterioro do
  begin
    Close;
    Sql.Clear;
    if (NOT Transaccion_implica(sAux_transaccion,'RV')) then
    begin
      Sql.Add(' insert into qs_tra_251_omd');
      Sql.Add(' select c.empresa '
             +'       ,c.cartera ');

      if sConLimite then
         Sql.Add('    ,a.fecha_proceso '
                +'    ,a.proceso '
                +'    ,a.codigo_limite '
                +'    ,b.codigo_rtpr ')
      else
         Sql.Add('     ,:fecha_proceso '
                +'     ,'' '' as proceso '
                +'     ,'' '' as codigo_limite '
                +'     ,'' '' as codigo_rtpr ');

      Sql.Add('       ,c.transaccion '
             +'       ,c.folio_interno '
             +'       ,c.estrategia '
             +'       ,c.nemotecnico '
             +'       ,c.valor_final_svs_mc '
             +'       ,c.valor_pte_mc_mixta ');

      if sConLimite then
         Sql.Add('    ,a.maximo_permitido '
                +'    ,a.valor_pte_cartera ' )
      else
         Sql.Add('    ,0 as maximo_permitido '
                +'    ,0 as valor_pte_cartera ');

      Sql.Add('   from qs_tmp_omd_limite c '
             +'       ,qs_fin_carteras d ');
      if sConLimite then
         Sql.Add('    ,qs_tra_251_det b '
                +'    ,qs_tra_251 a ');

      Sql.Add('  where c.PID               = :PID '
             +'    and c.transaccion       = :transaccion '
             +'    and c.folio_interno     = :folio_interno '
             +'    and c.empresa           = :empresa '
             +'    and d.cod_empresa       = c.empresa '
             +'    and d.cod_cartera       = c.cartera ');
      if sConLimite then
         Sql.Add(' and a.empresa           = c.empresa '
                +' and a.cartera           = :cartera '
                +' and a.fecha_proceso     = :fecha_proceso '
                +' and b.empresa           = a.empresa '
                +' and b.fecha_proceso     = a.fecha_proceso '
                +' and b.proceso           = a.proceso '
                +' and b.codigo_limite     = a.codigo_limite '
                +' and b.transaccion       = c.transaccion '
                +' and b.folio_interno     = c.folio_interno '
                +' and b.item_omd          = c.item_omd '
                +' and b.nemotecnico       = c.nemotecnico ');

      ParamByName('transaccion').asString     := sAux_transaccion;
      ParamByName('folio_interno').asString   := sAux_Folio_Interno;
      ParamByName('empresa').asString         := sAux_Empresa;
      ParamByName('PID').AsFloat              := Application.handle;
      ParamByName('fecha_proceso').asDate := dAux_Fecha;

      if sConLimite then
        ParamByName('cartera').asString         := sAux_Cartera;

    end
    else
    begin
      Sql.Add(' insert into qs_tra_251_omd');
      Sql.Add(' select distinct  c.empresa '
             +'       ,c.cartera ' );
      if sConLimite then
         Sql.Add('    ,a.fecha_proceso '
                +'    ,a.proceso '
                +'    ,a.codigo_limite '
                +'    ,b.codigo_rtpr ')
      else
         Sql.Add('    ,:fecha_proceso '
                +'    ,'' '' as proceso '
                +'    ,'' '' as codigo_limite '
                +'    ,'' '' as codigo_rtpr ');

      Sql.Add('       ,c.transaccion '
             +'       ,:folio_interno '
             +'       ,c.estrategia '
             +'       ,c.nemotecnico '
             +'       ,c.valor_final_svs_mc '
             +'       ,c.valor_pte_mc_mixta ');
      if sConLimite then
         Sql.Add('    ,a.maximo_permitido '
                +'    ,a.valor_pte_cartera ')
      else
         Sql.Add('    ,0  as maximo_permitido '
                +'    ,0 as valor_pte_cartera ');

      Sql.Add('   from qs_tmp_omd_limite c '
             +'       ,qs_fin_carteras d ');
      if sConLimite then
         Sql.Add('    ,qs_tra_251_det b '
                +'    ,qs_tra_251 a ' );

      Sql.Add('  where c.PID               = :PID '
             +'    and c.transaccion       = :transaccion '
             +'    and c.empresa           = :empresa '
             +'    and d.cod_empresa       = c.empresa '
             +'    and d.cod_cartera       = c.cartera ');

      if sConLimite then
         Sql.Add(' and a.empresa           = c.empresa '
                +' and a.cartera           = :cartera '
                +' and a.fecha_proceso     = :fecha_proceso '
                +' and b.empresa           = a.empresa '
                +' and b.fecha_proceso     = a.fecha_proceso '
                +' and b.proceso           = a.proceso '
                +' and b.codigo_limite     = a.codigo_limite '
                +' and b.nemotecnico       = c.nemotecnico '
                +' and b.transaccion       = c.transaccion '
                +' and b.cartera           = c.cartera ');

      ParamByName('transaccion').asString     := sAux_transaccion;
      ParamByName('folio_interno').asString   := sAux_Folio_Interno;
      ParamByName('empresa').asString         := sAux_Empresa;
      ParamByName('PID').AsFloat              := Application.handle;
      ParamByName('fecha_proceso').asDate := dAux_Fecha;
      if sConLimite then
        ParamByName('cartera').asString       := sAux_Cartera;

    end;

    try
      DataModule_Comun.Qry_Deterioro.ExecSQL
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
         Result := False;
      end;
    end;
    DataModule_Comun.Qry_Deterioro.Close;
  end;

end;

function StrFormatoMin(sString : String;
                       sTipo   : String): string;
var
  indice: integer;
  Temp,Cadena: string;
begin
  if sString = '' then
     Exit;
  sString := AnsiLowerCase(sString);
  Temp := StringReplace(sString,sString[1],AnsiUpperCase(sString[1]),[]);
  Cadena := Temp;
  if sTipo = '1' then
  begin
    while (Pos(' ',Temp) > 0) do
    begin
      Indice := Pos(' ',Temp);
      Cadena := StringReplace(Cadena,' '+Cadena[indice+1],' '+AnsiUpperCase(Cadena[indice+1]),[]);
         Temp[Pos(' ',Temp)] := '_'
    end;
  end;
  while (Pos('.',Temp) > 0) do
  begin
    Indice := Pos('.',Temp);
    Cadena := StringReplace(Cadena,'.'+Cadena[indice+1],'.'+AnsiUpperCase(Cadena[indice+1]),[]);
       Temp[Pos('.',Temp)] := '_'
  end;
  Result := Cadena;
end;

function StrPrural(sString : String) :String;
const cVocales = 'AEIOU';
var String_Arr : TArr100_String;
    i :Integer;
begin
   Result := '';
   Separa_Campos_String(' ','@',sString,String_Arr);
   for i := 1 to 100 do
   begin
      if String_Arr[i] = '' then
         break;
      if Pos(AnsiUpperCase(String_Arr[i][Length(String_Arr[i])]), cVocales) > 0 then
         Result := Result+' '+String_Arr[i]+'S'
      else
         Result := Result+' '+String_Arr[i]+'ES';
   end;
   Result := TrimLeft(Result);
end;

procedure habilita_mapeo();
begin
     WITH dmBaseDatos.Conexion_BaseDatos do
     begin
        if sDriver <> 'ORACLE' then
        begin
           with FormatOptions do
           begin
                OwnMapRules := True;
                with MapRules.Add do
                begin
                    SourceDataType := dtDateTimeStamp;
                    TargetDataType := dtDateTime;
                end;
           end;
        end
        else
        begin
           with FormatOptions do
           begin
                OwnMapRules := True;
                with MapRules.Add do
                begin
                  SourceDataType := dtDateTimeStamp;
                  TargetDataType := dtDateTime;
                end;

                with MapRules.Add do
                begin
                   SourceDataType := dtBCD;
                   TargetDataType := dtDouble;
                end;

                with MapRules.Add do
                begin
                   SourceDataType := dtFmtBCD;
                   TargetDataType := dtDouble;
                end;

                with MapRules.Add do
                begin
                   SourceDataType := dtWideString;
                   TargetDataType := dtDouble;
                end;
           end;
        end;
     end;
end;

function Titulos_Vigentes(sEmpresa       : String;
                          sTransaccion   : string;
                          sFolio_interno : string;
                          fItem_omd      : Double;
                          dFecha_Cierre  : TDateTime) :Double;
var
   fTitulo_Comprados : Double;
   bExiste_reallo    : Boolean;
begin

  Titulos_Vigentes := 0;
  bExiste_reallo := True;
  fTitulo_Comprados := 0;

  DataModule_Comun.QRY_General2.Close;
  DataModule_Comun.QRY_General2.Sql.Clear;
  DataModule_Comun.QRY_General2.Sql.Add('select *'
                                       +'  from qs_tra_omd_det_pp_reallo ');
  try
    DataModule_Comun.QRY_General2.Open;
  except
    bExiste_reallo := False;
  end;

  if bExiste_reallo then
  begin
    DataModule_Comun.QRY_General2.Close;
    DataModule_Comun.QRY_General2.Sql.Clear;
    DataModule_Comun.QRY_General2.Sql.Add('select SUM(b.Numero_Titulos) as Comprados'
                                         +'  from qs_tra_omd_det_pp_reallo b'
                                         +' where b.Empresa       = :Empresa'
                                         +'   and b.Transaccion   = :Transaccion'
                                         +'   and b.Folio_interno = :Folio_interno'
                                         +'   and b.Item_OMD      = :Item_OMD'
                                         +'   and b.fecha_desde   = (SELECT MAX(a.fecha_desde) '
                                         +'                            FROM qs_tra_omd_det_pp_reallo a '
                                         +'                           where a.Empresa       = b.Empresa'
                                         +'                             and a.Transaccion   = b.Transaccion'
                                         +'                             and a.Folio_interno = b.Folio_interno'
                                         +'                             and a.Item_OMD      = b.Item_OMD  '
                                         +'                             and a.fecha_desde   <= :fecha_cierre) ');

    DataModule_Comun.QRY_General2.ParamByName('Empresa').AsString        := sEmpresa;
    DataModule_Comun.QRY_General2.ParamByName('Transaccion').AsString    := sTransaccion;
    DataModule_Comun.QRY_General2.ParamByName('Folio_interno').AsString  := sFolio_interno;
    DataModule_Comun.QRY_General2.ParamByName('Item_OMD').asFloat        := fItem_OMD;
    DataModule_Comun.QRY_General2.ParamByName('fecha_cierre').AsDate     := solo_fecha(dFecha_Cierre);

    Try
      DataModule_Comun.QRY_General2.Open;
    except on E: EFDDBEngineException do
        begin
          ShowError(E);
          DataModule_Comun.QRY_General2.Close;
          Exit;
        end;
    end;
    fTitulo_Comprados := DataModule_Comun.QRY_General2.FieldByName('Comprados').AsFloat
  end;

  if fTitulo_Comprados = 0 then
  begin
    DataModule_Comun.QRY_General2.Close;
    DataModule_Comun.QRY_General2.Sql.Clear;
    DataModule_Comun.QRY_General2.Sql.Add('select SUM(b.Numero_Titulos) as Comprados'
                                         +'  from qs_tra_omd_det_pp b'
                                         +' where b.Empresa       = :Empresa'
                                         +'   and b.Transaccion   = :Transaccion'
                                         +'   and b.Folio_interno = :Folio_interno'
                                         +'   and b.Item_OMD      = :Item_OMD');

    DataModule_Comun.QRY_General2.ParamByName('Empresa').AsString       := sEmpresa;
    DataModule_Comun.QRY_General2.ParamByName('Transaccion').AsString   := sTransaccion;
    DataModule_Comun.QRY_General2.ParamByName('Folio_interno').AsString := sFolio_interno;
    DataModule_Comun.QRY_General2.ParamByName('Item_OMD').asFloat       := fItem_OMD;
    DataModule_Comun.QRY_General2.Open;

    Try
       DataModule_Comun.QRY_General2.Open;
    except on E: EFDDBEngineException do
       begin
         ShowError(E);
         DataModule_Comun.QRY_General2.Close;
         Exit;
       end;
    end;
    fTitulo_Comprados := DataModule_Comun.QRY_General2.FieldByName('Comprados').AsFloat
  end;

  if fTitulo_Comprados > 0 then
  begin
    DataModule_Comun.QRY_General2.Close;
    DataModule_Comun.QRY_General2.Sql.Clear;
    DataModule_Comun.QRY_General2.Sql.Add('select SUM(b.Numero_Titulos) as Vendidos'
                   +'  from qs_tra_omd_det_rf a'
                   +'      ,qs_tra_omd_det_pp b'
                   +'      ,qs_tra_omd c'
                   +' where a.Empresa_rel       = :Empresa_rel'
                   +'   and a.Transaccion_rel   = :Transaccion_rel'
                   +'   and a.Folio_interno_rel = :Folio_interno_rel'
                   +'   and a.Item_OMD_rel      = :Item_OMD_rel'
                   +'   and a.transaccion in (SELECT d.Codigo_Transaccion'
                   +'                           FROM qs_sys_tran_implic d'
                   +'                          WHERE d.Codigo_transaccion = a.transaccion'
                   +'                            AND d.implicancia = ''VENTA'')'
                   +'   and a.folio_interno not in (SELECT e.folio'
                   +'                                 FROM qs_ctr_anulacion e'
                   +'                                WHERE e.folio   = a.folio_interno'
                   +'                                  AND e.transaccion = a.transaccion'
                   +'                                  AND e.empresa = a.empresa)'
                   +'   and c.folio_interno     = a.folio_interno '
                   +'   and c.transaccion       = a.transaccion '
                   +'   and c.empresa           = a.empresa '
                   +'   and c.fecha_operacion  <= :fecha_desde '
                   +'   and b.Empresa           = c.Empresa'
                   +'   and b.Transaccion       = c.Transaccion'
                   +'   and b.Folio_interno     = c.Folio_interno'
                   +'   and b.Item_OMD          = a.Item_OMD' );

    DataModule_Comun.QRY_General2.ParamByName('Empresa_rel').AsString       := sEmpresa;
    DataModule_Comun.QRY_General2.ParamByName('Transaccion_rel').AsString   := sTransaccion;
    DataModule_Comun.QRY_General2.ParamByName('Folio_interno_rel').AsString := sFolio_interno;
    DataModule_Comun.QRY_General2.ParamByName('Item_OMD_rel').asFloat       := fItem_OMD;
    DataModule_Comun.QRY_General2.ParamByName('fecha_desde').AsDate         := solo_fecha(dFecha_Cierre);

    Try
       DataModule_Comun.QRY_General2.Open;
    except on E: EFDDBEngineException do
       begin
         ShowError(E);
         DataModule_Comun.QRY_General2.Close;
         Exit;
       end;
    end;

    if fTitulo_Comprados >= DataModule_Comun.QRY_General2.FieldByName('Vendidos').AsFloat then
       Titulos_Vigentes := fTitulo_Comprados - DataModule_Comun.QRY_General2.FieldByName('Vendidos').AsFloat;
  end;
end;

procedure existe_dll_excel();
var
    sFileName   : String;
     sDirApp    : string;
     ArchivoIni : TIniFile;
     F          : TextFile;
     sTipoArcivo : string;
begin
   ArchivoIni := TIniFile.Create(sArchivo_Ini);
  sDirApp   := ArchivoIni.ReadString('General','DirApp','');
  sDirExcel  := ArchivoIni.ReadString('Excel','DirExcel','');
  sExtencion := ArchivoIni.ReadString('Excel','Extencion','');
  sTipoArcivo :=  ArchivoIni.ReadString('Excel','TipoArchivo','');
  sDesplegar    := ArchivoIni.ReadString('Excel','Desplegar','SI');

  if sDirExcel = '' then
     sDirExcel := directorio_temp //'C:\TEMP\';
  else
  begin
    sFileName :=  sDirExcel+'prueba.txt';
    AssignFile(F,sFileName);
    {$I-}
    ReWrite(F);
    {$I+}
    if NOT(IOResult = 0) then
    begin
      MensajeBox('Directorio Excel','Directorio no existe o no tiene permiso de Escritura, se asigna Directorio Temporal');
      sDirExcel := directorio_temp;
    end
    else
    begin
      CloseFile(F);
      DeleteFile(sFileName);
    end;
  end;
  if sExtencion = '' then
     sExtencion := 'XLS';
  sFileName := sDirApp+'\LIBXL.DLL';
  if FileExists(sFileName) then
     bExiste_Dll := True
  else
     bExiste_Dll := False;


  if sTipoArcivo = 'HTLM' then
    bExiste_Dll := False;
end;

function Busca_Campo_en_OMD(sEmpresa,
                            sTransaccion,
                            sFolio,
                            sCampo       : string) :string;
begin
   with DataModule_Comun.Qry_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT '+sCampo);
      SQL.Add('  FROM QS_TRA_OMD');
      SQL.Add(' WHERE Folio_Interno = :Folio_Interno');
      SQL.Add('   AND Transaccion   = :Transaccion'  );
      SQL.Add('   AND Empresa       = :Empresa'      );
      ParamByName('Empresa'      ).AsString   := sEmpresa;
      ParamByName('Transaccion'  ).AsString   := sTransaccion;
      ParamByName('Folio_Interno').AsString   := sFolio;
      Open;
      if not FieldByName(sCampo).IsNull then
         Result := FieldByName(sCampo).AsString
      else
         Result := '';
      Close;
   end;
end;

function Query_a_String(Query      :TFDQuery) :string;
var i :Integer;
begin
   Result := '';
   for i := 0 to Query.FieldCount-1 do
   begin
     if Query.Fields[i].Visible then
        Result := Result + StrTran(Query.Fields[i].DisplayLabel,'~',' ') + #9;
   end;
   Result := Result + #10;

   Query.First;
   while not Query.Eof do
   begin
      for i := 0 to Query.FieldCount-1 do
      begin
        if Query.Fields[i].Visible then
           Result := Result + Query.Fields[i].AsString + #9;
      end;
      Result := Result + #10;
      Query.Next;
   end;
end;

function Leer_Unidad_Medida(sCod_Unidad  : String;
                            sDet_Unidad : String) :Boolean;
begin
  Result :=  False;
  With DataModule_Comun.Qry_General do
  begin
      Sql.Clear;
      SQL.Add('select * '
             +'  from QS_SYS_DET_MEDIDAS '
             +' where COD_UNIDAD    = :cod_unidad '
             +'   and D_TIPO_UNIDAD = :det_unidad '
            );
      ParamByName('cod_unidad').AsString := sCod_Unidad;
      ParamByName('det_unidad').AsString := sDet_Unidad;
      Open;
      if Not eof then
         Result := True;
      Close;
   end;
end;

procedure Genera_Ventas(sString_Empresas    :String;
                        sImplicancia_Venta  :String;
                        sImplicancia_Pacto  :String;
                        sImplicancia_Margen :String;
                        sImplicancia_RV     :String;
                        dFecha_Inicial      :TDAteTime
                       );
var dFecha_Aux        :TDAteTime;
    fItem_recursivo   :Double;
begin

  DataModule_Comun.Qry_General2.SQL.Clear;
  DataModule_Comun.Qry_General2.SQL.Add('select min(fecha_movimiento) as Fecha ');
  DataModule_Comun.Qry_General2.SQL.Add(' from QS_TRA_OMD_TRAZA ');
  DataModule_Comun.Qry_General2.SQL.Add('where folio_interno_omd = :folio_interno ');
  DataModule_Comun.Qry_General2.SQL.Add('  and item_omd          = :item_omd ');
  DataModule_Comun.Qry_General2.SQL.Add('  and transaccion_omd   = :transaccion ');
  DataModule_Comun.Qry_General2.SQL.Add('  and empresa_omd       = :empresa ');
  DataModule_Comun.Qry_General2.SQL.Add('  and fecha_movimiento  > :fecha ');

  DataModule_Comun.QRY_General4.SQL.Clear;
  DataModule_Comun.QRY_General4.SQL.Add('INSERT INTO QS_TRA_OMD_VENTAS '
                                       +' VALUES (:EMPRESA,:TRANSACCION,:FOLIO_INTERNO,:ITEM_OMD,:FECHA_OPERACION,:fecha_de_pago,:VALOR_NOMINAL,:Pid,:Fecha_Creacion ) ');

  With DataModule_Comun.Qry_General do
  begin
       // va a buscar ventas de omd's sin reallocation
      SQL.Clear;
      SQL.Add(' INSERT INTO QS_TRA_OMD_VENTAS '  );
      SQL.Add(' SELECT b.EMPRESA_rel          '  );
      SQL.Add('       ,b.transaccion_rel      '  );
      SQL.Add('       ,b.folio_interno_rel    '  );
      SQL.Add('       ,b.item_omd_rel         '  );
      SQL.Add('       ,c.FECHA_OPERACION      '  );
      SQL.Add('       ,c.fecha_de_pago        '  );
      SQL.Add('       ,SUM(b.VALOR_NOMINAL) as VALOR_NOMINAL     '  );
      SQL.Add('      ,:Pid '   );
      SQL.Add('      ,:Fecha_Creacion '   );
      SQL.Add('   FROM QS_TRA_OMD_DET_RF  b                     '  );
      SQL.Add('       ,qs_tra_omd         c                     '  );
      SQL.Add('  WHERE b.Empresa          IN '+sString_Empresas);
      SQL.Add('    AND c.FOLIO_INTERNO     = b.folio_interno     '  );
      SQL.Add('    AND c.Transaccion       = b.transaccion       '  );
      SQL.Add('    AND c.EMPRESA           = b.EMPRESA           '  );
      SQL.Add('    AND b.Transaccion      IN '+sImplicancia_Venta );
      SQL.Add('    AND b.Transaccion   NOT IN '+sImplicancia_Pacto );
      SQL.Add('    AND b.Transaccion   NOT IN '+sImplicancia_Margen );
      SQL.Add('    AND b.TRANSACCION   NOT IN '+sImplicancia_RV );
      SQL.Add('    AND b.folio_interno NOT IN (SELECT e.folio');
      SQL.Add('                                  FROM qs_ctr_anulacion e');
      SQL.Add('                                 WHERE e.folio       = b.folio_interno');
      SQL.Add('                                   AND e.transaccion = b.transaccion  ');
      SQL.Add('                                   AND e.empresa     = b.empresa)     ');
      SQL.Add('    AND NOT EXISTS (SELECT e.* ');
      SQL.Add('                      FROM QS_TRA_OMD_TRAZA e');
      SQL.Add('                     where e.folio_interno_omd = b.folio_interno_rel ');
      SQL.Add('                       and e.item_movimiento   = b.item_omd_rel ');
      SQL.Add('                       and e.transaccion_omd   = b.transaccion_rel ');
      SQL.Add('                       and e.empresa_omd       = b.empresa_rel) ');
      SQL.Add('  GROUP BY b.EMPRESA_rel          '  );
      SQL.Add('          ,b.transaccion_rel      '  );
      SQL.Add('          ,b.folio_interno_rel    '  );
      SQL.Add('          ,b.item_omd_rel         '  );
      SQL.Add('          ,c.FECHA_OPERACION      '  );
      SQL.Add('          ,c.fecha_de_pago        '  );
      ParamByName('Pid').AsString              := IntToStr(Application.Handle);
      ParamByName('Fecha_Creacion').asDateTime := dFecha_Hora;
      ExecSql;

      // va a buscar ventas de omd's con reallocation
      SQL.Clear;
      SQL.Add(' SELECT b.EMPRESA_rel          '  );
      SQL.Add('       ,b.transaccion_rel      '  );
      SQL.Add('       ,b.folio_interno_rel    '  );
      SQL.Add('       ,b.item_omd_rel         '  );
      SQL.Add('       ,c.FECHA_OPERACION      '  );
      SQL.Add('       ,c.fecha_de_pago        '  );
      SQL.Add('       ,SUM(b.VALOR_NOMINAL) as VALOR_NOMINAL     '  );
      SQL.Add('      ,:Pid as Pid'   );
      SQL.Add('      ,:Fecha_Creacion as Fecha_Creacion'   );
      SQL.Add('   FROM QS_TRA_OMD_DET_RF  b                     '  );
      SQL.Add('       ,qs_tra_omd          c                     '  );
      SQL.Add('  WHERE b.Empresa IN '+sString_Empresas);
      SQL.Add('    AND c.FOLIO_INTERNO     = b.folio_interno     '  );
      SQL.Add('    AND c.Transaccion       = b.transaccion       '  );
      SQL.Add('    AND c.EMPRESA           = b.EMPRESA           '  );
      SQL.Add('    AND b.Transaccion      IN '+sImplicancia_Venta );
      SQL.Add('    AND b.Transaccion   NOT IN '+sImplicancia_Pacto );
      SQL.Add('    AND b.Transaccion   NOT IN '+sImplicancia_Margen );
      SQL.Add('    AND b.TRANSACCION   NOT IN '+sImplicancia_RV );
      SQL.Add('    AND b.folio_interno NOT IN (SELECT e.folio');
      SQL.Add('                                  FROM qs_ctr_anulacion e');
      SQL.Add('                                 WHERE e.folio       = b.folio_interno');
      SQL.Add('                                   AND e.transaccion = b.transaccion  ');
      SQL.Add('                                   AND e.empresa     = b.empresa)     ');
      SQL.Add('    AND EXISTS (SELECT e.* ');
      SQL.Add('                  FROM QS_TRA_OMD_TRAZA e');
      SQL.Add('                 where e.folio_interno_omd = b.folio_interno_rel ');
      SQL.Add('                   and e.item_movimiento   = b.item_omd_rel ');
      SQL.Add('                   and e.transaccion_omd   = b.transaccion_rel ');
      SQL.Add('                   and e.empresa_omd       = b.empresa_rel) ');
      SQL.Add('    AND c.fecha_operacion > :fecha ');
      SQL.Add('  GROUP BY b.EMPRESA_rel          '  );
      SQL.Add('          ,b.transaccion_rel      '  );
      SQL.Add('          ,b.folio_interno_rel    '  );
      SQL.Add('          ,b.item_omd_rel         '  );
      SQL.Add('          ,c.FECHA_OPERACION      '  );
      SQL.Add('          ,c.fecha_de_pago        '  );
      ParamByName('Pid').AsString              := IntToStr(Application.Handle);
      ParamByName('Fecha_Creacion').AsDateTime := dFecha_Hora;
      ParamByName('Fecha'  ).asDate            := dFecha_Inicial;
      Open;

      while not eof do
      begin
         // va a buscar el item que tenia a la fecha de proceso ya que en las ventas aparece ese item y en la de operaciones el original
         fItem_recursivo := 0;
         DataModule_Comun.Qry_General2.ParamByName('folio_interno').AsString := FieldByName('Folio_interno_rel').AsString;
         DataModule_Comun.Qry_General2.ParamByName('item_omd').AsString      := FieldByName('item_omd_rel').AsString;
         DataModule_Comun.Qry_General2.ParamByName('transaccion').AsString   := FieldByName('transaccion_rel').AsString;
         DataModule_Comun.Qry_General2.ParamByName('empresa').AsString       := FieldByName('empresa_rel').AsString;
         DataModule_Comun.Qry_General2.ParamByName('Fecha').asDate           := dFecha_Inicial;
         DataModule_Comun.Qry_General2.Open;
         if (not DataModule_Comun.Qry_General2.Eof) and (not DataModule_Comun.Qry_General2.FieldByName('Fecha').IsNull) then
            dFecha_Aux := DataModule_Comun.Qry_General2.FieldByName('Fecha').AsDateTime
         else
            dFecha_Aux := dFecha_Inicial;

         recursivo_ventas(FieldByName('folio_interno_rel').AsString
                         ,FieldByName('item_omd_rel').Asfloat
                         ,FieldByName('transaccion_rel').AsString
                         ,FieldByName('EMPRESA_rel').AsString
                         ,dFecha_Aux //dFecha_Inicial
                         ,fItem_recursivo);

         DataModule_Comun.QRY_General4.ParamByName('empresa').AsString           := FieldByName('EMPRESA_rel').AsString ;
         DataModule_Comun.QRY_General4.ParamByName('TRANSACCION').AsString       := FieldByName('transaccion_rel').AsString;
         DataModule_Comun.QRY_General4.ParamByName('Folio_interno').AsString     := FieldByName('folio_interno_rel').AsString;
         DataModule_Comun.QRY_General4.ParamByName('ITEM_OMD').AsFloat           := fItem_recursivo;
         DataModule_Comun.QRY_General4.ParamByName('FECHA_OPERACION').AsDateTime := FieldByName('FECHA_OPERACION').AsDateTime;
         DataModule_Comun.QRY_General4.ParamByName('fecha_de_pago').AsDateTime   := FieldByName('fecha_de_pago').AsDateTime;
         DataModule_Comun.QRY_General4.ParamByName('VALOR_NOMINAL').AsFloat      := FieldByName('VALOR_NOMINAL').AsFloat;
         DataModule_Comun.QRY_General4.ParamByName('Pid').AsString               := FieldByName('Pid').AsString;
         DataModule_Comun.QRY_General4.ParamByName('Fecha_Creacion').AsDateTime  := FieldByName('Fecha_Creacion').AsDateTime;
         DataModule_Comun.QRY_General4.ExecSQL;
         Next;
      end;
  end;

end;

procedure recursivo_ventas(sFolio_interno  :string;
                           fitem_omd       :Double;
                           stransaccion    :string;
                           sempresa        :string;
                           dFecha          :TDateTime;
                       var fItem_recursivo :Double);
begin
   fItem_recursivo := fitem_omd;
   with DataModule_Comun.Qry_General3 do
   begin
      SQL.Clear;
      SQL.Add('select A.EMPRESA '
             +'      ,A.TRANSACCION_OMD '
             +'      ,A.FOLIO_INTERNO_OMD '
	 		       +'	     ,max(a.item_omd) as Item_recursivo'
             +'	from qs_tra_omd_traza a  '
             +' where a.Folio_interno_omd = :Folio_interno '
             +'   and a.item_movimiento   = :item_omd '
             +'   and a.transaccion_omd   = :transaccion '
             +'   and a.empresa           = :empresa '
             +'	  and a.item_omd         <> a.item_movimiento '
             +'	  and a.FECHA_MOVIMIENTO  > :Fecha '
             +' group by A.EMPRESA  '
             +'	        ,A.TRANSACCION_OMD '
             +'	        ,A.FOLIO_INTERNO_OMD '
	 			     +'	  	    ,a.item_movimiento ');
      ParamByName('empresa').AsString       := sempresa;
      ParamByName('TRANSACCION').AsString   := stransaccion;
      ParamByName('Folio_interno').AsString := sFolio_interno;
      ParamByName('ITEM_OMD').AsFloat       := fitem_omd;
      ParamByName('Fecha').AsDateTime       := dFecha;
      Open;
      if not eof then
      begin
         fItem_recursivo := FieldByName('Item_recursivo').Asfloat;
         recursivo_ventas(FieldByName('Folio_interno_omd').AsString
                         ,FieldByName('Item_recursivo').Asfloat
                         ,FieldByName('transaccion_omd').AsString
                         ,FieldByName('empresa').AsString
                         ,dFecha
                         ,fItem_recursivo);
      end;
   end;
end;

function Nominales_Vendidos(sEmpresa          :String;
                            sTransaccion      :String;
                            sFolio_interno    :String;
                            fItem_Omd         :Double;
                            dFecha_Vcto_Cupon :TDateTime) :Double;
begin
   Result := 0;
   with DataModule_Comun.Qry_Nominales_Venta do
   begin
      Close;
      {
      Sql.Clear;
      SQL.Add('SELECT SUM(VALOR_NOMINAL) as Valor_Nominal ');
      SQL.Add('  FROM QS_TRA_OMD_VENTAS                   ');
      SQL.Add(' WHERE Pid                = :Pid           ');
      SQL.Add('   AND Folio_interno_Rel  = :Folio_interno ');
      SQL.Add('   AND Item_OMD_Rel       = :Item_OMD      ');
      SQL.Add('   AND Transaccion_Rel    = :Transaccion   ');
      SQL.Add('   AND Empresa_Rel        = :Empresa       ');
      SQL.Add('   AND Fecha_Operacion    < :Fecha_Cupon   ');
      SQL.Add('   AND Fecha_de_Pago     <= :Fecha_Cupon   ');
      }
      ParamByName('Pid').asstring           := IntToStr(Application.Handle);
      ParamByName('Folio_interno').AsString := sFolio_interno;
      ParamByName('Item_OMD').AsFloat       := fItem_OMD;
      ParamByName('Transaccion').AsString   := sTransaccion;
      ParamByName('Empresa').AsString       := sEmpresa;
      ParamByName('Fecha_Cupon').AsDate     := dFecha_Vcto_Cupon;
      Open;
      if FieldByName('Valor_nominal').IsNull then
         Result := 0
      else
         Result := FieldByName('Valor_nominal').AsFloat;
      Close;
   end;
end;

function DatosUniversal(sEmpresa           : String;
                        sTransaccion_OMD   : String;
                        sFolio_Interno_OMD : String;
                        fItem_OMD          : Double;
                        fItem_Movimiento   : Double;
                        dFecha_Movimiento  : TDateTime):Boolean;
begin
   Result := True;
   With DataModule_Comun.Qry_General3 do
   begin
      Close;
      Sql.Clear;
      Sql.Add('DELETE FROM QS_TRA_OMD_DATADI_UNI '
             +' WHERE EMPRESA       = :EMPRESA '
             +'   AND FOLIO_INTERNO = :FOLIO_INTERNO '
             +'   AND ITEM_OMD      = :ITEM_MOV'
             +'   AND TRANSACCION   = :TRANSACCION '
             +'   AND TIPO_DATO     = ''ANNO'' '
             +'   AND FECHA_DESDE   = :FECHA_DESDE' );

      ParamByName('EMPRESA').asString        := sEmpresa;
      ParamByName('FOLIO_INTERNO').asString  := sFolio_Interno_OMD;
      ParamByName('TRANSACCION').asString    := sTransaccion_OMD;
      ParamByName('FECHA_DESDE').AsdateTime  := dFecha_Movimiento;
      ParamByName('ITEM_MOV').AsFloat        := fItem_Movimiento;

      Try
        ExecSQL;
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           Result := False;
        end;
      end;

      Close;
      Sql.Clear;
      Sql.Add('INSERT INTO QS_TRA_OMD_DATADI_UNI '
             +' (EMPRESA,FOLIO_INTERNO,ITEM_OMD,TIPO_DATO,FECHA_DESDE,VALOR,TRANSACCION) ');
      Sql.Add('(SELECT x.EMPRESA'
             +'      ,x.FOLIO_INTERNO '
             +'      ,:ITEM_MOV '
             +'      ,x.TIPO_DATO '
             +'      ,:FECHA_DESDE '
             +'      ,x.VALOR '
             +'      ,x.TRANSACCION '
             +'  FROM QS_TRA_OMD_DATADI_UNI x '
             +' WHERE x.EMPRESA       = :EMPRESA '
             +'   AND x.FOLIO_INTERNO = :FOLIO_INTERNO '
             +'   AND x.ITEM_OMD      = :ITEM_OMD '
             +'   AND x.TRANSACCION   = :TRANSACCION '
             +'   AND x.TIPO_DATO     = ''ANNO'' '
             +'   AND x.FECHA_DESDE   = (SELECT MAX(a.fecha_desde)'
             +'                            FROM QS_TRA_OMD_DATADI_UNI a'
             +'                           WHERE a.EMPRESA       = x.EMPRESA '
             +'                             AND a.FOLIO_INTERNO = x.FOLIO_INTERNO '
             +'                             AND a.ITEM_OMD      = x.ITEM_OMD '
             +'                             AND a.TRANSACCION   = x.TRANSACCION '
             +'                             AND a.TIPO_DATO     = x.TIPO_DATO '
             +'                             AND a.FECHA_DESDE  <= :FECHA_DESDE))');

      ParamByName('EMPRESA').asString        := sEmpresa;
      ParamByName('FOLIO_INTERNO').asString  := sFolio_Interno_OMD;
      ParamByName('TRANSACCION').asString    := sTransaccion_OMD;
      ParamByName('ITEM_OMD').AsFloat        := fItem_OMD;
      ParamByName('FECHA_DESDE').AsdateTime  := dFecha_Movimiento;
      ParamByName('ITEM_MOV').AsFloat        := fItem_Movimiento;

      Try
        ExecSQL;
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           Result := False;
        end;
      end;
      Close;
   end;
end;

function Leer_fecha_Reallocation(sempresa         : String;
                                 stransaccion     : String;
                                 sFolio_interno   : String;
                                 fItem_omd        : Double;
                                 dfecha           : TDateTime;
                             var sCartera_realloc : String): TDateTime;
var dFecha_Mov :TDateTime;
begin
  Result := 0;
  if Transaccion_Implica_Mem(sEmpresa_Usuario,'REALLOCAT') then
  begin
    with DataModule_Comun.Qry_General3 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT max(a.fecha_movimiento) as fecha_movimiento ');
      SQL.Add('   FROM QS_TRA_OMD_TRAZA a');
      SQL.Add('  WHERE a.Folio_Interno_omd = :Folio_interno '
             +'    AND a.transaccion_omd   = :Transaccion '
             +'    AND a.item_MOVIMIENTO   = :item_omd '         //
             +'    AND a.Empresa_omd       = :Empresa '
             +'    AND a.CARTERA_ORIGEN_MOV <> a.CARTERA_MOVIMIENTO '
             +'    AND a.fecha_movimiento <= :fecha_proceso '
             +'    AND a.Folio_Interno NOT IN (SELECT x.FOLIO_INTERNO '
                                        +'       FROM QS_TRA_OMD_TRAZA x '
                                        +'	     ,QS_TRA_OMD_TRAZA y '
                                        +'	where x.empresa            = y.empresa '
                                        +'	  and x.EMPRESA_OMD        = y.empresa_omd '
                                        +'	  and x.folio_interno      <> y.folio_interno '
                                        +'	  and x.TRANSACCION_OMD    = y.TRANSACCION_omd '
                                        +'	  and x.folio_interno_omd  = y.folio_interno_omd '
                                        +'	  and x.item_MOVIMIENTO    = Y.ITEM_MOVIMIENTO  '
                                        +'	  and x.fecha_movimiento   = y.fecha_movimiento   '
                                        +'	  and x.cartera_origen_mov = y.cartera_movimiento  '
                                        +'	  and x.cartera_movimiento = y.cartera_origen_mov '
                                        +'	  and x.valor_nominal      = y.valor_nominal '
                                        +'	  and x.fecha_movimiento   = y.fecha_movimiento) ');
      ParamByName('Empresa'      ).AsString   := sEmpresa_Usuario;
      ParamByName('Transaccion'  ).AsString   := sTransaccion;
      ParamByName('Folio_interno').AsString   := sFolio_Interno;
      ParamByName('item_omd'     ).AsFloat    := fItem_omd;
      ParamByName('fecha_proceso').AsDateTime := dfecha;

      Try
        Open;
        dFecha_Mov := FieldByName('fecha_movimiento').AsDateTime;
        Result := FieldByName('fecha_movimiento').AsDateTime;
      except on E: EFDDBEngineException do
       begin
         ShowError(E);
         Result := 0;
       end;
      end;

      Close;
      SQL.Clear;
      SQL.Add('SELECT CARTERA_MOVIMIENTO '
             +'  FROM QS_TRA_OMD_TRAZA '
             +' WHERE FOLIO_INTERNO_OMD = :Folio_interno '
             +'   AND TRANSACCION_OMD   = :Transaccion '
             +'   AND ITEM_OMD          = :item_omd '
             +'   AND EMPRESA           = :Empresa '
             +'   AND FECHA_MOVIMIENTO = :fecha_proceso ');
      ParamByName('Empresa'      ).AsString   := sEmpresa_Usuario;
      ParamByName('Transaccion'  ).AsString   := sTransaccion;
      ParamByName('Folio_interno').AsString   := sFolio_Interno;
      ParamByName('item_omd'     ).AsFloat    := fItem_omd;
      ParamByName('fecha_proceso').AsDateTime := dFecha_Mov;

      Try
        Open;
        if not eof then
           sCartera_realloc := FieldByName('Cartera_Movimiento').AsString;
      except on E: EFDDBEngineException do
       begin
         ShowError(E);
         Result := 0;
       end;
      end;

    end;
  end;
end;

Procedure Nemotecnico_Pasivo_Swap(sFolio_interno   : String;
                                  var sNemotecnico : String;
                                  var sSerie       : String;
                                  var sEmisor      : String;
                                  var sInstrumento : String);
begin

   with DataModule_Comun.Qry_Nem_Pas_Swap do
   begin
      Close;
      {
      SELECT NEMOTECNICO, SERIE, EMISOR, INSTRUMENTO FROM QS_TRA_OMD_DET_RF
      WHERE FOLIO_INTERNO = :Folio
      AND TRANSACCION = 'S'
      AND ITEM_OMD = 1
      }
      ParamByName('Folio').AsString  := sFolio_interno;
      Open;
      sNemotecnico := Trim(FieldByName('NEMOTECNICO').AsString);
      sSerie       := Trim(FieldByName('SERIE').AsString);
      sEmisor      := Trim(FieldByName('EMISOR').AsString);
      sInstrumento := Trim(FieldByName('INSTRUMENTO').AsString);
      Close;
   end;
end;

function EsValido(sContenido, sPatron: string): Boolean;
begin
  // Usamos TRegEx para validar si el contenido cumple con la expresión regular (patrón)
  Result := TRegEx.IsMatch(scontenido, spatron);
end;

Function Existe_Rol_Cartera(sEmpresa     : String;
                            sCartera     : String;
                            sRol         : String;
                            dFecha_Vig   : TDatetime;
                            var dFecha_Desde : TDatetime): Boolean;
begin
  Existe_Rol_Cartera := False;
  WITH DataModule_Comun.QRY_General do
   begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT a.Empresa, a.Fecha_Desde '
             +'  FROM QS_SUP_BRAIZ a'
             +' WHERE a.Empresa      = :Empresa'
//             +'   AND a.Cartera      = :Cartera'
             +'   AND a.Rol          = :Rol'
             +'   AND a.Fecha_Desde = (SELECT MAX(b.Fecha_Desde) '    // E.S. 14-11-2016
             +'                          FROM QS_SUP_BRAIZ b'
             +'                         WHERE b.Empresa = a.Empresa'
//             +'                           AND b.Cartera = a.Cartera'
             +'                           AND b.Rol     = a.Rol'
             +'                           AND b.Fecha_Desde <= :Fecha'
             +'                           AND (b.Fecha_Hasta >= :Fecha OR b.Fecha_Hasta Is Null))'
             );
      Parambyname('Empresa').asString   := sEmpresa;
//      Parambyname('Cartera').asString   := sCartera;
      Parambyname('Rol').asString       := sRol;
      Parambyname('Fecha').asDatetime   := dfecha_hora; //Fecha_hora_Servidor;  // E.S. 14-11-2016  dFecha_Vig;
      Open;

      if NOT Fieldbyname('Empresa').IsNull then
      begin
         Existe_Rol_Cartera := True;
         dFecha_Desde := Fieldbyname('Fecha_Desde').AsDateTime;
      end;

      Close;
   end;
end;

function CarpetaExisteYEsAccesible(const ruta: string): Boolean;
var attr: Integer;
begin
  Result := False;

  if Trim(ruta) = '' then
    Exit;

  try
    if DirectoryExists(ruta) then
    begin
      attr := GetFileAttributes(PChar(ruta));
      Result := (attr <> INVALID_FILE_ATTRIBUTES) and
                (attr and FILE_ATTRIBUTE_DIRECTORY <> 0);
    end;
  except
    Result := False;
  end;
end;

function Cierre_Contable_Oper(sProceso     : String;
                              sEmpresa     : String;
                              sCartera     : String;
                              sTipo_Contab : String;
                              dFecha       : TDateTime): Boolean;
var string_Proc : String;
begin
// Nueva funcion 05-2025  FI & ES

  Result := False;

  With DataModule_Comun.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(Fecha_Cierre) as Fecha_cierre'
           +'  FROM QS_CON_CIERRE'
           +' WHERE PROCESO IN (''OPERAC'',''CIERVAL'',''TESORE'',''CONTAB'') '
           +'   AND (CARTERA = :Cartera OR CARTERA = '''') '
           +'   AND ESTADO   = :Estado'
           +'   AND Fecha_Cierre >= :Fecha '
           );

    ParamByName('Cartera').AsString := trim(sCartera);
    ParamByName('Fecha').AsDate     := dFecha;
    ParamByName('Estado').AsString  := 'VIGENTE';
    Open;

    if eof then
    begin
       Close;
       exit;
    end;
    Close;

	  if sProceso = 'PARAME' then
	     string_Proc := '(''PARAME'', ''OPERAC'',''CIERVAL'',''TESORE'',''CONTAB'')'
	  else
	     if sProceso = 'OPERAC' then
	        string_Proc := '(''OPERAC'',''CIERVAL'',''TESORE'',''CONTAB'')'
	     else
	        if sProceso = 'CIERVAL' then
	           string_Proc := '(''CIERVAL'',''TESORE'',''CONTAB'')'
          else
	           if sProceso = 'TESORE' then
	              string_Proc := '(''TESORE'',''CONTAB'')'
             else
	              if sProceso = 'CONTAB' then
	                 string_Proc := '(''CONTAB'')'
                else
	                 string_Proc := '('''')';


    Close;
    SQL.Clear;
    SQL.Add('SELECT *'
           +'  FROM QS_CON_CIERRE'
           +' WHERE Empresa       = :Empresa');

    if trim(sCartera) <> '' then
       SQL.Add('AND Cartera  = :Cartera');

    SQL.Add('   AND Proceso       IN '+ string_Proc
           +'   AND Estado        = :Estado'
           +'   AND Fecha_cierre >= :Fecha_cierre' );

    if trim(sTipo_Contab) <> '' then
       SQL.Add('AND Tipo_Contabilidad  = :Tipo_Contab');

    ParamByName('Empresa').AsString        := sEmpresa;

    if trim(sCartera) <> '' then
       ParamByName('Cartera').AsString     := sCartera;

    if trim(sTipo_Contab) <> '' then
       ParamByName('Tipo_Contab').AsString     := sTipo_Contab;

//    ParamByName('Proceso').AsString        := sProceso;
    ParamByName('Estado').AsString         := 'VIGENTE';
    ParamByName('Fecha_cierre').AsDate := dFecha;

    try
      Open;
      if not eof then
         Result := True;
    except on E: EFDDBEngineException do
      begin
         ShowError(E);
         Close;
         Exit;
      end;
    end;

  end;

end;
//------------------------------------------------------------------------------
end.
