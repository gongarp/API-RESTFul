unit DM_Identidad_Direccion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,   Wwintl, wwidlg,  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, vcl.wwDialog, FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, Datasnap.Provider,
  Datasnap.DBClient;

type
  TdmIdentidad_Direccion = class(TDataModule)
    Search_Id_Dir: TwwSearchDialog;
    wwIntl2: TwwIntl;
    QRY_General: TFDQuery;
    FDMemTable1: TFDMemTable;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1Descripcion: TStringField;
    ClientDataSet1Item_Dir: TFloatField;
    Qry_Default_Direccion: TFDQuery;
    Qry_Codigo_Geo_IdDir: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function default_direccion(sCodigo_Identidad : String;
                             dFecha            : TDateTime) : Double;

  function Codigo_Geo_IdDir_Vig(sCodigo_Identidad : String;
                                dfecha            : TDateTime) : String;

  function Codigo_Geo_IdDir(sCodigo_Identidad : String;
                            fItem_Dir         : Double) : String;

  function direccion_matriz(sCodigo_Identidad : String;
                            dFecha            : TDateTime) : Double;

  procedure pais_identidad(sCodigo_Identidad : String;
                           dFecha            : TDateTime;
                           var sCod_Pais     : String;
                           var sModulo_Error : String;
                           var sString_Error : String;
                           var Result        : Boolean);

  procedure Leer_Identidad(sCodigo_Identidad : String;
                           sJuridico_Natural : String;
                           var sRazon_Social_Pat : String;
                           var sNombre_Fanta_Mat : String;
                           var sNombres          : String;
                           var sCredencial       : String;
                           var Result            : Boolean);


  procedure Leer_Identidad_Direccion(sCodigo_Identidad : String;
                                     fItem_Dir         : Double;
                                     var sRazon_Social : String;
                                     var sDireccion    : String;
                                     var sUbicacion    : String;
                                     var Result        : Boolean);

  procedure Ayuda_Identidad_Direccion(sCodigo_Identidad : String;
                                      var fItem_dir     : Double;
                                      var sDireccion    : String;
                                      dFecha            : TDateTime;
                                      var Result        : Boolean);

var
  dmIdentidad_Direccion: TdmIdentidad_Direccion;

implementation
Uses DM_Paises,
     DM_Base_Datos;

{$R *.DFM}
//==============================================================================
function default_direccion(sCodigo_Identidad : String;
                           dFecha            : TDateTime) : Double;
begin
  WITH dmIdentidad_Direccion.Qry_Default_Direccion do
    begin
//      SQL.Clear;
//      SQL.Add('SELECT Item_Dir'
//             +'  FROM QS_SYS_ID_DIR'
//             +' WHERE Codigo_Identidad = :Codigo_Identidad'
//             +'   AND Fecha_Desde <= :Fecha'
//             +'   AND (Fecha_Hasta >= :Fecha or Fecha_hasta is NULL)'
//             +' ORDER BY Item_Dir'
//             );

      ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
      ParamByName('Fecha').AsDateTime              := dFecha;

      Prepare;
      Open;
      First;
      if FieldByName('Item_dir').IsNull then
         Result := 0
      else
         Result := FieldByName('Item_dir').AsFloat;

      Close;
      UnPrepare;
    end;
end;    // default_direccion
//==============================================================================
function Codigo_Geo_IdDir(sCodigo_Identidad : String;
                          fItem_Dir         : Double) : String;
begin
  WITH dmIdentidad_Direccion.Qry_Codigo_Geo_IdDir do
    begin
//      SQL.Clear;
//      SQL.Add('SELECT Codigo_Geo'
//             +'  FROM QS_SYS_ID_DIR'
//             +' WHERE Codigo_Identidad = :Codigo_Identidad'
//             +'   AND Item_Dir         = :Item_Dir'
//             );
      ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
      ParamByName('Item_Dir').AsFloat          := fItem_Dir;
      Open;
      if FieldByName('Codigo_Geo').IsNull then
         Result := ''
      else
         Result := FieldByName('Codigo_Geo').AsString;

      Close;
    end;
end;   // Codigo_Geo_IdDir
//==============================================================================
///DC UTILIZAR ESTA FUNCION Y NO LA ANTERIOR... CONSIDERA VIGENCIA
function Codigo_Geo_IdDir_Vig(sCodigo_Identidad : String;
                              dfecha            : TDateTime) : String;
