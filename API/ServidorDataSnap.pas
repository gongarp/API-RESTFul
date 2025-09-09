unit ServidorDataSnap;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP,
  System.JSON, Data.DBXCommon, Data.DBXPlatform, System.Rtti;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    DSServerClass2: TDSServerClass;
    DSAuthenticationManager1: TDSAuthenticationManager;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DSHTTPWebDispatcher1FormatResult(Sender: TObject;
      var ResultVal: TJSONValue; const Command: TDBXCommand;
      var Handled: Boolean);
    procedure DSServerClass2GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
  private
    { Private declarations }
   FServerFunctionInvokerAction: TWebActionItem;
   function AllowServerFunctionInvoker: Boolean;
  public
    { Public declarations }
  end;

const
  RutasValidas: array[0..6] of string = ('/DataSnap/rest/TServerMethods1/Tratamiento_Fechas',
                                         '/DataSnap/rest/TServerMethods1/ObtenerCarteras',
                                         '/DataSnap/rest/TServerMethods1/Valoriza_OMD',
                                         '/DataSnap/rest/TServerMethods1/Valoriza_RF',
                                         '/DataSnap/rest/TServerMethods1/Limites_OMD',
                                         '/DataSnap/rest/TServerMethods2/ObtenerEmpresas',
                                         '/DataSnap/rest/TServerMethods2/ObtenerCodigosGenerales');
var
  WebModuleClass: TComponentClass = TWebModule1;

implementation


{$R *.dfm}

uses Web.WebReq,
     MetodosServidor,
     MetodosServidor2;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
//var Archivo: TStringList;
begin
{
  Archivo := TStringList.Create;
  try
    Archivo.LoadFromFile('./server_status_page.html');
    Response.Content := Archivo.Text;
  finally
    Archivo.Free;
  end;
}
  Response.Content :=
    '<html>' +
    '<head><title>DataSnap REST API Server</title></head>' +
    '<body>DataSnap REST API Server</body>' +
    '</html>';

end;

procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var Ruta: string;
    bencontrado :Boolean;
begin
  Response.SetCustomHeader('Access-Control-Allow-Origin', '*');
  Response.SetCustomHeader('Access-Control-Allow-Methods', '*');

  if trim(Request.GetFieldByName('Access-Control-Request-Headers')) <> '' then
  begin
     Response.SetCustomHeader('Access-Control-Allow-Headers', Request.GetFieldByName('Access-Control-Request-Headers'));
     Handled := True;
  end;

  if FServerFunctionInvokerAction <> nil then
     FServerFunctionInvokerAction.Enabled := AllowServerFunctionInvoker;


  bencontrado := false;
  for Ruta in RutasValidas do
    if Pos(Ruta, Request.PathInfo) > 0 then
       bencontrado := True;

  if not bencontrado then
  begin
     Response.StatusCode := 404;
     Response.Content := '{'
                        +'   "error": "Recurso '+Request.PathInfo+' no encontrado." '
                        +'}';
     Response.ContentType := 'application/json';
     Handled := True;
  end;

end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
   FServerFunctionInvokerAction := ActionByName('ServerFunctionInvokerAction');
end;

function TWebModule1.AllowServerFunctionInvoker: Boolean;
begin
  Result := (Request.RemoteAddr = '127.0.0.1') or (Request.RemoteAddr = '0:0:0:0:0:0:0:1') or (Request.RemoteAddr = '::1');
end;

procedure TWebModule1.DSAuthenticationManager1UserAuthenticate(Sender: TObject;
  const Protocol, Context, User, Password: string; var valid: Boolean;
  UserRoles: TStrings);
begin
//  if (( User = 'Invitado') and (Password = '123')) then
//  begin
//    UserRoles.Add('Invitado');
//    Valid := True;
//  end
//  else if (( User = 'Administrador') and (Password = '123')) then
//  begin
//    UserRoles.Add('Administrador');
//    Valid := True;
//  end
//  else
//    Valid := False;
//
//  if not valid  then
//  begin
//    Response.Content := '{'
//                       +'   "error": "Acceso denegado: usuario o contraseña incorrectos" '
//                       +'}';
//    Response.ContentType := 'application/json';
//  end;
end;

procedure TWebModule1.DSAuthenticationManager1UserAuthorize(Sender: TObject;
  AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
  if (valid = False) then
     GetInvocationMetadata.ResponseCode := 401;
end;

procedure TWebModule1.DSHTTPWebDispatcher1FormatResult(Sender: TObject;
  var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
begin
    ResultVal := (ResultVal as TJSONarray).Remove(0);
    Handled := True;
end;

procedure TWebModule1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := MetodosServidor.TServerMethods1;
  DSServerClass.LifeCycle := 'Invocation'; // o 'Session'
end;

procedure TWebModule1.DSServerClass2GetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := MetodosServidor2.TServerMethods2;
  DSServerClass.LifeCycle := 'Invocation'; //o 'Session';
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

