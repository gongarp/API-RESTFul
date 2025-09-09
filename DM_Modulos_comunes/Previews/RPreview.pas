unit RPreview;
//1:  Temporal
//2:  Qry
//3:  Fisica
interface
{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Menus, ComCtrls, ImgList, frxCtrls, frxDock,
  ToolWin, frxPreviewPages, frxClass, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, LibXL,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxGraphics, comobj,
  ShellApi, Vcl.Mask, frxDCtrl, frxExportPDF,IniFiles, frxPreview, cxImageList,
  System.ImageList

{$IFDEF FPC}
  , LResources, LCLType, LCLProc, LCLIntf, LazHelper, lmf4
{$ENDIF}
{$IFDEF Delphi6}
, Variants
{$ENDIF};

 {$warn comparison_true off}
{$if (not declared(LibXLVersion)) or (LibXLVersion < '03.08.02.01')}
  //{$warn message_directive on}{$MESSAGE WARN 'Need update "LibXL.pas"'}
  {$MESSAGE FATAL 'Need update "LibXL.pas"'}
{$ifend}{$warnings on} // ! D2007 required $IFEND

const
  WM_UPDATEZOOM = WM_USER + 1;
  fLargo_minimo = 20;
  fLargo_Maximo = 220;


type
  TfrxPreviewTool = (ptHand, ptZoom); // not implemented, backw compatibility only
  TfrxPageChangedEvent = procedure(Sender: TfrxPreview; PageNo: Integer) of object;

  TFrmRPreview = class(TForm)
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    Qry_excel: TFDQuery;
    Table_ExcelFis: TFDTable;
    RightMenu: TPopupMenu;
    CollapseMI: TMenuItem;
    ExpandMI: TMenuItem;
    N1: TMenuItem;
    HiddenMenu: TPopupMenu;
    Showtemplate1: TMenuItem;
    ExportPopup: TPopupMenu;
    cxImageList1: TcxImageList;
    ToolBar1: TToolBar;
    PrintB: TToolButton;
    openB: TToolButton;
    saveB: TToolButton;
    Sep1: TToolButton;
    PdfB: TToolButton;
    Btn_Excel: TToolButton;
    EmailB: TToolButton;
    ToolButton2: TToolButton;
    findB: TToolButton;
    ZoomPlusB: TToolButton;
    FullScreenBtn: TToolButton;
    Sep2: TToolButton;
    PageSettingsB: TToolButton;
    Sep5: TToolButton;
    FirstB: TToolButton;
    PriorB: TToolButton;
    nextB: TToolButton;
    LastB: TToolButton;
    CancelB: TToolButton;
    ZoomMinusB: TToolButton;
    Sep3: TfrxTBPanel;
    ZoomCB: TComboBox;
    Sep4: TfrxTBPanel;
    OfNL: TLabel;
    PageE: TEdit;
    frxPreview1: TfrxPreview;
    OutLineB: TToolButton;
    Table_Excel: TFDMemTable;
    SaveDialog2: TSaveDialog;
    Qry_Login_descargas: TFDQuery;

