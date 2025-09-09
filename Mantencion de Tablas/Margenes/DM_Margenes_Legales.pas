unit DM_Margenes_Legales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Wwquery, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM_Margenes = class(TDataModule)
    Qry_General: TFDQuery;
    Qry_Update: TFDQuery;
    Qry_Multiproposito: TFDQuery;
    Qry_Delete: TFDQuery;
    Qry_Simula: TFDQuery;
    Qry_Insert: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }

  end;



procedure Datos_Compania(sCartera          : String;
                         dFecha_Cierre     : TDateTime;
                     var fReserva_Tecnica  : Double;
                     var fPatrimonio_Riesgo: Double;
                     var fParticipacion    : Double;
                     var fRT_mas_PR        : Double;
                     var sError            : String;
                     var bResult           : Boolean
                         );
procedure Datos_Grupo_Instr(sGrupo        : String;
                        var fLimite_Max   : Double;
                        var fReserva_adi  : Double;
                        var fPatRiesgo    : Double;
                        var fRTyPR_Emisor : Double;
                        var fInstrum_Emisor : Double;
                        var fMultiplo     : Double
                        );
procedure   Datos_Emisor(Emisor                 :String;
                         dFecha_Cierre          :TDateTime;
                     var sGrupo_economico       :String;
                     var sSugrupo_economico     :String;
                     var fPatrimonio            :Double;
                     var fTotal_LH_emitidas     :Double;
                     var fTotal_Dep_Captaciones :Double;
                     var fTotal_Acc_suscritas   :Double;
                     var bResult                :Boolean);

procedure Nominales_Emision(sEmisor            : String;
                            sInstrumento       : String;
                            sSerie             : String;
                        var fNominales_Emision : Double;
                        var fNro_inscripcion   : Double );

procedure   Datos_Series_Emisor(sEmisor                 :String;
                                dFecha_Cierre           :TDatetime;
                            var fNominales_Vigentes     :Double;
                            var bResult                 :Boolean);


procedure Datos_Simulacion_Grupo(sGrupo           :String;
                             var fValor_Invertido : Double);

procedure Datos_Simulacion_Emisor(sEmisor          :String;
                                  sGrupo           :String;
                              var fValor_Invertido : Double);

procedure Datos_Simulacion_Serie(sEmisor          :String;
                                 sInstrumento     :String;
                                 sSerie           :String;
                             var fValor_Nominal   : Double);
                             
procedure Datos_Simulacion_Grupo_Eco(sEmisor         : String;
                                 var fValor_Invertido: Double );

function Factor_Riesgo_Emisor(sEmpresa : String;
                              sCartera : String;
                              sEmisor  : String;
                              dFecha_Cierre : TDateTime): Double;


Procedure Calculo_margenes_instrumentos(dFecha_Cierre : TDateTime;
                                        sCartera      : String;
                                        sEmpresa      : String;
                                        bSimular      : boolean;
                                    var sError        : String;
                                    var bResult       : boolean
                                        );
procedure Calculos_Margenes_Emisor(dFecha_Cierre : TDateTime;
                                   sCartera      : String;
                                   sEmpresa      : String;
                                   bSimular      : boolean;
                                   sCia_Grupo    : String;
                               var sError        : String;
                               var bResult       : boolean
                                        );
procedure Calculos_Margenes_Series(dFecha_Cierre : TDateTime;
                                   sCartera      : String;
                                   sEmpresa      : String;
                                   bSimular      : boolean;
                               var sError        : String;
                               var bResult       : boolean
                                    );

Procedure Calculos_Margenes_Grupo_Economicos(dFecha_Cierre : TDateTime;
                                             sCartera      : String;
                                             sEmpresa      : String;
                                             bSimular      : boolean;
                                         var sError        : String;
                                         var bResult       : boolean
                                             );

procedure Simulacion_Datos_Nuevos (dFecha_Cierre : TDateTime;
                                   sCartera      : String;
                                   sEmpresa      : String;
                                   fPorcentaje   : Double;
                               var sError        : String;
                               var bResult       : boolean
                                   );
procedure Simulacion_Datos_Nuevos_Emisor(dFecha_Cierre : TDateTime;
                                         sCartera      : String;
                                         sEmpresa      : String;
                                         sCia_Grupo    : String;
                                         fRT_mas_PR    : Double;
                                         fParticipacion: Double;
                                     var sError        : String;
                                     var bResult       : boolean
                                        );
function Grupo_Inst_251(sInstrumento:String):String;

Procedure Calculo_margenes_inst_Renta_Variable(dFecha_Cierre : TDateTime;
                                               sCartera      : String;
                                               sEmpresa      : String;
                                               bSimular      : boolean;
                                           var sError        : String;
                                           var bResult       : boolean
                                        );


var
  DM_Margenes: TDM_Margenes;

implementation
uses DMLeer_valor_Cambio
    ,DM_Comun
    ,DM_Base_Datos
    ,DM_Holding_Empresas
    ;
{$R *.DFM}

procedure Datos_Compania(sCartera          : String;
                         dFecha_Cierre     : TDateTime;
                     var fReserva_Tecnica  : Double;
                     var fPatrimonio_Riesgo: Double;
                     var fParticipacion    : Double;
                     var fRT_mas_PR        : Double;
                     var sError            : String;
                     var bResult           : Boolean
                         );
var
  dFecha_Balance : TDateTime;
begin
  sError  := '';
  bResult := True;
  with DM_Margenes,Qry_General do
    begin
      sql.Clear;
      sql.add('select max(fecha_cierre) as Fecha  '
             +'  from qs_fin_balance '
             +' where fecha_cierre <= :fecha_cierre '
             +'   and CODIGO_CARTERA = :cartera '
             );
      ParamByName('fecha_cierre').AsDateTime := dFecha_cierre;
      ParamByName('cartera').AsString        := sCartera;
      Prepare;
      Open;
      if FieldByName('fecha').IsNull then
         begin
           sError := 'No existen Datos para esta cartera';
           bResult:= False;
           Exit;
         end
      else
         dFecha_Balance := FieldByName('fecha').AsDateTime;

      Close;
      Unprepare;
      sql.Clear;
      sql.add('select * from qs_fin_balance '
             +' where fecha_cierre = :fecha_cierre '
             +'   and CODIGO_CARTERA = :cartera '
             );
      ParamByName('fecha_cierre').AsDateTime := dFecha_Balance;
      ParamByName('cartera').AsString        := sCartera;
      Prepare;
      Open;
      fReserva_Tecnica  := FieldByNAme('RIESGO_EN_CURSO').Asfloat +
                           FieldByNAme('MATEMATICA').Asfloat +
                           FieldByNAme('SINIESTROS').Asfloat +
                           FieldByNAme('ADICIONAL').Asfloat;

      fPatrimonio_Riesgo:= FieldByNAme('RIESGO').Asfloat;
      fParticipacion    := FieldByNAme('PATICIPACION').AsFloat;
      fRT_mas_PR        := fReserva_Tecnica + fPatrimonio_Riesgo;
      Close;
      Unprepare;
    end;

end;

function Factor_Riesgo_Emisor(sEmpresa : String;
                              sCartera : String;
                              sEmisor  : String;
                              dFecha_Cierre : TDateTime): Double;
begin
  with  DM_Margenes,Qry_MultiProposito do
    begin
      sql.Clear;
      sql.Add('select Sum(Factor_Riesgo* Valor_pte_mc_cpa) / sum(valor_pte_mc_cpa) as Factor_Riesgo'
             +'  from qs_res_mercado '
             +' where fecha_Cierre = :fecha_cierre '
             +'   and emisor = :emisor ');
      if scartera <> 'CONSOLIDAD' then
         sql.Add(' and cartera = :cartera ');
      sql.Add('  and empresa = :empresa ');

      if scartera <> 'CONSOLIDAD' then
         ParamByName('cartera').AsString   := sCartera;
      ParamByName('fecha_cierre').AsDateTime:= dFecha_Cierre;
      ParamByName('emisor').AsString       := sEmisor;
      ParamByName('Empresa').AsString      := sEmpresa;
      Prepare;
      Open;
      if FieldByName('Factor_Riesgo').IsNull then
         Result := 0
      else
         Result := FieldByName('Factor_Riesgo').AsFloat;
      Close;
      Unprepare;
    end;
end;

procedure Datos_Grupo_Instr(sGrupo          : String;
                        var fLimite_Max     : Double;
                        var fReserva_adi    : Double;
                        var fPatRiesgo      : Double;
                        var fRTyPR_Emisor   : Double;
                        var fInstrum_Emisor : Double;
                        var fMultiplo       : Double
                        );
begin
  with  DM_Margenes,Qry_MultiProposito do
    begin
      sql.Clear;
      sql.Add('select * from QS_FIN_GRUPO_INS '
             +' where grupo = :grupo ');
      ParamByName('grupo').AsString := sGrupo;
      Prepare;
      Open;
      if NOT FieldByName('limite_maximo').IsNull then
         begin
           fLimite_Max     := FieldByName('LIMITE_MAXIMO').AsFloat;
           fReserva_adi    := FieldByName('RESERVAS_ADIS').AsFloat;
           fPatRiesgo      := FieldByName('PAT_RIESGO').AsFloat;
           fRTyPR_Emisor   := FieldByName('RT_PR').AsFloat;
           fInstrum_Emisor := FieldByName('P_INSTRUMENTO').AsFloat;
           fMultiplo       := FieldByName('MULTIPLO_UNICO').AsFloat;
         end;
      Close;
      Unprepare;
   end;
end;

procedure   Datos_Emisor(Emisor                 : String;
                         dFecha_Cierre          : TDateTime;
                     var sGrupo_economico       :String;
                     var sSugrupo_economico     : String;
                     var fPatrimonio            :Double;
                     var fTotal_LH_emitidas     :Double;
                     var fTotal_Dep_Captaciones :Double;
                     var fTotal_Acc_suscritas   :Double;
                     var bResult                :Boolean);
var
 dFecha_Datos :TDateTime;
begin
  bResult := True;
  with DM_Margenes,Qry_MultiProposito do
    begin
      sql.Clear;
      sql.Add('select max(fecha_desde) as fecha  from QS_FIN_ESTADO_EMI '
             +' where emisor = :emisor '
             +'   and fecha_desde <= :fecha_cierre');
      ParamByName('emisor').AsString := Emisor;
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      Prepare;
      Open;
      if NOT FieldByName('Fecha').IsNull then
         dFecha_Datos := FieldByName('Fecha').AsDateTime
      else
         begin
           bResult := False;
           Exit;
         end;
      Close;
      Unprepare;
      sql.Clear;
      sql.Add('select *  from QS_FIN_ESTADO_EMI '
             +' where emisor = :emisor '
             +'   and fecha_desde = :fecha_cierre');
      ParamByName('emisor').AsString := Emisor;
      ParamByName('fecha_cierre').AsDateTime := dFecha_Datos;
      Prepare;
      Open;
      sGrupo_economico       := '';// por determinar
      sSugrupo_economico     := '';// por determinar
      fPatrimonio            := FieldByName('PATRIMONIO').AsFloat;
      fTotal_LH_emitidas     := FieldByName('LH_DE_CREDITO').AsFloat;
      fTotal_Dep_Captaciones := FieldByName('DEP_Y_CAP').AsFloat;
      fTotal_Acc_suscritas   := FieldByName('ACC_SUSCRITAS').AsFloat;
      Close;
      Unprepare;
   end;
