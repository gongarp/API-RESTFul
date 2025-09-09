unit DM_Ayuda_Tipo_Empresas;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, wwidlg, Wwintl, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, vcl.wwDialog, Datasnap.Provider,
  Datasnap.DBClient;

type
  TdmAyuda_Tipo_Empresa = class(TDataModule)
    wwIntl2: TwwIntl;
    QRY_General: TFDQuery;
    ClientDataSet1: TClientDataSet;
    Search_Tipo: TwwSearchDialog;
    DataSetProvider1: TDataSetProvider;
    Qry_Detalle: TFDQuery;
    Qry_DetalleCODIGO_IDENTIDAD: TStringField;
    Qry_DetalleJURIDICO_NATURAL: TStringField;
    Qry_DetalleCREDENCIAL: TStringField;
    Qry_DetalleRAZON_SOCIAL_PAT: TStringField;
    Qry_DetalleNOMBRE_FANTA_MAT: TStringField;
    Qry_DetalleNOMBRES: TStringField;
    Qry_Gral_Ayuda: TFDQuery;
    Qry_Gral_AyudaCodigo_Identidad: TStringField;
    Qry_Gral_AyudaRazon_Social_Pat: TStringField;
    ClientDataSet1Codigo_Identidad: TStringField;
    ClientDataSet1Razon_Social_Pat: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Leer_Tipo_Empresa(sEmpresa,
                             sTipo_Empresa : String;
                             dFecha        : TDatetime): Boolean;

  function Default_TipEmp(sEmpresa      : String;
                          fItem_Dir     : Double;
                          sTipo_Empresa : String): String;

  procedure Ayuda_Tipo_Empresa(var sEmpresa  : String;
                               sTipo_Empresa : String;
                               dFecha        : TDatetime;
                               var Result    : Boolean);
var
  dmAyuda_Tipo_Empresa: TdmAyuda_Tipo_Empresa;

implementation
Uses
  DM_Comun;

{$R *.DFM}
{Verifica si existe}
function Leer_Tipo_Empresa(sEmpresa,
                           sTipo_Empresa : String;
                           dFecha        : TDatetime): Boolean;
begin
 Result         := True;
  if sEmpresa = '' then
     begin
       Result := False;
       exit;
     end;

  with dmAyuda_Tipo_Empresa.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Codigo_Identidad'
           +'  FROM QS_SYS_ID_TIPO a'
           +' WHERE a.Codigo_Identidad = :Codigo_Identidad'
           +'   AND a.Tipo_Empresa     = :Tipo_Empresa'
           +'   AND a.Fecha_Desde     <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString := sEmpresa;
    ParamByName('Tipo_Empresa').AsString     := sTipo_Empresa;
    ParamByName('Fecha').AsDateTime          := dFecha;

    Open;

    if FieldByName('Codigo_Identidad').AsString <> sEmpresa then
       Result := False;

    Close;
  end;
  Screen.Cursor := crDefault;
end;

function Default_TipEmp(sEmpresa      : String;
                        fItem_Dir     : Double;
                        sTipo_Empresa : String): String;
var
  Buscar  : Boolean;
  bResult : Boolean;
begin
  Buscar := True;

  While Buscar do
    begin
      with dmAyuda_Tipo_Empresa.QRY_General do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT Empresa'
                 +'  FROM QS_SYS_DFLT_TIPEMP'
                 +' WHERE Codigo_Identidad = :Codigo_Identidad'
                 +'   AND Item_dir         = :Item_Dir'
                 +'   AND Tipo_Empresa     = :Tipo_Empresa'
                 );
          ParamByName('Codigo_Identidad').AsString := sEmpresa;
          ParamByName('Item_Dir').AsFloat          := fItem_Dir;
          ParamByName('Tipo_Empresa').AsString     := sTipo_Empresa;
          Prepare;
          Open;
          if NOT (FieldByName('Empresa').IsNull) then
             begin
               Result := FieldByName('Empresa').AsString;
               Buscar := False;
             end
          else
             begin
               Direccion_Padre(sEmpresa
                              ,fItem_dir
                              ,bResult);
               if NOT bResult then
                  begin
                    Result := ' ';
                    Buscar := False;
                  end;
             end;
          Close;
        end; // with
    end; // while
end;
{Despliega ventana ayuda}
procedure Ayuda_Tipo_Empresa(var sEmpresa  : String;
                             sTipo_Empresa : String;
                             dFecha        : TDatetime;
                             var Result    : Boolean);
begin
  Result := False;
  dmAyuda_Tipo_Empresa.Search_Tipo.Caption := 'Empresas segun tipo :'+sTipo_Empresa;
  dmAyuda_Tipo_Empresa.ClientDataSet1.Active := False;
  With dmAyuda_Tipo_Empresa.Qry_Gral_Ayuda do
  begin
    Close;
    ParamByName('p_Tipo_Empresa').AsString := sTipo_Empresa;
    ParamByName('p_Fecha').AsDateTime      := dFecha;
    Open;

    dmAyuda_Tipo_Empresa.ClientDataSet1.Active := True;
    if dmAyuda_Tipo_Empresa.Search_Tipo.execute then
    begin
        sEmpresa := dmAyuda_Tipo_Empresa.ClientDataSet1Codigo_Identidad.AsString;
        Result   := True;
    end;
  end;
  dmAyuda_Tipo_Empresa.Qry_Gral_Ayuda.Close;

  Screen.Cursor := crDefault;
end;

end.
