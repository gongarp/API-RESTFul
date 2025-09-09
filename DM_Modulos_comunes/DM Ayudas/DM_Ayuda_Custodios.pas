unit DM_Ayuda_Custodios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Wwquery, Wwtable, wwidlg, Wwintl, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, vcl.wwDialog,
  FireDAC.Phys.SQLiteVDataSet;

type
  TdmAyuda_Custodios = class(TDataModule)
    Search_Tipo: TwwSearchDialog;
    wwIntl2: TwwIntl;
    Search_Cuentas: TwwSearchDialog;
    QRY_General: TFDQuery;
    FDLocalSQL1: TFDLocalSQL;
    T_Paradox: TFDMemTable;
    T_AyudaCtas: TFDMemTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 function Leer_Cuenta(sEmpresa,
                      sTipo_Cuenta,
                      sIdentidad_cta,
                      sNro_cuenta   : String;
                      dFecha        : TDatetime): Boolean;

 procedure Datos_Cuenta(sEmpresa                       : String;
                        sTipo_Cuenta                   : String;
                        sIdentidad_cta                 : String;
                        sNro_cuenta                    : String;
                        dFecha                         : TDatetime;
                        var sMoneda                    : String;
                        var sTipo_Codigo_Transferencia : String;
                        var sCodigo_Transferencia      : String;
                        var sReferencia                : String;
                        var sId_Cuenta_Rel             : String;
                        var sNro_Cta_Rel               : String);

  Function Existe_Custodio(sEmpresa      : String;
                           sMoneda       : String;
                           dFecha        : TDatetime;
                           sTipo_cuenta  : String ) : Boolean;

  function Leer_Custodio(sEmpresa,
                         sCustodio,
                         sMoneda : String;
                         dFecha        : TDatetime): Boolean;

  function Leer_Identidad_cta(sEmpresa,
                              sTipo_Cuenta,
                              sIdentidad,
                              sMoneda : String;
                              dFecha        : TDatetime): Boolean;

  function Default_Custodio(sEmpresa      : String;
                            sMoneda       : String;
                            dFecha        : TdateTime): String;

  function Default_Identidad_Cta(sEmpresa      : String;
                                 sTipo_Cuenta  : string;
                                 sMoneda       : String;
                                 dFecha        : TdateTime): String;

  function Leer_Custodio_Gral(sCustodio : String;
                              dFecha    : TDatetime): Boolean;

  procedure Ayuda_Custodio(sEmpresa  : String;
                           sMoneda : String;
                           dFecha        : TDatetime;
                           sTipo_cuenta  : String;
                           var sCustodio : String;
                           var Result    : Boolean);

 procedure Ayuda_Cuentas( sTipo_cuenta   : String;
                          sEmpresa       : String;
                          dFecha         : TDatetime;
                          sIdentidad_cta : String;
                         var sNro_Cuenta : String;
                         var sIdentidadRel : String;
                         var sNro_Cuenta_sIdentidadRel : String;
                         var Result    : Boolean
                        );
 procedure Ayuda_Cuentas_Moneda(sTipo_cuenta              : String;
                                sEmpresa                  : String;
                                sCartera                  : String;
                                dFecha                    : TDatetime;
                                sIdentidad_cta            : String;
                            var sMoneda_cta               : String;
                            var sNro_Cuenta               : String;
                            var sIdentidadRel             : String;
                            var sNro_Cuenta_sIdentidadRel : String;
                            var Result                    : Boolean
                               );

Function Existe_Identidad_Cta(sEmpresa      : String;
                              sMoneda       : String;
                              sCustodio     : String;
                              dFecha        : TDatetime;
                              sTipo_cuenta  : String
                             ) : Boolean;

function Leer_Cuentas_Moneda(sTipo_cuenta              : String;
                              sEmpresa                  : String;
                              dFecha                    : TDatetime;
                              sIdentidad_cta            : String;
                              sMoneda_cta               : String;
                              sNro_Cuenta               : String): Boolean;

function Obtiene_Nro_Cuenta(sEmpresa       : String;
                            sTipo_Cuenta   : string;
                            sCartera       : string;
                            sIdentidad_cta : String;
                            sMoneda        : String;
                            dFecha         : TdateTime): String;

var
  dmAyuda_Custodios: TdmAyuda_Custodios;

implementation
Uses
 DM_Base_Datos,
 DM_Comun;

{$R *.DFM}

{Verifica si existe}
function Leer_Custodio(sEmpresa,
                       sCustodio,
                       sMoneda : String;
                       dFecha        : TDatetime): Boolean;
