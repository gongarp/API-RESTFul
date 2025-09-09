unit ConsultaGeneracionExcel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Vcl.ExtCtrls;

type
  TfrmConsultaGeneraExcel = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function Consulta_Genera_Excel(xMaxRegs      : Integer;
                               Var bConsulta : Boolean;
                               var bSalir    : Boolean) : Boolean;

var
  frmConsultaGeneraExcel: TfrmConsultaGeneraExcel;
  iMaxRegs : Integer;

implementation

uses
  DM_Variables_Menu,
  DM_FuncionesMemory;

{$R *.DFM}

function Consulta_Genera_Excel(xMaxRegs      : Integer;
                               Var bConsulta : Boolean;
                               var bSalir    : Boolean) : Boolean;
begin
  frmConsultaGeneraExcel := TfrmConsultaGeneraExcel.Create(Application);
  With frmConsultaGeneraExcel do
  begin
    iMaxRegs := xMaxRegs;


    Result := False;
    bSalir := False;
    case ShowModal of
      mrYes    : Result := True;
      mrCancel : bSalir := True;
    end;

    
   // Result := (ShowModal = mrYes);
  //  bSalir := (ShowModal = mrCancel);
    bConsulta := CheckBox1.Checked;
  end;
end;

procedure TfrmConsultaGeneraExcel.FormShow(Sender: TObject);
begin
  if transaccion_implica_Mem(sEmpresa_Usuario,'EXCEL') then
    CheckBox1.visible := False;

  Memo1.Lines.Clear;
  Memo1.Lines.Add('El archivo a generar tiene mas de '
                     +IntToStr(iMaxRegs)
                     +' registros.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('El proceso de traspaso a Excel podria tomar mucho tiempo');
  Memo1.Lines.Add('por lo cual es recomendable generar un archivo de texto');
  Memo1.Lines.Add('que puede ser importado posteriormente a Excel.');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('¿Desea de todas formas realizar el traspaso directo?');
end;

end.