    procedure OnCancel(Sender: TObject);
    procedure PageEClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZoomMinusBClick(Sender: TObject);
    procedure ZoomCBClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FirstBClick(Sender: TObject);
    procedure PriorBClick(Sender: TObject);
    procedure NextBClick(Sender: TObject);
    procedure LastBClick(Sender: TObject);
    procedure PrintBClick(Sender: TObject);
    procedure OpenBClick(Sender: TObject);
    procedure SaveBClick(Sender: TObject);
    procedure FindBClick(Sender: TObject);
    procedure PdfBClick(Sender: TObject);
    procedure EmailB1Click(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageSettingsBClick(Sender: TObject);
    procedure FullScreenBtnClick(Sender: TObject);
    procedure OnPreviewDblClick(Sender: TObject);
    procedure ZoomPlusBClick(Sender: TObject);
    procedure OutlineBClick(Sender: TObject);
    procedure ThumbBClick(Sender: TObject);
    procedure CollapseAllClick(Sender: TObject);
    procedure ExpandAllClick(Sender: TObject);
    //procedure FormResize(Sender: TObject);
    //procedure UpdateControls;
     procedure OnCloseReportPreview (Sender: TObject);
     procedure WMUpdateZoom(var Message: TMessage); message WM_UPDATEZOOM;

    procedure SetZoom(const Value: Extended);
    procedure SetZoomMode(const Value: TfrxZoomMode);
   procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    //procedure RxSpinEdit1Change(Sender: TObject);
    procedure Btn_ExcelClick(Sender: TObject);
    //procedure PageEChange(Sender: TObject);
    procedure frxPreview1PageChanged(Sender: TfrxPreview; PageNo: Integer);
    procedure PageEChange(Sender: TObject);
    procedure frxPreview1DblClick(Sender: TObject);
    //procedure AddCloseBtnToImageList;
    //procedure Btn_ImprimirClick(Sender: TObject);
//    procedure Export(Filter: TfrxCustomExportFilter);
  private
    { Private declarations }
    FAllowF3: Boolean;
    FSplitter: TSplitter;
    FOutline: TTreeView;
    FPageNo: Integer;
    FOnPageChanged: TfrxPageChangedEvent;
    FRunning: Boolean;
    FFreeOnClose: Boolean;
    FOldBS: TFormBorderStyle;
    FOldState: TWindowState;
    FFullScreen: Boolean;
    FRefreshing: Boolean;
    FPDFExport: TfrxCustomExportFilter;
    FEmailExport: TfrxCustomExportFilter;
    FLastFoundPage: Integer;
    FThumbnail: TfrxPreviewWorkspace;
    FWorkspace: TfrxPreviewWorkspace;
    //FPreview: TfrxPreview;
    function GetOutlineVisible: Boolean;
    function GetOutlineWidth: Integer;
    function GetPageCount: Integer;
    function GetThumbnailVisible: Boolean;
    procedure SetOutlineWidth(const Value: Integer);
    procedure SetOutlineVisible(const Value: Boolean);
    procedure SetPageNo(Value: Integer);
    procedure SetThumbnailVisible(const Value: Boolean);
    function GetReport: TfrxReport;
    procedure ExportMIClick(Sender: TObject);
    procedure UpdateZoom;

  public

     nTot_Pag     : integer;
     bPrueba      : Boolean;
     Table_Qry    : integer;


    { Public declarations }
     property Preview: TfrxPreview read frxPreview1;
     property Report: TfrxReport read GetReport;
    // procedure Clear;
    procedure Export(Filter: TfrxCustomExportFilter);
     procedure SwitchToFullScreen;
    property PageCount: Integer read GetPageCount;
    property PageNo: Integer read FPageNo write SetPageNo;
//    property Zoom: Extended read FZoom write SetZoom;
//    property ZoomMode: TfrxZoomMode read FZoomMode write SetZoomMode;
    //procedure AddPreviewTab(AReport: TfrxReport; const TabName: String; const TabCaption: String = '');
    procedure Cancel;
    property FreeOnClose: Boolean read FFreeOnClose write FFreeOnClose;
    property OnPageChanged: TfrxPageChangedEvent read FOnPageChanged write FOnPageChanged;
//Funciones para exportar excel directo
  procedure ExportToExcel(sFileName  : String; Table_Genera : TFDTable;
                               sTituloExcel : String); overload;
  procedure ExportToExcel(sFileName  : String; Table_Genera : TFDMemTable;
                               sTituloExcel : String); overload ;
  procedure ExportToExcel(sFileName  : String; Table_Genera : TFDQuery;
                               sTituloExcel : String); overload;
 published
    property Align;
    property OutlineVisible: Boolean read GetOutlineVisible write SetOutlineVisible;
    //property OutlineWidth: Integer read GetOutlineWidth write SetOutlineWidth;
    property PopupMenu;
    //property ThumbnailVisible: Boolean read GetThumbnailVisible write SetThumbnailVisible;
   end;

 procedure QueryToTxt_2( sFileName  : String;
                          sSeparador : String;
                          Query      : TFDQuery;
                          sin_ceros  : Boolean;
                          sTituloExcel : String
                         );

  procedure QueryToTxt_3( sFileName  : String;      // Sin Cabezera
                          sSeparador : String;
                          Query      : TFDQuery
                         );

  procedure TableToTxt_2(sFileName  : String;
                         sSeparador : String;
                         TableExcel      : TFDMemTable;
                         sin_ceros  : Boolean;
                         Titulo : string);
  procedure TableToTxt_3(sFileName  : String;
                         sSeparador : String;
                         TableExcel      : TFDTable;
                         sin_ceros  : Boolean ;
                         Titulo : string
                         );

  procedure EscribeTableNombresColumnas( sSeparador : String;
                                         TableExcel      : TFDTable);
  procedure EscribeQueryNombresColumnas( sSeparador : String;
                                         Query      : TFDQuery);
  procedure EscribeTableMemNombresColumnas( sSeparador : String;
                                         TableExcel      : TFDMemTable);

  procedure QueryToTxt( sFileName  : String;
                        sSeparador : String;
                        Query      : TFDQuery);

  procedure QueryToTxtConParametros( sFileName        : String;
                                     sSeparador       : String;
                                     Query            : TFDQuery;
                                     bTitulosColumnas : Boolean;
                                     bUltimoSeparador : Boolean;
                                     sTitulo          : String;
                                     sFormatoFecha    : String
                                   );

  procedure TableToTxt( sFileName  : String;
                        sSeparador : String;
                        Table      : TFDTable);
  procedure TableToTxt_4( sFileName  : String;
                        sSeparador : String;
                        Table      : TFDMemTable);

  procedure TableToTxtNoTit( sFileName  : String;
                             sSeparador : String;
                             Table      : TFDTable);

  procedure TableToTxtNoTit_2( sFileName  : String;
                             sSeparador : String;
                             Table      : TFDMemTable);

  procedure Genera_Excel_Qry(Qry_Genera : TFDQuery;
                             sTituloExcel : String);

  procedure Genera_Excel_Qry_Sin_Cabezera(Qry_Genera : TFDQuery;
                                          sTituloExcel : String);

  procedure Genera_Excel_Table(Table_Genera : TFDTable;
                               sTituloExcel : String); overload
  procedure Genera_Excel_Table(Table_Genera : TFDMemTable;
                               sTituloExcel : String); overload;

  procedure Genera_Excel_Table_Sin_Ceros(Table_Genera : TFDMemTable;
                                         sTituloExcel : String);

  procedure Genera_Excel_Qry_Con_Nombre( Qry_Genera : TFDQuery;
                                         sTituloExcel : String;
                                         sTituloArchivo : String
                                         );
  procedure Genera_Excel_Qry_Sin_Ceros(Qry_Genera : TFDQuery;
                                       sTituloExcel : String);
  procedure Genera_Excel_Qry_Visibles(Qry_Genera : TFDQuery;
                                      sTituloExcel : String);


 ///////// genera Excel con Libxl ////////////////////////////
  procedure Genera_excel_dll(qry_genera :  TFDQuery;
                             sTituloExcel : String;
                             sin_cero : Boolean); overload
  procedure Genera_excel_dll(Table_Genera : TFDTable;
                             sTituloExcel : String;
                             sin_cero : Boolean); overload
  procedure Genera_excel_dll(Table_Genera : TFDMemTable;
                             sTituloExcel : String;
                             sin_cero : Boolean); overload

  procedure Genera_excel_dll_libro_hojas(qry_genera :  TFDQuery;
                                         sTituloExcel : String;
                                         sin_cero : Boolean ;
                                         sArchivo_Excel : String);  overload
  procedure Genera_excel_dll_libro_hojas(Table_Genera : TFDTable;
                                         sTituloExcel : String;
                                         sin_cero : Boolean ;
                                         sArchivo_Excel : String); overload
  procedure Genera_excel_dll_libro_hojas(Table_Genera : TFDMemTable;
                                         sTituloExcel : String;
                                         sin_cero : Boolean ;
                                         sArchivo_Excel : String); overload

  procedure Genera_excel_dll_libro_hojas(qry_genera        : TFDQuery;
                                         sTituloExcel      : String;
                                         sin_cero          : Boolean;
                                         bImprimeInvisible : Boolean;
                                         sArchivo_Excel    : String);  overload
  procedure Genera_excel_dll_libro_hojas(Table_Genera      : TFDTable;
                                         sTituloExcel      : String;
                                         sin_cero          : Boolean ;
                                         bImprimeInvisible : Boolean;
                                         sArchivo_Excel    : String); overload
  procedure Genera_excel_dll_libro_hojas(Table_Genera      : TFDMemTable;
                                         sTituloExcel      : String;
                                         sin_cero          : Boolean ;
                                         bImprimeInvisible : Boolean;
                                         sArchivo_Excel    : String); overload

  procedure Genera_excel_dll_libro_hojas(qry_genera     : TFDQuery;
                                         sTituloExcel   : String;
                                         sTituloPestana : String;
                                         sin_cero       : Boolean;
                                         sArchivo_Excel : String);  overload

  procedure Genera_excel_dll_libro_hojas(qry_genera     : TFDMemTable;
                                         sTituloExcel   : String;
                                         sTituloPestana : String;
                                         sin_cero       : Boolean;
                                         sArchivo_Excel : String); overload

  procedure Genera_excel_color(qry_genera     :  TFDQuery;
                               sTituloExcel   :  String;
                               iCampos_desde  :  Integer);

////Funciones para exportar excel directo
//  procedure ExportToExcel(sFileName  : String; Table_Genera : TFDTable;
//                               sTituloExcel : String); overload
//  procedure ExportToExcel(sFileName  : String; Table_Genera : TFDMemTable;
//                               sTituloExcel : String); overload
//  procedure ExportToExcel(sFileName  : String; Table_Genera : TFDQuery;
//                               sTituloExcel : String); overload;

var
  FrmRPreview  : TFrmRPreview;
  F : TextFile;
  FZoom: Extended;
  FZoomMode: TfrxZoomMode;
  PageNo: Integer;
  bImprimeInvisible : Boolean;
  bSincabezara      : Boolean;
  bNombreLibre      : Boolean;
  snombre_descarga,
  event_ant,
  susuario       : string;
  dfecha_descarga :Tdatetime;
  sUserName, sHostName, sIPaddr, sMacAddr : String;
  DatosOk,bInsertado : Boolean;
  p : integer;



implementation
{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses
  {$IFNDEF FPC}Printers,{$ENDIF} frxPrinter, frxSearchDialog, frxUtils, frxRes, frxDsgnIntf,
  frxPreviewPageSettings, frxDMPClass,      DM_Variables_Menu
     ,DM_Comun
     ,DM_Base_Datos
     ,DM_Global_Var
     ,Jd_Tools
     ,DM_Identidad_Direccion
     ,uSystemInfo
     ,ConsultaGeneracionExcel;

var
  TextToFind: String;
  TextFound: Boolean;
  TextBounds: TRect;
  RecordNo: Integer;
  LastFoundRecord: Integer;
  CaseSensitive: Boolean;
  SaveDialog1: TSaveDialog;



procedure EscribeQueryNombresColumnas( sSeparador : String;
                                                    Query      : TFDQuery);
var
  i : integer;
begin
  for i := 0 to Query.FieldCount-1 do
    Write(F,Query.Fields[i].FieldName+sSeparador);
  Writeln(F,'');
end;

procedure EscribeTableNombresColumnas( sSeparador : String;
                                                    TableExcel      : TFDTable);
var
  i : integer;
begin
  for i := 0 to TableExcel.FieldCount-1 do
    Write(F,TableExcel.Fields[i].FieldName+sSeparador);
  Writeln(F,'');
end;

procedure EscribeTableMemNombresColumnas( sSeparador : String;
                                                    TableExcel      : TFDMemTable);
var
  i : integer;
begin
  for i := 0 to TableExcel.FieldCount-1 do
    Write(F,TableExcel.Fields[i].FieldName+sSeparador);
  Writeln(F,'');
end;

procedure QueryToTxt(sFileName  : String;
                                  sSeparador : String;
                                  Query      : TFDQuery);
var
   i : Integer;
begin
  AssignFile(F,sFileName);
  ReWrite(F);
  EscribeQueryNombresColumnas( sSeparador,Query );
  //FrmRPreview.ProgressBar1.Max := Query.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible := True;
  with Query do
    begin
      DisableControls;
      first;
      while not EOF do
      begin
         for i := 0 to FieldCount-1 do
           if (Fields[i].AsString = '30/12/1899') then
              Write(F,'0'+sSeparador)
           else
              Write(F,Fields[i].AsString+sSeparador);
         next;

         //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
         Application.ProcessMessages;
         Writeln(F,'');
      end;
      first;
      //FrmRPreview.ProgressBar1.Visible := False;
      EnableControls;
      CloseFile(F);
    end;
end;

procedure QueryToTxtConParametros( sFileName        : String;
                                   sSeparador       : String;
                                   Query            : TFDQuery;
                                   bTitulosColumnas : Boolean;
                                   bUltimoSeparador : Boolean;
                                   sTitulo          : String;
                                   sFormatoFecha    : String
                                 );
var
   i       : Integer;
   sString : String;
begin
  AssignFile(F,sFileName);
  ReWrite(F);

  if sTitulo <> '' then
    Writeln(F,sTitulo);

  with Query do
    begin
      if bTitulosColumnas then
      begin
        for i := 0 to Query.FieldCount-1 do
          if (NOT bUltimoSeparador) AND
             ( (Fields[1].AsString = '') or (i = FieldCount-1)
              ) then
             Write(F,Query.Fields[i].FieldName)
          else
             Write(F,Query.Fields[i].FieldName+sSeparador);
        Writeln(F,'');
      end;
      //FrmRPreview.ProgressBar1.Max := Query.RecordCount;
      //FrmRPreview.ProgressBar1.Position := 0;
      //FrmRPreview.ProgressBar1.Visible := True;
      DisableControls;
      first;
      while not EOF do
      begin
         for i := 0 to FieldCount-1 do
         begin
           sString :=  Fields[i].AsString;
           if Fields[i].DataType in [ftDateTime,ftDate] then
           begin
              if sFormatoFecha <> '' then
              begin
                 if Fields[i].AsFloat <> 0 then
                    sString :=  FormatDateTime(sFormatoFecha,Fields[i].AsDatetime)
                 else
                    sString := '';
              end;
           end;

           if (NOT bUltimoSeparador) AND
              ( (Fields[1].AsString = '') or (i = FieldCount-1)
               ) then
              Write(F,sString)
           else
              Write(F,sString+sSeparador);
         end; // end for
         next;

         //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
         Application.ProcessMessages;
         Writeln(F,'');
      end;
      first;
      //FrmRPreview.ProgressBar1.Visible := False;
      EnableControls;
      CloseFile(F);
    end;
end;

procedure TableToTxt(sFileName  : String;
                     sSeparador : String;
                     Table      : TFDTable);
var
   i : Integer;
begin
  AssignFile(F,sFileName);
  ReWrite(F);
  //FrmRPreview.ProgressBar1.Max := Table.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible := True;
  EscribeTableNombresColumnas( sSeparador,Table );
  with Table do
    begin
      DisableControls;
      first;
      while not EOF do
        begin
          for i := 0 to FieldCount-1 do
            Write(F,Fields[i].AsString+sSeparador);
          next;
          //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
          Application.ProcessMessages;
          Writeln(F,'');
        end;
      first;
      //FrmRPreview.ProgressBar1.Visible := False;
      EnableControls;
      CloseFile(F);
    end;
end;

procedure TableToTxt_4(sFileName  : String;
                     sSeparador : String;
                     Table      : TFDMemTable);
var
   i : Integer;
   sValor  : string;
begin
  AssignFile(F,sFileName);
  ReWrite(F);
  //FrmRPreview.ProgressBar1.Max := Table.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible := True;
  EscribeTableMemNombresColumnas( sSeparador,Table );
  with Table do
    begin
      DisableControls;
      first;
      while not EOF do
        begin
          for i := 0 to FieldCount-1 do
          if Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            sValor := floattostr(Fields[i].asFloat );
            Write(F,sValor+sSeparador);
          end
          else
            Write(F,Fields[i].AsString+sSeparador);
          next;
          //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
          Application.ProcessMessages;
          Writeln(F,'');
        end;
      first;
      //FrmRPreview.ProgressBar1.Visible := False;
      EnableControls;
      CloseFile(F);
    end;
end;

procedure TableToTxtNoTit(sFileName  : String;
                          sSeparador : String;
                          Table      : TFDTable);
var
   i : Integer;
begin
  AssignFile(F,sFileName);
  ReWrite(F);
  //FrmRPreview.ProgressBar1.Max := Table.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible := True;
  with Table do
    begin
      DisableControls;
      first;
      while not EOF do
        begin
          for i := 0 to FieldCount-1 do
          begin
            if (Fields[0].AsString = '')  or (i = FieldCount-1) then
               Write(F,Fields[i].AsString)
            else
               Write(F,Fields[i].AsString+sSeparador);
          end;
          next;
          //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
          Application.ProcessMessages;
          Writeln(F,'');
        end;
      first;
      //FrmRPreview.ProgressBar1.Visible := False;
      EnableControls;
      CloseFile(F);
    end;
end;
procedure TableToTxtNoTit_2(sFileName  : String;
                          sSeparador : String;
                          Table      : TFDMemTable);
var
   i : Integer;
begin
  AssignFile(F,sFileName);
  ReWrite(F);
  //FrmRPreview.ProgressBar1.Max := Table.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible := True;
  with Table do
    begin
      DisableControls;
      first;
      while not EOF do
        begin
          for i := 0 to FieldCount-1 do
          begin
            if (Fields[0].AsString = '')  or (i = FieldCount-1) then
               Write(F,Fields[i].AsString)
            else
               Write(F,Fields[i].AsString+sSeparador);
          end;
          next;
          //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
          Application.ProcessMessages;
          Writeln(F,'');
        end;
      first;
      //FrmRPreview.ProgressBar1.Visible := False;
      EnableControls;
      CloseFile(F);
    end;
end;

procedure TFrmRPreview.OnCloseReportPreview (Sender: TObject);
begin
   Report.Free;
end;

procedure TFrmRPreview.FormCreate(Sender: TObject);
begin
  bImprimeInvisible := True;      //  08/11/2017  por problemas con Grilla con los campos   PA, GG y FI
  WindowState  := wsMaximized;
  ZoomCB.Items.Clear;
  ZoomCB.Items.Add('25%');
  ZoomCB.Items.Add('50%');
  ZoomCB.Items.Add('75%');
  ZoomCB.Items.Add('100%');
  ZoomCB.Items.Add('150%');
  ZoomCB.Items.Add('200%');
  ZoomCB.Items.Add(frxResources.Get('zmPageWidth'));
  ZoomCB.Items.Add(frxResources.Get('zmWholePage'));

  frxPreview1 := TfrxPreview.Create(Self);
  frxPreview1.Parent := Self;
  frxPreview1.Align := alClient;
  frxPreview1.BorderStyle := bsNone;
  {$IFNDEF FPC}
  frxPreview1.BevelKind := bkNone;
  {$ENDIF}


 Sep3.ParentBackground := False;
  Sep4.ParentBackground := False;
  frxPreview1.OnDblClick := OnPreviewDblClick;
  ActiveControl := frxPreview1;


end;

procedure TFrmRPreview.SetZoom(const Value: Extended);

begin
  FZoom := Value;
  if FZoom < 0.25 then
    FZoom := 0.25;

  FZoomMode := zmDefault;
  //UpdatePages;
end;

procedure TFrmRPreview.SetZoomMode(const Value: TfrxZoomMode);
   var
     FZoomMode :  TfrxZoomMode ;
begin
  FZoomMode := Value;
  //UpdatePages;
end;

function TFrmRPreview.GetPageCount: Integer;
begin
  if frxPreview1 <> nil then
    Result := frxPreview1.PageCount
  else
    Result := 0;
end;

function TFrmRPreview.GetOutlineVisible: Boolean;
begin
  Result := FOutline.Visible;
end;

procedure TFrmRPreview.SetOutlineVisible(const Value: Boolean);
begin
  FOutline.Visible := Value;
  FSplitter.Visible := Value;
  FSplitter.SetBounds(1000, 0, 2, 0);
end;


function TFrmRPreview.GetThumbnailVisible: Boolean;
begin
  Result := FThumbnail.Visible;
end;

procedure TFrmRPreview.SetThumbnailVisible(const Value: Boolean);
var
  NeedChange: Boolean;
begin
  NeedChange := Value <> FThumbnail.Visible;

  FSplitter.Visible := Value or frxPreview1.OutlineVisible;
  FThumbnail.Visible := Value;

  if UseRightToLeftAlignment then
    FThumbnail.Left := Width;

  if Value then
    FOutline.Visible := False;

  if Value then
  begin
    FThumbnail.HorzPosition := FThumbnail.HorzPosition;
    FThumbnail.VertPosition := FThumbnail.VertPosition;
  end;
  if Owner is TfrxPreviewForm then
    TfrxPreviewForm(Owner).ThumbB.Down := Value;
//  if NeedChange then
//    UpdatePages;
end;

function TFrmRPreview.GetOutlineWidth: Integer;
begin
  Result := FOutline.Width;
end;

procedure TFrmRPreview.SetOutlineWidth(const Value: Integer);
begin
  FOutline.Width := Value;
  if not (csDesigning in ComponentState) then
    FThumbnail.Width := Value;
end;

procedure TFrmRPreview.SetPageNo(Value: Integer);
var
  ActivePageChanged: Boolean;
begin
  if Value < 1 then
    Value := 1;
  if Value > PageCount then
    Value := PageCount;
  ActivePageChanged := FPageNo <> Value;
  FPageNo := Value;

end;

procedure TFrmRPreview.EmailB1Click(Sender: TObject);
begin
  if Assigned(FEmailExport) then
    frxPreview1.Export(FEmailExport);
end;
{
procedure TFrmRPreview.UpdatePageNumbers;
begin
  if Assigned(FOnPageChanged) then
    FOnPageChanged(Self, FPageNo);
end;  }
procedure TFrmRPreview.Export(Filter: TfrxCustomExportFilter);
begin
  if FRunning then Exit;
  try
    frxPreview1.PreviewPages.CurPreviewPage := PageNo;
    if Report.DotMatrixReport and (frxDotMatrixExport <> nil) and
      (Filter.ClassName = 'TfrxTextExport') then
      Filter := frxDotMatrixExport;
    frxPreview1.PreviewPages.Export(Filter);
  finally
   begin
    report.Preview.Unlock;
    report.Preview.Repaint;
    report.Preview.RefreshReport;
   end;
  end;
end;

procedure TFrmRPreview.PdfBClick(Sender: TObject);
begin
     if Assigned(FPDFExport) then
        report.Export(FPDFExport);
end;
procedure TFrmRPreview.CollapseAllClick(Sender: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
begin
  frxPreview1.Lock;
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      TfrxGroupHeader(c).ExpandDrillDown := False;
  end;
  Report.DrillState.Clear;
  frxPreview1.RefreshReport;
  frxPreview1.SetPosition(0,0);
end;

procedure TFrmRPreview.ExpandAllClick(Sender: TObject);
var
  l: TList;
  i: Integer;
  c: TfrxComponent;
begin
  frxPreview1.Lock;
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
  begin
    c := l[i];
    if (c is TfrxGroupHeader) and TfrxGroupHeader(c).DrillDown then
      TfrxGroupHeader(c).ExpandDrillDown := True;
  end;
  Report.DrillState.Clear;
  frxPreview1.RefreshReport;
end;

procedure TFrmRPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FFreeOnClose then
    Action := caFree;
  if (Report <> nil) and (Assigned(Report.OnClosePreview)) then
    Report.OnClosePreview(Self);

end;

function TFrmRPreview.GetReport: TfrxReport;
begin
  Result := FrxPreview1.Report;
end;

procedure TFrmRPreview.OnPreviewDblClick(Sender: TObject);
begin
  if FFullScreen then
    SwitchToFullScreen;
end;

procedure TFrmRPreview.SwitchToFullScreen;
begin
  if not FFullScreen then
  begin
    //StatusBar.Visible := False;
    ToolBar1.Visible := False;
    FOldBS := BorderStyle;
    FOldState := WindowState;
    BorderStyle := bsNone;
    WindowState := {$IFDEF FPC}wsFullScreen {$ELSE}wsMaximized{$ENDIF};
    FFullScreen := True;
  end
  else
  begin
    WindowState := FOldState;
    BorderStyle := FOldBS;
    FFullScreen := False;
    //StatusBar.Visible := True;
    ToolBar1.Visible := True;
  end;
end;

procedure TFrmRPreview.FullScreenBtnClick(Sender: TObject);
begin
  SwitchToFullScreen;
end;
procedure TFrmRPreview.PageSettingsBClick(Sender: TObject);
begin
  FrxPreview1.PageSetupDlg;
end;

procedure TFrmRPreview.PageEChange(Sender: TObject);
vaR
FirstPass: Boolean;
begin
  FirstPass := False;
  if frxPreview1.PreviewPages <> nil then
    FirstPass := not frxPreview1.PreviewPages.Engine.FinalPass;

  begin
    OfNL.Caption := 'De '+ IntToStr(frxPreview1.PageCount);
    Sep4.Width := OfNL.Left + OfNL.Width + 4;
  end;
  PageE.Text := IntToStr(frxPreview1.PageNo);

  //FrxPreview1.PageNo := StrToInt(PageE.Text);
  //FrxPreview1.SetFocus;

end;

procedure TFrmRPreview.PageEClick(Sender: TObject);
VAR
   FirstPass: Boolean;
begin
  FirstPass := False;
  if frxPreview1.PreviewPages <> nil then
    FirstPass := not frxPreview1.PreviewPages.Engine.FinalPass;

  begin
    OfNL.Caption := 'De '+ IntToStr(frxPreview1.PageCount);
    Sep4.Width := OfNL.Left + OfNL.Width + 4;
  end;
  FrxPreview1.PageNo := StrToInt(PageE.Text);
  FrxPreview1.SetFocus;

end;
procedure TFrmRPreview.UpdateZoom;
begin
  ZoomCB.Text := IntToStr(Round(FrxPreview1.Zoom * 100)) + '%';
end;

procedure TFrmRPreview.WMUpdateZoom(var Message: TMessage);
begin
  UpdateZoom;
end;
procedure TFrmRPreview.ZoomCBClick(Sender: TObject);
var
  s: String;
begin
  FrxPreview1.SetFocus;

  if ZoomCB.ItemIndex = 6 then
    FrxPreview1.ZoomMode := zmPageWidth
  else if ZoomCB.ItemIndex = 7 then
    FrxPreview1.ZoomMode := zmWholePage
  else
  begin
    s := ZoomCB.Text;

    if Pos('%', s) <> 0 then
      s[Pos('%', s)] := ' ';
    while Pos(' ', s) <> 0 do
      Delete(s, Pos(' ', s), 1);

    if s <> '' then
      FrxPreview1.Zoom := frxStrToFloat(s) / 100;
  end;

  PostMessage(Handle, WM_UPDATEZOOM, 0, 0);
end;

procedure TFrmRPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    CancelBClick(Self);
  if Key = VK_F11 then
    SwitchToFullScreen;
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TFrmRPreview.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if ActiveControl = ZoomCB then
      ZoomCBClick(nil);
    if ActiveControl = PageE then
      PageEClick(nil);
  end;
end;



procedure TFrmRPreview.frxPreview1DblClick(Sender: TObject);
begin
  if FFullScreen then
    SwitchToFullScreen;

end;

procedure TFrmRPreview.frxPreview1PageChanged(Sender: TfrxPreview;
  PageNo: Integer);
var
FirstPass: Boolean;
begin
  FirstPass := False;
  if frxPreview1.PreviewPages <> nil then
    FirstPass := not frxPreview1.PreviewPages.Engine.FinalPass;

  begin
    OfNL.Caption := 'De '+ IntToStr(frxPreview1.PageCount);
    Sep4.Width := OfNL.Left + OfNL.Width + 4;
  end;
  PageE.Text := IntToStr(frxPreview1.PageNo);

  //FrxPreview1.PageNo := StrToInt(PageE.Text);
  //FrxPreview1.SetFocus;

end;

//procedure TFrmRPreview.PageEChange(Sender: TObject);
//var
{procedure TFrmRPreview.OnPageChanged(Sender: TfrxPreview; PageNo: Integer);
var
FirstPass: Boolean;
begin
  FirstPass := False;
  if TFrmRPreview.PreviewPages <> nil then
    FirstPass := not TFrmRPreview.PreviewPages.Engine.FinalPass;

  begin
    TFrmRPreview.OfNL.Caption := 'De '+ IntToStr(TFrmRPreview.PageCount);
    TFrmRPreview.Sep4.Width := TFrmRPreview.OfNL.Left + TFrmRPreview.OfNL.Width + 4;
  end;
  TFrmRPreview.PageE.Text := IntToStr(TFrmRPreview.PageNo);

  //FrxPreview1.PageNo := StrToInt(PageE.Text);
  //FrxPreview1.SetFocus;

end; }

procedure TFrmRPreview.FormActivate(Sender: TObject);
var
  i, j, k: Integer;
  m, e: TMenuItem;

  begin
  //frxPreview1.AddPreviewTab(Report, ExtractFileName(Report.FileName));
  frxPreview1.DoubleBuffered := True;
  frxPreview1.OutlineWidth := Report.PreviewOptions.OutlineWidth;
  frxPreview1.OutlineVisible := Report.PreviewOptions.OutlineVisible;
  frxPreview1.ThumbnailVisible := Report.PreviewOptions.ThumbnailVisible;
  frxPreview1.ZoomMode := Report.PreviewOptions.ZoomMode;
  frxPreview1.zoom := Report.PreviewOptions.Zoom;


  frxPreview1.First;
  frxPreview1.PageNo := 1;
  PageE.Text := '1';
  PageE.Text := IntToStr(frxPreview1.PageNo);
  OfNL.Caption := 'De '+ IntToStr(frxPreview1.PageCount);
  Sep4.Width := OfNL.Left + OfNL.Width + 4;

  FFullScreen := False;
  FPDFExport := nil;
  FEmailExport := nil;

  with Report.PreviewOptions do
  begin
    PrintB.Visible := pbPrint in Buttons;
    OpenB.Visible := pbLoad in Buttons;
    SaveB.Visible := (pbSave in Buttons) or (pbExport in Buttons);
    FindB.Visible := pbFind in Buttons;
    PdfB.Visible := False;
    EmailB.Visible := False;
//    with Qry_excel do
//      begin
//       if SQL.Text='' then
//          Btn_Excel.Visible := false;
//    end;
    Btn_Excel.Visible := (Table_Qry=1) or (Table_Qry=2) or (Table_Qry=3) or (Table_Qry=11)or (Table_Qry=22)or (Table_Qry=33);
    ZoomPlusB.Visible := pbZoom in Buttons;
    ZoomMinusB.Visible := pbZoom in Buttons;
    Sep3.Visible := pbZoom in Buttons;
    FullScreenBtn.Visible := (pbZoom in Buttons) and not (pbNoFullScreen in Buttons);
    if not (pbZoom in Buttons) then
      Sep1.Visible := False;

//    OutlineB.Visible := pbOutline in Buttons;
//    ThumbB.Visible := pbOutline in Buttons;
    PageSettingsB.Visible := pbPageSetup in Buttons;
    OutlineB.Visible := pbOutline in Buttons;
    OutlineB.Down := OutlineVisible;
    PageSettingsB.Visible := pbPageSetup in Buttons;

    if not (PageSettingsB.Visible) then
      Sep2.Visible := False;

    FirstB.Visible := pbNavigator in Buttons;
    PriorB.Visible := pbNavigator in Buttons;
    NextB.Visible := pbNavigator in Buttons;
    LastB.Visible := pbNavigator in Buttons;
    Sep4.Visible := pbNavigator in Buttons;

    if not (pbNavigator in Buttons) then
      Sep5.Visible := False;

    CancelB.Visible := not (pbNoClose in Buttons);

  end;
  ExportPopup.Items.Clear;
  if pbSave in Report.PreviewOptions.Buttons then
  begin
    m := TMenuItem.Create(ExportPopup);

    ExportPopup.Items.Add(m);
    //m.Caption := frxResources.Get('clFP3files') + '...';
    m.OnClick := SaveBClick;
    if pbExport in Report.PreviewOptions.Buttons then
    begin
      m := TMenuItem.Create(ExportPopup);
      ExportPopup.Items.Add(m);
      m.Caption := '-';
    end;
  end;

  for i := 0 to frxExportFilters.Count - 1 do
  begin
    if frxExportFilters[i].Filter = frxDotMatrixExport then
      continue;
    if pbExport in Report.PreviewOptions.Buttons then
      if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName <> 'TfrxMailExport' then
      begin
        m := TMenuItem.Create(ExportPopup);
        ExportPopup.Items.Add(m);
        m.Caption := TfrxCustomExportFilter(frxExportFilters[i].Filter).GetDescription + '...';
        m.Tag := i;
        m.OnClick := ExportMIClick;
      end;
    if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxPDFExport' then
    begin
      FPDFExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
      PdfB.Visible := pbExportQuick in Report.PreviewOptions.Buttons;
    end;
    if not (pbNoEmail in Report.PreviewOptions.Buttons) then
    begin
      if TfrxCustomExportFilter(frxExportFilters[i].Filter).ClassName = 'TfrxMailExport' then
      begin
        FEmailExport := TfrxCustomExportFilter(frxExportFilters[i].Filter);
        EmailB.Visible := pbExportQuick in Report.PreviewOptions.Buttons;
      end;
    end
    else EmailB.Visible := False;
  end;

  if Report.ReportOptions.Name <> '' then
    Caption := Report.ReportOptions.Name;

  k := 0;
  RightMenu.Items.Clear;

  RightMenu.Images := ToolBar1.Images;
  for i := 0 to ToolBar1.ButtonCount - 1 do
  begin
    if (ToolBar1.Buttons[i].Style <> tbsCheck) and
       (ToolBar1.Buttons[i].Visible) and
       (ToolBar1.Buttons[i].Hint <> '') then
    begin
      m := TMenuItem.Create(RightMenu);
      RightMenu.Items.Add(m);
      ToolBar1.Buttons[i].Tag := frxInteger(m);
      m.Caption := ToolBar1.Buttons[i].Hint;
      m.OnClick := ToolBar1.Buttons[i].OnClick;
      m.ImageIndex := ToolBar1.Buttons[i].ImageIndex;
      if Assigned(ToolBar1.Buttons[i].DropdownMenu) then
        for j := 0 to ToolBar1.Buttons[i].DropdownMenu.Items.Count - 1 do
        begin
          e := TMenuItem.Create(m);
          e.Caption := ToolBar1.Buttons[i].DropdownMenu.Items[j].Caption;
          e.Tag := ToolBar1.Buttons[i].DropdownMenu.Items[j].Tag;
          e.OnClick := ToolBar1.Buttons[i].DropdownMenu.Items[j].OnClick;
          m.Add(e);
        end;
    end;
    if ToolBar1.Buttons[i].Style = tbsSeparator then
    begin
      if k = 1 then
        break;
      m := TMenuItem.Create(RightMenu);
      RightMenu.Items.Add(m);
      m.Caption := '-';
      Inc(k);
    end;
  end;
  if UseRightToLeftAlignment then
    FlipChildren(True);

  //UpdateControls;
  //Report.OnClosePreview := OnCloseReportPreview;
  PopupMenu := RightMenu;
  //report.Preview.Update;

/// registro log de Descargas en los informes de papel
  if Table_Qry = 2 then
     p := Qry_excel.RecordCount
  else
 if Table_Qry = 3 then
     p := Table_ExcelFis.RecordCount
  else
     p := Table_excel.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;
  snombre_descarga := ValidaCaracteresArchivo(Report.ReportOptions.Name);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);
  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if (not  binsertado) or (event_ant <> copy(snombre_descarga,1,100))  then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
         dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_Login_descargas do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
        event_ant := copy(snombre_descarga,1,100);
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;
end;

procedure TFrmRPreview.PrintBClick(Sender: TObject);
begin
  frxPreview1.Print;
  Enabled := True;
end;

procedure TFrmRPreview.OpenBClick(Sender: TObject);
begin
  frxPreview1.LoadFromFile;
  if Report.ReportOptions.Name <> '' then
    Caption := Report.ReportOptions.Name
  else
    Caption := frxGet(100);
end;

procedure TFrmRPreview.FindBClick(Sender: TObject);
begin
  frxPreview1.Find;
end;

procedure TFrmRPreview.ZoomPlusBClick(Sender: TObject);
begin
  frxPreview1.Zoom := frxPreview1.Zoom + 0.25;
  UpdateZoom;
end;

procedure TFrmRPreview.ZoomMinusBClick(Sender: TObject);
begin
  frxPreview1.Zoom := frxPreview1.Zoom - 0.25;
  UpdateZoom;
end;

procedure TFrmRPreview.SaveBClick(Sender: TObject);
begin
  frxPreview1.SaveToFile;
end;

procedure TFrmRPreview.FirstBClick(Sender: TObject);
begin
  frxPreview1.PageNo := 1;
  frxPreview1.First;
  PageE.text := IntToStr(frxPreview1.PageNo);
end;

procedure TFrmRPreview.PriorBClick(Sender: TObject);
begin
  //frxPreview1.PageNo := frxPreview1.PageNo - 1;
  //PageNo := PageNo - 1;
  frxPreview1.Prior;
  PageE.text := IntToStr(frxPreview1.PageNo);
end;

procedure TFrmRPreview.NextBClick(Sender: TObject);
begin
   frxPreview1.Next;
  PageE.text := IntToStr(frxPreview1.PageNo);
end;

procedure TFrmRPreview.LastBClick(Sender: TObject);
begin
  frxPreview1.Last;
  PageE.text := IntToStr(frxPreview1.PageCount);
end;

procedure TFrmRPreview.ExportMIClick(Sender: TObject);
begin
  Report.Export(TfrxCustomExportFilter(frxExportFilters[TMenuItem(Sender).Tag].Filter));
  Enabled := True;
end;
procedure TFrmRPreview.OutlineBClick(Sender: TObject);
begin
  frxPreview1.OutlineVisible := not (frxPreview1.OutlineVisible);
  //frxPreview1.UpdateZoom;

end;

procedure TFrmRPreview.ThumbBClick(Sender: TObject);
begin
//  frxPreview1.ThumbnailVisible := ThumbB.Down;
end;
procedure TFrmRPreview.OnCancel(Sender: TObject);
begin
  Report.Terminated := True;
end;

procedure TFrmRPreview.Cancel;
begin
  if FRunning then
    OnCancel(Self);
end;

procedure TFrmRPreview.CancelBClick(Sender: TObject);
begin
  if FRunning then
     frxPreview1.Cancel
     else
      close;
end;

procedure TFrmRPreview.Btn_ExcelClick(Sender: TObject);
var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   Result         : Boolean;
   bSalir         : Boolean;
   bConsulta      : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
   btexto         :  Boolean;
begin
  btexto := False;
  if Report.ReportOptions.Name.IsEmpty then
     Report.ReportOptions.Name := 'LIBRO 1';

 {Cambia el formato de fecha y numero para toda la aplicación} //DC 25/06/2010
  if not bPrueba then
  begin
  bPrueba := True;
  FormatSettings.DateSeparator        := '/';
  FormatSettings.ShortDateFormat      := 'dd/MM/yyyy';
//  FormatSettings.ThousandSeparator    := '.';  //
//  FormatSettings.DecimalSeparator     := ',';

  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  //sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+IntToStr(MSec)+'.Html';
  //sArchivo_Excel := ValidaCaracteresArchivo(QRPrinter.PreviewCaption);

  //////////

  Delay(1000);
  //DC 05/06/2013
  if (length(directorio_temp) + fLargo_minimo) > fLargo_maximo then
  begin
    application.messagebox('Path del Temp excede maximo de caracteres permitidos'
                          ,'Excel'
                          ,MB_Ok);
    exit;
  end;

  sArchivo_Excel := ValidaCaracteresArchivo(Report.ReportOptions.Name);
  sArchivo_Excel := ValidaCaracteresCirculares(sArchivo_Excel);

  sArchivo_Excel := trim(copy(sArchivo_Excel,1,(fLargo_Maximo - (length(directorio_temp) + fLargo_minimo))));

////////////

   //DC 05/06/2013
  sArchivo_Excel := directorio_temp
                    +sArchivo_Excel
                    +'--'
                    +IntToStr(Hour)
                    +IntToStr(Min)
                    +IntToStr(Sec)
                    +IntToStr(MSec)
                    +'.Html';

  if Table_Qry = 2 then
     iNro_registros := Qry_excel.RecordCount
  else
 if Table_Qry = 3 then
     iNro_registros := Table_ExcelFis.RecordCount
  else
     iNro_registros := Table_excel.RecordCount;

  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
     bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;

    if Table_Qry = 22 then
       begin
       ExportToExcel(sArchivo_Excel, Qry_excel,Report.ReportOptions.Name);
       Exit
       end
    else
    if Table_Qry = 33 then
       begin
       ExportToExcel(sArchivo_Excel, Table_excelFis,Report.ReportOptions.Name ) ;
       Exit
       end
    else
    if Table_Qry = 11 then
       begin
       ExportToExcel(sArchivo_Excel, Table_excel,Report.ReportOptions.Name );
       Exit
       end;

    if bGeneraExcel then
    begin
      if Table_Qry = 2 then
      begin
         Qry_excel.FetchOptions.RecordCountMode := cmTotal;
         if (bExiste_Dll) and (Qry_excel.RecordCount < 65000) then
         begin
            genera_excel_dll(Qry_excel,Report.ReportOptions.Name,False);
         end
         else
         begin
            btexto := True;
            QueryToTxt_2(sArchivo_Excel, sSeparador, Qry_excel, True,Report.ReportOptions.Name);
         end;

      end
      else
      if Table_Qry = 3 then
      begin
         Table_excelFis.FetchOptions.RecordCountMode := cmTotal;
         if (bExiste_Dll) and (Table_excelFis.RecordCount < 65000) then
         begin
            genera_excel_dll(Table_excelFis,Report.ReportOptions.Name,False);
         end
         else
          begin
            btexto := True;
            TableToTxt_3(sArchivo_Excel, sSeparador, Table_excelFis, True,Report.ReportOptions.Name );
          end;
      end
      else
      begin
         Table_excel.FetchOptions.RecordCountMode := cmTotal;
         if (bExiste_Dll) and (Table_excel.RecordCount < 65000) then
         begin
            genera_excel_dll(Table_excel,Report.ReportOptions.Name,False);
         end
         else
         begin
            btexto := True;
            TableToTxt_2(sArchivo_Excel, sSeparador, Table_excel, True,Report.ReportOptions.Name );
         end;
      end;

     if btexto then
      ShellExecute(Application.Handle,
                   'open',
                   PChar('excel.exe'),
                   pchar(sArchivo_Excel),
                   nil,
                   SW_SHOW
                   );
    end
    else
      if SaveDialog2.Execute then
         if Table_Qry = 2 then
            QueryToTxt(SaveDialog2.FileName, sSeparador, Qry_excel )
         else
         if Table_Qry = 3 then
            TableToTxt(SaveDialog2.FileName ,sSeparador, Table_excelFis )
         else
            TableToTxt_4(SaveDialog2.FileName ,sSeparador, Table_excel )
  end;
  bPrueba := False;
  end;
end;

procedure QueryToTxt_2( sFileName  : String;
                        sSeparador : String;
                        Query      : TFDQuery;
                        sin_ceros  : Boolean;
                        sTituloExcel : String
                      );
var
   i : Integer;
   tipoDato : TFieldType;
   sRazon_Social,
   sDireccion,
   sTitulo,
   sPiePagina,
   sValor,
   S1,S2,S3,
   sUbicacion : String;
   fValor     : Double;
   Result     : Boolean;
   iFieldCount: Integer;
begin
  AssignFile(F,sFileName);

  try
    ReWrite(F);
  except
//      begin
//        Application.MessageBox('Archivo esta siendo utilizado o esta corrupto ...'
//                               ,'Impresion'
//                               , mb_OK);
//        exit;
//      end;
  end;

  //TFrmRPreview.ProgressBar1.Max      := Query.RecordCount;
  //TFrmRPreview.ProgressBar1.Position := 0;
  //TFrmRPreview.ProgressBar1.Visible  := True;

  Leer_Identidad_Direccion(sEmpresa_Usuario,
                           fItem_Dir_Usuario,
                           sRazon_Social,
                           sDireccion,
                           sUbicacion,
                           Result);
  with Query do
  begin
    //close;
    DisableControls;
    // Titulo
    Writeln( F , '<HTML xmlns:o="urn:schemas-microsoft-com:office:office"' );
    Writeln( F , 'xmlns:x="urn:schemas-microsoft-com:office:excel"' );
    Writeln( F , '>' );
    Writeln( F , '<head>' );
    Writeln( F , '<style>' );
    Writeln( F , '<!--table' );
    if GetLocaleInformation(LOCALE_SDECIMAL) = '.' then
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\.";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\,";}' );
    end
    else
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\,";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\.";}' );
    end;
    // El tipo .text Fuerza el formato texto (ELIMINA EL PROBLEMA QUE SE PIERDEN LOS CEROS A LA IZQUIERDA y qur 2-09 lo toma como fecha
    // F.I. 22-05-2013
    Writeln( F , '.text');
    Writeln( F , '{mso-number-format:"\@";/*force text*/}');
    // El tipo .x125 es para formatear variables de Fecha
    Writeln( F , '.xl25' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:"Short Date";}' );
    // El tipo .x124 es para formatear variables numericas
    Writeln( F , '.xl24' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:Standard;}' );
    // El tipo .x132 es para formatear variables String
    Writeln( F , '.xl32' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'text-align:left;' );
    Writeln( F , '-->' );
    Writeln( F , '</style>' );
    Writeln( F , '<BODY topmargin=4 leftmargin=0 marginheight=0 marginwidth=0>' );
    Writeln( F , '<h3>' );
    Writeln( F , '<font color="#000080" size="1"> '+sRazon_Social);
    Writeln( F , '</h3>' );
    Writeln( F , '<h3>' );
    Writeln( F , '<font color="#000080" size="1">'+sDireccion);
    Writeln( F , '</h3>' );
    Writeln( F , '<h3>' );
    Writeln( F , '<font color="#000080" size="1">'+sUbicacion);
    Writeln( F , '</h3>' );

