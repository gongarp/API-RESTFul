unit DM_Ayuda_Nemotecnicos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, wwidlg, Wwintl,DM_Variables_Menu, DM_Comun, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, vcl.wwDialog, FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, Datasnap.DBClient,
  Datasnap.Provider;

type
  TdmAyuda_Nemotecnicos = class(TDataModule)
    Search_Nemotecnico: TwwSearchDialog;
    wwIntl2: TwwIntl;
    Search_Nemotecnico_Ahorro: TwwSearchDialog;
    Search_Nemotecnico_Vig: TwwSearchDialog;
    //BatchMove1: TBatchMove;
    QRY_General: TFDQuery;
    T_Nemotecnico: TFDTable;
    FDMemTable1: TFDMemTable;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    T_NemotecnicoCODIGO_IDENTIDAD: TStringField;
    T_NemotecnicoCODIGO_INSTRUMENTO: TStringField;
    T_NemotecnicoSERIE: TStringField;
    T_NemotecnicoCODIGO_NEMOTECNICO: TStringField;
    T_NemotecnicoTASA_ORIGINAL: TFloatField;
    T_NemotecnicoCUPONES_CORTADOS: TFloatField;
    T_NemotecnicoEMISION_IMPLICITA: TStringField;
    ClientDataSet2: TClientDataSet;
    DataSetProvider2: TDataSetProvider;
    ClientDataSet2CODIGO_IDENTIDAD: TStringField;
    ClientDataSet2CODIGO_INSTRUMENTO: TStringField;
    ClientDataSet2SERIE: TStringField;
    ClientDataSet2CODIGO_NEMOTECNICO: TStringField;
    T_Nemotecnico_Vig: TFDTable;
    ClientDataSet3: TClientDataSet;
    DataSetProvider3: TDataSetProvider;
    T_Nemotecnico_Ahorro: TFDTable;
    ClientDataSet4: TClientDataSet;
    DataSetProvider4: TDataSetProvider;
    T_Nemotecnico_AhorroNEMOTECNICO: TStringField;
    T_Nemotecnico_AhorroDESCRIPCION: TStringField;
    T_Nemotecnico_AhorroEMISOR: TStringField;
    T_Nemotecnico_AhorroINSTRUMENTO: TStringField;
    T_Nemotecnico_AhorroSERIE: TStringField;
    T_Nemotecnico_AhorroMONEDA: TStringField;
    ClientDataSet4NEMOTECNICO: TStringField;
    ClientDataSet4DESCRIPCION: TStringField;
    ClientDataSet4EMISOR: TStringField;
    ClientDataSet4INSTRUMENTO: TStringField;
    ClientDataSet4SERIE: TStringField;
    ClientDataSet4MONEDA: TStringField;
    ClientDataSet3CODIGO_IDENTIDAD: TStringField;
    ClientDataSet3CODIGO_INSTRUMENTO: TStringField;
    ClientDataSet3SERIE: TStringField;
    ClientDataSet3CODIGO_NEMOTECNICO: TStringField;
    ClientDataSet3TASA_ORIGINAL: TFloatField;
    ClientDataSet3CUPONES_CORTADOS: TFloatField;
    ClientDataSet3EMISION_IMPLICITA: TStringField;
    T_NemotecnicoFECHA_EMISION: TDateTimeField;
    T_NemotecnicoFECHA_VENCIMIENTO: TDateTimeField;
    ClientDataSet1CODIGO_IDENTIDAD: TStringField;
    ClientDataSet1CODIGO_INSTRUMENTO: TStringField;
    ClientDataSet1SERIE: TStringField;
    ClientDataSet1CODIGO_NEMOTECNICO: TStringField;
    ClientDataSet1FECHA_EMISION: TDateTimeField;
    ClientDataSet1FECHA_VENCIMIENTO: TDateTimeField;
    ClientDataSet1TASA_ORIGINAL: TFloatField;
    ClientDataSet1CUPONES_CORTADOS: TFloatField;
    ClientDataSet1EMISION_IMPLICITA: TStringField;
    FDMemTable2: TFDMemTable;
    T_Nemotecnico_AhorroFECHA_HASTA: TDateTimeField;
    T_Nemotecnico_AhorroFECHA_DESDE: TDateTimeField;
    T_Nemotecnico_AhorroFECHA_HORA: TDateTimeField;
    ClientDataSet4FECHA_HORA: TDateTimeField;
    ClientDataSet4FECHA_HASTA: TDateTimeField;
    ClientDataSet4FECHA_DESDE: TDateTimeField;
    ClientDataSet3FECHA_VENCIMIENTO: TDateTimeField;
    ClientDataSet3FECHA_EMISION: TDateTimeField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure Leer_Nemotecnico(sNemotecnico,
                             sNemotecnicoEmisor : String;
                             var dFecha_Emision : TDatetime;
                             var sEmisor        : String;
                             var sInstrumento   : String;
                             var sSerie         : String;
                             var Result         : Boolean);

  procedure Leer_Nemotecnico_Emision_Implicita(sNemotecnico,
                             sNemotecnicoEmisor : String;
                             var dFecha_Emision : TDatetime;
                             var sEmisor        : String;
                             var sInstrumento   : String;
                             var sSerie         : String;
                             var sEmision_Implicita : String;
                             var Result         : Boolean);

  procedure Leer_Nemotecnico_Emision_Implicita_Vig(sNemotecnico,
                             sNemotecnicoEmisor : String;
                             var dFecha_Emision : TDatetime;
                             var sEmisor        : String;
                             var sInstrumento   : String;
                             var sSerie         : String;
                             var dFecha_Vig     : TDatetime;
                             var sEmision_Implicita : String;
                             var Result         : Boolean);


  procedure Leer_Nemotecnico_Emision_Vcto(sNemotecnico       : String;
                                          var dFecha_Emision : TDatetime;
                                          var dFecha_Vcto    : TDatetime;
                                          var Result         : Boolean);

  procedure Leer_Nemotecnico_Emision_Vcto_vig ( sNemotecnico       : String;
                                                dFecha_Proceso     : TDatetime;
                                                var sEmisor        : String;
                                                var sInstrumento   : String;
                                                var sSerie         : String;
                                                var dFecha_Emision : TDatetime;
                                                var dFecha_Vcto    : TDatetime;
                                                var sEmision_Implicita : String;
                                                var sModulo_Err        : String;
                                                var sString_Err        : String;
                                                var Result             : Boolean);


  // Solo Renta fija (Con descriptor)
  procedure Ayuda_Nemotecnico(var sNemotecnico : String;
                              sEmisor          : String;
                              var Result       : Boolean);

  procedure Ayuda_Nemotecnico_Trans(var sNemotecnico : String;
                                    sEmisor          : String;
                                    dFecha           : TDateTime;
                                    var Result       : Boolean);

  procedure Ayuda_Nemotecnico_Vig(var sNemotecnico : String;
                                  sEmisor          : String;
                                  var Result       : Boolean);


  procedure Ayuda_Nemotecnico_Ahorro(var sNemotecnico : String;
                                     var sEmisor      : String;
                                     var sInstrumento : String;
                                     var sSerie       : String;
                                     var sMoneda      : String;
                                     var dFechaDesde  : TDateTime;
                                     var Result       : Boolean);

  function Existe_Nemotecnico(sNemotecnico,
                              sNemotecnicoEmisor : String): Boolean;

  function Existe_Nemotecnico_RV(sNemotecnico,
                                 sNemotecnicoEmisor : String): Boolean;