begin
 Result         := True;
  if (sEmpresa = '') or (sCustodio = '') or (sMoneda = '') then
     begin
       Result := False;
       exit;
     end;

  with dmAyuda_Custodios.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT a.Identidad_cta'
           +'  FROM QS_SYS_ID_CTA a'
           +' WHERE a.Codigo_identidad = :Codigo_Identidad'
           +'   AND a.Tipo_Cuenta     = ''CUSTODIA'''
           +'   AND a.Identidad_cta   = :Custodio'
           +'   AND a.Moneda          = :Moneda'
           +'   AND a.Fecha_Desde  <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString := sEmpresa;
    ParamByName('Custodio').AsString         := sCustodio;
    ParamByName('Moneda').AsString           := sMoneda;
    ParamByName('Fecha').AsDateTime          := dFecha;

    Open;

    if FieldByName('Identidad_cta').AsString <> sCustodio then
       Result := False;

    Close;
  end;
  Screen.Cursor := crDefault;
end;

function Leer_Custodio_Gral(sCustodio : String;
                            dFecha    : TDatetime): Boolean;
begin
 Result := True;
  if (sCustodio = '') then
  begin
    Result := False;
    exit;
  end;

  with dmAyuda_Custodios.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT a.Codigo_identidad'
           +'  FROM QS_SYS_ID_TIPO a'
           +' WHERE a.Tipo_Empresa     = ''CUSTODIA'''
           +'   AND a.Codigo_identidad = :Custodio'
           +'   AND a.Fecha_Desde     <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Custodio').AsString := sCustodio;
    ParamByName('Fecha').AsDateTime  := dFecha;

    Open;

    if FieldByName('Codigo_identidad').AsString <> sCustodio then
       Result := False;

    Close;
  end;
  Screen.Cursor := crDefault;
end;

function Default_Custodio(sEmpresa      : String;
                          sMoneda       : String;
                          dFecha        : TdateTime): String;
begin
   with dmAyuda_Custodios.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Identidad_cta'
             +'  FROM QS_SYS_ID_CTA'
             +' WHERE Codigo_Identidad = :Empresa'
             +'   AND Tipo_cuenta       = ''CUSTODIA'''
             +'   AND Moneda            = :Moneda'
             +'   AND Fecha_Desde      <= :Fecha'
             +'   AND (Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
             );
      ParamByName('Empresa').AsString := sEmpresa;
      ParamByName('Moneda').AsString  := sMoneda;
      ParamByName('Fecha' ).AsDateTime  := dFecha;
      Prepare;
      Open;
      if NOT (FieldByName('Identidad_cta').IsNull) then
         Result := FieldByName('Identidad_cta').AsString;
      Close;
   end; // with
end;

{Despliega ventana ayuda}
procedure Ayuda_Custodio(sEmpresa      : String;
                         sMoneda       : String;
                         dFecha        : TDatetime;
                         sTipo_cuenta  : String;
                         var sCustodio : String;
                         var Result    : Boolean);
begin
 Result         := False;
 dmAyuda_Custodios.T_Paradox.Close;

 //dmAyuda_Custodios.T_Paradox.Name := 'helptipocustodio_'+FloatToStr(Application.Handle)+'.DB';
 with dmAyuda_Custodios.T_Paradox.FieldDefs do
  begin
    Clear;
    Add('Codigo_Identidad', ftString,10,False);
    Add('Razon_Social', ftString,35,False);
  end;

  with dmAyuda_Custodios.T_Paradox.IndexDefs do
  begin
    Clear;
      Add('Custodio','Codigo_Identidad',[ixprimary]);
      Add('Razon Social','Razon_Social',[ixCaseInsensitive]);
  end;

 // dmAyuda_Custodios.T_Paradox.CreateTable;
  dmAyuda_Custodios.T_Paradox.Open;

  with dmAyuda_Custodios.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT a.Identidad_cta'
           +'      ,b.Razon_Social_Pat'
           +'  FROM QS_SYS_ID_CTA a'
           +'      ,QS_SYS_IDENTIDAD b'
           +' WHERE a.Codigo_Identidad  = :Empresa'
           +'   AND a.Tipo_cuenta       = :Tipo_Cuenta');
    if sMoneda <> '' then
       SQL.Add(' AND a.Moneda           = :Moneda');
    SQL.Add('   AND a.Fecha_Desde      <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           +'   AND b.Codigo_Identidad  = a.Identidad_cta'
           );
    ParamByName('Empresa').AsString     := sEmpresa;
    if sMoneda <> '' then
       ParamByName('Moneda').AsString   := sMoneda;
    ParamByName('Tipo_Cuenta').AsString := sTipo_Cuenta;
    ParamByName('Fecha').AsDateTime     := dFecha;

    Open;
    while NOT(EOF) do
    begin
      Result := True;
      dmAyuda_Custodios.T_Paradox.insert;
      dmAyuda_Custodios.T_Paradox.FieldByName('Codigo_Identidad').AsString := FieldByName('Identidad_cta').AsString;
      dmAyuda_Custodios.T_Paradox.FieldByName('Razon_Social').AsString     := FieldByName('Razon_Social_Pat').AsString;
      dmAyuda_Custodios.T_Paradox.Post;
      next;
    end;
    Close;
  end;

  WITH dmAyuda_Custodios.T_Paradox do
    begin
     IndexFieldNames := 'Codigo_Identidad';
     SetKey;
     FieldByName('Codigo_Identidad').AsString  := sCustodio;
     if NOT GotoKey then
        First;
    end;

  dmAyuda_Custodios.Search_Tipo.Caption := sTipo_Cuenta + ' para: '
                                           +sEmpresa
                                           +' en moneda '
                                           +sMoneda
                                           ;


  if (dmAyuda_Custodios.Search_Tipo.Execute) and Result  then
     begin
       sCustodio := dmAyuda_Custodios.T_Paradox.FieldByName('Codigo_Identidad').AsString;
     end
  else
  Result := False;
  Screen.Cursor := crDefault;
  dmAyuda_Custodios.T_Paradox.Close;
 // dmAyuda_Custodios.T_Paradox.DeleteTable;
