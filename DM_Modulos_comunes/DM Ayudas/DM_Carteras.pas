unit DM_Carteras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, wwidlg, DM_Variables_Menu, DM_Comun,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  vcl.wwDialog;

type
  TdmCarteras = class(TDataModule)
    QRY_General: TFDQuery;
    T_Paradox: TFDMemTable;
    Search_Tipo: TwwSearchDialog;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure Leer_Cartera(sEmpresa               : String;
                         sCartera               : String;
                         var sDescripcion       : String;
                         var sIdentidadCli      : String;
                         var sMoneda_Cartera    : String;
                         var sProrrateo_Valores : String;
                         var Result             : Boolean);

  procedure Empresa_Cartera(sCartera         : String;
                        var sEmpresa         : String);

  procedure Cartera_esde_Empresa(sCartera         : String;
                                 sEmpresa         : String;
                             var Result           : Boolean);

  procedure Ayuda_Cartera_String(sEmpresa         : String;
                                 sString_Carteras : String;
                                 sGrupo           : String;
                                 var sCartera     : String;
                                 var Result       : Boolean);

var
  dmCarteras: TdmCarteras;

implementation
{$R *.DFM}

uses DM_Base_Datos;

procedure Leer_Cartera(sEmpresa         : String;
                       sCartera         : String;
                       var sDescripcion : String;
                       var sIdentidadCli: String;
                       var sMoneda_Cartera : String;
                       var sProrrateo_Valores : String;
                       var Result       : Boolean);
begin
   Result := False;
   sDescripcion := ' ';
   WITH dmCarteras.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Descripcion'
             +'      ,cod_ent_cli'
             +'      ,Moneda_Cartera'
             +'      ,Cod_Empresa'
             +'      ,prorrateo_valores'
             +'  FROM QS_FIN_CARTERAS'
             +' WHERE Cod_Cartera = :Cod_Cartera');

      if Trim(sEmpresa) <> '' then
      begin
        SQL.Add(' AND Cod_empresa = :Cod_empresa');
        ParamByName('Cod_empresa').AsString := trim(sEmpresa);
      end;

      ParamByName('Cod_Cartera').AsString := trim(sCartera);
      Open;
      if NOT (FieldByName('Descripcion').IsNull) then
      begin
         sDescripcion := FieldByName('Descripcion').AsString;
         sIdentidadCli:= FieldByName('cod_ent_cli').AsString;
         sEmpresa     := FieldByName('Cod_Empresa').AsString;
         sProrrateo_Valores := FieldByName('Prorrateo_Valores').AsString;
         if FieldByName('Moneda_Cartera').IsNull then
            sMoneda_Cartera:= ''
         else
            sMoneda_Cartera:= FieldByName('Moneda_Cartera').AsString;
         Result       := True;
      end;
      Close;
   end;
end;

procedure Empresa_Cartera(sCartera         : String;
                   var sEmpresa         : String);
begin
   WITH dmCarteras.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Cod_Empresa'
             +'  FROM QS_FIN_CARTERAS'
             +' WHERE Cod_Cartera = :Cod_Cartera'
             );
      ParamByName('Cod_Cartera').AsString := trim(sCartera);
      Open;
      if NOT (FieldByName('Cod_Empresa').IsNull) then
         sEmpresa := FieldByName('Cod_Empresa').AsString;
      Close;
   end;
end;

Procedure Cartera_esde_Empresa(sCartera         : String;
                               sEmpresa         : String;
                           var Result          : Boolean);
begin
   WITH dmCarteras.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Cod_Empresa'
             +'  FROM QS_FIN_CARTERAS'
             +' WHERE Cod_Cartera = :Cod_Cartera'
             +' AND Cod_Empresa = :Empresa '
             );
      ParamByName('Cod_Cartera').AsString := trim(sCartera);
      ParamByName('Empresa').AsString     := trim(sEmpresa);
      Open;
      if NOT (FieldByName('Cod_Empresa').IsNull) then
         Result := True
      else
         Result := False;
      Close;
   end;
end;

procedure Ayuda_Cartera_String(sEmpresa         : String;
                               sString_Carteras : String;
                               sGrupo           : String;
                               var sCartera     : String;
                               var Result       : Boolean);
begin
 Result         := False;
 dmCarteras.T_Paradox.Close;

 with dmCarteras.T_Paradox.FieldDefs do
  begin
    Clear;
    Add('cod_cartera', ftString,10,False);
    Add('descripcion', ftString,60,False);
  end;

  with dmCarteras.T_Paradox.IndexDefs do
  begin
    Clear;
      Add('cod_cartera','cod_cartera',[ixprimary]);
      Add('descripcion','descripcion',[ixCaseInsensitive]);
  end;

//  dmCarteras.T_Paradox.CreateTable;
  dmCarteras.T_Paradox.Open;

  with dmCarteras.QRY_General do
  begin
   SQL.Clear;
   SQL.Add('SELECT a.Cod_cartera'
          +'      ,a.Descripcion'
          +'  FROM qs_fin_carteras   a '
          +' WHERE a.cod_cartera in '+sString_Carteras);

    Open;
    First;
    while NOT(EOF) do
    begin
      Result := True;
      dmCarteras.T_Paradox.insert;
      dmCarteras.T_Paradox.FieldByName('Cod_cartera').AsString := FieldByName('Cod_cartera').AsString;
      dmCarteras.T_Paradox.FieldByName('Descripcion').AsString := FieldByName('Descripcion').AsString;
      dmCarteras.T_Paradox.Post;
      next;
    end;
    Close;
    UnPrepare;
  end;

  WITH dmCarteras.T_Paradox do
    begin
     IndexFieldNames := 'Cod_cartera';
     SetKey;
     FieldByName('Cod_cartera').AsString  := sCartera;
     if NOT GotoKey then
        First;
    end;

  dmCarteras.Search_Tipo.Caption := 'Carteras Pertenecientes al Grupo : '+sGrupo;

  if (dmCarteras.Search_Tipo.Execute) and Result  then
     begin
       sCartera := dmCarteras.T_Paradox.FieldByName('Cod_cartera').AsString;
     end
  else
  Result := False;
  Screen.Cursor := crDefault;
  dmCarteras.T_Paradox.Close;
//  dmCarteras.T_Paradox.DeleteTable;
end;


end.