end;

procedure Nominales_Emision(sEmisor            : String;
                            sInstrumento       : String;
                            sSerie             : String;
                        var fNominales_Emision : Double;
                        var fNro_inscripcion   : Double );
var
  Busqueda : Boolean;
begin
  with DM_Margenes,Qry_Update do
    begin
      sql.Clear;
      sql.Add('select * from QS_FIN_INSCRIPCION '
             +' where CODIGO_EMISOR       = :emisor '
             +'   and CODIGO_INSTRUMENTO  = :instrumento'
             +' ORDER BY LEN(SERIES) ');
      ParamByName('emisor').AsString      := sEmisor;
      ParamByName('instrumento').AsString := sInstrumento;
      Prepare;
      Open;
      Busqueda := False;
      While (NOT EOF) and (NOT Busqueda) do
        begin
          if Pos(sSerie,FieldByName('Series').AsString) > 0 then
             begin
             fNominales_Emision  := FieldByName('MONTO_INSCRIPCION').AsFloat;
             fNro_inscripcion    := FieldByName('NRO_INSCRIPCION').AsFloat;
             Busqueda            := True;
             end;
          Next;
        end;
     if NOT Busqueda then
        begin
          fNominales_Emision  := 0;
          fNro_inscripcion    := 0;
        end;
    end;

end;

procedure   Datos_Series_Emisor(sEmisor                 :String;
                                dFecha_Cierre           :TDateTime;
                            var fNominales_Vigentes     :Double;
                            var bResult                 :Boolean);
var
  fNominales_emision : Double;
  Modulo_Err         : String;
  String_Err         : String;
  Result             : Boolean;
  aux_pchar, aux_Titulo: array[0..250] of char;
begin
  bResult := True;
  with DM_Margenes,Qry_MultiProposito do
    begin
      Sql.Clear;
      Sql.Add('Select codigo_Emisor      as Emisor '
             +'      ,codigo_instrumento as Instrumento '
             +'      ,moneda_inscripcion as moneda '
             +'      ,sum(monto_inscripcion) as Nominales_emision '
             +'  from qs_fin_inscripcion '
             +' where codigo_Emisor       = :Emisor '
             +' group by codigo_emisor,codigo_instrumento,moneda_inscripcion '
             );
       ParamByName('Emisor').AsString         := sEmisor;
       Prepare;
       Open;
       fNominales_Vigentes := 0;
       While NOT EOF do
         begin
           fNominales_emision := FieldByName('Nominales_emision').AsFloat;
           if FieldByName('Moneda').AsString <> 'CLP' then
              begin
              conversion_unidad_mon(FieldByName('Moneda').AsString,
                                    'CLP',
                                    'BC',
                                    dfecha_cierre,
                                    fNominales_emision,
                                    fNominales_emision,
                                    Modulo_Err,
                                    String_Err,
                                    Result);
               if Not Result then
                  begin
                   strpcopy(aux_pchar,'No existe Valor '+FieldByName('Moneda').AsString+' al: '
                   +datetostr(dfecha_Cierre)+' Se asume Valor 1');
                   Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                   fNominales_emision := 1;
                  end;
              end;

           fNominales_Vigentes := fNominales_Vigentes + fNominales_emision;
           Next;
         end;
       Close;
       Unprepare;
    end;
end;


procedure Datos_Simulacion_Grupo(sGrupo           :String;
                             var fValor_Invertido : Double);
begin
  with DM_Margenes,Qry_Simula do
    begin
      sql.Clear;
      sql.Add('select c.descripcion_nodo  as Grupo '
             +'      ,sum(a.valor_invertido) as Valor_Cartera '
             +'  from qs_tmp_Simulacion a '
             +'      ,qs_sys_clasif_obj b '
             +'      ,qs_sys_est_cla c '
             +' Where  a.instrumento  = b.elemento '
             +'    and b.objeto       = :objeto '
             +'    and b.codigo_clasif= :codigo_clasif  '
             +'    and b.codigo_clasif= c.codigo_objeto '
             +'    and b.nodo  = c.nodo '
             +'    and c.descripcion_nodo = :grupo '
             +'  group by c.descripcion_nodo '  );
       ParamByName('objeto').AsString := 'INSTRUM';
       ParamByName('codigo_clasif').AsString := 'LEY251';
       ParamByName('Grupo').AsString := sGrupo;
       Prepare;
       Open;
       if FieldByName('Valor_Cartera').IsNull then
          fValor_Invertido := 0
       else
          fValor_Invertido := FieldByName('Valor_Cartera').AsFloat;
       Close;
       Unprepare;
     end;
end;

procedure Datos_Simulacion_Emisor(sEmisor          :String;
                                  sGrupo           :String;
                              var fValor_Invertido : Double);
begin
  with DM_Margenes,Qry_Simula do
    begin
      sql.Clear;
      sql.Add('select a.emisor as emisor '
             +'      ,c.descripcion_nodo  as Grupo '
             +'      ,sum(a.valor_invertido) as Valor_Cartera '
             +'  from qs_tmp_Simulacion a '
             +'      ,qs_sys_clasif_obj b '
             +'      ,qs_sys_est_cla c '
             +' Where  a.instrumento  = b.elemento '
             +'    and b.objeto       = :objeto '
             +'    and b.codigo_clasif= :codigo_clasif '
             +'    and b.codigo_clasif= c.codigo_objeto '
             +'    and b.nodo  = c.nodo '
             +'    and c.descripcion_nodo = :grupo '
             +'    and a.emisor  = :emisor '
             +'  group by a.emisor,c.descripcion_nodo '  );
       ParamByName('objeto').AsString := 'INSTRUM';
       ParamByName('codigo_clasif').AsString := 'LEY251';
       ParamByName('emisor').AsString := sEmisor;
       ParamByName('Grupo').AsString  := sGrupo;
       Prepare;
       Open;
       if FieldByName('Valor_Cartera').IsNull then
          fValor_Invertido := 0
       else
          fValor_Invertido := FieldByName('Valor_Cartera').AsFloat;
       Close;
       Unprepare;
     end;
end;

procedure Datos_Simulacion_Serie(sEmisor          :String;
                                 sInstrumento     :String;
                                 sSerie           :String;
                             var fValor_Nominal   : Double);
begin
  with DM_Margenes,Qry_Simula do
    begin
      sql.Clear;
      sql.Add('select a.emisor      as emisor '
             +'      ,a.instrumento as instrumento '
             +'      ,a.serie       as Serie '
             +'      ,sum(a.Nominales) as Valor_Nominal '
             +'  from qs_tmp_Simulacion a '
             +'      ,qs_sys_clasif_obj b '
             +'      ,qs_sys_est_cla c '
             +' Where  a.instrumento  = b.elemento '
             +'    and a.instrumento  = :instrumento '
             +'    and a.serie        = :serie '
             +'    and b.objeto       = :objeto '
             +'    and b.codigo_clasif= :codigo_clasif '
             +'    and b.codigo_clasif= c.codigo_objeto '
             +'    and b.nodo  = c.nodo '
             +'    and c.descripcion_nodo = :grupo '
             +'    and a.emisor = :emisor '
             +'  group by a.emisor,a.instrumento,a.serie '  );
       ParamByName('objeto').AsString        := 'INSTRUM';
       ParamByName('codigo_clasif').AsString := 'LEY251';
       ParamByName('emisor').AsString      := sEmisor;
       ParamByName('instrumento').AsString := sInstrumento;
       ParamByName('Serie').AsString       := sSerie;
       ParamByName('Grupo').AsString       := 'E';
       Prepare;
       Open;
       if FieldByName('Valor_Nominal').IsNull then
          fValor_Nominal := 0
       else
          fValor_Nominal := FieldByName('Valor_Nominal').AsFloat;
       Close;
       Unprepare;
     end;
end;

procedure Datos_Simulacion_Grupo_Eco(sEmisor         : String;
                                 var fValor_Invertido: Double );
begin
  with DM_Margenes,Qry_Simula do
      begin
        sql.Clear;
        Sql.Add('SELECT SUM(A.VALOR_INVERTIDO) as Valor_Invertido '
               +'  FROM QS_TMP_SIMULACION A '
               +' WHERE A.EMISOR = :Emisor '
               +'   AND A.INSTRUMENTO IN (SELECT D.ELEMENTO '
               +'                           FROM QS_SYS_CLASIF_OBJ D '
               +'                              , QS_SYS_EST_CLA E '
               +'                          WHERE D.CODIGO_CLASIF = E.CODIGO_OBJETO '
               +'                            AND D.NODO          = E.NODO    '
               +'                            AND D.CODIGO_CLASIF = :codigo_clasif'
               +'                            AND D.OBJETO        = :objeto '
               +'                            AND E.DESCRIPCION_NODO IN (:GRUPO) ) '
               );
          ParamByName('objeto').AsString := 'INSTRUM';
          ParamByName('codigo_clasif').AsString := 'LEY251';
          ParamByName('Grupo').AsString := '''B'''+''','''+'''C'''+''','''+'''E'''+''','''+'''G''';
          ParamByName('Emisor').AsString   := sEmisor;
          Prepare;
          Open;
          if FieldByName('Valor_Invertido').IsNull then
             fValor_Invertido := 0
          else
             fValor_Invertido := FieldByName('Valor_Invertido').AsFloat;
          Close;
          Unprepare;
      end;
end;


{   ------------------------------------------------------------------------
   Rutina de calculo de margenes por grupo de instrumentos para Renta Fija
   ------------------------------------------------------------------------}
Procedure Calculo_margenes_instrumentos(dFecha_Cierre : TDateTime;
                                        sCartera      : String;
                                        sEmpresa      : String;
                                        bSimular      : boolean;
                                    var sError        : String;
                                    var bResult       : boolean
                                        );
var
  fReserva_Tecnica  : Double;
  fPatrimonio_Riesgo: Double;
  fParticipacion    : Double;
  fRT_mas_PR        : Double;
  fLimite_Max       : Double;
  fReserva_adi      : Double;
  fPatRiesgo        : Double;
  fRTyPR_Emisor     : Double;
  fInstrum_Emisor   : Double;
  fMultiplo         : Double;
  sTag             : String;
  fValor_Cartera   : Double;
  fValor_Invertido : Double;