end;

procedure Ayuda_Cuentas( sTipo_cuenta   : String;
                         sEmpresa       : String;
                         dFecha         : TDatetime;
                         sIdentidad_cta : String;
                        var sNro_Cuenta : String;
                        var sIdentidadRel : String;
                        var sNro_Cuenta_sIdentidadRel : String;
                        var Result    : Boolean);
begin
 Result         := False;
 dmAyuda_Custodios.T_AyudaCtas.Close;

 //dmAyuda_Custodios.T_AyudaCtas.TableName := 'helpCtas_'+FloatToStr(Application.Handle)+'.DB';
 with dmAyuda_Custodios.T_AyudaCtas.FieldDefs do
  begin
    Clear;
    Add('Nro_Cuenta' , ftString, 30,False);
    Add('Descripcion', ftString, 30,False);
    Add('Moneda'     , ftString, 15,False);
    Add('Id_cuenta_rel',ftString, 10,False);
    Add('Nro_cta_rel'  ,ftString, 30,False);
  end;

  with dmAyuda_Custodios.T_AyudaCtas.IndexDefs do
  begin
    Clear;
    Add('Nro_Cuenta' ,'Nro_Cuenta',[ixprimary]);
    Add('Descripcion','Descripcion',[ixCaseInsensitive]);
    Add('Moneda'     ,'Moneda'     ,[ixCaseInsensitive]);
  end;
  //dmAyuda_Custodios.T_AyudaCtas.CreateTable;
  dmAyuda_Custodios.T_AyudaCtas.Open;

  with dmAyuda_Custodios.QRY_General do
  begin
   SQL.Clear;
   SQL.Add('SELECT  a.Nro_Cuenta'
           +'      ,a.Descripcion'
           +'      ,a.Moneda'
           +'      ,a.Id_cuenta_rel'
           +'      ,a.Nro_cta_rel'
           +'  FROM QS_SYS_ID_CTA a'
           +'      ,QS_SYS_IDENTIDAD b'
           +' WHERE a.Codigo_Identidad  = :Empresa'
           +'   AND a.Tipo_cuenta       = :Tipo_Cuenta'
           +'   AND a.Identidad_cta     = :Identidad_cta'
           +'   AND a.Fecha_Desde      <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           +'   AND b.Codigo_Identidad  = a.Identidad_cta'
           );
    ParamByName('Empresa').AsString            := sEmpresa;
    ParamByName('Tipo_Cuenta'     ).AsString   := sTipo_Cuenta;
    ParamByName('Identidad_cta'    ).AsString  := sIdentidad_cta;
    ParamByName('Fecha'           ).AsDateTime := dFecha;
    Open;

    while NOT(EOF) do
    begin
      Result := True;
      dmAyuda_Custodios.T_AyudaCtas.insert;
      dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_Cuenta').AsString :=
                                  FieldByName('Nro_Cuenta').AsString;
      dmAyuda_Custodios.T_AyudaCtas.FieldByName('Descripcion').AsString :=
                                  FieldByName('Descripcion').AsString;
      dmAyuda_Custodios.T_AyudaCtas.FieldByName('Moneda').AsString :=
                                  FieldByName('Moneda').AsString;
      dmAyuda_Custodios.T_AyudaCtas.FieldByName('Id_cuenta_rel').AsString :=
                                  FieldByName('Id_cuenta_rel').AsString;
      dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_cta_rel').AsString :=
                                  FieldByName('Nro_cta_rel').AsString;
      dmAyuda_Custodios.T_AyudaCtas.Post;
      next;
    end;
    Close;
  end;

  WITH dmAyuda_Custodios.T_AyudaCtas do
  begin
     IndexFieldNames := 'Nro_Cuenta';
     SetKey;
     FieldByName('Nro_Cuenta').AsString  := sNro_Cuenta;
     if NOT GotoKey then
        First;
  end;
  dmAyuda_Custodios.Search_Cuentas.Caption := 'Cuentas para: '
                                             +sEmpresa
                                             +' - '
                                             +sTipo_Cuenta
                                             +' - '
                                             +sIdentidad_cta;
  sIdentidadRel             := '';
  sNro_Cuenta_sIdentidadRel := '';
  if (dmAyuda_Custodios.Search_Cuentas.Execute) and Result  then
  begin
      sNro_Cuenta := dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_Cuenta').AsString;
      if Not dmAyuda_Custodios.T_AyudaCtas.FieldByName('Id_cuenta_rel').isNull then
         sIdentidadRel :=  dmAyuda_Custodios.T_AyudaCtas.FieldByName('Id_cuenta_rel').asString;

      if Not dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_cta_rel').isNull then
         sNro_Cuenta_sIdentidadRel :=  dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_cta_rel').asString;
  end
  else
     Result := False;

  Screen.Cursor := crDefault;
  dmAyuda_Custodios.T_AyudaCtas.Close;
  //dmAyuda_Custodios.T_AyudaCtas.DeleteTable;
