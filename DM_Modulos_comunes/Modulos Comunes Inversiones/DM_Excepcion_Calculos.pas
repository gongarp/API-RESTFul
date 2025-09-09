unit DM_Excepcion_Calculos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DM_Variables_Valorizacion, DM_Global_Var, DM_FuncionesMemory,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmManejaExcepcion = class(TDataModule)
    Qry_Excepciones: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure Analiza_Excepcion_Variacion_Cambiaria(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                                  sCodigo_Emisor       : String;
                                                  sCodigo_Instrumento  : String;
                                                  sSerie               : String;
                                                  Registro_Fechas      : TRegistro_Fechas;
                                                  var Modulo_Err       : String;
                                                  var String_Err       : String;
                                                  var Result           : Boolean);

  procedure Verifica_Excepcion_Variacion_Cambiaria(sCodigo_Emisor                 : String;
                                                   sCodigo_Instrumento            : String;
                                                   sSerie                         : String;
                                                   fCupon                         : Double;
                                                   dFecha_Calculo                 : TDateTime;
                                                   var fPtje_Aplica_Reajuste      : Double;
                                                   var sCodigo_MondInd            : String;
                                                   var s0Cod_Tratam_Inicio        : String;
                                                   var s1Cod_Tratam_Termino       : String;
                                                   var dFecha_Inicio_Tratamiento  : TDatetime;
                                                   var dFecha_Termino_Tratamiento : TDatetime;
                                                   var sPaga_Reajuste_Capital     : String;
                                                   var sNo_Considera_en_Interes   : String;
                                                   var sSolo_Aplica_en_Vctos      : String;
                                                   var sNo_Considera_Negativos    : String;
                                                   var Result                     : Boolean);

  procedure Calcula_Variacion_Cambiaria(sCod_Moneda_Indice    : String;
                                        sTratam_Inicio        : String;
                                        sTratam_Termino       : String;
                                        Registro_Fechas       : TRegistro_Fechas;
                                        fPtje_Aplica_Reajuste : Double;
                                        var fFactor_Variacion : Double;
                                        var dFecha_Inicio     : TDateTime;
                                        var dFecha_Termino    : TDateTime;
                                        var fValor_Ind_Inicio : Double;
                                        var fValor_Ind_Termino: Double;
                                        var Modulo_Err        : String;
                                        var String_Err        : String;
                                        var Result            : Boolean);

  procedure Factor_Variacion(sCod_Indice            : String;
                             fPtje_Aplica_Reajuste  : Double;
                             var dFecha_Inicio      : TDateTime;
                             var dFecha_Termino     : TDateTime;
                             dFecha_Calculo         : TDateTime;
                             var fValor_Variacion   : Double;
                             var fValor_Ind_Inicio  : Double;
                             var fValor_Ind_Termino : Double;
                             var sString_Err        : String;
                             var sModulo_Err        : String;
                             var Result             : Boolean);



  function Metodo_Sin_Tasa_Referencia(sFormula : String;
                                      dFecha   : TDateTime) : String;

  function Metodo_Calculo_Tasa_Basica(sFormula : String;
                                      dFecha   : TDateTime) : String;


  procedure Parametros_Margen(sCod_Formula       : String;
                              dFecha             : TDateTime;
                              var RegParamMargen : TRegParamMargen;
                              var Result         : Boolean);

  procedure Calcula_PROMTAS( sCodigo_Tasa    : String;
                             sTratam_Inicio        : String;
                             sTratam_Termino       : String;
                             Registro_Fechas       : TRegistro_Fechas;
                             var fTasa_Promedio    : Double;
                             var dFecha_Inicio     : TDateTime;
                             var dFecha_Termino    : TDateTime;
                             var Modulo_Err        : String;
                             var String_Err        : String;
                             var Result            : Boolean);

var
  dmManejaExcepcion: TdmManejaExcepcion;

implementation
uses DMLeer_Valor_Cambio,
     DM_ComunInversiones,
     DM_Base_Datos,
     DM_Variables_menu;

