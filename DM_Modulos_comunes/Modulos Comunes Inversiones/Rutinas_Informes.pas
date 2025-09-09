
unit Rutinas_Informes;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DM_Variables_Valorizacion, DM_FuncionesMemory,DM_Variables_Menu,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDM_Rutinas_Informes = class(TDataModule)
    Qry_General: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure Interest_91_92(sTipo_Instrumento   : String;
                           sEmisor              : String;
                           sInstrumento         : String;
                           sSerie               : String;
                           sNemotecnico         : String;
                           fTasaEmision         : Double;
                           fTasaCalculo        : Double;
                           sUnidadMonetaria     : String;
                           sTipoNominales       : String;
                           dFecha_Emision        : TDateTime;
                           dFecha_Vencimiento    : TDateTime;
                           dFecha_Compra         : TDateTime;
                           sMoneda_Conversion   : String;
                           dFechaCierreActual   : TDateTime;
                           dFechaCierreAnterior : TDateTime;
                           fNominales           : Double;
                           sTabla_Desarr_Cargada: String;
                           var RegDes           : TReg_Descriptor;
                           var Array_Mem_Desarr : TArray_Mem_Desarr;
                           var Interest_91      : Double;
                           var Interest_92      : Double;
                           var sModulo_Err      : String;
                           var sString_Err      : String;
                           var Result           : Boolean);

  procedure Intereses_Acumulados(sTipo_Instrumento         : String;
                                 sEmisor                   : String;
                                 sInstrumento              : String;
                                 sSerie                    : String;
                                 sNemotecnico              : String;
                                 fTasaEmision              : Double;
                                 fTasaCalculo              : Double;
                                 sUnidadMonetaria          : String;
                                 sTipoNominales            : String;
                                 dFecha_Emision             : TDateTime;
                                 dFecha_Vencimiento         : TDateTime;
                                 dFecha_Compra              : TDateTime;
                                 dFecha_Operacion                             : TDateTime;
                                 dFecha_Pago                : TDatetime;
                                 sMoneda_Conversion        : String;
                                 fCupones_Cortados         : Double;
                                 fNominales                : Double;
                                 dFecha_Desde              : TDateTime;
                                 dFecha_Hasta              : TDateTime;
                                 sDescriptor_Cargado       : String;
                                 sTabla_Desarr_Cargada     : String;
                                 var RegDes                : TReg_Descriptor;
                                 var Array_Mem_Desarr      : TArray_Mem_Desarr;
                                 var fInteres_Acum_UM      : Double;
                                 var fInteres_Acum_MC      : Double;
                                 var fInteres_Acum_UM_REAJUSTADO : Double;
                                 var fRea_Acum_Anterior          : Double;
                                 var fRea_Acum_Actual            : Double;
                                 var fReajuste_Periodo           : Double;
                                 var sModulo_Err                 : String;
                                 var sString_Err                 : String;
                                 var Result                      : Boolean);

  procedure Intereses_Acumulados_Vig(sTipo_Instrumento         : String;
                                     sEmisor                   : String;
                                     sInstrumento              : String;
                                     sSerie                    : String;
                                     dFecha_Vig                : TDateTime;
                                     sNemotecnico              : String;
                                     fTasaEmision              : Double;
                                     fTasaCalculo              : Double;
                                     sUnidadMonetaria          : String;
                                     sTipoNominales            : String;
                                     dFecha_Emision             : TDateTime;
                                     dFecha_Vencimiento         : TDateTime;
                                     dFecha_Compra              : TDateTime;
                                     dFecha_Operacion                             : TDateTime;
                                     dFecha_Pago                : TDatetime;
                                     sMoneda_Conversion        : String;
                                     fCupones_Cortados         : Double;
                                     fNominales                : Double;
                                     dFecha_Desde              : TDateTime;
                                     dFecha_Hasta              : TDateTime;
                                     sTabla_Desarr_Cargada     : String;
                                     var RegDes                : TReg_Descriptor;
                                     var Array_Mem_Desarr      : TArray_Mem_Desarr;
                                     var fInteres_Acum_UM      : Double;
                                     var fInteres_Acum_MC      : Double;
                                     var fInteres_Acum_UM_REAJUSTADO : Double;
                                     var fRea_Acum_Anterior          : Double;
                                     var fRea_Acum_Actual            : Double;
                                     var fReajuste_Periodo           : Double;
                                     var sModulo_Err                 : String;
                                     var sString_Err                 : String;
                                     var Result                      : Boolean);

  procedure Intereses_Acumulados_Ahorros(sNemotecnico                 : String;
                                         dFecha_Desde                 : TDateTime;
                                         dFecha_Hasta                 : TDateTime;
                                         var Deveng_Desde_El_Vcto_Ant : Double;
                                         var Deveng_Desde_El_Vcto_Act : Double;
                                         var sModulo_Err              : String;
                                         var sString_Err              : String;
                                         var Result                   : Boolean);

  procedure Pagos_Capitalizaciones_Periodo(sNemotecnico                 : String;
                                         dFecha_Desde                 : TDateTime;
                                         dFecha_Hasta                 : TDateTime;
                                         sMoneda_Instrum              : String;
                                         sMoneda_Iteracion            : String;
                                         var fCapitalizado_Periodo_UM : Double;
                                         var fCapitalizado_Periodo    : Double;
                                         var fInterest_92_UM          : Double;
                                         var fInterest_92             : Double;
                                         var sModulo_Err              : String;
                                         var sString_Err              : String;
                                         var Result                   : Boolean);


procedure Obtiene_Book_Value(sEmpresa_Usuario                        : String;
                             sCartera                                : String;
                             sTransaccion_Compra                     : String;
                             sFolio_Compra                           : String;
                             sItem_Omd_Compra                        : Double;
                             sTipoInstrumento                        : String;
                             sEmisor                                 : String;
                             sInstrumento                            : String;
                             sSerie                                  : String;
                             sNemotecnico                            : String;
                             fTasa_Emision                           : Double;
                             fTasa_Calculo                           : Double;
                             sTipo_Nominales                         : String;
                             sMoneda_Operacion                       : String;
                             sMoneda_Instrumento                     : String;
                             dFecha_Emision                          : TDateTime;
                             dFecha_Vencimiento                      : TDateTime;
                             dFecha_Compra                           : TDateTime;
                             dFecha_Pago                             : TDateTime;
                             sMoneda_Informe                         : String;
                             fCupones_Cortados                       : Double;
                             dFecha_Calculo                          : TDateTime;
                             dFecha_Cierre_Anterior                  : TDateTime;
                             fNominales_Originales                   : Double;
                             fNominales_Vigentes                     : Double;
                             fValor_Compra_UM                        : Double;
                             sTipoCalculoDias                        : String;
                             sPais_Tasa                              : String;
                             RegDes                                  : TReg_Descriptor;
                             Array_Mem_Desarr                        : TArray_Mem_Desarr;
                             //
                             // var Array_Mem_Amortizacion_Actual_Cost  : TArray_Mem_Amortizacion_Actual_Cost;
                             //
                             sTabla_Desarr_Cargada                   : String;
                             bMetodo_TIR_de_Capital                  : Boolean;
                             sMotivo_Inversion                       : String;
                             sProceso_ValorExposicion                : String;
                             var fBook_Value_UM                      : Double;
                             var fBook_Value_MC                      : Double;
                             var fDif_Precio                         : Double;
                             var fActual_Cost_MC                     : Double; // Valor de compra limpio y sin reajustes
                             var fTir_Capital_Cpa                    : Double;
                             var fActual_Cost_UM_Reajustado_a_Cpa    : Double;
                             var fActual_Cost_MC_Reajustado_a_Cpa    : Double;
                             var fReajuste_a_la_Cpa                  : Double;
                             var fReajuste_Par_Value_a_la_Cpa        : Double;
                             var fReajuste_Actual_Cost_Total         : Double;
                             var fReajuste_Actual_Cost_Periodo       : Double;
                             var fRea_Acumulado_Actual_Cost_Anterior : Double;
                             var fRea_Acumulado_Actual_Cost_Actual   : Double;
                             var fReajuste_Indexado_Inc_Dec_Total    : Double;
                             var fReajuste_No_Indexado_Inc_Dec_Total : Double;
                             var fActual_Cost_Residual_UM            : Double;
                             var fActual_Cost_Residual_MC            : Double;
                             var fActual_Cost_Residual_MC_SinRea     : Double;
                             var fMonto_Amort_a_la_CPA_UM              : Double;
                             var fMonto_Amort_a_la_CPA_MC              : Double;
                             var fReajuste_Indexado_Amort_a_la_CPA     : Double;
                             var fReajuste_No_Indexado_Amort_a_la_CPA  : Double;
                             var fMonto_Capitalizado_UM              : Double;
                             var fMonto_Capitalizado_MC              : Double;
                             var fReajuste_Indexado_Capitalizado     : Double;
                             var fReajuste_No_Indexado_Capitalizado  : Double;
                             var fIncrease_Decrease_Total            : Double;
                             var fIncrease_Decrease_Total_SinRea     : Double;

                             var fIncrease_Decrease_To_Maturity_Act  : Double;
                             var fIncrease_Decrease_To_Maturity_Act_SinRea  : Double;
                             var fProporcion_ActualCost_SalInsol     : Double;
                             var fMonto_Amort_Actual_Cost_A_CPA_UM         : Double;
                             var fMonto_Amort_Actual_Cost_A_CPA_MC         : Double;
                             var fReajuste_Indexado_Actual_Cost_A_CPA      : Double;
                             var fReajuste_No_Indexado_Actual_Cost_A_CPA   : Double;
                             var fRea_Capital_Residual_RF                  : Double;
                             var fExra_en_Capital_Residual_RF              : Double;
                             var fExra_en_Actual_Cost_RF                   : Double;
                             var fExra_en_Book_Value_RF                    : Double;
                             var fIncrease_Decrease_To_Maturity_Cpa        : Double;
                             var fAmortizacion_Inc_Dec_Pagada              : Double;
                             var sModulo_Err                               : String;
                             var sString_Err                               : String;
                             var Result                                    : Boolean);

  procedure ultimo_vencimiento_new(dFecha_Emision    : TDateTime;
                                   dFecha            : TDateTime;
                                   var Array_Mem_Desarr  : TArray_Mem_Desarr;
                                   RegDes            : TReg_Descriptor;
                                   bConCupon         : Boolean;
                                   var iNro_Cupon    : Integer;
                                   var dFecUltVcto   : TDateTime;
                                   var sModulo_Err   : String;
                                   var sString_Err   : String;
                                   var Result        : Boolean);

procedure Fecha_Inicio_devengamiento  (dFecha_Emision     : TDateTime;
                                       dFecha             : TDateTime;
                                       var Array_Mem_Desarr  : TArray_Mem_Desarr;
                                       iCuponVigente      : Integer;
                                       var dInicioDevenga : TDateTime);

  procedure Valores_Nominal_Invertido(sEmpresa        : String;
                                      sTransaccion    : String;
                                      sFolio          : String;
                                      fItem_omd       : Double;
                                      var fValor_Nominal : Double;
                                      var fValor_Invertido_MC : Double);

  procedure Interes_Cormon(RegDes           : TReg_Descriptor;
                           Reg_Fechas       : TRegistro_Fechas;
                           dFecha_Original  : TDateTime;
                           dFecha_Desde     : TDateTime;
                           dFecha_Hasta     : TDateTime;
                           fTasa_Calculo    : Double;
                           Array_Mem_Desarr : TArray_Mem_Desarr;
                           bSolo_Cupon_Vigente : Boolean;
                           fValor_Nominal      : Double;
                           fValor_Pagado       : Double;
                           Reg_Val_In          : TRegistro_Valoriza_In;
                           fNominales_Compra   : Double;
                           fInvertido_Compra   : Double;
                           var fInteres_UM     : Double;
                           var fInteres_MC     : Double;
                           var fInteres_Acum_GAAP_MC : Double;
                           var fCorMon         : Double;
                           var fValor_Original : Double;
                           var sString_Err     : String;
                           var sModulo_Err     : String;
                           var Result          : Boolean);

  procedure Interes_Cormon_VarCamb(RegDes                    : TReg_Descriptor;
                                   fTasa_Calculo             : Double;
                                   Reg_Fechas                : TRegistro_Fechas;
                                   dFecha_Original           : TDateTime;
                                   dFecha_Desde              : TDateTime;
                                   dFecha_Hasta              : TDateTime;
                                   sCodigo_MondInd_Variacion : String;
                                   fPtje_Aplica_Reajuste     : Double;
                                   Array_mem_Desarr          : TArray_Mem_Desarr;
                                   bSolo_Cupon_Vigente       : Boolean;
                                   fValor_Nominal            : Double;
                                   fValor_Pagado             : Double;
                                   var fInteres_UM           : Double;
                                   var fInteres_MC           : Double;
                                   var fInteres_Acum_GAAP_MC : Double;
                                   var fCorMon               : Double;
                                   var fValor_Original       : Double;
                                   var sString_Err           : String;
                                   var sModulo_Err           : String;
                                   var Result                : Boolean);

  procedure Interes_Cormon_Acum(sEmpresa            : String;
                                sTransaccion        : String;
                                sFolio_Interno      : String;
                                fItem_Omd           : Double;
                                RegDes              : TReg_Descriptor;
                                Reg_Fechas          : TRegistro_Fechas;
                                dFecha_Original     : TDateTime;
                                dFecha_Desde        : TDateTime;
                                dFecha_Hasta        : TDateTime;
                                fTasa_Calculo       : Double;
                                Array_Mem_Desarr    : TArray_Mem_Desarr;
                                bSolo_Cupon_Vigente : Boolean;
                                fValor_Nominal      : Double;
                                fValor_Pagado       : Double;
                                Reg_Val_In          : TRegistro_Valoriza_In;
                                fNominales_Compra   : Double;
                                fInvertido_Compra   : Double;
                                var fInteres_Acum   : Double;
                                var fCorMon_Acum    : Double;
                                var fValor_Original : Double;
                                var sString_Err     : String;
                                var sModulo_Err     : String;
                                var Result          : Boolean);


  procedure Saldo_Insoluto(sTipo_Instrumento    : String;
                           RegDes               : TReg_Descriptor;
                           dFecha_Emision       : TDateTime;
                           dFecha_Saldo         : TDateTime;
                           dFecha_Compra        : TDateTime;   //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                           fValor_Nominal       : Double;
                           Array_Mem_Desarr     : TArray_Mem_Desarr;
                           bCon_Cupon           : Boolean;
                           var fSaldo_Insoluto_Sin_Reajuste  : Double;
                           var fSaldo_Insoluto  : Double;
                           var sModulo_Err       : String;
                           var sString_Err       : String;
                           var Result           : Boolean);

  procedure Saldo_Insoluto_Sin_Capitalizacion(sTipo_Instrumento    : String;
                           RegDes               : TReg_Descriptor;
                           dFecha_Emision       : Double;
                           dFecha_Saldo         : TDateTime;
                           fValor_Nominal       : Double;
                           Array_Mem_Desarr     : TArray_Mem_Desarr;
                           bCon_Cupon           : Boolean;
                           var fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste  : Double;
                           var fSaldo_Insoluto_Sin_Capitalizacion               : Double;
                           var sModulo_Err       : String;
                           var sString_Err       : String;
                           var Result           : Boolean);

  procedure Saldo_Insoluto_Segun_Compra( sTipo_Instrumento    : String;
                                         RegDes               : TReg_Descriptor;
                                         dFecha_Emision       : Double;
                                         dFecha_Saldo         : TDateTime;
                                         dFecha_Compra        : TDateTime;
                                         fValor_Nominal       : Double;
                                         Array_Mem_Desarr     : TArray_Mem_Desarr;
                                         bCon_Cupon           : Boolean;
                                         var fSaldo_Insoluto_SinRea     : Double;
                                         var fSaldo_Insoluto            : Double;
                                         var fCapt_Acum_Cpa_y_Calc_NAmt : Double;
                                         var sModulo_Err                : String;
                                         var sString_Err                : String;
                                         var Result                     : Boolean);

  procedure Variacion_Porcentual(sTipo_Instrumento    : String;
                                 sEmisor              : String;
                                 sInstrumento         : String;
                                 sSerie               : String;
                                 sNemotecnico         : String;
                                 fTasaEmision         : Double;
                                 sUnidadMonetaria     : String;
                                 sTipoNominales       : String;
                                 dFecha_Emision        : TDateTime;
                                 dFecha_Vencimiento    : TDateTime;
                                 dFecha_Compra         : TDateTime;
                                 sMoneda_Conversion   : String;
                                 fNominales           : Double;
                                 dFecha_Desde         : TDateTime;
                                 dFecha_Hasta         : TDateTime;
                                 sTabla_Desarr_Cargada: String;
                                 sTipo_Valorizacion   : String;
                                 fTasa_Calculo        : Double;
                                 var RegDes           : TReg_Descriptor;
                                 var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 var fFactor_Variacion_Desde : Double;
                                 var fFactor_Variacion_Hasta : Double;
                                 var fFactor_Variacion       : Double;
                                 var fDecrease_Increase      : Double;
                                 var sModulo_Err             : String;
                                 var sString_Err             : String;
                                 var Result                  : Boolean);

  procedure Intereses_Acumulados_VAL(sTipo_Instrumento          : String;
                                     sEmisor                    : String;
                                     sInstrumento               : String;
                                     sSerie                     : String;
                                     sNemotecnico               : String;
                                     fTasaEmision               : Double;
                                     fTasaCalculo               : Double;
                                     sUnidadMonetaria           : String;
                                     sTipoNominales             : String;
                                     dFecha_Emision              : TDateTime;
                                     dFecha_Vencimiento          : TDateTime;
                                     dFecha_Compra               : TDateTime;
                                     sMoneda_Conversion         : String;
                                     fNominales                 : Double;
                                     fNro_Titulos               : Double;
                                     dFecha_Desde               : TDateTime;
                                     dFecha_Hasta               : TDateTime;
                                     sTabla_Desarr_Cargada      : String;
                                     fNominales_Compra          : Double;
                                     fValor_Invertido_UM_Compra : Double;
                                     sProceso                   : String;
                                     var RegDes                 : TReg_Descriptor;
                                     var Array_Mem_Desarr       : TArray_Mem_Desarr;
                                     var fInteres_Acum_UM       : Double;
                                     var fInteres_Acum_MC       : Double;
                                     var sModulo_Err            : String;
                                     var sString_Err            : String;
                                     var Result                 : Boolean);

  procedure Limpia_Valores(sEmpresa_Usuario      : String;
                           sCartera              : String;
                           sTransaccion          : String;
                           dFecha_Operacion      : TDateTime;
                           sTipoInstrumento      : String;
                           sEmisor               : String;
                           sInstrumento          : String;
                           sSerie                : String;
                           sNemotecnico          : String;
                           fTasa_Emision         : Double;
                           fTasa_Calculo         : Double;
                           sMoneda_Instrumento   : String;
                           sTipo_Nominales       : String;
                           dFecha_Emision        : TDateTime;
                           dFecha_Vencimiento    : TDateTime;
                           dFecha_Compra         : TDateTime;
                           dFecha_Pago           : TDateTime;
                           sMoneda_Informe       : String;
                           fCupones_Cortados      : Double;
                           sReajuste_Sobre       : String;
                           fSaldo_Insoluto       : Double;
                           fNominales_Vigentes   : Double;
                           sTabla_Desarr_Cargada : String;
                           RegDes                : TReg_Descriptor;
                           var Array_Mem_Desarr      : TArray_Mem_Desarr;
                           dFecha_Desde          : TDateTime;
                           dFecha_Hasta          : TDateTime;
                           fValor_Dirty_UM       : Double;
                           var fValor_Clean_UM   : Double;
                           var fValor_Clean_UM_Rea  : Double;
                           var sModulo_Err        : String;
                           var sString_Err        : String;
                           var Result            : Boolean);
  procedure Limpia_Valores_Vig(sEmpresa_Usuario      : String;
                           sCartera              : String;
                           sTransaccion          : String;
                           dFecha_Operacion      : TDateTime;
                           sTipoInstrumento      : String;
                           sEmisor               : String;
                           sInstrumento          : String;
                           sSerie                : String;
                           dFecha_Vig            : TDateTime;
                           sNemotecnico          : String;
                           fTasa_Emision         : Double;
                           fTasa_Calculo         : Double;
                           sMoneda_Instrumento   : String;
                           sTipo_Nominales       : String;
                           dFecha_Emision        : TDateTime;
                           dFecha_Vencimiento    : TDateTime;
                           dFecha_Compra         : TDateTime;
                           dFecha_Pago           : TDateTime;
                           sMoneda_Informe       : String;
                           fCupones_Cortados     : Double;
                           sReajuste_Sobre       : String;
                           fSaldo_Insoluto       : Double;
                           fNominales_Vigentes   : Double;
                           sTabla_Desarr_Cargada : String;
                           RegDes                : TReg_Descriptor;
                           Array_Mem_Desarr      : TArray_Mem_Desarr;
                           dFecha_Desde          : TDateTime;
                           dFecha_Hasta          : TDateTime;
                           fValor_Dirty_UM       : Double;
                           var fValor_Clean_UM   : Double;
                           var fValor_Clean_UM_Rea  : Double;
                           var sModulo_Err        : String;
                           var sString_Err        : String;
                           var Result            : Boolean);

  procedure Reajuste_Indexado(sMoneda_Original         : String;
                              sMoneda_Conversion       : String;
                              sTipo_Paridad            : String;
                              dFecha_Desde             : TDateTime;
                              dFecha_Hasta             : TDateTime;
                              fValor_Original_UM       : Double;
                              var fValor_Reajustado_MC : Double;
                              var fReajuste            : Double;
                              var sModulo_Err           : String;
                              var sString_Err           : String;
                              var Result               : Boolean);

  procedure Reajuste_No_Indexado(sEmisor                  : String;
                                 sInstrumento             : String;
                                 sSerie                   : String;
                                 dFecha_Calculo           : TDateTime;
                                 Registro_Fechas          : TRegistro_Fechas;
                                 iCupon_Vigente           : Integer;
                                 fValor_a_Reajustar       : Double;
                                 var fFactor_Reajuste     : Double;
                                 var fReajuste            : Double;
                                 var fValor_Reajustado    : Double;
                                 var sModulo_Err           : String;
                                 var sString_Err           : String;
                                 var Result               : Boolean);

  procedure Reajuste_Valor(sInstrumento              : String;
                           sMoneda_Instrumento       : String;
                           sMoneda_Conver            : String;
                           dFecha_Desde              : TDateTime;
                           dFecha_Hasta              : TDateTime;
                           fValor_Original_UM        : Double;
                           dFecha_Compra             : TDateTime;
                           dFecha_Emision            : TDateTime;
                           RegDes                    : TReg_Descriptor;
                           bConCupon                 : Boolean;           // bConCupon Por problema en el calculo
                           var Array_Mem_Desarr      : TArray_Mem_Desarr; // Interes 92 GAAP para funcion Interes_Cupones_Periodo_Para_OMD_Item
                           var sCod_Indice           : String;            // que calcula el 92 tiene que ser llamado con True los demas llamados con False
                           var fReajuste_Indexado    : Double;            // se incorpora 05-07-2006
                           var fReajuste_No_Indexado_UM : Double;
                           var fReajuste_No_Indexado : Double;
                           var fValor_Reajustado_MC  : Double;
                           var fDiferencia_tipo_cambio : Double;
                           var sModulo_Err            : String;
                           var sString_Err            : String;
                           var Result                : Boolean);

  procedure Amortizacion_Periodo(sInstrumento                                        : String;
                                 sTipo_Instrumento                                   : String;
                                 sCartera                                            : String;
                                 RegDes                                              : TReg_Descriptor;
                                 dFecha_Desde                                        : TDateTime;
                                 dFecha_Hasta                                        : TDateTime;
                                 dFecha_Compra                                       : TDateTime;
                                 dFecha_Emision                                      : TDateTime;
                                 fValor_Nominal_Original                             : Double;
                                 fValor_Nominal_Vigente                              : Double;
                                 sMoneda_Instrum                                     : String;
                                 sMoneda_Conver                                      : String;
                                 sEmpresa                                            : String;
                                 sTransaccion                                        : String;
                                 sFolio_Interno                                      : String;
                                 fItem_Omd                                           : Double;
                                 var Array_Mem_Desarr                                : TArray_Mem_Desarr;

                                 var fMonto_Amort_UM                                 : Double;
                                 var fMonto_Amort_MC                                 : Double;
                                 var fReajuste_Indexado_Amort                        : Double;
                                 var fReajuste_No_Indexado_Amort                     : Double;

                                 var fMonto_Amort_Pagado_UM                          : Double;
                                 var fMonto_Amort_Pagado_MC                          : Double;
                                 var fReajuste_Indexado_Amort_Pagado                 : Double;
                                 var fReajuste_No_Indexado_Amort_Pagado              : Double;

                                 var fMonto_Capitalizado_UM                          : Double;
                                 var fMonto_Capitalizado_MC                          : Double;
                                 var fReajuste_Indexado_Capitalizado                 : Double;
                                 var fReajuste_No_Indexado_Capitalizado              : Double;

                                 var fDiferencia_TC_Amort_Cupon                      : Double;
                                 var fDiferencia_TC_Amort_Cupon_Pagado               : Double;
                                 var fDiferencia_TC_Capit_Cupon                      : Double;

                                 fProporcion_ActualCost_SalInsol                     : Double;
                                 var fMonto_Amort_Actual_Cost_UM                     : Double;
                                 var fMonto_Amort_Actual_Cost_MC                     : Double;
                                 var fReajuste_Indexado_Actual_Cost                 : Double;
                                 var fReajuste_No_Indexado_Actual_Cost              : Double;
                                 var fDiferencia_TC_Actual_Cost                      : Double;

                                 var sModulo_Err                                     : String;
                                 var sString_Err                                     : String;
                                 var Result                                          : Boolean);

  procedure Accrued_Interest(sTipo_Instrumento                            : String;
                             sEmisor                                      : String;
                             sInstrumento                                 : String;
                             sSerie                                       : String;
                             sNemotecnico                                 : String;
                             fTasaEmision                                 : Double;
                             fTasaCalculo                                 : Double;
                             sUnidadMonetaria                             : String;
                             sTipoNominales                               : String;
                             dFecha_Emision                               : TDateTime;
                             dFecha_Vencimiento                           : TDateTime;
                             dFecha_Compra                                : TDateTime;
                             dFecha_Operacion                             : TDateTime;
                             dFecha_Pago                                  : TDateTime;
                             fCupones_Cortados                            : Double;
                             sMoneda_Conversion                           : String;
                             fNominales                                   : Double;
                             dFecha_Desde                                 : TDateTime;
                             dFecha_Hasta                                 : TDateTime;
                             sTabla_Desarr_Cargada                        : String;
                             sDescriptor_Cargado                          : String;
                             var RegDes                                   : TReg_Descriptor;
                             var Array_Mem_Desarr                         : TArray_Mem_Desarr;
                             var fInteres_Accrued_Pagado_UM               : Double;
                             var fInteres_Accrued_Pagado_MC               : Double;
                             var fInteres_Accrued_Devengado_UM            : Double;
                             var fInteres_Accrued_Devengado_MC            : Double;
                             var fReajuste_Interes_Pagado_Periodo         : Double;
                             var fReajuste_Interes_Devengado_Periodo      : Double;
                             var sModulo_Err                              : String;
                             var sString_Err                              : String;
                             var Result                                   : Boolean
                             );

 procedure Interes_Cupones_Periodo_Para_OMD_Item(sCartera              : String;
                                                 sEmpresa              : String;
                                                 sTransaccion          : String;
                                                 sFolio_interno        : String;
                                                 fItem_Omd             : Double;
                                                 dFecha_Desde          : TDateTime;
                                                 dFecha_Hasta          : TDateTime;
                                                 dFecha_Compra         : TDateTime;
                                                 dFecha_Pago           : TDateTime;
                                                 dFecha_Emision        : TDateTime;
                                                 sInstrumento          : String;
                                                 sMoneda_Instrumento   : String;
                                                 sMoneda_Conversion    : String;
                                                 fNominales            : Double;
                                                 RegDes                : TReg_Descriptor;
                                                 Array_Mem_Desarr      : TArray_Mem_Desarr;
                                                 sTipo_Instrumento     : String;
                                                 sNemotecnico          : String;
                                                 fTasaEmision          : Double;
                                                 fTasaCalculo          : Double;
                                                 sTipoNominales        : String;
                                                 dFecha_Vencimiento     : TDateTime;
                                                 var fInteres_UM_Pagado : Double;
                                                 var fInteres_MC_Pagado : Double;
                                                 var fReajuste_No_Indexado_Pagado : Double;
                                                 var fReajuste_Indexado_Pagado    : Double;
                                                 var fReajuste_Capital_Pagado_UM  : Double;
                                                 var fReajuste_Capital_Pagado_MC  : Double;
                                                 var sModulo_Err       : String;
                                                 var sString_Err       : String;
                                                 var Result            : Boolean);

  procedure Paid_For_Accrued_Vigente(dFecha_Cierre_Anterior_Ant   : TDateTime;
                                     dFecha_Cierre_Anterior_Act   : TDateTime;
                                     sTipo_Instrum                : String;
                                     sEmisor                      : String;
                                     sInstrumento                 : String;
                                     sSerie                       : String;
                                     sNemotecnico                 : String;
                                     fTasa_Emision                : Double;
                                     fTasa_Compra                 : Double;
                                     sMoneda_Instrum              : String;
                                     sTipo_Nominales              : String;
                                     dFecha_Emision               : TDateTime;
                                     dFecha_Vencimiento           : TDateTime;
                                     dFecha_Compra                : TDateTime;
                                     dFecha_Pago_Compra           : TDateTime;
                                     sMoneda_Conversion           : String;
                                     fCupones_Cortados            : Double;
                                     fNominales                   : Double;
                                     sTabla_Desarr_Cargada        : String;
                                     RegDes                       : TReg_Descriptor;
                                     Array_Mem_Desarr             : TArray_Mem_Desarr;
                                     var dPaid_For_Accrued_Vigente_Ant: Double;
                                     var dPaid_For_Accrued_Vigente_Act: Double;
                                     var sModuloErr                   : String;
                                     var sStringErr                   : String;
                                     var bResult                      : Boolean);

  procedure Tipo_Cambio_promedio_CPA_RV ( dFecha_Desde  : TDateTime;
                                          dFecha_Hasta  : TDateTime;
                                          sEmpresa      : String;
                                          sCartera      : String;
                                          sNemotecnico  : String;
                                          sMoneda_Origen        : String;
                                          sMoneda_Conversion_Proc : String;
                                          sMoneda_Conversion_Tran : String;
                                          var fValor_Nominal    : Double;
                                          var fTCambio_Promedio : Double;
                                          var sModuloErr        : String;
                                          var sStringErr        : String;
                                          var Result            : Boolean);

  procedure Tipo_Cambio_promedio_CPA_Ahorros ( dFecha_Desde  : TDateTime;
                                          dFecha_Hasta  : TDateTime;
                                          sEmpresa      : String;
                                          sCartera      : String;
                                          sNemotecnico  : String;
                                          sMoneda_Origen        : String;
                                          sMoneda_Conversion_Proc : String;
                                          sMoneda_Conversion_Tran : String;
                                          var fValor_Nominal    : Double;
                                          var fTCambio_Promedio : Double;
                                          var sModuloErr        : String;
                                          var sStringErr        : String;
                                          var Result            : Boolean);


  procedure Leer_Datos_Cierre_RV( sEmpresa        : String;
                                  sCartera        : String;
                                  sNemotecnico    : String;
                                  sMoneda_Operacion : String;
                                  dFechaCierre    : TDateTime;
                                  var fValor_Mercado_MC : Double;
                                  var fValor_Libro_MC : Double;
                                  var fPrecio_libro   : Double;
                                  var fValor_Nominal  : Double;
                                  var fPPP_UM         : Double;
                                  var fPPP_MC         : Double;
                                  var fPPP_UM_SINREA  : Double;
                                  var fPPP_MC_SINREA  : Double;
                                  var fPRECIO_MDO     : Double);

procedure Tipo_Cambio_promedio_CPA_RV1 (dFecha_Desde  : TDateTime;
                                        dFecha_Hasta  : TDateTime;
                                        sEmpresa      : String;
                                        sCartera      : String;
                                        sNemotecnico  : String;
                                        sMoneda_Origen        : String;
                                        sMoneda_Conversion_Proc : String;
                                        sMoneda_Conversion_Tran : String;
                                        var fValor_Nominal    : Double;
                                        var fTCambio_Promedio : Double;
                                        var sModuloErr        : String;
                                        var sStringErr        : String;
                                        var Result            : Boolean);

procedure Tipo_Cambio_promedio_CPA_RV2 ( dFecha_Desde  : TDateTime;
                                        dFecha_Hasta   : TDateTime;
                                        sEmpresa       : String;
                                        sCartera       : String;
                                        sNemotecnico   : String;
                                        sMoneda_Origen        : String;
                                        sMoneda_Conversion_Proc : String;
                                        sMoneda_Conversion_Tran : String;
                                        fNominales_Reverso    : Double;
                                        var fTCambio : Double;
                                        var sModuloErr        : String;
                                        var sStringErr        : String;
                                        var Result            : Boolean);

  procedure Leer_Datos_Cierre_Ahorros( sEmpresa        : String;
                                  sCartera        : String;
                                  sNemotecnico    : String;
                                  sMoneda_Operacion : String;
                                  dFechaCierre    : TDateTime;
                                  var fValor_Mercado_MC : Double;
                                  var fValor_Libro_MC : Double;
                                  var fPrecio_libro   : Double;
                                  var fValor_Nominal  : Double;
                                  var fPPP_UM         : Double;
                                  var fPPP_MC         : Double;
                                  var fPPP_MC_SINREA  : Double;
                                  var fPRECIO_MDO     : Double);


  procedure Precio_promedio_CPA_RV ( dFecha_Desde  : TDateTime;
                                     dFecha_Hasta  : TDateTime;
                                     sEmpresa      : String;
                                     sCartera      : String;
                                     sNemotecnico  : String;
                                     var fValor_Nominal    : Double;
                                     var fPrecio_Promedio_MDO  : Double;
                                     var fPrecio_Promedio_CPA  : Double);



  function Busca_Motivo_RV( sEmpresa        : String;
                            sCartera        : String;
                            sTransaccion    : String;
                            sNemotecnico    : String;
                            dFecha_Cierre   : TDateTime) : String;

  function Busca_Motivo_Inv_RV( sEmpresa        : String;
                                sCartera        : String;
                                sTransaccion    : String;
                                sNemotecnico    : String;
                                dFecha_Cierre   : TDateTime) : String;

function Calcula_Intereses_Acum(sTipo_Instrum          : String;
                                sEmisor                : String;
                                sInstrumento           : String;
                                sSerie                 : String;
                                sNemotecnico           : String;
                                fTasa_Emision          : Double;
                                fTasa_Mercado          : Double;
                                sMoneda_Instrum        : String;
                                sTipo_Nominales        : String;
                                dFecha_Emision         : TDateTime;
                                dFecha_Vencimiento     : TDateTime;
                                dFecha_Operacion       : TDateTime;
                                sMoneda_Operacion      : String;
                                fNominales             : Double;
                                fValor_Invertido_MC    : Double;
                                RegDes                 : TReg_descriptor;
                                var Array_Mem_Desarr       : TArray_Mem_Desarr;
                                dFecha_UltVcto         : TDateTime;
                                dFecha_Compra          : TDateTime;
                                dFecha_Tope            : TDateTime;
                                var fInteres_Acumulado : Double;
                                var fDeveng_Acumulado  : DOuble;
                                var sModuloErr         : String;
                                var sStringErr         : String) : Boolean;

procedure IncDec_por_Diferencia_Curvas( sTipoInstrumento                                  : String;
                                        RegDes                                            : TReg_Descriptor;
                                        dFecha_Emision                                    : TDateTime;
                                        dFecha_Vencimiento                                : TDateTime;
                                        dFecha_Calculo                                    : TDateTime;
                                        dFecha_Compra                                     : TDateTime;
                                        fNominales_Vigentes                               : Double;
                                        //Array_Mem_Desarr                                  : TArray_Mem_Desarr;
                                        fSaldo_Insoluto_Cpa                               : Double;
                                        fActual_Cost_UM                                   : Double;
                                        fTasa_Calculo                                     : Double;
                                        fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM     : Double;
                                        fReajuste_NoIndex_Acumulado_Actual_Cost_Actual_UM : Double;
                                        var Reg_Val_In                                    : TRegistro_Valoriza_In;
                                        var Reg_Val_Out                                   : TRegistro_Valoriza_Out;
                                        var fIncrease_Decrease_Total                      : Double;
                                        var fIncrease_Decrease_To_Maturity_Cpa            : Double;
                                        var fIncrease_Decrease_To_Maturity_Act            : Double;
                                        var sModulo_Err                                   : String;
                                        var sString_Err                                   : String;
                                        var Result                                        : Boolean
                                        );

procedure IncDec_por_TIRK ( sTipoInstrumento                                  : String;
                            RegDes                                            : TReg_Descriptor;
                            dFecha_Emision                                    : TDateTime;
                            dFecha_Calculo                                    : TDateTime;
                            dFecha_Compra                                     : TDateTime;
                            dFecha_Vencimiento                                : TDateTime;
                            fNominales_Vigentes                               : Double;
                            Array_Mem_Desarr                                  : TArray_Mem_Desarr;
                            fSaldo_Insoluto_Cpa                               : Double;
                            fActual_Cost_UM                                   : Double;
                            var Reg_Val_In                                    : TRegistro_Valoriza_In;
                            var Reg_Val_Out                                   : TRegistro_Valoriza_Out;
                            var fTir_Capital_Cpa                              : Double;
                            var fIncrease_Decrease_Total                      : Double;
                            var fIncrease_Decrease_To_Maturity_Cpa            : Double;
                            var fIncrease_Decrease_To_Maturity_Act            : Double;
                            var sModulo_Err                                   : String;
                            var sString_Err                                   : String;
                            var Result                                        : Boolean
                          );

procedure Inc_Dec_Lineal( dFecha_Calculo                                    : TDateTime;
                          dFecha_Compra                                     : TDateTime;
                          dFecha_Vencimiento                                : TDateTime;
                          fSaldo_Insoluto_Cpa                               : Double;
                          fActual_Cost_UM                                   : Double;
                          sTipoCalculoDias                                  : String;
                          sPais_Tasa                                        : String;
                          var fDif_Precio                                   : Double;
                          var fIncrease_Decrease_Total                      : Double;
                          var fIncrease_Decrease_To_Maturity_Cpa            : Double;
                          var fIncrease_Decrease_To_Maturity_Act            : Double
                         );
var
  DM_Rutinas_Informes: TDM_Rutinas_Informes;

implementation
uses
    Valoriza_General,
    Tabla_Mem_Desarr_TFija,
    DM_ComunInversiones,
    DM_Excepcion_Calculos,
    DM_Ayuda_Monedas,
    Funciones_Valorizacion,
    DM_Global_Var,
    DM_Comun,
    DM_Carteras,
    DM_Identidad_Direccion,
    DMLeer_Valor_Cambio,
    DM_Base_Datos;

{$R *.DFM}
//------------------------------------------------------------------------------
procedure Intereses_Acumulados(sTipo_Instrumento         : String;
                               sEmisor                   : String;
                               sInstrumento              : String;
                               sSerie                    : String;
                               sNemotecnico              : String;
                               fTasaEmision              : Double;
                               fTasaCalculo              : Double;
                               sUnidadMonetaria          : String;
                               sTipoNominales            : String;
                               dFecha_Emision             : TDateTime;
                               dFecha_Vencimiento         : TDateTime;
                               dFecha_Compra              : TDateTime;
                               dFecha_Operacion           : TDateTime;
                               dFecha_Pago                : TDatetime;
                               sMoneda_Conversion        : String;
                               fCupones_Cortados         : Double;
                               fNominales                : Double;
                               dFecha_Desde              : TDateTime;
                               dFecha_Hasta              : TDateTime;
                               sDescriptor_Cargado       : String;
                               sTabla_Desarr_Cargada     : String;
                               var RegDes                : TReg_Descriptor;
                               var Array_Mem_Desarr      : TArray_Mem_Desarr;
                               var fInteres_Acum_UM      : Double;
                               var fInteres_Acum_MC      : Double;
                               var fInteres_Acum_UM_REAJUSTADO : Double;
                               var fRea_Acum_Anterior          : Double;
                               var fRea_Acum_Actual            : Double;
                               var fReajuste_Periodo           : Double;
                               var sModulo_Err                 : String;
                               var sString_Err                 : String;
                               var Result                      : Boolean);
var
   fValor_Par_UM_Desde : Double;
   fValor_Par_UM_Hasta : Double;
   //fValor_Par_MC_Desde : Double;
   //fValor_Par_MC_Hasta : Double;

   Reg_Val_In                : TRegistro_Valoriza_In;
   Reg_Val_Out               : TRegistro_Valoriza_Out;
   sTipo_Instrumento_RVRF    : String;
   //sAux_Valorizacion_Proceso : String;
   fPtje_Aplica_Reajuste     : Double;
   sCodigo_MondInd           : String;
   s0Cod_Tratam_Inicio       : String;
   s1Cod_Tratam_Termino      : String;
   //fValor_Ind_Inicio         : Double;
   //fValor_Ind_Termino        : Double;
   //dFecha_Inicio             : TDateTime;
   //dFecha_Termino            : TDateTime;
   bVariacionCambiaria       : Boolean;
   fFactor_Reajuste          : Double;
   Registro_Fechas           : TRegistro_Fechas;
   iCuponVigente             : Integer;
   iNro_Cupon                : Integer;
   fCapital_Residual         : Double;
   //fCapital_Residual_Reajustado_UM : Double;
   //fReajuste_Capital         : Double;
   //dUltimoVctoAntesFechaDesde: TDateTime;
   dUltimoVctoAntesFechaHasta: TDateTime;

   fIntereses_Acumulados_Cierre_Actual   : Double;
   fIntereses_Acumulados_Cierre_Anterior : Double;
   //dAux_fecha_pago                       : TdateTime;

   sMoneda_Paridad                       : String;
   sTipo_Moneda                          : String;
   // sTipo_Variacion                       : String;
   sDescripcion_Moneda                   : String;
   sPaga_Reajuste_Capital                : String;
   sNo_Considera_en_Interes              : String;
   sSolo_Aplica_en_Vctos                 : String;
   sNo_Considera_Negativos               : String;

begin
  Result := True;

  fInteres_Acum_UM            := 0;
  fInteres_Acum_MC            := 0;
  fInteres_Acum_UM_REAJUSTADO := 0;
  fRea_Acum_Anterior          := 0;
  fRea_Acum_Actual            := 0;
  fReajuste_Periodo           := 0;

  // Para los instrumentos de Renta Variable NO DEBE CALCULARES INTERES DEVENGADO
  // confirmado con Daniel Quezada 30/07/2004
  if sValorizacion_Proceso = 'SI' then
  begin
     if NOT Leer_Tipo_Instrumento_Mem(sInstrumento
                                     ,sTipo_Instrumento_RVRF) then
     begin
       sString_Err := 'Error en definición de instrumento ('
                     +sInstrumento
                     +')';
       Result := False;
       exit;
     end;
  end
  else
  begin
     if NOT Leer_Tipo_Instrumento_Mem(sInstrumento
                                 ,sTipo_Instrumento_RVRF) then
     begin
       sString_Err := 'Error en definición de instrumento ('
                     +sInstrumento
                     +')';
       Result := False;
       exit;
     end;
  end;

  if sTipo_Instrumento_RVRF = 'RV' then
     exit;


  if dFecha_Desde = dFecha_Hasta then
  begin
    fInteres_Acum_UM := 0;
    fInteres_Acum_MC := 0;
    fInteres_Acum_UM_REAJUSTADO := 0;
    exit;
  end;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Hasta
               ,True
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  ultimo_vencimiento_new(dFecha_Emision
                        ,dFecha_Hasta
                        ,Array_Mem_Desarr
                        ,RegDes
                        ,True
                        ,iNro_Cupon
                        ,dUltimoVctoAntesFechaHasta
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

  if not Result then
     exit;

  // Para este caso es necesario identificar el como ultimo vencimiento el cupon NO CORTADO.
  // Ya que mientras no corte el cupon el valor PAR es el descontados los flujos, luego
  // el flujo del cupon cortado es cero por lo cual no afecta F.I. 25/01/2009

  While (Array_Mem_Desarr[iNro_Cupon].Cupon_Cortado) and
        (iNro_Cupon > 0)                             do  // 24-08-2009 E.S. & F.I. Se detecto que pasaba con 0 y daba un floating point exception Zurich
    begin
      iNro_Cupon := iNro_Cupon - 1;
      if iNro_Cupon = 0 then
      begin
         dUltimoVctoAntesFechaHasta := dFecha_Emision;
         Break;
      end
      else
         dUltimoVctoAntesFechaHasta := Array_Mem_Desarr[iNro_Cupon].Fecha_Vcto;
    end;

  // Ojo: La funcion interses acumulados solo funciona con fecha desde y hasta en el mismo
  // Periodo de pago (sin cortes de cupon en el medio)
  // Caso contrario usar funcion Accrued_Interest (C.J. & F.I. 19-12-2003
  //
  // 25/01/2009 --> Para el caso que el cupon en el medio sea cortado no corre
  // la observación anterior

  if (dFecha_Desde < dUltimoVctoAntesFechaHasta) then
  begin
    sModulo_Err := 'Interes_acumulados';
    sString_Err := 'Existe vencimiento en el periodo: '
                   +DateToStr(dFecha_Desde)
                   +' - '
                   +DateToStr(dUltimoVctoAntesFechaHasta);
    Result      := False;
    exit;
  end;

  Verifica_Excepcion_Variacion_Cambiaria(sEmisor
                                        ,sInstrumento
                                        ,sSerie
                                        ,iCuponVigente // Para todos los flujos
                                        ,dFecha_Hasta
                                        ,fPtje_Aplica_Reajuste
                                        ,sCodigo_MondInd
                                        ,s0Cod_Tratam_Inicio
                                        ,s1Cod_Tratam_Termino
                                        ,Registro_Fechas.Fecha_Desde
                                        ,Registro_Fechas.Fecha_Hasta
                                        ,sPaga_Reajuste_Capital
                                        ,sNo_Considera_en_Interes
                                        ,sSolo_Aplica_en_Vctos
                                        ,sNo_Considera_Negativos
                                        ,bVariacionCambiaria);
  if bVariacionCambiaria then
     Reg_Val_In.sValor_Cupon_Original := 'S'
  else
     Reg_Val_In.sValor_Cupon_Original := 'N';


  Registro_Fechas.Fecha_Compra      := dFecha_Compra;
  Registro_Fechas.Fecha_Emision     := dFecha_Emision;
  Registro_Fechas.Fecha_Vencimiento := dFecha_Vencimiento;
  Registro_Fechas.Fecha_Calculo     := dFecha_Desde;
  // Para obtener el valor al la fecha del vencimiento anterior
  // No debe tomar en cuenta el devengamiento desde fecha de pago
  // Por eso cambio la fecha de pago a la fecha del ultimo vencimiento
  // para que valorice en forma correcta a esa fecha
  // dAux_fecha_pago := dFecha_Pago;

  // OJO si estoy calculando devengamientos antes de la compra (Paid for accrued)
  // o para la venta y es antes de la operacion, debo cambiar la fecha de pago
  // sino el valorizador cambiara la fecha de calculo a la fecha de pago.
  if (dFecha_Desde < dFecha_Operacion) or
     (dFecha_Desde < dFecha_Pago)      then
  begin
     Reg_Val_In.Considera_Devengamiento_Formula := 'NO';
     Registro_Fechas.Fecha_Pago        := dFecha_Desde;
     Reg_Val_In.dFechaPago             := dFecha_Desde;
  end
  else
  begin
     Reg_Val_In.Considera_Devengamiento_Formula := 'SI';
     Registro_Fechas.Fecha_Pago        := dFecha_Pago;
     Reg_Val_In.dFechaPago             := dFecha_Pago;
  end;


  // Obtengo valor PAR a fecha de desde
  Reg_Val_In.Tipo_Instrumento   := sTipo_Instrumento;
  Reg_Val_In.sEmisor            := sEmisor;
  Reg_Val_In.sInstrumento       := sInstrumento;
  Reg_Val_In.sSerie             := sSerie;
  Reg_Val_In.Nemotecnico        := sNemotecnico;
  Reg_Val_In.dTasaEmision       := fTasaEmision;
  Reg_Val_In.sUnidadMonetaria   := sUnidadMonetaria;
  Reg_Val_In.sTipoNominales     := sTipoNominales;
  Reg_Val_In.dFechaEmision      := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
  Reg_Val_In.dFechaCalculo      := dFecha_Desde;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

  Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
  Reg_Val_In.Con_Cupon          := False;                // sin Cupon
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
  Reg_Val_Out.Nominales         := fNominales;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes            := RegDes;
  Reg_Val_Out.TasaCalculo       := fTasaCalculo;
  Reg_Val_In.dFechaCompra       := dFecha_Compra;
  Reg_Val_In.dFechaOperacion    := dFecha_Operacion;
  Reg_Val_In.Descriptor_Cargado   := sDescriptor_Cargado;
  Reg_Val_In.Tabla_Desarr_Cargada := sTabla_Desarr_Cargada;
  Reg_Val_In.fCupones_Cortados    := fCupones_Cortados;


// CJF, al parecer el valor viene sucio Reg_Val_Out.ValorInvertidoUM = +NAN y al covertir mas adelante se cae por invalid


// CJF, estos valores (Reg_Val_Out.ValorInvertidoUM, Reg_Val_Out.ValorInvertidoMC)
// al llegar a esta funcion llegan sucios "+NAN" y se acupan mas adelante y marca error de ivalid
// 04/02/2007 mapfre peru folio 699
   Reg_Val_Out.ValorInvertidoUM := 0;
   Reg_Val_Out.ValorInvertidoMC := 0;
//
  // Guardo valor original de sValorizacion_Proceso
//  sAux_Valorizacion_Proceso := sValorizacion_Proceso;
//  sValorizacion_Proceso := 'NO'; //Por Valores de Cambio Cargados sólo a fecha de calculo en memoria
  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);
  fValor_Par_UM_Desde   := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste   ;
  // fValor_Par_MC_Desde   := Reg_Val_Out.Valor_Par_MC    ;
  Array_Mem_Desarr      := Reg_Val_Out.Array_Mem_Desarr;
  RegDes                := Reg_Val_Out.RegDes          ;
  Reg_Val_Out.RegDes      := RegDes;

  // Restablesco valor que venia en sValorizacion_Proceso
//  sValorizacion_Proceso := sAux_Valorizacion_Proceso;
//  if (sValorizacion_Proceso    <> 'SI') and
//     (sAux_Valorizacion_Proceso = 'SI') then
    if (sValorizacion_Proceso    <> 'SI') then
        Crea_Tablas_Temporales_Tasa_Flotante;

  if NOT Result then
     exit;
  sTabla_Desarr_Cargada := Reg_Val_In.Tabla_Desarr_Cargada;

  // Calculo Valor PAR a la fecha hasta
  Reg_Val_In.Con_Cupon          := True;               // Con Cupon
  Reg_Val_In.dFechaCalculo      := dFecha_Hasta;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_Out.Nominales         := fNominales;
  Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr   ;
  Reg_Val_Out.TasaCalculo       := fTasaCalculo;
  Reg_Val_In.Considera_Devengamiento_Formula := 'SI';
//  sValorizacion_Proceso := 'NO'; //Por Valores de Cambio Cargados sólo a fecha de calculo en memoria

  // OJO si estoy calculando devengamientos antes de la compra (Paid for accrued)
  // o para la venta y es antes de la operacion, debo cambiar la fecha de pago
  // sino el valorizador cambiara la fecha de calculo a la fecha de pago.
  if dFecha_Hasta < dFecha_Operacion then
  begin
     Registro_Fechas.Fecha_Pago        := dFecha_Hasta;
     Reg_Val_In.dFechaPago             := dFecha_Hasta;
  end
  else
  begin
     Registro_Fechas.Fecha_Pago        := dFecha_Pago;
     Reg_Val_In.dFechaPago             := dFecha_Pago;
  end;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;
  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fValor_Par_UM_Hasta   := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste    ;
  // fValor_Par_MC_Hasta   := Reg_Val_Out.Valor_Par_MC    ;
  Array_Mem_Desarr      := Reg_Val_Out.Array_Mem_Desarr;
  Reg_Val_Out.RegDes      := RegDes;
  if NOT Result then
     exit;

  fInteres_Acum_UM      := fValor_Par_UM_Hasta - fValor_Par_UM_Desde;
  fInteres_Acum_UM_REAJUSTADO := fInteres_Acum_UM;
  fInteres_Acum_MC      := fInteres_Acum_UM;

  // Obtengo valor PAR a ultimo vcto no puede ser capital residual
  // ya que descubrimos que la NBC por tener la tasa mala no da el Capital Residual
  // en los cortes de cupon.

    ultimo_vencimiento_new(dFecha_Emision
                        ,dFecha_Hasta
                        ,Array_Mem_Desarr
                        ,RegDes
                        ,TRUE             // Con Cupon (Si cae en el vcto trae el vcto anterior)
                        ,iNro_Cupon
                        ,dUltimoVctoAntesFechaHasta
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

  if not Result then
     exit;

  Reg_Val_In.Tipo_Instrumento   := sTipo_Instrumento;
  Reg_Val_In.sEmisor            := sEmisor;
  Reg_Val_In.sInstrumento       := sInstrumento;
  Reg_Val_In.sSerie             := sSerie;
  Reg_Val_In.Nemotecnico        := sNemotecnico;
  Reg_Val_In.dTasaEmision       := fTasaEmision;
  Reg_Val_In.sUnidadMonetaria   := sUnidadMonetaria;
  Reg_Val_In.sTipoNominales     := sTipoNominales;
  Reg_Val_In.dFechaEmision      := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
  Reg_Val_In.dFechaCalculo      := dUltimoVctoAntesFechaHasta;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

  if dUltimoVctoAntesFechaHasta < dFecha_Operacion then
  begin
     Registro_Fechas.Fecha_Pago        := dUltimoVctoAntesFechaHasta;
     Reg_Val_In.dFechaPago             := dUltimoVctoAntesFechaHasta;
  end
  else
  begin
     Registro_Fechas.Fecha_Pago        := dFecha_Pago;
     Reg_Val_In.dFechaPago             := dFecha_Pago;
  end;


  Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
  Reg_Val_In.Con_Cupon          := False;                // sin Cupon
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
  Reg_Val_Out.Nominales         := fNominales;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes            := RegDes;
  Reg_Val_Out.TasaCalculo       := fTasaCalculo;
  Reg_Val_In.dFechaCompra       := dFecha_Compra;
  Reg_Val_In.dFechaOperacion    := dFecha_Operacion;
  Reg_Val_In.Tabla_Desarr_Cargada := sTabla_Desarr_Cargada;

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fCapital_Residual   := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste   ;


//  if (sValorizacion_Proceso    <> 'SI') and
//     (sAux_Valorizacion_Proceso = 'SI') then

  if (sValorizacion_Proceso    <> 'SI')  then
      Crea_Tablas_Temporales_Tasa_Flotante;

  // Me aseguro que variable sValor_Cupon_Original quede en forma estandar
  Reg_Val_In.sValor_Cupon_Original := 'N';
  fIntereses_Acumulados_Cierre_Actual   := fValor_Par_UM_Hasta - fCapital_Residual;
  fIntereses_Acumulados_Cierre_Anterior := fValor_Par_UM_Desde - fCapital_Residual;

  if bVariacionCambiaria then // Es NO Indexado
  begin
    Registro_Fechas.Fecha_Calculo      := dFecha_Hasta;
    Registro_Fechas.Fecha_Compra       := dFecha_Compra;
    Registro_Fechas.Fecha_Emision      := dFecha_Emision;
    Registro_Fechas.Fecha_Vencimiento  := dFecha_Vencimiento;
    Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;

    if iCuponVigente = 1 then
       Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
    else
       Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCuponVigente-1].Fecha_Vcto;

    Reajuste_No_Indexado(RegDes.Codigo_Emisor
                        ,RegDes.Codigo_Instrumento
                        ,RegDes.Serie
                        ,dFecha_Hasta
                        ,Registro_Fechas
                        ,iCuponVigente
                        ,fIntereses_Acumulados_Cierre_Actual
                        ,fFactor_Reajuste
                        ,fRea_Acum_Actual
                        ,fNoUtilizado
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

    if NOT Result Then
       exit;


//    if dFecha_Compra = dFecha_Desde then
//       fRea_Acum_Anterior := 0
//    else
//    begin
       Registro_Fechas.Fecha_Calculo      := dFecha_Desde;
       Reajuste_No_Indexado(RegDes.Codigo_Emisor
                           ,RegDes.Codigo_Instrumento
                           ,RegDes.Serie
                           ,dFecha_Desde
                           ,Registro_Fechas
                           ,iCuponVigente
                           ,fIntereses_Acumulados_Cierre_Anterior
                           ,fFactor_Reajuste
                           ,fRea_Acum_Anterior
                           ,fNoUtilizado
                           ,sModulo_Err
                           ,sString_Err
                           ,Result);

       if NOT Result Then
          exit;
//    end;


    fReajuste_Periodo           := fRea_Acum_Actual - fRea_Acum_Anterior;
    fInteres_Acum_UM_REAJUSTADO := fInteres_Acum_UM + fReajuste_Periodo;
    fInteres_Acum_MC            := fInteres_Acum_UM + fReajuste_Periodo;
  end
  else  // INDEXADOS
  begin
     // Por definición de esta funcion la fecha del ultimo cupon antes de
     // la fecha_hasta es igual a la fecha del ultimo cupon antes de fecha desde
     Reajuste_Indexado(sUnidadMonetaria
                      ,sMoneda_Conversion
                      ,'BC'
                      ,dUltimoVctoAntesFechaHasta
                      ,dFecha_Desde
                      ,fIntereses_Acumulados_Cierre_Actual
                      ,fNoUtilizado
                      ,fRea_Acum_Actual
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

     if NOT Result then
        exit;

     Reajuste_Indexado(sUnidadMonetaria
                      ,sMoneda_Conversion
                      ,'BC'
                      ,dUltimoVctoAntesFechaHasta
                      ,dFecha_Desde
                      ,fIntereses_Acumulados_Cierre_Anterior
                      ,fNoUtilizado
                      ,fRea_Acum_Anterior
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

     if NOT Result then
        exit;


  end;
  // Necesito saber el tipo de moneda (indice o moneda)
  Datos_Moneda_Mem(sUnidadMonetaria
                  ,sTipo_Moneda
                  ,sDescripcion_Moneda
                  ,sMoneda_Paridad);

{  Busca_Valores_Monedas_Periodo_Mem(sUnidadMonetaria
                                   ,sMoneda_Paridad
                                   ,sTipo_Moneda
                                   ,sTipo_Unidad
                                   ,sUnidad
                                   ,sTipo_Variacion);
}
  if sUnidadMonetaria <> sMoneda_Conversion then
  begin
  // Si la moneda de origen (instrumento) es un indice se entiende que
  // al convertirla se esta reajustando
  if sTipo_moneda = 'I' then
     conversion_unidad_mon(sUnidadMonetaria
                          ,sMoneda_Conversion
                          ,'BC'
                          ,dFecha_Hasta
                          ,fInteres_Acum_UM
                          ,fInteres_Acum_MC
                          ,sModulo_Err
                          ,sString_Err
                          ,Result)
  else
     // Si la moneda de origen (instrumento) es una moneda debe tomarse
     // el valor UM reajustado antes de convertirla
     conversion_unidad_mon(sUnidadMonetaria
                          ,sMoneda_Conversion
                          ,'BC'
                          ,dFecha_Hasta
                          ,fInteres_Acum_UM_REAJUSTADO
                          ,fInteres_Acum_MC
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
  end;
end;
//------------------------------------------------------------------------------
procedure Intereses_Acumulados_Vig(sTipo_Instrumento         : String;
                                   sEmisor                   : String;
                                   sInstrumento              : String;
                                   sSerie                    : String;
                                   dFecha_Vig                : TDateTime;
                                   sNemotecnico              : String;
                                   fTasaEmision              : Double;
                                   fTasaCalculo              : Double;
                                   sUnidadMonetaria          : String;
                                   sTipoNominales            : String;
                                   dFecha_Emision             : TDateTime;
                                   dFecha_Vencimiento         : TDateTime;
                                   dFecha_Compra              : TDateTime;
                                   dFecha_Operacion           : TDateTime;
                                   dFecha_Pago                : TDatetime;
                                   sMoneda_Conversion        : String;
                                   fCupones_Cortados         : Double;
                                   fNominales                : Double;
                                   dFecha_Desde              : TDateTime;
                                   dFecha_Hasta              : TDateTime;
                                   sTabla_Desarr_Cargada     : String;
                                   var RegDes                : TReg_Descriptor;
                                   var Array_Mem_Desarr      : TArray_Mem_Desarr;
                                   var fInteres_Acum_UM      : Double;
                                   var fInteres_Acum_MC      : Double;
                                   var fInteres_Acum_UM_REAJUSTADO : Double;
                                   var fRea_Acum_Anterior          : Double;
                                   var fRea_Acum_Actual            : Double;
                                   var fReajuste_Periodo           : Double;
                                   var sModulo_Err                 : String;
                                   var sString_Err                 : String;
                                   var Result                      : Boolean);
var
   fValor_Par_UM_Desde : Double;
   fValor_Par_UM_Hasta : Double;
   //fValor_Par_MC_Desde : Double;
   //fValor_Par_MC_Hasta : Double;

   Reg_Val_In                : TRegistro_Valoriza_In;
   Reg_Val_Out               : TRegistro_Valoriza_Out;
   sTipo_Instrumento_RVRF    : String;
   //sAux_Valorizacion_Proceso : String;
   fPtje_Aplica_Reajuste     : Double;
   sCodigo_MondInd           : String;
   s0Cod_Tratam_Inicio       : String;
   s1Cod_Tratam_Termino      : String;
   //fValor_Ind_Inicio         : Double;
   //fValor_Ind_Termino        : Double;
   //dFecha_Inicio             : TDateTime;
   //dFecha_Termino            : TDateTime;
   bVariacionCambiaria       : Boolean;
   fFactor_Reajuste          : Double;
   Registro_Fechas           : TRegistro_Fechas;
   iCuponVigente             : Integer;
   iNro_Cupon                : Integer;
   fCapital_Residual         : Double;
   //fCapital_Residual_Reajustado_UM : Double;
   //fReajuste_Capital         : Double;
   //dUltimoVctoAntesFechaDesde: TDateTime;
   dUltimoVctoAntesFechaHasta: TDateTime;

   fIntereses_Acumulados_Cierre_Actual   : Double;
   fIntereses_Acumulados_Cierre_Anterior : Double;
   //dAux_fecha_pago                       : TdateTime;

   sMoneda_Paridad                       : String;
   sTipo_Moneda                          : String;
   // sTipo_Variacion                       : String;
   sDescripcion_Moneda                   : String;
   sPaga_Reajuste_Capital                : String;
   sNo_Considera_en_Interes              : String;
   sSolo_Aplica_en_Vctos                 : String;
   sNo_Considera_Negativos               : String;

begin
  Result := True;

  fInteres_Acum_UM            := 0;
  fInteres_Acum_MC            := 0;
  fInteres_Acum_UM_REAJUSTADO := 0;
  fRea_Acum_Anterior          := 0;
  fRea_Acum_Actual            := 0;
  fReajuste_Periodo           := 0;

  // Para los instrumentos de Renta Variable NO DEBE CALCULARES INTERES DEVENGADO
  // confirmado con Daniel Quezada 30/07/2004
  if sValorizacion_Proceso = 'SI' then
  begin
     if NOT Leer_Tipo_Instrumento_Mem(sInstrumento
                                     ,sTipo_Instrumento_RVRF) then
     begin
       sString_Err := 'Error en definición de instrumento ('
                     +sInstrumento
                     +')';
       Result := False;
       exit;
     end;
  end
  else
  begin
     if NOT Leer_Tipo_Instrumento_Mem(sInstrumento
                                     ,sTipo_Instrumento_RVRF) then
     begin
       sString_Err := 'Error en definición de instrumento ('
                     +sInstrumento
                     +')';
       Result := False;
       exit;
     end;
  end;

  if sTipo_Instrumento_RVRF = 'RV' then
     exit;


  if dFecha_Desde = dFecha_Hasta then
  begin
    fInteres_Acum_UM := 0;
    fInteres_Acum_MC := 0;
    fInteres_Acum_UM_REAJUSTADO := 0;
    exit;
  end;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Hasta
               ,True
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  ultimo_vencimiento_new(dFecha_Emision
                        ,dFecha_Hasta
                        ,Array_Mem_Desarr
                        ,RegDes
                        ,True
                        ,iNro_Cupon
                        ,dUltimoVctoAntesFechaHasta
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

  if not Result then
     exit;

  // Ojo: La funcion interses acumualdos solo funciona con fecha desde y hasta en el mismo
  // Periodo de pago (sin cortes de cupon en el medio)
  // Caso contrario usar funcion Accrued_Interest (C.J. & F.I. 19-12-2003

  if (dFecha_Desde < dUltimoVctoAntesFechaHasta) then
  begin
    sModulo_Err := 'Interes_acumulados';
    sString_Err := 'Existe vencimiento en el periodo: '
                   +DateToStr(dFecha_Desde)
                   +' - '
                   +DateToStr(dUltimoVctoAntesFechaHasta);
    Result      := False;
    exit;
  end;

  Verifica_Excepcion_Variacion_Cambiaria(sEmisor
                                        ,sInstrumento
                                        ,sSerie
                                        ,iCuponVigente // Para todos los flujos
                                        ,dFecha_Hasta
                                        ,fPtje_Aplica_Reajuste
                                        ,sCodigo_MondInd
                                        ,s0Cod_Tratam_Inicio
                                        ,s1Cod_Tratam_Termino
                                        ,Registro_Fechas.Fecha_Desde
                                        ,Registro_Fechas.Fecha_Hasta
                                        ,sPaga_Reajuste_Capital
                                        ,sNo_Considera_en_Interes
                                        ,sSolo_Aplica_en_Vctos
                                        ,sNo_Considera_Negativos
                                        ,bVariacionCambiaria);
  if bVariacionCambiaria then
     Reg_Val_In.sValor_Cupon_Original := 'S'
  else
     Reg_Val_In.sValor_Cupon_Original := 'N';


  Registro_Fechas.Fecha_Compra      := dFecha_Compra;
  Registro_Fechas.Fecha_Emision     := dFecha_Emision;
  Registro_Fechas.Fecha_Vencimiento := dFecha_Vencimiento;
  Registro_Fechas.Fecha_Calculo     := dFecha_Desde;
  // Para obtener el valor al la fecha del vencimiento anterior
  // No debe tomar en cuenta el devengamiento desde fecha de pago
  // Por eso cambio la fecha de pago a la fecha del ultimo vencimiento
  // para que valorice en forma correcta a esa fecha
  // dAux_fecha_pago := dFecha_Pago;

  // OJO si estoy calculando devengamientos antes de la compra (Paid for accrued)
  // o para la venta y es antes de la operacion, debo cambiar la fecha de pago
  // sino el valorizador cambiara la fecha de calculo a la fecha de pago.
  if (dFecha_Desde < dFecha_Operacion) or
     (dFecha_Desde < dFecha_Pago)      then
  begin
     Reg_Val_In.Considera_Devengamiento_Formula := 'NO';
     Registro_Fechas.Fecha_Pago        := dFecha_Desde;
     Reg_Val_In.dFechaPago             := dFecha_Desde;
  end
  else
  begin
     Reg_Val_In.Considera_Devengamiento_Formula := 'SI';
     Registro_Fechas.Fecha_Pago        := dFecha_Pago;
     Reg_Val_In.dFechaPago             := dFecha_Pago;
  end;


  // Obtengo valor PAR a fecha de desde
  Reg_Val_In.Tipo_Instrumento   := sTipo_Instrumento;
  Reg_Val_In.sEmisor            := sEmisor;
  Reg_Val_In.sInstrumento       := sInstrumento;
  Reg_Val_In.sSerie             := sSerie;
  Reg_Val_In.dFecha_Vig         := dFecha_Vig;
  Reg_Val_In.Nemotecnico        := sNemotecnico;
  Reg_Val_In.dTasaEmision       := fTasaEmision;
  Reg_Val_In.sUnidadMonetaria   := sUnidadMonetaria;
  Reg_Val_In.sTipoNominales     := sTipoNominales;
  Reg_Val_In.dFechaEmision      := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
  Reg_Val_In.dFechaCalculo      := dFecha_Desde;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

  Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
  Reg_Val_In.Con_Cupon          := False;                // sin Cupon
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
  Reg_Val_Out.Nominales         := fNominales;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes            := RegDes;
  Reg_Val_Out.TasaCalculo       := fTasaCalculo;
  Reg_Val_In.dFechaCompra       := dFecha_Compra;
  Reg_Val_In.dFechaOperacion    := dFecha_Operacion;
  Reg_Val_In.Tabla_Desarr_Cargada := sTabla_Desarr_Cargada;


// CJF, al parecer el valor viene sucio Reg_Val_Out.ValorInvertidoUM = +NAN y al covertir mas adelante se cae por invalid


// CJF, estos valores (Reg_Val_Out.ValorInvertidoUM, Reg_Val_Out.ValorInvertidoMC)
// al llegar a esta funcion llegan sucios "+NAN" y se acupan mas adelante y marca error de ivalid
// 04/02/2007 mapfre peru folio 699
   Reg_Val_Out.ValorInvertidoUM := 0;
   Reg_Val_Out.ValorInvertidoMC := 0;
//
  // Guardo valor original de sValorizacion_Proceso
//  sAux_Valorizacion_Proceso := sValorizacion_Proceso;
//  sValorizacion_Proceso := 'NO'; //Por Valores de Cambio Cargados sólo a fecha de calculo en memoria
  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);
  fValor_Par_UM_Desde   := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste   ;
  // fValor_Par_MC_Desde   := Reg_Val_Out.Valor_Par_MC    ;
  Array_Mem_Desarr      := Reg_Val_Out.Array_Mem_Desarr;
  RegDes                := Reg_Val_Out.RegDes          ;
  Reg_Val_Out.RegDes      := RegDes;

  // Restablesco valor que venia en sValorizacion_Proceso
//  sValorizacion_Proceso := sAux_Valorizacion_Proceso;
//  if (sValorizacion_Proceso    <> 'SI') and
//     (sAux_Valorizacion_Proceso = 'SI') then
    if (sValorizacion_Proceso    <> 'SI') then
        Crea_Tablas_Temporales_Tasa_Flotante;

  if NOT Result then
     exit;
  sTabla_Desarr_Cargada := Reg_Val_In.Tabla_Desarr_Cargada;

  // Calculo Valor PAR a la fecha hasta
  Reg_Val_In.Con_Cupon          := True;               // Con Cupon
  Reg_Val_In.dFechaCalculo      := dFecha_Hasta;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_Out.Nominales         := fNominales;
  Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr   ;
  Reg_Val_Out.TasaCalculo       := fTasaCalculo;
  Reg_Val_In.Considera_Devengamiento_Formula := 'SI';
//  sValorizacion_Proceso := 'NO'; //Por Valores de Cambio Cargados sólo a fecha de calculo en memoria

  // OJO si estoy calculando devengamientos antes de la compra (Paid for accrued)
  // o para la venta y es antes de la operacion, debo cambiar la fecha de pago
  // sino el valorizador cambiara la fecha de calculo a la fecha de pago.
  if dFecha_Hasta < dFecha_Operacion then
  begin
     Registro_Fechas.Fecha_Pago        := dFecha_Hasta;
     Reg_Val_In.dFechaPago             := dFecha_Hasta;
  end
  else
  begin
     Registro_Fechas.Fecha_Pago        := dFecha_Pago;
     Reg_Val_In.dFechaPago             := dFecha_Pago;
  end;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;
  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fValor_Par_UM_Hasta   := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste    ;
  // fValor_Par_MC_Hasta   := Reg_Val_Out.Valor_Par_MC    ;
  Array_Mem_Desarr      := Reg_Val_Out.Array_Mem_Desarr;
  Reg_Val_Out.RegDes      := RegDes;
  if NOT Result then
     exit;

  fInteres_Acum_UM      := fValor_Par_UM_Hasta - fValor_Par_UM_Desde;
  fInteres_Acum_UM_REAJUSTADO := fInteres_Acum_UM;
  fInteres_Acum_MC      := fInteres_Acum_UM;

  // Obtengo valor PAR a ultimo vcto no puede ser capital residual
  // ya que descubrimos que la NBC por tener la tasa mala no da el Capital Residual
  // en los cortes de cupon.

    ultimo_vencimiento_new(dFecha_Emision
                        ,dFecha_Hasta
                        ,Array_Mem_Desarr
                        ,RegDes
                        ,TRUE             // Con Cupon (Si cae en el vcto trae el vcto anterior)
                        ,iNro_Cupon
                        ,dUltimoVctoAntesFechaHasta
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

  if not Result then
     exit;

  Reg_Val_In.Tipo_Instrumento   := sTipo_Instrumento;
  Reg_Val_In.sEmisor            := sEmisor;
  Reg_Val_In.sInstrumento       := sInstrumento;
  Reg_Val_In.sSerie             := sSerie;
  Reg_Val_In.Nemotecnico        := sNemotecnico;
  Reg_Val_In.dTasaEmision       := fTasaEmision;
  Reg_Val_In.sUnidadMonetaria   := sUnidadMonetaria;
  Reg_Val_In.sTipoNominales     := sTipoNominales;
  Reg_Val_In.dFechaEmision      := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
  Reg_Val_In.dFechaCalculo      := dUltimoVctoAntesFechaHasta;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

  if dUltimoVctoAntesFechaHasta < dFecha_Operacion then
  begin
     Registro_Fechas.Fecha_Pago        := dUltimoVctoAntesFechaHasta;
     Reg_Val_In.dFechaPago             := dUltimoVctoAntesFechaHasta;
  end
  else
  begin
     Registro_Fechas.Fecha_Pago        := dFecha_Pago;
     Reg_Val_In.dFechaPago             := dFecha_Pago;
  end;


  Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
  Reg_Val_In.Con_Cupon          := False;                // sin Cupon
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
  Reg_Val_Out.Nominales         := fNominales;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes            := RegDes;
  Reg_Val_Out.TasaCalculo       := fTasaCalculo;
  Reg_Val_In.dFechaCompra       := dFecha_Compra;
  Reg_Val_In.dFechaOperacion    := dFecha_Operacion;
  Reg_Val_In.Tabla_Desarr_Cargada := sTabla_Desarr_Cargada;

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fCapital_Residual   := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste   ;


//  if (sValorizacion_Proceso    <> 'SI') and
//     (sAux_Valorizacion_Proceso = 'SI') then

  if (sValorizacion_Proceso    <> 'SI')  then
      Crea_Tablas_Temporales_Tasa_Flotante;

  // Me aseguro que variable sValor_Cupon_Original quede en forma estandar
  Reg_Val_In.sValor_Cupon_Original := 'N';
  fIntereses_Acumulados_Cierre_Actual   := fValor_Par_UM_Hasta - fCapital_Residual;
  fIntereses_Acumulados_Cierre_Anterior := fValor_Par_UM_Desde - fCapital_Residual;

  if bVariacionCambiaria then // Es NO Indexado
  begin
    Registro_Fechas.Fecha_Calculo      := dFecha_Hasta;
    Registro_Fechas.Fecha_Compra       := dFecha_Compra;
    Registro_Fechas.Fecha_Emision      := dFecha_Emision;
    Registro_Fechas.Fecha_Vencimiento  := dFecha_Vencimiento;
    Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;

    if iCuponVigente = 1 then
       Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
    else
       Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCuponVigente-1].Fecha_Vcto;

    Reajuste_No_Indexado(RegDes.Codigo_Emisor
                        ,RegDes.Codigo_Instrumento
                        ,RegDes.Serie
                        ,dFecha_Hasta
                        ,Registro_Fechas
                        ,iCuponVigente
                        ,fIntereses_Acumulados_Cierre_Actual
                        ,fFactor_Reajuste
                        ,fRea_Acum_Actual
                        ,fNoUtilizado
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

    if NOT Result Then
       exit;


//    if dFecha_Compra = dFecha_Desde then
//       fRea_Acum_Anterior := 0
//    else
//    begin
       Registro_Fechas.Fecha_Calculo      := dFecha_Desde;
       Reajuste_No_Indexado(RegDes.Codigo_Emisor
                           ,RegDes.Codigo_Instrumento
                           ,RegDes.Serie
                           ,dFecha_Desde
                           ,Registro_Fechas
                           ,iCuponVigente
                           ,fIntereses_Acumulados_Cierre_Anterior
                           ,fFactor_Reajuste
                           ,fRea_Acum_Anterior
                           ,fNoUtilizado
                           ,sModulo_Err
                           ,sString_Err
                           ,Result);

       if NOT Result Then
          exit;
//    end;


    fReajuste_Periodo           := fRea_Acum_Actual - fRea_Acum_Anterior;
    fInteres_Acum_UM_REAJUSTADO := fInteres_Acum_UM + fReajuste_Periodo;
    fInteres_Acum_MC            := fInteres_Acum_UM + fReajuste_Periodo;
  end
  else  // INDEXADOS
  begin
     // Por definición de esta funcion la fecha del ultimo cupon antes de
     // la fecha_hasta es igual a la fecha del ultimo cupon antes de fecha desde
     Reajuste_Indexado(sUnidadMonetaria
                      ,sMoneda_Conversion
                      ,'BC'
                      ,dUltimoVctoAntesFechaHasta
                      ,dFecha_Desde
                      ,fIntereses_Acumulados_Cierre_Actual
                      ,fNoUtilizado
                      ,fRea_Acum_Actual
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

     if NOT Result then
        exit;

     Reajuste_Indexado(sUnidadMonetaria
                      ,sMoneda_Conversion
                      ,'BC'
                      ,dUltimoVctoAntesFechaHasta
                      ,dFecha_Desde
                      ,fIntereses_Acumulados_Cierre_Anterior
                      ,fNoUtilizado
                      ,fRea_Acum_Anterior
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

     if NOT Result then
        exit;


  end;
  // Necesito saber el tipo de moneda (indice o moneda)
  Datos_Moneda_Mem(sUnidadMonetaria
                  ,sTipo_Moneda
                  ,sDescripcion_Moneda
                  ,sMoneda_Paridad);

{  Busca_Valores_Monedas_Periodo_Mem(sUnidadMonetaria
                                   ,sMoneda_Paridad
                                   ,sTipo_Moneda
                                   ,sTipo_Unidad
                                   ,sUnidad
                                   ,sTipo_Variacion);
}
  if sUnidadMonetaria <> sMoneda_Conversion then
  begin
  // Si la moneda de origen (instrumento) es un indice se entiende que
  // al convertirla se esta reajustando
  if sTipo_moneda = 'I' then
     conversion_unidad_mon(sUnidadMonetaria
                          ,sMoneda_Conversion
                          ,'BC'
                          ,dFecha_Hasta
                          ,fInteres_Acum_UM
                          ,fInteres_Acum_MC
                          ,sModulo_Err
                          ,sString_Err
                          ,Result)
  else
     // Si la moneda de origen (instrumento) es una moneda debe tomarse
     // el valor UM reajustado antes de convertirla
     conversion_unidad_mon(sUnidadMonetaria
                          ,sMoneda_Conversion
                          ,'BC'
                          ,dFecha_Hasta
                          ,fInteres_Acum_UM_REAJUSTADO
                          ,fInteres_Acum_MC
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
  end;
end;
//------------------------------------------------------------------------------
procedure Obtiene_Book_Value(sEmpresa_Usuario                        : String;
                             sCartera                                : String;
                             sTransaccion_Compra                     : String;
                             sFolio_Compra                           : String;
                             sItem_Omd_Compra                        : Double;
                             sTipoInstrumento                        : String;
                             sEmisor                                 : String;
                             sInstrumento                            : String;
                             sSerie                                  : String;
                             sNemotecnico                            : String;
                             fTasa_Emision                           : Double;
                             fTasa_Calculo                           : Double;
                             sTipo_Nominales                         : String;
                             sMoneda_Operacion                       : String;
                             sMoneda_Instrumento                     : String;
                             dFecha_Emision                           : TDateTime;
                             dFecha_Vencimiento                       : TDateTime;
                             dFecha_Compra                            : TDateTime;
                             dFecha_Pago                              : TDateTime;
                             sMoneda_Informe                         : String;
                             fCupones_Cortados                       : Double;
                             dFecha_Calculo                          : TDateTime;
                             dFecha_Cierre_Anterior                  : TDateTime;
                             fNominales_Originales                   : Double;
                             fNominales_Vigentes                     : Double;
                             fValor_Compra_UM                        : Double;
                             sTipoCalculoDias                        : String;
                             sPais_Tasa                              : String;
                             RegDes                                  : TReg_Descriptor;
                             Array_Mem_Desarr                        : TArray_Mem_Desarr;
                             //
                             //var Array_Mem_Amortizacion_Actual_Cost  : TArray_Mem_Amortizacion_Actual_Cost;
                             //
                             sTabla_Desarr_Cargada                   : String;
                             bMetodo_TIR_de_Capital                  : Boolean;
                             sMotivo_Inversion                       : String;
                             sProceso_ValorExposicion                : String;
                             var fBook_Value_UM                      : Double;
                             var fBook_Value_MC                      : Double;
                             var fDif_Precio                         : Double;
                             var fActual_Cost_MC                     : Double; // Valor de compra limpio y sin reajustes
                             var fTir_Capital_Cpa                    : Double;
                             var fActual_Cost_UM_Reajustado_a_Cpa    : Double;
                             var fActual_Cost_MC_Reajustado_a_Cpa    : Double;
                             var fReajuste_a_la_Cpa                  : Double;
                             var fReajuste_Par_Value_a_la_Cpa        : Double;
                             var fReajuste_Actual_Cost_Total         : Double;
                             var fReajuste_Actual_Cost_Periodo       : Double;
                             var fRea_Acumulado_Actual_Cost_Anterior : Double;
                             var fRea_Acumulado_Actual_Cost_Actual   : Double;
                             var fReajuste_Indexado_Inc_Dec_Total    : Double;
                             var fReajuste_No_Indexado_Inc_Dec_Total : Double;
                             var fActual_Cost_Residual_UM            : Double;
                             var fActual_Cost_Residual_MC            : Double;
                             var fActual_Cost_Residual_MC_SinRea     : Double;
                             var fMonto_Amort_a_la_CPA_UM              : Double; // Falta Amortizacion de actual cost a la compra
                             var fMonto_Amort_a_la_CPA_MC              : Double;
                             var fReajuste_Indexado_Amort_a_la_CPA     : Double;
                             var fReajuste_No_Indexado_Amort_a_la_CPA  : Double;
                             var fMonto_Capitalizado_UM              : Double;
                             var fMonto_Capitalizado_MC              : Double;
                             var fReajuste_Indexado_Capitalizado     : Double;
                             var fReajuste_No_Indexado_Capitalizado  : Double;
                             var fIncrease_Decrease_Total            : Double;
                             var fIncrease_Decrease_Total_SinRea     : Double;

                             var fIncrease_Decrease_To_Maturity_Act  : Double;
                             var fIncrease_Decrease_To_Maturity_Act_SinRea  : Double;
                             var fProporcion_ActualCost_SalInsol     : Double;
                             var fMonto_Amort_Actual_Cost_A_CPA_UM         : Double;
                             var fMonto_Amort_Actual_Cost_A_CPA_MC         : Double;
                             var fReajuste_Indexado_Actual_Cost_A_CPA      : Double;
                             var fReajuste_No_Indexado_Actual_Cost_A_CPA   : Double;
                             var fRea_Capital_Residual_RF                  : Double;
                             var fExra_en_Capital_Residual_RF              : Double;
                             var fExra_en_Actual_Cost_RF                   : Double;
                             var fExra_en_Book_Value_RF                    : Double;
                             var fIncrease_Decrease_To_Maturity_Cpa        : Double;
                             var fAmortizacion_Inc_Dec_Pagada              : Double;
                             var sModulo_Err                          : String;
                             var sString_Err                          : String;
                             var Result                              : Boolean);

var
   fDiferencia_TC_Actual_Cost_A_CPA : Double;
   dUltimoVcto_CPA              : TdateTime;

   fValor_Clean_UM_Rea          : Double;

   fValor_Compra_Clean_UM       : Double;
   fActual_Cost_Compra_UM       : Double;

   fNoUtilizado                 : Double;
   fSaldo_Insoluto_Cpa          : Double;
   fSaldo_Insoluto_Cpa_ConRea   : Double;

   fSaldo_Insoluto_Act_SinRea   : Double;
   fSaldo_Insoluto_Act_ConRea   : Double;

   fSaldo_Insoluto_Ant          : Double;
   fSaldo_Insoluto_Ant_ConRea   : Double;
   fValor_Par_Compra            : Double;
   Reg_Val_In                   : TRegistro_Valoriza_In;
   Reg_Val_Out                  : TRegistro_Valoriza_Out;
   sTipo_Instrumento_RVRF       : String;
   Aux_Fecha_Cierre             : TDateTime;
   Aux_Fecha_Cierre_Ant         : TDateTime;
   sCod_Indice_Reajuste         : String;
   fActual_Cost_Reajustado      : Double;
   fReajuste                    : Double;
   fFactor_Reajuste             : Double;
   Registro_Fechas              : TRegistro_Fechas;
   fMonto_Amort_Pagado_UM                    : Double;
   fMonto_Amort_Pagado_MC                    : Double;
   fReajuste_Indexado_Amort_Pagado           : Double;
   fReajuste_No_Indexado_Amort_Pagado        : Double;
   iCupon_Vigente                     : Integer;
   fActual_Cost_UM                    : Double;

   fReajuste_Index_Acumulado_Actual_Cost_Anterior,
   fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior,
   fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior_UM,

   fReajuste_Index_Acumulado_Actual_Cost_Actual,
   fReajuste_NoIndex_Acumulado_Actual_Cost_Actual    : Double;
   fReajuste_NoIndex_Acumulado_Actual_Cost_Actual_UM : Double;

   fReajuste_No_Indexado_Inc_Dec_Total_UM            : Double;

   fReajuste_Index_Acumulado_Saldo_Insoluto_Ant      : Double;
   fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM_Ant : Double;
   fReajuste_NoIndex_Acumulado_Saldo_Insoluto_Ant    : Double;
   fDiferencia_tipo_cambio_Saldo_Insoluto_Ant        : Double;

   fReajuste_Index_Acumulado_Saldo_Insoluto          : Double;
   fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM     : Double;
   fReajuste_NoIndex_Acumulado_Saldo_Insoluto        : Double;
   fDiferencia_tipo_cambio_Saldo_Insoluto            : Double;

   fReajuste_Index_Acumulado_Saldo_Insoluto_Cpa      : Double;
   fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM_Cpa : Double;
   fReajuste_NoIndex_Acumulado_Saldo_Insoluto_Cpa    : Double;
   fDiferencia_tipo_cambio_Saldo_Insoluto_Cpa        : Double;

   iNro_Cupon  : Integer;
   fDiferencia_tipo_cambio_a_Cpa                     : Double;
   fDiferencia_tipo_cambio_a_Cpa_Ant                 : Double;
   fDiferencia_tipo_cambio                           : Double;
   fDiferencia_tipo_cambio_Inc_Dec_Total             : Double;
   fDiferencia_TC_Amort_Cupon                        : Double;
   fDiferencia_TC_Amort_Cupon_Pagado                 : Double;
   fDiferencia_TC_Capit_Cupon                        : Double;

   i                                                 : Integer;

   fMonto_Amort_Actual_Cost_UM                       : Double;
   fMonto_Amort_Actual_Cost_MC                       : Double;
   fReajuste_Indexado_Actual_Cost                    : Double;
   fReajuste_No_Indexado_Actual_Cost                 : Double;
   fDiferencia_TC_Actual_Cost                        : Double;


    fReajuste_Indexado_Inc_Dec_To_Maturity
   ,fReajuste_No_Indexado_Inc_Dec_To_Maturity_UM
   ,fReajuste_No_Indexado_Inc_Dec_To_Maturity
   ,fDiferencia_tipo_cambio_Inc_Dec_To_Maturity       : Double;

    fDiferencia_tipo_cambio_Inc_Dec_Pagado            : Double;

    sTipo_Moneda                                      : String;
    sDescripcion_Moneda                               : String;
    sMoneda_Paridad                                   : String;

    sTipo_Valuac                                      : String;
    sFormula_Pte                                      : String;
    fBase_Precio                                      : Double;
    sMon_Ind                                          : String;
    bNo_puede_Calcular_TIRK                           : Boolean;

    sTipo_Amortizacion_IncDec                         : String;
    bAmortizacion                                     : Boolean;


    //Aux_Amortizacion_Actual_Cost_Base                 : String;
    Aux_bBook_Value_es_Valor_Presente                 : Boolean;
    Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente : Boolean;
    Aux_Float                                         : Double;

    bAnula_Devengamiento_INCDEC_Ant                   : Boolean;
begin

sModulo_Err := 'Obtiene Book Value';
sString_Err := '';

// Estas variables Globales las dejo en locales
// con el fin de poder cambiarlas solo para esta llamada al Obtiene Book Value
// dependiendo del metodo de amportizacion de Increse / Decrease
Aux_bBook_Value_es_Valor_Presente := bBook_Value_es_Valor_Presente;
Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente := bConsidera_Indexados_para_Book_Value_es_Valor_Presente;
bNo_puede_Calcular_TIRK := False;

// 15-11-2016 Se recupera en cada iteracion el valor original del parametro de GAAP
// Ya que si se cambia en metodo de amortizacion de Inc/Dec se necesita para toda la iteracion y solo recuperarlo en la siguiente. F.I.
sAmortizacion_Actual_Cost_base := sParametro_Amortizacion_Actual_Cost_base;

fBook_Value_UM                            := 0;
fBook_Value_MC                            := 0;
fDif_Precio                               := 0;
fActual_Cost_MC_Reajustado_a_Cpa          := 0;
fReajuste_Actual_Cost_Total               := 0;
fReajuste_Actual_Cost_Periodo             := 0;
fRea_Acumulado_Actual_Cost_Anterior       := 0;
fRea_Acumulado_Actual_Cost_Actual         := 0;
fReajuste_Indexado_Inc_Dec_Total          := 0;
fReajuste_No_Indexado_Inc_Dec_Total       := 0;
fActual_Cost_Residual_MC                  := 0;

fMonto_Amort_Pagado_UM                    := 0;
fMonto_Amort_Pagado_MC                    := 0;
fReajuste_Indexado_Amort_Pagado           := 0;
fReajuste_No_Indexado_Amort_Pagado        := 0;

fMonto_Amort_a_la_CPA_UM                  := 0;
fMonto_Amort_a_la_CPA_MC                  := 0;
fReajuste_Indexado_Amort_a_la_CPA         := 0;
fReajuste_No_Indexado_Amort_a_la_CPA      := 0;

fMonto_Capitalizado_UM                    := 0;
fMonto_Capitalizado_MC                    := 0;
fReajuste_Indexado_Capitalizado           := 0;
fReajuste_No_Indexado_Capitalizado        := 0;
fIncrease_Decrease_Total                  := 0;
fDiferencia_tipo_cambio_a_Cpa_Ant         := 0;
fIncrease_Decrease_Total_SinRea           := 0;
fActual_Cost_Residual_MC_SinRea           := 0;


fMonto_Amort_Actual_Cost_UM           := 0;
fMonto_Amort_Actual_Cost_MC           := 0;
fReajuste_Indexado_Actual_Cost        := 0;
fReajuste_No_Indexado_Actual_Cost     := 0;
fDiferencia_TC_Actual_Cost            := 0;
fValor_Clean_UM_Rea                   := 0;
fExra_en_Capital_Residual_RF          := 0;


Registro_Fechas.Fecha_Emision := dFecha_Emision;
Registro_Fechas.Fecha_Compra  := dFecha_Compra;
Registro_Fechas.Fecha_Calculo := dFecha_Calculo;

// Se necesita en book value para las conversiones de los valores sin reajuste
// En el caso de indices se debe llevar a la moneda de paridad a fecha de compra
// y luego a la moneda de conversion a la fecha de calculo  F.I. 15-09-2006
Datos_Moneda_Mem(sMoneda_Instrumento
                ,sTipo_Moneda
                ,sDescripcion_Moneda
                ,sMoneda_Paridad);

// Se asegura que se hace desde la compra
if dFecha_Calculo < dFecha_Compra then
   dFecha_Calculo := dFecha_Compra;

if dFecha_Cierre_Anterior < dFecha_Compra then
   dFecha_Cierre_Anterior := dFecha_Compra;

  ultimo_vencimiento_new(dFecha_Emision
                        ,dFecha_Compra
                        ,Array_Mem_Desarr
                        ,RegDes
                        ,False
                        ,iNro_Cupon
                        ,dUltimoVcto_CPA
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

  if not Result then
     exit;

  // Saldo Insoluto a la Compra para limpiar valores a la misma
  // Con Nominales VIGENTES
  Saldo_Insoluto(sTipoInstrumento
                ,RegDes
                ,dFecha_Emision
                ,dFecha_Compra
                ,dFecha_Compra   //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                ,fNominales_Originales //fNominales_Vigentes
                ,Array_Mem_Desarr
                ,False
                ,fSaldo_Insoluto_Cpa
                ,fSaldo_Insoluto_Cpa_ConRea
                ,sModulo_Err
                ,sString_Err
                ,Result);

  if NOT Result then
     exit;

  if fSaldo_Insoluto_Cpa = 0 then
  begin
    sModulo_Err := 'Obtención de Book Value';
    sString_Err := 'Error en definición de la tabla de desarrollo. Saldo insoluto a la compra no puede ser cero';
    Result := False;
    Exit;
  end;

  // Ojo se esta usando el reajuste Valor y no la diferencia de
  // los saldos insolutos con rea y sin rea por el caso de los
  // titulos expresados en un indice.

  // NO LO NECESITO EN MC POR ESO PUSE MONEDA INSTRUMENTO MONEDA INSTRUMENTO
  Reajuste_Valor(sInstrumento
                ,sMoneda_Instrumento
                ,sMoneda_Instrumento
                ,dFecha_Emision    // Fecha Desde Para reajuste de capital es desde la emision
                ,dFecha_Compra     // Fecha de Compra
                ,fSaldo_Insoluto_Cpa
                ,dFecha_Compra
                ,dFecha_Emision
                ,RegDes
                ,False             // bConCupon Se incorpora 05-07-2006
                ,Array_Mem_Desarr
                ,sCod_Indice_Reajuste
                ,fReajuste_Index_Acumulado_Saldo_Insoluto_Cpa
                ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM_Cpa
                ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto_Cpa
                ,fSaldo_Insoluto_Cpa_ConRea     // Esta Reajustado y es MC
                ,fDiferencia_tipo_cambio_Saldo_Insoluto_Cpa
                ,sModulo_Err
                ,sString_Err
                ,Result                                   );

  if NOT Result Then
     exit;

  fReajuste_Par_Value_a_la_Cpa := fReajuste_Index_Acumulado_Saldo_Insoluto_Cpa +
                                  fReajuste_NoIndex_Acumulado_Saldo_Insoluto_Cpa;

  Limpia_Valores(sEmpresa_Usuario
                ,sCartera
                ,sTransaccion_Compra
                ,dFecha_Compra
                ,sTipoInstrumento
                ,sEmisor
                ,sInstrumento
                ,sSerie
                ,sNemotecnico
                ,fTasa_Emision
                ,RegDes.Tasa_Efectiva
                ,sMoneda_Instrumento
                ,sTipo_Nominales
                ,dFecha_Emision
                ,dFecha_Vencimiento
                ,dFecha_Compra
                ,dFecha_Pago
                ,sMoneda_Informe
                ,fCupones_Cortados
                ,sTipo_Reajuste_en_Book_Value
                ,fSaldo_Insoluto_Cpa_ConRea
                ,fNominales_Originales
                ,sTabla_Desarr_Cargada
                ,RegDes
                ,Array_Mem_Desarr
                ,dUltimoVcto_CPA
                ,dFecha_Compra
                ,fValor_Compra_UM
                ,fValor_Compra_Clean_UM
                ,fValor_Clean_UM_Rea
                ,sModulo_Err
                ,sString_Err
                ,Result);

  if NOT Result then
     exit;

  fActual_Cost_UM := fValor_Compra_Clean_UM *
                     (fNominales_Vigentes /
                      fNominales_Originales);

  fSaldo_Insoluto_Cpa := fSaldo_Insoluto_Cpa *
                        (fNominales_Vigentes /
                         fNominales_Originales);

  // Si actual cost es negativo no se puede llegar a una TIRK
  // Caso Zurich Enero del 2009 (F.I.)
  if fActual_Cost_UM <= 0 then
     bNo_puede_Calcular_TIRK := True;

  // Nuevo !!!
  // Para calcular el actual cost residual es necesario determinar
  // la proporcion de las amortizaciones que afecta al actual cost
  fProporcion_ActualCost_SalInsol := fActual_Cost_UM /
                                              fSaldo_Insoluto_Cpa;

// Calculo de reajuste de actual cost o capital residual
  Reg_Val_In.Tipo_Instrumento   := sTipoInstrumento;
  Reg_Val_In.sEmisor            := sEmisor;
  Reg_Val_In.sInstrumento       := sInstrumento;
  Reg_Val_In.sSerie             := sSerie;
  Reg_Val_In.Nemotecnico        := sNemotecnico;
  Reg_Val_In.dTasaEmision       := fTasa_Emision;
  Reg_Val_In.sUnidadMonetaria   := sMoneda_Instrumento;
  Reg_Val_In.sTipoNominales     := sTipo_Nominales;
  Reg_Val_In.dFechaEmision      := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
  Reg_Val_In.dFechaPago         := dFecha_Pago;
  Reg_Val_In.sMoneda_Conversion := sMoneda_Informe;
  Reg_Val_In.Con_Cupon          := False;
  Reg_Val_Out.Nominales         := fNominales_Vigentes;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes            := RegDes;
  Reg_Val_In.dFechaCompra       := dFecha_Compra;
  Reg_Val_In.Tabla_Desarr_Cargada := sTabla_Desarr_Cargada;
  Reg_Val_In.Pais_Titulo          := sPais_Tasa;
  Reg_Val_In.Nominales_Compra     := fNominales_Vigentes;
  Reg_Val_In.sValor_Cupon_Original := 'S';
  Reg_Val_In.fCupones_Cortados     := fCupones_Cortados;

  // 29-04-2009 F.I.
  // Se incopora la busqueda del metodo de amortizacion de IncDec
  Reg_Val_In.Proceso_Valuacion  := sProceso_ValorExposicion;
  Reg_Val_In.dFechaCalculo      := dFecha_Calculo;
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_In.Cartera            := sCartera;

  // Solo a TIRK se cambia
  fIncrease_Decrease_To_Maturity_Cpa := fSaldo_Insoluto_Cpa - fActual_Cost_UM;

  // Ojo pese a que la variable se llama Motivo de Operacion se esta utilizando para el motivo de inversion.
  Reg_Val_In.Motivo_Operacion := sMotivo_Inversion;
  // F.I. 11-06-2015
  // Por defecto si bMetodo_TIR_de_Capital viene en True se deja sTipo_Amortizacion_IncDec = 'TIRK'
  //sTipo_Amortizacion_IncDec := '';
//  if bMetodo_TIR_de_Capital then
  if bMetodo_TIR_de_Capital and
     (Not Aux_bBook_Value_es_Valor_Presente) and
     (Not Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente) then
     sTipo_Amortizacion_IncDec := 'TIRK'
  else
     sTipo_Amortizacion_IncDec := '';

  Busca_Met_Amortizacion_IncDec_Mem( Reg_Val_In
                                    ,sTipo_Amortizacion_IncDec
                                    ,bAmortizacion);

  // Si bNo_puede_Calcular_TIRK, esto es que el valor de compra limpio es negativo los flujos no van a tener calculado el Array_Mem_Amortizacion_Actual_Cost[i].ValorPteCupon
  // Y por lo tanto las amortizaciones de actual cost quedaran en cero
  // Acordado entre P.M. y F.I. 14-11-2016 que se defina LINEAL
  if (sTipo_Amortizacion_IncDec = 'TIRK') and bNo_puede_Calcular_TIRK then
      sTipo_Amortizacion_IncDec := 'LINEAL';

  if (sTipo_Amortizacion_IncDec = 'LINEAL') then
  begin
    // Anula los otros metodos de calculo de amortización de IncDec
    // No hay problema en la siguiente llamada ya que ambas variable son locales
    // COn estas condiciones pasara directo a calcula la amortizacion de IncDec Lineal
    Aux_bBook_Value_es_Valor_Presente := False;
    bMetodo_TIR_de_Capital            := False;
  end;

  if (sTipo_Amortizacion_IncDec = 'CURVAS') or
     (sTipo_Amortizacion_IncDec = 'CURVAS-VA') then
  begin
    // Anula los otros metodos de calculo de amortización de IncDec
    // No hay problema en la siguiente llamada ya que ambas variable son locales
    // COn estas condiciones pasara directo a calcula la amortizacion de IncDec Lineal
    Aux_bBook_Value_es_Valor_Presente := True;
    bMetodo_TIR_de_Capital            := False;
    if (sTipo_Amortizacion_IncDec = 'CURVAS-VA') then
       Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente := True;
  end;

  //ggarcia 04-03-2019
  if sTipo_Amortizacion_IncDec = 'CURVA-NASB' then
  begin
    // Anula los otros metodos de calculo de amortización de IncDec
    // No hay problema en la siguiente llamada ya que ambas variable son locales
    // COn estas condiciones pasara directo a calcula la amortizacion de IncDec Lineal
    Aux_bBook_Value_es_Valor_Presente := True;
    bMetodo_TIR_de_Capital            := False;
  end;

  if (sTipo_Amortizacion_IncDec = 'TIRK') then
  begin
    // Anula los otros metodos de calculo de amortización de IncDec
    // No hay problema en la siguiente llamada ya que ambas variable son locales
    // COn estas condiciones pasara directo a calcula la amortizacion de IncDec Lineal
    Aux_bBook_Value_es_Valor_Presente := False;
    bMetodo_TIR_de_Capital            := True;
  end;

  // Este if hace la excepcion que no calcule TIRK ni lineal sino que
  // despues en las amortizaciones determina el proporcional
  if (sTipo_Amortizacion_IncDec = 'PROP_CUPON') then
  begin
     fIncrease_Decrease_To_Maturity_Cpa := fSaldo_Insoluto_Cpa - fActual_Cost_UM;
     fIncrease_Decrease_Total            := 0;
     fIncrease_Decrease_To_Maturity_Act  := 0;
  end
  else
  if  NOT (Aux_bBook_Value_es_Valor_Presente  and
            (  Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente OR
              (Not RegDes.Variacion_Cambiaria and RegDes.bSin_Tasa_en_Flujos
              )
            )
          )
     or (SAmortizacion_Actual_Cost_base = 'Amortizacion_Capital_TIR_Capital') then
  Begin
     if (bMetodo_TIR_de_Capital) and
        ((sTipoInstrumento = 'S') or ((sTipoInstrumento = 'U') and (sTipo_Nominales = 'F'))) and
         NOT bNo_puede_Calcular_TIRK Then
     begin
              IncDec_por_TIRK ( sTipoInstrumento
                          ,RegDes
                          ,dFecha_Emision
                          ,dFecha_Calculo
                          ,dFecha_Compra
                          ,dFecha_Vencimiento
                          ,fNominales_Vigentes
                          ,Array_Mem_Desarr
                          ,fSaldo_Insoluto_Cpa
                          ,fActual_Cost_UM
                          ,Reg_Val_In
                          ,Reg_Val_Out
                          ,fTir_Capital_Cpa
                          ,fIncrease_Decrease_Total
                          ,fIncrease_Decrease_To_Maturity_Cpa
                          ,fIncrease_Decrease_To_Maturity_Act
                          ,sModulo_Err
                          ,sString_Err
                          ,Result
                         );
         if NOT Result Then   // Agregado el 11-09-2013 No se estaba controlando el error F.I.
            exit;

     end
     else  // Calculos lineales
     begin
         // Para cuadre de ACE (Si no es tir de capital...).
         // Se comenta el 12-08-2010 P.M.& F.I.  Se agrega condición !!!!
         if NOT Transaccion_Implica_mem(sEmpresa_Usuario,'TIR CAPITA') then
            fProporcion_ActualCost_SalInsol := 1;

         Inc_Dec_Lineal ( dFecha_Calculo
                         ,dFecha_Compra
                         ,dFecha_Vencimiento
                         ,fSaldo_Insoluto_Cpa
                         ,fActual_Cost_UM
                         ,sTipoCalculoDias
                         ,sPais_Tasa
                         ,fDif_Precio
                         ,fIncrease_Decrease_Total
                         ,fIncrease_Decrease_To_Maturity_Cpa
                         ,fIncrease_Decrease_To_Maturity_Act
                        );
     end;
  end;

///////////////////////////////////////////
  // Determino Fecha Desde para considerar amortizaciones
  if dFecha_Compra = dFecha_Calculo then
     aux_Fecha_Cierre := dFecha_Calculo    // Compra
  else
     if dFecha_Vencimiento = dFecha_Calculo then
        aux_Fecha_Cierre := dFecha_Calculo - 1    // Vencimiento Final
     else
        if dFecha_Calculo = dFechaCierre then
           aux_Fecha_Cierre := dFecha_Calculo     // Actualizacion de saldos (dpart1)
        else
           aux_Fecha_Cierre := dFecha_Calculo; // Venta

  fMonto_Amort_Actual_Cost_A_CPA_UM         := 0;
  fMonto_Amort_Actual_Cost_A_CPA_MC         := 0;
  fReajuste_Indexado_Actual_Cost_A_CPA      := 0;
  fReajuste_No_Indexado_Actual_Cost_A_CPA   := 0;
  fDiferencia_TC_Actual_Cost_A_CPA          := 0;

  /////////
  //Aux_Amortizacion_Actual_Cost_Base := sAmortizacion_Actual_Cost_Base;
  //if (sTipo_Amortizacion_IncDec = 'PROP_CUPON') then
  if (sTipo_Amortizacion_IncDec <> 'TIRK') then     // F.I. 10-06-2015 Cuando no se esta calculando la amortizacion de Inc_Dec a TIRK, no se tendra el dato en el proceso de calculo de amortizaciones de actual_cost
  begin                                             // Para "Amortización de Actual Cost en base a: Amortización en base a TIR de Capital a la compra "
     // En el caso de Increase Decrease Proporcional al cupón se requiere que
     // en el calculo de amortizaciones realize el calculo por proporciuon y no por TIRK
     // Guardo lo que venia en sAmortizacion_Actual_Cost_Base en la variable Aux
     // para luego recuperarla para asegurarme que no lo haga como TIRK
     sAmortizacion_Actual_Cost_Base    := '';
  end;
  Amortizacion_Periodo(sInstrumento
                      ,sTipoInstrumento
                      ,sCartera
                      ,RegDes
                      ,dFecha_Compra
                      ,aux_Fecha_Cierre
                      ,dFecha_Compra
                      ,dFecha_Emision
                      ,fNominales_Originales
                      ,fNominales_Vigentes
                      ,sMoneda_Instrumento
                      ,sMoneda_Informe
                      ,sEmpresa_Usuario
                      ,sTransaccion_Compra
                      ,sFolio_Compra
                      ,sItem_Omd_Compra
                      ,Array_Mem_Desarr
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

                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

  // Recupera lo indicado en los parametros de GAAP.
  //sAmortizacion_Actual_Cost_Base := Aux_Amortizacion_Actual_Cost_Base;

  if NOT Result then
     exit;

  fAmortizacion_Inc_Dec_Pagada := fMonto_Amort_a_la_CPA_UM - fMonto_Amort_Actual_Cost_A_CPA_UM;
  Reajuste_Valor(sInstrumento
                ,sMoneda_Instrumento
                ,sMoneda_Informe
                ,dFecha_Compra
                ,dFecha_Calculo
                ,fAmortizacion_Inc_Dec_Pagada
                ,dFecha_Compra
                ,dFecha_Emision
                ,RegDes
                ,False             // bConCupon Se incorpora 05-07-2006
                ,Array_Mem_Desarr
                ,sCod_Indice_Reajuste
                ,fReajuste_Index_Acumulado_Actual_Cost_Anterior
                ,fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior_UM
                ,fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior
                ,fAmortizacion_Inc_Dec_Pagada
                ,fDiferencia_tipo_cambio_Inc_Dec_Pagado
                ,sModulo_Err
                ,sString_Err
                ,Result                                   );

  if NOT Result Then
     exit;

  Conversion_unidad_mon(sMoneda_Instrumento
                       ,sMoneda_Informe
                       ,'BC'
                       ,dFecha_Compra    //dFecha_Calculo
                       ,fActual_Cost_UM
                       ,fActual_Cost_MC
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

  if NOT Result then
     exit;

  // Diferenciamos el Actual Cost Reajustado del Actual Cost MC ya que
  // Para el calculo del Book Value necesito el valor MC pero sin los reajustes
  // NO INDEXADOS ....
  // Por Otra parte el Actual cost que devuelve debe ser el reajustado ya sea por
  // NO INDEXADO COMO POR INDEXADO
  // Llama a la funcion reajuste con la misma fecha ya que asi reajusta y convierte
  // a la vez (OJO NO NOS INTERESAN LOS VALORES fReajuste_Index_Acumulado_Actual_Cost_Anterior
  // ni fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior

     fDiferencia_tipo_cambio_a_Cpa := 0;
     // Ojo: Se necesita el actual cost reajustado aun cuando se este trabajando con reajuste por capitalk residual
     Reajuste_Valor(sInstrumento
                   ,sMoneda_Instrumento
                   ,sMoneda_Informe
                   ,dFecha_Compra
                   ,dFecha_Compra
                   ,fActual_Cost_UM
                   ,dFecha_Compra
                   ,dFecha_Emision
                   ,RegDes
                   ,False             // bConCupon Se incorpora 05-07-2006
                   ,Array_Mem_Desarr
                   ,sCod_Indice_Reajuste
                   ,fReajuste_Index_Acumulado_Actual_Cost_Anterior
                   ,fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior_UM
                   ,fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior
                   ,fActual_Cost_MC_Reajustado_a_Cpa
                   ,fDiferencia_tipo_cambio_a_Cpa
                   ,sModulo_Err
                   ,sString_Err
                   ,Result                                   );

     if NOT Result Then
        exit;



  if (sTipo_Reajuste_en_Book_Value = 'Reajustes_Sobre_Capital_Residual') then
  begin
    fActual_Cost_UM_Reajustado_a_Cpa := fActual_Cost_UM +
                                        fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM_Cpa;

    conversion_unidad_mon(sMoneda_Instrumento
                         ,sMoneda_Informe
                         ,'BC'
                         ,dFecha_Compra // Ojo estaba ma la fecha dFecha_Calculo 23-08-2006 CJ & FI
                         ,fActual_Cost_UM_Reajustado_a_Cpa
                         ,fActual_Cost_MC_Reajustado_a_Cpa
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);
    if NOT Result then
       exit;
  end
  else
  begin
     fActual_Cost_UM_Reajustado_a_Cpa := fActual_Cost_UM +
                                         fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior_UM;
  end;

  // Este reajuste sigue siendo el del Actual Cost
  // ya que se usa en el programa para determinar el reajuste de
  // la diferencia de precio a la compra
  fReajuste_a_la_Cpa := fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior +
                        fReajuste_Index_Acumulado_Actual_Cost_Anterior;

  // Reajuste de Actual Cost Residual
  if NOT Leer_Tipo_Instrumento_Mem( sInstrumento
                                   ,sTipo_Instrumento_RVRF) then
     begin
       sString_Err := 'Error en definición de tipo de instrumento ('
                     +sInstrumento
                     +')';
       exit;
     end;

  if sTipo_Instrumento_RVRF = 'RV' then
     begin
       fReajuste_Index_Acumulado_Actual_Cost_Actual   := 0;
       fReajuste_NoIndex_Acumulado_Actual_Cost_Actual := 0;
       fRea_Acumulado_Actual_Cost_Anterior := 0;
       fRea_Acumulado_Actual_Cost_Actual   := 0;
       fReajuste_Actual_Cost_Periodo       := 0;
       fReajuste_Actual_Cost_Total         := 0;
     end
  else
     begin
       // Uso valor Compra Clean ya que es el Actual_Cost a la compra
       fActual_Cost_Residual_UM := fActual_Cost_UM  +
                                   (fMonto_Capitalizado_UM) -
                                   fMonto_Amort_Actual_Cost_A_CPA_UM;
//                                   (fMonto_Amort_UM * fProporcion_ActualCost_SalInsol);
       conversion_unidad_mon(sMoneda_Instrumento
                            ,sMoneda_Informe
                            ,'BC'
                            ,dFecha_Calculo
                            ,fActual_Cost_Residual_UM
                            ,fActual_Cost_Residual_MC_SinRea
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
          exit;

       // Valores Necesarios para Reajuste_No_Indexado
       Registro_Fechas.Fecha_Emision := dFecha_Emision;
       Registro_Fechas.Fecha_Compra  := dFecha_Compra;
       Registro_Fechas.Fecha_Calculo := dFecha_Calculo;

       Cupon_Vigente(Array_Mem_Desarr
                    ,RegDes
                    ,dFecha_Calculo
                    ,False
                    ,iCupon_Vigente
                    ,sModulo_Err
                    ,sString_Err
                    ,Result);

       if NOT Result then
          exit;

       if iCupon_Vigente = 1 then
          Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
       else
          Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto;
       Registro_Fechas.Fecha_Vcto_Periodo := dFecha_Calculo;

       // Reajustes para el Actual Cost
       // Ojo que tienen la separacion que puede ser el reajuste del capital residual
       // pero se le suma al actual cost

       fDiferencia_tipo_cambio_a_Cpa := 0;
       Reajuste_Valor(sInstrumento      //aqui
                     ,sMoneda_Instrumento
                     ,sMoneda_Informe
                     ,dFecha_Compra
                     ,dFecha_Calculo
                     ,fActual_Cost_Residual_UM
                     ,dFecha_Compra
                     ,dFecha_Emision
                     ,RegDes
                     ,False             // bConCupon Se incorpora 05-07-2006
                     ,Array_Mem_Desarr
                     ,sCod_Indice_Reajuste
                     ,fReajuste_Index_Acumulado_Actual_Cost_Actual
                     ,fReajuste_NoIndex_Acumulado_Actual_Cost_Actual_UM
                     ,fReajuste_NoIndex_Acumulado_Actual_Cost_Actual
                     ,fActual_Cost_Residual_MC
                     ,fDiferencia_tipo_cambio_a_Cpa
                     ,sModulo_Err
                     ,sString_Err
                     ,Result);

       if NOT Result Then
          exit;

       // Nuevo 26-10-2006 (F.I.)
       Aux_Fecha_Cierre_Ant := dFecha_Cierre_Anterior;
       if dFecha_Compra > dFecha_Cierre_Anterior then
          Aux_Fecha_Cierre_Ant := dFecha_Compra;

       if (sTipo_Reajuste_en_Book_Value = 'Reajustes_Sobre_Capital_Residual') then
       begin
         Saldo_Insoluto(sTipoInstrumento
                       ,RegDes
                       ,dFecha_Emision
                       ,dFecha_Calculo
                       ,dFecha_Compra  //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                       ,fNominales_Vigentes
                       ,Array_Mem_Desarr
                       ,False
                       ,fSaldo_Insoluto_Act_SinRea
                       ,fSaldo_Insoluto_Act_ConRea
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

         if NOT Result then
            exit;

         // Reajuste acumulado al Cierre anterior (Capital Residual)
         // Ojo se hace con Capital residual actual
         Reajuste_Valor(sInstrumento
                       ,sMoneda_Instrumento
                       ,sMoneda_Informe
                       ,dFecha_Compra
                       ,Aux_Fecha_Cierre_Ant  //dFecha_Cierre_Anterior
                       ,fSaldo_Insoluto_Act_SinRea   // Es el Actual !!! Esta bien !!!
                       ,dFecha_Compra
                       ,dFecha_Emision
                       ,RegDes
                       ,False             // bConCupon Se incorpora 05-07-2006
                       ,Array_Mem_Desarr
                       ,sCod_Indice_Reajuste
                       ,fReajuste_Index_Acumulado_Saldo_Insoluto_Ant
                       ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM_Ant
                       ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto_Ant
                       ,fSaldo_Insoluto_Ant_ConRea
                       ,fDiferencia_tipo_cambio_Saldo_Insoluto_Ant
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

         if NOT Result Then
            exit;

          Reajuste_Valor(sInstrumento
                        ,sMoneda_Instrumento
                        ,sMoneda_Informe
                        ,dFecha_Compra
                        ,dFecha_Calculo
                        ,fSaldo_Insoluto_Act_SinRea
                        ,dFecha_Compra
                        ,dFecha_Emision
                        ,RegDes
                        ,False             // bConCupon Se incorpora 05-07-2006
                        ,Array_Mem_Desarr
                        ,sCod_Indice_Reajuste
                        ,fReajuste_Index_Acumulado_Saldo_Insoluto
                        ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM
                        ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto
                        ,Aux_Float //fSaldo_Insoluto_Act
                        ,fDiferencia_tipo_cambio_Saldo_Insoluto
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);


          if NOT Result Then
             exit;

          // 16-04-2020 Nuevo para devolverlo en la llamada del Book Value
          fRea_Capital_Residual_RF     := fReajuste_Index_Acumulado_Saldo_Insoluto +
                                          fReajuste_NoIndex_Acumulado_Saldo_Insoluto;
          fExra_en_Capital_Residual_RF := fDiferencia_tipo_cambio_Saldo_Insoluto;

         // El exra del capital residual esta incluyendo el exra de las capitalizaciones
          // desde antes que se hicieran efectivas, por lo cual hay que restarlo.
          // DC & FI 22-11-2024
          fExra_en_Capital_Residual_RF := fExra_en_Capital_Residual_RF -
                                          fDiferencia_TC_Capit_Cupon +
                                          fDiferencia_TC_Amort_Cupon_Pagado;

          fActual_Cost_Residual_UM := fActual_Cost_Residual_UM +
                                      (//fReajuste_Index_Acumulado_Saldo_Insoluto +
                                       fReajuste_NoIndex_Acumulado_Saldo_Insoluto
                                       );

          fRea_Acumulado_Actual_Cost_Anterior := (fReajuste_Index_Acumulado_Saldo_Insoluto_Ant +
                                                  fReajuste_NoIndex_Acumulado_Saldo_Insoluto_Ant);

          fRea_Acumulado_Actual_Cost_Actual   := (fReajuste_Index_Acumulado_Saldo_Insoluto +
                                                  fReajuste_NoIndex_Acumulado_Saldo_Insoluto);

          fReajuste_Actual_Cost_Periodo :=  fRea_Acumulado_Actual_Cost_Actual -
                                            fRea_Acumulado_Actual_Cost_Anterior +
                                            fDiferencia_tipo_cambio_Saldo_Insoluto -
                                            fDiferencia_tipo_cambio_Saldo_Insoluto_ant;

          fReajuste_Actual_Cost_Total   :=  fRea_Acumulado_Actual_Cost_Actual;
       end
       else // Reajustes sobre Valor de Actual Cost
       begin
             begin
                 // Actual cost reajuste acumulado al Cierre anterior
                Reajuste_Valor(sInstrumento
                              ,sMoneda_Instrumento
                              ,sMoneda_Informe
                              ,dFecha_Compra
                              ,Aux_Fecha_Cierre_Ant //dFecha_Cierre_Anterior
                              ,fActual_Cost_Residual_UM
                              ,dFecha_Compra
                              ,dFecha_Emision
                              ,RegDes
                              ,False             // bConCupon Se incorpora 05-07-2006
                              ,Array_Mem_Desarr
                              ,sCod_Indice_Reajuste
                              ,fReajuste_Index_Acumulado_Actual_Cost_Anterior
                              ,fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior_UM
                              ,fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior
                              ,fActual_Cost_Residual_MC
                              ,fDiferencia_tipo_cambio_a_Cpa_Ant
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);

                if NOT Result Then
                   exit;
             end;

          fActual_Cost_Residual_UM := fActual_Cost_Residual_UM +
                                      fReajuste_NoIndex_Acumulado_Actual_Cost_Actual_UM;

          // diferencia de los reajustes acumulados corresponde al reajuste del periodo
          fRea_Acumulado_Actual_Cost_Anterior := (fReajuste_Index_Acumulado_Actual_Cost_Anterior +
                                                  fReajuste_NoIndex_Acumulado_Actual_Cost_Anterior);

          fRea_Acumulado_Actual_Cost_Actual   := (fReajuste_Index_Acumulado_Actual_Cost_Actual +
                                                  fReajuste_NoIndex_Acumulado_Actual_Cost_Actual);

          fReajuste_Actual_Cost_Periodo :=  fRea_Acumulado_Actual_Cost_Actual -
                                            fRea_Acumulado_Actual_Cost_Anterior +
                                            fDiferencia_tipo_cambio_a_Cpa -
                                            fDiferencia_tipo_cambio_a_Cpa_Ant;

          fReajuste_Actual_Cost_Total   :=  fReajuste_Index_Acumulado_Actual_Cost_Actual +
                                            fReajuste_NoIndex_Acumulado_Actual_Cost_Actual;
       end;

     end; // Fin reajuste Renta Fija ....
///////////////////////////////////////////

     if  Aux_bBook_Value_es_Valor_Presente  and
         (  Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente OR
            (Not RegDes.Variacion_Cambiaria and RegDes.bSin_Tasa_en_Flujos)
          )  Then
     begin
         //ggarcia 04-03-2019
         if sTipo_Amortizacion_IncDec = 'CURVA-NASB' then
         begin
            bAnula_Devengamiento_INCDEC_Ant := bAnula_Devengamiento_INCDEC;
            bAnula_Devengamiento_INCDEC     := False;
         end;
         IncDec_por_Diferencia_Curvas( sTipoInstrumento
                                      ,RegDes
                                      ,dFecha_Emision
                                      ,dFecha_Vencimiento
                                      ,dFecha_Calculo
                                      ,dFecha_Compra
                                      ,fNominales_Vigentes
                                      //,Array_Mem_Desarr
                                      ,fSaldo_Insoluto_Cpa
                                      ,fActual_Cost_UM
                                      ,fTasa_Calculo
                                      ,fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM
                                      ,fReajuste_NoIndex_Acumulado_Actual_Cost_Actual_UM
                                      ,Reg_Val_In
                                      ,Reg_Val_Out
                                      ,fIncrease_Decrease_Total
                                      ,fIncrease_Decrease_To_Maturity_Cpa
                                      ,fIncrease_Decrease_To_Maturity_Act
                                      ,sModulo_Err
                                      ,sString_Err
                                      ,Result);
         //ggarcia 04-03-2019
         if sTipo_Amortizacion_IncDec = 'CURVA-NASB' then
            bAnula_Devengamiento_INCDEC := bAnula_Devengamiento_INCDEC_Ant;
     end; // Fin Curvas Sucias

  // Para el caso de Existir Reajuste NO Indexado (Variación Cambiaria)
  // Se debe reajustar el Increase Decrease Total
  fDiferencia_tipo_cambio_Inc_Dec_Total := 0;
  fIncrease_Decrease_Total_SinRea       := fIncrease_Decrease_Total;

  // En el caso de indices se debe llevar a la moneda de paridad a fecha de compra
  // y luego a la moneda de conversion a la fecha de calculo  F.I. 15-09-2006
  if (sMoneda_Instrumento <> sMoneda_Informe) then
  begin
     if (sTipo_Moneda = 'I')  then
     begin
        Conversion_unidad_mon(sMoneda_Instrumento
                             ,sMoneda_Paridad
                             ,'BC'
                             ,dFecha_Compra
                             ,fIncrease_Decrease_Total_SinRea
                             ,fIncrease_Decrease_Total_SinRea
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

        if NOT Result then
           exit;

        Conversion_unidad_mon(sMoneda_Paridad
                             ,sMoneda_Informe
                             ,'BC'
                             ,dFecha_Calculo
                             ,fIncrease_Decrease_Total_SinRea
                             ,fIncrease_Decrease_Total_SinRea
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
     end
     else
        Conversion_unidad_mon(sMoneda_Instrumento
                             ,sMoneda_Informe
                             ,'BC'
                             ,dFecha_Calculo
                             ,fIncrease_Decrease_Total_SinRea
                             ,fIncrease_Decrease_Total_SinRea
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

     if NOT Result then
        exit;
  end;

  // Cuando se realiza el calculo a valor presente para flujos conocidos
  // no se debe reajustar el fIncrease_Decrease_Total
  if  NOT (Aux_bBook_Value_es_Valor_Presente  and
           (  Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente OR
              (Not RegDes.Variacion_Cambiaria and RegDes.bSin_Tasa_en_Flujos)
            )
           )
          or NOT (sTipo_Reajuste_en_Book_Value = 'Reajustes_Sobre_Capital_Residual') Then
  begin
     Reajuste_Valor(sInstrumento
                   ,sMoneda_Instrumento
                   ,sMoneda_Informe
                   ,dFecha_Compra
                   ,dFecha_Calculo
                   ,fIncrease_Decrease_Total
                   ,dFecha_Compra
                   ,dFecha_Emision
                   ,RegDes
                   ,False             // bConCupon Se incorpora 05-07-2006
                   ,Array_Mem_Desarr
                   ,sCod_Indice_Reajuste
                   ,fReajuste_Indexado_Inc_Dec_Total
                   ,fReajuste_No_Indexado_Inc_Dec_Total_UM
                   ,fReajuste_No_Indexado_Inc_Dec_Total
                   ,fIncrease_Decrease_Total     // Esta Reajustado y es MC
                   ,fDiferencia_tipo_cambio_Inc_Dec_Total
                   ,sModulo_Err
                   ,sString_Err
                   ,Result                                   );

     if NOT Result Then
        exit;
  End
  else
  begin
     if sTipo_Moneda <> 'I' then
     begin
      // Se agrega esta conversion a la fecha de compra para el calculo de la diferencia de TC  F.I. 16-04-2012
      Conversion_unidad_mon(sMoneda_Instrumento
                           ,sMoneda_Informe
                           ,'BC'
                           ,dFecha_Compra
                           ,fIncrease_Decrease_Total
                           ,fDiferencia_tipo_cambio_Inc_Dec_Total
                           ,sModulo_Err
                           ,sString_Err
                           ,Result);
      if NOT Result then
         exit;
      end;

      Conversion_unidad_mon(sMoneda_Instrumento
                           ,sMoneda_Informe
                           ,'BC'
                           ,dFecha_Calculo
                           ,fIncrease_Decrease_Total
                           ,fIncrease_Decrease_Total
                           ,sModulo_Err
                           ,sString_Err
                           ,Result);

      if NOT Result then
         exit;

     if sTipo_Moneda <> 'I' then
      fDiferencia_tipo_cambio_Inc_Dec_Total := fIncrease_Decrease_Total -               // Valor al TC de Cierre
                                               fDiferencia_tipo_cambio_Inc_Dec_Total;   // Valor al TC de Compra
  end;

  fReajuste_Indexado_Inc_Dec_To_Maturity         := 0;
  fReajuste_No_Indexado_Inc_Dec_To_Maturity_UM   := 0;
  fReajuste_No_Indexado_Inc_Dec_To_Maturity      := 0;
  fDiferencia_tipo_cambio_Inc_Dec_To_Maturity    := 0;
  fIncrease_Decrease_To_Maturity_Act_SinRea      := fIncrease_Decrease_To_Maturity_Act;
  if NOT ( Aux_bBook_Value_es_Valor_Presente  and
            (  Aux_Considera_Indexados_para_Book_Value_es_Valor_Presente OR
               (Not RegDes.Variacion_Cambiaria and RegDes.bSin_Tasa_en_Flujos)
            )
         )
     or NOT (sTipo_Reajuste_en_Book_Value = 'Reajustes_Sobre_Capital_Residual') Then
  begin
     Reajuste_Valor(sInstrumento
                   ,sMoneda_Instrumento
                   ,sMoneda_Informe
                   ,dFecha_Compra         // dFecha_Cierre_Anterior Cambiado el 06-06-2012 F.I.
                   ,dFecha_Calculo
                   ,fIncrease_Decrease_To_Maturity_Act
                   ,dFecha_Compra
                   ,dFecha_Emision
                   ,RegDes
                   ,False             // bConCupon Se incorpora 05-07-2006
                   ,Array_Mem_Desarr
                   ,sCod_Indice_Reajuste
                   ,fReajuste_Indexado_Inc_Dec_To_Maturity
                   ,fReajuste_No_Indexado_Inc_Dec_To_Maturity_UM
                   ,fReajuste_No_Indexado_Inc_Dec_To_Maturity
                   ,fIncrease_Decrease_To_Maturity_Act     // Esta Reajustado y es MC
                   ,fDiferencia_tipo_cambio_Inc_Dec_To_Maturity
                   ,sModulo_Err
                   ,sString_Err
                   ,Result                                   );

     if NOT Result Then
        exit;

  End
  else
  begin
     if sTipo_Moneda <> 'I' then
     begin
      // Se agrega esta conversion a la fecha de compra para el calculo de la diferencia de TC  F.I. 16-04-2012
      Conversion_unidad_mon(sMoneda_Instrumento
                           ,sMoneda_Informe
                           ,'BC'
                           ,dFecha_Compra
                           ,fIncrease_Decrease_To_Maturity_Act
                           ,fDiferencia_tipo_cambio_Inc_Dec_To_Maturity // La uso como variable de paso 16-04-2012 F.I.
                           ,sModulo_Err
                           ,sString_Err
                           ,Result);

      if NOT Result then
         exit;
     end;

     Conversion_unidad_mon(sMoneda_Instrumento
                          ,sMoneda_Informe
                          ,'BC'
                          ,dFecha_Calculo
                          ,fIncrease_Decrease_To_Maturity_Act
                          ,fIncrease_Decrease_To_Maturity_Act
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

     if NOT Result then
        exit;

     if sTipo_Moneda <> 'I' then
        fDiferencia_tipo_cambio_Inc_Dec_To_Maturity := fIncrease_Decrease_To_Maturity_Act -          // Valor al TC de Cierre
                                                       fDiferencia_tipo_cambio_Inc_Dec_To_Maturity;  // Valor al TC de Compra
  end;

  // En el caso de indices se debe llevar a la moneda de paridad a fecha de compra
  // y luego a la moneda de conversion a la fecha de calculo  F.I. 15-09-2006
  if (sMoneda_Instrumento <> sMoneda_Informe) then
  begin
     if sTipo_Moneda = 'I' then
     begin
        Conversion_unidad_mon(sMoneda_Instrumento
                             ,sMoneda_Paridad
                             ,'BC'
                             ,dFecha_Compra
                             ,fIncrease_Decrease_To_Maturity_Act_SinRea
                             ,fIncrease_Decrease_To_Maturity_Act_SinRea
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

        if NOT Result then
           exit;

        Conversion_unidad_mon(sMoneda_Paridad
                             ,sMoneda_Informe
                             ,'BC'
                             ,dFecha_Calculo
                             ,fIncrease_Decrease_To_Maturity_Act_SinRea
                             ,fIncrease_Decrease_To_Maturity_Act_SinRea
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

     end
     else
        Conversion_unidad_mon(sMoneda_Instrumento
                             ,sMoneda_Informe
                             ,'BC'
                             ,dFecha_Calculo
                             ,fIncrease_Decrease_To_Maturity_Act_SinRea
                             ,fIncrease_Decrease_To_Maturity_Act_SinRea
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

     if NOT Result then
        exit;
  end;

  if sTipo_Instrumento_RVRF = 'RV' then
  Begin
     Reg_Val_In.Tipo_Instrumento   := sTipoInstrumento;
     Reg_Val_In.sEmisor            := sEmisor;
     Reg_Val_In.sInstrumento       := sInstrumento;
     Reg_Val_In.sSerie             := sSerie;
     Reg_Val_In.Nemotecnico        := sNemotecnico;
     Reg_Val_In.dTasaEmision       := fTasa_Emision;
     Reg_Val_In.sUnidadMonetaria   := sMoneda_Instrumento;
     Reg_Val_In.sTipoNominales     := sTipo_Nominales;
     Reg_Val_In.dFechaEmision      := dFecha_Emision;
     Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
     Reg_Val_In.dFechaCalculo      := dFecha_Calculo;       // Fecha de Calculo
     Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
     Reg_Val_In.dFechaPago         := dFecha_Pago;
     Reg_Val_In.sMoneda_Conversion := sMoneda_Informe;
     Reg_Val_In.Con_Cupon          := True;                // sin Cupon
     Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
     Reg_Val_Out.Nominales         := fNominales_Vigentes;
     //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
     Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
     Reg_Val_Out.RegDes            := RegDes;
     Reg_Val_Out.TasaCalculo       := fTasa_Calculo;
     Reg_Val_In.dFechaCompra       := dFecha_Compra;
//     Reg_Val_In.dFechaOperacion    := dFecha_Operacion;
     Reg_Val_In.Tabla_Desarr_Cargada := sTabla_Desarr_Cargada;
     Valoriza_Registro(Reg_Val_In,
                       Reg_Val_Out,
                       sModulo_Err,
                       sString_Err,
                       Result);
     if NOT Result then
        exit;

     fBook_Value_MC := Reg_Val_Out.Valor_Par_MC ;
// cjf Hablado con fernando....como es un instruemnto RV manejado como RF el actual cost residual es = al Actual cost.
     fActual_Cost_Residual_UM := fActual_Cost_UM;
     fActual_Cost_Residual_MC := fActual_Cost_MC_Reajustado_a_Cpa;
  end
  else
  begin
    fExra_en_Actual_Cost_RF := 0;
    fExra_en_Book_Value_RF  := 0;

    // Nuevo Book Value Sin Reajustes de la parte Actual Cost

    // 30/07/2013
    // D.Q. & F.I. -->  La diferencia de tipo de cambio se calcula sobre
    //                  el actual cost residual independientemente de si
    //                  los reajustes se aplican sobre el capital residual
    //                  o se aplican sobre el actual cost

    if (sTipo_Reajuste_en_Book_Value = 'Reajustes_Sobre_Capital_Residual') then
    begin
       fBook_Value_MC := fActual_Cost_MC +
                         fDiferencia_tipo_cambio_a_Cpa +
                         fReajuste_Indexado_Amort_a_la_CPA +
                         fReajuste_No_Indexado_Amort_a_la_CPA +
                         fDiferencia_TC_Amort_Cupon +
                         fMonto_Capitalizado_MC -
                         fDiferencia_TC_Capit_Cupon -
                         fDiferencia_tipo_cambio_Inc_Dec_Pagado +
                         fIncrease_Decrease_Total_SinRea -  // Es sin Reajuste <> al estandar
                         fMonto_Amort_a_la_CPA_MC;

       // Cambio del 12-05-2005 Se suma el reajuste del capital residual
       fBook_Value_MC := fBook_Value_MC +
                         fReajuste_Index_Acumulado_Saldo_Insoluto +
                         fReajuste_NoIndex_Acumulado_Saldo_Insoluto;

        // 09-04-2020 Se estaba usando aun la diferencia por TC sobre capital Residual (Se corrige)
        //       fExra_en_Book_Value_RF := fDiferencia_tipo_cambio_a_Cpa +    // Esta es del actual cost residual
        //                                 fDiferencia_TC_Amort_Cupon +
        //                                 fDiferencia_TC_Capit_Cupon;


       fExra_en_Book_Value_RF := fDiferencia_tipo_cambio_a_Cpa +
                                 fDiferencia_TC_Amort_Cupon -
                                 fDiferencia_tipo_cambio_Inc_Dec_Pagado -
                                 fDiferencia_TC_Capit_Cupon;


       // Requiero separar el EXRA del Actual cost para poder cuadrar el analitico de inversiones
       // en la pestaña de ActualCost
//       fExra_en_Actual_Cost_RF := fDiferencia_tipo_cambio_a_Cpa +
//                                  fDiferencia_TC_Amort_Cupon -
//                                  fDiferencia_TC_Capit_Cupon;

       // D.C. & F.I. 28/11/2024
       fExra_en_Actual_Cost_RF := fDiferencia_tipo_cambio_a_Cpa +
                                  fDiferencia_TC_Actual_Cost_A_CPA -  // Esta es la DT de las amortizacionesd de actual cost
                                  fDiferencia_TC_Capit_Cupon;

       fActual_Cost_Residual_MC :=
                          fActual_Cost_MC +
                          fDiferencia_tipo_cambio_a_Cpa    -  // 31-07-2013
                          fDiferencia_TC_Capit_Cupon       +
                          fDiferencia_TC_Actual_Cost_A_CPA +
                          fReajuste_Indexado_Actual_Cost_A_CPA    +  // Reajuste de Amortizaciones !!!
                          fReajuste_No_Indexado_Actual_Cost_A_CPA +  // Reajuste de Amortizaciones !!!

                          (fMonto_Capitalizado_MC)+
                          (fReajuste_Indexado_Capitalizado) -
                          (fMonto_Amort_Actual_Cost_A_CPA_MC);

       fActual_Cost_Residual_MC :=  fActual_Cost_Residual_MC +
                                    fReajuste_Index_Acumulado_Saldo_Insoluto +
                                    fReajuste_NoIndex_Acumulado_Saldo_Insoluto;
//                                    fReajuste_Index_Acumulado_Actual_Cost_Actual +
//                                    fReajuste_NoIndex_Acumulado_Actual_Cost_Actual;
    end
    else // Book Value estandar
    begin
       fBook_Value_MC := fActual_Cost_MC +
                         fReajuste_Index_Acumulado_Actual_Cost_Actual +
                         fReajuste_NoIndex_Acumulado_Actual_Cost_Actual +
                         fDiferencia_tipo_cambio_a_Cpa +
                         fDiferencia_TC_Actual_Cost_A_CPA +  // Esta es la Dif de TC para las amortizaciones de Actual Cost
                         (fReajuste_Indexado_Actual_Cost_A_CPA)+
                         (fReajuste_No_Indexado_Actual_Cost_A_CPA) -
                         fAmortizacion_Inc_Dec_Pagada +
                         fMonto_Capitalizado_MC -
                         fDiferencia_TC_Capit_Cupon +
                         fIncrease_Decrease_Total -
                         fMonto_Amort_Actual_Cost_A_CPA_MC;

       fExra_en_Actual_Cost_RF := fDiferencia_tipo_cambio_a_Cpa +
                                  fDiferencia_TC_Actual_Cost_A_CPA +
                                  fDiferencia_TC_Capit_Cupon;

       fExra_en_Book_Value_RF := fDiferencia_tipo_cambio_a_Cpa +
                                 fDiferencia_TC_Actual_Cost_A_CPA +
                                 fDiferencia_TC_Capit_Cupon;

      fActual_Cost_Residual_MC :=
                         fActual_Cost_MC +
                         fReajuste_Index_Acumulado_Actual_Cost_Actual +
                         fReajuste_NoIndex_Acumulado_Actual_Cost_Actual +
                         fDiferencia_tipo_cambio_a_Cpa +
                         fDiferencia_TC_Actual_Cost_A_CPA +
                         fReajuste_Indexado_Actual_Cost_A_CPA+
                         fReajuste_No_Indexado_Actual_Cost_A_CPA+
                         fMonto_Capitalizado_MC -
                         fDiferencia_TC_Capit_Cupon -
                         fMonto_Amort_Actual_Cost_A_CPA_MC;
    end;
  end;
 end;   // Obtiene_Book_Value
//==============================================================================
// A diferencia del procedimiento ultimo_vencimiento, esta version
// asume tabla de desarrollo y descriptor cargados.
//==============================================================================
procedure ultimo_vencimiento_new(dFecha_Emision     : TDateTime;
                                 dFecha            : TDateTime;
                                 var Array_Mem_Desarr  : TArray_Mem_Desarr;
                                 RegDes            : TReg_Descriptor;
                                 bConCupon         : Boolean;
                                 var iNro_Cupon    : Integer;
                                 var dFecUltVcto   : TDateTime;
                                 var sModulo_Err   : String;
                                 var sString_Err   : String;
                                 var Result        : Boolean);
var
  iCuponVigente               : Integer;
begin
  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha
               ,bConCupon
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  iCuponVigente := iCuponVigente - 1;

  if iCuponVigente = 0 then
     dFecUltVcto := dFecha_Emision
  else
  begin
    // Se devuelve hasta el ultimo cupon que no este marcado como cortado                    b
    { Se comenta con fecha 27-09-2006
      No tiene sentido ya que afecta el calculo de los intereses devengados
      Los intereses devengados luego del cupon cortado deven ser a partir de
      la fecha de ese cupon CJ&FI
    While (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado) do
    begin
      iCuponVigente := iCuponVigente - 1;
      if iCuponVigente = 0 then
         Break;
    end;
    }

    // Cuando compro antes del cupon cortado el vcto anterior debe ser antes esa fecha

    WHILE Array_Mem_Desarr[iCuponVigente].Fecha_Vcto > dFecha do
    begin
      iCuponVigente := iCuponVigente - 1;
      if iCuponVigente = 0 then
         Break;
    end;

    if (iCuponVigente = 0) then
       dFecUltVcto := dFecha_Emision
    else
       dFecUltVcto := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
  end;
  iNro_Cupon := iCuponVigente;
end;
//==============================================================================
// A diferencia del procedimiento ultimo_vencimiento_new eeste va a determinar
// desde cuando se comienza a devengar
//==============================================================================
procedure Fecha_Inicio_devengamiento  (dFecha_Emision     : TDateTime;
                                       dFecha             : TDateTime;
                                       var Array_Mem_Desarr  : TArray_Mem_Desarr;
                                       iCuponVigente      : Integer;
                                       var dInicioDevenga : TDateTime);
var
   iCuponAnterior : Integer;

begin
   if iCuponVigente > 1 then
   begin
      iCuponAnterior := iCuponVigente - 1;
      while (Array_Mem_Desarr[iCuponAnterior+1].Cupon_Cortado) do
             iCuponAnterior := iCuponAnterior + 1;

      if iCuponAnterior >= 1 then
         dInicioDevenga := Array_Mem_Desarr[iCuponAnterior].Fecha_Vcto
      else
         dInicioDevenga := dFecha_Emision;
   end
   else
      dInicioDevenga := dFecha_Emision;
end;
//==============================================================================
{
procedure proximo_vencimiento(dFecha_Emision     : TDateTime;
                              dFecha            : TDateTime;
                              Array_Mem_Desarr  : TArray_Mem_Desarr;
                              RegDes            : TReg_Descriptor;
                              bConCupon         : Boolean;
                              var iNro_Cupon    : Integer;
                              var dFecUltVcto   : TDateTime;
                              var sModulo_Err   : String;
                              var sString_Err   : String;
                              var Result        : Boolean);
var
  iCuponVigente               : Integer;
begin
  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha
               ,bConCupon
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  dFecUltVcto := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
  iNro_Cupon := iCuponVigente;

end;
}
//==============================================================================
procedure Valores_Nominal_Invertido(sEmpresa        : String;
                                    sTransaccion    : String;
                                    sFolio          : String;
                                    fItem_omd       : Double;
                                    var fValor_Nominal : Double;
                                    var fValor_Invertido_MC : Double);
begin
  WITH DM_Rutinas_Informes.Qry_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Valor_Nominal');
    SQL.Add('      ,a.Valor_Invertido_MC');
    SQL.Add(' FROM QS_TRA_OMD_DET_RF a');
    SQL.Add(' WHERE a.Folio_Interno = :Folio');
    SQL.Add('   AND a.Transaccion   = :Transaccion');
    SQL.Add('   AND a.Item_Omd      = :Item');
    SQL.Add('   AND a.Empresa       = :Empresa');


     ParamByName('Empresa').AsString     := sEmpresa;
     ParamByName('Transaccion').AsString := sTransaccion;
     ParamByName('Folio').AsString       := sFolio;
     ParamByName('Item').AsFloat         := fItem_Omd;
     Open;

     if FieldByName('Valor_Nominal').IsNull then
        fValor_Nominal := 0
     else
        fValor_Nominal := FieldByName('Valor_Nominal').AsFloat;

     if FieldByName('Valor_Invertido_MC').IsNull then
        fValor_Invertido_MC := 0
     else
        fValor_Invertido_MC := FieldByName('Valor_Invertido_MC').AsFloat;
    Close;
  end;
end;//Determina Titulos Vendidos
//------------------------------------------------------------------------------
procedure Interes_Cormon(RegDes              : TReg_Descriptor;
                         Reg_Fechas          : TRegistro_Fechas;
                         dFecha_Original     : TDateTime;
                         dFecha_Desde        : TDateTime;
                         dFecha_Hasta        : TDateTime;
                         fTasa_Calculo       : Double;
                         Array_Mem_Desarr    : TArray_Mem_Desarr;
                         bSolo_Cupon_Vigente : Boolean;
                         fValor_Nominal      : Double;
                         fValor_Pagado       : Double;
                         Reg_Val_In          : TRegistro_Valoriza_In;
                         fNominales_Compra   : Double;
                         fInvertido_Compra   : Double;
                         var fInteres_UM     : Double;
                         var fInteres_MC     : Double;
                         var fInteres_Acum_GAAP_MC : Double;
                         var fCorMon         : Double;
                         var fValor_Original : Double;
                         var sString_Err     : String;
                         var sModulo_Err     : String;
                         var Result          : Boolean);
Var
   fPtje_Aplica_Reajuste : Double;
   sCodigo_MondInd       : String;
   s0Cod_Tratam_Inicio   : String;
   s1Cod_Tratam_Termino  : String;
   dFecha_Inicio_Tratamiento,
   dFecha_Termino_Tratamiento       : TDatetime;
   //fReajuste_Indexado               : Double;
   //fAjuste_Reajuste_Indexado        : Double;
   fRea_Acum_NO_Indexado_Anterior   : Double;
   fRea_Acum_NO_Indexado_Actual     : Double;
   fRea_NO_Indexado_Devengado       : Double;
   sPaga_Reajuste_Capital           : String;
   sNo_Considera_en_Interes              : String;
   sSolo_Aplica_en_Vctos                 : String;
   sNo_Considera_Negativos               : String;
begin
  fInteres_MC := 0;
  fCorMon  := 0;
  fValor_Original := 0;
  fRea_Acum_NO_Indexado_Anterior := 0;
  fRea_Acum_NO_Indexado_Actual   := 0;
  fRea_NO_Indexado_Devengado     := 0;

  Verifica_Excepcion_Variacion_Cambiaria(RegDes.Codigo_Emisor
                                        ,RegDes.Codigo_Instrumento
                                        ,RegDes.Serie
                                        ,0
                                        ,Reg_Fechas.Fecha_Calculo
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
  if Result then // Correccion Monetaria en Metodo por Variacion
     Interes_Cormon_VarCamb(RegDes
                           ,fTasa_Calculo
                           ,Reg_Fechas
                           ,dFecha_Original
                           ,dFecha_Desde
                           ,dFecha_Hasta
                           ,sCodigo_MondInd
                           ,fPtje_Aplica_Reajuste
                           ,Array_mem_Desarr
                           ,bSolo_Cupon_Vigente
                           ,fValor_Nominal
                           ,fValor_Pagado
                           ,fInteres_UM
                           ,fInteres_MC
                           ,fInteres_Acum_GAAP_MC
                           ,fCorMon
                           ,fValor_Original
                           ,sString_Err
                           ,sModulo_Err
                           ,Result)
  else
    begin
      Intereses_Acumulados(Reg_Val_In.Tipo_Instrumento
                          ,RegDes.Codigo_Emisor
                          ,RegDes.Codigo_Instrumento
                          ,RegDes.Serie
                          ,Reg_Val_In.Nemotecnico
                          ,Reg_Val_In.dTasaEmision
                          ,fTasa_Calculo
                          ,Reg_Val_In.sUnidadMonetaria
                          ,Reg_Val_In.sTipoNominales
                          ,Reg_Val_In.dFechaEmision
                          ,Reg_Val_In.dFechaVencimiento
                          ,Reg_Val_In.dFechaCompra
                          ,Reg_Val_In.dFechaOperacion
                          ,Reg_Val_In.dFechaPago
                          ,Reg_Val_In.sMoneda_Conversion
                          ,Reg_Val_In.fCupones_Cortados    // 05-04-2013  Edosan
                          ,fValor_Nominal
                          ,dFecha_Desde
                          ,dFecha_Hasta
                          ,Reg_Val_In.Descriptor_Cargado
                          ,Reg_Val_In.Tabla_Desarr_Cargada //'NO'
                          ,RegDes
                          ,Array_Mem_Desarr
                          ,fInteres_UM
                          ,fInteres_MC
                          ,fInteres_Acum_GAAP_MC
//                          ,fReajuste_Indexado
//                          ,fAjuste_Reajuste_Indexado
                          ,fRea_Acum_NO_Indexado_Anterior
                          ,fRea_Acum_NO_Indexado_Actual
                          ,fRea_NO_Indexado_Devengado
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

      if NOT Result then
         exit;

      fValor_Original := (fValor_Nominal * fInvertido_Compra) / fNominales_Compra;
    end;
end;
//------------------------------------------------------------------------------
procedure Interes_Cormon_VarCamb(RegDes                    : TReg_Descriptor;
                                 fTasa_Calculo             : Double;
                                 Reg_Fechas                : TRegistro_Fechas;
                                 dFecha_Original           : TDateTime;
                                 dFecha_Desde              : TDateTime;
                                 dFecha_Hasta              : TDateTime;
                                 sCodigo_MondInd_Variacion : String;
                                 fPtje_Aplica_Reajuste     : Double;
                                 Array_mem_Desarr          : TArray_Mem_Desarr;
                                 bSolo_Cupon_Vigente       : Boolean;
                                 fValor_Nominal            : Double;
                                 fValor_Pagado             : Double;
                                 var fInteres_UM           : Double;
                                 var fInteres_MC           : Double;
                                 var fInteres_Acum_GAAP_MC : Double;
                                 var fCorMon               : Double;
                                 var fValor_Original       : Double;
                                 var sString_Err           : String;
                                 var sModulo_Err           : String;
                                 var Result                : Boolean);
var
  fValor_Inicial_Cupon    : Double;
  fValor_Final_Cupon      : Double;
  fValor_Final_Cupon_CM   : Double;
  fValor_Variacion        : Double;
  fValor_Ind_Inicio       : Double;
  fValor_Ind_Termino      : Double;


  fValor_Inicial_UM       : Double;
  fValor_Final_UM         : Double;


begin
    Descuento_Flujos_Futuros(Array_Mem_Desarr
                            ,RegDes
                            ,fTasa_Calculo
                            ,dFecha_Original
                            ,RegDes.TASA_VALOR_PTE
                            ,False                 // bConCupon
                            ,False
                            ,bSolo_Cupon_Vigente
                            ,'S'                  // Toma valores originales sin Execepcion Variacion Cambiaria
                            ,''
                            ,fValor_Inicial_Cupon
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);

    if NOT Result then
       exit;

    Factor_Variacion(sCodigo_MondInd_Variacion
                    ,fPtje_Aplica_Reajuste
                    ,Reg_Fechas.Fecha_Emision
                    ,dFecha_Original
                    ,Reg_Fechas.Fecha_Calculo
                    ,fValor_Variacion
                    ,fValor_Ind_Inicio
                    ,fValor_Ind_Termino
                    ,sString_Err
                    ,sModulo_Err
                    ,Result);


    if NOT Result then
       exit;

    fValor_Original := fValor_Inicial_Cupon * fValor_Variacion;
    fValor_Original := fValor_Original * fValor_Nominal / RegDes.Base_Conversion;

    Descuento_Flujos_Futuros(Array_Mem_Desarr
                            ,RegDes
                            ,fTasa_Calculo
                            ,dFecha_Desde
                            ,RegDes.TASA_VALOR_PTE
                            ,False                 // bConCupon
                            ,False
                            ,bSolo_Cupon_Vigente
                            ,'S'                  // Toma valores originales sin Execepcion Variacion Cambiaria
                            ,''
                            ,fValor_Inicial_Cupon
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);

    if NOT Result then
       exit;

    fValor_Inicial_UM := fValor_Inicial_Cupon;

    Factor_Variacion(sCodigo_MondInd_Variacion
                    ,fPtje_Aplica_Reajuste
                    ,Reg_Fechas.Fecha_Emision
                    ,dFecha_Desde
                    ,Reg_Fechas.Fecha_Calculo
                    ,fValor_Variacion
                    ,fValor_Ind_Inicio
                    ,fValor_Ind_Termino
                    ,sString_Err
                    ,sModulo_Err
                    ,Result);

    if NOT Result then
       exit;

    fValor_Inicial_Cupon := fValor_Inicial_Cupon * fValor_Variacion;

    Descuento_Flujos_Futuros(Array_Mem_Desarr
                            ,RegDes
                            ,fTasa_Calculo
                            ,dFecha_Hasta
                            ,RegDes.TASA_VALOR_PTE
                            ,True                  // bConCupon
                            ,False
                            ,bSolo_Cupon_Vigente
                            ,'S'                  // Toma valores originales sin Execepcion Variacion Cambiaria
                            ,''
                            ,fValor_Final_Cupon
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);

    if NOT Result then
       exit;

    fValor_Final_UM := fValor_Final_Cupon;
    fValor_Final_Cupon := fValor_Final_Cupon * fValor_Variacion;


    fInteres_UM := fValor_Final_UM - fValor_Inicial_UM;
    fInteres_UM := fInteres_UM * fValor_Nominal / RegDes.Base_Conversion;

    fInteres_MC := fValor_Final_Cupon - fValor_Inicial_Cupon;
    fInteres_MC := fInteres_MC * fValor_Nominal / RegDes.Base_Conversion;

    // OJO Si como pararmetro me entregaron el Valor Pagado
    // es decir el precio de la venta o al vencimiento
    // EL CALCULO SE DEBE HACER POR LA DIFERENCIA A ESE VALOR


    // Calculo Variación Cambiaria en el período
    // Entre Fecha_Desde y Fecha_Hasta

    if fValor_Pagado = 0 then
       begin
          Factor_Variacion(sCodigo_MondInd_Variacion
                          ,fPtje_Aplica_Reajuste
                          ,dFecha_Desde
                          ,dFecha_Hasta
                          ,Reg_Fechas.Fecha_Calculo
                          ,fValor_Variacion
                          ,fValor_Ind_Inicio
                          ,fValor_Ind_Termino
                          ,sString_Err
                          ,sModulo_Err
                          ,Result);
          if NOT Result then
             exit;
          fValor_Final_Cupon_CM := fValor_Final_Cupon * fValor_Variacion;
          fValor_Final_Cupon_CM := fValor_Final_Cupon_CM * fValor_Nominal / RegDes.Base_Conversion;
       end
    else
          fValor_Final_Cupon_CM := fValor_Pagado;

    fValor_Inicial_Cupon := fValor_Inicial_Cupon * fValor_Nominal / RegDes.Base_Conversion;
    fCorMon              := fValor_Final_Cupon_CM - fValor_Inicial_Cupon - fInteres_MC;
end;
//------------------------------------------------------------------------------
procedure Interes_Cormon_Acum(sEmpresa            : String;
                              sTransaccion        : String;
                              sFolio_Interno      : String;
                              fItem_Omd           : Double;
                              RegDes              : TReg_Descriptor;
                              Reg_Fechas          : TRegistro_Fechas;
                              dFecha_Original     : TDateTime;
                              dFecha_Desde        : TDateTime;
                              dFecha_Hasta        : TDateTime;
                              fTasa_Calculo       : Double;
                              Array_Mem_Desarr    : TArray_Mem_Desarr;
                              bSolo_Cupon_Vigente : Boolean;
                              fValor_Nominal      : Double;
                              fValor_Pagado       : Double;
                              Reg_Val_In          : TRegistro_Valoriza_In;
                              fNominales_Compra   : Double;
                              fInvertido_Compra   : Double;
                              var fInteres_Acum   : Double;
                              var fCorMon_Acum    : Double;
                              var fValor_Original : Double;
                              var sString_Err     : String;
                              var sModulo_Err     : String;
                              var Result          : Boolean);
var
  Aux_Fecha_Desde : TDateTime;
  Aux_Fecha_Hasta : TDateTime;
  fInteres_UM     : Double;
  fInteres_MC     : Double;
  fInteres_Acum_GAAP_MC : Double;
  fCorMon         : Double;
  flag_Encontro   : Boolean;

  Aux_Secuencia_Desde : TDateTime;
begin
  fInteres_Acum := 0;
  fCorMon_Acum  := 0;
  flag_Encontro := False;

  Aux_Secuencia_Desde := dFecha_Desde;
  Aux_Fecha_Hasta := 0;

  // El objetivo es volver a calcular todos los intereses que se
  // han ido calculando en los distintos procesos
  // La idea es permitir un reverso exacto de los intereses devengados
  // e impútados en los procesos.

  WITH DM_Rutinas_Informes.Qry_General do
  begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT a.Fecha_Ini_Calculo');
    SQL.Add('               ,a.Fecha_Fin_Calculo');
    SQL.Add('  FROM QS_CON_ASIENTO a');
    SQL.Add(' WHERE a.Folio_Interno = :Folio_Interno');
    SQL.Add('   AND a.Transaccion   = :Transaccion');
    SQL.Add('   AND a.Item_Omd      = :Item_Omd');
    SQL.Add('   AND a.Empresa       = :Empresa');
    SQL.Add('   AND a.Fecha_Ini_Calculo >= :Fecha_Desde');
    SQL.Add('   AND a.Fecha_Ini_Calculo <  :Fecha_Hasta');
    SQL.Add('   AND a.Fecha_Ini_Calculo IS NOT NULL');
    SQL.Add('   AND a.Fecha_Fin_Calculo IS NOT NULL');
    SQL.Add(' ORDER BY a.Fecha_Ini_Calculo');

    ParamByName('Folio_Interno').AsString := sFolio_Interno;
    ParamByName('Transaccion').AsString   := sTransaccion;
    ParamByName('Item_Omd').AsFloat       := fItem_Omd;
    ParamByName('Empresa').AsString       := sEmpresa;
    ParamByName('Fecha_Desde').AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta').AsDateTime := dFecha_Hasta;
    Open;
    While NOT EOF do
      begin
        Flag_Encontro   := True;
        Aux_Fecha_Desde := FieldByName('Fecha_Ini_Calculo').AsDateTime;
        Aux_Fecha_Hasta := FieldByName('Fecha_Fin_Calculo').AsDateTime;

        // Si me faltan dias entre lo que encuentro en la tabla los calculo
        if Aux_Secuencia_Desde < Aux_Fecha_Desde then
           begin
             Interes_Cormon(RegDes
                           ,Reg_Fechas
                           ,dFecha_Original
                           ,Aux_Secuencia_Desde
                           ,Aux_Fecha_Desde
                           ,fTasa_Calculo
                           ,Array_Mem_Desarr
                           ,bSolo_Cupon_Vigente
                           ,fValor_Nominal
                           ,fValor_Pagado
                           ,Reg_Val_In
                           ,fNominales_Compra
                           ,fInvertido_Compra
                           ,fInteres_UM
                           ,fInteres_MC
                           ,fInteres_Acum_GAAP_MC
                           ,fCorMon
                           ,fValor_Original
                           ,sString_Err
                           ,sModulo_Err
                           ,Result);

             if NOT Result then
             begin
                Close;
                exit;
             end;

             fInteres_Acum := fInteres_Acum + fInteres_MC;
             fCorMon_Acum  := fCorMon_Acum  + fCorMon;
           end;

        Aux_Secuencia_Desde := Aux_Fecha_Hasta;

        Interes_Cormon(RegDes
                      ,Reg_Fechas
                      ,dFecha_Original
                      ,Aux_Fecha_Desde
                      ,Aux_Fecha_Hasta
                      ,fTasa_Calculo
                      ,Array_Mem_Desarr
                      ,bSolo_Cupon_Vigente
                      ,fValor_Nominal
                      ,fValor_Pagado
                      ,Reg_Val_In
                      ,fNominales_Compra
                      ,fInvertido_Compra
                      ,fInteres_UM
                      ,fInteres_MC
                      ,fInteres_Acum_GAAP_MC
                      ,fCorMon
                      ,fValor_Original
                      ,sString_Err
                      ,sModulo_Err
                      ,Result);

        if NOT Result then
        begin
           Close;
           exit;
        end;

        fInteres_Acum := fInteres_Acum + fInteres_MC;
        fCorMon_Acum  := fCorMon_Acum  + fCorMon;
        Next;
      end;
    Close;
  end;

  if NOT Flag_Encontro then
     begin
        // Si no encontro fechas calculadas calcula todo el periodo
        Interes_Cormon(RegDes
                      ,Reg_Fechas
                      ,dFecha_Original
                      ,dFecha_Desde
                      ,dFecha_Hasta
                      ,fTasa_Calculo
                      ,Array_Mem_Desarr
                      ,bSolo_Cupon_Vigente
                      ,fValor_Nominal
                      ,fValor_Pagado
                      ,Reg_Val_In
                      ,fNominales_Compra
                      ,fInvertido_Compra
                      ,fInteres_UM
                      ,fInteres_MC
                      ,fInteres_Acum_GAAP_MC
                      ,fCorMon
                      ,fValor_Original
                      ,sString_Err
                      ,sModulo_Err
                      ,Result);

        if NOT Result then
        begin
           exit;
        end;

        fInteres_Acum := fInteres_Acum + fInteres_MC;
        fCorMon_Acum  := fCorMon_Acum  + fCorMon;
     end
  else
     begin
       // Si no encontro fechas hasta la pedida calcula el periodo restante
       if Aux_Fecha_Hasta < dFecha_Hasta then
          begin
            Interes_Cormon(RegDes
                          ,Reg_Fechas
                          ,dFecha_Original
                          ,Aux_Fecha_Hasta
                          ,dFecha_Hasta
                          ,fTasa_Calculo
                          ,Array_Mem_Desarr
                          ,bSolo_Cupon_Vigente
                          ,fValor_Nominal
                          ,fValor_Pagado
                          ,Reg_Val_In
                          ,fNominales_Compra
                          ,fInvertido_Compra
                          ,fInteres_UM
                          ,fInteres_MC
                          ,fInteres_Acum_GAAP_MC
                          ,fCorMon
                          ,fValor_Original
                          ,sString_Err
                          ,sModulo_Err
                          ,Result);

            if NOT Result then
            begin
               exit;
            end;

            fInteres_Acum := fInteres_Acum + fInteres_MC;
            fCorMon_Acum  := fCorMon_Acum  + fCorMon;
          end;
     end;

end;
//==============================================================================
procedure Saldo_Insoluto(sTipo_Instrumento    : String;
                         RegDes               : TReg_Descriptor;
                         dFecha_Emision       : TDateTime;
                         dFecha_Saldo         : TDateTime;
                         dFecha_Compra        : TDateTime;   //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                         fValor_Nominal       : Double;
                         Array_Mem_Desarr     : TArray_Mem_Desarr;
                         bCon_Cupon           : Boolean;
                         var fSaldo_Insoluto_Sin_Reajuste  : Double;
                         var fSaldo_Insoluto               : Double;
                         var sModulo_Err                    : String;
                         var sString_Err                    : String;
                         var Result                        : Boolean);

var
  iCuponVigente : Integer;
  fReajuste               : Double;
  fFactor_Reajuste        : Double;
  Registro_Fechas         : TRegistro_Fechas;
begin
  Result := True;

  fSaldo_Insoluto_Sin_Reajuste  := 0;
  fSaldo_Insoluto               := 0;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Calculo := dFecha_Saldo;
  //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Saldo
               ,bCon_Cupon //False // Se agrego la variable el 24-06-2008 Para un caso unico hasta ahora que se requiere incluir el cupon el día del corte-
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  WHILE (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado) do
     Inc(iCuponVigente);

  if iCuponVigente = 1 then
     begin
         // Se hace cambio para que el saldo insoluto de los titulos unicos con nominales finales
         // sea equivalente a su valor par a la emisión
         // F.I. para GAAP 12-04-2007
         if (sTipo_Instrumento = 'U') and
            (RegDes.Tipo_nominales = 'F') then
         begin
            if (((Array_Mem_Desarr[1].Interes / 100) + 1) = 0) then
               fSaldo_Insoluto := fValor_Nominal
            else
               fSaldo_Insoluto := fValor_Nominal /((Array_Mem_Desarr[1].Interes / 100) + 1);

         end
         else
         begin
            fSaldo_Insoluto := (RegDes.Base_Original *
                                fValor_Nominal) /
                                RegDes.Base_Conversion;
         end;
     end
  else
     if RegDes.Base_Conversion = 0 then
        begin
          sString_Err := 'Base Conversión de Instrumento no puede ser igual a cero';
          sModulo_Err := 'Valuación';
          Result := False;
        end
     else
       begin
        // Ojo : se modifico la funcion para retornar tambien el saldo insoluto
        // No afectado por la variacion cambiaria (SIN REAJUSTE)
        // Para el caso comun es igual en ambos
        fSaldo_Insoluto := (Array_Mem_Desarr[iCuponVigente - 1].Saldo_Insoluto_Original *
                            fValor_Nominal) /
                            RegDes.Base_Conversion;

       end;


     fSaldo_Insoluto_Sin_Reajuste := fSaldo_Insoluto;
    {
    // Si se esta pidiendo el saldo indoluto a la fecha de emision
    // No se le debe agregar el reajuste.
    if dFecha_Saldo = dFecha_Emision then
       exit;
    }

  // Para el calculo del reajuste por la execpcion de variacion cambiaria
  // Se necesita que los datos de las fechas del cupon
  // consideren como vigente el cupon que si corta el mismo día
  //
  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Saldo
               ,True
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

    if iCuponVigente = 1 then
       Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
    else
       Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCuponVigente-1].Fecha_Vcto;

     Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;

//DC 21/11/2023
     Registro_Fechas.Fecha_Vencimiento := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
//DC 21/11/2023

     Reajuste_No_Indexado(RegDes.Codigo_Emisor
                   ,RegDes.Codigo_Instrumento
                   ,RegDes.Serie
                   ,dFecha_Saldo
                   ,Registro_fechas
                   ,iCuponVigente
                   ,fSaldo_Insoluto
                   ,fFactor_Reajuste
                   ,fReajuste
                   ,fSaldo_Insoluto
                   ,sModulo_Err
                   ,sString_Err
                   ,Result);

end;

procedure Saldo_Insoluto_Sin_Capitalizacion(sTipo_Instrumento    : String;
                         RegDes               : TReg_Descriptor;
                         dFecha_Emision       : Double;
                         dFecha_Saldo         : TDateTime;
                         fValor_Nominal       : Double;
                         Array_Mem_Desarr     : TArray_Mem_Desarr;
                         bCon_Cupon           : Boolean;
                         var fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste  : Double;
                         var fSaldo_Insoluto_Sin_Capitalizacion               : Double;
                         var sModulo_Err                    : String;
                         var sString_Err                    : String;
                         var Result                        : Boolean);

var
  iCuponVigente : Integer;
  fReajuste               : Double;
  fFactor_Reajuste        : Double;
  Registro_Fechas         : TRegistro_Fechas;
begin
  Result := True;

  fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste  := 0;
  fSaldo_Insoluto_Sin_Capitalizacion               := 0;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Calculo := dFecha_Saldo;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Saldo
               ,bCon_Cupon //False
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  WHILE (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado) do
     Inc(iCuponVigente);

  if iCuponVigente = 1 then
     begin
         fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste := (RegDes.Base_Original *
                                          fValor_Nominal) /
                                          RegDes.Base_Conversion;

         fSaldo_Insoluto_Sin_Capitalizacion := (RegDes.Base_Original *
                             fValor_Nominal) /
                             RegDes.Base_Conversion;
     end
  else
     if RegDes.Base_Conversion = 0 then
        begin
          sString_Err := 'Base Conversión de Instrumento no puede ser igual a cero';
          sModulo_Err := 'Valuación';
          Result := False;
        end
     else
       begin
        // Ojo : se modifico la funcion para retornar tambien el saldo insoluto
        // No afectado por la variacion cambiaria (SIN REAJUSTE)
        // Para el caso comun es igual en ambos

        fSaldo_Insoluto_Sin_Capitalizacion_Sin_Reajuste :=
                           (Array_Mem_Desarr[iCuponVigente - 1].Saldo_insoluto_Sin_Capitalizaciones *
                            fValor_Nominal) /
                            RegDes.Base_Conversion;

        fSaldo_Insoluto_Sin_Capitalizacion := (Array_Mem_Desarr[iCuponVigente - 1].Saldo_insoluto_Sin_Capitalizaciones *
                            fValor_Nominal) /
                            RegDes.Base_Conversion;

       end;

    {
    // Si se esta pidiendo el saldo indoluto a la fecha de emision
    // No se le debe agregar el reajuste.
    if dFecha_Saldo = dFecha_Emision then
       exit;
    }

    if iCuponVigente = 1 then
       Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
    else
       Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCuponVigente-1].Fecha_Vcto;



     Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
     Reajuste_No_Indexado(RegDes.Codigo_Emisor
                   ,RegDes.Codigo_Instrumento
                   ,RegDes.Serie
                   ,dFecha_Saldo
                   ,Registro_fechas
                   ,iCuponVigente
                   ,fSaldo_Insoluto_Sin_Capitalizacion
                   ,fFactor_Reajuste
                   ,fReajuste
                   ,fSaldo_Insoluto_Sin_Capitalizacion
                   ,sModulo_Err
                   ,sString_Err
                   ,Result);

     if NOT Result then
        exit;
end;



//==============================================================================
procedure Saldo_Insoluto_Segun_Compra( sTipo_Instrumento    : String;
                                       RegDes               : TReg_Descriptor;
                                       dFecha_Emision       : Double;
                                       dFecha_Saldo         : TDateTime;
                                       dFecha_Compra        : TDateTime;
                                       fValor_Nominal       : Double;
                                       Array_Mem_Desarr     : TArray_Mem_Desarr;
                                       bCon_Cupon           : Boolean;
                                       var fSaldo_Insoluto_SinRea     : Double;
                                       var fSaldo_Insoluto            : Double;
                                       var fCapt_Acum_Cpa_y_Calc_NAmt : Double;
                                       var sModulo_Err                : String;
                                       var sString_Err                : String;
                                       var Result                     : Boolean);
var
  iCuponVigente : Integer;
  fReajuste               : Double;
  fFactor_Reajuste        : Double;
  Registro_Fechas         : TRegistro_Fechas;

begin
  Result := True;

  // Capitalizado acumulado entre la compra y la fecha de calculo, no amortizado.
  fCapt_Acum_Cpa_y_Calc_NAmt := 0;
  fSaldo_Insoluto_SinRea     := 0;
  fSaldo_Insoluto            := 0;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Calculo := dFecha_Saldo;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Saldo
               ,bCon_Cupon //False // Se agrego la variable el 24-06-2008 Para un caso unico hasta ahora que se requiere incluir el cupon el día del corte-
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  WHILE (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado) do
     Inc(iCuponVigente);

  if iCuponVigente = 1 then
     begin
         if (sTipo_Instrumento = 'U') and
            (RegDes.Tipo_nominales = 'F') then
         begin
            if (((Array_Mem_Desarr[1].Interes / 100) + 1) = 0) then
               fSaldo_Insoluto := fValor_Nominal
            else
               fSaldo_Insoluto := fValor_Nominal /((Array_Mem_Desarr[1].Interes / 100) + 1);
         end
         else
            fSaldo_Insoluto := (RegDes.Base_Original *
                                fValor_Nominal) /
                                RegDes.Base_Conversion;
     end
  else
     if RegDes.Base_Conversion = 0 then
        begin
          sString_Err := 'Base Conversión de Instrumento no puede ser igual a cero';
          sModulo_Err := 'Valuación';
          Result := False;
        end
     else
     begin
        fSaldo_Insoluto := (Array_Mem_Desarr[iCuponVigente - 1].Saldo_Insoluto_Segun_Fecha_de_Compra *
                            fValor_Nominal) /
                            RegDes.Base_Conversion;

        fCapt_Acum_Cpa_y_Calc_NAmt := (Array_Mem_Desarr[iCuponVigente - 1].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado *
                                       fValor_Nominal) /
                                       RegDes.Base_Conversion;
     end;

  fSaldo_Insoluto_SinRea := fSaldo_Insoluto;

  // Para el calculo del reajuste por la execpcion de variacion cambiaria
  // Se necesita que los datos de las fechas del cupon
  // consideren como vigente el cupon que si corta el mismo día
  //
  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Saldo
               ,True
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

    if iCuponVigente = 1 then
       Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
    else
       Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCuponVigente-1].Fecha_Vcto;

     Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
     Reajuste_No_Indexado( RegDes.Codigo_Emisor
                          ,RegDes.Codigo_Instrumento
                          ,RegDes.Serie
                          ,dFecha_Saldo
                          ,Registro_fechas
                          ,iCuponVigente
                          ,fSaldo_Insoluto_SinRea
                          ,fFactor_Reajuste
                          ,fReajuste
                          ,fSaldo_Insoluto
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
end;
//==============================================================================
procedure Variacion_Porcentual(sTipo_Instrumento    : String;
                               sEmisor              : String;
                               sInstrumento         : String;
                               sSerie               : String;
                               sNemotecnico         : String;
                               fTasaEmision         : Double;
                               sUnidadMonetaria     : String;
                               sTipoNominales       : String;
                               dFecha_Emision        : TDateTime;
                               dFecha_Vencimiento    : TDateTime;
                               dFecha_Compra         : TDateTime;
                               sMoneda_Conversion   : String;
                               fNominales           : Double;
                               dFecha_Desde         : TDateTime;
                               dFecha_Hasta         : TDateTime;
                               sTabla_Desarr_Cargada: String;
                               sTipo_Valorizacion   : String;
                               fTasa_Calculo        : Double;
                               var RegDes           : TReg_Descriptor;
                               var Array_Mem_Desarr : TArray_Mem_Desarr;
                               var fFactor_Variacion_Desde : Double;
                               var fFactor_Variacion_Hasta : Double;
                               var fFactor_Variacion  : Double;
                               var fDecrease_Increase : Double;
                               var sModulo_Err        : String;
                               var sString_Err        : String;
                               var Result             : Boolean);

// La variación porcentual se calcula tomando la proporción entre el valor Presente
// o (producto de valución segun parametro) sobre el PAR
// Esto se hace a la fecha desde y a la fecha hasta y el resultado es el
var
   fValor_Par_MC_Desde     : Double;
   fValor_Val_MC_Desde     : Double;
   fValor_Par_MC_Hasta     : Double;
   fValor_Val_MC_Hasta     : Double;

   Reg_Val_In              : TRegistro_Valoriza_In;
   Reg_Val_Out             : TRegistro_Valoriza_Out;

begin
  // Obtengo valor PAR a fecha de desde
  Reg_Val_In.Tipo_Instrumento   := sTipo_Instrumento;
  Reg_Val_In.sEmisor            := sEmisor;
  Reg_Val_In.sInstrumento       := sInstrumento;
  Reg_Val_In.sSerie             := sSerie;
  Reg_Val_In.Nemotecnico        := sNemotecnico;
  Reg_Val_In.dTasaEmision       := fTasaEmision;
  Reg_Val_In.sUnidadMonetaria   := sUnidadMonetaria;
  Reg_Val_In.sTipoNominales     := sTipoNominales;
  Reg_Val_In.dFechaEmision      := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
  Reg_Val_In.dFechaCalculo      := dFecha_Desde;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
  Reg_Val_In.Con_Cupon          := False;                // sin Cupon
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
  Reg_Val_Out.Nominales         := fNominales;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes            := RegDes;

// OJO CON ESTA FUNCION LE FALTA LA FECHA DE PAGO
// (  Reg_Val_In.dFechaPago         := dFecha_Pago;)
// REVISARLA LO ANTES POSIBLE !!!!

  Reg_Val_In.Tabla_Desarr_Cargada := sTabla_Desarr_Cargada;

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  if NOT Result then
     exit;

  fValor_Par_MC_Desde := Reg_Val_Out.Valor_Par_MC    ;
  Array_Mem_Desarr    := Reg_Val_Out.Array_Mem_Desarr;
  RegDes              := Reg_Val_Out.RegDes          ;

  // Obtengo valor PTE o Valuación (segun Parametro) a fecha desde
  if sTipo_Valorizacion = 'VAL' then
     Reg_Val_In.Valoriza_Par_Pte := 'VAL'
  else
     Reg_Val_In.Valoriza_Par_Pte := 'PTE';

  Reg_Val_Out.TasaCalculo := fTasa_Calculo;

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  if NOT Result then
     exit;

  fValor_Val_MC_Desde := Reg_Val_Out.ValorInvertidoMC;
  Array_Mem_Desarr    := Reg_Val_Out.Array_Mem_Desarr;
  RegDes              := Reg_Val_Out.RegDes          ;

  if fValor_Par_MC_Desde = 0 then
     fFactor_Variacion_Desde := 0
  else
     fFactor_Variacion_Desde := fValor_Val_MC_Desde / fValor_Par_MC_Desde;

  // Calculo Valor PAR a la fecha hasta
  Reg_Val_In.Con_Cupon          := True;               // Con Cupon
  Reg_Val_In.dFechaCalculo      := dFecha_Hasta;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_Out.Nominales         := fNominales;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  if NOT Result then
     exit;

  fValor_Par_MC_Hasta := Reg_Val_Out.Valor_Par_MC    ;
  Array_Mem_Desarr    := Reg_Val_Out.Array_Mem_Desarr;
  RegDes              := Reg_Val_Out.RegDes          ;

  // Obtengo valor PTE o Valuación (segun Parametro) a fecha hasta
  if sTipo_Valorizacion = 'VAL' then
     Reg_Val_In.Valoriza_Par_Pte := 'VAL'
  else
     Reg_Val_In.Valoriza_Par_Pte := 'PTE';

  Reg_Val_Out.TasaCalculo := fTasa_Calculo;

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  if NOT Result then
     exit;

  fValor_Val_MC_Hasta := Reg_Val_Out.ValorInvertidoMC;
  Array_Mem_Desarr    := Reg_Val_Out.Array_Mem_Desarr;
  RegDes              := Reg_Val_Out.RegDes          ;

  if fValor_Par_MC_Hasta = 0 then
     fFactor_Variacion_Hasta := 0
  else
     fFactor_Variacion_Hasta := fValor_Val_MC_Hasta / fValor_Par_MC_Hasta;


  fFactor_Variacion  := fFactor_Variacion_Hasta - fFactor_Variacion_Desde;
  fDecrease_Increase := fFactor_Variacion * fValor_Par_MC_Hasta;
end;
//------------------------------------------------------------------------------
procedure Intereses_Acumulados_VAL(sTipo_Instrumento          : String;
                                   sEmisor                    : String;
                                   sInstrumento               : String;
                                   sSerie                     : String;
                                   sNemotecnico               : String;
                                   fTasaEmision               : Double;
                                   fTasaCalculo               : Double;
                                   sUnidadMonetaria           : String;
                                   sTipoNominales             : String;
                                   dFecha_Emision              : TDateTime;
                                   dFecha_Vencimiento          : TDateTime;
                                   dFecha_Compra               : TDateTime;
                                   sMoneda_Conversion         : String;
                                   fNominales                 : Double;
                                   fNro_Titulos               : Double;
                                   dFecha_Desde               : TDateTime;
                                   dFecha_Hasta               : TDateTime;
                                   sTabla_Desarr_Cargada      : String;
                                   fNominales_Compra          : Double;
                                   fValor_Invertido_UM_Compra : Double;
                                   sProceso                   : String;
                                   var RegDes                 : TReg_Descriptor;
                                   var Array_Mem_Desarr       : TArray_Mem_Desarr;
                                   var fInteres_Acum_UM       : Double;
                                   var fInteres_Acum_MC       : Double;
                                   var sModulo_Err            : String;
                                   var sString_Err            : String;
                                   var Result                 : Boolean);
var
   fValor_Val_UM_Desde : Double;
   fValor_Val_UM_Hasta : Double;
//   fValor_Val_MC_Desde : Double;
//   fValor_Val_MC_Hasta : Double;
   fReajuste             : Double;
   fFactor_Reajuste      : Double;
   Reg_Val_In          : TRegistro_Valoriza_In;
   Reg_Val_Out         : TRegistro_Valoriza_Out;

   Registro_Fechas     : TRegistro_Fechas;

begin
  // Obtengo valuacion a fecha de desde
  Registro_Fechas.Fecha_Emision      := dFecha_Emision;
  Registro_Fechas.Fecha_Compra       := dFecha_Compra;
  Registro_Fechas.Fecha_Calculo      := dFecha_Hasta;

  Reg_Val_In.Tipo_Instrumento        := sTipo_Instrumento;
  Reg_Val_In.sEmisor                 := sEmisor;
  Reg_Val_In.sInstrumento            := sInstrumento;
  Reg_Val_In.sSerie                  := sSerie;
  Reg_Val_In.Nemotecnico             := sNemotecnico;
  Reg_Val_In.dTasaEmision            := fTasaEmision;
  Reg_Val_Out.TasaCalculo            := fTasaCalculo;
  Reg_Val_In.sUnidadMonetaria        := sUnidadMonetaria;
  Reg_Val_In.sTipoNominales          := sTipoNominales;
  Reg_Val_In.dFechaEmision           := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento       := dFecha_Vencimiento;
  Reg_Val_In.dFechaCalculo           := dFecha_Desde;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_In.sMoneda_Conversion      := sMoneda_Conversion;
  Reg_Val_In.Con_Cupon               := False;                // sin Cupon
  Reg_Val_In.Valoriza_Par_Pte        := 'VAL';
  Reg_Val_Out.Nominales              := fNominales;
  Reg_Val_In.Numero_Titulos          := fNro_Titulos;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes                 := RegDes;
  Reg_Val_In.Tabla_Desarr_Cargada    := sTabla_Desarr_Cargada;
  // Valores Originales a la Compra (Se usa en Calculo de TIR Interno)
  Reg_Val_In.dFechaCompra            := dFecha_Compra;
  Reg_Val_In.Nominales_Compra        := fNominales_Compra;
  Reg_Val_In.ValorInvertidoUM_Compra := fValor_Invertido_UM_Compra;
  Reg_Val_In.dFechaCompra            := dFecha_Compra;
  Reg_Val_Out.Valor_PAR_UM           := 0;

  Reg_Val_In.Proceso_Valuacion       := sProceso;


// OJO CON ESTA FUNCION LE FALTA LA FECHA DE PAGO
// (  Reg_Val_In.dFechaPago         := dFecha_Pago;)
// REVISARLA LO ANTES POSIBLE !!!!
// Se corrigio en el origen. Ahora en la fecha desde ya viene la fecha de pago si corresponde F.I. 19-02-2008
  Reg_Val_In.dFechaPago         := dFecha_Desde;


  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fValor_Val_UM_Desde := Reg_Val_Out.ValorInvertidoUM    ;
//  fValor_Val_MC_Desde := Reg_Val_Out.ValorInvertidoMC    ;
  Array_Mem_Desarr    := Reg_Val_Out.Array_Mem_Desarr;
  RegDes              := Reg_Val_Out.RegDes          ;

  if NOT Result then
     exit;

  // Calculo Valuacion a la fecha hasta

  Reg_Val_In.Con_Cupon          := True;               // Con Cupon
  Reg_Val_In.dFechaCalculo      := dFecha_Hasta;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_Out.Nominales         := fNominales;
  Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr   ;
  Reg_Val_In.Valoriza_Par_Pte   := 'VAL';
  // Se corrigio en el origen. Ahora en la fecha desde ya viene la fecha de pago si corresponde F.I. 19-02-2008
  Reg_Val_In.dFechaPago         := dFecha_Hasta;


  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fValor_Val_UM_Hasta := Reg_Val_Out.ValorInvertidoUM    ;
//  fValor_Val_MC_Hasta := Reg_Val_Out.ValorInvertidoMC    ;
  Array_Mem_Desarr    := Reg_Val_Out.Array_Mem_Desarr;
  RegDes              := Reg_Val_Out.RegDes          ;

  if NOT Result then
     exit;

  fInteres_Acum_UM := fValor_Val_UM_Hasta - fValor_Val_UM_Desde;


  Conversion_unidad_mon(sUnidadMonetaria
                       ,sMoneda_Conversion
                       ,'BC'
                       ,dFecha_Hasta
                       ,fInteres_Acum_UM
                       ,fInteres_Acum_MC
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);
  if NOT Result then
     exit;

  // Reajusto los intereses para el caso que corresponda
  // (QS_FIN_EXCP_VARCAM
  Reajuste_No_Indexado(sEmisor
                ,sInstrumento
                ,sSerie
                ,dFecha_Hasta
                ,Registro_Fechas
                ,0 // se debe enviar el iCuponVigente
                ,fInteres_Acum_MC
                ,fFactor_Reajuste
                ,fReajuste
                ,fInteres_Acum_MC
                ,sModulo_Err
                ,sString_Err
                ,Result);


end;
//------------------------------------------------------------------------------
procedure Limpia_Valores(sEmpresa_Usuario      : String;
                         sCartera              : String;
                         sTransaccion          : String;
                         dFecha_Operacion      : TDateTime;
                         sTipoInstrumento      : String;
                         sEmisor               : String;
                         sInstrumento          : String;
                         sSerie                : String;
                         sNemotecnico          : String;
                         fTasa_Emision         : Double;
                         fTasa_Calculo         : Double;
                         sMoneda_Instrumento   : String;
                         sTipo_Nominales       : String;
                         dFecha_Emision         : TDateTime;
                         dFecha_Vencimiento     : TDateTime;
                         dFecha_Compra          : TDateTime;
                         dFecha_Pago            : TDateTime;
                         sMoneda_Informe       : String;
                         fCupones_Cortados      : Double;
                         sReajuste_Sobre       : String;
                         fSaldo_Insoluto       : Double;
                         fNominales_Vigentes   : Double;
                         sTabla_Desarr_Cargada : String;
                         RegDes                : TReg_Descriptor;
                         var Array_Mem_Desarr      : TArray_Mem_Desarr;
                         dFecha_Desde          : TDateTime;
                         dFecha_Hasta          : TDateTime;
                         fValor_Dirty_UM       : Double;
                         var fValor_Clean_UM   : Double;
                         var fValor_Clean_UM_Rea : Double;
                         var sModulo_Err        : String;
                         var sString_Err        : String;
                         var Result            : Boolean);

var
   fInteres_Acum_UM     : Double;
   fInteres_Acum_MC     : Double;
   fReajuste_Interes    : Double;
   fFactor_Reajuste     : Double;
   fNoUtilizado         : Double;
   Reg_Fechas           : TRegistro_Fechas;
   Reg_Val_In           : TRegistro_Valoriza_In;
   iCupon_Vigente       : Integer;
   //fReajuste_Indexado        : Double;
   //fAjuste_Reajuste_Indexado : Double;
   fRea_Acum_NO_Indexado_Anterior : Double;
   fRea_Acum_NO_Indexado_Actual   : Double;
   fRea_NO_Indexado_Devengado     : Double;

begin
   // Se deben eliminar los intereses del titulo antes de la Compra
   // en el valor de Compra
   // siempre y cuando no este especificado que son ingresados
   // LIMPIOS (CLEAN) ......
   if Tipo_Valores(sEmpresa_Usuario
                  ,sTransaccion
                  ,dFecha_Operacion) = 'CLEAN' then
   begin
      fValor_Clean_UM := fValor_Dirty_UM;
      fValor_Clean_UM_Rea := fValor_Dirty_UM;
      exit;
   end;

   fFactor_Reajuste := 1;
   Reg_Fechas.Fecha_Emision := dFecha_Emision;
   Reg_Fechas.Fecha_Compra  := dFecha_Compra;
   Reg_Fechas.Fecha_Calculo := dFecha_Operacion;

   Reg_Val_In.Tipo_Instrumento    := sTipoInstrumento;
   Reg_Val_In.Nemotecnico         := sNemotecnico;
   Reg_Val_In.dTasaEmision        := fTasa_Emision;
   Reg_Val_In.sUnidadMonetaria    := sMoneda_Instrumento;
   Reg_Val_In.sTipoNominales      := sTipo_Nominales;
   Reg_Val_In.dFechaEmision       := dFecha_Emision;
   Reg_Val_In.dFechaVencimiento   := dFecha_Vencimiento;
   Reg_Val_In.dFechaCompra        := dFecha_Compra;
   Reg_Val_In.dFechaPago          := dFecha_Pago;
   Reg_Val_In.sMoneda_Conversion  := sMoneda_Informe;
   Reg_Val_In.fCupones_Cortados   := fCupones_Cortados;

   // Esta funcion calcula los intereses acumulados
   // haciendo la diferencia para el caso de titulos afectados por la execepcion
   // Variacion Cambiaria .....
   // Caso contrario realiza el calculo en forma estandar ...
   //

   Intereses_Acumulados(sTipoInstrumento
                       ,sEmisor
                       ,sInstrumento
                       ,sSerie
                       ,sNemotecnico
                       ,fTasa_Emision
                       ,fTasa_Calculo
                       ,sMoneda_Instrumento
                       ,sTipo_Nominales
                       ,dFecha_Emision
                       ,dFecha_Vencimiento
                       ,dFecha_Compra
                       ,dFecha_Operacion
                       ,dFecha_Pago
                       ,sMoneda_Informe
                       ,fCupones_Cortados
                       ,fNominales_Vigentes
                       ,dFecha_Desde
                       ,dFecha_Hasta
                       ,'NO' //Descriptor
                       ,sTabla_Desarr_Cargada
                       ,RegDes
                       ,Array_Mem_Desarr
                       ,fInteres_Acum_UM
                       ,fInteres_Acum_MC
                       ,fNoUtilizado
//                       ,fReajuste_Indexado
//                       ,fAjuste_Reajuste_Indexado
                       ,fRea_Acum_NO_Indexado_Anterior
                       ,fRea_Acum_NO_Indexado_Actual
                       ,fRea_NO_Indexado_Devengado
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);
  if NOT Result then
      exit;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Hasta
               ,True              // Con Cupon
               ,iCupon_Vigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;
  // Necesito recalcular el reajuste NO INDEXADO
  // Ya que me devuelve el factor de reajuste !!!!!
  // y lo necesito para quitar al valor de compra sus reajustes

   if iCupon_Vigente = 1 then
      Reg_Fechas.Fecha_Inic_Periodo := dFecha_Emision
   else
      Reg_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto;

  Reg_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto;
  Reajuste_No_Indexado(sEmisor
                      ,sInstrumento
                      ,sSerie
                      ,dFecha_Hasta
                      ,Reg_Fechas
                      ,iCupon_Vigente
                      ,fInteres_Acum_UM
                      ,fFactor_Reajuste
                      ,fReajuste_Interes
                      ,fNoUtilizado
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);
   if NOT Result then
      exit;

  // Resto al valor de compra los intereses devengados a la compra (SOLO NO INDEXADO)
  fValor_Clean_UM := fValor_Dirty_UM -
                     fReajuste_Interes -
                     fInteres_Acum_UM;

  fValor_Clean_UM_Rea := fValor_Clean_UM;
  // En el caso de estar trabajando con Reajustes No indexados
  // Debo eliminar el reajuste que ya tiene
  // Al dividir por el factor de reajuste le estoy quitando los reajustes
  // Hace la diferencia si el reajuste se aplica al Costo o al Capital Residual (o SALDO INSOLUTO)
  if sReajuste_Sobre = 'Reajustes_Sobre_Capital_Residual' then
     fValor_Clean_UM := fValor_Clean_UM - (fSaldo_Insoluto - (fSaldo_Insoluto / fFactor_Reajuste))
  else
//   if dFecha_Desde <> dFecha_Hasta then   // Comentado con fecha 18/12/2012 Debe sacarle el reajuste
      fValor_Clean_UM := fValor_Clean_UM / fFactor_Reajuste;
end;
//------------------------------------------------------------------------------
procedure Limpia_Valores_Vig(sEmpresa_Usuario      : String;
                             sCartera              : String;
                             sTransaccion          : String;
                             dFecha_Operacion      : TDateTime;
                             sTipoInstrumento      : String;
                             sEmisor               : String;
                             sInstrumento          : String;
                             sSerie                : String;
                             dFecha_Vig            : TDateTime;
                             sNemotecnico          : String;
                             fTasa_Emision         : Double;
                             fTasa_Calculo         : Double;
                             sMoneda_Instrumento   : String;
                             sTipo_Nominales       : String;
                             dFecha_Emision         : TDateTime;
                             dFecha_Vencimiento     : TDateTime;
                             dFecha_Compra          : TDateTime;
                             dFecha_Pago            : TDateTime;
                             sMoneda_Informe       : String;
                             fCupones_Cortados      : Double;
                             sReajuste_Sobre       : String;
                             fSaldo_Insoluto       : Double;
                             fNominales_Vigentes   : Double;
                             sTabla_Desarr_Cargada : String;
                             RegDes                : TReg_Descriptor;
                             Array_Mem_Desarr      : TArray_Mem_Desarr;
                             dFecha_Desde          : TDateTime;
                             dFecha_Hasta          : TDateTime;
                             fValor_Dirty_UM       : Double;
                             var fValor_Clean_UM   : Double;
                             var fValor_Clean_UM_Rea : Double;
                             var sModulo_Err        : String;
                             var sString_Err        : String;
                             var Result            : Boolean);

var
   fInteres_Acum_UM     : Double;
   fInteres_Acum_MC     : Double;
   fReajuste_Interes    : Double;
   fFactor_Reajuste     : Double;
   fNoUtilizado         : Double;
   Reg_Fechas           : TRegistro_Fechas;
   Reg_Val_In           : TRegistro_Valoriza_In;
   iCupon_Vigente       : Integer;
   //fReajuste_Indexado        : Double;
   //fAjuste_Reajuste_Indexado : Double;
   fRea_Acum_NO_Indexado_Anterior : Double;
   fRea_Acum_NO_Indexado_Actual   : Double;
   fRea_NO_Indexado_Devengado     : Double;

begin
   // Se deben eliminar los intereses del titulo antes de la Compra
   // en el valor de Compra
   // siempre y cuando no este especificado que son ingresados
   // LIMPIOS (CLEAN) ......
   if Tipo_Valores(sEmpresa_Usuario
                  ,sTransaccion
                  ,dFecha_Operacion) = 'CLEAN' then
   begin
      fValor_Clean_UM := fValor_Dirty_UM;
      fValor_Clean_UM_Rea := fValor_Dirty_UM;
      exit;
   end;

   fFactor_Reajuste := 1;
   Reg_Fechas.Fecha_Emision := dFecha_Emision;
   Reg_Fechas.Fecha_Compra  := dFecha_Compra;
   Reg_Fechas.Fecha_Calculo := dFecha_Operacion;

   Reg_Val_In.Tipo_Instrumento    := sTipoInstrumento;
   Reg_Val_In.Nemotecnico         := sNemotecnico;
   Reg_Val_In.dTasaEmision        := fTasa_Emision;
   Reg_Val_In.sUnidadMonetaria    := sMoneda_Instrumento;
   Reg_Val_In.sTipoNominales      := sTipo_Nominales;
   Reg_Val_In.dFechaEmision       := dFecha_Emision;
   Reg_Val_In.dFechaVencimiento   := dFecha_Vencimiento;
   Reg_Val_In.dFechaCompra        := dFecha_Compra;
   Reg_Val_In.dFechaPago          := dFecha_Pago;
   Reg_Val_In.sMoneda_Conversion  := sMoneda_Informe;

   // Esta funcion calcula los intereses acumulados
   // haciendo la diferencia para el caso de titulos afectados por la execepcion
   // Variacion Cambiaria .....
   // Caso contrario realiza el calculo en forma estandar ...
   //

   Intereses_Acumulados_Vig(sTipoInstrumento
                           ,sEmisor
                           ,sInstrumento
                           ,sSerie
                           ,dFecha_Vig
                           ,sNemotecnico
                           ,fTasa_Emision
                           ,fTasa_Calculo
                           ,sMoneda_Instrumento
                           ,sTipo_Nominales
                           ,dFecha_Emision
                           ,dFecha_Vencimiento
                           ,dFecha_Compra
                           ,dFecha_Operacion
                           ,dFecha_Pago
                           ,sMoneda_Informe
                           ,fCupones_Cortados
                           ,fNominales_Vigentes
                           ,dFecha_Desde
                           ,dFecha_Hasta
                           ,sTabla_Desarr_Cargada
                           ,RegDes
                           ,Array_Mem_Desarr
                           ,fInteres_Acum_UM
                           ,fInteres_Acum_MC
                           ,fNoUtilizado
//                           ,fReajuste_Indexado
//                           ,fAjuste_Reajuste_Indexado
                           ,fRea_Acum_NO_Indexado_Anterior
                           ,fRea_Acum_NO_Indexado_Actual
                           ,fRea_NO_Indexado_Devengado
                           ,sModulo_Err
                           ,sString_Err
                           ,Result);
  if NOT Result then
      exit;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Hasta
               ,True              // Con Cupon
               ,iCupon_Vigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;
  // Necesito recalcular el reajuste NO INDEXADO
  // Ya que me devuelve el factor de reajuste !!!!!
  // y lo necesito para quitar al valor de compra sus reajustes

   if iCupon_Vigente = 1 then
      Reg_Fechas.Fecha_Inic_Periodo := dFecha_Emision
   else
      Reg_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto;

  Reg_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto;
  Reajuste_No_Indexado(sEmisor
                      ,sInstrumento
                      ,sSerie
                      ,dFecha_Hasta
                      ,Reg_Fechas
                      ,iCupon_Vigente
                      ,fInteres_Acum_UM
                      ,fFactor_Reajuste
                      ,fReajuste_Interes
                      ,fNoUtilizado
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);
   if NOT Result then
      exit;

  // Resto al valor de compra los intereses devengados a la compra (SOLO NO INDEXADO)
  fValor_Clean_UM := fValor_Dirty_UM -
                     fReajuste_Interes -
                     fInteres_Acum_UM;

  fValor_Clean_UM_Rea := fValor_Clean_UM;
  // En el caso de estar trabajando con Reajustes No indexados
  // Debo eliminar el reajuste que ya tiene
  // Al dividir por el factor de reajuste le estoy quitando los reajustes
  // Hace la diferencia si el reajuste se aplica al Costo o al Capital Residual (o SALDO INSOLUTO)
  if sReajuste_Sobre = 'Reajustes_Sobre_Capital_Residual' then
     fValor_Clean_UM := fValor_Clean_UM - (fSaldo_Insoluto - (fSaldo_Insoluto / fFactor_Reajuste))
  else
   if dFecha_Desde <> dFecha_Hasta then
      fValor_Clean_UM := fValor_Clean_UM / fFactor_Reajuste;
end;
//------------------------------------------------------------------------------
procedure Reajuste_No_Indexado(sEmisor                  : String;
                               sInstrumento             : String;
                               sSerie                   : String;
                               dFecha_Calculo           : TDateTime;
                               Registro_Fechas          : TRegistro_Fechas;
                               iCupon_Vigente           : Integer;
                               fValor_a_Reajustar       : Double;
                               var fFactor_Reajuste     : Double;
                               var fReajuste            : Double;
                               var fValor_Reajustado    : Double;
                               var sModulo_Err           : String;
                               var sString_Err           : String;
                               var Result               : Boolean);
var
   fPtje_Aplica_Reajuste        : Double;
   sCod_Indice_Reajuste         : String;
   sCod_Tratam_Inicio           : String;
   sCod_Tratam_Termino          : String;
   fValor_Ind_Inicio            : Double;
   fValor_Ind_Termino           : Double;
   dFecha_Inicio                : TDateTime;
   dFecha_Termino               : TDateTime;
   sPaga_Reajuste_Capital       : String;
   sNo_Considera_en_Interes              : String;
   sSolo_Aplica_en_Vctos                 : String;
   sNo_Considera_Negativos               : String;
begin
   // Reajuste
   fValor_Reajustado    := fValor_a_Reajustar;
   fReajuste            := 0;
   fFactor_Reajuste     := 1;
   {
   if dFecha_Calculo = Registro_Fechas.Fecha_Emision then
   begin
     // Sale sin reajustar ...
     Result := True;
     exit;
   end;
   }
   Verifica_Excepcion_Variacion_Cambiaria(sEmisor
                                         ,sInstrumento
                                         ,sSerie
                                         ,iCupon_Vigente //
                                         ,dFecha_Calculo
                                         ,fPtje_Aplica_Reajuste
                                         ,sCod_Indice_Reajuste
                                         ,sCod_Tratam_Inicio
                                         ,sCod_Tratam_Termino
                                         ,Registro_Fechas.Fecha_Desde
                                         ,Registro_Fechas.Fecha_Hasta
                                         ,sPaga_Reajuste_Capital
                                         ,sNo_Considera_en_Interes
                                         ,sSolo_Aplica_en_Vctos
                                         ,sNo_Considera_Negativos
                                         ,Result);

   if NOT Result then
   begin
     // Sale sin reajustar ...
     Result := True;
     exit;
   end;

   if Registro_Fechas.Fecha_Hasta > dFecha_Calculo then
      Registro_Fechas.Fecha_Hasta := dFecha_Calculo;

   Calcula_Variacion_Cambiaria(sCod_Indice_Reajuste
                              ,sCod_Tratam_Inicio
                              ,sCod_Tratam_Termino
                              ,Registro_Fechas
                              ,fPtje_Aplica_Reajuste
                              ,fFactor_Reajuste
                              ,dFecha_Inicio
                              ,dFecha_Termino
                              ,fValor_Ind_Inicio
                              ,fValor_Ind_Termino
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);

   if NOT Result then
      exit;

   fValor_Reajustado := fValor_a_Reajustar * fFactor_Reajuste;
   fReajuste         := fValor_Reajustado - fValor_a_Reajustar;
end;
//------------------------------------------------------------------------------
// Incluye tambien lo capitalizado del periodo
// Estas Se calculan con los nominales vigentes al cierre ya que estas efectan
// el saldo insoluto por lo cual este ultimo se ve afectado en forma natural por las ventas
//------------------------------------------------------------------------------
// Se incluye datos transaccion para descontar las ventas en el periodo
// Se agrega Amortizacion Pagada que considera las ventas en el tiempo
// Estaba pasando que solo considerabamos las amortizaciones segun los
// Nominales originales y no descontados

procedure Amortizacion_Periodo(sInstrumento                                        : String;
                               sTipo_Instrumento                                   : String;
                               sCartera                                            : String;
                               RegDes                                              : TReg_Descriptor;
                               dFecha_Desde                                        : TDateTime;
                               dFecha_Hasta                                        : TDateTime;
                               dFecha_Compra                                       : TDateTime;
                               dFecha_Emision                                      : TDateTime;
                               fValor_Nominal_Original                             : Double;
                               fValor_Nominal_Vigente                              : Double;
                               sMoneda_Instrum                                     : String;
                               sMoneda_Conver                                      : String;
                               sEmpresa                                            : String;
                               sTransaccion                                        : String;
                               sFolio_Interno                                      : String;
                               fItem_Omd                                           : Double;
                               var Array_Mem_Desarr                                : TArray_Mem_Desarr;

                               var fMonto_Amort_UM                                 : Double;
                               var fMonto_Amort_MC                                 : Double;
                               var fReajuste_Indexado_Amort                        : Double;
                               var fReajuste_No_Indexado_Amort                     : Double;

                               var fMonto_Amort_Pagado_UM                          : Double;
                               var fMonto_Amort_Pagado_MC                          : Double;
                               var fReajuste_Indexado_Amort_Pagado                 : Double;
                               var fReajuste_No_Indexado_Amort_Pagado              : Double;

                               var fMonto_Capitalizado_UM                          : Double;
                               var fMonto_Capitalizado_MC                          : Double;
                               var fReajuste_Indexado_Capitalizado                 : Double;
                               var fReajuste_No_Indexado_Capitalizado              : Double;

                               var fDiferencia_TC_Amort_Cupon                      : Double;
                               var fDiferencia_TC_Amort_Cupon_Pagado               : Double;
                               var fDiferencia_TC_Capit_Cupon                      : Double;

                               fProporcion_ActualCost_SalInsol                     : Double;
                               var fMonto_Amort_Actual_Cost_UM                     : Double;
                               var fMonto_Amort_Actual_Cost_MC                     : Double;
                               var fReajuste_Indexado_Actual_Cost                  : Double;
                               var fReajuste_No_Indexado_Actual_Cost               : Double;
                               var fDiferencia_TC_Actual_Cost                      : Double;


                               var sModulo_Err                                     : String;
                               var sString_Err                                     : String;
                               var Result                                          : Boolean);

var
  i                      : Integer;
  sCod_Indice_Reajuste   : String;
  Registro_Fechas        : TRegistro_Fechas;
  fNominales_Vendidos    : Double;
  fNominales_Reales      : Double;

  fMonto_Amort_Cupon_UM                : Double;
  fMonto_Amort_Cupon_MC                : Double;
  fReajuste_Indexado_Amort_Cupon       : Double;
  fReajuste_No_Indexado_Amort_Cupon    : Double;
  fReajuste_No_Indexado_Amort_Cupon_UM : Double;

  fMonto_Amort_Cupon_Actual_Cost_UM           : Double;
  fMonto_Amort_Cupon_Actual_Cost_MC           : Double;
  fReajuste_Indexado_Cupon_Actual_Cost        : Double;
  fReajuste_No_Indexado_Cupon_Actual_Cost     : Double;
  fReajuste_No_Indexado_Cupon_Actual_Cost_UM  : Double;


  fMonto_Amort_Cupon_Pagado_UM                : Double;
  fMonto_Amort_Cupon_Pagado_MC                : Double;
  fReajuste_Indexado_Amort_Pagado_Cupon       : Double;
  fReajuste_No_Indexado_Amort_Pagado_Cupon    : Double;
  fReajuste_No_Indexado_Amort_Pagado_Cupon_UM : Double;

  fReajuste_Indexado_Capit_Cupon              : Double;
  fReajuste_No_Indexado_Capit_Cupon           : Double;
  fReajuste_No_Indexado_Capit_Cupon_UM        : Double;

  fMonto_Capit_Cupon_UM                       : Double;
  fMonto_Capit_Cupon_MC                       : Double;
  fDiferencia_tipo_cambio                     : Double;

  fDif_TC_Amort_Cupon                  : Double;
  fDif_TC_Amort_Cupon_Pagado           : Double;
  fDif_TC_Capit_Cupon_MC               : Double;
  fDif_TC_Actual_Cost                  : Double;


  fMonto_Capit_Cupon_MC_Cpa          : Double;
  fMonto_Capitalizado_Cupon_MC_ConRea : Double;



 begin
  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;
  i := 1;
  Result := True;
  fMonto_Amort_UM                                 := 0;
  fMonto_Amort_MC                                 := 0;
  fReajuste_Indexado_Amort                        := 0;
  fReajuste_No_Indexado_Amort                     := 0;
  fMonto_Amort_Pagado_UM                          := 0;
  fMonto_Amort_Pagado_MC                          := 0;
  fReajuste_Indexado_Amort_Pagado                 := 0;
  fReajuste_No_Indexado_Amort_Pagado              := 0;

  //fMonto_Capit_Cupon_UM                           := 0;
  fMonto_Capit_Cupon_MC                           := 0;
  fMonto_Capitalizado_UM                          := 0;
  fMonto_Capitalizado_MC                          := 0;
  fReajuste_Indexado_Capitalizado                 := 0;
  fReajuste_No_Indexado_Capitalizado              := 0;

  //fMonto_Amort_Cupon_MC                           := 0;
  fReajuste_Indexado_Amort_Cupon                  := 0;
  fReajuste_No_Indexado_Amort_Cupon               := 0;
  fMonto_Amort_Cupon_Pagado_MC                    := 0;
  fReajuste_Indexado_Amort_Pagado_Cupon           := 0;
  fReajuste_No_Indexado_Amort_Pagado_Cupon        := 0;

  fMonto_Capitalizado_Cupon_MC_ConRea             := 0;
  fReajuste_Indexado_Capit_Cupon                  := 0;
  fReajuste_No_Indexado_Capit_Cupon               := 0;

  fDiferencia_TC_Amort_Cupon         := 0;
  fDiferencia_TC_Amort_Cupon_Pagado  := 0;
  fDiferencia_TC_Capit_Cupon         := 0;
  fDif_TC_Capit_Cupon_MC             := 0;

  fMonto_Amort_Cupon_Actual_Cost_MC           := 0;
  fReajuste_Indexado_Cupon_Actual_Cost        := 0;
  fReajuste_No_Indexado_Cupon_Actual_Cost     := 0;
  fReajuste_No_Indexado_Cupon_Actual_Cost_UM  := 0;
  fDiferencia_TC_Actual_Cost                  := 0;

  fMonto_Amort_Actual_Cost_UM                 := 0;
  fMonto_Amort_Actual_Cost_MC                 := 0;
  fReajuste_Indexado_Actual_Cost              := 0;
  fReajuste_No_Indexado_Actual_Cost           := 0;
  fDif_TC_Actual_Cost                         := 0;

  if dFecha_Desde < dFecha_Compra then
     dFecha_Desde := dFecha_Compra;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;

  if RegDes.Base_Conversion = 0 then
     begin
       sString_Err := 'Base Conversión de instrumento no puede ser igual a cero'+#10
                    +RegDes.Codigo_Emisor
                    +'/'
                    +RegDes.Codigo_Instrumento
                    +'/'
                    +RegDes.Serie;
       sModulo_Err := 'Amortización del período';
       Result := False;
       exit;
     end;


//    While i = Array_Mem_Desarr[i].Nro_Cupon do
    for i := 1 to Max_Nro_Cupones do
     begin
       if (Array_Mem_Desarr[i].Fecha_Vcto > dFecha_Desde) and
          (Array_Mem_Desarr[i].Fecha_Vcto <= dFecha_Hasta) then
          begin
              if (Array_Mem_Desarr[i].Amortizacion_Original = 0) and
                 (Array_Mem_Desarr[i].Capitalizado_Cupon = 0) then
              begin
//                Inc(i);
                Continue;
              end;

              // Valores Necesarios para Reajuste_No_Indexado
              // Es igual para todos los calculos pero diferente
              // para cada cupon ....
              Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[i].Fecha_Vcto;
              if i = 1 then
                 Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
              else
                 Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[i-1].Fecha_Vcto;
              Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[i].Fecha_Vcto;

              // Nuevo disminuye ventas a la fecha de corte
              // Lo hace para determinar amortizaciones realmente pagadas

//              if sValorizacion_Proceso = 'SI' then
                 Determina_Nominales_Vendidos(Array_Mem_Desarr[i].Fecha_Vcto
                                             ,sEmpresa
                                             ,sTransaccion
                                             ,sFolio_interno
                                             ,fItem_Omd
                                             ,fNominales_Vendidos);
//              else
//                 Determina_Nominales_Vendidos_Mem(Array_Mem_Desarr[i].Fecha_Vcto
//                                                 ,Array_Mem_Desarr[i].Fecha_Vcto
//                                                 ,Array_Mem_Desarr[i].Fecha_Vcto
//                                                 ,sEmpresa
//                                                 ,sTransaccion
//                                                 ,sFolio_Interno
//                                                 ,fItem_Omd
//                                                 ,fNominales_Vendidos
//                                                 ,fNoUtilizado
//                                                 ,fNoUtilizado
//                                                 );
              fNominales_Reales := fValor_Nominal_Original - fNominales_Vendidos;

              fMonto_Amort_Cupon_UM := Array_Mem_Desarr[i].Amortizacion_Original *
                                       fValor_Nominal_Vigente /
                                       RegDes.Base_Conversion;

              // Ojo: Discutido con Quezada 19-11-2003
              // Las amortizaciones se reajustan desde fecha de Compra
              // Recordar pagamos por un capital a esa fecha
              // OJO : Optimizar usando el factor de reajuste que ya esta en la tabla
              fDif_TC_Amort_Cupon := 0;
              Reajuste_Valor(sInstrumento
                            ,sMoneda_Instrum
                            ,sMoneda_Conver
                            ,dFecha_Compra                  // Fecha Desde
                            ,Array_Mem_Desarr[i].Fecha_Vcto // Fecha Hasta
                            ,fMonto_Amort_Cupon_UM
                            ,dFecha_Compra
                            ,dFecha_Emision
                            ,RegDes
                            ,False             // bConCupon Se incorpora 05-07-2006
                            ,Array_Mem_Desarr
                            ,sCod_Indice_Reajuste
                            ,fReajuste_Indexado_Amort_Cupon
                            ,fReajuste_No_Indexado_Amort_Cupon_UM
                            ,fReajuste_No_Indexado_Amort_Cupon
                            ,fMonto_Amort_Cupon_MC
                            ,fDif_TC_Amort_Cupon
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
              if NOT Result then
                 Break;

              fMonto_Amort_UM        := fMonto_Amort_UM +
                                        fMonto_Amort_Cupon_UM;

              fMonto_Amort_MC        := fMonto_Amort_MC +
                                        fMonto_Amort_Cupon_MC;

              fReajuste_Indexado_Amort    := fReajuste_Indexado_Amort +
                                             fReajuste_Indexado_Amort_Cupon;
              fReajuste_No_Indexado_Amort := fReajuste_No_Indexado_Amort +
                                             fReajuste_No_Indexado_Amort_Cupon;


              fDiferencia_TC_Amort_Cupon := fDiferencia_TC_Amort_Cupon +
                                            fDif_TC_Amort_Cupon;

              // Amortizaciones segun nominales vigentes a la fecha de corte
              fMonto_Amort_Cupon_Pagado_UM := Array_Mem_Desarr[i].Amortizacion_Original *
                                              fNominales_Reales /
                                              RegDes.Base_Conversion;

              fDif_TC_Amort_Cupon_Pagado := 0;
              Reajuste_Valor(sInstrumento
                            ,sMoneda_Instrum
                            ,sMoneda_Conver
                            ,dFecha_Compra                  // Fecha Desde
                            ,Array_Mem_Desarr[i].Fecha_Vcto // Fecha Hasta
                            ,fMonto_Amort_Cupon_Pagado_UM
                            ,dFecha_Compra
                            ,dFecha_Emision
                            ,RegDes
                            ,False             // bConCupon Se incorpora 05-07-2006
                            ,Array_Mem_Desarr
                            ,sCod_Indice_Reajuste
                            ,fReajuste_Indexado_Amort_Pagado_Cupon
                            ,fReajuste_No_Indexado_Amort_Pagado_Cupon_UM
                            ,fReajuste_No_Indexado_Amort_Pagado_Cupon
                            ,fMonto_Amort_Cupon_Pagado_MC
                            ,fDif_TC_Amort_Cupon_Pagado
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
              if NOT Result then
                 Break;

              fMonto_Amort_Pagado_UM := fMonto_Amort_Pagado_UM +
                                        fMonto_Amort_Cupon_Pagado_UM;

              fMonto_Amort_Pagado_MC := fMonto_Amort_Pagado_MC +
                                        fMonto_Amort_Cupon_Pagado_MC;

              fReajuste_Indexado_Amort_Pagado :=
                                        fReajuste_Indexado_Amort_Pagado +
                                        fReajuste_Indexado_Amort_Pagado_Cupon;
              fReajuste_No_Indexado_Amort_Pagado_Cupon :=
                                        fReajuste_No_Indexado_Amort_Pagado +
                                        fReajuste_No_Indexado_Amort_Pagado_Cupon;

              fDiferencia_TC_Amort_Cupon_Pagado  := fDiferencia_TC_Amort_Cupon_Pagado +
                                                    fDif_TC_Amort_Cupon_Pagado;



              if (SAmortizacion_Actual_Cost_base = 'Amortizacion_Capital_TIR_Capital') and
                 (sTipo_Instrumento = 'S')                                             then
              Begin
                  fMonto_Amort_Cupon_Actual_Cost_MC           := 0;
                  fReajuste_Indexado_Cupon_Actual_Cost        := 0;
                  fReajuste_No_Indexado_Cupon_Actual_Cost     := 0;
                  fReajuste_No_Indexado_Cupon_Actual_Cost_UM  := 0;
                  fMonto_Amort_Cupon_Actual_Cost_UM := Array_Mem_Amortizacion_Actual_Cost[i].ValorPteCupon *
                                           fValor_Nominal_Vigente /
                                           RegDes.Base_Conversion;
                  fDif_TC_Amort_Cupon := 0;
                  Reajuste_Valor(sInstrumento
                                ,sMoneda_Instrum
                                ,sMoneda_Conver
                                ,dFecha_Compra                  // Fecha Desde
                                ,Array_Mem_Desarr[i].Fecha_Vcto // Fecha Hasta
                                ,fMonto_Amort_Cupon_Actual_Cost_UM
                                ,dFecha_Compra
                                ,dFecha_Emision
                                ,RegDes
                                ,False             // bConCupon Se incorpora 05-07-2006
                                ,Array_Mem_Desarr
                                ,sCod_Indice_Reajuste
                                ,fReajuste_Indexado_Cupon_Actual_Cost
                                ,fReajuste_No_Indexado_Cupon_Actual_Cost_UM
                                ,fReajuste_No_Indexado_Cupon_Actual_Cost
                                ,fMonto_Amort_Cupon_Actual_Cost_MC
                                ,fDif_TC_Actual_Cost
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);
                  if NOT Result then
                     Break;
                  fMonto_Amort_Actual_Cost_UM       := fMonto_Amort_Actual_Cost_UM +
                                                       fMonto_Amort_Cupon_Actual_Cost_UM;
                  fMonto_Amort_Actual_Cost_MC       := fMonto_Amort_Actual_Cost_MC +
                                                       fMonto_Amort_Cupon_Actual_Cost_MC;
                  fReajuste_Indexado_Actual_Cost    := fReajuste_Indexado_Actual_Cost +
                                                       fReajuste_Indexado_Cupon_Actual_Cost;
                  fReajuste_No_Indexado_Actual_Cost := fReajuste_No_Indexado_Actual_Cost +
                                                       fReajuste_No_Indexado_Cupon_Actual_Cost;
                  fDiferencia_TC_Actual_Cost        := fDiferencia_TC_Actual_Cost +
                                                       fDif_TC_Actual_Cost;
              end
              else
                 if (SAmortizacion_Actual_Cost_base = 'Amortizacion_Capital_TIR_Capital') and
                    (sTipo_Instrumento = 'S')                                             then
                 Begin
                 end;


              // Capitalizaciones
              fMonto_Capit_Cupon_UM :=  Array_Mem_Desarr[i].Capitalizado_Cupon  *
                                        fValor_Nominal_Vigente /
                                        RegDes.Base_Conversion;

              fMonto_Capit_Cupon_MC_Cpa := 0;
              { No es necesario ya que la dif tipo de cambio viene en la funcion reajuste
                29-07-2013
              Conversion_unidad_mon(sMoneda_Instrum
                                   ,sMoneda_Conver
                                   ,'BC'
                                   ,dFecha_Compra
                                   ,fMonto_Capit_Cupon_UM
                                   ,fMonto_Capit_Cupon_MC_Cpa
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);

              if NOT Result then
                 Break;
              }
              Conversion_unidad_mon(sMoneda_Instrum
                                   ,sMoneda_Conver
                                   ,'BC'
                                   ,Array_Mem_Desarr[i].Fecha_Vcto
                                   ,fMonto_Capit_Cupon_UM
                                   ,fMonto_Capit_Cupon_MC
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);

              if NOT Result then
                 Break;

              // Reajuste Capitalizacion
              // fMonto_Capitalizado_Cupon_MC_ConRea
              fDif_TC_Capit_Cupon_MC := 0;
              Reajuste_Valor(sInstrumento
                            ,sMoneda_Instrum
                            ,sMoneda_Conver
                            ,dFecha_Compra                  // Fecha Desde
                            ,Array_Mem_Desarr[i].Fecha_Vcto // Fecha Hasta
                            ,fMonto_Capit_Cupon_UM
                            ,dFecha_Compra
                            ,dFecha_Emision
                            ,RegDes
                            ,False             // bConCupon Se incorpora 05-07-2006
                            ,Array_Mem_Desarr
                            ,sCod_Indice_Reajuste
                            ,fReajuste_Indexado_Capit_Cupon
                            ,fReajuste_No_Indexado_Capit_Cupon_UM
                            ,fReajuste_No_Indexado_Capit_Cupon
                            ,fMonto_Capitalizado_Cupon_MC_ConRea
                            ,fDif_TC_Capit_Cupon_MC
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
              if NOT Result then
                 Break;

              fMonto_Capitalizado_UM := fMonto_Capitalizado_UM +
                                        fMonto_Capit_Cupon_UM;

              fMonto_Capitalizado_MC := fMonto_Capitalizado_MC +
                                        fMonto_Capit_Cupon_MC ;

              fReajuste_Indexado_Capitalizado :=
                                        fReajuste_Indexado_Capitalizado +
                                        fReajuste_Indexado_Capit_Cupon;
              fReajuste_No_Indexado_Capitalizado :=
                                        fReajuste_No_Indexado_Capitalizado +
                                        fReajuste_No_Indexado_Capit_Cupon;

              fDiferencia_TC_Capit_Cupon := fDiferencia_TC_Capit_Cupon +
                                            fDif_TC_Capit_Cupon_MC;  // La diferencia de TC la devuelve la funcion reajuste...
                                            //(fMonto_Capit_Cupon_MC - fMonto_Capit_Cupon_MC_Cpa);

          end; // If cupon en el periodo
//       Inc(i);
     end; // While

     if (SAmortizacion_Actual_Cost_base <> 'Amortizacion_Capital_TIR_Capital') or
        (sTipo_Instrumento <> 'S')                                             then
     begin
        fMonto_Amort_Actual_Cost_UM       := fMonto_Amort_UM * fProporcion_ActualCost_SalInsol;
        fMonto_Amort_Actual_Cost_MC       := fMonto_Amort_MC * fProporcion_ActualCost_SalInsol;
        fReajuste_Indexado_Actual_Cost    := fReajuste_Indexado_Amort * fProporcion_ActualCost_SalInsol;
        fReajuste_No_Indexado_Actual_Cost := fReajuste_No_Indexado_Amort * fProporcion_ActualCost_SalInsol;
        fDiferencia_TC_Actual_Cost        := fDiferencia_TC_Amort_Cupon * fProporcion_ActualCost_SalInsol;
     end;


end;

(*
procedure Amortizacion_Periodo(sInstrumento                                        : String;
                               sTipo_Instrumento                                   : String;
                               sCartera                                            : String;
                               RegDes                                              : TReg_Descriptor;
                               dFecha_Desde                                        : TDateTime;
                               dFecha_Hasta                                        : TDateTime;
                               dFecha_Compra                                       : TDateTime;
                               dFecha_Emision                                      : TDateTime;
                               fValor_Nominal_Original                             : Double;
                               fValor_Nominal_Vigente                              : Double;
                               sMoneda_Instrum                                     : String;
                               sMoneda_Conver                                      : String;
                               sEmpresa                                            : String;
                               sTransaccion                                        : String;
                               sFolio_Interno                                      : String;
                               fItem_Omd                                           : Double;
                               var Array_Mem_Desarr                                : TArray_Mem_Desarr;

                               var fMonto_Amort_UM                                 : Double;
                               var fMonto_Amort_MC                                 : Double;
                               var fReajuste_Indexado_Amort                        : Double;
                               var fReajuste_No_Indexado_Amort                     : Double;

                               var fMonto_Amort_Pagado_UM                          : Double;
                               var fMonto_Amort_Pagado_MC                          : Double;
                               var fReajuste_Indexado_Amort_Pagado                 : Double;
                               var fReajuste_No_Indexado_Amort_Pagado              : Double;

                               var fMonto_Capitalizado_UM                          : Double;
                               var fMonto_Capitalizado_MC                          : Double;
                               var fReajuste_Indexado_Capitalizado                 : Double;
                               var fReajuste_No_Indexado_Capitalizado              : Double;

                               var fDiferencia_TC_Amort_Cupon                      : Double;
                               var fDiferencia_TC_Amort_Cupon_Pagado               : Double;
                               var fDiferencia_TC_Capit_Cupon                      : Double;


                               var sModulo_Err                                     : String;
                               var sString_Err                                     : String;
                               var Result                                          : Boolean);

var
  i                      : Integer;
  sCod_Indice_Reajuste   : String;
  Registro_Fechas        : TRegistro_Fechas;
  fNominales_Vendidos    : Double;
  fNominales_Reales      : Double;

  fMonto_Amort_Cupon_UM                : Double;
  fMonto_Amort_Cupon_MC                : Double;
  fReajuste_Indexado_Amort_Cupon       : Double;
  fReajuste_No_Indexado_Amort_Cupon    : Double;

  fMonto_Amort_Cupon_Pagado_UM                : Double;
  fMonto_Amort_Cupon_Pagado_MC                : Double;
  fReajuste_Indexado_Amort_Pagado_Cupon       : Double;
  fReajuste_No_Indexado_Amort_Pagado_Cupon    : Double;

  fReajuste_Indexado_Capit_Cupon              : Double;
  fReajuste_No_Indexado_Capit_Cupon           : Double;

  fMonto_Capit_Cupon_UM                       : Double;
  fMonto_Capit_Cupon_MC                       : Double;
  fDiferencia_tipo_cambio               : Double;
 begin
  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;
  i := 1;
  Result := True;
  fMonto_Amort_UM                                 := 0;
  fMonto_Amort_MC                                 := 0;
  fReajuste_Indexado_Amort                        := 0;
  fReajuste_No_Indexado_Amort                     := 0;
  fMonto_Amort_Pagado_UM                          := 0;
  fMonto_Amort_Pagado_MC                          := 0;
  fReajuste_Indexado_Amort_Pagado                 := 0;
  fReajuste_No_Indexado_Amort_Pagado              := 0;

  fMonto_Capit_Cupon_UM                           := 0;
  fMonto_Capit_Cupon_MC                           := 0;
  fMonto_Capitalizado_UM                          := 0;
  fMonto_Capitalizado_MC                          := 0;
  fReajuste_Indexado_Capitalizado                 := 0;
  fReajuste_No_Indexado_Capitalizado              := 0;

  fMonto_Amort_Cupon_MC                           := 0;
  fReajuste_Indexado_Amort_Cupon                  := 0;
  fReajuste_No_Indexado_Amort_Cupon               := 0;
  fMonto_Amort_Cupon_Pagado_MC                    := 0;
  fReajuste_Indexado_Amort_Pagado_Cupon           := 0;
  fReajuste_No_Indexado_Amort_Pagado_Cupon        := 0;

  fReajuste_Indexado_Capit_Cupon                  := 0;
  fReajuste_No_Indexado_Capit_Cupon               := 0;




  if dFecha_Desde < dFecha_Compra then
     dFecha_Desde := dFecha_Compra;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;

  if RegDes.Base_Conversion = 0 then
     begin
       sString_Err := 'Base Conversión de instrumento no puede ser igual a cero'+#10
                    +RegDes.Codigo_Emisor
                    +'/'
                    +RegDes.Codigo_Instrumento
                    +'/'
                    +RegDes.Serie;
       sModulo_Err := 'Amortización del período';
       Result := False;
       exit;
     end;

  While i = Array_Mem_Desarr[i].Nro_Cupon do
     begin
       if (Array_Mem_Desarr[i].Fecha_Vcto > dFecha_Desde) and
          (Array_Mem_Desarr[i].Fecha_Vcto <= dFecha_Hasta) then
          begin
              if (Array_Mem_Desarr[i].Amortizacion_Original = 0) and
                 (Array_Mem_Desarr[i].Capitalizado_Cupon = 0) then
              begin
                Inc(i);
                Continue;
              end;

              // Valores Necesarios para Reajuste_No_Indexado
              // Es igual para todos los calculos pero diferente
              // para cada cupon ....
              Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[i].Fecha_Vcto;
              if i = 1 then
                 Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
              else
                 Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[i-1].Fecha_Vcto;
              Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[i].Fecha_Vcto;

              // Nuevo disminuye ventas a la fecha de corte
              // Lo hace para determinar amortizaciones realmente pagadas

//              if sValorizacion_Proceso = 'SI' then
                 Determina_Nominales_Vendidos(Array_Mem_Desarr[i].Fecha_Vcto
                                             ,sEmpresa
                                             ,sTransaccion
                                             ,sFolio_interno
                                             ,fItem_Omd
                                             ,fNominales_Vendidos);
//              else
//                 Determina_Nominales_Vendidos_Mem(Array_Mem_Desarr[i].Fecha_Vcto
//                                                 ,Array_Mem_Desarr[i].Fecha_Vcto
//                                                 ,Array_Mem_Desarr[i].Fecha_Vcto
//                                                 ,sEmpresa
//                                                 ,sTransaccion
//                                                 ,sFolio_Interno
//                                                 ,fItem_Omd
//                                                 ,fNominales_Vendidos
//                                                 ,fNoUtilizado
//                                                 ,fNoUtilizado
//                                                 );
              fNominales_Reales := fValor_Nominal_Original - fNominales_Vendidos;

              fMonto_Amort_Cupon_UM := Array_Mem_Desarr[i].Amortizacion_Original *
                                       fValor_Nominal_Vigente /
                                       RegDes.Base_Conversion;

              // Ojo: Discutido con Quezada 19-11-2003
              // Las amortizaciones se reajustan desde fecha de Compra
              // Recordar pagamos por un capital a esa fecha
              fDiferencia_tipo_cambio := 0;
              Reajuste_Valor(sInstrumento
                            ,sMoneda_Instrum
                            ,sMoneda_Conver
                            ,dFecha_Compra                  // Fecha Desde
                            ,Array_Mem_Desarr[i].Fecha_Vcto // Fecha Hasta
                            ,fMonto_Amort_Cupon_UM
                            ,dFecha_Compra
                            ,dFecha_Emision
                            ,RegDes
                            ,Array_Mem_Desarr
                            ,sCod_Indice_Reajuste
                            ,fReajuste_Indexado_Amort_Cupon
                            ,fReajuste_No_Indexado_Amort_Cupon
                            ,fMonto_Amort_Cupon_MC
                            ,fDiferencia_tipo_cambio
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
              if NOT Result then
                 Break;

              fMonto_Amort_UM        := fMonto_Amort_UM +
                                        fMonto_Amort_Cupon_UM;

              fMonto_Amort_MC        := fMonto_Amort_MC +
                                        fMonto_Amort_Cupon_MC;

              fReajuste_Indexado_Amort    := fReajuste_Indexado_Amort +
                                             fReajuste_Indexado_Amort_Cupon;
              fReajuste_No_Indexado_Amort := fReajuste_No_Indexado_Amort +
                                             fReajuste_No_Indexado_Amort_Cupon;

              // Amortizaciones segun nominales vigentes a la fecha de corte
              fMonto_Amort_Cupon_Pagado_UM := Array_Mem_Desarr[i].Amortizacion_Original *
                                              fNominales_Reales /
                                              RegDes.Base_Conversion;

              fDiferencia_tipo_cambio := 0;
              Reajuste_Valor(sInstrumento
                            ,sMoneda_Instrum
                            ,sMoneda_Conver
                            ,dFecha_Compra                  // Fecha Desde
                            ,Array_Mem_Desarr[i].Fecha_Vcto // Fecha Hasta
                            ,fMonto_Amort_Cupon_Pagado_UM
                            ,dFecha_Compra
                            ,dFecha_Emision
                            ,RegDes
                            ,Array_Mem_Desarr
                            ,sCod_Indice_Reajuste
                            ,fReajuste_Indexado_Amort_Pagado_Cupon
                            ,fReajuste_No_Indexado_Amort_Pagado_Cupon
                            ,fMonto_Amort_Cupon_Pagado_MC
                            ,fDiferencia_tipo_cambio
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
              if NOT Result then
                 Break;

              fMonto_Amort_Pagado_UM := fMonto_Amort_Pagado_UM +
                                        fMonto_Amort_Cupon_Pagado_UM;

              fMonto_Amort_Pagado_MC := fMonto_Amort_Pagado_MC +
                                        fMonto_Amort_Cupon_Pagado_MC;

              fReajuste_Indexado_Amort_Pagado :=
                                        fReajuste_Indexado_Amort_Pagado +
                                        fReajuste_Indexado_Amort_Pagado_Cupon;
              fReajuste_No_Indexado_Amort_Pagado_Cupon :=
                                        fReajuste_No_Indexado_Amort_Pagado +
                                        fReajuste_No_Indexado_Amort_Pagado_Cupon;


              // Capitalizaciones
              fMonto_Capit_Cupon_UM :=  Array_Mem_Desarr[i].Capitalizado_Cupon  *
                                        fValor_Nominal_Vigente /
                                        RegDes.Base_Conversion;

              Conversion_unidad_mon(sMoneda_Instrum
                                   ,sMoneda_Conver
                                   ,'BC'
                                   ,Array_Mem_Desarr[i].Fecha_Vcto
                                   ,fMonto_Capit_Cupon_UM
                                   ,fMonto_Capit_Cupon_MC
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);

              if NOT Result then
                 Break;


              fMonto_Capitalizado_UM := fMonto_Capitalizado_UM +
                                        fMonto_Capit_Cupon_UM;

              fMonto_Capitalizado_MC := fMonto_Capitalizado_MC +
                                        fMonto_Capit_Cupon_MC;


          end; // If cupon en el periodo
       Inc(i);
     end; // While
end;
*)
//==============================================================================
procedure Reajuste_Indexado(sMoneda_Original         : String;
                            sMoneda_Conversion       : String;
                            sTipo_Paridad            : String;
                            dFecha_Desde             : TDateTime;
                            dFecha_Hasta             : TDateTime;
                            fValor_Original_UM       : Double;
                            var fValor_Reajustado_MC : Double;
                            var fReajuste            : Double;
                            var sModulo_Err           : String;
                            var sString_Err           : String;
                            var Result               : Boolean);
var
  dValor_Anterior_MC : Double;
  dValor_Actual_MC   : Double;
begin
  if sMoneda_Original = sMoneda_Conversion then
  begin
    fValor_Reajustado_MC := fValor_Original_UM;
    fReajuste            := 0;
    Result               := True;
    exit;
  end;

  Conversion_unidad_mon(sMoneda_Original
                       ,sMoneda_Conversion
                       ,sTipo_Paridad
                       ,dFecha_Desde
                       ,fValor_Original_UM
                       ,dValor_Anterior_MC
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

  if NOT Result then
     Exit;

  Conversion_unidad_mon(sMoneda_Original
                       ,sMoneda_Conversion
                       ,sTipo_Paridad
                       ,dFecha_Hasta
                       ,fValor_Original_UM
                       ,dValor_Actual_MC
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

  if NOT Result then
     Exit;

  fReajuste            := dValor_Actual_MC - dValor_Anterior_MC;
  fValor_Reajustado_MC := dValor_Actual_MC;
end;
//==============================================================================

procedure Reajuste_Valor(sInstrumento              : String;
                         sMoneda_Instrumento       : String;
                         sMoneda_Conver            : String;
                         dFecha_Desde              : TDateTime;
                         dFecha_Hasta              : TDateTime;
                         fValor_Original_UM        : Double;
                         dFecha_Compra             : TDateTime;
                         dFecha_Emision            : TDateTime;
                         RegDes                    : TReg_Descriptor;
                         bConCupon                 : Boolean;
                         var Array_Mem_Desarr      : TArray_Mem_Desarr;
                         var sCod_Indice           : String;
                         var fReajuste_Indexado    : Double;
                         var fReajuste_No_Indexado_UM : Double;
                         var fReajuste_No_Indexado : Double;
                         var fValor_Reajustado_MC  : Double;
                         var fDiferencia_tipo_cambio : Double;
                         var sModulo_Err            : String;
                         var sString_Err            : String;
                         var Result                : Boolean);
var
  fFactor_Reajuste     : Double;
  Registro_Fechas      : TRegistro_Fechas;
  iCupon_Vigente       : Integer;
  fFactorSigno         : Double; // Positivo o Negativo
  //fValor_Reajustado_UM : Double;
  sTipo_Moneda         : String;
  sDescripcion_Moneda  : String;
  sMoneda_Paridad      : String;


  fValor_Segun_Tipo_Cambio_Desde : Double;
  fValor_Segun_Tipo_Cambio_Hasta : Double;
  fValor_a_Compra                : Double;


  sTipo_Instrumento_RVRF         : String;

begin
  fReajuste_Indexado       := 0;
  fReajuste_No_Indexado_UM := 0;
  fReajuste_No_Indexado    := 0;
  fValor_Reajustado_MC     := 0;
  fDiferencia_tipo_cambio  := 0;

  // SI EL MONTO A REAJUSTAR ES NEGATIVO
  // SE LLEVA A POSITIVO PARA LOS CALCULOS PERO SE DEVUELVE NEGATIVO FINALMENTE
  if fValor_Original_UM < 0 then
     fFactorSigno := -1
  else
     fFactorSigno := 1;
  fValor_Original_UM := fValor_Original_UM * fFactorSigno;
//  fReajuste_No_Indexado := 0;
  fReajuste_Indexado    := 0;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;

  fValor_Reajustado_MC := fValor_Original_UM;

  // Se deja de considerar el cupon el dia que corta
  // Ya que debe considerar el reajuste del cupon
  // vigente (NO ES EL QUE CORTO) 22-05-2006 F.I.
  // Detectado con BOGAR2018 (cuando corta el ultimo día)

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Hasta
               ,bConCupon              //           FALSE //True              // Con Cupon
               ,iCupon_Vigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  if iCupon_Vigente = 1 then
     Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
  else
     Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto;

   Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto;

  Reajuste_No_Indexado(RegDes.Codigo_Emisor
                      ,RegDes.Codigo_Instrumento
                      ,RegDes.Serie
                      ,dFecha_Hasta
                      ,Registro_Fechas
                      ,iCupon_Vigente
                      ,fValor_Original_UM
                      ,fFactor_Reajuste
                      ,fReajuste_No_Indexado_UM
                      ,fValor_Reajustado_MC     // fValor_Reajustado_UM
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

  if NOT Result then
      Exit;

  fReajuste_No_Indexado := fReajuste_No_Indexado_UM;

  Datos_Moneda_Mem(sMoneda_Instrumento
                  ,sTipo_Moneda
                  ,sDescripcion_Moneda
                  ,sMoneda_Paridad);

  if NOT Leer_Tipo_Instrumento_Mem(sInstrumento
                                  ,sTipo_Instrumento_RVRF) then
  begin
    sString_Err := 'Error en definición de instrumento ('
                  +sInstrumento
                  +')';
    Result := False;
    exit;
  end;

  fValor_Segun_Tipo_Cambio_Desde := 0;
  fDiferencia_tipo_cambio    := 0;

  // Si la moneda de origen (instrumento) es un indice se entiende que
  // al convertirla se esta reajustando
//  if (sTipo_moneda = 'I') then
//  begin
//     Reajuste_Indexado(sMoneda_Instrumento
//                      ,sMoneda_Paridad
//                      ,'BC'
//                      ,dFecha_Desde
//                      ,dFecha_Hasta
//                      ,fValor_Original_UM
//                      ,fValor_Reajustado_MC
//                      ,fReajuste_Indexado
//                      ,sModulo_Err
//                      ,sString_Err
//                      ,Result);

  if (sTipo_moneda = 'I') then
  begin
     if sMoneda_Instrumento = sMoneda_Conver Then
     begin
        fReajuste_Indexado      := 0;
        fDiferencia_tipo_cambio := 0;
        fValor_Reajustado_MC    := fValor_Reajustado_MC * fFactorSigno;
        exit;
     end
     else
        Reajuste_Indexado(sMoneda_Instrumento
                         ,sMoneda_Paridad
                         ,'BC'
                         ,dFecha_Desde
                         ,dFecha_Hasta
                         ,fValor_Original_UM
                         ,fValor_Reajustado_MC
                         ,fReajuste_Indexado
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);


     if (sTipo_Instrumento_RVRF = 'RV') then
        fReajuste_Indexado := 0;

     // SI moneda paridad es distinta a la moneda se conversion
     // Corresponde diferencia por tipo de cambio
     if sMoneda_Paridad <> sMoneda_Conver then
     begin

       fValor_Segun_Tipo_Cambio_Desde := 0;
       fValor_Segun_Tipo_Cambio_Hasta := 0;
       fValor_a_Compra                := 0;
       //
       // Actualizo valor reajustado y reajuste a la fecha calculo
       //
       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Hasta
                            ,fValor_Reajustado_MC
                            ,fValor_Reajustado_MC
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Hasta
                            ,fReajuste_Indexado
                            ,fReajuste_Indexado
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

// La dif. por tipo Cambio corresponde a la diferencia del valor cpa con la fec desde y ghasta

       // Actualizo valor a fecha Desde
       // OJO: Se paso por la moneda de paridad ya que se necesita el Valor de Compra
       // en moneda de paridad mas abajo
       conversion_unidad_mon(sMoneda_Instrumento
                            ,sMoneda_Paridad
                            ,'BC'
                            ,dFecha_Desde
                            ,fValor_Original_UM
                            ,fValor_a_Compra
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Desde
                            ,fValor_a_Compra
                            ,fValor_Segun_Tipo_Cambio_Desde
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       // Actualizo valor a fecha Hasta
       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Hasta
                            ,fValor_a_Compra
                            ,fValor_Segun_Tipo_Cambio_Hasta
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       fDiferencia_tipo_cambio := (fValor_Segun_Tipo_Cambio_Hasta - fValor_Segun_Tipo_Cambio_Desde);
     end;
  end
  else
  begin
     ////////////////////////////////////////////////////////////////////
     //   Diferencia por Tipo de cambio                                //
     ////////////////////////////////////////////////////////////////////
     if sMoneda_Paridad <> sMoneda_Conver then
     begin
       fValor_Segun_Tipo_Cambio_Desde := 0;
       fValor_Segun_Tipo_Cambio_Hasta := 0;
       fValor_a_Compra                := 0;
       //
       // Actualizo valor reajustado y reajuste a la fecha calculo
       //
       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Hasta
                            ,fValor_Reajustado_MC
                            ,fValor_Reajustado_MC
                            ,sModulo_Err
                            ,sString_Err

                            ,Result);
       if NOT Result then
           Exit;

       if fReajuste_Indexado <> 0 then
       begin
         conversion_unidad_mon(sMoneda_Paridad
                              ,sMoneda_Conver
                              ,'BC'
                              ,dFecha_Hasta
                              ,fReajuste_Indexado
                              ,fReajuste_Indexado
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
         if NOT Result then
             Exit;
       end;

       if fReajuste_No_Indexado_UM <> 0 then
       begin
         conversion_unidad_mon(sMoneda_Paridad
                              ,sMoneda_Conver
                              ,'BC'
                              ,dFecha_Hasta
                              ,fReajuste_No_Indexado_UM
                              ,fReajuste_No_Indexado
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
         if NOT Result then
             Exit;
       end;


// La dif. por tipo Cambio corresponde a la diferencia del valor cpa con la fec desde y ghasta

       // Actualizo valor a fecha Desde
       conversion_unidad_mon(sMoneda_Instrumento
                            ,sMoneda_Paridad
                            ,'BC'
                            ,dFecha_Desde
                            ,fValor_Original_UM
                            ,fValor_a_Compra
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Desde
                            ,fValor_a_Compra
                            ,fValor_Segun_Tipo_Cambio_Desde
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       // Actualizo valor a fecha Desde
       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Hasta
                            ,fValor_a_Compra
                            ,fValor_Segun_Tipo_Cambio_Hasta
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       fDiferencia_tipo_cambio := (fValor_Segun_Tipo_Cambio_Hasta - fValor_Segun_Tipo_Cambio_Desde);
     end;
  end;
  // Lo dejo con el signo original !!!

  // Faltaba cambiar el La Dif TC  06-06-2012 F.I.
  fDiferencia_tipo_cambio := fDiferencia_tipo_cambio   * fFactorSigno;

  fValor_Reajustado_MC  := fValor_Reajustado_MC        * fFactorSigno;
  fReajuste_Indexado    := fReajuste_Indexado          * fFactorSigno;
  fReajuste_No_Indexado := fReajuste_No_Indexado       * fFactorSigno;
  fReajuste_No_Indexado_UM := fReajuste_No_Indexado_UM * fFactorSigno;

end;

(*
procedure Reajuste_Valor(sInstrumento              : String;
                         sMoneda_Instrumento       : String;
                         sMoneda_Conver            : String;
                         dFecha_Desde              : TDateTime;
                         dFecha_Hasta              : TDateTime;
                         fValor_Original_UM        : Double;
                         dFecha_Compra             : TDateTime;
                         dFecha_Emision            : TDateTime;
                         RegDes                    : TReg_Descriptor;
                         var Array_Mem_Desarr      : TArray_Mem_Desarr;
                         var sCod_Indice           : String;
                         var fReajuste_Indexado    : Double;
                         var fReajuste_No_Indexado : Double;
                         var fValor_Reajustado_MC  : Double;
                         var fDiferencia_tipo_cambio : Double;
                         var sModulo_Err            : String;
                         var sString_Err            : String;
                         var Result                : Boolean);
var
  fFactor_Reajuste     : Double;
  Registro_Fechas      : TRegistro_Fechas;
  iCupon_Vigente       : Integer;
  fFactorSigno         : Double; // Positivo o Negativo
  fValor_Reajustado_UM : Double;
  sTipo_Moneda         : String;
  sDescripcion_Moneda  : String;
  sMoneda_Paridad      : String;


  fValor_Segun_Tipo_Cambio_Desde : Double;
  sTipo_Instrumento_RVRF         : String;


begin
  // SI EL MONTO A REAJUSTAR ES NEGATIVO
  // SE LLEVA A POSITIVO PARA LOS CALCULOS PERO SE DEVUELVE NEGATIVO FINALMENTE
  if fValor_Original_UM < 0 then
     fFactorSigno := -1
  else
     fFactorSigno := 1;
  fValor_Original_UM := fValor_Original_UM * fFactorSigno;
  fReajuste_No_Indexado := 0;
  fReajuste_Indexado    := 0;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;

  fValor_Reajustado_MC := fValor_Original_UM;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Hasta
               ,True              // Con Cupon
               ,iCupon_Vigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  if iCupon_Vigente = 1 then
     Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
  else
     Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto;

   Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto;

  Reajuste_No_Indexado(RegDes.Codigo_Emisor
                      ,RegDes.Codigo_Instrumento
                      ,RegDes.Serie
                      ,dFecha_Hasta
                      ,Registro_Fechas
                      ,iCupon_Vigente
                      ,fValor_Original_UM
                      ,fFactor_Reajuste
                      ,fReajuste_No_Indexado
                      ,fValor_Reajustado_MC     // fValor_Reajustado_UM
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

  if NOT Result then
      Exit;

  if sMoneda_Paridad <> sMoneda_Conver then
     conversion_unidad_mon(sMoneda_Instrumento
                          ,sMoneda_Conver
                          ,'BC'
                          ,dFecha_Hasta
                          ,fReajuste_No_Indexado
                          ,fReajuste_No_Indexado
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
  if NOT Result then
      Exit;

  Datos_Moneda_Mem(sMoneda_Instrumento
                  ,sTipo_Moneda
                  ,sDescripcion_Moneda
                  ,sMoneda_Paridad);

  if NOT Leer_Tipo_Instrumento(sInstrumento
                              ,sTipo_Instrumento_RVRF) then
  begin
    sString_Err := 'Error en definición de instrumento ('
                  +sInstrumento
                  +')';
    Result := False;
    exit;
  end;

  fValor_Segun_Tipo_Cambio_Desde := 0;
  fDiferencia_tipo_cambio    := 0;

  // Si la moneda de origen (instrumento) es un indice se entiende que
  // al convertirla se esta reajustando
  if (sTipo_moneda = 'I') and (sTipo_Instrumento_RVRF <> 'RV') then
  begin
     Reajuste_Indexado(sMoneda_Instrumento
                      ,sMoneda_Paridad
                      ,'BC'
                      ,dFecha_Desde
                      ,dFecha_Hasta
                      ,fValor_Original_UM
                      ,fValor_Reajustado_MC
                      ,fReajuste_Indexado
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);
     // SI moneda paridad es distinta a la moneda se conversion
     // Corresponde diferencia por tipo de cambio
     if sMoneda_Paridad <> sMoneda_Conver then
     begin
       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Hasta
                            ,fReajuste_Indexado
                            ,fReajuste_Indexado
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;


       // Actualizo valor a fecha calculo
       conversion_unidad_mon(sMoneda_Paridad
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Hasta
                            ,fValor_Reajustado_MC
                            ,fValor_Reajustado_MC
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       // Actualizo valor a fecha Desde
       conversion_unidad_mon(sMoneda_Instrumento
                            ,sMoneda_Conver
                            ,'BC'
                            ,dFecha_Desde
                            ,fValor_Original_UM
                            ,fValor_Segun_Tipo_Cambio_Desde
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
       if NOT Result then
           Exit;

       fDiferencia_tipo_cambio := fValor_Reajustado_MC - fValor_Segun_Tipo_Cambio_Desde;
     end;
  end
  else
  begin
     ////////////////////////////////////////////////////////////////////
     //   Diferencia por Tipo de cambio                                //
     ////////////////////////////////////////////////////////////////////
     conversion_unidad_mon(sMoneda_Instrumento
                          ,sMoneda_Conver
                          ,'BC'
                          ,dFecha_Desde
                          ,fValor_Reajustado_MC
                          ,fValor_Segun_Tipo_Cambio_Desde
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
     if NOT Result then
         Exit;

     // Actualizo valor a fecha calculo
     conversion_unidad_mon(sMoneda_Instrumento
                          ,sMoneda_Conver
                          ,'BC'
                          ,dFecha_Hasta
                          ,fValor_Reajustado_MC
                          ,fValor_Reajustado_MC
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
     if NOT Result then
         Exit;

     fDiferencia_tipo_cambio := fValor_Reajustado_MC - fValor_Segun_Tipo_Cambio_Desde;
  end;
  // Lo dejo con el signo original !!!
  fValor_Reajustado_MC  := fValor_Reajustado_MC * fFactorSigno;
  fReajuste_Indexado    := fReajuste_Indexado * fFactorSigno;
  fReajuste_No_Indexado := fReajuste_No_Indexado * fFactorSigno;

end;
*)
{
procedure Reajuste_Valor(sInstrumento              : String;
                         sMoneda_Instrumento       : String;
                         sMoneda_Conver            : String;
                         dFecha_Desde              : TDateTime;
                         dFecha_Hasta              : TDateTime;
                         fValor_Original_UM        : Double;
                         dFecha_Compra             : TDateTime;
                         dFecha_Emision            : TDateTime;
                         RegDes                    : TReg_Descriptor;
                         var Array_Mem_Desarr      : TArray_Mem_Desarr;
                         var sCod_Indice           : String;
                         var fReajuste_Indexado    : Double;
                         var fReajuste_No_Indexado : Double;
                         var fValor_Reajustado_MC  : Double;
                         var sModulo_Err            : String;
                         var sString_Err            : String;
                         var Result                : Boolean);
var
  fFactor_Reajuste     : Double;
  Registro_Fechas      : TRegistro_Fechas;
  iCupon_Vigente       : Integer;
  fFactorSigno         : Double; // Positivo o Negativo
  fValor_Reajustado_UM : Double;
  sTipo_Moneda         : String;
  sDescripcion_Moneda  : String;
  sMoneda_Paridad      : String;


begin
  // SI EL MONTO A REAJUSTAR ES NEGATIVO
  // SE LLEVA A POSITIVO PARA LOS CALCULOS PERO SE DEVUELVE NEGATIVO FINALMENTE
  if fValor_Original_UM < 0 then
     fFactorSigno := -1
  else
     fFactorSigno := 1;
  fValor_Original_UM := fValor_Original_UM * fFactorSigno;
  fReajuste_No_Indexado := 0;
  fReajuste_Indexado    := 0;

  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;

  fValor_Reajustado_MC := fValor_Original_UM;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFecha_Hasta
               ,True              // Con Cupon
               ,iCupon_Vigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  if iCupon_Vigente = 1 then
     Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
  else
     Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon_Vigente-1].Fecha_Vcto;

   Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCupon_Vigente].Fecha_Vcto;
  Reajuste_No_Indexado(RegDes.Codigo_Emisor
                      ,RegDes.Codigo_Instrumento
                      ,RegDes.Serie
                      ,dFecha_Hasta
                      ,Registro_Fechas
                      ,iCupon_Vigente
                      ,fValor_Original_UM
                      ,fFactor_Reajuste
                      ,fReajuste_No_Indexado
                      ,fValor_Reajustado_UM
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

  if NOT Result then
      Exit;

  Datos_Moneda_Mem(sMoneda_Instrumento
                  ,sTipo_Moneda
                  ,sDescripcion_Moneda
                  ,sMoneda_Paridad);

  if sMoneda_Instrumento <> sMoneda_Conversion then
  // Si la moneda de origen (instrumento) es un indice se entiende que
  // al convertirla se esta reajustando
  if sTipo_moneda = 'I' then
     Reajuste_Indexado(sMoneda_Instrumento
                      ,sMoneda_Conver
                      ,'BC'
                      ,dFecha_Desde
                      ,dFecha_Hasta
                      ,fValor_Original_UM
                      ,fValor_Reajustado_MC
                      ,fReajuste_Indexado
                      ,sModulo_Err
                      ,sString_Err
                      ,Result)
  else
     // Si la moneda de origen (instrumento) es una moneda debe tomarse
     // el valor UM reajustado antes de convertirla
     begin
     conversion_unidad_mon(sMoneda_Instrumento
                          ,sMoneda_Conver
                          ,'BC'
                          ,dFecha_Hasta
                          ,fValor_Reajustado_UM
                          ,fValor_Reajustado_MC
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
     if NOT Result then
         Exit;

     conversion_unidad_mon(sMoneda_Instrumento
                          ,sMoneda_Conver
                          ,'BC'
                          ,dFecha_Hasta
                          ,fReajuste_No_Indexado
                          ,fReajuste_No_Indexado
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

     end;


  // Lo dejo con el signo original !!!
  fValor_Reajustado_MC  := fValor_Reajustado_MC * fFactorSigno;
  fReajuste_Indexado    := fReajuste_Indexado * fFactorSigno;
  fReajuste_No_Indexado := fReajuste_No_Indexado * fFactorSigno;

end;
}
//==============================================================================
procedure Accrued_Interest(sTipo_Instrumento                            : String;
                           sEmisor                                      : String;
                           sInstrumento                                 : String;
                           sSerie                                       : String;
                           sNemotecnico                                 : String;
                           fTasaEmision                                 : Double;
                           fTasaCalculo                                 : Double;
                           sUnidadMonetaria                             : String;
                           sTipoNominales                               : String;
                           dFecha_Emision                               : TDateTime;
                           dFecha_Vencimiento                           : TDateTime;
                           dFecha_Compra                                : TDateTime;
                           dFecha_Operacion                             : TDateTime;
                           dFecha_Pago                                  : TDateTime;
                           fCupones_Cortados                            : Double;
                           sMoneda_Conversion                           : String;
                           fNominales                                   : Double;
                           dFecha_Desde                                 : TDateTime;
                           dFecha_Hasta                                 : TDateTime;
                           sTabla_Desarr_Cargada                        : String;
                           sDescriptor_Cargado                          : String;
                           var RegDes                                   : TReg_Descriptor;
                           var Array_Mem_Desarr                         : TArray_Mem_Desarr;
                           var fInteres_Accrued_Pagado_UM               : Double;
                           var fInteres_Accrued_Pagado_MC               : Double;
                           var fInteres_Accrued_Devengado_UM            : Double;
                           var fInteres_Accrued_Devengado_MC            : Double;
                           var fReajuste_Interes_Pagado_Periodo         : Double;
                           var fReajuste_Interes_Devengado_Periodo      : Double;
                           var sModulo_Err                              : String;
                           var sString_Err                              : String;
                           var Result                                   : Boolean
                           );
var
  fInteres_Acum_UM                           : Double;
  fInteres_Acum_MC                           : Double;
  dAux_Fecha_Hasta                           : Double;
  iCuponVigente                              : Integer;
  fInteres_Acum_UM_Reajustado                : Double;
  fRea_Acum_Anterior                         : Double;
  fRea_Acum_Actual                           : Double;
  fReajuste_Periodo                          : Double;

begin
     fInteres_Acum_UM    := 0;
     fInteres_Acum_MC    := 0;
     fInteres_Accrued_Pagado_UM               := 0;
     fInteres_Accrued_Pagado_MC               := 0;
     fInteres_Accrued_Devengado_UM            := 0;
     fInteres_Accrued_Devengado_MC            := 0;
     fReajuste_Interes_Pagado_Periodo         := 0;
     fReajuste_Interes_Devengado_Periodo      := 0;

     // Agregado con fecha 02/01/2006 (F.I.)
     // Solo se comienza a devengar desde la fecha de emision
     // Para el caso de compras antes de esa fecha estaba dando un error.
     if dFecha_Desde < dFecha_Emision then
        dFecha_Desde := dFecha_Emision;

     // Busca siguiente vencimiento despues de la Fecha_desde
     Cupon_Vigente(Array_Mem_Desarr,
                   RegDes,
                   dFecha_Desde,
                   False,
                   iCuponVigente,
                   sModulo_Err,
                   sString_Err,
                   Result);

     if NOT Result then
        exit;

     dAux_Fecha_Hasta := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
     // Acumula intereses percibidos por cada cupon
     // Cuyo vencimiento este en el periodo calculado
     while (Array_Mem_Desarr[iCuponVigente].nro_cupon = iCuponVigente) Do
       Begin
         if dFecha_Desde >= dFecha_Hasta then
            Break;

         if dAux_Fecha_Hasta < dFecha_Hasta Then
            dAux_Fecha_Hasta := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto
         else
            dAux_Fecha_Hasta := dFecha_Hasta;

         Intereses_Acumulados(sTipo_Instrumento
                             ,sEmisor
                             ,sInstrumento
                             ,sSerie
                             ,sNemotecnico
                             ,fTasaEmision
                             ,fTasaCalculo
                             ,sUnidadMonetaria
                             ,sTipoNominales
                             ,dFecha_Emision
                             ,dFecha_Vencimiento
                             ,dFecha_Compra
                             ,dFecha_Operacion
                             ,dFecha_Pago
                             ,sMoneda_Conversion
                             ,fCupones_Cortados
                             ,fNominales
                             ,dFecha_Desde
                             ,dAux_Fecha_Hasta
                             ,sDescriptor_Cargado
                             ,sTabla_Desarr_Cargada
                             ,RegDes
                             ,Array_Mem_Desarr
                             ,fInteres_Acum_UM
                             ,fInteres_Acum_MC
                             ,fInteres_Acum_UM_Reajustado
                             ,fRea_Acum_Anterior
                             ,fRea_Acum_Actual
                             ,fReajuste_Periodo
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

         if NOT Result then
            exit;
         // Si Cupon esta pagado en el periodo !!! EL reajuste es pagado
         // Caso contrario es reajuste devengado
         if dAux_Fecha_Hasta = Array_Mem_Desarr[iCuponVigente].Fecha_Vcto then
         begin
           // Debo descontar de los intereses pagados la parte capitalizada (si existe)
           {
           fInteres_Acum_UM := fInteres_Acum_UM - (fInteres_Acum_UM *
                                                   Array_Mem_Desarr[iCuponVigente].Factor_Cap);
           fInteres_Acum_MC := fInteres_Acum_MC - (fInteres_Acum_MC *
                                                   Array_Mem_Desarr[iCuponVigente].Factor_Cap);
           fReajuste_Periodo := fReajuste_Periodo - (fReajuste_Periodo *
                                                     Array_Mem_Desarr[iCuponVigente].Factor_Cap);
           }
           fInteres_Accrued_Pagado_UM := fInteres_Accrued_Pagado_UM +
                                         fInteres_Acum_UM;
           fInteres_Accrued_Pagado_MC := fInteres_Accrued_Pagado_MC +
                                         fInteres_Acum_MC;
           fReajuste_Interes_Pagado_Periodo := fReajuste_Interes_Pagado_Periodo +
                                               fReajuste_Periodo;
         end
         else
         begin
           fInteres_Accrued_Devengado_UM := fInteres_Accrued_Devengado_UM +
                                         fInteres_Acum_UM;
           fInteres_Accrued_Devengado_MC := fInteres_Accrued_Devengado_MC +
                                            fInteres_Acum_MC;
           fReajuste_Interes_Devengado_Periodo := fReajuste_Interes_Devengado_Periodo +
                                                  fReajuste_Periodo;
         end;

         dFecha_Desde  := dAux_Fecha_Hasta;
         iCuponVigente := iCuponVigente + 1;
         dAux_Fecha_Hasta := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
       End; // End While
end;
//==============================================================================
// NOOOOOOOOOOOOOOOOO
// ESTABA MALOOOOOOO
// NO LO DEBIA HACER CON NOMINALES VIGENTES de cada cupon solo por los vigentes a la fecha
// YA QUE LOS PAGOS DE INTERESES Y AMORTIZACIONES SALIERON POR CADA VENTA !!!!
// El resto sale en el el libro de ventas complementario (Acuerdate: Claudio, Quezada y Filigara)
// 03-12-2003
//
// Diferencia de interes Pagado (Calculado sobre nominales vigentes
// a la fecha de corte del cupón
// a interes calculado sobre los nominales informados vigentes a la fecha
procedure Interes_Cupones_Periodo_Para_OMD_Item(sCartera              : String;
                                                sEmpresa              : String;
                                                sTransaccion          : String;
                                                sFolio_interno        : String;
                                                fItem_Omd             : Double;
                                                dFecha_Desde          : TDateTime;
                                                dFecha_Hasta          : TDateTime;
                                                dFecha_Compra         : TDateTime;
                                                dFecha_Pago           : TDateTime;
                                                dFecha_Emision        : TDateTime;
                                                sInstrumento          : String;
                                                sMoneda_Instrumento   : String;
                                                sMoneda_Conversion    : String;
                                                fNominales            : Double;
                                                RegDes                : TReg_Descriptor;
                                                Array_Mem_Desarr      : TArray_Mem_Desarr;
                                                sTipo_Instrumento     : String;
                                                sNemotecnico          : String;
                                                fTasaEmision          : Double;
                                                fTasaCalculo          : Double;
                                                sTipoNominales        : String;
                                                dFecha_Vencimiento     : TDateTime;
                                                var fInteres_UM_Pagado : Double;
                                                var fInteres_MC_Pagado : Double;
                                                var fReajuste_No_Indexado_Pagado : Double;
                                                var fReajuste_Indexado_Pagado    : Double;
                                                var fReajuste_Capital_Pagado_UM  : Double;
                                                var fReajuste_Capital_Pagado_MC  : Double;
                                                var sModulo_Err       : String;
                                                var sString_Err       : String;
                                                var Result            : Boolean);
var
  iCupon                  : Integer;
  Registro_Fechas         : TRegistro_Fechas;
  // fReajuste            : Double;
  // fFactor_Reajuste     : Double;
  Aux_Interes             : Double;
  Aux_Reajuste_Indexado   : Double;
  Aux_Reajuste_No_Indexado: Double;
  Aux_Reajuste_No_Indexado_UM : Double;
  Aux_Reajuste_Capital_Pagado_UM : Double;
  Aux_Reajuste_Capital_Pagado_MC : Double;
  sCodigo_Indice_Reajuste : String;

   Reg_Formula_PAR             : TRegFormulaPAR;
   Reg_Formula_TIR             : TRegFormulaTIR;

   Reg_Val_In              : TRegistro_Valoriza_In;
   Reg_Val_Out             : TRegistro_Valoriza_Out;
   fValor_Par_Cierre_Actual_MC : Double;
   fDiferencia_tipo_cambio     : Double;


begin

//  if sValorizacion_Proceso = 'SI' then
     carga_parametros_formulas_mem(RegDes.Cod_Calc_PAR_D
                              ,RegDes.Cod_Calc_TIR_D
                              ,Reg_Formula_PAR
                              ,Reg_Formula_TIR
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
  {
  else
     { Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.
     carga_parametros_formulas(RegDes.Cod_Calc_PAR_D
                              ,RegDes.Cod_Calc_TIR_D
                              ,Reg_Formula_PAR
                              ,Reg_Formula_TIR
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
  }
  // Lo hace asi por el BR !!!!
  Result := True;

  if (Reg_Formula_PAR.Valoriza_Acumulado = 'S') then
  begin
    if (dFecha_Hasta = dFecha_Vencimiento) then
      begin
        Reg_Val_In.Tipo_Instrumento   := sTipo_Instrumento;
        Reg_Val_In.sEmisor            := RegDes.Codigo_Emisor;
        Reg_Val_In.sInstrumento       := sInstrumento;
        Reg_Val_In.sSerie             := RegDes.Serie;
        Reg_Val_In.Nemotecnico        := sNemotecnico;
        Reg_Val_In.dTasaEmision       := fTasaEmision;
        Reg_Val_Out.TasaCalculo       := fTasaCalculo;
        Reg_Val_In.sUnidadMonetaria   := sMoneda_Instrumento;
        Reg_Val_In.sTipoNominales     := sTipoNominales;
        Reg_Val_In.dFechaEmision      := dFecha_Emision;
        Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
        Reg_Val_In.dFechaCalculo      := dFecha_Hasta;       // Fecha de Calculo
        Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
        Reg_Val_In.dFechaPago         := dFecha_Pago;
        Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
        Reg_Val_In.Con_Cupon          := True;
        Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
        Reg_Val_Out.Nominales         := fNominales;
        //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
        Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
        Reg_Val_Out.RegDes            := RegDes;
        Reg_Val_In.dFechaCompra       := dFecha_Compra;

        Valoriza_Registro(Reg_Val_In,
                          Reg_Val_Out,
                          sModulo_Err,
                          sString_Err,
                          Result);

        fValor_Par_Cierre_Actual_MC := Reg_Val_Out.Valor_Par_MC;

        if NOT Result then
           exit;


        Conversion_unidad_mon(sMoneda_Instrumento
                             ,sMoneda_Conversion
                             ,'BC'
                             ,dFecha_Hasta
                             ,fNominales
                             ,fNominales
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

        fInteres_MC_Pagado := fValor_Par_Cierre_Actual_MC - fNominales;
      end
    else
      fInteres_MC_Pagado := 0;

    exit;
  end;


  fInteres_UM_Pagado       := 0;
  fInteres_MC_Pagado       := 0;
  fReajuste_Capital_Pagado_UM := 0;
  fReajuste_Capital_Pagado_MC := 0;
  Aux_Interes              := 0;
  Aux_Reajuste_Indexado    := 0;
  Aux_Reajuste_No_Indexado := 0;

  //Aux_Reajuste_Capital_Pagado_UM  := 0;
  Aux_Reajuste_Capital_Pagado_MC  := 0;

  fReajuste_No_Indexado_Pagado := 0;
  fReajuste_Indexado_Pagado    := 0;



  Registro_Fechas.Fecha_Emision := dFecha_Emision;
  Registro_Fechas.Fecha_Compra  := dFecha_Compra;
  Registro_Fechas.Fecha_Calculo := dFecha_Hasta;

  For iCupon := 1 to Max_Nro_Cupones do
     begin
       if Array_Mem_Desarr[iCupon].Nro_Cupon <> iCupon then
          Break;

       if (Array_Mem_Desarr[iCupon].Fecha_Vcto >  dFecha_Desde ) AND
          (Array_Mem_Desarr[iCupon].Fecha_Vcto >  dFecha_Compra ) AND
          (Array_Mem_Desarr[iCupon].Fecha_Vcto <= dFecha_Hasta) then
       begin
         Aux_Interes := (Array_Mem_Desarr[iCupon].Interes_Original *
                         fNominales /
                         RegDes.BASE_CONVERSION);

         Aux_Reajuste_Capital_Pagado_UM := ( Array_Mem_Desarr[iCupon].Reajuste_Capital_Pagado *
                                             fNominales /
                                             RegDes.BASE_CONVERSION);

         fReajuste_Capital_Pagado_UM := fReajuste_Capital_Pagado_UM + Aux_Reajuste_Capital_Pagado_UM;

         Conversion_unidad_mon( sMoneda_Instrumento
                               ,sMoneda_Conversion
                               ,'BC'
                               ,Array_Mem_Desarr[iCupon].Fecha_Vcto
                               ,Aux_Reajuste_Capital_Pagado_UM
                               ,Aux_Reajuste_Capital_Pagado_MC
                               ,sModulo_Err
                               ,sString_Err
                               ,Result);
         if NOT Result then
            Break;

         fReajuste_Capital_Pagado_MC := fReajuste_Capital_Pagado_MC + Aux_Reajuste_Capital_Pagado_MC;

         Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[iCupon].Fecha_Vcto;
         if iCupon = 1 then
            Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision
         else
            Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon-1].Fecha_Vcto;
         Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCupon].Fecha_Vcto;

         // Ojo: Discutido con Quezada 19-11-2003
         // Los intereses se reajustan desde Ultimo Vencimiento
         // Recordar efecto curva de interes (llega a 0 todos los cortes)
         fDiferencia_tipo_cambio := 0;
         Reajuste_Valor(sInstrumento
                       ,sMoneda_Instrumento
                       ,sMoneda_Conversion
                       ,Registro_Fechas.Fecha_Inic_Periodo      //dFecha_Desde
                       ,Registro_Fechas.Fecha_Vcto_Periodo      //dFecha_Hasta
                       ,Aux_Interes
                       ,dFecha_Compra
                       ,dFecha_Emision
                       ,RegDes
                       ,True             // bConCupon Se incorpora 05-07-2006
                       ,Array_Mem_Desarr
                       ,sCodigo_Indice_Reajuste
                       ,Aux_Reajuste_Indexado
                       ,Aux_Reajuste_No_Indexado_UM
                       ,Aux_Reajuste_No_Indexado
                       ,Aux_Interes
                       ,fDiferencia_tipo_cambio
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

           if NOT Result then
              Break;

         fReajuste_No_Indexado_Pagado := fReajuste_No_Indexado_Pagado +
                                         Aux_Reajuste_No_Indexado;
         fReajuste_Indexado_Pagado    := fReajuste_Indexado_Pagado +
                                         Aux_Reajuste_Indexado;
         // Como estoy reajustando tanto por indexado como por No Indexado
         // Automaticamente los valores pasan a MC
         // Ejemplo: Si instrumento en UF el Valor reajustado es iguasl al valor en pesos
         // a la fecha
         fInteres_MC_Pagado := fInteres_MC_Pagado + Aux_Interes;
       end;
     end;
end;

// ESTA FUNCION SOLO SE ESTA USANDO EN COLOMBIA !!!
// DEBE SACARSE DE AHI YA QUE NO SIRVE
// Y REEMPLAZARSE POR INTERESES PARA OMD ITEM Y AMORTIZACION PERIODO
procedure Interest_91_92(sTipo_Instrumento   : String;
                         sEmisor             : String;
                         sInstrumento        : String;
                         sSerie              : String;
                         sNemotecnico        : String;
                         fTasaEmision        : Double;
                         fTasaCalculo        : Double;
                         sUnidadMonetaria    : String;
                         sTipoNominales      : String;
                         dFecha_Emision       : TDateTime;
                         dFecha_Vencimiento   : TDateTime;
                         dFecha_Compra        : TDateTime;
                         sMoneda_Conversion  : String;
                         dFechaCierreActual  : TDateTime;
                         dFechaCierreAnterior: TDateTime;
                         fNominales           : Double;
                         sTabla_Desarr_Cargada: String;
                         var RegDes           : TReg_Descriptor;
                         var Array_Mem_Desarr : TArray_Mem_Desarr;
                         var Interest_91      : Double;
                         var Interest_92      : Double;
                         var sModulo_Err      : String;
                         var sString_Err      : String;
                         var Result           : Boolean);
var

   Reg_Formula_PAR             : TRegFormulaPAR;
   Reg_Formula_TIR             : TRegFormulaTIR;
   fValor_Par_Cierre_Actual_MC      : Double;
   fValor_Par_UM      : Double;
   fValor_Par_UM_FecCierreAct : Double;
   iCuponVigente      : Integer;
   dFechaUltVcto      : TDateTime;
   dAuxFecCalculo     : TDateTime;
//   fBaseConver        : Double;
   fInteres_MC        : Double;

   Reg_Val_In         : TRegistro_Valoriza_In;
   Reg_Val_Out        : TRegistro_Valoriza_Out;
begin
  // Obtengo valor PAR a fecha de cierre actual
  Interest_91 := 0;
  Interest_92 := 0;

  Reg_Val_In.Tipo_Instrumento   := sTipo_Instrumento;
  Reg_Val_In.sEmisor            := sEmisor;
  Reg_Val_In.sInstrumento       := sInstrumento;
  Reg_Val_In.sSerie             := sSerie;
  Reg_Val_In.Nemotecnico        := sNemotecnico;
  Reg_Val_In.dTasaEmision       := fTasaEmision;
  Reg_Val_Out.TasaCalculo       := fTasaCalculo;
  Reg_Val_In.sUnidadMonetaria   := sUnidadMonetaria;
  Reg_Val_In.sTipoNominales     := sTipoNominales;
  Reg_Val_In.dFechaEmision      := dFecha_Emision;
  Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
  Reg_Val_In.dFechaCalculo      := dFechaCierreActual;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
  Reg_Val_In.Con_Cupon          := True;
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR
  Reg_Val_Out.Nominales         := fNominales;
  //Reg_Val_Out.Array_Mem_Desarr  := Array_Mem_Desarr; 12-09-2022
  Reg_Val_Out.Array_Mem_Desarr  := copy(Array_Mem_Desarr);
  Reg_Val_Out.RegDes            := RegDes;
  Reg_Val_In.dFechaCompra       := dFecha_Compra;

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fValor_Par_UM_FecCierreAct  := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste;
  fValor_Par_Cierre_Actual_MC := Reg_Val_Out.Valor_Par_MC;
  Array_Mem_Desarr            := Reg_Val_Out.Array_Mem_Desarr;
  RegDes                      := Reg_Val_Out.RegDes;

  if NOT Result then
     exit;

  // Obtengo ultimo vencimiento
  RegDes.Codigo_Emisor      := sEmisor;
  RegDes.Codigo_Instrumento := sInstrumento;
  RegDes.Serie              := sSerie;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,dFechaCierreActual
               ,True              // Con Cupon
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  if iCuponVigente = 1 then
     dFechaUltVcto := dFecha_Emision
  else
     dFechaUltVcto := Array_Mem_Desarr[iCuponVigente-1].Fecha_Vcto;

  dAuxFecCalculo := dFechaCierreAnterior;

  if dFechaUltVcto > dAuxFecCalculo then
     dAuxFecCalculo := dFechaUltVcto;

  if dFecha_Compra > dAuxFecCalculo then
     dAuxFecCalculo := dFecha_Compra;

  // Calculo Valor PAR a la mayor fecha anterior al cierre actual ya sea:
  //      - Fecha de ultimo vencimiento
  //      - Fecha de emisión
  //      - Fecha ultimo cierre
  // (Viene en dAuxFecCalculo

  Reg_Val_In.dFechaCalculo      := dAuxFecCalculo;       // Fecha de Calculo
  Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
  Reg_Val_In.Con_Cupon          := False;
  Reg_Val_In.Valoriza_Par_Pte   := 'PAR';  // Solo calcula valor PAR

  Valoriza_Registro(Reg_Val_In,
                    Reg_Val_Out,
                    sModulo_Err,
                    sString_Err,
                    Result);

  fValor_Par_UM     := Reg_Val_Out.Valor_Par_UM_Sin_Reajuste;
  Array_Mem_Desarr  := Reg_Val_Out.Array_Mem_Desarr;
  RegDes            := Reg_Val_Out.RegDes;

  if NOT Result then
     exit;

  Conversion_unidad_mon(sUnidadMonetaria
                       ,sMoneda_Conversion
                       ,'BC'
                       ,dFechaCierreActual
                       ,(fValor_Par_UM_FecCierreAct - fValor_Par_UM)
                       ,Interest_91
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

  if NOT Result then
     exit;

  //Para determinar los intereses pagados en valorizacion acumulada
  //if sValorizacion_Proceso = 'SI' then
     carga_parametros_formulas_mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                              ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                              ,Reg_Formula_PAR
                              ,Reg_Formula_TIR
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
  {
  else
   { Reemplazado por "carga_parametros_formulas_Mem" 05-03-2018 F.I.

     carga_parametros_formulas(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                              ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                              ,Reg_Formula_PAR
                              ,Reg_Formula_TIR
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
  }
  // se deja en true para el caso de los BR que no tienen formula real ....
  Result := True;

  if (Reg_Formula_PAR.Valoriza_Acumulado = 'S') then
  begin
    if (dFechaCierreActual = dFecha_Vencimiento) then
      begin
        Conversion_unidad_mon(sUnidadMonetaria
                             ,sMoneda_Conversion
                             ,'BC'
                             ,dFechaCierreActual
                             ,fNominales
                             ,fNominales
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

        Interest_92 := fValor_Par_Cierre_Actual_MC - fNominales;
      end
    else
      Interest_92 := 0;

    exit;
  end;


  Interest_92 := 0;
  iCuponVigente := 1;
//  fBaseConver   := 0;
  While iCuponVigente  = Array_Mem_Desarr[iCuponVigente].Nro_Cupon do
     begin
//       fBaseConver := fBaseConver + Array_Mem_Desarr[iCuponVigente].Amortizacion;
       if (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto > dFechaCierreAnterior) AND
          (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto > dFecha_Compra        ) AND
          (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto <= dFechaCierreActual) then
           begin
             Conversion_unidad_mon(sUnidadMonetaria
                                  ,sMoneda_Conversion
                                  ,'BC'
                                  ,Array_Mem_Desarr[iCuponVigente].Fecha_Vcto
                                  ,Array_Mem_Desarr[iCuponVigente].Interes
                                  ,fInteres_MC
                                  ,sModulo_Err
                                  ,sString_Err
                                  ,Result);

             if NOT Result then
                exit;

             Interest_92 := Interest_92 + fInteres_MC;
           end;
       inc(iCuponVigente);
     end;

  Interest_92 := (fNominales * Interest_92) / RegDes.BASE_CONVERSION;

end;

procedure Paid_For_Accrued_Vigente(dFecha_Cierre_Anterior_Ant   : TDateTime;
                                   dFecha_Cierre_Anterior_Act   : TDateTime;
                                   sTipo_Instrum                : String;
                                   sEmisor                      : String;
                                   sInstrumento                 : String;
                                   sSerie                       : String;
                                   sNemotecnico                 : String;
                                   fTasa_Emision                : Double;
                                   fTasa_Compra                 : Double;
                                   sMoneda_Instrum              : String;
                                   sTipo_Nominales              : String;
                                   dFecha_Emision               : TDateTime;
                                   dFecha_Vencimiento           : TDateTime;
                                   dFecha_Compra                : TDateTime;
                                   dFecha_Pago_Compra           : TDateTime;
                                   sMoneda_Conversion           : String;
                                   fCupones_Cortados            : Double;
                                   fNominales                   : Double;
                                   sTabla_Desarr_Cargada        : String;
                                   RegDes                       : TReg_Descriptor;
                                   Array_Mem_Desarr             : TArray_Mem_Desarr;
                                   var dPaid_For_Accrued_Vigente_Ant: Double;
                                   var dPaid_For_Accrued_Vigente_Act: Double;
                                   var sModuloErr                   : String;
                                   var sStringErr                   : String;
                                   var bResult                      : Boolean);
var
 iCuponVigente                   : Integer;
 dAux_Fecha_Hasta                : TDateTime;
 dUltimo_Vcto_Cpa                : TDateTime;
 dUltimo_Vcto_Cierre_Anterior_Ant: TDateTime;
 dUltimo_Vcto_Cierre_Anterior_Act: TDateTime;
 fN1, fN2, fN3, fN4, fN5         : Double;


begin
  sModuloErr := '';
  sStringErr := '';

  ultimo_vencimiento_new(dFecha_Emision
                        ,dFecha_Compra
                        ,Array_Mem_Desarr
                        ,RegDes
                        ,False             // Sin Cupon
                        ,iCuponVigente
                        ,dUltimo_Vcto_Cpa
                        ,sModuloErr
                        ,sStringErr
                        ,bResult);
  if NOT bResult then
     exit;

  if dFecha_Compra > dFecha_Cierre_Anterior_Act then
     dPaid_For_Accrued_Vigente_ant := 0
  else
  begin
     dAux_Fecha_Hasta := dFecha_Cierre_Anterior_Ant;
     if dFecha_Cierre_Anterior_Ant < dFecha_Compra then
        dAux_Fecha_Hasta := dFecha_Compra;

     ultimo_vencimiento_new(dFecha_Emision
                           ,dAux_Fecha_Hasta
                           ,Array_Mem_Desarr
                           ,RegDes
                           ,False             // Sin Cupon
                           ,iCuponVigente
                           ,dUltimo_Vcto_Cierre_Anterior_Ant
                           ,sModuloErr
                           ,sStringErr
                           ,bResult);
     if NOT bResult then
        exit;

     if dUltimo_Vcto_Cierre_Anterior_Ant > dUltimo_Vcto_Cpa then
       dPaid_For_Accrued_Vigente_ant := 0
     else
       // Si existio un corte en el periodo anterior ya se llevo el paid for accrued
       if Array_Mem_Desarr[iCuponVigente+1].Fecha_Vcto <= dFecha_Cierre_Anterior_Act then
          dPaid_For_Accrued_Vigente_ant := 0
       else
       begin
         Intereses_Acumulados( sTipo_Instrum
                              ,sEmisor
                              ,sInstrumento
                              ,sSerie
                              ,sNemotecnico
                              ,fTasa_Emision
                              ,fTasa_Compra
                              ,sMoneda_Instrum
                              ,sTipo_Nominales
                              ,dFecha_Emision
                              ,dFecha_Vencimiento
                              ,dFecha_Compra
                              ,dFecha_Compra
                              ,dFecha_Pago_Compra
                              ,sMoneda_Conversion
                              ,fCupones_Cortados
                              ,fNominales
                              ,dUltimo_Vcto_Cpa    // Desde
                              ,dFecha_Compra       // Hasta
                              ,'NO' //sDescriptor_Cargado
                              ,sTabla_Desarr_Cargada
                              ,RegDes
                              ,Array_Mem_Desarr
                              ,fN1
                              ,dPaid_For_Accrued_Vigente_Ant
                              ,fN2
                              ,fN3
                              ,fN4
                              ,fN5
                              ,sModuloErr
                              ,sStringErr
                              ,bResult);
       end;

     end;
// Actual

  dAux_Fecha_Hasta := dFecha_Cierre_Anterior_Act;
  if dFecha_Cierre_Anterior_Act < dFecha_Compra then
     dAux_Fecha_Hasta := dFecha_Compra;
  ultimo_vencimiento_new(dFecha_Emision
                        ,dAux_Fecha_Hasta
                        ,Array_Mem_Desarr
                        ,RegDes
                        ,False             // Sin Cupon
                        ,iCuponVigente
                        ,dUltimo_Vcto_Cierre_Anterior_Act
                        ,sModuloErr
                        ,sStringErr
                        ,bResult);
  if NOT bResult then
     exit;

  if dUltimo_Vcto_Cierre_Anterior_Act > dUltimo_Vcto_Cpa then
    dPaid_For_Accrued_Vigente_Act := 0
  else
    if dPaid_For_Accrued_Vigente_Ant <> 0 then
       // Su tengo calculado el Paid ant lo uso ya que siempre es el mismo
       // sino lo tengo que calcular ...
       dPaid_For_Accrued_Vigente_Act := dPaid_For_Accrued_Vigente_Ant
    else
    begin
      Intereses_Acumulados( sTipo_Instrum
                           ,sEmisor
                           ,sInstrumento
                           ,sSerie
                           ,sNemotecnico
                           ,fTasa_Emision
                           ,fTasa_Compra
                           ,sMoneda_Instrum
                           ,sTipo_Nominales
                           ,dFecha_Emision
                           ,dFecha_Vencimiento
                           ,dFecha_Compra
                           ,dFecha_Compra
                           ,dFecha_Pago_Compra
                           ,sMoneda_Conversion
                           ,fCupones_Cortados
                           ,fNominales
                           ,dUltimo_Vcto_Cpa    // Desde
                           ,dFecha_Compra       // Hasta
                           ,'NO' //sDescriptor_Cargado
                           ,sTabla_Desarr_Cargada
                           ,RegDes
                           ,Array_Mem_Desarr
                           ,fN1
                           ,dPaid_For_Accrued_Vigente_Act
                           ,fN2
                           ,fN3
                           ,fN4
                           ,fN5
                           ,sModuloErr
                           ,sStringErr
                           ,bResult);
    end;


end;

procedure Tipo_Cambio_promedio_CPA_RV1 (dFecha_Desde  : TDateTime;
                                        dFecha_Hasta  : TDateTime;
                                        sEmpresa      : String;
                                        sCartera      : String;
                                        sNemotecnico  : String;
                                        sMoneda_Origen        : String;
                                        sMoneda_Conversion_Proc : String;
                                        sMoneda_Conversion_Tran : String;
                                        var fValor_Nominal    : Double;
                                        var fTCambio_Promedio : Double;
                                        var sModuloErr        : String;
                                        var sStringErr        : String;
                                        var Result            : Boolean);
var
  fCpas_Totales : Double;
  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_Saldos   : Double;
  fTCambio_Saldos         : Double;

  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_OMDs   : Double;
  fTCambio_Promedio_OMDs : Double;

  // Variables para cuando el tipo de cambio se obtiene de tabla de monedas
  fValor_Nominal_ValCamb   : Double;
  fTCambio_Promedio_ValCamb : Double;
  fTCambio               : Double;
  fSuma_TCa_por_Nominales : Double;
  fSuma_Nominales         : Double;
  fCantidad               : Double;
begin
  Result := True;
  fValor_Nominal    := 0;
  fTCambio_Promedio := 0;
  fTCambio_Saldos   := 0;
  fCantidad         := 0;
  // Ojo: Realice la separacion ya que existe el caso en que el tipo de cambio existe en la operacion
  //      y el caso en que tengo que ir a buscarla a la tabla de tipos de cambio.
  //      Si determino que Moneda_origen = Moneda_Cambio Devuelvo imediatamente TCambio_Prom = 1
  //      Si determino que todos los nominales comprados en #1 concuerdan con Las compras realizadas en
  //      la moneda_Origen / Moneda Conversion solicitada no hago la tercera parte ...
  //      LO ANTERIOR PORQUE PUEDE QUE EXISTAN OPERACIONES DE IGUAL MONEDA_ORIGEN PERO DISTINTA MONEDA CONVERSION
  //

  WITH DM_Rutinas_Informes.Qry_General do
  begin
// #0 Leo los valores vigentes a la fecha desde
    SQL.Clear;
    SQL.Add(' SELECT (PRECIO_PROM_CPA * Cantidad) as Valor');
    SQL.Add('  FROM QS_RES_VALORIZA_RV_GAAP');
    SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
    SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');
    SQL.Add('   AND Cartera      = :Cartera        ');
    SQL.Add('   AND Empresa      = :Empresa        ');

    ParamByName('Fecha'      ).AsDateTime := dFecha_Desde;
    ParamByName('Nemotecnico').AsString   := sNemotecnico;
    ParamByName('Cartera'    ).AsString   := sCartera;
    ParamByName('Empresa'    ).AsString   := sEmpresa;

    Open;
    if FieldByName('Valor').isNull then
       fValor_Nominal_Saldos := 0
    else
       fValor_Nominal_Saldos := FieldByName('Valor').AsFloat;
    Close;

    SQL.Clear;
    SQL.Add(' SELECT Cantidad ');
    SQL.Add('  FROM QS_RES_VALORIZA_RV_GAAP');
    SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
    SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');
    SQL.Add('   AND Cartera      = :Cartera        ');
    SQL.Add('   AND Empresa      = :Empresa        ');

    ParamByName('Fecha'      ).AsDateTime := dFecha_Desde;
    ParamByName('Nemotecnico').AsString   := sNemotecnico;
    ParamByName('Cartera'    ).AsString   := sCartera;
    ParamByName('Empresa'    ).AsString   := sEmpresa;

    Open;
    if FieldByName('Cantidad').isNull then
       fCantidad := 0
    else
       fCantidad := FieldByName('Cantidad').AsFloat;
    Close;

    if fCantidad > 0 then
    begin
//    if fValor_Nominal_Saldos > 0 then
//    begin
      Conversion_unidad_mon(sMoneda_Origen
                       ,sMoneda_Conversion_Proc
                       ,'BC'
                       ,dFecha_Desde
                       ,1
                       ,fTCambio_Saldos
                       ,sModuloErr
                       ,sStringErr
                       ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
    end;

   // Ojo las compras al día 1 del periodo (fecha desde) estan incluidas en los saldos
   // obtenidos a desde la tabla de valorizaciones de RV por eso aumento fecha desde en 1
   dFecha_Desde := dFecha_Desde + 1;
// #1 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(b.valor_invertido_um) As valor_invertido_um                            ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add(' 	,qs_tra_omd_det_rf b                                                ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;

    Open;

    if (FieldByName('valor_invertido_um').AsFloat = 0) OR
       (FieldByName('valor_invertido_um').IsNull) then
    begin
      // Si las compras del periodo son 0 devuelvo los valores al inicio del periodo (Saldos)
      fValor_Nominal    := fValor_Nominal_Saldos;
      fTCambio_Promedio := fTCambio_Saldos;
      Close;
      exit;
    end;
    fCpas_Totales := FieldByName('valor_invertido_um').AsFloat;
    Close;

    if (sMoneda_Origen = sMoneda_Conversion_Proc) and
       (sMoneda_Origen = sMoneda_Conversion_Tran) then
    begin
      fValor_Nominal    := fCpas_Totales + fValor_Nominal_Saldos;
      fTCambio_Promedio := 1;
      exit;
    end;

// #2 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(b.valor_invertido_um) As valor_invertido_um   ');
    SQL.Add('       ,SUM(b.tasa_estimada * b.valor_invertido_um) / SUM(b.valor_invertido_um) As Tipo_Cambio_Prom ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add(' 	,qs_tra_omd_det_rf b                                                ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' and a.Moneda_Operacion = :Moneda_Operacion                            ');
    SQL.Add(' and b.Moneda_Instrum   = :Moneda_Instrum                              ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
    ParamByName('Moneda_Operacion' ).AsString := sMoneda_Conversion_Tran;
    ParamByName('Moneda_Instrum' ).AsString   := sMoneda_Origen;
    Open;

    if (FieldByName('valor_invertido_um').IsNull) OR
       (FieldByName('Tipo_Cambio_Prom').IsNull) then
    begin
       fValor_Nominal_OMDs    := 0;
       fTCambio_Promedio_OMDs := 0;
    end
    else
    begin
      fValor_Nominal_OMDs    := FieldByName('valor_invertido_um').AsFloat;
      fTCambio_Promedio_OMDs := FieldByName('Tipo_Cambio_Prom').AsFloat;
    end;
    Close;
    // Si todas las Cpas del periodo estan incluidas en la moneda origen moneda conversion solicitadas
    // no es necesario realizar el ciclo de compra por compra
    if (fValor_Nominal_OMDs + fValor_Nominal_Saldos) <> 0 then
      if (fValor_Nominal_OMDs = fCpas_Totales) then
      begin
          fValor_Nominal    := fValor_Nominal_OMDs + fValor_Nominal_Saldos;
          fTCambio_Promedio := ((fValor_Nominal_OMDs * fTCambio_Promedio_OMDs) +
                                (fValor_Nominal_Saldos * fTCambio_Saldos)
                                ) /
                                 (fValor_Nominal_OMDs + fValor_Nominal_Saldos);
          exit;
      end;

    // #3 Busco tipo de Cambio para cada compra a la fecha de operacion
    SQL.Clear;
    SQL.Add(' SELECT a.Fecha_Operacion                                              ');
    SQL.Add('       ,SUM(b.valor_invertido_um) As valor_invertido_um                          ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add('     ,qs_tra_omd_det_rf b                                              ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' and NOT (a.Moneda_Operacion = :Moneda_Operacion AND b.Moneda_Instrum = :Moneda_Instrum) ');
    SQL.Add(' GROUP BY a.Fecha_Operacion                                                              ');


    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
    ParamByName('Moneda_Operacion' ).AsString := sMoneda_Conversion_Tran;
    ParamByName('Moneda_Instrum' ).AsString   := sMoneda_Origen;

    Open;
    fSuma_TCa_por_Nominales := 0;
    fSuma_Nominales         := 0;

    While NOT EOF do
    begin
      Conversion_unidad_mon(sMoneda_Origen
                           ,sMoneda_Conversion_Tran
                           ,'BC'
                           ,FieldByName('Fecha_Operacion').AsDateTime
                           ,1
                           ,fTCambio
                           ,sModuloErr
                           ,sStringErr
                           ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
      fSuma_TCa_por_Nominales := fSuma_TCa_por_Nominales +
                                (fTCambio * FieldByName('valor_invertido_um').AsFloat);
      fSuma_Nominales         := fSuma_Nominales +
                                 FieldByName('valor_invertido_um').AsFloat;
      Next;
    end;
    Close;
    if fSuma_Nominales = 0 then
    begin
      fValor_Nominal_ValCamb    := 0;
      fTCambio_Promedio_ValCamb := 0;
    end
    else
    begin
      fValor_Nominal_ValCamb    := fSuma_Nominales;
      fTCambio_Promedio_ValCamb := fSuma_TCa_por_Nominales / fSuma_Nominales;
    end;

    fValor_Nominal := fValor_Nominal_Saldos + fValor_Nominal_OMDs + fValor_Nominal_ValCamb;

    if (fValor_Nominal <> 0 ) then
    begin
      fTCambio_Promedio := ((fValor_Nominal_Saldos * fTCambio_Saldos) +
                            (fValor_Nominal_OMDs * fTCambio_Promedio_OMDs) +
                            (fValor_Nominal_ValCamb * fTCambio_Promedio_ValCamb)
                           ) /
                           fValor_Nominal;
    end
    else
      fTCambio_Promedio := 0;
  end;
end;
//------------------------------------------------------------------------------
procedure Tipo_Cambio_promedio_CPA_RV ( dFecha_Desde  : TDateTime;
                                        dFecha_Hasta  : TDateTime;
                                        sEmpresa      : String;
                                        sCartera      : String;
                                        sNemotecnico  : String;
                                        sMoneda_Origen        : String;
                                        sMoneda_Conversion_Proc : String;
                                        sMoneda_Conversion_Tran : String;
                                        var fValor_Nominal    : Double;
                                        var fTCambio_Promedio : Double;
                                        var sModuloErr        : String;
                                        var sStringErr        : String;
                                        var Result            : Boolean);
var
  fCpas_Totales : Double;
  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_Saldos   : Double;
  fTCambio_Saldos         : Double;

  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_OMDs   : Double;
  fTCambio_Promedio_OMDs : Double;

  // Variables para cuando el tipo de cambio se obtiene de tabla de monedas
  fValor_Nominal_ValCamb   : Double;
  fTCambio_Promedio_ValCamb : Double;
  fTCambio               : Double;
  fSuma_TCa_por_Nominales : Double;
  fSuma_Nominales         : Double;
begin
  Result := True;
  fValor_Nominal    := 0;
  fTCambio_Promedio := 0;
  fTCambio_Saldos   := 0;
  // Ojo: Realice la separacion ya que existe el caso en que el tipo de cambio existe en la operacion
  //      y el caso en que tengo que ir a buscarla a la tabla de tipos de cambio.
  //      Si determino que Moneda_origen = Moneda_Cambio Devuelvo imediatamente TCambio_Prom = 1
  //      Si determino que todos los nominales comprados en #1 concuerdan con Las compras realizadas en
  //      la moneda_Origen / Moneda Conversion solicitada no hago la tercera parte ...
  //      LO ANTERIOR PORQUE PUEDE QUE EXISTAN OPERACIONES DE IGUAL MONEDA_ORIGEN PERO DISTINTA MONEDA CONVERSION
  //

  WITH DM_Rutinas_Informes.Qry_General do
  begin
// #0 Leo los valores vigentes a la fecha desde
    SQL.Clear;
    SQL.Add(' SELECT Cantidad');
    SQL.Add('  FROM QS_RES_VALORIZA_RV_GAAP');
    SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
    SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');
    SQL.Add('   AND Cartera      = :Cartera        ');
    SQL.Add('   AND Empresa      = :Empresa        ');

    ParamByName('Fecha'      ).AsDateTime := dFecha_Desde;
    ParamByName('Nemotecnico').AsString   := sNemotecnico;
    ParamByName('Cartera'    ).AsString   := sCartera;
    ParamByName('Empresa'    ).AsString   := sEmpresa;

    Open;
    if FieldByName('Cantidad').isNull then
       fValor_Nominal_Saldos := 0
    else
       fValor_Nominal_Saldos := FieldByName('Cantidad').AsFloat;
    Close;

    if fValor_Nominal_Saldos > 0 then
    begin
      Conversion_unidad_mon(sMoneda_Origen
                       ,sMoneda_Conversion_Proc
                       ,'BC'
                       ,dFecha_Desde
                       ,1
                       ,fTCambio_Saldos
                       ,sModuloErr
                       ,sStringErr
                       ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
    end;

   // Ojo las compras al día 1 del periodo (fecha desde) estan incluidas en los saldos
   // obtenidos a desde la tabla de valorizaciones de RV por eso aumento fecha desde en 1
   dFecha_Desde := dFecha_Desde + 1;
// #1 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(valor_nominal) As Valor_Nominal                            ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add(' 	,qs_tra_omd_det_rf b                                                ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;

    Open;

    if (FieldByName('Valor_Nominal').AsFloat = 0) OR
       (FieldByName('Valor_Nominal').IsNull) then
    begin
      // Si las compras del periodo son 0 devuelvo los valores al inicio del periodo (Saldos)
      fValor_Nominal    := fValor_Nominal_Saldos;
      fTCambio_Promedio := fTCambio_Saldos;
      Close;
      exit;
    end;
    fCpas_Totales := FieldByName('Valor_Nominal').AsFloat;
    Close;

    if (sMoneda_Origen = sMoneda_Conversion_Proc) and
       (sMoneda_Origen = sMoneda_Conversion_Tran) then
    begin
      fValor_Nominal    := fCpas_Totales + fValor_Nominal_Saldos;
      fTCambio_Promedio := 1;
      exit;
    end;

// #2 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(valor_nominal) As Valor_Nominal                            ');
    SQL.Add('       ,SUM(tasa_estimada * valor_nominal) / SUM(Valor_nominal) As Tipo_Cambio_Prom ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add(' 	,qs_tra_omd_det_rf b                                                ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' and a.Moneda_Operacion = :Moneda_Operacion                            ');
    SQL.Add(' and b.Moneda_Instrum   = :Moneda_Instrum                              ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
    ParamByName('Moneda_Operacion' ).AsString := sMoneda_Conversion_Tran;
    ParamByName('Moneda_Instrum' ).AsString   := sMoneda_Origen;
    Open;

    if (FieldByName('Valor_Nominal'   ).IsNull) OR
       (FieldByName('Tipo_Cambio_Prom').IsNull) then
    begin
       fValor_Nominal_OMDs    := 0;
       fTCambio_Promedio_OMDs := 0;
    end
    else
    begin
      fValor_Nominal_OMDs    := FieldByName('Valor_Nominal'   ).AsFloat;
      fTCambio_Promedio_OMDs := FieldByName('Tipo_Cambio_Prom').AsFloat;
    end;
    Close;
    // Si todas las Cpas del periodo estan incluidas en la moneda origen moneda conversion solicitadas
    // no es necesario realizar el ciclo de compra por compra
    if (fValor_Nominal_OMDs = fCpas_Totales) then
    begin
        fValor_Nominal    := fValor_Nominal_OMDs + fValor_Nominal_Saldos;
        fTCambio_Promedio := ((fValor_Nominal_OMDs * fTCambio_Promedio_OMDs) +
                              (fValor_Nominal_Saldos * fTCambio_Saldos)
                              ) /
                               (fValor_Nominal_OMDs + fValor_Nominal_Saldos);
        exit;
    end;

    // #3 Busco tipo de Cambio para cada compra a la fecha de operacion
    SQL.Clear;
    SQL.Add(' SELECT a.Fecha_Operacion                                              ');
    SQL.Add('       ,SUM(b.Valor_Nominal) As Valor_nominal                          ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add('     ,qs_tra_omd_det_rf b                                              ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' and NOT (a.Moneda_Operacion = :Moneda_Operacion AND b.Moneda_Instrum = :Moneda_Instrum) ');
    SQL.Add(' GROUP BY a.Fecha_Operacion                                                              ');


    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
    ParamByName('Moneda_Operacion' ).AsString := sMoneda_Conversion_Tran;
    ParamByName('Moneda_Instrum' ).AsString   := sMoneda_Origen;

    Open;
    fSuma_TCa_por_Nominales := 0;
    fSuma_Nominales         := 0;

    While NOT EOF do
    begin
      Conversion_unidad_mon(sMoneda_Origen
                           ,sMoneda_Conversion_Tran
                           ,'BC'
                           ,FieldByName('Fecha_Operacion').AsDateTime
                           ,1
                           ,fTCambio
                           ,sModuloErr
                           ,sStringErr
                           ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
      fSuma_TCa_por_Nominales := fSuma_TCa_por_Nominales +
                                (fTCambio * FieldByName('Valor_Nominal').AsFloat);
      fSuma_Nominales         := fSuma_Nominales +
                                 FieldByName('Valor_Nominal').AsFloat;
      Next;
    end;
    Close;
    if fSuma_Nominales = 0 then
    begin
      fValor_Nominal_ValCamb    := 0;
      fTCambio_Promedio_ValCamb := 0;
    end
    else
    begin
      fValor_Nominal_ValCamb    := fSuma_Nominales;
      fTCambio_Promedio_ValCamb := fSuma_TCa_por_Nominales / fSuma_Nominales;
    end;

    fValor_Nominal := fValor_Nominal_Saldos + fValor_Nominal_OMDs + fValor_Nominal_ValCamb;

    if (fValor_Nominal <> 0 ) then
    begin
      fTCambio_Promedio := ((fValor_Nominal_Saldos * fTCambio_Saldos) +
                            (fValor_Nominal_OMDs * fTCambio_Promedio_OMDs) +
                            (fValor_Nominal_ValCamb * fTCambio_Promedio_ValCamb)
                           ) /
                           fValor_Nominal;
    end
    else
      fTCambio_Promedio := 0;
  end;
end;
//------------------------------------------------------------------------------
procedure Tipo_Cambio_promedio_CPA_RV2 ( dFecha_Desde  : TDateTime;
                                        dFecha_Hasta   : TDateTime;
                                        sEmpresa       : String;
                                        sCartera       : String;
                                        sNemotecnico   : String;
                                        sMoneda_Origen        : String;
                                        sMoneda_Conversion_Proc : String;
                                        sMoneda_Conversion_Tran : String;
                                        fNominales_Reverso    : Double;
                                        var fTCambio : Double;
                                        var sModuloErr        : String;
                                        var sStringErr        : String;
                                        var Result            : Boolean);
var
  fprecio_mdo           : Double;
  fValor_saldo_um       : Double;
  fTCambio_saldo        : Double;
  fValor_nominal_cpa    : Double;
  fValor_Nominal_Saldos : Double;
  fValor                : Double;
  fSuma_TCa             : Double;
  fSuma_Invertido_Um    : Double;
  TCambio_Cpa           : Double;
  fValor_cpa,
  fPrecio_prom_Cpa      : Double;
begin
  Result := True;
  fValor_Nominal_Saldos := 0;
  fprecio_mdo           := 0;
  fValor_saldo_um       := 0;
  fTCambio_saldo        := 0;
  fValor_nominal_cpa    := 0;
  fValor                := 0;
  // Ojo: Realice la separacion ya que existe el caso en que el tipo de cambio existe en la operacion
  //      y el caso en que tengo que ir a buscarla a la tabla de tipos de cambio.
  //      Si determino que Moneda_origen = Moneda_Cambio Devuelvo imediatamente TCambio_Prom = 1
  //      Si determino que todos los nominales comprados en #1 concuerdan con Las compras realizadas en
  //      la moneda_Origen / Moneda Conversion solicitada no hago la tercera parte ...
  //      LO ANTERIOR PORQUE PUEDE QUE EXISTAN OPERACIONES DE IGUAL MONEDA_ORIGEN PERO DISTINTA MONEDA CONVERSION
  //

  WITH DM_Rutinas_Informes.Qry_General do
  begin
// #0 Leo los valores vigentes a la fecha desde
    SQL.Clear;
    SQL.Add(' SELECT Cantidad, precio_mdo');
    SQL.Add('  FROM QS_RES_VALORIZA_RV_GAAP');
    SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
    SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');
    SQL.Add('   AND Cartera      = :Cartera        ');
    SQL.Add('   AND Empresa      = :Empresa        ');

    ParamByName('Fecha'      ).AsDateTime := dFecha_Desde;
    ParamByName('Nemotecnico').AsString   := sNemotecnico;
    ParamByName('Cartera'    ).AsString   := sCartera;
    ParamByName('Empresa'    ).AsString   := sEmpresa;

    Open;
    if FieldByName('Cantidad').isNull then
    begin
       fprecio_mdo := 0;
       fvalor_saldo_um := 1;
    end
    else
    begin
       fValor_Nominal_Saldos := FieldByName('Cantidad').AsFloat - fNominales_Reverso;
       fprecio_mdo           := FieldByName('precio_mdo').AsFloat;
       fValor_saldo_um       := fValor_Nominal_Saldos * fprecio_mdo;

       Conversion_unidad_mon(sMoneda_Origen
                           ,sMoneda_Conversion_Tran
                           ,'BC'
                           ,dFecha_Desde
                           ,1
                           ,fTCambio_saldo
                           ,sModuloErr
                           ,sStringErr
                           ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
      fValor := fValor_Nominal_Saldos * fprecio_mdo * fTCambio_saldo;

    end;
    Close;

    if fvalor_saldo_um = 0 then
       fvalor_saldo_um := 1;

// Ojo las compras al día 1 del periodo (fecha desde) estan incluidas en los saldos
// obtenidos a desde la tabla de valorizaciones de RV por eso aumento fecha desde en 1
    dFecha_Desde := dFecha_Desde + 1;
// #1 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(valor_nominal) As Valor_Nominal                            ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add(' 	,qs_tra_omd_det_rf b                                                ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;

    Open;

    if (FieldByName('Valor_Nominal').AsFloat = 0) OR
       (FieldByName('Valor_Nominal').IsNull) then
    begin
      // Si las compras del periodo son 0 devuelvo los valores al inicio del periodo (Saldos)
      fTCambio := fValor/fvalor_saldo_um;
      Close;
      exit;
    end;
    fValor_nominal_cpa := FieldByName('Valor_Nominal').AsFloat;
    Close;
// #2 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    fSuma_TCa          := 0;
    fSuma_Invertido_Um := 0;
    SQL.Clear;
    SQL.Add(' SELECT fecha_operacion ' );
    SQL.Add('       ,SUM(b.valor_invertido_um) as valor_invertido_um ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add(' 	,qs_tra_omd_det_rf b                                                ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' GROUP BY fecha_operacion ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;

    Open;

    While NOT EOF do
    begin
      Conversion_unidad_mon(sMoneda_Origen
                           ,sMoneda_Conversion_Tran
                           ,'BC'
                           ,FieldByName('Fecha_Operacion').AsDateTime
                           ,1
                           ,fTCambio
                           ,sModuloErr
                           ,sStringErr
                           ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
      fSuma_TCa          := fSuma_TCa + (fTCambio * FieldByName('valor_invertido_um').AsFloat);
      fSuma_Invertido_Um := fSuma_Invertido_Um + FieldByName('valor_invertido_um').AsFloat;
      Next;
    end;
    Close;

    if fSuma_Invertido_Um <> 0 then
       TCambio_Cpa :=  fSuma_TCa / fSuma_Invertido_Um
    else
       TCambio_Cpa := 1;

    if fValor_nominal_cpa <> 0 then
       fPrecio_prom_Cpa :=  fSuma_Invertido_Um / fValor_nominal_cpa
    else
       fPrecio_prom_Cpa := 1;

    fValor_cpa :=  fValor_nominal_cpa * fPrecio_prom_Cpa * TCambio_Cpa;

    fValor := fValor + fValor_cpa;
    fvalor_saldo_um := fvalor_saldo_um + (fPrecio_prom_Cpa * fValor_nominal_cpa);

    if fvalor_saldo_um <> 0 then
       fTCambio :=  fValor / fvalor_saldo_um
    else
       fTCambio := 1;


  end;

end;
//------------------------------------------------------------------------------
procedure Tipo_Cambio_promedio_CPA_Ahorros ( dFecha_Desde  : TDateTime;
                                        dFecha_Hasta  : TDateTime;
                                        sEmpresa      : String;
                                        sCartera      : String;
                                        sNemotecnico  : String;
                                        sMoneda_Origen        : String;
                                        sMoneda_Conversion_Proc : String;
                                        sMoneda_Conversion_Tran : String;
                                        var fValor_Nominal    : Double;
                                        var fTCambio_Promedio : Double;
                                        var sModuloErr        : String;
                                        var sStringErr        : String;
                                        var Result            : Boolean);
var
  fCpas_Totales : Double;
  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_Saldos   : Double;
  fTCambio_Saldos         : Double;

  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_OMDs   : Double;
  fTCambio_Promedio_OMDs : Double;

  // Variables para cuando el tipo de cambio se obtiene de tabla de monedas
  fValor_Nominal_ValCamb   : Double;
  fTCambio_Promedio_ValCamb : Double;
  fTCambio               : Double;
  fSuma_TCa_por_Nominales : Double;
  fSuma_Nominales         : Double;
begin
  Result := True;
  fValor_Nominal    := 0;
  fTCambio_Promedio := 0;
  fTCambio_Saldos   := 0;
  // Ojo: Realice la separacion ya que existe el caso en que el tipo de cambio existe en la operacion
  //      y el caso en que tengo que ir a buscarla a la tabla de tipos de cambio.
  //      Si determino que Moneda_origen = Moneda_Cambio Devuelvo imediatamente TCambio_Prom = 1
  //      Si determino que todos los nominales comprados en #1 concuerdan con Las compras realizadas en
  //      la moneda_Origen / Moneda Conversion solicitada no hago la tercera parte ...
  //      LO ANTERIOR PORQUE PUEDE QUE EXISTAN OPERACIONES DE IGUAL MONEDA_ORIGEN PERO DISTINTA MONEDA CONVERSION
  //

  WITH DM_Rutinas_Informes.Qry_General do
  begin
// #0 Leo los valores vigentes a la fecha desde
    SQL.Clear;
    SQL.Add(' SELECT Valor_nominal as Cantidad');
    SQL.Add('  FROM QS_RES_AHORROS');
    SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
    SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');

    SQL.Add('   AND Cartera      = :Cartera        ');
    SQL.Add('   AND Empresa      = :Empresa        ');

    ParamByName('Fecha'      ).AsDateTime := dFecha_Desde;
    ParamByName('Nemotecnico').AsString   := sNemotecnico;
    ParamByName('Cartera'    ).AsString   := sCartera;
    ParamByName('Empresa'    ).AsString   := sEmpresa;

    Open;
    if FieldByName('Cantidad').isNull then
       fValor_Nominal_Saldos := 0
    else
       fValor_Nominal_Saldos := FieldByName('Cantidad').AsFloat;
    Close;

    if fValor_Nominal_Saldos > 0 then
    begin
      Conversion_unidad_mon(sMoneda_Origen
                       ,sMoneda_Conversion_Proc
                       ,'BC'
                       ,dFecha_Desde
                       ,1
                       ,fTCambio_Saldos
                       ,sModuloErr
                       ,sStringErr
                       ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
    end;

   // Ojo las compras al día 1 del periodo (fecha desde) estan incluidas en los saldos
   // obtenidos a desde la tabla de valorizaciones de RV por eso aumento fecha desde en 1
   dFecha_Desde := dFecha_Desde + 1;
// #1 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(nominales) As Valor_Nominal                            ');
    SQL.Add(' from QS_TRA_AHORROS a                                                     ');
    SQL.Add(' where a.fecha_hora_mov between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''STOCK(+)'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and a.nemotecnico = :Nemotecnico                                      ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;

    Open;

    if (FieldByName('Valor_Nominal').AsFloat = 0) OR
       (FieldByName('Valor_Nominal').IsNull) then
    begin
      // Si las compras del periodo son 0 devuelvo los valores al inicio del periodo (Saldos)
      fValor_Nominal    := fValor_Nominal_Saldos;
      fTCambio_Promedio := fTCambio_Saldos;
      Close;
      exit;
    end;
    fCpas_Totales := FieldByName('Valor_Nominal').AsFloat;
    Close;

    if (sMoneda_Origen = sMoneda_Conversion_Proc) and
       (sMoneda_Origen = sMoneda_Conversion_Tran) then
    begin
      fValor_Nominal    := fCpas_Totales + fValor_Nominal_Saldos;
      fTCambio_Promedio := 1;
      exit;
    end;

// #2 Determino si existen compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(nominales) As Valor_Nominal                            ');
    SQL.Add('       ,SUM(tipo_cambio * nominales) / SUM(nominales) As Tipo_Cambio_Prom ');
    SQL.Add(' from QS_TRA_AHORROS a, QS_FIN_DESCR_AHORRO b                                       ');
    SQL.Add(' where a.fecha_hora_mov between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''STOCK(+)'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and a.nemotecnico = b.nemotecnico                                 ');
    SQL.Add(' and a.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' and a.Moneda_caja = :Moneda_Operacion                            ');
    SQL.Add(' and b.Moneda      = :Moneda_Instrum                              ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
    ParamByName('Moneda_Operacion' ).AsString := sMoneda_Conversion_Tran;
    ParamByName('Moneda_Instrum' ).AsString   := sMoneda_Origen;
    Open;

    if (FieldByName('Valor_Nominal'   ).IsNull) OR
       (FieldByName('Tipo_Cambio_Prom').IsNull) then
    begin
       fValor_Nominal_OMDs    := 0;
       fTCambio_Promedio_OMDs := 0;
    end
    else
    begin
      fValor_Nominal_OMDs    := FieldByName('Valor_Nominal'   ).AsFloat;
      fTCambio_Promedio_OMDs := FieldByName('Tipo_Cambio_Prom').AsFloat;
    end;
    Close;
    // Si todas las Cpas del periodo estan incluidas en la moneda origen moneda conversion solicitadas
    // no es necesario realizar el ciclo de compra por compra
    if (fValor_Nominal_OMDs = fCpas_Totales) then
    begin
        fValor_Nominal    := fValor_Nominal_OMDs + fValor_Nominal_Saldos;
        fTCambio_Promedio := ((fValor_Nominal_OMDs * fTCambio_Promedio_OMDs) +
                              (fValor_Nominal_Saldos * fTCambio_Saldos)
                              ) /
                               (fValor_Nominal_OMDs + fValor_Nominal_Saldos);
        exit;
    end;

    // #3 Busco tipo de Cambio para cada compra a la fecha de operacion
    SQL.Clear;
    SQL.Add(' SELECT a.fecha_hora_mov                                              ');
    SQL.Add('       ,SUM(a.nominales) As Valor_nominal                          ');
    SQL.Add(' from QS_TRA_AHORROS a, QS_FIN_DESCR_AHORRO b                                       ');
    SQL.Add(' where a.fecha_hora_mov between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''STOCK(+)'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' and a.nemotecnico = b.nemotecnico                                      ');
    SQL.Add(' and NOT (a.Moneda_caja = :Moneda_Operacion AND b.Moneda = :Moneda_Instrum) ');
    SQL.Add(' GROUP BY a.fecha_hora_mov                                                              ');


    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
    ParamByName('Moneda_Operacion' ).AsString := sMoneda_Conversion_Tran;
    ParamByName('Moneda_Instrum' ).AsString   := sMoneda_Origen;

    Open;
    fSuma_TCa_por_Nominales := 0;
    fSuma_Nominales         := 0;

    While NOT EOF do
    begin
      Conversion_unidad_mon(sMoneda_Origen
                           ,sMoneda_Conversion_Tran
                           ,'BC'
                           ,FieldByName('fecha_hora_mov').AsDateTime
                           ,1
                           ,fTCambio
                           ,sModuloErr
                           ,sStringErr
                           ,Result);

      if NOT Result then
      begin
         sModuloErr := 'Tipo de Cambio Cpa. Promedio';
         exit;
      end;
      fSuma_TCa_por_Nominales := fSuma_TCa_por_Nominales +
                                (fTCambio * FieldByName('Valor_Nominal').AsFloat);
      fSuma_Nominales         := fSuma_Nominales +
                                 FieldByName('Valor_Nominal').AsFloat;
      Next;
    end;
    Close;
    if fSuma_Nominales = 0 then
    begin
      fValor_Nominal_ValCamb    := 0;
      fTCambio_Promedio_ValCamb := 0;
    end
    else
    begin
      fValor_Nominal_ValCamb    := fSuma_Nominales;
      fTCambio_Promedio_ValCamb := fSuma_TCa_por_Nominales / fSuma_Nominales;
    end;

    fValor_Nominal := fValor_Nominal_Saldos + fValor_Nominal_OMDs + fValor_Nominal_ValCamb;

    if (fValor_Nominal <> 0 ) then
    begin
      fTCambio_Promedio := ((fValor_Nominal_Saldos * fTCambio_Saldos) +
                            (fValor_Nominal_OMDs * fTCambio_Promedio_OMDs) +
                            (fValor_Nominal_ValCamb * fTCambio_Promedio_ValCamb)
                           ) /
                           fValor_Nominal;
    end
    else
      fTCambio_Promedio := 0;
  end;
end;

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
procedure Leer_Datos_Cierre_RV( sEmpresa        : String;
                                sCartera        : String;
                                sNemotecnico    : String;
                                sMoneda_Operacion : String;
                                dFechaCierre    : TDateTime;
                                var fValor_Mercado_MC : Double;
                                var fValor_Libro_MC : Double;
                                var fPrecio_libro   : Double;
                                var fValor_Nominal  : Double;
                                var fPPP_UM         : Double;
                                var fPPP_MC         : Double;
                                var fPPP_UM_SINREA  : Double;
                                var fPPP_MC_SINREA  : Double;
                                var fPRECIO_MDO     : Double);
begin
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add(' SELECT COSTO_CORREGIDO'   );
       SQL.Add('       ,PRECIO_MDO' );
       SQL.Add('       ,PRECIO_UM' );
       SQL.Add('       ,PRECIO' );
       SQL.Add('       ,PRECIO_SINREA' );
       SQL.Add('       ,PRECIO_PROM_CPA' );
       SQL.Add('       ,Cantidad' );
       SQL.Add('       ,Valor_Mercado_Mc ');
       SQL.Add('       ,PRECIO_LIBRO     ');
       SQL.Add('       ,VALOR_LIBRO      ');
       SQL.Add('  FROM QS_RES_VALORIZA_RV_GAAP');
       SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
       SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');
       SQL.Add('   AND Cartera      = :Cartera        ');
       { Se comenta con Fecha 10-08-2011 Para las ventas en otra moneda no encuentra los registros ...
       SQL.Add('   AND Moneda_Operacion = :Moneda_Operacion ');
       }
       SQL.Add('   AND Empresa      = :Empresa        ');

       ParamByName('Fecha'      ).AsDateTime := dFechaCierre;
       ParamByName('Nemotecnico').AsString   := trim(sNemotecnico);
       ParamByName('Cartera'    ).AsString   := trim(sCartera);
       // ParamByName('Moneda_Operacion'    ).AsString   := trim(sMoneda_Operacion);
       ParamByName('Empresa'    ).AsString   := trim(sEmpresa);

       Open;

       if FieldByName('Valor_Mercado_Mc').isNull then
          fValor_Mercado_MC := 0
       else
          fValor_Mercado_MC := FieldByName('Valor_Mercado_Mc'  ).AsFloat;

       if FieldByName('VALOR_LIBRO').isNull then
          fValor_Libro_MC := 0
       else
          fValor_Libro_MC := FieldByName('VALOR_LIBRO'  ).AsFloat;

       if FieldByName('PRECIO_LIBRO').isNull then
          fPrecio_libro := 0
       else
          fPrecio_libro := FieldByName('PRECIO_LIBRO'  ).AsFloat;

       if FieldByName('PRECIO_UM').isNull then
          fPPP_UM              := 0
       else
          fPPP_UM              := FieldByName('PRECIO_UM'  ).AsFloat;

       if FieldByName('PRECIO').isNull then
          fPPP_MC              := 0
       else
          fPPP_MC              := FieldByName('PRECIO'  ).AsFloat;

       if FieldByName('PRECIO_PROM_CPA').isNull then
          fPPP_UM_SINREA       := 0
       else
          fPPP_UM_SINREA       := FieldByName('PRECIO_PROM_CPA'  ).AsFloat;

       if FieldByName('PRECIO_SINREA').isNull then
          fPPP_MC_SINREA       := 0
       else
          fPPP_MC_SINREA       := FieldByName('PRECIO_SINREA'  ).AsFloat;

       if FieldByName('PRECIO_MDO').isNull then
          fPRECIO_MDO       := 0
       else
          fPRECIO_MDO       := FieldByName('PRECIO_MDO'  ).AsFloat;

       if FieldByName('Cantidad').isNull then
          fValor_Nominal    := 0
       else
          fValor_Nominal    := FieldByName('Cantidad').AsFloat;
       Close;
    end;
end;
//------------------------------------------------------------------------------
procedure Leer_Datos_Cierre_Ahorros( sEmpresa        : String;
                                sCartera        : String;
                                sNemotecnico    : String;
                                sMoneda_Operacion : String;
                                dFechaCierre    : TDateTime;
                                var fValor_Mercado_MC : Double;
                                var fValor_Libro_MC : Double;
                                var fPrecio_libro   : Double;
                                var fValor_Nominal  : Double;
                                var fPPP_UM         : Double;
                                var fPPP_MC         : Double;
                                var fPPP_MC_SINREA  : Double;
                                var fPRECIO_MDO     : Double);
begin
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
//       SQL.Add('  SELECT valor_nominal as COSTO_CORREGIDO ');
       SQL.Add('  SELECT valor_devenga as COSTO_CORREGIDO ');
       SQL.Add('        ,1 as PRECIO_MDO ');
       SQL.Add('        ,1 as PRECIO_UM ');
       SQL.Add('        ,1 as PRECIO ');
       SQL.Add('        ,1 as PRECIO_SINREA ');
       SQL.Add('        ,1 as PRECIO_PROM_CPA ');
//       SQL.Add('        ,valor_nominal as Cantidad ');
//       SQL.Add('        ,valor_nominal as Valor_Mercado_Mc ');
       SQL.Add('        ,valor_devenga as Cantidad ');
       SQL.Add('        ,valor_devenga as Valor_Mercado_Mc ');
       SQL.Add('        ,1 as PRECIO_LIBRO ');
//       SQL.Add('        ,valor_nominal as VALOR_LIBRO ');
       SQL.Add('        ,valor_devenga as VALOR_LIBRO ');






       SQL.Add('   FROM qs_res_ahorros ');
       SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
       SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');
       SQL.Add('   AND Cartera      = :Cartera        ');
       SQL.Add('   AND Empresa      = :Empresa        ');

       ParamByName('Fecha'      ).AsDateTime := dFechaCierre;
       ParamByName('Nemotecnico').AsString   := trim(sNemotecnico);
       ParamByName('Cartera'    ).AsString   := trim(sCartera);
       ParamByName('Empresa'    ).AsString   := trim(sEmpresa);

       Open;

       if FieldByName('Valor_Mercado_Mc').isNull then
          fValor_Mercado_MC := 0
       else
          fValor_Mercado_MC := FieldByName('Valor_Mercado_Mc'  ).AsFloat;

       if FieldByName('VALOR_LIBRO').isNull then
          fValor_Libro_MC := 0
       else
          fValor_Libro_MC := FieldByName('VALOR_LIBRO'  ).AsFloat;

       if FieldByName('PRECIO_LIBRO').isNull then
          fPrecio_libro := 0
       else
          fPrecio_libro := FieldByName('PRECIO_LIBRO'  ).AsFloat;

       if FieldByName('PRECIO_UM').isNull then
          fPPP_UM              := 0
       else
          fPPP_UM              := FieldByName('PRECIO_UM'  ).AsFloat;

       if FieldByName('PRECIO').isNull then
          fPPP_MC              := 0
       else
          fPPP_MC              := FieldByName('PRECIO'  ).AsFloat;

       if FieldByName('PRECIO_SINREA').isNull then
          fPPP_MC_SINREA       := 0
       else
          fPPP_MC_SINREA       := FieldByName('PRECIO_SINREA'  ).AsFloat;

       if FieldByName('PRECIO_MDO').isNull then
          fPRECIO_MDO       := 0
       else
          fPRECIO_MDO       := FieldByName('PRECIO_MDO'  ).AsFloat;

       if FieldByName('Cantidad').isNull then
          fValor_Nominal    := 0
       else
          fValor_Nominal    := FieldByName('Cantidad').AsFloat;
       Close;
    end;
end;

//------------------------------------------------------------------------------

procedure Precio_promedio_CPA_RV ( dFecha_Desde  : TDateTime;
                                   dFecha_Hasta  : TDateTime;
                                   sEmpresa      : String;
                                   sCartera      : String;
                                   sNemotecnico  : String;
                                   var fValor_Nominal    : Double;
                                   var fPrecio_Promedio_MDO  : Double;
                                   var fPrecio_Promedio_CPA  : Double);
var
  //fCpas_Totales : Double;
  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_Saldos   : Double;
  fPP_MDO_Saldos          : Double;
  fPP_CPA_Saldos          : Double;

  // Variables para cuando el tipo de cambio se obtiene directamente de la operacion
  fValor_Nominal_OMDs   : Double;
  fPPP_OMDs             : Double;

begin
  fValor_Nominal    := 0;

  WITH DM_Rutinas_Informes.Qry_General do
  begin
    SQL.Clear;
    SQL.Add(' SELECT Cantidad');
    SQL.Add('       ,PRECIO_MDO  ');
    SQL.Add('       ,PRECIO_PROM_CPA  ');
    SQL.Add('  FROM QS_RES_VALORIZA_RV_GAAP');
    SQL.Add(' WHERE Fecha_Cierre = :Fecha          ');
    SQL.Add('   AND Nemotecnico  = :Nemotecnico    ');
    SQL.Add('   AND Cartera      = :Cartera        ');
    SQL.Add('   AND Empresa      = :Empresa        ');

    ParamByName('Fecha'      ).AsDateTime := dFecha_Desde;
    ParamByName('Nemotecnico').AsString   := sNemotecnico;
    ParamByName('Cartera'    ).AsString   := sCartera;
    ParamByName('Empresa'    ).AsString   := sEmpresa;

    Open;
    if FieldByName('Cantidad').isNull then
    begin
       fValor_Nominal_Saldos := 0;
       fPP_MDO_Saldos           := 0;
       fPP_CPA_Saldos           := 0;
    end
    else
    begin
       fValor_Nominal_Saldos := FieldByName('Cantidad').AsFloat;
       fPP_MDO_Saldos           := FieldByName('PRECIO_MDO'  ).AsFloat;
       fPP_CPA_Saldos           := FieldByName('PRECIO_PROM_CPA'  ).AsFloat;
    end;
    Close;

    // Ojo las compras al día 1 del periodo (fecha desde) estan incluidas en los saldos
    // obtenidos a desde la tabla de valorizaciones de RV por eso aumento fecha desde en 1
    dFecha_Desde := dFecha_Desde + 1;
    // #1 Determino si existen compras (Para Nemotecnico, empresa, cartera en el periodo y por cantidad nominales
    // Se debe hacer para evitar división por cero
    SQL.Clear;
    SQL.Add(' SELECT SUM(valor_nominal) As Valor_Nominal                            ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add(' 	,qs_tra_omd_det_rf b                                                ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;

    Open;

    if (FieldByName('Valor_Nominal').AsFloat = 0) OR
       (FieldByName('Valor_Nominal').IsNull) then
    begin
      // Si las compras del periodo son 0 devuelvo los valores al inicio del periodo (Saldos)
      fValor_Nominal    := fValor_Nominal_Saldos;
      fPrecio_Promedio_MDO  := fPP_MDO_Saldos;
      fPrecio_Promedio_CPA  := fPP_CPA_Saldos;
      Close;
      exit;
    end;
    //fCpas_Totales := FieldByName('Valor_Nominal').AsFloat;
    Close;

    // #2 Calculo PPP compras (segun para Nemotecnico, empresa, cartera en el periodo y por que valor
    SQL.Clear;
    SQL.Add(' SELECT SUM(valor_nominal) As Valor_Nominal                            ');
// Lo cambio para que se incluyan las comisiones en el caso de estar contempladas en la operacion 07-10-2011 F.I.
//    SQL.Add('       ,SUM(Porcen_Valor_PAR * valor_nominal) / SUM(Valor_nominal) As PPP        ');
    SQL.Add('       ,SUM((Valor_Pte_Cpa_MC/TASA_ESTIMADA) ) / SUM(Valor_nominal) As PPP        ');
    SQL.Add(' from qs_tra_omd a                                                     ');
    SQL.Add('     ,qs_tra_omd_det_rf b                                              ');
    SQL.Add(' where a.fecha_operacion between :Fecha_Desde and :Fecha_Hasta         ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''RV'')                  ');
    SQL.Add(' and a.transaccion in (SELECT d.Codigo_Transaccion                     ');
    SQL.Add('                         FROM qs_sys_tran_implic d                     ');
    SQL.Add('                        WHERE d.Codigo_transaccion = a.transaccion     ');
    SQL.Add('                          AND d.implicancia = ''COMPRA'')              ');
    SQL.Add(' and a.empresa = :Empresa                                              ');
    SQL.Add(' and a.cartera = :cartera                                              ');
    SQL.Add(' and a.folio_interno NOT IN (SELECT e.folio                            ');
    SQL.Add('                               FROM qs_ctr_anulacion e                 ');
    SQL.Add('                              WHERE e.folio   = a.folio_interno        ');
    SQL.Add('                                AND e.transaccion = a.transaccion      ');
    SQL.Add('                                AND e.empresa = a.empresa)             ');
    SQL.Add(' and b.folio_interno = a.folio_interno                                 ');
    SQL.Add(' and b.transaccion = a.transaccion                                     ');
    SQL.Add(' and b.empresa = a.empresa                                             ');
    SQL.Add(' and b.nemotecnico = :Nemotecnico                                      ');
    SQL.Add(' and b.TASA_ESTIMADA <> 0                                              ');

    ParamByName('Fecha_Desde' ).AsDateTime := dFecha_Desde;
    ParamByName('Fecha_Hasta' ).AsDateTime := dFecha_Hasta;
    ParamByName('Empresa'     ).AsString   := sEmpresa;
    ParamByName('cartera'     ).AsString   := sCartera;
    ParamByName('Nemotecnico' ).AsString   := sNemotecnico;
    Open;

    if (FieldByName('Valor_Nominal'   ).IsNull) OR
       (FieldByName('PPP'             ).IsNull) then
    begin
      fValor_Nominal_OMDs := 0;
      fPPP_OMDs           := 0;
    end
    else
    begin
      fValor_Nominal_OMDs := FieldByName('Valor_Nominal'   ).AsFloat;
      fPPP_OMDs           := FieldByName('PPP'             ).AsFloat;
    end;

    Close;
    if (fValor_Nominal_Saldos > 0) then
    begin
      fValor_Nominal   := fValor_Nominal_OMDs + fValor_Nominal_Saldos;
      fPrecio_Promedio_MDO := ((fValor_Nominal_OMDs * fPPP_OMDs) + (fValor_Nominal_Saldos * fPP_MDO_Saldos)
                              ) /
                               (fValor_Nominal_OMDs + fValor_Nominal_Saldos);

      fPrecio_Promedio_CPA := ((fValor_Nominal_OMDs * fPPP_OMDs) + (fValor_Nominal_Saldos * fPP_CPA_Saldos)
                             ) /
                              (fValor_Nominal_OMDs + fValor_Nominal_Saldos);
    end
    else
    begin
      fValor_Nominal   := fValor_Nominal_OMDs;
      fPrecio_Promedio_MDO := fPPP_OMDs;
      fPrecio_Promedio_CPA := fPPP_OMDs;
    end;
  end;
end;
//------------------------------------------------------------------------------
// Por ahora se esta asumiendo como motivo de RV el ultimo motivo registrado en la tabla de motivos
// antes de la fecha de cierre (no importa la omd)
//------------------------------------------------------------------------------
function Busca_Motivo_RV( sEmpresa        : String;
                          sCartera        : String;
                          sTransaccion    : String;
                          sNemotecnico    : String;
                          dFecha_Cierre   : TDateTime) : String;

begin
// Cambios realizados por E.S. 06-10-2009, RV debe buscar los motivos desde la nueva tabla QS_TRA_OMD_MOTIVO_OMD
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT c.COD_MOTIVO,a.Folio_Interno                                      ');     // SELECT MOTIVO,a.Folio_Interno
       SQL.Add('  FROM QS_TRA_OMD a                                                      ');
       SQL.Add('      ,QS_TRA_OMD_DET_RF b                                               ');
       SQL.Add('      ,QS_TRA_OMD_MOTIVO_OMD c                                           ');     // Nueva Tabla de Motivos RV
       SQL.Add('  WHERE b.nemotecnico = :Nemotecnico                                     ');
       SQL.Add('    and b.TRANSACCION = :Transaccion                                     ');
       SQL.Add('    AND b.CARTERA     = :Cartera                                         ');
       SQL.Add('    AND b.EMPRESA     = :Empresa                                         ');
       SQL.Add('    AND b.folio_interno not in (SELECT e.folio                           ');
       SQL.Add('    				  FROM qs_ctr_anulacion e                ');
       SQL.Add('    				 WHERE e.folio = b.folio_interno         ');
       SQL.Add('    				   AND e.transaccion = b.transaccion     ');
       SQL.Add('    				   AND e.empresa = b.empresa             ');
       SQL.Add('    				)                                        ');
       SQL.Add('    and a.folio_Interno = b.folio_interno                                ');
       SQL.Add('    and a.transaccion = b.transaccion                                    ');
       SQL.Add('    and a.empresa = b.empresa                                            ');
       SQL.Add('    and c.folio_Interno = b.folio_interno                                ');
       SQL.Add('    and c.item_omd      = b.item_omd                                     ');
       SQL.Add('    and c.transaccion   = b.transaccion                                  ');
       SQL.Add('    and c.empresa       = b.empresa                                      ');
/// DC 04/02/2013 agregue esto e inhibi lo que esta mas abajo...
       SQL.Add('    AND c.Fecha_desde = (SELECT MAX(f.Fecha_desde)                       ');
       SQL.Add('  			   FROM QS_TRA_OMD_MOTIVO_OMD f                  ');
       SQL.Add('  			       ,QS_TRA_OMD_DET_RF h                      ');
       SQL.Add('  			  WHERE h.nemotecnico = :Nemotecnico             ');
       SQL.Add('  			    and h.transaccion = :Transaccion             ');
       SQL.Add('  			    and h.cartera     = :Cartera                 ');
       SQL.Add('  			    and h.empresa     = :Empresa                 ');
       SQL.Add('                            AND h.folio_interno not in (SELECT g.folio                         ');
       SQL.Add('  			    				  FROM qs_ctr_anulacion g              ');
       SQL.Add('  			    				 WHERE g.folio       = h.folio_interno ');
       SQL.Add('  			    				   AND g.transaccion = h.transaccion   ');
       SQL.Add('  			    				   AND g.empresa     = h.empresa )     ');
       SQL.Add('  			    and f.Folio_Interno = h.FOLIO_INTERNO        ');
       SQL.Add('  			    AND f.TRANSACCION   = h.TRANSACCION          ');
       SQL.Add('  			    AND f.EMPRESA 	= h.EMPRESA              ');
       SQL.Add('  			    AND f.FECHA_DESDE   <= :Fecha                ');
       SQL.Add('  			    AND(f.Fecha_Hasta >= :Fecha  OR f.Fecha_Hasta IS NULL) ');
       SQL.Add('  			    )   ');
/////DC 04/02/2013 lo cambie por lo de arriba no considera fecha vigencia de la tabla  QS_TRA_OMD_MOTIVO_OMD
{
       SQL.Add('    AND a.Fecha_Operacion = (SELECT MAX(c.Fecha_Operacion)               ');
       SQL.Add('  			   FROM QS_TRA_OMD c                             ');
       SQL.Add('  			       ,QS_TRA_OMD_DET_RF d                      ');
       SQL.Add('  			  WHERE d.nemotecnico = :Nemotecnico             ');
       SQL.Add('  			    and d.transaccion = :Transaccion             ');
       SQL.Add('  			    and d.cartera     = :Cartera                 ');
       SQL.Add('  			    and d.empresa     = :Empresa                 ');
       SQL.Add('  			    and d.Folio_Interno = c.FOLIO_INTERNO        ');
       SQL.Add('  			    AND d.TRANSACCION   = c.TRANSACCION          ');
       SQL.Add('  			    AND d.EMPRESA 	= c.EMPRESA              ');
       SQL.Add('  			    AND c.Fecha_Operacion   <= :Fecha            ');
       SQL.Add('  			    AND c.folio_interno not in (SELECT f.folio                       ');
       SQL.Add('  			    				  FROM qs_ctr_anulacion f            ');
       SQL.Add('  			    				 WHERE f.folio = c.folio_interno     ');
       SQL.Add('  			    				   AND f.transaccion = c.transaccion ');
       SQL.Add('  			    				   AND f.empresa = c.empresa         ');
       SQL.Add('  			    			        )                                    ');
       SQL.Add('  			    )                                                                ');
}
/////DC 04/02/2013 lo cambie por lo de arriba no considera fecha vigencia de la tabla  QS_TRA_OMD_MOTIVO_OMD

       // Se incluyo con fecha 15-11-2006 para que tomara el ultimo motivo (caso dos compras el mismo día)
       if sDriver = 'ORACLE' then
          SQL.Add(' ORDER BY TO_NUMBER(a.folio_interno) DESC ')
       else
          SQL.Add(' ORDER BY cast(a.folio_interno as integer) DESC                                           ');




       ParamByName('Nemotecnico').AsString := sNemotecnico;
       ParamByName('Transaccion').AsString := sTransaccion;
       ParamByName('Cartera'    ).AsString := sCartera;
       ParamByName('Empresa'    ).AsString := sEmpresa;
       ParamByName('Fecha'      ).AsDateTime := dFecha_Cierre;

       Open;
       if FieldByName('COD_MOTIVO').IsNull then
          Result := ''
       else
          Result := FieldByName('COD_MOTIVO').AsString;
       Close;
    end;
end;
//------------------------------------------------------------------------------
function Busca_Motivo_Inv_RV( sEmpresa        : String;
                              sCartera        : String;
                              sTransaccion    : String;
                              sNemotecnico    : String;
                              dFecha_Cierre   : TDateTime) : String;

begin
// Cambios realizados por E.S. 06-10-2009, RV debe buscar los motivos desde la nueva tabla QS_TRA_OMD_MOTIVO_OMD
    WITH dmComunInversiones.QRY_General do
    begin
       SQL.Clear;
       SQL.Add('SELECT c.COD_MOTIVO,a.Folio_Interno                                      ');     // SELECT MOTIVO,a.Folio_Interno
       SQL.Add('  FROM QS_TRA_OMD         a                                                      ');
       SQL.Add('      ,QS_TRA_OMD_DET_RF  b                                               ');
       SQL.Add('      ,QS_TRA_OMD_MOTIVO  c                                           ');     // Nueva Tabla de Motivos RV
       SQL.Add('  WHERE b.nemotecnico = :Nemotecnico                                     ');
       SQL.Add('    and b.TRANSACCION = :Transaccion                                     ');
       SQL.Add('    AND b.CARTERA     = :Cartera                                         ');
       SQL.Add('    AND b.EMPRESA     = :Empresa                                         ');
       SQL.Add('    AND b.folio_interno not in (SELECT e.folio                           ');
       SQL.Add('    				  FROM qs_ctr_anulacion e                ');
       SQL.Add('    				 WHERE e.folio = b.folio_interno         ');
       SQL.Add('    				   AND e.transaccion = b.transaccion     ');
       SQL.Add('    				   AND e.empresa = b.empresa             ');
       SQL.Add('    				)                                        ');
       SQL.Add('    and a.folio_Interno = b.folio_interno                                ');
       SQL.Add('    and a.transaccion = b.transaccion                                    ');
       SQL.Add('    and a.empresa = b.empresa                                            ');
       SQL.Add('    and c.folio_Interno = b.folio_interno                                ');
       SQL.Add('    and c.item_omd      = b.item_omd                                     ');
       SQL.Add('    and c.transaccion   = b.transaccion                                  ');
       SQL.Add('    and c.empresa       = b.empresa                                      ');
/// DC 04/02/2013 agregue esto e inhibi lo que esta mas abajo...
       SQL.Add('    AND c.Fecha_desde = (SELECT MAX(f.Fecha_desde)                       ');
       SQL.Add('  			   FROM QS_TRA_OMD_MOTIVO f                  ');
       SQL.Add('  			       ,QS_TRA_OMD_DET_RF h                      ');
       SQL.Add('  			  WHERE h.nemotecnico = :Nemotecnico             ');
       SQL.Add('  			    and h.transaccion = :Transaccion             ');
       SQL.Add('  			    and h.cartera     = :Cartera                 ');
       SQL.Add('  			    and h.empresa     = :Empresa                 ');
       SQL.Add('                            AND h.folio_interno not in (SELECT g.folio                         ');
       SQL.Add('  			    				  FROM qs_ctr_anulacion g              ');
       SQL.Add('  			    				 WHERE g.folio       = h.folio_interno ');
       SQL.Add('  			    				   AND g.transaccion = h.transaccion   ');
       SQL.Add('  			    				   AND g.empresa     = h.empresa )     ');
       SQL.Add('  			    and f.Folio_Interno = h.FOLIO_INTERNO        ');
       SQL.Add('  			    AND f.TRANSACCION   = h.TRANSACCION          ');
       SQL.Add('  			    AND f.EMPRESA 	= h.EMPRESA              ');
       SQL.Add('  			    AND f.FECHA_DESDE   <= :Fecha                ');
       SQL.Add('  			    AND(f.Fecha_Hasta >= :Fecha  OR f.Fecha_Hasta IS NULL) ');
       SQL.Add('  			    )   ');
/////DC 04/02/2013 lo cambie por lo de arriba no considera fecha vigencia de la tabla  QS_TRA_OMD_MOTIVO
{
       SQL.Add('    AND a.Fecha_Operacion = (SELECT MAX(c.Fecha_Operacion)               ');
       SQL.Add('  			   FROM QS_TRA_OMD c                             ');
       SQL.Add('  			       ,QS_TRA_OMD_DET_RF d                      ');
       SQL.Add('  			  WHERE d.nemotecnico = :Nemotecnico             ');
       SQL.Add('  			    and d.transaccion = :Transaccion             ');
       SQL.Add('  			    and d.cartera     = :Cartera                 ');
       SQL.Add('  			    and d.empresa     = :Empresa                 ');
       SQL.Add('  			    and d.Folio_Interno = c.FOLIO_INTERNO        ');
       SQL.Add('  			    AND d.TRANSACCION   = c.TRANSACCION          ');
       SQL.Add('  			    AND d.EMPRESA 	= c.EMPRESA              ');
       SQL.Add('  			    AND c.Fecha_Operacion   <= :Fecha            ');
       SQL.Add('  			    AND c.folio_interno not in (SELECT f.folio                       ');
       SQL.Add('  			    				  FROM qs_ctr_anulacion f            ');
       SQL.Add('  			    				 WHERE f.folio = c.folio_interno     ');
       SQL.Add('  			    				   AND f.transaccion = c.transaccion ');
       SQL.Add('  			    				   AND f.empresa = c.empresa         ');
       SQL.Add('  			    			        )                                    ');
       SQL.Add('  			    )                                                                ');
}
/////DC 04/02/2013 lo cambie por lo de arriba no considera fecha vigencia de la tabla  QS_TRA_OMD_MOTIVO

       // Se incluyo con fecha 15-11-2006 para que tomara el ultimo motivo (caso dos compras el mismo día)
       if sDriver = 'ORACLE' then
          SQL.Add(' ORDER BY TO_NUMBER(a.folio_interno) DESC ')
       else
          SQL.Add(' ORDER BY cast(a.folio_interno as integer) DESC                                           ');




       ParamByName('Nemotecnico').AsString := sNemotecnico;
       ParamByName('Transaccion').AsString := sTransaccion;
       ParamByName('Cartera'    ).AsString := sCartera;
       ParamByName('Empresa'    ).AsString := sEmpresa;
       ParamByName('Fecha'      ).AsDateTime := dFecha_Cierre;

       Open;
       if FieldByName('COD_MOTIVO').IsNull then
          Result := ''
       else
          Result := FieldByName('COD_MOTIVO').AsString;
       Close;
    end;
end;
//------------------------------------------------------------------------------
function Calcula_Intereses_Acum(sTipo_Instrum          : String;
                                sEmisor                : String;
                                sInstrumento           : String;
                                sSerie                 : String;
                                sNemotecnico           : String;
                                fTasa_Emision          : Double;
                                fTasa_Mercado          : Double;
                                sMoneda_Instrum        : String;
                                sTipo_Nominales        : String;
                                dFecha_Emision         : TDateTime;
                                dFecha_Vencimiento     : TDateTime;
                                dFecha_Operacion       : TDateTime;
                                sMoneda_Operacion      : String;
                                fNominales             : Double;
                                fValor_Invertido_MC    : Double;
                                RegDes                 : TReg_descriptor;
                                var Array_Mem_Desarr       : TArray_Mem_Desarr;
                                dFecha_UltVcto         : TDateTime;
                                dFecha_Compra          : TDateTime;
                                dFecha_Tope            : TDateTime;  //venta o vencimiento.
                                var fInteres_Acumulado : Double;
                                var fDeveng_Acumulado  : DOuble;
                                var sModuloErr         : String;
                                var sStringErr         : String) : Boolean;
var fInteres_Periodo
   ,fDeveng_Periodo           : Double;
    dFecha_Inicio
   ,dFecha_Termino            : TDateTime;
    bResultado                : Boolean;
    mm
   ,dd
   ,aa                        : Word;
begin

   bResultado := True;

   ///  Buscar ultimo dias del mes entre fecha de ultimo vcto y actual
   ///  llamar Intereses_Acumulados_VAL entre cada uno de los rangos
   ///  1/1 al 31/1 + 31/1 al 28/2 + 28/2 a la venta o vencimiento

   dFecha_Inicio := dFecha_UltVcto;
   if (dFecha_Inicio < dFecha_Compra) then
      dFecha_Inicio := dFecha_Compra;

   fInteres_Acumulado := 0;
   fDeveng_Acumulado  := 0;

   while dFecha_inicio < dFecha_Tope do
   begin

      bResultado := True;

      DecodeDate(dFecha_inicio+1, aa, mm, dd);
      dFecha_Termino := Encodedate(aa, mm, ultimo_dia_mes(mm,aa));
      if (dFecha_Termino > dFecha_Tope) then
         dFecha_Termino := dFecha_Tope;

      fInteres_Periodo := 0;
      fDeveng_Periodo  := 0;

      Intereses_Acumulados_VAL(sTipo_Instrum
                              ,sEmisor
                              ,sInstrumento
                              ,sSerie
                              ,sNemotecnico
                              ,fTasa_Emision
                              ,fTasa_Mercado
                              ,sMoneda_Instrum
                              ,sTipo_Nominales
                              ,dFecha_Emision
                              ,dFecha_Vencimiento
                              ,dFecha_Operacion
                              ,sMoneda_Operacion
                              ,fNominales
                              ,0
                              ,dFecha_Inicio   //Desde
                              ,dFecha_Termino  //Hasta
                              ,'NO'
                              ,fNominales
                              ,fValor_Invertido_MC
                              ,''              //Reg_Val_In.Proceso_Valuacion
                              ,RegDes
                              ,Array_Mem_Desarr
                              ,fInteres_Periodo
                              ,fDeveng_Periodo
                              ,sModuloErr
                              ,sStringErr
                              ,bResultado);
      if Not bResultado then
      begin
         break;
      end;

      fInteres_Acumulado  := fInteres_Acumulado + fInteres_Periodo;
      fDeveng_Acumulado   := fDeveng_Acumulado + fDeveng_Periodo;

      dFecha_Inicio             := dFecha_Termino;

   end;

   Result := bResultado;

end;

procedure Intereses_Acumulados_Ahorros(sNemotecnico                 : String;
                                       dFecha_Desde                 : TDateTime;
                                       dFecha_Hasta                 : TDateTime;
                                       var Deveng_Desde_El_Vcto_Ant : Double;
                                       var Deveng_Desde_El_Vcto_Act : Double;
                                       var sModulo_Err              : String;
                                       var sString_Err              : String;
                                       var Result                   : Boolean);
Begin
  WITH DM_Rutinas_Informes.Qry_General do
  begin
    Deveng_Desde_El_Vcto_Ant := 0;
    Deveng_Desde_El_Vcto_Act := 0;

    SQL.Clear;
    SQL.Add('SELECT interes_devengado            ');
    SQL.Add('FROM QS_RES_AHORROS                 ');
    SQL.Add('WHERE nemotecnico = :nemotecnico    ');
    SQL.Add('and fecha_cierre  = :fecha_cierre   ');
    ParamByName('Nemotecnico').AsString          := sNemotecnico;
    ParamByName('fecha_cierre'      ).AsDateTime := dFecha_Desde;
    Open;

    if Not FieldByName('interes_devengado').isNull then
       Deveng_Desde_El_Vcto_Ant := FieldByName('interes_devengado').AsFloat;
    close;

    ParamByName('Nemotecnico').AsString          := sNemotecnico;
    ParamByName('fecha_cierre'      ).AsDateTime := dFecha_Hasta;
    Open;
    if Not FieldByName('interes_devengado').isNull then
       Deveng_Desde_El_Vcto_Act := FieldByName('interes_devengado').AsFloat;
    Close;
  end;
end;

procedure Pagos_Capitalizaciones_Periodo(sNemotecnico            : String;
                                       dFecha_Desde              : TDateTime;
                                       dFecha_Hasta              : TDateTime;
                                       sMoneda_Instrum           : String;
                                       sMoneda_Iteracion         : String;
                                       var fCapitalizado_Periodo_UM : Double;
                                       var fCapitalizado_Periodo : Double;
                                       var fInterest_92_UM          : Double;
                                       var fInterest_92          : Double;
                                       var sModulo_Err           : String;
                                       var sString_Err           : String;
                                       var Result                : Boolean);
Var
f_Interest_92 : Double;
f_Capitalizado_Periodo : Double;

Begin
  WITH DM_Rutinas_Informes.Qry_General do
  begin
    fCapitalizado_Periodo := 0;
    fInterest_92 := 0;
    SQL.Clear;
    SQL.Add('SELECT fecha_cierre, sum(pagos) as pagos                        ');
    SQL.Add('FROM QS_RES_AHORROS                                             ');
    SQL.Add('WHERE nemotecnico = :nemotecnico                                ');
    SQL.Add('and fecha_cierre > :fecha_desde and fecha_cierre <= :fecha_hasta');
    SQL.Add('and pagos > 0                                                   ');
    SQL.Add('GROUP BY fecha_cierre ');
    ParamByName('Nemotecnico').AsString          := sNemotecnico;
    ParamByName('fecha_desde'       ).AsDateTime := dFecha_Desde;
    ParamByName('fecha_hasta'       ).AsDateTime := dFecha_Hasta;
    Open;
    //if Not FieldByName('pagos').isNull then
    //   fInterest_92 := FieldByName('pagos').AsFloat;
    fInterest_92 := 0;
    fInterest_92_UM := 0;
    While not eof do
    begin
         f_Interest_92 := 0;
         Conversion_unidad_mon(sMoneda_Instrum
                              ,sMoneda_Iteracion
                              ,'BC'
                              ,FieldByName('fecha_cierre').AsFloat
                              ,FieldByName('pagos').AsFloat
                              ,f_Interest_92
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
         if not Result then
         begin
            //sModuloErr := sModulo_Err+' '+sDPart;
            Add_Log_Message(''    //FieldByName('Folio_Interno').AsString
                           ,''    //FieldByName('Transaccion'  ).AsString
                           ,0     //FieldByName('Item_Omd'     ).AsFloat
                           ,sNemotecnico+' : '
                            +sString_Err
                           ,sModulo_Err);
         end;
         fInterest_92 := fInterest_92 + f_Interest_92;
         fInterest_92_UM := fInterest_92_UM + FieldByName('pagos').AsFloat;
       Next;
    end;
    close;
    SQL.Clear;

    SQL.Add('SELECT fecha_cierre, sum(capitalizaciones) as capitalizaciones          ');
    SQL.Add('FROM QS_RES_AHORROS                 ');
    SQL.Add('WHERE nemotecnico = :nemotecnico    ');
    SQL.Add('and fecha_cierre > :fecha_desde and fecha_cierre <= :fecha_hasta  ');
    SQL.Add('and capitalizaciones > 0                                                   ');
    SQL.Add('GROUP BY fecha_cierre ');
    ParamByName('Nemotecnico').AsString          := sNemotecnico;
    ParamByName('fecha_desde'       ).AsDateTime := dFecha_Desde;
    ParamByName('fecha_hasta'       ).AsDateTime := dFecha_Hasta;
    Open;
    //if Not FieldByName('capitalizaciones').isNull then
    //   fCapitalizado_Periodo := FieldByName('capitalizaciones').AsFloat;
    fCapitalizado_Periodo := 0;
    While not eof do
    begin
         f_Capitalizado_Periodo := 0;
         Conversion_unidad_mon(sMoneda_Instrum
                              ,sMoneda_Iteracion
                              ,'BC'
                              ,FieldByName('fecha_cierre').AsFloat
                              ,FieldByName('capitalizaciones').AsFloat
                              ,f_Capitalizado_Periodo
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
         if not Result then
         begin
            //sModuloErr := sModulo_Err+' '+sDPart;
            Add_Log_Message(''    //FieldByName('Folio_Interno').AsString
                           ,''    //FieldByName('Transaccion'  ).AsString
                           ,0     //FieldByName('Item_Omd'     ).AsFloat
                           ,sNemotecnico+' : '
                            +sString_Err
                           ,sModulo_Err);
         end;
         fCapitalizado_Periodo := fCapitalizado_Periodo + f_Capitalizado_Periodo;
         fCapitalizado_Periodo_UM := fCapitalizado_Periodo_UM + FieldByName('capitalizaciones').AsFloat;
       Next;
    end;
    Close;
  end;
end;
procedure IncDec_por_Diferencia_Curvas( sTipoInstrumento                                  : String;
                                        RegDes                                            : TReg_Descriptor;
                                        dFecha_Emision                                    : TDateTime;
                                        dFecha_Vencimiento                                : TDateTime;
                                        dFecha_Calculo                                    : TDateTime;
                                        dFecha_Compra                                     : TDateTime;
                                        fNominales_Vigentes                               : Double;
                                        //Array_Mem_Desarr                                  : TArray_Mem_Desarr;
                                        fSaldo_Insoluto_Cpa                               : Double;
                                        fActual_Cost_UM                                   : Double;
                                        fTasa_Calculo                                     : Double;
                                        fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM     : Double;
                                        fReajuste_NoIndex_Acumulado_Actual_Cost_Actual_UM : Double;
                                        var Reg_Val_In                                    : TRegistro_Valoriza_In;
                                        var Reg_Val_Out                                   : TRegistro_Valoriza_Out;
                                        var fIncrease_Decrease_Total                      : Double;
                                        var fIncrease_Decrease_To_Maturity_Cpa            : Double;
                                        var fIncrease_Decrease_To_Maturity_Act            : Double;
                                        var sModulo_Err                                   : String;
                                        var sString_Err                                   : String;
                                        var Result                                        : Boolean
                                        );
var
  fSaldo_Insoluto_Act         : Double;
  fSaldo_Insoluto_Act_ConRea  : Double;
  sTipo_Valuac                : String;
  sFormula_Pte                : String;
  fBase_Precio                : Double;
  sMon_Ind                    : String;
  sOrigen                     : String;

begin
  Saldo_Insoluto(sTipoInstrumento
                ,RegDes
                ,dFecha_Emision
                ,dFecha_Calculo
                ,dFecha_Compra     //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                ,fNominales_Vigentes
                ,Reg_Val_Out.Array_Mem_Desarr  //,Array_Mem_Desarr
                ,False
                ,fSaldo_Insoluto_Act
                ,fSaldo_Insoluto_Act_ConRea
                ,sModulo_Err
                ,sString_Err
                ,Result);

  if NOT Result then
     exit;

  // Siguiente metodo solo aplica a titulos con flujos conocidos
  // Es decir sin variación cambiaria y sin Tasa en Flujos F.I. 07-06-2006
  // Lo especial que tiene es que calcula Increase / Decrease como la diferencia entre el
  // Saldo insoluto y el valor presente LIMPIO a tir de compra

  fIncrease_Decrease_To_Maturity_Cpa := fSaldo_Insoluto_Cpa - fActual_Cost_UM;
  if dFecha_Calculo = dFecha_Compra then
  begin
     // A la fecha de compra no realizo el calculo como valor PTE ya que por la diferencia en
     // los calculos por tasa puede dar diferencia
     fIncrease_Decrease_To_Maturity_Act :=  fIncrease_Decrease_To_Maturity_Cpa;
     fIncrease_Decrease_Total           :=  0;
  end
  else
    if dFecha_Calculo = dFecha_Vencimiento then
    begin
       fIncrease_Decrease_To_Maturity_Act :=  0;
       fIncrease_Decrease_Total           :=  fIncrease_Decrease_To_Maturity_Cpa;;
    end
    else
    begin
       // Se hace esta execpcion para instrumentos comprados a la PAR
       // Ya que con el metodo se produce una inconsistencia
       // OJO Solo se hace cuando esta el parametro marcado en GAAP o sea queda en manos del usuario
       if (fIncrease_Decrease_To_Maturity_Cpa = 0) and
          (bAnula_Devengamiento_INCDEC)            then
       begin
          fIncrease_Decrease_To_Maturity_Act :=  0;
          fIncrease_Decrease_Total           :=  0;
       end
       else
       begin
          Reg_Val_In.sComponentes_Descuento  := '';
          Reg_Val_In.sValor_Cupon_Original   := 'N';
          Reg_Val_In.Valoriza_Par_Pte     := 'AMBOS';
          Reg_Val_Out.TasaCalculo         := fTasa_Calculo;
          Reg_Val_In.dFechaCalculo        := dFecha_Calculo;
          Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;

        // Se incopora el determinar si existe metodo de valuacion para proceso PRESENTE
        // Esto producto de la incorporación de la tasa real de Interseguros 29-05-2007
        Reg_Val_In.Proceso_Valuacion    := 'OMD_TASA';
        Reg_Val_In.Valoriza_Par_Pte     := 'VAL';

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

        if sTipo_Valuac <> '' then
        begin
           // Calcula Valor Presente segun valuacion
           Valoriza_Registro(Reg_Val_In,
                             Reg_Val_Out,
                             sModulo_Err,
                             sString_Err,
                             Result);
           if not Result then
              exit;

           Reg_Val_In.Valoriza_Par_Pte     := 'PAR';

           // Calcula Valor PAR (Se necesita y el de arriba no o entrega
           Valoriza_Registro(Reg_Val_In,
                             Reg_Val_Out,
                             sModulo_Err,
                             sString_Err,
                             Result);
        end
        else
        begin
           // VALOR PTE A Fecha de Calculo
           // cjf 14/06/2007
           Reg_Val_In.Valoriza_Par_Pte     := 'AMBOS';
           //
           Valoriza_Registro(Reg_Val_In,
                             Reg_Val_Out,
                             sModulo_Err,
                             sString_Err,
                             Result);
        end;

        if not Result then
           exit;

        // OJO: Los intereses devengados a la fecha de calculo son lo mismo que el VALOR PAR - Saldo_Insoluto
        // Por lo cual le resto esta diferencia al valor presente calculado


        // fReajuste_Actual_Cost_Total, esta variable corresponde al reajuste de actual cost o capital residual
        // calculado mas arriba
        // y la resta para el calculo del interes se tiene que hacer con el saldo insoluto reajustado
        // cj
        if (sTipo_Reajuste_en_Book_Value = 'Reajustes_Sobre_Capital_Residual') then
            Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM -
                                            fReajuste_NoIndex_Acumulado_Saldo_Insoluto_UM
        else
            Reg_Val_Out.ValorInvertidoUM := Reg_Val_Out.ValorInvertidoUM -
                                            fReajuste_NoIndex_Acumulado_Actual_Cost_Actual_UM;

        fIncrease_Decrease_To_Maturity_Act :=  fSaldo_Insoluto_Act -
                                               (Reg_Val_Out.ValorInvertidoUM -
                                               (Reg_Val_Out.Valor_Par_UM - fSaldo_Insoluto_Act_ConRea )); // ==> este es el interes devengado al calculo

        fIncrease_Decrease_Total := fIncrease_Decrease_To_Maturity_Cpa - fIncrease_Decrease_To_Maturity_Act;
     end;
  end;
end;

procedure IncDec_por_TIRK ( sTipoInstrumento                                  : String;
                            RegDes                                            : TReg_Descriptor;
                            dFecha_Emision                                    : TDateTime;
                            dFecha_Calculo                                    : TDateTime;
                            dFecha_Compra                                     : TDateTime;
                            dFecha_Vencimiento                                : TDateTime;
                            fNominales_Vigentes                               : Double;
                            Array_Mem_Desarr                                  : TArray_Mem_Desarr;
                            fSaldo_Insoluto_Cpa                               : Double;
                            fActual_Cost_UM                                   : Double;
                            var Reg_Val_In                                    : TRegistro_Valoriza_In;
                            var Reg_Val_Out                                   : TRegistro_Valoriza_Out;
                            var fTir_Capital_Cpa                              : Double;
                            var fIncrease_Decrease_Total                      : Double;
                            var fIncrease_Decrease_To_Maturity_Cpa            : Double;
                            var fIncrease_Decrease_To_Maturity_Act            : Double;
                            var sModulo_Err                                   : String;
                            var sString_Err                                   : String;
                            var Result                                        : Boolean
                            );
var
   fSaldo_Insoluto_Act        : Double;
   fSaldo_Insoluto_Act_ConRea : Double;
   fValor_PTE_TirK_Cpa        : Double;
   fValor_PTE_TirK_Act        : Double;
   fCapitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado : Double;

begin
        if dFecha_Calculo = dFecha_Vencimiento then
        begin
           fSaldo_Insoluto_Act := 0;
           fSaldo_Insoluto_Act_ConRea := 0;
        end
        else
           Saldo_Insoluto_Segun_Compra( sTipoInstrumento
                                       ,RegDes
                                       ,dFecha_Emision
                                       ,dFecha_Calculo
                                       ,dFecha_Compra   // 09-11-2015 F.I.
                                       ,fNominales_Vigentes
                                       ,Array_Mem_Desarr
                                       ,False
                                       ,fSaldo_Insoluto_Act
                                       ,fSaldo_Insoluto_Act_ConRea
                                       ,fCapitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result);

        if NOT Result then
        begin
           Reg_Val_In.sComponentes_Descuento  := '';
           Reg_Val_In.sValor_Cupon_Original   := 'N';
           exit;
        end;

          Reg_Val_In.Valoriza_Par_Pte        := 'TIR';
          Reg_Val_Out.ValorInvertidoUM       := fActual_Cost_UM;
          Reg_Val_Out.ValorInvertidoMC       := 0;
          Reg_Val_In.sValor_Cupon_Original   := 'S';
          Reg_Val_In.sComponentes_Descuento  := 'AMORTIZACION';
          Reg_Val_Out.TasaCalculo            := 0;
          Reg_Val_In.dFechaCalculo           := dFecha_Compra; // Fecha de Calculo
          Reg_Val_In.dFechaCalculoOriginal   := Reg_Val_In.dFechaCalculo;

          Valoriza_Registro(Reg_Val_In,
                            Reg_Val_Out,
                            sModulo_Err,
                            sString_Err,
                            Result);

          if not Result then
          begin
             Reg_Val_In.sComponentes_Descuento  := '';
             Reg_Val_In.sValor_Cupon_Original   := 'N';
             exit;
          end;
          fTir_Capital_Cpa := Reg_Val_Out.TasaCalculo;

          // Calculo Valor Presente a la Compra segun Tir de Capital
          Reg_Val_In.Valoriza_Par_Pte   := 'PTE';
          Reg_Val_Out.TasaCalculo       := fTir_Capital_Cpa;

          if (SAmortizacion_Actual_Cost_base = 'Amortizacion_Capital_TIR_Capital') then
              Reg_Val_In.sComponentes_Descuento  := 'AMORTIZ_TIRK';

          Valoriza_Registro(Reg_Val_In,
                            Reg_Val_Out,
                            sModulo_Err,
                            sString_Err,
                            Result);
          if not Result then
          begin
             Reg_Val_In.sComponentes_Descuento  := '';
             Reg_Val_In.sValor_Cupon_Original   := 'N';
             exit;
          end;

          fValor_PTE_TirK_Cpa := Reg_Val_Out.ValorInvertidoUM;

          fIncrease_Decrease_To_Maturity_Cpa := fSaldo_Insoluto_Cpa - fValor_PTE_TirK_Cpa;

          // Calculo Valor Presente a la Fecha de Calculo segun Tir de Capital
          Reg_Val_In.Valoriza_Par_Pte   := 'PTE';
          Reg_Val_Out.TasaCalculo       := fTir_Capital_Cpa;
          Reg_Val_In.dFechaCalculo      := dFecha_Calculo;       // Fecha de Calculo
          Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
          Reg_Val_In.sComponentes_Descuento  := 'AMORTIZACION';
     //     if dFecha_Calculo = dFecha_Compra then
             Reg_Val_In.Con_Cupon          := False;
     //     else
     //        Reg_Val_In.Con_Cupon          := True;

          Valoriza_Registro(Reg_Val_In,
                            Reg_Val_Out,
                            sModulo_Err,
                            sString_Err,
                            Result);

          Reg_Val_In.sComponentes_Descuento  := '';
          Reg_Val_In.sValor_Cupon_Original   := 'N';

          if not Result then
             exit;

          fValor_PTE_TirK_Act := Reg_Val_Out.ValorInvertidoUM;

          fIncrease_Decrease_To_Maturity_Act :=  fSaldo_Insoluto_Act - fValor_PTE_TirK_Act;
          fIncrease_Decrease_Total := fIncrease_Decrease_To_Maturity_Cpa - fIncrease_Decrease_To_Maturity_Act;
end;

procedure Inc_Dec_Lineal( dFecha_Calculo                          : TDateTime;
                          dFecha_Compra                           : TDateTime;
                          dFecha_Vencimiento                      : TDateTime;
                          fSaldo_Insoluto_Cpa                     : Double;
                          fActual_Cost_UM                         : Double;
                          sTipoCalculoDias                        : String;
                          sPais_Tasa                              : String;
                          var fDif_Precio                         : Double;
                          var fIncrease_Decrease_Total            : Double;
                          var fIncrease_Decrease_To_Maturity_Cpa  : Double;
                          var fIncrease_Decrease_To_Maturity_Act  : Double
                         );
var
   fDif_Dias                    : Double;
   iAnosEnteros                 : Double;
   iAnosFraccion                : Double;
   iMesesEnteros                : Double;

begin
        Calculo_de_dias(dFecha_Compra,
                        dFecha_Vencimiento,
                        sTipoCalculoDias,
                        sPais_Tasa,
                        fDif_Dias,
                        iAnosEnteros,
                        iAnosFraccion,
                        iMesesEnteros);


        if fDif_Dias <> 0 then
          fDif_Precio := (fSaldo_Insoluto_Cpa - fActual_Cost_UM) / fDif_Dias
        else
          fDif_Precio := 0;

        Calculo_de_dias(dFecha_Compra,
                        dFecha_Calculo,
                        sTipoCalculoDias,
                        sPais_Tasa,
                        fDif_Dias,
                        iAnosEnteros,
                        iAnosFraccion,
                        iMesesEnteros);

        // Entre Compra y Calculo ....
        // ESTA EN UM !!!!
        fIncrease_Decrease_Total :=  fDif_Precio *
                                     fDif_Dias;


        // fIncrease_Decrease_To_Maturity_Act := fIncrease_Decrease_To_Maturity_Act - fIncrease_Decrease_Total;

        // Inc / Dec Lineal
        Calculo_de_dias(dFecha_Calculo   ,
                        dFecha_Vencimiento,
                        sTipoCalculoDias ,
                        sPais_Tasa,
                        fDif_Dias,
                        iAnosEnteros,
                        iAnosFraccion,
                        iMesesEnteros);

         fIncrease_Decrease_To_Maturity_Act :=  fDif_Precio * fDif_Dias;

end;

end.