end;

function Leer_Cuenta(sEmpresa,
                     sTipo_Cuenta,
                     sIdentidad_cta,
                     sNro_cuenta   : String;
                     dFecha        : TDatetime): Boolean;
begin
  Result         := false;
  with dmAyuda_Custodios.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT a.Identidad_cta'
           +'  FROM QS_SYS_ID_CTA a'
           +' WHERE a.Codigo_identidad = :Codigo_Identidad'
           +'   AND a.Tipo_Cuenta      = :Tipo_Cuenta'
           +'   AND a.Identidad_cta    = :Identidad_cta'
           +'   AND a.Nro_cuenta       = :Nro_cuenta'
           +'   AND a.Fecha_Desde  <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString := sEmpresa;
    ParamByName('Tipo_Cuenta').AsString      := sTipo_Cuenta;
    ParamByName('Identidad_cta').AsString    := sIdentidad_cta;
    ParamByName('Nro_cuenta').AsString       := sNro_cuenta;
    ParamByName('Fecha').AsDateTime          := dFecha;
    Open;

    if (Not FieldByName('Identidad_cta').isNull) and ( not eof) then
       Result := True;
    Close;
  end;
  Screen.Cursor := crDefault;
end;

Function Existe_Custodio(sEmpresa      : String;
                          sMoneda       : String;
                          dFecha        : TDatetime;
                          sTipo_cuenta  : String
                         ) : Boolean;
begin
  Result := False;
  with dmAyuda_Custodios.QRY_General do
  begin
   SQL.Clear;
   SQL.Add('SELECT DISTINCT a.Identidad_cta'
          +'      ,b.Razon_Social_Pat'
          +'  FROM QS_SYS_ID_CTA a'
          +'      ,QS_SYS_IDENTIDAD b'
          +' WHERE a.Codigo_Identidad  = :Empresa'
          +'   AND a.Tipo_cuenta       = :Tipo_Cuenta');
   if sMoneda <> '' then
      SQL.Add(' AND a.Moneda           = :Moneda');
   SQL.Add('   AND a.Fecha_Desde      <= :Fecha'
          +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
          +'   AND b.Codigo_Identidad  = a.Identidad_cta'
           );
    ParamByName('Empresa').AsString            := sEmpresa;
    if sMoneda <> '' then
       ParamByName('Moneda'       ).AsString   := sMoneda;
    ParamByName('Tipo_Cuenta'     ).AsString   := sTipo_Cuenta;
    ParamByName('Fecha'           ).AsDateTime := dFecha;
    try
        Open;
        if NOT Fieldbyname('Identidad_cta').IsNull then
           Result := True;
    except
      begin
          Result := False;
          Close;
      end;
    end;
   Close;
  end;