// Incluye Nemotecnicos Con descriptor, Sin descriptor (RF y RV), mas los definidos en operaciones
  procedure Ayuda_Nemotecnico2(var sNemotecnico : String;
                               sEmisor          : String;
                               var Result       : Boolean);

  // Solo Renta fija (Sin descriptor definidos en las OMD'd)
  procedure Ayuda_Nemotecnico3(var sNemotecnico : String;
                               sEmisor          : String;
                               var Result       : Boolean);

  // Incluye Nemotecnicos definidos en operaciones y renta variable
  procedure Ayuda_Nemotecnico4(var sNemotecnico : String;
                               sEmisor          : String;
                               var Result       : Boolean);

  // Incluye SOLO RF (Con Descriptor mas de Operaciones de instrimentos Unicos
  procedure Ayuda_Nemotecnico5(var sNemotecnico : String;
                               sEmisor          : String;
                               var Result       : Boolean);




  // Trae solo los nemotecnicos del instrumento pasado como parametro
  procedure Ayuda_Nemotecnico_Instrumento(var sNemotecnico   : String;
                                          var sEmisor        : String;
                                          var sInstrumento   : String;
                                          var Result         : Boolean);

  // Trae solo los nemotecnicos de la serie  como parametro
  procedure Ayuda_Nemotecnico_Serie(var sNemotecnico   : String;
                                        sEmisor        : String;
                                        sSerie         : String;
                                    var Result         : Boolean);


var
  dmAyuda_Nemotecnicos: TdmAyuda_Nemotecnicos;

implementation
Uses
   DM_Base_Datos;

{$R *.DFM}
{Verifica si existe}
procedure Leer_Nemotecnico(sNemotecnico,
                           sNemotecnicoEmisor : String;
                           var dFecha_Emision : TDatetime;
                           var sEmisor        : String;
                           var sInstrumento   : String;
                           var sSerie         : String;
                           var Result         : Boolean);
begin

  if (sNemotecnico = ' ') or
     (sNemotecnico = '')  then
     begin
       Result := False;
       exit;
     end;
  with dmAyuda_Nemotecnicos.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Identidad'
             +'      ,Codigo_Instrumento'
             +'      ,Serie'
             +'      ,Fecha_Emision'
             +'  FROM QS_FIN_NEM_RFIJA'
             +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
             );

      ParamByName('Codigo_Nemotecnico').AsString := trim(sNemotecnico);

      if Trim(sNemotecnicoEmisor) <> '' then
      begin
        SQL.Add(' AND Codigo_Identidad = :Codigo_Identidad');
        ParamByName('Codigo_Identidad').AsString :=
                                              trim(sNemotecnicoEmisor);
      end;
      Open;

      if FieldByName('Codigo_Identidad').IsNull then
         Result := False
      else
         begin
           sEmisor      := FieldByName('Codigo_Identidad').AsString;
           sInstrumento := FieldByName('Codigo_Instrumento').AsString;
           sSerie       := FieldByName('Serie').AsString;
           dFecha_Emision := FieldByName('Fecha_Emision').AsDatetime;
           Result := True;
         end;
      Close;
      UnPrepare;
    end;
end;

{Despliega ventana ayuda}
procedure Ayuda_Nemotecnico(var sNemotecnico : String;
                            sEmisor          : String;
                            var Result       : Boolean);
var sNombre_Tabla : String;
begin
  Result         := False;

  sNombre_Tabla := 'QS_FIN_NEM_RFIJA';
  if sDriver = 'MSSQL' then
  begin
    pone_owner_MSSQL(sNombre_Tabla
                    ,Result);
    if NOT Result then
    begin
      Application.MessageBox(pchar('Error en definicion de tabla '+sNombre_Tabla)
                            ,'Sistema'
                            , mb_OK);
      Exit;
    end;
  end;

  dmAyuda_Nemotecnicos.ClientDataSet1.Active := False;
  //dmAyuda_Nemotecnicos.T_Nemotecnico.TableName := Trim(sNombre_Tabla);

