unit Frm_DatosLimites;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, DB, DBTables, Wwtable, Wwdatsrc, ComCtrls,
  Tabnotbk, Wwquery, ExtCtrls, StdCtrls, wwdblook, Mask,  ShellApi,
  Wwdbedit, Wwdotdot, Buttons, OvcBase, RXSplit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDesgn, vcl.wwintl;

type
  TFrmDatosLimites = class(TForm)
    Panel1: TPanel;
    wwDataLimitesDet: TwwDataSource;
    Grid_Detalle: TwwDBGrid;
    DataLimites: TwwDataSource;
    DataGrupo: TDataSource;
    Data_InfPorGrupo: TDataSource;
    Data_InfPorEmisor: TDataSource;
    Data_InfEmisorInstSerie: TDataSource;
    Panel2: TPanel;
    Rg_Reportes: TRadioGroup;
    Panel5: TPanel;
    Panel4: TPanel;
    Label6: TLabel;
    Ed_TipoLimite: TwwDBLookupCombo;
    Chk_TipoLimites: TCheckBox;
    BitBtn2: TBitBtn;
    Grid_Encabezado: TwwDBGrid;
    RxSplitter1: TRxSplitter;
    BTN_Imprimir: TBitBtn;
    GroupBox1: TGroupBox;
    Label13: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    edMonedaChk: TCheckBox;
    edNemotecnicoCHK: TCheckBox;
    edSerieCHK: TCheckBox;
    edInstrumentoCHK: TCheckBox;
    edEmisorCHK: TCheckBox;
    edEmisor: TwwDBComboDlg;
    edInstrumento: TwwDBLookupCombo;
    edSerie: TEdit;
    edNemotecnico: TwwDBComboDlg;
    edMoneda: TwwDBLookupCombo;
    edClasificacion: TwwDBLookupCombo;
    Chk_Clasif: TCheckBox;
    BTN_Seleccionar: TBitBtn;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    btnCC: TSpeedButton;
    Qry_General: TFDQuery;
    Qry_General2: TFDQuery;
    Qry_Limite_Det: TFDQuery;
    T_Instrumentos: TFDQuery;
    T_Clasif: TFDQuery;
    T_ClasifCOD_DETAIL: TStringField;
    T_ClasifDESC_DETAIL: TStringField;
    T_ClasifCOD_GENERAL: TStringField;
    T_Moneda: TFDQuery;
    Qry_Limite: TFDQuery;
    Qry_EmisorInstrum: TFDQuery;
    Qry_EmisorInstrumMatriz: TStringField;
    Qry_EmisorInstrumFilial: TStringField;
    Qry_EmisorInstrumInstrumento: TStringField;
    Qry_EmisorInstrumPorcentaje: TFloatField;
    Qry_EmisorInstrumMaximo_Permitido: TFloatField;
    Qry_EmisorInstrumVALOR_PTE_CARTERA: TFloatField;
    Qry_EmisorInstrumMargen_Permitido: TFloatField;
    Qry_Grupo: TFDQuery;
    Qry_GrupoGrupo_Emisor: TStringField;
    Qry_GrupoEmisor: TStringField;
    Qry_GrupoPorcentaje: TFloatField;
    Qry_GrupoMaximo_Permitido: TFloatField;
    Qry_GrupoVALOR_PTE_CARTERA: TFloatField;
    Qry_GrupoMargen_Permitido: TFloatField;
    Qry_EmisorInstSerie: TFDQuery;
    Qry_EmisorInstSerieEmisor: TStringField;
    Qry_EmisorInstSerieInstrumento: TStringField;
    Qry_EmisorInstSeriePorcentaje: TFloatField;
    Qry_EmisorInstSerieNominales: TFloatField;
    Qry_EmisorInstSerieMaximo_Permitido: TFloatField;
    Qry_EmisorInstSerieMargen_Permitido: TFloatField;
    Qry_EmisorInstSerieSeries_Inscritas: TStringField;
    T_TipoLimites: TFDQuery;
    T_DatosGrupo: TFDMemTable;
    T_DatosGrupoTipo_Inversion: TStringField;
    T_DatosGrupoCODIGO_RTPR: TStringField;
    T_DatosGrupoDescripcion: TStringField;
    T_DatosGrupoPor_Intrum_251: TFloatField;
    T_DatosGrupoPor_Conj_251: TFloatField;
    T_DatosGrupoPor_Emisor_251: TFloatField;
    T_DatosGrupoPorcen_Intrum: TStringField;
    T_DatosGrupoPorcen_Conj: TStringField;
    T_DatosGrupoPorcen_Emisor: TStringField;
    T_DatosGrupoMax_Intrum_251: TFloatField;
    T_DatosGrupoMax_Emisor_251: TFloatField;
    T_DatosGrupoMax_Conj_251: TFloatField;
    FDQuery1: TFDQuery;
    FDQuery1CODIGO_LIMITE: TStringField;
    FDQuery1TIPO_LIMITE: TStringField;
    FDQuery1EMISOR: TStringField;
    FDQuery1INSTRUMENTO: TStringField;
    FDQuery1NEMOTECNICO: TStringField;
    FDQuery1DESC_DETAIL: TStringField;
    FDQuery1MATRIZ: TStringField;
    FDQuery1PORCENTAJE_MIN: TFloatField;
    FDQuery1PORCENTAJE: TFloatField;
    FDQuery1VALOR_PTE_CARTERA: TFloatField;
    FDQuery1MINIMO_PERMITIDO: TFloatField;
    FDQuery1MAXIMO_PERMITIDO: TFloatField;
    FDQuery1Margen: TFloatField;
    FDQuery1SERIES_INSCRITAS: TStringField;
    FDQuery1GRUPO_EMISOR: TStringField;
    FDQuery1MONEDA_INSTRUM: TStringField;
    FDQuery1EMPRESA: TStringField;
    FDQuery1CARTERA: TStringField;
    FDQuery1FECHA_PROCESO: TSQLTimeStampField;
    FDQuery1PROCESO: TStringField;
    FDQuery2: TFDQuery;
    FDQuery2Cartera: TStringField;
    FDQuery2Folio_interno: TStringField;
    FDQuery2Item_OMD: TFloatField;
    FDQuery2Transaccion: TStringField;
    FDQuery2Emisor: TStringField;
    FDQuery2Instrumento: TStringField;
    FDQuery2Serie: TStringField;
    FDQuery2Nemotecnico: TStringField;
    FDQuery2Moneda_Instrum: TStringField;
    FDQuery2Valor_Nominal: TFloatField;
    FDQuery2Valor_Pte_mc_Cpa: TFloatField;
    FDQuery2Clasif_Riesgo: TStringField;
    FDQuery2CLASIF_LIMITE: TStringField;
    FDQuery2Codigo_RTPR: TStringField;
    FDQuery2Codigo_Limite: TStringField;
    FDQuery2Matriz: TStringField;
    FDQuery2Empresa: TStringField;
    FDMemTable1: TFDMemTable;
    FDMemTable1CODIGO_LIMITE: TStringField;
    FDMemTable1TIPO_LIMITE: TStringField;
    FDMemTable1EMISOR: TStringField;
    FDMemTable1INSTRUMENTO: TStringField;
    FDMemTable1NEMOTECNICO: TStringField;
    FDMemTable1DESC_DETAIL: TStringField;
    FDMemTable1MATRIZ: TStringField;
    FDMemTable1PORCENTAJE_MIN: TFloatField;
    FDMemTable1PORCENTAJE: TFloatField;
    FDMemTable1VALOR_PTE_CARTERA: TFloatField;
    FDMemTable1MINIMO_PERMITIDO: TFloatField;
    FDMemTable1MAXIMO_PERMITIDO: TFloatField;
    FDMemTable1MARGEN: TFMTBCDField;
    FDMemTable1SERIES_INSCRITAS: TStringField;
    FDMemTable1MONEDA_INSTRUM: TStringField;
    FDMemTable1EMPRESA: TStringField;
    FDMemTable1CARTERA: TStringField;
    FDMemTable1FECHA_PROCESO: TDateTimeField;
    FDMemTable1PROCESO: TStringField;
    FDMemTable1GRUPO_EMISOR: TStringField;
    GroupBox2: TGroupBox;
    Check_Detallado: TCheckBox;
    Check_TInversion: TCheckBox;
    check_Empresariales: TCheckBox;
    Check_Emisor1: TCheckBox;
    Check_Emisior2: TCheckBox;
    Check_Emisor3: TCheckBox;
    Check_Marcar: TCheckBox;
    Check_UnLibro: TCheckBox;
    CheckBox1: TCheckBox;
    Check_Todos: TCheckBox;
    Qry_Todos_Reg: TFDQuery;
    Check_Det_Excesos: TCheckBox;
    wwIntl1: TwwIntl;
    FDMemTable1CREDENCIAL_DEUDOR: TStringField;
    FDMemTable1NOMBRE_DEUDOR: TStringField;
    Qry_Detalle: TFDQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    StringField8: TStringField;
    FloatField6: TFloatField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    DateTimeField1: TDateTimeField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    StringField18: TStringField;
    Check_Nom_Val: TCheckBox;
    FDMemTable1ID_CREDITO: TStringField;
    Qry_DetalleID_CREDITO: TStringField;
    FDQuery3: TFDQuery;
    StringField19: TStringField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    StringField24: TStringField;
    StringField25: TStringField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    StringField26: TStringField;
    FloatField12: TFloatField;
    StringField27: TStringField;
    StringField28: TStringField;
    StringField29: TStringField;
    StringField30: TStringField;
    DateTimeField2: TDateTimeField;
    StringField31: TStringField;
    StringField32: TStringField;
    StringField33: TStringField;
    StringField34: TStringField;
    StringField35: TStringField;
    StringField36: TStringField;
    StringField37: TStringField;
    StringField38: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TransparentButton1Click(Sender: TObject);
    procedure BTN_SeleccionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edEmisorCustomDlg(Sender: TObject);
    procedure edNemotecnicoCustomDlg(Sender: TObject);
    procedure edEmisorChange(Sender: TObject);
    procedure edInstrumentoChange(Sender: TObject);
    procedure edSerieChange(Sender: TObject);
    procedure edMonedaChange(Sender: TObject);
    procedure edClasificacionChange(Sender: TObject);
    procedure Grid_EncabezadoDblClick(Sender: TObject);
    procedure Grid_EncabezadoCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure Ed_TipoLimiteChange(Sender: TObject);
    procedure BTN_ImprimirClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DataLimitesDataChange(Sender: TObject; Field: TField);
    procedure Qry_LimiteCalcFields(DataSet: TDataSet);
    procedure Qry_GrupoCalcFields(DataSet: TDataSet);
    procedure Qry_EmisorInstSerieCalcFields(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure Check_MarcarClick(Sender: TObject);
    procedure Seleccion_Excesos;
  private
    { Private declarations }
    procedure Seleccion_Detalle;
  public
    { Public declarations }
    dFecha_Proceso : TDatetime;
    bImprimir,
    bSBS           : Boolean;
  end;

var
  FrmDatosLimites: TFrmDatosLimites;

implementation
uses DM_Variables_Menu,
     DM_Ayuda_Tipo_Empresas,
     DM_Ayuda_Nemotecnicos,
     DM_Comun,
     DM_Base_Datos,
     DM_Identidad_Direccion,
     RPreview,
     Frm_CalculoLimites,
     FRM_ReportLImitesDetalle,
     Frm_ReportPorGrupo,
     Frm_ReportLimites,
     Frm_ReportPorEmisorInstrumentoSeries,
     Frm_ReportLimitesGrupo,
     Frm_ReportPorEmisorInstrumento;

{$R *.DFM}

procedure TFrmDatosLimites.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   T_Moneda.Close;
   T_Instrumentos.Close;
   T_Clasif.Close;
   T_TipoLimites.Close;
   T_DatosGrupo.Close;
   Action := Cafree;
end;

procedure TFrmDatosLimites.TransparentButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmDatosLimites.BTN_SeleccionarClick(Sender: TObject);
var
   sString_Carteras,
   sString_Empresas : string;
begin
  sString_Empresas := '';
  sString_Carteras := '';
  if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
  begin
    With Qry_General do
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
          sString_Empresas := sString_Empresas +' ( '''+Fieldbyname('Empresa').asString;
          Next;
          While Not Eof do
          begin
             sString_Empresas := sString_Empresas + ''','''+Fieldbyname('Empresa').asString;
             Next;
          end;
          sString_Empresas := sString_Empresas +''' )';
       end
       else
          sString_Empresas := '( '''+sEmpresa_Usuario+''' )';

       Close;
       Sql.Clear;
       SQL.Add(' SELECT z.Cartera FROM QS_SYS_PARAM_EMPRESA z'
              +' WHERE z.Empresa IN '+ sString_Empresas
              +'   AND z.Pid     = :Pid'
              );
       Parambyname('Pid').asFloat := Application.Handle;
       Open;
       if Not Fieldbyname('Cartera').IsNull then
       begin
          if NOT EOF then
             sString_Carteras := sString_Carteras +' ( '''+Fieldbyname('Cartera').asString;
          Next;
          While Not Eof do
          begin
             sString_Carteras := sString_Carteras +''','''+Fieldbyname('Cartera').asString;
             Next;
          end;
          sString_Carteras := sString_Carteras + ''' )';
       end
       else
          sString_Carteras := '';
    end;
  end;

  with Qry_Limite_Det do
  begin
     Close;
     SQL.Clear;
     //Esto es para Instrumentos con Descriptor
     SQL.Add('SELECT b.Cartera '
            +'      ,b.Folio_interno '
            +'      ,b.Item_omd   '
            +'      ,b.Transaccion '
            +'      ,b.Emisor  '
            +'      ,b.Instrumento '
            +'      ,b.Serie '
            +'      ,b.Nemotecnico '
            +'      ,b.Moneda_Instrum '
            +'      ,b.Valor_Nominal '
            +'      ,b.Valor_Pte_mc_Cpa '
            +'      ,b.Clasif_Riesgo  '
            +'      ,b.CLASIF_LIMITE '
            +'      ,b.Codigo_RTPR  '
            +'      ,b.Codigo_Limite  '
            +'      ,b.Matriz   '
            +'      ,b.Empresa  '
            +'  FROM QS_SUP_251_DET b'
            +' WHERE b.Empresa       = :Empresa '
            +'  AND  b.Proceso       = :Proceso'
            +'  AND  b.Fecha_Proceso = :Fecha_Proceso'
            +'  AND  b.Codigo_Limite = :Codigo_Limite'
            );
     if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
     begin
//       sql.add('    AND b.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
//       sql.add('                      WHERE  pid = :pid ');
//       sql.add('                         and z.empresa = b.empresa ');
//       sql.add('                     ) ');
//       sql.add('    AND b.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
//       sql.add('                      WHERE pid = :pid ');
//       sql.add('                        and z.cartera = b.cartera ');
//       sql.add('                 ) ');
      sql.add('    AND b.empresa in '+sString_Empresas );
      sql.add('    AND b.cartera in '+sString_Carteras );
//       ParamByName('pid').AsFloat := Application.Handle;
     end
     else
     begin
        sql.add('AND b.EMPRESA   = :EMPRESA ');
        sql.add('AND b.CARTERA   = :CARTERA ');
        ParamByname('Empresa').asString  := sEmpresa_Usuario;
        ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
     end;

     if Qry_Limite.Fieldbyname('Grupo_Emisor').asString <> '' then
     begin
       SQL.Add(' AND b.Grupo_Emisor = :Grupo_Emisor');
       ParamByName('Grupo_Emisor').asString := Qry_Limite.Fieldbyname('Grupo_Emisor').asString;
     end;

     // SI TIENE MATRIZ DEFINIDO SOLO FILTRO POR MATRIZ y NO POR EMISOR
     if Qry_Limite.Fieldbyname('Matriz').asString <> '' then
     begin
       SQL.Add(' AND (b.Matriz = :Matriz  OR  b.Emisor = :Emisor )');
       ParamByName('Matriz').asString := Qry_Limite.Fieldbyname('Matriz').asString;
       ParamByName('Emisor').asString := Qry_Limite.Fieldbyname('Emisor').asString;
     end
     else
     if Qry_Limite.Fieldbyname('Emisor').asString <> '' then
     begin
       SQL.Add(' AND b.Emisor      = :Emisor' );
       ParamByName('Emisor').asString  := Qry_Limite.Fieldbyname('Emisor').asString;
     end;

     if Qry_Limite.Fieldbyname('Instrumento').asString <> '' then
     begin
       SQL.Add(' AND b.Instrumento = :Instrumento');
       ParamByName('Instrumento').asString := Qry_Limite.Fieldbyname('Instrumento').asString;
     end;

     if Qry_Limite.Fieldbyname('Nemotecnico').asString <> '' then
     begin
       SQL.Add(' AND b.Nemotecnico = :Nemotecnico');
       ParamByName('Nemotecnico').asString := Qry_Limite.Fieldbyname('Nemotecnico').asString;
     end;

     if (Qry_Limite.Fieldbyname('Series_Inscritas').asString <> '') and (Qry_Limite.Fieldbyname('Tipo_Limite').asString <> 'INSTRUMENT') then
     begin
       SQL.Add(' AND b.Series_Inscritas = :Series_Inscritas');
       ParamByName('Series_Inscritas').asString := Qry_Limite.Fieldbyname('Series_Inscritas').asString;
     end;

     if Qry_Limite.Fieldbyname('Moneda_Instrum').asString <> '' then
     begin
       SQL.Add(' AND b.Moneda_Instrum = :Moneda_Instrum');
       ParamByName('Moneda_Instrum').asString := Qry_Limite.Fieldbyname('Moneda_Instrum').asString;
     end;

     if Qry_Limite.Fieldbyname('TIPO_CLASIF').asString <> '' then
     begin
       SQL.Add(' AND b.TIPO_CLASIF = :TIPO_CLASIF'
              +' AND b.grupo_clasif = :grupo_clasif ');
       ParamByName('TIPO_CLASIF').asString  := Qry_Limite.Fieldbyname('TIPO_CLASIF').asString;
       ParamByName('grupo_clasif').asString := Qry_Limite.Fieldbyname('grupo_clasif').asString;
     end;

     if edEmisorCHK.Checked then
     begin
        SQL.Add(' AND b.Emisor LIKE :Emisor');
        ParamByName('Emisor').AsString := edEmisor.text;
     end;

     if edInstrumentoCHK.Checked then
     begin
        SQL.Add(' AND b.Instrumento LIKE :Instrumento');
        ParamByName('Instrumento').AsString := edInstrumento.text;
     end;

     if edSerieCHK.Checked then
     begin
       SQL.Add(' AND b.Serie LIKE :Serie');
       ParamByName('Serie').AsString := edSerie.text;
     end;

     if edNemotecnicoCHK.Checked then
     begin
       SQL.Add(' AND b.Nemotecnico LIKE :Nemotecnico');
       ParamByName('Nemotecnico').AsString := edNemotecnico.text;
     end;

     if edMonedaCHK.Checked then
     begin
       SQL.Add(' AND b.Moneda_Instrum LIKE :Moneda');
       ParamByName('Moneda').AsString := edMoneda.text;
     end;

     if Chk_Clasif.Checked then
     begin
       SQL.Add(' AND b.Clasif_Riesgo LIKE :Clasif_Riesgo');
       ParamByName('Clasif_Riesgo').AsString := edClasificacion.text;
     end;
     Sql.Add(' ORDER BY b.Cartera'
            +'         ,b.Transaccion'
            +'         ,b.Folio_Interno'
            +'         ,b.Item_Omd'
            +'         ,b.Codigo_RTPR'
            +'         ,b.Codigo_Limite'
            );
     ParamByName('Empresa').AsString         := sEmpresa_usuario;
     ParamByName('Fecha_Proceso').asDatetime := dFecha_Proceso;
     ParamByName('Codigo_Limite').AsString   := Qry_Limite.Fieldbyname('Codigo_Limite').asString;
     ParamByname('Proceso').asString         := Qry_Limite.Fieldbyname('Proceso').asString;

//     if bdesarrollo then
//        sql.savetofile('c:\tmp.sql');
     Open;
  end;
  BTN_Imprimir.Enabled := True;
end;

procedure TFrmDatosLimites.Check_MarcarClick(Sender: TObject);
begin
  if Check_Marcar.Checked then
  begin
    Check_Detallado.Checked := True;
    Check_TInversion.Checked := True;
    check_Empresariales.Checked := True;
    Check_Emisor1.Checked := True;
    Check_Emisior2.Checked := True;
    Check_Emisor3.Checked := True;
    CheckBox1.Checked := True;
    Check_Todos.Checked := True;
    Check_UnLibro.Checked := True;
    Check_Det_Excesos.Checked := True;
    Check_Nom_Val.Checked := True;
  end
  else
  begin
    Check_Detallado.Checked := False;
    Check_TInversion.Checked := False;
    check_Empresariales.Checked := False;
    Check_Emisor1.Checked := False;
    Check_Emisior2.Checked := False;
    Check_Emisor3.Checked := False;
    CheckBox1.Checked := False;
    Check_Todos.Checked := False;
    Check_UnLibro.Checked := False;
    Check_Det_Excesos.Checked := False;
    Check_Nom_Val.Checked := False;
  end;

end;

procedure TFrmDatosLimites.FormShow(Sender: TObject);
begin
  T_Moneda.Open;
  T_Clasif.Open;
  T_Instrumentos.Open;
  T_TipoLimites.Open;
  dFecha_Proceso := FrmCalculoLimites.dFecha_Cierre;  //FrmCalculoLimites.Ed_Fecha.Date;

  bSBS := Transaccion_implica( 'LIMITES', 'SBS');
  With T_DatosGrupo.FieldDefs do
  begin
     Clear;
     Add( 'Tipo_Inversion' , ftString,   1,  False  );
     Add( 'CODIGO_RTPR'    , ftString,  10,  False  );
     Add( 'Descripcion'    , ftString, 100,  False  );
     Add( 'Por_Intrum_251' , ftFloat ,   0,  False  );
     Add( 'Max_Intrum_251' , ftFloat ,   0,  False  );
     Add( 'Porcen_Intrum'  , ftString,   4,  False  );
     Add( 'Por_Conj_251'   , ftFloat ,   0,  False  );
     Add( 'Max_Conj_251'   , ftFloat ,   0,  False  );
     Add( 'Porcen_Conj'    , ftString,   4,  False  );
     Add( 'Por_Emisor_251' , ftFloat ,   0,  False  );
     Add( 'Max_Emisor_251' , ftFloat ,   0,  False  );
     Add( 'Porcen_Emisor'  , ftString,   4,  False  );
  end;
  T_DatosGrupo.CreateDataSet;
  T_DatosGrupo.Open;

  With Qry_Limite do
  begin
     Sql.Clear;
     Sql.Add(' SELECT a.* '
            +'       ,b.DESCRIPCION_NODO AS desc_detail '
            +'       ,(a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) as Margen '
            +'       ,a.CREDENCIAL_DEUDOR '
            +'       ,a.NOMBRE_DEUDOR '
            +'       ,a.ID_CREDITO '
            +'   FROM QS_SUP_251     a '
            +'        LEFT JOIN QS_SYS_EST_CLA b '
            +'               ON b.codigo_objeto = a.tipo_clasif'
            +'              AND b.nodo          = a.grupo_clasif '
            +'  WHERE a.Empresa        = :Empresa'
            +'    AND a.Fecha_Proceso  = :Fecha_Proceso'
            +'    AND a.Proceso        = :Proceso'
            +'    AND a.Tipo_Clasif IS NOT NULL '
            );
     if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
     begin
       sql.add('    AND a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
       sql.add('                       WHERE  pid = :pid ');
       sql.add('                         and z.empresa = a.empresa ');
       sql.add('                     ) ');
       sql.add('    AND a.cartera  = :Cartera' );
       ParamByName('pid').AsFloat := Application.Handle;
     end
     else
     begin
        sql.add('AND a.EMPRESA   = :EMPRESA ');
        sql.add('AND a.CARTERA   = :CARTERA ');
     end;
     sql.Add(' UNION ');
     Sql.Add(' SELECT a.*   '
            +'       ,b.desc_detail '
            +'       ,(a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) as Margen'
            +'       ,a.CREDENCIAL_DEUDOR '
            +'       ,a.NOMBRE_DEUDOR '
            +'       ,a.ID_CREDITO '
            +'   FROM QS_SUP_251     a '
            +'        LEFT JOIN QS_SYS_COD_DET b '
            +'               ON b.Cod_General = ''GRUPOSEMP'' '
            +'              AND b.COd_Detail  = a.GRUPO_EMISOR '
            +'  WHERE a.Empresa        = :Empresa'
            +'    AND a.Fecha_Proceso  = :Fecha_Proceso'
            +'    AND a.Proceso        = :Proceso'
            +'    AND a.Tipo_Clasif IS NULL '
            );
     if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
     begin
       sql.add('    AND a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
       sql.add('                       WHERE  pid = :pid ');
       sql.add('                         and z.empresa = a.empresa ');
       sql.add('                     ) ');
       sql.add('    AND a.cartera  = :Cartera' );
       ParamByName('pid').AsFloat := Application.Handle;
     end
     else
     begin
        sql.add('AND a.EMPRESA   = :EMPRESA ');
        sql.add('AND a.CARTERA   = :CARTERA ');
     end;
     {
     Sql.Add(' ORDER BY TIPO_LIMITE '
            +'         ,CODIGO_LIMITE '
            +'         ,EMISOR '
            +'         ,INSTRUMENTO '
            +'         ,GRUPO_EMISOR '
            );
           }
     ParamByname('Empresa').asString         := sEmpresa_Usuario;
     ParamByname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
     ParamByname('Proceso').asString         := FrmCalculoLimites.Ed_Proceso.Text;
     ParamByname('Fecha_Proceso').asDatetime := dFecha_Proceso;

     if bdesarrollo then
        sql.savetofile('c:\temp\QRY_LIMITE.sql');

     Open;
  end;

  Qry_Limite.FieldByName('Margen').DisplayWidth := 20;
  Qry_Limite.FieldByName('DESC_DETAIL').DisplayWidth := 30;
  Qry_Limite.FieldByName('SERIES_INSCRITAS').DisplayWidth := 57;

  if sPais_Usuario <> 'CL' then
  begin
     Rg_Reportes.items.delete(1);
     Rg_Reportes.items.delete(1);
     Rg_Reportes.items.delete(1);
     Rg_Reportes.items.delete(1);
     Rg_Reportes.items.delete(1);
  end;
  bImprimir := False;

  BTN_SeleccionarClick(Sender);
end;

procedure TFrmDatosLimites.edEmisorCustomDlg(Sender: TObject);
var Result           : Boolean;
    sEmisor          : String;
    dFecha_Operacion : TDateTime;
begin
   dfecha_Operacion := EncodeDate(1980,01,01);
   Ayuda_Tipo_Empresa(sEmisor,
                      'EMI',
                      dFecha_Operacion,
                      Result);
   if Result then
      edEmisor.text := sEmisor;
end;

procedure TFrmDatosLimites.edNemotecnicoCustomDlg(Sender: TObject);
var
 sNemotecnico : String;
 sEmisor      : String;
 Result       : Boolean;
begin
   sNemotecnico := edNemotecnico.text;
   if edEmisorCHK.Checked then
      sEmisor := edEmisor.text
   else
      sEmisor := ' ';
   Ayuda_Nemotecnico(sNemotecnico,
                     sEmisor,
                     Result);
   if Result then
      edNemotecnico.text := sNemotecnico;
end;

procedure TFrmDatosLimites.edEmisorChange(Sender: TObject);
begin
   edEmisorCHK.Checked := True;
end;

procedure TFrmDatosLimites.edInstrumentoChange(Sender: TObject);
begin
   edInstrumentoCHK.Checked := True;
end;

procedure TFrmDatosLimites.edSerieChange(Sender: TObject);
begin
   edSerieCHK.Checked := True;
end;

procedure TFrmDatosLimites.edMonedaChange(Sender: TObject);
begin
   edMonedaCHK.Checked := True;
end;

procedure TFrmDatosLimites.edClasificacionChange(Sender: TObject);
begin
   Chk_Clasif.Checked := True;
end;

procedure TFrmDatosLimites.Grid_EncabezadoDblClick(Sender: TObject);
begin
   BTN_SeleccionarClick(Sender);
end;

procedure TFrmDatosLimites.Grid_EncabezadoCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
   if Grid_Encabezado.DataSource.Dataset.FieldbyName('Margen').AsFloat < 0 then
     Grid_Encabezado.Canvas.Brush.Color := clRed;
//   if (Field.FieldName = 'Margen' ) and
//      (Field.asFloat  < 0 ) then
//   begin
//    // AFont.Color  := clred;
//     Grid_Encabezado.Canvas.Brush.Color := clRed;
////     AFont.Size   := 9;
////     ABrush.Color := clSilver;
//   end;


end;

procedure TFrmDatosLimites.Ed_TipoLimiteChange(Sender: TObject);
begin
   Chk_TipoLimites.Checked := True;
end;

procedure TFrmDatosLimites.BTN_ImprimirClick(Sender: TObject);
var fValor_Cartera
   ,fMaximo_Permitido
   ,fPorcentaje : Double;
   i,
   iRegistro    : Integer;
   sTipo_Limite,
   sCodigo_RTPR : String;
   bInsertar    : Boolean;

   sRazon_Social,
   sDireccion,
   sUbicacion         : String;
   Result             : Boolean;
   Label_Razon_Social,
   Label_Direccion,
   Lbl_Titulo,
   Label_Ubicacion    : TfrxMemoView;
   GroupFooter1,
   GroupFooter2       : TfrxGroupFooter;
   Hour, Min, Sec, MSec : Word;
   sArchivo_Excel  :  string;
   PWFILE           : PWideChar;
   sString_Carteras,
   sString_Empresas : string;
begin
  sString_Empresas := '';
  sString_Carteras := '';
  if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
  begin
    With Qry_General do
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
          sString_Empresas := sString_Empresas +' ( '''+Fieldbyname('Empresa').asString;
          Next;
          While Not Eof do
          begin
             sString_Empresas := sString_Empresas + ''','''+Fieldbyname('Empresa').asString;
             Next;
          end;
          sString_Empresas := sString_Empresas +''' )';
       end
       else
          sString_Empresas := '( '''+sEmpresa_Usuario+''' )';

       Close;
       Sql.Clear;
       SQL.Add(' SELECT z.Cartera FROM QS_SYS_PARAM_EMPRESA z'
              +' WHERE z.Empresa IN '+ sString_Empresas
              +'   AND z.Pid     = :Pid'
              );
       Parambyname('Pid').asFloat := Application.Handle;
       Open;
       if Not Fieldbyname('Cartera').IsNull then
       begin
          if NOT EOF then
             sString_Carteras := sString_Carteras +' ( '''+Fieldbyname('Cartera').asString;
          Next;
          While Not Eof do
          begin
             sString_Carteras := sString_Carteras +''','''+Fieldbyname('Cartera').asString;
             Next;
          end;
          sString_Carteras := sString_Carteras + ''' )';
       end
       else
          sString_Carteras := '';
    end;
  end;


   if Check_UnLibro.Checked then
   begin
     DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
     sArchivo_Excel := sDirExcel
                        +'LMTS'
                        +IntToStr(Hour)
                        +IntToStr(Min)
                        +IntToStr(Sec)
                        +IntToStr(MSec)
                        +'.'+sExtencion;
   end;
////  qry_limite se pasa a una tabla temporal para ser generada por excel con los campos necesarios
///  al generar genera 4 columnas mas que son necesarias como parametros en otros select

   if (Rg_Reportes.ItemIndex = 1) or (Check_Detallado.Checked) then
   begin
      Seleccion_Detalle;
      FDMemTable1.Open;
      FDMemTable1.EmptyDataSet;
      FDMemTable1.CopyDataSet(Qry_Detalle);
      Leer_Identidad_Direccion(sEmpresa_Usuario,
                               fItem_Dir_Usuario,
                               sRazon_Social,
                               sDireccion,
                               sUbicacion,
                               Result);

      if Check_Detallado.Checked then
        if Check_UnLibro.Checked then
           Genera_excel_dll_libro_hojas(FDMemTable1,'LIMITES DE INVERSION DETALLADO',False,sArchivo_Excel)
        else
           Genera_excel_dll(FDMemTable1,'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text,True);

      if not CheckBox1.Checked then
      begin
        Grid_Encabezado.DataSource := Nil;
        Grid_Detalle.DataSource    := Nil;
        bImprimir                  := True;
        With TFrmReportLimites.Create(Self)do
        begin
          with TFrmRPreview.Create(Self) do
          begin
             Table_Excel := FDMemTable1;          ///  solo para planilla excel
             Table_Qry := 1;

//             Qry_excel := Qry_Limite;
//             Table_Qry := 2;
             with frxReport1 do
             begin
                Label_Razon_Social      := FindObject('Label_Razon_Social') as TfrxMemoView;
                Label_Razon_Social.Text := sRazon_Social;
                Label_Direccion         := FindObject('Label_Direccion') as TfrxMemoView;
                Label_Direccion.Text    := sDireccion;
                Label_Ubicacion         := FindObject('Label_Ubicacion') as TfrxMemoView;
                Label_Ubicacion.Text    := sUbicacion;
                Lbl_Titulo              := FindObject('Lbl_Titulo') as TfrxMemoView;
                Lbl_Titulo.Text         := 'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
                ReportOptions.Name      := 'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
                //if bdesarrollo then // para debuggear el report en ejecucion
                //   DesignReport;    // OJO poner libreria 'frxDesgn' en modulo del informe
                Preview := frxPreview1;
                PrepareReport(True);
                PrintOptions.ShowDialog :=True;
                ShowModal;
             end;

          end;
        end;
        Grid_Encabezado.DataSource := DataLimites;
        Grid_Detalle.DataSource    := wwDataLimitesDet;
        bImprimir                  := False;
        Qry_Limite.First;
      end;
   end;
   if (Rg_Reportes.ItemIndex = 1) or (Check_TInversion.Checked) then
   begin
      T_DatosGrupo.EmptyDataSet;
      With Qry_General do
      begin
         Sql.Clear;
         Sql.Add('SELECT a.CODIGO_RTPR'
                +'      ,a.DESCRIPCION'
                +'  FROM QS_SUP_251_RTPR a'
                +' WHERE a.Fecha_desde <= :Fecha'
                +'   AND (a.Fecha_Hasta >=:Fecha OR a.Fecha_Hasta IS NULL )'
                +' ORDER BY a.Codigo_RTPR'
                );
         ParamByname('Fecha').asDatetime := dFecha_Proceso;
         Open;
         While Not Eof do
         begin
            For i := 1 to 3 do
            begin
               Case i of
                  1:
                    sTipo_Limite := 'INSTRUMENT';
                  2:
                    sTipo_Limite := 'CONJUNTO';
                  3:
                    sTipo_Limite := 'EMISION';
               end;
               With Qry_General2 do
               begin
                   if sTipo_Limite <> 'EMISION' then
                   begin
                      Sql.Clear;
                      Sql.Add( ' SELECT a.Porcentaje'
                              +'       ,a.Maximo_Permitido'
                              +'       ,SUM(b.VALOR_PTE_MC_CPA) as VALOR_PTE_CARTERA'
                              +'       FROM QS_SUP_251 a'
                              +'           ,QS_SUP_251_DET b'
                              +'  WHERE a.Empresa       = :Empresa'
                              //+'   AND  a.Cartera       = :Cartera'
                              +'   AND  a.FECHA_PROCESO = :Fecha_Proceso'
                              +'   AND  a.EMPRESA       = a.EMPRESA'
                              +'   AND  a.FECHA_PROCESO = b.FECHA_PROCESO'
                              +'   AND  a.PROCESO       = b.PROCESO'
                              +'   AND  a.CODIGO_LIMITE = b.CODIGO_LIMITE'
                              +'   AND  a.PROCESO       = b.PROCESO'
                              +'   AND  a.TIPO_LIMITE   = :Tipo_Limite'//'EMISION'
                              +'   AND  b.CODIGO_RTPR   = :Codigo_RTPR'//'1B'
                              );
                      if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
                      begin
//                         sql.add('    AND b.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
//                         sql.add('                      WHERE  pid = :pid ');
//                         sql.add('                         and z.empresa = b.empresa ');
//                         sql.add('                     ) ');
//                         sql.add('    AND b.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
//                         sql.add('                      WHERE pid = :pid ');
//                         sql.add('                        and z.cartera = b.cartera ');
//                         sql.add('                 ) ');
                          sql.add('    AND b.empresa in '+sString_Empresas );
                          sql.add('    AND b.cartera in '+sString_Carteras );

                         sql.add('    AND a.CARTERA   = :CARTERA ');
                         Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
//                         ParamByName('pid').AsFloat := Application.Handle;
                      end
                      else
                      begin
                          sql.add('AND b.EMPRESA   = :EMPRESA ');
                          sql.add('AND b.CARTERA   = :CARTERA ');
                          ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
                      end;
                      sql.add('  GROUP BY a.Porcentaje'
                              +'         ,a.Maximo_Permitido'
                             );
                   end
                   else
                   begin
                      Sql.Clear;
                      Sql.Add( ' SELECT DISTINCT a.Porcentaje'
                              +'                ,a.maximo_permitido'
                              +'                ,a.VALOR_PTE_CARTERA'
                              +'       FROM QS_SUP_251 a'
                              +'           ,QS_SUP_251_DET b'
                              +'  WHERE a.Empresa       = :Empresa'
                              //+'   AND  a.Cartera       = :Cartera'
                              +'   AND  a.FECHA_PROCESO = :Fecha_Proceso'
                              +'   AND  a.EMPRESA       = a.EMPRESA'
                              +'   AND  a.FECHA_PROCESO = b.FECHA_PROCESO'
                              +'   AND  a.CODIGO_LIMITE = b.CODIGO_LIMITE'
                              +'   AND  a.PROCESO       = b.PROCESO'
                              +'   AND  a.TIPO_LIMITE   = :Tipo_Limite'//'EMISION'
                              +'   AND  b.CODIGO_RTPR   = :Codigo_RTPR'//'1B'
                              );
                      if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
                      begin
//                         sql.add('    AND b.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
//                         sql.add('                      WHERE  pid = :pid ');
//                         sql.add('                         and z.empresa = b.empresa ');
//                         sql.add('                     ) ');
//                         sql.add('    AND b.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
//                         sql.add('                      WHERE pid = :pid ');
//                         sql.add('                        and z.cartera = b.cartera ');
//                         sql.add('                 ) ');
                          sql.add('    AND b.empresa in '+sString_Empresas );
                          sql.add('    AND b.cartera in '+sString_Carteras );
                         sql.add('    AND a.CARTERA   = :CARTERA ');
                         Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
//                         ParamByName('pid').AsFloat := Application.Handle;
                      end
                      else
                      begin
                          sql.add('AND b.EMPRESA   = :EMPRESA ');
                          sql.add('AND b.CARTERA   = :CARTERA ');
                          ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
                      end;
                      sql.add(' ORDER BY a.Porcentaje'
                             );
                   end;
                   Parambyname('Empresa').asString          := sEmpresa_Usuario;
                   //Parambyname('Cartera').asString          := FrmCalculoLimites.Combo_Cartera.Text;
                   Parambyname('Fecha_Proceso').asDatetime  := dFecha_Proceso;
                   Parambyname('Tipo_Limite').asString      := sTipo_Limite;
                   Parambyname('Codigo_RTPR').asString      := Qry_General.Fieldbyname('Codigo_RTPR').asString;
                   Open;

                   if i = 1 then
                   begin
                      T_DatosGrupo.Append;
                      T_DatosGrupo.Fieldbyname('Descripcion').asString := Qry_General.Fieldbyname('Descripcion').asString;
                   end
                   else
                   begin
                      // busco primer registro de RT y PR....
                      T_DatosGrupo.First;
                      if T_DatosGrupo.Locate('CODIGO_RTPR', Qry_General.Fieldbyname('Codigo_RTPR').asString, [loCaseInsensitive]) then
                         T_DatosGrupo.Edit;
                   end;
                   T_DatosGrupo.Fieldbyname('Tipo_Inversion').asString := Copy(Qry_General.Fieldbyname('Codigo_RTPR').asString,1,1);
                   T_DatosGrupo.Fieldbyname('Codigo_RTPR').asString    := Qry_General. Fieldbyname('Codigo_RTPR').asString;
                   T_DatosGrupo.Post;
//                   bInsertar  := False;

//                   fValor_Cartera    := 0;
//                   fMaximo_Permitido := 0;
//                   fPorcentaje       := 0;
                   iRegistro         := 0;
                   While Not Eof do
                   begin
                      fValor_Cartera    := Fieldbyname('VALOR_PTE_CARTERA').asFloat;
                      fMaximo_Permitido := Fieldbyname('Maximo_Permitido').asFloat;
                      fPorcentaje       := Fieldbyname('Porcentaje').asFloat;

                      if iRegistro = 0 then
                         bInsertar := False
                      else
                      begin
                         if i = 1 then // Primera pasada siempre INSERTO
                            bInsertar := True
                         else
                         begin
                            T_DatosGrupo.Next;
                            bInsertar := True;
                            if ( Not T_DatosGrupo.Eof ) and
                               ( T_DatosGrupo.Fieldbyname('Codigo_RTPR').asString = Qry_General.Fieldbyname('Codigo_RTPR').asString) then
                               bInsertar := False;
                         end;
                      end;

                      if bInsertar then
                         T_DatosGrupo.Append
                      else
                         T_DatosGrupo.Edit;

                      T_DatosGrupo.Fieldbyname('Tipo_Inversion').asString := Copy(Qry_General.Fieldbyname('Codigo_RTPR').asString,1,1);
                      T_DatosGrupo.Fieldbyname('Codigo_RTPR').asString    := Qry_General.Fieldbyname('Codigo_RTPR').asString;
                      if sTipo_Limite = 'INSTRUMENT' then
                      begin
                         if fPorcentaje <> 0 then
                            T_DatosGrupo.Fieldbyname('Porcen_Intrum').asString  := Trim(FloatToStr(fPorcentaje))+'%';

                         T_DatosGrupo.Fieldbyname('Por_Intrum_251').asFloat  := fValor_Cartera;
                         T_DatosGrupo.Fieldbyname('Max_Intrum_251').asFloat  := fMaximo_Permitido;
                      end
                      else if sTipo_Limite = 'CONJUNTO' then
                      begin
                         if fPorcentaje <> 0 then
                            T_DatosGrupo.Fieldbyname('Porcen_Conj').asString    := Trim(FloatToStr(fPorcentaje))+'%';

                         T_DatosGrupo.Fieldbyname('Por_Conj_251').asFloat    := fValor_Cartera;
                         T_DatosGrupo.Fieldbyname('Max_Conj_251').asFloat    := fMaximo_Permitido;
                      end
                      else // EMISION
                      begin
                          fValor_Cartera    := 0;
                          fMaximo_Permitido := 0;
                          While (Not Eof) and
                                (Fieldbyname('Porcentaje').asFloat = fPorcentaje) do
                          begin
                             fValor_Cartera    := fValor_Cartera    + Fieldbyname('VALOR_PTE_CARTERA').asFloat;
                             fMaximo_Permitido := fMaximo_Permitido + Fieldbyname('Maximo_Permitido').asFloat;
                             Next;
                          end;
                          if fPorcentaje <> 0 then
                             T_DatosGrupo.Fieldbyname('Porcen_Emisor').asString  := Trim(FloatToStr(fPorcentaje))+'%';

                          T_DatosGrupo.Fieldbyname('Por_Emisor_251').asFloat  := fValor_Cartera;
                          T_DatosGrupo.Fieldbyname('Max_Emisor_251').asFloat  := fMaximo_Permitido;
                      end;
                      T_DatosGrupo.Post;

                      Inc(iRegistro);
                      if sTipo_Limite <> 'EMISION' then
                         Next;
                   end; // While Not Eof
                   Close;
               end;
            end; //for
            Qry_General.Next;
         end;
      end;

      if Check_TInversion.Checked then
        if Check_UnLibro.Checked then
             Genera_excel_dll_libro_hojas(T_DatosGrupo,'LIMITES DE INVERSION TIPO INV.',False,sArchivo_Excel)
          else
             Genera_excel_dll(T_DatosGrupo,'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text,True);
     if not CheckBox1.Checked then
     begin
      with TFrmRPreview.Create(Self) do
      begin
         FrmReportLimitesGrupo := TFrmReportLimitesGrupo.Create(Self);
         Table_excel := T_DatosGrupo;
         Table_Qry   := 1;
         with FrmReportLimitesGrupo.frxReport1 do
         begin
            Label_Razon_Social      := FindObject('Label_Razon_Social') as TfrxMemoView;
            Label_Razon_Social.Text := sRazon_Social;
            Label_Direccion         := FindObject('Label_Direccion') as TfrxMemoView;
            Label_Direccion.Text    := sDireccion;
            Label_Ubicacion         := FindObject('Label_Ubicacion') as TfrxMemoView;
            Label_Ubicacion.Text    := sUbicacion;
            Lbl_Titulo              := FindObject('Lbl_Titulo') as TfrxMemoView;
            Lbl_Titulo.Text         := 'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            ReportOptions.Name      := 'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            //if bdesarrollo then // para debuggear el report en ejecucion
            //   DesignReport;    // OJO poner libreria 'frxDesgn' en modulo del informe
            Preview := frxPreview1;
            PrepareReport(True);
            PrintOptions.ShowDialog :=True;
            ShowModal;
         end;
         FrmReportLimitesGrupo.Free;
      end;
     end;
   end;
   if (Rg_Reportes.ItemIndex = 2) or (check_Empresariales.Checked) then
   begin
      With Qry_Grupo do
      begin
         Sql.Clear;
         Sql.Add( ' SELECT a.Grupo_Emisor'
                 +'       ,b.Emisor'
                 +'       ,a.Porcentaje'
                 +'       ,a.Maximo_Permitido'
                 +'       ,SUM(b.VALOR_PTE_MC_CPA) as VALOR_PTE_CARTERA'
                 +'  FROM QS_SUP_251 a'
                 +'      ,QS_SUP_251_DET b'
                 +'  WHERE a.Empresa      = :Empresa'
                 +'   AND a.FECHA_PROCESO = :Fecha_Proceso'
                 +'   AND a.Empresa       = b.Empresa'
                 +'   AND a.fecha_proceso = b.fecha_Proceso'
                 +'   AND a.Proceso       = b.Proceso'
                 +'   AND a.Codigo_Limite = b.Codigo_Limite'
                 +'   AND a.GRUPO_EMISOR  = b.GRUPO_EMISOR'
                 );
         if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
         begin
//            sql.add('    AND b.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
//            sql.add('                      WHERE  pid = :pid ');
//            sql.add('                         and z.empresa = b.empresa ');
//            sql.add('                     ) ');
//            sql.add('    AND b.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
//            sql.add('                      WHERE pid = :pid ');
//            sql.add('                        and z.cartera = b.cartera ');
//            sql.add('                 ) ');
            sql.add('    AND b.empresa in '+sString_Empresas );
            sql.add('    AND b.cartera in '+sString_Carteras );
            sql.add('    AND a.CARTERA   = :CARTERA ');
            Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
//            ParamByName('pid').AsFloat := Application.Handle;
         end
         else
         begin
             sql.add('AND b.EMPRESA   = :EMPRESA ');
             sql.add('AND b.CARTERA   = :CARTERA ');
             ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
         end;

         if bSBS then // JULERO...pero ya se cambiara
            Sql.Add(' AND a.Tipo_Limite   =  ''GLOBALES''' )
         else
            Sql.Add(' AND a.Tipo_Limite   = ''CONJUNTO''' );

         Sql.Add('    AND a.Grupo_Emisor <> '' '''
                 +' GROUP BY a.Grupo_Emisor'
                 +'         ,b.Emisor'
                 +'         ,a.Porcentaje'
                 +'         ,a.Maximo_Permitido'
                 +' ORDER BY a.Grupo_Emisor'
                 +'         ,b.Emisor'
                 +'         ,a.Porcentaje'
                );
         Parambyname('Empresa').asString         := sEmpresa_Usuario;
         Parambyname('Fecha_Proceso').asDatetime := dFecha_Proceso;
         Open;
      end;

      if check_Empresariales.Checked then
        if Check_UnLibro.Checked then
             Genera_excel_dll_libro_hojas(Qry_Grupo,'LIMITES DE INVERSION EMPRESARIAL',False,sArchivo_Excel)
          else
             Genera_excel_dll(Qry_Grupo,'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text,True);
    if not CheckBox1.Checked then
    begin
      with TFrmRPreview.Create(Self) do
      begin
         FrmReportPorGrupo := TFrmReportPorGrupo.Create(Self);
         QRY_excel := Qry_Grupo;
         Table_Qry := 2;
         with FrmReportPorGrupo.frxReport1 do
         begin
            Label_Razon_Social      := FindObject('Label_Razon_Social') as TfrxMemoView;
            Label_Razon_Social.Text := sRazon_Social;
            Label_Direccion         := FindObject('Label_Direccion') as TfrxMemoView;
            Label_Direccion.Text    := sDireccion;
            Label_Ubicacion         := FindObject('Label_Ubicacion') as TfrxMemoView;
            Label_Ubicacion.Text    := sUbicacion;
            Lbl_Titulo              := FindObject('Lbl_Titulo') as TfrxMemoView;
            Lbl_Titulo.Text         := 'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            ReportOptions.Name      := 'LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            //if bdesarrollo then // para debuggear el report en ejecucion
            //   DesignReport;    // OJO poner libreria 'frxDesgn' en modulo del informe
            Preview := frxPreview1;
            PrepareReport(True);
            PrintOptions.ShowDialog :=True;
            ShowModal;
         end;
         FrmReportPorGrupo.Free;
      end;
    end;
   end;
   if (Rg_Reportes.ItemIndex = 3) or (Check_Emisor1.Checked) then
   begin
      With Qry_EmisorInstrum do
      begin
         Sql.Clear;
         Sql.Add( ' SELECT a.Emisor       as Matriz'
                 +'       ,b.Emisor       as Filial'
                 +'       ,b.Instrumento  as Instrumento'
                 +'       ,a.Porcentaje   as Porcentaje'
                 +'       ,a.Maximo_Permitido'
                 +'       ,SUM(b.VALOR_PTE_MC_CPA) as VALOR_PTE_CARTERA'
                 +'  FROM QS_SUP_251 a'
                 +'      ,QS_SUP_251_DET b'
                 +'  WHERE a.Empresa      = :Empresa'
                 +'   AND a.FECHA_PROCESO = :Fecha_Proceso'
                 +'   AND a.Empresa       = b.Empresa'
                 +'   AND a.fecha_proceso = b.fecha_Proceso'
                 +'   AND a.Proceso       = b.Proceso'
                 +'   AND a.Codigo_Limite = b.Codigo_Limite'
                 +'   AND (a.Emisor = b.Emisor OR a.emisor = b.matriz)'
                 +'   AND a.Tipo_Limite   = ''CONJUNTO'''
                 +'   AND a.Emisor       <> '' '''
                 +'   AND ( a.Grupo_Emisor  = '' '''
                 +'    OR   a.Grupo_Emisor IS NULL'
                 +'       )'
                 );
         if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
         begin
//            sql.add('    AND b.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
//            sql.add('                      WHERE  pid = :pid ');
//            sql.add('                         and z.empresa = b.empresa ');
//            sql.add('                     ) ');
//            sql.add('    AND b.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
//            sql.add('                      WHERE pid = :pid ');
//            sql.add('                        and z.cartera = b.cartera ');
//            sql.add('                 ) ');
            sql.add('    AND b.empresa in '+sString_Empresas );
            sql.add('    AND b.cartera in '+sString_Carteras );
            sql.add('    AND a.CARTERA   = :CARTERA ');
            Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
//            ParamByName('pid').AsFloat := Application.Handle;
         end
         else
         begin
             sql.add(' AND b.EMPRESA   = :EMPRESA ');
             sql.add(' AND b.CARTERA   = :CARTERA ');
             ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
         end;
         sql.add( ' GROUP BY a.Emisor'
                +'         ,b.Emisor'
                +'         ,b.Instrumento'
                +'         ,a.Porcentaje'
                +'         ,a.Maximo_Permitido'
                +' ORDER BY Matriz'
                +'         ,Filial'
                +'         ,Porcentaje'
                +'         ,Instrumento'
               );
        Parambyname('Empresa').asString         := sEmpresa_Usuario;
        Parambyname('Fecha_Proceso').asDatetime := dFecha_Proceso;
        Open;
      end;

      if Check_Emisor1.Checked then
        if Check_UnLibro.Checked then
             Genera_excel_dll_libro_hojas(Qry_EmisorInstrum,'LIMITES DE INVERSION( CONJUNTO )',False,sArchivo_Excel)
          else
             Genera_excel_dll(Qry_EmisorInstrum,'LIMITES DE INVERSION( CONJUNTO ) AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text,True);

    if not CheckBox1.Checked then
    begin
      with TFrmRPreview.Create(Self) do
      begin
         FrmReportPorEmisorInstrumento := TFrmReportPorEmisorInstrumento.Create(Self);
         Qry_excel := Qry_EmisorInstrum;
         Table_Qry   := 2;
         with FrmReportPorEmisorInstrumento.frxReport1 do
         begin
            GroupFooter1            := FindObject('GroupFooter1') as TfrxGroupFooter;
            GroupFooter1.Visible    := False;
            GroupFooter2            := FindObject('GroupFooter2') as TfrxGroupFooter;
            GroupFooter2.Visible    := True;
            Label_Razon_Social      := FindObject('Label_Razon_Social') as TfrxMemoView;
            Label_Razon_Social.Text := sRazon_Social;
            Label_Direccion         := FindObject('Label_Direccion') as TfrxMemoView;
            Label_Direccion.Text    := sDireccion;
            Label_Ubicacion         := FindObject('Label_Ubicacion') as TfrxMemoView;
            Label_Ubicacion.Text    := sUbicacion;
            Lbl_Titulo              := FindObject('Lbl_Titulo') as TfrxMemoView;
            Lbl_Titulo.Text         := 'LIMITES DE INVERSION( CONJUNTO ) AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            ReportOptions.Name      := 'LIMITES DE INVERSION( CONJUNTO ) AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            //if bdesarrollo then // para debuggear el report en ejecucion
            //   DesignReport;    // OJO poner libreria 'frxDesgn' en modulo del informe
            Preview := frxPreview1;
            PrepareReport(True);
            PrintOptions.ShowDialog :=True;
            ShowModal;
         end;
         FrmReportPorEmisorInstrumento.Free;
      end;
    end;
   end;
   if (Rg_Reportes.ItemIndex = 4) or (Check_Emisior2.Checked) then
   begin
      With Qry_General do
      begin
         Sql.Clear;
         Sql.Add( ' SELECT a.CODIGO_LIMITE'
                 +'       ,b.CODIGO_RTPR'
                 +'   		,a.EMISOR'
                 +'   	  ,a.INSTRUMENTO'
                 +'   	  ,A.PORCENTAJE'
                 +'   	  ,a.VALOR_PTE_CARTERA AS NOMINALES_CARTERA'
                 +'   	  ,a.MAXIMO_PERMITIDO AS MAXIMO_PERMITIDO_NOMINAL'
                 +'   	  ,SUM(d.VALOR_FINAL_SVS_MC) As VALOR_PTE_CARTERA'
                 +'   	  ,SUM(d.VALOR_PTE_MC_CPA) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA As Maximo_Permitido'
                 +'   	  ,(SUM(d.VALOR_PTE_MC_CPA) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA) - SUM(d.VALOR_FINAL_SVS_MC) As Margen'
                 +'   	  ,a.SERIES_INSCRITAS'
                 +'   FROM QS_SUP_251     a'
                 +'   	  ,QS_SUP_251_DET b'
                 +'   	  ,QS_SUP_251_LIM c'
                 +'       ,QS_RES_MERCADO d'
                 +'  WHERE a.FECHA_PROCESO = :Fecha_Proceso'
                 +'    AND a.proceso = :Proceso'
                 +'    AND a.TIPO_LIMITE = ''EMISION'' '
                 +'    AND a.Codigo_Limite not in (''LIMEMI_A1'',''LIMEMI_A2'')'
                 +'    AND c.CODIGO_LIMITE = a.CODIGO_LIMITE'
                 +'    AND c.PROCESO = a.PROCESO'
                 +'    AND c.FECHA_DESDE IN (SELECT MAX(d.FECHA_DESDE)'
                 +'     		          		  	 FROM QS_SUP_251_LIM d'
                 +'     					            WHERE d.CODIGO_LIMITE = a.CODIGO_LIMITE'
                 +'     					              AND d.PROCESO 		   = a.PROCESO'
                 +'     					              AND d.FECHA_DESDE    <= a.FECHA_PROCESO'
                 +'     					              AND (d.FECHA_HASTA   >= a.FECHA_PROCESO OR d.FECHA_HASTA IS NULL)'
                 +'          			          )'
                 +'    AND c.CODIGO_PORCENTAJE  = ''EMISION'' '
                 +'    AND b.FECHA_PROCESO = a.FECHA_PROCESO'
                 +'    AND b.PROCESO = a.PROCESO'
                 +'    AND b.CODIGO_LIMITE = a.CODIGO_LIMITE'
                 +'    AND b.EMPRESA = a.EMPRESA'
                 +'    AND b.EMISOR = a.EMISOR'
                 +'    AND ((a.Nemotecnico   = b.Nemotecnico) or (a.Nemotecnico is null))'
                 +'    AND ((b.SERIES_INSCRITAS = a.SERIES_INSCRITAS) OR (a.SERIES_INSCRITAS IS NULL))'
                 +'    AND d.FECHA_CIERRE  = b.FECHA_PROCESO '
                 +'    AND d.FOLIO_INTERNO = b.FOLIO_INTERNO '
                 +'    AND d.ITEM_OMD      = b.ITEM_OMD '
                 +'    AND d.TRANSACCION   = b.TRANSACCION '
                 +'    AND d.EMPRESA       = b.EMPRESA ');
         if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
         begin
            sql.add('    AND b.empresa in '+sString_Empresas );
            sql.add('    AND b.cartera in '+sString_Carteras );
            sql.add('    AND a.CARTERA   = :CARTERA ');
            Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
         end
         else
         begin
             sql.add('AND b.EMPRESA   = :EMPRESA ');
             sql.add('AND b.CARTERA   = :CARTERA ');
             ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
             Parambyname('Empresa').asString  := sEmpresa_Usuario;
         end;

         Sql.Add( '  GROUP BY a.CODIGO_LIMITE'
                 +'          ,b.CODIGO_RTPR'
                 +'      		 ,a.EMISOR'
                 +'   	     ,a.INSTRUMENTO'
                 +'   	     ,A.PORCENTAJE'
                 +'   	     ,a.VALOR_PTE_CARTERA'
                 +'    	     ,a.MAXIMO_PERMITIDO'
                 +'   	     ,a.SERIES_INSCRITAS');

         Sql.Add( ' UNION ');

         Sql.Add( ' SELECT a.CODIGO_LIMITE'
                 +'       ,b.CODIGO_RTPR'
                 +'   		,a.EMISOR'
                 +'   	  ,a.INSTRUMENTO'
                 +'   	  ,A.PORCENTAJE'
                 +'   	  ,a.VALOR_PTE_CARTERA AS NOMINALES_CARTERA'
                 +'   	  ,a.MAXIMO_PERMITIDO AS MAXIMO_PERMITIDO_NOMINAL'
                 +'   	  ,SUM(d.TOTAL_FINAL) As VALOR_PTE_CARTERA'
                 +'   	  ,SUM(d.TOTAL_FINAL) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA As Maximo_Permitido'
                 +'   	  ,(SUM(d.TOTAL_FINAL) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA) - SUM(d.TOTAL_FINAL) As Margen'
                 +'   	  ,a.SERIES_INSCRITAS'
                 +'   FROM QS_SUP_251         a'
                 +'   	  ,QS_SUP_251_DET     b'
                 +'   	  ,QS_SUP_251_LIM     c'
                 +'       ,QS_RES_VALORIZA_RV d'
                 +'  WHERE a.FECHA_PROCESO = :Fecha_Proceso'
                 +'    AND a.proceso = :Proceso'
                 +'    AND a.TIPO_LIMITE = ''EMISION'' '
                 +'    AND a.Codigo_Limite not in (''LIMEMI_A1'',''LIMEMI_A2'')'
                 +'    AND c.CODIGO_LIMITE = a.CODIGO_LIMITE'
                 +'    AND c.PROCESO = a.PROCESO'
                 +'    AND c.FECHA_DESDE IN (SELECT MAX(d.FECHA_DESDE)'
                 +'     		          		  	 FROM QS_SUP_251_LIM d'
                 +'     					            WHERE d.CODIGO_LIMITE = a.CODIGO_LIMITE'
                 +'     					              AND d.PROCESO 		   = a.PROCESO'
                 +'     					              AND d.FECHA_DESDE    <= a.FECHA_PROCESO'
                 +'     					              AND (d.FECHA_HASTA   >= a.FECHA_PROCESO OR d.FECHA_HASTA IS NULL)'
                 +'          			          )'
                 +'    AND c.CODIGO_PORCENTAJE  = ''EMISION'' '
                 +'    AND b.FECHA_PROCESO = a.FECHA_PROCESO'
                 +'    AND b.PROCESO = a.PROCESO'
                 +'    AND b.CODIGO_LIMITE = a.CODIGO_LIMITE'
                 +'    AND b.EMPRESA = a.EMPRESA'
                 +'    AND b.EMISOR = a.EMISOR'
                 +'    AND ((a.Nemotecnico   = b.Nemotecnico) or (a.Nemotecnico is null))'
                 +'    AND ((b.SERIES_INSCRITAS = a.SERIES_INSCRITAS) OR (a.SERIES_INSCRITAS IS NULL))'
                 +'    AND d.FECHA_CIERRE  = b.FECHA_PROCESO '
                 +'    AND d.NEMOTECNICO   = b.NEMOTECNICO '
                 +'    AND d.TRANSACCION   = b.TRANSACCION '
                 +'    AND d.CARTERA       = b.CARTERA '
                 +'    AND d.EMPRESA       = b.EMPRESA ');
         if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
         begin
            sql.add('    AND b.empresa in '+sString_Empresas );
            sql.add('    AND b.cartera in '+sString_Carteras );
            sql.add('    AND a.CARTERA   = :CARTERA ');
            Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
         end
         else
         begin
             sql.add('AND b.EMPRESA   = :EMPRESA ');
             sql.add('AND b.CARTERA   = :CARTERA ');
             ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
             Parambyname('Empresa').asString  := sEmpresa_Usuario;
         end;

         Sql.Add( '  GROUP BY a.CODIGO_LIMITE'
                 +'          ,b.CODIGO_RTPR'
                 +'      		 ,a.EMISOR'
                 +'   	     ,a.INSTRUMENTO'
                 +'   	     ,A.PORCENTAJE'
                 +'   	     ,a.VALOR_PTE_CARTERA'
                 +'    	     ,a.MAXIMO_PERMITIDO'
                 +'   	     ,a.SERIES_INSCRITAS');

         Parambyname('Fecha_Proceso').asDatetime := dFecha_Proceso;
         ParamByname('Proceso').asString         := FrmCalculoLimites.Ed_Proceso.Text;

         Genera_Excel_Qry(Qry_General
                         ,'LIMITES DE INVERSION (EMISION) AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text);

      end;
   end;
   if (Rg_Reportes.ItemIndex = 5) or (Check_Emisor3.Checked) then
   begin
      With Qry_EmisorInstSerie do
      begin
         Sql.Clear;
         Sql.Add( ' SELECT b.Emisor      as Emisor'
                 +'       ,b.Instrumento as Instrumento'
                 +'       ,a.Series_Inscritas'
                 +'       ,a.Porcentaje  as Porcentaje'
                 +'       ,a.Maximo_Permitido'
                 +'       ,SUM(b.VALOR_NOMINAL) as Nominales'
                 +'  FROM QS_SUP_251 a'
                 +'      ,QS_SUP_251_DET b'
                 +'  WHERE a.Empresa      = :Empresa'
                 +'   AND a.FECHA_PROCESO = :Fecha_Proceso'
                 +'   AND a.Tipo_Limite   = ''EMISION'''
//                 +'   AND a.Codigo_Limite not in (''LIMEMI_A1'',''LIMEMI_A2'')'
                 +'   AND a.Empresa       = b.Empresa'
                 +'   AND a.fecha_proceso = b.fecha_Proceso'
                 +'   AND a.Proceso       = b.Proceso'
                 +'   AND a.Codigo_Limite = b.Codigo_Limite'
                 +'   AND a.Emisor        = b.Emisor'
                 +'   AND a.Nemotecnico   = b.Nemotecnico'
                 +'   AND ((a.Series_Inscritas = b.Series_Inscritas) or (a.Series_Inscritas is null))'
                 );
         if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
         begin
//            sql.add('    AND b.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
//            sql.add('                      WHERE  pid = :pid ');
//            sql.add('                         and z.empresa = b.empresa ');
//            sql.add('                     ) ');
//            sql.add('    AND b.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
//            sql.add('                      WHERE pid = :pid ');
//            sql.add('                        and z.cartera = b.cartera ');
//            sql.add('                 ) ');
            sql.add('    AND b.empresa in '+sString_Empresas );
            sql.add('    AND b.cartera in '+sString_Carteras );
            sql.add('    AND a.CARTERA   = :CARTERA ');
            Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
//            ParamByName('pid').AsFloat := Application.Handle;
         end
         else
         begin
             sql.add('AND b.EMPRESA   = :EMPRESA ');
             sql.add('AND b.CARTERA   = :CARTERA ');
             ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
         end;
         sql.add('  GROUP BY b.Emisor'
                 +'         ,b.Instrumento'
                 +'         ,a.Series_Inscritas'
                 +'         ,a.Porcentaje'
                 +'         ,a.Maximo_Permitido'
                );
         Sql.Add( ' UNION ' );
         Sql.Add( ' SELECT b.Emisor      as Emisor'
                 +'       ,b.Instrumento as Instrumento'
                 +'       ,a.Series_Inscritas'
                 +'       ,a.Porcentaje  as Porcentaje'
                 +'       ,a.Maximo_Permitido'
                 +'       ,SUM(b.VALOR_NOMINAL) as Nominales'
                 +'  FROM QS_SUP_251 a'
                 +'      ,QS_SUP_251_DET b'
                 +'  WHERE a.Empresa      = :Empresa'
                 +'   AND a.FECHA_PROCESO = :Fecha_Proceso'
                 +'   AND a.Tipo_Limite   = ''EMISION'''
                 +'   AND a.Codigo_Limite not in (''LIMEMI_A1'',''LIMEMI_A2'')'
                 +'   AND a.Empresa       = b.Empresa'
                 +'   AND a.fecha_proceso = b.fecha_Proceso'
                 +'   AND a.Proceso       = b.Proceso'
                 +'   AND a.Codigo_Limite = b.Codigo_Limite'
                 +'   AND a.Emisor        = b.Emisor'
                 +'   AND (a.Nemotecnico   = '' '' or a.Nemotecnico is null) '
                 +'   AND ((a.Series_Inscritas = b.Series_Inscritas) or (a.Series_Inscritas is null))'
                 );
         if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
         begin
//            sql.add('    AND b.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
//            sql.add('                      WHERE  pid = :pid ');
//            sql.add('                         and z.empresa = b.empresa ');
//            sql.add('                     ) ');
//            sql.add('    AND b.cartera in (SELECT z.cartera from QS_SYS_PARAM_EMPRESA z ');
//            sql.add('                      WHERE pid = :pid ');
//            sql.add('                        and z.cartera = b.cartera ');
//            sql.add('                 ) ');
            sql.add('    AND b.empresa in '+sString_Empresas );
            sql.add('    AND b.cartera in '+sString_Carteras );
            sql.add('    AND a.CARTERA   = :CARTERA ');
            Parambyname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
//            ParamByName('pid').AsFloat := Application.Handle;
         end
         else
         begin
             sql.add('AND b.EMPRESA   = :EMPRESA ');
             sql.add('AND b.CARTERA   = :CARTERA ');
             ParamByname('Cartera').asString  := FrmCalculoLimites.Combo_Cartera.Text;
         end;
         sql.add('  GROUP BY b.Emisor'
                 +'         ,b.Instrumento'
                 +'         ,a.Series_Inscritas'
                 +'         ,a.Porcentaje'
                 +'         ,a.Maximo_Permitido'
                 +' ORDER BY Emisor'
                 +'         ,Instrumento'
                 +'         ,Porcentaje'
                );
         Parambyname('Empresa').asString         := sEmpresa_Usuario;
         Parambyname('Fecha_Proceso').asDatetime := dFecha_Proceso;
         Open;
      end;

      if Check_Emisor3.Checked then
        if Check_UnLibro.Checked then
             Genera_excel_dll_libro_hojas(Qry_EmisorInstSerie,'LIMITES DE INVERSION (EMISION NOMINALES)',False,sArchivo_Excel)
          else
             Genera_excel_dll(Qry_EmisorInstSerie,'LIMITES DE INVERSION (EMISION) AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text,True);
    if not CheckBox1.Checked then
    begin
      with TFrmRPreview.Create(Self) do
      begin
         FrmReportPorEmisorInstrumentoSeries := TFrmReportPorEmisorInstrumentoSeries.Create(Self);
         Qry_excel := Qry_EmisorInstSerie;
         Table_Qry   := 2;
         with FrmReportPorEmisorInstrumentoSeries.frxReport1 do
         begin
            Label_Razon_Social      := FindObject('Label_Razon_Social') as TfrxMemoView;
            Label_Razon_Social.Text := sRazon_Social;
            Label_Direccion         := FindObject('Label_Direccion') as TfrxMemoView;
            Label_Direccion.Text    := sDireccion;
            Label_Ubicacion         := FindObject('Label_Ubicacion') as TfrxMemoView;
            Label_Ubicacion.Text    := sUbicacion;
            Lbl_Titulo              := FindObject('Lbl_Titulo') as TfrxMemoView;
            Lbl_Titulo.Text         := 'LIMITES DE INVERSION (EMISION) AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            ReportOptions.Name      := 'LIMITES DE INVERSION (EMISION) AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
            //if bdesarrollo then // para debuggear el report en ejecucion
            //   DesignReport;    // OJO poner libreria 'frxDesgn' en modulo del informe
            Preview := frxPreview1;
            PrepareReport(True);
            PrintOptions.ShowDialog :=True;
            ShowModal;
         end;
         FrmReportPorEmisorInstrumentoSeries.Free;
      end;
    end;
   end;
   if Check_Todos.Checked then
   begin
      with Qry_Todos_Reg do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select a.* '
               +'      ,z.Credencial As Credencial_Deudor'
               +'      ,z.NOMBRE_DEUDOR'
               +'      ,y.ID_CREDITO  '
               +'  from QS_SUP_251_DET a '
               +'       LEFT OUTER JOIN QS_TRA_OMD_DAT_BRAIZ z'
               +'               ON z.Folio_Interno = a.Folio_Interno '
               +'              AND z.Item_Omd      = a.Item_Omd '
               +'              AND z.Transaccion   = a.Transaccion '
               +'              AND z.Empresa       = a.Empresa '
               +'       LEFT OUTER JOIN QS_TRA_OMD_DAT_CRESIN y '
               +'               ON y.Folio_Interno = a.Folio_Interno  '
               +'              AND y.Item_Omd      = a.Item_Omd       '
               +'              AND y.Transaccion   = a.Transaccion    '
               +'              AND y.Empresa       = a.Empresa        '
               +' where a.FECHA_PROCESO = :fecha_proceso '
               +'   and a.proceso       = :proceso '
               +'   and a.empresa       = :empresa '
               +' order by a.CODIGO_LIMITE  ');

        ParamByName('Empresa').AsString         := sEmpresa_usuario;
        ParamByName('Fecha_Proceso').asDatetime := dFecha_Proceso;
        ParamByname('Proceso').asString         := FrmCalculoLimites.Ed_Proceso.Text;
        Open;

        if Check_UnLibro.Checked then
           Genera_excel_dll_libro_hojas(Qry_Todos_Reg,'DETALLE DE TODOS LOS LIMITES AL '+DateToStr(dFecha_Proceso),False,sArchivo_Excel)
        else
           Genera_excel_dll(Qry_Todos_Reg,'DETALLE DE TODOS LOS LIMITES AL '+DateToStr(dFecha_Proceso),True);
      end;
   end;

   if Check_Det_Excesos.Checked then
   begin
      Seleccion_Excesos;
//      with Qry_Todos_Reg do
//      begin
//        Close;
//        SQL.Clear;
//        SQL.Add(' select a.*, (a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA)   '
//               +' from  QS_SUP_251 a   '
//               +' where a.Empresa        = :Empresa'
//               +' and a.FECHA_PROCESO = :Fecha_Proceso '
//               +' and a.proceso = :Proceso   '
//               +' and (a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) < 0  '
//               +' order by a.CODIGO_LIMITE  ');
//
//        ParamByName('Empresa').AsString         := sEmpresa_usuario;
//        ParamByName('Fecha_Proceso').asDatetime := dFecha_Proceso;
//        ParamByname('Proceso').asString         := FrmCalculoLimites.Ed_Proceso.Text;
//        Open;

        if Check_UnLibro.Checked then
             Genera_excel_dll_libro_hojas(Qry_Todos_Reg,'DETALLE DE TODOS LOS LIMITES CON EXCESOS AL '+DateToStr(dFecha_Proceso),False,sArchivo_Excel)
          else
             Genera_excel_dll(Qry_Todos_Reg,'DETALLE DE TODOS LOS LIMITES CON EXCESOS AL '+DateToStr(dFecha_Proceso),True);
 //     end;
   end;

   if Check_UnLibro.Checked then
    begin
      PWFILE := PWideChar(sArchivo_Excel) ;
      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
    end;
end;

procedure TFrmDatosLimites.Seleccion_Excesos;
begin
  with Qry_Todos_Reg do
  begin
    if Check_Nom_Val.Checked = false then
     begin
       Close;
       SQL.Clear;
       SQL.Add(' select a.*, (a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) as MARGEN   '
              +' from  QS_SUP_251 a   '
              +' where a.Empresa     = :Empresa'
              +' and a.FECHA_PROCESO = :Fecha_Proceso '
              +' and a.proceso       = :Proceso   '
              +' and (a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) < 0  '
              +' order by a.CODIGO_LIMITE  ');

       ParamByName('Empresa').AsString         := sEmpresa_usuario;
       ParamByName('Fecha_Proceso').asDatetime := dFecha_Proceso;
       ParamByname('Proceso').asString         := FrmCalculoLimites.Ed_Proceso.Text;
     end
     else
     begin
       Close;
       SQL.Clear;
       SQL.Add(' SELECT a.EMPRESA  '
              +'       ,a.CARTERA  '
              +'       ,a.FECHA_PROCESO'
              +'       ,a.PROCESO '
              +'       ,a.CODIGO_LIMITE'
              +'       ,a.TIPO_LIMITE'
              +'       ,a.EMISOR      '
              +'       ,a.INSTRUMENTO '
              +'       ,a.GRUPO_EMISOR'
              +'       ,a.PORCENTAJE  '
              +'       ,a.VALOR_PTE_CARTERA'
              +'       ,a.MAXIMO_PERMITIDO '
              +'       ,a.MATRIZ          '
              +'       ,a.SERIES_INSCRITAS'
              +'       ,a.GRUPO_CARTERA   '
              +'       ,a.NEMOTECNICO   '
              +'       ,a.MONEDA_INSTRUM '
              +'       ,a.TIPO_CLASIF '
              +'       ,a.GRUPO_CLASIF '
              +'       ,a.MONEDA_CONVERSION_INFORME '
              +'       ,a.PORCENTAJE_MIN   '
              +'       ,a.MINIMO_PERMITIDO '
              +'       ,a.CREDENCIAL_DEUDOR '
              +'       ,a.NOMBRE_DEUDOR '
              +'       ,a.ID_CREDITO'
              +'       ,(a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) as MARGEN   '
              +' from  QS_SUP_251 a   '
              +'      ,QS_SUP_251_LIM d '
              +' where a.Empresa     = :Empresa'
              +' and a.FECHA_PROCESO = :Fecha_Proceso '
              +' and a.proceso       = :Proceso   '
              +' and (a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) < 0  '
              +'   AND d.CODIGO_LIMITE = a.CODIGO_LIMITE '
              +'   AND d.PROCESO       = a.PROCESO '
              +'   AND d.FECHA_DESDE IN (SELECT MAX(e.FECHA_DESDE) '
              +'                           FROM QS_SUP_251_LIM e '
              +'                          WHERE e.CODIGO_LIMITE = a.CODIGO_LIMITE '
              +'                            AND e.PROCESO 		  = a.PROCESO '
              +'                            AND e.FECHA_DESDE  <= a.FECHA_PROCESO '
              +'                            AND (e.FECHA_HASTA >= a.FECHA_PROCESO OR e.FECHA_HASTA IS NULL)) '
              +'   AND (d.CODIGO_PORCENTAJE NOT IN (''EMISION'',''ACCIONES'',''CUOTAS'') or d.CODIGO_PORCENTAJE is null) ');
       SQL.Add(' UNION ');
       SQL.Add(' SELECT a.EMPRESA  '
              +'       ,a.CARTERA  '
              +'       ,a.FECHA_PROCESO'
              +'       ,a.PROCESO '
              +'       ,a.CODIGO_LIMITE'
              +'       ,a.TIPO_LIMITE'
              +'       ,a.EMISOR      '
              +'       ,a.INSTRUMENTO '
              +'       ,a.GRUPO_EMISOR'
              +'       ,a.PORCENTAJE  '
              +'       ,SUM(e.VALOR_FINAL_SVS_MC) as VALOR_PTE_CARTERA '
              +'       ,SUM(e.VALOR_PTE_MC_CPA) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MAXIMO_PERMITIDO '
              +'       ,a.MATRIZ          '
              +'       ,a.SERIES_INSCRITAS'
              +'       ,a.GRUPO_CARTERA   '
              +'       ,a.NEMOTECNICO   '
              +'       ,a.MONEDA_INSTRUM '
              +'       ,a.TIPO_CLASIF '
              +'       ,a.GRUPO_CLASIF '
              +'       ,a.MONEDA_CONVERSION_INFORME '
              +'       ,a.PORCENTAJE_MIN   '
              +'       ,SUM(e.VALOR_PTE_MC_CPA) * a.MINIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MINIMO_PERMITIDO '
              +'       ,a.CREDENCIAL_DEUDOR '
              +'       ,a.NOMBRE_DEUDOR '
              +'       ,a.ID_CREDITO'
              +'      ,((SUM(e.VALOR_PTE_MC_CPA) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA) - SUM(e.VALOR_FINAL_SVS_MC)) as MARGEN  '
              +' from  QS_SUP_251 a   '
              +'      ,QS_SUP_251_LIM d '
              +'	     ,QS_SUP_251_DET b '
              +'	     ,QS_RES_MERCADO e '
              +' where a.Empresa       = :Empresa'
              +'   and a.FECHA_PROCESO = :Fecha_Proceso '
              +'   and a.proceso       = :Proceso   '
              +'   and (a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) < 0  '
              +'   AND d.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'   AND d.PROCESO       = a.PROCESO '
               +'   AND d.FECHA_DESDE   IN (SELECT MAX(e.FECHA_DESDE) '
               +'                             FROM QS_SUP_251_LIM e '
               +'                            WHERE e.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'                              AND e.PROCESO 		= a.PROCESO '
               +'                              AND e.FECHA_DESDE  <= a.FECHA_PROCESO '
               +'                              AND (e.FECHA_HASTA >= a.FECHA_PROCESO OR e.FECHA_HASTA IS NULL)) '
               +'   AND d.CODIGO_PORCENTAJE  IN (''EMISION'',''ACCIONES'',''CUOTAS'') '
               +'   AND b.FECHA_PROCESO      = a.FECHA_PROCESO '
               +'   AND b.PROCESO            = a.PROCESO '
               +'   AND b.CODIGO_LIMITE      = a.CODIGO_LIMITE '
               +'   AND b.EMPRESA            = a.EMPRESA '
               +'   AND b.EMISOR             = a.EMISOR '
               +'   AND ((a.Instrumento      = b.Instrumento) or (a.Instrumento is null)) '
               +'   AND ((a.Nemotecnico      = b.Nemotecnico) or (a.Nemotecnico is null)) '
               +'   AND ((b.SERIES_INSCRITAS = a.SERIES_INSCRITAS) OR (a.SERIES_INSCRITAS IS NULL)) '
               +'   AND e.FECHA_CIERRE       = b.FECHA_PROCESO '
               +'   AND e.FOLIO_INTERNO      = b.FOLIO_INTERNO '
               +'   AND e.ITEM_OMD           = b.ITEM_OMD '
               +'   AND e.TRANSACCION        = b.TRANSACCION '
               +'   AND e.EMPRESA            = b.EMPRESA ');
        sql.add(' GROUP BY a.EMPRESA  '
              +'       ,a.CARTERA  '
              +'       ,a.FECHA_PROCESO'
              +'       ,a.PROCESO '
              +'       ,a.CODIGO_LIMITE'
              +'       ,a.TIPO_LIMITE'
              +'       ,a.EMISOR      '
              +'       ,a.INSTRUMENTO '
              +'       ,a.GRUPO_EMISOR'
              +'       ,a.PORCENTAJE  '
              +'       ,a.MATRIZ          '
              +'       ,a.SERIES_INSCRITAS'
              +'       ,a.GRUPO_CARTERA   '
              +'       ,a.NEMOTECNICO   '
              +'       ,a.MONEDA_INSTRUM '
              +'       ,a.TIPO_CLASIF '
              +'       ,a.GRUPO_CLASIF '
              +'       ,a.MONEDA_CONVERSION_INFORME '
              +'       ,a.PORCENTAJE_MIN   '
              +'       ,a.CREDENCIAL_DEUDOR '
              +'       ,a.NOMBRE_DEUDOR '
              +'       ,a.ID_CREDITO'
              +'       ,a.MAXIMO_PERMITIDO '
              +'       ,a.VALOR_PTE_CARTERA'
              +'       ,a.MINIMO_PERMITIDO ');
        SQL.Add(' UNION ');
        SQL.Add(' SELECT a.EMPRESA  '
              +'       ,a.CARTERA  '
              +'       ,a.FECHA_PROCESO'
              +'       ,a.PROCESO '
              +'       ,a.CODIGO_LIMITE'
              +'       ,a.TIPO_LIMITE'
              +'       ,a.EMISOR      '
              +'       ,a.INSTRUMENTO '
              +'       ,a.GRUPO_EMISOR'
              +'       ,a.PORCENTAJE  '
              +'       ,SUM(e.TOTAL_FINAL) as VALOR_PTE_CARTERA '
              +'       ,SUM(e.TOTAL_FINAL) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MAXIMO_PERMITIDO '
              +'       ,a.MATRIZ          '
              +'       ,a.SERIES_INSCRITAS'
              +'       ,a.GRUPO_CARTERA   '
              +'       ,a.NEMOTECNICO   '
              +'       ,a.MONEDA_INSTRUM '
              +'       ,a.TIPO_CLASIF '
              +'       ,a.GRUPO_CLASIF '
              +'       ,a.MONEDA_CONVERSION_INFORME '
              +'       ,a.PORCENTAJE_MIN   '
              +'       ,SUM(e.TOTAL_FINAL) * a.MINIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MINIMO_PERMITIDO '
              +'       ,a.CREDENCIAL_DEUDOR '
              +'       ,a.NOMBRE_DEUDOR '
              +'       ,a.ID_CREDITO'
              +'      ,((SUM(e.TOTAL_FINAL) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA) - SUM(e.TOTAL_FINAL)) as MARGEN  '
              +'  from  QS_SUP_251 a   '
              +'	     ,QS_SUP_251_DET     b '
              +'	     ,QS_SUP_251_LIM     d '
              +'	     ,QS_RES_VALORIZA_RV e '
              +' where a.Empresa       = :Empresa'
              +'   and a.FECHA_PROCESO = :Fecha_Proceso '
              +'   and a.proceso       = :Proceso   '
              +'   and (a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) < 0  '
              +'   AND d.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'   AND d.PROCESO       = a.PROCESO '
               +'   AND d.FECHA_DESDE   IN (SELECT MAX(e.FECHA_DESDE) '
               +'                             FROM QS_SUP_251_LIM e '
               +'                            WHERE e.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'                              AND e.PROCESO 		= a.PROCESO '
               +'                              AND e.FECHA_DESDE  <= a.FECHA_PROCESO '
               +'                              AND (e.FECHA_HASTA >= a.FECHA_PROCESO OR e.FECHA_HASTA IS NULL)) '
               +'   AND d.CODIGO_PORCENTAJE  IN (''EMISION'',''ACCIONES'',''CUOTAS'') '
               +'   AND b.FECHA_PROCESO      = a.FECHA_PROCESO '
               +'   AND b.PROCESO            = a.PROCESO '
               +'   AND b.CODIGO_LIMITE      = a.CODIGO_LIMITE '
               +'   AND b.EMPRESA            = a.EMPRESA '
               +'   AND b.EMISOR             = a.EMISOR '
               +'   AND ((a.Instrumento      = b.Instrumento) or (a.Instrumento is null)) '
               +'   AND ((a.Nemotecnico      = b.Nemotecnico) or (a.Nemotecnico is null)) '
               +'   AND ((b.SERIES_INSCRITAS = a.SERIES_INSCRITAS) OR (a.SERIES_INSCRITAS IS NULL)) '
               +'   AND e.FECHA_CIERRE       = b.FECHA_PROCESO '
               +'   AND e.NEMOTECNICO        = b.NEMOTECNICO '
               +'   AND e.TRANSACCION        = b.TRANSACCION '
               +'   AND e.CARTERA            = b.CARTERA '
               +'   AND e.EMPRESA            = b.EMPRESA ');
        sql.add(' GROUP BY a.EMPRESA  '
              +'       ,a.CARTERA  '
              +'       ,a.FECHA_PROCESO'
              +'       ,a.PROCESO '
              +'       ,a.CODIGO_LIMITE'
              +'       ,a.TIPO_LIMITE'
              +'       ,a.EMISOR      '
              +'       ,a.INSTRUMENTO '
              +'       ,a.GRUPO_EMISOR'
              +'       ,a.PORCENTAJE  '
              +'       ,a.MATRIZ          '
              +'       ,a.SERIES_INSCRITAS'
              +'       ,a.GRUPO_CARTERA   '
              +'       ,a.NEMOTECNICO   '
              +'       ,a.MONEDA_INSTRUM '
              +'       ,a.TIPO_CLASIF '
              +'       ,a.GRUPO_CLASIF '
              +'       ,a.MONEDA_CONVERSION_INFORME '
              +'       ,a.PORCENTAJE_MIN   '
              +'       ,a.CREDENCIAL_DEUDOR '
              +'       ,a.NOMBRE_DEUDOR '
              +'       ,a.ID_CREDITO'
              +'       ,a.MAXIMO_PERMITIDO '
              +'       ,a.VALOR_PTE_CARTERA'
              +'       ,a.MINIMO_PERMITIDO ');

       ParamByName('Empresa').AsString         := sEmpresa_usuario;
       ParamByName('Fecha_Proceso').asDatetime := dFecha_Proceso;
       ParamByname('Proceso').asString         := FrmCalculoLimites.Ed_Proceso.Text;
     end;
    Open;

  end;
end;

procedure TFrmDatosLimites.BitBtn2Click(Sender: TObject);
begin
   Qry_Limite.Filtered := False;
   if Chk_TipoLimites.Checked then
   begin
      Qry_Limite.Filter   := ' TIPO_LIMITE = '''+Ed_TipoLimite.Text+'''';
      Qry_Limite.Filtered := True;
      Qry_Limite.close;
      Qry_Limite.Open
   end;
   BTN_SeleccionarClick(Sender);
   bImprimir := False;
end;

procedure TFrmDatosLimites.DataLimitesDataChange(Sender: TObject;
  Field: TField);
begin
   if bImprimir then
     Exit;

   BTN_SeleccionarClick(Sender);
end;

procedure TFrmDatosLimites.Qry_LimiteCalcFields(DataSet: TDataSet);
begin
   dataset.Fieldbyname('Margen').asFloat :=
           dataset.Fieldbyname('MAXIMO_PERMITIDO').asFloat -
           dataset.Fieldbyname('VALOR_PTE_CARTERA').asFloat;
end;

procedure TFrmDatosLimites.Qry_GrupoCalcFields(DataSet: TDataSet);
begin
    DataSet.Fieldbyname('Margen_Permitido').asFloat :=
            DataSet.Fieldbyname('Maximo_Permitido').asFloat -
            DataSet.Fieldbyname('VALOR_PTE_CARTERA').asFloat;
end;

procedure TFrmDatosLimites.Qry_EmisorInstSerieCalcFields(
  DataSet: TDataSet);
begin
    DataSet.Fieldbyname('Margen_Permitido').asFloat :=
            DataSet.Fieldbyname('Maximo_Permitido').asFloat -
            DataSet.Fieldbyname('Nominales').asFloat;
end;

procedure TFrmDatosLimites.BitBtn1Click(Sender: TObject);
var sRazon_Social,
    sDireccion,
    sUbicacion         : String;
    Result             : Boolean;
    Label_Razon_Social,
    Label_Direccion,
    Lbl_Titulo,
    Label_Ubicacion    : TfrxMemoView;
begin
   Leer_Identidad_Direccion(sEmpresa_Usuario,
                            fItem_Dir_Usuario,
                            sRazon_Social,
                            sDireccion,
                            sUbicacion,
                            Result);

   with TFrmRPreview.Create(Self) do
   begin
      FrmReportLimitesDetalle := TFrmReportLimitesDetalle.Create(Self);
      Qry_excel := Qry_Limite_Det;
      Table_Qry   := 2;
      with FrmReportLimitesDetalle.ReportLimites do
      begin
         Label_Razon_Social      := FindObject('Label_Razon_Social') as TfrxMemoView;
         Label_Razon_Social.Text := sRazon_Social;
         Label_Direccion         := FindObject('Label_Direccion') as TfrxMemoView;
         Label_Direccion.Text    := sDireccion;
         Label_Ubicacion         := FindObject('Label_Ubicacion') as TfrxMemoView;
         Label_Ubicacion.Text    := sUbicacion;
         Lbl_Titulo              := FindObject('Lbl_Titulo') as TfrxMemoView;
         Lbl_Titulo.Text         := 'DETALLE OMD LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
         ReportOptions.Name      := 'DETALLE OMD LIMITES DE INVERSION AL '+DateToStr(dFecha_Proceso)+' CARTERA '+FrmCalculoLimites.Combo_Cartera.Text;
         Preview := frxPreview1;
         PrepareReport(True);
         PrintOptions.ShowDialog :=True;
         ShowModal;
      end;
      FrmReportLimitesDetalle.Free;
   end;
end;

procedure TFrmDatosLimites.Seleccion_Detalle;
begin

  With Qry_Detalle do
  begin
     Sql.Clear;
     sql.Add('SELECT a.EMPRESA '
            +'      ,a.CARTERA '
            +'	    ,a.FECHA_PROCESO '
            +'	    ,a.PROCESO '
            +'	    ,a.CODIGO_LIMITE '
            +'	    ,a.TIPO_LIMITE '
            +'	    ,a.EMISOR '
            +'	    ,a.INSTRUMENTO '
            +'	    ,a.GRUPO_EMISOR '
            +'	    ,a.PORCENTAJE '
            +'      ,a.VALOR_PTE_CARTERA '
            +'      ,a.MAXIMO_PERMITIDO '
            +'	    ,a.MATRIZ '
            +'	    ,a.SERIES_INSCRITAS '
            +'	    ,a.GRUPO_CARTERA '
            +'	    ,a.NEMOTECNICO '
            +'	    ,a.MONEDA_INSTRUM '
            +'	    ,a.TIPO_CLASIF '
            +'	    ,a.GRUPO_CLASIF '
            +'	    ,a.MONEDA_CONVERSION_INFORME '
            +'      ,a.MINIMO_PERMITIDO '
            +'	    ,a.PORCENTAJE_MIN '
            +'	    ,a.CREDENCIAL_DEUDOR '
            +'	    ,a.NOMBRE_DEUDOR '
            +'      ,a.ID_CREDITO '
            +'      ,b.DESCRIPCION_NODO AS desc_detail '
            +'      ,(a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) as Margen '
            +'      ,a.CREDENCIAL_DEUDOR '
            +'      ,a.NOMBRE_DEUDOR '
            +'  FROM QS_SUP_251     a '
            +'       LEFT JOIN QS_SYS_EST_CLA b '
            +'              ON b.codigo_objeto = a.tipo_clasif'
            +'             AND b.nodo          = a.grupo_clasif '
            +' WHERE a.Empresa        = :Empresa'
            +'   AND a.Fecha_Proceso  = :Fecha_Proceso'
            +'   AND a.Proceso        = :Proceso'
            +'   AND a.Tipo_Clasif IS NOT NULL '
            );
     if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
     begin
       sql.add('    AND a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
       sql.add('                       WHERE  pid = :pid ');
       sql.add('                         and z.empresa = a.empresa ');
       sql.add('                     ) ');
       sql.add('    AND a.cartera  = :Cartera' );
       ParamByName('pid').AsFloat := Application.Handle;
     end
     else
     begin
        sql.add('AND a.EMPRESA   = :EMPRESA ');
        sql.add('AND a.CARTERA   = :CARTERA ');
     end;
     sql.Add(' UNION ');

     if Check_Nom_Val.Checked = false then
     begin
        sql.Add('SELECT a.EMPRESA '
               +'      ,a.CARTERA '
               +'	     ,a.FECHA_PROCESO '
               +'	     ,a.PROCESO '
               +'	     ,a.CODIGO_LIMITE '
               +'	     ,a.TIPO_LIMITE '
               +'	     ,a.EMISOR '
               +'	     ,a.INSTRUMENTO '
               +'	     ,a.GRUPO_EMISOR '
               +'	     ,a.PORCENTAJE '
               +'      ,a.VALOR_PTE_CARTERA '
               +'      ,a.MAXIMO_PERMITIDO '
               +'	     ,a.MATRIZ '
               +'	     ,a.SERIES_INSCRITAS '
               +'	     ,a.GRUPO_CARTERA '
               +'	     ,a.NEMOTECNICO '
               +'	     ,a.MONEDA_INSTRUM '
               +'	     ,a.TIPO_CLASIF '
               +'	     ,a.GRUPO_CLASIF '
               +'	     ,a.MONEDA_CONVERSION_INFORME '
               +'      ,a.MINIMO_PERMITIDO '
               +'	     ,a.PORCENTAJE_MIN '
               +'	     ,a.CREDENCIAL_DEUDOR '
               +'	     ,a.NOMBRE_DEUDOR '
               +'      ,a.ID_CREDITO '
               +'      ,b.desc_detail '
               +'      ,(a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) as Margen'
               +'      ,a.CREDENCIAL_DEUDOR '
               +'      ,a.NOMBRE_DEUDOR '
               +'  FROM QS_SUP_251     a '
               +'       LEFT JOIN QS_SYS_COD_DET b '
               +'              ON b.Cod_General = ''GRUPOSEMP'' '
               +'             AND b.COd_Detail  = a.GRUPO_EMISOR '
               +' WHERE a.Empresa        = :Empresa'
               +'   AND a.Fecha_Proceso  = :Fecha_Proceso'
               +'   AND a.Proceso        = :Proceso'
               +'   AND a.Tipo_Clasif IS NULL '
            );
        if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
        begin
          sql.add('    AND a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
          sql.add('                       WHERE  pid = :pid ');
          sql.add('                         and z.empresa = a.empresa ');
          sql.add('                     ) ');
          sql.add('    AND a.cartera  = :Cartera' );
          ParamByName('pid').AsFloat := Application.Handle;
        end
        else
        begin
           sql.add('AND a.EMPRESA   = :EMPRESA ');
           sql.add('AND a.CARTERA   = :CARTERA ');
        end;
     end
     else
     begin
        sql.Add('SELECT a.EMPRESA '
               +'      ,a.CARTERA '
               +'	     ,a.FECHA_PROCESO '
               +'	     ,a.PROCESO '
               +'	     ,a.CODIGO_LIMITE '
               +'	     ,a.TIPO_LIMITE '
               +'	     ,a.EMISOR '
               +'	     ,a.INSTRUMENTO '
               +'	     ,a.GRUPO_EMISOR '
               +'	     ,a.PORCENTAJE '
               +'      ,a.VALOR_PTE_CARTERA '
               +'      ,a.MAXIMO_PERMITIDO '
               +'	     ,a.MATRIZ '
               +'	     ,a.SERIES_INSCRITAS '
               +'	     ,a.GRUPO_CARTERA '
               +'	     ,a.NEMOTECNICO '
               +'	     ,a.MONEDA_INSTRUM '
               +'	     ,a.TIPO_CLASIF '
               +'	     ,a.GRUPO_CLASIF '
               +'	     ,a.MONEDA_CONVERSION_INFORME '
               +'      ,a.MINIMO_PERMITIDO '
               +'	     ,a.PORCENTAJE_MIN '
               +'	     ,a.CREDENCIAL_DEUDOR '
               +'	     ,a.NOMBRE_DEUDOR '
               +'      ,a.ID_CREDITO '
               +'      ,b.desc_detail '
               +'      ,(a.MAXIMO_PERMITIDO - a.VALOR_PTE_CARTERA) as Margen'
               +'      ,a.CREDENCIAL_DEUDOR '
               +'      ,a.NOMBRE_DEUDOR '
               +'  FROM QS_SUP_251     a '
               +'       LEFT JOIN QS_SYS_COD_DET b '
               +'              ON b.Cod_General = ''GRUPOSEMP'' '
               +'             AND b.COd_Detail  = a.GRUPO_EMISOR '
	             +'      ,QS_SUP_251_LIM d '
               +' WHERE a.Empresa        = :Empresa'
               +'   AND a.Fecha_Proceso  = :Fecha_Proceso'
               +'   AND a.Proceso        = :Proceso'
               +'   AND a.Tipo_Clasif IS NULL '
               +'   AND d.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'   AND d.PROCESO       = a.PROCESO '
               +'   AND d.FECHA_DESDE IN (SELECT MAX(e.FECHA_DESDE) '
               +'                           FROM QS_SUP_251_LIM e '
               +'                          WHERE e.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'                            AND e.PROCESO 		= a.PROCESO '
               +'                            AND e.FECHA_DESDE  <= a.FECHA_PROCESO '
               +'                            AND (e.FECHA_HASTA >= a.FECHA_PROCESO OR e.FECHA_HASTA IS NULL)) '
               +'   AND (d.CODIGO_PORCENTAJE NOT IN (''EMISION'',''ACCIONES'',''CUOTAS'') or d.CODIGO_PORCENTAJE is null) '
               );
        if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
        begin
          sql.add('    AND a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
          sql.add('                       WHERE  pid = :pid ');
          sql.add('                         and z.empresa = a.empresa ');
          sql.add('                     ) ');
          sql.add('    AND a.cartera  = :Cartera' );
          ParamByName('pid').AsFloat := Application.Handle;
        end
        else
        begin
           sql.add('AND a.EMPRESA   = :EMPRESA ');
           sql.add('AND a.CARTERA   = :CARTERA ');
        end;
        sql.Add(' UNION ');
        sql.Add('SELECT a.EMPRESA '
               +'      ,a.CARTERA '
               +'	     ,a.FECHA_PROCESO '
               +'	     ,a.PROCESO '
               +'	     ,a.CODIGO_LIMITE '
               +'	     ,a.TIPO_LIMITE '
               +'	     ,a.EMISOR '
               +'	     ,a.INSTRUMENTO '
               +'	     ,a.GRUPO_EMISOR '
               +'	     ,a.PORCENTAJE '
               +'      ,SUM(e.VALOR_FINAL_SVS_MC) as VALOR_PTE_CARTERA '
               +'      ,SUM(e.VALOR_PTE_MC_CPA) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MAXIMO_PERMITIDO '
               +'	     ,a.MATRIZ '
               +'	     ,a.SERIES_INSCRITAS '
               +'	     ,a.GRUPO_CARTERA '
               +'	     ,a.NEMOTECNICO '
               +'	     ,a.MONEDA_INSTRUM '
               +'	     ,a.TIPO_CLASIF '
               +'	     ,a.GRUPO_CLASIF '
               +'	     ,a.MONEDA_CONVERSION_INFORME '
               +'      ,SUM(e.VALOR_PTE_MC_CPA) * a.MINIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MINIMO_PERMITIDO '
               +'	     ,a.PORCENTAJE_MIN '
               +'	     ,a.CREDENCIAL_DEUDOR '
               +'	     ,a.NOMBRE_DEUDOR '
               +'      ,a.ID_CREDITO '
               +'      ,c.DESC_DETAIL '
               +'      ,((SUM(e.VALOR_PTE_MC_CPA) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA) - SUM(e.VALOR_FINAL_SVS_MC)) as MARGEN  '
               +'      ,a.CREDENCIAL_DEUDOR '
               +'      ,a.NOMBRE_DEUDOR '
               +'  FROM QS_SUP_251     a  '
               +'       LEFT JOIN QS_SYS_COD_DET c '
               +'              ON c.Cod_General = ''GRUPOSEMP'' '
               +'             AND c.COd_Detail  = a.GRUPO_EMISOR '
               +'	     ,QS_SUP_251_DET b '
               +'	     ,QS_SUP_251_LIM d '
               +'	     ,QS_RES_MERCADO e '
               +' WHERE a.Empresa       = :Empresa'
               +'   AND a.Fecha_Proceso = :Fecha_Proceso'
               +'   AND a.Proceso       = :Proceso'
               +'   AND a.Tipo_Clasif   IS NULL '
               +'   AND d.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'   AND d.PROCESO       = a.PROCESO '
               +'   AND d.FECHA_DESDE   IN (SELECT MAX(e.FECHA_DESDE) '
               +'                             FROM QS_SUP_251_LIM e '
               +'                            WHERE e.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'                              AND e.PROCESO 		= a.PROCESO '
               +'                              AND e.FECHA_DESDE  <= a.FECHA_PROCESO '
               +'                              AND (e.FECHA_HASTA >= a.FECHA_PROCESO OR e.FECHA_HASTA IS NULL)) '
               +'   AND d.CODIGO_PORCENTAJE  IN (''EMISION'',''ACCIONES'',''CUOTAS'') '
               +'   AND b.FECHA_PROCESO      = a.FECHA_PROCESO '
               +'   AND b.PROCESO            = a.PROCESO '
               +'   AND b.CODIGO_LIMITE      = a.CODIGO_LIMITE '
               +'   AND b.EMPRESA            = a.EMPRESA '
               +'   AND b.EMISOR             = a.EMISOR '
               +'   AND ((a.Instrumento      = b.Instrumento) or (a.Instrumento is null)) '
               +'   AND ((a.Nemotecnico      = b.Nemotecnico) or (a.Nemotecnico is null)) '
               +'   AND ((b.SERIES_INSCRITAS = a.SERIES_INSCRITAS) OR (a.SERIES_INSCRITAS IS NULL)) '
               +'   AND e.FECHA_CIERRE       = b.FECHA_PROCESO '
               +'   AND e.FOLIO_INTERNO      = b.FOLIO_INTERNO '
               +'   AND e.ITEM_OMD           = b.ITEM_OMD '
               +'   AND e.TRANSACCION        = b.TRANSACCION '
               +'   AND e.EMPRESA            = b.EMPRESA '
               );
        if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
        begin
          sql.add(' AND a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
          sql.add('                    WHERE  pid = :pid ');
          sql.add('                      and z.empresa = a.empresa ');
          sql.add('                  ) ');
          sql.add(' AND a.cartera  = :Cartera' );
          ParamByName('pid').AsFloat := Application.Handle;
        end
        else
        begin
          sql.add(' AND a.EMPRESA   = :EMPRESA ');
          sql.add(' AND a.CARTERA   = :CARTERA ');
        end;
        sql.add(' GROUP BY a.EMPRESA '
               +'         ,a.CARTERA '
               +'	        ,a.FECHA_PROCESO '
               +'	        ,a.PROCESO '
               +'	        ,a.CODIGO_LIMITE '
               +'	        ,a.TIPO_LIMITE '
               +'	        ,a.EMISOR '
               +'	        ,a.INSTRUMENTO '
               +'	        ,a.GRUPO_EMISOR '
               +'	        ,a.PORCENTAJE '
               +'	        ,a.VALOR_PTE_CARTERA '
               +'	        ,a.MAXIMO_PERMITIDO '
               +'	        ,a.MATRIZ '
               +'	        ,a.SERIES_INSCRITAS '
               +'	        ,a.GRUPO_CARTERA '
               +'	        ,a.NEMOTECNICO '
               +'	        ,a.MONEDA_INSTRUM '
               +'	        ,a.TIPO_CLASIF '
               +'	        ,a.GRUPO_CLASIF '
               +'	        ,a.MONEDA_CONVERSION_INFORME '
               +'	        ,a.MINIMO_PERMITIDO '
               +'	        ,a.PORCENTAJE_MIN '
               +'	        ,a.CREDENCIAL_DEUDOR '
               +'	        ,a.NOMBRE_DEUDOR '
               +'         ,c.DESC_DETAIL '
               +'         ,a.CREDENCIAL_DEUDOR  '
               +'         ,a.NOMBRE_DEUDOR '
               +'	        ,d.CODIGO_PORCENTAJE '
               +'         ,a.ID_CREDITO '  );
        sql.Add(' UNION ');
        sql.Add('SELECT a.EMPRESA '
               +'      ,a.CARTERA '
               +'	     ,a.FECHA_PROCESO '
               +'	     ,a.PROCESO '
               +'	     ,a.CODIGO_LIMITE '
               +'	     ,a.TIPO_LIMITE '
               +'	     ,a.EMISOR '
               +'	     ,a.INSTRUMENTO '
               +'	     ,a.GRUPO_EMISOR '
               +'	     ,a.PORCENTAJE '
               +'      ,SUM(e.TOTAL_FINAL) as VALOR_PTE_CARTERA '
               +'      ,SUM(e.TOTAL_FINAL) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MAXIMO_PERMITIDO '
               +'	     ,a.MATRIZ '
               +'	     ,a.SERIES_INSCRITAS '
               +'	     ,a.GRUPO_CARTERA '
               +'	     ,a.NEMOTECNICO '
               +'	     ,a.MONEDA_INSTRUM '
               +'	     ,a.TIPO_CLASIF '
               +'	     ,a.GRUPO_CLASIF '
               +'	     ,a.MONEDA_CONVERSION_INFORME '
               +'      ,SUM(e.TOTAL_FINAL) * a.MINIMO_PERMITIDO / a.VALOR_PTE_CARTERA as MINIMO_PERMITIDO '
               +'	     ,a.PORCENTAJE_MIN '
               +'	     ,a.CREDENCIAL_DEUDOR '
               +'	     ,a.NOMBRE_DEUDOR '
               +'      ,a.ID_CREDITO '
               +'      ,c.DESC_DETAIL '
               +'      ,((SUM(e.TOTAL_FINAL) * a.MAXIMO_PERMITIDO / a.VALOR_PTE_CARTERA) - SUM(e.TOTAL_FINAL)) as MARGEN  '
               +'      ,a.CREDENCIAL_DEUDOR '
               +'      ,a.NOMBRE_DEUDOR '
               +'  FROM QS_SUP_251         a '
               +'       LEFT JOIN QS_SYS_COD_DET c '
               +'              ON c.Cod_General = ''GRUPOSEMP'' '
               +'             AND c.COd_Detail  = a.GRUPO_EMISOR '
               +'	     ,QS_SUP_251_DET     b '
               +'	     ,QS_SUP_251_LIM     d '
               +'	     ,QS_RES_VALORIZA_RV e '
               +' WHERE a.Empresa       = :Empresa'
               +'   AND a.Fecha_Proceso = :Fecha_Proceso'
               +'   AND a.Proceso       = :Proceso'
               +'   AND a.Tipo_Clasif   IS NULL '
               +'   AND d.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'   AND d.PROCESO       = a.PROCESO '
               +'   AND d.FECHA_DESDE   IN (SELECT MAX(e.FECHA_DESDE) '
               +'                             FROM QS_SUP_251_LIM e '
               +'                            WHERE e.CODIGO_LIMITE = a.CODIGO_LIMITE '
               +'                              AND e.PROCESO 		= a.PROCESO '
               +'                              AND e.FECHA_DESDE  <= a.FECHA_PROCESO '
               +'                              AND (e.FECHA_HASTA >= a.FECHA_PROCESO OR e.FECHA_HASTA IS NULL)) '
               +'   AND d.CODIGO_PORCENTAJE  IN (''EMISION'',''ACCIONES'',''CUOTAS'') '
               +'   AND b.FECHA_PROCESO      = a.FECHA_PROCESO '
               +'   AND b.PROCESO            = a.PROCESO '
               +'   AND b.CODIGO_LIMITE      = a.CODIGO_LIMITE '
               +'   AND b.EMPRESA            = a.EMPRESA '
               +'   AND b.EMISOR             = a.EMISOR '
               +'   AND ((a.Instrumento      = b.Instrumento) or (a.Instrumento is null)) '
               +'   AND ((a.Nemotecnico      = b.Nemotecnico) or (a.Nemotecnico is null)) '
               +'   AND ((b.SERIES_INSCRITAS = a.SERIES_INSCRITAS) OR (a.SERIES_INSCRITAS IS NULL)) '
               +'   AND e.FECHA_CIERRE       = b.FECHA_PROCESO '
               +'   AND e.NEMOTECNICO        = b.NEMOTECNICO '
               +'   AND e.TRANSACCION        = b.TRANSACCION '
               +'   AND e.CARTERA            = b.CARTERA '
               +'   AND e.EMPRESA            = b.EMPRESA '
               );
        if FrmCalculoLimites.Chk_Carteras.State = cbChecked then
        begin
          sql.add(' AND a.empresa in (SELECT z.empresa from QS_SYS_PARAM_EMPRESA z  ');
          sql.add('                    WHERE  pid = :pid ');
          sql.add('                      and z.empresa = a.empresa ');
          sql.add('                  ) ');
          sql.add(' AND a.cartera  = :Cartera' );
          ParamByName('pid').AsFloat := Application.Handle;
        end
        else
        begin
          sql.add(' AND a.EMPRESA   = :EMPRESA ');
          sql.add(' AND a.CARTERA   = :CARTERA ');
        end;
        sql.add(' GROUP BY a.EMPRESA '
               +'         ,a.CARTERA '
               +'	        ,a.FECHA_PROCESO '
               +'	        ,a.PROCESO '
               +'	        ,a.CODIGO_LIMITE '
               +'	        ,a.TIPO_LIMITE '
               +'	        ,a.EMISOR '
               +'	        ,a.INSTRUMENTO '
               +'	        ,a.GRUPO_EMISOR '
               +'	        ,a.PORCENTAJE '
               +'	        ,a.VALOR_PTE_CARTERA '
               +'	        ,a.MAXIMO_PERMITIDO '
               +'	        ,a.MATRIZ '
               +'	        ,a.SERIES_INSCRITAS '
               +'	        ,a.GRUPO_CARTERA '
               +'	        ,a.NEMOTECNICO '
               +'	        ,a.MONEDA_INSTRUM '
               +'	        ,a.TIPO_CLASIF '
               +'	        ,a.GRUPO_CLASIF '
               +'	        ,a.MONEDA_CONVERSION_INFORME '
               +'	        ,a.MINIMO_PERMITIDO '
               +'	        ,a.PORCENTAJE_MIN '
               +'	        ,a.CREDENCIAL_DEUDOR '
               +'	        ,a.NOMBRE_DEUDOR '
               +'         ,a.ID_CREDITO '
               +'         ,c.DESC_DETAIL '
               +'         ,a.CREDENCIAL_DEUDOR  '
               +'         ,a.NOMBRE_DEUDOR '
               +'	        ,d.CODIGO_PORCENTAJE ');
     end;

     ParamByname('Empresa').asString         := sEmpresa_Usuario;
     ParamByname('Cartera').asString         := FrmCalculoLimites.Combo_Cartera.Text;
     ParamByname('Proceso').asString         := FrmCalculoLimites.Ed_Proceso.Text;
     ParamByname('Fecha_Proceso').asDatetime := dFecha_Proceso;

     Open;
  end;
end;

end.

