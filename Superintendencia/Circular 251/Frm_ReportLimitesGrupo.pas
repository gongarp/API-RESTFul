unit Frm_ReportLimitesGrupo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Wwdatsrc, DBTables, Wwquery, StdCtrls, ExtCtrls, Wwtable, frxExportMail,
  frxClass, frxExportPDF, frxDBSet;

type
  TFrmReportLimitesGrupo = class(TForm)
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxMailExport1: TfrxMailExport;
  private
    { Private declarations }
  public
    { Public declarations }
    TotPages : Integer;
  end;

var
  FrmReportLimitesGrupo: TFrmReportLimitesGrupo;

implementation
Uses DM_Variables_Menu,
     Frm_DatosLimites;

{$R *.DFM}

end.
