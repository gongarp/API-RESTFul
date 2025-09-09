unit MetodosServidor2;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, vcl.Forms, system.IniFiles, System.Variants,
  System.Threading, Nb, System.Generics.Collections, System.Math, System.Types;

type
{$METHODINFO ON}
  TServerMethods2 = class(TDataModule)
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    Qry_General: TFDQuery;
    Qry_Estado: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }

    //Metodos para Ayudas
    function ObtenerEmpresas(sIdentidad :string): TJSONObject;
    function ObtenerIdentidades(sTipo :string; sIdentidad :string): TJSONObject;
    function ObtenerCodigosGenerales(sCodigo :string): TJSONObject;
    function ObtenerPerfil : TJSONObject;
    function ObtenerEstructuraFuncional(sIdentidad :string): TJSONObject;
    function ObtenerEstructuraFisica(sIdentidad :string): TJSONObject;
    function ObtenerEstadoProceso(fPID :double): TJSONObject;

    //Metodos Mantenedor Login
    function LoginUsuario(sLogin_Sistema :string) :TJSONValue;                              //GET
    function acceptLoginUsuario(jCampos: TJSONObject) :TJSONObject;                         //PUT
    function updateLoginUsuario(sLogin_Sistema :string; jCampos: TJSONObject) :TJSONObject; //POST
    function cancelLoginUsuario(sLogin_Sistema :string) :TJSONObject;                       //DELETE

  end;
{$METHODINFO OFF}

var
  ServerMethods2: TServerMethods2;
  Inactividad       :Integer;
  ytiempo           :Double;
  Inactividad_fecha :Integer;
  tiempo_fecha      :Integer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses System.StrUtils,
     Data.FireDACJSONReflect,
     DM_Variables_Menu,
     DM_Global_Var,
     DM_Base_Datos,
     DM_Comun,
     DM_ComunInversiones,
     Registro_Log,
     MetodosServidor;