begin
  WITH dmIdentidad_Direccion.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT * FROM QS_SYS_ID_DIR A '
             +' WHERE A.CODIGO_IDENTIDAD = :Codigo_Identidad'
             +'   AND A.FECHA_DESDE = (SELECT MAX(B.FECHA_DESDE)'
             +'                       FROM QS_SYS_ID_DIR B    '
             +'                      WHERE B.CODIGO_IDENTIDAD = A.CODIGO_IDENTIDAD'
             +'                      AND B.ITEM_DIR = A.ITEM_DIR  '
             +'                      AND FECHA_DESDE <= :Fecha '
             +'                      AND (FECHA_HASTA >= :Fecha OR FECHA_HASTA IS NULL)'
             +'                      )    '
             +' ORDER BY ITEM_DIR   ' );

      ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
      ParamByName('Fecha').AsDateTime          := dfecha;
      Open;
      if FieldByName('Codigo_Geo').IsNull then
         Result := ''
      else
         Result := FieldByName('Codigo_Geo').AsString;

      Close;
    end;
end;   // Codigo_Geo_IdDir
//==============================================================================
function direccion_matriz(sCodigo_Identidad : String;
                          dFecha            : TDateTime) : Double;
begin
  WITH dmIdentidad_Direccion.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Item_Direccion'
             +'  FROM QS_SYS_ID_ESTGERD'
             +' WHERE Codigo_Identidad = :Codigo_Identidad'
             +'   AND Codigo_Nodo = Nodo_Padre'
             );

      ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
      Prepare;
      Open;
      First;
      if FieldByName('Item_Direccion').IsNull then
         Result := 0
      else
         Result := FieldByName('Item_Direccion').AsFloat;

      Close;
      UnPrepare;
    end;

    if Result = 0 then
       Result := default_direccion(sCodigo_Identidad
                                  ,dFecha);
end;    // direccion_matriz
//==============================================================================
procedure pais_identidad(sCodigo_Identidad : String;
                         dFecha            : TDateTime;
                         var sCod_Pais     : String;
                         var sModulo_Error : STring;
                         var sString_Error : String;
                         var Result        : Boolean);
var
  fItem_Dir     : Double;
  sUbicacion    : String;
begin
  sModulo_Error := 'Pais de Identidad';
  fItem_Dir := default_direccion(sCodigo_Identidad
                                ,dFecha);
  if fItem_Dir = 0 then
     begin
       sString_Error := 'No se encontro dirección para '+sCodigo_Identidad;
       Result := False;
       exit;
     end;

  WITH dmIdentidad_Direccion.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Geo'
             +'  FROM QS_SYS_ID_DIR'
             +' WHERE Codigo_Identidad = :Codigo_Identidad'
             +'   AND Item_Dir         = :Item_Dir'
             );

      ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
      ParamByName('Item_Dir').AsFloat := fItem_Dir;
      Prepare;
      Open;

      if FieldByName('Codigo_Geo').IsNull then
         begin
           Close;
           UnPrepare;
           sString_Error := 'No se encontro dirección para '+sCodigo_Identidad;
           Result := False;
           exit;
         end;
      sUbicacion := FieldByName('Codigo_Geo').AsString;
      Close;
      UnPrepare;
    end;

  sCod_Pais := Pais_para_CodGeo(sUbicacion);
  Result := True;
end;
//==============================================================================
procedure Leer_Identidad(sCodigo_Identidad : String;
                         sJuridico_Natural : String;
                         var sRazon_Social_Pat : String;
                         var sNombre_Fanta_Mat : String;
                         var sNombres          : String;
                         var sCredencial       : String;
                         var Result            : Boolean);

begin
  sRazon_Social_Pat := '';
  sNombre_Fanta_Mat := '';
  sNombres          := '';
  sCredencial       := '';
  Result            := False;

  if (sCodigo_identidad = ' ') or
     (sCodigo_Identidad = '' ) then
     exit;

  WITH dmIdentidad_Direccion.QRY_General do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Codigo_Identidad'
             +'      ,Razon_Social_Pat'
             +'      ,Nombre_Fanta_Mat'
             +'      ,Nombres'
             +'      ,Credencial'
             +'  FROM QS_SYS_IDENTIDAD'
             +' WHERE Codigo_Identidad = :Codigo_Identidad'
             );
      if sJuridico_Natural <> ' ' then
         begin
           SQL.Add(' AND Juridico_Natural = :Juridico_Natural');
           ParamByName('Juridico_Natural').AsString := trim(sJuridico_Natural);
         end;

      ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
      Open;
      if FieldByName('Codigo_Identidad').AsString <> Trim(sCodigo_Identidad) then
      begin
        Close;
        UnPrepare;
        exit;
      end;

      sRazon_Social_Pat := FieldByName('Razon_Social_Pat').AsString;
      sNombre_Fanta_Mat := FieldByName('Nombre_Fanta_Mat').AsString;
      sNombres          := FieldByName('Nombres').AsString;
      sCredencial       := FieldByName('Credencial').AsString;
      Result            := True;
      Close;
    end;
