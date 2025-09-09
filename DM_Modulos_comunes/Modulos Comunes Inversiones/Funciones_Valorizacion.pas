unit Funciones_Valorizacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DM_Variables_Valorizacion, DB ,DM_Global_Var,DM_Variables_Menu,
  DM_FuncionesMemory, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Variants;

type
  TTasas_Equivalentes = Record
                        Limite_Inf               : Double;
                        Limite_Sup               : Double;
                        Valor_Tasa               : Double;
                        Valor_Implicito          : Double;
                        Base_Porcentual          : Double;
                        Vigencia_Valor           : Double;
                        Vigencia_Meses           : Double;
                        Base_Mensual_Tasa        : Double;
                        Vigencia_Original        : Double;
                        Vigencia_Meses_Original  : Double;
                        Base_Porcentual_Original : Double;
                        end;

  // TArray_Tasas_Equivalentes = Array[1..Max_Nro_Cupones] of TTasas_Equivalentes;
  TArray_Tasas_Equivalentes = Array of TTasas_Equivalentes;

  TInterpolacion = Record
                   Nro_Cupon        : Double;
                   Limite_Inf       : Double;
                   Valor_Inf        : Double;
                   Limite_Sup       : Double;
                   Valor_Sup        : Double;
                   Valor_Implicito  : Double;
                   Tasa_Interpolada : Double;
                   end;

  TArray_Interpolacion = Array[1..200] of TInterpolacion;

  TdmFunciones_Valorizacion = class(TDataModule)
    Qry_Aux: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Valor_Final_Unicos(sTipo_Nominales   : String;
                             dFecha_emision    : TDateTime;
                             dFecha_Vcto       : TDateTime;
                             sTasa_base_par    : String;
                             fTasa_emision     : Double;
                             fNominales        : Double;
                         var sModulo_Err       : String;
                         var sString_Err       : String;
                         var fValor_Final_um   : Double);
  
  Procedure Duration_Fijo(sInstrumento   : String;
                          dFecha_Calculo : TDateTime;
                          Var fDuration  : Double;
                          Var Result         : Boolean);


  procedure Calculo_Duration( sEmisor,
                           sInstrumento,
                           sSerie,
                           sNemotecnico,
                           sTipo_Instrumento   : String;
                           dFecha_Emision,
                           dFecha_Vencimiento,
                           dFecha_Calculo      : TDatetime;
                           fNominales,
                           fTasa_Mercado       : Double;
                           fTasa_Emision       : Double;
                           sMoneda_Instrumento : String;
                           var Reg_Val_In          : TRegistro_Valoriza_In;    //ggarcia 24-03-2015 a var por access violation
                           var Reg_Val_Out         : TRegistro_Valoriza_Out;   //ggarcia 24-03-2015 a var por access violation
                          var fDuration        : Double;
                          var fDuracion_Modificada : Double;
                          var fConvexidad      : Double;
                          var sModulo_Error    : String;
                          var sString_Error    : String;
                          var Result           : Boolean
                         );

  procedure Calculo_Duration_Vig( sEmisor,
                                  sInstrumento,
                                  sSerie,
                                  sNemotecnico,
                                  sTipo_Instrumento   : String;
                                  //dFecha_Vig,
                                  dFecha_Emision,
                                  dFecha_Vencimiento,
                                  dFecha_Calculo      : TDatetime;
                                  fNominales,
                                  fTasa_Mercado       : Double;
                                  fTasa_Emision       : Double;
                                  sMoneda_Instrumento : String;
                                  Reg_Val_In          : TRegistro_Valoriza_In;
                                  Array_Mem_Desarr    : TArray_Mem_Desarr;
                                  RegDes              : TReg_Descriptor;
                                 var fDuration        : Double;
                                 var fDuracion_Modificada : Double;
                                 var fConvexidad      : Double;
                                 var sModulo_Error    : String;
                                 var sString_Error    : String;
                                 var Result           : Boolean
                                );

  procedure Valor_PAR(Reg_Formula_PAR             : TRegFormulaPAR;
                      Reg_Formula_TIR             : TRegFormulaTIR;
                      sTipo_Instrumento           : String;
                      var Array_Mem_Desarr        : TArray_Mem_Desarr;
                      sNemotecnico                : STring;
                      RegDes                      : TReg_Descriptor;
                      fNominales                  : Double;
                      Reg_Fechas                  : TRegistro_Fechas;
                      bConCupon                   : Boolean;
                      sLLamado_Por                : String;
                      sValor_Cupon_Original       : String; // Calcula valores sin variacion cambiaria
                      sComponentes_Descuento      : String; // Si es blanco (Valor CUpon COmpleto)
                      var fValor_Par              : Double;
                      var fValor_Par_UM           : Double;
                      var acc_impuesto            : Double;
                      var sModulo_Err             : String;
                      var sString_Err             : String;
                      var Result                  : Boolean);

  procedure Valor_PTE(Reg_Formula_PAR      : TRegFormulaPAR;
                      Reg_Formula_TIR      : TRegFormulaTIR;
                      sTipo_Instrumento    : String;
                      var Array_Mem_Desarr : TArray_Mem_Desarr;
                      sNemotecnico         : String;
                      RegDes               : TReg_Descriptor;
                      fTasaCalculo         : Double;
                      fSpread              : Double; 
                      Reg_Fechas           : TRegistro_Fechas;
                      fNominales           : Double;
                      fValor_Par_Base      : Double;
                      fValor_Par_UM        : Double;
                      bConCupon            : Boolean;
                      bAcumula_Factor      : Boolean;
                      sLLamado_Por         : String;
                      sValor_Cupon_Original  : String;
                      sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                      fNominales_Compra    : Double;
                      fValor_Pte_UM_Compra : Double;
                      sOrigen              : String;
                      var fValor_Presente  : Double;
                      var fValor_Pte_UM    : Double;
                      var fValor_Par_Corto : Double;
                      var acc_impuesto     : Double;
                      var sModulo_Err      : String;
                      var sString_Err      : String;
                      var Result           : Boolean);

  procedure Valor_PAR_Con_Descriptor(Reg_Formula_PAR      : TRegFormulaPAR;
                                     Reg_Formula_TIR      : TRegFormulaTIR;
                                     var Array_Mem_Desarr : TArray_Mem_Desarr;
                                     sNemotecnico         : STring;
                                     RegDes               : TReg_Descriptor;
                                     fNominales           : Double;
                                     Reg_Fechas           : TRegistro_Fechas;
                                     bConCupon            : Boolean;
                                     sValor_Cupon_Original : String;
                                     sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                     var fValor_Par       : Double;
                                     var fValor_Par_UM    : Double;
                                     var acc_impuesto     : Double;
                                     var sModulo_Err      : String;
                                     var sString_Err      : String;
                                     var Result           : Boolean);

  procedure Valor_PAR_Con_Descriptor_TFija(Reg_Formula_PAR        : TRegFormulaPAR;
                                           Reg_Formula_TIR        : TRegFormulaTIR;
                                           var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                           sNemotecnico           : String;
                                           RegDes                 : TReg_descriptor;
                                           Reg_Fechas             : TRegistro_Fechas;
                                           bConCupon              : Boolean;
                                           sValor_Cupon_Original : String;
                                           sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                           var fValor_Par         : Double;
                                           var sModulo_Err        : String;
                                           var sString_Err        : String;
                                           var Result             : Boolean);

  procedure Valor_PAR_Con_Descriptor_TFija_FF(var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                              sNemotecnico           : String;
                                              RegDes                 : TReg_descriptor;
                                              Reg_Fechas             : TRegistro_Fechas;
                                              bConCupon              : Boolean;
                                              sValor_Cupon_Original : String;
                                              sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                              var fValor_Par         : Double;
                                              var sModulo_Err        : String;
                                              var sString_Err        : String;
                                              var Result             : Boolean);

  procedure Valor_PAR_Con_Descriptor_TFija_SI(var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                              sNemotecnico           : String;
                                              RegDes                 : TReg_descriptor;
                                              Reg_Fechas             : TRegistro_Fechas;
                                              bConCupon              : Boolean;
                                              sValor_Cupon_Original  : String;
                                              sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)                                              
                                              var fValor_Par         : Double;
                                              var sModulo_Err        : String;
                                              var sString_Err        : String;
                                              var Result             : Boolean);

  procedure Valor_PTE_Con_Descriptor(Reg_Formula_PAR      : TRegFormulaPAR;
                                     Reg_Formula_TIR      : TRegFormulaTIR;
                                     sTipo_Instrumento    : String;
                                     var Array_Mem_Desarr : TArray_Mem_Desarr;
                                     sNemotecnico         : String;
                                     RegDes               : TReg_Descriptor;
                                     fTasaCalculo         : Double;
                                     fSpread              : Double;
                                     Reg_Fechas           : TRegistro_Fechas;
                                     fNominales           : Double;
                                     P_Valor_PAR          : Double;
                                     fValor_Par_UM        : Double;
                                     bConCupon            : Boolean;
                                     bAcumula_Factor      : Boolean;
                                     sLLamado_Por         : String;
                                     sValor_Cupon_Original  : String;
                                     sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                     fNominales_Compra    : Double;
                                     fValor_Pte_UM_Compra : Double;
                                     sOrigen              : String;
                                     var fValor_Presente  : Double;
                                     var fValor_Pte_UM    : Double;
                                     var fValor_Par_Corto : Double;
                                     var sModulo_Err      : String;
                                     var sString_Err      : String;
                                     var Result           : Boolean);

  procedure Valor_PAR_Con_Descriptor_TFlot(Reg_Formula_PAR  : TRegFormulaPAR;
                                           Reg_Formula_TIR  : TRegFormulaTIR;
                                           var Array_Mem_Desarr : TArray_Mem_Desarr;
                                           sNemotecnico     : String;
                                           RegDes           : TReg_Descriptor;
                                           Reg_Fechas       : TRegistro_Fechas;
                                           bConCupon        : Boolean;
                                           sValor_Cupon_Original : String;
                                           sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                           var fValor_Par   : Double;
                                           var sModulo_Err  : String;
                                           var sString_Err  : String;
                                           var Result       : Boolean);

  procedure Valor_PAR_Con_Descriptor_TFlot_SI(Reg_Formula_PAR  : TRegFormulaPAR;
                                              Reg_Formula_TIR  : TRegFormulaTIR;
                                              var Array_Mem_Desarr : TArray_Mem_Desarr;
                                              sNemotecnico     : String;
                                              RegDes           : TReg_Descriptor;
                                              Reg_Fechas       : TRegistro_Fechas;
                                              bConCupon        : Boolean;
                                              sValor_Cupon_Original       : String;
                                              sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                              var fValor_Par   : Double;
                                              var sModulo_Err  : String;
                                              var sString_Err  : String;
                                              var Result       : Boolean);

  procedure Valor_PAR_Sin_Descriptor(Reg_Formula_PAR   : TRegFormulaPAR;
                                     Reg_Formula_TIR   : TRegFormulaTIR;
                                     fNominales        : Double;
                                     fTasaCalculo      : Double;
                                     var Array_Mem_Desarr : TArray_Mem_Desarr;
                                     Reg_fechas        : TRegistro_Fechas;
                                     sTasa_Base        : String;
                                     RegDes            : TReg_Descriptor;
                                     sLLamado_Por      : String;
                                     sValor_Cupon_Original : String;
                                     sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)                                     
                                     var fValor_Par_UM : Double;
                                     var acc_impuesto : Double;
                                     var sModulo_Err   : String;
                                     var sString_Err   : String;
                                     var Result        : Boolean);

  procedure Valor_PTE_Con_Descriptor_TFija(Reg_Formula_PAR        : TRegFormulaPAR;
                                           Reg_Formula_TIR        : TRegFormulaTIR;
                                           sTipo_Instrumento      : String;
                                           var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                           sNemotecnico           : String;
                                           RegDes                 : TReg_descriptor;
                                           fTasaCalculo           : Double;
                                           fSpread                : Double;
                                           Reg_Fechas             : TRegistro_Fechas;
                                           fNominales_Compra      : Double;
                                           P_Valor_PAR            : Double;
                                           Valor_Par_UM           : Double;
                                           bConCupon              : Boolean;
                                           bAcumula_Factor        : Boolean;
                                           sLLamado_Por           : String;
                                           sValor_Cupon_Original  : String;
                                           sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                           sOrigen                : String;
                                           var fValor_Presente    : Double;
                                           fValor_Pte_UM_Compra   : Double;
                                           var fValor_Par_Corto   : Double;
                                           var sModulo_Err        : String;
                                           var sString_Err        : String;
                                           var Result             : Boolean);

  procedure Valor_PTE_Con_Descriptor_TFlot(Reg_Formula_PAR        : TRegFormulaPAR;
                                           Reg_Formula_TIR        : TRegFormulaTIR;
                                           sTipo_Instrumento      : String;
                                           var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                           sNemotecnico           : String;
                                           RegDes                 : TReg_descriptor;
                                           fTasaCalculo           : Double;
                                           fSpread                : Double;
                                           Reg_Fechas             : TRegistro_Fechas;
                                           fNominales_Compra      : Double;
                                           P_Valor_PAR            : Double;
                                           Valor_Par_UM           : Double;
                                           bConCupon              : Boolean;
                                           bAcumula_Factor        : Boolean;
                                           sLLamado_Por           : String;
                                           sValor_Cupon_Original  : String;
                                           sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                           sOrigen                : String;
                                           var fValor_Presente    : Double;
                                           fValor_Pte_UM_Compra   : Double;
                                           var fValor_Par_Corto   : Double;
                                           var sModulo_Err        : String;
                                           var sString_Err        : String;
                                           var Result             : Boolean);

  procedure Valor_PTE_Con_Descriptor_TFlot_FF(Reg_Formula_PAR        : TRegFormulaPAR;
                                              Reg_Formula_TIR        : TRegFormulaTIR;
                                              sTipo_Instrumento      : String;
                                              var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                              sNemotecnico           : String;
                                              RegDes                 : TReg_descriptor;
                                              fTasaCalculo           : Double;
                                              fSpread                : Double;
                                              Reg_Fechas             : TRegistro_Fechas;
                                              fNominales_Compra      : Double;
                                              P_Valor_PAR            : Double;
                                              Valor_Par_UM           : Double;
                                              bConCupon              : Boolean;
                                              bAcumula_Factor        : Boolean;
                                              sLLamado_Por           : String;
                                              sValor_Cupon_Original  : String;
                                              sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                              sOrigen                : String;
                                              var fValor_Presente    : Double;
                                              fValor_Pte_UM_Compra   : Double;
                                              var fValor_Par_Corto   : Double;
                                              var sModulo_Err        : String;
                                              var sString_Err        : String;
                                              var Result             : Boolean);

  procedure Valor_PTE_Sin_Descriptor(Reg_Formula_PAR   : TRegFormulaPAR;
                                     Reg_Formula_TIR   : TRegFormulaTIR;

                                     sTipo_Instrumento : String;
                                     sNemotecnico      : String;
                                     bConCupon         : Boolean;
                                     fSpread           : Double;

                                     fNominales        : Double;
                                     fTasaCalculo      : Double;
                                     var Array_Mem_Desarr : TArray_Mem_Desarr;
                                     Reg_Fechas        : TRegistro_Fechas;
                                     sTasa_Base        : String;
                                     RegDes            : TReg_Descriptor;
                                     sLLamado_Por      : String;
                                     sValor_Cupon_Original : String;
                                     sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                     sOrigen                : String;
                                     var fValor_Pte_UM : Double;
                                     var acc_impuesto : Double;
                                     var sModulo_Err   : String;
                                     var sString_Err   : String;
                                     var Result        : Boolean);

   procedure Valor_Par_Sin_Descriptor_TasaFlotante(Reg_Formula_PAR   : TRegFormulaPAR;
                                                   Reg_Formula_TIR   : TRegFormulaTIR;
                                                   fNominales        : Double;
                                                   Reg_Fechas        : TRegistro_Fechas;
                                                   RegDes            : TReg_Descriptor;
                                                   sLLamado_Por      : String;
                                                   var fValor_Par_UM : Double;
                                                   var acc_impuesto : Double;
                                                   var sModulo_Err   : String;
                                                   var sString_Err   : String;
                                                   var Result        : Boolean);

   procedure Valor_Sin_Descriptor_TasaFija_SI(fNominales        : Double;
                                              fTasaCalculo      : Double;
                                              sTasa_Base        : String;
                                              var Array_Mem_Desarr : TArray_Mem_Desarr;
                                              dFecha_Calculo    : TdateTime;
                                              dFecha_Emision    : TdateTime;
                                              RegDes            : TReg_Descriptor;
                                              sValor_Cupon_Original : String;
                                              sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                              var fValor        : Double;
                                              var sModulo_Err   : String;
                                              var sString_Err   : String;
                                              var Result        : Boolean);

   procedure Valor_Sin_Descriptor_TasaFija_FF(fNominales        : Double;
                                              fTasaCalculo      : Double;
                                              sTasa_Base        : String;
                                              var Array_Mem_Desarr  : TArray_Mem_Desarr;
                                              dFecha_Calculo    : TdateTime;
                                              RegDes            : TReg_Descriptor;
                                              sValor_Cupon_Original : String;
                                              sComponentes_Descuento : String;
                                              var fValor_Pte_UM : Double;
                                              var sModulo_Err   : String;
                                              var sString_Err   : String;
                                              var Result        : Boolean);

   procedure Valor_Pte_Sin_Descriptor_TasaFlotante(Reg_Formula_PAR   : TRegFormulaPAR;
                                                   Reg_Formula_TIR   : TRegFormulaTIR;
                                                   fNominales        : Double;
                                                   Reg_Fechas        : TRegistro_Fechas;
                                                   RegDes            : TReg_Descriptor;
                                                   sLLamado_Por      : String;
                                                   var fValor_Pte_UM : Double;
                                                   var acc_impuesto     : Double;
                                                   var sModulo_Err   : String;
                                                   var sString_Err   : String;
                                                   var Result        : Boolean);

  procedure Valorizacion_Acumulada_Sin_Descriptor(sTasa_Base_Spread    : String;
                                                  sCodigo_Tasa         : String;
                                                  sTratamiento         : String;
                                                  sSpread_Operacion    : String;
                                                  fSpread_Factor       : Double;
                                                  sSpread_Variable     : String;
                                                  sDias_Habiles        : String;
                                                  fNominales           : Double;
                                                  Reg_Fechas           : TRegistro_Fechas;
                                                  RegDes               : TReg_Descriptor;
                                                  sLLamado_Por         : String;
                                                  var fValor_Acumulado : Double;
                                                  var acc_impuesto     : Double;
                                                  var sModulo_Err      : String;
                                                  var sString_Err      : String;
                                                  var Result           : Boolean);

  procedure Descuento_Flujos_Futuros(var Array_Mem_Desarr  : TArray_Mem_Desarr;
                                     RegDes                : TReg_descriptor;
                                     fTasaCalculo          : Double;
                                     dFecha_Calculo        : TDateTime;
                                     sTasaBase             : String;
                                     bConCupon             : Boolean;
                                     bAcumula_Factor       : Boolean;
                                     bSolo_Cupon_Vigente   : Boolean;  // Para obtener solo el valor del cupon
                                     sValor_Cupon_Original  : String;  // No toma en cuenta Execepcion Variacion Cambiaria
                                     sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                     var fValor_Actual     : Double;
                                     var sModulo_Err       : String;
                                     var sString_Err       : String;
                                     var Result            : Boolean);

  procedure Calcula_Interes(dFecha_Desde     : TDateTime;
                            dFecha_Hasta     : TDateTime;
                            var RegDes           : TReg_Descriptor;
                            var Reg_TasFlot      : TRegistro_TasFlot;
                            var Reg_Fechas       : TRegistro_Fechas;
                            var Array_Mem_Desarr    : TArray_Mem_Desarr;
                            bTasa_Flotante   : Boolean;
                            sCodigo_Tasa     : String;
                            fValorTasa       : Double;
                            iDiasBase        : Integer;
                            sTipoInteres     : String;
                            iBaseMensual     : Integer;
                            fBase_Porcentual : Double;
                            sTipoCalculoDias : String;
                            sPais_Tasa       : String;
                            iVigenciaValor   : Integer;
                            bDesagio         : Boolean;
                            sMetodo_Tasa_Referencia : String;
                            sNombreTablaReferencia  : String;
                            var sTasa_Real_Estimado : String;
                            var Interes      : Double;
                            var Modulo_Err   : String;
                            var String_Err   : String;
                            var Result       : Boolean);

  procedure Calculo_TIR_BR(dFecha_Emision,
                           dFecha_Vencimiento,
                           dFecha_Calculo            : TDateTime;
                           fValor_Nominal,
                           fTasa_Informada,
                           fValor_Inversion,
                           fTasa_Capitalizacion      : Double;
                           var fPrecio               : Double;
                           var fValor_PAR            : Double;
                           var fValor_Final          : Double;
                           var fValor_Presente       : Double;
                           var fTasa_Calculo         : Double;
                           var String_Modulo         : String;
                           var String_Error          : String;
                           var Result                : Boolean);


  procedure Calculo_BR(dFecha_Emision,
                       dFecha_Vencimiento,
                       dFecha_Calculo            : TDateTime;
                       fValor_Nominal,
                       fTasa_Informada,
                       fValor_Inversion,
                       fTasa_Capitalizacion      : Double;
                       var fPrecio               : Double;
                       var fValor_PAR_UM         : Double;
                       var fValor_PAR            : Double;
                       var fValor_Final          : Double;
                       var fValor_Presente       : Double;
                       var fTasa_Calculo         : Double;
                       var String_Modulo         : String;
                       var String_Error          : String;
                       var Result                : Boolean);

  procedure Calculo_BR_2008(dFecha_Emision,
                       dFecha_Vencimiento,
                       dFecha_Calculo            : TDateTime;
                       fValor_Nominal,
                       fTasa_Informada,
                       fValor_Inversion,
                       fTasa_Capitalizacion      : Double;
                       var fPrecio               : Double;
                       var fValor_PAR_UM         : Double;
                       var fValor_PAR            : Double;
                       var fValor_Final          : Double;
                       var fValor_Presente       : Double;
                       var fTasa_Calculo         : Double;
                       var String_Modulo         : String;
                       var String_Error          : String;
                       var Result                : Boolean);

  procedure  CALCULO_PTE_CORA(emisor,instrumento,serie   : string;
                              FechaCalculo,FechaEmision  : TDateTime;
                              FechaVcto                  : TDateTime;
                              TasaBasePar                : string;
                              TotalCupones               : integer;
                              ValorNominal               : double;
                              TasaEmision                : double;
                              TasaCalculo                : double;
                              Ipc_emision, Ipc_Calculo   : double;
                              BaseConversion             : integer;
                          var Valor_Par_100              : double;
                          var Valor_par_um_cora          : double;
                          var P_valor_par                : double;
                          var Valor_pte_um               : double;
                          var Modulo_err                 : String;
                          var String_err                 : String;
                          var Result                     : Boolean
                          );

  procedure Calculo_TIR(Reg_Formula_PAR      : TRegFormulaPAR;
                        Reg_Formula_TIR      : TRegFormulaTIR;
                        sTipo_Instrumento    : String;
                        var Array_Mem_Desarr : TArray_Mem_Desarr;
                        sNemotecnico         : String;
                        RegDes               : TReg_Descriptor;
                        Reg_Fechas           : TRegistro_Fechas;
                        fNominales           : Double;
                        fValor_Par_Base      : Double;
                        fValor_Par_UM        : Double;
                        bConCupon            : Boolean;
                        bAcumula_Factor      : Boolean;
                        sValor_Cupon_Original  : String;  // No toma en cuenta Execepcion Variacion Cambiaria
                        sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                        sOrigen                : String;
                        var fTasaCalculo     : Double;
                        var fTIR_Desarr      : Double;
                        var fValor_Presente  : Double;
                        var fValor_Pte_UM    : Double;
                        var fValor_Par_Corto : Double;
                        var sModulo_Err      : String;
                        var sString_Err      : String;
                        var Result           : Boolean);

  procedure Calculo_TIR_SinCupones(Reg_Fechas       : TRegistro_Fechas;
                                   RegDes           : TReg_Descriptor;
                                   fValor_Final     : Double;
                                   fValor_Pte_UM    : Double;
                                   var fTasaCalculo : Double;
                                   var sModulo_Err  : String;
                                   var sString_Err  : String;
                                   var Result       : Boolean);

  procedure Calcula_Tasa_Descuento_ProySimple(sMetodo_Tasa_Basica  : String;
                                              Reg_Formula_PAR      : TRegFormulaPAR;
                                              Reg_Formula_TIR      : TRegFormulaTIR;
                                              sTipo_Instrumento    : String;
                                              var Array_Mem_Desarr : TArray_Mem_Desarr;
                                              sNemotecnico         : String;
                                              RegDes               : TReg_Descriptor;
                                              Reg_Fechas           : TRegistro_Fechas;
                                              fNominales_Compra    : Double;
                                              bConCupon            : Boolean;
                                              fValor_Pte_UM_Compra : Double;
                                              sOrigen              : String;
                                              var sModulo_Err      : String;
                                              var sString_Err      : String;
                                              var Result           : Boolean);

  procedure Calcula_Tasa_Descuento_Futuro_Imp(sMetodo_Tasa_Basica  : String;
                                              Reg_Formula_PAR      : TRegFormulaPAR;
                                              Reg_Formula_TIR      : TRegFormulaTIR;
                                              sTipo_Instrumento    : String;
                                              var Array_Mem_Desarr : TArray_Mem_Desarr;
                                              sNemotecnico         : String;
                                              RegDes               : TReg_Descriptor;
                                              Reg_Fechas           : TRegistro_Fechas;
                                              fNominales_Compra    : Double;
                                              bConCupon            : Boolean;
                                              fValor_Pte_UM_Compra : Double;
                                              sOrigen              : String;
                                              var sModulo_Err      : String;
                                              var sString_Err      : String;
                                              var Result           : Boolean);


  procedure Calcula_Tasa_Basica_Proyeccion_Simple(sCodigo_Tasa     : String;
                                                  RegDes           : TReg_Descriptor;
                                                  dFecha_Calculo   : TDateTime;
                                                  var fTasa_Basica : Double;
                                                  var sModulo_Err  : String;
                                                  var sString_Err  : String;
                                                  var Result       : Boolean);

  procedure Calcula_Tasa_Basica_Futuros_implicitos(sCodigo_Tasa                : String;
                                                   iNro_Cupon                  : Integer;
                                                   RegDes                      : TReg_Descriptor;
                                                   dFecha                      : TDateTime;
                                                   Reg_Fechas                  : TRegistro_Fechas;
                                                   var Array_Mem_Desarr        : TArray_Mem_Desarr;
                                                   var bTasas_Basicas_Cargadas : Boolean;
                                                   var sModulo_Err             : String;
                                                   var sString_Err             : String;
                                                   var Result                  : Boolean);


  procedure Calcula_Tasa_Basica_Con_Tasa_Refencia_Proy_Simple(dFecha_Desde       : TDateTime;
                                                              dFecha_Hasta       : TDateTime;
                                                              sCodigo_Tasa       : String;
                                                              RegDes             : TReg_Descriptor;
                                                              fTasa_Original     : Double;
                                                              dFecha_Calculo     : TDateTime;
                                                              var fTasa_Basica   : Double;
                                                              var sModulo_Err    : String;
                                                              var sString_Err    : String;
                                                              var Result         : Boolean);



  procedure Carga_Valores_Tasas_Equivalentes(sCodigo_Tasa    : String;
                                             dFecha          : TDateTime;
                                             bIntermedios    : Boolean;
                                             var Array_Tasas   : TArray_Tasas_Equivalentes;
                                             var sModulo_Err : String;
                                             var sString_Err : String;
                                             var Result      : Boolean);

  procedure Actualiza_Valores_Tasas_Implicitas(sReal_Estimado  : String;
                                               fVigencia_Meses : Double;
                                               var Array_Tasas   : TArray_Tasas_Equivalentes;
                                               var sModulo_Err : String;
                                               var sString_Err : String;
                                               var Result      : Boolean);

  procedure Interpolacion_Array_Tasas(Real_Estimado         : String;
                                      fVigencia_Meses       : Double;
                                      bInterpolar           : Boolean;
                                      iCupon_Desde          : Integer;
                                      var Array_Tasas_Seleccionadas : TArray_Tasas_Equivalentes;
                                      var Array_Mem_Desarr          : TArray_Mem_Desarr;
                                      var Array_Interpolacion       : TArray_Interpolacion;
                                      var sModulo_Err       : String;
                                      var sString_Err       : String;
                                      var Result            : Boolean);

  procedure Completa_limites_Cupones(iCupon_Desde            : Integer;
                                     dFecha_Calculo          : TDateTime;
                                     var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                     var Array_Interpolacion : TArray_Interpolacion;
                                     var sModulo_Err         : String;
                                     var sString_Err         : String;
                                     var Result              : Boolean);

  procedure Selecciona_Tasas_Utilizadas(Array_Tasas                   : TArray_Tasas_Equivalentes;
                                        fLimite_Inferior              : Double;
                                        fLimite_Superior              : Double;
                                        bInterpola                    : Boolean;
                                        Periodo_Meses                 : Double;
                                        Real_Estimado                 : String;
                                        var Array_Tasas_Seleccionadas : TArray_Tasas_Equivalentes;
                                        var sModulo_Err               : String;
                                        var sString_Err               : String;
                                      var Result                    : Boolean);

  procedure Calcula_Tasa_Descuento(RegParamMargen       : TRegParamMargen;
                                   sTipo_Instrumento    : String;
                                   var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   sNemotecnico         : String;
                                   RegDes               : TReg_Descriptor;
                                   Reg_Fechas           : TRegistro_Fechas;
                                   fNominales_Compra    : Double;
                                   bConCupon            : Boolean;
                                   fValor_Pte_UM_Compra : Double;
                                   dTasa_Compra         : Double;
                                   fSpread              : Double;
                                   sOrigen              : String;
                                   sTipo_Valuac         : String;     //ggarcia 22-05-2013 para leer tasa mercado BR
                                   var sModulo_Err      : String;
                                   var sString_Err      : String;
                                   var Result           : Boolean);
 Procedure Busca_Valor( ArrayFechas,
                        ArrayValores : Variant;
                        dFecha_Tasa  : TDatetime;
                    var dValor_Tasa  : Double;
                    var Result       : Boolean);

function Feriado_Memory(sCodigo_Division : String;
                        dFecha           : TDatetime) : Boolean;
//   se comenta ya que existe en el DM_ComunInversiones   PA - FI   22/05/2020
//procedure Tratamiento_Fecha_Memory(sCodigo_Tratam   : String;
//                                   Registro_Fechas  : TRegistro_Fechas;
//                                   var Fecha_Result : TDateTime;
//                                   var Modulo_Err   : String;
//                                   var String_Err   : String;
//                                   var Result       : Boolean);


 procedure Carga_Valores_Tasa_Memory( sCodigo_Tasa   : String;
                                      dFecha_Inicial : TDatetime;
                                      dFecha_Final   : TDatetime
                                    );

 Procedure Calculo_Pactos( Var fValor_Invertido_UM_Inicial : Double;
                           Var fValor_Invertido_MC_Inicial : Double;
                           fTasa_Calculo    : Double;
                           sMoneda_Pacto,
                           sTipo_Nominales,
                           sMoneda_Conversion,
                           sTasa_Base_Pacto : String;
                           dFecha_Calculo,
                           dFecha_Vencimiento_Pacto,
                           dFecha_Operacion       : TDatetime;
                           Var fValor_Invertido_UM_Final : DoublE;
                           Var fValor_Invertido_MC_Final : Double;
                           Var sModulo_Error : String;
                           Var sString_Error : String;
                           Var Result        : Boolean
                         );

 Procedure Calculo_Pactos_RV( Var fValor_Invertido_UM_Inicial : Double;
                           Var fValor_Invertido_MC_Inicial : Double;
                           fTasa_Calculo    : Double;
                           sMoneda_Pacto,
                           sTipo_Nominales,
                           sMoneda_Conversion,
                           sTasa_Base_Pacto : String;
                           dFecha_Calculo,
                           dFecha_Vencimiento_Pacto,
                           dFecha_Operacion       : TDatetime;
                           Var fValor_Invertido_UM_Final : DoublE;
                           Var fValor_Invertido_MC_Final : Double;
                           Var sModulo_Error : String;
                           Var sString_Error : String;
                           Var Result        : Boolean
                         );

 Procedure Calculo_Forward(sInstrumento              : String;
                           sTipo_Valuacion           : String;
                           Valor_Nocional            : Double;
                           sMoneda_Nocional          : String;
                           sMoneda_Contrato          : String;
                           dFecha_Calculo            : TDatetime;
                           dFecha_Vcto               : TDatetime;
                           sOrigen                   : String;
                       Var fTipo_Cambio              : Double;
                       Var fFX_POINTS                : Double;
                       var fTipo_Cambio_fwd          : Double;
                       Var fValor_Invertido_UM_Final : Double;
                       Var sModulo_Error             : String;
                       Var sString_Error             : String;
                       Var Result                    : Boolean);

 procedure Calculo_TIR_PTE(Reg_Formula_PAR      : TRegFormulaPAR;
                           Reg_Formula_TIR      : TRegFormulaTIR;
                           sTipo_Instrumento    : String;
                           var Array_Mem_Desarr : TArray_Mem_Desarr;
                           sNemotecnico         : String;
                           RegDes               : TReg_Descriptor;
                           Reg_Fechas           : TRegistro_Fechas;
                           fNominales           : Double;
                           fValor_Par_Base      : Double;
                           fValor_Par_UM        : Double;
                           bConCupon            : Boolean;
                           bAcumula_Factor      : Boolean;
                           sValor_Cupon_Original  : String;  // No toma en cuenta Execepcion Variacion Cambiaria
                           sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                           sOrigen                : String;
                           var fTasaCalculo     : Double;
                           var fTIR_Desarr      : Double;
                           var fValor_Presente  : Double;
                           var fValor_Pte_UM    : Double;
                           var fValor_Par_Corto : Double;
                           var sModulo_Err      : String;
                           var sString_Err      : String;
                           var Result           : Boolean);


var
  dmFunciones_Valorizacion: TdmFunciones_Valorizacion;

implementation
Uses DM_ComunInversiones,
     Valoriza_General,
     Rutinas_Informes,
     Tabla_Mem_Desarr_TFija,
     DMLeer_Valor_Cambio,
     DM_Excepcion_Calculos,
     DM_Comun,
     DM_Identidad_Direccion,
     DateUtil,
     Math;
{$R *.DFM}
//------------------------------------------------------------------------------
procedure Valor_PAR(Reg_Formula_PAR             : TRegFormulaPAR;
                    Reg_Formula_TIR             : TRegFormulaTIR;
                    sTipo_Instrumento           : String;
                    var Array_Mem_Desarr        : TArray_Mem_Desarr;
                    sNemotecnico                : STring;
                    RegDes                      : TReg_Descriptor;
                    fNominales                  : Double;
                    Reg_Fechas                  : TRegistro_Fechas;
                    bConCupon                   : Boolean;
                    sLLamado_Por                : String;
                    sValor_Cupon_Original       : String;
                    sComponentes_Descuento      : String; // Si es blanco (Valor CUpon COmpleto)
                    var fValor_Par              : Double;
                    var fValor_Par_UM           : Double;
                    var acc_impuesto            : Double;
                    var sModulo_Err             : String;
                    var sString_Err             : String;
                    var Result                  : Boolean);
begin
  {Para valorizaciones antes de la emision 02-08-2005 F.I.}
  if (Reg_Fechas.Fecha_Calculo < Reg_Fechas.Fecha_Emision) then
     Reg_Fechas.Fecha_Calculo := Reg_Fechas.Fecha_Emision;

  if sTipo_Instrumento = 'S' then
     Valor_PAR_Con_Descriptor(Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,Array_Mem_Desarr
                             ,sNemotecnico
                             ,RegDes
                             ,fNominales
                             ,Reg_Fechas
                             ,bConCupon
                             ,sValor_Cupon_Original
                             ,sComponentes_Descuento
                             ,fValor_Par
                             ,fValor_Par_UM
                             ,acc_impuesto
                             ,sModulo_Err
                             ,sString_Err
                             ,Result)
  else
     Valor_PAR_Sin_Descriptor(Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,fNominales
                             ,RegDes.Tasa_Emision
                             ,Array_Mem_Desarr
                             ,Reg_Fechas
                             ,RegDes.Tasa_Valor_PAR
                             ,RegDes
                             ,sLLamado_Por
                             ,sValor_Cupon_Original
                             ,sComponentes_Descuento
                             ,fValor_Par_UM
                             ,acc_impuesto
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
end;
//------------------------------------------------------------------------------
procedure Valor_PTE(Reg_Formula_PAR      : TRegFormulaPAR;
                    Reg_Formula_TIR      : TRegFormulaTIR;
                    sTipo_Instrumento    : String;
                    var Array_Mem_Desarr : TArray_Mem_Desarr;
                    sNemotecnico         : String;
                    RegDes               : TReg_Descriptor;
                    fTasaCalculo         : Double;
                    fSpread              : Double;
                    Reg_Fechas           : TRegistro_Fechas;
                    fNominales           : Double;
                    fValor_Par_Base      : Double;
                    fValor_Par_UM        : Double;
                    bConCupon            : Boolean;
                    bAcumula_Factor      : Boolean;
                    sLLamado_Por         : String;
                    sValor_Cupon_Original  : String;
                    sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                    fNominales_Compra    : Double;
                    fValor_Pte_UM_Compra : Double;
                    sOrigen              : String;
                    var fValor_Presente  : Double;
                    var fValor_Pte_UM    : Double;
                    var fValor_Par_Corto : Double;
                    var acc_impuesto     : Double;
                    var sModulo_Err      : String;
                    var sString_Err      : String;
                    var Result           : Boolean);
var
   aux_fecha   :  TDateTime;
begin
  if sTipo_Instrumento = 'S' then
     Valor_PTE_Con_Descriptor(Reg_Formula_PAR
                             ,Reg_Formula_TIR
                             ,sTipo_Instrumento
                             ,Array_Mem_Desarr
                             ,sNemotecnico
                             ,RegDes
                             ,fTasaCalculo
                             ,fSpread
                             ,Reg_Fechas
                             ,fNominales
                             ,fValor_Par_Base
                             ,fValor_PAR_UM
                             ,bConCupon
                             ,bAcumula_Factor
                             ,sLLamado_Por
                             ,sValor_Cupon_Original
                             ,sComponentes_Descuento
                             ,fNominales_Compra
                             ,fValor_Pte_UM_Compra
                             ,sOrigen
                             ,fValor_Presente
                             ,fValor_Pte_UM
                             ,fValor_Par_Corto
                             ,sModulo_Err
                             ,sString_Err
                             ,Result)
  else
    begin
      Valor_PTE_Sin_Descriptor(Reg_Formula_PAR
                              ,Reg_Formula_TIR

                              ,sTipo_Instrumento
                              ,sNemotecnico
                              ,bConCupon
                              ,fSpread // Se habilita con fecha 10-01-2007 F.I. Lo necesitaba la sencibilizaion de La Chilena  0 // ya que en el antiguo no se ocupa

                              ,fNominales
                              ,fTasaCalculo
                              ,Array_Mem_Desarr
                              ,Reg_Fechas
                              ,RegDes.Tasa_Valor_PTE
                              ,RegDes
                              ,sLLamado_Por
                              ,sValor_Cupon_Original
                              ,sComponentes_Descuento
                              ,sOrigen
                              ,fValor_Pte_UM
                              ,acc_impuesto
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);

      if fValor_PAR_UM = 0 then
        fValor_Par_Corto := 0
      else
      begin
/////  Cambio realizado por la BCS lo dejamos duro ya que es algo muy especifico
///    29/09/2021  PM , TL, FI, JD, SS, PA
        aux_fecha := EncodeDate(2021,09,27);
//         PORCPAR
       if Reg_Fechas.Fecha_Calculo < aux_fecha then
         fValor_Par_Corto := redondeo((fValor_Pte_UM / fValor_PAR_UM),4) * 100
       else
         fValor_Par_Corto := redondeo((fValor_Pte_UM / fValor_PAR_UM),6) * 100;                                                        // 100 es por porcentaje
      end;

    end;
end;
//------------------------------------------------------------------------------
procedure Valor_PAR_Con_Descriptor(Reg_Formula_PAR      : TRegFormulaPAR;
                                   Reg_Formula_TIR      : TRegFormulaTIR;
                                   var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   sNemotecnico         : STring;
                                   RegDes               : TReg_Descriptor;
                                   fNominales           : Double;
                                   Reg_Fechas           : TRegistro_Fechas;
                                   bConCupon            : Boolean;
                                   sValor_Cupon_Original       : String;
                                   sComponentes_Descuento      : String; // Si es blanco (Valor CUpon COmpleto)
                                   var fValor_Par       : Double;
                                   var fValor_Par_UM    : Double;
                                   var acc_impuesto     : Double;
                                   var sModulo_Err      : String;
                                   var sString_Err      : String;
                                   var Result           : Boolean);
var
 iCuponVigente   : Integer;
 fSaldo_Insoluto : Double;
begin
  if RegDes.Tasa_Flotante = 'S' then
     begin
       Valor_PAR_Con_Descriptor_TFlot(Reg_Formula_PAR
                                     ,Reg_Formula_TIR
                                     ,Array_Mem_Desarr
                                     ,sNemotecnico
                                     ,RegDes
                                     ,Reg_Fechas
                                     ,bConCupon
                                     ,sValor_Cupon_Original
                                     ,sComponentes_Descuento
                                     ,fValor_Par
                                     ,sModulo_Err
                                     ,sString_Err
                                     ,Result);
     end
  else
     begin
       Valor_PAR_Con_Descriptor_TFija(Reg_Formula_PAR
                                     ,Reg_Formula_TIR
                                     ,Array_Mem_Desarr
                                     ,sNemotecnico
                                     ,RegDes
                                     ,Reg_Fechas
                                     ,bConCupon
                                     ,sValor_Cupon_Original
                                     ,sComponentes_Descuento
                                     ,fValor_Par
                                     ,sModulo_Err
                                     ,sString_Err
                                     ,Result);
        if Result  then
        begin
          if (UpperCase(Reg_Formula_PAR.Ajuste_Calculo_Intereses) = 'S') then
          begin
           {
              Nueva parametrizacion para el cálculo del valor PAR 28-02-2018 F.I.
              Bolsa de Comercio:
              Dado que el V.Par es mayor al S.I. + los intereses del período,
              se cambia este valor por el V.Par del día anterior.
              Si el V.Par del día anterior es mayor al S.I. + los intereses del período,
              entonces se cambia por el V.Par del día anterior y así sucesivamente.
           }
            Cupon_Vigente(Array_Mem_Desarr
                         ,RegDes
                         ,Reg_Fechas.Fecha_Calculo
                         ,True
                         ,iCuponVigente
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);
            if NOT Result then
              exit;

            if iCuponVigente = 1 then
              fSaldo_Insoluto := RegDes.BASE_CONVERSION
            else
              fSaldo_Insoluto := Array_Mem_Desarr[iCuponVigente-1].Saldo_Insoluto;

            if (fSaldo_Insoluto + Array_Mem_Desarr[iCuponVigente].Interes < fValor_Par) then
            begin
                // Manda a calcular el Valor par al día anterior (Se llama a si mismo con un dia menos)
                Reg_Fechas.Fecha_Calculo := Reg_Fechas.Fecha_Calculo - 1;
                Valor_PAR_Con_Descriptor( Reg_Formula_PAR
                                         ,Reg_Formula_TIR
                                         ,Array_Mem_Desarr
                                         ,sNemotecnico
                                         ,RegDes
                                         ,fNominales
                                         ,Reg_Fechas
                                         ,bConCupon
                                         ,sValor_Cupon_Original
                                         ,sComponentes_Descuento
                                         ,fValor_Par
                                         ,fValor_Par_UM
                                         ,acc_impuesto
                                         ,sModulo_Err
                                         ,sString_Err
                                         ,Result       );
            end;
          end;
        end;
     end;
  fValor_Par_UM := (fNominales * fValor_Par) / RegDes.BASE_CONVERSION;
end;
//------------------------------------------------------------------------------
procedure Valor_PAR_Con_Descriptor_TFija(Reg_Formula_PAR        : TRegFormulaPAR;
                                         Reg_Formula_TIR        : TRegFormulaTIR;
                                         var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                         sNemotecnico           : String;
                                         RegDes                 : TReg_descriptor;
                                         Reg_Fechas             : TRegistro_Fechas;
                                         bConCupon              : Boolean;
                                         sValor_Cupon_Original : String;
                                         sComponentes_Descuento : String; 
                                         var fValor_Par         : Double;
                                         var sModulo_Err        : String;
                                         var sString_Err        : String;
                                         var Result             : Boolean);

begin

//  if Con_Cupones_Cortados(Reg_Fechas.Fecha_Calculo
//                         ,RegDes
//                         ,bConCupon
//                         ,Array_Mem_Desarr
//                         ,sModulo_Err
//                         ,sString_Err
//                         ,Result) then
//     Reg_Formula_PAR.Valoriza_Sobre := 'FLUFUT';

  if NOT Result then
     exit;

  if (Reg_Formula_PAR.Valoriza_Sobre = 'FLUFUT') then
      Valor_PAR_Con_Descriptor_TFija_FF(Array_Mem_Desarr
                                       ,sNemotecnico
                                       ,RegDes
                                       ,Reg_Fechas
                                       ,bConCupon
                                       ,sValor_Cupon_Original
                                       ,sComponentes_Descuento
                                       ,fValor_Par
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result)
  else
      Valor_PAR_Con_Descriptor_TFija_SI(Array_Mem_Desarr
                                       ,sNemotecnico
                                       ,RegDes
                                       ,Reg_Fechas
                                       ,bConCupon
                                       ,sValor_Cupon_Original
                                       ,sComponentes_Descuento
                                       ,fValor_Par
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result);

end;
//------------------------------------------------------------------------------
procedure Valor_PAR_Con_Descriptor_TFija_FF(var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                            sNemotecnico           : String;
                                            RegDes                 : TReg_descriptor;
                                            Reg_Fechas             : TRegistro_Fechas;
                                            bConCupon              : Boolean;
                                            sValor_Cupon_Original  : String;
                                            sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                            var fValor_Par         : Double;
                                            var sModulo_Err        : String;
                                            var sString_Err        : String;
                                            var Result             : Boolean);
begin
  // Para Valor PAR Descuento a Tasa Efectiva
  Descuento_Flujos_Futuros(Array_Mem_Desarr
                          ,RegDes
                          ,RegDes.Tasa_Efectiva
                          ,Reg_Fechas.Fecha_Calculo
                          ,RegDes.TASA_VALOR_PAR
                          ,bConCupon
                          ,False
                          ,False
                          ,sValor_Cupon_Original
                          ,sComponentes_Descuento
                          ,fValor_Par
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
end;
//------------------------------------------------------------------------------
procedure Valor_PAR_Con_Descriptor_TFija_SI(var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                            sNemotecnico           : String;
                                            RegDes                 : TReg_descriptor;
                                            Reg_Fechas             : TRegistro_Fechas;
                                            bConCupon              : Boolean;
                                            sValor_Cupon_Original  : String;
                                            sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                            var fValor_Par         : Double;
                                            var sModulo_Err        : String;
                                            var sString_Err        : String;
                                            var Result             : Boolean);
var
  iDiasBaseTasa       : Integer;
  sTipoInteres,
  sPais_Tasa          : String;
  iBaseMensual        : Integer;
  sTipoCalculoDias    : String;
  iVigenciaValor      : Integer;
  iVigenciaMeses      : Integer;

  iDiasDif            : Double;
  iAnosEnteros        : Double;
  iAnosFraccion       : Double;
  iMesesEnteros       : Double;

  fInteres,
  fSaldoInsolutoCupon : Double;
  iCuponVigente       : Integer;
  dFechaInicioDevengamiento : TDateTime;
  sTipo_Tasa,
  sAnualidad_Tasa     : String;
  fPeriodo_Tasa,
  fBase_Porcen_Tasa   : Double;
begin
   Cupon_Vigente(Array_Mem_Desarr,
                 RegDes,
                 Reg_Fechas.Fecha_Calculo,
                 bConCupon,
                 iCuponVigente,
                 sModulo_Err,
                 sString_Err,
                 Result);

   if NOT Result then
      exit;

   // Nuevo calculo para cupones cortados P.M. & F.I. 19-07-2023
   while Array_Mem_Desarr[iCuponVigente].Cupon_Cortado do
   begin
         iCuponVigente := iCuponVigente + 1;
         Reg_Fechas.Fecha_Calculo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
   end;

   // Obtengo Saldo Insoluto a Fecha de Calculo
   if iCuponVigente > 1 then
      // El Saldo Insoluto es el que habia al principio del periodo
      if sValor_Cupon_Original = 'S' then
         fSaldoInsolutoCupon := Array_Mem_Desarr[iCuponVigente -1].Saldo_Insoluto_Original
      else
         fSaldoInsolutoCupon := Array_Mem_Desarr[iCuponVigente -1].Saldo_Insoluto_Original *
                                Array_Mem_Desarr[iCuponVigente].Factor_Varcam
   else
      begin
        // El saldo insoluto es el total
        // Cambiado con fecha 25-05-2006 F.I.
        // Debe ser base_original .... Ejemplo Base 1000 con base convercion 1 !!!!
        if sValor_Cupon_Original = 'S' then
           fSaldoInsolutoCupon := RegDes.Base_Original // RegDes.Base_Conversion
        else
           fSaldoInsolutoCupon := RegDes.Base_Original * //RegDes.Base_Conversion *
                                  Array_Mem_Desarr[iCuponVigente].Factor_Varcam;

{
        for i := 1 to ROUND(RegDes.Nro_Cupones) do
            if sValor_Cupon_Original = 'S' then
               fSaldoInsolutoCupon := fSaldoInsolutoCupon +
                                      Array_Mem_Desarr[i].Amortizacion_Original
            else
               fSaldoInsolutoCupon := fSaldoInsolutoCupon +
                                      Array_Mem_Desarr[i].Amortizacion;
}
      end;


   // En el caso de componente de descuento = 'AMORTIZACION' el valor par se devuelve sin intereses
   // OJO estoç se hizo cuando se detecto el problema con la formula PORCPAR
   if ((sComponentes_Descuento = 'AMORTIZACION') or
       (sComponentes_Descuento = 'AMORTIZ_TIRK')) then
   begin
     fValor_Par   := fSaldoInsolutoCupon;
     exit;
   end;


   // Caso de un titulo que no paga interes por el primer cupon
   if (Array_Mem_Desarr[iCuponVigente].Interes = 0) and
      (iCuponVigente = 1) then
      begin
        fValor_Par   := fSaldoInsolutoCupon;
        exit;
      end;

    Obtener_Tasa_base_Mem(RegDes.Tasa_Valor_PAR
                         ,iDiasBaseTasa
                         ,sTipoInteres
                         ,iBaseMensual
                         ,sTipoCalculoDias
                         ,iVigenciaValor
                         ,iVigenciaMeses
                         ,sPais_Tasa
                         ,sModulo_err
                         ,sString_err
                         ,Result
                       );
   if NOT Result then
      exit;
   // POR SI ES TASA VARIABLE
   iDiasBaseTasa := Array_Mem_Desarr[iCuponVigente].Dias_Base_PAR;

   Obtener_Base_Conversion_Mem(RegDes.Tasa_Valor_PAR
                              ,sTipo_Tasa
                              ,fPeriodo_Tasa
                              ,sAnualidad_Tasa
                              ,fBase_Porcen_Tasa
                              ,sModulo_Err
                              ,sString_Err
                              ,Result
                              );
   if NOT Result then
      exit;

////      10-07-2024 GG & FI
//  F.I. 20-12-2023
//   if iCuponVigente > 1 then
//   begin
//      iCuponAnterior := iCuponVigente - 1;
//      while (Array_Mem_Desarr[iCuponAnterior].Cupon_Cortado) and (iCuponAnterior > 0) do
//             iCuponAnterior := iCuponAnterior - 1;
//      if iCuponAnterior >= 1 then
//         dFechaVctoAnterior := Array_Mem_Desarr[iCuponAnterior].Fecha_Vcto
//      else
//         dFechaVctoAnterior := Reg_Fechas.Fecha_Emision;
//   end
//   else
//      dFechaVctoAnterior := Reg_Fechas.Fecha_Emision;

////      10-07-2024 GG & FI
    Fecha_Inicio_devengamiento  (Reg_Fechas.Fecha_Emision
                                ,Reg_Fechas.Fecha_Calculo
                                ,Array_Mem_Desarr
                                ,iCuponVigente
                                ,dFechaInicioDevengamiento);

   if (dFechaInicioDevengamiento > Reg_Fechas.Fecha_Calculo) then
         fInteres := 1    // No hay interes
   else
   begin
         // Calculo el Nro de dias entre el vcto anterior y fecha de calculo
         Calculo_de_dias(dFechaInicioDevengamiento,
                         Reg_Fechas.Fecha_Calculo,
                         sTipoCalculoDias,
                         sPais_Tasa,
                         iDiasDif,
                         iAnosEnteros,
                         iAnosFraccion,
                         iMesesEnteros);

         if sTipoInteres = 'C' then
            fInteres := Interes_Compuesto(RegDes.Tasa_Efectiva
                                         ,fBase_Porcen_Tasa
                                         ,iDiasDif
                                         ,iDiasBaseTasa)
         else
            fInteres := Interes_Simple(RegDes.Tasa_Efectiva
                                      ,fBase_Porcen_Tasa
                                      ,iDiasDif
                                      ,iDiasBaseTasa);
   end;

   {Calculo del valor par en base CONVERSION}
   fValor_Par   := fSaldoInsolutoCupon * fInteres;
end;
//------------------------------------------------------------------------------
procedure Valor_PAR_Con_Descriptor_TFlot(Reg_Formula_PAR  : TRegFormulaPAR;
                                         Reg_Formula_TIR  : TRegFormulaTIR;
                                         var Array_Mem_Desarr : TArray_Mem_Desarr;
                                         sNemotecnico     : String;
                                         RegDes           : TReg_Descriptor;
                                         Reg_Fechas       : TRegistro_Fechas;
                                         bConCupon        : Boolean;
                                         sValor_Cupon_Original       : String;
                                         sComponentes_Descuento      : String; // Si es blanco (Valor CUpon COmpleto)
                                         var fValor_Par   : Double;
                                         var sModulo_Err  : String;
                                         var sString_Err  : String;
                                         var Result       : Boolean);
begin
  if (Reg_Formula_PAR.Valoriza_Sobre = 'FLUFUT') then
      Valor_PAR_Con_Descriptor_TFija_FF(Array_Mem_Desarr
                                       ,sNemotecnico
                                       ,RegDes
                                       ,Reg_Fechas
                                       ,bConCupon
                                       ,sValor_Cupon_Original
                                       ,sComponentes_Descuento
                                       ,fValor_Par
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result)
  else
      Valor_PAR_Con_Descriptor_TFlot_SI(Reg_Formula_PAR
                                       ,Reg_Formula_TIR
                                       ,Array_Mem_Desarr
                                       ,sNemotecnico
                                       ,RegDes
                                       ,Reg_Fechas
                                       ,bConCupon
                                       ,sValor_Cupon_Original
                                       ,sComponentes_Descuento
                                       ,fValor_Par
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result);

end;
//------------------------------------------------------------------------------
procedure Valor_PAR_Con_Descriptor_TFlot_SI(Reg_Formula_PAR  : TRegFormulaPAR;
                                            Reg_Formula_TIR  : TRegFormulaTIR;
                                            var Array_Mem_Desarr : TArray_Mem_Desarr;
                                            sNemotecnico     : String;
                                            RegDes           : TReg_Descriptor;
                                            Reg_Fechas       : TRegistro_Fechas;
                                            bConCupon        : Boolean;
                                            sValor_Cupon_Original       : String;
                                            sComponentes_Descuento      : String; // Si es blanco (Valor CUpon COmpleto)
                                            var fValor_Par   : Double;
                                            var sModulo_Err  : String;
                                            var sString_Err  : String;
                                            var Result       : Boolean);
var
  iCuponVigente        : Integer;
  dFechaDesde          : TDateTime;
  dFechaHasta          : TDateTime;
  iDiasBase            : Integer;
  sTipoInteres,
  sPais_Tasa           : String;
  iBaseMensual         : Integer;
  sTipoCalculoDias     : String;
  iVigenciaValor       : Integer;
  iVigenciaMeses      : Integer;

  Registro_TasFlot     : TRegistro_TasFlot;
  fValorTasa           : Double;

  Interes              : Double;
  fSaldo_Insoluto       : Double;
  fValor_Interes        : Double;
  sTasa_Base_Utilizada  : String;
  bTasa_Flotante        : Boolean;
  sTipo_Tasa,
  sAnualidad_Tasa     : String;
  fPeriodo_Tasa,
  fBase_Porcen_Tasa   : Double;

  iDiasBaseDescriptor         : Integer;
  sTipoInteresDescriptor      : String;
  iBaseMensualDescriptor      : Integer;
  sTipoCalculoDiasDescriptor  : String;
  iVigenciaValorDescriptor    : Integer;
  iVigenciaMesesDescriptor    : Integer;

  sTipo_Conver_Descriptor        : String;
  fPeriodo_Conver_Descriptor     : Double;
  sAnualidad_Conver_Descriptor   : String;
  fBase_Porcen_Conver_Descriptor : Double;


begin
   // Determino Cupon Vigente
   Cupon_Vigente(Array_Mem_Desarr
                ,RegDes
                ,Reg_Fechas.Fecha_Calculo
                ,bConCupon
                ,iCuponVigente
                ,sModulo_Err
                ,sString_Err
                ,Result);

   if NOT Result then
      exit;

   if iCuponVigente = 1 then
      dFechaDesde := Reg_Fechas.Fecha_Emision
   else
      dFechaDesde := Array_Mem_Desarr[iCuponVigente - 1].Fecha_Vcto;

   dFechaHasta                   := Reg_Fechas.Fecha_Calculo;
   Reg_Fechas.Fecha_Inic_Periodo := dFechaDesde;
   Reg_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;;

   // Se agregan las variables para la tasa base del descriptor tal como lo hace
   // el calculo de los cupones al construir la tasa base: F.I. 12-02-2010
   Obtener_Tasa_base_Mem(RegDes.TASA_VALOR_PAR
                        ,iDiasBaseDescriptor
                        ,sTipoInteresDescriptor
                        ,iBaseMensualDescriptor
                        ,sTipoCalculoDiasDescriptor
                        ,iVigenciaValorDescriptor
                        ,iVigenciaMesesDescriptor
                        ,sPais_Tasa
                        ,sModulo_err
                        ,sString_err
                        ,Result
                        );
   if NOT Result then
      exit;

   // Se agrega con fecha 08-04-2010, Estaba usando la base completa. F.I.   
   // POR SI ES TASA VARIABLE
   iDiasBaseDescriptor := Array_Mem_Desarr[iCuponVigente].Dias_Base_PAR;


   Obtener_Base_Conversion_Mem(RegDes.TASA_VALOR_PAR
                              ,sTipo_Conver_Descriptor
                              ,fPeriodo_Conver_Descriptor
                              ,sAnualidad_Conver_Descriptor
                              ,fBase_Porcen_Conver_Descriptor
                              ,sModulo_Err
                              ,sString_Err
                              ,Result
                              );
   if NOT Result then
      exit;




   // Se cambia a la definicion de la tasa del flujo para aplicar la vigencia
   // esto se realizo para que itere en el calculo del valor PAR

   // 07/06/2002 Se incluye consideracion para definiciones en multiples
   // tasas que no especifican codigo .... (Tasa Fija)

   if (Array_Mem_Desarr[iCuponVigente].Tipo_Tasa.Empty = '') THEN
      if (trim(Array_Mem_Desarr[iCuponVigente].Tipo_Tasa) <> '')   THEN
      sTasa_Base_Utilizada := Array_Mem_Desarr[iCuponVigente].Tipo_Tasa
   else
      sTasa_Base_Utilizada := RegDes.TASA_VALOR_PAR;

   Obtener_Tasa_base_Mem(sTasa_Base_Utilizada
                        ,iDiasBase
                        ,sTipoInteres
                        ,iBaseMensual
                        ,sTipoCalculoDias
                        ,iVigenciaValor
                        ,iVigenciaMeses
                        ,sPais_Tasa
                        ,sModulo_err
                        ,sString_err
                        ,Result
                        );
   if NOT Result then
      exit;

   // POR SI ES TASA VARIABLE
   iDiasBase := Array_Mem_Desarr[iCuponVigente].Dias_Base_PAR;

   Obtener_Base_Conversion_Mem(sTasa_Base_Utilizada
                              ,sTipo_Tasa
                              ,fPeriodo_Tasa
                              ,sAnualidad_Tasa
                              ,fBase_Porcen_Tasa
                              ,sModulo_Err
                              ,sString_Err
                              ,Result
                              );
   if NOT Result then
      exit;

   if (Array_Mem_Desarr[iCuponVigente].Tipo_Tasa <> NULL) AND
      (trim(Array_Mem_Desarr[iCuponVigente].Tipo_Tasa) <> '')   THEN
   begin
      bTasa_Flotante                     := True;
      Registro_TasFlot.Codigo_Tasa       := Array_Mem_Desarr[iCuponVigente].Tipo_Tasa;
      Registro_TasFlot.Tratamiento       := Array_Mem_Desarr[iCuponVigente].Tratamiento;
      Registro_TasFlot.Factor            := Array_Mem_Desarr[iCuponVigente].Factor;
      Registro_TasFlot.Operacion         := Array_Mem_Desarr[iCuponVigente].Operacion;
      Registro_TasFlot.Real_Estimada     := '';
      Registro_TasFlot.Nro_Cupon         := iCuponVigente;
//      Registro_TasFlot.Array_Mem_Desarr  := copy(Array_mem_Desarr);
//      Registro_TasFlot.RegDes            := RegDes;
      Registro_TasFlot.ConCupon          := bConCupon;
   end
   else
   begin
      bTasa_Flotante := False;
      // Lo pongo constante para que tome de siempre un solo periodo
      // y no intente leer tasa cuando esta viene como blanco
      iVigenciaValor := 0;
   end;

  fValorTasa := Array_Mem_Desarr[iCuponVigente].Valor_Tasa;

   Calcula_Interes(dFechaDesde
                  ,dFechaHasta
                  ,RegDes
                  ,Registro_TasFlot
                  ,Reg_Fechas
                  ,Array_Mem_Desarr
                  ,bTasa_Flotante    // Es tasa Flotante
                  ,RegDes.TASA_VALOR_PAR
                  ,fValorTasa
                  ,iDiasBaseDescriptor //iDiasBase
                  ,sTipoInteresDescriptor //sTipoInteres
                  ,iBaseMensualDescriptor //iBaseMensual
                  ,fBase_Porcen_Conver_Descriptor //fBase_Porcen_Tasa
                  ,sTipoCalculoDiasDescriptor //sTipoCalculoDias
                  ,sPais_Tasa
                  ,iVigenciaValor
                  ,False                // bDesagio
                  ,''   //sMetodo_Sin_Tasa_Referencia para que no proyecte
                  ,''
                  ,Registro_TasFlot.Real_Estimada
                  ,Interes
                  ,sModulo_Err
                  ,sString_Err
                  ,Result);

   if NOT Result then
      exit;

   if iCuponVigente = 1 then
   begin
        // El saldo insoluto es el total
        // Cambiado con fecha 25-05-2006 F.I.
        // Debe ser base_original .... Ejemplo Base 1000 con base conversion 1 !!!!
        fSaldo_Insoluto := RegDes.Base_Original; // Base_Conversion
        if sValor_Cupon_Original = 'N' then
           fSaldo_Insoluto := fSaldo_Insoluto *
                              Array_Mem_Desarr[iCuponVigente].Factor_Varcam;
{
        // El saldo insoluto es el total, Se esta usando ahora la sumartoria de las
        // amortizaciones ya que para el caso de flujos afectados por variación cambiaria
        // la incluye en forma natural.
        fSaldo_Insoluto := 0;
        for i := 1 to ROUND(RegDes.Nro_Cupones) do
            fSaldo_Insoluto := fSaldo_Insoluto +
                                   Array_Mem_Desarr[i].Amortizacion;
}
   end
   else
      if (sValor_Cupon_Original = 'S') then
         fSaldo_Insoluto := Array_Mem_Desarr[iCuponVigente-1].Saldo_Insoluto_Original
      else
         fSaldo_Insoluto := Array_Mem_Desarr[iCuponVigente-1].Saldo_Insoluto_Original *
                            Array_Mem_Desarr[iCuponVigente].Factor_Varcam;

// No debe considerar el capitalizado ya que en la carga de la tabla de desarrollo
// Lo incorporo en el Saldo Insoluto
{
   if iCuponVigente = 1 then
      fCapitalizado := 0
   else
      fCapitalizado := Array_Mem_Desarr[iCuponVigente - 1].Capitalizado;

   fValor_Interes := (fSaldo_Insoluto + fCapitalizado) * Interes;
}
   fValor_Interes := fSaldo_Insoluto * Interes;

   fValor_Par := fSaldo_Insoluto + fValor_Interes ;

end;   // Valor_PAR_Con_Descriptor_TFlot_SI
//------------------------------------------------------------------------------
procedure Valor_PTE_Con_Descriptor(Reg_Formula_PAR      : TRegFormulaPAR;
                                   Reg_Formula_TIR      : TRegFormulaTIR;
                                   sTipo_Instrumento    : String;
                                   var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   sNemotecnico         : STring;
                                   RegDes               : TReg_Descriptor;
                                   fTasaCalculo         : Double;
                                   fSpread              : Double;
                                   Reg_Fechas           : TRegistro_Fechas;
                                   fNominales           : Double;
                                   P_Valor_PAR          : Double;
                                   fValor_Par_UM        : Double;
                                   bConCupon            : Boolean;
                                   bAcumula_Factor      : Boolean;
                                   sLLamado_Por         : String;
                                   sValor_Cupon_Original  : String;
                                   sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                   fNominales_Compra    : Double;
                                   fValor_Pte_UM_Compra : Double;
                                   sOrigen              : String;
                                   var fValor_Presente  : Double;
                                   var fValor_Pte_UM    : Double;
                                   var fValor_Par_Corto : Double;
                                   var sModulo_Err      : String;
                                   var sString_Err      : String;
                                   var Result           : Boolean);
var aux_fecha   : TDateTime;
begin
  if RegDes.Tasa_Flotante = 'S' then
     Valor_PTE_Con_Descriptor_TFlot(Reg_Formula_PAR
                                   ,Reg_Formula_TIR
                                   ,sTipo_Instrumento
                                   ,Array_Mem_Desarr
                                   ,sNemotecnico
                                   ,RegDes
                                   ,fTasaCalculo
                                   ,fSpread
                                   ,Reg_Fechas
                                   ,fNominales_Compra
                                   ,P_Valor_PAR
                                   ,fValor_Par_UM
                                   ,bConCupon
                                   ,bAcumula_Factor
                                   ,sLLamado_Por
                                   ,sValor_Cupon_Original
                                   ,sComponentes_Descuento
                                   ,sOrigen
                                   ,fValor_Presente
                                   ,fValor_Pte_UM_Compra
                                   ,fValor_Par_Corto
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result)
  else
     Valor_PTE_Con_Descriptor_TFija(Reg_Formula_PAR
                                   ,Reg_Formula_TIR
                                   ,sTipo_Instrumento
                                   ,Array_Mem_Desarr
                                   ,sNemotecnico
                                   ,RegDes
                                   ,fTasaCalculo
                                   ,fSpread
                                   ,Reg_Fechas
                                   ,fNominales
                                   ,P_Valor_PAR
                                   ,fValor_Par_UM
                                   ,bConCupon
                                   ,bAcumula_Factor
                                   ,sLLamado_Por
                                   ,sValor_Cupon_Original
                                   ,sComponentes_Descuento
                                   ,sOrigen
                                   ,fValor_Presente
                                   ,fValor_Pte_UM
                                   ,fValor_Par_Corto
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);


  fValor_Pte_UM    := (fValor_Presente * fNominales) / RegDes.Base_Conversion;

//  if P_Valor_Par = 0 then
//     fValor_Par_Corto := 0
//  else                            //Valor Pte. NO Multiplicado  por NOMINALES
//     fValor_Par_Corto := Redondeo((fValor_Presente / P_Valor_Par),4) * 100;  // 100 es por porcentaje

    if fValor_PAR_UM = 0 then
        fValor_Par_Corto := 0
      else
      begin
/////  Cambio realizado por la BCS lo dejamos duro ya que es algo muy especifico
///    29/09/2021  PM , TL, FI, JD, SS, PA
        aux_fecha := EncodeDate(2021,09,27);
//         PORCPAR
       if Reg_Fechas.Fecha_Calculo < aux_fecha then
         fValor_Par_Corto := redondeo((fValor_Pte_UM / fValor_PAR_UM),4) * 100
       else
         fValor_Par_Corto := redondeo((fValor_Pte_UM / fValor_PAR_UM),6) * 100;                                                        // 100 es por porcentaje
      end;

  // if (Reg_Formula_TIR.Valoriza_Sobre = 'PORCENPAR') then
   if (Reg_Formula_TIR.Valoriza_Sobre = 'PORCENPAR') and
      ((sComponentes_Descuento <> 'AMORTIZACION') AND
       (sComponentes_Descuento <> 'AMORTIZ_TIRK')) then
     if fValor_Par_Corto = 0 then
        fValor_Pte_UM := 0
     else  // Se corrigio con fecha 17-03-2009 DEBE SER 100 FIJO (por porcentaje)
        fValor_Pte_UM := (fValor_Par_UM * fValor_Par_Corto ) /  100;
end;
//------------------------------------------------------------------------------
procedure Valor_PTE_Con_Descriptor_TFija(Reg_Formula_PAR        : TRegFormulaPAR;
                                         Reg_Formula_TIR        : TRegFormulaTIR;
                                         sTipo_Instrumento      : String;
                                         var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                         sNemotecnico           : String;
                                         RegDes                 : TReg_descriptor;
                                         fTasaCalculo           : Double;
                                         fSpread                : Double;
                                         Reg_Fechas             : TRegistro_Fechas;
                                         fNominales_Compra      : Double;
                                         P_Valor_PAR            : Double;
                                         Valor_Par_UM           : Double;
                                         bConCupon              : Boolean;
                                         bAcumula_Factor        : Boolean;
                                         sLLamado_Por           : String;
                                         sValor_Cupon_Original  : String;
                                         sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                         sOrigen                : String;                                                                              
                                         var fValor_Presente    : Double;
                                         fValor_Pte_UM_Compra   : Double;
                                         var fValor_Par_Corto   : Double;
                                         var sModulo_Err        : String;
                                         var sString_Err        : String;
                                         var Result             : Boolean);

var
  RegParamMargen : TRegParamMargen;

begin
  if (Reg_Formula_TIR.Valoriza_Sobre = 'SALINSOL') then
  begin
     fValor_Presente := 0;
     sModulo_Err     := 'Funciones Valorización';
     sString_Err     := 'Error en definción de Formula (Parametro : SALINSOL NO PERMITIDO PARA INSTRUMENTOS CON DESCRIPTOR)';
     Result          := False;
  end
  else // Descuenta Flujos Futuros
  begin
    if (Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Vencimiento) then
    begin
      fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Valor_Cupon;
      Result := True;
      Exit;
    end;

    Parametros_Margen_Mem( Reg_Formula_TIR.Codigo_Formula
                          ,Reg_Fechas.Fecha_Calculo
                          ,RegParamMargen
                          ,Result
                          );

      if (sLLamado_Por <> 'TIR') AND
         Result                  then
         begin
           Reg_Fechas.Fecha_Parametro := RegParamMargen.Fecha_Desde; //lobo
           Calcula_Tasa_Descuento(RegParamMargen
                                 ,sTipo_Instrumento
                                 ,Array_Mem_Desarr
                                 ,sNemotecnico
                                 ,RegDes
                                 ,Reg_Fechas
                                 ,fNominales_Compra
                                 ,bConCupon
                                 ,fValor_Pte_UM_Compra
                                 ,fTasaCalculo
                                 ,fSpread
                                 ,sOrigen
                                 ,'' 
                                 ,sModulo_Err
                                 ,sString_Err
                                 ,Result);

           if NOT Result then
              exit;

           // Deja en cero la tasa de calculo para asi descontar por la tasa de descuento
           fTasaCalculo := 0;
         end;

      Descuento_Flujos_Futuros(Array_Mem_Desarr
                              ,RegDes
                              ,fTasaCalculo
                              ,Reg_Fechas.Fecha_Calculo
                              ,RegDes.Tasa_Valor_PTE
                              ,bConCupon
                              ,bAcumula_Factor
                              ,False
                              ,sValor_Cupon_Original
                              ,sComponentes_Descuento
                              ,fValor_Presente
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
   end;
end;   // Valor_PTE_Con_Descriptor_TFija
//------------------------------------------------------------------------------
procedure Valor_PTE_Con_Descriptor_TFlot(Reg_Formula_PAR        : TRegFormulaPAR;
                                         Reg_Formula_TIR        : TRegFormulaTIR;
                                         sTipo_Instrumento      : String;
                                         var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                         sNemotecnico           : String;
                                         RegDes                 : TReg_descriptor;
                                         fTasaCalculo           : Double;
                                         fSpread                : Double;
                                         Reg_Fechas             : TRegistro_Fechas;
                                         fNominales_Compra      : Double;
                                         P_Valor_PAR            : Double;
                                         Valor_Par_UM           : Double;
                                         bConCupon              : Boolean;
                                         bAcumula_Factor        : Boolean;
                                         sLLamado_Por           : String;
                                         sValor_Cupon_Original  : String;
                                         sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                         sOrigen                : String;
                                         var fValor_Presente    : Double;
                                         fValor_Pte_UM_Compra   : Double;
                                         var fValor_Par_Corto   : Double;
                                         var sModulo_Err        : String;
                                         var sString_Err        : String;
                                         var Result             : Boolean);
begin
  if (Reg_Formula_TIR.Valoriza_Sobre = 'SALINSOL') then
      {Se utilizo la misma formula de PAR ya que es lo mismo}
      Valor_PAR_Con_Descriptor_TFlot_SI(Reg_Formula_PAR
                                       ,Reg_Formula_TIR
                                       ,Array_Mem_Desarr
                                       ,sNemotecnico
                                       ,RegDes
                                       ,Reg_Fechas
                                       ,bConCupon
                                       ,sValor_Cupon_Original
                                       ,sComponentes_Descuento
                                       ,fValor_Presente
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result)
  else
     Valor_PTE_Con_Descriptor_TFlot_FF(Reg_Formula_PAR
                                      ,Reg_Formula_TIR
                                      ,sTipo_Instrumento
                                      ,Array_Mem_Desarr
                                      ,sNemotecnico
                                      ,RegDes
                                      ,fTasaCalculo
                                      ,fSpread
                                      ,Reg_Fechas
                                      ,fNominales_Compra
                                      ,P_Valor_PAR
                                      ,Valor_Par_UM
                                      ,bConCupon
                                      ,bAcumula_Factor
                                      ,sLLamado_Por
                                      ,sValor_Cupon_Original
                                      ,sComponentes_Descuento
                                      ,sOrigen
                                      ,fValor_Presente
                                      ,fValor_Pte_UM_Compra
                                      ,fValor_Par_Corto
                                      ,sModulo_Err
                                      ,sString_Err
                                      ,Result);
end;
//------------------------------------------------------------------------------
procedure Valor_PTE_Con_Descriptor_TFlot_FF(Reg_Formula_PAR        : TRegFormulaPAR;
                                            Reg_Formula_TIR        : TRegFormulaTIR;
                                            sTipo_Instrumento      : String;
                                            var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                            sNemotecnico           : String;
                                            RegDes                 : TReg_descriptor;
                                            fTasaCalculo           : Double;
                                            fSpread                : Double;
                                            Reg_Fechas             : TRegistro_Fechas;
                                            fNominales_Compra      : Double;
                                            P_Valor_PAR            : Double;
                                            Valor_Par_UM           : Double;
                                            bConCupon              : Boolean;
                                            bAcumula_Factor        : Boolean;
                                            sLLamado_Por           : String;
                                            sValor_Cupon_Original  : String;
                                            sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                            sOrigen                : String;
                                            var fValor_Presente    : Double;
                                            fValor_Pte_UM_Compra   : Double;
                                            var fValor_Par_Corto   : Double;
                                            var sModulo_Err        : String;
                                            var sString_Err        : String;
                                            var Result             : Boolean);
var
  sMetodo_Tasa_Basica : String;
  RegParamMargen      : TRegParamMargen;
  bExiste_Margen      : Boolean;
begin

  if (Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Vencimiento) then
     begin

        // Nuevo para TIR de Capital filigara 16/09/2004
        if ((sComponentes_Descuento = 'AMORTIZACION') or
            (sComponentes_Descuento = 'AMORTIZ_TIRK')) then
        begin
          // No considera Variacion Cambiaria (Sin CorMon)
          if (sValor_Cupon_Original = 'S') then
             // fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Amortizacion_Original
             // Nuevo: Cuando descuenta para TIRK se usan las amortizaciones de capital
             //        correspondientes al capital Residual a la compra           .... F.I. 22-12-2009
             // (Para solucionar el tema de las capitalizaciones
             fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Amortizaciones_Segun_Fecha_de_Compra
          else
             fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Amortizacion;
        end
        else
        begin
          if (sValor_Cupon_Original = 'S') then
             // No considera Variacion Cambiaria (Sin CorMon)
             fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Valor_Cupon_Original
          else
             fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Valor_Cupon;
        end;

{
       if sValor_Cupon_Original = 'S' then
          fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Valor_Cupon_Original
       else
          fValor_Presente := Array_Mem_Desarr[ROUND(RegDes.NRO_CUPONES)].Valor_Cupon;
}
       Result := True;
       Exit;
     end;

  if sLLamado_Por <> 'TIR' then
  begin

   //Cargo Valores de Margen y Tasa Básica para calculo de Tasas de Descuento
   //Si existe Código de Margen Privilegia el Llamado a la Función
   //Calcula_Tasa_Descuento, de lo contrario llama a funciones de
   //Calculo de tasa de descuento según referencia de Tasa Básica

   Parametros_Margen_Mem( Reg_Formula_TIR.Codigo_Formula
                         ,Reg_Fechas.Fecha_Calculo
                         ,RegParamMargen
                         ,bExiste_Margen
                        );
   // OJO
   if bExiste_Margen then // Si encontró Parámetros para Margen
   begin
       Calcula_Tasa_Descuento(RegParamMargen
                             ,sTipo_Instrumento
                             ,Array_Mem_Desarr
                             ,sNemotecnico
                             ,RegDes
                             ,Reg_Fechas
                             ,fNominales_Compra
                             ,bConCupon
                             ,fValor_Pte_UM_Compra
                             ,fTasaCalculo
                             ,fSpread
                             ,sOrigen
                             ,''
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

       if NOT Result then
          exit;

       // Deja en cero la tasa de calculo para asi descontar por la tasa de descuento
       fTasaCalculo := 0;
   end
   else
   begin
       sMetodo_Tasa_Basica := Metodo_Calculo_Tasa_Basica_Mem( Reg_Formula_TIR.Codigo_Formula
                                                             ,Reg_Fechas.Fecha_Calculo
                                                             );

       if (sMetodo_Tasa_Basica = 'PROYSIMPLE') then
       begin
          Calcula_Tasa_Descuento_ProySimple(sMetodo_Tasa_Basica
                                            ,Reg_Formula_PAR
                                            ,Reg_Formula_TIR
                                            ,sTipo_Instrumento
                                            ,Array_Mem_Desarr
                                            ,sNemotecnico
                                            ,RegDes
                                            ,Reg_Fechas
                                            ,fNominales_Compra
                                            ,bConCupon
                                            ,fValor_Pte_UM_Compra
                                            ,sOrigen
                                            ,sModulo_Err
                                            ,sString_Err
                                            ,Result);
          fTasaCalculo := 0;
       end;

       if sMetodo_Tasa_Basica = 'FUTUROIMP' then
       begin
         Calcula_Tasa_Descuento_Futuro_Imp(sMetodo_Tasa_Basica
                                          ,Reg_Formula_PAR
                                          ,Reg_Formula_TIR
                                          ,sTipo_Instrumento
                                          ,Array_Mem_Desarr
                                          ,sNemotecnico
                                          ,RegDes
                                          ,Reg_Fechas
                                          ,fNominales_Compra
                                          ,bConCupon
                                          ,fValor_Pte_UM_Compra
                                          ,sOrigen
                                          ,sModulo_Err
                                          ,sString_Err
                                          ,Result);
          fTasaCalculo := 0;
          bAcumula_Factor := True;
       end;

       if NOT Result then
          exit;
    end;
  end;

  Descuento_Flujos_Futuros(Array_Mem_Desarr
                          ,RegDes
                          ,fTasaCalculo
                          ,Reg_Fechas.Fecha_Calculo
                          ,RegDes.Tasa_Valor_PTE
                          ,bConCupon
                          ,bAcumula_Factor
                          ,False
                          ,sValor_Cupon_Original
                          ,sComponentes_Descuento
                          ,fValor_Presente
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
end;   // Valor_PTE_Con_Descriptor_TFlot
//------------------------------------------------------------------------------
procedure Valor_PAR_Sin_Descriptor(Reg_Formula_PAR   : TRegFormulaPAR;
                                   Reg_Formula_TIR   : TRegFormulaTIR;
                                   fNominales        : Double;
                                   fTasaCalculo      : Double;
                                   var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   Reg_fechas        : TRegistro_Fechas;
                                   sTasa_Base        : String;
                                   RegDes            : TReg_Descriptor;
                                   sLLamado_Por      : String;
                                   sValor_Cupon_Original : String;
                                   sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                   var fValor_Par_UM : Double;
                                   var acc_impuesto : Double ;
                                   var sModulo_Err   : String;
                                   var sString_Err   : String;
                                   var Result        : Boolean);
begin
  if (Reg_Formula_PAR.Cod_Utiliza_Tasa = 'TASFLOT') and
     (Reg_Formula_PAR.Valoriza_Acumulado = 'S')then
  begin
     Valor_Par_Sin_Descriptor_TasaFlotante(Reg_Formula_PAR
                                          ,Reg_Formula_TIR
                                          ,fNominales
                                          ,Reg_Fechas
                                          ,RegDes
                                          ,sLLamado_Por
                                          ,fValor_Par_UM
                                          ,acc_impuesto
                                          ,sModulo_Err
                                          ,sString_Err
                                          ,Result);
     Exit;
  end
  else
    if (Reg_Formula_PAR.Cod_Utiliza_Tasa = 'TASFLOT') then
       fTasaCalculo := Array_mem_Desarr[1].Valor_Tasa;

    if (Reg_Formula_PAR.Valoriza_Sobre = 'SALINSOL') then
       begin
         Valor_Sin_Descriptor_TasaFija_SI(fNominales
                                         ,fTasaCalculo
                                         ,sTasa_Base
                                         ,Array_Mem_Desarr
                                         ,Reg_Fechas.Fecha_Calculo
                                         ,Reg_Fechas.Fecha_Emision
                                         ,RegDes
                                         ,sValor_Cupon_Original
                                         ,sComponentes_Descuento
                                         ,fValor_Par_UM
                                         ,sModulo_Err
                                         ,sString_Err
                                         ,Result);
         fValor_Par_UM := (fNominales * fValor_Par_UM) / RegDes.BASE_CONVERSION;
       end
    else
    begin
       Valor_Sin_Descriptor_TasaFija_FF(fNominales
                                       ,fTasaCalculo
                                       ,sTasa_Base
                                       ,Array_Mem_Desarr
                                       ,Reg_Fechas.Fecha_Calculo
                                       ,RegDes
                                       ,sValor_Cupon_Original
                                       ,sComponentes_Descuento
                                       ,fValor_Par_UM
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result);
       if NOT Result then
          exit;

// F.I. Ahora el el valor cupon de los instrumentos unicos esta en base 100
//        if ((sComponentes_Descuento = 'AMORTIZACION') or
//            (sComponentes_Descuento = 'AMORTIZ_TIRK')) then
          fValor_Par_UM := (fNominales * fValor_Par_UM) / RegDes.BASE_CONVERSION;
    end;


end;
//------------------------------------------------------------------------------
procedure Valor_Par_Sin_Descriptor_TasaFlotante(Reg_Formula_PAR   : TRegFormulaPAR;
                                                Reg_Formula_TIR   : TRegFormulaTIR;
                                                fNominales        : Double;
                                                Reg_Fechas        : TRegistro_Fechas;
                                                RegDes            : TReg_Descriptor;
                                                sLLamado_Por      : String;
                                                var fValor_Par_UM : Double;
                                                var acc_impuesto : Double;
                                                var sModulo_Err   : String;
                                                var sString_Err   : String;
                                                var Result        : Boolean);

begin
  if (Reg_Formula_PAR.Valoriza_Acumulado = 'S') then
      Valorizacion_Acumulada_Sin_Descriptor(RegDes.TASA_VALOR_PAR
                                           ,Reg_Formula_PAR.Codigo_Tasa
                                           ,Reg_Formula_PAR.Tratamiento
                                           ,Reg_Formula_PAR.Spread_Operacion
                                           ,Reg_Formula_PAR.Spread_Factor
                                           ,Reg_Formula_PAR.Spread_Variable
                                           ,Reg_Formula_PAR.Dias_Habiles
                                           ,fNominales
                                           ,Reg_Fechas
                                           ,RegDes
                                           ,sLLamado_Por
                                           ,fValor_Par_UM
                                           ,acc_impuesto
                                           ,sModulo_Err
                                           ,sString_Err
                                           ,Result);


end;
//------------------------------------------------------------------------------
procedure Valor_PTE_Sin_Descriptor(Reg_Formula_PAR   : TRegFormulaPAR;
                                   Reg_Formula_TIR   : TRegFormulaTIR;

                                   sTipo_Instrumento : String;
                                   sNemotecnico      : String;
                                   bConCupon         : Boolean;
                                   fSpread           : Double;

                                   fNominales        : Double;
                                   fTasaCalculo      : Double;
                                   var Array_mem_Desarr : TArray_Mem_Desarr;
                                   Reg_Fechas        : TRegistro_Fechas;
                                   sTasa_Base        : String;
                                   RegDes            : TReg_Descriptor;
                                   sLLamado_Por      : String;
                                   sValor_Cupon_Original : String;
                                   sComponentes_Descuento : String;
                                   sOrigen                : String;
                                   var fValor_Pte_UM : Double;
                                   var acc_impuesto : Double;
                                   var sModulo_Err   : String;
                                   var sString_Err   : String;
                                   var Result        : Boolean);
Var
  RegParamMargen : TRegParamMargen;

begin
    if sValorizacion_Proceso = 'SI' then
       Parametros_Margen_Mem(Reg_Formula_TIR.Codigo_Formula
                            ,Reg_Fechas.Fecha_Calculo
                            ,RegParamMargen
                            ,Result)
    else
       Parametros_Margen(Reg_Formula_TIR.Codigo_Formula
                        ,Reg_Fechas.Fecha_Calculo
                        ,RegParamMargen
                        ,Result);

      if (sLLamado_Por <> 'TIR') AND
         Result                  then
         begin
           Reg_Fechas.Fecha_Parametro := RegParamMargen.Fecha_Desde; //lobo
           Calcula_Tasa_Descuento(RegParamMargen
                                 ,'U'                  // es para instrumentos Unicos
                                 ,Array_mem_Desarr
                                 ,sNemotecnico
                                 ,RegDes
                                 ,Reg_Fechas
                                 ,0                    // No se Ocupa
                                 ,bConCupon
                                 ,0                    // No se Ocupa
                                 ,fTasaCalculo
                                 ,fSpread           // En el antiguo no se ocupa
                                 ,sOrigen
                                 ,''
                                 ,sModulo_Err
                                 ,sString_Err
                                 ,Result);




           if NOT Result then
              exit;

           // Deja en cero la tasa de calculo para asi descontar por la tasa de descuento
           fTasaCalculo := 0;
         end;


  if (Reg_Formula_TIR.Cod_Utiliza_Tasa = 'TASFLOT') and
     (Reg_Formula_TIR.Valoriza_Acumulado = 'S') then
  begin
     Valor_Pte_Sin_Descriptor_TasaFlotante(Reg_Formula_PAR
                                          ,Reg_Formula_TIR
                                          ,fNominales
                                          ,Reg_Fechas
                                          ,RegDes
                                          ,sLLamado_Por
                                          ,fValor_Pte_UM
                                          ,acc_impuesto
                                          ,sModulo_Err
                                          ,sString_Err
                                          ,Result);
     Exit;
  end
  else
  begin
    if (Reg_Formula_TIR.Cod_Utiliza_Tasa = 'TASFLOT') then
        fTasaCalculo := Array_Mem_Desarr[1].Tasa_Flujo;

    if (Reg_Formula_TIR.Valoriza_Sobre = 'SALINSOL') then
       begin
         Valor_Sin_Descriptor_TasaFija_SI(fNominales
                                         ,fTasaCalculo
                                         ,sTasa_Base
                                         ,Array_Mem_Desarr
                                         ,Reg_Fechas.Fecha_Calculo
                                         ,Reg_Fechas.Fecha_Emision
                                         ,RegDes
                                         ,sValor_Cupon_Original
                                         ,sComponentes_Descuento
                                         ,fValor_Pte_UM
                                         ,sModulo_Err
                                         ,sString_Err
                                         ,Result);
         fValor_Pte_UM := (fNominales * fValor_Pte_UM) / RegDes.BASE_CONVERSION;
       end
    else
    begin
        Valor_Sin_Descriptor_TasaFija_FF(fNominales
                                        ,fTasaCalculo
                                        ,sTasa_Base
                                        ,Array_Mem_Desarr
                                        ,Reg_Fechas.Fecha_Calculo
                                        ,RegDes
                                        ,sValor_Cupon_Original
                                        ,sComponentes_Descuento
                                        ,fValor_Pte_UM
                                        ,sModulo_Err
                                        ,sString_Err
                                        ,Result);
                                               if NOT Result then
          exit;
// Cambio 17-05-2007 A partir de esta fecha el Valor del cupon para los unicos se deja enjh base 100
// para generalizarlo. Por esto si o si debe multiplicar despues por los nominales
// F.I.
//        if ((sComponentes_Descuento = 'AMORTIZACION') or
//            (sComponentes_Descuento = 'AMORTIZ_TIRK')) then
          fValor_Pte_UM := (fNominales * fValor_Pte_UM) / RegDes.BASE_CONVERSION;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure Valor_Pte_Sin_Descriptor_TasaFlotante(Reg_Formula_PAR   : TRegFormulaPAR;
                                                Reg_Formula_TIR   : TRegFormulaTIR;
                                                fNominales        : Double;
                                                Reg_Fechas        : TRegistro_Fechas;
                                                RegDes            : TReg_Descriptor;
                                                sLLamado_Por      : String;
                                                var fValor_Pte_UM : Double;
                                                var acc_impuesto     : Double;
                                                var sModulo_Err   : String;
                                                var sString_Err   : String;
                                                var Result        : Boolean);

begin
  if (Reg_Formula_TIR.Valoriza_Acumulado = 'S') then
      Valorizacion_Acumulada_Sin_Descriptor(RegDes.TASA_VALOR_PTE
                                           ,Reg_Formula_TIR.Codigo_Tasa
                                           ,Reg_Formula_PAR.Tratamiento
                                           ,Reg_Formula_TIR.Spread_Operacion
                                           ,Reg_Formula_TIR.Spread_Factor
                                           ,Reg_Formula_TIR.Spread_Variable
                                           ,Reg_Formula_TIR.Dias_Habiles
                                           ,fNominales
                                           ,Reg_Fechas
                                           ,RegDes
                                           ,sLLamado_Por
                                           ,fValor_Pte_UM
                                           ,acc_impuesto
                                           ,sModulo_Err
                                           ,sString_Err
                                           ,Result);


end;  //Valor_Pte_Sin_Descriptor_TasaFlotante
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
procedure Valor_Sin_Descriptor_TasaFija_FF(fNominales        : Double;
                                           fTasaCalculo      : Double;
                                           sTasa_Base        : String;
                                           var Array_Mem_Desarr : TArray_Mem_Desarr;
                                           dFecha_Calculo    : TdateTime;
                                           RegDes            : TReg_Descriptor;
                                           sValor_Cupon_Original : String;
                                           sComponentes_Descuento : String;
                                           var fValor_Pte_UM : Double;
                                           var sModulo_Err   : String;
                                           var sString_Err   : String;
                                           var Result        : Boolean);
begin
      Descuento_Flujos_Futuros(Array_Mem_Desarr
                              ,RegDes
                              ,fTasaCalculo
                              ,dFecha_Calculo
                              ,sTasa_Base
                              ,True      // Siempre con Cupon (D.Q. Pto.Rico 3/10/2000)
                              ,False
                              ,False
                              ,sValor_Cupon_Original
                              ,sComponentes_Descuento
                              ,fValor_Pte_UM
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
end;
//------------------------------------------------------------------------------
// ESTAMOS USANDO LA TASA BASE PAR O PTE SEGUN SEA EL CALCULO
// NO OLVIDAR EN LAS INSTALACIONES ANTIGUAS DEJAR LAS TASAS BASE
// A NIVEL DEL INSTRUMENTO EN BASE A 30 DIAS Y DEPENDIENDO DEL
// TIPO DE INTERES DE LA TASA A APLICAR SIMPLE O COMPUESTA
// PARA EL CASO DE SELIC BRASIL SERIA TIC30
procedure Valorizacion_Acumulada_Sin_Descriptor(sTasa_Base_Spread    : String;
                                                sCodigo_Tasa         : String;
                                                sTratamiento         : String;
                                                sSpread_Operacion    : String;
                                                fSpread_Factor       : Double;
                                                sSpread_Variable     : String;
                                                sDias_Habiles        : String;
                                                fNominales           : Double;
                                                Reg_Fechas           : TRegistro_Fechas;
                                                RegDes               : TReg_Descriptor;
                                                sLLamado_Por         : String;
                                                var fValor_Acumulado : Double;
                                                var acc_impuesto     : Double;
                                                var sModulo_Err      : String;
                                                var sString_Err      : String;
                                                var Result           : Boolean);

var
  dAux_Fecha  : TDateTime;
  dFecha_Tasa : TDateTime;
  sPais_Tasa  : String;
  dValor_Tasa : Double;

  iDiasBaseTasa    : Integer;
  sTipoInteres     : String;
  iBaseMensual     : Integer;
  sTipoCalculoDias : String;
  iVigenciaValor   : Integer;
  iVigenciaMeses   : Integer;

  sTipo_Tasa_Flot          : String;
  fPeriodo_Tasa_Flot       : Double;
  sAnualidad_Tasa_Flot     : String;
  fBase_Porcen_Tasa_Flot   : Double;
  fValor_Tasa_Conver,
  fTasaDia,
  fInteres_Dia         : Double;

  F: TextFile;

  fItem_Dir_Emisor     : Double;
  sCodigo_Geo_Emisor   : String;

  Reg_Montos           : TRegistro_Montos;
  fValor_Impuesto      : Double;
  fDias_Aplica         : Double;
  i                    : Integer;
  sTipo_Ajuste         : String;
  iDecimales_Redondeo  : Integer;
  bTasa_Para_Tir       : Boolean;

  iDiasBaseTasa_Spread     : Integer;
  sTipoInteres_Spread      : String;
  iBaseMensual_Spread      : Integer;
  sTipoCalculoDias_Spread  : String;
  iVigenciaValor_Spread    : Integer;
  iVigenciaMeses_Spread    : Integer;
  sPais_Tasa_Spread        : String;
  fSpread_Convertido       : Double;

  // Base Comun para aplicar operacion
  sTipoInteres_Comun       : String;
  iDiasBaseTasa_Comun      : Integer;

begin
  bTasa_Para_Tir := False;

  if sDebug_Txt = 'VALACUM' then
     begin
       AssignFile(F,'C:\temp\Valacum.txt');
       if FileExists('C:\temp\Valacum.txt') then
          Append(F)
       else
          ReWrite(F);

       WriteLn(F,'Detalle Valoriza Acumulado');
       WriteLn(F,'=====================================================================');
       WriteLn(F,RegDes.Codigo_Emisor+'-'+RegDes.Codigo_Instrumento+'-'+RegDes.Serie);
       WriteLn(F,'=====================================================================');
       WriteLn(F
              ,'Fecha'
              ,','
              ,'Tasa'
              ,','
              ,'Fecha de Tasa'
              ,','
              ,'Valor'
              ,','
              ,'Tipo Interes'
              ,','
              ,'Dias Base'
              ,','
              ,'Spread'
              ,','
              ,'Spread Operacion'
              ,','
              ,'Spread Convertido'
              ,','
              ,'Tasa Convertida'
              ,','
              ,'Tasa Diaria'
              ,','
              ,'Interes'
              ,','
              ,'ISR'
              ,','
              ,'Acumulado'
              ,','
              ,'Nominales'
              ,','
              ,'Dias Aplica'
              ,','
              ,'Fecha Hora'
              ,','
              ,'Valor Impuesto'
              ,','
              ,'Acc Impuesto'
              );
     end;

  if sValorizacion_Proceso = 'SI' then
  begin
    fItem_Dir_Emisor := default_direccion_Mem(RegDes.Codigo_Emisor
                                         ,Reg_Fechas.Fecha_Calculo);

     sCodigo_Geo_Emisor := Codigo_Geo_IdDir_Mem(RegDes.Codigo_Emisor
                                          ,fItem_Dir_Emisor);
  end
  else
  begin
     fItem_Dir_Emisor := default_direccion(RegDes.Codigo_Emisor
                                          ,Reg_Fechas.Fecha_Calculo);

     sCodigo_Geo_Emisor := Codigo_Geo_IdDir(RegDes.Codigo_Emisor
                                           ,fItem_Dir_Emisor);
  end;

{  if sCodigo_Geo_Emisor = '' then  // NO FUNCIONA DESDE EL INTERACTIVO
     begin
       sModulo_Err := 'Valorización Acumulada';
       sString_Err := 'Error en definición de dirección para Emisor '
                     +RegDes.Codigo_Emisor;
       Result := False;
       exit;
     end;}

  fValor_Acumulado := fNominales;

  // Nuevo... Permite capitalizar con tasa fija y no una tasa variable
  if (trim(sCodigo_Tasa) <> '') then
  begin
      if sValorizacion_Proceso = 'SI' then
      begin
         Pais_MonInd_Mem(sCodigo_Tasa
                         ,sPais_Tasa
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);
         if NOT Result then
            exit;

         Obtener_Tasa_base_Mem(sCodigo_Tasa        // Se busca Tasa Base para la Tasa
                              ,iDiasBaseTasa       // Ejemplo: Si tasa = 'SELIC' debe
                              ,sTipoInteres        // existir una Tasa Base = 'SELIC'
                              ,iBaseMensual
                              ,sTipoCalculoDias
                              ,iVigenciaValor
                              ,iVigenciaMeses
                              ,sPais_Tasa
                              ,sModulo_err
                              ,sString_err
                              ,Result);

        if NOT Result then
           exit;

         Obtener_Base_Conversion_Mem(sCodigo_Tasa
                                ,sTipo_Tasa_Flot
                                ,fPeriodo_Tasa_Flot
                                ,sAnualidad_Tasa_Flot
                                ,fBase_Porcen_Tasa_Flot
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);

        if NOT Result then
           exit;

        Leer_MonRedon_Mem(sCodigo_Tasa
                          ,Reg_Fechas.Fecha_Calculo
                          ,sTipo_Ajuste
                          ,iDecimales_Redondeo)
      end
      else
      begin
          Pais_MonInd( sCodigo_Tasa
                       ,sPais_Tasa
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);

          if NOT Result then
             exit;

         Obtener_Tasa_base(sCodigo_Tasa        // Se busca Tasa Base para la Tasa
                          ,iDiasBaseTasa       // Ejemplo: Si tasa = 'SELIC' debe
                          ,sTipoInteres        // existir una Tasa Base = 'SELIC'
                          ,iBaseMensual
                          ,sTipoCalculoDias
                          ,iVigenciaValor
                          ,iVigenciaMeses
                          ,sPais_Tasa
                          ,sModulo_err
                          ,sString_err
                          ,Result);
        if NOT Result then
           exit;

        Obtener_Base_Conversion(sCodigo_Tasa
                                ,sTipo_Tasa_Flot
                                ,fPeriodo_Tasa_Flot
                                ,sAnualidad_Tasa_Flot
                                ,fBase_Porcen_Tasa_Flot
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);
        if NOT Result then
           exit;

        Leer_MonRedon(sCodigo_Tasa
                      ,Reg_Fechas.Fecha_Calculo
                      ,sTipo_Ajuste
                      ,iDecimales_Redondeo);
      end;
  end
  else
  begin
      sPais_Tasa := '';
      Leer_MonRedon(RegDes.UNIDAD_MON
                   ,Reg_Fechas.Fecha_Calculo
                   ,sTipo_Ajuste
                   ,iDecimales_Redondeo);
  end;


  // Obtengo parametros de la tasa indicada en el Spread
  if sValorizacion_Proceso = 'SI' then
  begin
     Obtener_Tasa_base_Mem(sTasa_Base_Spread
                          ,iDiasBaseTasa_Spread
                          ,sTipoInteres_Spread
                          ,iBaseMensual_Spread
                          ,sTipoCalculoDias_Spread
                          ,iVigenciaValor_Spread
                          ,iVigenciaMeses_Spread
                          ,sPais_Tasa_Spread
                          ,sModulo_err
                          ,sString_err
                          ,Result);
  end
  else
  begin
     Obtener_Tasa_base(sTasa_Base_Spread
                      ,iDiasBaseTasa_Spread
                      ,sTipoInteres_Spread
                      ,iBaseMensual_Spread
                      ,sTipoCalculoDias_Spread
                      ,iVigenciaValor_Spread
                      ,iVigenciaMeses_Spread
                      ,sPais_Tasa_Spread
                      ,sModulo_err
                      ,sString_err
                      ,Result);

    if NOT Result then
       exit;
  end;

//  iDiasBaseTasa > iDiasBaseTasa_Spread;

  if (trim(sCodigo_Tasa) = '') then
  begin
       iDiasBaseTasa      :=      iDiasBaseTasa_Spread    ;
       sTipoInteres       :=      sTipoInteres_Spread     ;
       iBaseMensual       :=      iBaseMensual_Spread     ;
       sTipoCalculoDias   :=      sTipoCalculoDias_Spread ;
       iVigenciaValor     :=      iVigenciaValor_Spread   ;
       iVigenciaMeses     :=      iVigenciaMeses_Spread   ;
       sPais_Tasa         :=      sPais_Tasa_Spread       ;
  end;


  //Rescatamos Valores de Tasa Entre Fecha de Emision y Fecha de Calculo
  //Para Cargarlos en Memoria
  dAux_Fecha := Reg_Fechas.Fecha_Emision;
  if (trim(sCodigo_Tasa) <> '') then
  begin
      Carga_Valores_Tasa_Memory( sCodigo_Tasa    //Desface Para buscar valores anteriores
                                ,dAux_Fecha  -7  //Por tratamiento de Fechas
                                ,Reg_Fechas.Fecha_Calculo
                               );
  end;


  With dmFunciones_Valorizacion.Qry_Aux do
  begin
    //Ahora debo Dejar en memoria los arreglos de Feriados
    if sDias_Habiles <> 'N' then  // sI ES "N" no se necesitan dias habiles
    begin
        SQL.Clear;
        SQL.Add('SELECT *'
               +'  FROM QS_SYS_FERIADOS'
               +' WHERE Codigo_Division = '''+sPais_Tasa+''''
               );
        Prepare;
        Open;
        Last;
        First;

        Array_CodigoDivision := VarArrayCreate([0, RecordCount], varOleStr);
        Array_AnoFeriado     := VarArrayCreate([0, RecordCount], varDouble);
        Array_MesFeriado     := VarArrayCreate([0, RecordCount], varDouble);
        Array_DiaFeriado     := VarArrayCreate([0, RecordCount], varDouble);

        i := 0;
        while not eof do
        begin
           Array_CodigoDivision[i] := Fieldbyname('Codigo_Division').asString;
           Array_AnoFeriado[i]     := Fieldbyname('Ano_Feriado').asFloat;
           Array_MesFeriado[i]     := Fieldbyname('Mes_Feriado').asFloat;
           Array_DiaFeriado[i]     := Fieldbyname('Dia_Feriado').asFloat;
           Next;
           Inc(i);
        end;
        Close;
    end;

    if (trim(sCodigo_Tasa) <> '') then
    begin
        //Lleno el Registro de Tratamiento
        SQL.Clear;
        SQL.Add('SELECT Codigo_Tratam'
               +'      ,Cantidad'
               +'      ,Unidad'
               +'      ,Habiles'
               +'      ,Antes_Despues'
               +'      ,Referencia'
               +'      ,Codigo_Pais'
               +'      ,dia'
               +'  FROM QS_SYS_TRATAM'
               +' WHERE Codigo_Tratam = :Codigo_Tratam'
               );
        ParamByName('Codigo_Tratam').AsString := trim(sTratamiento);
        Prepare;
        Open;
        if FieldByName('Codigo_Tratam').IsNull then
        begin
           Close;
           UnPrepare;
           Result := False;
           sString_Err := 'No se encontró definición para código '+sTratamiento;
           sModulo_Err := 'Tratamiento Fechas';
           exit;
        end;
        Reg_Tratam.Codigo_Tratam := sTratamiento;
        Reg_Tratam.Cantidad      := FieldByName('Cantidad').AsFloat;
        Reg_Tratam.Unidad        := FieldByName('Unidad').AsString;
        Reg_Tratam.Habiles       := FieldByName('Habiles').AsString;
        Reg_Tratam.Antes_Despues := FieldByName('Antes_Despues').AsString;
        Reg_Tratam.Referencia    := FieldByName('Referencia').AsString;
        Reg_Tratam.Codigo_Pais   := FieldByName('Codigo_Pais').AsString;
        Reg_Tratam.dia           := FieldByName('dia').AsFloat;
        Close;
    end
    else
      sTratamiento := '';

    //Busco Codigo de Impuesto para Instrumento OJO sólo busca un Còdigo
    SQL.Clear;
    SQL.Add('SELECT Cod_Impuesto');
    SQL.Add('  FROM Qs_Fin_Instrum_Imp');
    SQL.Add(' WHERE Cod_Instrumento = :Cod_Instrumento');
    SQL.Add('   AND Fecha_Desde    <= :Fecha');
    SQL.Add('   AND (Fecha_Hasta >= :Fecha OR Fecha_Hasta IS NULL)');

    ParamByName('Cod_Instrumento').AsString := RegDes.Codigo_Instrumento;
    ParamByName('Fecha').AsDateTime         := Reg_Fechas.Fecha_Calculo;

    Prepare;
    Open;

    if Not FieldByname('Cod_Impuesto').IsNull then
       sCodigo_Impuesto_Instrumento := FieldByName('Cod_Impuesto').AsString
    else
       sCodigo_Impuesto_Instrumento  := '';
    Close;
  end;

  While ((dAux_Fecha < Reg_Fechas.Fecha_Calculo)     and
         (dAux_Fecha < Reg_Fechas.Fecha_Vencimiento)) do
    begin
      dAux_Fecha := dAux_Fecha + 1;
      if (sDias_Habiles = 'S') or
         (sDias_Habiles = 'A') then
          if (DayOfWeek(dAux_Fecha) in [1,7]) or
             (Feriado_Memory(sPais_Tasa,dAux_Fecha)) then
              Continue;

      if (trim(sCodigo_Tasa) <> '') then
      begin
          // Si fue llamado para Calculo de TIR calcula siempre con la misma tasa
          if NOT bTasa_Para_Tir then
             begin
               if (dAux_Fecha >= Reg_Fechas.Fecha_Compra) then
                   bTasa_Para_Tir := (sLlamado_Por = 'TIR');

               Reg_Fechas.Fecha_Inic_Periodo := dAux_Fecha;
               Reg_Fechas.Fecha_Vcto_Periodo := dAux_Fecha;

               Tratamiento_Fecha_Memory(sTratamiento
                                       ,Reg_Fechas
                                       ,dFecha_Tasa
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result);

               if (NOT Result) then
                  exit;

               if (dFecha_Tasa > Reg_Fechas.Fecha_Compra) and (bTasa_Para_Tir) then
                   dFecha_Tasa := Reg_Fechas.Fecha_Compra;

               // No debe leer tasas anteriores a la emision D.Q. 10/03/2003
               if dFecha_Tasa < Reg_Fechas.Fecha_Emision then
                  dValor_Tasa := 0
               else
               begin
                 Busca_Valor( ArrayFechas,
                              ArrayValores,
                              dFecha_Tasa,
                              dValor_Tasa,
                              Result );
                 if (NOT Result) then
                    begin
                      sModulo_Err := 'Valorización Acumulada';
                      sString_Err := 'No se encontró valor para: '+sCodigo_Tasa+#10
                                    +'Con fecha : '+DatetoStr(dFecha_Tasa);
                      exit;
                    end;
               end;
             end; // Tasa para tir
      end;

      // Si es spread variable remplazo el que venia como parametro
      if (sSpread_Variable = 'TAS_SPREAD') then
          begin
            fSpread_Factor    := RegDes.Tasa_Emision;
           // No debe aplicar spread antes de fecha de compra D.Q. 10/03/03
           if dAux_Fecha < Reg_Fechas.Fecha_Compra then
              fSpread_Factor := 0;
          end;

      sTipoInteres_Comun  := sTipoInteres;
      iDiasBaseTasa_Comun := iDiasBaseTasa;
      fSpread_Convertido  := fSpread_Factor;
      fValor_Tasa_Conver  := dValor_Tasa;

      // Si spread es valido convierto a mayor base entre tasa_spread y tasa formula
      if (sSpread_Operacion <> null) AND
         (fSpread_Factor <> 0)       AND
         (sSpread_Operacion <> '%')  then
      begin
        // SI SPREAD NO ES PORCENTAJE ASUMO QUE ES UNA TASA Y DEBO CONVERTIRLO

        if (trim(sCodigo_Tasa) <> '') then
        begin
          if iDiasBaseTasa > iDiasBaseTasa_Spread then
          begin
    //        iDiasBaseTasa_Comun := iDiasBaseTasa;
    //        sTipoInteres_Comun  := sTipoInteres;

            Convierte_Base(iDiasBaseTasa_Spread
                          ,sTipoInteres_Spread
                          ,fSpread_Factor
                          ,iDiasBaseTasa_Comun
                          ,sTipoInteres_Comun
                          ,fSpread_Convertido
                          ,sModulo_Err
                          ,sString_Err
                          ,Result)
          end
          else
          begin
            iDiasBaseTasa_Comun := iDiasBaseTasa_Spread;
            sTipoInteres_Comun  := sTipoInteres_Spread;
            Convierte_Base(iDiasBaseTasa
                          ,sTipoInteres
                          ,dValor_Tasa
                          ,iDiasBaseTasa_Comun
                          ,sTipoInteres_Comun
                          ,fValor_Tasa_Conver
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
          end;

          if NOT Result then
             exit;


          // Solo si el spread es valido lo aplico
          if (sSpread_Operacion <> null) AND (fSpread_Factor <> 0) then
          begin
            aplica_operacion(fValor_Tasa_Conver
                            ,fSpread_Convertido
                            ,sSpread_Operacion
                            ,fBase_Porcen_Tasa_Flot
                            ,sTipo_Ajuste
                            ,iDecimales_Redondeo
                            ,fValor_Tasa_Conver
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
            if NOT Result then
               exit;
          end;
        end
        else   //  (trim(sCodigo_Tasa) <> '') then
          fValor_Tasa_Conver := fSpread_Factor;
      end;


      // LLEVO A TASA DIARIA
      Convierte_Base(iDiasBaseTasa_Comun
                    ,sTipoInteres_Comun
                    ,fValor_Tasa_Conver
                    ,1
                    ,sTipoInteres_Comun         // Incluye spread
                    ,fTasaDia
                    ,sModulo_Err
                    ,sString_Err
                    ,Result);
       if NOT Result then
          exit;

      fInteres_Dia := (fValor_Acumulado * fTasaDia) / 100;

      // Caso que se debe incluir los intereses de los dias
      // Sabados, Domingos o Festivos que no se les a aplicado

      if sDias_Habiles = 'A' then
         fDias_Aplica := dAux_Fecha - dia_habil_anterior(sPais_Tasa,dAux_Fecha)
      else
         fDias_Aplica := 1;

      Reg_Montos.fIntereses := fInteres_Dia;
      Reg_Montos.fCapital   := fValor_Acumulado;

      fValor_Impuesto := 0;
      Impuesto_Instrumento_Memory(RegDes.Codigo_Instrumento
                                 ,sCodigo_Geo_Emisor
                                 ,Reg_Fechas.Fecha_Calculo
                                 ,Reg_Montos
                                 ,fValor_Impuesto
                                 ,sModulo_Err
                                 ,sString_Err
                                 ,Result);

      if NOT Result then
         exit;

      fInteres_Dia    := Redondeo(fInteres_Dia * fDias_Aplica, iDecimales_Redondeo);
      fValor_Impuesto := Redondeo(fValor_Impuesto * fDias_Aplica, iDecimales_Redondeo);

 // Acumula impuestos
      acc_impuesto := acc_impuesto + fValor_Impuesto;
      fValor_Acumulado := Redondeo(fValor_Acumulado + fInteres_Dia - fValor_Impuesto, iDecimales_Redondeo);
      if sDebug_Txt = 'VALACUM' then
         begin
           WriteLn(F
                  ,DateToStr(dAux_Fecha)
                  ,','
                  ,sCodigo_Tasa
                  ,','
                  ,DateToStr(dFecha_Tasa)
                  ,','
                  ,FloatToStr(dValor_Tasa)
                  ,','
                  ,sTipoInteres_Comun
                  ,','
                  ,IntToStr(iDiasBaseTasa_Comun)
                  ,','
                  ,fSpread_Factor
                  ,','
                  ,sSpread_Operacion
                  ,','
                  ,fSpread_Convertido
                  ,','
                  ,fValor_Tasa_Conver
                  ,','
                  ,FloatToStr(fTasaDia)
                  ,','
                  ,FloatToStr(fInteres_Dia)
                  ,','
                  ,FloatToStr(fValor_Impuesto)
                  ,','
                  ,FloatToStr(fValor_Acumulado)
                  ,','
                  ,FloatToStr(fNominales)
                  ,','
                  ,FloatToStr(fDias_Aplica)
                  ,','
                  ,DateTimeToStr(Now)
                  ,','
                  ,FloatToStr(fValor_Impuesto)
                  ,','
                  ,FloatToStr(acc_impuesto)
                  );
         end;
    end;  // end while
    if sDebug_Txt = 'VALACUM' then
       CloseFile(F);

    sString_Avance_Informe := '';

    fValor_Acumulado := Redondeo_Moneda(sCodigo_Tasa
                                        ,Reg_Fechas.Fecha_Calculo
                                        ,fValor_Acumulado
                                        );
end;
//------------------------------------------------------------------------------
procedure Descuento_Flujos_Futuros(var Array_Mem_Desarr  : TArray_Mem_Desarr;
                                   RegDes                : TReg_descriptor;
                                   fTasaCalculo          : Double;
                                   dFecha_Calculo        : TDateTime;
                                   sTasaBase             : String;
                                   bConCupon             : Boolean;
                                   bAcumula_Factor       : Boolean;
                                   bSolo_Cupon_Vigente   : Boolean;  // Para obtener solo el valor del cupon
                                   sValor_Cupon_Original : String;  // No toma en cuenta Execepcion Variacion Cambiaria
                                   sComponentes_Descuento : String; // Si es blanco (Valor Cupon Completo) Si es AMORTIZACION (Valor Amortizacion)
                                   var fValor_Actual     : Double;
                                   var sModulo_Err       : String;
                                   var sString_Err       : String;
                                   var Result            : Boolean);
var
  iDiasBaseTasa    : Integer;
  sTipoInteres,
  sPais_Tasa       : String;
  iBaseMensual     : Integer;
  sTipoCalculoDias : String;
  iVigenciaValor   : Integer;
  iVigenciaMeses   : Integer;

  iDiasDif         : Double;

  iAnosEnteros     : Double;
  iAnosFraccion    : Double;
  iMesesEnteros    : Double;

  fValorCupon         : Double;

  fInteres            : Double;
  iCuponVigente       : Integer;
  aux_Tasa_calculo    : Double;
  aux_fecha           : TDateTime;
  fFactor_Descuento   : Double;
  sTipo_Tasa,
  sAnualidad_Tasa     : String;
  fPeriodo_Tasa,
  fBase_Porcen_Tasa   : Double;
  i                   : Integer;
  bBase_Dias_Variable : Boolean;
  fPeriodos           : Double;

  RegParamRangoCupon : TRegParamRangoCupon;
  dFecha_desde       : TDateTime;
  dFecha_hasta       : TDateTime;
  Reg_Fechas         : TRegistro_Fechas;
  bRangoCupones      : Boolean;
begin
    if sComponentes_Descuento = 'AMORTIZ_TIRK' then
    begin
      if (length(Array_Mem_Amortizacion_Actual_Cost) < Max_Nro_Cupones + 1 )  then
         SetLength(Array_Mem_Amortizacion_Actual_Cost,Max_Nro_Cupones+1);
      For i := 1 TO Max_Nro_Cupones do
      begin
        Array_Mem_Amortizacion_Actual_Cost[i].Nro_Cupon      := 0;
        Array_Mem_Amortizacion_Actual_Cost[i].ValorPteCupon  := 0;
      end;
    end;

    // Si flag bAcumula_Factor viene en True los interes se calculan
    // desde el inicio de vigencia de cada cupon hasta su vencimiento
    // y de factoriza acumulado
    // Caso contrario funciona en forma normal
    fFactor_Descuento := 1;
    Obtener_Tasa_base_mem(sTasaBase
                     ,iDiasBaseTasa
                     ,sTipoInteres
                     ,iBaseMensual
                     ,sTipoCalculoDias
                     ,iVigenciaValor
                     ,iVigenciaMeses
                     ,sPais_Tasa
                     ,sModulo_err
                     ,sString_err
                     ,Result);
    if NOT Result then
       exit;

    Obtener_Base_Conversion_Mem(sTasaBase
                                ,sTipo_Tasa
                                ,fPeriodo_Tasa
                                ,sAnualidad_Tasa
                                ,fBase_Porcen_Tasa
                                ,sModulo_Err
                                ,sString_Err
                                ,Result
                                );
    if NOT Result then
       exit;

    Cupon_Vigente(Array_Mem_Desarr
                 ,RegDes
                 ,dFecha_Calculo
                 ,bConCupon
                 ,iCuponVigente
                 ,sModulo_Err
                 ,sString_Err
                 ,Result);

    if NOT Result then
       exit;

    // ggarcia 10-01-2013 Determina si tiene definicion de rango de cupones
    //                    si es asi, calcula las fechas entre las cuales va a considerar los cupones (segun su vcto).
    Parametros_Rango_Cpones_Mem(RegDes.COD_CALC_TIR_D
                               ,dFecha_Calculo
                               ,RegParamRangoCupon
                               ,bRangoCupones);
    if bRangoCupones then
    begin
       Reg_Fechas.Fecha_Calculo     := dFecha_Calculo;
       Reg_Fechas.Fecha_Vencimiento := Array_Mem_Desarr[ROUND(RegDes.Nro_Cupones)].Fecha_Vcto;

       Tratamiento_Fecha(RegParamRangoCupon.Fecha_Desde
                        ,Reg_Fechas
                        ,dFecha_desde
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);
       if NOT Result then
          exit;

       Tratamiento_Fecha(RegParamRangoCupon.Fecha_Hasta
                        ,Reg_Fechas
                        ,dFecha_Hasta
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);
       if NOT Result then
          exit;
    end;
    // fin ggarcia 10-01-2013

    fValor_Actual := 0;

    // Aux_Fecha almacena el inicio de cada periodo (cupon)
    // para el caso del primer cupon vigente tiene el valor
    // de la fecha de calculo (asi toma el lapso restante
    // del cupon vigente
    Aux_Fecha := dFecha_Calculo;

//    while (iCuponVigente <= ROUND(RegDes.Nro_Cupones)) do
      For iCuponVigente := iCuponVigente to  ROUND(RegDes.Nro_Cupones) do
      begin

        // ggarcia 10-01-2013 Si tiene definicion de rango de cupones, se dejan fuera los cupones que no estan dentro del rango
        if bRangoCupones then
        begin
           if (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto < dFecha_Desde) or
              (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto > dFecha_Hasta) then
              Continue;
        end;
        // fin ggarcia 10-01-2013
        
        // Nuevo para TIR de Capital filigara 16/09/2004
        if (sComponentes_Descuento = 'AMORTIZACION') OR (sComponentes_Descuento = 'AMORTIZ_TIRK') then
        begin
          // No considera Variacion Cambiaria (Sin CorMon)
          if (sValor_Cupon_Original = 'S') then
             // fValorCupon := Array_Mem_Desarr[iCuponVigente].Amortizacion_Original
             // Nuevo: Cuando descuenta para TIRK se usan las amortizaciones de capital
             //        correspondientes al capital Residual a la compra           .... F.I. 22-12-2009
             // (Para solucionar el tema de las capitalizaciones
             fValorCupon := Array_Mem_Desarr[iCuponVigente].Amortizaciones_Segun_Fecha_de_Compra
          else
             fValorCupon := Array_Mem_Desarr[iCuponVigente].Amortizacion;
        end
        else
        begin
          if (sValor_Cupon_Original = 'S') then
             // No considera Variacion Cambiaria (Sin CorMon)
             fValorCupon := Array_Mem_Desarr[iCuponVigente].Valor_Cupon_Original
          else
             fValorCupon := Array_Mem_Desarr[iCuponVigente].Valor_Cupon;
        end;
        Calculo_de_dias(Aux_Fecha
                       ,Array_Mem_Desarr[iCuponVigente].Fecha_Vcto
                       ,sTipoCalculoDias
                       ,sPais_Tasa
                       ,iDiasDif
                       ,iAnosEnteros
                       ,iAnosFraccion
                       ,iMesesEnteros);

        // En Aux_Fecha queda el valor de vcto. del cupon,
        // es decir el inicio del siguiente periodo.
        if bAcumula_Factor then
           Aux_Fecha := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto;
{
        if Array_Mem_Desarr[iCuponVigente].Tasa_de_Descuento <> 0 then
           begin
             if Array_Mem_Desarr[iCuponVigente].Tipo_Tasa <> '' then
             begin
               Obtener_Base_Conversion_Mem(Array_Mem_Desarr[iCuponVigente].Tipo_Tasa
                                          ,sTipo_Tasa_Flot
                                          ,fPeriodo_Tasa_Flot
                                          ,sAnualidad_Tasa_Flot
                                          ,fBase_Porcen_Tasa_Flot
                                          ,sModulo_Err
                                          ,sString_Err
                                          ,Result
                                          );
               if NOT Result then
                  exit;
             end;
             aux_Tasa_Calculo := fTasaCalculo + Array_Mem_Desarr[iCuponVigente].Tasa_de_Descuento;
             // Debe convertir siempre a Efectiva Anual
             if Array_Mem_Desarr[iCuponVigente].Tipo_Tasa <> '' then
                begin
                  conversion_tasas(sTipo_Tasa_Flot
                                  ,fPeriodo_Tasa_Flot
                                  ,sAnualidad_Tasa_Flot
                                  ,fBase_Porcen_Tasa_Flot
                                  ,'E'
                                  ,12
                                  ,''
                                  ,fBase_Porcen_Tasa_Flot
                                  ,aux_Tasa_Calculo
                                  ,sModulo_Err
                                  ,sString_Err
                                  ,Result);

                  if NOT Result then
                     exit;
                end;
           end
        else
           Aux_Tasa_Calculo := fTasaCalculo;
}

        if Array_Mem_Desarr[iCuponVigente].Tasa_de_Descuento <> 0 then
           aux_Tasa_Calculo := fTasaCalculo + Array_Mem_Desarr[iCuponVigente].Tasa_de_Descuento
         else
           Aux_Tasa_Calculo := fTasaCalculo;

        // Tasa Base Variable en el descuento.... Marzo 2017 F.I.
        Existe_Tasa_base_Mem( Trim( sTasaBase)
                                   ,bBase_Dias_Variable);

        if bBase_Dias_Variable then
        begin
           Reg_Fechas.Fecha_Calculo := Array_Mem_Desarr[iCuponVigente].Fecha_Vcto_Anterior;

           Obtener_Tasa_base_Variable( sTasaBase
                                      ,Reg_Fechas
                                      ,RegDes
                                      ,Array_Mem_Desarr
                                      ,sPais_Tasa
                                      ,iDiasBaseTasa
                                      ,fPeriodos
                                      ,sModulo_Err
                                      ,sString_Err
                                      ,Result);
           if NOT Result then
              exit;

           Aux_Tasa_Calculo := Aux_Tasa_Calculo / fPeriodos;

        end;
        ///


        //ggarcia 10-09-2019 caso penta tasa mercado -102
        if (aux_Tasa_calculo < 0) and (Abs(aux_Tasa_calculo) > 99) then
        begin
           sModulo_Err := 'Calculo Descuento de Flujos';
           sString_Err := 'No se puede realizar calculo con una tasa de '+FloatToStr(Aux_Tasa_Calculo);
           Result      := False;
           Exit;
        end;



        if sTipoInteres = 'C' then
           fInteres := Interes_Compuesto(Aux_Tasa_Calculo
                                        ,fBase_Porcen_Tasa
                                        ,iDiasDif
                                        ,iDiasBaseTasa)
        else
           fInteres := Interes_Simple(Aux_Tasa_Calculo
                                     ,fBase_Porcen_Tasa
                                     ,iDiasDif
                                     ,iDiasBaseTasa);

        if bAcumula_Factor then
           fFactor_Descuento := fFactor_Descuento * fInteres
        else
           fFactor_Descuento := fInteres;

        Array_Mem_Desarr[iCuponVigente].Factor_Descuento := (fValorCupon / fFactor_Descuento);
        fValor_Actual := fValor_Actual + (fValorCupon / fFactor_Descuento);
      //  inc(iCuponVigente);

        // Acumula valor pte por cupon...
           if (sComponentes_Descuento = 'AMORTIZ_TIRK') then Begin
              Array_Mem_Amortizacion_Actual_Cost[iCuponVigente].Nro_Cupon      := iCuponVigente;
              Array_Mem_Amortizacion_Actual_Cost[iCuponVigente].ValorPteCupon  := (fValorCupon / fFactor_Descuento);
           end;



        if (iCuponVigente > ROUND(RegDes.Nro_Cupones)) or
           (bSolo_Cupon_Vigente)                       then
           Break;

      end; // end while
      Result := True;
end; // Descuento_Flujos_Futuros
//------------------------------------------------------------------------------
procedure Calcula_Interes(dFecha_Desde     : TDateTime;
                          dFecha_Hasta     : TDateTime;
                          var RegDes       : TReg_Descriptor;
                          var Reg_TasFlot  : TRegistro_TasFlot;
                          var Reg_Fechas   : TRegistro_Fechas;
                          var Array_Mem_Desarr    : TArray_Mem_Desarr;
                          bTasa_Flotante   : Boolean;
                          sCodigo_Tasa     : String;
                          fValorTasa       : Double;
                          iDiasBase        : Integer;
                          sTipoInteres     : String;
                          iBaseMensual     : Integer;
                          fBase_Porcentual : Double;
                          sTipoCalculoDias : String;
                          sPais_Tasa       : String;
                          iVigenciaValor   : Integer;
                          bDesagio         : Boolean;
                          sMetodo_Tasa_Referencia : String;
                          sNombreTablaReferencia  : String;
                          var sTasa_Real_Estimado : String;
                          var Interes      : Double;
                          var Modulo_Err   : String;
                          var String_Err   : String;
                          var Result       : Boolean);

var
  Aux_Interes     : Double;
  DifDias,
  anos_enteros,
  anos_fraccion,
  meses_enteros   : double;
  aux_fin         : TDateTime;
  dInicio_Desagio         : TDateTime;
  dTermino_Desagio        : TDateTime;
  iVigenciaValorDesagio   : Integer;
  fValorTasa_Desagio      : Double;
  bTasas_Cargadas         : Boolean;
begin
  Aux_Interes     := 0;
  Interes         := 0;
  bTasas_Cargadas := False;
  // Si existe una vigencia parta la tasa de calcula la aux_fin
  // para delimitar periodos
  // caso = = se toma todo el periodo
  if iVigenciaValor > 0 then
     aux_fin := dFecha_Desde + iVigenciaValor
     {24/08/2005 La vigencicia siempre es por dias exactos)
     {La funcion suma dias no sirve es antigua)  F.I.
     {Suma_Dias(dFecha_Desde
              ,iVigenciaValor
              ,iBaseMensual
              ,aux_fin)
     }
  else
     aux_fin := dFecha_Hasta;

  if dFecha_Hasta > aux_fin then
     begin
       Calcula_Interes(dFecha_Desde
                      ,aux_fin
                      ,RegDes
                      ,Reg_TasFlot
                      ,Reg_Fechas
                      ,Array_Mem_Desarr
                      ,bTasa_Flotante
                      ,sCodigo_Tasa
                      ,fValorTasa
                      ,iDiasBase
                      ,sTipoInteres
                      ,iBaseMensual
                      ,fBase_Porcentual
                      ,sTipoCalculoDias
                      ,sPais_Tasa
                      ,iVigenciaValor
                      ,bDesagio
                      ,sMetodo_Tasa_Referencia
                      ,sNombreTablaReferencia
                      ,sTasa_Real_Estimado
                      ,aux_interes
                      ,Modulo_Err
                      ,String_Err
                      ,Result);

       if NOT Result then
          exit;

       Interes := Interes + aux_interes;

       if bTasa_Flotante then
       begin
          Reg_Fechas.Fecha_Inic_Periodo := aux_fin;
          Reg_Fechas.Fecha_Vcto_Periodo := dFecha_Hasta;
          Reg_TasFlot.Real_Estimada     := sTasa_Real_Estimado;

          Obtiene_Tasa_Flotante(Reg_TasFlot
                               ,RegDes
                               ,Reg_Fechas
                               ,sMetodo_Tasa_Referencia
                               ,sNombreTablaReferencia
                               ,iDiasBase
                               ,sTipoInteres
                               ,Array_mem_Desarr
                               ,bTasas_Cargadas
                               ,fValorTasa
                               ,Modulo_Err
                               ,String_Err
                               ,Result);
          if NOT Result then
             exit;

          sTasa_Real_Estimado := Reg_TasFlot.Real_Estimada;
       end;

       Calcula_Interes(aux_fin
                      ,dFecha_Hasta
                      ,RegDes
                      ,Reg_TasFlot
                      ,Reg_Fechas
                      ,Array_Mem_Desarr
                      ,bTasa_Flotante
                      ,sCodigo_Tasa
                      ,fValorTasa
                      ,iDiasBase
                      ,sTipoInteres
                      ,iBaseMensual
                      ,fBase_Porcentual
                      ,sTipoCalculoDias
                      ,sPais_Tasa
                      ,iVigenciaValor
                      ,bDesagio
                      ,sMetodo_Tasa_Referencia
                      ,sNombreTablaReferencia
                      ,sTasa_Real_Estimado
                      ,Aux_Interes
                      ,Modulo_Err
                      ,String_Err
                      ,Result);

       if NOT Result then
          exit;

       Interes := Interes + Aux_Interes;
     end // dFecha_Hasta > aux_fin
  else
     begin
       if NOT bDesagio then
          begin
            analiza_desagio(RegDes.Codigo_Emisor
                           ,RegDes.Codigo_Instrumento
                           ,RegDes.Serie
                           ,sCodigo_Tasa
                           ,iDiasBase
                           ,sTipoInteres
                           ,iBaseMensual
                           ,sTipoCalculoDias
                           ,sPais_Tasa
                           ,dFecha_Desde
                           ,dFecha_Hasta
                           ,fValorTasa
                           ,dInicio_Desagio
                           ,dTermino_Desagio
                           ,iVigenciaValorDesagio
                           ,fValorTasa_Desagio
                           ,Modulo_Err
                           ,String_Err
                           ,bDesagio
                           ,Result);

            if NOT Result then
               exit;

            if bDesagio then
               begin
                  if dInicio_Desagio > dFecha_Desde then
                     begin
                       calcula_interes(dFecha_Desde
                                      ,dInicio_Desagio
                                      ,RegDes
                                      ,Reg_TasFlot
                                      ,Reg_Fechas
                                      ,Array_Mem_Desarr
                                      ,bTasa_Flotante
                                      ,sCodigo_Tasa
                                      ,fValorTasa
                                      ,iDiasBase
                                      ,sTipoInteres
                                      ,iBaseMensual
                                      ,fBase_Porcentual
                                      ,sTipoCalculoDias
                                      ,sPais_Tasa
                                      ,iVigenciaValor
                                      ,bDesagio
                                      ,sMetodo_Tasa_Referencia
                                      ,sNombreTablaReferencia
                                      ,sTasa_Real_Estimado
                                      ,aux_interes
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);

                       if NOT Result then
                          exit;

                       Interes := Interes + aux_interes;

                       calcula_interes(dInicio_Desagio
                                      ,dTermino_Desagio
                                      ,RegDes
                                      ,Reg_TasFlot
                                      ,Reg_Fechas
                                      ,Array_Mem_Desarr
                                      ,False
                                      ,sCodigo_Tasa
                                      ,fValorTasa_Desagio
                                      ,iDiasBase
                                      ,sTipoInteres
                                      ,iBaseMensual
                                      ,fBase_Porcentual
                                      ,sTipoCalculoDias
                                      ,sPais_Tasa
                                      ,iVigenciaValorDesagio
                                      ,bDesagio
                                      ,sMetodo_Tasa_Referencia
                                      ,sNombreTablaReferencia
                                      ,sTasa_Real_Estimado
                                      ,aux_interes
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);
                       if NOT Result then
                          exit;

                       Interes := Interes + aux_interes;
                     end
                  else
                     begin
                       calcula_interes(dInicio_Desagio
                                      ,dTermino_Desagio
                                      ,RegDes
                                      ,Reg_TasFlot
                                      ,Reg_Fechas
                                      ,Array_Mem_Desarr
                                      ,False
                                      ,sCodigo_Tasa
                                      ,fValorTasa_Desagio
                                      ,iDiasBase
                                      ,sTipoInteres
                                      ,iBaseMensual
                                      ,fBase_Porcentual
                                      ,sTipoCalculoDias
                                      ,sPais_Tasa
                                      ,iVigenciaValorDesagio
                                      ,bDesagio
                                      ,sMetodo_Tasa_Referencia
                                      ,sNombreTablaReferencia
                                      ,sTasa_Real_Estimado
                                      ,aux_interes
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);

                       if NOT Result then
                          exit;

                       Interes := Interes + aux_interes;
                     end;

                  if dTermino_Desagio < dFecha_hasta then
                     begin
                       calcula_interes(dTermino_Desagio
                                      ,dFecha_hasta
                                      ,RegDes
                                      ,Reg_TasFlot
                                      ,Reg_Fechas
                                      ,Array_Mem_Desarr
                                      ,bTasa_Flotante
                                      ,sCodigo_Tasa
                                      ,fValorTasa
                                      ,iDiasBase
                                      ,sTipoInteres
                                      ,iBaseMensual
                                      ,fBase_Porcentual
                                      ,sTipoCalculoDias
                                      ,sPais_Tasa
                                      ,iVigenciaValor
                                      ,bDesagio
                                      ,sMetodo_Tasa_Referencia
                                      ,sNombreTablaReferencia
                                      ,sTasa_Real_Estimado
                                      ,aux_interes
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);

                       if NOT Result then
                          exit;

                       Interes := Interes + aux_interes;
                     end;  // if dTermino_Desagio < dFecha_hasta then
                  exit;
               end;        // if bDesagio then
          end;             // if NOT bDesagio then

       calculo_de_dias(dFecha_Desde
                      ,dFecha_Hasta
                      ,sTipoCalculoDias
                      ,sPais_Tasa
                      ,DifDias
                      ,anos_enteros,anos_fraccion,meses_enteros);

       if sTipoInteres = 'S' then
          Interes := Interes_Simple( fValorTasa
                                    ,fBase_Porcentual
                                    ,DifDias
                                    ,iDiasBase) - 1
       else
          Interes := Interes_Compuesto(fValorTasa
                                      ,fBase_Porcentual
                                      ,DifDias
                                      ,iDiasBase) - 1

     end;                  // else dFecha_Hasta > aux_fin
end;
//------------------------------------------------------------------------------
{Bono Reconocimiento}
procedure Calculo_TIR_BR(dFecha_Emision,
                         dFecha_Vencimiento,
                         dFecha_Calculo            : TDateTime;
                         fValor_Nominal,
                         fTasa_Informada,
                         fValor_Inversion,
                         fTasa_Capitalizacion      : Double;
                         var fPrecio               : Double;
                         var fValor_PAR            : Double;
                         var fValor_Final          : Double;
                         var fValor_Presente       : Double;
                         var fTasa_Calculo         : Double;
                         var String_Modulo         : String;
                         var String_Error          : String;
                         var Result                : Boolean);
var
//  fInteres       : Double;
//  wdias_totales,
//  wanos_enteros,
//  wanos_fraccion,
//  wmeses_enteros : double;
//  sCodigoIPC     : String;
//  wDelta_IPC     : Double;
//  wValor_IPC_Emision,
//  wValor_IPC_Calculo : Double;
  wdias              : Integer;
  aux_fecha          : TDate;
  fLimite_Inferior   : Double;
  fLimite_Superior   : Double;
begin

  fLimite_Inferior := -29;
  fLimite_Superior :=  50;

  if sValorizacion_Proceso = 'SI' then
     Busca_Rango_Tasa_Mercado_Mem( 'BR'
                                  ,''
                                  ,dFecha_Calculo
                                  ,fLimite_Inferior
                                  ,fLimite_Superior
                                 )
  else
     Busca_Rango_Tasa_Mercado( 'BR'
                              ,''
                              ,dFecha_Calculo
                              ,fLimite_Inferior
                              ,fLimite_Superior
                             );

  if fValor_Inversion > 0 then {Calculo Tasa}
     begin
       wdias := ROUND(dFecha_Vencimiento - dFecha_Calculo);
       fValor_Presente := fValor_Inversion;
       if wdias = 0 then
          fTasa_calculo := 0
       else
         begin
           fTasa_Calculo := (power((fValor_Final / fValor_Presente), // Base
                                       (365 / wdias))                      // Exponente
                                     - 1) * 100;

          if (fTasa_Calculo < fLimite_Inferior) or
             (fTasa_Calculo > fLimite_Superior) then
          begin
            String_Modulo := 'Calculo_TIR_BR';
//            String_Error  := 'Tasa no esta entre rangos validos ('
//                              +FloatToStr(fLimite_Inferior)
//                              +' y '
//                              +FloatToStr(fLimite_Superior)+')' ;
            String_Error := 'No se pudo determinar una tasa para obtener el valor: '+floattostr(fValor_Presente)+#10
                           +'Rango de Tasas utilizado para la busqueda '+#10
                           +'     Limite Tasa Inferior: '+floattostr(fLimite_Inferior)+#10
                           +'     Limite Tasa Superior: '+floattostr(fLimite_Superior);

            Result        := False;
            Exit;
          end;

          if fValor_PAR = 0 then
             fPrecio := 0
          else
          begin
/////  Cambio realizado por la BCS lo dejamos duro ya que es algo muy especifico
///    29/09/2021  PM , TL, FI, JD, SS, PA
           aux_fecha := EncodeDate(2021,09,27);
//         PORCPAR
           if dFecha_Calculo < aux_fecha then
             fPrecio := Redondeo((fValor_Presente / fValor_PAR),4)
           else
             fPrecio := Redondeo((fValor_Presente / fValor_PAR),6);
          end;
        fPrecio := fPrecio * 100;
        end;
     end   {Calculo Tasa}
end;
//------------------------------------------------------------------------------
{Bono Reconocimiento}    // CALCULO ANTIGUO

procedure Calculo_BR(dFecha_Emision,    // Calculo_BR_Antes
                     dFecha_Vencimiento,
                     dFecha_Calculo            : TDateTime;
                     fValor_Nominal,
                     fTasa_Informada,
                     fValor_Inversion,
                     fTasa_Capitalizacion      : Double;
                     var fPrecio               : Double;
                     var fValor_PAR_UM         : Double;
                     var fValor_PAR            : Double;
                     var fValor_Final          : Double;
                     var fValor_Presente       : Double;
                     var fTasa_Calculo         : Double;
                     var String_Modulo         : String;
                     var String_Error          : String;
                     var Result                : Boolean);
var
  fInteres       : Double;
  wdias_totales,
  wanos_enteros,
  wanos_fraccion,
  wmeses_enteros : double;
  sCodigoIPC     : String;
  wDelta_IPC     : Double;
  wValor_IPC_Emision : Double;
  wdia,
  wmes,
  wano,
  aa,
  mm,
  dd         : Word;
  wdias      : Integer;
  dFecha_Aux,
  aux_fecha   : TDatetime;
begin
  sCodigoIPC       := 'IPC';
  fPrecio          := 0;
  fValor_PAR       := 0;
  fValor_Final     := 0;
  fValor_Presente  := fValor_Inversion;
  fTasa_Calculo    := fTasa_Informada;
  String_Modulo    := 'Valorización Bono';
  String_error     := '';
  Result := True;

//  Calculo de Delta_IPC
  decodedate(dFecha_Emision,wano,wmes,wdia);
  wmes := wmes + 1;
  if wmes = 13 then
  begin
     wmes := 1;
     wano := wano + 1;
  end;

  if wdia > ultimo_dia_mes(wmes,wano) then
     wdia := ultimo_dia_mes(wmes,wano);

  dFecha_Emision := encodedate(wano,wmes,wdia);
  if sValorizacion_Proceso = 'SI' then
  begin
     Dec(wmes);
     if wmes = 0 then
     begin
        wmes := 12;
        wano := wano -1;
     end;

     wDia := ultimo_dia_mes( wmes,wano );
//     if wdia = 29 then
//        wdia := 28;

     dFecha_Aux := encodedate( wano, wmes, wdia );
     Busca_Ipc_Mem( dFecha_Aux
                   ,wValor_IPC_Emision
                   ,Result
                  )
  end
  else
  begin
     dFecha_Aux := dFecha_Emision;
     leer_valor_cambio2(sCodigoIPC,
                        sCodigoIPC,
                        'BC',
                        dFecha_Emision,
                        wValor_IPC_Emision,
                        Result);
  end;

  if NOT Result then
  begin
    String_Error := '¡No se encontró valor de '+sCodigoIPC+'!'#10
                   +' vigente al '+datetostr(dFecha_Aux)
                   +' (por Fecha Emisión)';
    Result := False;
    exit;
  end;

  if sValorizacion_Proceso = 'SI' then
  begin
     DecodeDate( dFecha_Calculo, aa, mm,dd );

     mm := mm -1;
     if mm = 0 then
     begin
        mm := 12;
        aa := aa -1;
     end;
     dd := ultimo_dia_mes( mm, aa );
 //    if dd = 29 then
//        dd := 28;

     dFecha_Aux := encodedate(aa,mm,dd );
     Busca_Ipc_Mem( dFecha_Aux
                    ,wValor_IPC_Calculo
                    ,Result
                  )
  end
  else
  begin                   
     //dFecha_Aux := dFecha_Calculo;
     leer_valor_cambio2(sCodigoIPC,
                        sCodigoIPC,
                        'BC',
                        dFecha_Calculo,
                        wValor_IPC_Calculo,
                        Result);
  end;

  if NOT Result then
  begin
    String_Error := '¡No se encontró valor de '+sCodigoIPC+'!'#10
                   +' vigente al '+datetostr(dFecha_Calculo)
                   +' (por Fecha Calculo)';
    Result := False;
    exit;
  end;

  if NOT Result then
     exit;

  wDelta_IPC := wValor_IPC_Calculo / wValor_IPC_Emision;

//
//  C A L C U L O S    P A R A    V A L O R   F I N A L
//
  calculo_de_dias(dFecha_Emision,
                  dFecha_Vencimiento,
                  'EXACTOS',   // Dias Exactos
                  'CL',
                  wdias_totales,
                  wanos_enteros ,
                  wanos_fraccion,
                  wmeses_enteros);

  fInteres := (power((1 + (fTasa_Capitalizacion / 100)),wanos_enteros)) *
              (1 + (fTasa_Capitalizacion /12 /100) * wmeses_enteros);

//  fInteres := (elevacion((1 + (fTasa_Capitalizacion / 100)),wanos_enteros)) *
//              (1 + (fTasa_Capitalizacion /12 /100) * wmeses_enteros);


  fValor_Final := wDelta_IPC * fValor_Nominal * fInteres;

//
//  C A L C U L O S    P A R A    V A L O R   P A R
//
  calculo_de_dias(dFecha_Emision,
                  dFecha_Calculo,
                  'EXACTOS',   // Dias Exactos
                  'CL',
                  wdias_totales,
                  wanos_enteros ,
                  wanos_fraccion,
                  wmeses_enteros);

  fInteres := power((1 + (fTasa_Capitalizacion / 100)), // Base
                             wanos_enteros) *                    // Exponente
                         (1 + (fTasa_Capitalizacion / 12 / 100) * wmeses_enteros);

  fValor_PAR_UM := fValor_Nominal * fInteres;
  fValor_PAR    := wDelta_IPC * fValor_Nominal * fInteres;

  // FI & CJ Cuando la fecha de Calculo es menor a emision asume nominales
  if dFecha_Calculo < dFecha_Emision Then
  begin
     fValor_PAR_UM := fValor_Nominal;
     fValor_PAR    := fValor_Nominal;
  end;


  wdias := ROUND(dFecha_Vencimiento - dFecha_Calculo);
  fTasa_Calculo := fTasa_Informada;
  
  // VALOR PRESENTE
  if power((1 + (fTasa_Informada / 100)),
               (wdias / 365)) = 0 then
     fValor_Presente := 0
  else
     fValor_Presente := fValor_Final /
                        power((1 + (fTasa_Informada / 100)),
                                  (wdias / 365));
  if fValor_PAR = 0 then
     fPrecio := 0
  else
  begin
/////  Cambio realizado por la BCS lo dejamos duro ya que es algo muy especifico
///    29/09/2021  PM , TL, FI, JD, SS, PA
           aux_fecha := EncodeDate(2021,09,27);
//         PORCPAR
           if dFecha_Calculo < aux_fecha then
              fPrecio := Redondeo((fValor_Presente / fValor_PAR),4)
           else
              fPrecio := Redondeo((fValor_Presente / fValor_PAR),6);
  end;

  fValor_Presente :=  fValor_PAR * fPrecio;
  fPrecio := fPrecio * 100;
end;  //Bono Reconocimiento               }

//------------------------------------------------------------------------------
{Bono Reconocimiento}   // CALCULO NUEVO
procedure Calculo_BR_2008(dFecha_Emision,
                     dFecha_Vencimiento,
                     dFecha_Calculo            : TDateTime;
                     fValor_Nominal,
                     fTasa_Informada,
                     fValor_Inversion,
                     fTasa_Capitalizacion      : Double;
                     var fPrecio               : Double;
                     var fValor_PAR_UM         : Double;
                     var fValor_PAR            : Double;
                     var fValor_Final          : Double;
                     var fValor_Presente       : Double;
                     var fTasa_Calculo         : Double;
                     var String_Modulo         : String;
                     var String_Error          : String;
                     var Result                : Boolean);
var
  fInteres       : Double;
  wdias_totales,
  wanos_enteros,
  wanos_fraccion,
  wmeses_enteros : double;
  sCodigoIPC_Factor_1 : String;    // Base 2008
  sCodigoIPC_Factor_2 : String;    // Base 2009
  wDelta_IPC     : Double;
  wValor_IPC_Emision : Double;
  wdia,
  wmes,
  wano       : Word;
  wdias      : Integer;
  dFecha_Aux_Mem_Emi  : TDatetime;
  dFecha_Aux_Mem_Calc : TDatetime;
  dFecha_Vigencia,
  aux_fecha           : TDatetime;

  // fIPC_Final_Factor_1 : Double;   // IPC Dic 2009 Base 2008
  // fIPC_Final_Factor_2 : Double;   // IPC Dic 2009 Base 2009
begin
  //sCodigoIPC       := 'IPC';
  fPrecio          := 0;
  fValor_PAR       := 0;
  fValor_Final     := 0;
  fValor_Presente  := fValor_Inversion;
  fTasa_Calculo    := fTasa_Informada;
  String_Modulo    := 'Valorización Bono';
  String_error     := '';
  dFecha_Vigencia  := StrToDate('31/01/2010');
  Result := True;

  sCodigoIPC_Factor_1 := 'IPC';
  sCodigoIPC_Factor_2 := 'IPC';
  //fIPC_Final_Factor_1 := 1;
  //fIPC_Final_Factor_2 := 1;

  //Calculo de Delta_IPC}
  decodedate(dFecha_Emision,wano,wmes,wdia);
  wmes := wmes + 1;
  if wmes = 13 then
  begin
     wmes := 1;
     wano := wano + 1;
  end;

  if wdia > ultimo_dia_mes(wmes,wano) then
     wdia := ultimo_dia_mes(wmes,wano);

  dFecha_Emision := encodedate(wano,wmes,wdia);

  // esto esta para la lectura de valores en memoria, para que busque el IPC vigente a la emisión
  // Corresponde al del mes anterior a la emisión
  {if sValorizacion_Proceso = 'SI' then
  begin
    Dec(wmes);
    if wmes = 0 then
    begin
       wmes := 12;
       wano := wano -1;
    end;
    wDia := ultimo_dia_mes( wmes,wano );
    dFecha_Aux_Mem_Emi := encodedate( wano, wmes, wdia );

    DecodeDate( dFecha_Calculo, aa, mm,dd );
    mm := mm -1;
    if mm = 0 then
    begin
       mm := 12;
       aa := aa -1;
    end;
    dd := ultimo_dia_mes( mm, aa );
    dFecha_Aux_Mem_Calc := encodedate(aa,mm,dd );
  end
  else
  }
  begin
    dFecha_Aux_Mem_Emi  := dFecha_Emision;
    dFecha_Aux_Mem_Calc := dFecha_Calculo;
  end;


  // Si esta activada la variación del IPC segun el INS (DS N° 322 del 2010)
  if transaccion_implica_Mem('VARIPC','INE') then
  begin
    if (dFecha_Calculo > dFecha_Vigencia) then
    begin
      if (dFecha_Aux_Mem_Emi <= dFecha_Vigencia) then
      begin
         sCodigoIPC_Factor_1 := 'IPC2008';
         sCodigoIPC_Factor_2 := 'IPC';
      end;
    end
    else
    begin
      // Calculos antiguos usa IPC Antiguo
         sCodigoIPC_Factor_1 := 'IPC2008';
         sCodigoIPC_Factor_2 := 'IPC2008';
    end;
  end;

  {if sValorizacion_Proceso = 'SI' then
     Busca_Ipc_Mem( dFecha_Aux_Mem_Emi
                   ,wValor_IPC_Emision
                   ,Result
                  )
  else
     leer_valor_cambio2(sCodigoIPC,
                        sCodigoIPC,
                        'BC',
                        dFecha_Aux_Mem_Emi,
                        wValor_IPC_Emision,
                        Result);
  }

     leer_valor_cambio2(sCodigoIPC_Factor_1,
                        sCodigoIPC_Factor_1,
                        'BC',
                        dFecha_Aux_Mem_Emi,
                        wValor_IPC_Emision,
                        Result);


  if NOT Result then
  begin
    String_Error := '¡No se encontró valor de '+sCodigoIPC_Factor_1+'!'#10
                   +' vigente al '+datetostr(dFecha_Aux_Mem_Emi)
                   +' (por Fecha Emisión)';
    Result := False;
    exit;
  end;

{
  if sValorizacion_Proceso = 'SI' then
  begin
     Busca_Ipc_Mem(  dFecha_Aux_Mem_Calc
                    ,wValor_IPC_Calculo
                    ,Result
                  )
  end
  else
  begin
     dFecha_Aux := dFecha_Calculo;
     leer_valor_cambio2(sCodigoIPC,
                        sCodigoIPC,
                        'BC',
                        dFecha_Aux_Mem_Calc,
                        wValor_IPC_Calculo,
                        Result);
  end;
  }
     leer_valor_cambio2(sCodigoIPC_Factor_2,
                        sCodigoIPC_Factor_2,
                        'BC',
                        dFecha_Aux_Mem_Calc,
                        wValor_IPC_Calculo,
                        Result);

  if NOT Result then
  begin
    String_Error := '¡No se encontró valor de '+sCodigoIPC_Factor_2+'!'#10
                   +' vigente al '+datetostr(dFecha_Aux_Mem_Calc)
                   +' (por Fecha Calculo)';
    Result := False;
    exit;
  end;

  if NOT Result then
     exit;


  if sCodigoIPC_Factor_1 <> sCodigoIPC_Factor_2 then
  begin
     wDelta_IPC := (98.62 / wValor_IPC_Emision) * ( wValor_IPC_Calculo / 99.51);
  end
  else
     wDelta_IPC := wValor_IPC_Calculo / wValor_IPC_Emision;
  //Prueba nueva formula.

  // wDelta_IPC := (98.62 / wValor_IPC_Emision) * ( wValor_IPC_Calculo / 99.51);


//
//  C A L C U L O S    P A R A    V A L O R   F I N A L
//
  calculo_de_dias(dFecha_Emision,
                  dFecha_Vencimiento,
                  'EXACTOS',   // Dias Exactos
                  'CL',
                  wdias_totales,
                  wanos_enteros ,
                  wanos_fraccion,
                  wmeses_enteros);

  fInteres := (power((1 + (fTasa_Capitalizacion / 100)),wanos_enteros)) *
              (1 + (fTasa_Capitalizacion /12 /100) * wmeses_enteros);

{  fInteres := (elevacion((1 + (fTasa_Capitalizacion / 100)),wanos_enteros)) *
              (1 + (fTasa_Capitalizacion /12 /100) * wmeses_enteros);
}

  fValor_Final := wDelta_IPC * fValor_Nominal * fInteres;

//
//  C A L C U L O S    P A R A    V A L O R   P A R
//
  calculo_de_dias(dFecha_Emision,
                  dFecha_Calculo,
                  'EXACTOS',   // Dias Exactos
                  'CL',
                  wdias_totales,
                  wanos_enteros ,
                  wanos_fraccion,
                  wmeses_enteros);

  fInteres := power((1 + (fTasa_Capitalizacion / 100)), // Base
                             wanos_enteros) *                    // Exponente
                         (1 + (fTasa_Capitalizacion / 12 / 100) * wmeses_enteros);

  fValor_PAR_UM := fValor_Nominal * fInteres;
  fValor_PAR    := wDelta_IPC * fValor_Nominal * fInteres;

  // FI & CJ Cuando la fecha de Calculo es menor a emision asume nominales
  if dFecha_Calculo < dFecha_Emision Then
  begin
     fValor_PAR_UM := fValor_Nominal;
     fValor_PAR    := fValor_Nominal;
  end;


  wdias := ROUND(dFecha_Vencimiento - dFecha_Calculo);
  fTasa_Calculo := fTasa_Informada;
  
  // VALOR PRESENTE
  if power((1 + (fTasa_Informada / 100)),
               (wdias / 365)) = 0 then
     fValor_Presente := 0
  else
     fValor_Presente := fValor_Final /
                        power((1 + (fTasa_Informada / 100)),
                                  (wdias / 365));
  if fValor_PAR = 0 then
     fPrecio := 0
  else
  begin
/////  Cambio realizado por la BCS lo dejamos duro ya que es algo muy especifico
///    29/09/2021  PM , TL, FI, JD, SS, PA
       aux_fecha := EncodeDate(2021,09,27);
//         PORCPAR
       if dFecha_Calculo < aux_fecha then
          fPrecio := Redondeo((fValor_Presente / fValor_PAR),4)
       else
          fPrecio := Redondeo((fValor_Presente / fValor_PAR),6);
  end;

  fValor_Presente :=  fValor_PAR * fPrecio;
  fPrecio := fPrecio * 100;
end;  //Bono Reconocimiento
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
procedure  CALCULO_PTE_CORA(emisor,
                            instrumento,
                            serie   : string;
                            FechaCalculo,
                            FechaEmision  : TDateTime;
                            FechaVcto                  : TDateTime;
                            TasaBasePar                : string;
                            TotalCupones               : integer;
                            ValorNominal               : double;
                            TasaEmision                : double;
                            TasaCalculo                : double;
                            Ipc_emision, Ipc_Calculo   : double;
                            BaseConversion             : integer;
                        var Valor_Par_100              : double;
                        var Valor_par_um_cora          : double;
                        var P_valor_par                : double;
                        var Valor_pte_um               : double;
                        var Modulo_err                 : String;
                        var String_err                 : String;
                        var Result                     : Boolean
                        );

var
  InteresCupon, AmortizacionCupon           : double;
  Base,Exponente,Resultado,Dias_wss         : double;
  BaseTasa,BaseMensual                      : integer;
  TipoCalculoDias                           : String;
  iVigenciaValor                            : Integer;
  iVigenciaMeses                            : Integer;  
  anos_enteros,anos_fraccion,meses_enteros  : double;
  Status_ok                                 : Boolean;
  LapsoPago,CuponesVigentesWss              : integer;
  Descuentos_otros_cupones                  : double;
  Reajuste,Interes_Nominal,Interes_Real     : double;
  Valor_10, Valor_20, Valor_30,MF1,MF2,MFR  : double;
  Valor_par_um,VPR_PRG,R_PRG,P_Valor_par_corto : double;
  TipoInteres,
  sPais_Tasa                                : string;
  wMes, wDia, wAno : Word;
  fdias_wss,
  fanos_fraccion,
  fTotal_Cupones,
  fmeses_enteros : Double;
begin
    //Rescato Ipc A fecha de Emisión
    decodedate(FechaEmision,wano,wmes,wdia);
    if sValorizacion_Proceso = 'SI' then
    begin
       Dec(wmes);
       if wmes = 0 then
       begin
          wmes := 12;
          wano := wano -1;
       end;

       wDia := ultimo_dia_mes( wmes,wano );
//       if wdia = 29 then
//          wdia := 28;

       Busca_Ipc_Mem( encodedate( wano, wmes, wdia )
                     ,Ipc_Emision
                     ,Result
                    )
    end
    else
        leer_valor_cambio2('IPC',
                           'IPC',
                           'BC',
                           FechaEmision,
                           Ipc_Emision,
                           Result);

     if NOT Result then
     begin
       String_Err := '¡No se encontró valor de IPC !'#10
                    +' Vigente al '+datetostr(FechaEmision)
                    +' (por Fecha Emisión )';
       Exit;
     end;

    //Rescato Ipc A fecha de Calculo
    decodedate(FechaCalculo,wano,wmes,wdia);
    if sValorizacion_Proceso = 'SI' then
    begin
       Dec(wmes);
       if wmes = 0 then
       begin
          wmes := 12;
          wano := wano -1;
       end;

       wDia := ultimo_dia_mes( wmes,wano );
//       if wdia = 29 then
//          wdia := 28;
       Busca_Ipc_Mem( encodedate( wano, wmes, wdia )
                     ,Ipc_Calculo
                     ,Result
                    )
    end
    else
        leer_valor_cambio2('IPC',
                           'IPC',
                           'BC',
                           FechaCalculo,
                           Ipc_Calculo,
                           Result);

    if NOT Result then
    begin
      String_Err := '¡No se encontró valor de IPC !'#10
                    +' Vigente al '+datetostr(FechaCalculo)
                    +' (por Fecha de Cálculo )';
      Exit;
    end;

   Result := True;
   Modulo_Err := 'CALCULO PTE CORA';
   Obtener_Tasa_base(TasaBasePar,
                     BaseTasa,
                     TipoInteres,
                     BaseMensual,
                     TipoCalculoDias,
                     iVigenciaValor,
                     iVigenciaMeses,
                     sPais_Tasa,
                     Modulo_err,
                     String_err,
                     Result);

   if NOT Result then
      exit;

   // Rescato Total de Cupones
   Calculo_de_dias(FechaEmision,FechaVcto,
                   TipoCalculoDias,
                   'CL',
                   fdias_wss,
                   fTotal_Cupones,
                   fanos_fraccion,
                   fmeses_enteros);
   TotalCupones := Trunc(fTotal_Cupones);                  


   Calculo_de_dias(FechaEmision,FechaCalculo,
                   TipoCalculoDias,
                   'CL',
                   dias_wss,
                   anos_enteros,
                   anos_fraccion,
                   meses_enteros);
   reajuste        := 100 * (ipc_calculo / ipc_emision);

   interes_nominal := 100 * (0.03 / 365) * dias_wss;

   interes_real    := ((ipc_calculo / ipc_emision) - 1) * 100 * 0.5
			  * (0.03 / 365) * dias_wss;

   valor_par_um   := reajuste + interes_nominal + interes_real;
   Valor_Par_100  := Valor_par_um;

   valor_Par_um_cora := Redondeo((valor_par_um * ValorNominal) / BaseConversion,2);


   VPR_PRG := valor_par_um_cora * (ipc_emision / ipc_calculo);


   Calculo_de_dias(FechaCalculo,FechaVcto,
                   TipoCalculoDias,
                   'CL',
                   dias_wss,
                   anos_enteros,
                   anos_fraccion,
                   meses_enteros);

   Base      := 1 + ( TasaEmision / 100);
   exponente := meses_enteros / 12;

   Resultado := power(Base,exponente);
//   Resultado := elevacion(Base,exponente);

   Base      := (ipc_calculo / ipc_emision) * resultado;
   Exponente :=  1 / TotalCupones;
   Resultado := power(Base,exponente);
//   Resultado := elevacion(Base,exponente);

   R_PRG     := (Resultado - 1) * 100;

   Base      :=  1 + (R_PRG / 100);
   Exponente :=  TotalCupones;
   Resultado := power(Base,exponente);
//   Resultado := elevacion(Base,exponente);


   Valor_10  := 100 * Resultado;
   Valor_20  := (100 * 0.03) * TotalCupones;
   Valor_30  := (Resultado - 1) * (( 0.03 * 100 * TotalCupones) / 2);


   MF1       :=  Valor_10  +  Valor_20 + Valor_30;
   MF2       :=  MF1 / 100 * ValorNominal;

   MFR       :=  MF2 / Resultado;

   Base      :=  1  +   (TasaCalculo / 100);
   Exponente :=  1  / BaseTasa;
   Resultado := power(Base,exponente);
//   Resultado := elevacion(Base,exponente);


   Base      :=  Resultado;
   Exponente :=  dias_wss;
   Resultado := power(Base,exponente);
//   Resultado := elevacion(Base,exponente);

   P_Valor_par_corto := Redondeo( MFR /( Resultado * VPR_PRG ), 4);

   Valor_Pte_UM := valor_par_um_cora *  P_Valor_par_corto;

   P_valor_par  := P_Valor_par_corto * 100;
end;
//------------------------------------------------------------------------------
procedure Calcula_Tasa_Descuento_ProySimple(sMetodo_Tasa_Basica  : String;
                                            Reg_Formula_PAR      : TRegFormulaPAR;
                                            Reg_Formula_TIR      : TRegFormulaTIR;
                                            sTipo_Instrumento    : String;
                                            var Array_Mem_Desarr : TArray_Mem_Desarr;
                                            sNemotecnico         : String;
                                            RegDes               : TReg_Descriptor;
                                            Reg_Fechas           : TRegistro_Fechas;
                                            fNominales_Compra    : Double;
                                            bConCupon            : Boolean;
                                            fValor_Pte_UM_Compra : Double;
                                            sOrigen              : String;
                                            var sModulo_Err      : String;
                                            var sString_Err      : String;
                                            var Result           : Boolean);
var
  fTIR_Desarr      : Double;
  iCupon           : Integer;
  iCuponVigente    : Integer;
//  fTasa_Basica     : Double;
//  fTasa_Descuento  : Double;
//  fMargen          : Double;
//  dFecha_Desde     : TDateTime;
//  dFecha_Hasta     : TDateTime;
//  dFecha           : TDateTime;
  Array_Mem_Desarr_Fecha_Calculo : TArray_Mem_Desarr;
  Aux_Fecha_Calculo              : TDateTime;
  fValor_Par_Base                : Double;
  fValor_Par_UM                  : Double;
  sMetodo_Sin_Tasa_Referencia    : String;
  fTasaCalculo                   : Double;
  fValor_Presente                : Double;
  fValor_Par_Corto               : Double;

//  Reg_Val_In             : TRegistro_Valoriza_In;
//  Reg_Val_Out            : TRegistro_Valoriza_Out;

//  bTasas_Basicas_Cargadas : Boolean;


begin
//    bTasas_Basicas_Cargadas := False;
   // El Margen Inicial siempre debe ser calculado a la fecha de compra
   // Por lo tanto cuando se realiza un calculo a una fecha distinta de
   // la fecha de compra debo :
   //    - Cargar tablas de desarrollo a Fecha de Compra
   //    - Calcular Tasas Basicas a fecha de compra
   //    - Obtengo TIR (Margen Inicial)

   // Aux_Fecha_Calculo almacena la fecha de calculo original

   Aux_Fecha_Calculo        := Reg_Fechas.Fecha_Calculo;
   Reg_Fechas.Fecha_Calculo := Reg_Fechas.Fecha_Compra;

   fValor_Par_Base          := 0;
   fValor_Par_UM            := 0;

   // Si la fecha de calculo es igual a la fecha de compra
   // Trapaso la tabla de desarrollo cargada directamente
   // En el otro caso la cargo a fecha de compra
   if Aux_Fecha_Calculo = Reg_Fechas.Fecha_Compra then
      begin
         Array_Mem_Desarr_Fecha_Calculo := copy(Array_Mem_Desarr);
      end
   else
      begin
         // Se obtiene el metodo para obtener la tasa cuando no existe
         // Es por formula PAR ya que esto es definido por el emisor
         // Ojo se vuelve a leer por si a cambiado
         sMetodo_Sin_Tasa_Referencia := Metodo_Sin_Tasa_Referencia(Reg_Formula_PAR.Codigo_Formula
                                                                  ,Reg_Fechas.Fecha_Calculo);

         // Cargo tabla de desarollo a fecha de Compra
         carga_Mem_Desarr(Array_Mem_Desarr_Fecha_Calculo
                         ,sNemotecnico
                         ,RegDes
                         ,Reg_Fechas
                         ,sMetodo_Sin_Tasa_Referencia
                         ,bConCupon
                         ,True     // Verifica Exepciones Cambiarias
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);
         if NOT Result then
            exit;
      end;

   // Calculo de TIR. Es utilizado para obtener el Margen Inicial a la Compra
   // Utiliza el metodo de factores acumulados
   Calculo_TIR_PTE(Reg_Formula_PAR
                  ,Reg_Formula_TIR
                  ,sTipo_Instrumento
                  ,Array_Mem_Desarr_Fecha_Calculo
                  ,sNemotecnico
                  ,RegDes
                  ,Reg_Fechas
                  ,fNominales_Compra
                  ,fValor_Par_Base
                  ,fValor_Par_UM
                  ,bConCupon
                  ,True     // Acumula Factor
                  ,'N'
                  ,''
                  ,sOrigen
                  ,fTasaCalculo
                  ,fTIR_Desarr
                  ,fValor_Presente
                  ,fValor_Pte_UM_Compra
                  ,fValor_Par_Corto
                  ,sModulo_Err
                  ,sString_Err
                  ,Result);

   if NOT Result then
      exit;

   // Devuelvo el valor original a la fecha de calculo
   Reg_Fechas.Fecha_Calculo := Aux_Fecha_Calculo;

   // Si Fecha de Calculo es igual a la fecha de compra
   // la traspaso a tabla de desarrollo original (Recupero Tasas Basicas)
   if Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Compra then
      Array_Mem_Desarr := copy(Array_Mem_Desarr_Fecha_Calculo);

   Cupon_Vigente(Array_Mem_Desarr
                 ,RegDes
                 ,Reg_Fechas.Fecha_Calculo
                 ,bConCupon
                 ,iCuponVigente
                 ,sModulo_Err
                 ,sString_Err
                 ,Result);

  if NOT Result then
     exit;

   iCupon := iCuponVigente;
//   While iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon do  07-2022
    While iCupon <= Max_Nro_Cupones do
    begin
//      fTasa_Descuento := fTasa_Basica + fMargen;
      Array_Mem_Desarr[iCupon].Tasa_de_Descuento  := fTIR_Desarr;
      Inc(iCupon);
    end;
(*
  // Calculo Tasa Basica Para el Margen Inicial
  // Es decir a la Fecha de Compra
    Cupon_Vigente(Array_Mem_Desarr
                 ,RegDes
                 ,Reg_Fechas.Fecha_Compra
                 ,bConCupon
                 ,iCuponVigente
                 ,sModulo_Err
                 ,sString_Err
                 ,Result);

  if NOT Result then
     exit;

  // Ojo es a fecha de compra !!!!!!
  Calcula_Tasa_Basica_Proyeccion_Simple(Array_Mem_Desarr[iCuponVigente].Tipo_Tasa
                                       ,RegDes
                                       ,Reg_Fechas.Fecha_Compra
                                       ,fTasa_Basica
                                       ,sModulo_Err
                                       ,sString_Err
                                       ,Result);


  if NOT Result then
     exit;
  fMargen := fTIR_Desarr - fTasa_Basica;

  Cupon_Vigente(Array_Mem_Desarr
               ,RegDes
               ,Reg_Fechas.Fecha_Calculo
               ,bConCupon
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);


  iCupon := iCuponVigente;
  While iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon do
    begin
      if NOT bTasas_Basicas_Cargadas then
         begin
           if iCupon =  1 then
              Reg_Fechas.Fecha_Inic_Periodo := Reg_Fechas.Fecha_Emision
           else
              Reg_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[iCupon-1].Fecha_Vcto;

           Reg_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[iCupon].Fecha_Vcto;

           Tratamiento_Fecha(Array_Mem_Desarr[iCupon].Tratamiento
                            ,Reg_Fechas
                            ,dFecha
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);

           if NOT Result then
              exit;

            if (Reg_Fechas.Fecha_Calculo < dFecha) or
               (NOT bConCupon and
                (Reg_Fechas.Fecha_Calculo >= Reg_Fechas.Fecha_Inic_Periodo) and
                (Reg_Fechas.Fecha_Calculo <  Reg_Fechas.Fecha_Vcto_Periodo)
                ) or
               (bConCupon and
                (Reg_Fechas.Fecha_Calculo >  Reg_Fechas.Fecha_Inic_Periodo) and
                (Reg_Fechas.Fecha_Calculo <= Reg_Fechas.Fecha_Vcto_Periodo)
                ) then
                  dFecha := Reg_Fechas.Fecha_Calculo;


           if (Array_Mem_Desarr[iCupon].Real_Estimado = '') and
              NOT (Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Emision)then
              begin
                dFecha_Desde := Reg_Fechas.Fecha_Calculo;
                dFecha_Hasta := Array_Mem_Desarr[iCupon].Fecha_Vcto;

                Calcula_Tasa_Basica_Con_Tasa_Refencia_Proy_Simple(dFecha_Desde
                                                                 ,dFecha_Hasta
                                                                 ,Array_Mem_Desarr[iCupon].Tipo_Tasa
                                                                 ,RegDes
                                                                 ,Array_Mem_Desarr[iCupon].Tasa_Flujo
                                                                 ,dFecha
                                                                 ,fTasa_Basica
                                                                 ,sModulo_Err
                                                                 ,sString_Err
                                                                 ,Result);
              end
           else
              begin
                if sMetodo_Tasa_Basica = 'PROYSIMPLE' then
                   Calcula_Tasa_Basica_Proyeccion_Simple(Array_Mem_Desarr[iCupon].Tipo_Tasa
                                                     ,RegDes
                                                     ,dFecha
                                                     ,fTasa_Basica
                                                     ,sModulo_Err
                                                     ,sString_Err
                                                     ,Result);

              end;

           if NOT Result then
              exit;
         end;

      fTasa_Descuento := fTasa_Basica + fMargen;

      Array_Mem_Desarr[iCupon].Tasa_de_Descuento  := fTasa_Descuento;
      Inc(iCupon);
    end;
*)
end;
//------------------------------------------------------------------------------
procedure Calculo_TIR(Reg_Formula_PAR      : TRegFormulaPAR;
                      Reg_Formula_TIR      : TRegFormulaTIR;
                      sTipo_Instrumento    : String;
                      var Array_Mem_Desarr : TArray_Mem_Desarr;
                      sNemotecnico         : String;
                      RegDes               : TReg_Descriptor;
                      Reg_Fechas           : TRegistro_Fechas;
                      fNominales           : Double;
                      fValor_Par_Base      : Double;
                      fValor_Par_UM        : Double;
                      bConCupon            : Boolean;
                      bAcumula_Factor      : Boolean;
                      sValor_Cupon_Original  : String;  // No toma en cuenta Execepcion Variacion Cambiaria
                      sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                      sOrigen                : String;
                      var fTasaCalculo     : Double;
                      var fTIR_Desarr      : Double;
                      var fValor_Presente  : Double;
                      var fValor_Pte_UM    : Double;
                      var fValor_Par_Corto : Double;
                      var sModulo_Err      : String;
                      var sString_Err      : String;
                      var Result           : Boolean);

var
  fLimite_Inferior,
  fLimite_Superior,
  faux_inferior,
  faux_superior,
  fValor_Pte_UM_Buscado,
  Pte_Par_Buscado     : Double;
  iNro_Iteracion      : Integer;
  Pte_Par_Calculado   : Double;
//  Pte_Buscado         : Double;
  sTipo_Tasa_PTE        : String;
  fPeriodo_Tasa_PTE     : Double;
  sAnualidad_Tasa_PTE   : String;
  fBase_Porcen_Tasa_PTE : Double;
  fValor_Final_UM       : Double;
  fSpread               : Double;
  acc_impuesto : double ;
  i                     : Integer;
  Reg_Val_In            : TRegistro_Valoriza_In;
  Reg_Val_Out           : TRegistro_Valoriza_Out;
  fElemento_Buscado     : Double;
  fElemento_Calculado   : Double;
  bDiferencia           : Boolean;
  sMetodo_Sin_Tasa_Referencia : String;
  aux_fecha    :  TDateTime;
begin

  if (Reg_Formula_TIR.Cod_Utiliza_tasa = 'TASA_CERO') then
  // NO CALCULA TIR
  begin
    fTIR_Desarr  := 0;
    fTasaCalculo := 0;
    Result      := True;
    exit;
  end;
  fValor_Pte_UM_Buscado := fValor_Pte_UM;
  if sTipo_Instrumento <> 'S' then // Instrumentos Unicos
     begin
       if RegDes.Tipo_Nominales = 'F' then
          fValor_Final_UM := fNominales
       else
          begin
            if ((sComponentes_Descuento = 'AMORTIZACION') or
                (sComponentes_Descuento = 'AMORTIZ_TIRK')) and
                (Reg_Fechas.Fecha_Emision = Reg_Fechas.Fecha_Calculo) then
            // NO CALCULA TIR
            begin
              fTIR_Desarr  := 0;
              fTasaCalculo := 0;
              Result      := True;
              exit;
            end;
            // Calculo Valor Final
            // Hago este cambio para la valorización acumulada
            //por ejemplo de LFT, Porque Arrastra la tasa de cálculo conocida
            // a la fecha del proceso, por lo tanto toma la fecha de compra
            // no puedo tomar la fecha de calculo porque, aqui se calcula el
            // valor final, es decir, con fecha de vencimiento.

            if Reg_Formula_PAR.Valoriza_Acumulado = 'S' then
               Reg_Fechas.Fecha_Compra := Reg_Fechas.Fecha_Calculo;

            Reg_Val_In.Tipo_Instrumento     := sTipo_Instrumento;
            Reg_Val_In.sEmisor              := RegDes.Codigo_Emisor;
            Reg_Val_In.sInstrumento         := RegDes.Codigo_Instrumento;
            Reg_Val_In.sSerie               := '';
            Reg_Val_In.Nemotecnico          := '';
            Reg_Val_In.sUnidadMonetaria     := RegDes.Unidad_Mon;
            // Ojo para calculo de TIR no me interesa convertir a moneda de origen
            Reg_Val_In.sMoneda_Conversion   := RegDes.Unidad_Mon;
            Reg_Val_In.Descriptor_Cargado   := 'SI';
            Reg_Val_In.Tabla_Desarr_Cargada := 'SI';
            Reg_Val_In.dFechaEmision        := Reg_Fechas.Fecha_Emision;
            Reg_Val_In.dFechaVencimiento    := Reg_Fechas.Fecha_Vencimiento;
            Reg_Val_In.dFechaCalculo        := Reg_Fechas.Fecha_Vencimiento;
            Reg_Val_In.dFechaCalculoOriginal := Reg_Val_In.dFechaCalculo;
            Reg_Val_In.dFechaCompra         := Reg_Fechas.Fecha_Compra;
            Reg_Val_In.Con_Cupon            := True;
            Reg_Val_Out.Array_Mem_Desarr    := copy(Array_Mem_Desarr);
            Reg_Val_Out.RegDes              := RegDes;
            Reg_Val_Out.Nominales           := fNominales;
            Reg_Val_In.Valoriza_Par_Pte     := 'PAR';
            Reg_Val_In.LLamado_por          := 'TIR';
            Reg_Val_In.dFechaPago           := Reg_Fechas.Fecha_Pago;
            Reg_Val_In.dTasaEmision         := Reg_Val_Out.RegDes.Tasa_Emision;


            //Reg_Val_In.sValor_Cupon_Original := sValor_Cupon_Original;

            // Se detecta que en el calculo de TIR para instrumentos unicoa
            // Con variacion cambiaria, se esta produciendo el problema que al calcular
            // el valor final, la variacion cambiaria (en la tabla de desarrollo)
            // se esta calculando con el indice proyectado a la fecha de vencimieto
            // lo que causaba que utilizaba uno mayor a la fecha de calculo donde para la
            // que se esta calculando la TIR
            // Solucion: Cargar antes la tabla de desarrollo a la fecha de calculo real
            // Luego se aplica la variacion cambiaria al valor final si lo indican los parametros
            // F.I. 20-12-2005

            // Calculo el Valor Final sin reajuste
            Reg_Val_In.sValor_Cupon_Original := 'S';
            Reg_Val_In.sComponentes_Descuento := sComponentes_Descuento;

            if (Reg_Formula_PAR.Aplica_Factor_Correccion = 'S') then
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
                             ,Reg_Fechas.Fecha_Calculo // Ojo se carga a la fecha de calculo
                             ,Reg_Val_Out.RegDes.Tasa_Valor_PAR
                             ,Reg_Val_In.Con_Cupon
                             ,Reg_Val_Out.Array_Mem_Desarr
                             ,Reg_Val_Out.RegDes
                             ,Reg_Fechas
                             ,sMetodo_Sin_Tasa_Referencia
                             ,Reg_Formula_PAR
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
              if NOT Result then
                 exit;
            end;

            Valoriza_Registro(Reg_Val_In
                             ,Reg_Val_Out
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
            if NOT Result then
               exit;

            if (Reg_Formula_PAR.Aplica_Factor_Correccion = 'S') and
               (sValor_Cupon_Original <> 'S') then
            begin // Aplico la variacion cambiaria sobre el cupon
              fValor_Final_UM := Reg_Val_Out.Valor_PAR_UM * Reg_Val_Out.Array_Mem_Desarr[1].Factor_Varcam
            end
            else
              fValor_Final_UM := Reg_Val_Out.Valor_PAR_UM;
          end;

       Calculo_TIR_SinCupones(Reg_Fechas
                             ,RegDes
                             ,fValor_Final_UM
                             ,fValor_Pte_UM
                             ,fTasaCalculo
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
       fTIR_Desarr := fTasaCalculo;
       exit;
     end;

  i := 1;
//  While Array_mem_desarr[i].nro_cupon <> 0 do
  While i <= Max_Nro_Cupones do
  begin
     Array_mem_desarr[i].Tasa_de_Descuento := 0;
     Inc(i);
     if i >= Max_Nro_Cupones then
        Break;
  end;




  //Determino Limites
  fLimite_Inferior := -29;
  fLimite_Superior :=  50;

  if sValorizacion_Proceso = 'SI' then
     Busca_Rango_Tasa_Mercado_Mem( RegDes.Codigo_Instrumento
                                  ,sNemotecnico
                                  ,Reg_Fechas.Fecha_Calculo
                                  ,fLimite_Inferior
                                  ,fLimite_Superior
                                 )
  else
     Busca_Rango_Tasa_Mercado( RegDes.Codigo_Instrumento
                              ,sNemotecnico
                              ,Reg_Fechas.Fecha_Calculo
                              ,fLimite_Inferior
                              ,fLimite_Superior
                             );

  faux_inferior     := fLimite_Inferior;
  faux_superior     := fLimite_Superior;

  iNro_Iteracion    := 0;
  fValor_Pte_UM     := 0;
  Pte_Par_Calculado := 0;
//  Pte_Par_Buscado   := Redondeo(fValor_Par_Corto,4);

  /////  Cambio realizado por la BCS lo dejamos duro ya que es algo muy especifico
///    29/09/2021  PM , TL, FI, JD, SS, PA
        aux_fecha := EncodeDate(2021,09,27);
//         PORCPAR
       if Reg_Fechas.Fecha_Calculo < aux_fecha then
         Pte_Par_Buscado := redondeo((fValor_Par_Corto),4)
       else
         Pte_Par_Buscado := redondeo((fValor_Par_Corto),6) ;
  // Lo siguiente se hizo ya que no daba tasas en otros paises Filigara 16/09/2004
  // if (Reg_Formula_TIR.Valoriza_Sobre = 'PORCENPAR') then
   if (Reg_Formula_TIR.Valoriza_Sobre = 'PORCENPAR') and
     ((sComponentes_Descuento <> 'AMORTIZACION') AND
      (sComponentes_Descuento <> 'AMORTIZ_TIRK')) then
  begin
     fElemento_Buscado   := Pte_Par_Buscado;
 //    fElemento_Calculado := Pte_Par_Calculado;
  end
  else
  begin
     fElemento_Buscado   := fValor_Pte_UM_Buscado;
//     fElemento_Calculado := 0;
  end;

  // Se implemento la diferencia para poder comparar como lo hacen
  // en Chile para Porcentaje PAR y en otros casos adminitir diferencia
  // de Valores Presente de 1 sobre 1.000.000.000
  bDiferencia := True;

  // while ((iNro_Iteracion < 100) and (Pte_Par_Buscado <> Pte_Par_Calculado)) do
  while ((iNro_Iteracion < 1000) and (bDiferencia)) do
  begin
    fTasaCalculo := (fLimite_Inferior + fLimite_Superior) /  2;
    fValor_Par_Corto := 0;

    Valor_PTE(Reg_Formula_PAR
             ,Reg_Formula_TIR
             ,sTipo_Instrumento
             ,Array_Mem_Desarr
             ,sNemotecnico
             ,RegDes
             ,fTasaCalculo
             ,fSpread
             ,Reg_Fechas
             ,fNominales
             ,fValor_Par_Base
             ,fValor_Par_UM
             ,bConCupon
             ,bAcumula_Factor
             ,'TIR'
             ,sValor_Cupon_Original
             ,sComponentes_Descuento
             ,fNominales
             ,fValor_Pte_UM
             ,sOrigen
             ,fValor_Presente
             ,fValor_Pte_UM
             ,fValor_Par_Corto
             ,acc_impuesto
             ,sModulo_Err
             ,sString_Err
             ,Result);

    if NOT Result then
       exit;

    // Pte_Par_Calculado := StrToFloat(FormatFloat('#####.00' , Pte_Par_Calculado ));
    Pte_Par_Calculado := Redondeo(fValor_Par_Corto,2);

  //if (Reg_Formula_TIR.Valoriza_Sobre = 'PORCENPAR') then
  if (Reg_Formula_TIR.Valoriza_Sobre = 'PORCENPAR') and
     ((sComponentes_Descuento <> 'AMORTIZACION') AND
      (sComponentes_Descuento <> 'AMORTIZ_TIRK')) then
    begin
       fElemento_Calculado := Pte_Par_Calculado;
       bDiferencia := (Pte_Par_Buscado <> Pte_Par_Calculado);
    end
    else
    begin
       fElemento_Calculado := fValor_Pte_UM;
       // Estoy adnitiendo una diferencia de 1 sobre 1.000.000    Lo reduje a 1 sobre 100000
       bDiferencia := (ABS(fElemento_Buscado - fElemento_Calculado)*100000 > 1);
    end;

    if Reg_Formula_TIR.Valoriza_Sobre = 'SALINSOL' then
    begin
      // if Pte_Par_Buscado > Pte_Par_Calculado then
      if fElemento_Buscado > fElemento_Calculado then
         fLimite_Inferior := fTasaCalculo
      else
         fLimite_Superior := fTasaCalculo;
    end
    else
    begin
      // if Pte_Par_Buscado < Pte_Par_Calculado then
      if fElemento_Buscado < fElemento_Calculado then
         fLimite_Inferior := fTasaCalculo
      else
         fLimite_Superior := fTasaCalculo;
    end;


    inc(iNro_Iteracion);
  end;

  // if (Pte_Par_Buscado <> Pte_Par_Calculado) then
  if (bDiferencia) then
     begin
       sModulo_Err := 'Busqueda Tasa Interna de Retorno';
       sString_Err := 'No se pudo determinar una tasa para obtener el valor: '+floattostr(fValor_Pte_UM_Buscado)+#10
                     +'Rango de Tasas utilizado para la busqueda '+#10
                     +'     Limite Tasa Inferior: '+floattostr(faux_inferior)+#10
                     +'     Limite Tasa Superior: '+floattostr(faux_superior);
//       sModulo_Err := 'Tasa Interna de Retorno';
//       sString_Err := 'No se pudo determinar Tasa'+#10
//                     +'Iteraciones: '
//                     +IntToStr(iNro_Iteracion)+#10
//                     +'Buscado: '
//                     +floattostr(fValor_Pte_UM_Buscado)+' ('+floattostr(Pte_Par_Buscado)+')'+#10
//                     +'Calculado: '
//                     +floattostr(fValor_Pte_UM)+' ('+floattostr(Pte_Par_Calculado)+')';
       Result := False;
     end
  else
     begin
       fTIR_Desarr := fTasaCalculo;

       if sValorizacion_Proceso = 'SI' then
          Obtener_Base_Conversion_Mem(RegDes.Tasa_Valor_PTE
                                     ,sTipo_Tasa_PTE
                                     ,fPeriodo_Tasa_PTE
                                     ,sAnualidad_Tasa_PTE
                                     ,fBase_Porcen_Tasa_PTE
                                     ,sModulo_Err
                                     ,sString_Err
                                     ,Result)
       else
          Obtener_Base_Conversion(RegDes.Tasa_Valor_PTE
                                 ,sTipo_Tasa_PTE
                                 ,fPeriodo_Tasa_PTE
                                 ,sAnualidad_Tasa_PTE
                                 ,fBase_Porcen_Tasa_PTE
                                 ,sModulo_Err
                                 ,sString_Err
                                 ,Result);
       if NOT Result then
          exit;

       conversion_tasas('E'
                       ,fPeriodo_Tasa_PTE
                       ,''
                       ,fBase_Porcen_Tasa_PTE
                       ,sTipo_Tasa_PTE
                       ,fPeriodo_Tasa_PTE
                       ,sAnualidad_Tasa_PTE
                       ,fBase_Porcen_Tasa_PTE
                       ,fTIR_Desarr
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);
     end;
end;
//------------------------------------------------------------------------------
procedure Calculo_TIR_SinCupones(Reg_Fechas       : TRegistro_Fechas;
                                 RegDes           : TReg_Descriptor;
                                 fValor_Final     : Double;
                                 fValor_Pte_UM    : Double;
                                 var fTasaCalculo : Double;
                                 var sModulo_Err  : String;
                                 var sString_Err  : String;
                                 var Result       : Boolean);
var
   iDiasBaseTasa     : Integer;
   sTipoInteres,
   sPais_Tasa        : String;
   iBaseMensual      : Integer;
   sTipoCalculoDias  : String;
   iVigenciaValor    : Integer;
   iVigenciaMeses    : Integer;

   fDiasDif          : Double;
   fAnosEnteros      : Double;
   fAnosFraccion     : Double;
   fMesesEnteros     : Double;

begin
  if sValorizacion_Proceso = 'SI' then
     Obtener_Tasa_base_Mem(RegDes.TASA_VALOR_PTE //RegDes.TASA_VALOR_PAR
                   ,iDiasBaseTasa
                   ,sTipoInteres
                   ,iBaseMensual
                   ,sTipoCalculoDias
                   ,iVigenciaValor
                   ,iVigenciaMeses
                   ,sPais_Tasa
                   ,sModulo_err
                   ,sString_err
                   ,Result)
  else
     Obtener_Tasa_base(RegDes.TASA_VALOR_PTE //RegDes.TASA_VALOR_PAR
                   ,iDiasBaseTasa
                   ,sTipoInteres
                   ,iBaseMensual
                   ,sTipoCalculoDias
                   ,iVigenciaValor
                   ,iVigenciaMeses
                   ,sPais_Tasa
                   ,sModulo_err
                   ,sString_err
                   ,Result);
  if NOT Result then
     exit;

  // Calculo el Nro de dias entre fecha emisión y fecha de vencimiento.
  Calculo_de_dias(Reg_Fechas.Fecha_Calculo, //Reg_Fechas.Fecha_Emision,
                  Reg_Fechas.Fecha_Vencimiento,
                  sTipoCalculoDias,
                  sPais_Tasa,
                  fDiasDif,
                  fAnosEnteros,
                  fAnosFraccion,
                  fMesesEnteros
                  );

  if fDiasDif = 0 then
     begin
       fTasaCalculo := 0;
       exit;
     end;

  if fValor_Pte_UM = 0 then
     begin
       sModulo_Err := 'Calculo TIR Instrumento sin cupones';
       sString_Err := 'Valor invertido para calculo de TIR, no puede ser cero.';
       Result := False;
       exit;
     end;


  if sTipoInteres = 'S' then
     fTasaCalculo := (((fValor_Final / fValor_Pte_UM) - 1) *
                         (iDiasBaseTasa / fDiasDif)
                       )*100
     else
       fTasaCalculo := (power((fValor_Final / fValor_Pte_UM),
                              (iDiasBaseTasa / fDiasDif)
                             ) - 1)*100;

  fTasaCalculo := redondeo(fTasaCalculo,4);
end;
//------------------------------------------------------------------------------
procedure Calcula_Tasa_Basica_Proyeccion_Simple(sCodigo_Tasa     : String;
                                                RegDes           : TReg_Descriptor;
                                                dFecha_Calculo   : TDateTime;
                                                var fTasa_Basica : Double;
                                                var sModulo_Err  : String;
                                                var sString_Err  : String;
                                                var Result       : Boolean);

var
  dMax_Fecha      : TDateTime;
  sTasa_Equiv     : String;
  sTasa_Buscada   : String;
  bBuscar         : Boolean;
  fVigencia_Meses : Double;
begin
  // Se determina la fecha a la que de realizo la
  // proyeccion simple
  WITH dmFunciones_Valorizacion.Qry_Aux do
    begin
      SQL.Clear;
      SQL.Add('SELECT MAX(Fecha_Paridad) As Max_Fecha');
      SQL.Add('  FROM Qs_Sys_Val_Cambio');
      SQL.Add(' WHERE Cod_Moneda      = :Codigo_Tasa');
      SQL.Add('   AND Tipo_De_Paridad = ''BC''');
      SQL.Add('   AND Fecha_Paridad  <= :fecha');

      ParamByName('Codigo_Tasa').AsString := sCodigo_Tasa;
      ParamByName('fecha').AsDateTime     := dFecha_Calculo;

      Prepare;
      Open;

      dMax_Fecha := FieldByName('Max_Fecha').AsDateTime;

      Close;
      UnPrepare;

      bBuscar     := True;
      sTasa_Buscada := sCodigo_Tasa;
      Repeat
        begin
          SQL.Clear;
          SQL.Add('SELECT a.Vigencia_Meses');
          SQL.Add('      ,b.Tasa_Equiv');
          SQL.Add('  FROM Qs_Fin_Tasa_Base a');
          SQL.Add('      ,Qs_Fin_Tasa_Conver b');
          SQL.Add(' WHERE a.Cod_Tasa_Base = :Codigo_Tasa');
          SQL.Add('   AND a.Cod_Tasa_Base = b.Cod_Tasa_Base');


          ParamByName('Codigo_Tasa').AsString := sTasa_Buscada;
          Prepare;
          Open;

          if FieldByName('Vigencia_Meses').IsNull then
             fVigencia_Meses := 0
          else
             fVigencia_Meses := FieldByName('Vigencia_Meses').AsFloat;

          if fVigencia_Meses = RegDes.Periodo_Pago then
             bBuscar := False
          else
             if (FieldByName('Tasa_Equiv').AsString = '') or
                (FieldByName('Tasa_Equiv').IsNull)        then
                sTasa_Equiv := ''
             else
                begin
                  sTasa_Equiv   := FieldByName('Tasa_Equiv').AsString;
                  sTasa_Buscada := FieldByName('Tasa_Equiv').AsString;
                end;

          Close;
          UnPrepare;

        end;
      Until (sTasa_Equiv = '') or (bBuscar = False);

      if bBuscar then
         begin
           sModulo_Err := 'Obtención de Tasa Básica';
           sString_Err := 'No se encontró valor para '+sCodigo_Tasa+#10
                         +'o tasa equivalente a '+FloatToStr(RegDes.Periodo_Pago)+' meses.';
           Result := False;
           exit;
         end;

      leer_valor_cambio2(sTasa_Buscada
                        ,sTasa_Buscada
                        ,'BC'
                        ,dMax_Fecha
                        ,fTasa_Basica
                        ,Result);

      if NOT Result then
         begin
           sModulo_Err := 'Obtención de Tasa Básica';
           sString_Err := 'No se encontró valor para '+sTasa_Buscada+#10
                         +'Con fecha : '+DateToStr(dMax_Fecha);
         end;
    end;
end;
//------------------------------------------------------------------------------
procedure Calcula_Tasa_Descuento_Futuro_Imp(sMetodo_Tasa_Basica  : String;
                                            Reg_Formula_PAR      : TRegFormulaPAR;
                                            Reg_Formula_TIR      : TRegFormulaTIR;
                                            sTipo_Instrumento    : String;
                                            var Array_Mem_Desarr : TArray_Mem_Desarr;
                                            sNemotecnico         : String;
                                            RegDes               : TReg_Descriptor;
                                            Reg_Fechas           : TRegistro_Fechas;
                                            fNominales_Compra    : Double;
                                            bConCupon            : Boolean;
                                            fValor_Pte_UM_Compra : Double;
                                            sOrigen              : String;
                                            var sModulo_Err      : String;
                                            var sString_Err      : String;
                                            var Result           : Boolean);
var
  iCuponVigente            : Integer;
  iCupon                   : Integer;
  bTasas_Basicas_Cargadas  : Boolean;
  fValor_Par_Base          : Double;
  fValor_Par_UM            : Double;
  fTasaCalculo             : Double;
  fTIR_Desarr              : Double;
  fValor_Presente          : Double;
  fValor_Par_Corto         : Double;
  fMargen_Inicial          : Double;

  iDiasBaseTasa            : Integer;
  sTipoInteres,
  sPais_Tasa               : String;
  iBaseMensual             : Integer;
  sTipoCalculoDias         : String;
  iVigenciaValor           : Integer;
  iVigenciaMeses           : Integer;

  Aux_Fecha_Calculo        : TDateTime;

  Array_Mem_Desarr_Fecha_Calculo : TArray_Mem_Desarr;
  sMetodo_Sin_Tasa_Referencia    : String;
begin
  // El Margen Inicial siempre debe ser calculado a la fecha de compra
  // Por lo tanto cuando se realiza un calculo a una fecha distinta de
  // la fecha de compra debo :
  //    - Cargar tablas de desarrollo a Fecha de Compra
  //    - Calcular Tasas Basicas a fecha de compra
  //    - Obtengo TIR (Margen Inicial)

  // Aux_Fecha_Calculo almacena la fecha de calculo original

  Aux_Fecha_Calculo        := Reg_Fechas.Fecha_Calculo;
  Reg_Fechas.Fecha_Calculo := Reg_Fechas.Fecha_Compra;

  fValor_Par_Base          := 0;
  fValor_Par_UM            := 0;

  // Si la fecha de calculo es igual a la fecha de compra
  // Trapaso la tabla de desarrollo cargada directamente
  // En el otro caso la cargo a fecha de compra
  if Aux_Fecha_Calculo = Reg_Fechas.Fecha_Compra then
     begin
        Array_Mem_Desarr_Fecha_Calculo := copy(Array_Mem_Desarr);
     end
  else
     begin
        // Se obtiene el metodo para obtener la tasa cuando no existe
        // Es por formula PAR ya que esto es definido por el emisor
        // Ojo se vuelve a leer por si a cambiado
        sMetodo_Sin_Tasa_Referencia := Metodo_Sin_Tasa_Referencia(Reg_Formula_PAR.Codigo_Formula
                                                                 ,Reg_Fechas.Fecha_Calculo);

        // Cargo tabla de desarollo a fecha de Compra
        carga_Mem_Desarr(Array_Mem_Desarr_Fecha_Calculo
                        ,sNemotecnico
                        ,RegDes
                        ,Reg_Fechas
                        ,sMetodo_Sin_Tasa_Referencia
                        ,bConCupon
                        ,True     // Verifica Exepciones Cambiarias
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);
        if NOT Result then
           exit;
     end;


  Cupon_Vigente(Array_Mem_Desarr_Fecha_Calculo
               ,RegDes
               ,Reg_Fechas.Fecha_Calculo
               ,bConCupon
               ,iCuponVigente
               ,sModulo_Err
               ,sString_Err
               ,Result);

  if NOT Result then
     exit;

  bTasas_Basicas_Cargadas := False;
  iCupon := iCuponVigente;

  // Obtengo Tasas Básicas a fecha de compra
  While (iCupon = Array_Mem_Desarr_Fecha_Calculo[iCupon].Nro_Cupon) AND
        (NOT bTasas_Basicas_Cargadas)                               do
  begin
    Calcula_Tasa_Basica_Futuros_implicitos(Array_Mem_Desarr_Fecha_Calculo[iCupon].Tipo_Tasa
                                          ,iCupon
                                          ,RegDes
                                          ,Reg_Fechas.Fecha_Calculo
                                          ,Reg_Fechas
                                          ,Array_Mem_Desarr_Fecha_Calculo
                                          ,bTasas_Basicas_Cargadas
                                          ,sModulo_Err
                                          ,sString_Err
                                          ,Result);
    if NOT Result then
       exit;
    Inc(iCupon);
   end; // While

    // Solo para obtencion de TIR carga en la tasa de descuento la tasa básica
    iCupon := 1;
//    While iCupon = Array_Mem_Desarr_Fecha_Calculo[iCupon].Nro_Cupon do  // 07-2022
    While iCupon <= Max_Nro_Cupones do
      begin
        Array_Mem_Desarr_Fecha_Calculo[iCupon].Tasa_de_Descuento := Array_Mem_Desarr_Fecha_Calculo[iCupon].Tasa_Basica;
        Inc(iCupon);
      end;

  // Calculo de TIR. Es utilizado para obtener el Margen Inicial a la Compra
  // Utiliza el metodo de factores acumulados

   Calculo_TIR_PTE(Reg_Formula_PAR
                  ,Reg_Formula_TIR
                  ,sTipo_Instrumento
                  ,Array_Mem_Desarr_Fecha_Calculo
                  ,sNemotecnico
                  ,RegDes
                  ,Reg_Fechas
                  ,fNominales_Compra
                  ,fValor_Par_Base
                  ,fValor_Par_UM
                  ,bConCupon
                  ,True     // Acumula Factor
                  ,'N'
                  ,''
                  ,sOrigen
                  ,fTasaCalculo
                  ,fTIR_Desarr
                  ,fValor_Presente
                  ,fValor_Pte_UM_Compra
                  ,fValor_Par_Corto
                  ,sModulo_Err
                  ,sString_Err
                  ,Result);



  if NOT Result then
     exit;

  fMargen_Inicial := fTasaCalculo;

  // Devuelvo el valor original a la fecha de calculo
  Reg_Fechas.Fecha_Calculo := Aux_Fecha_Calculo;

  // Si Fecha de Calculo es igual a la fecha de compra
  // la traspaso a tabla de desarrollo original (Recupero Tasas Basicas)
  if Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Compra then
     Array_Mem_Desarr := copy(Array_Mem_Desarr_Fecha_Calculo);


  // Para el caso que la fecha de compra es distinta a la fecha
  // de calculo vuelvo a cargar las tasas basicas pero esta vez
  // a fecha de calculo
  if Reg_Fechas.Fecha_Calculo <> Reg_Fechas.Fecha_Compra then
     begin
      Cupon_Vigente(Array_Mem_Desarr
                   ,RegDes
                   ,Reg_Fechas.Fecha_Calculo
                   ,bConCupon
                   ,iCuponVigente
                   ,sModulo_Err
                   ,sString_Err
                   ,Result);

      bTasas_Basicas_Cargadas := False;
      iCupon := iCuponVigente;

      // Obtengo Tasas Básicas a fecha de Calculo

//      While (iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon) AND
      While (iCupon <= Max_Nro_Cupones) AND
            (NOT bTasas_Basicas_Cargadas)                 do
      begin
        Calcula_Tasa_Basica_Futuros_implicitos(Array_Mem_Desarr[iCupon].Tipo_Tasa
                                              ,iCupon
                                              ,RegDes
                                              ,Reg_Fechas.Fecha_Calculo
                                              ,Reg_Fechas
                                              ,Array_Mem_Desarr
                                              ,bTasas_Basicas_Cargadas
                                              ,sModulo_Err
                                              ,sString_Err
                                              ,Result);
        if NOT Result then
           exit;

          Inc(iCupon);
      end; // While
     end;

  // Calculo Tasa de Riesgo Especifica
  // Establesco Factor de Descuento (Fd) para cada Flujo

  Obtener_Tasa_base(RegDes.TASA_VALOR_PTE
                   ,iDiasBaseTasa
                   ,sTipoInteres
                   ,iBaseMensual
                   ,sTipoCalculoDias
                   ,iVigenciaValor
                   ,iVigenciaMeses
                   ,sPais_Tasa
                   ,sModulo_err
                   ,sString_err
                   ,Result);

  if NOT Result then
     exit;

  iCupon := iCuponVigente;
//  While iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon do    // 07-2022
  While iCupon <= Max_Nro_Cupones do
    begin
      Array_Mem_Desarr[iCupon].Tasa_Riesgo := Array_Mem_Desarr[iCupon].Tasa_Basica +
                                              fMargen_Inicial;

      Array_Mem_Desarr[iCupon].Tasa_De_Descuento := Array_Mem_Desarr[iCupon].Tasa_Riesgo;
      inc(iCupon);
    end;
end;
//------------------------------------------------------------------------------
procedure Calcula_Tasa_Basica_Con_Tasa_Refencia_Proy_Simple(dFecha_Desde       : TDateTime;
                                                            dFecha_Hasta       : TDateTime;
                                                            sCodigo_Tasa       : String;
                                                            RegDes             : TReg_Descriptor;
                                                            fTasa_Original     : Double;
                                                            dFecha_Calculo     : TDateTime;
                                                            var fTasa_Basica   : Double;
                                                            var sModulo_Err    : String;
                                                            var sString_Err    : String;
                                                            var Result         : Boolean);
var
   iVigenciaDias     : Integer;
   iVigenciaDiasOrig : Double;
   iVigenciaMeses    : Integer;

   fDif_Dias        : Double;
   sTasa_Equiv      : String;
   sLimite_Anterior : Double;
   iArray_Idx       : Integer;

   dMax_Fecha       : TDateTime;


   bBuscar          : Boolean;
   iIdx_Siguiente   : Integer;

   Array_Tasas_Equiv         : Array[1..100] of TTasas_Equivalentes;
//   Array_Tasas_Interpolacion : Array[1..Max_Nro_Cupones] of TTasas_Equivalentes;
begin

  // Leo directo de la tabla para obtener Base Mensual con decimales (flotante)
  WITH dmFunciones_Valorizacion.Qry_Aux do
  begin
    SQL.Clear;
    SQL.Add('SELECT (Base_Mensual_Tasa * Vigencia_Meses) As Vigencia_Original');
    SQL.Add('       ,Vigencia_Meses');
    SQL.Add('  FROM QS_Fin_Tasa_Base');
    SQL.Add(' WHERE Cod_Tasa_Base = :Cod_Tasa_Base');

    ParamByName('Cod_Tasa_Base').AsString := sCodigo_Tasa;
    Prepare;
    Open;

    iVigenciaDiasOrig := FieldByName('Vigencia_Original').AsFloat;
    iVigenciaMeses    := FieldByName('Vigencia_Meses').AsInteger;

    Close;
    UnPrepare;
  end;

{
  Obtener_Tasa_base(sCodigo_Tasa
                   ,iDias_Ref_Tasa
                   ,sTipoInteres
                   ,iBaseMensual
                   ,sTipoCalculoDias
                   ,iVigenciaDias
                   ,iVigenciaMeses
                   ,sModulo_Err
                   ,sString_Err
                   ,Result);

  if NOT Result then
     exit;
}
  // 1.- Obtengo tasas equivalentes
  // hasta el nro de periodos entre las dos fechas (fDif_Dias)
  WITH dmFunciones_Valorizacion.Qry_Aux do
  begin
    SQL.Clear;
    SQL.Add('SELECT MAX(Fecha_Paridad) As Max_Fecha');
    SQL.Add('  FROM Qs_Sys_Val_Cambio');
    SQL.Add(' WHERE Cod_Moneda      = :Codigo_Tasa');
    SQL.Add('   AND Tipo_De_Paridad = ''BC''');
    SQL.Add('   AND Fecha_Paridad  <= :fecha');

    ParamByName('Codigo_Tasa').AsString := sCodigo_Tasa;
    ParamByName('fecha').AsDateTime     := dFecha_Calculo;

    Prepare;
    Open;

    dMax_Fecha := FieldByName('Max_Fecha').AsDateTime;

    Close;
    UnPrepare;
  end;


bBuscar           := True;
sTasa_Equiv       := sCodigo_Tasa;
sLimite_Anterior  := 0;
iArray_Idx        := 1;

// iVigenciaDiasOrig := iVigenciaDias;


fDif_Dias := dFecha_Hasta - dFecha_Desde;

Repeat
  WITH dmFunciones_Valorizacion.Qry_Aux do
  begin
    SQL.Clear;
    SQL.Add('SELECT a.Vigencia_Valor');
    SQL.Add('      ,b.Tasa_Equiv');
    SQL.Add('  FROM Qs_Fin_Tasa_Base a');
    SQL.Add('      ,Qs_Fin_Tasa_Conver b');
    SQL.Add(' WHERE a.Cod_Tasa_Base = :Codigo_Tasa');
    SQL.Add('   AND a.Cod_Tasa_Base = b.Cod_Tasa_Base');


    ParamByName('Codigo_Tasa').AsString := sTasa_Equiv;
    Prepare;
    Open;

    if FieldByName('Vigencia_Valor').IsNull then
       iVigenciaDias := 0
    else
       iVigenciaDias := FieldByName('Vigencia_Valor').AsInteger;

    Array_Tasas_Equiv[iArray_Idx].Limite_Inf := sLimite_Anterior;
    Array_Tasas_Equiv[iArray_Idx].Limite_Sup := iVigenciaDias;

    leer_valor_cambio2(sTasa_Equiv
                      ,sTasa_Equiv
                      ,'BC'
                      ,dMax_Fecha
                      ,fTasa_Basica
                      ,Result);

    if NOT Result then
       begin
         fTasa_Basica := 0;
       end;

    Array_Tasas_Equiv[iArray_Idx].Valor_Tasa := fTasa_Basica;

    if iVigenciaDias >= fDif_Dias then
       bBuscar := False
    else
       if FieldByName('Tasa_Equiv').IsNull then
          sTasa_Equiv := ''
       else
          sTasa_Equiv := FieldByName('Tasa_Equiv').AsString;

    Close;
    UnPrepare;
    sLimite_Anterior := Array_Tasas_Equiv[iArray_Idx].Limite_Sup;
    Inc(iArray_Idx);
  end;
  Until (sTasa_Equiv = '') or (bBuscar = False);

  iArray_Idx := 1;
  fTasa_Basica := Array_Tasas_Equiv[iArray_Idx].Valor_Tasa;

  if (((fDif_Dias / iVigenciaDiasOrig) <= 1) or
       (iVigenciaMeses = RegDes.Periodo_Pago)
      ) then
     begin
       Result := True;
       exit;
     end;

  // Se debe Interpolar .....


      if bBuscar then
         begin
           sModulo_Err := 'Obtención de Tasa Básica';
           sString_Err := 'No se encontró valor tasa equivalente a '+sCodigo_Tasa+''#10
                         +'para '+FloatToStr(fDif_Dias);
           Result := False;
           exit;
         end;

      iArray_Idx := 1;
      fTasa_Basica := 0;

      repeat
        begin
          iIdx_Siguiente := iArray_Idx + 1;
          if ((Array_Tasas_Equiv[iIdx_Siguiente].Limite_Inf = 0) and
              (Array_Tasas_Equiv[iIdx_Siguiente].Limite_Sup = 0)) then
              begin
                iIdx_Siguiente := iArray_Idx;
              end;

          IF Array_Tasas_Equiv[iIdx_Siguiente].Limite_Sup > fDif_Dias THEN
                Array_Tasas_Equiv[iIdx_Siguiente].Limite_Sup := fDif_Dias;

// INTERPOLACION
          fTasa_Basica := fTasa_Basica +
                         (((Array_Tasas_Equiv[iIdx_Siguiente].Valor_Tasa -
                            Array_Tasas_Equiv[iArray_Idx].Valor_Tasa
                            ) /
                            iVigenciaDiasOrig
                           )*
                           (Array_Tasas_Equiv[iIdx_Siguiente].Limite_Sup -
                            (Trunc(Array_Tasas_Equiv[iIdx_Siguiente].Limite_Sup /
                                   iVigenciaDiasOrig
                                   ) *
                             iVigenciaDiasOrig
                             )
                            )
                          );
          Inc(iArray_Idx);
        end;
      until (
             ((Array_Tasas_Equiv[iArray_Idx].Limite_Inf = 0) and
              (Array_Tasas_Equiv[iArray_Idx].Limite_Sup = 0)
              )
              or
             (Array_Tasas_Equiv[iArray_Idx].Limite_Inf >= fDif_Dias)
             );
      fTasa_Basica := fTasa_Basica + Array_Tasas_Equiv[1].Valor_Tasa;

end;
//------------------------------------------------------------------------------
procedure Calcula_Tasa_Basica_Futuros_implicitos(sCodigo_Tasa                : String;
                                                 iNro_Cupon                  : Integer;
                                                 RegDes              : TReg_Descriptor;
                                                 dFecha                      : TDateTime;
                                                 Reg_Fechas                  : TRegistro_Fechas;
                                                 var Array_Mem_Desarr        : TArray_Mem_Desarr;
                                                 var bTasas_Basicas_Cargadas : Boolean;
                                                 var sModulo_Err             : String;
                                                 var sString_Err             : String;
                                                 var Result                  : Boolean);

var

   Array_Tasas         : TArray_Tasas_Equivalentes;
   Array_Tasas_Seleccionadas : TArray_Tasas_Equivalentes;
   Array_Interpolacion : TArray_Interpolacion;
   iArray_Idx          : Integer;
   iIdx_Interpol       : Integer;
   iCupon              : Integer;
   sTipo               : String;
   fPeriodo            : Double;
   sAnualidad          : String;
   fBase_Porcen        : Double;
   bInterpola          : Boolean;



  function busca_Cupon_Interpoladas(iNro_Cupon : Double) : Integer;
    begin
       Result := 1;
       while Array_Interpolacion[Result].Limite_Sup <> 0 do
         begin
           if Array_Interpolacion[Result].Nro_Cupon = iNro_Cupon then
              begin
                exit;
              end;
           Inc(Result);
         end;
       if Array_Interpolacion[Result].Limite_Sup = 0 then
          Result := 0;
    end;

begin
  Obtener_Base_Conversion(sCodigo_Tasa
                         ,sTipo
                         ,fPeriodo
                         ,sAnualidad
                         ,fBase_Porcen
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);
  if NOT Result then
     exit;
 // Ojo: Si el periodo de pago del descriptor es igual al de la tasa
 // Original SOLO DEBE TRASPASAR LOS VALORES CON QUE FUERON CALCULADOS
 // LOS FLUJOS. Siempre y cuando sean tasas sin referencua
 if (RegDes.Periodo_Pago <> fPeriodo) or
    (Array_Mem_Desarr[iNro_Cupon].Real_Estimado = '') then
   begin
    // Si la fecha de vencimiento de uno de los cupones o la fecha de emision
    // coincide con la fecha de calculo no se debe interpolar
    iArray_Idx := 1;
    bInterpola := True;
    While Array_Mem_Desarr[iArray_Idx].Nro_Cupon = iArray_Idx do
       begin
         if Array_Mem_Desarr[iArray_Idx].Fecha_Vcto = Reg_Fechas.Fecha_Calculo then
            bInterpola := False;
         Inc(iArray_Idx);
       end;

    if Reg_Fechas.Fecha_Calculo = Reg_Fechas.Fecha_Emision then
       bInterpola := False;

    Completa_limites_Cupones(iNro_Cupon
                            ,Reg_Fechas.Fecha_Calculo
                            ,Array_Mem_Desarr
                            ,Array_Interpolacion
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);

    if NOT Result then
       exit;

    Carga_Valores_Tasas_Equivalentes(sCodigo_Tasa
                                    ,dFecha
                                    ,False  // No crea periodos intermedios
                                    ,Array_Tasas
                                    ,sModulo_Err
                                    ,sString_Err
                                    ,Result);

    if NOT Result then
       exit;

// Siempre se utiliza el indice uno de Array_Interpolacion para
// la seleccion de tasas ya que en este array el primer registro
// es el que se esta calculando ....

    Selecciona_Tasas_Utilizadas(Array_Tasas
                               ,Array_Interpolacion[1].Limite_Inf
                               ,Array_Interpolacion[1].Limite_Sup
                               ,bInterpola
                               ,RegDes.Periodo_Pago
                               ,Array_Mem_Desarr[iNro_Cupon].Real_Estimado
                               ,Array_Tasas_Seleccionadas
                               ,sModulo_Err
                               ,sString_Err
                               ,Result);


    Actualiza_Valores_Tasas_Implicitas(Array_Mem_Desarr[iNro_Cupon].Real_Estimado
                                      ,RegDes.Periodo_Pago
                                      ,Array_Tasas_Seleccionadas
                                      ,sModulo_Err
                                      ,sString_Err
                                      ,Result);


    Interpolacion_Array_Tasas(Array_Mem_Desarr[iNro_Cupon].Real_Estimado
                             ,RegDes.Periodo_Pago
                             ,bInterpola  // Realiza interpolacion
                             ,iNro_Cupon
                             ,Array_Tasas_Seleccionadas
                             ,Array_Mem_Desarr
                             ,Array_Interpolacion
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);

    if NOT Result then
       exit;

    if Array_Mem_Desarr[iNro_Cupon].Real_Estimado <> '' then
       bTasas_Basicas_Cargadas := True;

    iCupon := iNro_Cupon;

//    while iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon do    // 07-2022
    While iCupon <= Max_Nro_Cupones do
       begin
         iIdx_Interpol := busca_Cupon_Interpoladas(iCupon);
         Array_Mem_Desarr[iCupon].Tasa_Basica :=
                                 Array_Interpolacion[iIdx_Interpol].Tasa_Interpolada;
         if Array_Mem_Desarr[iNro_Cupon].Real_Estimado = '' then
            break;
         Inc(iCupon);
       end;
   end
 else
   begin
    iCupon := iNro_Cupon;
//    while iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon do    // 07-2022
    While iCupon <= Max_Nro_Cupones do
       begin
         Array_Mem_Desarr[iCupon].Tasa_Basica := Array_Mem_Desarr[iCupon].Tasa_Flujo;
         if Array_Mem_Desarr[iNro_Cupon].Real_Estimado = '' then
            break;
         Inc(iCupon);
       end;
       bTasas_Basicas_Cargadas := True;
   end;
end;
//------------------------------------------------------------------------------
procedure Carga_Valores_Tasas_Equivalentes(sCodigo_Tasa    : String;
                                           dFecha          : TDateTime;
                                           bIntermedios    : Boolean;
                                           var Array_Tasas   : TArray_Tasas_Equivalentes;
                                           var sModulo_Err : String;
                                           var sString_Err : String;
                                           var Result      : Boolean);
var
  sAux_Cod_Tasa          : String;
  sTasa_Equiv            : String;
  iArray_Idx             : Integer;
  fDias_Periodo_Original : Double;
  fBase_Porcentual_Original : Double;
  fDias_ant              : Double;
  fVigenciaMeses         : Double;

begin
  // Inicializo arreglo
  for iArray_Idx := 1 to Max_Nro_Cupones do
    begin
      Array_Tasas[iArray_Idx].Limite_Inf      := 0;
      Array_Tasas[iArray_Idx].Limite_Sup      := 0;
      Array_Tasas[iArray_Idx].Valor_Tasa      := 0;
      Array_Tasas[iArray_Idx].Valor_Implicito := 0;
      Array_Tasas[iArray_Idx].Base_Porcentual := 0;
      Array_Tasas[iArray_Idx].Vigencia_Meses  := 0;
    end;

  WITH dmFunciones_Valorizacion.Qry_Aux do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Vigencia_Valor');
      SQL.Add('      ,a.Vigencia_Meses');
      SQL.Add('      ,a.Base_Mensual_Tasa');
      SQL.Add('      ,b.Base_Porcentual');
      SQL.Add('      ,b.Tasa_Equiv');
      SQL.Add('  FROM Qs_Fin_Tasa_Base a');
      SQL.Add('      ,Qs_Fin_Tasa_Conver b');
      SQL.Add(' WHERE a.Cod_Tasa_Base = :Cod_Tasa_Base');
      SQL.Add('   AND b.Cod_Tasa_Base = a.Cod_Tasa_Base');

      sTasa_Equiv := sCodigo_Tasa;
      fDias_ant   := 0;
      iArray_Idx  := 1;

      WHILE sTasa_Equiv <> '' do
        begin
          sAux_Cod_Tasa := sTasa_Equiv;
          ParamByName('Cod_Tasa_Base').AsString := sAux_Cod_Tasa;
          Prepare;
          Open;

          if (FieldByName('Vigencia_Valor').AsFloat = 0) or
             (FieldByName('Vigencia_Valor').IsNull) then
             begin
               sModulo_Err := 'Metodo Obtención de Tasas Equivalentes';
               sString_Err := 'No existe definición de Vigencia. Para tasa : '+sTasa_Equiv;
               Close;
               UnPrepare;
               Result := False;
               exit;
             end;

          Array_Tasas[iArray_Idx].Vigencia_Valor := FieldByName('Vigencia_Valor').AsFloat;

          if FieldByName('Tasa_Equiv').IsNull then
             sTasa_Equiv := ''
          else
             sTasa_Equiv := FieldByName('Tasa_Equiv').AsString;

          if FieldByName('Vigencia_Meses').IsNull then
             fVigenciaMeses := 0
          else
             fVigenciaMeses := FieldByName('Vigencia_Meses').AsFloat;

          if FieldByName('Base_Mensual_Tasa').IsNull then
             Array_Tasas[iArray_Idx].Base_Mensual_Tasa := 0
          else
             Array_Tasas[iArray_Idx].Base_Mensual_Tasa := FieldByName('Base_Mensual_Tasa').AsFloat;

          // Almaceno dias del periodo original
          if sCodigo_Tasa = sAux_Cod_Tasa then
             begin
               fDias_Periodo_Original    := FieldByName('Vigencia_Valor' ).AsFloat;
               fBase_Porcentual_Original := FieldByName('Base_Porcentual').AsFloat;
               Array_Tasas[iArray_Idx].Vigencia_Meses_Original := fVigenciaMeses;
             end;
          Array_Tasas[iArray_Idx].Vigencia_Original        := fDias_Periodo_Original;
          Array_Tasas[iArray_Idx].Base_Porcentual_Original := fBase_Porcentual_Original;

          // Formo limites de vigencia de tasa y chequeo
          // que no falten periodos con respecto a los dias Base
          
          Array_Tasas[iArray_Idx].Limite_Inf := fDias_Ant;
          Array_Tasas[iArray_Idx].Limite_Sup := FieldByName('Vigencia_Valor').AsFloat;

          fDias_Ant := fDias_Ant + fDias_Periodo_Original;

          if bIntermedios then
          while (fDias_Ant + fDias_Periodo_Original) < FieldByName('Vigencia_Valor' ).AsFloat do
             begin
               Array_Tasas[iArray_Idx].Limite_Sup := fDias_Ant;
               Array_Tasas[iArray_Idx].Base_Porcentual   := fBase_Porcentual_Original;
               Array_Tasas[iArray_Idx].Vigencia_Meses    := Array_Tasas[iArray_Idx].Limite_Sup / 30;  // Autorizado D.Q. Miami 09-Nov-2000
               Inc(iArray_Idx);
               Array_Tasas[iArray_Idx].Limite_Inf        := fDias_Ant;
               Array_Tasas[iArray_Idx].Limite_Sup        := fDias_Ant + fDias_Periodo_Original;
               Array_Tasas[iArray_Idx].Vigencia_Original := fDias_Periodo_Original;
               Array_Tasas[iArray_Idx].Base_Porcentual_Original := fBase_Porcentual_Original;
             end;


          fDias_Ant := Array_Tasas[iArray_Idx].Limite_Sup;
          Array_Tasas[iArray_Idx].Base_Porcentual := FieldByName('Base_Porcentual').AsFloat;
          Array_Tasas[iArray_Idx].Vigencia_Meses  := FieldByName('Vigencia_Meses').AsFloat;

          if FieldByName('Tasa_Equiv').IsNull then
             sTasa_Equiv := ''
          else
             sTasa_Equiv := FieldByName('Tasa_Equiv').AsString;
          Close;
          UnPrepare;

          // Busco valor de tasa a fecha correspondiente
          leer_valor_cambio2(sAux_Cod_Tasa
                            ,sAux_Cod_Tasa
                            ,'BC'
                            ,dFecha
                            ,Array_Tasas[iArray_Idx].Valor_Tasa
                            ,Result);

          if NOT Result then
             begin
              {
               sModulo_Err := 'Metodo Obtención de Tasas Equivalentes';
               sString_Err := 'No se encontro valor para tasa : '
                              +sTasa_Equiv
                              +' con fecha : '+DateToStr(dFecha);
               exit;
              }
              Array_Tasas[iArray_Idx].Valor_Tasa := 0;
             end;
           Inc(iArray_Idx);
        end;  // end while
    end;      // end with

    // Calculo valores para periodos que se generaron
    // entre periodos
    iArray_Idx := 1;
    While Array_Tasas[iArray_Idx].Limite_Sup <> 0 do
      begin
        if Array_Tasas[iArray_Idx].Valor_Tasa = 0 then
           Array_Tasas[iArray_Idx].Valor_Tasa := (Array_Tasas[iArray_Idx-1].Valor_Tasa +
                                                Array_Tasas[iArray_Idx+1].Valor_Tasa) / 2;
        Inc(iArray_Idx);
      end;
  Result := True;
end;
//------------------------------------------------------------------------------
procedure Actualiza_Valores_Tasas_Implicitas(sReal_Estimado  : String;
                                             fVigencia_Meses : Double;
                                             var Array_Tasas   : TArray_Tasas_Equivalentes;
                                             var sModulo_Err : String;
                                             var sString_Err : String;
                                             var Result      : Boolean);
var
  iArray_Idx : Integer;
  Base       : Double;
  Exponente  : Double;
begin
  //  Ojo si la tasa no es estimada no se calculan las implicitas
  //  Solo se mueven las los valores reales a la variable Valor Implicito
  if sReal_Estimado = '' then
     begin
       iArray_Idx := 1;
       while Array_Tasas[iArray_Idx].Limite_Sup <> 0 do
         begin
           Array_Tasas[iArray_Idx].Valor_Implicito := Array_Tasas[iArray_Idx].Valor_Tasa;
           Inc(iArray_Idx);
         end;
       exit;
     end;

  iArray_Idx := 1;
  if fVigencia_Meses = 0 then
     fVigencia_Meses := Array_Tasas[iArray_Idx].Vigencia_Meses_Original;


  While Array_Tasas[iArray_Idx].Limite_Sup <> 0 do
    begin
      Base := 1 + (Array_Tasas[iArray_Idx].Valor_Tasa / Array_Tasas[iArray_Idx].Base_Porcentual);
      Exponente := Array_Tasas[iArray_Idx].Vigencia_Meses / fVigencia_Meses;

      Array_Tasas[iArray_Idx].Valor_Implicito := power(Base,Exponente);

      if iArray_Idx > 1 then
         begin
           Base := 1 + (Array_Tasas[iArray_Idx-1].Valor_Tasa / Array_Tasas[iArray_Idx-1].Base_Porcentual);
           Exponente := Array_Tasas[iArray_Idx-1].Vigencia_Meses / fVigencia_Meses;

           Array_Tasas[iArray_Idx].Valor_Implicito := Array_Tasas[iArray_Idx].Valor_Implicito /
                                                      power(Base,Exponente);
         end;

      Array_Tasas[iArray_Idx].Valor_Implicito := Array_Tasas[iArray_Idx].Valor_Implicito - 1;
      Array_Tasas[iArray_Idx].Valor_Implicito := Array_Tasas[iArray_Idx].Valor_Implicito *
                                               Array_Tasas[iArray_Idx].Base_Porcentual_Original;

      Inc(iArray_Idx);
    end;
  Result := True;
end;
//------------------------------------------------------------------------------
procedure Interpolacion_Array_Tasas(Real_Estimado         : String;
                                    fVigencia_Meses       : Double;
                                    bInterpolar           : Boolean;
                                    iCupon_Desde          : Integer;
                                    var Array_Tasas_Seleccionadas : TArray_Tasas_Equivalentes;
                                    var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                    var Array_Interpolacion : TArray_Interpolacion;
                                    var sModulo_Err       : String;
                                    var sString_Err       : String;
                                    var Result            : Boolean);
var
   iArray      : Integer;
   iArray_Periodo_Inf : Integer;
   iArray_Periodo_Sup : Integer;
   bBuscar     : Boolean;
   fValor_Limite_Inferior,
   fValor_Limite_Superior    : Double;
   fVigencia_Valor           : Double;

   // Funcion Busca Tasa..
   // entrega la posicion del arreglo en que esta la tasa correspondiente
   // si no lo encuentra sale con 0
   function busca_tasa(fDias : Double) : Integer;
     begin
       Result := 1;
       WHILE Array_Tasas_Seleccionadas[Result].Limite_Sup <> 0 do
         begin
           if (fDias >= Array_Tasas_Seleccionadas[Result].Limite_Inf) and
              (fDias <  Array_Tasas_Seleccionadas[Result].Limite_Sup) then
              exit;
           Inc(Result);
         end;
         if Array_Tasas_Seleccionadas[Result].Limite_Sup = 0 then
            Result := 0;
     end;

   // Funcion Busca Tasa para numero de dias mas alto
   // entrega la posicion del arreglo en que esta la tasa correspondiente
   function Mayor_tasa : Integer;
     begin
       Result := 1;
       WHILE Array_Tasas_Seleccionadas[Result].Limite_Sup <> 0 do
         Inc(Result);

       Result := Result - 1;
     end;

begin
    bBuscar     := True;
    iArray := 1;
    While Array_Interpolacion[iArray].Limite_Sup <> 0 do
      begin
        if bBuscar then  // Cuando es Buscar Busca Valores de los limites
           begin
             // Busco valor para limite inferior
             iArray_Periodo_Inf := Busca_Tasa(Array_Interpolacion[iArray].Limite_Inf);

             if iArray_Periodo_Inf = 0 then
                begin
                 iArray_Periodo_Sup := Busca_Tasa(Array_Interpolacion[iArray].Limite_Sup);
                 // Si se da el caso de que no tengo limite inferior pero si superior
                 // estamos en un extremo. Por lo tanto se asigna el valor del superior
                 if iArray_Periodo_Sup <> 0 then
                    begin
                      Array_Interpolacion[iArray].Valor_Inf :=
                                Array_Tasas_Seleccionadas[iArray_Periodo_Sup].Valor_Implicito;
                      fValor_Limite_Inferior := Array_Interpolacion[iArray].Valor_Inf;
                    end
                 else
                    begin
                      // No encontro valor.Buscar es False para que mantenga el valor
                      bBuscar     := False;
                      bInterpolar := False;
                    end;
                end
             else
                begin
                  Array_Interpolacion[iArray].Valor_Inf :=
                               Array_Tasas_Seleccionadas[iArray_Periodo_Inf].Valor_Implicito;
                  fValor_Limite_Inferior := Array_Interpolacion[iArray].Valor_Inf;
                end;

             iArray_Periodo_Sup := Busca_Tasa(Array_Interpolacion[iArray].Limite_Sup);

             // Se Verifica si los limites se saltan algun periodo completo
             // Para hacer la interpolacion se debe hacer contra el periodo
             // siguiente

              if (iArray_Periodo_Sup - iArray_Periodo_Inf) > 1 then
                begin
                  // Limite superior debe ser igual al inferior mas
                  // El periodo de pago de la tasa
                  // En el documento toma 92. Aca sumamos la vigencia de la tasa

                  Array_Interpolacion[iArray].Limite_Sup := Array_Interpolacion[iArray].Limite_Inf +
                                                            Array_Tasas_Seleccionadas[1].Vigencia_Original;
                  iArray_Periodo_Sup := Busca_Tasa(Array_Interpolacion[iArray].Limite_Sup);                                                            
                end;

             // Busco valor para limite superior


             if iArray_Periodo_Sup = 0 then
                begin
                  fValor_Limite_Superior := 0;
                  bInterpolar := False;
                end
             else
                begin
                  Array_Interpolacion[iArray].Valor_Sup := Array_Tasas_Seleccionadas[iArray_Periodo_Sup].Valor_Implicito;
                  fValor_Limite_Superior                := Array_Interpolacion[iArray].Valor_Sup;
                end;
           end ;// End bBuscar (el que trabaja buscando tasas)

        if NOT bBuscar then  // Pregunto otra vez por si no encontro en este ciclo
           begin
             // Si ya no busca (es que en alguno no encontro !!!)
             // Debe asignar la tasa interpolada para el numero de dias
             // mas alto
             fValor_Limite_Inferior := Array_Tasas_Seleccionadas[Mayor_tasa].Valor_Implicito
           end;

        if bInterpolar then
           begin
             if bBuscar then
                begin
                  if Array_Tasas_Seleccionadas[1].Base_Mensual_Tasa > 0 then
                     fVigencia_Valor := Array_Tasas_Seleccionadas[1].Base_Mensual_Tasa *
                                        Array_Tasas_Seleccionadas[1].Vigencia_Meses
                  else
                     fVigencia_Valor := Array_Tasas_Seleccionadas[1].Vigencia_Valor;

// INTERPOLACION
                  Array_Interpolacion[iArray].Tasa_Interpolada := fValor_Limite_Inferior +
                                                                (((fValor_Limite_Superior -
                                                                   fValor_Limite_Inferior
                                                                   ) /
                                                                   fVigencia_Valor
                                                                  ) *
                                                                 (Array_Interpolacion[iArray].Limite_Sup -
                                                                  (Trunc(Array_Interpolacion[iArray].Limite_Sup /
                                                                         fVigencia_Valor
                                                                         )*
                                                                   fVigencia_Valor
                                                                   )
                                                                  )
                                                                 );
                end;
           end
        else
           Array_Interpolacion[iArray].Tasa_Interpolada := fValor_Limite_Inferior;
        iArray := iArray + 1;
        if Real_Estimado = '' then
           break;
      end;  // end While

end;
//------------------------------------------------------------------------------
procedure Completa_limites_Cupones(iCupon_Desde            : Integer;
                                   dFecha_Calculo          : TDateTime;
                                   var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                   var Array_Interpolacion : TArray_Interpolacion;
                                   var sModulo_Err         : String;
                                   var sString_Err         : String;
                                   var Result              : Boolean);
var
  iCupon : Integer;
  iArray : Integer;
begin
 // Inicializo arreglo
  for iArray := 1 to Max_Nro_Cupones do
    begin
      Array_Interpolacion[iArray].Limite_Inf       := 0;
      Array_Interpolacion[iArray].Limite_Sup       := 0;
      Array_Interpolacion[iArray].Valor_Implicito  := 0;
      Array_Interpolacion[iArray].Tasa_Interpolada := 0;
    end;

  iArray := 1;
  // Cargo los limites correspondientes a los cupones
  iCupon := iCupon_Desde;
//  While (iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon) do  // Recorre la tabla de desarrollo mientras existen cupones
  While (iCupon <= Max_Nro_Cupones) do
    begin
      Array_Mem_Desarr[iCupon].Dias_Al_Vcto := Array_Mem_Desarr[iCupon].Fecha_Vcto - dFecha_Calculo;
      Array_Interpolacion[iArray].Nro_Cupon := iCupon;

      if (iCupon <= 1) then
         Array_Interpolacion[iArray].Limite_Inf := 0
      else
         Array_Interpolacion[iArray].Limite_Inf := Array_Mem_Desarr[iCupon - 1].Dias_Al_Vcto;

      Array_Interpolacion[iArray].Limite_Sup    := Array_Mem_Desarr[iCupon].Dias_Al_Vcto;
      Inc(iArray);
      Inc(iCupon);
    end;
end;
//------------------------------------------------------------------------------
procedure Selecciona_Tasas_Utilizadas(Array_Tasas                   : TArray_Tasas_Equivalentes;
                                      fLimite_Inferior              : Double;
                                      fLimite_Superior              : Double;
                                      bInterpola                    : Boolean;
                                      Periodo_Meses                 : Double;
                                      Real_Estimado                 : String;
                                      var Array_Tasas_Seleccionadas : TArray_Tasas_Equivalentes;
                                      var sModulo_Err               : String;
                                      var sString_Err               : String;
                                      var Result                    : Boolean);
var
   iArray_Idx       : Integer;
   iArray_idx_Selec  : Integer;
   iAnt_Array_Tasas : Integer;
   fLimite_Anterior : Double;

   function Inicializa_Tasas(Array_Function : TArray_Tasas_Equivalentes): TArray_Tasas_Equivalentes;
   var i : Integer;
     begin
       for i := 1 to Max_Nro_Cupones do
         begin
           Array_Function[i].Limite_Inf      := 0;
           Array_Function[i].Limite_Sup      := 0;
           Array_Function[i].Valor_Tasa      := 0;
           Array_Function[i].Valor_Implicito := 0;
           Array_Function[i].Base_Porcentual := 0;
           Array_Function[i].Vigencia_Meses  := 0;
         end;
       Result := Array_Function;
     end;

begin
  // Procedimiento que deja en la tabla de tasas solo las tasas
  // que son utilizadas por el cupon

  // La logica es: Rango de tasa entra entre limite inferior y superior
  // si es así la tasa es seleccionada
  Array_Tasas_Seleccionadas := Inicializa_Tasas(Array_Tasas_Seleccionadas);

  iArray_Idx := 1;
  iArray_idx_Selec := 1;
  iAnt_Array_Tasas := 0;  // La ultima tasa rescatada

  While Array_Tasas[iArray_Idx].Limite_Sup <> 0 do
    begin
      if (Array_Tasas[iArray_Idx].Limite_Sup <= fLimite_Superior   ) and
         (Array_Tasas[iArray_Idx].Limite_Sup >= fLimite_Inferior   ) and
         ((Array_Tasas[iArray_Idx].Vigencia_Meses >= Periodo_Meses)  or
          (bInterpola)                                             ) then
         begin

           if (Real_Estimado <> '' ) and
              (iArray_idx_Selec = 1) and
              (iArray_Idx > 1      ) and
              (NOT bInterpola      ) then
               begin
                 // Selecciono tambien el anterior
                 Array_Tasas_Seleccionadas[iArray_idx_Selec] := Array_Tasas[iArray_Idx-1];
                 inc(iArray_idx_Selec);
               end;

           Array_Tasas_Seleccionadas[iArray_idx_Selec] := Array_Tasas[iArray_Idx];
           iAnt_Array_Tasas                            := iArray_Idx; // Guardo el ultimo asignado
           inc(iArray_idx_Selec);
         end;
      Inc(iArray_Idx);
    end;

  if bInterpola then  // si interpola ademas debe dejar cargado el siguiente rango (remantente)
     begin
       iAnt_Array_Tasas := iAnt_Array_Tasas + 1;
       if Array_Tasas[iAnt_Array_Tasas].Limite_Sup <> 0 then // solo si el siguiente al ultimo seleccionado es válido
          Array_Tasas_Seleccionadas[iArray_idx_Selec] := Array_Tasas[iAnt_Array_Tasas];
     end;

  iArray_Idx := 1;
  fLimite_Anterior := 0;
  // Repaso los limites
  While Array_Tasas_Seleccionadas[iArray_Idx].Limite_Sup <> 0 do
     begin
        if iArray_Idx <= 1 then
           Array_Tasas_Seleccionadas[iArray_Idx].Limite_Inf := 0
        else
           Array_Tasas_Seleccionadas[iArray_Idx].Limite_Inf := fLimite_Anterior;

        fLimite_Anterior := Array_Tasas_Seleccionadas[iArray_Idx].Limite_Sup;
        Inc(iArray_Idx);
     end;
end;
//------------------------------------------------------------------------------
{procedure Calcula_Tasa_Descuento(RegParamMargen       : TRegParamMargen;
                                 sTipo_Instrumento    : String;
                                 var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 sNemotecnico         : String;
                                 RegDes               : TReg_Descriptor;
                                 Reg_Fechas           : TRegistro_Fechas;
                                 fNominales_Compra    : Double;
                                 bConCupon            : Boolean;
                                 fValor_Pte_UM_Compra : Double;
                                 dTasa_Compra         : Double;
                                 var sModulo_Err      : String;
                                 var sString_Err      : String;
                                 var Result           : Boolean);
var
  iCupon           : Integer;
  fTasa_Descuento  : Double;
  dFechaDesde      : TDateTime;
  dFechaHasta      : TDateTime;

  dFecha_aplica    : TDateTime;

  iDiasBaseTasa    : Integer;
  sTipoInteres,
  sPais_Tasa       : String;
  iBaseMensual     : Integer;
  sTipoCalculoDias : String;
  iVigenciaValor   : Integer;
  iVigenciaMeses   : Integer;

  fDiasDif         : Double;
  fAnosEnteros     : Double;
  fAnosFraccion    : Double;
  fMesesEnteros    : Double;

  sTipo_Ajuste,
  sTipo_Tasa_Flot,
  sAnualidad_Tasa_Flot : String;
  iDecimales_Redondeo  : Integer;
  fPeriodo_Tasa_Flot,
  fBase_Porcen_Tasa_Flot : Double;

  fValor1              : Double;
  fValor2              : Double;

  Modulo_Err 
  ,String_Err :String;

begin
  sModulo_Err := 'Calculo Margen';
  if (RegParamMargen.Fecha_Aplica = '') or (RegParamMargen.Fecha_Aplica = NULL) then
     begin
       sString_Err := 'Error en definición de formula para '+sNemotecnico+' Falta Fecha Aplica';
       Result := False;
       exit;
     end;

  Tratamiento_Fecha(RegParamMargen.Fecha_Aplica
                   ,Reg_Fechas
                   ,dFecha_aplica
                   ,sModulo_Err
                   ,sString_Err
                   ,Result);

  if NOT Result then
     exit;

  if (RegParamMargen.Cod_Valor1 = 'TIRCOMP') then
     fValor1 := dTasa_Compra;

  if (RegParamMargen.Cod_Valor2 = 'TIRCOMP') then
     fValor2 := dTasa_Compra;

  if (RegParamMargen.Cod_Valor1 = 'CONSTANTE') then
     fValor1 := RegParamMargen.Constante_1;

  if (RegParamMargen.Cod_Valor2 = 'CONSTANTE') then
     fValor2 := RegParamMargen.Constante_2;

  if (RegParamMargen.Cod_Valor1 = 'TASAMERC') then
  Begin
      fValor1 := lee_tasa_mercado(sNemotecnico
                                  ,sTipo_Instrumento
                                  ,Reg_Fechas.Fecha_Calculo
                                  ,False);
      if fValor1 = 0 then
      begin
         Modulo_Err := 'Tasa Descuento';
         String_Err := RegParamMargen.Cod_Valor1+': No se encontró Tasa de Mercado para :'
                       +' Nemotecnico : '+sNemotecnico+''
                       +' Con Fecha   : '+DatetoStr(Reg_Fechas.Fecha_Calculo);
         exit;
      end;
  End;

  if (RegParamMargen.Cod_Valor2 = 'TASAMERC') then
  Begin
      fValor2 := lee_tasa_mercado(sNemotecnico
                                  ,sTipo_Instrumento
                                  ,Reg_Fechas.Fecha_Calculo
                                  ,False);
      if fValor2 = 0 then
      begin
         Modulo_Err := 'Tasa Descuento';
         String_Err := RegParamMargen.Cod_Valor1+': No se encontró Tasa de Mercado para :'
                       +' Nemotecnico : '+sNemotecnico+''
                       +' Con Fecha   : '+DatetoStr(Reg_Fechas.Fecha_Calculo);
         exit;
      end;
  End;

  if (RegParamMargen.Cod_Valor1 = 'TIRREFER') then
  Begin
     if RegParamMargen.Periodo_Aplica_D_1 <> '' Then
     Begin
         // Obtengo Fecha menor para busqueda de tasas por tramo
         Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_D_1
                          ,Reg_Fechas
                          ,dFechaDesde
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

         if NOT Result then
            exit;
     end;

     if RegParamMargen.Periodo_Aplica_H_1 <> '' Then
     Begin
     // Obtengo Fecha mayor para busqueda de tasas por tramo
       Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_H_1
                        ,Reg_Fechas
                        ,dFechaHasta
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

       if NOT Result then
          exit;

       if sValorizacion_Proceso = 'SI' then
          Obtener_Tasa_base_Mem(RegParamMargen.Tasa_Base_1
                               ,iDiasBaseTasa
                               ,sTipoInteres
                               ,iBaseMensual
                               ,sTipoCalculoDias
                               ,iVigenciaValor
                               ,iVigenciaMeses
                               ,sPais_Tasa
                               ,sModulo_err
                               ,sString_err
                               ,Result)
       else
          Obtener_Tasa_base(RegParamMargen.Tasa_Base_1
                           ,iDiasBaseTasa
                           ,sTipoInteres
                           ,iBaseMensual
                           ,sTipoCalculoDias
                           ,iVigenciaValor
                           ,iVigenciaMeses
                           ,sPais_Tasa
                           ,sModulo_err
                           ,sString_err
                           ,Result);

       if NOT Result then
          exit;

       Calculo_de_dias(dFechaDesde,
                       dFechaHasta,
                       sTipoCalculoDias,
                       sPais_Tasa,
                       fDiasDif,
                       fAnosEnteros,
                       fAnosFraccion,
                       fMesesEnteros);

       Lee_Tasa_Tramos(RegParamMargen.Tasa_Base_1
                      ,RegParamMargen.Interpolacion_1
                      ,dFecha_aplica
                      ,fDiasDif
                      ,fValor1
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

       if NOT Result then
          exit;
     end
     else // Si fecha hasta viene en blanco busco tasa a fecha desde
     begin
        leer_valor_cambio2(RegParamMargen.Tasa_Base_1,
                           RegParamMargen.Tasa_Base_1,
                           'BC',
                           dFecha_aplica,
                           fValor1,
                           Result);
       if NOT Result then
          exit;
     end;
  End;

  if (RegParamMargen.Cod_Valor2 = 'TIRREFER') then
  Begin
     if RegParamMargen.Periodo_Aplica_D_2 <> '' Then
     Begin
         // Obtengo Fecha menor para busqueda de tasas por tramo
         Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_D_2
                          ,Reg_Fechas
                          ,dFechaDesde
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);

         if NOT Result then
            exit;
     end;

     if RegParamMargen.Periodo_Aplica_H_2 <> '' Then
     Begin
     // Obtengo Fecha mayor para busqueda de tasas por tramo
       Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_H_2
                        ,Reg_Fechas
                        ,dFechaHasta
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

       if NOT Result then
          exit;

       if sValorizacion_Proceso = 'SI' then
          Obtener_Tasa_base_Mem(RegParamMargen.Tasa_Base_2
                               ,iDiasBaseTasa
                               ,sTipoInteres
                               ,iBaseMensual
                               ,sTipoCalculoDias
                               ,iVigenciaValor
                               ,iVigenciaMeses
                               ,sPais_Tasa
                               ,sModulo_err
                               ,sString_err
                               ,Result)
       else
          Obtener_Tasa_base(RegParamMargen.Tasa_Base_2
                           ,iDiasBaseTasa
                           ,sTipoInteres
                           ,iBaseMensual
                           ,sTipoCalculoDias
                           ,iVigenciaValor
                           ,iVigenciaMeses
                           ,sPais_Tasa
                           ,sModulo_err
                           ,sString_err
                           ,Result);

       if NOT Result then
          exit;

       Calculo_de_dias(dFechaDesde,
                       dFechaHasta,
                       sTipoCalculoDias,
                       sPais_Tasa,
                       fDiasDif,
                       fAnosEnteros,
                       fAnosFraccion,
                       fMesesEnteros);

       Lee_Tasa_Tramos(RegParamMargen.Tasa_Base_2
                      ,RegParamMargen.Interpolacion_2
                      ,dFecha_aplica
                      ,fDiasDif
                      ,fValor2
                      ,sModulo_Err
                      ,sString_Err
                      ,Result);

       if NOT Result then
          exit;
     end
     else // Si fecha hasta viene en blanco busco tasa a fecha desde
     begin
        leer_valor_cambio2(RegParamMargen.Tasa_Base_2,
                           RegParamMargen.Tasa_Base_2,
                           'BC',
                           dFecha_aplica,
                           fValor2,
                           Result);
       if NOT Result then
          exit;
     end;
  End;

/// OPERACION
  if RegParamMargen.Operacion <> '' then
    aplica_operacion(fValor1
                    ,fValor2
                    ,RegParamMargen.Operacion
                    ,100
                    ,RegParamMargen.Redondeo_Truncado
                    ,RegParamMargen.Numero_Decimales
                    ,fTasa_Descuento
                    ,sModulo_err
                    ,sString_err
                    ,Result)
  else
    fTasa_Descuento := fValor1;


  if NOT Result then
     exit;

  iCupon := 1;
  While (iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon) do
  begin
      //Aplico a la Tasa la descripción de los flujos SI ES FLOTANTE
      // y es indicado en el margen
      if (RegDes.Tasa_Flotante = 'S') and
         (Array_Mem_Desarr[iCupon].Fecha_Vcto >= Reg_Fechas.Fecha_Calculo) and
         (RegParamMargen.Aplica_Flujo_1 = 'S') then
      begin
         if sValorizacion_Proceso = 'SI' then
            Leer_MonRedon_Mem(RegParamMargen.Tasa_Base_1
                             ,Reg_Fechas.Fecha_Calculo
                             ,sTipo_Ajuste
                             ,iDecimales_Redondeo)
         else
            Leer_MonRedon(RegParamMargen.Tasa_Base_1
                         ,Reg_Fechas.Fecha_Calculo
                         ,sTipo_Ajuste
                         ,iDecimales_Redondeo);


         if sValorizacion_Proceso = 'SI' then
            Obtener_Base_Conversion_Mem(RegParamMargen.Tasa_Base_1 //Array_Mem_Desarr[iCupon].Tipo_Tasa
                                ,sTipo_Tasa_Flot
                                ,fPeriodo_Tasa_Flot
                                ,sAnualidad_Tasa_Flot
                                ,fBase_Porcen_Tasa_Flot
                                ,sModulo_Err
                                ,sString_Err
                                ,Result)
         else
            Obtener_Base_Conversion(RegParamMargen.Tasa_Base_1 //Array_Mem_Desarr[iCupon].Tipo_Tasa
                                ,sTipo_Tasa_Flot
                                ,fPeriodo_Tasa_Flot
                                ,sAnualidad_Tasa_Flot
                                ,fBase_Porcen_Tasa_Flot
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);
         if NOT Result then
            exit;

         aplica_operacion(fTasa_Descuento
                         ,Array_Mem_Desarr[iCupon].Tasa_Flujo
                         ,Array_Mem_Desarr[iCupon].Operacion
                         ,fBase_Porcen_Tasa_Flot
                         ,sTipo_Ajuste
                         ,iDecimales_Redondeo
                         ,fTasa_Descuento
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);

         if NOT Result then
            exit;
      end;

      Array_Mem_Desarr[iCupon].Tasa_de_Descuento := fTasa_Descuento;
      Inc(iCupon);
  end;
end;}

//------------------------------------------------------------------------------
// Fili
procedure Calcula_Tasa_Descuento(RegParamMargen       : TRegParamMargen;
                                 sTipo_Instrumento    : String;
                                 var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 sNemotecnico         : String;
                                 RegDes               : TReg_Descriptor;
                                 Reg_Fechas           : TRegistro_Fechas;
                                 fNominales_Compra    : Double;
                                 bConCupon            : Boolean;
                                 fValor_Pte_UM_Compra : Double;
                                 dTasa_Compra         : Double;
                                 fSpread              : Double;
                                 sOrigen              : String;
                                 sTipo_Valuac         : String;   //ggarcia 22-05-2013 para leer tasa mercado BR
                                 var sModulo_Err      : String;
                                 var sString_Err      : String;
                                 var Result           : Boolean);
var
  iCupon           : Integer;
  fTasa_Descuento  : Double;
  //dFechaDesde      : TDateTime;
  //dFechaHasta      : TDateTime;
  dFecha_aplica_1  : TDateTime;
  dFecha_aplica_2  : TDateTime;
  dFecha_aplica_1_Ant  : TDateTime;
  dFecha_aplica_2_Ant  : TDateTime;

  dFechaDesde_Periodo_1: TDateTime;
  dFechaHasta_Periodo_1: TDateTime;
  dFechaDesde_Periodo_2: TDateTime;
  dFechaHasta_Periodo_2: TDateTime;

  dFechaDesde_Periodo_1_Ant: TDateTime;
  dFechaHasta_Periodo_1_Ant: TDateTime;
  dFechaDesde_Periodo_2_Ant: TDateTime;
  dFechaHasta_Periodo_2_Ant: TDateTime;

  iDiasBaseTasa    : Integer;
  sTipoInteres,
  sPais_Tasa       : String;
  iBaseMensual     : Integer;
  sTipoCalculoDias : String;
  iVigenciaValor   : Integer;
  iVigenciaMeses   : Integer;
  fDiasDif         : Double;
  fAnosEnteros     : Double;
  fAnosFraccion    : Double;
  fMesesEnteros    : Double;
  fValor_Tasa1      : Double;
  fValor_Tasa2      : Double;
  sTipo_Ajuste,
  sTipo_Tasa_Flot,
  sAnualidad_Tasa_Flot : String;
  iDecimales_Redondeo  : Integer;
  fPeriodo_Tasa_Flot,
  fBase_Porcen_Tasa_Flot : Double;


  sTipo_Tasa_Flot_1        : String;
  sAnualidad_Tasa_Flot_1   : String;
  fPeriodo_Tasa_Flot_1     : Double;
  fBase_Porcen_Tasa_Flot_1 : Double;
  sTipo_Tasa_Flot_2        : String;
  sAnualidad_Tasa_Flot_2   : String;
  fPeriodo_Tasa_Flot_2     : Double;
  fBase_Porcen_Tasa_Flot_2 : Double;
  fValor1,
  fValor2           : Double;
  sOperacion_Spread : String;
  fValor_Spread     : Double;
  bResultTasa       : Boolean;

  fDias_Plazo       : Double;

  Reg_Val_In           : TRegistro_Valoriza_In;
  Reg_Val_Out          : TRegistro_Valoriza_Out;
  fDuration            : Double;
  fDuracion_Modificada : Double;
  fConvexidad          : Double;

  sTipo_Tasa           : String;

  fSaldo_Insoluto_Sin_Rea : Double;
  fSaldo_Insoluto         : Double;

  //dFecha_aplica

  bTasa_distinta_cupones : Boolean;

begin
  iCupon := 1;
  dFecha_aplica_1_Ant       := 0;
  dFecha_aplica_2_Ant       := 0;
  dFecha_aplica_1           := 0;
  dFecha_aplica_2           := 0;
  dFechaDesde_Periodo_1_Ant := 0;
  dFechaHasta_Periodo_1_Ant := 0;
  dFechaDesde_Periodo_2_Ant := 0;
  dFechaHasta_Periodo_2_Ant := 0;


  //ggarcia 09-05-2022
  if Transaccion_Implica_mem(sEmpresa_Usuario,'TASA_FPROC') then
     Reg_Fechas.Fecha_Calculo := Reg_Fechas.Fecha_Calculo_Original;
//  While (iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon) do
  While (iCupon <= Max_Nro_Cupones) do  begin
      if (Array_Mem_Desarr[iCupon].Fecha_Vcto < Reg_Fechas.Fecha_Calculo) then
      begin
        Array_Mem_Desarr[iCupon].Tasa_de_Descuento := 0;
        Array_Mem_Desarr[iCupon].Valor_Tasa_Descuento := 0;
        inc(iCupon);
        Continue;
      end;

      Reg_fechas.Fecha_Inic_Periodo := Array_mem_desarr[iCupon].Fecha_Vcto_Anterior;
      Reg_fechas.Fecha_Vcto_Periodo := Array_mem_desarr[iCupon].Fecha_Vcto;

      if RegParamMargen.Fecha_Aplica_1 <> '' Then Begin
         Tratamiento_Fecha(RegParamMargen.Fecha_Aplica_1
                          ,Reg_Fechas
                          ,dFecha_aplica_1
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
          if NOT Result then
            exit;
      end;

      if RegParamMargen.Fecha_Aplica_2 <> '' Then Begin
         Tratamiento_Fecha(RegParamMargen.Fecha_Aplica_2
                          ,Reg_Fechas
                          ,dFecha_aplica_2
                          ,sModulo_Err
                          ,sString_Err
                          ,Result);
          if NOT Result then
            exit;
      end;

      // 23/04/2014. Se debe diferenciar si las fechas referencia cambian dependiendo del cupon, ya que en ese caso se tendra que repetir
      // la busqueda de la tasa de descuento por cada uno de los cupones

      bTasa_distinta_cupones := False;
      if RegParamMargen.Fecha_Aplica_1 <> '' then
        if (dFecha_aplica_1 <> dFecha_aplica_1_Ant) then
           bTasa_distinta_cupones := True;

      if NOT bTasa_distinta_cupones then
         if RegParamMargen.Fecha_Aplica_2 <> '' then
           if (dFecha_aplica_2 <> dFecha_aplica_2_Ant) then
              bTasa_distinta_cupones := True;

      // Fechas por rango
      if NOT bTasa_distinta_cupones then
         if (RegParamMargen.Cod_Valor1 = 'TIRREFER') then
            if (RegParamMargen.Periodo_Aplica_D_1 <> '') then
               if (dFechaDesde_Periodo_1 <> dFechaDesde_Periodo_1_Ant) then
                  bTasa_distinta_cupones := True;

      if NOT bTasa_distinta_cupones then
         if (RegParamMargen.Cod_Valor1 = 'TIRREFER') then
            if (RegParamMargen.Periodo_Aplica_D_1 <> '') then
               if (dFechaHasta_Periodo_1 <> dFechaHasta_Periodo_1_Ant) then
                  bTasa_distinta_cupones := True;

      if NOT bTasa_distinta_cupones then
         if (RegParamMargen.Cod_Valor2 = 'TIRREFER') then
            if (RegParamMargen.Periodo_Aplica_D_2 <> '') then
               if (dFechaDesde_Periodo_2 <> dFechaDesde_Periodo_2_Ant) then
                  bTasa_distinta_cupones := True;

      if NOT bTasa_distinta_cupones then
         if (RegParamMargen.Cod_Valor2 = 'TIRREFER') then
            if (RegParamMargen.Periodo_Aplica_D_2 <> '') then
               if (dFechaHasta_Periodo_2 <> dFechaHasta_Periodo_2_Ant) then
                  bTasa_distinta_cupones := True;

      dFecha_aplica_1_Ant       := dFecha_aplica_1;
      dFecha_aplica_2_Ant       := dFecha_aplica_2;
      dFechaDesde_Periodo_1_Ant := dFechaDesde_Periodo_1;
      dFechaHasta_Periodo_1_Ant := dFechaHasta_Periodo_1;
      dFechaDesde_Periodo_2_Ant := dFechaDesde_Periodo_2;
      dFechaHasta_Periodo_2_Ant := dFechaHasta_Periodo_2;

      if bTasa_distinta_cupones then
      begin

           fTasa_Descuento := 0;

           if (RegParamMargen.Cod_Valor1 = 'TIREMI') then
              fValor1 := RegDes.TASA_EFECTIVA;

           if (RegParamMargen.Cod_Valor2 = 'TIREMI') then
              fValor2 := RegDes.TASA_EFECTIVA;

           if (RegParamMargen.Cod_Valor1 = 'TIRCOMP') then
              fValor1 := dTasa_Compra;

           if (RegParamMargen.Cod_Valor2 = 'TIRCOMP') then
              fValor2 := dTasa_Compra;

           if (RegParamMargen.Cod_Valor1 = 'CONSTANTE') then
              fValor1 := RegParamMargen.Constante_1;

           if (RegParamMargen.Cod_Valor1 = 'SPREAD_OPE') then
              fValor1 := fSpread;

           if (RegParamMargen.Cod_Valor2 = 'SPREAD_OPE') then
              fValor2 := fSpread;


           if (RegParamMargen.Cod_Valor2 = 'CONSTANTE') then
              fValor2 := RegParamMargen.Constante_2;

           if (RegParamMargen.Cod_Valor1 = 'TIRMERC') or
              (RegParamMargen.Cod_Valor1 = 'BRTASAMERC') or
              (RegParamMargen.Cod_Valor1 = 'TASAMERC'  ) then
           begin

               if RegParamMargen.Fecha_Aplica_1 = 'VALORFECHA' then // LOBO
               begin
                  // Se incopora la condición de cuando viene 'BRTASAMERC' llame sin tipo_instrumento = 'B' de tal manera que no lea la TIRMRA   E.S. &F.I. 22-03-2016
                  if (RegParamMargen.Cod_Valor1 = 'BRTASAMERC') then
                     fValor1 := Lee_tasa_mercado_a_Fecha( sNemotecnico
                                                         ,''
                                                         ,Reg_Fechas.Fecha_Parametro
                                                         ,sOrigen
                                                         )
                  else
                    fValor1 := Lee_tasa_mercado_a_Fecha( sNemotecnico
                                                        ,sTipo_Instrumento
                                                        ,Reg_Fechas.Fecha_Parametro
                                                        ,sOrigen
                                                        );
                 if fValor1 = 0 then
                    fValor1 := dTasa_Compra;

                 fTasa_Descuento := fValor1;
               end
               else
               begin
                   bResultTasa:= lee_tasa_mercado( sNemotecnico
                                                  ,sTipo_Instrumento
                                                  ,RegDes.Codigo_Instrumento
                                                  ,Reg_Fechas
                                                  ,sTipo_Valuac // ''  //ggarcia 22-05-2013 para leer tasa mercado BR
                                                  ,dFecha_aplica_1
                                                  // ,Reg_Fechas.Fecha_Calculo // Se cambio a la fecha indicada en el margen (FI 28/12/2004)
                                                  ,sOrigen
                                                  ,fValor1
                                                  ,sTipo_Tasa);
                  if bResultTasa = false then
                  begin
                     sModulo_Err := 'Tasa Descuento';
                     sString_Err := RegParamMargen.Cod_Valor1+': No se encontró Tasa de Mercado para :'
                                     +' Nemotecnico : '+sNemotecnico+''
                                     +' Con Fecha   : '+DatetoStr(Reg_Fechas.Fecha_Calculo);
                     Result := False;
                     exit;
                  end;
               end;
           end;

           if (RegParamMargen.Cod_Valor2 = 'TIRMERC') or
              (RegParamMargen.Cod_Valor2 = 'BRTASAMERC') or
              (RegParamMargen.Cod_Valor2 = 'TASAMERC'  ) then
           begin
               if RegParamMargen.Fecha_Aplica_2 = 'VALORFECHA' then // LOBO
               begin
                  // Se incopora la condición de cuando viene 'BRTASAMERC' llame sin tipo_instrumento = 'B' de tal manera que no lea la TIRMRA   E.S. &F.I. 22-03-2016
                  if (RegParamMargen.Cod_Valor2 = 'BRTASAMERC') then
                      fValor2 := Lee_tasa_mercado_a_Fecha( sNemotecnico
                                                          ,''
                                                          ,Reg_Fechas.Fecha_Parametro
                                                          ,sOrigen
                                                          )
                  else
                      fValor2 := Lee_tasa_mercado_a_Fecha( sNemotecnico
                                                          ,sTipo_Instrumento
                                                          ,Reg_Fechas.Fecha_Parametro
                                                          ,sOrigen
                                                          );
                 if fValor2 = 0 then
                    fValor2 := dTasa_Compra;
               end
               else
               begin
                  bResultTasa := lee_tasa_mercado( sNemotecnico
                                                  ,sTipo_Instrumento
                                                  ,RegDes.Codigo_Instrumento
                                                  ,Reg_Fechas
                                                  ,sTipo_Valuac // ''  //ggarcia 22-05-2013 para leer tasa mercado BR
                                                  ,dFecha_aplica_2
                                                  // ,Reg_Fechas.Fecha_Calculo // Se cambio a la fecha indicada en el margen (FI 28/12/2004)
                                                  ,sOrigen
                                                  ,fValor2
                                                  ,sTipo_Tasa);
                  if bResultTasa = false then
                  begin
                     sModulo_Err := 'Tasa Descuento';
                     sString_Err := RegParamMargen.Cod_Valor2+': No se encontró Tasa de Mercado para :'
                                   +' Nemotecnico : '+sNemotecnico+''
                                   +' Con Fecha   : '+DatetoStr(Reg_Fechas.Fecha_Calculo);
                     Result := False;
                     exit;
                  end;
               end;
           end;

           if (RegParamMargen.Cod_Valor1 = 'TIRINSTRUM') then
           begin
               if RegParamMargen.Fecha_Aplica_1 = 'VALORFECHA' then // LOBO
                  fValor1 := Leer_Tasa_Instrumento( RegDes.Codigo_Instrumento,
                                                    Reg_Fechas.Fecha_Parametro,
                                                    Reg_Fechas.Fecha_Vencimiento,
                                                    sOrigen,
                                                    sTipo_Tasa)
               else
                  fValor1 := Leer_Tasa_Instrumento( RegDes.Codigo_Instrumento,
                                                    Reg_Fechas.Fecha_Calculo,
                                                    Reg_Fechas.Fecha_Vencimiento,
                                                    sOrigen,
                                                    sTipo_Tasa);

               if fValor1 = 0 then
               begin
                  sModulo_Err := 'Tasa Descuento';
                  sString_Err := RegParamMargen.Cod_Valor1+': No se encontró Tasa por Instrumento para :'
                                  +' Instrumento : '+RegDes.Codigo_Instrumento+''
                                  +' Nemotecnico : '+sNemotecnico+''
                                  +' Con Fecha   : '+DatetoStr(Reg_Fechas.Fecha_Calculo);
                  Result := False;
                  exit;
               end;
               fTasa_Descuento := fValor1;
           End;

           if (RegParamMargen.Cod_Valor2 = 'TIRINSTRUM') then
           begin
               if RegParamMargen.Fecha_Aplica_2 = 'VALORFECHA' then // LOBO
                  fValor2 := Leer_Tasa_Instrumento( RegDes.Codigo_Instrumento,
                                                    Reg_Fechas.Fecha_Parametro,
                                                    Reg_Fechas.Fecha_Vencimiento,
                                                    sOrigen,
                                                    sTipo_Tasa)
               else
                  fValor2 := Leer_Tasa_Instrumento( RegDes.Codigo_Instrumento,
                                                    Reg_Fechas.Fecha_Calculo,
                                                    Reg_Fechas.Fecha_Vencimiento,
                                                    sOrigen,
                                                    sTipo_Tasa);
               if fValor2 = 0 then
               begin
                  sModulo_Err := 'Tasa Descuento';
                  sString_Err := RegParamMargen.Cod_Valor2+': No se encontró Tasa por Instrumento para :'
                                  +' Instrumento : '+RegDes.Codigo_Instrumento+''
                                  +' Nemotecnico : '+sNemotecnico+''
                                  +' Con Fecha   : '+DatetoStr(Reg_Fechas.Fecha_Calculo);
                  Result := False;
                  exit;
               end;
           End;

           // GGARCIA 06-07-2010
           if (RegParamMargen.Cod_Valor1 = 'TASA') then
           begin
              fValor_Tasa1 := 0;
              leer_valor_cambio2(RegParamMargen.Tasa_Base_1
                                ,RegParamMargen.Tasa_Base_1
                                ,'BC'
                                ,dFecha_aplica_1
                                ,fValor_Tasa1
                                ,Result);
              if NOT Result then
              begin
                  sModulo_Err := 'Tasa Descuento';
                  sString_Err := RegParamMargen.Cod_Valor1+': No se encontró Tasa :'
                                  +''''+RegParamMargen.Tasa_Base_1+''''
                                  +' Con Fecha   : '+DatetoStr(dFecha_aplica_1);
                  exit;
              end;

              fValor1 := fValor_Tasa1;
              fTasa_Descuento := fValor1;
           end;

           // GGARCIA 06-07-2010
           if (RegParamMargen.Cod_Valor2 = 'TASA') then
           begin
              fValor_Tasa2 := 0;
              leer_valor_cambio2(RegParamMargen.Tasa_Base_2
                                ,RegParamMargen.Tasa_Base_2
                                ,'BC'
                                ,dFecha_aplica_2
                                ,fValor_Tasa2
                                ,Result);
              if NOT Result then
              begin
                  sModulo_Err := 'Tasa Descuento';
                  sString_Err := RegParamMargen.Cod_Valor2+': No se encontró Tasa :'
                                  +''''+RegParamMargen.Tasa_Base_2+''''
                                  +' Con Fecha   : '+DatetoStr(dFecha_aplica_2);
                  exit;
              end;

              fValor2 := fValor_Tasa2;
           end;


           // GGARCIA 28-10-2010
           if (RegParamMargen.Cod_Valor1 = 'TIRPLANEM') then
           begin

              fDias_Plazo := (Reg_Fechas.Fecha_Vencimiento - Reg_Fechas.Fecha_Calculo);  //Plazo al Vcto.

              fValor_Tasa1 := 0;
              Lee_Valores_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,'T'
                                ,sNemotecnico
                                ,dFecha_aplica_1
                                ,fDias_Plazo
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);
               if NOT Result then
                  exit;

               fValor1 := fValor_Tasa1;
               fTasa_Descuento := fValor1;
           end;

           // GGARCIA 28-10-2010
           if (RegParamMargen.Cod_Valor2 = 'TIRPLANEM') then
           begin

              fDias_Plazo := (Reg_Fechas.Fecha_Vencimiento - Reg_Fechas.Fecha_Calculo);   //Plazo al Vcto.

              fValor_Tasa2 := 0;
              Lee_Valores_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,'T'
                                ,sNemotecnico
                                ,dFecha_aplica_2
                                ,fDias_Plazo
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);

              if NOT Result then
                 exit;

              fValor2 := fValor_Tasa2;
           end;

           // GGARCIA 28-10-2010
           if (RegParamMargen.Cod_Valor1 = 'PREPLANEM') then
           begin

              fDias_Plazo := (Reg_Fechas.Fecha_Vencimiento - Reg_Fechas.Fecha_Calculo);  //Plazo al Vcto.

              fValor_Tasa1 := 0;
              Lee_Valores_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,'T'
                                ,sNemotecnico
                                ,dFecha_aplica_1
                                ,fDias_Plazo
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);
               if NOT Result then
                  exit;

               fValor1 := fValor_Tasa1;
               fTasa_Descuento := fValor1;
           end;

           // GGARCIA 28-10-2010
           if (RegParamMargen.Cod_Valor2 = 'PREPLANEM') then
           begin

              fDias_Plazo := (Reg_Fechas.Fecha_Vencimiento - Reg_Fechas.Fecha_Calculo);   //Plazo al Vcto.

              fValor_Tasa2 := 0;
              Lee_Valores_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,'T'
                                ,sNemotecnico
                                ,dFecha_aplica_2
                                ,fDias_Plazo
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);

              if NOT Result then
                 exit;

              fValor2 := fValor_Tasa2;
           end;


           if (RegParamMargen.Cod_Valor1 = 'TIRREFER') then
           Begin
              if RegParamMargen.Periodo_Aplica_D_1 <> '' Then
              Begin
                  // Obtengo Fecha menor para busqueda de tasas por tramo
                  Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_D_1
                                   ,Reg_Fechas
                                   ,dFechaDesde_Periodo_1
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);
                  if NOT Result then
                     exit;

                  // Obtengo Fecha mayor para busqueda de tasas por tramo
                  Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_H_1
                                   ,Reg_Fechas
                                   ,dFechaHasta_Periodo_1
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);

                  if NOT Result then
                     exit;

                  if sValorizacion_Proceso = 'SI' then
                     Obtener_Tasa_base_Mem(RegParamMargen.Tasa_Base_1
                                   ,iDiasBaseTasa
                                   ,sTipoInteres
                                   ,iBaseMensual
                                   ,sTipoCalculoDias
                                   ,iVigenciaValor
                                   ,iVigenciaMeses
                                   ,sPais_Tasa
                                   ,sModulo_err
                                   ,sString_err
                                   ,Result)
                  else
                     Obtener_Tasa_base(RegParamMargen.Tasa_Base_1
                                   ,iDiasBaseTasa
                                   ,sTipoInteres
                                   ,iBaseMensual
                                   ,sTipoCalculoDias
                                   ,iVigenciaValor
                                   ,iVigenciaMeses
                                   ,sPais_Tasa
                                   ,sModulo_err
                                   ,sString_err
                                   ,Result);

                  if NOT Result then
                     exit;

                  Calculo_de_dias(dFechaDesde_Periodo_1,
                                  dFechaHasta_Periodo_1,
                                  sTipoCalculoDias,
                                  sPais_Tasa,
                                  fDiasDif,
                                  fAnosEnteros,
                                  fAnosFraccion,
                                  fMesesEnteros);
              End;

              fValor_Tasa1 := 0;
              if fDiasDif > 0 then // Lo hicimos ya que faltando cero dias al vencimiento no requiere descontar nada y daba errpr al no encontrar tasa GG & FI 12-12-13
                 Lee_Tasa_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                 ,dFecha_aplica_1
                                 ,fDiasDif
                                 ,True
                                 ,fValor_Tasa1
                                 ,fValor_Tasa2
                                 ,sModulo_Err
                                 ,sString_Err
                                 ,Result);
               if NOT Result then
                  exit;

               fValor1 := fValor_Tasa1;
               fTasa_Descuento := fValor1;
           end; // if 'TIRREFER'

           if (RegParamMargen.Cod_Valor1 = 'SPREAD') then
           begin
              // si codigo 2 me indica Spread debe buscarlo y aplicarlo a la primera Tasa
              //
              Determina_Spread_Emisor_Instrumento_Mem( RegDes.CODIGO_EMISOR
                                                      ,RegDes.CODIGO_Instrumento
                                                      //,sOperacion_Spread
                                                      ,fValor_Spread
                                                      );
               //if (Trim(sOperacion_Spread) <> '') and
               if (fValor_Spread <> 0)            then
               begin
                  fValor1 := fValor_Spread;
                  {
                  aplica_operacion(fValor1
                                  ,fValor_Spread //RegParamMargen.constante_2
                                  ,sOperacion_Spread
                                  ,100
                                  ,'' // Redondeo_Truncado
                                  ,0  // Numero_Decimales
                                  ,fTasa_Descuento
                                  ,sModulo_err
                                  ,sString_err
                                  ,Result
                                  );
                 if NOT Result then
                    exit;
                 }
               end;
           end;


           if (RegParamMargen.Cod_Valor2 = 'SPREAD') then
           begin
              // si codigo 2 me indica Spread debe buscarlo y aplicarlo a la primera Tasa
              Determina_Spread_Emisor_Instrumento_Mem( RegDes.CODIGO_EMISOR
                                                      ,RegDes.CODIGO_Instrumento
                                                      //,sOperacion_Spread
                                                      ,fValor_Spread
                                                      );
               //if (Trim(sOperacion_Spread) <> '') and
               if   (fValor_Spread <> 0)            then
               begin
                  fValor2 := fValor_Spread;
                  {
                  aplica_operacion(fValor1
                                  ,fValor_Spread //RegParamMargen.constante_2
                                  ,sOperacion_Spread
                                  ,100
                                  ,'' // Redondeo_Truncado
                                  ,0  // Numero_Decimales
                                  ,fTasa_Descuento
                                  ,sModulo_err
                                  ,sString_err
                                  ,Result
                                  );
                 if NOT Result then
                    exit;
                 }
               end;
           end;

           if (RegParamMargen.constante_1 <> 0 )       and
              (Trim(RegParamMargen.Operacion_1) <> '') then
           begin
              aplica_operacion(fValor1
                              ,RegParamMargen.constante_1
                              ,RegParamMargen.Operacion_1
                              ,100
                              ,RegParamMargen.Redondeo_Truncado
                              ,RegParamMargen.Numero_Decimales
                              ,fTasa_Descuento
                              ,sModulo_err
                              ,sString_err
                              ,Result);

             if NOT Result then
                exit;

             fValor1:=fTasa_Descuento;
           end;

           if (RegParamMargen.Cod_Valor2 = 'TIRREFER') then
           Begin
              if RegParamMargen.Periodo_Aplica_D_2 <> '' Then
              Begin
                  // Obtengo Fecha menor para busqueda de tasas por tramo
                  Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_D_2
                                   ,Reg_Fechas
                                   ,dFechaDesde_Periodo_2
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);

                  if NOT Result then
                     exit;

                  // Obtengo Fecha mayor para busqueda de tasas por tramo
                  Tratamiento_Fecha(RegParamMargen.Periodo_Aplica_H_2
                                   ,Reg_Fechas
                                   ,dFechaHasta_Periodo_2
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result);

                  if NOT Result then
                     exit;

                  if sValorizacion_Proceso = 'SI' then
                     Obtener_Tasa_base_Mem(RegParamMargen.Tasa_Base_2
                                   ,iDiasBaseTasa
                                   ,sTipoInteres
                                   ,iBaseMensual
                                   ,sTipoCalculoDias
                                   ,iVigenciaValor
                                   ,iVigenciaMeses
                                   ,sPais_Tasa
                                   ,sModulo_err
                                   ,sString_err
                                   ,Result)
                  else
                     Obtener_Tasa_base(RegParamMargen.Tasa_Base_2
                                   ,iDiasBaseTasa
                                   ,sTipoInteres
                                   ,iBaseMensual
                                   ,sTipoCalculoDias
                                   ,iVigenciaValor
                                   ,iVigenciaMeses
                                   ,sPais_Tasa
                                   ,sModulo_err
                                   ,sString_err
                                   ,Result);

                  if NOT Result then
                     exit;

                  Calculo_de_dias(dFechaDesde_Periodo_2,
                                  dFechaHasta_Periodo_2,
                                  sTipoCalculoDias,
                                  sPais_Tasa,
                                  fDiasDif,
                                  fAnosEnteros,
                                  fAnosFraccion,
                                  fMesesEnteros);
              End;

              fValor_Tasa2 := 0;
              if fDiasDif > 0 then // Lo hicimos ya que faltando cero dias al vencimiento no requiere descontar nada y daba errpr al no encontrar tasa GG & FI 12-12-13
                 Lee_Tasa_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,dFecha_aplica_2
                                ,fDiasDif
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);

              if NOT Result then
                 exit;

              fValor2 := fValor_Tasa2;
           end; // If 'TIRREFER'


           // ggarcia 12-2010
           if (RegParamMargen.Cod_Valor1 = 'TIRDURA') or
              (RegParamMargen.Cod_Valor1 = 'TIRDURMOD') then
           begin
              Reg_Val_In.Descriptor_Cargado   := 'NO';
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
              Calculo_Duration(RegDes.Codigo_Emisor
                              ,RegDes.Codigo_Instrumento
                              ,RegDes.Serie
                              ,sNemotecnico
                              ,sTipo_Instrumento
                              ,Reg_Fechas.Fecha_Emision
                              ,Reg_Fechas.Fecha_Vencimiento
                              ,Reg_Fechas.Fecha_Calculo
                              ,fNominales_Compra
                              ,dTasa_Compra
                              ,RegDes.Tasa_Emision
                              ,RegDes.Unidad_Mon
                              ,Reg_Val_In
                              ,Reg_Val_Out
                              ,fDuration
                              ,fDuracion_Modificada
                              ,fConvexidad
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
              if NOT Result then
                 exit;

              fValor_Tasa1 := 0;
              if RegParamMargen.Cod_Valor1 = 'TIRDURA' then
                 Lee_Tasa_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,dFecha_aplica_1
                                ,fDuration
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result)
              else
                 Lee_Tasa_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,dFecha_aplica_1
                                ,fDuracion_Modificada
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);
               if NOT Result then
                  exit;

               fValor1 := fValor_Tasa1;
               fTasa_Descuento := fValor1;
           end; // if 'TIRDURA'


             // ggarcia 12-2010
           if (RegParamMargen.Cod_Valor2 = 'TIRDURA') or
              (RegParamMargen.Cod_Valor2 = 'TIRDURMOD') then
           begin
              Reg_Val_In.Descriptor_Cargado   := 'NO';
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
              Calculo_Duration(RegDes.Codigo_Emisor
                              ,RegDes.Codigo_Instrumento
                              ,RegDes.Serie
                              ,sNemotecnico
                              ,sTipo_Instrumento
                              ,Reg_Fechas.Fecha_Emision
                              ,Reg_Fechas.Fecha_Vencimiento
                              ,Reg_Fechas.Fecha_Calculo
                              ,fNominales_Compra
                              ,dTasa_Compra
                              ,RegDes.Tasa_Emision
                              ,RegDes.Unidad_Mon
                              ,Reg_Val_In
                              ,Reg_Val_Out
                              ,fDuration
                              ,fDuracion_Modificada
                              ,fConvexidad
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
              if NOT Result then
                 exit;

              fValor_Tasa1 := 0;
              if RegParamMargen.Cod_Valor1 = 'TIRDURA' then
                 Lee_Tasa_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,dFecha_aplica_2
                                ,fDuration
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result)
              else
                 Lee_Tasa_Tramos(RegParamMargen // ANTES RegParamMargen.Tasa_Base
                                ,dFecha_aplica_2
                                ,fDuracion_Modificada
                                ,True
                                ,fValor_Tasa1
                                ,fValor_Tasa2
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);
               if NOT Result then
                  exit;

               fValor2 := fValor_Tasa2;
           end; // if 'TIRDURA'

           // ggarcia 15-03-2012
           if (RegParamMargen.Cod_Valor1 = 'TIRCAPRES') then
           begin
              Reg_Val_In.Descriptor_Cargado   := 'NO';
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
              Saldo_Insoluto(sTipo_Instrumento
                            ,RegDes
                            ,Reg_Fechas.Fecha_Emision
                            ,Reg_Fechas.Fecha_Calculo
                            ,Reg_Fechas.Fecha_Compra   //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                            ,fNominales_Compra
                            ,Array_Mem_Desarr
                            ,Reg_Val_In.Con_Cupon // False
                            ,fSaldo_Insoluto_Sin_Rea
                            ,fSaldo_Insoluto
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
              if NOT Result then
                 exit;

              fValor_Tasa1 := 0;
              Lee_Tasa_CapRes(RegDes.Codigo_Instrumento
                             ,RegDes.Unidad_Mon
                             ,dFecha_aplica_1
                             ,fSaldo_Insoluto
                             ,fValor_Tasa1
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
               if NOT Result then
                  exit;

               fValor1 := fValor_Tasa1;
               fTasa_Descuento := fValor1;
           end; // if 'TIRCAPRES'

           // ggarcia 15-03-2012
           if (RegParamMargen.Cod_Valor2 = 'TIRCAPRES') then
           begin
              Reg_Val_In.Descriptor_Cargado   := 'NO';
              Reg_Val_In.Tabla_Desarr_Cargada := 'NO';
              Saldo_Insoluto(sTipo_Instrumento
                            ,RegDes
                            ,Reg_Fechas.Fecha_Emision
                            ,Reg_Fechas.Fecha_Calculo
                            ,Reg_Fechas.Fecha_Compra    //ggarcia 09-06-2015 caso nemotecnico con definicion excepcion variacion cambiaria, tratamiento de fecha FECOPE-1M
                            ,fNominales_Compra
                            ,Array_Mem_Desarr
                            ,Reg_Val_In.Con_Cupon // False
                            ,fSaldo_Insoluto_Sin_Rea
                            ,fSaldo_Insoluto
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
              if NOT Result then
                 exit;

              fValor_Tasa1 := 0;
              Lee_Tasa_CapRes(RegDes.Codigo_Instrumento
                             ,RegDes.Unidad_Mon
                             ,dFecha_aplica_2
                             ,fSaldo_Insoluto
                             ,fValor_Tasa2
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
               if NOT Result then
                  exit;

               fValor2 := fValor_Tasa2;
           end; // if 'TIRCAPRES'


           if (RegParamMargen.constante_2 <> 0 )       and
              (Trim(RegParamMargen.Operacion_2) <> '') then
           begin
                aplica_operacion(fValor2
                                ,RegParamMargen.constante_2
                                ,RegParamMargen.Operacion_2
                                ,100
                                ,RegParamMargen.Redondeo_Truncado
                                ,RegParamMargen.Numero_Decimales
                                ,fTasa_Descuento
                                ,sModulo_err
                                ,sString_err
                                ,Result);

               if NOT Result then
                  exit;
               fValor2:=fTasa_Descuento;
           end;

           if RegParamMargen.Tasa_Conversion_1 <> '' then
           Begin
              if sValorizacion_Proceso = 'SI' then
                 Obtener_Base_Conversion_Mem(RegParamMargen.Tasa_Base_1
                                            ,sTipo_Tasa_Flot_1
                                            ,fPeriodo_Tasa_Flot_1
                                            ,sAnualidad_Tasa_Flot_1
                                            ,fBase_Porcen_Tasa_Flot_1
                                            ,sModulo_Err
                                            ,sString_Err
                                            ,Result)
              else
                 Obtener_Base_Conversion(RegParamMargen.Tasa_Base_1
                                        ,sTipo_Tasa_Flot_1
                                        ,fPeriodo_Tasa_Flot_1
                                        ,sAnualidad_Tasa_Flot_1
                                        ,fBase_Porcen_Tasa_Flot_1
                                        ,sModulo_Err
                                        ,sString_Err
                                        ,Result);
              if NOT Result then
                 exit;

              if sValorizacion_Proceso = 'SI' then
                 Obtener_Base_Conversion_Mem(RegParamMargen.Tasa_Conversion_1
                                            ,sTipo_Tasa_Flot_2
                                            ,fPeriodo_Tasa_Flot_2
                                            ,sAnualidad_Tasa_Flot_2
                                            ,fBase_Porcen_Tasa_Flot_2
                                            ,sModulo_Err
                                            ,sString_Err
                                            ,Result)
              else
                 Obtener_Base_Conversion(RegParamMargen.Tasa_Conversion_1
                                        ,sTipo_Tasa_Flot_2
                                        ,fPeriodo_Tasa_Flot_2
                                        ,sAnualidad_Tasa_Flot_2
                                        ,fBase_Porcen_Tasa_Flot_2
                                        ,sModulo_Err
                                        ,sString_Err
                                        ,Result);
              if NOT Result then
                 exit;

              // Convertir a
               conversion_tasas(sTipo_Tasa_Flot_1
                               ,fPeriodo_Tasa_Flot_1
                               ,sAnualidad_Tasa_Flot_1
                               ,fBase_Porcen_Tasa_Flot_1
                               ,sTipo_Tasa_Flot_2
                               ,fPeriodo_Tasa_Flot_2
                               ,''
                               ,fBase_Porcen_Tasa_Flot_2
                               ,fValor1
                               ,sModulo_Err
                               ,sString_Err
                               ,Result);

               if NOT Result then
                  exit;
               fTasa_Descuento := fValor1;
           end;

           if RegParamMargen.Tasa_Conversion_2 <> '' then
           Begin
              if sValorizacion_Proceso = 'SI' then
                 Obtener_Base_Conversion_Mem(RegParamMargen.Tasa_Base_2
                                            ,sTipo_Tasa_Flot_1
                                            ,fPeriodo_Tasa_Flot_1
                                            ,sAnualidad_Tasa_Flot_1
                                            ,fBase_Porcen_Tasa_Flot_1
                                            ,sModulo_Err
                                            ,sString_Err
                                            ,Result)
              else
                 Obtener_Base_Conversion(RegParamMargen.Tasa_Base_2
                                        ,sTipo_Tasa_Flot_1
                                        ,fPeriodo_Tasa_Flot_1
                                        ,sAnualidad_Tasa_Flot_1
                                        ,fBase_Porcen_Tasa_Flot_1
                                        ,sModulo_Err
                                        ,sString_Err
                                        ,Result);
              if NOT Result then
                 exit;

              if sValorizacion_Proceso = 'SI' then
                 Obtener_Base_Conversion_Mem(RegParamMargen.Tasa_Conversion_2
                                            ,sTipo_Tasa_Flot_2
                                            ,fPeriodo_Tasa_Flot_2
                                            ,sAnualidad_Tasa_Flot_2
                                            ,fBase_Porcen_Tasa_Flot_2
                                            ,sModulo_Err
                                            ,sString_Err
                                            ,Result)
              else
                 Obtener_Base_Conversion(RegParamMargen.Tasa_Conversion_2
                                        ,sTipo_Tasa_Flot_2
                                        ,fPeriodo_Tasa_Flot_2
                                        ,sAnualidad_Tasa_Flot_2
                                        ,fBase_Porcen_Tasa_Flot_2
                                        ,sModulo_Err
                                        ,sString_Err
                                        ,Result);
              if NOT Result then
                 exit;

              // Convertir a
              conversion_tasas(sTipo_Tasa_Flot_1
                              ,fPeriodo_Tasa_Flot_1
                              ,sAnualidad_Tasa_Flot_1
                              ,fBase_Porcen_Tasa_Flot_1
                              ,sTipo_Tasa_Flot_2
                              ,fPeriodo_Tasa_Flot_2
                              ,''
                              ,fBase_Porcen_Tasa_Flot_2
                              ,fValor2
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);

              if NOT Result then
                 exit;
              fTasa_Descuento := fValor2;
           end;

           if RegParamMargen.Operacion <> '' then
           Begin
              aplica_operacion(fValor1
                              ,fValor2
                              ,RegParamMargen.Operacion
                              ,100
                              ,RegParamMargen.Redondeo_Truncado
                              ,RegParamMargen.Numero_Decimales
                              ,fTasa_Descuento
                              ,sModulo_err
                              ,sString_err
                              ,Result);

             if NOT Result then
                exit;
           end;

       //iCupon := 1;
       //While (iCupon = Array_Mem_Desarr[iCupon].Nro_Cupon) do
       //begin
           //Aplico a la Tasa la descripción de los flujos SI ES FLOTANTE
           // y es indicado en el margen
           if (RegDes.Tasa_Flotante = 'S') and
              (Array_Mem_Desarr[iCupon].Fecha_Vcto >= Reg_Fechas.Fecha_Calculo) and
              (RegParamMargen.Aplica_Flujo_1 = 'S') then
           begin
              fTasa_Descuento := fValor_Tasa1;

              if sValorizacion_Proceso = 'SI' then
                 Leer_MonRedon_Mem(RegParamMargen.Tasa_Base_1
                                  ,Reg_Fechas.Fecha_Calculo
                                  ,sTipo_Ajuste
                                  ,iDecimales_Redondeo)
              else
                 Leer_MonRedon(RegParamMargen.Tasa_Base_1
                              ,Reg_Fechas.Fecha_Calculo
                              ,sTipo_Ajuste
                              ,iDecimales_Redondeo);


              if sValorizacion_Proceso = 'SI' then
                 Obtener_Base_Conversion_Mem(RegParamMargen.Tasa_Base_1 //Array_Mem_Desarr[iCupon].Tipo_Tasa
                                     ,sTipo_Tasa_Flot
                                     ,fPeriodo_Tasa_Flot
                                     ,sAnualidad_Tasa_Flot
                                     ,fBase_Porcen_Tasa_Flot
                                     ,sModulo_Err
                                     ,sString_Err
                                     ,Result)
              else
                 Obtener_Base_Conversion(RegParamMargen.Tasa_Base_1 //Array_Mem_Desarr[iCupon].Tipo_Tasa
                                     ,sTipo_Tasa_Flot
                                     ,fPeriodo_Tasa_Flot
                                     ,sAnualidad_Tasa_Flot
                                     ,fBase_Porcen_Tasa_Flot
                                     ,sModulo_Err
                                     ,sString_Err
                                     ,Result);
              if NOT Result then
                 exit;

              aplica_operacion(fTasa_Descuento
                              ,Array_Mem_Desarr[iCupon].Tasa_Flujo
                              ,Array_Mem_Desarr[iCupon].Operacion
                              ,fBase_Porcen_Tasa_Flot
                              ,sTipo_Ajuste
                              ,iDecimales_Redondeo
                              ,fTasa_Descuento
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);

              if NOT Result then
                 exit;
           end;
           Array_Mem_Desarr[iCupon].Tasa_de_Descuento    := fTasa_Descuento;
           Array_Mem_Desarr[iCupon].Valor_Tasa_Descuento := fTasa_Descuento;    // Esta se usa para mostrarla despues de los calculos 04-03-2015
      end
      else
      // Si las tasas para cupon no van a ser distintas se le asigna a todos los cupones la misma tasa
      // caso contrario se sigue con el while de la tabla completa
      begin
         For iCupon := 1 TO Max_Nro_Cupones do
         begin
             Array_Mem_Desarr[iCupon].Tasa_de_Descuento := fTasa_Descuento;
             Array_Mem_Desarr[iCupon].Valor_Tasa_Descuento := fTasa_Descuento;
         end;

//         iCupon := Max_Nro_Cupones - 1; DC 28/07/2022
         iCupon := iCupon - 1;
      end;
      Inc(iCupon);
  end;
end;



//------------------------------------------------------------------------------
Procedure Duration_Fijo(sInstrumento   : String;
                        dFecha_Calculo : TDateTime;
                        Var fDuration  : Double;
                        Var Result         : Boolean);
Begin
  With dmFunciones_Valorizacion.Qry_Aux do
  begin
    Result := False;
    fDuration := 0;
    SQL.Clear;
    SQL.Add('SELECT *'
           +'  FROM QS_FIN_INST_DURATION'
           +' WHERE Cod_Instrumento = :Cod_Instrumento '
           );
    ParamByName('Cod_Instrumento').AsString := sInstrumento;
    Prepare;
    Open;
    If Not Eof Then
    Begin
       If Fieldbyname('Fecha_Hasta').Isnull Then
          If dFecha_Calculo >= Fieldbyname('Fecha_Desde').AsDateTime Then
             Begin
                Result := True;
                fDuration := Fieldbyname('Valor_Duration').AsFloat;
             End
       Else
          If (dFecha_Calculo >= Fieldbyname('Fecha_Desde').AsDateTime) And
             (dFecha_Calculo <= Fieldbyname('Fecha_Hasta').AsDateTime) Then
             Begin
                Result := True;
                fDuration := Fieldbyname('Valor_Duration').AsFloat;
             End;
    End;
    Close;
  end;

End;
//------------------------------------------------------------------------------
Procedure Calculo_Duration(sEmisor,
                           sInstrumento,
                           sSerie,
                           sNemotecnico,
                           sTipo_Instrumento   : String;
                           dFecha_Emision,
                           dFecha_Vencimiento,
                           dFecha_Calculo      : TDatetime;
                           fNominales,
                           fTasa_Mercado       : Double;
                           fTasa_Emision       : Double;
                           sMoneda_Instrumento : String;
                           var Reg_Val_In          : TRegistro_Valoriza_In;     //ggarcia 24-03-2015 a var por access violation
                           var Reg_Val_Out         : TRegistro_Valoriza_Out;    //ggarcia 24-03-2015 a var por access violation
                          var fDuration        : Double;
                          var fDuracion_Modificada : Double;
                          var fConvexidad      : Double;
                          var sModulo_Error    : String;
                          var sString_Error    : String;
                          var Result           : Boolean
                         ) ;
var
  RegDes            : TReg_Descriptor;
  Reg_Fechas        : TRegistro_Fechas;
  Array_Mem_Desarr  : TArray_Mem_Desarr;
  sMetodo_Sin_Tasa_Referencia,
  sTipoInteres,
  sPais_Tasa        : String;
  iNro_Cupon,
  iDiasBaseTasa,
  iBaseMensual      : Integer;
  sTipoCalculoDias  : String;
  iVigenciaValor,
  iVigenciaMeses    : Integer;
  fDias_Plazo,
  fValor_Vencimiento,
  fIntereses,
  fAmortizacion,
  fBase,
  fExponente,
  fResultado,
  fValor_Presente,
  fanos_enteros,
  fanos_fraccion,
  fmeses_enteros,
  fPeriodo_de_Pago,
  fNro_Periodos_Years,
  fDias_Emision_Vcto,
  fValor_Uno,
  fValor_Dos,
  fValor_Vencimiento_Afectado : Double;
  Resulta                     : Boolean;
  Reg_Formula_PAR             : TRegFormulaPAR;
  Reg_Formula_TIR             : TRegFormulaTIR;
begin
   Result := True;
   sModulo_Error := 'Calculo Duration ';
   Duration_Fijo_Mem(sInstrumento,
                     dFecha_Calculo,
                     fDuration,
                     Resulta
                     );
   if Resulta Then
      exit;

   if Reg_Val_In.Descriptor_Cargado <> 'SI' then
      Carga_RegDes(sTipo_Instrumento
                  ,sNemotecnico
                  ,sEmisor
                  ,sInstrumento
                  ,sSerie
                  ,Reg_Val_In.sUnidadMonetaria
                  ,fTasa_Emision
                  ,RegDes
                  ,sModulo_Error
                  ,sString_Error
                  ,Result)
   else
      RegDes := Reg_Val_Out.RegDes;


   if NOT Result then
      exit;

   Reg_Fechas.Fecha_Emision    := dFecha_Emision;
   Reg_Fechas.Fecha_Vencimiento:= dFecha_Vencimiento;
   Reg_Fechas.Fecha_Calculo    := dFecha_Calculo;
   Reg_Fechas.Fecha_Compra     := dFecha_Calculo;

   // Si Viene Tabla de Desarrollo no la cargo
   if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
   begin
      { // ggarcia 27-03-2013 no estaba cargarndo las tablas de desarrollo para instrumentos unicos
      carga_Mem_Desarr(Array_Mem_Desarr,
                       sNemotecnico,
                       RegDes,
                       Reg_Fechas,
                       sMetodo_Sin_Tasa_Referencia,
                       False, // Sin Con_Cupon,
                       True,  // Verifica Exepciones Cambiarias
                       sModulo_Error,
                       sString_Error,
                       Result );
      }
      carga_parametros_formulas_mem(RegDes.Cod_Calc_PAR_D
                                   ,RegDes.Cod_Calc_TIR_D
                                   ,Reg_Formula_PAR
                                   ,Reg_Formula_TIR
                                   ,sModulo_Error
                                   ,sString_Error
                                   ,Result
                                   );
      if not Result then // Por Ecepciones...como br
         Result := True;

      Carga_TabDesarr(sTipo_Instrumento
                     ,sEmisor
                     ,sInstrumento
                     ,sSerie
                     ,sNemotecnico
                     ,Reg_Val_In.sTipoNominales
                     ,fNominales
                     ,fTasa_Emision
                     ,dFecha_Emision
                     ,dFecha_Vencimiento
                     ,dFecha_Calculo
                     ,RegDes.Tasa_Valor_PAR
                     ,Reg_Val_In.Con_Cupon
                     ,Array_Mem_Desarr
                     ,RegDes
                     ,Reg_Fechas
                     ,sMetodo_Sin_Tasa_Referencia
                     ,Reg_Formula_PAR
                     ,sModulo_Error
                     ,sString_Error
                     ,Result);
      if Not Result then
         Exit;
   end
   else
//      Array_Mem_Desarr := Reg_Val_Out.Array_Mem_Desarr;   12-09-2022
      Array_Mem_Desarr := copy(Reg_Val_Out.Array_Mem_Desarr);

   Obtener_Tasa_base_Mem(RegDes.Tasa_Valor_Pte
                        ,iDiasBaseTasa
                        ,sTipoInteres
                        ,iBaseMensual
                        ,sTipoCalculoDias
                        ,iVigenciaValor
                        ,iVigenciaMeses
                        ,sPais_Tasa
                        ,sModulo_Error
                        ,sString_Error
                        ,Result
                        );
   if NOT Result then
   begin
      // BASE_VARIABLE
{      if iDiasBaseTasa = 0 then
      begin
         Obtener_Tasa_base_Variable(RegDes.Tasa_Valor_Pte,
                                    Reg_Fechas,
                                    RegDes,
                                    Array_Mem_Desarr,
                                    sPais_Tasa,
                                    iDiasBaseTasa,
                                    fPeriodos,
                                    sModulo_error,
                                    sString_error,
                                    Result);
      end;
 }     if Not Result then
         exit;
   end;

    // Si es Instrumento Unico Calculo Duration por fecha de vencimiento
    if (sTipo_Instrumento = 'U') or
       (sTipo_Instrumento = 'B') then
    begin
       fDias_Plazo := (dFecha_Vencimiento - dFecha_Calculo);
       if fDias_Plazo = 0 then
       begin
         fDuration := 0;
         exit;
       end;
       fDuration   := fDias_Plazo / (StrToFloat('365'+FormatSettings.DecimalSeparator+'25'));

       if (fTasa_Mercado <= 0) or
          (Reg_Val_In.Tasa_Compra = 0) then //Fué comprado con tada CERO
       begin
          fDuration     := fDias_Plazo / (StrToFloat('365'+FormatSettings.DecimalSeparator+'25'));
          fDuracion_Modificada := fDias_Plazo / (StrToFloat('365'+FormatSettings.DecimalSeparator+'25'));
          fConvexidad   := 0;
          Exit;
       end;

       //Calculo Duracion Modificada
       fDias_Emision_Vcto  := (dFecha_Vencimiento - dFecha_Emision);
       if fDias_Emision_Vcto <> 0 then
          fNro_Periodos_Years := iDiasBaseTasa/fDias_Emision_Vcto
       else
          sString_Error := 'Dias Entre Emisión y Vencimiento es Cero (Duración Modificada)';

       if fNro_Periodos_Years <= 1 then
          fNro_Periodos_Years := 1;

       try
          fDuracion_Modificada := fDuration/(1+(fTasa_Mercado/100/fNro_Periodos_Years));

          fPeriodo_de_Pago     := iDiasBaseTasa/(fDias_Plazo);
          fValor_Vencimiento   := Array_Mem_Desarr[1].Valor_Cupon;

          fValor_Vencimiento_Afectado := fValor_Vencimiento/Power(1+fTasa_Mercado/100,fPeriodo_de_Pago);

          fValor_Uno := 1/ Power(1+fTasa_Mercado/100,2);
          fValor_Dos := (fValor_Vencimiento_Afectado * 2 )/
                        (fNro_Periodos_Years*fNro_Periodos_Years*fValor_Vencimiento_Afectado);

          fConvexidad := fValor_Uno * fValor_Dos;
       except
          begin
              fDuration            := 0;
              fDuracion_Modificada := 0;
              fConvexidad          := 0;
          end;
       end;      
       Result      := True;
       Exit;
    end;

   if RegDes.Periodo_Pago = 0 then
   begin
      sModulo_Error := 'Cálculo de Duración Modificada/Convexidad :';
      sString_Error := 'Período de Pago en Descriptor es Cero'
                      +' Nemotécnico : '+sNemotecnico;
      Result        := False;
      Exit;
   end;

   // Ahora recorro la tabla de desarrollo para buscar los vencimientos
   fValor_Presente:= 0;
   fDuration      := 0;
   fConvexidad    := 0;
//   fAcum_Cupon_Descontado := 0;
//   iNro_Cupon     := 1;

   try
       for iNro_Cupon := 1 to Max_Nro_Cupones do
       begin
//          fValor_Vencimiento := 0;
//          fIntereses         := 0;
//          fAmortizacion      := 0;
          if Array_Mem_Desarr[iNro_Cupon].Fecha_Vcto >= dFecha_Calculo then
          begin
            fIntereses        := Array_Mem_Desarr[iNro_Cupon].Interes
                                 * fNominales/RegDes.Base_Conversion;
            fAmortizacion     := Array_Mem_Desarr[iNro_Cupon].Amortizacion
                                 * fNominales/RegDes.Base_Conversion;

            fValor_Vencimiento:= (fIntereses + fAmortizacion);

            Calculo_de_dias(dFecha_Calculo,
                            Array_Mem_Desarr[iNro_Cupon].Fecha_Vcto,
                            sTipoCalculoDias,
                            sPais_Tasa,
                            fdias_Plazo,
                            fanos_enteros,
                            fanos_fraccion,
                            fmeses_enteros);

            fBase      := 1 + (fTasa_Mercado / 100);
            fExponente := fDias_Plazo / iDiasBaseTasa;
            fResultado := Power(fBase, fExponente);

            fValor_Presente := fValor_Presente +
                               ( fValor_Vencimiento / fResultado );
            {
            fDuration      := fDuration   + ((fValor_Vencimiento / fResultado) * (fDias_Plazo/365) );//fExponente
            fConvexidad    := fConvexidad + ( ((fValor_Vencimiento / fResultado) * (fDias_Plazo/365)) // Duration
                                              * ((fDias_Plazo/365) + 1) );
            }
            // Con Fecha 24-01-2006 Se cambia el 365 Fijo que estaba en el calculo
            // Por los días Base de la Tasa
            fDuration      := fDuration   + ((fValor_Vencimiento / fResultado) * (fDias_Plazo/iDiasBaseTasa) );//fExponente
            fConvexidad    := fConvexidad + ( ((fValor_Vencimiento / fResultado) * (fDias_Plazo/iDiasBaseTasa)) // Duration
                                              * ((fDias_Plazo/iDiasBaseTasa) + 1) );

          end;//fin if

          if Array_Mem_Desarr[iNro_Cupon].Nro_Cupon = 0 then
             Break;
       end;// fin while
       if fValor_Presente = 0 then
          fDuration      := 0
       else
          fDuration      := fDuration   /fValor_Presente;

       fDuracion_Modificada := 1/((1+(fTasa_Mercado/100)))*fDuration;

       if fValor_Presente = 0 then
          fConvexidad    := 0
       else
          fConvexidad    := fConvexidad /fValor_Presente;

       fConvexidad    := fConvexidad * ( Power( 1/(1+(fTasa_Mercado/100)), 2) );
   except
       fDuration            := 0;
       fDuracion_Modificada := 0;
       fConvexidad          := 0;
   end;
end;
//------------------------------------------------------------------------------
/////DC
Procedure Calculo_Duration_Vig(sEmisor,
                               sInstrumento,
                               sSerie,
                               sNemotecnico,
                               sTipo_Instrumento   : String;
                               //dFecha_Vig,
                               dFecha_Emision,
                               dFecha_Vencimiento,
                               dFecha_Calculo      : TDatetime;
                               fNominales,
                               fTasa_Mercado       : Double;
                               fTasa_Emision       : Double;
                               sMoneda_Instrumento : String;
                               Reg_Val_In          : TRegistro_Valoriza_In;
                               Array_Mem_Desarr    : TArray_Mem_Desarr;
                               RegDes              : TReg_Descriptor;
//                               Reg_Val_Out         : TRegistro_Valoriza_Out;
                              var fDuration        : Double;
                              var fDuracion_Modificada : Double;
                              var fConvexidad      : Double;
                              var sModulo_Error    : String;
                              var sString_Error    : String;
                              var Result           : Boolean
                             ) ;
var
//ES 22-07-2013  RegDes            : TReg_Descriptor;
  Reg_Fechas        : TRegistro_Fechas;
//ES 22-07-2013  Array_Mem_Desarr  : TArray_Mem_Desarr;
  sMetodo_Sin_Tasa_Referencia,
  sTipoInteres,
  sPais_Tasa        : String;
  iNro_Cupon,
  iDiasBaseTasa,
  iBaseMensual      : Integer;
  sTipoCalculoDias  : String;
  iVigenciaValor,
  iVigenciaMeses    : Integer;
  fDias_Plazo,
  fValor_Vencimiento,
  fIntereses,
  fAmortizacion,
  fBase,
  fExponente,
  fResultado,
  fValor_Presente,
  fanos_enteros,
  fanos_fraccion,
  fmeses_enteros,
  fPeriodo_de_Pago,
  fNro_Periodos_Years,
  fDias_Emision_Vcto,
  fValor_Uno,
  fValor_Dos,
  fValor_Vencimiento_Afectado : Double;
  Resulta                     : Boolean;
begin
   Result := True;
   sModulo_Error := 'Calculo Duration ';
   Duration_Fijo_Mem(sInstrumento,
                     dFecha_Calculo,
                     fDuration,
                     Resulta
                     );
   if Resulta Then
      exit;

   if Reg_Val_In.Descriptor_Cargado <> 'SI' then
      Carga_RegDes_vig(sTipo_Instrumento
                      ,sNemotecnico
                      ,sEmisor
                      ,sInstrumento
                      ,sSerie
                      ,dFecha_Calculo
                      ,sMoneda_Instrumento
                      ,fTasa_Emision
                      ,RegDes
                      ,sModulo_Error
                      ,sString_Error
                      ,Result);
//ES   else
//ES      RegDes := Reg_Val_Out.RegDes;


   if NOT Result then
      exit;

   Reg_Fechas.Fecha_Emision    := dFecha_Emision;
   Reg_Fechas.Fecha_Vencimiento:= dFecha_Vencimiento;
   Reg_Fechas.Fecha_Calculo    := dFecha_Calculo;
   Reg_Fechas.Fecha_Compra     := dFecha_Calculo;

   // Si Viene Tabla de Desarrollo no la cargo
   if Reg_Val_In.Tabla_Desarr_Cargada <> 'SI' then
   begin
      carga_Mem_Desarr(Array_Mem_Desarr,
                       sNemotecnico,
                       RegDes,
                       Reg_Fechas,
                       sMetodo_Sin_Tasa_Referencia,
                       False, // Sin Con_Cupon,
                       True,  // Verifica Exepciones Cambiarias
                       sModulo_Error,
                       sString_Error,
                       Result );

      if Not Result then
         Exit;
   end;
//   else
//      Array_Mem_Desarr := Reg_Val_Out.Array_Mem_Desarr;

   Obtener_Tasa_base_Mem(RegDes.Tasa_Valor_Pte
                        ,iDiasBaseTasa
                        ,sTipoInteres
                        ,iBaseMensual
                        ,sTipoCalculoDias
                        ,iVigenciaValor
                        ,iVigenciaMeses
                        ,sPais_Tasa
                        ,sModulo_Error
                        ,sString_Error
                        ,Result
                        );
   if NOT Result then
   begin
      // BASE_VARIABLE
{      if iDiasBaseTasa = 0 then
      begin
         Obtener_Tasa_base_Variable(RegDes.Tasa_Valor_Pte,
                                    Reg_Fechas,
                                    RegDes,
                                    Array_Mem_Desarr,
                                    sPais_Tasa,
                                    iDiasBaseTasa,
                                    fPeriodos,
                                    sModulo_error,
                                    sString_error,
                                    Result);
      end;
 }     if Not Result then
         exit;
   end;

    // Si es Instrumento Unico Calculo Duration por fecha de vencimiento
    if (sTipo_Instrumento = 'U') or
       (sTipo_Instrumento = 'B') then
    begin
       fDias_Plazo := (dFecha_Vencimiento - dFecha_Calculo);
       if fDias_Plazo = 0 then
       begin
         fDuration := 0;
         exit;
       end;
       fDuration   := fDias_Plazo / (StrToFloat('365'+FormatSettings.DecimalSeparator+'25'));

       if (fTasa_Mercado <= 0) or
          (Reg_Val_In.Tasa_Compra = 0) then //Fué comprado con tada CERO
       begin
          fDuration     := fDias_Plazo / (StrToFloat('365'+FormatSettings.DecimalSeparator+'25'));
          fDuracion_Modificada := fDias_Plazo / (StrToFloat('365'+FormatSettings.DecimalSeparator+'25'));
          fConvexidad   := 0;
          Exit;
       end;

       //Calculo Duracion Modificada
       fDias_Emision_Vcto  := (dFecha_Vencimiento - dFecha_Emision);
       if fDias_Emision_Vcto <> 0 then
          fNro_Periodos_Years := iDiasBaseTasa/fDias_Emision_Vcto
       else
          sString_Error := 'Dias Entre Emisión y Vencimiento es Cero (Duración Modificada)';

       if fNro_Periodos_Years <= 1 then
          fNro_Periodos_Years := 1;

       try
          fDuracion_Modificada := fDuration/(1+(fTasa_Mercado/100/fNro_Periodos_Years));

          fPeriodo_de_Pago     := iDiasBaseTasa/(fDias_Plazo);
          fValor_Vencimiento   := Array_Mem_Desarr[1].Valor_Cupon;

          fValor_Vencimiento_Afectado := fValor_Vencimiento/Power(1+fTasa_Mercado/100,fPeriodo_de_Pago);

          fValor_Uno := 1/ Power(1+fTasa_Mercado/100,2);
          fValor_Dos := (fValor_Vencimiento_Afectado * 2 )/
                        (fNro_Periodos_Years*fNro_Periodos_Years*fValor_Vencimiento_Afectado);

          fConvexidad := fValor_Uno * fValor_Dos;
       except
          begin
              fDuration            := 0;
              fDuracion_Modificada := 0;
              fConvexidad          := 0;
          end;
       end;      
       Result      := True;
       Exit;
    end;

   if RegDes.Periodo_Pago = 0 then
   begin
      sModulo_Error := 'Cálculo de Duración Modificada/Convexidad :';
      sString_Error := 'Período de Pago en Descriptor es Cero'
                      +' Nemotécnico : '+sNemotecnico;
      Result        := False;
      Exit;
   end;

   // Ahora recorro la tabla de desarrollo para buscar los vencimientos
   fValor_Presente:= 0;
   fDuration      := 0;
   fConvexidad    := 0;
//   fAcum_Cupon_Descontado := 0;
//   iNro_Cupon     := 1;

   try
       for iNro_Cupon := 1 to Max_Nro_Cupones do
       begin
//          fValor_Vencimiento := 0;
//          fIntereses         := 0;
//          fAmortizacion      := 0;
          if Array_Mem_Desarr[iNro_Cupon].Fecha_Vcto >= dFecha_Calculo then
          begin
            fIntereses        := Array_Mem_Desarr[iNro_Cupon].Interes
                                 * fNominales/RegDes.Base_Conversion;
            fAmortizacion     := Array_Mem_Desarr[iNro_Cupon].Amortizacion
                                 * fNominales/RegDes.Base_Conversion;

            fValor_Vencimiento:= (fIntereses + fAmortizacion);

            Calculo_de_dias(dFecha_Calculo,
                            Array_Mem_Desarr[iNro_Cupon].Fecha_Vcto,
                            sTipoCalculoDias,
                            sPais_Tasa,
                            fdias_Plazo,
                            fanos_enteros,
                            fanos_fraccion,
                            fmeses_enteros);

            fBase      := 1 + (fTasa_Mercado / 100);
            fExponente := fDias_Plazo / iDiasBaseTasa;
            fResultado := Power(fBase, fExponente);

            fValor_Presente := fValor_Presente +
                               ( fValor_Vencimiento / fResultado );
            {
            fDuration      := fDuration   + ((fValor_Vencimiento / fResultado) * (fDias_Plazo/365) );//fExponente
            fConvexidad    := fConvexidad + ( ((fValor_Vencimiento / fResultado) * (fDias_Plazo/365)) // Duration
                                              * ((fDias_Plazo/365) + 1) );
            }
            // Con Fecha 24-01-2006 Se cambia el 365 Fijo que estaba en el calculo
            // Por los días Base de la Tasa
            fDuration      := fDuration   + ((fValor_Vencimiento / fResultado) * (fDias_Plazo/iDiasBaseTasa) );//fExponente
            fConvexidad    := fConvexidad + ( ((fValor_Vencimiento / fResultado) * (fDias_Plazo/iDiasBaseTasa)) // Duration
                                              * ((fDias_Plazo/iDiasBaseTasa) + 1) );

          end;//fin if

          if Array_Mem_Desarr[iNro_Cupon].Nro_Cupon = 0 then
             Break;
       end;// fin while
       if fValor_Presente = 0 then
          fDuration      := 0
       else
          fDuration      := fDuration   /fValor_Presente;

       fDuracion_Modificada := 1/((1+(fTasa_Mercado/100)))*fDuration;

       if fValor_Presente = 0 then
          fConvexidad    := 0
       else
          fConvexidad    := fConvexidad /fValor_Presente;

       fConvexidad    := fConvexidad * ( Power( 1/(1+(fTasa_Mercado/100)), 2) );
   except
       fDuration            := 0;
       fDuracion_Modificada := 0;
       fConvexidad          := 0;
   end;
end;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
Procedure Busca_Valor( ArrayFechas,
                       ArrayValores : Variant;
                       dFecha_Tasa  : TDatetime;
                   var dValor_Tasa  : Double;
                   var Result       : Boolean);
var i : Integer;
begin
  Result := False;
  for i := 0 to VarArrayHighBound(ArrayFechas , 1 )  do
  begin
    if ArrayFechas[i] = dFecha_Tasa then
    begin
      dValor_Tasa := ArrayValores[i];
      Result := True;
      Break;
    end;
  end;
end;

function Feriado_Memory(sCodigo_Division : String;
                        dFecha           : TDatetime) : Boolean;
var
  wano,
  wmes,
  wdia : word;
  i    : Integer;
begin
  Result := False;
  if sCodigo_Division = EmptyStr then
     Exit;

  decodedate(dFecha,wano,wmes,wdia);

  For i := 0 to  VarArrayHighBound(Array_CodigoDivision, 1 ) do
  begin
     if ( (Array_AnoFeriado[i] = 0) or (Array_AnoFeriado[i] = wAno) ) and
          (Array_MesFeriado[i] = wMes) and
          (Array_DiaFeriado[i] = wDia) then
     begin
       Result := True;
       Break;
     end;
  end;
end;

//procedure Tratamiento_Fecha_Memory(sCodigo_Tratam   : String;
//                                   Registro_Fechas  : TRegistro_Fechas;
//                                   var Fecha_Result : TDateTime;
//                                   var Modulo_Err   : String;
//                                   var String_Err   : String;
//                                   var Result       : Boolean);
//var
//   iDias,
//   iMeses,
//   iAnos      : Integer;
//   fCantidad  : Double; //No puedo utilizar la variable del Registro
//
//   AA,
//   MM,
//   DD         : word;
//   Ano,
//   Mes,
//   Dia         : Integer;
//
//begin
//  Result := True;
//  Fecha_Result := strtodate(Fecha_Nula);
//
//  if Reg_Tratam.Referencia = 'FECCALC' then
//     Fecha_Result := Registro_fechas.Fecha_Calculo;
//
//  if Reg_Tratam.Referencia = 'FECEMIS' then
//     Fecha_Result := Registro_fechas.Fecha_Emision;
//
//  if Reg_Tratam.Referencia = 'FECVCTPER' then
//     Fecha_Result := Registro_fechas.Fecha_Vcto_Periodo;
//
//  if Reg_Tratam.Referencia = 'FECINIPER' then
//     Fecha_Result := Registro_fechas.Fecha_Inic_Periodo;
//
//  if Reg_Tratam.Referencia = 'FECPAGO' then
//     Fecha_Result := Registro_fechas.Fecha_Pago;
//
//  if Fecha_Result = StrToDate(Fecha_Nula) then
//  begin
//     Modulo_Err := 'Tratamiento Fecha (ComunInversiones)';
//     String_Err := 'No existe fecha para: '
//                   +sCodigo_Tratam;
//     Result := False;
//     exit;
//  end;
//
//  if Reg_Tratam.Dia <> 0 Then
//  begin
//     DecodeDate(Fecha_Result,AA,MM,DD);
//     Ano   := AA;
//     Mes   := MM;
//     Dia   := StrToInt(FloatToStr(Reg_Tratam.Dia));
//     if Reg_Tratam.Dia > ultimo_dia_mes(MM,AA) Then
//        Dia := ultimo_dia_mes(MM,AA);
//     Fecha_Result := EncodeDate(Ano,Mes,Dia);
//  end;
//
//
//  if Reg_Tratam.Cantidad = 0 then
//  begin
//    Result := True;
//    exit;
//  end;
//
//  iDias  := 0;
//  iMeses := 0;
//  iAnos  := 0;
//  fCantidad := Reg_Tratam.Cantidad;
//
//  if Reg_Tratam.Antes_Despues = 'A' then
//     fCantidad := fCantidad * (-1);
//
//  if Reg_Tratam.Unidad = 'DIA' then
//     iDias := ROUND(fCantidad);
//
//  if Reg_Tratam.Unidad = 'MES' then
//     iMeses := ROUND(fCantidad);
//
//  if Reg_Tratam.Unidad = 'ANO' then
//     iAnos := ROUND(fCantidad);
//
//  Fecha_Result := IncDate(Fecha_Result
//                         ,iDias
//                         ,iMeses
//                         ,iAnos);
//
//  if Reg_Tratam.Habiles = 'N' then
//  begin
//    Result := True;
//    exit;
//  end;
//
//  //Aqui dudo si se puede usar el mismo codigo de Pais que el ya cargado
//  While (feriado_Memory(Reg_Tratam.Codigo_Pais,Fecha_Result)  or
//        (DayOfWeek(Fecha_Result) in [1,7])) do
//     if Reg_Tratam.Antes_Despues = 'A' then
//        Fecha_Result := Fecha_Result - 1
//     else
//        Fecha_Result := Fecha_Result + 1;
//
//  Result := True;
//end;


Procedure Carga_Valores_Tasa_Memory( sCodigo_Tasa   : String;
                                     dFecha_Inicial : TDatetime;
                                     dFecha_Final   : TDatetime
                                   );
Var
   i : Integer;                                   
begin
  With dmFunciones_Valorizacion.Qry_Aux do
  begin
    SQL.Clear;
    SQL.Add('SELECT Fecha_Paridad'
           +'      ,Valor_Moneda'
           +'  FROM Qs_Sys_Val_Cambio'
           +' WHERE Cod_Moneda      = :Cod_Moneda'
           +'   AND Tipo_De_Paridad = ''BC'''
           +'   AND Fecha_Paridad >= :Fecha_Inicial'
           +'   AND Fecha_Paridad <= :Fecha_Final'
           +'  ORDER BY Fecha_Paridad'
           );
    Parambyname('Cod_Moneda').asString     := sCodigo_Tasa;
    Parambyname('Fecha_Inicial').asDatetime:= dFecha_Inicial;
    Parambyname('Fecha_Final').asDatetime  := dFecha_Final;
    Prepare;
    Open;
    Last;
    First;

    //Creo Arreglo y Cargo Valores
    ArrayValores := VarArrayCreate([0, RecordCount], varDouble);
    ArrayFechas  := VarArrayCreate([0, RecordCount], varDate);
    i := 0;
    while not Eof do
    begin
      ArrayFechas[i]  := Fieldbyname('Fecha_Paridad').asDatetime;
      ArrayValores[i] := Fieldbyname('Valor_Moneda').asFloat;
      Next;
      Inc(i);
    end;

    Close;
    Unprepare;
  end;
end;

Procedure Calculo_Pactos( Var fValor_Invertido_UM_Inicial : Double;
                          Var fValor_Invertido_MC_Inicial : Double;
                          fTasa_Calculo    : Double;
                          sMoneda_Pacto,
                          sTipo_Nominales,
                          sMoneda_Conversion,
                          sTasa_Base_Pacto : String;
                          dFecha_Calculo,
                          dFecha_Vencimiento_Pacto,
                          dFecha_Operacion   : TDatetime;
                          Var fValor_Invertido_UM_Final : Double;
                          Var fValor_Invertido_MC_Final : Double;
                          Var sModulo_Error : String;
                          Var sString_Error : String;
                          Var Result        : Boolean
                        );
Var dFecha_Aux : TDatetime;
    iBaseMensual,
    iVigenciaValor,
    iVigenciaMeses      : integer;
    BaseTasa            : integer;
    sTipoInteres,
    sTipoCalculoDias,
    sPais_Tasa         : string;
    dias_totales,
    anos_enteros,
    anos_fraccion,
    meses_enteros : Double;
    sTipo_Tasa,
    sAnualidad_Tasa     : String;
    fPeriodo_Tasa,
    fBase_Porcen_Tasa   : Double;
begin
  Result                    := False;
  sModulo_Error             := 'Cálculo Pacto :';
  fValor_Invertido_UM_Final := 0;
  fValor_Invertido_MC_Final := 0;

  if Trim(sMoneda_Pacto) = EmptyStr then
  begin
     sString_Error := ' No se ha ingresado Moneda Pacto ';
     Result := False;
     exit;
  end;

  try
     dFecha_Aux := dFecha_Calculo;
  except
     sString_Error := 'No se a Ingresado fecha de Cálculo Correcta';
     Result := False;
     Exit;
  end;

  try
     dFecha_Aux := dFecha_Vencimiento_Pacto;
  except
     sString_Error := 'No se a Ingresado Fecha de Vencimiento Correcta';
     Result := False;
     Exit;
  end;

  if sTipo_Nominales = 'B' then
  begin
      if sValorizacion_Proceso = 'SI' then
         Obtener_Tasa_base_Mem(sTasa_Base_Pacto,
                            BaseTasa,
                            sTipoInteres,
                            iBaseMensual,
                            sTipoCalculoDias,
                            iVigenciaValor,
                            iVigenciaMeses,
                            sPais_Tasa,
                            sModulo_error,
                            sString_error,
                            Result)
      else
          Obtener_Tasa_base(sTasa_Base_Pacto,
                            BaseTasa,
                            sTipoInteres,
                            iBaseMensual,
                            sTipoCalculoDias,
                            iVigenciaValor,
                            iVigenciaMeses,
                            sPais_Tasa,
                            sModulo_error,
                            sString_error,
                            Result);

      if NOT Result then
         exit;

      if sValorizacion_Proceso = 'SI' then
         Obtener_Base_Conversion_Mem(sTasa_Base_Pacto
                                    ,sTipo_Tasa
                                    ,fPeriodo_Tasa
                                    ,sAnualidad_Tasa
                                    ,fBase_Porcen_Tasa
                                    ,sModulo_Error
                                    ,sString_Error
                                    ,Result)
      else
         Obtener_Base_Conversion(sTasa_Base_Pacto
                                ,sTipo_Tasa
                                ,fPeriodo_Tasa
                                ,sAnualidad_Tasa
                                ,fBase_Porcen_Tasa
                                ,sModulo_Error
                                ,sString_Error
                                ,Result);
      if NOT Result then
         exit;

      calculo_de_dias(dFecha_Calculo, //ggarcia 12-11-2015 dFecha_Operacion,
                      dFecha_Vencimiento_Pacto,
                      sTipoCalculoDias,
                      sPais_Tasa,
                      dias_totales,
                      anos_enteros,
                      anos_fraccion,
                      meses_enteros);

      if sTipoInteres = 'S' then
         fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial / Interes_Simple(fTasa_Calculo,
                                                                                   fBase_Porcen_Tasa,
                                                                                   dias_totales,
                                                                                   BaseTasa)
      else
         fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial / Interes_Compuesto(fTasa_Calculo,
                                                                                      fBase_Porcen_Tasa,
                                                                                      dias_totales,
                                                                                      BaseTasa);
      fValor_Invertido_UM_Final := Redondeo_Moneda(sMoneda_Pacto
                                                   ,dFecha_Operacion
                                                   ,fValor_Invertido_UM_Final
                                                   );
      Conversion_unidad_mon(sMoneda_Pacto,
                            sMoneda_Conversion,
                            'BC',
                            dFecha_Calculo,
                            fValor_Invertido_UM_Final,
                            fValor_Invertido_MC_Final,
                            sModulo_Error,
                            sString_Error,
                            Result);

      if NOT Result then
         Exit;

      fValor_Invertido_MC_Final := Redondeo_Moneda(sMoneda_Conversion,
                                                   dFecha_Calculo,
                                                   fValor_Invertido_MC_Final);
      exit;
  end;

  if fValor_Invertido_UM_Inicial <> 0 then
  begin
    conversion_unidad_mon(sMoneda_Pacto,
                          sMoneda_Conversion,
                          'BC',
                          dFecha_Calculo,
                          fValor_Invertido_UM_Inicial,
                          fValor_Invertido_MC_Inicial,
                          sModulo_Error,
                          sString_Error,
                          Result);

    if NOT Result then
       fValor_Invertido_MC_Inicial := fValor_Invertido_UM_Inicial;

    if sValorizacion_Proceso = 'SI' then
       fValor_Invertido_MC_Inicial := Redondeo_Moneda_Mem(sMoneda_Pacto,
                                                          dFecha_Calculo,
                                                          fValor_Invertido_MC_Inicial)
    else
       fValor_Invertido_MC_Inicial := Redondeo_Moneda(sMoneda_Pacto,
                                                      dFecha_Calculo,
                                                      fValor_Invertido_MC_Inicial);
  end
  else if fValor_Invertido_MC_Inicial <> 0 then
  begin
    conversion_unidad_mon(sMoneda_Conversion,
                          sMoneda_Pacto,
                          'BC',
                          dFecha_Calculo,
                          fValor_Invertido_MC_Inicial,
                          fValor_Invertido_UM_Inicial,
                          sModulo_Error,
                          sString_Error,
                          Result);

    if NOT Result then
       fValor_Invertido_UM_Inicial := fValor_Invertido_MC_Inicial;

    if sValorizacion_Proceso = 'SI' then
       fValor_Invertido_UM_Inicial := Redondeo_Moneda_Mem(sMoneda_Pacto,
                                                          dFecha_Calculo,
                                                          fValor_Invertido_UM_Inicial)
    else
       fValor_Invertido_UM_Inicial := Redondeo_Moneda(sMoneda_Pacto,
                                                      dFecha_Calculo,
                                                      fValor_Invertido_UM_Inicial);
  end;

  if Trim(sTasa_Base_Pacto) = EmptyStr then
  begin
     sString_Error := ' ¡No se a especificado Tasa Base Pacto Correcta ! ';
     Result := False;
     exit;
  end;

  if sValorizacion_Proceso = 'SI' then
      Obtener_Tasa_base_Mem(sTasa_Base_Pacto,
                        BaseTasa,
                        sTipoInteres,
                        iBaseMensual,
                        sTipoCalculoDias,
                        iVigenciaValor,
                        iVigenciaMeses,
                        sPais_Tasa,
                        sModulo_error,
                        sString_error,
                        Result)
  else
      Obtener_Tasa_base(sTasa_Base_Pacto,
                        BaseTasa,
                        sTipoInteres,
                        iBaseMensual,
                        sTipoCalculoDias,
                        iVigenciaValor,
                        iVigenciaMeses,
                        sPais_Tasa,
                        sModulo_error,
                        sString_error,
                        Result);

  if NOT Result then
     exit;

   if sValorizacion_Proceso = 'SI' then
      Obtener_Base_Conversion_Mem(sTasa_Base_Pacto
                                 ,sTipo_Tasa
                                 ,fPeriodo_Tasa
                                 ,sAnualidad_Tasa
                                 ,fBase_Porcen_Tasa
                                 ,sModulo_Error
                                 ,sString_Error
                                 ,Result)
   else
      Obtener_Base_Conversion(sTasa_Base_Pacto
                             ,sTipo_Tasa
                             ,fPeriodo_Tasa
                             ,sAnualidad_Tasa
                             ,fBase_Porcen_Tasa
                             ,sModulo_Error
                             ,sString_Error
                             ,Result);
   if NOT Result then
      exit;

  if sTipo_Nominales = 'I' then
  begin
     calculo_de_dias(dFecha_Operacion,
                     dFecha_Vencimiento_Pacto,
                     sTipoCalculoDias,
                     sPais_Tasa,
                     dias_totales,
                     anos_enteros,
                     anos_fraccion,
                     meses_enteros);

     if sTipoInteres = 'S' then
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Simple( fTasa_Calculo,
                                                                                   fBase_Porcen_Tasa,
                                                                                   dias_totales,
                                                                                   BaseTasa)
     else
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Compuesto( fTasa_Calculo,
                                                                                      fBase_Porcen_Tasa,
                                                                                      dias_totales,
                                                                                      BaseTasa);
     calculo_de_dias(dFecha_Calculo,
                     dFecha_Vencimiento_Pacto,
                     sTipoCalculoDias,
                     sPais_Tasa,
                     dias_totales,
                     anos_enteros,
                     anos_fraccion,
                     meses_enteros);

     if sTipoInteres = 'S' then
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Final / Interes_Simple( fTasa_Calculo,
                                                                                 fBase_Porcen_Tasa,
                                                                                 dias_totales,
                                                                                 BaseTasa)
     else
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Final / Interes_Compuesto( fTasa_Calculo,
                                                                                    fBase_Porcen_Tasa,
                                                                                    dias_totales,
                                                                                    BaseTasa);
  end
  else
  begin
     calculo_de_dias(dFecha_Operacion,
                     dFecha_Vencimiento_Pacto,
                     sTipoCalculoDias,
                     sPais_Tasa,
                     dias_totales,
                     anos_enteros,
                     anos_fraccion,
                     meses_enteros);

     if sTipoInteres = 'S' then
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Simple( fTasa_Calculo,
                                                                                   fBase_Porcen_Tasa,
                                                                                   dias_totales,
                                                                                   BaseTasa)
     else
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Compuesto( fTasa_Calculo,
                                                                                      fBase_Porcen_Tasa,
                                                                                      dias_totales,
                                                                                      BaseTasa);
  end;

  Conversion_unidad_mon(sMoneda_Pacto,
                        sMoneda_Conversion,
                        'BC',
                        dFecha_Calculo,
                        fValor_Invertido_UM_Final,
                        fValor_Invertido_MC_Final,
                        sModulo_Error,
                        sString_Error,
                        Result);

  if NOT Result then
    fValor_Invertido_MC_Final := fValor_Invertido_UM_Final;

  if sValorizacion_Proceso = 'SI' then
     fValor_Invertido_MC_Final := Redondeo_Moneda_Mem(sMoneda_Conversion,
                                                      dFecha_Calculo,
                                                      fValor_Invertido_MC_Final)
  else
     fValor_Invertido_MC_Final := Redondeo_Moneda(sMoneda_Conversion,
                                                  dFecha_Calculo,
                                                  fValor_Invertido_MC_Final);
end;
//------------------------------------------------------------------------------
Procedure Calculo_Pactos_RV( Var fValor_Invertido_UM_Inicial : Double;
                             Var fValor_Invertido_MC_Inicial : Double;
                             fTasa_Calculo    : Double;
                             sMoneda_Pacto,
                             sTipo_Nominales,
                             sMoneda_Conversion,
                             sTasa_Base_Pacto : String;
                             dFecha_Calculo,
                             dFecha_Vencimiento_Pacto,
                             dFecha_Operacion   : TDatetime;
                             Var fValor_Invertido_UM_Final : Double;
                             Var fValor_Invertido_MC_Final : Double;
                             Var sModulo_Error : String;
                             Var sString_Error : String;
                             Var Result        : Boolean
                           );
Var dFecha_Aux : TDatetime;
    iBaseMensual,
    iVigenciaValor,
    iVigenciaMeses      : integer;
    BaseTasa            : integer;
    sTipoInteres,
    sTipoCalculoDias,
    sPais_Tasa         : string;
    dias_totales,
    anos_enteros,
    anos_fraccion,
    meses_enteros : Double;
    sTipo_Tasa,
    sAnualidad_Tasa     : String;
    fPeriodo_Tasa,
    fBase_Porcen_Tasa   : Double;
begin
  Result                    := False;
  sModulo_Error             := 'Cálculo Pacto :';
  fValor_Invertido_UM_Final := 0;
  fValor_Invertido_MC_Final := 0;

  if Trim(sMoneda_Pacto) = EmptyStr then
  begin
     sString_Error := ' No se ha ingresado Moneda Pacto ';
     Result := False;
     exit;
  end;

  try
     dFecha_Aux := dFecha_Calculo;
  except
     sString_Error := 'No se a Ingresado fecha de Cálculo Correcta';
     Result := False;
     Exit;
  end;

  try
     dFecha_Aux := dFecha_Vencimiento_Pacto;
  except
     sString_Error := 'No se a Ingresado Fecha de Vencimiento Correcta';
     Result := False;
     Exit;
  end;

  if sTipo_Nominales = 'B' then
  begin
      if sValorizacion_Proceso = 'SI' then
         Obtener_Tasa_base_Mem(sTasa_Base_Pacto,
                            BaseTasa,
                            sTipoInteres,
                            iBaseMensual,
                            sTipoCalculoDias,
                            iVigenciaValor,
                            iVigenciaMeses,
                            sPais_Tasa,
                            sModulo_error,
                            sString_error,
                            Result)
      else
          Obtener_Tasa_base(sTasa_Base_Pacto,
                            BaseTasa,
                            sTipoInteres,
                            iBaseMensual,
                            sTipoCalculoDias,
                            iVigenciaValor,
                            iVigenciaMeses,
                            sPais_Tasa,
                            sModulo_error,
                            sString_error,
                            Result);

      if NOT Result then
         exit;

      if sValorizacion_Proceso = 'SI' then
         Obtener_Base_Conversion_Mem(sTasa_Base_Pacto
                                    ,sTipo_Tasa
                                    ,fPeriodo_Tasa
                                    ,sAnualidad_Tasa
                                    ,fBase_Porcen_Tasa
                                    ,sModulo_Error
                                    ,sString_Error
                                    ,Result)
      else
         Obtener_Base_Conversion(sTasa_Base_Pacto
                                ,sTipo_Tasa
                                ,fPeriodo_Tasa
                                ,sAnualidad_Tasa
                                ,fBase_Porcen_Tasa
                                ,sModulo_Error
                                ,sString_Error
                                ,Result);
      if NOT Result then
         exit;

      calculo_de_dias(dFecha_Operacion,
                      dFecha_Vencimiento_Pacto,
                      sTipoCalculoDias,
                      sPais_Tasa,
                      dias_totales,
                      anos_enteros,
                      anos_fraccion,
                      meses_enteros);

      if sTipoInteres = 'S' then
         fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial / Interes_Simple(fTasa_Calculo,
                                                                                   fBase_Porcen_Tasa,
                                                                                   dias_totales,
                                                                                   BaseTasa)
      else
         fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial / Interes_Compuesto(fTasa_Calculo,
                                                                                      fBase_Porcen_Tasa,
                                                                                      dias_totales,
                                                                                      BaseTasa);
      {fValor_Invertido_UM_Final := Redondeo_Moneda(sMoneda_Pacto
                                                   ,dFecha_Operacion
                                                   ,fValor_Invertido_UM_Final);}
      fValor_Invertido_UM_Final := Redondeo(fValor_Invertido_UM_Final,3);

      Conversion_unidad_mon(sMoneda_Pacto,
                            sMoneda_Conversion,
                            'BC',
                            dFecha_Calculo,
                            fValor_Invertido_UM_Final,
                            fValor_Invertido_MC_Final,
                            sModulo_Error,
                            sString_Error,
                            Result);

      if NOT Result then
         Exit;

      {fValor_Invertido_MC_Final := Redondeo_Moneda(sMoneda_Conversion,
                                                   dFecha_Calculo,
                                                   fValor_Invertido_MC_Final);}
      fValor_Invertido_MC_Final := Redondeo(fValor_Invertido_MC_Final,3);
      exit;
  end;

  if fValor_Invertido_UM_Inicial <> 0 then
  begin
    conversion_unidad_mon(sMoneda_Pacto,
                          sMoneda_Conversion,
                          'BC',
                          dFecha_Calculo,
                          fValor_Invertido_UM_Inicial,
                          fValor_Invertido_MC_Inicial,
                          sModulo_Error,
                          sString_Error,
                          Result);

    if NOT Result then
       fValor_Invertido_MC_Inicial := fValor_Invertido_UM_Inicial;

    {if sValorizacion_Proceso = 'SI' then
       fValor_Invertido_MC_Inicial := Redondeo_Moneda_Mem(sMoneda_Pacto,
                                                          dFecha_Calculo,
                                                          fValor_Invertido_MC_Inicial)
    else
       fValor_Invertido_MC_Inicial := Redondeo_Moneda(sMoneda_Pacto,
                                                      dFecha_Calculo,
                                                      fValor_Invertido_MC_Inicial);}
    fValor_Invertido_MC_Inicial := Redondeo(fValor_Invertido_MC_Inicial,3);
  end
  else if fValor_Invertido_MC_Inicial <> 0 then
  begin
    conversion_unidad_mon(sMoneda_Conversion,
                          sMoneda_Pacto,
                          'BC',
                          dFecha_Calculo,
                          fValor_Invertido_MC_Inicial,
                          fValor_Invertido_UM_Inicial,
                          sModulo_Error,
                          sString_Error,
                          Result);

    if NOT Result then
       fValor_Invertido_UM_Inicial := fValor_Invertido_MC_Inicial;

    {if sValorizacion_Proceso = 'SI' then
       fValor_Invertido_UM_Inicial := Redondeo_Moneda_Mem(sMoneda_Pacto,
                                                          dFecha_Calculo,
                                                          fValor_Invertido_UM_Inicial)
    else
       fValor_Invertido_UM_Inicial := Redondeo_Moneda(sMoneda_Pacto,
                                                      dFecha_Calculo,
                                                      fValor_Invertido_UM_Inicial); }
    fValor_Invertido_UM_Inicial := Redondeo(fValor_Invertido_UM_Inicial,3);
  end;

  if Trim(sTasa_Base_Pacto) = EmptyStr then
  begin
     sString_Error := ' ¡No se a especificado Tasa Base Pacto Correcta ! ';
     Result := False;
     exit;
  end;

  if sValorizacion_Proceso = 'SI' then
      Obtener_Tasa_base_Mem(sTasa_Base_Pacto,
                        BaseTasa,
                        sTipoInteres,
                        iBaseMensual,
                        sTipoCalculoDias,
                        iVigenciaValor,
                        iVigenciaMeses,
                        sPais_Tasa,
                        sModulo_error,
                        sString_error,
                        Result)
  else
      Obtener_Tasa_base(sTasa_Base_Pacto,
                        BaseTasa,
                        sTipoInteres,
                        iBaseMensual,
                        sTipoCalculoDias,
                        iVigenciaValor,
                        iVigenciaMeses,
                        sPais_Tasa,
                        sModulo_error,
                        sString_error,
                        Result);

  if NOT Result then
     exit;

   if sValorizacion_Proceso = 'SI' then
      Obtener_Base_Conversion_Mem(sTasa_Base_Pacto
                                 ,sTipo_Tasa
                                 ,fPeriodo_Tasa
                                 ,sAnualidad_Tasa
                                 ,fBase_Porcen_Tasa
                                 ,sModulo_Error
                                 ,sString_Error
                                 ,Result)
   else
      Obtener_Base_Conversion(sTasa_Base_Pacto
                             ,sTipo_Tasa
                             ,fPeriodo_Tasa
                             ,sAnualidad_Tasa
                             ,fBase_Porcen_Tasa
                             ,sModulo_Error
                             ,sString_Error
                             ,Result);
   if NOT Result then
      exit;

  if sTipo_Nominales = 'I' then
  begin
     calculo_de_dias(dFecha_Operacion,
                     dFecha_Vencimiento_Pacto,
                     sTipoCalculoDias,
                     sPais_Tasa,
                     dias_totales,
                     anos_enteros,
                     anos_fraccion,
                     meses_enteros);

     if sTipoInteres = 'S' then
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Simple( fTasa_Calculo,
                                                                                   fBase_Porcen_Tasa,
                                                                                   dias_totales,
                                                                                   BaseTasa)
     else
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Compuesto( fTasa_Calculo,
                                                                                      fBase_Porcen_Tasa,
                                                                                      dias_totales,
                                                                                      BaseTasa);
     calculo_de_dias(dFecha_Calculo,
                     dFecha_Vencimiento_Pacto,
                     sTipoCalculoDias,
                     sPais_Tasa,
                     dias_totales,
                     anos_enteros,
                     anos_fraccion,
                     meses_enteros);

     if sTipoInteres = 'S' then
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Final / Interes_Simple( fTasa_Calculo,
                                                                                 fBase_Porcen_Tasa,
                                                                                 dias_totales,
                                                                                 BaseTasa)
     else
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Final / Interes_Compuesto( fTasa_Calculo,
                                                                                    fBase_Porcen_Tasa,
                                                                                    dias_totales,
                                                                                    BaseTasa);
  end
  else
  begin
     calculo_de_dias(dFecha_Operacion,
                     dFecha_Vencimiento_Pacto,
                     sTipoCalculoDias,
                     sPais_Tasa,
                     dias_totales,
                     anos_enteros,
                     anos_fraccion,
                     meses_enteros);

     if sTipoInteres = 'S' then
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Simple( fTasa_Calculo,
                                                                                   fBase_Porcen_Tasa,
                                                                                   dias_totales,
                                                                                   BaseTasa)
     else
        fValor_Invertido_UM_Final := fValor_Invertido_UM_Inicial * Interes_Compuesto( fTasa_Calculo,
                                                                                      fBase_Porcen_Tasa,
                                                                                      dias_totales,
                                                                                      BaseTasa);
  end;

  Conversion_unidad_mon(sMoneda_Pacto,
                        sMoneda_Conversion,
                        'BC',
                        dFecha_Calculo,
                        fValor_Invertido_UM_Final,
                        fValor_Invertido_MC_Final,
                        sModulo_Error,
                        sString_Error,
                        Result);

  if NOT Result then
    fValor_Invertido_MC_Final := fValor_Invertido_UM_Final;

  {if sValorizacion_Proceso = 'SI' then
     fValor_Invertido_MC_Final := Redondeo_Moneda_Mem(sMoneda_Conversion,
                                                      dFecha_Calculo,
                                                      fValor_Invertido_MC_Final)
  else
     fValor_Invertido_MC_Final := Redondeo_Moneda(sMoneda_Conversion,
                                                  dFecha_Calculo,
                                                  fValor_Invertido_MC_Final);}
  fValor_Invertido_MC_Final := Redondeo(fValor_Invertido_MC_Final,3);
end;
//------------------------------------------------------------------------------
Procedure Calculo_Forward(sInstrumento              : String;
                          sTipo_Valuacion           : String;
                          Valor_Nocional            : Double;
                          sMoneda_Nocional          : String;
                          sMoneda_Contrato          : String;
                          dFecha_Calculo            : TDatetime;
                          dFecha_Vcto               : TDatetime;
                          sOrigen                   : String;
                      Var fTipo_Cambio              : Double;
                      Var fFX_POINTS                : Double;
                      var fTipo_Cambio_fwd          : Double;
                      Var fValor_Invertido_UM_Final : Double;
                      Var sModulo_Error             : String;
                      Var sString_Error             : String;
                      Var Result                    : Boolean);
Var fValor_Paridad1   : Double;
    bExiste_Paridad   : Boolean;
    dfecha_paridad    : TDatetime;
    fTipo_Cambio_new  : Double;
    fFX_POINTS_new    : Double;
begin
   Result := true;

   //inicio ggarcia 23-11-2015
   dfecha_paridad := dFecha_Calculo;
   { //ggarcia 24-03-2016 se comenta ya que es solo valido para los vencimientos.
   dfecha_paridad := Calcula_Fecha_Efectiva(dFecha_Calculo
                                           ,' ' //emisor
                                           ,sInstrumento
                                           ,' ' //serie
                                           ,' '); //nemotecnico
   }
   //fin ggarcia 23-11-2015

   if (sTipo_Valuacion <> 'FW TC+FX')   AND
      (sTipo_Valuacion <> 'FW TC')      AND
      (sTipo_Valuacion <> 'FW TC-TR')   THEN
       sTipo_Valuacion := 'FW TC';


   if (sTipo_Valuacion = 'FW TC+FX') OR
      (sTipo_Valuacion = 'FW TC')    then
   begin

      leer_valor_cambio2(sMoneda_Nocional
                        ,sMoneda_Contrato
                        ,'BC'
                        ,dfecha_paridad // ggarcia 23-11-2015 dFecha_Calculo
                        ,fTipo_Cambio
                        ,bExiste_Paridad);
      if NOT bExiste_Paridad then
      begin
         sModulo_Error := 'Cálculo Forward';
         sString_Error := 'No se encontró valor de cambio de '+sMoneda_Nocional+' a '+ sMoneda_Contrato+'. Con fecha : '+DateToStr(dfecha_paridad);
         Result := False;
         exit;
      end;
      if fTipo_Cambio < 1 then
         leer_valor_cambio2(sMoneda_Contrato
                           ,sMoneda_Nocional
                           ,'BC'
                           ,dfecha_paridad // ggarcia 23-11-2015 dFecha_Calculo
                           ,fTipo_Cambio_new
                           ,bExiste_Paridad)
      else
         fTipo_Cambio_new := 0;


      // Incluye FX Points
      fFX_POINTS := 0;
      if ( sTipo_Valuacion = 'FW TC+FX') AND
         ( dFecha_Calculo  <> dFecha_Vcto) THEN
      begin
        leer_valor_cambio_tramo_Mem(sMoneda_Nocional
                                   ,sMoneda_Contrato
                                   ,sOrigen
                                   ,'BC'
                                   ,dfecha_paridad // ggarcia 23-11-2015 dFecha_Calculo
                                   ,dFecha_Vcto - dFecha_Calculo
                                   ,fFX_POINTS
                                   ,bExiste_Paridad);
        if NOT bExiste_Paridad then
        begin
           sModulo_Error := 'Cálculo Forward';
           sString_Error := 'No se encontró FX Points '+sOrigen+' de '+sMoneda_Nocional+' a '+ sMoneda_Contrato+' para '+FormatFloat('###,###',(dFecha_Vcto-dFecha_Calculo))+' días.'+' Con fecha : '+DateToStr(dfecha_paridad);
           Result := False;
           exit;
        end;
        if fTipo_Cambio < 1 then
           leer_valor_cambio_tramo_Mem(sMoneda_Contrato
                                      ,sMoneda_Nocional
                                      ,sOrigen
                                      ,'BC'
                                      ,dfecha_paridad // ggarcia 23-11-2015 dFecha_Calculo
                                      ,dFecha_Vcto - dFecha_Calculo
                                      ,fFX_POINTS_new
                                      ,bExiste_Paridad)
        else
           fFX_POINTS_new := 0;
      end;

      if fTipo_Cambio < 1 then
         //ggarcia 06-10-2022
         //fValor_Paridad1 := 1/(fTipo_Cambio_new+fFX_POINTS_new)
         fValor_Paridad1 := (1/fTipo_Cambio_new)+(1/fFX_POINTS_new)
      else
         fValor_Paridad1 := fTipo_Cambio + fFX_POINTS;
   end;

   if (sTipo_Valuacion = 'FW TC-TR') then
   begin

      leer_valor_cambio2(sMoneda_Nocional
                        ,sMoneda_Contrato
                        ,'BC'
                        ,dfecha_paridad // ggarcia 23-11-2015 dFecha_Calculo
                        ,fTipo_Cambio
                        ,bExiste_Paridad);
      if NOT bExiste_Paridad then
      begin
         sModulo_Error := 'Cálculo Forward';
         sString_Error := 'No se encontró valor de cambio de '+sMoneda_Nocional+' a '+ sMoneda_Contrato+'. Con fecha : '+DateToStr(dfecha_paridad);
         Result := False;
         exit;
      end;

      leer_valor_cambio_tramo_Mem(sMoneda_Nocional
                                 ,sMoneda_Contrato
                                 ,sOrigen
                                 ,'BC'
                                 ,dfecha_paridad
                                 ,dFecha_Vcto - dFecha_Calculo
                                 ,fValor_Paridad1
                                 ,bExiste_Paridad);
      if NOT bExiste_Paridad then
      begin
         sModulo_Error := 'Cálculo Forward';
         sString_Error := 'No se encontró Tipo Cambio '+sOrigen+' por tramo de '+sMoneda_Nocional+' a '+ sMoneda_Contrato+' para '+FormatFloat('###,###',(dFecha_Vcto-dFecha_Calculo))+' días.'+' Con fecha : '+DateToStr(dfecha_paridad);
         Result := False;
         exit;
      end;

   end;

   fTipo_Cambio_fwd := fValor_Paridad1;

   fValor_Invertido_UM_Final := (Valor_Nocional * fValor_Paridad1);

   fValor_Invertido_UM_Final := Redondeo_Moneda_Mem(sMoneda_Contrato,
                                                    dfecha_paridad,
                                                    fValor_Invertido_UM_Final);
 end;
//------------------------------------------------------------------------------
procedure Calculo_TIR_PTE(Reg_Formula_PAR      : TRegFormulaPAR;
                          Reg_Formula_TIR      : TRegFormulaTIR;
                          sTipo_Instrumento    : String;
                          var Array_Mem_Desarr : TArray_Mem_Desarr;
                          sNemotecnico         : String;
                          RegDes               : TReg_Descriptor;
                          Reg_Fechas           : TRegistro_Fechas;
                          fNominales           : Double;
                          fValor_Par_Base      : Double;
                          fValor_Par_UM        : Double;
                          bConCupon            : Boolean;
                          bAcumula_Factor      : Boolean;
                          sValor_Cupon_Original  : String;  // No toma en cuenta Execepcion Variacion Cambiaria
                          sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                          sOrigen                : String;
                          var fTasaCalculo     : Double;
                          var fTIR_Desarr      : Double;
                          var fValor_Presente  : Double;
                          var fValor_Pte_UM    : Double;
                          var fValor_Par_Corto : Double;
                          var sModulo_Err      : String;
                          var sString_Err      : String;
                          var Result           : Boolean);
var
  fLimite_Inferior    : Double;
  fLimite_Superior    : Double;

  fValor_Invertido_UM_Buscado    : Double;

  iNro_Iteracion      : Integer;

  Pte_Calculado       : Currency;
  Pte_Buscado         : Currency;

  sTipo_Tasa_PTE        : String;
  fPeriodo_Tasa_PTE     : Double;
  sAnualidad_Tasa_PTE   : String;
  fBase_Porcen_Tasa_PTE : Double;
  fSpread               : Double;

  acc_impuesto : double ;

begin
// Determino Limites
  fValor_Invertido_UM_Buscado := fValor_Pte_UM;  // asigno parametro donde viene el valor

  fLimite_Inferior := -29;
  fLimite_Superior :=  50;

  iNro_Iteracion := 0;
  fSpread        := 0;
  fValor_Pte_UM := 0;
  Pte_Calculado := 0;
  Pte_Buscado := fValor_Invertido_UM_Buscado;
  while ((iNro_Iteracion < 100) and (Pte_Buscado <> Pte_Calculado)) do
    begin
      fTasaCalculo := (fLimite_Inferior + fLimite_Superior) /  2;

      Valor_PTE(Reg_Formula_PAR
               ,Reg_Formula_TIR
               ,sTipo_Instrumento
               ,Array_Mem_Desarr
               ,sNemotecnico
               ,RegDes
               ,fTasaCalculo
               ,fSpread
               ,Reg_Fechas
               ,fNominales
               ,fValor_Par_Base
               ,fValor_Par_UM
               ,bConCupon
               ,bAcumula_Factor
               ,'TIR'
               ,'N'   //  Reg_Val_In.sValor_Cupon_Original
               ,sComponentes_Descuento
               ,fNominales
               ,fValor_Pte_UM
               ,sOrigen
               ,fValor_Presente
               ,fValor_Pte_UM
               ,fValor_Par_Corto
               ,acc_impuesto
               ,sModulo_Err
               ,sString_Err
               ,Result);

      if NOT Result then
         exit;

      Pte_Calculado := fValor_Pte_UM;


      if Reg_Formula_TIR.Valoriza_Sobre = 'SALINSOL' then
         begin
           if fValor_Invertido_UM_Buscado > fValor_Pte_UM then
              fLimite_Inferior := fTasaCalculo
           else
              fLimite_Superior := fTasaCalculo;
         end
      else
         begin
           if fValor_Invertido_UM_Buscado < fValor_Pte_UM then
              fLimite_Inferior := fTasaCalculo
           else
              fLimite_Superior := fTasaCalculo;
         end;


      inc(iNro_Iteracion);
    end;

  if (Pte_Buscado <> Pte_Calculado) then
     begin
       sModulo_Err := 'Tasa Interna de Retorno';
       sString_Err := 'No se pudo determinar Tasa'+#10
                     +'Iteraciones: '
                     +IntToStr(iNro_Iteracion)+#10
                     +'Buscado: '
                     +floattostr(Pte_Buscado)+#10
                     +'Calculado: '
                     +floattostr(Pte_Calculado);
       Result := False;
     end
  else
     begin
       fTIR_Desarr := fTasaCalculo;
       Obtener_Base_Conversion(RegDes.Tasa_Valor_PTE
                              ,sTipo_Tasa_PTE
                              ,fPeriodo_Tasa_PTE
                              ,sAnualidad_Tasa_PTE
                              ,fBase_Porcen_Tasa_PTE
                              ,sModulo_Err
                              ,sString_Err
                              ,Result);
       if NOT Result then
          exit;

       conversion_tasas('E'
                       ,fPeriodo_Tasa_PTE
                       ,''
                       ,fBase_Porcen_Tasa_PTE
                       ,sTipo_Tasa_PTE
                       ,fPeriodo_Tasa_PTE
                       ,sAnualidad_Tasa_PTE
                       ,fBase_Porcen_Tasa_PTE
                       ,fTIR_Desarr
                       ,sModulo_Err
                       ,sString_Err
                       ,Result);
     end;
end;
//------------------------------------------------------------------------------
procedure Valor_Final_Unicos(sTipo_Nominales   : String;
                             dFecha_emision    : TDateTime;
                             dFecha_Vcto       : TDateTime;
                             sTasa_base_par    : String;
                             fTasa_emision     : Double;
                             fNominales        : Double;
                         var sModulo_Err       : String;
                         var sString_Err       : String;
                         var fValor_Final_um   : Double);
var
  iDiasBaseTasa       : Integer;
  sTipoInteres,
  sPais_Tasa          : String;
  iBaseMensual        : Integer;
  sTipoCalculoDias    : String;
  iVigenciaValor      : Integer;
  iVigenciaMeses      : Integer;
  iDiasDif            : Double;
  iAnosEnteros        : Double;
  iAnosFraccion       : Double;
  iMesesEnteros       : Double;
  fInteres            : Double;
  Result : Boolean;
  sTipo_Tasa,
  sAnualidad_Tasa     : String;
  fPeriodo_Tasa,
  fBase_Porcen_Tasa   : Double;
begin
  if sTipo_Nominales = 'I' then
  begin
     {Lectura tasa base par }
     Obtener_Tasa_base(sTasa_Base_PAR
                       ,iDiasBaseTasa
                       ,sTipoInteres
                       ,iBaseMensual
                       ,sTipoCalculoDias
                       ,iVigenciaValor
                       ,iVigenciaMeses
                       ,sPais_Tasa
                       ,sModulo_err
                       ,sString_err
                       ,Result);

     if NOT Result then
        exit;

     if sValorizacion_Proceso = 'SI' then
        Obtener_Base_Conversion_Mem(sTasa_Base_PAR
                                   ,sTipo_Tasa
                                   ,fPeriodo_Tasa
                                   ,sAnualidad_Tasa
                                   ,fBase_Porcen_Tasa
                                   ,sModulo_Err
                                   ,sString_Err
                                   ,Result)
     else
        Obtener_Base_Conversion(sTasa_Base_PAR
                               ,sTipo_Tasa
                               ,fPeriodo_Tasa
                               ,sAnualidad_Tasa
                               ,fBase_Porcen_Tasa
                               ,sModulo_Err
                               ,sString_Err
                               ,Result);
     if NOT Result then
        exit;

     // Calculo el Nro de dias entre el vcto anterior y fecha de calculo
     Calculo_de_dias(dFecha_Emision,
                     dFecha_Vcto,
                     sTipoCalculoDias,
                     sPais_Tasa,
                     iDiasDif,
                     iAnosEnteros,
                     iAnosFraccion,
                     iMesesEnteros);

     if sTipoInteres = 'C' then
        fInteres := Interes_Compuesto(fTasa_emision
                                     ,fBase_Porcen_Tasa
                                     ,iDiasDif
                                     ,iDiasBaseTasa)
     else
        fInteres := Interes_Simple(fTasa_emision
                                  ,fBase_Porcen_Tasa
                                  ,iDiasDif
                                  ,iDiasBaseTasa);

     fValor_final_um  := fNominales * fInteres;
  end
  else
     fValor_final_um  := fNominales;
end;

// Ojo esta rutina esta lista para ser llamada desde instrumentos con
// Descriptor y ser unificada
procedure Valor_Sin_Descriptor_TasaFija_SI(fNominales        : Double;
                                           fTasaCalculo      : Double;
                                           sTasa_Base        : String;
                                           var Array_Mem_Desarr : TArray_Mem_Desarr;
                                           dFecha_Calculo    : TdateTime;
                                           dFecha_Emision    : TdateTime;
                                           RegDes            : TReg_Descriptor;
                                           sValor_Cupon_Original : String;
                                           sComponentes_Descuento : String; // Si es blanco (Valor CUpon COmpleto)
                                           var fValor        : Double;
                                           var sModulo_Err   : String;
                                           var sString_Err   : String;
                                           var Result        : Boolean);
var
  iDiasBaseTasa       : Integer;
  sTipoInteres,
  sPais_Tasa          : String;
  iBaseMensual        : Integer;
  sTipoCalculoDias    : String;
  iVigenciaValor      : Integer;
  iVigenciaMeses      : Integer;

  iDiasDif            : Double;
  iAnosEnteros        : Double;
  iAnosFraccion       : Double;
  iMesesEnteros       : Double;

  fInteres,
  fSaldoInsolutoCupon : Double;
  iCuponVigente       : Integer;
  dFechaVctoAnterior  : TDateTime;
  sTipo_Tasa,
  sAnualidad_Tasa     : String;
  fPeriodo_Tasa,
  fBase_Porcen_Tasa   : Double;
begin
   Cupon_Vigente(Array_Mem_Desarr,
                 RegDes,
                 dFecha_Calculo,
                 True,
                 iCuponVigente,
                 sModulo_Err,
                 sString_Err,
                 Result);

   if NOT Result then
      exit;

   // Obtengo Saldo Insoluto a Fecha de Calculo

   if iCuponVigente > 1 then
      // El Saldo Insoluto es el que habia al principio del periodo
      if sValor_Cupon_Original = 'S' then
         fSaldoInsolutoCupon := Array_Mem_Desarr[iCuponVigente -1].Saldo_Insoluto_Original
      else
         fSaldoInsolutoCupon := Array_Mem_Desarr[iCuponVigente -1].Saldo_Insoluto_Original *
                                Array_Mem_Desarr[iCuponVigente].Factor_Varcam

//      fSaldoInsolutoCupon := Array_Mem_Desarr[iCuponVigente -1].Saldo_Insoluto
   else
      begin
        // El saldo insoluto es el total
        // Cambiado con fecha 25-05-2006 F.I.
        // Debe ser base_original .... Ejemplo Base 1000 con base convercion 1 !!!!
        if sValor_Cupon_Original = 'S' then
           fSaldoInsolutoCupon := RegDes.Base_Original // RegDes.Base_Conversion
        else
           fSaldoInsolutoCupon := RegDes.Base_Original * //RegDes.Base_Conversion *
                                  Array_Mem_Desarr[iCuponVigente].Factor_Varcam;
{
        fSaldoInsolutoCupon := 0;
        for i := 1 to ROUND(RegDes.Nro_Cupones) do
            fSaldoInsolutoCupon := fSaldoInsolutoCupon +
                                   Array_Mem_Desarr[i].Amortizacion;
}
      end;

   if sValorizacion_Proceso = 'SI' then
      Obtener_Tasa_base_mem(sTasa_Base
                    ,iDiasBaseTasa
                    ,sTipoInteres
                    ,iBaseMensual
                    ,sTipoCalculoDias
                    ,iVigenciaValor
                    ,iVigenciaMeses
                    ,sPais_Tasa
                    ,sModulo_err
                    ,sString_err
                    ,Result)
   else
      Obtener_Tasa_base(sTasa_Base
                    ,iDiasBaseTasa
                    ,sTipoInteres
                    ,iBaseMensual
                    ,sTipoCalculoDias
                    ,iVigenciaValor
                    ,iVigenciaMeses
                    ,sPais_Tasa
                    ,sModulo_err
                    ,sString_err
                    ,Result);
   if Not Result then
      exit;

   // POR SI ES TASA VARIABLE
   iDiasBaseTasa := Array_Mem_Desarr[iCuponVigente].Dias_Base_PAR;
   if sValorizacion_Proceso = 'SI' then
      Obtener_Base_Conversion_Mem(RegDes.Tasa_Valor_PAR
                                 ,sTipo_Tasa
                                 ,fPeriodo_Tasa
                                 ,sAnualidad_Tasa
                                 ,fBase_Porcen_Tasa
                                 ,sModulo_Err
                                 ,sString_Err
                                 ,Result)
   else
      Obtener_Base_Conversion(RegDes.Tasa_Valor_PAR
                             ,sTipo_Tasa
                             ,fPeriodo_Tasa
                             ,sAnualidad_Tasa
                             ,fBase_Porcen_Tasa
                             ,sModulo_Err
                             ,sString_Err
                             ,Result);
   if NOT Result then
      exit;

   if iCuponVigente > 1 then
      dFechaVctoAnterior := Array_Mem_Desarr[iCuponVigente -1].Fecha_Vcto
   else
      dFechaVctoAnterior := dFecha_Emision;

   // Calculo el Nro de dias entre el vcto anterior y fecha de calculo
   Calculo_de_dias(dFechaVctoAnterior,
                   dFecha_Calculo,
                   sTipoCalculoDias,
                   sPais_Tasa,
                   iDiasDif,
                   iAnosEnteros,
                   iAnosFraccion,
                   iMesesEnteros);

   if sTipoInteres = 'C' then
      fInteres := Interes_Compuesto(fTasaCalculo
                                   ,fBase_Porcen_Tasa
                                   ,iDiasDif
                                   ,iDiasBaseTasa)
   else
      fInteres := Interes_Simple(fTasaCalculo
                                ,fBase_Porcen_Tasa
                                ,iDiasDif
                                ,iDiasBaseTasa);

   {Calculo del valor en base CONVERSION}
   fValor := fSaldoInsolutoCupon * fInteres;

end;


end.
