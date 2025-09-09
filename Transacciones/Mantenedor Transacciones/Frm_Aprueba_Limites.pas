unit Frm_Aprueba_Limites;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Wwdbigrd, Wwdbgrid,
   DB,  Wwdatsrc,  Wwtable, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet; //OneCrypt,

type
  TFrmApruebaLimites = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BTN_Cancelar: TBitBtn;
    wwDBGrid1: TwwDBGrid;
    DS_Aprueba: TwwDataSource;
    Label1: TLabel;
    ED_login: TEdit;
    DBEClave: TLabel;
    ED_Password: TEdit;
    BTN_Aceptar: TBitBtn;
    Lb_Nombre_Usuario: TLabel;
    Lb_Perfil: TLabel;
    Panel3: TPanel;
    chk_aprobar: TCheckBox;
    Lb_Supervisor: TLabel;
    T_Perfil: TFDTable;
    QRY_General: TFDQuery;
    T_PerfilCOD_GENERAL: TStringField;
    T_PerfilCOD_DETAIL: TStringField;
    T_PerfilDESC_DETAIL: TStringField;
    Qry_Paradox: TFDQuery;
    procedure BTN_AceptarClick(Sender: TObject);
    procedure chk_aprobarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    aux_Tipo_Llamada : String;
    aux_Empresa      : String;
    aux_Moneda       : String;
    aux_Transaccion  : String;
    aux_Folio_Interno: String;
    aux_Operador     : String;
  end;

  function Aprueba_Limites(sTipo_Llamada     : String;
                           sNombre_Tabla     : String;
                           sEmpresa          : String;
                           sOperador         : String;
                           sMoneda           : String;
                           sTransaccion      : String;
                           sFolio_Interno    : String;
                       var sLogin_Supervisor : String) : Boolean;

var
  FrmApruebaLimites: TFrmApruebaLimites;

implementation

uses DM_Comun,
     DM_Variables_Menu,
     DM_Identidad_Direccion,
     DM_Base_Datos;


{$R *.DFM}
function Aprueba_Limites(sTipo_Llamada     : String;
                         sNombre_Tabla     : String;
                         sEmpresa          : String;
                         sOperador         : String;
                         sMoneda           : String;
                         sTransaccion      : String;
                         sFolio_Interno    : String;
                     var sLogin_Supervisor : String) : Boolean;
begin
   Result := True;
   FrmApruebaLimites := TFrmApruebaLimites.Create(Application);
   with FrmApruebaLimites do
   begin
      aux_Tipo_Llamada  := sTipo_Llamada;
      aux_Empresa       := sEmpresa;
      aux_Moneda        := sMoneda;
      aux_Transaccion   := sTransaccion;
      aux_Folio_Interno := sFolio_Interno;
      aux_Operador      := sOperador;
      with Qry_Paradox do
      begin
         Sql.Clear;
         Sql.Add('select tipo'
                +'      ,codigo_tipo'
                +'      ,limite'
                +'      ,codigo'
                +'      ,descripcion'
                +'      ,monto_limite'
                +'      ,monto_transado'
                +'      ,sum(monto_operacion) as monto_operacion'
                +'      ,sum(monto_operacion) as monto_excedido'
                +'  from '+sNombre_Tabla
                +' where monto_transado > monto_limite '
                +' group by tipo'
                +'         ,codigo_tipo'
                +'         ,limite'
                +'         ,codigo'
                +'         ,descripcion'
                +'         ,monto_limite'
                +'         ,monto_transado');
         Sql.Add(' union ');
         Sql.Add('select tipo'
                +'      ,codigo_tipo'
                +'      ,limite'
                +'      ,codigo'
                +'      ,descripcion'
                +'      ,monto_limite'
                +'      ,monto_transado'
                +'      ,sum(monto_operacion) as monto_operacion'
                +'      ,(monto_transado+sum(monto_operacion))-monto_limite as monto_excedido'
                +'  from '+sNombre_Tabla
                +' where monto_transado <= monto_limite '
                +' group by tipo'
                +'         ,codigo_tipo'
                +'         ,limite'
                +'         ,codigo'
                +'         ,descripcion'
                +'         ,monto_limite'
                +'         ,monto_transado');
         Sql.Add(' order by tipo'
                +'         ,codigo');
         Open;
      end;
   end;
   if NOT (FrmApruebaLimites.showmodal = mrOK) then
   begin
     Result := False;
     Exit;
   end
   else
      sLogin_Supervisor := FrmApruebaLimites.ED_login.Text;
