unit MetodosServidor;

interface

uses System.SysUtils, System.Classes, System.Json, System.DateUtils,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, System.IOUtils,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, vcl.Forms, system.IniFiles, System.Variants,
  System.Threading, Nb, DM_Variables_Valorizacion;

type
   TCarteras = Record
                  Empresa :Variant;
                  Cartera :Variant;
               end;
   TEmisores = Record
                  Emisor :Variant;
               end;
   TInstrumentos = Record
                      Instrumento :Variant;
                   end;
   TDetalle = Record
                 fItem_OMD           :Variant;
                 sNemotecnico        :Variant;
                 sTipo_Instrum       :Variant;
                 sEmisor             :Variant;
                 sInstrumento        :Variant;
                 sSerie              :Variant;
                 sMoneda_Instrum     :Variant;
                 fTasa_Emision       :Variant;
                 dFecha_Emision      :Variant;
                 dFecha_Vencimiento  :Variant;
                 sTipo_Nominales     :Variant;
                 fValor_Nominal      :Variant;
                 sTasa_Base_Par      :Variant;
                 fTasa_mercado       :Variant;
                 sTransaccion_rel    :Variant;
                 sFolio_Interno_Rel  :Variant;
                 fItem_Omd_rel       :Variant;
                 fValor_Invertido_MC :Variant;
                 fValor_Pte_Cpa_MC   :Variant;
              end;
{$METHODINFO ON}
  //[TRoleAuth('Administrador,Invitado')] //Se define el acceso a todos los metodos de la clase

  TServerMethods1 = class(TDataModule)
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    Qry_General: TFDQuery;
    Qry_General2: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }
    procedure Logs_Valorizacion_RF(dFecha_Desde   :TDateTime;
                                   dFecha_Hasta   :TDateTime;
                                   Reg_Parametros :TParametros);
    function String_a_Date(sFecha :string) :TDateTime;
    function Llena_Tabla_Limites(sEmpresa         : String;
                                 sCartera         : String;
                                 sTransaccion     : String;
                                 sFolio_Interno   : String;
                                 dFecha_Operacion : TDateTime;
                                 dFecha_de_Pago   : TDateTime;
                                 sMoneda_Operacion: String;
                                 sEstrategia      : String;
                                 bSBS             : Boolean;
                                 ArrayDetalle     : TDetalle) :Boolean;
  public
    { Public declarations }
    //[TRoleAuth('Administrador,Invitado')]  //Se pude dar acceso a cada metodo
    function Conexion_Basedatos :Boolean;

    //Metodos Valorizacion Renta Fija
    //[TRoleAuth('Administrador,Invitado')]  //Se pude dar acceso a cada metodo
    function ObtenerCarteras(sEmpresa: string): TJSONObject;                  //GET
    function ObtenerEmisores: TJSONObject;                                    //GET
    function ObtenerInstrumentos: TJSONObject;                                //GET
    function updateValoriza_RF(Parametros: TJSONObject): TJSONObject;         //POST
    function updateValoriza_OMD(Parametros: TJSONObject): TJSONObject;        //POST
    //[TRoleAuth('Administrador')]
    function updateTratamiento_Fechas(Parametros: TJSONObject): TJSONObject;  //POST
    function updateLimites_OMD(Parametros: TJSONObject): TJSONObject;         //POST

  end;

  {$METHODINFO OFF}

var
  ServerMethods1: TServerMethods1;
  Inactividad       :Integer;
  ytiempo           :Double;
  Inactividad_fecha :Integer;
  tiempo_fecha      :Integer;

implementation


{$R *.dfm}


uses System.StrUtils,
     Data.FireDACJSONReflect,
     DM_Base_Datos,
     DM_Threadvar,
     DM_Variables_Menu,
     DM_Valorizacion,
     DM_Global_Var,
     DM_Comun,
     DM_ComunInversiones,
     DM_Ayuda_Nemotecnicos,
     DM_Ayuda_Tipo_Empresas,
     DM_FuncionesMemory,
     Registro_Log,
     Valoriza_General,
     Frm_CalculoLimites,
     FRM_ReportErrores;

procedure TServerMethods1.DataModuleCreate(Sender: TObject);
var sNombre_Seccion :string;
    sDirApp         :string;
begin
  inherited;

  dmBaseDatos := TdmBaseDatos.Create(nil);         // cada hilo/llamada tiene su dmPMS

  sDirApp := GetEnvironmentVariable('PMS_API_DIR');
  with TIniFile.Create(sDirApp+'\syspms_desa_api.ini') do
  begin
     bDesarrollo := False;
     sNombre_Seccion     := ReadString('conexion' , 'Activo'   , 'VSECURITY');
     sLogin_Servidor     := '';
     sPasswd_servidor    := '';
     sDriver             := '';
     sLogin_Servidor     := ReadString (sNombre_Seccion, 'LoginIni'        , '');
     if sLogin_Servidor = EmptyStr then
        sLogin_Servidor     := ReadString ('conexion', 'LoginIni'        , 'uconex00');
     sPasswd_servidor    := ReadString (sNombre_Seccion, 'PasswdIni'       , '');
     if sPasswd_servidor = EmptyStr then
        sPasswd_servidor    := ReadString ('conexion', 'PasswdIni'       , 'uconex00');
     sDriver             := ReadString (sNombre_Seccion, 'Driver'                , '');
     if sDriver = EmptyStr then
        sDriver             := ReadString ('conexion', 'Driver'                , 'ORACLE');
     sPuertoId              := ReadString (sNombre_Seccion, 'PuertoId'                , '');
     if sPuertoId = EmptyStr then
        sPuertoId := ReadString('conexion','PuertoId','');
     fItem_Dir_Usuario   := ReadInteger('conexion', 'Item_Dir_Usuario' , 1);
     sBasedatos            := ReadString(sNombre_Seccion,'BaseDatos','');
     sServidor             := ReadString(sNombre_Seccion,'Servidor','');
     sInstancia_Oracle     := ReadString(sNombre_Seccion,'Instancia','');      // Oracle
     sTipo_Conexion_Oracle := ReadString(sNombre_Seccion,'Tipo_Conexion','');  // Normal (Oracle)
     sAutentificacion      := ReadString(sNombre_Seccion,'Autentificacion','');  // Normal (Oracle)
     if UpperCase(sAutentificacion) = 'SI' then
        sAutentificacion := 'Yes';
     sPuertoId             := ReadString(sNombre_Seccion,'PuertoId','');
     sPerfil_Usuario     := ReadString (sNombre_Seccion, 'Perfil_Usuario'   , 'SUP');
     sEmpresa_Usuario    := ReadString (sNombre_Seccion, 'Empresa_Usuario'  , 'CHILENA VI');
     sLogin_sistema      := ReadString (sNombre_Seccion, 'Login_sistema'    , 'MIFUENTEA');
     sArchivo_Ini        := ReadString (sNombre_Seccion, 'Archivo_Ini'      , 'SysPms.ini');
     sIdentidad_usuario  := ReadString (sNombre_Seccion, 'Identidad_Usuario', 'MIFUENTEA');
     sEntidad_Fisica     := ReadString (sNombre_Seccion, 'Entidad_Fisica'   , 'MIFUENTEA');
     sCodigo_Div_Geo_Usuario := ReadString (sNombre_Seccion, 'Div_Geo_Usuario', 'BB');
     sPrivilegio_usuario := ReadString (sNombre_Seccion, 'Privilegio_usuario', 'SUP');

     Free;
  end;
  WITH dmBaseDatos.Conexion_BaseDatos do
  begin
     Close;
     Params.Clear;
     Params.Add('ConnectionName=PMSSERVER');
     Params.Add('DataBase='+sBasedatos);    // MSSQL = Base, Oracle = Instancia
     Params.Add('USER_NAME='+sLogin_Servidor);
     Params.Add('PASSWORD='+sPasswd_servidor);
     Params.Add('OSAuthent='+sAutentificacion);
     if sDriver <> 'ORACLE' then
     begin
       if sPuertoId <> '' then
          Params.Add('SERVER='+sServidor+','+sPuertoId)
       else
          Params.Add('SERVER='+sServidor);
       Params.Add('ApplicationName= Client/Server');
       Params.Add('DriverID='+sDriver);
       Params.Add('Encrypt=No');
       if (sVendorId <> '') OR (sOdbcDriver <> '') then
       begin
          if sOdbcDriver <> '' then
             dmBaseDatos.FDPhysMSSQLDriverLink1.ODBCDriver := sOdbcDriver
          else
          begin
             dmBaseDatos.FDPhysMSSQLDriverLink1.VendorLib := sVendorId;
             dmBaseDatos.FDPhysMSSQLDriverLink1.ODBCDriver := 'SQL Native Client';
          end;
          dmBaseDatos.FDPhysMSSQLDriverLink1.ODBCAdvanced := 'MARS_Connection=yes;Regional=yes';
       end;
     end
     else
     begin
       Params.Add('SERVER='+sServidor);
       Params.Add('ApplicationName= Client/Server');
       Params.Add('AuthMode=Normal');
       Params.Add('DriverID=Ora');
       if sVendorId <> '' then
          dmBaseDatos.FDPhysOracleDriverLink1.VendorLib := sVendorId;
       if sPuertoId <> '' then
          Params.Add('Port='+sPuertoId);
       Params.Add('Pooled=True');
       Params.Add('MARS=Yes');
     end;
     try
        Open;   //Conecta Base inicial
     except
     end;
  end;
  WITH dmBaseDatos.FDConnection1 do
  begin
     Close;
     Params.Clear;
     Params.Add('ConnectionName=PMSSERVER');
     Params.Add('DataBase='+sBasedatos);    // MSSQL = Base, Oracle = Instancia
     Params.Add('USER_NAME='+sLogin_Servidor);
     Params.Add('PASSWORD='+sPasswd_servidor);
     Params.Add('OSAuthent='+sAutentificacion);
     if sDriver <> 'ORACLE' then
     begin
       if sPuertoId <> '' then
          Params.Add('SERVER='+sServidor+','+sPuertoId)
       else
          Params.Add('SERVER='+sServidor);
       Params.Add('ApplicationName= Client/Server');
       Params.Add('DriverID='+sDriver);
       Params.Add('Encrypt=No');
       if (sVendorId <> '') OR (sOdbcDriver <> '') then
       begin
          if sOdbcDriver <> '' then
             dmBaseDatos.FDPhysMSSQLDriverLink1.ODBCDriver := sOdbcDriver
          else
          begin
             dmBaseDatos.FDPhysMSSQLDriverLink1.VendorLib := sVendorId;
             dmBaseDatos.FDPhysMSSQLDriverLink1.ODBCDriver := 'SQL Native Client';
          end;
          dmBaseDatos.FDPhysMSSQLDriverLink1.ODBCAdvanced := 'MARS_Connection=yes;Regional=yes';
       end;
     end
     else
     begin
       Params.Add('SERVER='+sServidor);
       Params.Add('ApplicationName= Client/Server');
       Params.Add('AuthMode=Normal');
       Params.Add('DriverID=Ora');
       if sVendorId <> '' then
          dmBaseDatos.FDPhysOracleDriverLink1.VendorLib := sVendorId;
       if sPuertoId <> '' then
          Params.Add('Port='+sPuertoId);
       Params.Add('Pooled=True');
       Params.Add('MARS=Yes');
     end;
     try
        Open;   //Conecta Base inicial
     except
        begin
        end;
     end;
  end;

end;

procedure TServerMethods1.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(dmBaseDatos);
  inherited;
end;

function TServerMethods1.Conexion_Basedatos :Boolean;
begin

   if not dmBaseDatos.Conexion_BaseDatos.Connected then
   begin
      Result := false;
      Exit;
   end;

   Application.UpdateFormatSettings := true;

   FormatSettings.DateSeparator        := '/';
   FormatSettings.ShortDateFormat      :='dd/MM/yyyy';

   {$j+}
   Fecha_Nula := DateToStr(EncodeDate(1899,12,30));
   {$j-}

   ytiempo := 0;
   Inactividad := 1;
   Inactivo := False;
   Inactividad_fecha := 1;
   tiempo_fecha := 0;

   habilita_mapeo;
   dfecha_hora   := Fecha_Hora_Servidor;
   sPais_Usuario := Pais_Para_CodGeo_Mem(sCodigo_Div_Geo_Usuario);

   Result := true;

end;