    // este es el titulo del Informe

    sTitulo := FrmRPreview.Caption;
    sPiePagina := '';
    if Pos( 'Quick', FrmRPreview.Caption) > 0 then
       sTitulo := '';

    sTitulo := sTituloExcel;
    if Pos( '|', sTitulo) > 0 then
    begin
       sPiePagina := copy(sTitulo
                         ,Pos( '|', sTitulo)+1
                         ,length(stitulo));
       sTitulo := copy(sTitulo
                      ,1
                      ,Pos( '|', sTitulo) - 1
                      );
    end;

    //ggarcia 08-08-2017
    iFieldCount := 0;
    if not bImprimeInvisible then
    begin
       for i := 0 to Query.FieldCount-1 do
          if Fields[i].visible = true then
             iFieldCount := iFieldCount +1;
    end
    else
        iFieldCount := Query.FieldCount;

    Writeln( F , '<TABLE u1:str BORDER = 1 width = 100% aling = center bordercolor =#00008B >' );
    //ggarcia 08-08-2017
    //Writeln( F , '<TH width="100%" colspan="'+IntToStr(Query.FieldCount)+'" bgcolor="#D3D3D3">'+sTitulo );
    Writeln( F , '<TH width="100%" colspan="'+IntToStr(iFieldCount)+'" bgcolor="#D3D3D3">'+sTitulo );
    Writeln( F , '</TH>' );