begin
with DM_Margenes do
begin
  sError  := '';
  bResult := True;
  Datos_Compania(sCartera
                ,dFecha_Cierre
                ,fReserva_Tecnica
                ,fPatrimonio_Riesgo
                ,fParticipacion
                ,fRT_mas_PR
                ,sError
                ,bResult
                );

  with Qry_General do
      begin
        sql.Clear;
        sql.add('delete from qs_fin_lim_inst '
               +' where fecha = :fecha_cierre '
               +'   and cartera = :cartera ' );
        ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
        ParamByName('cartera').AsString        := sCartera;
        Prepare;
        Execsql;
        Close;
        Unprepare;

        Sql.Clear;
        Sql.Add('select c.descripcion_nodo  as Grupo '
               +'      ,sum(a.valor_pte_mc_cpa) as Valor_Cartera '
               +'  from qs_res_mercado a '
               +'      ,qs_sys_clasif_obj b '
               +'      ,qs_sys_est_cla c '
               +'  where a.fecha_cierre = :fecha_cierre ');
        if scartera <> 'CONSOLIDAD' then
           sql.Add('    and a.cartera      = :cartera ');
        sql.Add('    and a.empresa      = :empresa '
               +'    and a.instrumento  = b.elemento '
               +'    and b.objeto       = :objeto '
               +'    and b.codigo_clasif= :codigo_clasif '
               +'    and b.codigo_clasif= c.codigo_objeto '
               +'    and b.nodo  = c.nodo '
               +'  group by c.descripcion_nodo ');

          ParamByName('objeto').AsString := 'INSTRUM';
          ParamByName('codigo_clasif').AsString := 'LEY251';
          ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
          if scartera <> 'CONSOLIDAD' then
             ParamByName('cartera').AsString        := sCartera;
          ParamByName('empresa').AsString        := sEmpresa;
          Prepare;
          Open;
          first;
          While NOT EOF do
            begin
              Datos_Grupo_Instr(FieldByName('Grupo').AsString
                         ,fLimite_Max
                         ,fReserva_adi
                         ,fPatRiesgo
                         ,fRTyPR_Emisor
                         ,fInstrum_Emisor
                         ,fMultiplo
                        );
              sTag := '';
              if bSimular then
                 begin
                 Datos_Simulacion_Grupo(FieldByName('Grupo').AsString
                                       ,fValor_Invertido );
                 if fValor_Invertido <> 0 then
                    sTag := 'S';
                 end;

              Qry_Update.Sql.Clear;
              Qry_Update.Sql.Add('insert into qs_fin_lim_inst  ( '
                                +' CARTERA          '
                                +',FECHA            '
                                +',GRUPO_GRL        '
                                +',GRUPO_INST       '
                                +',VALOR_PRESENTE   '
                                +',PORCENTAJE_LIM   '
                                +',MAXIMO_PERM      '
                                +',MERGEN_INV       '
                                +',PORCENTAJE_USE   '
                                +',TAG )            '
                                +'   values (       '
                                +' :CARTERA         '
                                +',:FECHA           '
                                +',:GRUPO_GRL       '
                                +',:GRUPO_INST      '
                                +',:VALOR_PRESENTE  '
                                +',:PORCENTAJE_LIM  '
                                +',:MAXIMO_PERM     '
                                +',:MERGEN_INV      '
                                +',:PORCENTAJE_USE  '
                                +',:TAG ) '
                                );
              if bSimular then
                 fValor_Cartera := FieldByName('Valor_Cartera').AsFloat + fValor_Invertido
              else
                 fValor_Cartera := FieldByName('Valor_Cartera').AsFloat;
              Qry_Update.ParamByName('CARTERA').AsString      := scartera;
              Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
              Qry_Update.ParamByName('GRUPO_GRL').AsString    := '';
              Qry_Update.ParamByName('GRUPO_INST').AsString   := FieldByName('Grupo').AsString;
              Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fLimite_Max;
              Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fRT_mas_PR * fLimite_Max / 100;
              Qry_Update.ParamByName('MERGEN_INV').AsFloat    := (fRT_mas_PR * fLimite_Max / 100)
                                                                - fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= (fValor_Cartera
                                                              / fRT_mas_PR) * 100;
              Qry_Update.ParamByName('TAG').AsString          := sTag;
              Qry_Update.Prepare;
              Qry_Update.Execsql;
              Qry_Update.Close;
              Qry_Update.Unprepare;
              Next;
            end;{while}
    end;{with frm}
end;
end;
{   ------------------------------------------------------------------------
   Rutina de calculo de margenes por Emisor/grupo de instrumentos para Renta Fija
   ------------------------------------------------------------------------}
procedure Calculos_Margenes_Emisor(dFecha_Cierre : TDateTime;
                                   sCartera      : String;
                                   sEmpresa      : String;
                                   bSimular      : boolean;
                                   sCia_Grupo    : String;
                               var sError        : String;
                               var bResult       : boolean
                                        );
var
  fReserva_Tecnica  : Double;
  fPatrimonio_Riesgo: Double;
  fParticipacion    : Double;
  fRT_mas_PR        : Double;
  fLimite_Max       : Double;
  fReserva_adi      : Double;
  fPatRiesgo        : Double;
  fRTyPR_Emisor     : Double;
  fInstrum_Emisor   : Double;
  fMultiplo         : Double;

  aux_pchar, aux_Titulo: array[0..250] of char;
  sTag                   : String;
  fValor_Cartera         : Double;
  fValor_Invertido       : Double;
  sGrupo_economico       : String;
  sSugrupo_economico     : String;
  fPatrimonio            : Double;
  fTotal_LH_emitidas     : Double;
  fTotal_Dep_Captaciones : Double;
  fTotal_Acc_suscritas   : Double;
  fNominales_Vigentes    : Double;
  fLimite_1              : Double;
  fLimite_2              : Double;
  fLimite_3              : Double;
  fLimite                : Double;
  fPorcentaje_max        : Double;
  fValor_Moneda          : Double;
  Modulo_Err             : String;
  String_Err             : String;
  fFactor_Riesgo         : Double;
  Result                 : Boolean;

begin
with DM_Margenes do
begin
  sError  := '';
  bResult := True;
  Datos_Compania(sCartera
                ,dFecha_Cierre
                ,fReserva_Tecnica
                ,fPatrimonio_Riesgo
                ,fParticipacion
                ,fRT_mas_PR
                ,sError
                ,bResult
                );

  with Qry_General do
      begin // Borrar calculos anteriores
        sql.Clear;
        sql.add('delete from qs_fin_lim_emi '
               +' where fecha = :fecha_cierre '
               +'   and cartera = :cartera ' );
        ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
        ParamByName('cartera').AsString        := sCartera;
        Prepare;
        Execsql;
        Close;
        Unprepare;
        // Agrupar por emisor grupo inst. a los cuales se les calcula lim x emisor
        Sql.Clear;
        Sql.Add('SELECT A.EMISOR            as emisor '
               +'      ,C.DESCRIPCION_NODO  as Grupo  '
               +'      ,SUM(A.VALOR_PTE_MC_CPA) as Valor_cartera '
               +'      ,SUM(A.VALOR_NOMINAL) as Valor_Nominal '
               +'      ,Sum(a.Factor_Riesgo* a.Valor_pte_mc_cpa) / sum(a.valor_pte_mc_cpa) as Factor_Riesgo'
               +'  FROM QS_RES_MERCADO A  '
               +'      ,QS_SYS_CLASIF_OBJ B '
               +'      ,QS_SYS_EST_CLA C '
               +' WHERE A.FECHA_CIERRE = :fecha_cierre ');
        if scartera <> 'CONSOLIDAD' then
           sql.Add('   AND A.CARTERA      = :cartera ');
        sql.Add('   AND A.EMPRESA      = :empresa '
               +'   AND A.INSTRUMENTO  = B.ELEMENTO '
               +'   AND B.CODIGO_CLASIF = C.CODIGO_OBJETO '
               +'   AND B.NODO          = C.NODO    '
               +'   AND B.OBJETO        = :objeto '
               +'   AND B.CODIGO_CLASIF = :codigo_clasif '
               +'   AND C.DESCRIPCION_NODO NOT IN (:GRUPO) '
               +' GROUP BY A.EMISOR,C.DESCRIPCION_NODO ');

          ParamByName('objeto').AsString := 'INSTRUM';
          ParamByName('codigo_clasif').AsString := 'LEY251';
          ParamByName('Grupo').AsString := '''A'''+''','''+'''D'''+''','''+'''K''';
          ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
          if scartera <> 'CONSOLIDAD' then
             ParamByName('cartera').AsString        := sCartera;
          ParamByName('empresa').AsString        := sEmpresa;
          Prepare;
          Open;
          first;
          While NOT EOF do
            begin
              Datos_Grupo_Instr(FieldByName('Grupo').AsString
                         ,fLimite_Max
                         ,fReserva_adi
                         ,fPatRiesgo
                         ,fRTyPR_Emisor
                         ,fInstrum_Emisor
                         ,fMultiplo
                        );
              Datos_Emisor(FieldByName('Emisor').AsString
                          ,dFecha_Cierre
                          ,sGrupo_economico
                          ,sSugrupo_economico
                          ,fPatrimonio
                          ,fTotal_LH_emitidas
                          ,fTotal_Dep_Captaciones
                          ,fTotal_Acc_suscritas
                          ,bResult
                          );
        if (sCia_Grupo = 'S') and (fPatrimonio = 0) then
           begin
             strpcopy(aux_pchar,FieldByName('Emisor').AsString + ''#10
                     +'Patrimonio en Cero'+''#10
                     +'Debe ingresar valor ');

             Application.MessageBox(aux_pchar,'Cálculo de Límites',mb_OK);
             fPatrimonio := 1;
           end;
        if (FieldByName('Grupo').AsString = 'B') and(fTotal_Dep_Captaciones = 0) then
           begin
             strpcopy(aux_pchar,FieldByName('Emisor').AsString + ''#10
                     +'Total en Dep. y Captaciones en Cero'+''#10
                     +'Debe ingresar valor ');

             Application.MessageBox(aux_pchar,'Cálculo de Límites',mb_OK);
             fTotal_Dep_Captaciones := 1;
           end;

        if (FieldByName('Grupo').AsString = 'C') and(fTotal_LH_emitidas = 0) then
           begin
             strpcopy(aux_pchar,FieldByName('Emisor').AsString + ''#10
                     +'Total de Letras Emitidas en Cero'+''#10
                     +'Debe ingresar valor ');

             Application.MessageBox(aux_pchar,'Cálculo de Límites',mb_OK);
             fTotal_LH_emitidas := 1;
           end;

        {Calculo de Limites }
        fLimite := 0;
        fPorcentaje_max := 0;
        fNominales_Vigentes := 0;

        fFactor_Riesgo := Factor_Riesgo_Emisor(sEmpresa
                                              ,sCartera
                                              ,FieldByName('Emisor').AsString
                                              ,dFecha_Cierre);
        fFactor_Riesgo := Redondeo(fFactor_Riesgo,2);

        if FieldByName('Grupo').AsString = 'B' then
           begin
             fLimite_1 := (fRTyPR_Emisor * fRT_mas_PR ) / 100;
             fLimite_2 := (fInstrum_Emisor * fTotal_Dep_Captaciones) / 100;
             fLimite_3 := fMultiplo * (fParticipacion / 100) * fPatrimonio
                          * fFactor_Riesgo;
           end;
        if FieldByName('Grupo').AsString = 'C' then
           begin
             fLimite_1 := (fRTyPR_Emisor * fRT_mas_PR ) / 100;
             fLimite_2 := (fInstrum_Emisor * fTotal_LH_emitidas) / 100;
             fLimite_3 := fMultiplo * (fParticipacion / 100) * fPatrimonio
                          * fFactor_Riesgo;
           end;
        if FieldByName('Grupo').AsString = 'E' then
           begin
              Datos_Series_Emisor(FieldByName('Emisor').AsString
                                 ,dFecha_Cierre
                                 ,fNominales_Vigentes
                                 ,bResult);
              if fNominales_Vigentes = 0 then
                 begin
                  strpcopy(aux_pchar,'No se encontró informacion de Series '
                 +'para emisor '+FieldByName('Emisor').AsString+' ');
                 Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                 fNominales_Vigentes := 1;
                 end;

             fLimite_1 := (fRTyPR_Emisor * fRT_mas_PR ) / 100;
             fLimite_2 := (fInstrum_Emisor * fNominales_Vigentes ) / 100;
             fLimite_3 := fMultiplo * (fParticipacion / 100) * fPatrimonio
                          * fFactor_Riesgo;
           end;
           if sCia_Grupo = 'P' then
              fLimite_3 := 9999999999.0;

           {Determinar el límite menor de los 3 calculados}
           if fLimite_1 < fLimite_2 then
              begin
                if fLimite_1 < fLimite_3 then
                   begin
                     fLimite := fLimite_1;
                     fPorcentaje_max := fRTyPR_Emisor;
                   end
                else
                   begin
                     fLimite := fLimite_3;
                     fPorcentaje_max := fMultiplo * fParticipacion
                                      * FieldByName('Factor_Riesgo').AsFloat;
                   end;
              end
           else
              begin
                if fLimite_2 < fLimite_3 then
                   begin
                     fLimite := fLimite_2;
                     fPorcentaje_max := fInstrum_Emisor;
                   end
                else
                   begin
                     fLimite := fLimite_3;
                     fPorcentaje_max := fMultiplo * fParticipacion
                                      * FieldByName('Factor_Riesgo').AsFloat;
                   end;
              end;
           sTag := '';
           if bSimular then
              begin
                Datos_Simulacion_Emisor(FieldByName('Emisor').AsString
                                       ,FieldByName('Grupo').AsString
                                       ,fValor_Invertido );
                if fValor_Invertido <> 0 then
                   sTag := 'S';
              end;

           Qry_Update.Sql.Clear;
           Qry_Update.Sql.Add('insert into qs_fin_lim_emi  ( '
                             +' CARTERA          '
                             +',FECHA            '
                             +',EMISOR           '
                             +',GRUPO_INST       '
                             +',VALOR_PRESENTE   '
                             +',NOMINALES        '
                             +',NOMINALES_EMI    '
                             +',PORCENTAJE_LIM   '
                             +',MAXIMO_PERM      '
                             +',MARGEN_INV       '
                             +',LIMITE_1         '
                             +',LIMITE_2         '
                             +',LIMITE_3         '
                             +',PORCENTAJE_USE   '
                             +',TAG )            '
                             +'   values (       '
                             +' :CARTERA          '
                             +',:FECHA            '
                             +',:EMISOR           '
                             +',:GRUPO_INST       '
                             +',:VALOR_PRESENTE   '
                             +',:NOMINALES        '
                             +',:NOMINALES_EMI    '
                             +',:PORCENTAJE_LIM   '
                             +',:MAXIMO_PERM      '
                             +',:MARGEN_INV       '
                             +',:LIMITE_1         '
                             +',:LIMITE_2         '
                             +',:LIMITE_3         '
                             +',:PORCENTAJE_USE   '
                             +',:TAG )            '
                              );
              if bSimular then
                 fValor_Cartera := FieldByName('Valor_Cartera').AsFloat + fValor_Invertido
              else
                 fValor_Cartera := FieldByName('Valor_Cartera').AsFloat;

              Qry_Update.ParamByName('CARTERA').AsString      := scartera;
              Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
              Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
              Qry_Update.ParamByName('GRUPO_INST').AsString   := FieldByName('Grupo').AsString;
              Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fValor_Cartera;
              Qry_Update.ParamByName('NOMINALES').AsFloat     := 0;
              Qry_Update.ParamByName('NOMINALES_EMI').AsFloat := fNominales_Vigentes;
              Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
              Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
              Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fValor_Cartera;
              Qry_Update.ParamByName('LIMITE_1').AsFloat      := fLimite_1;
              Qry_Update.ParamByName('LIMITE_2').AsFloat      := fLimite_2;
              Qry_Update.ParamByName('LIMITE_3').AsFloat      := fLimite_3;
              Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fValor_Cartera / fLimite;
              Qry_Update.ParamByName('TAG').AsString          := sTag;
              Qry_Update.Prepare;
              Qry_Update.Execsql;
              Qry_Update.Close;
              Qry_Update.Unprepare;
              Next;
            end;{while}
            if bSimular then
               Simulacion_Datos_Nuevos_Emisor(dFecha_Cierre
                                             ,sCartera
                                             ,sEmpresa
                                             ,sCia_Grupo
                                             ,fRT_mas_PR
                                             ,fParticipacion
                                             ,sError
                                             ,bResult
                                             );

    end;{with frm}

