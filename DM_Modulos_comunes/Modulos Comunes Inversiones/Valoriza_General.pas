unit Valoriza_General;
interface
uses
   SysUtils,
   Dialogs,
   Windows,
   FireDAC.Stan.Util,
   DM_Variables_Valorizacion,
   DM_variables_Menu,
   DM_FuncionesMemory,
   DM_Identidad_Direccion,
   DM_Paises,
   DM_Global_Var;

  procedure Valoriza_Registro(var Reg_Val_In  : TRegistro_Valoriza_In;
                              var Reg_Val_Out : TRegistro_Valoriza_Out;
                              var Modulo_Err  : String;
                              var String_Err  : String;
                              var Result      : Boolean);

  Procedure ValorizaBonoReco(sNemotecnico    : String;
                             dFechaCalculo   : TDateTime;
                             sTipo_Calculo   : String;
                         var fNominales      : Double;
                         var fTasaCalculo    : Double;
                         var fPrecio         : Double;
                         var fValorInversion : Double;
                         var fValor_PAR_UM   : Double;
                         var fValor_Par      : Double;
                         var fValor_Final    : Double;
                         var Modulo_Err      : String;
                         var String_Err      : String;
                         var Result          : Boolean);

  procedure Valuacion(var Reg_Val_In      : TRegistro_Valoriza_In;
                      var Reg_Val_Out : TRegistro_Valoriza_Out;
                      var Modulo_Err  : String;
                      var String_Err  : String;
                      var Result      : Boolean);

  procedure TIR_Valuacion( var Reg_Val_In      : TRegistro_Valoriza_In;
                           var Reg_Val_Out : TRegistro_Valoriza_Out;
                           var Modulo_Err  : String;
                           var String_Err  : String;
                           var Result      : Boolean);

  procedure Limpia_Valor_Interes(var Reg_Val_In      : TRegistro_Valoriza_In;
                      var Reg_Val_Out : TRegistro_Valoriza_Out;
                      var Modulo_Err  : String;
                      var String_Err  : String;
                      var Result      : Boolean);

  procedure Carga_TabDesarr(sTipo_Instrumento    : String;
                            sEmisor              : String;
                            sInstrumento         : String;
                            sSerie               : String;
                            sNemotecnico         : String;
                            sTipoNominales       : String;
                            fNominales           : Double;
                            fTasaEmision         : Double;
                            dFechaEmision        : TDateTime;
                            var dFechaVencimiento: TDateTime;
                            dFechaCalculo        : TDateTime;
                            sTasa_Valor_PAR      : String;
                            bConCupon            : Boolean;
                            var Array_Mem_Desarr : TArray_Mem_Desarr;
                            var RegDes           : TReg_Descriptor;
                            var Registro_Fechas  : TRegistro_Fechas;
                            var sMetodo_Sin_Tasa_Referencia : String;
                            sParametros_Formula             : TRegFormulaPAR;
                            var sModulo_Err      : String;
                            var sString_Err      : String;
                            var Result           : Boolean);
  procedure Carga_TabDesarr_Vig(sTipo_Instrumento    : String;
                                sEmisor              : String;
                                sInstrumento         : String;
                                sSerie               : String;
                                dFecha_Vig           : TDateTime;
                                sNemotecnico         : String;
                                sTipoNominales       : String;
                                fNominales           : Double;
                                fTasaEmision         : Double;
                                dFechaEmision        : TDateTime;
                                var dFechaVencimiento: TDateTime;
                                dFechaCalculo        : TDateTime;
                                sTasa_Valor_PAR      : String;
                                bConCupon            : Boolean;
                                var Array_Mem_Desarr : TArray_Mem_Desarr;
                                var RegDes           : TReg_Descriptor;
                                var Registro_Fechas  : TRegistro_Fechas;
                                var sMetodo_Sin_Tasa_Referencia : String;
                                sParametros_Formula             : TRegFormulaPAR;
                                var sModulo_Err      : String;
                                var sString_Err      : String;
                                var Result           : Boolean);

  procedure Carga_RegDes(sTipo_Instrumento : String;
                         sNemotecnico      : String;
                         sEmisor           : String;
                         sInstrumento      : String;
                         sSerie            : String;
                         sUnidadMonetaria  : String;
                         fTasaEmision      : Double;
                         var RegDes        : TReg_Descriptor;
                         var sModulo_Err   : String;
                         var sString_Err   : String;
                         var Result        : Boolean);

  procedure Carga_RegDes_Vig(sTipo_Instrumento : String;
                         sNemotecnico      : String;
                         sEmisor           : String;
                         sInstrumento      : String;
                         sSerie            : String;
                         dFecha_Vig        : TDateTime;
                         sUnidadMonetaria  : String;
                         fTasaEmision      : Double;
                         var RegDes        : TReg_Descriptor;
                         var sModulo_Err   : String;
                         var sString_Err   : String;
                         var Result        : Boolean);

  procedure Valorizacion( var Reg_Val_In    : TRegistro_Valoriza_In;
                          var Reg_Val_Out   : TRegistro_Valoriza_Out;
                          var sModulo_Error : String;
                          var sString_Error : String;
                          var Result        : Boolean
                        );
  procedure Cambio_fecha_Devengamiento( var Reg_Val_In    : TRegistro_Valoriza_In;
                                          Reg_Formula_PAR : TRegFormulaPAR;
                                          Reg_Formula_TIR : TRegFormulaTIR;
                                      var Reg_Fechas      : TRegistro_Fechas;
                                      var Modulo_Err : String;
                                      var String_Err : String;
                                      var Result     : Boolean
                                     );

  procedure Calcula_Precio_Sucio_Limpio(sTipo_Precio               : String;
                                        sTipo_Valuac_Fijo_CLEAN    : String;
                                        sTipo_Valuac_Fijo_PX_DIRTY : String;
                                        var Reg_Val_In    : TRegistro_Valoriza_In;
                                        var Reg_Val_Out   : TRegistro_Valoriza_Out;
                                        var sModulo_Error : String;
                                        var sString_Error : String;
                                        var Result        : Boolean);

  procedure Recalculo_tasa_cupon(Reg_Val_In       :TRegistro_Valoriza_In;
                                 Reg_Val_Out      :TRegistro_Valoriza_Out;
                                 Registro_Fechas  :TRegistro_Fechas;
                                 Reg_Formula_PAR  :TRegFormulaPAR;
                                 Reg_Formula_TIR  :TRegFormulaTIR;
                                 sOrigen          :string;
                                 iCupon_Vigente   :Integer;
                                 dFecha_Recalculo :TDateTime;
                                 sGraba_Tasa      :Boolean;
                             var fTasa_cupon      :Double;
                             var sModulo_Err      :string;
                             var sString_Err      :string;
                             var bResultado       :Boolean);

  var fNoUtilizado : Double;


implementation

Uses
     Tabla_Mem_Desarr_TFija,
     DMLeer_valor_Cambio,
     DM_ComunInversiones,
     Funciones_Valorizacion,
     Rutinas_Informes,
     DM_Excepcion_Calculos,
     DM_Comun,
     DM_Ayuda_Monedas,
     Math;
//------------------------------------------------------------------------------
// Funcion que discrimina segun formula como valorizarlo...
//------------------------------------------------------------------------------
procedure Valoriza_Registro(var Reg_Val_In  : TRegistro_Valoriza_In;
                            var Reg_Val_Out : TRegistro_Valoriza_Out;
                            var Modulo_Err  : String;
                            var String_Err  : String;
                            var Result      : Boolean);
var
   Reg_Formula_PAR             : TRegFormulaPAR;
   Reg_Formula_TIR             : TRegFormulaTIR;
   Registro_Fechas             : TRegistro_Fechas;
   RegParamMargen              : TRegParamMargen;
   P_ValorPte                  : Double;
   sMetodo_Sin_Tasa_Referencia : String;
   sUnidad,
   sPais_Tasa,
   sAntes_Despues              : String;
   fCantidad                   : Double;
   bBusca_Proy_Precios,
   bFecha_Tope,
   bCalcula_Valor_Par,
   bResult_Devengamiento,
   bExiste_Margen             : Boolean;
   dFecha_Calculo              : TDatetime;
   sTipo_UnidadMonetaria,
   //sCodigo_Geo_Emisor,
   sDescripcion_Moneda,
   sUnidad_Conversion          : String;
   fPorcentaje_Precio,
   fTasaCalculoBR              : Double;
   //fItem_Dir_Emisor            : Double;
   //fFactor_Correccion          : Double;
   iCupon_Vigente              : Integer;
   //fValor_Ind_Inicio           : Double;
   //fValor_Ind_Termino          : Double;
   //dFecha_Inicio,
   //dFecha_Termino,
   dFecha_Tope,
   dFecha_TipoCambio           : TDatetime;

   sTipoBono                   : String;

   sTipo_Valuac   : String;
   sFormula_Pte   : String;
   fBase_Precio   : Double;
   sMon_Ind       : String;
   sOrigen        : String;
   sTipo_TasPre   : String;

   bAcumula_Factor : Boolean;
begin
  Reg_Val_In.dFechaOperacion   := Reg_Val_In.dFechaCompra;   // Se necesita para variacion cambiaria con FECOPE (Rutas del Pacifico) F.I. 06-11-2015
  Result := true;
  if sValorizacion_Proceso = 'SI' then
     Busca_Valuacion_Mem ( Reg_Val_In,
                           sTipo_Valuac,
                           sFormula_Pte,
                           fBase_Precio,
                           sMon_Ind,
                           sOrigen,
                           Result
                           )
  else
     if sValorizacion_Proceso = 'FW' then   // ggarcia 03-06-2014
     begin
        sTipo_Valuac := sTIPO_VALUACION;
        sFormula_Pte := sCODIGO_CALCULO;
        fBase_Precio := fBASE_TASA_PRECIO;
        sMon_Ind     := sMON_IND_PRECIO;
        sOrigen      := sORIGEN_PRECIO;
     end
     else
      Busca_Valuacion( Reg_Val_In,
                       sTipo_Valuac,
                       sFormula_Pte,
                       fBase_Precio,
                       sMon_Ind,
                       sOrigen,
                       Result
                       );
  if NOT Result then
     sTipo_Valuac := '';

  // Se inicializa por problema que se estaba dando en Peru (+NAN) ocasionaba float point exception 19-12-2005 F.I.
  // Se Agrego el "if" para cuando sea un BR Tipo_instrumento = 'B' no se mueva 0 al valor final 03/07/2006 CJ
   if Reg_Val_In.Tipo_Instrumento <> 'B' then
      Reg_Val_Out.fValor_Final_UM := 0;



  // Guardo el valor del parametro original enviado ya que al valoriza cambia
  // esto es para el caso Precio en OMD
  if ((Reg_Val_In.Descriptor_Cargado <> 'SI') or
      (Reg_Val_Out.RegDes.COD_CALC_PAR_D_Old = '')       //Transaccion anterior era PACTO
     ) and
     (TRIM(Reg_Val_In.sInstrumento) <> 'OMD_PACTO')
      and
     (TRIM(Reg_Val_In.sInstrumento) <> 'FWD') then //Transaccion Actual es PACTO
  begin
     if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
        Carga_RegDes(Reg_Val_In.Tipo_Instrumento
                    ,Reg_Val_In.Nemotecnico
                    ,Reg_Val_In.sEmisor
                    ,Reg_Val_In.sInstrumento
                    ,Reg_Val_In.sSerie
                    ,Reg_Val_In.sUnidadMonetaria
                    ,Reg_Val_In.dTasaEmision
                    ,Reg_Val_Out.RegDes
                    ,Modulo_Err
                    ,String_Err
                    ,Result
                    )
     else
        Carga_RegDes_Vig(Reg_Val_In.Tipo_Instrumento
                        ,Reg_Val_In.Nemotecnico
                        ,Reg_Val_In.sEmisor
                        ,Reg_Val_In.sInstrumento
                        ,Reg_Val_In.sSerie
                        ,Reg_Val_In.dFecha_Vig
                        ,Reg_Val_In.sUnidadMonetaria
                        ,Reg_Val_In.dTasaEmision
                        ,Reg_Val_Out.RegDes
                        ,Modulo_Err
                        ,String_Err
                        ,Result
                        );
     if NOT Result then
        Exit;
     Reg_Val_In.Descriptor_Cargado := 'SI';
  end
  else
  begin
     //Restablesco Valores de Formulas Par y Pte
     //POrque pueden ser cambiadas al forzar la formula Par o Pte
     Reg_Val_Out.RegDes.COD_CALC_PAR_D := Reg_Val_Out.RegDes.COD_CALC_PAR_D_Old;
     Reg_Val_Out.RegDes.COD_CALC_TIR_D := Reg_Val_Out.RegDes.COD_CALC_TIR_D_Old;

     // Para el caso de PACTO estas variables deben ir vacías
     if (TRIM(Reg_Val_In.sInstrumento) = 'OMD_PACTO') OR (TRIM(Reg_Val_In.sInstrumento) = 'FWD') then
     begin
        Reg_Val_Out.RegDes.COD_CALC_PAR_D     := '';
        Reg_Val_Out.RegDes.COD_CALC_PAR_D_Old := '';
        Reg_Val_Out.RegDes.COD_CALC_TIR_D     := '';
        Reg_Val_Out.RegDes.COD_CALC_TIR_D_Old := '';
     end;
  end;

  // Carga de Cupon cortado
  Reg_Val_Out.RegDes.fCupones_Cortados := 0;
  if (Reg_Val_In.bIncluye_CC) and
     (Transaccion_Implica(Reg_Val_In.sInstrumento,'CC')) then
  begin
     Reg_Val_Out.RegDes.fCupones_Cortados := Reg_Val_In.fCupones_Cortados;
     Reg_Val_In.Tabla_Desarr_Cargada      := 'NO';
  end;

  //Rescato Fechas de Fechas de Emisión y Vencimiento
  if (TRIM(Reg_Val_In.sInstrumento) <> 'OMD_PACTO') and (TRIM(Reg_Val_In.sInstrumento) <> 'FWD') then
  begin
      Registro_Fechas.Fecha_Compra := Reg_Val_In.dFechaCompra;
      if Reg_Val_In.Emision_Implicita = 'S' then
      begin
        Emision_Implicita( Reg_Val_In.Nemotecnico,
                           Reg_Val_In.sEmisor,
                           Reg_Val_In.sInstrumento,
                           Reg_Val_In.Sserie,
                           Registro_Fechas,
                           Reg_Val_In.Descriptor_Cargado,
                           Reg_Val_In.dFechaEmision,
                           Reg_Val_In.dFechaVencimiento,
                           Reg_Val_Out.RegDes,
                           Modulo_Err,
                           String_Err,
                           Result
                          );
        if Not Result then
           Exit;

        // Si ocurre esto quiere decir que esta vencido
        if Reg_Val_In.dFechaVencimiento < Reg_Val_In.dFechaCalculo then
        begin
           Result := False;
           Reg_Val_Out.Result_Inst_Vencido := True;
        end;
        Reg_Val_In.Descriptor_Cargado      := 'SI';
    end;  // if emision implicita
  end;

  // Vencimiento Final
  if (Reg_Val_In.dFechaVencimiento = Reg_Val_In.dFechaCalculo) and
     ( Not Reg_Val_In.Con_Cupon ) then
  begin
// E.S.  03-01-2012, para que cambie nemos con "*"
     if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
     begin
        Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                       ,Reg_Val_In.sEmisor
                       ,Reg_Val_In.sInstrumento
                       ,Reg_Val_In.sSerie
                       ,Reg_Val_In.Nemotecnico
                       ,Reg_Val_In.sTipoNominales
                       ,Reg_Val_Out.Nominales
                       ,Reg_Val_In.dTasaEmision
                       ,Reg_Val_In.dFechaEmision
                       ,Reg_Val_In.dFechaVencimiento
                       ,Reg_Val_In.dFechaCalculo
                       ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                       ,Reg_Val_In.Con_Cupon
                       ,Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_Out.RegDes
                       ,Registro_Fechas
                       ,sMetodo_Sin_Tasa_Referencia
                       ,Reg_Formula_PAR
                       ,Modulo_Err
                       ,String_Err
                       ,Result);
        if NOT Result then
           exit;

        Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
     end;

     Cambia_Nemotecnico(Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_In.dFechaCalculo//dFecha_Desde
                       ,Reg_Val_In.dFechaEmision  //dFecha_Emision
                       ,False     // True Lo cambio filigara porque el dia que corta ya no debe considerarlo
                       ,Reg_Val_Out.RegDes
                       ,Reg_Val_In.Nemotecnico
                       ,Modulo_Err
                       ,String_Err
                       ,Result);
     if Not Result then
        Exit;

     Reg_Val_Out.Valor_Par_UM     := 0;
     Reg_Val_Out.Valor_Par_MC     := 0;
     Reg_Val_Out.PorcentajePar    := 0;
     Reg_Val_Out.ValorInvertidoUM := 0;
     Reg_Val_Out.ValorInvertidoMC := 0;
     Result := True;
     Exit;
  end;

  fPorcentaje_Precio := Reg_Val_Out.PorcentajePar;
  // Fue llamado con el parametro Valuacion
  if (Reg_Val_In.Valoriza_Par_Pte = 'VAL') OR
     (Reg_Val_In.Valoriza_Par_Pte = 'TIR_VALUACION') then
  begin
     carga_parametros_formulas_mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                  ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                  ,Reg_Formula_PAR
                                  ,Reg_Formula_TIR
                                  ,Modulo_Err
                                  ,String_Err
                                  ,Result
                                  );
     if not Result then // Por Ecepciones...como br
        Result := True;

     Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;
     Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
     Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
     Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
     Registro_Fechas.Fecha_Pago        := Reg_Val_In.dFechaPago;
     // Cambio la fecha de Calculo si Corresponde
     if Reg_Val_In.Considera_Devengamiento_Formula <> 'NO' then
     begin
        Cambio_fecha_Devengamiento( Reg_Val_In,
                                    Reg_Formula_PAR,
                                    Reg_Formula_TIR,
                                    Registro_Fechas,
                                    Modulo_Err,
                                    String_Err,
                                    bResult_Devengamiento
                                );
        if Not bResult_Devengamiento then
        begin
            Result := bResult_Devengamiento;
            Exit;
        end;
     end;

     // Para Cambiar nemotécnico de letras
     if ((Reg_Val_Out.RegDes.Tasa_Flotante = 'S') and (NOT Reg_Descriptor.bSin_Tasa_en_Flujos)) or
        ((Reg_Val_Out.RegDes.Variacion_Cambiaria) and (NOT (Reg_Val_In.sValor_Cupon_Original = 'S'))) then
        if (Reg_Val_Out.RegDes.Fecha_Carga_Array_Mem <> Reg_Val_In.dFechaCalculo) then
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO'
        else
           if VarCamb_Depende_de_Operacion_Mem( Reg_Val_In.sEmisor                  // 09-11-2015 Se agrega para que cuando la tabla de desarrollo depende de la fechga de la operacion la cargue siempre
                                               ,Reg_Val_In.sInstrumento
                                               ,Reg_Val_In.sSerie)  then
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO';


     if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
     begin
        Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                       ,Reg_Val_In.sEmisor
                       ,Reg_Val_In.sInstrumento
                       ,Reg_Val_In.sSerie
                       ,Reg_Val_In.Nemotecnico
                       ,Reg_Val_In.sTipoNominales
                       ,Reg_Val_Out.Nominales
                       ,Reg_Val_In.dTasaEmision
                       ,Reg_Val_In.dFechaEmision
                       ,Reg_Val_In.dFechaVencimiento
                       ,Reg_Val_In.dFechaCalculo
                       ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                       ,Reg_Val_In.Con_Cupon
                       ,Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_Out.RegDes
                       ,Registro_Fechas
                       ,sMetodo_Sin_Tasa_Referencia
                       ,Reg_Formula_PAR
                       ,Modulo_Err
                       ,String_Err
                       ,Result);
        if NOT Result then
           exit;

        Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
     end;

     Cambia_Nemotecnico(Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_In.dFechaCalculo//dFecha_Desde
                       ,Reg_Val_In.dFechaEmision  //dFecha_Emision
                       ,False     // True Lo cambio filigara porque el dia que corta ya no debe considerarlo
                       ,Reg_Val_Out.RegDes
                       ,Reg_Val_In.Nemotecnico
                       ,Modulo_Err
                       ,String_Err
                       ,Result);
     if Not Result then
        Exit;

     //Determino Consistencia entre Cupones Cortados y los Cupones que Faltan
     if Reg_Val_In.bIncluye_CC then
     begin
// Se debe obtener el cupon cortado a la fecha de compra para obtener los cupones vigentes a esta fecha, FI - ES 06-05-2008
        Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                      Reg_Val_Out.RegDes,
                      Reg_Val_In.dFechaCompra,
                      False,
                      iCupon_Vigente,
                      Modulo_Err,
                      String_Err,
                      Result);
        if NOT Result then
           Exit;

        if Reg_Val_Out.RegDes.fCupones_Cortados > (Round(Reg_Val_Out.RegDes.NRO_CUPONES) - iCupon_Vigente) then
        begin
           Modulo_Err := 'Cupones cortados ';
           String_Err := ' Cupones Cortados Exceden a Cupones Futuros'
                         +' Nemotécnico '+Reg_Val_In.Nemotecnico;
           Result     :=  False;
           Exit;
        end;
        Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                      Reg_Val_Out.RegDes,
                      Reg_Val_In.dFechaCalculo,
                      False,
                      iCupon_Vigente,
                      Modulo_Err,
                      String_Err,
                      Result);
        if NOT Result then
           Exit;
     end;

     Reg_Val_In.Emision_Implicita  := 'N';

     if (Reg_Val_In.Valoriza_Par_Pte = 'TIR_VALUACION') then
         TIR_Valuacion( Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result)
     else
         Valuacion(Reg_Val_In
                  ,Reg_Val_Out
                  ,Modulo_Err
                  ,String_Err
                  ,Result);
     exit;
  end;

  //Determino que valores fueron ingresados para valorizar
  // y por lo tanto que debo hacer
  if (Reg_Val_In.Re_Llamado <> 'SI') and
     (Reg_Val_In.Re_Llamado <> EmptyStr) then
  begin
     Reg_Val_In.Re_Llamado := 'SI';
     Valorizacion( Reg_Val_In
                  ,Reg_Val_Out
                  ,Modulo_Err
                  ,String_Err
                  ,Result
                 );
      if (Reg_Val_In.Re_Llamado = 'SI') or (Not Result) then
         Exit;
  end;
  Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;
  Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
  Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
  Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
  Registro_Fechas.Fecha_Pago        := Reg_Val_In.dFechaPago;
  //ggarcia 09-05-2022
  Registro_Fechas.Fecha_Calculo_Original := Reg_Val_In.dFechaCalculoOriginal;

  Result := False;

  // Aca para el caso que se quiera forzar el uso de una formula
  // Como es en el caso de Valuacion
  // Se asigna sobre las formulas del Instrumento las que
  // vienen como parametros

  if Reg_Val_In.Forzar_Uso_Formula_PAR = 'SI' then
     Reg_Val_Out.RegDes.Cod_Calc_PAR_D := Reg_Val_In.Formula_PAR;

  if Reg_Val_In.Forzar_Uso_Formula_PTE = 'SI' then
     Reg_Val_Out.RegDes.Cod_Calc_TIR_D := Reg_Val_In.Formula_PTE;

  // Se dejan en memoria las formulas y sus parametros
  // para evitar relecturas a la Base de Datos

  //   if sValorizacion_Proceso = 'SI' then
   Datos_Moneda_Mem(  Reg_Val_In.sUnidadMonetaria
                     ,sTipo_UnidadMonetaria
                     ,sDescripcion_Moneda
                     ,sUnidad_Conversion
                    );
{   else
      Datos_Moneda(Reg_Val_In.sUnidadMonetaria
                  ,sTipo_UnidadMonetaria
                  ,sDescripcion_Moneda
                  ,sUnidad_Conversion);}


//   if sValorizacion_Proceso = 'SI' then
   carga_parametros_formulas_mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                ,Reg_Formula_PAR
                                ,Reg_Formula_TIR
                                ,Modulo_Err
                                ,String_Err
                                ,Result
                                );

    // Cambio la fecha de Calculo si Corresponde
     if Reg_Val_In.Considera_Devengamiento_Formula <> 'NO' then
     begin
        Cambio_fecha_Devengamiento( Reg_Val_In,
                                    Reg_Formula_PAR,
                                    Reg_Formula_TIR,
                                    Registro_Fechas,
                                    Modulo_Err,
                                    String_Err,
                                    bResult_Devengamiento
                                );
        if Not bResult_Devengamiento then
        begin
           Result := bResult_Devengamiento;
           Exit;
        end;
     end;

   // Hasta esta fecha si no podia cargar los parametros de la formula (es decir la formula no existia)
   // Se asumia que se trataba de un instrumento como Bono de Reconociiento o CORA
   // Como por el tema de la entrada en vigencia de la valorización a fecha de pago en Chile
   // Se hace necesario poner una formula valida en el descriptor de Bonos de Reconocimiento
   // para que siga funcionando como antes y se salta al else del if que esta a continuación de este parrafo
   // se agrega el OR instrumento es Bono de Rconocimiento
   // F.I. 16-11-2007


   if Result and
     (Reg_Val_In.Tipo_Instrumento <> 'B' )then   // si encontro formula ..... Y ADEMAS NO ES UN BR !!!!
   begin
     // Para el caso de instrumetos de Tasa Flotante e Instrumentos que son afectados
     // por la variacion cambiaría. La tabla tiene que ser cargada nuevamente si el
     // calculo se realiza a una fecha diferente de la carga anterior

     if ((Reg_Val_Out.RegDes.Tasa_Flotante = 'S') and (NOT Reg_Val_Out.RegDes.bSin_Tasa_en_Flujos)) or
        ((Reg_Val_Out.RegDes.Variacion_Cambiaria) and (NOT (Reg_Val_In.sValor_Cupon_Original = 'S'))) then
        if (Reg_Val_Out.RegDes.Fecha_Carga_Array_Mem <> Reg_Val_In.dFechaCalculo) then
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO'
        else
           if VarCamb_Depende_de_Operacion_Mem( Reg_Val_In.sEmisor                  // 09-11-2015 Se agrega para que cuando la tabla de desarrollo depende de la fechga de la operacion la cargue siempre
                                               ,Reg_Val_In.sInstrumento
                                               ,Reg_Val_In.sSerie)  then
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO';

     if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
     begin
        if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
           Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                          ,Reg_Val_In.sEmisor
                          ,Reg_Val_In.sInstrumento
                          ,Reg_Val_In.sSerie
                          ,Reg_Val_In.Nemotecnico
                          ,Reg_Val_In.sTipoNominales
                          ,Reg_Val_Out.Nominales
                          ,Reg_Val_In.dTasaEmision
                          ,Reg_Val_In.dFechaEmision
                          ,Reg_Val_In.dFechaVencimiento
                          ,Reg_Val_In.dFechaCalculo
                          ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                          ,Reg_Val_In.Con_Cupon
                          ,Reg_Val_Out.Array_Mem_Desarr
                          ,Reg_Val_Out.RegDes
                          ,Registro_Fechas
                          ,sMetodo_Sin_Tasa_Referencia
                          ,Reg_Formula_PAR
                          ,Modulo_Err
                          ,String_Err
                          ,Result)
        else
           Carga_TabDesarr_Vig(Reg_Val_In.Tipo_Instrumento
                              ,Reg_Val_In.sEmisor
                              ,Reg_Val_In.sInstrumento
                              ,Reg_Val_In.sSerie
                              ,Reg_Val_In.dFecha_Vig
                              ,Reg_Val_In.Nemotecnico
                              ,Reg_Val_In.sTipoNominales
                              ,Reg_Val_Out.Nominales
                              ,Reg_Val_In.dTasaEmision
                              ,Reg_Val_In.dFechaEmision
                              ,Reg_Val_In.dFechaVencimiento
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                              ,Reg_Val_In.Con_Cupon
                              ,Reg_Val_Out.Array_Mem_Desarr
                              ,Reg_Val_Out.RegDes
                              ,Registro_Fechas
                              ,sMetodo_Sin_Tasa_Referencia
                              ,Reg_Formula_PAR
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
     end
     else
     begin
        // ggarcia 12-09-2013 Si la tabla de desarrollo esta cargada, debe mover la fecha de vencimiento del ultimo cupon a la fecha de vencimiento final,
        //                    de lo contrario, mantendra la del nemotecnico y no considerara el dia de pago indicado en el descriptor.
        Reg_Val_In.dFechaVencimiento      := Reg_Val_Out.Array_Mem_Desarr[ROUND(Reg_Val_Out.RegDes.NRO_CUPONES)].Fecha_Vcto;
        Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
     end;
     if NOT Result then
        exit;
     Reg_Val_In.Tabla_Desarr_Cargada := 'SI';

     //Guardo Original Por si Acaso
     //Reg_Val_Out.Nemotecnico := Reg_Val_In.Nemotecnico; //18-01-2018 se debe guardar el original (caso mutual con asterisco que cambio)
     Reg_Val_Out.Nemotecnico := Reg_Val_In.Nemotecnico_Original;
     //analizo cambio de nemotecnico
     Cambia_Nemotecnico(Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_In.dFechaCalculo//dFecha_Desde
                       ,Reg_Val_In.dFechaEmision  //dFecha_Emision
                       ,True     // True Lo cambio filigara porque el dia que corta ya no debe considerarlo
                       ,Reg_Val_Out.RegDes
                       ,Reg_Val_In.Nemotecnico
                       ,Modulo_Err
                       ,String_Err
                       ,Result);
     if Not Result then
        Exit;

     //Determino Consistencia entre Cupones Cortados y los Cupones que Faltan
     if Reg_Val_In.bIncluye_CC then
     begin
// Se debe obtener el cupon cortado a la fecha de compra para obtener los cupones vigentes a esta fecha, FI - ES 06-05-2008
        Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                      Reg_Val_Out.RegDes,
                      Reg_Val_In.dFechaCompra,
                      False,
                      iCupon_Vigente,
                      Modulo_Err,
                      String_Err,
                      Result);
        if NOT Result then
           Exit;

        if Reg_Val_Out.RegDes.fCupones_Cortados > (Round(Reg_Val_Out.RegDes.NRO_CUPONES) - iCupon_Vigente) then
        begin
           Modulo_Err := 'Cupones cortados ';
           String_Err := ' Cupones Cortados Exceden a Cupones Futuros'
                         +' Nemotécnico '+Reg_Val_In.Nemotecnico;
           Result     :=  False;
           Exit;
        end;
        Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                      Reg_Val_Out.RegDes,
                      Reg_Val_In.dFechaCalculo,
                      False,
                      iCupon_Vigente,
                      Modulo_Err,
                      String_Err,
                      Result);
        if NOT Result then
           Exit;
     end;
{ Eliminado por DQ ya que fue comprobado en Peru que no correspondia (23/11/2004) By Filigara
     // Cuando se valoriza a fecha de emisión NO se debe considerar variacion cambiaria
     // Esto por que a la emisión el capital no esta reajustado
     if Reg_Val_In.dFechaCalculo = Reg_Val_In.dFechaEmision then
        Reg_Val_In.sValor_Cupon_Original := 'S';
}

     bCalcula_Valor_Par     := True; 
     Reg_Val_Out.Valor_Par_Base := 0;
     if ( (Reg_Formula_TIR.Valoriza_Sobre = 'PORCENPAR') OR
          (Reg_Val_In.Valoriza_Par_Pte = 'PAR')          OR
          (Reg_Val_In.Valoriza_Par_Pte = 'TIR')          OR
          (Reg_Val_In.Valoriza_Par_Pte = 'AMBOS')
         ) and
         ( bCalcula_Valor_Par )     then
     begin
        Valor_PAR(Reg_Formula_PAR
                 ,Reg_Formula_TIR
                 ,Reg_Val_In.Tipo_Instrumento
                 ,Reg_Val_Out.Array_Mem_Desarr
                 ,Reg_Val_In.Nemotecnico
                 ,Reg_Val_Out.RegDes
                 ,Reg_Val_Out.Nominales
                 ,Registro_Fechas
                 ,Reg_Val_In.Con_Cupon
                 ,Reg_Val_In.LLamado_Por
                 ,Reg_Val_In.sValor_Cupon_Original
                 ,Reg_Val_In.sComponentes_Descuento
                 ,Reg_Val_Out.Valor_Par_Base
                 ,Reg_Val_Out.Valor_Par_UM
                 ,Reg_Val_Out.Impuestos_Acc
                 ,Modulo_Err
                 ,String_Err
                 ,Result
                 );

        if NOT Result then
           exit;

     end;

          if (Reg_Val_In.Valoriza_Par_Pte = 'PTE') OR
             (Reg_Val_In.Valoriza_Par_Pte = 'AMBOS') then
             begin
               // Habilitado por F.I. para Penta Vida 25-08-2015
               bAcumula_Factor := (Reg_Formula_TIR.Valoriza_acumulado = 'S');

               Valor_PTE(Reg_Formula_PAR
                        ,Reg_Formula_TIR
                        ,Reg_Val_In.Tipo_Instrumento
                        ,Reg_Val_Out.Array_Mem_Desarr
                        ,Reg_Val_In.Nemotecnico
                        ,Reg_Val_Out.RegDes
                        ,Reg_Val_Out.TasaCalculo
                        ,Reg_Val_In.Spread
                        ,Registro_Fechas
                        ,Reg_Val_Out.Nominales
                        ,Reg_Val_Out.Valor_Par_Base
                        ,Reg_Val_Out.Valor_PAR_UM
                        ,Reg_Val_In.Con_Cupon
                        ,bAcumula_Factor   //False               //
                        ,''    // Este parametro solo se usa cuando es llamado por Calculo_TIR
                        ,Reg_Val_In.sValor_Cupon_Original
                        ,Reg_Val_In.sComponentes_Descuento
                        ,Reg_Val_In.Nominales_Compra
                        ,Reg_Val_In.ValorInvertidoUM_Compra
                        ,sOrigen
                        ,P_ValorPte
                        ,Reg_Val_Out.ValorInvertidoUM
                        ,Reg_Val_Out.PorcentajePar
                        ,Reg_Val_Out.Impuestos_Acc
                        ,Modulo_Err
                        ,String_Err
                        ,Result);

               if NOT Result then
                  exit;
             end;

            if (Reg_Val_In.Valoriza_Par_Pte = 'TIR') then
            begin
              if Reg_Val_Out.Valor_Par_UM = 0 then
                 Reg_Val_Out.PorcentajePar := 0
              else
                 Reg_Val_Out.PorcentajePar := Redondeo(Reg_Val_Out.ValorInvertidoUM /
                                                       Reg_Val_Out.Valor_Par_UM, 4) * 100;

              // Habilitado por F.I. para Penta Vida 25-08-2015
              bAcumula_Factor := (Reg_Formula_TIR.Valoriza_acumulado = 'S');

              Calculo_TIR(Reg_Formula_PAR
                         ,Reg_Formula_TIR
                         ,Reg_Val_In.Tipo_Instrumento
                         ,Reg_Val_Out.Array_Mem_Desarr
                         ,Reg_Val_In.Nemotecnico
                         ,Reg_Val_Out.RegDes
                         ,Registro_Fechas
                         ,Reg_Val_Out.Nominales
                         ,Reg_Val_Out.Valor_Par_Base
                         ,Reg_Val_Out.Valor_PAR_UM
                         ,Reg_Val_In.Con_Cupon
                         ,bAcumula_Factor //False                //
                         ,Reg_Val_In.sValor_Cupon_Original
                         ,Reg_Val_In.sComponentes_Descuento
                         ,sOrigen
                         ,Reg_Val_Out.TasaCalculo
                         ,Reg_Val_Out.TIR_Desarr
                         ,P_ValorPte
                         ,Reg_Val_Out.ValorInvertidoUM
                         ,Reg_Val_Out.PorcentajePar
                         ,Modulo_Err
                         ,String_Err
                         ,Result);

               if NOT Result then
                  exit;
            end;

        // Asume que valores UM no incluyen Reajuste
        // Debe verificarse posteriormrnte el caso de la
        // Excepcion Variación Cambiaria
        Reg_Val_Out.Valor_Par_UM_Sin_Reajuste := Reg_Val_Out.Valor_Par_UM;

        //ggarcia 01-2012 debe redondear a los decimales del descriptor, campo utilizado en funcion Intereses_Acumulados
        if Reg_Val_In.Tipo_Instrumento <> 'U' then //ggarcia 20-11-2013 
        begin
           if (Transaccion_Implica(Reg_Val_In.Nemotecnico,'REDOND_INT'))  or
              (Transaccion_Implica(Reg_Val_In.sInstrumento,'REDOND_INT')) or
              (Transaccion_Implica('GENERAL','REDOND_INT'))               then
              Reg_Val_Out.Valor_Par_UM_Sin_Reajuste  := Redondeo(Reg_Val_Out.Valor_Par_UM_Sin_Reajuste, Trunc(Reg_Val_Out.RegDes.Decimal_Ajuste));
        end;

        // Busco si hay proyección de precios para gestion para encontrar último
        // día hábil, se usa en el caso de la rentabilidad porque no hay valor de
        // cambio los fines de semana

        // Se vuelve a habilitar con fecha 22-11-2006
        // Se pasa como tipo de proceso la moneda de oriogen
        // de esta manera se puede indicar para cuales monedas proyectar
        // Visto para la SVS (Para Dolar proyecta para UF NO)

        dFecha_Calculo := Reg_Val_In.dFechaCalculo;
        //Busca_Proy_Precio_Mem(Reg_Val_In.Tipo_Proceso,
        Busca_Proy_Precio_Mem(Reg_Val_In.sUnidadMonetaria,
                              fCantidad,
                              sUnidad,
                              sAntes_Despues,
                              bBusca_Proy_Precios
                              );
        if bBusca_Proy_Precios then
        begin
          if sValorizacion_Proceso = 'SI' then
             Pais_MonInd_Mem(Reg_Val_In.sMoneda_Conversion
                            ,sPais_Tasa
                            ,Modulo_Err
                            ,String_Err
                            ,Result)
          else
             Pais_MonInd(Reg_Val_In.sMoneda_Conversion
                        ,sPais_Tasa
                        ,Modulo_Err
                        ,String_Err
                        ,Result);
          if Not Result then
             Exit;

          if sAntes_Despues = 'A' then
             dFecha_Calculo := dia_habil_antes_despues( sPais_Tasa
                                                       ,dFecha_Calculo
                                                       ,'-')
          else
             dFecha_Calculo := dia_habil_antes_despues( sPais_Tasa
                                                       ,dFecha_Calculo
                                                       ,'+');
        end;

        // Aplica Factor de Correccion Segun Formula
        // Agregar pregunta si sValor_Cupon_Original = 'S' NO LO HACE

