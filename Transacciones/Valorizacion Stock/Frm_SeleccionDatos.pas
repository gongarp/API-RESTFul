unit Frm_SeleccionDatos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, StdCtrls, Buttons, Mask,  ExtCtrls,
   OvcBase, OvcISLB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmSeleccionDatos = class(TForm)
    Panel2: TPanel;
    ListTarget: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    BTN_Cancelar: TBitBtn;
    BTN_Aceptar: TBitBtn;
    OvcController1: TOvcController;
    ListSource: TOvcSearchList;
    Qry_General: TFDQuery;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListSourceKeyPress(Sender: TObject; var Key: Char);
    procedure ListTargetKeyPress(Sender: TObject; var Key: Char);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BTN_AceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sTipo_Proceso : String;
  end;

     procedure SeleccionParametros( sNombre_Tabla
                                   ,sCodigo
                                   ,sCondicion
                                   ,sTipo  : String);
     procedure SeleccionParametrosMult(sNombre_Tabla1
                                      ,sNombre_Tabla2
                                      ,sCodigo
                                      ,sCondicion1
                                      ,sCondicion2
                                      ,sTipo   : String);
     procedure SeleccionParametros_Auditoria( sNombre_Tabla
                                   ,sCodigo
                                   ,sCondicion
                                   ,sTipo  : String);
     procedure BorraParametros(sTipo  : String);
var
  FrmSeleccionDatos: TFrmSeleccionDatos;

implementation

uses DM_Comun
    ,DM_Base_Datos
    ,DM_Variables_Menu;

{$R *.DFM}

procedure TFrmSeleccionDatos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFrmSeleccionDatos.SpeedButton1Click(Sender: TObject);
begin
  if ListSource.ItemIndex <> -1 then
  begin
    ListTarget.Items.Add(ListSource.Items[ListSource.ItemIndex]);
    ListSource.Items.Delete(ListSource.ItemIndex);
  end;
end;

procedure TFrmSeleccionDatos.SpeedButton2Click(Sender: TObject);
begin
  if ListSource.Items.Count <> 0 then
     ListSource.ItemIndex := 0;

  while ListSource.ItemIndex <> -1 do
  begin
      ListTarget.Items.Add(ListSource.Items[ListSource.ItemIndex]);
      ListSource.Items.Delete(ListSource.ItemIndex);

      if ListSource.Items.Count <> 0 then
        ListSource.ItemIndex := 0;
  end;
end;

procedure TFrmSeleccionDatos.ListSourceKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Trim(Key) = EmptyStr then
      SpeedButton1Click(Sender);
end;

procedure TFrmSeleccionDatos.ListTargetKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Trim(Key) = EmptyStr then
      SpeedButton2Click(Sender);
end;

procedure SeleccionParametros( sNombre_Tabla
                              ,sCodigo
                              ,sCondicion
                              ,sTipo   : String);
var i : Integer;
begin
  FrmSeleccionDatos := TFrmSeleccionDatos.Create(Application);
  With FrmSeleccionDatos,QRY_General do
  begin
     Sql.Clear;
     if sDriver = 'MSSQL' then
        SQL.Add('set dateformat dmy;');

     Sql.Add('SELECT DISTINCT '+sCodigo
            +' FROM  '+sNombre_Tabla
            +' WHERE '+sCodigo );
     Sql.Add(' NOT IN ( SELECT z.valor FROM QS_SYS_PARAM_PROCESO z'
            +'                             WHERE z.Proceso   = :Proceso'
            +'                              AND  z.Parametro = :Parametro)'
            );
     if sCondicion <> '' then
        Sql.Add( ' AND '+sCondicion );

     Sql.Add( ' ORDER BY '+sCodigo );

     ParamByName('Proceso').asString   := IntToStr(Application.Handle);
     ParamByName('Parametro').AsString := sTipo;
     Open;
     while Not (EOF) do
     begin
        ListSource.Items.Add(FieldByName(sCodigo).AsString);

 //       New_List.Items.Add(FieldByName(sCodigo).AsString);
        Next;
     end;
     Close;

     // Inserto lo restante en en Destino
     Sql.Clear;
     Sql.Add(' SELECT z.valor FROM QS_SYS_PARAM_PROCESO z'
            +' WHERE  z.Proceso   = :Proceso'
            +' AND    z.Parametro = :Parametro'
            );
     ParamByName('Proceso').asString   := IntToStr(Application.Handle);
     ParamByName('Parametro').AsString := sTipo;
     Open;
     while Not (EOF) do
     begin
        ListTarget.Items.Add(FieldByName('Valor').AsString);
        Next;
     end;
     Close;
     sTipo_Proceso := sTipo;
  end;
  if sTipo = 'CUSTODIAS' then
     FrmSeleccionDatos.caption := 'Selección de Custodias';
  FrmSeleccionDatos.ShowModal;