end;
end;

{   ------------------------------------------------------------------------
   Rutina de calculo de margenes por Series para Bonos Empresas Renta Fija
   ------------------------------------------------------------------------}
procedure Calculos_Margenes_Series(dFecha_Cierre : TDateTime;
                                   sCartera      : String;
                                   sEmpresa      : String;
                                   bSimular      : boolean;
                               var sError        : String;
                               var bResult       : boolean
                                   );
var
  fLimite_Max       : Double;
  fReserva_adi      : Double;
  fPatRiesgo        : Double;
  fRTyPR_Emisor     : Double;
  fInstrum_Emisor   : Double;
  fMultiplo         : Double;

  aux_pchar, aux_Titulo: array[0..250] of char;
  sTag                   : String;
  fValor_Cartera         : Double;
  fValor_Invertido       : Double;
  fNominales_Vigentes    : Double;
  fLimite                : Double;
  fPorcentaje_max        : Double;
  fValor_Moneda          : Double;
  Modulo_Err             : String;
  String_Err             : String;
  Result                 : Boolean;
  fNominales_cartera     : Double;
  fNominales_Simulacion  : Double;
  sSerie                 : String;
  fNominales             : Double;
  fNominales_Emision     : Double;
  fNro_Inscripcion       : Double;

begin
with DM_Margenes do
begin
  sError  := '';
  bResult := True;
  with Qry_General do
      begin // Borrar calculos anteriores
        sql.Clear;
        sql.add('delete from qs_fin_lim_serie '
               +' where fecha = :fecha_cierre '
               +'   and cartera = :cartera ' );
        ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
        ParamByName('cartera').AsString        := sCartera;
        Prepare;
        Execsql;
        Close;
        Unprepare;
        // Agrupar por emisor serie para bonos empresas
        Sql.Clear;
        Sql.Add('SELECT A.EMISOR            as emisor '
               +'      ,A.INSTRUMENTO       as Instrumento  '
               +'      ,A.MONEDA_INSTRUM    as Moneda '
               +'      ,A.SERIE             as Serie  '
               +'      ,SUM(A.VALOR_PTE_MC_CPA) as Valor_cartera '
               +'      ,SUM(A.VALOR_NOMINAL) as Valor_Nominal '
               +'  FROM QS_RES_MERCADO A  '
               +'      ,QS_SYS_CLASIF_OBJ B '
               +'      ,QS_SYS_EST_CLA C '
               +' WHERE A.FECHA_CIERRE = :fecha_cierre ');
        if scartera <> 'CONSOLIDAD' then
           sql.Add('   AND A.CARTERA      = :cartera ');
        sql.Add('   AND A.EMPRESA      = :empresa '
               +'   AND A.INSTRUMENTO  = B.ELEMENTO '
               +'   AND B.CODIGO_CLASIF = C.CODIGO_OBJETO '
               +'   AND B.NODO          = C.NODO    '
               +'   AND B.OBJETO        = :objeto '
               +'   AND B.CODIGO_CLASIF = :codigo_clasif '
               +'   AND C.DESCRIPCION_NODO = :grupo '
               +' GROUP BY A.EMISOR,A.INSTRUMENTO,A.MONEDA_INSTRUM,A.SERIE ');
          ParamByName('objeto').AsString := 'INSTRUM';
          ParamByName('codigo_clasif').AsString := 'LEY251';
          ParamByName('Grupo').AsString   := 'E';
          ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
          if scartera <> 'CONSOLIDAD' then
             ParamByName('cartera').AsString        := sCartera;
          ParamByName('empresa').AsString        := sEmpresa;
          Prepare;
          Open;
          first;
          While NOT EOF do
            begin
              Datos_Grupo_Instr('E'
                         ,fLimite_Max
                         ,fReserva_adi
                         ,fPatRiesgo
                         ,fRTyPR_Emisor
                         ,fInstrum_Emisor
                         ,fMultiplo
                        );

              {Calculo de Limites }
              fLimite := 0;
              fPorcentaje_max := 0;
              Nominales_Emision(FieldByName('Emisor').AsString
                               ,FieldByName('Instrumento').AsString
                               ,FieldByName('Serie').AsString
                               ,fNominales_Emision
                               ,fNro_Inscripcion
                               );
              fNominales_Vigentes := fNominales_Emision;

              if fNominales_Vigentes = 0 then
                 begin
                   strpcopy(aux_pchar,'No se encontró informacion de Series '
                            +'para '+FieldByName('Emisor').AsString+' , '
                            +FieldByName('Instrumento').AsString+' , '
                            +FieldByName('Serie').AsString);
                   Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                   fNominales_Vigentes := 1;
                 end;

              conversion_unidad_mon(FieldByName('Moneda').AsString,
                                 'CLP',
                                 'BC',
                                 dfecha_cierre,
                                 fNominales_Vigentes,
                                 fNominales_Vigentes,
                                 Modulo_Err,
                                 String_Err,
                                 Result);
              if Not Result then
                 begin
                   strpcopy(aux_pchar,'No existe Valor '+FieldByName('Moneda').AsString+' al: '
                   +datetostr(dfecha_Cierre)+' Se asume Valor 1');
                   Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                   fNominales_Vigentes := 1;
              end;
              fNominales_cartera := FieldByName('Valor_Nominal').AsFloat;
              conversion_unidad_mon(FieldByName('Moneda').AsString,
                                 'CLP',
                                 'BC',
                                 dfecha_cierre,
                                 fNominales_cartera,
                                 fNominales_cartera,
                                 Modulo_Err,
                                 String_Err,
                                 Result);
              if Not Result then
                 begin
                   strpcopy(aux_pchar,'No existe Valor '+FieldByName('Moneda').AsString+' al: '
                   +datetostr(dfecha_Cierre)+' Se asume Valor 1');
                   Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                   fNominales_Cartera := 1;
                 end;


              fLimite := (fInstrum_Emisor * fNominales_Vigentes ) / 100;
              fPorcentaje_max := fInstrum_Emisor;

              sTag := '';
              if bSimular then
                 begin
                   Datos_Simulacion_Serie(FieldByName('Emisor').AsString
                                         ,FieldByName('Instrumento').AsString
                                         ,FieldByName('Serie').AsString
                                         ,fNominales_Simulacion );
                   if fNominales_Simulacion <> 0 then
                      sTag := 'S';
                 end;
              Qry_Update.Sql.Clear;
              Qry_Update.Sql.Add('Select * from qs_fin_lim_serie '
                                +' where emisor = :emisor '
                                +'   and nro_inscripcion = :nro_inscripcion '
                                +'   and instrumento = :instrumento '
                                +'   and fecha = :fecha '
                                +'   and cartera = :cartera '
                                );
              Qry_Update.ParamByName('CARTERA').AsString      := scartera;
              Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
              Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
              Qry_Update.ParamByName('instrumento').AsString  := FieldByName('Instrumento').AsString;
              Qry_Update.ParamByName('nro_inscripcion').AsFloat:= fNro_Inscripcion;
              Qry_Update.Prepare;
              Qry_Update.Open;
              if Qry_Update.FieldByName('Emisor').IsNull then
                 begin
                   Qry_Update.Close;
                   Qry_Update.Unprepare;
                   Qry_Update.Sql.Clear;
                   Qry_Update.Sql.Add('insert into qs_fin_lim_serie  ( '
                                     +' CARTERA          '
                                     +',FECHA            '
                                     +',EMISOR           '
                                     +',INSTRUMENTO      '
                                     +',SERIE            '
                                     +',VALOR_PRESENTE   '
                                     +',NOMINALES        '
                                     +',NOMINALES_EMI    '
                                     +',PORCENTAJE_LIM   '
                                     +',MAXIMO_PERM      '
                                     +',MARGEN_INV       '
                                     +',PORCENTAJE_USE   '
                                     +',TAG              '
                                     +',NRO_INSCRIPCION )'
                                     +'   values (       '
                                     +' :CARTERA          '
                                     +',:FECHA            '
                                     +',:EMISOR           '
                                     +',:INSTRUMENTO      '
                                     +',:SERIE            '
                                     +',:VALOR_PRESENTE   '
                                     +',:NOMINALES        '
                                     +',:NOMINALES_EMI    '
                                     +',:PORCENTAJE_LIM   '
                                     +',:MAXIMO_PERM      '
                                     +',:MARGEN_INV       '
                                     +',:PORCENTAJE_USE   '
                                     +',:TAG              '
                                     +',:NRO_INSCRIPCION )'
                                     );
                   if bSimular then
                      fNominales_Cartera := fNominales_Cartera + fNominales_Simulacion;

                   Qry_Update.ParamByName('CARTERA').AsString      := scartera;
                   Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
                   Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
                   Qry_Update.ParamByName('INSTRUMENTO').AsString  := FieldByName('Instrumento').AsString;
                   Qry_Update.ParamByName('SERIE').AsString        := FieldByName('Serie').AsString;
                   Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fNominales_Cartera;
                   Qry_Update.ParamByName('NOMINALES').AsFloat     := fNominales_Cartera;
                   Qry_Update.ParamByName('NOMINALES_EMI').AsFloat := fNominales_Vigentes;
                   Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
                   Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
                   Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fNominales_Cartera;
                   Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fNominales_Cartera / fLimite;
                   Qry_Update.ParamByName('TAG').AsString          := sTag;
                   Qry_Update.ParamByName('NRO_INSCRIPCION').AsFloat:= fNro_Inscripcion;
                   Qry_Update.Prepare;
                   Qry_Update.Execsql;
                   Qry_Update.Close;
                   Qry_Update.Unprepare;
                 end
              else
                 begin
                   sSerie     := Qry_Update.FieldByName('Serie').AsString;
                   fNominales := Qry_Update.FieldByName('Nominales').AsFloat;
                   Qry_Update.Close;
                   Qry_Update.Unprepare;
                   Qry_Update.Sql.Clear;
                   Qry_Update.Sql.Add('Update qs_fin_lim_serie set '
                                     +' SERIE          = :serie  '
                                     +',VALOR_PRESENTE = :Valor_Presente '
                                     +',NOMINALES      = :Nominales  '
                                     +',NOMINALES_EMI  = :Nominales_emi  '
                                     +',PORCENTAJE_LIM = :porcentaje_lim  '
                                     +',MAXIMO_PERM    = :maximo_perm '
                                     +',MARGEN_INV     = :margen_inv  '
                                     +',PORCENTAJE_USE = :porcentaje_use  '
                                     +',TAG            = :tag             '
                                     +' Where CARTERA = :cartera      '
                                     +'   and FECHA   = :fecha        '
                                     +'   and EMISOR  = :emisor       '
                                     +'   and INSTRUMENTO = :instrumento  '
                                     +'   and nro_inscripcion = :nro_inscripcion '
                                     );
                   if bSimular then
                      fNominales_Cartera := fNominales_Cartera + fNominales_Simulacion;
                   fNominales_cartera := fNominales_Cartera + fNominales;

                   Qry_Update.ParamByName('CARTERA').AsString      := scartera;
                   Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
                   Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
                   Qry_Update.ParamByName('INSTRUMENTO').AsString  := FieldByName('Instrumento').AsString;

                   Qry_Update.ParamByName('SERIE').AsString        := sSerie + ','+FieldByName('Serie').AsString;
                   Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fNominales_Cartera;
                   Qry_Update.ParamByName('NOMINALES').AsFloat     := fNominales_Cartera;
                   Qry_Update.ParamByName('NOMINALES_EMI').AsFloat := fNominales_Vigentes;
                   Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
                   Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
                   Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fNominales_Cartera;
                   Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fNominales_Cartera / fLimite;
                   Qry_Update.ParamByName('TAG').AsString          := sTag;
                   Qry_Update.ParamByName('NRO_INSCRIPCION').AsFloat:= fNro_Inscripcion;
                   Qry_Update.Prepare;
                   Qry_Update.Execsql;
                   Qry_Update.Close;
                   Qry_Update.Unprepare;

                 end;{update}
              Next;
            end;{while}
        if bSimular then
           Simulacion_Datos_Nuevos (dFecha_Cierre
                                   ,sCartera
                                   ,sEmpresa
                                   ,fInstrum_Emisor
                                   ,sError
                                   ,bResult
                                   );

    end;{with frm}

