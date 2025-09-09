unit MensajesDialog;


interface
uses
  Windows, Messages, SysUtils, Classes, Graphics,Vcl.StdCtrls, Controls, Forms, Dialogs;

function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; Captions: array of string; DefaultButton: TMsgDlgBtn): Integer; overload;
function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; Captions: array of string): Integer; overload;
function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): Integer; overload;
function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons): Integer; overload;

implementation
function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; Captions: array of string ;DefaultButton: TMsgDlgBtn): Integer; overload ;
var
   aMsgDlg: TForm;
   i: Integer;
   dlgButton: TButton;
   CaptionIndex: Integer;
begin
   aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons,DefaultButton);
   aMsgDlg.Caption := Titulo;
   captionIndex := 0;
   for i := 0 to aMsgDlg.ComponentCount - 1 do
   begin
     if (aMsgDlg.Components[i] is TButton) then
     begin
       dlgButton := TButton(aMsgDlg.Components[i]);
       if CaptionIndex > High(Captions) then Break;
       dlgButton.Caption := Captions[CaptionIndex];
       Inc(CaptionIndex);
     end;
   end;
   Result := aMsgDlg.ShowModal;
end;

function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; Captions: array of string): Integer; overload;
var
   DefaultButton: TMsgDlgBtn;

begin
  if mbOk in Buttons then DefaultButton := mbOk else
    if mbYes in Buttons then DefaultButton := mbYes else
      DefaultButton := mbRetry;
   Result := myMessageDialog(Msg,Titulo, DlgType, Buttons,Captions,DefaultButton);
end;
function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; DefaultButton: TMsgDlgBtn): Integer; overload;
const
  Captions_Es : array[0..11] of string = ('Si','No','Aceptar','Cancelar','Abortar','Reintentar','Ignorar','Todos','No a Todo','Si a Todos','Ayuda','Cerrar');
var
  CaptionIndex, i: Integer;
  B : TMsgDlgBtn;
  LCaptions : array of string;
  valor : string;
begin
   i := 0;
   SetLength(LCaptions,SizeOf(Buttons));
   for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
   begin
     begin
       if i = sizeof(Buttons) then break;
       if B in Buttons then
       begin
       captionIndex := Ord(B);
       valor := Captions_Es[captionIndex];
       LCaptions[i] := Captions_Es[captionIndex];
       Inc(i);

       end;
     end;
   end;
   Result := myMessageDialog(Msg,Titulo, DlgType, Buttons,LCaptions,DefaultButton);
end;

function MyMessageDialog(const Msg: string; Titulo : string ; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons): Integer; overload;
var
  DefaultButton: TMsgDlgBtn;
begin
  if mbOk in Buttons then DefaultButton := mbOk else
    if mbYes in Buttons then DefaultButton := mbYes else
      DefaultButton := mbRetry;

   Result := myMessageDialog(Msg,Titulo, DlgType, Buttons,DefaultButton);
end;

end.
