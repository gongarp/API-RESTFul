unit DM_Valorizacion;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Wwquery, Wwtable, DM_Variables_Valorizacion;

type
  TDMValorizacion = class(TDataModule)
    Qry_General: TwwQuery;
    Qry_General2: TwwQuery;
    T_Res_Mercado: TwwTable;
    T_Res_MercadoEmpresa: TStringField;
    T_Res_MercadoCartera: TStringField;
    T_Res_MercadoTransaccion: TStringField;
    T_Res_MercadoFolio_interno: TStringField;
    T_Res_MercadoItem_OMD: TFloatField;
    T_Res_MercadoFecha_Cierre: TDateTimeField;
    T_Res_MercadoFecha_Operacion: TDateTimeField;
    T_Res_MercadoNemotecnico: TStringField;
    T_Res_MercadoEmisor: TStringField;
    T_Res_MercadoInstrumento: TStringField;
    T_Res_MercadoSerie: TStringField;
    T_Res_MercadoValor_Nominal: TFloatField;
    T_Res_MercadoTasa_Compra: TFloatField;
    T_Res_MercadoValor_Pte_um_Cpa: TFloatField;
    T_Res_MercadoValor_Pte_mc_Cpa: TFloatField;
    T_Res_MercadoPor_Valor_Par_Cpa: TFloatField;
    T_Res_MercadoPlazo_al_Vcto: TFloatField;
    T_Res_MercadoTasa_Mercado_Mdo: TFloatField;
    T_Res_MercadoValor_Pte_um_Mdo: TFloatField;
    T_Res_MercadoValor_Pte_mc_Mdo: TFloatField;
    T_Res_MercadoPor_Valor_Par_Mdo: TFloatField;
    T_Res_MercadoDuration: TFloatField;
    T_Res_MercadoDiferencia: TFloatField;
    T_Res_MercadoClasif_Riesgo: TStringField;
    T_Res_MercadoComprometido: TStringField;
    T_Res_MercadoMoneda_Instrum: TStringField;
    T_Res_MercadoFecha_emision: TDateTimeField;
    T_Res_MercadoFecha_vcto: TDateTimeField;
    T_Res_MercadoTasa_emision: TFloatField;
    T_Res_MercadoFactor_Riesgo: TFloatField;
    T_Res_MercadoValorizacion_Mixta: TFloatField;
    T_Res_MercadoPrecio_Mixto: TFloatField;
    T_Res_MercadoMotivo_Inv: TStringField;
    T_Res_MercadoSaldo_Insoluto: TFloatField;
    T_Res_MercadoDuration_Mod: TFloatField;
    T_Res_MercadoConvexidad: TFloatField;
    T_Res_MercadoValor_Pte_mc_i_Cpa: TFloatField;
    T_Res_MercadoValor_Pte_mc_I_Mer: TFloatField;
    T_Res_MercadoFecha_Last_Cierre: TDateTimeField;
    T_Tes_Egring: TwwTable;
    T_Tes_EgringEMPRESA: TStringField;
    T_Tes_EgringTRANSACCION: TStringField;
    T_Tes_EgringFOLIO_INTERNO: TStringField;
    T_Tes_EgringTIPO_MOVIMIENTO: TStringField;
    T_Tes_EgringCARTERA: TStringField;
    T_Tes_EgringMONEDA_CARTERA: TStringField;
    T_Tes_EgringFECHA_MOV: TDateTimeField;
    T_Tes_EgringAMORTIZACION_UM: TFloatField;
    T_Tes_EgringSALDO_INSOLUTO: TFloatField;
    T_Tes_EgringVALOR_NOMINAL: TFloatField;
    T_Tes_EgringMONTO_UM_MOVIMIENTO: TFloatField;
    T_Tes_EgringMONTO_MC_MOVIMIENTO: TFloatField;
    T_Tes_EgringNEMOTECNICO: TStringField;
    T_Tes_EgringFECHA_PAGO: TDateTimeField;
    T_Tes_EgringMONTO_UM_PAGADO: TFloatField;
    T_Tes_EgringMONTO_MC_PAGADO: TFloatField;
    T_Tes_EgringFECHA_EMISION_PAGO: TDateTimeField;
    T_Tes_EgringTRANSACCION_OMD: TStringField;
    T_Tes_EgringFOLIO_INTERNO_OMD: TStringField;
    T_Tes_EgringITEM_OMD: TFloatField;
    T_Tes_EgringNRO_CUPON: TFloatField;
    T_Stock: TwwTable;
    T_StockEmpresa: TStringField;
    T_StockTransaccion: TStringField;
    T_StockFolio_interno: TStringField;
    T_StockItem_OMD: TFloatField;
    T_StockFecha_Operacion: TDateTimeField;
    T_Stockfecha_stock: TDateTimeField;
    T_StockNemotecnico: TStringField;
    T_StockEmisor: TStringField;
    T_StockInstrumento: TStringField;
    T_StockSerie: TStringField;
    T_StockFecha_Emision: TDateTimeField;
    T_StockFecha_Vencimiento: TDateTimeField;
    T_StockValor_Nominal: TFloatField;
    T_StockValor_Nominal_Calculo: TFloatField;
    T_StockTasa_Emision: TFloatField;
    T_StockTasa_Mercado: TFloatField;
    T_StockMoneda_Instrum: TStringField;
    T_StockTasa_Base_par: TStringField;
    T_StockTasa_Base_Tir: TStringField;
    T_StockValor_Pte_um_Cpa: TFloatField;
    T_StockValor_Pte_mc_Cpa: TFloatField;
    T_StockPorcen_Valor_Par: TFloatField;
    T_StockCartera: TStringField;
    T_StockMoneda_Pacto: TStringField;
    T_StockTasa_pacto: TFloatField;
    T_StockTasa_Base_Pacto: TStringField;
    T_StockFecha_Vcto_pacto: TDateTimeField;
    T_StockTipo_Nominales: TStringField;
    T_StockCustodia: TStringField;
    T_StockPlazo_al_Vcto: TFloatField;
    T_StockTipo_Instrum: TStringField;
    T_StockValor_Pte_um_Mdo: TFloatField;
    T_StockValor_Pte_mc_Mdo: TFloatField;
    T_StockTasa_Mercado_Mdo: TFloatField;
    T_StockDuration: TFloatField;
    T_StockPlazo_Vcto: TStringField;
    T_StockDiferencia: TFloatField;
    T_StockValorizacion_Mixta: TFloatField;
    T_StockPrecio_Mixto: TFloatField;
    T_StockMotivo_Inv: TStringField;
    T_StockClasif_Riesgo: TStringField;
    T_Res_Mercado_Ad : TwwTable;
    Tmp_Res_Mercado_CC: TwwTable;
    Tmp_Res_Mercado_CCFecha: TDateTimeField;
    Tmp_Res_Mercado_CCEmpresa: TStringField;
    Tmp_Res_Mercado_CCCartera: TStringField;
    Tmp_Res_Mercado_CCTransaccion: TStringField;
    Tmp_Res_Mercado_CCFolio_interno: TStringField;
    Tmp_Res_Mercado_CCItem_OMD: TFloatField;
    Tmp_Res_Mercado_CCEmisor: TStringField;
    Tmp_Res_Mercado_CCInstrumento: TStringField;
    Tmp_Res_Mercado_CCSerie: TStringField;
    Tmp_Res_Mercado_CCNemotecnico: TStringField;
    Tmp_Res_Mercado_CCValor_Nominal: TFloatField;
    Tmp_Res_Mercado_CCValor_Pte_mc_Cpa: TFloatField;
    Tmp_Res_Mercado_CCValor_Pte_mc_Mdo: TFloatField;
    Tmp_Res_Mercado_CCValor_Pte_mc_Mixta: TFloatField;
    Tmp_Res_Mercado_Ad: TwwTable;
    Tmp_Stock: TwwTable;
    Tmp_StockEmpresa: TStringField;
    Tmp_StockTransaccion: TStringField;
    Tmp_StockFolio_interno: TStringField;
    Tmp_StockItem_OMD: TFloatField;
    Tmp_StockFecha_Operacion: TDateTimeField;
    Tmp_Stockfecha_stock: TDateTimeField;
    Tmp_StockNemotecnico: TStringField;
    Tmp_StockEmisor: TStringField;
    Tmp_StockInstrumento: TStringField;
    Tmp_StockSerie: TStringField;
    Tmp_StockFecha_Emision: TDateTimeField;
    Tmp_StockFecha_Vencimiento: TDateTimeField;
    Tmp_StockValor_Nominal: TFloatField;
    Tmp_StockValor_Nominal_Calculo: TFloatField;
    Tmp_StockTasa_Emision: TFloatField;
    Tmp_StockTasa_Mercado: TFloatField;
    Tmp_StockMoneda_Instrum: TStringField;
    Tmp_StockTasa_Base_par: TStringField;
    Tmp_StockTasa_Base_Tir: TStringField;
    Tmp_StockValor_Pte_um_Cpa: TFloatField;
    Tmp_StockValor_Pte_mc_Cpa: TFloatField;
    Tmp_StockPorcen_Valor_Par: TFloatField;
    Tmp_StockCartera: TStringField;
    Tmp_StockMoneda_Pacto: TStringField;
    Tmp_StockTasa_pacto: TFloatField;
    Tmp_StockTasa_Base_Pacto: TStringField;
    Tmp_StockFecha_Vcto_pacto: TDateTimeField;
    Tmp_StockTipo_Nominales: TStringField;
    Tmp_StockCustodia: TStringField;
    Tmp_StockPlazo_al_Vcto: TFloatField;
    Tmp_StockTipo_Instrum: TStringField;
    Tmp_StockValor_Pte_um_Mdo: TFloatField;
    Tmp_StockValor_Pte_mc_Mdo: TFloatField;
    Tmp_StockTasa_Mercado_Mdo: TFloatField;
    Tmp_StockDuration: TFloatField;
    Tmp_StockPlazo_Vcto: TStringField;
    Tmp_StockDiferencia: TFloatField;
    Tmp_StockValorizacion_Mixta: TFloatField;
    Tmp_StockPrecio_Mixto: TFloatField;
    Tmp_StockMotivo_Inv: TStringField;
    Tmp_StockClasif_Riesgo: TStringField;
    Tmp_Res_Mercado: TwwTable;
    Tmp_Res_MercadoEmpresa: TStringField;
    Tmp_Res_MercadoCartera: TStringField;
    Tmp_Res_MercadoTransaccion: TStringField;
    Tmp_Res_MercadoFolio_interno: TStringField;
    Tmp_Res_MercadoItem_OMD: TFloatField;
    Tmp_Res_MercadoFecha_Cierre: TDateTimeField;
    Tmp_Res_MercadoFecha_Operacion: TDateTimeField;
    Tmp_Res_MercadoNemotecnico: TStringField;
    Tmp_Res_MercadoEmisor: TStringField;
    Tmp_Res_MercadoInstrumento: TStringField;
    Tmp_Res_MercadoSerie: TStringField;
    Tmp_Res_MercadoValor_Nominal: TFloatField;
    Tmp_Res_MercadoTasa_Compra: TFloatField;
    Tmp_Res_MercadoValor_Pte_um_Cpa: TFloatField;
    Tmp_Res_MercadoValor_Pte_mc_Cpa: TFloatField;
    Tmp_Res_MercadoPor_Valor_Par_Cpa: TFloatField;
    Tmp_Res_MercadoPlazo_al_Vcto: TFloatField;
    Tmp_Res_MercadoTasa_Mercado_Mdo: TFloatField;
    Tmp_Res_MercadoValor_Pte_um_Mdo: TFloatField;
    Tmp_Res_MercadoValor_Pte_mc_Mdo: TFloatField;
    Tmp_Res_MercadoPor_Valor_Par_Mdo: TFloatField;
    Tmp_Res_MercadoDuration: TFloatField;
    Tmp_Res_MercadoDuration_Mod: TFloatField;
    Tmp_Res_MercadoConvexidad: TFloatField;
    Tmp_Res_MercadoDiferencia: TFloatField;
    Tmp_Res_MercadoClasif_Riesgo: TStringField;
    Tmp_Res_MercadoComprometido: TStringField;
    Tmp_Res_MercadoMoneda_Instrum: TStringField;
    Tmp_Res_MercadoValor_Pte_mc_i_Cpa: TFloatField;
    Tmp_Res_MercadoValor_Pte_mc_I_Mer: TFloatField;
    Tmp_Res_MercadoFecha_emision: TDateTimeField;
    Tmp_Res_MercadoFecha_vcto: TDateTimeField;
    Tmp_Res_MercadoTasa_emision: TFloatField;
    Tmp_Res_MercadoFactor_Riesgo: TFloatField;
    Tmp_Res_MercadoValorizacion_Mixta: TFloatField;
    Tmp_Res_MercadoPrecio_Mixto: TFloatField;
    Tmp_Res_MercadoMotivo_Inv: TStringField;
    Tmp_Res_MercadoSaldo_Insoluto: TFloatField;
    Tmp_Res_MercadoFecha_Last_Cierre: TDateTimeField;
    BatchMove: TBatchMove;
    Tmp_Res_MercadoValor_PAR_UM: TFloatField;
    Tmp_Res_MercadoValor_PAR_MC: TFloatField;
    T_Res_MercadoVALOR_PAR_UM: TFloatField;
    T_Res_MercadoVALOR_PAR_MC: TFloatField;
    T_Tes_Egringintereses_um: TFloatField;
    T_Tes_EgringDIF_VENCIMIENTO_UM: TFloatField;
    T_Tes_EgringDIF_VENCIMIENTO_MC: TFloatField;
    T_Provision: TwwTable;
    T_ProvisionEMPRESA: TStringField;
    T_ProvisionCARTERA: TStringField;
    T_ProvisionTRANSACCION: TStringField;
    T_ProvisionFOLIO_INTERNO: TStringField;
    T_ProvisionITEM_OMD: TFloatField;
    T_ProvisionVALOR_TASACION_UM: TFloatField;
    T_ProvisionNRO_DIVIDENDOS_IMP: TFloatField;
    T_ProvisionDIVIDENDO_IMPAGO_UM: TFloatField;
    T_ProvisionDIVIDENDO_IMPAGO_MC: TFloatField;
    T_ProvisionPROVISION_UM: TFloatField;
    T_ProvisionPROVISION_MC: TFloatField;
    T_ProvisionFECHA_CIERRE: TDateTimeField;
    T_ProvisionEMISOR: TStringField;
    T_ProvisionINSTRUMENTO: TStringField;
    T_ProvisionSERIE: TStringField;
    T_ProvisionNEMOTECNICO: TStringField;
    T_ProvisionFECHA_PRIMER_DIV: TDateTimeField;
    T_ProvisionFECHA_RETASACION: TDateTimeField;
    Tmp_Res_MercadoValor_Final_SVS_MC: TFloatField;
    Tmp_Res_MercadoValor_Final_SVS_UM: TFloatField;
    T_Res_MercadoValor_Final_SVS_UM: TFloatField;
    T_Res_MercadoValor_Final_SVS_MC: TFloatField;
    T_StockCupones_Cortados: TFloatField;
    Tmp_StockCupones_Cortados: TFloatField;
    T_Res_Mercado_CC: TwwTable;
    Tmp_Res_Proceso: TwwTable;
    T_Res_Proceso: TwwTable;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    DateTimeField3: TDateTimeField;
    DateTimeField4: TDateTimeField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    StringField11: TStringField;
    StringField12: TStringField;
    FloatField9: TFloatField;
    StringField13: TStringField;
    DateTimeField5: TDateTimeField;
    StringField14: TStringField;
    StringField15: TStringField;
    FloatField10: TFloatField;
    StringField16: TStringField;
    FloatField11: TFloatField;
    FloatField12: TFloatField;
    FloatField13: TFloatField;
    FloatField14: TFloatField;
    StringField17: TStringField;
    FloatField15: TFloatField;
    FloatField16: TFloatField;
    FloatField17: TFloatField;
    StringField18: TStringField;
    StringField19: TStringField;
    FloatField18: TFloatField;
    Tmp_Res_MercadoValorizacion_Mixta_UM: TFloatField;
    T_Res_MercadoFloatField: TFloatField;
    Tmp_Res_Mercado_CCValor_Pte_um_Cpa: TFloatField;
    Tmp_Res_Mercado_CCValor_Pte_um_Mdo: TFloatField;
    Tmp_Res_Mercado_CCValor_Pte_um_Mixta: TFloatField;
    Tmp_RES_PROVISION: TwwTable;
    T_RES_PROVISION: TwwTable;
    Qry_QS_RES_MERCADO: TwwQuery;
    Qry_Tesoreria: TwwQuery;
    Qry_QS_TRA_OMD_STK_RF: TwwQuery;
    Qry_QS_RES_PROVISION: TwwQuery;
    Qry_QS_RES_MERCADO_AD: TwwQuery;
    Qry_QS_RES_MERCADO_CC: TwwQuery;
    T_Res_MercadoCustodia: TStringField;
    Tmp_Res_MercadoCustodia: TStringField;
    Tmp_Res_MercadoDuration_Tasa_Emi: TFloatField;
    Tmp_Res_MercadoDuration_Mod_Tasa_Emi: TFloatField;
    Tmp_Res_MercadoCupones_Impagos: TFloatField;
    QRY_CNS: TwwQuery;
    Tmp_Res_MercadoSaldo_Insoluto_UM: TFloatField;
    Tmp_Res_MercadoSaldo_Insoluto_MC: TFloatField;
    T_StockValor_PAR_UM: TFloatField;
    T_StockValor_PAR_MC: TFloatField;
    T_StockSaldo_Insoluto_UM: TFloatField;
    T_StockSaldo_Insoluto_MC: TFloatField;
    Tmp_StockValor_PAR_UM: TFloatField;
    Tmp_StockValor_PAR_MC: TFloatField;
    Tmp_StockSaldo_Insoluto_UM: TFloatField;
    Tmp_StockSaldo_Insoluto_MC: TFloatField;
    Tmp_Res_MercadoTipo_Tasa_Precio_Cpa: TStringField;
    Tmp_Res_MercadoTipo_Tasa_Precio_Mdo: TStringField;
    Tmp_Res_MercadoTipo_Tasa_Precio_Mix: TStringField;
    Tmp_Res_MercadoTipo_Valuac_Cpa: TStringField;
    Tmp_Res_MercadoTipo_Valuac_Mdo: TStringField;
    Tmp_Res_MercadoTipo_Valuac_Mix: TStringField;
    Tmp_Res_MercadoFormula_Pte_Cpa: TStringField;
    Tmp_Res_MercadoFormula_Pte_Mdo: TStringField;
    Tmp_Res_MercadoFormula_Pte_Mix: TStringField;
    Tmp_Res_MercadoOrigen_Cpa: TStringField;
    Tmp_Res_MercadoOrigen_Mdo: TStringField;
    Tmp_Res_MercadoOrigen_Mix: TStringField;
    Tmp_ERP_CtasPorPagar: TwwTable;
    Qry_QS_ERP_INTERFAZ: TwwQuery;
    Tmp_Res_MercadoTipo_Clasif: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    dFecha_Hora_Servidor : Tdatetime;
  end;

//     Function  Vencimientos_Al_Dia(dFecha_Desde:TdateTime;Array_Mem_Desarr : TArray_Mem_Desarr):Boolean;

     procedure Insert_Valores_MH(sEmpresa,
                                 sCartera,
                                 sTransaccion,
                                 sFolio_interno   : String;
                                 fItem_OMD        : Double;
                                 sEmisor,
                                 sInstrumento,
                                 sSerie,
                                 sNemotecnico     : String;
                                 dFecha_Cierre,
                                 dFecha_Primer_Dividendo,
                                 dFecha_Retasacion : TDateTime;
                                 fVALOR_TASACION_UM,
                                 fNRO_DIVIDENDOS_IMP,
                                 fDIVIDENDO_IMPAGO_UM,
                                 fDIVIDENDO_IMPAGO_MC,
                                 fPROVISION_UM,
                                 fPROVISION_MC    : Double;
                                 var Result : Boolean;
                                 Reg_Parametros   : TParametros
                                 );

     procedure Insert_Mercado(sEmpresa,
                             sCartera,
                             sTransaccion,
                             sFolio_interno   : String;
                             fItem_OMD        : Double;
                             sNemotecnico,
                             sEmisor,
                             sInstrumento,
                             sSerie,
                             sMoneda_Instrum    : String;
                             fTasa_Emision      : Double;
                             dFecha_Emision,
                             dFecha_Vencimiento,
                             dFecha_Cierre,
                             dFecha_Operacion   : TDateTime;
                             fValor_Nominal,
                             fValor_PAR_UM,
                             fValor_PAR_MC,
                             fTasa_Compra,
                             fValor_Pte_UM_Cpa,
                             fValor_Pte_MC_Cpa,
                             fValor_Pte_UM_Mdo,
                             fValor_Pte_MC_Mdo,
                             fPtj_Valor_Par_Mdo,
                             fRate_Used_Valuacion,
                             fPorcen_Valor_Cpa,
                             fDuration,
                             fDuration_Modificada,
                             fConvexidad,
                             fPlazo_al_Vcto,
                             fValor_Final_SVS_UM,
                             fValor_Final_SVS_MC  : Double;
                             sClasif_Riesgo     : String;
                             sTipo_Clasif       : String;
                             fFactor_Riesgo,
                             fPrecio_Mixto,
                             fValorizacion_Mixta: Double;
                             fValorizacion_Mixta_UM: Double;
                             sMotivo_Inversion  : String;
                             fSaldo_Insoluto    : Double;
                             sComprometido : String;
                             fValor_Pte_I_Cpa_Last          : Double;
                             fValor_Pte_I_Mer_Last          : Double;
                             dFecha_Last_Mdo                : TDatetime;
                             var Result                     : Boolean;
                             Reg_Parametros                 : TParametros;
                             sCustodia_Detalle              : String;
                             fDuration_Tasa_Emi             : Double;
                             fDuration_Modificada_Tasa_Emi  : Double;
                             fNRO_DIVIDENDOS_IMP            : Double;
                             fSaldo_Insoluto_UM             : Double;
                             fSaldo_Insoluto_MC             : Double;
                             sTipo_Tasa_Precio_Cpa          : String;
                             sOrigen_Cpa                    : String;
                             sTipo_Valuac_Cpa               : String;
                             sFormula_Pte_Cpa               : String;
                             sTipo_Tasa_Precio_Mdo          : String;
                             sOrigen_Mdo                    : String;
                             sTipo_Valuac_Mdo               : String;
                             sFormula_Pte_Mdo               : String;
                             sTipo_Tasa_Precio_Mix          : String;
                             sOrigen_Mix                    : String;
                             sTipo_Valuac_Mix               : String;
                             sFormula_Pte_Mix               : String;
                             fDiferencia                    : Double
                             );

    // Se elimina la tabla qs_res_mercado_cc
    // F.I. & GGARCIA 18-11-2010
    {
    Procedure Insert_Mercado_CC(sFecha : TDateTime;
                                sEmpresa,
                                sCartera,
                                sTransaccion,
                                sFolio_interno   : String;
                                fItem_OMD        : Double;
                                sEmisor,
                                sInstrumento,
                                sSerie,
                                sNemotecnico     : String;
                                fValor_Nominal,
                                fValor_Pte_MC_Cpa,
                                fValor_Pte_MC_Mdo,
                                fValorizacion_Mixta,
                                fValor_Pte_UM_Cpa,
                                fValor_Pte_UM_Mdo,
                                fValorizacion_UM_Mixta : Double;
                                sMotivo_Inversion      : String;
                                var Result                 : Boolean;
                                Reg_Parametros         : TParametros
                                );
    }
    
    procedure Insert_Mercado_Ad(sEmpresa,
                             sCartera,
                             sTransaccion,
                             sFolio_interno   : String;
                             fItem_OMD        : Double;
                             dFecha_Cierre    : TDateTime;
                             fTasa_Compra,
                             fValor_Pte_UM_Cpa,
                             fValor_Pte_MC_Cpa,
                             fPtj_Valor_Par_Cpa,
                             fTasa_Mercado,
                             fValor_Pte_UM_Mdo,
                             fValor_Pte_MC_Mdo,
                             fPtj_Valor_Par_Mdo : Double;
                             fPrecio_Mixto,
                             fValor_Pte_UM_Mix,
                             fValor_Pte_MC_Mix  : Double;
                             sComprometido,
                             sEmisor,
                             sInstrumento,
                             sSerie,
                             sNemotecnico       : String;
                             fValor_Pte_UM_Cpa_SC,
                             fValor_Pte_MC_Cpa_SC,
                             fValor_Pte_UM_Mdo_SC,
                             fValor_Pte_MC_Mdo_SC : Double;
                             var Result : Boolean;
                             Reg_Parametros   : TParametros
                             );

    procedure Insert_Valores_Proceso(sEmpresa,
                                 sCartera         : String;
                                 dFecha_Cierre    : TDateTime;
                                 sProceso         : String;
                                 sTransaccion,
                                 sFolio_interno   : String;
                                 fItem_OMD        : Double;
                                 sNemotecnico,
                                 sInstrumento     : String;
                                 fPrecio_Tasa     : Double;
                                 fValor_Pte_MC_Proceso : Double;
                              var Result : Boolean
                                 );

    procedure Registro_Caja(sEmpresa          : String;
                            sCartera          : String;
                            sTransaccion      : String;
                            sFolio_Interno    : String;
                            fItem_Omd         : Double;
                            dFecha_Mov        : TDateTime;
                            dFecha_Pago       : TDateTime;
                            sTipo_Movimiento  : String;
                            sMoneda_Cartera   : String;
                            sNemotecnico      : String;
                            fIntereses_UM     : Double;
                            fAmortizacion_UM  : Double;
                            fSaldo_Insoluto   : Double;
                            fValor_Nominal    : Double;
                            fValor_Vencimiento_UM: Double;
                            fValor_Vencimiento_MC: Double;
                            fDiferencia_Vencimiento_UM: Double;
                            fDiferencia_Vencimiento_MC: Double;
                            iCuponVigente     : Integer;
                            var Modulo_Err        : String;
                            var String_Err        : String;
                            var Result            : Boolean;
                            Reg_Parametros        : TParametros);

     procedure Inserta_Registro_Stock(sEmpresa         : String;
                                      sTransaccion     : String;
                                      sFolio_Interno   : String;
                                      fItem_Omd        : Double;
                                      dFecha_Operacion : TDateTime;
                                      dfecha_stock     : TDateTime;
                                      sNemotecnico     : String;
                                      sEmisor          : String;
                                      sInstrumento     : String;
                                      sSerie           : String;
                                      dFecha_Emision   : TDateTime;
                                      dFecha_Vencimiento : TDateTime;
                                      fValor_Nominal     : Double;
                                      fValor_Nominal_Calculo : Double;
                                      fTasa_Emision          : Double;
                                      fTasa_Mercado          : Double;
                                      sMoneda_Instrum        : String;
                                      sTasa_Base_par         : String;
                                      sTasa_Base_Tir         : String;
                                      fValor_Pte_um_Cpa      : Double;
                                      fValor_Pte_mc_Cpa      : Double;
                                      fPorcen_Valor_Par      : Double;
                                      sCartera               : String;
                                      sMoneda_Pacto          : String;
                                      fTasa_pacto            : Double;
                                      sTasa_Base_Pacto       : String;
                                      dFecha_Vcto_pacto      : TDateTime;
                                      sTipo_Nominales        : String;
                                      sCustodia              : String;
                                      fPlazo_al_Vcto         : Double;
                                      sTipo_Instrum          : String;
                                      fValor_Pte_um_Mdo      : Double;
                                      fValor_Pte_mc_Mdo      : Double;
                                      fTasa_Mercado_Mdo      : Double;
                                      fDuration              : Double;
                                      sPlazo_Vcto            : String;
                                      fDiferencia            : Double;
                                      fValorizacion_Mixta    : Double;
                                      fPrecio_Mixto          : Double;
                                      sMotivo_Inv            : String;
                                      sClasif_Riesgo         : String;
                                      iCupones_cortados      : Integer;
                                      fValor_PAR_UM          : Double;
                                      fValor_PAR_MC          : Double;
                                      fSaldo_Insoluto_UM     : Double;
                                      fSaldo_Insoluto_MC     : Double;
                                      Var Resultado          : Boolean);

    procedure Insert_ERP_CXP(sEmpresa,
                             sCartera,
                             sTransaccion,
                             sFolio_interno   : String;
                             fItem_OMD        : Double;
                             sContraparte     : String;
                             fDir_Contraparte : Double;
                             sNemotecnico,
                             sEmisor,
                             sInstrumento,
                             sSerie,
                             sMoneda_Instrum    : String;
                             fTasa_Emision      : Double;
                             dFecha_Emision,
                             dFecha_Vencimiento,
                             dFecha_Cierre,
                             dFecha_Pago,
                             dFecha_Operacion   : TDateTime;
                             fValor_Nominal,
                             fValor_PAR_UM,
                             fValor_PAR_MC,
                             fTasa_Compra,
                             fValor_Pte_UM_Cpa,
                             fValor_Pte_MC_Cpa,
                             fValor_Pte_UM_Mdo,
                             fValor_Pte_MC_Mdo,
                             fPtj_Valor_Par_Mdo,
                             fRate_Used_Valuacion,
                             fPorcen_Valor_Cpa,
                             fDuration,
                             fDuration_Modificada,
                             fConvexidad,
                             fPlazo_al_Vcto,
                             fValor_Final_SVS_UM,
                             fValor_Final_SVS_MC : Double;
                             sClasif_Riesgo      : String;
                             fFactor_Riesgo,
                             fPrecio_Mixto,
                             fValorizacion_Mixta: Double;
                             fValorizacion_Mixta_UM: Double;
                             sMotivo_Inversion  : String;
                             fSaldo_Insoluto    : Double;
                             sComprometido : String;
                             fValor_Pte_I_Cpa_Last : Double;
                             fValor_Pte_I_Mer_Last : Double;
                             dFecha_Last_Mdo : TDatetime;
                             Var Result : Boolean;
                             Reg_Parametros                 : TParametros;
                             sCustodia_Detalle              : String;
                             fDuration_Tasa_Emi             : Double;
                             fDuration_Modificada_Tasa_Emi  : Double;
                             fNRO_DIVIDENDOS_IMP            : Double;
                             fSaldo_Insoluto_UM             : Double;
                             fSaldo_Insoluto_MC             : Double;
                             sTipo_Tasa_Precio_Cpa          : String;
                             sOrigen_Cpa                    : String;
                             sTipo_Valuac_Cpa               : String;
                             sFormula_Pte_Cpa               : String;
                             sTipo_Tasa_Precio_Mdo          : String;
                             sOrigen_Mdo                    : String;
                             sTipo_Valuac_Mdo               : String;
                             sFormula_Pte_Mdo               : String;
                             sTipo_Tasa_Precio_Mix          : String;
                             sOrigen_Mix                    : String;
                             sTipo_Valuac_Mix               : String;
                             sFormula_Pte_Mix               : String
                             );

  Procedure  Proceso_Valorizacion( dFecha_Inicial : TDateTime;
                                   dFecha_Final   : TDatetime;
                                   Reg_Parametros : TParametros;
                                   sProceso       : String;
                                   sCaption       : String;
                                   var bAbortar       : Boolean
                                  );


  Procedure LiberarMemoria;
var
  DMValorizacion: TDMValorizacion;

implementation
Uses DM_Base_Datos,
     DM_FuncionesMemory,
     DM_Global_Var,
     DM_Variables_Menu,
     DM_Comun,
     DM_ComunInversiones,
     DMLeer_valor_Cambio,
     DM_Codigos_generales,
     Tabla_Mem_Desarr_TFija,
     Funciones_Valorizacion,
     Valoriza_General,
     Frm_SeleccionDatos,
     Mensajes_Procesos,
     Registro_Log,
     Finaliza_Valorizacion,
     DM_Clasif_Riesgo,

     DM_Carteras,
     DM_Ayuda_Monedas,
     DM_Paises;
     
{$R *.DFM}

Procedure  Proceso_Valorizacion( dFecha_Inicial,
                                 dFecha_Final : TDatetime;
                                 Reg_Parametros : TParametros;
                                 sProceso     : String;
                                 sCaption     : String;
                                 var bAbortar     : Boolean
                                );
var
     sNombre_Tabla,
     sVALORIZACION,
     sInstrumento_Equiv,
     sImplicancia_NO_Vcto,
     sImplicancia_Mercado_CC,
     sEmpresa_Aux,
     sEmpresa_Proceso,
     sNemotecnico,
     sNemotecnico_Dia_Siguiente,
     sMensaje,
     sClasif_Riesgo,
     sString_Error,
     sModulo_Error,
     sCodigo_Geo_Emisor,
     sRelacion,
     sSistema,
     sTipo_Movimiento,
     sTipo_Valuac,
     sFormula_Pte,
     sMon_Ind,
     sOrigen,
     sDescripcion,
     sImplicancia_Mercado : String;
     bImplicancia_Omite_Error_Clasif_Riesgo : Boolean;
//     Resultado : Boolean;
     dFecha_Aux,
     dFecha_Emision,
     dFecha_Last_Cierre,
     dFecha_Primer_Dividendo,
     dFecha_Libera_Pacto,
     dFecha_Vencimiento,
     dFecha_retasacion  : TDatetime;
     fProvision_UM,
     fProvision_MC,
     fMonto_Impago_UM,
     fMonto_Impago_MC,
     fValor_Retasacion,
     fNominales_Vigentes,
     fNominales_Totales,
     fTasa_Compra,
     fTasa_Compra_Utilizada, // La fTasa_Compra_Utilizada Para el caso de Valuacion PRESENTE puede cambiar.
     fPorcen_Valor_Par,
     fValor_Pte_UM_Cpa,
     fValor_Pte_MC_Cpa,
     fValor_Pte_UM_Mer,
     fNominales_Vendidos,
     fNominales_Vendidos_Reales,
     fNominales_Ventas_Dia,
     fNominales_Pactados,
     fNominales_Pactados_Reales,
     fNominales_Reales,
     fValor_Final_SVS_UM,
     fValor_Final_SVS_MC,
     fValor_Retasacion_UM,
     fPtj_Valor_Par_Mdo_Pacto,

     fPorcen_Valor_Par_Pacto,
     fValor_Pte_UM_Mdo_Pacto,
     fValor_Pte_MC_Mdo_Pacto,

     fValor_Pte_UM_Mix_Pacto,
     fValor_Pte_MC_Mix_Pacto,


     fPorcen_Valor_Par_Ini_Pacto,
     fValor_Pte_UM_Cpa_Ini_Pacto,
     fValor_Pte_MC_Cpa_Ini_Pacto,
     fValor_Pte_UM_Mdo_Ini_Pacto,
     fValor_Pte_MC_Mdo_Ini_Pacto,
     fValor_Pte_UM_Mix_Ini_Pacto,
     fValor_Pte_MC_Mix_Ini_Pacto,
     fPtj_Valor_Par_Mdo_Ini_Pacto,
     fValor_Pte_UM_Cpa_SC_Pacto,
     fValor_Pte_MC_Cpa_SC_Pacto,
     fValor_Pte_UM_Mdo_SC_Pacto,
     fValor_Pte_MC_Mdo_SC_Pacto,
     fInteres,
     fReajuste_Capital_Pagado,
     fAmortizacion,
     fSaldo_Insoluto,
     fSaldo_Insoluto_UM,
     fSaldo_Insoluto_MC,
     fSaldo_Insoluto_Par,
     fValor_Vencimiento_UM,
     fValor_Vencimiento_MC,
     fValor_Par_UM,
     fValor_Par_MC,
     fValor_Par_UM_Ini,
     fValor_Par_MC_Ini,
     fValor_Final_UM,
     fItem_Dir_Emisor,
     fBase_Precio,
     fValor_Pte_UM_Mdo,
     fValor_Pte_MC_Mdo,
     fRate_Used_Valuacion,
     fPtj_Valor_Par_Mdo,
     fValorizacion_Mixta,
     fValorizacion_Mixta_UM,
     fPrecio_Mixto,
     fDuration,
     fDuracion_Modificada,
     fConvexidad,
     fPlazo_Al_Vcto,
     fFactor_Riesgo,
     fValor_Nominal_Last,
     fDiferencia_Vencimiento_UM,
     fDiferencia_Vencimiento_MC,
     fValor_PAR_UM_Pacto,
     fValor_PAR_MC_Pacto,
     fValor_Pte_UM_Cpa_Pacto,
     fValor_Pte_MC_Cpa_Pacto,
     fValor_Pte_UM_Cpa_SC,
     fNRO_DIVIDENDOS_IMP,
     fValor_Pte_MC_Cpa_SC,
     fValor_Pte_UM_Cpa_Orig,
     fValor_Pte_MC_Cpa_Orig,
     fValor_Pte_UM_Mdo_SC,
     fValor_Pte_MC_Mdo_SC,
//     fPrecio_Tasa,
     fValor_Pte_I_Cpa_Last,
     fValor_Pte_I_Mer_Last,
     fValor_Pte_UM_Cpa_Ini,
     fValor_Pte_MC_Proceso,
     fValor_Pte_MC_Cpa_Ini,
     fValor_Pte_UM_Mdo_Ini,
     fValor_Pte_MC_Mdo_Ini,
     fValor_Pte_UM_Mix_Ini,
     fValor_Pte_MC_Mix_Ini,
     fPorcen_Valor_Par_Ini,
     fPtj_Valor_Par_Mdo_Ini,
     fValorInvertidoUM_Cpa,
     fValorInvertidoMC_Cpa,
     fTotal_Registros_Mercado,
     fTotal_Registros,
     fValor_Par_Base   : Double;
     bTodo_Pactado,
     bVencimiento,
     bError_Cartera,
     bValuacion,
     bEquivalencia     : Boolean;
     Reg_Val_In        : TRegistro_Valoriza_In;
     Reg_Val_Out       : TRegistro_Valoriza_Out;
     Aux_Reg_Val_In        : TRegistro_Valoriza_In;
     Aux_Reg_Val_Out       : TRegistro_Valoriza_Out;


     iCuponVigente,
     j,
     i                 : Integer;
     Reg_Carteras_Proceso : TReg_Carteras_Proceso;
     Result               : Boolean;
     aa,mm,dd             : Word;
     iCupones_cortados    : Integer;
     fTotal_Nominales,
     fRut                 : Double;
     sParametro_Moneda_Conversion,
     sDigito,
     sRazon_social,
     sCustodia_Dest,
     sPeriodo,
     sMoneda_Tasacion : String; // Cuando es distinto de blanco convierte a esta moneda y no a la de la cartera
     iBaseTasa                    : integer;
     sTipoInteres                 : string;
     iBaseMensual                 : integer;
     sTipoCalculoDias             : String;
     iVigenciaValor               : Integer;
     iVigencia_Meses              : Integer;
     sPais_Tasa                   : String;
     bError_Tasacion              : Boolean;
     dFecha_Valor_Vencimiento     : TDatetime;
     sString_Empresas,
     sString_Emisores,
     sString_Instrumentos,
     sMoneda_Conversion,
     sString_Carteras               : String;
     bExiste_Tabla_Cta_Cte          : Boolean;
     bExiste_Tabla_Det_PP           : Boolean;
     bforward                       : Boolean;
     bEmpresa_Implica_Stock_Parcial,
     bValorizando_Stock_Parcial     : Boolean;
     dFecha_Stock                   : TDatetime;
     fValor_Paridad  : Double;
     bExiste_Paridad : Boolean;
     bPrepagos_Pactos               : Boolean;
     bAnticipos_Pactos              : Boolean;
     Aux_fNominales_Vigentes        : Double;
     Aux_fNominales_Reales          : Double;
     sTIPO_INSTRUMENTO              : String;
     fcuenta_pasadas                : Double;
     sEmisor_Pagador                : String;
     sTipo_Clasif                   : String;
     Flag_Duration_Tasa_Emi         : Boolean;
     fDuration_Tasa_Emi             : Double;
     fDuration_Modificada_Tasa_Emi  : Double;
     fConvexidad_Tasa_Emi           : Double;

     dFechaPagoAOcupar              : TDateTime;
     sFechaPagoAOcupar              : String;
     bResultFechaPago               : Boolean;
     fTitulos_Vigentes              : Double;
     sParametro_Consistencia        : String;
     fNum_Regs                      : Double;

     fTipo_Cambio_Compra            : Double;
     SSerie                         : String;
     bError_valoriza_mercado_ad     : Boolean;
     sTipo_Tasa_Precio_Cpa          : String;
     sOrigen_Cpa                    : String;
     sTipo_Valuac_Cpa               : String;
     sFormula_Pte_Cpa               : String;
     sTipo_Tasa_Precio_Mdo          : String;
     sOrigen_Mdo                    : String;
     sTipo_Valuac_Mdo               : String;
     sFormula_Pte_Mdo               : String;
     sTipo_Tasa_Precio_Mix          : String;
     sOrigen_Mix                    : String;
     sTipo_Valuac_Mix               : String;
     sFormula_Pte_Mix               : String;
     Registro_Fechas                : TRegistro_Fechas;
     sMetodo_Sin_Tasa_Referencia : String;
     Reg_Formula_PAR             : TRegFormulaPAR;
     Reg_Formula_TIR             : TRegFormulaTIR;

     bBusca_Siguiente_Cupon      : Boolean;
     bErrorWhile                 : Boolean;
     fDiferencia                 : Double;


begin
   FrmMensajesProcesos := TFrmMensajesProcesos.Create(Application);
   FrmMensajesProcesos.Caption := sCaption;
   Application.ProcessMessages;
   FrmMensajesProcesos.Show;

   //13-12-2012 F.I. (No lo queremos en el centro)
   FrmMensajesProcesos.Position := poDesigned;
   FrmMensajesProcesos.Top := 511;
   FrmMensajesProcesos.Left := 138;

   FrmMensajesProcesos.T_Errores_Mesa.Open;
   bAbortar := False;
   Result   := False;
   DMValorizacion.dFecha_Hora_Servidor := Fecha_Hora_Servidor;

   sValorizacion_Proceso := 'SI';

   Inicializar_Progreso(dFecha_Inicial,
                        dFecha_Final

                                                );

   // Verifica si esta la tabla en la BD
   Existe_Tabla_en_Base_de_datos( sDriver
                                 ,'QS_TRA_OMD_PREPAGO'
                                 ,sModulo_Error
                                 ,sString_Error
                                 ,bPrepagos_Pactos
                                 ,Result);
   if NOT Result then
   begin
     Application.MessageBox(Pchar( sString_Error )
                           ,Pchar( sModulo_Error )
                           ,Mb_OK + MB_IconError );
     Exit;
   end;
   // Verifica si esta la tabla en la BD
   Existe_Tabla_en_Base_de_datos( sDriver
                                 ,'QS_TRA_OMD_PREPAGO_PACTO'
                                 ,sModulo_Error
                                 ,sString_Error
                                 ,bAnticipos_Pactos
                                 ,Result);
   if NOT Result then
   begin
     Application.MessageBox(Pchar( sString_Error )
                           ,Pchar( sModulo_Error )
                           ,Mb_OK + MB_IconError );
     Exit;
   end;

   sImplicancia_NO_Vcto := '';
   if Transaccion_Implica( sEmpresa_Usuario, 'NO_VCTO' ) then
      sImplicancia_NO_Vcto := 'NO_VCTO';

   sImplicancia_Mercado_CC := '';
   if Transaccion_Implica( sEmpresa_Usuario, 'MERCADO_CC' ) then
      sImplicancia_Mercado_CC := 'MERCADO_CC';

   sImplicancia_Mercado := '';
   if Transaccion_Implica( sEmpresa_Usuario, 'MERCADO' ) then
      sImplicancia_Mercado := 'MERCADO';

   if bTEST then
   begin
      if (sImplicancia_Mercado = 'MERCADO') then
       Application.MessageBox(PChar('La implicancia MERCADO esta activada'), pchar('VALORIZACION STOCK'), MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);

   end;

   bEmpresa_Implica_Stock_Parcial := Transaccion_Implica( sEmpresa_Usuario, 'STOCK_PARCIAL' );
   bValorizando_Stock_Parcial     := FALSE;
   dFecha_Stock                   := 0;

   if bEmpresa_Implica_Stock_Parcial then
   begin
       if (NOT Reg_Parametros.bCarteras ) and
          ( (Reg_Parametros.bInstrumentos) or
            (Reg_Parametros.bEmisores)
          ) then
        begin
           sString_Error := ' Debe Seleccionar Cartera'#10
                           +' Para Selección de Emisor, Instrumento';
           Application.MessageBox(Pchar( sString_Error )
                                        ,'PROCESO'
                                        ,Mb_OK + MB_IconError
                                 );
           Exit;
        end;

       if (Reg_Parametros.bCarteras ) and
          ( (Reg_Parametros.bInstrumentos) or
            (Reg_Parametros.bEmisores)
          ) then
       begin
          bValorizando_Stock_Parcial := True;
          sString_Error := ' ATENCION : La Valorizacion combinada de '#10
                          +' Cartera, Emisor e Instrumento no actualizará su Valorizacion a Mercado. ';
          Application.MessageBox(Pchar( sString_Error )
                                       ,'PROCESO'
                                       ,Mb_OK + MB_IconError
                                 );
       end;
   end;

   bImplicancia_Omite_Error_Clasif_Riesgo := Transaccion_Implica( sEmpresa_Usuario, 'NERRCLASIF' );

   Busca_param_proceso('VALORIZA'
                      ,'MON_CONVER'
                      ,sParametro_Moneda_Conversion
                      ,Result);

   if NOT Result then
      sParametro_Moneda_Conversion := '';

   try
     DMValorizacion.Tmp_Res_Mercado.Close
   except
   end;


   with DMValorizacion.Qry_QS_RES_MERCADO do
   begin
        // Determina si existen los nuevos campos para TSA
        SQL.Clear;
        SQL.ADD(' SELECT Duration_Tasa_Emi FROM QS_RES_MERCADO     ');
        if sDriver = 'ORACLE' then
           SQL.Add(' WHERE FECHA_CIERRE = TO_DATE(''01-01-1900'',''DD-MM-YYYY'') ')
        else
        begin
           SQL.Add(' WHERE FECHA_CIERRE = :Fecha ');
           ParamByName('Fecha').AsDatetime := EncodeDate(1900,01,01);
        end;

        Flag_Duration_Tasa_Emi := True;
        Try
          Open;
        Except
          Flag_Duration_Tasa_Emi := False;
        end;
        Close;

        sql.clear;
        sql.add('INSERT INTO QS_RES_MERCADO ');
        sql.add('(');
        sql.add(' Empresa');
        sql.add(',Cartera');
        sql.add(',Transaccion');
        sql.add(',Folio_interno');
        sql.add(',Item_OMD');
        sql.add(',Fecha_Cierre');
        sql.add(',Fecha_Operacion');
        sql.add(',Nemotecnico');
        sql.add(',Emisor');
        sql.add(',Instrumento');
        sql.add(',Serie');
        sql.add(',Valor_Nominal');
        sql.add(',Valor_PAR_UM');
        sql.add(',Valor_PAR_MC');
        sql.add(',Tasa_Compra');
        sql.add(',Valor_Pte_um_Cpa');
        sql.add(',Valor_Pte_mc_Cpa');
        sql.add(',Por_Valor_Par_Cpa');
        sql.add(',Plazo_al_Vcto');
        sql.add(',Tasa_Mercado_Mdo');
        sql.add(',Valor_Pte_um_Mdo');
        sql.add(',Valor_Pte_mc_Mdo');
        sql.add(',Por_Valor_Par_Mdo');
        sql.add(',Duration');
        sql.add(',Duration_Mod');
        sql.add(',Convexidad');
        sql.add(',Diferencia');
        sql.add(',Clasif_Riesgo');
        sql.add(',Tipo_Clasif_Riesgo');
        sql.add(',Comprometido');
        sql.add(',Moneda_Instrum');
        sql.add(',Valor_Pte_mc_i_Cpa');
        sql.add(',Valor_Pte_mc_I_Mer');
        sql.add(',Fecha_emision');
        sql.add(',Fecha_vcto');
        sql.add(',Tasa_emision');
        sql.add(',Factor_Riesgo');
        sql.add(',Valorizacion_Mixta');
        sql.add(',Precio_Mixto');
        sql.add(',Motivo_Inv');
        sql.add(',Saldo_Insoluto');
        sql.add(',Fecha_Last_Cierre');
        sql.add(',Valor_Final_SVS_UM');
        sql.add(',Valor_Final_SVS_MC');
        sql.add(',Valorizacion_Mixta_UM');
        sql.add(',Custodia');
        if Flag_Duration_Tasa_Emi then
        begin
           sql.add(',Duration_Tasa_Emi');
           sql.add(',Duration_Mod_Tasa_Emi');
           sql.add(',Cupones_Impagos');
        end;
        sql.add(',Saldo_Insoluto_UM');
        sql.add(',Saldo_Insoluto_MC');
        sql.add(',Tipo_Tasa_Precio_Cpa');
        sql.add(',Origen_Cpa');
        sql.add(',Tipo_Valuac_Cpa');
        sql.add(',Formula_Pte_Cpa');
        sql.add(',Tipo_Tasa_Precio_Mdo');
        sql.add(',Origen_Mdo');
        sql.add(',Tipo_Valuac_Mdo');
        sql.add(',Formula_Pte_Mdo');
        sql.add(',Tipo_Tasa_Precio_Mix');
        sql.add(',Origen_Mix');
        sql.add(',Tipo_Valuac_Mix');
        sql.add(',Formula_Pte_Mix');
        sql.add(')');

        sql.add(' VALUES ');

        sql.add('(');
        sql.add(' :Empresa');
        sql.add(',:Cartera');
        sql.add(',:Transaccion');
        sql.add(',:Folio_interno');
        sql.add(',:Item_OMD');
        sql.add(',:Fecha_Cierre');
        sql.add(',:Fecha_Operacion');
        sql.add(',:Nemotecnico');
        sql.add(',:Emisor');
        sql.add(',:Instrumento');
        sql.add(',:Serie');
        sql.add(',:Valor_Nominal');
        sql.add(',:Valor_PAR_UM');
        sql.add(',:Valor_PAR_MC');
        sql.add(',:Tasa_Compra');
        sql.add(',:Valor_Pte_um_Cpa');
        sql.add(',:Valor_Pte_mc_Cpa');
        sql.add(',:Por_Valor_Par_Cpa');
        sql.add(',:Plazo_al_Vcto');
        sql.add(',:Tasa_Mercado_Mdo');
        sql.add(',:Valor_Pte_um_Mdo');
        sql.add(',:Valor_Pte_mc_Mdo');
        sql.add(',:Por_Valor_Par_Mdo');
        sql.add(',:Duration');
        sql.add(',:Duration_Mod');
        sql.add(',:Convexidad');
        sql.add(',:Diferencia');
        sql.add(',:Clasif_Riesgo');
        sql.add(',:Tipo_Clasif_Riesgo');
        sql.add(',:Comprometido');
        sql.add(',:Moneda_Instrum');
        sql.add(',:Valor_Pte_mc_i_Cpa');
        sql.add(',:Valor_Pte_mc_I_Mer');
        sql.add(',:Fecha_emision');
        sql.add(',:Fecha_vcto');
        sql.add(',:Tasa_emision');
        sql.add(',:Factor_Riesgo');
        sql.add(',:Valorizacion_Mixta');
        sql.add(',:Precio_Mixto');
        sql.add(',:Motivo_Inv');
        sql.add(',:Saldo_Insoluto');
        sql.add(',:Fecha_Last_Cierre');
        sql.add(',:Valor_Final_SVS_UM');
        sql.add(',:Valor_Final_SVS_MC');
        sql.add(',:Valorizacion_Mixta_UM');
        sql.add(',:Custodia');
        if Flag_Duration_Tasa_Emi then
        begin
           sql.add(',:Duration_Tasa_Emi');
           sql.add(',:Duration_Mod_Tasa_Emi');
           sql.add(',:Cupones_Impagos');
        end;
        sql.add(',:Saldo_Insoluto_UM');
        sql.add(',:Saldo_Insoluto_MC');
        sql.add(',:Tipo_Tasa_Precio_Cpa');
        sql.add(',:Origen_Cpa');
        sql.add(',:Tipo_Valuac_Cpa');
        sql.add(',:Formula_Pte_Cpa');
        sql.add(',:Tipo_Tasa_Precio_Mdo');
        sql.add(',:Origen_Mdo');
        sql.add(',:Tipo_Valuac_Mdo');
        sql.add(',:Formula_Pte_Mdo');
        sql.add(',:Tipo_Tasa_Precio_Mix');
        sql.add(',:Origen_Mix');
        sql.add(',:Tipo_Valuac_Mix');
        sql.add(',:Formula_Pte_Mix');
        sql.add(')');
        prepare;
   end;
   DMValorizacion.Qry_Tesoreria.Prepare;
   DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.Prepare;

   with DMValorizacion.Tmp_Res_Mercado.FieldDefs do
   begin
      Clear;
      Add('Empresa'                              , ftString, 10,False);
      Add('Cartera'                              , ftString, 10,False);
      Add('Transaccion'                          , ftString, 10 ,False);
      Add('Folio_interno'                        , ftString, 15 ,False);
      Add('Item_OMD'                             , ftFloat, 0,False);
      Add('Fecha_Cierre'                         , ftDatetime, 0,False);
      Add('Fecha_Operacion'                      , ftDatetime, 0,False);
      Add('Nemotecnico'                          , ftString, 30 ,False);
      Add('Emisor'                               , ftString, 10 ,False);
      Add('Instrumento'                          , ftString, 10 ,False);
      Add('Serie'                                , ftString, 30 ,False);
      Add('Valor_Nominal'                        , ftFloat, 0,False);
      Add('Valor_PAR_UM'                         , ftFloat, 0,False);
      Add('Valor_PAR_MC'                         , ftFloat, 0,False);
      Add('Tasa_Compra'                          , ftFloat, 0,False);
      Add('Valor_Pte_um_Cpa'                     , ftFloat, 0,False);
      Add('Valor_Pte_mc_Cpa'                     , ftFloat, 0,False);
      Add('Por_Valor_Par_Cpa'                    , ftFloat, 0,False);
      Add('Plazo_al_Vcto'                        , ftFloat, 0,False);
      Add('Tasa_Mercado_Mdo'                     , ftFloat, 0,False);
      Add('Valor_Pte_um_Mdo'                     , ftFloat, 0,False);
      Add('Valor_Pte_mc_Mdo'                     , ftFloat, 0,False);
      Add('Por_Valor_Par_Mdo'                    , ftFloat, 0,False);
      Add('Duration'                             , ftFloat, 0,False);
      Add('Duration_Mod'                         , ftFloat, 0,False);
      Add('Convexidad'                           , ftFloat, 0,False);
      Add('Diferencia'                           , ftFloat, 0,False);
      Add('Clasif_Riesgo'                        , ftString, 10 ,False);
      Add('Tipo_Clasif'                          , ftString, 10 ,False);
      Add('Comprometido'                         , ftString, 1 ,False);
      Add('Moneda_Instrum'                       , ftString, 15 ,False);
      Add('Valor_Pte_mc_i_Cpa'                   , ftFloat, 0,False);
      Add('Valor_Pte_mc_I_Mer'                   , ftFloat, 0,False);
      Add('Fecha_emision'                        , ftDatetime, 0,False);
      Add('Fecha_vcto'                           , ftDatetime, 0,False);
      Add('Tasa_emision'                         , ftFloat, 0,False);
      Add('Factor_Riesgo'                        , ftFloat, 0,False);
      Add('Valorizacion_Mixta'                   , ftFloat, 0,False);
      Add('Precio_Mixto'                         , ftFloat, 0,False);
      Add('Motivo_Inv'                           , ftString, 10 ,False);
      Add('Saldo_Insoluto'                       , ftFloat, 0,False);
      Add('Fecha_Last_Cierre'                    , ftDatetime, 0, false);
      Add('Valor_Final_SVS_UM'                   , ftFloat, 0,False);
      Add('Valor_Final_SVS_MC'                   , ftFloat, 0,False);
      Add('Valorizacion_Mixta_UM'                , ftFloat, 0,False);
      Add('Custodia'                             , ftString, 10 ,False);
      Add('Duration_Tasa_Emi'                    , ftFloat, 0,False);
      Add('Duration_Mod_Tasa_Emi'                , ftFloat, 0,False);
      Add('Cupones_Impagos'                      , ftFloat, 0,False);
      Add('Saldo_Insoluto_UM'                    , ftFloat, 0,False);
      Add('Saldo_Insoluto_MC'                    , ftFloat, 0,False);
      Add('Tipo_Tasa_Precio_Cpa'                 , ftString, 10 ,False);
      Add('Origen_Cpa'                           , ftString, 10 ,False);
      Add('Tipo_Valuac_Cpa'                      , ftString, 10 ,False);
      Add('Formula_Pte_Cpa'                      , ftString, 10 ,False);
      Add('Tipo_Tasa_Precio_Mdo'                 , ftString, 10 ,False);
      Add('Origen_Mdo'                           , ftString, 10 ,False);
      Add('Tipo_Valuac_Mdo'                      , ftString, 10 ,False);
      Add('Formula_Pte_Mdo'                      , ftString, 10 ,False);
      Add('Tipo_Tasa_Precio_Mix'                 , ftString, 10 ,False);
      Add('Origen_Mix'                           , ftString, 10 ,False);
      Add('Tipo_Valuac_Mix'                      , ftString, 10 ,False);
      Add('Formula_Pte_Mix'                      , ftString, 10 ,False);
   end;
   if NOT Reg_Parametros.bSolo_Stock then
   begin
   DMValorizacion.Tmp_Res_Mercado.TableName := DMValorizacion.Tmp_Res_Mercado.TableName +IntToStr(Application.Handle);
   DMValorizacion.Tmp_Res_Mercado.CreateTable;
   DMValorizacion.Tmp_Res_Mercado.Open;
   end;

   with DMValorizacion.Tmp_Res_Mercado_Ad.FieldDefs do
   begin
      Clear;
      Add('Empresa', ftString, 10,False);
      Add('Cartera', ftString, 10,False);
      Add('Transaccion', ftString, 10 ,False);
      Add('Folio_interno', ftString, 15 ,False);
      Add('Item_OMD', ftFloat, 0,False);
      Add('Fecha_Cierre', ftDatetime, 0,False);
      Add('Tasa_Compra_I', ftFloat, 0,False);
      Add('Valor_Pte_um_Cpa_Ini', ftFloat, 0,False);
      Add('Valor_Pte_mc_Cpa_Ini', ftFloat, 0,False);
      Add('Por_Valor_Par_Cpa_Ini', ftFloat, 0,False);
      Add('Tasa_Mercado_Mdo_Ini', ftFloat, 0,False);
      Add('Valor_Pte_um_Mdo_Ini', ftFloat, 0,False);
      Add('Valor_Pte_mc_Mdo_Ini', ftFloat, 0,False);
      Add('Por_Valor_Par_Mdo_Ini', ftFloat, 0,False);
      Add('Precio_Mixto_Ini', ftFloat, 0,False);
      Add('Valor_Pte_um_Mix_Ini', ftFloat, 0,False);
      Add('Valor_Pte_mc_Mix_Ini', ftFloat, 0,False);
      Add('Comprometido', ftString, 1 ,False);
      Add('Emisor', ftString, 10 ,False);
      Add('Instrumento', ftString, 10 ,False);
      Add('Serie', ftString, 30 ,False);
      Add('Nemotecnico', ftString, 30 ,False);
      Add('Valor_Pte_um_Cpa_SC', ftFloat, 0,False);
      Add('Valor_Pte_mc_Cpa_SC', ftFloat, 0,False);
      Add('Valor_Pte_um_Mdo_SC', ftFloat, 0,False);
      Add('Valor_Pte_mc_Mdo_SC', ftFloat, 0,False);
   end;
   if NOT Reg_Parametros.bSolo_Stock then
   begin
     DMValorizacion.Tmp_Res_Mercado_Ad.TableName := DMValorizacion.Tmp_Res_Mercado_Ad.TableName +IntToStr(Application.Handle);
     DMValorizacion.Tmp_Res_Mercado_Ad.CreateTable;
     DMValorizacion.Tmp_Res_Mercado_Ad.Open;
   end;

   with DMValorizacion.Qry_QS_RES_MERCADO_AD do
   begin
        sql.clear;
        sql.add('INSERT INTO QS_RES_MERCADO_AD ');
        sql.add('(');
        sql.Add('Empresa');
        sql.Add(',Cartera');
        sql.Add(',Transaccion');
        sql.Add(',Folio_interno');
        sql.Add(',Item_OMD');
        sql.Add(',Fecha_Cierre');
        sql.Add(',Tasa_Compra_I');
        sql.Add(',Valor_Pte_um_Cpa_Ini');
        sql.Add(',Valor_Pte_mc_Cpa_Ini');
        sql.Add(',Por_Valor_Par_Cpa_Ini');
        sql.Add(',Tasa_Mercado_Mdo_Ini');
        sql.Add(',Valor_Pte_um_Mdo_Ini');
        sql.Add(',Valor_Pte_mc_Mdo_Ini');
        sql.Add(',Por_Valor_Par_Mdo_Ini');
        sql.Add(',Precio_Mixto_Ini');
        sql.Add(',Valor_Pte_um_Mix_Ini');
        sql.Add(',Valor_Pte_mc_Mix_Ini');
        sql.Add(',Comprometido');
        sql.Add(',Emisor');
        sql.Add(',Instrumento');
        sql.Add(',Serie');
        sql.Add(',Nemotecnico');
        sql.Add(',Valor_Pte_um_Cpa_SC');
        sql.Add(',Valor_Pte_mc_Cpa_SC');
        sql.Add(',Valor_Pte_um_Mdo_SC');
        sql.Add(',Valor_Pte_mc_Mdo_SC');
        sql.add(')');
        sql.add(' VALUES ');
        sql.add('(');
        sql.Add(':Empresa');
        sql.Add(',:Cartera');
        sql.Add(',:Transaccion');
        sql.Add(',:Folio_interno');
        sql.Add(',:Item_OMD');
        sql.Add(',:Fecha_Cierre');
        sql.Add(',:Tasa_Compra_I');
        sql.Add(',:Valor_Pte_um_Cpa_Ini');
        sql.Add(',:Valor_Pte_mc_Cpa_Ini');
        sql.Add(',:Por_Valor_Par_Cpa_Ini');
        sql.Add(',:Tasa_Mercado_Mdo_Ini');
        sql.Add(',:Valor_Pte_um_Mdo_Ini');
        sql.Add(',:Valor_Pte_mc_Mdo_Ini');
        sql.Add(',:Por_Valor_Par_Mdo_Ini');
        sql.Add(',:Precio_Mixto_Ini');
        sql.Add(',:Valor_Pte_um_Mix_Ini');
        sql.Add(',:Valor_Pte_mc_Mix_Ini');
        sql.Add(',:Comprometido');
        sql.Add(',:Emisor');
        sql.Add(',:Instrumento');
        sql.Add(',:Serie');
        sql.Add(',:Nemotecnico');
        sql.Add(',:Valor_Pte_um_Cpa_SC');
        sql.Add(',:Valor_Pte_mc_Cpa_SC');
        sql.Add(',:Valor_Pte_um_Mdo_SC');
        sql.Add(',:Valor_Pte_mc_Mdo_SC');
        sql.add(')');
        Prepare;
   end;

   with DMValorizacion.Tmp_Res_Mercado_CC.FieldDefs do
   begin
      Clear;
      Add('Fecha', ftDatetime, 0,False);
      Add('Empresa', ftString, 10,False);
      Add('Cartera', ftString, 10,False);
      Add('Transaccion', ftString, 10 ,False);
      Add('Folio_interno', ftString, 15 ,False);
      Add('Item_OMD'   , ftFloat, 0,False);
      Add('Emisor'     , ftString, 10 ,False);
      Add('Instrumento', ftString, 10 ,False);
      Add('Serie'      , ftString, 30 ,False);
      Add('Nemotecnico', ftstring, 30 ,False);
      Add('Valor_Nominal', ftFloat, 0,False);
      Add('Valor_Pte_mc_Cpa', ftFloat, 0,False);
      Add('Valor_Pte_mc_Mdo', ftFloat, 0,False);
      Add('Valor_Pte_mc_Mixta', ftFloat, 0,False);
      Add('Valor_Pte_um_Cpa', ftFloat, 0,False);
      Add('Valor_Pte_um_Mdo', ftFloat, 0,False);
      Add('Valor_Pte_um_Mixta', ftFloat, 0,False);
   end;
   if NOT Reg_Parametros.bSolo_Stock then
   begin
     DMValorizacion.Tmp_Res_Mercado_CC.TableName := DMValorizacion.Tmp_Res_Mercado_CC.TableName +IntToStr(Application.Handle);
     DMValorizacion.Tmp_Res_Mercado_CC.CreateTable;
     DMValorizacion.Tmp_Res_Mercado_CC.Open;
   end;

   // Se elimina la tabla qs_res_mercado_cc
   // F.I. & GGARCIA 18-11-2010
   {
   with DMValorizacion.Qry_QS_RES_MERCADO_CC do
   begin
      sql.clear;
      sql.add(' INSERT INTO QS_RES_MERCADO_CC ');
      sql.add('(');
      sql.Add(' Fecha');
      sql.Add(',Empresa');
      sql.Add(',Cartera');
      sql.Add(',Transaccion');
      sql.Add(',Folio_interno');
      sql.Add(',Item_OMD'  );
      sql.Add(',Emisor'     );
      sql.Add(',Instrumento');
      sql.Add(',Serie'     );
      sql.Add(',Nemotecnico');
      sql.Add(',Valor_Nominal');
      sql.Add(',Valor_Pte_mc_Cpa');
      sql.Add(',Valor_Pte_mc_Mdo');
      sql.Add(',Valor_Pte_mc_Mixta');
      sql.Add(',Valor_Pte_um_Cpa');
      sql.Add(',Valor_Pte_um_Mdo');
      sql.Add(',Valor_Pte_um_Mixta');
      sql.add(')');
      sql.add(' VALUES ');
      sql.add('(');
      sql.Add(' :Fecha');
      sql.Add(',:Empresa');
      sql.Add(',:Cartera');
      sql.Add(',:Transaccion');
      sql.Add(',:Folio_interno');
      sql.Add(',:Item_OMD'  );
      sql.Add(',:Emisor'     );
      sql.Add(',:Instrumento');
      sql.Add(',:Serie'     );
      sql.Add(',:Nemotecnico');
      sql.Add(',:Valor_Nominal');
      sql.Add(',:Valor_Pte_mc_Cpa');
      sql.Add(',:Valor_Pte_mc_Mdo');
      sql.Add(',:Valor_Pte_mc_Mixta');
      sql.Add(',:Valor_Pte_um_Cpa');
      sql.Add(',:Valor_Pte_um_Mdo');
      sql.Add(',:Valor_Pte_um_Mixta');
      sql.add(')');
      Prepare;
   end;
   }

   with DMValorizacion.Tmp_RES_PROVISION.FieldDefs do
   begin
      Clear;
      Add('Empresa'       , ftString, 10,False);
      Add('Cartera'       , ftString, 10,False);
      Add('Fecha_Cierre'  , ftDatetime, 0,False);
      Add('Transaccion'   , ftString, 10 ,False);
      Add('Folio_interno' , ftString, 15 ,False);
      Add('Item_OMD'      , ftFloat, 0,False);
      Add('Emisor'        , ftString, 10 ,False);
      Add('Instrumento'   , ftString, 10 ,False);
      Add('Serie'         , ftString, 30 ,False);
      Add('Nemotecnico'   , ftString, 30 ,False);
      Add('FECHA_PRIMER_DIV'  , ftDatetime, 0,False);
      Add('FECHA_RETASACION'  , ftDatetime, 0,False);
      Add('VALOR_TASACION_UM' , ftFloat, 0,False);
      Add('NRO_DIVIDENDOS_IMP', ftFloat, 0,False);
      Add('DIVIDENDO_IMPAGO_UM', ftFloat, 0,False);
      Add('DIVIDENDO_IMPAGO_MC', ftFloat, 0,False);
      Add('PROVISION_UM'       , ftFloat, 0,False);
      Add('PROVISION_MC'       , ftFloat, 0,False);
   end;
   if NOT Reg_Parametros.bSolo_Stock then
   begin
     DMValorizacion.Tmp_RES_PROVISION.TableName := DMValorizacion.Tmp_RES_PROVISION.TableName +IntToStr(Application.Handle);
     DMValorizacion.Tmp_RES_PROVISION.CreateTable;
     DMValorizacion.Tmp_RES_PROVISION.Open;
   end;

   with DMValorizacion.Qry_QS_RES_PROVISION do
   begin
        sql.clear;
        sql.add('INSERT INTO QS_RES_PROVISION ');
        sql.add('(');
        sql.Add('Empresa' );
        sql.Add(',Cartera' );
        sql.Add(',Fecha_Cierre');
        sql.Add(',Transaccion' );
        sql.Add(',Folio_interno');
        sql.Add(',Item_OMD'      );
        sql.Add(',Emisor'       );
        sql.Add(',Instrumento' );
        sql.Add(',Serie'      );
        sql.Add(',Nemotecnico' );
        sql.Add(',FECHA_PRIMER_DIV' );
        sql.Add(',FECHA_RETASACION' );
        sql.Add(',VALOR_TASACION_UM');
        sql.Add(',NRO_DIVIDENDOS_IMP');
        sql.Add(',DIVIDENDO_IMPAGO_UM');
        sql.Add(',DIVIDENDO_IMPAGO_MC');
        sql.Add(',PROVISION_UM');
        sql.Add(',PROVISION_MC');
        sql.add(')');
        sql.add(' VALUES ');
        sql.add('(');
        sql.Add(' :Empresa' );
        sql.Add(',:Cartera' );
        sql.Add(',:Fecha_Cierre');
        sql.Add(',:Transaccion' );
        sql.Add(',:Folio_interno');
        sql.Add(',:Item_OMD'      );
        sql.Add(',:Emisor'       );
        sql.Add(',:Instrumento' );
        sql.Add(',:Serie'      );
        sql.Add(',:Nemotecnico' );
        sql.Add(',:FECHA_PRIMER_DIV' );
        sql.Add(',:FECHA_RETASACION' );
        sql.Add(',:VALOR_TASACION_UM');
        sql.Add(',:NRO_DIVIDENDOS_IMP');
        sql.Add(',:DIVIDENDO_IMPAGO_UM');
        sql.Add(',:DIVIDENDO_IMPAGO_MC');
        sql.Add(',:PROVISION_UM');
        sql.Add(',:PROVISION_MC');
        sql.add(')');
        Prepare;
   end;

   with DMValorizacion.Qry_QS_TRA_OMD_STK_RF do
   begin
        sql.clear;
        sql.add('INSERT INTO QS_TRA_OMD_STK_RF ');
        sql.add('(');
        sql.Add('Empresa');
        sql.Add(',Transaccion');
        sql.Add(',Folio_interno');
        sql.Add(',Item_OMD');
        sql.Add(',Fecha_Operacion');
        sql.Add(',Fecha_Stock');
        sql.Add(',Nemotecnico');
        sql.Add(',Emisor');
        sql.Add(',Instrumento');
        sql.Add(',Serie');
        sql.Add(',Fecha_emision');
        sql.Add(',Fecha_vencimiento');
        sql.Add(',Valor_Nominal');
        sql.Add(',Valor_Nominal_Calculo');
        sql.Add(',Tasa_Emision');
        sql.Add(',Tasa_Mercado');
        sql.Add(',Moneda_Instrum');
        sql.Add(',Tasa_Base_Par');
        sql.Add(',Tasa_Base_Tir');
        sql.Add(',Valor_Pte_um_Cpa');
        sql.Add(',Valor_Pte_mc_Cpa');
        sql.Add(',Porcen_Valor_Par');
        sql.Add(',Cartera');
        sql.Add(',Moneda_Pacto');
        sql.Add(',Tasa_Pacto');
        sql.Add(',Tasa_Base_Pacto');
        sql.Add(',Fecha_vcto_Pacto');
        sql.Add(',Tipo_Nominales');
        sql.Add(',Custodia');
        sql.Add(',Plazo_Al_Vcto');
        sql.Add(',Tipo_Instrum');
        sql.Add(',Valor_Pte_um_Mdo');
        sql.Add(',Valor_Pte_mc_Mdo');
        sql.Add(',Tasa_Mercado_Mdo');
        sql.Add(',Duration');
        sql.Add(',Plazo_Vcto');
        sql.Add(',Diferencia');
        sql.Add(',Valorizacion_Mixta');
        sql.Add(',Precio_Mixto');
        sql.Add(',Motivo_Inv');
        sql.Add(',Clasif_Riesgo');
        sql.Add(',Cupones_Cortados');
        sql.add(',Valor_PAR_UM');
        sql.add(',Valor_PAR_MC');
        sql.add(',Saldo_Insoluto_UM');
        sql.add(',Saldo_Insoluto_MC');
        sql.add(')');
        sql.add(' VALUES ');
        sql.add('(');
        sql.Add(':Empresa');
        sql.Add(',:Transaccion');
        sql.Add(',:Folio_interno');
        sql.Add(',:Item_OMD');
        sql.Add(',:Fecha_Operacion');
        sql.Add(',:Fecha_Stock');
        sql.Add(',:Nemotecnico');
        sql.Add(',:Emisor');
        sql.Add(',:Instrumento');
        sql.Add(',:Serie');
        sql.Add(',:Fecha_emision');
        sql.Add(',:Fecha_vencimiento');
        sql.Add(',:Valor_Nominal');
        sql.Add(',:Valor_Nominal_Calculo');
        sql.Add(',:Tasa_Emision');
        sql.Add(',:Tasa_Mercado');
        sql.Add(',:Moneda_Instrum');
        sql.Add(',:Tasa_Base_Par');
        sql.Add(',:Tasa_Base_Tir');
        sql.Add(',:Valor_Pte_um_Cpa');
        sql.Add(',:Valor_Pte_mc_Cpa');
        sql.Add(',:Porcen_Valor_Par');
        sql.Add(',:Cartera');
        sql.Add(',:Moneda_Pacto');
        sql.Add(',:Tasa_Pacto');
        sql.Add(',:Tasa_Base_Pacto');
        sql.Add(',:Fecha_vcto_Pacto');
        sql.Add(',:Tipo_Nominales');
        sql.Add(',:Custodia');
        sql.Add(',:Plazo_Al_Vcto');
        sql.Add(',:Tipo_Instrum');
        sql.Add(',:Valor_Pte_um_Mdo');
        sql.Add(',:Valor_Pte_mc_Mdo');
        sql.Add(',:Tasa_Mercado_Mdo');
        sql.Add(',:Duration');
        sql.Add(',:Plazo_Vcto');
        sql.Add(',:Diferencia');
        sql.Add(',:Valorizacion_Mixta');
        sql.Add(',:Precio_Mixto');
        sql.Add(',:Motivo_Inv');
        sql.Add(',:Clasif_Riesgo');
        sql.Add(',:Cupones_Cortados');
        sql.add(',:Valor_PAR_UM');
        sql.add(',:Valor_PAR_MC');
        sql.add(',:Saldo_Insoluto_UM');
        sql.add(',:Saldo_Insoluto_MC');
        sql.add(')');
        prepare;
   end;
   DMValorizacion.Qry_Tesoreria.Prepare;
   DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.Prepare;

   with DMValorizacion.Tmp_Stock.FieldDefs do
   begin
      Clear;
      Add('Empresa', ftString, 10,False);
      Add('Transaccion', ftString, 10 ,False);
      Add('Folio_interno', ftString, 15 ,False);
      Add('Item_OMD', ftFloat, 0,False);
      Add('Fecha_Operacion', ftDatetime, 0,False);
      Add('Fecha_Stock', ftDatetime, 0,False);
      Add('Nemotecnico', ftString, 30 ,False);
      Add('Emisor', ftString, 10 ,False);
      Add('Instrumento', ftString, 10 ,False);
      Add('Serie', ftString, 30 ,False);
      Add('Fecha_emision', ftDatetime, 0,False);
      Add('Fecha_vencimiento', ftDatetime, 0,False);
      Add('Valor_Nominal', ftFloat, 0,False);
      Add('Valor_Nominal_Calculo', ftFloat, 0,False);
      Add('Tasa_Emision', ftFloat, 0,False);
      Add('Tasa_Mercado', ftFloat, 0,False);
      Add('Moneda_Instrum', ftString, 15 ,False);
      Add('Tasa_Base_Par', ftString, 10 ,False);
      Add('Tasa_Base_Tir', ftString, 10 ,False);
      Add('Valor_Pte_um_Cpa', ftFloat, 0,False);
      Add('Valor_Pte_mc_Cpa', ftFloat, 0,False);
      Add('Porcen_Valor_Par', ftFloat, 0,False);
      Add('Cartera', ftString, 10,False);
      Add('Moneda_Pacto', ftString, 15 ,False);
      Add('Tasa_Pacto', ftFloat, 0,False);
      Add('Tasa_Base_Pacto', ftString, 10 ,False);
      Add('Fecha_vcto_Pacto', ftDatetime, 0,False);
      Add('Tipo_Nominales', ftString, 1 ,False);
      Add('Custodia', ftString, 10,False);
      Add('Plazo_Al_Vcto', ftFloat, 0,False);
      Add('Tipo_Instrum', ftString, 1 ,False);
      Add('Valor_Pte_um_Mdo', ftFloat, 0,False);
      Add('Valor_Pte_mc_Mdo', ftFloat, 0,False);
      Add('Tasa_Mercado_Mdo', ftFloat, 0,False);
      Add('Duration', ftFloat, 0,False);
      Add('Plazo_Vcto', ftString, 7 ,False);
      Add('Diferencia', ftFloat, 0,False);
      Add('Valorizacion_Mixta', ftFloat, 0,False);
      Add('Precio_Mixto', ftFloat, 0,False);
      Add('Motivo_Inv', ftString, 10 ,False);
      Add('Clasif_Riesgo', ftString, 10 ,False);
      Add('Cupones_Cortados', ftFloat, 0 ,False);
      Add('Valor_PAR_UM' , ftFloat, 0,False);
      Add('Valor_PAR_MC' , ftFloat, 0,False);
      Add('Saldo_Insoluto_UM' , ftFloat, 0,False);
      Add('Saldo_Insoluto_MC' , ftFloat, 0,False);
   end;
   DMValorizacion.Tmp_Stock.TableName := DMValorizacion.Tmp_Stock.TableName +IntToStr(Application.Handle);
   DMValorizacion.Tmp_Stock.CreateTable;
   DMValorizacion.Tmp_Stock.Open;

   with DMValorizacion.Tmp_Res_Proceso.FieldDefs do
   begin
      Clear;
      Add('Empresa'    , ftString, 10,False);
      Add('Cartera'    , ftString, 10,False);
      Add('Fecha'      , ftDatetime, 0,False);
      Add('Proceso'    , ftString, 10 ,False);
      Add('Transaccion', ftString, 10 ,False);
      Add('Folio'      , ftString, 15 ,False);
      Add('Item'       , ftFloat, 0,False);
      Add('Nemotecnico', ftString, 30 ,False);
      Add('Instrumento', ftString, 10 ,False);
      Add('Precio_Tasa', ftFloat, 0,False);
      Add('Valor'      , ftFloat, 0,False);
   end;
   DMValorizacion.Tmp_Res_Proceso.TableName := DMValorizacion.Tmp_Res_Proceso.TableName +IntToStr(Application.Handle);
   DMValorizacion.Tmp_Res_Proceso.CreateTable;
   DMValorizacion.Tmp_Res_Proceso.Open;


   if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
   begin
      WITH DMValorizacion.Qry_QS_ERP_INTERFAZ do
      begin
         SQL.Clear;
         SQL.Add('INSERT INTO ETLODSQS20'     //QS_ERP_CXP'
            +'('
            +' DS_CIA_ORIGEN'
            +',DS_SISTEMA_ORIGEN'
            +',ID_FECHA_PROCESO'
            +',ID_NUM_PROCESO'
            +',ID_NUM_ENVIO'
            +',ID_TIPO_REGISTRO'
            +',ID_TIPO_MOV'
            +',ID_ESTADO_PROC'
            +',F_CANTIDAD_REG'
            +',F_CANTIDAD_TIPO_MONEDA'
            +',ID_TIPO_MONEDA'
            +',DS_TIPO_MONEDA'
            +',F_IND_CTRL_MONTO'
            +',ID_CARTERA'
            +',DS_CARTERA'
            +',ID_TIPO_OPERACION'
            +',DS_TIPO_OPERACION'
            +',ID_INSTRUMENTO'
            +',DS_INSTRUMENTO'
            +',ID_FOLIO'
            +',ID_ITEM'
            +',ID_NEMOTECNICO'
            +',ID_EMISOR'
            +',DS_EMISOR'
            +',ID_TIPO_INVERSION'
            +',DS_TIPO_INVERSION'
            +',DS_CIA'
            +',ID_SUCURSAL'
            +',DS_SUCURSAL'
            +',ID_MOTIVO_INVERSION'
            +',ID_LINEA'
            +',ID_DIVISA_MONEDA'
            +',DS_DIVISA_MONEDA'
            +',ID_FEC_CONVERSION'
            +',F_TIPO_CAMBIO'
            +',F_MONTO_MONEDA'
            +',ID_FEC_OPERACION'
            +',ID_FEC_PAGO_CXP'
            +',ID_PROVEEDOR'
            +',DS_PROVEEDOR'
            +',ID_RUT'
            +',DS_DVRUT'
            +',ID_COD_IMPUESTO'
            +',DS_COD_IMPUESTO'
            +',F_VALOR_IMPUESTO'
            +',F_VALOR_COMISION'
            +',F_MONTO_TOTAL_OPERACION'
            +',DS_FACTURA'
            +',ID_TIPO_DOCUMENTO'
            +',DS_TIPO_DOCUMENTO'
            +',ID_PAIS'
            +',DS_PAIS'
            +')'
            +' VALUES ('
            +' :DS_CIA_ORIGEN'
            +',:DS_SISTEMA_ORIGEN'
            +',:ID_FECHA_PROCESO'
            +',:ID_NUM_PROCESO'
            +',:ID_NUM_ENVIO'
            +',:ID_TIPO_REGISTRO'
            +',:ID_TIPO_MOV'
            +',:ID_ESTADO_PROC'
            +',:F_CANTIDAD_REG'
            +',:F_CANTIDAD_TIPO_MONEDA'
            +',:ID_TIPO_MONEDA'
            +',:DS_TIPO_MONEDA'
            +',:F_IND_CTRL_MONTO'
            +',:ID_CARTERA'
            +',:DS_CARTERA'
            +',:ID_TIPO_OPERACION'
            +',:DS_TIPO_OPERACION'
            +',:ID_INSTRUMENTO'
            +',:DS_INSTRUMENTO'
            +',:ID_FOLIO'
            +',:ID_ITEM'
            +',:ID_NEMOTECNICO'
            +',:ID_EMISOR'
            +',:DS_EMISOR'
            +',:ID_TIPO_INVERSION'
            +',:DS_TIPO_INVERSION'
            +',:DS_CIA'
            +',:ID_SUCURSAL'
            +',:DS_SUCURSAL'
            +',:ID_MOTIVO_INVERSION'
            +',:ID_LINEA'
            +',:ID_DIVISA_MONEDA'
            +',:DS_DIVISA_MONEDA'
            +',:ID_FEC_CONVERSION'
            +',:F_TIPO_CAMBIO'
            +',:F_MONTO_MONEDA'
            +',:ID_FEC_OPERACION'
            +',:ID_FEC_PAGO_CXP'
            +',:ID_PROVEEDOR'
            +',:DS_PROVEEDOR'
            +',:ID_RUT'
            +',:DS_DVRUT'
            +',:ID_COD_IMPUESTO'
            +',:DS_COD_IMPUESTO'
            +',:F_VALOR_IMPUESTO'
            +',:F_VALOR_COMISION'
            +',:F_MONTO_TOTAL_OPERACION'
            +',:DS_FACTURA'
            +',:ID_TIPO_DOCUMENTO'
            +',:DS_TIPO_DOCUMENTO'
            +',:ID_PAIS'
            +',:DS_PAIS'
            +')'
            );
      end;

      with DMValorizacion.Tmp_ERP_CtasPorPagar.FieldDefs do
      begin
         Clear;
         Add('DS_CIA_ORIGEN'           , ftString, 10,False);
         Add('DS_SISTEMA_ORIGEN'       , ftString, 20,False);
         Add('ID_FECHA_PROCESO'        , ftDatetime, 0,False);
         Add('ID_NUM_PROCESO'          , ftFloat, 0,False);
         Add('ID_NUM_ENVIO'            , ftFloat, 0,False);
         Add('ID_TIPO_REGISTRO'        , ftInteger, 0,False);
         Add('ID_TIPO_MOV'             , ftInteger, 0,False);
         Add('ID_ESTADO_PROC'          , ftInteger, 0,False);
         Add('F_CANTIDAD_REG'          , ftInteger, 0,False);
         Add('F_CANTIDAD_TIPO_MONEDA'  , ftInteger, 0,False);
         Add('ID_TIPO_MONEDA'          , ftString, 15,False);
         Add('DS_TIPO_MONEDA'          , ftString, 60,False);
         Add('F_IND_CTRL_MONTO'        , ftFloat, 0,False);
         Add('ID_CARTERA'              , ftString, 10 ,False);
         Add('DS_CARTERA'              , ftString, 60 ,False);
         Add('ID_TIPO_OPERACION'       , ftString, 10 ,False);
         Add('DS_TIPO_OPERACION'       , ftString, 60 ,False);
         Add('ID_INSTRUMENTO'          , ftString, 10 ,False);
         Add('DS_INSTRUMENTO'          , ftString, 60 ,False);
         Add('ID_FOLIO'                , ftString, 15 ,False);
         Add('ID_ITEM'                 , ftFloat, 0,False);
         Add('ID_NEMOTECNICO'          , ftString, 30 ,False);
         Add('ID_EMISOR'               , ftString, 10 ,False);
         Add('DS_EMISOR'               , ftString, 60 ,False);
         Add('ID_TIPO_INVERSION'       , ftString, 30 ,False);
         Add('DS_TIPO_INVERSION'       , ftString, 60 ,False);
         Add('DS_CIA'                  , ftString, 10 ,False);
         Add('ID_SUCURSAL'             , ftString, 10 ,False);
         Add('DS_SUCURSAL'             , ftString, 60 ,False);
         Add('ID_MOTIVO_INVERSION'     , ftString, 10 ,False);
         Add('ID_LINEA'                , ftString, 20 ,False);
         Add('ID_DIVISA_MONEDA'        , ftString, 10 ,False);
         Add('DS_DIVISA_MONEDA'        , ftString, 60 ,False);
         Add('ID_FEC_CONVERSION'       , ftDatetime, 0,False);
         Add('F_TIPO_CAMBIO'           , ftFloat, 0,False);
         Add('F_MONTO_MONEDA'          , ftFloat, 0,False);
         Add('ID_FEC_OPERACION'        , ftDatetime, 0,False);
         Add('ID_FEC_PAGO_CXP'         , ftDatetime, 0,False);
         Add('ID_PROVEEDOR'            , ftString, 10 ,False);
         Add('DS_PROVEEDOR'            , ftString, 60 ,False);
         Add('ID_RUT'                  , ftFloat, 0,False);
         Add('DS_DVRUT'                , ftString, 01 ,False);
         Add('ID_COD_IMPUESTO'         , ftString, 10 ,False);
         Add('DS_COD_IMPUESTO'         , ftString, 60 ,False);
         Add('F_VALOR_IMPUESTO'        , ftFloat, 0,False);
         Add('F_VALOR_COMISION'        , ftFloat, 0,False);
         Add('F_MONTO_TOTAL_OPERACION' , ftFloat, 0,False);
         Add('DS_FACTURA'              , ftString, 50 ,False);
         Add('ID_TIPO_DOCUMENTO'       , ftString, 10 ,False);
         Add('DS_TIPO_DOCUMENTO'       , ftString, 60 ,False);
         Add('ID_PAIS'                 , ftString, 10 ,False);
         Add('DS_PAIS'                 , ftString, 60 ,False);
      end;
      if NOT Reg_Parametros.bSolo_Stock then
      begin
         DMValorizacion.Tmp_ERP_CtasPorPagar.TableName := DMValorizacion.Tmp_ERP_CtasPorPagar.TableName +IntToStr(Application.Handle);
         DMValorizacion.Tmp_ERP_CtasPorPagar.CreateTable;
         DMValorizacion.Tmp_ERP_CtasPorPagar.Open;
      end;
   end;

   // ggarcia 21-09-2011 se mueve debajo del delete de la qs_tes_egring
   {
   Mostrar_Mensaje('Cargando Movimientos Impagos ...', bAbortar);
   if NOT bAbortar then
   begin
       if sImplicancia_Mercado = 'MERCADO' then
          Carga_Folios_Tesoreria_Impagos_Mem(  dFecha_Inicial
                                              ,dFecha_Final + 1
                                            )
       else
          Carga_Folios_Tesoreria_Impagos_Mem(  dFecha_Inicial
                                              ,dFecha_Final
                                            );
   end;
   //}

   Mostrar_Mensaje('Cargando Metodos Valuacion ...', bAbortar);
   if NOT bAbortar then
   Carga_Metodos_Valuacion_Mem;

   Mostrar_Mensaje('Cargando Redondeo Monedas ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Redondeo_Monedas_Mem( dFecha_Inicial );

   Mostrar_Mensaje('Cargando Valores Monedas por Periodo ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Monedas_Periodo_Mem;

   Mostrar_Mensaje('Cargando Excepciones Cambiarias ...', bAbortar);
   if NOT bAbortar then
   Carga_Excepcion_Cambiaria_Mem; // ( dFecha_Final );

   // Implicancia NO USAR MEMORIA SE ESTA PROBANDO PARA LA SVS
   // ya que las tablas de descripores son demasiado grandes ...
   if sImplica_NOMEM <> 'S' then
   begin
     Mostrar_Mensaje('Cargando Descriptores ...', bAbortar);
     if NOT bAbortar then
        if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
           Carga_Descriptores_Mem( dFecha_Inicial )
        else
           Carga_Descriptores_Vig_Mem( dFecha_Inicial );
   end;

   Mostrar_Mensaje('Cargando Codigos Carteras ...', bAbortar);
   if NOT bAbortar then
   Carga_Carteras_Mem;

   Mostrar_Mensaje('Cargando Implicancia de Transacciones ...', bAbortar);
   if NOT bAbortar then
   Carga_Tran_Implic_Mem;

   Mostrar_Mensaje('Cargando Codigos Instrumentos ...', bAbortar);
   if NOT bAbortar then
   Carga_Instrumentos_Unicos_Mem;

   Mostrar_Mensaje('Cargando Divisiones Geograficas ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Division_Geografica_Mem;

   Mostrar_Mensaje('Cargando Direcciones ...', bAbortar);
   if NOT bAbortar then
   Carga_Item_Direccion_Identidad_Mem( dFecha_Final );

   Mostrar_Mensaje('Cargando Datos Transacciones ...', bAbortar);
   if NOT bAbortar then
   Carga_Datos_Transaccion_Mem;

   Mostrar_Mensaje('Cargando Codigos Default ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Default_Cod_General_Mem;

   Mostrar_Mensaje('Cargando Duration Fijo ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Duration_Fijo_Mem;

   // Implicancia NO USAR MEMORIA SE ESTA PROBANDO PARA LA SVS
   // ya que las tablas de descripores son demasiado grandes ...
   if sImplica_NOMEM <> 'S' then
   begin
     Mostrar_Mensaje('Cargando Nemotecnicos ...', bAbortar);
     if NOT bAbortar then
     Carga_Nemotecnicos_Mem( dFecha_Final );
   end;
   {   Ahora lo hace directo de la tabla
   Mostrar_Mensaje('Cargando Fechas Variables ...', bAbortar);
   if NOT bAbortar then
   Carga_Nem_Fechas_Variables_Mem( dFecha_Final );
   }
   Mostrar_Mensaje('Cargando Formulas ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Formulas_Par_Pte_Mem;

   Mostrar_Mensaje('Cargando Tasas Base ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Tasa_base_Mem;

   Mostrar_Mensaje('Cargando Tasa Referencia ...', bAbortar);
   if NOT bAbortar then
      Carga_Valores_Metodo_Sin_Tasa_Referencia_Mem;

   Mostrar_Mensaje('Cargando Proyecciones ...', bAbortar);
   if NOT bAbortar then
   Carga_Proyeccion_Precios_Mem;

   Mostrar_Mensaje('Cargando Parametros Margen ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Parametros_Margen_Mem;
   //Carga_Valores_Parametros_Margen_Mem( dFecha_Final );

   Mostrar_Mensaje('Cargando Clasificaciones de Riesgo ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Clasif_Riesgo_Mem( dFecha_Final );

   Mostrar_Mensaje('Cargando Emisores Pagadores ...', bAbortar);
   if NOT bAbortar then
   Carga_Emisor_Pagador_Mem( dFecha_Final );

   Mostrar_Mensaje('Cargando Emisiones Implicitas ...', bAbortar);
   if NOT bAbortar then
   Carga_Emision_Implicita_Mem;

   Mostrar_Mensaje('Cargando Equivalencias ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Equivalencia( dFecha_Final );

   Mostrar_Mensaje('Cargando Metodos de Valuación SUPER ...', bAbortar);
   if NOT bAbortar then
   Carga_Metodos_Valuacion_Super_Mem( dFecha_Final );

   //Valores Necesarios para Instrumentos Tasa Flotante
   Mostrar_Mensaje('Cargando Valores Desagio ...', bAbortar);
   if NOT bAbortar then
   Carga_Valores_Desagio_Mem;

   Mostrar_Mensaje('Cargando Base de Conversión ...', bAbortar);
   if NOT bAbortar then
   Carga_Base_Conversion_Mem;

   Mostrar_Mensaje('Cargando Valores Tasa Básica ...', bAbortar);
   if NOT bAbortar then
   Carga_Metodo_Calcula_Tasa_Basica( dFecha_Final );

   Mostrar_Mensaje('Cargando Flujos Tasa Flotante ...', bAbortar);
   if NOT bAbortar then
   Carga_Flujos_Flotante_Mem;

   Mostrar_Mensaje('Cargando Tratamiento Fechas ...', bAbortar);
   if NOT bAbortar then
   Carga_Tratamiento_Fechas_Mem;

   Mostrar_Mensaje('Cargando Monedas, Paises ...', bAbortar);
   if NOT bAbortar then
   Carga_Monedas_Pais_Mem;

   Mostrar_Mensaje('Cargando Rango Cálculo Tasa ...', bAbortar);
   if NOT bAbortar then
   Carga_Rango_tasas_Mem( dFecha_Final );

   Mostrar_Mensaje('Creando Tablas Temporales T.F.  ...', bAbortar);
   if NOT bAbortar then
   Crea_Tablas_Temporales_Tasa_Flotante;

   Mostrar_Mensaje('Cargando Factores de Riesgo ...', bAbortar);
   if NOT bAbortar then
      Carga_Nro_Clasif_Riesgo;

   Mostrar_Mensaje('Cargando Indices (1) ...', bAbortar);
   if NOT bAbortar then
   Carga_IpcBR_Mem( dFecha_Final + 5 );

   Mostrar_Mensaje('Cargando Indices (2) ...', bAbortar);
   if NOT bAbortar then
   Carga_UF_Mem( dFecha_Final + 5 );

   Mostrar_Mensaje('Cargando Feriados ...', bAbortar);
   if NOT bAbortar then
   Carga_Dias_Feriados_Mem;

   Mostrar_Mensaje('Cargando Spread de Operaciones ...', bAbortar);
   Carga_Spread_Mem;

   // CJF, Carga formulas que aplicar devengamiento
   //
   Mostrar_Mensaje('Cargando Formulas ...', bAbortar);
   Carga_Formula_aplica_dev;
   //

   if Reg_Parametros.bGenera_Stock then
   begin
      Mostrar_Mensaje('Insertando Implicancia "VALORIZANDO"...', bAbortar);
      if (sDriver = 'ORACLE') and
         (NOT dmBaseDatos.Database_General.InTransaction) then
         dmBaseDatos.Database_General.StartTransaction;

      Marca_Proceso_Valorizacion('VALORIZANDO');
      if (sDriver = 'ORACLE') and
         (dmBaseDatos.Database_General.InTransaction) then
         dmBaseDatos.Database_General.Commit;

   end;

   // Chequeo de Consistencia de Transacciones Temporales
   fNum_Regs            := 0;
   with DMValorizacion,QRY_General do
   begin
       sString_Empresas := '';
       Close;
       Sql.Clear;
       SQL.Add('  SELECT Distinct valor As Empresa ');
       SQL.Add('         FROM QS_SYS_PARAM_PROCESO ');
       SQL.Add('  WHERE proceso  = :proceso       ');
       SQL.Add('  AND parametro  = ''EMPRESA'' ');
       Parambyname('Proceso').asString := IntToStr(Application.Handle);
       Open;

       if Not Fieldbyname('Empresa').IsNull then
       begin
          sString_Empresas := sString_Empresas +' ( '''+Fieldbyname('Empresa').asString;
          Next;
          While Not Eof do
          begin
             sString_Empresas := sString_Empresas + ''','''+Fieldbyname('Empresa').asString;
             Next;
          end;
          sString_Empresas := sString_Empresas +''' )';
       end
       else
          sString_Empresas := '( '''+sEmpresa_Usuario+''' )';


      Close;
      SQL.Clear;
      SQL.Add('SELECT a.Empresa, a.Login_Usuario, a.Fecha_Operacion, a.Transaccion, ''EXISTEN OPERACIONES PENDIENTES DE GRABAR PARA '' as Error');
      SQL.Add('  FROM QS_TMP_OMD a');
      SQL.Add('      ,QS_TMP_OMD_DET_RF b');
      SQL.Add(' WHERE a.Empresa       IN '+sString_Empresas);
      SQL.Add('   AND b.Folio_Interno = a.Folio_Interno');
      SQL.Add('   AND b.Transaccion   = a.Transaccion');
      SQL.Add('   AND b.Empresa       = a.Empresa');
      SQL.Add('   AND a.TRANSACCION IN (SELECT b.CODIGO_TRANSACCION            ');
      SQL.Add('          	          FROM QS_SYS_TRAN_IMPLIC b            ');
      SQL.Add('      	  	         WHERE b.IMPLICANCIA IN ( ''VENTA'', ''PENDIENTE'') )     ');
      SQL.Add('   AND a.TRANSACCION NOT IN (SELECT c.CODIGO_TRANSACCION        ');
      SQL.Add('      		              FROM QS_SYS_TRAN_IMPLIC c        ');
      SQL.Add('      		             WHERE c.IMPLICANCIA = ''RV'')     ');
      Open;
      While Not EOF do
      begin
         sMensaje  :=   ' OPERACION PENDIENTE DE GRABAR ';
//         sMensaje  :=   ' Usuario : ' + FieldByName('Login_Usuario').AsString
//                       +' - '
//                       +' Transaccion : '+FieldByName('Transaccion').AsString
//                       +' - '
//                       +'Fecha Operacion : '+FieldByName('Fecha_Operacion').AsString;

         Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                   sProceso,
                                   dFecha_Inicial,
                                   sLogin_Sistema,
                                   sMensaje,
                                   'Consistencia de OMDs',
                                   FieldByName('Error').AsString
                                  +' '
                                  +FieldByName('Login_Usuario').AsString
                                  +' - '
                                  +FieldByName('Transaccion').AsString
                                  +' - '
                                  +FieldByName('Fecha_Operacion').AsString
                                  ,'01'
                                                                      );
         fNum_Regs := 1;
         Next;
      end;
   end;

   if fNum_Regs <> 0 then
   begin
//      Close;
      Marca_Proceso_Valorizacion('');{borra marca de valorizando}
      Termino_proceso;
      if (sDriver = 'ORACLE') and
         (dmBaseDatos.Database_General.InTransaction) then
          dmBaseDatos.Database_General.RollBack;

      if Reg_Parametros.sTipo_de_Proceso = 'M' then
         if NOT bAbortar then
         begin
            Frm_FinalizaValorizacion := TFrm_FinalizaValorizacion.Create(DMValorizacion);
            Frm_FinalizaValorizacion.Caption := sCaption;
            Frm_FinalizaValorizacion.width := 196;
            Frm_FinalizaValorizacion.Btn_Aceptar.left := 55;
            Frm_FinalizaValorizacion.Lb_Mensaje.caption := 'Valorización Finalizada';
            Frm_FinalizaValorizacion.ShowModal;
            //Application.MessageBox('Valorización Finalizada'
            //                      ,Pchar(sCaption)
            //                      ,mb_Ok+MB_ICONINFORMATION)
         end
         else
         begin
            Frm_FinalizaValorizacion := TFrm_FinalizaValorizacion.Create(DMValorizacion);
            Frm_FinalizaValorizacion.Caption := sCaption;
            Frm_FinalizaValorizacion.width := 257;
            Frm_FinalizaValorizacion.Lb_Mensaje.caption := 'Valorización Cancelada, por Usuario';
            Frm_FinalizaValorizacion.Btn_Aceptar.left := 87;
            Frm_FinalizaValorizacion.ShowModal;
            //Application.MessageBox('Valorización Cancelada, por Usuario'
            //                      ,Pchar(sCaption)
            //                      ,mb_Ok+MB_ICONINFORMATION);
         end;
         Mostrar_Mensaje('Proceso de Valorización Terminado', bAbortar);

         sValorizacion_Proceso := '';
         with DMValorizacion do
         begin
           if NOT Reg_Parametros.bSolo_Stock then
           begin
              T_Res_Mercado.Close;
              T_Res_Mercado_Ad.Close;
              T_Res_Mercado_CC.Close;
              T_Tes_Egring.Close;
              T_Stock.Close;

              Tmp_Res_Mercado.Close;
              Tmp_RES_PROVISION.Close;

              Tmp_Res_Mercado_Ad.Close;
              Tmp_Res_Mercado_CC.Close;
              Tmp_Stock.Close;
              Tmp_Res_Mercado.DeleteTable;
              Tmp_RES_PROVISION.DeleteTable;
              Tmp_Res_Mercado_Ad.DeleteTable;
              Tmp_Stock.DeleteTable;
              Tmp_Res_Mercado_CC.DeleteTable;
              T_Res_Proceso.Close;
              Tmp_Res_Proceso.Close;
              Tmp_Res_Proceso.DeleteTable;
              if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
              begin
                 Tmp_ERP_CtasPorPagar.Close;
                 Tmp_ERP_CtasPorPagar.DeleteTable;
              end;
           end
           else
           begin
              T_Stock.Close;
              Tmp_Stock.Close;
              Tmp_Stock.DeleteTable;

              T_Res_Proceso.Close;
              Tmp_Res_Proceso.Close;
              Tmp_Res_Proceso.DeleteTable;
           end;
         end;
      exit;
   end;


   // Cambio realizado
   bExiste_Tabla_Det_PP := True;
   fNum_Regs            := 0;
   with DMValorizacion,QRY_General do
   begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS num_regs');
      SQL.Add(' FROM QS_TRA_OMD_DET_PP a');
      try
        Open;
        fNum_Regs := FieldByName('num_regs').AsFloat;
        Close;
      except
         bExiste_Tabla_Det_PP := False;
      end;
      if fNum_Regs = 0 then
         bExiste_Tabla_Det_PP := False;

      try
         SQL.Clear;
         SQL.Add('SELECT Empresa '
                +'  FROM QS_TRA_FWD ');
         Open;
         bforward := true;
      except
         bforward := false;
      end;

   end;

 {
   if bdesarrollo then
   begin
     Reg_Parametros.bFolios       := True;
     Reg_Parametros.fFolio_desde  := 14345;
     Reg_Parametros.fFolio_hasta  := 14345;
   end;
//}

   While (dFecha_Inicial <= dFecha_Final) and (NOT bAbortar) do
   begin
     Mostrar_Mensaje( 'Chequeando Consistencia ...', bAbortar);
     with DMValorizacion,QRY_General do
     begin
       sString_Empresas := '';
       Close;
       Sql.Clear;
       SQL.Add('  SELECT Distinct valor As Empresa ');
       SQL.Add('         FROM QS_SYS_PARAM_PROCESO ');
       SQL.Add('  WHERE proceso  = :proceso       ');
       SQL.Add('  AND parametro  = ''EMPRESA'' ');
       Parambyname('Proceso').asString := IntToStr(Application.Handle);
       Open;

       if Not Fieldbyname('Empresa').IsNull then
       begin
          sString_Empresas := sString_Empresas +' ( '''+Fieldbyname('Empresa').asString;
          Next;
          While Not Eof do
          begin
             sString_Empresas := sString_Empresas + ''','''+Fieldbyname('Empresa').asString;
             Next;
          end;
          sString_Empresas := sString_Empresas +''' )';
       end
       else
          sString_Empresas := '( '''+sEmpresa_Usuario+''' )';

       Close;
       Sql.Clear;
       SQL.Add(' SELECT z.Cartera FROM QS_SYS_PARAM_EMPRESA z'
              +' WHERE z.Empresa IN '+ sString_Empresas
              +'   AND z.Pid     = :Pid'
              );
       Parambyname('Pid').asFloat := Application.Handle;
       Open;
       sString_Carteras := '';
       if Not Fieldbyname('Cartera').IsNull then
       begin
          if NOT EOF then
             sString_Carteras := sString_Carteras +' ( '''+Fieldbyname('Cartera').asString;
          Next;
          While Not Eof do
          begin
             sString_Carteras := sString_Carteras +''','''+Fieldbyname('Cartera').asString;
             Next;
          end;
          sString_Carteras := sString_Carteras + ''' )';
       end
       else
          sString_Carteras := '';

       sString_Emisores := '';
       Close;
       if Reg_Parametros.bEmisores then
       begin
          Sql.Clear;
          SQL.Add(' SELECT Valor as Emisor FROM QS_SYS_PARAM_PROCESO '
                 +' WHERE Parametro = ''STK_EMISOR'''
                 +'   AND Proceso   = :Proceso'
                 );
          Parambyname('Proceso').asString := IntToStr(Application.Handle);
          Open;
          sString_Emisores := '';
          if Not Fieldbyname('Emisor').IsNull then
          begin
             if NOT EOF then
                sString_Emisores := sString_Emisores +' ( '''+Fieldbyname('Emisor').asString;
             Next;
             While Not Eof do
             begin
                sString_Emisores := sString_Emisores +''','''+Fieldbyname('Emisor').asString;
                Next;
             end;
             sString_Emisores := sString_Emisores + ''' )';

          end
          else
             sString_Emisores := '';
       end;

       sString_Instrumentos := '';
       if Reg_Parametros.bInstrumentos then
       begin
          Close;
          Sql.Clear;
          SQL.Add(' SELECT Valor as Instrumento FROM QS_SYS_PARAM_PROCESO '
                 +' WHERE Parametro = ''STK_INST'''
                 +'   AND Proceso   = :Proceso'
                 );
          Parambyname('Proceso').asString := IntToStr(Application.Handle);
          Open;
          sString_Instrumentos := '';
          if Not Fieldbyname('Instrumento').IsNull then
          begin
             if NOT EOF then
                sString_Instrumentos := sString_Instrumentos +' ( '''+Fieldbyname('Instrumento').asString;
             Next;
             While Not Eof do
             begin
                sString_Instrumentos := sString_Instrumentos +''','''+Fieldbyname('Instrumento').asString;
                Next;
             end;
             sString_Instrumentos := sString_Instrumentos + ''' )';

          end
          else
             sString_Instrumentos := '';
       end;

       /////////////////////////////////////////////////////////////////////////
       //  LLenando Tabla temporal Detalle OMD (Re-Allocation)
       /////////////////////////////////////////////////////////////////////////
       Mostrar_Mensaje('LLenando Tabla temporal Detalle OMD (Re-Allocation)...', bAbortar);
       Detalle_OMD_Re_Allocation(dFecha_Inicial,'1=1');
       /////////////////////////////////////////////////////////////////////////

       Close;
       Mostrar_Mensaje( 'Chequeando Consistencia (Existencia Nemotecnicos) ...', bAbortar);
       SQL.Clear;
       SQL.Add('SELECT b.Empresa                          ');
       SQL.Add('      ,b.Nemotecnico                      ');
       SQL.Add('      ,b.Emisor                           ');
       SQL.Add('      ,b.Instrumento                      ');
       SQL.Add('      ,b.Serie                            ');
       SQL.Add('      ,b.Folio_Interno                    ');
       SQL.Add('      ,b.Item_omd                         ');
       SQL.Add('  FROM Qs_Tra_Omd_Det_Rf b                               ');
       SQL.Add(' WHERE b.Nemotecnico NOT IN (SELECT c.Codigo_Nemotecnico             ');
       SQL.Add('       		      	     FROM QS_FIN_NEM_RFIJA c                 ');
       SQL.Add('			                 WHERE c.Codigo_Nemotecnico = b.Nemotecnico)');
       SQL.Add('  AND b.Tipo_Instrum  = ''S''                                             ');
       SQL.Add('  AND b.folio_interno not in (SELECT e.folio                              ');
       SQL.Add('				 FROM qs_ctr_anulacion e                  ');
       SQL.Add('				WHERE e.folio       = b.folio_interno    ');
       SQL.Add('				  AND e.transaccion = b.transaccion      ');
       SQL.Add('  				  AND e.empresa     = b.empresa)         ');
       SQL.Add(' AND b.Empresa IN '+sString_Empresas                                      );

       if Reg_Parametros.bSolo_Var then
       begin
          Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                +' )' );
           Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
       end;

       Open;
       WHILE NOT EOF do
       begin
          sMensaje  := ' Folio : ' + FieldByName('Folio_Interno').AsString
                       +' - '
                       +' Item : ' + FieldByName('Item_Omd').AsString
                       +' - '
                       +FieldByName('Emisor').AsString
                       +' - '
                       +FieldByName('Instrumento').AsString
                       +' - '
                       +FieldByName('Serie').AsString
                       +' - '
                       +FieldByName('Nemotecnico').AsString;

          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                    sProceso,
                                    dFecha_Inicial,
                                    sLogin_Sistema,
                                    sMensaje,
                                    'Consistencia',
                                    'NO EXISTE DEFINICION DE NEMOTECNICO'
                                    + ' : ' + FieldByName('Nemotecnico').AsString
                                    ,'99'
                                    );
          Next;
       end;
       Close;
       Mostrar_Mensaje( 'Chequeando Consistencia (Descriptores) ...', bAbortar);
       SQL.Clear;
       SQL.Add('SELECT b.Empresa                           ');
       SQL.Add('      ,b.Nemotecnico                       ');
       SQL.Add('      ,d.Codigo_Identidad As Emisor        ');
       SQL.Add('      ,d.Codigo_Instrumento As Instrumento ');
       SQL.Add('      ,d.Serie                             ');
       SQL.Add('      ,b.Folio_Interno                     ');
       SQL.Add('      ,b.Item_omd                          ');
       SQL.Add('      ,''ERROR EN DEFINICION DE DESCRIPTOR '' As Error  ');
       SQL.Add('  FROM Qs_Tra_Omd_Det_Rf b                               ');
       SQL.Add('      ,qs_fin_nem_rfija d                               ');
       SQL.Add(' WHERE d.Codigo_Nemotecnico = b.Nemotecnico                          ');
       SQL.Add('   AND b.TRANSACCION IN (SELECT x.CODIGO_TRANSACCION            ');
       SQL.Add('      		           FROM QS_SYS_TRAN_IMPLIC x           ');
       SQL.Add('      		          WHERE x.IMPLICANCIA = ''COMPRA'')     ');
       SQL.Add('   AND b.TRANSACCION NOT IN (SELECT y.CODIGO_TRANSACCION        ');
       SQL.Add('      		               FROM QS_SYS_TRAN_IMPLIC y        ');
       SQL.Add('      		              WHERE y.IMPLICANCIA = ''RV'')     ');
       SQL.Add('   AND d.Serie NOT IN (SELECT c.Serie                                ');
       SQL.Add('        	         FROM QS_FIN_DESCRIPTOR c                    ');
       SQL.Add('			WHERE c.Serie = d.Serie                      ');
       SQL.Add('			  AND c.Codigo_Instrumento = d.Codigo_Instrumento');
       SQL.Add('			  AND c.Codigo_Emisor = d.Codigo_Identidad)');
       SQL.Add('  AND b.folio_interno not in (SELECT e.folio                              ');
       SQL.Add('				 FROM qs_ctr_anulacion e                  ');
       SQL.Add('				WHERE e.folio       = b.folio_interno    ');
       SQL.Add('				  AND e.transaccion = b.transaccion      ');
       SQL.Add('  				  AND e.empresa     = b.empresa)         ');
       SQL.Add(' AND b.Empresa IN '+sString_Empresas                                      );

       if Reg_Parametros.bSolo_Var then
       begin
          Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                +' )' );
           Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
       end;

       Open;
       WHILE NOT EOF do
       begin
         sMensaje  := ' Folio : ' + FieldByName('Folio_Interno').AsString
                       +' - '
                       +' Item : ' + FieldByName('Item_Omd').AsString
                       +' - '
                       +FieldByName('Emisor').AsString
                       +' - '
                       +FieldByName('Instrumento').AsString
                       +' - '
                       +FieldByName('Serie').AsString
                       +' - '
                       +FieldByName('Nemotecnico').AsString;

          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                    sProceso,
                                    dFecha_Inicial,
                                    sLogin_Sistema,
                                    sMensaje,
                                    'Consistencia',
                                    FieldByName('Error').AsString
                                   +' '
                                   +FieldByName('Emisor').AsString
                                   +' - '
                                   +FieldByName('Instrumento').AsString
                                   +' - '
                                   +FieldByName('Serie').AsString
                                   ,'99'
                                                                       );
          Next;
       end;
       Close;
       sMensaje := '';


       if (Reg_Parametros.bCarteras ) and
          ( (Reg_Parametros.bInstrumentos) or
            (Reg_Parametros.bEmisores)
          ) then
       begin
           Mostrar_Mensaje( 'Preparando Empresa - Cartera en memoria ...', bAbortar);
           Sql.Clear;
           Sql.Add(' SELECT Empresa,Cartera FROM QS_SYS_PARAM_EMPRESA ' );
           SQL.Add('  WHERE Empresa IN (SELECT Distinct valor As Empresa                  ');
           SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
           SQL.Add('                     WHERE proceso   = :proceso                       ');
           SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
           SQL.Add('  AND Pid     = :Pid'                                                  );
           Parambyname('Pid').asFloat      := Application.Handle;
           Parambyname('Proceso').asString := IntToStr(Application.Handle);
           Open;

           i:= RecordCount;
           Reg_Carteras_Proceso.Empresa := VarArrayCreate([0, i], varOleStr);
           Reg_Carteras_Proceso.Cartera := VarArrayCreate([0, i], varOleStr);

           i := 0;
           while not eof do
           begin
               Reg_Carteras_Proceso.Empresa[i] := Fieldbyname('Empresa').asString;
               Reg_Carteras_Proceso.Cartera[i] := Fieldbyname('Cartera').asString;
               Inc(i);
               Next;
           end;
           Close;

           //Verifico Cartera por Cartera
           if NOT bValorizando_Stock_Parcial then
           begin
              Mostrar_Mensaje( 'Verificando valorizaciones anteriores de carteras (1) ...', bAbortar);
              bError_Cartera := False;
              if Reg_Parametros.bSolo_Stock then
              begin
                 For i := 0 to VarArrayHighBound(Reg_Carteras_Proceso.Cartera, 1 )-1 do
                 begin
                   Sql.Clear;
                   Sql.Add( 'SELECT Empresa FROM QS_TRA_OMD_STK_RF '
                           +' WHERE Fecha_Stock  = :Fecha_Cierre'
                           +'   AND empresa      = :empresa'
                           +'   AND Cartera      = :Cartera'
                           );
                   Parambyname('Empresa').AsString        := Reg_Carteras_Proceso.Empresa[i];
                   Parambyname('Cartera').AsString        := Reg_Carteras_Proceso.Cartera[i];
                   Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
                   Open;

                   if Fieldbyname('Empresa').IsNull then
                   begin
                      sString_Error := ' Cartera '+Reg_Carteras_Proceso.Cartera[i]
                                      +' Stock No generado al '+Datetostr(dFecha_Inicial)+' '#10
                                      +' Debe Generar stock Completo para esta cartera'#10
                                      +' Para Utilizar parámetros de Reproceso ';
                      Application.MessageBox(Pchar( sString_Error )
                                            ,'PROCESO'
                                            ,Mb_OK);
                      bError_Cartera := True;
                   end;
                   Close;
                 end;{for}
              end
              else
              begin
                 For i := 0 to VarArrayHighBound(Reg_Carteras_Proceso.Cartera, 1 )-1 do
                 begin
                   Sql.Clear;
                   Sql.Add( 'SELECT Empresa FROM QS_RES_MERCADO'
                           +' WHERE Fecha_Cierre = :Fecha_Cierre'
                           +'   AND empresa      = :empresa'
                           +'   AND Cartera      = :Cartera'
                           );
                   Parambyname('Empresa').AsString        := Reg_Carteras_Proceso.Empresa[i];
                   Parambyname('Cartera').AsString        := Reg_Carteras_Proceso.Cartera[i];
                   Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
                   Open;

                   if Fieldbyname('Empresa').IsNull then
                   begin
                      sString_Error := ' Cartera '+Reg_Carteras_Proceso.Cartera[i]
                                      +' No Valorada al '+Datetostr(dFecha_Inicial)+' '#10
                                      +' Debe Valorar Cartera Completa'#10
                                      +' Para Selección de Emisor, Instrumento';
                      Application.MessageBox(Pchar( sString_Error )
                                            ,'PROCESO'
                                            ,Mb_OK);
                      bError_Cartera := True;
                   end;
                   Close;
                 end;{for}
              end;{else}

              if bError_Cartera then
              begin
                 dFecha_Inicial := dFecha_Inicial + 1;
                 Continue;
              end;
          end; //IF...bValorizando_Stock_Parcial
        end;

     dFecha_Aux := dFecha_Inicial;
     if sImplicancia_Mercado = 'MERCADO' then
        dFecha_Aux := dFecha_Inicial + 1
     else
        dFecha_Aux := dFecha_Inicial;

     if NOT Reg_Parametros.bSolo_Stock then
     begin
       // Comienzo Transaccion

        if (sDriver = 'ORACLE') and
           (NOT dmBaseDatos.Database_General.InTransaction) then
            dmBaseDatos.Database_General.StartTransaction;

        Mostrar_Mensaje( 'Verificando valorizaciones anteriores de carteras (2) ...', bAbortar);
        close;

        bExiste_Tabla_Cta_Cte := True;
        try
          SQL.Clear;
          SQL.Add('SELECT Count(*) As Num_Regs FROM QS_TES_CTACTE'
                 +' WHERE Fecha_Movimiento = :Fecha_Cierre'
                 );
          Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
          Open;
        except
           bExiste_Tabla_Cta_Cte := False;
        end;
        Close;

        if bExiste_Tabla_Cta_Cte then
        begin
           Sql.Clear;
           Sql.Add( 'SELECT a.Empresa'
                  +'       ,a.Folio_Interno_Omd'
                  +'       ,a.Item_Omd'
                  +'       ,a.Transaccion_Omd'
                  +'       ,a.Fecha_Mov'
                  +'       ,a.Nro_Cupon'
                  +' FROM QS_TES_EGRING      a'
                  +'     ,Qs_Temp_Omd_Det_Rf b'
                  +' WHERE a.Folio_Interno_Omd = b.Folio_Interno'
                  +'   AND a.Item_Omd          = b.Item_omd'
                  +'   AND a.Transaccion_Omd   = b.Transaccion'
                  +'   AND a.Empresa           = b.Empresa'
                  +'   AND b.Pid               = :Pid '
                  +'   AND a.Fecha_Pago        = a.Fecha_Mov');
           if not (transaccion_implica_mem(sEmpresa_Usuario,'MOVTO_CAJA')) then   // E.S. 22-05-2013, para que pueda eliminar los reg. en Rimac
              Sql.Add('   AND ((a.MONTO_UM_PAGADO = a.MONTO_UM_MOVIMIENTO) OR (a.MONTO_UM_PAGADO = 0))') //ggarcia 01-08-2013 se debe considerar cuando esta en 0 tambien
           else
              Sql.Add('   AND a.MONTO_UM_PAGADO   = 0');
           Sql.Add('   AND (a.Cuenta_Banco IS NULL OR a.Cuenta_Banco = '''') '    //ggarcia 30-06-2010
                  +'   AND a.Transaccion       = :Transaccion ');
           SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
           SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
           SQL.Add('                     WHERE proceso   = :proceso                       ');
           SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
           if bAnticipos_Pactos then
           begin
             // No lo valoriza si esta prepagado (G.G. 27-12-2010)
             SQL.Add('   AND a.folio_interno_omd NOT IN (SELECT g.FOLIO_INTERNO_REL                   ');
             SQL.Add('                                     FROM QS_TRA_OMD_PREPAGO_PACTO g            ');
             SQL.Add('                                    WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno_Omd ');
             SQL.Add('                                      AND g.Transaccion_Rel   = a.Transaccion_Omd   ');
             SQL.Add('                                      AND g.Empresa_Rel       = a.Empresa       ');
             SQL.Add('                                      AND g.Fecha_Prepago    <= :Fecha_Mov      ');
             SQL.Add('                                      AND g.folio_interno NOT IN (SELECT e.folio                         ');
             SQL.Add('                                                                    FROM qs_ctr_anulacion e              ');
             SQL.Add('                                                                   WHERE e.folio       = g.folio_interno ');
             SQL.Add('                                                                     AND e.transaccion = g.transaccion   ');
             SQL.Add('                                                                     AND e.empresa     = g.empresa))     ');
             Parambyname('Fecha_Mov').asDatetime := dFecha_Inicial;
           end;
           if sImplicancia_Mercado = 'MERCADO' then
           begin
              Sql.Add(' AND a.Fecha_Mov BETWEEN :Fecha_Inicial AND :Fecha_Final' );
              Parambyname('Fecha_Inicial').asDatetime   := dFecha_Inicial;
              Parambyname('Fecha_Final').asDatetime     := dFecha_Inicial + 1;
           end
           else
           begin
              Sql.Add(' AND a.Fecha_Mov = :Fecha_Mov' );
              Parambyname('Fecha_Mov').asDatetime   := dFecha_Inicial;
           end;
           if Reg_Parametros.bCarteras then
              Sql.Add( ' AND b.cartera in ' + sString_Carteras );

           if Reg_Parametros.bEmisores then
              Sql.Add( ' AND b.Emisor in ' + sString_Emisores  );

           if Reg_Parametros.bInstrumentos then
              Sql.Add( ' AND b.Instrumento in ' + sString_Instrumentos );

           if Reg_Parametros.bSerie then
           begin
             Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                     +' WHERE z.Parametro = ''STK_SERIE'''
                                     +'   AND z.Proceso   = :Proceso'
                                     +' )' );
             Parambyname('Proceso').asString := IntToStr(Application.Handle);
           end;

           if Reg_Parametros.bNemotecnico then
           begin
             Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                           +' WHERE w.Parametro = ''STK_NEMOS'''
                                           +'   AND w.Proceso   = :Proceso'
                                           +' )' );
             Parambyname('Proceso').asString := IntToStr(Application.Handle);
           end;

           if Reg_Parametros.bFolios then
           begin
             if sDriver = 'MSSQL' then
                Sql.Add( ' AND convert(Integer,b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
             else
                Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');

             Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
             Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
           end;

           if Reg_Parametros.bExcepcion then
           begin
             Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                            +'   where u.id = :id )');
             Parambyname('id').AsFloat := Application.Handle;
           end;

           if Reg_Parametros.bSolo_Var then
           begin
               Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                        +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                        +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                        +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                        +'   AND x.Var_Periodo   = :Periodo '
                                        +'   AND x.Var_1010411   = b.Empresa '
                                    +' )' );
               Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
           end;

           if (bforward)                         and
              (not Reg_Parametros.bEmisores)     and
              (not Reg_Parametros.bInstrumentos) and
              (not Reg_Parametros.bSerie)        and
              (not Reg_Parametros.bNemotecnico)  and
               not ((Reg_Parametros.bInstrumentos) and (not BuscaStr(sString_Instrumentos,'''FWD'''))) then
           begin
              Sql.Add( ' UNION ' );
              Sql.Add( 'SELECT a.Empresa'
                     +'       ,a.Folio_Interno_Omd'
                     +'       ,a.Item_Omd'
                     +'       ,a.Transaccion_Omd'
                     +'       ,a.Fecha_Mov'
                     +'       ,a.Nro_Cupon'
                     +' FROM QS_TES_EGRING      a'
                     +' WHERE a.Fecha_Pago        = a.Fecha_Mov');
              if not (transaccion_implica_mem(sEmpresa_Usuario,'MOVTO_CAJA')) then   // E.S. 22-05-2013, para que pueda eliminar los reg. en Rimac
                 Sql.Add('   AND ((a.MONTO_UM_PAGADO = a.MONTO_UM_MOVIMIENTO) OR (a.MONTO_UM_PAGADO = 0))')  //ggarcia 01-08-2013 se debe considerar cuando esta en 0 tambien
              else
                 Sql.Add('   AND a.MONTO_UM_PAGADO   = 0');
              Sql.Add('   AND (a.Cuenta_Banco IS NULL OR a.Cuenta_Banco = '''') '    //ggarcia 30-06-2010
                     +'   AND a.Transaccion       = :Transaccion ');
              SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
              SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
              SQL.Add('                     WHERE proceso   = :proceso                       ');
              SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
              if bAnticipos_Pactos then
              begin
                // No lo valoriza si esta prepagado (G.G. 27-12-2010)
                SQL.Add('   AND a.folio_interno_omd NOT IN (SELECT g.FOLIO_INTERNO_REL                   ');
                SQL.Add('                                     FROM QS_TRA_OMD_PREPAGO_PACTO g            ');
                SQL.Add('                                    WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno_Omd ');
                SQL.Add('                                      AND g.Transaccion_Rel   = a.Transaccion_Omd   ');
                SQL.Add('                                      AND g.Empresa_Rel       = a.Empresa       ');
                SQL.Add('                                      AND g.Fecha_Prepago    <= :Fecha_Mov      ');
                SQL.Add('                                      AND g.folio_interno NOT IN (SELECT e.folio                         ');
                SQL.Add('                                                                    FROM qs_ctr_anulacion e              ');
                SQL.Add('                                                                   WHERE e.folio       = g.folio_interno ');
                SQL.Add('                                                                     AND e.transaccion = g.transaccion   ');
                SQL.Add('                                                                     AND e.empresa     = g.empresa))     ');
                Parambyname('Fecha_Mov').asDatetime := dFecha_Inicial;
              end;
              if sImplicancia_Mercado = 'MERCADO' then
              begin
                 Sql.Add(' AND a.Fecha_Mov BETWEEN :Fecha_Inicial AND :Fecha_Final' );
                 Parambyname('Fecha_Inicial').asDatetime   := dFecha_Inicial;
                 Parambyname('Fecha_Final').asDatetime     := dFecha_Inicial + 1;
              end
              else
              begin
                 Sql.Add(' AND a.Fecha_Mov = :Fecha_Mov' );
                 Parambyname('Fecha_Mov').asDatetime   := dFecha_Inicial;
              end;
              if Reg_Parametros.bCarteras then
                 Sql.Add( ' AND a.cartera in ' + sString_Carteras );

              if Reg_Parametros.bSolo_Var then
              begin
                  Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                           +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                           +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                           +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                           +'   AND x.Var_Periodo   = :Periodo '
                                           +'   AND x.Var_1010411   = b.Empresa '
                                       +' )' );
                  Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
              end;
           end;   //if bforward then

           Parambyname('Transaccion' ).AsString  := 'VCTO';
           Parambyname('Proceso').asString       := IntToStr(Application.Handle);
           Parambyname('Pid').AsFloat := Application.Handle;
           Open;

           Mostrar_Mensaje( 'Cargando Movimientos Cuenta Corriente', bAbortar);
           Carga_Registros_en_CtaCte_Mem( dFecha_Inicial
                                         ,dFecha_Inicial + 1
                                        );

           // Ahora Borro Folios Encontrados
           Mostrar_Mensaje( 'Eliminando Movimientos anteriores de tesoreria ...', bAbortar);
           While Not Eof do
           begin
              if Existe_Registro_en_CtaCte_Mem( QRY_General.Fieldbyname('Empresa').asString
                                               ,QRY_General.Fieldbyname('Transaccion_Omd').asString
                                               ,QRY_General.Fieldbyname('Folio_Interno_Omd').asString
                                               ,QRY_General.Fieldbyname('Nro_Cupon').asFloat) then
              begin
                Next;
                Continue;
              end;

              QRY_General2.Close;
              QRY_General2.Sql.Clear;
              QRY_General2.Sql.Add('DELETE FROM QS_TES_EGRING'
                                  +' WHERE Folio_Interno_OMD = :Folio_Interno'
                                  +'   AND Item_Omd          = :Item_omd'
                                  +'   AND Transaccion_OMD   = :Transaccion'
                                  +'   AND Empresa           = :Empresa'
                                  +'   AND Fecha_mov         = :Fecha_Cierre'
                                  );
              QRY_General2.Parambyname('Empresa').asString       := QRY_General.Fieldbyname('Empresa').asString;
              QRY_General2.Parambyname('Folio_Interno').asString := QRY_General.Fieldbyname('Folio_Interno_Omd').asString;
              QRY_General2.Parambyname('Item_Omd').asFloat       := QRY_General.Fieldbyname('Item_Omd').asFloat;
              QRY_General2.Parambyname('Transaccion').asString   := QRY_General.Fieldbyname('Transaccion_Omd').asString;
              QRY_General2.Parambyname('Fecha_Cierre').asDatetime:= QRY_General.Fieldbyname('Fecha_Mov').asDatetime;
              try
                QRY_General2.ExecSql;
              except on E: EDBEngineError do
                begin
                  ShowError_SQL(E
                               ,QRY_General2.Sql
                               ,'Parametros : '+#10
                               +'Empresa           = '+QRY_General.Fieldbyname('Empresa'          ).asString + #10
                               +'Folio_Interno     = '+QRY_General.Fieldbyname('Folio_Interno_Omd').asString + #10
                               +'Item_Omd          = '+FloatTostr(QRY_General.Fieldbyname('Item_Omd').asFloat) + #10
                               +'Transaccion       = '+QRY_General.Fieldbyname('Transaccion_Omd').asString + #10
                               +'Fecha_Cierre      = '+DateToStr(QRY_General.Fieldbyname('Fecha_Mov').asDatetime)
                               );
                  QRY_General2.Close;
                  qry_general.Close;
                  bAbortar := True;
                  try
                  if NOT Reg_Parametros.bSolo_Stock then
                  begin
                     DMValorizacion.Tmp_Res_Mercado.Close;
                     DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                     DMValorizacion.Tmp_Res_Mercado_CC.Close;
                     DMValorizacion.Tmp_RES_PROVISION.Close;
                     if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                        DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                  end;
                  DMValorizacion.Tmp_Stock.Close;
                  DMValorizacion.Tmp_Res_Proceso.Close;
                  except
                  end;
                  Exit;
                end;
              end;
              QRY_General2.Close;
              Application.ProcessMessages;
              Next;
           end;
           Close;
        end
        else
        begin
           Sql.Clear;
           Sql.Add('DELETE FROM QS_TES_EGRING' );
           Sql.Add(' WHERE Transaccion = ''VCTO''' );
           Sql.Add('   AND Fecha_Pago  = Fecha_Mov' );
           if not (transaccion_implica_mem(sEmpresa_Usuario,'MOVTO_CAJA')) then   // E.S. 22-05-2013, para que pueda eliminar los reg. en Rimac
              Sql.Add('   AND ((MONTO_UM_PAGADO = MONTO_UM_MOVIMIENTO) OR (MONTO_UM_PAGADO = 0))' )  //ggarcia 01-08-2013 se debe considerar cuando esta en 0 tambien
           else
              Sql.Add('   AND MONTO_UM_PAGADO = 0' );
           Sql.Add('   AND (Cuenta_Banco IS NULL or Cuenta_Banco = '''') ');    //ggarcia 30-06-2010
           SQL.Add('   AND EXISTS (SELECT Distinct valor As Empresa  ');
           SQL.Add('                 FROM QS_SYS_PARAM_PROCESO   ');
           SQL.Add('                WHERE QS_SYS_PARAM_PROCESO.proceso   = :proceso    ');
           SQL.Add('                  AND QS_SYS_PARAM_PROCESO.parametro = ''EMPRESA''');
           SQL.Add('                  AND QS_SYS_PARAM_PROCESO.valor     = QS_TES_EGRING.Empresa )' );
           if bAnticipos_Pactos then
           begin
             // No lo valoriza si esta prepagado (G.G. 27-12-2010)
             SQL.Add('   AND folio_interno_omd NOT IN (SELECT FOLIO_INTERNO_REL                   ');
             SQL.Add('                                   FROM QS_TRA_OMD_PREPAGO_PACTO            ');
             SQL.Add('                                  WHERE QS_TRA_OMD_PREPAGO_PACTO.FOLIO_INTERNO_REL = QS_TES_EGRING.Folio_Interno_omd ');
             SQL.Add('                                    AND QS_TRA_OMD_PREPAGO_PACTO.Transaccion_Rel   = QS_TES_EGRING.Transaccion_omd   ');
             SQL.Add('                                    AND QS_TRA_OMD_PREPAGO_PACTO.Empresa_Rel       = QS_TES_EGRING.Empresa       ');
             SQL.Add('                                    AND QS_TRA_OMD_PREPAGO_PACTO.Fecha_Prepago    <= :Fecha_Mov          ');
             SQL.Add('                                    AND QS_TRA_OMD_PREPAGO_PACTO.folio_interno NOT IN (SELECT folio                         ');
             SQL.Add('                                                                                         FROM qs_ctr_anulacion              ');
             SQL.Add('                                                                                        WHERE qs_ctr_anulacion.folio       = QS_TRA_OMD_PREPAGO_PACTO.folio_interno ');
             SQL.Add('                                                                                          AND qs_ctr_anulacion.transaccion = QS_TRA_OMD_PREPAGO_PACTO.transaccion   ');
             SQL.Add('                                                                                          AND qs_ctr_anulacion.empresa     = QS_TRA_OMD_PREPAGO_PACTO.empresa))     ');
             Parambyname('Fecha_Mov').asDatetime := dFecha_Inicial;
           end;
           if sImplicancia_Mercado = 'MERCADO' then
           begin
              Sql.Add(' AND Fecha_Mov BETWEEN :Fecha_Inicial AND :Fecha_Final' );
              Parambyname('Fecha_Inicial').asDatetime   := dFecha_Inicial;
              Parambyname('Fecha_Final').asDatetime     := dFecha_Inicial + 1;
           end
           else
           begin
              Sql.Add(' AND Fecha_Mov = :Fecha_Mov' );
              Parambyname('Fecha_Mov').asDatetime   := dFecha_Inicial;
           end;

           if Reg_Parametros.bCarteras then
           begin
              Sql.Add( ' AND EXISTS ( SELECT Cartera FROM QS_SYS_PARAM_EMPRESA '
                                     +' WHERE QS_SYS_PARAM_EMPRESA.Empresa = QS_TES_EGRING.empresa'
                                     +'   AND QS_SYS_PARAM_EMPRESA.Cartera = QS_TES_EGRING.Cartera'  //ggarcia 26/4/2007 , borraba todas las carteras
                                     +'   AND QS_SYS_PARAM_EMPRESA.Pid     = :Pid'
                                     +' )' );
              Parambyname('Pid').asFloat := Application.Handle;
           end;

           if Reg_Parametros.bEmisores then
           begin
              Sql.Add( ' AND EXISTS ( SELECT Emisor FROM Qs_Tra_Omd_Det_Rf '
                                        +' WHERE QS_TES_EGRING.Empresa           = Qs_Tra_Omd_Det_Rf.Empresa '
                                        +'   AND QS_TES_EGRING.Transaccion_OMD   = Qs_Tra_Omd_Det_Rf.Transaccion '
                                        +'   AND QS_TES_EGRING.Folio_Interno_OMD = Qs_Tra_Omd_Det_Rf.Folio_Interno '
                                        +'   AND QS_TES_EGRING.Item_OMD          = Qs_Tra_Omd_Det_Rf.Item_OMD '
                                        +'   AND Qs_Tra_Omd_Det_Rf.Emisor IN ( SELECT Valor FROM QS_SYS_PARAM_PROCESO '
                                                                             +' WHERE Parametro = ''STK_EMISOR'''
                                                                             +'   AND Proceso   = :Proceso'
                                                                             +' )'
                                    +' )'
                                  );
               Parambyname('Proceso').asString := IntToStr(Application.Handle);
           end;

           if Reg_Parametros.bInstrumentos then
           begin
              Sql.Add( ' AND EXISTS ( SELECT Instrumento FROM Qs_Tra_Omd_Det_Rf '
                                        +' WHERE QS_TES_EGRING.Empresa           = Qs_Tra_Omd_Det_Rf.Empresa '
                                        +'   AND QS_TES_EGRING.Transaccion_OMD   = Qs_Tra_Omd_Det_Rf.Transaccion '
                                        +'   AND QS_TES_EGRING.Folio_Interno_OMD = Qs_Tra_Omd_Det_Rf.Folio_Interno '
                                        +'   AND QS_TES_EGRING.Item_OMD          = Qs_Tra_Omd_Det_Rf.Item_OMD '
                                        +'   AND Qs_Tra_Omd_Det_Rf.Instrumento IN ( SELECT Valor FROM QS_SYS_PARAM_PROCESO '
                                                                                  +' WHERE Parametro = ''STK_INST'''
                                                                                  +'   AND Proceso   = :Proceso'
                                                                                  +' )'
                                       +' )'
                      );
               Parambyname('Proceso').asString := IntToStr(Application.Handle);
           end;
           if Reg_Parametros.bSerie then
           begin
              Sql.Add( ' AND EXISTS ( SELECT Serie FROM Qs_Tra_Omd_Det_Rf '
                                        +' WHERE QS_TES_EGRING.Empresa           = Qs_Tra_Omd_Det_Rf.Empresa '
                                        +'   AND QS_TES_EGRING.Transaccion_OMD   = Qs_Tra_Omd_Det_Rf.Transaccion '
                                        +'   AND QS_TES_EGRING.Folio_Interno_OMD = Qs_Tra_Omd_Det_Rf.Folio_Interno '
                                        +'   AND QS_TES_EGRING.Item_OMD          = Qs_Tra_Omd_Det_Rf.Item_OMD '
                                        +'   AND Qs_Tra_Omd_Det_Rf.Serie IN ( SELECT Valor FROM QS_SYS_PARAM_PROCESO '
                                                                            +' WHERE Parametro = ''STK_SERIE'''
                                                                            +'   AND Proceso   = :Proceso'
                                                                            +' )'
                                    +' )'
                       );
             Parambyname('Proceso').asString := IntToStr(Application.Handle);
           end;

           if Reg_Parametros.bNemotecnico then
           begin
              Sql.Add( ' AND EXISTS ( SELECT Nemotecnico FROM Qs_Tra_Omd_Det_Rf '
                                        +' WHERE QS_TES_EGRING.Empresa           = Qs_Tra_Omd_Det_Rf.Empresa '
                                        +'   AND QS_TES_EGRING.Transaccion_OMD   = Qs_Tra_Omd_Det_Rf.Transaccion '
                                        +'   AND QS_TES_EGRING.Folio_Interno_OMD = Qs_Tra_Omd_Det_Rf.Folio_Interno '
                                        +'   AND QS_TES_EGRING.Item_OMD          = Qs_Tra_Omd_Det_Rf.Item_OMD '
                                        +'   AND Qs_Tra_Omd_Det_Rf.Nemotecnico IN ( SELECT Valor FROM QS_SYS_PARAM_PROCESO '
                                                                                  +' WHERE Parametro = ''STK_NEMOS'''
                                                                                  +'   AND Proceso   = :Proceso'
                                                                                  +' )'
                                       +' )'
                                       );
             Parambyname('Proceso').asString := IntToStr(Application.Handle);
           end;

           if Reg_Parametros.bFolios then
           begin
              if sDriver = 'MSSQL' then
                 Sql.Add( ' AND convert(Integer, Folio_Interno_OMD) between :Folio_desde and :Folio_hasta ')
              else
                 Sql.Add( ' AND TO_NUMBER(Folio_Interno_OMD) between :Folio_desde and :Folio_hasta ');

              Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
              Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
           end;

           if Reg_Parametros.bExcepcion then
           begin
               Sql.Add( ' AND Folio_Interno_OMD in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                              +'   where u.id = :id )');
               Parambyname('id').AsFloat := Application.Handle;
           end;
           Parambyname('Proceso').asString       := IntToStr(Application.Handle);

           try
               ExecSql;
           except on E: EDBEngineError do
              begin
                ShowError_SQL(E
                             ,QRY_General.Sql
                             ,'Parametros : '+#10
                             +'Empresa           = '+QRY_General.Fieldbyname('Empresa'          ).asString + #10
                             +'Folio_Interno     = '+QRY_General.Fieldbyname('Folio_Interno_Omd').asString + #10
                             +'Item_Omd          = '+FloatTostr(QRY_General.Fieldbyname('Item_Omd').asFloat) + #10
                             +'Transaccion       = '+QRY_General.Fieldbyname('Transaccion_Omd').asString + #10
                             +'Fecha_Cierre      = '+DateToStr(QRY_General.Fieldbyname('Fecha_Mov').asDatetime)
                             );
                Close;
                qry_general.Close;
                bAbortar := True;
                try
                if NOT Reg_Parametros.bSolo_Stock then
                begin
                   DMValorizacion.Tmp_Res_Mercado.Close;
                   DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                   DMValorizacion.Tmp_Res_Mercado_CC.Close;
                   DMValorizacion.Tmp_RES_PROVISION.Close;
                   if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                      DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                end;
                DMValorizacion.Tmp_Stock.Close;
                DMValorizacion.Tmp_Res_Proceso.Close;
                except
                end;
                Exit;
              end;
           end;
           Application.ProcessMessages;
          Close;
        end;
       end;{if solo stock}

       Mostrar_Mensaje('Cargando Movimientos Impagos ...', bAbortar);
       if NOT bAbortar then
       begin
           if sImplicancia_Mercado = 'MERCADO' then
              Carga_Folios_Tesoreria_Impagos_Mem(  dFecha_Inicial
                                                  ,dFecha_Final + 1
                                                )
           else
              Carga_Folios_Tesoreria_Impagos_Mem(  dFecha_Inicial
                                                  ,dFecha_Final
                                                );
       end;

       // Nueva consistencia
       // Determina operaciones que no han sido confirmadas
       sParametro_Consistencia := '';
       Busca_param_proceso('VALORIZA'
                          ,'CONSIST'
                          ,sParametro_Consistencia
                          ,Result);

       if (sParametro_Consistencia = 'OPERACION SIN CERRAR') then
       begin
         Close;
         Mostrar_Mensaje( 'Chequeando Operaciones sin confirmar ...', bAbortar);
         SQL.Clear;
         SQL.Add('SELECT TRANSACCION                                            ');
         SQL.Add('      ,FOLIO_INTERNO                                          ');
         SQL.Add('      ,EMPRESA                                          ');
         SQL.Add('      ,CARTERA                                          ');
         SQL.Add('      ,FECHA_DE_PAGO                                          ');
         SQL.Add('  FROM QS_TRA_OMD a                                           ');
         SQL.Add(' WHERE (FOLIO_PREIMPRESO IS NULL OR FOLIO_PREIMPRESO = '' '') ');
         SQL.Add('   AND FECHA_DE_PAGO <= :Fecha                                ');
         SQL.Add('   AND TRANSACCION IN (SELECT b.CODIGO_TRANSACCION            ');
         SQL.Add('      		   FROM QS_SYS_TRAN_IMPLIC b            ');
         SQL.Add('      		  WHERE b.IMPLICANCIA = ''COMPRA'')     ');
         SQL.Add('   AND TRANSACCION NOT IN (SELECT c.CODIGO_TRANSACCION        ');
         SQL.Add('      		       FROM QS_SYS_TRAN_IMPLIC c        ');
         SQL.Add('      		      WHERE c.IMPLICANCIA = ''RV'')     ');
         SQL.Add('  AND a.folio_interno not in (SELECT e.folio                         ');
         SQL.Add('				 FROM qs_ctr_anulacion e               ');
         SQL.Add('				WHERE e.folio       = a.folio_interno  ');
         SQL.Add('				  AND e.transaccion = a.transaccion    ');
         SQL.Add('  				  AND e.empresa     = a.empresa)       ');
         SQL.Add(' AND a.Empresa IN '+sString_Empresas                           );
         if Reg_Parametros.bCarteras then
            SQL.Add(' AND a.Cartera IN '+sString_Carteras                           );
         SQL.Add(' ORDER BY FOLIO_INTERNO DESC                                  ');

         ParamByName('Fecha'  ).AsDateTime := dFecha_Inicial;

         Open;
         WHILE NOT EOF do
         begin
           sMensaje  := ' Folio: ' + FieldByName('Folio_Interno').AsString
                       +' con fecha de pago: ' + FormatDateTime('dd/mm/yyyy',FieldByName('FECHA_DE_PAGO').AsDateTime)
                       +' sin confirmar';

            Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                      sProceso,
                                      dFecha_Inicial,
                                      sLogin_Sistema,
                                      sMensaje,
                                      'Consistencia',
                                      'Operación Sin Cerrar'
                                      ,'99'
                                      );
            Next;
         end;


       end;

       if (sDriver = 'ORACLE') and
          (dmBaseDatos.Database_General.InTransaction) then
          dmBaseDatos.Database_General.Commit;

     end;{with qry_general}


     if (sDriver = 'ORACLE') and
        (NOT dmBaseDatos.Database_General.InTransaction) then
        dmBaseDatos.Database_General.StartTransaction;



     with DMValorizacion,QRY_General do
     begin
         Mostrar_Mensaje( 'Seleccionando Registros OMD''s ...', bAbortar);
         // Instrumentos con Descriptor SIN PACTOS CON EMISION EXPLICITA (NO IMPLICITA)
         SQL.Clear;
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor        ');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                   );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia in (''COMPRA'',''DERIVADO'') )');
         SQL.Add('   AND a.transaccion NOT IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');

         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and a.folio_preimpreso <> '' ''');
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
         SQL.Add('   AND b.Tipo_Instrum       <> ''R''' );
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
         SQL.Add('   AND (c.Emision_Implicita IS NULL OR Emision_Implicita <> ''S'') ');
         SQL.Add('   AND c.Fecha_Vencimiento  >= :Fecha');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         if bAnticipos_Pactos then
         begin
           // No lo valoriza si esta en la tabla de anticipo SOLO DERIVADOS (G.G. 23-06-2011)
           SQL.Add('   AND a.folio_interno NOT IN (SELECT g.FOLIO_INTERNO_REL                   ');
           SQL.Add('                                 FROM QS_TRA_OMD_PREPAGO_PACTO g            ');
           SQL.Add('                                WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno ');
           SQL.Add('                                  AND g.Transaccion_Rel   = a.Transaccion   ');
           SQL.Add('                                  AND g.Empresa_Rel       = a.Empresa       ');
           SQL.Add('                                  AND g.Fecha_Prepago    <= :Fecha          ');
           SQL.Add('                                  AND g.folio_interno NOT IN (SELECT e.folio                         ');
           SQL.Add('                                                                FROM qs_ctr_anulacion e              ');
           SQL.Add('                                                               WHERE e.folio       = g.folio_interno ');
           SQL.Add('                                                                 AND e.transaccion = g.transaccion   ');
           SQL.Add('                                                                 AND e.empresa     = g.empresa))     ');
         end;
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );

         if Reg_Parametros.bFolios then
         begin
             if sDriver = 'MSSQL' then
                Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
             else
                Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         SQL.Add(' UNION ');
         // Instrumentos sin descriptor SIN PACTOS
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,b.Emisor'                           );
         SQL.Add('      ,b.Instrumento'                      );
         SQL.Add('      ,b.Serie as Serie'                   );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,b.Fecha_Emision as Fecha_Vig'       );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,b.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,b.Tasa_Emision'                     );
         SQL.Add('      ,b.Fecha_Emision'                    );
         SQL.Add('      ,b.Fecha_Vencimiento'                );
         SQL.Add('      ,b.Moneda_Instrum'                   );
         SQL.Add('      ,b.Tipo_Nominales'                   );
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
         begin
            SQL.Add('      ,h.Tip_Tas_Valor_PAR   As Tasa_Base_Par');
            SQL.Add('      ,h.Tip_Tas_Valor_PTE   As Tasa_Base_Pte');
         end
         else
         begin
            SQL.Add('      ,b.Tasa_Base_Par   As Tasa_Base_Par');
            SQL.Add('      ,b.Tasa_Base_Tir   As Tasa_Base_Pte');
         end;
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,h.COD_CALC_PTE_INS As Formula_Pte'  );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
         SQL.Add('                           FROM qs_sys_tran_implic d');
         SQL.Add('                          WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia in (''COMPRA'',''DERIVADO'') )');
         SQL.Add('   AND a.transaccion NOT IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');

         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
         SQL.Add('                                 FROM qs_ctr_anulacion e');
         SQL.Add('                                WHERE e.folio   = a.folio_interno');
         SQL.Add('                                  AND e.empresa = a.empresa');
         SQL.Add('                                  AND e.transaccion = a.transaccion)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and a.folio_preimpreso <> '' ''');
         SQL.Add('   and a.Folio_Interno     = b.Folio_Interno');
         SQL.Add('   AND b.Tipo_Instrum     <> ''S''' );
         SQL.Add('   AND b.Tipo_Instrum     <> ''R''' );
         SQL.Add('   and a.Transaccion       = b.Transaccion');
         SQL.Add('   and a.Empresa           = b.Empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         if bAnticipos_Pactos then
         begin
           // No lo valoriza si esta en la tabla de anticipo SOLO DERIVADOS (G.G. 23-06-2011)
           SQL.Add('   AND a.folio_interno NOT IN (SELECT g.FOLIO_INTERNO_REL                   ');
           SQL.Add('                                 FROM QS_TRA_OMD_PREPAGO_PACTO g            ');
           SQL.Add('                                WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno ');
           SQL.Add('                                  AND g.Transaccion_Rel   = a.Transaccion   ');
           SQL.Add('                                  AND g.Empresa_Rel       = a.Empresa       ');
           SQL.Add('                                  AND g.Fecha_Prepago    <= :Fecha          ');
           SQL.Add('                                  AND g.folio_interno NOT IN (SELECT e.folio                         ');
           SQL.Add('                                                                FROM qs_ctr_anulacion e              ');
           SQL.Add('                                                               WHERE e.folio       = g.folio_interno ');
           SQL.Add('                                                                 AND e.transaccion = g.transaccion   ');
           SQL.Add('                                                                 AND e.empresa     = g.empresa))     ');
         end;
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
            SQL.Add('   AND b.Fecha_Vencimiento >= :Fecha');
         SQL.Add('   AND b.Instrumento       = h.Cod_Instrumento');
         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND b.Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );
         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         SQL.Add(' UNION ');
         // Instrumentos con Descriptor CON PACTO CON EMISION EXPLICITA (NO IMPLICITA)
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                            );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,b.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPRA'')');
         SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and a.folio_preimpreso <> '' ''');
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
         SQL.Add('   AND b.Tipo_Instrum       <> ''R''' );
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
         SQL.Add('   AND (c.Emision_Implicita IS NULL OR Emision_Implicita <> ''S'') ');
         SQL.Add('   AND c.Fecha_Vencimiento  >= :Fecha');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         SQL.Add('   AND a.Fecha_Vcto_Pacto   > :Fecha   ');
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );


         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                   +' WHERE z.Parametro = ''STK_SERIE'''
                                   +'   AND z.Proceso   = :Proceso'
                                   +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                         +' WHERE w.Parametro = ''STK_NEMOS'''
                                         +'   AND w.Proceso   = :Proceso'
                                         +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;
         SQL.Add(' UNION ');
         // Instrumentos sin descriptor  CON PACTOS
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,b.Emisor'                           );
         SQL.Add('      ,b.Instrumento'                      );
         SQL.Add('      ,b.Serie as Serie'                            );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,b.Fecha_Emision as Fecha_Vig'       );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                     );
         SQL.Add('      ,a.Tasa_Base_Pacto'                     );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,b.Tasa_Emision'                     );
         SQL.Add('      ,b.Fecha_Emision'                    );
         SQL.Add('      ,b.Fecha_Vencimiento'                );
         SQL.Add('      ,b.Moneda_Instrum'                   );
         SQL.Add('      ,b.Tipo_Nominales'                   );
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
         begin
            SQL.Add('      ,h.Tip_Tas_Valor_PAR   As Tasa_Base_Par');
            SQL.Add('      ,h.Tip_Tas_Valor_PTE   As Tasa_Base_Pte');
         end
         else
         begin
            SQL.Add('      ,b.Tasa_Base_Par   As Tasa_Base_Par');
            SQL.Add('      ,b.Tasa_Base_Tir   As Tasa_Base_Pte');
         end;
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,h.COD_CALC_PTE_INS As Formula_Pte'  );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
         SQL.Add('                           FROM qs_sys_tran_implic d');
         SQL.Add('                          WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPRA'')');
         SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
         SQL.Add('                                 FROM qs_ctr_anulacion e');
         SQL.Add('                                WHERE e.folio   = a.folio_interno');
         SQL.Add('                                  AND e.empresa = a.empresa');
         SQL.Add('                                  AND e.transaccion = a.transaccion)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and a.folio_preimpreso <> '' ''');
         SQL.Add('   and a.Folio_Interno     = b.Folio_Interno');
         SQL.Add('   AND b.Tipo_Instrum     <> ''S''' );
         SQL.Add('   AND b.Tipo_Instrum     <> ''R''' );
         SQL.Add('   and a.Transaccion       = b.Transaccion');
         SQL.Add('   and a.Empresa           = b.Empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
            SQL.Add('   AND b.Fecha_Vencimiento >= :Fecha');
         SQL.Add('   AND b.Instrumento       = h.Cod_Instrumento');
         SQL.Add('   AND a.Fecha_Vcto_Pacto > :Fecha');

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND b.Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );
         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
           Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         // Instrumentos con Descriptor SIN PACTOS CON EMISION IMPLICITA
         SQL.Add(' UNION ');
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                   );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,c.Emision_Implicita'                  );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia in (''COMPRA'',''DERIVADO'') )');
         SQL.Add('   AND a.transaccion NOT IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');

         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and a.folio_preimpreso <> '' ''');
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
         SQL.Add('   AND b.Tipo_Instrum       <> ''R''' );
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
         SQL.Add('   AND c.Emision_Implicita = ''S'' ');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         if bAnticipos_Pactos then
         begin
           // No lo valoriza si esta en la tabla de anticipo SOLO DERIVADOS (G.G. 23-06-2011)
           SQL.Add('   AND a.folio_interno NOT IN (SELECT g.FOLIO_INTERNO_REL                   ');
           SQL.Add('                                 FROM QS_TRA_OMD_PREPAGO_PACTO g            ');
           SQL.Add('                                WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno ');
           SQL.Add('                                  AND g.Transaccion_Rel   = a.Transaccion   ');
           SQL.Add('                                  AND g.Empresa_Rel       = a.Empresa       ');
           SQL.Add('                                  AND g.Fecha_Prepago    <= :Fecha          ');
           SQL.Add('                                  AND g.folio_interno NOT IN (SELECT e.folio                         ');
           SQL.Add('                                                                FROM qs_ctr_anulacion e              ');
           SQL.Add('                                                               WHERE e.folio       = g.folio_interno ');
           SQL.Add('                                                                 AND e.transaccion = g.transaccion   ');
           SQL.Add('                                                                 AND e.empresa     = g.empresa))     ');
         end;
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         SQL.Add(' UNION ');
         // Instrumentos con Descriptor CON PACTO CON EMISION IMPLICITA
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                            );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,c.Emision_Implicita'                );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPRA'')');
         SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and a.folio_preimpreso <> '' ''');
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
         SQL.Add('   AND b.Tipo_Instrum       <> ''R''' );
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico   ');
         SQL.Add('   AND c.Emision_Implicita  = ''S''                  ');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         SQL.Add('   AND a.Fecha_Vcto_Pacto   > :Fecha   ');
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         // Si Implicacia es MERCADO Valorizo las Ventas CON PACTO del día
         // (VALORIZO EL PACTO)
        // if sImplicancia_Mercado = 'MERCADO' then
        // begin
            SQL.Add( ' UNION ' );
            // Instrumentos con Descriptor VENTA CON PACTO
            SQL.Add('SELECT b.Empresa as Empresa'  );
            SQL.Add('      ,b.Transaccion'                      );
            SQL.Add('      ,b.Folio_Interno'                    );
            SQL.Add('      ,b.Item_Omd'                         );
            SQL.Add('      ,c.Codigo_Identidad As Emisor');
            SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
            SQL.Add('      ,c.Serie as Serie'                            );
            if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
               SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
            SQL.Add('      ,b.Nemotecnico'                      );
            SQL.Add('      ,b.Tipo_Instrum'                     );
            SQL.Add('      ,b.Valor_Nominal'                    );
            SQL.Add('      ,b.Tasa_Mercado'                     );
            SQL.Add('      ,a.Moneda_Pacto'                     );
            SQL.Add('      ,a.Tasa_pacto'                       );
            SQL.Add('      ,a.Tasa_Base_Pacto'                  );
            SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
            SQL.Add('      ,g.Tasa_Emision'                     );
            SQL.Add('      ,c.Fecha_Emision'                    );
            SQL.Add('      ,c.Fecha_Vencimiento'                );
            SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
            SQL.Add('      ,g.Tipo_Nominales'                   );
            SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
            SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
            SQL.Add('      ,b.Cartera'                          );
            SQL.Add('      ,a.Fecha_Operacion'                  );
            SQL.Add('      ,h.Tipo_Instrumento'                 );
            SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
            SQL.Add('      ,b.Custodia_Dest'    );
            SQL.Add('      ,''N'' As Emision_Implicita'         );
            SQL.Add('      ,b.Valor_Invertido_UM');
            SQL.Add('      ,b.Valor_Invertido_MC');
            SQL.Add('      ,b.Valor_Pactado_UM'                 );
            SQL.Add('      ,b.Valor_Pactado_MC'               );
            SQL.Add('      ,a.Owner'               );
            SQL.Add('      ,b.Cupones_Cortados'   );
            SQL.Add('      ,a.Fecha_de_Pago'   );
            SQL.Add('      ,b.Porcen_Valor_PAR'   );
            SQL.Add('      ,a.Moneda_Operacion'   );
            SQL.Add('      ,b.Tipo_Cambio'   );
            SQL.Add('      ,a.Contraparte'   );
            SQL.Add('      ,a.Contraparte_Dir'   );
            SQL.Add('  from Qs_Tra_Omd a');
            SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
            SQL.Add('     , qs_fin_nem_rfija c');
            SQL.Add('      ,Qs_Fin_Instrum h');
            SQL.Add('      ,Qs_Fin_Descriptor g');
            SQL.Add(' where a.fecha_operacion <= :Fecha');
            SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                   SQL.Add('    FROM qs_sys_tran_implic d');
                                   SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                   SQL.Add('     AND d.implicancia = ''VENTA'')');
            SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                       SQL.Add('    FROM qs_sys_tran_implic d');
                                       SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                       SQL.Add('     AND d.implicancia = ''PACTO'')');
            SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                           SQL.Add('  FROM qs_ctr_anulacion e');
                                           SQL.Add(' WHERE e.folio   = a.folio_interno');
                                           SQL.Add('   AND e.transaccion = a.transaccion');
                                           SQL.Add('   AND e.empresa = a.empresa)');
            SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
            SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
            SQL.Add('                     WHERE proceso   = :proceso                       ');
            SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
            SQL.Add('   and a.folio_preimpreso <> '' ''');
            SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
            SQL.Add('   and a.Transaccion        = b.Transaccion');
            SQL.Add('   AND a.Empresa            = b.empresa');
            SQL.Add('   AND b.Pid                = :proceso ');
            SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
            SQL.Add('   AND b.Tipo_Instrum       <> ''R''' );
            SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
            SQL.Add('   AND (c.Emision_Implicita IS NULL OR Emision_Implicita <> ''S'') ');
            SQL.Add('   AND c.Fecha_Vencimiento  >= :Fecha');
            SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
            SQL.Add('   AND c.Serie              = g.Serie');
            SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
            SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
            SQL.Add('   AND a.Fecha_Vcto_Pacto   > :Fecha   ');
            if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
            end;

            if Reg_Parametros.bCarteras then
               Sql.Add( ' AND b.cartera in ' + sString_Carteras );
            if Reg_Parametros.bEmisores then
               Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

            if Reg_Parametros.bInstrumentos then
               Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

            if Reg_Parametros.bSerie then
               Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                     +' WHERE z.Parametro = ''STK_SERIE'''
                                     +'   AND z.Proceso   = :Proceso'
                                     +' )' );

            if Reg_Parametros.bNemotecnico then
               Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                            +' WHERE w.Parametro = ''STK_NEMOS'''
                                            +'   AND w.Proceso   = :Proceso'
                                            +' )' );

            if Reg_Parametros.bFolios then
            begin
               if sDriver = 'MSSQL' then
                  Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
               else
                  Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
            end;

            if Reg_Parametros.bExcepcion then
               Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                            +'   where u.id = :id )');

            if Reg_Parametros.bSolo_Var then
            begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                     +' )' );
                Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
            end;

            SQL.Add(' UNION ');
            // Instrumentos sin descriptor  VENTA CON PACTO
            SQL.Add('SELECT b.Empresa as Empresa'  );
            SQL.Add('      ,b.Transaccion'                      );
            SQL.Add('      ,b.Folio_Interno'                    );
            SQL.Add('      ,b.Item_Omd'                         );
            SQL.Add('      ,b.Emisor'                           );
            SQL.Add('      ,b.Instrumento'                      );
            SQL.Add('      ,b.Serie as Serie'                            );
            if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
               SQL.Add('   ,b.Fecha_Emision as Fecha_Vig'       );
            SQL.Add('      ,b.Nemotecnico'                      );
            SQL.Add('      ,b.Tipo_Instrum'                     );
            SQL.Add('      ,b.Valor_Nominal'                    );
            SQL.Add('      ,b.Tasa_Mercado'                     );
            SQL.Add('      ,a.Moneda_Pacto'                     );
            SQL.Add('      ,a.Tasa_pacto'                     );
            SQL.Add('      ,a.Tasa_Base_Pacto'                     );
            SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
            SQL.Add('      ,b.Tasa_Emision'                     );
            SQL.Add('      ,b.Fecha_Emision'                    );
            SQL.Add('      ,b.Fecha_Vencimiento'                );
            SQL.Add('      ,b.Moneda_Instrum'                   );
            SQL.Add('      ,b.Tipo_Nominales'                   );
            if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
            begin
               SQL.Add('      ,h.Tip_Tas_Valor_PAR   As Tasa_Base_Par');
               SQL.Add('      ,h.Tip_Tas_Valor_PTE   As Tasa_Base_Pte');
            end
            else
            begin
               SQL.Add('      ,b.Tasa_Base_Par   As Tasa_Base_Par');
               SQL.Add('      ,b.Tasa_Base_Tir   As Tasa_Base_Pte');
            end;
            SQL.Add('      ,b.Cartera'                          );
            SQL.Add('      ,a.Fecha_Operacion'                  );
            SQL.Add('      ,h.Tipo_Instrumento'                 );
            SQL.Add('      ,h.COD_CALC_PTE_INS As Formula_Pte'  );
            SQL.Add('      ,b.Custodia_Dest'    );
            SQL.Add('      ,''N'' As Emision_Implicita'         );
            SQL.Add('      ,b.Valor_Invertido_UM');
            SQL.Add('      ,b.Valor_Invertido_MC');
            SQL.Add('      ,b.Valor_Pactado_UM'                 );
            SQL.Add('      ,b.Valor_Pactado_MC'               );
            SQL.Add('      ,a.Owner'               );
            SQL.Add('      ,b.Cupones_Cortados'   );
            SQL.Add('      ,a.Fecha_de_Pago'   );
            SQL.Add('      ,b.Porcen_Valor_PAR'   );
            SQL.Add('      ,a.Moneda_Operacion'   );
            SQL.Add('      ,b.Tipo_Cambio'   );
            SQL.Add('      ,a.Contraparte'   );
            SQL.Add('      ,a.Contraparte_Dir'   );
            SQL.Add('  from Qs_Tra_Omd a');
            SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
            SQL.Add('      ,Qs_Fin_Instrum h');
            SQL.Add(' where a.fecha_operacion <= :Fecha');
            SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
            SQL.Add('                           FROM qs_sys_tran_implic d');
            SQL.Add('                          WHERE d.Codigo_transaccion = a.transaccion');
            SQL.Add('                            AND d.implicancia = ''VENTA'')');
            SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                       SQL.Add('    FROM qs_sys_tran_implic d');
                                       SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                       SQL.Add('     AND d.implicancia = ''PACTO'')');
            SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
            SQL.Add('                                 FROM qs_ctr_anulacion e');
            SQL.Add('                                WHERE e.folio   = a.folio_interno');
            SQL.Add('                                  AND e.empresa = a.empresa');
            SQL.Add('                                  AND e.transaccion = a.transaccion)');
            SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
            SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
            SQL.Add('                     WHERE proceso   = :proceso                       ');
            SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
            SQL.Add('   and a.folio_preimpreso <> '' ''');
            SQL.Add('   and a.Folio_Interno     = b.Folio_Interno');
            SQL.Add('   AND b.Tipo_Instrum     <> ''S''' );
            SQL.Add('   AND b.Tipo_Instrum     <> ''R''' );
            SQL.Add('   and a.Transaccion       = b.Transaccion');
            SQL.Add('   and a.Empresa           = b.Empresa');
            SQL.Add('   AND b.Pid                = :proceso ');
            if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
               SQL.Add('   AND b.Fecha_Vencimiento >= :Fecha');
            SQL.Add('   AND b.Instrumento       = h.Cod_Instrumento');
            SQL.Add('   AND a.Fecha_Vcto_Pacto > :Fecha');
         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND b.Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

            if Reg_Parametros.bSerie then
               Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                     +' WHERE z.Parametro = ''STK_SERIE'''
                                     +'   AND z.Proceso   = :Proceso'
                                     +' )' );

            if Reg_Parametros.bNemotecnico then
               Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                           +' WHERE w.Parametro = ''STK_NEMOS'''
                                           +'   AND w.Proceso   = :Proceso'
                                           +' )' );

            if Reg_Parametros.bFolios then
            begin
               if sDriver = 'MSSQL' then
                  Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
               else
                  Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
            end;

            if Reg_Parametros.bExcepcion then
               Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                            +'   where u.id = :id )');

            if Reg_Parametros.bSolo_Var then
            begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                     +' )' );
                Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
            end;

         // OPERACIONES PENDIENTES
         // Instrumentos con Descriptor SIN PACTOS CON EMISION EXPLICITA (NO IMPLICITA)
         SQL.Add( 'UNION ' );
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor        ');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                   );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPC'')');
         SQL.Add('   AND a.transaccion NOT IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');

         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and (a.folio_preimpreso   = '' ''                                  ');
         SQL.Add('    OR  a.folio_preimpreso IS NULL)                                   ');
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
         //SQL.Add('   AND b.Tipo_Instrum       <> ''R''' ); LO ELIMINE YA QUE NO TENIA SENTIDO F.I. 23-09-2005
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
         SQL.Add('   AND (c.Emision_Implicita IS NULL OR Emision_Implicita <> ''S'') ');
         SQL.Add('   AND c.Fecha_Vencimiento  >= :Fecha');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         SQL.Add(' UNION ');
         // Instrumentos sin descriptor
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,b.Emisor'                           );
         SQL.Add('      ,b.Instrumento'                      );
         SQL.Add('      ,b.Serie as Serie'                   );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,b.Fecha_Emision as Fecha_Vig'       );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,b.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,b.Tasa_Emision'                     );
         SQL.Add('      ,b.Fecha_Emision'                    );
         SQL.Add('      ,b.Fecha_Vencimiento'                );
         SQL.Add('      ,b.Moneda_Instrum'                   );
         SQL.Add('      ,b.Tipo_Nominales'                   );
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
         begin
            SQL.Add('      ,h.Tip_Tas_Valor_PAR   As Tasa_Base_Par');
            SQL.Add('      ,h.Tip_Tas_Valor_PTE   As Tasa_Base_Pte');
         end
         else
         begin
            SQL.Add('      ,b.Tasa_Base_Par   As Tasa_Base_Par');
            SQL.Add('      ,b.Tasa_Base_Tir   As Tasa_Base_Pte');
         end;
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,h.COD_CALC_PTE_INS As Formula_Pte'  );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
         SQL.Add('                           FROM qs_sys_tran_implic d');
         SQL.Add('                          WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPC'')');
         SQL.Add('   AND a.transaccion NOT IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
         SQL.Add('                                 FROM qs_ctr_anulacion e');
         SQL.Add('                                WHERE e.folio   = a.folio_interno');
         SQL.Add('                                  AND e.empresa = a.empresa');
         SQL.Add('                                  AND e.transaccion = a.transaccion)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and (a.folio_preimpreso   = '' ''                                  ');
         SQL.Add('    OR  a.folio_preimpreso IS NULL)                                   '); // Faltaba el "IS NULL" para Oracle F.I. 23-09-2005
         SQL.Add('   and a.Folio_Interno     = b.Folio_Interno');
         SQL.Add('   AND b.Tipo_Instrum     <> ''S''' );
         SQL.Add('   AND b.Tipo_Instrum     <> ''R''' );
         SQL.Add('   and a.Transaccion       = b.Transaccion');
         SQL.Add('   and a.Empresa           = b.Empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
            SQL.Add('   AND b.Fecha_Vencimiento >= :Fecha');
         SQL.Add('   AND b.Instrumento       = h.Cod_Instrumento');
         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND b.Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );
         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         SQL.Add(' UNION ');
         // Instrumentos con Descriptor CON PACTO CON EMISION EXPLICITA (NO IMPLICITA)
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                            );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,b.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPC'')');
         SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and (a.folio_preimpreso   = '' ''                                  ');
         SQL.Add('    OR  a.folio_preimpreso IS NULL)                                   '); // Faltaba el "IS NULL" para Oracle F.I. 23-09-2005
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
        //  SQL.Add('   AND b.Tipo_Instrum       <> ''R''' ); No Tiene sentido
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
         SQL.Add('   AND (c.Emision_Implicita IS NULL OR Emision_Implicita <> ''S'') ');
         SQL.Add('   AND c.Fecha_Vencimiento  >= :Fecha');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         SQL.Add('   AND a.Fecha_Vcto_Pacto   > :Fecha   ');
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;
         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                   +' WHERE z.Parametro = ''STK_SERIE'''
                                   +'   AND z.Proceso   = :Proceso'
                                   +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                         +' WHERE w.Parametro = ''STK_NEMOS'''
                                         +'   AND w.Proceso   = :Proceso'
                                         +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         SQL.Add(' UNION ');
         // Instrumentos sin descriptor
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,b.Emisor'                           );
         SQL.Add('      ,b.Instrumento'                      );
         SQL.Add('      ,b.Serie as Serie'                            );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,b.Fecha_Emision as Fecha_Vig'       );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                     );
         SQL.Add('      ,a.Tasa_Base_Pacto'                     );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,b.Tasa_Emision'                     );
         SQL.Add('      ,b.Fecha_Emision'                    );
         SQL.Add('      ,b.Fecha_Vencimiento'                );
         SQL.Add('      ,b.Moneda_Instrum'                   );
         SQL.Add('      ,b.Tipo_Nominales'                   );
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
         begin
            SQL.Add('      ,h.Tip_Tas_Valor_PAR   As Tasa_Base_Par');
            SQL.Add('      ,h.Tip_Tas_Valor_PTE   As Tasa_Base_Pte');
         end
         else
         begin
            SQL.Add('      ,b.Tasa_Base_Par   As Tasa_Base_Par');
            SQL.Add('      ,b.Tasa_Base_Tir   As Tasa_Base_Pte');
         end;
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,h.COD_CALC_PTE_INS As Formula_Pte'  );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
         SQL.Add('                           FROM qs_sys_tran_implic d');
         SQL.Add('                          WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPC'')');
         SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
         SQL.Add('                                 FROM qs_ctr_anulacion e');
         SQL.Add('                                WHERE e.folio   = a.folio_interno');
         SQL.Add('                                  AND e.empresa = a.empresa');
         SQL.Add('                                  AND e.transaccion = a.transaccion)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and (a.folio_preimpreso   = '' ''                                  ');
         SQL.Add('    OR  a.folio_preimpreso IS NULL)                                   '); // Faltaba el "IS NULL" para Oracle F.I. 23-09-2005
         SQL.Add('   and a.Folio_Interno     = b.Folio_Interno');
         SQL.Add('   AND b.Tipo_Instrum     <> ''S''' );
         SQL.Add('   AND b.Tipo_Instrum     <> ''R''' );
         SQL.Add('   and a.Transaccion       = b.Transaccion');
         SQL.Add('   and a.Empresa           = b.Empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
            SQL.Add('   AND b.Fecha_Vencimiento >= :Fecha');
         SQL.Add('   AND b.Instrumento       = h.Cod_Instrumento');
         SQL.Add('   AND a.Fecha_Vcto_Pacto > :Fecha');
         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND b.Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );
         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
           Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;
         // Instrumentos con Descriptor SIN PACTOS CON EMISION IMPLICITA
         SQL.Add(' UNION ');
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                   );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,c.Emision_Implicita'                  );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPC'')');
         SQL.Add('   AND a.transaccion NOT IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');

         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and (a.folio_preimpreso   = '' ''                                  ');
         SQL.Add('    OR  a.folio_preimpreso IS NULL)                                   '); // Faltaba el "IS NULL" para Oracle F.I. 23-09-2005
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
         // SQL.Add('   AND b.Tipo_Instrum       <> ''R''' );
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
         SQL.Add('   AND c.Emision_Implicita = ''S'' ');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         SQL.Add(' UNION ');
         // Instrumentos con Descriptor CON PACTO CON EMISION IMPLICITA
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                            );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,g.Fecha_Vig as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,a.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,g.Tasa_Emision'                     );
         SQL.Add('      ,c.Fecha_Emision'                    );
         SQL.Add('      ,c.Fecha_Vencimiento'                );
         SQL.Add('      ,g.UNIDAD_MON As Moneda_Instrum'     );
         SQL.Add('      ,g.Tipo_Nominales'                   );
         SQL.Add('      ,g.Tasa_Valor_PAR  As Tasa_Base_Par');
         SQL.Add('      ,g.Tasa_Valor_PTE  As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,g.COD_CALC_TIR_D As Formula_Pte'    );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,c.Emision_Implicita'                );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rfija c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add('      ,Qs_Fin_Descriptor g');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPC'')');
         SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and (a.folio_preimpreso   = '' ''                                  ');
         SQL.Add('    OR  a.folio_preimpreso IS NULL)                                   '); // Faltaba el "IS NULL" para Oracle F.I. 23-09-2005
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''S''' );
         //SQL.Add('   AND b.Tipo_Instrum       <> ''R''' );
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico   ');
         SQL.Add('   AND c.Emision_Implicita  = ''S''                  ');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND c.Serie              = g.Serie');
         SQL.Add('   AND c.Codigo_Instrumento = g.Codigo_Instrumento');
         SQL.Add('   AND c.Codigo_Identidad   = g.Codigo_Emisor');
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
         begin
            if sDriver = 'ORACLE' then
            begin
               SQL.Add('   AND TRUNC(c.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_nem_rfija x');
               SQL.Add('                               WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND TRUNC(g.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))');
               SQL.Add('                                FROM qs_fin_descriptor x');
               SQL.Add('                               WHERE x.Serie              = g.Serie');
               SQL.Add('                                 AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                                 AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		                 AND x.Fecha_Vig         <= :Fecha)');
            end
            else
            begin
               SQL.Add('   AND CONVERT(CHAR(10),c.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_nem_rfija x');
               SQL.Add('                        WHERE x.Codigo_Nemotecnico = c.Codigo_Nemotecnico');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
               SQL.Add('   AND CONVERT(CHAR(10),g.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
               SQL.Add('                         FROM qs_fin_descriptor x');
               SQL.Add('                        WHERE x.Serie              = g.Serie');
               SQL.Add('                          AND x.Codigo_Instrumento = g.Codigo_Instrumento');
               SQL.Add('                          AND x.Codigo_Emisor      = g.Codigo_Emisor');
               SQL.Add('      		          AND x.Fecha_Vig         <= :Fecha)');
             end;
             SQL.Add('   AND g.Tasa_Valor_PAR    <> ''TIX''');
         end;
         SQL.Add('   AND a.Fecha_Vcto_Pacto   > :Fecha   ');
         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND g.Codigo_Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );

         if Reg_Parametros.bSerie then
            Sql.Add( ' AND b.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                  +' WHERE z.Parametro = ''STK_SERIE'''
                                  +'   AND z.Proceso   = :Proceso'
                                  +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                        +' WHERE w.Parametro = ''STK_NEMOS'''
                                        +'   AND w.Proceso   = :Proceso'
                                        +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
            Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
            Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;
         SQL.Add(' UNION ');
         // PACTOS DE RENTA VARIABLE
         SQL.Add('SELECT b.Empresa as Empresa'  );
         SQL.Add('      ,b.Transaccion'                      );
         SQL.Add('      ,b.Folio_Interno'                    );
         SQL.Add('      ,b.Item_Omd'                         );
         SQL.Add('      ,c.Codigo_Identidad As Emisor');
         SQL.Add('      ,c.Codigo_Instrumento As Instrumento');
         SQL.Add('      ,c.Serie as Serie'                            );
         if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
            SQL.Add('   ,b.Fecha_Emision as Fecha_Vig' );
         SQL.Add('      ,b.Nemotecnico'                      );
         SQL.Add('      ,b.Tipo_Instrum'                     );
         SQL.Add('      ,b.Valor_Nominal'                    );
         SQL.Add('      ,b.Tasa_Mercado'                     );
         SQL.Add('      ,b.Moneda_Pacto'                     );
         SQL.Add('      ,a.Tasa_pacto'                       );
         SQL.Add('      ,a.Tasa_Base_Pacto'                  );
         SQL.Add('      ,a.Fecha_Vcto_Pacto'                 );
         SQL.Add('      ,b.Tasa_Emision'                     );
         SQL.Add('      ,b.Fecha_Emision'                    );
         SQL.Add('      ,b.Fecha_Vencimiento'                );
         SQL.Add('      ,c.Moneda     As Moneda_Instrum'     );
         SQL.Add('      ,b.Tipo_Nominales'                   );
         SQL.Add('      ,h.Tip_Tas_Valor_PAR   As Tasa_Base_Par');
         SQL.Add('      ,h.Tip_Tas_Valor_PTE   As Tasa_Base_Pte');
         SQL.Add('      ,b.Cartera'                          );
         SQL.Add('      ,a.Fecha_Operacion'                  );
         SQL.Add('      ,h.Tipo_Instrumento'                 );
         SQL.Add('      ,h.COD_CALC_PTE_INS As Formula_Pte'  );
         SQL.Add('      ,b.Custodia_Dest'    );
         SQL.Add('      ,''N'' As Emision_Implicita'         );
         SQL.Add('      ,b.Valor_Invertido_UM'               );
         SQL.Add('      ,b.Valor_Invertido_MC'               );
         SQL.Add('      ,b.Valor_Pactado_UM'                 );
         SQL.Add('      ,b.Valor_Pactado_MC'               );
         SQL.Add('      ,a.Owner'               );
         SQL.Add('      ,b.Cupones_Cortados'   );
         SQL.Add('      ,a.Fecha_de_Pago'   );
         SQL.Add('      ,b.Porcen_Valor_PAR'   );
         SQL.Add('      ,a.Moneda_Operacion'   );
         SQL.Add('      ,b.Tipo_Cambio'   );
         SQL.Add('      ,a.Contraparte'   );
         SQL.Add('      ,a.Contraparte_Dir'   );
         SQL.Add('  from Qs_Tra_Omd a');
         SQL.Add('     , Qs_Temp_Omd_Det_Rf b');
         SQL.Add('     , qs_fin_nem_rvari c');
         SQL.Add('      ,Qs_Fin_Instrum h');
         SQL.Add(' where a.fecha_operacion <= :Fecha');
         {SQL.Add('   AND a.transaccion in (SELECT d.Codigo_Transaccion');
                                SQL.Add('    FROM qs_sys_tran_implic d');
                                SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                SQL.Add('     AND d.implicancia = ''COMPRA'')');
         }
         SQL.Add('   AND a.transaccion  IN (SELECT d.Codigo_Transaccion');
                                    SQL.Add('    FROM qs_sys_tran_implic d');
                                    SQL.Add('   WHERE d.Codigo_transaccion = a.transaccion');
                                    SQL.Add('     AND d.implicancia = ''PACTO'')');
         SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                        SQL.Add('  FROM qs_ctr_anulacion e');
                                        SQL.Add(' WHERE e.folio   = a.folio_interno');
                                        SQL.Add('   AND e.transaccion = a.transaccion');
                                        SQL.Add('   AND e.empresa = a.empresa)');
         SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
         SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
         SQL.Add('                     WHERE proceso   = :proceso                       ');
         SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
         SQL.Add('   and a.folio_preimpreso <> '' ''');
         SQL.Add('   and a.Folio_Interno      = b.Folio_Interno');
         SQL.Add('   and a.Transaccion        = b.Transaccion');
         SQL.Add('   AND a.Empresa            = b.empresa');
         SQL.Add('   AND b.Pid                = :proceso ');
         SQL.Add('   AND b.Tipo_Instrum       = ''R''' ); // SOLO RENTA VARIABLE
         SQL.Add('   AND b.Nemotecnico        = c.Codigo_Nemotecnico');
         SQL.Add('   AND c.Codigo_Instrumento = h.Cod_Instrumento');
         SQL.Add('   AND a.Fecha_Vcto_Pacto   > :Fecha   ');

         if bPrepagos_Pactos then
         begin
           // No lo valoriza si esta prepagado (F.I. 24-06-2005)
           SQL.Add('   AND a.folio_interno NOT IN ( SELECT g.FOLIO_INTERNO_REL                          ');
           SQL.Add('                                  FROM QS_TRA_OMD_PREPAGO g                         ');
           SQL.Add('                                 WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno        ');
           SQL.Add('                                   AND g.Transaccion_Rel   = a.Transaccion          ');
           SQL.Add('                                   AND g.Empresa_Rel       = a.Empresa              ');
           SQL.Add('                                   AND g.Fecha_Prepago    <= :Fecha                 ');
           SQL.Add('                                   AND g.folio_interno NOT IN (SELECT e.folio       ');
           SQL.Add('                                                                 FROM qs_ctr_anulacion e              ');
           SQL.Add('                                                                WHERE e.folio       = g.folio_interno     ');
           SQL.Add('                                                                  AND e.transaccion = g.transaccion   ');
           SQL.Add('                                                                  AND e.empresa     = g.empresa))         ');
         end;
         
         if bAnticipos_Pactos then
         begin
           // No lo valoriza si esta prepagado (G.G. 27-12-2010)
           SQL.Add('   AND a.folio_interno NOT IN (SELECT g.FOLIO_INTERNO_REL                   ');
           SQL.Add('                                 FROM QS_TRA_OMD_PREPAGO_PACTO g            ');
           SQL.Add('                                WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno ');
           SQL.Add('                                  AND g.Transaccion_Rel   = a.Transaccion   ');
           SQL.Add('                                  AND g.Empresa_Rel       = a.Empresa       ');
           SQL.Add('                                  AND g.Fecha_Prepago    <= :Fecha          ');
           SQL.Add('                                  AND g.folio_interno NOT IN (SELECT e.folio                         ');
           SQL.Add('                                                                FROM qs_ctr_anulacion e              ');
           SQL.Add('                                                               WHERE e.folio       = g.folio_interno ');
           SQL.Add('                                                                 AND e.transaccion = g.transaccion   ');
           SQL.Add('                                                                 AND e.empresa     = g.empresa))     ');
         end;

         if Reg_Parametros.bCarteras then
            Sql.Add( ' AND b.cartera in ' + sString_Carteras );
         if Reg_Parametros.bEmisores then
            Sql.Add( ' AND b.Emisor in ' + sString_Emisores  );

         if Reg_Parametros.bInstrumentos then
            Sql.Add( ' AND h.Cod_Instrumento in ' + sString_Instrumentos );


         if Reg_Parametros.bSerie then
            Sql.Add( ' AND c.Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                   +' WHERE z.Parametro = ''STK_SERIE'''
                                   +'   AND z.Proceso   = :Proceso'
                                   +' )' );

         if Reg_Parametros.bNemotecnico then
            Sql.Add( ' AND b.Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                         +' WHERE w.Parametro = ''STK_NEMOS'''
                                         +'   AND w.Proceso   = :Proceso'
                                         +' )' );

         if Reg_Parametros.bFolios then
         begin
            if sDriver = 'MSSQL' then
               Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
            else
               Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
         end;

         if Reg_Parametros.bExcepcion then
            Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                         +'   where u.id = :id )');

         if Reg_Parametros.bSolo_Var then
         begin
                Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                     +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                     +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                     +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                     +'   AND x.Var_Periodo   = :Periodo '
                                     +'   AND x.Var_1010411   = b.Empresa '
                                  +' )' );
             Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
         end;

         if (bforward)                         and
            (not Reg_Parametros.bEmisores)     and
            (not Reg_Parametros.bSerie)        and
            (not Reg_Parametros.bNemotecnico)  and
             not ((Reg_Parametros.bInstrumentos) and (not BuscaStr(sString_Instrumentos,'''FWD'''))) then
         begin

            SQL.Add(' UNION ');
            // FORWARD
            SQL.Add('SELECT a.Empresa as Empresa'                   );
            SQL.Add('      ,a.Transaccion'                          );
            SQL.Add('      ,a.Folio_Interno'                        );
            SQL.Add('      ,1 as Item_OMD'                          );  // ,b.Item_Omd'                             );
            SQL.Add('      ,a.Empresa as Emisor'                    );  // ,b.Emisor'                               );
            SQL.Add('      ,''FWD'' as Instrumento'                 );  // ,b.Instrumento'                          );
            SQL.Add('      ,'''' as Serie'                          );  // ,b.Serie'                                );
            if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
               SQL.Add('   ,a.Fecha_Operacion as Fecha_Vig'         );
            SQL.Add('      ,''FWD'' as Nemotecnico'                 );  // ,b.Nemotecnico'                          );
            SQL.Add('      ,''RF'' as Tipo_Instrum'                 );  // ,b.Tipo_Inversion as Tipo_Instrum'       );
            SQL.Add('      ,a.Monto_Ope_UM as Valor_Nominal'                     );  // ,b.Valor_Nominal'                        );
            SQL.Add('      ,a.Tipo_Cambio_Spot as Tasa_Mercado'     );
            SQL.Add('      ,a.Moneda_Origen as Moneda_Pacto'        );
            SQL.Add('      ,0 as Tasa_pacto'                        );
            SQL.Add('      ,'''' as Tasa_Base_Pacto'                );
            SQL.Add('      ,a.Fecha_Vcto as Fecha_Vcto_Pacto'       );
            SQL.Add('      ,a.Tipo_Cambio_Fwd as Tasa_Emision'      );
            SQL.Add('      ,a.Fecha_Operacion as Fecha_Emision'     );
            SQL.Add('      ,a.Fecha_Vcto as Fecha_Vencimiento'      );
            SQL.Add('      ,a.Moneda_Origen As Moneda_Instrum'  );
            SQL.Add('      ,''I'' as Tipo_Nominales'                );
            SQL.Add('      ,'''' As Tasa_Base_Par'                  );  // ,h.Tip_Tas_Valor_PAR As Tasa_Base_Par'   );
            SQL.Add('      ,'''' As Tasa_Base_Pte'                  );  // ,h.Tip_Tas_Valor_PTE As Tasa_Base_Pte'   );
            SQL.Add('      ,a.Cartera'                              );
            SQL.Add('      ,a.Fecha_Operacion'                      );
            SQL.Add('      ,''RF''Tipo_Instrumento'                 );  // ,h.Tipo_Instrumento'                     );
            SQL.Add('      ,'''' As Formula_Pte'                    );  // ,h.COD_CALC_PTE_INS As Formula_Pte'      );
            SQL.Add('      ,'''' as Custodia_Dest'                  );
            SQL.Add('      ,''N'' As Emision_Implicita'             );
            SQL.Add('      ,a.Monto_Ope_UM as Valor_Invertido_UM'   );
            SQL.Add('      ,a.Monto_Ope_MC as Valor_Invertido_MC'   );
            SQL.Add('      ,a.Monto_Ope_UM as Valor_Pactado_UM     ');
            SQL.Add('      ,a.Monto_Ope_MC as Valor_Pactado_MC     ');
            SQL.Add('      ,'''' as Owner'                          );
            SQL.Add('      ,0 as Cupones_Cortados'                  );
            SQL.Add('      ,a.Fecha_de_Pago'                        );
            SQL.Add('      ,0 as Porcen_Valor_PAR'                  );
            SQL.Add('      ,a.Moneda_Conversion as Moneda_Operacion');
            SQL.Add('      ,0 as Tipo_Cambio'                       );
            SQL.Add('      ,'''' as Contraparte'                    );
            SQL.Add('      ,0    as Contraparte_Dir'                );
            SQL.Add('  FROM QS_TRA_FWD              a ');
            SQL.Add(' WHERE a.fecha_operacion <= :Fecha');
            SQL.Add('   AND a.transaccion  IN ( SELECT d.Codigo_Transaccion');
                                       SQL.Add('  FROM qs_sys_tran_implic d');
                                       SQL.Add(' WHERE d.Codigo_transaccion = a.transaccion');
                                       SQL.Add('   AND d.implicancia = ''FORWARD'')');
            SQL.Add('   AND a.folio_interno not in (SELECT e.folio');
                                           SQL.Add('  FROM qs_ctr_anulacion e');
                                           SQL.Add(' WHERE e.folio   = a.folio_interno');
                                           SQL.Add('   AND e.transaccion = a.transaccion');
                                           SQL.Add('   AND e.empresa = a.empresa)');
            if bAnticipos_Pactos then
            begin
              // No lo valoriza si esta prepagado (G.G. 27-12-2010)
              SQL.Add('   AND a.folio_interno NOT IN (SELECT g.FOLIO_INTERNO_REL                   ');
              SQL.Add('                                 FROM QS_TRA_OMD_PREPAGO_PACTO g            ');
              SQL.Add('                                WHERE g.FOLIO_INTERNO_REL = a.Folio_Interno ');
              SQL.Add('                                  AND g.Transaccion_Rel   = a.Transaccion   ');
              SQL.Add('                                  AND g.Empresa_Rel       = a.Empresa       ');
              SQL.Add('                                  AND g.Fecha_Prepago    <= :Fecha          ');
              SQL.Add('                                  AND g.folio_interno NOT IN (SELECT e.folio                         ');
              SQL.Add('                                                                FROM qs_ctr_anulacion e              ');
              SQL.Add('                                                               WHERE e.folio       = g.folio_interno ');
              SQL.Add('                                                                 AND e.transaccion = g.transaccion   ');
              SQL.Add('                                                                 AND e.empresa     = g.empresa))     ');
            end;
            SQL.Add('   AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
            SQL.Add('                       FROM QS_SYS_PARAM_PROCESO                       ');
            SQL.Add('                      WHERE proceso   = :proceso                       ');
            SQL.Add('                        AND parametro = ''EMPRESA'')                   ');
            SQL.Add('   AND a.Fecha_Vcto         > :Fecha   ');
            if Reg_Parametros.bCarteras then
               Sql.Add( ' AND a.cartera in ' + sString_Carteras );
            if Reg_Parametros.bFolios then
            begin
               if sDriver = 'MSSQL' then
                  Sql.Add( ' AND convert(Integer, b.Folio_Interno) between :Folio_desde and :Folio_hasta ')
               else
                  Sql.Add( ' AND TO_NUMBER(b.Folio_Interno) between :Folio_desde and :Folio_hasta ');
            end;
            if Reg_Parametros.bExcepcion then
               Sql.Add( ' AND b.Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                               +'   where u.id = :id )');
            if Reg_Parametros.bSolo_Var then
            begin
                   Sql.Add( ' AND EXISTS (SELECT x.Var_Folio_Ope FROM VAR_DET_OPE_VAR x'
                                        +' WHERE x.Var_Folio_Ope = b.Folio_Interno '
                                        +'   AND x.Var_Item_Ope  = b.Item_OMD '
                                        +'   AND x.Var_Cod_Ope   = b.Transaccion '
                                        +'   AND x.Var_Periodo   = :Periodo '
                                        +'   AND x.Var_1010411   = b.Empresa '
                                     +' )' );
                Parambyname('Periodo').asFloat := Reg_Parametros.fPeriodo;
            end;

         end;  //if bForward then

         Sql.Add(' ORDER BY Empresa'
                +'         ,Emisor'
                +'         ,Instrumento'
                +'         ,Serie'
                +'         ,Nemotecnico'
                );
         ParamByName('Fecha'  ).AsDateTime := dFecha_Inicial;
         Parambyname('Proceso').asString   := IntToStr(Application.Handle);

//         if Reg_Parametros.bCarteras then
//            Parambyname('Pid').asFloat := Application.Handle;

         if Reg_Parametros.bFolios then
         begin
           Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
           Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
         end;

         if Reg_Parametros.bExcepcion then
            Parambyname('id').AsFloat := Application.Handle;

         Open;

         Mostrar_Progreso_Reg;
         //Cargo Valores
         sNombre_Tabla := 'QS_TES_EGRING';
         if sDriver = 'MSSQL' then
         begin
             pone_owner_MSSQL(sNombre_Tabla, Result);
             if NOT Result then
             begin
                Application.MessageBox(Pchar('Error al Abrir Tabla '+sNombre_Tabla)
                                      ,'Sistema'
                                      , mb_OK);
                Exit;
             end;
         end;
         T_Tes_Egring.Close;
         T_Tes_Egring.TableName := Trim(sNombre_Tabla);
         T_Tes_Egring.Open;

         if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
            dFecha_Aux := dFecha_Hora_Servidor;
         if dFecha_Final > dFecha_Aux then
            dFecha_Aux := dFecha_Final;

         Mostrar_Mensaje('Cargando Valores Monedas ...', bAbortar);
         if NOT bAbortar then
         Carga_Valores_de_Cambio_Mem(   dFecha_Inicial - 3 // Desface porque si proyecta y es fin de semana
                                      , dFecha_Final + 5
                                      ,''
                                      ); // va un o dos dias atras a buscar Valor de Cambio
         if (bforward)                         and
            (not Reg_Parametros.bEmisores)     and
            (not Reg_Parametros.bSerie)        and
            (not Reg_Parametros.bNemotecnico)  and
             not ((Reg_Parametros.bInstrumentos) and (not BuscaStr(sString_Instrumentos,'''FWD'''))) then
            Carga_Valores_de_Cambio_Tramo_Mem(dFecha_Inicial - 3 // Desface porque si proyecta y es fin de semana
                                             ,dFecha_Final + 5
                                             ,''
                                             ); // va un o dos dias atras a buscar Valor de Cambio

         //if NOT bdesarrollo then  // Solo para Hoy 23-03-2011
         //begin
         Mostrar_Mensaje('Cargando Tasas de Mercado ...', bAbortar);
         if NOT bAbortar then
         Carga_Valores_Tasas_Mercado_Mem( dFecha_Inicial );

         Mostrar_Mensaje('Cargando Ultimas Tasas de Mercado ...', bAbortar);
         if NOT bAbortar then
         Carga_Last_Tasas_Mercado_Mem( 'VALORIZA'
                                      ,dFecha_Inicial
                                     );
         //end;

         Mostrar_Mensaje('Cargando Tasas Por Instrumento ...', bAbortar);
         if NOT bAbortar then
         Carga_Valores_Tasas_Instrumento_Mem( dFecha_Inicial );

         Mostrar_Mensaje('Cargando TIRMRA ...', bAbortar);
         if NOT bAbortar then
         Carga_Valores_Tirmra_Mem( dFecha_Inicial );
         Carga_Valores_Tirmra_2_Mem( dFecha_Inicial );

         Mostrar_Mensaje('Cargando Motivos ...', bAbortar);
         if NOT bAbortar then
         Carga_Motivo_Mem( dFecha_Final );

         Mostrar_Mensaje('Cargando Custodias Vigentes ...', bAbortar);
         Carga_Custodias_Vigentes_Mem( dFecha_Final );

         Mostrar_Mensaje('Cargando Pactos Para Vencimientos ...', bAbortar);
         if NOT bAbortar then
         Carga_Nominales_Pactados_Mercado_Mem( dFecha_Inicial,
                                               Reg_Parametros
                                              );

         dFecha_Libera_Pacto := dFecha_Inicial;

         // Se comenta para tema doble financiamiento en Euroamerica
         // Entra a pruebas con fecha 25-05-2007

         //if dfecha_Hora_Servidor > dFecha_Libera_Pacto then
         //   dFecha_Libera_Pacto := dfecha_Hora_Servidor;


// cjf Busco parametro para el control de fechas de pago...
         sFechaPagoAOcupar := '0';
         Busca_param_proceso('FECHAPAGO','FECHAPAGO', sFechaPagoAOcupar, bResultFechaPago);

         sCartera         := '';
         sEmpresa_Aux     := '';
         sEmpresa_Proceso := '';
         Inicializar_Progreso_Reg(RecordCount);
         While (NOT EOF)      and
               (NOT bAbortar) do
         begin


//// DC 16/11/2010
           SSerie := DMValorizacion.QRY_General.FieldByName('Serie').AsString;
           if (Fieldbyname('Tipo_Instrumento').asString = 'RV') and
             ((DMValorizacion.QRY_General.Fieldbyname('Serie').IsNull) or
              (DMValorizacion.QRY_General.Fieldbyname('Serie').AsString = '')) then
           begin
             with DMValorizacion,QRY_CNS do
             begin
               SQL.CLear;
               SQL.Add('SELECT a.Serie'
                      +'  FROM QS_FIN_NEM_RVARI a'
                      +' WHERE a.Codigo_Instrumento = :Instrumento'
                      +'   AND a.Codigo_Nemotecnico = :Nemotecnico'
                      +'   AND a.Codigo_Identidad   = :Identidad' );

               ParamByName('Instrumento').AsString  := DMValorizacion.QRY_General.Fieldbyname('Instrumento').asString;
               ParamByName('Nemotecnico').AsString  := DMValorizacion.QRY_General.Fieldbyname('Nemotecnico').asString;
               ParamByName('Identidad').AsString    := DMValorizacion.QRY_General.Fieldbyname('Emisor').asString;

               Open;

               if Not FieldByName('Serie').IsNull then
                  SSerie := DMValorizacion.QRY_CNS.FieldByName('Serie').AsString
               else
                  SSerie := DMValorizacion.QRY_General.FieldByName('Serie').AsString;
             end;
           end;
//// DC 16/11/2010

           if sEmpresa_Proceso <> Fieldbyname('Empresa').asString then
           begin
              if VarIsArray(Reg_Nominales_Vendidos.Folio_Interno_Rel) then
              begin
                 VarClear(Reg_Nominales_Vendidos.Folio_Interno_Rel);
                 VarClear(Reg_Nominales_Vendidos.Item_Omd_Rel);
                 VarClear(Reg_Nominales_Vendidos.Transaccion_Rel);
                 VarClear(Reg_Nominales_Vendidos.Valor_Nominal);
                 VarClear(Reg_Nominales_Vendidos.Fecha_Operacion);
              end;

              Mostrar_Mensaje('Cargando Nominales Vendidos ...', bAbortar);
              if NOT bAbortar then
                 Carga_Nominales_Vendidos_Mem(  Fieldbyname('Empresa').asString
                                               ,fecha_hora_servidor   //dFecha_Aux  Se usa mas abajo!!!!  06-05-211 FI & GG
                                              );

              if VarIsArray(Reg_Nominales_Pactados.Folio_Interno_Rel) then
              begin
                 VarClear(Reg_Nominales_Pactados.Cartera);
                 VarClear(Reg_Nominales_Pactados.Folio_Interno_Rel);
                 VarClear(Reg_Nominales_Pactados.Item_Omd_Rel);
                 VarClear(Reg_Nominales_Pactados.Transaccion_Rel);
                 VarClear(Reg_Nominales_Pactados.Valor_Nominal);
                 VarClear(Reg_Nominales_Pactados.Fecha_Operacion);
                 VarClear(Reg_Nominales_Pactados.Fecha_Vcto_Pacto);
                 VarClear(Reg_Nominales_Pactados.Valor_Pactado_UM);
                 VarClear(Reg_Nominales_Pactados.Valor_Pactado_MC);
                 VarClear(Reg_Nominales_Pactados.Transaccion);
                 VarClear(Reg_Nominales_Pactados.Folio_Interno);
                 VarClear(Reg_Nominales_Pactados.Item_Omd);
              end;

              Mostrar_Mensaje('Cargando Nominales Pactados ...', bAbortar);
              if NOT bAbortar then
                 Carga_Nominales_Pactados_Mem(  Fieldbyname('Empresa').asString
                                               ,dFecha_Inicial //dFecha_Final  // se deben cargar al dia de proceso
                                              );

              { Carga de valorizacion de ayer}
              if sImplicancia_Mercado = 'MERCADO' then
              begin
                 if VarIsArray(Reg_Folio_Mdo.Cartera) then
                 begin
                    VarClear(Reg_Folio_Mdo.Cartera          );
                    VarClear(Reg_Folio_Mdo.Transaccion      );
                    VarClear(Reg_Folio_Mdo.Folio_Interno    );
                    VarClear(Reg_Folio_Mdo.Item_OMD         );
                    VarClear(Reg_Folio_Mdo.Valor_Nominal    );
                    VarClear(Reg_Folio_Mdo.Valor_Pte_I_Mer  );
                    VarClear(Reg_Folio_Mdo.fecha_Last_Cierre);
                 end;

                 Mostrar_Mensaje('Cargando Valores de Mercado ...', bAbortar);
                 if NOT bAbortar then
                    Carga_Registro_Mercado_Mem(  Fieldbyname('Empresa').asString
                                                ,dFecha_Inicial - 1
                                              );
              end;
              sEmpresa_Proceso := Fieldbyname('Empresa').asString;
           end;

           //Elimino tipo de cambio FIJO
           Elimina_Tipo_Cambio_Fijo_Mem;
           sMensaje  := ' Folio : ' + FieldByName('Folio_Interno').AsString
                       +' - '
                       +' Item : ' + FieldByName('Item_Omd').AsString
                       +' - '
                       +FieldByName('Emisor').AsString
                       +' - '
                       +FieldByName('Instrumento').AsString
                       +' - '
                       +FieldByName('Serie').AsString
                       +' - '
                       +FieldByName('Nemotecnico').AsString;

           Mostrar_Mensaje(sMensaje, bAbortar);
           Mostrar_Progreso_Reg;

           if baBortar then
              Continue;

{
if bdesarrollo then
   if (Fieldbyname('transaccion').asString <> 'FWDV') and (Fieldbyname('transaccion').asString <> 'VRCNC') then
   begin
        Next;
        Continue;
   end;
//}
//{
if bdesarrollo then
//   if (Fieldbyname('Folio_interno').asString <> '9290') or
//      (Fieldbyname('Item_omd').AsFloat <> 3) then
   if (Fieldbyname('Folio_interno').asString <> '60028676') then
   begin
        Next;
        Continue;
   end;
//}
     //      if bdesarrollo then
     //      begin
     //         if (Fieldbyname('Instrumento').asString <> 'LH') then
     //            (Fieldbyname('Item_omd').AsFloat <> 2) then
     //         begin
     //            Next;
     //            Continue;
     //         end;
     //      end;

 {
 if bdesarrollo then
   if (Fieldbyname('Folio_interno').asString = '60024515') and
      (Fieldbyname('Item_omd').AsFloat = 7) then
   begin
           Application.MessageBox(Pchar( 'Llegue a Folio 60024515-7' )
                                        ,'PROCESO'
                                        ,Mb_OK
                                 );
   end;
 }
{
     if bdesarrollo then
        if (Fieldbyname('Nemotecnico').asString <> 'BCAPS-F')  then
        begin
           Next;
           Continue;
        end;
//}
{
     if bdesarrollo then
        if (Fieldbyname('instrumento').asString <> 'MH')  then
        begin
           Next;
           Continue;
        end;
//}

     // Verifico Bonos Vencidos y no Cobrados (Auditoria) y reasigno la fecha de calculo para k valorize al Vcto.
           if (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
           begin
              dFecha_Inicial := dFecha_aux;
              if (FieldByName('Instrumento').AsString = 'BR') and
                 (FieldByName('Fecha_Vencimiento').asdatetime < dFecha_Inicial) then
              begin
                 dFecha_Inicial := FieldByName('Fecha_Vencimiento').asdatetime;
              end;
           end;


   // cjf  Para control de la fecha de pago segun parametro
   // Cambio F.I. 08-04-2008 Estaba afectando a las compañias extranjeras que no tienen
   // el parametro desde que fecha utilizar el devengamiento
         {
         dFechaPagoAOcupar  := Fieldbyname('Fecha_Operacion').asDatetime;
         if sFechaPagoAOcupar <> '0' then
            if dFecha_Inicial > strtoDate(sFechaPagoAOcupar) Then
               dFechaPagoAOcupar  := Fieldbyname('Fecha_de_Pago').asDatetime;
         }


         dFechaPagoAOcupar  := Fieldbyname('Fecha_de_Pago').asDatetime;
         if sFechaPagoAOcupar <> '0' then
            if dFecha_Inicial <= strtoDate(sFechaPagoAOcupar) Then
               dFechaPagoAOcupar  := Fieldbyname('Fecha_Operacion').asDatetime;

         if FieldByName('Tipo_Cambio').IsNull then
            fTipo_Cambio_Compra := 0
         else
            fTipo_Cambio_Compra := FieldByName('Tipo_Cambio').AsFloat;

           //Se movio validacion tasa base despues de la rutina de pactos GGARCIA 17/04/2007

           Reg_Val_In.Spread := Busca_Spread_Mem(  FieldByName('Empresa').AsString
                                                  ,FieldByName('Transaccion').AsString
                                                  ,FieldByName('Folio_Interno').AsString
                                                  ,FieldByName('Item_Omd').AsFloat
                                                  );


           // Si existe el parametro moneda conversion debeconvertir a este y no a la cartera
           if sParametro_Moneda_Conversion <> '' then
              sMoneda_Conversion := sParametro_Moneda_Conversion
           else
              if sCartera <> FieldByName('Cartera').AsString then
              begin
                 sCartera := FieldByName('Cartera').AsString;

                 Leer_Cartera_Mem(FieldByName('Empresa').AsString,
                                  sCartera,
                                  sString_Error,
                                  sString_Error,
                                  sMoneda_Conversion,
                                  Result);

                 if NOT Result then
                 begin
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial,
                                              sLogin_Sistema,
                                              sMensaje,
                                              'DM_Valorizacion',
                                              'No existe definicion de cartera '+sCartera
                                             ,'99'
                                              );
                    Next;
                    Continue;
                 end;
              end;

           // *******************************************************
           // Valorizo los forward aquí para no ensuciar lo de abajo
           // *******************************************************

           if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'FORWARD') then
           begin
              // Moneda Operacion es la del contrato
              // Moneda de conversion es la moneda de la cartera
              if Fieldbyname('Moneda_Operacion').asString <> sMoneda_Conversion then
              begin
                 leer_valor_cambio2(Fieldbyname('Moneda_Operacion').asString
                                   ,sMoneda_Conversion
                                   ,'BC'
                                   ,dFecha_Inicial
                                   ,fValor_Paridad
                                   ,bExiste_Paridad
                                   );
                 if NOT bExiste_Paridad then
                 begin
                    sModulo_Error := 'Cálculo Forward';
                    sString_Error := 'No se encontró valor de cambio para '+Fieldbyname('Moneda_Operacion').asString+#10
                                    +'Con fecha : '+DateToStr(dFecha_Inicial);
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                   sProceso,
                                                   dFecha_Inicial,
                                                   sLogin_Sistema,
                                                   sMensaje,
                                                   sModulo_Error,
                                                   sString_Error,
                                                   '10'
                                                   );
                    Next;
                    Continue;
                 end;
              end
              else
                 fValor_Paridad := 1;

              fValorInvertidoUM_Cpa := Fieldbyname('Valor_Pactado_UM').asFloat;
              fValorInvertidoMC_Cpa := Fieldbyname('Valor_Pactado_MC').asFloat;

              // VALORIZACION MERCADO FORWARD
              fValor_Pte_UM_Cpa             := 0;
              fValor_Pte_MC_Cpa             := 0;
              fValor_Pte_UM_Cpa_SC          := 0;
              fValor_Pte_MC_Cpa_SC          := 0;
              fValor_Pte_UM_Mdo_SC          := 0;
              fValor_Pte_MC_Mdo_SC          := 0;
              Reg_Val_Out.Valor_Par_UM      := Fieldbyname('Valor_Pactado_UM').asFloat;
              Reg_Val_Out.Valor_Par_MC      := Fieldbyname('Valor_Pactado_MC').asFloat;
              Reg_Val_Out.ValorInvertidoUM  := 0;
              Reg_Val_Out.ValorInvertidoMC  := 0;
              Reg_Val_In.Valoriza_Par_Pte   := '';
              Reg_Val_In.Re_Llamado         := '';
              Reg_Val_In.Descriptor_Cargado := 'SI';
              // Nuevo 28-11-2012 F.I.
              Reg_Val_In.Proceso_Valuacion  := 'MERCADO';
              Reg_Val_In.Tipo_Instrumento   := '';
              Reg_Val_In.Tipo_Proceso       := 'B';
              Reg_Val_In.Cartera            := Fieldbyname('Cartera').asString;
              Reg_Val_In.Pais_Titulo        := sPais_Usuario;
              Reg_Val_In.sEmisor            := '';
              Reg_Val_In.sSerie             := '';
              if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                 Reg_Val_In.dFecha_Vig      := 0;
              Reg_Val_In.Nemotecnico        := '';
              Reg_Val_In.sInstrumento       := 'FWD';
              Reg_Val_In.sUnidadMonetaria   := Fieldbyname('Moneda_Pacto').asString;
              Reg_Val_In.sMoneda_Conversion := Fieldbyname('Moneda_Operacion').asString;  //sMoneda_Conversion;
              Reg_Val_In.Tasa_Base_Pacto    := Fieldbyname('Tasa_Base_Pacto').Asstring;
              Reg_Val_In.dFechaCalculo      := dFecha_Inicial;
              Reg_Val_In.dFechaVencimiento  := Fieldbyname('Fecha_Vcto_Pacto').asDatetime;
              Reg_Val_In.dFechaOperacion    := Fieldbyname('Fecha_Operacion').asDatetime;//dFecha_Inicial;
              Reg_Val_Out.TasaCalculo       := FieldByName('Tasa_Pacto').AsFloat;
              Reg_Val_In.Con_Cupon          := True;
              Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
              Reg_Val_In.dFechaPago         := dFechaPagoAOcupar;



              sTipo_Tasa_Precio_Mdo        := '';
              Reg_Val_Out.Tipo_Tasa_Precio := '';
              sOrigen_Mdo                  := '';
              sTipo_Valuac_Mdo             := '';
              sFormula_Pte_Mdo             := '';

              Busca_Valuacion_Mem ( Reg_Val_In,
                                    sTipo_Valuac,
                                    sFormula_Pte,
                                    fBase_Precio,
                                    sMon_Ind,
                                    sOrigen,
                                    bValuacion
                                    );

              if bValuacion then
              begin
                sOrigen_Mdo      := sOrigen;
                sTipo_Valuac_Mdo := sTipo_Valuac;
                sFormula_Pte_Mdo := sFormula_Pte;
              end;

              Valoriza_Registro(Reg_Val_In,
                                Reg_Val_Out,
                                sModulo_Error,
                                sString_Error,
                                Result);

              if NOT Result then
              begin
                 Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                           sProceso,
                                           dFecha_Inicial,
                                           sLogin_Sistema,
                                           sMensaje,
                                           sModulo_Error,
                                           sString_Error
                                          ,'10'
                                           );
                 Next;
                 Continue;
              end;
              // Valor del operación (registrado y comprometido a la firma del conmtrato)

              fValor_Pte_UM_Cpa      := Redondeo_Moneda_Mem(sMoneda_Conversion
                                                           ,dFecha_Inicial
                                                           ,fValorInvertidoMC_Cpa);

              fValor_Pte_MC_Cpa      := Redondeo_Moneda_Mem(sMoneda_Conversion
                                                           ,dFecha_Inicial
                                                           ,fValorInvertidoMC_Cpa * fValor_Paridad);

              sTipo_Tasa_Precio_Mdo  := Reg_Val_Out.Tipo_Tasa_Precio;

              // Valor al dia de la valorización
              fValor_Pte_UM_Mdo      := Redondeo_Moneda_Mem(sMoneda_Conversion
                                                           ,dFecha_Inicial
                                                           ,Reg_Val_Out.ValorInvertidoUM);

              fValor_Pte_MC_Mdo      := Redondeo_Moneda_Mem(sMoneda_Conversion
                                                           ,dFecha_Inicial
                                                           ,Reg_Val_Out.ValorInvertidoUM * fValor_Paridad);

              // Valor del operación (registrado y comprometido a la firma del conmtrato)
              fValor_Par_UM          := Redondeo_Moneda_Mem(sMoneda_Conversion
                                                           ,dFecha_Inicial
                                                           ,Reg_Val_Out.Valor_Par_UM);

              fValor_Par_MC          := Redondeo_Moneda_Mem(sMoneda_Conversion
                                                           ,dFecha_Inicial
                                                           ,Reg_Val_Out.Valor_Par_MC * fValor_Paridad);



              // VALORIZACION MIXTA FORWARD
              Reg_Val_Out.ValorInvertidoUM  := 0;
              Reg_Val_Out.ValorInvertidoMC  := 0;
              Reg_Val_In.Valoriza_Par_Pte   := '';
              Reg_Val_In.Re_Llamado         := '';
              Reg_Val_In.Descriptor_Cargado := 'SI';
              // Nuevo 28-11-2012 F.I.
              Reg_Val_In.Proceso_Valuacion  := 'MIXTA';
              Reg_Val_In.Tipo_Instrumento   := '';
              Reg_Val_In.Tipo_Proceso       := 'B';
              Reg_Val_In.sEmisor            := '';
              Reg_Val_In.sSerie             := '';
              if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                 Reg_Val_In.dFecha_Vig      := 0;
              Reg_Val_In.Nemotecnico        := '';
              Reg_Val_In.sInstrumento       := 'FWD';
              Reg_Val_In.sUnidadMonetaria   := Fieldbyname('Moneda_Pacto').asString;
              Reg_Val_In.sMoneda_Conversion := Fieldbyname('Moneda_Operacion').asString;  //sMoneda_Conversion;
              Reg_Val_In.Tasa_Base_Pacto    := Fieldbyname('Tasa_Base_Pacto').Asstring;
              Reg_Val_In.dFechaCalculo      := dFecha_Inicial;
              Reg_Val_In.dFechaVencimiento  := Fieldbyname('Fecha_Vcto_Pacto').asDatetime;
              Reg_Val_In.dFechaOperacion    := Fieldbyname('Fecha_Operacion').asDatetime;//dFecha_Inicial;
              Reg_Val_In.dFechaEmision      := Fieldbyname('Fecha_Operacion').asDatetime;
              Reg_Val_Out.TasaCalculo       := FieldByName('Tasa_Pacto').AsFloat;
              Reg_Val_In.Con_Cupon          := True;
              Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
              Reg_Val_In.dFechaPago         := dFechaPagoAOcupar;

              sTipo_Tasa_Precio_Mix        := '';
              Reg_Val_Out.Tipo_Tasa_Precio := '';
              sOrigen_Mix                  := '';
              sTipo_Valuac_Mix             := '';
              sFormula_Pte_Mix             := '';

              Busca_Valuacion_Mem ( Reg_Val_In,
                                    sTipo_Valuac,
                                    sFormula_Pte,
                                    fBase_Precio,
                                    sMon_Ind,
                                    sOrigen,
                                    bValuacion
                                    );

              if bValuacion then
              begin
                sOrigen_Mix      := sOrigen;
                sTipo_Valuac_Mix := sTipo_Valuac;
                sFormula_Pte_Mix := sFormula_Pte;
              end;

              Valoriza_Registro(Reg_Val_In,
                                Reg_Val_Out,
                                sModulo_Error,
                                sString_Error,
                                Result);

              if NOT Result then
              begin
                 Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                           sProceso,
                                           dFecha_Inicial,
                                           sLogin_Sistema,
                                           sMensaje,
                                           sModulo_Error,
                                           sString_Error
                                          ,'10'
                                           );
                 Next;
                 Continue;
              end;


              fValorizacion_Mixta_UM      := Redondeo_Moneda_Mem( sMoneda_Conversion
                                                                 ,dFecha_Inicial
                                                                 ,Reg_Val_Out.ValorInvertidoUM);

              fValorizacion_Mixta      := Redondeo_Moneda_Mem( sMoneda_Conversion
                                                              ,dFecha_Inicial
                                                              ,Reg_Val_Out.ValorInvertidoUM * fValor_Paridad);

              sTipo_Tasa_Precio_Mix     := Reg_Val_Out.Tipo_Tasa_Precio;
              fSaldo_Insoluto_UM := 0;
              fSaldo_Insoluto_MC := 0;

              if (Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'FORWARD')) and
                 (Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PASIVO') ) then
                 fDiferencia := fValor_Pte_Mc_Cpa - fValor_Pte_Mc_Mdo
              else
                 fDiferencia := fValor_Pte_Mc_Mdo - fValor_Pte_Mc_Cpa;

              // Nuevo busca proceso para calculo de Resultado a mercado

              Reg_Val_In.Proceso_Valuacion  := 'RES-FWD';  //--> Nuevo proceso para poder parametrizar eld escuento del resultado
              Reg_Val_In.sInstrumento       := 'RES-FWD';


              sTipo_Tasa_Precio_Cpa        := '';
              Reg_Val_Out.Tipo_Tasa_Precio := '';
              sOrigen_Cpa                  := '';
              sTipo_Valuac_Cpa             := '';
              sFormula_Pte_Cpa             := '';

              Busca_Valuacion_Mem ( Reg_Val_In,
                                    sTipo_Valuac,
                                    sFormula_Pte,
                                    fBase_Precio,
                                    sMon_Ind,
                                    sOrigen,
                                    bValuacion
                                    );

              if bValuacion then
              begin
                Reg_Val_In.Valoriza_Par_Pte     := 'VAL';
                Reg_Val_In.Proceso_Valuacion  := 'RES-FWD';  //--> Nuevo proceso para poder parametrizar eld escuento del resultado
                Reg_Val_Out.Nominales         := fDiferencia;
                Reg_Val_Out.ValorInvertidoUM  := fDiferencia;
                Reg_Val_Out.ValorInvertidoMC  := 0;
                Reg_Val_In.sUnidadMonetaria   := Fieldbyname('Moneda_Operacion').asString;
                Reg_Val_In.sMoneda_Conversion := Fieldbyname('Moneda_Operacion').asString;  //sMoneda_Conversion;
                Reg_Val_In.sInstrumento       := 'RES-FWD';
                Reg_Val_In.Tipo_Instrumento   := 'U';
                Reg_Val_In.sTipoNominales     := 'F';

                sOrigen_Cpa      := sOrigen;
                sTipo_Valuac_Cpa := sTipo_Valuac;
                sFormula_Pte_Cpa := sFormula_Pte;

                Valoriza_Registro(Reg_Val_In,
                                  Reg_Val_Out,
                                  sModulo_Error,
                                  sString_Error,
                                  Result);

                if NOT Result then
                begin
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             sModulo_Error,
                                             sString_Error
                                            ,'10'
                                             );
                   Next;
                   Continue;
                end;
                fDiferencia          := Reg_Val_Out.ValorInvertidoUM;
                fRate_Used_Valuacion := Reg_val_out.Rate_Used_Valuacion
              end;

              fDiferencia := Redondeo_Moneda_Mem( sMoneda_Conversion
                                                 ,dFecha_Inicial
                                                 ,fDiferencia);

              Insert_Mercado(Fieldbyname('Empresa').asString,
                             Fieldbyname('Cartera').asString,
                             Fieldbyname('Transaccion').asString,
                             Fieldbyname('Folio_Interno').asString,
                             Fieldbyname('Item_Omd').asFloat,
                             Fieldbyname('Nemotecnico').asString,
                             Fieldbyname('Emisor').asString,
                             Fieldbyname('Instrumento').asString,
                             SSerie,  // Fieldbyname('Serie').asString,   DC
                             Fieldbyname('Moneda_Instrum').asString,
                             Fieldbyname('Tasa_Emision').asFloat,
                             Fieldbyname('Fecha_Operacion').asDatetime,    //dFecha_Emision,
                             Fieldbyname('Fecha_Vcto_Pacto').asDatetime,   //dFecha_Vencimiento,
                             dFecha_Inicial,
                             Fieldbyname('Fecha_Operacion').asDatetime,
                             FieldByName('Valor_Nominal').AsFloat,
                             fValor_Par_UM, //Reg_Val_Out.Valor_Par_UM,
                             fValor_Par_MC, //Reg_Val_Out.Valor_Par_MC,
                             FieldByName('Tasa_Pacto').AsFloat,
                             fValor_Pte_UM_Cpa,
                             fValor_Pte_MC_Cpa,
                             fValor_Pte_UM_Mdo,
                             fValor_Pte_MC_Mdo,
                             0,//fPtj_Valor_Par_Mdo,
                             fRate_Used_Valuacion,
                             0,//fPorcen_Valor_Par,
                             0,//fDuration,
                             0,//fDuracion_Modificada,
                             0,//fConvexidad,
                             0,//fPlazo_al_Vcto,
                             fValor_Pte_UM_Cpa,
                             fValor_Pte_MC_Cpa,
                             ' ',//sClasif_Riesgo,
                             ' ',//sTipo_Clasif,
                             0, //fFactor_Riesgo,
                             FieldByName('Tasa_Pacto').AsFloat,
                             fValorizacion_Mixta,
                             fValorizacion_Mixta_UM,
                             Reg_Val_In.Motivo_Operacion,
                             fSaldo_Insoluto_Par,
                             'T',
                             fValor_Pte_MC_Cpa,
                             fValor_Pte_MC_Cpa,
                             dFecha_Last_Cierre,
                             Result,
                             Reg_Parametros,
                             FieldByName('Custodia_Dest').AsString,
                             0,    //fDuration_Tasa_Emi,
                             0,   //fDuracion_Modificada_Tasa_Emi
                             0,   //fNRO_DIVIDENDOS_IMP
                             fSaldo_Insoluto_UM,
                             fSaldo_Insoluto_MC,

                             sTipo_Tasa_Precio_Cpa,
                             sOrigen_Cpa,
                             sTipo_Valuac_Cpa,
                             sFormula_Pte_Cpa,
                             sTipo_Tasa_Precio_Mdo,
                             sOrigen_Mdo,
                             sTipo_Valuac_Mdo,
                             sFormula_Pte_Mdo,
                             sTipo_Tasa_Precio_Mix,
                             sOrigen_Mix,
                             sTipo_Valuac_Mix,
                             sFormula_Pte_Mix,
                             fDiferencia
                             );

              if not Result then
              begin
                 Result := true;
                 Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                           sProceso,
                                           dFecha_Inicial,
                                           sLogin_Sistema,
                                           sMensaje,
                                           ' Base de Datos : ',
                                           ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO'
                                          ,'99'
                                           );
              end;

              /// Valorizamos al dia siguiete si corresponde MERCADO para la tabla _AD
              (*
              if sImplicancia_Mercado = 'MERCADO' then
              begin

                Reg_Val_In.dFechaCalculo      := dFecha_Inicial+1;
                Reg_Val_In.dFechaOperacion    := dFecha_Inicial+1;

                   Valoriza_Registro(Reg_Val_In,
                                     Reg_Val_Out,
                                     sModulo_Error,
                                     sString_Error,
                                     Result);

                   if NOT Result then
                   begin
                      Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                sProceso,
                                                dFecha_Inicial + 1,
                                                sLogin_Sistema,
                                                sMensaje,
                                                sModulo_Error,
                                                sString_Error
                                                ,'10'
                                                );
                      Next;
                      Continue;
                   end;

                   fValor_Pte_UM_Cpa      := fValorInvertidoMC_Cpa;
                   fValor_Pte_MC_Cpa      := fValorInvertidoMC_Cpa * fValor_Paridad;
                   fValor_Pte_UM_Mdo      := Reg_Val_Out.ValorInvertidoUM;
                   fValor_Pte_MC_Mdo      := Reg_Val_Out.ValorInvertidoUM * fValor_Paridad;
                   fValorizacion_Mixta    := Reg_Val_Out.ValorInvertidoMC;
                   fValorizacion_Mixta_UM := Reg_Val_Out.ValorInvertidoMC * fValor_Paridad;
                //end;

                Insert_Mercado_Ad(Fieldbyname('Empresa').asString,
                                  Fieldbyname('Cartera').asString,
                                  Fieldbyname('Transaccion').asString,
                                  Fieldbyname('Folio_Interno').asString,
                                  Fieldbyname('Item_Omd').asFloat,
                                  dFecha_Inicial + 1,
                                  FieldByName('Tasa_Pacto').AsFloat,
                                  fValor_Pte_UM_Cpa,
                                  fValor_Pte_MC_Cpa,
                                  0,//fPorcen_Valor_Par_Ini,
                                  FieldByName('Tasa_Pacto').AsFloat,
                                  fValor_Pte_UM_Mdo,
                                  fValor_Pte_MC_Mdo,
                                  0,// fPtj_Valor_Par_Mdo,
                                  FieldByName('Tasa_Pacto').AsFloat,
                                  fValorizacion_Mixta_UM,
                                  fValorizacion_Mixta,
                                  'T',
                                  Fieldbyname('Emisor').asString,
                                  Fieldbyname('Instrumento').asString,
                                  SSerie,
                                  //Fieldbyname('Serie').asString,   DC
                                  Fieldbyname('Nemotecnico').asString,
                                  fValor_Pte_UM_Cpa,
                                  fValor_Pte_MC_Cpa,
                                  fValor_Pte_UM_Cpa,
                                  fValor_Pte_MC_Cpa,
                                  Result,
                                  Reg_Parametros
                                 );
                 if not Result then
                 begin
                    Result := True;
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial + j,
                                              sLogin_Sistema,
                                              sMensaje,
                                              ' Base de Datos : ',
                                              ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO_AD'
                                              ,'99'
                                              );
//                    Next;
                    continue;
                 end;
              end; // Dia + 1 Es solo MERCADO
              *)
              Next;
              Continue;
           end;
           // ******************************************************
           // Termino FORWAD
           // ******************************************************


           // ******************************************************
           // Valorizo los pactos aquí para no ensuciar lo de abajo
           // ******************************************************
           if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PACTO') then
           begin
              if NOT Leer_Tipo_Instrumento_Mem( FieldByName('Instrumento').AsString
                                               ,sTIPO_INSTRUMENTO) then
              begin
                Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                          sProceso,
                                          dFecha_Inicial,
                                          sLogin_Sistema,
                                          sMensaje,
                                          'Leer Instrumento Memory',
                                          'No existe definición de instrumento '+FieldByName('Instrumento').AsString
                                         ,'99'
                                          );
                Next;
                Continue;
              end;

              if (Fieldbyname('Tipo_Instrum').asString = 'R') or
                 (sTIPO_INSTRUMENTO = 'RV')                   then
              begin
                 fValorInvertidoUM_Cpa := Fieldbyname('Porcen_Valor_Par').asFloat;   //Fieldbyname('Valor_Pactado_UM').asFloat;  //ggarcia 05-04-2011
                 fValorInvertidoMC_Cpa := Fieldbyname('Porcen_Valor_Par').asFloat;   //Fieldbyname('Valor_Pactado_MC').asFloat;  //ggarcia 05-04-2011

                 //Valor Pte a Fecha de Cierre
                 fValor_Pte_UM_Cpa    := 0;
                 fValor_Pte_MC_Cpa    := 0;
                 fValor_Pte_UM_Cpa_SC := 0;
                 fValor_Pte_MC_Cpa_SC := 0;
                 fValor_Pte_UM_Mdo_SC := 0;
                 fValor_Pte_MC_Mdo_SC := 0;
                 Reg_Val_Out.Valor_Par_UM := 0;
                 Reg_Val_Out.Valor_Par_MC := 0;
                 Reg_Val_Out.ValorInvertidoUM := 0;
                 Reg_Val_Out.ValorInvertidoMC := 0;
                 Reg_Val_In.Valoriza_Par_Pte  := '';
                 Reg_Val_In.Re_Llamado        := '';
                 Reg_Val_In.Descriptor_Cargado := 'SI';
                 Reg_Val_In.Proceso_Valuacion  := '';
                 Reg_Val_In.Tipo_Instrumento   := Fieldbyname('Tipo_Instrum').asString; // '';  //ggarcia 05-04-2011
                 Reg_Val_In.Tipo_Proceso       := 'B';
                 Reg_Val_In.sEmisor            := '';
                 Reg_Val_In.sSerie             := '';
                 if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                    Reg_Val_In.dFecha_Vig      := 0;
                 Reg_Val_In.Nemotecnico        := '';
                 Reg_Val_In.sInstrumento       := 'OMD_PACTO';
                 Reg_Val_In.sUnidadMonetaria   := Fieldbyname('Moneda_Pacto').asString;
                 Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
                 Reg_Val_In.Tasa_Base_Pacto    := Fieldbyname('Tasa_Base_Pacto').Asstring;
                 Reg_Val_In.dFechaCalculo      := dFecha_Inicial;
                 Reg_Val_In.dFechaVencimiento  := Fieldbyname('Fecha_Vcto_Pacto').asDatetime;
                 Reg_Val_In.dFechaOperacion    := dFecha_Inicial;
                 Reg_Val_Out.TasaCalculo       := FieldByName('Tasa_Pacto').AsFloat;
                 Reg_Val_Out.Valor_Par_UM      := fValorInvertidoUM_Cpa;
                 Reg_Val_Out.Valor_Par_MC      := fValorInvertidoMC_Cpa;
                 Reg_Val_In.Con_Cupon          := True;
                 Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
// cjf
                 Reg_Val_In.dFechaPago           := dFechaPagoAOcupar;

                 Valoriza_Registro(Reg_Val_In,
                                   Reg_Val_Out,

                                   sModulo_Error,
                                   sString_Error,
                                   Result);

                 if NOT Result then
                 begin
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial + j,
                                              sLogin_Sistema,
                                              sMensaje,
                                              sModulo_Error,
                                              sString_Error
                                             ,'10'
                                              );
                    Next;
                    Continue;
                 end;
                 fValor_Pte_UM_Cpa := Reg_Val_Out.ValorInvertidoUM * FieldByName('Valor_Nominal').AsFloat;
                 fValor_Pte_MC_Cpa := Reg_Val_Out.ValorInvertidoMC * FieldByName('Valor_Nominal').AsFloat;
                 fValor_Par_UM     := Reg_Val_Out.Valor_Par_UM * FieldByName('Valor_Nominal').AsFloat;
                 fValor_Par_MC     := Reg_Val_Out.Valor_Par_MC * FieldByName('Valor_Nominal').AsFloat;

                 fDiferencia       := 0; // EN Pactos va en cero

                 Insert_Mercado(Fieldbyname('Empresa').asString,
                                   Fieldbyname('Cartera').asString,
                                   Fieldbyname('Transaccion').asString,
                                   Fieldbyname('Folio_Interno').asString,
                                   Fieldbyname('Item_Omd').asFloat,
                                   Fieldbyname('Nemotecnico').asString,
                                   Fieldbyname('Emisor').asString,
                                   Fieldbyname('Instrumento').asString,
                                   SSerie,
                                   // Fieldbyname('Serie').asString,   DC
                                   Fieldbyname('Moneda_Pacto').asString,
                                   Fieldbyname('Tasa_Emision').asFloat,
                                   Fieldbyname('Fecha_Operacion').asDatetime,//dFecha_Emision,
                                   Fieldbyname('Fecha_Vcto_Pacto').asDatetime,//dFecha_Vencimiento,
                                   dFecha_Inicial,
                                   Fieldbyname('Fecha_Operacion').asDatetime,
                                   FieldByName('Valor_Nominal').AsFloat,
                                   Reg_Val_Out.Valor_Par_UM,
                                   Reg_Val_Out.Valor_Par_MC,
                                   FieldByName('Tasa_Pacto').AsFloat,
                                   fValor_Pte_UM_Cpa,
                                   fValor_Pte_MC_Cpa,
                                   fValor_Pte_UM_Cpa,
                                   fValor_Pte_MC_Cpa,
                                   0,//fPtj_Valor_Par_Mdo,
                                   FieldByName('Tasa_Pacto').AsFloat, //0,//fRate_Used_Valuacion,
                                   0,//fPorcen_Valor_Par,
                                   0,//fDuration,
                                   0,//fDuracion_Modificada,
                                   0,//fConvexidad,
                                   0,//fPlazo_al_Vcto,
                                   fValor_Pte_UM_Cpa,
                                   fValor_Pte_MC_Cpa,
                                   ' ',//sClasif_Riesgo,
                                   ' ',//sTipo_Clasif,
                                   0, //fFactor_Riesgo,
                                   FieldByName('Tasa_Pacto').AsFloat,
                                   fValor_Pte_MC_Cpa,
                                   fValor_Pte_UM_Cpa,
                                   Reg_Val_In.Motivo_Operacion,
                                   fSaldo_Insoluto_Par,
                                   'T',
                                   fValor_Pte_MC_Cpa,
                                   fValor_Pte_MC_Cpa,
                                   dFecha_Last_Cierre,
                                   Result,
                                   Reg_Parametros,
                                   FieldByName('Custodia_Dest').AsString,
                                   0,    //fDuration_Tasa_Emi,
                                   0,   //fDuracion_Modificada_Tasa_Emi
                                   0,   //fNRO_DIVIDENDOS_IMP
                                   fSaldo_Insoluto_UM,
                                   fSaldo_Insoluto_MC,
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   fDiferencia
                                   );
                 if not Result then
                 begin
                    Result := true;
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial,
                                              sLogin_Sistema,
                                              sMensaje,
                                              ' Base de Datos : ',
                                              ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO'
                                             ,'99'
                                              );
                 end;

                 /// Valorizamos al dia siguiete si corresponde MERCADO para la tabla _AD

                   if sImplicancia_Mercado = 'MERCADO' then
                   begin
                     Reg_Val_In.dFechaCalculo      := dFecha_Inicial+1;
                     Reg_Val_In.dFechaOperacion    := dFecha_Inicial+1;

                     Valoriza_Registro(Reg_Val_In,
                                       Reg_Val_Out,
                                       sModulo_Error,
                                       sString_Error,
                                       Result);

                     if NOT Result then
                     begin
                        Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                  sProceso,
                                                  dFecha_Inicial + 1,
                                                  sLogin_Sistema,
                                                  sMensaje,
                                                  sModulo_Error,
                                                  sString_Error
                                                  ,'10'
                                                  );
                        Next;
                        Continue;
                     end;

                     fValor_Pte_UM_Cpa := Reg_Val_Out.ValorInvertidoUM * FieldByName('Valor_Nominal').AsFloat;
                     fValor_Pte_MC_Cpa := Reg_Val_Out.ValorInvertidoMC * FieldByName('Valor_Nominal').AsFloat;

                     Insert_Mercado_Ad(Fieldbyname('Empresa').asString,
                                       Fieldbyname('Cartera').asString,
                                       Fieldbyname('Transaccion').asString,
                                       Fieldbyname('Folio_Interno').asString,
                                       Fieldbyname('Item_Omd').asFloat,
                                       dFecha_Inicial + 1,
                                       FieldByName('Tasa_Pacto').AsFloat,
                                       fValor_Pte_UM_Cpa,
                                       fValor_Pte_MC_Cpa,
                                       0,//fPorcen_Valor_Par_Ini,
                                       FieldByName('Tasa_Pacto').AsFloat,
                                       fValor_Pte_UM_Cpa,
                                       fValor_Pte_MC_Cpa,
                                       0,// fPtj_Valor_Par_Mdo,
                                       FieldByName('Tasa_Pacto').AsFloat,
                                       fValor_Pte_UM_Cpa,
                                       fValor_Pte_MC_Cpa,
                                       'T',
                                       Fieldbyname('Emisor').asString,
                                       Fieldbyname('Instrumento').asString,
                                       SSerie,
                                       //Fieldbyname('Serie').asString,   DC
                                       Fieldbyname('Nemotecnico').asString,
                                       fValor_Pte_UM_Cpa,
                                       fValor_Pte_MC_Cpa,
                                       fValor_Pte_UM_Cpa,
                                       fValor_Pte_MC_Cpa,
                                       Result,
                                       Reg_Parametros
                                      );
                      if not Result then
                      begin
                         Result := True;
                         Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                   sProceso,
                                                   dFecha_Inicial + j,
                                                   sLogin_Sistema,
                                                   sMensaje,
                                                   ' Base de Datos : ',
                                                   ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO_AD'
                                                   ,'99'
                                                   );
//                         Next;
                         continue;
                      end;
                   end; // Dia + 1 Es solo MERCADO

                 Next;
                 Continue;
              end;    //if (Fieldbyname('Tipo_Instrum').asString = 'R') or (sTIPO_INSTRUMENTO = 'RV')  then

              for j := 0 to 1 do
              begin
                 // Día + 1 Sólo Mercado
                 if (sImplicancia_Mercado <> 'MERCADO') and
                    (j = 1) then // Día despues
                    Break;

                 //Determino Valor del Pacto Porque
                 //los Pactos Cargados Desde BACK en USD no quedan correctos
                 fValorInvertidoUM_Cpa := Fieldbyname('Valor_Pactado_UM').asFloat;
                 fValorInvertidoMC_Cpa := Fieldbyname('Valor_Pactado_MC').asFloat;

                 //Valor Pte a Fecha de Cierre
                 fValor_Pte_UM_Cpa    := 0;
                 fValor_Pte_MC_Cpa    := 0;
                 fValor_Pte_UM_Cpa_SC := 0;
                 fValor_Pte_MC_Cpa_SC := 0;
                 fValor_Pte_UM_Mdo_SC := 0;
                 fValor_Pte_MC_Mdo_SC := 0;
                 Reg_Val_Out.Valor_Par_UM      := 0;
                 Reg_Val_Out.Valor_Par_MC      := 0;
                 Reg_Val_Out.ValorInvertidoUM  := 0;
                 Reg_Val_Out.ValorInvertidoMC  := 0;
                 Reg_Val_In.Valoriza_Par_Pte   := '';
                 Reg_Val_In.Re_Llamado         := '';
                 Reg_Val_In.Descriptor_Cargado := 'SI';
                 Reg_Val_In.Proceso_Valuacion  := '';
                 Reg_Val_In.Tipo_Instrumento   := '';
                 Reg_Val_In.Tipo_Proceso       := 'B';
                 Reg_Val_In.sEmisor            := '';
                 Reg_Val_In.sSerie             := '';
                 if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                    Reg_Val_In.dFecha_Vig        := 0;
                 Reg_Val_In.Nemotecnico        := '';
                 Reg_Val_In.sInstrumento       := 'OMD_PACTO';
                 Reg_Val_In.sUnidadMonetaria   := Fieldbyname('Moneda_Pacto').asString;
                 Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
                 Reg_Val_In.Tasa_Base_Pacto    := Fieldbyname('Tasa_Base_Pacto').Asstring;
                 Reg_Val_In.dFechaCalculo      := (dFecha_Inicial + j);
                 Reg_Val_In.dFechaVencimiento  := Fieldbyname('Fecha_Vcto_Pacto').asDatetime;
                 Reg_Val_In.dFechaOperacion    := (dFecha_Inicial + j);
                 Reg_Val_Out.TasaCalculo       := FieldByName('Tasa_Pacto').AsFloat;
                 Reg_Val_Out.Valor_Par_UM      := fValorInvertidoUM_Cpa;
                 Reg_Val_Out.Valor_Par_MC      := fValorInvertidoMC_Cpa;
                 Reg_Val_In.Con_Cupon          := True;
                 Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
// cjf
                 Reg_Val_In.dFechaPago           := dFechaPagoAOcupar;

                 Valoriza_Registro(Reg_Val_In,
                                   Reg_Val_Out,
                                   sModulo_Error,
                                   sString_Error,
                                   Result);

                 if NOT Result then
                 begin
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial + j,
                                              sLogin_Sistema,
                                              sMensaje,
                                              sModulo_Error,
                                              sString_Error
                                              ,'10'
                                              );
//                    Next;
                    Continue;
                 end;
                 fValor_Pte_UM_Cpa := Reg_Val_Out.ValorInvertidoUM;
                 fValor_Pte_MC_Cpa := Reg_Val_Out.ValorInvertidoMC;

                 // Esto es solo para el caso de los pactos
                 // El Porcen_Valor_PAR que se usa es el registrado en la OMD

                 fPorcen_Valor_Par := FieldByName('Porcen_Valor_PAR').AsFloat;

                 fValor_Pte_UM_Cpa_SC := fValor_Pte_UM_Cpa;
                 fValor_Pte_MC_Cpa_SC := fValor_Pte_MC_Cpa;
                 fValor_Pte_UM_Mdo_SC := fValor_Pte_UM_Cpa;
                 fValor_Pte_MC_Mdo_SC := fValor_Pte_MC_Cpa;
                 if (Reg_Val_In.dFechaCalculo = Fieldbyname('Fecha_Vcto_Pacto').asDatetime) then
                 begin
                     fValor_Pte_UM_Cpa_SC := 0;
                     fValor_Pte_MC_Cpa_SC := 0;
                     fValor_Pte_UM_Mdo_SC := 0;
                     fValor_Pte_MC_Mdo_SC := 0;
                 end;
                 Reg_Val_In.Motivo_Operacion := Busca_Motivo_Mem(FieldByName('Empresa').AsString
                                                                ,FieldByName('Transaccion').AsString
                                                                ,FieldByName('Folio_Interno').AsString
                                                                ,FieldByName('Item_Omd').AsFloat
                                                                ,dFecha_Inicial);

                  if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                     Reg_Val_In.Proceso_Valuacion := 'MDO-DERIVA'  // Nuevo !!!!
                  else
                     Reg_Val_In.Proceso_Valuacion := 'MERCADO';
                  Reg_Val_in.Tipo_proceso         := 'GESTION';
                  Reg_Val_In.Valoriza_Par_Pte     := 'VAL';
                  Reg_Val_In.Descriptor_Cargado   := 'NO';
                  Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
                  Reg_Val_In.Tasa_Compra          := FieldByName('Tasa_Mercado').AsFloat;
                  Reg_Val_In.Cartera              := FieldByName('Cartera').AsString;
                  Reg_Val_In.Emision_Implicita    := FieldByName('Emision_Implicita').AsString;
                  Reg_Val_In.Tipo_Instrumento   := FieldByName('Tipo_Instrum').AsString;
                  Reg_Val_In.sEmisor            := FieldByName('Emisor').AsString;
                  Reg_Val_In.sInstrumento       := FieldByName('Instrumento').AsString;
                  Reg_Val_In.sSerie             := FieldByName('Serie').AsString;
                  if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                     Reg_Val_In.dFecha_Vig        := dFecha_Inicial;   //FieldByName('Fecha_Vig').AsDatetime;
                  Reg_Val_In.Nemotecnico        := Fieldbyname('Nemotecnico').asString;
                  Reg_Val_In.dTasaEmision       := FieldByName('Tasa_Emision').AsFloat;
                  Reg_Val_In.sUnidadMonetaria   := FieldByName('Moneda_Instrum').AsString;
                  Reg_Val_In.sTipoNominales     := FieldByName('Tipo_Nominales').AsString;
                  Reg_Val_In.dFechaEmision      := FieldByName('Fecha_Emision').asdatetime;
                  Reg_Val_In.dFechaVencimiento  := FieldByName('Fecha_Vencimiento').asdatetime;
                  Reg_Val_In.dFechaCompra       := FieldByName('Fecha_Operacion').AsDatetime;
                  Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
// cjf
                  Reg_Val_In.dFechaPago           := dFechaPagoAOcupar;
                  Reg_Val_In.dFechaCalculo      := dFecha_Inicial + j;
                  Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
                  Reg_Val_Out.Nominales         := Fieldbyname('Valor_Nominal').asFloat;
                  Reg_Val_Out.TasaCalculo         := FieldByName('Tasa_Mercado').AsFloat;
                  reg_val_out.Rate_Used_Valuacion := 0;
                  Reg_Val_Out.PorcentajePar     := 0;
                  Reg_Val_Out.ValorInvertidoUM  := 0;
                  Reg_Val_Out.ValorInvertidoMC  := 0;
                  Reg_Val_Out.Valor_Par_UM      := 0;
                  Reg_Val_Out.Valor_Par_MC      := 0;
                  Reg_Val_Out.fValor_Final_UM   := 0;
                  Reg_Val_Out.Valor_Par_Base    := 0;
                  Reg_Val_Out.Result_Inst_Vencido := False;

                  // Se cambia a pais del usuario, esto se determino con DQ en Noviembre del 2004
                  // ya que no depende del pais del emisor sino de donde se transa.
                  Reg_Val_In.Pais_Titulo := sPais_Usuario;

                  {
                  fItem_Dir_Emisor       := default_direccion_Mem(Reg_Val_In.sEmisor ,Reg_Val_In.dFechaCalculo);
                  sCodigo_Geo_Emisor     := Codigo_Geo_IdDir_Mem(Reg_Val_In.sEmisor ,fItem_Dir_Emisor);

                  Reg_Val_In.Pais_Titulo := Pais_Para_CodGeo_mem(sCodigo_Geo_Emisor);

                  if Reg_Val_In.Pais_Titulo = '' then
                     Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                               sProceso,
                                               dFecha_Inicial + J,
                                               sLogin_Sistema,
                                               sMensaje,
                                               'Dirección, Pais Emisor :',
                                               ' Error en dirección('+FloatToStr(fItem_Dir_Emisor)+ '), Emisor: '
                                               + Reg_Val_In.sEmisor+'.'
                                               +' No se Encuentra país para Dirección. '
                                               );
                  }

                  Reg_Val_In.Motivo_Operacion := Busca_Motivo_Mem(FieldByName('Empresa').AsString
                                                                 ,FieldByName('Transaccion').AsString
                                                                 ,FieldByName('Folio_Interno').AsString
                                                                 ,FieldByName('Item_Omd').AsFloat
                                                                 ,dFecha_Inicial+j);

                  if (trim(Reg_Val_In.Motivo_Operacion) = '') or
                     (Reg_Val_In.Motivo_Operacion = NULL)     then
                  begin
                    // Obtiene Sistema para buscar default
                    Result := Datos_Transaccion_Mem(FieldByName('Transaccion').AsString
                                                    ,sRelacion
                                                    ,sSistema
                                                    ,sDescripcion
                                                    ,sModulo_Error
                                                    ,sString_Error);
                    if Not Result then
                    begin
                        Result := True;
                        Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                  sProceso,
                                                  dFecha_Inicial,
                                                  sLogin_Sistema,
                                                  sMensaje,
                                                  sModulo_Error,
                                                  sString_Error
                                                  ,'99'
                                                  );
//                        Next;
                        Continue;
                    end;
                    Reg_Val_In.Motivo_Operacion := default_codgen_Mem('MOTINV'
                                                                     ,sSistema
                                                                     ,FieldByName('Transaccion').AsString);
                  end;

                  Busca_Valuacion_Mem ( Reg_Val_In,
                                        sTipo_Valuac,
                                        sFormula_Pte,
                                        fBase_Precio,
                                        sMon_Ind,
                                        sOrigen,
                                        bValuacion
                                        );

                  if bValuacion then
                  begin
                     // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 08/09/2005
                     if FieldByName('Valor_Nominal').AsFloat <> 0 then
                        Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                        FieldByName('Valor_Invertido_UM').AsFloat /
                                                        FieldByName('Valor_Nominal').AsFloat;

                     Valoriza_Registro(Reg_Val_In,
                                       Reg_Val_Out,
                                       sModulo_Error,
                                       sString_Error,
                                       Result);

                  end;
                  if NOT Result then
                  begin
                    Result := True;
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial + j,
                                              sLogin_Sistema,
                                              sMensaje,
                                              sModulo_Error +' (Mdo)',
                                              sString_Error
                                              ,'10'
                                              );
                    // Lo siguiente es para que en los titulos de tasa flotante
                    // extranjeros si no puede valorizar a mercado, deje el valor PAR
                    // deje el buscar el pais del emisor dentro del IF para
                    // que no afecte a los titulos que no son tasa flotante
                    // F.I. para Normativa 1360
                    if (Transaccion_Implica('NOVALTFLOT','VALOR_PAR')) and
                       (Reg_Val_Out.RegDes.TASA_FLOTANTE = 'S') then
                    begin
                      fItem_Dir_Emisor       := default_direccion_Mem(Reg_Val_In.sEmisor ,Reg_Val_In.dFechaCalculo);
                      sCodigo_Geo_Emisor     := Codigo_Geo_IdDir_Mem(Reg_Val_In.sEmisor ,fItem_Dir_Emisor);

                      Reg_Val_In.Pais_Titulo := Pais_Para_CodGeo_mem(sCodigo_Geo_Emisor);

                      if Reg_Val_In.Pais_Titulo = '' then
                      begin
                         Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                   sProceso,
                                                   dFecha_Inicial + J,
                                                   sLogin_Sistema,
                                                   sMensaje,
                                                   'Dirección, Pais Emisor :',
                                                   ' Error en dirección('+FloatToStr(fItem_Dir_Emisor)+ '), Emisor: '
                                                   + Reg_Val_In.sEmisor+'.'
                                                   +' No se Encuentra país para Dirección. (Tasa Flotante)'
                                                   ,'99'
                                                   );
                         // Como no se si es nacional o extranjero lo dejo los valores de mercado en 0
                         fValor_Pte_UM_Mdo    := 0;
                         fValor_Pte_MC_Mdo    := 0;
                      end
                      else
                      begin
                         // si es titulo extranjero en valor de mercado queda el valor PAR
                         if (Reg_Val_In.Pais_Titulo <> sPais_Usuario) then
                         begin
                           fValor_Pte_UM_Mdo    := Reg_Val_Out.Valor_Par_UM;
                           fValor_Pte_MC_Mdo    := Reg_Val_Out.Valor_Par_MC;
                         end
                         else
                         // si es titulo nacionalen valor de mercado queda el valor PAR
                         begin
                           fValor_Pte_UM_Mdo    := fValor_Pte_UM_Cpa;
                           fValor_Pte_MC_Mdo    := fValor_Pte_MC_Cpa;
                         end;
                      end;
                    end
                    else
                    // si no tiene la implicancia 'NOVALTFLOT','VALOR_PAR'
                    // y no pudo determinar valor de mercado le deja el valor presente
                    begin
                      fValor_Pte_UM_Mdo    := fValor_Pte_UM_Cpa;
                      fValor_Pte_MC_Mdo    := fValor_Pte_MC_Cpa;
                    end;
                    fRate_Used_Valuacion := Fieldbyname('Tasa_Mercado').asFloat;
                    fPtj_Valor_Par_Mdo   := fPorcen_Valor_Par;
                  end
                  else
                  begin
                    fValor_Pte_UM_Mdo    := Reg_Val_Out.ValorInvertidoUM;
                    fValor_Pte_MC_Mdo    := Reg_Val_Out.ValorInvertidoMC;
                    fPtj_Valor_Par_Mdo   := Reg_Val_Out.PorcentajePar   ;

                    // 09-05-2008 G.G. & F.I.   La tasa de mercado en cero es valida
                    // Solo si no existe es un error y ese se controla mas arriba.
                    if ( bValuacion ) then
                    //   ( Reg_val_out.Rate_Used_Valuacion <> 0) then
                       fRate_Used_Valuacion := Reg_val_out.Rate_Used_Valuacion
                    else
                    begin
                       fRate_Used_Valuacion := Fieldbyname('Tasa_Mercado').asFloat;
                       fValor_Pte_UM_Mdo    := fValor_Pte_UM_Cpa;
                       fValor_Pte_MC_Mdo    := fValor_Pte_MC_Cpa;
                       fPtj_Valor_Par_Mdo   := 0;
                    end;
                 end;
                 sNemotecnico       := Reg_Val_In.Nemotecnico;
                 dFecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
                 dFecha_Emision     := Reg_Val_In.dFechaEmision;

                 if j = 0 then
                 begin
                    fPlazo_Al_Vcto := 0;
                    if FieldByName('Tipo_Instrumento').AsString = 'RF' Then
                       fPlazo_Al_Vcto := (dFecha_Vencimiento
                                          -
                                          dFecha_Inicial + j )
                                         / StrToFloat( '365'+DecimalSeparator+'25');

                    // Busca Clasif. Risego x Nemotecnico
                    sClasif_Riesgo := '';
                    Busca_Clasif_Riesgo_Nem(FieldByName('Nemotecnico').AsString
                                           ,dFecha_Inicial + j
                                           ,sClasif_Riesgo
                                           ,sTipo_Clasif
                                           );
                    if (sClasif_Riesgo = '') or (sClasif_Riesgo = null) THEN
                       Busca_Clasif_Riesgo_Mem(FieldByName('Emisor').AsString
                                              ,FieldByName('Instrumento').AsString
                                              ,FieldByName('Serie').AsString
                                              ,dFecha_Inicial + j
                                              ,False
                                              ,default_codgen('AGENCIACLA','FI','')
                                              ,sClasif_Riesgo
                                              ,fFactor_Riesgo
                                              ,sEmisor_Pagador
                                              ,sTipo_Clasif);
                    if ((sClasif_Riesgo = '') AND
                        NOT bImplicancia_Omite_Error_Clasif_Riesgo) then
                    begin
                        Existe_param_proceso( 'VALORIZA'
                                             ,'INSSINCLA'
                                             ,FieldByName('Instrumento').AsString
                                             ,Result);
                        if NOT Result then
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                     sProceso,
                                                     dFecha_Inicial,
                                                     sLogin_Sistema,
                                                     // OJO: Se reemplaza el mesaje por el caso de Emisor Pagador
                                                     ' Folio : ' + FieldByName('Folio_Interno').AsString
                                                     +' - '
                                                     +' Item : ' + FieldByName('Item_Omd').AsString
                                                     +' - '
                                                     +sEmisor_Pagador
                                                     +' - '
                                                     +FieldByName('Instrumento').AsString
                                                     +' - '
                                                     +FieldByName('Serie').AsString
                                                     +' - '
                                                     +FieldByName('Nemotecnico').AsString,
                                                     'Clasificación de Riesgo',
                                                     'No Existe Clasificación de Riesgo Vigente',
                                                     '30'
                                                     );
                    end;

                    //Determino Valor Final SVS
                    sVALORIZACION := '';
                    Busca_Valor_Super_Mem( 'SVS',
                                          FieldByName('Empresa').AsString,
                                          FieldByName('Cartera').AsString,
                                          Reg_Val_In.Pais_Titulo,
                                          FieldByName('Emisor').AsString,
                                          FieldByName('Instrumento').AsString,
                                          FieldByName('Serie').AsString,
                                          Reg_Val_In.Motivo_Operacion,
                                          sVALORIZACION
                                          );
                    if sVALORIZACION = '' then // Si no hay definición lo dejo a COMPRA
                       sVALORIZACION := 'COMPRA';

                    if sVALORIZACION = 'COMPRA'  then
                    begin
                        fValor_Final_SVS_UM  := fValor_Pte_UM_Cpa;
                        fValor_Final_SVS_MC  := fValor_Pte_MC_Cpa;
                    end
                    else
                    begin
                        fValor_Final_SVS_UM  := fValor_Pte_UM_Mdo;
                        fValor_Final_SVS_MC  := fValor_Pte_MC_Mdo;
                    end;

                    fDiferencia := fValor_Pte_MC_Mdo - fValor_Pte_MC_Cpa;

                    if NOT Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PENDIENTE') and
                       //( NOT bValorizando_Stock_Parcial) then
                       ( NOT Reg_Parametros.bSolo_Stock)         then
                       Insert_Mercado(Fieldbyname('Empresa').asString,
                                      Fieldbyname('Cartera').asString,
                                      Fieldbyname('Transaccion').asString,
                                      Fieldbyname('Folio_Interno').asString,
                                      Fieldbyname('Item_Omd').asFloat,
                                      sNemotecnico,
                                      Fieldbyname('Emisor').asString,
                                      Fieldbyname('Instrumento').asString,
                                      SSerie,
                                      //Fieldbyname('Serie').asString, DC
                                      Fieldbyname('Moneda_Instrum').asString,
                                      Fieldbyname('Tasa_Emision').asFloat,
                                      dFecha_Emision,
                                      dFecha_Vencimiento,
                                      dFecha_Inicial + j,
                                      Fieldbyname('Fecha_Operacion').asDatetime,
                                      FieldByName('Valor_Nominal').AsFloat,
                                      Reg_Val_Out.Valor_Par_UM,
                                      Reg_Val_Out.Valor_Par_MC,
                                      FieldByName('Tasa_Pacto').AsFloat,
                                      //fTasa_Compra_Utilizada,
                                      //FieldByName('Tasa_Mercado').AsFloat, 15-11-05 F.I.-
                                      fValor_Pte_UM_Cpa,
                                      fValor_Pte_MC_Cpa,
                                      fValor_Pte_UM_Mdo,
                                      fValor_Pte_MC_Mdo,
                                      fPtj_Valor_Par_Mdo,
                                      fRate_Used_Valuacion,
                                      fPorcen_Valor_Par,
                                      fDuration,
                                      fDuracion_Modificada,
                                      fConvexidad,
                                      fPlazo_al_Vcto,
                                      fValor_Final_SVS_UM,
                                      fValor_Final_SVS_MC,//fValor_Final_SVS,
                                      sClasif_Riesgo,
                                      sTipo_Clasif,
                                      fFactor_Riesgo,
                                      fRate_Used_Valuacion,
                                      fValor_Pte_MC_Mdo,
                                      fValor_Pte_UM_Mdo,
                                      Reg_Val_In.Motivo_Operacion,
                                      fSaldo_Insoluto_Par,
                                      'T',
                                      fValor_Pte_MC_Cpa,
                                      fValor_Pte_MC_Mdo,
                                      dFecha_Last_Cierre,
                                      Result,
                                      Reg_Parametros,
                                      sCustodia_Dest,
                                      fDuration_Tasa_Emi,
                                      fDuration_Modificada_Tasa_Emi,
                                      0, //fNRO_DIVIDENDOS_IMP
                                      fSaldo_Insoluto_UM,
                                      fSaldo_Insoluto_MC,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      fDiferencia
                                     );
                     if not Result then
                     begin
                        Result := true;
                        Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                  sProceso,
                                                  dFecha_Inicial + j,
                                                  sLogin_Sistema,
                                                  sMensaje,
                                                  ' Base de Datos : ',
                                                  ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO'
                                                 ,'99'
                                                  );
//                        Next;
                        continue;
                     end;

                     // Inserto Compra con Pacto en STOCK
                     if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'COMPRA') then
                     begin
                        sCustodia_Dest := Custodia_Actual_Mem( FieldByName('Empresa').AsString,
                                                               FieldByName('Transaccion').AsString,
                                                               FieldByName('Folio_interno').AsString,
                                                               FieldByName('Item_OMD').AsFloat
                                                             );
                        if Trim( sCustodia_Dest ) = '' then
                           sCustodia_Dest := FieldByName('Custodia_Dest').AsString;

                        if dFecha_Stock <> (dFecha_Inicial + j ) then
                           dFecha_Stock := dFecha_Inicial + j;

                        Inserta_Registro_Stock(FieldByName('Empresa').AsString,
                                               FieldByName('Transaccion').AsString,
                                               FieldByName('Folio_interno').AsString,
                                               FieldByName('Item_OMD').AsFloat,
                                               FieldByName('Fecha_Operacion').AsDateTime,
                                               dFecha_Inicial + j,
                                               Fieldbyname('Nemotecnico').asString,
                                               FieldByName('Emisor').AsString,
                                               FieldByName('Instrumento').AsString,
                                               SSerie,
                                             //  FieldByName('Serie').AsString,  DC
                                               FieldByName('Fecha_Emision').AsDateTime,
                                               FieldByName('Fecha_Vencimiento').AsDateTime,
                                               FieldByName('Valor_Nominal').AsFloat,
                                               FieldByName('Valor_Nominal').AsFloat,
                                               FieldByName('Tasa_Emision').AsFloat,
                                               FieldByName('Tasa_Mercado').AsFloat,
                                               FieldByName('Moneda_Instrum').AsString,
                                               FieldByName('Tasa_Base_Par').AsString,
                                               FieldByName('Tasa_Base_Pte').AsString,
                                               fValor_Pte_UM_Cpa,
                                               fValor_Pte_MC_Cpa,
                                               fPorcen_Valor_Par,
                                               FieldByName('Cartera'      ).AsString,
                                               FieldByName('Moneda_Pacto').AsString,
                                               FieldByName('Tasa_pacto'  ).AsFloat,
                                               FieldByName('Tasa_Base_Pacto').AsString,
                                               FieldByName('Fecha_Vcto_Pacto').AsDateTime,
                                               FieldByName('Tipo_Nominales').AsString,
                                               sCustodia_Dest,
                                               fPlazo_Al_Vcto,
                                               FieldByName('Tipo_Instrum').AsString,
                                               fValor_Pte_UM_Mdo,
                                               fValor_Pte_MC_Mdo,
                                               fRate_Used_Valuacion,
                                               fDuration,
                                               ' ',
                                               (fValor_Pte_MC_Mdo - fValor_Pte_MC_Cpa),
                                               fValor_Pte_MC_Mdo,
                                               fRate_Used_Valuacion,
                                               Reg_Val_In.Motivo_Operacion,
                                               sClasif_Riesgo,
                                               iCupones_cortados,
                                               Reg_Val_Out.Valor_Par_UM,
                                               Reg_Val_Out.Valor_Par_MC,
                                               fSaldo_Insoluto_UM,
                                               fSaldo_Insoluto_MC,
                                               Result);
                        if not Result then
                        begin
                           Result := True;
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                     sProceso,
                                                     dFecha_Inicial,
                                                     sLogin_Sistema,
                                                     sMensaje,
                                                     ' Base de Datos : ',
                                                     ' Error al Insertar Registro en Tabla Temporal QS_TRA_OMD_STK_RF'
                                                      ,'99'
                                                     );
//                           Next;
                           continue;
                        end;
                     end;

                     if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                     begin
                        Insert_ERP_CXP(Fieldbyname('Empresa').asString,
                                          Fieldbyname('Cartera').asString,
                                          Fieldbyname('Transaccion').asString,
                                          Fieldbyname('Folio_Interno').asString,
                                          Fieldbyname('Item_Omd').asFloat,
                                          Fieldbyname('Contraparte').asString,
                                          Fieldbyname('Contraparte_Dir').asFloat,
                                          Fieldbyname('Nemotecnico').asString,
                                          Fieldbyname('Emisor').asString,
                                          Fieldbyname('Instrumento').asString,
                                          SSerie,
                                          // Fieldbyname('Serie').asString,   DC
                                          Fieldbyname('Moneda_Pacto').asString,
                                          Fieldbyname('Tasa_Emision').asFloat,
                                          Fieldbyname('Fecha_Operacion').asDatetime,//dFecha_Emision,
                                          Fieldbyname('Fecha_Vcto_Pacto').asDatetime,//dFecha_Vencimiento,
                                          dFecha_Inicial,
                                          Fieldbyname('Fecha_de_Pago').asDatetime,
                                          Fieldbyname('Fecha_Operacion').asDatetime,
                                          FieldByName('Valor_Nominal').AsFloat,
                                          Reg_Val_Out.Valor_Par_UM,
                                          Reg_Val_Out.Valor_Par_MC,
                                          FieldByName('Tasa_Pacto').AsFloat,
                                          fValor_Pte_UM_Cpa,
                                          fValor_Pte_MC_Cpa,
                                          fValor_Pte_UM_Cpa,
                                          fValor_Pte_MC_Cpa,
                                          0,//fPtj_Valor_Par_Mdo,
                                          FieldByName('Tasa_Pacto').AsFloat, //0,//fRate_Used_Valuacion,
                                          0,//fPorcen_Valor_Par,
                                          0,//fDuration,
                                          0,//fDuracion_Modificada,
                                          0,//fConvexidad,
                                          0,//fPlazo_al_Vcto,
                                          fValor_Pte_UM_Cpa,
                                          fValor_Pte_MC_Cpa,
                                          ' ',//sClasif_Riesgo,
                                          0, //fFactor_Riesgo,
                                          FieldByName('Tasa_Pacto').AsFloat,
                                          fValor_Pte_MC_Cpa,
                                          fValor_Pte_UM_Cpa,
                                          Reg_Val_In.Motivo_Operacion,
                                          fSaldo_Insoluto_Par,
                                          'T',
                                          fValor_Pte_MC_Cpa,
                                          fValor_Pte_MC_Cpa,
                                          dFecha_Last_Cierre,
                                          Result,
                                          Reg_Parametros,
                                          FieldByName('Custodia_Dest').AsString,
                                          0,    //fDuration_Tasa_Emi,
                                          0,   //fDuracion_Modificada_Tasa_Emi
                                          0,   //fNRO_DIVIDENDOS_IMP
                                          fSaldo_Insoluto_UM,
                                          fSaldo_Insoluto_MC,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          ''
                                          );
                        if not Result then
                        begin
                           Result := true;
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                     sProceso,
                                                     dFecha_Inicial,
                                                     sLogin_Sistema,
                                                     sMensaje,
                                                     ' Base de Datos : ',
                                                     ' Error al Insertar Registro en Tabla ETLODSQS20'
                                                    ,'99'
                                                     );
                        end;
                     end;
                 end
                 else // j = 1
                 begin
                   // Dia + 1 Es solo MERCADO
                   if sImplicancia_Mercado = 'MERCADO' then
                   begin
                    if NOT Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PENDIENTE') and
                      //( NOT bValorizando_Stock_Parcial) then
                      (NOT Reg_Parametros.bSolo_Stock)         then
                      Insert_Mercado_Ad(Fieldbyname('Empresa').asString,
                                        Fieldbyname('Cartera').asString,
                                        Fieldbyname('Transaccion').asString,
                                        Fieldbyname('Folio_Interno').asString,
                                        Fieldbyname('Item_Omd').asFloat,
                                        dFecha_Inicial + j,
                                        FieldByName('Tasa_Pacto').AsFloat,
                                        fValor_Pte_UM_Cpa,
                                        fValor_Pte_MC_Cpa,
                                        0,//fPorcen_Valor_Par_Ini,
                                        FieldByName('Tasa_Pacto').AsFloat,
                                        fValor_Pte_UM_Mdo,
                                        fValor_Pte_MC_Mdo,
                                        fPtj_Valor_Par_Mdo,
                                        FieldByName('Tasa_Pacto').AsFloat,
                                        fValor_Pte_UM_Mdo,
                                        fValor_Pte_MC_Mdo,
                                        'T',
                                        Fieldbyname('Emisor').asString,
                                        Fieldbyname('Instrumento').asString,
                                        SSerie,
                                   //     Fieldbyname('Serie').asString,  DC
                                        sNemotecnico,
                                        fValor_Pte_UM_Cpa_SC,
                                        fValor_Pte_MC_Cpa_SC,
                                        fValor_Pte_UM_Mdo_SC,
                                        fValor_Pte_MC_Mdo_SC,
                                        Result,
                                        Reg_Parametros
                                       );
                      if not Result then
                      begin
                         Result := True;
                         Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                   sProceso,
                                                   dFecha_Inicial + j,
                                                   sLogin_Sistema,
                                                   sMensaje,
                                                   ' Base de Datos : ',
                                                   ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO_AD'
                                                   ,'99'
                                                   );
//                         Next;
                         continue;
                      end;
                   end; // Dia + 1 Es solo MERCADO
                end;
              end;
              Reg_Val_In.Descriptor_Cargado   := 'NO';
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
              Reg_Val_In.Proceso_Valuacion    := '';
              Reg_Val_In.Valoriza_Par_Pte     := '';
              Reg_Val_In.Cartera              := '';
              Reg_Val_In.Emision_Implicita    := '';
              Reg_Val_In.Tipo_Instrumento   := '';
              Reg_Val_In.sEmisor            := '';
              Reg_Val_In.sInstrumento       := '';
              Reg_Val_In.sSerie             := '';
              if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                 Reg_Val_In.dFecha_Vig        := 0;
              Reg_Val_In.Nemotecnico        := '';
              Reg_Val_In.dTasaEmision       := 0;
              Reg_Val_In.sUnidadMonetaria   := '';
              Reg_Val_In.sTipoNominales     := '';
              Reg_Val_In.dFechaEmision      := 0;
              Reg_Val_In.dFechaVencimiento  := 0;
              Reg_Val_In.dFechaCompra       := 0;
              Reg_Val_In.dFechaCalculo      := 0;
              Reg_Val_In.dFechaPago         := 0;
              Reg_Val_In.sMoneda_Conversion := '';
//              Reg_Val_In.Spread             := 0;
              Reg_Val_Out.Nominales         := 0;
              Reg_Val_Out.TasaCalculo       := 0;
              reg_val_out.Rate_Used_Valuacion := 0;
              Reg_Val_Out.PorcentajePar     := 0;
              Reg_Val_Out.ValorInvertidoUM  := 0;
              Reg_Val_Out.ValorInvertidoMC  := 0;
              Reg_Val_Out.Valor_Par_UM      := 0;
              Reg_Val_Out.Valor_Par_MC      := 0;
              Reg_Val_Out.fValor_Final_UM   := 0;
              Reg_Val_Out.Valor_Par_Base    := 0;
              Reg_Val_Out.Result_Inst_Vencido := False;
              Next;
              Continue;
           end;
           // ******************************************************
           // Termino PACTOS
           // ******************************************************


           // Determino si Hay tipo de cambio al D + 1 de la moneda Instrum
           if (sImplicancia_Mercado = 'MERCADO') then
           begin
              leer_valor_cambio2(  Fieldbyname('Moneda_Instrum').asString
                                  ,sMoneda_Conversion
                                  ,'BC'
                                  ,dFecha_Inicial + 1
                                  ,fValor_Paridad
                                  ,bExiste_Paridad
                                );
              if (NOT bExiste_Paridad) and
                 (dFecha_Inicial+1 > dFecha_Hora_Servidor) then //GGARCIA 18/07/2005 - Se cargan siempre y cuando se este buscando el valor de cambio a una fecha mayor a la de hoy.
              begin
                 leer_valor_cambio2(  Fieldbyname('Moneda_Instrum').asString
                                     ,sMoneda_Conversion
                                     ,'BC'
                                     ,dFecha_Inicial
                                     ,fValor_Paridad
                                     ,bExiste_Paridad
                                   );
                 if bExiste_Paridad then
                     Carga_Tipo_Cambio_Fijo_Mem(  FieldByName('Moneda_Instrum').AsString
                                                 ,sMoneda_Conversion
                                                 ,dFecha_Inicial + 1
                                                 ,fValor_Paridad
                                                 );
              end;
           end;
           sNemotecnico          := FieldByName('Nemotecnico').AsString;
           dFecha_Emision        := FieldByName('Fecha_Emision').AsDateTime;
           dFecha_Vencimiento    := FieldByName('Fecha_Vencimiento').AsDateTime;
           fNominales_Vigentes   := FieldByName('Valor_Nominal').AsFloat;


           Determina_Nominales_Vendidos_Mem(dFecha_Inicial,
                                            dFecha_Hora_Servidor,
                                            dFecha_Inicial,
                                            Fieldbyname('Empresa').asString,
                                            Fieldbyname('Transaccion').asString,
                                            Fieldbyname('Folio_Interno').asString,
                                            Fieldbyname('Item_Omd').asFloat,
                                            fNominales_Vendidos,
                                            fNominales_Vendidos_Reales,
                                            fNominales_Ventas_Dia);

           Determina_Nominales_Pactados_Mem(dFecha_Inicial,
                                            dFecha_Libera_Pacto,//dfecha_Hora_Servidor,
                                            Fieldbyname('Empresa').asString,
                                            Fieldbyname('Transaccion').asString,
                                            Fieldbyname('Folio_Interno').asString,
                                            Fieldbyname('Item_Omd').asFloat,
                                            fNominales_Pactados,
                                            fNominales_Pactados_Reales);

           fNominales_Reales :=            Fieldbyname('Valor_Nominal').asFloat-
                                           fNominales_Vendidos_Reales-
                                           fNominales_Pactados_Reales;

           Aux_fNominales_Reales := StrToFloat(FormatFloat('##########.00000' ,
                                           fNominales_Reales));

           // Lo siguiente se agrego ya que se dio en una compañia (BiceVida)
           // el redondeo de arriba no funciono y aparecio el error por una diferencia despues del 5 decimal.
           // ES & FI 02-02-2007
           if (ABS(Aux_fNominales_Reales) < 0.00001) then
              fNominales_Reales := 0;

           if (fNominales_Vendidos + fNominales_Pactados) =  0 then
               fNominales_Ventas_Dia := 0;


// Titulos Vigentes Actual
           Reg_Val_In.Numero_Titulos   := 0;
           if bExiste_Tabla_Det_PP then
           begin
              fTitulos_Vigentes := Numero_Titulos(sEmpresa_Usuario
                                                 ,FieldByName('Transaccion'  ).AsString
                                                 ,FieldByName('Folio_Interno').AsString
                                                 ,FieldByName('Item_Omd'     ).AsFloat);

              if fTitulos_Vigentes <> 0 then
              begin
                 fTitulos_Vigentes := fTitulos_Vigentes -
                                      Determina_Titulos_Vendidos(sEmpresa_Usuario
                                                                ,FieldByName('Transaccion'  ).AsString
                                                                ,FieldByName('Folio_Interno').AsString
                                                                ,FieldByName('Item_Omd'     ).AsFloat
                                                                ,dFecha_Inicial);
                 Reg_Val_In.Numero_Titulos         := fTitulos_Vigentes;
              end;
           end;

           //Verifico si esta todo pactado debo valorizar
           bTodo_Pactado := False;

           // No econtramos sentido a la diferencia si es que tiene implicancia MERCADO
           // G.G. & F.I. (tema vencimiento de cupones)
           {
           if sImplicancia_Mercado = 'MERCADO' then
           begin
               // Eduardo elimine el valor absoluto ya que no le encuentro sentido
               // un valor negativo apartecion como positivo !!!!
               // fNominales_Vigentes := Abs(fNominales_Vigentes - fNominales_Vendidos);
               fNominales_Vigentes := (fNominales_Vigentes - fNominales_Vendidos);
               //Esto quiere decir que esta todo pactado y hay que Valorizar
               if (fNominales_Vigentes - fNominales_Pactados <= 0) and
                  (fNominales_Pactados > 0) then
               begin
                  bTodo_Pactado       := True;
                  fNominales_Vigentes := fNominales_Pactados
               end
               else
                  fNominales_Vigentes := fNominales_Vigentes - fNominales_Pactados;
           //{
           end
           else
              fNominales_Vigentes  := (fNominales_Vigentes -
                                       fNominales_Vendidos - fNominales_Pactados);
           //}
              { Lo mismo que el comentario anterior
              fNominales_Vigentes  := Abs(fNominales_Vigentes -
                                          fNominales_Vendidos - fNominales_Pactados);
              }


           fNominales_Vigentes := (fNominales_Vigentes - fNominales_Vendidos);
           //Esto quiere decir que esta todo pactado y hay que Valorizar
           if (fNominales_Vigentes - fNominales_Pactados <= 0) and
              (fNominales_Pactados > 0) then
           begin
              bTodo_Pactado       := True;
              fNominales_Vigentes := fNominales_Pactados
           end
           else
              fNominales_Vigentes := fNominales_Vigentes - fNominales_Pactados;

           // Filigara 06-07-2005
           Aux_fNominales_Vigentes := StrToFloat(FormatFloat('##########.00000' ,
                                             fNominales_Vigentes)
                                       );
           // Lo siguiente se agrego ya que se dio en una compañia (BiceVida)
           // el redondeo de arriba no funciono y aparecio el error por una diferencia despues del 5 decimal.
           // ES & FI 02-02-2007
           if (ABS(Aux_fNominales_Vigentes) < 0.00001) then
              fNominales_Vigentes := 0;

           if fNominales_Reales < 0 then
           begin
             { Se comenta con fecha 28-12-2007
               Cuando hay ventas a termino despues de un pacto
               y se valoriza antes de este ultimo comienza a dar un error que no es valido. F.I.
             Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                       sProceso,
                                       dFecha_Inicial,
                                       sLogin_Sistema,
                                       sMensaje,
                                       'Consistencia',
                                       'Error en Saldo Nominales Reales '+FormatFLoat('###,###,###,###.########',fNominales_Reales)
                                       );
             }
             fNominales_Reales := 0;
             //Next;
             //Continue;
           end;

           if fNominales_Vigentes < 0 then
           begin
             Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                       sProceso,
                                       dFecha_Inicial,
                                       sLogin_Sistema,
                                       sMensaje,
                                       'Consistencia',
                                       'Error en Saldo Nominales Vigentes '+FormatFLoat('###,###,###,###.########',fNominales_Vigentes),
                                       '01'   // SObreventa
                                       );
             fNominales_Vigentes := 0;
             Next;
             Continue;
           end;


           fTasa_Compra           := FieldByName('Tasa_Mercado').AsFloat;
           fTasa_Compra_Utilizada := FieldByName('Tasa_Mercado').AsFloat;
           fPorcen_Valor_Par      := 0;
           fValor_Pte_UM_Cpa      := 0;
           fValor_Pte_MC_Cpa      := 0;
           Result                 := True;

           Aux_fNominales_Vigentes := StrToFloat(FormatFloat('##########.00000' , fNominales_Vigentes ));
           // Lo siguiente se agrego ya que se dio en una compañia (BiceVida)
           // el redondeo de arriba no funciono y aparecio el error por una diferencia despues del 5 decimal.
           // ES & FI 02-02-2007
           if (ABS(Aux_fNominales_Vigentes) < 0.00001) then
              fNominales_Vigentes := 0;

           if fNominales_Vigentes > 0 then
           begin

             //Se movio desde arriba para que no valide las OMD no vigentes
             if Fieldbyname('Tipo_Instrum').asString <> 'R' then
             begin
                Obtener_Tasa_base_Mem(FieldByName('Tasa_Base_Par').AsString
                                                 ,iBaseTasa
                                                 ,sTipoInteres
                                                 ,iBaseMensual
                                                 ,sTipoCalculoDias
                                                 ,iVigenciaValor
                                                 ,iVigencia_Meses
                                                 ,sPais_Tasa
                                                 ,sModulo_Error
                                                 ,sString_Error
                                                 ,Result);
                if NOT Result then
                begin
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             'DM_Valorizacion',
                                             'Error en definicion de Tasa Base PAR '+FieldByName('Tasa_Base_Par').AsString
                                             ,'99'
                                             );
                   Next;
                   Continue;
                end;

                Obtener_Tasa_base_Mem(FieldByName('Tasa_Base_Pte').AsString
                                                 ,iBaseTasa
                                                 ,sTipoInteres
                                                 ,iBaseMensual
                                                 ,sTipoCalculoDias
                                                 ,iVigenciaValor
                                                 ,iVigencia_Meses
                                                 ,sPais_Tasa
                                                 ,sModulo_Error
                                                 ,sString_Error
                                                 ,Result);
                if NOT Result then
                begin
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             'DM_Valorizacion',
                                             'Error en definicion de Tasa Base Pte '+FieldByName('Tasa_Base_Pte').AsString
                                             ,'99'
                                             );
                   Next;
                   Continue;
                end;
             end;


             Valida_Descriptor_Flujos_Cargados( Reg_Val_In,
                                                Reg_Val_Out,
                                                sNemotecnico,
                                                Fieldbyname('Emisor').asString,
                                                Fieldbyname('Instrumento').asString,
                                                Fieldbyname('Serie').asString,
                                                Fieldbyname('Tipo_Instrum').asString,
                                                Fieldbyname('Transaccion').asString
                                              );

          //   Reg_Val_In.Modulo_Llamado       := Reg_Parametros.Modulo_Llamado;
          //   Reg_Val_Out.Valor_Par_ya_Calculado := False;
             Reg_Val_In.fCupones_Cortados    := Fieldbyname('Cupones_Cortados').asFloat;
             Reg_Val_In.bIncluye_CC          := (Fieldbyname('Cupones_Cortados').asFloat > 0);
             Reg_Val_In.Emision_Implicita    := FieldByName('Emision_Implicita').AsString;
             Reg_Val_In.Tipo_Instrumento     := FieldByName('Tipo_Instrum').AsString;
             Reg_Val_In.sEmisor              := FieldByName('Emisor').AsString;
             Reg_Val_In.sInstrumento         := FieldByName('Instrumento').AsString;
             Reg_Val_In.sSerie               := FieldByName('Serie').AsString;
             if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                Reg_Val_In.dFecha_Vig        := dFecha_Inicial;  //FieldByName('Fecha_Vig').AsDatetime;
             Reg_Val_In.Nemotecnico          := sNemotecnico;
             Reg_Val_In.Nemotecnico_Original := Fieldbyname('Nemotecnico').asString;
             Reg_Val_In.dTasaEmision       := FieldByName('Tasa_Emision').AsFloat;
             Reg_Val_In.sUnidadMonetaria   := FieldByName('Moneda_Instrum').AsString;
             Reg_Val_In.sTipoNominales     := FieldByName('Tipo_Nominales').AsString;
             Reg_Val_In.dFechaEmision      := dFecha_Emision;
             Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
             Reg_Val_In.dFechaCompra       := FieldByName('Fecha_Operacion').AsDatetime;
             Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
// cjf
             Reg_Val_In.dFechaPago           := dFechaPagoAOcupar;
             Reg_Val_In.dFechaCalculo      := dFecha_Inicial;
             Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
             Reg_Val_In.Con_Cupon          := False;         // Sin cupon
             Reg_Val_In.Valoriza_Par_Pte   := 'AMBOS';       // PAR y PTE
// Edosan, 07-04-2009, si no pasa por aqui, no puede obtener la tasa base
//             if NOT (Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA')) then
//             begin
                if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                   Carga_RegDes(Reg_Val_In.Tipo_Instrumento
                               ,Reg_Val_In.Nemotecnico
                               ,Reg_Val_In.sEmisor
                               ,Reg_Val_In.sInstrumento
                               ,Reg_Val_In.sSerie
                               ,Reg_Val_In.sUnidadMonetaria
                               ,Reg_Val_In.dTasaEmision
                               ,Reg_Val_Out.RegDes
                               ,sModulo_Error
                               ,sString_Error
                               ,Result
                               )
                else
                   Carga_RegDes_Vig(Reg_Val_In.Tipo_Instrumento
                                   ,Reg_Val_In.Nemotecnico
                                   ,Reg_Val_In.sEmisor
                                   ,Reg_Val_In.sInstrumento
                                   ,Reg_Val_In.sSerie
                                   ,Reg_Val_In.dFecha_vig
                                   ,Reg_Val_In.sUnidadMonetaria
                                   ,Reg_Val_In.dTasaEmision
                                   ,Reg_Val_Out.RegDes
                                   ,sModulo_Error
                                   ,sString_Error
                                   ,Result
                                   );
                if NOT Result then
                begin
                   Result := True;
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             sModulo_Error,
                                             sString_Error
                                             ,'10'
                                            );
                   Next;
                   continue;
                end;
                Reg_Val_Out.RegDes.Tasa_Valor_PAR := Fieldbyname('Tasa_Base_Par').asString;
                Reg_Val_Out.RegDes.Tasa_Valor_PTE := Fieldbyname('Tasa_Base_Pte').asString;
                Reg_Val_In.Descriptor_Cargado   := 'SI';
//             end;

             Reg_Val_Out.Nominales         := fNominales_Vigentes;
             Reg_Val_Out.TasaCalculo       := fTasa_Compra;  // tasa_Calculo
             Reg_Val_Out.PorcentajePar     := fPorcen_Valor_Par;
             Reg_Val_Out.ValorInvertidoUM  := fValor_Pte_UM_Cpa;
             Reg_Val_Out.ValorInvertidoMC  := fValor_Pte_MC_Cpa;
             Reg_Val_Out.Valor_Par_UM      := fValor_Par_UM;
             Reg_Val_Out.Valor_Par_MC      := fValor_Par_MC;
             Reg_Val_Out.fValor_Final_UM   := fValor_Final_UM;
             Reg_Val_Out.Valor_Par_Base    := fValor_Par_Base;
             Reg_Val_in.Tipo_proceso       := 'GESTION';//'VALORIZA';
             Reg_Val_In.Formula_PTE        := Fieldbyname('Formula_Pte').asString;
             Reg_Val_Out.Result_Inst_Vencido := False;// Si Retorna Verdadero el Instrumento esta Vencido
             Reg_Val_Out.Tipo_Tasa_Precio  := '';

             if ( Fieldbyname('Fecha_de_Pago').asDatetime > dFecha_Inicial) then
             begin
                 if NOT ((Fieldbyname('Moneda_Operacion').AsString = sMoneda_Conversion) and
                         (fTipo_Cambio_Compra <> 0)) then
                 begin
                      conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                           ,sMoneda_Conversion
                                           ,'BC'
                                           ,Fieldbyname('Fecha_Operacion').asDatetime
                                           ,1
                                           ,fTipo_Cambio_Compra
                                           ,sModulo_Error
                                           ,sString_Error
                                           ,Result);
                      if NOT Result then
                      begin
                        Result := True;
                        Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                       sProceso,
                                                       dFecha_Inicial,
                                                       sLogin_Sistema,
                                                       sMensaje,
                                                       sModulo_Error,
                                                       sString_Error
                                                       ,'9.5'
                                                       );
                        Next;
                        continue;
                      end;
                 end;

                 Carga_Tipo_Cambio_Fijo_Mem( FieldByName('Moneda_Instrum').AsString
                                            ,sMoneda_Conversion
                                            ,Fieldbyname('Fecha_de_Pago').asDatetime
                                            ,fTipo_Cambio_Compra)
             end;

             // Valoriza a Tasa de Compra
             Valoriza_Registro(Reg_Val_In,
                               Reg_Val_Out,
                               sModulo_Error,
                               sString_Error,
                               Result);
             if Not Result then
             begin
                 Result := True;
                 if Not Reg_Val_Out.Result_Inst_Vencido then
                 begin
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial,
                                              sLogin_Sistema,
                                              sMensaje,
                                              sModulo_Error,
                                              sString_Error
                                              ,'10'
                                              );
                 end;
                 Next;
                 Continue;
             end;
             fPorcen_Valor_Par  := Reg_Val_Out.PorcentajePar   ;
             fValor_Pte_UM_Cpa  := Reg_Val_Out.ValorInvertidoUM;
             fValor_Pte_MC_Cpa  := Reg_Val_Out.ValorInvertidoMC;
             fValor_Par_UM      := Reg_Val_Out.Valor_Par_UM    ;
             fValor_Par_MC      := Reg_Val_Out.Valor_Par_MC    ;
             fValor_Final_UM    := Reg_Val_Out.fValor_Final_UM ;
             fValor_Par_Base    := Reg_Val_Out.Valor_Par_Base  ;
             fValor_Pte_UM_Cpa_Orig := Reg_Val_Out.ValorInvertidoUM;
             fValor_Pte_MC_Cpa_Orig := Reg_Val_Out.ValorInvertidoMC;
             fTasa_Compra_Utilizada := fTasa_Compra;
             sTipo_Tasa_Precio_Cpa  := Reg_Val_Out.Tipo_Tasa_Precio;

             // Para el caso que la compra sea el día del cierre o la fecha de pago de ella sea mayor que la fecha de cierre
             // Se debe usar el tipo de cambio de la compra (SI EXISTE) G.G & F.I. 20-10-2010
             if ( Fieldbyname('Fecha_de_Pago').asDatetime > dFecha_Inicial) then
             begin
                { Se movio mas arriba para que lo tome la valorizacion anterior 04-12-2012 G.G. & F.I.
                if fTipo_Cambio_Compra <> 0 then
                Carga_Tipo_Cambio_Fijo_Mem( FieldByName('Moneda_Instrum').AsString
                                           ,sMoneda_Conversion
                                           ,Fieldbyname('Fecha_de_Pago').asDatetime
                                           ,fTipo_Cambio_Compra);
                }
                // Si Moneda_Operacion es distinta a Moneda_Conversion, convierto de Moneda_Operacion a Moneda_Conversion utilizando
                // el tipo de cambio correspondiente a la fecha de Pago.
                if sMoneda_Conversion <> Fieldbyname('Moneda_Operacion').AsString  then
                begin
                   // conversion_unidad_mon(FieldByName('Moneda_Operacion').AsString 07-07-2011 GG & FI DEBE SER MONEDA DEL INSTRUMENTO !!!!!!
                   conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                        ,sMoneda_Conversion
                                        ,'BC'
                                        ,Fieldbyname('Fecha_de_Pago').asDatetime
                                        ,fValor_Pte_UM_Cpa
                                        ,fValor_Pte_MC_Cpa
                                        ,sModulo_Error
                                        ,sString_Error
                                        ,Result);
                   if NOT Result then
                   begin
                     Result := True;
                     Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                    sProceso,
                                                    dFecha_Inicial,
                                                    sLogin_Sistema,
                                                    sMensaje,
                                                    sModulo_Error,
                                                    sString_Error
                                                    ,'9.5'
                                                    );
                     Next;
                     continue;
                   end;
                end
                else
                begin
                   if fTipo_Cambio_Compra <> 0 then
                      fValor_Pte_MC_Cpa := fValor_Pte_UM_Cpa * fTipo_Cambio_Compra;
                   fValor_Pte_MC_Cpa    := Redondeo_Moneda_Mem(sMoneda_Conversion
                                                              ,dFecha_Inicial
                                                              ,fValor_Pte_MC_Cpa);
                end;
             end;

             sNemotecnico       := Reg_Val_In.Nemotecnico;
             dFecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
             dFecha_Emision     := Reg_Val_In.dFechaEmision;

             Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
             Reg_Val_In.Descriptor_Cargado   := 'SI';
//--------  NUEVO BUSCA METODO DE VALUACION PARA COLUMNAS VALOR PRESENTE a COMPRA
              // Respaldo parametros por si acaso
             Aux_Reg_Val_In  := Reg_Val_In;
             Aux_Reg_Val_Out := Reg_Val_Out;

             // Faltaba asignar la cartera 19-05-2008 F.I.
             Reg_Val_In.Cartera              := FieldByName('Cartera').AsString;
             if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                Reg_Val_In.Proceso_Valuacion := 'PTE-DERIVA'  // Nuevo !!!!
             else
                Reg_Val_In.Proceso_Valuacion := 'PRESENTE';   // Nuevo !!!!
             Reg_Val_In.Valoriza_Par_Pte     := 'VAL';       // Valuación (A Mercado)
             Reg_Val_In.Tabla_Desarr_Cargada := 'SI';        // Ya la cargo en el calculo de PTE
             Reg_Val_In.Descriptor_Cargado   := 'SI';
             Reg_Val_In.Emision_Implicita    := 'N';
             reg_val_out.Rate_Used_Valuacion := 0;
             Reg_Val_Out.TasaCalculo         := fTasa_Compra;  // tasa_Calculo
             // Lo agregue ya que con metodo de valuacion PRESENTE la necesita
             Reg_Val_In.Tasa_Compra          := fTasa_Compra;  // tasa_Calculo
             // Se cambia a pais del usuario, esto se determino con DQ en Noviembre del 2004
             // ya que no depende del pais del emisor sino de donde se transa.
             Reg_Val_In.Pais_Titulo := sPais_Usuario;


             Busca_Valuacion_Mem ( Reg_Val_In,
                                   sTipo_Valuac,
                                   sFormula_Pte,
                                   fBase_Precio,
                                   sMon_Ind,
                                   sOrigen,
                                   bValuacion
                                   );

             sOrigen_Cpa      := sOrigen;
             sTipo_Valuac_Cpa := sTipo_Valuac;
             sFormula_Pte_Cpa := sFormula_Pte;

             Reg_Val_Out.Nominales   := fNominales_Vigentes;
             if (bValuacion) then
             begin
                // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                if FieldByName('Valor_Nominal').AsFloat <> 0 then
                   Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                   FieldByName('Valor_Invertido_UM').AsFloat /
                                                   FieldByName('Valor_Nominal').AsFloat;


                Valoriza_Registro(Reg_Val_In,                 //SI
                                  Reg_Val_Out,
                                  sModulo_Error,
                                  sString_Error,
                                  Result);

                if NOT Result then
                begin
                  Result := True;
                  Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                            sProceso,
                                            dFecha_Inicial,
                                            sLogin_Sistema,
                                            sMensaje,
                                            sModulo_Error +' (Pte)',
                                            sString_Error
                                            ,'10'
                                            );
                  fValor_Pte_UM_Cpa      := 0;
                  fValor_Pte_MC_Cpa      := 0;
                  fValor_Pte_UM_Cpa_Orig := 0;
                  fValor_Pte_MC_Cpa_Orig := 0;
                  sTipo_Tasa_Precio_Cpa  := '';
                end
                else
                begin
                  fValor_Pte_UM_Cpa      := Reg_Val_Out.ValorInvertidoUM;
                  fValor_Pte_MC_Cpa      := Reg_Val_Out.ValorInvertidoMC;
                  fValor_Pte_UM_Cpa_Orig := Reg_Val_Out.ValorInvertidoUM;
                  fValor_Pte_MC_Cpa_Orig := Reg_Val_Out.ValorInvertidoMC;
                  if ( Reg_val_out.Rate_Used_Valuacion <> 0) then
                     fTasa_Compra_Utilizada := Reg_val_out.Rate_Used_Valuacion;
                  sTipo_Tasa_Precio_Cpa  := Reg_Val_Out.Tipo_Tasa_Precio;
                end;
             end;

             Reg_Val_In  := Aux_Reg_Val_In;
             Reg_Val_Out := Aux_Reg_Val_Out;

//--------
             if Transaccion_Implica_Mem(Reg_Val_In.sInstrumento,'CC') then
             begin
               iCupones_cortados := 0;
               Verifica_Cupones_Cortados(FieldByName('Empresa').AsString
                                        ,FieldByName('Cartera').AsString
                                        ,FieldByName('Transaccion').AsString
                                        ,FieldByName('Folio_Interno').AsString
                                        ,FieldByName('Item_Omd').AsFloat
                                        ,dFecha_Inicial + 1
                                        ,Reg_Val_Out
                                        ,iCupones_cortados
                                        ,sModulo_Error
                                        ,sString_Error
                                        ,Result
                                          );
             end;
//--------
             fValor_PAR_UM_Pacto     := 0;
             fValor_PAR_MC_Pacto     := 0;
             fPorcen_Valor_Par_Pacto := 0;
             fValor_Pte_UM_Cpa_Pacto := 0;
             fValor_Pte_MC_Cpa_Pacto := 0;

             if (fNominales_Pactados > 0) and
                (sImplicancia_Mercado = 'MERCADO') then
             begin
                Reg_Val_In.Emision_Implicita  := 'N';
                Reg_Val_Out.Nominales         := fNominales_Pactados;
                Valoriza_Registro(Reg_Val_In,
                                  Reg_Val_Out,
                                  sModulo_Error,
                                  sString_Error,
                                  Result);
                if Not Result then
                begin
                    Result := True;
                    if Not Reg_Val_Out.Result_Inst_Vencido then
                       Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                 sProceso,
                                                 dFecha_Inicial,
                                                 sLogin_Sistema,
                                                 sMensaje,
                                                 sModulo_Error,
                                                 sString_Error
                                                 ,'10'
                                                 );
                    Next;
                    Continue;
                end;
                Reg_Val_Out.Nominales   := fNominales_Vigentes;
                fValor_PAR_UM_Pacto     := Reg_Val_Out.Valor_Par_UM;
                fValor_PAR_MC_Pacto     := Reg_Val_Out.Valor_Par_MC;
                fPorcen_Valor_Par_Pacto := Reg_Val_Out.PorcentajePar;
                fValor_Pte_UM_Cpa_Pacto := Reg_Val_Out.ValorInvertidoUM;
                fValor_Pte_MC_Cpa_Pacto := Reg_Val_Out.ValorInvertidoMC;
             end;

             fNRO_DIVIDENDOS_IMP:= 0;

             Busca_Equivalencia_Mem( 'SUPER',
                                     'INSTRUM',
                                     FieldByName('Instrumento').AsString,
                                     dFecha_Inicial,
                                     sInstrumento_Equiv,
                                     bEquivalencia
                                   );

             // Se incluye if`para evitar el leer impagaos cuando no se necesita-
             if (sInstrumento_Equiv = 'MH')      or
                //(sInstrumento_Equiv = 'LEASING') or
                (sInstrumento_Equiv = 'CLEAS')   or //ggarcia 05/10/2007 No estaba considerando los leasing
                (Flag_Duration_Tasa_Emi)         then
             begin
               Cupones_Impagos( Fieldbyname('Empresa').asString,
                                Fieldbyname('Transaccion').asString,
                                Fieldbyname('Folio_Interno').asString,
                                Fieldbyname('Item_Omd').asFloat,
                                dFecha_Inicial,
                                fMonto_Impago_UM,
                                fNRO_DIVIDENDOS_IMP);
             end;

             // Se cambia a pais del usuario, esto se determino con DQ en Noviembre del 2004
             // ya que no depende del pais del emisor sino de donde se transa.
             Reg_Val_In.Pais_Titulo := sPais_Usuario;

             {
             fItem_Dir_Emisor   := default_direccion_Mem(Reg_Val_In.sEmisor
                                                        ,Reg_Val_In.dFechaCalculo);

             sCodigo_Geo_Emisor := Codigo_Geo_IdDir_Mem(Reg_Val_In.sEmisor
                                                       ,fItem_Dir_Emisor);

             Reg_Val_In.Pais_Titulo := Pais_Para_CodGeo_mem(sCodigo_Geo_Emisor);
             if Reg_Val_In.Pais_Titulo = '' then
             begin
                Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                          sProceso,
                                          dFecha_Inicial,
                                          sLogin_Sistema,
                                          sMensaje,
                                          'Dirección, Pais Emisor :',
                                          ' Error en dirección('+FloatToStr(fItem_Dir_Emisor)+ '), Emisor: '
                                          + Reg_Val_In.sEmisor+'.'
                                          +' No se Encuentra país para Dirección. '
                                          );
               // Next;
               // Continue;
             end;
             }
             Reg_Val_In.Motivo_Operacion := Busca_Motivo_Mem(FieldByName('Empresa').AsString
                                                         ,FieldByName('Transaccion').AsString
                                                         ,FieldByName('Folio_Interno').AsString
                                                         ,FieldByName('Item_Omd').AsFloat
                                                         ,dFecha_Inicial);
             // Si no encuentra motivo de operación busca el default
             if (trim(Reg_Val_In.Motivo_Operacion) = '') or
                (Reg_Val_In.Motivo_Operacion = NULL)     then
             begin
               // Obtiene Sistema para buscar default
               Result := Datos_Transaccion_Mem(FieldByName('Transaccion').AsString
                                               ,sRelacion
                                               ,sSistema
                                               ,sDescripcion
                                               ,sModulo_Error
                                               ,sString_Error);
               if Not Result then
               begin
                   Result := True;
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             sModulo_Error,
                                             sString_Error
                                             ,'99'
                                             );
                   Next;
                   Continue;
               end;
               Reg_Val_In.Motivo_Operacion := default_codgen_Mem('MOTINV'
                                                                ,sSistema
                                                                ,FieldByName('Transaccion').AsString);
             end;

             Reg_Val_In.Cartera              := FieldByName('Cartera').AsString;
             Reg_Val_In.Emision_Implicita    := 'N';
             // VALORIZACION A MERCADO O "VALUACION"
             if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                Reg_Val_In.Proceso_Valuacion := 'MDO-DERIVA'  // Nuevo !!!!
             else
                Reg_Val_In.Proceso_Valuacion := 'MERCADO';   // Nuevo !!!!
             Reg_Val_In.Valoriza_Par_Pte     := 'VAL';       // Valuación (A Mercado)
             Reg_Val_In.Tabla_Desarr_Cargada := 'SI';        // Ya la cargo en el calculo de PTE
             Reg_Val_In.Descriptor_Cargado   := 'SI';
             reg_val_out.Rate_Used_Valuacion := 0;
             Reg_Val_Out.TasaCalculo         := fTasa_Compra;  // tasa_Calculo
             // Lo agregue ya que con metodo de valuacion PRESENTE la necesita
             Reg_Val_In.Tasa_Compra          := fTasa_Compra;  // tasa_Calculo
             Reg_Val_Out.Tipo_Tasa_Precio    := '';

             sTipo_Valuac_Mdo := '';


             Busca_Valuacion_Mem ( Reg_Val_In,
                                   sTipo_Valuac,
                                   sFormula_Pte,
                                   fBase_Precio,
                                   sMon_Ind,
                                   sOrigen,
                                   bValuacion
                                   );

             sOrigen_Mdo      := sOrigen;
             sTipo_Valuac_Mdo := sTipo_Valuac;
             sFormula_Pte_Mdo := sFormula_Pte;

             fValor_Pte_UM_Mdo    := 0;
             fValor_Pte_MC_Mdo    := 0;
             fValor_Pte_um_Mer    := 0;
             fPtj_Valor_Par_Mdo   := 0;

             Reg_Val_Out.Nominales   := fNominales_Vigentes;
             if (bValuacion) then
             begin
                 sTipo_Valuac_Mdo := sTipo_Valuac;
                // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                if FieldByName('Valor_Nominal').AsFloat <> 0 then
                   Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                   FieldByName('Valor_Invertido_UM').AsFloat /
                                                   FieldByName('Valor_Nominal').AsFloat;

                Reg_Val_In.fCupones_Cortados    := Fieldbyname('Cupones_Cortados').asFloat;           // Edosan, 05-04-2013
                Reg_Val_In.bIncluye_CC          := (Fieldbyname('Cupones_Cortados').asFloat > 0);     // Edosan, 05-04-2013

                Valoriza_Registro(Reg_Val_In,                 //SI
                                  Reg_Val_Out,
                                  sModulo_Error,
                                  sString_Error,
                                  Result);
             end;

             if NOT Result then
             begin
               Result := True;
               Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                         sProceso,
                                         dFecha_Inicial,
                                         sLogin_Sistema,
                                         sMensaje,
                                         sModulo_Error +' (Mdo)',
                                         sString_Error
                                         ,'10'
                                         );
               // Lo siguiente es para que en los titulos de tasa flotante
               // extranjeros si no puede valorizar a mercado, deje el valor PAR
               // deje el buscar el pais del emisor dentro del IF para
               // que no afecte a los titulos que no son tasa flotante
               // F.I. para Euroamerica 07-05-2007
               if (Transaccion_Implica('NOVALTFLOT','VALOR_PAR')) and
                  (Reg_Val_Out.RegDes.TASA_FLOTANTE = 'S') then
               begin
                 fItem_Dir_Emisor       := default_direccion_Mem(Reg_Val_In.sEmisor ,Reg_Val_In.dFechaCalculo);
                 sCodigo_Geo_Emisor     := Codigo_Geo_IdDir_Mem(Reg_Val_In.sEmisor ,fItem_Dir_Emisor);

                 Reg_Val_In.Pais_Titulo := Pais_Para_CodGeo_mem(sCodigo_Geo_Emisor);

                 if Reg_Val_In.Pais_Titulo = '' then
                 begin
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial + J,
                                              sLogin_Sistema,
                                              sMensaje,
                                              'Dirección, Pais Emisor :',
                                              ' Error en dirección('+FloatToStr(fItem_Dir_Emisor)+ '), Emisor: '
                                              + Reg_Val_In.sEmisor+'.'
                                              +' No se Encuentra país para Dirección. (Tasa Flotante)'
                                              ,'10'
                                              );
                    // Como no se si es nacional o extranjero lo dejo los valores de mercado en 0
                    fValor_Pte_UM_Mdo    := 0;
                    fValor_Pte_MC_Mdo    := 0;
                 end
                 else
                 begin
                    // si es titulo extranjero en valor de mercado queda el valor PAR
                    if (Reg_Val_In.Pais_Titulo <> sPais_Usuario) then
                    begin
                      fValor_Pte_UM_Mdo    := Reg_Val_Out.Valor_Par_UM;
                      fValor_Pte_MC_Mdo    := Reg_Val_Out.Valor_Par_MC;
                    end
                    else
                    // si es titulo nacionalen valor de mercado queda el valor PAR
                    begin
                      fValor_Pte_UM_Mdo    := fValor_Pte_UM_Cpa;
                      fValor_Pte_MC_Mdo    := fValor_Pte_MC_Cpa;
                    end;
                 end;
               end
               else
               // si no tiene la implicancia 'NOVALTFLOT','VALOR_PAR'
               // y no pudo determinar valor de mercado le deja el valor presente
               begin
                 fValor_Pte_UM_Mdo    := fValor_Pte_UM_Cpa;
                 fValor_Pte_MC_Mdo    := fValor_Pte_MC_Cpa;
               end;
               fValor_Pte_um_Mer    := fValor_Pte_UM_Cpa;
               fRate_Used_Valuacion := fTasa_Compra_Utilizada;
               fPtj_Valor_Par_Mdo   := fPorcen_Valor_Par;
               sTipo_Tasa_Precio_Mdo:= '';
             end
             else
             begin
               fValor_Pte_UM_Mdo    := Reg_Val_Out.ValorInvertidoUM;
               fValor_Pte_MC_Mdo    := Reg_Val_Out.ValorInvertidoMC;
               //GGARCIA 12/01/2009 se calcula aca porque la funcion del valorizador la dejaba en cero.
               if Reg_Val_Out.Valor_PAR_UM > 0 then
                  fPtj_Valor_Par_Mdo   := Redondeo((fValor_Pte_UM_Mdo/Reg_Val_Out.Valor_PAR_UM),4)*100
               else
                  fPtj_Valor_Par_Mdo   := Reg_Val_Out.PorcentajePar   ;
               fValor_Pte_um_Mer    := fValor_Pte_UM_Mdo;
               // 09-05-2008 G.G. & F.I.   La tasa de mercado en cero es valida
               // Solo si no existe es un error y ese se cobntrola mas arriba.
               if ( bValuacion )                          then
               //   ( Reg_val_out.Rate_Used_Valuacion <> 0) then
                  fRate_Used_Valuacion := Reg_val_out.Rate_Used_Valuacion
               else
               begin
                  fValor_Pte_UM_Mdo    := fValor_Pte_UM_Cpa;
                  fValor_Pte_MC_Mdo    := fValor_Pte_MC_Cpa;     //FI
                  fValor_Pte_um_Mer    := fValor_Pte_UM_Cpa;
                  fRate_Used_Valuacion := fTasa_Compra_Utilizada;
                  fPtj_Valor_Par_Mdo   := fPorcen_Valor_Par
               end;
               sTipo_Tasa_Precio_Mdo   := Reg_Val_Out.Tipo_Tasa_Precio;
             end;

             fValor_Pte_UM_Mdo_Pacto  := 0;
             fValor_Pte_MC_Mdo_Pacto  := 0;
             fPtj_Valor_Par_Mdo_Pacto := 0;

             //Guardo Proporcion Pactada
             if (fNominales_Pactados > 0) and
                (sImplicancia_Mercado = 'MERCADO') and
                (bValuacion) then
             begin
               Reg_Val_In.Emision_Implicita    := 'N';
               if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                  Reg_Val_In.Proceso_Valuacion := 'MDO-DERIVA'  // Nuevo !!!!
               else
                  Reg_Val_In.Proceso_Valuacion := 'MERCADO';
               Reg_Val_In.Valoriza_Par_Pte     := 'VAL';
               Reg_Val_Out.Nominales           := fNominales_Pactados;
               Reg_Val_Out.Tipo_Tasa_Precio    := '';
               Valoriza_Registro(Reg_Val_In,
                                 Reg_Val_Out,
                                 sModulo_Error,
                                 sString_Error,
                                 Result);

               if Not Result then
               begin
                  Result := True;
                  Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                            sProceso,
                                            dFecha_Inicial,
                                            sLogin_Sistema,
                                            sMensaje,
                                            sModulo_Error +' (Mdo)',
                                            sString_Error
                                            ,'10'
                                            );
                  // Lo siguiente es para que en los titulos de tasa flotante
                  // extranjeros si no puede valorizar a mercado, deje el valor PAR
                  // deje el buscar el pais del emisor dentro del IF para
                  // que no afecte a los titulos que no son tasa flotante
                  // F.I. para Normativa 1360
                  if (Transaccion_Implica('NOVALTFLOT','VALOR_PAR')) and
                     (Reg_Val_Out.RegDes.TASA_FLOTANTE = 'S') then
                  begin
                    fItem_Dir_Emisor       := default_direccion_Mem(Reg_Val_In.sEmisor ,Reg_Val_In.dFechaCalculo);
                    sCodigo_Geo_Emisor     := Codigo_Geo_IdDir_Mem(Reg_Val_In.sEmisor ,fItem_Dir_Emisor);

                    Reg_Val_In.Pais_Titulo := Pais_Para_CodGeo_mem(sCodigo_Geo_Emisor);

                    if Reg_Val_In.Pais_Titulo = '' then
                    begin
                       Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                 sProceso,
                                                 dFecha_Inicial + J,
                                                 sLogin_Sistema,
                                                 sMensaje,
                                                 'Dirección, Pais Emisor :',
                                                 ' Error en dirección('+FloatToStr(fItem_Dir_Emisor)+ '), Emisor: '
                                                 + Reg_Val_In.sEmisor+'.'
                                                 +' No se Encuentra país para Dirección. (Tasa Flotante)'
                                                 ,'99'
                                                 );
                       // Como no se si es nacional o extranjero lo dejo los valores de mercado en 0
                       fValor_Pte_UM_Mdo_Pacto    := 0;
                       fValor_Pte_MC_Mdo_Pacto    := 0;
                    end
                    else
                    begin
                       // si es titulo extranjero en valor de mercado queda el valor PAR
                       if (Reg_Val_In.Pais_Titulo <> sPais_Usuario) then
                       begin
                         fValor_Pte_UM_Mdo_Pacto    := fValor_Par_UM_Pacto;
                         fValor_Pte_MC_Mdo_Pacto    := fValor_Par_MC_Pacto;
                       end
                       else
                       // si es titulo nacionalen valor de mercado queda el valor PAR
                       begin
                         fValor_Pte_UM_Mdo_Pacto    := fValor_Pte_UM_Cpa_Pacto;
                         fValor_Pte_MC_Mdo_Pacto    := fValor_Pte_MC_Cpa_Pacto;
                       end;
                    end;
                  end
                  else
                  // si no tiene la implicancia 'NOVALTFLOT','VALOR_PAR'
                  // y no pudo determinar valor de mercado le deja el valor presente
                  begin
                    fValor_Pte_UM_Mdo_Pacto    := fValor_Pte_UM_Cpa_Pacto;
                    fValor_Pte_MC_Mdo_Pacto    := fValor_Pte_MC_Cpa_Pacto;
                  end;

//////
                  fPtj_Valor_Par_Mdo_Pacto := fPorcen_Valor_Par_Pacto;
                  sTipo_Tasa_Precio_Mdo    := '';
               end
               else
               begin
                  fValor_Pte_UM_Mdo_Pacto   := Reg_Val_Out.ValorInvertidoUM;
                  fValor_Pte_MC_Mdo_Pacto   := Reg_Val_Out.ValorInvertidoMC;
                  fPtj_Valor_Par_Mdo_Pacto  := Reg_Val_Out.PorcentajePar;
                  sTipo_Tasa_Precio_Mdo     := Reg_Val_Out.Tipo_Tasa_Precio;
               end;
               Reg_Val_Out.Nominales   := fNominales_Vigentes;
             end;

             // PARA VALUACION MIXTA ....
             // Ex - Busca sin Pais solo por motivo
             Reg_Val_In.Proceso_Valuacion    := 'MIXTA';   // Nuevo !!!!
             Reg_Val_In.Valoriza_Par_Pte     := 'VAL';       // Valuación
             Reg_Val_In.Tabla_Desarr_Cargada := 'SI';        // Ya la cargo en el calculo de PTE
             Reg_Val_In.Descriptor_Cargado   := 'SI';
             Reg_val_out.Rate_Used_Valuacion := 0;
             Reg_Val_Out.TasaCalculo         := fTasa_Compra;  // tasa_Calculo
             Reg_Val_Out.Nominales           := fNominales_Vigentes;
             Reg_Val_In.Tasa_Compra          := fTasa_Compra;  // tasa_Calculo
             Busca_Valuacion_Mem ( Reg_Val_In,
                                   sTipo_Valuac,
                                   sFormula_Pte,
                                   fBase_Precio,
                                   sMon_Ind,
                                   sOrigen,
                                   bValuacion
                                   );
             sOrigen_Mix      := sOrigen;
             sTipo_Valuac_Mix := sTipo_Valuac;
             sFormula_Pte_Mix := sFormula_Pte;

             if bValuacion then
             begin
             // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                if FieldByName('Valor_Nominal').AsFloat <> 0 then
                   Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                   FieldByName('Valor_Invertido_UM').AsFloat /
                                                   FieldByName('Valor_Nominal').AsFloat;


                Valoriza_Registro(Reg_Val_In,
                                  Reg_Val_Out,
                                  sModulo_Error,
                                  sString_Error,
                                  Result);
             end;

             if NOT Result then
             begin
               Result := True;
               Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                         sProceso,
                                         dFecha_Inicial,
                                         sLogin_Sistema,
                                         sMensaje,
                                         sModulo_Error +' (Mix)',
                                         sString_Error
                                         ,'10'
                                         );

               fValorizacion_Mixta    := fValor_Pte_MC_Cpa;
               fValorizacion_Mixta_UM := fValor_Pte_UM_Cpa;
               fPrecio_Mixto          := fRate_Used_Valuacion;
               sTipo_Tasa_Precio_Mix  := '';
             end
             else
             begin
                fValorizacion_Mixta    := fValor_Pte_MC_Mdo;
                fValorizacion_Mixta_UM := fValor_Pte_UM_Mdo;
                fPrecio_Mixto          := fRate_Used_Valuacion;
                // 05-11-2009 G.G. E.S. & F.I.   La tasa en cero es valida
                // Solo si no existe es un error y ese se controla mas arriba.
                if ( bValuacion ) then
                   //( Reg_val_out.Rate_Used_Valuacion <> 0) then
                begin
                   fValorizacion_Mixta    := Reg_Val_Out.ValorInvertidoMC;
                   fValorizacion_Mixta_UM := Reg_Val_Out.ValorInvertidoUM;
                   fPrecio_Mixto          := Reg_val_out.Rate_Used_Valuacion;
                end;
                sTipo_Tasa_Precio_Mix     := Reg_Val_Out.Tipo_Tasa_Precio;
             end;


             fValor_Pte_UM_Mix_Pacto := 0;
             fValor_Pte_MC_Mix_Pacto := 0;
             //Guardo Proporcion Pactada
             if (fNominales_Pactados > 0) and
                (sImplicancia_Mercado = 'MERCADO') and
                (bValuacion) then
             begin
             /////////////

                Reg_Val_Out.TasaCalculo         := fTasa_Compra;  // tasa_Calculo
                Reg_Val_In.Tasa_Compra          := fTasa_Compra;  // tasa_Calculo
                Reg_Val_Out.Nominales   := fNominales_Pactados;
                Valoriza_Registro(Reg_Val_In,
                                     Reg_Val_Out,
                                     sModulo_Error,
                                     sString_Error,
                                     Result);

                if NOT Result then
                begin
                  Result := True;
                  Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                            sProceso,
                                            dFecha_Inicial,
                                            sLogin_Sistema,
                                            sMensaje,
                                            sModulo_Error +' (Mix)',
                                            sString_Error
                                            ,'10'
                                            );


                  fValor_Pte_UM_Mix_Pacto := fValor_Pte_UM_Mdo_Pacto;
                  fValor_Pte_MC_Mix_Pacto := fValor_Pte_MC_Mdo_Pacto;
                  fPrecio_Mixto           := fRate_Used_Valuacion;
                end
                else
                begin
                   fValor_Pte_MC_Mix_Pacto := Reg_Val_Out.ValorInvertidoMC;
                   fValor_Pte_UM_Mix_Pacto := Reg_Val_Out.ValorInvertidoUM;
                   fPrecio_Mixto           := Reg_val_out.Rate_Used_Valuacion;
                end;
             end;

            fDuration            := 0;
            fDuracion_Modificada := 0;
            fConvexidad          := 0;
            if Fieldbyname('Instrumento').asString <> 'CORA' then
            begin
               if Transaccion_Implica_Mem(sEmpresa_Usuario,'DURAT_MER') then
               begin

                  Result := True;
                  if (sTipo_Valuac_Mdo = 'TASAMERC') OR (sTipo_Valuac_Mdo = 'BRTASAMERC') then
                      Reg_Val_Out.TasaCalculo := fRate_Used_Valuacion
                  else
                  begin
                    // Calcula la tasa de mercado (por si valorizo con precio).
                    Reg_Val_In.Valoriza_Par_Pte        := 'TIR';    // Realiza Valuacion
                    Reg_Val_Out.TasaCalculo            := 0;
                    Reg_Val_In.Nominales_Compra        := fNominales_Vigentes;
                    Reg_Val_Out.ValorInvertidoUM       := fValor_Pte_UM_Mdo;
                    Reg_Val_In.fCupones_Cortados    := Fieldbyname('Cupones_Cortados').asFloat;           // Edosan, 05-04-2013
                    Reg_Val_In.bIncluye_CC          := (Fieldbyname('Cupones_Cortados').asFloat > 0);     // Edosan, 05-04-2013
                    Application.ProcessMessages;
                    Valoriza_Registro(Reg_Val_In,
                                      Reg_Val_Out,
                                      sModulo_Error,
                                      sString_Error,
                                      Result);
                    if NOT Result then
                    begin
                       Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                 sProceso,
                                                 dFecha_Inicial,
                                                 sLogin_Sistema,
                                                 sMensaje,
                                                 sModulo_Error+'(Dur)',
                                                 sString_Error
                                                 ,'10'
                                                 );
                       fDuration := 0;
                    end;
                  end;

                  if Result then
                  begin
                     //Calcula Duration a Tasa de Mercado
                     Calculo_Duration(FieldByName('Emisor').AsString
                                     ,FieldByName('Instrumento').AsString
                                     ,FieldByName('Serie').AsString
                                     ,sNemotecnico
                                     ,FieldByName('Tipo_Instrum').AsString
                                     ,dFecha_Emision
                                     ,dFecha_Vencimiento
                                     ,dFecha_Inicial
                                     ,fNominales_Vigentes
                                     ,Reg_val_out.TasaCalculo // Reg_val_out.Rate_Used_Valuacion //fRate_Used_Valuacion     //fTasa_Compra  - Ahora va con Tasa Mercado
                                     ,FieldByName('Tasa_Emision').AsFloat
                                     ,FieldByName('Moneda_Instrum').AsString
                                     ,Reg_Val_In
                                     ,Reg_Val_Out
                                     ,fDuration
                                     ,fDuracion_Modificada
                                     ,fConvexidad
                                     ,sModulo_Error
                                     ,sString_Error
                                     ,Result);
                  end
               end
               else
                  Calculo_Duration(FieldByName('Emisor').AsString
                                  ,FieldByName('Instrumento').AsString
                                  ,FieldByName('Serie').AsString
                                  ,sNemotecnico
                                  ,FieldByName('Tipo_Instrum').AsString
                                  ,dFecha_Emision
                                  ,dFecha_Vencimiento
                                  ,dFecha_Inicial
                                  ,fNominales_Vigentes
                                  ,fTasa_Compra
                                  ,FieldByName('Tasa_Emision').AsFloat
                                  ,FieldByName('Moneda_Instrum').AsString
                                  ,Reg_Val_In
                                  ,Reg_Val_Out
                                  ,fDuration
                                  ,fDuracion_Modificada
                                  ,fConvexidad
                                  ,sModulo_Error
                                  ,sString_Error
                                  ,Result);
               if NOT Result then
               begin
                 Result := True;
                 Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                           sProceso,
                                           dFecha_Inicial,
                                           sLogin_Sistema,
                                           sMensaje,
                                           sModulo_Error,
                                           sString_Error
                                           ,'99'
                                           );
                 fDuration := 0;
               end;
               // Duration a Tasa de Emision
               if Flag_Duration_Tasa_Emi then
               begin
                 Calculo_Duration(FieldByName('Emisor').AsString
                                 ,FieldByName('Instrumento').AsString
                                 ,FieldByName('Serie').AsString
                                 ,sNemotecnico
                                 ,FieldByName('Tipo_Instrum').AsString
                                 ,dFecha_Emision
                                 ,dFecha_Vencimiento
                                 ,dFecha_Inicial
                                 ,fNominales_Vigentes
                                 ,FieldByName('Tasa_Emision').AsFloat
                                 ,FieldByName('Tasa_Emision').AsFloat
                                 ,FieldByName('Moneda_Instrum').AsString
                                 ,Reg_Val_In
                                 ,Reg_Val_Out
                                 ,fDuration_Tasa_Emi
                                 ,fDuration_Modificada_Tasa_Emi
                                 ,fConvexidad_Tasa_Emi
                                 ,sModulo_Error
                                 ,sString_Error
                                 ,Result);
                 if NOT Result then
                 begin
                   Result := True;
                   sString_Error := '(Tasa Emisión) '+sString_Error;
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             sModulo_Error,
                                             sString_Error
                                             ,'99'
                                             );
                   fDuration_Tasa_Emi            := 0;
                   fDuration_Modificada_Tasa_Emi := 0;
                   fConvexidad_Tasa_Emi          := 0;
                 end;
               end;
            end;


            if (Not bAbortar) and (dFecha_Vencimiento > dFecha_Inicial) then
            begin
               fPlazo_Al_Vcto := 0 ;
               if FieldByName('Tipo_Instrumento').AsString = 'RF' Then
                  fPlazo_Al_Vcto := (dFecha_Vencimiento
                                     -
                                     dFecha_Inicial)
                                    / StrToFloat( '365'+DecimalSeparator+'25');

               // Busca Clasif. Risego x Nemotecnico
               sClasif_Riesgo := '';
               Busca_Clasif_Riesgo_Nem(FieldByName('Nemotecnico').AsString
                                      ,dFecha_Inicial
                                      ,sClasif_Riesgo
                                      ,sTipo_Clasif
                                      );
               if (sClasif_Riesgo = '') or (sClasif_Riesgo = null) THEN
                  Busca_Clasif_Riesgo_Mem(FieldByName('Emisor').AsString
                                           ,FieldByName('Instrumento').AsString
                                           ,FieldByName('Serie').AsString
                                           ,dFecha_Inicial
                                           ,False
                                           ,default_codgen('AGENCIACLA','FI','')
                                           ,sClasif_Riesgo
                                           ,fFactor_Riesgo
                                           ,sEmisor_Pagador
                                           ,sTipo_Clasif);
               if ((sClasif_Riesgo = '') AND
                  NOT bImplicancia_Omite_Error_Clasif_Riesgo) then
               begin
                 Existe_param_proceso( 'VALORIZA'
                                      ,'INSSINCLA'
                                      ,FieldByName('Instrumento').AsString
                                      ,Result);
                 if NOT Result then
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                              sProceso,
                                              dFecha_Inicial,
                                              sLogin_Sistema,
                                              // OJO: Se reemplaza el mesaje por el caso de Emisor Pagador
                                              ' Folio : ' + FieldByName('Folio_Interno').AsString
                                              +' - '
                                              +' Item : ' + FieldByName('Item_Omd').AsString
                                              +' - '
                                              +sEmisor_Pagador
                                              +' - '
                                              +FieldByName('Instrumento').AsString
                                              +' - '
                                              +FieldByName('Serie').AsString
                                              +' - '
                                              +FieldByName('Nemotecnico').AsString,
                                               'Clasificación de Riesgo',
                                               'No Existe Clasificación de Riesgo Vigente',
                                               '30'
                                              );
               end;

               // Esto es para Calcular el saldo insoluto
               if FieldByName('Tipo_Instrum').AsString = 'S' then
               begin
                  Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr
                               ,Reg_Val_Out.RegDes
                               ,dFecha_Inicial
                               ,True
                               ,iCuponVigente
                               ,sModulo_Error
                               ,sString_Error
                               ,Result);

                   if Not Result then
                   begin
                      Result := True;
                      Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                sProceso,
                                                dFecha_Inicial,
                                                sLogin_Sistema,
                                                sMensaje,
                                                sModulo_Error,
                                                sString_Error
                                                ,'99'
                                                );
                      Next;
                      continue;
                   end;

                   // EL Saldo insoluto debe ser el del cupon anterior al vigente F.I. % J.D. 01-12-2011
                   // fSaldo_Insoluto    := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Saldo_Insoluto;
                   if iCuponVigente = 1 then
                      fSaldo_Insoluto := Reg_Val_Out.RegDes.Base_Conversion
                   else
                      // g.g. & p.m. 18-01-2013 si es el dia del vcto, debe ser el vcto del cupon vigente
                      if (dFecha_Inicial = Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto) then
                         fSaldo_Insoluto := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Saldo_Insoluto
                      else
                         fSaldo_Insoluto := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente-1].Saldo_Insoluto;

                   fSaldo_Insoluto_UM := (fSaldo_Insoluto * fNominales_Vigentes) / Reg_Val_Out.RegDes.Base_Conversion;
                   conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                        ,sMoneda_Conversion
                                        ,'BC'
                                        ,dFecha_Inicial
                                        ,fSaldo_Insoluto_UM
                                        ,fSaldo_Insoluto_MC
                                        ,sModulo_Error
                                        ,sString_Error
                                        ,Result);
                   if NOT Result then
                   begin
                     Result := True;
                     Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                    sProceso,
                                                    dFecha_Inicial,
                                                    sLogin_Sistema,
                                                    sMensaje,
                                                    sModulo_Error,
                                                    sString_Error
                                                    ,'99');
                      fSaldo_Insoluto_MC := fSaldo_Insoluto_UM;
                   end;

                   if iCuponVigente = 1 then
                      fSaldo_Insoluto_Par := Reg_Val_Out.RegDes.Base_Conversion
                   else
                      fSaldo_Insoluto_Par := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente-1].Saldo_Insoluto;

               end
               else
               begin
                  fSaldo_Insoluto     := 100;
                  fSaldo_Insoluto_UM  := fNominales_Vigentes;
                  conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                       ,sMoneda_Conversion
                                       ,'BC'
                                       ,dFecha_Inicial
                                       ,fSaldo_Insoluto_UM
                                       ,fSaldo_Insoluto_MC
                                       ,sModulo_Error
                                       ,sString_Error
                                       ,Result);
                  if NOT Result then
                  begin
                    Result := True;
                    Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                   sProceso,
                                                   dFecha_Inicial,
                                                   sLogin_Sistema,
                                                   sMensaje,
                                                   sModulo_Error,
                                                   sString_Error
                                                   ,'99');
                     fSaldo_Insoluto_MC := fSaldo_Insoluto_UM;
                  end;
                  fSaldo_Insoluto_Par := 100;
               end;

               // Debo Valorizar a Fecha de Calculo + 1, para gestión a Cpa y Mdo
               bError_valoriza_mercado_ad := false;
               fValor_Nominal_Last  := 0;
               //fFactor_Riesgo       := 0;
               fValor_Pte_I_Cpa_Last:= 0;
               fValor_Pte_I_Mer_Last:= 0;
               dFecha_Last_Cierre   := dFecha_Inicial;
               if sImplicancia_Mercado = 'MERCADO'  then
               begin
                   Reg_Val_In.Emision_Implicita    := FieldByName('Emision_Implicita').AsString;
                   Reg_Val_In.Nemotecnico          := FieldByName('Nemotecnico').AsString;
                   Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
                   Reg_Val_In.Descriptor_Cargado   := 'SI';
                   Reg_Val_In.Valoriza_Par_Pte     := 'AMBOS';
                   Reg_Val_Out.TasaCalculo         := fTasa_Compra;
                   Reg_Val_In.dFechaCalculo        := dFecha_Inicial + 1;
                   Reg_Val_In.Con_Cupon            := True;
                   Valoriza_Registro(Reg_Val_In,
                                     Reg_Val_Out,
                                     sModulo_Error,
                                     sString_Error,
                                     Result);

                   if Not Result then
                   begin
                       Result := True;
                       if Not Reg_Val_Out.Result_Inst_Vencido then
                       begin
                           bError_valoriza_mercado_ad := true;
                           {
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                     sProceso,
                                                     dFecha_Inicial,
                                                     sLogin_Sistema,
                                                     sMensaje,
                                                     sModulo_Error,
                                                     sString_Error
                                                     ,'10'
                                                     );
                           }
                       end;
                       //Next;        // GGARCIA 10-05-2010
                       //Continue;    // GGARCIA 10-05-2010
                   end;
                   fPorcen_Valor_Par_Ini  := Reg_Val_Out.PorcentajePar   ;
                   fValor_Pte_UM_Cpa_Ini  := Reg_Val_Out.ValorInvertidoUM;
                   fValor_Pte_MC_Cpa_Ini  := Reg_Val_Out.ValorInvertidoMC;
                   fValor_Par_UM_Ini      := Reg_Val_Out.Valor_Par_UM;
                   fValor_Par_MC_Ini      := Reg_Val_Out.Valor_Par_MC;
                   sNemotecnico_Dia_Siguiente := Reg_Val_In.Nemotecnico;

      //--------  NUEVO BUSCA METODO DE VALUACION PARA COLUMNAS VALOR PRESENTE a COMPRA
                    // Respaldo parametros por si acaso
                   Aux_Reg_Val_In  := Reg_Val_In;
                   Aux_Reg_Val_Out := Reg_Val_Out;

                   if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                      Reg_Val_In.Proceso_Valuacion := 'PTE-DERIVA'  // Nuevo !!!!
                   else
                      Reg_Val_In.Proceso_Valuacion := 'PRESENTE';   // Nuevo !!!!
                   Reg_Val_In.Valoriza_Par_Pte     := 'VAL';       // Valuación (A Mercado)
                   Reg_Val_In.Tabla_Desarr_Cargada := 'SI';        // Ya la cargo en el calculo de PTE
                   Reg_Val_In.Descriptor_Cargado   := 'SI';
                   Reg_Val_In.Emision_Implicita    := 'N';
                   //reg_val_out.Rate_Used_Valuacion := 0;
                   Reg_Val_Out.TasaCalculo         := fTasa_Compra;  // tasa_Calculo
                   // Lo agregue ya que con metodo de valuacion PRESENTE la necesita
                   Reg_Val_In.Tasa_Compra          := fTasa_Compra;  // tasa_Calculo
                   fTasa_Compra_Utilizada          := fTasa_Compra;
                   // Se cambia a pais del usuario, esto se determino con DQ en Noviembre del 2004
                   // ya que no depende del pais del emisor sino de donde se transa.
                   Reg_Val_In.Pais_Titulo := sPais_Usuario;
                   Reg_val_out.Rate_Used_Valuacion := 0; // Lo hace dejarla limpia...


                   Busca_Valuacion_Mem ( Reg_Val_In,
                                         sTipo_Valuac,
                                         sFormula_Pte,
                                         fBase_Precio,
                                         sMon_Ind,
                                         sOrigen,
                                         bValuacion
                                         );

                   Reg_Val_Out.Nominales   := fNominales_Vigentes;
                   if (bValuacion) then
                   begin
                      // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                      if FieldByName('Valor_Nominal').AsFloat <> 0 then
                         Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                         FieldByName('Valor_Invertido_UM').AsFloat /
                                                         FieldByName('Valor_Nominal').AsFloat;


                      Valoriza_Registro(Reg_Val_In,                 //SI
                                        Reg_Val_Out,
                                        sModulo_Error,
                                        sString_Error,
                                        Result);
                   end;

                   if NOT Result then
                   begin
                     Result := True;
                     //ggarcia 23-03-2012 se comenta para que grabe igual en la qs_res_mercado_ad
                     //bError_valoriza_mercado_ad := true;
                     {
                     Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                               sProceso,
                                               dFecha_Inicial,
                                               sLogin_Sistema,
                                               sMensaje,
                                               sModulo_Error +' (Pte)',
                                               sString_Error
                                               ,'10'
                                               );
                     }
                     fValor_Pte_UM_Cpa_Ini  := 0;
                     fValor_Pte_MC_Cpa_Ini  := 0;

                   end
                   else
                   begin
                     fValor_Pte_UM_Cpa_Ini  := Reg_Val_Out.ValorInvertidoUM;
                     fValor_Pte_MC_Cpa_Ini  := Reg_Val_Out.ValorInvertidoMC;
                     // Se comenta con fecha 15-11-2005 Ya que estaba pisando el precio (tasa) de mercado utilizado
                     if ( Reg_val_out.Rate_Used_Valuacion <> 0) then
                        fTasa_Compra_Utilizada := Reg_val_out.Rate_Used_Valuacion;
                   end;

                   Reg_Val_In  := Aux_Reg_Val_In;
                   Reg_Val_Out := Aux_Reg_Val_Out;

      //--------

                   //Valorizo Proporcion Pactada
                   if (fNominales_Pactados > 0) and
                      (sImplicancia_Mercado = 'MERCADO') then
                   begin
                      Reg_Val_In.Emision_Implicita    := FieldByName('Emision_Implicita').AsString;
                      Reg_Val_In.Nemotecnico          := FieldByName('Nemotecnico').AsString;
                      Reg_Val_In.Valoriza_Par_Pte     := 'AMBOS';
                      Reg_Val_Out.Nominales           := fNominales_Pactados;
                      Valoriza_Registro(Reg_Val_In,
                                        Reg_Val_Out,
                                        sModulo_Error,
                                        sString_Error,
                                        Result);

                      if Not Result then
                      begin
                          Result := True;
                          bError_valoriza_mercado_ad := true;
                         {
                          if Not Reg_Val_Out.Result_Inst_Vencido then
                              Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                        sProceso,
                                                        dFecha_Inicial,
                                                        sLogin_Sistema,
                                                        sMensaje,
                                                        sModulo_Error,
                                                        sString_Error
                                                        ,'10'
                                                        );
                          }
                          //Next;
                          //Continue;
                      end;
                      fPorcen_Valor_Par_Ini_Pacto  := Reg_Val_Out.PorcentajePar   ;
                      fValor_Pte_UM_Cpa_Ini_Pacto  := Reg_Val_Out.ValorInvertidoUM;
                      fValor_Pte_MC_Cpa_Ini_Pacto  := Reg_Val_Out.ValorInvertidoMC;
                      fValor_Par_UM_Pacto          := Reg_Val_Out.Valor_Par_UM    ;
                      fValor_Par_MC_Pacto          := Reg_Val_Out.Valor_Par_MC    ;
                      Reg_Val_Out.Nominales        := fNominales_Vigentes;
                   end;

                   //MERCADO
                   Reg_Val_In.Emision_Implicita    := 'N';
                   if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                      Reg_Val_In.Proceso_Valuacion := 'MDO-DERIVA'  // Nuevo !!!!
                   else
                      Reg_Val_In.Proceso_Valuacion := 'MERCADO';
                   Reg_Val_In.Valoriza_Par_Pte     := 'VAL';

                   Busca_Valuacion_Mem ( Reg_Val_In,
                                         sTipo_Valuac,
                                         sFormula_Pte,
                                         fBase_Precio,
                                         sMon_Ind,
                                         sOrigen,
                                         bValuacion
                                         );
                   if bValuacion then
                   begin
                      // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                      if FieldByName('Valor_Nominal').AsFloat <> 0 then
                         Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                         FieldByName('Valor_Invertido_UM').AsFloat /
                                                         FieldByName('Valor_Nominal').AsFloat;

                      Valoriza_Registro(Reg_Val_In,
                                        Reg_Val_Out,
                                        sModulo_Error,
                                        sString_Error,
                                        Result);
                   end;

                   if NOT Result then
                   begin
                     Result := True;
                     //ggarcia 23-03-2012 se comenta para que grabe igual en la qs_res_mercado_ad
                     //bError_valoriza_mercado_ad := true;
                     {
                     Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                               sProceso,
                                               dFecha_Inicial,
                                               sLogin_Sistema,
                                               sMensaje,
                                               sModulo_Error,
                                               sString_Error
                                               ,'10'
                                               );
                     }

                     //fValor_Pte_UM_Mdo_Ini := 0;
                     //fValor_Pte_MC_Mdo_Ini := 0;
                     // Si no existe valor de mercado pone el valor a tasa de compra
                     fValor_Pte_UM_Mdo_Ini := fValor_Pte_UM_Cpa_Ini;
                     fValor_Pte_MC_Mdo_Ini := fValor_Pte_MC_Cpa_Ini;

                     fPorcen_Valor_Par_Ini := Reg_Val_Out.PorcentajePar;
                     fValor_Pte_UM_Mdo_Ini_Pacto := 0;
                     fValor_Pte_MC_Mdo_Ini_Pacto := 0;
                     fPorcen_Valor_Par_Ini_Pacto := Reg_Val_Out.PorcentajePar;
                   end
                   else
                   begin
                     fValor_Pte_UM_Mdo_Ini  := Reg_Val_Out.ValorInvertidoUM;
                     fValor_Pte_MC_Mdo_Ini  := Reg_Val_Out.ValorInvertidoMC;
                     fPtj_Valor_Par_Mdo_Ini := Reg_Val_Out.PorcentajePar;
                   end;

                  //Valorizo Proporcion Pactada
                  if (fNominales_Pactados > 0) and
                     (sImplicancia_Mercado = 'MERCADO') and
                     (bValuacion) then
                  begin
                     Reg_Val_In.Emision_Implicita    := 'N';
                     if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                        Reg_Val_In.Proceso_Valuacion := 'MDO-DERIVA'  // Nuevo !!!!
                     else
                        Reg_Val_In.Proceso_Valuacion := 'MERCADO';
                     Reg_Val_In.Valoriza_Par_Pte     := 'VAL';
                     Reg_Val_Out.Nominales           := fNominales_Pactados;

                     Valoriza_Registro(Reg_Val_In,
                                       Reg_Val_Out,
                                       sModulo_Error,
                                       sString_Error,
                                       Result);

                     if NOT Result then
                     begin
                       Result := True;
                       //ggarcia 23-03-2012 se comenta para que grabe igual en la qs_res_mercado_ad
                       //bError_valoriza_mercado_ad := true;
                       {
                       Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                 sProceso,
                                                 dFecha_Inicial,
                                                 sLogin_Sistema,
                                                 sMensaje,
                                                 sModulo_Error,
                                                 sString_Error
                                                 ,'10'
                                                 );
                       }
                       //fValor_Pte_UM_Mdo_Ini_Pacto := 0;
                       //fValor_Pte_MC_Mdo_Ini_Pacto := 0;
                       // FI 30-01-2008
                       fValor_Pte_UM_Mdo_Ini_Pacto := fValor_Pte_UM_Cpa_Ini_Pacto;
                       fValor_Pte_MC_Mdo_Ini_Pacto := fValor_Pte_MC_Cpa_Ini_Pacto;
                       fPorcen_Valor_Par_Ini_Pacto := Reg_Val_Out.PorcentajePar;
                     end
                     else
                     begin
                        fValor_Pte_UM_Mdo_Ini_Pacto  := Reg_Val_Out.ValorInvertidoUM;
                        fValor_Pte_MC_Mdo_Ini_Pacto  := Reg_Val_Out.ValorInvertidoMC;
                        fPtj_Valor_Par_Mdo_Ini_Pacto := Reg_Val_Out.PorcentajePar;
                     end;
                     Reg_Val_Out.Nominales := fNominales_Vigentes;
                   end;

                   //MIXTA
                   Reg_Val_In.Emision_Implicita    := 'N';
                   Reg_Val_In.Proceso_Valuacion    := 'MIXTA';
                   Reg_Val_In.Valoriza_Par_Pte     := 'VAL';

                   Busca_Valuacion_Mem ( Reg_Val_In,
                                         sTipo_Valuac,
                                         sFormula_Pte,
                                         fBase_Precio,
                                         sMon_Ind,
                                         sOrigen,
                                         bValuacion
                                         );
                   if bValuacion then
                   begin
                      // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                      if FieldByName('Valor_Nominal').AsFloat <> 0 then
                         Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                         FieldByName('Valor_Invertido_UM').AsFloat /
                                                         FieldByName('Valor_Nominal').AsFloat;

                      Valoriza_Registro(Reg_Val_In,
                                        Reg_Val_Out,
                                        sModulo_Error,
                                        sString_Error,
                                        Result);
                   end;

                   if NOT Result then
                   begin
                     Result := True;
                     //ggarcia 23-03-2012 se comenta para que grabe igual en la qs_res_mercado_ad
                     //bError_valoriza_mercado_ad := true;
                     {
                     Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                               sProceso,
                                               dFecha_Inicial,
                                               sLogin_Sistema,
                                               sMensaje,
                                               sModulo_Error,
                                               sString_Error
                                               ,'10'
                                               );
                     }

                     fValor_Pte_UM_Mix_Ini := fValor_Pte_UM_Mdo_Ini;   //0;  ggarcia 15-05-2012
                     fValor_Pte_MC_Mix_Ini := fValor_Pte_MC_Mdo_Ini;   //0;  ggarcia 15-05-2012
                     fValor_Pte_UM_Mix_Ini_Pacto := 0;
                     fValor_Pte_MC_Mix_Ini_Pacto := 0;
                   end
                   else
                   begin
                     fValor_Pte_UM_Mix_Ini  := Reg_Val_Out.ValorInvertidoUM;
                     fValor_Pte_MC_Mix_Ini  := Reg_Val_Out.ValorInvertidoMC;
                   end;

                  //Valorizo Proporcion Pactada
                  if (fNominales_Pactados > 0) and
                     (sImplicancia_Mercado = 'MERCADO') and
                     (bValuacion) then
                  begin
                     Reg_Val_In.Emision_Implicita    := 'N';
                     Reg_Val_In.Proceso_Valuacion    := 'MIXTA';
                     Reg_Val_In.Valoriza_Par_Pte     := 'VAL';
                     Reg_Val_Out.Nominales           := fNominales_Pactados;

                     Valoriza_Registro(Reg_Val_In,
                                       Reg_Val_Out,
                                       sModulo_Error,
                                       sString_Error,
                                       Result);

                     if NOT Result then
                     begin
                       Result := True;
                       //ggarcia 23-03-2012 se comenta para que grabe igual en la qs_res_mercado_ad
                       //bError_valoriza_mercado_ad := true;
                       {
                       Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                 sProceso,
                                                 dFecha_Inicial,
                                                 sLogin_Sistema,
                                                 sMensaje,
                                                 sModulo_Error,
                                                 sString_Error
                                                 ,'10'
                                                 );
                       }
                       fValor_Pte_UM_Mix_Ini_Pacto := fValor_Pte_UM_Mdo_Ini_Pacto;   //0;  ggarcia 15-05-2012
                       fValor_Pte_MC_Mix_Ini_Pacto := fValor_Pte_MC_Mdo_Ini_Pacto;   //0;  ggarcia 15-05-2012
                     end
                     else
                     begin
                        fValor_Pte_UM_Mix_Ini_Pacto  := Reg_Val_Out.ValorInvertidoUM;
                        fValor_Pte_MC_Mix_Ini_Pacto  := Reg_Val_Out.ValorInvertidoMC;
                     end;
                     Reg_Val_Out.Nominales := fNominales_Vigentes;
                   end;

                   decodedate(dFecha_Inicial,aa,mm,dd);
                   {si hoy es cierre de mes estos valores quedan como cierre}
                   if dd = ultimo_dia_mes(mm,aa) then
                   begin
                      if bTodo_Pactado then
                      begin
                       fValor_Pte_I_Cpa_Last := fValor_Pte_um_Cpa;
                       fValor_Pte_I_Mer_Last := fValor_Pte_um_Mer;
                      end
                      else
                      begin
                       fValor_Pte_I_Cpa_Last := fValor_Pte_um_Cpa + fValor_Pte_Um_Cpa_Pacto;
                       fValor_Pte_I_Mer_Last := fValor_Pte_um_Mer + fValor_Pte_Um_Mdo_Pacto;
                      end;
                      dFecha_Last_Cierre    := dFecha_Inicial;
                   end
                   else
                   begin
                      {busco este registro en la valorizacion de ayer}
                      dFecha_Aux := dFecha_Inicial - 1;
                      if Existe_Registro_Mercado_Mem( sCartera,
                                                      Fieldbyname('Transaccion').asString,
                                                      Fieldbyname('Folio_Interno').asString,
                                                      Fieldbyname('Item_Omd').asFloat,
                                                      fValor_Nominal_Last,
                                                      fValor_Pte_I_Cpa_Last,
                                                      fValor_Pte_I_Mer_Last,
                                                      dFecha_Aux
                                                     ) then
                       begin
                         if (Vencimientos_Al_Dia(dFecha_Inicial { si hubo vctos son los valores de hoy}
                                 ,Reg_val_out.Array_Mem_Desarr)) then
                         begin
                           if bTodo_Pactado then
                           begin
                           fValor_Pte_I_Cpa_Last := fValor_Pte_um_Cpa;
                           fValor_Pte_I_Mer_Last := fValor_Pte_um_Mer;
                           end
                           else
                           begin
                           fValor_Pte_I_Cpa_Last := fValor_Pte_um_Cpa + fValor_Pte_um_Cpa_Pacto;
                           fValor_Pte_I_Mer_Last := fValor_Pte_um_Mer + fValor_Pte_um_Mdo_Pacto;
                           end;
                           dFecha_Last_Cierre    := dFecha_Inicial;
                         end
                         else if fNominales_Ventas_Dia <> 0 then // si hubo ventas se rebaja en froma proporcional el valor de ayer
                         begin
                           if fValor_Nominal_Last <> 0 then
                              begin
                                fValor_Pte_I_Cpa_Last := fValor_Pte_I_Cpa_Last - (fValor_Pte_I_Cpa_Last*fNominales_Ventas_Dia/fValor_Nominal_Last);
                                fValor_Pte_I_Mer_Last := fValor_Pte_I_Mer_Last - (fValor_Pte_I_Mer_Last*fNominales_Ventas_Dia/fValor_Nominal_Last);
                                dFecha_Last_Cierre    := dFecha_Aux;
                              end;
                         end
                         else
                         begin
                           fValor_Pte_I_Cpa_Last := fValor_Pte_I_Cpa_Last;
                           fValor_Pte_I_Mer_Last := fValor_Pte_I_Mer_Last;
                           dFecha_Last_Cierre    := dFecha_Aux;
                         end;
                       end
                      else { si no existe ayer es compra de hoy }
                      begin
                        if bTodo_Pactado then
                        begin
                          fValor_Pte_I_Cpa_Last := fValor_Pte_um_Cpa;
                          fValor_Pte_I_Mer_Last := fValor_Pte_um_Mer;
                        end
                        else
                        begin
                          fValor_Pte_I_Cpa_Last := fValor_Pte_um_Cpa + fValor_Pte_um_Cpa_Pacto;
                          fValor_Pte_I_Mer_Last := fValor_Pte_um_Mer + fValor_Pte_um_Mdo_Pacto;
                        end;
                        dFecha_Last_Cierre    := dFecha_Inicial;
                      end;
                   end;

                   //Verifico que existan vencimientos a D + 1
                   if bTodo_Pactado then
                     fNominales_Totales := fNominales_Pactados
                   else
                     fNominales_Totales := (fNominales_Vigentes + fNominales_Pactados);

                   bVencimiento := False;
                   if FieldByName('Tipo_Instrum').AsString = 'S' then
                   begin
                      Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr
                                   ,Reg_Val_Out.RegDes
                                   ,dFecha_Inicial + 1
                                   ,True
                                   ,iCuponVigente
                                   ,sModulo_Error
                                   ,sString_Error
                                   ,Result);

                       if iCuponVigente = 1 then
                          fSaldo_Insoluto_Par := Reg_Val_Out.RegDes.Base_Conversion
                       else
                          fSaldo_Insoluto_Par := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente-1].Saldo_Insoluto;

                       // Se cambia para eliminar que aparescan el cupon del día de compra  F.I 06-09-2006
                       // if (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = (dFecha_Inicial + 1)) and
                       //    (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Cupon_Cortado = False) then

                       // Se cambia para que no aparezca el cupon que corta el dia del pago E.S. & F.I. 01/08/2008
                       //if (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = (dFecha_Inicial + 1)) and
                       //   (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Cupon_Cortado = False)             and
                       //   (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto >
                       //                                        Fieldbyname('Fecha_Operacion').asDatetime) then
                       if (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = (dFecha_Inicial + 1)) and
                          (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Cupon_Cortado = False)             and
                          (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto    > dFechaPagoAOcupar) then
                       begin
                            bVencimiento := True;
                            fInteres             := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Interes *
                                                    fNominales_Totales /
                                                    Reg_Val_Out.RegDes.Base_Conversion;

                            fAmortizacion        := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Amortizacion   *
                                                    fNominales_Totales /
                                                    Reg_Val_Out.RegDes.Base_Conversion;

                            fSaldo_Insoluto      := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Saldo_Insoluto *
                                                    fNominales_Totales /
                                                    Reg_Val_Out.RegDes.Base_Conversion;

                            fSaldo_Insoluto_UM   := (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Saldo_Insoluto * fNominales_Vigentes) /
                                                     Reg_Val_Out.RegDes.Base_Conversion;
                            conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                                 ,sMoneda_Conversion
                                                 ,'BC'
                                                 ,dFecha_Inicial
                                                 ,fSaldo_Insoluto_UM
                                                 ,fSaldo_Insoluto_MC
                                                 ,sModulo_Error
                                                 ,sString_Error
                                                 ,Result);
                            if NOT Result then
                            begin
                               Result := True;
                               Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                              sProceso,
                                                              dFecha_Inicial,
                                                              sLogin_Sistema,
                                                              sMensaje,
                                                              sModulo_Error,
                                                              sString_Error
                                                              ,'99');
                               fSaldo_Insoluto_MC := fSaldo_Insoluto_UM;
                            end;

                            // Se agrega con fecha 31-10-2006 (F.I.)
                            // Faltaba la parte de reajuste de capital para titulos con esa caracteristica
                            // Para el resto queda en cero
                            fReajuste_Capital_Pagado := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Reajuste_Capital_Pagado *
                                                        fNominales_Totales /
                                                        Reg_Val_Out.RegDes.Base_Conversion;

                            fValor_Vencimiento_UM:= fInteres +
                                                    fReajuste_Capital_Pagado +
                                                    fAmortizacion;

                            //Llevamos Vencimiento a Moneda de la Cartera
                            dFecha_Valor_Vencimiento := dia_habil_siguiente( 'CL',  dFecha_Inicial + 1);
                            conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                                 ,sMoneda_Conversion
                                                 ,'BC'
                                                 ,dFecha_Valor_Vencimiento
                                                 ,fValor_Vencimiento_UM
                                                 ,fValor_Vencimiento_MC
                                                 ,sModulo_Error
                                                 ,sString_Error
                                                 ,Result);
                            // Si no hay Valor de cambio Dejamos Valores MC = UM
                            if NOT Result then
                            begin
                              Result := True;
                              Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                        sProceso,
                                                        dFecha_Inicial + 1,
                                                        sLogin_Sistema,
                                                        sMensaje,
                                                        sModulo_Error,
                                                        sString_Error
                                                        ,'99'
                                                        );
                               fValor_Vencimiento_MC := fValor_Vencimiento_UM;
                            end;
                            fValor_Vencimiento_MC := Redondeo_Moneda_Mem( sMoneda_Conversion,
                                                                          Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Tipo_Cambio,  // Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto,  Edosan, 27-07-2009
                                                                          fValor_Vencimiento_MC
                                                                         );
                        end;
                   end
                   else  // Tipo_Instrumento <> 'S'
                   begin
                       if dFecha_Vencimiento = (dFecha_Inicial + 1) then
                       begin
                         bVencimiento          := True;
                         iCuponVigente         := 1;
                         fValor_Vencimiento_UM := fValor_Par_UM_Ini;
                         fValor_Vencimiento_MC := fValor_Par_MC_Ini;
                         fInteres              := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Interes*
                                                  fNominales_Totales /
                                                  Reg_Val_Out.RegDes.Base_Conversion;
                         fSaldo_Insoluto       := 0;
                         fSaldo_Insoluto_UM    := fNominales_Vigentes;
                         conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                              ,sMoneda_Conversion
                                              ,'BC'
                                              ,dFecha_Inicial
                                              ,fSaldo_Insoluto_UM
                                              ,fSaldo_Insoluto_MC
                                              ,sModulo_Error
                                              ,sString_Error
                                              ,Result);
                         if NOT Result then
                         begin
                           Result := True;
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                          sProceso,
                                                          dFecha_Inicial,
                                                          sLogin_Sistema,
                                                          sMensaje,
                                                          sModulo_Error,
                                                          sString_Error
                                                          ,'99');
                            fSaldo_Insoluto_MC := fSaldo_Insoluto_UM;
                         end;
//                         fAmortizacion         := fValor_Par_UM;
                         fAmortizacion        := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Amortizacion   *
                                                 fNominales_Vigentes /
                                                 Reg_Val_Out.RegDes.Base_Conversion;

                       end;
                       fSaldo_Insoluto_Par := 100;
                   end;

                   if bVencimiento then
                   begin
                       //Debo Valorizar sin cupón
                       Reg_Val_In.Emision_Implicita    := FieldByName('Emision_Implicita').AsString;
                       Reg_Val_In.Nemotecnico          := FieldByName('Nemotecnico').AsString;
                       Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
                       Reg_Val_In.Descriptor_Cargado   := 'SI';
                       Reg_Val_In.Valoriza_Par_Pte     := 'PTE';
                       Reg_Val_Out.TasaCalculo         := fTasa_Compra;
                       Reg_Val_In.dFechaCalculo        := dFecha_Inicial + 1;
                       Reg_Val_In.Con_Cupon            := False;
                       Reg_Val_Out.ValorInvertidoUM    := 0;
                       Reg_Val_Out.ValorInvertidoMC    := 0;

                       Valoriza_Registro(Reg_Val_In,
                                         Reg_Val_Out,
                                         sModulo_Error,
                                         sString_Error,
                                         Result);

                       if Not Result then
                       begin
                           Result := True;
                           if Not Reg_Val_Out.Result_Inst_Vencido then
                               Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                         sProceso,
                                                         dFecha_Inicial,
                                                         sLogin_Sistema,
                                                         sMensaje,
                                                         sModulo_Error,
                                                         sString_Error
                                                         ,'10'
                                                         );
                           Next;
                           Continue;
                       end;
                       fValor_Pte_UM_Cpa_SC  := Reg_Val_Out.ValorInvertidoUM;
                       fValor_Pte_MC_Cpa_SC  := Reg_Val_Out.ValorInvertidoMC;

           //--------  NUEVO BUSCA METODO DE VALUACION PARA COLUMNAS VALOR PRESENTE a COMPRA
                         // Respaldo parametros por si acaso
                        Aux_Reg_Val_In  := Reg_Val_In;
                        Aux_Reg_Val_Out := Reg_Val_Out;

                        if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                           Reg_Val_In.Proceso_Valuacion := 'PTE-DERIVA'  // Nuevo !!!!
                        else
                           Reg_Val_In.Proceso_Valuacion := 'PRESENTE';   // Nuevo !!!!
                        Reg_Val_In.Valoriza_Par_Pte     := 'VAL';       // Valuación (A Mercado)
                        Reg_Val_In.Tabla_Desarr_Cargada := 'SI';        // Ya la cargo en el calculo de PTE
                        Reg_Val_In.Descriptor_Cargado   := 'SI';
                        reg_val_out.Rate_Used_Valuacion := 0;
                        Reg_Val_Out.TasaCalculo         := fTasa_Compra;  // tasa_Calculo
                        // Lo agregue ya que con metodo de valuacion PRESENTE la necesita
                        Reg_Val_In.Tasa_Compra          := fTasa_Compra;  // tasa_Calculo
                        fTasa_Compra_Utilizada          := fTasa_Compra;
                        // Se cambia a pais del usuario, esto se determino con DQ en Noviembre del 2004
                        // ya que no depende del pais del emisor sino de donde se transa.
                        Reg_Val_In.Pais_Titulo := sPais_Usuario;


                        Busca_Valuacion_Mem ( Reg_Val_In,
                                              sTipo_Valuac,
                                              sFormula_Pte,
                                              fBase_Precio,
                                              sMon_Ind,
                                              sOrigen,
                                              bValuacion
                                              );

                        Reg_Val_Out.Nominales   := fNominales_Vigentes;
                        if (bValuacion) then
                        begin
                           // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                           if FieldByName('Valor_Nominal').AsFloat <> 0 then
                              Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                              FieldByName('Valor_Invertido_UM').AsFloat /
                                                              FieldByName('Valor_Nominal').AsFloat;


                           Valoriza_Registro(Reg_Val_In,                 //SI
                                             Reg_Val_Out,
                                             sModulo_Error,
                                             sString_Error,
                                             Result);
                        end;

                        if NOT Result then
                        begin
                          Result := True;
                          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                    sProceso,
                                                    dFecha_Inicial,
                                                    sLogin_Sistema,
                                                    sMensaje,
                                                    sModulo_Error +' (Pte)',
                                                    sString_Error
                                                    ,'10'
                                                    );
                          fValor_Pte_UM_Cpa_SC  := 0;
                          fValor_Pte_MC_Cpa_SC  := 0;
                        end
                        else
                        begin
                          fValor_Pte_UM_Cpa_SC  := Reg_Val_Out.ValorInvertidoUM;
                          fValor_Pte_MC_Cpa_SC  := Reg_Val_Out.ValorInvertidoMC;
                          if ( Reg_val_out.Rate_Used_Valuacion <> 0) then
                             fTasa_Compra_Utilizada := Reg_val_out.Rate_Used_Valuacion;
                        end;

                        Reg_Val_In  := Aux_Reg_Val_In;
                        Reg_Val_Out := Aux_Reg_Val_Out;

           //--------

                       if (fNominales_Pactados > 0) and
                          (sImplicancia_Mercado = 'MERCADO') then
                       begin
                          Reg_Val_Out.Nominales           := fNominales_Pactados;
                          Reg_Val_In.Emision_Implicita    := FieldByName('Emision_Implicita').AsString;
                          Reg_Val_In.Nemotecnico          := FieldByName('Nemotecnico').AsString;
                          Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
                          Reg_Val_In.Descriptor_Cargado   := 'SI';
                          Reg_Val_Out.ValorInvertidoUM    := 0;
                          Reg_Val_Out.ValorInvertidoMC    := 0;
                          Valoriza_Registro(Reg_Val_In,
                                            Reg_Val_Out,
                                            sModulo_Error,
                                            sString_Error,
                                            Result);

                          if Not Result then
                          begin
                              Result := True;
                             if Not Reg_Val_Out.Result_Inst_Vencido then
                                  Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                            sProceso,
                                                            dFecha_Inicial,
                                                            sLogin_Sistema,
                                                            sMensaje,
                                                            sModulo_Error,
                                                            sString_Error
                                                            ,'10'
                                                            );
                              Next;
                              Continue;
                          end;
                          fValor_Pte_UM_Cpa_SC_Pacto := Reg_Val_Out.ValorInvertidoUM;
                          fValor_Pte_MC_Cpa_SC_Pacto := Reg_Val_Out.ValorInvertidoMC;
                          Reg_Val_Out.Nominales      := fNominales_Vigentes;
                       end;

                       Reg_Val_In.Emision_Implicita    := 'N';
                       if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                          Reg_Val_In.Proceso_Valuacion := 'MDO-DERIVA'  // Nuevo !!!!
                       else
                          Reg_Val_In.Proceso_Valuacion := 'MERCADO';
                       Reg_Val_In.Valoriza_Par_Pte     := 'VAL';
                       Reg_Val_In.Con_Cupon            := False;

                       Busca_Valuacion_Mem ( Reg_Val_In,
                                             sTipo_Valuac,
                                             sFormula_Pte,
                                             fBase_Precio,
                                             sMon_Ind,
                                             sOrigen,
                                             bValuacion
                                             );

                       if bValuacion then
                       begin
                          // Es necesario para ciertas valuaciones (Valor de Compra) F.I. 06/07/2005
                          if FieldByName('Valor_Nominal').AsFloat <> 0 then
                             Reg_Val_Out.ValorInvertidoUM := fNominales_Vigentes *
                                                             FieldByName('Valor_Invertido_UM').AsFloat /
                                                             FieldByName('Valor_Nominal').AsFloat;


                          Valoriza_Registro(Reg_Val_In,
                                            Reg_Val_Out,
                                            sModulo_Error,
                                            sString_Error,
                                            Result);
                       end;

                       if NOT Result then
                       begin
                         Result := True;
                         Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                   sProceso,
                                                   dFecha_Inicial,
                                                   sLogin_Sistema,
                                                   sMensaje,
                                                   sModulo_Error,
                                                   sString_Error
                                                   ,'10'
                                                   );

                         fValor_Pte_UM_Mdo_SC := 0;
                         fValor_Pte_MC_Mdo_SC := 0;
                       end
                       else
                       begin
                         fValor_Pte_UM_Mdo_SC  := Reg_Val_Out.ValorInvertidoUM;
                         fValor_Pte_MC_Mdo_SC  := Reg_Val_Out.ValorInvertidoMC;
                       end;

                       if (fNominales_Pactados > 0) and
                          (sImplicancia_Mercado = 'MERCADO') and
                          (bValuacion) then
                       begin
                          Reg_Val_In.Emision_Implicita    := 'N';
                          if Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'DERIVADO') then
                             Reg_Val_In.Proceso_Valuacion := 'MDO-DERIVA'  // Nuevo !!!!
                          else
                             Reg_Val_In.Proceso_Valuacion := 'MERCADO';
                          Reg_Val_In.Valoriza_Par_Pte     := 'VAL';
                          Reg_Val_In.Con_Cupon            := False;
                          Reg_Val_Out.Nominales           := fNominales_Pactados;
                          Valoriza_Registro(Reg_Val_In,
                                            Reg_Val_Out,
                                            sModulo_Error,
                                            sString_Error,
                                            Result);
                          if NOT Result then
                          begin
                            Result := True;
                            Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                      sProceso,
                                                      dFecha_Inicial,
                                                      sLogin_Sistema,
                                                      sMensaje,
                                                      sModulo_Error,
                                                      sString_Error
                                                      ,'10'
                                                      );

                            fValor_Pte_UM_Mdo_SC_Pacto := 0;
                            fValor_Pte_MC_Mdo_SC_Pacto := 0;
                          end
                          else
                          begin
                            fValor_Pte_UM_Mdo_SC_Pacto := Reg_Val_Out.ValorInvertidoUM;
                            fValor_Pte_MC_Mdo_SC_Pacto := Reg_Val_Out.ValorInvertidoMC;
                          end;
                          Reg_Val_Out.Nominales   := fNominales_Vigentes;
                       end;

                       fDiferencia_Vencimiento_UM := 0;
                       fDiferencia_Vencimiento_MC := 0;
                       if FieldByName('Tipo_Instrum').AsString = 'S' then
                       begin
                           if iCuponVigente <> Reg_Val_Out.RegDes.Nro_Cupones then
                           begin
                              // SACO PROPORCION PARA LO NOMINALES VIGENTES + PACTADOS
                              // ESTO ES PORQUE AHORA EL VENCIMIENTO INCLUYE LO PACTADO
                              // Y CUANDO VALORICE FUE SOLO POR LO VIGENTE
                              fDiferencia_Vencimiento_UM := (fValor_Pte_UM_Cpa_Ini *
                                                             fNominales_Totales /
                                                              fNominales_Vigentes
                                                             )-
                                                             (fValor_Pte_UM_Cpa_SC *
                                                             fNominales_Totales /
                                                              fNominales_Vigentes
                                                             )
                                                            ;

                              fDiferencia_Vencimiento_MC := (fValor_Pte_MC_Cpa_Ini *
                                                             fNominales_Totales /
                                                              fNominales_Vigentes
                                                             )-
                                                             (fValor_Pte_MC_Cpa_SC *
                                                             fNominales_Totales /
                                                              fNominales_Vigentes
                                                             )
                           end
                           else
                           begin
                              fDiferencia_Vencimiento_UM := fValor_Pte_UM_Cpa_Ini;
                              fDiferencia_Vencimiento_MC := fValor_Pte_MC_Cpa_Ini;
                           end;
                           fDiferencia_Vencimiento_UM := (fDiferencia_Vencimiento_UM-fValor_Vencimiento_UM)*-1;
                           fDiferencia_Vencimiento_MC := (fDiferencia_Vencimiento_MC-fValor_Vencimiento_MC)*-1;
                       end;

                       // Registro del vcto en caja
                       // Si esta registrado el vencimiento en en el sistema de cuentas corrientes
                       // No se debe generar nuevamente (filigara 10/06/2004)
                       if Existe_Registro_en_CtaCte_Mem( FieldByName('Empresa').AsString
                                                        ,FieldByName('Transaccion').AsString
                                                        ,FieldByName('Folio_interno').AsString
                                                        ,iCuponVigente) then
                       begin     
                            Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                      sProceso,
                                                      dFecha_Inicial,
                                                      sLogin_Sistema,
                                                      FieldByName('Transaccion').AsString+'-'
                                                      +FieldByName('Folio_interno').AsString+'-'
                                                      +FloatToStr(FieldByName('Item_Omd').AsFloat)+'-'
                                                      +sNemotecnico
                                                      +' Numero Cupón: '+IntToSTR(iCuponVigente),
                                                      'Registro en CtaCte',
                                                      'No se generó registro en Tesoreía. Vencimento ya reportado a Cuentas Corrientes'
                                                      ,'99'
                                                      );
                       end
                       else
                       if (sImplicancia_NO_Vcto <> 'NO_VCTO') and
                          (fValor_Vencimiento_UM <> 0)        then
                       begin
                          Registro_Caja(FieldByName('Empresa').AsString,
                                        FieldByName('Cartera').AsString,
                                        FieldByName('Transaccion').AsString,
                                        FieldByName('Folio_interno').AsString,
                                        FieldByName('Item_Omd').AsFloat,
                                        dFecha_Inicial + 1,
                                        dFecha_Inicial + 1,
                                        'I',
                                        sMoneda_Conversion,
                                        Reg_Val_In.Nemotecnico,
                                        fInteres,
                                        fAmortizacion,
                                        fSaldo_Insoluto,
                                        fNominales_Totales,//(fNominales_Vigentes + fNominales_Pactados),
                                        fValor_Vencimiento_UM,
                                        fValor_Vencimiento_MC,
                                        fDiferencia_Vencimiento_UM,
                                        fDiferencia_Vencimiento_MC,
                                        iCuponVigente,
                                        sModulo_Error,
                                        sString_Error,
                                        Result,
                                        Reg_Parametros);
                          if Not Result then
                          begin
                            Result := true;
                            Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                      sProceso,
                                                      dFecha_Inicial,
                                                      sLogin_Sistema,
                                                      sMensaje,
                                                      sModulo_Error,
                                                      sString_Error
                                                      ,'99'
                                                      );
                            Next;
                            Continue;
                          end;
                       end;
                   end //if bVencimiento
                   else
                   begin
                      // Si no hay vencimisntos dejo valores sin cupón igual a con cupón
                      fValor_Pte_UM_Cpa_SC := fValor_Pte_UM_Cpa_Ini;
                      fValor_Pte_MC_Cpa_SC := fValor_Pte_MC_Cpa_Ini;
                      fValor_Pte_UM_Mdo_SC := fValor_Pte_UM_Mdo_Ini;
                      fValor_Pte_MC_Mdo_SC := fValor_Pte_MC_Mdo_Ini;
                      fValor_Pte_UM_Cpa_SC_Pacto := fValor_Pte_UM_Cpa_Ini;
                      fValor_Pte_MC_Cpa_SC_Pacto := fValor_Pte_MC_Cpa_Ini;
                      fValor_Pte_UM_Mdo_SC_Pacto := fValor_Pte_UM_Mdo_Ini;
                      fValor_Pte_MC_Mdo_SC_Pacto := fValor_Pte_MC_Mdo_Ini;
                   end;

                   //Inserto proporcion Pactada
                   if fNominales_Pactados > 0 then
                   begin
                     if bTodo_Pactado then
                       fTotal_Nominales := fNominales_Vigentes
                     else
                       fTotal_Nominales := fNominales_Vigentes + fNominales_Pactados;

                     if  NOT Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PENDIENTE') and
                        (NOT Reg_Parametros.bSolo_Stock)         then
                        //( NOT bValorizando_Stock_Parcial) then

                        fDiferencia := fValor_Pte_MC_Mdo_Pacto - fValor_Pte_MC_Cpa_Pacto;

                        Insert_Mercado(Fieldbyname('Empresa').asString,
                                       Fieldbyname('Cartera').asString,
                                       Fieldbyname('Transaccion').asString,
                                       Fieldbyname('Folio_Interno').asString,
                                       Fieldbyname('Item_Omd').asFloat,
                                       sNemotecnico,
                                       Fieldbyname('Emisor').asString,
                                       Fieldbyname('Instrumento').asString,
                                       SSerie,
                                    //   Fieldbyname('Serie').asString,   DC
                                       Fieldbyname('Moneda_Instrum').asString,
                                       Fieldbyname('Tasa_Emision').asFloat,
                                       dFecha_Emision,
                                       dFecha_Vencimiento,
                                       dFecha_Inicial,
                                       Fieldbyname('Fecha_Operacion').asDatetime,
                                       fNominales_Pactados,
                                       fValor_PAR_UM_Pacto,//
                                       fValor_PAR_MC_Pacto,//
                                       fTasa_Compra_Utilizada,
                                       //FieldByName('Tasa_Mercado').AsFloat, 15-11-05 F.I.-
                                       fValor_Pte_UM_Cpa_Pacto,//
                                       fValor_Pte_MC_Cpa_Pacto,//
                                       fValor_Pte_UM_Mdo_Pacto,//
                                       fValor_Pte_MC_Mdo_Pacto,//
                                       fPtj_Valor_Par_Mdo_Pacto,
                                       fRate_Used_Valuacion,
                                       fPorcen_Valor_Par_Pacto,
                                       fDuration,
                                       fDuracion_Modificada,
                                       fConvexidad,
                                       fPlazo_al_Vcto,
                                       0,
                                       0,// Parte Intermediada no VA EL VALOR fValor_Final_SVS,
                                       sClasif_Riesgo,
                                       sTipo_Clasif,
                                       fFactor_Riesgo,
                                       fPrecio_Mixto,

                                       fValor_Pte_MC_Mix_Pacto,
                                       fValor_Pte_UM_Mix_Pacto,

                                       // 17-12-2010 se agregan variables para Pacto en proceso MIXTA
                                       //fValorizacion_Mixta,
                                       //fValorizacion_Mixta_UM,

                                       Reg_Val_In.Motivo_Operacion,
                                       fSaldo_Insoluto_Par,
                                       'I',
                                       (fNominales_Pactados*fValor_Pte_I_Cpa_Last)/fTotal_Nominales,
                                       (fNominales_Pactados*fValor_Pte_I_Mer_Last)/fTotal_Nominales,
                                       dFecha_Last_Cierre,
                                       Result,
                                       Reg_Parametros,
                                       FieldByName('Custodia_Dest').AsString,
                                       fDuration_Tasa_Emi,
                                       fDuration_Modificada_Tasa_Emi,
                                       fNRO_DIVIDENDOS_IMP,
                                       fSaldo_Insoluto_UM,
                                       fSaldo_Insoluto_MC,
                                       sTipo_Tasa_Precio_Cpa,
                                       sOrigen_Cpa,
                                       sTipo_Valuac_Cpa,
                                       sFormula_Pte_Cpa,
                                       sTipo_Tasa_Precio_Mdo,
                                       sOrigen_Mdo,
                                       sTipo_Valuac_Mdo,
                                       sFormula_Pte_Mdo,
                                       sTipo_Tasa_Precio_Mix,
                                       sOrigen_Mix,
                                       sTipo_Valuac_Mix,
                                       sFormula_Pte_Mix,
                                       fDiferencia
                                      );
                        if not Result then
                        begin
                           Result := True;
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                     sProceso,
                                                     dFecha_Inicial,
                                                     sLogin_Sistema,
                                                     sMensaje,
                                                     sModulo_Error,
                                                     sString_Error
                                                     ,'99'
                                                     );
                           Next;
                           continue;
                        end;

                        //Inserto valores a Tabla de Mercado con fecha de calculo + 1
                        if sImplicancia_Mercado = 'MERCADO' then
                        begin
                          if NOT Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PENDIENTE') and
                             ( NOT Reg_Parametros.bSolo_Stock )   and
                             ( NOT bError_valoriza_mercado_ad )   then
                             //( NOT bValorizando_Stock_Parcial) then
                             Insert_Mercado_Ad(Fieldbyname('Empresa').asString,
                                             Fieldbyname('Cartera').asString,
                                             Fieldbyname('Transaccion').asString,
                                             Fieldbyname('Folio_Interno').asString,
                                             Fieldbyname('Item_Omd').asFloat,
                                             dFecha_Inicial + 1,
                                             //fTasa_Compra,                                     15-11-05 F.I.-
                                             fTasa_Compra_Utilizada,
                                             fValor_Pte_UM_Cpa_Ini_Pacto,
                                             fValor_Pte_MC_Cpa_Ini_Pacto,
                                             fPorcen_Valor_Par_Ini_Pacto,
                                             fRate_Used_Valuacion,
                                             fValor_Pte_UM_Mdo_Ini_Pacto,
                                             fValor_Pte_MC_Mdo_Ini_Pacto,
                                             fPtj_Valor_Par_Mdo_Ini_Pacto,
                                             fPrecio_Mixto,
                                             fValor_Pte_UM_Mix_Ini_Pacto,
                                             fValor_Pte_MC_Mix_Ini_Pacto,
                                             'I',
                                             Fieldbyname('Emisor').asString,
                                             Fieldbyname('Instrumento').asString,
                                             SSerie,
                                           //  Fieldbyname('Serie').asString, DC
                                             sNemotecnico_Dia_Siguiente,
                                             fValor_Pte_UM_Cpa_SC_Pacto,
                                             fValor_Pte_MC_Cpa_SC_Pacto,
                                             fValor_Pte_UM_Mdo_SC_Pacto,
                                             fValor_Pte_MC_Mdo_SC_Pacto,
                                             Result,
                                             Reg_Parametros
                                            );
                           if not Result then
                           begin
                              Result := true;
                              Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                        sProceso,
                                                        dFecha_Inicial,
                                                        sLogin_Sistema,
                                                        sMensaje,
                                                        sModulo_Error,
                                                        sString_Error
                                                        ,'99'
                                                        );
                              Next;
                              continue;
                           end;
                        end;
                   end; //fNominales_Pactados > 0 then
               end; //if Implicancia 'MERCADO'

               //Insertamos a Mercado para Gestion
               //Inserto la valorización normal y pregunto
               //que no esté todo pactado(implicancia "Mercado") por que ya lo insertó arriba
               if (Not bTodo_Pactado) and
                  (NOT Reg_Parametros.bSolo_Stock) then
               begin
                   sInstrumento_Equiv := '';
                   fProvision_UM      := 0;
                   fProvision_MC      := 0;
                   fMonto_Impago_MC   := 0;
                   fValor_Retasacion  := 0;
                   //fNRO_DIVIDENDOS_IMP:= 0; // Se comentaron ya que ahora seobtienen mucho mas arriba ...
                   //fMonto_Impago_UM   := 0; // 08-03-2006
                   dFecha_retasacion  := 0;
                   dFecha_Primer_Dividendo := 0;
                   Busca_Equivalencia_Mem( 'SUPER',
                                           'INSTRUM',
                                           FieldByName('Instrumento').AsString,
                                           dFecha_Inicial,
                                           sInstrumento_Equiv,
                                           bEquivalencia
                                         );
                   // Se movio la busqueda del numero de cupones impagos arriba del insert de la QS_RES_MERCADO
                   if (sInstrumento_Equiv = 'MH')    or
                      //(sInstrumento_Equiv = 'LEASING') then
                      (sInstrumento_Equiv = 'CLEAS') then //ggarcia 05/10/2007 No estaba considerando los leasing
                   begin
                      conversion_unidad_mon(Fieldbyname('Moneda_Instrum').asString,
                                            sMoneda_Conversion,
                                           'BC',
                                           dFecha_Inicial,
                                           fMonto_Impago_UM,
                                           fMonto_Impago_MC,
                                           sModulo_Error,
                                           sString_Error,
                                           Result);
                      if Not Result then
                      begin
                         Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                   sProceso,
                                                   dFecha_Inicial,
                                                   sLogin_Sistema,
                                                   sMensaje,
                                                   sModulo_Error,
                                                   sString_Error
                                                   ,'99'
                                                   );
                         Next;
                         continue;
                      end;
                      fMonto_Impago_MC := Redondeo_Moneda_Mem( sMoneda_Conversion,
                                                               dFecha_Inicial,
                                                               fMonto_Impago_MC
                                                               );

                      if sInstrumento_Equiv = 'MH' then
                      begin
                         // Si no hay dividendo impagos no busca retasación ni calcula provisión
                         // Paula & Fili 29-10-2003
                         if fNRO_DIVIDENDOS_IMP = 0 then
                         begin
                            fPROVISION_UM := 0;
                            fPROVISION_MC := 0;
                         end
                         else
                         begin
                            fValor_Retasacion := 0;
                            fValor_Retasacion := Tasacion_Omd_Braiz(Fieldbyname('Empresa').asString,
                                                                    Fieldbyname('Transaccion').asString,
                                                                    Fieldbyname('Folio_Interno').asString,
                                                                    Fieldbyname('Item_Omd').asFloat,
                                                                    dFecha_Inicial,
                                                                    dFecha_retasacion,
                                                                    sMoneda_Tasacion
                                                                    );
                            fValor_Retasacion_UM := fValor_Retasacion;
                            bError_Tasacion      := False;
                            if ((fValor_Retasacion = 0) OR (sMoneda_Tasacion = '')) then
                            begin
                               Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                         sProceso,
                                                         dFecha_Inicial,
                                                         sLogin_Sistema,
                                                         'No Existe Tasación Folio :'+FieldByName('Folio_Interno').AsString+
                                                         ' Item : '+FieldByName('Item_Omd').AsString,
                                                         ' Tasación Mutuos Hipotecarios',
                                                         sString_Error
                                                         ,'99'
                                                         );
                               bError_Tasacion := True;
                            end;

                            if (sMoneda_Tasacion <> Fieldbyname('Moneda_Instrum').asString) and
                               (Not bError_Tasacion) then
                            begin
                               conversion_unidad_mon(sMoneda_Tasacion,
                                                     Fieldbyname('Moneda_Instrum').asString,
                                                     'BC',
                                                     dFecha_retasacion,
                                                     fValor_Retasacion,
                                                     fValor_Retasacion_UM,
                                                     sModulo_Error,
                                                     sString_Error,
                                                     Result);
                               if Not Result then
                               begin
                                  Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                            sProceso,
                                                            dFecha_Inicial,
                                                            sLogin_Sistema,
                                                            sMensaje,
                                                            sModulo_Error,
                                                            sString_Error
                                                            ,'99'
                                                            );
                                  bError_Tasacion := True;
                               end;
                            end;

                            if Not bError_Tasacion then
                            begin
                               fProvision_UM := 0;
                               fProvision_MC := 0;
                               provision_mutuo(fNRO_DIVIDENDOS_IMP,
                                               Fieldbyname('Moneda_Instrum').asString,
                                               fMonto_Impago_UM,
                                               fValor_Retasacion_UM,
                                               fValor_Par_UM,//fNominales_Vigentes,
                                               fValor_Pte_UM_Cpa,
                                               fProvision_UM);

                                conversion_unidad_mon(Fieldbyname('Moneda_Instrum').asString,
                                                      sMoneda_Conversion,
                                                      'BC',
                                                      dFecha_Inicial,
                                                      fProvision_UM,
                                                      fProvision_MC,
                                                      sModulo_Error,
                                                      sString_Error,
                                                      Result);
                                if Not Result then
                                begin
                                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                             sProceso,
                                                             dFecha_Inicial,
                                                             sLogin_Sistema,
                                                             sMensaje,
                                                             sModulo_Error,
                                                             sString_Error
                                                             ,'99'
                                                             );
                                   bError_Tasacion := True;
                                end
                                else
                                   fProvision_MC := Redondeo_Moneda_Mem( sMoneda_Conversion,
                                                                         dFecha_Inicial,
                                                                         fProvision_MC
                                                                        );
                               if fNRO_DIVIDENDOS_IMP >= 36 then
                                  fProvision_MC := fProvision_MC - 1;
                            end;  // si encontro tasacion

                         end; //si tiene dividendos impagos

                         dFecha_Primer_Dividendo := Reg_Val_Out.RegDes.Fecha_Emision;
                         Proximo_vencimiento( Fieldbyname('Nemotecnico').asString
                                             ,Reg_Val_Out.RegDes.Tipo_Vencimiento
                                             ,1
                                             ,Round(Reg_Val_Out.RegDes.Dia_Vencimiento)
                                             ,Round(Reg_Val_Out.RegDes.Periodo_Pago)
                                             ,Reg_Val_Out.RegDes.Tasa_Flotante
                                             ,dFecha_Primer_Dividendo
                                             ,Result);
                         if NOT Result then
                         begin
                             Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                       sProceso,
                                                       dFecha_Inicial,
                                                       sLogin_Sistema,
                                                       sMensaje,
                                                       sModulo_Error,
                                                       sString_Error
                                                        ,'99'
                                                       );
                             Next;
                             continue;
                         end;

                      end; // si es MH

                      //Inserto Valores
                      //  if ( NOT bValorizando_Stock_Parcial) then
                         Insert_Valores_MH(Fieldbyname('Empresa'      ).asString,
                                        FieldByName('Cartera'      ).AsString,
                                        FieldByName('Transaccion'  ).AsString,
                                        FieldByName('Folio_interno').AsString,
                                        FieldByName('Item_OMD').AsFloat,
                                        FieldByName('Emisor').AsString,
                                        FieldByName('Instrumento').AsString,
                                        SSerie,
                                       // FieldByName('Serie').AsString,
                                        sNemotecnico,
                                        dFecha_Inicial,
                                        dFecha_Primer_Dividendo,
                                        dFecha_retasacion,
                                        fValor_Retasacion,
                                        fNRO_DIVIDENDOS_IMP,
                                        fMonto_Impago_UM,
                                        fMonto_Impago_MC,
                                        fPROVISION_UM,
                                        fPROVISION_MC,
                                        Result,
                                        Reg_Parametros
                                        );
                       if Not Result then
                       begin
                          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                    sProceso,
                                                    dFecha_Inicial,
                                                    sLogin_Sistema,
                                                    sMensaje,
                                                    sModulo_Error,
                                                    sString_Error
                                                    ,'99'
                                                    );
                          Next;
                          continue;
                       end;
                  end;

                  //Determino Valor Final SVS
                  sVALORIZACION := '';
                  Busca_Valor_Super_Mem( 'SVS',
                                        FieldByName('Empresa').AsString,
                                        FieldByName('Cartera').AsString,
                                        Reg_Val_In.Pais_Titulo,
                                        FieldByName('Emisor').AsString,
                                        FieldByName('Instrumento').AsString,
                                        FieldByName('Serie').AsString,
                                       Reg_Val_In.Motivo_Operacion,
                                        sVALORIZACION
                                        );
                  if sVALORIZACION = '' then // Si no hay definición lo dejo a COMPRA
                     sVALORIZACION := 'COMPRA';

                  if Transaccion_Implica_Mem(sEmpresa_Usuario,'AUDITORIA') then
                  begin
                     sVALORIZACION := '';
                     Busca_Valor_Super_Mem( 'SVS',
                                            'SVS',
                                           FieldByName('Cartera').AsString,
                                           Reg_Val_In.Pais_Titulo,
                                           FieldByName('Emisor').AsString,
                                           FieldByName('Instrumento').AsString,
                                           FieldByName('Serie').AsString,
                                           Reg_Val_In.Motivo_Operacion,
                                           sVALORIZACION
                                           );
                     if sVALORIZACION = '' then // Si no hay definición lo dejo a COMPRA
                        sVALORIZACION := 'COMPRA';
                        
                     if sVALORIZACION = 'COMPRA' then
                     begin
                        // Rescato valores de Dividendos impagos y Provision
                        DecodeDate(dFecha_Inicial, aa, mm, dd);
                        fRut     := 0;
                        sPeriodo := IntToStr(aa) + IntToStr(mm);
                        if sEmpresa_Aux <> FieldByName('Empresa').AsString then
                        begin
                           sEmpresa_Aux := FieldByName('Empresa').AsString;
                           Valores_Identidad ( FieldByName('Empresa').AsString
                                               ,fRut
                                               ,sDigito
                                               ,sRazon_social
                                               ,Result
                                             );
                           if Not Result then
                           begin
                              Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                        sProceso,
                                                        dFecha_Inicial,
                                                        sLogin_Sistema,
                                                        'No Existe Código de Identidad '+FieldByName('Empresa').AsString,
                                                        sModulo_Error,
                                                        sString_Error
                                                        ,'99'
                                                        );
                              Next;
                              continue;
                           end;

                           If fRut = 0 Then
                           begin
                              Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                        sProceso,
                                                        dFecha_Inicial,
                                                        sLogin_Sistema,
                                                        'No Existe Rut, para Identidad ' +FieldByName('Empresa').AsString,
                                                        sModulo_Error,
                                                        sString_Error
                                                        ,'99'
                                                        );
                              Next;
                              continue;
                           end;
                        end;

                        With DMValorizacion,Qry_General2 do
                        begin
                           Sql.Clear;
                           Sql.Add( ' SELECT SV_DIV_IMP_PP'
                                   +'       ,SV_PROVISION'
                                   +'       ,SV_DIV_IMP'
                                   +'  FROM QS_AUD_B1'
                                   +' WHERE SV_PERIODO     = :Periodo'
                                   +'   AND SV_1010411     = :Rut'
                                   +'   AND SV_CODIGO_OPER = :Transaccion'
                                   +'   AND SV_FOLIO_OPER  = :Folio_Interno'
                                   +'   AND SV_ITEM_OPER   = :Item_Omd'
                                  );
                           ParamByName('Periodo').asString     := sPeriodo;
                           ParamByName('Rut').AsFloat          := fRut;
                           ParamByName('Transaccion').AsString := DMValorizacion.QRY_General.Fieldbyname('Transaccion').asString;
                           ParamByName('Folio_interno').asFloat:= DMValorizacion.QRY_General.Fieldbyname('Folio_interno').asFloat;
                           ParamByName('Item_Omd').AsFloat     := DMValorizacion.QRY_General.Fieldbyname('Item_Omd').asFloat;
                           Open;

                           fMonto_Impago_UM    := 0;
                           fMonto_Impago_MC    := 0;
                           fProvision_UM       := 0;
                           fProvision_MC       := 0;
                           fNRO_DIVIDENDOS_IMP := 0;
                           if Not Fieldbyname('SV_DIV_IMP_PP').isNull then
                           begin
                              fMonto_Impago_UM    := Fieldbyname('SV_DIV_IMP_PP').asFloat;
                              fMonto_Impago_MC    := Fieldbyname('SV_DIV_IMP_PP').asFloat;
                              fProvision_UM       := Fieldbyname('SV_PROVISION').asFloat;
                              fProvision_MC       := Fieldbyname('SV_PROVISION').asFloat;
                              fNRO_DIVIDENDOS_IMP := Fieldbyname('SV_DIV_IMP').asFloat;
                           end;
                           Close;
                        end;

                        fValor_Final_SVS_UM  := fValor_Pte_UM_Cpa + fMonto_Impago_UM - fProvision_UM;
                        fValor_Final_SVS_MC  := fValor_Pte_MC_Cpa + fMonto_Impago_MC - fProvision_MC;
                        if fNRO_DIVIDENDOS_IMP >= 36 then
                        begin
                           fValor_Final_SVS_UM  := 1;
                           fValor_Final_SVS_MC  := 1;
                        end;
                     end
                     else
                     begin
                        fValor_Final_SVS_UM  := fValor_Pte_UM_Mdo;
                        fValor_Final_SVS_MC  := fValor_Pte_MC_Mdo;
                     end;
                  end
                  else
                  begin
                     if sVALORIZACION = 'COMPRA' then
                     begin
                        fValor_Final_SVS_UM  := fValor_Pte_UM_Cpa + fMonto_Impago_UM - fProvision_UM;
                        fValor_Final_SVS_MC  := fValor_Pte_MC_Cpa + fMonto_Impago_MC - fProvision_MC;
                        if fNRO_DIVIDENDOS_IMP >= 36 then
                        begin
                           fValor_Final_SVS_UM  := 1;
                           fValor_Final_SVS_MC  := 1;
                        end;
                     end
                     else
                     begin
                        fValor_Final_SVS_UM  := fValor_Pte_UM_Mdo;
                        fValor_Final_SVS_MC  := fValor_Pte_MC_Mdo;
                     end;
                  end;

                  if NOT Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PENDIENTE') and
                   ( NOT Reg_Parametros.bSolo_Stock)         then                  
                     //( NOT bValorizando_Stock_Parcial) then
{
                  Edo: Esto no puede ir aqui ... Cuando es CFM el cupon vigente viene en cero !!!!
                  if Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto <= Fieldbyname('Fecha_Operacion').asDatetime then
                  begin
                     Next;
                     continue;
                  end;
}
                     fDiferencia := fValor_Pte_MC_Mdo - fValor_Pte_MC_Cpa;

                     Insert_Mercado(Fieldbyname('Empresa').asString,    //FI
                                 Fieldbyname('Cartera').asString,
                                 Fieldbyname('Transaccion').asString,
                                 Fieldbyname('Folio_Interno').asString,
                                 Fieldbyname('Item_Omd').asFloat,
                                 sNemotecnico,
                                 Fieldbyname('Emisor').asString,
                                 Fieldbyname('Instrumento').asString,
                                 SSerie,
                                 //Fieldbyname('Serie').asString,  DC
                                 Fieldbyname('Moneda_Instrum').asString,
                                 Fieldbyname('Tasa_Emision').asFloat,
                                 dFecha_Emision,
                                 dFecha_Vencimiento,
                                 dFecha_Inicial,
                                 Fieldbyname('Fecha_Operacion').asDatetime,
                                 fNominales_Vigentes,
                                 fValor_PAR_UM,
                                 fValor_PAR_MC,
                                 fTasa_Compra_Utilizada,
                                 //FieldByName('Tasa_Mercado').AsFloat, 15-11-05 F.I.-
                                 fValor_Pte_UM_Cpa,
                                 fValor_Pte_MC_Cpa,
                                 fValor_Pte_UM_Mdo,
                                 fValor_Pte_MC_Mdo,
                                 fPtj_Valor_Par_Mdo,
                                 fRate_Used_Valuacion,
                                 fPorcen_Valor_Par,
                                 fDuration,
                                 fDuracion_Modificada,
                                 fConvexidad,
                                 fPlazo_al_Vcto,
                                 fValor_Final_SVS_UM,
                                 fValor_Final_SVS_MC,
                                 sClasif_Riesgo,
                                 sTipo_Clasif,
                                 fFactor_Riesgo,
                                 fPrecio_Mixto,
                                 fValorizacion_Mixta,
                                 fValorizacion_Mixta_UM,
                                 Reg_Val_In.Motivo_Operacion,
                                 fSaldo_Insoluto_Par,
                                 'T',
                                 (fNominales_Vigentes*fValor_Pte_I_Cpa_Last)/(fNominales_Vigentes + fNominales_Pactados),
                                 (fNominales_Vigentes*fValor_Pte_I_Mer_Last)/(fNominales_Vigentes + fNominales_Pactados),
                                 dFecha_Last_Cierre,
                                 Result,
                                 Reg_Parametros,
                                 FieldByName('Custodia_Dest').AsString,
                                 fDuration_Tasa_Emi,
                                 fDuration_Modificada_Tasa_Emi,
                                 fNRO_DIVIDENDOS_IMP,
                                 fSaldo_Insoluto_UM,
                                 fSaldo_Insoluto_MC,
                                 sTipo_Tasa_Precio_Cpa,
                                 sOrigen_Cpa,
                                 sTipo_Valuac_Cpa,
                                 sFormula_Pte_Cpa,
                                 sTipo_Tasa_Precio_Mdo,
                                 sOrigen_Mdo,
                                 sTipo_Valuac_Mdo,
                                 sFormula_Pte_Mdo,
                                 sTipo_Tasa_Precio_Mix,
                                 sOrigen_Mix,
                                 sTipo_Valuac_Mix,
                                 sFormula_Pte_Mix,
                                 fDiferencia
                                );
                   if not Result then
                   begin
                      Result := true;
                      Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                sProceso,
                                                dFecha_Inicial,
                                                sLogin_Sistema,
                                                sMensaje,
                                                ' Base de Datos : ',
                                                ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO'
                                                ,'99'
                                                );
                      Next;
                      continue;
                   end;
                end;

                //Inserto valores a Tabla de Mercado con fecha de calculo + 1
                if (sImplicancia_Mercado = 'MERCADO') and
                   (NOT Reg_Parametros.bSolo_Stock)   and
                   (Not bTodo_Pactado)  then
                begin
                   if NOT Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PENDIENTE') and
                      ( NOT Reg_Parametros.bSolo_Stock )         and
                      ( NOT bError_valoriza_mercado_ad )         then
                      //( NOT bValorizando_Stock_Parcial) then
                      Insert_Mercado_Ad(Fieldbyname('Empresa'    ).asString,
                                     Fieldbyname('Cartera'    ).asString,
                                     Fieldbyname('Transaccion').asString,
                                     Fieldbyname('Folio_Interno').asString,
                                     Fieldbyname('Item_Omd').asFloat,
                                     dFecha_Inicial + 1,
                                     fTasa_Compra_Utilizada,
                                     // fTasa_Compra, 15-11-05 F.I.-
                                     fValor_Pte_UM_Cpa_Ini,
                                     fValor_Pte_MC_Cpa_Ini,
                                     fPorcen_Valor_Par_Ini,
                                     fRate_Used_Valuacion,
                                     fValor_Pte_UM_Mdo_Ini,
                                     fValor_Pte_MC_Mdo_Ini,
                                     fPtj_Valor_Par_Mdo_Ini,
                                     fPrecio_Mixto,
                                     fValor_Pte_UM_Mix_Ini,
                                     fValor_Pte_MC_Mix_Ini,
                                     'T',
                                     Fieldbyname('Emisor').asString,
                                     Fieldbyname('Instrumento').asString,
                                     SSerie,
                                   //  Fieldbyname('Serie').asString,   DC
                                     sNemotecnico_Dia_Siguiente,
                                     fValor_Pte_UM_Cpa_SC,
                                     fValor_Pte_MC_Cpa_SC,
                                     fValor_Pte_UM_Mdo_SC,
                                     fValor_Pte_MC_Mdo_SC,
                                     Result,
                                     Reg_Parametros
                                    );
                   if not Result then
                   begin
                      Result := true;
                      Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                sProceso,
                                                dFecha_Inicial,
                                                sLogin_Sistema,
                                                sMensaje,
                                                ' Base de Datos : ',
                                                ' Error al Insertar Registro en Tabla Temporal QS_RES_MERCADO_AD'
                                                ,'99'
                                                );
                      Next;
                      continue;
                   end;
                end;
             end;
          end;

          if (fNominales_Reales    > 0) or
             ((fNominales_Vigentes > 0) and NOT bTodo_Pactado)  then
          begin
              sCustodia_Dest := Custodia_Actual_Mem( FieldByName('Empresa').AsString,
                                                     FieldByName('Transaccion').AsString,
                                                     FieldByName('Folio_interno').AsString,
                                                      FieldByName('Item_OMD').AsFloat
                                                    );
             if Trim( sCustodia_Dest ) = '' then
                sCustodia_Dest := FieldByName('Custodia_Dest').AsString;

             if dFecha_Stock <> dFecha_Inicial then
               dFecha_Stock := dFecha_Inicial;

             // Para el caso que todo esta pactado significa que los nominales vigentes son 0
             // estan con valor porque se cambiaron para poder obtener los valores a tasa de compra
             // que son necesarios cuando se produce un corte de cupon
             if bTodo_Pactado then
                Aux_fNominales_Vigentes := 0
             else
                Aux_fNominales_Vigentes := fNominales_Vigentes;

             Inserta_Registro_Stock(FieldByName('Empresa').AsString,
                                    FieldByName('Transaccion').AsString,
                                    FieldByName('Folio_interno').AsString,
                                    FieldByName('Item_OMD').AsFloat,
                                    FieldByName('Fecha_Operacion').AsDateTime,
                                    dFecha_Inicial,
                                    sNemotecnico,
                                    FieldByName('Emisor').AsString,
                                    FieldByName('Instrumento').AsString,
                                    SSerie,
                                  //  FieldByName('Serie').AsString,
                                    dFecha_Emision,
                                    dFecha_Vencimiento,
                                    fNominales_Reales,
                                    Aux_fNominales_Vigentes,  //fNominales_Vigentes,
                                    FieldByName('Tasa_Emision').AsFloat,
                                    fTasa_Compra_Utilizada,
                                    //FieldByName('Tasa_Mercado').AsFloat, 15-11-05 F.I.-
                                    FieldByName('Moneda_Instrum').AsString,
                                    FieldByName('Tasa_Base_Par').AsString,
                                    FieldByName('Tasa_Base_Pte').AsString,
                                    fValor_Pte_UM_Cpa,
                                    fValor_Pte_MC_Cpa,
                                    fPorcen_Valor_Par,
                                    FieldByName('Cartera'      ).AsString,
                                    FieldByName('Moneda_Pacto').AsString,
                                    FieldByName('Tasa_pacto'  ).AsFloat,
                                    FieldByName('Tasa_Base_Pacto').AsString,
                                    FieldByName('Fecha_Vcto_Pacto').AsDateTime,
                                    FieldByName('Tipo_Nominales').AsString,
                                    sCustodia_Dest,
                                    fPlazo_Al_Vcto,
                                    FieldByName('Tipo_Instrum').AsString,
                                    fValor_Pte_UM_Mdo,
                                    fValor_Pte_MC_Mdo,
                                    fRate_Used_Valuacion,
                                    fDuration,
                                    ' ',
                                    (fValor_Pte_MC_Mdo - fValor_Pte_MC_Cpa),
                                    fValorizacion_Mixta,
                                    fPrecio_Mixto,
                                    Reg_Val_In.Motivo_Operacion,
                                    sClasif_Riesgo,
                                    iCupones_cortados,
                                    fValor_PAR_UM,
                                    fValor_PAR_MC,
                                    fSaldo_Insoluto_UM,
                                    fSaldo_Insoluto_MC,
                                    Result);
             if not Result then
             begin
                Result := True;
                Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                          sProceso,
                                          dFecha_Inicial,
                                          sLogin_Sistema,
                                          sMensaje,
                                          ' Base de Datos : ',
                                          ' Error al Insertar Registro en Tabla Temporal QS_TRA_OMD_STK_RF'
                                          ,'99'
                                          );
                Next;
                continue;
             end;
          end;

             Reg_Val_In.Con_Cupon          := False;          // Sin cupon

             //Esto es Porque si Valorizé todo lo PACTADO
             { Modificado por F.I. Porque no salian los vencimientos de lo
               Que esta totalmente pactado cuando no existia la implicancia MERCADO
               }
// 2 lineas siguientes, comentadas por Edosan, al estar pactado Toda la OMD hacia que no quedase el registro en qs_tes_egring, 10-11-2008, lo vi con F.I.
//             if (sImplicancia_Mercado = 'MERCADO') and bTodo_Pactado then
//                fNominales_Vigentes := 0;


             // INICIO 30-11-2011
             // Si los nominales vigentes estan en cero, pero los fNominales_Ventas_Dia (QUE INCLUYEN LOS VENDIDOS PERO NO COBRADOS)
             // son mayores a cero NO HA CARGADO AUN EL DESCRIPTOR F.I. 30-11-2011

             if (fNominales_Vigentes   = 0) and
                (fNominales_Ventas_Dia > 0) then
             begin
                    sNemotecnico := FieldByName('Nemotecnico').AsString;
                    Valida_Descriptor_Flujos_Cargados( Reg_Val_In,
                                                       Reg_Val_Out,
                                                       sNemotecnico,
                                                       Fieldbyname('Emisor').asString,
                                                       Fieldbyname('Instrumento').asString,
                                                       Fieldbyname('Serie').asString,
                                                       Fieldbyname('Tipo_Instrum').asString,
                                                       Fieldbyname('Transaccion').asString
                                                      );

                    if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
                    begin
                       Reg_Val_In.fCupones_Cortados    := Fieldbyname('Cupones_Cortados').asFloat;
                       Reg_Val_In.bIncluye_CC          := (Fieldbyname('Cupones_Cortados').asFloat > 0);
                       Reg_Val_In.Emision_Implicita    := FieldByName('Emision_Implicita').AsString;
                       Reg_Val_In.Tipo_Instrumento     := FieldByName('Tipo_Instrum').AsString;
                       Reg_Val_In.sEmisor              := FieldByName('Emisor').AsString;
                       Reg_Val_In.sInstrumento         := FieldByName('Instrumento').AsString;
                       Reg_Val_In.sSerie               := FieldByName('Serie').AsString;
                       if Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                          Reg_Val_In.dFecha_Vig        := dFecha_Inicial;  //FieldByName('Fecha_Vig').AsDatetime;
                       Reg_Val_In.Nemotecnico          := sNemotecnico;
                       Reg_Val_In.Nemotecnico_Original := Fieldbyname('Nemotecnico').asString;
                       Reg_Val_In.dTasaEmision       := FieldByName('Tasa_Emision').AsFloat;
                       Reg_Val_In.sUnidadMonetaria   := FieldByName('Moneda_Instrum').AsString;
                       Reg_Val_In.sTipoNominales     := FieldByName('Tipo_Nominales').AsString;
                       Reg_Val_In.dFechaEmision      := dFecha_Emision;
                       Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
                       Reg_Val_In.dFechaCompra       := FieldByName('Fecha_Operacion').AsDatetime;
                       Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
                       Reg_Val_In.dFechaPago           := dFechaPagoAOcupar;
                       Reg_Val_In.dFechaCalculo      := dFecha_Inicial;
                       Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
                       Reg_Val_In.Con_Cupon          := False;         // Sin cupon
                       Reg_Val_In.Valoriza_Par_Pte   := 'AMBOS';       // PAR y PTE

                       Registro_Fechas.Fecha_Calculo     := Reg_Val_In.dFechaCalculo;
                       Registro_Fechas.Fecha_Compra      := Reg_Val_In.dFechaCompra;
                       Registro_Fechas.Fecha_Emision     := Reg_Val_In.dFechaEmision;
                       Registro_Fechas.Fecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
                       Registro_Fechas.Fecha_Pago        := Reg_Val_In.dFechaPago;

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
                                            sModulo_Error,
                                            sString_Error,
                                            Result
                                           );
                         if Not Result then
                         begin
                            Result := True;
                            Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                      sProceso,
                                                      dFecha_Inicial,
                                                      sLogin_Sistema,
                                                      sMensaje,
                                                      sModulo_Error,
                                                      sString_Error
                                                      ,'99'
                                                      );
                            Next;
                            continue;
                         end;
                       end;

                       if NOT Transaccion_Implica(sEmpresa_Usuario,'FECHAVIG') then
                          Carga_RegDes(Reg_Val_In.Tipo_Instrumento
                                      ,Reg_Val_In.Nemotecnico
                                      ,Reg_Val_In.sEmisor
                                      ,Reg_Val_In.sInstrumento
                                      ,Reg_Val_In.sSerie
                                      ,Reg_Val_In.sUnidadMonetaria
                                      ,Reg_Val_In.dTasaEmision
                                      ,Reg_Val_Out.RegDes
                                      ,sModulo_Error
                                      ,sString_Error
                                      ,Result
                                      )
                       else
                          Carga_RegDes_Vig(Reg_Val_In.Tipo_Instrumento
                                          ,Reg_Val_In.Nemotecnico
                                          ,Reg_Val_In.sEmisor
                                          ,Reg_Val_In.sInstrumento
                                          ,Reg_Val_In.sSerie
                                          ,Reg_Val_In.dFecha_vig
                                          ,Reg_Val_In.sUnidadMonetaria
                                          ,Reg_Val_In.dTasaEmision
                                          ,Reg_Val_Out.RegDes
                                          ,sModulo_Error
                                          ,sString_Error
                                          ,Result
                                          );
                       if NOT Result then
                       begin
                          Result := True;
                          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                    sProceso,
                                                    dFecha_Inicial,
                                                    sLogin_Sistema,
                                                    sMensaje,
                                                    sModulo_Error,
                                                    sString_Error
                                                    ,'10'
                                                   );
                          Next;
                          continue;
                       end;
                       Reg_Val_Out.RegDes.Tasa_Valor_PAR := Fieldbyname('Tasa_Base_Par').asString;
                       Reg_Val_Out.RegDes.Tasa_Valor_PTE := Fieldbyname('Tasa_Base_Pte').asString;
                       Reg_Val_In.Descriptor_Cargado   := 'SI';

                       carga_parametros_formulas_mem(Reg_Val_Out.RegDes.Cod_Calc_PAR_D
                                                    ,Reg_Val_Out.RegDes.Cod_Calc_TIR_D
                                                    ,Reg_Formula_PAR
                                                    ,Reg_Formula_TIR
                                                    ,sModulo_Error
                                                    ,sString_Error
                                                    ,Result
                                                    );
                       if not Result then // Por Ecepciones...como br
                          Result := True;

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
                                      ,sModulo_Error
                                      ,sString_Error
                                      ,Result);
                       if NOT Result then
                       begin
                          Result := True;
                          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                    sProceso,
                                                    dFecha_Inicial,
                                                    sLogin_Sistema,
                                                    sMensaje,
                                                    sModulo_Error,
                                                    sString_Error
                                                    ,'10'
                                                   );
                          Next;
                          continue;
                       end;

                       Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
                    end;
             end;
             // FIN 30-11-2011

             // Si tiene ventas o vencimientos a ese día
             // Sumo las ventas al vigente y valorizo Con cupon
             If (Vencimientos_Al_Dia(dFecha_Inicial,Reg_val_out.Array_Mem_Desarr)) or
                (fNominales_Ventas_Dia > 0)                         or
                (dFecha_Vencimiento = dFecha_Inicial) Then
             Begin
                 // Si los nominales vigentes vienen en cero, implica verifico nemotecnico arriba
                 if (fNominales_Vigentes = 0) or (dFecha_Vencimiento = dFecha_Inicial) then
                 begin
                    sNemotecnico := FieldByName('Nemotecnico').AsString;
                    Valida_Descriptor_Flujos_Cargados( Reg_Val_In,
                                                       Reg_Val_Out,
                                                       sNemotecnico,
                                                       Fieldbyname('Emisor').asString,
                                                       Fieldbyname('Instrumento').asString,
                                                       Fieldbyname('Serie').asString,
                                                       Fieldbyname('Tipo_Instrum').asString,
                                                       Fieldbyname('Transaccion').asString
                                                      );
                     Reg_Val_In.Emision_Implicita  := FieldByName('Emision_Implicita').AsString;
                     if Reg_Val_In.Tabla_Desarr_Cargada = 'NO' then
                     begin
                        Registro_Fechas.Fecha_Compra      := FieldByName('Fecha_Operacion').AsDatetime;;
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
                                       ,sModulo_Error
                                       ,sString_Error
                                       ,Result);
                        if NOT Result then
                        begin
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                     sProceso,
                                                     dFecha_Inicial,
                                                     sLogin_Sistema,
                                                     sMensaje,
                                                     sModulo_Error,
                                                     sString_Error
                                                     ,'10'
                                                    );
                           Next;
                           continue;
                        end;
                        Reg_Val_In.Tabla_Desarr_Cargada  := 'SI'
                     end;
                 end;
                 Reg_Val_In.Con_Cupon          := True;          // Sin cupon
                 fNominales_Vigentes           := fNominales_Vigentes + fNominales_Ventas_Dia;                            //aa1
//               fNominales_Vigentes           := fNominales_Vigentes ;    // Edosan, lo comente porque al no considerar
                                                                           // los nominales vendidos, no considera los vctos q tienen venta el mismo dia
                                                                           // Habilite la linea de arriba  06/03/2006
             End;

             if (fNominales_Vigentes <= 0) then
             begin
               next;
               continue;
             end;

             ///////////////////////////////////////////////////////////////////////////////////
             //         Para grabar tabla _CC
             ///////////////////////////////////////////////////////////////////////////////////

             // COMENTADO CON FECHA 24-09-2012
             // Se usaba solo para determinar la diferencia al vencimiento que se inserta en la QS_TES_EGRING
             // E.S. & F.I. determinaron que no se ocupa para nada
             (*
             if Reg_Val_In.Con_Cupon then
             begin
                Reg_Val_In.Tipo_Instrumento   := FieldByName('Tipo_Instrum').AsString;
                Reg_Val_In.sEmisor            := FieldByName('Emisor').AsString;
                Reg_Val_In.sInstrumento       := FieldByName('Instrumento').AsString;
                Reg_Val_In.sSerie             := FieldByName('Serie').AsString;
                Reg_Val_In.Nemotecnico        := Fieldbyname('Nemotecnico').asString;
                Reg_Val_In.dTasaEmision       := FieldByName('Tasa_Emision').AsFloat;
                Reg_Val_In.sUnidadMonetaria   := FieldByName('Moneda_Instrum').AsString;
                Reg_Val_In.sTipoNominales     := FieldByName('Tipo_Nominales').AsString;
                Reg_Val_In.dFechaEmision      := dFecha_Emision;
                Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
                Reg_Val_In.dFechaCompra       := FieldByName('Fecha_Operacion').AsDatetime;
                Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
// cjf
                Reg_Val_In.dFechaPago           := dFechaPagoAOcupar;
                Reg_Val_In.dFechaCalculo      := dFecha_Inicial;
                Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
                Reg_Val_In.Valoriza_Par_Pte   := 'AMBOS';
                Reg_Val_Out.Nominales         := fNominales_Vigentes;
                Reg_Val_Out.TasaCalculo       := fTasa_Compra;
                Reg_Val_Out.PorcentajePar     := fPorcen_Valor_Par;
                Reg_Val_Out.ValorInvertidoUM  := fValor_Pte_UM_Cpa;
                Reg_Val_Out.ValorInvertidoMC  := fValor_Pte_MC_Cpa;
                Reg_Val_Out.Valor_Par_UM      := fValor_Par_UM;
                Reg_Val_Out.Valor_Par_MC      := fValor_Par_MC;
                Reg_Val_Out.fValor_Final_UM   := fValor_Final_UM;
                Reg_Val_Out.Valor_Par_Base    := fValor_Par_Base;
                Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
                Reg_Val_In.Descriptor_Cargado   := 'NO';
                Reg_Val_Out.Result_Inst_Vencido := False;// Si Retorna Verdadero el Instrumento esta Vencido

                // A Tasa de Compra
                Valoriza_Registro(Reg_Val_In,
                                  Reg_Val_Out,
                                  sModulo_Error,
                                  sString_Error,
                                  Result);
                if NOT Result then
                begin
                   Result := True;
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             sModulo_Error,
                                             sString_Error
                                             ,'10'
                                            );
                   Next;
                   continue;
                end;
                fPorcen_Valor_Par  := Reg_Val_Out.PorcentajePar   ;
                fValor_Pte_UM_Cpa  := Reg_Val_Out.ValorInvertidoUM;
                fValor_Pte_MC_Cpa  := Reg_Val_Out.ValorInvertidoMC;
                fValor_Par_UM      := Reg_Val_Out.Valor_Par_UM    ;
                fValor_Par_MC      := Reg_Val_Out.Valor_Par_MC    ;
                fValor_Final_UM    := Reg_Val_Out.fValor_Final_UM ;
                fValor_Par_Base    := Reg_Val_Out.Valor_Par_Base  ;
                sNemotecnico       := Reg_Val_In.Nemotecnico;
                dFecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
                dFecha_Emision     := Reg_Val_In.dFechaEmision;

                fDiferencia_Vencimiento_UM := 0;
                fDiferencia_Vencimiento_MC := 0;
                if FieldByName('Tipo_Instrum').AsString = 'S' then
                begin
                   Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr
                                 ,Reg_Val_Out.RegDes
                                 ,dFecha_Inicial
                                 ,True
                                 ,iCuponVigente
                                 ,sModulo_Error
                                 ,sString_Error
                                 ,Result);

                   if Not Result then
                   begin
                      Result := True;
                      Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                sProceso,
                                                dFecha_Inicial,
                                                sLogin_Sistema,
                                                sMensaje,
                                                sModulo_Error,
                                                sString_Error
                                                ,'99'
                                                );
                      Next;
                      continue;
                   end;

                   if iCuponVigente <> Reg_Val_Out.RegDes.Nro_Cupones then
                   begin
                      fDiferencia_Vencimiento_UM := fValor_Pte_UM_Cpa - fValor_Pte_UM_Cpa_Orig;
                      fDiferencia_Vencimiento_MC := fValor_Pte_MC_Cpa - fValor_Pte_MC_Cpa_Orig;
                   end
                   else
                   begin
                      fDiferencia_Vencimiento_UM := fValor_Pte_UM_Cpa;
                      fDiferencia_Vencimiento_MC := fValor_Pte_MC_Cpa;
                   end
                end;

                // Se elimina la valorizacion mercado y mixta ya que se utiliza exclusivamente para la tabla qs_res_mercado_cc
                // F.I. & GGARCIA 18-11-2010
                {
                // VALORIZACION A MERCADO O "VALUACION"
                // }
             end;
             *)

                // se dejaron inicializadas para eliminar posibles errores de Out Of Bound
                fDiferencia_Vencimiento_UM := 0;
                fDiferencia_Vencimiento_MC := 0;

                if FieldByName('Tipo_Instrum').AsString = 'S' then
                begin
                   Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr
                                 ,Reg_Val_Out.RegDes
                                 ,dFecha_Inicial
                                 ,True
                                 ,iCuponVigente
                                 ,sModulo_Error
                                 ,sString_Error
                                 ,Result);

                   if Not Result then
                   begin
                      Result := True;
                      Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                sProceso,
                                                dFecha_Inicial,
                                                sLogin_Sistema,
                                                sMensaje,
                                                sModulo_Error,
                                                sString_Error
                                                ,'99'
                                                );
                      Next;
                      continue;
                   end;
                end;

                // Nuevo While por si hay dos cortes de cupon el mismo día
                // Caso BiceVida Leasing               E.S. & F.I. 24-09-2012
                bBusca_Siguiente_Cupon := True;
                bErrorWhile            := False;
                if FieldByName('Tipo_Instrum').AsString <> 'S' then
                   if dFecha_Vencimiento <> dFecha_Inicial then
                      bBusca_Siguiente_Cupon := False;
                While bBusca_Siguiente_Cupon do
                begin
                  //Calculo Vencimiento y Registro Caja
                  bVencimiento := False;

                  // Se dejan en cero los nominales vigentes que se habianm alterado
                  // para que saliera el vencimiento del cupon en el caso de que estaba toodo pactado
                  if bTodo_Pactado then
                     fNominales_Vigentes := 0;

                  if FieldByName('Tipo_Instrum').AsString = 'S' then
                  begin
                    // Se cambia para eliminar que aparescan el cupon del día de compra  F.I 06-09-2006
                    // if (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto    = dFecha_Inicial) and
                    //   (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Cupon_Cortado = False) then

                    // Se cambia para que no aparezca el cupon que corta el dia del pago E.S. & F.I. 01/08/2008
                    // if (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = (dFecha_Inicial)) and
                    //   (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Cupon_Cortado = False)             and
                    //   (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto >
                    //                                        Fieldbyname('Fecha_Operacion').asDatetime) then

                    if (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = dFecha_Inicial) and
                       (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Cupon_Cortado = False)             and
                       (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto    > dFechaPagoAOcupar) then
                    begin
                    // Utilizado para aquellas compras que coinciden con el vcto. del cupon
                         bVencimiento := True;

                         fInteres             := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Interes *
                                                 (fNominales_Vigentes+fNominales_pactados) /   //(fNominales_Vigentes+fNominales_pactados+fNominales_Ventas_Dia)  Relacinado con marca aa1
                                                 Reg_Val_Out.RegDes.Base_Conversion;

                         fAmortizacion        := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Amortizacion   *
                                                 (fNominales_Vigentes+fNominales_pactados) /    //(fNominales_Vigentes+fNominales_pactados+fNominales_Ventas_Dia)  Relacinado con marca aa1
                                                 Reg_Val_Out.RegDes.Base_Conversion;

                         fSaldo_Insoluto      := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Saldo_Insoluto *
                                                 (fNominales_Vigentes+fNominales_pactados) /   //(fNominales_Vigentes+fNominales_pactados+fNominales_Ventas_Dia)  Relacinado con marca aa1
                                                 Reg_Val_Out.RegDes.Base_Conversion;

                         fSaldo_Insoluto_UM   := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Saldo_Insoluto * fNominales_Vigentes /
                                                 Reg_Val_Out.RegDes.Base_Conversion;
                         conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                              ,sMoneda_Conversion
                                              ,'BC'
                                              ,dFecha_Inicial
                                              ,fSaldo_Insoluto_UM
                                              ,fSaldo_Insoluto_MC
                                              ,sModulo_Error
                                              ,sString_Error
                                              ,Result);
                         if NOT Result then
                         begin
                            Result := True;
                            Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                           sProceso,
                                                           dFecha_Inicial,
                                                           sLogin_Sistema,
                                                           sMensaje,
                                                           sModulo_Error,
                                                           sString_Error
                                                           ,'99');
                            fSaldo_Insoluto_MC := fSaldo_Insoluto_UM;
                         end;

                         // Se agrega con fecha 31-10-2006 (F.I.)
                         // Faltaba la parte de reajuste de capital para titulos con esa caracteristica
                         // Para el resto queda en cero
                         fReajuste_Capital_Pagado := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Reajuste_Capital_Pagado *
                                                    (fNominales_Vigentes+fNominales_pactados) /   //(fNominales_Vigentes+fNominales_pactados+fNominales_Ventas_Dia)  Relacinado con marca aa1
                                                     Reg_Val_Out.RegDes.Base_Conversion;

                         fValor_Vencimiento_UM:= fInteres +
                                                 fReajuste_Capital_Pagado +
                                                 fAmortizacion;


                         //Llevamos Vencimiento a Moneda de la Cartera
                         //ggarcia 24-07-2013 si existe definicion dia efectivo de pago se toma la fecha tipo cambio
                         if Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Tipo_Cambio <> Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto then
                            dFecha_Valor_Vencimiento := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Tipo_Cambio
                         else
                            dFecha_Valor_Vencimiento := dia_habil_siguiente( 'CL',  dFecha_Inicial);
                         conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                              ,sMoneda_Conversion
                                              ,'BC'
                                              ,dFecha_Valor_Vencimiento
                                              ,fValor_Vencimiento_UM
                                              ,fValor_Vencimiento_MC
                                              ,sModulo_Error
                                              ,sString_Error
                                              ,Result);
                         if NOT Result then
                         begin
                           Result := True;
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                    sProceso,
                                                    dFecha_Inicial,
                                                    sLogin_Sistema,
                                                    sMensaje,
                                                    sModulo_Error,
                                                    sString_Error
                                                    ,'99'
                                                    );
                           bErrorWhile := True;
                           bBusca_Siguiente_Cupon := False;
                           //Next;
                           //continue;
                         end;
                         fValor_Vencimiento_MC := Redondeo_Moneda_Mem( sMoneda_Conversion,
                                                                       Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Tipo_Cambio,       // Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto,  Edosan, 27-07-2009
                                                                       fValor_Vencimiento_MC
                                                                       );

                         fDiferencia_Vencimiento_UM := (fDiferencia_Vencimiento_UM-fValor_Vencimiento_UM)*-1;
                         fDiferencia_Vencimiento_MC := (fDiferencia_Vencimiento_MC-fValor_Vencimiento_MC)*-1;
                     end;
                  end
                  else  // Tipo_Instrumento <> 'S'
                  begin
                      if dFecha_Vencimiento = dFecha_Inicial then
                      begin
                        bVencimiento          := True;
                        // INCLUIDO EL 12-10-2012 F.I. !!!! FALTABA CALCULAR EL VALOR PAR CON CUPON

                        Reg_Val_In.Tipo_Instrumento   := FieldByName('Tipo_Instrum').AsString;
                        Reg_Val_In.sEmisor            := FieldByName('Emisor').AsString;
                        Reg_Val_In.sInstrumento       := FieldByName('Instrumento').AsString;
                        Reg_Val_In.sSerie             := FieldByName('Serie').AsString;
                        Reg_Val_In.Nemotecnico        := Fieldbyname('Nemotecnico').asString;
                        Reg_Val_In.dTasaEmision       := FieldByName('Tasa_Emision').AsFloat;
                        Reg_Val_In.sUnidadMonetaria   := FieldByName('Moneda_Instrum').AsString;
                        Reg_Val_In.sTipoNominales     := FieldByName('Tipo_Nominales').AsString;
                        Reg_Val_In.dFechaEmision      := dFecha_Emision;
                        Reg_Val_In.dFechaVencimiento  := dFecha_Vencimiento;
                        Reg_Val_In.dFechaCompra       := FieldByName('Fecha_Operacion').AsDatetime;
                        Reg_Val_In.dFechaPago         := Fieldbyname('Fecha_de_Pago').asDatetime;
                        // cjf
                        Reg_Val_In.dFechaPago           := dFechaPagoAOcupar;
                        Reg_Val_In.dFechaCalculo      := dFecha_Inicial;
                        Reg_Val_In.sMoneda_Conversion := sMoneda_Conversion;
                        Reg_Val_In.Valoriza_Par_Pte   := 'PAR';
                        Reg_Val_Out.Nominales         := fNominales_Vigentes;
                        Reg_Val_Out.TasaCalculo       := fTasa_Compra;
                        Reg_Val_Out.PorcentajePar     := fPorcen_Valor_Par;
                        Reg_Val_Out.ValorInvertidoUM  := fValor_Pte_UM_Cpa;
                        Reg_Val_Out.ValorInvertidoMC  := fValor_Pte_MC_Cpa;
                        Reg_Val_Out.Valor_Par_UM      := fValor_Par_UM;
                        Reg_Val_Out.Valor_Par_MC      := fValor_Par_MC;
                        Reg_Val_Out.fValor_Final_UM   := fValor_Final_UM;
                        Reg_Val_Out.Valor_Par_Base    := fValor_Par_Base;
                        Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
                        Reg_Val_In.Descriptor_Cargado   := 'NO';
                        Reg_Val_Out.Result_Inst_Vencido := False;// Si Retorna Verdadero el Instrumento esta Vencido

                        // A Tasa de Compra
                        Valoriza_Registro(Reg_Val_In,
                                          Reg_Val_Out,
                                          sModulo_Error,
                                          sString_Error,
                                          Result);
                        if NOT Result then
                        begin
                           Result := True;
                           Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                     sProceso,
                                                     dFecha_Inicial,
                                                     sLogin_Sistema,
                                                     sMensaje,
                                                     sModulo_Error,
                                                     sString_Error
                                                     ,'10'
                                                    );
//                           Next;
//                           continue;
                           bErrorWhile := True;
                           bBusca_Siguiente_Cupon := False;
                        end;
                        fPorcen_Valor_Par  := Reg_Val_Out.PorcentajePar   ;
                        fValor_Pte_UM_Cpa  := Reg_Val_Out.ValorInvertidoUM;
                        fValor_Pte_MC_Cpa  := Reg_Val_Out.ValorInvertidoMC;
                        fValor_Par_UM      := Reg_Val_Out.Valor_Par_UM    ;
                        fValor_Par_MC      := Reg_Val_Out.Valor_Par_MC    ;
                        fValor_Final_UM    := Reg_Val_Out.fValor_Final_UM ;
                        fValor_Par_Base    := Reg_Val_Out.Valor_Par_Base  ;
                        sNemotecnico       := Reg_Val_In.Nemotecnico;
                        dFecha_Vencimiento := Reg_Val_In.dFechaVencimiento;
                        dFecha_Emision     := Reg_Val_In.dFechaEmision;
                        ////////////////////////////
                        iCuponVigente         := 1;
                        fValor_Vencimiento_UM := fValor_Par_UM;
                        fValor_Vencimiento_MC := fValor_Par_MC;
                        fInteres              := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Interes *
                                                 fNominales_Vigentes /
                                                 Reg_Val_Out.RegDes.Base_Conversion;
                        fSaldo_Insoluto       := 0;
                        fSaldo_Insoluto_UM    := fNominales_Vigentes;
                        //ggarcia 24-07-2013 si existe definicion dia efectivo de pago se toma la fecha tipo cambio
                        if Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Tipo_Cambio <> Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto then
                           dFecha_Valor_Vencimiento := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Tipo_Cambio
                        else
                           dFecha_Valor_Vencimiento := dia_habil_siguiente( 'CL',  dFecha_Inicial);  // E.S. & J.D. 06-11-2012, caso instrumento CERO no tomaba bien la fecha
                        conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                             ,sMoneda_Conversion
                                             ,'BC'
                                             ,dFecha_Valor_Vencimiento  // E.S. & J.D. 06-11-2012, de dFecha_Inicial paso a  dFecha_Valor_Vencimiento
                                             ,fSaldo_Insoluto_UM
                                             ,fSaldo_Insoluto_MC
                                             ,sModulo_Error
                                             ,sString_Error
                                             ,Result);
                        if NOT Result then
                        begin
                          Result := True;
                          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                         sProceso,
                                                         dFecha_Inicial,
                                                         sLogin_Sistema,
                                                         sMensaje,
                                                         sModulo_Error,
                                                         sString_Error
                                                         ,'99');
                           //fSaldo_Insoluto_MC := fSaldo_Insoluto_UM;
                           bErrorWhile := True;
                           bBusca_Siguiente_Cupon := False;
                           //Next;
                           //continue;
                        end;
                        // MALOOO  fAmortizacion         := fValor_Par_UM;
                        fAmortizacion        := Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Amortizacion   *
                                                fNominales_Vigentes /
                                                Reg_Val_Out.RegDes.Base_Conversion;
                        conversion_unidad_mon(FieldByName('Moneda_Instrum').AsString
                                             ,sMoneda_Conversion
                                             ,'BC'
                                             ,dFecha_Valor_Vencimiento  // E.S. & J.D. 06-11-2012, de dFecha_Inicial paso a  dFecha_Valor_Vencimiento
                                             ,fValor_Vencimiento_UM
                                             ,fValor_Vencimiento_MC
                                             ,sModulo_Error
                                             ,sString_Error
                                             ,Result);
                        if NOT Result then
                        begin
                          Result := True;
                          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                         sProceso,
                                                         dFecha_Inicial,
                                                         sLogin_Sistema,
                                                         sMensaje,
                                                         sModulo_Error,
                                                         sString_Error
                                                         ,'99');
                           //fSaldo_Insoluto_MC := fSaldo_Insoluto_UM;
                           bErrorWhile := True;
                           bBusca_Siguiente_Cupon := False;
                           //Next;
                           //continue;
                        end;
                        fValor_Vencimiento_MC := Redondeo_Moneda_Mem( sMoneda_Conversion,
                                                                      dFecha_Valor_Vencimiento,   //Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Tipo_Cambio,       // Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto,  Edosan, 27-07-2009
                                                                      fValor_Vencimiento_MC
                                                                      );

                        fDiferencia_Vencimiento_UM := (fDiferencia_Vencimiento_UM-fValor_Vencimiento_UM)*-1;
                        fDiferencia_Vencimiento_MC := (fDiferencia_Vencimiento_MC-fValor_Vencimiento_MC)*-1;

                      end;
                  end;

                  // Si esta registrado el vencimiento en en el sistema de cuentas corrientes
                  // No se debe generar nuevamente (filigara 10/06/2004)
                  if Existe_Registro_en_CtaCte_Mem( FieldByName('Empresa').AsString
                                                   ,FieldByName('Transaccion').AsString
                                                   ,FieldByName('Folio_interno').AsString
                                                   ,iCuponVigente) then
                  begin
                     Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                               sProceso,
                                               dFecha_Inicial,
                                               sLogin_Sistema,
                                               FieldByName('Transaccion').AsString+'-'
                                               +FieldByName('Folio_interno').AsString+'-'
                                               +FloatToStr(FieldByName('Item_Omd').AsFloat)+'-'
                                               +sNemotecnico
                                               +' Numero Cupón: '+IntToSTR(iCuponVigente),
                                               'Registro en CtaCte',
                                               'No se generó registro en Tesoreía. Vencimento ya reportado a Cuentas Corrientes'
                                               ,'99'
                                               );
                  end
                  else
                  if (bVencimiento                      ) and
                     (fValor_Vencimiento_UM <> 0        ) and
                     (sImplicancia_NO_Vcto  <> 'NO_VCTO') then
                  begin
                      // Registro del vcto en caja
                      sTipo_Movimiento := '';
                      if Transaccion_Implica_Mem('VCTO','TES(+)') then
                         sTipo_Movimiento := 'I';

                      Registro_Caja(FieldByName('Empresa').AsString,
                                    FieldByName('Cartera').AsString,
                                    FieldByName('Transaccion').AsString,
                                    FieldByName('Folio_interno').AsString,
                                    FieldByName('Item_Omd').AsFloat,
                                    dFecha_Inicial,
                                    dFecha_Inicial,
                                    'I',
                                    sMoneda_Conversion,
                                    Reg_Val_In.Nemotecnico,
                                    fInteres,
                                    fAmortizacion,
                                    fSaldo_Insoluto,
                                    (fNominales_Vigentes+fNominales_pactados),     // fNominales_Vigentes+fNominales_pactados+fNominales_Ventas_Dia  Edosan, va directamente relacionado con marca aa1,
                                    fValor_Vencimiento_UM,                         // las Ventas del dia ya estan agregadas en la marca aa1
                                    fValor_Vencimiento_MC,
                                    fDiferencia_Vencimiento_UM,
                                    fDiferencia_Vencimiento_MC,
                                    iCuponVigente,
                                    sModulo_Error,
                                    sString_Error,
                                    Result,
                                    Reg_Parametros);
                      if Not Result then
                      begin
                        Result := true;
                        Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                                  sProceso,
                                                  dFecha_Inicial,
                                                  sLogin_Sistema,
                                                  sMensaje,
                                                  sModulo_Error,
                                                  sString_Error
                                                  ,'99'
                                                  );
                        bErrorWhile := True;
                        bBusca_Siguiente_Cupon := False;
                        //Next;
                        //continue;
                      end;
                  end;  // if bVencimiento
                  if FieldByName('Tipo_Instrum').AsString <> 'S' then
                     bBusca_Siguiente_Cupon := False
                  else
                  begin
                     iCuponVigente := iCuponVigente + 1;
                     if (Reg_Val_Out.Array_Mem_Desarr[iCuponVigente].Fecha_Vcto <> dFecha_Inicial) then
                        bBusca_Siguiente_Cupon := False;
                  end;
                end; // While siguiente cuopon

                if bErrorWhile then
                begin
                  Next;
                  continue;
                end;

             /////////////////////////////////////////////////
            // end;

             // Se elimina la tabla qs_res_mercado_cc
             // F.I. & GGARCIA 18-11-2010
             {
             // Si Empresa Implica VaLORIZACION Mercado con Cupón
             if (sImplicancia_Mercado_CC = 'MERCADO_CC') and
                (NOT Reg_Parametros.bSolo_Stock)         then
             begin
                if NOT Transaccion_Implica_Mem(Fieldbyname('Transaccion').asString,'PENDIENTE') and
                   ( NOT Reg_Parametros.bSolo_Stock)         then
                   //( NOT bValorizando_Stock_Parcial) then
                   Insert_Mercado_CC(dFecha_Inicial,
                                     Fieldbyname('Empresa').asString,
                                     Fieldbyname('Cartera').asString,
                                     Fieldbyname('Transaccion').asString,
                                     Fieldbyname('Folio_Interno').asString,
                                     Fieldbyname('Item_Omd').asFloat,
                                     Fieldbyname('Emisor').asString,
                                     Fieldbyname('Instrumento').asString,
                                     SSerie,
                                    // Fieldbyname('Serie').asString,
                                     sNemotecnico,
                                     fNominales_Vigentes,
                                     fValor_Pte_MC_Cpa,
                                     fValor_Pte_MC_Mdo,
                                     fValorizacion_Mixta,
                                     fValor_Pte_UM_Cpa,
                                     fValor_Pte_UM_Mdo,
                                     fValorizacion_Mixta_UM,
                                     Reg_Val_In.Motivo_Operacion,
                                     Result,
                                     Reg_Parametros
                                    );
                if not Result then
                begin
                   Result := True;
                   Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                             sProceso,
                                             dFecha_Inicial,
                                             sLogin_Sistema,
                                             sMensaje,
                                             sModulo_Error,
                                             sString_Error
                                             ,'99'
                                             );
                end;
             end;
             }

             Next;
             Application.ProcessMessages;
         end;{while registros}
         Close;
     end; // With


     if (NOT bAbortar)       and
        (sDriver = 'ORACLE') and
        (dmBaseDatos.Database_General.InTransaction) then
        dmBaseDatos.Database_General.Commit;

     if NOT bAbortar then
     begin
         if (sDriver = 'ORACLE') and
            (NOT dmBaseDatos.Database_General.InTransaction) then
            dmBaseDatos.Database_General.StartTransaction;

         Mostrar_Mensaje('Transfiriendo Información...', bAbortar);
         Application.ProcessMessages;
         if ( sImplicancia_NO_Vcto <> 'NO_VCTO') then
            For i := 0 to VarArrayHighBound(Reg_Nominales_Pactados_Mdo.Folio_Interno, 1 )-1 do
            begin
               sMensaje := 'FOLIO OMD:' +FloatToStr(Reg_Nominales_Pactados_Mdo.Folio_Interno[i])
                          +' ITEM OMD :'+FloatToStr(Reg_Nominales_Pactados_Mdo.Item_Omd[i])
                          +' TRANSACCION :'+Reg_Nominales_Pactados_Mdo.Transaccion[i];

               // Si esta registrado el vencimiento en en el sistema de cuentas corrientes
               // No se debe generar nuevamente (filigara 10/06/2004)
               if Existe_Registro_en_CtaCte_Mem( Reg_Nominales_Pactados_Mdo.Empresa[i]
                                                ,Reg_Nominales_Pactados_Mdo.Transaccion[i]
                                                ,Reg_Nominales_Pactados_Mdo.Folio_Interno[i]
                                                ,1) then  // CuponVigente = 1
               begin
                    Insertar_Registro_Errores_Mesa(Reg_Nominales_Pactados_Mdo.Empresa[i],
                                              sProceso,
                                              dFecha_Inicial,
                                              sLogin_Sistema,
                                              Reg_Nominales_Pactados_Mdo.Transaccion[i]+'-'
                                              +Reg_Nominales_Pactados_Mdo.Folio_Interno[i]+'-'
                                              +FloatToStr(Reg_Nominales_Pactados_Mdo.Item_Omd[i]),
                                              'Registro en CtaCte',
                                              'No se generó registro en Tesorería. Vencimento ya reportado a Cuentas Corrientes'
                                              ,'99'
                                              );
                    Continue;  // para el for
               end;

               if NOT Transaccion_Implica_Mem(Reg_Nominales_Pactados_Mdo.Transaccion[i],'PENDIENTE') then
               begin
                  if (Transaccion_Implica_Mem(Reg_Nominales_Pactados_Mdo.Transaccion[i],'COMPRA')  ) or
                     (Transaccion_Implica_Mem(Reg_Nominales_Pactados_Mdo.Transaccion[i],'DERIVADO')) then
                     Registro_Caja(Reg_Nominales_Pactados_Mdo.Empresa[i],
                                   Reg_Nominales_Pactados_Mdo.Cartera[i],
                                   Reg_Nominales_Pactados_Mdo.Transaccion[i],
                                   Reg_Nominales_Pactados_Mdo.Folio_Interno[i],
                                   Reg_Nominales_Pactados_Mdo.Item_Omd[i],
                                   Reg_Nominales_Pactados_Mdo.Fecha_Vcto_Pacto[i],
                                   Reg_Nominales_Pactados_Mdo.Fecha_Vcto_Pacto[i],
                                   'I',// Ingreso Devuelvo Dinero Pactado
                                   sMoneda_Conversion,
                                   '',//Nemotecnico
                                   0,//Interes
                                   0,//Amortizacion
                                   0,//Saldo_Insoluto
                                   Reg_Nominales_Pactados_Mdo.Valor_Nominal[i],
                                   Reg_Nominales_Pactados_Mdo.Valor_Pactado_UM[i],
                                   Reg_Nominales_Pactados_Mdo.Valor_Pactado_MC[i],
                                   0,
                                   0,
                                   1,//iCuponVigente,
                                   sModulo_Error,
                                   sString_Error,
                                   Result,
                                   Reg_Parametros)
                  else
                     Registro_Caja(Reg_Nominales_Pactados_Mdo.Empresa[i],
                                   Reg_Nominales_Pactados_Mdo.Cartera[i],
                                   Reg_Nominales_Pactados_Mdo.Transaccion[i],
                                   Reg_Nominales_Pactados_Mdo.Folio_Interno[i],
                                   Reg_Nominales_Pactados_Mdo.Item_Omd[i],
                                   Reg_Nominales_Pactados_Mdo.Fecha_Vcto_Pacto[i],
                                   Reg_Nominales_Pactados_Mdo.Fecha_Vcto_Pacto[i],
                                   'E',// Ingreso Devuelvo Dinero Pactado
                                   sMoneda_Conversion,
                                   '',//Nemotecnico
                                   0,//Interes
                                   0,//Amortizacion
                                   0,
                                   Reg_Nominales_Pactados_Mdo.Valor_Nominal[i],
                                   Reg_Nominales_Pactados_Mdo.Valor_Pactado_UM[i],
                                   Reg_Nominales_Pactados_Mdo.Valor_Pactado_MC[i],
                                   0,
                                   0,
                                   1,//iCuponVigente,
                                   sModulo_Error,
                                   sString_Error,
                                   Result,
                                   Reg_Parametros);
                  if Not Result then
                  begin
                      Result := true;
                      Insertar_Registro_Errores_Mesa(Reg_Nominales_Pactados_Mdo.Empresa[i],
                                                sProceso,
                                                dFecha_Inicial,
                                                sLogin_Sistema,
                                                sMensaje,
                                                sModulo_Error,
                                                sString_Error
                                                ,'99'
                                                );
                  end;
               end;
            end; //For

         if (sDriver = 'ORACLE') and
            (dmBaseDatos.Database_General.InTransaction) then
            dmBaseDatos.Database_General.Commit;

         //COMIENZA TRANSACCION EN LA BASE DE DATOS

         Mostrar_Mensaje('Transfiriendo Información...', bAbortar);
         Application.ProcessMessages;
         with DMValorizacion,QRY_General do
         begin
         if Reg_Parametros.bGenera_Stock then
         begin
            if (sDriver = 'ORACLE') and
               (NOT dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.StartTransaction;

            Close;
            Sql.Clear;
            Sql.Add( 'DELETE FROM QS_TRA_OMD_STK_RF ' );
            Sql.Add('  WHERE Empresa IN '+sString_Empresas );
            if ( Reg_Parametros.bCarteras )    and
               ( Trim(sString_Carteras) <> '') then
              Sql.Add('  AND  CARTERA IN '+sString_Carteras );
            if (    Reg_Parametros.bEmisores)   and
               ( Trim(sString_Emisores) <> '') then
               Sql.Add( ' AND Emisor in ' + sString_Emisores  );
            if ( Reg_Parametros.bInstrumentos ) and
               ( Trim(sString_Instrumentos) <> '') then
                Sql.Add( ' AND Instrumento in ' + sString_Instrumentos );
            if Reg_Parametros.bSerie then
            begin
               Sql.Add( ' AND Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                       +' WHERE z.Parametro = ''STK_SERIE'''
                                       +'   AND z.Proceso   = :Proceso'
                                       +' )' );
               Parambyname('Proceso').asString := IntToStr(Application.Handle);
            end;

            if Reg_Parametros.bNemotecnico then
            begin
              Sql.Add( ' AND Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                            +' WHERE w.Parametro = ''STK_NEMOS'''
                                            +'   AND w.Proceso   = :Proceso'
                                            +' )' );
              Parambyname('Proceso').asString := IntToStr(Application.Handle);
            end;

            if Reg_Parametros.bFolios then
            begin
              if sDriver = 'MSSQL' then
                 Sql.Add( ' AND convert(Integer, Folio_Interno) between :Folio_desde and :Folio_hasta ')
              else
                 Sql.Add( ' AND TO_NUMBER(Folio_Interno) between :Folio_desde and :Folio_hasta ');

              Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
              Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
            end;

            if Reg_Parametros.bExcepcion then
            begin
              Sql.Add( ' AND Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u'
                                             +'   where u.id = :id ');
              Parambyname('id').AsFloat := Application.Handle;
            end;

             try
               ExecSql;
             except on E: EDBEngineError do
               begin
                 ShowError_SQL(E
                              ,Sql
                              ,'');
                 Close;
                 bAbortar := True;
                 if (sDriver = 'ORACLE') and
                    (dmBaseDatos.Database_General.InTransaction) then
                    dmBaseDatos.Database_General.RollBack;

                 try
                 if NOT Reg_Parametros.bSolo_Stock then
                 begin
                    DMValorizacion.Tmp_Res_Mercado.Close;
                    DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                    DMValorizacion.Tmp_Res_Mercado_CC.Close;
                    DMValorizacion.Tmp_RES_PROVISION.Close;
                    if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                       DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                 end;
                 DMValorizacion.Tmp_Stock.Close;
                 DMValorizacion.Tmp_Res_Proceso.Close;
                 except
                 end;
                 Exit;
               end;
             end;
             Close;

             ///////// inicio ggarcia 12-2011 borra los folios que fueron traspasados a otras o desde otras carteras,
             /////////                        para que no se duplique el folio_interno.
             Sql.Clear;
             Sql.Add('DELETE FROM QS_TRA_OMD_STK_RF ' );
             Sql.Add(' WHERE Empresa IN '+sString_Empresas
                    +'   AND FECHA_STOCK <> :fecha '
                    +'   AND FOLIO_INTERNO IN (SELECT FOLIO_INTERNO_OMD '
                    +'                           FROM QS_TRA_OMD_TRAZA '
                    +'                          WHERE QS_TRA_OMD_TRAZA.folio_interno_omd   = QS_TRA_OMD_STK_RF.folio_interno '
                    +'                            AND QS_TRA_OMD_TRAZA.transaccion_omd     = QS_TRA_OMD_STK_RF.transaccion '
                    +'                            AND QS_TRA_OMD_TRAZA.item_movimiento     = QS_TRA_OMD_STK_RF.item_omd '
                    +'                            AND QS_TRA_OMD_TRAZA.empresa_omd         = QS_TRA_OMD_STK_RF.empresa ');
             if (Reg_Parametros.bCarteras) and (Trim(sString_Carteras) <> '') then
                Sql.Add('                         AND (QS_TRA_OMD_TRAZA.CARTERA_ORIGEN_MOV IN '+sString_Carteras +' OR QS_TRA_OMD_TRAZA.CARTERA_MOVIMIENTO IN '+sString_Carteras+')');
             Sql.Add('                        )' );
             Parambyname('fecha').AsDateTime := dFecha_Inicial;
             try
               ExecSql;
             except on E: EDBEngineError do
               begin
                 ShowError_SQL(E
                              ,Sql
                              ,'');
                 Close;
                 bAbortar := True;
                 if (sDriver = 'ORACLE') and
                    (dmBaseDatos.Database_General.InTransaction) then
                    dmBaseDatos.Database_General.RollBack;

                 try
                 if NOT Reg_Parametros.bSolo_Stock then
                 begin
                    DMValorizacion.Tmp_Res_Mercado.Close;
                    DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                    DMValorizacion.Tmp_Res_Mercado_CC.Close;
                    DMValorizacion.Tmp_RES_PROVISION.Close;
                    if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                       DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                 end;
                 DMValorizacion.Tmp_Stock.Close;
                 DMValorizacion.Tmp_Res_Proceso.Close;
                 except
                 end;
                 Exit;
               end;
             end;
             Close;
             ///////// fin ggarcia 12-2011

             if (sDriver = 'ORACLE') and
                (dmBaseDatos.Database_General.InTransaction) then
                 dmBaseDatos.Database_General.Commit;
         end;

         Close;
         if NOT Reg_Parametros.bSolo_Stock then
         begin
            //Borro Valores de Tabla de Mercado AD
            if ( sImplicancia_Mercado = 'MERCADO' ) and
              ( NOT Reg_Parametros.bSolo_Stock)         then
               //(NOT bValorizando_Stock_Parcial)     then
            begin
               if  (sDriver = 'ORACLE') and
                   (NOT dmBaseDatos.Database_General.InTransaction) then
                   dmBaseDatos.Database_General.StartTransaction;

               Sql.Clear;
               Sql.Add( 'DELETE FROM QS_RES_MERCADO_AD '
                       +' WHERE Fecha_Cierre = :Fecha_Cierre'
                       +'  AND Empresa IN '+sString_Empresas
                       );
               if ( Reg_Parametros.bCarteras )    and
                  ( Trim(sString_Carteras) <> '') then
                     Sql.add(' AND Cartera IN '+sString_Carteras );
               if Reg_Parametros.bEmisores then
                  Sql.Add( ' AND Emisor in ' + sString_Emisores  );
               if Reg_Parametros.bInstrumentos then
                  Sql.Add( ' AND Instrumento in ' + sString_Instrumentos );

               if Reg_Parametros.bSerie then
               begin
                 Sql.Add( ' AND Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                         +' WHERE z.Parametro = ''STK_SERIE'''
                                         +'   AND z.Proceso   = :Proceso'
                                         +' )' );
                 Parambyname('Proceso').asString := IntToStr(Application.Handle);
               end;
               if Reg_Parametros.bNemotecnico then
               begin
                 Sql.Add( ' AND Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                               +' WHERE w.Parametro = ''STK_NEMOS'''
                                               +'   AND w.Proceso   = :Proceso'
                                               +' )' );
                 Parambyname('Proceso').asString := IntToStr(Application.Handle);
               end;
               if Reg_Parametros.bFolios then
               begin
                 if sDriver = 'MSSQL' then
                    Sql.Add( ' AND convert(Integer, Folio_Interno) between :Folio_desde and :Folio_hasta ')
                 else
                    Sql.Add( ' AND TO_NUMBER(Folio_Interno) between :Folio_desde and :Folio_hasta ');

                 Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
                 Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
               end;

               if Reg_Parametros.bExcepcion then
               begin
                 Sql.Add( ' AND Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u'
                                                +'   where u.id = :id )');
                 Parambyname('id').AsFloat := Application.Handle;
               end;
               Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial + 1;
             //  Parambyname('Proceso').asString := IntToStr(Application.Handle);
               try
                 ExecSql;
               except on E: EDBEngineError do
                 begin
                   ShowError_SQL(E
                                ,Sql
                                ,'');
                   Close;
                   bAbortar := True;
                   if (sDriver = 'ORACLE') and
                      (dmBaseDatos.Database_General.InTransaction) then
                       dmBaseDatos.Database_General.RollBack;

                   try
                   if NOT Reg_Parametros.bSolo_Stock then
                   begin
                      DMValorizacion.Tmp_Res_Mercado.Close;
                      DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                      DMValorizacion.Tmp_Res_Mercado_CC.Close;
                      DMValorizacion.Tmp_RES_PROVISION.Close;
                      if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                         DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                   end;
                   DMValorizacion.Tmp_Stock.Close;
                   DMValorizacion.Tmp_Res_Proceso.Close;
                   except
                   end;
                   Exit;
                 end;
               end;
               Close;

               if (sDriver = 'ORACLE') and
                  (dmBaseDatos.Database_General.InTransaction) then
                  dmBaseDatos.Database_General.Commit;
            end;

            // Se elimina la tabla qs_res_mercado_cc
            // F.I. & GGARCIA 18-11-2010
            {
            //Borro Valores de Tabla de Mercado CC
            //if (NOT bValorizando_Stock_Parcial) then
            if ( NOT Reg_Parametros.bSolo_Stock) then
            begin
               if (sDriver = 'ORACLE') and
                  (NOT dmBaseDatos.Database_General.InTransaction) then
                  dmBaseDatos.Database_General.StartTransaction;

               Close;
               Sql.Clear;
               Sql.Add( 'DELETE FROM QS_RES_MERCADO_CC '
                       +' WHERE Fecha    = :Fecha_Cierre'
                       +'  AND Empresa IN '+sString_Empresas
                      );
               if ( Reg_Parametros.bCarteras )    and
                  ( Trim(sString_Carteras) <> '') then
                 Sql.add(' AND Cartera IN '+sString_Carteras );

               if Reg_Parametros.bEmisores then
                  Sql.Add( ' AND Emisor in ' + sString_Emisores  );
               if Reg_Parametros.bInstrumentos then
                  Sql.Add( ' AND Instrumento in ' + sString_Instrumentos );
               if Reg_Parametros.bSerie then
               begin
                 Sql.Add( ' AND Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                         +' WHERE z.Parametro = ''STK_SERIE'''
                                         +'   AND z.Proceso   = :Proceso'
                                         +' )' );
                 Parambyname('Proceso').asString := IntToStr(Application.Handle);
               end;
               if Reg_Parametros.bNemotecnico then
               begin
                 Sql.Add( ' AND Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                               +' WHERE w.Parametro = ''STK_NEMOS'''
                                               +'   AND w.Proceso   = :Proceso'
                                               +' )' );
                 Parambyname('Proceso').asString := IntToStr(Application.Handle);
               end;
               if Reg_Parametros.bFolios then
               begin
                 if sDriver = 'MSSQL' then
                    Sql.Add( ' AND convert(Integer, Folio_Interno) between :Folio_desde and :Folio_hasta ')
                 else
                    Sql.Add( ' AND TO_NUMBER(Folio_Interno) between :Folio_desde and :Folio_hasta ');

                 Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
                 Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
               end;

               if Reg_Parametros.bExcepcion then
               begin
                 Sql.Add( ' AND Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u '
                                                +'   where u.id = :id ');
                 Parambyname('id').AsFloat := Application.Handle;
               end;

                Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
                try
                  ExecSql;
                except on E: EDBEngineError do
                  begin
                   ShowError_SQL(E
                                ,Sql
                                ,'');
                    Close;
                    bAbortar := True;

                    if (sDriver = 'ORACLE') and
                       (dmBaseDatos.Database_General.InTransaction) then
                        dmBaseDatos.Database_General.RollBack;
                    try
                    if NOT Reg_Parametros.bSolo_Stock then
                    begin
                       DMValorizacion.Tmp_Res_Mercado.Close;
                       DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                       DMValorizacion.Tmp_Res_Mercado_CC.Close;
                       DMValorizacion.Tmp_RES_PROVISION.Close;
                    end;
                    DMValorizacion.Tmp_Stock.Close;
                    DMValorizacion.Tmp_Res_Proceso.Close;
                    except
                    end;
                    Exit;
                  end;
                end;
                Close;

                if  (sDriver = 'ORACLE') and
                    (dmBaseDatos.Database_General.InTransaction) then
                     dmBaseDatos.Database_General.Commit;
            end;
            }
            
            // Borramos datos de Tabla de Mercado
            //if (NOT bValorizando_Stock_Parcial) then
            if ( NOT Reg_Parametros.bSolo_Stock) then
            begin
               Mostrar_Mensaje('Transfiriendo Valores Mercado...', bAbortar);
               Application.ProcessMessages;

               if (sDriver = 'ORACLE') and
                  (NOT dmBaseDatos.Database_General.InTransaction) then
                  dmBaseDatos.Database_General.StartTransaction;

               Close;
               Sql.Clear;
               Sql.Add( ' DELETE FROM QS_RES_MERCADO'
                       +' WHERE Fecha_Cierre = :Fecha_Cierre'
                          +'  AND Empresa IN '+sString_Empresas
                      );
               if ( Reg_Parametros.bCarteras )    and
                  ( Trim(sString_Carteras) <> '') then
                 Sql.Add('  AND  CARTERA IN  '+sString_Carteras );

               if Reg_Parametros.bEmisores then
                  Sql.Add( ' AND Emisor in ' + sString_Emisores  );

               if Reg_Parametros.bInstrumentos then
                  Sql.Add( ' AND Instrumento in ' + sString_Instrumentos );

               if Reg_Parametros.bSerie then
               begin
                 Sql.Add( ' AND Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                         +' WHERE z.Parametro = ''STK_SERIE'''
                                         +'   AND z.Proceso   = :Proceso'
                                         +' )' );
                 Parambyname('Proceso').asString := IntToStr(Application.Handle);
               end;
               if Reg_Parametros.bNemotecnico then
               begin
                 Sql.Add( ' AND Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                               +' WHERE w.Parametro = ''STK_NEMOS'''
                                               +'   AND w.Proceso   = :Proceso'
                                               +' )' );
                 Parambyname('Proceso').asString := IntToStr(Application.Handle);
               end;
               if Reg_Parametros.bFolios then
               begin
                 if sDriver = 'MSSQL' then
                    Sql.Add( ' AND convert(Integer, Folio_Interno) between :Folio_desde and :Folio_hasta ')
                 else
                    Sql.Add( ' AND TO_NUMBER(Folio_Interno) between :Folio_desde and :Folio_hasta ');

                 Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
                 Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
               end;

               if Reg_Parametros.bExcepcion then
               begin
                 Sql.Add( ' AND Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u'
                                                +'   where u.id = :id ');
                 Parambyname('id').AsFloat := Application.Handle;
               end;
               Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
               try
                 ExecSql;
               except on E: EDBEngineError do
                 begin
                    ShowError_SQL(E
                                  ,Sql
                                  ,'');
                    Close;
                    bAbortar := True;
                    if  (sDriver = 'ORACLE') and
                        (dmBaseDatos.Database_General.InTransaction) then
                        dmBaseDatos.Database_General.RollBack;

                    try
                    if NOT Reg_Parametros.bSolo_Stock then
                    begin
                       DMValorizacion.Tmp_Res_Mercado.Close;
                       DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                       DMValorizacion.Tmp_Res_Mercado_CC.Close;
                       DMValorizacion.Tmp_RES_PROVISION.Close;
                       if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                          DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                    end;
                    DMValorizacion.Tmp_Stock.Close;
                    DMValorizacion.Tmp_Res_Proceso.Close;
                    except
                    end;
                    Exit;
                 end;
               end;
               Close;
            end;

{           // NO PUEDO ELIMINAR LOS REGISTROS, SOLO INSERTAR
            if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
            begin
               // Borramos datos de Tabla de Mercado
               //if (NOT bValorizando_Stock_Parcial) then
               if ( NOT Reg_Parametros.bSolo_Stock) then
               begin
                  Mostrar_Mensaje('Transfiriendo Valores Interfaz ERP...', bAbortar);
                  Application.ProcessMessages;

                  if (sDriver = 'ORACLE') and
                     (NOT dmBaseDatos.Database_General.InTransaction) then
                     dmBaseDatos.Database_General.StartTransaction;

                  Close;
                  Sql.Clear;
                  Sql.Add( ' DELETE FROM ETLODSQS20'
                          +' WHERE ID_FECHA_PROCESO  = :Fecha_Cierre'
                          +'   AND DS_CIA_ORIGEN     = :Empresa'
                          +'   AND ID_TIPO_OPERACION = :Transaccion'
//                          +'   AND ID_FOLIO          = :Folio_Interno'
                          );
                  if ( Reg_Parametros.bCarteras )    and
                     ( Trim(sString_Carteras) <> '') then
                    Sql.Add('  AND  ID_CARTERA IN  '+sString_Carteras );

                  if Reg_Parametros.bEmisores then
                     Sql.Add( ' AND ID_EMISOR in ' + sString_Emisores  );

                  if Reg_Parametros.bInstrumentos then
                     Sql.Add( ' AND ID_INSTRUMENTO in ' + sString_Instrumentos );

                  if Reg_Parametros.bNemotecnico then
                  begin
                    Sql.Add( ' AND ID_NEMOTECNICO in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                                  +' WHERE w.Parametro = ''STK_NEMOS'''
                                                  +'   AND w.Proceso   = :Proceso'
                                                  +' )' );
                    Parambyname('Proceso').asString := IntToStr(Application.Handle);
                  end;
                  if Reg_Parametros.bFolios then
                  begin
                    if sDriver = 'MSSQL' then
                       Sql.Add( ' AND convert(Integer, ID_FOLIO) between :Folio_desde and :Folio_hasta ')
                    else
                       Sql.Add( ' AND TO_NUMBER(ID_FOLIO) between :Folio_desde and :Folio_hasta ');

                    Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
                    Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
                  end;

                  if Reg_Parametros.bExcepcion then
                  begin
                    Sql.Add( ' AND ID_FOLIO in ( Select u.Folio_interno from QS_TMP_Excepcion u'
                                                   +'   where u.id = :id ');
                    Parambyname('id').AsFloat := Application.Handle;
                  end;
                  Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
                  ParamByName('Empresa').AsString        := 'CDS VIDA';
                  ParamByName('Transaccion').AsString    := 'CRVNC';   // Mientras

                  try
                    ExecSql;
                  except on E: EDBEngineError do
                    begin
                       ShowError_SQL(E
                                     ,Sql
                                     ,'');
                       Close;
                       bAbortar := True;
                       if  (sDriver = 'ORACLE') and
                           (dmBaseDatos.Database_General.InTransaction) then
                           dmBaseDatos.Database_General.RollBack;

                       try
                       if NOT Reg_Parametros.bSolo_Stock then
                       begin
                          DMValorizacion.Tmp_Res_Mercado.Close;
                          DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                          DMValorizacion.Tmp_Res_Mercado_CC.Close;
                          DMValorizacion.Tmp_RES_PROVISION.Close;
                       end;
                       DMValorizacion.Tmp_Stock.Close;
                       DMValorizacion.Tmp_Res_Proceso.Close;
                       except
                       end;
                       Exit;
                    end;
                  end;
                  Close;
               end;
            end;
}
            if (sDriver = 'ORACLE') and
               (dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.Commit;

            Mostrar_Mensaje('Transfiriendo Valores Instrumentos...', bAbortar);
            Application.ProcessMessages;
            if (sDriver = 'ORACLE') and
               (NOT dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.StartTransaction;

            Close;
            Sql.Clear;
            Sql.Add( ' DELETE FROM QS_RES_PROVISION'
                    +' WHERE Fecha_Cierre = :Fecha_Cierre'
                       +'  AND Empresa IN '+sString_Empresas
                   );
            if ( Reg_Parametros.bCarteras )    and
               ( Trim(sString_Carteras) <> '') then
              Sql.Add('  AND  CARTERA IN  '+sString_Carteras );

            if Reg_Parametros.bEmisores then
               Sql.Add( ' AND Emisor in ' + sString_Emisores  );

            if Reg_Parametros.bInstrumentos then
               Sql.Add( ' AND Instrumento in ' + sString_Instrumentos );

            if Reg_Parametros.bSerie then
            begin
              Sql.Add( ' AND Serie in ( SELECT z.Valor FROM QS_SYS_PARAM_PROCESO z'
                                      +' WHERE z.Parametro = ''STK_SERIE'''
                                      +'   AND z.Proceso   = :Proceso'
                                      +' )' );
              Parambyname('Proceso').asString := IntToStr(Application.Handle);
            end;

            if Reg_Parametros.bNemotecnico then
            begin
              Sql.Add( ' AND Nemotecnico in ( SELECT w.Valor FROM QS_SYS_PARAM_PROCESO w'
                                            +' WHERE w.Parametro = ''STK_NEMOS'''
                                            +'   AND w.Proceso   = :Proceso'
                                            +' )' );
              Parambyname('Proceso').asString := IntToStr(Application.Handle);
            end;

            if Reg_Parametros.bFolios then
            begin
              if sDriver = 'MSSQL' then
                 Sql.Add( ' AND convert(Integer, Folio_Interno) between :Folio_desde and :Folio_hasta ')
              else
                 Sql.Add( ' AND TO_NUMBER(Folio_Interno) between :Folio_desde and :Folio_hasta ');

              Parambyname('Folio_desde').AsInteger := Reg_Parametros.fFolio_desde;
              Parambyname('Folio_hasta').AsInteger := Reg_Parametros.fFolio_hasta;
            end;

            if Reg_Parametros.bExcepcion then
            begin
              Sql.Add( ' AND Folio_Interno in ( Select u.Folio_interno from QS_TMP_Excepcion u'
                                             +'   where u.id = :id ');
              Parambyname('id').AsFloat := Application.Handle;
            end;

            Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
            try
              ExecSql;
            except on E: EDBEngineError do
              begin
                 ShowError_SQL(E
                               ,Sql
                               ,'');
                 Close;
                 bAbortar := True;
                 if  (sDriver = 'ORACLE') and
                     (dmBaseDatos.Database_General.InTransaction) then
                     dmBaseDatos.Database_General.RollBack;

                 try
                 if NOT Reg_Parametros.bSolo_Stock then
                 begin
                    DMValorizacion.Tmp_Res_Mercado.Close;
                    DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                    DMValorizacion.Tmp_Res_Mercado_CC.Close;
                    DMValorizacion.Tmp_RES_PROVISION.Close;
                    if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                       DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                 end;
                 DMValorizacion.Tmp_Stock.Close;
                 DMValorizacion.Tmp_Res_Proceso.Close;
                 except
                 end;
                 Exit;
              end;
            end;
            Close;
            if (sDriver = 'ORACLE') and
               (dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.Commit;

           end;{solo stock}
         end;{with Qry_General}

         //Transfiero Stock
         if Reg_Parametros.bGenera_Stock then
         begin
            if (sDriver = 'ORACLE') and
               (NOT dmBaseDatos.Database_General.InTransaction) then
                dmBaseDatos.Database_General.StartTransaction;

            Mostrar_Mensaje('Transfiriendo Stock...', bAbortar);
            Application.ProcessMessages;

            try
               fTotal_Registros_Mercado := DMValorizacion.Tmp_Stock.RecordCount;
               fTotal_Registros         := 0;
               DMValorizacion.Tmp_Stock.First;
               while not DMValorizacion.Tmp_Stock.eof do
               begin
                  with DMValorizacion.Qry_QS_TRA_OMD_STK_RF do
                  begin
                     Parambyname('Empresa').asString              := DMValorizacion.Tmp_Stock.FieldByName('Empresa').AsString;
                     Parambyname('Transaccion').asString          := DMValorizacion.Tmp_Stock.FieldByName('Transaccion').AsString;
                     Parambyname('Folio_interno').asString        := DMValorizacion.Tmp_Stock.FieldByName('Folio_interno').AsString;
                     Parambyname('Item_OMD').asFloat              := DMValorizacion.Tmp_Stock.FieldByName('Item_OMD').asFloat;
                     Parambyname('Fecha_Operacion').asDatetime    := DMValorizacion.Tmp_Stock.FieldByName('Fecha_Operacion').asDatetime;
                     Parambyname('Fecha_Stock').asDatetime        := DMValorizacion.Tmp_Stock.FieldByName('Fecha_Stock').asDatetime;
                     Parambyname('Nemotecnico').asString          := DMValorizacion.Tmp_Stock.FieldByName('Nemotecnico').AsString;
                     Parambyname('Emisor').asString               := DMValorizacion.Tmp_Stock.FieldByName('Emisor').AsString;
                     Parambyname('Instrumento').asString          := DMValorizacion.Tmp_Stock.FieldByName('Instrumento').AsString;
                     Parambyname('Serie').asString                := DMValorizacion.Tmp_Stock.FieldByName('Serie').AsString;
                     Parambyname('Fecha_emision').asDatetime      := DMValorizacion.Tmp_Stock.FieldByName('Fecha_emision').asDatetime;
                     Parambyname('Fecha_vencimiento').asDatetime  := DMValorizacion.Tmp_Stock.FieldByName('Fecha_vencimiento').asDatetime;
                     Parambyname('Valor_Nominal').asFloat         := DMValorizacion.Tmp_Stock.FieldByName('Valor_Nominal').asFloat;
                     Parambyname('Valor_Nominal_Calculo').asFloat := DMValorizacion.Tmp_Stock.FieldByName('Valor_Nominal_Calculo').asFloat;
                     Parambyname('Tasa_Emision').asFloat          := DMValorizacion.Tmp_Stock.FieldByName('Tasa_Emision').asFloat;
                     Parambyname('Tasa_Mercado').asFloat          := DMValorizacion.Tmp_Stock.FieldByName('Tasa_Mercado').asFloat;
                     Parambyname('Moneda_Instrum').asString       := DMValorizacion.Tmp_Stock.FieldByName('Moneda_Instrum').AsString;
                     Parambyname('Tasa_Base_Par').asString        := DMValorizacion.Tmp_Stock.FieldByName('Tasa_Base_Par').AsString;
                     Parambyname('Tasa_Base_Tir').asString        := DMValorizacion.Tmp_Stock.FieldByName('Tasa_Base_Tir').AsString;
                     Parambyname('Valor_Pte_um_Cpa').asFloat      := DMValorizacion.Tmp_Stock.FieldByName('Valor_Pte_um_Cpa').asFloat;
                     Parambyname('Valor_Pte_mc_Cpa').asFloat      := DMValorizacion.Tmp_Stock.FieldByName('Valor_Pte_mc_Cpa').asFloat;
                     Parambyname('Porcen_Valor_Par').asFloat      := DMValorizacion.Tmp_Stock.FieldByName('Porcen_Valor_Par').asFloat;
                     Parambyname('Cartera').asString              := DMValorizacion.Tmp_Stock.FieldByName('Cartera').AsString;
                     Parambyname('Moneda_Pacto').asString         := DMValorizacion.Tmp_Stock.FieldByName('Moneda_Pacto').AsString;
                     Parambyname('Tasa_Pacto').asFloat            := DMValorizacion.Tmp_Stock.FieldByName('Tasa_Pacto').asFloat;
                     Parambyname('Tasa_Base_Pacto').asString      := DMValorizacion.Tmp_Stock.FieldByName('Tasa_Base_Pacto').AsString;
                     Parambyname('Fecha_vcto_Pacto').asDatetime   := DMValorizacion.Tmp_Stock.FieldByName('Fecha_vcto_Pacto').asDatetime;
                     Parambyname('Tipo_Nominales').asString       := DMValorizacion.Tmp_Stock.FieldByName('Tipo_Nominales').AsString;
                     Parambyname('Custodia').asString             := DMValorizacion.Tmp_Stock.FieldByName('Custodia').AsString;
                     Parambyname('Plazo_Al_Vcto').asFloat         := DMValorizacion.Tmp_Stock.FieldByName('Plazo_Al_Vcto').asFloat;
                     Parambyname('Tipo_Instrum').asString         := DMValorizacion.Tmp_Stock.FieldByName('Tipo_Instrum').AsString;
                     Parambyname('Valor_Pte_um_Mdo').asFloat      := DMValorizacion.Tmp_Stock.FieldByName('Valor_Pte_um_Mdo').asFloat;
                     Parambyname('Valor_Pte_mc_Mdo').asFloat      := DMValorizacion.Tmp_Stock.FieldByName('Valor_Pte_mc_Mdo').asFloat;
                     Parambyname('Tasa_Mercado_Mdo').asFloat      := DMValorizacion.Tmp_Stock.FieldByName('Tasa_Mercado_Mdo').asFloat;
                     Parambyname('Duration').asFloat              := DMValorizacion.Tmp_Stock.FieldByName('Duration').asFloat;
                     Parambyname('Plazo_Vcto').asString           := DMValorizacion.Tmp_Stock.FieldByName('Plazo_Vcto').AsString;
                     Parambyname('Diferencia').asFloat            := DMValorizacion.Tmp_Stock.FieldByName('Diferencia').asFloat;
                     Parambyname('Valorizacion_Mixta').asFloat    := DMValorizacion.Tmp_Stock.FieldByName('Valorizacion_Mixta').asFloat;
                     Parambyname('Precio_Mixto').asFloat          := DMValorizacion.Tmp_Stock.FieldByName('Precio_Mixto').asFloat;
                     Parambyname('Motivo_Inv').asString           := DMValorizacion.Tmp_Stock.FieldByName('Motivo_Inv').AsString;
                     Parambyname('Clasif_Riesgo').asString        := DMValorizacion.Tmp_Stock.FieldByName('Clasif_Riesgo').AsString;
                     Parambyname('Cupones_Cortados').asFloat      := DMValorizacion.Tmp_Stock.FieldByName('Cupones_Cortados').asFloat;
                     Parambyname('Valor_Par_UM').AsFloat          := DMValorizacion.Tmp_Stock.FieldByName('Valor_Par_UM').AsFloat;
                     Parambyname('Valor_Par_MC').AsFloat          := DMValorizacion.Tmp_Stock.FieldByName('Valor_Par_MC').AsFloat;
                     Parambyname('Saldo_Insoluto_UM').AsFloat     := DMValorizacion.Tmp_Stock.FieldByName('Saldo_Insoluto_UM').AsFloat;
                     Parambyname('Saldo_Insoluto_MC').AsFloat     := DMValorizacion.Tmp_Stock.FieldByName('Saldo_Insoluto_MC').AsFloat;
                     ExecSql;
                  end;
                  DMValorizacion.Tmp_Stock.Next;
                  fTotal_Registros := fTotal_Registros + 1;

                  sMensaje  := ' Registro( Stock ) : ' + FloatToStr( Trunc(fTotal_Registros /fTotal_Registros_Mercado * 100) )+'%';
                  Mostrar_Mensaje(sMensaje, bAbortar);
               end;

            except on E: EDBEngineError do
               begin
                  ShowError(E);
                  Application.MessageBox(' Error Al Transferir Datos, Tabla QS_TRA_OMD_STK_RF'
                                         ,'Valorización Posición'
                                         ,mb_Ok + MB_IconError
                                        );
                   if (sDriver = 'ORACLE') and
                      (dmBaseDatos.Database_General.InTransaction) then
                      dmBaseDatos.Database_General.RollBack;

                  bAbortar := True;

                  try
                  if NOT Reg_Parametros.bSolo_Stock then
                  begin
                     DMValorizacion.Tmp_Res_Mercado.Close;
                     DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                     DMValorizacion.Tmp_Res_Mercado_CC.Close;
                     DMValorizacion.Tmp_RES_PROVISION.Close;
                     if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                        DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                  end;
                  DMValorizacion.Tmp_Stock.Close;
                  DMValorizacion.Tmp_Res_Proceso.Close;
                  except
                  end;
                  Exit;
               end;
            end;
            sMensaje  := ' Transferencia de stock concluida  ';
            Mostrar_Mensaje(sMensaje, bAbortar);

            if (sDriver = 'ORACLE') and
               (dmBaseDatos.Database_General.InTransaction) then
            begin
            sMensaje  := ' Cerrando transaccion (commit) ';
            Mostrar_Mensaje(sMensaje, bAbortar);

                dmBaseDatos.Database_General.Commit;
            end;
            sMensaje  := ' Borrando registro de stock temporal ';
            Mostrar_Mensaje(sMensaje, bAbortar);

            DMValorizacion.Tmp_Stock.EmptyTable;
         end;

         with DMValorizacion,QRY_General do
         begin
            // Valorización Parcial de STOCK
            if bValorizando_Stock_Parcial then
            begin
                fcuenta_pasadas := 1;
                sMensaje  := ' Preparando log de stock parcial  ';
                Mostrar_Mensaje(sMensaje, bAbortar);

                Close;
                Sql.Clear;
                SQL.Add(' SELECT z.Empresa, z.Cartera FROM QS_SYS_PARAM_EMPRESA z'
                       +' WHERE z.Empresa IN '+ sString_Empresas
                       +'   AND z.Pid     = :Pid'
                       );
                Parambyname('Pid').asFloat := Application.Handle;
                Open;

                While NOT Eof do
                begin
                    QRY_General2.Close;
                    QRY_General2.Sql.Clear;
                    QRY_General2.Sql.Add( 'DELETE FROM QS_TRA_OMD_STK_RF_LOG'
                                         +' WHERE Empresa       = :Empresa'
                                         +'   AND Cartera       = :Cartera'
                                         +'   AND Fecha_Cierre  = :Fecha_Cierre'
                                        );
                    QRY_General2.Parambyname('Empresa').asString         := QRY_General.Fieldbyname('Empresa').asString;
                    QRY_General2.Parambyname('Cartera').asString         := QRY_General.Fieldbyname('Cartera').asString;
                    QRY_General2.Parambyname('Fecha_Cierre').asDatetime  := fecha_de_Stock(QRY_General.Fieldbyname('Cartera').asString);
                    try
                      QRY_General2.ExecSql;
                    except on E: EDBEngineError do
                      begin
                        ShowError(E);
                        QRY_General2.Close;
                        qry_general.Close;
                        bAbortar := True;
                        try
                        if NOT Reg_Parametros.bSolo_Stock then
                        begin
                           DMValorizacion.Tmp_Res_Mercado.Close;
                           DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                           DMValorizacion.Tmp_Res_Mercado_CC.Close;
                           DMValorizacion.Tmp_RES_PROVISION.Close;
                           if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                              DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                        end;
                        DMValorizacion.Tmp_Stock.Close;
                        DMValorizacion.Tmp_Res_Proceso.Close;
                        except
                        end;
                        Exit;
                      end;
                    end;

                    sMensaje  := ' Registrando log de stock parcial  ('+floattostr(fcuenta_pasadas)+')';
                    Mostrar_Mensaje(sMensaje, bAbortar);

                    sMensaje  := ' Registrando log de stock parcial (close)  ('+floattostr(fcuenta_pasadas)+')';
                    Mostrar_Mensaje(sMensaje, bAbortar);
                    QRY_General2.Close;
                    sMensaje  := ' Registrando log de stock parcial (clear)  ('+floattostr(fcuenta_pasadas)+')';
                    Mostrar_Mensaje(sMensaje, bAbortar);
                    QRY_General2.Sql.Clear;
                    sMensaje  := ' Registrando log de stock parcial (insert)  ('+floattostr(fcuenta_pasadas)+')';
                    Mostrar_Mensaje(sMensaje, bAbortar);
                    QRY_General2.Sql.Add( ' INSERT INTO QS_TRA_OMD_STK_RF_LOG'
                                         +' VALUES (:Empresa'
                                         +'         ,:Cartera'
                                         +'         ,:Fecha_Cierre'
                                         +'         ,:Emisor'
                                         +'         ,:Instrumento'
                                         +'         )'
                                        );
                    QRY_General2.Parambyname('Empresa').asString         := QRY_General.Fieldbyname('Empresa').asString;
                    QRY_General2.Parambyname('Cartera').asString         := QRY_General.Fieldbyname('Cartera').asString;
                    QRY_General2.Parambyname('Fecha_Cierre').asDatetime  := fecha_de_Stock(QRY_General.Fieldbyname('Cartera').asString);
                    QRY_General2.Parambyname('Emisor').asString          := COPY(sString_Emisores,1,250);
                    QRY_General2.Parambyname('Instrumento').asString     := COPY(sString_Instrumentos,1,250);

                    sMensaje  := ' Registrando log de stock parcial (execsql)  ('+floattostr(fcuenta_pasadas)+')';
                    Mostrar_Mensaje(sMensaje, bAbortar);

                    try
                      QRY_General2.ExecSql;
                      sMensaje  := ' Registrando log de stock parcial (despues de execsql)  ('+floattostr(fcuenta_pasadas)+')';
                      Mostrar_Mensaje(sMensaje, bAbortar);

                    except on E: EDBEngineError do
                      begin
                        ShowError(E);
                        QRY_General2.Close;
                        qry_general.Close;
                        bAbortar := True;
                        try
                        if NOT Reg_Parametros.bSolo_Stock then
                        begin
                           DMValorizacion.Tmp_Res_Mercado.Close;
                           DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                           DMValorizacion.Tmp_Res_Mercado_CC.Close;
                           DMValorizacion.Tmp_RES_PROVISION.Close;
                           if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                              DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                        end;
                        DMValorizacion.Tmp_Stock.Close;
                        DMValorizacion.Tmp_Res_Proceso.Close;
                        except
                        end;
                        Exit;
                      end;
                    end;
                    sMensaje  := ' Registrando log de stock parcial (next)  ('+floattostr(fcuenta_pasadas)+')';
                    fcuenta_pasadas := fcuenta_pasadas + 1;
                    Mostrar_Mensaje(sMensaje, bAbortar);
                   Next;
                end;
                Close;
            end
            else
            begin
               if ( bEmpresa_Implica_Stock_Parcial) and
                  ( NOT bValorizando_Stock_Parcial) then
               begin
                  sMensaje  := ' Eliminando log de stock parcial (1) ';
                  Mostrar_Mensaje(sMensaje, bAbortar);

                  Close;
                  if Reg_Parametros.bCarteras then
                  begin
                     Sql.Clear;
                     SQL.Add(' SELECT z.Empresa, z.Cartera FROM QS_SYS_PARAM_EMPRESA z'
                            +' WHERE z.Empresa IN '+ sString_Empresas
                            +'   AND z.Pid     = :Pid'
                            );
                     Parambyname('Pid').asFloat := Application.Handle;
                     Open;

                     While NOT Eof do
                     begin
                         QRY_General2.Close;
                         QRY_General2.Sql.Clear;
                         QRY_General2.Sql.Add( 'DELETE FROM QS_TRA_OMD_STK_RF_LOG'
                                              +' WHERE Empresa       = :Empresa'
                                              +'   AND Cartera       = :Cartera'
                                              +'   AND Fecha_Cierre  = :Fecha_Cierre'
                                             );
                         QRY_General2.Parambyname('Empresa').asString         := QRY_General.Fieldbyname('Empresa').asString;
                         QRY_General2.Parambyname('Cartera').asString         := QRY_General.Fieldbyname('Cartera').asString;
                         QRY_General2.Parambyname('Fecha_Cierre').asDatetime  := fecha_de_Stock(QRY_General.Fieldbyname('Cartera').asString);
                         try
                           QRY_General2.ExecSql;
                         except on E: EDBEngineError do
                           begin
                             ShowError(E);
                             QRY_General2.Close;
                             qry_general.Close;
                             bAbortar := True;
                             try
                             if NOT Reg_Parametros.bSolo_Stock then
                             begin
                                DMValorizacion.Tmp_Res_Mercado.Close;
                                DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                                DMValorizacion.Tmp_Res_Mercado_CC.Close;
                                DMValorizacion.Tmp_RES_PROVISION.Close;
                                if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                                   DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                             end;
                             DMValorizacion.Tmp_Stock.Close;
                             DMValorizacion.Tmp_Res_Proceso.Close;
                             except
                             end;

                             Exit;
                           end;
                         end;
                        Next;
                     end;
                  end
                  else
                  begin
                     sMensaje  := ' Eliminando log de stock parcial (2) ';
                     Mostrar_Mensaje(sMensaje, bAbortar);

                     Sql.Clear;
                     SQL.Add(' SELECT z.Empresa, z.Cartera FROM QS_SYS_PARAM_EMPRESA z'
                            +' WHERE z.Empresa IN '+ sString_Empresas
                            +'   AND z.Pid     = :Pid'
                            );
                     Parambyname('Pid').asFloat := Application.Handle;
                     Open;

                     While NOT Eof do
                     begin
                         QRY_General2.Close;
                         QRY_General2.Sql.Clear;
                         QRY_General2.Sql.Add( 'DELETE FROM QS_TRA_OMD_STK_RF_LOG'
                                              +' WHERE Empresa IN '+sString_Empresas
                                              +'   AND Fecha_Cierre  = :Fecha_Cierre'
                                             );
//                         QRY_General2.Parambyname('Empresa').asString        := QRY_General.Fieldbyname('Empresa').asString;
                         QRY_General2.Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
                         try
                           QRY_General2.ExecSql;
                         except on E: EDBEngineError do
                           begin
                             ShowError(E);
                             QRY_General2.Close;
                             qry_general.Close;
                             bAbortar := True;
                             try
                             if NOT Reg_Parametros.bSolo_Stock then
                             begin
                                DMValorizacion.Tmp_Res_Mercado.Close;
                                DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                                DMValorizacion.Tmp_Res_Mercado_CC.Close;
                                DMValorizacion.Tmp_RES_PROVISION.Close;
                                if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                                   DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                             end;
                             DMValorizacion.Tmp_Stock.Close;
                             DMValorizacion.Tmp_Res_Proceso.Close;
                             except
                             end;

                             Exit;
                           end;
                         end;
                        Next;
                     end;
                  end;
                  Close;
              end;
            end;
         end;

         sMensaje  := ' Registro de log de concluido ';
         Mostrar_Mensaje(sMensaje, bAbortar);

        // Se agrega el if de Solo Stock ya que daba un error cuando se trataba de
        // utilizar el record count... (Cuando es solo stock la tabla de provision no estaba abierta

        if NOT Reg_Parametros.bSolo_Stock then
        if DMValorizacion.Tmp_Res_Provision.RecordCount <>  0 then
        begin
            sMensaje  := ' Iniciando nueva transaccion ';
            Mostrar_Mensaje(sMensaje, bAbortar);

            if (sDriver = 'ORACLE') and
               (NOT dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.StartTransaction;

            Mostrar_Mensaje('Transfiriendo Valores Instrumentos...', bAbortar);
            Application.ProcessMessages;
            try
               fTotal_Registros_Mercado := DMValorizacion.Tmp_Res_Provision.RecordCount;
               fTotal_Registros         := 0;
               DMValorizacion.Tmp_Res_Provision.First;
               while not DMValorizacion.Tmp_Res_Provision.eof do
               begin
                  with DMValorizacion.Qry_QS_RES_PROVISION do
                  begin
                     Parambyname('Empresa').asString              := DMValorizacion.Tmp_Res_Provision.FieldByName('Empresa').AsString;
                     Parambyname('Cartera').asString              := DMValorizacion.Tmp_Res_Provision.FieldByName('Cartera').AsString;
                     Parambyname('Fecha_Cierre').asDatetime       := DMValorizacion.Tmp_Res_Provision.FieldByName('Fecha_Cierre').asDatetime;
                     Parambyname('Transaccion').asString          := DMValorizacion.Tmp_Res_Provision.FieldByName('Transaccion').AsString;
                     Parambyname('Folio_interno').asString        := DMValorizacion.Tmp_Res_Provision.FieldByName('Folio_interno').AsString;
                     Parambyname('Item_OMD').asFloat              := DMValorizacion.Tmp_Res_Provision.FieldByName('Item_OMD').asFloat;
                     Parambyname('Emisor').asString               := DMValorizacion.Tmp_Res_Provision.FieldByName('Emisor').AsString;
                     Parambyname('Instrumento').asString          := DMValorizacion.Tmp_Res_Provision.FieldByName('Instrumento').AsString;
                     Parambyname('Serie').asString                := DMValorizacion.Tmp_Res_Provision.FieldByName('Serie').AsString;
                     Parambyname('Nemotecnico').asString          := DMValorizacion.Tmp_Res_Provision.FieldByName('Nemotecnico').AsString;
                     Parambyname('FECHA_PRIMER_DIV').asDatetime   := DMValorizacion.Tmp_Res_Provision.FieldByName('FECHA_PRIMER_DIV').asDatetime;
                     Parambyname('FECHA_RETASACION').asDatetime   := DMValorizacion.Tmp_Res_Provision.FieldByName('FECHA_RETASACION').asDatetime;
                     Parambyname('VALOR_TASACION_UM').asFloat     := DMValorizacion.Tmp_Res_Provision.FieldByName('VALOR_TASACION_UM').asFloat;
                     Parambyname('NRO_DIVIDENDOS_IMP').asFloat    := DMValorizacion.Tmp_Res_Provision.FieldByName('NRO_DIVIDENDOS_IMP').asFloat;
                     Parambyname('DIVIDENDO_IMPAGO_UM').asFloat   := DMValorizacion.Tmp_Res_Provision.FieldByName('DIVIDENDO_IMPAGO_UM').asFloat;
                     Parambyname('DIVIDENDO_IMPAGO_MC').asFloat   := DMValorizacion.Tmp_Res_Provision.FieldByName('DIVIDENDO_IMPAGO_MC').asFloat;
                     Parambyname('PROVISION_UM').asFloat          := DMValorizacion.Tmp_Res_Provision.FieldByName('PROVISION_UM').asFloat;
                     Parambyname('PROVISION_MC').asFloat          := DMValorizacion.Tmp_Res_Provision.FieldByName('PROVISION_MC').asFloat;
                     ExecSql;
                  end;
                  DMValorizacion.Tmp_Res_Provision.Next;
                  fTotal_Registros := fTotal_Registros + 1;

                  sMensaje  := ' Registro( Provisiones ) : ' + FloatToStr( Trunc(fTotal_Registros /fTotal_Registros_Mercado * 100) )+'%';
                  Mostrar_Mensaje(sMensaje, bAbortar);
               end;

            except on E: EDBEngineError do
               begin
                  ShowError(E);
                  Application.MessageBox(' Error Al Transferir Datos, Tabla QS_RES_PROVISION'
                                         ,'Valorización Posición'
                                         ,mb_Ok + MB_IconError
                                        );
                   if (sDriver = 'ORACLE') and
                      (dmBaseDatos.Database_General.InTransaction) then
                      dmBaseDatos.Database_General.RollBack;
                      try
                      if NOT Reg_Parametros.bSolo_Stock then
                      begin
                         DMValorizacion.Tmp_Res_Mercado.Close;
                         DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                         DMValorizacion.Tmp_Res_Mercado_CC.Close;
                         DMValorizacion.Tmp_RES_PROVISION.Close;
                         if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                            DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                      end;
                      DMValorizacion.Tmp_Stock.Close;
                      DMValorizacion.Tmp_Res_Proceso.Close;
                      except
                      end;


                  bAbortar := True;
                  Exit;
               end;
            end;

            if  (sDriver = 'ORACLE') and
                (dmBaseDatos.Database_General.InTransaction) then
                dmBaseDatos.Database_General.Commit;

            DMValorizacion.Tmp_Res_Provision.EmptyTable;
         end;

         if ( NOT Reg_Parametros.bSolo_Stock) then //and
            //(NOT bValorizando_Stock_Parcial)  then
         begin
            //Transfiero Mercado
            if (sDriver = 'ORACLE') and
               (NOT dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.StartTransaction;

            Mostrar_Mensaje('Transfiriendo Valores Mercado...', bAbortar);
            Application.ProcessMessages;
            try
               //DMValorizacion.BatchMove.Source      := DMValorizacion.Tmp_Res_Mercado;
               //DMValorizacion.BatchMove.Destination := DMValorizacion.T_Res_Mercado;
               //DMValorizacion.BatchMove.Execute;
               fTotal_Registros_Mercado := DMValorizacion.Tmp_Res_Mercado.RecordCount;
               fTotal_Registros         := 0;
               DMValorizacion.Tmp_Res_Mercado.First;
               while not DMValorizacion.Tmp_Res_Mercado.eof do
               begin
                  with DMValorizacion.Qry_QS_RES_MERCADO do
                  begin
                    Parambyname('Empresa').AsString           := DMValorizacion.Tmp_Res_Mercado.FieldByName('Empresa').AsString;
                    Parambyname('Cartera').AsString           := DMValorizacion.Tmp_Res_Mercado.FieldByName('Cartera').AsString;
                    Parambyname('Transaccion').AsString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Transaccion').AsString;
                    Parambyname('Folio_interno').AsString     := DMValorizacion.Tmp_Res_Mercado.FieldByName('Folio_interno').AsString;
                    Parambyname('Item_OMD').AsFloat           := DMValorizacion.Tmp_Res_Mercado.FieldByName('Item_OMD').AsFloat;
                    Parambyname('Fecha_Cierre').AsDateTime    := DMValorizacion.Tmp_Res_Mercado.FieldByName('Fecha_Cierre').AsDateTime;
                    Parambyname('Fecha_Operacion').AsDateTime := DMValorizacion.Tmp_Res_Mercado.FieldByName('Fecha_Operacion').AsDateTime;
                    Parambyname('Nemotecnico').AsString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Nemotecnico').AsString;
                    Parambyname('Emisor').AsString            := DMValorizacion.Tmp_Res_Mercado.FieldByName('Emisor').AsString;
                    Parambyname('Instrumento').AsString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Instrumento').AsString;
                    Parambyname('Serie').AsString             := DMValorizacion.Tmp_Res_Mercado.FieldByName('Serie').AsString;
                    Parambyname('Valor_Nominal').AsFloat      := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Nominal').AsFloat;
                    Parambyname('Valor_PAR_UM').AsFloat       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_PAR_UM').AsFloat;
                    Parambyname('Valor_PAR_MC').AsFloat       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_PAR_MC').AsFloat;
                    Parambyname('Tasa_Compra').AsFloat        := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tasa_Compra').AsFloat;
                    Parambyname('Valor_Pte_um_Cpa').AsFloat   := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Pte_um_Cpa').AsFloat;
                    Parambyname('Valor_Pte_mc_Cpa').AsFloat   := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Pte_mc_Cpa').AsFloat;
                    Parambyname('Por_Valor_Par_Cpa').AsFloat  := DMValorizacion.Tmp_Res_Mercado.FieldByName('Por_Valor_Par_Cpa').AsFloat;
                    Parambyname('Plazo_al_Vcto').AsFloat      := DMValorizacion.Tmp_Res_Mercado.FieldByName('Plazo_al_Vcto').AsFloat;
                    Parambyname('Tasa_Mercado_Mdo').AsFloat   := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tasa_Mercado_Mdo').AsFloat;
                    Parambyname('Valor_Pte_um_Mdo').AsFloat   := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Pte_um_Mdo').AsFloat;
                    Parambyname('Valor_Pte_mc_Mdo').AsFloat   := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Pte_mc_Mdo').AsFloat;
                    Parambyname('Por_Valor_Par_Mdo').AsFloat  := DMValorizacion.Tmp_Res_Mercado.FieldByName('Por_Valor_Par_Mdo').AsFloat;
                    Parambyname('Duration').AsFloat           := DMValorizacion.Tmp_Res_Mercado.FieldByName('Duration').AsFloat;
                    Parambyname('Duration_Mod').AsFloat       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Duration_Mod').AsFloat;
                    Parambyname('Convexidad').AsFloat         := DMValorizacion.Tmp_Res_Mercado.FieldByName('Convexidad').AsFloat;
                    Parambyname('Diferencia').AsFloat         := DMValorizacion.Tmp_Res_Mercado.FieldByName('Diferencia').AsFloat;

                    Parambyname('Clasif_Riesgo').AsString     := DMValorizacion.Tmp_Res_Mercado.FieldByName('Clasif_Riesgo').AsString;
                    Parambyname('Tipo_Clasif_Riesgo').AsString:= DMValorizacion.Tmp_Res_Mercado.FieldByName('Tipo_Clasif').AsString;
                    Parambyname('Comprometido').AsString      := DMValorizacion.Tmp_Res_Mercado.FieldByName('Comprometido').AsString;
                    Parambyname('Moneda_Instrum').AsString    := DMValorizacion.Tmp_Res_Mercado.FieldByName('Moneda_Instrum').AsString;

                    Parambyname('Valor_Pte_mc_i_Cpa').AsFloat := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Pte_mc_i_Cpa').AsFloat;
                    Parambyname('Valor_Pte_mc_I_Mer').AsFloat := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Pte_mc_I_Mer').AsFloat;
                    Parambyname('Fecha_emision').AsDateTime   := DMValorizacion.Tmp_Res_Mercado.FieldByName('Fecha_emision').AsDateTime;
                    Parambyname('Fecha_vcto').AsDateTime      := DMValorizacion.Tmp_Res_Mercado.FieldByName('Fecha_vcto').AsDateTime;
                    Parambyname('Tasa_emision').AsFloat       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tasa_emision').AsFloat;
                    Parambyname('Factor_Riesgo').AsFloat      := DMValorizacion.Tmp_Res_Mercado.FieldByName('Factor_Riesgo').AsFloat;
                    Parambyname('Valorizacion_Mixta').AsFloat := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valorizacion_Mixta').AsFloat;
                    Parambyname('Precio_Mixto').AsFloat       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Precio_Mixto').AsFloat;
                    Parambyname('Motivo_Inv').AsString        := DMValorizacion.Tmp_Res_Mercado.FieldByName('Motivo_Inv').AsString;
                    Parambyname('Saldo_Insoluto').AsFloat     := DMValorizacion.Tmp_Res_Mercado.FieldByName('Saldo_Insoluto').AsFloat;

                    Parambyname('Fecha_Last_Cierre').AsDateTime   := DMValorizacion.Tmp_Res_Mercado.FieldByName('Fecha_Last_Cierre').AsDateTime;
                    Parambyname('Valor_Final_SVS_UM').AsFloat     := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Final_SVS_UM').AsFloat;
                    Parambyname('Valor_Final_SVS_MC').AsFloat     := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valor_Final_SVS_MC').AsFloat;
                    Parambyname('Valorizacion_Mixta_UM').AsFloat  := DMValorizacion.Tmp_Res_Mercado.FieldByName('Valorizacion_Mixta_UM').AsFloat;

                    Parambyname('Custodia').AsString              := DMValorizacion.Tmp_Res_Mercado.FieldByName('Custodia').AsString;
                    if Flag_Duration_Tasa_Emi then
                    begin
                       Parambyname('Duration_Tasa_Emi').AsFloat     := DMValorizacion.Tmp_Res_Mercado.FieldByName('Duration_Tasa_Emi').AsFloat;
                       Parambyname('Duration_Mod_Tasa_Emi').AsFloat := DMValorizacion.Tmp_Res_Mercado.FieldByName('Duration_Mod_Tasa_Emi').AsFloat;
                       Parambyname('Cupones_Impagos').AsFloat       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Cupones_Impagos').AsFloat;

                    end;
                    Parambyname('Saldo_Insoluto_UM').AsFloat      := DMValorizacion.Tmp_Res_Mercado.FieldByName('Saldo_Insoluto_UM').AsFloat;
                    Parambyname('Saldo_Insoluto_MC').AsFloat      := DMValorizacion.Tmp_Res_Mercado.FieldByName('Saldo_Insoluto_MC').AsFloat;
                    Parambyname('Tipo_Tasa_Precio_Cpa').asString  := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tipo_Tasa_Precio_Cpa').AsString;
                    Parambyname('Origen_Cpa').asString            := DMValorizacion.Tmp_Res_Mercado.FieldByName('Origen_Cpa').AsString;
                    Parambyname('Tipo_Valuac_Cpa').asString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tipo_Valuac_Cpa').AsString;
                    Parambyname('Formula_Pte_Cpa').asString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Formula_Pte_Cpa').AsString;
                    Parambyname('Tipo_Tasa_Precio_Mdo').asString  := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tipo_Tasa_Precio_Mdo').AsString;
                    Parambyname('Origen_Mdo').asString            := DMValorizacion.Tmp_Res_Mercado.FieldByName('Origen_Mdo').AsString;
                    Parambyname('Tipo_Valuac_Mdo').asString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tipo_Valuac_Mdo').AsString;
                    Parambyname('Formula_Pte_Mdo').asString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Formula_Pte_Mdo').AsString;
                    Parambyname('Tipo_Tasa_Precio_Mix').asString  := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tipo_Tasa_Precio_Mix').AsString;
                    Parambyname('Origen_Mix').asString            := DMValorizacion.Tmp_Res_Mercado.FieldByName('Origen_Mix').AsString;
                    Parambyname('Tipo_Valuac_Mix').asString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Tipo_Valuac_Mix').AsString;
                    Parambyname('Formula_Pte_Mix').asString       := DMValorizacion.Tmp_Res_Mercado.FieldByName('Formula_Pte_Mix').AsString;
                    Try
                       ExecSql;
                    except on E: EDBEngineError do
                      begin
                        ShowError_SQL(E
                                     ,DMValorizacion.Qry_QS_RES_MERCADO.sql // DMValorizacion.Qry_General.SQL
                                     ,'Parametros : '+#10
                                     +'Empresa           = '+DMValorizacion.Tmp_Res_Mercado.FieldByName('Empresa').AsString + #10
                                     +'Folio_Interno     = '+DMValorizacion.Tmp_Res_Mercado.FieldByName('Folio_interno').AsString + #10
                                     +'Item_Omd          = '+FloatTostr(DMValorizacion.Tmp_Res_Mercado.FieldByName('Item_Omd').asFloat) + #10
                                     +'Transaccion       = '+DMValorizacion.Tmp_Res_Mercado.FieldByName('Transaccion').asString
//                                     +'Fecha_Cierre      = '+DateToStr(QRY_General.Fieldbyname('Fecha_Mov').asDatetime)
                                     );
                      end;
                    end;
                  end;
                  DMValorizacion.Tmp_Res_Mercado.next;
                  fTotal_Registros := fTotal_Registros + 1;

                  sMensaje  := ' Registro( Mercado ) : ' + FloatToStr( Trunc(fTotal_Registros /fTotal_Registros_Mercado * 100) )+'%';
                  Mostrar_Mensaje(sMensaje, bAbortar);
               end;

            except on E: EDBEngineError do
               begin
                  ShowError(E);
                  Application.MessageBox(' Error Al Transferir Datos, Tabla QS_RES_MERCADO'
                                         ,'Valorización Posición'
                                         ,mb_Ok + MB_IconError
                                        );
                   if (sDriver = 'ORACLE') and
                      (dmBaseDatos.Database_General.InTransaction) then
                      dmBaseDatos.Database_General.RollBack;

                  bAbortar := True;

                  try
                  if NOT Reg_Parametros.bSolo_Stock then
                  begin
                     DMValorizacion.Tmp_Res_Mercado.Close;
                     DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                     DMValorizacion.Tmp_Res_Mercado_CC.Close;
                     DMValorizacion.Tmp_RES_PROVISION.Close;
                     if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
                        DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                  end;
                  DMValorizacion.Tmp_Stock.Close;
                  DMValorizacion.Tmp_Res_Proceso.Close;
                  except
                  end;


                  Exit;
               end;
            end;

         if  (sDriver = 'ORACLE') and
             (dmBaseDatos.Database_General.InTransaction) then
             dmBaseDatos.Database_General.Commit;

         DMValorizacion.Tmp_Res_Mercado.EmptyTable;

         if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
         begin
            if ( NOT Reg_Parametros.bSolo_Stock) then //and
               //(NOT bValorizando_Stock_Parcial)  then
            begin
               //Transfiero Mercado
               if (sDriver = 'ORACLE') and
                  (NOT dmBaseDatos.Database_General.InTransaction) then
                  dmBaseDatos.Database_General.StartTransaction;

               Mostrar_Mensaje('Transfiriendo Valores Interfaz ERP ...', bAbortar);
               Application.ProcessMessages;
               try
                  //DMValorizacion.BatchMove.Source      := DMValorizacion.Tmp_Res_Mercado;
                  //DMValorizacion.BatchMove.Destination := DMValorizacion.T_Res_Mercado;
                  //DMValorizacion.BatchMove.Execute;
                  fTotal_Registros_Mercado := DMValorizacion.Tmp_ERP_CtasPorPagar.RecordCount;
                  fTotal_Registros         := 0;
                  DMValorizacion.Tmp_ERP_CtasPorPagar.First;
                  while not DMValorizacion.Tmp_ERP_CtasPorPagar.eof do
                  begin
                     with DMValorizacion.Qry_QS_ERP_INTERFAZ do
                     begin
                       Parambyname('DS_CIA_ORIGEN').AsString          :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_CIA_ORIGEN').asString;
                       Parambyname('DS_SISTEMA_ORIGEN').AsString      :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_SISTEMA_ORIGEN').asString;
                       Parambyname('ID_FECHA_PROCESO').asDatetime     :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_FECHA_PROCESO').asDatetime;
                       Parambyname('ID_NUM_PROCESO').asFloat          :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_NUM_PROCESO').asFloat;
                       Parambyname('ID_NUM_ENVIO').AsFloat            :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_NUM_ENVIO').asFloat;
                       Parambyname('ID_TIPO_REGISTRO').asFloat        :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_REGISTRO').asFloat;
                       Parambyname('ID_TIPO_MOV').asFloat             :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_MOV').asFloat;
                       Parambyname('ID_ESTADO_PROC').asFloat          :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_ESTADO_PROC').asFloat;
                       Parambyname('F_CANTIDAD_REG').asFloat          :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_CANTIDAD_REG').asFloat;
                       Parambyname('F_CANTIDAD_TIPO_MONEDA').asFloat  :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_CANTIDAD_TIPO_MONEDA').asFloat;
                       Parambyname('ID_TIPO_MONEDA').AsString         :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_MONEDA').asString;
                       Parambyname('DS_TIPO_MONEDA').asString         :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_MONEDA').asString;
                       Parambyname('F_IND_CTRL_MONTO').AsFloat        :=  DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_IND_CTRL_MONTO').asFloat;

                       Parambyname('ID_CARTERA').asString             := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_CARTERA').asString;
                       Parambyname('DS_CARTERA').asString             := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_CARTERA').asString;
                       Parambyname('ID_TIPO_OPERACION').asString      := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_OPERACION').asString;
                       Parambyname('DS_TIPO_OPERACION').asString      := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_OPERACION').asString;
                       Parambyname('ID_INSTRUMENTO').asString         := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_INSTRUMENTO').asString;
                       Parambyname('DS_INSTRUMENTO').asString         := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_INSTRUMENTO').asString;
                       Parambyname('ID_FOLIO').asString               := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_FOLIO').asString;
                       Parambyname('ID_ITEM').AsFloat                 := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_ITEM').asFloat;
                       Parambyname('ID_NEMOTECNICO').asString         := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_NEMOTECNICO').asString;
                       Parambyname('ID_EMISOR').asString              := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_EMISOR').asString;
                       Parambyname('DS_EMISOR').asString              := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_EMISOR').asString;
                       Parambyname('ID_TIPO_INVERSION').asString      := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_INVERSION').asString;
                       Parambyname('DS_TIPO_INVERSION').asString      := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_INVERSION').asString;
                       Parambyname('DS_CIA').asString                 := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_CIA').asString;
                       Parambyname('ID_SUCURSAL').asString            := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_SUCURSAL').asString;
                       Parambyname('DS_SUCURSAL').asString            := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_SUCURSAL').asString;
                       Parambyname('ID_MOTIVO_INVERSION').asString    := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_MOTIVO_INVERSION').asString;
                       Parambyname('ID_LINEA').asString               := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_LINEA').asString;
                       Parambyname('ID_DIVISA_MONEDA').asString       := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_DIVISA_MONEDA').asString;
                       Parambyname('DS_DIVISA_MONEDA').asString       := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_DIVISA_MONEDA').asString;
                       Parambyname('ID_FEC_CONVERSION').asDatetime    := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_FEC_CONVERSION').asDatetime;
                       Parambyname('F_TIPO_CAMBIO').AsFloat           := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_TIPO_CAMBIO').asFloat;
                       Parambyname('F_MONTO_MONEDA').AsFloat          := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_MONTO_MONEDA').asFloat;
                       Parambyname('ID_FEC_OPERACION').asDatetime     := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_FEC_OPERACION').asDatetime;
                       Parambyname('ID_FEC_PAGO_CXP').asDatetime      := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_FEC_PAGO_CXP').asDatetime;
                       Parambyname('ID_PROVEEDOR').asString           := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_PROVEEDOR').asString;
                       Parambyname('DS_PROVEEDOR').asString           := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_PROVEEDOR').asString;
                       Parambyname('ID_RUT').AsFloat                  := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_RUT').asFloat;
                       Parambyname('DS_DVRUT').asString               := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_DVRUT').asString;

                       Parambyname('ID_COD_IMPUESTO').asString        := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_COD_IMPUESTO').asString;
                       Parambyname('DS_COD_IMPUESTO').asString        := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_COD_IMPUESTO').asString;
                       Parambyname('F_VALOR_IMPUESTO').AsFloat        := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_VALOR_IMPUESTO').AsFloat;
                       Parambyname('F_VALOR_COMISION').AsFloat        := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_VALOR_COMISION').AsFloat;
                       Parambyname('F_MONTO_TOTAL_OPERACION').AsFloat := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('F_MONTO_TOTAL_OPERACION').AsFloat;
                       Parambyname('DS_FACTURA').asString             := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_FACTURA').asString;
                       Parambyname('ID_TIPO_DOCUMENTO').asString      := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_DOCUMENTO').asString;
                       Parambyname('DS_TIPO_DOCUMENTO').asString      := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_DOCUMENTO').asString;
                       Parambyname('ID_PAIS').asString                := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('ID_PAIS').asString;
                       Parambyname('DS_PAIS').asString                := DMValorizacion.Tmp_ERP_CtasPorPagar.FieldByName('DS_PAIS').asString;

                       Try
                          ExecSql;
                       except on E: EDBEngineError do
                         begin
                           ShowError_SQL(E
                                        ,DMValorizacion.Qry_QS_ERP_INTERFAZ.sql // DMValorizacion.Qry_General.SQL
                                        ,'Parametros : '+#10
                                        +'Empresa           = '+DMValorizacion.Tmp_Res_Mercado.FieldByName('DS_CIA_ORIGEN').AsString + #10
                                        +'Folio_Interno     = '+DMValorizacion.Tmp_Res_Mercado.FieldByName('ID_FOLIO').AsString + #10
                                        +'Item_Omd          = '+FloatTostr(DMValorizacion.Tmp_Res_Mercado.FieldByName('ID_ITEM').asFloat) + #10
                                        +'Transaccion       = '+DMValorizacion.Tmp_Res_Mercado.FieldByName('ID_TIPO_OPERACION').asString
//                                        +'Fecha_Cierre      = '+DateToStr(QRY_General.Fieldbyname('Fecha_Mov').asDatetime)
                                        );
                         end;
                       end;
                     end;
                     DMValorizacion.Tmp_ERP_CtasPorPagar.next;
                     fTotal_Registros := fTotal_Registros + 1;

                     sMensaje  := ' Registro( Interfaz ERP ) : ' + FloatToStr( Trunc(fTotal_Registros /fTotal_Registros_Mercado * 100) )+'%';
                     Mostrar_Mensaje(sMensaje, bAbortar);
                  end;

               except on E: EDBEngineError do
                  begin
                     ShowError(E);
                     Application.MessageBox(' Error Al Transferir Datos, Tabla ETLODSQS20'            //QS_ERP_CXP'
                                            ,'Valorización Posición'
                                            ,mb_Ok + MB_IconError
                                           );
                      if (sDriver = 'ORACLE') and
                         (dmBaseDatos.Database_General.InTransaction) then
                         dmBaseDatos.Database_General.RollBack;

                     bAbortar := True;

                     try
                     if NOT Reg_Parametros.bSolo_Stock then
                     begin
                        DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                        DMValorizacion.Tmp_Res_Mercado.Close;
                        DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                        DMValorizacion.Tmp_Res_Mercado_CC.Close;
                        DMValorizacion.Tmp_RES_PROVISION.Close;
                        DMValorizacion.Tmp_ERP_CtasPorPagar.Close;
                     end;
                     DMValorizacion.Tmp_Stock.Close;
                     DMValorizacion.Tmp_Res_Proceso.Close;
                     except
                     end;

                     Exit;
                  end;
               end;
            end;
         end;


         if  (sDriver = 'ORACLE') and
             (dmBaseDatos.Database_General.InTransaction) then
             dmBaseDatos.Database_General.Commit;

         DMValorizacion.Tmp_Res_Mercado.EmptyTable;

         // Se elimina la tabla qs_res_mercado_cc
         // F.I. & GGARCIA 18-11-2010
         {
         //Transfiero Mercado CC
         if (sImplicancia_Mercado_CC = 'MERCADO_CC') and
            //(NOT bValorizando_Stock_Parcial)         then
            ( NOT Reg_Parametros.bSolo_Stock) then
         begin
            if (sDriver = 'ORACLE') and
               (NOT dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.StartTransaction;

            Mostrar_Mensaje('Transfiriendo Valores Mercado(CC)...', bAbortar);
            try
               fTotal_Registros_Mercado := DMValorizacion.Tmp_Res_Mercado_CC.RecordCount;
               fTotal_Registros         := 0;
               DMValorizacion.Tmp_Res_Mercado_CC.First;
               while not DMValorizacion.Tmp_Res_Mercado_CC.eof do
               begin
                  with DMValorizacion.Qry_QS_RES_MERCADO_CC do
                  begin
                    Parambyname('Fecha').AsDateTime             := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Fecha').AsDateTime;
                    Parambyname('Empresa').AsString             := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Empresa').AsString;
                    Parambyname('Cartera').AsString             := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Cartera').AsString;
                    Parambyname('Transaccion').AsString         := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Transaccion').AsString;
                    Parambyname('Folio_interno').AsString       := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Folio_interno').AsString;
                    Parambyname('Item_OMD').AsFloat             := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Item_OMD').AsFloat;
                    Parambyname('Emisor').AsString              := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Emisor').AsString;
                    Parambyname('Instrumento').AsString         := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Instrumento').AsString;
                    Parambyname('Serie').AsString               := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Serie').AsString;
                    Parambyname('Nemotecnico').AsString         := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Nemotecnico').AsString;
                    Parambyname('Valor_Nominal').AsFloat        := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Valor_Nominal').AsFloat;
                    Parambyname('Valor_Pte_mc_Cpa').AsFloat     := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Valor_Pte_mc_Cpa').AsFloat;
                    Parambyname('Valor_Pte_mc_Mdo').AsFloat     := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Valor_Pte_mc_Mdo').AsFloat;
                    Parambyname('Valor_Pte_mc_Mixta').AsFloat   := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Valor_Pte_mc_Mixta').AsFloat;
                    Parambyname('Valor_Pte_um_Cpa').AsFloat     := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Valor_Pte_um_Cpa').AsFloat;
                    Parambyname('Valor_Pte_um_Mdo').AsFloat     := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Valor_Pte_um_Mdo').AsFloat;
                    Parambyname('Valor_Pte_um_Mixta').AsFloat   := DMValorizacion.Tmp_Res_Mercado_CC.FieldByName('Valor_Pte_um_Mixta').AsFloat;
                    ExecSql;
                  end;
                  DMValorizacion.Tmp_Res_Mercado_CC.next;
                  fTotal_Registros := fTotal_Registros + 1;

                  sMensaje  := ' Registro( Mercado(CC) ) : ' + FloatToStr( Trunc(fTotal_Registros /fTotal_Registros_Mercado * 100) )+'%';
                  Mostrar_Mensaje(sMensaje, bAbortar);
               end;

            except on E: EDBEngineError do
               begin
                  ShowError(E);
                  Application.MessageBox(' Error Al Transferir Datos, Tabla QS_RES_MERCADO_CC'
                                         ,'Valorización Posición'
                                         ,mb_Ok + MB_IconError
                                        );
                   if (sDriver = 'ORACLE') and
                      (dmBaseDatos.Database_General.InTransaction) then
                      dmBaseDatos.Database_General.RollBack;

                  bAbortar := True;
                  try
                  if NOT Reg_Parametros.bSolo_Stock then
                  begin
                     DMValorizacion.Tmp_Res_Mercado.Close;
                     DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                     DMValorizacion.Tmp_Res_Mercado_CC.Close;
                     DMValorizacion.Tmp_RES_PROVISION.Close;
                  end;
                  DMValorizacion.Tmp_Stock.Close;
                  DMValorizacion.Tmp_Res_Proceso.Close;
                  except
                  end;

                  Exit;
               end;
            end;

            if  (sDriver = 'ORACLE') and
                (dmBaseDatos.Database_General.InTransaction) then
                dmBaseDatos.Database_General.Commit;

            DMValorizacion.Tmp_Res_Mercado_CC.EmptyTable;
         end;
         }

         //Transfiero Mercado AD SI CORRESPONDE y Errores
         if ( sImplicancia_Mercado = 'MERCADO' ) and
            ( NOT Reg_Parametros.bSolo_Stock) then
            //(NOT bValorizando_Stock_Parcial)     then
         begin
            //Transfiero Mercado AD
            if (sDriver = 'ORACLE') and
               (NOT dmBaseDatos.Database_General.InTransaction) then
               dmBaseDatos.Database_General.StartTransaction;

            Mostrar_Mensaje('Transfiriendo Valores Mercado(AD)...', bAbortar);
            Application.ProcessMessages;
           { try
               DMValorizacion.BatchMove.Source      := DMValorizacion.Tmp_Res_Mercado_Ad;
               DMValorizacion.BatchMove.Destination := DMValorizacion.T_Res_Mercado_Ad;
               DMValorizacion.BatchMove.Execute;
            except on E: EDBEngineError do
               begin
                  ShowError(E);
                  Application.MessageBox(' Error Al Transferir Datos, Tabla QS_RES_MERCADO_AD'
                                         ,'Valorización Posición'
                                         ,mb_Ok + Mb_IconError
                                        );
                  if (sDriver = 'ORACLE') and
                     (dmBaseDatos.Database_General.InTransaction) then
                     dmBaseDatos.Database_General.RollBack;

                   bAbortar := True;
                   Exit;
               end;
            end;
            }

            try
               fTotal_Registros_Mercado := DMValorizacion.Tmp_Res_Mercado_Ad.RecordCount;
               fTotal_Registros         := 0;
               DMValorizacion.Tmp_Res_Mercado_Ad.First;
               while not DMValorizacion.Tmp_Res_Mercado_Ad.eof do
               begin
                  with DMValorizacion.Qry_QS_RES_MERCADO_AD do
                  begin
                     Parambyname('Empresa').asString              := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Empresa').AsString;
                     Parambyname('Cartera').asString              := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Cartera').AsString;
                     Parambyname('Transaccion').asString          := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Transaccion').AsString;
                     Parambyname('Folio_interno').asString        := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Folio_interno').AsString;
                     Parambyname('Item_OMD').asFloat              := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Item_OMD').asFloat;
                     Parambyname('Fecha_Cierre').asDatetime       := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Fecha_Cierre').asDatetime;
                     Parambyname('Tasa_Compra_I').asFloat          := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Tasa_Compra_I').asFloat;
                     Parambyname('Valor_Pte_um_Cpa_Ini').asFloat   := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_um_Cpa_Ini').asFloat;
                     Parambyname('Valor_Pte_mc_Cpa_Ini').asFloat   := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_mc_Cpa_Ini').asFloat;
                     Parambyname('Por_Valor_Par_Cpa_Ini').asFloat  := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Por_Valor_Par_Cpa_Ini').asFloat;
                     Parambyname('Tasa_Mercado_Mdo_Ini').asFloat   := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Tasa_Mercado_Mdo_Ini').asFloat;
                     Parambyname('Valor_Pte_um_Mdo_Ini').asFloat   := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_um_Mdo_Ini').asFloat;
                     Parambyname('Valor_Pte_mc_Mdo_Ini').asFloat   := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_mc_Mdo_Ini').asFloat;
                     Parambyname('Por_Valor_Par_Mdo_Ini').asFloat  := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Por_Valor_Par_Mdo_Ini').asFloat;
                     Parambyname('Precio_Mixto_Ini').asFloat       := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Precio_Mixto_Ini').asFloat;
                     Parambyname('Valor_Pte_um_Mix_Ini').asFloat   := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_um_Mix_Ini').asFloat;
                     Parambyname('Valor_Pte_mc_Mix_Ini').asFloat   := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_mc_Mix_Ini').asFloat;
                     Parambyname('Comprometido').asString          := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Comprometido').AsString;
                     Parambyname('Emisor').asString                := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Emisor').AsString;
                     Parambyname('Instrumento').asString           := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Instrumento').AsString;
                     Parambyname('Serie').asString                 := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Serie').AsString;
                     Parambyname('Nemotecnico').asString           := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Nemotecnico').AsString;
                     Parambyname('Valor_Pte_um_Cpa_SC').asFloat    := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_um_Cpa_SC').asFloat;
                     Parambyname('Valor_Pte_mc_Cpa_SC').asFloat    := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_mc_Cpa_SC').asFloat;
                     Parambyname('Valor_Pte_um_Mdo_SC').asFloat    := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_um_Mdo_SC').asFloat;
                     Parambyname('Valor_Pte_mc_Mdo_SC').asFloat    := DMValorizacion.Tmp_Res_Mercado_Ad.FieldByName('Valor_Pte_mc_Mdo_SC').asFloat;
                     ExecSql;
                     Close;
                  end;
                  DMValorizacion.Tmp_Res_Mercado_Ad.Next;
                  fTotal_Registros := fTotal_Registros + 1;

                  sMensaje  := ' Registro( Mercado(AD) ) : ' + FloatToStr( Trunc(fTotal_Registros /fTotal_Registros_Mercado * 100) )+'%';
                  Mostrar_Mensaje(sMensaje, bAbortar);
               end;

            except on E: EDBEngineError do
               begin
                  ShowError(E);
                  Application.MessageBox(' Error Al Transferir Datos, Tabla QS_RES_MERCADO_AD'
                                         ,'Valorización Posición'
                                         ,mb_Ok + MB_IconError
                                        );
                   if (sDriver = 'ORACLE') and
                      (dmBaseDatos.Database_General.InTransaction) then
                      dmBaseDatos.Database_General.RollBack;

                  bAbortar := True;
                  try
                  if NOT Reg_Parametros.bSolo_Stock then
                  begin
                     DMValorizacion.Tmp_Res_Mercado.Close;
                     DMValorizacion.Tmp_Res_Mercado_Ad.Close;
                     DMValorizacion.Tmp_Res_Mercado_CC.Close;
                     DMValorizacion.Tmp_RES_PROVISION.Close;
                  end;
                  DMValorizacion.Tmp_Stock.Close;
                  DMValorizacion.Tmp_Res_Proceso.Close;
                  except
                  end;
                  
                  Exit;
               end;
            end;

            if (sDriver = 'ORACLE') and
               (dmBaseDatos.Database_General.InTransaction) then
                dmBaseDatos.Database_General.Commit;

            DMValorizacion.Tmp_Res_Mercado_Ad.EmptyTable;
         end;
       end;

     end; {solo stock}

     with DMValorizacion,QRY_General do
     begin
       // Verifico Inconsistencia de nemotecnicos en STOCK y no existen
       Close;
       SQL.Clear;
       SQL.Add('SELECT a.Empresa                          ');
       SQL.Add('      ,b.Nemotecnico                      ');
       SQL.Add('      ,b.Emisor                           ');
       SQL.Add('      ,b.Instrumento                      ');
       SQL.Add('      ,b.Serie                            ');
       SQL.Add('      ,b.Folio_Interno                    ');
       SQL.Add('      ,b.Item_omd                         ');
       SQL.Add('      ,''NO EXISTE DEFINICION DE NEMOTECNICO'' As Error  ');
       SQL.Add('  FROM qs_tra_omd a ');
       SQL.Add('      ,QS_TRA_OMD_STK_RF b ');
       SQL.Add(' WHERE a.fecha_operacion <= :Fecha_Cierre                ');
       SQL.Add('  AND a.folio_interno not in (SELECT e.folio               ');
       SQL.Add('				 FROM qs_ctr_anulacion e    ');
       SQL.Add('				WHERE e.folio   = a.folio_interno    ');
       SQL.Add('  				  AND e.empresa = a.empresa          ');
       SQL.Add('				  AND e.transaccion = a.transaccion) ');
       SQL.Add('    AND a.Empresa IN (SELECT Distinct valor As Empresa                 ');
       SQL.Add('                      FROM QS_SYS_PARAM_PROCESO                       ');
       SQL.Add('                     WHERE proceso   = :proceso                       ');
       SQL.Add('                       AND parametro = ''EMPRESA'')                   ');
       SQL.Add('   and a.folio_interno = b.folio_interno                             ');
       SQL.Add('   and a.Transaccion   = b.Transaccion');
       SQL.Add('   and a.Empresa       = b.Empresa');
       SQL.Add('   and b.Tipo_Instrum  = ''S'' ');
       SQL.Add('   AND b.Tipo_Instrum <> ''R''' );
       SQL.Add('   and b.Nemotecnico NOT IN (SELECT c.Codigo_Nemotecnico             ');
       SQL.Add('       			     FROM QS_FIN_NEM_RFIJA c                 ');
       SQL.Add('			       WHERE c.Codigo_Nemotecnico = b.Nemotecnico)');
       Parambyname('Fecha_Cierre').asDatetime := dFecha_Inicial;
       Parambyname('Proceso').asString := IntToStr(Application.Handle);

       Open;
       WHILE NOT EOF do
       begin
         sMensaje  := ' Folio : ' + FieldByName('Folio_Interno').AsString
                       +' - '
                       +' Item : ' + FieldByName('Item_Omd').AsString
                       +' - '
                       +FieldByName('Emisor').AsString
                       +' - '
                       +FieldByName('Instrumento').AsString
                       +' - '
                       +FieldByName('Serie').AsString
                       +' - '
                       +FieldByName('Nemotecnico').AsString;

          Insertar_Registro_Errores_Mesa(FieldByName('Empresa').AsString,
                                    sProceso,
                                    dFecha_Inicial,
                                    sLogin_Sistema,
                                    sMensaje,
                                    'Consistencia',
                                    FieldByName('Error').AsString
                                    + ' : ' + FieldByName('Nemotecnico').AsString
                                   ,'99'
                                    );
          Next;
       end;
       Close;
     end;
     // Libero los VarArray

     if VarIsArray(Reg_Nominales_Vendidos.Folio_Interno_Rel) then
     begin
        VarClear(Reg_Nominales_Vendidos.Folio_Interno_Rel);
        VarClear(Reg_Nominales_Vendidos.Item_Omd_Rel);
        VarClear(Reg_Nominales_Vendidos.Transaccion_Rel);
        VarClear(Reg_Nominales_Vendidos.Valor_Nominal);
        VarClear(Reg_Nominales_Vendidos.Fecha_Operacion);
     end;

     if VarIsArray(Reg_Nominales_Pactados.Folio_Interno_Rel) then
     begin
        VarClear(Reg_Nominales_Pactados.Cartera);
        VarClear(Reg_Nominales_Pactados.Folio_Interno_Rel);
        VarClear(Reg_Nominales_Pactados.Item_Omd_Rel);
        VarClear(Reg_Nominales_Pactados.Transaccion_Rel);
        VarClear(Reg_Nominales_Pactados.Valor_Nominal);
        VarClear(Reg_Nominales_Pactados.Fecha_Operacion);
        VarClear(Reg_Nominales_Pactados.Fecha_Vcto_Pacto);
        VarClear(Reg_Nominales_Pactados.Valor_Pactado_UM);
        VarClear(Reg_Nominales_Pactados.Valor_Pactado_MC);
        VarClear(Reg_Nominales_Pactados.Transaccion);
        VarClear(Reg_Nominales_Pactados.Folio_Interno);
        VarClear(Reg_Nominales_Pactados.Item_Omd);
     end;

     if VarIsArray(Reg_Monedas.COD_MONEDA) then
     begin
        VarClear(Reg_Monedas.COD_MONEDA      );
        VarClear(Reg_Monedas.TIPO_DE_PARIDAD );
        VarClear(Reg_Monedas.MONEDA_PARIDAD  );
        VarClear(Reg_Monedas.FECHA_PARIDAD   );
        VarClear(Reg_Monedas.VALOR_MONEDA    );
        VarClear(Reg_Monedas.TIPO            );
     end;

     if VarIsArray(Reg_Tasas_Mercado.Codigo_Nemotecnico) then
     begin
        VarClear(Reg_Tasas_Mercado.Codigo_Nemotecnico );
        VarClear(Reg_Tasas_Mercado.Fecha              );
        VarClear(Reg_Tasas_Mercado.Valor              );
     end;

     if VarIsArray(Reg_LastTasas_Mercado.Codigo_Nemotecnico) then
     begin
        VarClear(Reg_LastTasas_Mercado.Codigo_Nemotecnico );
        VarClear(Reg_LastTasas_Mercado.Fecha              );
        VarClear(Reg_LastTasas_Mercado.Valor              );
        VarClear(Reg_LastTasas_Mercado.Codigo_Nemotecnico );
        VarClear(Reg_LastTasas_Mercado.Fecha              );
        VarClear(Reg_LastTasas_Mercado.Valor              );
     end;

     if VarIsArray(Reg_Valores_Tirmra.Dias_Desde) then
     begin
        VarClear(Reg_Valores_Tirmra.Dias_Desde );
        VarClear(Reg_Valores_Tirmra.Dias_Hasta );
        VarClear(Reg_Valores_Tirmra.Valor      );
     end;

     if VarIsArray(Reg_Valores_Tirmra_2.Dias_Desde) then
     begin
        VarClear(Reg_Valores_Tirmra_2.Dias_Desde );
        VarClear(Reg_Valores_Tirmra_2.Dias_Hasta );
        VarClear(Reg_Valores_Tirmra_2.Valor      );
     end;

     // Agregados 27-12-2005 E.S. & F.I.
     if VarIsArray(Reg_Valores_Tasas_Instrumento.Unidad) then
     begin
        VarClear(Reg_Valores_Tasas_Instrumento.Unidad );
        VarClear(Reg_Valores_Tasas_Instrumento.Instrumento );
        VarClear(Reg_Valores_Tasas_Instrumento.Dias_Desde      );
        VarClear(Reg_Valores_Tasas_Instrumento.Dias_Hasta      );
        VarClear(Reg_Valores_Tasas_Instrumento.Valor      );
     end;

     if VarIsArray(Reg_Motivo.Empresa) then
     begin
        VarClear(Reg_Motivo.Empresa );
        VarClear(Reg_Motivo.Transaccion );
        VarClear(Reg_Motivo.Folio_Interno      );
        VarClear(Reg_Motivo.Item_Omd      );
        VarClear(Reg_Motivo.Fecha_Hora      );
        VarClear(Reg_Motivo.Fecha_Desde      );
        VarClear(Reg_Motivo.Fecha_Hasta      );
        VarClear(Reg_Motivo.Cod_Motivo      );
     end;


     if VarIsArray(Reg_Custodia.Empresa) then
     begin
        VarClear(Reg_Custodia.Empresa );
        VarClear(Reg_Custodia.Transaccion );
        VarClear(Reg_Custodia.Folio_Interno      );
        VarClear(Reg_Custodia.Item_Omd      );
        VarClear(Reg_Custodia.Custodia      );
     end;

     if VarIsArray(Reg_Nominales_Pactados_Mdo.Empresa) then
     begin
        VarClear(Reg_Nominales_Pactados_Mdo.Empresa );
        VarClear(Reg_Nominales_Pactados_Mdo.Cartera );
        VarClear(Reg_Nominales_Pactados_Mdo.Transaccion      );
        VarClear(Reg_Nominales_Pactados_Mdo.Folio_Interno      );
        VarClear(Reg_Nominales_Pactados_Mdo.Item_Omd      );
        VarClear(Reg_Nominales_Pactados_Mdo.Valor_Nominal      );
        VarClear(Reg_Nominales_Pactados_Mdo.Fecha_Vcto_Pacto      );
        VarClear(Reg_Nominales_Pactados_Mdo.Valor_Pactado_UM      );
        VarClear(Reg_Nominales_Pactados_Mdo.Valor_Pactado_MC      );
     end;

     if sImplicancia_Mercado = 'MERCADO' then
     begin
       if VarIsArray(Reg_Folio_Mdo.Cartera) then
       begin
          VarClear(Reg_Folio_Mdo.Cartera          );
          VarClear(Reg_Folio_Mdo.Transaccion      );
          VarClear(Reg_Folio_Mdo.Folio_Interno    );
          VarClear(Reg_Folio_Mdo.Item_OMD         );
          VarClear(Reg_Folio_Mdo.Valor_Nominal    );
          VarClear(Reg_Folio_Mdo.Valor_Pte_I_Mer  );
          VarClear(Reg_Folio_Mdo.fecha_Last_Cierre);
       end;
     end;

     if dFecha_Inicial = dFecha_Final then
        if FrmMensajesProcesos.T_Errores_Mesa.Recordcount = 0 then
        begin
           with DMValorizacion,QRY_General do
           begin
             sql.Clear;
             sql.Add('SELECT Valor FROM qs_sys_param_proceso '
                    +' WHERE Proceso   = :Proceso '
                    +'   AND Parametro = ''EMPRESA'' '
                    );
             ParamByName('Proceso').AsString    := Floattostr(Application.Handle);
             Open;
//             sEmpresa_Val := FieldByName('Valor').AsString;

             Insertar_Registro_Errores_Mesa(FieldByName('Valor').AsString,  //sEmpresa,
                                       sProceso,
                                       dFecha_Inicial,
                                       sLogin_Sistema,
                                       '',
                                       '',
                                       'NO EXISTEN ERRORES EN EL PROCESO'
                                      ,'99'
                                       );
             Close;
           end;
        end;

     // Libero Memoria No Utilizada
     LiberarMemoria;

     dFecha_Inicial := dFecha_Inicial + 1;
     Mostrar_Progreso_dia( dFecha_Inicial );
 end;// while dfecha_inicial
 Mostrar_Progreso_dia( dFecha_Final );

 /////////////////////////////////////////////////////////////////////////
 //  Borrando Tabla temporal Detalle OMD (Re-Allocation)
 /////////////////////////////////////////////////////////////////////////
 Mostrar_Mensaje('Borrando Tabla temporal Detalle OMD (Re-Allocation)...', bAbortar);
 Borra_OMD_Re_Allocation(dFecha_Final);
 /////////////////////////////////////////////////////////////////////////

 Termino_proceso;

 if bAbortar then
 // E.S. 28-11-2012
// E.S. las rutinas del if sDriver las quité, cuando el programa se ejecuta desde el Panel de Control deja tomada la tabla qs_sys_tran_implic
// a pesar de que el proceo termina, nadie puede entrar a insertar una venta porque la tabla queda tomada
//    if (sDriver = 'ORACLE') and
//       (dmBaseDatos.Database_General.InTransaction) then
    if (dmBaseDatos.Database_General.InTransaction) then
        dmBaseDatos.Database_General.RollBack;

// E.S. quité este if, no tiene sentido no eliminar la marca si el proceso ya ha finalizado, 28-11-2012       
// if Reg_Parametros.bGenera_Stock then
// begin
//    if (sDriver = 'ORACLE') and
//       (NOT dmBaseDatos.Database_General.InTransaction) then
    if (NOT dmBaseDatos.Database_General.InTransaction) then
       dmBaseDatos.Database_General.StartTransaction;

    Marca_Proceso_Valorizacion('');{borra marca de valorizando}
//    if (sDriver = 'ORACLE') and
//       (dmBaseDatos.Database_General.InTransaction) then
    if (dmBaseDatos.Database_General.InTransaction) then
        dmBaseDatos.Database_General.Commit;
// end;

 if Reg_Parametros.sTipo_de_Proceso = 'M' then
    if NOT bAbortar then
    begin
       carga_estado(1);     // DC 14/06/2011
       sMensaje  := 'Valorización Finalizada';
       Mostrar_Mensaje(sMensaje, bAbortar);
       Frm_FinalizaValorizacion := TFrm_FinalizaValorizacion.Create(DMValorizacion);
       Frm_FinalizaValorizacion.Caption := sCaption;
       Frm_FinalizaValorizacion.width := 196;
       Frm_FinalizaValorizacion.Btn_Aceptar.left := 55;
       Frm_FinalizaValorizacion.Lb_Mensaje.caption := 'Valorización Finalizada';
       Frm_FinalizaValorizacion.ShowModal;
       //Application.MessageBox('Valorización Finalizada'
       //                      ,Pchar(sCaption)
       //                      ,mb_Ok+MB_ICONINFORMATION)
    end
    else
    begin
       carga_estado(0);     // DC 14/06/2011
       sMensaje  := 'Valorización Cancelada, por Usuario';
       Mostrar_Mensaje(sMensaje, bAbortar);
       Frm_FinalizaValorizacion := TFrm_FinalizaValorizacion.Create(DMValorizacion);
       Frm_FinalizaValorizacion.Caption := sCaption;
       Frm_FinalizaValorizacion.width := 257;
       Frm_FinalizaValorizacion.Lb_Mensaje.caption := 'Valorización Cancelada, por Usuario';
       Frm_FinalizaValorizacion.Btn_Aceptar.left := 87;
       Frm_FinalizaValorizacion.ShowModal;
       //Application.MessageBox('Valorización Cancelada, por Usuario'
       //                      ,Pchar(sCaption)
       //                      ,mb_Ok+MB_ICONINFORMATION);
    end;
  Mostrar_Mensaje('Proceso de Valorización Terminado', bAbortar);

  sValorizacion_Proceso := '';
  with DMValorizacion do
  begin
    if NOT Reg_Parametros.bSolo_Stock then
    begin
       T_Res_Mercado.Close;
       T_Res_Mercado_Ad.Close;
       T_Res_Mercado_CC.Close;
       T_Tes_Egring.Close;
       T_Stock.Close;

       Tmp_Res_Mercado.Close;
       Tmp_RES_PROVISION.Close;

       Tmp_Res_Mercado_Ad.Close;
       Tmp_Res_Mercado_CC.Close;
       Tmp_Stock.Close;
       Tmp_Res_Mercado.DeleteTable;
       Tmp_RES_PROVISION.DeleteTable;
       Tmp_Res_Mercado_Ad.DeleteTable;
       Tmp_Stock.DeleteTable;
       Tmp_Res_Mercado_CC.DeleteTable;
       T_Res_Proceso.Close;
       Tmp_Res_Proceso.Close;
       Tmp_Res_Proceso.DeleteTable;
       if Transaccion_implica_Mem(sEmpresa_Usuario,'ERPCDELSUR') then
       begin
          Tmp_ERP_CtasPorPagar.Close;
          Tmp_ERP_CtasPorPagar.DeleteTable;
       end;
    end
    else
    begin
       T_Stock.Close;
       Tmp_Stock.Close;
       Tmp_Stock.DeleteTable;

       T_Res_Proceso.Close;
       Tmp_Res_Proceso.Close;
       Tmp_Res_Proceso.DeleteTable;
    end;
  end;
end;

{
Function Vencimientos_Al_Dia(dFecha_Desde:TdateTime;Array_Mem_Desarr : TArray_Mem_Desarr):Boolean;
Var i : integer;
Begin
   Vencimientos_Al_Dia := False;
   i := 1;
  // While Array_Mem_Desarr[i].Fecha_Vcto <= dFecha_Desde Do
   for i := 1 to Max_Nro_Cupones do
   Begin
      if Array_Mem_Desarr[i].Fecha_Vcto = dFecha_Desde Then
         Vencimientos_Al_Dia := True;
     // i := i + 1;
      if Array_Mem_Desarr[i].nro_cupon <> i Then
         exit;

      if Array_Mem_Desarr[i].Fecha_Vcto > dFecha_Desde  then
         Break;
   End;
End;
}

procedure Insert_Mercado(sEmpresa,
                         sCartera,
                         sTransaccion,
                         sFolio_interno   : String;
                         fItem_OMD        : Double;
                         sNemotecnico,
                         sEmisor,
                         sInstrumento,
                         sSerie,
                         sMoneda_Instrum    : String;
                         fTasa_Emision      : Double;
                         dFecha_Emision,
                         dFecha_Vencimiento,
                         dFecha_Cierre,
                         dFecha_Operacion   : TDateTime;
                         fValor_Nominal,
                         fValor_PAR_UM,
                         fValor_PAR_MC,
                         fTasa_Compra,
                         fValor_Pte_UM_Cpa,
                         fValor_Pte_MC_Cpa,
                         fValor_Pte_UM_Mdo,
                         fValor_Pte_MC_Mdo,
                         fPtj_Valor_Par_Mdo,
                         fRate_Used_Valuacion,
                         fPorcen_Valor_Cpa,
                         fDuration,
                         fDuration_Modificada,
                         fConvexidad,
                         fPlazo_al_Vcto,
                         fValor_Final_SVS_UM,
                         fValor_Final_SVS_MC : Double;
                         sClasif_Riesgo      : String;
                         sTipo_Clasif        : String;
                         fFactor_Riesgo,
                         fPrecio_Mixto,
                         fValorizacion_Mixta: Double;
                         fValorizacion_Mixta_UM: Double;
                         sMotivo_Inversion  : String;
                         fSaldo_Insoluto    : Double;
                         sComprometido : String;
                         fValor_Pte_I_Cpa_Last : Double;
                         fValor_Pte_I_Mer_Last : Double;
                         dFecha_Last_Mdo : TDatetime;
                         Var Result : Boolean;
                         Reg_Parametros                 : TParametros;
                         sCustodia_Detalle              : String;
                         fDuration_Tasa_Emi             : Double;
                         fDuration_Modificada_Tasa_Emi  : Double;
                         fNRO_DIVIDENDOS_IMP            : Double;
                         fSaldo_Insoluto_UM             : Double;
                         fSaldo_Insoluto_MC             : Double;
                         sTipo_Tasa_Precio_Cpa          : String;
                         sOrigen_Cpa                    : String;
                         sTipo_Valuac_Cpa               : String;
                         sFormula_Pte_Cpa               : String;
                         sTipo_Tasa_Precio_Mdo          : String;
                         sOrigen_Mdo                    : String;
                         sTipo_Valuac_Mdo               : String;
                         sFormula_Pte_Mdo               : String;
                         sTipo_Tasa_Precio_Mix          : String;
                         sOrigen_Mix                    : String;
                         sTipo_Valuac_Mix               : String;
                         sFormula_Pte_Mix               : String;
                         fDiferencia                    : Double
                         );
var sCustodia_Dest : String;
    bResult    : Boolean;
    sNem_Inst : String;
begin
  sCustodia_Dest := Custodia_Actual_Mem( sEmpresa,
                                         sTransaccion,
                                         sFolio_interno,
                                         fItem_OMD
                                        );
  if Trim( sCustodia_Dest ) = '' then
     sCustodia_Dest := sCustodia_Detalle;

  // ggracia 12-2010 Simultaneas
  Busca_param_proceso('SIMULTANEA'
                     ,sTransaccion
                     ,sNem_Inst
                     ,bResult);
  if bResult then
  begin
     sNemotecnico := sNem_Inst;
     sInstrumento := sNem_Inst;
  end;

  if (    Transaccion_Implica_Mem(sTransaccion,'PASIVO' ))  and
     (not Transaccion_Implica_Mem(sTransaccion,'FORWARD')) then
  begin
     fValor_Pte_UM_Cpa      := fValor_Pte_UM_Cpa *-1;
     fValor_Pte_MC_Cpa      := fValor_Pte_MC_Cpa *-1;
     fValor_Pte_UM_Mdo      := fValor_Pte_UM_Mdo *-1;
     fValor_Pte_MC_Mdo      := fValor_Pte_MC_Mdo *-1;
     fValor_Pte_I_Cpa_Last  := fValor_Pte_I_Cpa_Last *-1;
     fValor_Pte_I_Mer_Last  := fValor_Pte_I_Mer_Last *-1;
     fValorizacion_Mixta    := fValorizacion_Mixta *-1;
     fValorizacion_Mixta_UM := fValorizacion_Mixta_UM *-1;
     fValor_Final_SVS_UM    := fValor_Final_SVS_UM *-1;
     fValor_Final_SVS_MC    := fValor_Final_SVS_MC *-1;
  end;
  // FIN ggracia 12-2010 Simultaneas

  Result := True;
  if NOT Reg_Parametros.bSolo_Stock then
  begin
     with DMValorizacion do
     begin
        Tmp_Res_Mercado.Insert;
        Tmp_Res_MercadoEmpresa.asString            := sEmpresa;
        Tmp_Res_MercadoCartera.asString            := sCartera;
        Tmp_Res_MercadoTransaccion.asString        := sTransaccion;
        Tmp_Res_MercadoFolio_interno.asString      := sFolio_Interno;
        Tmp_Res_MercadoItem_OMD.asFloat            := fItem_Omd;
        Tmp_Res_MercadoFecha_Cierre.asDatetime     := dFecha_Cierre;
        Tmp_Res_MercadoFecha_Operacion.asDatetime  := dFecha_Operacion;
        Tmp_Res_MercadoNemotecnico.asString        := sNemotecnico;
        Tmp_Res_MercadoEmisor.asString             := sEmisor;
        Tmp_Res_MercadoInstrumento.asString        := sInstrumento;
        Tmp_Res_MercadoSerie.asString              := sSerie;
        Tmp_Res_MercadoValor_Nominal.asFloat       := fValor_Nominal;
        Tmp_Res_MercadoValor_Par_UM.asFloat        := fValor_Par_UM;
        Tmp_Res_MercadoValor_Par_MC.asFloat        := fValor_Par_MC;
        Tmp_Res_MercadoTasa_Compra.asFloat         := fTasa_Compra;
        Tmp_Res_MercadoValor_Pte_um_Cpa.asFloat    := fValor_Pte_UM_Cpa;
        Tmp_Res_MercadoValor_Pte_mc_Cpa.asFloat    := fValor_Pte_MC_Cpa;
        Tmp_Res_MercadoPor_Valor_Par_Cpa.asFloat   := fPorcen_Valor_Cpa;
        Tmp_Res_MercadoPlazo_al_Vcto.asFloat       := fPlazo_al_Vcto;
        Tmp_Res_MercadoTasa_Mercado_Mdo.asFloat    := fRate_Used_Valuacion;
        Tmp_Res_MercadoValor_Pte_um_Mdo.asFloat    := fValor_Pte_UM_Mdo;
        Tmp_Res_MercadoValor_Pte_mc_Mdo.asFloat    := fValor_Pte_MC_Mdo;
        Tmp_Res_MercadoPor_Valor_Par_Mdo.asFloat   := fPtj_Valor_Par_Mdo;
        Tmp_Res_MercadoDuration.asFloat            := fDuration;
        Tmp_Res_MercadoDuration_Mod.asFloat        := fDuration_Modificada;
        Tmp_Res_MercadoConvexidad.asFloat          := fConvexidad;

        { Ahora se asigna la "Diferencia" antes de la llamada a la funcion insert
        if (Transaccion_Implica_Mem(sTransaccion,'FORWARD')) and (Transaccion_Implica_Mem(sTransaccion,'PASIVO')) then
           Tmp_Res_MercadoDiferencia.asFloat       := fValor_Pte_Mc_Cpa - fValor_Pte_Mc_Mdo
        else
           Tmp_Res_MercadoDiferencia.asFloat       := fValor_Pte_Mc_Mdo - fValor_Pte_Mc_Cpa;
        }

        Tmp_Res_MercadoDiferencia.asFloat          := fDiferencia;

        Tmp_Res_MercadoClasif_Riesgo.asString      := sClasif_Riesgo;
        Tmp_Res_MercadoTipo_Clasif.asString        := sTipo_Clasif;
        Tmp_Res_MercadoComprometido.asString       := sComprometido;
        Tmp_Res_MercadoMoneda_Instrum.asString     := sMoneda_Instrum;
        Tmp_Res_MercadoFecha_emision.asDatetime    := dFecha_Emision;
        Tmp_Res_MercadoFecha_vcto.asDatetime       := dFecha_Vencimiento;
        Tmp_Res_MercadoTasa_emision.asFloat        := fTasa_Emision;
        Tmp_Res_MercadoFactor_Riesgo.asFloat       := fFactor_Riesgo;
        Tmp_Res_MercadoValorizacion_Mixta.asFloat     := fValorizacion_Mixta;
        Tmp_Res_MercadoValorizacion_Mixta_UM.asFloat  := fValorizacion_Mixta_UM;
        Tmp_Res_MercadoPrecio_Mixto.asFloat        := fPrecio_Mixto;
        Tmp_Res_MercadoMotivo_Inv.asString         := sMotivo_Inversion;
        Tmp_Res_MercadoSaldo_Insoluto.asFloat      := fSaldo_Insoluto;
        Tmp_Res_MercadoValor_Pte_mc_i_Cpa.asFloat  := fValor_Pte_I_Cpa_Last;
        Tmp_Res_MercadoValor_Pte_mc_I_Mer.asFloat  := fValor_Pte_I_Mer_Last;
        Tmp_Res_MercadoFecha_Last_Cierre.asDatetime:= dFecha_Last_Mdo;
        Tmp_Res_MercadoValor_Final_SVS_UM.asFloat  := fValor_Final_SVS_UM;
        Tmp_Res_MercadoValor_Final_SVS_MC.asFloat  := fValor_Final_SVS_MC;
        Tmp_Res_MercadoCustodia.asString           := sCustodia_Dest;
        Tmp_Res_Mercado.FieldByName('Duration_Tasa_Emi').asFloat     := Redondeo(fDuration_Tasa_Emi,2);
        Tmp_Res_Mercado.FieldByName('Duration_Mod_Tasa_Emi').asFloat := Redondeo(fDuration_Modificada_Tasa_Emi,2);
        Tmp_Res_Mercado.FieldByName('Cupones_Impagos').asFloat       := fNRO_DIVIDENDOS_IMP;

        Tmp_Res_Mercado.FieldByName('Saldo_Insoluto_UM').asFloat       := fSaldo_Insoluto_UM;
        Tmp_Res_Mercado.FieldByName('Saldo_Insoluto_MC').asFloat       := fSaldo_Insoluto_MC;

        Tmp_Res_Mercado.FieldByName('Tipo_Tasa_Precio_Cpa').asString   := sTipo_Tasa_Precio_Cpa;
        Tmp_Res_Mercado.FieldByName('Origen_Cpa').asString             := sOrigen_Cpa;
        Tmp_Res_Mercado.FieldByName('Tipo_Valuac_Cpa').asString        := sTipo_Valuac_Cpa;
        Tmp_Res_Mercado.FieldByName('Formula_Pte_Cpa').asString        := sFormula_Pte_Cpa;
        Tmp_Res_Mercado.FieldByName('Tipo_Tasa_Precio_Mdo').asString   := sTipo_Tasa_Precio_Mdo;
        Tmp_Res_Mercado.FieldByName('Origen_Mdo').asString             := sOrigen_Mdo;
        Tmp_Res_Mercado.FieldByName('Tipo_Valuac_Mdo').asString        := sTipo_Valuac_Mdo;
        Tmp_Res_Mercado.FieldByName('Formula_Pte_Mdo').asString        := sFormula_Pte_Mdo;
        Tmp_Res_Mercado.FieldByName('Tipo_Tasa_Precio_Mix').asString   := sTipo_Tasa_Precio_Mix;
        Tmp_Res_Mercado.FieldByName('Origen_Mix').asString             := sOrigen_Mix;
        Tmp_Res_Mercado.FieldByName('Tipo_Valuac_Mix').asString        := sTipo_Valuac_Mix;
        Tmp_Res_Mercado.FieldByName('Formula_Pte_Mix').asString        := sFormula_Pte_Mix;

        try
           Tmp_Res_Mercado.Post;
        except on E: EDBEngineError do
           begin
             ShowError(E);
             Result := False;
             Tmp_Res_Mercado.Cancel;
             Exit;
           end;
        end;
     end;
  end;{solo stock}
end;

// Se elimina la tabla qs_res_mercado_cc
// F.I. & GGARCIA 18-11-2010
{
Procedure Insert_Mercado_CC(sFecha : TDateTime;
                              sEmpresa,
                              sCartera,
                              sTransaccion,
                              sFolio_interno   : String;
                              fItem_OMD        : Double;
                              sEmisor,
                              sInstrumento,
                              sSerie,
                              sNemotecnico     : String;
                              fValor_Nominal,
                              fValor_Pte_MC_Cpa,
                              fValor_Pte_MC_Mdo,
                              fValorizacion_Mixta,
                              fValor_Pte_UM_Cpa,
                              fValor_Pte_UM_Mdo,
                              fValorizacion_UM_Mixta : Double;
                              sMotivo_Inversion      : String;
                              var Result                 : Boolean;
                              Reg_Parametros         : TParametros
                              );
begin
  //Insertamos Valores en Tabla de Mercado_CC
  if NOT Reg_Parametros.bSolo_Stock then
  begin
  Result := True;
  with DMValorizacion do
  begin
     Tmp_Res_Mercado_CC.Append;
     Tmp_Res_Mercado_CCFecha.asDateTime           := sfecha;
     Tmp_Res_Mercado_CCEmpresa.asString           := sEmpresa;
     Tmp_Res_Mercado_CCCartera.asString           := sCartera;
     Tmp_Res_Mercado_CCTransaccion.asString       := sTransaccion;
     Tmp_Res_Mercado_CCFolio_interno.asString     := sFolio_Interno;
     Tmp_Res_Mercado_CCItem_OMD.asFloat           := fItem_OMD;
     Tmp_Res_Mercado_CCEmisor.asString            := sEmisor;
     Tmp_Res_Mercado_CCInstrumento.asString       := sInstrumento;
     Tmp_Res_Mercado_CCSerie.asString             := sSerie;
     Tmp_Res_Mercado_CCNemotecnico.asString       := sNemotecnico;
     Tmp_Res_Mercado_CCValor_Nominal.asFloat      := fValor_Nominal;
     Tmp_Res_Mercado_CCValor_Pte_mc_Cpa.asFloat   := fValor_Pte_MC_Cpa;
     Tmp_Res_Mercado_CCValor_Pte_mc_Mdo.asFloat   := fValor_Pte_MC_Mdo;
     Tmp_Res_Mercado_CCValor_Pte_mc_Mixta.asFloat := fValorizacion_Mixta;
     Tmp_Res_Mercado_CCValor_Pte_um_Cpa.asFloat   := fValor_Pte_UM_Cpa;
     Tmp_Res_Mercado_CCValor_Pte_um_Mdo.asFloat   := fValor_Pte_UM_Mdo;
     Tmp_Res_Mercado_CCValor_Pte_um_Mixta.asFloat := fValorizacion_UM_Mixta;
     try
        Tmp_Res_Mercado_CC.Post;
        except on E: EDBEngineError do
           begin
             ShowError(E);
             Result := False;
             Tmp_Res_Mercado_CC.Cancel;
             Exit;
           end;
     end;
  end;
  end; //solo stock
end;
}

procedure Insert_Mercado_Ad(sEmpresa,
                            sCartera,
                            sTransaccion,
                            sFolio_interno   : String;
                            fItem_OMD        : Double;
                            dFecha_Cierre    : TDateTime;
                            fTasa_Compra,
                            fValor_Pte_UM_Cpa,
                            fValor_Pte_MC_Cpa,
                            fPtj_Valor_Par_Cpa,
                            fTasa_Mercado,
                            fValor_Pte_UM_Mdo,
                            fValor_Pte_MC_Mdo,
                            fPtj_Valor_Par_Mdo : Double;
                            fPrecio_Mixto,
                            fValor_Pte_UM_Mix,
                            fValor_Pte_MC_Mix  : Double;
                            sComprometido,
                            sEmisor,
                            sInstrumento,
                            sSerie,
                            sNemotecnico       : String;
                            fValor_Pte_UM_Cpa_SC,
                            fValor_Pte_MC_Cpa_SC,
                            fValor_Pte_UM_Mdo_SC,
                            fValor_Pte_MC_Mdo_SC : Double;
                            var Result : Boolean;
                            Reg_Parametros       : TParametros
                            );
var bResult    : Boolean;
    sNem_Inst : String;
begin
  Result := True;

  if bTest then
       Application.MessageBox(PChar('INSERTANDO TABLA AD')
                              , pchar('Valorizacion Stock'), MB_OK+MB_ICONEXCLAMATION+MB_APPLMODAL);


  // ggracia 12-2010 Simultaneas
  Busca_param_proceso('SIMULTANEA'
                     ,sTransaccion
                     ,sNem_Inst
                     ,bResult);
  if bResult then
  begin
     sNemotecnico := sNem_Inst;
     sInstrumento := sNem_Inst;
  end;
  if (    Transaccion_Implica_Mem(sTransaccion,'PASIVO' ))  and
     (not Transaccion_Implica_Mem(sTransaccion,'FORWARD')) then
  begin
     fValor_Pte_UM_Cpa    := fValor_Pte_UM_Cpa *-1;
     fValor_Pte_MC_Cpa    := fValor_Pte_MC_Cpa *-1;
     fValor_Pte_UM_Mdo    := fValor_Pte_UM_Mdo *-1;
     fValor_Pte_MC_Mdo    := fValor_Pte_MC_Mdo *-1;
     fValor_Pte_UM_Mix    := fValor_Pte_UM_Mix *-1;
     fValor_Pte_MC_Mix    := fValor_Pte_MC_Mix *-1;
     fValor_Pte_UM_Cpa_SC := fValor_Pte_UM_Cpa_SC *-1;
     fValor_Pte_MC_Cpa_SC := fValor_Pte_MC_Cpa_SC *-1;
     fValor_Pte_UM_Mdo_SC := fValor_Pte_UM_Mdo_SC *-1;
     fValor_Pte_MC_Mdo_SC := fValor_Pte_MC_Mdo_SC *-1;
 end;

  // FIN ggracia 12-2010 Simultaneas
  if NOT Reg_Parametros.bSolo_Stock then
  begin
    with DMValorizacion do
    begin
       Tmp_Res_Mercado_Ad.Insert;
       Tmp_Res_Mercado_Ad.FieldByName('EMPRESA').asString              := sEmpresa;
       Tmp_Res_Mercado_Ad.FieldByName('CARTERA').asString              := sCartera;
       Tmp_Res_Mercado_Ad.FieldByName('TRANSACCION').asString          := sTransaccion;
       Tmp_Res_Mercado_Ad.FieldByName('FOLIO_INTERNO').asString        := sFolio_Interno;
       Tmp_Res_Mercado_Ad.FieldByName('ITEM_OMD').asFloat              := fItem_Omd;
       Tmp_Res_Mercado_Ad.FieldByName('FECHA_CIERRE').asDateTime       := dFecha_Cierre;
       Tmp_Res_Mercado_Ad.FieldByName('TASA_COMPRA_I').asFloat         := fTasa_Compra;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_UM_CPA_INI').asFloat  := fValor_Pte_UM_Cpa;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_MC_CPA_INI').asFloat  := fValor_Pte_MC_Cpa;
       Tmp_Res_Mercado_Ad.FieldByName('POR_VALOR_PAR_CPA_INI').asFloat := fPtj_Valor_Par_Cpa;
       Tmp_Res_Mercado_Ad.FieldByName('TASA_MERCADO_MDO_INI').asFloat  := fTasa_Mercado;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_UM_MDO_INI').asFloat  := fValor_Pte_UM_Mdo;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_MC_MDO_INI').asFloat  := fValor_Pte_MC_Mdo;
       Tmp_Res_Mercado_Ad.FieldByName('POR_VALOR_PAR_MDO_INI').asFloat := fPtj_Valor_Par_Mdo;
       Tmp_Res_Mercado_Ad.FieldByName('PRECIO_MIXTO_INI').asFloat      := fPrecio_Mixto;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_UM_MIX_INI').asFloat  := fValor_Pte_UM_Mix;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_MC_MIX_INI').asFloat  := fValor_Pte_MC_Mix;
       Tmp_Res_Mercado_Ad.FieldByName('COMPROMETIDO').asString         := sComprometido;
       Tmp_Res_Mercado_Ad.FieldByName('Emisor').asString               := sEmisor;
       Tmp_Res_Mercado_Ad.FieldByName('Instrumento').asString          := sInstrumento;
       Tmp_Res_Mercado_Ad.FieldByName('Serie').asString                := sSerie;
       Tmp_Res_Mercado_Ad.FieldByName('Nemotecnico').asString          := sNemotecnico;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_UM_CPA_SC').asFloat   := fValor_Pte_UM_Cpa_SC;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_MC_CPA_SC').asFloat   := fValor_Pte_MC_Cpa_SC;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_UM_CPA_SC').asFloat   := fValor_Pte_UM_Cpa_SC;
       Tmp_Res_Mercado_Ad.FieldByName('VALOR_PTE_MC_CPA_SC').asFloat   := fValor_Pte_MC_Cpa_SC;
       Try
          Tmp_Res_Mercado_Ad.Post;
       except on E: EDBEngineError do
           begin
             ShowError(E);
             Result := False;
             Tmp_Res_Mercado_Ad.Cancel;
             Exit;
           end;
       end;
    end;
  end;{solo stock}
end;

procedure Inserta_Registro_Stock(sEmpresa         : String;
                                 sTransaccion     : String;
                                 sFolio_Interno   : String;
                                 fItem_Omd        : Double;
                                 dFecha_Operacion : TDateTime;
                                 dfecha_stock     : TDateTime;
                                 sNemotecnico     : String;
                                 sEmisor          : String;
                                 sInstrumento     : String;
                                 sSerie           : String;
                                 dFecha_Emision   : TDateTime;
                                 dFecha_Vencimiento : TDateTime;
                                 fValor_Nominal     : Double;
                                 fValor_Nominal_Calculo : Double;
                                 fTasa_Emision          : Double;
                                 fTasa_Mercado          : Double;
                                 sMoneda_Instrum        : String;
                                 sTasa_Base_par         : String;
                                 sTasa_Base_Tir         : String;
                                 fValor_Pte_um_Cpa      : Double;
                                 fValor_Pte_mc_Cpa      : Double;
                                 fPorcen_Valor_Par      : Double;
                                 sCartera               : String;
                                 sMoneda_Pacto          : String;
                                 fTasa_pacto            : Double;
                                 sTasa_Base_Pacto       : String;
                                 dFecha_Vcto_pacto      : TDateTime;
                                 sTipo_Nominales        : String;
                                 sCustodia              : String;
                                 fPlazo_al_Vcto         : Double;
                                 sTipo_Instrum          : String;
                                 fValor_Pte_um_Mdo      : Double;
                                 fValor_Pte_mc_Mdo      : Double;
                                 fTasa_Mercado_Mdo      : Double;
                                 fDuration              : Double;
                                 sPlazo_Vcto            : String;
                                 fDiferencia            : Double;
                                 fValorizacion_Mixta    : Double;
                                 fPrecio_Mixto          : Double;
                                 sMotivo_Inv            : String;
                                 sClasif_Riesgo         : String;
                                 iCupones_cortados      : Integer;
                                 fValor_PAR_UM          : Double;
                                 fValor_PAR_MC          : Double;
                                 fSaldo_Insoluto_UM     : Double;
                                 fSaldo_Insoluto_MC     : Double;
                                 Var Resultado          : Boolean);
var
  fYears,
  fMonths: Double;
begin
   fYears      := Int(fPlazo_al_Vcto);//fdias / 365.25;
   fMonths     := Int( frac(fPlazo_al_Vcto) *12  );//(fYears - trunc(fyears)) * 12;
   sPlazo_vcto := ''''+formatfloat('00',fYears)+'/'+formatfloat('00',fMonths);;//formatfloat('00',fYears)+'/'+formatfloat('00',fMonths);
   Resultado   := True;
   with DMValorizacion do
   begin
      Tmp_Stock.Insert;
      Tmp_StockEmpresa.asString             := sEmpresa;
      Tmp_StockTransaccion.asString         := sTransaccion;
      Tmp_StockFolio_interno.asString       := sFolio_Interno;
      Tmp_StockItem_OMD.asFloat             := fItem_Omd;
      Tmp_StockFecha_Operacion.asDatetime   := dFecha_Operacion;
      Tmp_Stockfecha_stock.asDatetime       := dFecha_Stock;
      Tmp_StockNemotecnico.asString         := sNemotecnico;
      Tmp_StockEmisor.asString              := sEmisor;
      Tmp_StockInstrumento.asString         := sInstrumento;
      Tmp_StockSerie.asString               := sSerie;
      Tmp_StockFecha_Emision.asDatetime     := dFecha_Emision;
      Tmp_StockFecha_Vencimiento.asDatetime := dFecha_Vencimiento;
      Tmp_StockValor_Nominal.asFloat        := fValor_Nominal;
      Tmp_StockValor_Nominal_Calculo.asFloat:= fValor_Nominal_Calculo;
      Tmp_StockTasa_Emision.asFloat         := fTasa_Emision;
      Tmp_StockTasa_Mercado.asFloat         := fTasa_Mercado;
      Tmp_StockMoneda_Instrum.asString      := sMoneda_Instrum;
      Tmp_StockTasa_Base_par.asString       := sTasa_Base_par;
      Tmp_StockTasa_Base_Tir.asString       := sTasa_Base_Tir;
      Tmp_StockValor_Pte_um_Cpa.asFloat     := fValor_Pte_um_Cpa;
      Tmp_StockValor_Pte_mc_Cpa.asFloat     := fValor_Pte_mc_Cpa;
      Tmp_StockPorcen_Valor_Par.asFloat     := fPorcen_Valor_Par;
      Tmp_StockCartera.asString             := sCartera;
      Tmp_StockMoneda_Pacto.asString        := sMoneda_Pacto;
      Tmp_StockTasa_pacto.asFloat           := fTasa_pacto;
      Tmp_StockTasa_Base_Pacto.asString     := sTasa_Base_Pacto;
      Tmp_StockFecha_Vcto_pacto.asDatetime  := dFecha_Vcto_pacto;
      Tmp_StockTipo_Nominales.asString      := sTipo_Nominales;
      Tmp_StockCustodia.asString            := sCustodia;
      Tmp_StockPlazo_al_Vcto.asFloat        := fPlazo_al_Vcto;
      Tmp_StockTipo_Instrum.asString        := sTipo_Instrum;
      Tmp_StockValor_Pte_um_Mdo.asFloat     := fValor_Pte_um_Mdo;
      Tmp_StockValor_Pte_mc_Mdo.asFloat     := fValor_Pte_mc_Mdo;
      Tmp_StockTasa_Mercado_Mdo.asFloat     := fTasa_Mercado_Mdo;
      Tmp_StockDuration.asFloat             := fDuration;
      Tmp_StockPlazo_Vcto.asString          := sPlazo_Vcto;
      Tmp_StockDiferencia.asFloat           := fDiferencia;
      Tmp_StockValorizacion_Mixta.asFloat   := fValorizacion_Mixta;
      Tmp_StockPrecio_Mixto.asFloat         := fPrecio_Mixto;
      Tmp_StockMotivo_Inv.asString          := sMotivo_Inv;
      Tmp_StockClasif_Riesgo.asString       := sClasif_Riesgo;
      Tmp_Stock.FieldByName('Cupones_Cortados').asInteger   := iCupones_Cortados;

      Tmp_Stock.FieldByName('Valor_PAR_UM').asFloat      := fValor_PAR_UM;
      Tmp_Stock.FieldByName('Valor_PAR_MC').asFloat      := fValor_PAR_MC;
      Tmp_Stock.FieldByName('Saldo_Insoluto_UM').asFloat := fSaldo_Insoluto_UM;
      Tmp_Stock.FieldByName('Saldo_Insoluto_MC').asFloat := fSaldo_Insoluto_MC;

      Try
         Tmp_Stock.Post;
       except on E: EDBEngineError do
           begin
             ShowError(E);
             Resultado := False;
             Tmp_Stock.Cancel;
             Exit;
           end;
      end;
   end;
end;

procedure Registro_Caja(sEmpresa          : String;
                        sCartera          : String;
                        sTransaccion      : String;
                        sFolio_Interno    : String;
                        fItem_Omd         : Double;
                        dFecha_Mov        : TDateTime;
                        dFecha_Pago       : TDateTime;
                        sTipo_Movimiento  : String;
                        sMoneda_Cartera   : String;
                        sNemotecnico      : String;
                        fIntereses_UM     : Double;
                        fAmortizacion_UM  : Double;
                        fSaldo_Insoluto   : Double;
                        fValor_Nominal    : Double;
                        fValor_Vencimiento_UM: Double;
                        fValor_Vencimiento_MC: Double;
                        fDiferencia_Vencimiento_UM: Double;
                        fDiferencia_Vencimiento_MC: Double;
                        iCuponVigente     : Integer;
                        var Modulo_Err        : String;
                        var String_Err        : String;
                        var Result            : Boolean;
                        Reg_Parametros        : TParametros);
var
 sfolio_interno_tes : String;
 fFolio_tes         : Double;
 bOmd_Tiene_Pago    : Boolean;
begin
    if NOT Reg_Parametros.bSolo_Stock then
    begin
     Result     := True;
     Modulo_Err := 'Registro Caja :';
     bOmd_Tiene_Pago := Verifica_Pago_Omd_Mem( sEmpresa
                                              ,sTransaccion
                                              ,sFolio_Interno
                                              ,fItem_Omd
                                              ,iCuponVigente
                                              ,dFecha_Mov
                                             );

     if bOmd_Tiene_Pago then
     begin
       With DMValorizacion.Qry_Tesoreria do
       begin
         Parambyname('Folio_Interno').asString       := sFolio_Interno;
         Parambyname('Item_Omd').asFloat             := fItem_Omd;
         ParamByname('NRO_CUPON').asFloat            := iCuponVigente;
         Parambyname('Transaccion').asString         := sTransaccion;
         Parambyname('Empresa').asString             := sEmpresa;
         ParamByname('FECHA_MOV').asDateTime         := dFecha_Mov;
         ParamByname('INTERESES_UM').asFloat         := fIntereses_UM;
         ParamByname('AMORTIZACION_UM').asFloat      := fAmortizacion_UM;
         ParamByname('SALDO_INSOLUTO').asFloat       := fSaldo_Insoluto;
         ParamByname('VALOR_NOMINAL').asFloat        := fValor_Nominal;
         ParamByname('MONTO_UM_MOVIMIENTO').asFloat  := fValor_Vencimiento_UM;
         ParamByname('MONTO_MC_MOVIMIENTO').asFloat  := fValor_Vencimiento_MC;
         ParamByname('DIF_VENCIMIENTO_UM').asFloat   := fDiferencia_Vencimiento_UM;
         ParamByname('DIF_VENCIMIENTO_MC').asFloat   := fDiferencia_Vencimiento_MC;
         ParamByname('NEMOTECNICO').asString         := sNemotecnico;
         try
            ExecSql;
         except on E: EDBEngineError do
             begin
               ShowError(E);
               String_Err := 'ERROR AL ACTUALIZAR :' +sFolio_Interno
                             +' Item :'+FloatToStr(fItem_Omd)
                             +' TABLA QS_TES_EGRING( Mov.Caja )';
               Result := False;
               Exit;
             end;
         end;
       end;
     end
     else
     begin
         Leer_Grabar_Folio(sEmpresa,
                           ' ',// Entidad va en blanco para folio unico empresa
                           'VCTO',
                           'I',
                           solo_fecha(DMValorizacion.dfecha_hora_Servidor),
                           fFolio_tes,
                           Result);
         if NOT Result then
         begin
            String_Err := 'No existe definición para folio de Vencimientos (VCTO). Para empresa: '
                          +sEmpresa+'.';

            Result := False;
            Exit;
         end;
         sFolio_Interno_tes := trim(floattostr(fFolio_tes));

         with DMValorizacion do
         begin
             T_Tes_Egring.Insert;
             T_Tes_EgringEMPRESA.asString             := sEmpresa;
             T_Tes_EgringTRANSACCION.asString         := 'VCTO';
             T_Tes_EgringFOLIO_INTERNO.asString       := sFolio_interno_tes;
             T_Tes_EgringTIPO_MOVIMIENTO.asString     := sTipo_Movimiento;
             T_Tes_EgringCARTERA.asString             := sCartera;
             T_Tes_EgringMONEDA_CARTERA.asString      := sMoneda_Cartera;
             T_Tes_EgringFECHA_MOV.asDateTime         := dFecha_Mov;
             T_Tes_EgringINTERESES_UM.asFloat         := fIntereses_UM;
             T_Tes_EgringAMORTIZACION_UM.asFloat      := fAmortizacion_UM;
             T_Tes_EgringSALDO_INSOLUTO.asFloat       := fSaldo_Insoluto;
             T_Tes_EgringVALOR_NOMINAL.asFloat        := fValor_Nominal;
             T_Tes_EgringMONTO_UM_MOVIMIENTO.asFloat  := fValor_Vencimiento_UM;
             T_Tes_EgringMONTO_MC_MOVIMIENTO.asFloat  := fValor_Vencimiento_MC;
             T_Tes_EgringDIF_VENCIMIENTO_UM.asFloat   := fDiferencia_Vencimiento_UM;
             T_Tes_EgringDIF_VENCIMIENTO_MC.asFloat   := fDiferencia_Vencimiento_MC;
             T_Tes_EgringNEMOTECNICO.asString         := sNemotecnico;
             if not (transaccion_implica_mem(sEmpresa_Usuario,'MOVTO_CAJA')) then
             begin
                T_Tes_EgringFECHA_PAGO.asDateTime        := dFecha_Pago;
                T_Tes_EgringMONTO_UM_PAGADO.asFloat      := fValor_Vencimiento_UM;
                T_Tes_EgringMONTO_MC_PAGADO.asFloat      := fValor_Vencimiento_MC;
             end
             else
             begin
                T_Tes_EgringFECHA_PAGO.asDateTime        := dFecha_Pago;
                T_Tes_EgringMONTO_UM_PAGADO.asFloat      := 0;
                T_Tes_EgringMONTO_MC_PAGADO.asFloat      := 0;
             end;
             T_Tes_EgringFECHA_EMISION_PAGO.asDateTime:= dFecha_Mov;
             T_Tes_EgringTRANSACCION_OMD.asString     := sTransaccion;
             T_Tes_EgringFOLIO_INTERNO_OMD.asString   := sFolio_Interno;
             T_Tes_EgringITEM_OMD.asFloat             := fItem_Omd;
             T_Tes_EgringNRO_CUPON.asFloat            := iCuponVigente;
             try
                T_Tes_Egring.Post;
             except on E: EDBEngineError do
                 begin
                   ShowError(E);
                   T_Tes_Egring.Cancel;
                   String_Err := 'ERROR AL INSERTAR FOLIO :' +sFolio_Interno_Tes+' MOVIMIENTO :'+sTipo_Movimiento
                            +' TABLA QS_TES_EGRING( Mov.Caja )';
                   Result := False;
                   Exit;
                 end;
             end;
         end;
   end;
 end;{solo stock}
end;

procedure Insert_Valores_Proceso(sEmpresa,
                                 sCartera         : String;
                                 dFecha_Cierre    : TDateTime;
                                 sProceso         : String;
                                 sTransaccion,
                                 sFolio_interno   : String;
                                 fItem_OMD        : Double;
                                 sNemotecnico,
                                 sInstrumento     : String;
                                 fPrecio_Tasa     : Double;
                                 fValor_Pte_MC_Proceso : Double;
                              var Result : Boolean
                                 );
begin
    Result := True;
    with DMValorizacion do
    begin
       Tmp_Res_Proceso.Insert;
       Tmp_Res_Proceso.FieldByName('EMPRESA').asString      := sEmpresa;
       Tmp_Res_Proceso.FieldByName('CARTERA').asString      := sCartera;
       Tmp_Res_Proceso.FieldByName('FECHA').asDateTime      := dFecha_Cierre;
       Tmp_Res_Proceso.FieldByName('PROCESO').asString      := sProceso;
       Tmp_Res_Proceso.FieldByName('TRANSACCION').asString  := sTransaccion;
       Tmp_Res_Proceso.FieldByName('FOLIO').asString        := sFolio_Interno;
       Tmp_Res_Proceso.FieldByName('ITEM').asFloat          := fItem_Omd;
       Tmp_Res_Proceso.FieldByName('Nemotecnico').asString  := sNemotecnico;
       Tmp_Res_Proceso.FieldByName('Instrumento').asString  := sInstrumento;
       Tmp_Res_Proceso.FieldByName('PRECIO_TASA').asFloat   := fPrecio_Tasa;
       Tmp_Res_Proceso.FieldByName('VALOR').asFloat         := fValor_Pte_MC_Proceso;
       Try
          Tmp_Res_Proceso.Post;
       except on E: EDBEngineError do
           begin
             ShowError(E);
             Result := False;
             Tmp_Res_Proceso.Cancel;
             Exit;
           end;
       end;
    end;
end;


procedure Insert_Valores_MH(sEmpresa,
                            sCartera,
                            sTransaccion,
                            sFolio_interno   : String;
                            fItem_OMD        : Double;
                            sEmisor,
                            sInstrumento,
                            sSerie,
                            sNemotecnico     : String;
                            dFecha_Cierre,
                            dFecha_Primer_Dividendo,
                            dFecha_Retasacion : TDateTime;
                            fVALOR_TASACION_UM,
                            fNRO_DIVIDENDOS_IMP,
                            fDIVIDENDO_IMPAGO_UM,
                            fDIVIDENDO_IMPAGO_MC,
                            fPROVISION_UM,
                            fPROVISION_MC    : Double;
                            var Result : Boolean;
                            Reg_Parametros : TParametros
                            );
begin
  Result := True;
  if NOT Reg_Parametros.bSolo_Stock then
  begin
    With DMValorizacion do
    begin
       Tmp_RES_PROVISION.Insert;
       Tmp_RES_PROVISION.FieldByName('Empresa').AsString             := sEmpresa;
       Tmp_RES_PROVISION.FieldByName('Cartera').AsString             := sCartera;
       Tmp_RES_PROVISION.FieldByName('Transaccion').AsString         := sTransaccion;
       Tmp_RES_PROVISION.FieldByName('Folio_Interno').AsString       := sFolio_Interno;
       Tmp_RES_PROVISION.FieldByName('Item_Omd').AsFloat             := fItem_Omd;
       Tmp_RES_PROVISION.FieldByName('Fecha_Cierre').asDatetime      := dFecha_Cierre;
       Tmp_RES_PROVISION.FieldByName('FECHA_PRIMER_DIV').asDateTime  := dFecha_Primer_Dividendo;
       Tmp_RES_PROVISION.FieldByName('FECHA_RETASACION').asDateTime  := dFecha_Retasacion;
       Tmp_RES_PROVISION.FieldByName('EMISOR').asString              := sEmisor;
       Tmp_RES_PROVISION.FieldByName('INSTRUMENTO').asString         := sInstrumento;
       Tmp_RES_PROVISION.FieldByName('SERIE').asString               := sSerie;
       Tmp_RES_PROVISION.FieldByName('NEMOTECNICO').asString         := sNemotecnico;
       Tmp_RES_PROVISION.FieldByName('VALOR_TASACION_UM').asFloat    := fVALOR_TASACION_UM;
       Tmp_RES_PROVISION.FieldByName('NRO_DIVIDENDOS_IMP').asFloat   := fNRO_DIVIDENDOS_IMP;
       Tmp_RES_PROVISION.FieldByName('DIVIDENDO_IMPAGO_UM').asFloat  := fDIVIDENDO_IMPAGO_UM;
       Tmp_RES_PROVISION.FieldByName('DIVIDENDO_IMPAGO_MC').asFloat  := fDIVIDENDO_IMPAGO_MC;
       Tmp_RES_PROVISION.FieldByName('PROVISION_UM').asFloat         := fPROVISION_UM;
       Tmp_RES_PROVISION.FieldByName('PROVISION_MC').asFloat         := fPROVISION_MC;
       Try
          Tmp_RES_PROVISION.Post;
       except on E: EDBEngineError do
           begin
             ShowError(E);
             Result := False;
             Tmp_RES_PROVISION.Cancel;
             Exit;
           end;
       end;
    end;
  end;{solo stock}
end;


{procedure Insert_Valores_MH(sEmpresa,
                            sCartera,
                            sTransaccion,
                            sFolio_interno   : String;
                            fItem_OMD        : Double;
                            sEmisor,
                            sInstrumento,
                            sSerie,
                            sNemotecnico     : String;
                            dFecha_Cierre,
                            dFecha_Primer_Dividendo,
                            dFecha_Retasacion : TDateTime;
                            fVALOR_TASACION_UM,
                            fNRO_DIVIDENDOS_IMP,
                            fDIVIDENDO_IMPAGO_UM,
                            fDIVIDENDO_IMPAGO_MC,
                            fPROVISION_UM,
                            fPROVISION_MC    : Double;
                            Result : Boolean;
                            Reg_Parametros : TParametros
                            );
begin
    Result := True;
  if NOT Reg_Parametros.bSolo_Stock then
  begin
    //Borro Antes de Insertar
    With DMValorizacion.Qry_General2 do
    begin
       Sql.Clear;
       Sql.Add( ' DELETE FROM QS_RES_PROVISION'
               +' WHERE empresa       = :empresa'
               +'   AND cartera       = :Cartera'
               +'   AND Transaccion   = :Transaccion'
               +'   AND Folio_Interno = :Folio_Interno'
               +'   AND Item_Omd      = :Item_Omd'
               +'   AND Fecha_Cierre  = :Fecha_Cierre'
               );
       Parambyname('Empresa').AsString        := sEmpresa;
       Parambyname('Cartera').AsString        := sCartera;
       Parambyname('Transaccion').AsString    := sTransaccion;
       Parambyname('Folio_Interno').AsString  := sFolio_Interno;
       Parambyname('Item_Omd').AsFloat        := fItem_Omd;
       Parambyname('Fecha_Cierre').asDatetime := dFecha_Cierre;
       try
          ExecSql;
       except on E: EDBEngineError do
         begin
           ShowError_SQL(E
                        ,Sql
                        ,'');
           Close;
           Result := False;
           Exit;
         end;
       end;
       Close;

       Sql.Clear;
       Sql.Add( ' INSERT INTO QS_RES_PROVISION'
               +' ( EMPRESA'
               +' ,CARTERA'
               +' ,FECHA_CIERRE'
               +' ,TRANSACCION'
               +' ,FOLIO_INTERNO'
               +' ,ITEM_OMD'
               +' ,EMISOR'
               +' ,INSTRUMENTO'
               +' ,SERIE'
               +' ,NEMOTECNICO'
               +' ,FECHA_PRIMER_DIV'
               +' ,FECHA_RETASACION'
               +' ,VALOR_TASACION_UM'
               +' ,NRO_DIVIDENDOS_IMP'
               +' ,DIVIDENDO_IMPAGO_UM'
               +' ,DIVIDENDO_IMPAGO_MC'
               +' ,PROVISION_UM'
               +' ,PROVISION_MC'
               +' )'
               +' VALUES(:EMPRESA'
               +' ,:CARTERA'
               +' ,:FECHA_CIERRE'
               +' ,:TRANSACCION'
               +' ,:FOLIO_INTERNO'
               +' ,:ITEM_OMD'
               +' ,:EMISOR'
               +' ,:INSTRUMENTO'
               +' ,:SERIE'
               +' ,:NEMOTECNICO'
               +' ,:FECHA_PRIMER_DIV'
               +' ,:FECHA_RETASACION'
               +' ,:VALOR_TASACION_UM'
               +' ,:NRO_DIVIDENDOS_IMP'
               +' ,:DIVIDENDO_IMPAGO_UM'
               +' ,:DIVIDENDO_IMPAGO_MC'
               +' ,:PROVISION_UM'
               +' ,:PROVISION_MC'
               +' )'
               );
       Parambyname('Empresa').AsString             := sEmpresa;
       Parambyname('Cartera').AsString             := sCartera;
       Parambyname('Transaccion').AsString         := sTransaccion;
       Parambyname('Folio_Interno').AsString       := sFolio_Interno;
       Parambyname('Item_Omd').AsFloat             := fItem_Omd;
       Parambyname('Fecha_Cierre').asDatetime      := dFecha_Cierre;
       Parambyname('FECHA_PRIMER_DIV').asDateTime  := dFecha_Primer_Dividendo;
       Parambyname('FECHA_RETASACION').asDateTime  := dFecha_Retasacion;
       Parambyname('EMISOR').asString              := sEmisor;
       Parambyname('INSTRUMENTO').asString         := sInstrumento;
       Parambyname('SERIE').asString               := sSerie;
       Parambyname('NEMOTECNICO').asString         := sNemotecnico;
       Parambyname('VALOR_TASACION_UM').asFloat    := fVALOR_TASACION_UM;
       Parambyname('NRO_DIVIDENDOS_IMP').asFloat   := fNRO_DIVIDENDOS_IMP;
       Parambyname('DIVIDENDO_IMPAGO_UM').asFloat  := fDIVIDENDO_IMPAGO_UM;
       Parambyname('DIVIDENDO_IMPAGO_MC').asFloat  := fDIVIDENDO_IMPAGO_MC;
       Parambyname('PROVISION_UM').asFloat         := fPROVISION_UM;
       Parambyname('PROVISION_MC').asFloat         := fPROVISION_MC;
       try
          ExecSql;
       except on E: EDBEngineError do
         begin
           ShowError(E);
           Result := False;
           Close;
           Exit;
         end;
      end;
      Close;
    end;
  end;
end;  }

procedure Insert_ERP_CXP(sEmpresa,
                         sCartera,
                         sTransaccion,
                         sFolio_interno   : String;
                         fItem_OMD        : Double;
                         sContraparte     : String;
                         fDir_Contraparte : Double;
                         sNemotecnico,
                         sEmisor,
                         sInstrumento,
                         sSerie,
                         sMoneda_Instrum    : String;
                         fTasa_Emision      : Double;
                         dFecha_Emision,
                         dFecha_Vencimiento,
                         dFecha_Cierre,
                         dFecha_Pago,
                         dFecha_Operacion   : TDateTime;
                         fValor_Nominal,
                         fValor_PAR_UM,
                         fValor_PAR_MC,
                         fTasa_Compra,
                         fValor_Pte_UM_Cpa,
                         fValor_Pte_MC_Cpa,
                         fValor_Pte_UM_Mdo,
                         fValor_Pte_MC_Mdo,
                         fPtj_Valor_Par_Mdo,
                         fRate_Used_Valuacion,
                         fPorcen_Valor_Cpa,
                         fDuration,
                         fDuration_Modificada,
                         fConvexidad,
                         fPlazo_al_Vcto,
                         fValor_Final_SVS_UM,
                         fValor_Final_SVS_MC : Double;
                         sClasif_Riesgo      : String;
                         fFactor_Riesgo,
                         fPrecio_Mixto,
                         fValorizacion_Mixta: Double;
                         fValorizacion_Mixta_UM: Double;
                         sMotivo_Inversion  : String;
                         fSaldo_Insoluto    : Double;
                         sComprometido : String;
                         fValor_Pte_I_Cpa_Last : Double;
                         fValor_Pte_I_Mer_Last : Double;
                         dFecha_Last_Mdo : TDatetime;
                         Var Result : Boolean;
                         Reg_Parametros                 : TParametros;
                         sCustodia_Detalle              : String;
                         fDuration_Tasa_Emi             : Double;
                         fDuration_Modificada_Tasa_Emi  : Double;
                         fNRO_DIVIDENDOS_IMP            : Double;
                         fSaldo_Insoluto_UM             : Double;
                         fSaldo_Insoluto_MC             : Double;
                         sTipo_Tasa_Precio_Cpa          : String;
                         sOrigen_Cpa                    : String;
                         sTipo_Valuac_Cpa               : String;
                         sFormula_Pte_Cpa               : String;
                         sTipo_Tasa_Precio_Mdo          : String;
                         sOrigen_Mdo                    : String;
                         sTipo_Valuac_Mdo               : String;
                         sFormula_Pte_Mdo               : String;
                         sTipo_Tasa_Precio_Mix          : String;
                         sOrigen_Mix                    : String;
                         sTipo_Valuac_Mix               : String;
                         sFormula_Pte_Mix               : String
                         );
var sCustodia_Dest : String;
    bResult    : Boolean;
    sNem_Inst : String;
    i   : Integer;
    dFecha_Hora_ERP          : TDateTime;
    sDescr_Cartera           : String;
    sMoneda_Cartera          : String;
    sProrrateo_Valores       : String;
    sString                  : String;
    aux_result               : Boolean;
    sRelacion
   ,sSistema
   ,sDescr_Transaccion
   ,sDescr_Instrumento
   ,sModulo_Err
   ,sString_Err              : String;
    fRut                     : Double;
    fRut_Contraparte         : Double;
    sDigito
   ,sDigito_Contraparte
   ,sDescr_Emisor
   ,sTipo_Moneda
   ,sDescr_Moneda
   ,sUnidad_Conversion
   ,sDescr_Tipo_Inversion
   ,sCodigo_Geo_Contraparte
   ,sPais_Titulo
   ,sDescr_Pais
   ,sDescr_Contraparte       : String;
    fItem_Dir_Contraparte    : Double;
    fFolio_Int_Correlativo   : Double;
    iCant_tipos_Monedas      : Integer;
begin

  Result := True;
  if NOT Reg_Parametros.bSolo_Stock then
  begin

// Leo Descripcion de Cartera
     Leer_Cartera(sEmpresa_Usuario,
                  sCartera,
                  sDescr_Cartera,
                  sString,
                  sMoneda_Cartera,
                  sProrrateo_Valores,
                  aux_Result);

// Leo Descripcion de Transaccion
     if NOT Datos_Transaccion(sTransaccion
                             ,sRelacion
                             ,sSistema
                             ,sDescr_Transaccion
                             ,sModulo_Err
                             ,sString_Err) then
     begin
        // Cuek
     end;

// Leo Descripcion de Insturmento
     Leer_Nombre_Instrumento(sInstrumento
                            ,sDescr_Instrumento
                            ,aux_Result
                            );

// Leo Descripcion de Emisor
     Valores_Identidad ( sEmisor
                        ,fRut
                        ,sDigito
                        ,sDescr_Emisor
                        ,aux_Result
                        );

// Leo Descripcion de Moneda Origen
     Datos_Moneda(sMoneda_Instrum
                 ,sTipo_Moneda
                 ,sDescr_Moneda
                 ,sUnidad_Conversion
                 );
// Leo Descripcion de Contraparte
     Valores_Identidad ( sContraparte
                        ,fRut_Contraparte
                        ,sDigito_Contraparte
                        ,sDescr_Contraparte
                        ,aux_Result
                        );

//     fItem_Dir_Contraparte   := default_direccion(sContraparte
//                                            ,T_MasterFecha_Operacion.AsDatetime);
     sCodigo_Geo_Contraparte := Codigo_Geo_IdDir_Mem(sContraparte
                                                    ,fDir_Contraparte);
     sPais_Titulo            := Pais_Para_CodGeo_mem(sCodigo_Geo_Contraparte);

     With DMValorizacion.QRY_General2 do
     begin
        Sql.clear;
        sql.add('SELECT b.DESCRIPCION_NODO');
        sql.add('  FROM QS_SYS_CLASIF_OBJ a');
        sql.add('      ,QS_SYS_EST_CLA    b');
        sql.add(' WHERE a.OBJETO        = ''INSTRUM'' ');
        sql.add('   AND a.ELEMENTO      = :Instrumento');                                 // 'BE'
        sql.add('   AND a.CODIGO_CLASIF = ''TIPINV'' ');
        sql.add('   AND a.CODIGO_CLASIF = b.CODIGO_OBJETO');
        sql.add('   AND a.nodo          = b.nodo');
        ParamByName('Instrumento').AsString := sInstrumento;
        Open;
        If Not Eof then
           sDescr_Tipo_Inversion := DMValorizacion.QRY_General2.FieldByName('DESCRIPCION_NODO').AsString;
        Close;
     end;

     Leer_Descripcion_Pais(sPais_Titulo
                          ,sDescr_Pais
                          ,Result);


     with DMValorizacion do
     begin
        Tmp_ERP_CtasPorPagar.Insert;

// Cabezera
        Tmp_ERP_CtasPorPagar.FieldByName('DS_CIA_ORIGEN').asString          := 'CDS VIDA';
        Tmp_ERP_CtasPorPagar.FieldByName('DS_SISTEMA_ORIGEN').asString      := 'QS';
        Tmp_ERP_CtasPorPagar.FieldByName('ID_FECHA_PROCESO').asDatetime     := dFecha_Hora_Servidor;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_NUM_PROCESO').asFloat          := StrToFloat(sFolio_Interno);
        Tmp_ERP_CtasPorPagar.FieldByName('ID_NUM_ENVIO').asFloat            := 0000000000;   // ??????????????????????????????
        Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_REGISTRO').asFloat        := 2;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_MOV').asFloat             := 10;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_ESTADO_PROC').asFloat          := 10;
        Tmp_ERP_CtasPorPagar.FieldByName('F_CANTIDAD_REG').asFloat          := 0;
        Tmp_ERP_CtasPorPagar.FieldByName('F_CANTIDAD_TIPO_MONEDA').asFloat  := 0;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_MONEDA').asString         := '';
        Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_MONEDA').asString         := '';
        Tmp_ERP_CtasPorPagar.FieldByName('F_IND_CTRL_MONTO').asFloat        := 0;

// Detalle
        Tmp_ERP_CtasPorPagar.FieldByName('ID_CARTERA').asString             := sCartera;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_CARTERA').asString             := sDescr_Cartera;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_OPERACION').asString      := sTransaccion;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_OPERACION').asString      := sDescr_Transaccion;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_INSTRUMENTO').asString         := sInstrumento;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_INSTRUMENTO').asString         := sDescr_Instrumento;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_FOLIO').asString               := sFolio_Interno;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_ITEM').asFloat                 := fItem_Omd;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_NEMOTECNICO').asString         := sNemotecnico;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_EMISOR').asString              := sEmisor;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_EMISOR').asString              := sDescr_Emisor;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_INVERSION').asString      := sDescr_Tipo_Inversion;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_INVERSION').asString      := sDescr_Tipo_Inversion;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_CIA').asString                 := 'CDS VIDA';
        Tmp_ERP_CtasPorPagar.FieldByName('ID_SUCURSAL').asString            := 'CDS VIDA';
        Tmp_ERP_CtasPorPagar.FieldByName('DS_SUCURSAL').asString            := 'CDS VIDA';
        Tmp_ERP_CtasPorPagar.FieldByName('ID_MOTIVO_INVERSION').asString    := sMotivo_Inversion;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_LINEA').asString               := '-2';
        Tmp_ERP_CtasPorPagar.FieldByName('ID_DIVISA_MONEDA').asString       := sMoneda_Instrum;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_DIVISA_MONEDA').asString       := sDescr_Moneda;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_FEC_CONVERSION').asDatetime    := dFecha_Pago;               // nuevo
        Tmp_ERP_CtasPorPagar.FieldByName('F_TIPO_CAMBIO').asFloat           := (fValor_Pte_MC_Mdo / fValor_Nominal);
        Tmp_ERP_CtasPorPagar.FieldByName('F_MONTO_MONEDA').asFloat          := fValor_Pte_MC_Mdo;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_FEC_OPERACION').asDatetime     := dFecha_Operacion;
        Tmp_ERP_CtasPorPagar.FieldByName('ID_FEC_PAGO_CXP').asDatetime      := dFecha_Pago;               // nuevo
        Tmp_ERP_CtasPorPagar.FieldByName('ID_PROVEEDOR').asString           := sContraparte;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_PROVEEDOR').asString           := sDescr_Contraparte;        // nuevo
        Tmp_ERP_CtasPorPagar.FieldByName('ID_RUT').asFloat                  := fRut_Contraparte;        // nuevo
        Tmp_ERP_CtasPorPagar.FieldByName('DS_DVRUT').asString               := sDigito_Contraparte;
//        if T_DetalleImpuesto_MC.AsFloat <> 0 then
//        begin
           Tmp_ERP_CtasPorPagar.FieldByName('ID_COD_IMPUESTO').asString        := 'IVA';
           Tmp_ERP_CtasPorPagar.FieldByName('DS_COD_IMPUESTO').asString        := 'IVA';
//        end
//        else
//        begin
//           Tmp_ERP_CtasPorPagar.FieldByName('ID_COD_IMPUESTO').asString        := '';
//           Tmp_ERP_CtasPorPagar.FieldByName('DS_COD_IMPUESTO').asString        := '';
//        end;
        Tmp_ERP_CtasPorPagar.FieldByName('F_VALOR_IMPUESTO').asFloat        := 0;
        Tmp_ERP_CtasPorPagar.FieldByName('F_VALOR_COMISION').asFloat        := 0;
        Tmp_ERP_CtasPorPagar.FieldByName('F_MONTO_TOTAL_OPERACION').asFloat := fValor_Pte_Mc_Cpa;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_FACTURA').asString             := sFolio_Interno+FloatToStr(fItem_Omd);
//        if T_DetalleImpuesto_MC.AsFloat <> 0 then
//        begin
           Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_DOCUMENTO').asString      := 'IVA';
           Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_DOCUMENTO').asString      := 'IVA';
//        end
//        else
//        begin
//           Tmp_ERP_CtasPorPagar.FieldByName('ID_TIPO_DOCUMENTO').asString      := '';
//           Tmp_ERP_CtasPorPagar.FieldByName('DS_TIPO_DOCUMENTO').asString      := '';
//        end
        Tmp_ERP_CtasPorPagar.FieldByName('ID_PAIS').asString                := sPais_Titulo;
        Tmp_ERP_CtasPorPagar.FieldByName('DS_PAIS').asString                := sDescr_Pais;

        try
           Tmp_ERP_CtasPorPagar.Post;
        except on E: EDBEngineError do
           begin
             ShowError(E);
             Result := False;
             Tmp_ERP_CtasPorPagar.Cancel;
             Exit;
           end;
        end;
     end;
  end;{solo stock}
end;

procedure LiberarMemoria;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
end;

end.


