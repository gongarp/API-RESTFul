unit DMLeer_valor_Cambio;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DM_Variables_Valorizacion, DM_Variables_Menu, Variants,
  DM_FuncionesMemory, DM_Global_Var, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDM_Leer_Valor_Cambio = class(TDataModule)
    Qry_General: TFDQuery;
    FDTable1: TFDTable;
    Qry_leer_valor_cambio2_Moneda: TFDQuery;
    Qry_leer_valor_cambio2_Indice_Tasa: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

    function leer_fecha_periodo(sTipo_Unidad,
                                sUnidad,
                                sTipo_Variacion : String;
                                dfecha : TDatetime) : Boolean;

    procedure Leer_Valor_Indice(sIndice       :String;
                                dFecha        :TDateTime;
                            var fValorCambio  : Double;
                            var Result        : Boolean);

    function leer_valor_cambio_old(sMon_Origen,
                               sMon_Paridad,
                               sTipo_Paridad : String;
                               dfecha : TDatetime) : Boolean;

    function Leer_Param_Conver(Calculo,
                               Mon_Origen : String): String;


    procedure leer_valor_cambio2(sMon_Origen,
                                 sMon_Paridad,
                                 sTipo_Paridad : String;
                                 dfecha        : TDatetime;
                                 var fParidad  : Double;
                                 var Result    : Boolean);

   procedure leer_valor_formula(sCodigo_Tasa         : String;
                                dFecha_Vcto_Anterior : TDatetime;
                                dFecha_Vcto          : TDatetime;
                                sMetodo_Tasa_Referencia : String;
                                bResult_Cupon        : Boolean;
                                RegDes               : TReg_descriptor;
                                bConCupon            : Boolean;
                                dfecha_ref_Tasa      : TDatetime;
                                dFecha_Calculo       : TDatetime;
                                var sFormula         : String;
                                var fTasa_Resultado  : Double;
                                var Modulo_Err       : String;
                                var String_Err       : String;
                                var bResult          : Boolean);

   procedure leer_valor_cambio_con_tipo(sMon_Origen   : String;
                                        sMon_Paridad  : String;
                                        sTipo_Paridad : String;
                                        dfecha        : TDatetime;
                                        var fParidad  : Double;
                                        var sTipo     : String;
                                        var Result    : Boolean);

   procedure conversion_unidad_mon(sUniMon_origen,
                                   sUniMon_Resultado,
                                   sTipo_Cambio  : String;
                                   dfecha_cambio : TDateTime;
                                   dValor_origen : double;
                                   var dValor_Resultado : double;
                                   var Modulo_Err : String;
                                   var String_Err : String;
                                   var Result     : boolean);

  procedure Lee_Tasa_Tramos(RegParamMargen  : TRegParamMargen;
                            dFecha          : TDateTime;
                            iDiasDif        : Double;
                            bDia_Habil      : Boolean;
                            var fValor_Tasa_1 : Double;
                            var fValor_Tasa_2 : Double;
                            var sModulo_Err : String;
                            var sString_Err : String;
                            var Result      : Boolean);

  procedure Lee_Tasa_Tramos_Interpolacion(sCodigo_Tasa : string;
                                          dFecha          : TDateTime;
                                          fPlazo          : Double;
                                          var fValor_Tasa : Double;
                                          var sModulo_Err : String;
                                          var sString_Err : String;
                                          var Result      : Boolean);

  procedure Lee_Tasa_CapRes(sInstrumento      : String;
                            sMoneda           : String;
                            dFecha            : TDateTime;
                            fCapital_Residual : Double;
                            var fValor_Tasa_1 : Double;
                            var sModulo_Err   : String;
                            var sString_Err   : String;
                            var Result        : Boolean);

  procedure Lee_Valores_Tramos(RegParamMargen    : TRegParamMargen;
                               sTipo             : String;
                               sNemotecnico      : String;
                               dFecha            : TDateTime;
                               iDiasDif          : Double;
                               bDia_Habil        : Boolean;
                               var fValor_Tasa_1 : Double;
                               var fValor_Tasa_2 : Double;
                               var sModulo_Err   : String;
                               var sString_Err   : String;
                               var Result        : Boolean);

  procedure Moneda_Conversion_Avanzada( sSistema     : String;
                                        sProceso     : String;
                                        sInstrumento : String;
                                        sMoneda      : String;
                                        var sMoneda_Conversion : String);

  procedure conversion_unidad_mon_con_proyeccion( sUniMon_origen,
                                                  sUniMon_Resultado,
                                                  sTipo_Cambio  : String;
                                                  dfecha_cambio : TDateTime;
                                                  dValor_origen : double;
                                                  var dValor_Resultado : double;
                                                  var Modulo_Err : String;
                                                  var String_Err : String;
                                                  var Result     : boolean);


  procedure conversion_unidad_mon_con_Tipo(sUniMon_origen       : String;
                                           sUniMon_Resultado    : String;
                                           sTipo_Cambio         : String;
                                           dfecha_cambio        : TDateTime;
                                           dValor_origen        : double;
                                           var dValor_Resultado : double;
                                           var sTipo            : String;
                                           var Modulo_Err       : String;
                                           var String_Err       : String;
                                           var Result           : boolean);

  procedure Buscar_valor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                                const sTipo_Paridad   : String;
                                                const sMoneda_Paridad : String;
                                                const sTipo_Moneda    : String;
                                                dFecha_Paridad        : TDatetime;
                                                fdias                 : Double;
                                                var fValor            : Double;
                                                var bResult           : Boolean); overload

  procedure Buscar_valor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                                const sOrigen         : String;
                                                const sTipo_Paridad   : String;
                                                const sMoneda_Paridad : String;
                                                const sTipo_Moneda    : String;
                                                dFecha_Paridad        : TDatetime;
                                                fdias                 : Double;
                                                var fValor            : Double;
                                                var bResult           : Boolean); overload

  procedure Buscar_Lastvalor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                                    const sOrigen         : String;
                                                    const sTipo_Paridad   : String;
                                                    const sMoneda_Paridad : String;
                                                    const sTipo_Moneda    : String;
                                                    dFecha_Paridad        : TDatetime;
                                                    fdias                 : Double;
                                                    var fValor            : Double;
                                                    var bResult           : Boolean); overload

  procedure Buscar_Lastvalor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                                    const sTipo_Paridad   : String;
                                                    const sMoneda_Paridad : String;
                                                    const sTipo_Moneda    : String;
                                                    dFecha_Paridad        : TDatetime;
                                                    fdias                 : Double;
                                                    var fValor            : Double;
                                                    var bResult           : Boolean); overload

  procedure Proyecta_Valor_Indice_por_curvas( sCodigo_Indice   : String;
                                              dFecha_Calculo   : TDateTime;
                                              dFecha_Proyeccion      : TDateTime;
                                              var fValor_Proyectado  : Double;
                                              var sModulo_Err  : String;
                                              var sString_Err  : String;
                                              var bResult      : Boolean);

  procedure Carga_Reg_Monedas(sMon_Origen     : String;
                              sTipo_Paridad   : String;
                              sMon_Paridad    : String;
                              dfecha          : TDateTime;
                              fParidad        : Double);

procedure Determina_SOFR_COMP( sCodigo_Tasa         : String;
                               dFecha_Vcto_Anterior : TDatetime;
                               dFecha_Vcto          : TDatetime;
                               dFecha_Calculo       : TDateTime;
                               sCodigo_Indice       : String;
                               var fTasa_Resultado      : Double;
                               var sModulo_Err          : String;
                               var sString_Err          : String;
                               var bResult              : Boolean );

procedure leer_ultimo_valor_cambio(sMon_Origen   : String;
                                   sTipo_Paridad : String;
                                   sMon_Paridad  : String;
                                   dfecha        : TDatetime;
                                   var fParidad  : Double;
                                   var Result    : Boolean);

var
  DM_Leer_Valor_Cambio : TDM_Leer_Valor_Cambio;
  dfecha_periodo       : TDatetime;
  fValor_Cambio        : double;
  re_llamado           : boolean;

implementation
uses DM_Comun
    ,DM_ComunInversiones
    ,DM_Codigos_generales
    ,dm_Base_Datos
    ,DateUtils
    ,Tabla_Mem_Desarr_TFija;


{$R *.DFM}
constructor TDM_Leer_Valor_Cambio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Qry_General.ConnectionName := 'PMSSERVER';
  Qry_leer_valor_cambio2_Moneda.ConnectionName := 'PMSSERVER';
  Qry_leer_valor_cambio2_Indice_Tasa.ConnectionName := 'PMSSERVER';
end;
function leer_fecha_periodo(sTipo_Unidad,
                            sUnidad,
                            sTipo_Variacion : String;
                            dfecha : TDatetime) : Boolean;
var
  wdia,
  wMes,
  wano : Word;
  wDia_Referencia,
  wMes_Referencia : Word;