//  dmAyuda_Nemotecnicos.T_Nemotecnico.Close;
//  dmAyuda_Nemotecnicos.T_Nemotecnico.Fields.Clear;
//  dmAyuda_Nemotecnicos.T_Nemotecnico.FieldDefs.Clear;
//  dmAyuda_Nemotecnicos.T_Nemotecnico.Prepare;
//  dmAyuda_Nemotecnicos.T_Nemotecnico.CreateDataSet;

   with dmAyuda_Nemotecnicos.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT a.Codigo_Nemotecnico');
      SQL.Add('      ,a.Codigo_Identidad');
      SQL.Add('      ,a.Codigo_Instrumento');
      SQL.Add('      ,a.Serie');
      SQL.Add('      ,a.FECHA_EMISION');
      SQL.Add('      ,a.FECHA_VENCIMIENTO');
      SQL.Add('      ,a.TASA_ORIGINAL');
      SQL.Add('      ,a.CUPONES_CORTADOS');
      SQL.Add('      ,a.EMISION_IMPLICITA');
      SQL.Add('  FROM QS_FIN_NEM_RFIJA a');
      SQL.Add(' ORDER BY a.Codigo_Nemotecnico');

      Open;
      dmAyuda_Nemotecnicos.QRY_General.FetchAll;
      dmAyuda_Nemotecnicos.FDMemTable2.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
      dmAyuda_Nemotecnicos.FDMemTable2.First;
   end;


//  dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet1;
  //ggarcia 26-02-2019 se activa nuevamente ya que la ayuda Ayuda_Nemotecnico_Trans cambia el clientdataset a este mismo componente
  dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet1;
  dmAyuda_Nemotecnicos.ClientDataSet1.Active := True;

  try
     if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
     begin
        sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet1.FieldByName('Codigo_Nemotecnico').AsString;
        Result := True;
     end
     else
        Result := False;
  except
  end;
  Screen.Cursor := crDefault;
  dmAyuda_Nemotecnicos.T_Nemotecnico.Close;
  dmAyuda_Nemotecnicos.FDMemTable2.Close;
end;


procedure Ayuda_Nemotecnico_Trans(var sNemotecnico : String;
                                  sEmisor          : String;
                                  dFecha           : TDateTime;
                                  var Result       : Boolean);
begin
   Result         := False;

   dmAyuda_Nemotecnicos.FDMemTable1.Close;
   dmAyuda_Nemotecnicos.QRY_General.Close;
   with dmAyuda_Nemotecnicos.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT a.Codigo_Nemotecnico');
      SQL.Add('      ,a.Codigo_Identidad');
      SQL.Add('      ,a.Codigo_Instrumento');
      SQL.Add('      ,a.Serie');
      SQL.Add('  FROM QS_FIN_NEM_RFIJA a');
      SQL.Add(' WHERE (Fecha_Vencimiento >= :Fecha OR Fecha_Vencimiento is null) ');
      if (sEmisor <> ' ') and
         (sEmisor <> '')  then
      begin
        SQL.Add(' AND a.Codigo_Identidad = :Codigo_Identidad');
        ParamByName('Codigo_Identidad').AsString := sEmisor;
        dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
      end
      else
         dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';
      SQL.Add(' order by Codigo_Nemotecnico');
      ParamByName('Fecha').AsDate := dFecha;

      Open;
      dmAyuda_Nemotecnicos.QRY_General.FetchAll;
      dmAyuda_Nemotecnicos.FDMemTable1.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
      dmAyuda_Nemotecnicos.FDMemTable1.First;
   end;

   with dmAyuda_Nemotecnicos.FDMemTable1 do
   begin
      IndexFieldNames := 'Codigo_Nemotecnico';
      SetKey;
      FieldByName('Codigo_Nemotecnico').AsString  := sNemotecnico;
      if NOT GotoKey then
         First;
   end;

   dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet2;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := True;

   if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
   begin
      sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet2Codigo_Nemotecnico.AsString;
      Result := True;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Nemotecnicos.FDMemTable1.Close;
//   dmAyuda_Nemotecnicos.FDMemTable1.Delete;

end;


{Despliega ventana ayuda}
procedure Ayuda_Nemotecnico_Vig(var sNemotecnico : String;
                                sEmisor          : String;
                                var Result       : Boolean);
var sNombre_Tabla : String;
begin
  Result         := False;

  dmAyuda_Nemotecnicos.T_Nemotecnico_Vig.Close;
  if sDriver = 'MSSQL' then
  begin
    pone_owner_MSSQL(sNombre_Tabla
                    ,Result);
    if NOT Result then
    begin
      Application.MessageBox(pchar('Error en definicion de tabla '+sNombre_Tabla)
                            ,'Sistema'
                            , mb_OK);
      Exit;
    end;
  end;
  dmAyuda_Nemotecnicos.T_Nemotecnico_Vig.TableName := Trim(sNombre_Tabla);
  dmAyuda_Nemotecnicos.T_Nemotecnico_Vig.Open;
  dmAyuda_Nemotecnicos.ClientDataSet3.Active := True;

  try
     if dmAyuda_Nemotecnicos.Search_Nemotecnico_vig.Execute then
     begin
        sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet3Codigo_Nemotecnico.AsString;
        Result := True;
     end
     else
        Result := False;
  except
  end;
  Screen.Cursor := crDefault;
  dmAyuda_Nemotecnicos.T_Nemotecnico_Vig.Close;
end;


procedure Ayuda_Nemotecnico_Ahorro(var sNemotecnico : String;
                                   var sEmisor      : String;
                                   var sInstrumento : String;
                                   var sSerie       : String;
                                   var sMoneda      : String;
                                   var dFechaDesde  : TDateTime;
                                   var Result       : Boolean);