{$R *.DFM}
//------------------------------------------------------------------------------
procedure Analiza_Excepcion_Variacion_Cambiaria(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                                sCodigo_Emisor       : String;
                                                sCodigo_Instrumento  : String;
                                                sSerie               : String;
                                                Registro_Fechas      : TRegistro_Fechas;
                                                var Modulo_Err       : String;
                                                var String_Err       : String;
                                                var Result           : Boolean);
var
   fPtje_Aplica_Reajuste : Double;
   sCodigo_MondInd       : String;
   sCod_Tratam_Inicio    : String;
   sCod_Tratam_Termino   : String;
   Flag_Excepcion_VarCam : Boolean;
   fFactor_Variacion_Cupon : Double;
   i                       : Integer;
   fValor_Ind_Inicio       : Double;
   fValor_Ind_Termino      : Double;
   dFecha_Inicio           : TDateTime;
   dFecha_Termino          : TDateTime;
   dAux_Fecha_Calculo      : TDateTime;
   sPaga_Reajuste_Capital  : String;
   sNo_Considera_en_Interes: String;
   sSolo_Aplica_en_Vctos   : String;
   sNo_Considera_Negativos : String;
begin
  // Funcion que agrupa el proceso
  // de VERIFICAR si se debe aplicar
  // la excepcion variación cambiaria
  // Si corresponde CALCULA el factor
  // correspondiente
  // Finalmente la aplica a los flujos
  // de la tabla de desarrollo en memoria

  Result := True;
  i := 1;