end;

procedure SeleccionParametrosMult(sNombre_Tabla1
                                 ,sNombre_Tabla2
                                 ,sCodigo
                                 ,sCondicion1
                                 ,sCondicion2
                                 ,sTipo   : String);
var i : Integer;
begin
  FrmSeleccionDatos := TFrmSeleccionDatos.Create(Application);
  With FrmSeleccionDatos,QRY_General do
  begin
     Sql.Clear;
     if sDriver = 'MSSQL' then
        SQL.Add('set dateformat dmy;');

     Sql.Add('SELECT DISTINCT '+sCodigo
            +'  FROM '+sNombre_Tabla1);
     Sql.Add(' WHERE '+sCondicion1
            +' AND '+sCodigo+' NOT IN (SELECT z.valor FROM QS_SYS_PARAM_PROCESO z'
            +'                            WHERE z.Proceso   = :Proceso'
            +'                              AND z.Parametro = :Parametro)'
            );

     Sql.Add(' UNION ');

     Sql.Add('SELECT DISTINCT '+sCodigo
            +'  FROM '+sNombre_Tabla2);
     Sql.Add(' WHERE '+sCondicion2
            +'   AND '+sCodigo+' NOT IN (SELECT z.valor FROM QS_SYS_PARAM_PROCESO z'
            +'                            WHERE z.Proceso   = :Proceso'
            +'                              AND z.Parametro = :Parametro)');
         // +'   AND '+sCodigo+' NOT IN (SELECT DISTINCT '+sCodigo
         // +'                             FROM '+sNombre_Tabla1
         // +'                            WHERE '+sCondicion1+')'
         // +'                              AND '+sCodigo +' NOT IN (SELECT z.valor FROM QS_SYS_PARAM_PROCESO z'
         // +'                                                        WHERE z.Proceso   = :Proceso'
         // +'                                                          AND z.Parametro = :Parametro)');

     Sql.Add(' ORDER BY '+sCodigo );

  //   if bdesarrollo then
  //      sql.savetofile('c:\tmp.sql');

     ParamByName('Proceso').asString   := IntToStr(Application.Handle);
     ParamByName('Parametro').AsString := sTipo;
     Open;
     while Not (EOF) do
     begin
        ListSource.Items.Add(FieldByName(sCodigo).AsString);
 //     New_List.Items.Add(FieldByName(sCodigo).AsString);
        Next;
     end;
     Close;

     // Inserto lo restante en en Destino
     Sql.Clear;
     Sql.Add(' SELECT z.valor FROM QS_SYS_PARAM_PROCESO z'
            +' WHERE  z.Proceso   = :Proceso'
            +' AND    z.Parametro = :Parametro'
            );
     ParamByName('Proceso').asString   := IntToStr(Application.Handle);
     ParamByName('Parametro').AsString := sTipo;
     Open;
     while Not (EOF) do
     begin
        ListTarget.Items.Add(FieldByName('Valor').AsString);
        Next;
     end;
     Close;
     sTipo_Proceso := sTipo;
  end;
  FrmSeleccionDatos.ShowModal;
end;


procedure SeleccionParametros_Auditoria( sNombre_Tabla
                              ,sCodigo
                              ,sCondicion
                              ,sTipo   : String);