function TServerMethods1.ObtenerCarteras(sEmpresa: string): TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

   Qry_General.Close;
   Qry_General.SQL.Clear;
   Qry_General.SQL.Add('select * ');
   Qry_General.SQL.Add('  from qs_fin_carteras ');
   if sEmpresa <> '' then
   begin
      Qry_General.SQL.Add(' where cod_empresa = :cod_empresa');
      Qry_General.ParamByName('cod_empresa').AsString := sEmpresa;
   end;
   Qry_General.SQL.Add(' order by cod_empresa, cod_cartera ');
   Qry_General.Open;

   if not Qry_General.Eof then
   begin
      ArregloJson := TJSONArray.Create;
      JSONProd    := TJSONObject.Create;
      JSONProd.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
      JSONProd.AddPair('Mensaje' ,'Peticion exitosa');
      JSONProd.AddPair('Data',ArregloJson);
      while not Qry_General.Eof do
      begin
         JSON := TJSONObject.Create;

         JSON.AddPair('cod_empresa'      ,TJSONString.Create(Qry_General.FieldByName('cod_empresa').AsString));
         JSON.AddPair('cod_cartera'      ,TJSONString.Create(Qry_General.FieldByName('cod_cartera').AsString));
         JSON.AddPair('descripcion'      ,TJSONString.Create(Qry_General.FieldByName('descripcion').AsString));
         JSON.AddPair('tipo_cartera'     ,TJSONString.Create(Qry_General.FieldByName('tipo_cartera').AsString));
         JSON.AddPair('cod_ent_cli'      ,TJSONString.Create(Qry_General.FieldByName('cod_ent_cli').AsString));
         JSON.AddPair('moneda_cartera'   ,TJSONString.Create(Qry_General.FieldByName('moneda_cartera').AsString));
         JSON.AddPair('administra'       ,TJSONString.Create(Qry_General.FieldByName('administra').AsString));
         JSON.AddPair('prorrateo_valores',TJSONString.Create(Qry_General.FieldByName('prorrateo_valores').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'No existen carteras para empresa '+sEmpresa);
      Result := JSON;
   end;

   Qry_General.Close;

end;

function TServerMethods1.ObtenerEmisores: TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :String;
begin
   if not Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

   Qry_General.Close;
   Qry_General.SQL.Clear;
   Qry_General.SQL.Add('select * ');
   Qry_General.SQL.Add('  from QS_SYS_ID_TIPO ');
   Qry_General.SQL.Add(' where TIPO_EMPRESA = ''EMI'' ');
   Qry_General.Open;

   if not Qry_General.Eof then
   begin
      ArregloJson := TJSONArray.Create;
      JSONProd    := TJSONObject.Create;
      JSONProd.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
      JSONProd.AddPair('Data',ArregloJson);
      while not Qry_General.Eof do
      begin
         JSON := TJSONObject.Create;

         JSON.AddPair('Codigo_Identidad',TJSONString.Create(Qry_General.FieldByName('Codigo_Identidad').AsString));
         JSON.AddPair('Fecha_Desde'     ,TJSONString.Create(Qry_General.FieldByName('Fecha_Desde').AsString));
         JSON.AddPair('Fecha_Hasta'     ,TJSONString.Create(Qry_General.FieldByName('Fecha_Hasta').AsString));
         JSON.AddPair('Tipo_Empresa'    ,TJSONString.Create(Qry_General.FieldByName('Tipo_Empresa').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'No existen Emisores ');
      Result := JSON;
   end;

   Qry_General.Close;
end;

function TServerMethods1.ObtenerInstrumentos: TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

   Qry_General.Close;
   Qry_General.SQL.Clear;
   Qry_General.SQL.Add('select * ');
   Qry_General.SQL.Add('  from QS_FIN_INSTRUM ');
   Qry_General.Open;

   if not Qry_General.Eof then
   begin
      ArregloJson := TJSONArray.Create;
      JSONProd    := TJSONObject.Create;
      JSONProd.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
      JSONProd.AddPair('Data',ArregloJson);
      while not Qry_General.Eof do
      begin
         JSON := TJSONObject.Create;

         JSON.AddPair('Cod_Instrumento'  ,TJSONString.Create(Qry_General.FieldByName('Cod_Instrumento').AsString));
         JSON.AddPair('Nom_Instrumento'  ,TJSONString.Create(Qry_General.FieldByName('Nom_Instrumento').AsString));
         JSON.AddPair('Si_No_Descriptor' ,TJSONString.Create(Qry_General.FieldByName('Si_No_Descriptor').AsString));
         JSON.AddPair('Tip_Tas_Valor_Par',TJSONString.Create(Qry_General.FieldByName('Tip_Tas_Valor_Par').AsString));
         JSON.AddPair('Tip_Tas_Valor_PTe',TJSONString.Create(Qry_General.FieldByName('Tip_Tas_Valor_PTe').AsString));
         JSON.AddPair('Cod_Calc_Par_Ins' ,TJSONString.Create(Qry_General.FieldByName('Cod_Calc_Par_Ins').AsString));
         JSON.AddPair('Cod_Calc_Pte_Ins' ,TJSONString.Create(Qry_General.FieldByName('Cod_Calc_Pte_Ins').AsString));
         JSON.AddPair('Tipo_Instrumento' ,TJSONString.Create(Qry_General.FieldByName('Tipo_Instrumento').AsString));
         JSON.AddPair('Si_No_Opciones'   ,TJSONString.Create(Qry_General.FieldByName('Si_No_Opciones').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'No existen Emisores ');
      Result := JSON;
   end;

   Qry_General.Close;
end;

function TServerMethods1.updateValoriza_RF(Parametros: TJSONObject): TJSONObject;
var JSONResult        :TJSONObject;
    vJSONP            :TJSONValue;
    JSONArray         :TJSONArray;
    ArrayElement      :TJSONValue;
    ArrayCarteras     :TCarteras;
    ArrayEmisores     :TEmisores;
    ArrayInstrumentos :TInstrumentos;
    dFecha_Desde      :TDateTime;
    dFecha_Hasta      :TDateTime;
    Reg_Parametros    :TParametros;
    sProceso          :String;
    sCaption          :String;
    bAbortar          :Boolean;
    i                 :Integer;
    sMensaje          :String;
    sUserName         :String;
    sHostName         :String;
    sIPaddr           :String;
    sMacAddr          :String;
    sUserName_Win_Val :String;
    sUsuario_Pms_Val  :String;
    sPid_Val          :String;
    sEmpresa_Val      :String;
    bResult           :Boolean;
begin

//{
//    "dFecha_Desde": "30/09/2023",
//    "dFecha_Hasta": "30/09/2023",
//    "Reg_Parametros": {
//        "bEmisores": false,
//        "bInstrumentos": false,
//        "bCarteras": true,
//        "bSerie": false,
//        "bNemotecnico": false,
//        "bExcepcion": false,
//        "bFolios": false,
//        "bSolo_Var": false,
//        "Modulo_Llamado": "STOCK_MESA",
//        "sTipo_de_Proceso": "API",
//        "iIncluye": 0,
//       "bGenera_Stock": true,
//       "bSolo_Stock": false
//    },
//    "sProceso": "STOCK",
//    "sCaption": "VALORIZACION",
//    "Carteras":
//       [{
//          "Empresa": "VSECURITY",
//          "Cartera": "AGF"
//       },
//       {
//          "Empresa": "VSECURITY",
//          "Cartera": "INMOBIL"
//       }]
//}

//{
// "Estado": "1",
// "Mensaje": "Proceso Ejecutado"
//}

   dFecha_Desde := StrToDate(Parametros.GetValue<String>('dFecha_Desde'));
   dFecha_Hasta := StrToDate(Parametros.GetValue<String>('dFecha_Hasta'));

   vJSONP := Parametros.GetValue <TJSONValue>('Reg_Parametros');
   Reg_Parametros.bEmisores        := vJSONP.Getvalue<Boolean>('bEmisores');
   Reg_Parametros.bInstrumentos    := vJSONP.Getvalue<Boolean>('bInstrumentos');
   Reg_Parametros.bCarteras        := vJSONP.Getvalue<Boolean>('bCarteras');
   Reg_Parametros.bSerie           := vJSONP.Getvalue<Boolean>('bSerie');
   Reg_Parametros.bNemotecnico     := vJSONP.Getvalue<Boolean>('bNemotecnico');
   Reg_Parametros.bExcepcion       := vJSONP.Getvalue<Boolean>('bExcepcion');
   Reg_Parametros.bFolios          := vJSONP.Getvalue<Boolean>('bFolios');
   Reg_Parametros.bSolo_Var        := vJSONP.Getvalue<Boolean>('bSolo_Var');
   Reg_Parametros.Modulo_Llamado   := vJSONP.Getvalue<String>('Modulo_Llamado');
   Reg_Parametros.sTipo_de_Proceso := vJSONP.Getvalue<String>('sTipo_de_Proceso');
   Reg_Parametros.iIncluye         := vJSONP.Getvalue<Integer>('iIncluye');
   Reg_Parametros.bGenera_Stock    := vJSONP.Getvalue<Boolean>('bGenera_Stock');
   Reg_Parametros.bSolo_Stock      := vJSONP.Getvalue<Boolean>('bSolo_Stock');

   sProceso     := Parametros.GetValue<String>('sProceso');
   sCaption     := Parametros.GetValue<String>('sCaption');

   if Reg_Parametros.bCarteras then
   begin
      i := 0;
      JSONArray := Parametros.GetValue <TJSONArray>('Carteras');
      for ArrayElement in JSONArray do
          inc(i);
      ArrayCarteras.Empresa := VarArrayCreate([0,i],varOleStr);
      ArrayCarteras.cartera := VarArrayCreate([0,i],varOleStr);
      i := 1;
      for ArrayElement in JSONArray do
      begin
         ArrayCarteras.Empresa[i] := ArrayElement.Getvalue<string>('Empresa');
         ArrayCarteras.cartera[i] := ArrayElement.Getvalue<string>('Cartera');
         inc(i);
      end;
   end;

   if Reg_Parametros.bEmisores then
   begin
      i := 0;
      JSONArray := Parametros.GetValue <TJSONArray>('Emisores');
      for ArrayElement in JSONArray do
          inc(i);
      ArrayEmisores.Emisor := VarArrayCreate([0,i],varOleStr);
      i := 1;
      for ArrayElement in JSONArray do
      begin
         ArrayEmisores.Emisor[i] := ArrayElement.Getvalue<string>('Emisor');
         inc(i);
      end;
   end;

   if Reg_Parametros.bInstrumentos then
   begin
      i := 0;
      JSONArray := Parametros.GetValue <TJSONArray>('Instrumentos');
      for ArrayElement in JSONArray do
          inc(i);
      ArrayInstrumentos.Instrumento := VarArrayCreate([0,i],varOleStr);
      i := 1;
      for ArrayElement in JSONArray do
      begin
         ArrayInstrumentos.Instrumento[i] := ArrayElement.Getvalue<string>('Instrumento');
         inc(i);
      end;
   end;

   JSONResult    := TJSONObject.Create;

   if not Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      exit;
   end;

   // ggarcia 19-11-2015
   // Se agrega validación de cierre operacional y de valorizaciones SS 19-07-2022
   With Qry_General do
   begin
     Sql.Clear;
     SQL.Add('SELECT * FROM QS_SYS_COD_DET ');
     SQL.Add('  WHERE COD_DETAIL = ''CIERVAL''');
     SQL.Add(' AND COD_GENERAL = ''PROCON''');
     Open;
     if not eof then
       sProceso := 'CIERVAL'
     else
       sProceso := 'OPERAC';
   end;
   //fin SS 19-07-2022

   if verifica_cierre(sProceso
                     ,Reg_Parametros.bCarteras
                     ,dFecha_Desde
                     ,sMensaje) then
   begin
      sMensaje := Pchar('Las Operaciones se encuentran'+sMensaje+'al '+datetostr(dFecha_Desde)+' No se puede Valorizar');
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      exit;
   end;
   // fin ggarcia 19-11-2015

   // ggarcia 13-04-2020
   if Transaccion_Implica( sEmpresa_Usuario, 'PERFILCART') then
     if Existe_Perfil_Cartera(sPerfil_Usuario) then
        if verifica_carteras(IntToStr(Application.Handle)
                            ,sMensaje) then
        begin
           JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
           JSONResult.AddPair('Mensaje' ,sMensaje);
           Result := JSONResult;
           exit;
        end;
   // fin ggarcia 13-04-2020

   if (Reg_Parametros.bInstrumentos) or (Reg_Parametros.bEmisores) then
   begin
      if Not Reg_Parametros.bCarteras then
      begin
         sMensaje := Pchar('Debe Seleccionar Cartera para Selección de Emisor, Instrumento');
         JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
         JSONResult.AddPair('Mensaje' ,sMensaje);
         Result := JSONResult;
         Exit;
      end;
   end;

   Info_Conexion(sUserName, sHostName, sIPaddr, sMacAddr);

   Verifica_Proceso_En_Ejecucion('Valorizacion de Posicion'  // proceso log
                                ,trim(sEmpresa_Usuario)
                                ,trim(sUserName)
                                ,sUserName_Win_Val
                                ,sUsuario_Pms_Val
                                ,sPid_Val
                                ,sEmpresa_Val
                                ,bResult);
   if bResult then
   begin
      sMensaje := Pchar('Ya se está ejecutando un proceso de Valorización generado por usuario: '+Trim(sUserName_Win_Val)
                       +', Usuario PMS :'+sUsuario_Pms_Val+ ', Empresa :'+sEmpresa_Val+' Proceso : '+sPid_Val);
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      Exit;
   end;

   //ggarcia 10-11-2017
   Verifica_Proceso_En_Ejecucion('Carga IIF - Carga'  // proceso log
                                ,trim(sEmpresa_Usuario)
                                ,trim(sUserName)
                                ,sUserName_Win_Val
                                ,sUsuario_Pms_Val
                                ,sPid_Val
                                ,sEmpresa_Val
                                ,bResult);
   if bResult then
   begin
      sMensaje := Pchar('No puede valorizar, se está ejecutando un proceso de Carga Automatica de Operaciones por usuario: '+Trim(sUserName_Win_Val)
                       +', Usuario PMS :'+sUsuario_Pms_Val+ ', Empresa :'+sEmpresa_Val+' Proceso : '+sPid_Val);
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      Exit;
   end;
   Verifica_Proceso_En_Ejecucion('Carga IRF - Carga'  // proceso log
                                ,trim(sEmpresa_Usuario)
                                ,trim(sUserName)
                                ,sUserName_Win_Val
                                ,sUsuario_Pms_Val
                                ,sPid_Val
                                ,sEmpresa_Val
                                ,bResult);
   if bResult then
   begin
      sMensaje := Pchar('No puede valorizar, se está ejecutando un proceso de Carga Automatica de Operaciones por usuario: '+Trim(sUserName_Win_Val)
                       +', Usuario PMS :'+sUsuario_Pms_Val+ ', Empresa :'+sEmpresa_Val+' Proceso : '+sPid_Val);
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      Exit;
   end;


   TTask.Run(
   procedure
   var i :Integer;
   begin

      Logs_Valorizacion_RF(dFecha_Desde,dFecha_Hasta,Reg_Parametros);

      Elimina_Param_Empresa(Application.Handle);
      Elimina_Param_Proceso(Floattostr(Application.Handle));

      if Reg_Parametros.bCarteras then
         for i := 1 to VarArrayHighBound(ArrayCarteras.Cartera,1) do
             Graba_param_empresa(ArrayCarteras.Empresa[i]
                                ,ArrayCarteras.Cartera[i]
                                ,Application.Handle);

      // Esto es para el caso general, deja grabado un unico registro
      if Not Reg_Parametros.bCarteras then
         Graba_param_proceso(Floattostr(Application.Handle)
                            ,'EMPRESA'
                            ,sEmpresa_Usuario)
      else
         Graba_Empresas_param_proceso(Floattostr(Application.Handle)
                                     ,'EMPRESA');

      if Reg_Parametros.bEmisores then
         for i := 1 to VarArrayHighBound(ArrayEmisores.Emisor,1) do
             Graba_param_proceso(Floattostr(Application.Handle)
                                ,'STK_EMISOR'
                                ,ArrayEmisores.Emisor[i]);

      if Reg_Parametros.bInstrumentos then
         for i := 1 to VarArrayHighBound(ArrayInstrumentos.Instrumento,1) do
             Graba_param_proceso(Floattostr(Application.Handle)
                                ,'STK_INST'
                                ,ArrayInstrumentos.Instrumento[i]);

      bAbortar := False;

      Proceso_Valorizacion(dFecha_Desde
                          ,dFecha_Hasta
                          ,Reg_Parametros
                          ,sProceso
                          ,sCaption
                          ,bAbortar);

   end); //TTask.Run(..);

   JSONResult.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
   JSONResult.AddPair('Mensaje' ,'Proceso Ejecutado ');
   JSONResult.AddPair('PID' ,Floattostr(Application.Handle));
   Result := JSONResult;

end;

procedure TServerMethods1.Logs_Valorizacion_RF(dFecha_Desde   :TDateTime;
                                               dFecha_Hasta   :TDateTime;
                                               Reg_Parametros :TParametros);

var i :Integer;
begin
   fPid        := Application.Handle;
   sPrograma   := 'MD - Valorizacion de Posicion Renta Fija';
   dfecha_hora := Fecha_Hora_Servidor;
   i := 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;

   // Rango Fechas
   Array_Reg_Log[i].Campo      := 'Rango Fechas';
   if dFecha_Desde <> dFecha_Hasta then
   begin
      Array_Reg_Log[i].Valor := 'S';
      i := i + 1;
      Array_Reg_Log[i].Pid        := fPid;
      Array_Reg_Log[i].Fecha_hora := dfecha_hora;
      Array_Reg_Log[i].Campo      := 'Fecha Desde';
      Array_Reg_Log[i].Valor      := DateToStr(dFecha_Desde);
      i := i + 1;
      Array_Reg_Log[i].Pid        := fPid;
      Array_Reg_Log[i].Fecha_hora := dfecha_hora;
      Array_Reg_Log[i].Campo      := 'Fecha Hasta';
      Array_Reg_Log[i].Valor      := DateToStr(dFecha_Hasta);
   end
   else
   begin
      Array_Reg_Log[i].Valor := 'N';
      i := i + 1;
      Array_Reg_Log[i].Pid        := fPid;
      Array_Reg_Log[i].Fecha_hora := dfecha_hora;
      Array_Reg_Log[i].Campo      := 'Fecha Desde';
      Array_Reg_Log[i].Valor      := DateToStr(dFecha_Desde);
   end;

   // Carteras
   i := i + 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;
   Array_Reg_Log[i].Campo      := 'Carteras';
   if Reg_Parametros.bCarteras then
   begin
      Array_Reg_Log[i].Valor := 'S';
      agrega_datosarray_cartera(i);
   end
   else
      Array_Reg_Log[i].Valor := 'N';

   // Instrumentos
   i := i + 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;
   Array_Reg_Log[i].Campo      := 'Instrumentos';
   if Reg_Parametros.bInstrumentos then
   begin
      Array_Reg_Log[i].Valor := 'S';
      agrega_datosarray(i,'STK_INST');
   end
   else
      Array_Reg_Log[i].Valor := 'N';

   // Emisores
   i := i + 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;
   Array_Reg_Log[i].Campo      := 'Emisores';
   if Reg_Parametros.bEmisores then
   begin
      Array_Reg_Log[i].Valor := 'S';
      agrega_datosarray(i,'STK_EMISOR');
   end
   else
      Array_Reg_Log[i].Valor := 'N';

   // Genera Stock
   i := i + 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;
   Array_Reg_Log[i].Campo      := 'Genera Stock';
   if Reg_Parametros.bGenera_Stock then
      Array_Reg_Log[i].Valor := 'S'
   else
      Array_Reg_Log[i].Valor := 'N';

   // Solo Stock
   i := i + 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;
   Array_Reg_Log[i].Campo      := 'Solo Stock';
   if Reg_Parametros.bSolo_Stock then
      Array_Reg_Log[i].Valor := 'S'
   else
      Array_Reg_Log[i].Valor := 'N';

   inserta_Log(True);
end;

function TServerMethods1.updateValoriza_OMD(Parametros: TJSONObject): TJSONObject;
var JSONResult    :TJSONObject;
    vJSONP        :TJSONValue;
    JSON          :TJSONObject;
    JSONRegDes    :TJSONObject;
    JSONArray     :TJSONArray;
    JSONTabDes    :TJSONObject;
    sMensaje      :String;
    i             :Integer;
    sFecha        :String;

    Reg_Val_In    :TRegistro_Valoriza_In;
    Reg_Val_Out   :TRegistro_Valoriza_Out;
    sModulo_Error :String;
    sString_Error :String;
    bResult       :Boolean;
begin
//{
//    "Reg_Val_In": {
//        "Tipo_Instrumento": "",
//        "sEmisor": "",
//        "sInstrumento": "",
//        "sSerie": "",
//        "dFecha_Vig": "01011900",
//        "Nemotecnico": "",
//        "Nemotecnico_Original": "",
//        "dTasaEmision": 0,
//        "sUnidadMonetaria": "",
//        "sTipoNominales": "",
//        "dFechaEmision": "01011900",
//        "dFechaVencimiento": "",
//        "dFechaCalculo": "01011900",
//        "dFechaCalculoOriginal": "01011900",
//        "dFechaCompra": "01011900",
//        "dFechaOperacion": "01011900",
//        "dFechaPago": "01011900",
//        "sMoneda_Conversion": "",
//        "Con_Cupon": false,
//        "Valoriza_Par_Pte": "",
//        "Numero_Titulos": 0,
//        "Forzar_Uso_Formula_PAR": "",
//        "Formula_PAR": "",
//        "Forzar_Uso_Formula_PTE": "",
//        "Formula_PTE": "",
//        "Tabla_Desarr_Cargada": "",
//        "Pais_Titulo": "",
//        "Motivo_Operacion": "",
//        "Nominales_Compra": 0,
//        "ValorInvertidoUM_Compra": 0,
//        "Re_Llamado": "",
//        "Tipo_Proceso": "",
//        "Tasa_Compra": 0,
//        "Spread": 0,
//        "Descriptor_Cargado": "",
//        "Proceso_Valuacion": "",
//        "Cartera": "",
//        "LLamado_por": "",
//        "Tasa_Base_Pacto": "",
//        "Emision_Implicita": "",
//        "sValor_Cupon_Original": "",
//        "sComponentes_Descuento": "",
//        "fCupones_Cortados": 0,
//        "bIncluye_CC": false,
//        "Considera_Devengamiento_Formula": "",
//        "Modulo_Llamado": "",
//        "Fuerza_Tasa_Cero": "",
//        "Transaccion": "",
//        "Empresa": "",
//        "Folio_Interno": "",
//        "Item_OMD": 0,
//        "Tipo_Cambio": "",
//    },
//}

//{
// "Estado": "1",
// "Mensaje": "Proceso Ejecutado"
// "Reg_Val_Out":
//        {
//        "Nominales": 0,
//        "Nominales": 0,
//        "TasaCalculo": 0,
//        "PorcentajePar": 0,
//        "ValorInvertidoUM": 0,
//        "ValorInvertidoMC": 0,
//        "TasaEstimada": 0,
//        "Valor_Par_UM_Sin_Reajuste": 0,
//        "Valor_Par_UM": 0,
//        "Valor_Par_MC": 0,
//        "fValor_Final_UM": 0,
//        "Valor_Par_Base": 0,
//        "Array_Mem_Desarr":
//              [{
//              "Nro_Cupon": 1,
//              "Tipo_Tasa": "",
//              "Tratamiento": "",
//              "Operacion": "",
//              "Factor": 0,
//              "Interes": 0,
//              "Amortizacion": 0,
//              "Reajuste_Capital_Pagado": 0,
//              "Valor_Cupon": 0,
//              "Valor_Cupon_Descontado": 0,
//              "Saldo_Insoluto": 0,
//              "Valor_Tasa": 0,
//              "Tasa_Flujo": 0,
//              "Factor_cap": 0,
//              "Capitalizado": 0,
//              "Capitalizado_Cupon": 0,
//              "Fecha_Vcto_Anterior": "01/01/1900",
//              "Fecha_Vcto": "01/01/1900",
//              "Dias_Al_Vcto": 0,
//              "Real_Estimado": "",
//              "Tasa_Basica": 0,
//              "Tasa_Riesgo": 0,
//              "Tasa_de_Descuento": 0,
//              "Factor_Descuento": 0,
//              "Valoriza_Con_TDesc": "",
//              "Interes_Original": 0,
//              "Amortizacion_Original": 0,
//              "Valor_Cupon_Original": 0,
//              "Saldo_Insoluto_Original": 0,
//              "Fecha_Tasa": "01/01/1900",
//              "Cupon_Cortado": false,
//              "Codigo_Tratam": "",
//              "Cantidad": 0,
//              "Unidad": "",
//              "Habiles": "",
//              "Antes_Despues": "",
//              "Referencia": "",
//              "Codigo_Pais": "",
//              "Factor_Varcam": 0,
//              "Cod_Moneda_Ind": "",
//              "Cod_Tratam_Inicio": "",
//              "Cod_Tratam_Termino": "",
//              "Valor_Ind_Inicio": 0,
//              "Valor_Ind_Termino": 0,
//              "Fecha_Inicio": "01/01/1900",
//              "Fecha_Termino": "01/01/1900",
//              "Dias_Base_PAR": 0,
//              "Periodos_Tasa_Base_Variable": 0,
//              "Saldo_insoluto_Sin_Capitalizaciones": 0,
//              "Fecha_Tipo_Cambio       : TDateTime;
//              "Amortizaciones_Segun_Fecha_de_Compra": 0,
//              "Saldo_Insoluto_Segun_Fecha_de_Compra": 0,
//              "Capitalizado_Segun_Fecha_de_Compra": 0,
//              "Capitalizado_Entre_Compra_y_Calculo": 0,
//              "Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo": 0,
//              "Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado": 0,
//              "Fecha_Tasa_Flotante": "01/01/1900",
//              "Curva_Proy_utilizada": "",
//              "Dias_Proyeccion": 0,
//              "Tasa_Proyeccion": 0,
//              "FD_Proyeccion_fin": 0,
//              "FD_Proyeccion_Inicio": 0,
//              "Valor_Tasa_Descuento": 0,
//              "Fecha_Liquidacion": "01/01/1900"
//              }]
//        "Precio_Titulo": 0,
//        "TIR_Desarr": 0,
//        "RegDes":
//             {
//             "CODIGO_EMISOR": "".
//             "CODIGO_INSTRUMENTO": "".
//             "SERIE": "".
//             "FECHA_VIG": "01/01/1900",
//             "SERIE_BOLSA": "".
//             "FECHA_EMISION": "01/01/1900",
//             "TASA_EMISION": 0,
//             "TASA_EFECTIVA": 0,
//             "TASA_VALOR_PAR": "".
//             "TASA_VALOR_PTE": "".
//             "UNIDAD_MON": "".
//             "PLAZO_EN_ANOS": 0,
//             "TIPO_AMORTIZAC": "".
//             "NRO_CUPONES": 0,
//             "PERIODO_PAGO": 0,
//             "TIPO_VENCIMIENTO": "".
//             "DIA_VENCIMIENTO": 0,
//             "DECIMAL_AJUSTE": 0,
//             "TIPO_AJUSTE": "".
//             "BASE_ORIGINAL": 0,
//             "BASE_CONVERSION": 0,
//             "COD_CALC_PAR_D": "".
//             "COD_CALC_TIR_D": "".
//             "OPCION_PREPAGO": "".
//             "FECHA_PREPAGO": "01/01/1900",
//             "PRECIO_PREPAGO": 0,;
//             "TASA_FLOTANTE": "".
//             "TIPO_NOMINALES": "".
//             "FECHAS_SINO": "".
//             "Tipo_pago": "".
//             "Periodo_Gracia": 0,
//             "Codigo_Emisor_Old": "".
//             "Codigo_Instrumento_Old": "".
//             "Serie_Old": "".
//             "COD_CALC_PAR_D_Old": "".
//             "COD_CALC_TIR_D_Old": "".
//             "Fecha_Carga_Array_Mem": "01/01/1900",
//             "Variacion_Cambiaria": false,
//             "fCupones_Cortados": 0,
//             "Dias_Base_Variables": false,
//             "bSin_Tasa_en_Flujos": false
//             }
//        "Tipo_Valuacion": "",
//        "Rate_Used_Valuacion": 0,
//        "Impuestos_Acc": 0,
//        "Precio": 0,
//        "Nemotecnico": "",
//        "Result_Inst_Vencido": false,
//        "Precio_Limpio": 0,
//        "Precio_Sucio": 0,
//        "Valor_Par_ya_Calculado": false,
//        "Tipo_Tasa_Precio": "",
//        "Tipo_cambio": 0,
//        "FX_Points": 0,
//        "Tipo_cambio_fwd": 0,
//        "Origen": "",
//        "Valor_Razonable_Pos_Larga": 0,
//        "Valor_Razonable_Pos_Corta": 0
//    },
//}

   vJSONP := Parametros.GetValue<TJSONValue>('Reg_Val_In');
   Reg_Val_In.Tipo_Instrumento                := vJSONP.Getvalue<String>('Tipo_Instrumento');
   Reg_Val_In.sEmisor                         := vJSONP.Getvalue<String>('sEmisor');
   Reg_Val_In.sInstrumento                    := vJSONP.Getvalue<String>('sInstrumento');
   Reg_Val_In.sSerie                          := vJSONP.Getvalue<String>('sSerie');
   sFecha := vJSONP.Getvalue<String>('dFecha_Vig');
   Reg_Val_In.dFecha_Vig                      := String_a_Date(sFecha);
   Reg_Val_In.Nemotecnico                     := vJSONP.Getvalue<String>('Nemotecnico');
   Reg_Val_In.Nemotecnico_Original            := vJSONP.Getvalue<String>('Nemotecnico_Original');
   Reg_Val_In.dTasaEmision                    := vJSONP.Getvalue<Double>('dTasaEmision');
   Reg_Val_In.sUnidadMonetaria                := vJSONP.Getvalue<String>('sUnidadMonetaria');
   Reg_Val_In.sTipoNominales                  := vJSONP.Getvalue<String>('sTipoNominales');
   sFecha := vJSONP.Getvalue<String>('dFechaEmision');
   Reg_Val_In.dFechaEmision                   := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<String>('dFechaVencimiento');
   Reg_Val_In.dFechaVencimiento               := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<String>('dFechaCalculo');
   Reg_Val_In.dFechaCalculo                   := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<String>('dFechaCalculoOriginal');
   Reg_Val_In.dFechaCalculoOriginal           := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<String>('dFechaCompra');
   Reg_Val_In.dFechaCompra                    := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<String>('dFechaOperacion');
   Reg_Val_In.dFechaOperacion                 := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<String>('dFechaPago');
   Reg_Val_In.dFechaPago                      := String_a_Date(sFecha);
   Reg_Val_In.sMoneda_Conversion              := vJSONP.Getvalue<String>('sMoneda_Conversion');
   Reg_Val_In.Con_Cupon                       := vJSONP.Getvalue<Boolean>('Con_Cupon');
   Reg_Val_In.Valoriza_Par_Pte                := vJSONP.Getvalue<String>('Valoriza_Par_Pte');
   Reg_Val_In.Numero_Titulos                  := vJSONP.Getvalue<Double>('Numero_Titulos');
   Reg_Val_In.Forzar_Uso_Formula_PAR          := vJSONP.Getvalue<String>('Forzar_Uso_Formula_PAR');
   Reg_Val_In.Formula_PAR                     := vJSONP.Getvalue<String>('Formula_PAR');
   Reg_Val_In.Forzar_Uso_Formula_PTE          := vJSONP.Getvalue<String>('Forzar_Uso_Formula_PTE');
   Reg_Val_In.Formula_PTE                     := vJSONP.Getvalue<String>('Formula_PTE');
   Reg_Val_In.Tabla_Desarr_Cargada            := vJSONP.Getvalue<String>('Tabla_Desarr_Cargada');
   Reg_Val_In.Pais_Titulo                     := vJSONP.Getvalue<String>('Pais_Titulo');
   Reg_Val_In.Motivo_Operacion                := vJSONP.Getvalue<String>('Motivo_Operacion');
   Reg_Val_In.Nominales_Compra                := vJSONP.Getvalue<Double>('Nominales_Compra');
   Reg_Val_In.ValorInvertidoUM_Compra         := vJSONP.Getvalue<Double>('ValorInvertidoUM_Compra');
   Reg_Val_In.Re_Llamado                      := vJSONP.Getvalue<String>('Re_Llamado');
   Reg_Val_In.Tipo_Proceso                    := vJSONP.Getvalue<String>('Tipo_Proceso');
   Reg_Val_In.Tasa_Compra                     := vJSONP.Getvalue<Double>('Tasa_Compra');
   Reg_Val_In.Spread                          := vJSONP.Getvalue<Double>('Spread');
   Reg_Val_In.Descriptor_Cargado              := vJSONP.Getvalue<String>('Descriptor_Cargado');
   Reg_Val_In.Proceso_Valuacion               := vJSONP.Getvalue<String>('Proceso_Valuacion');
   Reg_Val_In.Cartera                         := vJSONP.Getvalue<String>('Cartera');
   Reg_Val_In.LLamado_por                     := vJSONP.Getvalue<String>('LLamado_por');
   Reg_Val_In.Tasa_Base_Pacto                 := vJSONP.Getvalue<String>('Tasa_Base_Pacto');
   Reg_Val_In.Emision_Implicita               := vJSONP.Getvalue<String>('Emision_Implicita');
   Reg_Val_In.sValor_Cupon_Original           := vJSONP.Getvalue<String>('sValor_Cupon_Original');
   Reg_Val_In.sComponentes_Descuento          := vJSONP.Getvalue<String>('sComponentes_Descuento');
   Reg_Val_In.fCupones_Cortados               := vJSONP.Getvalue<Double>('fCupones_Cortados');
   Reg_Val_In.bIncluye_CC                     := vJSONP.Getvalue<Boolean>('bIncluye_CC');
   Reg_Val_In.Considera_Devengamiento_Formula := vJSONP.Getvalue<String>('Considera_Devengamiento_Formula');
   Reg_Val_In.Modulo_Llamado                  := vJSONP.Getvalue<String>('Modulo_Llamado');
   Reg_Val_In.Fuerza_Tasa_Cero                := vJSONP.Getvalue<String>('Fuerza_Tasa_Cero');
   Reg_Val_In.Transaccion                     := vJSONP.Getvalue<String>('Transaccion');
   Reg_Val_In.Empresa                         := vJSONP.Getvalue<String>('Empresa');
   Reg_Val_In.Folio_Interno                   := vJSONP.Getvalue<String>('Folio_Interno');
   Reg_Val_In.Item_OMD                        := vJSONP.Getvalue<Double>('Item_OMD');
   Reg_Val_In.Tipo_Cambio                     := vJSONP.Getvalue<String>('Tipo_Cambio');

   vJSONP := Parametros.GetValue<TJSONValue>('Reg_Val_Out');
   Reg_Val_Out.Nominales                 := vJSONP.Getvalue<Double>('Nominales');
   Reg_Val_Out.TasaCalculo               := vJSONP.Getvalue<Double>('TasaCalculo');
   Reg_Val_Out.PorcentajePar             := vJSONP.Getvalue<Double>('PorcentajePar');
   Reg_Val_Out.ValorInvertidoUM          := vJSONP.Getvalue<Double>('ValorInvertidoUM');
   Reg_Val_Out.ValorInvertidoMC          := vJSONP.Getvalue<Double>('ValorInvertidoMC');
   Reg_Val_Out.TasaEstimada              := vJSONP.Getvalue<Double>('TasaEstimada');
   Reg_Val_Out.Valor_Par_UM_Sin_Reajuste := vJSONP.Getvalue<Double>('Valor_Par_UM_Sin_Reajuste');
   Reg_Val_Out.Valor_Par_UM              := vJSONP.Getvalue<Double>('Valor_Par_UM');
   Reg_Val_Out.Valor_Par_MC              := vJSONP.Getvalue<Double>('Valor_Par_MC');
   Reg_Val_Out.fValor_Final_UM           := vJSONP.Getvalue<Double>('fValor_Final_UM');
   Reg_Val_Out.Valor_Par_Base            := vJSONP.Getvalue<Double>('Valor_Par_Base');
   Reg_Val_Out.Precio_Titulo             := vJSONP.Getvalue<Double>('Precio_Titulo');
   Reg_Val_Out.TIR_Desarr                := vJSONP.Getvalue<Double>('TIR_Desarr');
   Reg_Val_Out.Tipo_Valuacion            := vJSONP.Getvalue<String>('Tipo_Valuacion');
   Reg_Val_Out.Rate_Used_Valuacion       := vJSONP.Getvalue<Double>('Rate_Used_Valuacion');
   Reg_Val_Out.Impuestos_Acc             := vJSONP.Getvalue<Double>('Impuestos_Acc');
   Reg_Val_Out.Precio                    := vJSONP.Getvalue<Double>('Precio');
   Reg_Val_Out.Nemotecnico               := vJSONP.Getvalue<String>('Nemotecnico');
   Reg_Val_Out.Result_Inst_Vencido       := vJSONP.Getvalue<Boolean>('Result_Inst_Vencido');
   Reg_Val_Out.Precio_Limpio             := vJSONP.Getvalue<Double>('Precio_Limpio');
   Reg_Val_Out.Precio_Sucio              := vJSONP.Getvalue<Double>('Precio_Sucio');
   Reg_Val_Out.Result_Inst_Vencido       := vJSONP.Getvalue<Boolean>('Valor_Par_ya_Calculado');
   Reg_Val_Out.Tipo_Tasa_Precio          := vJSONP.Getvalue<String>('Tipo_Tasa_Precio');
   Reg_Val_Out.Tipo_cambio               := vJSONP.Getvalue<Double>('Tipo_cambio');
   Reg_Val_Out.FX_Points                 := vJSONP.Getvalue<Double>('FX_Points');
   Reg_Val_Out.Tipo_cambio_fwd           := vJSONP.Getvalue<Double>('Tipo_cambio_fwd');
   Reg_Val_Out.Origen                    := vJSONP.Getvalue<String>('Origen');
   Reg_Val_Out.Valor_Razonable_Pos_Larga := vJSONP.Getvalue<Double>('Valor_Razonable_Pos_Larga');
   Reg_Val_Out.Valor_Razonable_Pos_Corta := vJSONP.Getvalue<Double>('Valor_Razonable_Pos_Corta');



   JSONResult    := TJSONObject.Create;

   if not Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      exit;
   end;


   if Reg_Val_In.Tipo_Instrumento = 'S' then
   begin
      Leer_Nemotecnico(Reg_Val_In.Nemotecnico
                      ,''
                      ,Reg_Val_In.dFechaEmision
                      ,Reg_Val_In.sEmisor
                      ,Reg_Val_In.sInstrumento
                      ,Reg_Val_In.sSerie
                      ,bResult);
      if not bResult then
      begin
         sModulo_Error := 'Lecura Nemotécnico';
         sString_Error := 'Nemotecnico '+Reg_Val_In.Nemotecnico+' no existe.';
      end
      else
      begin
          Carga_RegDes(Reg_Val_In.Tipo_Instrumento
                      ,Reg_Val_In.Nemotecnico
                      ,Reg_Val_In.sEmisor
                      ,Reg_Val_In.sInstrumento
                      ,Reg_Val_In.sSerie
                      ,Reg_Val_In.sUnidadMonetaria
                      ,Reg_Val_In.dTasaEmision
                      ,Reg_Val_Out.RegDes
                      ,sModulo_Error
                      ,sString_Error
                      ,bResult);
         if bResult then
         begin
            Reg_Val_In.sUnidadMonetaria  := Reg_Val_Out.RegDes.UNIDAD_MON;
            Valorizacion(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         bResult);
         end;
      end;
   end
   else
   begin
      Valorizacion(Reg_Val_In,
                   Reg_Val_Out,
                   sModulo_Error,
                   sString_Error,
                   bResult);
   end;

   if bResult then
   begin
      //ArrayMemDesarr
      JSONArray  := TJSONArray.Create;
      for i := 1 to Max_Nro_Cupones  do
      begin
         JSONTabDes := TJSONObject.Create;

         JSONTabDes.AddPair('Nro_Cupon'                            ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Nro_Cupon));
         JSONTabDes.AddPair('Tipo_Tasa'                            ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Tipo_Tasa));
         JSONTabDes.AddPair('Tratamiento'                          ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Tratamiento));
         JSONTabDes.AddPair('Operacion'                            ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Operacion));
         JSONTabDes.AddPair('Factor'                               ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Factor));
         JSONTabDes.AddPair('Interes'                              ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Interes));
         JSONTabDes.AddPair('Amortizacion'                         ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Amortizacion));
         JSONTabDes.AddPair('Reajuste_Capital_Pagado'              ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Reajuste_Capital_Pagado));
         JSONTabDes.AddPair('Valor_Cupon'                          ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valor_Cupon));
         JSONTabDes.AddPair('Valor_Cupon_Descontado'               ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valor_Cupon_Descontado));
         JSONTabDes.AddPair('Saldo_Insoluto'                       ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Saldo_Insoluto));
         JSONTabDes.AddPair('Valor_Tasa'                           ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valor_Tasa));
         JSONTabDes.AddPair('Tasa_Flujo'                           ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Tasa_Flujo));
         JSONTabDes.AddPair('Factor_cap'                           ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Factor_cap));
         JSONTabDes.AddPair('Capitalizado'                         ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Capitalizado));
         JSONTabDes.AddPair('Capitalizado_Cupon'                   ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Capitalizado_Cupon));
         JSONTabDes.AddPair('Fecha_Vcto_Anterior'                  ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Vcto_Anterior)));
         JSONTabDes.AddPair('Fecha_Vcto'                           ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Vcto)));
         JSONTabDes.AddPair('Dias_Al_Vcto'                         ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Dias_Al_Vcto));
         JSONTabDes.AddPair('Real_Estimado'                        ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Real_Estimado));
         JSONTabDes.AddPair('Tasa_Basica'                          ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Tasa_Basica));
         JSONTabDes.AddPair('Tasa_Riesgo'                          ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Tasa_Riesgo));
         JSONTabDes.AddPair('Tasa_de_Descuento'                    ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Tasa_de_Descuento));
         JSONTabDes.AddPair('Factor_Descuento'                     ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Factor_Descuento));
         JSONTabDes.AddPair('Valoriza_Con_TDesc'                   ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valoriza_Con_TDesc));
         JSONTabDes.AddPair('Interes_Original'                     ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Interes_Original));
         JSONTabDes.AddPair('Amortizacion_Original'                ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Amortizacion_Original));
         JSONTabDes.AddPair('Valor_Cupon_Original'                 ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valor_Cupon_Original));
         JSONTabDes.AddPair('Saldo_Insoluto_Original'              ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Saldo_Insoluto_Original));
         JSONTabDes.AddPair('Fecha_Tasa'                           ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Tasa)));
         JSONTabDes.AddPair('Cupon_Cortado'                        ,TJSONBool.Create(Reg_Val_Out.Array_Mem_Desarr[i].Cupon_Cortado));
         JSONTabDes.AddPair('Codigo_Tratam'                        ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Codigo_Tratam));
         JSONTabDes.AddPair('Cantidad'                             ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Cantidad));
         JSONTabDes.AddPair('Unidad'                               ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Unidad));
         JSONTabDes.AddPair('Habiles'                              ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Habiles));
         JSONTabDes.AddPair('Antes_Despues'                        ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Antes_Despues));
         JSONTabDes.AddPair('Referencia'                           ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Referencia));
         JSONTabDes.AddPair('Codigo_Pais'                          ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Codigo_Pais));
         JSONTabDes.AddPair('Factor_Varcam'                        ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Factor_Varcam));
         JSONTabDes.AddPair('Cod_Moneda_Ind'                       ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Cod_Moneda_Ind));
         JSONTabDes.AddPair('Cod_Tratam_Inicio'                    ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Cod_Tratam_Inicio));
         JSONTabDes.AddPair('Cod_Tratam_Termino'                   ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Cod_Tratam_Termino));
         JSONTabDes.AddPair('Valor_Ind_Inicio'                     ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valor_Ind_Inicio));
         JSONTabDes.AddPair('Valor_Ind_Termino'                    ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valor_Ind_Termino));
         JSONTabDes.AddPair('Fecha_Inicio'                         ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Inicio)));
         JSONTabDes.AddPair('Fecha_Termino'                        ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Termino)));
         JSONTabDes.AddPair('Dias_Base_PAR'                        ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Dias_Base_PAR));
         JSONTabDes.AddPair('Periodos_Tasa_Base_Variable'          ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Periodos_Tasa_Base_Variable));
         JSONTabDes.AddPair('Saldo_insoluto_Sin_Capitalizaciones'  ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Saldo_insoluto_Sin_Capitalizaciones));
         JSONTabDes.AddPair('Fecha_Tipo_Cambio'                    ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Tipo_Cambio)));
         JSONTabDes.AddPair('Amortizaciones_Segun_Fecha_de_Compra' ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra));
         JSONTabDes.AddPair('Saldo_Insoluto_Segun_Fecha_de_Compra' ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra));
         JSONTabDes.AddPair('Capitalizado_Segun_Fecha_de_Compra'   ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Capitalizado_Segun_Fecha_de_Compra));
         JSONTabDes.AddPair('Capitalizado_Entre_Compra_y_Calculo'  ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo));
         JSONTabDes.AddPair('Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo'       ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo));
         JSONTabDes.AddPair('Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado' ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado));
         JSONTabDes.AddPair('Fecha_Tasa_Flotante'                  ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Tasa_Flotante)));
         JSONTabDes.AddPair('Curva_Proy_utilizada'                 ,TJSONString.Create(Reg_Val_Out.Array_Mem_Desarr[i].Curva_Proy_utilizada));
         JSONTabDes.AddPair('Dias_Proyeccion'                      ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Dias_Proyeccion));
         JSONTabDes.AddPair('Tasa_Proyeccion'                      ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Tasa_Proyeccion));
         JSONTabDes.AddPair('FD_Proyeccion_fin'                    ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].FD_Proyeccion_fin));
         JSONTabDes.AddPair('FD_Proyeccion_Inicio'                 ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].FD_Proyeccion_Inicio));
         JSONTabDes.AddPair('Valor_Tasa_Descuento'                 ,TJSONNumber.Create(Reg_Val_Out.Array_Mem_Desarr[i].Valor_Tasa_Descuento));
         JSONTabDes.AddPair('Fecha_Liquidacion'                    ,TJSONString.Create(DateToStr(Reg_Val_Out.Array_Mem_Desarr[i].Fecha_Liquidacion)));

         JSONArray.AddElement(JSONTabDes);
      end;

      //RegDes
      JSONRegDes := TJSONObject.Create;
      JSONRegDes.AddPair('CODIGO_EMISOR'          ,TJSONString.Create(Reg_Val_Out.RegDes.CODIGO_EMISOR));
      JSONRegDes.AddPair('CODIGO_INSTRUMENTO'     ,TJSONString.Create(Reg_Val_Out.RegDes.CODIGO_INSTRUMENTO));
      JSONRegDes.AddPair('SERIE'                  ,TJSONString.Create(Reg_Val_Out.RegDes.SERIE));
      JSONRegDes.AddPair('FECHA_VIG'              ,TJSONString.Create(DateToStr(Reg_Val_Out.RegDes.FECHA_VIG)));
      JSONRegDes.AddPair('SERIE_BOLSA'            ,TJSONString.Create(Reg_Val_Out.RegDes.SERIE_BOLSA));
      JSONRegDes.AddPair('FECHA_EMISION'          ,TJSONString.Create(DateToStr(Reg_Val_Out.RegDes.FECHA_EMISION)));
      JSONRegDes.AddPair('TASA_EMISION'           ,TJSONNumber.Create(Reg_Val_Out.RegDes.TASA_EMISION));
      JSONRegDes.AddPair('TASA_EFECTIVA'          ,TJSONNumber.Create(Reg_Val_Out.RegDes.TASA_EFECTIVA));
      JSONRegDes.AddPair('TASA_VALOR_PAR'         ,TJSONString.Create(Reg_Val_Out.RegDes.TASA_VALOR_PAR));
      JSONRegDes.AddPair('TASA_VALOR_PTE'         ,TJSONString.Create(Reg_Val_Out.RegDes.TASA_VALOR_PTE));
      JSONRegDes.AddPair('UNIDAD_MON'             ,TJSONString.Create(Reg_Val_Out.RegDes.UNIDAD_MON));
      JSONRegDes.AddPair('PLAZO_EN_ANOS'          ,TJSONNumber.Create(Reg_Val_Out.RegDes.PLAZO_EN_ANOS));
      JSONRegDes.AddPair('TIPO_AMORTIZAC'         ,TJSONString.Create(Reg_Val_Out.RegDes.TIPO_AMORTIZAC));
      JSONRegDes.AddPair('NRO_CUPONES'            ,TJSONNumber.Create(Reg_Val_Out.RegDes.NRO_CUPONES));
      JSONRegDes.AddPair('PERIODO_PAGO'           ,TJSONNumber.Create(Reg_Val_Out.RegDes.PERIODO_PAGO));
      JSONRegDes.AddPair('TIPO_VENCIMIENTO'       ,TJSONString.Create(Reg_Val_Out.RegDes.TIPO_VENCIMIENTO));
      JSONRegDes.AddPair('DIA_VENCIMIENTO'        ,TJSONNumber.Create(Reg_Val_Out.RegDes.DIA_VENCIMIENTO));
      JSONRegDes.AddPair('DECIMAL_AJUSTE'         ,TJSONNumber.Create(Reg_Val_Out.RegDes.DECIMAL_AJUSTE));
      JSONRegDes.AddPair('TIPO_AJUSTE'            ,TJSONString.Create(Reg_Val_Out.RegDes.TIPO_AJUSTE));
      JSONRegDes.AddPair('BASE_ORIGINAL'          ,TJSONNumber.Create(Reg_Val_Out.RegDes.BASE_ORIGINAL));
      JSONRegDes.AddPair('BASE_CONVERSION'        ,TJSONNumber.Create(Reg_Val_Out.RegDes.BASE_CONVERSION));
      JSONRegDes.AddPair('COD_CALC_PAR_D'         ,TJSONString.Create(Reg_Val_Out.RegDes.COD_CALC_PAR_D));
      JSONRegDes.AddPair('COD_CALC_TIR_D'         ,TJSONString.Create(Reg_Val_Out.RegDes.COD_CALC_TIR_D));
      JSONRegDes.AddPair('OPCION_PREPAGO'         ,TJSONString.Create(Reg_Val_Out.RegDes.OPCION_PREPAGO));
      JSONRegDes.AddPair('FECHA_PREPAGO'          ,TJSONString.Create(DateToStr(Reg_Val_Out.RegDes.FECHA_PREPAGO)));
      JSONRegDes.AddPair('PRECIO_PREPAGO'         ,TJSONNumber.Create(Reg_Val_Out.RegDes.PRECIO_PREPAGO));
      JSONRegDes.AddPair('TASA_FLOTANTE'          ,TJSONString.Create(Reg_Val_Out.RegDes.TASA_FLOTANTE));
      JSONRegDes.AddPair('TIPO_NOMINALES'         ,TJSONString.Create(Reg_Val_Out.RegDes.TIPO_NOMINALES));
      JSONRegDes.AddPair('FECHAS_SINO'            ,TJSONString.Create(Reg_Val_Out.RegDes.FECHAS_SINO));
      JSONRegDes.AddPair('Tipo_pago'              ,TJSONString.Create(Reg_Val_Out.RegDes.Tipo_pago));
      JSONRegDes.AddPair('Periodo_Gracia'         ,TJSONNumber.Create(Reg_Val_Out.RegDes.Periodo_Gracia));
      JSONRegDes.AddPair('Codigo_Emisor_Old'      ,TJSONString.Create(Reg_Val_Out.RegDes.Codigo_Emisor_Old));
      JSONRegDes.AddPair('Codigo_Instrumento_Old' ,TJSONString.Create(Reg_Val_Out.RegDes.Codigo_Instrumento_Old));
      JSONRegDes.AddPair('Serie_Old'              ,TJSONString.Create(Reg_Val_Out.RegDes.Serie_Old));
      JSONRegDes.AddPair('COD_CALC_PAR_D_Old'     ,TJSONString.Create(Reg_Val_Out.RegDes.COD_CALC_PAR_D_Old));
      JSONRegDes.AddPair('COD_CALC_TIR_D_Old'     ,TJSONString.Create(Reg_Val_Out.RegDes.COD_CALC_TIR_D_Old));
      JSONRegDes.AddPair('Fecha_Carga_Array_Mem'  ,TJSONString.Create(DateToStr(Reg_Val_Out.RegDes.Fecha_Carga_Array_Mem)));
      JSONRegDes.AddPair('Variacion_Cambiaria'    ,TJSONBool.Create(Reg_Val_Out.RegDes.Variacion_Cambiaria));
      JSONRegDes.AddPair('fCupones_Cortados'      ,TJSONNumber.Create(Reg_Val_Out.RegDes.fCupones_Cortados));
      JSONRegDes.AddPair('Dias_Base_Variables'    ,TJSONBool.Create(Reg_Val_Out.RegDes.Dias_Base_Variables));
      JSONRegDes.AddPair('bSin_Tasa_en_Flujos'    ,TJSONBool.Create(Reg_Val_Out.RegDes.bSin_Tasa_en_Flujos));

      //Reg_Val_Out
      JSON := TJSONObject.Create;
      JSON.AddPair('Nominales'                 ,TJSONNumber.Create(Reg_Val_Out.Nominales));
      JSON.AddPair('TasaCalculo'               ,TJSONNumber.Create(Reg_Val_Out.TasaCalculo));
      JSON.AddPair('PorcentajePar'             ,TJSONNumber.Create(Reg_Val_Out.PorcentajePar));
      JSON.AddPair('ValorInvertidoUM'          ,TJSONNumber.Create(Reg_Val_Out.ValorInvertidoUM));
      JSON.AddPair('ValorInvertidoMC'          ,TJSONNumber.Create(Reg_Val_Out.ValorInvertidoMC));
      JSON.AddPair('TasaEstimada'              ,TJSONNumber.Create(Reg_Val_Out.TasaEstimada));
      JSON.AddPair('Valor_Par_UM_Sin_Reajuste' ,TJSONNumber.Create(Reg_Val_Out.Valor_Par_UM_Sin_Reajuste));
      JSON.AddPair('Valor_Par_UM'              ,TJSONNumber.Create(Reg_Val_Out.Valor_Par_UM));
      JSON.AddPair('Valor_Par_MC'              ,TJSONNumber.Create(Reg_Val_Out.Valor_Par_MC));
      JSON.AddPair('fValor_Final_UM'           ,TJSONNumber.Create(Reg_Val_Out.fValor_Final_UM));
      JSON.AddPair('Valor_Par_Base'            ,TJSONNumber.Create(Reg_Val_Out.Valor_Par_Base));
      JSON.AddPair('Array_Mem_Desarr'          ,JSONArray);
      JSON.AddPair('Precio_Titulo'             ,TJSONNumber.Create(Reg_Val_Out.Precio_Titulo));
      JSON.AddPair('TIR_Desarr'                ,TJSONNumber.Create(Reg_Val_Out.TIR_Desarr));
      JSON.AddPair('RegDes'                    ,JSONRegDes);
      JSON.AddPair('Tipo_Valuacion'            ,TJSONString.Create(Reg_Val_Out.Tipo_Valuacion));
      JSON.AddPair('Rate_Used_Valuacion'       ,TJSONNumber.Create(Reg_Val_Out.Rate_Used_Valuacion));
      JSON.AddPair('Impuestos_Acc'             ,TJSONNumber.Create(Reg_Val_Out.Impuestos_Acc));
      JSON.AddPair('Precio'                    ,TJSONNumber.Create(Reg_Val_Out.Precio));
      JSON.AddPair('Nemotecnico'               ,TJSONString.Create(Reg_Val_Out.Nemotecnico));
      JSON.AddPair('Result_Inst_Vencido'       ,TJSONBool.Create(Reg_Val_Out.Result_Inst_Vencido));
      JSON.AddPair('Precio_Limpio'             ,TJSONNumber.Create(Reg_Val_Out.Precio_Limpio));
      JSON.AddPair('Precio_Sucio'              ,TJSONNumber.Create(Reg_Val_Out.Precio_Sucio));
      JSON.AddPair('Valor_Par_ya_Calculado'    ,TJSONBool.Create(Reg_Val_Out.Result_Inst_Vencido));
      JSON.AddPair('Tipo_Tasa_Precio'          ,TJSONString.Create(Reg_Val_Out.Tipo_Tasa_Precio));
      JSON.AddPair('Tipo_cambio'               ,TJSONNumber.Create(Reg_Val_Out.Tipo_cambio));
      JSON.AddPair('FX_Points'                 ,TJSONNumber.Create(Reg_Val_Out.FX_Points));
      JSON.AddPair('Tipo_cambio_fwd'           ,TJSONNumber.Create(Reg_Val_Out.Tipo_cambio_fwd));
      JSON.AddPair('Origen'                    ,TJSONString.Create(Reg_Val_Out.Origen));
      JSON.AddPair('Valor_Razonable_Pos_Larga' ,TJSONNumber.Create(Reg_Val_Out.Valor_Razonable_Pos_Larga));
      JSON.AddPair('Valor_Razonable_Pos_Corta' ,TJSONNumber.Create(Reg_Val_Out.Valor_Razonable_Pos_Corta));

      JSONResult.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,'Peticion exitosa');
      JSONResult.AddPair('Reg_Val_Out',JSON);
      Result := JSONResult;
   end
   else
   begin
      sMensaje := 'Terminado con erores: '+sModulo_Error+' - '+sString_Error;
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
   end;

