unit DM_Ayuda_Monedas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Wwintl, wwidlg, DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.Provider, Datasnap.DBClient, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, vcl.wwDialog;

type
  TDMAyuda_Monedas = class(TDataModule)
    Search_Tipo: TwwSearchDialog;
    wwIntl2: TwwIntl;
    QRY_General: TFDQuery;
    FDTable1: TFDTable;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    FDTable1COD_MONEDA: TStringField;
    FDTable1DESCRIPCION_MONEDA: TStringField;
    FDTable1TIPO_MONEDA: TStringField;
    FDTable1UNIDAD_CONVERSION: TStringField;
    FDTable1TIPO_UNI_VARIACION: TStringField;
    FDTable1UNIDAD_MEDIDA_MON: TStringField;
    FDTable1NACION_MONEDA: TStringField;
    ClientDataSet1COD_MONEDA: TStringField;
    ClientDataSet1DESCRIPCION_MONEDA: TStringField;
    Qry_Detalle: TFDQuery;
    Qry_DetalleCOD_MONEDA: TStringField;
    Qry_DetalleDESCRIPCION_MONEDA: TStringField;
    Qry_DetalleTIPO_MONEDA: TStringField;
    Qry_DetalleUNIDAD_CONVERSION: TStringField;
    Qry_DetalleTIPO_UNI_VARIACION: TStringField;
    Qry_DetalleUNIDAD_MEDIDA_MON: TStringField;
    Qry_DetalleNACION_MONEDA: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Existe_moneda(sCod_moneda   : String;
                         sTipo_Moneda  : String) : Boolean;


  procedure Ayuda_Monedas(var sMoneda  : String;
                          var Result   : Boolean);

  procedure Datos_Moneda(sCod_Moneda             : String;
                         var sTipo_Moneda        : String;
                         var sDescripcion_Moneda : String;
                         var sUnidad_Conversion  : String);

  procedure Datos_Moneda2(sCod_Moneda             : String;
                          var sTipo_Moneda        : String;
                          var sDescripcion_Moneda : String;
                          var sUnidad_Conversion  : String;
                          var sUnidad_Medida_Mon  : String);

  procedure Ayuda_Monedas_Con_Filtro(var sMoneda  : String;
                                     sFiltro      : String;
                                     sCaption     : String;
                                     var Result   : Boolean);

var
  DMAyuda_Monedas: TDMAyuda_Monedas;

implementation

//uses DM_Ayuda_Unidad_Tiempo;

{$R *.DFM}

function Existe_moneda(sCod_moneda   : String;
                       sTipo_Moneda  : String) : Boolean;
begin
   with DMAyuda_Monedas.QRY_General do
   begin
     if sCod_Moneda = '' then
     begin
       Result := False;
       exit;
     end;
     Close;
     SQL.Clear;
     SQL.Add('SELECT Cod_Moneda');
     SQL.Add('      ,Descripcion_Moneda');
     SQL.Add('      ,Unidad_Conversion');
     SQL.Add('  FROM Qs_Sys_Monedas');
     SQL.Add(' WHERE Cod_Moneda = :Cod_Moneda');
     SQL.Add('   AND Tipo_Moneda = :Tipo_Moneda');

     ParamByName('Cod_Moneda' ).AsString := sCod_Moneda;
     ParamByName('Tipo_Moneda').AsString := sTipo_Moneda;
     Open;

     if (FieldByName('Cod_moneda').AsString <> sCod_Moneda) or
        (FieldByName('Cod_Moneda').IsNull )                 then
        Result := False
     else
        Result := True;

     Close;
   end;
end;
//------------------------------------------------------------------------------
procedure Ayuda_Monedas(var sMoneda  : String;
                        var Result   : Boolean);