    Writeln( F , '<tr>' );
    // Escribo nombre de columnas
    for i := 0 to Query.FieldCount-1 do
    begin
       //ggarcia 08-08-2017
       if (Fields[i].visible = true) or (bImprimeInvisible) then
       begin
          Writeln(F, '<TH width="100%" bgcolor="#D3D3D3">'+Query.Fields[i].DisplayLabel);
          Writeln(F, '</TH>');
       end;
    end;
    Writeln( F , '</tr>' );

    First;
    while not EOF do
    begin
       Writeln( F , '<tr>' );
       For i := 0 to FieldCount-1 do
       begin
	     if (Fields[i].visible = true) or (bImprimeInvisible) then
          begin
          tipoDato := Fields[i].DataType;
          if Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
             fValor := Fields[i].AsFloat;
             sValor := FloatToStrF(fValor, ffNumber,30,8);          //  no cambiar
             if (not sin_ceros) and (Fields[i].asFloat = 0) then
               sValor := '';
//             if sin_ceros then
//                //ggarcia 10-06-2016
//                //sValor := FormatFloat( '###,###,###,##0.000000000000000', Fields[i].asFloat )
//                sValor := FormatFloat( '###,###,###,##0.00000000', Fields[i].asFloat )
//             else
//                //ggarcia 10-06-2016
//                //sValor := FormatFloat( '###,###,###,###.###############', Fields[i].asFloat );
//                sValor := FormatFloat( '###,###,###,###.########', Fields[i].asFloat );
             //sValor := PadL( sValor, ' ', 20 );
             Writeln(F,'<TD class=xl24>'+ sValor )
          end
          else if Fields[i].DataType in [ftDateTime,ftDate] then
             if Fields[i].asFloat <> 0 then
                Writeln(F,'<TD class=xl25 x:num="'+Trim(FloatToStr(Fields[i].asFloat))+'">'+DateToStr( Fields[i].AsDatetime ))
             else
                //Writeln(F,'<TD class=xl32>'+'' )
                Writeln(F,'<TD class="text">'+'' )
          else
          begin
             S1 := UpperCase(Query.Fields[i].DisplayLabel);
             S2 := 'FOLIO';
             S3 := STRPAS(StrPos(Pchar(s1),PChar(S2)));
             if trim(S3) <> '' then  /// OJO!!!
             begin
               try
                 fValor := Fields[i].asFloat;
                 sValor := FloatToStrF(fValor, ffNumber, 30,0);
                 //sValor := PadL( sValor, ' ', 20 );
                 Writeln(F,'<TD class=xl24>'+ sValor );
               except
                 Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
               end;
             end
             else
               Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
//          else if Fields[i].DataType in [ftDateTime,ftDate] then
//             Writeln(F,'<TD class=xl25 x:num="'+Trim(FloatToStr(Fields[i].asFloat))+'">'+DateToStr( Fields[i].AsDatetime ))
//          else
//             Writeln(F,'<TD class=xl32>'+Trim(Fields[i].AsString) );
          end;
          Writeln( F , '</TD >' );
         end;
       end;
       Writeln( F , '</tr>' );
       Next;
       //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
       Application.ProcessMessages;
    end;

    if sPiePagina <> '' then
    begin
       Writeln( F , '</TABLE>' );
       Writeln( F , '<TABLE u1:str BORDER = 1 width = 100% aling = left bordercolor =#00008B >' );
       Writeln( F , '<TH width="100%" colspan="'+IntToStr(Query.FieldCount)+'" bgcolor="#D3D3D3">'+sPiePagina );
       Writeln( F , '</TH>' );
       Writeln( F , '</TABLE>' );
    end;

    Writeln( F , '</BODY>' );
    Writeln( F , '</HTML>' );

    First;
    //FrmRPreview.ProgressBar1.Visible := False;
    EnableControls;
    CloseFile(F);
  end;
end;

procedure QueryToTxt_3( sFileName  : String;
                        sSeparador : String;
                        Query      : TFDQuery
                      );
var
   i : Integer;
   sRazon_Social,
   sDireccion,
   sValor,
   S1,S2,S3,
   sUbicacion : String;
   fValor     : Double;
   Result     : Boolean;
begin
  AssignFile(F,sFileName);
  ReWrite(F);
  //FrmRPreview.ProgressBar1.Max      := Query.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible  := True;

  Leer_Identidad_Direccion(sEmpresa_Usuario,
                           fItem_Dir_Usuario,
                           sRazon_Social,
                           sDireccion,
                           sUbicacion,
                           Result);
  with Query do
  begin
    DisableControls;
    // Titulo
    Writeln( F , '<HTML xmlns:o="urn:schemas-microsoft-com:office:office"' );
    Writeln( F , 'xmlns:x="urn:schemas-microsoft-com:office:excel"' );
    Writeln( F , '>' );
    Writeln( F , '<head>' );
    Writeln( F , '<style>' );
    Writeln( F , '<!--table' );
    if GetLocaleInformation(LOCALE_SDECIMAL) = '.' then
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\.";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\,";}' );
    end
    else
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\,";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\.";}' );
    end;
    Writeln( F , 'mso-displayed-thousand-separator:"\,";}' );
    // El tipo .text Fuerza el formato texto (ELIMINAL EL PROBLEMA QUE SE PIERDEN LOS CEROS A LA IZQUIERDA y qur 2-09 lo toma como fecha
    // F.I. 22-05-2013
    Writeln( F , '.text');
    Writeln( F , '{mso-number-format:"\@";/*force text*/}');
    // El tipo .x125 es para formatear variables de Fecha
    Writeln( F , '.xl25' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:"Short Date";}' );
    // El tipo .x124 es para formatear variables numericas
    Writeln( F , '.xl24' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:Standard;}' );
    // El tipo .x132 es para formatear variables String
    Writeln( F , '.xl32' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'text-align:left;' );

//    Writeln( F , '-->' );
//    Writeln( F , '</style>' );
//    Writeln( F , '<BODY topmargin=4 leftmargin=0 marginheight=0 marginwidth=0>' );
//    Writeln( F , '<h3>' );
//    Writeln( F , '<font color="#000080" size="1"> '+sRazon_Social);
//    Writeln( F , '</h3>' );
//    Writeln( F , '<h3>' );
//    Writeln( F , '<font color="#000080" size="1">'+sDireccion);
//    Writeln( F , '</h3>' );
//    Writeln( F , '<h3>' );
 //   Writeln( F , '<font color="#000080" size="1">'+sUbicacion);
 //   Writeln( F , '</h3>' );

//       // este es el titulo del Informe
//       sTitulo := QRPrinter.PreviewCaption;
//       if Pos( 'Quick', QRPrinter.PreviewCaption) > 0 then
//          sTitulo := '';

    Writeln( F , '<TABLE u1:str BORDER = 1 width = 100% aling = center bordercolor =#00008B >' );
//    Writeln( F , '<TH width="100%" colspan="'+IntToStr(Query.FieldCount)+'" bgcolor="#D3D3D3">'+sTitulo );
    Writeln( F , '</TH>' );

    Writeln( F , '<tr>' );
    // Escribo nombre de columnas
    for i := 0 to Query.FieldCount-1 do
    begin
       Writeln(F, '<TH width="100%" bgcolor="#D3D3D3">'+Query.Fields[i].DisplayLabel);
       Writeln(F, '</TH>');
    end;
    Writeln( F , '</tr>' );

    First;
    while not EOF do
    begin
       Writeln( F , '<tr>' );
       For i := 0 to FieldCount-1 do
       begin
          if Fields[i].DataType      in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            fValor := Fields[i].AsFloat;
            sValor := FloatToStrF(fValor, ffNumber,30,8);            //  no cambiar
             //sValor := FormatFloat( '###,###,###,##0.000000000000000', Fields[i].asFloat );
             //sValor := PadL( sValor, ' ', 20 );
             Writeln(F,'<TD class=xl24>'+ sValor )
          end
          else if Fields[i].DataType in [ftDateTime,ftDate] then
             if Fields[i].asFloat <> 0 then
                Writeln(F,'<TD class=xl25 x:num="'+Trim(FloatToStr(Fields[i].asFloat))+'">'+DateToStr( Fields[i].AsDatetime ))
             else
                //Writeln(F,'<TD class=xl32>'+'' )
                Writeln(F,'<TD class="text">'+'' )
          else
             //Writeln(F,'<TD class=xl32>'+Trim(Fields[i].AsString) );
          begin
             S1 := UpperCase(Query.Fields[i].DisplayLabel);
             S2 := 'FOLIO';
             S3 := STRPAS(StrPos(Pchar(s1),PChar(S2)));
             if trim(S3) <> '' then  /// OJO!!!
             begin
               try
                 fValor := Fields[i].asFloat;
                 sValor := FloatToStrF(fValor, ffNumber,30,0);
                 //sValor := FormatFloat( '###,###,###,###', Fields[i].asFloat );
                 //sValor := PadL( sValor, ' ', 20 );
                 Writeln(F,'<TD class=xl24>'+ sValor );
               except
                 Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
               end;
             end
             else
               Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
          end;

          Writeln( F , '</TD >' );
       end;
       Writeln( F , '</tr>' );
       Next;
       //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
       Application.ProcessMessages;
    end;
    Writeln( F , '</TABLE>' );
    Writeln( F , '</BODY>' );
    Writeln( F , '</HTML>' );

    First;
    //FrmRPreview.ProgressBar1.Visible := False;
    EnableControls;
    CloseFile(F);
  end;
end;

procedure TableToTxt_2(sFileName  : String;
                       sSeparador : String;
                       TableExcel      : TFDMemTable;
                       sin_ceros  : Boolean;
                       Titulo : string);
var
   i : Integer;
   sRazon_Social,
   sDireccion,
   sValor,
   S1,S2,S3,
   sUbicacion : String;
   fValor     : Double;
   Result     : Boolean;
begin
  AssignFile(F,sFileName);

  try
    ReWrite(F);
  except

  end;

  //FrmRPreview.ProgressBar1.Max := Table.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible := True;
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                           fItem_Dir_Usuario,
                           sRazon_Social,
                           sDireccion,
                           sUbicacion,
                           Result);
  with TableExcel do
  begin

    DisableControls;
    // Titulo
    Writeln( F , '<HTML xmlns:o="urn:schemas-microsoft-com:office:office"' );
    Writeln( F , 'xmlns:x="urn:schemas-microsoft-com:office:excel"' );
    Writeln( F , '>' );
    Writeln( F , '<head>' );
    Writeln( F , '<style>' );
    Writeln( F , '<!--table' );
    if GetLocaleInformation(LOCALE_SDECIMAL) = '.' then
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\.";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\,";}' );
    end
    else
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\,";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\.";}' );
    end;
    // El tipo .text Fuerza el formato texto (ELIMINAL EL PROBLEMA QUE SE PIERDEN LOS CEROS A LA IZQUIERDA y qur 2-09 lo toma como fecha
    // F.I. 22-05-2013
    Writeln( F , '.text');
    Writeln( F , '{mso-number-format:"\@";/*force text*/}');
    // El tipo .x125 es para formatear variables de Fecha
    Writeln( F , '.xl25' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:"Short Date";}' );
    // El tipo .x124 es para formatear variables numericas
    Writeln( F , '.xl24' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:Standard;}' );
//    if GetLocaleInformation(LOCALE_SDECIMAL) = '.' then
//       Writeln( F , 'mso-number-format:"\#\,\#\#0\.000";}' )
//    else
//       Writeln( F , 'mso-number-format:"\#\.\#\#0\,000";}' ) ;
    // El tipo .x132 es para formatear variables String
    Writeln( F , '.xl32' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'text-align:left;' );
    Writeln( F , '-->' );
    Writeln( F , '</style>' );
    Writeln( F , '<BODY topmargin=4 leftmargin=0 marginheight=0 marginwidth=0>' );
    Writeln( F , '<h3>' );
    Writeln( F , '<font color="#000080" size="1"> '+sRazon_Social);
    Writeln( F , '</h3>' );
    Writeln( F , '<h3>' );
    Writeln( F , '<font color="#000080" size="1">'+sDireccion);
    Writeln( F , '</h3>' );
    Writeln( F , '<h3>' );
    Writeln( F , '<font color="#000080" size="1">'+sUbicacion);
    Writeln( F , '</h3>' );

    // Tabla
    Writeln( F , '<TABLE u1:str BORDER = 1 width = 100% aling = center bordercolor =#00008B >' );
    Writeln( F , '<TH width="100%" colspan="'+IntToStr(TableExcel.FieldCount)+'" bgcolor="#D3D3D3">'+ Titulo );
    Writeln( F , '</TH>' );

    Writeln( F , '<tr>' );
    // Escribo nombre de columnas

    for i := 0 to TableExcel.FieldCount-1 do
    begin
       Writeln(F, '<TH width="100%" bgcolor="#D3D3D3">'+TableExcel.Fields[i].DisplayLabel);
       Writeln(F, '</TH>');
    end;

    Writeln( F , '</tr>' );

    First;
    while not EOF do
    begin
       Writeln( F , '<tr>' );
       For i := 0 to FieldCount-1 do
       begin
          if Fields[i].DataType      in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
             fValor := Fields[i].AsFloat;
             //sValor := FloatToStrF(fValor, ffCurrency,30,8);       //  no cambiar
             //sValor := FloatToStrF(fValor, ffExponent,30,8);       //  no cambiar
             sValor := FloatToStrF(fValor, ffNumber,30,8);       //  no cambiar
             //sValor := FloatToStr(fValor);       //  no cambiar