//  While (Array_Mem_Desarr[i].Nro_Cupon <> 0) do
  While (i <= Max_Nro_Cupones) do
  begin
      // Nuevo Busca variacion cambiaria segun cupon
      Verifica_Excepcion_Variacion_Cambiaria_Vigente_Mem(sCodigo_Emisor
                                                        ,sCodigo_Instrumento
                                                        ,sSerie
                                                        ,Array_Mem_Desarr[i].Nro_Cupon
                                                        ,Registro_Fechas.Fecha_Calculo
                                                        ,fPtje_Aplica_Reajuste
                                                        ,sCodigo_MondInd
                                                        ,sCod_Tratam_Inicio
                                                        ,sCod_Tratam_Termino
                                                        ,Registro_Fechas.Fecha_Desde
                                                        ,Registro_Fechas.Fecha_Hasta
                                                        ,sPaga_Reajuste_Capital
                                                        ,sNo_Considera_en_Interes
                                                        ,sSolo_Aplica_en_Vctos
                                                        ,sNo_Considera_Negativos
                                                        ,Flag_Excepcion_VarCam
                                                        );
      if Flag_Excepcion_VarCam then
      begin

         if i = 1 then
            registro_Fechas.Fecha_Inic_Periodo := Registro_Fechas.Fecha_Emision
         else
            registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[i-1].Fecha_Vcto;

         registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[i].Fecha_Vcto;


         if Registro_Fechas.Fecha_Hasta > Registro_Fechas.Fecha_Calculo then
            Registro_Fechas.Fecha_Hasta := Registro_Fechas.Fecha_Calculo;


         // Se dejo que la asigne siempre (fuera del if)
         // ya que cuando no pasaba la perdia mas abajo... 16-12-2005 F.I.
         dAux_fecha_Calculo            := Registro_Fechas.Fecha_Calculo;

         if Array_Mem_Desarr[i].Fecha_Vcto < Registro_Fechas.Fecha_Calculo then
            Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[i].Fecha_Vcto;



         //Si Valorizo desde la Mesa en el el Interactivo
         // cargo valores...
         // lo hago asi y no en procesos como GAAP o libros
         // porque habria que Borrar lor indices por cada registro....
         // y asi modificar la llamada en cada Programa que valoriza
         {
         Inabilitado por F.I. 18/10/2004
         Cuando se trato de valorizar un titulo con variacion desde 6 meses antes de la emision
         no encontro valores ....

          if sValorizacion_Interactiva = 'SI' then
             if NOT VarIsArray(Reg_Valores_Indices.Codigo_Indice) then
                Carga_Valores_Indices_Mem( Registro_Fechas.Fecha_Emision
                                          ,Registro_Fechas.Fecha_Vencimiento
                                          ,sCodigo_MondInd
                                          );
         }
         Calcula_Variacion_Cambiaria(sCodigo_MondInd
                                    ,sCod_Tratam_Inicio
                                    ,sCod_Tratam_Termino
                                    ,Registro_Fechas
                                    ,fPtje_Aplica_Reajuste
                                    ,fFactor_Variacion_Cupon
                                    ,dFecha_Inicio
                                    ,dFecha_Termino
                                    ,fValor_Ind_Inicio
                                    ,fValor_Ind_Termino
                                    ,Modulo_Err
                                    ,String_Err
                                    ,Result);
         Registro_Fechas.Fecha_Calculo := dAux_fecha_Calculo;
         if NOT Result then
            Break;
      end
      else
      begin
         fFactor_Variacion_Cupon := 1;
         sCodigo_MondInd := '';
         dFecha_Inicio := 0;
         dFecha_Termino := 0;
         fValor_Ind_Inicio := 0;
         fValor_Ind_Termino := 0;
         sCod_Tratam_Inicio := '';
         sCod_Tratam_Termino := '';
      end;

      //ggarcia 12-07-2018
      if sSolo_Aplica_en_Vctos = 'SI' then
         if (Array_Mem_Desarr[i].Fecha_Vcto > Registro_Fechas.Fecha_Calculo) then
            fFactor_Variacion_Cupon := 1;

      //ggarcia 12-07-2018
      if sNo_Considera_Negativos = 'SI' then
         if fFactor_Variacion_Cupon < 0 then
            fFactor_Variacion_Cupon := 1;

      //fFactor_Variacion_Cupon := fFactor_Variacion * fFactor_Variacion_Cupon;

      Array_Mem_Desarr[i].Cod_Moneda_Ind          := sCodigo_MondInd;
      Array_Mem_Desarr[i].Cod_Tratam_Inicio       := sCod_Tratam_Inicio;
      Array_Mem_Desarr[i].Cod_Tratam_Termino      := sCod_Tratam_Termino;
      Array_Mem_Desarr[i].Valor_Ind_Inicio        := fValor_Ind_Inicio;
      Array_Mem_Desarr[i].Valor_Ind_Termino       := fValor_Ind_Termino;
      Array_Mem_Desarr[i].Fecha_Inicio            := dFecha_Inicio;
      Array_Mem_Desarr[i].Fecha_Termino           := dFecha_Termino;

      Array_Mem_Desarr[i].Factor_VarCam := fFactor_Variacion_Cupon;

      //ggarcia 12-07-2018
      if sNo_Considera_en_Interes <> 'SI' then
         Array_Mem_Desarr[i].Interes    := Array_Mem_Desarr[i].Interes * fFactor_Variacion_Cupon;

      Array_Mem_Desarr[i].Amortizacion  := Array_Mem_Desarr[i].Amortizacion * fFactor_Variacion_Cupon;

      // PAGA REAJUSTE DE CAPITAL EN LOS CUPONES
      // SOLO SI ESTOS NO AMORTIZAN !!!!!
      if (Array_Mem_Desarr[i].Amortizacion = 0)    and
         (sPaga_Reajuste_Capital           = 'SI') then
         Array_Mem_Desarr[i].Reajuste_Capital_Pagado := ( Array_Mem_Desarr[i].Saldo_Insoluto *
                                                          fFactor_Variacion_Cupon) -
                                                          Array_Mem_Desarr[i].Saldo_Insoluto
      else
         Array_Mem_Desarr[i].Reajuste_Capital_Pagado := 0;

      //Array_Mem_Desarr[i].Valor_Cupon   :=   OJO
      //Array_Mem_Desarr[i].Valor_Cupon * fFactor_Variacion;

      Array_Mem_Desarr[i].Valor_Cupon   := Array_Mem_Desarr[i].Interes +
                                           Array_Mem_Desarr[i].Amortizacion +
                                           Array_Mem_Desarr[i].Reajuste_Capital_Pagado;

      inc(i);
  end;
