unit DM_Variables_Menu;

interface
const
// Ahora es dinamico
//  Max_Nro_Cupones = 601;           // Maximo de registros posibles
//  Max_Nro_Cupones = 360;
  iMax_Tramos     = 1500;
var
  Max_Nro_Cupones : Integer;
  sLogin_Servidor,
  sPasswd_servidor,
  sBasedatos,
  sServidor,
  sTipo_Conexion_Oracle,
  sInstancia_Oracle,
  sAutentificacion,
  sAliasBase,
  sPrivilegio_Usuario,
  sEmpresa_Usuario,
  sidentidad_usuario,
  sEmpresa,
  sCodigo,
  snombre_usuario,
  sperfil_usuario : string;
  sEmpresa_Cartera: string;
  xMon_ind_Tas : Char;
  sDriver,
  sVendorId,
  sOdbcDriver,
  sPuertoId,
  sLogin_sistema,
  sMoneda_Destino,
  sPath_Login,
  sNodo_Funcional,
  sEntidad_Fisica : String;
  fItem_Dir_Usuario : Double;
  sCodigo_Div_Geo_Usuario,
  sPais_Usuario,
  sIdentifica_Instancia,

  Syspmsini_Login,
  sArchivo_Ini    : String;
  sRutaArchivoPago : String; 
  sDebug_Txt            : String;
  bpaso                 : Boolean;
  bDebugger             : Boolean;
  sNemotecnico_Debug    : String;
  sNemotecnico_Debug_RV : String;
  bDesarrollo     : Boolean;
  Abortar         : Boolean;
  bEncriptado     : Boolean;
  bEncriptado2    : Boolean;
  sCrypt        : Boolean;
  sCrypt2       : Boolean;
  sCrypKey        : Boolean;

  sImplica_NOMEM  : String;
  bTEST           : Boolean;
  bTEST2           : Boolean;
  sGrupo_Cartera  : String;
  Inactivo        : Boolean;
  fReserva_publico   : Double;
  Procesado       : Boolean;
  Incluye_Pactos  : Boolean;
  fileName_Log    : string;
  fileDate_Log    : Integer;
  IIndice         : Integer;
  sLlamado_Desde  : String;  // Cada menu debería llenar esto Ej: MESA DE DINERO
  sLlamado_Super  : String;

  bFuturas_implicitas : Boolean;

  bExiste_Error       : Boolean;

  sString_Nombre_Err  : String;

  sNombre_de_Menu     : String;
  bInserta_Opc       : Boolean;
  bElimina_Opc       : Boolean;
  bModifica_Opc       : Boolean;

  sDirExcel      : String;
  sExtencion     : String;
  sDesplegar     : String;
  bUnsoloLibro   : Boolean;
  bParametros    : Boolean;

  bopcion_swap   : Boolean;
  smoneda_nacional_gen   : String;
  sSeparadorField : string;

implementation
end.
