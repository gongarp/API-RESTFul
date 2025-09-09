unit FrmConsolidaEmp;


interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, StdCtrls, Buttons, Mask, ExtCtrls,
  wwdblook, Wwdatsrc, IniFiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet,
   FireDAC.Comp.Client, dxdbtrel;

type
  TFrmConsolidaEmpresa = class(TForm)
    Panel2: TPanel;
    ListSource: TListBox;
    ListTarget: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    BTN_Cancelar: TBitBtn;
    BTN_Aceptar: TBitBtn;
    Panel4: TPanel;
    Label10: TLabel;
    Label4: TLabel;
    Ed_TipoClasif_Cartera: TwwDBLookupCombo;
    DataClasif: TwwDataSource;
    Chk_ClasifCarteras: TCheckBox;
    ListBox1: TListBox;
    QRY_General: TFDQuery;
    Qry_Clasificacion: TFDQuery;
    Ed_Clasificacion: TdxLookupTreeView;
    T_Clasif_Cartera: TFDQuery;
    T_Clasif_CarteraCODIGO_OBJETO: TStringField;
    T_Clasif_CarteraDESCRIPCION_OBJETO: TStringField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListSourceKeyPress(Sender: TObject; var Key: Char);
    procedure ListTargetKeyPress(Sender: TObject; var Key: Char);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BTN_AceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Ed_ClasificacionCloseUp(Sender: TObject);
    procedure Chk_ClasifCarterasClick(Sender: TObject);
    procedure Ed_ClasificacionExit(Sender: TObject);
    procedure Ed_ClasificacionDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure Ed_ClasificacionDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Ed_ClasificacionDropDown(Sender: TObject);
    procedure Ed_ClasificacionEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure Ed_ClasificacionClick(Sender: TObject);
    procedure Ed_ClasificacionStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure Ed_TipoClasif_CarteraChange(Sender: TObject);
    procedure Ed_TipoClasif_CarteraCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure Ed_TipoClasif_CarteraNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure ParametrosEmpresas(perfil_usr,empresa_usr:String;Var Result:boolean);
  //Procedure AsignaParametrosEmpresas(PID:Double);  AHORA ESTA EN "DM_COMUN"
  //Procedure EliminaParametrosEmpresas(PID:Double); AHORA ESTA EN "DM_COMUN"

var
  FrmConsolidaEmpresa: TFrmConsolidaEmpresa;
  sEmpresa_prg  : String;
  sPerfil_prg   : String;
  sConsolida    : String;
  bClick_clasif : Boolean;

implementation

uses DM_Comun
    ,DM_Variables_Menu
    ,DM_Base_Datos;

{$R *.DFM}

procedure TFrmConsolidaEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   T_Clasif_Cartera.Close;
end;

procedure TFrmConsolidaEmpresa.SpeedButton1Click(Sender: TObject);
begin
  if ListSource.ItemIndex <> -1 then
  begin
    ListTarget.Items.Add(ListSource.Items[ListSource.ItemIndex]);
    ListSource.Items.Delete(ListSource.ItemIndex);
  end;
  bClick_clasif := False;
  Ed_TipoClasif_Cartera.Text := '';
  Ed_Clasificacion.Text      := '';
  Chk_ClasifCarteras.Checked := False;
  bClick_clasif := True;
end;

procedure TFrmConsolidaEmpresa.SpeedButton2Click(Sender: TObject);
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
  bClick_clasif := False;
  Ed_TipoClasif_Cartera.Text := '';
  Ed_Clasificacion.Text      := '';
  Chk_ClasifCarteras.Checked := False;
  bClick_clasif := True;
end;

procedure TFrmConsolidaEmpresa.ListSourceKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Trim(Key) = EmptyStr then
      SpeedButton1Click(Sender);
end;

procedure TFrmConsolidaEmpresa.ListTargetKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Trim(Key) = EmptyStr then
      SpeedButton2Click(Sender);
end;