end;

function TServerMethods1.String_a_Date(sFecha :string) :TDateTime;
var aa,mm,dd :Word;
begin
   dd := StrToInt(copy(sFecha,1,2));
   mm := StrToInt(copy(sFecha,3,2));
   aa := StrToInt(copy(sFecha,5,4));
   Result := encodedate(aa,mm,dd);
end;

function TServerMethods1.updateLimites_OMD(Parametros: TJSONObject): TJSONObject;
var Sender               :TObject;

    sEmpresa             :String;
    sCartera             :String;
    dFecha_Operacion     :TDateTime;
    dFecha_de_Pago       :TDateTime;
    sTransaccion         :String;
    sFolio_Interno       :String;
    sMoneda_Operacion    :string;
    sString_Nemo         :String;
    sEstrategia          :String;

    i                    :Integer;
    bSBS                 :Boolean;
    fNodo_Grupo          :Double;
    sCartera_Limite      :String;
    bResult,
    bErrores             :Boolean;
    sProceso,
    sString_RTPR_Trans,
    sString_Limite_Trans :String;
    dfecha_limite        :TDateTime;

    sMensaje             :string;
    sFecha               :string;
    JSON                 :TJSONObject;
    JSONResult           :TJSONObject;
    vJSONP               :TJSONValue;
    JSONArray            :TJSONArray;
    ArrayElement         :TJSONValue;
    ArrayDetalle         :TDetalle;
    JSONExcedidos        :TJSONArray;
    JSONError            :TJSONArray;