//             if GetLocaleInformation(LOCALE_SDECIMAL) = '.' then
//                sValor := FormatFloat( '###########0.00000000', fValor )
//             else
//               sValor := FormatFloat( '###########0,00000000', fValor ) ;

             //sValor := PadL( sValor, ' ', 20 );
             Writeln(F,'<TD class=xl24>'+ sValor )
             //Writeln(F,'<TD class=xl24 x:num>'+ sValor )
          end
          else if Fields[i].DataType in [ftDateTime,ftDate] then
             if Fields[i].asFloat <> 0 then
                Writeln(F,'<TD class=xl25 x:num="'+Trim(FloatToStr(Fields[i].asFloat))+'">'+DateToStr( Fields[i].AsDatetime ))
             else
                //Writeln(F,'<TD class=xl32>'+'' )
                Writeln(F,'<TD class="text">'+'' )
          else
          begin
             //S1 := UpperCase(Table.Fields[i].DisplayLabel);
             S2 := 'FOLIO';
             S3 := STRPAS(StrPos(Pchar(s1),PChar(S2)));
             if trim(S3) <> '' then  /// OJO!!!
             begin
               try
                 fValor := Fields[i].asFloat;
                 sValor := FloatToStrF(fValor, ffNumber,30,0);
                 //sValor := FormatFloat( '###,###,###,###', Fields[i].asFloat );
                 //sValor := PadL( sValor, ' ', 20 );
                 Writeln(F,'<TD class=xl24>'+ sValor );
               except
                 Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
               end;
             end
             else
               Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
          end;

          Writeln( F , '</TD >' );
       end;
       Writeln( F , '</tr>' );
       Next;
       //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
       Application.ProcessMessages;
    end;
    Writeln( F , '</TABLE>' );
    Writeln( F , '</BODY>' );
    Writeln( F , '</HTML>' );

    First;
    //FrmRPreview.ProgressBar1.Visible := False;
    EnableControls;
    CloseFile(F);
  end;
end;
procedure TableToTxt_3(sFileName  : String;
                       sSeparador : String;
                       TableExcel      : TFDTable;
                       sin_ceros  : Boolean;
                       Titulo : string);
var
   i : Integer;
   sRazon_Social,
   sDireccion,
   sValor,
   S1,S2,S3,
   sUbicacion : String;
   fValor     : Double;
   Result     : Boolean;
begin
  AssignFile(F,sFileName);

  try
    ReWrite(F);
  except

  end;

  //FrmRPreview.ProgressBar1.Max := Table.RecordCount;
  //FrmRPreview.ProgressBar1.Position := 0;
  //FrmRPreview.ProgressBar1.Visible := True;

  Leer_Identidad_Direccion(sEmpresa_Usuario,
                           fItem_Dir_Usuario,
                           sRazon_Social,
                           sDireccion,
                           sUbicacion,
                           Result);
  with TableExcel do
  begin
    DisableControls;
    // Titulo
    Writeln( F , '<HTML xmlns:o="urn:schemas-microsoft-com:office:office"' );
    Writeln( F , 'xmlns:x="urn:schemas-microsoft-com:office:excel"' );
    Writeln( F , '>' );
    Writeln( F , '<head>' );
    Writeln( F , '<style>' );
    Writeln( F , '<!--table' );
    if GetLocaleInformation(LOCALE_SDECIMAL) = '.' then
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\.";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\,";}' );
    end
    else
    begin
      Writeln( F , '{mso-displayed-decimal-separator:"\,";' );
      Writeln( F , 'mso-displayed-thousand-separator:"\.";}' );
    end;
    // El tipo .text Fuerza el formato texto (ELIMINAL EL PROBLEMA QUE SE PIERDEN LOS CEROS A LA IZQUIERDA y qur 2-09 lo toma como fecha
    // F.I. 22-05-2013
    Writeln( F , '.text');
    Writeln( F , '{mso-number-format:"\@";/*force text*/}');
    // El tipo .x125 es para formatear variables de Fecha
    Writeln( F , '.xl25' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:"Short Date";}' );
    // El tipo .x124 es para formatear variables numericas
    Writeln( F , '.xl24' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'mso-number-format:Standard;}' );
    // El tipo .x132 es para formatear variables String
    Writeln( F , '.xl32' );
    Writeln( F , '{mso-style-parent:style0;' );
    Writeln( F , 'text-align:left;' );
    Writeln( F , '-->' );
    Writeln( F , '</style>' );
    Writeln( F , '<BODY topmargin=4 leftmargin=0 marginheight=0 marginwidth=0>' );
    //Writeln( F , '<h3>' );
    Writeln( F , '<h3 font color="#000080" size="1"> '+sRazon_Social);
    Writeln( F , '</h3>' );
    //Writeln( F , '<h3>' );
    Writeln( F , '<h3 font color="#000080" size="1">'+sDireccion);
    Writeln( F , '</h3>' );
    //Writeln( F , '<h3>' );
    Writeln( F , '<h3 font color="#000080" size="1">'+sUbicacion);
    Writeln( F , '</h3>' );

    // Tabla
    Writeln( F , '<TABLE u1:str BORDER = 1 width = 100% aling = center bordercolor =#00008B >' );
    Writeln( F , '<TH width="100%" colspan="'+IntToStr(TableExcel.FieldCount)+'" bgcolor="#D3D3D3">'+ Titulo );
    //Writeln( F , '<TH width="100%" colspan="'+IntToStr(Table.FieldCount)+'" bgcolor="#D3D3D3">'+QRPrinter.PreviewCaption );
    Writeln( F , '</TH>' );

    Writeln( F , '<tr>' );
    // Escribo nombre de columnas

    for i := 0 to TableExcel.FieldCount-1 do
    begin
       Writeln(F, '<TH width="100%" bgcolor="#D3D3D3">'+TableExcel.Fields[i].DisplayLabel);
       Writeln(F, '</TH>');
    end;

    Writeln( F , '</tr>' );

    First;
    while not EOF do
    begin
       Writeln( F , '<tr>' );
       For i := 0 to FieldCount-1 do
       begin
          if Fields[i].DataType      in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
             fValor := Fields[i].asFloat;
             sValor := FloatToStrF(fValor, ffNumber,30,8);         //  no cambiar
             //sValor := FormatFloat( '###,###,###,##0.000000000000000', Fields[i].asFloat );
             //sValor := PadL( sValor, ' ', 20 );
             Writeln(F,'<TD class=xl24>'+ sValor )
          end
          else if Fields[i].DataType in [ftDateTime,ftDate] then
             if Fields[i].asFloat <> 0 then
                Writeln(F,'<TD class=xl25 x:num="'+Trim(FloatToStr(Fields[i].asFloat))+'">'+DateToStr( Fields[i].AsDatetime ))
             else
                //Writeln(F,'<TD class=xl32>'+'' )
                Writeln(F,'<TD class="text">'+'' )
          else
          begin
             //S1 := UpperCase(Table.Fields[i].DisplayLabel);
             S2 := 'FOLIO';
             S3 := STRPAS(StrPos(Pchar(s1),PChar(S2)));
             if trim(S3) <> '' then  /// OJO!!!
             begin
               try
                 fValor := Fields[i].asFloat;
                 sValor := FloatToStrF(fValor, ffNumber,30,0);
                 //sValor := FormatFloat( '###,###,###,###', Fields[i].asFloat );
                 //sValor := PadL( sValor, ' ', 20 );
                 Writeln(F,'<TD class=xl24>'+ sValor );
               except
                 Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
               end;
             end
             else
               Writeln(F,'<TD class="text">'+Trim(Fields[i].AsString) );
          end;

          Writeln( F , '</TD >' );
       end;
       Writeln( F , '</tr>' );
       Next;
       //FrmRPreview.ProgressBar1.Position := FrmRPreview.ProgressBar1.Position + 1;
       Application.ProcessMessages;
    end;
    Writeln( F , '</TABLE>' );
    Writeln( F , '</BODY>' );
    Writeln( F , '</HTML>' );

    First;
    //FrmRPreview.ProgressBar1.Visible := False;
    EnableControls;
    CloseFile(F);
  end;
end;

procedure Genera_Excel_Qry(Qry_Genera : TFDQuery;
                            sTituloExcel : String);

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bConsulta      : Boolean;
   bSalir         : Boolean;
   Result         : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
   SaveDialog3: TSaveDialog;
   Qry_General1 : TFDQuery;
begin
   Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Qry_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;

   Qry_Genera.FetchOptions.RecordCountMode := cmTotal;
   if (bExiste_Dll) and (Qry_Genera.RecordCount < 65000) then
   begin
     bImprimeInvisible := true;
     Genera_excel_dll(Qry_Genera,sTituloExcel,False);
     Exit;
   end;

   with FrmRPreview do
   begin
     Qry_Genera.Open;
     DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
     Delay(1000);
     //  sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
     //DC 05/06/2013
     if (length(directorio_temp) + fLargo_minimo) > fLargo_maximo then
     begin
       application.messagebox('Path del Temp excede maximo de caracteres permitidos'
                             ,'Excel'
                             ,MB_Ok);
       exit;
     end;

     sArchivo_Excel := ValidaCaracteresArchivo(sTituloExcel);

     sArchivo_Excel := trim(copy(sArchivo_Excel,1,(fLargo_Maximo - (length(directorio_temp) + fLargo_minimo))));

     sArchivo_Excel := directorio_temp
                       +sArchivo_Excel
                       +'--'
                       +IntToStr(Hour)
                       +IntToStr(Min)
                       +IntToStr(Sec)
                       +IntToStr(MSec)
                       +'.Html';

     iNro_registros := Qry_Genera.RecordCount;

     sDatosIni := TIniFile.Create(sArchivo_Ini);
     bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
     bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
     iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
     sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

     if (iNro_registros > iMaxRows) AND bConsulta then
        bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

     if Not bSalir then
     begin
       if NOT bConsulta then
          sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

       sDatosIni.WriteBool('Excel','Consulta',bConsulta);
       sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
       sDatosIni.WriteString('Excel','Separador',sSeparador);
       sDatosIni.Free;
       //QRPrinter.PreviewCaption := '';
       //QRPrinter.PreviewCaption := sTituloExcel;


       if bGeneraExcel then
       begin
         bImprimeInvisible := true;
         QueryToTxt_2(sArchivo_Excel, sSeparador, Qry_Genera, true,sTituloExcel );

         ShellExecute(Application.Handle,
                      'open',
                      PChar('excel.exe'),
                      pchar(sArchivo_Excel),
                      nil,
                      SW_SHOW
                      );
       end
       else
       begin
         SaveDialog3 := TSaveDialog.Create(Application);
         if SaveDialog3.Execute then
           QueryToTxt(SaveDialog3.FileName, sSeparador, Qry_Genera )
       end;
       SaveDialog3.Free;
     end;
  end;
end;

procedure Genera_Excel_Qry_Sin_Ceros(Qry_Genera : TFDQuery;
                                     sTituloExcel : String);

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bConsulta      : Boolean;
   bSalir         : Boolean;
   Result         : Boolean;
   iMaxRows,ii    : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
begin
with FrmRPreview do
begin
  Qry_Genera.Open;
  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
  Qry_Genera.Last;
  ii := Qry_Genera.recordcount;
  Qry_Genera.First;
  iNro_registros := ii;
  bSalir := False;
  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
     bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;
    //QRPrinter.PreviewCaption := '';
    //QRPrinter.PreviewCaption := sTituloExcel;

    if bGeneraExcel then
    begin
      bImprimeInvisible := true;
      Qry_Genera.FetchOptions.RecordCountMode := cmTotal;
      if (bExiste_Dll) and (Qry_Genera.RecordCount < 65000) then
      begin
        genera_excel_dll(Qry_Genera,sTituloExcel,True);
      end
      else
      begin
        QueryToTxt_2(sArchivo_Excel, sSeparador, Qry_Genera, false,' ' );

        ShellExecute(Application.Handle,
                     'open',
                     PChar('excel.exe'),
                     pchar(sArchivo_Excel),
                     nil,
                     SW_SHOW
                     );
      end;
    end
  end;
 end;
end;

procedure Genera_Excel_Qry_Visibles(Qry_Genera : TFDQuery;
                                    sTituloExcel : String);

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bConsulta      : Boolean;
   bSalir         : Boolean;
   Result         : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
begin
with FrmRPreview do
begin
  Qry_Genera.FetchOptions.RecordCountMode := cmTotal;
  if (bExiste_Dll) and (Qry_Genera.RecordCount < 65000) then
  begin
    bImprimeInvisible := False;
    Genera_excel_dll(Qry_Genera,sTituloExcel,False);
    Exit;
  end;
  bSalir := False;
  Qry_Genera.Open;
  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  Delay(1000);  // D.C&F.I. 08-03-2016

  sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
  iNro_registros := Qry_Genera.RecordCount;

  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
     bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;
//    QRPrinter.PreviewCaption := '';
//    QRPrinter.PreviewCaption := sTituloExcel;

    if bGeneraExcel then
    begin
      bImprimeInvisible := false;
      QueryToTxt_2(sArchivo_Excel, sSeparador, Qry_Genera, false,sTituloExcel );

      ShellExecute(Application.Handle,
                   'open',
                   PChar('excel.exe'),
                   pchar(sArchivo_Excel),
                   nil,
                   SW_SHOW
                   );
    end
    else
      if SaveDialog2.Execute then
         QueryToTxt(SaveDialog2.FileName, sSeparador, Qry_Genera );

      // Qry_Genera.Close;
  end;
 end;
end;


procedure Genera_Excel_Qry_Sin_Cabezera(Qry_Genera : TFDQuery;
                                        sTituloExcel : String);

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bConsulta      : Boolean;
   bSalir         : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
begin
with FrmRPreview do
begin
  Qry_Genera.FetchOptions.RecordCountMode := cmTotal;
  if (bExiste_Dll) and (Qry_Genera.RecordCount < 65000) then
  begin
    bSincabezara := True;
    bImprimeInvisible := true;
    Genera_excel_dll(Qry_Genera,sTituloExcel,False);
    bSincabezara := False;
    Exit;
  end;


  Qry_Genera.Open;
  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
  iNro_registros := Qry_Genera.RecordCount;

  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
     bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;
    //QRPrinter.PreviewCaption := '';
    //QRPrinter.PreviewCaption := sTituloExcel;


    if bGeneraExcel then
    begin
      bImprimeInvisible := true;
      QueryToTxt_3(sArchivo_Excel, sSeparador, Qry_Genera );

      ShellExecute(Application.Handle,
                   'open',
                   PChar('excel.exe'),
                   pchar(sArchivo_Excel),
                   nil,
                   SW_SHOW
                   );
    end
   end;
 end;
end;


procedure Genera_Excel_Table(Table_Genera : TFDTable;
                             sTituloExcel : String);

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bSalir         : Boolean;
   bConsulta      : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
   SaveDialog3: TSaveDialog;
   Qry_General1 : TFDQuery;
begin
  Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Table_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;
with FrmRPreview do
begin
  Table_Genera.FetchOptions.RecordCountMode := cmTotal;
  if (bExiste_Dll) and (Table_Genera.RecordCount < 65000) then
  begin
     bImprimeInvisible := true;
     Genera_excel_dll(Table_Genera,sTituloExcel,False);
     Exit;
  end;


  Table_Genera.Open;
  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
  iNro_registros := Table_Genera.RecordCount;

  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
      bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;
    //QRPrinter.PreviewCaption := '';
    //QRPrinter.PreviewCaption := sTituloExcel;


    if bGeneraExcel then
    begin
      bImprimeInvisible := true;
      TableToTxt_3(sArchivo_Excel, sSeparador, Table_Genera, True,sTituloExcel );

      ShellExecute(Application.Handle,
                   'open',
                   PChar('excel.exe'),
                   pchar(sArchivo_Excel),
                   nil,
                   SW_SHOW
                   );
    end
    else
    begin
        SaveDialog3 := TSaveDialog.Create(Application);
        if SaveDialog3.Execute then
          TableToTxt(SaveDialog2.FileName ,sSeparador, Table_Genera )
    end;
    SaveDialog3.Free;
  end;
 end;
end;

procedure Genera_Excel_Table(Table_Genera : TFDMemTable;
                             sTituloExcel : String);

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bSalir         : Boolean;
   bConsulta      : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
   SaveDialog3: TSaveDialog;
   Qry_General1 : TFDQuery;
begin
  Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Table_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;

  Table_Genera.FetchOptions.RecordCountMode := cmTotal;
  if (bExiste_Dll) and (Table_Genera.RecordCount < 65000) then
  begin
    bImprimeInvisible := true;
    Genera_excel_dll(Table_Genera,sTituloExcel,False);
    Exit;
  end;