end;
end;
{   ------------------------------------------------------------------------
   Esta rutina determinará los limites por Series que no se encuentran en la cartera
   de los Bonos Empresas ingresados para simulación
   ------------------------------------------------------------------------ }
procedure Simulacion_Datos_Nuevos (dFecha_Cierre : TDateTime;
                                   sCartera      : String;
                                   sEmpresa      : String;
                                   fPorcentaje   : Double;
                               var sError        : String;
                               var bResult       : boolean
                                   );
var
  aux_pchar, aux_Titulo  : array[0..250] of char;
  sTag                   : String;
  fValor_Cartera         : Double;
  fValor_Invertido       : Double;
  fNominales_Vigentes    : Double;
  fLimite                : Double;
  fPorcentaje_max        : Double;
  fValor_Moneda          : Double;
  Modulo_Err             : String;
  String_Err             : String;
  Result                 : Boolean;
  fNominales_cartera     : Double;
  fNominales_Simulacion  : Double;
  sSerie                 : String;
  fNominales             : Double;
  fNro_Inscripcion       : Double;
begin
  with DM_Margenes,Qry_Insert do
  begin
    Sql.Clear;
    Sql.Add('Select * from qs_tmp_simulacion '
           +' where serie not in (select serie from qs_fin_lim_serie '
           +'                     where cartera = :cartera '
           +'                       and fecha   = :fecha ) '
           +'   and instrumento = :instrumento '
           );
    ParamByName('cartera').AsString := sCartera;
    ParamByName('Fecha').AsDateTime := dFecha_Cierre;
    ParamByName('instrumento').AsString := 'BONO EMPRE';
    Prepare;
    Open;
    while NOT EOF do
      begin
        fLimite := 0;
        fPorcentaje_max := 0;
        fNominales_Vigentes := FieldByname('Nominales_Vigentes').AsFloat;
        if fNominales_Vigentes = 0 then
           begin
             strpcopy(aux_pchar,'Nominales Vigentes para '
                            +FieldByName('Emisor').AsString+' , '
                            +FieldByName('Instrumento').AsString+' , '
                            +FieldByName('Serie').AsString);
             Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
             fNominales_Vigentes := 1;
           end;

           conversion_unidad_mon(FieldByName('Moneda_datos').AsString,
                                'CLP',
                                'BC',
                                dfecha_cierre,
                                fNominales_Vigentes,
                                fNominales_Vigentes,
                                Modulo_Err,
                                String_Err,
                                Result);
           if Not Result then
              begin
                strpcopy(aux_pchar,'No existe Valor '+FieldByName('Moneda_datos').AsString+' al: '
                +datetostr(dfecha_Cierre)+' Se asume Valor 1');
                Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                fNominales_Vigentes := 1;
              end;
           fNominales_cartera := FieldByName('Nominales').AsFloat;
           conversion_unidad_mon(FieldByName('Moneda').AsString,
                                 'CLP',
                                 'BC',
                                 dfecha_cierre,
                                 fNominales_cartera,
                                 fNominales_cartera,
                                 Modulo_Err,
                                 String_Err,
                                 Result);
           if Not Result then
              begin
                strpcopy(aux_pchar,'No existe Valor '+FieldByName('Moneda').AsString+' al: '
                +datetostr(dfecha_Cierre)+' Se asume Valor 1');
                Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                fNominales_Cartera := 1;
              end;


            fLimite := (fPorcentaje * fNominales_Vigentes ) / 100;
            fPorcentaje_max := fPorcentaje;

            sTag := 'S';


            Qry_Update.Sql.Clear;
            Qry_Update.Sql.Add('Select * from qs_fin_lim_serie '
                              +' where emisor = :emisor '
                              +'   and nro_inscripcion = :nro_inscripcion '
                              +'   and instrumento = :instrumento '
                              +'   and fecha = :fecha '
                              +'   and cartera = :cartera '
                              );
            Qry_Update.ParamByName('CARTERA').AsString      := scartera;
            Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
            Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
            Qry_Update.ParamByName('instrumento').AsString  := FieldByName('Instrumento').AsString;
            Qry_Update.ParamByName('nro_inscripcion').AsFloat:= FieldByName('Nro_Inscripcion').AsFloat;
            Qry_Update.Prepare;
            Qry_Update.Open;
            if Qry_Update.FieldByName('Emisor').IsNull then
               begin
                 Qry_Update.Sql.Clear;
                 Qry_Update.Sql.Add('insert into qs_fin_lim_serie  ( '
                                   +' CARTERA          '
                                   +',FECHA            '
                                   +',EMISOR           '
                                   +',INSTRUMENTO      '
                                   +',SERIE            '
                                   +',VALOR_PRESENTE   '
                                   +',NOMINALES        '
                                   +',NOMINALES_EMI    '
                                   +',PORCENTAJE_LIM   '
                                   +',MAXIMO_PERM      '
                                   +',MARGEN_INV       '
                                   +',PORCENTAJE_USE   '
                                   +',TAG )            '
                                   +'   values (       '
                                   +' :CARTERA          '
                                   +',:FECHA            '
                                   +',:EMISOR           '
                                   +',:INSTRUMENTO      '
                                   +',:SERIE            '
                                   +',:VALOR_PRESENTE   '
                                   +',:NOMINALES        '
                                   +',:NOMINALES_EMI    '
                                   +',:PORCENTAJE_LIM   '
                                   +',:MAXIMO_PERM      '
                                   +',:MARGEN_INV       '
                                   +',:PORCENTAJE_USE   '
                                   +',:TAG )            '
                                    );

                 Qry_Update.ParamByName('CARTERA').AsString      := scartera;
                 Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
                 Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
                 Qry_Update.ParamByName('INSTRUMENTO').AsString  := FieldByName('Instrumento').AsString;
                 Qry_Update.ParamByName('SERIE').AsString        := FieldByName('Serie').AsString;
                 Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fNominales_Cartera;
                 Qry_Update.ParamByName('NOMINALES').AsFloat     := fNominales_Cartera;
                 Qry_Update.ParamByName('NOMINALES_EMI').AsFloat := fNominales_Vigentes;
                 Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
                 Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
                 Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fNominales_Cartera;
                 Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fNominales_Cartera / fLimite;
                 Qry_Update.ParamByName('TAG').AsString          := sTag;
                 Qry_Update.Prepare;
                 Qry_Update.Execsql;
                 Qry_Update.Close;
                 Qry_Update.Unprepare;
              end
            else
              begin
                 sSerie     := Qry_Update.FieldByName('Serie').AsString;
                 fNominales := Qry_Update.FieldByName('Nominales').AsFloat;
                 Qry_Update.Close;
                 Qry_Update.Unprepare;
                 Qry_Update.Sql.Clear;
                 Qry_Update.Sql.Add('Update qs_fin_lim_serie set '
                                   +' SERIE          = :serie  '
                                   +',VALOR_PRESENTE = :Valor_Presente '
                                   +',NOMINALES      = :Nominales  '
                                   +',NOMINALES_EMI  = :Nominales_emi  '
                                   +',PORCENTAJE_LIM = :porcentaje_lim  '
                                   +',MAXIMO_PERM    = :maximo_perm '
                                   +',MARGEN_INV     = :margen_inv  '
                                   +',PORCENTAJE_USE = :porcentaje_use  '
                                   +',TAG            = :tag             '
                                   +' Where CARTERA = :cartera      '
                                   +'   and FECHA   = :fecha        '
                                   +'   and EMISOR  = :emisor       '
                                   +'   and INSTRUMENTO = :instrumento  '
                                   +'   and nro_inscripcion = :nro_inscripcion '
                                   );
                                   
                 fNominales_cartera := fNominales_Cartera + fNominales;
                 Qry_Update.ParamByName('CARTERA').AsString      := scartera;
                 Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
                 Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
                 Qry_Update.ParamByName('INSTRUMENTO').AsString  := FieldByName('Instrumento').AsString;
                 Qry_Update.ParamByName('SERIE').AsString        := sSerie + ','+FieldByName('Serie').AsString;
                 Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fNominales_Cartera;
                 Qry_Update.ParamByName('NOMINALES').AsFloat     := fNominales_Cartera;
                 Qry_Update.ParamByName('NOMINALES_EMI').AsFloat := fNominales_Vigentes;
                 Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
                 Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
                 Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fNominales_Cartera;
                 Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fNominales_Cartera / fLimite;
                 Qry_Update.ParamByName('TAG').AsString          := sTag;
                 Qry_Update.ParamByName('NRO_INSCRIPCION').AsFloat:= fNro_Inscripcion;
                 Qry_Update.Prepare;
                 Qry_Update.Execsql;
                 Qry_Update.Close;
                 Qry_Update.Unprepare;
              end;
            Next;
      end;{while}
      Close;
      Unprepare;
  end;{Dm_Margenes}