var sNombre_Tabla : String;
begin
  Result         := False;

  sNombre_Tabla := 'QS_FIN_DESCR_AHORRO';
  if sDriver = 'MSSQL' then
  begin
    pone_owner_MSSQL(sNombre_Tabla
                    ,Result);
    if NOT Result then
    begin
      Application.MessageBox(pchar('Error en definicion de tabla '+sNombre_Tabla)
                            ,'Sistema'
                            , mb_OK);
      Exit;
    end;
  end;
  dmAyuda_Nemotecnicos.T_Nemotecnico_Ahorro.TableName := Trim(sNombre_Tabla);
  dmAyuda_Nemotecnicos.T_Nemotecnico_Ahorro.Open;

  dmAyuda_Nemotecnicos.ClientDataSet4.Active := True;

  try
     if dmAyuda_Nemotecnicos.Search_Nemotecnico_Ahorro.Execute then
     begin
        sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet4nemotecnico.AsString;
        sEmisor      := dmAyuda_Nemotecnicos.ClientDataSet4emisor.AsString;
        sInstrumento := dmAyuda_Nemotecnicos.ClientDataSet4Instrumento.AsString;
        sSerie       := dmAyuda_Nemotecnicos.ClientDataSet4Serie.AsString;
        sMoneda      := dmAyuda_Nemotecnicos.ClientDataSet4Moneda.AsString;
        dFechaDesde  := dmAyuda_Nemotecnicos.ClientDataSet4Fecha_Desde.AsDateTime;
        Result := True;
     end
     else
        Result := False;
  except
  end;
  Screen.Cursor := crDefault;
  dmAyuda_Nemotecnicos.T_Nemotecnico_Ahorro.Close;
end;
//------------------------------------------------------------------------------
procedure Leer_Nemotecnico_Emision_Vcto(sNemotecnico       : String;
                                        var dFecha_Emision : TDatetime;
                                        var dFecha_Vcto    : TDatetime;
                                        var Result         : Boolean);
begin

  if (sNemotecnico = ' ') or
     (sNemotecnico = '')  then
     begin
       Result := False;
       exit;
     end;

  with dmAyuda_Nemotecnicos.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Fecha_Emision'
             +'      ,Fecha_Vencimiento'
             +'      ,Codigo_Identidad'
             +'  FROM QS_FIN_NEM_RFIJA'
             +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
             );

      ParamByName('Codigo_Nemotecnico').AsString := trim(sNemotecnico);
      Prepare;
      Open;

      if FieldByName('Codigo_Identidad').IsNull then
         Result := False
      else
         begin
           dFecha_Emision := FieldByName('Fecha_Emision').AsDatetime;
           dFecha_Vcto    := FieldByName('Fecha_Vencimiento').AsDatetime;
           Result := True;
         end;
      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
procedure Leer_Nemotecnico_Emision_Vcto_vig ( sNemotecnico       : String;
                                              dFecha_Proceso     : TDatetime;
                                              var sEmisor        : String;
                                              var sInstrumento   : String;
                                              var sSerie         : String;
                                              var dFecha_Emision : TDatetime;
                                              var dFecha_Vcto    : TDatetime;
                                              var sEmision_Implicita : String;
                                              var sModulo_Err        : String;
                                              var sString_Err        : String;
                                              var Result             : Boolean);