with FrmRPreview do
begin
  bSalir := False;
  Table_Genera.Open;
  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
  iNro_registros := Table_Genera.RecordCount;

  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
      bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;
    //QRPrinter.PreviewCaption := '';
    //QRPrinter.PreviewCaption := sTituloExcel;


    if bGeneraExcel then
    begin
      bImprimeInvisible := true;
      TableToTxt_2(sArchivo_Excel, sSeparador, Table_Genera, True,sTituloExcel );

      ShellExecute(Application.Handle,
                   'open',
                   PChar('excel.exe'),
                   pchar(sArchivo_Excel),
                   nil,
                   SW_SHOW
                   );
    end
    else
    begin
       SaveDialog3 := TSaveDialog.Create(Application);
       if SaveDialog3.Execute then
         TableToTxt_4(SaveDialog2.FileName ,sSeparador, Table_Genera );
       SaveDialog3.Free;
    end;

  end;
 end;
end;

procedure Genera_Excel_Table_Sin_Ceros(Table_Genera : TFDMemTable;
                                      sTituloExcel : String);

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bConsulta      : Boolean;
   bSalir         : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
begin
with FrmRPreview do
begin
  Table_Genera.Open;
  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  sArchivo_Excel := directorio_temp + 'Libro'+IntToStr(Application.Handle)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
  iNro_registros := Table_Genera.RecordCount;

  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
     bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;
    //QRPrinter.PreviewCaption := '';
    //QRPrinter.PreviewCaption := sTituloExcel;


    if bGeneraExcel then
    begin
      Table_Genera.FetchOptions.RecordCountMode := cmTotal;
      if (bExiste_Dll) and (Table_Genera.RecordCount < 65000) then
      begin
        genera_excel_dll(Table_Genera,sTituloExcel,True);
      end
      else
      begin
        TableToTxt_2(sArchivo_Excel, sSeparador, Table_Genera, False,sTituloExcel );

        ShellExecute(Application.Handle,
                     'open',
                     PChar('excel.exe'),
                     pchar(sArchivo_Excel),
                     nil,
                     SW_SHOW
                     );
      end;
    end
  end;
 end;
end;

procedure Genera_Excel_Qry_Con_Nombre( Qry_Genera : TFDQuery;
                                       sTituloExcel : String;
                                       sTituloArchivo : String
                                       );

var
   iNro_registros : Integer;
   sDatosIni      : TiniFile;
   bGeneraExcel   : Boolean;
   bConsulta      : Boolean;
   bSalir         : Boolean;
   Result         : Boolean;
   iMaxRows       : Integer;
   sSeparador,
   sArchivo_Excel : String;
   Hour, Min, Sec, MSec : Word;
   Qry_General1   : TFDQuery;
begin
  Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Qry_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
  end;

with FrmRPreview do
begin
  Qry_Genera.FetchOptions.RecordCountMode := cmTotal;
  if (bExiste_Dll) and (Qry_Genera.RecordCount < 65000) then
  begin
     bImprimeInvisible := true;
     Genera_excel_dll(Qry_Genera,sTituloExcel,False);
     Exit;
  end;

  bSalir := false;
  Qry_Genera.Open;
  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  sArchivo_Excel := directorio_temp + trim(sTituloArchivo)+IntToStr(Hour)+IntToStr(Min)+IntToStr(Sec)+'.Html';
  sArchivo_Excel := StrTran(sArchivo_Excel, ' ', '_');
  iNro_registros := Qry_Genera.RecordCount;

  sDatosIni := TIniFile.Create(sArchivo_Ini);
  bConsulta    := sDatosIni.ReadBool('Excel','Consulta',True);
  bGeneraExcel := sDatosIni.ReadBool('Excel','GeneraExcel',True);
  iMaxRows     := sDatosIni.ReadInteger('Excel','MaxRows',200);
  sSeparador   := sDatosIni.ReadString('Excel','Separador',';');

  if (iNro_registros > iMaxRows) AND bConsulta then
     bGeneraExcel := Consulta_Genera_Excel(iMaxRows,bConsulta,bSalir);

  if Not bSalir then
  begin
    if NOT bConsulta then
       sDatosIni.WriteBool('Excel','GeneraExcel',bGeneraExcel);

    sDatosIni.WriteBool('Excel','Consulta',bConsulta);
    sDatosIni.WriteInteger('Excel','MaxRows',iMaxRows);
    sDatosIni.WriteString('Excel','Separador',sSeparador);
    sDatosIni.Free;
    //QRPrinter.PreviewCaption := '';
    //QRPrinter.PreviewCaption := sTituloExcel;

    if bGeneraExcel then
    begin
      bImprimeInvisible := true;
      QueryToTxt_2(sArchivo_Excel, sSeparador, Qry_Genera, true,sTituloExcel );

      ShellExecute(Application.Handle,
                   'open',
                   PChar('excel.exe'),
                   pchar(sArchivo_Excel),
                   nil,
                   SW_SHOW
                   );
    end
  end;
 end;
end;

  procedure TFrmRPreview.ExportToExcel(sFileName  : String; Table_Genera : TFDTable;
                          sTituloExcel : String);
var
  PlanillaPms : Variant;
  Linea,cont,i  : Integer;
  xValor : Variant;
  tipoDato : TFieldType;
   sValor : string;
   fValor     : Double;
   sRazon_Social,
   sDireccion,
   sUbicacion : String;
   result : Boolean;
begin
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                           fItem_Dir_Usuario,
                           sRazon_Social,
                           sDireccion,
                           sUbicacion,
                           Result);
  Linea := 7;
  Table_Genera.Open;
  Table_Genera.Last;
  ProgressBar1.Max :=  Table_Genera.RecordCount;
  ProgressBar1.Min :=  0;
  ProgressBar1.Position := 1;
  PlanillaPms := createoleobject('Excel.Application');
  PlanillaPms.caption := sTituloExcel;
  PlanillaPms.visible := false;
  PlanillaPms.workbooks.add(1);
  PlanillaPms.Workbooks[1].WorkSheets[1].Name := sTituloExcel;
  PlanillaPms.cells[1,1]:= sRazon_Social;
  PlanillaPms.cells[1,1].Font.Bold := True;
  PlanillaPms.cells[1,1].Font.Color := clBlue;
  PlanillaPms.cells[2,1]:= sDireccion;
  PlanillaPms.cells[2,1].Font.Bold := True;
  PlanillaPms.cells[2,1].Font.Color := clBlue;
  PlanillaPms.cells[3,1]:= sUbicacion;
  PlanillaPms.cells[3,1].Font.Bold := True;
  PlanillaPms.cells[3,1].Font.Color := clBlue;

  PlanillaPms.cells[5,1]:= sTituloExcel;
  PlanillaPms.cells[5,1].Font.Bold := True;
  PlanillaPms.cells[5,1].Font.Color := clBlue;
   for i := 0 to Table_Genera.FieldCount-1 do
    begin
        PlanillaPms.cells[6,i+1].Font.Bold := True;
        PlanillaPms.cells[6,i+1].Font.Color := clBlue;
        PlanillaPms.cells[6,i+1]:= Table_Genera.Fields[i].DisplayLabel;
    end;
   Table_Genera.DisableControls;

   Table_Genera.First;
     try
       while not Table_Genera.Eof do
       begin
         for i := 0 to Table_Genera.FieldCount-1 do
          begin
            tipoDato := Table_Genera.Fields[i].DataType;
            if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
              begin
                 if Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).isnull then
                    fvalor := 0
                 else
                  fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsVariant;

                 sValor := FloatToStrF(fValor, ffNumber,30,8);          //  no cambiar
                 PlanillaPms.cells[Linea,i+1]:= sValor;
              end
            else
              if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
               if Table_Genera.Fields[i].asFloat <> 0 then
               begin
                  xValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsDateTime;
                  PlanillaPms.cells[Linea,i+1]:= xValor;
               end
               else
               begin
                 xValor := '';
                 PlanillaPms.cells[Linea,i+1]:= xValor;
               end
              else
              begin
               PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
               sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsString;
               PlanillaPms.cells[Linea,i+1]:= sValor;
              end;

          end;
          inc(Linea);
          ProgressBar1.Position := ProgressBar1.Position + 1;
          ProgressBar1.Refresh;
          Table_Genera.Next

       end;
       PlanillaPms.columns.autofit;
       PlanillaPms.visible := True;
       finally
        Table_Genera.EnableControls;
        PlanillaPms := Unassigned;

     end;
end;

  procedure TFrmRPreview.ExportToExcel(sFileName  : String; Table_Genera : TFDMemTable;
                               sTituloExcel : String);
var
  PlanillaPms : Variant;
  Linea,cont,i  : Integer;
  xValor : Variant;
  tipoDato : TFieldType;
   sValor : string;
   fValor     : Double;
   sRazon_Social,
   sDireccion,
   sUbicacion : String;
   result : Boolean;
   dfecha_minima : TDateTime;
begin
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                           fItem_Dir_Usuario,
                           sRazon_Social,
                           sDireccion,
                           sUbicacion,
                           Result);
  dfecha_minima :=  EncodeDate(1900,01,01);
  Linea := 7;
  Table_Genera.Open;
  Table_Genera.Last;
  ProgressBar1.Max :=  Table_Genera.RecordCount;
  ProgressBar1.Min :=  0;
  ProgressBar1.Position := 1;
  PlanillaPms := createoleobject('Excel.Application');
  PlanillaPms.caption := sTituloExcel;
  PlanillaPms.visible := false;
  PlanillaPms.workbooks.add(1);
  PlanillaPms.Workbooks[1].WorkSheets[1].Name := sTituloExcel;
  PlanillaPms.cells[1,1]:= sRazon_Social;
  PlanillaPms.cells[1,1].Font.Bold := True;
  PlanillaPms.cells[1,1].Font.Color := clBlue;
  PlanillaPms.cells[2,1]:= sDireccion;
  PlanillaPms.cells[2,1].Font.Bold := True;
  PlanillaPms.cells[2,1].Font.Color := clBlue;
  PlanillaPms.cells[3,1]:= sUbicacion;
  PlanillaPms.cells[3,1].Font.Bold := True;
  PlanillaPms.cells[3,1].Font.Color := clBlue;

  PlanillaPms.cells[5,1]:= sTituloExcel;
  PlanillaPms.cells[5,1].Font.Bold := True;
  PlanillaPms.cells[5,1].Font.Color := clBlue;
   for i := 0 to Table_Genera.FieldCount-1 do
    begin
        PlanillaPms.cells[6,i+1].Font.Bold := True;
        PlanillaPms.cells[6,i+1].Font.Color := clBlue;
        PlanillaPms.cells[6,i+1]:= Table_Genera.Fields[i].DisplayLabel;
    end;
   Table_Genera.DisableControls;

   Table_Genera.First;
     try
       while not Table_Genera.Eof do
       begin
         for i := 0 to Table_Genera.FieldCount-1 do
          begin
            tipoDato := Table_Genera.Fields[i].DataType;
            if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
              begin
                 if Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).isnull then
                    fvalor := 0
                 else
                  fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsVariant;

                 sValor := FloatToStrF(fValor, ffNumber,30,8);          //  no cambiar
                 PlanillaPms.cells[Linea,i+1]:= sValor;
              end
            else
              if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
                 if Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsDateTime < dfecha_minima then
                 begin
                   PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
                   sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsString;
                   PlanillaPms.cells[Linea,i+1]:= sValor;
                 end
                 else
                 begin
                   if Table_Genera.Fields[i].asFloat <> 0 then
                   begin
                      xValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsDateTime;
                      PlanillaPms.cells[Linea,i+1]:= xValor;
                   end
                   else
                   begin
                     xValor := '';
                     PlanillaPms.cells[Linea,i+1]:= xValor;
                   end
                 end
              else
              begin
                 PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
                 sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsString;
                 PlanillaPms.cells[Linea,i+1]:= sValor;
              end;

          end;
          inc(Linea);
          ProgressBar1.Position := ProgressBar1.Position + 1;
          ProgressBar1.Refresh;
          Table_Genera.Next

       end;
       PlanillaPms.columns.autofit;
       PlanillaPms.visible := True;
       finally
        Table_Genera.EnableControls;
        PlanillaPms := Unassigned;

     end;
end;

  procedure TFrmRPreview.ExportToExcel(sFileName  : String; Table_Genera : TFDQuery;
                               sTituloExcel : String);
var
  PlanillaPms : Variant;
  Linea,cont,i  : Integer;
  xValor : Variant;
  tipoDato : TFieldType;
   sValor : string;
   fValor     : Double;
   sRazon_Social,
   sDireccion,
   sUbicacion : String;
   result : Boolean;
begin
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                           fItem_Dir_Usuario,
                           sRazon_Social,
                           sDireccion,
                           sUbicacion,
                           Result);
  Linea := 7;
  Table_Genera.Open;
  Table_Genera.Last;
  ProgressBar1.Max :=  Table_Genera.RecordCount;
  ProgressBar1.Min :=  0;
  ProgressBar1.Position := 1;
  PlanillaPms := createoleobject('Excel.Application');
  PlanillaPms.caption := sTituloExcel;
  PlanillaPms.visible := false;
  PlanillaPms.workbooks.add(1);
  PlanillaPms.Workbooks[1].WorkSheets[1].Name := sTituloExcel;
  PlanillaPms.cells[1,1]:= sRazon_Social;
  PlanillaPms.cells[1,1].Font.Bold := True;
  PlanillaPms.cells[1,1].Font.Color := clBlue;
  PlanillaPms.cells[2,1]:= sDireccion;
  PlanillaPms.cells[2,1].Font.Bold := True;
  PlanillaPms.cells[2,1].Font.Color := clBlue;
  PlanillaPms.cells[3,1]:= sUbicacion;
  PlanillaPms.cells[3,1].Font.Bold := True;
  PlanillaPms.cells[3,1].Font.Color := clBlue;

  PlanillaPms.cells[5,1]:= sTituloExcel;
  PlanillaPms.cells[5,1].Font.Bold := True;
  PlanillaPms.cells[5,1].Font.Color := clBlue;
   for i := 0 to Table_Genera.FieldCount-1 do
    begin
        PlanillaPms.cells[6,i+1].Font.Bold := True;
        PlanillaPms.cells[6,i+1].Font.Color := clBlue;
        PlanillaPms.cells[6,i+1]:= Table_Genera.Fields[i].DisplayLabel;
    end;
   Table_Genera.DisableControls;

   Table_Genera.First;
     try
       while not Table_Genera.Eof do
       begin
         for i := 0 to Table_Genera.FieldCount-1 do
          begin
            tipoDato := Table_Genera.Fields[i].DataType;
            if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
              begin
                 if Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).isnull then
                    fvalor := 0
                 else
                  fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsVariant;

                 sValor := FloatToStrF(fValor, ffNumber,30,8);          //  no cambiar
                 PlanillaPms.cells[Linea,i+1]:= sValor;
              end
            else
              if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
               if Table_Genera.Fields[i].asFloat <> 0 then
               begin
                  xValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsDateTime;
                  PlanillaPms.cells[Linea,i+1]:= xValor;
               end
               else
               begin
                 xValor := '';
                 PlanillaPms.cells[Linea,i+1]:= xValor;
               end
              else
              begin
               PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
               sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].DisplayLabel).AsString;
               PlanillaPms.cells[Linea,i+1]:= sValor;
              end;

          end;
          inc(Linea);
          ProgressBar1.Position := ProgressBar1.Position + 1;
          ProgressBar1.Refresh;
          Table_Genera.Next

       end;
       PlanillaPms.columns.autofit;
       PlanillaPms.visible := True;
       finally
        Table_Genera.EnableControls;
        PlanillaPms := Unassigned;

     end;

end;

procedure Genera_excel_dll(qry_genera   :  TFDQuery;
                           sTituloExcel : String;
                           sin_cero : Boolean);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : String;//PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : String;//PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   sArchivo_Excel   : String;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   SaveDialog4      : TSaveDialog;