Procedure ParametrosEmpresas(perfil_usr,empresa_usr:String;Var Result : Boolean);
Var
Empresa    : String;
cartera    : String;
sw_esta    : Boolean;
sHolding   : String;
i,k,p : Integer;
begin
  sEmpresa_prg := empresa_usr;
  sPerfil_prg  := perfil_usr;
  FrmConsolidaEmpresa := TFrmConsolidaEmpresa.Create(Application);
  With FrmConsolidaEmpresa,QRY_General do
  begin
       Sql.Clear;
       Sql.Add('SELECT  a.* '
              +'FROM qs_sys_perfil a '
              +'WHERE a.COD_PERFIL = '''+perfil_usr+''' '
              );
       Open;
       If not eof Then
       Begin
          sConsolida := FieldByname('CONSOLIDA').AsString;
          empresa := empresa_usr;
          If FieldByname('CONSOLIDA').AsString = 'HOLDING' Then       // POR HOLDING
          Begin
             Sql.Clear;
             Sql.Add(' SELECT a.CODIGO_HOLDING'
                    +'   FROM qs_sys_def_holding a'
                    +'  WHERE a.CODIGO_EMPRESA = :EMPRESA '
                    );
             ParamByName('EMPRESA').AsString := empresa_usr;
             Open;
             if eof then
             begin
               Application.MessageBox(pchar('Empresa '+empresa_usr+' no pertenece a ningun holding')
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
                    +'   AND a.CODIGO_EMPRESA = b.COD_EMPRESA '
                    );
             ParamByName('Codigo_Holding').AsString := sHolding;
             Open;
          End
          else
             If FieldByname('CONSOLIDA').AsString = 'EMPRESA' Then       // POR EMPRESA
              Begin
                 Sql.Clear;
                 Sql.Add(' SELECT a.COD_EMPRESA, a.COD_CARTERA '
                        +'   FROM qs_fin_carteras a '
                        +'  WHERE a.COD_EMPRESA = :empresa '
                        );
                 ParamByname('empresa').AsString := empresa;
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
        ParamByName('empresa').AsString := empresa_usr;
        Open;
     end;

     with TIniFile.Create(sArchivo_Ini) do
     begin
        ReadSectionValues('Parametros Empresa '+sEmpresa_Usuario,ListBox1.items);
        Free;
     end;

     if (ListBox1.items.count = 0) then
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
        first;
        while Not (EOF) do
        begin
           if empresa = Trim(FieldByname('COD_EMPRESA').AsString) then
           begin
              ListTarget.Items.Add(empresa +' - '+cartera);
              break;
           end;
           next;
        end;
     end;

     first;
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
     sEmpresa_prg := empresa_usr;
     Result:=True;
  end;
  FrmConsolidaEmpresa.Height := 383;
  FrmConsolidaEmpresa.Width  := 452;

  if FrmConsolidaEmpresa.ShowModal = mrOk then
  begin
     With FrmConsolidaEmpresa do
     begin
        if ListTarget.Items.Count = 0 then
           Result:=False;
     end;
  end
  else
    Result:=False;

end;

procedure TFrmConsolidaEmpresa.BTN_CancelarClick(Sender: TObject);
begin
   //Close;
end;

procedure TFrmConsolidaEmpresa.SpeedButton3Click(Sender: TObject);
begin
  if ListTarget.ItemIndex <> -1 then
  begin
    ListSource.Items.Add(ListTarget.Items[ListTarget.ItemIndex]);
    ListTarget.Items.Delete(ListTarget.ItemIndex);
  end;
  bClick_clasif := False;
  Ed_TipoClasif_Cartera.Text := '';
  Ed_Clasificacion.Text      := '';
  Chk_ClasifCarteras.Checked := False;
  bClick_clasif := True;
end;

procedure TFrmConsolidaEmpresa.SpeedButton4Click(Sender: TObject);
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
  bClick_clasif := False;
  Ed_TipoClasif_Cartera.Text := '';
  Ed_Clasificacion.Text      := '';
  Chk_ClasifCarteras.Checked := False;
  bClick_clasif := True;
end;

procedure TFrmConsolidaEmpresa.BTN_AceptarClick(Sender: TObject);
var i,p : Integer;
    Empresa,Cartera : String;
begin
   // Elimina lo existente
   With Qry_General do
   begin
      with TIniFile.Create(sArchivo_Ini) do
      begin
         EraseSection('Parametros Empresa '+sEmpresa_Usuario);
         Free;
      end;
      Sql.Clear;
      Sql.Add('DELETE FROM QS_SYS_PARAM_EMPRESA '
             +' WHERE pid     = :Pid'
             );
//      ParamByName('pid').asString     := IntToStr(Application.Handle);
      ParamByName('pid').AsFloat     := (Application.Handle);
      try
        ExecSQL;
      except
      end;
      Close;
   end;

   With Qry_General do
   Begin
     Sql.Clear;
     Sql.Add('INSERT INTO QS_SYS_PARAM_EMPRESA (pid,empresa,cartera) '
                               +'VALUES (:pid,:empresa,:cartera)    '
            );
   End;

   for i := 0 to ListTarget.Items.Count -1 do
   begin
      With Qry_General do
      Begin
        p := pos('-',ListTarget.Items[i]);
        Empresa    := Trim(Copy(ListTarget.Items[i], 1 ,p-1));
        Cartera    := Trim(Copy(ListTarget.Items[i], p+1 ,20));

        with TIniFile.Create(sArchivo_Ini) do
        begin
           WriteString('Parametros Empresa '+sEmpresa_Usuario,'Empresa'+inttostr(i),Empresa+' - '+ cartera);
           Free;
        end;

//        if not (dmBaseDatos.Conexion_BaseDatos.InTransaction) then
//             dmBaseDatos.Conexion_BaseDatos.StartTransaction;

        // ParamByName('pid').AsString      := IntToStr(Application.Handle);

        ParamByName('pid').Asfloat       := Application.Handle;
        ParamByName('empresa').AsString  := Empresa;
        ParamByName('cartera').AsString  := Cartera;
        try
           ExecSQL;
        except
          begin
            Application.MessageBox(pchar('Error al Insertar table QS_SYS_PARAM_EMPRESA')
                                  ,'Consolidado'
                                  , mb_OK);
//            if dmBaseDatos.Conexion_BaseDatos.InTransaction then
//               dmBaseDatos.Conexion_BaseDatos.RollBack;
            end;
        end;
//        if (dmBaseDatos.Conexion_BaseDatos.InTransaction) then
//           dmBaseDatos.Conexion_BaseDatos.Commit;
        Close;
      End;
   end;
   if Chk_ClasifCarteras.Checked then
   begin
      With Qry_General do
      Begin
//        if not (dmBaseDatos.Conexion_BaseDatos.InTransaction)  then
//          dmBaseDatos.Conexion_BaseDatos.StartTransaction;

//        ParamByName('pid').AsString      := IntToStr(Application.Handle);
        ParamByName('pid').AsFloat      := (Application.Handle);
        ParamByName('empresa').AsString  := Ed_TipoClasif_Cartera.Text;
        //ggarcia 09-12-2016
        //ParamByName('cartera').AsString  := Ed_Clasificacion.Text;
        ParamByName('cartera').AsString  := copy(Ed_Clasificacion.Text,1,10);
        try
           ExecSQL;
        except
//          if (dmBaseDatos.Conexion_BaseDatos.InTransaction) then
//           dmBaseDatos.Conexion_BaseDatos.RollBack;
        end;
//        if (dmBaseDatos.Conexion_BaseDatos.InTransaction) then
//           dmBaseDatos.Conexion_BaseDatos.Commit;
        Close;
      End;
   end;
   //Close;
   sGrupo_Cartera := Ed_TipoClasif_Cartera.Text;
end;

procedure TFrmConsolidaEmpresa.Ed_TipoClasif_CarteraCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
   with  Qry_Clasificacion do
   begin
      Close;
      Sql.Clear;
      Sql.Add(' SELECT * FROM qs_sys_est_cla'
             +'  WHERE CODIGO_OBJETO = :codigo'
             );
      ParamByname('codigo').AsString := Ed_TipoClasif_Cartera.text;
      Open;
   end;
end;
procedure TFrmConsolidaEmpresa.FormShow(Sender: TObject);
begin
   T_Clasif_Cartera.Open;
   bClick_clasif := True;
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionCloseUp(
  Sender: TObject);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Chk_ClasifCarterasClick(Sender: TObject);
var p :Integer;
begin
//  SpeedButton4Click(Sender);
if Not bClick_clasif then
   exit;

  if ListTarget.Items.Count <> 0 then
     ListTarget.ItemIndex := 0;

  while ListTarget.ItemIndex <> -1 do
  begin
     ListSource.Items.Add(ListTarget.Items[ListTarget.ItemIndex]);
     ListTarget.Items.Delete(ListTarget.ItemIndex);

     if ListTarget.Items.Count <> 0 then
        ListTarget.ItemIndex := 0;
  end;


  If Chk_ClasifCarteras.State = cbChecked then
  begin
     if Trim(sConsolida) = 'HOLDING' then
     begin
       With QRY_General do
       begin
          Sql.Clear;
          Sql.Add(' SELECT z.COD_CARTERA'
                 +'   FROM QS_FIN_CARTERAS z'
                 +'       ,qs_sys_clasif_obj a'
                 +'       ,qs_sys_est_cla b'
                 +'       ,QS_SYS_DEF_HOLDING c'                   // E.S. 12-05-2014, para asegurarme de que traiga carteras que existan en holding
                 +'  WHERE a.objeto           = ''CARTERA'' '
                 +'    AND a.codigo_clasif    = :Codigo_Clasif '
                 +'    AND a.elemento         = z.cod_cartera'
                 +'    AND b.codigo_objeto    = a.codigo_clasif'
                 +'    AND b.descripcion_nodo = :clasificacion'
                 +'    AND b.nodo             = a.nodo'
                 +'    AND c.CODIGO_EMPRESA = z.COD_EMPRESA' );     // E.S. 12-05-2014, para asegurarme de que traiga carteras que existan en holding
  //ES 17-03-2014               +'    AND z.cod_empresa      = :Empresa');
  //ES 17-03-2014        ParamByName('empresa').asString       := sEmpresa_prg;
          ParamByName('Codigo_Clasif').asString := Ed_TipoClasif_Cartera.Text;
          ParamByName('clasificacion').asString := Ed_Clasificacion.Text;
          Open;
       end;

     end
     else
     begin
       With QRY_General do
       begin
          Sql.Clear;
          Sql.Add(' SELECT z.COD_CARTERA'
                 +'   FROM QS_FIN_CARTERAS z'
                 +'       ,qs_sys_clasif_obj a'
                 +'       ,qs_sys_est_cla b'
                 +'  WHERE a.objeto           = ''CARTERA'' '
                 +'    AND a.codigo_clasif    = :Codigo_Clasif '
                 +'    AND a.elemento         = z.cod_cartera'
                 +'    AND b.codigo_objeto    = a.codigo_clasif'
                 +'    AND b.descripcion_nodo = :clasificacion'
                 +'    AND b.nodo             = a.nodo'
                 +'    AND z.cod_empresa      = :Empresa');

          ParamByName('empresa').asString       := sEmpresa_prg;
          ParamByName('Codigo_Clasif').asString := Ed_TipoClasif_Cartera.Text;
          ParamByName('clasificacion').asString := Ed_Clasificacion.Text;
          Open;
       end;
     end;

     while Not (QRY_General.EOF) do
     begin
        if ListSource.Items.Count <> 0 then
           ListSource.ItemIndex := 0;
        if ListTarget.Items.Count <> 0 then
           ListTarget.ItemIndex := 0;

        while ListSource.ItemIndex <> -1 do
        begin
           if ListTarget.ItemIndex <> -1 then
           begin
              p := pos('-',ListTarget.Items[ListTarget.Itemindex]);
              if QRY_General.FieldByName('COD_CARTERA').AsString = Trim(Copy(ListTarget.Items[ListTarget.Itemindex], p+1 ,20)) then //ListTarget.Items[ListTarget.Itemindex] then
              begin
                 ListSource.ItemIndex := -1;
                 continue;
              end;
           end;

           p := pos('-',ListSource.Items[ListSource.Itemindex]);
           if Trim(Copy(ListSource.Items[ListSource.Itemindex], p+1 ,20)) = QRY_General.FieldByName('COD_CARTERA').AsString then
           begin
              ListTarget.Items.Add(ListSource.Items[ListSource.ItemIndex]);
              ListSource.Items.Delete(ListSource.ItemIndex);
              ListSource.ItemIndex := -1;
              continue;
           end;
           ListSource.ItemIndex := ListSource.ItemIndex + 1;
           ListTarget.ItemIndex := ListTarget.ItemIndex + 1;
        end;
        QRY_General.Next;
        if ListSource.Items.Count <> 0 then
           ListSource.ItemIndex := 0;
     end;
  end
  else    // if cbChecked
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
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionExit(
  Sender: TObject);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionDropDown(Sender: TObject);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionEndDrag(Sender,
  Target: TObject; X, Y: Integer);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionClick(Sender: TObject);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Ed_ClasificacionStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
   Screen.Cursor := crDefault;
end;

procedure TFrmConsolidaEmpresa.Ed_TipoClasif_CarteraChange(Sender: TObject);
begin
  Qry_Clasificacion.Close;
  Qry_Clasificacion.ParamByName('Codigo_Objeto').AsString := Ed_TipoClasif_Cartera.text;
  Qry_Clasificacion.Open;

end;

procedure TFrmConsolidaEmpresa.Ed_TipoClasif_CarteraNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
     if not (NewValue = '') then
          begin
            Application.MessageBox('¡Código Tipo Clasificación Incorrecto!'
                            ,'Selección de Carteras'
                            ,mb_OK);
            Ed_TipoClasif_Cartera.Text := '';
            exit;
          end;
end;

end.