var i : Integer;
begin
  FrmSeleccionDatos := TFrmSeleccionDatos.Create(Application);
  With FrmSeleccionDatos,QRY_General do
  begin
     Sql.Clear;
     if sDriver = 'MSSQL' then
        SQL.Add('set dateformat dmy;');

     Sql.Add('SELECT DISTINCT '+sCodigo
            +' FROM  '+sNombre_Tabla
            +' WHERE '+sCodigo );
     if sCondicion <> '' then
        Sql.Add( ' AND '+sCondicion );

     Sql.Add( ' ORDER BY '+sCodigo );

     ParamByName('Proceso').asString   := IntToStr(Application.Handle);
     ParamByName('Parametro').AsString := sTipo;
     Open;
     while Not (EOF) do
     begin
        ListSource.Items.Add(FieldByName(sCodigo).AsString);

 //       New_List.Items.Add(FieldByName(sCodigo).AsString);
        Next;
     end;
     Close;

     // Inserto lo restante en en Destino
     Sql.Clear;
     Sql.Add(' SELECT z.valor FROM QS_SYS_PARAM_PROCESO z'
            +' WHERE  z.Proceso   = :Proceso'
            +' AND    z.Parametro = :Parametro'
            );
     ParamByName('Proceso').asString   := IntToStr(Application.Handle);
     ParamByName('Parametro').AsString := sTipo;
     Open;
     while Not (EOF) do
     begin
        ListTarget.Items.Add(FieldByName('Valor').AsString);
        Next;
     end;
     Close;
     sTipo_Proceso := sTipo;
  end;
  FrmSeleccionDatos.ShowModal;
end;

procedure TFrmSeleccionDatos.BTN_CancelarClick(Sender: TObject);
begin
   FrmSeleccionDatos.Close;
end;

procedure TFrmSeleccionDatos.SpeedButton3Click(Sender: TObject);
begin
  if ListTarget.ItemIndex <> -1 then
  begin
    ListSource.Items.Add(ListTarget.Items[ListTarget.ItemIndex]);


    ListTarget.Items.Delete(ListTarget.ItemIndex);
  end;
end;

procedure TFrmSeleccionDatos.SpeedButton4Click(Sender: TObject);
begin
  if ListTarget.Items.Count <> 0 then
     ListTarget.ItemIndex := 0;

  while ListTarget.ItemIndex <> -1 do
  begin
     ListSource.Items.Add(ListTarget.Items[ListTarget.ItemIndex]);
     ListTarget.Items.Delete(ListTarget.ItemIndex);

     if ListTarget.Items.Count <> 0 then
        ListTarget.ItemIndex := 0;
  end;
end;

procedure TFrmSeleccionDatos.BTN_AceptarClick(Sender: TObject);
var i : Integer;
begin
   With Qry_General do
   Begin
      Sql.Clear;
      Sql.Add('DELETE FROM QS_SYS_PARAM_PROCESO '
             +' WHERE Proceso   = :Proceso'
             +'  AND  Parametro = :Parametro'
             );
      ParamByName('Proceso').asString   := IntToStr(Application.Handle);
      ParamByName('Parametro').asString := sTipo_Proceso;
      try
        ExecSQL;
      except
      end;
      Close;
   End;

   for i := 0 to ListTarget.Items.Count -1 do
   begin
      With Qry_General do
      Begin
        Sql.Clear;
        Sql.Add('INSERT INTO QS_SYS_PARAM_PROCESO (Proceso,Parametro,Valor) '
               +'VALUES (:Proceso,:Parametro,:Valor)                   '
               );
        ParamByName('Proceso').asString   := IntToStr(Application.Handle);
        ParamByName('Parametro').AsString := sTipo_Proceso;
        ParamByName('Valor').AsString     := ListTarget.Items[i];
        try
           ExecSQL;
        except
        end;
        Close;
      End;
   end;
   FrmSeleccionDatos.Close;
end;

procedure BorraParametros(sTipo  : String);
begin
  FrmSeleccionDatos := TFrmSeleccionDatos.Create(Application);
  With FrmSeleccionDatos,QRY_General do
   Begin
      Sql.Clear;
      Sql.Add('DELETE FROM QS_SYS_PARAM_PROCESO '
             +' WHERE Proceso   = :Proceso'
             +'  AND  Parametro like :Parametro'
             );
      ParamByName('Proceso').asString   := IntToStr(Application.Handle);
      ParamByName('Parametro').asString := sTipo;
      try
        ExecSQL;
      except
      end;
      Close;
   End;
   FrmSeleccionDatos.Free;
End;

end.