// CJF ***
     //   if Reg_Formula_PAR.Aplica_Factor_Correccion = 'S' then
        {
        if (Reg_Formula_PAR.Aplica_Factor_Correccion = 'S') and
           (not (Reg_Val_In.sValor_Cupon_Original = 'S'))  then
        begin
            Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                          Reg_Val_Out.RegDes,
                          Reg_Val_In.dFechaCalculo,
                          True,
                          iCupon_Vigente,
                          Modulo_Err,
                          String_Err,
                          Result);
            if NOT Result then
               Exit;

           Registro_fechas.Fecha_Inic_Periodo := Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto_Anterior;
           Registro_fechas.Fecha_Vcto_Periodo := Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto;
           Calcula_Variacion_Cambiaria( Reg_Formula_PAR.Mon_Ind_Correccion
                                       ,Reg_Formula_PAR.Fecha_Desde_Corr
                                       ,Reg_Formula_PAR.Fecha_Hasta_Corr
                                       ,Registro_Fechas
                                       ,fFactor_Correccion
                                       ,dFecha_Inicio
                                       ,dFecha_Termino
                                       ,fValor_Ind_Inicio
                                       ,fValor_Ind_Termino
                                       ,Modulo_Err
                                       ,String_Err
                                       ,Result);
           if NOT Result then
              Exit;

           Reg_Val_Out.Valor_Par_UM := Reg_Val_Out.Valor_Par_UM * fFactor_Correccion;
        end;
        if (Reg_Formula_TIR.Aplica_Factor_Correccion = 'S') and
           (NOT (Reg_Val_In.sValor_Cupon_Original = 'S'))  then
        begin
           Calcula_Variacion_Cambiaria( Reg_Formula_TIR.Mon_Ind_Correccion
                                       ,Reg_Formula_TIR.Fecha_Desde_Corr
                                       ,Reg_Formula_TIR.Fecha_Hasta_Corr
                                       ,Registro_Fechas
                                       ,fFactor_Correccion
                                       ,dFecha_Inicio
                                       ,dFecha_Termino
                                       ,fValor_Ind_Inicio
                                       ,fValor_Ind_Termino
                                       ,Modulo_Err
                                       ,String_Err
                                       ,Result);
           if NOT Result then
              Exit;

           Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM * fFactor_Correccion;
        end;
        }
        // Indica que debe utilizar el valor ingresado en precio de la OMD
        if (Reg_Formula_TIR.Cod_Utiliza_Precio = 'PRECIO') AND
           (Reg_Val_In.dFechaCalculo = Reg_Val_In.dFechaOperacion) then
        begin
           Reg_Val_Out.PorcentajePar    := fPorcentaje_Precio;
           Reg_Val_Out.Valor_Par_UM     := Reg_Val_Out.Nominales;
           Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.Nominales * fPorcentaje_Precio;
           Reg_Val_Out.Valor_Par_MC     := Reg_Val_Out.Nominales * fPorcentaje_Precio;
           Reg_Val_Out.ValorInvertidoMC := Reg_Val_Out.Nominales * fPorcentaje_Precio;
        end
        else
        begin
          // Nuevo Redondeo de valores UM dependiendo de la formula
          // se implemento debido a que se detecto un descuadre con bolsa para los
          // DPF ... Filigara 05-12-2005

          if Reg_Formula_TIR.Aplica_Redondeo_UM = 'S' then
          begin
            // Solo debe redondear los valores en UM cuando no son inidices
            Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,
                                                                Reg_Val_In.dFechaCalculo,
                                                                Reg_Val_Out.ValorInvertidoUM);

            Reg_Val_Out.Valor_Par_UM := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,
                                                            Reg_Val_In.dFechaCalculo,
                                                            Reg_Val_Out.Valor_Par_UM);

            Reg_Val_Out.Valor_Par_UM_Sin_Reajuste :=
                                        Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,
                                                            Reg_Val_In.dFechaCalculo,
                                                            Reg_Val_Out.Valor_Par_UM_Sin_Reajuste);

          end;

          {Se habilita el 22-11-2006 (para la SVS) ES & FI}
          if bBusca_Proy_Precios then
           begin
              dFecha_Tope       := Reg_Val_In.dFechaCalculo;
              dFecha_TipoCambio := Reg_Val_In.dFechaCalculo;
              // Corregido por ES & FI 28-03-2008
              lee_proy_Fecha_Tope(  Reg_Val_In.sUnidadMonetaria // Reg_Val_In.Tipo_Proceso
                                   ,Reg_Val_In.dFechaCalculo
                                   ,dFecha_Tope
                                   ,sAntes_Despues
                                   ,bFecha_Tope
                                );
              if bFecha_Tope then
              begin
                 while True do
                 begin
                    Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                                         ,Reg_Val_In.sMoneda_Conversion
                                         ,'BC'
                                         ,dFecha_TipoCambio
                                         ,Reg_Val_Out.Valor_Par_UM
                                         ,Reg_Val_Out.Valor_Par_MC
                                         ,Modulo_Err
                                         ,String_Err
                                         ,Result);

                    if Result then
                    begin
                       Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                                            ,Reg_Val_In.sMoneda_Conversion
                                            ,'BC'
                                            ,dFecha_TipoCambio
                                            ,Reg_Val_Out.ValorInvertidoUM
                                            ,Reg_Val_Out.ValorInvertidoMC
                                            ,Modulo_Err
                                            ,String_Err
                                            ,Result);
                       if Result then
                          Break;
                    end;

                    if sAntes_Despues = 'A' then
                    begin
                       dFecha_TipoCambio := dFecha_TipoCambio - 1;
                       if dFecha_TipoCambio = (dFecha_Tope - 1 ) then
                          break;
                    end
                    else
                    begin
                       dFecha_TipoCambio := dFecha_TipoCambio + 1;
                       if dFecha_TipoCambio = (dFecha_Tope + 1 ) then
                          break;
                    end;
                 end;
              end
              else
              begin
                 Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                                      ,Reg_Val_In.sMoneda_Conversion
                                      ,'BC'
                                      ,dFecha_Calculo  //Reg_Val_In.dFechaCalculo
                                      ,Reg_Val_Out.Valor_Par_UM
                                      ,Reg_Val_Out.Valor_Par_MC
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);
                 if NOT Result then
                    exit;

                 Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                                      ,Reg_Val_In.sMoneda_Conversion
                                      ,'BC'
                                      ,dFecha_Calculo  //Reg_Val_In.dFechaCalculo
                                      ,Reg_Val_Out.ValorInvertidoUM
                                      ,Reg_Val_Out.ValorInvertidoMC
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);
                 if NOT Result then
                    Exit;
              end;
           end
           else
           begin
           //}
              //GGARCIA 19-01-2012
              if (sTipo_UnidadMonetaria = 'I') and (Reg_Val_Out.Tipo_Tasa_Precio = '') then
              begin
                 Conversion_unidad_mon_con_tipo(Reg_Val_In.sUnidadMonetaria
                                               ,Reg_Val_In.sMoneda_Conversion
                                               ,'BC'
                                               ,dFecha_Calculo  //Reg_Val_In.dFechaCalculo
                                               ,Reg_Val_Out.Valor_Par_UM
                                               ,Reg_Val_Out.Valor_Par_MC
                                               ,sTipo_TasPre
                                               ,Modulo_Err
                                               ,String_Err
                                               ,Result);
                 if NOT Result then
                    exit;

                 Conversion_unidad_mon_con_tipo(Reg_Val_In.sUnidadMonetaria
                                               ,Reg_Val_In.sMoneda_Conversion
                                               ,'BC'
                                               ,dFecha_Calculo  //Reg_Val_In.dFechaCalculo
                                               ,Reg_Val_Out.ValorInvertidoUM
                                               ,Reg_Val_Out.ValorInvertidoMC
                                               ,sTipo_TasPre
                                               ,Modulo_Err
                                               ,String_Err
                                               ,Result);
                 if NOT Result then
                    Exit;

                 if sTipo_TasPre <> '' then
                    Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;
              end
              else
              begin
                 Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                                      ,Reg_Val_In.sMoneda_Conversion
                                      ,'BC'
                                      ,dFecha_Calculo  //Reg_Val_In.dFechaCalculo
                                      ,Reg_Val_Out.Valor_Par_UM
                                      ,Reg_Val_Out.Valor_Par_MC
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);
                 if NOT Result then
                    exit;

                 Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                                      ,Reg_Val_In.sMoneda_Conversion
                                      ,'BC'
                                      ,dFecha_Calculo  //Reg_Val_In.dFechaCalculo
                                      ,Reg_Val_Out.ValorInvertidoUM
                                      ,Reg_Val_Out.ValorInvertidoMC
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);
                 if NOT Result then
                    Exit;
              end;
           end;
        end;
   end
   else  // Casos Antiguos
   begin
//     Result := True;
     if Reg_Val_In.Tipo_Instrumento = 'B' then
     begin
       // Desde 06-12-2007 Si es BR y no encontro formula es ERROR !!!! CJ & FI
       // Para tema de Valorizacion a Fecha de Pago, a partir del 06-12-2007, los BR tienen que tener una
       // formula Válida 01-04-2009
       if NOT Result then
          exit;
       Decodifica_Nemotecnico_Br(Reg_Val_In.Nemotecnico,
                                 sTipoBono,
                                 Reg_Val_In.dFechaEmision,
                                 Reg_Val_In.dFechaVencimiento,
                                 Modulo_Err,
                                 String_Err,
                                 Result);

       if NOT Result then
       begin
            String_Err := 'Error en codificación de BR: '
                          +Reg_Val_In.Nemotecnico;
            Result := False;
            exit;
       end;

        String_err := '';
        if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
           if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
              Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                             ,Reg_Val_In.sEmisor
                             ,Reg_Val_In.sInstrumento
                             ,Reg_Val_In.sSerie
                             ,Reg_Val_In.Nemotecnico
                             ,Reg_Val_In.sTipoNominales
                             ,Reg_Val_Out.Nominales
                             ,Reg_Val_In.dTasaEmision
                             ,Reg_Val_In.dFechaEmision
                             ,Reg_Val_In.dFechaVencimiento
                             ,Reg_Val_In.dFechaCalculo
                             ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                             ,Reg_Val_In.Con_Cupon
                             ,Reg_Val_Out.Array_Mem_Desarr
                             ,Reg_Val_Out.RegDes
                             ,Registro_Fechas
                             ,sMetodo_Sin_Tasa_Referencia
                             ,Reg_Formula_PAR
                             ,Modulo_Err
                             ,String_Err
                             ,Result)
           else
              Carga_TabDesarr_Vig(Reg_Val_In.Tipo_Instrumento
                                 ,Reg_Val_In.sEmisor
                                 ,Reg_Val_In.sInstrumento
                                 ,Reg_Val_In.sSerie
                                 ,Reg_Val_In.dFecha_Vig
                                 ,Reg_Val_In.Nemotecnico
                                 ,Reg_Val_In.sTipoNominales
                                 ,Reg_Val_Out.Nominales
                                 ,Reg_Val_In.dTasaEmision
                                 ,Reg_Val_In.dFechaEmision
                                 ,Reg_Val_In.dFechaVencimiento
                                 ,Reg_Val_In.dFechaCalculo
                                 ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                                 ,Reg_Val_In.Con_Cupon
                                 ,Reg_Val_Out.Array_Mem_Desarr
                                 ,Reg_Val_Out.RegDes
                                 ,Registro_Fechas
                                 ,sMetodo_Sin_Tasa_Referencia
                                 ,Reg_Formula_PAR
                                 ,Modulo_Err
                                 ,String_Err
                                 ,Result);
           if NOT Result then
              exit;

      // Verifico si hay Margen para rescatar tasa
       Parametros_Margen_Mem( Reg_Val_Out.RegDes.COD_CALC_TIR_D
                             ,Reg_Val_In.dFechaCalculo
                             ,RegParamMargen
                             ,bExiste_Margen
                            );
       if bExiste_Margen then
       begin
          // Nuevo agregado para poder utilizar margenes con Spread en los BR's. (La Chilena)
          // 10/01/2007 F.I.

          Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;
          Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
          Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
          Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
          Registro_Fechas.Fecha_Pago        := Reg_Val_In.dFechaPago;
          Registro_Fechas.Fecha_Parametro   := RegParamMargen.Fecha_Desde;;

        Calcula_Tasa_Descuento( RegParamMargen
                                 ,Reg_Val_In.Tipo_Instrumento
                                 ,Reg_Val_Out.Array_Mem_Desarr
                                 ,Reg_Val_In.Nemotecnico
                                 ,Reg_Val_Out.RegDes
                                 ,Registro_Fechas
                                 ,Reg_Val_In.Nominales_Compra
                                 ,True
                                 ,0
                                 ,Reg_Val_Out.TasaCalculo   // 10-09-2019 Reg_Val_In.Tasa_Compra
                                 ,Reg_Val_In.Spread
                                 ,sOrigen
                                 ,sTipo_Valuac   //ggarcia 22-05-2013 para leer tasa mercado BR
                                 ,Modulo_Err
                                 ,String_Err
                                 ,Result);
           if NOT Result then
              exit;

          fTasaCalculoBR := Reg_Val_Out.Array_Mem_Desarr[1].Tasa_de_Descuento;

          // Ojo esto lo deje aqui porque al parecer lom usa Ohio F.I. 10-01-2007
//          E.S. 26-09-2019, para evitar que tome otra tasa (caso Spread BICEVIDA), OHIO soluciona
//                           este problema pq va a buscar la tasa en Calcula_Tasa_Descuento
//          if fTasaCalculoBR = 0 then
//             fTasaCalculoBR := Leer_Tasa_Instrumento(  'BR'
//                                                    //,Reg_Val_In.dFechaCalculo
//                                                    ,RegParamMargen.Fecha_Desde
//                                                    ,Reg_Val_In.dFechaVencimiento
//                                                    ,sOrigen
//                                                    ,sTipo_TasPre);
//          if fTasaCalculoBR <> 0 then
//          begin
             Reg_Val_Out.TasaCalculo         := fTasaCalculoBR;
             Reg_Val_Out.Rate_Used_Valuacion := fTasaCalculoBR;
             Reg_Val_Out.Tipo_Tasa_Precio    := sTipo_TasPre;