function TServerMethods2.LoginUsuario(sLogin_Sistema :string) :TJSONValue;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :String;
begin
   if not ServerMethods1.Conexion_Basedatos then
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
   Qry_General.SQL.Add('  from QS_SYS_LOGIN ');
   if sLogin_Sistema <> '' then
   begin
      Qry_General.SQL.Add(' where Login_Sistema = :Login_Sistema');
      Qry_General.ParamByName('Login_Sistema').AsString := sLogin_Sistema;
   end;
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

         JSON.AddPair('EMPRESA_LOGIN'    ,TJSONString.Create(Qry_General.FieldByName('EMPRESA_LOGIN').AsString));
         JSON.AddPair('LOGIN_SISTEMA'    ,TJSONString.Create(Qry_General.FieldByName('LOGIN_SISTEMA').AsString));
         JSON.AddPair('DESCRIPCION_LOGIN',TJSONString.Create(Qry_General.FieldByName('DESCRIPCION_LOGIN').AsString));
         JSON.AddPair('CODIGO_IDENTIDAD' ,TJSONString.Create(Qry_General.FieldByName('CODIGO_IDENTIDAD').AsString));
         JSON.AddPair('PASSWORD_SISTEMA' ,TJSONString.Create(Qry_General.FieldByName('PASSWORD_SISTEMA').AsString));
         JSON.AddPair('LOGIN_SERVIDOR'   ,TJSONString.Create(Qry_General.FieldByName('LOGIN_SERVIDOR').AsString));
         JSON.AddPair('PASSWORD_SERVIDOR',TJSONString.Create(Qry_General.FieldByName('PASSWORD_SERVIDOR').AsString));
         JSON.AddPair('PRIVILEGIO'       ,TJSONString.Create(Qry_General.FieldByName('PRIVILEGIO').AsString));
         JSON.AddPair('PERFIL'           ,TJSONString.Create(Qry_General.FieldByName('PERFIL').AsString));
         JSON.AddPair('NODO_ESTFUNDEF'   ,TJSONString.Create(Qry_General.FieldByName('NODO_ESTFUNDEF').AsString));
         JSON.AddPair('CODIGO_ENT_ESTFIS',TJSONString.Create(Qry_General.FieldByName('CODIGO_ENT_ESTFIS').AsString));
         JSON.AddPair('FECHA_EXPIRACION' ,TJSONString.Create(Qry_General.FieldByName('FECHA_EXPIRACION').AsString));
         JSON.AddPair('LOGIN_WINDOWS'    ,TJSONString.Create(Qry_General.FieldByName('LOGIN_WINDOWS').AsString));
         JSON.AddPair('ACTIVO_BLOQUEADO' ,TJSONString.Create(Qry_General.FieldByName('ACTIVO_BLOQUEADO').AsString));
         JSON.AddPair('OBSERVACION'      ,TJSONString.Create(Qry_General.FieldByName('OBSERVACION').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'No existe Codigo Login '+sLogin_Sistema);
      Result := JSON;
   end;

   Qry_General.Close;
end;

function TServerMethods2.acceptLoginUsuario(jCampos: TJSONObject) :TJSONObject;
var JSON     :TJSONObject;
    sMensaje :string;
begin
//{
//  "EMPRESA_LOGIN": "033",
//  "LOGIN_SISTEMA": "GGARCIA",
//  "DESCRIPCION_LOGIN": "GONZALO GARCIA",
//  "CODIGO_IDENTIDAD": "GGARCIA",
//  "PASSWORD_SISTEMA": "gonza9332",
//  "LOGIN_SERVIDOR": "",
//  "PASSWORD_SERVIDOR": "",
//  "PRIVILEGIO": "USU",
//  "PERFIL": "ADMIN",
//  "NODO_ESTFUNDEF": 6,
//  "CODIGO_ENT_ESTFIS": "OFISIS",
//  "FECHA_EXPIRACION": "",
//  "LOGIN_WINDOWS": "",
//  "ACTIVO_BLOQUEADO": "ACTIVO",
//  "OBSERVACION": "PRUEBA"
//}
   JSON := TJSONObject.Create;

   if not ServerMethods1.Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

   try
     begin
        Qry_General.SQL.Clear;
        Qry_General.SQL.Add('INSERT INTO QS_SYS_LOGIN '
                           +'  (EMPRESA_LOGIN '
                           +'  ,LOGIN_SISTEMA '
                           +'  ,DESCRIPCION_LOGIN  '
                           +'  ,CODIGO_IDENTIDAD  '
                           +'  ,PASSWORD_SISTEMA '
                           +'  ,LOGIN_SERVIDOR '
                           +'  ,PASSWORD_SERVIDOR '
                           +'  ,PRIVILEGIO '
                           +'  ,PERFIL '
                           +'  ,NODO_ESTFUNDEF '
                           +'  ,CODIGO_ENT_ESTFIS  '
                           +'  ,FECHA_EXPIRACION '
                           +'  ,LOGIN_WINDOWS '
                           +'  ,ACTIVO_BLOQUEADO '
                           +'  ,OBSERVACION) '
                           +'VALUES '
                           +'  (:EMPRESA_LOGIN '
                           +'  ,:LOGIN_SISTEMA '
                           +'  ,:DESCRIPCION_LOGIN  '
                           +'  ,:CODIGO_IDENTIDAD '
                           +'  ,:PASSWORD_SISTEMA '
                           +'  ,:LOGIN_SERVIDOR '
                           +'  ,:PASSWORD_SERVIDOR  '
                           +'  ,:PRIVILEGIO '
                           +'  ,:PERFIL '
                           +'  ,:NODO_ESTFUNDEF '
                           +'  ,:CODIGO_ENT_ESTFIS '
                           +'  ,:FECHA_EXPIRACION '
                           +'  ,:LOGIN_WINDOWS '
                           +'  ,:ACTIVO_BLOQUEADO '
                           +'  ,:OBSERVACION) ');
        Qry_General.ParamByName('EMPRESA_LOGIN').asString     := jCampos.Getvalue<String>('EMPRESA_LOGIN');
        Qry_General.ParamByName('LOGIN_SISTEMA').asString     := jCampos.Getvalue<String>('LOGIN_SISTEMA');
        Qry_General.ParamByName('DESCRIPCION_LOGIN').asString := jCampos.Getvalue<String>('DESCRIPCION_LOGIN');
        Qry_General.ParamByName('CODIGO_IDENTIDAD').asString  := jCampos.Getvalue<String>('CODIGO_IDENTIDAD');
        Qry_General.ParamByName('PASSWORD_SISTEMA').asString  := jCampos.Getvalue<String>('PASSWORD_SISTEMA');
        Qry_General.ParamByName('LOGIN_SERVIDOR').asString    := jCampos.Getvalue<String>('LOGIN_SERVIDOR');
        Qry_General.ParamByName('PASSWORD_SERVIDOR').asString := jCampos.Getvalue<String>('PASSWORD_SERVIDOR');
        Qry_General.ParamByName('PRIVILEGIO').asString        := jCampos.Getvalue<String>('PRIVILEGIO');
        Qry_General.ParamByName('PERFIL').asString            := jCampos.Getvalue<String>('PERFIL');
        Qry_General.ParamByName('NODO_ESTFUNDEF').AsFloat     := jCampos.Getvalue<Double>('NODO_ESTFUNDEF');
        Qry_General.ParamByName('CODIGO_ENT_ESTFIS').asString := jCampos.Getvalue<String>('CODIGO_ENT_ESTFIS');
        Qry_General.ParamByName('FECHA_EXPIRACION').asString  := jCampos.Getvalue<String>('FECHA_EXPIRACION');
        Qry_General.ParamByName('LOGIN_WINDOWS').asString     := jCampos.Getvalue<String>('LOGIN_WINDOWS');
        Qry_General.ParamByName('ACTIVO_BLOQUEADO').asString  := jCampos.Getvalue<String>('ACTIVO_BLOQUEADO');
        Qry_General.ParamByName('OBSERVACION').asString       := jCampos.Getvalue<String>('OBSERVACION');
        Qry_General.ExecSql;

        JSON.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
        JSON.AddPair('Mensaje' ,'Registro Insertado');
        Result := JSON;
     end
   except
     begin
        JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
        JSON.AddPair('Mensaje' ,'Error al Insertar Registro');
        Result := JSON;
     end;
   end;

end;

function TServerMethods2.updateLoginUsuario(sLogin_Sistema :string; jCampos: TJSONObject) :TJSONObject;
var JSON     :TJSONObject;
    sSet     :string;
    sMensaje :string;
begin
//{
//  "DESCRIPCION_LOGIN": "GONZALO GARCIA PEREZ",
//  "CODIGO_IDENTIDAD": "GGARCIA",
//  "PASSWORD_SISTEMA": "gonza9332",
//  "LOGIN_SERVIDOR": "",
//  "PASSWORD_SERVIDOR": "",
//  "PRIVILEGIO": "USU",
//  "PERFIL": "ADMIN",
//  "NODO_ESTFUNDEF": 6,
//  "CODIGO_ENT_ESTFIS": "OFISIS",
//  "FECHA_EXPIRACION": "",
//  "LOGIN_WINDOWS": "",
//  "ACTIVO_BLOQUEADO": "ACTIVO",
//  "OBSERVACION": "PRUEBA DE API"
//}

   JSON := TJSONObject.Create;

   if not ServerMethods1.Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

   try
     begin

        sSet := 'set';
        if Assigned(jCampos.FindValue('DESCRIPCION_LOGIN')) then
           sSet := sSet+' DESCRIPCION_LOGIN = :DESCRIPCION_LOGIN';
        if Assigned(jCampos.FindValue('CODIGO_IDENTIDAD')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' CODIGO_IDENTIDAD       = :CODIGO_IDENTIDAD';
        if Assigned(jCampos.FindValue('PASSWORD_SISTEMA')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' PASSWORD_SISTEMA       = :PASSWORD_SISTEMA';
        if Assigned(jCampos.FindValue('LOGIN_SERVIDOR')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' LOGIN_SERVIDOR       = :LOGIN_SERVIDOR';
        if Assigned(jCampos.FindValue('PASSWORD_SERVIDOR')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' PASSWORD_SERVIDOR       = :PASSWORD_SERVIDOR';
        if Assigned(jCampos.FindValue('PRIVILEGIO')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' PRIVILEGIO       = :PRIVILEGIO';
        if Assigned(jCampos.FindValue('PERFIL')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' PERFIL       = :PERFIL';
        if Assigned(jCampos.FindValue('NODO_ESTFUNDEF')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' NODO_ESTFUNDEF       = :NODO_ESTFUNDEF';
        if Assigned(jCampos.FindValue('CODIGO_ENT_ESTFIS')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' CODIGO_ENT_ESTFIS       = :CODIGO_ENT_ESTFIS';
        if Assigned(jCampos.FindValue('FECHA_EXPIRACION')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' FECHA_EXPIRACION       = :FECHA_EXPIRACION';
        if Assigned(jCampos.FindValue('LOGIN_WINDOWS')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' LOGIN_WINDOWS       = :LOGIN_WINDOWS';
        if Assigned(jCampos.FindValue('ACTIVO_BLOQUEADO')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' ACTIVO_BLOQUEADO       = :ACTIVO_BLOQUEADO';
        if Assigned(jCampos.FindValue('OBSERVACION')) then
           if sSet <> 'set' then sSet := sSet+',';
              sSet := sSet+' OBSERVACION       = :OBSERVACION';

        Qry_General.Close;
        Qry_General.SQL.Clear;
        Qry_General.SQL.Add('update QS_SYS_LOGIN ');
        Qry_General.SQL.Add(sSet);
        Qry_General.SQL.Add(' where Login_Sistema = :Login_Sistema');

        Qry_General.ParamByName('LOGIN_SISTEMA').asString     := sLogin_Sistema;
        if Assigned(jCampos.FindValue('DESCRIPCION_LOGIN')) then
           Qry_General.ParamByName('DESCRIPCION_LOGIN').asString := jCampos.Getvalue<String>('DESCRIPCION_LOGIN');
        if Assigned(jCampos.FindValue('CODIGO_IDENTIDAD')) then
           Qry_General.ParamByName('CODIGO_IDENTIDAD').asString  := jCampos.Getvalue<String>('CODIGO_IDENTIDAD');
        if Assigned(jCampos.FindValue('PASSWORD_SISTEMA')) then
           Qry_General.ParamByName('PASSWORD_SISTEMA').asString  := jCampos.Getvalue<String>('PASSWORD_SISTEMA');
        if Assigned(jCampos.FindValue('LOGIN_SERVIDOR')) then
           Qry_General.ParamByName('LOGIN_SERVIDOR').asString    := jCampos.Getvalue<String>('LOGIN_SERVIDOR');
        if Assigned(jCampos.FindValue('PASSWORD_SERVIDOR')) then
           Qry_General.ParamByName('PASSWORD_SERVIDOR').asString := jCampos.Getvalue<String>('PASSWORD_SERVIDOR');
        if Assigned(jCampos.FindValue('PRIVILEGIO')) then
           Qry_General.ParamByName('PRIVILEGIO').asString        := jCampos.Getvalue<String>('PRIVILEGIO');
        if Assigned(jCampos.FindValue('PERFIL')) then
           Qry_General.ParamByName('PERFIL').asString            := jCampos.Getvalue<String>('PERFIL');
        if Assigned(jCampos.FindValue('NODO_ESTFUNDEF')) then
           Qry_General.ParamByName('NODO_ESTFUNDEF').AsFloat     := jCampos.Getvalue<Double>('NODO_ESTFUNDEF');
        if Assigned(jCampos.FindValue('CODIGO_ENT_ESTFIS')) then
           Qry_General.ParamByName('CODIGO_ENT_ESTFIS').asString := jCampos.Getvalue<String>('CODIGO_ENT_ESTFIS');
        if Assigned(jCampos.FindValue('FECHA_EXPIRACION')) then
           Qry_General.ParamByName('FECHA_EXPIRACION').asString  := jCampos.Getvalue<String>('FECHA_EXPIRACION');
        if Assigned(jCampos.FindValue('LOGIN_WINDOWS')) then
           Qry_General.ParamByName('LOGIN_WINDOWS').asString     := jCampos.Getvalue<String>('LOGIN_WINDOWS');
        if Assigned(jCampos.FindValue('ACTIVO_BLOQUEADO')) then
           Qry_General.ParamByName('ACTIVO_BLOQUEADO').asString  := jCampos.Getvalue<String>('ACTIVO_BLOQUEADO');
        if Assigned(jCampos.FindValue('OBSERVACION')) then
           Qry_General.ParamByName('OBSERVACION').asString       := jCampos.Getvalue<String>('OBSERVACION');
        Qry_General.ExecSql;

        JSON.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
        JSON.AddPair('Mensaje' ,'Registro Actualizado');
        Result := JSON;
     end
   except
     begin
        JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
        JSON.AddPair('Mensaje' ,'Error al Actualizar Registro');
        Result := JSON;
     end;
   end;
end;

function TServerMethods2.cancelLoginUsuario(sLogin_Sistema :string) :TJSONObject;
var JSON     :TJSONObject;
    sMensaje :string;
begin

   JSON := TJSONObject.Create;

   if not ServerMethods1.Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

   try
     begin
        Qry_General.Close;
        Qry_General.SQL.Clear;
        Qry_General.SQL.Add('delete from QS_SYS_LOGIN ');
        Qry_General.SQL.Add(' where Login_Sistema = :Login_Sistema');

        Qry_General.ParamByName('LOGIN_SISTEMA').asString := sLogin_Sistema;
        Qry_General.ExecSql;

        JSON.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
        JSON.AddPair('Mensaje' ,'Registro Eliminado');
        Result := JSON;
     end
   except
     begin
        JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
        JSON.AddPair('Mensaje' ,'Error al Eliminar Registro');
        Result := JSON;
     end;
   end;
end;

function TServerMethods2.ObtenerEstadoProceso(fPid: double): TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not ServerMethods1.Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

   Qry_Estado.Close;
   Qry_Estado.SQL.Clear;
   Qry_Estado.SQL.Add('select * ');
   Qry_Estado.SQL.Add('  from qs_sys_estado_procesos ');
   Qry_Estado.SQL.Add(' where pid = :pid');
   Qry_Estado.ParamByName('pid').AsFloat := fPid;
   Qry_Estado.Open;

   if not Qry_Estado.Eof then
   begin
      ArregloJson := TJSONArray.Create;
      JSONProd    := TJSONObject.Create;
      JSONProd.AddPair('Estado'  ,'0');  //0:Ejecutado 1:Error
      JSONProd.AddPair('Data',ArregloJson);
      while not Qry_Estado.Eof do
      begin
         JSON := TJSONObject.Create;

         JSON.AddPair('mensaje'  ,TJSONString.Create(Qry_Estado.FieldByName('mensaje').AsString));
         JSON.AddPair('reg_tot1' ,TJSONNumber.Create(Qry_Estado.FieldByName('reg_tot1').AsFloat));
         JSON.AddPair('reg_proc1',TJSONNumber.Create(Qry_Estado.FieldByName('reg_proc1').AsFloat));
         JSON.AddPair('reg_tot2' ,TJSONNumber.Create(Qry_Estado.FieldByName('reg_tot2').AsFloat));
         JSON.AddPair('reg_proc2',TJSONNumber.Create(Qry_Estado.FieldByName('reg_proc2').AsFloat));

         ArregloJson.AddElement(JSON);

         Qry_Estado.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'ID de proceso '+FloatToStr(fPid)+' no existe');
      Result := JSON;
   end;

   Qry_Estado.Close;

end;


function TServerMethods2.ObtenerEmpresas(sIdentidad: string): TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
    i :Integer;
begin
   if not ServerMethods1.Conexion_Basedatos then
   begin
      sMensaje := Pchar('Error de conexion a la Base Datos');
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,sMensaje);
      Result := JSON;
      exit;
   end;

 for i := 1 to 30 do
 begin

   Qry_General.Close;
   Qry_General.SQL.Clear;
   Qry_General.SQL.Add('select * ');
   Qry_General.SQL.Add('  from qs_sys_identidad ');
   Qry_General.SQL.Add(' where Juridico_Natural = ''J'' ');
   if sIdentidad <> '' then
   begin
      Qry_General.SQL.Add(' and Codigo_Identidad = :Codigo_Identidad');
      Qry_General.ParamByName('Codigo_Identidad').AsString := sIdentidad;
   end;
   Qry_General.Open;
   while not Qry_General.Eof do
   begin
      Qry_General.Next;
   end;
 end;

   Qry_General.first;
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
         JSON.AddPair('Juridico_Natural',TJSONString.Create(Qry_General.FieldByName('Juridico_Natural').AsString));
         JSON.AddPair('Credencial'      ,TJSONString.Create(Qry_General.FieldByName('Credencial').AsString));
         JSON.AddPair('Razon_Social_Pat',TJSONString.Create(Qry_General.FieldByName('Razon_Social_Pat').AsString));
         JSON.AddPair('Nombre_Fanta_Mat',TJSONString.Create(Qry_General.FieldByName('Nombre_Fanta_Mat').AsString));
         JSON.AddPair('Nombres'         ,TJSONString.Create(Qry_General.FieldByName('Nombres').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'Codigo Empresa '+sIdentidad+' no existe');
      Result := JSON;
   end;

   Qry_General.Close;



end;

function TServerMethods2.ObtenerIdentidades(sTipo :string; sIdentidad: string): TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not ServerMethods1.Conexion_Basedatos then
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
   Qry_General.SQL.Add('  from qs_sys_identidad ');
   Qry_General.SQL.Add(' where Juridico_Natural = :Juridico_Natural ');
   if sIdentidad <> '' then
   begin
      Qry_General.SQL.Add(' and Codigo_Identidad = :Codigo_Identidad');
      Qry_General.ParamByName('Codigo_Identidad').AsString := sIdentidad;
   end;
   Qry_General.ParamByName('Juridico_Natural').AsString := sTipo;
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
         JSON.AddPair('Juridico_Natural',TJSONString.Create(Qry_General.FieldByName('Juridico_Natural').AsString));
         JSON.AddPair('Credencial'      ,TJSONString.Create(Qry_General.FieldByName('Credencial').AsString));
         JSON.AddPair('Razon_Social_Pat',TJSONString.Create(Qry_General.FieldByName('Razon_Social_Pat').AsString));
         JSON.AddPair('Nombre_Fanta_Mat',TJSONString.Create(Qry_General.FieldByName('Nombre_Fanta_Mat').AsString));
         JSON.AddPair('Nombres'         ,TJSONString.Create(Qry_General.FieldByName('Nombres').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Error' ,'Codigo Identidad '+sIdentidad+' no existe');
      Result := JSON;
   end;

   Qry_General.Close;

end;

function TServerMethods2.ObtenerCodigosGenerales(sCodigo :string): TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not ServerMethods1.Conexion_Basedatos then
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
   Qry_General.SQL.Add('  from qs_sys_cod_det ');
   Qry_General.SQL.Add(' where Cod_General = :Cod_General ');
   Qry_General.ParamByName('Cod_General').AsString := sCodigo;
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

         JSON.AddPair('Cod_General',TJSONString.Create(Qry_General.FieldByName('Cod_General').AsString));
         JSON.AddPair('Cod_Detail' ,TJSONString.Create(Qry_General.FieldByName('Cod_Detail').AsString));
         JSON.AddPair('Desc_Detail',TJSONString.Create(Qry_General.FieldByName('Desc_Detail').AsString));

         ArregloJson.AddElement(JSON);

         sleep(1);
         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'Codigo General '+sCodigo+' no existe');
      Result := JSON;
   end;

   Qry_General.Close;

end;

function TServerMethods2.ObtenerPerfil : TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not ServerMethods1.Conexion_Basedatos then
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
   Qry_General.SQL.Add('  from qs_sys_perfil ');
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

         JSON.AddPair('Empresa'           ,TJSONString.Create(Qry_General.FieldByName('Empresa').AsString));
         JSON.AddPair('Cod_Perfil'        ,TJSONString.Create(Qry_General.FieldByName('Cod_Perfil').AsString));
         JSON.AddPair('Descripcion_Perfil',TJSONString.Create(Qry_General.FieldByName('Descripcion_Perfil').AsString));
         JSON.AddPair('Habilitado'        ,TJSONString.Create(Qry_General.FieldByName('Habilitado').AsString));
         JSON.AddPair('Consolida'         ,TJSONString.Create(Qry_General.FieldByName('Consolida').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'No se encontarron datos de perfiles');
      Result := JSON;
   end;

   Qry_General.Close;

end;

function TServerMethods2.ObtenerEstructuraFuncional(sIdentidad :string): TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not ServerMethods1.Conexion_Basedatos then
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
   Qry_General.SQL.Add('  from qs_sys_id_estfund ');
   Qry_General.SQL.Add(' where Codigo_Identidad = :Codigo_Identidad');
   Qry_General.ParamByName('Codigo_Identidad').AsString := sIdentidad;
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
         JSON.AddPair('Codigo_Nodo'     ,TJSONNumber.Create(Qry_General.FieldByName('Codigo_Nodo').AsFloat));
         JSON.AddPair('Nodo_Padre'      ,TJSONNumber.Create(Qry_General.FieldByName('Nodo_Padre').AsFloat));
         JSON.AddPair('Nodo_Estfun'     ,TJSONNumber.Create(Qry_General.FieldByName('Nodo_Estfun').AsFloat));
         JSON.AddPair('Descripcion'     ,TJSONString.Create(Qry_General.FieldByName('Descripcion').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'Estructura Funcional para Empresa '+sIdentidad+' no existe');
      Result := JSON;
   end;

   Qry_General.Close;

end;

function TServerMethods2.ObtenerEstructuraFisica(sIdentidad :string): TJSONObject;
var ArregloJson :TJSONArray;
    JSON        :TJSONObject;
    JSONProd    :TJSONObject;
    sMensaje    :string;
begin
   if not ServerMethods1.Conexion_Basedatos then
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
   Qry_General.SQL.Add('  from qs_sys_id_estfisd ');
   Qry_General.SQL.Add(' where Codigo_Identidad = :Codigo_Identidad');
   Qry_General.ParamByName('Codigo_Identidad').AsString := sIdentidad;
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
         JSON.AddPair('Codigo_Nodo'     ,TJSONNumber.Create(Qry_General.FieldByName('Codigo_Nodo').AsFloat));
         JSON.AddPair('Nodo_Padre'      ,TJSONNumber.Create(Qry_General.FieldByName('Nodo_Padre').AsFloat));
         JSON.AddPair('Nodo_EstGerDef'  ,TJSONNumber.Create(Qry_General.FieldByName('Nodo_EstGerDef').AsFloat));
         JSON.AddPair('Nodo_EstFis'     ,TJSONNumber.Create(Qry_General.FieldByName('Nodo_EstFis').AsFloat));
         JSON.AddPair('Codificacion'    ,TJSONString.Create(Qry_General.FieldByName('Codificacion').AsString));
         JSON.AddPair('Descripcion'     ,TJSONString.Create(Qry_General.FieldByName('Descripcion').AsString));

         ArregloJson.AddElement(JSON);

         Qry_General.Next;
      end;
      Result := JSONProd;
   end
   else
   begin
      JSON := TJSONObject.Create;
      JSON.AddPair('Estado'  ,'1');  //0:Ejecutado 1:Error
      JSON.AddPair('Mensaje' ,'Estructura Fisica para Empresa '+sIdentidad+' no existe');
      Result := JSON;
   end;

   Qry_General.Close;

end;

end.