begin
//  qry_genera.Last;
//  if (qry_genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//    Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                           ,'Genera Excel'
//                           , mb_OK);
//    exit;
//  end;
//  qry_genera.First;

  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
   if sDesplegar = 'NO' then
   begin
     SaveDialog4 := TSaveDialog.Create(Application);
     SaveDialog4.Options := [ofOverwritePrompt];
     if sExtencion = 'XLS' then
     begin
      SaveDialog4.filter := 'Archivos de EXCEL|*.XLS|Archivos de EXCEL|*.XLSX';
      SaveDialog4.DefaultExt := '*.XLS';
     end
     else
     begin
      SaveDialog4.filter := 'Archivos de EXCEL|*.XLSX|Archivos de EXCEL|*.XLS';
      SaveDialog4.DefaultExt := '*.XLSX';
     end;
     sTituloExcel := ValidaCaracteresArchivo(sTituloExcel);
     SaveDialog4.FileName := copy(sTituloExcel,1,60);
     if SaveDialog4.Execute then
     begin
      sArchivo_Excel := SaveDialog4.FileName;
      nombre_excel := ValidaCaracteresArchivo(sArchivo_Excel);
     end
     else
       exit;
     SaveDialog4.Free;
   end
   else
   begin

     nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
     nombre_excel := ValidaCaracteresCirculares(nombre_excel);

     sArchivo_Excel := sDirExcel
                    +copy(nombre_excel,1,20)
                    +IntToStr(Hour)
                    +IntToStr(Min)
                    +IntToStr(Sec)
                    +IntToStr(MSec)
                    +'.'+sExtencion;
   end;




  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
     for i := 0 to qry_genera.FieldCount-1 do
        if qry_genera.Fields[i].visible = true then
           largo_centrado := largo_centrado +1;
  end
  else
      largo_centrado := qry_genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  qry_genera.Open;
  qry_genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  if not bSincabezara then
  begin
    Sheet.setCol(0,10);
    //sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
    //sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
    //sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
    //Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));
    sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;


    Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
    Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
    Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

    Sheet.writeStr(6,0,Titulo , fFormat_columna);
    Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

    filas := 7;
  end
  else
    filas := 0;

  columnas := 0;
  for i := 0 to qry_genera.FieldCount-1 do
  begin
    if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,qry_genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  if not bSincabezara then
    Filas := 8
  else
    Filas := 1;

  columnas := 0;

  qry_genera.First;
  try
    while not qry_genera.Eof do
    begin
      for i := 0 to qry_genera.FieldCount-1 do
      begin
        if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := qry_genera.Fields[i].DataType;
          if qry_genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
              fvalor := 0
            else
              fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
            if (sin_cero) and (fvalor = 0) then
               Sheet.writeStr(Filas, Columnas, '',fFormat_detalle)
            else
               Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if qry_genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
            begin
              if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if (qry_genera.FieldByName(qry_genera.Fields[i].FieldName).IsNull) or (qry_genera.FieldByName(qry_genera.Fields[i].FieldName).asdatetime = 0) then
                  //sValor := '0'
                  sValor := ' '
                else
                  sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if qry_genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            end
            else
            begin
              // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
              S1 := UpperCase(qry_genera.Fields[i].DisplayLabel);
              S2 := 'PORTFOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                 S3 := '';
              end
              else
              begin
                S2 := 'FOLIO';
                S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              end;
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                    sValor := ' ';
                if  sValor='' then
                    sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      qry_genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
      if sDesplegar <> 'NO' then
      begin
        PWFILE := PWideChar(sArchivo_Excel) ;
        ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      end;
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll(Table_Genera : TFDTable;
                           sTituloExcel : String;
                           sin_cero : Boolean);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string; //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   sArchivo_Excel   : String;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   SaveDialog4      : TSaveDialog;