//          end;
       end;

       Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;
       ValorizaBonoReco(Reg_Val_In.Nemotecnico,
                        Reg_Val_In.dFechaCalculo,
                        Reg_Val_In.Valoriza_Par_Pte,
                        Reg_Val_Out.Nominales,
                        Reg_Val_Out.TasaCalculo,
                        Reg_Val_Out.PorcentajePar,
                        Reg_Val_Out.ValorInvertidoUM,
                        Reg_Val_Out.Valor_Par_UM,
                        Reg_Val_Out.Valor_Par_MC,
                        Reg_Val_Out.fValor_Final_UM,
                        Modulo_Err,
                        String_Err,
                        Result
                        );
       if Not Result then
          exit;

       // La siguiente linea es para poder utilizar los valores sin reajuste
       // en la contabilizacion GAAP
       Reg_Val_Out.Valor_Par_UM_Sin_Reajuste := Reg_Val_Out.Valor_Par_UM;
       Reg_Val_Out.Valor_Par_UM     :=  Reg_Val_Out.Valor_Par_MC;
       Reg_Val_Out.ValorInvertidoMC := Reg_Val_Out.ValorInvertidoUM;

       // Se agrega para poder llevar los valores de los BR a la moneda de conversion
       // si esta es diferente. Esto porque la rutina de los BR asume Pesos y devuelve
       // siempre en pesos.

       if Reg_Val_In.sUnidadMonetaria <> Reg_Val_In.sMoneda_Conversion then
       begin
         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sMoneda_Conversion
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
         if NOT Result then
            exit;
       end;
     end
     else if Reg_Val_In.sInstrumento = 'CORA' then
     begin
          String_err := '';
          // Si estamos Valorizando debemos tomar
          //la fecha de emisión y vencimiento de la Omd
          // de lo contrario queda tal cual, como en el interactivo o en la trnsacción
          CALCULO_PTE_CORA(Reg_Val_In.sEmisor,
                           Reg_Val_In.sinstrumento,
                           Reg_Val_In.sserie,
                           Reg_Val_In.dFechaCalculo,
                           Reg_Val_In.dFechaEmision,
                           Reg_Val_In.dFechaVencimiento,
                           Reg_Val_Out.RegDes.Tasa_Valor_PAR,
                           Round(Reg_Val_Out.RegDes.NRO_CUPONES),
                           Reg_Val_Out.Nominales,
                           Reg_Val_Out.RegDes.Tasa_Emision,
                           Reg_Val_Out.TasaCalculo,
                           0,//  Ipc_emision, VALORES Obtenidos dentro de rutina de cálculo
                           0,//  Ipc_Calculo
                           Round(Reg_Val_Out.RegDes.BASE_CONVERSION),
                           Reg_Val_Out.Valor_Par_Base,
                           Reg_Val_Out.Valor_Par_UM,
                           Reg_Val_Out.PorcentajePar,
                           Reg_Val_Out.ValorInvertidoMC,
                           Modulo_err,
                           String_err,
                           Result
                        );
         if Not Result then
            Exit;

         Reg_Val_Out.Valor_Par_MC     := Reg_Val_Out.Valor_Par_UM;
         Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;

         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sMoneda_Conversion
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
          if NOT Result then
             exit;

          end
     else if Reg_Val_In.sInstrumento = 'OMD_PACTO' then
     begin
         String_err := '';
         if Reg_Val_In.Tipo_Instrumento = 'R' then
            Calculo_Pactos_RV(Reg_Val_Out.Valor_Par_UM,
                              Reg_Val_Out.Valor_Par_MC,
                              Reg_Val_Out.TasaCalculo,
                              Reg_Val_In.sUnidadMonetaria,
                              Reg_Val_In.Tipo_Proceso,
                              Reg_Val_In.sMoneda_Conversion,
                              Reg_Val_In.Tasa_Base_Pacto,
                              Reg_Val_In.dFechaCalculo ,
                              Reg_Val_In.dFechaVencimiento,
                              Reg_Val_In.dFechaOperacion,//Para Calculo de Dias
                              Reg_Val_Out.ValorInvertidoUM,
                              Reg_Val_Out.ValorInvertidoMC,
                              Modulo_Err,
                              String_Err,
                              Result)
         else
            Calculo_Pactos(  Reg_Val_Out.Valor_Par_UM,
                             Reg_Val_Out.Valor_Par_MC,
                             Reg_Val_Out.TasaCalculo,
                             Reg_Val_In.sUnidadMonetaria,
                             Reg_Val_In.Tipo_Proceso,
                             Reg_Val_In.sMoneda_Conversion,
                             Reg_Val_In.Tasa_Base_Pacto,
                             Reg_Val_In.dFechaCalculo ,
                             Reg_Val_In.dFechaVencimiento,
                             Reg_Val_In.dFechaOperacion,//Para Calculo de Dias
                             Reg_Val_Out.ValorInvertidoUM,
                             Reg_Val_Out.ValorInvertidoMC,
                             Modulo_Err,
                             String_Err,
                             Result);
        if Not Result then
           Exit;
     end
     else //if Reg_Val_In.sInstrumento = 'FWD' then     DC y FI 09/10/2015
     if ( BuscaStr(Reg_Val_In.sInstrumento,'FW-')) then
     begin
         String_err := '';
         Calculo_Forward( Reg_Val_In.sinstrumento,
                          sTipo_Valuac,
                          Reg_Val_Out.Valor_Par_UM,
                          Reg_Val_In.sUnidadMonetaria,
                          Reg_Val_In.sMoneda_Conversion,
                          Reg_Val_In.dFechaCalculo ,
                          Reg_Val_In.dFechaVencimiento,
                          sOrigen,
                          Reg_Val_Out.Tipo_Cambio,
                          Reg_Val_Out.FX_Points,
                          Reg_Val_Out.Tipo_Cambio_fwd,
                          Reg_Val_Out.ValorInvertidoUM,
                          Modulo_Err,
                          String_Err,
                          Result);
        if Not Result then
           Exit;
     end
     else
     begin
       Modulo_Err := 'Valoriza General';
       String_Err := 'Casos especiales sin formula. Instrumento '''+Reg_Val_In.sInstrumento+''' no es valido';
       Result := False;
       exit;
     end;
   end;


   if sValorizacion_Proceso = 'SI' then
   begin
      if sTipo_UnidadMonetaria <> 'I' then
      begin
        // Solo debe redondear los valores en UM cuando no son inidices
        Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,
                                                            Reg_Val_In.dFechaCalculo,
                                                            Reg_Val_Out.ValorInvertidoUM);

        Reg_Val_Out.Valor_Par_UM := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,
                                                        Reg_Val_In.dFechaCalculo,
                                                        Reg_Val_Out.Valor_Par_UM);

        Reg_Val_Out.Valor_Par_UM_Sin_Reajuste :=
                                    Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,
                                                        Reg_Val_In.dFechaCalculo,
                                                        Reg_Val_Out.Valor_Par_UM_Sin_Reajuste);

      end;
      Reg_Val_Out.fValor_Final_UM  := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,
                                                          Reg_Val_In.dFechaCalculo,
                                                          Reg_Val_Out.fValor_Final_UM);

      Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda_Mem(Reg_Val_In.sMoneda_Conversion,
                                                          Reg_Val_In.dFechaCalculo,
                                                          Reg_Val_Out.ValorInvertidoMC);

      Reg_Val_Out.Valor_Par_MC := Redondeo_Moneda_Mem(Reg_Val_In.sMoneda_Conversion,
                                                      Reg_Val_In.dFechaCalculo,
                                                      Reg_Val_Out.Valor_Par_MC);

   end
   else
   begin
      if sTipo_UnidadMonetaria <> 'I' then
      begin
        // Solo debe redondear los valores en UM cuando no son inidices
        Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
                                                        Reg_Val_In.dFechaCalculo,
                                                        Reg_Val_Out.ValorInvertidoUM);

        Reg_Val_Out.Valor_Par_UM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
                                                    Reg_Val_In.dFechaCalculo,
                                                    Reg_Val_Out.Valor_Par_UM);

        Reg_Val_Out.Valor_Par_UM_Sin_Reajuste :=
                                    Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
                                                    Reg_Val_In.dFechaCalculo,
                                                    Reg_Val_Out.Valor_Par_UM_Sin_Reajuste);

      end;
      Reg_Val_Out.fValor_Final_UM  := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
                                                      Reg_Val_In.dFechaCalculo,
                                                      Reg_Val_Out.fValor_Final_UM);

      Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,
                                                      Reg_Val_In.dFechaCalculo,
                                                      Reg_Val_Out.ValorInvertidoMC);

      Reg_Val_Out.Valor_Par_MC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,
                                                  Reg_Val_In.dFechaCalculo,
                                                  Reg_Val_Out.Valor_Par_MC)
   end;
end;
//---------------------------------------------------------------------------
Procedure ValorizaBonoReco(sNemotecnico    : String;
                           dFechaCalculo   : TDateTime;
                           sTipo_Calculo   : String;
                       var fNominales      : Double;
                       var fTasaCalculo    : Double;
                       var fPrecio         : Double;
                       var fValorInversion : Double;
                       var fValor_PAR_UM   : Double;
                       var fValor_Par      : Double;
                       var fValor_Final    : Double;
                       var Modulo_Err      : String;
                       var String_Err      : String;
                       var Result          : Boolean);

var
sTipoBono            : String;
dFechaEmision,
dFechaVencimiento    : TDateTime;
//dFecha_Ultimo_Vcto   : TDateTime;
fTasaCapitalizacion  : Double;

begin
  Modulo_Err := 'Valorizacion General (Valoriza BR)';
  Result     := True;

//Verificar nemotecnico valido
  Decodifica_Nemotecnico_Br(sNemotecnico,
                            sTipoBono,
                            dFechaEmision,
                            dFechaVencimiento,
                            Modulo_Err,
                            String_Err,
                            Result);

if NOT Result then
   begin
       // String_Err := 'Error en codificación de BR: '
       //              +sNemotecnico;
       Result := False;
       exit;
   end;

  if sTipoBono = 'B' then
     fTasaCapitalizacion := 4
  else
     fTasaCapitalizacion := 0;

  if dFechaEmision > dFechaVencimiento then
     begin
       String_Err := 'Fecha Emisión es mayor que Fecha Vencimiento BR: '
                      +sNemotecnico;
       Result := False;
       exit;
     end;

  if (dFechaCalculo < dFechaEmision) OR
     (dFechaCalculo > dFechaVencimiento) then
     begin
       String_Err := 'Calculo fuera de vigencia del instrumento BR: '
                      +sNemotecnico;
       Result := False;
       exit;
     end;

{  if (fTasaCalculo = 0) and
     (fValorInversion = 0) then
      begin
{
        String_Err := 'Error en parametros para valorización BR: '
                      +sNemotecnico;
        Result := False;
}
 {       exit;
      end;}

  if sTipo_Calculo = 'TIR' then
     Calculo_TIR_BR(dFechaEmision,
                    dFechaVencimiento,
                    dFechaCalculo,
                    fNominales,
                    fTasaCalculo,
                    fValorInversion,
                    fTasaCapitalizacion,
                    fPrecio,
                    fValor_PAR,
                    fValor_Final,
                    fValorInversion,
                    fTasaCalculo,
                    Modulo_Err,
                    String_err,
                    Result)
  else
    begin
      fPrecio      := 0;
      fValor_Par   := 0;
      fValor_Final := 0;
      Calculo_BR(dFechaEmision,
                 dFechaVencimiento,
                 dFechaCalculo,
                 fNominales,
                 fTasaCalculo,
                 fValorInversion,
                 fTasaCapitalizacion,
                 fPrecio,
                 fValor_PAR_UM,
                 fValor_PAR,
                 fValor_Final,
                 fValorInversion,
                 fTasaCalculo,
                 Modulo_Err,
                 String_err,
                 Result);
    end;

   if not Result then
      begin
        Result := False;
        exit;
      end;

   fTasaCalculo := Redondeo(fTasaCalculo,4);
end;
//---------------------------------------------------------------------------
procedure Valuacion(var Reg_Val_In      : TRegistro_Valoriza_In;
                    var Reg_Val_Out : TRegistro_Valoriza_Out;
                    var Modulo_Err  : String;
                    var String_Err  : String;
                    var Result      : Boolean);
var
  sTipo_Valuac   : String;
  sFormula_Pte   : String;
  fBase_Precio   : Double;
  sMon_Ind       : String;
// Para poder retornar el origen 09-05-2024 F.I.
//  sOrigen        : String;  --> Ahora usamos Reg_val_out.Origen
  sTasa_Base     : string;
  sCodigo_Formula: string;

  fValor         : Double;
  sTipo_TasPre   : String;
  Registro_Fechas             : TRegistro_Fechas;
  sMetodo_Sin_Tasa_Referencia : String;
  fSaldo_Insoluto             : Double;
  fSaldo_Insoluto_Cpa         : Double;
  fSaldo_Insoluto_Cpa_ConRea  : Double;
  dFecha_Desde                : TDateTime;
  fInteres_Acum_UM            : Double;
  fInteres_Acum_MC            : Double;
  iCupon_Vigente,
  i                           : Integer;
  iNro_Cupon                  : Integer;
  fInteres_Acum_UM_REAJUSTADO : Double;
  //fCorMon,
  //fValor_Original        : Double;
  Parametros_Formula     : TRegFormulaPAR;
  fReajuste_Indexado          : Double;
  fReajuste_NO_Indexado       : Double;
  fAjuste_Reajuste_Indexado   : Double;
  fSaldo_Insoluto_Sin_Rea     : Double;
  fReajuste_Capital           : Double;

  fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste : Double;
  fSaldo_Insoluto_Sin_Capitalizacion              : Double;

  fValor_Compra_Clean_UM      : Double;
  fValor_Clean_UM_Rea         : Double;
  dFecha_Calculo              : Double;
  sTipo_Reajuste              : String;
  sAux_Moneda_Conversion      : String;
  Aux_Fecha_Pago              : TdateTime;
  bResultTasa                 : Boolean;
  bExiste_Precio_Mdo          : Boolean;
  bAcumula_Factor             : Boolean;

  iBaseTasa                   : Integer;
  sTipoInteres                : String;
  iBaseMensual                : Integer;
  sTipoCalculoDias            : String;
  iVigenciaValor              : Integer;
  iVigenciaMeses              : Integer;
  sPais_Tasa                  : String;
  fDif_Dias                   : Double;
  iAnosEnteros                : Double;
  iAnosFraccion               : Double;
  iMesesEnteros               : Double;
  fDif_Precio                 : Double;
  fIncrease_Decrease_Total    : Double;

  fAux_Valor_Invertido_UM     : Double;
  P_ValorPte                  : Double;


  // Variables necesarias para la obtenciónde las amortizaciones y capitalizaciones del periodo
  fMonto_Amort_a_la_CPA_UM ,fMonto_Amort_a_la_CPA_MC,
  fReajuste_Indexado_Amort_a_la_CPA ,fReajuste_No_Indexado_Amort_a_la_CPA ,fMonto_Amort_Pagado_UM,
  fMonto_Amort_Pagado_MC ,fReajuste_Indexado_Amort_Pagado ,fReajuste_No_Indexado_Amort_Pagado,
  fMonto_Capitalizado_UM, fMonto_Capitalizado_MC ,fReajuste_Indexado_Capitalizado,
  fReajuste_No_Indexado_Capitalizado, fDiferencia_TC_Amort_Cupon ,fDiferencia_TC_Amort_Cupon_Pagado,
  fDiferencia_TC_Capit_Cupon, fProporcion_ActualCost_SalInsol,fMonto_Amort_Actual_Cost_A_CPA_UM,
  fMonto_Amort_Actual_Cost_A_CPA_MC, fReajuste_Indexado_Actual_Cost_A_CPA, fReajuste_No_Indexado_Actual_Cost_A_CPA,
  fDiferencia_TC_Actual_Cost_A_CPA : Double;

  fCapitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado : Double;

  // Variables para la funcion reajuste
  sCod_Indice_Reajuste : String;
  fReajuste_Index_Acumulado, fReajuste_NoIndex_Acumulado_UM,
  fReajuste_NoIndex_Acumulado, fDiferencia_tipo_cambio : Double;

  fReajuste_Index_Acumulado_Saldo_Insoluto              : Double;
  fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM         : Double;
  fReajuste_NoIndex_Acumulado_Saldo_Insoluto            : Double;
  fDiferencia_tipo_cambio_Saldo_Insoluto                : Double;

  Reg_Formula_PAR : TRegFormulaPAR;
  Reg_Formula_TIR : TRegFormulaTIR;
  fTasa_Cupon     : Double;

  sTasa_Base_Aux  : string;

  dFecha_Tasa             : TDateTime;

  fAux_Posicion_Corta     : Double;

  fValor_Pte_MC        : Double;
  fValor_Pte_UM        : Double;
  fPrecio_Pte          : Double;
  fValor_Mdo_UM        : Double;
  fPtge_Diferencia     : Double;
  fPtge_Max_Diferencia : Double;
  fValor_Pte_Ant_UM    : Double;
  fValor_Pte_Ant_MC    : Double;
  fPrecio_Ant          : Double;
begin
  Result := True;
  Reg_Val_Out.Precio_Titulo := 0;
  Reg_Val_In.Forzar_Uso_Formula_PAR := 'NO';
  Reg_Val_In.Forzar_Uso_Formula_PTE := 'NO';


  if sValorizacion_Proceso = 'SI' then
     Busca_Valuacion_Mem (Reg_Val_In,
                          sTipo_Valuac,
                          sFormula_Pte,
                          fBase_Precio,
                          sMon_Ind,
                          Reg_val_out.Origen,
                          sTasa_Base,
                          sCodigo_Formula,
                          Result)
  else
     if sValorizacion_Proceso = 'FW' then   // ggarcia 03-06-2014
     begin
        sTipo_Valuac := sTIPO_VALUACION;
        sFormula_Pte := sCODIGO_CALCULO;
        fBase_Precio := fBASE_TASA_PRECIO;
        sMon_Ind     := sMON_IND_PRECIO;
        Reg_val_out.Origen      := sOrigen_PRECIO;
        sTasa_Base   := '';
        sCodigo_Formula := '';
     end
     else
        Busca_Valuacion(Reg_Val_In,
                        sTipo_Valuac,
                        sFormula_Pte,
                        fBase_Precio,
                        sMon_Ind,
                        Reg_val_out.Origen,
                        sTasa_Base,
                        sCodigo_Formula,
                        Result);

  if NOT Result then
     sTipo_Valuac := '';

    //--------------------------------------------------------------------------
    // PARMASMERC: Valoriza a valor PAR al dia anterior al calculo
    //             y al resultado le suma la valorizacion indicada en
    //             la formula ingresada como parametro en sFormula_Pte
    // (BRASIL) 12 de Marzo del 2003
    //--------------------------------------------------------------------------
    if sTipo_Valuac = 'PARMASMERC' then
    begin
      // Almaceno fechas para recuperarlas antes de salir
      Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
      Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
      Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
      Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;

      // Se valoriza a PAR al dia antes => Fecha de calculo es un día antes
      Reg_Val_In.dFechaCalculo := Registro_Fechas.Fecha_Calculo - 1;
      Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

      Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
      Reg_Val_In.Valoriza_Par_Pte := 'PAR';

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

      // Devuelvo valores al original por si sale por error
      Reg_Val_In.dFechaEmision := Registro_Fechas.Fecha_Emision;
      Reg_Val_In.dFechaCalculo := Registro_Fechas.Fecha_Calculo;
      Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

      if NOT Result then
      begin
         String_Err := sTipo_Valuac+'-'+String_Err;
         exit;
      end;

      bResultTasa := true;
      if sValorizacion_Proceso = 'SI' then
      begin
        if Reg_Val_In.Tipo_Instrumento = 'B' then
        begin
           fValor := Leer_Tir_Mra_Mem(Reg_Val_In.Nemotecnico
                                     ,Reg_Val_In.dFechaCalculo
                                     ,Reg_val_out.Origen
                                     ,sTipo_TasPre);
           if fValor = 0 then  bResultTasa := false;
        end
        else
           bResultTasa := lee_tasa_mercado_Mem(Reg_Val_In.Nemotecnico
                                              ,Reg_Val_In.dFechaCalculo
                                              ,False
                                              ,Reg_val_out.Origen
                                              ,fValor
                                              ,sTipo_TasPre)
      end
      else
         bResultTasa := lee_tasa_mercado(Reg_Val_In.Nemotecnico
                                        ,Reg_Val_In.Tipo_Instrumento
                                        ,Reg_Val_In.sInstrumento
                                        ,Registro_Fechas
                                        ,''
                                        ,Reg_Val_In.dFechaCalculo
                                        ,Reg_val_out.Origen
                                        ,fValor
                                        ,sTipo_TasPre);

//      if (bResultTasa = false) and (Reg_Val_In.Tipo_Instrumento <> 'B') then      // para que de error cuando no encuentre TIRMRA E.S. 18-11-2010
      if (bResultTasa = false) then                                                 // por cambios IFRS, ahora debe buscar tasa hacia atras  J.D. & E.S. 24-07-2012
      begin
          // Si no Existe Tasa a Fecha Busco Proyección de Tasas
          if sValorizacion_Proceso = 'SI' then
             bResultTasa := Lee_LastTasa_mercado_Mem(Reg_Val_In.Nemotecnico
                                                    ,Reg_val_out.Origen
                                                    ,fValor
                                                    ,sTipo_TasPre);

          //Busco Tasas por Instrumento si No Encuentra Proyección
          //if fValor = 0 then   // E.S. 05-04-2016
          if NOT bResultTasa then
          begin
             fValor := Leer_Tasa_Instrumento_Mem( Reg_Val_In.sInstrumento
                                                 ,Reg_Val_In.dFechaCalculo
                                                 ,Reg_Val_In.dFechaVencimiento
                                                 ,sTipo_TasPre
                                                 ,Reg_val_out.Origen);

             if fValor = 0 then
             begin
                Modulo_Err := 'Valuación de Instrumentos';
                String_Err := sTipo_Valuac+': No se encontró Tasa de Mercado para :'
                            +' Nemotecnico: '+Reg_Val_In.Nemotecnico
                            +' Con Fecha: '+DatetoStr(Reg_Val_In.dFechaCalculo)
                            +' ('+Reg_val_out.Origen+')';

                Result := False;
                exit;
             end;
             Result := True;
          end;
      end
      else
      begin
//         if (bResultTasa = false) and (Reg_Val_In.Tipo_Instrumento = 'B') then        // para que de error cuando no encuentre TIRMRA E.S. 18-11-2010
         if (bResultTasa = false) then           // por cambios IFRS, ahora debe dar error cuando no encuentre tasa hacia atras  J.D. & E.S. 24-07-2012
             if fValor = 0 then
             begin
                Modulo_Err := 'Valuación de Instrumentos';
                String_Err := sTipo_Valuac+': No se encontró Tasa de Mercado para :'
                            +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                            +' Con Fecha: '+DatetoStr(Reg_Val_In.dFechaCalculo);
                Result := False;
                exit;
             end;
      end;

      // Fuerzo el uso en el valorizador de la formula
      // Especificada para Valuacion segun de Tasa Mercado
      if (String.IsNullOrEmpty(sFormula_Pte))    or
         (sFormula_Pte = '')    then
          sFormula_Pte := Reg_Val_Out.RegDes.COD_CALC_TIR_D;

      Reg_Val_In.dFechaEmision := Registro_Fechas.Fecha_Calculo - 1;
      Reg_Val_In.dFechaCalculo := Registro_Fechas.Fecha_Calculo;
      Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

      Reg_Val_In.Forzar_Uso_Formula_PTE := 'SI';
      Reg_Val_In.Formula_PTE            := sFormula_Pte;
      Reg_Val_In.Valoriza_Par_Pte       := 'PTE';
      Reg_Val_Out.TasaCalculo           := fValor;
      Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
      Reg_Val_Out.Rate_Used_Valuacion   := fValor;
      if sTipo_TasPre <> '' then
         Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;

      // Nuevo capital es el valor PAR
      Reg_Val_Out.Nominales             := Reg_Val_Out.Valor_Par_UM;

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

      // Devuelvo valores al original por si sale por error
      Reg_Val_In.dFechaEmision := Registro_Fechas.Fecha_Emision;
      Reg_Val_In.dFechaCalculo := Registro_Fechas.Fecha_Calculo;
      Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

      if NOT Result then
      begin
         String_Err := sTipo_Valuac+': '+String_Err;
         exit;
      end;

      Reg_Val_In.Forzar_Uso_Formula_PAR := 'NO';
      Reg_Val_In.Forzar_Uso_Formula_PTE := 'NO';

      exit;  // ggarcia 14-06-2013

    end;
    //--------------------------------------------------------------------------
    // Valuación por Tasa de Mercado
    //--------------------------------------------------------------------------
    if (sTipo_Valuac = 'TASAMERC')   OR
       (sTipo_Valuac = 'BRTASAMERC') OR
       (sTipo_Valuac = 'BRTAME-LIM') OR
       (sTipo_Valuac = 'TASMERBRTR') OR
       (sTipo_Valuac = 'VTM-LIMPIO') then
    begin
      //ggarcia 21-04-2022
      dFecha_Tasa := Reg_Val_In.dFechaCalculo;

      if (String.IsNullOrEmpty(sFormula_Pte)) or
         (sFormula_Pte = '')    then
          sFormula_Pte := Reg_Val_Out.RegDes.COD_CALC_TIR_D;
      // Para calculo de Tasa por Instrumento
      Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
      bResultTasa := true;
      if (sTipo_Valuac = 'BRTASAMERC') or (sTipo_Valuac = 'VTM-LIMPIO') or (sTipo_Valuac = 'BRTAME-LIM')  then
         bResultTasa := lee_tasa_mercado(  Reg_Val_In.Nemotecnico
                                          ,Reg_Val_In.Tipo_Instrumento
                                          ,Reg_Val_In.sInstrumento
                                          ,Registro_Fechas
                                          ,'BRTASAMERC'
                                          ,dFecha_Tasa //ggarcia 21-04-2022 Reg_Val_In.dFechaCalculo
                                          ,Reg_val_out.Origen
                                          ,fValor
                                          ,sTipo_TasPre)
      else
         if sTipo_Valuac = 'TASMERBRTR' then
            bResultTasa := lee_tasa_mercado(  Reg_Val_In.Nemotecnico
                                             ,Reg_Val_In.Tipo_Instrumento
                                             ,Reg_Val_In.sInstrumento
                                             ,Registro_Fechas
                                             ,'TASMERBRTR'
                                             ,dFecha_Tasa //ggarcia 21-04-2022 Reg_Val_In.dFechaCalculo
                                             ,Reg_val_out.Origen
                                             ,fValor
                                             ,sTipo_TasPre)
         else
         begin
            //ggarcia 21-04-2022
            if Transaccion_Implica_mem(sEmpresa_Usuario,'TASA_FPROC') then
               dFecha_Tasa := Reg_Val_In.dFechaCalculoOriginal;

            bResultTasa := lee_tasa_mercado(  Reg_Val_In.Nemotecnico
                                             ,Reg_Val_In.Tipo_Instrumento
                                             ,Reg_Val_In.sInstrumento
                                             ,Registro_Fechas
                                             ,''
                                             ,dFecha_Tasa //ggarcia 21-04-2022 Reg_Val_In.dFechaCalculo
                                             ,Reg_val_out.Origen
                                             ,fValor
                                             ,sTipo_TasPre);
            if bResultTasa = false then
               if sValorizacion_Proceso = 'SI' then
                  bResultTasa := Lee_LastTasa_mercado_Mem(Reg_Val_In.Nemotecnico
                                                         ,Reg_val_out.Origen
                                                         ,fValor
                                                         ,sTipo_TasPre);
         end;

      if bResultTasa = false then
      begin
         Modulo_Err := 'Valuación de Instrumentos';
         String_Err := sTipo_Valuac+': No se encontró Tasa de Mercado para :'
                       +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                       +' Con Fecha: '+DatetoStr(dFecha_Tasa)     //ggarcia 21-04-2022 DatetoStr(Reg_Val_In.dFechaCalculo)
                       +' ('+Reg_val_out.Origen+')';

         Result := False;
         exit;
      end;
      // Fuerzo el uso en el valorizador de la formula
      // Especificada para Valuacion segun de Tasa Mercado
      Reg_Val_In.Forzar_Uso_Formula_PTE := 'SI';
      Reg_Val_In.Formula_PTE            := sFormula_Pte;
      Reg_Val_In.Valoriza_Par_Pte       := 'PTE';
      Reg_Val_Out.TasaCalculo           := fValor;
      Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
      Reg_Val_Out.Rate_Used_Valuacion   := fValor;
      if sTipo_TasPre <> '' then
         Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

      If sTipo_Valuac = 'VTM-LIMPIO' then
      Begin
         Limpia_Valor_Interes(Reg_Val_In,
                        Reg_Val_Out,
                        Modulo_Err,
                        String_Err,
                        Result);
         if Not Result then
         begin
            Modulo_Err := 'Valuación de Instrumentos';
            String_Err := sTipo_Valuac+': Problemas con Limpiar el Valor de Mercado :'
                         +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                         +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo);
            exit;
         end;
      End;

      if sTipo_Valuac = 'BRTAME-LIM' then
      begin
         ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                               ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                               ,Reg_Val_Out.Array_Mem_Desarr
                               ,Reg_Val_Out.RegDes
                               ,Reg_Val_In.Con_Cupon
                               ,iNro_Cupon
                               ,dFecha_Desde
                               ,Modulo_Err
                               ,String_Err
                               ,Result);
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

         Reg_Val_In.bIncluye_CC := (Reg_Val_In.fCupones_Cortados > 0);     // Edosan, 05-04-2013

         Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                             ,Reg_Val_In.sEmisor
                             ,Reg_Val_In.sInstrumento
                             ,Reg_Val_In.sSerie
                             ,Reg_Val_In.Nemotecnico
                             ,Reg_Val_In.dTasaEmision
                             ,Reg_Val_Out.TasaCalculo
                             ,Reg_Val_In.sUnidadMonetaria
                             ,Reg_Val_In.sTipoNominales
                             ,Reg_Val_In.dFechaEmision
                             ,Reg_Val_In.dFechaVencimiento
                             //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                             //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                             ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                             ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                             ,Reg_Val_In.dFechaPago
                             ,Reg_Val_In.sMoneda_Conversion
                             ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                             ,Reg_Val_Out.Nominales
                             ,dFecha_Desde                 // Fecha Desde
                             ,Reg_Val_In.dFechaCompra     // Fecha Hasta
                             ,Reg_Val_In.Descriptor_Cargado
                             ,Reg_Val_In.Tabla_Desarr_Cargada
                             ,Reg_Val_Out.RegDes
                             ,Reg_Val_Out.Array_Mem_Desarr
                             ,fInteres_Acum_UM
                             ,fInteres_Acum_MC
                             ,fInteres_Acum_UM_REAJUSTADO
                             ,fReajuste_Indexado
                             ,fAjuste_Reajuste_Indexado
                             ,fReajuste_NO_Indexado
                             ,Modulo_Err
                             ,String_Err
                             ,Result);
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;
         Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM -
                                         fInteres_Acum_UM;

         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sMoneda_Conversion
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
         if NOT Result then
            exit;
         Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoMC);
      end;


      Reg_Val_In.Forzar_Uso_Formula_PAR := 'NO';
      Reg_Val_In.Forzar_Uso_Formula_PTE := 'NO';

      exit;  // ggarcia 14-06-2013

    end;
    //--------------------------------------------------------------------------
    // Valuación por Tasa por Instrumento
    //--------------------------------------------------------------------------
    if sTipo_Valuac = 'TASAINST' then
    begin
      if (String.IsNullOrEmpty(sFormula_Pte)) or
         (sFormula_Pte = '')    then
          sFormula_Pte := Reg_Val_Out.RegDes.COD_CALC_TIR_D;

      if sValorizacion_Proceso = 'SI' then
      begin
         fValor := Leer_Tasa_Instrumento_Mem( Reg_Val_In.sInstrumento
                                             ,Reg_Val_In.dFechaCalculo
                                             ,Reg_Val_In.dFechaVencimiento
                                             ,sTipo_TasPre
                                             ,Reg_val_out.Origen);

         if fValor = 0 then
         begin
            Modulo_Err := 'Valuación de Instrumentos';
            String_Err := sTipo_Valuac+': No se encontro+ de Tasa Por Instrumento para :'
                        +'Nemotecnico : '+Reg_Val_In.Nemotecnico+''
                        +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo);
            Result := False;
            exit;
         end;
      end;
      // Fuerzo el uso en el valorizador de la formula
      // Especificada para Valuacion segun de Tasa Mercado
      Reg_Val_In.Forzar_Uso_Formula_PTE := 'SI';
      Reg_Val_In.Formula_PTE            := sFormula_Pte;
      Reg_Val_In.Valoriza_Par_Pte       := 'PTE';
      Reg_Val_Out.TasaCalculo           := fValor;
      Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
      Reg_Val_Out.Rate_Used_Valuacion   := fValor;
      if sTipo_TasPre <> '' then
         Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

      Reg_Val_In.Forzar_Uso_Formula_PAR := 'NO';
      Reg_Val_In.Forzar_Uso_Formula_PTE := 'NO';

      exit;  // ggarcia 14-06-2013

    end;


    //--------------------------------------------------------------------------
    // Valuación por Precio de Mercado * Nominales (PRECIO SUCIO)
    //--------------------------------------------------------------------------
    if (sTipo_Valuac = 'PRECNOM') OR
       (sTipo_Valuac = 'VPN-LIMPIO') then
       begin
         if (FloatToStr(fBase_Precio) = '') or
            (fBase_Precio <= 0)    then
         begin
           Modulo_Err := 'Valuación de Instrumentos';
           String_Err := sTipo_Valuac+': Error en definición de Base para Valuacìón de :'
                        +'Emisor      : '+Reg_Val_In.sEmisor
                        +'Instrumento : '+Reg_Val_In.sInstrumento
                        +'Serie       : '+Reg_Val_In.sSerie;
           Result := False;
           exit;
         end;

         // Para Reg_Val_In.Proceso_Valuacion = 'OMD_P_CLEA' o
         //      Reg_Val_In.Proceso_Valuacion = 'OMD_P_DIRT' o
         //      sTipo_Valuac = 'PX-CLEAN-O') o
         //      sTipo_Valuac = 'PX-DIRTY-O')
         // Debo usar el precio indicado en la OMD
         // por lo cual no tengo que leer precios de mercado
         if (sTipo_Valuac <> 'PX-CLEAN-O') AND
            (sTipo_Valuac <> 'PX-DIRTY-O') AND
            (Reg_Val_In.Proceso_Valuacion <> 'OMD_P_CLEA') AND
            (Reg_Val_In.Proceso_Valuacion <> 'OMD_P_DIRT') then
         begin
            bExiste_Precio_Mdo := lee_precio_mercado(Reg_Val_In.Nemotecnico
                                                    ,Reg_Val_In.dFechaCalculo
                                                    ,False
                                                    ,Reg_val_out.Origen
                                                    ,fValor
                                                    ,sTipo_TasPre);

            if NOT bExiste_Precio_Mdo then
            begin
              lee_proy_precio( Reg_Val_In.Tipo_Proceso
                              ,Reg_Val_In.Nemotecnico
                              ,'QS_FIN_PREC_MERCAD'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_val_out.Origen
                              ,fValor
                              ,sTipo_TasPre
                              ,Result
                             );
              if Not Result then
              begin
                Modulo_Err := 'Valuación de Instrumentos';
                String_Err := sTipo_Valuac+' No se encontro Precio de Mercado para :'
                             +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                             +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo)
                             +' ('+Reg_val_out.Origen+')';
                Result := False;
                exit;
              end;
            end;
         end;

         if (Reg_Val_In.Proceso_Valuacion = 'OMD_P_CLEA') then
            fValor := Reg_Val_Out.Precio_Limpio;

         if (Reg_Val_In.Proceso_Valuacion = 'OMD_P_DIRT') then
            fValor := Reg_Val_Out.Precio_Sucio;

         Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
         Reg_Val_Out.Rate_Used_Valuacion   := fValor;
         if sTipo_TasPre <> '' then
            Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;
         Reg_Val_Out.ValorInvertidoUM := (Reg_Val_Out.Nominales *
                                          fValor) /
                                          fBase_Precio;


         // Nuevo...
         // Considera el pareametro con o sin cupon para el metodo de valuación PRECNOM
         // Hasta ahora el valorizar "Con cupon" al hacer el PxQ estaba entregando lo mismo
         // Con cupon y sin cupon (se entiende que el precio sucio trae reflejado el corte de cupon
         // por lo cual el valor entregado es con el cupon cortado

         // El cambio consiste en que cuando venga con cupon se le debera sumar el valor correspondiente
         // al cupon cortado (FI) 29-01-2007

         if Reg_Val_In.Con_Cupon then
         begin
           if ((Reg_Val_Out.RegDes.Tasa_Flotante = 'S') and (NOT Reg_Val_Out.RegDes.bSin_Tasa_en_Flujos)) or
               ((Reg_Val_Out.RegDes.Variacion_Cambiaria) and (NOT (Reg_Val_In.sValor_Cupon_Original = 'S'))) then
               if (Reg_Val_Out.RegDes.Fecha_Carga_Array_Mem <> Reg_Val_In.dFechaCalculo) then
                   Reg_Val_In.Tabla_Desarr_Cargada := 'NO'
               else
                   if VarCamb_Depende_de_Operacion_Mem( Reg_Val_In.sEmisor                  // 09-11-2015 Se agrega para que cuando la tabla de desarrollo depende de la fechga de la operacion la cargue siempre
                                                       ,Reg_Val_In.sInstrumento
                                                       ,Reg_Val_In.sSerie)  then
                      Reg_Val_In.Tabla_Desarr_Cargada := 'NO';

                if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
                begin
                   Carga_RegDes(Reg_Val_In.Tipo_Instrumento
                               ,Reg_Val_In.sEmisor
                               ,Reg_Val_In.sEmisor
                               ,Reg_Val_In.sInstrumento
                               ,Reg_Val_In.sSerie
                               ,Reg_Val_In.sMoneda_Conversion
                               ,Reg_Val_In.dTasaEmision
                               ,Reg_Val_Out.RegDes
                               ,Modulo_Err
                               ,String_Err
                               ,Result);
                    if NOT Result then
                    begin
                       String_Err := sTipo_Valuac+': '+String_Err;
                       exit;
                    end;
                    Reg_Val_In.Descriptor_Cargado := 'SI';

                    if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                       Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                                      ,Reg_Val_In.sEmisor
                                      ,Reg_Val_In.sInstrumento
                                      ,Reg_Val_In.sSerie
                                      ,Reg_Val_In.Nemotecnico
                                      ,Reg_Val_In.sTipoNominales
                                      ,Reg_Val_Out.Nominales
                                      ,Reg_Val_In.dTasaEmision
                                      ,Reg_Val_In.dFechaEmision
                                      ,Reg_Val_In.dFechaVencimiento
                                      ,Reg_Val_In.dFechaCalculo
                                      ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                                      ,Reg_Val_In.Con_Cupon
                                      ,Reg_Val_Out.Array_Mem_Desarr
                                      ,Reg_Val_Out.RegDes
                                      ,Registro_Fechas
                                      ,sMetodo_Sin_Tasa_Referencia
                                      ,Parametros_Formula
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result)
                    else
                       Carga_TabDesarr_Vig(Reg_Val_In.Tipo_Instrumento
                                          ,Reg_Val_In.sEmisor
                                          ,Reg_Val_In.sInstrumento
                                          ,Reg_Val_In.sSerie
                                          ,Reg_Val_In.dFecha_Vig
                                          ,Reg_Val_In.Nemotecnico
                                          ,Reg_Val_In.sTipoNominales
                                          ,Reg_Val_Out.Nominales
                                          ,Reg_Val_In.dTasaEmision
                                          ,Reg_Val_In.dFechaEmision
                                          ,Reg_Val_In.dFechaVencimiento
                                          ,Reg_Val_In.dFechaCalculo
                                          ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                                          ,Reg_Val_In.Con_Cupon
                                          ,Reg_Val_Out.Array_Mem_Desarr
                                          ,Reg_Val_Out.RegDes
                                          ,Registro_Fechas
                                          ,sMetodo_Sin_Tasa_Referencia
                                          ,Parametros_Formula
                                          ,Modulo_Err
                                          ,String_Err
                                          ,Result);

                   if NOT Result then
                   begin
                      String_Err := sTipo_Valuac+': '+String_Err;
                      exit;
                   end;
                   Reg_Val_In.Tabla_Desarr_Cargada := 'SI'
                end;

                Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                              Reg_Val_Out.RegDes,
                              Reg_Val_In.dFechaCalculo,
                              True,
                              iCupon_Vigente,
                              Modulo_Err,
                              String_Err,
                              Result);


                if not Result then
                begin
                   String_Err := sTipo_Valuac+': '+String_Err;
                   exit;
                end;

                if Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto = Reg_Val_In.dFechaCalculo then
                begin
                  if Reg_Val_Out.RegDes.BASE_CONVERSION <> 0 then
                     Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                                     (Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Valor_Cupon *
                                                      Reg_Val_Out.Nominales /
                                                      Reg_Val_Out.RegDes.BASE_CONVERSION);
                end;


         end; // Nuevo CON CUPON !!!!!


         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sMoneda_Conversion
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

         Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoUM);

         Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoMC);
      If sTipo_Valuac = 'VPN-LIMPIO' then
      Begin
         Limpia_Valor_Interes(Reg_Val_In,
                        Reg_Val_Out,
                        Modulo_Err,
                        String_Err,
                        Result);
         if Not Result then
         begin
            Modulo_Err := 'Valuación de Instrumentos';
            String_Err := sTipo_Valuac+': Problemas con Limpiar el Valor de Mercado :'
                         +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                         +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo);
            exit;
         end;
      end;

      exit;

      exit;  // ggarcia 14-06-2013

   end;

    //--------------------------------------------------------------------------
    // TIRK+I (K): DESC. FLUJOS DE K. A TIRK MAS INT. DEVENG. (REA CAPITAL RES)
    // TIRK (K): DESC. FLUJOS DE K. A TIRK MAS INT. DEVENG. (REA CAPITAL RES)
    // Pendiente !!!  TIRK+I (C): DESC. FLUJOS DE K. A TIRK MAS INT. DEVENG. (REA COSTO CPA)
    //--------------------------------------------------------------------------
    if (sTipo_Valuac = 'TIRK+I (K)') or
       (sTipo_Valuac = 'TIRK+I (C)') or
       (sTipo_Valuac = 'TIRK (K)') or
       (sTipo_Valuac = 'TIRK (C)') then
    begin
      if (sTipo_Valuac = 'TIRK+I (K)') or
         (sTipo_Valuac = 'TIRK (K)') then
        sTipo_Reajuste := 'Reajustes_Sobre_Capital_Residual'
      else
        sTipo_Reajuste := 'Reajustes_Sobre_Actual_Cost';

      // Determino ultimo corte antes de la compra
      ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                            ,Reg_Val_In.dFechaCompra
                            ,Reg_Val_Out.Array_Mem_Desarr
                            ,Reg_Val_Out.RegDes
                            ,False
                            ,iCupon_Vigente
                            ,dFecha_Desde  // Fecha ultimo vencimiento
                            ,Modulo_Err
                            ,String_Err
                            ,Result);

      if not Result then
      begin
         String_Err := sTipo_Valuac+': '+String_Err;
         exit;
      end;

      // Saldo Insoluto a la Compra para limpiar valores a la misma
      { 12-01-2010 --> Por el tema de capitalizaciones se cambia la funcion F.I.
      Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                    ,Reg_Val_Out.RegDes
                    ,Reg_Val_In.dFechaEmision
                    ,Reg_Val_In.dFechaCompra
                    ,Reg_Val_Out.Nominales
                    ,Reg_Val_Out.Array_Mem_Desarr
                    ,False
                    ,fSaldo_Insoluto_Cpa
                    ,fSaldo_Insoluto_Cpa_ConRea
                    ,Modulo_Err
                    ,String_Err
                    ,Result);
      }

      Saldo_Insoluto_Segun_Compra( Reg_Val_In.Tipo_Instrumento
                                   ,Reg_Val_Out.RegDes
                                   ,Reg_Val_In.dFechaEmision
                                   ,Reg_Val_In.dFechaCompra // Fecha Saldo
                                   ,Reg_Val_In.dFechaCompra
                                   ,Reg_Val_Out.Nominales
                                   ,Reg_Val_Out.Array_Mem_Desarr
                                   ,False
                                   ,fSaldo_Insoluto_Cpa
                                   ,fSaldo_Insoluto_Cpa_ConRea
                                   ,fCapitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado
                                   ,Modulo_Err
                                   ,String_Err
                                   ,Result);
      if NOT Result then
      begin
         String_Err := sTipo_Valuac+': '+String_Err;
         exit;
      end;

      // Cambio moneda de conversion para calculos a la fecha de compra
      sAux_Moneda_Conversion        := Reg_Val_In.sMoneda_Conversion;
      Reg_Val_In.sMoneda_Conversion := Reg_Val_In.sUnidadMonetaria;
       // Se subio mas arriba ya que afecta tambien el calculo de los intereses 17-06-2015
       // Guardo la fecha de calculo original
       dFecha_Calculo := Reg_Val_In.dFechaCalculo;
       // Calculo TIR de Capital a la fecha de compra (Solo sobre amortizaciones
       Reg_Val_In.dFechaCalculo           := Reg_Val_In.dFechaCompra; // Fecha de Calculo
       Reg_Val_In.dFechaCalculoOriginal   := Reg_Val_In.dFechaCalculo;
       // Esto es para que no cambie a la fecha de pago de la venta
       Aux_Fecha_Pago := Reg_Val_In.dFechaPago;
       if (Reg_Val_In.Modulo_Llamado = 'LIBRO VENTAS') then
          Reg_Val_In.dFechaPago := Reg_Val_In.dFechaCompra;

       // Se limpian el valor invertido de la compra (se asume que es el vigente proporcional)
       if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
          Limpia_Valores(sEmpresa_Usuario
                        ,''              // La cartera no la estoy usando ... Pendiente eliminar el parametro
                        ,''              // sTransaccion_Compra
                        ,Reg_Val_In.dFechaCompra
                        ,Reg_Val_In.Tipo_Instrumento
                        ,Reg_Val_In.sEmisor
                        ,Reg_Val_In.sInstrumento
                        ,Reg_Val_In.sSerie
                        ,Reg_Val_In.Nemotecnico
                        ,Reg_Val_In.dTasaEmision
                        ,Reg_Val_Out.RegDes.Tasa_Efectiva
                        ,Reg_Val_In.sUnidadMonetaria
                        ,Reg_Val_In.sTipoNominales
                        ,Reg_Val_In.dFechaEmision
                        ,Reg_Val_In.dFechaVencimiento
                        ,Reg_Val_In.dFechaCompra
                        ,Reg_Val_In.dFechaPago
                        ,Reg_Val_In.sMoneda_Conversion
                        ,Reg_Val_In.fCupones_Cortados
                        ,sTipo_Reajuste
                        ,fSaldo_Insoluto_Cpa_ConRea
                        ,Reg_Val_Out.Nominales
                        ,Reg_Val_In.Tabla_Desarr_Cargada
                        ,Reg_Val_Out.RegDes
                        ,Reg_Val_Out.Array_Mem_Desarr
                        ,dFecha_Desde
                        ,Reg_Val_In.dFechaCompra
                        ,Reg_Val_Out.ValorInvertidoUM
                        ,fValor_Compra_Clean_UM
                        ,fValor_Clean_UM_Rea
                        ,Modulo_Err
                        ,String_Err
                        ,Result)
       else
          Limpia_Valores_Vig(sEmpresa_Usuario
                            ,''              // La cartera no la estoy usando ... Pendiente eliminar el parametro
                            ,''              // sTransaccion_Compra
                            ,Reg_Val_In.dFechaCompra
                            ,Reg_Val_In.Tipo_Instrumento
                            ,Reg_Val_In.sEmisor
                            ,Reg_Val_In.sInstrumento
                            ,Reg_Val_In.sSerie
                            ,Reg_Val_In.dFecha_Vig
                            ,Reg_Val_In.Nemotecnico
                            ,Reg_Val_In.dTasaEmision
                            ,Reg_Val_Out.RegDes.Tasa_Efectiva
                            ,Reg_Val_In.sUnidadMonetaria
                            ,Reg_Val_In.sTipoNominales
                            ,Reg_Val_In.dFechaEmision
                            ,Reg_Val_In.dFechaVencimiento
                            ,Reg_Val_In.dFechaCompra
                            ,Reg_Val_In.dFechaPago
                            ,Reg_Val_In.sMoneda_Conversion
                            ,Reg_Val_In.fCupones_Cortados
                            ,sTipo_Reajuste
                            ,fSaldo_Insoluto_Cpa_ConRea
                            ,Reg_Val_Out.Nominales
                            ,Reg_Val_In.Tabla_Desarr_Cargada
                            ,Reg_Val_Out.RegDes
                            ,Reg_Val_Out.Array_Mem_Desarr
                            ,dFecha_Desde
                            ,Reg_Val_In.dFechaCompra
                            ,Reg_Val_Out.ValorInvertidoUM
                            ,fValor_Compra_Clean_UM
                            ,fValor_Clean_UM_Rea
                            ,Modulo_Err
                            ,String_Err
                            ,Result);

       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
          exit;
       end;
{
       // Guardo la fecha de calculo original
       dFecha_Calculo := Reg_Val_In.dFechaCalculo;
       // Calculo TIR de Capital a la fecha de compra (Solo sobre amortizaciones
       Reg_Val_In.dFechaCalculo           := Reg_Val_In.dFechaCompra; // Fecha de Calculo
       // Esto es para que no cambie a la fecha de pago de la venta
       Aux_Fecha_Pago := Reg_Val_In.dFechaPago;
       if (Reg_Val_In.Modulo_Llamado = 'LIBRO VENTAS') then
          Reg_Val_In.dFechaPago := Reg_Val_In.dFechaCompra;
}
       Reg_Val_In.Valoriza_Par_Pte        := 'TIR';
       Reg_Val_Out.ValorInvertidoUM       := fValor_Compra_Clean_UM;
       Reg_Val_Out.ValorInvertidoMC       := 0;
       Reg_Val_In.sValor_Cupon_Original   := 'S';
       Reg_Val_In.sComponentes_Descuento  := 'AMORTIZACION';

       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         Modulo_Err,
                         String_Err,
                         Result);

       if not Result then
       begin
          Reg_Val_In.sComponentes_Descuento  := '';
          Reg_Val_In.sValor_Cupon_Original   := '';
          Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;
       Reg_Val_Out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;

       // Calculo Valor Presente a la Fecha de Calculo segun Tir de Capital
       Reg_Val_In.Valoriza_Par_Pte   := 'PTE';
       Reg_Val_In.dFechaCalculo      := dFecha_Calculo;       // Fecha de Calculo
       Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
       Reg_Val_In.dFechaPago         := Aux_Fecha_Pago;
       Reg_Val_In.sComponentes_Descuento  := 'AMORTIZACION';
       // El con Cupon estaba comentado. Lo descomente con fecha 23-06-2008 (F.I.)
       // a que el valor pte ya no debe incluir el valor del cupon a la fecha de calculo
       // NO CORRESPONDE CAMBIAR EL Con_Cupon ACA !!! SE VUELVE A COMENTAR 24-06-2008
       //Reg_Val_In.Con_Cupon               := False;
       Reg_Val_In.sValor_Cupon_Original   := 'S';

       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         Modulo_Err,
                         String_Err,
                         Result);

       if not Result then
       begin
          Reg_Val_In.sComponentes_Descuento  := '';
          Reg_Val_In.sValor_Cupon_Original   := '';
          Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
          Modulo_Err := 'Valuación con TirK';
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

       Reg_Val_In.sComponentes_Descuento  := '';
       Reg_Val_In.sValor_Cupon_Original   := '';

       ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                             ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                             ,Reg_Val_Out.Array_Mem_Desarr
                             ,Reg_Val_Out.RegDes
                             ,Reg_Val_In.Con_Cupon
                             ,iNro_Cupon         // traia el 74
                             ,dFecha_Desde
                             ,Modulo_Err
                             ,String_Err
                             ,Result);
       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
          exit;
       end;

       if (sTipo_Valuac = 'TIRK+I (K)') or
          (sTipo_Valuac = 'TIRK+I (C)') then
       begin
         if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                                ,Reg_Val_In.sEmisor
                                ,Reg_Val_In.sInstrumento
                                ,Reg_Val_In.sSerie
                                ,Reg_Val_In.Nemotecnico
                                ,Reg_Val_In.dTasaEmision
                                ,Reg_Val_Out.TasaCalculo
                                ,Reg_Val_In.sUnidadMonetaria
                                ,Reg_Val_In.sTipoNominales
                                ,Reg_Val_In.dFechaEmision
                                ,Reg_Val_In.dFechaVencimiento
                                //,Reg_Val_In.dFechaCompra
                                //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                ,Reg_Val_In.dFechaPago
                                ,Reg_Val_In.sMoneda_Conversion
                                ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                ,Reg_Val_Out.Nominales
                                ,dFecha_Desde                 // Fecha Desde
                                ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                ,Reg_Val_In.Descriptor_Cargado
                                ,Reg_Val_In.Tabla_Desarr_Cargada
                                ,Reg_Val_Out.RegDes
                                ,Reg_Val_Out.Array_Mem_Desarr
                                ,fInteres_Acum_UM
                                ,fInteres_Acum_MC
                                ,fInteres_Acum_UM_REAJUSTADO
                                ,fReajuste_Indexado
                                ,fAjuste_Reajuste_Indexado
                                ,fReajuste_NO_Indexado
                                ,Modulo_Err
                                ,String_Err
                                ,Result)
         else
         begin
//            Reg_Val_In.dFecha_Vig      := dFecha_Vig;
            Intereses_Acumulados_Vig(Reg_Val_In.Tipo_Instrumento
                                    ,Reg_Val_In.sEmisor
                                    ,Reg_Val_In.sInstrumento
                                    ,Reg_Val_In.sSerie
                                    ,Reg_Val_In.dFecha_Vig
                                    ,Reg_Val_In.Nemotecnico
                                    ,Reg_Val_In.dTasaEmision
                                    ,Reg_Val_Out.TasaCalculo
                                    ,Reg_Val_In.sUnidadMonetaria
                                    ,Reg_Val_In.sTipoNominales
                                    ,Reg_Val_In.dFechaEmision
                                    ,Reg_Val_In.dFechaVencimiento
                                    //,Reg_Val_In.dFechaCompra
                                    //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                    ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                    ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                    ,Reg_Val_In.dFechaPago
                                    ,Reg_Val_In.sMoneda_Conversion
                                    ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                    ,Reg_Val_Out.Nominales
                                    ,dFecha_Desde                 // Fecha Desde
                                    ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                    ,Reg_Val_In.Tabla_Desarr_Cargada
                                    ,Reg_Val_Out.RegDes
                                    ,Reg_Val_Out.Array_Mem_Desarr
                                    ,fInteres_Acum_UM
                                    ,fInteres_Acum_MC
                                    ,fInteres_Acum_UM_REAJUSTADO
                                    ,fReajuste_Indexado
                                    ,fAjuste_Reajuste_Indexado
                                    ,fReajuste_NO_Indexado
                                    ,Modulo_Err
                                    ,String_Err
                                    ,Result);
         end;
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
            exit;
         end;
       end
       else
       begin
         fInteres_Acum_UM             := 0;
         fInteres_Acum_MC             := 0;
         fInteres_Acum_UM_REAJUSTADO  := 0;
       end;

       Saldo_Insoluto_Segun_Compra( Reg_Val_In.Tipo_Instrumento
                                   ,Reg_Val_Out.RegDes
                                   ,Reg_Val_In.dFechaEmision
                                   ,Reg_Val_In.dFechaCalculo
                                   ,Reg_Val_In.dFechaCompra
                                   ,Reg_Val_Out.Nominales
                                   ,Reg_Val_Out.Array_Mem_Desarr
                                   ,Reg_Val_In.Con_Cupon // False
                                   ,fSaldo_Insoluto_Sin_Rea
                                   ,fSaldo_Insoluto
                                   ,fCapitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado
                                   ,Modulo_Err
                                   ,String_Err
                                   ,Result);

       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
          exit;
       end;

       // OJO: el reajuste debe ser sobre el capital residual actual. 04-08-2010
       Saldo_Insoluto( Reg_Val_In.Tipo_Instrumento
                      ,Reg_Val_Out.RegDes
                      ,Reg_Val_In.dFechaEmision
                      ,Reg_Val_In.dFechaCalculo
                      ,Reg_Val_In.dFechaCompra   //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                      ,Reg_Val_Out.Nominales
                      ,Reg_Val_Out.Array_Mem_Desarr
                      ,Reg_Val_In.Con_Cupon // False
                      ,fSaldo_Insoluto_Sin_Rea
                      ,fSaldo_Insoluto
                      ,Modulo_Err
                      ,String_Err
                      ,Result);

          Reajuste_Valor(Reg_Val_In.sInstrumento
                        ,Reg_Val_In.sUnidadMonetaria
                        ,Reg_Val_In.sMoneda_Conversion
                        ,Reg_Val_In.dFechaCompra
                        ,Reg_Val_In.dFechaCalculo
                        ,fSaldo_Insoluto_Sin_Rea
                        ,Reg_Val_In.dFechaCompra
                        ,Reg_Val_In.dFechaEmision
                        ,Reg_Val_Out.RegDes
                        ,False
                        ,Reg_Val_Out.Array_Mem_Desarr
                        ,sCod_Indice_Reajuste
                        ,fReajuste_Index_Acumulado_Saldo_Insoluto
                        ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM
                        ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto
                        ,fSaldo_Insoluto
                        ,fDiferencia_tipo_cambio_Saldo_Insoluto
                        ,Modulo_Err
                        ,String_Err
                        ,Result);


       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
          exit;
       end;

       if (sTipo_Reajuste = 'Reajustes_Sobre_Capital_Residual') then
          // fReajuste_Capital := fSaldo_Insoluto - fSaldo_Insoluto_Sin_Rea // 03-08-2010 Para ajustarse al Book Value
          fReajuste_Capital := fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM
       else
          fReajuste_Capital := 0;


      if not Result then
      begin
         Reg_Val_In.sComponentes_Descuento  := '';
         Reg_Val_In.sValor_Cupon_Original   := '';
         Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
         String_Err := sTipo_Valuac+'(TIR SUCIA): '+String_Err;
         exit;
      end;

       Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                       fReajuste_Capital +
                                       fInteres_Acum_UM_REAJUSTADO +
                                       fCapitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado;

       if ((sTipo_Valuac = 'TIRK+I (K)')  or
           (sTipo_Valuac = 'TIRK+I (C)')) and
           (Reg_Val_In.dFechaCalculo <> Reg_Val_In.dFechaVencimiento) then
       begin
          // Calculo de la TIR para el nuevo valor con intereses
          Reg_Val_In.dFechaCalculo           := Reg_Val_In.dFechaCalculo;
          Reg_Val_In.dFechaCalculoOriginal   := Reg_Val_In.dFechaCalculo;
          Reg_Val_In.Valoriza_Par_Pte        := 'TIR';
          Reg_Val_In.sValor_Cupon_Original   := 'N';
          Reg_Val_In.sComponentes_Descuento  := '';

          Valoriza_Registro(Reg_Val_In,
                            Reg_Val_Out,
                            Modulo_Err,
                            String_Err,
                            Result);

          if not Result then
          begin
             Reg_Val_In.sComponentes_Descuento  := '';
             Reg_Val_In.sValor_Cupon_Original   := '';
             Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
             String_Err := sTipo_Valuac+'(TIR SUCIA): '+String_Err;
             exit;
          end;
          Reg_Val_Out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;
       end;

       Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;

       Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                            ,Reg_Val_In.sMoneda_Conversion
                            ,'BC'
                            ,Reg_Val_In.dFechaCalculo
                            ,Reg_Val_Out.ValorInvertidoUM
                            ,Reg_Val_Out.ValorInvertidoMC
                            ,Modulo_Err
                            ,String_Err
                            ,Result);
       //ggarcia 12-01-2018
       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;
       Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda_Mem(Reg_Val_In.sMoneda_Conversion,
                                                           Reg_Val_In.dFechaCalculo,
                                                           Reg_Val_Out.ValorInvertidoMC);

      exit;  // ggarcia 14-06-2013

    end;
    //----------------------------------------------------------------------------------------------------------------------
    // VALCPA+I   : Valor de compra menos amortizaciones mas intereses a tasa de emision (desde la compra o ultimo corte)
    // VALCPA     : (Limpio) Valor de compra menos amortizaciones
    //----------------------------------------------------------------------------------------------------------------------
    if (sTipo_Valuac = 'VALCPA+I') or
       (sTipo_Valuac = 'VALCPA') then
    begin
         Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                       ,Reg_Val_Out.RegDes
                       ,Reg_Val_In.dFechaEmision
                       ,Reg_Val_In.dFechaCalculo
                       ,Reg_Val_In.dFechaCompra    //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                       ,100                     // para obtener el saldo insoluto como porcentaje ..
                       ,Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_In.Con_Cupon // False
                       ,fSaldo_Insoluto_Sin_Rea
                       ,fSaldo_Insoluto
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

         Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM * fSaldo_Insoluto /100;

         if (sTipo_Valuac = 'VALCPA+I') then
         begin
            ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                                  ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                                  ,Reg_Val_Out.Array_Mem_Desarr
                                  ,Reg_Val_Out.RegDes
                                  ,Reg_Val_In.Con_Cupon
                                  ,iNro_Cupon         // traia el 74
                                  ,dFecha_Desde
                                  ,Modulo_Err
                                  ,String_Err
                                  ,Result);
            if NOT Result then
            begin
               String_Err := sTipo_Valuac+': '+String_Err;
               exit;
            end;

            if (dFecha_Desde < Reg_Val_In.dFechaCompra) then
               dFecha_Desde := Reg_Val_In.dFechaCompra;

            if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
               Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                                   ,Reg_Val_In.sEmisor
                                   ,Reg_Val_In.sInstrumento
                                   ,Reg_Val_In.sSerie
                                   ,Reg_Val_In.Nemotecnico
                                   ,Reg_Val_In.dTasaEmision
                                   ,Reg_Val_Out.TasaCalculo
                                   ,Reg_Val_In.sUnidadMonetaria
                                   ,Reg_Val_In.sTipoNominales
                                   ,Reg_Val_In.dFechaEmision
                                   ,Reg_Val_In.dFechaVencimiento
                                   //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                   //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                   ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                   ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                   ,Reg_Val_In.dFechaPago
                                   ,Reg_Val_In.sUnidadMonetaria //Reg_Val_In.sMoneda_Conversion
                                   ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                   ,Reg_Val_Out.Nominales
                                   ,dFecha_Desde                 // Fecha Desde
                                   ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                   ,Reg_Val_In.Descriptor_Cargado
                                   ,Reg_Val_In.Tabla_Desarr_Cargada
                                   ,Reg_Val_Out.RegDes
                                   ,Reg_Val_Out.Array_Mem_Desarr
                                   ,fInteres_Acum_UM
                                   ,fInteres_Acum_MC
                                   ,fInteres_Acum_UM_REAJUSTADO
                                   ,fReajuste_Indexado
                                   ,fAjuste_Reajuste_Indexado
                                   ,fReajuste_NO_Indexado
                                   ,Modulo_Err
                                   ,String_Err
                                   ,Result)
            else
            begin
   //            Reg_Val_In.dFecha_Vig      := dFecha_Vig;
               Intereses_Acumulados_Vig(Reg_Val_In.Tipo_Instrumento
                                       ,Reg_Val_In.sEmisor
                                       ,Reg_Val_In.sInstrumento
                                       ,Reg_Val_In.sSerie
                                       ,Reg_Val_In.dFecha_Vig
                                       ,Reg_Val_In.Nemotecnico
                                       ,Reg_Val_In.dTasaEmision
                                       ,Reg_Val_Out.TasaCalculo
                                       ,Reg_Val_In.sUnidadMonetaria
                                       ,Reg_Val_In.sTipoNominales
                                       ,Reg_Val_In.dFechaEmision
                                       ,Reg_Val_In.dFechaVencimiento
                                       //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                       //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                       ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                       ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                       ,Reg_Val_In.dFechaPago
                                       ,Reg_Val_In.sUnidadMonetaria //Reg_Val_In.sMoneda_Conversion
                                       ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                       ,Reg_Val_Out.Nominales
                                       ,dFecha_Desde                 // Fecha Desde
                                       ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                       ,Reg_Val_In.Tabla_Desarr_Cargada
                                       ,Reg_Val_Out.RegDes
                                       ,Reg_Val_Out.Array_Mem_Desarr
                                       ,fInteres_Acum_UM
                                       ,fInteres_Acum_MC
                                       ,fInteres_Acum_UM_REAJUSTADO
                                       ,fReajuste_Indexado
                                       ,fAjuste_Reajuste_Indexado
                                       ,fReajuste_NO_Indexado
                                       ,Modulo_Err
                                       ,String_Err
                                       ,Result);
            end;
            if NOT Result then
            begin
               String_Err := sTipo_Valuac+': '+String_Err;
               exit;
            end;

            Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM + fInteres_Acum_UM;
         end;

         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sMoneda_Conversion
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

      exit;  // ggarcia 14-06-2013

    end;
    //----------------------------------------------------------------------------------------------------------------------
    // K+INT+PL   : Capital Residual mas intereses a tasa de emision mas Paridad Lineal (Increase / Decrease)
    // K+PL       : (Limpio) Capital Residual mas Paridad Lineal (Increase / Decrease)
    //----------------------------------------------------------------------------------------------------------------------
    if (sTipo_Valuac = 'K+INT+PL') or
       (sTipo_Valuac = 'K+PL') then
    begin
         Modulo_Err := 'Valuación';
         String_Err := 'El tipo de valuación '+sTipo_Valuac+' no es válido';
         Result := False;
         exit;
    end;
    //----------------------------------------------------------------------------------------------------------------------
    // AC+INT+PL   : Actual Cost mas intereses a tasa de emision mas Paridad Lineal (Increase / Decrease)
    // AC+PL       : (Limpio) Actual Cost mas Paridad Lineal (Increase / Decrease)
    //----------------------------------------------------------------------------------------------------------------------
    if (sTipo_Valuac = 'AC+INT+PL') or
       (sTipo_Valuac = 'AC+PL') then
    begin
	// 07/08/2013 F.I. (ANTES ERA ACTUAL COST)
        sTipo_Reajuste := 'Reajustes_Sobre_Capital_Residual';

        // Obtiene tipo de calculo de días
        Obtener_Tasa_base(Reg_Val_Out.RegDes.Tasa_Valor_PTE,
                          iBaseTasa        ,
                          sTipoInteres     ,
                          iBaseMensual     ,
                          sTipoCalculoDias ,
                          iVigenciaValor   ,
                          iVigenciaMeses   ,
                          sPais_Tasa           ,
                          Modulo_Err       ,
                          String_Err       ,
                          Result );

        if not Result then
        begin
           String_Err := sTipo_Valuac+': '+String_Err;
           exit;
        end;

        // Determina Valor Limpio a la compra (Actual Cost)
        // Determino ultimo corte antes de la compra
        ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                              ,Reg_Val_In.dFechaCompra
                              ,Reg_Val_Out.Array_Mem_Desarr
                              ,Reg_Val_Out.RegDes
                              ,False
                              ,iCupon_Vigente
                              ,dFecha_Desde  // Fecha ultimo vencimiento
                              ,Modulo_Err
                              ,String_Err
                              ,Result);

        if not Result then
        begin
           String_Err := sTipo_Valuac+': '+String_Err;
           exit;
        end;

        // Saldo Insoluto a la Compra para limpiar valores a la misma
        Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                      ,Reg_Val_Out.RegDes
                      ,Reg_Val_In.dFechaEmision
                      ,Reg_Val_In.dFechaCompra
                      ,Reg_Val_In.dFechaCompra   //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                      ,Reg_Val_Out.Nominales
                      ,Reg_Val_Out.Array_Mem_Desarr
                      ,False
                      ,fSaldo_Insoluto_Cpa
                      ,fSaldo_Insoluto_Cpa_ConRea
                      ,Modulo_Err
                      ,String_Err
                      ,Result);

        if NOT Result then
        begin
           String_Err := sTipo_Valuac+': '+String_Err;
           exit;
        end;

         // Se limpian el valor invertido de la compra (se asume que es el vigente proporcional)
         if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            Limpia_Valores(sEmpresa_Usuario
                          ,''              // La cartera no la estoy usando ... Pendiente eliminar el parametro
                          ,''              // sTransaccion_Compra
                          ,Reg_Val_In.dFechaCompra
                          ,Reg_Val_In.Tipo_Instrumento
                          ,Reg_Val_In.sEmisor
                          ,Reg_Val_In.sInstrumento
                          ,Reg_Val_In.sSerie
                          ,Reg_Val_In.Nemotecnico
                          ,Reg_Val_In.dTasaEmision
                          ,Reg_Val_Out.RegDes.Tasa_Efectiva
                          ,Reg_Val_In.sUnidadMonetaria
                          ,Reg_Val_In.sTipoNominales
                          ,Reg_Val_In.dFechaEmision
                          ,Reg_Val_In.dFechaVencimiento
                          ,Reg_Val_In.dFechaCompra
                          ,Reg_Val_In.dFechaPago
                          ,Reg_Val_In.sUnidadMonetaria // Reg_Val_In.sMoneda_Conversion
                          ,Reg_Val_In.fCupones_Cortados
                          ,sTipo_Reajuste
                          ,fSaldo_Insoluto_Cpa_ConRea
                          ,Reg_Val_Out.Nominales
                          ,Reg_Val_In.Tabla_Desarr_Cargada
                          ,Reg_Val_Out.RegDes
                          ,Reg_Val_Out.Array_Mem_Desarr
                          ,dFecha_Desde
                          ,Reg_Val_In.dFechaCompra
                          ,Reg_Val_Out.ValorInvertidoUM
                          ,fValor_Compra_Clean_UM
                          ,fValor_Clean_UM_Rea
                          ,Modulo_Err
                          ,String_Err
                          ,Result)
         else
            Limpia_Valores_Vig(sEmpresa_Usuario
                              ,''              // La cartera no la estoy usando ... Pendiente eliminar el parametro
                              ,''              // sTransaccion_Compra
                              ,Reg_Val_In.dFechaCompra
                              ,Reg_Val_In.Tipo_Instrumento
                              ,Reg_Val_In.sEmisor
                              ,Reg_Val_In.sInstrumento
                              ,Reg_Val_In.sSerie
                              ,Reg_Val_In.dFecha_Vig
                              ,Reg_Val_In.Nemotecnico
                              ,Reg_Val_In.dTasaEmision
                              ,Reg_Val_Out.RegDes.Tasa_Efectiva
                              ,Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sTipoNominales
                              ,Reg_Val_In.dFechaEmision
                              ,Reg_Val_In.dFechaVencimiento
                              ,Reg_Val_In.dFechaCompra
                              ,Reg_Val_In.dFechaPago
                              ,Reg_Val_In.sUnidadMonetaria //Reg_Val_In.sMoneda_Conversion
                              ,Reg_Val_In.fCupones_Cortados
                              ,sTipo_Reajuste
                              ,fSaldo_Insoluto_Cpa_ConRea
                              ,Reg_Val_Out.Nominales
                              ,Reg_Val_In.Tabla_Desarr_Cargada
                              ,Reg_Val_Out.RegDes
                              ,Reg_Val_Out.Array_Mem_Desarr
                              ,dFecha_Desde
                              ,Reg_Val_In.dFechaCompra
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,fValor_Compra_Clean_UM
                              ,fValor_Clean_UM_Rea
                              ,Modulo_Err
                              ,String_Err
                              ,Result);

         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

         // Determino Inc/Dec Lineal
         Calculo_de_dias(Reg_Val_In.dFechaCompra,
                         Reg_Val_In.dFechaVencimiento,
                         'EXACTOS',
                         sPais_Tasa,
                         fDif_Dias,
                         iAnosEnteros,
                         iAnosFraccion,
                         iMesesEnteros);

        if fDif_Dias <> 0 then
          fDif_Precio := (fSaldo_Insoluto_Cpa - fValor_Compra_Clean_UM) / fDif_Dias
        else
          fDif_Precio := 0;

        Calculo_de_dias(Reg_Val_In.dFechaCompra,
                        Reg_Val_In.dFechaCalculo,
                        'EXACTOS',
                        sPais_Tasa,
                        fDif_Dias,
                        iAnosEnteros,
                        iAnosFraccion,
                        iMesesEnteros);

         // Entre Compra y Calculo ....
         // ESTA EN UM !!!!
         fIncrease_Decrease_Total :=  fDif_Precio *
                                      fDif_Dias;

         Reg_Val_Out.ValorInvertidoUM := fValor_Compra_Clean_UM;

         /// Busca Amortizaciones y/o Capitalizaciones desde la compra
         Amortizacion_Periodo(Reg_Val_In.sInstrumento
                             ,Reg_Val_In.Tipo_Instrumento
                             ,'' // El parametro cartera no lo esta utilizando HAY QUE ELIMINARLO 08-07-2009
                             ,Reg_Val_Out.RegDes
                             ,Reg_Val_In.dFechaCompra
                             ,Reg_Val_In.dFechaCalculo
                             ,Reg_Val_In.dFechaCompra
                             ,Reg_Val_In.dFechaEmision
                             ,Reg_Val_Out.Nominales
                             ,Reg_Val_Out.Nominales
                             ,Reg_Val_In.sUnidadMonetaria
                             ,Reg_Val_In.sUnidadMonetaria // Reg_Val_In.sMoneda_Conversion (No es necesaria la conversión)
                             ,sEmpresa_Usuario
                             ,'' // sTransaccion_Compra        // No se informan los datros de la compra
                             ,'' // sFolio_Compra              // ya que esta funcion los utiliza para determinar
                             ,0  // sItem_Omd_Compra           // el nominal vigente en cada corte, cosa que nos necesaria en este caso ya que se requieren solo los valores con los nominales vigentes 08-07-2009 F.I.
                             ,Reg_Val_Out.Array_Mem_Desarr
                             ,fMonto_Amort_a_la_CPA_UM
                             ,fMonto_Amort_a_la_CPA_MC
                             ,fReajuste_Indexado_Amort_a_la_CPA
                             ,fReajuste_No_Indexado_Amort_a_la_CPA
                             ,fMonto_Amort_Pagado_UM
                             ,fMonto_Amort_Pagado_MC
                             ,fReajuste_Indexado_Amort_Pagado
                             ,fReajuste_No_Indexado_Amort_Pagado
                             ,fMonto_Capitalizado_UM
                             ,fMonto_Capitalizado_MC
                             ,fReajuste_Indexado_Capitalizado
                             ,fReajuste_No_Indexado_Capitalizado
                             ,fDiferencia_TC_Amort_Cupon
                             ,fDiferencia_TC_Amort_Cupon_Pagado
                             ,fDiferencia_TC_Capit_Cupon

                             ,fProporcion_ActualCost_SalInsol
                             ,fMonto_Amort_Actual_Cost_A_CPA_UM         ///ESTAS SON A LA CPA
                             ,fMonto_Amort_Actual_Cost_A_CPA_MC         ///ESTAS SON A LA CPA
                             ,fReajuste_Indexado_Actual_Cost_A_CPA      ///ESTAS SON A LA CPA
                             ,fReajuste_No_Indexado_Actual_Cost_A_CPA   ///ESTAS SON A LA CPA
                             ,fDiferencia_TC_Actual_Cost_A_CPA          ///ESTAS SON A LA CPA

                             ,Modulo_Err
                             ,String_Err
                             ,Result);

         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

         // Actual Cost + Capitalizado - amortizado.
         Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                         fMonto_Capitalizado_UM -
                                         fMonto_Amort_Pagado_UM;


         if (sTipo_Valuac = 'AC+INT+PL') then
         begin
            ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                                  ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                                  ,Reg_Val_Out.Array_Mem_Desarr
                                  ,Reg_Val_Out.RegDes
                                  ,Reg_Val_In.Con_Cupon
                                  ,iNro_Cupon         // traia el 74
                                  ,dFecha_Desde
                                  ,Modulo_Err
                                  ,String_Err
                                  ,Result);
            if NOT Result then
            begin
               String_Err := sTipo_Valuac+': '+String_Err;
               exit;
            end;

            // Se comenta con fecha 07-11-2011 Confirmado por Mariano Calviello  F.I.
            //if (dFecha_Desde < Reg_Val_In.dFechaCompra) then
            //   dFecha_Desde := Reg_Val_In.dFechaCompra;

            if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
               Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                                   ,Reg_Val_In.sEmisor
                                   ,Reg_Val_In.sInstrumento
                                   ,Reg_Val_In.sSerie
                                   ,Reg_Val_In.Nemotecnico
                                   ,Reg_Val_In.dTasaEmision
                                   ,Reg_Val_Out.TasaCalculo
                                   ,Reg_Val_In.sUnidadMonetaria
                                   ,Reg_Val_In.sTipoNominales
                                   ,Reg_Val_In.dFechaEmision
                                   ,Reg_Val_In.dFechaVencimiento
                                   //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                   //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                   ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                   ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                   ,Reg_Val_In.dFechaPago
                                   ,Reg_Val_In.sUnidadMonetaria //Reg_Val_In.sMoneda_Conversion
                                   ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                   ,Reg_Val_Out.Nominales
                                   ,dFecha_Desde                 // Fecha Desde
                                   ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                   ,Reg_Val_In.Descriptor_Cargado
                                   ,Reg_Val_In.Tabla_Desarr_Cargada
                                   ,Reg_Val_Out.RegDes
                                   ,Reg_Val_Out.Array_Mem_Desarr
                                   ,fInteres_Acum_UM
                                   ,fInteres_Acum_MC
                                   ,fInteres_Acum_UM_REAJUSTADO
                                   ,fReajuste_Indexado
                                   ,fAjuste_Reajuste_Indexado
                                   ,fReajuste_NO_Indexado
                                   ,Modulo_Err
                                   ,String_Err
                                   ,Result)
            else
            begin
   //            Reg_Val_In.dFecha_Vig      := dFecha_Vig;
               Intereses_Acumulados_Vig(Reg_Val_In.Tipo_Instrumento
                                       ,Reg_Val_In.sEmisor
                                       ,Reg_Val_In.sInstrumento
                                       ,Reg_Val_In.sSerie
                                       ,Reg_Val_In.dFecha_Vig
                                       ,Reg_Val_In.Nemotecnico
                                       ,Reg_Val_In.dTasaEmision
                                       ,Reg_Val_Out.TasaCalculo
                                       ,Reg_Val_In.sUnidadMonetaria
                                       ,Reg_Val_In.sTipoNominales
                                       ,Reg_Val_In.dFechaEmision
                                       ,Reg_Val_In.dFechaVencimiento
                                       //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                       //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                       ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                       ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                       ,Reg_Val_In.dFechaPago
                                       ,Reg_Val_In.sUnidadMonetaria //Reg_Val_In.sMoneda_Conversion
                                       ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                       ,Reg_Val_Out.Nominales
                                       ,dFecha_Desde                 // Fecha Desde
                                       ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                       ,Reg_Val_In.Tabla_Desarr_Cargada
                                       ,Reg_Val_Out.RegDes
                                       ,Reg_Val_Out.Array_Mem_Desarr
                                       ,fInteres_Acum_UM
                                       ,fInteres_Acum_MC
                                       ,fInteres_Acum_UM_REAJUSTADO
                                       ,fReajuste_Indexado
                                       ,fAjuste_Reajuste_Indexado
                                       ,fReajuste_NO_Indexado
                                       ,Modulo_Err
                                       ,String_Err
                                       ,Result);
            end;
            if NOT Result then
            begin
               String_Err := sTipo_Valuac+': '+String_Err;
               exit;
            end;

            // Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM + fInteres_Acum_UM_REAJUSTADO;
            // Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM + fInteres_Acum_UM;

            // 07/08/2013 F.I.
            if sTipo_Reajuste = 'Reajustes_Sobre_Capital_Residual' then
               Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM + fInteres_Acum_UM_REAJUSTADO
            else
               Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM + fInteres_Acum_UM;
         end;

         Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                         fIncrease_Decrease_Total;

         // Aplica reajuste Se agrega condicion para Capital Residual 07/08/2013 F.I.
        if sTipo_Reajuste = 'Reajustes_Sobre_Capital_Residual' then
        begin
          // Saldo Insoluto al calculo
          // Se necesita oara calcular el reajuste capital residual
          Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                        ,Reg_Val_Out.RegDes
                        ,Reg_Val_In.dFechaEmision
                        ,Reg_Val_In.dFechaCalculo
                        ,Reg_Val_In.dFechaCompra    //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                        ,Reg_Val_Out.Nominales
                        ,Reg_Val_Out.Array_Mem_Desarr
                        ,False
                        ,fSaldo_Insoluto_Sin_Rea
                        ,fSaldo_Insoluto
                        ,Modulo_Err
                        ,String_Err
                        ,Result);

          if NOT Result then
          begin
             String_Err := sTipo_Valuac+': '+String_Err;
             exit;
          end;

          Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                         (fSaldo_Insoluto - fSaldo_Insoluto_Sin_Rea);
        end
        else
        begin
           // NO LO NECESITO EN MC POR ESO PUSE MONEDA INSTRUMENTO MONEDA INSTRUMENTO
           Reajuste_Valor(Reg_Val_In.sInstrumento
                         ,Reg_Val_In.sUnidadMonetaria
                         ,Reg_Val_In.sUnidadMonetaria
                         ,Reg_Val_In.dFechaCompra    // Fecha Desde
                         ,Reg_Val_In.dFechaCalculo    // Fecha Hasta
                         ,Reg_Val_Out.ValorInvertidoUM
                         ,Reg_Val_In.dFechaCompra
                         ,Reg_Val_In.dFechaEmision
                         ,Reg_Val_Out.RegDes
                         ,False             // bConCupon Se incorpora 05-07-2006
                         ,Reg_Val_Out.Array_Mem_Desarr
                         ,sCod_Indice_Reajuste
                         ,fReajuste_Index_Acumulado
                         ,fReajuste_NoIndex_Acumulado_UM
                         ,fReajuste_NoIndex_Acumulado
                         ,Reg_Val_Out.ValorInvertidoUM
                         ,fDiferencia_tipo_cambio
                         ,Modulo_Err
                         ,String_Err
                         ,Result                                   );

           if NOT Result then
           begin
              String_Err := sTipo_Valuac+': '+String_Err;
              exit;
           end;
        end;

         // Calculo de la TIR para el nuevo valor
         Reg_Val_In.dFechaCalculo           := Reg_Val_In.dFechaCalculo;
         Reg_Val_In.dFechaCalculoOriginal   := Reg_Val_In.dFechaCalculo;
         Reg_Val_In.Valoriza_Par_Pte        := 'TIR';
         Reg_Val_In.sValor_Cupon_Original   := 'N';
         Reg_Val_In.sComponentes_Descuento  := '';
        // Se guarda la moneda de conversión original, ya
        // que los calculos iniciales se deben hacer en la
        // moneda del instrumento 20-07-2009 F.I.
        sAux_Moneda_Conversion := Reg_Val_In.sMoneda_Conversion;
        fAux_Valor_Invertido_UM := Reg_Val_Out.ValorInvertidoUM;
        Reg_Val_In.sMoneda_Conversion := Reg_Val_In.sUnidadMonetaria;

         Valoriza_Registro(Reg_Val_In,
                           Reg_Val_Out,
                           Modulo_Err,
                           String_Err,
                           Result);

         if not Result then
         begin
            Reg_Val_In.sComponentes_Descuento  := '';
            Reg_Val_In.sValor_Cupon_Original   := '';
            Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
            String_Err := sTipo_Valuac+' (TIR): '+String_Err;
            Reg_Val_Out.Rate_Used_Valuacion := 99;
            // Aun cuando no encontro la tasa recupera el valor calculado !!!! F.I. 06-03-2015
            Reg_Val_Out.ValorInvertidoUM := fAux_Valor_Invertido_UM;
         end
         else
           Reg_Val_Out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;

         Reg_Val_In.sMoneda_Conversion := sAux_Moneda_Conversion;
         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sMoneda_Conversion
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;


      exit;  // ggarcia 14-06-2013

    end;
    //--------------------------------------------------------------------------
    // PRECMERC   : Precio de Mercado * Saldo Insoluto
    // KINTERES   : Precio de Mercado * Saldo Insoluto + Interes Devengado
    // PRECNOMINT : Precio de Mercado * Nominales      + Interes Devengado
    // KINTERESNR : Precio de Mercado * Saldo Insoluto Sin Reajustes + Interes Devengado
    //--------------------------------------------------------------------------
    if (sTipo_Valuac = 'PRECMERC')   OR
       (sTipo_Valuac = 'PRECMERCNR') OR  // Capital Residual (sin Reajuste) + Precio
       (sTipo_Valuac = 'PRECNOMINT') OR  // Precio de Mercado * Nominales + Interes Devengado
       (sTipo_Valuac = 'PRENOMINTR') OR  // (Nominales * Precio) + Interes + Reajuste Capital
       (sTipo_Valuac = 'PRENOM+REA') OR  // (Nominales * Precio) + Reajuste Capital
       (sTipo_Valuac = 'KINTERES')   OR
       (sTipo_Valuac = 'KINTERESNR') OR
       (sTipo_Valuac = 'KNR+INT+RE') OR  // Capital Residual (sin Reajuste) + Intereses + Reajuste Capital
       (sTipo_Valuac = 'KNR+REACAP') OR  // Capital Residual (sin Reajuste) + Reajuste Capital
       (sTipo_Valuac = 'PX-CLEAN-O') OR
       (sTipo_Valuac = 'VPM-LIMPIO') OR
       (sTipo_Valuac = 'VPMSR-LIM') OR   // Capital Residual Sin Reajuste * Precio - Intereses
       (sTipo_Valuac = 'KSCNRMER+I') OR  // saldo insoluto sin capitalizacion y sin reajuste por precio mercado + Int
       (sTipo_Valuac = 'KSCNRMER-I') OR  // saldo insoluto sin capitalizacion y sin reajuste por precio mercado - Int
       (sTipo_Valuac = 'PREMERNRNC') OR  // saldo insoluto sin capitalizacion y sin reajuste por precio mercado
       (sTipo_Valuac = 'PX-DIRTY-O') then
       begin
         if (FloatToStr(fBase_Precio) = '') or
            (fBase_Precio <= 0)    then
            begin
              Modulo_Err := 'Valuación de Instrumentos';
              String_Err := sTipo_Valuac+': Error en definición de Base para Valuacìón de :'
                           +' Emisor      : '+Reg_Val_In.sEmisor
                           +' Instrumento : '+Reg_Val_In.sInstrumento
                           +' Serie       : '+Reg_Val_In.sSerie;
              Result := False;
              exit;
            end;

         // Para "PX-CLEAN-O" y "PX-DIRTY-O" Utilicio el precio que ingresaron en la OMD
         // por lo cual no tengo que leer precios de mercado
         if (sTipo_Valuac <> 'PX-CLEAN-O') AND
            (sTipo_Valuac <> 'PX-DIRTY-O') AND
            (Reg_Val_In.Proceso_Valuacion <> 'OMD_P_CLEA') AND
            (Reg_Val_In.Proceso_Valuacion <> 'OMD_P_DIRT') then
         begin
            bExiste_Precio_Mdo := lee_precio_mercado(Reg_Val_In.Nemotecnico
                                                    ,Reg_Val_In.dFechaCalculo
                                                    ,False
                                                    ,Reg_val_out.Origen
                                                    ,fValor
                                                    ,sTipo_TasPre);

            if NOT bExiste_Precio_Mdo then
            begin
              lee_proy_precio( Reg_Val_In.Tipo_Proceso
                              ,Reg_Val_In.Nemotecnico
                              ,'QS_FIN_PREC_MERCAD'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_val_out.Origen
                              ,fValor
                              ,sTipo_TasPre
                              ,Result
                             );
              if Not Result then
              begin
                 Modulo_Err := 'Valuación de Instrumentos';
                 String_Err := sTipo_Valuac+': No se encontro Precio de Mercado para :'
                              +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                              +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo)
                              +' ('+Reg_val_out.Origen+')';
                 exit;
              end;
            end;
         end;

         if (sTipo_Valuac = 'PX-CLEAN-O') OR
            (Reg_Val_In.Proceso_Valuacion = 'OMD_P_CLEA') then
            fValor := Reg_Val_Out.Precio_Limpio;

         if (sTipo_Valuac = 'PX-DIRTY-O') OR
            (Reg_Val_In.Proceso_Valuacion = 'OMD_P_DIRT') then
             fValor := Reg_Val_Out.Precio_Sucio;

         Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;
         Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
         Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
         Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
         Registro_Fechas.Fecha_Pago        := Reg_Val_In.dFechaPago;


     if ((Reg_Val_Out.RegDes.Tasa_Flotante = 'S') and (NOT Reg_Val_Out.RegDes.bSin_Tasa_en_Flujos)) or
        ((Reg_Val_Out.RegDes.Variacion_Cambiaria) and (NOT (Reg_Val_In.sValor_Cupon_Original = 'S'))) then
        if (Reg_Val_Out.RegDes.Fecha_Carga_Array_Mem <> Reg_Val_In.dFechaCalculo) then
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO'
        else
           if VarCamb_Depende_de_Operacion_Mem( Reg_Val_In.sEmisor                  // 09-11-2015 Se agrega para que cuando la tabla de desarrollo depende de la fechga de la operacion la cargue siempre
                                               ,Reg_Val_In.sInstrumento
                                               ,Reg_Val_In.sSerie)  then
            Reg_Val_In.Tabla_Desarr_Cargada := 'NO';

         if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
         begin
            Carga_RegDes(Reg_Val_In.Tipo_Instrumento
                        ,Reg_Val_In.sEmisor
                        ,Reg_Val_In.sEmisor
                        ,Reg_Val_In.sInstrumento
                        ,Reg_Val_In.sSerie
                        ,Reg_Val_In.sMoneda_Conversion
                        ,Reg_Val_In.dTasaEmision
                        ,Reg_Val_Out.RegDes
                        ,Modulo_Err
                        ,String_Err
                        ,Result);
             if NOT Result then
             begin
                String_Err := sTipo_Valuac+': '+String_Err;
                exit;
             end;
             Reg_Val_In.Descriptor_Cargado := 'SI';

             if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                               ,Reg_Val_In.sEmisor
                               ,Reg_Val_In.sInstrumento
                               ,Reg_Val_In.sSerie
                               ,Reg_Val_In.Nemotecnico
                               ,Reg_Val_In.sTipoNominales
                               ,Reg_Val_Out.Nominales
                               ,Reg_Val_In.dTasaEmision
                               ,Reg_Val_In.dFechaEmision
                               ,Reg_Val_In.dFechaVencimiento
                               ,Reg_Val_In.dFechaCalculo
                               ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                               ,Reg_Val_In.Con_Cupon
                               ,Reg_Val_Out.Array_Mem_Desarr
                               ,Reg_Val_Out.RegDes
                               ,Registro_Fechas
                               ,sMetodo_Sin_Tasa_Referencia
                               ,Parametros_Formula
                               ,Modulo_Err
                               ,String_Err
                               ,Result)
             else
                Carga_TabDesarr_Vig(Reg_Val_In.Tipo_Instrumento
                                   ,Reg_Val_In.sEmisor
                                   ,Reg_Val_In.sInstrumento
                                   ,Reg_Val_In.sSerie
                                   ,Reg_Val_In.dFecha_Vig
                                   ,Reg_Val_In.Nemotecnico
                                   ,Reg_Val_In.sTipoNominales
                                   ,Reg_Val_Out.Nominales
                                   ,Reg_Val_In.dTasaEmision
                                   ,Reg_Val_In.dFechaEmision
                                   ,Reg_Val_In.dFechaVencimiento
                                   ,Reg_Val_In.dFechaCalculo
                                   ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                                   ,Reg_Val_In.Con_Cupon
                                   ,Reg_Val_Out.Array_Mem_Desarr
                                   ,Reg_Val_Out.RegDes
                                   ,Registro_Fechas
                                   ,sMetodo_Sin_Tasa_Referencia
                                   ,Parametros_Formula
                                   ,Modulo_Err
                                   ,String_Err
                                   ,Result);

            if NOT Result then
            begin
               String_Err := sTipo_Valuac+': '+String_Err;
               exit;
            end;
            Reg_Val_In.Tabla_Desarr_Cargada := 'SI'
         end;

         Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                       ,Reg_Val_Out.RegDes
                       ,Reg_Val_In.dFechaEmision
                       ,Reg_Val_In.dFechaCalculo
                       ,Reg_Val_In.dFechaCompra    //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                       ,Reg_Val_Out.Nominales
                       ,Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_In.Con_Cupon  //False
                       ,fSaldo_Insoluto_Sin_Rea
                       ,fSaldo_Insoluto
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

         fReajuste_Capital := fSaldo_Insoluto - fSaldo_Insoluto_Sin_Rea;

         Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
         Reg_Val_Out.Rate_Used_Valuacion   := fValor;
         if sTipo_TasPre <> '' then
            Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;


         if (sTipo_Valuac = 'KINTERESNR') OR
            (sTipo_Valuac = 'KNR+INT+RE') OR  // Capital Residual (sin Reajuste) + Intereses + Reajuste Capital
            (sTipo_Valuac = 'KNR+REACAP') OR  // Capital Residual (sin Reajuste) + Reajuste Capital
            (sTipo_Valuac = 'PRECMERCNR') OR
            (sTipo_Valuac = 'VPMSR-LIM') Then
            Reg_Val_Out.ValorInvertidoUM := (fSaldo_Insoluto_Sin_Rea *
                                             fValor) /
                                             fBase_Precio
         else
         if (sTipo_Valuac = 'PRECNOMINT') OR
            (sTipo_Valuac = 'PRENOMINTR') OR     // (Nominales * Precio) + Interes + Reajuste Capital
            (sTipo_Valuac = 'PRENOM+REA') THEN   // (Nominales * Precio) + Reajuste Capital
            Reg_Val_Out.ValorInvertidoUM := (Reg_Val_Out.Nominales *
                                             fValor) /
                                             fBase_Precio
         else
            If (sTipo_Valuac = 'KSCNRMER+I') OR (sTipo_Valuac = 'KSCNRMER-I') OR (sTipo_Valuac = 'PREMERNRNC') Then
            begin
                fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste := 0;
                fSaldo_Insoluto_Sin_Capitalizacion              := 0;
                Saldo_Insoluto_Sin_Capitalizacion(Reg_Val_In.Tipo_Instrumento
                              ,Reg_Val_Out.RegDes
                              ,Reg_Val_In.dFechaEmision
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.Nominales
                              ,Reg_Val_Out.Array_Mem_Desarr
                              ,Reg_Val_In.Con_Cupon  //False
                              ,fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste
                              ,fSaldo_Insoluto_Sin_Capitalizacion
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
                if NOT Result then
                begin
                   String_Err := sTipo_Valuac+': '+String_Err;
                   exit;
                end;


               Reg_Val_Out.ValorInvertidoUM := (fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste *
                                                fValor) /
                                                fBase_Precio;

            end
            else
               Reg_Val_Out.ValorInvertidoUM := (fSaldo_Insoluto *
                                                fValor) /
                                                fBase_Precio;

         if (sTipo_Valuac = 'KINTERES')   OR
            (sTipo_Valuac = 'KNR+INT+RE') OR  // Capital Residual (sin Reajuste) + Intereses + Reajuste Capital
            (sTipo_Valuac = 'PRENOMINTR') OR  // (Nominales * Precio) + Interes + Reajuste Capital
            (sTipo_Valuac = 'PRECNOMINT') OR
            (sTipo_Valuac = 'KINTERESNR') OR
            (sTipo_Valuac = 'KSCNRMER+I') OR
            (sTipo_Valuac = 'PX-CLEAN-O') then
         begin
             ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                                   ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                                   ,Reg_Val_Out.Array_Mem_Desarr
                                   ,Reg_Val_Out.RegDes
                                   ,Reg_Val_In.Con_Cupon
                                   ,iNro_Cupon
                                   ,dFecha_Desde
                                   ,Modulo_Err
                                   ,String_Err
                                   ,Result);
             if NOT Result then
             begin
                String_Err := sTipo_Valuac+': '+String_Err;
                exit;
             end;

             Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                                 ,Reg_Val_In.sEmisor
                                 ,Reg_Val_In.sInstrumento
                                 ,Reg_Val_In.sSerie
                                 ,Reg_Val_In.Nemotecnico
                                 ,Reg_Val_In.dTasaEmision
                                 ,Reg_Val_Out.TasaCalculo
                                 ,Reg_Val_In.sUnidadMonetaria
                                 ,Reg_Val_In.sTipoNominales
                                 ,Reg_Val_In.dFechaEmision
                                 ,Reg_Val_In.dFechaVencimiento
                                 //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                 //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                 ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                 ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                 ,Reg_Val_In.dFechaPago
                                 ,Reg_Val_In.sMoneda_Conversion
                                 ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                 ,Reg_Val_Out.Nominales
                                 ,dFecha_Desde                 // Fecha Desde
                                 ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                 ,Reg_Val_In.Descriptor_Cargado
                                 ,Reg_Val_In.Tabla_Desarr_Cargada
                                 ,Reg_Val_Out.RegDes
                                 ,Reg_Val_Out.Array_Mem_Desarr
                                 ,fInteres_Acum_UM
                                 ,fInteres_Acum_MC
                                 ,fInteres_Acum_UM_REAJUSTADO
                                 ,fReajuste_Indexado
                                 ,fAjuste_Reajuste_Indexado
                                 ,fReajuste_NO_Indexado
                                 ,Modulo_Err
                                 ,String_Err
                                 ,Result);
             if NOT Result then
             begin
                String_Err := sTipo_Valuac+': '+String_Err;
                exit;
             end;


             Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                             fInteres_Acum_UM_REAJUSTADO;
          end;  // KINTERES

         if (sTipo_Valuac = 'KNR+INT+RE') OR     // Capital Residual (sin Reajuste) + Intereses + Reajuste Capital
            (sTipo_Valuac = 'PRENOMINTR') OR     // (Nominales * Precio) + Interes + Reajuste Capital
            (sTipo_Valuac = 'KNR+REACAP') OR     // Capital Residual (sin Reajuste) + Reajuste Capital
            (sTipo_Valuac = 'PRENOM+REA') THEN   // (Nominales * Precio) + Reajuste Capital
            Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                            fReajuste_Capital;

         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,Reg_Val_In.sMoneda_Conversion
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.ValorInvertidoMC
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;

         Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoUM);

         Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoMC);

         If (sTipo_Valuac = 'VPM-LIMPIO') OR (sTipo_Valuac = 'VPMSR-LIM') OR (sTipo_Valuac = 'KSCNRMER-I') then
         Begin
            Limpia_Valor_Interes(Reg_Val_In,
                           Reg_Val_Out,
                           Modulo_Err,
                           String_Err,
                           Result);
            if Not Result then
            begin
               Modulo_Err := 'Valuación de Instrumentos';
               String_Err := sTipo_Valuac+': Problemas con Limpiar el Valor de Mercado :'
                            +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                            +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo);
               exit;
            end;
         end;



         exit;  // ggarcia 14-06-2013

       end;
    //--------------------------------------------------------------------------
    // Valuacion por Precio de Titulo
    //--------------------------------------------------------------------------
    if (sTipo_Valuac = 'PRECTITULO') OR
       (sTipo_Valuac = 'PRECTIT+i')  OR  // Precio por titulo mas intereses devengados 13-12-2012
       (sTipo_Valuac = 'VPT-LIMPIO') then
       begin
         if (String.IsNullOrEmpty(sMon_Ind)) or
            (sMon_Ind = '')    then
            begin
              Modulo_Err := 'Valuación de Instrumentos';
              String_Err := sTipo_Valuac+': Error en definición de Moneda / Indice en metodo de valuación para :'
                           +' Emisor      : '+Reg_Val_In.sEmisor
                           +' Instrumento : '+Reg_Val_In.sInstrumento
                           +' Serie       : '+Reg_Val_In.sSerie;
              Result := False;
              exit;
            end;

            if (Reg_Val_In.Numero_Titulos <= 0) then
            begin
              Modulo_Err := 'Valuación de Instrumentos';
              String_Err := sTipo_Valuac+': Numero de Títulos inconsistente para : '+Reg_Val_In.Nemotecnico + ', verifique';
//              String_Err := sTipo_Valuac+': No existe numero de titulos para: '+Reg_Val_In.Nemotecnico;
              {
                           +' Emisor      : '+Reg_Val_In.sEmisor
                           +' Instrumento : '+Reg_Val_In.sInstrumento
                           +' Serie       : '+Reg_Val_In.sSerie;
              }
              Result := False;
              exit;
            end;

            // Para Reg_Val_In.Proceso_Valuacion = 'OMD_P_CLEA' o
            //      Reg_Val_In.Proceso_Valuacion = 'OMD_P_DIRT' o
            //      sTipo_Valuac = 'PX-CLEAN-O') o
            //      sTipo_Valuac = 'PX-DIRTY-O')
            // Debo usar el precio indicado en la OMD
            // por lo cual no tengo hay que leer los precios de la tabla
            if (Reg_Val_In.Proceso_Valuacion <> 'OMD_P_CLEA') AND
               (Reg_Val_In.Proceso_Valuacion <> 'OMD_P_DIRT') then
            begin
                fValor := lee_precio_titulo(Reg_Val_In.Nemotecnico
                                           ,Reg_Val_In.dFechaCalculo
                                           ,Reg_val_out.Origen
                                           ,False);

                if fValor = 0 then
                begin
                  lee_proy_precio( Reg_Val_In.Tipo_Proceso
                                  ,Reg_Val_In.Nemotecnico
                                  ,'QS_FIN_PREC_TITULO'
                                  ,Reg_Val_In.dFechaCalculo
                                  ,Reg_val_out.Origen
                                  ,fValor
                                  ,sTipo_TasPre
                                  ,Result
                                 );
                  if Not Result then
                  begin
                     Modulo_Err := 'Valuación de Instrumentos';
                     String_Err := sTipo_Valuac+': No se encontro Precio por Titulo para :'
                                  +' Nemotecnico: '+Reg_Val_In.Nemotecnico
                                  +' Con Fecha: '+DatetoStr(Reg_Val_In.dFechaCalculo)
                                  +' ('+Reg_val_out.Origen+')';
                     Result := False;
                     exit;
                  end;
                end;
            end
            else
            begin
               if (Reg_Val_In.Proceso_Valuacion = 'OMD_P_CLEA') then
               begin
                  fValor       := Reg_Val_Out.Precio_Limpio;
                  sTipo_Valuac := 'PRECTIT+i';   // La razon de cambiar el tipo de valuacion es para que le sume los intereses ya que es precio limpio
               end;

               if (Reg_Val_In.Proceso_Valuacion = 'OMD_P_DIRT') then
               begin
                  fValor       := Reg_Val_Out.Precio_Sucio;
                  sTipo_Valuac := 'PRECTITULO'; // La razon de cambiar el tipo de valuacion es para que NO le sume los intereses ya que es precio sucio
               end;
            end;

         if fBase_Precio = 0 then
            fBase_Precio := 1;

         Reg_Val_Out.ValorInvertidoUM := (Reg_Val_In.Numero_Titulos *
                                          fValor) / fBase_Precio;    // 30-11-2012 Se incluye la base en precio por titulo

         Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
         Reg_Val_Out.Rate_Used_Valuacion   := fValor;
         if sTipo_TasPre <> '' then
            Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;

         if (sMon_Ind <> Reg_Val_In.sUnidadMonetaria) then
         begin
           Conversion_unidad_mon(sMon_Ind
                                ,Reg_Val_In.sUnidadMonetaria
                                ,'BC'
                                ,Reg_Val_In.dFechaCalculo
                                ,Reg_Val_Out.ValorInvertidoUM
                                ,Reg_Val_Out.ValorInvertidoUM
                                ,Modulo_Err
                                ,String_Err
                                ,Result);
           if NOT Result then
           begin
              String_Err := sTipo_Valuac+': '+String_Err;
              exit;
           end;
         end;

         // Nuevo 13-12-2012
         if (sTipo_Valuac = 'PRECTIT+i') then
         begin
             ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                                   ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                                   ,Reg_Val_Out.Array_Mem_Desarr
                                   ,Reg_Val_Out.RegDes
                                   ,Reg_Val_In.Con_Cupon
                                   ,iNro_Cupon
                                   ,dFecha_Desde
                                   ,Modulo_Err
                                   ,String_Err
                                   ,Result);
             if NOT Result then
             begin
                String_Err := sTipo_Valuac+': '+String_Err;
                exit;
             end;

             Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                                 ,Reg_Val_In.sEmisor
                                 ,Reg_Val_In.sInstrumento
                                 ,Reg_Val_In.sSerie
                                 ,Reg_Val_In.Nemotecnico
                                 ,Reg_Val_In.dTasaEmision
                                 ,Reg_Val_Out.TasaCalculo
                                 ,Reg_Val_In.sUnidadMonetaria
                                 ,Reg_Val_In.sTipoNominales
                                 ,Reg_Val_In.dFechaEmision
                                 ,Reg_Val_In.dFechaVencimiento
                                 //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                 //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                                 ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                 ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                                 ,Reg_Val_In.dFechaPago
                                 ,Reg_Val_In.sMoneda_Conversion
                                 ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                                 ,Reg_Val_Out.Nominales
                                 ,dFecha_Desde                 // Fecha Desde
                                 ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                                 ,Reg_Val_In.Descriptor_Cargado
                                 ,Reg_Val_In.Tabla_Desarr_Cargada
                                 ,Reg_Val_Out.RegDes
                                 ,Reg_Val_Out.Array_Mem_Desarr
                                 ,fInteres_Acum_UM
                                 ,fInteres_Acum_MC
                                 ,fInteres_Acum_UM_REAJUSTADO
                                 ,fReajuste_Indexado
                                 ,fAjuste_Reajuste_Indexado
                                 ,fReajuste_NO_Indexado
                                 ,Modulo_Err
                                 ,String_Err
                                 ,Result);
             if NOT Result then
             begin
                String_Err := sTipo_Valuac+': '+String_Err;
                exit;
             end;


             Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                             fInteres_Acum_UM_REAJUSTADO;
          end;  // (sTipo_Valuac = 'PRECTIT+i')
         //
         if (Reg_Val_In.sUnidadMonetaria <> Reg_Val_In.sMoneda_Conversion) then
         begin
           Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                                ,Reg_Val_In.sMoneda_Conversion
                                ,'BC'
                                ,Reg_Val_In.dFechaCalculo
                                ,Reg_Val_Out.ValorInvertidoUM
                                ,Reg_Val_Out.ValorInvertidoMC
                                ,Modulo_Err
                                ,String_Err
                                ,Result);
           if NOT Result then
           begin

              String_Err := sTipo_Valuac+': '+String_Err;
              exit;
           end;
         end
         else
           Reg_Val_Out.ValorInvertidoMC := Reg_Val_Out.ValorInvertidoUM;

         Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoUM);

         Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoMC);


         Reg_Val_Out.Precio_Titulo := fValor;

         // Ojo en el caso de valuacion por precio de titulo
         // el valor Um y MC se devuelven en la Mon_ind especificado
         // COMENTADO POR G.G. & F.I. 26-11-2012 --> NO TIENE SENTIDO Y AFECTARA RENTABILIDAD
         //Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;

         If sTipo_Valuac = 'VPT-LIMPIO' then
         Begin
            Limpia_Valor_Interes(Reg_Val_In,
                           Reg_Val_Out,
                           Modulo_Err,
                           String_Err,
                           Result);
            if Not Result then
            begin
               Modulo_Err := 'Valuación de Instrumentos';
               String_Err := sTipo_Valuac+': Problemas con Limpiar el Valor de Mercado :'
                            +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                            +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo);
               exit;
            end;
         end;



         exit;  // ggarcia 14-06-2013

       end;
   //--------------------------------------------------------------------------
   // Valuación a Porcentaje Par
   //--------------------------------------------------------------------------
   if sTipo_Valuac = 'PORCPAR' then
   begin
      if (FloatToStr(fBase_Precio) = '') or
         (fBase_Precio <= 0)    then
      begin
         Modulo_Err := 'Valuación de Instrumentos';
         String_Err := sTipo_Valuac+': Error en definición de Base para Valuacìón de :'
                      +'Emisor      : '+Reg_Val_In.sEmisor
                      +'Instrumento : '+Reg_Val_In.sInstrumento
                      +'Serie       : '+Reg_Val_In.sSerie;
         Result := False;
         Exit;
      end;

      bExiste_Precio_Mdo := lee_precio_mercado(Reg_Val_In.Nemotecnico
                                              ,Reg_Val_In.dFechaCalculo
                                              ,False
                                              ,Reg_val_out.Origen
                                              ,fValor
                                              ,sTipo_TasPre);

      if NOT bExiste_Precio_Mdo then
      begin
         lee_proy_precio( Reg_Val_In.Tipo_Proceso
                         ,Reg_Val_In.Nemotecnico
                         ,'QS_FIN_PREC_MERCAD'
                         ,Reg_Val_In.dFechaCalculo
                         ,Reg_val_out.Origen
                         ,fValor
                         ,sTipo_TasPre
                         ,Result
                        );
         if Not Result then
         begin
            Modulo_Err := 'Valuación de Instrumentos';
            String_Err := sTipo_Valuac+': No se encontro Precio de Mercado para :'
                        +'Nemotecnico : '+Reg_Val_In.Nemotecnico
                        +'Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo)
                        +' ('+Reg_val_out.Origen+')';
            Exit;
         end;
      end;

      Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
      Reg_Val_Out.Rate_Used_Valuacion   := fValor;
      if sTipo_TasPre <> '' then
         Reg_Val_Out.Tipo_Tasa_Precio   := sTipo_TasPre;
      Reg_Val_In.Valoriza_Par_Pte := 'PAR';
      reg_val_out.PorcentajePar   := fValor;

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

      if Result then
      begin
         Reg_Val_Out.ValorInvertidoUM := (Reg_Val_Out.Valor_Par_UM *
                                          fValor) /
                                          fBase_Precio;
         Reg_Val_Out.ValorInvertidoMC := (Reg_Val_Out.Valor_Par_MC *
                                          fValor) /
                                          fBase_Precio;
      end;

      exit;  // ggarcia 14-06-2013

   end;

   //--------------------------------------------------------------------------
   // Valor a Tasa Real mas reajuste de Interes y Capital
   // Descuenta flujos originales a la tasa indicada y luego le suma el reajuste de
   // los intereses devengados a tasa de emisión y le suma el reajuste de capital
   //--------------------------------------------------------------------------
   if (sTipo_Valuac = 'T_REA+R_IK') then
   begin
       Reg_Val_In.Valoriza_Par_Pte        := 'PTE';
       Reg_Val_In.sValor_Cupon_Original   := 'S';

       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         Modulo_Err,
                         String_Err,
                         Result);

       if not Result then
       begin
          Reg_Val_In.sValor_Cupon_Original   := 'N';
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;
       Reg_Val_In.sValor_Cupon_Original   := 'N';

       ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                          ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                          ,Reg_Val_Out.Array_Mem_Desarr
                          ,Reg_Val_Out.RegDes
                          ,Reg_Val_In.Con_Cupon
                          ,iNro_Cupon
                          ,dFecha_Desde
                          ,Modulo_Err
                          ,String_Err
                          ,Result);
       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

       Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                           ,Reg_Val_In.sEmisor
                           ,Reg_Val_In.sInstrumento
                           ,Reg_Val_In.sSerie
                           ,Reg_Val_In.Nemotecnico
                           ,Reg_Val_In.dTasaEmision
                           ,Reg_Val_Out.TasaCalculo
                           ,Reg_Val_In.sUnidadMonetaria
                           ,Reg_Val_In.sTipoNominales
                           ,Reg_Val_In.dFechaEmision
                           ,Reg_Val_In.dFechaVencimiento
                           //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                           //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                           ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                           ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                           ,Reg_Val_In.dFechaPago
                           ,Reg_Val_In.sMoneda_Conversion
                           ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                           ,Reg_Val_Out.Nominales
                           ,dFecha_Desde                 // Fecha Desde
                           ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                           ,Reg_Val_In.Descriptor_Cargado
                           ,Reg_Val_In.Tabla_Desarr_Cargada
                           ,Reg_Val_Out.RegDes
                           ,Reg_Val_Out.Array_Mem_Desarr
                           ,fInteres_Acum_UM
                           ,fInteres_Acum_MC
                           ,fInteres_Acum_UM_REAJUSTADO
                           ,fReajuste_Indexado
                           ,fAjuste_Reajuste_Indexado
                           ,fReajuste_NO_Indexado
                           ,Modulo_Err
                           ,String_Err
                           ,Result);
       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

       Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                       (fInteres_Acum_UM_REAJUSTADO -
                                        fInteres_Acum_UM);


       Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                     ,Reg_Val_Out.RegDes
                     ,Reg_Val_In.dFechaEmision
                     ,Reg_Val_In.dFechaCalculo
                     ,Reg_Val_In.dFechaCompra      //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                     ,Reg_Val_Out.Nominales
                     ,Reg_Val_Out.Array_Mem_Desarr
                     ,False
                     ,fSaldo_Insoluto_Sin_Rea
                     ,fSaldo_Insoluto
                     ,Modulo_Err
                     ,String_Err
                     ,Result);

       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

       fReajuste_Capital := fSaldo_Insoluto - fSaldo_Insoluto_Sin_Rea;

       Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM +
                                       fReajuste_Capital;



       exit;  // ggarcia 14-06-2013

   end;

    //--------------------------------------------------------------------------
    // VALORPAR Valoriza a tasa de emisión 19-07-2011
    //--------------------------------------------------------------------------
    if (sTipo_Valuac = 'VALORPAR') OR
       (sTipo_Valuac = 'PAR-LIMPIO') Then
    begin
      // Almaceno fechas para recuperarlas antes de salir
      Reg_Val_Out.Tipo_Valuacion        := sTipo_Valuac;
      Reg_Val_In.Valoriza_Par_Pte := 'PAR';

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result);

      if NOT Result then
      begin
         String_Err := sTipo_Valuac+'-'+String_Err;
         exit;
      end;

      if (sTipo_Valuac = 'PAR-LIMPIO') then
      begin
          Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                        ,Reg_Val_Out.RegDes
                        ,Reg_Val_In.dFechaEmision
                        ,Reg_Val_In.dFechaCalculo
                        ,Reg_Val_In.dFechaCompra      //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                        ,Reg_Val_Out.Nominales
                        ,Reg_Val_Out.Array_Mem_Desarr
                        ,False
                        ,fSaldo_Insoluto_Sin_Rea
                        ,fSaldo_Insoluto
                        ,Modulo_Err
                        ,String_Err
                        ,Result);

          if NOT Result then
          begin
             String_Err := sTipo_Valuac+': '+String_Err;
             exit;
          end;
          Reg_Val_Out.Valor_Par_UM := fSaldo_Insoluto;
      end;

      Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.Valor_Par_UM;
      Reg_Val_Out.ValorInvertidoMC := Reg_Val_Out.Valor_Par_MC;
      // Para que retorne la tasa efectiva F.I. 10-09-2024
      Reg_Val_Out.Rate_Used_Valuacion := Reg_Val_Out.RegDes.TASA_EFECTIVA;
      exit;  // ggarcia 14-06-2013
    end;

   // ggarcia 22-10-2013
   if (sTipo_Valuac = 'FW TC+FX') OR
      (sTipo_Valuac = 'FW TC')    OR
      (sTipo_Valuac = 'FW TC-TR') Then
   begin
     // if Reg_Val_In.sInstrumento <> 'FWD' then              DC y FI 09/10/2015
      if NOT( BuscaStr(Reg_Val_In.sInstrumento,'FW-')) then
      begin
        String_Err := 'Metodo de valuación "'+sTipo_Valuac+'" no es valido para instrumento "'+Reg_Val_In.sInstrumento+'"';
        Result := False;
        exit;
      end;

      String_err := '';
      Calculo_Forward( Reg_Val_In.sInstrumento,
                       sTipo_Valuac,
                       Reg_Val_Out.Valor_Par_UM,
                       Reg_Val_In.sUnidadMonetaria,
                       Reg_Val_In.sMoneda_Conversion,
                       Reg_Val_In.dFechaCalculo ,
                       Reg_Val_In.dFechaVencimiento,
                       Reg_val_out.Origen, //Tipo de Paridad
                       Reg_Val_Out.Tipo_Cambio,
                       Reg_Val_Out.FX_Points,
                       Reg_Val_Out.Tipo_Cambio_fwd,
                       Reg_Val_Out.ValorInvertidoUM,
                       Modulo_Err,
                       String_Err,
                       Result);
      if Not Result then
         Exit;

      if (not String.IsNullOrEmpty(sFormula_Pte)) and
         (sFormula_Pte <> ''  ) then
      begin

         fAux_Posicion_Corta := Reg_Val_Out.Valor_Par_MC;

         Reg_Val_In.sMoneda_Conversion := Reg_Val_In.sUnidadMonetaria;

         Reg_Val_Out.Nominales         := Reg_Val_Out.ValorInvertidoUM;
         Reg_Val_Out.ValorInvertidoUM  := Reg_Val_Out.ValorInvertidoUM;

         Reg_Val_Out.ValorInvertidoMC  := 0;
         Reg_Val_In.Tipo_Instrumento   := 'U';
         Reg_Val_In.sTipoNominales     := 'F';

         Reg_Val_In.Valoriza_Par_Pte     := 'PTE';
         Reg_Val_Out.Tipo_Valuacion      := sTipo_Valuac;

         Reg_Val_In.Forzar_Uso_Formula_PTE := 'SI';
         Reg_Val_In.Formula_PTE            := sFormula_Pte;

         Valoriza_Registro(Reg_Val_In
                          ,Reg_Val_Out
                          ,Modulo_Err
                          ,String_Err
                          ,Result);

         if NOT Result then
         begin
            String_Err := sTipo_Valuac+' - '+trim(Reg_Val_In.Formula_PTE)+': '+String_Err;
            exit;
         end;

         Reg_Val_Out.Valor_Razonable_Pos_Larga := Reg_Val_Out.ValorInvertidoUM;


         Reg_Val_Out.Nominales         := fAux_Posicion_Corta;
         Reg_Val_Out.ValorInvertidoUM  := fAux_Posicion_Corta;

         Reg_Val_Out.ValorInvertidoMC  := 0;
         Reg_Val_In.Tipo_Instrumento   := 'U';
         Reg_Val_In.sTipoNominales     := 'F';

         Reg_Val_In.Valoriza_Par_Pte     := 'PTE';
         Reg_Val_Out.Tipo_Valuacion      := sTipo_Valuac;

         Reg_Val_In.Forzar_Uso_Formula_PTE := 'SI';
         Reg_Val_In.Formula_PTE            := sFormula_Pte;

         Valoriza_Registro(Reg_Val_In
                          ,Reg_Val_Out
                          ,Modulo_Err
                          ,String_Err
                          ,Result);

         if NOT Result then
         begin
            String_Err := sTipo_Valuac+' - '+trim(Reg_Val_In.Formula_PTE)+': '+String_Err;
            exit;
         end;

         Reg_Val_Out.Valor_Razonable_Pos_Corta := Reg_Val_Out.ValorInvertidoUM;

         //Valor Razonable
         Reg_Val_Out.ValorInvertidoUM  := Reg_Val_Out.Valor_Razonable_Pos_Larga - Reg_Val_Out.Valor_Razonable_Pos_Corta;

         Reg_Val_In.Forzar_Uso_Formula_PAR := 'NO';
         Reg_Val_In.Forzar_Uso_Formula_PTE := 'NO';
         Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;

         if Reg_Val_Out.Array_Mem_Desarr[1].Tasa_de_Descuento <> 0 then
            Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.Array_Mem_Desarr[1].Tasa_de_Descuento
         else
            Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;

         Reg_Val_Out.Array_Mem_Desarr[1].Tasa_de_Descuento := 0;

      end
      else
      begin
         Reg_Val_In.sMoneda_Conversion := Reg_Val_In.sUnidadMonetaria;

         Reg_Val_Out.Valor_Razonable_Pos_Larga := Reg_Val_Out.ValorInvertidoUM;
         Reg_Val_Out.Valor_Razonable_Pos_Corta := Reg_Val_Out.Valor_Par_MC;

         Reg_Val_Out.Nominales         := Reg_Val_Out.ValorInvertidoUM - Reg_Val_Out.Valor_Par_MC;
         Reg_Val_Out.ValorInvertidoUM  := Reg_Val_Out.ValorInvertidoUM - Reg_Val_Out.Valor_Par_MC;

      end;

      exit;  // ggarcia 14-06-2013

   end;

   //ggarcia 23-03-2020
   if (sTipo_Valuac = 'REC-TIRCPA') Then
   begin
      fTasa_Cupon := Reg_val_out.TasaCalculo;
      //Reg_Val_In.Con_Cupon := true;

      //Determinar cupón vigente a fecha de calculo (Incluyendo cupón del día)
      Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                    Reg_Val_Out.RegDes,
                    Reg_Val_In.dFechaCalculo,
                    true, //Reg_Val_In.Con_Cupon,
                    iCupon_Vigente,
                    Modulo_Err,
                    String_Err,
                    Result);
      if NOT Result then
         Exit;

      //SI fecha Valorización igual a la fecha de Vcto para el cupón Vigente
      //Llama a Re-Calculo de tasa para cupón (Fecha de Valorización) Retorna Tasa de Valorización
      if (Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto = Reg_Val_In.dFechaCalculo) then
      begin
         carga_parametros_formulas_Mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                      ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                      ,Reg_Formula_PAR
                                      ,Reg_Formula_TIR
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);
         if (not String.IsNullOrEmpty(sFormula_Pte)) and
            (sFormula_Pte <> ''  ) then
         begin
            Reg_Val_In.Forzar_Uso_Formula_PTE := 'SI';
            Reg_Val_In.Formula_PTE            := sFormula_Pte;
         end;
         Recalculo_tasa_cupon(Reg_Val_In
                             ,Reg_Val_Out
                             ,Registro_Fechas
                             ,Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,Reg_val_out.Origen
                             ,iCupon_Vigente
                             ,Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente+1].Fecha_Vcto
                             ,true  //genera recalculo tasa
                             ,fTasa_cupon
                             ,Modulo_Err
                             ,String_Err
                             ,Result);
         if NOT Result then
            Exit;
      end
      else
      begin
         //Si Cupón Vigente es el 1 y fecha de valorización es menor a Fecha de Vcto del cupón vigente
         //Tasa de Valorización es igual a tasa de compra
         if (iCupon_Vigente = 1) and (Reg_Val_In.dFechaCalculo < Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto) then
         begin
            fTasa_Cupon := Reg_Val_In.Tasa_Compra;
         end
         else
         begin
            //Si Cupón Vigente es mayor que el 1
	          //Tasa de valorización es igual a tasa recalculada para el cupón vigente. (Se obtiene de la nueva tabla de tasas recalculadas)
            if iCupon_Vigente > 1 then
            begin
               Busca_tasa_cupon(Reg_Val_In.Empresa
                               ,Reg_Val_In.Transaccion
                               ,Reg_Val_In.Folio_Interno
                               ,Reg_Val_In.Item_OMD
                               ,Reg_Val_In.Tasa_Compra
                               ,iCupon_Vigente
                               ,fTasa_Cupon
                               ,Result);
              //Si no encuentra registro en tabla de tasas recalculadas
	            //Llama a Re-Calculo de tasa para cupón (Fecha de Vcto Cupón Vigente) Retorna Tasa de Valorización
              if not Result then
              begin
                 Recalculo_tasa_cupon(Reg_Val_In
                                     ,Reg_Val_Out
                                     ,Registro_Fechas
                                     ,Reg_Formula_PAR
                                     ,Reg_Formula_TIR
                                     ,Reg_val_out.Origen
                                     ,iCupon_Vigente
                                     ,Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente+1].Fecha_Vcto
                                     ,false  //no genera recalculo tasa para el cupon vigente solo para los anteriores
                                     ,fTasa_cupon
                                     ,Modulo_Err
                                     ,String_Err
                                     ,Result);
                 if NOT Result then
                    Exit;
                 Busca_tasa_cupon(Reg_Val_In.Empresa
                                 ,Reg_Val_In.Transaccion
                                 ,Reg_Val_In.Folio_Interno
                                 ,Reg_Val_In.Item_OMD
                                 ,Reg_Val_In.Tasa_Compra
                                 ,iCupon_Vigente
                                 ,fTasa_Cupon
                                 ,Result);
                 if NOT Result then
                 begin
                    String_Err := sTipo_Valuac+' - '+trim(Reg_Val_In.Formula_PTE)+': NO se pudo determinar tasa de recalculo ';
                    exit;
                 end;
              end;
            end;
         end;
      end;

      //Valorizar a la tasa de Valorización
      Reg_Val_In.Valoriza_Par_Pte     := 'PTE';
      Reg_Val_Out.Tipo_Valuacion      := sTipo_Valuac;
      Reg_val_out.TasaCalculo         := fTasa_Cupon;

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,Modulo_Err
                       ,String_Err
                       ,Result);
      if NOT Result then
      begin
         String_Err := sTipo_Valuac+' - '+trim(Reg_Val_In.Formula_PTE)+': '+String_Err;
         exit;
      end;

      Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;
      exit;  // ggarcia 14-06-2013

   end;

   //--------------------------------------------------------------------------
   // si llego aca es sin definicion Valorizo a PTE
   //--------------------------------------------------------------------------
   //--------------------------------------------------------------------------
    if (sTipo_Valuac = '') or
       (sTipo_Valuac = 'PRE-LIMPIO') OR     // Valor Presente as TTIR de Compra - INT Dev.
       (sTipo_Valuac = 'PRESENTE') then     // Valor Presente as Tasa de COmpra
    begin

       //ggarcia 17-08-2020
       if sCodigo_Formula <> '' then
       begin
          sMetodo_Sin_Tasa_Referencia := Metodo_Sin_Tasa_Referencia_Mem(sCodigo_Formula
                                                                       ,Reg_Val_In.dFechaCalculo);
          sTasa_Base_Aux := Reg_Val_Out.RegDes.TASA_VALOR_PAR;
          if sTasa_base <> '' then
             Reg_Val_Out.RegDes.TASA_VALOR_PAR := sTasa_base;

          Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
          Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
          Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
          Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;

          carga_Mem_Desarr(Reg_Val_Out.Array_Mem_Desarr
                          ,Reg_Val_In.Nemotecnico
                          ,Reg_Val_Out.RegDes
                          ,Registro_Fechas
                          ,sMetodo_Sin_Tasa_Referencia
                          ,Reg_Val_In.Con_Cupon
                          ,True     // Verifica Exepciones Cambiarias
                          ,Modulo_Err
                          ,String_Err
                          ,Result);
          if NOT Result then
             exit;
          Reg_Val_Out.RegDes.TASA_VALOR_PAR := sTasa_Base_Aux;
       end;
       //fin ggarcia 17-08-2020


       Reg_Val_In.Valoriza_Par_Pte     := 'PTE';
       Reg_Val_Out.Tipo_Valuacion      := sTipo_Valuac;

       //Solucíon  Parcial
       if Reg_Val_In.Tipo_Proceso = 'GESTION' then
          Reg_val_out.TasaCalculo := Reg_Val_In.Tasa_Compra;

       if (not String.IsNullOrEmpty(sFormula_Pte)) and
          (sFormula_Pte <> ''  ) then
       begin
          Reg_Val_In.Forzar_Uso_Formula_PTE := 'SI';
          Reg_Val_In.Formula_PTE            := sFormula_Pte;
       end;

       Valoriza_Registro(Reg_Val_In
                        ,Reg_Val_Out
                        ,Modulo_Err
                        ,String_Err
                        ,Result);

       if NOT Result then
       begin
          String_Err := sTipo_Valuac+' - '+trim(Reg_Val_In.Formula_PTE)+': '+String_Err;
          exit;
       end;

       //ggarcia 17-08-2020
       if sCodigo_Formula <> '' then
          Reg_Val_In.Tabla_Desarr_Cargada    := 'NO';


       Reg_Val_In.Forzar_Uso_Formula_PAR := 'NO';
       Reg_Val_In.Forzar_Uso_Formula_PTE := 'NO';
       Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;

       if Reg_Val_in.Tipo_Instrumento = 'S' then
       begin
         //Determino Cupón vigente y verifico si hay tasa de descuento
         Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                       Reg_Val_Out.RegDes,
                       Reg_Val_In.dFechaCalculo,
                       False,
                       iCupon_Vigente,
                       Modulo_Err,
                       String_Err,
                       Result);
         if NOT Result then
         begin
            String_Err := sTipo_Valuac+': '+String_Err;
            exit;
         end;


         if Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Tasa_de_Descuento <> 0 then
         begin
            Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Tasa_de_Descuento;
            Reg_Val_Out.TasaCalculo := Reg_val_out.Rate_Used_Valuacion;
            // Dejo en Cero las Tasas de descuento debido a que al calcular los valores restantes
            //calcula valor pte. sumando a la tasa la tasa de descuento
            for i := 1 to ROUND(Reg_Val_Out.RegDes.Nro_Cupones) do
               Reg_Val_Out.Array_Mem_Desarr[i].Tasa_de_Descuento := 0;

            // Calculamos una TIR para el valor
            Valida_Param_Proceso_Mem('CALC_TIR'
                                   ,'TAS_FLOT'
                                   ,'ACTIVO'
                                   ,bResultTasa);

            if (bResultTasa) then
            begin
               carga_parametros_formulas_Mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                            ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                            ,Reg_Formula_PAR
                                            ,Reg_Formula_TIR
                                            ,Modulo_Err
                                            ,String_Err
                                            ,Result);

               if NOT Result then
               begin
                  String_Err := sTipo_Valuac+': '+String_Err;
                  exit;
               end;

               Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;
               Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
               Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
               Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
               Registro_Fechas.Fecha_Pago        := Reg_Val_In.dFechaPago;

               if Reg_Val_Out.Valor_Par_UM = 0 then
                  Reg_Val_Out.PorcentajePar := 0
               else
                  Reg_Val_Out.PorcentajePar := Redondeo(Reg_Val_Out.ValorInvertidoUM /
                                                        Reg_Val_Out.Valor_Par_UM, 4) * 100;

               // Habilitado por F.I. para Penta Vida 25-08-2015
               bAcumula_Factor := (Reg_Formula_TIR.Valoriza_acumulado = 'S');



               Calculo_TIR(Reg_Formula_PAR
                          ,Reg_Formula_TIR
                          ,Reg_Val_In.Tipo_Instrumento
                          ,Reg_Val_Out.Array_Mem_Desarr
                          ,Reg_Val_In.Nemotecnico
                          ,Reg_Val_Out.RegDes
                          ,Registro_Fechas
                          ,Reg_Val_Out.Nominales
                          ,Reg_Val_Out.Valor_Par_Base
                          ,Reg_Val_Out.Valor_PAR_UM
                          ,Reg_Val_In.Con_Cupon
                          ,bAcumula_Factor //False                //
                          ,Reg_Val_In.sValor_Cupon_Original
                          ,Reg_Val_In.sComponentes_Descuento
                          ,Reg_val_out.Origen
                          ,Reg_Val_Out.TasaCalculo
                          ,Reg_Val_Out.TIR_Desarr
                          ,P_ValorPte
                          ,Reg_Val_Out.ValorInvertidoUM
                          ,Reg_Val_Out.PorcentajePar
                          ,Modulo_Err
                          ,String_Err
                          ,Result);

                if NOT Result then
                   exit;
                Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;
            end;
         end
         else
           Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;
       end
       else
       begin
           if Reg_Val_in.Tipo_Instrumento <> 'B' then  // Gonzalo te falto este IFFFFF F.I. 14-07-2005 23:55
           begin
              if Reg_Val_Out.Array_Mem_Desarr[1].Tasa_de_Descuento <> 0 then
                 Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.Array_Mem_Desarr[1].Tasa_de_Descuento //GGARCIA 14/7/2005
              else
                 Reg_val_out.Rate_Used_Valuacion := Reg_Val_Out.TasaCalculo;
               // Dejo en Cero las Tasas de descuento debido a que al calcular los valores restantes
               //calcula valor pte. sumando a la tasa la tasa de descuento
               // 30-12-2008 Faltaba en los instrumentos unicos ....
               Reg_Val_Out.Array_Mem_Desarr[1].Tasa_de_Descuento := 0;
           end;

       end;

       If sTipo_Valuac = 'PRE-LIMPIO' then
       Begin
          Limpia_Valor_Interes(Reg_Val_In,
                         Reg_Val_Out,
                         Modulo_Err,
                         String_Err,
                         Result);
          if Not Result then
          begin
             Modulo_Err := 'Valuación de Instrumentos';
             String_Err := sTipo_Valuac+': Problemas con Limpiar el Valor de Mercado :'
                          +' Nemotecnico : '+Reg_Val_In.Nemotecnico
                          +' Con Fecha   : '+DatetoStr(Reg_Val_In.dFechaCalculo);
             exit;
          end;
       End;

       exit;  // ggarcia 14-06-2013
    end;

    //ggarcia 17-10-2023
    if sTipo_Valuac = 'AJUST-VAL' then
    begin

       Reg_Val_In.Proceso_Valuacion    := 'PRESENTE';
       Reg_Val_In.Valoriza_Par_Pte     := 'VAL';       // Valuación
       Valoriza_Registro(Reg_Val_In
                        ,Reg_Val_Out
                        ,Modulo_Err
                        ,String_Err
                        ,Result);
       if NOT Result then
       begin
          Modulo_Err := 'Valuación de Instrumentos';
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;
       fValor_Pte_MC := Reg_Val_Out.ValorInvertidoMC;
       fValor_Pte_UM := Reg_Val_Out.ValorInvertidoUM;
       fPrecio_Pte   := Reg_val_out.Rate_Used_Valuacion;

       if Reg_Val_In.dFechaCalculo <> Reg_Val_In.dFechaCompra then
       begin
          Reg_Val_In.Proceso_Valuacion    := 'MERCADO';
          Reg_Val_In.Valoriza_Par_Pte     := 'VAL';       // Valuación
          Valoriza_Registro(Reg_Val_In
                           ,Reg_Val_Out
                           ,Modulo_Err
                           ,String_Err
                           ,Result);
          if NOT Result then
          begin
             Modulo_Err := 'Valuación de Instrumentos';
             String_Err := sTipo_Valuac+': '+String_Err;
             exit;
          end;
          fValor_Mdo_UM := Reg_Val_Out.ValorInvertidoUM;

          if fValor_Mdo_UM > 0 then
             fPtge_Diferencia  := ((fValor_Pte_UM - fValor_Mdo_UM) / fValor_Mdo_UM) * 100
          else
             fPtge_Diferencia  := 100;

          fPtge_Max_Diferencia :=  fBase_Precio;

          if fPtge_Diferencia < fPtge_Max_Diferencia then
          begin
              Reg_Val_Out.ValorInvertidoUM    := fValor_Pte_UM;
              Reg_Val_Out.ValorInvertidoMC    := fValor_Pte_MC;
              Reg_val_out.Rate_Used_Valuacion := fPrecio_Pte;
          end
          else
          begin
              //buscar resultados dia anterior
              Valor_Presente(Reg_Val_In.Empresa
                            ,Reg_Val_In.Cartera
                            ,Reg_Val_In.Transaccion
                            ,Reg_Val_In.Folio_Interno
                            ,Reg_Val_In.Item_OMD
                            ,Reg_Val_In.dFechaCalculo-1
                            ,Reg_Val_Out.Nominales
                            ,fValor_Pte_Ant_UM
                            ,fValor_Pte_Ant_MC
                            ,fPrecio_Ant
                            ,Result);
              if NOT Result then
              begin
                 Modulo_Err := 'Valuación de Instrumentos';
                 String_Err := sTipo_Valuac+': '+'No se encontro valor Mixto al '+DateToStr(Reg_Val_In.dFechaCalculo-1);
                 exit;
              end;
              Reg_Val_Out.ValorInvertidoUM    := fValor_Pte_Ant_UM;
              Reg_Val_Out.ValorInvertidoMC    := fValor_Pte_Ant_MC;
              Reg_val_out.Rate_Used_Valuacion := fPrecio_Ant;
          end;
       end;

       exit;  // ggarcia 14-06-2013
    end;
    //fin ggarcia 17-10-2023


    // ggarcia 14-06-2013
    // Si llega aca es que no encontro tipo de valuacion valido ya que hay un exit en cada if
    Modulo_Err := 'Valuación';
    String_Err := 'El tipo de valuación '+sTipo_Valuac+' no es válido';
    Result := False;

end;

procedure Recalculo_tasa_cupon(Reg_Val_In       :TRegistro_Valoriza_In;
                               Reg_Val_Out      :TRegistro_Valoriza_Out;
                               Registro_Fechas  :TRegistro_Fechas;
                               Reg_Formula_PAR  :TRegFormulaPAR;
                               Reg_Formula_TIR  :TRegFormulaTIR;
                               sOrigen          :string;
                               iCupon_Vigente   :Integer;
                               dFecha_Recalculo :TDateTime;
                               sGraba_Tasa      :Boolean;
                           var fTasa_cupon      :Double;
                           var sModulo_Err      :string;
                           var sString_Err      :string;
                           var bResultado       :Boolean);
var bResult :Boolean;
    sMetodo_Sin_Tasa_Referencia :string;
    dFecha_Calculo :TDateTime;
    P_ValorPte :Double;
    bAcumula_Factor :Boolean;
//    fValor_PAR_Base :Double;
//    fValor_PAR_UM   :Double;
//    fValorInvertidoUM :Double;
//    fPorcentajePar    :Double;
begin

   //Busca Tasa en cupón anterior a (fecha)
   Busca_tasa_cupon(Reg_Val_In.Empresa
                   ,Reg_Val_In.Transaccion
                   ,Reg_Val_In.Folio_Interno
                   ,Reg_Val_In.Item_OMD
                   ,Reg_Val_In.Tasa_Compra
                   ,iCupon_Vigente
                   ,fTasa_cupon
                   ,bResult);
   //Si existe cupón anterior pero no registro en la nueva tabla
   if not bResult then
   begin
      dFecha_Calculo           := Reg_Val_In.dFechaCalculo;
      Reg_Val_In.dFechaCalculo := Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto;
      Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
      Recalculo_tasa_cupon(Reg_Val_In
                          ,Reg_Val_Out
                          ,Registro_Fechas
                          ,Reg_Formula_PAR
                          ,Reg_Formula_TIR
                          ,sOrigen
                          ,iCupon_Vigente-1
                          ,Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto
                          ,true    //genera recalculo tasa
                          ,fTasa_cupon
                          ,sModulo_Err
                          ,sString_Err
                          ,bResult);
      if NOT bResult then
      begin
         bResultado := False;
         Exit;
      end
      else
      begin
         Reg_Val_In.dFechaCalculo := dFecha_Calculo;
         Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
         Busca_tasa_cupon(Reg_Val_In.Empresa
                         ,Reg_Val_In.Transaccion
                         ,Reg_Val_In.Folio_Interno
                         ,Reg_Val_In.Item_OMD
                         ,Reg_Val_In.Tasa_Compra
                         ,iCupon_Vigente
                         ,fTasa_cupon
                         ,bResult);
         if not sGraba_Tasa then
         begin
            bResultado := True;
            Exit;
         end;
      end;
   end;

   //ggarcia 22-07-2020 si s el ultimo cupon no genera tasa recalculo
   if iCupon_Vigente < Reg_Val_Out.RegDes.NRO_CUPONES then
   begin

      if iCupon_Vigente > 1 then
         dFecha_Calculo := Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto
      else
         dFecha_Calculo := Reg_Val_Out.RegDes.FECHA_EMISION;
      Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                     ,Reg_Val_In.sEmisor
                     ,Reg_Val_In.sInstrumento
                     ,Reg_Val_In.sSerie
                     ,Reg_Val_In.Nemotecnico
                     ,Reg_Val_In.sTipoNominales
                     ,Reg_Val_Out.Nominales
                     ,Reg_Val_In.dTasaEmision
                     ,Reg_Val_In.dFechaEmision
                     ,Reg_Val_In.dFechaVencimiento
                     ,dFecha_Calculo
                     ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                     ,Reg_Val_In.Con_Cupon
                     ,Reg_Val_Out.Array_Mem_Desarr
                     ,Reg_Val_Out.RegDes
                     ,Registro_Fechas
                     ,sMetodo_Sin_Tasa_Referencia
                     ,Reg_Formula_PAR
                     ,sModulo_Err
                     ,sString_Err
                     ,bResult);
      if NOT bResult then
      begin
         bResultado := False;
         exit;
      end;

      //Valoriza a (fecha) con tasa anterior para obtener Valor Presente Anterior (VER FORMA QUE NO ACTUALICE LA TABLA DE DESARROLLO)
      Reg_Val_In.Valoriza_Par_Pte     := 'PTE';
      Reg_Val_Out.Tipo_Valuacion      := 'REC-TIRCPA';
      Reg_val_out.TasaCalculo         := fTasa_Cupon;
      //para que no actualice la tabla de desarrollo al valorizar
      Reg_Val_Out.RegDes.Fecha_Carga_Array_Mem := Reg_Val_In.dFechaCalculo;

      Valoriza_Registro(Reg_Val_In
                       ,Reg_Val_Out
                       ,sModulo_Err
                       ,sString_Err
                       ,bResult);
      if NOT bResult then
      begin
         sString_Err := 'REC-TIRCPA'+' - '+trim(Reg_Val_In.Formula_PTE)+': '+sString_Err;
         bResultado  := False;
         exit;
      end;

      //Carga tabla de desarrollo a (fecha)
      Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                     ,Reg_Val_In.sEmisor
                     ,Reg_Val_In.sInstrumento
                     ,Reg_Val_In.sSerie
                     ,Reg_Val_In.Nemotecnico
                     ,Reg_Val_In.sTipoNominales
                     ,Reg_Val_Out.Nominales
                     ,Reg_Val_In.dTasaEmision
                     ,Reg_Val_In.dFechaEmision
                     ,Reg_Val_In.dFechaVencimiento
                     ,Reg_Val_In.dFechaCalculo
                     ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                     ,Reg_Val_In.Con_Cupon
                     ,Reg_Val_Out.Array_Mem_Desarr
                     ,Reg_Val_Out.RegDes
                     ,Registro_Fechas
                     ,sMetodo_Sin_Tasa_Referencia
                     ,Reg_Formula_PAR
                     ,sModulo_Err
                     ,sString_Err
                     ,bResult);
      if NOT bResult then
      begin
         bResultado := False;
         exit;
      end;

      //Determina Tir a (fecha) para obtener Valor Presente Anterior   Calculo_TIR
      bAcumula_Factor := (Reg_Formula_TIR.Valoriza_acumulado = 'S');
      Calculo_TIR(Reg_Formula_PAR
                 ,Reg_Formula_TIR
                 ,Reg_Val_In.Tipo_Instrumento
                 ,Reg_Val_Out.Array_Mem_Desarr
                 ,Reg_Val_In.Nemotecnico
                 ,Reg_Val_Out.RegDes
                 ,Registro_Fechas
                 ,Reg_Val_Out.Nominales
                 ,Reg_Val_Out.Valor_Par_Base
                 ,Reg_Val_Out.Valor_PAR_UM
                 ,Reg_Val_In.Con_Cupon
                 ,bAcumula_Factor //False
                 ,Reg_Val_In.sValor_Cupon_Original
                 ,Reg_Val_In.sComponentes_Descuento
                 ,sOrigen
                 ,Reg_Val_Out.TasaCalculo
                 ,Reg_Val_Out.TIR_Desarr
                 ,P_ValorPte
                 ,Reg_Val_Out.ValorInvertidoUM
                 ,Reg_Val_Out.PorcentajePar
                 ,sModulo_Err
                 ,sString_Err
                 ,bResult);
      if NOT bResult then
      begin
         bResultado := False;
         exit;
      end;

      //Graba Tir en nueva tabla la Tasa Recalculada  para cupon siguiente
      Graba_tasa_cupon(Reg_Val_In.Empresa
                      ,Reg_Val_In.Transaccion
                      ,Reg_Val_In.Folio_Interno
                      ,Reg_Val_In.Item_OMD
                      ,iCupon_Vigente+1
                      ,dFecha_Recalculo
                      ,Reg_Val_Out.TasaCalculo
                      ,Reg_Val_Out.Array_Mem_Desarr[iCupon_Vigente+1].Valor_Tasa
                      ,bResult);
      if NOT bResult then
      begin
         sModulo_Err := 'Recalculo Tasa Cupón';
         sString_Err := 'Error al grabar en la tabla QS_TRA_OMD_TASA_REC';
         bResultado := False;
         exit;
      end;

   end;

   fTasa_cupon := Reg_Val_Out.TasaCalculo;
   bResultado  := true;

 end;
//==============================================================================
// Funcion TIR_Valuacion creada el 28-05-2007.
// Ahora se puede definir metodo de valuacion para TIR por ende debe usar el mismo
// metodo para determinar la TIR (Caso de las OMD)
//==============================================================================
procedure TIR_Valuacion( var Reg_Val_In      : TRegistro_Valoriza_In;
                         var Reg_Val_Out : TRegistro_Valoriza_Out;
                         var Modulo_Err  : String;
                         var String_Err  : String;
                         var Result      : Boolean);

var
  sTipo_Valuac                : String;
  sFormula_Pte                : String;
  fBase_Precio                : Double;
  sMon_Ind                    : String;
  sOrigen                     : String;

  iNro_Cupon                  : Integer;
  dFecha_Desde                : TDateTime;
  fInteres_Acum_UM            : Double;
  fInteres_Acum_MC            : Double;
  fInteres_Acum_UM_REAJUSTADO : Double;
  fReajuste_Indexado          : Double;
  fAjuste_Reajuste_Indexado   : Double;
  fReajuste_NO_Indexado       : Double;

  fSaldo_Insoluto_Sin_Rea     : Double;
  fSaldo_Insoluto             : Double;


  fReajuste_Interes_Devengado : Double;
  fReajuste_Capital           : Double;

  fValor_Invertido_UM_Original : Double;

begin
  if sValorizacion_Proceso = 'SI' then
      Busca_Valuacion_Mem ( Reg_Val_In,
                           sTipo_Valuac,
                           sFormula_Pte,
                           fBase_Precio,
                           sMon_Ind,
                           sOrigen,
                           Result
                           )
  else
      Busca_Valuacion( Reg_Val_In,
                       sTipo_Valuac,
                       sFormula_Pte,
                       fBase_Precio,
                       sMon_Ind,
                       sOrigen,
                       Result
                       );

  if NOT Result then
     sTipo_Valuac := '';


   // Valor a Tasa Real mas reajuste de Interes y Capital
   // Descuenta flujos originales a la tasa indicada y luego le suma el reajuste de
   // los intereses devengados a tasa de emisión y le suma el reajuste de capital
   // Aca en el calculo de TIR hace el inverso
   // Resta al valor invertido el reajuste de los intereses devengados a tasa de
   // emisión y el reajuste de capital 28-05-2007 F.I.
   if (sTipo_Valuac = 'T_REA+R_IK') then
   begin
       // Determino intereses devengados para obtener el reajuste de interes
       ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                          ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                          ,Reg_Val_Out.Array_Mem_Desarr
                          ,Reg_Val_Out.RegDes
                          ,Reg_Val_In.Con_Cupon
                          ,iNro_Cupon
                          ,dFecha_Desde
                          ,Modulo_Err
                          ,String_Err
                          ,Result);
       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

       Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                           ,Reg_Val_In.sEmisor
                           ,Reg_Val_In.sInstrumento
                           ,Reg_Val_In.sSerie
                           ,Reg_Val_In.Nemotecnico
                           ,Reg_Val_In.dTasaEmision
                           ,Reg_Val_Out.TasaCalculo
                           ,Reg_Val_In.sUnidadMonetaria
                           ,Reg_Val_In.sTipoNominales
                           ,Reg_Val_In.dFechaEmision
                           ,Reg_Val_In.dFechaVencimiento
                           //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                           //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                           ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                           ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                           ,Reg_Val_In.dFechaPago
                           ,Reg_Val_In.sMoneda_Conversion
                           ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                           ,Reg_Val_Out.Nominales
                           ,dFecha_Desde                 // Fecha Desde
                           ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                           ,Reg_Val_In.Descriptor_Cargado
                           ,Reg_Val_In.Tabla_Desarr_Cargada
                           ,Reg_Val_Out.RegDes
                           ,Reg_Val_Out.Array_Mem_Desarr
                           ,fInteres_Acum_UM
                           ,fInteres_Acum_MC
                           ,fInteres_Acum_UM_REAJUSTADO
                           ,fReajuste_Indexado
                           ,fAjuste_Reajuste_Indexado
                           ,fReajuste_NO_Indexado
                           ,Modulo_Err
                           ,String_Err
                           ,Result);
       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

       fReajuste_Interes_Devengado := (fInteres_Acum_UM_REAJUSTADO -
                                       fInteres_Acum_UM);

       // Determino reajuste de capital
       Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                     ,Reg_Val_Out.RegDes
                     ,Reg_Val_In.dFechaEmision
                     ,Reg_Val_In.dFechaCalculo
                     ,Reg_Val_In.dFechaCompra     //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                     ,Reg_Val_Out.Nominales
                     ,Reg_Val_Out.Array_Mem_Desarr
                     ,False
                     ,fSaldo_Insoluto_Sin_Rea
                     ,fSaldo_Insoluto
                     ,Modulo_Err
                     ,String_Err
                     ,Result);

       if NOT Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;

       fReajuste_Capital := fSaldo_Insoluto - fSaldo_Insoluto_Sin_Rea;

       // Debo guardar el valor original ya que debe devolverlo igual al final
       fValor_Invertido_UM_Original := Reg_Val_Out.ValorInvertidoUM;

       Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM -
                                       fReajuste_Capital -
                                       fReajuste_Interes_Devengado;

       Reg_Val_In.Valoriza_Par_Pte        := 'TIR';
       Reg_Val_In.sValor_Cupon_Original   := 'S';

       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         Modulo_Err,
                         String_Err,
                         Result);

       Reg_Val_Out.ValorInvertidoUM := fValor_Invertido_UM_Original;
       Reg_Val_In.sValor_Cupon_Original   := 'N';

       if not Result then
       begin
          String_Err := sTipo_Valuac+': '+String_Err;
          exit;
       end;
      Exit;
   end;
   // Si llega hasta aqui es calculo normal de TIR
   Reg_Val_In.Valoriza_Par_Pte        := 'TIR';
   
   Valoriza_Registro(Reg_Val_In,
                     Reg_Val_Out,
                     Modulo_Err,
                     String_Err,
                     Result);


end;
//==============================================================================
// Funcion que carga tabla de desarrollo
//==============================================================================
procedure Carga_TabDesarr(sTipo_Instrumento    : String;
                          sEmisor              : String;
                          sInstrumento         : String;
                          sSerie               : String;
                          sNemotecnico         : String;
                          sTipoNominales       : String;
                          fNominales           : Double;
                          fTasaEmision         : Double;
                          dFechaEmision        : TDateTime;
                          var dFechaVencimiento: TDateTime;
                          dFechaCalculo        : TDateTime;
                          sTasa_Valor_PAR      : String;
                          bConCupon            : Boolean;
                          var Array_Mem_Desarr : TArray_Mem_Desarr;
                          var RegDes           : TReg_Descriptor;
                          var Registro_Fechas  : TRegistro_Fechas;
                          var sMetodo_Sin_Tasa_Referencia : String;
                          sParametros_Formula             : TRegFormulaPAR;
                          var sModulo_Err      : String;
                          var sString_Err      : String;
                          var Result           : Boolean);
begin
  With Registro_Fechas do
    begin
      Fecha_Emision       := dFechaEmision;
      Fecha_Vencimiento   := dFechaVencimiento;
      Fecha_Calculo       := dFechaCalculo;
    end;

  // Cargo Tabla desarrollo
  if sTipo_Instrumento = 'S' then
     begin
       // Se obtiene el metodo para obtener la tasa si no existe
       // Es por formula PAR ya que esto es definido por el emisor
       sMetodo_Sin_Tasa_Referencia := Metodo_Sin_Tasa_Referencia_Mem( RegDes.Cod_Calc_PAR_D
                                                                     ,dFechaCalculo
                                                                     );
       carga_Mem_Desarr(Array_Mem_Desarr
                       ,sNemotecnico
                       ,RegDes
                       ,Registro_Fechas
                       ,sMetodo_Sin_Tasa_Referencia
                       ,bConCupon
                       ,True     // Verifica Exepciones Cambiarias
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

       if NOT Result then
          exit;

       dFechaVencimiento := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Fecha_Vcto;
       Registro_Fechas.Fecha_Vencimiento := dFechaVencimiento;
     end
  else  // Instrumentos Unicos
     begin
       Carga_Mem_Desarr_Unicos(sTipoNominales
                              ,fNominales
                              ,fTasaEmision
                              ,dFechaEmision
                              ,dFechaVencimiento
                              ,dFechaCalculo
                              ,sTasa_Valor_PAR
                              ,Array_Mem_Desarr
                              ,RegDes
                              ,sParametros_Formula
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
       if NOT Result then
          exit;

     end;

  // Se guarda fecha a la que fue cargada la tabla de desarrollo
  RegDes.Fecha_Carga_Array_Mem := dFechaCalculo;
  {
  if (dFechaCalculo > dFechaVencimiento) or
     (dFechaCalculo < dFechaEmision)     then
  }
  if (dFechaCalculo > dFechaVencimiento) then

  begin
      sModulo_Err := 'Modulo Valorizaciones';
      sString_Err := 'Instrumento no vigente a la fecha de calculo ('
                     +datetostr(dFechaCalculo)+')';
      Result := False;
  end;
end;
//---------------------------------------------------------------------------
procedure Carga_TabDesarr_Vig(sTipo_Instrumento    : String;
                              sEmisor              : String;
                              sInstrumento         : String;
                              sSerie               : String;
                              dFecha_Vig           : TDateTime;
                              sNemotecnico         : String;
                              sTipoNominales       : String;
                              fNominales           : Double;
                              fTasaEmision         : Double;
                              dFechaEmision        : TDateTime;
                              var dFechaVencimiento: TDateTime;
                              dFechaCalculo        : TDateTime;
                              sTasa_Valor_PAR      : String;
                              bConCupon            : Boolean;
                              var Array_Mem_Desarr : TArray_Mem_Desarr;
                              var RegDes           : TReg_Descriptor;
                              var Registro_Fechas  : TRegistro_Fechas;
                              var sMetodo_Sin_Tasa_Referencia : String;
                              sParametros_Formula             : TRegFormulaPAR;
                              var sModulo_Err      : String;
                              var sString_Err      : String;
                              var Result           : Boolean);
begin
  With Registro_Fechas do
    begin
      Fecha_Emision       := dFechaEmision;
      Fecha_Vencimiento   := dFechaVencimiento;
      Fecha_Calculo       := dFechaCalculo;
    end;

  // Cargo Tabla desarrollo
  if sTipo_Instrumento = 'S' then
     begin
       // Se obtiene el metodo para obtener la tasa si no existe
       // Es por formula PAR ya que esto es definido por el emisor
       sMetodo_Sin_Tasa_Referencia := Metodo_Sin_Tasa_Referencia_Mem( RegDes.Cod_Calc_PAR_D
                                                                     ,dFechaCalculo
                                                                     );
       sString_Err := '';
       carga_Mem_Desarr_Vig(Array_Mem_Desarr
                           ,sNemotecnico
                           ,dFechaCalculo  //dFecha_Vig
                           ,RegDes
                           ,Registro_Fechas
                           ,sMetodo_Sin_Tasa_Referencia
                           ,bConCupon
                           ,True     // Verifica Exepciones Cambiarias
                           ,sModulo_Err
                           ,sString_Err
                           ,Result);

       if NOT Result then
          exit;

       dFechaVencimiento := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Fecha_Vcto;
       Registro_Fechas.Fecha_Vencimiento := dFechaVencimiento;
     end
  else  // Instrumentos Unicos
     begin
       Carga_Mem_Desarr_Unicos(sTipoNominales
                              ,fNominales
                              ,fTasaEmision
                              ,dFechaEmision
                              ,dFechaVencimiento
                              ,dFechaCalculo
                              ,sTasa_Valor_PAR
                              ,Array_Mem_Desarr
                              ,RegDes
                              ,sParametros_Formula
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
       if NOT Result then
          exit;

     end;

  // Se guarda fecha a la que fue cargada la tabla de desarrollo
  RegDes.Fecha_Carga_Array_Mem := dFechaCalculo;
  {
  if (dFechaCalculo > dFechaVencimiento) or
     (dFechaCalculo < dFechaEmision)     then
  }
  if (dFechaCalculo > dFechaVencimiento) then

  begin
      sModulo_Err := 'Modulo Carga Tabla Desarrollo';
      sString_Err := 'Instrumento no vigente a la fecha de calculo ('
                     +datetostr(dFechaCalculo)+')';
      Result := False;
  end;
end;
//---------------------------------------------------------------------------
procedure Carga_RegDes(sTipo_Instrumento : String;
                       sNemotecnico      : String;
                       sEmisor           : String;
                       sInstrumento      : String;
                       sSerie            : String;
                       sUnidadMonetaria  : String;
                       fTasaEmision      : Double;
                       var RegDes        : TReg_Descriptor;
                       var sModulo_Err   : String;
                       var sString_Err   : String;
                       var Result        : Boolean);
var
  sSi_No_Descriptor : String;
begin
  RegDes.Codigo_Emisor         := sEmisor;
  RegDes.Codigo_Instrumento    := sInstrumento;
  RegDes.Serie                 := sSerie;
  RegDes.Fecha_Carga_Array_Mem := 0;

  if sTipo_Instrumento = 'U' then
  begin
       if sValorizacion_Proceso = 'SI' then
          Leer_Instrumento_Mem(sInstrumento,
                           sSi_No_Descriptor,
                           RegDes.Tasa_Valor_PAR,    // Ojo recupero datos en
                           RegDes.Tasa_Valor_PTE,    // el registro descriptor
                           RegDes.Cod_Calc_PAR_D,    // para no generar mas variables
                           RegDes.Cod_Calc_TIR_D,    // Solo es un paso
                           Result)
       else
          Leer_Instrumento(sInstrumento,
                           sSi_No_Descriptor,
                           RegDes.Tasa_Valor_PAR,    // Ojo recupero datos en
                           RegDes.Tasa_Valor_PTE,    // el registro descriptor
                           RegDes.Cod_Calc_PAR_D,    // para no generar mas variables
                           RegDes.Cod_Calc_TIR_D,    // Solo es un paso
                           Result);

       if NOT Result then
          begin
            sString_Err := 'No existe definición para instrumento: '
                          +sInstrumento;
            Result := False;
            exit;
          end;

       RegDes.Codigo_Emisor      := sEmisor;
       RegDes.Codigo_Instrumento := sInstrumento;
       RegDes.Serie              := sSerie;
       RegDes.Unidad_Mon         := sUnidadMonetaria;
       RegDes.Tasa_Emision       := fTasaEmision;
       RegDes.BASE_ORIGINAL      := 100;
       RegDes.BASE_CONVERSION    := 100;
       RegDes.Nro_Cupones        := 1;
       RegDes.Cod_Calc_PAR_D_Old := RegDes.Cod_Calc_PAR_D;
       RegDes.Cod_Calc_TIR_D_Old := RegDes.Cod_Calc_TIR_D;
       RegDes.Opcion_Prepago     := 'N';
     end
  else    // Nemotecnicos sin descriptor (UNICOS)
     if sTipo_Instrumento = 'N' then
     begin
       Leer_Nemotecnico_Sin_Descriptor(sNemotecnico
                                      ,RegDes.Tasa_Valor_PAR
                                      ,RegDes.Cod_Calc_PAR_D
                                      ,RegDes.Codigo_Emisor
                                      ,Result);

       if NOT Result then
          begin
            sString_Err := 'No existe definición para nemotecnico: '+sNemotecnico;
            Result := False;
            exit;
          end;


       RegDes.Cod_Calc_TIR_D     := RegDes.Cod_Calc_PAR_D;
       RegDes.Tasa_Valor_PTE     := RegDes.Tasa_Valor_PAR;
       RegDes.Codigo_Emisor      := sEmisor;
       RegDes.Codigo_Instrumento := sInstrumento;
       RegDes.Serie              := sSerie;
       RegDes.Unidad_Mon         := sUnidadMonetaria;
       RegDes.Tasa_Emision       := fTasaEmision;
       RegDes.BASE_ORIGINAL      := 100;
       RegDes.BASE_CONVERSION    := 100;
       RegDes.Nro_Cupones        := 1;
       RegDes.Cod_Calc_PAR_D_Old := RegDes.Cod_Calc_PAR_D;
       RegDes.Cod_Calc_TIR_D_Old := RegDes.Cod_Calc_TIR_D;
       RegDes.Variacion_Cambiaria := False;
       RegDes.TASA_FLOTANTE       := 'N';

     end
     else // Instrumentos con descriptor
     begin
       {if (sValorizacion_Proceso = 'SI') and
         NOT (sImplica_NOMEM = 'S'     ) then
          Carga_Descriptor_Mem(sEmisor,
                            sInstrumento,
                            sSerie,
                            RegDes,
                            sModulo_Err,
                            sString_Err,
                            Result)

        else}       
           Carga_Descriptor(sEmisor,
                            sInstrumento,
                            sSerie,
                            RegDes,
                            sModulo_Err,
                            sString_Err,
                            Result);
     end;
end;
//------------------------------------------------------------------------------
procedure Carga_RegDes_Vig(sTipo_Instrumento : String;
                           sNemotecnico      : String;
                           sEmisor           : String;
                           sInstrumento      : String;
                           sSerie            : String;
                           dFecha_Vig        : TDateTime;
                           sUnidadMonetaria  : String;
                           fTasaEmision      : Double;
                           var RegDes        : TReg_Descriptor;
                           var sModulo_Err   : String;
                           var sString_Err   : String;
                           var Result        : Boolean);
var
  sSi_No_Descriptor : String;
begin
  RegDes.Codigo_Emisor      := sEmisor;
  RegDes.Codigo_Instrumento := sInstrumento;
  RegDes.Serie              := sSerie;

  if sTipo_Instrumento = 'U' then
  begin
       if sValorizacion_Proceso = 'SI' then
          Leer_Instrumento_Mem(sInstrumento,
                           sSi_No_Descriptor,
                           RegDes.Tasa_Valor_PAR,    // Ojo recupero datos en
                           RegDes.Tasa_Valor_PTE,    // el registro descriptor
                           RegDes.Cod_Calc_PAR_D,    // para no generar mas variables
                           RegDes.Cod_Calc_TIR_D,    // Solo es un paso
                           Result)
       else
          Leer_Instrumento(sInstrumento,
                           sSi_No_Descriptor,
                           RegDes.Tasa_Valor_PAR,    // Ojo recupero datos en
                           RegDes.Tasa_Valor_PTE,    // el registro descriptor
                           RegDes.Cod_Calc_PAR_D,    // para no generar mas variables
                           RegDes.Cod_Calc_TIR_D,    // Solo es un paso
                           Result);

       if NOT Result then
          begin
            sString_Err := 'No existe definición para instrumento: '
                          +sInstrumento;
            Result := False;
            exit;
          end;

       RegDes.Codigo_Emisor      := sEmisor;
       RegDes.Codigo_Instrumento := sInstrumento;
       RegDes.Serie              := sSerie;
       RegDes.Unidad_Mon         := sUnidadMonetaria;
       RegDes.Tasa_Emision       := fTasaEmision;
       RegDes.BASE_ORIGINAL      := 100;
       RegDes.BASE_CONVERSION    := 100;
       RegDes.Nro_Cupones        := 1;
       RegDes.Cod_Calc_PAR_D_Old := RegDes.Cod_Calc_PAR_D;
       RegDes.Cod_Calc_TIR_D_Old := RegDes.Cod_Calc_TIR_D;
       RegDes.Opcion_Prepago     := 'N';
     end
  else    // Nemotecnicos sin descriptor (UNICOS)
     if sTipo_Instrumento = 'N' then
     begin
       Leer_Nemotecnico_Sin_Descriptor(sNemotecnico
                                      ,RegDes.Tasa_Valor_PAR
                                      ,RegDes.Cod_Calc_PAR_D
                                      ,RegDes.Codigo_Emisor
                                      ,Result);

       if NOT Result then
          begin
            sString_Err := 'No existe definición para nemotecnico: '+sNemotecnico;
            Result := False;
            exit;
          end;


       RegDes.Cod_Calc_TIR_D     := RegDes.Cod_Calc_PAR_D;
       RegDes.Tasa_Valor_PTE     := RegDes.Tasa_Valor_PAR;
       RegDes.Codigo_Emisor      := sEmisor;
       RegDes.Codigo_Instrumento := sInstrumento;
       RegDes.Serie              := sSerie;
       RegDes.Unidad_Mon         := sUnidadMonetaria;
       RegDes.Tasa_Emision       := fTasaEmision;
       RegDes.BASE_ORIGINAL      := 100;
       RegDes.BASE_CONVERSION    := 100;
       RegDes.Nro_Cupones        := 1;
       RegDes.Cod_Calc_PAR_D_Old := RegDes.Cod_Calc_PAR_D;
       RegDes.Cod_Calc_TIR_D_Old := RegDes.Cod_Calc_TIR_D;
       RegDes.Variacion_Cambiaria := False;
       RegDes.TASA_FLOTANTE       := 'N';

     end
     else // Instrumentos con descriptor
     begin
       {if (sValorizacion_Proceso = 'SI') and
         NOT (sImplica_NOMEM = 'S'     ) then
          Carga_Descriptor_Mem(sEmisor,
                            sInstrumento,
                            sSerie,
                            RegDes,
                            sModulo_Err,
                            sString_Err,
                            Result)

        else}
        Carga_Descriptor_Vig(sEmisor,
                            sInstrumento,
                            sSerie,
                            dFecha_Vig,
                            RegDes,
                            sModulo_Err,
                            sString_Err,
                            Result)
     end;
end;
//------------------------------------------------------------------------------
Procedure Valorizacion( var Reg_Val_In    : TRegistro_Valoriza_In;
                        var Reg_Val_Out   : TRegistro_Valoriza_Out;
                        var sModulo_Error : String;
                        var sString_Error : String;
                        var Result        : Boolean
                       );
Var
    fValorInvertidoMC_Original,
    fValorInvertidoUM_Original,
    fValor_Par_MC_Original,
    fValor_Par_UM_Original : Double;
    fPorcentaje_Par_Original : Double;
    bEntro : Boolean;
    Reg_Formula_PAR        : TRegFormulaPAR;
    Reg_Formula_TIR        : TRegFormulaTIR;
    sTipo_UnidadMonetaria,
    sDescripcion_Moneda,
    sUnidad_Conversion     : String;

    sTipo_Valuac           : String;
    sFormula_Pte           : String;
    fBase_Precio           : Double;
    sMon_Ind               : String;
    sOrigen                : String;

begin
  // Cargo Valores de Formulas para saber si es valorizacion
  // Para verificar si Porcentaje PAR es precio OMD
  Datos_Moneda_Mem(Reg_Val_In.sUnidadMonetaria
                  ,sTipo_UnidadMonetaria
                  ,sDescripcion_Moneda
                  ,sUnidad_Conversion
                  );

  carga_parametros_formulas_Mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                               ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                               ,Reg_Formula_PAR
                               ,Reg_Formula_TIR
                               ,sModulo_Error
                               ,sString_Error
                               ,Result
                               );

  if Not Result then
     if (Reg_Val_In.Tipo_Instrumento = 'B')    or
        (Reg_Val_In.sInstrumento     = 'CORA') then
         Result := True;

  Result := True;
  bEntro := False;
 //*****************************************************************************
 // Primero Verifico  si viene Tasa, Nominales y Valor Invertido, Como es el caso
 // que puede entregar la valuación y calculo el % PAR
 //*****************************************************************************
 if ( Reg_Val_Out.Nominales   <> 0 ) and
    ( Reg_Val_Out.TasaCalculo <> 0 ) and
    ( Reg_Val_Out.ValorInvertidoMC <> 0 ) then
 begin
    // Guardo Originales
    fValorInvertidoMC_Original := Reg_Val_Out.ValorInvertidoMC;
    fValorInvertidoUM_Original := Reg_Val_Out.ValorInvertidoUM;
    //1.) Debo Obtener Valor Par
    Reg_Val_In.Valoriza_Par_Pte := 'PAR';
    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if not Result then
       Exit;

    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;

    //2.) Calculo % Valor Par
    if Reg_Val_Out.Valor_Par_UM <> 0 then
       Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.ValorInvertidoUM/
                                              Reg_Val_Out.Valor_Par_UM * 100, 2)
    else
    begin
       // Por si Acaso
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Valor Par UM en Cero. Nemotécnico '+Reg_Val_In.Nemotecnico;
       Exit;
    end;

    // Obtengo Precio Sucio y Limpio
    Calcula_Precio_Sucio_Limpio('AMBOS'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    Exit;
 end;

 //*****************************************************************************
 // Caso 1 Vienen Nominales y Tasa de Calculo
 // por lo tanto queda tal cual
 //*****************************************************************************
 if ( Reg_Val_Out.Nominales   <> 0 ) and
    (( Reg_Val_Out.TasaCalculo <> 0 ) or (Reg_Val_In.Fuerza_Tasa_Cero = 'SI')) then
 begin
    //bEntro := True;

    // 24-05-2007 Busca metodo de valuacion para valorización por tasa
    // Incluido para valorizaciones a tasa sin reajuste
    Reg_Val_In.Proceso_Valuacion    := 'OMD_TASA';
    Reg_Val_In.Valoriza_Par_Pte     := 'VAL';

    Busca_Valuacion( Reg_Val_In,
                     sTipo_Valuac,
                     sFormula_Pte,
                     fBase_Precio,
                     sMon_Ind,
                     sOrigen,
                     Result);

    if sTipo_Valuac <> '' then
    begin
       // Calcula el valor presente segun metodo de valuacion  28-05-2007 (F.I.)
       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result
                         );
       if NOT Result then
          exit;

       // Calcula el valor PAR (Necesario para porcentaje PAR)
       Reg_Val_In.Valoriza_Par_Pte := 'PAR';
       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result
                         );
    end
    else
    begin
       //1.)Llamo al Valorizador tal Cuál para que calcule Valor Invertido MC
       Reg_Val_In.Valoriza_Par_Pte := 'AMBOS';//'PTE';
       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result
                         );
    end;
    if not Result then
       Exit;


    //3.) Obtengo Porcentaje Valor Par a dos Decimales
    if Reg_Val_Out.Valor_Par_UM <> 0 then
       Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.ValorInvertidoUM/
                                              Reg_Val_Out.Valor_Par_UM * 100, 2)
    else
    begin
       // Por si Acaso
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Valor Par UM en Cero. Nemotécnico '+Reg_Val_In.Nemotecnico;
       Exit;
    end;

    //4.)Actualizo el Valor Invertido MC para el Porcentaje Actualizado a 2 Decimales
    // No se si es Valido
    // Ojo si es indice no redondeo los valores UM
    if sTipo_UnidadMonetaria <> 'I' then
       Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
                                                           Reg_Val_In.dFechaCalculo,
                                                           Reg_Val_Out.ValorInvertidoUM
                                                           );

    Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda_Mem( Reg_Val_In.sMoneda_Conversion,//Moneda Cartera
                                                         Reg_Val_In.dFechaCalculo,
                                                         Reg_Val_Out.ValorInvertidoMC
                                                        );
    // Obtengo Precio Sucio y Limpio
    Calcula_Precio_Sucio_Limpio('AMBOS'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    Exit;
 end;

 //*****************************************************************************
 // Caso 2 Vienen Nominales y Porcentaje Valor Par
 //*****************************************************************************
 if ( Reg_Val_Out.Nominales     <> 0 ) and
    ( Reg_Val_Out.PorcentajePar <> 0 ) then
 begin
    //bEntro := True;
    if (Reg_Formula_TIR.Cod_Utiliza_Precio = 'PRECIO') AND
       (Reg_Val_In.dFechaCalculo = Reg_Val_In.dFechaOperacion) then
       begin
         Reg_Val_Out.Valor_Par_UM     := Reg_Val_Out.Nominales;
         Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.Nominales * Reg_Val_Out.PorcentajePar;
         Reg_Val_Out.Valor_Par_MC     := Reg_Val_Out.Nominales * Reg_Val_Out.PorcentajePar;
         Reg_Val_Out.ValorInvertidoMC := Reg_Val_Out.Nominales * Reg_Val_Out.PorcentajePar;
         exit;
       end;

    // Por Si acaso Redondeo
    Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.PorcentajePar, 2);
    //1.) Debo Obtener porcentaje valor par um llamando  al valorizador
    Reg_Val_In.Valoriza_Par_Pte := 'PAR';
    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if not Result then
       Exit;

    { Los Valores pueden Modificar en la Llamada Siguiente a TIR
    { por lo tanto los restablesco y Guardo los valores Originales a PAR }
    fValor_Par_UM_Original := Reg_Val_Out.Valor_Par_UM;
//    fValor_Par_MC_Original := Reg_Val_Out.Valor_Par_MC;

    Reg_Val_In.Tabla_Desarr_Cargada := 'SI';

    //2.) Obtengo el valor Invertido UM y MC
    Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.Valor_Par_UM * Reg_Val_Out.PorcentajePar
                                   /Reg_Val_Out.RegDes.Base_Conversion;

    if sTipo_UnidadMonetaria <> 'I' then
    if sValorizacion_Proceso = 'SI' then
       Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
                                                           Reg_Val_In.dFechaCalculo,
                                                           Reg_Val_Out.ValorInvertidoUM)
    else
       Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
                                                       Reg_Val_In.dFechaCalculo,
                                                       Reg_Val_Out.ValorInvertidoUM);


    //1.) Convierto Valor Invertido UM  a Valor MC
    conversion_unidad_mon( Reg_Val_In.sUnidadMonetaria   // Moneda del Instrumento
                          ,Reg_Val_In.sMoneda_Conversion
                          ,'BC'
                          ,Reg_Val_In.dFechaCalculo
                          ,Reg_Val_Out.ValorInvertidoUM
                          ,Reg_Val_Out.ValorInvertidoMC
                          ,sModulo_Error
                          ,sString_Error
                          ,Result
                         );
    if not Result then
       Exit;

    if sValorizacion_Proceso = 'SI' then
       Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda_Mem(Reg_Val_In.sMoneda_Conversion,//Moneda Cartera
                                                           Reg_Val_In.dFechaCalculo,
                                                           Reg_Val_Out.ValorInvertidoMC)
    else
       Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,//Moneda Cartera
                                                       Reg_Val_In.dFechaCalculo,
                                                       Reg_Val_Out.ValorInvertidoMC);

    // Guardo Originales
    fValorInvertidoMC_Original := Reg_Val_Out.ValorInvertidoMC;
    fValorInvertidoUM_Original := Reg_Val_Out.ValorInvertidoUM;


    //Cargo Valores de Formulas para saber si es valorizacion
    // acumulada no calcule Tasa TIR
    { Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.
    carga_parametros_formulas(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                             ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                             ,Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,sModulo_Error
                             ,sString_Error
                             ,Result);
    }
    carga_parametros_formulas_Mem ( Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                   ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                   ,Reg_Formula_PAR
                                   ,Reg_Formula_TIR
                                   ,sModulo_Error
                                   ,sString_Error
                                   ,Result);

    if Not Result then
       begin
         // Caso TIR para Bono Reconocimiento ...
         if Reg_Val_In.Tipo_Instrumento = 'B' then
         begin
           Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;
           Reg_Val_In.Valoriza_Par_Pte := 'TIR';

           ValorizaBonoReco(Reg_Val_In.Nemotecnico
                           ,Reg_Val_In.dFechaCalculo
                           ,Reg_Val_In.Valoriza_Par_Pte
                           ,Reg_Val_Out.Nominales
                           ,Reg_Val_Out.TasaCalculo
                           ,Reg_Val_Out.PorcentajePar
                           ,Reg_Val_Out.ValorInvertidoUM
                           ,Reg_Val_Out.Valor_Par_UM
                           ,Reg_Val_Out.Valor_Par_MC
                           ,Reg_Val_Out.fValor_Final_UM
                           ,sModulo_Error
                           ,sString_Error
                           ,Result);

           exit;
         end
         else if Reg_Val_In.sInstrumento = 'CORA' then
         begin
             CALCULO_PTE_CORA(Reg_Val_In.sEmisor,
                              Reg_Val_In.sinstrumento,
                              Reg_Val_In.sserie,
                              Reg_Val_In.dFechaCalculo,
                              Reg_Val_In.dFechaEmision,
                              Reg_Val_In.dFechaVencimiento,
                              Reg_Val_Out.RegDes.Tasa_Valor_PAR,
                              Round(Reg_Val_Out.RegDes.NRO_CUPONES),
                              Reg_Val_Out.Nominales,
                              Reg_Val_Out.RegDes.Tasa_Emision,
                              Reg_Val_Out.TasaCalculo,
                              0,//  Ipc_emision, VALORES Obtenidos dentro de rutina de cálculo
                              0,//  Ipc_Calculo
                              Round(Reg_Val_Out.RegDes.BASE_CONVERSION),
                              Reg_Val_Out.Valor_Par_Base,
                              Reg_Val_Out.Valor_Par_UM,
                              Reg_Val_Out.PorcentajePar,
                              Reg_Val_Out.ValorInvertidoMC,
                              sModulo_error,
                              sString_error,
                              Result
                           );
            if Not Result then
               Exit;

            Reg_Val_Out.Valor_Par_MC     := Reg_Val_Out.Valor_Par_UM;
            Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;
            Exit;
         end
       end;

       //3.) Obtengo TIR
       //Reg_Val_In.Valoriza_Par_Pte := 'TIR';
       // Nuevo para buscar posibles metodos de valuacion parat Tasa F.I. 28-05-2007

       Reg_Val_In.Valoriza_Par_Pte  := 'TIR_VALUACION';
       Reg_Val_In.Proceso_Valuacion := 'OMD_TASA';

       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result);
//       Reg_Val_Out.TasaCalculo := Redondeo( Reg_Val_Out.TasaCalculo, 4);   // 02-08-2016 E.S. quité el redondeo para que se guarde con todos los decimales en la operación
                                                                             // el redondeo ocurre en la operación cuando ingresan un valor par y el sistema recalcula la tasa
    // Obtengo Precio Sucio y Limpio
    Calcula_Precio_Sucio_Limpio('AMBOS'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    if not Result then
       Exit;

    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;
    Reg_Val_Out.Valor_Par_UM     := fValor_Par_UM_Original;
    Reg_Val_Out.Valor_Par_UM     := fValor_Par_UM_Original;
    Exit;
 end;

 //*****************************************************************************
 //Caso 3 Viene Valor Nominal y Valor Invertido MC
 //*****************************************************************************
 if ( Reg_Val_Out.Nominales        <> 0 ) and
    ( Reg_Val_Out.ValorInvertidoMC <> 0 ) then
 begin
    //1.) Convierto Valor Invertido MC  a Valor UM
    conversion_unidad_mon( Reg_Val_In.sMoneda_Conversion
                          ,Reg_Val_In.sUnidadMonetaria // Moneda del Instrumento
                          ,'BC'
                          ,Reg_Val_In.dFechaCalculo
                          ,Reg_Val_Out.ValorInvertidoMC
                          ,Reg_Val_Out.ValorInvertidoUM
                          ,sModulo_Error
                          ,sString_Error
                          ,Result
                         );
    if not Result then
       Exit;

    fValorInvertidoMC_Original := Reg_Val_Out.ValorInvertidoMC;
    fValorInvertidoUM_Original := Reg_Val_Out.ValorInvertidoUM;

    //2.) Debo Obtener porcentaje valor par llamando al valorizador
    Reg_Val_In.Valoriza_Par_Pte := 'PAR';
    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if not Result then
       Exit;

    { Los Valores pueden haber sido modificados en la Llamada Anterior al Valorizador
    { por lo tanto los restablesco y Guardo los valores Originales a PAR }
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;

    fValor_Par_UM_Original := Reg_Val_Out.Valor_Par_UM;
    fValor_Par_MC_Original := Reg_Val_Out.Valor_Par_MC;

    { Indico que la Tabla de Desarrolo ya esta cargada }
    Reg_Val_In.Tabla_Desarr_Cargada := 'SI';

    //3.) Obtengo Porcentaje Valor Par
    if Reg_Val_Out.Valor_Par_UM <> 0 then
       Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.ValorInvertidoUM/
                                              Reg_Val_Out.Valor_Par_UM * 100, 2)
    else
    begin
       // Por si Acaso
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Valor Par UM en Cero';
       Exit;
    end;

    fPorcentaje_Par_Original := Reg_Val_Out.PorcentajePar;

    //Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
    //                                                Reg_Val_In.dFechaCalculo,
    //                                                Reg_Val_Out.ValorInvertidoUM);

    //Cargo Valores de Formulas para saber si es valorizacion
    // acumulada no calcule Tasa TIR
   { Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.
    carga_parametros_formulas(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                             ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                             ,Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,sModulo_Error
                             ,sString_Error
                             ,Result);
    }
    carga_parametros_formulas_Mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                             ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                             ,Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,sModulo_Error
                             ,sString_Error
                             ,Result);

    if NOT Result then
       begin
         // Caso TIR para Bono Reconocimiento ...
         if Reg_Val_In.Tipo_Instrumento = 'B' then
            begin
              Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;
              Reg_Val_In.Valoriza_Par_Pte := 'TIR';

              ValorizaBonoReco(Reg_Val_In.Nemotecnico
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_In.Valoriza_Par_Pte
                              ,Reg_Val_Out.Nominales
                              ,Reg_Val_Out.TasaCalculo
                              ,Reg_Val_Out.PorcentajePar
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.Valor_Par_UM
                              ,Reg_Val_Out.Valor_Par_MC
                              ,Reg_Val_Out.fValor_Final_UM
                              ,sModulo_Error
                              ,sString_Error
                              ,Result);

              exit;
            end;
       end;

       //4.) Debo Obtener TIR
       //Reg_Val_In.Valoriza_Par_Pte := 'TIR';
       // Nuevo para buscar posibles metodos de valuacion parat Tasa F.I. 28-05-2007

       Reg_Val_In.Valoriza_Par_Pte  := 'TIR_VALUACION';
       Reg_Val_In.Proceso_Valuacion := 'OMD_TASA';

       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result);
       if not Result then
          Exit;
//       Reg_Val_Out.TasaCalculo := Redondeo( Reg_Val_Out.TasaCalculo, 4);     // 02-08-2016 E.S. quité el redondeo para que se guarde con todos los decimales en la operación
                                                                               // el redondeo ocurre en la operación cuando ingresan un valor par y el sistema recalcula la tasa

    // Obtengo Precio Sucio y Limpio
    Calcula_Precio_Sucio_Limpio('AMBOS'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    if not Result then
       Exit;

    { Los Valores pueden haber sido modificados en la Llamada Anterior al Valorizador
    { por lo tanto los restablesco }
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;
    Reg_Val_Out.Valor_Par_UM     := fValor_Par_UM_Original;
    Reg_Val_Out.Valor_Par_MC     := fValor_Par_MC_Original;
    Reg_Val_Out.PorcentajePar    := fPorcentaje_Par_Original;
    exit;
 end;

 //*****************************************************************************
 // Caso 4 Viene Tasa de Calculo y Valor Invertido
 //*****************************************************************************
 if ( Reg_Val_Out.ValorInvertidoMC   <> 0 ) and
    ( Reg_Val_Out.TasaCalculo <> 0 ) then
 begin
    // Guardo Originales
    fValorInvertidoMC_Original := Reg_Val_Out.ValorInvertidoMC;
    fValorInvertidoUM_Original := Reg_Val_Out.ValorInvertidoUM;

    if fValorInvertidoUM_Original = 0 then
    begin
       // Trata de obtener conversion automatica
       Conversion_unidad_mon(Reg_Val_In.sMoneda_Conversion
                            ,Reg_Val_In.sUnidadMonetaria
                            ,'BC'
                            ,Reg_Val_In.dFechaCalculo
                            ,fValorInvertidoMC_Original
                            ,fValorInvertidoUM_Original
                            ,sModulo_Error
                            ,sString_Error
                            ,Result);
       if Not Result then
          Exit;

       Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;
    end;

    //1.)Obtengo Valor PAR y PTE
    Reg_Val_Out.Nominales       := 100; //Base 100
    Reg_Val_In.Valoriza_Par_Pte := 'AMBOS';
    // 24-05-2007 Busca metodo de valuacion para valorización por tasa
    // Incluido para valorizaciones a tasa sin reajuste
    Reg_Val_In.Proceso_Valuacion    := 'OMD_TASA';
    Reg_Val_In.Valoriza_Par_Pte     := 'VAL';

    Busca_Valuacion( Reg_Val_In,
                     sTipo_Valuac,
                     sFormula_Pte,
                     fBase_Precio,
                     sMon_Ind,
                     sOrigen,
                     Result);

    if sTipo_Valuac <> '' then
    begin
       // Calcula el valor presente segun metodo de valuacion  28-05-2007 (F.I.)
       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result
                         );
       if NOT Result then
          exit;

       // Calcula el valor PAR (Necesario para porcentaje PAR)
       Reg_Val_In.Valoriza_Par_Pte := 'PAR';
       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result
                         );
    end
    else
    begin
       //1.)Llamo al Valorizador tal Cuál para que calcule Valor Invertido MC
       Reg_Val_In.Valoriza_Par_Pte := 'AMBOS';//'PTE';
       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result
                         );
    end;

    {
    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if not Result then
       Exit;
    }
    //2.) Obtengo Porcentaje Valor Par a dos Decimales
    if Reg_Val_Out.Valor_Par_UM <> 0 then
       Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.ValorInvertidoUM/
                                              Reg_Val_Out.Valor_Par_UM * 100, 2)
    else
    begin
       // Por si Acaso
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Valor Par UM en Cero. Nemotécnico '+Reg_Val_In.Nemotecnico;
       Exit;
    end;

    Reg_Val_Out.Nominales := (fValorInvertidoUM_Original / Reg_Val_Out.ValorInvertidoUM)*100;

    // Obtengo Precio Sucio y Limpio
    Calcula_Precio_Sucio_Limpio('AMBOS'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    if not Result then
       Exit;
    //Restablesco Valores Originales
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;
    Exit;
 end;

 //*****************************************************************************
 // Caso 5 Viene Valor_Nominal y Precio Sucio
 //*****************************************************************************
 if ( Reg_Val_Out.Nominales   <> 0 ) and
    ( Reg_Val_Out.Precio_Sucio <> 0 ) then
 begin
    Reg_Val_In.Proceso_Valuacion    := 'OMD_P_DIRT';
    Reg_Val_In.Valoriza_Par_Pte     := 'VAL';

    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if NOT Result then
       exit;

    fValorInvertidoMC_Original := Reg_Val_Out.ValorInvertidoMC;
    fValorInvertidoUM_Original := Reg_Val_Out.ValorInvertidoUM;

    //2.) Debo Obtener porcentaje valor par llamando al valorizador
    Reg_Val_In.Valoriza_Par_Pte := 'PAR';
    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if not Result then
       Exit;

    { Los Valores Presente pueden haber sido modificados en la Llamada Anterior al Valorizador
    { por lo tanto los restablesco y Guardo los valores Originales a PAR }
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;

    fValor_Par_UM_Original := Reg_Val_Out.Valor_Par_UM;
    fValor_Par_MC_Original := Reg_Val_Out.Valor_Par_MC;

    { Indico que la Tabla de Desarrolo ya esta cargada }
    Reg_Val_In.Tabla_Desarr_Cargada := 'SI';

    //3.) Obtengo Porcentaje Valor Par
    if Reg_Val_Out.Valor_Par_UM <> 0 then
       Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.ValorInvertidoUM/
                                              Reg_Val_Out.Valor_Par_UM * 100, 2)
    else
    begin
       // Por si Acaso
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Valor Par UM en Cero';
       Exit;
    end;

    fPorcentaje_Par_Original := Reg_Val_Out.PorcentajePar;

    Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
                                                    Reg_Val_In.dFechaCalculo,
                                                    Reg_Val_Out.ValorInvertidoUM);

    //Cargo Valores de Formulas para saber si es valorizacion
    // acumulada no calcule Tasa TIR
     { Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.
      carga_parametros_formulas(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                             ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                             ,Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,sModulo_Error
                             ,sString_Error
                             ,Result);
     }
      carga_parametros_formulas_Mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                   ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                   ,Reg_Formula_PAR
                                   ,Reg_Formula_TIR
                                   ,sModulo_Error
                                   ,sString_Error
                                   ,Result);

    if NOT Result then
       begin
         // Caso TIR para Bono Reconocimiento ...
         if Reg_Val_In.Tipo_Instrumento = 'B' then
            begin
              Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;
              Reg_Val_In.Valoriza_Par_Pte := 'TIR';

              ValorizaBonoReco(Reg_Val_In.Nemotecnico
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_In.Valoriza_Par_Pte
                              ,Reg_Val_Out.Nominales
                              ,Reg_Val_Out.TasaCalculo
                              ,Reg_Val_Out.PorcentajePar
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.Valor_Par_UM
                              ,Reg_Val_Out.Valor_Par_MC
                              ,Reg_Val_Out.fValor_Final_UM
                              ,sModulo_Error
                              ,sString_Error
                              ,Result);

              exit;
            end;
       end;

       //4.) Debo Obtener TIR
       //Reg_Val_In.Valoriza_Par_Pte := 'TIR';
       // Nuevo para buscar posibles metodos de valuacion parat Tasa F.I. 28-05-2007

       Reg_Val_In.Valoriza_Par_Pte  := 'TIR_VALUACION';
       Reg_Val_In.Proceso_Valuacion := 'OMD_TASA';

       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result);
       if not Result then
          Exit;
//       Reg_Val_Out.TasaCalculo := Redondeo( Reg_Val_Out.TasaCalculo, 4);     // 02-08-2016 E.S. quité el redondeo para que se guarde con todos los decimales en la operación
                                                                               // el redondeo ocurre en la operación cuando ingresan un valor par y el sistema recalcula la tasa

    // Obtengo Precio Limpio
    // Obtengo Precio Sucio y Limpio
    Calcula_Precio_Sucio_Limpio('LIMPIO'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    if not Result then
       Exit;

    { Los Valores pueden haber sido modificados en la Llamada Anterior al Valorizador
    { por lo tanto los restablesco }
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;
    Reg_Val_Out.Valor_Par_UM     := fValor_Par_UM_Original;
    Reg_Val_Out.Valor_Par_MC     := fValor_Par_MC_Original;
    Reg_Val_Out.PorcentajePar    := fPorcentaje_Par_Original;
    Exit;
 end;

  //*****************************************************************************
 // Caso 6 Viene Valor_Nominal y Precio Limpio
 //*****************************************************************************
 if ( Reg_Val_Out.Nominales   <> 0 ) and
    ( Reg_Val_Out.Precio_Limpio <> 0 ) then
 begin
    Reg_Val_In.Proceso_Valuacion    := 'OMD_P_CLEA';
    Reg_Val_In.Valoriza_Par_Pte     := 'VAL';

    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if NOT Result then
       exit;

    fValorInvertidoMC_Original := Reg_Val_Out.ValorInvertidoMC;
    fValorInvertidoUM_Original := Reg_Val_Out.ValorInvertidoUM;

    //2.) Debo Obtener porcentaje valor par llamando al valorizador
    Reg_Val_In.Valoriza_Par_Pte := 'PAR';
    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if not Result then
       Exit;

    { Los Valores Presente pueden haber sido modificados en la Llamada Anterior al Valorizador
    { por lo tanto los restablesco y Guardo los valores Originales a PAR }
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;

    fValor_Par_UM_Original := Reg_Val_Out.Valor_Par_UM;
    fValor_Par_MC_Original := Reg_Val_Out.Valor_Par_MC;

    { Indico que la Tabla de Desarrolo ya esta cargada }
    Reg_Val_In.Tabla_Desarr_Cargada := 'SI';

    //3.) Obtengo Porcentaje Valor Par
    if Reg_Val_Out.Valor_Par_UM <> 0 then
       Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.ValorInvertidoUM/
                                              Reg_Val_Out.Valor_Par_UM * 100, 2)
    else
    begin
       // Por si Acaso
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Valor Par UM en Cero';
       Exit;
    end;

    fPorcentaje_Par_Original := Reg_Val_Out.PorcentajePar;
    Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
                                                    Reg_Val_In.dFechaCalculo,
                                                    Reg_Val_Out.ValorInvertidoUM);

    //Cargo Valores de Formulas para saber si es valorizacion
    // acumulada no calcule Tasa TIR
     { Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.
      carga_parametros_formulas(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                             ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                             ,Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,sModulo_Error
                             ,sString_Error
                             ,Result);
     }

      carga_parametros_formulas_Mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                   ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                   ,Reg_Formula_PAR
                                   ,Reg_Formula_TIR
                                   ,sModulo_Error
                                   ,sString_Error
                                   ,Result);
    if NOT Result then
       begin
         // Caso TIR para Bono Reconocimiento ...
         if Reg_Val_In.Tipo_Instrumento = 'B' then
            begin
              Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoMC;
              Reg_Val_In.Valoriza_Par_Pte := 'TIR';

              ValorizaBonoReco(Reg_Val_In.Nemotecnico
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_In.Valoriza_Par_Pte
                              ,Reg_Val_Out.Nominales
                              ,Reg_Val_Out.TasaCalculo
                              ,Reg_Val_Out.PorcentajePar
                              ,Reg_Val_Out.ValorInvertidoUM
                              ,Reg_Val_Out.Valor_Par_UM
                              ,Reg_Val_Out.Valor_Par_MC
                              ,Reg_Val_Out.fValor_Final_UM
                              ,sModulo_Error
                              ,sString_Error
                              ,Result);

              exit;
            end;
       end;

       //4.) Debo Obtener TIR
       //Reg_Val_In.Valoriza_Par_Pte := 'TIR';
       // Nuevo para buscar posibles metodos de valuacion parat Tasa F.I. 28-05-2007

       Reg_Val_In.Valoriza_Par_Pte  := 'TIR_VALUACION';
       Reg_Val_In.Proceso_Valuacion := 'OMD_TASA';
       
       Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result);
       if not Result then
          Exit;
//       Reg_Val_Out.TasaCalculo := Redondeo( Reg_Val_Out.TasaCalculo, 4);    // 02-08-2016 E.S. quité el redondeo para que se guarde con todos los decimales en la operación
                                                                              // el redondeo ocurre en la operación cuando ingresan un valor par y el sistema recalcula la tasa

    { Los Valores pueden haber sido modificados en la Llamada Anterior al Valorizador
    { por lo tanto los restablesco }
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;
    Reg_Val_Out.Valor_Par_UM     := fValor_Par_UM_Original;
    Reg_Val_Out.Valor_Par_MC     := fValor_Par_MC_Original;
    Reg_Val_Out.PorcentajePar    := fPorcentaje_Par_Original;


    // Obtengo Precio Sucio
    Calcula_Precio_Sucio_Limpio('SUCIO'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    Exit;
 end;

 //*****************************************************************************
 // Caso 7 Viene solo el Valor Nominal (Calcula Tir)
 //*****************************************************************************
 if ( Reg_Val_Out.Nominales   <> 0 ) then
 begin
    if (Reg_Val_In.Tipo_Instrumento = 'B') or
       (Reg_Val_In.sInstrumento     = 'CORA') then
    begin
       Result := True;
       Exit;
    end;

    if NOT ((Reg_Formula_TIR.Cod_Utiliza_Tasa = 'TASA_CERO') OR
            (Reg_Formula_TIR.Valoriza_Acumulado = 'S') )then
    begin
       Result := True;
       Exit;
    end;

    //bEntro := True;
    //1.)Llamo al Valorizador tal Cuál para que calcule Valor Invertido MC
    Reg_Val_In.Valoriza_Par_Pte := 'PTE';

    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);

    if not Result then
       Exit;

    // Guardo Originales
    fValorInvertidoMC_Original := Reg_Val_Out.ValorInvertidoMC;
    fValorInvertidoUM_Original := Reg_Val_Out.ValorInvertidoUM;
    Reg_Val_In.Tabla_Desarr_Cargada := 'SI';

    //2.) Debo Obtener porcentaje valor par llamando al valorizador
    //Para Calcular Porcentaje Valor Par
    Reg_Val_In.Valoriza_Par_Pte := 'PAR';
    Valoriza_Registro(Reg_Val_In,
                      Reg_Val_Out,
                      sModulo_Error,
                      sString_Error,
                      Result);
    if not Result then
       Exit;

    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;

    //3.) Obtengo Porcentaje Valor Par
    if Reg_Val_Out.Valor_Par_UM <> 0 then
       Reg_Val_Out.PorcentajePar := Redondeo( Reg_Val_Out.ValorInvertidoUM/
                                              Reg_Val_Out.Valor_Par_UM * 100, 2)
    else
    begin
       // Por si Acaso
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Valor Par UM en Cero. Nemotécnico '+Reg_Val_In.Nemotecnico;
       Exit;
    end;

    //4.) Obtengo TIR
    //Reg_Val_In.Valoriza_Par_Pte := 'TIR';
    // Nuevo para buscar posibles metodos de valuacion parat Tasa F.I. 28-05-2007

    Reg_Val_In.Valoriza_Par_Pte  := 'TIR_VALUACION';
    Reg_Val_In.Proceso_Valuacion := 'OMD_TASA';
    Valoriza_Registro(Reg_Val_In,
                         Reg_Val_Out,
                         sModulo_Error,
                         sString_Error,
                         Result);
    if not Result then
        Exit;
//    Reg_Val_Out.TasaCalculo := Redondeo( Reg_Val_Out.TasaCalculo, 4);   // 02-08-2016 E.S. quité el redondeo para que se guarde con todos los decimales en la operación
                                                                          // el redondeo ocurre en la operación cuando ingresan un valor par y el sistema recalcula la tasa

    //Restablesco Valores Originales
    Reg_Val_Out.ValorInvertidoMC := fValorInvertidoMC_Original;
    Reg_Val_Out.ValorInvertidoUM := fValorInvertidoUM_Original;


    //5.)Actualizo el Valor Invertido MC para el Porcentaje Actualizado a 2 Decimales
    // No se si es Valido
    if sValorizacion_Proceso = 'SI' then
    begin
       Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda_Mem(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
                                                           Reg_Val_In.dFechaCalculo,
                                                           Reg_Val_Out.ValorInvertidoUM);
       Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda_Mem(Reg_Val_In.sMoneda_Conversion,//Moneda Cartera
                                                           Reg_Val_In.dFechaCalculo,
                                                           Reg_Val_Out.ValorInvertidoMC);
    end
    else
    begin
       Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,//Moneda Instrumento
                                                       Reg_Val_In.dFechaCalculo,
                                                       Reg_Val_Out.ValorInvertidoUM);
       Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,//Moneda Cartera
                                                       Reg_Val_In.dFechaCalculo,
                                                       Reg_Val_Out.ValorInvertidoMC);
    end;

    // Obtengo Precio Sucio y Limpio
    Calcula_Precio_Sucio_Limpio('AMBOS'
                               ,''
                               ,''
                               ,Reg_Val_In
                               ,Reg_Val_Out
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
    if not Result then
       Exit;

    Exit;
 end;

 if (Not bEntro) and (Result) then
    Reg_Val_In.Re_Llamado := 'NO';
end;


procedure Cambio_fecha_Devengamiento( var Reg_Val_In    : TRegistro_Valoriza_In;
                                        Reg_Formula_PAR : TRegFormulaPAR;
                                        Reg_Formula_TIR : TRegFormulaTIR;
                                    var Reg_Fechas      : TRegistro_Fechas;
                                    var Modulo_Err : String;
                                    var String_Err : String;
                                    var Result     : Boolean
                                   );
var sTratam_Devengamiento : String;
    dFecha_Devengamiento  : TDatetime;
    //dFecha_Devengamiento_Compra  : TDatetime;
    //aux_reg_fechas        : TRegistro_Fechas;
begin
    Result := True;
    if BuscaStr(Reg_Val_In.sInstrumento,'FW-') then
       exit;

    if  (Reg_Formula_PAR.Aplica_Devengamiento = 'S') or
        (Reg_Formula_TIR.Aplica_Devengamiento = 'S') then
    begin
        sTratam_Devengamiento := '';
        if Trim(Reg_Formula_TIR.Tratam_Devengamiento) <> '' then
           sTratam_Devengamiento := Reg_Formula_TIR.Tratam_Devengamiento;

        if Trim(Reg_Formula_PAR.Tratam_Devengamiento) <> '' then
           sTratam_Devengamiento := Reg_Formula_PAR.Tratam_Devengamiento;

        Tratamiento_Fecha(sTratam_Devengamiento
                          ,Reg_Fechas
                          ,dFecha_Devengamiento
                          ,Modulo_Err
                          ,String_Err
                          ,Result
                          );
        if NOT Result then
           exit;

        // 24-11-2007 Se cambia tambien la fecha de compra
        // Ya que para los casos de TIRK no estabamos siendo consistentes. F.I.

        // Se hace execpcion para llamado del libro de ventas
        // Ya que estaba poniendo en la fecha de compra la fecha de pago de la venta
        // El libro de ventas envia en la fecha de compra la fecha de devengamiento correcta 08-04-2008 F.I.

        if (Reg_Val_In.Modulo_Llamado <> 'LIBRO VENTAS') then
          if dFecha_Devengamiento > Reg_Val_In.dFechaCompra  then
             Reg_Val_In.dFechaCompra  := dFecha_Devengamiento;

        //ggarcia 21-04-2022
        //Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;  //no se puede asignar aca ya que pasa mas de una vez
        if dFecha_Devengamiento > Reg_Val_In.dFechaCalculo  then
        begin
           Reg_Val_In.dFechaCalculo  := dFecha_Devengamiento;
           //ggarcia 23-11-2023
           //Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
           Reg_Fechas.Fecha_Calculo  := dFecha_Devengamiento;
        end;
    end;
end;


procedure Calcula_Precio_Sucio_Limpio(sTipo_Precio      : String;
                                      sTipo_Valuac_Fijo_CLEAN    : String;
                                      sTipo_Valuac_Fijo_PX_DIRTY : String;
                                     var Reg_Val_In    : TRegistro_Valoriza_In;
                                     var Reg_Val_Out   : TRegistro_Valoriza_Out;
                                     var sModulo_Error : String;
                                     var sString_Error : String;
                                     var Result        : Boolean);
var
   Registro_Fechas : TRegistro_Fechas;
   sMetodo_Sin_Tasa_Referencia : String;
   fSaldo_Insoluto             : Double;
   fSaldo_Insoluto_SinRea      : Double;
   fReajuste_Capital           : Double;
   Parametros_Formula          : TRegFormulaPAR;
   iNro_Cupon                  : Integer;
   dFecha_Desde                : TDateTime;
   fInteres_Acum_UM            : Double;
   fInteres_Acum_MC            : Double;
   fInteres_Acum_UM_REAJUSTADO : Double;
   fReajuste_Indexado          : Double;
   fAjuste_Reajuste_Indexado   : Double;
   fReajuste_NO_Indexado       : Double;
   sTipo_Valuac_PX_CLEAN       : String;
   sTipo_Valuac_PX_DIRTY       : String;
   fBase_Precio_PX_CLEAN       : Double;
   fBase_Precio_PX_DIRTY       : Double;
   sFormula_Pte                : String;
   sMon_Ind_Clean              : String;
   sMon_Ind_Dirty              : String;
   sOrigen_Clean               : String;
   sOrigen_Dirty               : String;

begin
sModulo_Error := '';
sString_Error := '';

if (sTipo_Valuac_Fijo_CLEAN = '') and (sTipo_Valuac_Fijo_PX_DIRTY = '') Then
Begin
    if (sTipo_Precio = 'LIMPIO') OR
       (sTipo_Precio = 'AMBOS') Then
    begin
      Reg_Val_Out.Precio_Limpio := 0;
      Reg_Val_In.Proceso_Valuacion := 'OMD_P_CLEA';
      { Se movio mas abajo D.C. & F.I. 03-03-2011
        Se descomenta con fecha 03-05-2011
      }
      if sValorizacion_Proceso = 'SI' then
         Busca_Valuacion_Mem (Reg_Val_In,
                              sTipo_Valuac_PX_CLEAN,
                              sFormula_Pte,
                              fBase_Precio_PX_CLEAN,
                              sMon_Ind_Clean,
                              sOrigen_Clean,
                              Result)
      else
         Busca_Valuacion( Reg_Val_In,
                           sTipo_Valuac_PX_CLEAN,
                           sFormula_Pte,
                           fBase_Precio_PX_CLEAN,
                           sMon_Ind_Clean,
                           sOrigen_Clean,
                           Result);
    end;

    if (sTipo_Precio = 'SUCIO') OR
       (sTipo_Precio = 'AMBOS') Then
    begin
      Reg_Val_Out.Precio_Sucio := 0;
      Reg_Val_In.Proceso_Valuacion := 'OMD_P_DIRT';
      { Se movio mas abajo D.C. & F.I. 03-03-2010
        Se descomenta con fecha 03-05-2011
      }
      if sValorizacion_Proceso = 'SI' then
         Busca_Valuacion_Mem (Reg_Val_In,
                              sTipo_Valuac_PX_DIRTY,
                              sFormula_Pte,
                              fBase_Precio_PX_DIRTY,
                              sMon_Ind_Dirty,
                              sOrigen_Dirty,
                              Result)
      else
         Busca_Valuacion( Reg_Val_In,
                          sTipo_Valuac_PX_DIRTY,
                          sFormula_Pte,
                          fBase_Precio_PX_DIRTY,
                          sMon_Ind_Dirty,
                          sOrigen_Dirty,
                          Result);
    end;
    if NOT result then
    begin
       Result := True;
       exit;
    end;
End
else
begin
    sTipo_Valuac_PX_CLEAN := sTipo_Valuac_Fijo_CLEAN;
    sTipo_Valuac_PX_DIRTY := sTipo_Valuac_Fijo_PX_DIRTY;

    if Reg_val_In.Proceso_Valuacion <> 'SINVALUAC' then   // DC 12/08/2011
    begin
      // Ultimo cambio D.C. con F.I. 03/05/2011
      if (sTipo_Precio = 'LIMPIO') OR
          (sTipo_Precio = 'AMBOS') Then
      begin
         if sValorizacion_Proceso = 'SI' then
            Busca_Valuacion_Mem (Reg_Val_In,
                                 sTipo_Valuac_PX_CLEAN,
                                 sFormula_Pte,
                                 fBase_Precio_PX_CLEAN,
                                 sMon_Ind_Clean,
                                 sOrigen_Clean,
                                 Result)
         else
            Busca_Valuacion( Reg_Val_In,
                              sTipo_Valuac_PX_CLEAN,
                              sFormula_Pte,
                              fBase_Precio_PX_CLEAN,
                              sMon_Ind_Clean,
                              sOrigen_Clean,
                              Result);
         if NOT result then
         begin
            Result := True;
            exit;
         end;
      end;

      if (sTipo_Precio = 'SUCIO') OR
         (sTipo_Precio = 'AMBOS') Then
      begin
         if sValorizacion_Proceso = 'SI' then
            Busca_Valuacion_Mem (Reg_Val_In,
                                 sTipo_Valuac_PX_DIRTY,
                                 sFormula_Pte,
                                 fBase_Precio_PX_DIRTY,
                                 sMon_Ind_Dirty,
                                 sOrigen_Dirty,
                                 Result)
         else
            Busca_Valuacion( Reg_Val_In,
                             sTipo_Valuac_PX_DIRTY,
                             sFormula_Pte,
                             fBase_Precio_PX_DIRTY,
                             sMon_Ind_Dirty,
                             sOrigen_Dirty,
                             Result);
         if NOT result then
         begin
           Result := True;
           exit;
         end;
      end;
    end;
end;

if (sTipo_Valuac_PX_DIRTY = 'PRECNOM') AND
   ((sTipo_Precio = 'SUCIO') OR
    (sTipo_Precio = 'AMBOS')) Then
  if Reg_Val_Out.Nominales <> 0 then
     Reg_Val_Out.Precio_Sucio := Reg_Val_Out.ValorInvertidoUM /
                                 Reg_Val_Out.Nominales *
                                 fBase_Precio_PX_DIRTY
  else
     Reg_Val_Out.Precio_Sucio := 0;

if (sTipo_Valuac_PX_CLEAN = 'PRECNOM') AND
   ((sTipo_Precio = 'LIMPIO') OR
    (sTipo_Precio = 'AMBOS')) Then
   if Reg_Val_Out.Nominales <> 0 then
      Reg_Val_Out.Precio_Limpio := Reg_Val_Out.ValorInvertidoUM /
                                   Reg_Val_Out.Nominales *
                                   fBase_Precio_PX_CLEAN
   else
      Reg_Val_Out.Precio_Limpio := 0;

if ((sTipo_Valuac_PX_DIRTY = 'PRECTITULO') or (sTipo_Valuac_PX_DIRTY = 'PRECTIT+i')) AND
   ((sTipo_Precio = 'SUCIO') OR
    (sTipo_Precio = 'AMBOS')) Then
begin
   if sMon_Ind_Dirty = '' Then
   begin
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Falta el ingreso de la moneda en Método de Valuación. Proceso : '+Reg_Val_In.Proceso_Valuacion +' Tipo Valuacion : '+sTipo_Valuac_PX_DIRTY;
       exit;
   end;
   if Reg_Val_In.Numero_Titulos <= 0 Then
   begin
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Numero de Títulos <= 0, se debe ingresar ';
       exit;
   end;
   if Reg_Val_In.Numero_Titulos <> 0 then
   begin
      Reg_Val_Out.Precio_Sucio := Reg_Val_Out.ValorInvertidoUM /
                                  Reg_Val_In.Numero_Titulos;

      if fBase_Precio_PX_DIRTY = 0 then
         fBase_Precio_PX_DIRTY := 1;

      Reg_Val_Out.Precio_Sucio := Reg_Val_Out.Precio_Sucio * fBase_Precio_PX_DIRTY;

      // Se debe convertir el precio obtenido de Reg_Val_In.sUnidadMonetaria a sMon_Ind_Dirty
      //Se lleva precio a moneda de método de valuación
      Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                           ,sMon_Ind_Dirty
                           ,'BC'
                           ,Reg_Val_In.dFechaCalculo
                           ,Reg_Val_Out.Precio_Sucio
                           ,Reg_Val_Out.Precio_Sucio
                           ,sModulo_Error
                           ,sString_Error
                           ,Result);
      if NOT Result then
         exit;
   end
   else
      Reg_Val_Out.Precio_Sucio := 0;
end;

{
if (sTipo_Valuac_PX_CLEAN = 'PRECTITULO') AND
   ((sTipo_Precio = 'LIMPIO') OR
    (sTipo_Precio = 'AMBOS')) Then
begin
   if sMon_Ind_Clean = '' Then
   begin
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Falta el ingreso de la moneda en Método de Valuación. Proceso : '+Reg_Val_In.Proceso_Valuacion +' Tipo Valuacion : '+sTipo_Valuac_PX_CLEAN;
       exit;
   end;
   if Reg_Val_In.Numero_Titulos <= 0 Then
   begin
       Result       := False;
       sModulo_Error:= 'Módulo de Valorización :';
       sString_Error:= 'Numero de Títulos en 0, se debe ingresar ';
       exit;
   end;


   if Reg_Val_In.Numero_Titulos <> 0 then
   begin
      Reg_Val_Out.Precio_Limpio := Reg_Val_Out.ValorInvertidoUM /
                                   Reg_Val_In.Numero_Titulos;

      if fBase_Precio_PX_CLEAN = 0 then
         fBase_Precio_PX_CLEAN := 1;

      Reg_Val_Out.Precio_Sucio := Reg_Val_Out.Precio_Sucio * fBase_Precio_PX_CLEAN;

     // Se debe convertir el precio obtenido de Reg_Val_In.sUnidadMonetaria a sMon_Ind_Clean
      Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                           ,sMon_Ind_Clean
                           ,'BC'
                           ,Reg_Val_In.dFechaCalculo
                           ,Reg_Val_Out.Precio_Limpio
                           ,Reg_Val_Out.Precio_Limpio
                           ,sModulo_Error
                           ,sString_Error
                           ,Result);
      if NOT Result then
         exit;
   end
   else
      Reg_Val_Out.Precio_Limpio := 0;
end;
}
if (sTipo_Valuac_PX_CLEAN = 'PRECMERC')   OR
   (sTipo_Valuac_PX_CLEAN = 'PRECNOMINT') OR
   (sTipo_Valuac_PX_CLEAN = 'KINTERES')   OR
   (sTipo_Valuac_PX_CLEAN = 'PX-CLEAN-O') OR
   (sTipo_Valuac_PX_CLEAN = 'PX-DIRTY-O') OR
   (sTipo_Valuac_PX_CLEAN = 'PRENOMINTR') OR  // (Nominales * Precio) + Interes + Reajuste Capital
   (sTipo_Valuac_PX_CLEAN = 'PRENOM+REA') OR  // (Nominales * Precio) + Reajuste Capital
   (sTipo_Valuac_PX_CLEAN = 'KNR+INT+RE') OR  // Capital Residual (sin Reajuste) + Intereses + Reajuste Capital
   (sTipo_Valuac_PX_CLEAN = 'KNR+REACAP') OR  // Capital Residual (sin Reajuste) + Reajuste Capital
   (sTipo_Valuac_PX_CLEAN = 'VPT-LIMPIO') OR
   (sTipo_Valuac_PX_CLEAN = 'VPN-LIMPIO') OR
   (sTipo_Valuac_PX_DIRTY = 'PRECMERC')   OR
   (sTipo_Valuac_PX_DIRTY = 'KINTERES')   OR
   (sTipo_Valuac_PX_DIRTY = 'PRENOMINTR') OR  // (Nominales * Precio) + Interes + Reajuste Capital
   (sTipo_Valuac_PX_DIRTY = 'PRENOM+REA') OR  // (Nominales * Precio) + Reajuste Capital
   (sTipo_Valuac_PX_DIRTY = 'KNR+INT+RE') OR  // Capital Residual (sin Reajuste) + Intereses + Reajuste Capital
   (sTipo_Valuac_PX_DIRTY = 'KNR+REACAP') OR  // Capital Residual (sin Reajuste) + Reajuste Capital
   (sTipo_Valuac_PX_CLEAN = 'KINTERESNR') OR
   (sTipo_Valuac_PX_DIRTY = 'PRECMERCNR') OR
   (sTipo_Valuac_PX_DIRTY = 'VPT-LIMPIO') OR
   (sTipo_Valuac_PX_DIRTY = 'VPN-LIMPIO') OR
   (sTipo_Valuac_PX_DIRTY = 'PX-CLEAN-O') OR
   (sTipo_Valuac_PX_CLEAN = 'PRECTITULO') OR
   (sTipo_Valuac_PX_CLEAN = 'PRECTIT+i')  OR
   (sTipo_Valuac_PX_DIRTY = 'PX-DIRTY-O') then
begin
  // Calculamos Saldo Insoluto (Capital Residual)
  Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;
  Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
  Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
  Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
  Registro_Fechas.Fecha_Pago        := Reg_Val_In.dFechaPago;
  if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
     begin
       Carga_RegDes(Reg_Val_In.Tipo_Instrumento
                   ,Reg_Val_In.sEmisor
                   ,Reg_Val_In.sEmisor
                   ,Reg_Val_In.sInstrumento
                   ,Reg_Val_In.sSerie
                   ,Reg_Val_In.sMoneda_Conversion
                   ,Reg_Val_In.dTasaEmision
                   ,Reg_Val_Out.RegDes
                   ,sModulo_Error
                   ,sString_Error
                   ,Result);
        if NOT Result then
           exit;
        Reg_Val_In.Descriptor_Cargado := 'SI';

        Carga_TabDesarr(Reg_Val_In.Tipo_Instrumento
                       ,Reg_Val_In.sEmisor
                       ,Reg_Val_In.sInstrumento
                       ,Reg_Val_In.sSerie
                       ,Reg_Val_In.Nemotecnico
                       ,Reg_Val_In.sTipoNominales
                       ,Reg_Val_Out.Nominales
                       ,Reg_Val_In.dTasaEmision
                       ,Reg_Val_In.dFechaEmision
                       ,Reg_Val_In.dFechaVencimiento
                       ,Reg_Val_In.dFechaCalculo
                       ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                       ,Reg_Val_In.Con_Cupon
                       ,Reg_Val_Out.Array_Mem_Desarr
                       ,Reg_Val_Out.RegDes
                       ,Registro_Fechas
                       ,sMetodo_Sin_Tasa_Referencia
                       ,Parametros_Formula
                       ,sModulo_Error
                       ,sString_Error
                       ,Result);

       if NOT Result then
          exit;
       Reg_Val_In.Tabla_Desarr_Cargada := 'SI'
     end;

  Saldo_Insoluto(Reg_Val_In.Tipo_Instrumento
                ,Reg_Val_Out.RegDes
                ,Reg_Val_In.dFechaEmision
                ,Reg_Val_In.dFechaCalculo
                ,Reg_Val_In.dFechaCompra      //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                ,Reg_Val_Out.Nominales
                ,Reg_Val_Out.Array_Mem_Desarr
                ,False
                ,fSaldo_Insoluto_SinRea
                ,fSaldo_Insoluto
                ,sModulo_Error
                ,sString_Error
                ,Result);

  if NOT Result then
     exit;

  fReajuste_Capital := fSaldo_Insoluto - fSaldo_Insoluto_SinRea;

  if ((sTipo_Valuac_PX_DIRTY = 'PRECMERC')   OR
      (sTipo_Valuac_PX_DIRTY = 'PX-DIRTY-O')) AND
     ((sTipo_Precio = 'SUCIO') OR
      (sTipo_Precio = 'AMBOS')) Then
        if fSaldo_Insoluto <> 0 then
           Reg_Val_Out.Precio_Sucio := Reg_Val_Out.ValorInvertidoUM *
                                       100 /
                                       fSaldo_Insoluto
        else
           Reg_Val_Out.Precio_Sucio := 0;

  if ((sTipo_Valuac_PX_CLEAN = 'PRECMERC')   OR
      (sTipo_Valuac_PX_CLEAN = 'PX-DIRTY-O')) AND
     ((sTipo_Precio = 'LIMPIO') OR
      (sTipo_Precio = 'AMBOS')) Then
        if fSaldo_Insoluto <> 0 then
           Reg_Val_Out.Precio_Limpio := Reg_Val_Out.ValorInvertidoUM *
                                       100 /
                                       fSaldo_Insoluto
        else
           Reg_Val_Out.Precio_Limpio := 0;


  /////////////////////////////////////////////////
  if ((sTipo_Valuac_PX_DIRTY = 'PRECMERCNR')
  //OR
  //    (sTipo_Valuac_PX_DIRTY = 'PX-DIRTY-O') // COMENTADO POR F.I. 14-11-2012 // Ya lo habia calculado mas arriba ... El pasar por aca lo echa a pereder
  ) AND
     ((sTipo_Precio = 'SUCIO') OR
      (sTipo_Precio = 'AMBOS')) Then
        if fSaldo_Insoluto_SinRea <> 0 then
           Reg_Val_Out.Precio_Sucio := Reg_Val_Out.ValorInvertidoUM *
                                       100 /
                                       fSaldo_Insoluto_SinRea
        else
           Reg_Val_Out.Precio_Sucio := 0;

  if ((sTipo_Valuac_PX_CLEAN = 'PRECMERCNR')
  //OR
  //    (sTipo_Valuac_PX_CLEAN = 'PX-DIRTY-O') // COMENTADO POR F.I. 14-11-2012 // Ya lo habia calculado mas arriba ... El pasar por aca lo echa a pereder
     ) AND
     ((sTipo_Precio = 'LIMPIO') OR
      (sTipo_Precio = 'AMBOS')) Then
        if fSaldo_Insoluto_SinRea <> 0 then
           Reg_Val_Out.Precio_Limpio := Reg_Val_Out.ValorInvertidoUM *
                                       100 /
                                       fSaldo_Insoluto_SinRea
        else
           Reg_Val_Out.Precio_Limpio := 0;


  /////////////////////////////////////////////////


  if (sTipo_Valuac_PX_CLEAN = 'KINTERES')   OR
     (sTipo_Valuac_PX_CLEAN = 'KINTERESNR') OR
     (sTipo_Valuac_PX_CLEAN = 'PRECNOMINT') OR
     (sTipo_Valuac_PX_CLEAN = 'PX-CLEAN-O') OR
     (sTipo_Valuac_PX_CLEAN = 'KNR+INT+RE') OR
     (sTipo_Valuac_PX_CLEAN = 'PRENOMINTR') OR
     (sTipo_Valuac_PX_CLEAN = 'VPT-LIMPIO') OR
     (sTipo_Valuac_PX_CLEAN = 'VPN-LIMPIO') OR
     (sTipo_Valuac_PX_CLEAN = 'PRECTITULO' ) OR
     (sTipo_Valuac_PX_CLEAN = 'PRECTIT+i' ) OR
     (sTipo_Valuac_PX_DIRTY = 'VPN-LIMPIO') OR
     (sTipo_Valuac_PX_DIRTY = 'VPT-LIMPIO') OR
     (sTipo_Valuac_PX_DIRTY = 'PX-CLEAN-O') THEN
  begin
    {Calculo intereses devengados desde ultimo vcto}
    ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                          ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                          ,Reg_Val_Out.Array_Mem_Desarr
                          ,Reg_Val_Out.RegDes
                          ,Reg_Val_In.Con_Cupon
                          ,iNro_Cupon
                          ,dFecha_Desde
                          ,sModulo_Error
                          ,sString_Error
                          ,Result);
    if NOT Result then
       exit;

    Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                        ,Reg_Val_In.sEmisor
                        ,Reg_Val_In.sInstrumento
                        ,Reg_Val_In.sSerie
                        ,Reg_Val_In.Nemotecnico
                        ,Reg_Val_In.dTasaEmision
                        ,Reg_Val_Out.TasaCalculo
                        ,Reg_Val_In.sUnidadMonetaria
                        ,Reg_Val_In.sTipoNominales
                        ,Reg_Val_In.dFechaEmision
                        ,Reg_Val_In.dFechaVencimiento
                        //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                        //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                        ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                        ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                        ,Reg_Val_In.dFechaPago
                        ,Reg_Val_In.sMoneda_Conversion
                        ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                        ,Reg_Val_Out.Nominales
                        ,dFecha_Desde                 // Fecha Desde
                        ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                        ,Reg_Val_In.Descriptor_Cargado
                        ,Reg_Val_In.Tabla_Desarr_Cargada
                        ,Reg_Val_Out.RegDes
                        ,Reg_Val_Out.Array_Mem_Desarr
                        ,fInteres_Acum_UM
                        ,fInteres_Acum_MC
                        ,fInteres_Acum_UM_REAJUSTADO
                        ,fReajuste_Indexado
                        ,fAjuste_Reajuste_Indexado
                        ,fReajuste_NO_Indexado
                        ,sModulo_Error
                        ,sString_Error
                        ,Result);
    if NOT Result then
       exit;
    ////
    if ( sTipo_Valuac_PX_CLEAN = 'PRECNOMINT') AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
       if (Reg_Val_Out.Nominales * fBase_Precio_PX_CLEAN <> 0) then
          Reg_Val_Out.Precio_Limpio := (Reg_Val_Out.ValorInvertidoUM -
                                        fInteres_Acum_UM_REAJUSTADO)/
                                        Reg_Val_Out.Nominales *
                                        fBase_Precio_PX_CLEAN
       else
          Reg_Val_Out.Precio_Limpio := 0;

    ///////

    if ((sTipo_Valuac_PX_CLEAN = 'PRECTITULO') or (sTipo_Valuac_PX_CLEAN = 'PRECTIT+i')) AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
    begin
      if sMon_Ind_Clean = '' Then
      begin
          Result       := False;
          sModulo_Error:= 'Módulo de Valorización :';
          sString_Error:= 'Falta el ingreso de la moneda en Método de Valuación. Proceso : '+Reg_Val_In.Proceso_Valuacion +' Tipo Valuacion : '+sTipo_Valuac_PX_CLEAN;
          exit;
      end;
      if Reg_Val_In.Numero_Titulos <= 0 Then
      begin
          Result       := False;
          sModulo_Error:= 'Módulo de Valorización :';
          sString_Error:= 'Numero de Títulos en 0, se debe ingresar ';
          exit;
      end;

      if Reg_Val_In.Numero_Titulos <> 0 then
      begin
         Reg_Val_Out.Precio_Limpio := (Reg_Val_Out.ValorInvertidoUM -
                                       fInteres_Acum_UM_REAJUSTADO)/
                                       Reg_Val_In.Numero_Titulos;

         if fBase_Precio_PX_CLEAN = 0 then
            fBase_Precio_PX_CLEAN := 1;

         Reg_Val_Out.Precio_Sucio := Reg_Val_Out.Precio_Sucio * fBase_Precio_PX_CLEAN;

        // Se debe convertir el precio obtenido de Reg_Val_In.sUnidadMonetaria a sMon_Ind_Clean
         Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                              ,sMon_Ind_Clean
                              ,'BC'
                              ,Reg_Val_In.dFechaCalculo
                              ,Reg_Val_Out.Precio_Limpio
                              ,Reg_Val_Out.Precio_Limpio
                              ,sModulo_Error
                              ,sString_Error
                              ,Result);
         if NOT Result then
            exit;
      end
      else
         Reg_Val_Out.Precio_Limpio := 0;
    end;

    if ((sTipo_Valuac_PX_DIRTY = 'KINTERES')   OR
        (sTipo_Valuac_PX_DIRTY = 'PX-CLEAN-O')) AND
       ((sTipo_Precio = 'SUCIO') OR
        (sTipo_Precio = 'AMBOS')) Then
       if fSaldo_Insoluto <> 0 then
          Reg_Val_Out.Precio_Sucio := (Reg_Val_Out.ValorInvertidoUM -
                                       fInteres_Acum_UM_REAJUSTADO)*
                                       100 /
                                       fSaldo_Insoluto
       else
          Reg_Val_Out.Precio_Sucio := 0;

    if ((sTipo_Valuac_PX_CLEAN = 'KINTERES')   OR
        (sTipo_Valuac_PX_CLEAN = 'PX-CLEAN-O')) AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
       if fSaldo_Insoluto <> 0 then
          Reg_Val_Out.Precio_Limpio := (Reg_Val_Out.ValorInvertidoUM -
                                        fInteres_Acum_UM_REAJUSTADO)*
                                        100 /
                                        fSaldo_Insoluto
       else
          Reg_Val_Out.Precio_Limpio := 0;


    if ( sTipo_Valuac_PX_DIRTY = 'VPN-LIMPIO') AND
       ((sTipo_Precio = 'SUCIO') OR
        (sTipo_Precio = 'AMBOS')) Then
       if (Reg_Val_Out.Nominales * fBase_Precio_PX_DIRTY <> 0) then
          Reg_Val_Out.Precio_Sucio := (Reg_Val_Out.ValorInvertidoUM -
                                       fInteres_Acum_UM_REAJUSTADO) /
                                       Reg_Val_Out.Nominales *
                                       fBase_Precio_PX_DIRTY
       else
          Reg_Val_Out.Precio_Sucio := 0;

    if ( sTipo_Valuac_PX_CLEAN = 'VPN-LIMPIO') AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
       if (Reg_Val_Out.Nominales * fBase_Precio_PX_CLEAN <> 0) then
          Reg_Val_Out.Precio_Limpio := (Reg_Val_Out.ValorInvertidoUM -
                                        fInteres_Acum_UM_REAJUSTADO)/
                                        Reg_Val_Out.Nominales *
                                        fBase_Precio_PX_CLEAN
       else
          Reg_Val_Out.Precio_Limpio := 0;


    if ((sTipo_Valuac_PX_DIRTY = 'KINTERESNR')
//    OR
//        (sTipo_Valuac_PX_DIRTY = 'PX-CLEAN-O') // COMENTADO POR F.I. 14-11-2012 // Ya lo habia calculado mas arriba ... El pasar por aca lo echa a pereder
) AND
       ((sTipo_Precio = 'SUCIO') OR
        (sTipo_Precio = 'AMBOS')) Then
       if fSaldo_Insoluto_SinRea <> 0 then
          Reg_Val_Out.Precio_Sucio := (Reg_Val_Out.ValorInvertidoUM -
                                       fInteres_Acum_UM_REAJUSTADO)*
                                       100 /
                                       fSaldo_Insoluto_SinRea
       else
          Reg_Val_Out.Precio_Sucio := 0;

    if ((sTipo_Valuac_PX_CLEAN = 'KINTERESNR')
//    OR
//        (sTipo_Valuac_PX_CLEAN = 'PX-CLEAN-O')  // COMENTADO POR F.I. 14-11-2012 // Ya lo habia calculado mas arriba ... El pasar por aca lo echa a pereder
       ) AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
       if fSaldo_Insoluto_SinRea <> 0 then
          Reg_Val_Out.Precio_Limpio := (Reg_Val_Out.ValorInvertidoUM -
                                        fInteres_Acum_UM_REAJUSTADO)*
                                        100 /
                                        fSaldo_Insoluto_SinRea
       else
          Reg_Val_Out.Precio_Limpio := 0;

    if (sTipo_Valuac_PX_DIRTY = 'VPT-LIMPIO')    AND
       ((sTipo_Precio = 'SUCIO') OR
        (sTipo_Precio = 'AMBOS')) Then
    begin
       if sMon_Ind_Dirty = '' Then
       begin
           Result       := False;
           sModulo_Error:= 'Módulo de Valorización :';
           sString_Error:= 'Falta el ingreso de la moneda en Método de Valuación. Proceso : '+Reg_Val_In.Proceso_Valuacion +' Tipo Valuacion : '+sTipo_Valuac_PX_DIRTY;
           exit;
       end;
       if Reg_Val_In.Numero_Titulos <= 0 Then
       begin
           Result       := False;
           sModulo_Error:= 'Módulo de Valorización :';
           sString_Error:= 'Numero de Títulos en 0, se debe ingresar ';
           exit;
       end;
       if Reg_Val_In.Numero_Titulos <> 0 then
       begin
          Reg_Val_Out.Precio_Sucio := (Reg_Val_Out.ValorInvertidoUM -
                                       fInteres_Acum_UM_REAJUSTADO) /
                                       Reg_Val_In.Numero_Titulos;
          // Se debe convertir el precio obtenido de Reg_Val_In.sUnidadMonetaria a sMon_Ind_Dirty
          Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                               ,sMon_Ind_Dirty
                               ,'BC'
                               ,Reg_Val_In.dFechaCalculo
                               ,Reg_Val_Out.Precio_Sucio
                               ,Reg_Val_Out.Precio_Sucio
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
          if NOT Result then
             exit;
       end
       else
          Reg_Val_Out.Precio_Sucio := 0;
    end;


    if (sTipo_Valuac_PX_CLEAN = 'VPT-LIMPIO') AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
    begin
       if sMon_Ind_Clean = '' Then
       begin
           Result       := False;
           sModulo_Error:= 'Módulo de Valorización :';
           sString_Error:= 'Falta el ingreso de la moneda en Método de Valuación. Proceso : '+Reg_Val_In.Proceso_Valuacion +' Tipo Valuacion : '+sTipo_Valuac_PX_CLEAN;
           exit;
       end;
       if Reg_Val_In.Numero_Titulos <= 0 Then
       begin
           Result       := False;
           sModulo_Error:= 'Módulo de Valorización :';
           sString_Error:= 'Numero de Títulos en 0, se debe ingresar ';
           exit;
       end;
       if Reg_Val_In.Numero_Titulos <> 0 then
       begin
          Reg_Val_Out.Precio_Limpio := (Reg_Val_Out.ValorInvertidoUM -
                                        fInteres_Acum_UM_REAJUSTADO) /
                                        Reg_Val_In.Numero_Titulos;
          // Se debe convertir el precio obtenido de Reg_Val_In.sUnidadMonetaria a sMon_Ind_Clean
          Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                               ,sMon_Ind_Clean
                               ,'BC'
                               ,Reg_Val_In.dFechaCalculo
                               ,Reg_Val_Out.Precio_Limpio
                               ,Reg_Val_Out.Precio_Limpio
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);
          if NOT Result then
             exit;
       end
       else
          Reg_Val_Out.Precio_Limpio := 0;
    End;
  end; // Solo kinteres


  if ((sTipo_Valuac_PX_DIRTY = 'PRENOM+REA')) AND  // (Nominales * Precio) + Reajuste Capital
     ((sTipo_Precio = 'SUCIO') OR
      (sTipo_Precio = 'AMBOS')) Then
      if Reg_Val_Out.Nominales <> 0 then
         Reg_Val_Out.Precio_Sucio := ((Reg_Val_Out.ValorInvertidoUM - fReajuste_Capital)
                                     / Reg_Val_Out.Nominales) * fBase_Precio_PX_DIRTY
      else
         Reg_Val_Out.Precio_Sucio := 0;

    if ((sTipo_Valuac_PX_CLEAN = 'PRENOMINTR')) AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
      if Reg_Val_Out.Nominales <> 0 then
         Reg_Val_Out.Precio_Limpio := ((Reg_Val_Out.ValorInvertidoUM - fInteres_Acum_UM_REAJUSTADO - fReajuste_Capital)
                                     / Reg_Val_Out.Nominales) * fBase_Precio_PX_CLEAN
      else
         Reg_Val_Out.Precio_Limpio := 0;

    if ((sTipo_Valuac_PX_CLEAN = 'KNR+INT+RE')) AND
       ((sTipo_Precio = 'LIMPIO') OR
        (sTipo_Precio = 'AMBOS')) Then
      if Reg_Val_Out.Nominales <> 0 then
         Reg_Val_Out.Precio_Limpio := ((Reg_Val_Out.ValorInvertidoUM - fInteres_Acum_UM_REAJUSTADO - fReajuste_Capital)
                                     / fSaldo_Insoluto) * fBase_Precio_PX_CLEAN
      else
         Reg_Val_Out.Precio_Limpio := 0;


  if ((sTipo_Valuac_PX_DIRTY = 'KNR+REACAP')) AND
     ((sTipo_Precio = 'SUCIO') OR
      (sTipo_Precio = 'AMBOS')) Then
      if Reg_Val_Out.Nominales <> 0 then
         Reg_Val_Out.Precio_Sucio := ((Reg_Val_Out.ValorInvertidoUM - fReajuste_Capital)
                                     / Reg_Val_Out.Nominales) * fBase_Precio_PX_DIRTY
      else
         Reg_Val_Out.Precio_Sucio := 0;

end; // precnom y kinteres
end;

procedure Limpia_Valor_Interes(var Reg_Val_In      : TRegistro_Valoriza_In;
                         var Reg_Val_Out : TRegistro_Valoriza_Out;
                         var Modulo_Err  : String;
                         var String_Err  : String;
                         var Result      : Boolean);

Var
  //Registro_Fechas             : TRegistro_Fechas;
  //sMetodo_Sin_Tasa_Referencia : String;
  //fSaldo_Insoluto             : Double;
  dFecha_Desde                : TDateTime;
  fInteres_Acum_UM            : Double;
  fInteres_Acum_MC            : Double;
  //iCupon_Vigente,
  //i                           : Integer;
  iNro_Cupon                  : Integer;
  fInteres_Acum_UM_REAJUSTADO : Double;
  //fCorMon,
  //fValor_Original        : Double;
  //Parametros_Formula     : TRegFormulaPAR;
  fReajuste_Indexado          : Double;
  fReajuste_NO_Indexado       : Double;
  fAjuste_Reajuste_Indexado   : Double;

Begin
//  Interes dev
      ultimo_vencimiento_new(Reg_Val_In.dFechaEmision
                            ,Reg_Val_In.dFechaCalculo // Antes de esta fecha
                            ,Reg_Val_Out.Array_Mem_Desarr
                            ,Reg_Val_Out.RegDes
//                            ,Reg_Val_In.Con_Cupon
                            ,FALSE
                            ,iNro_Cupon
                            ,dFecha_Desde
                            ,Modulo_Err
                            ,String_Err
                            ,Result);
      if NOT Result then
         exit;

      fInteres_Acum_UM              := 0;
      fInteres_Acum_MC              := 0;
      fInteres_Acum_UM_REAJUSTADO   := 0;
      fReajuste_Indexado            := 0;
      fAjuste_Reajuste_Indexado     := 0;
      fReajuste_NO_Indexado         := 0;
         
      Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                          ,Reg_Val_In.sEmisor
                          ,Reg_Val_In.sInstrumento
                          ,Reg_Val_In.sSerie
                          ,Reg_Val_In.Nemotecnico
                          ,Reg_Val_In.dTasaEmision
                          ,Reg_Val_Out.TasaCalculo
                          ,Reg_Val_In.sUnidadMonetaria
                          ,Reg_Val_In.sTipoNominales
                          ,Reg_Val_In.dFechaEmision
                          ,Reg_Val_In.dFechaVencimiento
                          //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                          //,Reg_Val_In.dFechaCalculo  // No se usa da lo mismo lo que vaya
                          ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                          ,Reg_Val_In.dFechaCompra     //GG FI 09-06-2015 se utiliza
                          ,Reg_Val_In.dFechaPago
                          ,Reg_Val_In.sMoneda_Conversion
                          ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                          ,Reg_Val_Out.Nominales
                          ,dFecha_Desde                 // Fecha Desde
                          ,Reg_Val_In.dFechaCalculo     // Fecha Hasta
                          ,Reg_Val_In.Descriptor_Cargado
                          ,Reg_Val_In.Tabla_Desarr_Cargada
                          ,Reg_Val_Out.RegDes
                          ,Reg_Val_Out.Array_Mem_Desarr
                          ,fInteres_Acum_UM
                          ,fInteres_Acum_MC
                          ,fInteres_Acum_UM_REAJUSTADO
                          ,fReajuste_Indexado
                          ,fAjuste_Reajuste_Indexado
                          ,fReajuste_NO_Indexado
                          ,Modulo_Err
                          ,String_Err
                          ,Result);
      if NOT Result then
         exit;

//  Resto el interes.
// se Agrego " - fReajuste_Indexado - fReajuste_NO_Indexado" por NBC Reajustes
      Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM - fInteres_Acum_UM - fReajuste_Indexado - fReajuste_NO_Indexado ;


      Conversion_unidad_mon(Reg_Val_In.sUnidadMonetaria
                           ,Reg_Val_In.sMoneda_Conversion
                           ,'BC'
                           ,Reg_Val_In.dFechaCalculo
                           ,Reg_Val_Out.ValorInvertidoUM
                           ,Reg_Val_Out.ValorInvertidoMC
                           ,Modulo_Err
                           ,String_Err
                           ,Result);
      if NOT Result then
         exit;

      //Reg_Val_Out.ValorInvertidoUM := Redondeo_Moneda(Reg_Val_In.sUnidadMonetaria,
      //                                                Reg_Val_In.dFechaCalculo,
      //                                                Reg_Val_Out.ValorInvertidoUM);

      Reg_Val_Out.ValorInvertidoMC := Redondeo_Moneda(Reg_Val_In.sMoneda_Conversion,
                                                      Reg_Val_In.dFechaCalculo,
                                                      Reg_Val_Out.ValorInvertidoMC);
end;
end.