end;

 procedure Ayuda_Cuentas_Moneda(sTipo_cuenta              : String;
                                sEmpresa                  : String;
                                sCartera                  : String;
                                dFecha                    : TDatetime;
                                sIdentidad_cta            : String;
                            var sMoneda_cta               : String;
                            var sNro_Cuenta               : String;
                            var sIdentidadRel             : String;
                            var sNro_Cuenta_sIdentidadRel : String;
                            var Result                    : Boolean
                               );
begin
   Result := False;
   dmAyuda_Custodios.T_AyudaCtas.Close;

  // dmAyuda_Custodios.T_AyudaCtas.TableName := 'helpCtas_'+FloatToStr(Application.Handle)+'.DB';
   with dmAyuda_Custodios.T_AyudaCtas.FieldDefs do
   begin
      Clear;
      Add('Nro_Cuenta' , ftString, 30,False);
      Add('Id_cuenta_rel',ftString, 10,False);
      Add('Nro_cta_rel'  ,ftString, 30,False);
      Add('Descripcion', ftString, 30,False);
      Add('Moneda'     , ftString, 15,False);
   end;
   with dmAyuda_Custodios.T_AyudaCtas.IndexDefs do
   begin
      Clear;
      Add('Unico'      ,'Nro_Cuenta;Id_cuenta_rel;Nro_cta_rel',[ixprimary]);
      Add('Nro_Cuenta' ,'Nro_Cuenta' ,[ixCaseInsensitive]);
      Add('Descripcion','Descripcion',[ixCaseInsensitive]);
      Add('Moneda'     ,'Moneda'     ,[ixCaseInsensitive]);
   end;
  // dmAyuda_Custodios.T_AyudaCtas.CreateTable;
   dmAyuda_Custodios.T_AyudaCtas.Open;

   with dmAyuda_Custodios.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT a.Nro_Cuenta'
              +'     ,a.Descripcion'
              +'     ,a.Moneda'
              +'     ,a.Id_cuenta_rel'
              +'     ,a.Nro_cta_rel'
              +' FROM QS_SYS_ID_CTA a'
              +'     ,QS_SYS_IDENTIDAD b');
      if sCartera <> '' then
         SQL.Add(' ,QS_SYS_ID_CTA_CARTERA c');
      SQL.Add(' WHERE a.Codigo_Identidad  = :Empresa'
              +'  AND a.Tipo_cuenta       = :Tipo_Cuenta'
              +'  AND a.Identidad_cta     = :Identidad_cta'
              +'  AND a.Fecha_Desde      <= :Fecha'
              +'  AND (a.Fecha_Hasta Is NULL or a.Fecha_Hasta >= :Fecha)');
      if sMoneda_cta <> '' then
         SQL.Add(' AND a.Moneda            = :Moneda');
      SQL.Add('    AND b.Codigo_Identidad  = a.Identidad_cta');
      if sCartera <> '' then
      begin
         SQL.Add(' AND c.Codigo_Identidad = a.Codigo_Identidad');
         SQL.Add(' AND c.Tipo_Cuenta      = a.Tipo_Cuenta');
         SQL.Add(' AND c.Identidad_Cta    = a.Identidad_Cta');
         SQL.Add(' AND c.Fecha_Desde      = a.Fecha_Desde');
         SQL.Add(' AND c.Nro_Cuenta       = a.Nro_Cuenta');
         SQL.Add(' AND c.Cartera          = :Cartera');
         ParamByName('Cartera').AsString := sCartera;
      end;

      ParamByName('Empresa').AsString       := sEmpresa;
      ParamByName('Tipo_Cuenta').AsString   := sTipo_Cuenta;
      ParamByName('Identidad_cta').AsString := sIdentidad_cta;
      ParamByName('Fecha').AsDateTime       := dFecha;
      if sMoneda_cta <> '' then
         ParamByName('Moneda').AsString     := sMoneda_cta;

      Open;
