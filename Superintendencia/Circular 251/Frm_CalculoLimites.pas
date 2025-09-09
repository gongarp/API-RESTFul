unit Frm_CalculoLimites;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, StdCtrls, Mask, wwdblook, Buttons, DB, DBTables, Wwquery, Wwtable,
    Grids, Wwdbigrd, Wwdbgrid, Wwdatsrc, ComCtrls, wwidlg, OvcABtn, IniFiles,
    DM_Variables_Valorizacion, vcl.wwDialog, RxToolEdit, variants, FireDAC.Stan.Intf,
    FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
    FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLiteVDataSet, frxClass;

  type

    TReg_Grupos_Emisores = Record
      Grupo_Emisor: Variant;
      Valor_Cartera: Variant;
    End;

    TReg_Grupos_EmiClasif = Record
      Tipo_Clasif: Variant;
      Grupo_Clasif: Variant;
      Valor_Cartera: Variant;
    End;

    TReg_Emisores = Record
      Emisor: Variant;
      Emisor_Matriz: Variant;
      Valor_Cartera: Variant;
      Grupo_Emisor: Variant;
    End;

    TReg_Errores_Grupo = Record
      Emisor: Variant;
      Error: Variant;
    End;

    TReg_Series_Inscritas = Record
      CODIGO_EMISOR: Variant;
      CODIGO_INSTRUMENTO: Variant;
      Series: Variant;
      MONTO_INSCRIPCION: Variant;
      MONEDA_INSCRIPCION: Variant;
    End;

    TReg_Emisores_Nem = Record
      Emisor: Variant;
      Instrumento: Variant;
      Nemotecnico: Variant;
      Valor_Cartera: Variant;
    End;

    TReg_Deudores_Mem = Record
      Deudor: Variant;
      Nombre_Deudor: Variant;
      Valor_Cartera: Variant;
    End;

    TReg_Creditos_Mem = Record
      Id_Credito: Variant;
      Valor_Cartera: Variant;
    End;

    TReg_Valor_Pte = Record
      Codigo_Limite: Variant;
      Valor_Pte_Compra: Variant;
      Valor_Pte_Mercado: Variant;
      Valor_Pte_Mixto: Variant;
    End;

    TReg_ListaVal_Ptje = Record
      Codigo_Limite: Variant;
      Porcentaje: Variant;
      Aplica_Sobre: Variant;
      Moneda_Monto: Variant;
    End;

    TReg_Monedas = Record
      Moneda: Variant;
      Valor_Cartera: Variant;
    End;

    TReg_Otra_Valuacion = Record
      Proceso: Variant;
      Valor_Valuacion_MC: Variant;
    End;

    TReg_Grupos_Instrum = Record
      Grupo_Instrumento: Variant;
      Valor_Pte_Compra: Variant;
      Valor_Pte_Mercado: Variant;
      Valor_Pte_Mixto: Variant;
    End;

    TFrmCalculoLimites = class(TForm)
      Panel1: TPanel;
      Label1: TLabel;
      Ed_Fecha: TDateEdit;
      DataLimites: TwwDataSource;
      Panel2: TPanel;
      BTN_Insertar: TSpeedButton;
      BTN_Eliminar: TSpeedButton;
      BTN_Confirmar: TSpeedButton;
      BTN_Cancelar: TSpeedButton;
      Panel3: TPanel;
      BTN_Imprimir: TBitBtn;
      Busca_Limites: TwwSearchDialog;
      BTN_Buscar: TOvcAttachedButton;
      Chk_Carteras: TCheckBox;
      Ed_Proceso: TwwDBLookupCombo;
      Label13: TLabel;
      BTN_Calculo: TSpeedButton;
      BTN_Gestion: TSpeedButton;
      BTN_Calcelar: TBitBtn;
      Group_Moneda_Conversion: TRadioGroup;
      edMoneda: TwwDBLookupCombo;
      Busca_Limites_Inver: TwwSearchDialog;
      BTN_Buscar_Inver: TOvcAttachedButton;
      btnCC: TSpeedButton;
      T_ProcesoLimite: TFDQuery;
      T_Moneda: TFDQuery;
      T_Carteras: TFDQuery;
      T_CarterasCOD_CARTERA: TStringField;
      T_CarterasCOD_EMPRESA: TStringField;
      T_CarterasDESCRIPCION: TStringField;
      T_TmpHelpLimites: TFDMemTable;
      DataSource1: TwwDataSource;
      Qry_General: TFDQuery;
      Qry_General_Del: TFDQuery;
      Qry_Sensibilizacion: TFDQuery;
      Qry_RTPR: TFDQuery;
      Qry_Pasivos: TFDQuery;
      Qry_RTPR_Det: TFDQuery;
      Qry_Limites: TFDQuery;
      Qry_Limites_Det: TFDQuery;
      Qry_EstadoEMI: TFDQuery;
      Qry_Aux: TFDQuery;
      Qry_AccCta_Suscritas: TFDQuery;
      T_TmpLimites: TFDMemTable;
      T_TmpDatos: TFDMemTable;
      T_TmpDatosLimite: TFDMemTable;
      Qry_Prdx: TFDQuery;
      FDLocalSQL1: TFDLocalSQL;
      T_OrigenDat: TFDTable;
      Qry_Detalle: TFDQuery;
      Qry_Cartera_Lim: TFDQuery;
      Qry_Cartera_Nemo: TFDQuery;
      Label2: TLabel;
      Combo_Cartera: TEdit;
      Qry_Cartera: TFDQuery;
      Qry_Cartera_exi: TFDQuery;
      FDMemTable1: TFDMemTable;
      FDMemTable1grupo_cartera: TStringField;
      FDMemTable1proceso: TStringField;
      FDMemTable1fecha_de_cierre: TSQLTimeStampField;
      FDMemTable1fecha_cierre_anterior: TSQLTimeStampField;
      FDMemTable1fecha_inicio_anterior: TSQLTimeStampField;
      FDMemTable1tipo_conversion: TStringField;
      FDMemTable1moneda_conversion: TStringField;
      FDMemTable1moneda_conversion_informe: TStringField;
      Panel4: TPanel;
      Panel5: TPanel;
      Label8: TLabel;
      Label7: TLabel;
      Label9: TLabel;
      Label11: TLabel;
      Label14: TLabel;
      BtnBuscaFechaCierre: TOvcAttachedButton;
      edFecha_Cierre: TDateEdit;
      edFecha_Cierre_Anterior: TDateEdit;
      edFecha_Inicio_Cierre_Anterior: TDateEdit;
      edTipo_Conversion: TEdit;
      edMoneda_Conversion: TEdit;
      Lbl_Avance2: TLabel;
      ProgressBar2: TProgressBar;
      wwDBGrid1: TwwDBGrid;
      Chk_SBS11052: TCheckBox;
      Qry_Cns: TFDQuery;
      qry_paradox: TFDQuery;
      LabelPorcentaje2: TLabel;
      Lbl_Avance1: TLabel;
      LabelPorcentaje1: TLabel;
      ProgressBar1: TProgressBar;
      Qry_MontoCred: TFDQuery;
    Qry_RTPR_DetAgr: TFDQuery;
      procedure TransparentButton1Click(Sender: TObject);
      procedure FormClose(Sender    : TObject;
                          var Action: TCloseAction);
      procedure BTN_CalculoClick(Sender: TObject);
      procedure BTN_GestionClick(Sender: TObject);
      procedure BTN_ImprimirClick(Sender: TObject);
      procedure FormCloseQuery(Sender      : TObject;
                               var CanClose: Boolean);
      procedure BTN_CalcelarClick(Sender: TObject);
      procedure BTN_SalirClick(Sender: TObject);
      procedure BTN_EliminarClick(Sender: TObject);
      procedure BTN_ConfirmarClick(Sender: TObject);
      procedure BTN_InsertarClick(Sender: TObject);
      procedure BTN_BuscarClick(Sender: TObject);
      procedure BTN_CancelarClick(Sender: TObject);
      procedure Chk_CarterasClick(Sender: TObject);
      procedure Group_Moneda_ConversionClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure BTN_Buscar_InverClick(Sender: TObject);
      procedure BtnBuscaFechaCierreClick(Sender: TObject);
      procedure Ed_ProcesoNotInList(Sender     : TObject;
                                    LookupTable: TDataSet;
                                    NewValue   : string;
                                    var Accept : Boolean);
      procedure Ed_ProcesoChange(Sender: TObject);
      procedure Actualiza_Limite_Trans(Sender: TObject);
      procedure carga_array(Sender: TObject);
      procedure Ed_FechaExit(Sender: TObject);
      private
        { Private declarations }
        bImplica_Emision  : Boolean;
        bImplica_Emigrupo : Boolean;
        bImplica_EmiClasif: Boolean;

        bValida_No_Elegible : Boolean;
        sClasif_Elegible  : string;

        sTipoClasif_Emisor: String;
        bComparacion      : Boolean;
        bMuestra          : Boolean;
        bSensibilizacion  : Boolean;
        function Implica_BienesRaices(sCodigo_Limite: String): Boolean;
        Procedure Determina_Inscripcion(sEmisor,
                                        sInstrumento,
                                        sSerie,
                                        sMoneda_Instrum      : String;
                                        Var sSeries          : String;
                                        Var fMonto_Inscrito  : Double);
        Function Existen_Valores_Instrum(sTipo         : String;
                                         sCodigo_Limite: String;
                                         sEmisor       : String): Boolean;
        Procedure Carga_Serie_Vigentes;
        procedure Calculo_Emisiones;
        procedure Habilita_Campos;
        procedure Obtiene_Vcto;
        procedure Calculo_Emisiones_VC;
        Procedure Inserta_Errores(sModulo_Error, sString_Error: String);
        function valida_datos: Boolean;
        function cns_existe_limite(sString_Limite: String): Boolean;
        Function Cns_Stock: Boolean;
        procedure llenar_T_TmpDatos(var bResultado: Boolean);
        procedure Prepara_DatoCalculo(sString_LimPor: String;
                                      var Resultado : Boolean);
        function Monto_ReservaNva(dfecha_desde : TdateTime;
                                  sTipo_reserva: String): Double;
      public
        { Public declarations }
        sString_Empresas,
        sString_Carteras                   : String;
        dFecha_Cierre,
        dFecha_Ope,
        dFecha_Cierre_Anterior,
        dFecha_Inicio_Cierre_Anterior      : TdateTime;
        sModulo_Error,
        sString_Error,
        sProceso,
        sEstrategia_OMD,
        sEstrategia,
        sTipo_Conversion,
        sMoneda_Conversion                 : String;
        sMoneda_Nacional                   : String;
        bSBS                               : Boolean;
        bAbortar,
        bNoGrupo,
        Result                             : Boolean;
        sNorma                             : string;
        sMoneda_Cartera                    : String;
        sString_RTPR                       : String;
        sString_Limite                     : String;
        fReserva_Tecnica,
        fBienesRaices_NoLeasing,
        fLH_DE_CREDITO,
        fDEP_Y_CAP,
        fACC_SUSCRITAS,
        fValor_Pte_Limite_Min,
        fValor_Pte_Limite,
        fPorcentaje_Limite_Min,
        fPorcentaje_Limite,
        fPatrimonio_Neto,
        fPatrimonio_Libre,
        fValor_Pte_Compra,
        fValor_Pte_Mercado,
        fValor_Pte_Mixto,
        fPatrimonio_Riesgo,
        fNro_Riesgo,
        fFactor_Riesgo,
        fQS_Nodo,
        fMonto_Inscrito,
        fItem_Dir_Emisor                   : Double;
        sCodigo_Geo_Emisor,
        sGrupo_Emisor_Cartera,
        sGrupo_Emisor,
        sPais,
        sDescripcion_Padre,
        sClasificacion_Riesgo,
        sSeries_Inscritas,
        sNacion                            : String;
        sTipo_Limite                                                                                                                                                              : String;
        Reg_Emisores                                                                                                                                                              : TReg_Emisores;
        Reg_Grupos_EmiClasif: TReg_Grupos_EmiClasif;
        Reg_Emisores_Nem    : TReg_Emisores_Nem;
        Reg_Emisor_Nemo     : TReg_Emisores_Nem;
        Reg_Deudores_Mem    : TReg_Deudores_Mem;
        Reg_Creditos_Mem    : TReg_Creditos_Mem;
        Reg_Errores_Grupo   : TReg_Errores_Grupo;
        Reg_Series_Inscritas: TReg_Series_Inscritas;
        Reg_Valor_Pte       : TReg_Valor_Pte;
        Reg_ListaVal_Ptje   : TReg_ListaVal_Ptje;
        Reg_Monedas         : TReg_Monedas;
        Reg_Otra_Valuacion  : TReg_Otra_Valuacion;
        Reg_Grupos_Emisores : TReg_Grupos_Emisores;
        Reg_Grupos_Instrum  : TReg_Grupos_Instrum;
        Procedure Seleccion_RTPT(sString_Instrumento :string);
        Function Emisor_Matriz(sEmisor: String) : String;
        Procedure Calculo_Filiales(fTotal_Porcentaje    : Double;
                                   fTotal_Porcentaje_Min: Double);
        Function Nominales_Nemotecnico(sCodigo_Limite: String;
                                       sEmisor       : String;
                                       sInstrumento  : String;
                                       sNemotecnico  : String): Double;
    end;

  var
    FrmCalculoLimites: TFrmCalculoLimites;
      Matriz_Serie    : array[0..1500, 0..1500] of String;

implementation
uses FrmConsolidaEmp,
     DM_Variables_Menu,
     DM_Ayuda_Clasificacion,
     DM_Ayuda_Nemotecnicos,
     DM_FuncionesMemory,
     DM_ComunInversiones,
     DM_Identidad_Direccion,
     DM_Ayuda_Tipo_Empresas,
     DM_Paises,
     DM_Carteras,
     DM_Comun,
     DM_Margenes_Legales,
     DM_Codigos_Generales,
     DM_Base_Datos,
     JD_Tools,
     Frm_DatosLimites,
     Frm_ReportErrores,
     DMLeer_Valor_Cambio,
     Frm_AyudaMARS,
     RPreview,
     Rutinas_CalculoLimites,
     DM_Global_Var,
     Registro_Log,
     Nb;

{$R *.DFM}

procedure TFrmCalculoLimites.TransparentButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmCalculoLimites.FormClose(Sender    : TObject;
                                       var Action: TCloseAction);
begin
  T_Carteras.Close;
  T_Moneda.Close;
  T_ProcesoLimite.Close;
  T_TmpDatos.Close;
  T_TmpDatosLimite.Close;
  T_TmpLimites.Close;
  T_OrigenDat.Close;
  FDLocalSQL1.Active := false;

  Action := Cafree;
end;

procedure TFrmCalculoLimites.FormCreate(Sender: TObject);
var
  xejecuta, xinserta, xelimina, xmodifica: Boolean;
  sNombre_Menu                           : String;
  sModulo_Err                            : String;
  sString_Err                            : String;
  Result                                 : Boolean;
begin
  bMuestra := True;
  T_ProcesoLimite.Open;
  T_Carteras.Open;
  T_Moneda.Open;
  T_OrigenDat.Open;
  T_ProcesoLimite.Open;

  with T_TmpDatos.FieldDefs do
  begin
    Clear;
    Add(            'Empresa',           ftString,         10,     False);
    Add(            'Cartera',           ftString,         10,     False);
    Add(            'Transaccion',       ftString,         10,     False);
    Add(            'Folio_interno',     ftString,         15,     False);
    Add(            'Item_OMD',          ftFloat,          0,      False);
    Add(            'Nemotecnico',       ftString,         30,     False);
    Add(            'Emisor_Original',   ftString,         10,     False);
    Add(            'Emisor',            ftString,         10,     False);
    Add(            'Instrumento',       ftString,         10,     False);
    Add(            'Tipo_Instrum',      ftString,         10,     False);
    Add(            'Serie',             ftString,         30,     False);
    Add(            'Valor_Nominal',     ftFloat,          0,      False);
    Add(            'Saldo_Insoluto',    ftFloat,          0,      False);
    Add(            'Monto_Inscrito',    ftFloat,          0,      False);
    Add(            'Valor_Final_svs_mc',ftFloat,          0,      False);
    Add(            'Valor_Pte_mc_Cpa',  ftFloat,          0,      False);
    Add(            'Valor_Pte_mc_Mdo',  ftFloat,          0,      False);
    Add(            'Valor_Pte_mc_Mix',  ftFloat,          0,      False);
    Add(            'Clasif_Riesgo',     ftString,         10,     False);
    Add(            'Moneda_Instrum',    ftString,         15,     False);
    Add(            'Codigo_RTPR',       ftString,         10,     False);
    Add(            'Grupo_Emisor',      ftString,         10,     False);
    Add(            'Series_Inscritas',  ftString,         60,     False);
    Add(            'Presencia_Bursatil',ftFloat,          0,      False);
    Add(            'Motivo',            ftString,         10,     False);
    Add(            'Duration',          ftFloat,          0,      False);
    Add(            'Fecha_Operacion',   ftDateTime,       0,      False);
    Add(            'Fecha_Emision',     ftDateTime,       0,      False);
    Add(            'Fecha_Vcto',        ftDateTime,       0,      False);
    Add(            'Tipo_Clasif',       ftString,         10,     False);
    Add(            'Grupo_Clasif',      ftFloat,          0,      False);
    Add(            'CREDENCIAL_DEUDOR', ftString,         20,     False);
    Add(            'NOMBRE_DEUDOR',     ftString,         60,     False);
    Add(            'Tipo_Grupo',        ftString,         10,     False);
    Add(            'Id_Credito',        ftString,         30,     False);
  end;
  FDLocalSQL1.DataSets[1].Name := 'T_TmpDatos';
  T_TmpDatos.CreateDataSet;
  T_TmpDatos.Open;

  with T_TmpLimites.FieldDefs do
  begin
    Clear;
    Add(            'Cartera',           ftString,    10,     False);
    Add(            'Codigo_Limite',     ftString,    30,     False);
    Add(            'Tipo_Limite',       ftString,    10,     False);
    Add(            'Emisor',            ftString,    10,     False);
    Add(            'Instrumento',       ftString,    10,     False);
    Add(            'Nemotecnico',       ftString,    30,     False);
    Add(            'Moneda_Instrum',    ftString,    15,     False);
    Add(            'Grupo_Emisor',      ftString,    10,     False);
    Add(            'Porcentaje_Min',    ftFloat,     0,      False);
    Add(            'Porcentaje',        ftFloat,     0,      False);
    Add(            'Valor_Pte_Cartera', ftFloat,     0,      False);
    Add(            'Minimo_Permitido',  ftFloat,     0,      False);
    Add(            'Maximo_Permitido',  ftFloat,     0,      False);
    Add(            'Margen',            ftFloat,     0,      False);
    Add(            'Matriz',            ftString,    10,     False);
    Add(            'Series_Inscritas',  ftString,    60,     False);
    Add(            'Tipo_Clasif',       ftString,    10,     False);
    Add(            'Grupo_Clasif',      ftFloat,     0,      False);
    Add(            'CREDENCIAL_DEUDOR', ftString,    20,     False);
    Add(            'NOMBRE_DEUDOR',     ftString,    60,     False);
    Add(            'Id_Credito',        ftString,    30,     False);
  end;
  T_TmpLimites.CreateDataSet;
  T_TmpLimites.Open;

  with T_TmpDatosLimite.FieldDefs do
  begin
    Clear;
    Add(            'Empresa',           ftString,            10,            False);
    Add(            'Cartera',           ftString,            10,            False);
    Add(            'Transaccion',       ftString,            10,            False);
    Add(            'Folio_interno',     ftString,            15,            False);
    Add(            'Item_OMD',          ftFloat,            0,            False);
    Add(            'Nemotecnico',       ftString,            30,            False);
    Add(            'Emisor',            ftString,            10,            False);
    Add(            'Instrumento',       ftString,            10,            False);
    Add(            'Serie',             ftString,            30,            False);
    Add(            'Valor_Nominal',     ftFloat,            0,            False);
    Add(            'Saldo_Insoluto',    ftFloat,            0,            False);
    Add(            'Monto_Inscrito',    ftFloat,            0,            False);
    Add(            'Valor_Pte_mc_Cpa',  ftFloat,            0,            False);
    Add(            'Clasif_Riesgo',     ftString,            10,            False);
    Add(            'Moneda_Instrum',    ftString,            15,            False);
    Add(            'Codigo_Limite',     ftString,            30,            False);
    Add(            'Codigo_RTPR',       ftString,            10,            False);
    Add(            'Grupo_Emisor',      ftString,            10,            False);
    Add(            'Matriz',            ftString,            10,            False);
    Add(            'Series_Inscritas',  ftString,            60,            False);
    Add(            'Clasif_Limite',     ftString,            10,            False);
    Add(            'Tipo_Clasif',       ftString,            10,           False);
    Add(            'Grupo_Clasif',      ftFloat,            0,            False);
  end;
  FDLocalSQL1.DataSets[2].Name := 'T_TmpDatosLimite';
  T_TmpDatosLimite.CreateDataSet;
  T_TmpDatosLimite.Open;

  FDLocalSQL1.Active := True;

  bSBS := False;
  bSBS := Transaccion_Implica('LIMITES',
                              'SBS');
  if bSBS then
  begin
    Chk_SBS11052.visible     := True;
    BTN_Buscar.visible       := False;
    BTN_Buscar_Inver.Left    := 209;
    BTN_Buscar_Inver.visible := True;
  end
  else
  begin
    BTN_Buscar.visible       := True;
    BTN_Buscar_Inver.visible := False;
  end;

  Panel5.enabled   := False;
  Panel5.visible   := False;
  Label1.visible   := True;
  Ed_Fecha.visible := True;

  bAbortar := False;

  bComparacion := True;
  try
    With Qry_Aux do
    begin
      Sql.Clear;
      Sql.Add('SELECT Valor_Comparacion FROM QS_SUP_251_LIM ');
      Open;
    end;
  except
    bComparacion := False;
  end;

  // ggarcia 19-03-2014
  bSensibilizacion := False;
  Existe_Tabla_en_Base_de_datos(sDriver,
                                'QS_RES_SENSIBILIZACION',
                                sModulo_Err,
                                sString_Err,
                                bSensibilizacion,
                                Result);

  if not bDesarrollo then
  begin
    sNombre_Menu := 'PMS_SU_90_01';
    valida_permiso(sEmpresa_Usuario,
                   sPerfil_Usuario,
                   sNombre_Menu,
                   xejecuta,
                   xinserta,
                   xelimina,
                   xmodifica);

    BTN_Insertar.enabled := xinserta;
    BTN_Eliminar.enabled := xelimina;

    if (NOT xinserta) and (NOT xelimina) then
    begin
      BTN_Confirmar.enabled := False;
      BTN_Calculo.enabled   := False;
    end;
  end;

  FrmReportErrores.T_Paradox.EmptyDataSet;

end;

procedure TFrmCalculoLimites.Habilita_Campos;
begin
  BTN_Calcelar.enabled        := False;
  bAbortar                    := False;
  BTN_Calculo.enabled         := True;
  BTN_Gestion.enabled         := True;
  BTN_Imprimir.enabled        := True;
  BTN_Insertar.enabled        := True;
  BTN_Eliminar.enabled        := True;
  BTN_Confirmar.enabled       := True;
  BTN_Cancelar.enabled        := True;
  BtnBuscaFechaCierre.enabled := True;

  Group_Moneda_Conversion.enabled := True;
  Combo_Cartera.enabled           := False;
  Chk_Carteras.enabled            := True;
  Ed_Proceso.enabled              := True;
  Ed_Fecha.enabled                := True;
  edMoneda.enabled                := True;

  if bSBS then
    BTN_Buscar_Inver.enabled := True
  else
    BTN_Buscar.enabled := True;
end;

function TFrmCalculoLimites.valida_datos: Boolean;
begin
  Result := True;

  if Ed_Proceso.Text = '' then
  begin
    Application.MessageBox('Debe Ingresar Código de Proceso',
                           Pchar(Caption),
                           Mb_Ok + MB_IconError);
    Ed_Proceso.Setfocus;
    Result := False;
    Exit;
  end;

  if Combo_Cartera.Text = '' then
  begin
    Application.MessageBox('Debe Ingresar Cartera Válida',
                           Pchar(Caption),
                           Mb_Ok + MB_IconError);
    Ed_Proceso.Setfocus;
    Result := False;
    Exit;
  end;

  if Chk_Carteras.State = cbUnChecked then
  begin
    Application.MessageBox('Debe Seleccionar Carteras',
                           Pchar(Caption),
                           Mb_Ok + MB_IconError);
    Ed_Proceso.Setfocus;
    Exit;
  end;

  if dFecha_Cierre = 0 then
  begin
    Application.MessageBox('Debe Ingresar Fecha de Cierre Válida',
                           Pchar(Caption),
                           Mb_Ok + MB_IconError);
    Ed_Proceso.Setfocus;
    Result := False;
    Exit;
  end;

  if Trim(Ed_Proceso.Text) = 'NORMATIVO' then
  begin
    Qry_Cns.Close;
    Qry_Cns.Sql.Clear;
    Qry_Cns.Sql.Add('SELECT * FROM QS_SUP_1835_B1'
                  + ' WHERE fecha_proceso = :fecha_proceso '
                  + '   AND empresa       = :empresa ');
    Qry_Cns.Parambyname('fecha_proceso').AsDate := Ed_Fecha.Date;;
    Qry_Cns.Parambyname('empresa').asString     := sEmpresa_Usuario;

    if bDesarrollo then
      Qry_Cns.Open
    else
      try
        Qry_Cns.Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
          end;
      end;

    if Qry_Cns.RecordCount = 0 then
    begin
      Application.MessageBox('No Existe Proceso Normativo 1835',
                             'Procesos',
                             Mb_Ok);
      Ed_Fecha.Setfocus;
      Result := False;
      Qry_Cns.Close;
      Exit;
    end;
    Qry_Cns.Close;
  end;

  if (Group_Moneda_Conversion.ItemIndex = 1) and (edMoneda.Text = '') then
  begin
    Application.MessageBox('Debe Ingresar Moneda ',
                           Pchar(Caption),
                           Mb_Ok + MB_IconError);
    edMoneda.Setfocus;
    Result := False;
    Exit;
  end;

  if Group_Moneda_Conversion.ItemIndex = 0 then
    begin
      sMoneda_Nacional := moneda_nacional_pais_Usuario(sPais_Usuario);
      if sMoneda_Nacional = 'NO DISPONIBLE' then
      begin
        Application.MessageBox(Pchar(' Pais Usuario : ' + sPais_Usuario + #13 + ' Descripción Geográfica :' + sCodigo_Div_Geo_Usuario),
                               'Moneda Nacional',
                               Mb_Ok + MB_IconError);
        Exit;
      end;
    end
  else
    sMoneda_Nacional := edMoneda.Text;

  sString_Carteras := '';
  sString_Empresas := '';

end;

function TFrmCalculoLimites.cns_existe_limite(sString_Limite: String): Boolean;
var aux_fecha_cierre    :TDateTime;
    aux_moneda_Nacional :String;
begin
  Result := True;
  aux_fecha_cierre := dfecha_cierre;
  with Qry_General do
  begin
    Close;
    Sql.Clear;
    Sql.Add('SELECT max(Fecha_proceso) as fecha_proceso FROM QS_TRA_251'
          + ' WHERE Proceso        = :Proceso'
          + '   AND Fecha_proceso <= :Fecha'
          + '   AND cartera        = :cartera ');

    Parambyname('Proceso').asString := Ed_Proceso.Text;
    Parambyname('cartera').asString := Combo_Cartera.Text;
    Parambyname('Fecha').AsDate     := dFecha_Cierre;

    try
      Open;
      if not eof then
         aux_fecha_cierre := solo_fecha(FieldByName('fecha_proceso').AsDateTime);
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
        end;
    end;

    Close;
    Sql.Clear;
    Sql.Add('SELECT distinct codigo_limite FROM QS_SUP_251_LIM'
          + ' WHERE Proceso           = :Proceso'
          + '   AND codigo_limite in ' + sString_Limite);

    Parambyname('Proceso').asString := Ed_Proceso.Text;
    Open;

    while not eof do
    begin
      with Qry_Detalle do
      begin
        Close;
        Sql.Clear;
        Sql.Add('SELECT * FROM QS_TRA_251'
               +' WHERE Proceso           = :Proceso'
               +'   AND Fecha_proceso     = :Fecha'
               +'   AND cartera           = :cartera '
               +'   AND codigo_limite     = :codigo_limite ');

        Parambyname('Proceso').asString       := Ed_Proceso.Text;
        Parambyname('cartera').asString       := Combo_Cartera.Text;
        Parambyname('Fecha').AsDate           := aux_fecha_cierre;
        Parambyname('codigo_limite').asString := Qry_General.FieldByName('codigo_limite').asString;

        try
          Open;
          if not eof then
             aux_moneda_Nacional := Qry_Detalle.FieldByName('moneda_conversion_informe').asString;
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E);
            end;
        end;

        if eof then
        begin
          Result := False;
          break;
        end;
      end;
      Next;
    end;
  end;
  if Result then
  begin
     dfecha_cierre    := aux_fecha_cierre;
     smoneda_Nacional := aux_moneda_Nacional;
  end;
end;

Function TFrmCalculoLimites.Cns_Stock: Boolean;
begin

  // Result := False;
  with Qry_General do
  begin
    Close;
    Sql.Clear;
    Sql.Add(' SELECT a.* '
          + '   FROM QS_RES_MERCADO  a'
          + '  WHERE a.Fecha_Cierre = :Fecha_Cierre');
    Sql.Add('    AND a.EMPRESA in ' + sString_Empresas);
    Sql.Add('    AND a.CARTERA in ' + sString_Carteras);

    Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;

    try
      Open;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
        end;
    end;

    if not eof then
    begin
      Close;
      Sql.Clear;
      Sql.Add(' SELECT a.* '
            + '   FROM QS_RES_VALORIZA_RV  a'
            + ' WHERE a.Fecha_Cierre  = :Fecha_Cierre');
      Sql.Add('   AND a.EMPRESA in ' + sString_Empresas);
      Sql.Add('   AND a.CARTERA in ' + sString_Carteras);

      Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;

      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
          end;
      end;
      if eof then
        Result := False
      else
        Result := True;
    end
    else
      Result := False;
  end;

end;

procedure TFrmCalculoLimites.carga_array(Sender: TObject);
var
   i: Integer;
begin
  fPid        := Application.Handle;
  sPrograma   := 'MD - Proceso Limites';
  dfecha_hora := Fecha_Hora_Servidor;

  i := 1;
  // proceso
  Array_Reg_Log[i].Pid        := fPid;
  Array_Reg_Log[i].Fecha_hora := dfecha_hora;
  Array_Reg_Log[i].Campo      := 'Proceso Limite';
  Array_Reg_Log[i].Valor      := Ed_Proceso.Text;

  // Carteras
  i                           := i + 1;
  Array_Reg_Log[i].Pid        := fPid;
  Array_Reg_Log[i].Fecha_hora := dfecha_hora;
  Array_Reg_Log[i].Campo      := 'Carteras';

  if (Chk_Carteras.ChecKed) then
  begin
    Array_Reg_Log[i].Valor := 'S';
    agrega_datosarray_cartera(i);
  end
  else
    Array_Reg_Log[i].Valor := 'N';

  i := i + 1;
  if (sNorma = '11052') or (sNorma = '1041') then
  begin
    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Fecha Cierre';
    Array_Reg_Log[i].Valor      := edFecha_Cierre.Text;

    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Fecha Cie Ant';
    Array_Reg_Log[i].Valor      := edFecha_Cierre_Anterior.Text;

    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Fecha Cie Ini';
    Array_Reg_Log[i].Valor      := edFecha_Inicio_Cierre_Anterior.Text;

    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Tipo Conversion';
    Array_Reg_Log[i].Valor      := edTipo_Conversion.Text;

    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Moneda Conversion';
    Array_Reg_Log[i].Valor      := edMoneda_Conversion.Text;
  end
  else
  begin
    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Fecha Proceso';
    Array_Reg_Log[i].Valor      := Ed_Fecha.Text;
  end;

  if Group_Moneda_Conversion.ItemIndex = 0 then
  begin
    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Moneda';
    Array_Reg_Log[i].Valor      := 'Moneda Nacional';
  end
  else
  begin
    i                           := i + 1;
    Array_Reg_Log[i].Pid        := fPid;
    Array_Reg_Log[i].Fecha_hora := dfecha_hora;
    Array_Reg_Log[i].Campo      := 'Moneda';
    Array_Reg_Log[i].Valor      := edMoneda.Text;
  end;

  if Trim(sTipo_Limite) <> 'T' then
    inserta_Log(True) // bTransaccion
  else
    inserta_Log(False); // bTransaccion
end;

procedure TFrmCalculoLimites.BTN_CalculoClick(Sender: TObject);
var
  bResult,
  bExisten_Valores_Limites,
  bDuration,
  bPlazo_Vcto,
  bEmisor_Relacionado,
  bExisten_Valores_Instrum,
  bMotivo,
  bRespueta,
  Existe_LimiteCalculado   : Boolean;
  dFecha_Emision,
  dFecha_Plazo             : TdateTime;
  iRecordCount,
  i                        : Integer;
  fRecordCount,
  fValor_Pte_mc_Cpa_Detalle,
  fValor,
  fValor_Max,
  fValor_Min,
  fPatrimonio,
  fTotal_LH_emitidas,
  fMonto_Inscrito,
  fTotal_Acc_suscritas,
  fTotal_Porcentaje,
  fTotal_Porcentaje_Min,
  fTotal_Porcentaje_New,
  fTotal_Porcentaje_Min_New,
  fCUOTAS_SUSCRITAS,
  fValor_Cuota,
  fValor_Nominal,
  fPorcentaje_Ant,
  fNodo_Clasif,
  fValor_Pte_MC_Cpa: Double;
  sEmisor,
  sSerie,
  sClasificadora_Riesgo,
  sTipo_Clasif,
  sEmisor_Pagador,
  sModulo_Err,
  sString_Err,
  sDescripcion,
  sInstrumento,
  sIdentidadCli,
  sMoneda_Cartera,
  sProrrateo_Valores,
  sInstrumento_Equiv,
  sSugrupo_economico,
  sGrupo_economico,
  sProceso_lim,
  sString_LimPor,
  sInstrumentos   : String;
  Registro_Fechas : TRegistro_Fechas;
begin
  dFecha_Cierre := Ed_Fecha.Date;
  dFecha_Ope    := dFecha_Cierre;

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption      := '';
    Lbl_Avance2.Caption      := '';
    LabelPorcentaje1.Caption := '';
    LabelPorcentaje2.Caption := '';
    Application.ProcessMessages;
  end;

  bValida_No_Elegible := False;
  sClasif_Elegible := '';

  if Trim(sTipo_Limite) <> 'T' then
  begin
    if Not valida_datos then
       Exit;

    // Solo excluye los no elegibles si esta en la base
    // este paranetro de proceso
    Busca_param_proceso(  sEmpresa_Usuario,
                          'NO_ELEGIBL',
                          sClasif_Elegible,
                          bValida_No_Elegible);
  end
  else
  begin
    if Generando_stock('VALORIZANDO') then
    begin
      Application.MessageBox(Pchar('¡Se está Generando Stock'#10 + 'No se puede Generar Limites'#10 + 'Espere que Termine el Proceso de Valorización'),
                             'Sistema',
                              Mb_Ok + MB_ICONINFORMATION);
      Exit;
    end;
  end;

  carga_array(Sender);

  With Qry_General do
  begin
    Close;
    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TEMP_LIMITE '
          + '  WHERE PID = :PID');
    Parambyname('PID').asFloat := Application.Handle;

    try
      ExecSql;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;

    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TEMP_LIMITE '
          + '  WHERE FECHA_CREACION < :FECHA_CREACION');

    Parambyname('FECHA_CREACION').AsDateTime := Fecha_Hora_Servidor - 1;

    try
      ExecSql;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;
    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TEMP_LIM_DERIV '
          + '  WHERE PID = :PID');
    Parambyname('PID').asFloat := Application.Handle;

    try
      ExecSql;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;

    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TEMP_LIM_DERIV '
          + '  WHERE FECHA_CREACION < :FECHA_CREACION');

    Parambyname('FECHA_CREACION').AsDateTime := Fecha_Hora_Servidor - 1;

    try
      ExecSql;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;

    // verifico si hay Limites Definidos
    if sTipo_Limite = '' then
    begin
      Lbl_Avance1.Caption := 'Validando si existe definición de limites a la fecha ...';
      Application.ProcessMessages;
    end;

    Close;
    Sql.Clear;
    Sql.Add('SELECT a.CODIGO_LIMITE '
          + '  FROM QS_SUP_251_LIM     a '
          + '      ,QS_SUP_251_LIM_DET b '
          + ' WHERE a.Proceso          = :Proceso '
          + '   AND a.Fecha_Desde     <= :Fecha '
          + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
          + '   AND a.Proceso          = b.Proceso '
          + '   AND a.Codigo_Limite    = b.Codigo_Limite '
          + '   AND a.Fecha_Desde      = b.Fecha_Desde ');

    Parambyname('Proceso').asString := Ed_Proceso.Text;
    Parambyname('Fecha').AsDate     := dFecha_Cierre;

    try
      Open;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
        end;
    end;

    if FieldByName('CODIGO_LIMITE').IsNull then
    begin
      if sTipo_Limite = '' then
      begin
        Application.MessageBox(' No existe Definición de Límites para Datos Ingresados',
                               Pchar(Caption),
                               Mb_Ok + MB_IconError);
        Lbl_Avance1.Caption := '';
        Application.ProcessMessages;
      end;
      Habilita_Campos;
      Ed_Proceso.Setfocus;
      Exit;
    end;
    Close;
  end;

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := 'Cargando Valores de Cambio ...';
    Application.ProcessMessages;
  end;
  Carga_Valores_de_Cambio_Mem(dFecha_Cierre,
                              dFecha_Cierre,
                              '');

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := 'Cargando Emisor / Pagador ...';
    Application.ProcessMessages;
  end;
  Carga_Emisor_Pagador_Mem(dFecha_Cierre);

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := 'Cargando Nro Clasificación Riesgo ...';
    Application.ProcessMessages;
  end;
  Carga_Nro_Clasif_Riesgo;

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := 'Cargando Valores Clasificación Riesgo ...';
    Application.ProcessMessages;
  end;

  Carga_Valores_Clasif_Riesgo_Mem(dFecha_Cierre);

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := 'Cargando Redondeo Moneda ...';
    Application.ProcessMessages;
  end;
  Carga_Valores_Redondeo_Monedas_Mem(dFecha_Cierre);

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := 'Cargando Valores UF ...';
    Application.ProcessMessages;
  end;
  Carga_UF_Mem(dFecha_Cierre);

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := 'Cargando Series Vigentes ...';
    Application.ProcessMessages;
  end;
  Carga_Serie_Vigentes;


  // if bDesarrollo then
  // begin
  // sTipo_Limite   := 'Filtrado';
  // sString_Limite := '(''LIMINST_H'')';   //LIMINST_Q
  // sString_RTPR   := '(''''';
  // with Qry_Aux do
  // begin
  // Qry_Aux.SQL.Clear;
  // Qry_Aux.SQL.Add(' SELECT codigo_rtpr ');
  // Qry_Aux.SQL.Add('   FROM qs_sup_251_lim_det ');
  // Qry_Aux.SQL.Add('  where codigo_limite IN '+sString_Limite);
  // Open;
  // while not eof do
  // begin
  // sString_RTPR   := sString_RTPR+','''+FieldByName('CODIGO_RTPR').AsString+'''';
  // next;
  // end;
  // sString_RTPR   := sString_RTPR+')';
  // end;
  // end;

  // Rescato las Definiciones de reserva técnica y Patrimonio de Riesgo
  // y acoto todos los instrumentos que me sirver para aplicar los límites
  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := '';
    Application.ProcessMessages;
  end;

  T_TmpDatos.EmptyDataSet;
  T_TmpDatosLimite.EmptyDataSet;
  T_TmpLimites.EmptyDataSet;
  FrmReportErrores.T_Paradox.EmptyDataSet;

  bAbortar                        := False;
  BTN_Calcelar.enabled            := True;
  BTN_Calculo.enabled             := False;
  BTN_Buscar.enabled              := False;
  BTN_Buscar_Inver.enabled        := False;
  BTN_Insertar.enabled            := False;
  BTN_Eliminar.enabled            := False;
  BTN_Confirmar.enabled           := False;
  BTN_Cancelar.enabled            := False;
  BTN_Gestion.enabled             := False;
  BTN_Imprimir.enabled            := False;
  BtnBuscaFechaCierre.enabled     := False;
  Group_Moneda_Conversion.enabled := False;
  Ed_Proceso.enabled              := False;
  Combo_Cartera.enabled           := False;
  Chk_Carteras.enabled            := False;
  Ed_Fecha.enabled                := False;
  edMoneda.enabled                := False;

  Existe_LimiteCalculado := True;

  if sTipo_Limite = 'T' then
  begin
    if Trim(sString_Carteras) = '' then
    begin
      sString_Carteras := String_Carteras(Application.Handle);
      sString_Empresas := '(''' + sEmpresa_Usuario + ''')';
    end;
    if (Trim(sString_RTPR) <> '') then
    begin
      if not cns_existe_limite(sString_Limite) then
      begin
        Existe_LimiteCalculado := False;
        /// de no existir limite procesado debe existir el stock al dia de la operacion
        if Not Cns_Stock then
          Exit;
      end;
    end
    else
      Exit;
  end
  else
    Existe_LimiteCalculado := False;

  sProceso_lim := Ed_Proceso.Text;
  if Not Existe_LimiteCalculado then
  begin
    if sTipo_Limite = '' then
    begin
      Lbl_Avance1.Caption := 'Prepara datos cálculo ...';
      Application.ProcessMessages;
    end;

    Prepara_DatoCalculo('X',bRespueta);
    if Not bRespueta then
    begin
      Habilita_Campos;
      Exit;
    end;
  end
  else
  begin
    sString_LimPor := llena_Arreglo_Limite(sProceso_lim,
                                           dFecha_Cierre,
                                           sString_Limite);
    if sString_LimPor = '(''X'')' then
    begin
      llenar_T_TmpDatos(bRespueta);
      if Not bRespueta then
      begin
        Habilita_Campos;
        Exit;
      end;
    end
    else
    begin
      if sTipo_Limite = '' then
      begin
        Lbl_Avance1.Caption := 'Prepara datos cálculo ...';
        Application.ProcessMessages;
      end;

      Prepara_DatoCalculo(sString_LimPor,bRespueta);
      if Not bRespueta then
      begin
        Habilita_Campos;
        Exit;
      end;
    end;
  end;

  // GGARCIA 24-09-2013 para limites por otras valuaciones (sensibilizacion)
  if bSensibilizacion then // ggarcia 19-03-2014
  begin
    With Qry_General do
    begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT SUM(a.Valor_Valuacion_MC) as Valor_Valuacion_MC '
                + '      ,a.PROCESO                 as PROCESO '
                + '      ,c.Moneda_Cartera          as Moneda_Informe '
                + '  FROM QS_RES_SENSIBILIZACION a '
                + '      ,QS_FIN_CARTERAS        c '
                + ' WHERE a.Fecha_Cierre = :Fecha '
                + '   AND a.PROCESO      in (select distinct b.CODIGO_PORCENTAJE from qs_sup_251_lim b) '
                + '   AND a.Cartera      = c.Cod_Cartera '
                + '   AND a.Transaccion NOT IN (SELECT Codigo_Transaccion '
                + '                                FROM QS_SYS_TRAN_IMPLIC '
                + '                               WHERE Implicancia = ''PACTO'')'
                + ' Group By a.PROCESO, c.Moneda_Cartera ');
      Parambyname('Fecha').AsDate := dFecha_Cierre;
      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
          end;
      end;
      Last;

      iRecordCount := RecordCount;
      if iRecordCount > 0 then
        iRecordCount := iRecordCount - 1;

      Reg_Otra_Valuacion.Proceso            := VarArrayCreate([0, iRecordCount],varOleStr);
      Reg_Otra_Valuacion.Valor_Valuacion_MC := VarArrayCreate([0, iRecordCount],varDouble);
      i := 0;
      First;
      While not eof do
      begin
        fValor_Cambio := 1;
        if sMoneda_Nacional <> FieldByName('Moneda_Informe').asString then
        begin
          Leer_Valor_Cambio2_Mem(Qry_General.FieldByName('Moneda_Informe').asString,
                                 sMoneda_Nacional,
                                 'BC',
                                 dFecha_Cierre,
                                 fValor_Cambio,
                                 Result);
          if not Result then
          begin
            Inserta_Errores('Proceso Limite',
                            'No se encontro Tipo Cambio, Fecha - Moneda ' + DateToStr(dFecha_Cierre) + ' - ' + Qry_General.FieldByName('Moneda_Informe').asString);
            Qry_General.Next;
            Continue;
          end;
        end;
        Reg_Otra_Valuacion.Proceso[i]            := FieldByName('PROCESO').asString;
        Reg_Otra_Valuacion.Valor_Valuacion_MC[i] := FieldByName('Valor_Valuacion_MC').asFloat * fValor_Cambio;
        Inc(i);
        Next;
      end;
      Close;
    end;
  end;
  // Fin GGARCIA 24-09-2013

  sEstrategia := '';
  Busca_param_proceso(sEmpresa_Usuario,
                      'DUOMDRF01',
                      sEstrategia,
                      bResult);

  Qry_Limites.Close;
  Qry_Limites.Sql.Clear;
  Qry_Limites.Sql.Add('SELECT * FROM QS_SUP_251_LIM a '
                    + ' WHERE a.Proceso = :Proceso'
                    + '   AND Fecha_Desde = (SELECT MAX(b.FECHA_DESDE) '
   				          + '                        FROM QS_SUP_251_LIM b '
				            + '                       WHERE b.PROCESO = a.PROCESO '
				            + '                         AND b.CODIGO_LIMITE = a.CODIGO_LIMITE '
				            + '                         AND b.Fecha_Desde <= :Fecha '
				            + '                         AND (b.Fecha_Hasta IS NULL OR b.Fecha_Hasta >= :Fecha)) ');


  if ((sTipo_Limite = 'T') or (sTipo_Limite = 'Filtrado')) and (Trim(sString_Limite) <> '') then
    Qry_Limites.Sql.Add(' AND CODIGO_Limite in ' + sString_Limite);

  Qry_Limites.Sql.Add(' ORDER BY Codigo_Limite ');

  if dFecha_Ope < dFecha_Cierre then
    Qry_Limites.Parambyname('fecha').AsDate := dFecha_Cierre
  else
    Qry_Limites.Parambyname('fecha').AsDate := dFecha_Ope;

  Qry_Limites.Parambyname('Proceso').asString := Ed_Proceso.Text;

  if bDesarrollo then
     Qry_Limites.Open
  else
    try
      Qry_Limites.Open;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
        end;
    end;

  bExisten_Valores_Limites := False;
  ProgressBar1.Max         := Qry_Limites.RecordCount;
  ProgressBar1.Position    := 0;

  While (Not Qry_Limites.eof) and (Not bAbortar) do
  begin
    Lbl_Avance1.Caption      := 'Aplicando: '+ Qry_Limites.FieldByName('Codigo_Limite').asString;
    ProgressBar1.Position    := ProgressBar1.Position + 1;
    LabelPorcentaje1.Caption := FloatToStr(ProgressBar1.Position) + ' de ' + FloatToStr(ProgressBar1.Max) + ' (' + FormatFloat('##0', ProgressBar1.Position / ProgressBar1.Max * 100) + '%)';

    Application.ProcessMessages;


//    if bDesarrollo then
//    begin
//    if trim(Qry_Limites.Fieldbyname('Codigo_Limite').asString)  <> 'LEMI_B_1C_EMISION_SERIE' then
////         Lbl_Avance1.Caption      := 'Aplicando: ' + Qry_Limites.FieldByName('Codigo_Limite').asString;
//    begin
//    Qry_Limites.Next;
//    Continue;
//    end;
//    end;

    Qry_Limites_Det.Close;
    Qry_Limites_Det.Parambyname('Proceso').asString       := Ed_Proceso.Text;
    Qry_Limites_Det.Parambyname('Codigo_Limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
    Qry_Limites_Det.Parambyname('fecha').AsDate           := solo_fecha(Qry_Limites.FieldByName('fecha_desde').AsDateTime);

    if bDesarrollo then
       Qry_Limites_Det.Open
    else
      try
        Qry_Limites_Det.Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
          end;
      end;

    if Qry_Limites_Det.FieldByName('Codigo_Limite').IsNull then
    begin
      Qry_Limites.Next;
      Qry_Limites_Det.Close;
      Continue;
    end;

    // Limpio Variables
    /// DC 02/08/2016
    if Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMICLASIF' then
      for i := 0 to VarArrayHighBound(Reg_Grupos_EmiClasif.Tipo_Clasif, 1) do
        Reg_Grupos_EmiClasif.Valor_Cartera[i] := 0;
    /// DC 02/08/2016

    if Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIGRUPO' then
      for i := 0 to VarArrayHighBound(Reg_Grupos_Emisores.Grupo_Emisor, 1) do
        Reg_Grupos_Emisores.Valor_Cartera[i] := 0;

    if (Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIINSTRUM') or
       (Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIFILIAL') then
      for i := 0 to VarArrayHighBound(Reg_Emisores.Emisor, 1) do
        Reg_Emisores.Valor_Cartera[i] := 0;

    if (Qry_Limites.FieldByName('Codigo_Porcentaje').asString = 'ACCIONES') or
       (Qry_Limites.FieldByName('Codigo_Porcentaje').asString = 'CUOTAS') then
      for i := 0 to VarArrayHighBound(Reg_Emisores_Nem.Emisor, 1) do
        Reg_Emisores_Nem.Valor_Cartera[i] := 0;

    if Qry_Limites.FieldByName('Suma_Inversion').asString = 'SUMNEMOTEC' then
      for i := 0 to VarArrayHighBound(Reg_Emisor_Nemo.Emisor, 1) do
        Reg_Emisor_Nemo.Valor_Cartera[i] := 0;

    if Qry_Limites.FieldByName('Suma_Inversion').asString = 'IDEMDEUDOR' then
      for i  := 0 to VarArrayHighBound(Reg_Deudores_Mem.Deudor, 1) do
        Reg_Deudores_Mem.Valor_Cartera[i] := 0;

//      if (Qry_Limites.FieldByName('Codigo_Porcentaje_Min').asString = 'MONTOCRED') or
//         (Qry_Limites.FieldByName('Codigo_Porcentaje'    ).asString = 'MONTOCRED') or
    if (Qry_Limites.FieldByName('Suma_Inversion').asString = 'CREDITO') then
       for i  := 0 to VarArrayHighBound(Reg_Creditos_Mem.Id_Credito, 1) do
          Reg_Creditos_Mem.Valor_Cartera[i] := 0;

    // GGARCIA 03-2010  para limites transacciones
    if (Qry_Limites.FieldByName('Codigo_Porcentaje').asString = 'PASIVOS') then
      for i := 0 to VarArrayHighBound(Reg_Monedas.Moneda, 1) do
        Reg_Monedas.Valor_Cartera[i] := 0;
    // FIN GGARCIA 03-2010

    // Recorro todo el detalle del LIMITE
    fValor_Pte_MC_Cpa        := 0;
    sInstrumentos            := '';
    bExisten_Valores_Limites := False;
    fRecordCount             := 0;

    While (Not Qry_Limites_Det.eof) and (Not bAbortar) do
    begin
      fRecordCount        := fRecordCount + 1;
      Lbl_Avance2.Caption := 'Grupo: '
                            + Qry_Limites_Det.FieldByName('Codigo_RTPR').asString
                            + ' ('
                            + FloatToStr(fRecordCount)
                            + ' de '
                            + FloatToStr(Qry_Limites_Det.RecordCount)
                            + ')';
      Application.ProcessMessages;
      With T_TmpDatos do
      begin
        Last;
        Filtered := False;
        Filter   := ' Codigo_RTPR = ''' + Qry_Limites_Det.FieldByName('Codigo_RTPR').asString + '''';
        Filtered := True;
        First;
        ProgressBar2.Max      := T_TmpDatos.RecordCount;
        ProgressBar2.Position := 0;

        While (Not T_TmpDatos.eof) and
              (Not bAbortar) do
        begin

          ProgressBar2.Position    := ProgressBar2.Position + 1;
          LabelPorcentaje2.Caption := FloatToStr(ProgressBar2.Position)
                                    + ' de '
                                    + FloatToStr(ProgressBar2.Max)
                                    + ' ('
                                    +FormatFloat('##0', ProgressBar2.Position /
                                                        ProgressBar2.Max * 100)
                                    + '%)';
          Application.ProcessMessages;

          sClasificacion_Riesgo := '';

          fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Final_svs_mc').asFloat;
          if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'VP' then
            fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Pte_mc_Cpa').asFloat;

          if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'VM' then
            fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Pte_mc_Mdo').asFloat;

          if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'VX' then
            fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Pte_mc_Mix').asFloat;

          // GGARCIA 03/04/2009 Mientras se implementa valor comparacion
          if bComparacion then
          begin
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VP' then
              fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Pte_mc_Cpa').asFloat;
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VM' then
              fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Pte_mc_Mdo').asFloat;
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VX' then
              fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Pte_mc_Mix').asFloat;
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VN' then
              fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Nominal').asFloat;
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'SI' then
              fValor_Pte_mc_Cpa_Detalle := FieldByName('SALDO_INSOLUTO_MC').asFloat;
          end;

          // ggarcia 24-09-2013 si codigo_porcentaje corresponde a un proceso de sensibilizacion toma el valor correspondiente
          if bSensibilizacion then // ggarcia 19-03-2014
          begin
            fValor := 0;
            for i  := 0 to VarArrayHighBound(Reg_Otra_Valuacion.Proceso, 1) do
            begin
              if (Reg_Otra_Valuacion.Proceso[i] = Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString) or
                 ((Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = '') and
                 (Reg_Otra_Valuacion.Proceso[i] = Qry_Limites.FieldByName('VALOR_COMPARACION').asString)) then
              begin
                // Rescato valuacion segun proceso de sensibilizacion
                if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString <> '' then
                  Qry_Sensibilizacion.Parambyname('Proceso').asString := Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString
                else
                  Qry_Sensibilizacion.Parambyname('Proceso').asString := Qry_Limites.FieldByName('VALOR_COMPARACION').asString;

                Qry_Sensibilizacion.Parambyname('Fecha').AsDate           := dFecha_Cierre;
                Qry_Sensibilizacion.Parambyname('Folio_Interno').asString := FieldByName('Folio_Interno').asString;
                Qry_Sensibilizacion.Parambyname('Item_OMD').asFloat       := FieldByName('Item_OMD').asFloat;
                Qry_Sensibilizacion.Parambyname('Transaccion').asString   := FieldByName('Transaccion').asString;
                Qry_Sensibilizacion.Parambyname('Empresa').asString       := FieldByName('Empresa').asString;

                if bDesarrollo then
                   Qry_Sensibilizacion.Open
                else
                  try
                    Qry_Sensibilizacion.Open;
                  except
                    on E: EFDDBEngineException do
                      begin
                        ShowError(E);
                      end;
                  end;

                if not Qry_Sensibilizacion.eof then
                begin
                  fValor_Cambio := 1;
                  if sMoneda_Nacional <> Qry_Sensibilizacion.FieldByName('Moneda_Informe').asString then
                  begin
                    Leer_Valor_Cambio2_Mem(Qry_Sensibilizacion.FieldByName('Moneda_Informe').asString,
                                           sMoneda_Nacional,
                                           'BC',
                                           dFecha_Cierre,
                                           fValor_Cambio,
                                           Result);
                    if not Result then
                    begin
                      Inserta_Errores('Proceso Limite',
                                      'No se encontro Tipo Cambio, Fecha - Moneda ' + DateToStr(dFecha_Cierre) + ' - ' + Qry_Sensibilizacion.FieldByName('Moneda_Informe').asString);
                      Next;
                      Continue;
                    end;
                  end;
                  fValor := fValor + Qry_Sensibilizacion.FieldByName('Valor_Valuacion_MC').asFloat * fValor_Cambio;
                end;
                Qry_Sensibilizacion.Close;
                // break;
              end;
            end;
            if fValor > 0 then
              fValor_Pte_mc_Cpa_Detalle := fValor;
          end;
          // fin ggarcia 24-09-2013

          // Verifico Clasificacón de Cartera
          if (Qry_Limites.FieldByName('CLASIF_CARTERA').asString <> '') and
             (Qry_Limites.FieldByName('Nodo').asFloat <> 0) then
          begin
            // Busco Nodo de Clasificación de Cartera
            Determina_Nodo_Clasificacion(
              'CARTERA',
              FieldByName('CARTERA').asString,
              Qry_Limites.FieldByName('CLASIF_CARTERA').asString,
              fNodo_Clasif);
            if (fNodo_Clasif = 0) or (fNodo_Clasif <> Qry_Limites.FieldByName('Nodo').asFloat)
            then
              begin
                T_TmpDatos.Next;
                Continue;
              end;
          end
          else
          begin
            /// / DC 31/05/2017
            Qry_Cartera_exi.Close;
            Qry_Cartera_exi.Sql.Clear;
            Qry_Cartera_exi.Sql.Add(' SELECT * FROM QS_SUP_251_lim_cartera'
                                  + '  WHERE proceso       = :proceso'
                                  + '    AND codigo_limite = :codigo_limite '
                                  + '    AND fecha_desde   = :fecha_desde ');

            Qry_Cartera_exi.Parambyname('proceso').asString       := Qry_Limites.FieldByName('proceso').asString;
            Qry_Cartera_exi.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('codigo_limite').asString;
            Qry_Cartera_exi.Parambyname('Fecha_desde').AsDate     := solo_fecha(Qry_Limites.FieldByName('Fecha_desde').AsDateTime);

            if bDesarrollo then
               Qry_Cartera_exi.Open
            else
              try
                Qry_Cartera_exi.Open;
              except
                on E: EFDDBEngineException do
                  begin
                    ShowError(E);
                  end;
              end;

            if Qry_Cartera_exi.RecordCount > 0 then
            begin
              Qry_Cartera_Lim.Close;
              Qry_Cartera_Lim.Parambyname('proceso').asString       := Qry_Limites.FieldByName('proceso').asString;
              Qry_Cartera_Lim.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('codigo_limite').asString;
              Qry_Cartera_Lim.Parambyname('Fecha_desde').AsDate     := solo_fecha(Qry_Limites.FieldByName('Fecha_desde').AsDateTime);
              Qry_Cartera_Lim.Parambyname('cartera').asString       := T_TmpDatos.FieldByName('CARTERA').asString;

              if bDesarrollo then
                 Qry_Cartera_Lim.Open
              else
                try
                  Qry_Cartera_Lim.Open;
                except
                  on E: EFDDBEngineException do
                    begin
                      ShowError(E);
                    end;
                end;

              if Qry_Cartera_Lim.RecordCount = 0 then
              begin
                if (sTipo_Limite = 'T')
                then
                  Inserta_Errores(
                    'Proceso Limite',
                    'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
                T_TmpDatos.Next;
                Continue;
              end;
            end;
          end;

          Qry_Cartera_exi.Close;
          Qry_Cartera_exi.Sql.Clear;
          Qry_Cartera_exi.Sql.Add(' SELECT * FROM QS_SUP_251_lim_nemo'
                                + '  WHERE proceso       = :proceso'
                                + '    AND codigo_limite = :codigo_limite '
                                + '    AND fecha_desde   = :fecha_desde '
                                + '    AND codigo_rtpr   = :codigo_rtpr ');

          Qry_Cartera_exi.Parambyname('proceso').asString       := Qry_Limites.FieldByName('proceso').asString;
          Qry_Cartera_exi.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('codigo_limite').asString;
          Qry_Cartera_exi.Parambyname('Fecha_desde').AsDate     := solo_fecha(Qry_Limites.FieldByName('Fecha_desde').AsDateTime);
          Qry_Cartera_exi.Parambyname('codigo_rtpr').asString   := Qry_Limites_Det.FieldByName('codigo_rtpr').asString;

          if bDesarrollo then
             Qry_Cartera_exi.Open
          else
            try
              Qry_Cartera_exi.Open;
            except
              on E: EFDDBEngineException do
                begin
                  ShowError(E);
                end;
            end;

          if Qry_Cartera_exi.RecordCount > 0 then
          begin
            Qry_Cartera_Nemo.Close;
            Qry_Cartera_Nemo.Parambyname('proceso').asString       := Qry_Limites.FieldByName('proceso').asString;
            Qry_Cartera_Nemo.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('codigo_limite').asString;
            Qry_Cartera_Nemo.Parambyname('Fecha_desde').AsDate     := solo_fecha(Qry_Limites.FieldByName('Fecha_desde').AsDateTime);
            Qry_Cartera_Nemo.Parambyname('codigo_rtpr').asString   := Qry_Limites_Det.FieldByName('codigo_rtpr').asString;
            Qry_Cartera_Nemo.Parambyname('Nemotecnico').asString   := T_TmpDatos.FieldByName('Nemotecnico').asString;

            if bDesarrollo then
               Qry_Cartera_Nemo.Open
            else
              try
                Qry_Cartera_Nemo.Open;
              except
                on E: EFDDBEngineException do
                  begin
                    ShowError(E);
                  end;
              end;

            if Qry_Cartera_Nemo.RecordCount = 0 then
            begin
              if (sTipo_Limite = 'T') then
                Inserta_Errores('Proceso Limite',
                                'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
              T_TmpDatos.Next;
              Continue;
            end;
          end;

          IF (Not Qry_Limites_Det.FieldByName('estrategia').IsNull) and
              (Trim(Qry_Limites_Det.FieldByName('estrategia').asString) <> '') then
            begin
              sEstrategia_OMD := '';
              if (sTipo_Limite = 'T') then
                sEstrategia_OMD := Busca_Estrategia_Trans(T_TmpDatos.FieldByName('Transaccion').asString,
                                                          T_TmpDatos.FieldByName('Folio_interno').asString,
                                                          T_TmpDatos.FieldByName('Nemotecnico').asString)
              else
                if T_TmpDatos.FieldByName('Tipo_Instrum').asString = 'R' then
                  sEstrategia_OMD := Busca_Estrategia_RV(T_TmpDatos.FieldByName('Empresa').asString,
                                                          'CRV',
                                                          T_TmpDatos.FieldByName('CARTERA').asString,
                                                          T_TmpDatos.FieldByName('Nemotecnico').asString,
                                                          sEstrategia,
                                                          dFecha_Cierre)
                else
                  sEstrategia_OMD := Busca_Estrategia(T_TmpDatos.FieldByName('Empresa').asString,
                                                      T_TmpDatos.FieldByName('Transaccion').asString,
                                                      T_TmpDatos.FieldByName('Folio_interno').asString,
                                                      sEstrategia,
                                                      dFecha_Cierre);

              if sEstrategia_OMD <> Qry_Limites_Det.FieldByName('estrategia').asString then
              begin
                if (sTipo_Limite = 'T') then
                  Inserta_Errores('Proceso Limite',
                                  'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
                T_TmpDatos.Next;
                Continue;
              end;
            end;
          /// / DC 31/05/2017

          // Verifico NACION del EMISOR
          // if Qry_Limites_Det.Fieldbyname('Nacion').asString <> '' then
          if (Not Qry_Limites_Det.FieldByName('Nacion').IsNull) and
             (Trim(Qry_Limites_Det.FieldByName('Nacion').asString) <> '') then
          begin
            fItem_Dir_Emisor := default_direccion(FieldByName('Emisor').asString,
                                                  dFecha_Cierre);

            sCodigo_Geo_Emisor := Codigo_Geo_IdDir(
              FieldByName('Emisor').asString,
              fItem_Dir_Emisor);

            sPais := Pais_Para_CodGeo(sCodigo_Geo_Emisor);

            if sPais = '' then
            begin
              Inserta_Errores('Dirección, Pais Emisor :',
                              ' Error en dirección(' + FloatToStr(fItem_Dir_Emisor) + '), Emisor: ' + FieldByName('Emisor').asString + '.' + ' No se Encuentra país para Dirección. ');
              Next;
              Continue;
            end;

            sNacion := Nacion_Pais(sPais);
            if sNacion = '' then
            begin
              Inserta_Errores(' Nación Pais :',
                              ' Error en Definición de Nación para Pais : ' + sPais + ' Emisor : ' + FieldByName('Emisor').asString);

              Next;
              Continue;
            end;

            // EMISORES CON DIFERENTE NACION A LA INDICADA EN EL LIMITE
            // NO SON CONSIDERADAS
            if sNacion <> Qry_Limites_Det.FieldByName('Nacion').asString then
            begin
              if (sTipo_Limite = 'T') then
                Inserta_Errores('Proceso Limite',
                                'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
              Next;
              Continue;
            end;
          end;

          // Verifico Presencia Bursatil
          if (Trim(Qry_Limites_Det.FieldByName('SIN_PRES_BURSATIL').asString) <> '') and
             (Trim(Qry_Limites_Det.FieldByName('SIN_PRES_BURSATIL').asString) <> 'N')  then
          begin
            if FieldByName('Presencia_Bursatil').asFloat > 0 then
            begin
              if (sTipo_Limite = 'T') then
                Inserta_Errores('Proceso Limite',
                                'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
              Next;
              Continue;
            end;
          end;

          Result := True;
          // Valido Clasificación 251
          if (Trim(Qry_Limites_Det.FieldByName('Clasif_251').asString) <> '') and
              (Qry_Limites_Det.FieldByName('Nodo').asFloat <> 0) then
          begin
            // Verifico que Nemotecnico Tenga Clasificación.
            if FieldByName('Tipo_Instrum').asString = 'R'  then
              Determina_Nodo_Clasificacion('NEMRVAR',
                                            FieldByName('Nemotecnico').asString,
                                            Qry_Limites_Det.FieldByName('Clasif_251').asString,
                                            fNodo_Clasif)
            else
              Determina_Nodo_Clasificacion('NEMOTECNIC',
                                            FieldByName('Nemotecnico').asString,
                                            Qry_Limites_Det.FieldByName('Clasif_251').asString,
                                            fNodo_Clasif);
            if fNodo_Clasif <> Qry_Limites_Det.FieldByName('Nodo').asFloat then
            begin
              if (sTipo_Limite = 'T')
              then
                Inserta_Errores('Proceso Limite',
                                'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
              Next;
              Continue;
            end;
          end;

          if Trim(Qry_Limites_Det.FieldByName('Clasif_Riesgo').asString) <> '' then
          begin
            // Busca clasificación de Riesgo Vigente
            // SOLO PARA LOS LIMITES POR EMISION

            // ggarcia 17-06-2013 se vuelve a buscar la clasificacion de riesgo aca, ya que se agrego a la busqueda la clasificadora de riesgo,
            // en la temporal viene la clasificacion de riesgo de la clasificadora por defecto.
            Leer_Nemotecnico( FieldByName('Nemotecnico').asString
                            // ggarcia 26-02-2014 obtengo emisor original ya que este es el emisor pagador
                              ,''
                              ,dFecha_Emision
                              ,sEmisor
                              ,sInstrumento
                              ,sSerie
                              ,Result);

            if not Result then
              sEmisor := FieldByName('Emisor').asString;

            if Qry_Limites_Det.FieldByName('Clasificadora_Riesgo').asString <> '' then
              sClasificadora_Riesgo := Qry_Limites_Det.FieldByName('Clasificadora_Riesgo').asString
            else
              sClasificadora_Riesgo := default_codgen('AGENCIACLA',
                                                      'FI',
                                                      '');

            sTipo_Clasif := ''; // ggarcia 14-07-2015

            Busca_Clasif_Riesgo_Origen_Tipo_Mem(sEmisor,
                                                FieldByName('Instrumento').asString,
                                                FieldByName('Serie').asString,
                                                FieldByName('Nemotecnico').asString,
                                                dFecha_Cierre,
                                                sClasificadora_Riesgo,
                                                sTipo_Clasif,
                                                False,
                                                sClasificacion_Riesgo,
                                                fFactor_Riesgo,
                                                sEmisor_Pagador);

            // Si NO VIENE CON CLASIFICACION de RIESGO DE MERCADO
            if (sClasificacion_Riesgo = '') and (Qry_Limites_Det.FieldByName('Incluye_SIN_Clasif').asString <> 'S') then
            begin
              Inserta_Errores('Clasificación de Riesgo ',
                                'No Existe Clasif.de Riesgo (Valorización) Emisor: '
                                + sEmisor // Fieldbyname('Emisor').asString
                                + ' Instrumento: '
                                + FieldByName('Instrumento').asString
                                + ' Serie: '
                                + FieldByName('Serie').asString
                                + ' Nemotecnico: '
                                + FieldByName('Nemotecnico').asString);
              Next;
              Continue;
            end;

            if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'EMISION') or
               (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'EMISION-VC') then
            begin
              if sClasificacion_Riesgo = '' then
              begin
                Inserta_Errores(  ' Clasificación de Riesgo ',
                                  ' No existe Clasif.de riesgo vigente Emisor: '
                                  + FieldByName('Emisor').asString
                                  + ' Instrumento: '
                                  + FieldByName('Instrumento').asString
                                  + ' Serie: '
                                  + FieldByName('Serie').asString
                                  + ' Nemotecnico: '
                                  + FieldByName('Nemotecnico').asString // ggarcia 14-07-2015
                                  );
                if Qry_Limites_Det.FieldByName('Incluye_SIN_Clasif').asString <> 'S' then
                begin
                  if (sTipo_Limite = 'T') then
                    Inserta_Errores( 'Proceso Limite',
                                     'No aplica OMD para limite encontrado '
                                     + Qry_Limites.FieldByName('codigo_limite').asString);
                  Next;
                  Continue;
                end;
              end;
            end;

            if (sClasificacion_Riesgo <> '') then
            begin
              if Not Aplica_Operacion_Clasif_Riesgo_Mem(sClasificacion_Riesgo,
                                                        Qry_Limites_Det.FieldByName('Clasif_Riesgo').asString,
                                                        Qry_Limites_Det.FieldByName('Operacion').asString,
                                                        Qry_Limites_Det.FieldByName('APLICA_EQUIV').asString,
                                                        FieldByName('Tipo_Instrum').asString,
                                                        sModulo_Error,
                                                        sString_Error) then
              begin
                if (sTipo_Limite = 'T') then
                  Inserta_Errores( 'Proceso Limite',
                                   'No aplica OMD para limite encontrado '
                                   + Qry_Limites.FieldByName('codigo_limite').asString);
                Next;
                Continue;
              end;
            end
            else
            begin
              if Not (Qry_Limites_Det.FieldByName('Incluye_SIN_Clasif').asString = 'S') then
              begin
                if (sTipo_Limite = 'T') then
                  Inserta_Errores( 'Proceso Limite',
                                   'No aplica OMD para limite encontrado '
                                   + Qry_Limites.FieldByName('codigo_limite').asString);
                Next;
                Continue;
              end;
            end;

//            if Not((Qry_Limites_Det.FieldByName('Incluye_SIN_Clasif').asString = 'S') and
//                   (sClasificacion_Riesgo <> '')) then
//              if Not Aplica_Operacion_Clasif_Riesgo_Mem(sClasificacion_Riesgo,
//                                                        Qry_Limites_Det.FieldByName('Clasif_Riesgo').asString,
//                                                        Qry_Limites_Det.FieldByName('Operacion').asString,
//                                                        Qry_Limites_Det.FieldByName('APLICA_EQUIV').asString,
//                                                        FieldByName('Tipo_Instrum').asString,
//                                                        sModulo_Error,
//                                                        sString_Error) then
//              begin
//                if (sTipo_Limite = 'T')
//                then
//                  Inserta_Errores( 'Proceso Limite',
//                                   'No aplica OMD para limite encontrado '
//                                   + Qry_Limites.FieldByName('codigo_limite').asString);
//                Next;
//                Continue;
//              end;
          end;

          // valido presencia bursatil--->>>   edosan
          if (Qry_Limites_Det.FieldByName('Presencia_Bursatil').asFloat <> 0) and
             (Qry_Limites_Det.FieldByName('Operacion').asString <> '') and
              (FieldByName('Tipo_Instrum').asString = 'R') then
          begin
            If Not Aplica_Operacion_lim(FieldByName('Presencia_Bursatil').asFloat,
                                        Qry_Limites_Det.FieldByName('Presencia_Bursatil').asFloat,
                                        Qry_Limites_Det.FieldByName('Operacion').asString) then
            begin
              if (sTipo_Limite = 'T') then
                Inserta_Errores(  'Proceso Limite',
                                  'No aplica OMD para limite encontrado '
                                  + Qry_Limites.FieldByName('codigo_limite').asString);
              Next;
              Continue;
            end;
          end;

          // INICIO GGARCIA 03-2010
          if (Trim(Qry_Limites_Det.FieldByName('Emisor').asString) <> '') then
          begin
            if FieldByName('Emisor').asString <> Qry_Limites_Det.FieldByName('Emisor').asString then
            begin
              if (sTipo_Limite = 'T') then
                Inserta_Errores('Proceso Limite',
                                'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
              Next;
              Continue;
            end;
          end;
          // FIN GGARCIA 03-2010

          // INICIO GGARCIA 28-12-2012 Nuevas restricciones Mantenedor de Limites.
          if (Trim(Qry_Limites_Det.FieldByName('Operador_Motivo').asString) <> '') and
             (Trim(Qry_Limites_Det.FieldByName('Motivo').asString) <> '') then
          begin
            bMotivo := True;
            if Qry_Limites_Det.FieldByName('Operador_Motivo').asString = '=' then
              bMotivo := (FieldByName('Motivo').asString = Qry_Limites_Det.FieldByName('Motivo').asString)
            else
              if Qry_Limites_Det.FieldByName('Operador_Motivo').asString = '<>' then
                bMotivo := (FieldByName('Motivo').asString <> Qry_Limites_Det.FieldByName('Motivo').asString);
            if not bMotivo then
            begin
              if (sTipo_Limite = 'T') then
                Inserta_Errores('Proceso Limite',
                                'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
              Next;
              Continue;
            end;
          end;

          if (Trim(Qry_Limites_Det.FieldByName('Operador_Duration').asString) <> '') then
          begin
            bDuration := True;
            if Qry_Limites_Det.FieldByName('Operador_Duration').asString = '=' then
              bDuration := (FieldByName('Duration').asFloat = Qry_Limites_Det.FieldByName('Duration').asFloat)
            else
              if Qry_Limites_Det.FieldByName('Operador_Duration').asString = '<' then
                bDuration := (FieldByName('Duration').asFloat < Qry_Limites_Det.FieldByName('Duration').asFloat)
              else
                if Qry_Limites_Det.FieldByName('Operador_Duration').asString = '<=' then
                  bDuration := (FieldByName('Duration').asFloat <= Qry_Limites_Det.FieldByName('Duration').asFloat)
                else
                  if Qry_Limites_Det.FieldByName('Operador_Duration').asString = '>' then
                    bDuration := (FieldByName('Duration').asFloat > Qry_Limites_Det.FieldByName('Duration').asFloat)
                  else
                    if Qry_Limites_Det.FieldByName('Operador_Duration').asString = '>=' then
                      bDuration := (FieldByName('Duration').asFloat >= Qry_Limites_Det.FieldByName('Duration').asFloat)
                    else
                      if Qry_Limites_Det.FieldByName('Operador_Duration').asString = '<>' then
                        bDuration := (FieldByName('Duration').asFloat <> Qry_Limites_Det.FieldByName('Duration').asFloat);
            if not bDuration then
            begin
              if (sTipo_Limite = 'T') then
                Inserta_Errores( 'Proceso Limite',
                                 'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
              Next;
              Continue;
            end;
          end;
          // FIN GGARCIA 28-12-2012 Nuevas restricciones Mantenedor de Limites.

          // INICIO GGARCIA 13-09-2013
          if (Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat <> 0) and
              (Qry_Limites_Det.FieldByName('Fecha_Ref_Vcto').asString <> '') then
            begin
              bPlazo_Vcto                       := True;
              Registro_Fechas.Fecha_Calculo     := dFecha_Cierre;
              Registro_Fechas.Fecha_Compra      := FieldByName('Fecha_Operacion').AsDateTime;
              Registro_Fechas.Fecha_Emision     := FieldByName('Fecha_Emision').AsDateTime;
              Registro_Fechas.Fecha_Vencimiento := FieldByName('Fecha_Vcto').AsDateTime;
              Registro_Fechas.Fecha_Pago        := FieldByName('Fecha_Operacion').AsDateTime;
              Tratamiento_Fecha(
                Qry_Limites_Det.FieldByName('Fecha_Ref_Vcto').asString,
                Registro_Fechas,
                dFecha_Plazo,
                sModulo_Err,
                sString_Err,
                Result);
              if NOT Result then
                bPlazo_Vcto := False
              else
                begin
                  if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '=' then
                    bPlazo_Vcto := ((dFecha_Plazo - dFecha_Cierre) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) = Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
                  else
                    if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '<' then
                      bPlazo_Vcto := ((dFecha_Plazo - dFecha_Cierre) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) < Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
                    else
                      if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '<=' then
                        bPlazo_Vcto := ((dFecha_Plazo - dFecha_Cierre) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) <= Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
                      else
                        if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '>' then
                          bPlazo_Vcto := ((dFecha_Plazo - dFecha_Cierre) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) > Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
                        else
                          if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '>=' then
                            bPlazo_Vcto :=((dFecha_Plazo - dFecha_Cierre) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) >= Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
                          else
                            if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '<>' then
                              bPlazo_Vcto := ((dFecha_Plazo - dFecha_Cierre) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) <> Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat;

////DC 28/06/2023
//                  if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '=' then
//                    bPlazo_Vcto := ((FieldByName('Fecha_Vcto').AsDateTime - dFecha_Plazo) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) = Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
//                  else
//                    if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '<' then
//                      bPlazo_Vcto := ((FieldByName('Fecha_Vcto').AsDateTime - dFecha_Plazo) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) < Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
//                    else
//                      if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '<=' then
//                        bPlazo_Vcto := ((FieldByName('Fecha_Vcto').AsDateTime - dFecha_Plazo) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) <= Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
//                      else
//                        if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '>' then
//                          bPlazo_Vcto := ((FieldByName('Fecha_Vcto').AsDateTime - dFecha_Plazo) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) > Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
//                        else
//                          if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '>=' then
//                            bPlazo_Vcto :=((FieldByName('Fecha_Vcto').AsDateTime - dFecha_Plazo) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) >= Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat
//                          else
//                            if Qry_Limites_Det.FieldByName('Operador_Plazo').asString = '<>' then
//                              bPlazo_Vcto := ((FieldByName('Fecha_Vcto').AsDateTime - dFecha_Plazo) / StrToFloat('365' + FormatSettings.DecimalSeparator + '25')) <> Qry_Limites_Det.FieldByName('Anos_Vcto').asFloat;
////DC 28/06/2023
///
                end;
              if not bPlazo_Vcto then
                begin
                  if (sTipo_Limite = 'T') then
                    Inserta_Errores('Proceso Limite',
                                    'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
                  Next;
                  Continue;
                end;
            end;
          // FIN GGARCIA 13-09-2013

          /// DC 02/08/2016
          // Guardo Valores si emisor pertenece a clasificacion
          if Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMICLASIF' then
          begin
            for i := 0 to VarArrayHighBound(Reg_Grupos_EmiClasif.Tipo_Clasif, 1) do
              if (Reg_Grupos_EmiClasif.Tipo_Clasif[i] = FieldByName('Tipo_Clasif').asString) and
                 (Reg_Grupos_EmiClasif.Grupo_Clasif[i] = FieldByName('Grupo_Clasif').asFloat) then
              begin
                Reg_Grupos_EmiClasif.Valor_Cartera[i] := Reg_Grupos_EmiClasif.Valor_Cartera[i] + fValor_Pte_mc_Cpa_Detalle;
                break;
              end;
          end;
          /// DC 02/08/2016
          // Guardo Valores si emisor pertenece a grupo
          if Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIGRUPO' then
          begin
            for i := 0 to VarArrayHighBound(Reg_Grupos_Emisores.Grupo_Emisor, 1) do
              if Reg_Grupos_Emisores.Grupo_Emisor[i] = FieldByName('Grupo_Emisor').asString then
              begin
                Reg_Grupos_Emisores.Valor_Cartera[i] := Reg_Grupos_Emisores.Valor_Cartera[i] + fValor_Pte_mc_Cpa_Detalle;
                // Fieldbyname('Valor_Pte_mc_Cpa').asFloat;
                break;
              end;
          end;

          // Guardo Valores POR Emisor para Agrupación O Filiales
          if (Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIINSTRUM') or
             (Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIFILIAL') then
          begin
            // Si Emisor es relacionado con la cia....
            // rescato porcentaje si existe definición
            if Qry_Limites.FieldByName('Relacion_Cia').asString = 'RELACION' then
            begin
              Leer_Cartera(sEmpresa,
                            FieldByName('Cartera').asString,
                            sDescripcion,
                            sIdentidadCli,
                            sMoneda_Cartera,
                            sProrrateo_Valores,
                            Result);
              if Not Result then
                begin
                  if (sTipo_Limite = 'T') then
                    Inserta_Errores('Proceso Limite',
                                    'No aplica OMD para limite encontrado ' + Qry_Limites.FieldByName('codigo_limite').asString);
                  Next;
                  Continue;
                end;
              bEmisor_Relacionado := Emisores_Relacionado_Cia(sIdentidadCli,
                                                              FieldByName('Emisor').asString,
                                                              dFecha_Cierre);
              if bEmisor_Relacionado then
                fValor_Pte_mc_Cpa_Detalle := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                                 dFecha_Cierre,
                                                                 (fValor_Pte_mc_Cpa_Detalle * Qry_Limites.FieldByName('Porcentaje_Cia').asFloat / 100));
            end;

            for i := 0 to VarArrayHighBound(Reg_Emisores.Emisor, 1) do
              if Reg_Emisores.Emisor[i] = FieldByName('Emisor').asString then
              begin
                Reg_Emisores.Valor_Cartera[i] := Reg_Emisores.Valor_Cartera[i] + fValor_Pte_mc_Cpa_Detalle;
                break;
              end;
          end;

          if (Qry_Limites.FieldByName('Codigo_Porcentaje').asString = 'ACCIONES') or
             (Qry_Limites.FieldByName('Codigo_Porcentaje').asString = 'CUOTAS') then
          begin
            for i := 0 to VarArrayHighBound(Reg_Emisores_Nem.Emisor, 1) do
              if Reg_Emisores_Nem.Nemotecnico[i] = FieldByName('Nemotecnico').asString then
              begin
                Reg_Emisores_Nem.Valor_Cartera[i] := Reg_Emisores_Nem.Valor_Cartera[i] + fValor_Pte_mc_Cpa_Detalle;
                break;
              end;
          end;

          // Si es Limite por serie Calculo el Valor por Detalle

          sSeries_Inscritas := '';
          if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'EMISION' then
          begin
            if FieldByName('Tipo_Instrum').asString = 'S' then
            begin
              Determina_Inscripcion(  FieldByName('Emisor_Original').asString,
                                      FieldByName('Instrumento').asString,
                                      FieldByName('Serie').asString,
                                      FieldByName('Moneda_Instrum').asString,
                                      sSeries_Inscritas,
                                      fMonto_Inscrito);
              if fMonto_Inscrito = 0 then
                begin
                  Inserta_Errores(  ' Emisión de Series ',
                                    ' No existe emisión de series Emisor: '
                                    + FieldByName('Emisor_Original').asString
                                    + ' Instrumento: '
                                    + FieldByName('Instrumento').asString
                                    + ' Serie: '
                                    + FieldByName('Serie').asString
                                    + ' Moneda: '
                                    + FieldByName('Moneda_Instrum').asString);
                  Next;
                  Continue;
                end
              else
                begin
                  Edit;
                  FieldByName('Monto_Inscrito').asFloat    := fMonto_Inscrito;
                  FieldByName('Series_Inscritas').asString := sSeries_Inscritas;
                  // fValor_Pte_mc_Cpa_Detalle := Fieldbyname('Valor_Pte_mc_Cpa').asFloat;
                  Post;
                end;
            end
            else
            begin
              // Busca Mantenedor emisores
              bResult := False;
              Datos_Emisor( FieldByName('Emisor_Original').asString,
                            StrToDate(Ed_Fecha.Text),
                            sGrupo_economico,
                            sSugrupo_economico,
                            fPatrimonio,
                            fTotal_LH_emitidas,
                            fMonto_Inscrito,
                            fTotal_Acc_suscritas,
                            bResult);
              if not bResult then
              begin
                Inserta_Errores(  ' Emisión de Series ',
                                  ' No existe emisión de series Emisor: '
                                  + FieldByName('Emisor_Original').asString
                                  + ' Instrumento: '
                                  + FieldByName('Instrumento').asString
                                  + ' Serie: '
                                  + FieldByName('Serie').asString
                                  + ' Moneda: '
                                  + FieldByName('Moneda_Instrum').asString);
                Next;
                Continue;
              end
              else
              begin
                Edit;
                FieldByName('Monto_Inscrito').asFloat    := fMonto_Inscrito;
                FieldByName('Series_Inscritas').asString := sSeries_Inscritas;
                // fValor_Pte_mc_Cpa_Detalle := Fieldbyname('Valor_Pte_mc_Cpa').asFloat;
                Post;
              end;
            end;
          end;

          // Si es Limite por serie Calculo el Valor por Detalle
          if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'EMISION-VC' then
          begin
            sSeries_Inscritas := '';
            Leer_Valor_Cambio2_Mem(FieldByName('Moneda_Instrum').asString,
                                    sMoneda_Nacional,
                                    'BC',
                                    dFecha_Cierre,
                                    fValor_Cambio,
                                    Result);
            if not Result then
            begin
              Inserta_Errores('Proceso Limite',
                              'No se encontro Tipo Cambio, Fecha - Moneda ' + DateToStr(dFecha_Cierre) + ' - ' + FieldByName('Moneda_Instrum').asString);
              Next;
              Continue;
            end;

            if FieldByName('Tipo_Instrum').asString = 'S' then
            begin
              Determina_Inscripcion(  FieldByName('Emisor_Original').asString,
                                      FieldByName('Instrumento').asString,
                                      FieldByName('Serie').asString,
                                      FieldByName('Moneda_Instrum').asString,
                                      sSeries_Inscritas,
                                      fMonto_Inscrito);
              if fMonto_Inscrito = 0 then
              begin
                Inserta_Errores(  ' Emisión de Series ',
                                  ' No existe emisión de series Emisor: '
                                  + FieldByName('Emisor_Original').asString
                                  + ' Instrumento: '
                                  + FieldByName('Instrumento').asString
                                  + ' Serie: '
                                  + FieldByName('Serie').asString
                                  + ' Moneda: '
                                  + FieldByName('Moneda_Instrum').asString);
                Next;
                Continue;
              end
              else
              begin
                Edit;
                FieldByName('Monto_Inscrito').asFloat    := fMonto_Inscrito * fValor_Cambio;
                FieldByName('Series_Inscritas').asString := sSeries_Inscritas;
                Post;
              end;
            end
            else
            begin
              // Busca Mantenedor emisores
              bResult := False;
              Datos_Emisor( FieldByName('Emisor_Original').asString,
                            StrToDate(Ed_Fecha.Text),
                            sGrupo_economico,
                            sSugrupo_economico,
                            fPatrimonio,
                            fTotal_LH_emitidas,
                            fMonto_Inscrito,
                            fTotal_Acc_suscritas,
                            bResult);
              if not bResult then
              begin
                Inserta_Errores(  ' Emisión de Series ',
                                  ' No existe emisión de series Emisor: '
                                  + FieldByName('Emisor_Original').asString
                                  + ' Instrumento: '
                                  + FieldByName('Instrumento').asString
                                  + ' Serie: '
                                  + FieldByName('Serie').asString
                                  + ' Moneda: '
                                  + FieldByName('Moneda_Instrum').asString);
                Next;
                Continue;
              end
              else
              begin
                Edit;
                FieldByName('Monto_Inscrito').asFloat    := fMonto_Inscrito * fValor_Cambio;
                FieldByName('Series_Inscritas').asString := sSeries_Inscritas;
                Post;
              end;
            end;
          end;

          if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'ACCIONES') OR
             (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'ACCIONES') then
          begin
            // Rescato valores del Estado del Emisor
            Qry_EstadoEMI.Close;
            Qry_EstadoEMI.Parambyname('Emisor').asString := FieldByName('Emisor').asString;
            Qry_EstadoEMI.Parambyname('Fecha').AsDate    := dFecha_Cierre;

            if bdesarrollo then
               Qry_EstadoEMI.Open
            else
              try
                Qry_EstadoEMI.Open;
              except
                on E: EFDDBEngineException do
                  begin
                    ShowError(E);
                  end;
              end;

            if Not Qry_EstadoEMI.FieldByName('Emisor').IsNull then
            begin
              Edit;
              FieldByName('Monto_Inscrito').asFloat := Qry_EstadoEMI.FieldByName('ACC_SUSCRITAS').asFloat;
              Post;
            end;
            Qry_EstadoEMI.Close;
            // Rescato Acciones Cuotas Suscritas a nivel de Nemotecnico
            Qry_AccCta_Suscritas.Close;
            Qry_AccCta_Suscritas.Parambyname('Nemotecnico').asString := FieldByName('Nemotecnico').asString;
            Qry_AccCta_Suscritas.Parambyname('Fecha').AsDate         := dFecha_Cierre;

            if bdesarrollo then
               Qry_AccCta_Suscritas.Open
            else
              try
                Qry_AccCta_Suscritas.Open;
              except
                on E: EFDDBEngineException do
                  begin
                    ShowError(E);
                  end;
              end;

            if Not Qry_AccCta_Suscritas.FieldByName('Nemotecnico').IsNull then
            begin
              Edit;
              FieldByName('Monto_Inscrito').asFloat := Qry_AccCta_Suscritas.FieldByName('MONTO_SUSCRITO').asFloat;
              Post;
            end;

            Qry_AccCta_Suscritas.Close;
            fValor_Pte_mc_Cpa_Detalle := FieldByName('Valor_Pte_mc_Cpa').asFloat;
          end;

          // Guardo Valores por deudor
          if Qry_Limites.FieldByName('Suma_Inversion').asString = 'IDEMDEUDOR' then
          begin
            for i := 0 to VarArrayHighBound(Reg_Deudores_Mem.Deudor, 1) do
              if Reg_Deudores_Mem.Deudor[i] = FieldByName('Credencial_Deudor').asString then
              begin
                Reg_Deudores_Mem.Valor_Cartera[i] := Reg_Deudores_Mem.Valor_Cartera[i] +
                                                     fValor_Pte_mc_Cpa_Detalle;
                break;
              end;
          end;

          // Guardo Valores por Id del Crédito
          if Qry_Limites.FieldByName('Suma_Inversion').asString = 'CREDITO' then
          begin
            for i := 0 to VarArrayHighBound(Reg_Creditos_Mem.Id_Credito, 1) do
              if Reg_Creditos_Mem.Id_Credito[i] = FieldByName('Id_Credito').asString then
              begin
                Reg_Creditos_Mem.Valor_Cartera[i] := Reg_Creditos_Mem.Valor_Cartera[i] +
                                                     fValor_Pte_mc_Cpa_Detalle;
                break;
              end;
          end;

          // Guardo Valores si emisor pertenece a grupo
          if Qry_Limites.FieldByName('Suma_Inversion').asString = 'SUMNEMOTEC' then
          begin
            for i := 0 to VarArrayHighBound(Reg_Emisor_Nemo.Emisor, 1) do
              if Reg_Emisor_Nemo.Nemotecnico[i] = T_TmpDatos.FieldByName('Nemotecnico').asString then
                begin
                  Reg_Emisor_Nemo.Valor_Cartera[i] := Reg_Emisor_Nemo.Valor_Cartera[i] + fValor_Pte_mc_Cpa_Detalle;
                  break;
                end;
          end;

          // GGARCIA 03-2010  para limites transacciones
          if (Qry_Limites.FieldByName('Codigo_Porcentaje').asString = 'PASIVOS') then
          begin
            for i := 0 to VarArrayHighBound(Reg_Monedas.Moneda, 1) do
              if Reg_Monedas.Moneda[i] = FieldByName('Moneda_Instrum').asString then
                begin
                  Reg_Monedas.Valor_Cartera[i] := Reg_Monedas.Valor_Cartera[i] + fValor_Pte_mc_Cpa_Detalle;
                  break;
                end;
          end;
          // FIN GGARCIA 03-2010

          // Acumula para obtener Valor presente total
          fValor_Pte_MC_Cpa := fValor_Pte_MC_Cpa + fValor_Pte_mc_Cpa_Detalle;

          if Qry_Limites.FieldByName('TIPO_LIMITE').asString = 'INSTRUMENT' then
            if not BuscaStr(sInstrumentos, FieldByName('Instrumento').asString) then
              sInstrumentos := sInstrumentos + FieldByName('Instrumento').asString + ';';

          if FieldByName('Tipo_Grupo').asString = 'TRANSACCIO' then
            if not BuscaStr( sInstrumentos
                            ,Trim(FieldByName('Transaccion').asString)) then
               sInstrumentos := sInstrumentos +
                                FieldByName('Transaccion').asString +
                                ';';

          // Inserto En Tabla de Detalle
          T_TmpDatosLimite.insert;
          T_TmpDatosLimite.FieldByName('Empresa').asString          := Trim(FieldByName('Empresa').asString);
          T_TmpDatosLimite.FieldByName('Cartera').asString          := Trim(FieldByName('Cartera').asString);
          T_TmpDatosLimite.FieldByName('Transaccion').asString      := Trim(FieldByName('Transaccion').asString);
          T_TmpDatosLimite.FieldByName('Folio_interno').asString    := Trim(FieldByName('Folio_interno').asString);
          T_TmpDatosLimite.FieldByName('Item_OMD').asFloat          := FieldByName('Item_OMD').asFloat;
          T_TmpDatosLimite.FieldByName('Nemotecnico').asString      := Trim(FieldByName('Nemotecnico').asString);
          T_TmpDatosLimite.FieldByName('Emisor').asString           := Trim(FieldByName('Emisor').asString);
          T_TmpDatosLimite.FieldByName('Instrumento').asString      := Trim(FieldByName('Instrumento').asString);
          T_TmpDatosLimite.FieldByName('Serie').asString            := Trim(FieldByName('Serie').asString);
          T_TmpDatosLimite.FieldByName('Valor_Nominal').asFloat     := FieldByName('Valor_Nominal').asFloat;
          T_TmpDatosLimite.FieldByName('Valor_Pte_mc_Cpa').asFloat  := fValor_Pte_mc_Cpa_Detalle;
          T_TmpDatosLimite.FieldByName('Moneda_Instrum').asString   := Trim(FieldByName('Moneda_Instrum').asString);
          T_TmpDatosLimite.FieldByName('Saldo_Insoluto').asFloat    := FieldByName('Saldo_Insoluto').asFloat;
          T_TmpDatosLimite.FieldByName('Monto_Inscrito').asFloat    := FieldByName('Monto_Inscrito').asFloat;
          T_TmpDatosLimite.FieldByName('Series_Inscritas').asString := Trim(sSeries_Inscritas);
          T_TmpDatosLimite.FieldByName('Clasif_Riesgo').asString    := Trim(sClasificacion_Riesgo);
          T_TmpDatosLimite.FieldByName('Clasif_Limite').asString    := Trim(Qry_Limites_Det.FieldByName('Clasif_Riesgo').asString);
          T_TmpDatosLimite.FieldByName('Codigo_Limite').asString    := Trim(Qry_Limites.FieldByName('Codigo_Limite').asString);
          T_TmpDatosLimite.FieldByName('Codigo_RTPR').asString      := Trim(FieldByName('Codigo_RTPR').asString);
          T_TmpDatosLimite.FieldByName('Grupo_Emisor').asString     := Trim(FieldByName('Grupo_Emisor').asString);
          T_TmpDatosLimite.FieldByName('Tipo_Clasif').asString      := Trim(FieldByName('Tipo_Clasif').asString);
          T_TmpDatosLimite.FieldByName('Grupo_Clasif').asFloat      := FieldByName('Grupo_Clasif').asFloat;
          T_TmpDatosLimite.Post;
          bExisten_Valores_Limites := True;
          Next;
        end;
      end;
      Qry_Limites_Det.Next;
    end; // Not Qry_Limites_Det.eof

//    With Qry_Prdx do
//    begin
//      // Rescato Valores Afectados Por Emisión
//      Close;
//      Sql.Clear;
//      Sql.Add('SELECT *'
//            + '  FROM ' + T_TmpDatosLimite.Name  );
//
//      Genera_Excel_Qry(Qry_Prdx, 'Monto_Inscrito');
//      Close;
//    end;

    if sTipo_Limite = '' then
    begin
      Lbl_Avance2.Caption      := '';
      LabelPorcentaje2.Caption := '';
      ProgressBar2.Position    := 0;
      Application.ProcessMessages;
    end;

      // CALCULO LIMITE
    if bExisten_Valores_Limites then
    begin
      // ggarcia 10-09-2013
      if Qry_Limites.FieldByName('Tipo_Def_Limite').asString = 'MONTO_FIJO' then
      begin
        // fPorcentaje_Limite     := 100;
        // fPorcentaje_Limite_Min := 100;
        fPorcentaje_Limite     := Qry_Limites.FieldByName('Porcentaje').asFloat;
        fPorcentaje_Limite_Min := Qry_Limites.FieldByName('Porcentaje_Min').asFloat;

        fTotal_Porcentaje     := Qry_Limites.FieldByName('Porcentaje').asFloat;
        fTotal_Porcentaje_Min := Qry_Limites.FieldByName('Porcentaje_Min').asFloat;

        if Trim(Qry_Limites.FieldByName('Moneda').asString) <> '' then
        begin
          Leer_Valor_Cambio2_Mem(Qry_Limites.FieldByName('Moneda').asString,
                                  sMoneda_Nacional,
                                  'BC',
                                  dFecha_Cierre,
                                  fValor_Cambio,
                                  Result);
          if not Result then
          begin
            Inserta_Errores('Proceso Limite',
                            'No se encontro Tipo Cambio, Fecha - Moneda ' + DateToStr(dFecha_Cierre) + ' - ' + Qry_Limites.FieldByName('Moneda').asString);
            Next;
            Continue;
          end;

          fValor_Pte_Limite := Redondeo_Moneda_Mem(
                                        Qry_Limites.FieldByName('Moneda').asString
                                       ,dFecha_Cierre
                                       ,(Qry_Limites.FieldByName('Porcentaje').asFloat * fValor_Cambio));
          fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(Qry_Limites.FieldByName('Moneda').asString,
                                                       dFecha_Cierre,
                                                       (Qry_Limites.FieldByName('Porcentaje_Min').asFloat * fValor_Cambio));
        end
        else
          begin
            fValor_Pte_Limite := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                     dFecha_Cierre,
                                                     Qry_Limites.FieldByName('Porcentaje').asFloat);
            fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                         dFecha_Cierre,
                                                         Qry_Limites.FieldByName('Porcentaje_Min').asFloat);
          end
      end
      else
      begin
        // Maximo
        fPorcentaje_Limite        := Qry_Limites.FieldByName('Porcentaje').asFloat;
        fPorcentaje_Limite_Min    := Qry_Limites.FieldByName('Porcentaje_Min').asFloat;
        fTotal_Porcentaje         := 0;
        fTotal_Porcentaje_Min     := 0;
        fTotal_Porcentaje_New     := 0;
        fTotal_Porcentaje_Min_New := 0;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MONTORESER'  then
        begin
          fTotal_Porcentaje := Monto_ReservaNva(dFecha_Cierre,
                                                Qry_Limites.FieldByName('Tipo_reserva').asString);
        end;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'MONTORESER' then
        begin
          fTotal_Porcentaje_Min := Monto_ReservaNva(dFecha_Cierre,
                                                    Qry_Limites.FieldByName('Tipo_reserva').asString);
        end;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'RT' then
          fTotal_Porcentaje := fReserva_Tecnica;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'RT' then
          fTotal_Porcentaje_Min := fReserva_Tecnica;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'RT+PR' then
          fTotal_Porcentaje := fReserva_Tecnica + fPatrimonio_Riesgo;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'RT+PR' then
          fTotal_Porcentaje_Min := fReserva_Tecnica + fPatrimonio_Riesgo;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'PR' then
          fTotal_Porcentaje := fPatrimonio_Riesgo;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'PR' then
          fTotal_Porcentaje_Min := fPatrimonio_Riesgo;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'PN' then
          fTotal_Porcentaje := fPatrimonio_Neto;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'PN' then
          fTotal_Porcentaje_Min := fPatrimonio_Neto;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'PL' then
          fTotal_Porcentaje := fPatrimonio_Libre;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'PL' then
          fTotal_Porcentaje_Min := fPatrimonio_Libre;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'VP' then
          fTotal_Porcentaje := fValor_Pte_Compra;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'VP' then
          fTotal_Porcentaje_Min := fValor_Pte_Compra;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'VM' then
          fTotal_Porcentaje := fValor_Pte_Mercado;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'VM' then
          fTotal_Porcentaje_Min := fValor_Pte_Mercado;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'VX' then
          fTotal_Porcentaje := fValor_Pte_Mixto;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'VX' then
          fTotal_Porcentaje_Min := fValor_Pte_Mixto;

        // E.S.   (Para Calcular Minimo o Maximo valor entre una lista de valores
        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MIN_LISTA') or
           (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MAX_LISTA') then
        begin
          for i := 0 to VarArrayHighBound(Reg_ListaVal_Ptje.Aplica_Sobre, 1) do
          begin
            if Reg_ListaVal_Ptje.Codigo_Limite[i] = Qry_Limites.FieldByName('Codigo_Limite').asString then
            begin
              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'RT' then
                fTotal_Porcentaje_New := fReserva_Tecnica;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'RT+PR' then
                fTotal_Porcentaje_New := fReserva_Tecnica + fPatrimonio_Riesgo;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'PR' then
                fTotal_Porcentaje_New := fPatrimonio_Riesgo;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'PN' then
                fTotal_Porcentaje_New := fPatrimonio_Neto;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'PL' then
                fTotal_Porcentaje_New := fPatrimonio_Libre;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'VP' then
                fTotal_Porcentaje_New := fValor_Pte_Compra;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'VM' then
                fTotal_Porcentaje_New := fValor_Pte_Mercado;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'VX' then
                fTotal_Porcentaje_New := fValor_Pte_Mixto;

              // Nuevo MONTO en lugar de un porcentaje viene un monto fijo 08-07-2021 F.I.
              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'MONTO' then
              begin
                fValor_Cambio := 1;
                if (Trim(Reg_ListaVal_Ptje.Moneda_Monto[i]) <> '') and
                (Reg_ListaVal_Ptje.Moneda_Monto[i] <> sMoneda_Nacional) then
                  begin
                    Leer_Valor_Cambio2_Mem( Reg_ListaVal_Ptje.Moneda_Monto[i],
                                            sMoneda_Nacional,
                                            'BC',
                                            dFecha_Cierre,
                                            fValor_Cambio,
                                            Result);
                    if not Result                             then
                      begin
                        fValor_Cambio := 1;
                        Inserta_Errores( 'Proceso Limite'
                                         ,'No se encontró Tipo Cambio, Fecha - Moneda '
                                         + DateToStr(dFecha_Cierre)
                                         + ' - '
                                         + Reg_ListaVal_Ptje.Moneda_Monto[i]
                                         + ' a '
                                         + sMoneda_Nacional
                                         );
                      end;
                  end;
                fTotal_Porcentaje_New := Reg_ListaVal_Ptje.Porcentaje[i] * fValor_Cambio;
              end
              else
                fTotal_Porcentaje_New := (fTotal_Porcentaje_New *
                                          Reg_ListaVal_Ptje.Porcentaje[i]) / 100;

              if fTotal_Porcentaje = 0 then
              begin
                fPorcentaje_Limite := Reg_ListaVal_Ptje.Porcentaje[i];
                fTotal_Porcentaje  := fTotal_Porcentaje_New;
              end
              else
                if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MIN_LISTA') then
                  begin
                    if fTotal_Porcentaje_New < fTotal_Porcentaje then
                    begin
                      fPorcentaje_Limite := Reg_ListaVal_Ptje.Porcentaje[i];
                      fTotal_Porcentaje  := fTotal_Porcentaje_New;
                    end;
                  end
                else
                  if fTotal_Porcentaje_New >= fTotal_Porcentaje then // Realmente es para obtener el valor Maximo de la lista
                  begin
                    fPorcentaje_Limite := Reg_ListaVal_Ptje.Porcentaje[i];
                    fTotal_Porcentaje  := fTotal_Porcentaje_New;
                  end;
            end;
          end;
          fValor_Pte_Limite := fTotal_Porcentaje;
        end
        else
        begin
          fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje').asFloat;

          fValor_Pte_Limite := Redondeo_Moneda_Mem( sMoneda_Cartera,
                                                    dFecha_Cierre,
                                                    (fTotal_Porcentaje *
                                                     fPorcentaje_Limite / 100));
        end;

        // E.S.   (Para Calcular Minimo o Maximo valor entre una lista de valores
        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'MIN_LISTA') or
           (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'MAX_LISTA') then
        begin
          for i := 0 to VarArrayHighBound(Reg_ListaVal_Ptje.Aplica_Sobre, 1) do
          begin
            if Reg_ListaVal_Ptje.Codigo_Limite[i] = Qry_Limites.FieldByName('Codigo_Limite').asString then
            begin
              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'RT' then
                fTotal_Porcentaje_Min_New := fReserva_Tecnica;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'RT+PR' then
                fTotal_Porcentaje_Min_New := fReserva_Tecnica + fPatrimonio_Riesgo;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'PR' then
                fTotal_Porcentaje_Min_New := fPatrimonio_Riesgo;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'PN' then
                fTotal_Porcentaje_Min_New := fPatrimonio_Neto;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'PL' then
                fTotal_Porcentaje_Min_New := fPatrimonio_Libre;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'VP' then
                fTotal_Porcentaje_Min_New := fValor_Pte_Compra;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'VM' then
                fTotal_Porcentaje_Min_New := fValor_Pte_Mercado;

              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'VX' then
                fTotal_Porcentaje_Min_New := fValor_Pte_Mixto;

              // Nuevo MONTO en lugar de un porcentaje viene un monto fijo 08-07-2021 F.I.
              if Reg_ListaVal_Ptje.Aplica_Sobre[i] = 'MONTO' then
              begin
                fValor_Cambio := 1;
                if (Trim(Reg_ListaVal_Ptje.Moneda_Monto[i]) <> '') and
                   (Reg_ListaVal_Ptje.Moneda_Monto[i] <> sMoneda_Nacional)  then
                  begin
                    Leer_Valor_Cambio2_Mem( Reg_ListaVal_Ptje.Moneda_Monto[i],
                                            sMoneda_Nacional,
                                            'BC',
                                            dFecha_Cierre,
                                            fValor_Cambio,
                                            Result);
                    if not Result then
                      begin
                        fValor_Cambio := 1;
                        Inserta_Errores( 'Proceso Limite'
                                        ,'No se encontro Tipo Cambio, Fecha - Moneda '
                                        + DateToStr(dFecha_Cierre)
                                        + ' - '
                                        + Reg_ListaVal_Ptje.Moneda_Monto[i]
                                        + ' a '
                                        + sMoneda_Nacional);
                      end;
                  end;
                fTotal_Porcentaje_Min_New := Reg_ListaVal_Ptje.Porcentaje[i] * fValor_Cambio;
              end
              else
                fTotal_Porcentaje_Min_New := (fTotal_Porcentaje_Min_New * Reg_ListaVal_Ptje.Porcentaje[i]) / 100;

              if fTotal_Porcentaje_Min = 0                      then
              begin
                fPorcentaje_Limite    := Reg_ListaVal_Ptje.Porcentaje[i];
                fTotal_Porcentaje_Min := fTotal_Porcentaje_Min_New;
              end
              else
              if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'MIN_LISTA') then
              begin
//                  if fTotal_Porcentaje_Min_New < fTotal_Porcentaje
                if fTotal_Porcentaje_Min_New < fTotal_Porcentaje_Min then
                begin
                  fTotal_Porcentaje_Min := fTotal_Porcentaje_Min_New;
                  fPorcentaje_Limite    := Reg_ListaVal_Ptje.Porcentaje[i];
                end;
              end
              else
//                  if fTotal_Porcentaje_Min_New >= fTotal_Porcentaje
                if fTotal_Porcentaje_Min_New >= fTotal_Porcentaje_Min then // Realmente es para obtener el valor Maximo de la lista
                begin
                  fTotal_Porcentaje_Min := fTotal_Porcentaje_Min_New;
                  fPorcentaje_Limite    := Reg_ListaVal_Ptje.Porcentaje[i];
                end;
            end;
          end;
          fValor_Pte_Limite_Min := fTotal_Porcentaje_Min;
        end
        else
        begin
          fPorcentaje_Limite_Min := Qry_Limites.FieldByName('Porcentaje_Min').asFloat;

          fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                       dFecha_Cierre,
                                                      (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100));
        end;

        // GGARCIA 03-2010  para limites transacciones
        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'GRUPOINS' then
        begin
          for i := 0 to VarArrayHighBound(Reg_Valor_Pte.Codigo_Limite, 1) do
          begin
            if Reg_Valor_Pte.Codigo_Limite[i] = Qry_Limites.FieldByName('Codigo_Limite').asString then
              begin
                if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VP' then
                  fTotal_Porcentaje := Reg_Valor_Pte.Valor_Pte_Compra[i];
                if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VM' then
                  fTotal_Porcentaje := Reg_Valor_Pte.Valor_Pte_Mercado[i];
                if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VX' then
                  fTotal_Porcentaje := Reg_Valor_Pte.Valor_Pte_Mixto[i];
                break;
              end;
          end;
        end;

        if Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'GRUPOINS' then
        begin
          for i := 0 to VarArrayHighBound(Reg_Valor_Pte.Codigo_Limite, 1) do
          begin
            if Reg_Valor_Pte.Codigo_Limite[i] = Qry_Limites.FieldByName('Codigo_Limite').asString then
            begin
              if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VP' then
                fTotal_Porcentaje_Min := Reg_Valor_Pte.Valor_Pte_Compra[i];
              if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VM' then
                fTotal_Porcentaje_Min := Reg_Valor_Pte.Valor_Pte_Mercado[i];
              if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VX' then
                fTotal_Porcentaje_Min := Reg_Valor_Pte.Valor_Pte_Mixto[i];
              break;
            end;
          end;
        end;

        // Fin GGARCIA 03-2010

        // GGARCIA 24-09-2013 si codigo_porcentaje corresponde a un proceso de sensibilizacion toma el valor correspondiente
        if bSensibilizacion then // ggarcia 19-03-2014
        begin
          fValor_Max := 0;
          fValor_Min := 0;
          for i      := 0 to VarArrayHighBound(Reg_Otra_Valuacion.Proceso, 1) do
            begin
              if (Trim(Reg_Otra_Valuacion.Proceso[i]) <> '') and (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString <> '') then
              begin
                if (Reg_Otra_Valuacion.Proceso[i] = Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString)then
                  fValor_Max := fValor_Max + Reg_Otra_Valuacion.Valor_Valuacion_MC[i];
              end;

              if (Trim(Reg_Otra_Valuacion.Proceso[i]) <> '') and (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString <> '') then
              begin
                if (Reg_Otra_Valuacion.Proceso[i] = Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString) then
                  fValor_Min := fValor_Min + Reg_Otra_Valuacion.Valor_Valuacion_MC[i];
              end;
            end;
          if fValor_Max > 0 then
            fTotal_Porcentaje := fValor_Max;
          if fValor_Min > 0  then
            fTotal_Porcentaje_Min := fValor_Min;
        end;

        // GGARCIA 08-11-2013 si codigo_porcentaje corresponde a un grupo de instrumentos toma el valor del array correspondiente
        fValor_Max := 0;
        fValor_Min := 0;
        for i      := 0 to VarArrayHighBound(Reg_Grupos_Instrum.Grupo_Instrumento, 1) do
        begin
          if (Reg_Grupos_Instrum.Grupo_Instrumento[i] = Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString) then
          begin
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VP' then
              fValor_Max := fValor_Max + Reg_Grupos_Instrum.Valor_Pte_Compra[i];
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VM' then
              fValor_Max := fValor_Max + Reg_Grupos_Instrum.Valor_Pte_Mercado[i];
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VX'  then
              fValor_Max := fValor_Max + Reg_Grupos_Instrum.Valor_Pte_Mixto[i];
          end;
          if (Reg_Grupos_Instrum.Grupo_Instrumento[i] = Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString) then
          begin
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VP' then
              fValor_Min := fValor_Min + Reg_Grupos_Instrum.Valor_Pte_Compra[i];
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VM' then
              fValor_Min := fValor_Min + Reg_Grupos_Instrum.Valor_Pte_Mercado[i];
            if Qry_Limites.FieldByName('VALOR_COMPARACION').asString = 'VX'  then
              fValor_Min := fValor_Min + Reg_Grupos_Instrum.Valor_Pte_Mixto[i];
          end;
        end;
        if fValor_Max > 0 then
          fTotal_Porcentaje := fValor_Max;

        if fValor_Min > 0 then
          fTotal_Porcentaje_Min := fValor_Min;

        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString <> 'MIN_LISTA') and
           (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString <> 'MAX_LISTA') then
          fValor_Pte_Limite := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                   dFecha_Cierre,
                                                  (fTotal_Porcentaje * fPorcentaje_Limite / 100))
        else
          fValor_Pte_Limite := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                   dFecha_Cierre,
                                                   fTotal_Porcentaje);

        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString <> 'MIN_LISTA') and
           (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString <> 'MAX_LISTA') then
          fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                       dFecha_Cierre,
                                                      (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100))
        else
          fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                       dFecha_Cierre,
                                                       fTotal_Porcentaje_Min);

      end;

        // 28-07-2020
      if Qry_Limites.FieldByName('Suma_Inversion').asString = 'IDEMDEUDOR' then
        for i := 0 to VarArrayHighBound(Reg_Deudores_Mem.Deudor, 1) do
        begin
          if (Reg_Deudores_Mem.Deudor[i] <> '') and
             (Reg_Deudores_Mem.Valor_Cartera[i] <> 0) then
          begin
            T_TmpLimites.insert;
            T_TmpLimites.FieldByName('Codigo_Limite').asString     := Qry_Limites.FieldByName('Codigo_Limite').asString;
            T_TmpLimites.FieldByName('Tipo_Limite').asString       := Qry_Limites.FieldByName('Tipo_Limite').asString;
            T_TmpLimites.FieldByName('Credencial_Deudor').asString := Reg_Deudores_Mem.Deudor[i];
            T_TmpLimites.FieldByName('Nombre_Deudor').asString     := Reg_Deudores_Mem.Nombre_Deudor[i];
            T_TmpLimites.FieldByName('Porcentaje_Min').asFloat     := fPorcentaje_Limite_Min;
            T_TmpLimites.FieldByName('Porcentaje').asFloat         := fPorcentaje_Limite;
            T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat  := Reg_Deudores_Mem.Valor_Cartera[i];
            T_TmpLimites.FieldByName('Minimo_Permitido').asFloat   := fValor_Pte_Limite_Min;
            T_TmpLimites.FieldByName('Maximo_Permitido').asFloat   := fValor_Pte_Limite;
            if fValor_Pte_Limite <> 0 then
              T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite - Reg_Deudores_Mem.Valor_Cartera[i];
            T_TmpLimites.Post;
          end
        end
      else
        if Qry_Limites.FieldByName('Suma_Inversion').asString = 'CREDITO' then
          for i := 0 to VarArrayHighBound(Reg_Creditos_Mem.Id_Credito, 1) do
          begin
            if (Reg_Creditos_Mem.Id_Credito[i] <> '') and
               (Reg_Creditos_Mem.Valor_Cartera[i] <> 0) then
            begin

              if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'MONTOCRED') or
                 (Qry_Limites.FieldByName('CODIGO_PORCENTAJE'    ).asString = 'MONTOCRED') then
              begin
                // Rescato valores del monto del credito
                Qry_MontoCred.ParambyName('ID_CREDITO').asString := Reg_Creditos_Mem.Id_Credito[i];

                if bdesarrollo then
                   Qry_MontoCred.Open
                else
                  try
                    Qry_MontoCred.Open;
                  except
                    on E: EFDDBEngineException do
                      begin
                        ShowError(E);
                      end;
                  end;

                if Qry_MontoCred.FieldByName('MONTO_PRESTAMO').IsNull then
                begin
                    Inserta_Errores( 'Proceso Limite'
                                     ,'No se encontró definición de crédito para Id_Credito: '
                                     +T_TmpDatos.FieldByName('Id_Credito').AsString
                                     );

                    if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MONTOCRED') then
                        fTotal_Porcentaje := 0
                    else
                        fTotal_Porcentaje_Min := 0;
                end
                else
                begin
                  if (TRIM(Qry_MontoCred.FieldByName('MONEDA_PRESTAMO').AsString) = '') or
                          (Qry_MontoCred.FieldByName('MONEDA_PRESTAMO').IsNull) then
                  begin
                    Inserta_Errores( 'Proceso Limite'
                                     ,'No se encontró moneda de crédito para Id_Credito: '
                                     +T_TmpDatos.FieldByName('ID_CREDITO').AsString
                                     );

                    if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MONTOCRED') then
                        fTotal_Porcentaje := 0
                    else
                        fTotal_Porcentaje_Min := 0;
                  end
                  else
                  begin
                      Leer_Valor_Cambio2_Mem( Qry_MontoCred.FieldByName('MONEDA_PRESTAMO').AsString
                                             ,sMoneda_Nacional
                                             ,'BC'
                                             ,dFecha_Cierre
                                             ,fValor_Cambio
                                             ,Result);
                      if not Result then
                      begin
                        Inserta_Errores(
                                    'Proceso Limite',
                                    'No se encontró Tipo Cambio, Fecha - Moneda '
                                    + DateToStr(dFecha_Cierre)
                                    + ' - '
                                    + Qry_MontoCred.FieldByName('MONEDA_PRESTAMO').AsString
                                    + ' - '
                                    + sMoneda_Cartera
                                    );
                      end
                      else
                      begin
                        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MONTOCRED') then
                            fTotal_Porcentaje :=
                                     Redondeo_Moneda_Mem( sMoneda_Nacional
                                                         ,dFecha_Cierre
                                                         ,(Qry_MontoCred.FieldByName('MONTO_PRESTAMO').AsFloat *
                                                           fPorcentaje_Limite / 100)*
                                                          fValor_Cambio
                                                          )
                        else
                            fTotal_Porcentaje_Min :=
                                     Redondeo_Moneda_Mem( sMoneda_Nacional
                                                         ,dFecha_Cierre
                                                         ,(Qry_MontoCred.FieldByName('MONTO_PRESTAMO').AsFloat *
                                                          fPorcentaje_Limite_Min / 100) *
                                                          fValor_Cambio
                                                          );
                      end;
                  end;
                end;
                Qry_MontoCred.Close;
              end;

              T_TmpLimites.insert;
              T_TmpLimites.FieldByName('Codigo_Limite').asString     := Qry_Limites.FieldByName('Codigo_Limite').asString;
              T_TmpLimites.FieldByName('Tipo_Limite').asString       := Qry_Limites.FieldByName('Tipo_Limite').asString;
              T_TmpLimites.FieldByName('Porcentaje_Min').asFloat     := fPorcentaje_Limite_Min;
              T_TmpLimites.FieldByName('Porcentaje').asFloat         := fPorcentaje_Limite;
              T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat  := Reg_Creditos_Mem.Valor_Cartera[i];
              T_TmpLimites.FieldByName('Minimo_Permitido').asFloat   := fTotal_Porcentaje_Min;
              T_TmpLimites.FieldByName('Maximo_Permitido').asFloat   := fTotal_Porcentaje;
              T_TmpLimites.FieldByName('Id_Credito').asString        := Reg_Creditos_Mem.Id_Credito[i];
              if fValor_Pte_Limite <> 0 then
                T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite -
                                                              Reg_Creditos_Mem.Valor_Cartera[i];
              T_TmpLimites.Post;
            end
          end
        else
          if Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMICLASIF' then
            for i := 0 to VarArrayHighBound(Reg_Grupos_EmiClasif.Tipo_Clasif, 1) do
            begin
              if (Reg_Grupos_EmiClasif.Tipo_Clasif[i] <> '') and (Reg_Grupos_EmiClasif.Valor_Cartera[i] <> 0)
              then
                begin
                  fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje').asFloat;
                  fValor_Pte_Limite  := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                            dFecha_Cierre,
                                                            (fTotal_Porcentaje * fPorcentaje_Limite / 100));

                  fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                               dFecha_Cierre,
                                                               (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100));
                  T_TmpLimites.insert;
                  T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
                  T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
                  T_TmpLimites.FieldByName('Tipo_Clasif').asString      := Reg_Grupos_EmiClasif.Tipo_Clasif[i];
                  T_TmpLimites.FieldByName('Grupo_Clasif').asFloat      := Reg_Grupos_EmiClasif.Grupo_Clasif[i];
                  T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
                  T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
                  T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := Reg_Grupos_EmiClasif.Valor_Cartera[i];
                  T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
                  T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;
                  if fValor_Pte_Limite <> 0 then
                    T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite - Reg_Grupos_EmiClasif.Valor_Cartera[i];

                  T_TmpLimites.Post;
                end;
            end
          else
            if Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIGRUPO' then
              for i := 0 to VarArrayHighBound(Reg_Grupos_Emisores.Grupo_Emisor, 1) do
              begin
                if (Reg_Grupos_Emisores.Grupo_Emisor[i] <> '') and
                   (Reg_Grupos_Emisores.Valor_Cartera[i] <> 0) then
                begin
                  fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje').asFloat;
                  if (Qry_Limites.FieldByName('Relacion_Cia').asString = 'GRUPO') and
                     (sGrupo_Emisor_Cartera = Reg_Grupos_Emisores.Grupo_Emisor[i]) then
                    fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje_Cia').asFloat;

                  fValor_Pte_Limite := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                           dFecha_Cierre,
                                                           (fTotal_Porcentaje * fPorcentaje_Limite / 100));
                  fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                               dFecha_Cierre,
                                                               (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100));
                  T_TmpLimites.insert;
                  T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
                  T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
                  T_TmpLimites.FieldByName('Grupo_Emisor').asString     := Reg_Grupos_Emisores.Grupo_Emisor[i];
                  T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
                  T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
                  T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := Reg_Grupos_Emisores.Valor_Cartera[i];
                  T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
                  T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;
                  if fValor_Pte_Limite <> 0 then
                    T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite -
                                                                  Reg_Grupos_Emisores.Valor_Cartera[i];
                  T_TmpLimites.Post;
                end;
              end
            else
            begin
              if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'ACCIONES') or
                 (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'CUOTAS') or
                 (Qry_Limites.FieldByName('CODIGO_PORCENTAJE'    ).asString = 'ACCIONES') or
                 (Qry_Limites.FieldByName('CODIGO_PORCENTAJE'    ).asString = 'CUOTAS') then
                for i := 0 to VarArrayHighBound(Reg_Emisores_Nem.Emisor, 1) do
                begin
                  fACC_SUSCRITAS    := 0;
                  fCUOTAS_SUSCRITAS := 0;
                  // Rescato valores del Estado del Emisor
                  Qry_EstadoEMI.Parambyname('Emisor').asString := Reg_Emisores_Nem.Emisor[i];
                  Qry_EstadoEMI.Parambyname('Fecha').AsDate    := dFecha_Cierre;

                  if bdesarrollo then
                     Qry_EstadoEMI.Open
                  else
                    try
                      Qry_EstadoEMI.Open;
                    except
                      on E: EFDDBEngineException do
                        begin
                          ShowError(E);
                        end;
                    end;
                  if Not Qry_EstadoEMI.FieldByName('Emisor').IsNull then
                    begin
                      fACC_SUSCRITAS    := Qry_EstadoEMI.FieldByName('ACC_SUSCRITAS').asFloat;
                      fCUOTAS_SUSCRITAS := Qry_EstadoEMI.FieldByName('CUOTAS_SUSCRITAS').asFloat;
                    end;
                  Qry_EstadoEMI.Close;

                  // Rescato Acciones Cuotas Suscritas a nivel de Nemotecnico
                  Qry_AccCta_Suscritas.Parambyname('Nemotecnico').asString := Reg_Emisores_Nem.Nemotecnico[i];
                  Qry_AccCta_Suscritas.Parambyname('Fecha').AsDate         := dFecha_Cierre;

                  if bdesarrollo then
                     Qry_AccCta_Suscritas.Open
                  else
                      try
                        Qry_AccCta_Suscritas.Open;
                      except
                        on E: EFDDBEngineException do
                          begin
                            ShowError(E);
                          end;
                      end;

                  if Not Qry_AccCta_Suscritas.FieldByName('Nemotecnico').IsNull then
                  begin
                    if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'ACCIONES') or
                       (Qry_Limites.FieldByName('CODIGO_PORCENTAJE'    ).asString = 'ACCIONES') then
                      fACC_SUSCRITAS := Qry_AccCta_Suscritas.FieldByName('MONTO_SUSCRITO').asFloat
                    else
                      fCUOTAS_SUSCRITAS := Qry_AccCta_Suscritas.FieldByName('MONTO_SUSCRITO').asFloat;
                  end;
                  Qry_AccCta_Suscritas.Close;

                  if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'ACCIONES') or
                     (Qry_Limites.FieldByName('CODIGO_PORCENTAJE'    ).asString = 'ACCIONES') then
                  begin
                    Busca_Equivalencia( 'SUPER',
                                        'INSTRUM',
                                        Reg_Emisores_Nem.Instrumento[i],
                                        dFecha_Cierre,
                                        sInstrumento_Equiv);

                    if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'ACCIONES') then
                      fTotal_Porcentaje := fACC_SUSCRITAS
                    else
                      fTotal_Porcentaje_Min := fACC_SUSCRITAS; // ggarcia 11-12-2013

                    // Ticket #961
                    Reg_Emisores_Nem.Valor_Cartera[i] := Nominales_Nemotecnico(Qry_Limites.FieldByName('Codigo_Limite').asString,
                                                                               Reg_Emisores_Nem.Emisor[i],
                                                                               sInstrumento_Equiv,
                                                                               Reg_Emisores_Nem.Nemotecnico[i]);

                    bExisten_Valores_Instrum := Existen_Valores_Instrum(  'ACCIONES',
                                                                          Qry_Limites.FieldByName('Codigo_Limite').asString,
                                                                          Reg_Emisores_Nem.Emisor[i]);
                    if (fACC_SUSCRITAS = 0) and
                       (bExisten_Valores_Instrum) then
                      Inserta_Errores( ' Datos Emisor ',
                                       ' No Existen Valores de Acciones Suscritas Emisor: '
                                         + Reg_Emisores_Nem.Emisor[i]);
                  end;

                  if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'CUOTAS') OR
                     (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'CUOTAS') then
                  begin

                    Busca_Equivalencia('SUPER',
                                       'INSTRUM',
                                       Reg_Emisores_Nem.Instrumento[i],
                                       dFecha_Cierre,
                                       sInstrumento_Equiv);

                    fValor_Nominal := Nominales_Nemotecnico(Qry_Limites.FieldByName( 'Codigo_Limite').asString
                                                            ,Reg_Emisores_Nem.Emisor[i]
                                                            ,sInstrumento_Equiv // Equivalencia
                                                            ,Reg_Emisores_Nem.Nemotecnico[i]);

                    Reg_Emisores_Nem.Valor_Cartera[i] := Nominales_Nemotecnico( Qry_Limites.FieldByName('Codigo_Limite').asString
                                                                               ,Reg_Emisores_Nem.Emisor[i]
                                                                               ,sInstrumento_Equiv // Equivalencia
                                                                               ,Reg_Emisores_Nem.Nemotecnico[i]);

                    bExisten_Valores_Instrum := Existen_Valores_Instrum('CUOTAS',
                                                                        Qry_Limites.FieldByName('Codigo_Limite').asString,
                                                                        Reg_Emisores_Nem.Emisor[i]);

                    if (fCUOTAS_SUSCRITAS = 0) and (bExisten_Valores_Instrum) then
                      Inserta_Errores('Datos Emisor ',
                                      'No Existen Valores de Cuotas Suscritas ' + ' Emisor: ' + Reg_Emisores_Nem.Emisor[i]);

                    if fValor_Nominal <> 0 then
                    begin
                      fValor_Cuota := Reg_Emisores_Nem.Valor_Cartera[i] / fValor_Nominal;

                      if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'CUOTAS') then
                      begin
                        fTotal_Porcentaje  := fCUOTAS_SUSCRITAS;
                        fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje').asFloat;
                      end
                      else
                      begin
                        fTotal_Porcentaje_Min := fCUOTAS_SUSCRITAS;
                        fPorcentaje_Limite    := Qry_Limites.FieldByName('Porcentaje_Min').asFloat;
                      end;
                    end
                    else
                      if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'CUOTAS') then
                      begin
                        fTotal_Porcentaje  := 0;
                        fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje').asFloat;
                      end
                      else
                      begin
                        fTotal_Porcentaje_Min := 0;
                        fPorcentaje_Limite    := Qry_Limites.FieldByName('Porcentaje_Min').asFloat;
                      end;
                  end;

                  fValor_Pte_Limite := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                           dFecha_Cierre,
                                                           (fTotal_Porcentaje * fPorcentaje_Limite / 100));

                  fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                               dFecha_Cierre,
                                                               (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100));

                  if (Reg_Emisores_Nem.Valor_Cartera[i] <> 0) and (fValor_Pte_Limite <> 0) then
                  begin
                    T_TmpLimites.insert;
                    T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
                    T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
                    T_TmpLimites.FieldByName('Emisor').asString           := Reg_Emisores_Nem.Emisor[i];
                    T_TmpLimites.FieldByName('Nemotecnico').asString      := Reg_Emisores_Nem.Nemotecnico[i];
                    T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
                    T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
                    T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := Reg_Emisores_Nem.Valor_Cartera[i];
                    T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
                    T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;

                    if fValor_Pte_Limite <> 0 then
                      T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite - Reg_Emisores_Nem.Valor_Cartera[i];
                    T_TmpLimites.Post;
                  end
                  else
                  begin
                    // Borro Valores del Detalle Que No de Sirven
                    Qry_Prdx.Close;
                    Qry_Prdx.Sql.Clear;
                    Qry_Prdx.Sql.Add(' DELETE FROM ' + T_TmpDatosLimite.Name
                                    + ' WHERE Emisor        = :Emisor'
                                    + '   AND Codigo_Limite = :Codigo_Limite'
                                    + '   AND Nemotecnico   = :Nemotecnico');

                    Qry_Prdx.Parambyname('Emisor').asString        := Reg_Emisores_Nem.Emisor[i];
                    Qry_Prdx.Parambyname('Nemotecnico').asString   := Reg_Emisores_Nem.Nemotecnico[i];
                    Qry_Prdx.Parambyname('Codigo_Limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
                    try
                      Qry_Prdx.ExecSql;
                    except
                      on E: EFDDBEngineException do
                        begin
                          ShowError(E);
                        end;
                    end;
                    Qry_Prdx.Close;
                  end;
                end
                else
                  if (Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIINSTRUM') or
                     (Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIFILIAL') then
                  begin
                    fPorcentaje_Ant := 0;
                    for i := 0 to VarArrayHighBound(Reg_Emisores.Emisor, 1) do
                    begin
                      sEmisor := Reg_Emisores.Emisor[i];
                      fLH_DE_CREDITO    := 0;
                      fDEP_Y_CAP        := 0;
                      fACC_SUSCRITAS    := 0;
                      fCUOTAS_SUSCRITAS := 0;
                      fPatrimonio       := 0;
                      // DC 03/02/2016
                      if (fPorcentaje_Ant > 0) and (fPorcentaje_Ant <> fPorcentaje_Limite) then
                        fPorcentaje_Limite := fPorcentaje_Ant;
                      // DC 03/02/2016
                      // Rescato valores del Estado del Emisor
                      Qry_EstadoEMI.Close;
                      Qry_EstadoEMI.Parambyname('Emisor').asString := Reg_Emisores.Emisor[i];
                      Qry_EstadoEMI.Parambyname('Fecha').AsDate    := dFecha_Cierre;

                      if bdesarrollo then
                         Qry_EstadoEMI.Open
                      else
                        try
                          Qry_EstadoEMI.Open;
                        except
                          on E: EFDDBEngineException do
                            begin
                              ShowError(E);
                            end;
                        end;
                      if Not Qry_EstadoEMI.FieldByName('Emisor').IsNull then
                      begin
                        fLH_DE_CREDITO    := Qry_EstadoEMI.FieldByName('LH_DE_CREDITO').asFloat;
                        fDEP_Y_CAP        := Qry_EstadoEMI.FieldByName('DEP_Y_CAP').asFloat;
                        fACC_SUSCRITAS    := Qry_EstadoEMI.FieldByName('ACC_SUSCRITAS').asFloat;
                        fCUOTAS_SUSCRITAS := Qry_EstadoEMI.FieldByName('CUOTAS_SUSCRITAS').asFloat;
                        fPatrimonio       := Qry_EstadoEMI.FieldByName('PATRIMONIO').asFloat;
                      end;
                      Qry_EstadoEMI.Close;

                      if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'DEPOSITOS') or
                         (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'DEPOSITOS') then
                      begin
                        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'DEPOSITOS') THEN
                          fTotal_Porcentaje := fDEP_Y_CAP * 1000
                        else
                          fTotal_Porcentaje_Min := fDEP_Y_CAP * 1000;

                        bExisten_Valores_Instrum := Existen_Valores_Instrum('DEPOSITOS',
                                                                            Qry_Limites.FieldByName('Codigo_Limite').asString,
                                                                            Reg_Emisores.Emisor[i]);
                        if (fDEP_Y_CAP = 0) and (bExisten_Valores_Instrum) then
                          Inserta_Errores(' Datos Emisor ',
                                          ' No Existen Valores de Dep.y Captaciones Emisor: ' + Reg_Emisores.Emisor[i]);
                      end;

                      if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'LETRAS') or
                         (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'LETRAS') then
                      begin
                        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'LETRAS') then
                          fTotal_Porcentaje := fLH_DE_CREDITO * 1000
                        else
                          fTotal_Porcentaje_Min := fLH_DE_CREDITO * 1000;

                        bExisten_Valores_Instrum := Existen_Valores_Instrum('LETRAS',
                                                                            Qry_Limites.FieldByName('Codigo_Limite').asString,
                                                                            Reg_Emisores.Emisor[i]);

                        if (fLH_DE_CREDITO = 0) and (bExisten_Valores_Instrum) then
                          Inserta_Errores('Datos Emisor ',
                                          'No Existen Valores de L.H. emitidas Emisor: ' + Reg_Emisores.Emisor[i]);
                      end;

                      if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'PATEMI') or
                         (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'PATEMI') then
                      begin
                        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'PATEMI') then
                          fTotal_Porcentaje := fPatrimonio * 1000
                        else
                          fTotal_Porcentaje_Min := fPatrimonio * 1000;

                        bExisten_Valores_Instrum := Existen_Valores_Instrum('*',
                                                                            Qry_Limites.FieldByName('Codigo_Limite').asString,
                                                                            Reg_Emisores.Emisor[i]);

                        if (fPatrimonio = 0) and (bExisten_Valores_Instrum) then
                          Inserta_Errores('Datos Emisor ',
                                          ' No Existen Valores de Patrimonio Emisor: ' + Reg_Emisores.Emisor[i]);
                      end;

                      fPorcentaje_Ant := fPorcentaje_Limite; // DC 03/02/2016
                      if ((Qry_Limites.FieldByName('Relacion_Cia').asString = 'GRUPO') and
                          (sGrupo_Emisor_Cartera <> '') and
                          (sGrupo_Emisor_Cartera = Reg_Emisores.Grupo_Emisor[i])) then
                        fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje_Cia').asFloat;


                       // Aplica Porcentaje !!!
                      fValor_Pte_Limite := Redondeo_Moneda_Mem( sMoneda_Cartera,
                                                                dFecha_Cierre,
                                                                (fTotal_Porcentaje *
                                                                 fPorcentaje_Limite / 100));

                      fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                                  dFecha_Cierre,
                                                                  (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100));

                      // Casos Lista Valores (Porcentaje ya viene aplicado
                      if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MIN_LISTA') or
                         (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MAX_LISTA') then
                          fValor_Pte_Limite := Redondeo_Moneda_Mem( sMoneda_Cartera,
                                                                    dFecha_Cierre,
                                                                    fTotal_Porcentaje);

                      if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'MIN_LISTA') or
                         (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'MAX_LISTA') then
                          fValor_Pte_Limite := Redondeo_Moneda_Mem( sMoneda_Cartera,
                                                                    dFecha_Cierre,
                                                                    fTotal_Porcentaje);

                      if (Reg_Emisores.Valor_Cartera[i] <> 0) and (fTotal_Porcentaje <> 0)then // (fValor_Pte_Limite <> 0) then
                      begin
                        T_TmpLimites.insert;
                        T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
                        T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
                        T_TmpLimites.FieldByName('Emisor').asString           := Reg_Emisores.Emisor[i];
                        T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
                        T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
                        T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := Reg_Emisores.Valor_Cartera[i];
                        T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
                        T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;
                        if fValor_Pte_Limite <> 0 then
                          T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite - Reg_Emisores.Valor_Cartera[i];
                        T_TmpLimites.Post;
                      end
                      else
                      begin
                        // Borro Valores del Detalle Que No de Sirven
                        Qry_Prdx.Close;
                        Qry_Prdx.Sql.Clear;
                        Qry_Prdx.Sql.Add(' DELETE FROM ' + T_TmpDatosLimite.Name
                                        + ' WHERE Emisor        = :Emisor'
                                        + '   AND Codigo_Limite = :Codigo_Limite');

                        Qry_Prdx.Parambyname('Emisor').asString        := Reg_Emisores.Emisor[i];
                        Qry_Prdx.Parambyname('Codigo_Limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
                        try
                          Qry_Prdx.ExecSql;
                        except
                          on E: EFDDBEngineException do
                            begin
                              ShowError(E);
                            end;
                        end;
                        Qry_Prdx.Close;
                      end;
                    end;
                  end
                  else
                    if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'EMISION') or
                       (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'EMISION') then
                      Calculo_Emisiones
                    else
                      begin
                        if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'EMISION-VC') or
                           (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'EMISION-VC') then
                          Calculo_Emisiones_VC
                        else
                          begin
                            if Qry_Limites.FieldByName('Suma_Inversion').asString = 'SUMNEMOTEC' then
                              begin
                                for i := 0 to VarArrayHighBound(Reg_Emisor_Nemo.Emisor, 1) do
                                  begin
                                    if (Reg_Emisor_Nemo.Valor_Cartera[i] <> 0) and (fValor_Pte_Limite <> 0) then
                                    begin
                                      T_TmpLimites.insert;
                                      T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
                                      T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
                                      T_TmpLimites.FieldByName('Emisor').asString           := Reg_Emisor_Nemo.Emisor[i];
                                      T_TmpLimites.FieldByName('Nemotecnico').asString      := Reg_Emisor_Nemo.Nemotecnico[i];
                                      T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
                                      T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
                                      T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := Reg_Emisor_Nemo.Valor_Cartera[i];
                                      T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
                                      T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;
                                      if fValor_Pte_Limite <> 0 then
                                         T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite - Reg_Emisor_Nemo.Valor_Cartera[i];
                                      T_TmpLimites.Post;
                                    end;
                                  end
                              end // Distribuyo por Nemotecnico
                            else
                              begin
                                if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE_MIN').asString = 'PASIVOS') or
                                   (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'PASIVOS') then
                                  begin
                                    for i := 0 to VarArrayHighBound(Reg_Monedas.Moneda, 1) do
                                      begin
                                        Qry_Pasivos.Parambyname('Empresa').asString := sEmpresa_Usuario;
                                        Qry_Pasivos.Parambyname('Codigo').asString  := 'PASIVOS';
                                        Qry_Pasivos.Parambyname('Moneda').asString  := Reg_Monedas.Moneda[i];

                                        if bdesarrollo then
                                           Qry_Pasivos.Open
                                        else
                                          try
                                            Qry_Pasivos.Open;
                                          except
                                            on E: EFDDBEngineException do
                                              begin
                                                ShowError(E);
                                              end;
                                          end;
                                        fTotal_Porcentaje := 0;
                                        if Not Qry_Pasivos.FieldByName('Moneda').IsNull then
                                          if (Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'PASIVOS') then
                                            fTotal_Porcentaje := Qry_Pasivos.FieldByName('Valor').asFloat
                                          else
                                            fTotal_Porcentaje_Min := Qry_Pasivos.FieldByName('Valor').asFloat;
                                        Qry_Pasivos.Close;

                                        fValor_Pte_Limite := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                                                  dFecha_Cierre,
                                                                                  (fTotal_Porcentaje * fPorcentaje_Limite / 100));

                                        fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                                                     dFecha_Cierre,
                                                                                     (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100));

                                        if (Reg_Monedas.Valor_Cartera[i] <> 0) and (fTotal_Porcentaje <> 0) then
                                          // (fValor_Pte_Limite <> 0) then
                                        begin
                                          T_TmpLimites.insert;
                                          T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
                                          T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
                                          T_TmpLimites.FieldByName('Moneda_Instrum').asString   := Reg_Monedas.Moneda[i];
                                          T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
                                          T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
                                          T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := Reg_Monedas.Valor_Cartera[i];
                                          T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
                                          T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;
                                          if fValor_Pte_Limite <> 0 then
                                            T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite - Reg_Monedas.Valor_Cartera[i];
                                          T_TmpLimites.Post;
                                        end;
                                      end;
                                  end // FIN GGARCIA 03-2010
                                else
                                  begin
                                    // Verifico si Cartera Implica Bienes Raíces
                                    if Implica_BienesRaices(Qry_Limites.FieldByName('Codigo_Limite').asString) then
                                      fValor_Pte_MC_Cpa := fValor_Pte_MC_Cpa + fBienesRaices_NoLeasing;

                                    if (fValor_Pte_MC_Cpa <> 0) then
                                      // ggarcia 04-11-2013 (fValor_Pte_Limite <> 0) then
                                    begin
                                      T_TmpLimites.insert;
                                      T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
                                      T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
                                      T_TmpLimites.FieldByName('Series_Inscritas').asString := sInstrumentos;
                                      T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
                                      T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
                                      T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := fValor_Pte_MC_Cpa;
                                      T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
                                      T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;
                                      if fValor_Pte_Limite <> 0 then
                                        T_TmpLimites.FieldByName('Margen').asFloat := fValor_Pte_Limite - fValor_Pte_MC_Cpa;
                                      T_TmpLimites.Post;
                                    end;
                                  end;
                              end;
                          end;
                      end;
            end;
      // Si es definido por fial junto todos dependiendo de la matriz
        if Qry_Limites.FieldByName('Suma_Inversion').asString = 'EMIFILIAL' then
          Calculo_Filiales(fTotal_Porcentaje,
                           fTotal_Porcentaje_Min);

    end; // if bExisten_Valores_Limites then
    Qry_Limites_Det.Close;
    Qry_Limites.Next;
  end; // Fin qry_limites

  Qry_Limites.Close;
  ProgressBar1.Position    := 0;
  Lbl_Avance1.Caption      := '';
  LabelPorcentaje1.Caption := '';
  ProgressBar2.Position    := 0;
  Lbl_Avance2.Caption      := '';
  LabelPorcentaje2.Caption := '';

  bexiste_limite_final := True;
  if (sTipo_Limite = 'T') and (Not bExisten_Valores_Limites) then
    if FrmReportErrores.T_Paradox.RecordCount > 0 then
      bexiste_limite_final := False;

  With Qry_General do
    begin
      Close;
      Sql.Clear;
      Sql.Add(' DELETE FROM QS_TEMP_LIMITE '
            + '  WHERE PID = :PID');
      Parambyname('PID').asFloat := Application.Handle;

      try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Close;
            Exit;
          end;
      end;

      Sql.Clear;
      Sql.Add(' DELETE FROM QS_TEMP_LIMITE '
            + '  WHERE FECHA_CREACION < :FECHA_CREACION');

      Parambyname('FECHA_CREACION').AsDateTime := Fecha_Hora_Servidor - 1;

      try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Close;
            Exit;
          end;
      end;
      Sql.Clear;
      Sql.Add(' DELETE FROM QS_TEMP_LIM_DERIV '
            + '  WHERE PID = :PID');
      Parambyname('PID').asFloat := Application.Handle;

      try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Close;
            Exit;
          end;
      end;

      Sql.Clear;
      Sql.Add(' DELETE FROM QS_TEMP_LIM_DERIV '
            + '  WHERE FECHA_CREACION < :FECHA_CREACION');

      Parambyname('FECHA_CREACION').AsDateTime := Fecha_Hora_Servidor - 1;

      try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Close;
            Exit;
          end;
      end;

    end;

  if sTipo_Limite = '' then
    begin
      if bAbortar then
        begin
            carga_estado(0);
          Application.MessageBox( 'Proceso Abortado Por Usuario',
                                  Pchar(Caption),
                                  Mb_Ok + MB_ICONINFORMATION);
        end
      else
        begin
          carga_estado(1);
          BTN_ConfirmarClick(Sender);
        end;
    end;

  // Libero datos Cargados
  VarClear(Reg_Errores_Grupo.Emisor);
  VarClear(Reg_Errores_Grupo.Error);
  Habilita_Campos;

end;

procedure TFrmCalculoLimites.llenar_T_TmpDatos(var bResultado: Boolean);
var
  fProgreso, fMaximo: Integer;
  sString_Instrumento :string;
begin

  bResultado := True;
  // QS_SUP_251_RTPR
  Qry_RTPR.Close;
  Qry_RTPR.Sql.Clear;
  Qry_RTPR.Sql.Add('SELECT a.Codigo_RTPR '
                 + '      ,a.descripcion '
                 + '      ,a.clasif_251  '
                 + '      ,a.nodo        '
                 + '      ,a.nacion      '
                 + '      ,a.fecha_desde '
                 + '      ,a.Tipo_Grupo  '
                 + '  FROM QS_SUP_251_RTPR a   '
                 + '      ,qs_sup_251_lim b    '
                 + '      ,qs_sup_251_lim_det c '
                 + ' WHERE b.proceso     = :proceso  '
                 + '   AND b.Fecha_Desde <= :Fecha   '
                 + '   AND (b.Fecha_Hasta IS NULL OR b.Fecha_Hasta >= :Fecha)'
                 + '   AND c.proceso = b.proceso                             '
                 + '   AND c.codigo_limite = b.codigo_limite                 '
                 + '   AND c.fecha_desde = b.fecha_desde                     '
                 + '   AND a.codigo_rtpr = c.codigo_rtpr                     '
                 + '   AND a.Fecha_Desde <= :Fecha                           '
                 + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)');

  if ((sTipo_Limite = 'T') or
     (sTipo_Limite = 'Filtrado')) and (Trim(sString_RTPR) <> '') then
    Qry_RTPR.Sql.Add(' AND a.CODIGO_RTPR in ' + sString_RTPR);

  Qry_RTPR.Sql.Add(' group by a.Codigo_RTPR '
                         + ' ,a.descripcion '
                         + ' ,a.clasif_251  '
                         + ' ,a.nodo        '
                         + ' ,a.nacion      '
                         + ' ,a.fecha_desde '
                         + ' ,a.Tipo_Grupo  '
                         + ' ORDER BY a.Codigo_RTPR ');

  Qry_RTPR.Parambyname('Fecha').AsDate     := dFecha_Cierre;
  Qry_RTPR.Parambyname('Proceso').asString := Ed_Proceso.Text;;

  if bDesarrollo then
     Qry_RTPR.Open
  else
    try
      Qry_RTPR.Open;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          bResultado := False;
          Qry_RTPR.Close;
          Exit;
        end;
    end;

  Qry_RTPR.Last;
  // ProgressBar1.Max := Qry_RTPR.RecordCount;
  // ProgressBar1.Position := 0;
  fProgreso := 0;
  fMaximo   := Qry_RTPR.RecordCount;

  Qry_RTPR.First;

  While (Not Qry_RTPR.eof) and (Not bAbortar) do
  begin

    Lbl_Avance1.Caption := 'Obteniendo Grupo: '
                          +Qry_RTPR.FieldByName('Codigo_RtPr').asString;

    // Esto se hizo ya que la barra tambien la actualiza en otra funcion que llama este while
    ProgressBar1.Max      := fMaximo;
    fProgreso             := fProgreso + 1;
    ProgressBar1.Position := fProgreso;

    LabelPorcentaje1.Caption := FloatToStr(ProgressBar1.Position) + ' de ' + FloatToStr(ProgressBar1.Max) + ' (' + FormatFloat('##0', ProgressBar1.Position / ProgressBar1.Max * 100) + '%)';

    Application.ProcessMessages;

//      if bDesarrollo then
//      begin
//      if (Qry_RTPR.Fieldbyname('Codigo_RtPr').asString  <> '1E-TD-A') then
//      //if (Qry_RTPR_Det.Fieldbyname('Codigo_RtPr').asString  <> '3D') and (Qry_RTPR_Det.Fieldbyname('Codigo_RtPr').asString  <> '3E') then
//      begin
//      Qry_RTPR.Next;
//      Continue;
//      end;
//      end;

    Qry_RTPR_DetAgr.Close;
    Qry_RTPR_DetAgr.Sql.Clear;
    Qry_RTPR_DetAgr.Sql.Add('SELECT DISTINCT Codigo_RtPr '
                           +'      ,Origen_Posicion '
                           +'      ,CLASIFICADORA_EMISOR'
                           +'      ,CLASIF_RIESGO_EMISOR'
                           +'      ,OPERAC_CLASIF_EMISOR'
                           +'      ,CLASIF_RIESGO '
                           +'      ,OPERACION'
                           +'   FROM QS_SUP_251_RTPR_DET '
                           + ' WHERE Codigo_RTPR = :Codigo_RTPR '
                           + '   AND Fecha_desde = :fecha_desde ');

    Qry_RTPR_DetAgr.Parambyname('Codigo_RtPr').asString := Qry_RTPR.FieldByName('Codigo_RtPr').asString;
    Qry_RTPR_DetAgr.Parambyname('Fecha_desde').AsDate   := solo_fecha(Qry_RTPR.FieldByName('Fecha_desde').AsDateTime);

    if bDesarrollo then
       Qry_RTPR_DetAgr.Open
    else
      try
        Qry_RTPR_DetAgr.Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            bResultado := False;
            Qry_RTPR_DetAgr.Close;
            Exit;
          end;
      end;

    while not Qry_RTPR_DetAgr.eof do
    begin
      // QS_SUP_251_RTPR_DET
      Qry_RTPR_Det.Close;
      Qry_RTPR_Det.Sql.Clear;
      Qry_RTPR_Det.Sql.Add('SELECT * FROM QS_SUP_251_RTPR_DET '
                         + ' WHERE Codigo_RTPR = :Codigo_RTPR '
                         + '   AND Fecha_desde = :fecha_desde ');

      if (Qry_RTPR_DetAgr.FieldByName('Origen_Posicion').IsNull) then
      begin
        Qry_RTPR_Det.Sql.Add('    AND (Origen_Posicion is null or Origen_Posicion = '''') ');
      end
      else
      begin
        Qry_RTPR_Det.Sql.Add('    AND Origen_Posicion = :Origen_Posicion ');
        Qry_RTPR_Det.Parambyname('Origen_Posicion').asString := Qry_RTPR_DetAgr.FieldByName('Origen_Posicion').asString;
      end;

      if (Qry_RTPR_DetAgr.FieldByName('CLASIFICADORA_EMISOR').IsNull) then
      begin
        Qry_RTPR_Det.Sql.Add('    AND (CLASIFICADORA_EMISOR IS NULL OR CLASIFICADORA_EMISOR = '''') ');
      end
      else
      begin
        Qry_RTPR_Det.Sql.Add('    AND CLASIFICADORA_EMISOR = :CLASIFICADORA_EMISOR ');
        Qry_RTPR_Det.Parambyname('CLASIFICADORA_EMISOR').asString := Qry_RTPR_DetAgr.FieldByName('CLASIFICADORA_EMISOR').asString;
      end;

      if (Qry_RTPR_DetAgr.FieldByName('CLASIF_RIESGO_EMISOR').IsNull) then
      begin
        Qry_RTPR_Det.Sql.Add('    AND (CLASIF_RIESGO_EMISOR is null OR CLASIF_RIESGO_EMISOR = '''') ');
      end
      else
      begin
        Qry_RTPR_Det.Sql.Add('    AND CLASIF_RIESGO_EMISOR = :CLASIF_RIESGO_EMISOR ');
        Qry_RTPR_Det.Parambyname('CLASIF_RIESGO_EMISOR').asString := Qry_RTPR_DetAgr.FieldByName('CLASIF_RIESGO_EMISOR').asString;
      end;

      if (Qry_RTPR_DetAgr.FieldByName('OPERAC_CLASIF_EMISOR').IsNull) then
      begin
        Qry_RTPR_Det.Sql.Add('    AND (OPERAC_CLASIF_EMISOR is null OR OPERAC_CLASIF_EMISOR = '''') ');
      end
      else
      begin
        Qry_RTPR_Det.Sql.Add('    AND OPERAC_CLASIF_EMISOR = :OPERAC_CLASIF_EMISOR ');
        Qry_RTPR_Det.Parambyname('OPERAC_CLASIF_EMISOR').asString := Qry_RTPR_DetAgr.FieldByName('OPERAC_CLASIF_EMISOR').asString;
      end;

      if (Qry_RTPR_DetAgr.FieldByName('CLASIF_RIESGO').IsNull) then
      begin
        Qry_RTPR_Det.Sql.Add('    AND (CLASIF_RIESGO is null OR CLASIF_RIESGO = '''') ');
      end
      else
      begin
        Qry_RTPR_Det.Sql.Add('    AND CLASIF_RIESGO = :CLASIF_RIESGO ');
        Qry_RTPR_Det.Parambyname('CLASIF_RIESGO').asString := Qry_RTPR_DetAgr.FieldByName('CLASIF_RIESGO').asString;
      end;

      if (Qry_RTPR_DetAgr.FieldByName('OPERACION').IsNull) then
      begin
        Qry_RTPR_Det.Sql.Add('    AND (OPERACION is null OR OPERACION = '''') ');
      end
      else
      begin
        Qry_RTPR_Det.Sql.Add('    AND OPERACION            = :OPERACION ');
        Qry_RTPR_Det.Parambyname('OPERACION').asString := Qry_RTPR_DetAgr.FieldByName('OPERACION').asString;
      end;

      Qry_RTPR_Det.Parambyname('Codigo_RtPr').asString := Qry_RTPR.FieldByName('Codigo_RtPr').asString;
      Qry_RTPR_Det.Parambyname('Fecha_desde').AsDate   := solo_fecha(Qry_RTPR.FieldByName('Fecha_desde').AsDateTime);

      if bDesarrollo then
         Qry_RTPR_Det.Open
      else
        try
          Qry_RTPR_Det.Open;
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E);
              bResultado := False;
              Qry_RTPR.Close;
              Exit;
            end;
        end;

      sString_Instrumento := '('' ''';
      while not Qry_RTPR_Det.eof do
      begin
        sString_Instrumento := sString_Instrumento +','''+Qry_RTPR_Det.Fieldbyname('Instrumento').asString+'''';
        Qry_RTPR_Det.Next;
      end;
      sString_Instrumento := sString_Instrumento+')';

      Qry_RTPR_Det.First;
      bImplica_Emision   := False;
      bImplica_Emigrupo  := False;
      bImplica_EmiClasif := False;

      if Not Qry_RTPR_Det.FieldByName('Codigo_RtPr').IsNull then
      begin
        With Qry_Aux do
        begin
          Close;
          Sql.Clear;
          Sql.Add('SELECT a.moneda FROM QS_SUP_251_LIM a'
                + '                    ,QS_SUP_251_LIM_DET b'
                + ' WHERE a.Proceso           = :Proceso'
                + '   AND a.Fecha_Desde      <= :Fecha'
                + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
                + '   AND a.Proceso           = b.Proceso'
                + '   AND a.Codigo_Limite     = b.Codigo_Limite'
                + '   AND a.Fecha_Desde       = b.Fecha_Desde'
                + '   AND b.Codigo_RTPR       = :Codigo_RTPR');

          Parambyname('Codigo_RTPR').asString := Qry_RTPR_Det.FieldByName('Codigo_RtPr').asString;
          Parambyname('Proceso').asString     := Ed_Proceso.Text;
          Parambyname('Fecha').AsDate         := dFecha_Cierre;

          try
            Open;
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                bResultado := False;
                Qry_Aux.Close;
                Qry_RTPR.Close;
                Exit;
              end;
          end;
          if (Trim(sMoneda_Nacional) = '') and (Not FieldByName('moneda').IsNull) then
            sMoneda_Nacional := FieldByName('moneda').asString;

          Close;
          Sql.Clear;
          Sql.Add('SELECT b.Codigo_RTPR FROM QS_SUP_251_LIM a'
                + '                         ,QS_SUP_251_LIM_DET b'
                + ' WHERE a.Proceso           = :Proceso'
                + '   AND a.Fecha_Desde      <= :Fecha'
                + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
                + '   AND a.Codigo_Porcentaje = ''EMISION'''
                + '   AND a.Proceso           = b.Proceso'
                + '   AND a.Codigo_Limite     = b.Codigo_Limite'
                + '   AND a.Fecha_Desde       = b.Fecha_Desde'
                + '   AND b.Codigo_RTPR       = :Codigo_RTPR');

          Parambyname('Codigo_RTPR').asString := Qry_RTPR_Det.FieldByName('Codigo_RtPr').asString;
          Parambyname('Proceso').asString     := Ed_Proceso.Text;
          Parambyname('Fecha').AsDate         := dFecha_Cierre;

          try
            Open;
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                bResultado := False;
                Qry_Aux.Close;
                Qry_RTPR.Close;
                Exit;
              end;
          end;
          if Not FieldByName('Codigo_RTPR').IsNull then
            bImplica_Emision := True;

          Close;
          Sql.Clear;
          Sql.Add('SELECT b.Codigo_RTPR FROM QS_SUP_251_LIM a'
                + '                         ,QS_SUP_251_LIM_DET b'
                + ' WHERE a.Proceso           = :Proceso'
                + '   AND a.Fecha_Desde      <= :Fecha'
                + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
                + '   AND a.Suma_Inversion    = ''EMIGRUPO'''
                + '   AND a.Proceso           = b.Proceso'
                + '   AND a.Codigo_Limite     = b.Codigo_Limite'
                + '   AND a.Fecha_Desde       = b.Fecha_Desde'
                + '   AND b.Codigo_RTPR       = :Codigo_RTPR');

          Parambyname('Codigo_RTPR').asString := Qry_RTPR_Det.FieldByName('Codigo_RtPr').asString;
          Parambyname('Proceso').asString     := Ed_Proceso.Text;
          Parambyname('Fecha').AsDate         := dFecha_Cierre;

          try
            Open;
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                bResultado := False;
                Qry_Aux.Close;
                Qry_RTPR.Close;
                Exit;
              end;
          end;
          if Not FieldByName('Codigo_RTPR').IsNull then
            bImplica_Emigrupo := True;
          Close;

          /// / DC 02/08/2016
          Sql.Clear;
          Sql.Add('SELECT a.tipoclasif_emisor FROM QS_SUP_251_LIM a'
                + '                               ,QS_SUP_251_LIM_DET b'
                + ' WHERE a.Proceso           = :Proceso'
                + '   AND a.Fecha_Desde      <= :Fecha'
                + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
                + '   AND a.Suma_Inversion    = ''EMICLASIF'''
                + '   AND a.Proceso           = b.Proceso'
                + '   AND a.Codigo_Limite     = b.Codigo_Limite'
                + '   AND a.Fecha_Desde       = b.Fecha_Desde'
                + '   AND b.Codigo_RTPR       = :Codigo_RTPR');

          Parambyname('Codigo_RTPR').asString := Qry_RTPR_Det.FieldByName('Codigo_RtPr').asString;
          Parambyname('Proceso').asString     := Ed_Proceso.Text;
          Parambyname('Fecha').AsDate         := dFecha_Cierre;

          try
            Open;
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                bResultado := False;
                Qry_Aux.Close;
                Qry_RTPR.Close;
                Exit;
              end;
          end;
          sTipoClasif_Emisor := '';
          if Not FieldByName('tipoclasif_emisor').IsNull then
            begin
              bImplica_EmiClasif := True;
              sTipoClasif_Emisor := FieldByName('tipoclasif_emisor').asString;
            end;
        end;
        Seleccion_RTPT(sString_Instrumento);
      end;
      Qry_RTPR_Det.Close;
      Qry_RTPR_DetAgr.Next;
    end;
    Qry_RTPR_DetAgr.Close;
    Qry_RTPR.Next;
  end;
  Qry_RTPR.Close;

  if sTipo_Limite = '' then
  begin
    Lbl_Avance1.Caption := ' ';
    Application.ProcessMessages;
  end;

end;

procedure TFrmCalculoLimites.Prepara_DatoCalculo(sString_LimPor: String;
                                                 var Resultado : Boolean);
var
  sCartera,
  sString_Instrum,
  sDescripcion,
  sProrrateo_Valores,
  sCod_rtpr,
  sIdentidadCli  : String;
  bPn,
  bPl,
  bRtpr          : Boolean;
  x, i,
  fRecordCount   : Integer;
  fNodo_Clasif   : Double;
  /// ///
begin

    Resultado := True;
    // Rescato Valores de la Cartera a Fecha de Cierre
    sIdentidadCli   := '';
    sMoneda_Cartera := '';
    if Trim(sMoneda_Nacional) = '' then
      sMoneda_Nacional := moneda_nacional_pais_Usuario(sPais_Usuario);

    if Chk_Carteras.State = cbChecked then
    begin
      sCartera := Determina_Cartera_Pid(sEmpresa_Usuario,
                                         Application.Handle);
      Leer_Cartera(sEmpresa,
                   sCartera,
                   sDescripcion,
                   sIdentidadCli,
                   sMoneda_Cartera,
                   sProrrateo_Valores,
                   Result);
    end;

    // ggarcia 18-10-2013
    sString_Carteras := '';
    sString_Empresas := '';
    sString_Carteras := String_Carteras(Application.Handle);
    sString_Empresas := String_Empresas(Application.Handle);

    if sString_Carteras = '('' '')' then
    begin
      Application.MessageBox(' No Existen Carteras Definida Bajo este Grupo ',
                              Pchar(Caption),
                              Mb_Ok + MB_IconError);
      Habilita_Campos;
      Resultado := False;
      Close;
      Exit;
    end;

    With Qry_General do
    begin
      bRtpr := True;
      Close;
      Sql.Clear;
      Sql.Add('select a.* '
            + '  from qs_sup_251_lim a '
            + ' where (a.codigo_porcentaje in (''RT'',''PR'',''RT+PR'')) or '
            + '       (a.codigo_porcentaje_min in (''RT'',''PR'',''RT+PR'')) ');

      Open;
      If eof
      then
        bRtpr := False;

      bPn := True;
      Close;
      Sql.Clear;
      Sql.Add('select a.* ' + '  from qs_sup_251_lim a '
            + ' where (a.codigo_porcentaje in (''PN'')) or '
            + '       (a.codigo_porcentaje_min in (''PN'')) ');
      Open;
      If eof then
        bPn := False;

      bPl := True;
      Close;
      Sql.Clear;
      Sql.Add('select a.* '
            + '  from qs_sup_251_lim a '
            + ' where (a.codigo_porcentaje in (''PL'')) or '
            + '       (a.codigo_porcentaje_min in (''PL'')) ');
      Open;
      If eof then
        bPl := False;

      // Rescato Reserva Tecnica y Patrimonio de Riesgo
      Close;
      Sql.Clear;
      Sql.Add(' SELECT a.Codigo_Identidad'
            + '       ,a.BRAIZ_SIN_LEASING'
            + '       ,a.Grupo_Emisor'
            + '       ,a.Neto'
            + '       ,a.Pasivo_Financieros as Libre'
            + '       ,a.Riesgo'
            + '       ,a.Riesgo_en_Curso'
            + '       ,a.Matematica'
            + '       ,a.Siniestros'
            + '       ,a.Adicional'
          + ' FROM QS_FIN_BALANCE a'
          + ' WHERE a.Codigo_Identidad = :Empresa');
      Sql.Add('   AND a.codigo_cartera in ' + sString_Carteras);
      Sql.Add('   AND a.Fecha_Cierre = (SELECT MAX(x.Fecha_Cierre) FROM QS_FIN_BALANCE x'
            + ' WHERE x.Codigo_Identidad = :Empresa'
            + '   AND x.Fecha_Cierre    <= :Fecha_Cierre)');

      if Trim(sIdentidadCli) <> '' then
        Parambyname('Empresa').asString := sIdentidadCli
      else
        Parambyname('Empresa').asString := sEmpresa_Usuario;

      Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;

      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Resultado := False;
            Exit;
          end;
      end;

      if (FieldByName('Codigo_Identidad').IsNull) and (bRtpr) then
        begin
          if sTipo_Limite = '' then
            begin
              Application.MessageBox(Pchar('No Existen Valores de Balance Vigentes ' + ' para Empresa ' + sIdentidadCli + ' Cartera ' + Combo_Cartera.Text + ' con Fecha ' + datetimetostr(dFecha_Cierre)),
                                     Pchar(Caption),
                                     Mb_Ok + MB_IconError);

            end;
          Habilita_Campos;
          Resultado := False;
          Ed_Proceso.Setfocus;
          Close;
          Exit;
        end;
      fPatrimonio_Neto      := FieldByName('Neto').asFloat;
      fPatrimonio_Libre     := FieldByName('Libre').asFloat;
      fPatrimonio_Riesgo    := FieldByName('Riesgo').asFloat;
      fReserva_Tecnica      := FieldByName('Riesgo_en_Curso').asFloat + FieldByName('Matematica').asFloat + FieldByName('Siniestros').asFloat + FieldByName('Adicional').asFloat;
      sGrupo_Emisor_Cartera := FieldByName('Grupo_Emisor').asString;

      // si los Valores del balance tienen como grupo "'SIN CLASIF'"
      // lo dejo en blanco ya que a algunos emisores asignan este valor..
      // y por lo tanto afecta al limite
      if sGrupo_Emisor_Cartera = 'SIN CLASIF'
      then
        sGrupo_Emisor_Cartera := '';

      fBienesRaices_NoLeasing := 0;
      if Not FieldByName('BRAIZ_SIN_LEASING').IsNull then
        fBienesRaices_NoLeasing := FieldByName('BRAIZ_SIN_LEASING').asFloat;

      Close;

      if NOT bSBS then
        if (fPatrimonio_Riesgo = 0) and (bRtpr) then
          begin
            if sTipo_Limite = '' then
              Application.MessageBox(' No Existe Patrimonio de Riesgo Definido para Cartera ',
                                      Pchar(Caption),
                                      Mb_Ok + MB_IconError);
            Habilita_Campos;
            Resultado := False;
            Close;
            Exit;
          end;

      if (fPatrimonio_Neto = 0) and (bPn) then
        begin
          if sTipo_Limite = '' then
            Application.MessageBox(' No Existe Patrimonio Neto Definido para Cartera ',
                                    Pchar(Caption),
                                    Mb_Ok + MB_IconError);
          Habilita_Campos;
          Resultado := False;
          Close;
          Exit;
        end;

      if (fPatrimonio_Libre = 0) and (bPl) then
        begin
          if sTipo_Limite = '' then
            Application.MessageBox(' No Existe Patrimonio Libre Definido para Cartera ',
                                    Pchar(Caption),
                                    Mb_Ok + MB_IconError);
          Habilita_Campos;
          Resultado := False;
          Close;
          Exit;
        end;

      if (fReserva_Tecnica = 0) and (bRtpr) then
        begin
          if sTipo_Limite = '' then
            Application.MessageBox(' No Existe Reserva Técnica Definida para Cartera ',
                                    Pchar(Caption),
                                    Mb_Ok + MB_IconError);
          Habilita_Campos;
          Resultado := False;
          Close;
          Exit;
        end;

      /// limpio arreglos de limites detalle
      Close;
      Sql.Clear;
      Sql.Add('SELECT b.* '
            + '  FROM QS_SUP_251_LIM     a '
            + '      ,QS_SUP_251_LIM_DET b '
            + ' WHERE a.Proceso       = :Proceso '
            + '   AND a.Fecha_Desde  <= :Fecha '
            + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
            + '   AND a.Proceso       = b.Proceso '
            + '   AND a.Codigo_Limite = b.Codigo_Limite '
            + '   AND a.Fecha_Desde   = b.Fecha_Desde ');
      if (sString_LimPor <> 'X')
      then
        Sql.Add(' AND a.codigo_limite IN ' + sString_LimPor);
      if (sTipo_Limite = 'Filtrado')
      then
        Sql.Add(' AND a.codigo_limite IN ' + sString_Limite);

      Parambyname('Proceso').asString := Ed_Proceso.Text;
      Parambyname('Fecha').AsDate     := dFecha_Cierre;

      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Resultado := False;
            Exit;
          end;
      end;
      Last;
      fRecordCount := RecordCount;
      if fRecordCount > 0then
        fRecordCount := fRecordCount - 1;

      Reg_Grupos_Instrum.Grupo_Instrumento := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Grupos_Instrum.Valor_Pte_Compra  := VarArrayCreate([0, fRecordCount],varDouble);
      Reg_Grupos_Instrum.Valor_Pte_Mercado := VarArrayCreate([0, fRecordCount],varDouble);
      Reg_Grupos_Instrum.Valor_Pte_Mixto   := VarArrayCreate([0, fRecordCount],varDouble);

      /// limpio arreglos de limites detalle

      // GGARCIA 03-2010  para limites transacciones
      // Creo registro para almacenar Valores presentes por codigo de limite (de acuerdo a los instrumentos que contiene).

      Close;
      Sql.Clear;
      Sql.Add('select codigo_limite '
            + '      ,fecha_desde'
            + '      ,moneda '
            + '  from qs_sup_251_lim '
            + ' where proceso = :proceso'
            + '   AND Fecha_Desde <= :Fecha '
            + '   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)');
      /// DC 06/04/2017 se lo agregue asi me trae solo los limites del proceso
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND codigo_limite IN ' + sString_LimPor);
      if (sTipo_Limite = 'Filtrado') then
        Sql.Add(' AND codigo_limite IN ' + sString_Limite);

      Parambyname('Proceso').asString := Ed_Proceso.Text;
      Parambyname('Fecha').AsDate     := dFecha_Cierre;
      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Resultado := False;
            Exit;
          end;
      end;

      Last;
      fRecordCount := RecordCount;
      if fRecordCount > 0 then
        fRecordCount := fRecordCount - 1;

      Reg_Valor_Pte.Codigo_Limite     := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Valor_Pte.Valor_Pte_Compra  := VarArrayCreate([0, fRecordCount],varDouble);
      Reg_Valor_Pte.Valor_Pte_Mercado := VarArrayCreate([0, fRecordCount],varDouble);
      Reg_Valor_Pte.Valor_Pte_Mixto   := VarArrayCreate([0, fRecordCount],varDouble);

      i := 0;
      x := 0;
      First;

      While not eof do
        begin
          Reg_Valor_Pte.Codigo_Limite[i] := FieldByName('codigo_limite').asString;
          if (Trim(sMoneda_Nacional) = '') and (Not FieldByName('moneda').IsNull) then
            sMoneda_Nacional := FieldByName('moneda').asString;
          /// ////
          with Qry_Detalle do
            begin
              Close;
              Sql.Clear;
              Sql.Add(' select distinct a.CODIGO_RTPR '
                    + '   from qs_sup_251_lim_det a '
                    + '       ,qs_sup_251_rtpr b'
                    + '  where a.proceso       = :proceso'
                    + '    AND a.codigo_limite = :codigo_limite '
                    + '    AND a.Fecha_Desde   = :Fecha_Desde '
                    + '    AND a.codigo_rtpr   = b.codigo_rtpr '
                    + '    AND b.fecha_desde  <= :Fecha '
                    + '    AND (b.Fecha_Hasta IS NULL OR b.Fecha_Hasta >= :Fecha)');

              Parambyname('Proceso').asString       := Ed_Proceso.Text;
              Parambyname('codigo_limite').asString := Reg_Valor_Pte.Codigo_Limite[i];
              Parambyname('Fecha_Desde').AsDate     := solo_fecha(Qry_General.FieldByName('fecha_desde').AsDateTime);
              Parambyname('Fecha').AsDate           := dFecha_Cierre;

              try
                Open;
              except
                on E: EFDDBEngineException do
                  begin
                    ShowError(E);
                    Resultado := False;
                    Exit;
                  end;
              end;

              First;
              While not Qry_Detalle.eof do
                begin
                  Reg_Grupos_Instrum.Grupo_Instrumento[x] := Qry_Detalle.FieldByName('CODIGO_RTPR').asString;
                  Inc(x);
                  Qry_Detalle.Next;
                end;
              Close;
            end;
          /// ///
          Inc(i);
          Next;
        end;
      Close;
      // Fin GGARCIA 03-2010

      // Inicio  ES 05-2021
      Close;
      Sql.Clear;
      Sql.Add('select Codigo_Limite, Porcentaje, Codigo_Aplica,Moneda_Monto '
            + '  from QS_SUP_251_LIM_LISTAVAL '
            + ' where proceso      = :proceso'
            + '   AND Fecha_Desde <= :Fecha ');
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND codigo_limite IN ' + sString_LimPor);
      if (sTipo_Limite = 'Filtrado') then
        Sql.Add(' AND codigo_limite IN ' + sString_Limite);

      Parambyname('Proceso').asString := Ed_Proceso.Text;
      Parambyname('Fecha').AsDate     := dFecha_Cierre;
      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Resultado := False;
            Exit;
          end;
      end;

      Last;
      fRecordCount := RecordCount;
      if fRecordCount > 0 then
        fRecordCount := fRecordCount - 1;

      Reg_ListaVal_Ptje.Codigo_Limite := VarArrayCreate( [0, fRecordCount], varOleStr);
      Reg_ListaVal_Ptje.Porcentaje    := VarArrayCreate( [0, fRecordCount], varDouble);
      Reg_ListaVal_Ptje.Aplica_Sobre  := VarArrayCreate( [0, fRecordCount], varOleStr);
      Reg_ListaVal_Ptje.Moneda_Monto  := VarArrayCreate( [0, fRecordCount], varOleStr);

      i := 0;
      // x := 0;
      First;

      While not eof do
        begin
          Reg_ListaVal_Ptje.Codigo_Limite[i] := FieldByName('Codigo_Limite').asString;
          Reg_ListaVal_Ptje.Porcentaje[i]    := FieldByName('Porcentaje').asFloat;
          Reg_ListaVal_Ptje.Aplica_Sobre[i]  := FieldByName('codigo_Aplica').asString;
          Reg_ListaVal_Ptje.Moneda_Monto[i]  := FieldByName('Moneda_Monto').asString;
          Inc(i);
          Next;
        end;
      Close;
      // Fin     Es 05-2021

      (*

      Esto se inhibe porque solo esta considerando los instrumentos que tienen limites definidos   DC 15/11/2021

      Sql.Clear;
      Sql.Add('select distinct d.Instrumento '
            + '  from qs_sup_251_lim  a '
            + '     ,qs_sup_251_lim_det  b '
            + '     ,qs_sup_251_rtpr c '
            + '     ,qs_sup_251_rtpr_det d ' +
          ' where a.proceso       = :proceso '
          + '   AND a.Fecha_Desde  <= :Fecha '
          + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
          + '   AND b.proceso       = a.proceso '
          + '   AND b.codigo_limite = a.codigo_limite '
          + '   AND b.fecha_desde   = a.fecha_desde '
          + '   and c.codigo_rtpr   = b.codigo_rtpr '
          + '   AND c.fecha_desde  <= :Fecha '
          + '   AND (c.Fecha_Hasta IS NULL OR c.Fecha_Hasta >= :Fecha)'
          + '   AND d.codigo_rtpr   = c.codigo_rtpr '
          + '   AND d.fecha_desde   = c.fecha_desde ');
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND a.codigo_limite in ' + sString_LimPor);

      if (sTipo_Limite = 'Filtrado') then
        Sql.Add(' AND a.codigo_limite in ' + sString_Limite);

      Parambyname('proceso').asString := sProceso;
      Parambyname('Fecha').AsDate     := dFecha_Cierre;

      Open;
      sString_Instrum := '(';
      while not eof do
        begin
          sString_Instrum := sString_Instrum + ' ''' + FieldByName('Instrumento').asString + ''',';
          Next;
        end;

      sString_Instrum := sString_Instrum + ' '''' )';
      Esto se inhibe porque solo esta considerando los instrumentos que tienen limites definidos   DC 15/11/2021
      *)

      // Rescato Valores presentes Totales
      fValor_Pte_Compra  := 0;
      fValor_Pte_Mercado := 0;
      fValor_Pte_Mixto   := 0;
      Close;
      Sql.Clear;
      Sql.Add('SELECT SUM(a.Valor_Pte_Mc_Cpa)   as Valor_Pte_Mc_Cpa'
            + '      ,SUM(a.Valor_Pte_Mc_Mdo)   as Valor_Pte_Mc_Mdo'
            + '      ,SUM(a.Valorizacion_Mixta) as Valor_Pte_Mc_Mix'
            + '      ,c.Moneda_Cartera          as Moneda_Informe'
            + '      ,a.Nemotecnico             as Nemotecnico '
            + '      ,a.Instrumento             as Instrumento '
            + '      ,''RF''                    as Tipo_Instrum '
          + '  FROM QS_RES_MERCADO  a'
          + '      ,QS_FIN_CARTERAS c');
      if (sString_LimPor <> 'X') then
        Sql.Add(' ,QS_TEMP_LIMITE  d ');
      Sql.Add(' WHERE a.Fecha_Cierre     = :Fecha_Cierre'
//                + '   AND a.Instrumento in ' + sString_Instrum
            + '   AND a.EMPRESA in ' + sString_Empresas
            + '   AND a.CARTERA in ' + sString_Carteras
            + '   AND c.Cod_Cartera      = a.Cartera'
            + '   AND a.Fecha_Vcto      >  :Fecha_Cierre'
            + '   AND a.Fecha_Operacion <= :Fecha_Cierre'
            + '   AND a.Transaccion NOT IN (SELECT Codigo_Transaccion'
            + '                               FROM QS_SYS_TRAN_IMPLIC'
            + '                              WHERE Implicancia = ''PACTO'')');
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND d.pid         = :pid '
              + ' AND a.emisor      = d.Emisor '
              + ' AND a.instrumento = d.Instrumento '
              + ' AND a.nemotecnico = d.Nemotecnico ');
      Sql.Add(' Group By c.Moneda_Cartera, a.Nemotecnico, a.Instrumento ');
      Sql.Add(' UNION ');
      Sql.Add('SELECT SUM(a.COSTO_CORREGIDO) as Valor_Pte_Mc_Cpa'
            + '      ,SUM(a.Valor_Libro)     as Valor_Pte_Mc_Mdo'
            + '      ,SUM(a.Valor_Libro)     as Valor_Pte_Mc_Mix'
            + '      ,c.Moneda_Cartera       as Moneda_Informe'
            + '      ,a.Nemotecnico          as Nemotecnico '
            + '      ,a.Instrumento          as Instrumento '
            + '      ,''RV''                 as Tipo_Instrum '
          + '  FROM QS_RES_VALORIZA_RV a'
          + '      ,QS_FIN_CARTERAS    c'
          + '      ,QS_FIN_NEM_RVARI   d');
      if (sString_LimPor <> 'X') then
        Sql.Add(' ,QS_TEMP_LIMITE  e ');
      Sql.Add(' WHERE a.Fecha_Cierre  = :Fecha_Cierre');
//                + '   AND a.Instrumento in ' + sString_Instrum);
      Sql.Add('   AND a.EMPRESA in ' + sString_Empresas);
      Sql.Add('   AND a.CARTERA in ' + sString_Carteras);
      Sql.Add('   AND c.Cod_Cartera       = a.Cartera'
             +'   AND a.nemotecnico IN (SELECT b.codigo_nemotecnico FROM QS_FIN_NEM_RVARI_EST b '
             +'                                                     WHERE a.nemotecnico   = b.codigo_nemotecnico '
             +'                                                     AND   b.Codigo_Estado = ''NOCOTIZADO'' '
             +'                                                     AND   b.fecha_desde <= :Fecha_Cierre and (b.fecha_hasta >= :Fecha_Cierre or b.fecha_hasta Is Null)) '
             +'   AND d.Codigo_Nemotecnico = a.Nemotecnico ');
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND e.pid         = :pid '
              + ' AND a.instrumento = e.Instrumento '
              + ' AND a.nemotecnico = e.Nemotecnico ');
      Sql.Add(' Group By c.Moneda_Cartera, a.Nemotecnico, a.Instrumento ');
      Sql.Add(' UNION ');
      Sql.Add('SELECT SUM(a.COSTO_CORREGIDO)  as Valor_Pte_Mc_Cpa'
            + '      ,SUM(a.Valor_Mercado_Mc) as Valor_Pte_Mc_Mdo'
            + '      ,SUM(a.Valor_Libro)      as Valor_Pte_Mc_Mix'
            + '      ,c.Moneda_Cartera        as Moneda_Informe'
            + '      ,a.Nemotecnico           as Nemotecnico '
            + '      ,a.Instrumento           as Instrumento '
            + '      ,''RV''                  as Tipo_Instrum '
            + '  FROM QS_RES_VALORIZA_RV a'
            + '      ,QS_FIN_CARTERAS    c'
            + '      ,QS_FIN_NEM_RVARI   d');
      if (sString_LimPor <> 'X') then
        Sql.Add(' ,QS_TEMP_LIMITE  e ');
      Sql.Add(' WHERE a.Fecha_Cierre  = :Fecha_Cierre');
//              + '   AND a.Instrumento in ' + sString_Instrum);
      Sql.Add('   AND a.EMPRESA in ' + sString_Empresas);
      Sql.Add('   AND a.CARTERA in ' + sString_Carteras);
      Sql.Add('   AND c.Cod_Cartera       = a.Cartera'
            + '   AND a.nemotecnico IN (SELECT b.codigo_nemotecnico FROM QS_FIN_NEM_RVARI_EST b '
            + '                                                     WHERE a.nemotecnico   = b.codigo_nemotecnico '
            + '                                                     AND   b.Codigo_Estado = ''COTIZADO'' '
            + '                                                     AND   b.fecha_desde <= :Fecha_Cierre and (b.fecha_hasta >= :Fecha_Cierre or b.fecha_hasta Is Null)) '
            + '   AND d.Codigo_Nemotecnico = a.Nemotecnico ');
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND e.pid         = :pid '
              + ' AND a.instrumento = e.Instrumento '
              + ' AND a.nemotecnico = e.Nemotecnico ');
      Sql.Add(' Group By c.Moneda_Cartera, a.Nemotecnico, a.Instrumento ');
      Sql.Add(' UNION ');
      Sql.Add('SELECT SUM(a.COSTO_CORREGIDO)  as Valor_Pte_Mc_Cpa'
            + '      ,SUM(a.Valor_Mercado_Mc) as Valor_Pte_Mc_Mdo'
            + '      ,SUM(a.Valor_Mercado_Mc) as Valor_Pte_Mc_Mix'
            + '      ,c.Moneda_Cartera        as Moneda_Informe'
            + '      ,a.Nemotecnico           as Nemotecnico '
            + '      ,a.Instrumento           as Instrumento'
            + '      ,''RV''                  as Tipo_Instrum '
        + '  FROM QS_RES_VALORIZA_RV a'
        + '      ,QS_FIN_CARTERAS    c'
        + '      ,QS_FIN_NEM_RVARI   d');
      if (sString_LimPor <> 'X') then
        Sql.Add(' ,QS_TEMP_LIMITE  e ');
      Sql.Add(' WHERE a.Fecha_Cierre  = :Fecha_Cierre');
//              + '   AND a.Instrumento in ' + sString_Instrum);
      Sql.Add('   AND a.EMPRESA in ' + sString_Empresas);
      Sql.Add('   AND a.CARTERA in ' + sString_Carteras);
      Sql.Add('   AND c.Cod_Cartera   = a.Cartera'
            + '   AND a.nemotecnico NOT IN (SELECT b.codigo_nemotecnico FROM QS_FIN_NEM_RVARI_EST b '
            + '                              WHERE a.nemotecnico   = b.codigo_nemotecnico )'
            + '   AND d.Codigo_Nemotecnico = a.Nemotecnico ');
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND e.pid         = :pid ' + ' AND a.instrumento = e.Instrumento ' + ' AND a.nemotecnico = e.Nemotecnico ');
      // if bDesarrollo then
      // begin
      // Sql.Add('   AND k.CODIGO_RTPR   IN '+sString_RTPR
      // +'   AND k.Instrumento   = a.Instrumento ');
      //
      // end;
      Sql.Add(' Group By c.Moneda_Cartera, a.Nemotecnico, a.Instrumento ');

      Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;
      if (sString_LimPor <> 'X') then
        Parambyname('PID').asFloat := Application.Handle;
      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Resultado := False;
            Exit;
          end;
      end;

      Last;
      ProgressBar1.Max      := Qry_General.RecordCount;
      ProgressBar1.Position := 0;
      First;

      While (Not eof) and (Not bAbortar) do
      begin
        Lbl_Avance1.Caption := 'Nemotécnico: ' + Qry_General.FieldByName('Nemotecnico').asString;

        ProgressBar1.Position    := ProgressBar1.Position + 1;
        LabelPorcentaje1.Caption := FloatToStr(ProgressBar1.Position) + ' de ' + FloatToStr(ProgressBar1.Max) + ' (' + FormatFloat('##0', ProgressBar1.Position / ProgressBar1.Max * 100) + '%)';
        Application.ProcessMessages;

        fValor_Cambio := 1;
        if sMoneda_Nacional <> FieldByName('Moneda_Informe').asString then
        begin
          Leer_Valor_Cambio2_Mem( Qry_General.FieldByName('Moneda_Informe').asString,
                                  sMoneda_Nacional,
                                  'BC',
                                  dFecha_Cierre,
                                  fValor_Cambio,
                                  Result);
          if not Result
          then
            begin
              Inserta_Errores('Proceso Limite',
                              'No se encontro Tipo Cambio, Fecha - Moneda ' + DateToStr(dFecha_Cierre) + ' - ' + Qry_General.FieldByName('Moneda_Informe').asString);
              Qry_General.Next;
              Continue;
            end;
        end;

        fValor_Pte_Compra  := fValor_Pte_Compra + (FieldByName('Valor_Pte_Mc_Cpa').asFloat * fValor_Cambio);
        fValor_Pte_Mercado := fValor_Pte_Mercado + (FieldByName('Valor_Pte_Mc_Mdo').asFloat * fValor_Cambio);
        fValor_Pte_Mixto   := fValor_Pte_Mixto + (FieldByName('Valor_Pte_Mc_Mix').asFloat * fValor_Cambio);

        // GGARCIA 03-2010  para limites transacciones
        with Qry_Aux do
        begin
          Sql.Clear;
          Sql.Add('select distinct b.codigo_limite '
                + '  from qs_sup_251_lim  a '
                + '      ,qs_sup_251_lim_det  b '
                + '      ,qs_sup_251_rtpr c '
                + '      ,qs_sup_251_rtpr_det d '
                + ' where a.proceso       = :proceso '
                + '   AND a.Fecha_Desde  <= :Fecha '
                + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
                + '   AND b.proceso       = a.proceso '
                + '   AND b.codigo_limite = a.codigo_limite '
                + '   AND b.fecha_desde   = a.fecha_desde '
                + '   and c.codigo_rtpr   = b.codigo_rtpr '
                + '   AND c.fecha_desde  <= :Fecha '
                + '   AND (c.Fecha_Hasta IS NULL OR c.Fecha_Hasta >= :Fecha)'
                + '   AND d.codigo_rtpr   = c.codigo_rtpr '
                + '   AND d.fecha_desde   = c.fecha_desde '
                + '   and d.instrumento   = :instrumento ');

          if (sString_LimPor <> 'X') then
            Sql.Add(' AND a.codigo_limite in ' + sString_LimPor);
          if (sTipo_Limite = 'Filtrado') then
            Sql.Add(' AND a.codigo_limite in ' + sString_Limite);

          Parambyname('proceso').asString := sProceso;
          Parambyname('Fecha').AsDate     := dFecha_Cierre;

          Parambyname('instrumento').asString := Qry_General.FieldByName('Instrumento').asString;
          Open;
          while not eof do
            begin
              for i := 0 to VarArrayHighBound(Reg_Valor_Pte.Codigo_Limite, 1) do
                begin
                  if Reg_Valor_Pte.Codigo_Limite[i] = FieldByName('Codigo_Limite').asString then
                    begin
                      Reg_Valor_Pte.Valor_Pte_Compra[i]  := Reg_Valor_Pte.Valor_Pte_Compra[i] + (Qry_General.FieldByName('Valor_Pte_Mc_Cpa').asFloat * fValor_Cambio);
                      Reg_Valor_Pte.Valor_Pte_Mercado[i] := Reg_Valor_Pte.Valor_Pte_Mercado[i] + (Qry_General.FieldByName('Valor_Pte_Mc_Mdo').asFloat * fValor_Cambio);
                      Reg_Valor_Pte.Valor_Pte_Mixto[i]   := Reg_Valor_Pte.Valor_Pte_Mixto[i] + (Qry_General.FieldByName('Valor_Pte_Mc_Mix').asFloat * fValor_Cambio);
                      break;
                    end;
                end;
              Qry_Aux.Next;
            end;
          Close;
        end;
        // Fin GGARCIA 03-2010

        // GGARCIA 08-11-2013 para aplicar un % limite a un grupo de instrumentos
        with Qry_Aux do
        begin
          Close;
          Sql.Clear;
          Sql.Add('select distinct c.CODIGO_RTPR '
                         + '      ,c.Codigo_Objeto '
                         + '      ,c.Nodo ,c.Cod_Obj_Excluye ,c.Nodo_Excluye '
                + '  from qs_sup_251_lim  a '
                + '      ,qs_sup_251_lim_det  b '
                + '      ,qs_sup_251_rtpr_det c '
                + '      ,qs_sup_251_rtpr d '
                + ' where a.proceso       = :proceso '
                + '   AND a.Fecha_Desde  <= :Fecha '
                + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
                + '   AND b.proceso       = a.proceso '
                + '   AND b.codigo_limite = a.codigo_limite '
                + '   AND b.fecha_desde   = a.fecha_desde '
                + '   and d.codigo_rtpr   = b.codigo_rtpr '
                + '   AND d.fecha_desde  <= :Fecha '
                + '   AND (d.Fecha_Hasta IS NULL OR d.Fecha_Hasta >= :Fecha)'
                + '   and c.codigo_rtpr   = d.codigo_rtpr '
                + '   AND c.fecha_desde   = d.fecha_desde '
                + '   and c.instrumento   = :instrumento '
                + '   and (c.codigo_objeto is not null or c.cod_obj_Excluye is not null)'); // 06-2021

          if (sString_LimPor <> 'X') then
            Sql.Add(' AND d.CODIGO_RTPR IN ' + sString_RTPR);
          if (sTipo_Limite = 'Filtrado') then
            Sql.Add(' AND d.CODIGO_RTPR IN ' + sString_RTPR);
          //
          Parambyname('proceso').asString     := sProceso;
          Parambyname('Fecha').AsDate         := dFecha_Cierre;
          Parambyname('instrumento').asString := Qry_General.FieldByName('Instrumento').asString;

          Open;
          while not eof do
            begin
              // Valido Clasificación de NEMOTECNICO SI EXISTE
              if (FieldByName('Codigo_Objeto').asString <> '') and
                 Not(FieldByName('Codigo_Objeto').IsNull) and
                 (FieldByName('Nodo').asFloat <> 0) then
                begin
                  if Qry_General.FieldByName('Tipo_Instrum').asString = 'RV' then
                    Determina_Nodo_Clasificacion('NEMRVAR',
                                                  Qry_General.FieldByName('Nemotecnico').asString,
                                                  FieldByName('Codigo_Objeto').asString,
                                                  fNodo_Clasif)
                  else
                    Determina_Nodo_Clasificacion( 'NEMOTECNIC',
                                                  Qry_General.FieldByName('Nemotecnico').asString,
                                                  FieldByName('Codigo_Objeto').asString,
                                                  fNodo_Clasif);
                  if fNodo_Clasif <> FieldByName('Nodo').asFloat then
                    begin
                      Next;
                      Continue;
                    end;
                end;

              // Exluye Nemotecnicos que tengan clasificacion OIED  //        // 06-2021
              if (FieldByName('cod_obj_Excluye').asString <> '') and
                  Not(FieldByName('cod_obj_Excluye').IsNull) and
                 (FieldByName('Nodo_Excluye').asFloat <> 0) then
                begin
                  if Qry_General.FieldByName('Tipo_Instrum').asString = 'RV' then
                    Determina_Nodo_Clasificacion('NEMRVAR',
                                                  Qry_General.FieldByName('Nemotecnico').asString,
                                                  FieldByName('cod_obj_Excluye').asString,
                                                  fNodo_Clasif)
                  else
                    Determina_Nodo_Clasificacion('NEMOTECNIC',
                                                  Qry_General.FieldByName('Nemotecnico').asString,
                                                  FieldByName('cod_obj_Excluye').asString,
                                                  fNodo_Clasif);
                  if fNodo_Clasif = FieldByName('Nodo_Excluye').asFloat then
                    begin
                      Next;
                      Continue;
                    end;
                end;

              for i := 0 to VarArrayHighBound(Reg_Grupos_Instrum.Grupo_Instrumento, 1) do
                begin
                  if Reg_Grupos_Instrum.Grupo_Instrumento[i] = FieldByName('CODIGO_RTPR').asString then
                    begin
                      Reg_Grupos_Instrum.Valor_Pte_Compra[i]  := Reg_Grupos_Instrum.Valor_Pte_Compra[i] + (Qry_General.FieldByName('Valor_Pte_Mc_Cpa').asFloat * fValor_Cambio);
                      Reg_Grupos_Instrum.Valor_Pte_Mercado[i] := Reg_Grupos_Instrum.Valor_Pte_Mercado[i] + (Qry_General.FieldByName('Valor_Pte_Mc_Mdo').asFloat * fValor_Cambio);
                      Reg_Grupos_Instrum.Valor_Pte_Mixto[i]   := Reg_Grupos_Instrum.Valor_Pte_Mixto[i] + (Qry_General.FieldByName('Valor_Pte_Mc_Mix').asFloat * fValor_Cambio);
                      break;
                    end;
                end;
              Next;
            end;
          Close;
        end;
        // Fin GGARCIA 08-11-2013
        Next;
      end;
      Lbl_Avance1.Caption      := '';
      LabelPorcentaje1.Caption := '';
      ProgressBar1.Position    := 0;
      Application.ProcessMessages;

      // Para controlar Errores
      Close;
      if (sString_LimPor <> 'X') then
        begin
          Sql.Clear;
          Sql.Add(' SELECT distinct a.Emisor FROM QS_TEMP_LIMITE a'
                + '  WHERE a.PID = :PID ');
          Parambyname('PID').asFloat := Application.Handle;
        end
      else
        begin
          if sNorma = '11052' then
            begin
              Sql.Clear;
              Sql.Add(' SELECT a.Emisor FROM QS_SBS_TOTAL_INVERSIONES a'
                    + '  WHERE a.Fecha_de_Cierre       = :Fecha_Cierre'
                    + '    AND a.Fecha_Cierre_Anterior = :Fecha_Cierre_Ant '
                    + '    AND a.Fecha_Inicio_Anterior = :Fecha_Inicio_Ant '
                    + '    AND a.Tipo_Conversion       = :Tipo_Conversion ');
              Sql.Add('    AND a.EMPRESA in ' + sString_Empresas);
              Sql.Add('    AND a.CARTERA in ' + sString_Carteras);

              if sTipo_Conversion = 'Moneda_Conversion'
              then
                Sql.Add('     AND a.Moneda_Conversion     = :Moneda_Conversion ');
            end
          else
            begin
              if sNorma = '1041' then
                begin
                  Sql.Clear;
                  Sql.Add(' SELECT a.Emisor FROM QS_SBS_1041_ANX1_INVERTOTAL a'
                        + '  WHERE a.Fecha_de_Cierre       = :Fecha_Cierre'
                        + '    AND a.Fecha_Cierre_Anterior = :Fecha_Cierre_Ant '
                        + '    AND a.Fecha_Inicio_Anterior = :Fecha_Inicio_Ant '
                        + '    AND a.Tipo_Conversion       = :Tipo_Conversion ');
                  Sql.Add('    AND a.EMPRESA in ' + sString_Empresas);
                  Sql.Add('    AND a.CARTERA in ' + sString_Carteras);

                  if sTipo_Conversion = 'Moneda_Conversion'
                  then
                    Sql.Add('     AND a.Moneda_Conversion     = :Moneda_Conversion ');
                end
              else
                begin
                  Sql.Clear;
                  Sql.Add(' SELECT a.Emisor FROM QS_RES_MERCADO a'
                        + '  WHERE a.Fecha_Cierre  = :Fecha_Cierre'
//                          + '    AND a.Instrumento in ' + sString_Instrum
                        + '    AND a.EMPRESA in '+ sString_Empresas
                        + '    AND a.CARTERA in ' + sString_Carteras
                        + '    AND a.COMPROMETIDO       <> ''I'''
                        + '    AND a.transaccion in (SELECT d.Codigo_Transaccion');
                  Sql.Add('                      FROM qs_sys_tran_implic d');
                  Sql.Add('                     WHERE d.Codigo_transaccion = a.transaccion');
                  Sql.Add('                       AND d.implicancia = ''COMPRA'')');
                end;
            end;
          Sql.Add(' GROUP BY a.Emisor');

          if (sNorma = '11052') or (sNorma = '1041') then
            begin
              Parambyname('Fecha_Cierre').AsDate      := dFecha_Cierre;
              Parambyname('Fecha_Cierre_Ant').AsDate  := dFecha_Cierre_Anterior;
              Parambyname('Fecha_Inicio_Ant').AsDate  := dFecha_Inicio_Cierre_Anterior;
              Parambyname('Tipo_Conversion').asString := sTipo_Conversion;
              if sTipo_Conversion = 'Moneda_Conversion'
              then
                Parambyname('Moneda_conversion').asString := sMoneda_Conversion;
            end
          else
            Parambyname('Fecha_Cierre').AsDate := dFecha_Cierre;
        end;

      try
        Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Resultado := False;
            Exit;
          end;
      end;

      Last;
      fRecordCount := RecordCount;
      if fRecordCount > 0 then
        fRecordCount := fRecordCount - 1;

      Reg_Errores_Grupo.Emisor := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Errores_Grupo.Error  := VarArrayCreate([0, fRecordCount],varOleStr);
      i := 0;
      First;

      while Not eof do
        begin
          Reg_Errores_Grupo.Emisor[i] := FieldByName('Emisor').asString;
          Reg_Errores_Grupo.Error[i]  := 'N';
          Inc(i);
          Next;
        end;
      Close;
    end;

    llenar_T_TmpDatos(Resultado);
    if Not Resultado then
    begin
      Resultado := False;
      Exit;
    end;

    // *******************************
    // Comienzo a Aplicar Limites
    // ******************************

    // Obtengo codigos_rtpr de acciones y cuotas para utilizarlos posteriormente en Reg_Emisores_Nem
    sCod_rtpr := '''''';
    With Qry_General do
    begin
      Close;
      Sql.Clear;
      Sql.Add('select DISTINCT b.codigo_rtpr '
            + '  from qs_sup_251_lim     a '
            + '      ,qs_sup_251_lim_det b '
            + ' WHERE a.codigo_porcentaje in (''ACCIONES'',''CUOTAS'',''VM'',''VX'',''VP'') '
            + '   AND a.Proceso           = :Proceso'
            + '   AND a.Fecha_Desde      <= :Fecha'
            + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
            + '   AND a.Proceso           = b.Proceso'
            + '   AND a.Codigo_Limite     = b.Codigo_Limite'
            + '   AND a.Fecha_Desde       = b.Fecha_Desde');
      if (sString_LimPor <> 'X') then
        Sql.Add(' AND b.codigo_rtpr in ' + sString_RTPR);
      if (sTipo_Limite = 'Filtrado') then
        Sql.Add(' AND b.codigo_rtpr in ' + sString_RTPR);

      Parambyname('Proceso').asString := Ed_Proceso.Text;
      Parambyname('Fecha').AsDate     := dFecha_Cierre;
      Open;

      While not eof do
      begin
        if sCod_rtpr = '''''' then
          sCod_rtpr := '(''' + FieldByName('codigo_rtpr').asString + ''''
        else
          sCod_rtpr := sCod_rtpr + ',''' + FieldByName('codigo_rtpr').asString + '''';

        Next;
      end;
      if sCod_rtpr <> '''''' then
        sCod_rtpr := sCod_rtpr + ')';
    end;

    // Determino los Grupos de Emisores Existentes
    With Qry_Prdx do
    begin
      Qry_Prdx.Close;
      Qry_Prdx.Sql.Clear;
      Qry_Prdx.Sql.Add(' SELECT Grupo_Emisor FROM ' + T_TmpDatos.Name
                      + ' WHERE Grupo_Emisor <> '' '''
                      + '   AND Grupo_Emisor <> ''SIN CLASIFICACION'' '
                      + '   AND GRUPO_EMISOR <> ''SIN CLASIF''  '   // ===> No se consideran los SIN CLASIF F.I.  09-08-2021
                      + ' GROUP BY Grupo_Emisor' + ' ORDER BY Grupo_Emisor');

      if bdesarrollo then
         Qry_Prdx.Open
      else
        try
          Qry_Prdx.Open;
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E);
              Resultado := False;
              Exit;
            end;
        end;
      Qry_Prdx.Last;
      fRecordCount := Qry_Prdx.RecordCount;
      if fRecordCount > 0
      then
        fRecordCount := fRecordCount - 1;

      Reg_Grupos_Emisores.Grupo_Emisor  := VarArrayCreate([0, fRecordCount], varOleStr);
      Reg_Grupos_Emisores.Valor_Cartera := VarArrayCreate([0, fRecordCount], varDouble);
      i := 0;
      Qry_Prdx.First;
      While not Qry_Prdx.eof do
      begin
          Reg_Grupos_Emisores.Grupo_Emisor[i]  := Qry_Prdx.FieldByName('Grupo_Emisor').asString;
          Reg_Grupos_Emisores.Valor_Cartera[i] := 0;
          Inc(i);
          Qry_Prdx.Next;
      end;
      Qry_Prdx.Close;

      /// DC 02/08/2016  // Determino los Clasificacion de Emisores Existentes
      Qry_Prdx.Sql.Clear;
      Qry_Prdx.Sql.Add(' SELECT Tipo_Clasif,Grupo_Clasif FROM ' + T_TmpDatos.Name
                     + '  WHERE Tipo_Clasif <> '' '''
                     + '    AND Grupo_Clasif <> 0 '
                     + '  GROUP BY Tipo_Clasif,Grupo_Clasif '
                     + '  ORDER BY Tipo_Clasif,Grupo_Clasif ');

      if bdesarrollo then
         Qry_Prdx.Open
      else
        try
          Qry_Prdx.Open;
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E);
              Resultado := False;
              Exit;
            end;
        end;
      Qry_Prdx.Last;

      fRecordCount := Qry_Prdx.RecordCount;
      if fRecordCount > 0
      then
        fRecordCount := fRecordCount - 1;

      Reg_Grupos_EmiClasif.Tipo_Clasif   := VarArrayCreate([0,fRecordCount],varOleStr);
      Reg_Grupos_EmiClasif.Grupo_Clasif  := VarArrayCreate([0,fRecordCount],varDouble);
      Reg_Grupos_EmiClasif.Valor_Cartera := VarArrayCreate([0,fRecordCount],varDouble);
      Qry_Prdx.First;
      i := 0;
      While not Qry_Prdx.eof do
      begin
          Reg_Grupos_EmiClasif.Tipo_Clasif[i]   := Qry_Prdx.FieldByName('Tipo_Clasif').asString;
          Reg_Grupos_EmiClasif.Grupo_Clasif[i]  := Qry_Prdx.FieldByName('Grupo_Clasif').asString;
          Reg_Grupos_EmiClasif.Valor_Cartera[i] := 0;
          Inc(i);
          Qry_Prdx.Next;
      end;
      Qry_Prdx.Close;
      /// DC 02/08/2016

      Qry_Prdx.Sql.Clear;
      Qry_Prdx.Sql.Add(' SELECT Emisor FROM ' + T_TmpDatos.Name
                     + ' GROUP BY Emisor'
                     + ' ORDER BY Emisor');

      if bdesarrollo then
         Qry_Prdx.Open
      else
          try
            Qry_Prdx.Open;
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                Resultado := False;
                Exit;
              end;
          end;
      Qry_Prdx.Last;

      fRecordCount := Qry_Prdx.RecordCount;
      if fRecordCount > 0 then
        fRecordCount := fRecordCount - 1;

      Reg_Emisores.Emisor        := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Emisores.Valor_Cartera := VarArrayCreate([0, fRecordCount],varDouble);
      Reg_Emisores.Grupo_Emisor  := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Emisores.Emisor_Matriz := VarArrayCreate([0, fRecordCount],varOleStr);
      i := 0;
      Qry_Prdx.First;
      While not Qry_Prdx.eof do
      begin
          Reg_Emisores.Emisor[i]        := Qry_Prdx.FieldByName('Emisor').asString;
          Reg_Emisores.Emisor_Matriz[i] := Emisor_Matriz(Qry_Prdx.FieldByName('Emisor').asString);

          Qry_EstadoEMI.Close;
          Qry_EstadoEMI.Parambyname('Emisor').asString := Qry_Prdx.FieldByName('Emisor').asString;
          Qry_EstadoEMI.Parambyname('Fecha').AsDate    := dFecha_Cierre;

          if bDesarrollo then
             Qry_EstadoEMI.Open
          else
            try
              Qry_EstadoEMI.Open;
            except
              on E: EFDDBEngineException do
                begin
                  ShowError(E);
                  Resultado := False;
                  Exit;
                end;
            end;
          if Not Qry_EstadoEMI.FieldByName('Grupo_Emisor').IsNull then
            Reg_Emisores.Grupo_Emisor[i] := Qry_EstadoEMI.FieldByName('Grupo_Emisor').asString;
          Qry_EstadoEMI.Close;

          Reg_Emisores.Valor_Cartera[i] := 0;
          Inc(i);
          Qry_Prdx.Next;
      end;
      Qry_Prdx.Close;

      Qry_Prdx.Sql.Clear;
      Qry_Prdx.Sql.Add('SELECT DISTINCT Emisor,Instrumento,Nemotecnico FROM ' + T_TmpDatos.Name);
      if sCod_rtpr <> '''''' then
        Qry_Prdx.Sql.Add(' WHERE codigo_RTPR in ' + sCod_rtpr);
      Qry_Prdx.Sql.Add(' GROUP BY Emisor,Instrumento,Nemotecnico'
                     + ' ORDER BY Emisor,Instrumento,Nemotecnico');

      if bdesarrollo then
         Qry_Prdx.Open
      else
        try
          Qry_Prdx.Open;
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E);
              Resultado := False;
              Exit;
            end;
        end;

      T_TmpDatos.First;
      i := 0;
      Qry_Prdx.Last;

      fRecordCount := Qry_Prdx.RecordCount;
      if fRecordCount > 0 then
         fRecordCount := fRecordCount - 1;

      Reg_Emisores_Nem.Emisor        := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Emisores_Nem.Instrumento   := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Emisores_Nem.Nemotecnico   := VarArrayCreate([0, fRecordCount],varOleStr);
      Reg_Emisores_Nem.Valor_Cartera := VarArrayCreate([0, fRecordCount],varDouble);

      Qry_Prdx.First;
      While not Qry_Prdx.eof do
      begin
          Reg_Emisores_Nem.Emisor[i]        := Qry_Prdx.FieldByName('Emisor').asString;
          Reg_Emisores_Nem.Instrumento[i]   := Qry_Prdx.FieldByName('Instrumento').asString;
          Reg_Emisores_Nem.Nemotecnico[i]   := Trim(Qry_Prdx.FieldByName('Nemotecnico').asString);
          Reg_Emisores_Nem.Valor_Cartera[i] := 0;

          Inc(i);
          Qry_Prdx.Next;
      end;
      Qry_Prdx.Close;

      Qry_Prdx.Sql.Clear;
      Qry_Prdx.Sql.Add('SELECT DISTINCT Emisor,Instrumento,Nemotecnico FROM ' + T_TmpDatos.Name);
      Qry_Prdx.Sql.Add(' GROUP BY Emisor,Instrumento,Nemotecnico'
                     + ' ORDER BY Emisor,Instrumento,Nemotecnico');

      if bdesarrollo then
         Qry_Prdx.Open
      else
        try
          Qry_Prdx.Open;
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E);
              Resultado := False;
              Exit;
            end;
        end;

      T_TmpDatos.First;
      i := 0;
      Qry_Prdx.Last;

      fRecordCount := Qry_Prdx.RecordCount;
      if fRecordCount > 0
      then
        fRecordCount := fRecordCount - 1;

      Reg_Emisor_Nemo.Emisor        := VarArrayCreate([0,fRecordCount],varOleStr);
      Reg_Emisor_Nemo.Instrumento   := VarArrayCreate([0,fRecordCount],varOleStr);
      Reg_Emisor_Nemo.Nemotecnico   := VarArrayCreate([0,fRecordCount],varOleStr);
      Reg_Emisor_Nemo.Valor_Cartera := VarArrayCreate([0,fRecordCount],varDouble);

      Qry_Prdx.First;
      While not Qry_Prdx.eof do
      begin
          Reg_Emisor_Nemo.Emisor[i]        := Qry_Prdx.FieldByName('Emisor').asString;
          Reg_Emisor_Nemo.Instrumento[i]   := Qry_Prdx.FieldByName('Instrumento').asString;
          Reg_Emisor_Nemo.Nemotecnico[i]   := Trim(Qry_Prdx.FieldByName('Nemotecnico').asString);
          Reg_Emisor_Nemo.Valor_Cartera[i] := 0;

          Inc(i);
          Qry_Prdx.Next;
      end;
      Qry_Prdx.Close;

      Qry_Prdx.Sql.Clear;
      Qry_Prdx.Sql.Add(' SELECT Moneda_Instrum FROM ' + T_TmpDatos.Name
                     + ' GROUP BY Moneda_Instrum'
                     + ' ORDER BY Moneda_Instrum');
      try
        Qry_Prdx.Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Resultado := False;
            Exit;
          end;
      end;
      Qry_Prdx.Last;
      fRecordCount := Qry_Prdx.RecordCount;
      if fRecordCount > 0 then
        fRecordCount     := fRecordCount - 1;
      Reg_Monedas.Moneda        := VarArrayCreate([0, fRecordCount], varOleStr);
      Reg_Monedas.Valor_Cartera := VarArrayCreate([0, fRecordCount], varDouble);
      i := 0;
      Qry_Prdx.First;
      While not Qry_Prdx.eof do
      begin
        Reg_Monedas.Moneda[i]        := Qry_Prdx.FieldByName('Moneda_Instrum').asString;
        Reg_Monedas.Valor_Cartera[i] := 0;
        Inc(i);
        Qry_Prdx.Next;
      end;
      Qry_Prdx.Close;
    end;

    sCod_rtpr := '''''';
    With Qry_General do
    begin
        Close;
        Sql.Clear;
        Sql.Add('select DISTINCT b.codigo_rtpr '
              + '  from qs_sup_251_lim     a '
              + '      ,qs_sup_251_lim_det b '
              + ' WHERE a.SUMA_INVERSION in (''IDEMDEUDOR'') '
              + '   AND a.Proceso           = :Proceso'
              + '   AND a.Fecha_Desde      <= :Fecha'
              + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
              + '   AND a.Proceso           = b.Proceso'
              + '   AND a.Codigo_Limite     = b.Codigo_Limite'
              + '   AND a.Fecha_Desde       = b.Fecha_Desde');
        if (sString_LimPor <> 'X') then
          Sql.Add(' AND b.codigo_rtpr in ' + sString_RTPR);
        if (sTipo_Limite = 'Filtrado') then
          Sql.Add(' AND b.codigo_rtpr in ' + sString_RTPR);

        Parambyname('Proceso').asString := Ed_Proceso.Text;
        Parambyname('Fecha').AsDate     := dFecha_Cierre;
        Open;

        While not eof do
        begin
            if sCod_rtpr = '''''' then
              sCod_rtpr := '(''' + FieldByName('codigo_rtpr').asString + ''''
            else
              sCod_rtpr := sCod_rtpr + ',''' + FieldByName('codigo_rtpr').asString + '''';

            Next;
        end;
        if sCod_rtpr <> '''''' then
          sCod_rtpr := sCod_rtpr + ')'
        else
          sCod_rtpr := ' ('''') ';
    end;

    Qry_Prdx.Close;

    Qry_Prdx.Sql.Clear;
    Qry_Prdx.Sql.Add(' SELECT DISTINCT CREDENCIAL_DEUDOR,NOMBRE_DEUDOR '
                   + '   FROM ' + T_TmpDatos.Name
                   + '  WHERE codigo_RTPR in ' + sCod_rtpr
                   + '    AND TRIM(CREDENCIAL_DEUDOR) <> '''' '
                   + '  ORDER BY CREDENCIAL_DEUDOR');
    try
      Qry_Prdx.Open;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Resultado := False;
          Exit;
        end;
    end;
    Qry_Prdx.Last;
    fRecordCount := Qry_Prdx.RecordCount;
    if fRecordCount > 0
    then
      fRecordCount := fRecordCount - 1;

    Reg_Deudores_Mem.Deudor        := VarArrayCreate( [0, fRecordCount],varOleStr);
    Reg_Deudores_Mem.Nombre_Deudor := VarArrayCreate([0, fRecordCount],varOleStr);
    Reg_Deudores_Mem.Valor_Cartera := VarArrayCreate([0, fRecordCount],varDouble);

    i := 0;
    Qry_Prdx.First;
    While not Qry_Prdx.eof do
    begin
        Reg_Deudores_Mem.Deudor[i]        := Qry_Prdx.FieldByName('CREDENCIAL_DEUDOR').asString;
        Reg_Deudores_Mem.Nombre_Deudor[i] := Qry_Prdx.FieldByName('NOMBRE_DEUDOR').asString;
        Reg_Deudores_Mem.Valor_Cartera[i] := 0;
        Inc(i);
        Qry_Prdx.Next;
    end;
    Qry_Prdx.Close;

    sCod_rtpr := '''''';
    With Qry_General do
    begin
       Close;
       Sql.Clear;
       Sql.Add('select DISTINCT b.codigo_rtpr '
             + '  from qs_sup_251_lim     a '
             + '      ,qs_sup_251_lim_det b '
             + ' WHERE a.SUMA_INVERSION in (''CREDITO'') '
             + '   AND a.Proceso           = :Proceso'
             + '   AND a.Fecha_Desde      <= :Fecha'
             + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha)'
             + '   AND a.Proceso           = b.Proceso'
             + '   AND a.Codigo_Limite     = b.Codigo_Limite'
             + '   AND a.Fecha_Desde       = b.Fecha_Desde');
       if (sString_LimPor <> 'X')
       then
         Sql.Add(' AND b.codigo_rtpr in ' + sString_RTPR);
       if (sTipo_Limite = 'Filtrado')
       then
         Sql.Add(' AND b.codigo_rtpr in ' + sString_RTPR);

       Parambyname('Proceso').asString := Ed_Proceso.Text;
       Parambyname('Fecha').AsDate     := dFecha_Cierre;
       Open;

       While not eof do
       begin
           if sCod_rtpr = '''''' then
             sCod_rtpr := '(''' + FieldByName('codigo_rtpr').asString + ''''
           else
             sCod_rtpr := sCod_rtpr + ',''' + FieldByName('codigo_rtpr').asString + '''';

           Next;
       end;
       if sCod_rtpr <> '''''' then
         sCod_rtpr := sCod_rtpr + ')'
       else
         sCod_rtpr := ' ('''') ';
    end;

    Qry_Prdx.Close;

    Qry_Prdx.Sql.Clear;
    Qry_Prdx.Sql.Add(' SELECT DISTINCT Id_Credito '
                   + '   FROM ' + T_TmpDatos.Name
                   + '  WHERE codigo_RTPR in ' + sCod_rtpr
                   + '    AND TRIM(Id_Credito) <> '''' '
                   + '  ORDER BY Id_Credito');
    try
      Qry_Prdx.Open;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Resultado := False;
          Exit;
        end;
    end;
    Qry_Prdx.Last;
    fRecordCount := Qry_Prdx.RecordCount;
    if fRecordCount > 0
    then
      fRecordCount := fRecordCount - 1;

    Reg_Creditos_Mem.Id_Credito    := VarArrayCreate([0, fRecordCount],varOleStr);
    Reg_Creditos_Mem.Valor_Cartera := VarArrayCreate([0, fRecordCount],varDouble);

    i := 0;
    Qry_Prdx.First;
    While not Qry_Prdx.eof do
    begin
        Reg_Creditos_Mem.Id_Credito[i]    := Qry_Prdx.FieldByName('Id_Credito').asString;

        Reg_Creditos_Mem.Valor_Cartera[i] := 0;
        Inc(i);
        Qry_Prdx.Next;
    end;
    Qry_Prdx.Close;
end;

Procedure TFrmCalculoLimites.Seleccion_RTPT(sString_Instrumento :string);
var
  sTipo_Clasif, sAux_String, sClasif_Riesgo, sClasif_emisor, sNodos_Hijos_Instrumentos, sdescripcion_nodo, sEmisor_Pagador, sEmisor, sClasificadora_Default: String;
  fNodo_Emiclasif, fValor_Final_SVS_MC, fValor_Pte_MC_Cpa, fValor_Pte_MC_Mdo, fValor_Pte_MC_Mix, fPorcentaje_Deuda_Garantia, fNodo_Clasif,fPorcentaje_max  : Double;
  String_Arr                                                                                                                                               : TArr100_String;
  bEncontro                                                                                                                                                : Boolean;
  i                                                                                                                                                        : Integer;
  iMeses : Integer;
  bNominal : Boolean;
  dFecha_emision  : TDateTime;
  aa,mm,dd : Word;
begin
  // ggarcia 18-10-2013
  sClasificadora_Default := Default_TipEmp(sEmpresa_Usuario,
                                           fItem_Dir_Usuario,
                                           'AGENCIACLA');

  // Primero rescato los Instrumentos que corresponden al código
  // de reserva técnica y patrimonio de riesgo

  // if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
  // dmBaseDatos.Conexion_BaseDatos.StartTransaction;

  With Qry_General do
  begin
    Close;
    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TEMP_LIMITE '
          + '  WHERE PID = :PID');
    Parambyname('PID').asFloat := Application.Handle;

    try
      ExecSql;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;

    Sql.Clear;
    Sql.Add(' DELETE FROM QS_TEMP_LIMITE '
          + '  WHERE FECHA_CREACION < :FECHA_CREACION');
    Parambyname('FECHA_CREACION').AsDate := Fecha_Hora_Servidor - 1;

    try
      ExecSql;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
          Close;
          Exit;
        end;
    end;
  end;

  if (sTipo_Limite = 'T') then
    Genera_Tabla_Interno(Qry_RTPR_Det.FieldByName('Codigo_RTPR').asString)
  else
  begin
    if sNorma = '11052' then
      Genera_Tabla_11052(sString_Carteras,
                         sString_Empresas,
                         dFecha_Cierre,
                         dFecha_Cierre_Anterior,
                         dFecha_Inicio_Cierre_Anterior,
                         sTipo_Conversion,
                         sMoneda_Conversion,
                         sMoneda_Nacional,
                         Qry_RTPR_Det.FieldByName('Codigo_RTPR').asString)

      /// mantencion total inversiones
    else
      if sNorma = '1041' then
        Genera_Tabla_1041(sString_Carteras,
                          sString_Empresas,
                          dFecha_Cierre,
                          dFecha_Cierre_Anterior,
                          dFecha_Inicio_Cierre_Anterior,
                          sTipo_Conversion,
                          sMoneda_Conversion,
                          sMoneda_Nacional,
                          Qry_RTPR_Det.FieldByName('Codigo_RTPR').asString)
        /// anexo1 complementario total inversiones
      else
        if Qry_RTPR.FieldByName('Tipo_Grupo').asString = 'TRANSACCIO' then
        begin
          Genera_Tabla_con_Transacciones( sString_Carteras,
                                          sString_Empresas,
                                          dFecha_Cierre,
                                          Qry_RTPR_Det.FieldByName('Codigo_RTPR').asString,
                                          Qry_RTPR_Det.FieldByName('Origen_Posicion').asString,
                                          sTipo_Limite,
                                          sModulo_Error,
                                          sString_Error,
                                          Result);
          if not Result then
            Inserta_Errores(sModulo_Error,
                            sString_Error);
        end
        else
          Genera_Tabla_Stock(sString_Carteras,
                             sString_Empresas,
                             dFecha_Cierre,
                             Qry_RTPR_Det.FieldByName('Codigo_RTPR').asString,
                             Qry_RTPR_Det.FieldByName('Origen_Posicion').asString,
                             sTipo_Limite);
    /// Stock RF y RV
  end;

  With Qry_General do
  begin
    Close;
    Sql.Clear;
    Sql.Add(' SELECT * FROM QS_TEMP_LIMITE '
          + '  WHERE PID = :PID' );
    if Qry_RTPR.FieldByName('Tipo_Grupo').asString <> 'TRANSACCIO' then
      Sql.Add('     AND Instrumento in '+ sString_Instrumento);
    Sql.Add('  ORDER BY FOLIO_INTERNO,ITEM_OMD,TRANSACCION');

    Parambyname('PID').asFloat := Application.Handle;

    Qry_General.Open;
    Qry_General.Last;
    ProgressBar2.Max      := Qry_General.RecordCount;
    ProgressBar2.Position := 0;
    Lbl_Avance2.Caption   := 'Cargando Grupo: ' + Qry_RTPR_Det.FieldByName('Codigo_RTPR').asString;
    Application.ProcessMessages;
    Qry_General.First;

    While (Not Qry_General.eof) and (Not bAbortar) do
    begin

//        if bDesarrollo then
//    begin
//    if trim(Fieldbyname('Folio_interno').asString)  <> '60120465' then
////         Lbl_Avance1.Caption      := 'Aplicando: ' + Qry_Limites.FieldByName('Codigo_Limite').asString;
//    begin
//    Next;
//    Continue;
//    end;
//    end;


      ProgressBar2.Position    := ProgressBar2.Position + 1;
      LabelPorcentaje2.Caption := FloatToStr(ProgressBar2.Position) + ' de ' + FloatToStr(ProgressBar2.Max) + ' (' + FormatFloat('##0', ProgressBar2.Position / ProgressBar2.Max * 100) + '%)';
      Application.ProcessMessages;
      Result := True;

      // Importantisimo inicializar la clasificacion de riesgo
      // se quedaba pegado el resultado anterior cuando no se usa. 30-08-2021 F.I.
      sClasif_Riesgo := '';

      // Primero Verifico Nacionalidad
      sPais := FieldByName('Pais').asString;
      if Not bSBS then
      begin
        if FieldByName('Tipo_Instrum').asString = 'R' then
          sPais := FieldByName('Pais').asString
        else
        begin
          fItem_Dir_Emisor := default_direccion(FieldByName('Emisor').asString,
                                                dFecha_Cierre);

          sCodigo_Geo_Emisor := Codigo_Geo_IdDir(FieldByName('Emisor').asString,
                                                 fItem_Dir_Emisor);

          sPais := Pais_Para_CodGeo(sCodigo_Geo_Emisor);
        end;

        if Trim(sPais) = '' then
        begin
          sPais := FieldByName('Pais').asString;
          if sPais = '' then
          begin
            if FieldByName('Tipo_Instrum').asString = 'R' then
              Inserta_Errores(' Pais Nemotécnico :',
                              ' No se Encuentra país en Nemotécnico' + FieldByName('Nemotecnico').asString + '.')
            else
              Inserta_Errores('Dirección, Pais Emisor :',
                              'Error para: ''' + FieldByName('Emisor').asString + ''' dirección (' + FloatToStr(fItem_Dir_Emisor) + ').' + ' No se Encuentra país para Dirección. ');
            Next;
            Continue;
          end;
        end;
      end
      else
      begin
        if Trim(sPais) = '' then
        begin
          fItem_Dir_Emisor := default_direccion(FieldByName('Emisor').asString,
                                                dFecha_Cierre);

          sCodigo_Geo_Emisor := Codigo_Geo_IdDir(FieldByName('Emisor').asString,
                                                 fItem_Dir_Emisor);

          sPais := Pais_Para_CodGeo(sCodigo_Geo_Emisor);

          if Trim(sPais) = '' then
          begin
            Inserta_Errores('Dirección, País Emisor :',
                            'Error para: ''' + FieldByName('Emisor').asString + ''' dirección (' + FloatToStr(fItem_Dir_Emisor) + ').' + ' No se Encuentra país para Dirección. ');
            Next;
            Continue;
          end;
        end;
      end;

      sNacion := Trim(Nacion_Pais(sPais));
      if Trim(sNacion) = '' then
      begin
        Inserta_Errores(' Nación Pais :',
                        ' Error en Definición de Nación para Pais : ' + sPais + ' Emisor : ' + FieldByName('Emisor').asString);
        Next;
        Continue;
      end;

      // No Considero Emisores con diferente NACION
      if Trim(Qry_RTPR.FieldByName('Nacion').asString) <> '' then
      begin
        if Trim(sNacion) = 'N' then
        begin
          if Participacion_Extranjera(FieldByName('Nemotecnico').asString, dFecha_Cierre) then
            sNacion := 'E';
        end;

        if Trim(sNacion) <> Trim(Qry_RTPR.FieldByName('Nacion').asString) then
        begin
          Next;
          Continue;
        end;
      end;

      if (Trim(Qry_RTPR_Det.FieldByName('CLASIFICADORA_EMISOR').asString) <> '') and (NOT Qry_RTPR_Det.FieldByName('CLASIFICADORA_EMISOR').IsNull) and
         (Trim(Qry_RTPR_Det.FieldByName('CLASIF_RIESGO_EMISOR').asString) <> '') and (NOT Qry_RTPR_Det.FieldByName('CLASIF_RIESGO_EMISOR').IsNull) and
         (Trim(Qry_RTPR_Det.FieldByName('OPERAC_CLASIF_EMISOR').asString) <> '') and (NOT Qry_RTPR_Det.FieldByName('OPERAC_CLASIF_EMISOR').IsNull) then
      begin
        // Verifico si existe definición de Clasificacion
        // Si Grupo Implica Agrupacion por emision busco clasificación de RIESGO
        // POR EMISOR,INSTRUMENTO
        // sClasif_Riesgo := FieldByName('Clasif_Riesgo').asString;

        // DC 02/08/2016
        if Trim(FieldByName('Clasificadora_Emisor').asString) <> '' then
        begin
          sTipo_Clasif   := '';
          sClasif_Riesgo := '';
          sClasif_emisor := FieldByName('Clasificadora_Emisor').asString;

          Busca_Clasif_Riesgo_Origen_Tipo_Mem(
                                              FieldByName('Emisor').asString,
                                              '',
                                              '',
                                              '',
                                              dFecha_Cierre,
                                              sClasif_emisor,
                                              sTipo_Clasif,
                                              False,
                                              sClasif_Riesgo,
                                              fFactor_Riesgo,
                                              sEmisor_Pagador);

          if Not Aplica_Operacion_Clasif_Riesgo_Mem(sClasif_Riesgo,
                                                    FieldByName('Clasif_Riesgo_emisor').asString,
                                                    FieldByName('Operac_clasif_emisor').asString,
                                                    'N',
                                                    ' ',
                                                    sModulo_Error,
                                                    sString_Error) then
          begin
            Next;
            Continue;
          end;
        end;
      end;

      if (Trim(Qry_RTPR_Det.FieldByName('CLASIF_RIESGO').asString) <> '') and
         (NOT Qry_RTPR_Det.FieldByName('CLASIF_RIESGO').IsNull) and
         (Trim(Qry_RTPR_Det.FieldByName('OPERACION').asString) <> '') and
         (NOT Qry_RTPR_Det.FieldByName('OPERACION').IsNull) then
      begin
        sClasif_Riesgo         := '';
        sClasificadora_Default := '';
        // DC 02/08/2016
        sTipo_Clasif := ''; // ggarcia 14-07-2015
        Busca_Clasif_Riesgo_Origen_Tipo_Mem(
                              FieldByName('Emisor').asString,
                              FieldByName('Instrumento').asString,
                              FieldByName('Serie').asString,
                              FieldByName('Nemotecnico').asString,
                              dFecha_Cierre,
                              sClasificadora_Default,
                              sTipo_Clasif,
                              False,
                              sClasif_Riesgo,
                              fFactor_Riesgo,
                              sEmisor_Pagador);

        // Segundo Verifico Clasificación de Riesgo
        // o si incluye instrumento sin Clasificación
        if Trim(Qry_RTPR.FieldByName('Nacion').asString) <> '' then
        begin
          // Si NO VIENE CON CLASIFICACION de RIESGO DE MERCADO
          if (Trim(sClasif_Riesgo) = '') and
             (Trim(FieldByName('Incluye_SIN_Clasif').asString) <> 'S') then
          begin
            Inserta_Errores('Clasificación de Riesgo ',
                            'No Existe Clasif.de Riesgo( Valorización )' +
                            ' Emisor : ' + Qry_General.FieldByName('Emisor').asString +
                            ' Instrumento : ' + Qry_General.FieldByName('Instrumento').asString +
                            ' Serie : ' + Qry_General.FieldByName('Serie').asString +
                            ' Nemotecnico : ' + Qry_General.FieldByName('Nemotecnico').asString);
            Next;
            Continue;
          end;

          if (Trim(sClasif_Riesgo) <> '') then
          begin
            if Not Aplica_Operacion_Clasif_Riesgo_Mem(sClasif_Riesgo,
                                                      FieldByName('Clasif_Riesgo_rtpr').asString,
                                                      FieldByName('Operacion').asString,
                                                      'N',
                                                      ' ',
                                                      sModulo_Error,
                                                      sString_Error) then
            begin
              Next;
              Continue;
            end;
          end
          else
          begin
            if Not (Qry_Limites_Det.FieldByName('Incluye_SIN_Clasif').asString = 'S') then
            begin
              Next;
              Continue;
            end;
          end;

//          if Not((Trim(Qry_General.FieldByName('Incluye_SIN_Clasif').asString) = 'S') and
//            (Trim(sClasif_Riesgo) <> '')) then(
//          if Not Aplica_Operacion_Clasif_Riesgo_Mem(sClasif_Riesgo,
//                                                    FieldByName('Clasif_Riesgo_rtpr').asString,
//                                                    FieldByName('Operacion').asString,
//                                                    'N',
//                                                    ' ',
//                                                    sModulo_Error,
//                                                    sString_Error) then
//          begin
//            Next;
//            Continue;
//          end;
        end;
      end;

      /// 02/08/2016    DC
      if (Trim(FieldByName('TipoClasif_Emisor').asString) <> '') and
         (FieldByName('Nodo_emisor').asFloat <> 0) and
         (Trim(FieldByName('Operacion_Emisor').asString) <> '') then
      begin
        sNodos_Hijos_Instrumentos := Nodos_Hijos(FieldByName('TipoClasif_Emisor').asString,
                                                 FieldByName('Nodo_emisor').asFloat);

        fNodo_Clasif := 0;
        Pertenece_Clasificacion('EMISOR',
                                FieldByName('EMISOR').asString,
                                FieldByName('TipoClasif_Emisor').asString,
                                sNodos_Hijos_Instrumentos,
                                FieldByName('Operacion_Emisor').asString,
                                fNodo_Clasif);

        if fNodo_Clasif = 0 then
        begin
          Next;
          Continue;
        end;
      end;
      /// 02/08/2016    DC

      // Valido Clasificación de NEMOTECNICO SI EXISTE
      if (Trim(FieldByName('Codigo_Objeto').asString) <> '') and
          Not(FieldByName('Codigo_Objeto').IsNull) and (FieldByName('Nodo').asFloat <> 0) then
      begin
        fNodo_Clasif := 0;
        if Trim(FieldByName('Tipo_Instrum').asString) = 'R' then
          Determina_Nodo_Clasificacion('NEMRVAR',
                                       FieldByName('Nemotecnico').asString,
                                       FieldByName('Codigo_Objeto').asString,
                                       fNodo_Clasif)
        else
          Determina_Nodo_Clasificacion('NEMOTECNIC',
                                       FieldByName('Nemotecnico').asString,
                                       FieldByName('Codigo_Objeto').asString,
                                       fNodo_Clasif);
        if fNodo_Clasif <> FieldByName('Nodo').asFloat then
        begin
          Next;
          Continue;
        end;
      end;

      // Exluye Nemotecnicos que tengan clasificacion OIED  //        // 06-2021
      if (FieldByName('cod_obj_Excluye').asString <> '') and
          Not(FieldByName('cod_obj_Excluye').IsNull) and (FieldByName('Nodo_Excluye').asFloat <> 0) then
      begin
        if Qry_General.FieldByName('Tipo_Instrum').asString = 'R'
        then
          Determina_Nodo_Clasificacion('NEMRVAR',
                                       Qry_General.FieldByName('Nemotecnico').asString,
                                       FieldByName('cod_obj_Excluye').asString,
                                       fNodo_Clasif)
        else
          Determina_Nodo_Clasificacion('NEMOTECNIC',
                                       Qry_General.FieldByName('Nemotecnico').asString,
                                       FieldByName('cod_obj_Excluye').asString,
                                       fNodo_Clasif);
        if fNodo_Clasif = FieldByName('Nodo_Excluye').asFloat then
          begin
            Next;
            Continue;
          end;
      end;

      if not(FieldByName('OPERADOR_MOTIVO').IsNull) AND not(FieldByName('MOTIVO_INV').IsNull) THEN
      begin
        if FieldByName('OPERADOR_MOTIVO').asString = '=' then
        begin
          if (FieldByName('MOTIVO').asString <> FieldByName('MOTIVO_INV').asString) then
            begin
              Next;
              Continue;
            end;
        end
        else
        begin
          if FieldByName('OPERADOR_MOTIVO').asString = 'IN' then
          begin
            for i := 1 to 200 do
              String_Arr[i] := '';
            sAux_String     := FieldByName('MOTIVO_INV').asString;
            Separa_Campos_String(',',
                                 '@',
                                 sAux_String,
                                 String_Arr);
            i         := 1;
            bEncontro := False;
            while (String_Arr[i] <> '') and (i < 200) do
            begin
              if (FieldByName('MOTIVO').asString = String_Arr[i]) then
              begin
                bEncontro := True;
                break;
              end;
              i           := i + 1;
              sAux_String := String_Arr[i];
            end;
            if NOT bEncontro then
            begin
              Next;
              Continue;
            end;
          end;
        end;
      end;

      // 23-07-2021
      if not(FieldByName('PORCENTAJE_MAX').IsNull) AND
         not(FieldByName('BASE_RELACION').IsNull) AND
         (Trim(FieldByName('BASE_RELACION').asString) <> '') then
      begin
        if FieldByName('BASE_RELACION').asString = 'RELDEUGAR' then
        begin
          bNominal := false;

          iMeses := Qry_RTPR_Det.fieldByName('meses').AsInteger;
          DecodeDate(FieldByName('fecha_emision').AsDateTime,aa,mm,dd);
          inc(mm,iMeses);

          if mm > 12 then
          begin
            mm := mm -12;
            inc(aa);
          end;
          dFecha_emision := EncodeDAte(aa,mm,dd);

          if dFecha_emision > dFecha_Cierre then
             bNominal := true;

          Determina_Relacion_Deuda_Garantia(dFecha_Cierre,
                                            FieldByName('Empresa').asString,
                                            FieldByName('TRANSACCION').asString,
                                            FieldByName('FOLIO_INTERNO').asString,
                                            FieldByName('ITEM_OMD').asFloat,
                                            iMeses,
                                            bNominal,
                                            FieldByName('valor_nominal').asFloat,
                                            fPorcentaje_Deuda_Garantia,
                                            sModulo_Error,
                                            sString_Error,
                                            Result);
          if NOT Result then
          begin
            Inserta_Errores(sModulo_Error,
                            sString_Error);
            Next;
            Continue;
          end;

          fPorcentaje_max := qry_general.FieldByName('PORCENTAJE_MAX').asFloat;
          if (fPorcentaje_Deuda_Garantia > fPorcentaje_max) then //qry_general.FieldByName('PORCENTAJE_MAX').asFloat) then
          begin
            Next;
            Continue;
          end;
        end;
      end;

      // Valido SI Incluye NO ELEGIBLES  GGARCIA 24/04/2008
      // Se reemplaza con fecha 14-10-2021 F.I
      // =======================================================
      {
      if bSBS and (sTipo_Limite <> 'T')
      then
        if (Trim(FieldByName('Incluye_No_Elegibles').asString) = 'S')
        then
          Begin
            sdescripcion_nodo := '';
            if FieldByName('Tipo_Instrum').asString = 'R'
            then
              sdescripcion_nodo := Clasificacion_Objeto(
                                                        'NEMRVAR',
                                                        FieldByName('Nemotecnico').asString,
                                                        'ELEGIBLE')
            else
              sdescripcion_nodo := Clasificacion_Objeto(
                                                        'NEMOTECNIC',
                                                        FieldByName('Nemotecnico').asString,
                                                        'ELEGIBLE');
            if BuscaStr('NE', sdescripcion_nodo)
            then
              begin
                Next;
                Continue;
              end;

          End;
      }

      if ((bValida_No_Elegible) and (sTipo_Limite <> 'T')) then
      begin
        if not (Trim(FieldByName('Incluye_No_Elegibles').asString) = 'S') then
        Begin
          sdescripcion_nodo := '';
          if FieldByName('Tipo_Instrum').asString = 'R' then
            sdescripcion_nodo := Clasificacion_Objeto( 'NEMRVAR',
                                                       FieldByName('Nemotecnico').asString,
                                                       sClasif_Elegible)
          else
            sdescripcion_nodo := Clasificacion_Objeto( 'NEMOTECNIC',
                                                       FieldByName('Nemotecnico').asString,
                                                       sClasif_Elegible);
          if BuscaStr(sdescripcion_nodo,'NE') then
          begin
            Next;
            Continue;
          end;
        End;
      end;

      // Determino_Emisor Pagador
      sEmisor_Pagador := '';
      sEmisor         := FieldByName('Emisor').asString;
      Emisor_Pagador_Mem( dFecha_Cierre,
                          sEmisor,
                          FieldByName('Instrumento').asString, //'',
                          sEmisor_Pagador,
                          Result);

      if (Trim(sEmisor) <> Trim(sEmisor_Pagador)) and (Trim(sEmisor_Pagador) <> '') then
        sEmisor := Trim(sEmisor_Pagador);

      // Agrego grupo al que pertenece el emisor
      Qry_EstadoEMI.Close;
      Qry_EstadoEMI.Parambyname('Emisor').asString := sEmisor;
      Qry_EstadoEMI.Parambyname('Fecha').AsDate    := dFecha_Cierre;
      Qry_EstadoEMI.Open;

      sGrupo_Emisor := '';
      if Not Qry_EstadoEMI.FieldByName('Grupo_Emisor').IsNull then
        sGrupo_Emisor := Qry_EstadoEMI.FieldByName('Grupo_Emisor').asString;

      Qry_EstadoEMI.Close;

      if (bImplica_Emigrupo) and (Trim(sGrupo_Emisor) = '') then
        Inserta_Errores(  'Clasif.Grupo Emisor',
                          ' No existe clasif. de grupo para emisor: '
                          + sEmisor
                          + ' Instrumento: '
                          + FieldByName('Instrumento').asString
                          + ' Serie: '
                          + FieldByName('Serie').asString);

      /// / DC 02/08/2016
      if bImplica_EmiClasif then
      begin
        fNodo_Clasif := 0;
        Determina_Nodo_Clasificacion('EMISOR',
                                     sEmisor,
                                     sTipoClasif_Emisor,
                                     fNodo_Emiclasif);

        if fNodo_Emiclasif = 0 then
          Inserta_Errores('Clasif. Emisor ',
                          ' No Existe Clasif. para emisor: '
                          + sEmisor
                          + ' Clasificación: '
                          + sTipoClasif_Emisor);
      end;
      /// / DC 02/08/2016

      fValor_Final_SVS_MC := FieldByName('Valor_Final_SVS_MC').asFloat;
      fValor_Pte_MC_Cpa   := FieldByName('Valor_Pte_MC_Cpa').asFloat;
      fValor_Pte_MC_Mdo   := FieldByName('Valor_Pte_MC_Mdo').asFloat;
      fValor_Pte_MC_Mix   := FieldByName('Valor_Pte_MC_Mix').asFloat;

      if Trim(sMoneda_Nacional) <> Trim(FieldByName('Moneda_Informe').asString) then
      begin
        fValor_Cambio := 0;
        Leer_Valor_Cambio2_Mem(FieldByName('Moneda_Informe').asString,
                               sMoneda_Nacional,
                               'BC',
                               dFecha_Cierre,
                               fValor_Cambio,
                               Result);
        if not Result then
        begin
          Inserta_Errores('Proceso Limite',
                          'No se encontro Tipo Cambio, Fecha - Moneda ' + DateToStr(dFecha_Cierre) + ' - ' + FieldByName('Moneda_Informe').asString);
          Next;
          Continue;
        end;

        fValor_Final_SVS_MC := fValor_Final_SVS_MC * fValor_Cambio;
        fValor_Pte_MC_Cpa   := fValor_Pte_MC_Cpa * fValor_Cambio;
        fValor_Pte_MC_Mdo   := fValor_Pte_MC_Mdo * fValor_Cambio;
        fValor_Pte_MC_Mix   := fValor_Pte_MC_Mix * fValor_Cambio;
      end;

      T_TmpDatos.insert;
      T_TmpDatos.FieldByName('Empresa').asString           := FieldByName('Empresa').asString;
      T_TmpDatos.FieldByName('Cartera').asString           := FieldByName('Cartera').asString;
      T_TmpDatos.FieldByName('Transaccion').asString       := FieldByName('Transaccion').asString;
      T_TmpDatos.FieldByName('Folio_interno').asString     := FieldByName('Folio_interno').asString;
      T_TmpDatos.FieldByName('Item_OMD').asFloat           := FieldByName('Item_OMD').asFloat;
      T_TmpDatos.FieldByName('Nemotecnico').asString       := FieldByName('Nemotecnico').asString;
      T_TmpDatos.FieldByName('Emisor_Original').asString   := FieldByName('Emisor').asString;;
      T_TmpDatos.FieldByName('Emisor').asString            := sEmisor;
      T_TmpDatos.FieldByName('Instrumento').asString       := FieldByName('Instrumento').asString;
      T_TmpDatos.FieldByName('Tipo_Instrum').asString      := FieldByName('Tipo_Instrum').asString;
      T_TmpDatos.FieldByName('Serie').asString             := FieldByName('Serie').asString;
      T_TmpDatos.FieldByName('Valor_Nominal').asFloat      := FieldByName('Valor_Nominal').asFloat;
      T_TmpDatos.FieldByName('Saldo_Insoluto').asFloat     := FieldByName('Saldo_Insoluto').asFloat;
      T_TmpDatos.FieldByName('Presencia_Bursatil').asFloat := FieldByName('Presencia_Bursatil').asFloat;
      T_TmpDatos.FieldByName('Valor_Final_svs_mc').asFloat := fValor_Final_SVS_MC;
      T_TmpDatos.FieldByName('Valor_Pte_mc_Cpa').asFloat   := fValor_Pte_MC_Cpa;
      T_TmpDatos.FieldByName('Valor_Pte_mc_Mdo').asFloat   := fValor_Pte_MC_Mdo;
      T_TmpDatos.FieldByName('Valor_Pte_mc_Mix').asFloat   := fValor_Pte_MC_Mix;
      T_TmpDatos.FieldByName('Clasif_Riesgo').asString     := sClasif_Riesgo;
      T_TmpDatos.FieldByName('Moneda_Instrum').asString    := FieldByName('Moneda_Instrum').asString;
      T_TmpDatos.FieldByName('Codigo_RTPR').asString       := Qry_RTPR_Det.FieldByName('Codigo_RTPR').asString;
      T_TmpDatos.FieldByName('Grupo_Emisor').asString      := sGrupo_Emisor;
      T_TmpDatos.FieldByName('Tipo_Clasif').asString       := sTipoClasif_Emisor;
      T_TmpDatos.FieldByName('Grupo_Clasif').asFloat       := fNodo_Emiclasif;
      T_TmpDatos.FieldByName('Motivo').asString            := FieldByName('Motivo').asString;
      T_TmpDatos.FieldByName('Duration').asFloat           := FieldByName('Duration').asFloat;
      if (Qry_General.FieldByName('Fecha_Operacion').asString <> '0') or (Qry_General.FieldByName('Fecha_Operacion').IsNull) then
      begin
        T_TmpDatos.FieldByName('Fecha_Operacion').AsDateTime := Qry_General.FieldByName('Fecha_Operacion').AsDateTime;
        T_TmpDatos.FieldByName('Fecha_Emision').AsDateTime   := Qry_General.FieldByName('Fecha_Emision').AsDateTime;
        T_TmpDatos.FieldByName('Fecha_Vcto').AsDateTime      := Qry_General.FieldByName('Fecha_Vcto').AsDateTime;
      end;
      T_TmpDatos.FieldByName('CREDENCIAL_DEUDOR').asString := FieldByName('CREDENCIAL_DEUDOR').asString;
      T_TmpDatos.FieldByName('NOMBRE_DEUDOR').asString     := FieldByName('NOMBRE_DEUDOR').asString;
      T_TmpDatos.FieldByName('Tipo_Grupo').asString        := sTipo_Limite;
      T_TmpDatos.FieldByName('Id_Credito').asString        := FieldByName('Id_Credito').asString;
      Try
        T_TmpDatos.Post;
      except
        Application.MessageBox('Error al Insertar en Tabla Temporal(Datos Mercado)',
                                Pchar(Caption),
                                Mb_Ok);
        Close;
        Exit;
      end;
      Next;
    end;
    Close;
  end;
  ProgressBar2.Max         := 0;
  ProgressBar2.Position    := 0;
  Lbl_Avance2.Caption      := ' ';
  LabelPorcentaje2.Caption := '';
  Application.ProcessMessages;
end;

procedure TFrmCalculoLimites.BTN_GestionClick(Sender: TObject);
  var
    i                 : Integer;
    bExiste_Formulario: Boolean;
    aux_pchar         : Array [0 .. 250] of Char;
  begin
    if (T_TmpDatosLimite.RecordCount > 0) then
    begin
      strpcopy(aux_pchar,
               '¡No se ha grabado ultimo proceso!'#10 + Caption + ''#10 + 'No se pueden Visualizar los Resultados!!');
      Application.MessageBox(aux_pchar,
                             Pchar(Caption),
                             Mb_Ok + MB_IconError);
      Exit;
    end;

    bExiste_Formulario := False;
    For i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TForm then
        if TForm(Components[i]).Name = 'FrmDatosLimites' then
        begin
          bExiste_Formulario := True;
          break;
        end;
    end;

    if Not bExiste_Formulario then
    begin
      FrmDatosLimites       := TFrmDatosLimites.create(FrmCalculoLimites);
      FrmDatosLimites.Left  := 0;
      FrmDatosLimites.Top   := 20;
      FrmDatosLimites.Width := 1290;
      FrmDatosLimites.Show;
    end;
  end;

procedure TFrmCalculoLimites.Calculo_Filiales(
  fTotal_Porcentaje    : Double;
  fTotal_Porcentaje_Min: Double);
  var
    i               : Integer;
    fValor_Holding  : Double;
    bExisten_Valores: Boolean;
  begin
    // Fundo todo en la matriz
    for i := 0 to VarArrayHighBound(Reg_Emisores.Emisor, 1) do
    begin
      fValor_Holding := 0;
      if Reg_Emisores.Emisor_Matriz[i] <> '' then
      begin
        With Qry_General do
        begin
          // Rescato Empresas Asociadas
          Close;
          Sql.Clear;
          Sql.Add('SELECT DISTINCT a.EMISOR '
                + '  FROM QS_FIN_ESTADO_EMI a '
                + ' WHERE (a.Matriz = :Matriz OR a.Emisor = :Matriz) '
                + '   AND a.GRUPO_EMISOR <> ''SIN CLASIFICACION''  '   // ===> No se consideran los SIN CLASIF F.I.  09-08-2021
                + '   AND a.GRUPO_EMISOR <> ''SIN CLASIF''  '   // ===> No se consideran los SIN CLASIF F.I.  09-08-2021
                + '   AND a.Fecha_Desde = (SELECT max(fecha_desde) '
                + '                          FROM QS_FIN_ESTADO_EMI b '
                + '                          WHERE (b.Matriz = :Matriz OR b.MATRIZ IS NULL) '
                + '                            AND b.emisor = a.emisor '
                + '                            AND Fecha_Desde <=  :Fecha ) '
                + '   AND (a.Fecha_Hasta IS NULL OR a.Fecha_Hasta >= :Fecha) ');

          Parambyname('Matriz').asString := Reg_Emisores.Emisor_Matriz[i];
          Parambyname('Fecha').AsDate    := dFecha_Cierre;
          Open;

          bExisten_Valores := False;
          While Not eof do
          begin
            fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje').asFloat;
            if (Qry_Limites.FieldByName('Relacion_Cia').asString = 'GRUPO') and
               (sGrupo_Emisor_Cartera <> '') and
               (sGrupo_Emisor_Cartera = Reg_Emisores.Grupo_Emisor[i]) then
              fPorcentaje_Limite := Qry_Limites.FieldByName('Porcentaje_Cia').asFloat;

            // Rescato Valor y Borro Valores de Filiales
            Qry_Prdx.Sql.Clear;
            Qry_Prdx.Sql.Add(' SELECT Valor_Pte_Cartera FROM '
                            + T_TmpLimites.Name
                            + ' WHERE Emisor = :Emisor'
                            +'    AND codigo_limite = :codigo_limite ');
            Qry_Prdx.Parambyname('Emisor').asString := FieldByName('Emisor').asString;
            Qry_Prdx.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
            Qry_Prdx.Open;

            if Not Qry_Prdx.FieldByName('Valor_Pte_Cartera').IsNull then
              fValor_Holding := fValor_Holding + Qry_Prdx.FieldByName('Valor_Pte_Cartera').asFloat;

            // Borro Encabezado del Emisor (cambio , solo lo marco para borrarlo abajo)
            Qry_Prdx.Close;
            Qry_Prdx.Sql.Clear;
            Qry_Prdx.Sql.Add(' UPDATE ' + T_TmpLimites.Name
                              + ' SET Matriz       = ''XXXXXXXXXX'' '
                              + ' WHERE Emisor = :Emisor '
                              +'    AND codigo_limite = :codigo_limite '
                              + '   AND Matriz is null ');

            Qry_Prdx.Parambyname('Emisor').asString := FieldByName('Emisor').asString;
            Qry_Prdx.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
            try
              Qry_Prdx.ExecSql;
            except
              on E: EFDDBEngineException do
                begin
                  ShowError(E);
                end;
            end;
            Qry_Prdx.Close;

            // Actualizo Matriz en el Detalle
            if Reg_Emisores.Emisor_Matriz[i] <> FieldByName('Emisor').asString then
            begin
              Qry_Prdx.Close;
              Qry_Prdx.Sql.Clear;
              Qry_Prdx.Sql.Add(' UPDATE  ' + T_TmpDatosLimite.Name
                                + ' SET Matriz   = :Matriz'
                                + ' WHERE Emisor = :Emisor '
                                +'    AND codigo_limite = :codigo_limite ');
              Qry_Prdx.Parambyname('Matriz').asString := Reg_Emisores.Emisor_Matriz[i];
              Qry_Prdx.Parambyname('Emisor').asString := FieldByName('Emisor').asString;
              Qry_Prdx.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
              try
                Qry_Prdx.ExecSql;
              except
                on E: EFDDBEngineException do
                  begin
                    ShowError(E);
                  end;
              end;
              Qry_Prdx.Close;
            end;

            Next;
            bExisten_Valores := True;
          end;

          // Inserto Encabezado con el Total de la Matriz
          if (bExisten_Valores) and (fValor_Holding > 0) then
          begin
            if Qry_Limites.FieldByName('CODIGO_PORCENTAJE').asString = 'MONTORESER' then
            begin
              fValor_Pte_Limite := Redondeo_Moneda_Mem(
                sMoneda_Cartera,
                dFecha_Cierre,
                (fTotal_Porcentaje * fPorcentaje_Limite / 100));
              fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(
                sMoneda_Cartera,
                dFecha_Cierre,
                (fTotal_Porcentaje_Min * fPorcentaje_Limite_Min / 100));
            end
            else
            begin
              fValor_Pte_Limite := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                       dFecha_Cierre,
                                                       ((fReserva_Tecnica + fPatrimonio_Riesgo) * fPorcentaje_Limite / 100));
              fValor_Pte_Limite_Min := Redondeo_Moneda_Mem(sMoneda_Cartera,
                                                           dFecha_Cierre,
                                                           ((fReserva_Tecnica + fPatrimonio_Riesgo) * fPorcentaje_Limite_Min / 100));
            end;
            T_TmpLimites.insert;
            T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
            T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
            T_TmpLimites.FieldByName('Grupo_Emisor').asString     := '';
            T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
            T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
            T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := fValor_Holding;
            T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fValor_Pte_Limite_Min;
            T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fValor_Pte_Limite;
            T_TmpLimites.FieldByName('Margen').asFloat            := fValor_Pte_Limite - fValor_Holding;
            T_TmpLimites.FieldByName('Matriz').asString           := Reg_Emisores.Emisor_Matriz[i];
            T_TmpLimites.FieldByName('Emisor').asString           := Reg_Emisores.Emisor_Matriz[i];
            T_TmpLimites.Post;
          end;
          Close;
        end;
      end;
    end;

    // Borro del Encabezado lo Marcado
    Qry_Prdx.Close;
    Qry_Prdx.Sql.Clear;
    Qry_Prdx.Sql.Add(' DELETE FROM ' + T_TmpLimites.Name
                    + ' WHERE Matriz = ''XXXXXXXXXX'' '
                    +'    AND codigo_limite = :codigo_limite ');

    Qry_Prdx.Parambyname('codigo_limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;

    try
      Qry_Prdx.ExecSql;
    except
      on E: EFDDBEngineException do
        begin
          ShowError(E);
        end;
    end;
    Qry_Prdx.Close;

  end;

procedure TFrmCalculoLimites.Ed_FechaExit(Sender: TObject);
  begin
    if (not bMuestra) or (sTipo_Limite = 'T') then
      Exit;

    if Trim(sProceso) = 'NORMATIVO' then
    begin
      Qry_Cns.Close;
      Qry_Cns.Sql.Clear;
      Qry_Cns.Sql.Add('SELECT * FROM QS_SUP_1835_B1'
                    + ' WHERE fecha_proceso = :fecha_proceso '
                    + '   AND empresa       = :empresa ');
      Qry_Cns.Parambyname('fecha_proceso').AsDate := Ed_Fecha.Date;;
      Qry_Cns.Parambyname('empresa').asString     := sEmpresa_Usuario;
      try
        Qry_Cns.Open;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
          end;
      end;

      if Qry_Cns.RecordCount = 0 then
      begin
        Application.MessageBox(
          'No Existe Proceso Normativo 1835',
          'Procesos',
          Mb_Ok);
        Ed_Fecha.Text := '';
        Exit;
      end;
      Qry_Cns.Close;
    end;

  end;

procedure TFrmCalculoLimites.Ed_ProcesoChange(Sender: TObject);
  begin
    if (not bMuestra) or (sTipo_Limite = 'T') then
      Exit;

    sProceso := Ed_Proceso.Text;

    if Trim(sProceso) = 'NORMATIVO' then
    begin
      Application.MessageBox('Proceso Normativo Requiere Archivos B de SVS',
                             'Procesos',
                              Mb_Ok);
    end;

    sNorma   := '';
    bNoGrupo := False;
    if Trim(Combo_Cartera.Text) = '' then
    begin
      bMuestra           := False;
      Chk_Carteras.State := cbUnChecked;
      bMuestra           := True;
      Combo_Cartera.Text := '';
    end;
    Chk_Carteras.enabled  := True;
    Combo_Cartera.enabled := True;

    Existe_param_proceso('NOGRUPO',
                         sEmpresa_Usuario,
                         sProceso,
                         Result);
    if Result then
      bNoGrupo := True;

    if (Ed_Proceso.Text = 'SBS-1041') then
    begin
      FrmCalculoLimites.Height := 458;
      Panel5.enabled           := True;
      Panel5.visible           := True;
      Label1.visible           := False;
      Ed_Fecha.visible         := False;
      BTN_Buscar.visible       := False;
      BTN_Buscar_Inver.visible := True;
      BTN_Buscar_Inver.Left    := 209;
      sNorma                   := '1041';
    end
    else
    begin
      if (Ed_Proceso.Text = 'SBS-11052') then
      begin
        FrmCalculoLimites.Height := 458;
        Panel5.enabled           := True;
        Panel5.visible           := True;
        Label1.visible           := False;
        Ed_Fecha.visible         := False;
        BTN_Buscar.visible       := False;
        BTN_Buscar_Inver.visible := True;
        BTN_Buscar_Inver.Left    := 209;
        sNorma                   := '11052';
      end
      else
      begin
        FrmCalculoLimites.Height      := 350;
        Panel5.enabled                := False;
        Panel5.visible                := False;
        Label1.visible                := True;
        Group_Moneda_Conversion.Width := 188;
        Panel3.Width                  := 221;
        Ed_Fecha.visible              := True;
        if bSBS then
        begin
          BTN_Buscar.visible       := False;
          BTN_Buscar_Inver.visible := True;
        end
        else
        begin
          BTN_Buscar.visible       := True;
          BTN_Buscar_Inver.visible := False;
        end;
      end;
    end;

    if bNoGrupo then
    begin
      bMuestra              := False;
      Chk_Carteras.State    := cbChecked;
      bMuestra              := True;
      Combo_Cartera.Text    := 'CONSOLIDA';
      Chk_Carteras.enabled  := False;
      Combo_Cartera.enabled := False;
      Llena_Carteras_Lim(sProceso);
    end;

  end;

procedure TFrmCalculoLimites.Ed_ProcesoNotInList(
  Sender     : TObject;
  LookupTable: TDataSet;
  NewValue   : string;
  var Accept : Boolean);
  begin

    if not(NewValue = '') then
      begin
        Application.MessageBox(
          '¡Código Incorrecto!',
          'Procesos',
          Mb_Ok);
        Ed_Proceso.Text := '';
        Exit;
      end;

  end;

Function TFrmCalculoLimites.Emisor_Matriz(sEmisor: String): String;
begin
  Emisor_Matriz := '';
  with Qry_General do
  begin
    Close;
    Sql.Clear;
    Sql.Add(' SELECT Matriz FROM QS_FIN_ESTADO_EMI'
          + ' WHERE Matriz = :Matriz'
          + ' AND Fecha_Desde <= :Fecha'
          + ' AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha) ');
    Parambyname('Matriz').asString := sEmisor;
    Parambyname('Fecha').AsDate    := dFecha_Cierre;
    Open;

    if Not FieldByName('Matriz').IsNull then
      Emisor_Matriz := FieldByName('Matriz').asString;
    Close;
  end;
end;

Procedure TFrmCalculoLimites.Carga_Serie_Vigentes;
var
  i,j                                           : Integer;
  sCODIGO_EMISOR, sCODIGO_INSTRUMENTO, sSeries: String;
  dFecha                                      : TdateTime;
  String_Arr                                  : TArr100_String;
  cSeparador   : Char;
begin
  // Rescato Ultima definición Vigente
  with Qry_General do
  begin
    Close;
    Sql.Clear;
    // SQL.Add('SELECT CODIGO_EMISOR'
    // +'      ,CODIGO_INSTRUMENTO'
    // +'      ,SERIES'
    // +'      ,FECHA_VIGENCIA'
    // +'      ,MONTO_INSCRIPCION'
    // +'      ,MONEDA_INSCRIPCION'
    // +' FROM QS_FIN_INSCRIPCION'
    // +' WHERE Fecha_Vigencia <= :Fecha'
    // +' GROUP BY'
    // +'       CODIGO_EMISOR'
    // +'      ,CODIGO_INSTRUMENTO'
    // +'      ,SERIES'
    // +'      ,FECHA_VIGENCIA'
    // +'      ,MONTO_INSCRIPCION'
    // +'      ,MONEDA_INSCRIPCION'
    // +' ORDER BY'
    // +'       CODIGO_EMISOR'
    // +'      ,CODIGO_INSTRUMENTO'
    // +'      ,SERIES'
    // +'      ,FECHA_VIGENCIA'
    // );

    Sql.Add('SELECT a.CODIGO_EMISOR'
          + '      ,a.CODIGO_INSTRUMENTO'
          + '      ,a.SERIES'
          + '      ,a.FECHA_VIGENCIA'
          + '      ,SUM(a.MONTO_INSCRIPCION) as MONTO_INSCRIPCION'
          + '      ,a.MONEDA_INSCRIPCION'
          + '      FROM QS_FIN_INSCRIPCION a '
          + '      WHERE A.FECHA_VIGENCIA = (SELECT MAX(b.FECHA_VIGENCIA)   '
                         + '    	 	   	    FROM QS_FIN_INSCRIPCION b       '
                         + '       					WHERE B.FECHA_VIGENCIA <= :Fecha'
                         + '       						AND B.SERIE = A.SERIE         '
                         + '       						AND B.CODIGO_INSTRUMENTO = A.CODIGO_INSTRUMENTO'
                         + '       						AND B.CODIGO_EMISOR = A.CODIGO_EMISOR) '
//       + ' WHERE Fecha_Vigencia <= :Fecha'
//       + ' GROUP BY CODIGO_EMISOR'
//       + '      ,CODIGO_INSTRUMENTO'
//       + '      ,SERIES'
//       + '      ,FECHA_VIGENCIA'
//       + '      ,MONTO_INSCRIPCION'
//       + '      ,MONEDA_INSCRIPCION'
         + ' GROUP BY CODIGO_EMISOR'
          + '      ,CODIGO_INSTRUMENTO'
          + '      ,SERIES'
          + '      ,FECHA_VIGENCIA'
          + '      ,MONEDA_INSCRIPCION'
          + ' ORDER BY FECHA_VIGENCIA DESC'
          + '      ,CODIGO_EMISOR'
          + '      ,CODIGO_INSTRUMENTO'
          + '      ,SERIES ');

    Parambyname('Fecha').AsDate := dFecha_Cierre;
    Open;
    i := RecordCount;
    if i > 0 then
      i := i - 1;

    Reg_Series_Inscritas.CODIGO_EMISOR      := VarArrayCreate([0, i],varOleStr);
    Reg_Series_Inscritas.CODIGO_INSTRUMENTO := VarArrayCreate([0, i],varOleStr);
    Reg_Series_Inscritas.Series             := VarArrayCreate([0, i],varOleStr);
    Reg_Series_Inscritas.MONTO_INSCRIPCION  := VarArrayCreate([0, i],varDouble);
    Reg_Series_Inscritas.MONEDA_INSCRIPCION := VarArrayCreate([0, i],varOleStr);
    i := 0;
    First;

    while Not eof do
    begin
      sCODIGO_EMISOR                             := FieldByName('CODIGO_EMISOR').asString;
      sCODIGO_INSTRUMENTO                        := FieldByName('CODIGO_INSTRUMENTO').asString;
      sSeries                                    := FieldByName('Series').asString;
      Reg_Series_Inscritas.CODIGO_EMISOR[i]      := sCODIGO_EMISOR;
      Reg_Series_Inscritas.CODIGO_INSTRUMENTO[i] := sCODIGO_INSTRUMENTO;
      Reg_Series_Inscritas.Series[i]             := sSeries;

///////////////
      cSeparador  := ',';
      Separa_Campos_String(cSeparador,'"',sSeries, String_Arr);
      j:= 1;
      while String_Arr[j] <> '' do
      begin
         Matriz_Serie[i,j] := trim(String_Arr[j]);
         j := j + 1;
      end;
//////////////

      dFecha := solo_fecha(FieldByName('FECHA_VIGENCIA').AsDateTime);
      while (not eof) and (sCODIGO_EMISOR = FieldByName('CODIGO_EMISOR').asString) and
            (sCODIGO_INSTRUMENTO = FieldByName('CODIGO_INSTRUMENTO').asString) and
            (sSeries = FieldByName('Series').asString) do
      begin
        if solo_fecha(FieldByName('Fecha_Vigencia').AsDateTime) >= dFecha then
        begin
          if (TRIM(FieldByName('MONEDA_INSCRIPCION').asString) = '') or
              FieldByName('MONEDA_INSCRIPCION').IsNull                then
          begin
              Inserta_Errores( 'Inscripción Series',
                               'No se encontro moneda para emisor: '
                               +sCODIGO_EMISOR
                               +' instrumento: '
                               +sCODIGO_INSTRUMENTO
                               +' serie: '
                               +sSeries
                               +' ('
                               + DateToStr(FieldByName('Fecha_Vigencia').AsDateTime)
                               +')'
                               );
              Reg_Series_Inscritas.MONEDA_INSCRIPCION[i] := sMoneda_Nacional;
          end
          else
              Reg_Series_Inscritas.MONEDA_INSCRIPCION[i] := FieldByName('MONEDA_INSCRIPCION').asString;

          Reg_Series_Inscritas.MONTO_INSCRIPCION[i]  := FieldByName('Monto_Inscripcion').asFloat;
        end;
        Next;
      end;
      Inc(i);
    end;
    Close;
  end;
end;

Procedure TFrmCalculoLimites.Determina_Inscripcion(sEmisor,
                                                  sInstrumento,
                                                  sSerie,
                                                  sMoneda_Instrum: String;
                                                  Var sSeries                                   : String;
                                                  Var fMonto_Inscrito                           : Double);
var i, j: Integer;
begin
  fMonto_Inscrito := 0;
  for i := 0 to VarArrayHighBound(Reg_Series_Inscritas.Series, 1) do
    begin
      if (Reg_Series_Inscritas.CODIGO_EMISOR[i] = sEmisor) and
         (Reg_Series_Inscritas.CODIGO_INSTRUMENTO[i] = sInstrumento) then
      begin
         j := 1;
         while Matriz_Serie[i,j] <> '' do
         begin
           if Matriz_Serie[i,j] = sSerie then
           begin
             fValor_Cambio := 1;
             if Reg_Series_Inscritas.MONEDA_INSCRIPCION[i] <> sMoneda_Instrum then
               // sMoneda_Nacional then //
             begin
               Leer_Valor_Cambio2_Mem( Reg_Series_Inscritas.MONEDA_INSCRIPCION[i],
                                       sMoneda_Instrum,
                                       'BC',
                                       dFecha_Cierre,
                                       fValor_Cambio,
                                       Result);
             end;
             fMonto_Inscrito := Reg_Series_Inscritas.MONTO_INSCRIPCION[i] / fValor_Cambio;
             sSeries         := Reg_Series_Inscritas.Series[i];    //Matriz_Serie[i,j]; //Reg_Series_Inscritas.Series[i];
             break;
           end;
           j:= j + 1;
         end;
      end;
    end;
end;

procedure TFrmCalculoLimites.Calculo_Emisiones;
var
  fMinimo_Permitido, fMaximo_Permitido, fMargen: Double;
begin
  With Qry_Prdx do
    begin
      // Rescato Valores Afectados Por Emisión
      Close;
      Sql.Clear;
      Sql.Add('SELECT Emisor'
            + '      ,Instrumento'
            + '      ,Series_Inscritas'
            + '      ,Monto_Inscrito '
            + '      ,SUM(Valor_Nominal)    as Valor_Nominal'
            +'      ,SUM(Valor_Pte_mc_Cpa) as Valor_Emision'
            + '  FROM ' + T_TmpDatosLimite.Name
            + ' WHERE Valor_Pte_mc_Cpa <> 0'
            + '  AND  Codigo_Limite = :Codigo_Limite'
            + ' GROUP BY Emisor'
            + '         ,Instrumento'
            + '         ,Series_Inscritas'
            + '         ,Monto_Inscrito'
            + ' HAVING SUM(Valor_Pte_mc_Cpa) <> 0'
            + ' ORDER BY EMISOR,INSTRUMENTO');

      Parambyname('Codigo_Limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
      Open;
      While Not eof do
        begin
          if (FieldByName('Monto_Inscrito').asFloat <> 0) and (FieldByName('Valor_Emision').asFloat <> 0) then
            begin
              T_TmpLimites.insert;
              T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
              T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
              T_TmpLimites.FieldByName('Emisor').asString           := FieldByName('Emisor').asString;
              T_TmpLimites.FieldByName('Instrumento').asString      := FieldByName('Instrumento').asString;
              T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
              T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
              T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := FieldByName('Valor_Nominal').asFloat;

              if (FieldByName('Valor_Nominal').asFloat) > (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100) then
                begin
                  fMargen           := ((FieldByName('Valor_Nominal').asFloat) - (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100));
                  fMaximo_Permitido := FieldByName('Valor_Nominal').asFloat - fMargen;
                end
              else
                begin
                  fMargen           := (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100) - FieldByName('Valor_Nominal').asFloat;
                  fMaximo_Permitido := (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100);
                end;

              fMinimo_Permitido := (fPorcentaje_Limite_Min * FieldByName('Monto_Inscrito').asFloat / 100);

              T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fMinimo_Permitido;
              T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fMaximo_Permitido;
              T_TmpLimites.FieldByName('Margen').asFloat            := fMargen;
              T_TmpLimites.FieldByName('Series_Inscritas').asString := FieldByName('Series_Inscritas').asString;
              T_TmpLimites.Post;
            end;
          Next;
        end;
      Close;

      // Borro lo que no me sirve
      Close;
      Sql.Clear;
      Sql.Add(' DELETE FROM ' + T_TmpDatosLimite.Name
            + ' WHERE Valor_Pte_mc_Cpa = 0'
            + '  AND  Codigo_Limite    = :Codigo_Limite');
      Parambyname('Codigo_Limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
      try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
          end;
      end;
      Close;
    end; // With
end;

procedure TFrmCalculoLimites.Calculo_Emisiones_VC;
var
  // i: Integer;
  // fValor_Holding,
  // fValor_Excedido,
  fMinimo_Permitido, fMaximo_Permitido, fMargen: Double;
begin
  With Qry_Prdx do
    begin
      // Rescato Valores Afectados Por Emisión
      Close;
      Sql.Clear;
      Sql.Add('SELECT Emisor'
            + '      ,Instrumento'
            + '      ,Series_Inscritas'
            + '      ,Monto_Inscrito'
            + '      ,SUM(Valor_Pte_mc_Cpa) as Valor_Emision'
            + '  FROM ' + T_TmpDatosLimite.Name +
          ' WHERE Valor_Pte_mc_Cpa <> 0'
          + '  AND  Codigo_Limite = :Codigo_Limite'
          + ' GROUP BY Emisor'
          + '         ,Instrumento'
          + '         ,Series_Inscritas'
          + '         ,Monto_Inscrito' +
          ' HAVING SUM(Valor_Pte_mc_Cpa) <> 0'
          + ' ORDER BY EMISOR,INSTRUMENTO');

      Parambyname('Codigo_Limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
      Open;
      While Not eof do
        begin
          if (FieldByName('Monto_Inscrito').asFloat <> 0) and (FieldByName('Valor_Emision').asFloat <> 0) then
            begin
              T_TmpLimites.insert;
              T_TmpLimites.FieldByName('Codigo_Limite').asString    := Qry_Limites.FieldByName('Codigo_Limite').asString;
              T_TmpLimites.FieldByName('Tipo_Limite').asString      := Qry_Limites.FieldByName('Tipo_Limite').asString;
              T_TmpLimites.FieldByName('Emisor').asString           := FieldByName('Emisor').asString;
              T_TmpLimites.FieldByName('Instrumento').asString      := FieldByName('Instrumento').asString;
              T_TmpLimites.FieldByName('Porcentaje_Min').asFloat    := fPorcentaje_Limite_Min;
              T_TmpLimites.FieldByName('Porcentaje').asFloat        := fPorcentaje_Limite;
              T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat := FieldByName('Valor_Emision').asFloat;

              if (FieldByName('Valor_Emision').asFloat) > (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100) then
                begin
                  fMargen           := ((FieldByName('Valor_Emision').asFloat) - (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100));
                  fMaximo_Permitido := FieldByName('Valor_Emision').asFloat - fMargen;
                end
              else
                begin
                  fMargen           := (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100) - FieldByName('Valor_Emision').asFloat;
                  fMaximo_Permitido := (fPorcentaje_Limite * FieldByName('Monto_Inscrito').asFloat / 100);
                end;

              fMinimo_Permitido := (fPorcentaje_Limite_Min * FieldByName('Monto_Inscrito').asFloat / 100);

              T_TmpLimites.FieldByName('Minimo_Permitido').asFloat  := fMinimo_Permitido;
              T_TmpLimites.FieldByName('Maximo_Permitido').asFloat  := fMaximo_Permitido;
              T_TmpLimites.FieldByName('Margen').asFloat            := fMargen;
              T_TmpLimites.FieldByName('Series_Inscritas').asString := FieldByName('Series_Inscritas').asString;
              T_TmpLimites.Post;
            end;
          Next;
        end;
      Close;

      // Borro lo que no me sirve
      Close;
      Sql.Clear;
      Sql.Add(' DELETE FROM ' + T_TmpDatosLimite.Name
            + ' WHERE Valor_Pte_mc_Cpa = 0'
            + '  AND  Codigo_Limite    = :Codigo_Limite');

      Parambyname('Codigo_Limite').asString := Qry_Limites.FieldByName('Codigo_Limite').asString;
      try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
          end;
      end;
      Close;
    end; // With
end;

procedure TFrmCalculoLimites.BTN_ImprimirClick(Sender: TObject);
var
  sRazon_Social, sDireccion, sUbicacion                           : String;
  Result                                                          : Boolean;
  Label_Razon_Social, Label_Direccion, Lbl_Titulo, Label_Ubicacion: TfrxMemoView;
begin
  Leer_Identidad_Direccion(
    sEmpresa_Usuario,
    fItem_Dir_Usuario,
    sRazon_Social,
    sDireccion,
    sUbicacion,
    Result);

  with TFrmRPreview.create(Self) do
    begin
      FrmReportErrores.T_Paradox.First;
      Table_excel := FrmReportErrores.T_Paradox;
      Table_Qry   := 1;
      with FrmReportErrores.Report_Errores do
        begin
          Label_Razon_Social      := FindObject('Label_Razon_Social') as TfrxMemoView;
          Label_Razon_Social.Text := sRazon_Social;
          Label_Direccion         := FindObject('Label_Direccion') as TfrxMemoView;
          Label_Direccion.Text    := sDireccion;
          Label_Ubicacion         := FindObject('Label_Ubicacion') as TfrxMemoView;
          Label_Ubicacion.Text    := sUbicacion;
          Lbl_Titulo              := FindObject('Lbl_Titulo') as TfrxMemoView;
          Lbl_Titulo.Text         := 'Errores Limites de Inversión Cartera ' + Combo_Cartera.Text + ' al ' + Ed_Fecha.Text;
          ReportOptions.Name      := 'Errores Limites de Inversión Cartera ' + Combo_Cartera.Text + ' al ' + Ed_Fecha.Text;
          Preview                 := frxPreview1;
          PrepareReport(True);
          PrintOptions.ShowDialog := True;
          ShowModal;
        end;
    end;
end;

procedure TFrmCalculoLimites.FormCloseQuery(Sender      : TObject;
                                            var CanClose: Boolean);
var
  aux_pchar: Array [0 .. 250] of Char;
begin
  if (T_TmpDatosLimite.RecordCount > 0) then
    begin
      strpcopy(aux_pchar,
              '¡No se ha grabado ultimo proceso!'#10 + Caption + ''#10 + '¿Desea Salir y perder los datos?');
      if Application.MessageBox(aux_pchar, Pchar(Caption), mb_YesNo + mb_DefButton2) = idNo then
        CanClose := False;
    end
  else
    CanClose := True;
end;

procedure TFrmCalculoLimites.BTN_CalcelarClick(Sender: TObject);
begin
  bAbortar := True;
end;

function TFrmCalculoLimites.Implica_BienesRaices(sCodigo_Limite: String) : Boolean;
begin
  with Qry_Limites_Det do
    begin
      Close;
      Parambyname('Codigo_Limite').asString := sCodigo_Limite;
      Open;

      Implica_BienesRaices := False;
      while Not eof do
        begin
          Busca_QS_NODO_Clasificacion(FieldByName('Clasif_251').asString,
                                      FieldByName('Nodo').asFloat,
                                      fQS_Nodo);

          Busca_Descripcion_Clasificacion_Padre(FieldByName('Clasif_251').asString,
                                                fQS_Nodo,
                                                1,
                                                sDescripcion_Padre);

          if (sDescripcion_Padre = 'BIENES RAICES') then
            begin
              Implica_BienesRaices := True;
              break;
            end;
          Next;
        end;
      Close;
    end;
end;

procedure TFrmCalculoLimites.BTN_SalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCalculoLimites.BTN_EliminarClick(Sender: TObject);
begin
  if Combo_Cartera.Text = '' then
    Exit;

  if Trim(Ed_Proceso.Text) = EmptyStr then
    begin
      Application.MessageBox(
        'Debe ingresar Tipo Límite',
        Pchar(Caption),
        Mb_Ok + MB_IconError);
      Ed_Proceso.Setfocus;
      Exit;
    end;

  if Application.MessageBox('¿ Confirma eliminación ?'
                           , Pchar(Caption)
                           , mb_OKCancel + mb_DefButton2 + Mb_IconQuestion) <> IDOK then
    Exit;

  With Qry_General do
    begin
      Close;
      Sql.Clear;
      Sql.Add('DELETE FROM QS_SUP_251 '
            + ' WHERE Empresa = :EMPRESA'
            + '  AND Proceso  = :Proceso'
            + '  AND Fecha_Proceso = :Fecha_Proceso');
      Parambyname('EMPRESA').asString     := sEmpresa_Usuario;
      Parambyname('Proceso').asString     := Ed_Proceso.Text;
      Parambyname('Fecha_Proceso').AsDate := dFecha_Cierre;
      Try
        ExecSql
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Close;
            Exit;
          end;
      end;
      Close;

      Sql.Clear;
      Sql.Add('DELETE FROM QS_SUP_251_DET '
            + ' WHERE Empresa = :EMPRESA'
            + '  AND Proceso  = :Proceso'
            + '  AND Fecha_Proceso = :Fecha_Proceso');
      Parambyname('EMPRESA').asString     := sEmpresa_Usuario;
      Parambyname('Proceso').asString     := Ed_Proceso.Text;
      Parambyname('Fecha_Proceso').AsDate := dFecha_Cierre;
      Try
        ExecSql
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E);
            Close;
            Exit;
          end;
      end;
      Close;

      if bSBS then
        begin
          Sql.Clear;
          Sql.Add('DELETE FROM QS_SUP_251_PROCESO '
                + ' WHERE Empresa = :EMPRESA'
                + '  AND Proceso  = :Proceso'
                + '  AND Fecha_de_cierre = :Fecha_Proceso');
          Parambyname('EMPRESA').asString     := sEmpresa_Usuario;
          Parambyname('Proceso').asString     := Ed_Proceso.Text;
          Parambyname('Fecha_Proceso').AsDate := dFecha_Cierre;
          Try
            ExecSql
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                Close;
                Exit;
              end;
          end;
          Close;
        end;
    end;
  BTN_CancelarClick(Sender);
end;

procedure TFrmCalculoLimites.BTN_ConfirmarClick(Sender: TObject);
var
  i, x, iTotal     : Integer;
  sNombre_Tabla    : String;
  sNombre_Tabla_Det: String;
  Nro_pasadas      : Integer;
begin
  if Trim(Ed_Proceso.Text) = EmptyStr then
  begin
      Application.MessageBox('Debe ingresar Tipo Límite',
                              Pchar(Caption),
                              Mb_Ok + MB_IconError);
      Ed_Proceso.Setfocus;
      Exit;
  end;

  if (T_TmpDatosLimite.RecordCount = 0) then
  begin
      if sTipo_Limite = '' then
        Application.MessageBox(' NO EXISTEN Datos para Grabar',
                                Pchar(Caption),
                                Mb_Ok + MB_IconError);
      Exit;
  end;

  Nro_pasadas := 1;
  if Transaccion_implica_Mem(sEmpresa_Usuario, 'LIMTRASBS') then
     Nro_pasadas := 2;

  for x := 1 to Nro_pasadas do
  begin
      if x = 1 then
      begin
          sNombre_Tabla     := 'QS_SUP_251';
          sNombre_Tabla_Det := 'QS_SUP_251_DET';
      end
      else
      begin
          sNombre_Tabla     := 'QS_TRA_251';
          sNombre_Tabla_Det := 'QS_TRA_251_DET';
      end;

      With Qry_General do
      begin
          Close;
          Sql.Clear;
          Sql.Add('DELETE ' + sNombre_Tabla
                + ' WHERE Empresa = :EMPRESA'
                + '   AND Proceso = :Proceso');
          Sql.Add('   AND Fecha_Proceso = :Fecha_Proceso'
                + '   AND Cartera       = :Cartera');

          Parambyname('EMPRESA').asString     := sEmpresa_Usuario;
          Parambyname('Proceso').asString     := Ed_Proceso.Text;
          Parambyname('Fecha_Proceso').AsDate := dFecha_Cierre;
          Parambyname('Cartera').asString     := Combo_Cartera.Text;

          try
            ExecSql
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                Close;
                Exit;
              end;
          end;

          Close;
          Sql.Clear;
          Sql.Add('DELETE ' + sNombre_Tabla_Det
                + ' WHERE Empresa       = :EMPRESA'
                + '   AND Proceso       = :Proceso');
          Sql.Add('   AND Fecha_Proceso = :Fecha_Proceso');
          Sql.Add('   AND cartera IN ' + sString_Carteras);

          Parambyname('EMPRESA').asString     := sEmpresa_Usuario;
          Parambyname('Proceso').asString     := Ed_Proceso.Text;
          Parambyname('Fecha_Proceso').AsDate := dFecha_Cierre;

          try
            ExecSql
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E);
                Close;
                Exit;
              end;
          end;
          Close;
      end;

      // Encabezado
      Qry_General.Close;
      Qry_General.Sql.Clear;
      Qry_General.Sql.Add(' INSERT INTO ' + sNombre_Tabla
                        + ' ( Empresa'
                        + ',Cartera'
                        + ',Fecha_Proceso'
                        + ',Proceso'
                        + ',Codigo_Limite'
                        + ',Tipo_Limite'
                        + ',Emisor'
                        + ',Instrumento'
                        + ',Nemotecnico'
                        + ',Moneda_Instrum'
                        + ',Grupo_Emisor'
                        + ',Porcentaje_Min'
                        + ',Porcentaje'
                        + ',Valor_Pte_Cartera'
                        + ',Minimo_Permitido'
                        + ',Maximo_Permitido'
                        + ',Matriz'
                        + ',Series_Inscritas'
                        + ',Grupo_Cartera'
                        + ',Tipo_Clasif'
                        + ',Grupo_Clasif'
                        + ',Moneda_Conversion_Informe'
                        + ',CREDENCIAL_DEUDOR'
                        + ',NOMBRE_DEUDOR'
                        + ',Id_Credito'
                        + ' )'
                        + ' VALUES( :Empresa'
                        + ',:Cartera'
                        + ',:Fecha_Proceso'
                        + ',:Proceso'
                        + ',:Codigo_Limite'
                        + ',:Tipo_Limite'
                        + ',:Emisor'
                        + ',:Instrumento'
                        + ',:Nemotecnico'
                        + ',:Moneda_Instrum'
                        + ',:Grupo_Emisor'
                        + ',:Porcentaje_Min'
                        + ',:Porcentaje'
                        + ',:Valor_Pte_Cartera'
                        + ',:Minimo_Permitido'
                        + ',:Maximo_Permitido'
                        + ',:Matriz'
                        + ',:Series_Inscritas'
                        + ',:Grupo_Cartera'
                        + ',:Tipo_Clasif'
                        + ',:Grupo_Clasif'
                        + ',:Moneda_Conversion_Informe'
                        + ',:CREDENCIAL_DEUDOR'
                        + ',:NOMBRE_DEUDOR'
                        + ',:Id_Credito'
                        + ' )');
      i := 0;
      T_TmpLimites.Last;
      iTotal := T_TmpLimites.RecordCount;
      T_TmpLimites.First;
      ProgressBar1.Max      := T_TmpLimites.RecordCount;
      ProgressBar1.Position := 0;
      T_TmpLimites.First;
      Lbl_Avance1.Caption := 'Grabando Cabecera';
      Lbl_Avance2.Caption := 'Detalle';

      While Not T_TmpLimites.eof do
      begin

          ProgressBar1.Position := ProgressBar1.Position + 1;
          Inc(i);
          LabelPorcentaje1.Caption := FloatToStr(ProgressBar1.Position) + ' de ' + FloatToStr(ProgressBar1.Max) + ' (' + FormatFloat('##0', ProgressBar1.Position / ProgressBar1.Max * 100) + '%)';

          Application.ProcessMessages;

          if (Not bSBS) and (Trim(T_TmpLimites.FieldByName('Codigo_Limite').asString) = '') then
          begin
              T_TmpLimites.Next;
              Continue;
          end;

          Qry_General.Parambyname('Empresa').asString          := sEmpresa_Usuario;
          Qry_General.Parambyname('Cartera').asString          := Combo_Cartera.Text;
          Qry_General.Parambyname('Proceso').asString          := Ed_Proceso.Text;
          Qry_General.Parambyname('Fecha_Proceso').AsDateTime  := dFecha_Cierre;
          Qry_General.Parambyname('Codigo_Limite').asString    := T_TmpLimites.FieldByName('Codigo_Limite').asString;
          Qry_General.Parambyname('Tipo_Limite').asString      := T_TmpLimites.FieldByName('Tipo_Limite').asString;
          Qry_General.Parambyname('Emisor').asString           := T_TmpLimites.FieldByName('Emisor').asString;
          Qry_General.Parambyname('Instrumento').asString      := T_TmpLimites.FieldByName('Instrumento').asString;
          Qry_General.Parambyname('Nemotecnico').asString      := T_TmpLimites.FieldByName('Nemotecnico').asString;
          Qry_General.Parambyname('Moneda_Instrum').asString   := T_TmpLimites.FieldByName('Moneda_Instrum').asString;
          Qry_General.Parambyname('Grupo_Emisor').asString     := T_TmpLimites.FieldByName('Grupo_Emisor').asString;
          Qry_General.Parambyname('Porcentaje_Min').asFloat    := T_TmpLimites.FieldByName('Porcentaje_Min').asFloat;
          Qry_General.Parambyname('Porcentaje').asFloat        := T_TmpLimites.FieldByName('Porcentaje').asFloat;
          Qry_General.Parambyname('Valor_Pte_Cartera').asFloat := T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat;
          Qry_General.Parambyname('Minimo_Permitido').asFloat  := T_TmpLimites.FieldByName('Minimo_Permitido').asFloat;
          Qry_General.Parambyname('Maximo_Permitido').asFloat  := T_TmpLimites.FieldByName('Maximo_Permitido').asFloat;
          Qry_General.Parambyname('Matriz').asString           := T_TmpLimites.FieldByName('Matriz').asString;
          Qry_General.Parambyname('Series_Inscritas').asString := T_TmpLimites.FieldByName('Series_Inscritas').asString;
          Qry_General.Parambyname('Grupo_Cartera').asString    := sGrupo_Cartera;
          // 'GRUPO';
          Qry_General.Parambyname('Tipo_Clasif').asString               := T_TmpLimites.FieldByName('Tipo_Clasif').asString;
          Qry_General.Parambyname('Grupo_Clasif').asFloat               := T_TmpLimites.FieldByName('Grupo_Clasif').asFloat;
          Qry_General.Parambyname('Moneda_Conversion_Informe').asString := sMoneda_Nacional;

          Qry_General.Parambyname('CREDENCIAL_DEUDOR').asString         := T_TmpLimites.FieldByName('CREDENCIAL_DEUDOR').asString;
          Qry_General.Parambyname('NOMBRE_DEUDOR').asString             := T_TmpLimites.FieldByName('NOMBRE_DEUDOR').asString;
          Qry_General.Parambyname('Id_Credito').asString                := T_TmpLimites.FieldByName('Id_Credito').asString;

          Try
            Qry_General.ExecSql
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E)
              end;
          end;
          Qry_General.Close;
          T_TmpLimites.Next;
      end;

      // Detalle
      Qry_General.Close;
      Qry_General.Sql.Clear;
      Qry_General.Sql.Add(' INSERT INTO ' + sNombre_Tabla_Det
                            + ' ( Empresa'
                            + ',Cartera'
                            + ',Proceso'
                            + ',Fecha_Proceso'
                            + ',Codigo_Limite'
                            + ',Codigo_RtPr'
                            + ',Transaccion'
                            + ',Folio_Interno'
                            +',Item_Omd'
                            + ',Emisor'
                            + ',Instrumento'
                            + ',Serie'
                            + ',Nemotecnico'
                            + ',Moneda_Instrum'
                            + ',Valor_Nominal'
                            + ',Saldo_Insoluto'
                            + ',Monto_Inscrito'
                            + ',Valor_Pte_MC_Cpa'
                            + ',Clasif_Riesgo'
                            + ',Grupo_Emisor'
                            + ',Matriz'
                            + ',Series_Inscritas'
                            + ',Clasif_Limite'
                            + ',Tipo_Clasif'
                            + ',Grupo_Clasif'
                            + ' )'
                            + ' VALUES( :Empresa'
                            + ',:Cartera'
                            + ',:Proceso'
                            +',:Fecha_Proceso'
                            + ',:Codigo_Limite'
                            + ',:Codigo_RtPr'
                            + ',:Transaccion'
                            + ',:Folio_Interno'
                            + ',:Item_Omd'
                            + ',:Emisor'
                            + ',:Instrumento'
                            + ',:Serie'
                            + ',:Nemotecnico'
                            + ',:Moneda_Instrum'
                            + ',:Valor_Nominal'
                            + ',:Saldo_Insoluto'
                            + ',:Monto_Inscrito'
                            + ',:Valor_Pte_MC_Cpa'
                            + ',:Clasif_Riesgo'
                            + ',:Grupo_Emisor'
                            + ',:Matriz'
                            + ',:Series_Inscritas'
                            + ',:Clasif_Limite'
                            + ',:Tipo_Clasif'
                            + ',:Grupo_Clasif'
                            + ' )');
      i := 0;
      T_TmpDatosLimite.Last;
      ProgressBar2.Max      := T_TmpDatosLimite.RecordCount;
      ProgressBar2.Position := 0;
      T_TmpDatosLimite.First;
      Lbl_Avance2.Caption := 'Grabando Detalle';
      While Not T_TmpDatosLimite.eof do
      begin
          ProgressBar2.Position    := ProgressBar2.Position + 1;
          LabelPorcentaje2.Caption := FloatToStr(ProgressBar2.Position) + ' de ' + FloatToStr(ProgressBar2.Max) + ' (' + FormatFloat('##0', ProgressBar2.Position / ProgressBar2.Max * 100) + '%)';
          Application.ProcessMessages;

          if (Not bSBS) and
             ((Pos('SIN', T_TmpDatosLimite.FieldByName('Grupo_Emisor').asString) > 0) and
             (Trim(T_TmpDatosLimite.FieldByName('Codigo_Limite').asString) = '')) then
          begin
              T_TmpDatosLimite.Next;
              Continue;
          end;

          Qry_General.Parambyname('Empresa').asString         := sEmpresa_Usuario;
          Qry_General.Parambyname('Cartera').asString         := T_TmpDatosLimite.FieldByName('Cartera').asString;
          Qry_General.Parambyname('Proceso').asString         := Ed_Proceso.Text;
          Qry_General.Parambyname('Fecha_Proceso').AsDateTime := dFecha_Cierre;
          Qry_General.Parambyname('Codigo_Limite').asString   := T_TmpDatosLimite.FieldByName('Codigo_Limite').asString;
          Qry_General.Parambyname('Codigo_RtPr').asString     := T_TmpDatosLimite.FieldByName('Codigo_RtPr').asString;
          if Trim(T_TmpDatosLimite.FieldByName('Transaccion').asString) = '' then
          begin
              Qry_General.Parambyname('Transaccion').asString   := 'CRV';
              Qry_General.Parambyname('Folio_Interno').asString := ' ';
              Qry_General.Parambyname('Item_Omd').asFloat       := 0;
          end
          else
          begin
              Qry_General.Parambyname('Transaccion').asString := T_TmpDatosLimite.FieldByName('Transaccion').asString;
              if T_TmpDatosLimite.FieldByName('Folio_Interno').IsNull then
                Qry_General.Parambyname('Folio_Interno').asString := ' '
              else
                Qry_General.Parambyname('Folio_Interno').asString := T_TmpDatosLimite.FieldByName('Folio_Interno').asString;

              Qry_General.Parambyname('Item_Omd').asFloat := T_TmpDatosLimite.FieldByName('Item_Omd').asFloat;
          end;
          Qry_General.Parambyname('Emisor').asString           := T_TmpDatosLimite.FieldByName('Emisor').asString;
          Qry_General.Parambyname('Instrumento').asString      := T_TmpDatosLimite.FieldByName('Instrumento').asString;
          Qry_General.Parambyname('Serie').asString            := T_TmpDatosLimite.FieldByName('Serie').asString;
          Qry_General.Parambyname('Nemotecnico').asString      := T_TmpDatosLimite.FieldByName('Nemotecnico').asString;
          Qry_General.Parambyname('Moneda_Instrum').asString   := T_TmpDatosLimite.FieldByName('Moneda_Instrum').asString;
          Qry_General.Parambyname('valor_Nominal').asFloat     := T_TmpDatosLimite.FieldByName('valor_Nominal').asFloat;
          Qry_General.Parambyname('Saldo_Insoluto').asFloat    := T_TmpDatosLimite.FieldByName('Saldo_Insoluto').asFloat;
          Qry_General.Parambyname('Monto_Inscrito').asFloat    := T_TmpDatosLimite.FieldByName('Monto_Inscrito').asFloat;
          Qry_General.Parambyname('Valor_Pte_MC_Cpa').asFloat  := T_TmpDatosLimite.FieldByName('Valor_Pte_MC_Cpa').asFloat;
          Qry_General.Parambyname('Clasif_Riesgo').asString    := T_TmpDatosLimite.FieldByName('Clasif_Riesgo').asString;
          Qry_General.Parambyname('Grupo_Emisor').asString     := T_TmpDatosLimite.FieldByName('Grupo_Emisor').asString;
          Qry_General.Parambyname('Matriz').asString           := T_TmpDatosLimite.FieldByName('Matriz').asString;
          Qry_General.Parambyname('Series_Inscritas').asString := T_TmpDatosLimite.FieldByName('Series_Inscritas').asString;
          Qry_General.Parambyname('Clasif_Limite').asString    := T_TmpDatosLimite.FieldByName('Clasif_Limite').asString;
          Qry_General.Parambyname('Tipo_Clasif').asString      := T_TmpDatosLimite.FieldByName('Tipo_Clasif').asString;
          Qry_General.Parambyname('Grupo_Clasif').asFloat      := T_TmpDatosLimite.FieldByName('Grupo_Clasif').asFloat;
          try
            Qry_General.ExecSql
          except
            on E: EFDDBEngineException do
              begin
                ShowError(E)
              end;
          end;
          Qry_General.Close;
          T_TmpDatosLimite.Next;
      end;
  end;

  if sTipo_Limite <> 'T' then
     if bSBS then
     begin
        Qry_General_Del.Close;
        Qry_General_Del.Sql.Clear;
        Qry_General_Del.Sql.Add(' DELETE FROM QS_SUP_251_PROCESO '
                              + ' WHERE Empresa               =  :Empresa'
                              + '   AND Grupo_Cartera         =  :Grupo_Cartera'
                              + '   AND Proceso               =  :Proceso'
                              + '   AND Fecha_de_Cierre       =  :Fecha_de_Cierre');
        if Trim(sTipo_Conversion) <> '' then
        begin
            Qry_General_Del.Sql.Add('   AND Fecha_cierre_anterior =  :Fecha_cierre_anterior'
                                  + '   AND Fecha_Inicio_anterior =  :Fecha_Inicio_anterior'
                                  + '   AND Tipo_conversion       =  :Tipo_conversion');

            Qry_General_Del.Parambyname('Fecha_cierre_anterior').AsDate := dFecha_Cierre_Anterior;
            Qry_General_Del.Parambyname('Fecha_Inicio_anterior').AsDate := dFecha_Inicio_Cierre_Anterior;
            Qry_General_Del.Parambyname('Tipo_conversion').asString     := sTipo_Conversion;
        end;

        Qry_General_Del.Parambyname('Empresa').asString       := sEmpresa_Usuario;
        Qry_General_Del.Parambyname('Grupo_Cartera').asString := Combo_Cartera.Text; // sGrupo_Cartera;  //'GRUPO';
        Qry_General_Del.Parambyname('Proceso').asString       := Ed_Proceso.Text;
        Qry_General_Del.Parambyname('Fecha_de_Cierre').AsDate := dFecha_Cierre;

        try
          Qry_General_Del.ExecSql
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E)
            end;
        end;
        Qry_General_Del.Close;

        Qry_General.Close;
        Qry_General.Sql.Clear;
        Qry_General.Sql.Add(' INSERT INTO QS_SUP_251_PROCESO '
                          + ' ( Empresa'
                          + '  ,Grupo_Cartera'
                          + '  ,Proceso'
                          + '  ,Fecha_de_Cierre');

        if Trim(sTipo_Conversion) <> '' then
          Qry_General.Sql.Add('  ,Fecha_cierre_anterior'
                            + '  ,Fecha_Inicio_anterior'
                            + '  ,Tipo_conversion'
                            + '  ,Moneda_conversion');

        Qry_General.Sql.Add('  ,Moneda_Conversion_Informe'
                          + ' )'
                          + ' VALUES(:Empresa'
                          + '  ,:Grupo_Cartera'
                          + '  ,:Proceso'
                          + '  ,:Fecha_de_Cierre');

        if Trim(sTipo_Conversion) <> '' then
          Qry_General.Sql.Add('  ,:Fecha_cierre_anterior'
                            + '  ,:Fecha_Inicio_anterior'
                            + '  ,:Tipo_conversion'
                            + '  ,:Moneda_conversion');

        Qry_General.Sql.Add('  ,:Moneda_Conversion_Informe'
                          + ' )');

        Qry_General.Parambyname('Empresa').asString       := sEmpresa_Usuario;
        Qry_General.Parambyname('Grupo_Cartera').asString := Combo_Cartera.Text;
        // sGrupo_Cartera;  //'GRUPO';
        Qry_General.Parambyname('Proceso').asString           := Ed_Proceso.Text;
        Qry_General.Parambyname('Fecha_de_Cierre').AsDateTime := dFecha_Cierre;
        if Trim(sTipo_Conversion) <> '' then
        begin
            Qry_General.Parambyname('Fecha_cierre_anterior').AsDateTime := dFecha_Cierre_Anterior;
            Qry_General.Parambyname('Fecha_Inicio_anterior').AsDateTime := dFecha_Inicio_Cierre_Anterior;
            Qry_General.Parambyname('Tipo_conversion').asString         := sTipo_Conversion;
            Qry_General.Parambyname('Moneda_conversion').asString       := sMoneda_Conversion;
        end;
        Qry_General.Parambyname('Moneda_Conversion_Informe').asString := sMoneda_Nacional;

        try
          Qry_General.ExecSql
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E)
            end;
        end;
     end;

  T_TmpDatos.EmptyDataSet;
  T_TmpDatosLimite.EmptyDataSet;
  T_TmpLimites.EmptyDataSet;
  if sTipo_Limite = '' then
    Application.MessageBox(' Datos Grabados con Exito ',
                            Pchar(Caption),
                            Mb_Ok + MB_ICONINFORMATION);
  BTN_Gestion.enabled      := True;
  Lbl_Avance1.Caption      := '';
  Lbl_Avance2.Caption      := '';
  LabelPorcentaje1.Caption := '';
  LabelPorcentaje2.Caption := '';
  ProgressBar1.Position    := 0;
  ProgressBar2.Position    := 0;
end;

procedure TFrmCalculoLimites.BTN_InsertarClick(Sender: TObject);
begin
  T_TmpDatos.EmptyDataSet;
  T_TmpDatosLimite.EmptyDataSet;
  T_TmpLimites.EmptyDataSet;
  FrmReportErrores.T_Paradox.EmptyDataSet;
  Combo_Cartera.Text := '';
  Ed_Proceso.Text    := '';
  Ed_Fecha.Date      := 0;
  Ed_Proceso.Setfocus;
end;

procedure TFrmCalculoLimites.BTN_BuscarClick(Sender: TObject);
// Var
// Empresa: String;
// cartera: String;
// sw_esta: Boolean;
// sHolding: String;
// i, k,
// p: Integer;
begin
  with T_TmpHelpLimites.FieldDefs do
    begin
      Clear;
      Add('Valor', ftAutoInc, 0, False);
      Add('Cartera', ftString, 10, False);
      Add('Proceso', ftString, 10, False);
      Add('Fecha_Proceso', ftDateTime, 0, False);
      Add('Grupo_Cartera', ftString, 10,  False);
    end;

  with T_TmpHelpLimites.IndexDefs do
    begin
      Clear;
      Add('Valor', 'Valor', [ixprimary]);
      Add('Cartera', 'Cartera', [ixCaseInsensitive]);
      Add('Proceso', 'Proceso', [ixCaseInsensitive]);
      Add('Fecha_Proceso', 'Fecha_Proceso', [ixCaseInsensitive]);
    end;
  T_TmpHelpLimites.CreateDataSet;
  T_TmpHelpLimites.Open;

  With Qry_General do
    begin
      Sql.Clear;
      Sql.Add(' SELECT Cartera'
            + '       ,Proceso'
            + '       ,Fecha_Proceso'
            + '       ,Grupo_Cartera'
            + '  FROM QS_SUP_251'
            + ' WHERE Empresa = :Empresa'
            + ' GROUP BY Cartera'
            + '       ,Proceso'
            + '       ,Fecha_Proceso'
            + '       ,Grupo_Cartera'
            + '  ORDER BY Fecha_Proceso'
            + '          ,Proceso'
            + '          ,Cartera');
      Parambyname('Empresa').asString := sEmpresa_Usuario;
      Open;
      While Not eof do
        begin
          T_TmpHelpLimites.insert;
          T_TmpHelpLimites.FieldByName('Cartera').asString         := FieldByName('Cartera').asString;
          T_TmpHelpLimites.FieldByName('Proceso').asString         := FieldByName('Proceso').asString;
          T_TmpHelpLimites.FieldByName('Fecha_Proceso').AsDateTime := FieldByName('Fecha_Proceso').AsDateTime;
          T_TmpHelpLimites.FieldByName('Grupo_Cartera').asString   := FieldByName('Grupo_Cartera').asString;
          T_TmpHelpLimites.Post;
          Next;
        end;
      Close;
    end;

  if Busca_Limites.Execute  then
    begin
      bMuestra           := False;
      Chk_Carteras.State := cbChecked;
      bMuestra           := True;
      Combo_Cartera.Text := T_TmpHelpLimites.FieldByName('Cartera').asString;
      Ed_Fecha.Date      := solo_fecha(T_TmpHelpLimites.FieldByName('Fecha_Proceso').AsDateTime);

      With Qry_General do
        begin
          Sql.Clear;
          Sql.Add(' SELECT * FROM QS_SUP_251'
                + ' WHERE Empresa       = :Empresa'
                + '   AND Cartera       = :Cartera'
                + '   AND Fecha_Proceso = :Fecha_Proceso'
                + '   AND Proceso       = :Proceso');
          Parambyname('fecha_Proceso').AsDate := solo_fecha(T_TmpHelpLimites.FieldByName('Fecha_Proceso').AsDateTime);
          Parambyname('Proceso').asString     := T_TmpHelpLimites.FieldByName('Proceso').asString;
          Parambyname('Cartera').asString     := T_TmpHelpLimites.FieldByName('Cartera').asString;
          Parambyname('Empresa').asString     := sEmpresa_Usuario;
          Open;

          if FieldByName('Cartera').IsNull then
            begin
              Close;
              T_TmpHelpLimites.Close;
              Exit;
            end;
          Ed_Proceso.Text     := T_TmpHelpLimites.FieldByName('Proceso').asString;
          BTN_Gestion.enabled := True;
          Close;

          With Qry_General do
          begin
            Close;
            Sql.Clear;
            Sql.Add(' DELETE FROM QS_SYS_PARAM_EMPRESA '
                   +'  WHERE PID = :PID ');

            Parambyname('PID').asString := FloatToStr(Application.Handle);
            try
              Qry_General.ExecSql
            except
              on E: EFDDBEngineException do
                begin
                  ShowError(E)
                end;
            end;

            Close;
            Sql.Clear;
            Sql.Add(' INSERT INTO QS_SYS_PARAM_EMPRESA ');
            Sql.Add(' SELECT :PID, z.cod_empresa,z.COD_CARTERA'
                   +'   FROM QS_FIN_CARTERAS z'
                   +'       ,qs_sys_clasif_obj a'
                   +'       ,qs_sys_est_cla b'
                   +'  WHERE a.objeto           = ''CARTERA'' '
              // +'    AND a.codigo_clasif    = :GRUPO  '
                   +'    AND a.elemento         = z.cod_cartera'
                   +'    AND b.codigo_objeto    = a.codigo_clasif'
                   +'    AND b.descripcion_nodo LIKE :Cartera ' // clasificacion'
                   +'    AND b.nodo             = a.nodo'
                   +'    AND z.cod_empresa      = :empresa');

            if Combo_Cartera.Text = 'CONSOLIDA' then
              begin
                Sql.Add(' UNION ');
                Sql.Add(' SELECT distinct :PID, c.cod_empresa,c.cod_CARTERA'
                      +'    FROM QS_FIN_CARTERAS c'
                      +'   WHERE c.cod_Empresa = :Empresa');

                // SQL.Add(' UNION ');
                // Sql.Add(' SELECT distinct :PID, c.empresa,c.CARTERA'
                // +'   FROM QS_SUP_251_DET c'
                // +'       ,QS_SUP_251 d '
                // +' WHERE d.Fecha_Proceso = :Fecha_Proceso'
                // +'   AND d.Proceso       = :Proceso'
                // +'   AND d.Cartera       = :Cartera'
                // +'   AND d.Empresa       = :Empresa'
                // +'   AND c.Fecha_Proceso = d.Fecha_Proceso'
                // +'   AND c.Proceso       = d.Proceso'
                // +'   AND c.Empresa       = d.Empresa'
                // );
                // ParamByName('clasificacion').asString   := T_TmpHelpLimites.Fieldbyname('Grupo_Cartera').asString;
                // ParamByname('fecha_Proceso').AsDate     := solo_fecha(T_TmpHelpLimites.Fieldbyname('Fecha_Proceso').asDatetime);
                // ParamByname('Proceso').asString         := T_TmpHelpLimites.Fieldbyname('Proceso').asString;
                Parambyname('Empresa').asString := sEmpresa_Usuario;
              end;

            Parambyname('PID').asString     := FloatToStr(Application.Handle);
            Parambyname('Cartera').asString := T_TmpHelpLimites.FieldByName('cartera').asString+'%';
            // ParamByname('GRUPO').asString    := T_TmpHelpLimites.Fieldbyname('Grupo_Cartera').asString;
            Parambyname('Empresa').asString := sEmpresa_Usuario;

            try
              Qry_General.ExecSql
            except
              on E: EFDDBEngineException do
                begin
                  ShowError(E)
                end;
            end;
          end;



          // inicio llena ventana carteras
          // FrmConsolidaEmpresa := TFrmConsolidaEmpresa.Create(Application);
          // with FrmConsolidaEmpresa do
          // begin
          // bClick_clasif              := True;
          // sEmpresa_prg               := sEmpresa_Usuario;
          // Ed_Clasificacion.Text      := FrmCalculoLimites.Combo_Cartera.Text;
          // Ed_TipoClasif_Cartera.Text := T_TmpHelpLimites.Fieldbyname('Grupo_Cartera').asString; //'GRUPO';
          // With QRY_General do
          // begin
          // Sql.Clear;
          // Sql.Add('SELECT  a.* '
          // +'FROM qs_sys_perfil a '
          // +'WHERE a.COD_PERFIL = '''+sperfil_usuario+''' '
          // );
          // Open;
          // sConsolida := FieldByname('CONSOLIDA').AsString;
          // If not eof Then
          // Begin
          // empresa := sEmpresa_Usuario;
          // If FieldByname('CONSOLIDA').AsString = 'HOLDING' Then       // POR HOLDING
          // Begin
          // Sql.Clear;
          // Sql.Add(' SELECT a.CODIGO_HOLDING'
          // +'   FROM qs_sys_def_holding a'
          // +'  WHERE a.CODIGO_EMPRESA = :EMPRESA '
          // );
          // ParamByName('EMPRESA').AsString := sEmpresa_Usuario;
          // Open;
          // if eof then
          // begin
          // Application.MessageBox(pchar('Empresa '+sEmpresa_Usuario+' no pertenece a ningun holding')
          // ,' Informe Consolidado'
          // , mb_OK);
          // Close;
          // exit;
          // end;
          // sHolding := FieldByName('CODIGO_HOLDING').AsString;
          // Close;
          // Sql.Clear;
          // Sql.Add(' SELECT a.CODIGO_EMPRESA AS COD_EMPRESA, b.COD_CARTERA '
          // +' FROM   qs_sys_def_holding a, qs_fin_carteras b '
          // +' WHERE a.Codigo_Holding = :Codigo_Holding'
          // +'   AND a.CODIGO_EMPRESA = b.COD_EMPRESA '
          // );
          // ParamByName('Codigo_Holding').AsString := sHolding;
          // Open;
          // End
          // else
          // If FieldByname('CONSOLIDA').AsString = 'EMPRESA' Then       // POR EMPRESA
          // Begin
          // Sql.Clear;
          // Sql.Add(' SELECT a.COD_EMPRESA, a.COD_CARTERA '
          // +'   FROM qs_fin_carteras a '
          // +'  WHERE a.COD_EMPRESA = :empresa '
          // );
          // ParamByname('empresa').AsString := empresa;
          // Open;
          // end
          // else
          // begin
          // Application.MessageBox('No se ha definido nivel de consolidación para este perfil de usuario '
          // ,' Informe Consolidado'
          // , mb_OK);
          //
          // exit;
          // end;
          // end
          // else
          // begin
          // Close;
          // Sql.Clear;
          // Sql.Add('SELECT a.COD_EMPRESA, a.COD_CARTERA '
          // +'  FROM QS_FIN_CARTERAS a'
          // +' WHERE a.COD_EMPRESA = :empresa '
          // );
          // ParamByName('empresa').AsString := sEmpresa_Usuario;
          // Open;
          // end;
          // with TIniFile.Create(sArchivo_Ini) do
          // begin
          // ReadSectionValues('Parametros Empresa',ListBox1.items);
          // Free;
          // end;
          // For k := 0 to (ListBox1.items.count -1) do
          // begin
          // i := pos('=',ListBox1.items.strings[k]);
          // p := pos('-',ListBox1.items.strings[k]);
          // Empresa    := Trim(Copy(ListBox1.items.strings[k], i+1 ,p-i-1));
          // cartera    := Trim(Copy(ListBox1.items.strings[k], p+1 ,20));
          // ListTarget.Items.Add(empresa +' - '+cartera);
          // end;
          // while Not (EOF) do
          // begin
          // sw_esta := False;
          // For k := 0 to (ListBox1.items.count -1) do
          // begin
          // i := pos('=',ListBox1.items.strings[k]);
          // p := pos('-',ListBox1.items.strings[k]);
          // Empresa    := Trim(Copy(ListBox1.items.strings[k], i+1 ,p-i-1));
          // cartera    := Trim(Copy(ListBox1.items.strings[k], p+1 ,20));
          // if (empresa +' - '+cartera) = (Trim(FieldByname('COD_EMPRESA').AsString)+' - '+Trim(FieldByname('COD_CARTERA').AsString)) Then
          // sw_esta := True;
          // end;
          // if Not sw_esta Then
          // ListSource.Items.Add(Trim(FieldByname('COD_EMPRESA').AsString)+' - '+Trim(FieldByname('COD_CARTERA').AsString));
          // Next;
          // end;
          // Close;
          // end;
          // Chk_ClasifCarteras.checked := true;
          // Chk_ClasifCarterasClick(Sender);
          // BTN_AceptarClick(Sender);
          // end;
          // FrmConsolidaEmpresa.Close;
          // fin llena ventana carteras

        end;
    end;
  dFecha_Cierre := Ed_Fecha.Date;
  T_TmpHelpLimites.Close;
  BTN_Gestion.enabled := True;
  Screen.Cursor       := crDefault;
end;

procedure TFrmCalculoLimites.BTN_CancelarClick(Sender: TObject);
begin
  T_TmpDatos.EmptyDataSet;
  T_TmpDatosLimite.EmptyDataSet;
  T_TmpLimites.EmptyDataSet;
  FrmReportErrores.T_Paradox.EmptyDataSet;

  Ed_Fecha.enabled                    := True;
  BTN_Buscar.enabled                  := True;
  Combo_Cartera.Text                  := '';
  Ed_Fecha.Date                       := 0;
  edFecha_Cierre.Date                 := 0;
  edFecha_Cierre_Anterior.Date        := 0;
  edFecha_Inicio_Cierre_Anterior.Date := 0;
  edTipo_Conversion.Text              := '';
  edMoneda_Conversion.Text            := '';
  Ed_Proceso.Setfocus;
  BTN_Gestion.enabled   := False;
  bMuestra              := False;
  Chk_Carteras.State    := cbUnChecked;
  Ed_Proceso.Text       := '';
  edMoneda.Text         := '';
  Ed_Proceso.enabled    := True;
  Chk_Carteras.enabled  := True;
  Combo_Cartera.enabled := True;
  BTN_Imprimir.enabled  := False;
  bMuestra              := True;

  if bSBS then
    begin
      BTN_Buscar.visible       := False;
      BTN_Buscar_Inver.Left    := 209;
      BTN_Buscar_Inver.visible := True;
    end
  else
    begin
      BTN_Buscar.visible       := True;
      BTN_Buscar_Inver.visible := False;
    end;

end;

Function TFrmCalculoLimites.Existen_Valores_Instrum(sTipo         : String;
                                                    sCodigo_Limite: String;
                                                    sEmisor       : String): Boolean;
var
  sInstrumento_Equiv: String;
begin
  Existen_Valores_Instrum := False;
  With Qry_Prdx do
    begin
      Close;
      Sql.Clear;
      Sql.Add(' SELECT Instrumento FROM '+ T_TmpDatosLimite.Name
            + ' WHERE Emisor        = :Emisor'
            + '   AND Codigo_Limite = :Codigo_Limite'
            + ' GROUP BY Instrumento' + ' ORDER BY Instrumento');
      Parambyname('Emisor').asString        := sEmisor;
      Parambyname('Codigo_Limite').asString := sCodigo_Limite;
      Open;
      while Not eof do
        begin
          Busca_Equivalencia('SUPER',
                              'INSTRUM',
                              FieldByName('Instrumento').asString,
                              dFecha_Cierre,
                              sInstrumento_Equiv);
          if sTipo = 'DEPOSITOS' then
            begin
              If sInstrumento_Equiv = 'DPC' then
                begin
                  Close;
                  Existen_Valores_Instrum := True;
                  Exit;
                end;
            end;

          if sTipo = 'LETRAS' then
            begin
              If sInstrumento_Equiv = 'LH' then
                begin
                  Close;
                  Existen_Valores_Instrum := True;
                  Exit;
                end;
            end;

          if sTipo = 'ACCIONES' then
            begin
              If sInstrumento_Equiv = 'ACC' then
                begin
                  Close;
                  Existen_Valores_Instrum := True;
                  Exit;
                end;
            end;

          if sTipo = 'CUOTAS' then
            begin
              If sInstrumento_Equiv = 'CFM' then
                begin
                  Close;
                  Existen_Valores_Instrum := True;
                  Exit;
                end;
            end;

          if sTipo = '*' then
            begin
              Close;
              Existen_Valores_Instrum := True;
              Exit;
            end;

          Next;
        end;
      Close;
    end;
end;

procedure TFrmCalculoLimites.Chk_CarterasClick(Sender: TObject);
  begin
    if (not bMuestra) or (sTipo_Limite = 'T') then
      Exit;

    if Trim(Ed_Proceso.Text) <> '' then
      if Chk_Carteras.State = cbChecked then
        begin
          ParametrosEmpresas(sPerfil_Usuario,
                             sEmpresa_Usuario,
                             Result);
          if Result Then
            begin
              sString_Empresas := String_Empresas(Application.Handle);
              With Qry_General do
                begin
                  Close;
                  Sql.Clear;
                  Sql.Add(' SELECT a.Cartera'
                        + '   FROM QS_SYS_PARAM_EMPRESA a'
                        + '  WHERE a.Pid = :Pid'
                        + '    AND a.Empresa not in ' + sString_Empresas);

                  Parambyname('pid').asFloat := Application.Handle;
                  Open;

                  if Qry_General.FieldByName('Cartera').asString <> '' then
                    Combo_Cartera.Text := Qry_General.FieldByName('Cartera').asString
                  else
                    begin
                      Chk_Carteras.ChecKed := False;
                      Application.MessageBox('Para este proceso, las carteras deben ser seleccionadas a través de la clasificación GRUPO ',
                                              'Seleccion Carteras',
                                              Mb_Ok);

                      Exit;
                    end;
                  Close;
                end;
            end
          else
            begin
              Combo_Cartera.Text   := '';
              bMuestra             := False;
              Chk_Carteras.ChecKed := False;
              bMuestra             := True;
              Ed_Proceso.Setfocus;
            end;
        end;
  end;

Function TFrmCalculoLimites.Nominales_Nemotecnico(sCodigo_Limite: String;
                                                  sEmisor       : String;
                                                  sInstrumento  : String;
                                                  sNemotecnico  : String): Double;
var
  fNominales        : Double;
  sInstrumento_Equiv: String;
begin
  // Result := 0;
  With Qry_Prdx do
    begin
      Close;
      Sql.Clear;
      Sql.Add(' SELECT Instrumento,SUM(Valor_Nominal) as Valor_Nominal FROM ' + T_TmpDatosLimite.Name //
            + ' WHERE Emisor        = :Emisor'
            + '   AND Codigo_Limite = :Codigo_Limite'
            + '   AND Nemotecnico   = :Nemotecnico'
            + '   GROUP BY Instrumento');
      Parambyname('Emisor').asString        := sEmisor;
      Parambyname('Nemotecnico').asString   := sNemotecnico;
      Parambyname('Codigo_Limite').asString := sCodigo_Limite;
      Qry_Prdx.Open;

      fNominales := 0;
      while Not Qry_Prdx.eof do
        begin
          Busca_Equivalencia('SUPER',
                            'INSTRUM',
                            Qry_Prdx.FieldByName('Instrumento').asString,
                            dFecha_Cierre,
                            sInstrumento_Equiv);
          If sInstrumento_Equiv = sInstrumento then
            fNominales := fNominales + Qry_Prdx.FieldByName('Valor_Nominal').asFloat;

          Qry_Prdx.Next;
        end;
      Close;
    end;
  Result := fNominales;
end;

procedure TFrmCalculoLimites.Group_Moneda_ConversionClick(Sender: TObject);
begin
  edMoneda.enabled := (Group_Moneda_Conversion.ItemIndex = 1);
end;

procedure TFrmCalculoLimites.BTN_Buscar_InverClick(Sender: TObject);
  // Var
  // Empresa: String;
  // cartera: String;
begin
  /// SOLO PERU POR CLASIFICACION 'GRUPO' 11052
  with T_TmpHelpLimites.FieldDefs do
    begin
      Clear;
      Add('Valor', ftAutoInc, 0, False);
      Add('Grupo_Cartera', ftString, 10, False);
      Add('Proceso', ftString, 10, False);
      Add('Fecha_de_Cierre', ftDateTime, 0, False);
      Add('Fecha_cierre_anterior', ftDateTime, 0, False);
      Add('Fecha_Inicio_anterior', ftDateTime, 0, False);
      Add('Tipo_conversion', ftString,30,False);
      Add('Moneda_conversion', ftString, 15,False);
      Add('Moneda_Conversion_Informe', ftString, 15, False);
    end;

  with T_TmpHelpLimites.IndexDefs do
    begin
      Clear;
      Add('Valor', 'Valor', [ixprimary]);
      Add('Grupo_Cartera', 'Grupo_Cartera', [ixCaseInsensitive]);
      Add('Proceso', 'Proceso', [ixCaseInsensitive]);
      Add('Fecha_de_Cierre', 'Fecha_de_Cierre', [ixCaseInsensitive]);
    end;
  T_TmpHelpLimites.CreateDataSet;
  T_TmpHelpLimites.Open;

  BTN_CancelarClick(Sender);

  With Qry_General do
    begin
      Close;
      Sql.Clear;
      Sql.Add(' SELECT Proceso'
            + '       ,Grupo_Cartera'
            + '       ,Fecha_de_Cierre'
            + '       ,Fecha_cierre_anterior'
            + '       ,Fecha_Inicio_anterior'
            + '       ,Tipo_conversion'
            + '       ,Moneda_conversion'
            + '       ,Moneda_Conversion_Informe'
            + '  FROM QS_SUP_251_PROCESO'
            + ' WHERE Empresa = :Empresa'
            + '  ORDER BY Fecha_de_Cierre'
            + '          ,Proceso'
            + '          ,Grupo_Cartera');
      Parambyname('Empresa').asString := sEmpresa_Usuario;
      Open;
      While Not eof do
        begin
          T_TmpHelpLimites.insert;
          T_TmpHelpLimites.FieldByName('Proceso').asString           := FieldByName('Proceso').asString;
          T_TmpHelpLimites.FieldByName('Grupo_Cartera').asString     := FieldByName('Grupo_Cartera').asString;
          T_TmpHelpLimites.FieldByName('Fecha_de_Cierre').AsDateTime := FieldByName('Fecha_de_Cierre').AsDateTime;
          if (FieldByName('Proceso').asString = 'SBS-11052') or (FieldByName('Proceso').asString = 'SBS-1041') then
            begin
              T_TmpHelpLimites.FieldByName('Fecha_cierre_anterior').AsDateTime := FieldByName('Fecha_cierre_anterior').AsDateTime;
              T_TmpHelpLimites.FieldByName('Fecha_Inicio_anterior').AsDateTime := FieldByName('Fecha_Inicio_anterior').AsDateTime;
              T_TmpHelpLimites.FieldByName('Tipo_conversion').asString         := FieldByName('Tipo_conversion').asString;
              T_TmpHelpLimites.FieldByName('Moneda_conversion').asString       := FieldByName('Moneda_conversion').asString;
            end;
          T_TmpHelpLimites.FieldByName('Moneda_Conversion_Informe').asString := FieldByName('Moneda_Conversion_Informe').asString;
          T_TmpHelpLimites.Post;
          Next;
        end;
      Close;
    end;

  if Busca_Limites_Inver.Execute then
    begin
      bMuestra                            := False;
      Chk_Carteras.State                  := cbChecked;
      bMuestra                            := True;
      Combo_Cartera.Text                  := T_TmpHelpLimites.FieldByName('Grupo_Cartera').asString;
      edFecha_Cierre.Date                 := solo_fecha(T_TmpHelpLimites.FieldByName('Fecha_de_Cierre').AsDateTime);
      Ed_Fecha.Date                       := solo_fecha(T_TmpHelpLimites.FieldByName('Fecha_de_Cierre').AsDateTime);
      edFecha_Cierre_Anterior.Date        := solo_fecha(T_TmpHelpLimites.FieldByName('Fecha_cierre_anterior').AsDateTime);
      edFecha_Inicio_Cierre_Anterior.Date := solo_fecha(T_TmpHelpLimites.FieldByName('Fecha_Inicio_anterior').AsDateTime);
      edTipo_Conversion.Text              := T_TmpHelpLimites.FieldByName('Tipo_conversion').asString;
      edMoneda_Conversion.Text            := T_TmpHelpLimites.FieldByName('Moneda_conversion').asString;
      Ed_Proceso.Text                     := T_TmpHelpLimites.FieldByName('Proceso').asString;
      Chk_SBS11052.enabled                := False;
      Chk_Carteras.enabled                := False;

      if T_TmpHelpLimites.FieldByName('Moneda_Conversion_Informe').asString = moneda_nacional_pais_Usuario(sPais_Usuario) then
        Group_Moneda_Conversion.ItemIndex := 0
      else
        begin
          Group_Moneda_Conversion.ItemIndex := 1;
          edMoneda.Text                     := T_TmpHelpLimites.FieldByName('Moneda_Conversion_Informe').asString;
        end;

      dFecha_Cierre                 := edFecha_Cierre.Date;
      dFecha_Cierre_Anterior        := edFecha_Cierre_Anterior.Date;
      dFecha_Inicio_Cierre_Anterior := edFecha_Inicio_Cierre_Anterior.Date;
      sTipo_Conversion              := edTipo_Conversion.Text;
      sMoneda_Conversion            := edMoneda_Conversion.Text;
      sTipo_Conversion              := edTipo_Conversion.Text;

      With Qry_General do
        begin
          Close;
          Sql.Clear;
          Sql.Add(' SELECT * FROM QS_SUP_251'
                + ' WHERE Empresa       = :Empresa'
                + '   AND Cartera       = :Cartera'
                + '   AND Fecha_Proceso = :Fecha_Proceso'
                + '   AND Proceso       = :Proceso'
                + '   AND Moneda_Conversion_Informe = :Moneda_Conversion_Informe');
          Parambyname('fecha_Proceso').AsDate               := solo_fecha(T_TmpHelpLimites.FieldByName('Fecha_de_Cierre').AsDateTime);
          Parambyname('Proceso').asString                   := T_TmpHelpLimites.FieldByName('Proceso').asString;
          Parambyname('Cartera').asString                   := T_TmpHelpLimites.FieldByName('Grupo_Cartera').asString;
          Parambyname('Empresa').asString                   := sEmpresa_Usuario;
          Parambyname('Moneda_Conversion_Informe').asString := T_TmpHelpLimites.FieldByName('Moneda_Conversion_Informe').asString;
          Open;
          if FieldByName('Cartera').IsNull then
            begin
              Close;
              T_TmpHelpLimites.Close;
              Exit;
            end;

          BTN_Gestion.enabled := True;
          Close;

          With Qry_General do
            begin
              Close;
              Sql.Clear;
              Sql.Add(' INSERT INTO QS_SYS_PARAM_EMPRESA ');
              Sql.Add(' SELECT :PID, z.cod_empresa,z.COD_CARTERA'
                    + '   FROM QS_FIN_CARTERAS z'
                    + '       ,qs_sys_clasif_obj a'
                    + '       ,qs_sys_est_cla b' +
                  '  WHERE a.objeto           = ''CARTERA'' '
                  + '    AND a.codigo_clasif    = ''GRUPO'' '
                  + '    AND a.elemento         = z.cod_cartera'
                  + '    AND b.codigo_objeto    = a.codigo_clasif'
                  + '    AND b.descripcion_nodo = :clasificacion'
                  + '    AND b.nodo             = a.nodo');
              if Combo_Cartera.Text = 'CONSOLIDA' then
                begin
                  Sql.Add(' UNION ');
                  Sql.Add(' SELECT distinct :PID, c.cod_empresa,c.cod_CARTERA'
                        + '   FROM QS_FIN_CARTERAS c'
                        + ' WHERE c.cod_Empresa = :Empresa');

                  // SQL.Add(' UNION ');
                  // Sql.Add(' SELECT distinct :PID, c.empresa,c.CARTERA'
                  // +'   FROM QS_SUP_251_DET c'
                  // +'       ,QS_SUP_251 d '
                  // +' WHERE d.Fecha_Proceso = :Fecha_Proceso'
                  // +'   AND d.Proceso       = :Proceso'
                  // +'   AND d.Cartera       = :Cartera'
                  // +'   AND d.Empresa       = :Empresa'
                  // +'   AND c.Fecha_Proceso = d.Fecha_Proceso'
                  // +'   AND c.Proceso       = d.Proceso'
                  // +'   AND c.Empresa       = d.Empresa'
                  // );

                  // ParamByname('fecha_Proceso').AsDate := solo_fecha(T_TmpHelpLimites.Fieldbyname('Fecha_de_Cierre').asDatetime);
                  // ParamByname('Proceso').asString     := T_TmpHelpLimites.Fieldbyname('Proceso').asString;
                  // ParamByname('Cartera').asString     := T_TmpHelpLimites.Fieldbyname('Grupo_Cartera').asString;
                  Parambyname('Empresa').asString := sEmpresa_Usuario;
                end;

              Parambyname('PID').asString           := FloatToStr(Application.Handle);
              Parambyname('clasificacion').asString := T_TmpHelpLimites.FieldByName('Grupo_Cartera').asString;

              try
                Qry_General.ExecSql
              except
                on E: EFDDBEngineException do
                  begin
                    ShowError(E)
                  end;
              end;
            end;
        end;
    end;
  T_TmpHelpLimites.Close;
  BTN_Gestion.enabled := True;
  Screen.Cursor       := crDefault;
end;

procedure TFrmCalculoLimites.BtnBuscaFechaCierreClick(Sender: TObject);
var
  sNada: String;
  // Fecha : String;
begin
  sNada := '';
  if Leer_FechaCierreGAAP_Sin_Empresa(dFecha_Cierre,
                                      dFecha_Cierre_Anterior,
                                      dFecha_Inicio_Cierre_Anterior,
                                      sTipo_Conversion,
                                      sMoneda_Conversion,
                                      True,
                                      False,
                                      False,
                                      False,
                                      False,
                                      sNada) then
    begin
      edFecha_Cierre.Date                 := dFecha_Cierre;
      edFecha_Cierre_Anterior.Date        := dFecha_Cierre_Anterior;
      edFecha_Inicio_Cierre_Anterior.Date := dFecha_Inicio_Cierre_Anterior;
      edTipo_Conversion.Text              := sTipo_Conversion;
      edMoneda_Conversion.Text            := sMoneda_Conversion;
      Ed_Fecha.Date                       := dFecha_Cierre;

      if sTipo_Conversion = 'Moneda_Caja' then
        edTipo_Conversion.Text := 'MONEDA CAJA'
      else
        if sTipo_Conversion = 'Moneda_Conversion' then
          begin
            edTipo_Conversion.Text   := 'MONEDA CONVERSION';
            edMoneda.Text            := sMoneda_Conversion;
            edMoneda_Conversion.Text := sMoneda_Conversion;
          end
        else
          if sTipo_Conversion = 'Moneda_Origen' then
            edTipo_Conversion.Text := 'MONEDA ORIGEN'
          else
            if sTipo_Conversion = 'Moneda_Cartera' then
              edTipo_Conversion.Text := 'MONEDA CARTERA'
            else
              edTipo_Conversion.Text := '';
    end
end;

procedure TFrmCalculoLimites.Inserta_Errores(sModulo_Error, sString_Error: String);
var
  i: Integer;
begin
  if sModulo_Error = 'Clasif.Grupo Emisor' then
    for i := 0 to VarArrayHighBound(Reg_Errores_Grupo.Emisor, 1) do
      begin
        if Reg_Errores_Grupo.Emisor[i] = T_TmpDatos.FieldByName('Emisor').asString then
          begin
            if Reg_Errores_Grupo.Error[i] = 'S' then
              Exit
            else
              Reg_Errores_Grupo.Error[i] := 'S';
          end;
      end;

  FrmReportErrores.T_Paradox.First;
  FrmReportErrores.T_Paradox.insert;
  FrmReportErrores.T_Paradox.FieldByName('Error').asString  := sString_Error;
  FrmReportErrores.T_Paradox.FieldByName('Modulo').asString := sModulo_Error;
  FrmReportErrores.T_Paradox.Post;
end;

procedure TFrmCalculoLimites.Obtiene_Vcto;
begin

  With Qry_General do
    begin
      Close;
      Sql.Clear;
      Sql.Add(' DELETE FROM QS_TMP_VCTO'
            + '  WHERE (PID = :PID '
            + '     OR fecha_proceso <= :Fecha_Proceso) ');

      Parambyname('PID').asFloat          := Application.Handle;
      Parambyname('Fecha_Proceso').AsDate := (dFecha_Cierre - 2);

      Try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E)
          end;
      end;

      Close;
      Sql.Clear;
      Sql.Add(' INSERT INTO QS_TMP_VCTO');
      Sql.Add(' SELECT :PID '
            + '       ,a.fecha_proceso '
            + '       ,a.PROCESO       '
            + '       ,a.codigo_limite '
            + '       ,a.codigo_rtpr   '
            + '       ,a.empresa '
            + '       ,a.transaccion '
            + '       ,a.folio_interno '
            + '       ,a.VALOR_NOMINAL '
            + '       ,a.valor_pte_mc_cpa '
            + '   FROM QS_TRA_251_DET a'
            + '       ,qs_tra_omd_det_rf b '
            + '  WHERE a.empresa       = :empresa '
            + '    AND a.Proceso       = :Proceso '
            + '    AND a.fecha_proceso = :Fecha_Proceso '
            + '    AND a.transaccion not IN (SELECT x.codigo_transaccion '
            + '                                FROM QS_SYS_TRAN_IMPLIC x '
            + '                               WHERE x.implicancia = ''RV'') '
            + '    AND a.transaccion in (SELECT x.codigo_transaccion '
            + '                                FROM QS_SYS_TRAN_IMPLIC x '
            +'                               WHERE x.implicancia = ''COMPRA'') '
            + '    AND a.empresa       = b.empresa '
            + '    AND a.transaccion   = b.transaccion  '
            + '    AND a.FOLIO_INTERNO = b.folio_interno '
            + '    AND a.nemotecnico   = b.nemotecnico  '
            + '    AND (b.fecha_vencimiento > a.fecha_proceso AND b.fecha_vencimiento <= :Fecha_Operacion) ');

      Parambyname('EMPRESA').asString       := sEmpresa_Usuario;
      Parambyname('Proceso').asString       := Ed_Proceso.Text;
      Parambyname('Fecha_Proceso').AsDate   := dFecha_Cierre;
      Parambyname('PID').asFloat            := Application.Handle;
      Parambyname('Fecha_Operacion').AsDate := dFecha_Ope;

      Try
        ExecSql;
      except
        on E: EFDDBEngineException do
          begin
            ShowError(E)
          end;
      end;
    end;

end;

procedure TFrmCalculoLimites.Actualiza_Limite_Trans(Sender: TObject);
var bAgrega, Result         : Boolean;
begin

  Obtiene_Vcto;

  // Encabezado
  Qry_General.Close;
  Qry_General.Sql.Clear;
  Qry_General.Sql.Add(' INSERT INTO QS_TRA_251'
                    + ' ( Empresa'
                    + ',Cartera'
                    + ',Fecha_Proceso'
                    + ',Proceso'
                    + ',Codigo_Limite'
                    + ',Tipo_Limite'
                    + ',Emisor'
                    + ',Instrumento'
                    + ',Nemotecnico'
                    + ',Moneda_Instrum'
                    + ',Grupo_Emisor'
                    + ',Porcentaje_Min'
                    + ',Porcentaje'
                    + ',Valor_Pte_Cartera'
                    + ',Minimo_Permitido'
                    + ',Maximo_Permitido'
                    + ',Matriz'
                    + ',Series_Inscritas'
                    + ',Grupo_Cartera'
                    + ',Tipo_Clasif'
                    + ',Grupo_Clasif'
                    + ',Moneda_Conversion_Informe'
                    + ' )'
                    + ' VALUES( :Empresa'
                    + ',:Cartera'
                    + ',:Fecha_Proceso'
                    + ',:Proceso'
                    + ',:Codigo_Limite'
                    + ',:Tipo_Limite'
                    + ',:Emisor'
                    + ',:Instrumento'
                    + ',:Nemotecnico'
                    + ',:Moneda_Instrum'
                    + ',:Grupo_Emisor'
                    + ',:Porcentaje_Min'
                    + ',:Porcentaje'
                    + ',:Valor_Pte_Cartera'
                    + ',:Minimo_Permitido'
                    + ',:Maximo_Permitido'
                    + ',:Matriz'
                    + ',:Series_Inscritas'
                    + ',:Grupo_Cartera'
                    + ',:Tipo_Clasif'
                    + ',:Grupo_Clasif'
                    + ',:Moneda_Conversion_Informe'
                    + ' )');

  T_TmpLimites.First;
  While Not T_TmpLimites.eof do
  begin
     Qry_Detalle.Close;
     Qry_Detalle.Sql.Clear;
     Qry_Detalle.Sql.Add('SELECT * FROM QS_TRA_251 '
                       + ' WHERE Empresa       = :EMPRESA'
                       + '   AND Proceso       = :Proceso'
                       + '   AND Fecha_Proceso = :Fecha_Proceso'
                       + '   AND Cartera       = :Cartera'
                       + '   AND codigo_limite = :codigo_limite');

     Qry_Detalle.Parambyname('EMPRESA').asString       := sEmpresa_Usuario;
     Qry_Detalle.Parambyname('Proceso').asString       := Ed_Proceso.Text;
     Qry_Detalle.Parambyname('Fecha_Proceso').AsDate   := dFecha_Cierre;
     Qry_Detalle.Parambyname('Cartera').asString       := Combo_Cartera.Text;
     Qry_Detalle.Parambyname('codigo_limite').asString := T_TmpLimites.FieldByName('Codigo_Limite').asString;

     Qry_Detalle.Open;

     if not Qry_Detalle.eof then
     begin
        fValor_Cambio := 1;
        if sMoneda_Nacional <> Qry_Detalle.FieldByName('Moneda_Conversion_Informe').asString then
        begin
            Leer_Valor_Cambio2_Mem(Qry_Detalle.FieldByName('Moneda_Conversion_Informe').asString,
                                    sMoneda_Nacional,
                                    'BC',
                                    dFecha_Cierre,
                                    fValor_Cambio,
                                    Result);
            if Not Result then
              begin
                fValor_Cambio := 1;
              end;
        end;

        if fValor_Cambio = 0  then
          fValor_Cambio := 1;

        Qry_Detalle.Sql.Clear;
        Qry_Detalle.Sql.Add('UPDATE QS_TRA_251 '
                          + '   SET Valor_Pte_Cartera = Valor_Pte_Cartera + :Valor_OMD '
                          + ' WHERE Empresa       = :EMPRESA'
                          + '   AND Proceso       = :Proceso'
                          + '   AND Fecha_Proceso = :Fecha_Proceso'
                          + '   AND Cartera       = :Cartera'
                          + '   AND codigo_limite = :codigo_limite');

        Qry_Detalle.Parambyname('EMPRESA').asString       := sEmpresa_Usuario;
        Qry_Detalle.Parambyname('Proceso').asString       := Ed_Proceso.Text;
        Qry_Detalle.Parambyname('Fecha_Proceso').AsDate   := dFecha_Cierre;
        Qry_Detalle.Parambyname('Cartera').asString       := Combo_Cartera.Text;
        Qry_Detalle.Parambyname('codigo_limite').asString := T_TmpLimites.FieldByName('Codigo_Limite').asString;
        Qry_Detalle.Parambyname('Valor_OMD').asFloat      := (T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat / fValor_Cambio);

        Try
          Qry_Detalle.ExecSql
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E)
            end;
        end;
     end
     else
     begin
        Qry_General.Parambyname('Empresa').asString          := sEmpresa_Usuario;
        Qry_General.Parambyname('Cartera').asString          := Combo_Cartera.Text;
        Qry_General.Parambyname('Proceso').asString          := Ed_Proceso.Text;
        Qry_General.Parambyname('Fecha_Proceso').AsDateTime  := dFecha_Cierre;
        Qry_General.Parambyname('Codigo_Limite').asString    := T_TmpLimites.FieldByName('Codigo_Limite').asString;
        Qry_General.Parambyname('Tipo_Limite').asString      := T_TmpLimites.FieldByName('Tipo_Limite').asString;
        Qry_General.Parambyname('Emisor').asString           := T_TmpLimites.FieldByName('Emisor').asString;
        Qry_General.Parambyname('Instrumento').asString      := T_TmpLimites.FieldByName('Instrumento').asString;
        Qry_General.Parambyname('Nemotecnico').asString      := T_TmpLimites.FieldByName('Nemotecnico').asString;
        Qry_General.Parambyname('Moneda_Instrum').asString   := T_TmpLimites.FieldByName('Moneda_Instrum').asString;
        Qry_General.Parambyname('Grupo_Emisor').asString     := T_TmpLimites.FieldByName('Grupo_Emisor').asString;
        Qry_General.Parambyname('Porcentaje_Min').asFloat    := T_TmpLimites.FieldByName('Porcentaje_Min').asFloat;
        Qry_General.Parambyname('Porcentaje').asFloat        := T_TmpLimites.FieldByName('Porcentaje').asFloat;
        Qry_General.Parambyname('Valor_Pte_Cartera').asFloat := T_TmpLimites.FieldByName('Valor_Pte_Cartera').asFloat;
        Qry_General.Parambyname('Minimo_Permitido').asFloat  := T_TmpLimites.FieldByName('Minimo_Permitido').asFloat;
        Qry_General.Parambyname('Maximo_Permitido').asFloat  := T_TmpLimites.FieldByName('Maximo_Permitido').asFloat;
        Qry_General.Parambyname('Matriz').asString           := T_TmpLimites.FieldByName('Matriz').asString;
        Qry_General.Parambyname('Series_Inscritas').asString := T_TmpLimites.FieldByName('Series_Inscritas').asString;
        Qry_General.Parambyname('Grupo_Cartera').asString    := sGrupo_Cartera;
        // 'GRUPO';
        Qry_General.Parambyname('Tipo_Clasif').asString               := T_TmpLimites.FieldByName('Tipo_Clasif').asString;
        Qry_General.Parambyname('Grupo_Clasif').asFloat               := T_TmpLimites.FieldByName('Grupo_Clasif').asFloat;
        Qry_General.Parambyname('Moneda_Conversion_Informe').asString := sMoneda_Nacional;

        Try
          Qry_General.ExecSql
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E)
            end;
        end;
        Qry_General.Close;
     end;
     T_TmpLimites.Next;
  end;

  T_TmpLimites.First;

  // Detalle
  Qry_General.Sql.Clear;
  Qry_General.Sql.Add(' INSERT INTO QS_TRA_251_DET '
                    + ' ( Empresa'
                    + ',Cartera'
                    + ',Proceso'
                    + ',Fecha_Proceso'
                    + ',Codigo_Limite'
                    + ',Codigo_RtPr'
                    + ',Transaccion'
                    + ',Folio_Interno'
                    + ',Item_Omd'
                    + ',Emisor'
                    + ',Instrumento'
                    + ',Serie'
                    + ',Nemotecnico'
                    + ',Moneda_Instrum'
                    + ',Valor_Nominal'
                    + ',Saldo_Insoluto'
                    + ',Monto_Inscrito'
                    + ',Valor_Pte_MC_Cpa'
                    + ',Clasif_Riesgo'
                    + ',Grupo_Emisor'
                    + ',Matriz'
                    + ',Series_Inscritas'
                    + ',Clasif_Limite'
                    + ',Tipo_Clasif'
                    + ',Grupo_Clasif'
                    + ' )'
                    + ' VALUES( :Empresa'
                    + ',:Cartera'
                    + ',:Proceso'
                    + ',:Fecha_Proceso'
                    + ',:Codigo_Limite'
                    + ',:Codigo_RtPr'
                    + ',:Transaccion'
                    + ',:Folio_Interno'
                    + ',:Item_Omd'
                    + ',:Emisor'
                    + ',:Instrumento'
                    + ',:Serie'
                    + ',:Nemotecnico'
                    + ',:Moneda_Instrum'
                    + ',:Valor_Nominal'
                    + ',:Saldo_Insoluto'
                    + ',:Monto_Inscrito'
                    + ',:Valor_Pte_MC_Cpa'
                    + ',:Clasif_Riesgo'
                    + ',:Grupo_Emisor'
                    + ',:Matriz'
                    + ',:Series_Inscritas'
                    + ',:Clasif_Limite'
                    + ',:Tipo_Clasif'
                    + ',:Grupo_Clasif' + ' )');
  T_TmpDatosLimite.First;
  While Not T_TmpDatosLimite.eof do
  begin
     if T_TmpLimites.eof then
     begin
        Qry_Detalle.Close;
        Qry_Detalle.Sql.Clear;
        Qry_Detalle.Sql.Add('SELECT * FROM QS_TRA_251 '
                          + ' WHERE Empresa       = :EMPRESA'
                          + '   AND Proceso       = :Proceso'
                          + '   AND Fecha_Proceso = :Fecha_Proceso'
                          + '   AND Cartera       = :Cartera'
                          + '   AND codigo_limite = :codigo_limite');

        Qry_Detalle.Parambyname('EMPRESA').asString       := sEmpresa_Usuario;
        Qry_Detalle.Parambyname('Proceso').asString       := Ed_Proceso.Text;
        Qry_Detalle.Parambyname('Fecha_Proceso').AsDate   := dFecha_Cierre;
        Qry_Detalle.Parambyname('Cartera').asString       := Combo_Cartera.Text;
        Qry_Detalle.Parambyname('codigo_limite').asString := T_TmpDatosLimite.FieldByName('Codigo_Limite').asString;

        Qry_Detalle.Open;

        if not Qry_Detalle.eof then
        begin
           fValor_Cambio := 1;
           if sMoneda_Nacional <> Qry_Detalle.FieldByName('Moneda_Conversion_Informe').asString then
           begin
               Leer_Valor_Cambio2_Mem(Qry_Detalle.FieldByName('Moneda_Conversion_Informe').asString,
                                       sMoneda_Nacional,
                                       'BC',
                                       dFecha_Cierre,
                                       fValor_Cambio,
                                       Result);

               if Not Result then
                 begin
                   fValor_Cambio := 1;
                 end;
           end;

           if fValor_Cambio = 0 then
             fValor_Cambio := 1;

           Qry_Detalle.Sql.Clear;
           Qry_Detalle.Sql.Add('UPDATE QS_TRA_251 '
                             + '   SET Valor_Pte_Cartera = Valor_Pte_Cartera + :Valor_OMD '
                             + ' WHERE Empresa       = :EMPRESA'
                             + '   AND Proceso       = :Proceso'
                             + '   AND Fecha_Proceso = :Fecha_Proceso'
                             + '   AND Cartera       = :Cartera'
                             + '   AND codigo_limite = :codigo_limite');

           Qry_Detalle.Parambyname('EMPRESA').asString       := sEmpresa_Usuario;
           Qry_Detalle.Parambyname('Proceso').asString       := Ed_Proceso.Text;
           Qry_Detalle.Parambyname('Fecha_Proceso').AsDate   := dFecha_Cierre;
           Qry_Detalle.Parambyname('Cartera').asString       := Combo_Cartera.Text;
           Qry_Detalle.Parambyname('codigo_limite').asString := T_TmpDatosLimite.FieldByName('Codigo_Limite').asString;
           Qry_Detalle.Parambyname('Valor_OMD').asFloat      := (T_TmpDatosLimite.FieldByName('Valor_Pte_MC_Cpa').asFloat / fValor_Cambio);

           Try
             Qry_Detalle.ExecSql
           except
             on E: EFDDBEngineException do
               begin
                 ShowError(E)
               end;
           end;
        end;
     end;

     bAgrega := True;
     if Trim(T_TmpDatosLimite.FieldByName('Transaccion').asString) = 'CRV' then
     begin
        Qry_Detalle.Close;
        Qry_Detalle.Sql.Clear;
        Qry_Detalle.Sql.Add('SELECT * FROM QS_TRA_251_DET '
                          + ' WHERE Empresa       = :EMPRESA'
                          + '   AND Proceso       = :Proceso'
                          + '   AND Fecha_Proceso = :Fecha_Proceso'
                          + '   AND Cartera       = :Cartera'
                          + '   AND codigo_limite = :codigo_limite'
                          + '   AND Codigo_RtPr   = :Codigo_RtPr');

        Qry_Detalle.Parambyname('EMPRESA').asString       := sEmpresa_Usuario;
        Qry_Detalle.Parambyname('Proceso').asString       := Ed_Proceso.Text;
        Qry_Detalle.Parambyname('Fecha_Proceso').AsDate   := dFecha_Cierre;
        Qry_Detalle.Parambyname('Cartera').asString       := T_TmpDatosLimite.FieldByName('Cartera').asString;
        Qry_Detalle.Parambyname('codigo_limite').asString := T_TmpDatosLimite.FieldByName('Codigo_Limite').asString;
        Qry_Detalle.Parambyname('Codigo_RtPr').asString   := T_TmpDatosLimite.FieldByName('Codigo_RtPr').asString;

        Qry_Detalle.Open;

        if not Qry_Detalle.eof then
        begin
           bAgrega := False;
           Qry_Detalle.Close;
           Qry_Detalle.Sql.Clear;
           Qry_Detalle.Sql.Add(' UPDATE QS_TRA_251_DET '
                             + '   SET valor_nominal = valor_nominal + :nominal '
                             + '      ,valor_pte_mc_cpa = valor_pte_mc_cpa + :valor_pte '
                             + ' WHERE Empresa       = :EMPRESA'
                             + '   AND Proceso       = :Proceso'
                             + '   AND Fecha_Proceso = :Fecha_Proceso'
                             + '   AND Cartera       = :Cartera'
                             + '   AND codigo_limite = :codigo_limite'
                             + '   AND Codigo_RtPr   = :Codigo_RtPr');

           Qry_Detalle.Parambyname('EMPRESA').asString       := sEmpresa_Usuario;
           Qry_Detalle.Parambyname('Proceso').asString       := Ed_Proceso.Text;
           Qry_Detalle.Parambyname('Fecha_Proceso').AsDate   := dFecha_Cierre;
           Qry_Detalle.Parambyname('Cartera').asString       := T_TmpDatosLimite.FieldByName('Cartera').asString;
           Qry_Detalle.Parambyname('codigo_limite').asString := T_TmpDatosLimite.FieldByName('Codigo_Limite').asString;
           Qry_Detalle.Parambyname('Codigo_RtPr').asString   := T_TmpDatosLimite.FieldByName('Codigo_RtPr').asString;
           Qry_Detalle.Parambyname('nominal').asFloat        := T_TmpDatosLimite.FieldByName('valor_Nominal').asFloat;
           Qry_Detalle.Parambyname('valor_pte').asFloat      := (T_TmpDatosLimite.FieldByName('Valor_Pte_MC_Cpa').asFloat / fValor_Cambio);

           try
             Qry_Detalle.ExecSql
           except
             on E: EFDDBEngineException do
               begin
                 ShowError(E)
               end;
           end;
           Qry_Detalle.Close;
        end;
     end;

     if bAgrega then
     begin
        Qry_General.Close;
        Qry_General.Parambyname('Empresa').asString         := sEmpresa_Usuario;
        Qry_General.Parambyname('Cartera').asString         := T_TmpDatosLimite.FieldByName('Cartera').asString;
        Qry_General.Parambyname('Proceso').asString         := Ed_Proceso.Text;
        Qry_General.Parambyname('Fecha_Proceso').AsDateTime := dFecha_Cierre;
        Qry_General.Parambyname('Codigo_Limite').asString   := T_TmpDatosLimite.FieldByName('Codigo_Limite').asString;
        Qry_General.Parambyname('Codigo_RtPr').asString     := T_TmpDatosLimite.FieldByName('Codigo_RtPr').asString;
        if Trim(T_TmpDatosLimite.FieldByName('Transaccion').asString) = '' then
        begin
            Qry_General.Parambyname('Transaccion').asString   := 'CRV';
            Qry_General.Parambyname('Folio_Interno').asString := ' ';
            Qry_General.Parambyname('Item_Omd').asFloat       := 0;
        end
        else
        begin
            Qry_General.Parambyname('Transaccion').asString := T_TmpDatosLimite.FieldByName('Transaccion').asString;
            if T_TmpDatosLimite.FieldByName('Folio_Interno').IsNull then
              Qry_General.Parambyname('Folio_Interno').asString := ' '
            else
              Qry_General.Parambyname('Folio_Interno').asString := T_TmpDatosLimite.FieldByName('Folio_Interno').asString;
            Qry_General.Parambyname('Item_Omd').asFloat         := T_TmpDatosLimite.FieldByName('Item_Omd').asFloat;
        end;
        Qry_General.Parambyname('Emisor').asString           := T_TmpDatosLimite.FieldByName('Emisor').asString;
        Qry_General.Parambyname('Instrumento').asString      := T_TmpDatosLimite.FieldByName('Instrumento').asString;
        Qry_General.Parambyname('Serie').asString            := T_TmpDatosLimite.FieldByName('Serie').asString;
        Qry_General.Parambyname('Nemotecnico').asString      := T_TmpDatosLimite.FieldByName('Nemotecnico').asString;
        Qry_General.Parambyname('Moneda_Instrum').asString   := T_TmpDatosLimite.FieldByName('Moneda_Instrum').asString;
        Qry_General.Parambyname('valor_Nominal').asFloat     := T_TmpDatosLimite.FieldByName('valor_Nominal').asFloat;
        Qry_General.Parambyname('Saldo_Insoluto').asFloat    := T_TmpDatosLimite.FieldByName('Saldo_Insoluto').asFloat;
        Qry_General.Parambyname('Monto_Inscrito').asFloat    := T_TmpDatosLimite.FieldByName('Monto_Inscrito').asFloat;
        Qry_General.Parambyname('Valor_Pte_MC_Cpa').asFloat  := (T_TmpDatosLimite.FieldByName('Valor_Pte_MC_Cpa').asFloat / fValor_Cambio);
        Qry_General.Parambyname('Clasif_Riesgo').asString    := T_TmpDatosLimite.FieldByName('Clasif_Riesgo').asString;
        Qry_General.Parambyname('Grupo_Emisor').asString     := T_TmpDatosLimite.FieldByName('Grupo_Emisor').asString;
        Qry_General.Parambyname('Matriz').asString           := T_TmpDatosLimite.FieldByName('Matriz').asString;
        Qry_General.Parambyname('Series_Inscritas').asString := T_TmpDatosLimite.FieldByName('Series_Inscritas').asString;
        Qry_General.Parambyname('Clasif_Limite').asString    := T_TmpDatosLimite.FieldByName('Clasif_Limite').asString;
        Qry_General.Parambyname('Tipo_Clasif').asString      := T_TmpDatosLimite.FieldByName('Tipo_Clasif').asString;
        Qry_General.Parambyname('Grupo_Clasif').asFloat      := T_TmpDatosLimite.FieldByName('Grupo_Clasif').asFloat;
        try
          Qry_General.ExecSql
        except
          on E: EFDDBEngineException do
            begin
              ShowError(E)
            end;
        end;
     end;

     Qry_General.Close;
     T_TmpDatosLimite.Next;
  end;

  With Qry_General do
  begin
     Close;
     Sql.Clear;
     Sql.Add(' DELETE FROM QS_TMP_VCTO'
           + '  WHERE PID = :PID ');

     Parambyname('PID').asFloat := Application.Handle;

     Try
       ExecSql;
     except
       on E: EFDDBEngineException do
         begin
           ShowError(E)
         end;
     end;

  end;

  T_TmpDatos.EmptyDataSet;
  T_TmpLimites.EmptyDataSet;
  T_TmpDatosLimite.EmptyDataSet;

end;

function TFrmCalculoLimites.Monto_ReservaNva(dfecha_desde : TdateTime;
                                             sTipo_reserva: String)  : Double;
begin
  // Result := 0;
  With Qry_General do
    begin
      Close;
      Sql.Clear;
      Sql.Add(' SELECT a.*'
            + ' FROM QS_FIN_DATADIC_EMPRESA a'
            + ' WHERE a.empresa = :Empresa');
      Sql.Add('   AND (a.cartera in ' + sString_Carteras);
      Sql.Add('    OR a.cartera IS NULL OR a.cartera = '''') ');
      Sql.Add('   AND a.codigo = :codigo ');
      Sql.Add('   AND a.Fecha = (SELECT MAX(x.Fecha) FROM QS_FIN_DATADIC_EMPRESA x'
                              + ' WHERE x.empresa = :Empresa'
                              + '   AND x.Fecha <= :Fecha_Cierre)');

      Parambyname('Empresa').asString    := sEmpresa_Usuario;
      Parambyname('Fecha_Cierre').AsDate := dfecha_desde;
      Parambyname('codigo').asString     := sTipo_reserva;

      try
        Open;
        Result := FieldByName('Valor').asFloat;
      except
        Result := 0;
      end;
    end;
end;

end.
