unit Mensajes_Procesos;

interface                                  

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Wwtable, Wwdatsrc, Grids, DBGrids, StdCtrls, Gauges,
  ComCtrls, ExtCtrls, Buttons, Wwquery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TFrmMensajesProcesos = class(TForm)
    Panel1: TPanel;
    Barra_de_Estado: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    L_Reg_Count: TLabel;
    L_fechas: TLabel;
    DBGrid1: TDBGrid;
    ds_Errores: TwwDataSource;
    Boton_Cancelar_Salir: TBitBtn;
    Timer1: TTimer;
    Btn_Det: TBitBtn;
    T_Paradox: TFDMemTable;
    T_Errores_Mesa: TFDMemTable;
    T_Errores: TFDMemTable;
    QryGrabaError: TFDQuery;
    T_ErroresEmpresa: TStringField;
    T_ErroresProceso: TStringField;
    T_ErroresFecha_Proceso: TDateTimeField;
    T_ErroresUsuario: TStringField;
    T_ErroresRegistro: TStringField;
    T_ErroresModulo_Error: TStringField;
    T_ErroresDescripcion: TStringField;
    Avance_Reg: TProgressBar;
    Avance_Fecha: TProgressBar;
    Qry_General: TFDQuery;
    procedure Boton_Cancelar_SalirClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Btn_DetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    bCancelar : Boolean;{ False indica que está procesando}
    bTermino  : Boolean;{ Proceso termina normalmente }
  end;
procedure Inicializar_Progreso(dFecha_Inicio : TDateTime;
                               dFecha_Final  : TDateTime
                               );
procedure Inicializar_Progreso_Reg(iMax_regs : Integer);

procedure Mostrar_Progreso_dia(dFecha : TDateTime);
procedure Mostrar_Progreso_Reg;
procedure Mostrar_Mensaje(sMensaje    : String;
                      var bAbortar    : Boolean);
procedure Termino_proceso;

procedure Insertar_Registro_Errores(sEmpresa      : String;
                                    sProceso      : String;
                                    dFecha_Hora   : TDateTime;
                                    sUsuario      : String;
                                    sRegistro     : String;
                                    sModulo_Error : String;
                                    sDescripcion  : String
                                    );
procedure Insertar_Registro_Errores_Mesa(sEmpresa      : String;
                                         sProceso      : String;
                                         dFecha_Hora   : TDateTime;
                                         sUsuario      : String;
                                         sRegistro     : String;
                                         sModulo_Error : String;
                                         sDescripcion  : String;
                                         sNivel        : String
                                         );
var
  FrmMensajesProcesos   : TFrmMensajesProcesos;
  TTranscurrido : TDateTime;
  Time_Inicio   : TDateTime;
  Fecha_Termino : TDateTime;
  iNro_Registros: Integer;

implementation
uses DM_Global_Var,
     Registro_Log,
     DM_Base_Datos,
     DM_Comun;
{$R *.DFM}
procedure Inicializar_Progreso(dFecha_Inicio : TDateTime;
                               dFecha_Final  : TDateTime
                               );

var
  iMax_dias : Double;