begin
  Result := False;
  DMAyuda_Monedas.FDTable1.Close;
  DMAyuda_Monedas.ClientDataSet1.Active := False;

  DMAyuda_Monedas.FDTable1.Open;
  DMAyuda_Monedas.ClientDataSet1.Active := True;

  //if (DMAyuda_Monedas.Search_Tipo.Execute) and Result  then    //  23/09/2015  PA y GG
  if (DMAyuda_Monedas.Search_Tipo.Execute) then
  begin
    With DMAyuda_Monedas.Qry_Detalle do
    begin
      Close;
      ParamByName('Cod_Moneda').AsString := DMAyuda_Monedas.ClientDataSet1COD_MONEDA.AsString;

      Open;
      sMoneda := DMAyuda_Monedas.Qry_DetalleCod_Moneda.AsString;
      Result := True;
    end;
  end;

  DMAyuda_Monedas.FDTable1.Close;
  Screen.Cursor := crDefault;
end;

procedure Datos_Moneda(sCod_Moneda             : String;
                       var sTipo_Moneda        : String;
                       var sDescripcion_Moneda : String;
                       var sUnidad_Conversion  : String);
begin
 with DMAyuda_Monedas.QRY_General do
  begin
   SQL.Clear;
   SQL.Add('SELECT Tipo_Moneda');
   SQL.Add('      ,Descripcion_Moneda');
   SQL.Add('      ,Unidad_Conversion');
   SQL.Add('  FROM Qs_Sys_Monedas');
   SQL.Add(' WHERE Cod_Moneda = :Cod_Moneda');

   ParamByName('Cod_Moneda').AsString := sCod_Moneda;
   Prepare;
   Open;

   sTipo_Moneda        := FieldByName('Tipo_Moneda').AsString;
   sDescripcion_Moneda := FieldByName('Descripcion_Moneda').AsString;
   sUnidad_Conversion  := FieldByName('Unidad_Conversion').AsString;

   Close;
   UnPrepare;
  end;
end;

procedure Datos_Moneda2(sCod_Moneda             : String;
                        var sTipo_Moneda        : String;
                        var sDescripcion_Moneda : String;
                        var sUnidad_Conversion  : String;
                        var sUnidad_Medida_Mon  : String);
begin
 with DMAyuda_Monedas.QRY_General do
  begin
   SQL.Clear;
   SQL.Add('SELECT Tipo_Moneda');
   SQL.Add('      ,Descripcion_Moneda');
   SQL.Add('      ,Unidad_Conversion');
   SQL.Add('      ,Unidad_Medida_Mon');
   SQL.Add('  FROM Qs_Sys_Monedas');
   SQL.Add(' WHERE Cod_Moneda = :Cod_Moneda');

   ParamByName('Cod_Moneda').AsString := sCod_Moneda;
   Prepare;
   Open;

   sTipo_Moneda        := FieldByName('Tipo_Moneda').AsString;
   sDescripcion_Moneda := FieldByName('Descripcion_Moneda').AsString;
   sUnidad_Conversion  := FieldByName('Unidad_Conversion').AsString;
   sUnidad_Medida_Mon  := FieldByName('Unidad_Medida_Mon').AsString;

   Close;
   UnPrepare;
  end;
end;

procedure Ayuda_Monedas_Con_Filtro(var sMoneda  : String;
                                   sFiltro      : String;
                                   sCaption     : String;
                                   var Result   : Boolean);
begin
  Result := True;
  DMAyuda_Monedas.Search_Tipo.caption :=  sCaption;

  DMAyuda_Monedas.FDTable1.Close;
  DMAyuda_Monedas.ClientDataSet1.Active := False;

  DMAyuda_Monedas.FDTable1.Filter := sFiltro;
  DMAyuda_Monedas.FDTable1.Filtered := True;
  DMAyuda_Monedas.FDTable1.Open;


  DMAyuda_Monedas.ClientDataSet1.Active := True;

  if (DMAyuda_Monedas.Search_Tipo.Execute) and Result  then
  begin
    sMoneda := DMAyuda_Monedas.ClientDataSet1COD_MONEDA.AsString;
    Result := True;
  end
  else
    Result := False;

  DMAyuda_Monedas.FDTable1.Close;
  Screen.Cursor := crDefault;

end;

end.
