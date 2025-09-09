unit Muestra_Mensaje;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TMuestraMensaje = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ListBox1: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MuestraMensaje: TMuestraMensaje;

implementation

{$R *.DFM}

end.
