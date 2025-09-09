unit DM_Clasif_Riesgo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,  DM_FuncionesMemory, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM_Clasificacion_Riesgo = class(TDataModule)
    QRY_Clasificacion: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  {
  procedure Busca_Clasif_Riesgo(sEmisor            : String;
                                sInstrumento       : String;
                                sSerie             : String;
                                dFecha             : TDateTime;
                                var sClasificacion : String);

  procedure Busca_Clasif_Riesgo_Nem(sNemotecnico   : String;
                                    dFecha         : TDateTime;
                                var sClasificacion : String;
                                var sTipo_Clasif   : String);
   }
  procedure Busca_Clasif_Riesgo_Origen_Tipo(const sEmisor_par      : String;
                                            const sInstrumento     : String;
                                            sSerie                 : String;
                                            sNemotecnico           : String;
                                            dFecha                 : TDateTime;
                                            var sOrigen             : String;
                                            var sTipo_Clasif       : String;
                                            bObliga_Clasif_Instrum : Boolean;
                                            var sClasificacion     : String;
                                            var fFactor_Riesgo     : Double;
                                            var sEmisor_Pagador    : String);
var
  DM_Clasificacion_Riesgo: TDM_Clasificacion_Riesgo;

implementation
uses DM_Base_Datos,DM_Codigos_generales;