//      if Eof and (sCartera <> '') then
//      begin
//        Close;
//        SQL.Clear;
//        SQL.Add('SELECT a.Nro_Cuenta'
//                +'     ,a.Descripcion'
//                +'     ,a.Moneda'
//                +'     ,a.Id_cuenta_rel'
//                +'     ,a.Nro_cta_rel'
//                +' FROM QS_SYS_ID_CTA a'
//                +'     ,QS_SYS_IDENTIDAD b');
//        SQL.Add(' WHERE a.Codigo_Identidad  = :Empresa'
//                +'  AND a.Tipo_cuenta       = :Tipo_Cuenta'
//                +'  AND a.Identidad_cta     = :Identidad_cta'
//                +'  AND a.Fecha_Desde      <= :Fecha'
//                +'  AND (a.Fecha_Hasta Is NULL or a.Fecha_Hasta >= :Fecha)');
//        if sMoneda_cta <> '' then
//           SQL.Add(' AND a.Moneda            = :Moneda');
//        SQL.Add('    AND b.Codigo_Identidad  = a.Identidad_cta');
//
//        ParamByName('Empresa').AsString       := sEmpresa;
//        ParamByName('Tipo_Cuenta').AsString   := sTipo_Cuenta;
//        ParamByName('Identidad_cta').AsString := sIdentidad_cta;
//        ParamByName('Fecha').AsDateTime       := dFecha;
//        if sMoneda_cta <> '' then
//           ParamByName('Moneda').AsString     := sMoneda_cta;
//
//        Open;
//
//      end;

      while NOT(EOF) do
      begin
         Result := True;
         dmAyuda_Custodios.T_AyudaCtas.insert;
         dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_Cuenta').AsString    := FieldByName('Nro_Cuenta').AsString;
         dmAyuda_Custodios.T_AyudaCtas.FieldByName('Descripcion').AsString   := FieldByName('Descripcion').AsString;
         dmAyuda_Custodios.T_AyudaCtas.FieldByName('Moneda').AsString        := FieldByName('Moneda').AsString;
         dmAyuda_Custodios.T_AyudaCtas.FieldByName('Id_cuenta_rel').AsString := FieldByName('Id_cuenta_rel').AsString;
         dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_cta_rel').AsString   := FieldByName('Nro_cta_rel').AsString;
         dmAyuda_Custodios.T_AyudaCtas.Post;
         next;
      end;
      Close;
   end;

   with dmAyuda_Custodios.T_AyudaCtas do
   begin
      IndexFieldNames := 'Nro_Cuenta';
      SetKey;
      FieldByName('Nro_Cuenta').AsString  := sNro_Cuenta;
      if NOT GotoKey then
         First;
   end;
   dmAyuda_Custodios.Search_Cuentas.Caption := 'Cuentas para: '+sEmpresa;

   sIdentidadRel             := '';
   sNro_Cuenta_sIdentidadRel := '';
   if (dmAyuda_Custodios.Search_Cuentas.Execute) and Result  then
   begin
      sMoneda_cta := dmAyuda_Custodios.T_AyudaCtas.FieldByName('Moneda').AsString;
      sNro_Cuenta := dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_Cuenta').AsString;
      if Not dmAyuda_Custodios.T_AyudaCtas.FieldByName('Id_cuenta_rel').isNull then
         sIdentidadRel :=  dmAyuda_Custodios.T_AyudaCtas.FieldByName('Id_cuenta_rel').asString;

      if Not dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_cta_rel').isNull then
         sNro_Cuenta_sIdentidadRel :=  dmAyuda_Custodios.T_AyudaCtas.FieldByName('Nro_cta_rel').asString;
   end
   else
      Result := False;

   Screen.Cursor := crDefault;
   dmAyuda_Custodios.T_AyudaCtas.Close;
   //dmAyuda_Custodios.T_AyudaCtas.DeleteTable;
end;

 function Leer_Cuentas_Moneda(sTipo_cuenta              : String;
                              sEmpresa                  : String;
                              dFecha                    : TDatetime;
                              sIdentidad_cta            : String;
                              sMoneda_cta               : String;
                              sNro_Cuenta               : String): Boolean;
begin
  Result := False;

  with dmAyuda_Custodios.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT  a.* '
            +'  FROM QS_SYS_ID_CTA a'
            +'      ,QS_SYS_IDENTIDAD b'
            +' WHERE a.Codigo_Identidad  = :Empresa'
            +'   AND a.Tipo_cuenta       = :Tipo_Cuenta'
            +'   AND a.Identidad_cta     = :Identidad_cta'
            +'   AND a.Nro_Cuenta        = :Nro_Cuenta'
            +'   AND a.Fecha_Desde      <= :Fecha'
            +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)');
    if sMoneda_cta <> '' then
       SQL.Add(' AND a.Moneda            = :Moneda');
    SQL.Add('    AND b.Codigo_Identidad  = a.Identidad_cta');

    ParamByName('Empresa').AsString       := sEmpresa;
    ParamByName('Tipo_Cuenta').AsString   := sTipo_Cuenta;
    ParamByName('Identidad_cta').AsString := sIdentidad_cta;
    ParamByName('Nro_Cuenta').AsString    := sNro_Cuenta;
    ParamByName('Fecha').AsDateTime       := dFecha;
    if sMoneda_cta <> '' then
       ParamByName('Moneda').AsString     := sMoneda_cta;

    try
      Open;
      if NOT Fieldbyname('Moneda').IsNull then
         Result := True;
    except
      begin
        Result := False;
        Close;
      end;
    end;
    Close;
  end;