begin
  sModulo_Err := 'Leer Nemotécnico Emisión Vcto Vigente';

  if (sNemotecnico = ' ') or
     (sNemotecnico = '')  then
     begin
       sString_Err := 'Nemotécnico en blanco';
       Result := False;
       exit;
     end;

  with dmAyuda_Nemotecnicos.QRY_General do
    begin
      SQL.Clear;
      SQL.Add( 'SELECT a.CODIGO_IDENTIDAD   As Emisor  '
              +'      ,a.CODIGO_INSTRUMENTO As Instrumento '
              +'      ,a.SERIE                             '
              +'      ,a.FECHA_EMISION                     '
              +'      ,a.FECHA_VENCIMIENTO                 '
              +'      ,a.EMISION_IMPLICITA                 '
              +'  FROM QS_FIN_NEM_RFIJA a'
              +' WHERE a.Codigo_Nemotecnico = :Codigo_Nemotecnico '
              +'   AND a.Fecha_Vig IN (SELECT MAX(b.Fecha_Vig)     '
              +'                         FROM QS_FIN_NEM_RFIJA b '
              +'                        WHERE b.Codigo_Nemotecnico = a.Codigo_Nemotecnico  '
              +'                          AND Fecha_Vig <= :Fecha_proceso                  '
              +'                       )                                                   '
             );

      ParamByName('Codigo_Nemotecnico').AsString   := trim(sNemotecnico);
      ParamByName('Fecha_proceso'     ).AsdateTime := dFecha_Proceso;
      Prepare;
      Open;

      if FieldByName('Emisor').IsNull then
      begin
         sString_Err := 'No se encontro código nemotécnico: '''+sNemotecnico+'''';
         Result := False;
      end
      else
         begin
           dFecha_Emision := FieldByName('Fecha_Emision').AsDatetime;
           dFecha_Vcto    := FieldByName('Fecha_Vencimiento').AsDatetime;
           sEmisor        := FieldByName('Emisor').AsString;
           sInstrumento   := FieldByName('Instrumento').AsString;
           sSerie         := FieldByName('Serie').AsString;
           sEmision_Implicita := FieldByName('EMISION_IMPLICITA').AsString;
           Result := True;
         end;
      Close;
      UnPrepare;
    end;
end;
//------------------------------------------------------------------------------
function Existe_Nemotecnico(sNemotecnico,
                            sNemotecnicoEmisor : String): Boolean;
begin

  if (sNemotecnico = ' ') or
     (sNemotecnico = '')  then
     begin
       Result := False;
       exit;
     end;

  with dmAyuda_Nemotecnicos.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Codigo_Nemotecnico');
      SQL.Add('  FROM QS_FIN_NEM_RFIJA a');
      SQL.Add(' WHERE a.Codigo_Nemotecnico = :Codigo_Nemotecnico');

      ParamByName('Codigo_Nemotecnico').AsString := trim(sNemotecnico);

      if sNemotecnicoEmisor <> ' ' then
         begin
           SQL.Add(' AND Codigo_Identidad = :Codigo_Identidad');
           ParamByName('Codigo_Identidad').AsString :=
                                                 trim(sNemotecnicoEmisor);
         end;

      SQL.Add(' UNION ');
      SQL.Add('SELECT a.Nemotecnico As Codigo_Nemotenico');
      SQL.Add('  FROM QS_Tra_Omd_Det_Rf a');
      SQL.Add(' WHERE a.Nemotecnico = :Nemotecnico');

      ParamByName('Nemotecnico').AsString := trim(sNemotecnico);

      if sNemotecnicoEmisor <> ' ' then
         begin
           SQL.Add(' AND Emisor = :Codigo_Identidad');
           ParamByName('Codigo_Identidad').AsString :=
                                                 trim(sNemotecnicoEmisor);
         end;
      Prepare;
      Open;

      if FieldByName('Codigo_Nemotecnico').IsNull then
         Result := False
      else
         Result := True;
      Close;
      UnPrepare;
    end;
end;

function Existe_Nemotecnico_RV(sNemotecnico,
                               sNemotecnicoEmisor : String): Boolean;
begin

  if (sNemotecnico = ' ') or
     (sNemotecnico = '')  then
     begin
       Result := False;
       exit;
     end;

  with dmAyuda_Nemotecnicos.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Codigo_Nemotecnico');
      SQL.Add('  FROM QS_FIN_NEM_RVARI a');
      SQL.Add(' WHERE a.Codigo_Nemotecnico = :Codigo_Nemotecnico');
      ParamByName('Codigo_Nemotecnico').AsString := trim(sNemotecnico);
      if (sNemotecnicoEmisor <> ' ') and (sNemotecnicoEmisor <> '') then
      begin
        SQL.Add(' AND Codigo_Identidad = :Codigo_Identidad');
        ParamByName('Codigo_Identidad').AsString := trim(sNemotecnicoEmisor);
      end;
      Prepare;
      Open;

      if FieldByName('Codigo_Nemotecnico').IsNull then
         Result := False
      else
         Result := True;

      Close;
      UnPrepare;
    end;
end;

// Incluye Nemotecnicos Con descriptor, Sin descriptor (RF y RV), mas los definidos en operaciones
procedure Ayuda_Nemotecnico2(var sNemotecnico : String;
                             sEmisor          : String;
                             var Result       : Boolean);

begin
 Result         := False;

  //dmAyuda_Nemotecnicos.FDMemTable1.Close;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := False;

  with dmAyuda_Nemotecnicos.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA a');

    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    SQL.Add(' UNION ');
    SQL.Add(' SELECT DISTINCT a.Nemotecnico  as Codigo_Nemotecnico');
    SQL.Add('                ,a.Emisor       as Codigo_Identidad');
    SQL.Add('                ,a.Instrumento  as Codigo_Instrumento');
    SQL.Add('                ,a.Serie');
    SQL.Add('  FROM QS_TRA_OMD_DET_RF a'
           +'  WHERE a.Tipo_Instrum <> ''S'''
           +'    AND a.Tipo_Instrum <> ''R'''
           +'    AND NOT EXISTS (SELECT x.Codigo_Nemotecnico'
           +'                      FROM QS_FIN_NEM_RVARI x'
           +'                     WHERE x.Codigo_Nemotecnico = a.Nemotecnico)'
           );
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
        SQL.Add('  AND a.Emisor = :Emisor');
        ParamByName('Emisor').AsString := sEmisor;
    end;

    SQL.Add(' UNION ');                      // Por alguna razon alguien tenia comentado el Union con los nemotecnicos de RV
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');  // Esto fue descomentado ya que estaba afectando a la definición de los Enlaces
    SQL.Add('      ,a.Codigo_Identidad');    // por nemotecnico !!!! F.I. 07-11-2005
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE a.Serie IS NOT NULL ');
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      //SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      //ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';
    SQL.Add(' UNION ');
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,'''' as Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE a.Serie IS NULL ');
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    Open;

    dmAyuda_Nemotecnicos.QRY_General.FetchAll;
    dmAyuda_Nemotecnicos.FDMemTable1.CopyDataSet(dmAyuda_Nemotecnicos.QRY_General,[coStructure,coRestart,coAppend]);
    //dmAyuda_Nemotecnicos.FDMemTable1.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
    dmAyuda_Nemotecnicos.FDMemTable1.First;
  end;

   with dmAyuda_Nemotecnicos.FDMemTable1 do
   begin
      IndexFieldNames := 'Codigo_Nemotecnico';
      SetKey;
      FieldByName('Codigo_Nemotecnico').AsString  := sNemotecnico;
      if NOT GotoKey then
         First;
   end;

   dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet2;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := True;

   if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
   begin
      sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet2Codigo_Nemotecnico.AsString;
      Result := True;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Nemotecnicos.FDMemTable1.Close;

end;
//------------------------------------------------------------------------------
// Solo Renta fija (Sin descriptor definidos en las OMD'd)
procedure Ayuda_Nemotecnico3(var sNemotecnico : String;
                             sEmisor          : String;
                             var Result       : Boolean);

begin
 Result         := False;

  with dmAyuda_Nemotecnicos.QRY_General do
  begin
    SQL.Clear;
    SQL.Add(' SELECT DISTINCT a.Nemotecnico  as Codigo_Nemotecnico');
    SQL.Add('                ,a.Emisor       as Codigo_Identidad');
    SQL.Add('                ,a.Instrumento  as Codigo_Instrumento');
    SQL.Add('                ,a.Serie');
    SQL.Add('  FROM QS_TRA_OMD_DET_RF a'
           +'  WHERE a.Tipo_Instrum <> ''S'''
           +'    AND a.Tipo_Instrum <> ''R'''
           );
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
        SQL.Add('  AND a.Emisor = :Emisor');
        ParamByName('Emisor').AsString := sEmisor;
    end;

    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    Open;

    dmAyuda_Nemotecnicos.QRY_General.FetchAll;
    dmAyuda_Nemotecnicos.FDMemTable1.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
    dmAyuda_Nemotecnicos.FDMemTable1.First;
  end;

   with dmAyuda_Nemotecnicos.FDMemTable1 do
   begin
      IndexFieldNames := 'Codigo_Nemotecnico';
      SetKey;
      FieldByName('Codigo_Nemotecnico').AsString  := sNemotecnico;
      if NOT GotoKey then
         First;
   end;

   dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet2;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := True;

   if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
   begin
      sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet2Codigo_Nemotecnico.AsString;
      Result := True;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Nemotecnicos.FDMemTable1.Close;
 //  dmAyuda_Nemotecnicos.FDMemTable1.Delete;

