unit DM_Paises;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,  IniFiles, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmPaises = class(TDataModule)
    QRY_General: TFDQuery;
    Qry_Division_Geografica_Padre: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Nacion_Pais(sPais : String) : String;
  function Pais_Para_CodGeo(sCodGeo : String) : String;
  procedure Division_Geografica_Padre(var sCodigo_Division : String;
                                      var Result           : Boolean);

  procedure Leer_Descripcion_Geo(sCodigo_Geo      : String;
                                 var sDescripcion : String;
                                 var Result       : Boolean);

  procedure Leer_Descripcion_Pais(sCodigo_Geo      : String;
                                  var sDescripcion : String;
                                  var Result       : Boolean);

  procedure Busca_Tipo_Division_CodGeo(sTipo_Division :String;
                                   var sCodGeo        :String;
                                   var sDescGeo       :String);

  procedure Leer_Desc_Tipo_Geo(sCodigo_Geo      : String;
                               var sDescripcion : String;
                               var sTipo        : String;
                               var Result       : Boolean);

var
  dmPaises: TdmPaises;

implementation
Uses
  DM_Base_Datos;

{$R *.DFM}
procedure Division_Geografica_Padre(var sCodigo_Division : String;
                                    var Result           : Boolean);
begin
  Result := True;
  WITH dmPaises.Qry_Division_Geografica_Padre do
  begin
//      SQL.Clear;
//      SQL.Add('SELECT IN__COD_DESC_DIVIS '
//             +'  FROM QS_SYS_DESC_GEO'
//             +' WHERE COD_DESC_DIVISION = :Codigo_Division'
//             );
      ParamByName('Codigo_Division').AsString := trim(sCodigo_Division);

      Prepare;
      Open;

      if FieldByName('IN__COD_DESC_DIVIS').AsString = 'TOP' then
         Result := False
      else
         if NOT (FieldByName('IN__COD_DESC_DIVIS').IsNull) then
            sCodigo_Division := FieldByName('IN__COD_DESC_DIVIS').AsString
         else
            Result := False;

      Close;
      UnPrepare;
    end;
end;

// Pais_Para_CodGeo ... Entrega el país al que pertenece un codigo geografico
// Recorre el arbol hasta la raiz ....
function Pais_Para_CodGeo(sCodGeo : String) : String;
var
  ant_CodGeo : String;
  Buscar     : Boolean;
begin
  Buscar := True;
   While Buscar do
   begin
     ant_CodGeo := sCodGeo;
     Division_Geografica_Padre(sCodGeo
                              ,Buscar);
     if ant_CodGeo = sCodGeo then
        Buscar := False;
   end;
   Result := sCodGeo;
end;

procedure Busca_Tipo_Division_CodGeo(sTipo_Division :String;
                                 var sCodGeo        :String;
                                 var sDescGeo       :String);
var ant_CodGeo      : String;
    sDescripcionGeo : String;
    sTipoGeo        : String;
    bResult         : Boolean;
    Buscar          : Boolean;
begin
  Buscar := True;
  While Buscar do
  begin
     Leer_Desc_Tipo_Geo(sCodGeo
                       ,sDescripcionGeo
                       ,sTipoGeo
                       ,bResult);
     if (sTipoGeo = sTipo_Division) then
     begin
        Buscar := False;
        Continue;
     end;

     ant_CodGeo := sCodGeo;
     Division_Geografica_Padre(sCodGeo
                              ,Buscar);
     if ant_CodGeo = sCodGeo  then
        Buscar := False;
  end;
  sDescGeo := sDescripcionGeo;
end;

procedure Leer_Desc_Tipo_Geo(sCodigo_Geo      : String;
                             var sDescripcion : String;
                             var sTipo        : String;
                             var Result       : Boolean);
begin
  Result       := True;
  sDescripcion := '';
  sTipo        := '';

  WITH dmPaises.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Descripcion, Tipo_Division'
             +'  FROM QS_SYS_DESC_GEO'
             +' WHERE Cod_Desc_Division = :Cod_Desc_Division'
             );
      ParamByName('Cod_Desc_Division').AsString := sCodigo_Geo;
      Prepare;
      Open;
      if FieldByName('Descripcion').IsNull then
         Result := False
      else
      begin
         sDescripcion := FieldByName('Descripcion').AsString;
         sTipo        := FieldByName('Tipo_Division').AsString;
      end;

      Close;
      UnPrepare;
    end;
end;

procedure Leer_Descripcion_Geo(sCodigo_Geo      : String;
                               var sDescripcion : String;
                               var Result       : Boolean);
begin
  Result := True;
  sDescripcion := '';

  WITH dmPaises.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Descripcion'
             +'  FROM QS_SYS_DESC_GEO'
             +' WHERE Cod_Desc_Division = :Cod_Desc_Division'
             );
      ParamByName('Cod_Desc_Division').AsString := sCodigo_Geo;
      Prepare;
      Open;
      if FieldByName('Descripcion').IsNull then
         Result := False
      else
         sDescripcion := FieldByName('Descripcion').AsString;

      Close;
      UnPrepare;
    end;
end;

procedure Leer_Descripcion_Pais(sCodigo_Geo      : String;
                               var sDescripcion : String;
                               var Result       : Boolean);
begin
  Result := True;
  sDescripcion := '';

  WITH dmPaises.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT DESC_PAIS '
             +'  FROM QS_SYS_PAIS'
             +' WHERE COD_PAIS  = :sCodigo_Geo'
             );
      ParamByName('sCodigo_Geo').AsString := sCodigo_Geo;
      Prepare;
      Open;
      if FieldByName('DESC_PAIS').IsNull then
         Result := False
      else
         sDescripcion := FieldByName('DESC_PAIS').AsString;

      Close;
      UnPrepare;
    end;
end;

function Nacion_Pais(sPais : String) : String;
begin
    Nacion_Pais := '';
    WITH dmPaises.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Nacion_Pais'
             +'  FROM QS_SYS_PAIS'
             +' WHERE Cod_Pais = :Cod_Pais'
             );
      ParamByName('Cod_Pais').AsString := sPais;
      Open;
      
      if FieldByName('Nacion_Pais').IsNull then
         Result := ''
      else
         Result := FieldByName('Nacion_Pais').AsString;

      Close;
    end;
end;
end.