end;

 procedure Datos_Cuenta(sEmpresa                       : String;
                        sTipo_Cuenta                   : String;
                        sIdentidad_cta                 : String;
                        sNro_cuenta                    : String;
                        dFecha                         : TDateTime;
                        var sMoneda                    : String;
                        var sTipo_Codigo_Transferencia : String;
                        var sCodigo_Transferencia      : String;
                        var sReferencia                : String;
                        var sId_Cuenta_Rel             : String;
                        var sNro_Cta_Rel               : String);
begin
   with dmAyuda_Custodios.QRY_General do
   begin
      sMoneda                    := '';
      sTipo_Codigo_Transferencia := '';
      sCodigo_Transferencia      := '';
      sReferencia                := '';
      sId_Cuenta_Rel             := '';
      sNro_Cta_Rel               := '';
      SQL.Clear;
      SQL.Add('SELECT a.Moneda '
             +'      ,a.Tipo_Codigo_Transferencia '
             +'      ,a.Codigo_Transferencia '
             +'      ,a.Referencia '
             +'      ,a.Id_Cuenta_Rel '
             +'      ,a.Nro_Cta_Rel '
             +'  FROM QS_SYS_ID_CTA a '
             +' WHERE a.Codigo_identidad  = :Codigo_Identidad '
             +'   AND a.Tipo_Cuenta       = :Tipo_Cuenta '
             +'   AND a.Identidad_cta     = :Identidad_cta '
             +'   AND a.Nro_cuenta        = :Nro_cuenta '
             +'   AND a.Fecha_Desde      <= :Fecha '
             +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha) '
             );
      ParamByName('Codigo_Identidad').AsString := sEmpresa;
      ParamByName('Tipo_Cuenta').AsString      := sTipo_Cuenta;
      ParamByName('Identidad_cta').AsString    := sIdentidad_cta;
      ParamByName('Nro_cuenta').AsString       := sNro_cuenta;
      ParamByName('Fecha').AsDatetime          := dFecha;
      Open;

      if Not eof then
      begin
         sMoneda                    := FieldByName('Moneda').AsString;
         sTipo_Codigo_Transferencia := FieldByName('Tipo_Codigo_Transferencia').AsString;
         sCodigo_Transferencia      := FieldByName('Codigo_Transferencia').AsString;
         sReferencia                := FieldByName('Referencia').AsString;
         sId_Cuenta_Rel             := FieldByName('Id_Cuenta_Rel').AsString;
         sNro_Cta_Rel               := FieldByName('Nro_Cta_Rel').AsString;
      end;
      Close;
   end;
   Screen.Cursor := crDefault;
end;

Function Existe_Identidad_Cta(sEmpresa      : String;
                              sMoneda       : String;
                              sCustodio     : String;
                              dFecha        : TDatetime;
                              sTipo_cuenta  : String
                             ) : Boolean;
begin
  Result := False;
  with dmAyuda_Custodios.QRY_General do
  begin
   SQL.Clear;
   SQL.Add('SELECT a.Identidad_cta'
          +'  FROM QS_SYS_ID_CTA a'
          +' WHERE a.Codigo_Identidad  = :Empresa'
          +'   AND a.Tipo_cuenta       = :Tipo_Cuenta'
          +'   AND a.Identidad_cta     = :Identidad_cta');
   if sMoneda <> '' then
      SQL.Add(' AND a.Moneda           = :Moneda');
   SQL.Add('   AND a.Fecha_Desde      <= :Fecha'
          +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );
    ParamByName('Empresa'      ).AsString          := sEmpresa;
    ParamByName('Identidad_cta').AsString          := sCustodio;
    if sMoneda <> '' then
       ParamByName('Moneda'       ).AsString   := sMoneda;
    ParamByName('Tipo_Cuenta'     ).AsString   := sTipo_Cuenta;
    ParamByName('Fecha'           ).AsDateTime := dFecha;
    try
        Open;
        if NOT Fieldbyname('Identidad_cta').IsNull then
           Result := True;
    except
      begin
          Result := False;
          Close;
      end;
    end;
   Close;
  end;
end;

function Leer_Identidad_cta(sEmpresa,
                            sTipo_Cuenta,
                            sIdentidad,
                            sMoneda : String;
                            dFecha        : TDatetime): Boolean;
