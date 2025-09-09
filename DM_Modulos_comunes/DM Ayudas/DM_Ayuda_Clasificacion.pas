unit DM_Ayuda_Clasificacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.DB, Datasnap.DBClient, vcl.wwdialog, vcl.wwidlg,
  Datasnap.Provider;

type
  TDMAyuda_Clasificacion = class(TDataModule)
    QRY_General: TFDQuery;
    FDMemTable1: TFDMemTable;
    ClientDataSet1: TClientDataSet;
    Search_Clasifica: TwwSearchDialog;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1codigo_objeto: TStringField;
    ClientDataSet1descripcion_objeto: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Clasificacion_Objeto(sObjeto        : String;
                                sElemento      : String;
                                sCodigo_Clasif : String) : String;

  function Nodo_Clasif_Objeto(sObjeto        : String;
                              sElemento      : String;
                              sCodigo_Clasif : String) : Double;

  procedure Ayuda_Clasificacion(var Clasificacion : String;
                                var Result        : Boolean);

var
  DMAyuda_Clasificacion: TDMAyuda_Clasificacion;

implementation

uses
   DM_Base_Datos,
   DM_Comun,
   DM_Variables_Menu;
{$R *.DFM}

function Clasificacion_Objeto(sObjeto        : String;
                              sElemento      : String;
                              sCodigo_Clasif : String) : String;
begin
  WITH DMAyuda_Clasificacion.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT descripcion_nodo As Clasificacion ');
    SQL.Add('  FROM qs_sys_clasif_obj a               ');
    SQL.Add('      ,qs_sys_est_cla c                  ');
    SQL.Add(' WHERE  a.elemento     = :Elemento       ');     // 'LH'
    SQL.Add('   AND a.codigo_clasif = :Codigo_Clasif  ');     // GRUPINSVAR'
    SQL.Add('   AND a.objeto        = :Objeto         ');
    SQL.Add('   AND c.codigo_objeto = a.codigo_clasif ');
    SQL.Add('   AND c.nodo          = a.nodo          ');

    ParamByName('Elemento').AsString      := sElemento;
    ParamByName('Codigo_Clasif').AsString := sCodigo_Clasif;
    ParamByName('Objeto').AsString        := sObjeto;
    Open;

    if FieldByName('Clasificacion').IsNull then
       Result := ''
    else
       Result := FieldByName('Clasificacion').AsString;
    DMAyuda_Clasificacion.QRY_General.Close;
  end;
end;

function Nodo_Clasif_Objeto(sObjeto        : String;
                            sElemento      : String;
                            sCodigo_Clasif : String) : Double;
begin
  WITH DMAyuda_Clasificacion.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Nodo As Clasificacion ');
    SQL.Add('  FROM qs_sys_clasif_obj a               ');
    SQL.Add('      ,qs_sys_est_cla c                  ');
    SQL.Add(' WHERE  a.elemento     = :Elemento       ');     // 'LH'
    SQL.Add('   AND a.codigo_clasif = :Codigo_Clasif  ');     // GRUPINSVAR'
    SQL.Add('   AND a.objeto        = :Objeto         ');
    SQL.Add('   AND c.codigo_objeto = a.codigo_clasif ');
    SQL.Add('   AND c.nodo          = a.nodo          ');

    ParamByName('Elemento').AsString      := sElemento;
    ParamByName('Codigo_Clasif').AsString := sCodigo_Clasif;
    ParamByName('Objeto').AsString        := sObjeto;
    Open;

    if FieldByName('Clasificacion').IsNull then
       Result := 0
    else
       Result := FieldByName('Clasificacion').AsFloat;
    DMAyuda_Clasificacion.QRY_General.Close;
  end;
end;

{Despliega ventana ayuda}
procedure Ayuda_Clasificacion(var Clasificacion : String;
                              var Result        : Boolean);
var sNombre_Tabla : String;
begin
  Result         := False;

  DMAyuda_Clasificacion.FDMemTable1.Close;
  DMAyuda_Clasificacion.QRY_General.Close;


   with DMAyuda_Clasificacion.QRY_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * '
             +'  FROM QS_SYS_CLASIFICA'
             +' WHERE CODIGO_OBJETO IN (SELECT CODIGO_CLASIF'
			       +'                           FROM qs_sys_clasif_obj '
			       +'                          WHERE OBJETO IN (''INSTRUM'', ''NEMOTECNIC'', ''NEMRVAR''))'
             +' ORDER BY CODIGO_OBJETO');

      Open;
      DMAyuda_Clasificacion.QRY_General.FetchAll;
      DMAyuda_Clasificacion.FDMemTable1.Data := DMAyuda_Clasificacion.QRY_General.Data;
      DMAyuda_Clasificacion.FDMemTable1.First;
      Close;
   end;

  DMAyuda_Clasificacion.Search_Clasifica.ShadowSearchTable := DMAyuda_Clasificacion.ClientDataSet1;
  DMAyuda_Clasificacion.ClientDataSet1.Active := True;

  try
     if DMAyuda_Clasificacion.Search_Clasifica.Execute then
     begin
        Clasificacion := DMAyuda_Clasificacion.ClientDataSet1.FieldByName('Codigo_Objeto').AsString;
        Result := True;
     end
     else
        Result := False;
  except
  end;
  Screen.Cursor := crDefault;
  DMAyuda_Clasificacion.FDMemTable1.Close;
end;
end.
