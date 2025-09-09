unit Frm_ReportPorEmisorInstrumento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Wwdatsrc, DBTables, Wwquery, StdCtrls, ExtCtrls, Wwtable, frxClass,
  frxDBSet, frxExportMail, frxExportPDF;

type
  TFrmReportPorEmisorInstrumento = class(TForm)
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxMailExport1: TfrxMailExport;
    frxDBDataset1: TfrxDBDataset;
  private
    { Private declarations }
    sEmisor           : String;
    fMaximo_Permitido : Double;
  public
    { Public declarations }
    TotPages : Integer;
    bImprime_BandaPorcentaje,
    bImprime_BandaEmisor : Boolean;
  end;

var
  FrmReportPorEmisorInstrumento: TFrmReportPorEmisorInstrumento;

implementation
Uses DM_Identidad_Direccion,
     DM_Variables_Menu,
     Frm_DatosLimites;

{$R *.DFM}

end.
