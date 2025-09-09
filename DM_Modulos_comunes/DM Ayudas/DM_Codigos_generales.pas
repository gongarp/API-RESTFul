unit DM_Codigos_generales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Wwintl, wwidlg, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, vcl.wwDialog, FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, Datasnap.Provider,
  Datasnap.DBClient;

type
  TdmCodigos_Generales = class(TDataModule)
    Search_CodGrls: TwwSearchDialog;
    wwIntl2: TwwIntl;
    QRY_General: TFDQuery;
    Qry_Ayuda_Gral: TFDQuery;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1COD_DETAIL: TStringField;
    ClientDataSet1DESC_DETAIL: TStringField;
    Qry_Leer_Codigo_General: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure Leer_Codigo_General(sCodigo_General  : String;
                                sCodigo_Detalle  : String;
                                Var sDescripcion : String;
                                Var Result       : Boolean);
  procedure Leer_Codigo_General_Tmp(sCodigo_General  : String;
                                    sCodigo_Detalle  : String;
                                    Var sDescripcion : String;
                                    Var Result       : Boolean);
  function default_codgen(sCod_General
                         ,sSistema
                         ,sTransaccion : String) : String;

  procedure Ayuda_Codigos_Generales(     sTipo     : String;
                                     var sAux_Tipo : String;
                                     var Result    : Boolean);
                         
  function default_codgen_emp(sCod_General
                             ,sEmpresa
                             ,sCartera
                             ,sSistema
                             ,sTransaccion : String) : String;
var
  dmCodigos_Generales: TdmCodigos_Generales;

implementation
Uses
DM_Base_Datos;

{$R *.DFM}
//==============================================================================
procedure Leer_Codigo_General(sCodigo_General  : String;
                              sCodigo_Detalle  : String;
                              Var sDescripcion : String;
                              Var Result       : Boolean);
begin
   sDescripcion := '';
   Result := False;

   if (sCodigo_Detalle = ' ') or
      (sCodigo_Detalle = '')  then
      Exit;

   WITH dmCodigos_Generales.Qry_Leer_Codigo_General do
   begin
//     SQL.Clear;
//     SQL.Add('SELECT Cod_Detail'
//            +'      ,Desc_Detail'
//            +'  FROM QS_SYS_COD_DET'
//            +' WHERE Cod_General = :Cod_General'
//            +'   AND Cod_Detail  = :Cod_Detail'
//            );
     ParamByName('Cod_General').AsString := trim(sCodigo_General);
     ParamByName('Cod_Detail').AsString  := trim(sCodigo_Detalle);
     Open;
     if FieldByName('Cod_Detail').AsString = trim(sCodigo_Detalle) then
     begin
       sDescripcion := FieldByName('Desc_Detail').AsString;
       Result := True;
     end;
     Close;
   end; // With
end;

procedure Leer_Codigo_General_Tmp(sCodigo_General  : String;
                                 sCodigo_Detalle  : String;
                                 Var sDescripcion : String;
                                 Var Result       : Boolean);
begin
   sDescripcion := '';
   Result := False;

   if (sCodigo_Detalle = ' ') or
      (sCodigo_Detalle = '')  then
      Exit;

   WITH dmCodigos_Generales.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('SELECT Cod_Detail'
            +'      ,Desc_Detail'
            +'  FROM QS_TMP_COD_DET'
            +' WHERE Cod_General = :Cod_General'
            +'   AND Cod_Detail  = :Cod_Detail'
            );
     ParamByName('Cod_General').AsString := trim(sCodigo_General);
     ParamByName('Cod_Detail').AsString  := trim(sCodigo_Detalle);
     Open;
     if FieldByName('Cod_Detail').AsString = trim(sCodigo_Detalle) then
     begin
       sDescripcion := FieldByName('Desc_Detail').AsString;
       Result := True;
     end;
     Close;
   end; // With
end;
//==============================================================================
function default_codgen(sCod_General
                       ,sSistema
                       ,sTransaccion : String) : String;
Var
  Flag_Leer : Boolean;
begin
 Flag_Leer := True;
 WHILE Flag_Leer do
  begin
  WITH dmCodigos_Generales.QRY_General do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Cod_Detail'
             +'  FROM QS_SYS_COD_DEFAULT'
             +' WHERE Cod_General = :Cod_General'
             +'   AND Sistema     = :Sistema'
             +'   AND Transaccion = :Transaccion'
             );
      ParamByName('Cod_General').AsString := trim(sCod_General);
      ParamByName('Sistema').AsString     := trim(sSistema);

      if (sTransaccion = ' ') or
         (sTransaccion = '')  then
         begin
           sTransaccion := ' ';
           ParamByName('Transaccion').AsString := ' ';
         end
      else
         ParamByName('Transaccion').AsString := sTransaccion;

      Open;
      if FieldByName('Cod_Detail').IsNull then
         Result := ' '
      else
         begin
           Result := FieldByName('Cod_Detail').AsString;
           Flag_Leer := False;
         end;

      Close;
      UnPrepare;

      if sTransaccion = ' ' then
         Flag_Leer := False
      else
         sTransaccion := ' ';
    end; // With
  end; // While
