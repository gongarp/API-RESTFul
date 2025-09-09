unit Frm_ReportLimitesDetalle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Wwdatsrc, DBTables, Wwquery, StdCtrls, ExtCtrls, Wwtable, frxClass,
  frxExportMail, frxDBSet, frxExportPDF;

type
  TFrmReportLimitesDetalle = class(TForm)
    ReportLimites: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxMailExport1: TfrxMailExport;
    frxPDFExport1: TfrxPDFExport;
  private
    { Private declarations }
  public
    { Public declarations }
    TotPages : Integer;
  end;

var
  FrmReportLimitesDetalle: TFrmReportLimitesDetalle;

implementation
Uses Frm_DatosLimites;

{$R *.DFM}


end.