{$R *.DFM}
{
procedure Busca_Clasif_Riesgo(sEmisor            : String;
                              sInstrumento       : String;
                              sSerie             : String;
                              dFecha             : TDateTime;
                              var sClasificacion : String);
var Buscar     : Boolean;
    dMax_Fecha : TDateTime;
    Encontro_Fecha : Boolean;
    sEmisor_Pagador : String;
    bEmisor_Pagador : Boolean;
begin
   WITH DM_Clasificacion_Riesgo.QRY_Clasificacion do
   begin
      Buscar := True;
      Encontro_Fecha := False;
      if sSerie = '' then
         sSerie := ' ';

      While Buscar do
      begin
         SQL.Clear;
         SQL.Add('SELECT MAX(F_CLASIF_SERIE) as Max_Fecha'
                +'  FROM QS_FIN_CL_RIESGOS'
                +' WHERE COD_EMP_SERIE  = :Emisor'
                +'   AND COD_INST_SERIE = :Instrumento'
                );
         if sSerie = ' ' then
            SQL.Add('   AND (SERIE_CLASIF  = :Serie OR SERIE_CLASIF IS NULL) ')
         else
            SQL.Add('   AND SERIE_CLASIF   = :Serie');
         SQL.Add('   AND F_CLASIF_SERIE <= :Fecha'
                +'   AND ORIGEN <= :Origen '
                );

         ParamByName('Emisor').AsString      := trim(sEmisor);
         ParamByName('Instrumento').AsString := trim(sInstrumento);

         if sSerie = ' ' then
            ParamByName('Serie').AsString := ' '
         else
            ParamByName('Serie').AsString := trim(sSerie);

         ParamByName('Fecha').AsDatetime := dFecha;
         ParamByName('Origen').AsString  := default_codgen('AGENCIACLA','FI','');
         Open;
         if NOT FieldByName('Max_Fecha').IsNull then
         begin
           dMax_Fecha := FieldByName('Max_Fecha').AsDateTime;
           Encontro_Fecha := True;
           Buscar         := False;
         end;
         Close;

         if Encontro_Fecha then
         begin
            SQL.Clear;
            SQL.Add('SELECT CLASIF_SERIE'
                   +'  FROM QS_FIN_CL_RIESGOS'
                   +' WHERE COD_EMP_SERIE  = :Emisor'
                   +'   AND COD_INST_SERIE = :Instrumento'
                   );
            if sSerie = ' ' then
               SQL.Add('   AND (SERIE_CLASIF  = :Serie OR SERIE_CLASIF IS NULL) ')
            else
               SQL.Add('   AND SERIE_CLASIF   = :Serie');
            SQL.Add('   AND F_CLASIF_SERIE = :Fecha'
                   +'   AND ORIGEN <= :Origen '
                   );

            ParamByName('Emisor').AsString      := trim(sEmisor);
            ParamByName('Instrumento').AsString := trim(sInstrumento);
            if sSerie = ' ' then
               ParamByName('Serie').AsString := ' '
            else
               ParamByName('Serie').AsString := trim(sSerie);
            ParamByName('Fecha').AsDatetime := dMax_Fecha;
            ParamByName('Origen').AsString  := default_codgen('AGENCIACLA','FI','');
            Open;
            sClasificacion := FieldByName('CLASIF_SERIE').AsString;
            Close;
         end; // end Encontro

         if Buscar then
            if sSerie = ' ' then
            begin
               Buscar := False;
               sClasificacion := '';
            end
            else
               sSerie := ' ';
      end;  // end While

      //GGARCIA 17/04/2007  Si no encuentra Clasificacion va a buscar con el emisor pagador si tiene.
      if (sClasificacion = '') or (sClasificacion = ' ') then
      begin
         sEmisor_Pagador := '';
         bEmisor_Pagador := False;
         Emisor_Pagador_Mem(dFecha
                           ,sEmisor
                           ,sInstrumento
                           ,sEmisor_Pagador
                           ,bEmisor_Pagador);
         if bEmisor_Pagador then
            Busca_Clasif_Riesgo(sEmisor_Pagador
                               ,sInstrumento
                               ,sSerie
                               ,dFecha
                               ,sClasificacion);
      end;
   end; // end with
end;

procedure Busca_Clasif_Riesgo_Nem(sNemotecnico   : String;
                                  dFecha         : TDateTime;
                              var sClasificacion : String;
                              var sTipo_Clasif   : String);
var dMax_Fecha     : TDateTime;
    Encontro_Fecha : Boolean;
begin
   WITH DM_Clasificacion_Riesgo.QRY_Clasificacion do
   begin
      Encontro_Fecha := False;
      SQL.Clear;
      SQL.Add('SELECT MAX(FECHA_VIGENCIA) as Max_Fecha'
             +'  FROM QS_FIN_CL_RIESGO_NEMO'
             +' WHERE NEMOTECNICO     = :Nemotecnico'
             +'   AND FECHA_VIGENCIA <= :Fecha_vigencia'
             );
      ParamByName('Nemotecnico').AsString      := trim(sNemotecnico);
      ParamByName('Fecha_vigencia').AsDatetime := dFecha;
      Open;
      if NOT FieldByName('Max_Fecha').IsNull then
      begin
        dMax_Fecha := FieldByName('Max_Fecha').AsDateTime;
        Encontro_Fecha := True;
      end;
      Close;

      if Encontro_Fecha then
      begin
         SQL.Clear;
         SQL.Add('SELECT CLASIFICACION '
                +'      ,TIPO_CLASIF '
                +'  FROM QS_FIN_CL_RIESGO_NEMO'
                +' WHERE NEMOTECNICO    = :Nemotecnico'
                +'   AND FECHA_VIGENCIA = :Fecha_vigencia'
                );
         ParamByName('Nemotecnico').AsString      := trim(sNemotecnico);
         ParamByName('Fecha_vigencia').AsDatetime := dMax_Fecha;  //dFecha;
         Open;
         sClasificacion := FieldByName('CLASIFICACION').AsString;
         sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
         Close;
      end; // end Encontro
   end; // end with
end;
 }

procedure Busca_Clasif_Riesgo_Origen_Tipo(const sEmisor_par      : String;
                                          const sInstrumento     : String;
                                          sSerie                 : String;
                                          sNemotecnico           : String;
                                          dFecha                 : TDateTime;
                                          var sOrigen             : String;
                                          var sTipo_Clasif       : String;
                                          bObliga_Clasif_Instrum : Boolean;
                                          var sClasificacion     : String;
                                          var fFactor_Riesgo     : Double;
                                          var sEmisor_Pagador    : String);