end;
//==============================================================================
function default_codgen_emp(sCod_General
                           ,sEmpresa
                           ,sCartera
                           ,sSistema
                           ,sTransaccion : String) : String;
Var
  Flag_Leer : Boolean;
begin
 Flag_Leer := True;
 WHILE Flag_Leer do
  begin
  WITH dmCodigos_Generales.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Cod_Detail'
             +'  FROM QS_SYS_COD_DEFAULT'
             +' WHERE Cod_General      = :Cod_General'
             +'   AND codigo_identidad = :codigo_identidad');
      if (sCartera <> ' ') or (sCartera <> '') then
      begin
      SQL.Add('   AND Cartera          = :Cartera');
         ParamByName('Cartera').AsString := sCartera;
      end;
      SQL.Add('   AND Sistema          = :Sistema'
             +'   AND Transaccion      = :Transaccion'
             );
      ParamByName('Cod_General').AsString      := trim(sCod_General);
      ParamByName('codigo_identidad').AsString := trim(sEmpresa);
      ParamByName('Sistema').AsString          := trim(sSistema);

      if (sTransaccion = ' ') or
         (sTransaccion = '')  then
         begin
           sTransaccion := ' ';
           ParamByName('Transaccion').AsString := ' ';
         end
      else
         ParamByName('Transaccion').AsString := sTransaccion;
      Open;
      if FieldByName('Cod_Detail').IsNull then
      begin
         SQL.Clear;
         SQL.Add('SELECT Cod_Detail'
                +'  FROM QS_SYS_COD_DEFAULT'
                +' WHERE Cod_General      = :Cod_General'
                +'   AND codigo_identidad = :codigo_identidad'
                +'   AND Sistema          = :Sistema'
                +'   AND Transaccion      = :Transaccion'
                +'   AND (RTrim(Cartera) = '''' Or Cartera Is null)'
                );
         ParamByName('Cod_General').AsString      := trim(sCod_General);
         ParamByName('codigo_identidad').AsString := trim(sEmpresa);
         ParamByName('Sistema').AsString          := trim(sSistema);

         if (sTransaccion = ' ') or
            (sTransaccion = '')  then
            begin
              sTransaccion := ' ';
              ParamByName('Transaccion').AsString := ' ';
            end
         else
            ParamByName('Transaccion').AsString := sTransaccion;
         Open;
         if FieldByName('Cod_Detail').IsNull then
         begin
            SQL.Clear;
            SQL.Add('SELECT Cod_Detail'
                   +'  FROM QS_SYS_COD_DEFAULT'
                   +' WHERE Cod_General      = :Cod_General'
                   +'   AND codigo_identidad = :codigo_identidad'
                   +'   AND Sistema          = :Sistema'
                   );
            ParamByName('Cod_General').AsString      := trim(sCod_General);
            ParamByName('codigo_identidad').AsString := trim(sEmpresa);
            ParamByName('Sistema').AsString          := trim(sSistema);
            Open;

            if FieldByName('Cod_Detail').IsNull then
               Result := ' ';
         end
         else
         begin
            Result := FieldByName('Cod_Detail').AsString;
            Flag_Leer := False;
         end;
      end
      else
      begin
         Result := FieldByName('Cod_Detail').AsString;
         Flag_Leer := False;
      end;
      Close;
      UnPrepare;
      if sTransaccion = ' ' then
         Flag_Leer := False
      else
         sTransaccion := ' ';
    end; // With
  end; // While
end;
//==============================================================================
procedure Ayuda_Codigos_Generales(  sTipo        : String;
                                   var sAux_Tipo : String;
                                   var Result    : Boolean);
begin
  Result := False;

 DMCodigos_Generales.ClientDataSet1.Active := False;
  with DMCodigos_Generales.QRY_General do
  begin
     Sql.Clear;
     Sql.Add('SELECT * FROM QS_SYS_COD_DET'
            +' WHERE Cod_General = '''+sTipo+''''
            );

     //Open;
  end;

  DMCodigos_Generales.ClientDataSet1.Active := True;

  if DMCodigos_Generales.Search_CodGrls.Execute then
  begin
     sAux_Tipo:= DMCodigos_Generales.ClientDataSet1COD_DETAIL.AsString;
     Result   := True;
  end;

  Screen.Cursor := crDefault;
end;

end.