end;

//------------------------------------------------------------------------------
// Incluye Nemotecnicos definidos en Operaciones y Renta Variable
procedure Ayuda_Nemotecnico4(var sNemotecnico : String;
                             sEmisor          : String;
                             var Result       : Boolean);

begin
 Result         := False;

  with dmAyuda_Nemotecnicos.QRY_General do
  begin
    SQL.Clear;
    SQL.Add(' SELECT DISTINCT a.Nemotecnico  as Codigo_Nemotecnico');
    SQL.Add('                ,a.Emisor       as Codigo_Identidad');
    SQL.Add('                ,a.Instrumento  as Codigo_Instrumento');
    SQL.Add('                ,a.Serie');
    SQL.Add('  FROM QS_TRA_OMD_DET_RF a'
           +'  WHERE a.Tipo_Instrum <> ''S'''
           +'    AND a.Tipo_Instrum <> ''R'''
           +'    AND a.Tipo_Instrum <> ''B'''
           +'    AND rtrim(a.Nemotecnico) <> '' '''
           );
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
        SQL.Add('  AND a.Emisor = :Emisor');
        ParamByName('Emisor').AsString := sEmisor;
    end;
    SQL.Add(' UNION ');                      // Por alguna razon alguien tenia comentado el Union con los nemotecnicos de RV
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');  // Esto fue descomentado ya que estaba afectando a la definición de los Enlaces
    SQL.Add('      ,a.Codigo_Identidad');    // por nemotecnico !!!! F.I. 07-11-2005
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE rtrim(a.Serie) = '' '' ');
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      //SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      //ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';
    SQL.Add(' UNION ');
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,'''' as Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE a.Serie IS NULL ');
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';
    SQL.Add(' UNION ');
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie as Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE (a.Serie IS NOT NULL AND rtrim(a.serie) <> '' '') ');
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    Open;
    dmAyuda_Nemotecnicos.QRY_General.FetchAll;
    dmAyuda_Nemotecnicos.FDMemTable1.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
    dmAyuda_Nemotecnicos.FDMemTable1.First;
  end;

   with dmAyuda_Nemotecnicos.FDMemTable1 do
   begin
      IndexFieldNames := 'Codigo_Nemotecnico';
      SetKey;
      FieldByName('Codigo_Nemotecnico').AsString  := sNemotecnico;
      if NOT GotoKey then
         First;
   end;

   dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet2;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := True;

   if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
   begin
      sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet2Codigo_Nemotecnico.AsString;
      Result := True;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Nemotecnicos.FDMemTable1.Close;
 //  dmAyuda_Nemotecnicos.FDMemTable1.Delete;

end;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// Incluye SOLO RF (Con Descriptor mas de Operaciones de instrimentos Unicos
procedure Ayuda_Nemotecnico5(var sNemotecnico : String;
                             sEmisor          : String;
                             var Result       : Boolean);

begin
 Result         := False;

  with dmAyuda_Nemotecnicos.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA a');

    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    SQL.Add(' UNION ');
    SQL.Add(' SELECT DISTINCT a.Nemotecnico  as Codigo_Nemotecnico');
    SQL.Add('                ,a.Emisor       as Codigo_Identidad');
    SQL.Add('                ,a.Instrumento  as Codigo_Instrumento');
    SQL.Add('                ,a.Serie');
    SQL.Add('  FROM QS_TRA_OMD_DET_RF a'
           +'  WHERE a.Tipo_Instrum <> ''S'''
           +'    AND a.Tipo_Instrum <> ''R'''
           +'    AND NOT EXISTS (SELECT x.Codigo_Nemotecnico'
           +'                      FROM QS_FIN_NEM_RVARI x'
           +'                     WHERE x.Codigo_Nemotecnico = a.Nemotecnico)'
           );
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
        SQL.Add('  AND a.Emisor = :Emisor');
        ParamByName('Emisor').AsString := sEmisor;
    end;
    // Ayuda_Nemotecnico5 es SOLO PARA RENTA FIJA !!!!!
    // NO VOLVER A PONER LOS NEMOS DE RV
    {
    SQL.Add(' UNION ');                      // Por alguna razon alguien tenia comentado el Union con los nemotecnicos de RV
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');  // Esto fue descomentado ya que estaba afectando a la definición de los Enlaces
    SQL.Add('      ,a.Codigo_Identidad');    // por nemotecnico !!!! F.I. 07-11-2005
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE a.Serie = '''' ');


    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      //SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      //ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    SQL.Add(' UNION ');
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,'''' as Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE a.Serie IS NULL ');
    }
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    Open;

    dmAyuda_Nemotecnicos.QRY_General.FetchAll;
    dmAyuda_Nemotecnicos.FDMemTable1.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
    dmAyuda_Nemotecnicos.FDMemTable1.First;
  end;

   with dmAyuda_Nemotecnicos.FDMemTable1 do
   begin
      IndexFieldNames := 'Codigo_Nemotecnico';
      SetKey;
      FieldByName('Codigo_Nemotecnico').AsString  := sNemotecnico;
      if NOT GotoKey then
         First;
   end;

   dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet2;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := True;

   if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
   begin
      sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet2Codigo_Nemotecnico.AsString;
      Result := True;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Nemotecnicos.FDMemTable1.Close;
  // dmAyuda_Nemotecnicos.FDMemTable1.Delete;