begin

//Parametros
//{
//    "Cabecera": {
//        "Empresa": "",
//        "Cartera": "",
//        "Fecha_Operacion": "",
//        "Fecha_de_Pago": "",
//        "Transaccion": "",
//        "Folio_Interno": "",
//        "Moneda_Operacion": "",
//        "Estrategia": ""
//        },
//    "Detalle": [{
//        "Item_OMD": 0,
//        "Nemotecnico": "",
//        "Tipo_Instrum": "",
//        "Emisor": "",
//        "Instrumento": "",
//        "Serie": "",
//        "Moneda_Instrum": "",
//        "Tasa_Emision": 0,
//        "Fecha_Emision": "",
//        "Fecha_Vencimiento": "",
//        "Tipo_Nominales": "",
//        "Valor_Nominal": 0,
//        "Tasa_Base_Par": "",
//        "Tasa_mercado": 0,
//        "Transaccion_rel": "",
//        "Folio_Interno_Rel": "",
//        "Item_Omd_rel": 0,
//        "Valor_Invertido_MC": 0,
//        "Valor_Pte_Cpa_MC": 0
//        }]
//}



   vJSONP := Parametros.GetValue<TJSONValue>('Cabecera');
   sEmpresa         := vJSONP.GetValue<String>('Empresa');
   sCartera         := vJSONP.GetValue<String>('Cartera');
   sFecha           := vJSONP.GetValue<String>('Fecha_Operacion');
   dFecha_Operacion := String_a_Date(sFecha);
   sTransaccion     := vJSONP.GetValue<String>('Transaccion');
   sFolio_Interno   := vJSONP.GetValue<String>('Folio_Interno');
   sFecha           := vJSONP.GetValue<String>('Fecha_de_Pago');
   dFecha_de_Pago   := String_a_Date(sFecha);
   sMoneda_Operacion:= vJSONP.GetValue<String>('Moneda_Operacion');
   sEstrategia      := vJSONP.GetValue<String>('Estrategia');

   i := 0;
   JSONArray := Parametros.GetValue <TJSONArray>('Detalle');
   for ArrayElement in JSONArray do
       inc(i);
   ArrayDetalle.fItem_OMD           := VarArrayCreate([0,i],varDouble);
   ArrayDetalle.sNemotecnico        := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.sTipo_Instrum       := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.sEmisor             := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.sInstrumento        := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.sSerie              := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.sMoneda_Instrum     := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.fTasa_Emision       := VarArrayCreate([0,i],varDouble);
   ArrayDetalle.dFecha_Emision      := VarArrayCreate([0,i],varDate);
   ArrayDetalle.dFecha_Vencimiento  := VarArrayCreate([0,i],varDate);
   ArrayDetalle.sTipo_Nominales     := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.fValor_Nominal      := VarArrayCreate([0,i],varDouble);
   ArrayDetalle.sTasa_Base_Par      := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.fTasa_mercado       := VarArrayCreate([0,i],varDouble);
   ArrayDetalle.sTransaccion_rel    := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.sFolio_Interno_Rel  := VarArrayCreate([0,i],varOleStr);
   ArrayDetalle.fItem_Omd_rel       := VarArrayCreate([0,i],varDouble);
   ArrayDetalle.fValor_Invertido_MC := VarArrayCreate([0,i],varDouble);
   ArrayDetalle.fValor_Pte_Cpa_MC   := VarArrayCreate([0,i],varDouble);
   i := 0;
   for ArrayElement in JSONArray do
   begin
      ArrayDetalle.fItem_OMD[i]           := ArrayElement.Getvalue<Double>('Item_OMD');
      ArrayDetalle.sNemotecnico[i]        := ArrayElement.Getvalue<string>('Nemotecnico');
      ArrayDetalle.sTipo_Instrum[i]       := ArrayElement.Getvalue<string>('Tipo_Instrum');
      ArrayDetalle.sEmisor[i]             := ArrayElement.Getvalue<string>('Emisor');
      ArrayDetalle.sInstrumento[i]        := ArrayElement.Getvalue<string>('Instrumento');
      ArrayDetalle.sSerie[i]              := ArrayElement.Getvalue<string>('Serie');
      ArrayDetalle.sMoneda_Instrum[i]     := ArrayElement.Getvalue<string>('Moneda_Instrum');
      ArrayDetalle.fTasa_Emision[i]       := ArrayElement.Getvalue<string>('Tasa_Emision');
      sFecha                              := ArrayElement.Getvalue<string>('Fecha_Emision');
      ArrayDetalle.dFecha_Emision[i]      := String_a_Date(sFecha);
      sFecha                              := ArrayElement.Getvalue<string>('Fecha_Vencimiento');
      ArrayDetalle.dFecha_Vencimiento[i]  := String_a_Date(sFecha);
      ArrayDetalle.sTipo_Nominales[i]     := ArrayElement.Getvalue<string>('Tipo_Nominales');
      ArrayDetalle.fValor_Nominal[i]      := ArrayElement.Getvalue<Double>('Valor_Nominal');
      ArrayDetalle.sTasa_Base_Par[i]      := ArrayElement.Getvalue<string>('Tasa_Base_Par');
      ArrayDetalle.fTasa_mercado[i]       := ArrayElement.Getvalue<Double>('Tasa_mercado');
      ArrayDetalle.sTransaccion_rel[i]    := ArrayElement.Getvalue<string>('Transaccion_rel');
      ArrayDetalle.sFolio_Interno_Rel[i]  := ArrayElement.Getvalue<string>('Folio_Interno_Rel');
      ArrayDetalle.fItem_Omd_rel[i]       := ArrayElement.Getvalue<Double>('Item_Omd_rel');
      ArrayDetalle.fValor_Invertido_MC[i] := ArrayElement.Getvalue<Double>('Valor_Invertido_MC');
      ArrayDetalle.fValor_Pte_Cpa_MC[i]   := ArrayElement.Getvalue<Double>('Valor_Pte_Cpa_MC');
      inc(i);
   end;


   JSONResult    := TJSONObject.Create;

   if not Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      exit;
   end;

   bSBS := Transaccion_Implica( 'LIMITES', 'SBS');

   Determina_Nodo_Clasificacion('CARTERA'
                               ,sCartera
                               ,'GRUPO'
                               ,fNodo_Grupo);
   Busca_Descripcion_Clasificacion('GRUPO'
                                  ,fNodo_Grupo
                                  ,sCartera_Limite);

   if not Llena_Tabla_Limites(sEmpresa
                             ,sCartera
                             ,sTransaccion
                             ,sFolio_Interno
                             ,dFecha_Operacion
                             ,dFecha_de_Pago
                             ,sMoneda_Operacion
                             ,sEstrategia
                             ,bSBS
                             ,ArrayDetalle) then
   begin
      sMensaje := Pchar('Se Detecto Problema al cargar OMD a Limites (1)');
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      exit;
   end;

   sString_RTPR_Trans   := '';
   sString_Limite_Trans := '';

   Tiene_Limite(dFecha_Operacion
               ,sString_RTPR_Trans
               ,sString_Limite_Trans);

   if Trim(sString_RTPR_Trans) = '' then
   begin
     if not Agrega_OMD_Excedida(sTransaccion,
                                sFolio_Interno,
                                sEmpresa,
                                sCartera_Limite,
                                dFecha_Operacion,
                                false) then
     begin
       sMensaje := Pchar('Se Detecto Problema al cargar OMD a Limites (2)');
       JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
       JSONResult.AddPair('Mensaje' ,sMensaje);
       Result := JSONResult;
       exit;
     end;
     sMensaje := Pchar('Operación NO tiene Limite Asociado');
     JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
     JSONResult.AddPair('Mensaje' ,sMensaje);
     Result := JSONResult;
     exit;
   end;

   bErrores := False;
   bexiste_limite_final := True;
   FrmCalculoLimites := TFrmCalculoLimites.Create(Application);
   with FrmCalculoLimites do
   begin
      bSBS := Transaccion_Implica( 'LIMITES', 'SBS');

      Existe_param_proceso('NOGRUPO'
                          ,sEmpresa
                          ,sProceso
                          ,bResult);
      if bResult then
         sCartera_Limite := 'CONSOLIDA';

      Busca_param_proceso('LIMTRA'
                          ,sEmpresa
                          ,sProceso
                          ,bResult);

      sTipo_Limite   := 'T';
      sString_RTPR   := sString_RTPR_Trans;
      sString_Limite := sString_Limite_Trans;

      JSONError := TJSONArray.Create;

      with Qry_General2 do
      begin
         Close;
         SQL.Clear;
         SQL.Add('select distinct a.Proceso '
                +'  from qs_sup_251_lim a ');
         if Trim(sProceso) <> '' then
         begin
            Sql.Add(' where a.proceso in (SELECT VALOR FROM QS_SYS_PARAM_PROCESO WHERE PROCESO = ''LIMTRA'' AND PARAMETRO = :Empresa )');
            ParamByName('Empresa').AsString := sEmpresa;
         end;

         Open;
         while not eof do
         begin

            Ed_Proceso.text      := FieldByName('Proceso').asString ;
            Combo_Cartera.text   := sCartera_Limite;
            Chk_Carteras.checked := true;
            Ed_Fecha.date        := dFecha_Operacion;
            sProceso             := Ed_Proceso.text;
            dFecha_Cierre        := dFecha_Operacion;
            dFecha_Ope           := dFecha_Operacion;

            if sCartera_Limite = 'CONSOLIDA' then
            begin
              sGrupo_Cartera  := '';
              Llena_Carteras_Lim(sProceso);
              BTN_CalculoClick(Sender);
              Actualiza_Limite_Trans(Sender);
            end
            else
            begin
              sGrupo_Cartera  := 'GRUPO';
              Llena_Seleccion_Carteras('GRUPO',Combo_Cartera.Text);
              BTN_CalculoClick(Sender);
              BTN_ConfirmarClick(Sender);
            end;

            if sCartera_Limite <> 'CONSOLIDA' then
            begin
               if FrmReportErrores.T_Paradox.RecordCount > 0 then
               begin
                  //genera archivo json errores calculo limites
                  FrmReportErrores.T_Paradox.First;
                  while not FrmReportErrores.T_Paradox.eof do
                  begin
                     JSON := TJSONObject.Create;

                     JSON.AddPair('Modulo',TJSONString.Create(FrmReportErrores.T_ParadoxModulo.asstring));
                     JSON.AddPair('Error' ,TJSONString.Create(FrmReportErrores.T_ParadoxError.asstring));

                     JSONError.AddElement(JSON);

                     FrmReportErrores.T_Paradox.Next;
                  end;
                  bErrores := True;
               end;
            end;
            Next;
         end;
         Close;
      end;
      //Close;
      Free;
   end;

   if bErrores then
   begin
      {
      if Application.Messagebox('¡Se encontraron errores en el calculo de Limites!, Desea Continuar?','Advertencia', mb_OKCancel+MB_ICONError) = 2 then
      begin
         Result := False;
         Exit;
      end;
      }
      sMensaje := Pchar('Se encontraron errores en el calculo de Limites');
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      JSONResult.AddPair('Errores' ,JSONError);
      Result := JSONResult;
      exit;
   end;

   if Not bexiste_limite_final then
   begin
     if not Agrega_OMD_Excedida(sTransaccion,
                                sFolio_Interno,
                                sEmpresa,
                                sCartera_Limite,
                                dFecha_Operacion,
                                False) then
     begin
       sMensaje := Pchar('Se Detecto Problema al cargar OMD a Limites (9)');
       JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
       JSONResult.AddPair('Mensaje' ,sMensaje);
       Result := JSONResult;
       exit;
     end;
     sMensaje := Pchar('Operación NO tiene Limite Asociado');
     JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
     JSONResult.AddPair('Mensaje' ,sMensaje);
     Result := JSONResult;
     exit;
   end;

   Busca_param_proceso('LIMTRA'
                      ,sEmpresa
                      ,sProceso
                      ,bResult);
   Obtiene_MaxFec_Limite(sProceso,
                         sCartera_Limite,
                         dFecha_Operacion,   //Fecha_Hora_Servidor,
                         dfecha_limite,
                         bResult);
   if Not bResult then
      dfecha_limite := dFecha_Operacion;

   if Exedio_Limites(sEmpresa
                    ,sCartera_Limite
                    ,dfecha_limite
                    ,sTransaccion
                    ,sFolio_Interno) then
   begin
      JSONExcedidos := TJSONArray.Create;
      with Qry_General do
      begin
         Close;
         if (NOT Transaccion_implica(sTransaccion,'RV')) then
         begin
           Sql.Clear;
           Sql.Add('select a.proceso '
                  +'      ,a.codigo_limite '
                  +'      ,b.descripcion '
                  +'      ,c.nemotecnico '
                  +'      ,sum(a.valor_pte_cartera - a.maximo_permitido) as monto_excedido '
                  +'  from qs_tra_251     a '
                  +'      ,qs_sup_251_lim b '
                  +'      ,qs_tra_251_det c '
                  +' where a.empresa           = :empresa '
                  +'   and a.cartera           = :cartera '
                  +'   and a.fecha_proceso     = :fecha_proceso '
                  +'   and a.valor_pte_cartera > a.Maximo_Permitido '
                  +'   and b.codigo_limite     = a.codigo_limite '
                  +'   and b.fecha_desde      <= a.fecha_proceso '
                  +'   and (b.fecha_hasta     >= a.fecha_proceso or b.fecha_hasta is null) '
                  +'   and c.empresa           = a.empresa '
                  +'   and c.fecha_proceso     = a.fecha_proceso '
                  +'   and c.proceso           = a.proceso '
                  +'   and c.codigo_limite     = a.codigo_limite ');
           Sql.Add('   and c.transaccion       = :transaccion '
                  +'   and c.folio_interno     = :folio_interno ');
           Sql.Add(' group by a.proceso '
                  +'         ,a.codigo_limite '
                  +'         ,b.descripcion '
                  +'         ,c.nemotecnico '
                  +' order by a.proceso '
                  +'         ,b.descripcion ');
           ParamByName('transaccion').asString     := stransaccion;
           ParamByName('folio_interno').asString   := sFolio_Interno;
         end
         else
         begin
           with Qry_General2 do
           begin
             Close;
             SQL.Clear;
             SQL.Add('select distinct a.Nemotecnico '
                    +'  from qs_tmp_omd_limite a '
                    +' WHERE a.pid = :PID ');
             ParamByName('PID').AsFloat := Application.handle;
             open;
             sString_Nemo := '(''''';
             while not eof do
             begin
               sString_Nemo := sString_Nemo+','''+FieldByName('Nemotecnico').AsString+'''';
               next;
             end;
             sString_Nemo := sString_Nemo+')';
             Close;
           end;
           Sql.Clear;
           Sql.Add('select a.proceso '
                  +'      ,a.codigo_limite '
                  +'      ,b.descripcion '
                  +'      ,c.nemotecnico '
                  +'      ,sum(c.VALOR_PTE_MC_CPA) - a.maximo_permitido as monto_excedido '
                  +'  from qs_tra_251     a '
                  +'      ,qs_sup_251_lim b '
                  +'      ,qs_tra_251_det c '
                  +' where a.empresa           = :empresa '
                  +'   and a.cartera           = :cartera '
                  +'   and a.fecha_proceso     = :fecha_proceso '
                  +'   and a.valor_pte_cartera > a.Maximo_Permitido '
                  +'   and b.codigo_limite     = a.codigo_limite '
                  +'   and b.fecha_desde      <= a.fecha_proceso '
                  +'   and (b.fecha_hasta     >= a.fecha_proceso or b.fecha_hasta is null) '
                  +'   and c.empresa           = a.empresa '
                  +'   and c.fecha_proceso     = a.fecha_proceso '
                  +'   and c.proceso           = a.proceso '
                  +'   and c.codigo_limite     = a.codigo_limite ');
           Sql.Add('   and c.nemotecnico      in '+sString_Nemo);
           Sql.Add(' group by a.proceso '
                  +'         ,b.descripcion '
                  +'         ,c.nemotecnico '
                  +'         ,a.maximo_permitido '
                  +' order by a.proceso '
                  +'         ,b.descripcion ');
         end;
         ParamByName('empresa').asString         := sEmpresa;
         ParamByName('cartera').asString         := sCartera_Limite;
         ParamByName('fecha_proceso').asDateTime := dFecha_Operacion;
         Open;
         while not eof do
         begin
            JSON := TJSONObject.Create;

            //genera archivo json limites excedidos
            JSON.AddPair('proceso'        ,TJSONString.Create(Qry_General.FieldByName('proceso').asstring));
            JSON.AddPair('codigo_limite'  ,TJSONString.Create(Qry_General.FieldByName('codigo_limite').asstring));
            JSON.AddPair('descripcion'    ,TJSONString.Create(Qry_General.FieldByName('descripcion').asstring));
            JSON.AddPair('nemotecnico'    ,TJSONString.Create(Qry_General.FieldByName('nemotecnico').asstring));
            JSON.AddPair('monto_excedido' ,TJSONNumber.Create(Qry_General.FieldByName('monto_excedido').asfloat));

            JSONExcedidos.AddElement(JSON);

            Next;
         end;
         Close;
      end;

      sMensaje := Pchar('Operación excedio limites definidos');
      JSONResult.AddPair('Estado'  ,'2');  //0:Ejecutado 1:Error 2:Limites Excedidos
      JSONResult.AddPair('Mensaje' ,sMensaje);
      JSONResult.AddPair('LimitesExcedidos' ,JSONExcedidos);
      Result := JSONResult;
      exit;

      if not agrega_omd_excedida(sTransaccion,
                                 sFolio_Interno,
                                 sEmpresa,
                                 sCartera_Limite,
                                 dfecha_limite,
                                 true) then
      begin
         sMensaje := Pchar('Se Detecto Problema al cargar OMD a Limites (3)');
         JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
         JSONResult.AddPair('Mensaje' ,sMensaje);
         Result := JSONResult;
         exit;
      end;
   end;

   sMensaje := Pchar('Peticion exitosa, operación no excedio limites');
   JSONResult.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
   JSONResult.AddPair('Mensaje' ,sMensaje);
   Result := JSONResult;

end;

Function TServerMethods1.Llena_Tabla_Limites(sEmpresa         : String;
                                             sCartera         : String;
                                             sTransaccion     : String;
                                             sFolio_Interno   : String;
                                             dFecha_Operacion : TDateTime;
                                             dFecha_de_Pago   : TDateTime;
                                             sMoneda_Operacion: String;
                                             sEstrategia      : String;
                                             bSBS             : Boolean;
                                             ArrayDetalle     : TDetalle) :Boolean;
var
    sClasif_Riesgo       : String;
    fFactor_Riesgo       : Double;
    sEmisor_Pagador      : String;
    sTipo_Clasif         : String;
    sMoneda_Conversion   : String;
    RegDes               : TReg_Descriptor;
    Array_Mem_Desarr     : TArray_Mem_Desarr;
    Reg_Formula_PAR      : TRegFormulaPAR;
    Reg_Formula_TIR      : TRegFormulaTIR;
    Reg_Val_In           : TRegistro_Valoriza_In;
    Reg_Val_Out          : TRegistro_Valoriza_Out;
    Registro_Fechas      : TRegistro_Fechas;
    dFecha_Hasta         : TDateTime;
    dFecha_Vencimiento   : TDateTime;
    fValor_Mercado_MC    : Double;
    Modulo_Error         : String;
    String_Error         : String;
    bResult              : Boolean;
    sClasificadora_Default       : String;
    sMetodo_Sin_Tasa_Referencia  : String;
    i : Integer;
begin
   Result := True;

   with Qry_General2 do
   begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM qs_tmp_omd_limite'
             +' WHERE (PID = :PID '
             +'    OR fecha_hora <= :Fecha_Proceso) ');
      ParamByName('PID').AsFloat := Application.handle;
      ParamByName('Fecha_Proceso').AsDate := (solo_fecha(fecha_hora_Servidor) - 2);
      try
         ExecSQL
      except on E: EFDDBEngineException do
        begin
           ShowError(E);
           Result := False;
        end;
      end;
   end;

   with Qry_General2 do
   begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO qs_tmp_omd_limite '
             +'(PID '
             +',Empresa '
             +',Cartera '
             +',Transaccion '
             +',Folio_interno '
             +',Item_OMD '
             +',Emisor '
             +',Instrumento '
             +',Serie '
             +',Nemotecnico '
             +',Moneda_Instrum '
             +',Tipo_Instrum '
             +',Valor_Nominal '
             +',Saldo_Insoluto '
             +',Valor_Final_SVS_MC '
             +',Valor_Pte_Mc_Cpa '
             +',Valor_Pte_Mc_Mdo '
             +',Valor_Pte_Mc_Mixta '
             +',Clasif_Riesgo '
             +',Presencia_Bursatil '
             +',Pais  '
             +',Estrategia  '
             +',Fecha_Hora  '
             +',fecha_Operacion  '
             +',fecha_emision  '
             +',fecha_vcto  )'
             +' VALUES '
             +'(:PID '
             +',:Empresa '
             +',:Cartera '
             +',:Transaccion '
             +',:Folio_interno '
             +',:Item_OMD '
             +',:Emisor '
             +',:Instrumento '
             +',:Serie '
             +',:Nemotecnico '
             +',:Moneda_Instrum '
             +',:Tipo_Instrum '
             +',:Valor_Nominal '
             +',:Saldo_Insoluto '
             +',:Valor_Final_SVS_MC '
             +',:Valor_Pte_Mc_Cpa '
             +',:Valor_Pte_Mc_Mdo '
             +',:Valor_Pte_Mc_Mixta '
             +',:Clasif_Riesgo '
             +',:Presencia_Bursatil '
             +',:Pais '
             +',:Estrategia  '
             +',:Fecha_Hora '
             +',:fecha_Operacion  '
             +',:fecha_emision  '
             +',:fecha_vcto  )');
   end;

   for i := 0 to  VarArrayHighBound(ArrayDetalle.sNemotecnico, 1 )-1 do
   begin
      fValor_Mercado_MC := 0;
      if Not bSBS then
      begin
        Leer_Cartera_Mem(sEmpresa,
                         sCartera,
                         Modulo_Error,
                         String_Error,
                         sMoneda_Conversion,
                         bResult);

        // INICIO VALORIZACION
        Carga_RegDes(ArrayDetalle.sTipo_Instrum[i]
                    ,ArrayDetalle.sNemotecnico[i]
                    ,ArrayDetalle.sEmisor[i]
                    ,ArrayDetalle.sInstrumento[i]
                    ,ArrayDetalle.sSerie[i]
                    ,ArrayDetalle.sMoneda_Instrum[i]
                    ,ArrayDetalle.fTasa_Emision[i]
                    ,RegDes
                    ,Modulo_Error
                    ,String_Error
                    ,bResult);
        if not bResult then
        begin
           Result := False;
           Continue;
        end;

        if NOT Es_Nemotecnico_Br(ArrayDetalle.sNemotecnico[i]) then
        begin
           carga_parametros_formulas_mem(RegDes.Cod_Calc_PAR_D
                                        ,RegDes.Cod_Calc_TIR_D
                                        ,Reg_Formula_PAR
                                        ,Reg_Formula_TIR
                                        ,Modulo_Error
                                        ,String_Error
                                        ,bResult);
           if not bResult then
           begin
              Result := False;
              Continue;
           end;

           Reg_Val_In.dFechaCalculo          := dFecha_Operacion;
           Reg_Val_In.dFechaCalculoOriginal  := Reg_Val_In.dFechaCalculo;
           Registro_Fechas.Fecha_Calculo     := dFecha_Operacion;
           Registro_Fechas.Fecha_Compra      := dFecha_Operacion;
           Registro_Fechas.Fecha_Emision     := ArrayDetalle.dFecha_Emision[i];
           Registro_Fechas.Fecha_Vencimiento := ArrayDetalle.dFecha_Vencimiento[i];
           Registro_Fechas.Fecha_Pago        := dFecha_de_Pago;
           Cambio_fecha_Devengamiento(Reg_Val_In
                                     ,Reg_Formula_PAR
                                     ,Reg_Formula_TIR
                                     ,Registro_Fechas
                                     ,Modulo_Error
                                     ,String_Error
                                     ,bResult);
           if bResult then
              dFecha_Hasta := Registro_Fechas.Fecha_Calculo
           else
              dFecha_Hasta := dFecha_Operacion;
        end
        else
        begin
           Reg_Val_In.dFechaCalculo          := dFecha_Operacion;
           Reg_Val_In.dFechaCalculoOriginal  := Reg_Val_In.dFechaCalculo;
           Registro_Fechas.Fecha_Calculo     := dFecha_Operacion;
           Registro_Fechas.Fecha_Compra      := dFecha_Operacion;
           Registro_Fechas.Fecha_Emision     := ArrayDetalle.dFecha_Emision[i];
           Registro_Fechas.Fecha_Vencimiento := ArrayDetalle.dFecha_Vencimiento[i];
           Registro_Fechas.Fecha_Pago        := dFecha_de_Pago;

           dFecha_Hasta                      := dFecha_Operacion;
        end;
        dFecha_Vencimiento := ArrayDetalle.dFecha_Vencimiento[i];

        Carga_TabDesarr(ArrayDetalle.sTipo_Instrum[i]
                       ,ArrayDetalle.sEmisor[i]
                       ,ArrayDetalle.sInstrumento[i]
                       ,ArrayDetalle.sSerie[i]
                       ,ArrayDetalle.sNemotecnico[i]
                       ,ArrayDetalle.sTipo_Nominales[i]
                       ,ArrayDetalle.fValor_Nominal[i]
                       ,ArrayDetalle.fTasa_Emision[i]
                       ,ArrayDetalle.dFecha_Emision[i]
                       ,dFecha_Vencimiento
                       ,dFecha_Hasta        //fecha Calculo
                       ,ArrayDetalle.sTasa_Base_Par[i]
                       ,False           // Sin cupon
                       ,Array_Mem_Desarr
                       ,RegDes
                       ,Registro_Fechas
                       ,sMetodo_Sin_Tasa_Referencia
                       ,Reg_Formula_PAR
                       ,Modulo_Error
                       ,String_Error
                       ,bResult);
        if not bResult then
        begin
           Result := False;
           Continue;
        end;

        Reg_Val_In.Descriptor_Cargado   := 'NO';
        Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
        Reg_Val_In.Tipo_Instrumento   := ArrayDetalle.sTipo_Instrum[i];
        Reg_Val_In.sEmisor            := ArrayDetalle.sEmisor[i];
        Reg_Val_In.sInstrumento       := ArrayDetalle.sInstrumento[i];
        Reg_Val_In.sSerie             := ArrayDetalle.sSerie[i];
        Reg_Val_In.Nemotecnico        := ArrayDetalle.sNemotecnico[i];
        Reg_Val_In.dTasaEmision       := ArrayDetalle.fTasa_Emision[i];
        Reg_Val_In.sUnidadMonetaria   := ArrayDetalle.sMoneda_Instrum[i];
        Reg_Val_In.sTipoNominales     := ArrayDetalle.sTipo_Nominales[i];
        Reg_Val_In.dFechaEmision      := ArrayDetalle.dFecha_Emision[i];
        Reg_Val_In.dFechaVencimiento  := ArrayDetalle.dFecha_Vencimiento[i];
        Reg_Val_In.dFechaCalculo      := dFecha_Operacion;
        Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
        Reg_Val_In.Pais_Titulo        := sCodigo_Div_Geo_Usuario;
        Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
        Reg_Val_In.Con_Cupon          := false;      //sin cupon

        Reg_Val_In.Proceso_Valuacion  := 'MERCADO';
        Reg_Val_In.Valoriza_Par_Pte   := 'VAL';

        Reg_Val_Out.Nominales         := ArrayDetalle.fValor_Nominal[i];
        Reg_Val_Out.TasaCalculo       := ArrayDetalle.fTasa_mercado[i];

        Reg_Val_In.Emision_Implicita    := 'N';
        Reg_val_out.Rate_Used_Valuacion := 0;
        Reg_Val_Out.PorcentajePar     := 0;
        Reg_Val_Out.Valor_Par_UM      := 0;
        Reg_Val_Out.Valor_Par_MC      := 0;
        Reg_Val_Out.fValor_Final_UM   := 0;
        Reg_Val_Out.Valor_Par_Base    := 0;
        Reg_Val_Out.Precio_Sucio      := 0;
        Reg_Val_Out.Precio_Limpio     := 0;
        Reg_Val_Out.ValorInvertidoUM  := 0;
        Reg_Val_Out.ValorInvertidoMC  := 0;

        Reg_Val_In.Re_llamado         := 'NO';
        Reg_Val_In.dFechaCompra       := dFecha_Operacion;
        Reg_Val_In.dFechaOperacion    := dFecha_Operacion;
        Reg_Val_In.dFechaPago         := dFecha_de_Pago;

        sValorizacion_Interactiva     := 'SI';

        Valoriza_Registro(Reg_Val_In,
                          Reg_Val_Out,
                          Modulo_Error,
                          String_Error,
                          bResult);
        if (String_Error = '') or (String_Error = ' ') then
           String_Error := 'No pudo Valorizar, metodo valuacion no definido';
        if NOT bResult then
        begin
           //Application.MessageBox(pchar(Modulo_Error+' - '+String_Error)
           Result := False;
           Continue;
        end;
        fValor_Mercado_MC := Reg_Val_Out.ValorInvertidoMC;
        sValorizacion_Interactiva  := 'NO';
        // FIN VALORIZACION
      end;

      sClasificadora_Default := Default_TipEmp(sEmpresa,
                                               fItem_Dir_Usuario,
                                              'AGENCIACLA');

      {
      fValor_Cambio := 1;
      if sMoneda_Cartera <> sMoneda_Operacion then
      begin
         Leer_Valor_Cambio2(sMoneda_Operacion
                           ,sMoneda_Cartera
                           ,'BC'
                           ,dFecha_Operacion
                           ,fValor_Cambio
                           ,bResult);
         if Not bResult then
         begin
            Result := False;
            Continue;
         end;
      end;
      }

      Busca_Clasif_Riesgo_Origen_Tipo_Mem(ArrayDetalle.sEmisor[i],
                                          ArrayDetalle.sInstrumento[i],
                                          ArrayDetalle.sSerie[i],
                                          ArrayDetalle.sNemotecnico[i],
                                          dFecha_Operacion,
                                          sClasificadora_Default,
                                          sTipo_Clasif,
                                          False,
                                          sClasif_Riesgo,
                                          fFactor_Riesgo,
                                          sEmisor_Pagador);
      with Qry_General2 do
      begin
         ParamByName('PID').AsFloat                := Application.handle;
         ParamByName('Empresa').asString           := sEmpresa;
         ParamByName('Cartera').asString           := sCartera;

         if (Transaccion_implica_Mem(sTransaccion,'COMPRA')) then
         begin
           ParamByName('Transaccion').asString     := sTransaccion;
           ParamByName('Folio_interno').asString   := sFolio_Interno;
           ParamByName('Item_OMD').asFloat         := ArrayDetalle.fItem_Omd[i];
         end
         else
         begin
           ParamByName('Transaccion').asString     := ArrayDetalle.sTransaccion_rel[i];
           ParamByName('Folio_interno').asString   := ArrayDetalle.sFolio_Interno_Rel[i];
           ParamByName('Item_OMD').asFloat         := ArrayDetalle.fItem_Omd_rel[i];
         end;

         ParamByName('Emisor').asString            := ArrayDetalle.sEmisor[i];
         ParamByName('Instrumento').asString       := ArrayDetalle.sInstrumento[i];
         ParamByName('Serie').asString             := ArrayDetalle.sSerie[i];
         ParamByName('Nemotecnico').asString       := ArrayDetalle.sNemotecnico[i];
         ParamByName('Moneda_Instrum').asString    := ArrayDetalle.sMoneda_Instrum[i];
         ParamByName('Tipo_Instrum').asString      := ArrayDetalle.sTipo_Instrum[i];
         ParamByName('Valor_Nominal').asFloat      := ArrayDetalle.fValor_Nominal[i];
         ParamByName('Saldo_Insoluto').asFloat     := 100;
         ParamByName('Valor_Final_SVS_MC').asFloat := ArrayDetalle.fValor_Invertido_MC[i];
         ParamByName('Valor_Pte_Mc_Cpa').asFloat   := ArrayDetalle.fValor_Invertido_MC[i];

         if bSBS then
         begin
           ParamByName('Valor_Pte_Mc_Mdo').asFloat   := ArrayDetalle.fValor_Pte_Cpa_MC[i];
           ParamByName('Valor_Pte_Mc_Mixta').asFloat := ArrayDetalle.fValor_Pte_Cpa_MC[i];
         end
         else
         begin
           ParamByName('Valor_Pte_Mc_Mdo').asFloat   := fValor_Mercado_MC;
           ParamByName('Valor_Pte_Mc_Mixta').asFloat := fValor_Mercado_MC;
         end;

         ParamByName('Clasif_Riesgo').asString     := sClasif_Riesgo;
         ParamByName('Presencia_Bursatil').asFloat := 0;
         ParamByName('Pais').asString              := '';
         ParamByName('Estrategia').asString        := sEstrategia;
         ParamByName('Fecha_hora').AsDateTime      := fecha_hora_servidor;

         ParamByName('fecha_emision').AsDateTime   := ArrayDetalle.dFecha_Emision[i];
         ParamByName('Fecha_operacion').AsDateTime := dFecha_Operacion;
         ParamByName('fecha_vcto').AsDateTime      := ArrayDetalle.dFecha_Vencimiento[i];

         try
            ExecSQL
         except on E: EFDDBEngineException do
           begin
              Result := False;
           end;
         end;
      end;
   end;

end;

function TServerMethods1.updateTratamiento_Fechas(Parametros: TJSONObject): TJSONObject;  //POST
var sCodigo_Tratam   : String;
    Registro_Fechas  : TRegistro_Fechas;
    Fecha_Result     : TDateTime;
    sModulo_Error    : String;
    sString_Error    : String;
    bResult          : Boolean;
    sMensaje         : string;
    sFecha           : string;

    vJSONP     : TJSONValue;
    JSONResult : TJSONObject;
begin
//{
//    "sCodigo_Tratam": "",
//    "Registro_Fechas":
//        {
//        "Fecha_Tasa": "",
//        "Fecha_Calculo": "",
//        "Fecha_Emision": "",
//        "Fecha_Compra": "",
//        "Fecha_Inic_Periodo": "",
//        "Fecha_Vcto_Periodo": "",
//        "Fecha_Desde": "",
//        "Fecha_Hasta": "",
//        "Fecha_Parametro": "",
//        "Fecha_Vencimiento": "",
//        "Fecha_Pago": "",
//        "Fecha_Calculo_Original": ""
//        }
//}

   sCodigo_Tratam := Parametros.GetValue<String>('sCodigo_Tratam');

   vJSONP := Parametros.GetValue <TJSONValue>('Registro_Fechas');
   sFecha := vJSONP.Getvalue<string>('Fecha_Tasa');
   if sFecha <>'' then Registro_Fechas.Fecha_Tasa             := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Calculo');
   if sFecha <>'' then Registro_Fechas.Fecha_Calculo          := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Emision');
   if sFecha <>'' then Registro_Fechas.Fecha_Emision          := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Compra');
   if sFecha <>'' then Registro_Fechas.Fecha_Compra           := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Inic_Periodo');
   if sFecha <>'' then Registro_Fechas.Fecha_Inic_Periodo     := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Vcto_Periodo');
   if sFecha <>'' then Registro_Fechas.Fecha_Vcto_Periodo     := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Desde');
   if sFecha <>'' then Registro_Fechas.Fecha_Desde            := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Hasta');
   if sFecha <>'' then Registro_Fechas.Fecha_Hasta            := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Parametro');
   if sFecha <>'' then Registro_Fechas.Fecha_Parametro        := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Vencimiento');
   if sFecha <>'' then Registro_Fechas.Fecha_Vencimiento      := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Pago');
   if sFecha <>'' then Registro_Fechas.Fecha_Pago             := String_a_Date(sFecha);
   sFecha := vJSONP.Getvalue<string>('Fecha_Calculo_Original');
   if sFecha <>'' then Registro_Fechas.Fecha_Calculo_Original := String_a_Date(sFecha);

   JSONResult    := TJSONObject.Create;

   if not Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
      Result := JSONResult;
      exit;
   end;

   Carga_Tratamiento_Fechas_Mem;
   Tratamiento_Fecha(sCodigo_Tratam
                    ,Registro_Fechas
                    ,Fecha_Result
                    ,sModulo_Error
                    ,sString_Error
                    ,bResult);
   if bResult then
   begin
      JSONResult.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,'Peticion exitosa');
      JSONResult.AddPair('Fecha_Result',datetostr(Fecha_Result));
   end
   else
   begin
      sMensaje := 'Terminado con erores: '+sModulo_Error+' - '+sString_Error;
      JSONResult.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSONResult.AddPair('Mensaje' ,sMensaje);
   end;

   Result := JSONResult;

end;

end.