end;
//------------------------------------------------------------------------------
procedure Verifica_Excepcion_Variacion_Cambiaria(sCodigo_Emisor                 : String;
                                                 sCodigo_Instrumento            : String;
                                                 sSerie                         : String;
                                                 fCupon                         : Double;
                                                 dFecha_Calculo                 : TDateTime;
                                                 var fPtje_Aplica_Reajuste      : Double;
                                                 var sCodigo_MondInd            : String;
                                                 var s0Cod_Tratam_Inicio        : String;
                                                 var s1Cod_Tratam_Termino       : String;
                                                 var dFecha_Inicio_Tratamiento  : TDatetime;
                                                 var dFecha_Termino_Tratamiento : TDatetime;
                                                 var sPaga_Reajuste_Capital     : String;
                                                 var sNo_Considera_en_Interes   : String;
                                                 var sSolo_Aplica_en_Vctos      : String;
                                                 var sNo_Considera_Negativos    : String;
                                                 var Result                     : Boolean);
begin
   Verifica_Excepcion_Variacion_Cambiaria_Vigente_Mem(sCodigo_Emisor
                                                     ,sCodigo_Instrumento
                                                     ,sSerie
                                                     ,fCupon
                                                     ,dFecha_Calculo
                                                     ,fPtje_Aplica_Reajuste
                                                     ,sCodigo_MondInd
                                                     ,s0Cod_Tratam_Inicio
                                                     ,s1Cod_Tratam_Termino
                                                     ,dFecha_Inicio_Tratamiento
                                                     ,dFecha_Termino_Tratamiento
                                                     ,sPaga_Reajuste_Capital
                                                     ,sNo_Considera_en_Interes
                                                     ,sSolo_Aplica_en_Vctos
                                                     ,sNo_Considera_Negativos
                                                     ,Result);
end; // end Verifica_Excepcion_Variacion_Cambiaria
//------------------------------------------------------------------------------
procedure Calcula_Variacion_Cambiaria(sCod_Moneda_Indice    : String;
                                      sTratam_Inicio        : String;
                                      sTratam_Termino       : String;
                                      Registro_Fechas       : TRegistro_Fechas;
                                      fPtje_Aplica_Reajuste : Double;
                                      var fFactor_Variacion : Double;
                                      var dFecha_Inicio     : TDateTime;
                                      var dFecha_Termino    : TDateTime;
                                      var fValor_Ind_Inicio : Double;
                                      var fValor_Ind_Termino: Double;
                                      var Modulo_Err        : String;
                                      var String_Err        : String;
                                      var Result            : Boolean);
begin
  // Ojo: A pesar de que llegue la variable
  // con el nombre Cod_Moneda_Indice ...
  // Se llego a la conclusión que solo
  // pueden ser Indices
  // Filigara-Brasil 30 de Junio del 2000
  Registro_Fechas.Fecha_Parametro := Registro_Fechas.Fecha_Desde;
  Tratamiento_Fecha(sTratam_Inicio
                   ,Registro_Fechas
                   ,dFecha_Inicio
                   ,Modulo_Err
                   ,String_Err
                   ,Result
                   );
  if NOT Result then
     exit;

  Registro_Fechas.Fecha_Parametro := Registro_Fechas.Fecha_Hasta;
  Tratamiento_Fecha(sTratam_Termino
                   ,Registro_Fechas
                   ,dFecha_Termino
                   ,Modulo_Err
                   ,String_Err
                   ,Result);

  if NOT Result then
     exit;

  Factor_Variacion(sCod_Moneda_Indice
                  ,fPtje_Aplica_Reajuste
                  ,dFecha_Inicio
                  ,dFecha_Termino
                  ,Registro_Fechas.Fecha_Calculo
                  ,fFactor_Variacion
                  ,fValor_Ind_Inicio
                  ,fValor_Ind_Termino
                  ,String_Err
                  ,Modulo_Err
                  ,Result);

end;  //end Calcula_Variacion_Cambiaria
//------------------------------------------------------------------------------
procedure Factor_Variacion(sCod_Indice            : String;
                           fPtje_Aplica_Reajuste  : Double;
                           var dFecha_Inicio      : TDateTime;
                           var dFecha_Termino     : TDateTime;
                           dFecha_Calculo         : TDateTime;
                           var fValor_Variacion   : Double;
                           var fValor_Ind_Inicio  : Double;
                           var fValor_Ind_Termino : Double;
                           var sString_Err        : String;
                           var sModulo_Err        : String;
                           var Result             : Boolean);
var

  sReal_Estimada : String;
  dFecha_Proyeccion : TDateTime;