end;{procedure}

{   ------------------------------------------------------------------------
    Esta Rutina detemina los margenes para los nuevos emisores que se
    incorporan en tabla de simulacion
    ------------------------------------------------------------------------}
procedure Simulacion_Datos_Nuevos_Emisor(dFecha_Cierre : TDateTime;
                                         sCartera      : String;
                                         sEmpresa      : String;
                                         sCia_Grupo    : String;
                                         fRT_mas_PR    : Double;
                                         fParticipacion: Double;
                                     var sError        : String;
                                     var bResult       : boolean
                                        );
var
  fLimite_Max       : Double;
  fReserva_adi      : Double;
  fPatRiesgo        : Double;
  fRTyPR_Emisor     : Double;
  fInstrum_Emisor   : Double;
  fMultiplo         : Double;

  aux_pchar, aux_Titulo: array[0..250] of char;
  sTag                   : String;
  fValor_Cartera         : Double;
  fValor_Invertido       : Double;
  sGrupo_economico       : String;
  sSugrupo_economico     : String;
  fPatrimonio            : Double;
  fTotal_LH_emitidas     : Double;
  fTotal_Dep_Captaciones : Double;
  fTotal_Acc_suscritas   : Double;
  fNominales_Vigentes    : Double;
  fLimite_1              : Double;
  fLimite_2              : Double;
  fLimite_3              : Double;
  fLimite                : Double;
  fPorcentaje_max        : Double;
  fValor_Moneda          : Double;
  Modulo_Err             : String;
  String_Err             : String;
  Result                 : Boolean;

begin
with DM_Margenes do
begin
  sError  := '';
  bResult := True;

  with Qry_General do
      begin
        // Agrupar por emisor grupo inst. a los cuales se les calcula lim x emisor
        Sql.Clear;
        Sql.Add('SELECT A.EMISOR            as emisor '
               +'      ,C.DESCRIPCION_NODO  as Grupo  '
               +'      ,A.MONEDA            as Moneda '
               +'      ,SUM(A.Valor_Invertido) as Valor_cartera '
               +'      ,SUM(A.Patrimonio)      as Patrimonio '
               +'      ,SUM(A.Nominales_Vigentes) as Nominales_Vigentes '
               +'      ,Sum(a.Factor_Riesgo* a.Valor_Invertido) / sum(a.valor_invertido) as Factor_Riesgo'
               +'  FROM QS_TMP_SIMULACION A  '
               +'      ,QS_SYS_CLASIF_OBJ B '
               +'      ,QS_SYS_EST_CLA C '
               +' WHERE A.INSTRUMENTO  = B.ELEMENTO '
               +'   AND B.CODIGO_CLASIF = C.CODIGO_OBJETO '
               +'   AND B.NODO          = C.NODO    '
               +'   AND B.OBJETO        = :objeto '
               +'   AND B.CODIGO_CLASIF = :codigo_clasif '
               +'   AND C.DESCRIPCION_NODO NOT IN (:GRUPO) '
               +'   AND A.EMISOR NOT IN (SELECT D.EMISOR FROM QS_FIN_LIM_EMI D '
               +'                          WHERE D.CARTERA = :CARTERA '
               +'                            AND D.FECHA   = :FECHA ) '
               +' GROUP BY A.EMISOR,C.DESCRIPCION_NODO,A.MONEDA ');

          ParamByName('objeto').AsString := 'INSTRUM';
          ParamByName('codigo_clasif').AsString := 'LEY251';
          ParamByName('GRUPO').AsString := '''A'''+''','''+'''D'''+''','''+'''K''';
          ParamByName('cartera').AsString := sCartera;
          ParamByName('Fecha').AsDateTime := dFecha_Cierre;
          Prepare;
          Open;
          first;
          While NOT EOF do
            begin
              Datos_Grupo_Instr(FieldByName('Grupo').AsString
                         ,fLimite_Max
                         ,fReserva_adi
                         ,fPatRiesgo
                         ,fRTyPR_Emisor
                         ,fInstrum_Emisor
                         ,fMultiplo
                        );
              fPatrimonio       := FieldByName('Patrimonio').AsFloat;
              fTotal_LH_emitidas:= 0;//FieldByName('Letras_Emitidas').AsFloat;
              fTotal_Dep_Captaciones := 0;//FieldByName('Dep_Captaciones').AsFloat;

        {Calculo de Limites }
        fLimite := 0;
        fPorcentaje_max := 0;
        if FieldByName('Grupo').AsString = 'B' then
           begin
             fLimite_1 := (fRTyPR_Emisor * fRT_mas_PR ) / 100;
             fLimite_2 := (fInstrum_Emisor * fTotal_Dep_Captaciones) / 100;
             fLimite_3 := fMultiplo * fParticipacion * fPatrimonio
                          * FieldByName('Factor_Riesgo').AsFloat;
           end;
        if FieldByName('Grupo').AsString = 'C' then
           begin
             fLimite_1 := (fRTyPR_Emisor * fRT_mas_PR ) / 100;
             fLimite_2 := (fInstrum_Emisor * fTotal_LH_emitidas) / 100;
             fLimite_3 := fMultiplo * fParticipacion * fPatrimonio
                          * FieldByName('Factor_Riesgo').AsFloat;
           end;
        if FieldByName('Grupo').AsString = 'E' then
           begin
             fNominales_Vigentes := FieldByName('Nominales_Vigentes').AsFloat;
             if fNominales_Vigentes = 0 then
                 begin
                  strpcopy(aux_pchar,'No se encontró Nominal Vigente '
                 +'para emisor '+FieldByName('Emisor').AsString+' ');
                 Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                 fNominales_Vigentes := 1;
                 end;

                 conversion_unidad_mon(FieldByName('Moneda').AsString,
                                       'CLP',
                                       'BC',
                                       dfecha_cierre,
                                       fNominales_Vigentes,
                                       fNominales_Vigentes,
                                       Modulo_Err,
                                       String_Err,
                                       Result);
              if Not Result then
                 begin
                  strpcopy(aux_pchar,'No existe Valor '+FieldByName('Moneda').AsString+' al: '
                 +datetostr(dfecha_Cierre)+' Se asume Valor 1');
                 Application.MessageBox(aux_pchar, aux_Titulo, mb_OK);
                 fNominales_Vigentes := 1;
                end;


             fLimite_1 := (fRTyPR_Emisor * fRT_mas_PR ) / 100;
             fLimite_2 := (fInstrum_Emisor * fNominales_Vigentes ) / 100;
             fLimite_3 := fMultiplo * fParticipacion * fPatrimonio
                          * FieldByName('Factor_Riesgo').AsFloat;
           end;
           if sCia_Grupo = 'P' then
              fLimite_3 := 9999999999.0;

           {Determinar el límite menor de los 3 calculados}
           if fLimite_1 < fLimite_2 then
              begin
                if fLimite_1 < fLimite_3 then
                   begin
                     fLimite := fLimite_1;
                     fPorcentaje_max := fRTyPR_Emisor;
                   end
                else
                   begin
                     fLimite := fLimite_3;
                     fPorcentaje_max := fMultiplo * fParticipacion
                                      * FieldByName('Factor_Riesgo').AsFloat;
                   end;
              end
           else
              begin
                if fLimite_2 < fLimite_3 then
                   begin
                     fLimite := fLimite_2;
                     fPorcentaje_max := fInstrum_Emisor;
                   end
                else
                   begin
                     fLimite := fLimite_3;
                     fPorcentaje_max := fMultiplo * fParticipacion
                                      * FieldByName('Factor_Riesgo').AsFloat;
                   end;
              end;
           sTag := 'S';
           fValor_Cartera := FieldByName('Valor_Cartera').AsFloat;
           Qry_Update.Sql.Clear;
           Qry_Update.Sql.Add('insert into qs_fin_lim_emi  ( '
                             +' CARTERA          '
                             +',FECHA            '
                             +',EMISOR           '
                             +',GRUPO_INST       '
                             +',VALOR_PRESENTE   '
                             +',NOMINALES        '
                             +',NOMINALES_EMI    '
                             +',PORCENTAJE_LIM   '
                             +',MAXIMO_PERM      '
                             +',MARGEN_INV       '
                             +',LIMITE_1         '
                             +',LIMITE_2         '
                             +',LIMITE_3         '
                             +',PORCENTAJE_USE   '
                             +',TAG )            '
                             +'   values (       '
                             +' :CARTERA          '
                             +',:FECHA            '
                             +',:EMISOR           '
                             +',:GRUPO_INST       '
                             +',:VALOR_PRESENTE   '
                             +',:NOMINALES        '
                             +',:NOMINALES_EMI    '
                             +',:PORCENTAJE_LIM   '
                             +',:MAXIMO_PERM      '
                             +',:MARGEN_INV       '
                             +',:LIMITE_1         '
                             +',:LIMITE_2         '
                             +',:LIMITE_3         '
                             +',:PORCENTAJE_USE   '
                             +',:TAG )            '
                              );

              Qry_Update.ParamByName('CARTERA').AsString      := scartera;
              Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
              Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
              Qry_Update.ParamByName('GRUPO_INST').AsString   := FieldByName('Grupo').AsString;
              Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fValor_Cartera;
              Qry_Update.ParamByName('NOMINALES').AsFloat     := 0;
              Qry_Update.ParamByName('NOMINALES_EMI').AsFloat := fNominales_Vigentes;
              Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
              Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
              Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fValor_Cartera;
              Qry_Update.ParamByName('LIMITE_1').AsFloat      := fLimite_1;
              Qry_Update.ParamByName('LIMITE_2').AsFloat      := fLimite_2;
              Qry_Update.ParamByName('LIMITE_3').AsFloat      := fLimite_3;
              Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fValor_Cartera / fLimite;
              Qry_Update.ParamByName('TAG').AsString          := sTag;
              Qry_Update.Prepare;
              Qry_Update.Execsql;
              Qry_Update.Close;
              Qry_Update.Unprepare;
              Next;
            end;{while}
            Close;
            Unprepare;
    end;{with frm}