begin
  with FrmMensajesProcesos do
  begin
    bCancelar     := False;
    bTermino      := False;
    Fecha_Termino := dFecha_Final;

    if dFecha_Final = dFecha_Inicio then
       iMax_dias := 1
    else
       //iMax_dias := diashabiles(dFecha_Inicio,dFecha_Final,'CL');
       //ggarcia 08-07-2024 estaba calculando mal la cantidad de dias entre las dos fechas
       //iMax_dias := dFecha_Final - dFecha_Inicio;  // calculo rentabilidad, intereses y cm  de Gestion RV, lo usa asi.
       iMax_dias := (dFecha_Final - dFecha_Inicio) + 1;  // calculo rentabilidad, intereses y cm  de Gestion RV, lo usa asi.

    if iMax_dias <= 0 then
       iMax_dias := 1;

    PageControl1.ActivePage := TabSheet1;
    if (iMax_dias < 2) and
       (dFecha_Final = dFecha_Inicio) then
    begin
      Avance_Fecha.visible := False;
      L_fechas.Caption     := 'Procesando dia '+FormatDateTime('dd/MM/yyyy',dFecha_Inicio);
    end
    else
    begin
      Avance_Fecha.visible := True;
      L_fechas.Caption     := 'Procesando dia '+FormatDateTime('dd/MM/yyyy',dFecha_Inicio)
                             +' de '+FormatDateTime('dd/MM/yyyy',Fecha_Termino);
    end;
    L_Reg_Count.Caption    := 'Determinando';
    Time_Inicio            := Now;
    Avance_Fecha.Min       := 0;
    Avance_Fecha.Position  := 0;
    Avance_Fecha.Max       := Trunc(iMax_dias);
    FrmMensajesProcesos.refresh;

    with qry_general do
    begin
      sql.Clear;
      sql.Add('insert into qs_sys_estado_procesos '
             +'(pid '
             +',mensaje '
             +',reg_tot1 '
             +',reg_proc1 '
             +',reg_tot2 '
             +',reg_proc2) ');
      sql.Add(' values ');
      sql.Add('(:pid '
             +',:mensaje '
             +',:reg_tot1 '
             +',:reg_proc1 '
             +',:reg_tot2 '
             +',:reg_proc2) ');
      ParamByName('pid').AsFloat      := Application.Handle;
      ParamByName('mensaje').AsString := 'Iniciando Proceso';
      ParamByName('reg_tot1').AsFloat  := iMax_dias;
      ParamByName('reg_proc1').AsFloat := Avance_Fecha.Position;
      ParamByName('reg_tot2').AsFloat  := 0;
      ParamByName('reg_proc2').AsFloat := 0;
      ExecSQL;
    end;
  end;
end;

procedure Inicializar_Progreso_Reg(iMax_regs : Integer);
begin
   with FrmMensajesProcesos do
   begin
     L_Reg_Count.Caption := 'Procesando registro 0 de '+InttoStr(iMax_regs);
     Avance_Reg.Min := 0;
     Avance_Reg.Position := 0;
     Avance_Reg.max := iMax_Regs;
     iNro_Registros := iMax_Regs;
     FrmMensajesProcesos.refresh;

     with qry_general do
     begin
        sql.Clear;
        sql.Add('update qs_sys_estado_procesos '
               +'   set reg_tot2 = :reg_tot2 '
               +' where pid = :pid ');
        ParamByName('pid').AsFloat      := Application.Handle;
        ParamByName('reg_tot2').AsFloat := iMax_Regs;
        ExecSQL;
     end;
   end;
end;

procedure Mostrar_Mensaje(sMensaje    : String;
                      var bAbortar    : Boolean);
begin
  with FrmMensajesProcesos do
  begin
     Barra_de_Estado.Panels[0].text := sMensaje;
     if bCancelar then
        bAbortar := True;

     with qry_general do
     begin
        sql.Clear;
        sql.Add('update qs_sys_estado_procesos '
               +'   set mensaje = :mensaje '
               +' where pid = :pid ');
        ParamByName('pid').AsFloat      := Application.Handle;
        ParamByName('mensaje').AsString := sMensaje;
        ExecSQL;
     end;
  end;
  Application.ProcessMessages;
end;

procedure Insertar_Registro_Errores(sEmpresa      : String;
                                    sProceso      : String;
                                    dFecha_Hora   : TDateTime;
                                    sUsuario      : String;
                                    sRegistro     : String;
                                    sModulo_Error : String;
                                    sDescripcion  : String
                                    );