end;
//------------------------------------------------------------------------------
procedure Leer_Nemotecnico_Emision_Implicita(sNemotecnico,
                           sNemotecnicoEmisor : String;
                           var dFecha_Emision : TDatetime;
                           var sEmisor        : String;
                           var sInstrumento   : String;
                           var sSerie         : String;
                           var sEmision_Implicita : String;
                           var Result         : Boolean);
begin
  if (sNemotecnico = ' ') or
     (sNemotecnico = '')  then
     begin
       Result := False;
       exit;
     end;
    with dmAyuda_Nemotecnicos.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Identidad'
             +'      ,Codigo_Instrumento'
             +'      ,Serie'
             +'      ,Fecha_Emision'
             +'      ,Emision_Implicita'
             +'  FROM QS_FIN_NEM_RFIJA'
             +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
             );

      ParamByName('Codigo_Nemotecnico').AsString := trim(sNemotecnico);

      if sNemotecnicoEmisor <> ' ' then
      begin
        SQL.Add(' AND Codigo_Identidad = :Codigo_Identidad');
        ParamByName('Codigo_Identidad').AsString :=
                                              trim(sNemotecnicoEmisor);
      end;
      Open;

      if FieldByName('Codigo_Identidad').IsNull then
         Result := False
      else
      begin
        sEmision_Implicita := 'N';
        sEmisor      := FieldByName('Codigo_Identidad').AsString;
        sInstrumento := FieldByName('Codigo_Instrumento').AsString;
        sSerie       := FieldByName('Serie').AsString;
        dFecha_Emision := FieldByName('Fecha_Emision').AsDatetime;

        if Not Fieldbyname('Emision_Implicita').isNull then
           sEmision_Implicita := Fieldbyname('Emision_Implicita').asString;

        Result := True;
      end;
      Close;
      UnPrepare;
    end;
end;
//-------------------------------------------------------------------------------------------------------------
procedure Leer_Nemotecnico_Emision_Implicita_Vig(sNemotecnico,
                           sNemotecnicoEmisor : String;
                           var dFecha_Emision : TDatetime;
                           var sEmisor        : String;
                           var sInstrumento   : String;
                           var sSerie         : String;
                           var dFecha_Vig     : TDatetime;
                           var sEmision_Implicita : String;
                           var Result         : Boolean);
begin
  if (sNemotecnico = ' ') or
     (sNemotecnico = '')  then
     begin
       Result := False;
       exit;
     end;
    with dmAyuda_Nemotecnicos.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT Codigo_Identidad'
             +'      ,Codigo_Instrumento'
             +'      ,Serie'
             +'      ,Fecha_Vig'
             +'      ,Fecha_Emision'
             +'      ,Emision_Implicita'
             +'  FROM QS_FIN_NEM_RFIJA'
             +' WHERE Codigo_Nemotecnico = :Codigo_Nemotecnico'
             );

      ParamByName('Codigo_Nemotecnico').AsString := trim(sNemotecnico);

      if sNemotecnicoEmisor <> ' ' then
      begin
        SQL.Add(' AND Codigo_Identidad = :Codigo_Identidad');
        ParamByName('Codigo_Identidad').AsString :=
                                              trim(sNemotecnicoEmisor);
      end;
      Open;

      if FieldByName('Codigo_Identidad').IsNull then
         Result := False
      else
      begin
        sEmision_Implicita := 'N';
        sEmisor        := FieldByName('Codigo_Identidad').AsString;
        sInstrumento   := FieldByName('Codigo_Instrumento').AsString;
        sSerie         := FieldByName('Serie').AsString;
        dFecha_Vig     := FieldByName('Fecha_Vig').AsDatetime;
        dFecha_Emision := FieldByName('Fecha_Emision').AsDatetime;

        if Not Fieldbyname('Emision_Implicita').isNull then
           sEmision_Implicita := Fieldbyname('Emision_Implicita').asString;

        Result := True;
      end;
      Close;
      UnPrepare;
    end;
end;
//-------------------------------------------------------------------------------------------------------------
// Trae solo los nemotecnicos del instrumento pasado como parametro
//-------------------------------------------------------------------------------------------------------------
procedure Ayuda_Nemotecnico_Instrumento(  var sNemotecnico   : String;
                                          var sEmisor      : String;
                                          var sInstrumento : String;
                                          var Result         : Boolean);