end;

procedure TFrmApruebaLimites.BTN_AceptarClick(Sender: TObject);
var sApellido_Mat : String;
    sApellido_Pat : String;
    sNombres      : String;
    sCredencial   : String;
    Result        : Boolean;
begin
   if (ED_login.text = '') or (ED_Password.text = '') then
   begin
      Application.Messagebox(Pchar('Debe ingresar Usuario y Password del Supervisor.')
                            ,Pchar( Caption )
                            ,MB_OK + MB_IconERROR);
      Exit;
   end;

   if ED_login.text = aux_Operador then
   begin
      Application.Messagebox(Pchar('Debe ingresar un Usuario distinto al Operador.')
                            ,Pchar( Caption )
                            ,MB_OK + MB_IconERROR);
      Exit;
   end;

   WITH QRY_General do
   begin
      Close;
      SQL.clear;
      SQL.Add('SELECT Privilegio '
             +'      ,Codigo_Identidad '
             +'  FROM QS_SYS_LOGIN '
             +' WHERE Login_Sistema    = :Login_Sistema '
             +'   AND Password_Sistema = :Password_Sistema ');
      ParamByName('Login_Sistema').AsString    := ED_login.text;
      if bEncriptado then
         ED_Password.text := encripta_printeables(ED_Password.text);
      ParamByName('Password_Sistema').AsString := ED_Password.text;
      Prepare;
      open;
      if eof then
      begin
         Application.Messagebox(Pchar('Usuario no existe ... ')
                               ,Pchar( Caption )
                               ,MB_OK + MB_IconERROR);
         Close;
         Exit;
      end;
      Leer_Identidad(FieldByName('Codigo_Identidad').AsString
                    ,'N'
                    ,sApellido_Mat
                    ,sApellido_Pat
                    ,sNombres
                    ,sCredencial
                    ,Result);
      Lb_Nombre_Usuario.caption := sApellido_Pat+' '+sApellido_Mat+', '+sNombres;
      T_Perfil.Close;
      T_Perfil.TableName := 'QS_SYS_COD_DET';
      T_Perfil.Filter   := 'Cod_General = ''PRIVIL'' and Cod_Detail = '''+FieldByName('Privilegio').AsString+'''';
      T_Perfil.Filtered := True;
      T_Perfil.Open;
      Lb_Perfil.caption := 'Privilegio - '+T_Perfil.fieldbyname('Desc_Detail').asString;
      if FieldByName('Privilegio').AsString <> 'SUP' then
      begin
         Application.Messagebox(Pchar('Usuario no tiene autorización para aprobar transacciones.'+#10+'Su Login debe tener privilegio ''SUPER USUARIO''.')
                               ,Pchar( Caption )
                               ,MB_OK + MB_IconERROR);
         Close;
         Exit;
      end;
      Close;
   end;

   if Application.MessageBox('¿Desea Aprobar Limites Excedidos?'
                            ,pchar(Caption)
                            ,mb_YesNo +mb_DefButton2) = idNo then
   begin
      Exit;
   end;

   // Elimina Registros anteriores
   WITH Qry_General do
   begin
      Close;
      SQL.clear;
      SQL.Add('DELETE FROM qs_sup_limites_aprobados '
             +' WHERE Folio_interno = :Folio_interno '
             +'   AND Transaccion   = :Transaccion '
             +'   AND Empresa       = :Empresa ');
      ParamByName('transaccion').asString        := aux_transaccion;
      ParamByName('folio_interno').asString      := aux_folio_interno;
      ParamByName('empresa').asString            := aux_empresa;
      Prepare;
      try
        ExecSql
       except on E: EFDDBEngineException do
        begin
           ShowError(E);
           Close;
           UnPrepare;
           Exit;
        end;
      end;
      Close;
      UnPrepare;
   end;

   // Registra Log Aprobacion
   WITH Qry_Paradox do
   begin
      First;
      while not eof do
      begin
         if Qry_Paradox.FieldByName('tipo').asString <> '' then
         begin
            with Qry_General do
            begin
               Close;
               SQL.clear;
               SQL.Add('INSERT INTO qs_sup_limites_aprobados '
                      +'(fecha_aprobacion '
                      +',login_supervisor '
                      +',login_operador '
                      +',empresa '
                      +',moneda '
                      +',transaccion '
                      +',folio_interno '
                      +',tipo '
                      +',codigo_tipo '
                      +',limite '
                      +',codigo '
                      +',descripcion '
                      +',monto_limite '
                      +',monto_transado '
                      +',monto_operacion '
                      +',monto_aprobado) '
                      +' VALUES '
                      +'(:fecha_aprobacion '
                      +',:login_supervisor '
                      +',:login_operador '
                      +',:empresa '
                      +',:moneda '
                      +',:transaccion '
                      +',:folio_interno '
                      +',:tipo '
                      +',:codigo_tipo '
                      +',:limite '
                      +',:codigo '
                      +',:descripcion '
                      +',:monto_limite '
                      +',:monto_transado '
                      +',:monto_operacion '
                      +',:monto_aprobado) ');
               ParamByName('fecha_aprobacion').asDatetime := fecha_hora_servidor;
               ParamByName('login_supervisor').asString   := ED_login.text;
               ParamByName('login_operador').asString     := sLogin_Sistema;
               ParamByName('empresa').asString            := aux_empresa;
               ParamByName('moneda').asString             := aux_moneda;
               ParamByName('transaccion').asString        := aux_transaccion;
               ParamByName('folio_interno').asString      := aux_folio_interno;
               ParamByName('tipo').asString               := Qry_Paradox.FieldByName('tipo').asString;
               ParamByName('codigo_tipo').asString        := Qry_Paradox.FieldByName('codigo_tipo').asString;
               ParamByName('limite').asString             := Qry_Paradox.FieldByName('limite').asString;
               ParamByName('codigo').asString             := Qry_Paradox.FieldByName('codigo').asString;
               ParamByName('descripcion').asString        := Qry_Paradox.FieldByName('descripcion').asString;
               ParamByName('monto_limite').asFloat        := Qry_Paradox.FieldByName('monto_limite').asFloat;
               ParamByName('monto_transado').asFloat      := Qry_Paradox.FieldByName('monto_transado').asFloat;
               ParamByName('monto_operacion').asFloat     := Qry_Paradox.FieldByName('monto_operacion').asFloat;
               ParamByName('monto_aprobado').asFloat      := Qry_Paradox.FieldByName('monto_excedido').asFloat;
               Prepare;
               try
                 ExecSql
                except on E: EFDDBEngineException do
                 begin
                    ShowError(E);
                    Close;
                    UnPrepare;
                    Exit;
                 end;
               end;
               Close;
               UnPrepare;
            end;
         end;
         Next;
      end;
   end;

   ModalResult := mrOk;
end;

procedure TFrmApruebaLimites.chk_aprobarClick(Sender: TObject);
begin
   if chk_aprobar.checked then
      Panel1.visible := true
   else
      Panel1.visible := false;
end;

procedure TFrmApruebaLimites.FormShow(Sender: TObject);
begin
   if aux_Tipo_Llamada = 'A' then
   begin
      chk_aprobar.enabled   := false;
      Lb_Supervisor.visible := true;
      BTN_Cancelar.caption  := '&Volver';
   end;
end;

end.
