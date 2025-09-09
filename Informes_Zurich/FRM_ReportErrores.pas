unit Frm_ReportErrores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Wwdatsrc, StdCtrls, ExtCtrls, Wwtable,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxClass, frxExportXLSX, frxExportPDF, frxDBSet, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteVDataSet, frxExportMail, frxExportBaseDialog;

type
  TFrmReportErrores = class(TForm)
    T_Paradox: TFDMemTable;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    Report_Errores: TfrxReport;
    T_ParadoxError: TStringField;
    T_ParadoxModulo: TStringField;
    frxMailExport1: TfrxMailExport;
    FDLocalSQL1: TFDLocalSQL;
    procedure FormCreate(Sender: TObject);
    procedure Lista_Errores_FIFO(var T_Errores_FIFO : TFDMemTable);
  private
    { Private declarations }
  public
    { Public declarations }
    TotPages : Integer;
  end;

var
  FrmReportErrores: TFrmReportErrores;

implementation
Uses DM_Identidad_Direccion,
     DM_Base_Datos,
     RPreview,
     DM_Variables_Menu;

{$R *.DFM}

procedure TFrmReportErrores.FormCreate(Sender: TObject);
begin

   T_Paradox.Close;
   with T_Paradox.FieldDefs do
   begin
     Clear;
     Add('Modulo' ,ftString, 60,False);
     Add('Error'  ,ftString,200,False);
   end;
   T_Paradox.Open;

end;

procedure TFrmReportErrores.Lista_Errores_FIFO(var T_Errores_FIFO : TFDMemTable);

var
  sString_Error : String;
  sRazon_Social,
  sDireccion,
  sUbicacion,
  sDescripcion   : String;
  Result         : Boolean;

  Lbl_Titulo,
  Label_Razon_Social,
  Label_Direccion,
  Label_Ubicacion   :  TfrxMemoView;

begin
  With TFrmReportErrores.Create(Application) Do
  begin

       T_Errores_FIFO.Open;
       T_Paradox.CopyDataSet(T_Errores_FIFO,[coRestart,coAppend]);
       T_Paradox.Open;

       With TFrmRPreview.Create(Application) Do
       begin
          Table_Excel := T_Paradox;
          Table_Qry   := 1;

          Leer_Identidad_Direccion(sEmpresa_Usuario,
                                   fItem_Dir_Usuario,
                                   sRazon_Social,
                                   sDireccion,
                                   sUbicacion,
                                   Result);
          with Report_Errores do
          begin
             Lbl_Titulo         := Report_Errores.FindObject('Lbl_Titulo') as TfrxMemoView;
             Lbl_Titulo.text    := sString_Error;
             Label_Razon_Social := Report_Errores.FindObject('Label_Razon_Social') as TfrxMemoView;
             Label_Razon_Social.Text := sRazon_Social;
             Label_Direccion := Report_Errores.FindObject('Label_Direccion') as TfrxMemoView;
             Label_Direccion.Text := sDireccion;
             Label_Ubicacion := Report_Errores.FindObject('Label_Ubicacion') as TfrxMemoView;
             Label_Ubicacion.Text := sUbicacion;

             Report_Errores.Report.ReportOptions.Name := sString_Error;
             Preview := frxPreview1;
             Report_Errores.PrepareReport(true);
             PrintOptions.ShowDialog := true;
             ShowModal;
          end;
       end;
     Close;
     Free;
  end;
end;

end.