begin
 Result         := False;

  with dmAyuda_Nemotecnicos.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA a');

    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    if (sInstrumento <> '') AND (sInstrumento <> '') AND (sInstrumento <> EmptySTR) then
    begin
      if (sEmisor <> ' ') AND
         (sEmisor <> '')  then
          SQL.Add('  AND    ')
      else
          SQL.Add('  WHERE  ');

      SQL.Add(' a.Codigo_Instrumento = :Instrumento ');
      ParamByName('Instrumento').AsString := sInstrumento;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption +
                                                         ' para Instrumento: '+sInstrumento;

    end;


    SQL.Add(' UNION ');
    SQL.Add(' SELECT DISTINCT a.Nemotecnico  as Codigo_Nemotecnico');
    SQL.Add('                ,a.Emisor       as Codigo_Identidad');
    SQL.Add('                ,a.Instrumento  as Codigo_Instrumento');
    SQL.Add('                ,a.Serie');
    SQL.Add('  FROM QS_TRA_OMD_DET_RF a'
           +'  WHERE a.Tipo_Instrum <> ''S'''
           +'    AND a.Tipo_Instrum <> ''R'''
           +'    AND NOT EXISTS (SELECT x.Codigo_Nemotecnico'
           +'                      FROM QS_FIN_NEM_RVARI x'
           +'                     WHERE x.Codigo_Nemotecnico = a.Nemotecnico)'
           );
    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
        SQL.Add('  AND a.Emisor = :Emisor');
        ParamByName('Emisor').AsString := sEmisor;
    end;

    if (sInstrumento <> '') AND (sInstrumento <> '') AND (sInstrumento <> EmptySTR) then
    begin
      SQL.Add(' AND a.Instrumento = :Instrumento ');
      ParamByName('Instrumento').AsString := sInstrumento;
    end;


    SQL.Add(' UNION ');                      // Por alguna razon alguien tenia comentado el Union con los nemotecnicos de RV
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');  // Esto fue descomentado ya que estaba afectando a la definición de los Enlaces
    SQL.Add('      ,a.Codigo_Identidad');    // por nemotecnico !!!! F.I. 07-11-2005
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE a.Serie = '''' ');

    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      SQL.Add('  AND a.Codigo_Identidad = :Codigo_Identidad');
      ParamByName('Codigo_Identidad').AsString := sEmisor;
      //dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end;
    // else
    //   dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    if (sInstrumento <> '') AND (sInstrumento <> '') AND (sInstrumento <> EmptySTR) then
    begin
      if (sEmisor <> ' ') AND
         (sEmisor <> '')  then
          SQL.Add('  AND    ')
      else
          SQL.Add('  AND  ');

      SQL.Add(' a.Codigo_Instrumento = :Instrumento ');
      ParamByName('Instrumento').AsString := sInstrumento;
    end;
    SQL.Add(' UNION ');                      // Por alguna razon alguien tenia comentado el Union con los nemotecnicos de RV
    SQL.Add('SELECT DISTINCT a.Codigo_Nemotecnico');  // Esto fue descomentado ya que estaba afectando a la definición de los Enlaces
    SQL.Add('      ,a.Codigo_Identidad');    // por nemotecnico !!!! F.I. 07-11-2005
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,'''' as Serie');
    SQL.Add('  FROM QS_FIN_NEM_RVARI a');
    SQL.Add(' WHERE a.Serie IS NULL ');

    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      SQL.Add('  AND a.Codigo_Identidad = :Codigo_Identidad');
      ParamByName('Codigo_Identidad').AsString := sEmisor;
      //dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end;
    // else
    //   dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    if (sInstrumento <> '') AND (sInstrumento <> '') AND (sInstrumento <> EmptySTR) then
    begin
      if (sEmisor <> ' ') AND
         (sEmisor <> '')  then
          SQL.Add('  AND    ')
      else
          SQL.Add('  AND  ');

      SQL.Add(' a.Codigo_Instrumento = :Instrumento ');
      ParamByName('Instrumento').AsString := sInstrumento;
    end;

    Open;

    dmAyuda_Nemotecnicos.QRY_General.FetchAll;
    dmAyuda_Nemotecnicos.FDMemTable1.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
    dmAyuda_Nemotecnicos.FDMemTable1.First;
  end;

   dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet2;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := True;

   with dmAyuda_Nemotecnicos.FDMemTable1 do
   begin
      IndexFieldNames := 'Codigo_Nemotecnico';
      SetKey;
      FieldByName('Codigo_Nemotecnico').AsString  := sNemotecnico;
      if NOT GotoKey then
         First;
   end;

   if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
   begin
      sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet2Codigo_Nemotecnico.AsString;
      Result := True;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Nemotecnicos.FDMemTable1.Close;
  // dmAyuda_Nemotecnicos.FDMemTable1.Delete;

end;
//------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------
// Trae solo los nemotecnicos de la Serie como parametro
//-------------------------------------------------------------------------------------------------------------
procedure Ayuda_Nemotecnico_Serie(  var sNemotecnico : String;
                                        sEmisor      : String;
                                        sSerie       : String;
                                    var Result       : Boolean);
begin
 Result         := False;

  with dmAyuda_Nemotecnicos.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Codigo_Nemotecnico');
    SQL.Add('      ,a.Codigo_Identidad');
    SQL.Add('      ,a.Codigo_Instrumento');
    SQL.Add('      ,a.Serie');
    SQL.Add('  FROM QS_FIN_NEM_RFIJA a');

    if (sEmisor <> ' ') AND
       (sEmisor <> '')  then
    begin
      SQL.Add('  WHERE a.Codigo_Identidad = :Codigo_Identidad');
      ParamByName('Codigo_Identidad').AsString := sEmisor;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos de: '+sEmisor;
    end
    else
       dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := 'Nemotécnicos';

    if (sSerie <> '') AND (sSerie <> '') AND (sSerie <> EmptySTR) then
    begin
      if (sEmisor <> ' ') AND
         (sEmisor <> '')  then
          SQL.Add('  AND    ')
      else
          SQL.Add('  WHERE  ');

      SQL.Add(' a.Serie = :Serie ');
      ParamByName('Serie').AsString := sSerie;
      dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption := dmAyuda_Nemotecnicos.Search_Nemotecnico.Caption +
                                                         ' para Serie: '+sSerie;
    end;

    Open;

    dmAyuda_Nemotecnicos.QRY_General.FetchAll;
    dmAyuda_Nemotecnicos.FDMemTable1.Data := dmAyuda_Nemotecnicos.QRY_General.Data;
    dmAyuda_Nemotecnicos.FDMemTable1.First;
  end;

   with dmAyuda_Nemotecnicos.FDMemTable1 do
   begin
      IndexFieldNames := 'Codigo_Nemotecnico';
      SetKey;
      FieldByName('Codigo_Nemotecnico').AsString  := sNemotecnico;
      if NOT GotoKey then
         First;
   end;

   dmAyuda_Nemotecnicos.Search_Nemotecnico.ShadowSearchTable := dmAyuda_Nemotecnicos.ClientDataSet2;
   dmAyuda_Nemotecnicos.ClientDataSet2.Active := True;

   if dmAyuda_Nemotecnicos.Search_Nemotecnico.Execute then
   begin
      sNemotecnico := dmAyuda_Nemotecnicos.ClientDataSet2Codigo_Nemotecnico.AsString;
      Result := True;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Nemotecnicos.FDMemTable1.Close;
  // dmAyuda_Nemotecnicos.FDMemTable1.Delete;

end;
//------------------------------------------------------------------------------

end.