begin
{
  if  VarIsArray(Reg_Valores_Indices.Codigo_Indice) then
     Leer_Valor_Indice_mem(sCod_Indice
                          ,dFecha_Inicio
                          ,fValor_Ind_Inicio
                          ,Result)
  else
}
    Leer_Valor_Indice(sCod_Indice
                      ,dFecha_Inicio
                      ,fValor_Ind_Inicio
                      ,Result);

  if NOT Result then
     begin
// Proyeccion Simple por ahora fijo !!!
       Tasa_Proyeccion_Simple(sCod_Indice
                             ,dFecha_Calculo //ggarcia 05-11-2018 no de deben considerar las fechas a futuro dFecha_Inicio //ggarcia 09-08-2018 se debe proyectar con fecha inicio  //dFecha_Calculo
                             ,dFecha_Proyeccion
                             ,sReal_Estimada
                             ,fValor_Ind_Inicio
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

       if NOT Result then
       begin
          sModulo_Err := 'Factor de Variación';
          sString_Err := 'No se encontro valor para '''+sCod_Indice+#10
                        +'A fecha : '+DateToStr(dFecha_Inicio);
          exit;
       end;
       dFecha_Inicio := dFecha_Proyeccion;
     end;
{
  if  VarIsArray(Reg_Valores_Indices.Codigo_Indice) then
     Leer_Valor_Indice_mem(sCod_Indice
                          ,dFecha_Termino
                          ,fValor_Ind_Termino
                          ,Result)
  else
}
     Leer_Valor_Indice(sCod_Indice
                      ,dFecha_Termino
                      ,fValor_Ind_Termino
                      ,Result);

  if NOT Result then
     begin
// Proyeccion Simple por ahora fijo !!!
       Tasa_Proyeccion_Simple(sCod_Indice
                             ,dFecha_Termino //ggarcia 09-08-2018 se debe proyectar con fecha termino  //dFecha_Calculo
                             ,dFecha_Proyeccion
                             ,sReal_Estimada
                             ,fValor_Ind_Termino
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

       if NOT Result then
       begin
          sModulo_Err := 'Factor de Variación';
          sString_Err := 'No se encontro valor para '''+sCod_Indice+''''#10
                       +'A fecha : '+DateToStr(dFecha_Termino);
          exit;
       end;
       dFecha_Termino := dFecha_Proyeccion;
     end;

  if (fValor_Ind_Inicio = 0) then
     begin
        sModulo_Err := 'Factor de Variación';
        sString_Err := 'Error al determinar Factor de Variación'#10
                      +'Valor en 0 (cero) para '''+sCod_Indice+''''#10
                      +'A fecha : '+DateToStr(dFecha_Inicio);
        Result := False;
        exit;
     end;

  if (fValor_Ind_Termino = 0) then
     begin
        sModulo_Err := 'Factor de Variación';
        sString_Err := 'Error al determinar Factor de Variación'#10
                      +'Valor en 0 (cero) para '''+sCod_Indice+''''#10
                      +'A fecha : '+DateToStr(dFecha_Termino);
        Result := False;
        exit;
     end;

//  13-09-2019 F.I. Por un caso en La Positica se elimina esta condicion, que aparte de que sea por logica no tiene justificación.
//  15-10-2019 F.I. Se acuerda con T.L. ponerle una implicancia ya que afecto a otras compañías y se va a conversar con ellas antes de entregar el cambio.

  if (dFecha_Inicio > dFecha_Termino) and NOT ( transaccion_implica_Mem('VARCAM','FECHA_INVERSA') ) then
     fValor_Variacion := 1
  else
     fValor_Variacion := fValor_Ind_Termino / fValor_Ind_Inicio;

  //ggarcia 10-04-2023
  fValor_Variacion := ((fValor_Variacion - 1) * fPtje_Aplica_Reajuste/100) + 1;

end;

//------------------------------------------------------------------------------
function Metodo_Sin_Tasa_Referencia(sFormula : String;
                                    dFecha   : TDateTime) : String;
begin
   WITH dmManejaExcepcion.Qry_Excepciones do
     begin
       SQL.Clear;
       SQL.Add('SELECT Metodo_Sin_T_Ref');
       SQL.Add('  FROM Qs_Fin_Met_SinTRef');
       SQL.Add(' WHERE Cod_Formula = :Cod_Formula');
       SQL.Add('   AND Fecha_Desde <= :Fecha');
       SQL.Add('   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)');

       ParamByName('Cod_Formula').AsString   := sFormula;
       ParamByName('Fecha'      ).AsDateTime := dFecha;
       Prepare;
       Open;

       if (FieldByName('Metodo_Sin_T_Ref').AsString = '') or
          (FieldByName('Metodo_Sin_T_Ref').IsNull)        then
          Result := ''
       else
          Result := FieldByName('Metodo_Sin_T_Ref').AsString;
       Close;
     end;
end;
//------------------------------------------------------------------------------
function Metodo_Calculo_Tasa_Basica(sFormula : String;
                                    dFecha   : TDateTime) : String;
begin
   WITH dmManejaExcepcion.Qry_Excepciones do
     begin
       SQL.Clear;
       SQL.Add('SELECT Metodo');
       SQL.Add('  FROM Qs_Fin_Met_TBasica');
       SQL.Add(' WHERE Cod_Formula = :Cod_Formula');
       SQL.Add('   AND Fecha_Desde <= :Fecha');
       SQL.Add('   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)');

       ParamByName('Cod_Formula').AsString   := sFormula;
       ParamByName('Fecha'      ).AsDateTime := dFecha;
       Prepare;
       Open;

       if (FieldByName('Metodo').AsString = '') or
          (FieldByName('Metodo').IsNull)        then
          Result := ''
       else
          Result := FieldByName('Metodo').AsString;
       Close;
       UnPrepare;
     end;
end;
//------------------------------------------------------------------------------

procedure Parametros_Margen(sCod_Formula       : String;
                            dFecha             : TDateTime;
                            var RegParamMargen : TRegParamMargen;
                            var Result         : Boolean);
begin
   WITH dmManejaExcepcion.Qry_Excepciones do
     begin
       SQL.Clear;
{
       SQL.Add('SELECT Cod_Formula');
       SQL.Add('      ,Fecha_Aplica');
       SQL.Add('      ,Tipo_Margen');
       SQL.Add('      ,Interpolacion');
       SQL.Add('      ,Cod_Valor1');
       SQL.Add('      ,Operacion');
       SQL.Add('      ,Cod_Valor2');
       SQL.Add('      ,Periodo_Aplica_D');
       SQL.Add('      ,Periodo_Aplica_H');
       SQL.Add('      ,Tasa_Base');
       SQL.Add('      ,Aplica_Flujo');
}
       SQL.Add('SELECT *');
       SQL.Add('  FROM QS_FIN_MET_PMARGEN');
       SQL.Add(' WHERE Cod_Formula  = :Cod_Formula');
       SQL.Add('   AND Fecha_Desde <= :Fecha');
       SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

       ParamByName('Cod_Formula').AsString := sCod_Formula;
       ParamByName('Fecha').AsDateTime     := dFecha;

//       Prepare;
       Open;

       if (FieldByName('Cod_Formula').AsString <> sCod_Formula) or
          (FieldByName('Cod_Formula').IsNull)                   then
          begin
            Result := False;
            Close;
//            UnPrepare;
            Exit;
          end;

       RegParamMargen.Fecha_Aplica_1     := FieldByName('Fecha_Aplica_1'  ).AsString;
       RegParamMargen.Fecha_Aplica_2     := FieldByName('Fecha_Aplica_2'  ).AsString;
       RegParamMargen.Cod_Valor1         := FieldByName('Cod_Valor1'      ).AsString;
       RegParamMargen.Tasa_Base_1        := FieldByName('Tasa_Base_1'       ).AsString;
       RegParamMargen.Interpolacion_1    := FieldByName('Interpolacion_1'   ).AsString;
       RegParamMargen.Periodo_Aplica_D_1 := FieldByName('Periodo_Aplica_D_1').AsString;
       RegParamMargen.Periodo_Aplica_H_1 := FieldByName('Periodo_Aplica_H_1').AsString;
       RegParamMargen.Aplica_Flujo_1     := FieldByName('Aplica_Flujo_1'    ).AsString;
       RegParamMargen.Cod_Valor2         := FieldByName('Cod_Valor2'      ).AsString;
       RegParamMargen.Tasa_Base_2        := FieldByName('Tasa_Base_2'       ).AsString;
       RegParamMargen.Interpolacion_2    := FieldByName('Interpolacion_2'   ).AsString;
       RegParamMargen.Periodo_Aplica_D_2 := FieldByName('Periodo_Aplica_D_2').AsString;
       RegParamMargen.Periodo_Aplica_H_2 := FieldByName('Periodo_Aplica_H_2').AsString;
       RegParamMargen.Aplica_Flujo_2     := FieldByName('Aplica_Flujo_2'    ).AsString;
       RegParamMargen.Operacion          := FieldByName('Operacion'       ).AsString;
       RegParamMargen.Operacion_1        := FieldByName('Operacion_1'     ).AsString;
       RegParamMargen.Operacion_2        := FieldByName('Operacion_2'     ).AsString;

       RegParamMargen.Redondeo_Truncado  := FieldByName('Redondeo_Truncado').AsString;
       RegParamMargen.Numero_Decimales   := FieldByName('Numero_Decimales').AsFloat;
       RegParamMargen.constante_1        := FieldByName('constante_1').AsFloat;
       RegParamMargen.constante_2        := FieldByName('constante_2').AsFloat;
       RegParamMargen.Tasa_Conversion_1        := FieldByName('Tasa_Conversion_1').AsString;
       RegParamMargen.Tasa_Conversion_2        := FieldByName('Tasa_Conversion_2').AsString;

       Close;
//       Unprepare;
       Result := True;
     end;
end;
//------------------------------------------------------------------------------
procedure Calcula_PROMTAS( sCodigo_Tasa    : String;
                           sTratam_Inicio        : String;
                           sTratam_Termino       : String;
                           Registro_Fechas       : TRegistro_Fechas;
                           var fTasa_Promedio    : Double;
                           var dFecha_Inicio     : TDateTime;
                           var dFecha_Termino    : TDateTime;
                           var Modulo_Err        : String;
                           var String_Err        : String;
                           var Result            : Boolean);

var
  fNum_Registros : Double;
begin
  fNum_Registros := 0;
  fTasa_Promedio := 0;
  Registro_Fechas.Fecha_Parametro := Registro_Fechas.Fecha_Desde;
  Tratamiento_Fecha(sTratam_Inicio
                   ,Registro_Fechas
                   ,dFecha_Inicio
                   ,Modulo_Err
                   ,String_Err
                   ,Result
                   );
  if NOT Result then
     exit;

  // Si la fecha de inicio es posterior a la fecha de calculo
  // Devuelve cero (Esta pendiente determinar una mejor forma de proyección de valores desconocidos.
  if dFecha_Inicio < Registro_Fechas.Fecha_Calculo then
     exit;


  Registro_Fechas.Fecha_Parametro := Registro_Fechas.Fecha_Hasta;
  Tratamiento_Fecha(sTratam_Termino
                   ,Registro_Fechas
                   ,dFecha_Termino
                   ,Modulo_Err
                   ,String_Err
                   ,Result);

  if NOT Result then
     exit;

  With dmManejaExcepcion.Qry_Excepciones do
  begin
    SQL.Clear;
    SQL.Add('SELECT Valor_Moneda ');
    SQL.Add('  FROM QS_SYS_VAL_CAMBIO ');
    SQL.Add(' WHERE Fecha_Paridad BETWEEN :Fecha_Desde AND :Fecha_Hasta ');
    SQL.Add('   AND Cod_Moneda = :Cod_Moneda                            ');

    ParamByName('Fecha_Desde').AsDateTime := dFecha_Inicio;
    ParamByName('Fecha_Hasta').AsDateTime := dFecha_Termino;

    Open;
    While NOT EOF do
    begin
      fTasa_Promedio := fTasa_Promedio + FieldByName('Valor_Moneda').AsFloat;
      fNum_Registros := fNum_Registros + 1;
      Next;
    end;

    if fNum_Registros > 0 then
       fTasa_Promedio := fTasa_Promedio / fNum_Registros;
    Close;
  end;
end;  //end Calcula_PROMTAS
//------------------------------------------------------------------------------
end.