begin
  Result         := True;
  if (sEmpresa = '') or (sIdentidad = '') or (sMoneda = '') then
     begin
       Result := False;
       exit;
     end;

  with dmAyuda_Custodios.QRY_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT a.Identidad_cta'
           +'  FROM QS_SYS_ID_CTA a'
           +' WHERE a.Codigo_identidad = :Codigo_Identidad'
           +'   AND a.Tipo_Cuenta     = :Tipo_Cuenta '
           +'   AND a.Identidad_cta   = :Custodio'
           +'   AND a.Moneda          = :Moneda'
           +'   AND a.Fecha_Desde  <= :Fecha'
           +'   AND (a.Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha)'
           );

    ParamByName('Codigo_Identidad').AsString := sEmpresa;
    ParamByName('Tipo_Cuenta').AsString      := sTipo_Cuenta;
    ParamByName('Custodio').AsString         := sIdentidad;
    ParamByName('Moneda').AsString           := sMoneda;
    ParamByName('Fecha').AsDateTime          := dFecha;

    Open;

    if FieldByName('Identidad_cta').AsString <> sIdentidad then
       Result := False;

    Close;
  end;
  Screen.Cursor := crDefault;
end;

function Default_Identidad_Cta(sEmpresa      : String;
                               sTipo_Cuenta  : string;
                               sMoneda       : String;
                               dFecha        : TdateTime): String;
begin
   Result := '';
   with dmAyuda_Custodios.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Identidad_cta '
             +'  FROM QS_SYS_ID_CTA '
             +' WHERE Codigo_Identidad = :Empresa '
             +'   AND Tipo_cuenta      = :Tipo_Cuenta '
             +'   AND Moneda           = :Moneda '
             +'   AND Fecha_Desde      <= :Fecha '
             +'   AND (Fecha_Hasta Is NULL or Fecha_Hasta >= :Fecha) '
             );
      ParamByName('Empresa').AsString     := sEmpresa;
      ParamByName('Tipo_Cuenta').AsString := sTipo_Cuenta;
      ParamByName('Moneda').AsString      := sMoneda;
      ParamByName('Fecha' ).AsDateTime    := dFecha;
      Prepare;
      Open;
      if NOT (FieldByName('Identidad_cta').IsNull) then
         Result := FieldByName('Identidad_cta').AsString;
      Close;
   end; // with
end;

function Obtiene_Nro_Cuenta(sEmpresa       : String;
                            sTipo_Cuenta   : string;
                            sCartera       : string;
                            sIdentidad_cta : String;
                            sMoneda        : String;
                            dFecha         : TdateTime): String;
begin
   Result := '';
   with dmAyuda_Custodios.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT a.Nro_cuenta '
             +'  FROM QS_SYS_ID_CTA a');
      if sCartera <> '' then
         SQL.Add(' ,QS_SYS_ID_CTA_CARTERA c');
      SQL.Add(' WHERE a.Codigo_Identidad = :Empresa '
             +'   AND a.Tipo_cuenta      = :Tipo_Cuenta '
             +'   AND a.Identidad_cta    = :Identidad_cta '
             +'   AND a.Moneda           = :Moneda '
             +'   AND a.Fecha_Desde      <= :Fecha '
             +'   AND (a.Fecha_Hasta Is NULL or a.Fecha_Hasta >= :Fecha) '
             );
      if sCartera <> '' then
      begin
         SQL.Add(' AND c.Codigo_Identidad = a.Codigo_Identidad');
         SQL.Add(' AND c.Tipo_Cuenta      = a.Tipo_Cuenta');
         SQL.Add(' AND c.Identidad_Cta    = a.Identidad_Cta');
         SQL.Add(' AND c.Fecha_Desde      = a.Fecha_Desde');
         SQL.Add(' AND c.Nro_Cuenta       = a.Nro_Cuenta');
         SQL.Add(' AND c.Cartera          = :Cartera');
         ParamByName('Cartera').AsString := sCartera;
      end;

      ParamByName('Empresa').AsString       := sEmpresa;
      ParamByName('Tipo_Cuenta').AsString   := sTipo_Cuenta;
      ParamByName('Identidad_cta').AsString := sIdentidad_cta;
      ParamByName('Moneda').AsString        := sMoneda;
      ParamByName('Fecha' ).AsDateTime      := dFecha;
      Prepare;
      Open;
      if NOT (FieldByName('Nro_cuenta').IsNull) then
         Result := FieldByName('Nro_cuenta').AsString;
      Close;
   end; // with
end;


end.