var i               : Integer;
    fNro_Riesgo,
    fValor_Nivel,
    fNivel          : Double;
    Result,
    bEmisor_Pagador : Boolean;
    sTipo_Plazo     : String;
    sEmisor         : String;
begin

  Result         := False;
  sEmisor        := sEmisor_par;
  sClasificacion := '';
  if sSerie = '' then
     sSerie      := ' ';

  sEmisor_Pagador := sEmisor;
  bEmisor_Pagador := False;
  Emisor_Pagador_Mem(dFecha,
                     sEmisor,
                     sInstrumento,
                     sEmisor_Pagador,
                     bEmisor_Pagador);
  if (bEmisor_Pagador) and
     (sEmisor <> sEmisor_Pagador) then
  begin
     Busca_Clasif_Riesgo_Origen_Tipo(sEmisor_Pagador,
                                     sInstrumento,
                                     sSerie,
                                     sNemotecnico,
                                     dFecha,
                                     sOrigen,
                                     sTipo_Clasif,
                                     bObliga_Clasif_Instrum,
                                     sClasificacion,
                                     fFactor_Riesgo,
                                     sEmisor_Pagador);
     if sClasificacion <> '' then
        Exit;   // Sale unicamente si encontró, de lo contrario, sigue buscando clasificación para el emisor original
  end;

  WITH DM_Clasificacion_Riesgo.QRY_Clasificacion do
  begin

    if bObliga_Clasif_Instrum then
    begin
       if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) <> '') then
       begin
          SQL.Clear;
          SQL.Add('SELECT a.CLASIF_SERIE '
                 +'  FROM QS_FIN_CL_RIESGOS a '
                 +' WHERE a.COD_EMP_SERIE   = :Emisor '
                 +'   AND a.COD_INST_SERIE  = :Instrumento '
                 +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                 +'                              FROM QS_FIN_CL_RIESGOS b '
                 +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                 +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                 +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                 +'                               AND b.ORIGEN          = a.ORIGEN '
                 +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                 +'   AND a.ORIGEN          = :Origen'
                 +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                 );
          ParamByName('Emisor').AsString      := trim(sEmisor);
          ParamByName('Instrumento').AsString := trim(sInstrumento);
          ParamByName('Fecha').AsDatetime     := dFecha;
          ParamByName('Origen').AsString      := trim(sOrigen);
          ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
          Open;
          if not eof then
          begin
             sClasificacion := FieldByName('CLASIF_SERIE').AsString;
             Result         := True;
          end;
       end
       else
       begin
          if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) = '') then
          begin
             SQL.Clear;
             SQL.Add('SELECT a.CLASIF_SERIE '
                    +'      ,a.ORIGEN '
                    +'  FROM QS_FIN_CL_RIESGOS a '
                    +' WHERE a.COD_EMP_SERIE   = :Emisor '
                    +'   AND a.COD_INST_SERIE  = :Instrumento '
                    +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                    +'                              FROM QS_FIN_CL_RIESGOS b '
                    +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                    +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                    +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                    +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                    +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                    );
             ParamByName('Emisor').AsString      := trim(sEmisor);
             ParamByName('Instrumento').AsString := trim(sInstrumento);
             ParamByName('Fecha').AsDatetime     := dFecha;
             ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
             Open;
             if not eof then
             begin
                sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                sOrigen        := FieldByName('ORIGEN').AsString;
                Result         := True;
             end;
          end
          else
          begin
             if (trim(sTipo_Clasif) = '') and (trim(sOrigen) <> '') then
             begin
                SQL.Clear;
                SQL.Add('SELECT a.CLASIF_SERIE '
                       +'      ,a.TIPO_CLASIF '
                       +'  FROM QS_FIN_CL_RIESGOS a '
                       +' WHERE a.COD_EMP_SERIE   = :Emisor '
                       +'   AND a.COD_INST_SERIE  = :Instrumento '
                       +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                       +'                              FROM QS_FIN_CL_RIESGOS b '
                       +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                       +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                       +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                       +'                               AND b.ORIGEN          = a.ORIGEN)'
                       +'   AND a.ORIGEN          = :Origen'
                       );
                ParamByName('Emisor').AsString      := trim(sEmisor);
                ParamByName('Instrumento').AsString := trim(sInstrumento);
                ParamByName('Fecha').AsDatetime     := dFecha;
                ParamByName('Origen').AsString      := trim(sOrigen);
                Open;
                if not eof then
                begin
                   sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                   sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                   Result         := True;
                end;
             end
             else
             begin
                SQL.Clear;
                SQL.Add('SELECT a.CLASIF_SERIE '
                       +'      ,a.TIPO_CLASIF '
                       +'      ,a.ORIGEN '
                       +'  FROM QS_FIN_CL_RIESGOS a '
                       +' WHERE a.COD_EMP_SERIE   = :Emisor '
                       +'   AND a.COD_INST_SERIE  = :Instrumento '
                       +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                       +'                              FROM QS_FIN_CL_RIESGOS b '
                       +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                       +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                       +'                               AND b.F_CLASIF_SERIE <= :Fecha )'
                       );
                ParamByName('Emisor').AsString      := trim(sEmisor);
                ParamByName('Instrumento').AsString := trim(sInstrumento);
                ParamByName('Fecha').AsDatetime     := dFecha;
                Open;
                if not eof then
                begin
                   sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                   sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                   sOrigen        := FieldByName('ORIGEN').AsString;
                   Result         := True;
                end;
             end;
          end;
       end;
    end;

    //Busco Nemotecnico
    if Not Result then
    begin
       if trim(sNemotecnico) <> '' then
       begin
          if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) <> '') then
          begin
             SQL.Clear;
             SQL.Add('SELECT a.CLASIF_SERIE '
                    +'  FROM QS_FIN_CL_RIESGOS a '
                    +' WHERE a.NEMOTECNICO     = :Nemotecnico '
                    +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                    +'                              FROM QS_FIN_CL_RIESGOS b '
                    +'                             WHERE b.NEMOTECNICO     = a.NEMOTECNICO '
                    +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                    +'                               AND b.ORIGEN          = a.ORIGEN '
                    +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                    +'   AND a.ORIGEN          = :Origen'
                    +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                    );
             ParamByName('Nemotecnico').AsString := trim(sNemotecnico);
             ParamByName('Fecha').AsDatetime     := dFecha;
             ParamByName('Origen').AsString      := trim(sOrigen);
             ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
             Open;
             if not eof then
             begin
                sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                Result         := True;
             end;
          end
          else
          begin
             if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) = '') then
             begin
                SQL.Clear;
                SQL.Add('SELECT a.CLASIF_SERIE '
                       +'      ,a.ORIGEN '
                       +'  FROM QS_FIN_CL_RIESGOS a '
                       +' WHERE a.NEMOTECNICO     = :Nemotecnico '
                       +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                       +'                              FROM QS_FIN_CL_RIESGOS b '
                       +'                             WHERE b.NEMOTECNICO     = a.NEMOTECNICO '
                       +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                       +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                       +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                       );
                ParamByName('Nemotecnico').AsString := trim(sNemotecnico);
                ParamByName('Fecha').AsDatetime     := dFecha;
                ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
                Open;
                if not eof then
                begin
                   sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                   sOrigen        := FieldByName('ORIGEN').AsString;
                   Result         := True;
                end;
             end
             else
             begin
                if (trim(sTipo_Clasif) = '') and (trim(sOrigen) <> '') then
                begin
                   SQL.Clear;
                   SQL.Add('SELECT a.CLASIF_SERIE '
                          +'      ,a.TIPO_CLASIF '
                          +'  FROM QS_FIN_CL_RIESGOS a '
                          +' WHERE a.NEMOTECNICO     = :Nemotecnico '
                          +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                          +'                              FROM QS_FIN_CL_RIESGOS b '
                          +'                             WHERE b.NEMOTECNICO     = a.NEMOTECNICO '
                          +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                          +'                               AND b.ORIGEN          = a.ORIGEN)'
                          +'   AND a.ORIGEN     = :Origen'
                          );
                   ParamByName('Nemotecnico').AsString := trim(sNemotecnico);
                   ParamByName('Fecha').AsDatetime     := dFecha;
                   ParamByName('Origen').AsString      := trim(sOrigen);
                   Open;
                   if not eof then
                   begin
                      sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                      sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                      Result         := True;
                   end;
                end
                else
                begin
                   SQL.Clear;
                   SQL.Add('SELECT a.CLASIF_SERIE '
                          +'      ,a.TIPO_CLASIF '
                          +'      ,a.ORIGEN '
                          +'  FROM QS_FIN_CL_RIESGOS a '
                          +' WHERE a.NEMOTECNICO     = :Nemotecnico '
                          +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                          +'                              FROM QS_FIN_CL_RIESGOS b '
                          +'                             WHERE b.NEMOTECNICO     = a.NEMOTECNICO '
                          +'                               AND b.F_CLASIF_SERIE <= :Fecha) '
                          );
                   ParamByName('Nemotecnico').AsString := trim(sNemotecnico);
                   ParamByName('Fecha').AsDatetime     := dFecha;
                   Open;
                   if not eof then
                   begin
                      sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                      sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                      sOrigen        := FieldByName('ORIGEN').AsString;
                      Result         := True;
                   end;
                end;
             end;
          end;
       end;
    end;

    //Busco Emisor, Instrumento, serie
    if Not Result then
    begin
      if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) <> '') then
      begin
         SQL.Clear;
         SQL.Add('SELECT a.CLASIF_SERIE '
                +'  FROM QS_FIN_CL_RIESGOS a '
                +' WHERE a.COD_EMP_SERIE   = :Emisor '
                +'   AND a.COD_INST_SERIE  = :Instrumento '
                +'   AND a.SERIE_CLASIF    = :Serie '
                +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                +'                              FROM QS_FIN_CL_RIESGOS b '
                +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                +'                               AND b.ORIGEN          = a.ORIGEN '
                +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                +'   AND a.ORIGEN          = :Origen'
                +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                );
         ParamByName('Emisor').AsString      := trim(sEmisor);
         ParamByName('Instrumento').AsString := trim(sInstrumento);
         ParamByName('Serie').AsString       := trim(sSerie);
         ParamByName('Fecha').AsDatetime     := dFecha;
         ParamByName('Origen').AsString      := trim(sOrigen);
         ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
         Open;
         if not eof then
         begin
            sClasificacion := FieldByName('CLASIF_SERIE').AsString;
            Result         := True;
         end;
      end
      else
      begin
        if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) = '') then
        begin
           SQL.Clear;
           SQL.Add('SELECT a.CLASIF_SERIE '
                  +'      ,a.ORIGEN '
                  +'  FROM QS_FIN_CL_RIESGOS a '
                  +' WHERE a.COD_EMP_SERIE   = :Emisor '
                  +'   AND a.COD_INST_SERIE  = :Instrumento '
                  +'   AND a.SERIE_CLASIF    = :Serie '
                  +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                  +'                              FROM QS_FIN_CL_RIESGOS b '
                  +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                  +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                  +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                  +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                  +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                  +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                  );
           ParamByName('Emisor').AsString      := trim(sEmisor);
           ParamByName('Instrumento').AsString := trim(sInstrumento);
           ParamByName('Serie').AsString       := trim(sSerie);
           ParamByName('Fecha').AsDatetime     := dFecha;
           ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
           Open;
           if not eof then
           begin
              sClasificacion := FieldByName('CLASIF_SERIE').AsString;
              sOrigen        := FieldByName('ORIGEN').AsString;
              Result         := True;
           end;
        end
        else
        begin
          if (trim(sTipo_Clasif) = '') and (trim(sOrigen) <> '') then
          begin
             SQL.Clear;
             SQL.Add('SELECT a.CLASIF_SERIE '
                    +'      ,a.TIPO_CLASIF '
                    +'  FROM QS_FIN_CL_RIESGOS a '
                    +' WHERE a.COD_EMP_SERIE   = :Emisor '
                    +'   AND a.COD_INST_SERIE  = :Instrumento '
                    +'   AND a.SERIE_CLASIF    = :Serie '
                    +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                    +'                              FROM QS_FIN_CL_RIESGOS b '
                    +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                    +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                    +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                    +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                    +'                               AND b.ORIGEN          = a.ORIGEN)'
                    +'   AND a.ORIGEN          = :Origen'
                    );
             ParamByName('Emisor').AsString      := trim(sEmisor);
             ParamByName('Instrumento').AsString := trim(sInstrumento);
             ParamByName('Serie').AsString       := trim(sSerie);
             ParamByName('Fecha').AsDatetime     := dFecha;
             ParamByName('Origen').AsString     := trim(sOrigen);
             Open;
             if not eof then
             begin
                sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                Result         := True;
             end;
          end
          else
          begin
             SQL.Clear;
             SQL.Add('SELECT a.CLASIF_SERIE '
                    +'      ,a.TIPO_CLASIF '
                    +'      ,a.ORIGEN '
                    +'  FROM QS_FIN_CL_RIESGOS a '
                    +' WHERE a.COD_EMP_SERIE   = :Emisor '
                    +'   AND a.COD_INST_SERIE  = :Instrumento '
                    +'   AND a.SERIE_CLASIF    = :Serie '
                    +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                    +'                              FROM QS_FIN_CL_RIESGOS b '
                    +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                    +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                    +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                    +'                               AND b.F_CLASIF_SERIE <= :Fecha) '
                    );
             ParamByName('Emisor').AsString      := trim(sEmisor);
             ParamByName('Instrumento').AsString := trim(sInstrumento);
             ParamByName('Serie').AsString       := trim(sSerie);
             ParamByName('Fecha').AsDatetime     := dFecha;
             Open;
             if not eof then
             begin
                sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                sOrigen        := FieldByName('ORIGEN').AsString;
                Result         := True;
             end;
          end;
        end;
      end;
    end;

    //Busco Emisor, Instrumento
    if Not Result then
    begin
       if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) <> '') then
       begin
          SQL.Clear;
          SQL.Add('SELECT a.CLASIF_SERIE '
                 +'  FROM QS_FIN_CL_RIESGOS a '
                 +' WHERE a.COD_EMP_SERIE   = :Emisor '
                 +'   AND a.COD_INST_SERIE  = :Instrumento '
                 +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                 +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                 +'                              FROM QS_FIN_CL_RIESGOS b '
                 +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                 +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                 +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                 +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                 +'                               AND b.ORIGEN          = a.ORIGEN '
                 +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                 +'   AND a.ORIGEN          = :Origen'
                 +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                 );
          ParamByName('Emisor').AsString      := trim(sEmisor);
          ParamByName('Instrumento').AsString := trim(sInstrumento);
          ParamByName('Fecha').AsDatetime     := dFecha;
          ParamByName('Origen').AsString      := trim(sOrigen);
          ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
          Open;
          if not eof then
          begin
             sClasificacion := FieldByName('CLASIF_SERIE').AsString;
             Result         := True;
          end;
       end
       else
       begin
          if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) = '') then
          begin
            SQL.Clear;
            SQL.Add('SELECT a.CLASIF_SERIE '
                   +'      ,a.ORIGEN '
                   +'  FROM QS_FIN_CL_RIESGOS a '
                   +' WHERE a.COD_EMP_SERIE   = :Emisor '
                   +'   AND a.COD_INST_SERIE  = :Instrumento '
                   +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                   +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                   +'                              FROM QS_FIN_CL_RIESGOS b '
                   +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                   +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                   +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                   +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                   +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                   +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                   );
            ParamByName('Emisor').AsString      := trim(sEmisor);
            ParamByName('Instrumento').AsString := trim(sInstrumento);
            ParamByName('Fecha').AsDatetime     := dFecha;
            ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
            Open;
            if not eof then
            begin
               sClasificacion := FieldByName('CLASIF_SERIE').AsString;
               sOrigen        := FieldByName('ORIGEN').AsString;
               Result         := True;
            end;
          end
          else
          begin
            if (trim(sTipo_Clasif) = '') and (trim(sOrigen) <> '') then
            begin
              SQL.Clear;
              SQL.Add('SELECT a.CLASIF_SERIE '
                     +'      ,a.TIPO_CLASIF '
                     +'  FROM QS_FIN_CL_RIESGOS a '
                     +' WHERE a.COD_EMP_SERIE   = :Emisor '
                     +'   AND a.COD_INST_SERIE  = :Instrumento '
                     +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                     +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                     +'                              FROM QS_FIN_CL_RIESGOS b '
                     +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                     +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                     +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                     +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                     +'                               AND b.ORIGEN          = a.ORIGEN)'
                     +'   AND a.ORIGEN          = :Origen'
                     );
              ParamByName('Emisor').AsString      := trim(sEmisor);
              ParamByName('Instrumento').AsString := trim(sInstrumento);
              ParamByName('Fecha').AsDatetime     := dFecha;
              ParamByName('Origen').AsString      := trim(sOrigen);
              Open;
              if not eof then
              begin
                 sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                 sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                 Result         := True;
              end;
            end
            else
            begin
              SQL.Clear;
              SQL.Add('SELECT a.CLASIF_SERIE '
                     +'      ,a.TIPO_CLASIF '
                     +'      ,a.ORIGEN '
                     +'  FROM QS_FIN_CL_RIESGOS a '
                     +' WHERE a.COD_EMP_SERIE   = :Emisor '
                     +'   AND a.COD_INST_SERIE  = :Instrumento '
                     +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                     +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                     +'                              FROM QS_FIN_CL_RIESGOS b '
                     +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                     +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                     +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                     +'                               AND b.F_CLASIF_SERIE <= :Fecha) '
                     );
              ParamByName('Emisor').AsString      := trim(sEmisor);
              ParamByName('Instrumento').AsString := trim(sInstrumento);
              ParamByName('Fecha').AsDatetime     := dFecha;
              Open;
              if not eof then
              begin
                 sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                 sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                 sOrigen        := FieldByName('ORIGEN').AsString;
                 Result         := True;
              end;
            end;
          end
       end;
    end;

    //Busco Emisor
    if Not Result then
    begin
       if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) <> '') then
       begin
         SQL.Clear;
         SQL.Add('SELECT a.CLASIF_SERIE '
                +'  FROM QS_FIN_CL_RIESGOS a '
                +' WHERE a.COD_EMP_SERIE   = :Emisor '
                +'   AND (a.COD_INST_SERIE is null OR a.COD_INST_SERIE = '''' OR a.COD_INST_SERIE = '' '') '
                +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                +'                              FROM QS_FIN_CL_RIESGOS b '
                +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                +'                               AND b.ORIGEN          = a.ORIGEN '
                +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                +'   AND a.ORIGEN          = :Origen'
                +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                );
         ParamByName('Emisor').AsString      := trim(sEmisor);
         ParamByName('Fecha').AsDatetime     := dFecha;
         ParamByName('Origen').AsString      := trim(sOrigen);
         ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
         Open;
         if not eof then
         begin
            sClasificacion := FieldByName('CLASIF_SERIE').AsString;
            Result         := True;
         end;
       end
       else
       begin
         if (trim(sTipo_Clasif) <> '') and (trim(sOrigen) = '') then
         begin
           SQL.Clear;
           SQL.Add('SELECT a.CLASIF_SERIE '
                  +'      ,a.ORIGEN '
                  +'  FROM QS_FIN_CL_RIESGOS a '
                  +' WHERE a.COD_EMP_SERIE   = :Emisor '
                  +'   AND (a.COD_INST_SERIE is null OR a.COD_INST_SERIE = '''' OR a.COD_INST_SERIE = '' '') '
                  +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                  +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                  +'                              FROM QS_FIN_CL_RIESGOS b '
                  +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                  +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                  +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                  +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                  +'                               AND b.TIPO_CLASIF     = a.TIPO_CLASIF)'
                  +'   AND a.TIPO_CLASIF     = :Tipo_Clasif'
                  );
           ParamByName('Emisor').AsString      := trim(sEmisor);
           ParamByName('Fecha').AsDatetime     := dFecha;
           ParamByName('Tipo_Clasif').AsString := trim(sTipo_Clasif);
           Open;
           if not eof then
           begin
              sClasificacion := FieldByName('CLASIF_SERIE').AsString;
              sOrigen        := FieldByName('ORIGEN').AsString;
              Result         := True;
           end;
         end
         else
         begin
           if (trim(sTipo_Clasif) = '') and (trim(sOrigen) <> '') then
           begin
             SQL.Clear;
             SQL.Add('SELECT a.CLASIF_SERIE '
                    +'      ,a.TIPO_CLASIF '
                    +'  FROM QS_FIN_CL_RIESGOS a '
                    +' WHERE a.COD_EMP_SERIE   = :Emisor '
                    +'   AND (a.COD_INST_SERIE is null OR a.COD_INST_SERIE = '''' OR a.COD_INST_SERIE = '' '') '
                    +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                    +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                    +'                              FROM QS_FIN_CL_RIESGOS b '
                    +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                    +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                    +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                    +'                               AND b.F_CLASIF_SERIE <= :Fecha '
                    +'                               AND b.ORIGEN          = a.ORIGEN)'
                    +'   AND a.ORIGEN     = :Origen'
                    );
             ParamByName('Emisor').AsString      := trim(sEmisor);
             ParamByName('Fecha').AsDatetime     := dFecha;
             ParamByName('Origen').AsString      := trim(sOrigen);
             Open;
             if not eof then
             begin
                sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                Result         := True;
             end;
           end
           else
           begin
             SQL.Clear;
             SQL.Add('SELECT a.CLASIF_SERIE '
                    +'      ,a.TIPO_CLASIF '
                    +'      ,a.ORIGEN '
                    +'  FROM QS_FIN_CL_RIESGOS a '
                    +' WHERE a.COD_EMP_SERIE   = :Emisor '
                    +'   AND (a.COD_INST_SERIE is null OR a.COD_INST_SERIE = '''' OR a.COD_INST_SERIE = '' '') '
                    +'   AND (a.SERIE_CLASIF is null OR a.SERIE_CLASIF = '''' OR a.SERIE_CLASIF = '' '') '
                    +'   AND a.F_CLASIF_SERIE  = (SELECT MAX(b.F_CLASIF_SERIE) '
                    +'                              FROM QS_FIN_CL_RIESGOS b '
                    +'                             WHERE b.COD_EMP_SERIE   = a.COD_EMP_SERIE '
                    +'                               AND b.COD_INST_SERIE  = a.COD_INST_SERIE '
                    +'                               AND b.SERIE_CLASIF    = a.SERIE_CLASIF '
                    +'                               AND b.F_CLASIF_SERIE <= :Fecha) '
                    );
             ParamByName('Emisor').AsString      := trim(sEmisor);
             ParamByName('Fecha').AsDatetime     := dFecha;
             Open;
             if not eof then
             begin
                sClasificacion := FieldByName('CLASIF_SERIE').AsString;
                sTipo_Clasif   := FieldByName('TIPO_CLASIF').AsString;
                sOrigen        := FieldByName('ORIGEN').AsString;
                Result         := True;
             end;
           end;
         end
       end;
    end;
  end;

  if Result then
     Busca_Datos_Clasif_Riesgo_Mem('' ,  // TIPO
                                   sClasificacion,
                                   fNro_Riesgo,
                                   fFactor_Riesgo,
                                   sTipo_Plazo,
                                   fValor_Nivel,
                                   fNivel);
end;

end.