end;
end;

{   ------------------------------------------------------------------------
    Esta Rutina detemina los margenes para los grupos economicos
    ------------------------------------------------------------------------}
Procedure Calculos_Margenes_Grupo_Economicos(dFecha_Cierre : TDateTime;
                                             sCartera      : String;
                                             sEmpresa      : String;
                                             bSimular      : boolean;
                                         var sError        : String;
                                         var bResult       : boolean
                                             );
var
  fReserva_Tecnica  : Double;
  fPatrimonio_Riesgo: Double;
  fParticipacion    : Double;
  fRT_mas_PR        : Double;

  fLimite_Max       : Double;
  fReserva_adi      : Double;
  fPatRiesgo        : Double;
  fRTyPR_Emisor     : Double;
  fInstrum_Emisor   : Double;
  fMultiplo         : Double;

  aux_pchar, aux_Titulo: array[0..250] of char;
  sTag                   : String;
  fValor_Cartera         : Double;
  fValor_Invertido       : Double;
  fNominales_Vigentes    : Double;
  fLimite                : Double;
  fPorcentaje_max        : Double;
  fValor_Moneda          : Double;
  Modulo_Err             : String;
  String_Err             : String;
  Result                 : Boolean;
  fNominales_cartera     : Double;
  fNominales_Simulacion  : Double;

begin
with DM_Margenes do
begin
  sError  := '';
  bResult := True;
  Datos_Compania(sCartera
                ,dFecha_Cierre
                ,fReserva_Tecnica
                ,fPatrimonio_Riesgo
                ,fParticipacion
                ,fRT_mas_PR
                ,sError
                ,bResult
                );

  with Qry_General do
      begin // Borrar calculos anteriores
        sql.Clear;
        sql.add('delete from qs_fin_lim_grupo '
               +' where fecha = :fecha_cierre '
               +'   and cartera = :cartera ' );
        ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
        ParamByName('cartera').AsString        := sCartera;
        Prepare;
        Execsql;
        Close;
        Unprepare;
        // Agrupar por grupos economicos
        Sql.Clear;
        Sql.Add('SELECT C.CODIGO_HOLDING+C.DESCRIPCION as Grupo_Eco '
               +'      ,A.EMISOR                as Emisor '
               +'      ,SUM(A.VALOR_PTE_MC_CPA) as Valor_Cartera '
               +'  FROM QS_RES_MERCADO A '
               +'      ,QS_SYS_DES_HOLDING B '
               +'      ,QS_SYS_HOLDING C '
               +' WHERE A.FECHA_CIERRE = :Fecha_Cierre '
               +'   AND A.EMISOR = B.EMPRESA '
               +'   AND B.CODIGO_HOLDING = C.CODIGO_HOLDING ');
        if scartera <> 'CONSOLIDAD' then
           sql.Add('   AND A.CARTERA      = :cartera ');
        sql.Add('   AND A.EMPRESA      = :empresa '
               +'   AND A.INSTRUMENTO IN (SELECT D.ELEMENTO '
               +'                           FROM QS_SYS_CLASIF_OBJ D '
               +'                              , QS_SYS_EST_CLA E '
               +'                          WHERE D.CODIGO_CLASIF = E.CODIGO_OBJETO '
               +'                            AND D.NODO          = E.NODO    '
               +'                            AND D.CODIGO_CLASIF = :codigo_clasif '
               +'                            AND D.OBJETO        = :objeto '
               +'                            AND E.DESCRIPCION_NODO IN (:GRUPO)) '
               +' GROUP BY C.CODIGO_HOLDING+C.DESCRIPCION , A.EMISOR ' );
          ParamByName('objeto').AsString := 'INSTRUM';
          ParamByName('codigo_clasif').AsString := 'LEY251';
          ParamByName('Grupo').AsString := '''B'''+''','''+'''C'''+''','''+'''E'''+''','''+'''G''';
          ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
          if scartera <> 'CONSOLIDAD' then
             ParamByName('cartera').AsString        := sCartera;
          ParamByName('empresa').AsString        := sEmpresa;
          Prepare;
          Open;
          first;
          While NOT EOF do
            begin

              {Calculo de Limites }
              fLimite := 0;
              fPorcentaje_max := 0;
              fValor_cartera  := FieldByName('Valor_Cartera').AsFloat;

              fLimite := (fRT_mas_PR * 25.0 ) / 100;
              fPorcentaje_max := 25.0;
              if (Holding_Empresa(FieldByName('Emisor').AsString) =
                 Holding_Empresa(sEmpresa)) then
                 begin
                   fLimite := fLimite / 2;
                   fPorcentaje_max := fPorcentaje_max / 2;
                 end;

              sTag := '';
              if bSimular then
                 begin
                   Datos_Simulacion_Grupo_Eco(FieldByName('Emisor').AsString
                                             ,fValor_Invertido );
                   if fValor_Invertido <> 0 then
                      sTag := 'S';
                 end;

           Qry_Update.Sql.Clear;
           Qry_Update.Sql.Add('insert into qs_fin_lim_Grupo  ( '
                             +' CARTERA          '
                             +',FECHA            '
                             +',GRUPO_ECO        '
                             +',EMISOR           '
                             +',VALOR_PRESENTE   '
                             +',PORCENTAJE_LIM   '
                             +',MAXIMO_PERM      '
                             +',MARGEN_INV       '
                             +',PORCENTAJE_USE   '
                             +',TAG )            '
                             +'   values (       '
                             +' :CARTERA          '
                             +',:FECHA            '
                             +',:GRUPO_ECO        '
                             +',:EMISOR           '
                             +',:VALOR_PRESENTE   '
                             +',:PORCENTAJE_LIM   '
                             +',:MAXIMO_PERM      '
                             +',:MARGEN_INV       '
                             +',:PORCENTAJE_USE   '
                             +',:TAG )            '
                              );
              if bSimular then
                 fValor_cartera := fValor_cartera + fValor_Invertido;

              Qry_Update.ParamByName('CARTERA').AsString      := scartera;
              Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
              Qry_Update.ParamByName('GRUPO_ECO').AsString    := FieldByName('Grupo_Eco').AsString;
              Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
              Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
              Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
              Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fValor_Cartera / fLimite;
              Qry_Update.ParamByName('TAG').AsString          := sTag;
              Qry_Update.Prepare;
              Qry_Update.Execsql;
              Qry_Update.Close;
              Qry_Update.Unprepare;
              Next;
            end;{while}

    end;{with frm}

end;
end;

{ funcion que indica a que grupo de la clasificacion segun ley 251 pertenece el instrumento}
function Grupo_Inst_251(sInstrumento:String):String;
begin
  With DM_Margenes,Qry_Multiproposito do
    begin
      Sql.Clear;
      Sql.Add('select b.descripcion_nodo as grupo '
             +'  from qs_sys_clasif_obj a '
             +'      ,qs_sys_est_cla b '
             +' where a.codigo_clasif = :codigo_clasif '
             +'   AND a.OBJETO = :objeto '
             +'   and a.codigo_clasif = b.codigo_objeto '
             +'   and a.nodo = b.nodo '
             +'   and a.elemento = :Instrumento ');
      ParamByName('objeto').AsString := 'INSTRUM';
      ParamByName('codigo_clasif').AsString := 'LEY251';
      ParamByName('Instrumento').AsString := sInstrumento;
      Prepare;
      Open;
      if FieldByName('grupo').IsNull then
         Result := ''
      else
         Result := FieldByName('grupo').AsString;
      Close;
      Unprepare;
    end;
end;
{   ------------------------------------------------------------------------
    Esta Rutina detemina los margenes para los instrumentos de renta
    Variable ( Grupo de instrumentos)
    ------------------------------------------------------------------------}
Procedure Calculo_margenes_inst_Renta_Variable(dFecha_Cierre : TDateTime;
                                               sCartera      : String;
                                               sEmpresa      : String;
                                               bSimular      : boolean;
                                           var sError        : String;
                                           var bResult       : boolean
                                        );
var
  fReserva_Tecnica  : Double;
  fPatrimonio_Riesgo: Double;
  fParticipacion    : Double;
  fRT_mas_PR        : Double;
  fLimite_Max       : Double;
  fReserva_adi      : Double;
  fPatRiesgo        : Double;
  fRTyPR_Emisor     : Double;
  fInstrum_Emisor   : Double;
  fMultiplo         : Double;
  sTag             : String;
  fValor_Cartera   : Double;
  fValor_Invertido : Double;
  sGrupo           : String;
