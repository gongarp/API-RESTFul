unit Frm_ReportLimites;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Wwdatsrc, DBTables, Wwquery, StdCtrls, ExtCtrls, Wwtable, frxExportMail,
  frxClass, frxExportPDF, frxDBSet;

type
  TFrmReportLimites = class(TForm)
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxMailExport1: TfrxMailExport;
    frxReport1: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
    TotPages : Integer;
  end;

var
  FrmReportLimites: TFrmReportLimites;

implementation
Uses DM_Variables_Menu,
     Frm_DatosLimites;

{$R *.DFM}

end.