begin
//  Table_Genera.Last;
//  if (Table_Genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//      Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                             ,'Genera Excel'
//                             , mb_OK);
//      exit;
//  end;
//  Table_Genera.First;

  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
    if sDesplegar = 'NO' then
   begin
     SaveDialog4 := TSaveDialog.Create(Application);
     SaveDialog4.Options := [ofOverwritePrompt];
     if sExtencion = 'XLS' then
     begin
      SaveDialog4.filter := 'Archivos de EXCEL|*.XLS|Archivos de EXCEL|*.XLSX';
      SaveDialog4.DefaultExt := '*.XLS';
     end
     else
     begin
      SaveDialog4.filter := 'Archivos de EXCEL|*.XLSX|Archivos de EXCEL|*.XLS';
      SaveDialog4.DefaultExt := '*.XLSX';
     end;
     sTituloExcel := ValidaCaracteresArchivo(sTituloExcel);
     SaveDialog4.FileName := copy(sTituloExcel,1,60);
     if SaveDialog4.Execute then
     begin
      sArchivo_Excel := SaveDialog4.FileName;
      nombre_excel := ValidaCaracteresArchivo(sArchivo_Excel);
     end
     else
       exit;
     SaveDialog4.Free;
   end
   else
   begin

     nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
     nombre_excel := ValidaCaracteresCirculares(nombre_excel);

     sArchivo_Excel := sDirExcel
                    +copy(nombre_excel,1,20)
                    +IntToStr(Hour)
                    +IntToStr(Min)
                    +IntToStr(Sec)
                    +IntToStr(MSec)
                    +'.'+sExtencion;
   end;


  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
     for i := 0 to Table_Genera.FieldCount-1 do
        if Table_Genera.Fields[i].visible = true then
           largo_centrado := largo_centrado +1;
  end
  else
      largo_centrado := Table_Genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  Table_Genera.Open;
  Table_Genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL;  //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

    sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to Table_Genera.FieldCount-1 do
  begin
    if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,Table_Genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  if not bSincabezara then
    Filas := 8
  else
    Filas := 1;
  columnas := 0;

  Table_Genera.First;
  try
    while not Table_Genera.Eof do
    begin
      for i := 0 to Table_Genera.FieldCount-1 do
      begin
        if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := Table_Genera.Fields[i].DataType;
          if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
               if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
                  fvalor := 0
               else
                fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
               Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);

          end
          else
          begin
            if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
            begin
              if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).IsNull then
                  sValor := '0'
                else
                  sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if Table_Genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            end
            else
            begin
              // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
              S1 := UpperCase(Table_Genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                    sValor := ' ';
                if  sValor='' then
                    sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      Table_Genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
       if sDesplegar <> 'NO' then
      begin
        PWFILE := PWideChar(sArchivo_Excel) ;
        ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      end;
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll(Table_Genera : TFDMemTable;
                           sTituloExcel : String;
                           sin_cero : Boolean);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string; //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   sArchivo_Excel   : String;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   SaveDialog4      : TSaveDialog;
begin
//  Table_Genera.Last;
//  if (Table_Genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//     Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                            ,'Genera Excel'
//                            , mb_OK);
//     exit;
//  end;
//  Table_Genera.First;
  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);


  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
    if sDesplegar = 'NO' then
   begin
     SaveDialog4 := TSaveDialog.Create(Application);
     SaveDialog4.Options := [ofOverwritePrompt];
     if sExtencion = 'XLS' then
     begin
      SaveDialog4.filter := 'Archivos de EXCEL|*.XLS|Archivos de EXCEL|*.XLSX';
      SaveDialog4.DefaultExt := '*.XLS';
     end
     else
     begin
      SaveDialog4.filter := 'Archivos de EXCEL|*.XLSX|Archivos de EXCEL|*.XLS';
      SaveDialog4.DefaultExt := '*.XLSX';
     end;
     sTituloExcel := ValidaCaracteresArchivo(sTituloExcel);
     SaveDialog4.FileName := copy(sTituloExcel,1,60);
     if SaveDialog4.Execute then
     begin
      sArchivo_Excel := SaveDialog4.FileName;
      nombre_excel := ValidaCaracteresArchivo(sArchivo_Excel);
     end
     else
       exit;
     SaveDialog4.Free;
   end
   else
   begin

     nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
     nombre_excel := ValidaCaracteresCirculares(nombre_excel);

     if not bNombreLibre  then
       sArchivo_Excel := sDirExcel
                      +copy(nombre_excel,1,20)
                      +IntToStr(Hour)
                      +IntToStr(Min)
                      +IntToStr(Sec)
                      +IntToStr(MSec)
                      +'.'+sExtencion
     else
       sArchivo_Excel := sDirExcel
                        +nombre_excel
                        +'.'+sExtencion;
   end;


  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to Table_Genera.FieldCount-1 do
      if Table_Genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := Table_Genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  Table_Genera.Open;
  Table_Genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  if not bSincabezara then
  begin
    Sheet.setCol(0,10);
    //sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
    //sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
    //sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
    //Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));
    sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;


    Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
    Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
    Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

    Sheet.writeStr(6,0,Titulo , fFormat_columna);
    Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

    filas := 7;
  end
  else
    filas := 0;

  columnas := 0;
  for i := 0 to Table_Genera.FieldCount-1 do
  begin
    if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,Table_Genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  if not bSincabezara then
    Filas := 8
  else
    Filas := 1;
  columnas := 0;

  Table_Genera.First;
  try
    while not Table_Genera.Eof do
    begin
      for i := 0 to Table_Genera.FieldCount-1 do
      begin
        if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
          //columnas := i ;
          tipoDato := Table_Genera.Fields[i].DataType;
          if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
              fvalor := 0
            else
              fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
            Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
            begin
              if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).IsNull then
                  sValor := '0'
                else
                  sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if Table_Genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                   xValor := '';
                   Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            end
            else
            begin
              // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
              S1 := UpperCase(Table_Genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                    sValor := ' ';
                if  sValor='' then
                    sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      Table_Genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
      if sDesplegar <> 'NO' then
      begin
        PWFILE := PWideChar(sArchivo_Excel) ;
        ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      end;
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(qry_genera     :  TFDQuery;
                                       sTituloExcel   : String;
                                       sin_cero       : Boolean;
                                       sArchivo_Excel : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_general1     : TFDQuery;
begin
   Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Qry_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados (Excel): '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;
//  qry_genera.Last;
//  if (qry_genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//      Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                             ,'Genera Excel'
//                             , mb_OK);
//      exit;
//  end;
//  qry_genera.First;
  bImprimeInvisible := True;
  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to qry_genera.FieldCount-1 do
      if qry_genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := qry_genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
    Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  qry_genera.Open;
  qry_genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;


  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to qry_genera.FieldCount-1 do
  begin
    if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,qry_genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  qry_genera.First;
  try
    while not qry_genera.Eof do
    begin

      for i := 0 to qry_genera.FieldCount-1 do
      begin
        if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := qry_genera.Fields[i].DataType;
          if qry_genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
             if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                fvalor := 0
             else
                fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
             Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if qry_genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
              if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).IsNull then
                   sValor := '0'
                else
                   sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if qry_genera.Fields[i].asFloat <> 0 then
                begin
                   FechaValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime;
                   Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            else
            begin
              // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
              S1 := UpperCase(qry_genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                   sValor := ' ';
                if sValor='' then
                   sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      qry_genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(Table_Genera : TFDTable;
                                       sTituloExcel   : String;
                                       sin_cero       : Boolean;
                                       sArchivo_Excel : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_General1     : TFDQuery;
begin
  Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Table_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados (Excel): '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;
//  Table_Genera.Last;
//  if (Table_Genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//     Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                            ,'Genera Excel'
//                            , mb_OK);
//     exit;
//  end;
//  Table_Genera.First;

  bImprimeInvisible := True;
  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to Table_Genera.FieldCount-1 do
      if Table_Genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := Table_Genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
      Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  Table_Genera.Open;
  Table_Genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to Table_Genera.FieldCount-1 do
  begin
    if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,Table_Genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  Table_Genera.First;
  try
    while not Table_Genera.Eof do
    begin
      for i := 0 to Table_Genera.FieldCount-1 do
      begin
        if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := Table_Genera.Fields[i].DataType;
          if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
              fvalor := 0
            else
              fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
            Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
            begin
              if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).IsNull then
                  sValor := '0'
                else
                  sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if Table_Genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            end
            else
            begin
              S1 := UpperCase(Table_Genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
                sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                   sValor := ' ';
                if sValor='' then
                   sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      Table_Genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(Table_Genera : TFDMemTable;
                                       sTituloExcel   : String;
                                       sin_cero       : Boolean;
                                       sArchivo_Excel : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_General1     : TFDQuery;
begin
   Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Table_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;
//  Table_Genera.Last;
//  if (Table_Genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//    Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                           ,'Genera Excel'
//                           , mb_OK);
//    exit;
//  end;
//  Table_Genera.First;
  bImprimeInvisible := True;
  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to Table_Genera.FieldCount-1 do
      if Table_Genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := Table_Genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
     Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  Table_Genera.Open;
  Table_Genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to Table_Genera.FieldCount-1 do
  begin
    if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,Table_Genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  Table_Genera.First;
  try
    while not Table_Genera.Eof do
    begin
      for i := 0 to Table_Genera.FieldCount-1 do
      begin
        if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := Table_Genera.Fields[i].DataType;
          if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
              fvalor := 0
            else
              fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
            Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
              if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).IsNull then
                  sValor := '0'
                else
                  sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if Table_Genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            else
            begin
              S1 := UpperCase(Table_Genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
                sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                    sValor := ' ';
                if  sValor='' then
                    sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      Table_Genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(qry_genera        :  TFDQuery;
                                       sTituloExcel      : String;
                                       sin_cero          : Boolean;
                                       bImprimeInvisible : Boolean;
                                       sArchivo_Excel    : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_General1     : TFDQuery;
begin
  Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Qry_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;

  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to qry_genera.FieldCount-1 do
      if qry_genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := qry_genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
    Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  qry_genera.Open;
  qry_genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;


  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to qry_genera.FieldCount-1 do
  begin
    if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,qry_genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  qry_genera.First;
  try
    while not qry_genera.Eof do
    begin

      for i := 0 to qry_genera.FieldCount-1 do
      begin
        if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := qry_genera.Fields[i].DataType;
          if qry_genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
             if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                fvalor := 0
             else
                fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
             Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if qry_genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
              if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).IsNull then
                   sValor := '0'
                else
                   sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if qry_genera.Fields[i].asFloat <> 0 then
                begin
                   FechaValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime;
                   Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            else
            begin
              // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
              S1 := UpperCase(qry_genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                   sValor := ' ';
                if sValor='' then
                   sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      qry_genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(Table_Genera      : TFDTable;
                                       sTituloExcel      : String;
                                       sin_cero          : Boolean;
                                       bImprimeInvisible : Boolean;
                                       sArchivo_Excel    : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_General1     : TFDQuery;
begin
  Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Table_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;

  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to Table_Genera.FieldCount-1 do
      if Table_Genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := Table_Genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
      Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  Table_Genera.Open;
  Table_Genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to Table_Genera.FieldCount-1 do
  begin
    if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,Table_Genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  Table_Genera.First;
  try
    while not Table_Genera.Eof do
    begin
      for i := 0 to Table_Genera.FieldCount-1 do
      begin
        if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := Table_Genera.Fields[i].DataType;
          if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
              fvalor := 0
            else
              fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
            Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
            begin
              if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).IsNull then
                  sValor := '0'
                else
                  sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if Table_Genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            end
            else
            begin
              S1 := UpperCase(Table_Genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
                sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                   sValor := ' ';
                if sValor='' then
                   sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      Table_Genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(Table_Genera      : TFDMemTable;
                                       sTituloExcel      : String;
                                       sin_cero          : Boolean;
                                       bImprimeInvisible : Boolean;
                                       sArchivo_Excel    : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_General1     : TFDQuery;
begin
Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Table_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;

  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to Table_Genera.FieldCount-1 do
      if Table_Genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := Table_Genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
     Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  Table_Genera.Open;
  Table_Genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to Table_Genera.FieldCount-1 do
  begin
    if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,Table_Genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  Table_Genera.First;
  try
    while not Table_Genera.Eof do
    begin
      for i := 0 to Table_Genera.FieldCount-1 do
      begin
        if (Table_Genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := Table_Genera.Fields[i].DataType;
          if Table_Genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
              fvalor := 0
            else
              fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
            Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if Table_Genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
              if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).IsNull then
                  sValor := '0'
                else
                  sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if Table_Genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            else
            begin
              S1 := UpperCase(Table_Genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
                sValor := Table_Genera.FieldByName(Table_Genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                    sValor := ' ';
                if  sValor='' then
                    sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      Table_Genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(qry_genera     : TFDQuery;
                                       sTituloExcel   : String;
                                       sTituloPestana : String;
                                       sin_cero       : Boolean;
                                       sArchivo_Excel : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_General1     : TFDQuery;
begin
   Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Qry_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;

//  qry_genera.Last;
//  if (qry_genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//      Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                             ,'Genera Excel'
//                             , mb_OK);
//      exit;
//  end;
//  qry_genera.First;
  bImprimeInvisible := True;
  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloPestana);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to qry_genera.FieldCount-1 do
      if qry_genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := qry_genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
    Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  qry_genera.Open;
  qry_genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;


  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to qry_genera.FieldCount-1 do
  begin
    if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,qry_genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  qry_genera.First;
  try
    while not qry_genera.Eof do
    begin

      for i := 0 to qry_genera.FieldCount-1 do
      begin
        if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := qry_genera.Fields[i].DataType;
          if qry_genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
             if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                fvalor := 0
             else
                fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
             Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if qry_genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
              if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).IsNull then
                   sValor := '0'
                else
                   sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if qry_genera.Fields[i].asFloat <> 0 then
                begin
                   FechaValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime;
                   Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            else
            begin
              // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
              S1 := UpperCase(qry_genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                   sValor := ' ';
                if sValor='' then
                   sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      qry_genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_dll_libro_hojas(qry_genera     : TFDMemTable;
                                       sTituloExcel   : String;
                                       sTituloPestana : String;
                                       sin_cero       : Boolean;
                                       sArchivo_Excel : String);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : string;  //PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : string;  //PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fFormat_tit      : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   xValor           : Variant;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado   : Integer;
   S1,S2,S3         : string;
   Qry_General1     : TFDQuery;
begin
   Qry_General1 := TFDQuery.Create(Application) ;
   Qry_General1.Connection := dmBaseDatos.Conexion_BaseDatos;
   p := Qry_Genera.RecordCount;
  susuario := sLogin_sistema+'/'+sPerfil_usuario;
  dfecha_descarga := fecha_hora_servidor;

  snombre_descarga := ValidaCaracteresArchivo(sTituloExcel);
  snombre_descarga := ValidaCaracteresCirculares(snombre_descarga);

  DatosOk := GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);
  if not  binsertado then
  begin
      if NOT dmBaseDatos.Conexion_BaseDatos.InTransaction then
       dmBaseDatos.Conexion_BaseDatos.StartTransaction;
      with Qry_general1 do
      begin
        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :proceso, '
               +' :usuario_pms,  '
               +' :perfil_pms, '
               +' :usuario_win, '
               +' :nombre_maq, '
               +' :direccion_Ip, '
               +' :mac,'
               +' :tipo, '
               +' :evento )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('proceso').AsString := 'PMS - DESCARGAS DE DATOS';
        parambyname('usuario_pms').AsString := sLogin_sistema;
        parambyname('perfil_pms').AsString := sPerfil_usuario ;
        parambyname('usuario_win').AsString := sUserName;
        parambyname('nombre_maq').AsString := sHostName;
        parambyname('direccion_Ip').AsString := sIPaddr;
        parambyname('mac').AsString := sMacAddr;
        parambyname('tipo').AsString :=  'P';
        parambyname('evento').AsString := copy(snombre_descarga,1,100);;
        ExecSql;

        sql.Clear;
        sql.Add(' insert into QS_SYS_LOG_DET values ( '
               +' :pid, '
               +' :fecha_hora, '
               +' :item, '
               +' :campo, '
               +' :valor )'
               );
        parambyname('pid').asfloat :=  Application.Handle;
        parambyname('fecha_hora').asdatetime := dfecha_descarga;
        parambyname('Item').asfloat :=  1;
        parambyname('campo').asstring := copy(snombre_descarga,1,60);
        parambyname('valor').AsString := 'Registros Descargados: '+floattostr(p);
        ExecSql;
        binsertado := True;
      end;
      if dmBaseDatos.Conexion_BaseDatos.InTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
  end;

//  qry_genera.Last;
//  if (qry_genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//      Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                             ,'Genera Excel'
//                             , mb_OK);
//      exit;
//  end;
//  qry_genera.First;
  bImprimeInvisible := True;
  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloPestana);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
    for i := 0 to qry_genera.FieldCount-1 do
      if qry_genera.Fields[i].visible = true then
        largo_centrado := largo_centrado +1;
  end
  else
    largo_centrado := qry_genera.FieldCount;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  if FileExists(sArchivo_Excel) then
    Book.load(sArchivo_Excel);

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  qry_genera.Open;
  qry_genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;

  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_DATE);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;


  Sheet.setCol(0,10);
//  sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
//  sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
//  sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
//  Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));

  sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;

  Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
  Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
  Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

  Sheet.writeStr(6,0,Titulo , fFormat_columna);
  Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

  filas := 7;

  columnas := 0;
  for i := 0 to qry_genera.FieldCount-1 do
  begin
    if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,qry_genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  Filas := 8;
  columnas := 0;

  qry_genera.First;
  try
    while not qry_genera.Eof do
    begin

      for i := 0 to qry_genera.FieldCount-1 do
      begin
        if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := qry_genera.Fields[i].DataType;
          if qry_genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
             if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                fvalor := 0
             else
                fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
             Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
          end
          else
          begin
            if qry_genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
              if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).IsNull then
                   sValor := '0'
                else
                   sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end
              else
              begin
                if qry_genera.Fields[i].asFloat <> 0 then
                begin
                   FechaValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime;
                   Sheet.writeNum(Filas, Columnas, FechaValor, dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                end
              end
            else
            begin
              // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
              S1 := UpperCase(qry_genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fFormat_detalle);
                except
                  begin
                    sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                   sValor := ' ';
                if sValor='' then
                   sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      qry_genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
//      PWFILE := PWideChar(sArchivo_Excel) ;
//      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

procedure Genera_excel_color(qry_genera   :  TFDQuery;
                           sTituloExcel   :  String;
                           iCampos_desde  :  Integer);
var
   sRazon_Social_excel,
   sDireccion_excel,
   sUbicacion_excel : String;
   Result           : Boolean;
   dfecha_minima    : TDateTime;
   Titulo           : String;//PAnsiChar;
   sRazon_Social,
   sDireccion,
   sUbicacion       : String;//PAnsiChar;
   Book             : TBook;
   Sheet            : TSheet;
   Font_tit         : TFont;
   Font_subtit      : TFont;
   Font_columnas    : TFont;
   Font_detalle     : TFont;
   Font_date        : TFont;
   fFormat_columna  : TFormat;
   fFormat_detalle  : TFormat;
   fdetalle         : TFormat;
   fFormat_detalle_gris  : TFormat;
   fFormat_tit      : TFormat;
   fFormat_subtit   : TFormat;
   Filas, Columnas  : Integer;
   Linea,cont,i,x   : Integer;
   tipoDato         : TFieldType;
   sValor           : string;
   fValor           : Double;
   FechaValor       : TDate;
   dateFormat       : TFormat;
   dateFormat_gris  : TFormat;
   fFechas          : TFormat;
   xValor           : Variant;
   sArchivo_Excel   : String;
   nombre_excel     : string;
   Hour, Min, Sec, MSec : Word;
   AnsString        : AnsiString;
   PAFile           : PAnsiChar;
   PWFILE           : PWideChar;
   largo_centrado,j   : Integer;
   S1,S2,S3         : string;
   aux_cambio,
   aux_cambio1      : TDateTime;
   aux_usuario,
   aux_usuario1     : String;
begin
//  qry_genera.Last;
//  if (qry_genera.RecordCount > 65535) and (sExtencion = 'XLS') then
//  begin
//    Application.MessageBox('Archivo tiene mas de 65535 regitros.'+#10+'Debe configurar la extencion de Excel a XLSX en la opcion Configuracion del Menu Principal.'
//                           ,'Genera Excel'
//                           , mb_OK);
//    exit;
//  end;
  qry_genera.First;

  dfecha_minima :=  EncodeDate(1900,01,01);
  Leer_Identidad_Direccion(sEmpresa_Usuario,
                         fItem_Dir_Usuario,
                         sRazon_Social_excel,
                         sDireccion_excel,
                         sUbicacion_excel,
                         Result);

  nombre_excel := ValidaCaracteresArchivo(sTituloExcel);
  nombre_excel := ValidaCaracteresCirculares(nombre_excel);

  DecodeTime( Fecha_Hora_Servidor, Hour, Min, Sec, MSec) ;
  sArchivo_Excel := sDirExcel
                    +copy(nombre_excel,1,20)
                    +IntToStr(Hour)
                    +IntToStr(Min)
                    +IntToStr(Sec)
                    +IntToStr(MSec)
                    +'.'+sExtencion;

  largo_centrado := 0;
  if not bImprimeInvisible then
  begin
     for i := iCampos_desde to qry_genera.FieldCount-1 do
        if qry_genera.Fields[i].visible = true then
           largo_centrado := largo_centrado + 1;
  end;

  if sExtencion = 'XLS' then
    Book := TBinBook.Create
  else
    Book := TXmlBook.Create;

  Book.setKey('PABLO NAVIA', 'windows-2f212c0f0fc3ec0f6fbc6c66a5tai9td');

  Sheet := Book.addSheet(PAnsiChar(AnsiString(nombre_excel)));//sTituloExcel));

  qry_genera.Open;
  qry_genera.First;

  Font_tit := Book.addFont;
  Font_tit.size := 8;
  Font_tit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_tit.bold := True;

  Font_subtit := Book.addFont;
  Font_subtit.size := 8;
  Font_subtit.color := COLOR_DARKBLUE_CL; //COLOR_BLUE;
  Font_subtit.bold := True;

  Font_columnas := Book.addFont;
  Font_columnas.size := 8;
  Font_columnas.bold := True;

  Font_detalle := Book.addFont;
  Font_detalle.size := 8;


  Font_date  := Book.addFont;
  Font_date.size := 8;

  fFormat_tit := Book.addFormat();
  fFormat_tit.alignH := ALIGNH_LEFT;
  fFormat_tit.font := Font_tit;

  fFormat_subtit := Book.addFormat();
  fFormat_subtit.alignH := ALIGNH_LEFT;
  fFormat_subtit.font := Font_tit;

  fFormat_columna := Book.addFormat();
  fFormat_columna.setBorder(BORDERSTYLE_THIN);
  fFormat_columna.alignH := ALIGNH_CENTER;
  fFormat_columna.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_columna.font := Font_columnas;
  fFormat_columna.fillPattern := FILLPATTERN_SOLID;

  fFormat_detalle := Book.addFormat();
  fFormat_detalle.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle.alignH := ALIGNH_GENERAL;
  fFormat_detalle.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle.font := Font_detalle;

  fFormat_detalle_gris := Book.addFormat();
  fFormat_detalle_gris.setBorder(BORDERSTYLE_THIN);
  fFormat_detalle_gris.alignH := ALIGNH_GENERAL;
  fFormat_detalle_gris.setNumFormat(NUMFORMAT_NUMBER_SEP_D2);
  fFormat_detalle_gris.patternForegroundColor := COLOR_GRAY25 ;
  fFormat_detalle_gris.font := Font_detalle;
  fFormat_detalle_gris.fillPattern := FILLPATTERN_SOLID;

  dateFormat := Book.addFormat();
  dateFormat.setNumFormat(NUMFORMAT_CUSTOM_MDYYYY_HMM);
  dateFormat.setBorder(BORDERSTYLE_THIN);
  dateFormat.font := Font_date;

  dateFormat_gris := Book.addFormat();
  dateFormat_gris.setNumFormat(NUMFORMAT_CUSTOM_MDYYYY_HMM);
  dateFormat_gris.setBorder(BORDERSTYLE_THIN);
  dateFormat_gris.font := Font_date;
  dateFormat_gris.patternForegroundColor := COLOR_GRAY25 ;
  dateFormat_gris.fillPattern := FILLPATTERN_SOLID;

  if not bSincabezara then
  begin
    Sheet.setCol(0,10);
    //sRazon_Social := PAnsiChar(PansiString(AnsiString(sRazon_Social_excel)));
    //sDireccion    := PAnsiChar(PansiString(AnsiString(sDireccion_excel)));
    //sUbicacion    := PAnsiChar(PansiString(AnsiString(sUbicacion_excel)));
    //Titulo        := PAnsiChar(PansiString(AnsiString(sTituloExcel)));
    sRazon_Social := sRazon_Social_excel;
    sDireccion    := sDireccion_excel;
    sUbicacion    := sUbicacion_excel;
    Titulo        := sTituloExcel;


    Sheet.writeStr(0, 0,sRazon_Social , fFormat_tit);
    Sheet.writeStr(2, 0,sDireccion , fFormat_tit);
    Sheet.writeStr(4, 0,sUbicacion , fFormat_tit);

    filas := 6;

    Sheet.writeStr(6,0,Titulo , fFormat_columna);
    Sheet.setMerge (6,6,0,largo_centrado-1);  //qry_genera.FieldCount-1);

    filas := 7;

  end
  else
    filas := 0;

  columnas := 0;
  for i := iCampos_desde to qry_genera.FieldCount-1 do
  begin
    if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
    begin
      Sheet.writeStr(filas,columnas,qry_genera.Fields[i].DisplayLabel,fFormat_columna);
      Sheet.setCol(Columnas,-1);
      inc(columnas);
    end;
  end;

  if not bSincabezara then
    Filas := 8
  else
    Filas := 1;

  columnas := 0;

  qry_genera.First;
  aux_cambio := qry_genera.FieldByName('Fecha_Hora').AsDateTime;

  fdetalle :=  fFormat_detalle;
  fFechas  :=  dateFormat;
  j := 0;
  try
    while not qry_genera.Eof do
    begin
      aux_cambio1 := qry_genera.FieldByName('Fecha_Hora').AsDateTime;
      if aux_cambio <> aux_cambio1 then
      begin
//         filas := filas + 1;
         aux_cambio := aux_cambio1;
         if j = 1 then
         begin
          fdetalle :=  fFormat_detalle;
          fFechas  :=  dateFormat;
          j := 0;
         end
         else
         begin
          fdetalle :=  fFormat_detalle_gris;
          fFechas  :=  dateFormat_gris;
          j := 1;
         end;
      end;

      for i := iCampos_desde to qry_genera.FieldCount-1 do
      begin
        if (qry_genera.Fields[i].visible = true) or (bImprimeInvisible) then
        begin
//        columnas := i ;
          tipoDato := qry_genera.Fields[i].DataType;
          if qry_genera.Fields[i].DataType  in [ftFMTBcd,ftInteger,ftSmallint,ftFloat,ftCurrency,ftAutoInc] then
          begin
            if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
              fvalor := 0
            else
              fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
            Sheet.writeNum(Filas, Columnas, fValor,  fdetalle); //fFormat_detalle);
          end
          else
          begin
            if qry_genera.Fields[i].DataType in [ftDateTime,ftDate,ftTimeStamp] then
              if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime < dfecha_minima then
              begin
                if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).IsNull then
                  sValor := '0'
                else
                  sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fdetalle); //fFormat_detalle);
              end
              else
              begin
                if qry_genera.Fields[i].asFloat <> 0 then
                begin
                  FechaValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsDateTime;
                  Sheet.writeNum(Filas, Columnas, FechaValor,fFechas);// dateFormat) //Book.datePack(Anio, Mes, Dia), dateFormat);
                end
                else
                begin
                  xValor := '';
                  Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fdetalle); //fFormat_detalle);fFormat_detalle);
                end
              end
            else
            begin
              S1 := UpperCase(qry_genera.Fields[i].DisplayLabel);
              S2 := 'FOLIO';
              S3 := STRPAS(StrPos(Pchar(S1),PChar(S2)));
              if trim(S3) <> '' then  /// OJO!!!
              begin
                try
                  if qry_genera.FieldByName(qry_genera.Fields[i].FieldName).isnull then
                    fvalor := 0
                  else
                    fValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsVariant;
                  Sheet.writeNum(Filas, Columnas, fValor, fdetalle); //fFormat_detalle);fFormat_detalle);
                except
                  begin
                    sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                    if (sValor.IsEmpty) then
                        sValor := ' ';
                    if  sValor='' then
                        sValor := ' ';
                    Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fdetalle); //fFormat_detalle);fFormat_detalle);
                  end;
                end;
              end
              else
              begin
                // PlanillaPms.cells[Linea,i+1].NumberFormat := '@'; //Text
                sValor := qry_genera.FieldByName(qry_genera.Fields[i].FieldName).AsString;
                if (sValor.IsEmpty) then
                    sValor := ' ';
                if  sValor='' then
                    sValor := ' ';
                Sheet.writeStr(Filas, Columnas, PAnsiChar(PAnsiString(AnsiString(svalor))),fdetalle); //fFormat_detalle);fFormat_detalle);
              end;
            end;
          end;
          Inc(columnas);
        end;
      end;
      Columnas := 0;
      inc(filas);
      qry_genera.Next
    end;
  finally
    begin
      AnsString := AnsiString(sArchivo_Excel);
      PAFile := PAnsiChar(PAnsiString(AnsString));
      Book.save(PAFile);
      PWFILE := PWideChar(sArchivo_Excel) ;
      ShellExecute(0, 'open', PWFILE, nil, nil, SW_SHOW);
      Book.Free;
    end;
  end;
end;

end.
