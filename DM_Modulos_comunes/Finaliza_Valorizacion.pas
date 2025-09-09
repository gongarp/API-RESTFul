unit Finaliza_Valorizacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TFrm_FinalizaValorizacion = class(TForm)
    Lb_Mensaje: TLabel;
    Btn_Aceptar: TButton;
    Image1: TImage;
    procedure Btn_AceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_FinalizaValorizacion: TFrm_FinalizaValorizacion;

implementation

{$R *.DFM}

procedure TFrm_FinalizaValorizacion.Btn_AceptarClick(Sender: TObject);
begin
     Close;
end;

procedure TFrm_FinalizaValorizacion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

end.