begin
  sDescripcion := StrTran(sDescripcion, #10, ' ');
  with FrmMensajesProcesos do
  begin
    T_Errores.Insert;
    T_Errores.FieldByName('EMPRESA').AsString         := sEmpresa;
    T_Errores.FieldByName('PROCESO').AsString         := sProceso;
    T_Errores.FieldByName('FECHA_PROCESO').AsDateTime := solo_fecha(dFecha_Hora);
    T_Errores.FieldByName('USUARIO').AsString         := sUsuario;
    T_Errores.FieldByName('REGISTRO').AsString        := sRegistro;
    T_Errores.FieldByName('MODULO_ERROR').AsString    := sModulo_Error;
    T_Errores.FieldByName('DESCRIPCION').AsString     := sDescripcion;
    try
        T_Errores.Post;
    except on E: EFDDBEngineException do
       begin
          ShowError(E);
       end;
    end;

    if (FrmMensajesProcesos.Caption = 'Proyección de Flujos para Valorización de Flujos Ajustados') or
       (FrmMensajesProcesos.Caption = 'Ajuste de Flujos para Valorización de Flujos Ajustados') or
       (FrmMensajesProcesos.Caption = 'Valorización de Flujos Ajustados') then
    begin
      with QryGrabaError do
      begin
         ParamByname('EMPRESA').AsString           := sEmpresa;
         ParamByname('PROCESO').AsString           := sProceso;
         ParamByname('FECHA_HORA').AsDateTime      := dFecha_Hora;
         ParamByname('LOGIN_USUARIO').AsString     := sUsuario;
         ParamByname('REGISTRO').AsString          := sRegistro;
         ParamByname('MODULO_ERROR').AsString      := sModulo_Error;
         ParamByname('DESCRIPCION_ERROR').AsString := sDescripcion;
         try
            ExecSql;
         except on E: EFDDBEngineException do
            begin
              ShowError(E);
            end;
         end;
      end;
    end;
  end;
end;

procedure Insertar_Registro_Errores_Mesa(sEmpresa      : String;
                                         sProceso      : String;
                                         dFecha_Hora   : TDateTime;
                                         sUsuario      : String;
                                         sRegistro     : String;
                                         sModulo_Error : String;
                                         sDescripcion  : String;
                                         sNivel        : String
                                         );
begin
  sDescripcion := StrTran(sDescripcion, #10, ' ');
  with FrmMensajesProcesos do
  begin
    T_Errores_Mesa.Insert;
    T_Errores_Mesa.FieldByName('EMPRESA').AsString         := sEmpresa;
    T_Errores_Mesa.FieldByName('PROCESO').AsString         := sProceso;
    T_Errores_Mesa.FieldByName('FECHA_PROCESO').AsDateTime := dFecha_Hora;
    T_Errores_Mesa.FieldByName('USUARIO').AsString         := sUsuario;
    T_Errores_Mesa.FieldByName('REGISTRO').AsString        := sRegistro;
    T_Errores_Mesa.FieldByName('MODULO_ERROR').AsString    := sModulo_Error;
    T_Errores_Mesa.FieldByName('DESCRIPCION').AsString     := sDescripcion;
    T_Errores_Mesa.FieldByName('NIVEL').AsString           := sNivel;
    try
        T_Errores_Mesa.Post;
    except on E: EFDDBEngineException do
       begin
          ShowError(E);
       end;
    end;
  end;
end;

procedure TFrmMensajesProcesos.Boton_Cancelar_SalirClick(Sender: TObject);
begin
  if bTermino then
  begin
     Barra_de_Estado.Panels[0].text := 'Proceso Terminado Normalmente TIEMPO :'
                                      +FormatDateTime('hh:mm:ss',TTranscurrido);
     T_Errores.Close;
     T_Errores_Mesa.Close;
     Close; { Salida normal}
  end
  else
     if bCancelar then
     begin
        Barra_de_Estado.Panels[0].text := 'Proceso Abortado  TIEMPO :'
                                         +FormatDateTime('hh:mm:ss',TTranscurrido);
        Close; { salida por interrupcion}
     end
     else
     begin
        Boton_Cancelar_Salir.Caption := '&Salir';
        bCancelar := True;
        Boton_Cancelar_Salir.Enabled := false;
     end;
end;

procedure Termino_proceso;
begin
   with FrmMensajesProcesos do
   begin
      Boton_Cancelar_Salir.Caption := '&Salir';
      Boton_Cancelar_Salir.Enabled := True;
      bTermino       := True;
      Timer1.Enabled := False;
      FrmMensajesProcesos.BringToFront;
   end;
end;

procedure Mostrar_Progreso_dia(dFecha : TDateTime);
begin
  with FrmMensajesProcesos do
  begin
     Avance_Fecha.Position := Avance_Fecha.Position + 1;
     L_fechas.Caption      := 'Procesando dia '+FormatDateTime('dd/MM/yyyy',dFecha)
                           +' de '+FormatDateTime('dd/MM/yyyy',Fecha_Termino);

     with qry_general do
     begin
        sql.Clear;
        sql.Add('update qs_sys_estado_procesos '
               +'   set reg_proc1 = :reg_proc1 '
               +' where pid = :pid ');
        ParamByName('pid').AsFloat      := Application.Handle;
        ParamByName('reg_proc1').AsFloat := Avance_Fecha.Position;
        ExecSQL;
     end;
  end;
end;

procedure Mostrar_Progreso_Reg;
begin
  with FrmMensajesProcesos do
   begin
     Avance_Reg.Position := Avance_Reg.Position + 1;
     L_Reg_Count.Caption := 'Procesando registro '
                          +Inttostr(Avance_Reg.Position)+' de '+InttoStr(iNro_Registros);
     L_Reg_Count.refresh;

     with qry_general do
     begin
        sql.Clear;
        sql.Add('update qs_sys_estado_procesos '
               +'   set reg_proc2 = :reg_proc2 '
               +' where pid = :pid ');
        ParamByName('pid').AsFloat      := Application.Handle;
        ParamByName('reg_proc2').AsFloat := Avance_Reg.Position;
        ExecSQL;
     end;
   end;
end;


procedure TFrmMensajesProcesos.Timer1Timer(Sender: TObject);
begin
  TTranscurrido := Now - Time_Inicio;
  FrmMensajesProcesos.Barra_de_Estado.Panels[1].text := 'Tiempo Transcurrido: '
                                               +FormatDateTime('hh:mm:ss'
                                               ,TTranscurrido);

end;

procedure TFrmMensajesProcesos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   if (not bTermino) and ( (not bCancelar) or (not Boton_Cancelar_Salir.enabled) ) then
      Abort;
end;

procedure TFrmMensajesProcesos.FormCreate(Sender: TObject);
begin
   with T_Errores.FieldDefs do
   begin
      Clear;
   	Add('Empresa'      , ftString  , 10, False );
   	Add('PROCESO'      , ftString  , 30, False );
   	Add('FECHA_PROCESO', ftDatetime,  0, False );
   	Add('USUARIO'      , ftString  , 10, False );
   	Add('REGISTRO'     , ftString  , 120, False );
   	Add('MODULO_ERROR' , ftString  , 120, False );
   	Add('DESCRIPCION'  , ftString  ,200, False );
   end;

   //T_Errores.Tablename := T_Paradox.Tablename + intToStr(Application.Handle);
   //sTabla_Errores_Prdx := T_Errores.Tablename;
   try
      T_Errores.open;
   except
   end;
   try
      T_Errores.EmptyDataSet;
   except
   end;

   with T_Errores_Mesa.FieldDefs do
   begin
      Clear;
   	Add('Empresa'      , ftString  , 10, False );
   	Add('PROCESO'      , ftString  , 30, False );
   	Add('FECHA_PROCESO', ftDatetime,  0, False );
   	Add('USUARIO'      , ftString  , 10, False );
   	Add('REGISTRO'     , ftString  , 120, False );
   	Add('MODULO_ERROR' , ftString  , 120, False );
   	Add('DESCRIPCION'  , ftString  ,200, False );
   	Add('NIVEL'        , ftString  , 02, False );
   end;

  // T_Errores_Mesa.Tablename := T_Paradox.Tablename + intToStr(Application.Handle);
  // sTabla_Errores_Prdx := T_Errores_Mesa.Tablename;
   try
      T_Errores_Mesa.open;
   except
   end;
   try
      T_Errores_Mesa.EmptyDataSet;
   except
   end;

end;

procedure TFrmMensajesProcesos.Btn_DetClick(Sender: TObject);
begin

  if Btn_Det.Caption = 'Mas detalle' then
     bDetalle_Reg := True
  else
     bDetalle_Reg := False;

  if bDetalle_Reg then
  begin
     L_Reg_Count.Visible := True;
     Btn_Det.Caption := 'Ocultar detalle';
  end
  else
  begin
     Barra_de_Estado.Panels[0].text := '';
     L_Reg_Count.Visible := False;
     Btn_Det.Caption := 'Mas detalle';
  end;

end;

end.