begin
  Result := True;
  decodedate(dfecha,wano,wMes,wdia);
  if sTipo_Variacion = 'A' then  {Periodo en el año}
    begin
     With DM_Leer_Valor_Cambio.QRY_General do
      begin
        SQL.Clear;
        SQL.Add('SELECT MAX(Mes_Referencia) As Mes_Referencia'
               +'  FROM QS_SYS_PERIODO_DET'
               +' WHERE Tipo_Unidad = '''+sTipo_Unidad+''''
               +'   AND Unidad      = '''+sUnidad+''''
               +'   AND Mes_Referencia < '+inttostr(wMes)
               );
        Prepare;
        Open;

        if FieldByName('Mes_Referencia').Isnull then
           wMes_Referencia := 0
        else
           wMes_Referencia := FieldByName('Mes_Referencia').AsInteger;
        Close;
        UnPrepare;
      end;

     if wMes_Referencia = 0 then
       begin
         With DM_Leer_Valor_Cambio.QRY_General do
           begin   {Si no hay meses antes busco el ultimo periodo del año anterior}
             wano := wano - 1;
             SQL.Clear;
             SQL.Add('SELECT MAX(Mes_Referencia) As Mes_Referencia'
                    +'  FROM QS_SYS_PERIODO_DET'
                    +' WHERE Tipo_Unidad = '''+sTipo_Unidad+''''
                    +'   AND Unidad      = '''+sUnidad+''''
                    );
             Prepare;
             Open;

             if FieldByName('Mes_Referencia').Isnull then
                wMes_Referencia := 0
             else
                wMes_Referencia := FieldByName('Mes_Referencia').AsInteger;
             Close;
             UnPrepare;
           end;
           if wMes_Referencia = 0 then
              begin
                Result := False;
                exit;
              end;
       end;
       {Busco dia de Referencia}

     WITH DM_Leer_Valor_Cambio.QRY_General do
       begin
         SQL.Clear;
         SQL.Add('SELECT MAX(Dia_Referencia) As Dia_Referencia'
                +'  FROM QS_SYS_PERIODO_DET'
                +' WHERE Tipo_Unidad = '''+sTipo_Unidad+''''
                +'   AND Unidad      = '''+sUnidad+''''
                +'   AND Mes_Referencia = '+inttostr(wMes_Referencia)
                );
         Prepare;
         Open;

         if FieldByName('Dia_Referencia').Isnull then
            wdia_Referencia := 0
         else
            wdia_Referencia := FieldByName('Dia_Referencia').AsInteger;
         Close;
         UnPrepare;
       end;
     if wdia_Referencia = 0 then
       begin
        Result := False;
        exit;
       end;

     if wDia_Referencia > ultimo_dia_mes(wmes_Referencia,wano) then
        wDia_Referencia := ultimo_dia_mes(wmes_Referencia,wano);

     dFecha_Periodo := encodedate(wano,wMes_Referencia,wDia_Referencia);
     if (wMes_Referencia = 2) and (wDia_Referencia = 28) then
        if IsInLeapYear(dFecha_Periodo) then
          dFecha_Periodo := dFecha_Periodo + 1;

     exit;
    end;

  {Por Tipo Variacion M (en el mes)}

  WITH DM_Leer_Valor_Cambio.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT MAX(Dia_Referencia) AS Dia_Referencia'
             +'  FROM QS_SYS_PERIODO_DET'
             +' WHERE Tipo_Unidad = '''+sTipo_Unidad+''''
             +'   AND Unidad      = '''+sUnidad+''''
             +'   AND Dia_Referencia < '+inttostr(wdia)
             );
      Prepare;
      Open;

      if FieldByName('Dia_Referencia').Isnull then
         wDia_Referencia := 0
      else
         wDia_Referencia := FieldByName('Dia_Referencia').AsInteger;
      Close;
      UnPrepare;
    end;

    if wDia_Referencia = 0 then
       begin
         wmes := wmes - 1;
         if wmes < 1 then
            begin
              wmes := 12;
              wano := wano - 1;
            end;
         WITH DM_Leer_Valor_Cambio.QRY_General do
           begin
             SQL.Clear;
             SQL.Add('SELECT MAX(Dia_Referencia) AS Dia_Referencia'
                    +'  FROM QS_SYS_PERIODO_DET'
                    +' WHERE Tipo_Unidad = '''+sTipo_Unidad+''''
                    +'   AND Unidad      = '''+sUnidad+''''
                    );
             Prepare;
             Open;

             if FieldByName('Dia_Referencia').Isnull then
               wDia_Referencia := 0
             else
               wDia_Referencia := FieldByName('Dia_Referencia').AsInteger;
             Close;
             UnPrepare;
           end;
           if wDia_Referencia = 0 then
              begin
                Result := False;
                Exit;
              end;
       end;

    if wDia_Referencia > ultimo_dia_mes(wMes,wano) then
       wDia_Referencia := ultimo_dia_mes(wMes,wano);

     dFecha_Periodo := encodedate(wano,wMes,wDia_Referencia);
end;

{Funcion valor de cambio devuelve el resultado en variable global fValor_Cambio}
function leer_valor_cambio_old(sMon_Origen,
                               sMon_Paridad,
                               sTipo_Paridad : String;
                               dfecha : TDatetime): Boolean;
var
 sTipo_Moneda,
 sTipo_Unidad,
 sUnidad,
 sTipo_Variacion : String;
 swhere_part     : string;
 aux_pchar : Array[0..250] of Char;

begin
  Result := True;

  Busca_Valores_Monedas_Periodo_Mem(sMon_Origen,
                                    sMon_Origen,
                                    sTipo_Moneda,
                                    sTipo_Unidad,
                                    sUnidad,
                                    sTipo_Variacion
                                   );
  {
  WITH DM_Leer_Valor_Cambio.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Tipo_moneda As Tipo_Moneda'
             +'      ,b.Tipo_Unidad As Tipo_Unidad'
             +'      ,b.Unidad      As Unidad'
             +'      ,b.Tipo_Variacion As Tipo_Variacion'
             +'  FROM QS_SYS_MONEDAS a'
             +'      ,QS_SYS_PERIODO b'
             +' WHERE a.Cod_Moneda         = :Moneda_origen'
             +'   AND a.Tipo_Uni_Variacion = b.Tipo_Unidad'
             +'   AND a.Unidad_Medida_Mon  = b.Unidad'
             );
      Prepare;
      ParamByName('Moneda_origen').AsString := sMon_Origen;
      Open;

      sTipo_Moneda    := FieldByName('Tipo_Moneda').AsString;
      sTipo_Unidad    := FieldByName('Tipo_Unidad').AsString;
      sUnidad         := FieldByName('Unidad').AsString;
      sTipo_Variacion := FieldByName('Tipo_Variacion').AsString;

      Close;
      UnPrepare;
    end;
    }
    if (sTipo_Moneda = 'M') and
       (sMon_Origen  = sMon_Paridad) then
       begin
         fValor_Cambio := 1;
         exit;
       end;


    if sTipo_Variacion <> 'D' then
       {Busco la fecha de paridad}
       begin
       if NOT leer_fecha_periodo(sTipo_Unidad
                            ,sUnidad
                            ,sTipo_Variacion
                            ,dfecha) then
          begin
             strpcopy(aux_pchar
                     ,'Error en definición de período para: '''+sMon_Origen+''''
                     +#10'con fecha: '+datetostr(dfecha_Periodo));

             Application.MessageBox(aux_pchar
                                  ,'Valor Paridad'
                                  ,mb_OK);

            Result := False;
            exit;
          end;
       end
    else
       dfecha_Periodo := dfecha;

    {Busco Paridad}

    swhere_part := ' WHERE Cod_moneda      = '''+sMon_Origen+''''
                 +'   AND Tipo_De_Paridad = '''+sTipo_Paridad+'''';

    if sTipo_Moneda = 'M' then
       swhere_part := swhere_part
                  +' AND Moneda_Paridad = '''+sMon_Paridad+'''';

    with DM_Leer_Valor_Cambio.QRY_General do
      begin
        SQL.Clear;
        SQL.Add('SELECT Valor_Moneda As Valor_Moneda'
               +'  FROM QS_SYS_VAL_CAMBIO'
               +swhere_part
               +' AND Fecha_Paridad = :pfecha'
               );

        ParamByName('pfecha').AsDate := dfecha_Periodo;

        Prepare;
        Open;
        if (FieldByName('Valor_Moneda').IsNull) or
           (FieldByName('Valor_Moneda').Asfloat = 0) then
          begin
          {Busco a reves (solo una vez por re_llamado}
           if (sTipo_Moneda = 'M') and NOT re_llamado then
              begin
                re_llamado := True;
                if NOT leer_valor_cambio_old(sMon_Paridad,
                                             sMon_Origen,
                                             sTipo_Paridad,
                                             dfecha) then
                   Result := False
                else
                   if fValor_Cambio <> 0 then
                      fValor_Cambio := 1 / fValor_Cambio
                   else
                      fValor_Cambio := 0;
                re_llamado := False;
              end
           else
              begin
                Result := False;
                fValor_Cambio := 0;
              end
          end
        else
           begin
             fValor_Cambio := FieldByName('Valor_Moneda').AsFloat;
           end;

        if (sTipo_Moneda = 'M') AND
           (fValor_Cambio = 0)        then
            Result := False;
        Close;
        UnPrepare;
      end;
{
  if NOT Result then
    begin
        strpcopy(aux_pchar,
                'No se encontro conversión'#10
               +'de '+sMon_Origen+' a '+sMon_Paridad+''#10
               +'con fecha: '+datetostr(dfecha)
               );

       Application.MessageBox(aux_Pchar
                            ,'Valor de Cambio'
                            ,mb_Ok);
     end;
}
end;


function Leer_Param_Conver(Calculo,
                           Mon_Origen
                            : String): String;

begin
Leer_Param_Conver := '';
  WITH DM_Leer_Valor_Cambio.QRY_General do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Indice_Conversion'
             +'  FROM QS_CON_PARAM_CONVER a'
             +' WHERE a.Calculo   = :Calculo'
            +'   AND a.Moneda_Origen = :Moneda_Origen'
             );
      Prepare;
      ParamByName('Calculo').AsString := Calculo;
      ParamByName('Moneda_Origen').AsString := Mon_Origen;

      Open;

      if not eof then
         Leer_Param_Conver := FieldByName('Indice_Conversion').AsString;

      Close;
      UnPrepare;
    end;

end;

procedure Determina_SOFR_COMP( sCodigo_Tasa         : String;
                               dFecha_Vcto_Anterior : TDatetime;
                               dFecha_Vcto          : TDatetime;
                               dFecha_Calculo       : TDateTime;
                               sCodigo_Indice       : String;
                               var fTasa_Resultado      : Double;
                               var sModulo_Err          : String;
                               var sString_Err          : String;
                               var bResult              : Boolean );
var
  dFecha_inicio, sFecha_Fin : TDateTime;
  sPais_Tasa : String;
  fValor_Indice_Inicio : Double;
  fValor_Indice_Fin : Double;

  iBaseTasa        : integer;
  sTipoInteres     : string;
  iBaseMensual     : integer;
  sTipoCalculoDias : String;
  iVigenciaValor   : Integer;
  iVigencia_Meses  : Integer;

  iDiasDif         : Double;
  iAnosEnteros     : Double;
  iAnosFraccion    : Double;
  iMesesEnteros    : Double;

  begin
     bResult := True;
     if (dFecha_Vcto_Anterior > dFecha_Calculo) then
     begin
        fTasa_Resultado := -999;  // Valor tasa -999 lo usamos para identificar caso
                                             // que debe proyectar valor tasa que no se pudo calcular.      bResult := False;
        exit;
     end;

     dFecha_inicio := dFecha_Vcto_Anterior;
     sFecha_Fin    := dFecha_Vcto;

     if (dFecha_Calculo < dFecha_Vcto)  then
        sFecha_Fin := dFecha_Calculo;

     // 2 dias habiles antes

     Pais_MonInd_Mem(sCodigo_Indice
                    ,sPais_Tasa
                    ,sModulo_Err
                    ,sString_Err
                    ,bResult);

     if NOT bResult then
     begin
       sModulo_Err := 'Determina Tasa SOFR_COMP';
       sString_Err := 'No se pudo obtener país para indice '''+sCodigo_Indice+'''';
       exit;
     end;

     dFecha_inicio := dFecha_inicio - 2;
     While (Feriado_Mem(sPais_Tasa,dFecha_inicio)  or
           (DayOfWeek(dFecha_inicio) in [1,7])) do
             dFecha_inicio := dFecha_inicio - 1;

     sFecha_Fin := sFecha_Fin - 2;
     While (Feriado_Mem(sPais_Tasa,sFecha_Fin)  or  (DayOfWeek(sFecha_Fin) in [1,7])) do
             sFecha_Fin := sFecha_Fin - 1;

     leer_valor_cambio2( sCodigo_Indice
                        ,sCodigo_Indice
                        ,'BC'
                        ,dfecha_Inicio
                        ,fValor_Indice_Inicio
                        ,bResult);

      if not bResult then
      begin
         sModulo_Err := 'Determina Tasa SOFR_COMP';
         sString_Err := 'No se encontró valor para '''+sCodigo_Indice+''''
                       +'. Con Fecha :'+DateToStr(dfecha_Inicio);
         exit;
      end;

      if (fValor_Indice_Inicio = 0)  then
      begin
         sModulo_Err := 'Determina Tasa SOFR_COMP';
         sString_Err := 'Valor para '''+sCodigo_Indice+''''
                       +'. Al inicio de periodo '+DateToStr(dfecha_Inicio)
                       +' no puede ser cero';
         bResult := False;
         exit;
      end;

     leer_valor_cambio2( sCodigo_Indice
                        ,sCodigo_Indice
                        ,'BC'
                        ,sFecha_Fin
                        ,fValor_Indice_Fin
                        ,bResult);
         if not bResult then
         begin
             sModulo_Err := 'Determina Tasa SOFR_COMP';
             sString_Err := 'No se encontró valor para '''+sCodigo_Indice+''''
                       +'. Con Fecha :'+DateToStr(sFecha_Fin);
              exit;
         end;


         Obtener_Tasa_base_Memory( sCodigo_Tasa
                                  ,iBaseTasa
                                  ,sTipoInteres
                                  ,iBaseMensual
                                  ,sTipoCalculoDias
                                  ,iVigenciaValor
                                  ,iVigencia_Meses
                                  ,sModulo_err
                                  ,sString_err
                                  ,bResult);
         if not bResult then
            exit;

         Calculo_de_dias( dFecha_inicio
                         ,sFecha_Fin
                         ,sTipoCalculoDias
                         ,sPais_Tasa
                         ,iDiasDif
                         ,iAnosEnteros
                         ,iAnosFraccion
                         ,iMesesEnteros);

     fTasa_Resultado := (fValor_Indice_Fin /
                         fValor_Indice_Inicio) - 1;

     fTasa_Resultado := fTasa_Resultado * 100 * iBaseTasa / iDiasDif;

  end;

// Este procedimiento debe tender a reemplazar la funcion leer_valor_cambio
// ya que devuelve la paridad como PARAMETRO y no en VARIABLE GLOBAL
procedure leer_valor_cambio2(sMon_Origen,
                             sMon_Paridad,
                             sTipo_Paridad : String;
                             dfecha        : TDatetime;
                             var fParidad  : Double;
                             var Result    : Boolean);
var
 sTipo_Moneda,
 sTipo_Unidad,
 sUnidad,
 sUnidad_Conversion,
 sTipo_Variacion  : string;
 aux_pchar        : Array[0..250] of Char;
 i                : Integer;

 xCOD_MONEDA     : string;
 xTIPO_DE_PARIDAD: string;
 xMONEDA_PARIDAD : string;
 xFECHA_PARIDAD  : TDateTime;


begin
    // Verifico si existe un tipo de cambio definido por quien lo llama
    // Caso de utilizar tipo de cambio ingresado en la Operacion
    Buscar_Tipo_Cambio_Fijo_Mem( sMon_Origen
                                ,sMon_Paridad
                                ,sTipo_Paridad
                                ,dfecha
                                ,fParidad
                                ,Result);
    // Si encontro tipo de cambio fijo lo devuelve !!!!
    if Result then
       exit;

    Result := True;
     Busca_Valores_Monedas_Periodo_Mem( sMon_Origen,
                                     sUnidad_Conversion,
                                     sTipo_Moneda,
                                     sTipo_Unidad,
                                     sUnidad,
                                     sTipo_Variacion
                                   );
    if (sTipo_Moneda = 'M') and
       (sMon_Origen  = sMon_Paridad) then
    begin
       Result   := true;  //ES GG  15-01-2018
       fParidad := 1;
       exit;
    end;

    if sValorizacion_Proceso =  'SI' then
    begin
       if NOT VarIsArray(Reg_Monedas.COD_MONEDA) then
       begin
          i := 0;
          Reg_Monedas.COD_MONEDA      := VarArrayCreate([0, i], varOleStr);
          Reg_Monedas.TIPO_DE_PARIDAD := VarArrayCreate([0, i], varOleStr);
          Reg_Monedas.MONEDA_PARIDAD  := VarArrayCreate([0, i], varOleStr);
          Reg_Monedas.FECHA_PARIDAD   := VarArrayCreate([0, i], varDate);
          Reg_Monedas.VALOR_MONEDA    := VarArrayCreate([0, i], varDouble);
          Reg_Monedas.TIPO            := VarArrayCreate([0, i], varOleStr);
       end
       else
       begin
           // For i := 0 to VarArrayHighBound(Reg_Monedas.COD_MONEDA, 1 ) do
           For i := 0 to VarArrayHighBound(Reg_Monedas.COD_MONEDA, 1 ) do
           begin
              xCOD_MONEDA     := Reg_Monedas.COD_MONEDA[i]      ;
              xTIPO_DE_PARIDAD:= Reg_Monedas.TIPO_DE_PARIDAD[i] ;
              xMONEDA_PARIDAD := Reg_Monedas.MONEDA_PARIDAD[i]  ;
              xFECHA_PARIDAD  := Reg_Monedas.FECHA_PARIDAD[i]   ;

              if (sTipo_Moneda = 'M') then
              begin
                  if (xCOD_MONEDA      = sMon_Origen)   and
                     (xTIPO_DE_PARIDAD = sTipo_Paridad) and
                     (xMONEDA_PARIDAD  = sMon_Paridad)  and
                     (xFECHA_PARIDAD   = dfecha)  then
                  begin
                      fParidad  := Reg_Monedas.VALOR_MONEDA[i] ;
                      Result    := True;
                      Exit;
                  end;
              end
              else
              begin
                  if (xCOD_MONEDA      = sMon_Origen)   and
                     (xTIPO_DE_PARIDAD = sTipo_Paridad) and
                     (xFECHA_PARIDAD   = dfecha)  then
                  begin
                      fParidad  := Reg_Monedas.VALOR_MONEDA[i] ;
                      Result    := True;
                      Exit;
                  end;
              end;

           end;
       end;
    end;

    if sTipo_Variacion <> 'D' then
       {Busco la fecha de paridad}
       begin
       if NOT leer_fecha_periodo(sTipo_Unidad
                                ,sUnidad
                                ,sTipo_Variacion
                                ,dfecha) then
          begin
             strpcopy(aux_pchar
                     ,'Error en definición de período para : '''+sMon_Origen+''''
                     +#10'con fecha: '+datetostr(dfecha));

             Application.MessageBox(aux_pchar
                                  ,'Valor Paridad'
                                  ,mb_OK);

            Result := False;
            exit;
          end;
       end
    else
       dfecha_Periodo := dfecha;

    {Busco Paridad}
      if (sTipo_Moneda = 'M') then
      begin
        with DM_Leer_Valor_Cambio.Qry_leer_valor_cambio2_Moneda do
        begin
//          SQL.Clear;
//          SQL.Add( 'SELECT Valor_Moneda As Valor_Moneda '
//                  +' FROM QS_SYS_VAL_CAMBIO '
//                  +' WHERE Fecha_Paridad  = :pfecha '
//                  +' AND  Cod_moneda      = :cod_moneda '
//                  +' AND  Tipo_De_Paridad = :tipo_paridad'
//                  +' AND Moneda_Paridad   = :mon_paridad  ');

          ParamByName('pfecha').AsDate:= dfecha_Periodo;
          ParamByName('cod_Moneda').AsString   := sMon_Origen;
          ParamByName('tipo_paridad').AsString := sTipo_Paridad;
          ParamByName('mon_paridad').AsString   := sMon_Paridad;

          Prepare;
          Open;
          if (FieldByName('Valor_Moneda').IsNull) or
             (FieldByName('Valor_Moneda').Asfloat = 0) then
            begin
               {Busco a reves (solo una vez por re_llamado}
               if NOT re_llamado then
               begin
                 re_llamado := True;
                 DM_Leer_Valor_Cambio.Qry_leer_valor_cambio2_Moneda.Close;
                 leer_valor_cambio2(sMon_Paridad,
                                    sMon_Origen,
                                    sTipo_Paridad,
                                    dfecha,
                                    fParidad,
                                    Result);
                 if Result then
                    if fParidad <> 0 then
                       fParidad := 1 / fParidad
                    else
                       fParidad := 0;
                 re_llamado := False;
               end
              else
                begin
                  Result := False;
                  fParidad := 0;
                end
           end
         else
            fParidad := FieldByName('Valor_Moneda').AsFloat;

          if (fParidad = 0)        then
              Result := False;
          DM_Leer_Valor_Cambio.Qry_leer_valor_cambio2_Moneda.Close;
        end
      end
      else
      begin
          with DM_Leer_Valor_Cambio.Qry_leer_valor_cambio2_Indice_Tasa do
          begin
    //        SQL.Clear;
    //        SQL.Add('SELECT Valor_Moneda As Valor_Moneda'
    //               +'  FROM QS_SYS_VAL_CAMBIO'
//                   +' WHERE Fecha_Paridad = :pfecha'
//                   +'   AND  Cod_moneda      = '''+sMon_Origen+''''
//                   +'   AND  Tipo_De_Paridad = '''+sTipo_Paridad+'''';
    //               );

            ParamByName('pfecha').AsDate:= dfecha_Periodo;
            ParamByName('cod_Moneda').AsString   := sMon_Origen;
            ParamByName('tipo_paridad').AsString := sTipo_Paridad;

            //Prepare;
            Open;
            if (FieldByName('Valor_Moneda').IsNull) then  // solo debe validar si no existe registro, valor 0 puede ser válido
            begin
              Result := False;
              fParidad := 0;
            end
            else
              fParidad := FieldByName('Valor_Moneda').AsFloat;
            DM_Leer_Valor_Cambio.Qry_leer_valor_cambio2_Indice_Tasa.Close;
          end;
      end;


    if sValorizacion_Proceso =  'SI' then
       if Result then
       begin
           Carga_Reg_Monedas(sMon_Origen
                            ,sTipo_Paridad
                            ,sMon_Paridad
                            ,dfecha
                            ,fParidad);
//           VarArrayRedim(Reg_Monedas.COD_MONEDA      , i );
//           VarArrayRedim(Reg_Monedas.TIPO_DE_PARIDAD , i );
//           VarArrayRedim(Reg_Monedas.MONEDA_PARIDAD  , i );
//           VarArrayRedim(Reg_Monedas.FECHA_PARIDAD   , i );
//           VarArrayRedim(Reg_Monedas.VALOR_MONEDA    , i );
//           VarArrayRedim(Reg_Monedas.TIPO            , i );
//
//           Reg_Monedas.COD_MONEDA[i]     := sMon_Origen;
//           Reg_Monedas.TIPO_DE_PARIDAD[i]:= sTipo_Paridad;
//           Reg_Monedas.MONEDA_PARIDAD[i] := sMon_Paridad;
//           Reg_Monedas.FECHA_PARIDAD[i]  := dfecha;
//           Reg_Monedas.VALOR_MONEDA[i]   := fParidad;
//           Reg_Monedas.TIPO[i]           := '';
       end;
end;

procedure Carga_Reg_Monedas(sMon_Origen     : String;
                            sTipo_Paridad   : String;
                            sMon_Paridad    : String;
                            dfecha          : TDateTime;
                            fParidad        : Double);
var
   i : Integer;
begin
           i:= VarArrayHighBound(Reg_Monedas.COD_MONEDA,1)+1;
           VarArrayRedim(Reg_Monedas.COD_MONEDA      , i );
           VarArrayRedim(Reg_Monedas.TIPO_DE_PARIDAD , i );
           VarArrayRedim(Reg_Monedas.MONEDA_PARIDAD  , i );
           VarArrayRedim(Reg_Monedas.FECHA_PARIDAD   , i );
           VarArrayRedim(Reg_Monedas.VALOR_MONEDA    , i );
           VarArrayRedim(Reg_Monedas.TIPO            , i );

           Reg_Monedas.COD_MONEDA[i]     := sMon_Origen;
           Reg_Monedas.TIPO_DE_PARIDAD[i]:= sTipo_Paridad;
           Reg_Monedas.MONEDA_PARIDAD[i] := sMon_Paridad;
           Reg_Monedas.FECHA_PARIDAD[i]  := dfecha;
           Reg_Monedas.VALOR_MONEDA[i]   := fParidad;
           Reg_Monedas.TIPO[i]           := '';
  end;

procedure leer_valor_formula(sCodigo_Tasa         : String;
                             dFecha_Vcto_Anterior : TDatetime;
                             dFecha_Vcto          : TDatetime;
                             sMetodo_Tasa_Referencia : String;
                             bResult_Cupon        : Boolean;
                             RegDes               : TReg_descriptor;
                             bConCupon            : Boolean;
                             dfecha_ref_Tasa      : TDatetime;
                             dFecha_Calculo       : TDatetime;
                             var sFormula         : String;
                             var fTasa_Resultado  : Double;
                             var Modulo_Err       : String;
                             var String_Err       : String;
                             var bResult           : Boolean);

var iDiasBase               : Integer;
    sTipoInteres            : String;
    iBaseMensual            : Integer;
    sTipoCalculoDias        : String;
    iVigenciaValor          : Integer;
    iVigenciaMeses          : Integer;
    sPais_Tasa              : String;
    dFecha_Inicio           : TDatetime;
    dFecha_Termino           : TDatetime;

    fICP_Inicio             : Double;
    fICP_Termino            : Double;
    fDias                   : Double;
    fUF0                    : Double;
    fUF1                    : Double;
    fTNA                    : Double;

    dT0                     : TdateTime;
    dTi                     : TdateTime;
    dTi_1                   : TdateTime;

    fICP0                    : Double;
    fICPi                    : Double;
    fICPi_1                  : Double;

begin
   fTasa_Resultado := 0;
   bResult := false;

   try
      Busca_Formula_Tasas_Mem(dFecha_Calculo
                             ,sCodigo_Tasa
                             ,sFormula
                             ,bResult);
      if not bResult then
         sFormula := '';
   except
      sFormula := '';
   end;

   if (sFormula = '') then  // Esta volviendo con Result True, ya que el que lo llama controla por formula blanco si debe leer tasas directo y no calcularlas
   begin
      bResult := True;
      exit;
   end;

   dFecha_inicio  := dFecha_Vcto_Anterior;

   // CALCULO CON VARIACION DE SOFRINDX 02-2023 F.I.
   if (sFormula = 'SOFR COMP')  then
   begin
     Determina_SOFR_COMP( sCodigo_Tasa
                         ,dFecha_Vcto_Anterior
                         ,dFecha_Vcto
                         ,dFecha_Calculo
                         ,'SOFRINDX'  // Código del indice para determinar la variacion
                         ,fTasa_Resultado
                         ,Modulo_Err
                         ,String_Err
                         ,bResult        );
     exit;
   end;


   // Para los calculos con formula para ICP la definición de tratamiento de fechas en la tabla debe ser VAFECA
   // Para ya que se valida que hasta esa fecha existan valores ...

   if (sFormula = 'ICP')    or
      (sFormula = 'ICP-UF') then
   begin
      // Nunca deberia llegar aqui con una fecha de inicio > a la fecha de calculo
      if (dFecha_Inicio > dFecha_Calculo) then
      begin
         Modulo_Err := 'Obtención de Valores Tasa con formula';
         String_Err := 'No se puede calcular tasa para flujo que vence el '+DateToStr(dFecha_Vcto)+' Inicio flujo mayor que el calculo';
         exit;
      end;

      leer_valor_cambio2('ICP'
                        ,'ICP'
                        ,'BC'
                        ,dfecha_Inicio
                        ,fICP_Inicio
                        ,bResult);
      if not bResult then
      begin
         Modulo_Err := 'Obtención de Valores Tasa con formula';
         String_Err := 'No se encontro Valor para ICP'
                       +'. Con Fecha :'+DateToStr(dfecha_Inicio);
         exit;
      end;


      // Hasta ahora la proyeccion del valor final del indice se hacia simplemente a la fecha de calculo /dfecha_ref_Tasa viene el calor correspondiente a VAFECA
      if dFecha_Vcto > dFecha_Calculo then
      begin
         // Si la fecha es posterior al calculo debe proyectar !!!! (Caso en que estan ejecutando valorizaciones hacia atras...
         // La proyeccion simple usa el valor del dia del calculo (Que debe ser conocido) Si no con curvas estima un valor a la fecha futura


         // 19-08-2020
         // Se acuerda que para los dias inhabiles se utilizaran los valores del día habil siguiente,
         // lo anterior
         While (Feriado_Mem(sPais_Usuario,dFecha_Calculo)  or  (DayOfWeek(dFecha_Calculo) in [1,7])) do
               dFecha_Calculo := dFecha_Calculo + 1;

         leer_valor_cambio2('ICP'
                           ,'ICP'
                           ,'BC'
                           ,dFecha_Calculo
                           ,fICP_Termino
                           ,bResult);
         if not bResult then
         begin
            Modulo_Err := 'Obtención de Valores Tasa con formula';
            String_Err := 'No se encontro valor para ICP con fecha :'+DateToStr(dFecha_Calculo);
            exit;
         end;

         if sMetodo_Tasa_Referencia = 'CURVAS' then   // Se proyecta el valor del ICP (Solo lo uso alguna ves BTG)
                                                      // a partir del de la fecha de calculo
         begin
            Proyecta_Valor_Indice_por_curvas( 'ICP'
                                             ,dFecha_Calculo
                                             ,dFecha_Vcto
                                             ,fICP_Termino
                                             ,Modulo_Err
                                             ,String_Err
                                             ,bResult);
            if NOT bResult then
               exit;
            dFecha_Termino := dFecha_Vcto;
         end
         else
            dFecha_Termino := dFecha_Calculo;
      end
      else   // Fecha de vencimiento es menor a la fecha de calaculo asi que se tienen que tener los valores
      begin
        dFecha_Termino := dFecha_Vcto;
        leer_valor_cambio2('ICP'
                          ,'ICP'
                          ,'BC'
                          ,dFecha_Termino
                          ,fICP_Termino
                          ,bResult);
        if not bResult then
        begin
           Modulo_Err := 'Obtención de Valores Tasa con formula';
           String_Err := 'No se encontro Valor para ICP'
                         +'. Con Fecha :'+DateToStr(dfecha_Termino);
           exit;
        end;
      end;

      fDias := dFecha_Termino - dFecha_Inicio;

      if fDias > 0 then
      begin
          Obtener_Tasa_base_Mem(sCodigo_Tasa
                               ,iDiasBase
                               ,sTipoInteres
                               ,iBaseMensual
                               ,sTipoCalculoDias
                               ,iVigenciaValor
                               ,iVigenciaMeses
                               ,sPais_Tasa
                               ,Modulo_err
                               ,String_err
                               ,bResult);

         if NOT bResult then
         begin
            Modulo_Err := 'Obtención de Valores Tasa con formula';
            String_Err := 'No se encontro Definición Tasa Base para '+sCodigo_Tasa;
            exit;
         end;

         if fICP_Inicio = 0 then
         begin
           fTasa_Resultado := 0;
           Modulo_Err := 'Obtención de Valores Tasa con formula';
           String_Err := 'Valor para ICP inicial no puede ser cero.'
                         +' Con Fecha: '+DateToStr(fICP_Inicio);
           exit;
         end
         else
           fTNA := ((fICP_Termino / fICP_Inicio) - 1) * (iDiasBase / fDias);

         fTasa_Resultado := fTNA * 100;   // <-- Hay que dejarlo paranetrico y cambiar el 100 por la base porcentual de la definion para la TNA.
         fTNA := Redondeo(fTNA, 4);    // Esto es para que se vaya redondeado a la funcon de ICP-UF ... No lo cambie porque asi lo tenia Bicevida ...
      end
      else
         // 0 Era tasa Valida se tiene que retornar error
         // fTasa_Resultado := 0;
         fTasa_Resultado := -999;

   end;  // Para ICP y ICP-UF

   if (sFormula = 'ICP2') then
   begin
       // Penta Septiembre del 2015

       // si Ti-1=T0 --> TNA=REDONDEAR(((ICP1/ICP0)-1)*36000/(T1-T0);2)

       // Otros dias --> TNA=REDONDEAR([((ICPi/ICP0-1)*36000/(Ti-T0))*(Ti-T0)-((ICPi-1/ICP0-1)*36000/(Ti-1-T0))*(Ti-1-T0)]/(Ti-Ti-1),2)


       // T0 = significa, la fecha de suscripción de este Pagaré y, a partir de entonces, cada Fecha de Vencimiento siguiente
       // Ti = significa el Día Hábil Bancario siguiente al de la suscripción de este Pagaré y, a partir de entonces, cada Día Hábil Bancario siguiente.
       // Ti-1 = significa el Día Hábil Bancario inmediatamente anterior a Ti.

       // ICP0 significa el Índice Cámara Promedio publicado en la fecha de suscripción de este Pagaré y, a partir de entonces, en cada Fecha de Vencimiento siguiente.
       // ICPi significa el Índice Cámara Promedio publicado el Día Hábil Bancario siguiente al de la suscripción de este Pagaré y, a partir de entonces, cada Día Hábil Bancario siguiente.
       // ICPi-1 significa, el Índice Cámara Promedio publicado el Día Hábil Bancario inmediatamente anterior a ICPi.

       dT0 := dFecha_Vcto_Anterior; // Ojo la formula no dice nada si es que debe ser habil o no.

       //ggarcia 13-11-2019
       //dTi := dFecha_Calculo;
       //dTi := dFecha_Calculo + 1;

       // F.I. 10-08-2020
       // Se vuelve atras el cambio, ya que no tiene sentido depender siempre del valor
       // del dia siguiente
       dTi := dFecha_Calculo;
       // dTi := dFecha_Calculo + 1;
       // Día Habil Siguiente
       While (Feriado_Mem(sPais_Usuario,dTi)  or  (DayOfWeek(dTi) in [1,7])) do
             dTi := dTi + 1;


       // Si T0 igual a Ti es que se esta valorando a la fecha de suscripcion
       // Se deja tasa cero J.D. P.M. T.L. F.I. 10-08-2020
       if (dT0 = dTi) then
       begin
          fTasa_Resultado := 0;
          exit;
       end;


       // DC&FI Cuando lo ejecuten a futuro 12-09-2017
       if dTi > dfecha_hora then
       begin
          fTasa_Resultado := -999;
          exit;
       end;

       //ggarcia 13-11-2019
       //dTi_1 := dFecha_Calculo - 1;
       dTi_1 := dTi - 1;
       // Dia habil antes
       While (Feriado_Mem(sPais_Usuario,dTi_1)  or  (DayOfWeek(dTi_1) in [1,7])) do
             dTi_1 := dTi_1 - 1;


       if (dTi_1 < dT0 ) then  // No calculable ... devuelvo -999 para indicar que proyecte con valor vcto anterior
       begin
          fTasa_Resultado := -999;
          exit;
       end;

       leer_valor_cambio2('ICP'
                         ,'ICP'
                         ,'BC'
                         ,dT0
                         ,fICP0
                         ,bResult);
       if not bResult then
       begin
          Modulo_Err := 'Obtención de Valores Tasa con formula';
          String_Err := 'No se encontro valor para ICP con fecha :'+DateToStr(dT0);
          exit;
       end;
       if (fICP0 = 0) then
       begin
          Modulo_Err := 'Obtención de Valores Tasa con formula';
          String_Err := 'Valor para ICP inicial no puede ser cero.'
                         +' Con Fecha: '+DateToStr(dT0)+' T0';
          exit;
       end;

       leer_valor_cambio2('ICP'
                         ,'ICP'
                         ,'BC'
                         ,dTi
                         ,fICPi
                         ,bResult);
       if not bResult then
       begin
          Modulo_Err := 'Obtención de Valores Tasa con formula';
          String_Err := 'No se encontro valor para ICP con fecha :'+DateToStr(dTi)+' Ti';
          exit;
       end;

       Obtener_Tasa_base_Mem(sCodigo_Tasa
                            ,iDiasBase
                            ,sTipoInteres
                            ,iBaseMensual
                            ,sTipoCalculoDias
                            ,iVigenciaValor
                            ,iVigenciaMeses
                            ,sPais_Tasa
                            ,Modulo_err
                            ,String_err
                            ,bResult);

       if NOT bResult then
       begin
          Modulo_Err := 'Obtención de Valores Tasa con formula';
          String_Err := 'No se encontro Definición Tasa Base para '+sCodigo_Tasa;
          exit;
       end;

       if (dTi_1 = dT0) or (dFecha_Calculo = dFecha_Vcto) then
       begin
          // TNA=REDONDEAR(((ICP1/ICP0)-1)*36000/(T1-T0);2)      // LOS 36000 corresponden a dias base 360 x 100  (100 es porcentual)

          if (dTi-dT0 = 0) then
          begin
             Modulo_Err := 'Obtención de Valores Tasa con formula';
             String_Err := 'Ti-T0 = 0  Ti = '+DateToStr(dTi);
             exit;
          end;

          fTasa_Resultado := Redondeo(
                                      ((fICPi/fICP0)-1)*(iDiasBase*100)/(dTi-dT0)
                                      ,2);
       end
       else
       begin
          leer_valor_cambio2('ICP'
                            ,'ICP'
                            ,'BC'
                            ,dTi_1
                            ,fICPi_1
                            ,bResult);
          if not bResult then
          begin
             Modulo_Err := 'Obtención de Valores Tasa con formula';
             String_Err := 'No se encontro valor para ICP con fecha :'+DateToStr(dTi_1)+' Ti-1';
             exit;
          end;

          if (dTi-dTi_1 = 0) then
          begin
             Modulo_Err := 'Obtención de Valores Tasa con formula';
             String_Err := 'Ti-Ti_1 = 0  Imposible Ti = '+DateToStr(dTi);
             exit;
          end;

          // TNA=REDONDEAR([((ICPi/ICP0-1)*36000/(Ti-T0))*(Ti-T0)-((ICPi-1/ICP0-1)*36000/(Ti-1-T0))*(Ti-1-T0)]/(Ti-Ti-1),2)
//           10-08-2020
//          fTasa_Resultado := Redondeo( (
//                                       ((fICPi/fICP0)-1)*(iDiasBase*100) -
//                                       ((fICPi_1/fICP0)-1)*(iDiasBase*100)
//                                       ) / (dTi - dTi_1)
//                                      ,2);

          if ((dTi - dT0) = 0)  then
             fTasa_Resultado := 0
          else
             fTasa_Resultado := (Redondeo((fICPi/fICP0-1)*(iDiasBase*100),2) -
                                 Redondeo((fICPi_1/fICP0-1)*(iDiasBase*100),2)
                                ) / (dTi - dTi_1);
       end;
   end;

   /////////////////////////////////////////////////////////////////////////////
   //  F O R M U L A   I C P
   /////////////////////////////////////////////////////////////////////////////
   if sFormula = 'ICP' then
   begin
      fTasa_Resultado := Redondeo_moneda_Mem( sCodigo_Tasa
                                             ,dFecha_Calculo
                                             ,fTasa_Resultado);
      bResult := true;
   end;

   /////////////////////////////////////////////////////////////////////////////
   //  F O R M U L A   I C P  -  U F
   /////////////////////////////////////////////////////////////////////////////
   if sFormula = 'ICP-UF' then
   begin
      fDias := dFecha_Termino - dFecha_Inicio;
      if fDias > 0 then
      begin
         leer_valor_cambio2('UF'
                           ,Moneda_Nacional
                           ,'BC'
                           ,dFecha_Inicio
                           ,fUF0
                           ,bResult);
         if not bResult then
         begin
            Modulo_Err := 'Obtención de Valores Tasa';
            String_Err := 'No se encontro Valor para UF'
                          +'. Con Fecha :'+DateToStr(dFecha_Inicio);
            exit;
         end;

         leer_valor_cambio2('UF'
                           ,Moneda_Nacional
                           ,'BC'
                           ,dFecha_Termino
                           ,fUF1
                           ,bResult);
         if not bResult then
         begin
            Modulo_Err := 'Obtención de Valores Tasa';
            String_Err := 'No se encontro Valor para UF'
                          +'. Con Fecha :'+DateToStr(dFecha_Termino);
            exit;
         end;

         fTasa_Resultado := (  ( ((fTNA * fDias) / iDiasBase) - ((fUF1 / fUF0) - 1) ) / (fUF1 / fUF0)  ) * (iDiasBase / fDias);

         fTasa_Resultado := Redondeo_moneda_Mem( sCodigo_Tasa
                                                ,dFecha_Calculo
                                                ,fTasa_Resultado);

         fTasa_Resultado :=  fTasa_Resultado * 100;
      end
      else
         fTasa_Resultado := 0;

      bResult := true;
   end;

end;

procedure leer_valor_cambio_con_tipo(sMon_Origen   : String;
                                     sMon_Paridad  : String;
                                     sTipo_Paridad : String;
                                     dfecha        : TDatetime;
                                     var fParidad  : Double;
                                     var sTipo     : String;
                                     var Result    : Boolean);
var sTipo_Moneda        : string;
    sTipo_Unidad        : string;
    sUnidad             : string;
    sUnidad_Conversion  : string;
    sTipo_Variacion     : string;
    swhere_part         : string;
    aux_pchar           : Array[0..250] of Char;
    i                   : Integer;
begin

   Busca_Valores_Monedas_Periodo_Mem(sMon_Origen,
                                     sUnidad_Conversion,
                                     sTipo_Moneda,
                                     sTipo_Unidad,
                                     sUnidad,
                                     sTipo_Variacion);
   if (sTipo_Moneda = 'M') and
      (sMon_Origen  = sMon_Paridad) then
   begin
      Result   := true;  //ES GG  15-01-2018
      fParidad := 1;
      exit;
   end;
   // Verifico si existe un tipo de cambio definido por quien lo llama
   // Caso de utilizar tipo de cambio ingresado en la Operacion
   Buscar_Tipo_Cambio_Fijo_Mem( sMon_Origen
                               ,sMon_Paridad
                               ,sTipo_Paridad
                               ,dfecha
                               ,fParidad
                               ,Result);
   // Si encontro tipo de cambio fijo lo devuelve !!!!
   if Result then
      exit;

   Result := True;
   if sValorizacion_Proceso =  'SI' then
   begin
      if NOT VarIsArray(Reg_Monedas.COD_MONEDA) then
      begin
         i := 0;
         Reg_Monedas.COD_MONEDA      := VarArrayCreate([0, i], varOleStr);
         Reg_Monedas.TIPO_DE_PARIDAD := VarArrayCreate([0, i], varOleStr);
         Reg_Monedas.MONEDA_PARIDAD  := VarArrayCreate([0, i], varOleStr);
         Reg_Monedas.FECHA_PARIDAD   := VarArrayCreate([0, i], varDate);
         Reg_Monedas.VALOR_MONEDA    := VarArrayCreate([0, i], varDouble);
         Reg_Monedas.TIPO            := VarArrayCreate([0, i], varOleStr);
      end
      else
      begin
         For i := 0 to VarArrayHighBound(Reg_Monedas.COD_MONEDA, 1 ) do
         begin
            if (Reg_Monedas.COD_MONEDA[i]      = sMon_Origen)   and
               (Reg_Monedas.TIPO_DE_PARIDAD[i] = sTipo_Paridad) and
               (Reg_Monedas.MONEDA_PARIDAD[i]  = sMon_Paridad)  and
               (Reg_Monedas.FECHA_PARIDAD[i]   = dfecha)  then
            begin
               fParidad  := Reg_Monedas.VALOR_MONEDA[i] ;
               if trim(Reg_Monedas.TIPO[i]) <> '' then
                  sTipo := Reg_Monedas.TIPO[i] ;
               Result    := True;
               Exit;
            end;
         end;
      end;
   end;

   if sTipo_Variacion <> 'D' then
   begin
      {Busco la fecha de paridad}
      if NOT leer_fecha_periodo(sTipo_Unidad
                               ,sUnidad
                               ,sTipo_Variacion
                               ,dfecha) then
      begin
         strpcopy(aux_pchar
                 ,'Error en definición de período para : '''+sMon_Origen+''''
                 +#10'con fecha: '+datetostr(dfecha));
         Application.MessageBox(aux_pchar
                              ,'Valor Paridad'
                              ,mb_OK);
         Result := False;
         exit;
      end;
   end
   else
      dfecha_Periodo := dfecha;

   {Busco Paridad}

   swhere_part := ' WHERE Fecha_Paridad = :pfecha'
                +'   AND  Cod_moneda      = '''+sMon_Origen+''''
                +'   AND  Tipo_De_Paridad = '''+sTipo_Paridad+'''';

   if (sTipo_Moneda = 'M') then
      swhere_part := swhere_part + ' AND Moneda_Paridad = '''+sMon_Paridad+'''';

   with DM_Leer_Valor_Cambio.QRY_General do
   begin
      SQL.Clear;
      SQL.Add('SELECT Valor_Moneda As Valor_Moneda '
             +'      ,Tipo         As Tipo '
             +'  FROM QS_SYS_VAL_CAMBIO'
             +swhere_part );
      ParamByName('pfecha').AsDate := dfecha_Periodo;
      Prepare;
      Open;
      if (FieldByName('Valor_Moneda').IsNull) or
         (FieldByName('Valor_Moneda').Asfloat = 0) then
      begin
         {Busco a reves (solo una vez por re_llamado}
         if (sTipo_Moneda = 'M') and NOT re_llamado then
         begin
            re_llamado := True;
            leer_valor_cambio_con_tipo(sMon_Paridad,
                                       sMon_Origen,
                                       sTipo_Paridad,
                                       dfecha,
                                       fParidad,
                                       sTipo,
                                       Result);
            if Result then
               if fParidad <> 0 then
                  fParidad := 1 / fParidad
               else
                  fParidad := 0;
            re_llamado := False;
         end
         else
         begin
            Result := False;
            fParidad := 0;
            sTipo    := '';
            if sTipo_Moneda = 'T' then
               if NOT FieldByName('Valor_Moneda').IsNull then
                  Result := True;
         end;
      end
      else
      begin
         fParidad := FieldByName('Valor_Moneda').AsFloat;
         if trim(DM_Leer_Valor_Cambio.QRY_General.FieldByName('Tipo').AsString) <> '' then
            sTipo := FieldByName('Tipo').AsString;
      end;

      if (sTipo_Moneda = 'M') and
         (fParidad = 0)       then
          Result := False;
      Close;
   end;

   if sValorizacion_Proceso =  'SI' then
   begin
      if Result then
      begin
          VarArrayRedim(Reg_Monedas.COD_MONEDA      , i );
          VarArrayRedim(Reg_Monedas.TIPO_DE_PARIDAD , i );
          VarArrayRedim(Reg_Monedas.MONEDA_PARIDAD  , i );
          VarArrayRedim(Reg_Monedas.FECHA_PARIDAD   , i );
          VarArrayRedim(Reg_Monedas.VALOR_MONEDA    , i );
          VarArrayRedim(Reg_Monedas.TIPO            , i );

          Reg_Monedas.COD_MONEDA[i]     := sMon_Origen;
          Reg_Monedas.TIPO_DE_PARIDAD[i]:= sTipo_Paridad;
          Reg_Monedas.MONEDA_PARIDAD[i] := sMon_Paridad;
          Reg_Monedas.FECHA_PARIDAD[i]  := dfecha;
          Reg_Monedas.VALOR_MONEDA[i]   := fParidad;
          Reg_Monedas.TIPO[i]           := sTipo;
      end;
   end;
end;

procedure Leer_Valor_Indice(sIndice       :String;
                            dFecha        :TDateTime;
                        var fValorCambio  : Double;
                        var Result        : Boolean);
var
  sTipo_Moneda        : String;
  sDescripcion_Moneda : String;
  sConversion         : String;
begin
   Result := True;
   fValorCambio := 0;

   sConversion := '';
   Datos_Moneda_Mem( sIndice
                    ,sTipo_Moneda
                    ,sDescripcion_Moneda
                    ,sConversion);
   if sConversion = '' then
   begin
     Result := False;
     exit;
   end;
   leer_valor_cambio2(sIndice,
                      sConversion,
                      'BC',
                      dfecha,
                      fValorCambio,
                      Result);
end;


procedure conversion_unidad_mon(sUniMon_origen,
                                sUniMon_Resultado,
                                sTipo_Cambio  : String;
                                dfecha_cambio : TDateTime;
                                dValor_origen : double;
                                var dValor_Resultado : double;
                                var Modulo_Err : String;
                                var String_Err : String;
                                var Result     : boolean);
var
   sTipo_Moneda_Origen,
   sTipo_Moneda_Resultado,
   sUnidad_Conv_Origen,
   sUnidad_Conv_Resultado,
   sDescripcion_Moneda    : String;
   fValorCambio           : Double;

   fCantidad              : Double;
   sUnidad                : String;
   sAntes_Despues         : String;

begin
  Result := True;
  dValor_Resultado := 0;
  sUniMon_origen    := trim(sUniMon_origen);
  sUniMon_Resultado := trim(sUniMon_Resultado);
  // Si la moneda es la misma seria todo
  if sUniMon_origen = sUniMon_Resultado then
  begin
    dValor_Resultado := dValor_origen;
    exit;
  end;



  { La funcion Datos_Moneda_mem esta siempre cargada !!!! F.I. 10-08-2011}
      Datos_Moneda_Mem( sUniMon_Origen
                       ,sTipo_Moneda_Origen
                       ,sDescripcion_Moneda
                       ,sUnidad_Conv_Origen);

  { La funcion Datos_Moneda_mem esta siempre cargada !!!!  }
      Datos_Moneda_Mem( sUniMon_Resultado
                       ,sTipo_Moneda_Resultado
                       ,sDescripcion_Moneda
                       ,sUnidad_Conv_Resultado);

      Busca_Proy_Precio_Mem('MON-HABIL'
                            ,fCantidad
                            ,sUnidad
                            ,sAntes_Despues
                            ,Result);
      if Result then
      begin
        if sAntes_Despues = 'A' then
           dfecha_cambio := dia_habil_antes_despues( sCodigo_Div_Geo_Usuario
                                                     ,dfecha_cambio
                                                     ,'-')
        else
           dfecha_cambio := dia_habil_antes_despues( sCodigo_Div_Geo_Usuario
                                                     ,dfecha_cambio
                                                     ,'+');
      end;

      Result := True;
      if sTipo_Moneda_Origen = 'I' then
      {llevar indice origen a su unidad de conversion propia}
      begin
           Leer_valor_cambio2(sUniMon_Origen,
                              sUniMon_Origen,
                              'BC', //sTipo_Cambio,
                              dfecha_cambio,
                              fValorCambio,
                              Result);
        if NOT Result then
           begin
             Modulo_Err := 'Conversión de Unidad Monetaria (1)';
             String_Err := 'No se registra valor de '+sUniMon_Origen+#10
                          +'con fecha: '+datetostr(dfecha_cambio);
             Result := False;
             exit
           end;
        dValor_origen := dValor_Origen * fValorCambio;
        //ggarcia 21-12-2017 si se asigno un valor fijo en la funcion 'Leer_valor_cambio_con_tipo' de arriba no debe hacer nada mas.
        Buscar_Tipo_Cambio_Fijo_Mem(sUniMon_Origen
                                   ,sUniMon_Origen
                                   ,'BC' //sTipo_Cambio
                                   ,dfecha_cambio
                                   ,fValorCambio
                                   ,Result);
        if Result then
        begin
           dValor_Resultado := dValor_Origen;
           exit;
        end;
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        sUniMon_Origen := sUnidad_Conv_Origen;
      end;

      if sTipo_Moneda_Resultado = 'I' then
      {llevar valor de origen a moneda del indice para resultado}
      begin
           leer_valor_cambio2(sUniMon_Origen,
                           sUnidad_Conv_Resultado,
                           sTipo_Cambio,
                           dfecha_cambio,
                           fValorCambio,
                           Result);
           if NOT Result then
           begin
             Modulo_Err := 'Conversión de Unidad Monetaria';
             String_Err := 'No se registra paridad de '+trim(sUniMon_Origen)+#10
                          +'a '+trim(sUnidad_Conv_Resultado)
                          +' con fecha: '+datetostr(dfecha_cambio);
             Result := False;
             exit
           end;

        dValor_origen := dValor_Origen * fValorCambio;  // tengo el valor en moneda del indice
        leer_valor_cambio2(sUniMon_Resultado,
                           sUniMon_Resultado,
                           'BC', //sTipo_Cambio,
                           dfecha_cambio,
                           fValorCambio,
                           Result);
        if NOT Result then
           begin
             Modulo_Err := 'Conversión de Unidad Monetaria (2)';
             String_Err := 'No se registra valor de '+trim(sUniMon_Resultado)+#10
                           +'con fecha: '+datetostr(dfecha_cambio);
             Result := False;
             exit
           end;
        if fValorCambio <> 0 then
           dValor_Resultado := dValor_Origen / fValorCambio
        else
           dValor_Resultado := 0;
      end
   else
   begin   { Conversión entre monedas normal}

    leer_valor_cambio2(sUniMon_Origen,
                        sUniMon_Resultado,
                        sTipo_Cambio,
                        dfecha_cambio,
                        fValorCambio,
                        Result);
     if NOT Result then
        begin
          Modulo_Err := 'Conversión de Unidad Monetaria';
          //ggarcia 30-10-2017
          //String_Err := 'No se registra paridad de '+trim(sUniMon_Origen)
          String_Err := 'No se registra paridad '+sTipo_Cambio+' de '+trim(sUniMon_Origen)
                       +' a '+trim(sUniMon_Resultado)+#10
                       +'con fecha: '+datetostr(dfecha_cambio);
          Result := False;
          exit
        end;
     dValor_Resultado := dValor_Origen * fValorCambio;
   end;
end;
//==============================================================================
procedure conversion_unidad_mon_con_Tipo(sUniMon_origen       : String;
                                         sUniMon_Resultado    : String;
                                         sTipo_Cambio         : String;
                                         dfecha_cambio        : TDateTime;
                                         dValor_origen        : double;
                                         var dValor_Resultado : double;
                                         var sTipo            : String;
                                         var Modulo_Err       : String;
                                         var String_Err       : String;
                                         var Result           : boolean);
var
   sTipo_Moneda_Origen    : String;
   sTipo_Moneda_Resultado : String;
   sUnidad_Conv_Origen    : String;
   sUnidad_Conv_Resultado : String;
   sDescripcion_Moneda    : String;
   fValorCambio           : Double;
begin
   Result := True;
   dValor_Resultado := 0;
   sUniMon_origen    := trim(sUniMon_origen);
   sUniMon_Resultado := trim(sUniMon_Resultado);

   // Si la moneda es la misma seria todo
   if sUniMon_origen = sUniMon_Resultado then
   begin
     dValor_Resultado := dValor_origen;
     exit;
   end;

   Datos_Moneda_Mem( sUniMon_Origen
                    ,sTipo_Moneda_Origen
                    ,sDescripcion_Moneda
                    ,sUnidad_Conv_Origen);
   Datos_Moneda_Mem( sUniMon_Resultado
                    ,sTipo_Moneda_Resultado
                    ,sDescripcion_Moneda
                    ,sUnidad_Conv_Resultado);

   if sTipo_Moneda_Origen = 'I' then
   begin
     {llevar indice origen a su unidad de conversion propia}
      Leer_valor_cambio_con_tipo(sUniMon_Origen,
                                 sUniMon_Origen,
                                 'BC', //sTipo_Cambio,
                                 dfecha_cambio,
                                 fValorCambio,
                                 sTipo,
                                 Result);
      if NOT Result then
      begin
         Modulo_Err := 'Conversión de Unidad Monetaria (1)';
         String_Err := 'No se registra valor de '+sUniMon_Origen+#10
                      +'con fecha: '+datetostr(dfecha_cambio);
         Result := False;
         exit
      end;
      dValor_origen := dValor_Origen * fValorCambio;
      //ggarcia 21-12-2017 si se asigno un valor fijo en la funcion 'Leer_valor_cambio_con_tipo' de arriba no debe hacer nada mas.
      Buscar_Tipo_Cambio_Fijo_Mem(sUniMon_Origen
                                 ,sUniMon_Origen
                                 ,sTipo_Cambio
                                 ,dfecha_cambio
                                 ,fValorCambio
                                 ,Result);
      if Result then
      begin
         dValor_Resultado := dValor_Origen;
         exit;
      end;
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      sUniMon_Origen := sUnidad_Conv_Origen;
   end;

   if sTipo_Moneda_Resultado = 'I' then
   begin
      {llevar valor de origen a moneda del indice para resultado}
      Leer_valor_cambio_con_tipo(sUniMon_Origen,
                                 sUnidad_Conv_Resultado,
                                 sTipo_Cambio,
                                 dfecha_cambio,
                                 fValorCambio,
                                 sTipo,
                                 Result);
      if NOT Result then
      begin
        Modulo_Err := 'Conversión de Unidad Monetaria';
        String_Err := 'No se registra paridad de '+trim(sUniMon_Origen)+#10
                     +'a '+trim(sUnidad_Conv_Resultado)
                     +' con fecha: '+datetostr(dfecha_cambio);
        Result := False;
        exit
      end;
      dValor_origen := dValor_Origen * fValorCambio;  // tengo el valor en moneda del indice
      Leer_valor_cambio_con_tipo(sUniMon_Resultado,
                                 sUniMon_Resultado,
                                 'BC',  //sTipo_Cambio,
                                 dfecha_cambio,
                                 fValorCambio,
                                 sTipo,
                                 Result);
      if NOT Result then
      begin
         Modulo_Err := 'Conversión de Unidad Monetaria (2)';
         String_Err := 'No se registra valor de '+trim(sUniMon_Resultado)+#10
                       +'con fecha: '+datetostr(dfecha_cambio);
         Result := False;
         exit
      end;
      if fValorCambio <> 0 then
         dValor_Resultado := dValor_Origen / fValorCambio
      else
         dValor_Resultado := 0;
   end
   else
   begin
      { Conversión entre monedas normal}
      Leer_valor_cambio_con_tipo(sUniMon_Origen,
                                 sUniMon_Resultado,
                                 sTipo_Cambio,
                                 dfecha_cambio,
                                 fValorCambio,
                                 sTipo,
                                 Result);
      if NOT Result then
      begin
         Modulo_Err := 'Conversión de Unidad Monetaria';
         //ggarcia 30-10-2017
         //String_Err := 'No se registra paridad de '+trim(sUniMon_Origen)
         String_Err := 'No se registra paridad '+sTipo_Cambio+' de '+trim(sUniMon_Origen)
                      +' a '+trim(sUniMon_Resultado)+#10
                      +'con fecha: '+datetostr(dfecha_cambio);
         Result := False;
         exit
      end;
      dValor_Resultado := dValor_Origen * fValorCambio;
   end;
end;
//==============================================================================
{procedure Lee_Tasa_Tramos(sCodigo_Tasa    : String;
                          sInterpolacion  : String;
                          dFecha          : TDateTime;
                          iDiasDif        : Double;
                          var fValor_Tasa : Double;
                          var sModulo_Err : String;
                          var sString_Err : String;
                          var Result      : Boolean);
var
  bBuscar          : Boolean;
  sCodigo_Division : String;
  dFecha_Tasa      : TDatetime;
  fTasa_Menor,
  fTasa_Mayor,
  fDias_Menor,
  fDias_Mayor      : Double;
  EsTramo          : Boolean;
  Modulo_Err : String;
  String_Err : String;
begin
   sModulo_Err := 'Valor Tasa Tramo : ';
   Result      := False;
   // Determino si existe tasa por tramos
   WITH DM_Leer_Valor_Cambio.QRY_General do
   begin
        Sql.Clear;
        Sql.Add( 'SELECT MAX(Fecha) as Fecha '
                +' FROM QS_FIN_VALOR_TRAMO'
                +' WHERE Fecha   <= :Fecha'
                +'   AND Codigo   = :Tasa'
               );
        ParamByName('Tasa' ).AsString   := sCodigo_Tasa;
        ParamByName('Fecha').AsDateTime := dFecha;
        Open;

        EsTramo := False;
        if Not Fieldbyname( 'Fecha' ).IsNull then
        Begin
           dFecha_Tasa :=  Fieldbyname('Fecha').asDatetime;
           EsTramo := True;
        End
        else
        Begin
          Sql.Clear;
          Sql.Add( 'SELECT MAX(fecha_paridad) as Fecha '
                  +' FROM QS_SYS_VAL_CAMBIO'
                  +' WHERE fecha_paridad   <= :Fecha'
                  +'   AND Cod_Moneda   = :Tasa'
                 );
          ParamByName('Tasa' ).AsString   := sCodigo_Tasa;
          ParamByName('Fecha').AsDateTime := dFecha;
          Open;
          if Not Fieldbyname( 'Fecha' ).IsNull then
             dFecha_Tasa :=  Fieldbyname('Fecha').asDatetime
        End;

        if Fieldbyname( 'Fecha' ).IsNull then
        begin
           Close;
           sString_Err := 'No se encontro valor para: '
                          +sCodigo_Tasa+#10
                          +'Con Fecha '
                          +DateToStr(dFecha)
                          +' para '
                          +FloatToStr(iDiasDif)
                          +' días';
           Exit;
        end;

        Close;

        If EsTramo  Then
        Begin
           // si hay Interpolacion
           if sInterpolacion = 'I' then
           begin
              // Busco Tasa a Fecha Encontrada
              SQL.Clear;
              SQL.Add('SELECT Valor'
                     +'      ,Dias_Desde'
                     +'      ,Dias_Hasta'
                     +'  FROM QS_FIN_VALOR_TRAMO'
                     +' WHERE Fecha        = :Fecha'
                     +'   AND Codigo       = :Tasa'
                     +' ORDER BY Fecha'
                     );
              ParamByName('Tasa' ).AsString   := sCodigo_Tasa;
              ParamByName('Fecha').AsDateTime := dFecha_Tasa;
              Prepare;
              Open;

              While Not Eof do
              begin
                 // Busco Rango de Dias
                 if ( Fieldbyname('Dias_desde').asFloat <= iDiasDif) and
                    (( Fieldbyname('Dias_hasta').asFloat >= iDiasDif ) or
                     ( Fieldbyname('Dias_hasta').isNull)
                    ) then
                 begin
                     // Si es Primer tramo esta es la tasa buscada
                     if Fieldbyname('Dias_desde').asFloat = 0 then
                     begin
                       fValor_Tasa := Fieldbyname('Valor').asFloat;
                       Result      := True;
                       Break;
                     end;

                     // Si no es primer tramo se Interpola y este es el tramo mayor
                     fDias_Mayor := 0;
                     if Not Fieldbyname('Dias_Hasta').IsNull then
                        fDias_Mayor := Fieldbyname('Dias_Hasta').asFloat
                     else // Si se esta en el ultimo tramo no se interpola y se usa esta
                     begin
                       fValor_Tasa := Fieldbyname('Valor').asFloat;
                       Result      := True;
                       Break;
                     end;

                     fTasa_Mayor := 0;
                     if Not Fieldbyname('Valor').IsNull then
                        fTasa_Mayor := Fieldbyname('Valor').asFloat;

                     // si es el Primer rango no interpolo y esa es la tasa
                     Prior;
                     if Bof then
                     begin
                        fValor_Tasa := fTasa_Mayor;
                        Result      := True;
                        Break;
                     end;

                     fTasa_Menor := 0;
                     if Not Fieldbyname('Valor').IsNull then
                        fTasa_Menor := Fieldbyname('Valor').asFloat;

                     fDias_Menor := 0;
                     if Not Fieldbyname('Dias_Hasta').IsNull then // Antes
                        fDias_Menor := Fieldbyname('Dias_Hasta').asFloat;


                     if ( fDias_Mayor - fDias_Menor ) <> 0 then
                     begin
                        fValor_Tasa := fTasa_Menor + (( iDiasDif - fDias_Menor) * ( fTasa_Mayor -fTasa_Menor ) /
                                                      ( fDias_Mayor - fDias_Menor )
                                                      );
                        Result := True;
                     end;
                    Break;
                 end;
                 Next;
              end
           end
           else  //NO interpolacion
           begin
              // Rescato Tasa sin Interpolar
              SQL.Clear;
              SQL.Add('SELECT Valor'
                     +'  FROM QS_FIN_VALOR_TRAMO'
                     +' WHERE Fecha        = :Fecha'
                     +'   AND Codigo       = :Tasa'
                     +'   AND Dias_desde  <= :Dias'
                     +'   AND (Dias_hasta >= :Dias or dias_hasta is null)'
                     );
              ParamByName('Tasa' ).AsString   := sCodigo_Tasa;
              ParamByName('Fecha').AsDateTime := dFecha_Tasa;
              ParamByName('Dias'  ).AsFloat   := iDiasDif;
              Prepare;
              Open;

              If Not Fieldbyname('Valor').IsNull then
              begin
                 fValor_Tasa := Fieldbyname('Valor').asFloat;
                 Result      := True;
              end
              else
                 sString_Err := 'No se encontro valor para: '
                                +sCodigo_Tasa+#10
                                +'Con Fecha '
                                +DateToStr(dFecha)
                                +' para '
                                +FloatToStr(iDiasDif)
                                +' días';

           end;
           Close;
        end
        else  // Si no es por tramo buscva el valor como tasas estandar
        Begin
              leer_valor_cambio2(sCodigo_Tasa,
                                 sCodigo_Tasa,
                                 'BC',
                                 dFecha,
                                 fValor_Tasa,
                                 Result);
              if NOT Result then
              begin
                String_Err := 'No se registra valor para tasa: '
                             +trim(sCodigo_Tasa)
                             +' con fecha: '+datetostr(dFecha);
                Result := False;
              end
        End;
   end;
End;}
procedure Lee_Tasa_Tramos(RegParamMargen  : TRegParamMargen;
                          dFecha          : TDateTime;
                          iDiasDif        : Double;
                          bDia_Habil      : Boolean;
                          var fValor_Tasa_1 : Double;
                          var fValor_Tasa_2 : Double;
                          var sModulo_Err : String;
                          var sString_Err : String;
                          var Result      : Boolean);
var
 // bBuscar          : Boolean;
//  sCodigo_Division : String;
  dFecha_Tasa      : TDatetime;
  fTasa_Menor,
  fTasa_Mayor,
  fDias_Menor,
  fDias_Mayor      : Double;
  EsTramo          : Boolean;

  Modulo_Err : String;
  String_Err : String;
  bresult    :  Boolean;
  sTipo_Ajuste             : String;
  iDecimales_Redondeo      : Integer;

begin
   fTasa_Menor := 0;
   //fTasa_Mayor := 0;
   fDias_Menor := 0;
   //fDias_Mayor := 0;

   sModulo_Err := 'Valor Tasa Tramo : ';
   Result      := False;
   bresult     := True;
   If (RegParamMargen.Tasa_Base_1 <> '') Then
   Begin
      WITH DM_Leer_Valor_Cambio.QRY_General do
      begin
        Sql.Clear;
        Sql.Add( 'SELECT MAX(Fecha) as Fecha '
                +' FROM QS_FIN_VALOR_TRAMO'
                +' WHERE Fecha   <= :Fecha'
                +'   AND Codigo   = :Tasa'
               );
        ParamByName('Tasa' ).AsString   := RegParamMargen.Tasa_Base_1;
        ParamByName('Fecha').AsDate := dFecha;
        Open;

        EsTramo := False;
        if Not Fieldbyname( 'Fecha' ).IsNull then Begin
           dFecha_Tasa :=  Fieldbyname('Fecha').asDatetime;
           EsTramo := True;
        End
        else
           Begin
              Sql.Clear;
              Sql.Add( 'SELECT MAX(fecha_paridad) as Fecha '
                      +' FROM QS_SYS_VAL_CAMBIO'
                      +' WHERE fecha_paridad   <= :Fecha'
                      +'   AND Cod_Moneda   = :Tasa'
                     );
              ParamByName('Tasa' ).AsString   := RegParamMargen.Tasa_Base_1;
              ParamByName('Fecha').AsDate := dFecha;
              Open;
              if Not Fieldbyname( 'Fecha' ).IsNull then
                 dFecha_Tasa :=  Fieldbyname('Fecha').asDatetime
           End;
        if Fieldbyname( 'Fecha' ).IsNull then
        begin
           Close;
           sString_Err := 'No se encontro valor para: '
                          +RegParamMargen.Tasa_Base_1+#10
                          +'Con Fecha '
                          +DateToStr(dFecha)
                          +' para '
                          +FloatToStr(iDiasDif)
                          +' días';
           Exit;
        end;

        Close;

        If EsTramo  Then Begin
           // si hay Interpolacion
           if RegParamMargen.Interpolacion_1 = 'I' then
           begin
              // Busco Tasa a Fecha Encontrada
              SQL.Clear;
              SQL.Add('SELECT Valor '
                     +'      ,Dias_Desde '
                     +'      ,Dias_Hasta '
                     +'  FROM QS_FIN_VALOR_TRAMO '
                     +' WHERE Fecha        = :Fecha '
                     +'   AND Codigo       = :Tasa '
                     +'   AND Dias_Desde   = (SELECT max(Dias_Desde) '
                     +'                         FROM QS_FIN_VALOR_TRAMO '
                     +'                        WHERE Fecha        = :Fecha '
                     +'                          AND Codigo       = :Tasa '
                     +'                          AND Dias_Desde   <= :Dias_Desde) ' // Se cambia a Menor o igual para que tome el tramo si cae justo F.I., 09-04-2014
                     );
              ParamByName('Tasa').AsString       := RegParamMargen.Tasa_Base_1;
              ParamByName('Fecha').AsDate    := dFecha_Tasa;
              ParamByName('Dias_Desde').AsFloat  := iDiasDif;
              Open;
              if Not Eof then
              begin
                 fDias_Menor := FieldByName('Dias_Desde').AsFloat;
                 fTasa_Menor := FieldByName('Valor').AsFloat;
              end;

              // Si coincide justo el numero de dias biscado con dias menor, no es necesario leer otro dato para interpolar  F.I. 13-04-2016
              if fDias_Menor = iDiasDif then
              begin
                fValor_Tasa_1 := fTasa_Menor;
                Result := True;
              end
              else  // lee segundo tramo para interpolar...
              begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT Valor '
                         +'      ,Dias_Desde '
                         +'      ,Dias_Hasta '
                         +'  FROM QS_FIN_VALOR_TRAMO '
                         +' WHERE Fecha        = :Fecha '
                         +'   AND Codigo       = :Tasa '
                         +'   AND Dias_Desde   = (SELECT min(Dias_Desde) '
                         +'                         FROM QS_FIN_VALOR_TRAMO '
                         +'                        WHERE Fecha        = :Fecha '
                         +'                          AND Codigo       = :Tasa '
                         +'                          AND Dias_Desde   > :Dias_Desde) '
                         );
                  ParamByName('Tasa').AsString       := RegParamMargen.Tasa_Base_1;
                  ParamByName('Fecha').AsDate    := dFecha_Tasa;
                  ParamByName('Dias_Desde').AsFloat  := iDiasDif;
                  Open;
                  if Not Eof then
                  begin
                     fDias_Mayor := FieldByName('Dias_Desde').AsFloat;
                     fTasa_Mayor := FieldByName('Valor').AsFloat;
                  end
                  else
                  begin
                     fDias_Mayor := 0;
                     fTasa_Mayor := 0;
                     bresult := False;
                  end;

                  if bresult then
                  begin
//                  if ( fTasa_Menor <> 0 ) and ( fTasa_Mayor <> 0 ) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then
                  if ( (fDias_Mayor - fDias_Menor) <> 0 ) then
                  begin
                     fValor_Tasa_1 := fTasa_Menor + ( ( iDiasDif - fDias_Menor) * ( fTasa_Mayor - fTasa_Menor ) / ( fDias_Mayor - fDias_Menor ) );
                     Result := True;
                  end
                  else
                     sString_Err := 'No se pudo interpolar tasa : '
                                    +RegParamMargen.Tasa_Base_1+#10
                                    +'Con Fecha '
                                    +DateToStr(dFecha)
                                    +' para '
                                    +FloatToStr(iDiasDif)
                                    +' días';
                  end
                  else
                     sString_Err := 'No se pudo interpolar tasa : '
                                    +RegParamMargen.Tasa_Base_1+#10
                                    +'Con Fecha '
                                    +DateToStr(dFecha)
                                    +' para '
                                    +FloatToStr(iDiasDif)
                                    +' días';


//                  if fValor_Tasa_1 = 0 then
//                     sString_Err := 'No se pudo interpolar tasa : '
//                                    +RegParamMargen.Tasa_Base_1+#10
//                                    +'Con Fecha '
//                                    +DateToStr(dFecha)
//                                    +' para '
//                                    +FloatToStr(iDiasDif)
//                                    +' días';
              end;
           end
           else
           begin
              // Rescato Tasa sin Interpolar
              SQL.Clear;
              SQL.Add('SELECT Valor'
                     +'  FROM QS_FIN_VALOR_TRAMO'
                     +' WHERE Fecha        = :Fecha'
                     +'   AND Codigo       = :Tasa'
                     +'   AND Dias_desde  <= :Dias'
                     +'   AND (Dias_hasta >= :Dias or dias_hasta is null)'
                     );
              ParamByName('Tasa' ).AsString   := RegParamMargen.Tasa_Base_1;
              ParamByName('Fecha').AsDate := dFecha_Tasa;
              ParamByName('Dias'  ).AsFloat   := iDiasDif;
              Prepare;
              Open;

              If Not Fieldbyname('Valor').IsNull then
              begin
                 fValor_Tasa_1 := Fieldbyname('Valor').asFloat;
                 Result      := True;
              end
              else
                 // ggarcia 25-02-2014
                 if iDiasDif = 0 then
                 begin
                    fValor_Tasa_1 := 0;
                    Result        := True;
                 end
                 else
                    sString_Err := 'No se encontro valor para: '
                                   +RegParamMargen.Tasa_Base_1+#10
                                   +'Con Fecha '
                                   +DateToStr(dFecha)
                                   +' para '
                                   +FloatToStr(iDiasDif)
                                   +' días';
           end;
           Close;
         end
         else
         Begin
              leer_valor_cambio2(RegParamMargen.Tasa_Base_1,
                                 RegParamMargen.Tasa_Base_1,
                                 'BC',
                                 dFecha,
                                 fValor_Tasa_1,
                                 Result);
              if NOT Result then
              begin
                Modulo_Err := 'Conversión de Unidad Monetaria';
                String_Err := 'No se registra paridad de '+trim(RegParamMargen.Tasa_Base_2)
                             +' a '+trim(RegParamMargen.Tasa_Base_2)+#10
                             +'con fecha: '+datetostr(dFecha_Tasa);
                Result := False;
                exit
              end
         end;

        End;
   end;

   If (RegParamMargen.Tasa_Base_2 <> '') Then
   Begin
      Leer_MonRedon_Mem(RegParamMargen.Tasa_Base_2
                       ,dFecha
                       ,sTipo_Ajuste
                       ,iDecimales_Redondeo);
      if iDecimales_Redondeo > 0 then
         iDiasDif := redondeo(iDiasDif,iDecimales_Redondeo);

      WITH DM_Leer_Valor_Cambio.QRY_General do
      begin
        Sql.Clear;
        Sql.Clear;
        Sql.Add( 'SELECT MAX(Fecha) as Fecha '
                +' FROM QS_FIN_VALOR_TRAMO'
                +' WHERE Fecha   <= :Fecha'
                +'   AND Codigo   = :Tasa'
               );
        ParamByName('Tasa' ).AsString   := RegParamMargen.Tasa_Base_2;
        ParamByName('Fecha').AsDate := dFecha;
        Open;

        EsTramo := False;
        if Not Fieldbyname( 'Fecha' ).IsNull then
        Begin
           dFecha_Tasa :=  Fieldbyname('Fecha').asDatetime;
           EsTramo := True;
        End
        else
            Begin
              Sql.Clear;
              Sql.Add( 'SELECT MAX(fecha_paridad) as Fecha '
                      +' FROM QS_SYS_VAL_CAMBIO'
                      +' WHERE fecha_paridad   <= :Fecha'
                      +'   AND Cod_Moneda   = :Tasa'
                     );
              ParamByName('Tasa' ).AsString   := RegParamMargen.Tasa_Base_2;
              ParamByName('Fecha').AsDate := dFecha;
              Open;
              if Not Fieldbyname( 'Fecha' ).IsNull then
                 dFecha_Tasa :=  Fieldbyname('Fecha').asDatetime
           End;
        if Fieldbyname( 'Fecha' ).IsNull then
        begin
           Close;
           sString_Err := 'No se encontro valor para: '
                          +RegParamMargen.Tasa_Base_2+#10
                          +'Con Fecha '
                          +DateToStr(dFecha)
                          +' para '
                          +FloatToStr(iDiasDif)
                          +' días';
           Exit;
        end;

        Close;

        If EsTramo  Then 
        Begin
           // si hay Interpolacion
           if RegParamMargen.Interpolacion_2 = 'I' then
           begin
              // Busco Tasa a Fecha Encontrada
              SQL.Clear;
              SQL.Add('SELECT Valor'
                     +'      ,Dias_Desde'
                     +'      ,Dias_Hasta'
                     +'  FROM QS_FIN_VALOR_TRAMO'
                     +' WHERE Fecha        = :Fecha'
                     +'   AND Codigo       = :Tasa'
                     +' ORDER BY Fecha'
                     );
              ParamByName('Tasa' ).AsString   := RegParamMargen.Tasa_Base_2;
              ParamByName('Fecha').AsDate := dFecha_Tasa;
              Prepare;
              Open;

              While Not Eof do
              begin
                 // Busco Rango de Dias
                 if ( Fieldbyname('Dias_desde').asFloat <= iDiasDif) and
                    (( Fieldbyname('Dias_hasta').asFloat >= iDiasDif ) or
                     ( Fieldbyname('Dias_hasta').isNull)
                    ) then
                 begin
                     // Si es Primer tramo esta es la tasa buscada
                     if Fieldbyname('Dias_desde').asFloat = 0 then
                     begin
                       fValor_Tasa_2 := Fieldbyname('Valor').asFloat;
                       Result      := True;
                       Break;
                     end;

                     // Si no es primer tramo se Interpola y este es el tramo mayor
                     //fDias_Mayor := 0;
                     if Not Fieldbyname('Dias_Hasta').IsNull then
                        fDias_Mayor := Fieldbyname('Dias_Hasta').asFloat
                     else // Si se esta en el ultimo tramo no se interpola y se usa esta
                     begin
                       fValor_Tasa_2 := Fieldbyname('Valor').asFloat;
                       Result      := True;
                       Break;
                     end;

                     fTasa_Mayor := 0;
                     if Not Fieldbyname('Valor').IsNull then
                        fTasa_Mayor := Fieldbyname('Valor').asFloat;

                     // si es el Primer rango no interpolo y esa es la tasa
                     Prior;
                     if Bof then
                     begin
                        fValor_Tasa_2 := fTasa_Mayor;
                        Result      := True;
                        Break;
                     end;

                     fTasa_Menor := 0;
                     if Not Fieldbyname('Valor').IsNull then
                        fTasa_Menor := Fieldbyname('Valor').asFloat;

                     fDias_Menor := 0;
                     if Not Fieldbyname('Dias_Hasta').IsNull then // Antes
                        fDias_Menor := Fieldbyname('Dias_Hasta').asFloat;


                     if ( fDias_Mayor - fDias_Menor ) <> 0 then
                     begin
                        fValor_Tasa_2 := fTasa_Menor + (( iDiasDif - fDias_Menor) * ( fTasa_Mayor -fTasa_Menor ) /
                                                      ( fDias_Mayor - fDias_Menor )
                                                      );
                        Result := True;
                     end;
                    Break;
                 end;
                 Next;
              end
           end
           else
           begin
              // Rescato Tasa sin Interpolar
              SQL.Clear;
              SQL.Add('SELECT Valor'
                     +'  FROM QS_FIN_VALOR_TRAMO'
                     +' WHERE Fecha        = :Fecha'
                     +'   AND Codigo       = :Tasa'
                     +'   AND Dias_desde  <= :Dias'
                     +'   AND (Dias_hasta >= :Dias or dias_hasta is null)'
                     );
              ParamByName('Tasa' ).AsString   := RegParamMargen.Tasa_Base_2;
              ParamByName('Fecha').AsDate := dFecha_Tasa;
              ParamByName('Dias'  ).AsFloat   := iDiasDif;
              Prepare;
              Open;

              If Not Fieldbyname('Valor').IsNull then
              begin
                 fValor_Tasa_2 := Fieldbyname('Valor').asFloat;
                 Result      := True;
              end
              else
                 sString_Err := 'No se encontro valor para: '
                                +RegParamMargen.Tasa_Base_2+#10
                                +'Con Fecha '
                                +DateToStr(dFecha)
                                +' para '
                                +FloatToStr(iDiasDif)
                                +' días';

           end;
           Close;
           end
        Else
         Begin
              leer_valor_cambio2(RegParamMargen.Tasa_Base_2,
                                 RegParamMargen.Tasa_Base_2,
                                 'BC',
                                 dFecha,
                                 fValor_Tasa_2,
                                 Result);
              if NOT Result then
              begin
                Modulo_Err := 'Conversión de Unidad Monetaria';
                String_Err := 'No se registra paridad de '+trim(RegParamMargen.Tasa_Base_2)
                             +' a '+RegParamMargen.Tasa_Base_2+#10
                             +'con fecha: '+datetostr(dFecha_Tasa);
                Result := False;
                exit
              end

        end;
      end;
   end;
End;

procedure Lee_Tasa_Tramos_Interpolacion(sCodigo_Tasa    : string;
                                        dFecha          : TDateTime;
                                        fPlazo          : Double;
                                        var fValor_Tasa : Double;
                                        var sModulo_Err : String;
                                        var sString_Err : String;
                                        var Result      : Boolean);
var
  dFecha_Tasa      : TDatetime;
  fTasa_Menor,
  fTasa_Mayor,
  fDias_Menor,
  fDias_Mayor      : Double;

  Modulo_Err : String;
  String_Err : String;
  bresult    :  Boolean;
  sTipo_Ajuste             : String;
  iDecimales_Redondeo      : Integer;

begin
   fTasa_Menor := 0;
   //fTasa_Mayor := 0;
   fDias_Menor := 0;
   //fDias_Mayor := 0;

   sModulo_Err := 'Valor Tasa Tramo : ';
   Result      := False;
   bresult     := True;

   WITH DM_Leer_Valor_Cambio.QRY_General do
   begin
     Sql.Clear;
     Sql.Add( 'SELECT MAX(Fecha) as Fecha '
             +' FROM QS_FIN_VALOR_TRAMO'
             +' WHERE Fecha   <= :Fecha'
             +'   AND Codigo   = :Tasa'
            );
     ParamByName('Tasa' ).AsString   := sCodigo_Tasa;
     ParamByName('Fecha').AsDate := dFecha;
     Open;

     if Not Fieldbyname( 'Fecha' ).IsNull then
        dFecha_Tasa :=  Fieldbyname('Fecha').asDatetime;

     if Fieldbyname( 'Fecha' ).IsNull then
     begin
        Close;
        sString_Err := 'No se encontro valor para: '
                       +sCodigo_Tasa+#10
                       +'Con Fecha '
                       +DateToStr(dFecha)
                       +' para '
                       +FloatToStr(fPlazo)
                       +' días';
        Exit;
     end;

     Close;

     // si hay Interpolacion
     // Busco Tasa a Fecha Encontrada
     SQL.Clear;
     SQL.Add('SELECT Valor '
            +'      ,Dias_Desde '
            +'      ,Dias_Hasta '
            +'  FROM QS_FIN_VALOR_TRAMO '
            +' WHERE Fecha        = :Fecha '
            +'   AND Codigo       = :Tasa '
            +'   AND Dias_Desde   = (SELECT max(Dias_Desde) '
            +'                         FROM QS_FIN_VALOR_TRAMO '
            +'                        WHERE Fecha        = :Fecha '
            +'                          AND Codigo       = :Tasa '
            +'                          AND Dias_Desde   <= :Dias_Desde) ' // Se cambia a Menor o igual para que tome el tramo si cae justo F.I., 09-04-2014
            );
     ParamByName('Tasa').AsString       := sCodigo_Tasa;
     ParamByName('Fecha').AsDate        := dFecha_Tasa;
     ParamByName('Dias_Desde').AsFloat  := fPlazo;
     Open;
     if Not Eof then
     begin
        fDias_Menor := FieldByName('Dias_Desde').AsFloat;
        fTasa_Menor := FieldByName('Valor').AsFloat;
     end;

     // Si coincide justo el numero de dias biscado con dias menor, no es necesario leer otro dato para interpolar  F.I. 13-04-2016
     if fDias_Menor = fPlazo then
     begin
       fValor_Tasa := fTasa_Menor;
       Result := True;
     end
     else  // lee segundo tramo para interpolar...
     begin
         Close;
         SQL.Clear;
         SQL.Add('SELECT Valor '
                +'      ,Dias_Desde '
                +'      ,Dias_Hasta '
                +'  FROM QS_FIN_VALOR_TRAMO '
                +' WHERE Fecha        = :Fecha '
                +'   AND Codigo       = :Tasa '
                +'   AND Dias_Desde   = (SELECT min(Dias_Desde) '
                +'                         FROM QS_FIN_VALOR_TRAMO '
                +'                        WHERE Fecha        = :Fecha '
                +'                          AND Codigo       = :Tasa '
                +'                          AND Dias_Desde   > :Dias_Desde) '
                );
         ParamByName('Tasa').AsString       := sCodigo_Tasa;
         ParamByName('Fecha').AsDate        := dFecha_Tasa;
         ParamByName('Dias_Desde').AsFloat  := fPlazo;
         Open;
         if Not Eof then
         begin
            fDias_Mayor := FieldByName('Dias_Desde').AsFloat;
            fTasa_Mayor := FieldByName('Valor').AsFloat;
         end
         else
         begin
            fDias_Mayor := 0;
            fTasa_Mayor := 0;
            bresult := False;
         end;

         if bresult then
         begin
           if ( (fDias_Mayor - fDias_Menor) <> 0 ) then
           begin
              fValor_Tasa := fTasa_Menor + ( ( fPlazo - fDias_Menor) * ( fTasa_Mayor - fTasa_Menor ) / ( fDias_Mayor - fDias_Menor ) );
              Result := True;
           end
           else
              sString_Err := 'No se pudo interpolar tasa : '
                             +sCodigo_Tasa+#10
                             +'Con Fecha '
                             +DateToStr(dFecha)
                             +' para '
                             +FloatToStr(fPlazo)
                             +' días';
         end
         else
            sString_Err := 'No se pudo interpolar tasa : '
                           +sCodigo_Tasa+#10
                           +'Con Fecha '
                           +DateToStr(dFecha)
                           +' para '
                           +FloatToStr(fPlazo)
                           +' días';
     end;
     Close;
   End;

End;

procedure Lee_Tasa_CapRes(sInstrumento      : String;
                          sMoneda           : String;
                          dFecha            : TDateTime;
                          fCapital_Residual : Double;
                          var fValor_Tasa_1 : Double;
                          var sModulo_Err   : String;
                          var sString_Err   : String;
                          var Result        : Boolean);
//var Modulo_Err : String;
//    String_Err : String;
begin
   sModulo_Err := 'Valor Tasa Tramo : ';
   Result      := False;
   if fValor_Tasa_1 = 0 then
   begin
      with DM_Leer_Valor_Cambio.QRY_General do
      begin
         // Rescato Tasa sin Interpolar
         SQL.Clear;
         SQL.Add('select b.TASA '
                +'  from QS_FIN_VALTRA_CAPRES     a '
                +'      ,QS_FIN_VALTRA_CAPRES_DET b '
                +' where (a.FECHA_DESDE <= :Fecha and (a.FECHA_HASTA >= :Fecha OR a.FECHA_HASTA is null)) '
                +'   and a.INSTRUMENTO = :Instrumento '
                +'   and a.MONEDA      = :Moneda '
                +'   and b.FECHA_DESDE = a.FECHA_DESDE '
                +'   and b.INSTRUMENTO = a.INSTRUMENTO '
                +'   and b.MONEDA      = a.MONEDA '
                +'   and (b.TRAMO_DESDE <= :Capital_Residual and b.TRAMO_HASTA >= :Capital_Residual )'
                );
         ParamByName('Fecha').AsDate         := dFecha;
         ParamByName('Instrumento').AsString     := sInstrumento;
         ParamByName('Moneda').AsString          := sMoneda;
         ParamByName('Capital_Residual').AsFloat := fCapital_Residual;
         Prepare;
         Open;
         if Not Fieldbyname('TASA').IsNull then
         begin
            fValor_Tasa_1 := Fieldbyname('TASA').asFloat;
            Result      := True;
         end
         else
            sString_Err := 'No se encontro tasa para: '
                           +sInstrumento+' - '+sMoneda+#10
                           +'Con Fecha '
                           +DateToStr(dFecha)
                           +' para Capital Residual '
                           +FloatToStr(fCapital_Residual);
         Close;
      end;
   end;

end;

procedure Lee_Valores_Tramos(RegParamMargen    : TRegParamMargen;
                             sTipo             : String;
                             sNemotecnico      : String;
                             dFecha            : TDateTime;
                             iDiasDif          : Double;
                             bDia_Habil        : Boolean;
                             var fValor_Tasa_1 : Double;
                             var fValor_Tasa_2 : Double;
                             var sModulo_Err   : String;
                             var sString_Err   : String;
                             var Result        : Boolean);
var
  //bBuscar          : Boolean;
  //sCodigo_Division : String;
  //dFecha_Tasa      : TDatetime;
  fTasa_Menor,
  fTasa_Mayor,
  fDias_Menor,
  fDias_Mayor      : Double;
  //EsTramo          : Boolean;

  //Modulo_Err : String;
  //String_Err : String;

begin
   sModulo_Err := 'Valor Tasa Tramo : ';
   Result      := False;
   if (RegParamMargen.Cod_Valor1 <> '') then
   begin
      with DM_Leer_Valor_Cambio.QRY_General do
      begin
         // si hay Interpolacion
         if RegParamMargen.Interpolacion_1 = 'I' then
         begin
            // Busco Tasa a Fecha Encontrada
            SQL.Clear;
            SQL.Add('SELECT Valor'
                   +'      ,Dias_Desde'
                   +'      ,Dias_Hasta'
                   +'  FROM QS_FIN_NEM_VALOR_TRAMO'
                   +' WHERE Fecha        = :Fecha'
                   +'   AND Codigo       = :Codigo'
                   +'   AND Tipo         = :Tipo'
                   +' ORDER BY Fecha'
                   );
            ParamByName('Codigo' ).AsString := sNemotecnico;
            ParamByName('Tipo' ).AsString   := sTipo;
            ParamByName('Fecha').AsDate := dFecha;
            Open;

            While Not Eof do
            begin
               // Busco Rango de Dias
               if ( Fieldbyname('Dias_desde').asFloat <= iDiasDif) and
                  (( Fieldbyname('Dias_hasta').asFloat >= iDiasDif ) or
                   ( Fieldbyname('Dias_hasta').isNull)
                  ) then
               begin
                  // Si es Primer tramo esta es la tasa buscada
                  if Fieldbyname('Dias_desde').asFloat = 0 then
                  begin
                    fValor_Tasa_1 := Fieldbyname('Valor').asFloat;
                    Result      := True;
                    Break;
                  end;

                  // Si no es primer tramo se Interpola y este es el tramo mayor
                  //fDias_Mayor := 0;
                  if Not Fieldbyname('Dias_Hasta').IsNull then
                     fDias_Mayor := Fieldbyname('Dias_Hasta').asFloat
                  else // Si se esta en el ultimo tramo no se interpola y se usa esta
                  begin
                    fValor_Tasa_1 := Fieldbyname('Valor').asFloat;
                    Result      := True;
                    Break;
                  end;

                  fTasa_Mayor := 0;
                  if Not Fieldbyname('Valor').IsNull then
                     fTasa_Mayor := Fieldbyname('Valor').asFloat;

                  // si es el Primer rango no interpolo y esa es la tasa
                  Prior;
                  if Bof then
                  begin
                     fValor_Tasa_1 := fTasa_Mayor;
                     Result      := True;
                     Break;
                  end;

                  fTasa_Menor := 0;
                  if Not Fieldbyname('Valor').IsNull then
                     fTasa_Menor := Fieldbyname('Valor').asFloat;

                  fDias_Menor := 0;
                  if Not Fieldbyname('Dias_Hasta').IsNull then // Antes
                     fDias_Menor := Fieldbyname('Dias_Hasta').asFloat;


                  if ( fDias_Mayor - fDias_Menor ) <> 0 then
                  begin
                     fValor_Tasa_1 := fTasa_Menor + (( iDiasDif - fDias_Menor) * ( fTasa_Mayor -fTasa_Menor ) /
                                                   ( fDias_Mayor - fDias_Menor )
                                                   );
                     Result := True;
                  end;
                  Break;
               end;
               Next;
            end
         end
         else
         begin
            // Rescato Tasa sin Interpolar
            SQL.Clear;
            SQL.Add('SELECT Valor'
                   +'  FROM QS_FIN_NEM_VALOR_TRAMO'
                   +' WHERE Fecha        = :Fecha'
                   +'   AND Codigo       = :Codigo'
                   +'   AND Tipo         = :Tipo'
                   +'   AND Dias_desde  <= :Dias'
                   +'   AND (Dias_hasta >= :Dias or dias_hasta is null)'
                   );
            ParamByName('Codigo' ).AsString := sNemotecnico;
            ParamByName('Tipo' ).AsString   := sTipo;
            ParamByName('Fecha').AsDate := dFecha;
            ParamByName('Dias'  ).AsFloat   := iDiasDif;
            Prepare;
            Open;

            if Not Fieldbyname('Valor').IsNull then
            begin
               fValor_Tasa_1 := Fieldbyname('Valor').asFloat;
               Result      := True;
            end
            else
               sString_Err := 'No se encontro valor para: '
                              +sNemotecnico+#10
                              +'Con Fecha '
                              +DateToStr(dFecha)
                              +' para '
                              +FloatToStr(iDiasDif)
                              +' días';

         end;
      end;
   end;

   if (RegParamMargen.Cod_Valor2 <> '') then
   begin
      with DM_Leer_Valor_Cambio.QRY_General do
      begin
         // si hay Interpolacion
         if RegParamMargen.Interpolacion_2 = 'I' then
         begin
            // Busco Tasa a Fecha Encontrada
            SQL.Clear;
            SQL.Add('SELECT Valor'
                   +'      ,Dias_Desde'
                   +'      ,Dias_Hasta'
                   +'  FROM QS_FIN_NEM_VALOR_TRAMO'
                   +' WHERE Fecha        = :Fecha'
                   +'   AND Codigo       = :Tasa'
                   +'   AND Tipo         = :Tipo'
                   +' ORDER BY Fecha'
                   );
            ParamByName('Codigo' ).AsString := sNemotecnico;
            ParamByName('Tipo' ).AsString   := sTipo;
            ParamByName('Fecha').AsDate := dFecha;
            Prepare;
            Open;

            while Not Eof do
            begin
               // Busco Rango de Dias
               if ( Fieldbyname('Dias_desde').asFloat <= iDiasDif) and
                  (( Fieldbyname('Dias_hasta').asFloat >= iDiasDif ) or
                   ( Fieldbyname('Dias_hasta').isNull)
                  ) then
               begin
                   // Si es Primer tramo esta es la tasa buscada
                   if Fieldbyname('Dias_desde').asFloat = 0 then
                   begin
                     fValor_Tasa_2 := Fieldbyname('Valor').asFloat;
                     Result      := True;
                     Break;
                   end;

                   // Si no es primer tramo se Interpola y este es el tramo mayor
                   //fDias_Mayor := 0;
                   if Not Fieldbyname('Dias_Hasta').IsNull then
                      fDias_Mayor := Fieldbyname('Dias_Hasta').asFloat
                   else // Si se esta en el ultimo tramo no se interpola y se usa esta
                   begin
                     fValor_Tasa_2 := Fieldbyname('Valor').asFloat;
                     Result      := True;
                     Break;
                   end;

                   fTasa_Mayor := 0;
                   if Not Fieldbyname('Valor').IsNull then
                      fTasa_Mayor := Fieldbyname('Valor').asFloat;

                   // si es el Primer rango no interpolo y esa es la tasa
                   Prior;
                   if Bof then
                   begin
                      fValor_Tasa_2 := fTasa_Mayor;
                      Result      := True;
                      Break;
                   end;

                   fTasa_Menor := 0;
                   if Not Fieldbyname('Valor').IsNull then
                      fTasa_Menor := Fieldbyname('Valor').asFloat;

                   fDias_Menor := 0;
                   if Not Fieldbyname('Dias_Hasta').IsNull then // Antes
                      fDias_Menor := Fieldbyname('Dias_Hasta').asFloat;


                   if ( fDias_Mayor - fDias_Menor ) <> 0 then
                   begin
                      fValor_Tasa_2 := fTasa_Menor + (( iDiasDif - fDias_Menor) * ( fTasa_Mayor -fTasa_Menor ) /
                                                    ( fDias_Mayor - fDias_Menor )
                                                    );
                      Result := True;
                   end;
                  Break;
               end;
               Next;
            end
         end
         else
         begin
            // Rescato Tasa sin Interpolar
            SQL.Clear;
            SQL.Add('SELECT Valor'
                   +'  FROM QS_FIN_NEM_VALOR_TRAMO'
                   +' WHERE Fecha        = :Fecha'
                   +'   AND Codigo       = :Codigo'
                   +'   AND Tipo         = :Tipo'
                   +'   AND Dias_desde  <= :Dias'
                   +'   AND (Dias_hasta >= :Dias or dias_hasta is null)'
                   );
            ParamByName('Codigo' ).AsString := sNemotecnico;
            ParamByName('Tipo' ).AsString   := sTipo;
            ParamByName('Fecha').AsDate := dFecha;
            ParamByName('Dias'  ).AsFloat   := iDiasDif;
            Prepare;
            Open;

            if Not Fieldbyname('Valor').IsNull then
            begin
               fValor_Tasa_2 := Fieldbyname('Valor').asFloat;
               Result      := True;
            end
            else
               sString_Err := 'No se encontro valor para: '
                              +sNemotecnico+#10
                              +'Con Fecha '
                              +DateToStr(dFecha)
                              +' para '
                              +FloatToStr(iDiasDif)
                              +' días';

         end;
      end;
   end;

End;


procedure Moneda_Conversion_Avanzada( sSistema     : String;
                                      sProceso     : String;
                                      sInstrumento : String;
                                      sMoneda      : String;
                                      var sMoneda_Conversion : String);
begin
  sMoneda_Conversion := '';


  // NUEVO:
  // Se incluye parametro proceso, que indica si corresponde a transacciones
  // o aun proceso de cierre

  WITH DM_Leer_Valor_Cambio.QRY_General do
  begin
    // Clasificacion - Moneda
    SQL.Clear;
    SQL.Add('SELECT Moneda_Conversion                        ');
    SQL.Add('FROM QS_SYS_CONVER_AVANZ a                      ');
    SQL.Add('    ,QS_SYS_CLASIF_OBJ b                        ');
    SQL.Add('WHERE a.SISTEMA = :Sistema                      ');
    SQL.Add('AND a.TIPO_TRANSA_PROC = :PROCESO                        ');
    SQL.Add('AND b.elemento  = :Instrumento                  ');
    SQL.Add('AND b.OBJETO    = ''INSTRUM''                   ');
    SQL.Add('AND b.CODIGO_CLASIF = a.TIPO_CLASIFICACION      ');
    SQL.Add('AND b.NODO		 = a.CLASIFICACION           ');
    SQL.Add('AND a.MONEDA 	 = :Moneda                   ');


    ParamByName('Sistema'    ).AsString := sSistema;
    ParamByName('Instrumento').AsString := sInstrumento;
    ParamByName('Moneda'     ).AsString := sMoneda;
    ParamByName('PROCESO'     ).AsString := sPROCESO;

    Open;
    if NOT FieldByName('Moneda_Conversion').IsNull then
    begin
       sMoneda_Conversion := FieldByName('Moneda_Conversion').AsString;
       Close;
       exit;
    end;

    // Clasificacion
    SQL.Clear;
    SQL.Add('SELECT Moneda_Conversion                        ');
    SQL.Add('FROM QS_SYS_CONVER_AVANZ a                      ');
    SQL.Add('    ,QS_SYS_CLASIF_OBJ b                        ');
    SQL.Add('WHERE a.SISTEMA = :Sistema                      ');
    SQL.Add('AND a.TIPO_TRANSA_PROC = :PROCESO                        ');
    SQL.Add('  AND b.elemento  = :Instrumento                  ');
    SQL.Add('  AND b.OBJETO    = ''INSTRUM''                   ');
    SQL.Add('  AND b.CODIGO_CLASIF = a.TIPO_CLASIFICACION      ');
    SQL.Add('  AND b.NODO	   = a.CLASIFICACION           ');
    SQL.Add('  AND a.Moneda IS NULL                            ');


    ParamByName('Sistema'    ).AsString := sSistema;
    ParamByName('Instrumento').AsString := sInstrumento;
    ParamByName('PROCESO'     ).AsString := sPROCESO;

    Open;
    if NOT FieldByName('Moneda_Conversion').IsNull then
    begin
       sMoneda_Conversion := FieldByName('Moneda_Conversion').AsString;
       Close;
       exit;
    end;

    // Instrumento - Moneda
    SQL.Clear;
    SQL.Add('SELECT Moneda_Conversion                        ');
    SQL.Add('FROM QS_SYS_CONVER_AVANZ a                      ');
    SQL.Add('WHERE a.SISTEMA = :Sistema                      ');
    SQL.Add('AND a.TIPO_TRANSA_PROC = :PROCESO                        ');
    SQL.Add('  AND a.INSTRUMENTO = :Instrumento              ');
    SQL.Add('  AND a.MONEDA 	 = :Moneda                   ');
    ParamByName('Sistema'    ).AsString := sSistema;
    ParamByName('Instrumento').AsString := sInstrumento;
    ParamByName('Moneda'     ).AsString := sMoneda;
    ParamByName('PROCESO'     ).AsString := sPROCESO;

    Open;
    if NOT FieldByName('Moneda_Conversion').IsNull then
    begin
       sMoneda_Conversion := FieldByName('Moneda_Conversion').AsString;
       Close;
       exit;
    end;

    // Instrumento
    SQL.Clear;
    SQL.Add('SELECT Moneda_Conversion                        ');
    SQL.Add('FROM QS_SYS_CONVER_AVANZ a                      ');
    SQL.Add('WHERE a.SISTEMA = :Sistema                      ');
    SQL.Add('AND a.TIPO_TRANSA_PROC = :PROCESO                        ');
    SQL.Add('  AND a.INSTRUMENTO = :Instrumento              ');
    SQL.Add('  AND a.Moneda IS NULL                          ');
    ParamByName('Sistema'    ).AsString := sSistema;
    ParamByName('Instrumento').AsString := sInstrumento;
    ParamByName('PROCESO'     ).AsString := sPROCESO;

    Open;
    if NOT FieldByName('Moneda_Conversion').IsNull then
    begin
       sMoneda_Conversion := FieldByName('Moneda_Conversion').AsString;
       Close;
       exit;
    end;

    // Moneda
    SQL.Clear;
    SQL.Add('SELECT Moneda_Conversion                        ');
    SQL.Add('FROM QS_SYS_CONVER_AVANZ a                      ');
    SQL.Add('WHERE a.SISTEMA = :Sistema                      ');
    SQL.Add('AND a.TIPO_TRANSA_PROC = :PROCESO                        ');
    SQL.Add('  AND a.Moneda = :Moneda                        ');
    SQL.Add('  AND a.Tipo_Clasificacion IS NULL              ');
    SQL.Add('  AND a.Instrumento IS NULL                     ');
    ParamByName('Sistema'    ).AsString := sSistema;
    ParamByName('Moneda'     ).AsString := sMoneda;
    ParamByName('PROCESO'     ).AsString := sPROCESO;

    Open;
    if NOT FieldByName('Moneda_Conversion').IsNull then
    begin
       sMoneda_Conversion := FieldByName('Moneda_Conversion').AsString;
       Close;
       exit;
    end;
    Close;
  end; // DM_Leer_Valor_Cambio.QRY_General
end;

procedure conversion_unidad_mon_con_proyeccion( sUniMon_origen,
                                                sUniMon_Resultado,
                                                sTipo_Cambio  : String;
                                                dfecha_cambio : TDateTime;
                                                dValor_origen : double;
                                                var dValor_Resultado : double;
                                                var Modulo_Err : String;
                                                var String_Err : String;
                                                var Result     : boolean);

var //bBusca_Proy_Precios : Boolean;
    bFecha_Tope         : Boolean;
    //fCantidad           : Double;
    //sUnidad             : String;
    sAntes_Despues      : String;
    //sPais_Tasa          : String;
    dFecha_Tope         : TDateTime;
    dFecha_TipoCambio   : TDateTime;

begin
    conversion_unidad_mon( sUniMon_origen
                          ,sUniMon_Resultado
                          ,sTipo_Cambio
                          ,dfecha_cambio
                          ,dValor_origen
                          ,dValor_Resultado
                          ,Modulo_Err
                          ,String_Err
                          ,Result     );

    if NOT Result then
    begin
          dFecha_Tope       := dfecha_cambio;
          dFecha_TipoCambio := dfecha_cambio;

          lee_proy_Fecha_Tope(  sUniMon_origen
                               ,dfecha_cambio
                               ,dFecha_Tope
                               ,sAntes_Despues
                               ,bFecha_Tope
                            );
          if bFecha_Tope then
          begin
             while True do
             begin
                if sAntes_Despues = 'A' then
                begin
                   dFecha_TipoCambio := dFecha_TipoCambio - 1;
                   if (dFecha_TipoCambio = (dFecha_Tope - 1 )) then
                      break;
                end
                else
                begin
                   dFecha_TipoCambio := dFecha_TipoCambio + 1;
                   if (dFecha_TipoCambio = (dFecha_Tope + 1 )) then
                      break;
                end;

                conversion_unidad_mon( sUniMon_origen
                                      ,sUniMon_Resultado
                                      ,sTipo_Cambio
                                      ,dFecha_TipoCambio
                                      ,dValor_origen
                                      ,dValor_Resultado
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result     );

                if Result then
                   Break;
             end;
        end;
    end;
end;

procedure Buscar_valor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                              const sTipo_Paridad   : String;
                                              const sMoneda_Paridad : String;
                                              const sTipo_Moneda    : String;
                                              dFecha_Paridad        : TDatetime;
                                              fdias                 : Double;
                                              var fValor            : Double;
                                              var bResult           : Boolean);
var fDias_Mayor : Double;
    fTasa_Mayor : Double;
    fTasa_Menor : Double;
    fDias_Menor : Double;
    bencontro_Mayor,
    bencontro_Menor : Boolean;
begin

   fDias_Mayor := 0;
   fTasa_Mayor := 0;
   fTasa_Menor := 0;
   fDias_Menor := 0;
   fValor      := 0;
   bResult     := false;
   bencontro_Mayor := false;
   bencontro_Menor := false;

   with DM_Leer_Valor_Cambio.QRY_General do
   begin
      // Busco Tasa a Fecha Encontrada
      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('   AND a.Fecha           = :Fecha ');
      SQL.Add('   AND a.Origen          = :Origen ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT max(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Fecha           = :Fecha ');
      SQL.Add('                               AND a.Origen          = :Origen ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      <= :Dias_Desde) ');  // Se cambia a Menor o igual para que tome el tramo si cae justo F.I., 09-04-2014

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate        := dFecha_Paridad;
      Parambyname('Origen').asString         := default_codgen('ORIGEN','FI','');
      Parambyname('Dias_Desde').asfloat      := fdias;
      Open;
      if not eof then
      begin
         bencontro_Menor := True;
         fDias_Menor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Menor := Fieldbyname('Valor').asfloat;
      end;
      Close;

      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('   AND a.Fecha           = :Fecha ');
      SQL.Add('   AND a.Origen          = :Origen ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT min(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Fecha           = :Fecha ');
      SQL.Add('                               AND a.Origen          = :Origen ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      > :Dias_Desde) ');

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate        := dFecha_Paridad;
      Parambyname('Origen').asString         := default_codgen('ORIGEN','FI','');
      Parambyname('Dias_Desde').asfloat      := fdias;
      Open;
      if not eof then
      begin
         bencontro_Mayor := True;
         fDias_Mayor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Mayor := Fieldbyname('Valor').asfloat;
      end;

      //if ( fTasa_Menor <> 0 ) and ( fTasa_Mayor <> 0 ) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then   DC 26/12/2014 porque existe valor en cero

      if (bencontro_Mayor) and (bencontro_Menor) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then
      begin
         fValor  := fTasa_Menor + (( fdias - fDias_Menor) * ( fTasa_Mayor - fTasa_Menor ) / ( fDias_Mayor - fDias_Menor ));
         bResult := True;
      end;

   end;

end;

procedure Buscar_Lastvalor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                                  const sOrigen         : String;
                                                  const sTipo_Paridad   : String;
                                                  const sMoneda_Paridad : String;
                                                  const sTipo_Moneda    : String;
                                                  dFecha_Paridad        : TDatetime;
                                                  fdias                 : Double;
                                                  var fValor            : Double;
                                                  var bResult           : Boolean);
var fDias_Mayor : Double;
    fTasa_Mayor : Double;
    fTasa_Menor : Double;
    fDias_Menor : Double;
    bencontro_Mayor,
    bencontro_Menor : Boolean;
begin

   fDias_Mayor := 0;
   fTasa_Mayor := 0;
   fTasa_Menor := 0;
   fDias_Menor := 0;
   fValor      := 0;
   bResult     := false;
   bencontro_Mayor := false;
   bencontro_Menor := false;

   with DM_Leer_Valor_Cambio.QRY_General do
   begin
      // Busco Tasa a Fecha Encontrada
      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
   //   SQL.Add('   AND a.Fecha           <= :Fecha ');
      SQL.Add('   AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('	                	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('		                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('	                    and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('	                    AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('	                    AND x.Origen         = a.Origen ');
			SQL.Add('	                    AND x.Fecha          <= :Fecha) ');

      SQL.Add('   AND a.Origen          = :Origen ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT max(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Origen          = :Origen ');
//      SQL.Add('                               AND a.Fecha           <= :Fecha ');
      SQL.Add('                               AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('	                                            	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('	                            	                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('	                                                and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('	                                                AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('	                                                AND x.Origen         = a.Origen ');
			SQL.Add('	                                                AND x.Fecha          <= :Fecha) ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      <= :Dias_Desde) ');  // Se cambia a Menor o igual para que tome el tramo si cae justo F.I., 09-04-2014

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate            := dFecha_Paridad;
      Parambyname('Origen').asString         := sOrigen;
      Parambyname('Dias_Desde').asfloat      := fdias;
      Open;
      if not eof then
      begin
         bencontro_Menor := True;
         fDias_Menor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Menor := Fieldbyname('Valor').asfloat;
      end;
      Close;

      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add('      ,QS_TMP_VAL_TRAMO  e ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('   AND a.Origen          = :Origen ');
//      SQL.Add('   AND a.Fecha           <= :Fecha ');
      SQL.Add('   AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('	                	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('		                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('	                    and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('	                    AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('	                    AND x.Origen         = a.Origen ');
			SQL.Add('	                    AND x.Fecha          <= :Fecha) ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT min(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Origen          = :Origen ');
//      SQL.Add('                               AND a.Fecha           <= :Fecha ');
      SQL.Add('                               AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('                            	                	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('                            		                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('                            	                    and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('                            	                    AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('                            	                    AND x.Origen         = a.Origen ');
			SQL.Add('                            	                    AND x.Fecha          <= :Fecha) ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      > :Dias_Desde) ');

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate        := dFecha_Paridad;
      Parambyname('Origen').asString         := sOrigen;
      Parambyname('Dias_Desde').asfloat      := fdias;
      Open;
      if not eof then
      begin
         bencontro_Mayor := True;
         fDias_Mayor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Mayor := Fieldbyname('Valor').asfloat;
      end;

      //if ( fTasa_Menor <> 0 ) and ( fTasa_Mayor <> 0 ) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then   DC 26/12/2014 porque existe valor en cero

      if (bencontro_Mayor) and (bencontro_Menor) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then
      begin
         fValor  := fTasa_Menor + (( fdias - fDias_Menor) * ( fTasa_Mayor - fTasa_Menor ) / ( fDias_Mayor - fDias_Menor ));
         bResult := True;
      end;

   end;

end;

procedure Buscar_Lastvalor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                                  const sTipo_Paridad   : String;
                                                  const sMoneda_Paridad : String;
                                                  const sTipo_Moneda    : String;
                                                  dFecha_Paridad        : TDatetime;
                                                  fdias                 : Double;
                                                  var fValor            : Double;
                                                  var bResult           : Boolean);
var fDias_Mayor : Double;
    fTasa_Mayor : Double;
    fTasa_Menor : Double;
    fDias_Menor : Double;
    bencontro_Mayor,
    bencontro_Menor : Boolean;
begin

   fDias_Mayor := 0;
   fTasa_Mayor := 0;
   fTasa_Menor := 0;
   fDias_Menor := 0;
   fValor      := 0;
   bResult     := false;
   bencontro_Mayor := false;
   bencontro_Menor := false;

   with DM_Leer_Valor_Cambio.QRY_General do
   begin
      // Busco Tasa a Fecha Encontrada
      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
//      SQL.Add('   AND a.Fecha           <= :Fecha ');
      SQL.Add('   AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('	                	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('		                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('	                    and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('	                    AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('	                    AND x.Origen         = a.Origen ');
			SQL.Add('	                    AND x.Fecha          <= :Fecha) ');
      SQL.Add('   AND a.Origen          = :Origen ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT max(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Origen          = :Origen ');
//      SQL.Add('                               AND a.Fecha           <= :Fecha ');
      SQL.Add('                               AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('	                                            	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('	                             	                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('	                                                and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('	                                                AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('	                                                AND x.Origen         = a.Origen ');
			SQL.Add('	                                                AND x.Fecha          <= :Fecha) ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      <= :Dias_Desde) ');  // Se cambia a Menor o igual para que tome el tramo si cae justo F.I., 09-04-2014

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate            := dFecha_Paridad;
      Parambyname('Origen').asString         := default_codgen('ORIGEN','FI','');
      Parambyname('Dias_Desde').asfloat      := fdias;
      Open;
      if not eof then
      begin
         bencontro_Menor := True;
         fDias_Menor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Menor := Fieldbyname('Valor').asfloat;
      end;
      Close;

      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add('      ,QS_TMP_VAL_TRAMO  e ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('   AND a.Origen          = :Origen ');
//      SQL.Add('   AND a.Fecha           <= :Fecha ');
      SQL.Add('   AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('	                	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('		                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('	                    and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('	                    AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('	                    AND x.Origen         = a.Origen ');
			SQL.Add('	                    AND x.Fecha          <= :Fecha) ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT min(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Origen          = :Origen ');
//      SQL.Add('                               AND a.Fecha           <= :Fecha ');
      SQL.Add('                               AND a.fecha = (SELECT max(x.fecha)  ');
			SQL.Add('	                                            	 FROM QS_SYS_VAL_TRAMO  x  ');
		  SQL.Add('	                            	                WHERE x.Cod_Moneda     = a.Cod_Moneda ');
			SQL.Add('	                                                and x.tipo_paridad   = a.tipo_paridad ');
			SQL.Add('	                                                AND x.Moneda_Paridad = a.Moneda_Paridad  ');
			SQL.Add('	                                                AND x.Origen         = a.Origen ');
			SQL.Add('	                                                AND x.Fecha          <= :Fecha) ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      > :Dias_Desde) ');

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate        := dFecha_Paridad;
      Parambyname('Origen').asString     := default_codgen('ORIGEN','FI','');
      Parambyname('Dias_Desde').asfloat  := fdias;
      Open;
      if not eof then
      begin
         bencontro_Mayor := True;
         fDias_Mayor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Mayor := Fieldbyname('Valor').asfloat;
      end;

      //if ( fTasa_Menor <> 0 ) and ( fTasa_Mayor <> 0 ) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then   DC 26/12/2014 porque existe valor en cero

      if (bencontro_Mayor) and (bencontro_Menor) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then
      begin
         fValor  := fTasa_Menor + (( fdias - fDias_Menor) * ( fTasa_Mayor - fTasa_Menor ) / ( fDias_Mayor - fDias_Menor ));
         bResult := True;
      end;

   end;

end;

procedure Buscar_valor_cambio_tramo_interpola(const sCod_Moneda     : String;
                                              const sOrigen         : String;
                                              const sTipo_Paridad   : String;
                                              const sMoneda_Paridad : String;
                                              const sTipo_Moneda    : String;
                                              dFecha_Paridad        : TDatetime;
                                              fdias                 : Double;
                                              var fValor            : Double;
                                              var bResult           : Boolean);
var fDias_Mayor : Double;
    fTasa_Mayor : Double;
    fTasa_Menor : Double;
    fDias_Menor : Double;
    bencontro_Mayor,
    bencontro_Menor : Boolean;
begin

   fDias_Mayor := 0;
   fTasa_Mayor := 0;
   fTasa_Menor := 0;
   fDias_Menor := 0;
   fValor      := 0;
   bResult     := false;
   bencontro_Mayor := false;
   bencontro_Menor := false;

   with DM_Leer_Valor_Cambio.QRY_General do
   begin
      // Busco Tasa a Fecha Encontrada
      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('   AND a.Fecha           = :Fecha ');
      SQL.Add('   AND a.Origen          = :Origen ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT max(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Fecha           = :Fecha ');
      SQL.Add('                               AND a.Origen          = :Origen ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      <= :Dias_Desde) ');  // Se cambia a Menor o igual para que tome el tramo si cae justo F.I., 09-04-2014

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate        := dFecha_Paridad;
      Parambyname('Origen').asString         := sOrigen;
      Parambyname('Dias_Desde').asfloat      := fdias;
      Open;
      if not eof then
      begin
         bencontro_Menor := True;
         fDias_Menor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Menor := Fieldbyname('Valor').asfloat;
      end;
      Close;

      SQL.Clear;
      SQL.Add('SELECT a.Valor ');
      SQL.Add('      ,a.Dias_Desde ');
      SQL.Add('      ,a.Dias_Hasta ');
      SQL.Add('  FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('      ,QS_SYS_MONEDAS    b ');
      SQL.Add('      ,QS_SYS_PERIODO    c ');
      SQL.Add(' WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('   AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('   AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('   AND a.Fecha           = :Fecha ');
      SQL.Add('   AND a.Origen          = :Origen ');
      SQL.Add('   AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('   AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('   AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('   AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('   AND a.Dias_Desde      = (SELECT min(a.Dias_Desde) ');
      SQL.Add('                              FROM QS_SYS_VAL_TRAMO  a ');
      SQL.Add('                                  ,QS_SYS_MONEDAS    b ');
      SQL.Add('                                  ,QS_SYS_PERIODO    c ');
      SQL.Add('                             WHERE a.Cod_Moneda      = :Cod_Moneda ');
      SQL.Add('                               AND a.Tipo_Paridad    = :Tipo_Paridad ');
      if sTipo_Moneda = 'M' then
         SQL.Add('                            AND a.Moneda_Paridad  = :Moneda_Paridad ');
      SQL.Add('                               AND a.Fecha           = :Fecha ');
      SQL.Add('                               AND a.Origen          = :Origen ');
      SQL.Add('                               AND b.COD_MONEDA      = a.COD_MONEDA ');
      SQL.Add('                               AND c.TIPO_UNIDAD     = b.TIPO_UNI_VARIACION ');
      SQL.Add('                               AND c.UNIDAD	         = b.UNIDAD_MEDIDA_MON ');
      SQL.Add('                               AND c.Tipo_Variacion  = ''D'' ');
      SQL.Add('                               AND a.Dias_Desde      > :Dias_Desde) ');

      Parambyname('Cod_Moneda').asString     := sCod_Moneda;
      Parambyname('Tipo_Paridad').asString   := sTipo_Paridad;
      if sTipo_Moneda = 'M' then
         Parambyname('Moneda_Paridad').asString := sMoneda_Paridad;
      ParamByName('Fecha').AsDate        := dFecha_Paridad;
      Parambyname('Origen').asString         := sOrigen;
      Parambyname('Dias_Desde').asfloat      := fdias;
      Open;
      if not eof then
      begin
         bencontro_Mayor := True;
         fDias_Mayor := Fieldbyname('Dias_Desde').asfloat;
         fTasa_Mayor := Fieldbyname('Valor').asfloat;
      end;

      //if ( fTasa_Menor <> 0 ) and ( fTasa_Mayor <> 0 ) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then   DC 26/12/2014 porque existe valor en cero

      if (bencontro_Mayor) and (bencontro_Menor) and ( (fDias_Mayor - fDias_Menor) <> 0 ) then
      begin
         fValor  := fTasa_Menor + (( fdias - fDias_Menor) * ( fTasa_Mayor - fTasa_Menor ) / ( fDias_Mayor - fDias_Menor ));
         bResult := True;
      end;

   end;

end;

procedure Proyecta_Valor_Indice_por_curvas( sCodigo_Indice   : String;
                                            dFecha_Calculo   : TDateTime;
                                            dFecha_Proyeccion      : TDateTime;
                                            var fValor_Proyectado  : Double;
                                            var sModulo_Err  : String;
                                            var sString_Err  : String;
                                            var bResult      : Boolean);
var fValor_a_Fecha_de_Calculo  : Double;
    sCurva_Proy_utilizada      : String;
    iDias_Base_Curva           : Integer;
    sTipoInteres_Curva         : String;
    iBaseMensual_Curva         : Integer;
    sTipoCalculoDias_Curva     : String;
    iVigenciaValor_Curva       : Integer;
    iVigencia_Meses_Curva      : Integer;
    sPais_Curva                : String;

    sTipo_Tasa_Curva           : String;
    fPeriodo_Curva             : Double;
    sAnualidad_Curva           : String;
    fBase_Porcen_Curva         : Double;


    fDias                      : Double;
    iAnosEnteros               : Double;
    iAnosFraccion              : Double;
    iMesesEnteros              : Double;

    RegParamMargen             : TRegParamMargen;

    fNoUtilizado               : Double;
    fTasa_Proyeccion           : Double;
    fFD_Proyeccion             : Double;


begin
   bResult := True;
   // Originalmente en fValor_Proyectado trae el valor a la fecha de calculo.
   fValor_a_Fecha_de_Calculo := fValor_Proyectado;

   if dFecha_Proyeccion = dFecha_Calculo then
      exit;

   if (dFecha_Proyeccion < dFecha_Calculo) then
   begin
       sModulo_Err := 'Proyección de tasa / indice por curvas';
       sString_Err := 'Fecha Proyeccion ('+DateToStr(dFecha_Proyeccion)+') es menor que fecha de calculo ('+DateToStr(dFecha_Calculo)+')';
       bResult     := False;
       exit;
   end;

   with DM_Leer_Valor_Cambio.QRY_General do
   begin
     SQL.Clear;
     SQL.Add('SELECT b.Tasa_Equiv');
     SQL.Add('  FROM Qs_Fin_Tasa_Conver b');
     SQL.Add(' WHERE b.Cod_Tasa_Base = :Cod_Tasa_Base');

     ParamByName('Cod_Tasa_Base').AsString := sCodigo_Indice;
     Prepare;
     Open;

     if ((FieldByName('Tasa_Equiv').AsString = '') or (FieldByName('Tasa_Equiv').IsNull)) then
     begin
       sModulo_Err := 'Proyección de tasa / indice por curvas';
       sString_Err := 'No esta definida tasa equivalente (curva proyección) para: '+sCodigo_Indice;
       bResult     := False;
       Close;
       exit;
     end;
     sCurva_Proy_utilizada := FieldByName('Tasa_Equiv').AsString;
     Close;
   end;

   Obtener_Tasa_base_Mem(sCurva_Proy_utilizada
                        ,iDias_Base_Curva
                        ,sTipoInteres_Curva
                        ,iBaseMensual_Curva
                        ,sTipoCalculoDias_Curva
                        ,iVigenciaValor_Curva
                        ,iVigencia_Meses_Curva
                        ,sPais_Curva
                        ,sModulo_err
                        ,sString_err
                        ,bResult);
   if NOT bResult then
      exit;

   Obtener_Base_Conversion_Mem(sCurva_Proy_utilizada
                              ,sTipo_Tasa_Curva
                              ,fPeriodo_Curva
                              ,sAnualidad_Curva
                              ,fBase_Porcen_Curva
                              ,sModulo_Err
                              ,sString_Err
                              ,bResult
                              );
   if NOT bResult then
      exit;

   if (iDias_Base_Curva = 0) then
   begin
      sModulo_Err := 'Proyección de tasa / indice por curvas';
      sString_Err := 'Base días para '+sCurva_Proy_utilizada+' no puede ser cero';
      exit;
   end;

   Calculo_de_dias(dFecha_Calculo
                  ,dFecha_Proyeccion
                  ,sTipoCalculoDias_Curva
                  ,sPais_Curva
                  ,fDias
                  ,iAnosEnteros
                  ,iAnosFraccion
                  ,iMesesEnteros);

   // Use el RegParamMargen ya que la funcion lee_Tasas_Tramos se hizo con ese parametro.
   RegParamMargen.Tasa_Base_1     := sCurva_Proy_utilizada;
   RegParamMargen.Tasa_Base_2     := '';
   RegParamMargen.Interpolacion_1 := 'I';

   Lee_Tasa_Tramos( RegParamMargen
                   ,dFecha_Calculo
                   ,fDias
                   ,False
                   ,fTasa_Proyeccion
                   ,fNoUtilizado
                   ,sModulo_Err
                   ,sString_Err
                   ,bResult);

   if NOT bResult then
      exit;

   // Factor de descuento Proyeccion
   if sTipoInteres_Curva = 'C' then
      fFD_Proyeccion := 1 / Interes_Compuesto( fTasa_Proyeccion
                                              ,fBase_Porcen_Curva
                                              ,fDias
                                              ,iDias_Base_Curva)
   else
      fFD_Proyeccion := 1 / Interes_Simple( fTasa_Proyeccion
                                           ,fBase_Porcen_Curva
                                           ,fDias
                                           ,iDias_Base_Curva);

   if (fFD_Proyeccion = 0) then
   begin
       sModulo_Err := 'Proyección de flujos por curvas';
       sString_Err := 'No se puede proyectar valor de ('+sCodigo_Indice+') para '+FloatToStr(fDias)+ ' días. Factor de descuento es cero.';
       bResult      := False;
       exit;
   end;
   fValor_Proyectado := fValor_a_Fecha_de_Calculo / fFD_Proyeccion;

   fValor_Proyectado := Redondeo_moneda_Mem( sCodigo_Indice
                                            ,dFecha_Calculo
                                            ,fValor_Proyectado);
end;

procedure leer_ultimo_valor_cambio(sMon_Origen   : String;
                                   sTipo_Paridad : String;
                                   sMon_Paridad  : String;
                                   dfecha        : TDatetime;
                                   var fParidad  : Double;
                                   var Result    : Boolean);
begin
 Result := false;
 with DM_Leer_Valor_Cambio.QRY_General do
 begin
  SQL.Clear;
  SQL.Add('SELECT a.VALOR_MONEDA FROM QS_SYS_VAL_CAMBIO a'
         +' WHERE a.COD_MONEDA = :Moneda_Origen '
         +' AND a.TIPO_DE_PARIDAD = :Paridad '
         +' AND a.MONEDA_PARIDAD = :Moneda_Paridad '
         +' AND a.FECHA_PARIDAD = (SELECT MAX(b.FECHA_PARIDAD) FROM QS_SYS_VAL_CAMBIO b'
         +'                                                    WHERE b.COD_MONEDA = a.COD_MONEDA'
         +'                                                    AND b.TIPO_DE_PARIDAD = a.TIPO_DE_PARIDAD'
         +'                                                    AND b.MONEDA_PARIDAD = a.MONEDA_PARIDAD'
         +'                                                    AND b.FECHA_PARIDAD <= :Fecha_Paridad )');
  ParamByName('Moneda_Origen').AsString  := sMon_Origen;
  ParamByName('Paridad').AsString        := sTipo_Paridad;
  ParamByName('Moneda_Paridad').AsString := sMon_Paridad;
  ParamByName('Fecha_Paridad').AsDate    := dfecha;
  Prepare;
  Open;

  if FieldByName('VALOR_MONEDA').Asfloat = 0 then
  begin
   Result := false;
  end
  else
  begin
   Result   := true;
   fParidad := FieldByName('VALOR_MONEDA').Asfloat
  end;
 end;
end;

end.