end;

procedure Leer_Identidad_Direccion(sCodigo_Identidad : String;
                                   fItem_Dir         : Double;
                                   var sRazon_Social : String;
                                   var sDireccion    : String;
                                   var sUbicacion    : String;
                                   var Result        : Boolean);
var
  saux_Codigo_Geo,
  saux_Descr_Ubicacion : String;
begin
   sRazon_Social := '';
   sDireccion    := '';
   sUbicacion    := '';
   Result := True;
   WITH dmIdentidad_Direccion.QRY_General do
     begin
        SQL.Clear;
        SQL.Add('SELECT Razon_Social_Pat'
               +'  FROM QS_SYS_IDENTIDAD'
               +' WHERE Codigo_Identidad = :Codigo_Identidad'
               );
        ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
        Prepare;
        Open;
        if FieldByName('Razon_Social_Pat').IsNull then
           begin
             Close;
             UnPrepare;
             Result := False;
             exit;
           end;
        sRazon_Social := FieldByName('Razon_Social_Pat').AsString;
        Close;
        UnPrepare;

        SQL.Clear;
        SQL.Add('SELECT Descripcion'
               +'      ,Codigo_Geo'
               +'  FROM QS_SYS_ID_DIR'
               +' WHERE Codigo_Identidad = :Codigo_Identidad'
               +'   AND Item_Dir         = :Item_Dir'
               );
        ParamByName('Codigo_Identidad').AsString := trim(sCodigo_Identidad);
        ParamByName('Item_Dir').AsFloat          := fItem_Dir;
        Prepare;
        Open;
        if FieldByName('Descripcion').IsNull then
           begin
             Close;
             UnPrepare;
             Result := False;
             exit;
           end;

        sDireccion      := FieldByName('Descripcion').AsString;
        saux_Codigo_Geo := FieldByName('Codigo_Geo').AsString;
        Close;
        UnPrepare;

        Leer_Descripcion_Geo(saux_Codigo_Geo,
                             saux_Descr_Ubicacion,
                             Result);

        if NOT Result then
           exit;

        sUbicacion := saux_Descr_Ubicacion;
        Division_Geografica_Padre(saux_Codigo_Geo,
                                  Result);

        if NOT Result then
           exit;

        Leer_Descripcion_Geo(saux_Codigo_Geo,
                             saux_Descr_Ubicacion,
                             Result);
        if NOT Result then
           exit;
        sUbicacion := trim(sUbicacion)
                      +' - '
                      +trim(saux_Descr_Ubicacion);
     end;
end;

// Despliega ventana ayuda dirección
procedure Ayuda_Identidad_Direccion(sCodigo_Identidad : String;
                                    var fItem_dir     : Double;
                                    var sDireccion    : String;
                                    dFecha            : TDateTime;
                                    var Result        : Boolean);
begin
  Result := False;

  with dmIdentidad_Direccion.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT Item_Dir'
           +'      ,Descripcion'
           +'  FROM QS_SYS_ID_DIR'
           +' WHERE Codigo_Identidad  = :Codigo_Identidad'
           +'   AND Fecha_Desde       <= :Fecha'
           +'   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)'
           +' ORDER BY Item_Dir DESC'
           );
    ParamByName('Codigo_Identidad').AsString := sCodigo_Identidad;
    ParamByName('Fecha').AsDateTime          := dFecha;

    Open;
    dmIdentidad_Direccion.QRY_General.FetchAll;
    dmIdentidad_Direccion.FDMemTable1.Data := dmIdentidad_Direccion.QRY_General.Data;
    dmIdentidad_Direccion.FDMemTable1.First;
  end;

  dmIdentidad_Direccion.Search_Id_Dir.Caption := 'Direcciones de: '
                                                 +sCodigo_Identidad;

  dmIdentidad_Direccion.ClientDataSet1.Active := True;
  if dmIdentidad_Direccion.Search_Id_Dir.Execute then
  begin
    fItem_Dir := dmIdentidad_Direccion.ClientDataSet1Item_Dir.AsFloat;
    sDireccion := dmIdentidad_Direccion.ClientDataSet1Descripcion.AsString;
    Result := True;
  end;

  Screen.Cursor := crDefault;
  dmIdentidad_Direccion.FDMemTable1.Close;

end;


end.