begin
with DM_Margenes do
begin
  sError  := '';
  bResult := True;
  Datos_Compania(sCartera
                ,dFecha_Cierre
                ,fReserva_Tecnica
                ,fPatrimonio_Riesgo
                ,fParticipacion
                ,fRT_mas_PR
                ,sError
                ,bResult
                );

  with Qry_General do
      begin
        sql.Clear;
        sql.add('delete from qs_fin_lim_inst '
               +' where fecha = :fecha_cierre '
               +'   and grupo_grl = :GRUPO '
               +'   and cartera = :cartera ' );
        ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
        ParamByName('GRUPO').AsString          := 'RV';
        ParamByName('cartera').AsString        := sCartera;
        Prepare;
        Execsql;
        Close;
        Unprepare;

        Sql.Clear;
        Sql.Add('select b.codigo_instrumento as instrumento '
               +'      ,sum(a.total_final)   as valor_cartera '
               +'  from qs_res_valoriza_rv a  '
               +'      ,qs_fin_nem_rvari b    '
               +' where a.fecha_cierre = :fecha_cierre ');
        if scartera <> 'CONSOLIDAD' then
           sql.Add('   and a.cartera      = :cartera ');
        sql.Add('   and a.empresa      = :empresa '
               +'   and a.nemotecnico  = b.codigo_nemotecnico '
               +' group by b.codigo_instrumento ');
          ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
          if scartera <> 'CONSOLIDAD' then
             ParamByName('cartera').AsString        := sCartera;
          ParamByName('empresa').AsString        := sEmpresa;
          Prepare;
          Open;
          first;
          While NOT EOF do
            begin
              sGrupo := Grupo_Inst_251(FieldByName('Instrumento').AsString);
              Datos_Grupo_Instr(sGrupo
                         ,fLimite_Max
                         ,fReserva_adi
                         ,fPatRiesgo
                         ,fRTyPR_Emisor
                         ,fInstrum_Emisor
                         ,fMultiplo
                        );
              sTag := '';

              Qry_Update.Sql.Clear;
              Qry_Update.Sql.Add('insert into qs_fin_lim_inst  ( '
                                +' CARTERA          '
                                +',FECHA            '
                                +',GRUPO_GRL        '
                                +',GRUPO_INST       '
                                +',VALOR_PRESENTE   '
                                +',PORCENTAJE_LIM   '
                                +',MAXIMO_PERM      '
                                +',MERGEN_INV       '
                                +',PORCENTAJE_USE   '
                                +',TAG )            '
                                +'   values (       '
                                +' :CARTERA         '
                                +',:FECHA           '
                                +',:GRUPO_GRL       '
                                +',:GRUPO_INST      '
                                +',:VALOR_PRESENTE  '
                                +',:PORCENTAJE_LIM  '
                                +',:MAXIMO_PERM     '
                                +',:MERGEN_INV      '
                                +',:PORCENTAJE_USE  '
                                +',:TAG ) '
                                );
              sTag := '';
              fValor_Cartera := FieldByName('Valor_Cartera').AsFloat;
              Qry_Update.ParamByName('CARTERA').AsString      := scartera;
              Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
              Qry_Update.ParamByName('GRUPO_GRL').AsString    := 'RV';
              Qry_Update.ParamByName('GRUPO_INST').AsString   := sGrupo;
              Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fLimite_Max;
              Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fRT_mas_PR * fLimite_Max / 100;
              Qry_Update.ParamByName('MERGEN_INV').AsFloat    := (fRT_mas_PR * fLimite_Max / 100)
                                                                - fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= (fValor_Cartera
                                                                / fRT_mas_PR) * 100;
              Qry_Update.ParamByName('TAG').AsString          := sTag;
              Qry_Update.Prepare;
              Qry_Update.Execsql;
              Qry_Update.Close;
              Qry_Update.Unprepare;
              Next;
            end;{while}
    end;{with frm}
end;
end;

{   ------------------------------------------------------------------------
    Esta Rutina detemina los margenes para las matrices y filiales (subgrupo)
    ------------------------------------------------------------------------}
Procedure Calculos_Margenes_Sub_Grupo_Eco(dFecha_Cierre : TDateTime;
                                          sCartera      : String;
                                          sEmpresa      : String;
                                          bSimular      : boolean;
                                      var sError        : String;
                                      var bResult       : boolean
                                          );
var
  fReserva_Tecnica  : Double;
  fPatrimonio_Riesgo: Double;
  fParticipacion    : Double;
  fRT_mas_PR        : Double;

  fLimite_Max       : Double;
  fReserva_adi      : Double;
  fPatRiesgo        : Double;
  fRTyPR_Emisor     : Double;
  fInstrum_Emisor   : Double;
  fMultiplo         : Double;

  aux_pchar, aux_Titulo  : array[0..250] of char;
  sTag                   : String;
  fValor_Cartera         : Double;
  fValor_Invertido       : Double;
  fNominales_Vigentes    : Double;
  fLimite                : Double;
  fPorcentaje_max        : Double;
  fValor_Moneda          : Double;
  Modulo_Err             : String;
  String_Err             : String;
  Result                 : Boolean;
  fNominales_cartera     : Double;
  fNominales_Simulacion  : Double;

begin
with DM_Margenes do
begin
  sError  := '';
  bResult := True;
  Datos_Compania(sCartera
                ,dFecha_Cierre
                ,fReserva_Tecnica
                ,fPatrimonio_Riesgo
                ,fParticipacion
                ,fRT_mas_PR
                ,sError
                ,bResult
                );

  with Qry_General do
      begin // Borrar calculos anteriores
        sql.Clear;
        sql.add('delete from qs_fin_lim_grupo '
               +' where fecha = :fecha_cierre '
               +'   and cartera = :cartera ' );
        ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
        ParamByName('cartera').AsString        := sCartera;
        Prepare;
        Execsql;
        Close;
        Unprepare;
        // Agrupar por grupos economicos
        Sql.Clear;
        Sql.Add('SELECT C.CODIGO_HOLDING+C.DESCRIPCION as Grupo_Eco '
               +'      ,A.EMISOR                as Emisor '
               +'      ,SUM(A.VALOR_PTE_MC_CPA) as Valor_Cartera '
               +'  FROM QS_RES_MERCADO A '
               +'      ,QS_SYS_DEF_HOLDING B '
               +'      ,QS_SYS_HOLDING C '
               +' WHERE A.FECHA_CIERRE = :Fecha_Cierre '
               +'   AND A.EMISOR = B.CODIGO_EMPRESA '
               +'   AND B.CODIGO_HOLDING = C.CODIGO_HOLDING ');
        if scartera <> 'CONSOLIDAD' then
           sql.Add('   AND A.CARTERA      = :cartera ');
        sql.Add('   AND A.EMPRESA      = :empresa '
               +'   AND A.INSTRUMENTO IN (SELECT D.ELEMENTO '
               +'                           FROM QS_SYS_CLASIF_OBJ D '
               +'                              , QS_SYS_EST_CLA E '
               +'                          WHERE D.CODIGO_CLASIF = E.CODIGO_OBJETO '
               +'                            AND D.NODO          = E.NODO    '
               +'                            AND D.CODIGO_CLASIF = :codigo_clasif '
               +'                            AND D.OBJETO        = :objeto '
               +'                            AND E.DESCRIPCION_NODO IN (:Grupo)) '
               +' GROUP BY C.CODIGO_HOLDING+C.DESCRIPCION , A.EMISOR ' );
          ParamByName('objeto').AsString := 'INSTRUM';
          ParamByName('codigo_clasif').AsString := 'LEY251';
          ParamByName('Grupo').AsString := '''B'''+''','''+'''C'''+''','''+'''E'''+''','''+'''G''';
          ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
          if scartera <> 'CONSOLIDAD' then
             ParamByName('cartera').AsString        := sCartera;
          ParamByName('empresa').AsString        := sEmpresa;
          Prepare;
          Open;
          first;
          While NOT EOF do
            begin

              {Calculo de Limites }
              fLimite := 0;
              fPorcentaje_max := 0;
              fValor_cartera  := FieldByName('Valor_Cartera').AsFloat;

              fLimite := (fRT_mas_PR * 25.0 ) / 100;
              fPorcentaje_max := 25.0;
              if (Holding_Empresa(FieldByName('Emisor').AsString) =
                 Holding_Empresa(sEmpresa)) then
                 begin
                   fLimite := fLimite / 2;
                   fPorcentaje_max := fPorcentaje_max / 2;
                 end;

              sTag := '';
              if bSimular then
                 begin
                   Datos_Simulacion_Grupo_Eco(FieldByName('Emisor').AsString
                                             ,fValor_Invertido );
                   if fValor_Invertido <> 0 then
                      sTag := 'S';
                 end;

           Qry_Update.Sql.Clear;
           Qry_Update.Sql.Add('insert into qs_fin_lim_Grupo  ( '
                             +' CARTERA          '
                             +',FECHA            '
                             +',GRUPO_ECO        '
                             +',EMISOR           '
                             +',VALOR_PRESENTE   '
                             +',PORCENTAJE_LIM   '
                             +',MAXIMO_PERM      '
                             +',MARGEN_INV       '
                             +',PORCENTAJE_USE   '
                             +',TAG )            '
                             +'   values (       '
                             +' :CARTERA          '
                             +',:FECHA            '
                             +',:GRUPO_ECO        '
                             +',:EMISOR           '
                             +',:VALOR_PRESENTE   '
                             +',:PORCENTAJE_LIM   '
                             +',:MAXIMO_PERM      '
                             +',:MARGEN_INV       '
                             +',:PORCENTAJE_USE   '
                             +',:TAG )            '
                              );
              if bSimular then
                 fValor_cartera := fValor_cartera + fValor_Invertido;

              Qry_Update.ParamByName('CARTERA').AsString      := scartera;
              Qry_Update.ParamByName('FECHA').AsDateTime      := dFecha_Cierre;
              Qry_Update.ParamByName('GRUPO_ECO').AsString    := FieldByName('Grupo_Eco').AsString;
              Qry_Update.ParamByName('EMISOR').AsString       := FieldByName('Emisor').AsString;
              Qry_Update.ParamByName('VALOR_PRESENTE').AsFloat:= fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_LIM').AsFloat:= fPorcentaje_max;
              Qry_Update.ParamByName('MAXIMO_PERM').AsFloat   := fLimite;
              Qry_Update.ParamByName('MARGEN_INV').AsFloat    := fLimite - fValor_Cartera;
              Qry_Update.ParamByName('PORCENTAJE_USE').AsFloat:= fValor_Cartera / fLimite;
              Qry_Update.ParamByName('TAG').AsString          := sTag;
              Qry_Update.Prepare;
              Qry_Update.Execsql;
              Qry_Update.Close;
              Qry_Update.Unprepare;
              Next;
            end;{while}

    end;{with frm}

end;
end;


end.
