unit Tabla_Mem_Desarr_TFija;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,  DM_ComunInversiones,DM_Variables_Valorizacion,
  DM_Variables_Menu, DM_FuncionesMemory, Wwtable,DM_Global_Var, Wwdatsrc,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  System.Variants, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.SQLiteVDataSet, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
    TDM_Tabla_Mem_Desarr_TFija = class(TDataModule)
    Qry_Tabla_Desarr_Prdx: TFDQuery;
    Table_FutImplicit: TFDMemTable;
    Qry_Tabla_Desarr: TFDQuery;
    Query1: TFDQuery;
    FDConnection1: TFDConnection;
    Table_FutImplicitItem: TFloatField;
    Table_FutImplicitDias_Desde: TFloatField;
    Table_FutImplicitDias_Hasta: TFloatField;
    Table_FutImplicitValor: TFloatField;
    Table_FutImplicitValor_Implicito: TFloatField;
    Table_FutImplicitBase_Porcentual: TFloatField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    Table_Ult_Tasa: TFDMemTable;
    FDLocalSQL1: TFDLocalSQL;
    Table_Ult_TasaCodigo_Tasa: TStringField;
    Table_Ult_TasaFecha_Calculo: TDateTimeField;
    Table_Ult_TasaValorTasa: TFloatField;
    Table_Ult_TasaFecha_Inic_Periodo: TDateTimeField;
    Table_Ult_TasaFecha_Vcto_Periodo: TDateTimeField;
    Qry_Carga_mem_desarr_TFlot: TFDQuery;
    Qry_carga_Mem_Desarr_TFija: TFDQuery;
    Qry_NemFechas: TFDQuery;
    Qry_Max_Fija: TFDQuery;
    Qry_Max_Flotante: TFDQuery;
    Qry_TasaBaseVar: TFDQuery;
    Qry_Max_Prepago: TFDQuery;
    Qry_Max_Fija_Vig: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
//------------------------------------------------------------------------------
Function Existe_Tabla_Desarr_Prepago( sCodigo_Emisor,
                                      sCodigo_Instrumento,
                                      sSerie    : String
                                     ) : Boolean ;

Function Existe_Tabla_Desarr_Prepago_Vig( sCodigo_Emisor,
                                          sCodigo_Instrumento,
                                          sSerie     : String;
                                          dFecha_Vig :TDateTime
                                         ) : Boolean ;


 procedure carga_Mem_Desarr_Prepago(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   sCodigo_Emisor,
                                   sCodigo_Instrumento,
                                   sSerie,
                                   sTipoAmortizacion      : String;
                                   iNroCupones            : Integer;
                                   fTasa_Emision          : Double;
                                   var Modulo_Err         : String;
                                   var String_Err         : String;
                                   var Result             : Boolean);

 procedure carga_Mem_Desarr_Prepago_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                       sCodigo_Emisor,
                                       sCodigo_Instrumento,
                                       sSerie,
                                       sTipoAmortizacion      : String;
                                       iNroCupones            : Integer;
                                       fTasa_Emision          : Double;
                                       dFecha_Vig             : TDateTime;
                                       var Modulo_Err         : String;
                                       var String_Err         : String;
                                       var Result             : Boolean);

  procedure carga_Mem_Desarr(var Array_Mem_Desarr : TArray_Mem_Desarr;
                             sNemotecnico         : String;
                             var RegDes           : TReg_Descriptor;
                             var Registro_Fechas  : TRegistro_Fechas;
                             sMetodo_Tasa_Referen : String;
                             bConCupon            : Boolean;
                             bAnaliza_Excepcion   : Boolean;
                             var Modulo_Err       : String;
                             var String_Err       : String;
                             var Result           : Boolean);

  procedure carga_Mem_Desarr_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 sNemotecnico         : String;
                                 dFecha_Vig           : TDateTime;
                                 var RegDes           : TReg_Descriptor;
                                 var Registro_Fechas  : TRegistro_Fechas;
                                 sMetodo_Tasa_Referen : String;
                                 bConCupon            : Boolean;
                                 bAnaliza_Excepcion   : Boolean;
                                 var Modulo_Err       : String;
                                 var String_Err       : String;
                                 var Result           : Boolean);

  procedure Inicializa_Mem_Desarr(var Array_Mem_Desarr : TArray_Mem_Desarr);

  procedure carga_Mem_Desarr_TFija_Prdx(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                        sCodigo_Emisor,
                                        sCodigo_Instrumento,
                                        sSerie,
                                        sTipoAmortizacion      : String;
                                        iNroCupones            : Integer;
                                        fTasa_Emision          : Double;
                                        var Modulo_Err         : String;
                                        var String_Err         : String;
                                        var Result            : Boolean
                                        );

  procedure carga_Mem_Desarr_TFija(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   sCodigo_Emisor,
                                   sCodigo_Instrumento,
                                   sSerie,
                                   sValida_unCupon        : String;   //sTipoAmortizacion      : String;
                                   iNroCupones            : Integer;
                                   fTasa_Emision          : Double;
                                   var Modulo_Err         : String;
                                   var String_Err         : String;
                                   var bResult            : Boolean);
  procedure carga_Mem_Desarr_TFija_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   sCodigo_Emisor,
                                   sCodigo_Instrumento,
                                   sSerie                 : String;
                                   dFecha_Vig             : TDateTime;
                                   sValida_unCupon        : String;   //sTipoAmortizacion      : String;
                                   iNroCupones            : Integer;
                                   fTasa_Emision          : Double;
                                   var Modulo_Err         : String;
                                   var String_Err         : String;
                                   var Result             : Boolean);

  procedure carga_Mem_Desarr_TFlot(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   RegDes               : TReg_Descriptor;
                                   var Modulo_Err       : String;
                                   var String_Err       : String;
                                   var Result           : Boolean);

  procedure Actualiza_Fechas_Vencimiento(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                         sNemotecnico         : String;
                                         dFecha_Compra        : TdateTime;
                                         var RegDes           : TReg_Descriptor;
                                         dFecha_Emision       : TDateTime;
                                         Registro_Fechas      : TRegistro_Fechas;
                                         var Modulo_Err       : String;
                                         var String_Err       : String;
                                         var Result           : Boolean);

  procedure Actualiza_Fechas_Vencimiento_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                             sNemotecnico         : String;
                                             dFecha_Vig           : TdateTime;
                                             dFecha_Compra        : TdateTime;
                                             var RegDes           : TReg_Descriptor;
                                             dFecha_Emision       : TDateTime;
                                             Registro_Fechas      : TRegistro_Fechas;
                                             var Modulo_Err       : String;
                                             var String_Err       : String;
                                             var Result           : Boolean);

  procedure Cupon_Vigente(var Array_Mem_Desarr : TArray_Mem_Desarr;
                          RegDes               : TReg_Descriptor;
                          dFecha               : TDateTime;
                          bConCupon            : Boolean;
                          var iCuponVigente    : Integer;
                          var Modulo_Err       : String;
                          var String_Err       : String;
                          var Result           : Boolean); overload

  procedure Cupon_Vigente(var Array_Mem_Desarr : TArray_Mem_Desarr;
                          RegDes               : TReg_Descriptor;
                          dFecha               : TDateTime;
                          bConCupon            : Boolean;
                          bFecha_Liq           : Boolean;
                          var iCuponVigente    : Integer;
                          var Modulo_Err       : String;
                          var String_Err       : String;
                          var Result           : Boolean); overload

  procedure Carga_Mem_Desarr_Unicos(sTipo_Nominales        : String;
                                    fNominales             : Double;
                                    fTasa_Emision          : Double;
                                    dFecha_Emision         : TDateTime;
                                    dFecha_Vencimiento     : TDateTime;
                                    dFecha_Calculo         : TDateTime;                                    
                                    sTasa_Base             : String;
                                    var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                    var RegDes             : TReg_Descriptor;
                                    sParametros_Formula    : TRegFormulaPAR;                                    
                                    var Modulo_Err         : String;
                                    var String_Err         : String;
                                    var Result             : Boolean);

  procedure Calcula_Valores_Tasa_Flotante(var Reg_Descriptor          : TReg_descriptor;
                                          Registro_Fechas         : TRegistro_Fechas;
                                          sMetodo_Tasa_Referencia : String;
                                          bConCupon               : Boolean;
                                          var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                          var sModulo_Err         : String;
                                          var sString_Err         : String;
                                          var Result              : Boolean);

  function Capitaliza_Intereses(var Array_Mem_Desarr : TArray_Mem_Desarr) : Boolean;

  function Con_Cupones_Cortados(dFecha_Calculo : TDateTime;
                                RegDes         : TReg_descriptor;
                                bConCupon      : Boolean;
                                var Array_Mem_Desarr : TArray_Mem_Desarr;
                                var Modulo_Err       : String;
                                var String_Err       : String;
                                var Err_Result           : Boolean) : Boolean;

procedure Verifica_Cupones_Cortados(sEmpresa        : String;
                                    sCartera        : String;
                                    sTransaccion    : String;
                                    sFolio_Interno  : String;
                                    fItem_Omd       : Double;
                                    dFecha_Analisis : TDateTime;
                                    Reg_Val_Out       : TRegistro_Valoriza_Out;
                                var iCupones_cortados : Integer;
                                var Modulo_Err        : String;
                                var String_Err        : String;
                                var Result            : Boolean
                                );

function carga_tasa_flotante_unico(sParametros_Formula : TRegFormulaPAR;
                                  dFecha_Calculo       : TDateTime;
                                  sTasa_Base           : String;
                               var RegDes              : TReg_Descriptor;
                               var Array_Mem_Desarr    : TArray_Mem_Desarr;
                               var fTasa_Emision       : Double;
                               var sTipo_Nominales     : String;
                               var Modulo_Err          : String;
                               var String_Err          : String) :Boolean;


var
  DM_Tabla_Mem_Desarr_TFija: TDM_Tabla_Mem_Desarr_TFija;

implementation
uses DM_Excepcion_Calculos,
     Funciones_Valorizacion,
     DM_Comun,
     DM_Base_Datos,
     DateUtil;

{$R *.DFM}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
procedure Asigna_Numero_de_cupones ( var Array_Mem_Desarr : TArray_mem_Desarr;
                                     sTipo_Tabla : String;
                                     sEmisor      : String ;
                                     sInstrumento : String;
                                     sSerie       : String;
                                     dFecha_Vig   : TDateTime;
                                     var sModulo_Err  : String;
                                     var sString_Err  : String;
                                     var Result       : Boolean );
begin
  if sTipo_Tabla = 'FLOTANTE' then
  begin
//          select MAX(CUPON_HASTA)
//          from QS_FIN_DEF_DESFLOT
//          WHERE SERIE = :SERIE
//          AND CODIGO_INSTRUMENTO = :INSTRUMENTO
//          AND CODIGO_IDENTIDAD = :EMISOR
       DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.ParamByName('Emisor').AsString := sEmisor;
       DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.ParamByName('Instrumento').AsString := sInstrumento;
       DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.ParamByName('Serie').AsString := sSerie;

       DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.Open;
       if (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger = 0) OR
          (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').IsNull)      then
          begin
            DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.Close;
            sModulo_Err := 'Carga Tabla Desarrollo';
            sString_Err := 'No se encontro Tabla de desarrollo para:'+#10
                          +' Emisor = '+sEmisor
                          +' Instrumento = '+sInstrumento
                          +' Serie = '+sSerie;

            Result := False;
            exit;
          end;

       if (length(Array_Mem_Desarr) <
          DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger+1 )  then
       begin
          SetLength(Array_Mem_Desarr,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger+1);
       end;
// Lo movimos al descuenta flujos
//  SetLength(Array_Mem_Amortizacion_Actual_Cost,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger+1);

       Max_Nro_Cupones := DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger;

       DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.Close;


  end
  else
      if sTipo_Tabla = 'FIJA' then
      begin
    //          SELECT MAX(NUMERO_DE_CUPON)  as Ultimo_Cupon
    //          from QS_FIN_DESARR
    //          WHERE SERIE = :SERIE
    //          AND CODIGO_INSTRUMENTO = :INSTRUMENTO
    //          AND CODIGO_EMISOR  = :EMISOR

           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.ParamByName('Emisor').AsString := sEmisor;
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.ParamByName('Instrumento').AsString := sInstrumento;
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.ParamByName('Serie').AsString := sSerie;

           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.Open;
           if (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.FieldByName('Ultimo_Cupon').AsInteger = 0) OR
              (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.FieldByName('Ultimo_Cupon').IsNull)      then
              begin
                DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.Close;
                sModulo_Err := 'Carga Tabla Desarrollo';
                sString_Err := 'No se encontro Tabla de desarrollo para:'+#10
                              +' Emisor = '+sEmisor
                              +' Instrumento = '+sInstrumento
                              +' Serie = '+sSerie;

                Result := False;
                exit;
              end;

           if (length(Array_Mem_Desarr) <
              DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.FieldByName('Ultimo_Cupon').AsInteger+1 )  then
           begin
              SetLength(Array_Mem_Desarr,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.FieldByName('Ultimo_Cupon').AsInteger+1);
           end;
          // Lo movimos al descuenta flujos
          //  SetLength(Array_Mem_Amortizacion_Actual_Cost,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger+1);
           Max_Nro_Cupones := DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.FieldByName('Ultimo_Cupon').AsInteger;
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija.Close;

      end
      else
        if sTipo_Tabla = 'PREPAGO' then
        begin

             DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.ParamByName('Emisor').AsString := sEmisor;
             DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.ParamByName('Instrumento').AsString := sInstrumento;
             DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.ParamByName('Serie').AsString := sSerie;

             DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.Open;
             if (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger = 0) OR
                (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').IsNull)      then
                begin
                  DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.Close;
                  sModulo_Err := 'Carga Tabla Desarrollo';
                  sString_Err := 'No se encontro Tabla de desarrollo para:'+#10
                                +' Emisor = '+sEmisor
                                +' Instrumento = '+sInstrumento
                                +' Serie = '+sSerie;

                  Result := False;
                  exit;
                end;

             if (length(Array_Mem_Desarr) <
                DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger+1 )  then
             begin
                SetLength(Array_Mem_Desarr,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger+1);
             end;
            // Lo movimos al descuenta flujos
            //  SetLength(Array_Mem_Amortizacion_Actual_Cost,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger+1);
             Max_Nro_Cupones := DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger;
             DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.Close;

        end
        else
        if sTipo_Tabla = 'FIJA-VIG' then
        begin
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.ParamByName('Emisor').AsString := sEmisor;
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.ParamByName('Instrumento').AsString := sInstrumento;
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.ParamByName('Serie').AsString := sSerie;
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.ParamByName('Fecha_Vig').AsDateTime := dFecha_Vig;

           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.Open;
           if (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.FieldByName('Ultimo_Cupon').AsInteger = 0) OR
              (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.FieldByName('Ultimo_Cupon').IsNull)      then
              begin
                DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.Close;
                sModulo_Err := 'Carga Tabla Desarrollo';
                sString_Err := 'No se encontro Tabla de desarrollo para:'+#10
                              +' Emisor = '+sEmisor
                              +' Instrumento = '+sInstrumento
                              +' Serie = '+sSerie;

                Result := False;
                exit;
              end;

           if (length(Array_Mem_Desarr) <
              DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.FieldByName('Ultimo_Cupon').AsInteger+1 )  then
           begin
              SetLength(Array_Mem_Desarr,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.FieldByName('Ultimo_Cupon').AsInteger+1);
           end;
           Max_Nro_Cupones := DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.FieldByName('Ultimo_Cupon').AsInteger;
           DM_Tabla_Mem_Desarr_TFija.Qry_Max_Fija_Vig.Close;
        end
        else
          if sTipo_Tabla = 'PREPAGO-VIG' then
          begin

               DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.ParamByName('Emisor').AsString := sEmisor;
               DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.ParamByName('Instrumento').AsString := sInstrumento;
               DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.ParamByName('Serie').AsString := sSerie;

               DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.Open;
               if (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger = 0) OR
                  (DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').IsNull)      then
                  begin
                    DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.Close;
                    sModulo_Err := 'Carga Tabla Desarrollo';
                    sString_Err := 'No se encontro Tabla de desarrollo para:'+#10
                                  +' Emisor = '+sEmisor
                                  +' Instrumento = '+sInstrumento
                                  +' Serie = '+sSerie;

                    Result := False;
                    exit;
                  end;

               if (length(Array_Mem_Desarr) <
                  DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger+1 )  then
               begin
                  SetLength(Array_Mem_Desarr,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger+1);
               end;
              // Lo movimos al descuenta flujos
              //  SetLength(Array_Mem_Amortizacion_Actual_Cost,DM_Tabla_Mem_Desarr_TFija.Qry_Max_Flotante.FieldByName('Ultimo_Cupon').AsInteger+1);
               Max_Nro_Cupones := DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.FieldByName('Ultimo_Cupon').AsInteger;
               DM_Tabla_Mem_Desarr_TFija.Qry_Max_Prepago.Close;

          end
          else
          begin
                    sModulo_Err := 'Carga Tabla Desarrollo';
                    sString_Err := 'No existe implementacion para tabla de desarrollo '''+sTipo_Tabla+'''';
                    Result := False;

          end;
end;
//------------------------------------------------------------------------------

procedure carga_Mem_Desarr(var Array_Mem_Desarr : TArray_Mem_Desarr;
                           sNemotecnico         : String;
                           var RegDes           : TReg_Descriptor;
                           var Registro_Fechas  : TRegistro_Fechas;
                           sMetodo_Tasa_Referen : String;
                           bConCupon            : Boolean;
                           bAnaliza_Excepcion   : Boolean;
                           var Modulo_Err       : String;
                           var String_Err       : String;
                           var Result           : Boolean);
var
  i : Integer;
begin

  Result := True;
  if RegDes.Tasa_Flotante = 'S' then
      carga_Mem_Desarr_TFlot(Array_Mem_Desarr
                            ,RegDes
                            ,Modulo_Err
                            ,String_Err
                            ,Result)
  else
  begin
     if sValorizacion_Proceso = 'SI' then //Suponemos que en proceso se llenan las Variables
     begin
       {  if   ( RegDes.Codigo_Emisor_Old      <>  RegDes.Codigo_Emisor) //OJO
          or ( RegDes.Codigo_Instrumento_Old <>  RegDes.Codigo_Instrumento)
          or ( RegDes.Serie_Old              <>  RegDes.Serie) then }

       if sBuscar_Tabla_Desarrollo_Pdrx = 'SI' then
          carga_Mem_Desarr_TFija_Prdx(Array_Mem_Desarr
                                      ,RegDes.Codigo_Emisor
                                      ,RegDes.Codigo_Instrumento
                                      ,RegDes.Serie
                                      ,RegDes.Tipo_Amortizac
                                      ,ROUND(RegDes.Nro_Cupones)
                                      ,RegDes.Tasa_Emision
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result
                                      )
       else
          carga_Mem_Desarr_TFija(Array_Mem_Desarr
                                ,RegDes.Codigo_Emisor
                                ,RegDes.Codigo_Instrumento
                                ,RegDes.Serie
                                ,RegDes.Tipo_Amortizac
                                ,ROUND(RegDes.Nro_Cupones)
                                ,RegDes.Tasa_Emision
                                ,Modulo_Err
                                ,String_Err
                                ,Result);
     end
     else
        carga_Mem_Desarr_TFija(Array_Mem_Desarr
                              ,RegDes.Codigo_Emisor
                              ,RegDes.Codigo_Instrumento
                              ,RegDes.Serie
                              ,RegDes.Tipo_Amortizac
                              ,ROUND(RegDes.Nro_Cupones)
                              ,RegDes.Tasa_Emision
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
  end;
  if NOT Result then
     exit;

  // Asigna la fecha de vencimiento a cada cupon
  // ya sea por la definición en el descriptor o
  // por la definicion de fechas variables.
  Actualiza_Fechas_Vencimiento(Array_Mem_Desarr
                              ,sNemotecnico
                              ,Registro_Fechas.Fecha_Compra
                              ,RegDes
                              ,Registro_Fechas.Fecha_Emision
                              ,Registro_Fechas
                              ,Modulo_Err
                              ,String_Err
                              ,Result);
  if NOT Result then
     exit;

  Registro_Fechas.Fecha_Vencimiento := Array_Mem_Desarr[Round(RegDes.Nro_Cupones)].Fecha_Vcto;

  if RegDes.Tasa_Flotante = 'S' then
     Calcula_Valores_Tasa_Flotante(RegDes
                                  ,Registro_Fechas
                                  ,sMetodo_Tasa_Referen
                                  ,bConCupon
                                  ,Array_Mem_Desarr
                                  ,Modulo_Err
                                  ,String_Err
                                  ,Result)
  else
  begin
     // Variables que nuevas se llenan en multiples tasas pero que se requiere tambien esten
     // Cuando la tabla esta ingresada por tasa fija. Enero del 2010 F.I.
     For i := 1 TO Max_Nro_Cupones do
     begin
        Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra := Array_Mem_Desarr[i].Amortizacion;
        Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra := Array_Mem_Desarr[i].Saldo_Insoluto;
     end;
  end;

  if NOT Result then
     exit;

  For i := 1 TO Max_Nro_Cupones do
     begin
       Array_Mem_Desarr[i].Interes_Original        := Array_Mem_Desarr[i].Interes        ;
       Array_Mem_Desarr[i].Amortizacion_Original   := Array_Mem_Desarr[i].Amortizacion   ;
       Array_Mem_Desarr[i].Saldo_Insoluto_Original := Array_Mem_Desarr[i].Saldo_Insoluto ;
       Array_Mem_Desarr[i].Valor_Cupon_Original    := Array_Mem_Desarr[i].Valor_Cupon    ;
       if RegDes.Tasa_Flotante = 'N' then
          Array_Mem_Desarr[i].Saldo_insoluto_Sin_Capitalizaciones := Array_Mem_Desarr[i].Saldo_Insoluto;
     end;


  // Se preocupa del caso de variación cambiaria
  // y la aplica a los registros de la tabla en memoria
  // si corresponde
  if bAnaliza_Excepcion then
     Analiza_Excepcion_Variacion_Cambiaria(Array_Mem_Desarr
                                          ,RegDes.Codigo_Emisor
                                          ,RegDes.Codigo_Instrumento
                                          ,RegDes.Serie
                                          ,Registro_Fechas
                                          ,Modulo_Err
                                          ,String_Err
                                          ,Result);

  // Nuevo ya que no estaba redondeando los cupones segun la definición del descriptor
  // SOLO SE HACE PARA TITULOS QUE TIENEN VARIACION CAMBIARIA
  // No se esta aplicando a las tablas normales ya que en Chile se producirian diferencias
  // Lo anterior ya que existen descriptores que tienen el numero de decimales mal ingresado
  // 08/02/2006 F.I.
  For i := 1 TO Max_Nro_Cupones do
     begin
       if Array_Mem_Desarr[i].Factor_VarCam <> 1 then
       begin
          Array_Mem_Desarr[i].Interes        := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                 ,Array_Mem_Desarr[i].Interes
                                                                 ,Trunc(RegDes.Decimal_Ajuste));
          Array_Mem_Desarr[i].Amortizacion   := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                 ,Array_Mem_Desarr[i].Amortizacion
                                                                 ,Trunc(RegDes.Decimal_Ajuste));

          Array_Mem_Desarr[i].Saldo_Insoluto := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                 ,Array_Mem_Desarr[i].Saldo_Insoluto
                                                                 ,Trunc(RegDes.Decimal_Ajuste));

          Array_Mem_Desarr[i].Valor_Cupon    := Array_Mem_Desarr[i].Interes +
                                                Array_Mem_Desarr[i].Amortizacion +
                                                Array_Mem_Desarr[i].Reajuste_Capital_Pagado;
       end;

       {
       Array_Mem_Desarr[i].Interes_Original := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                ,Array_Mem_Desarr[i].Interes_Original
                                                                ,Trunc(RegDes.Decimal_Ajuste));

       Array_Mem_Desarr[i].Amortizacion_Original := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                ,Array_Mem_Desarr[i].Amortizacion_Original
                                                                ,Trunc(RegDes.Decimal_Ajuste));

       Array_Mem_Desarr[i].Saldo_Insoluto_Original := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                ,Array_Mem_Desarr[i].Saldo_Insoluto_Original
                                                                ,Trunc(RegDes.Decimal_Ajuste));

       Array_Mem_Desarr[i].Valor_Cupon_Original    := Array_Mem_Desarr[i].Interes_Original +
                                                      Array_Mem_Desarr[i].Amortizacion_Original;
       }
     end;
end;
//------------------------------------------------------------------------------
procedure carga_Mem_Desarr_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                               sNemotecnico         : String;
                               dFecha_Vig           : TDateTime;
                               var RegDes               : TReg_Descriptor;
                               var Registro_Fechas  : TRegistro_Fechas;
                               sMetodo_Tasa_Referen : String;
                               bConCupon            : Boolean;
                               bAnaliza_Excepcion   : Boolean;
                               var Modulo_Err       : String;
                               var String_Err       : String;
                               var Result           : Boolean);
var
  i : Integer;
begin
  Result := True;
  if RegDes.Tasa_Flotante = 'S' then
      carga_Mem_Desarr_TFlot(Array_Mem_Desarr
                            ,RegDes
                            ,Modulo_Err
                            ,String_Err
                            ,Result)
  else
  begin
     if sValorizacion_Proceso = 'SI' then //Suponemos que en proceso se llenan las Variables
     begin
       {  if   ( RegDes.Codigo_Emisor_Old      <>  RegDes.Codigo_Emisor) //OJO
          or ( RegDes.Codigo_Instrumento_Old <>  RegDes.Codigo_Instrumento)
          or ( RegDes.Serie_Old              <>  RegDes.Serie) then }

       if sBuscar_Tabla_Desarrollo_Pdrx = 'SI' then
          carga_Mem_Desarr_TFija_Prdx(Array_Mem_Desarr
                                      ,RegDes.Codigo_Emisor
                                      ,RegDes.Codigo_Instrumento
                                      ,RegDes.Serie
                                      ,RegDes.Tipo_Amortizac
                                      ,ROUND(RegDes.Nro_Cupones)
                                      ,RegDes.Tasa_Emision
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result
                                      )
       else
          carga_Mem_Desarr_TFija_Vig(Array_Mem_Desarr
                                    ,RegDes.Codigo_Emisor
                                    ,RegDes.Codigo_Instrumento
                                    ,RegDes.Serie
                                    ,dFecha_Vig    //RegDes.Fecha_Vig
                                    ,RegDes.Tipo_Amortizac
                                    ,ROUND(RegDes.Nro_Cupones)
                                    ,RegDes.Tasa_Emision
                                    ,Modulo_Err
                                    ,String_Err
                                    ,Result);
     end
     else
        carga_Mem_Desarr_TFija_Vig(Array_Mem_Desarr
                                  ,RegDes.Codigo_Emisor
                                  ,RegDes.Codigo_Instrumento
                                  ,RegDes.Serie
                                  ,dFecha_Vig    //RegDes.Fecha_Vig
                                  ,RegDes.Tipo_Amortizac
                                  ,ROUND(RegDes.Nro_Cupones)
                                  ,RegDes.Tasa_Emision
                                  ,Modulo_Err
                                  ,String_Err
                                  ,Result);
  end;
  if NOT Result then
     exit;

  // Asigna la fecha de vencimiento a cada cupon
  // ya sea por la definición en el descriptor o
  // por la definicion de fechas variables.
  Actualiza_Fechas_Vencimiento_Vig(Array_Mem_Desarr
                                  ,sNemotecnico
                                  ,dFecha_vig
                                  ,Registro_Fechas.Fecha_Compra
                                  ,RegDes
                                  ,Registro_Fechas.Fecha_Emision
                                  ,Registro_Fechas
                                  ,Modulo_Err
                                  ,String_Err
                                  ,Result);
  if NOT Result then
     exit;

  {      ¿EDUARDO, PORQUE ESTA COMENTADO ESTE ERROR  en la super lo tuve que rutiar para encontrarlo?
  if (Registro_Fechas.Fecha_Vencimiento <> Array_Mem_Desarr[Round(RegDes.Nro_Cupones)].Fecha_Vcto) then
  begin
    Modulo_Err := 'Carga_Mem_Desarr_TFija_Vig';
    String_Err := 'Inconsistencia entre fecha de vencimiento nemo y la generada segun descriptor ('
                 + FormatDateTime('dd/mm/yyyy',Registro_Fechas.Fecha_Vencimiento)
                 +' y '
                 + FormatDateTime('dd/mm/yyyy',Array_Mem_Desarr[Round(RegDes.Nro_Cupones)].Fecha_Vcto)
                 +')';
    Result := False;
    exit;
  end;
  }

  Registro_Fechas.Fecha_Vencimiento := Array_Mem_Desarr[Round(RegDes.Nro_Cupones)].Fecha_Vcto;

  if RegDes.Tasa_Flotante = 'S' then
     Calcula_Valores_Tasa_Flotante(RegDes
                                  ,Registro_Fechas
                                  ,sMetodo_Tasa_Referen
                                  ,bConCupon
                                  ,Array_Mem_Desarr
                                  ,Modulo_Err
                                  ,String_Err
                                  ,Result);

  if NOT Result then
     exit;

  For i := 1 TO Max_Nro_Cupones do
     begin
       Array_Mem_Desarr[i].Interes_Original        := Array_Mem_Desarr[i].Interes        ;
       Array_Mem_Desarr[i].Amortizacion_Original   := Array_Mem_Desarr[i].Amortizacion   ;
       Array_Mem_Desarr[i].Saldo_Insoluto_Original := Array_Mem_Desarr[i].Saldo_Insoluto ;
       Array_Mem_Desarr[i].Valor_Cupon_Original    := Array_Mem_Desarr[i].Valor_Cupon    ;
       if RegDes.Tasa_Flotante = 'N' then
          Array_Mem_Desarr[i].Saldo_insoluto_Sin_Capitalizaciones := Array_Mem_Desarr[i].Saldo_Insoluto;
     end;


  // Se preocupa del caso de variación cambiaria
  // y la aplica a los registros de la tabla en memoria
  // si corresponde
  if bAnaliza_Excepcion then
     Analiza_Excepcion_Variacion_Cambiaria(Array_Mem_Desarr
                                          ,RegDes.Codigo_Emisor
                                          ,RegDes.Codigo_Instrumento
                                          ,RegDes.Serie
                                          ,Registro_Fechas
                                          ,Modulo_Err
                                          ,String_Err
                                          ,Result);

  // Nuevo ya que no estaba redondeando los cupones segun la definición del descriptor
  // SOLO SE HACE PARA TITULOS QUE TIENEN VARIACION CAMBIARIA
  // No se esta aplicando a las tablas normales ya que en Chile se producirian diferencias
  // Lo anterior ya que existen descriptores que tienen el numero de decimales mal ingresado
  // 08/02/2006 F.I.
  For i := 1 TO Max_Nro_Cupones do
     begin
       if Array_Mem_Desarr[i].Factor_VarCam <> 1 then
       begin
          Array_Mem_Desarr[i].Interes        := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                 ,Array_Mem_Desarr[i].Interes
                                                                 ,Trunc(RegDes.Decimal_Ajuste));
          Array_Mem_Desarr[i].Amortizacion   := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                 ,Array_Mem_Desarr[i].Amortizacion
                                                                 ,Trunc(RegDes.Decimal_Ajuste));

          Array_Mem_Desarr[i].Saldo_Insoluto := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                 ,Array_Mem_Desarr[i].Saldo_Insoluto
                                                                 ,Trunc(RegDes.Decimal_Ajuste));

          Array_Mem_Desarr[i].Valor_Cupon    := Array_Mem_Desarr[i].Interes +
                                                Array_Mem_Desarr[i].Amortizacion +
                                                Array_Mem_Desarr[i].Reajuste_Capital_Pagado;
       end;

       {
       Array_Mem_Desarr[i].Interes_Original := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                ,Array_Mem_Desarr[i].Interes_Original
                                                                ,Trunc(RegDes.Decimal_Ajuste));

       Array_Mem_Desarr[i].Amortizacion_Original := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                ,Array_Mem_Desarr[i].Amortizacion_Original
                                                                ,Trunc(RegDes.Decimal_Ajuste));

       Array_Mem_Desarr[i].Saldo_Insoluto_Original := ajusta_decimales( RegDes.Tipo_Ajuste
                                                                ,Array_Mem_Desarr[i].Saldo_Insoluto_Original
                                                                ,Trunc(RegDes.Decimal_Ajuste));

       Array_Mem_Desarr[i].Valor_Cupon_Original    := Array_Mem_Desarr[i].Interes_Original +
                                                      Array_Mem_Desarr[i].Amortizacion_Original;
       }
     end;


end;
//------------------------------------------------------------------------------
procedure Inicializa_Mem_Desarr(var Array_Mem_Desarr : TArray_Mem_Desarr);
var
  i : Integer;
begin

    For i := 1 TO Max_Nro_Cupones do
    begin
      Array_Mem_Desarr[i].Nro_Cupon          := 0;
      Array_Mem_Desarr[i].Tipo_Tasa          := '';
      Array_Mem_Desarr[i].Tratamiento        := '';
      Array_Mem_Desarr[i].Operacion          := '';
      Array_Mem_Desarr[i].Factor             := 0;
      Array_Mem_Desarr[i].Amortizacion       := 0;
      Array_Mem_Desarr[i].Interes            := 0;
      Array_Mem_Desarr[i].Reajuste_Capital_Pagado := 0;
      Array_Mem_Desarr[i].Saldo_Insoluto     := 0;
      Array_Mem_Desarr[i].Valor_Tasa         := 0;
      Array_Mem_Desarr[i].Factor_Cap         := 0;
      Array_Mem_Desarr[i].Capitalizado       := 0;
      Array_Mem_Desarr[i].Capitalizado_Cupon := 0;
      Array_Mem_Desarr[i].Valor_Cupon        := 0;
      Array_Mem_Desarr[i].Tasa_Flujo         := 0;
      Array_Mem_Desarr[i].Dias_Al_Vcto       := 0;
      Array_Mem_Desarr[i].Tasa_Basica        := 0;
      Array_Mem_Desarr[i].Tasa_Riesgo        := 0;
      Array_Mem_Desarr[i].Tasa_de_Descuento  := 0;
      Array_Mem_Desarr[i].Factor_Descuento   := 0;
      Array_Mem_Desarr[i].Real_Estimado      := '';
      Array_Mem_Desarr[i].Valoriza_Con_TDesc := 'N';
      Array_Mem_Desarr[i].Interes_Original        := 0;
      Array_Mem_Desarr[i].Amortizacion_Original   := 0;
      Array_Mem_Desarr[i].Valor_Cupon_Original    := 0;
      Array_Mem_Desarr[i].Saldo_Insoluto_Original := 0;
      Array_Mem_Desarr[i].Cupon_Cortado           := False;
      Array_Mem_Desarr[i].Factor_Varcam           := 1;
      Array_Mem_Desarr[i].Cod_Moneda_Ind          := '';
      Array_Mem_Desarr[i].Cod_Tratam_Inicio       := '';
      Array_Mem_Desarr[i].Cod_Tratam_Termino      := '';
      Array_Mem_Desarr[i].Dias_Base_PAR           := 0;
      Array_Mem_Desarr[i].Periodos_Tasa_Base_Variable := 0;
      Array_Mem_Desarr[i].Saldo_insoluto_Sin_Capitalizaciones := 0;

      Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra := 0; // 05-01-2010 F.I. Ver comentario en DM_Variables_Valorizacion
      Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra := 0;
      Array_Mem_Desarr[i].Capitalizado_Segun_Fecha_de_Compra   := 0;

      Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo                         := 0; // 05-01-2010 F.I. Ver comentario en DM_Variables_Valorizacion
      Array_Mem_Desarr[i].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo       := 0;
      Array_Mem_Desarr[i].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado := 0;

      Array_Mem_Desarr[i].Fecha_Vcto          := 0;
      Array_Mem_Desarr[i].Fecha_Tasa_Flotante := 0;

      // 05-02-2015 F.I.
      Array_Mem_Desarr[i].Curva_Proy_utilizada	   := '';
      Array_Mem_Desarr[i].Dias_Proyeccion	   := 0;     
      Array_Mem_Desarr[i].Tasa_Proyeccion	   := 0;     
      Array_Mem_Desarr[i].FD_Proyeccion_fin	   := 0;     
      Array_Mem_Desarr[i].FD_Proyeccion_Inicio	   := 0;
      Array_Mem_Desarr[i].Valor_Tasa_Descuento     := 0;
    end;
end;
//------------------------------------------------------------------------------
procedure carga_Mem_Desarr_TFija(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 sCodigo_Emisor,
                                 sCodigo_Instrumento,
                                 sSerie,
                                 sValida_unCupon        : String;   //sTipoAmortizacion      : String;
                                 iNroCupones            : Integer;
                                 fTasa_Emision          : Double;
                                 var Modulo_Err         : String;
                                 var String_Err         : String;
                                 var bResult            : Boolean);
var
   i : Integer;
begin
    bResult := True;

     Asigna_Numero_de_cupones ( Array_Mem_Desarr
                               ,'FIJA'
                               ,sCodigo_Emisor
                               ,sCodigo_Instrumento
                               ,sSerie
                               ,0
                               ,Modulo_Err
                               ,String_Err
                               ,bResult    );
     if NOT bResult then
        exit;


    Inicializa_Mem_Desarr(Array_Mem_Desarr);
    WITH DM_Tabla_Mem_Desarr_TFija.Qry_carga_Mem_Desarr_TFija do
    begin
//       DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Clear;
//       DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Add(' SELECT Numero_de_Cupon '
//                               +'       ,Interes_Cupon   '
//                               +'       ,Amortiz_Cupon   '
//                               +'       ,Saldo_Insol_Cupon '
//                               +'   FROM QS_FIN_DESARR     '
//                               +'  WHERE Serie = :Serie     '
//                               +'    AND Codigo_Instrumento = :Codigo_Instrumento '
//                               +'    AND Codigo_Emisor = :Codigo_Emisor           ');
//
//       If sValida_unCupon <> 'S' then
//          DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Add(' ORDER By Numero_de_Cupon ');

       ParamByName('Serie').AsString              := sSerie;
       ParamByName('Codigo_Instrumento').AsString := sCodigo_Instrumento;
       ParamByName('Codigo_Emisor').AsString      := sCodigo_Emisor;
       Open;
       i := 1;
       WHILE NOT EOF DO
       begin
          If sValida_unCupon = 'S' then
          begin
            Close;
            bResult := True;
            exit;
          end;

          if i > Max_Nro_Cupones then
          begin
            Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
            String_Err := 'Se detecto problema con máximo de cupones.'#10
                         +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                         +'Se aborta proceso. Contactese con soporte PMS';
            Close;
            bResult := False;
            exit;
          end;

          Array_Mem_Desarr[i].Nro_Cupon         := FieldByName('Numero_de_Cupon').AsInteger;
          Array_Mem_Desarr[i].Tasa_Flujo        := fTasa_Emision;
          Array_Mem_Desarr[i].Valor_Tasa        := fTasa_Emision;
          Array_Mem_Desarr[i].Interes           := FieldByName('Interes_Cupon').AsFloat;
          Array_Mem_Desarr[i].Amortizacion      := FieldByName('Amortiz_Cupon').AsFloat;
          Array_Mem_Desarr[i].Saldo_Insoluto    := FieldByName('Saldo_Insol_Cupon').AsFloat;
          Array_Mem_Desarr[i].Valor_Cupon       := Array_Mem_Desarr[i].Interes +
                                                         Array_Mem_Desarr[i].Amortizacion;
          Next;
          Inc(i);

       end; // End While
       i := i - 1;  // El indice queda pasado en 1
       Close;
    end;//end with

    if (NOT bResult) and
     (i > Max_Nro_Cupones) then
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
        String_Err := 'Se detecto problema con maximo de cupones.'#10
                     +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                     +'Se aborta proceso. Contactese con el Administrador';
        bResult := False;
        exit;
     end;

     if (i = 0) then  // No encontro ningun cupon
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
        String_Err := 'No se encontró Tabla de Desarrollo para: '#10
                      +'Emisor      : '+sCodigo_Emisor+' '#10
                      +'Instrumento : '+sCodigo_Instrumento+' '#10
                      +'Serie       : '+sSerie+' '#10;
        bResult := False;
        exit;
     end;

    if (i <> iNroCupones) then  // Inconsistencia
    begin
       bResult := False;
       Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
       String_Err := 'Existe una inconsistencia entre los cupones'#10
                     +'indicados en el descriptor y los encontrados'#10
                     +'en la tabla de desarrollo para:'#10
                     +'Emisor      : '+sCodigo_Emisor+' '#10
                     +'Instrumento : '+sCodigo_Instrumento+' '#10
                     +'Serie       : '+sSerie+' '#10
                     +'En Descriptor : '+inttostr(iNroCupones)+' cupones.'#10
                     +'En Tabla de desarrollo : '+inttostr(i)+' cupones.';
       exit;
    end;
end;
//------------------------------------------------------------------------------
procedure carga_Mem_Desarr_TFija_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 sCodigo_Emisor,
                                 sCodigo_Instrumento,
                                 sSerie                 : String;
                                 dFecha_Vig             : TDateTime;
                                 sValida_unCupon        : String;   //sTipoAmortizacion      : String;
                                 iNroCupones            : Integer;
                                 fTasa_Emision          : Double;
                                 var Modulo_Err         : String;
                                 var String_Err         : String;
                                 var Result             : Boolean);
var
   i : Integer;
begin
    Result := True;
    Inicializa_Mem_Desarr(Array_Mem_Desarr);

     Asigna_Numero_de_cupones ( Array_Mem_Desarr
                               ,'FIJA-VIG'
                               ,sCodigo_Emisor
                               ,sCodigo_Instrumento
                               ,sSerie
                               ,dFecha_Vig
                               ,Modulo_Err
                               ,String_Err
                               ,Result    );
     if NOT Result then
        exit;

    WITH DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr do
    begin
       DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Clear;
       DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Add(' SELECT Numero_de_Cupon '
                               +'       ,Interes_Cupon   '
                               +'       ,Amortiz_Cupon   '
                               +'       ,Saldo_Insol_Cupon '
                               +'   FROM QS_FIN_DESARR a    '
                               +'  WHERE Serie = :Serie     '
                               +'    AND Codigo_Instrumento = :Codigo_Instrumento '
                               +'    AND Codigo_Emisor = :Codigo_Emisor           ');
       if sDriver = 'ORACLE' then
          DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Add('    AND trunc(a.Fecha_Vig) in (SELECT MAX(trunc(x.Fecha_Vig)) ')
       else
          DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Add('    AND convert(CHAR(10),a.Fecha_Vig,103) in (SELECT MAX(convert(CHAR(10),x.Fecha_Vig,103)) ');

       DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Add('    FROM QS_FIN_DESARR x '
                               +'                             WHERE x.serie = a.serie '
                               +'                               AND x.Codigo_Instrumento = a.Codigo_Instrumento '
                               +'                               AND x.codigo_emisor = a.codigo_emisor '
                               +'                               AND x.Fecha_Vig <= :Fecha_Vig ) ');

       If sValida_unCupon <> 'S' then
          DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr.SQl.Add(' ORDER By Numero_de_Cupon ');

       ParamByName('Serie').AsString              := sSerie;
       ParamByName('Codigo_Instrumento').AsString := sCodigo_Instrumento;
       ParamByName('Codigo_Emisor').AsString      := sCodigo_Emisor;
       ParamByName('Fecha_Vig').AsDate        := dFecha_Vig;
       Open;
       i := 1;
       WHILE NOT EOF DO
       begin
          If sValida_unCupon = 'S' then
          begin
            Close;
            Result := True;
            exit;
          end;

          if i > Max_Nro_Cupones then
          begin
            Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
            String_Err := 'Se detecto problema con máximo de cupones.'#10
                         +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                         +'Se aborta proceso. Contactese con soporte PMS';
            Close;
            Result := False;
            exit;
          end;

          Array_Mem_Desarr[i].Nro_Cupon         := FieldByName('Numero_de_Cupon').AsInteger;
          Array_Mem_Desarr[i].Tasa_Flujo        := fTasa_Emision;
          Array_Mem_Desarr[i].Valor_Tasa        := fTasa_Emision;
          Array_Mem_Desarr[i].Interes           := FieldByName('Interes_Cupon').AsFloat;
          Array_Mem_Desarr[i].Amortizacion      := FieldByName('Amortiz_Cupon').AsFloat;
          Array_Mem_Desarr[i].Saldo_Insoluto    := FieldByName('Saldo_Insol_Cupon').AsFloat;
          Array_Mem_Desarr[i].Valor_Cupon       := Array_Mem_Desarr[i].Interes +
                                                         Array_Mem_Desarr[i].Amortizacion;
          Next;
          Inc(i);

       end; // End While
       Close;
    end;//end with

    i := i - 1;

    if (NOT Result) and
     (i > Max_Nro_Cupones) then
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
        String_Err := 'Se detecto problema con maximo de cupones.'#10
                     +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                     +'Se aborta proceso. Contactese con el Administrador';
        Result := False;
        exit;
     end;

     if (i = 0) then  // No encontro ningun cupon
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
        String_Err := 'No se encontró Tabla de Desarrollo para: '#10
                      +'Emisor      : '+sCodigo_Emisor+' '#10
                      +'Instrumento : '+sCodigo_Instrumento+' '#10
                      +'Serie       : '+sSerie+' '#10;
        Result := False;
        exit;
     end;

  if (i <> iNroCupones) then  // Inconsistencia
  begin
     Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
     String_Err := 'Existe una inconsistencia entre los cupones'#10
                   +'indicados en el descriptor y los encontrados'#10
                   +'en la tabla de desarrollo para:'#10
                   +'Emisor      : '+sCodigo_Emisor+' '#10
                   +'Instrumento : '+sCodigo_Instrumento+' '#10
                   +'Serie       : '+sSerie+' '#10
                   +'En Descriptor : '+inttostr(iNroCupones)+' cupones.'#10
                   +'En Tabla de desarrollo : '+inttostr(i)+' cupones.';
     Result := False;
     exit;
  end;
end;
//------------------------------------------------------------------------------
procedure carga_Mem_Desarr_TFlot(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                 RegDes               : TReg_Descriptor;
                                 var Modulo_Err       : String;
                                 var String_Err       : String;
                                 var Result           : Boolean);
var
   iNro_Cupon         : Integer;
   iCupon_Por_Crear   : Integer;
   fAmortiz_Acum      : Double;
begin
 Result := True;
 iCupon_Por_Crear := 1;
 fAmortiz_Acum    := 0;

  Asigna_Numero_de_cupones ( Array_Mem_Desarr
                           ,'FLOTANTE'
                           ,RegDes.Codigo_Emisor
                           ,RegDes.Codigo_Instrumento
                           ,RegDes.Serie
                           ,0
                           ,Modulo_Err
                           ,String_Err
                           ,Result    );
 if NOT Result then
    exit;

     iNro_Cupon := 1;
     Inicializa_Mem_Desarr(Array_Mem_Desarr);

     WITH DM_Tabla_Mem_Desarr_TFija.Qry_Carga_mem_desarr_TFlot do
     begin
        {
          SQL.Clear;
          SQL.Add('SELECT Cupon_Desde'                             );
          SQL.Add('      ,Cupon_Hasta'                             );
          SQL.Add('      ,Tipo_Tasa'                               );
          SQL.Add('      ,Tratamiento'                             );
          SQL.Add('      ,Operacion'                               );
          SQL.Add('      ,Factor'                                  );
          SQL.Add('      ,Amortizacion'                            );
          SQL.Add('      ,Factor_Cap'                              );
          SQL.Add('  FROM QS_FIN_DEF_DESFLOT'                      );
          SQL.Add(' WHERE Serie              = :xSerie'            );
          SQL.Add('   AND Codigo_Instrumento = :Instrumento'       );
          SQL.Add('   AND Codigo_Identidad   = :Emisor'            );
          SQL.Add(' ORDER BY Cupon_Desde'                          );
        }
          ParamByName('xSerie'     ).AsString := RegDes.Serie;
          ParamByName('Instrumento').AsString := RegDes.Codigo_Instrumento;
          ParamByName('Emisor'     ).AsString := RegDes.Codigo_Emisor;
          Open;
          First;
          WHILE NOT EOF do
            begin
               for iNro_Cupon := FieldByName('Cupon_Desde').AsInteger to
                                 FieldByName('Cupon_Hasta').AsInteger do
                   begin
                     if iNro_Cupon > Max_Nro_Cupones then
                        begin
                          Close;
                          UnPrepare;
                          Result := False;
                          exit;
                        end;

                     if (iCupon_Por_Crear <> iNro_Cupon) then
                         begin
                           Close;
                           UnPrepare;
                           Modulo_Err := 'Definición Tabla de Desarrollo Tasa Flotante';
                           String_Err := 'Error en definición de cupón nro.:'
                                         +inttostr(iCupon_Por_Crear)+'.'+#10
                                         +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                                         +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                                         +'     Serie       : '+RegDes.Serie+'.';
                           Result := False;
                           exit;
                         end;

                     inc(iCupon_Por_Crear);
                     Array_Mem_Desarr[iNro_Cupon].Nro_Cupon := iNro_Cupon;

                     if NOT (FieldByName('Tipo_Tasa').IsNull) then
                        Array_Mem_Desarr[iNro_Cupon].Tipo_Tasa    := FieldByName('Tipo_Tasa').AsString;

                     if NOT (FieldByName('Tratamiento').IsNull) then
                        Array_Mem_Desarr[iNro_Cupon].Tratamiento  := FieldByName('Tratamiento').AsString;

                     if NOT (FieldByName('Operacion').IsNull) then
                        Array_Mem_Desarr[iNro_Cupon].Operacion  := FieldByName('Operacion').AsString;

                    if NOT (FieldByName('Factor').IsNull) then
                        Array_Mem_Desarr[iNro_Cupon].Factor  := FieldByName('Factor').AsFloat;

                    if NOT (FieldByName('Amortizacion').IsNull) then
                        begin
                          Array_Mem_Desarr[iNro_Cupon].Amortizacion  := FieldByName('Amortizacion').AsFloat;
                          fAmortiz_Acum := fAmortiz_Acum + Array_Mem_Desarr[iNro_Cupon].Amortizacion;
                        end;

                    if NOT (FieldByName('Factor_Cap').IsNull) then
                        Array_Mem_Desarr[iNro_Cupon].Factor_Cap  := FieldByName('Factor_Cap').AsFloat
                    else
                        Array_Mem_Desarr[iNro_Cupon].Factor_Cap  := 0;
                   end;   // end for
               Next;
            end; // end while
          Close;
         // UnPrepare;
     end; // end with

    iNro_Cupon := iNro_Cupon - 1;
    if iNro_Cupon = 0 then
    begin
      Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
      String_Err := 'No se pudo obtener definición de tabla de desarrollo tasa flotante'+#10
                   +'Emisor       : '+RegDes.Codigo_Emisor+#10
                   +'Instrumento  : '+RegDes.Codigo_Instrumento+#10
                   +'Serie        : '+RegDes.Serie+#10;
      Result := False;
      exit;
    end;

    if iNro_Cupon  > Max_Nro_Cupones then
    begin
      Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
      String_Err := 'Se detecto problema con maximo de cupones.'#10
                   +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                   +'Se aborta proceso. Contactese con el Administrador';
      Result := False;
      exit;
    end;

   //ggarcia 11-10-2016 se redondea la base original, ya que en caso de base con decimales entra al if a pesar que son identicos.
   //if (redondeo(fAmortiz_Acum,10) <> RegDes.BASE_Original then
   if (redondeo(fAmortiz_Acum,10) <> redondeo(RegDes.BASE_Original,10)) then
      begin
        Modulo_Err := 'Definición Tabla de Desarrollo Tasa Flotante';
        String_Err := 'Inconsistencia en definición de amortización para '#10
                      +'Emisor       : '+RegDes.Codigo_Emisor+#10
                      +'Instrumento  : '+RegDes.Codigo_Instrumento+#10
                      +'Serie        : '+RegDes.Serie+#10+#10
                      +'Base Original: '+floattostr(RegDes.BASE_Original)+#10
                      +'Amotizacion  : '+floattostr(fAmortiz_Acum);
        Result := False;
        exit;
      end;

   if (iNro_Cupon) <> RegDes.NRO_CUPONES then
      begin
        Modulo_Err := 'Definición Tabla de Desarrollo Tasa Flotante';
        String_Err := 'Inconsistencia en definición de cupones'#10
                      +'En la tabla '+inttostr(iNro_Cupon)+' cupones.'#10
                     +'En descriptor '+floattostr(RegDes.NRO_CUPONES)+' cupones.'#10
                      +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                      +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                      +'     Serie       : '+RegDes.Serie+'.';
        Result := False;
        exit;
      end;

   iNro_Cupon := 1;

//   while (Array_Mem_Desarr[iNro_Cupon].Nro_Cupon <> 0) do
   While (iNro_Cupon <= Max_Nro_Cupones) do  // Recorre la tabla de desarrollo mientras existen cupones

     begin
       fAmortiz_Acum := fAmortiz_Acum - Array_Mem_Desarr[iNro_Cupon].Amortizacion;
       Array_Mem_Desarr[iNro_Cupon].Saldo_Insoluto := fAmortiz_Acum;

       // 05-01-2010 F.I. Cambios para tener valores sin considerar capitalizaciones despues de la compra
       Array_Mem_Desarr[iNro_Cupon].Amortizaciones_Segun_Fecha_de_Compra := Array_Mem_Desarr[iNro_Cupon].Amortizacion;
       Array_Mem_Desarr[iNro_Cupon].Saldo_Insoluto_Segun_Fecha_de_Compra  := Array_Mem_Desarr[iNro_Cupon].Saldo_Insoluto;

       inc(iNro_Cupon);
     end;
end;    // carga_Mem_Desarr_TFlot
//------------------------------------------------------------------------------
procedure Actualiza_Fechas_Vencimiento(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                       sNemotecnico         : String;
                                       dFecha_Compra        : TdateTime;
                                       var RegDes           : TReg_Descriptor;
                                       dFecha_Emision       : TDateTime;
                                       Registro_Fechas      : TRegistro_Fechas;
                                       var Modulo_Err       : String;
                                       var String_Err       : String;
                                       var Result           : Boolean);
var
  iCupon    : Integer;
  aux_fecha  : TDateTime;
  aux_fecha2 : TDateTime;
  fNum_Cupones_Cortados : Double;
  bBase_Dias_Variable   : Boolean;
  iDiasBaseTasa         : Integer;
  sTipoInteres          : String;
  iBaseMensual          : Integer;
  sTipoCalculoDias      : String;
  iVigenciaValor        : Integer;
  iVigenciaMeses        : Integer;
  sPais_Tasa            : String;
  fPeriodos             : Double;
  fDiasBaseTasa_Originales : Integer;
//  fTasa_Efectiva_Original  : Double;

// Dias efectivo de pago
  fCantidad		: Double;
  sUnidad 		: String;
  sHabiles		: String;
  sAntes_Despues        : String;
  DiasEfectivosPago     : Boolean;
  sAfecta               : String;
   iDias,
   iMeses,
   iAnos                : Integer;


begin
  aux_fecha := dFecha_Emision;
//  fTasa_Efectiva_Original := RegDes.Tasa_Efectiva;

  DiasEfectivosPago := False;
  if NOT bBusca_Dias_Efectivos_Pago then
     // Se cambia a rutina en memoria _mem  04-09-2014
     {
     Determina_Dias_Efectivos_Pago( sPais_Usuario,
                                   RegDes.Codigo_Emisor,
                                   RegDes.Codigo_Instrumento,
                                   RegDes.Serie,
                                   sNemotecnico,
                                   Registro_Fechas.Fecha_Calculo, //aux_fecha,
                                   fCantidad,
                                   sUnidad,
                                   sHabiles,
                                   sAntes_Despues,
                                   sAfecta,
                                   DiasEfectivosPago
                                   );
      }
      Determina_Dias_Efectivos_Pago_Mem( sPais_Usuario,
                                         RegDes.Codigo_Emisor,
                                         RegDes.Codigo_Instrumento,
                                         RegDes.Serie,
                                         sNemotecnico,
                                         Registro_Fechas.Fecha_Calculo, //aux_fecha,
                                         fCantidad,
                                         sUnidad,
                                         sHabiles,
                                         sAntes_Despues,
                                         sAfecta,
                                         DiasEfectivosPago
                                      );

  fNum_Cupones_Cortados := 0;

  if RegDes.fCupones_Cortados > 0 then
     fNum_Cupones_Cortados := RegDes.fCupones_Cortados
  else
  begin
// E.S. desde el 12-04-2018 no se considerará mas los cupones cortados desde para instrumentios con implicancia CC
     if NOT transaccion_implica(RegDes.Codigo_Instrumento, 'CC') then
        if (sValorizacion_Proceso = 'SI') and
           (sImplica_NOMEM <> 'S'       ) then // hago pregunta porque estoy en pruebas "LOBO"
           fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico_Mem(sNemotecnico)
        else
           fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico(sNemotecnico);
  end;

  if fNum_Cupones_Cortados > 0 then
     if dFecha_Compra = StrToDate(Fecha_Nula) then
     begin
       Result := False;
       Modulo_Err := 'Titulo con cupones cortados';
       String_Err := 'Fecha de Compra no valida para: '#10
                    +'Emisor      : '+RegDes.Codigo_Emisor+#10
                    +'Instrumento : '+RegDes.Codigo_Instrumento+#10
                    +'Serie       : '+RegDes.Serie+'.';
       exit;
     end;

     if ((RegDes.Tipo_Vencimiento = 'UD')  or
         (RegDes.Tipo_Vencimiento = 'SD')) and
         (Round(RegDes.Periodo_Pago) = 0)  then
     begin
       Result := False;
       Modulo_Err := 'Generación de fechas de vencimiento para Tabla de desarrolo';
       String_Err := 'Periodo de Pago no válido para : '#10
                    +'Emisor      : '+RegDes.Codigo_Emisor+#10
                    +'Instrumento : '+RegDes.Codigo_Instrumento+#10
                    +'Serie       : '+RegDes.Serie+'.';
       exit;
      end;

      if (sValorizacion_Proceso = 'SI') then
          Existe_Tasa_base_Mem( Trim(RegDes.Tasa_Valor_PAR)
                               ,bBase_Dias_Variable
                               )
      else
      begin
         try
           WITH DM_Tabla_Mem_Desarr_TFija.Qry_TasaBaseVar do
           begin
                {
                SQL.Clear;
                SQL.Add('SELECT *                             ');
                SQL.Add('  FROM QS_FIN_TASA_BASE_VARIABLE          ');
                SQL.Add(' WHERE Cod_Tasa_Base = :Tasa_Base    ');
                SQL.Add('   AND  Fecha_Desde  <= :Fecha       ');
                SQL.Add('   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)');
                }
                ParamByName('Tasa_Base').AsString := trim(RegDes.Tasa_Valor_PAR);
                ParamByName('Fecha').Asdate   := Registro_Fechas.Fecha_Calculo;
                try
                  Open;
                except on E: EFDDBEngineException do
                   begin
                      ShowError(E);
                      DM_Tabla_Mem_Desarr_TFija.Qry_TasaBaseVar.Close;
                      Exit;
                   end;
                end;

                if Fieldbyname('Cod_Tasa_base').isNull  then
                   bBase_Dias_Variable := False
                else
                   bBase_Dias_Variable := True;
                Close;
           end;
         except
            bBase_Dias_Variable := False;
         end;
      end;

      Obtener_Tasa_base_Mem(RegDes.Tasa_Valor_PAR
                            ,iDiasBaseTasa
                            ,sTipoInteres
                            ,iBaseMensual
                            ,sTipoCalculoDias
                            ,iVigenciaValor
                            ,iVigenciaMeses
                            ,sPais_Tasa
                            ,Modulo_err
                            ,String_err
                            ,Result
                            );
      if NOT Result then
         exit;
      fDiasBaseTasa_Originales := iDiasBaseTasa;


      if RegDes.Tipo_Vencimiento = 'VA' then
      begin
        WITH DM_Tabla_Mem_Desarr_TFija.Qry_NemFechas do
        begin
          {
          SQL.Clear;
          Sql.Add( 'SELECT  Nro_Cupon        '
                  +'       ,Fecha_Vencimiento'
                  +' FROM QS_FIN_Nem_Fechas '
                  +' WHERE Codigo_Nemotecnico = :Nemotecnico'
                  );
                  }
          ParamByName('Nemotecnico').AsString := sNemotecnico;
          Open;
          WHILE NOT EOF do
          begin
            if (FieldByName('Nro_Cupon').AsInteger > Max_Nro_Cupones) then
               Break;    // Se detectaron tablas que tenian mas fechas que cupones por error
            Array_Mem_Desarr[FieldByName('Nro_Cupon').AsInteger].Fecha_Vcto := FieldByName('Fecha_Vencimiento').AsDateTime;
            Next;
          end;
          Close;
          Modulo_Err := '';
//          For iCupon := 1 to ROUND(RegDes.Nro_Cupones) do
          For iCupon := 1 to Max_Nro_Cupones do
          begin
            if (Array_Mem_Desarr[iCupon].Fecha_Vcto = 0) then
            begin
              Modulo_Err := 'Definición Fechas Vencimiento Variable';
              String_Err := 'Falta definición de fechas de vencimiento variable'#10
                           +'para el cupon '+inttostr(iCupon)+#10
                           +'     Nemotécnico : '+sNemotecnico+#10
                           +'     Emisor      : '+RegDes.Codigo_Emisor+#10
                           +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                           +'     Serie       : '+RegDes.Serie+'';
              Result := False;  //SS FI ES 07-06-2023 Dejaba el result en verdadero a pesar de encontrar error
              Break;
            end;
          end;
          Close;
          if (Modulo_Err <> '') then
             exit;
        end;
      end;

      Result := True;
      iCupon := 1;

      try
//          For iCupon := 1 to ROUND(RegDes.Nro_Cupones) do
          For iCupon := 1 to Max_Nro_Cupones do
          begin
          if (RegDes.Tipo_Vencimiento <> 'VA') AND
             (RegDes.Tipo_Vencimiento <> 'V')  then
          begin
              Proximo_vencimiento(sNemotecnico
                                 ,RegDes.Tipo_Vencimiento
                                 ,iCupon
                                 ,Round(RegDes.Dia_Vencimiento)
                                 ,Round(RegDes.Periodo_Pago)
                                 ,RegDes.Tasa_Flotante
                                 ,aux_fecha
                                 ,Result);

              if NOT Result then
              begin
                Modulo_Err := 'Definición Fechas Vencimiento Variable';
                String_Err := 'No existe definición de fecha de Vcto.'#10
                             +'para el cupon '+inttostr(iCupon)+#10
                             +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                             +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                             +'     Serie       : '+RegDes.Serie+'.';
                exit;
              end;
              Array_Mem_Desarr[iCupon].Fecha_Vcto := aux_fecha;
            end
            else
              aux_fecha := Array_Mem_Desarr[iCupon].Fecha_Vcto;  //  28-08-2013 GG  & ES   (Caso Tasa flotante, con definicion de fechas variables y definicion de dias efectivos de pago)
                                                                 // , tomaba la fecha de emision en vez del vcto del cupon)
//            (*
            if DiasEfectivosPago Then
            Begin
               aux_fecha2 := aux_fecha;
               if fCantidad > 0 then
               begin
                 iDias  := 0;
                 iMeses := 0;
                 iAnos  := 0;

                 // No puede multiplicarse por ya que siono no entra mas
                 //if sAntes_Despues = 'A' then
                 //   fCantidad := fCantidad * (-1);

                 if sUnidad = 'DIA' then
                    if sAntes_Despues = 'A' then
                       iDias := ROUND(fCantidad*(-1))
                    else
                       iDias := ROUND(fCantidad);

                 if sUnidad = 'MES' then
                    if sAntes_Despues = 'A' then
                       iMeses := ROUND(fCantidad*(-1))
                    else
                       iMeses := ROUND(fCantidad);

                 if sUnidad = 'ANO' then
                    if sAntes_Despues = 'A' then
                       iAnos := ROUND(fCantidad*(-1))
                    else
                       iAnos := ROUND(fCantidad);

                 if (sUnidad = 'DIA') AND (sHabiles = 'S') then
                 begin
                   if sAntes_Despues = 'A' then
                      aux_fecha2 := Resta_dias_habiles(sPais_Usuario
                                                        ,aux_fecha2
                                                        ,ABS(fCantidad))
                   else
                      aux_fecha2 := suma_dias_habiles(sPais_Usuario
                                                       ,aux_fecha2
                                                       ,ABS(fCantidad));

                 end
                 else
                   aux_fecha2 := IncDate(aux_fecha2
                                          ,iDias
                                          ,iMeses
                                          ,iAnos);
               end;

              if sHabiles = 'S' then
              begin
                 While (Feriado_Mem(sPais_Usuario,aux_fecha2)  or // OJO VA A MEMORIA DIRECTO
                       (DayOfWeek(aux_fecha2) in [1,7])) do
                    if sAntes_Despues = 'A' then
                       aux_fecha2 := aux_fecha2 - 1
                    else
                       aux_fecha2 := aux_fecha2 + 1;
              end;
// edosan, por If de abajo              Array_Mem_Desarr[iCupon].Fecha_Vcto := aux_fecha2;
// Inicio
              Array_Mem_Desarr[iCupon].Fecha_Tipo_Cambio := aux_fecha2;
              if sAfecta <> 'TIPOCAMBIO' then
                 Array_Mem_Desarr[iCupon].Fecha_Vcto        := aux_fecha2;
// Fin
            end
            else
              Array_Mem_Desarr[iCupon].Fecha_Tipo_Cambio := Array_Mem_Desarr[iCupon].Fecha_Vcto;

            if iCupon > 1 then
               Array_Mem_Desarr[iCupon].Fecha_Vcto_Anterior := Array_Mem_Desarr[iCupon-1].Fecha_Vcto
            else
               Array_Mem_Desarr[iCupon].Fecha_Vcto_Anterior := dFecha_Emision;

            if (fNum_Cupones_Cortados > 0)                           and
               (Array_Mem_Desarr[iCupon].Fecha_Vcto > dFecha_Compra) then
            begin
              if Array_Mem_Desarr[iCupon].Valor_Cupon <> 0 then         // F.I. 20-12-2023 Los cupones de gracia (en cero)
                 fNum_Cupones_Cortados := fNum_Cupones_Cortados - 1;    // no se cuentan de tal manera que solo corte cupones con valor
              Array_Mem_Desarr[iCupon].Cupon_Cortado := True;
              Array_Mem_Desarr[iCupon].Interes       := 0;
              Array_Mem_Desarr[iCupon].Amortizacion  := 0;
              Array_Mem_Desarr[iCupon].Valor_Cupon   := 0;
            end;
            Array_Mem_Desarr[iCupon].Dias_Base_PAR          := iDiasBaseTasa;
            Array_Mem_Desarr[iCupon].Periodos_Tasa_Base_Variable := 1;
          end;  // end for
          iCupon := 1;

          // Para Dias Base Variable recorro de nuevo la tabla
          // no se podia hacer en el for anterior ya que se necesitan
          // las fechas de todos los cupones.
          if bBase_Dias_Variable then
          begin
//            For iCupon := 1 to ROUND(RegDes.Nro_Cupones) do
            For iCupon := 1 to Max_Nro_Cupones do
            begin
              Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[iCupon].Fecha_Vcto_Anterior;
              iDiasBaseTasa:= fDiasBaseTasa_Originales;
              Obtener_Tasa_base_Variable(RegDes.Tasa_Valor_PAR
                                        ,Registro_Fechas
                                        ,RegDes
                                        ,Array_Mem_Desarr
                                        ,sPais_Tasa
                                        ,iDiasBaseTasa
                                        ,fPeriodos
                                        ,Modulo_err
                                        ,String_err
                                        ,Result);
              if NOT Result then
                 exit;
              Array_Mem_Desarr[iCupon].Dias_Base_PAR          := iDiasBaseTasa;
              Array_Mem_Desarr[iCupon].Periodos_Tasa_Base_Variable := fPeriodos;
            end; // end for
            iCupon := 1;
          end;


      except
              Modulo_Err := 'Definición Fechas Vencimiento';
              String_Err := ' ERROR al BUSCAR fechas de Vcto.'#10
                           +'para el cupon '+inttostr(iCupon)+#10
                           +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                           +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                           +'     Serie       : '+RegDes.Serie+'.';
              exit;
      end;
end;        // Actualiza_Fechas_Vencimiento
//------------------------------------------------------------------------------
procedure Actualiza_Fechas_Vencimiento_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                           sNemotecnico         : String;
                                           dFecha_Vig           : TdateTime;
                                           dFecha_Compra        : TdateTime;
                                           var RegDes           : TReg_Descriptor;
                                           dFecha_Emision       : TDateTime;
                                           Registro_Fechas      : TRegistro_Fechas;
                                           var Modulo_Err       : String;
                                           var String_Err       : String;
                                           var Result           : Boolean);
var
  iCupon    : Integer;
  aux_fecha  : TDateTime;
  aux_fecha2 : TDateTime;
  fNum_Cupones_Cortados : Double;
  bBase_Dias_Variable   : Boolean;
  iDiasBaseTasa         : Integer;
  sTipoInteres          : String;
  iBaseMensual          : Integer;
  sTipoCalculoDias      : String;
  iVigenciaValor        : Integer;
  iVigenciaMeses        : Integer;
  sPais_Tasa            : String;
  fPeriodos             : Double;
  fDiasBaseTasa_Originales : Integer;
//  fTasa_Efectiva_Original  : Double;

// Dias efectivo de pago
  fCantidad		: Double;
  sUnidad 		: String;
  sHabiles		: String;
  sAntes_Despues        : String;
  DiasEfectivosPago     : Boolean;
  sAfecta               : String;
   iDias,
   iMeses,
   iAnos                : Integer;


begin
  aux_fecha := dFecha_Emision;
//  fTasa_Efectiva_Original := RegDes.Tasa_Efectiva;

  DiasEfectivosPago := False;
  if NOT bBusca_Dias_Efectivos_Pago then
     Determina_Dias_Efectivos_Pago_Mem( sPais_Usuario,
                                   RegDes.Codigo_Emisor,
                                   RegDes.Codigo_Instrumento,
                                   RegDes.Serie,
                                   sNemotecnico,
                                   Registro_Fechas.Fecha_Calculo, //aux_fecha,
                                   fCantidad,
                                   sUnidad,
                                   sHabiles,
                                   sAntes_Despues,
                                   sAfecta,
                                   DiasEfectivosPago);

  if RegDes.fCupones_Cortados > 0 then
     fNum_Cupones_Cortados := RegDes.fCupones_Cortados
  else
  begin
     if (sValorizacion_Proceso = 'SI') and
        (sImplica_NOMEM <> 'S'       ) then // hago pregunta porque estoy en pruebas "LOBO"
        fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico_Mem(sNemotecnico)
     else
        fNum_Cupones_Cortados := Cupones_Cortados_Nemotecnico(sNemotecnico);
  end;

  if fNum_Cupones_Cortados > 0 then
     if dFecha_Compra = strtodate(Fecha_Nula) then //Fecha_Nula then
     begin
       Result := False;
       Modulo_Err := 'Titulo con cupones cortados';
       String_Err := 'Fecha de Compra no valida para: '#10
                    +'Emisor      : '+RegDes.Codigo_Emisor+#10
                    +'Instrumento : '+RegDes.Codigo_Instrumento+#10
                    +'Serie       : '+RegDes.Serie+'.';
       exit;
     end;

     if ((RegDes.Tipo_Vencimiento = 'UD')  or
         (RegDes.Tipo_Vencimiento = 'SD')) and
         (Round(RegDes.Periodo_Pago) = 0)  then
     begin
       Result := False;
       Modulo_Err := 'Generación de fechas de vencimiento para Tabla de desarrolo';
       String_Err := 'Periodo de Pago no válido para : '#10
                    +'Emisor      : '+RegDes.Codigo_Emisor+#10
                    +'Instrumento : '+RegDes.Codigo_Instrumento+#10
                    +'Serie       : '+RegDes.Serie+'.';
       exit;
      end;

      if (sValorizacion_Proceso = 'SI') then
          Existe_Tasa_base_Mem( Trim(RegDes.Tasa_Valor_PAR)
                               ,bBase_Dias_Variable
                               )
      else
      begin
         try
           WITH DM_Tabla_Mem_Desarr_TFija.Query1 do
           begin
                SQL.Clear;
                SQL.Add('SELECT *                             ');
                SQL.Add('  FROM QS_FIN_TASA_BASE_VARIABLE          ');
                SQL.Add(' WHERE Cod_Tasa_Base = :Tasa_Base    ');
                SQL.Add('   AND  Fecha_Desde  <= :Fecha       ');
                SQL.Add('   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)');

                ParamByName('Tasa_Base').AsString := trim(RegDes.Tasa_Valor_PAR);
                ParamByName('Fecha').AsDate   := Registro_Fechas.Fecha_Calculo;
                Open;
                if Fieldbyname('Cod_Tasa_base').isNull  then
                   bBase_Dias_Variable := False
                else
                   bBase_Dias_Variable := True;
                Close;
           end;
         except
            bBase_Dias_Variable := False;
         end;
      end;

      Obtener_Tasa_base_Mem(RegDes.Tasa_Valor_PAR
                            ,iDiasBaseTasa
                            ,sTipoInteres
                            ,iBaseMensual
                            ,sTipoCalculoDias
                            ,iVigenciaValor
                            ,iVigenciaMeses
                            ,sPais_Tasa
                            ,Modulo_err
                            ,String_err
                            ,Result
                            );
      if NOT Result then
         exit;
      fDiasBaseTasa_Originales := iDiasBaseTasa;

      try

          if NOT ((RegDes.Tipo_Vencimiento = 'UD') or
                  (RegDes.Tipo_Vencimiento = 'SD') or
                  (RegDes.Tipo_Vencimiento = 'CD')) then
          begin
            Carga_Fechas_Variables_Vig(sNemotecnico
                                      ,dfecha_Vig
                                      ,Array_Mem_Desarr
                                      ,Modulo_Err
                                      ,String_Err
                                      ,Result);
            if Not Result then
            begin
              exit;
            end;
          end;

          For iCupon := 1 to ROUND(RegDes.Nro_Cupones) do
          begin
              if ((RegDes.Tipo_Vencimiento = 'UD') or
                  (RegDes.Tipo_Vencimiento = 'SD') or
                  (RegDes.Tipo_Vencimiento = 'CD')) then
              begin
                Proximo_vencimiento_Vig(sNemotecnico
                                       ,dFecha_Vig
                                       ,RegDes.Tipo_Vencimiento
                                       ,iCupon
                                       ,Round(RegDes.Dia_Vencimiento)
                                       ,Round(RegDes.Periodo_Pago)
                                       ,RegDes.Tasa_Flotante
                                       ,aux_fecha
                                       ,Modulo_Err
                                       ,String_Err
                                       ,Result);
                if NOT Result then
                begin
                  { Ahora la funcion trae el modulo_err y string_err
                  Modulo_Err := 'Definición Fechas Vencimiento Variable';
                  String_Err := 'No existe definición de fecha de Vcto.'#10
                               +'para el cupon '+inttostr(iCupon)+#10
                               +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                               +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                               +'     Serie       : '+RegDes.Serie+'.';
                  }
                  exit;
                end;
                Array_Mem_Desarr[iCupon].Fecha_Vcto := aux_fecha;
              end;
//            (*
            if DiasEfectivosPago Then
            Begin
               aux_fecha2 := Array_Mem_Desarr[iCupon].Fecha_Vcto;
               if fCantidad > 0 then
               begin
                 iDias  := 0;
                 iMeses := 0;
                 iAnos  := 0;

                 // No puede multiplicarse por ya que siono no entra mas
                 //if sAntes_Despues = 'A' then
                 //   fCantidad := fCantidad * (-1);

                 if sUnidad = 'DIA' then
                    if sAntes_Despues = 'A' then
                       iDias := ROUND(fCantidad*(-1))
                    else
                       iDias := ROUND(fCantidad);

                 if sUnidad = 'MES' then
                    if sAntes_Despues = 'A' then
                       iMeses := ROUND(fCantidad*(-1))
                    else
                       iMeses := ROUND(fCantidad);

                 if sUnidad = 'ANO' then
                    if sAntes_Despues = 'A' then
                       iAnos := ROUND(fCantidad*(-1))
                    else
                       iAnos := ROUND(fCantidad);

                 if (sUnidad = 'DIA') AND (sHabiles = 'S') then
                 begin
                   if sAntes_Despues = 'A' then
                      aux_fecha2 := Resta_dias_habiles(sPais_Usuario
                                                        ,aux_fecha2
                                                        ,ABS(fCantidad))
                   else
                      aux_fecha2 := suma_dias_habiles(sPais_Usuario
                                                       ,aux_fecha2
                                                       ,ABS(fCantidad));

                 end
                 else
                   aux_fecha2 := IncDate(aux_fecha2
                                          ,iDias
                                          ,iMeses
                                          ,iAnos);
               end;

              if sHabiles = 'S' then
              begin
                 While (Feriado_Mem(sPais_Usuario,aux_fecha2)  or // OJO VA A MEMORIA DIRECTO
                       (DayOfWeek(aux_fecha2) in [1,7])) do
                    if sAntes_Despues = 'A' then
                       aux_fecha2 := aux_fecha2 - 1
                    else
                       aux_fecha2 := aux_fecha2 + 1;
              end;

// edosan, por If de abajo              Array_Mem_Desarr[iCupon].Fecha_Vcto := aux_fecha2;
// Inicio
              Array_Mem_Desarr[iCupon].Fecha_Tipo_Cambio := aux_fecha2;
              if sAfecta <> 'TIPOCAMBIO' then
                 Array_Mem_Desarr[iCupon].Fecha_Vcto        := aux_fecha2;
// Fin
            end
            else
              Array_Mem_Desarr[iCupon].Fecha_Tipo_Cambio := Array_Mem_Desarr[iCupon].Fecha_Vcto;

            if iCupon > 1 then
               Array_Mem_Desarr[iCupon].Fecha_Vcto_Anterior := Array_Mem_Desarr[iCupon-1].Fecha_Vcto
            else
               Array_Mem_Desarr[iCupon].Fecha_Vcto_Anterior := dFecha_Emision;

            if (fNum_Cupones_Cortados > 0)                           and
               (Array_Mem_Desarr[iCupon].Fecha_Vcto > dFecha_Compra) then
            begin
              fNum_Cupones_Cortados := fNum_Cupones_Cortados - 1;
              Array_Mem_Desarr[iCupon].Cupon_Cortado := True;
              Array_Mem_Desarr[iCupon].Interes       := 0;
              Array_Mem_Desarr[iCupon].Amortizacion  := 0;
              Array_Mem_Desarr[iCupon].Valor_Cupon   := 0;
            end;
            Array_Mem_Desarr[iCupon].Dias_Base_PAR          := iDiasBaseTasa;
            Array_Mem_Desarr[iCupon].Periodos_Tasa_Base_Variable := 1;
          end;  // end for
          iCupon := 1;

          // Para Dias Base Variable recorro de nuevo la tabla
          // no se podia hacer en el for anterior ya que se necesitan
          // las fechas de todos los cupones.
          if bBase_Dias_Variable then
          begin
            For iCupon := 1 to ROUND(RegDes.Nro_Cupones) do
            begin
              Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[iCupon].Fecha_Vcto_Anterior;
              iDiasBaseTasa:= fDiasBaseTasa_Originales;
              Obtener_Tasa_base_Variable(RegDes.Tasa_Valor_PAR
                                        ,Registro_Fechas
                                        ,RegDes
                                        ,Array_Mem_Desarr
                                        ,sPais_Tasa
                                        ,iDiasBaseTasa
                                        ,fPeriodos
                                        ,Modulo_err
                                        ,String_err
                                        ,Result);
              if NOT Result then
                 exit;
              Array_Mem_Desarr[iCupon].Dias_Base_PAR          := iDiasBaseTasa;
              Array_Mem_Desarr[iCupon].Periodos_Tasa_Base_Variable := fPeriodos;
            end; // end for
          end;


      except
              Modulo_Err := 'Definición Fechas Vencimiento';
              String_Err := ' ERROR al BUSCAR fechas de Vcto.'#10
                           +'para el cupon '+inttostr(iCupon)+#10
                           +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                           +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                           +'     Serie       : '+RegDes.Serie+'.';
              exit;
      end;
end;        // Actualiza_Fechas_Vencimiento
//------------------------------------------------------------------------------
procedure Cupon_Vigente(var Array_Mem_Desarr     : TArray_Mem_Desarr;
                        RegDes               : TReg_Descriptor;
                        dFecha               : TDateTime;
                        bConCupon            : Boolean;
                        var iCuponVigente    : Integer;
                        var Modulo_Err       : String;
                        var String_Err       : String;
                        var Result           : Boolean);
var i : Integer;
begin
  iCuponVigente := 1;
  Result := True;

  // FI & DC 01/08/2022
//   if Array_Mem_Desarr[Max_Nro_Cupones].Fecha_Vcto < dFecha  then   PA & GG  28/09/2023 caso SWAP
   if Array_Mem_Desarr[trunc(RegDes.NRO_CUPONES)].Fecha_Vcto < dFecha  then
   begin
      Modulo_Err := 'Cupon vigente en Tabla de Desarrollo';
      String_Err := 'No se encontro cupon vigente con fecha:'
                   +datetostr(dFecha)+#10
                   +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                   +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                   +'     Serie       : '+RegDes.Serie+'.';
      Result := False;
      exit;
   end;
  // FI & DC 01/08/2022

//  While (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto < dFecha) do
  for i := 1 to Max_Nro_Cupones do
  begin
// ES 18-11-2011
//    if i > Max_Nro_Cupones then
//     begin
//        Modulo_Err := 'Cupon vigente en Tabla de Desarrollo';
//        String_Err := 'Se detecto problema con maximo de cupones.'#10
//                     +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
//                     +'Se aborta proceso. Contactese con el Administrador';
//        Result := False;
//        exit;
//     end;

//    if Array_Mem_Desarr[i].Nro_Cupon = 0 then
//       begin
//          Modulo_Err := 'Cupon vigente en Tabla de Desarrollo';
//          String_Err := 'No se encontro cupon vigente con fecha:'
//                       +datetostr(dFecha)+#10
//                       +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
//                       +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
//                       +'     Serie       : '+RegDes.Serie+'.';
//          Result := False;
//          Break;  // Es 18-11-2011
//       end;



    // Avanza si el cupon esta cortado ....
    if (Array_Mem_Desarr[i].Cupon_Cortado) then
       Continue;

    // Sale del for como cupon vigente
    if Array_Mem_Desarr[i].Fecha_Vcto >= dFecha  then
       Break;
  end;

  if Not Result then   // Es 18-11-2011
     Exit;

  iCuponVigente := i;

  if NOT bConCupon then
  begin
     if iCuponVigente < RegDes.Nro_Cupones then
        if Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = dFecha then
           iCuponVigente := iCuponVigente + 1
  end;
{
  else
  begin
     // Si el cupon Viene Marcado Cortado !!!!!NO SE CONSIDERA!!!!!!
     if iCuponVigente < RegDes.Nro_Cupones then
        if (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = dFecha) and
           (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado)  then
           iCuponVigente := iCuponVigente + 1
  end;
}
end;    // Cupon_Vigente
//------------------------------------------------------------------------------
procedure Cupon_Vigente(var Array_Mem_Desarr     : TArray_Mem_Desarr;
                        RegDes               : TReg_Descriptor;
                        dFecha               : TDateTime;
                        bConCupon            : Boolean;
                        bFecha_Liq           : Boolean;
                        var iCuponVigente    : Integer;
                        var Modulo_Err       : String;
                        var String_Err       : String;
                        var Result           : Boolean);
var i : Integer;
begin
  iCuponVigente := 1;
  Result := True;

  // FI & DC 01/08/2022
//   if Array_Mem_Desarr[Max_Nro_Cupones].Fecha_Vcto < dFecha  then    PA & GG  28/09/2023 caso SWAP
   if Array_Mem_Desarr[trunc(RegDes.NRO_CUPONES)].Fecha_Vcto < dFecha  then
   begin
      Modulo_Err := 'Cupon vigente en Tabla de Desarrollo';
      String_Err := 'No se encontro cupon vigente con fecha:'
                   +datetostr(dFecha)+#10
                   +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                   +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                   +'     Serie       : '+RegDes.Serie+'.';
      Result := False;
      exit;
   end;
  // FI & DC 01/08/2022

  for i := 1 to Max_Nro_Cupones do
  begin
    if Array_Mem_Desarr[i].Nro_Cupon = 0 then
    begin
       Modulo_Err := 'Cupon vigente en Tabla de Desarrollo';
       String_Err := 'No se encontro cupon vigente con fecha:'
                    +datetostr(dFecha)+#10
                    +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                    +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                    +'     Serie       : '+RegDes.Serie+'.';
       Result := False;
       Break;  // Es 18-11-2011
    end;

    // Avanza si el cupon esta cortado ....
    if (Array_Mem_Desarr[i].Cupon_Cortado) then
       Continue;

    // Sale del for como cupon vigente
    if bFecha_Liq then
    begin
       if Array_Mem_Desarr[i].Fecha_Liquidacion >= dFecha  then
          Break;
    end
    else
    begin
       if Array_Mem_Desarr[i].Fecha_vcto >= dFecha  then
          Break;
    end;
  end;

  if Not Result then   // Es 18-11-2011
     Exit;

  iCuponVigente := i;

  if NOT bConCupon then
  begin
     if iCuponVigente < RegDes.Nro_Cupones then
        if bFecha_Liq then
        begin
          if Array_Mem_Desarr[iCuponVigente].Fecha_Liquidacion = dFecha then
             iCuponVigente := iCuponVigente + 1;
        end
        else
        begin
          if Array_Mem_Desarr[iCuponVigente].Fecha_vcto = dFecha then
             iCuponVigente := iCuponVigente + 1;
        end;
  end;
end;    // Cupon_Vigente
//------------------------------------------------------------------------------
procedure Carga_Mem_Desarr_Unicos(sTipo_Nominales        : String;
                                  fNominales             : Double;
                                  fTasa_Emision          : Double;
                                  dFecha_Emision         : TDateTime;
                                  dFecha_Vencimiento     : TDateTime;
                                  dFecha_Calculo         : TDateTime;
                                  sTasa_Base             : String;
                                  var Array_Mem_Desarr   : TArray_Mem_Desarr;
                                  var RegDes             : TReg_Descriptor;
                                  sParametros_Formula    : TRegFormulaPAR;
                                  var Modulo_Err         : String;
                                  var String_Err         : String;
                                  var Result             : Boolean);
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
  fInteres         : Double;
  Registro_Fechas  : TRegistro_Fechas;
  sTipo_Tasa,
  sAnualidad_Tasa     : String;
  fPeriodo_Tasa,
  fBase_Porcen_Tasa   : Double;
  fFactor_Correccion  : Double;

  dFecha_Inicio       : TDateTime;
  dFecha_Termino      : TDateTime;
  fValor_Ind_Inicio   : Double;
  fValor_Ind_Termino  : Double;

// Dias efectivo de pago
  aux_fecha : TDateTime;
  fCantidad		: Double;
  sUnidad 		: String;
  sHabiles		: String;
  sAntes_Despues        : String;
  DiasEfectivosPago     : Boolean;
  sAfecta               : String;
   iDias,
   iMeses,
   iAnos                : Integer;


begin
  SetLength(Array_Mem_Desarr,2);
  Max_Nro_Cupones := 1;

  Inicializa_Mem_Desarr(Array_Mem_Desarr);
  RegDes.Tasa_Emision   := fTasa_Emision;
  RegDes.Tipo_Nominales := sTipo_Nominales;
  Array_Mem_Desarr[1].Nro_Cupon               := 1;
  Array_Mem_Desarr[1].Amortizacion            := 100;
  Array_Mem_Desarr[1].Saldo_Insoluto          := 0;
  Array_Mem_Desarr[1].Fecha_Vcto_Anterior     := dFecha_Emision;
  Array_Mem_Desarr[1].Fecha_vcto              := dFecha_Vencimiento;
  Array_Mem_Desarr[1].Valor_Tasa              := fTasa_Emision;
  Array_Mem_Desarr[1].Tasa_flujo              := fTasa_Emision;
  Array_Mem_Desarr[1].Factor_Varcam           := 1;
  RegDes.Fecha_Carga_Array_Mem                := dFecha_Calculo;
  RegDes.bSin_Tasa_en_Flujos                  := True;

  // Variables que nuevas se llenan en multiples tasas pero que se requiere tambien esten
  // Cuando la tabla esta ingresada por tasa fija. Enero del 2010 F.I.
  Array_Mem_Desarr[1].Amortizaciones_Segun_Fecha_de_Compra := Array_Mem_Desarr[1].Amortizacion;
  Array_Mem_Desarr[1].Saldo_Insoluto_Segun_Fecha_de_Compra := Array_Mem_Desarr[1].Saldo_Insoluto;




  if sValorizacion_Proceso = 'SI' then
     Obtener_Tasa_base_mem(sTasa_Base
                   ,iDiasBaseTasa
                   ,sTipoInteres
                   ,iBaseMensual
                   ,sTipoCalculoDias
                   ,iVigenciaValor
                   ,iVigenciaMeses
                   ,sPais_Tasa
                   ,Modulo_err
                   ,String_err
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
                   ,Modulo_err
                   ,String_err
                   ,Result);

  if NOT Result then
     exit;

   if sValorizacion_Proceso = 'SI' then
      Obtener_Base_Conversion_Mem(sTasa_Base
                                 ,sTipo_Tasa
                                 ,fPeriodo_Tasa
                                 ,sAnualidad_Tasa
                                 ,fBase_Porcen_Tasa
                                 ,Modulo_Err
                                 ,String_Err
                                 ,Result)
   else
      Obtener_Base_Conversion(sTasa_Base
                             ,sTipo_Tasa
                             ,fPeriodo_Tasa
                             ,sAnualidad_Tasa
                             ,fBase_Porcen_Tasa
                             ,Modulo_Err
                             ,String_Err
                             ,Result);
   if NOT Result then
      exit;

  Registro_Fechas.Fecha_Calculo      := dFecha_Calculo;
  Registro_Fechas.Fecha_Emision      := dFecha_Emision;
  Registro_Fechas.Fecha_Vencimiento  := dFecha_Vencimiento;
  Registro_Fechas.Fecha_Inic_Periodo := dFecha_Emision;
  Registro_Fechas.Fecha_Vcto_Periodo := dFecha_Vencimiento;

  if (sParametros_Formula.Cod_Utiliza_Tasa = 'TASFLOT') and
     (sParametros_Formula.Valoriza_Acumulado <> 'S')then
  begin
    // ggarcia 25-02-2014 Se lleva a una funcion aparte por el error de STACK OVERFLOW
      if NOT carga_tasa_flotante_unico(sParametros_Formula
                                      ,dFecha_Calculo
                                      ,sTasa_Base
                                      ,RegDes
                                      ,Array_Mem_Desarr
                                      ,fTasa_Emision
                                      ,sTipo_Nominales
                                      ,Modulo_Err
                                      ,String_Err
                                      ) then
         exit;
  end;


  // Calculo el Nro de dias entre la emisión y el vencimiento
  Calculo_de_dias(dFecha_Emision,
                  dFecha_Vencimiento,
                  sTipoCalculoDias,
                  sPais_Tasa,
                  iDiasDif,
                  iAnosEnteros,
                  iAnosFraccion,
                  iMesesEnteros);

  if sTipoInteres = 'C' then
     fInteres := Interes_Compuesto(fTasa_Emision
                                  ,fBase_Porcen_Tasa
                                  ,iDiasDif
                                  ,iDiasBaseTasa)
  else
     fInteres := Interes_Simple(fTasa_Emision
                               ,fBase_Porcen_Tasa
                               ,iDiasDif
                               ,iDiasBaseTasa);

  if sTipo_Nominales = 'F' then
     Begin
//        Array_Mem_Desarr[1].Valor_Cupon := fNominales;
        Array_Mem_Desarr[1].Valor_Cupon := 100;
//        fInteres := fInteres;
     end
  else
     Begin
//        Array_Mem_Desarr[1].Valor_Cupon := fNominales * fInteres;
        Array_Mem_Desarr[1].Valor_Cupon := 100 * fInteres;
//      fInteres := (fInteres - 1) * 100;
     end;

  fInteres := (fInteres - 1) * 100;

  Array_Mem_Desarr[1].Interes                 := fInteres;
  Array_Mem_Desarr[1].Interes_Original        := Array_Mem_Desarr[1].Interes        ;
  Array_Mem_Desarr[1].Amortizacion_Original   := Array_Mem_Desarr[1].Amortizacion   ;
  Array_Mem_Desarr[1].Saldo_Insoluto_Original := Array_Mem_Desarr[1].Saldo_Insoluto ;
  Array_Mem_Desarr[1].Valor_Cupon_Original    := Array_Mem_Desarr[1].Valor_Cupon    ;
  Array_Mem_Desarr[1].Dias_Base_PAR           := iDiasBaseTasa;
  Array_Mem_Desarr[1].Periodos_Tasa_Base_Variable := 1;

  if (sParametros_Formula.Aplica_Factor_Correccion = 'S') then
  begin
     Calcula_Variacion_Cambiaria(sParametros_Formula.Mon_Ind_Correccion
                                ,sParametros_Formula.Fecha_Desde_Corr
                                ,sParametros_Formula.Fecha_Hasta_Corr
                                ,Registro_Fechas
                                ,100
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

     Array_Mem_Desarr[1].Interes        := Array_Mem_Desarr[1].Interes        * fFactor_Correccion;
     Array_Mem_Desarr[1].Amortizacion   := Array_Mem_Desarr[1].Amortizacion   * fFactor_Correccion;
     Array_Mem_Desarr[1].Saldo_Insoluto := Array_Mem_Desarr[1].Saldo_Insoluto * fFactor_Correccion;
     Array_Mem_Desarr[1].Valor_Cupon    := Array_Mem_Desarr[1].Valor_Cupon    * fFactor_Correccion;
     Array_Mem_Desarr[1].Factor_Varcam  := fFactor_Correccion;
  end;

  if (sParametros_Formula.Aplica_Factor_Correccion = 'S') then
     RegDes.Variacion_Cambiaria := True
  else
     RegDes.Variacion_Cambiaria := False;

  // Aun que sea Tasa Flotante para los unicos va 'N'
  RegDes.TASA_FLOTANTE       := 'N';

  aux_fecha := Array_Mem_Desarr[1].Fecha_Vcto;
  DiasEfectivosPago := False;
  // Cambiado a mem 04-09-2014 F.I.
  Determina_Dias_Efectivos_Pago_Mem( sPais_Usuario,
                                     RegDes.Codigo_Emisor,
                                     RegDes.Codigo_Instrumento,
                                     RegDes.Serie,
                                     //RegDes.Nemotecnico,
                                     '',
                                     aux_fecha,
                                     fCantidad,
                                     sUnidad,
                                     sHabiles,
                                     sAntes_Despues,
                                     sAfecta,
                                     DiasEfectivosPago);

//            (*
  if DiasEfectivosPago Then
  Begin
     if fCantidad > 0 then
     begin
       iDias  := 0;
       iMeses := 0;
       iAnos  := 0;

       if sAntes_Despues = 'A' then
          fCantidad := fCantidad * (-1);

       if sUnidad = 'DIA' then
          iDias := ROUND(fCantidad);

       if sUnidad = 'MES' then
          iMeses := ROUND(fCantidad);

       if sUnidad = 'ANO' then
          iAnos := ROUND(fCantidad);

       if (sUnidad = 'DIA') AND (sHabiles = 'S') then
       begin
         if sAntes_Despues = 'A' then
            aux_fecha := Resta_dias_habiles(sPais_Usuario
                                              ,aux_fecha
                                              ,ABS(fCantidad))
         else
            aux_fecha := suma_dias_habiles(sPais_Usuario
                                             ,aux_fecha
                                             ,ABS(fCantidad));

       end
       else
         aux_fecha := IncDate(aux_fecha
                                ,iDias
                                ,iMeses
                                ,iAnos);
     end;

    if sHabiles = 'S' then
    begin
       While (Feriado_Mem(sPais_Usuario,aux_fecha)  or // OJO VA A MEMORIA DIRECTO
             (DayOfWeek(aux_fecha) in [1,7])) do
          if sAntes_Despues = 'A' then
             aux_fecha := aux_fecha - 1
          else
             aux_fecha := aux_fecha + 1;
    end;

// edosan, por If de abajo              Array_Mem_Desarr[1].Fecha_Vcto := aux_fecha;
// Inicio
              Array_Mem_Desarr[1].Fecha_Tipo_Cambio := aux_fecha;
              if sAfecta <> 'TIPOCAMBIO' then
                 Array_Mem_Desarr[1].Fecha_Vcto        := aux_fecha;
// Fin
  end
  else
     Array_Mem_Desarr[1].Fecha_Tipo_Cambio := Array_Mem_Desarr[1].Fecha_Vcto;


//*)



  Result := True;
end;
//------------------------------------------------------------------------------
function carga_tasa_flotante_unico(sParametros_Formula : TRegFormulaPAR;
                                  dFecha_Calculo       : TDateTime;
                                  sTasa_Base           : String;
                               var RegDes              : TReg_Descriptor;
                               var Array_Mem_Desarr    : TArray_Mem_Desarr;
                               var fTasa_Emision       : Double;
                               var sTipo_Nominales     : String;
                               var Modulo_Err          : String;
                               var String_Err          : String) :Boolean;
var Registro_TasFlot : TRegistro_TasFlot;
    Registro_Fechas  : TRegistro_Fechas;
    iDiasBaseTasa    : Integer;
    sTipoInteres     : String;
    bTasas_Cargadas  : Boolean;
    fValorTasa       : Double;
begin
    bTasas_Cargadas                    := False;

    Registro_TasFlot.Codigo_Tasa       := sParametros_Formula.Codigo_Tasa;
    Registro_TasFlot.Tratamiento       := sParametros_Formula.Tratamiento;
    RegDes.bSin_Tasa_en_Flujos         := False;
    if sParametros_Formula.Spread_Variable = 'TAS_SPREAD' then
       Registro_TasFlot.Factor := fTasa_Emision
    else
       if sParametros_Formula.Spread_Factor <> NULL then
          Registro_TasFlot.Factor := sParametros_Formula.Spread_Factor
       else
          Registro_TasFlot.Factor := 0;

    Registro_TasFlot.Operacion         := sParametros_Formula.Spread_Operacion;
    Registro_TasFlot.Real_Estimada     := '';
    Registro_TasFlot.Nro_Cupon         := 1;
//    Registro_TasFlot.Array_Mem_Desarr  := copy(Array_mem_Desarr);
//    Registro_TasFlot.RegDes            := Reg_Descriptor;
    Registro_TasFlot.ConCupon          := True;

    RegDes.DECIMAL_AJUSTE := decimales_moneda(sTasa_Base
                                             ,dFecha_Calculo);

    RegDes.TIPO_AJUSTE := 'R';

    iDiasBaseTasa := 0;
    Obtiene_Tasa_Flotante(Registro_TasFlot
                         ,RegDes
                         ,Registro_Fechas
                         ,''
                         ,''
                         ,iDiasBaseTasa
                         ,sTipoInteres
                         ,Array_mem_Desarr
                         ,bTasas_Cargadas
                         ,fValorTasa
                         ,Modulo_Err
                         ,String_Err
                         ,Result);

      sTipo_Nominales                 := 'I';
      Array_Mem_Desarr[1].Valor_Tasa  := fValorTasa;
      Array_Mem_Desarr[1].Tasa_flujo  := fValorTasa;
      RegDes.Tipo_Nominales           := sTipo_Nominales;

      // De aqui en adelante opera como un tasa fija estandar
      fTasa_Emision := fValorTasa;
end;
//------------------------------------------------------------------------------
procedure Calcula_Valores_Tasa_Flotante(var Reg_Descriptor          : TReg_descriptor;
                                        Registro_Fechas         : TRegistro_Fechas;
                                        sMetodo_Tasa_Referencia : String;
                                        bConCupon               : Boolean;
                                        var Array_Mem_Desarr    : TArray_Mem_Desarr;
                                        var sModulo_Err         : String;
                                        var sString_Err         : String;
                                        var Result              : Boolean);
var
  dFechaVctoAnt           : TDateTime;
  Registro_TasFlot        : TRegistro_TasFlot;
  sTipoInteresDescriptor,
  sPais_Tasa,
  sAnualidad_Conver_Descriptor,
  sTipoInteresTasFlot,
  sTipo_Conver_Descriptor          : String;
  i,
  iBaseMensualDescriptor           : Integer;
  sTipoCalculoDiasDescriptor       : String;
  iVigenciaValorDescriptor,
  iDiasBaseDescriptor,
  iDiasBaseTasFlot,
  iBaseMensualTasFlot              : Integer;
  sTipoCalculoDiasTasFlot          : String;
  iVigenciaValorTasFlot,
  iVigenciaMesesTasFlot,
  iVigenciaMesesDescriptor   : Integer;
  fPeriodo_Conver_Descriptor,
  Interes,
  fBase_Porcen_Conver_Descriptor,
  fValorTasa              : Double;
  bTasas_Cargadas,
  bTodos_Cupones          : Boolean;
  dAux_Fecha_Calculo      : TDateTime;
  bBase_Dias_Variable     : Boolean;
  fPeriodos               : Double;
  dFecha_Calculo          : TDateTime;
  sCodigo_Tasa_Cupon_Ant  : String;

//  Table_Ult_Tasa          : TTable;           // Almacena Valores de Cuando se encontro la tasa
//  Table_FutImplicit       : TTable;           // Tabla para metodo de Futuros Implicitos
begin
     Reg_Descriptor.bSin_Tasa_en_Flujos := True;
   if NOT Fecha_Valida(DateToStr(Registro_Fechas.Fecha_Calculo)) then
   begin
      sModulo_Err := 'Calcula Valores Tasa Flotante';
      sString_Err := 'Fecha de cálculo no es una fecha válida (Mala)';
      Result := False;
      exit;
   end;

   dFecha_Calculo := Registro_Fechas.Fecha_Calculo;

   if sValorizacion_Proceso <> 'SI' then
   begin
      // Creo tabla para guardar valores de la ultima vez
      // que se encontraron valores de tasa (SOLO METODO FUTURAS IMPLICITAS)
    //  Table_Ult_Tasa := TwwTable.Create(Application.Owner);

      with DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa do
      begin
          close;
     //    TableName := 'FutImpli_'+IntToStr(Application.Handle)+'_Aux';
    //     DataBaseName := 'Alias_Paradox';
    {
         with FieldDefs do
         begin
            Clear;
            Add('Codigo_Tasa'        , ftString  , 10, False);
            Add('Fecha_Calculo'      , ftdatetime,  0, False);
            Add('ValorTasa'          , ftFloat   ,  0, False);
            Add('Fecha_Inic_Periodo' , ftdatetime,  0, False);
            Add('Fecha_Vcto_Periodo' , ftdatetime,  0, False);
         end;
     }
         try
            //CreateDataSet;
            DM_Tabla_Mem_Desarr_TFija.FDLocalSQL1.DataSets[1].Name := 'Table_Ult_Tasa';

         //   CreateTable;
         except on E: EFDDBEngineException do
            begin
               ShowError(E);
               DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.Close;
             //  Table_Ult_Tasa.DeleteTable;
             //  Table_Ult_Tasa.Free;
               Exit;
            end;
         end;
      end;

      // Creo tabla para guardar valores de tasas para el caso de
      // Metodo de determinación de Tasa Futuros Implicitos
     // Table_FutImplicit := TwwTable.Create(Application.Owner);

      with DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit do
      begin
        close;
       //  TableName := 'FutImpli_'+IntToStr(Application.Handle);
       //  DataBaseName := 'Alias_Paradox';
         with FieldDefs do
         begin
            Clear;
            Add('Item'             , ftFloat   ,  0, False);
            Add('Dias_Desde'       , ftFloat   ,  0, False);
            Add('Dias_Hasta'       , ftFloat   ,  0, False);
            Add('Valor'            , ftFloat   ,  0, False);
            Add('Valor_Implicito'  , ftFloat   ,  0, False);
            Add('Base_Porcentual'  , ftFloat   ,  0, False);
         end;

         try
            CreateDataSet;
            DM_Tabla_Mem_Desarr_TFija.FDLocalSQL1.DataSets[0].Name := 'FutImpli_'+IntToStr(Application.Handle);

         except on E: EFDDBEngineException do
            begin
               ShowError(E);
               DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.Close;
           //    Table_FutImplicit.DeleteTable;
            //   Table_FutImplicit.Free;
               Exit;
            end;
         end;
      end;
   end // fin If
   else
   begin
     if bFuturas_implicitas then
     begin
       DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.EmptyDataSet;
       DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.EmptyDataSet;
     end;
   end;

   Obtener_Tasa_base_Mem(Reg_Descriptor.TASA_VALOR_PAR
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
   begin
     if sValorizacion_Proceso <> 'SI' then
     begin
        DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.Close;
      //  Table_Ult_Tasa.DeleteTable;
      //  Table_Ult_Tasa.Free;

        DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.Close;
       // Table_FutImplicit.DeleteTable;
       // Table_FutImplicit.Free;
     end;
     exit;
   end;

   Obtener_Base_Conversion_Mem(Reg_Descriptor.TASA_VALOR_PAR
                              ,sTipo_Conver_Descriptor
                              ,fPeriodo_Conver_Descriptor
                              ,sAnualidad_Conver_Descriptor
                              ,fBase_Porcen_Conver_Descriptor
                              ,sModulo_Err
                              ,sString_Err
                              ,Result
                              );
   if NOT Result then
   begin
      if sValorizacion_Proceso <> 'SI' then
      begin
        DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.Close;
     //   Table_Ult_Tasa.DeleteTable;
     //   Table_Ult_Tasa.Free;

        DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.Close;
      //  Table_FutImplicit.DeleteTable;
      //  Table_FutImplicit.Free;
      end;
     exit;
   end;


  bTasas_Cargadas := False;  // Solo lo cambia el metodo de proyeccion de tasas futuras implicitas
  // Estamos cargando ahora todos los cupones Debido a problema detectado en GAAP
  // CJ & FI 25-08-2004 (Interes_92)
  // bTodos_Cupones  := Capitaliza_Intereses(Array_Mem_Desarr);
  bTodos_Cupones  := True;

  sCodigo_Tasa_Cupon_Ant := '';

  i := 1;
  dFechaVctoAnt := Registro_Fechas.Fecha_Emision;
  While i <= Max_Nro_Cupones do
     begin
     if (Array_Mem_Desarr[i].Fecha_Vcto >= Registro_Fechas.Fecha_Calculo) or
        bTodos_Cupones then
       begin
         if (Array_Mem_Desarr[i].Tipo_Tasa <> '') then
             Reg_Descriptor.bSin_Tasa_en_Flujos := False;


         // POR SI ES TASA VARIABLE
         iDiasBaseDescriptor := Array_Mem_Desarr[i].Dias_Base_PAR;

         Registro_TasFlot.Codigo_Tasa       := Array_Mem_Desarr[i].Tipo_Tasa;
         Registro_TasFlot.Tratamiento       := Array_Mem_Desarr[i].Tratamiento;
         Registro_TasFlot.Factor            := Array_Mem_Desarr[i].Factor;
         Registro_TasFlot.Operacion         := Array_Mem_Desarr[i].Operacion;
         Registro_TasFlot.Real_Estimada     := '';
         Registro_TasFlot.Nro_Cupon         := i;
//         Registro_TasFlot.Array_Mem_Desarr  := copy(Array_mem_Desarr);
////         Registro_TasFlot.RegDes            := Reg_Descriptor;
//
////          Registro_TasFlot.RegDes.CODIGO_EMISOR          := Reg_Descriptor.CODIGO_EMISOR                     ;
////          Registro_TasFlot.RegDes.CODIGO_INSTRUMENTO     := Reg_Descriptor.CODIGO_INSTRUMENTO                ;
////          Registro_TasFlot.RegDes.SERIE                  := Reg_Descriptor.SERIE                             ;
////          Registro_TasFlot.RegDes.FECHA_VIG              := Reg_Descriptor.FECHA_VIG                         ;
////          Registro_TasFlot.RegDes.SERIE_BOLSA            := Reg_Descriptor.SERIE_BOLSA                       ;
////          Registro_TasFlot.RegDes.FECHA_EMISION          := Reg_Descriptor.FECHA_EMISION                     ;
////          Registro_TasFlot.RegDes.TASA_EMISION           := Reg_Descriptor.TASA_EMISION                      ;
////          Registro_TasFlot.RegDes.TASA_EFECTIVA          := Reg_Descriptor.TASA_EFECTIVA                     ;
////          Registro_TasFlot.RegDes.TASA_VALOR_PAR         := Reg_Descriptor.TASA_VALOR_PAR                    ;
////          Registro_TasFlot.RegDes.TASA_VALOR_PTE         := Reg_Descriptor.TASA_VALOR_PTE                    ;
////          Registro_TasFlot.RegDes.UNIDAD_MON             := Reg_Descriptor.UNIDAD_MON                        ;
////          Registro_TasFlot.RegDes.PLAZO_EN_ANOS          := Reg_Descriptor.PLAZO_EN_ANOS                     ;
////          Registro_TasFlot.RegDes.TIPO_AMORTIZAC         := Reg_Descriptor.TIPO_AMORTIZAC                    ;
////          Registro_TasFlot.RegDes.NRO_CUPONES            := Reg_Descriptor.NRO_CUPONES                       ;
////          Registro_TasFlot.RegDes.PERIODO_PAGO           := Reg_Descriptor.PERIODO_PAGO                      ;
////          Registro_TasFlot.RegDes.TIPO_VENCIMIENTO       := Reg_Descriptor.TIPO_VENCIMIENTO                  ;
////          Registro_TasFlot.RegDes.DIA_VENCIMIENTO        := Reg_Descriptor.DIA_VENCIMIENTO                   ;
////          Registro_TasFlot.RegDes.DECIMAL_AJUSTE         := Reg_Descriptor.DECIMAL_AJUSTE                    ;
////          Registro_TasFlot.RegDes.TIPO_AJUSTE            := Reg_Descriptor.TIPO_AJUSTE                       ;
////          Registro_TasFlot.RegDes.BASE_ORIGINAL          := Reg_Descriptor.BASE_ORIGINAL                     ;
////          Registro_TasFlot.RegDes.BASE_CONVERSION        := Reg_Descriptor.BASE_CONVERSION                   ;
////          Registro_TasFlot.RegDes.COD_CALC_PAR_D         := Reg_Descriptor.COD_CALC_PAR_D                    ;
////          Registro_TasFlot.RegDes.COD_CALC_TIR_D         := Reg_Descriptor.COD_CALC_TIR_D                    ;
////          Registro_TasFlot.RegDes.OPCION_PREPAGO         := Reg_Descriptor.OPCION_PREPAGO                    ;
////          Registro_TasFlot.RegDes.FECHA_PREPAGO          := Reg_Descriptor.FECHA_PREPAGO                     ;
////          Registro_TasFlot.RegDes.PRECIO_PREPAGO         := Reg_Descriptor.PRECIO_PREPAGO                    ;
////          Registro_TasFlot.RegDes.TASA_FLOTANTE          := Reg_Descriptor.TASA_FLOTANTE                     ;
////          Registro_TasFlot.RegDes.TIPO_NOMINALES         := Reg_Descriptor.TIPO_NOMINALES                    ;
////          Registro_TasFlot.RegDes.FECHAS_SINO            := Reg_Descriptor.FECHAS_SINO                       ;
////          Registro_TasFlot.RegDes.Tipo_pago              := Reg_Descriptor.Tipo_pago                         ;
////          Registro_TasFlot.RegDes.Periodo_Gracia         := Reg_Descriptor.Periodo_Gracia                    ;
////          Registro_TasFlot.RegDes.Codigo_Emisor_Old      := Reg_Descriptor.Codigo_Emisor_Old                 ;
////          Registro_TasFlot.RegDes.Codigo_Instrumento_Old := Reg_Descriptor.Codigo_Instrumento_Old            ;
////          Registro_TasFlot.RegDes.Serie_Old              := Reg_Descriptor.Serie_Old                         ;
////          Registro_TasFlot.RegDes.COD_CALC_PAR_D_Old     := Reg_Descriptor.COD_CALC_PAR_D_Old                ;
////          Registro_TasFlot.RegDes.COD_CALC_TIR_D_Old     := Reg_Descriptor.COD_CALC_TIR_D_Old                ;
////          Registro_TasFlot.RegDes.Fecha_Carga_Array_Mem  := Reg_Descriptor.Fecha_Carga_Array_Mem             ;
////          Registro_TasFlot.RegDes.Variacion_Cambiaria    := Reg_Descriptor.Variacion_Cambiaria               ;
////          Registro_TasFlot.RegDes.fCupones_Cortados      := Reg_Descriptor.fCupones_Cortados                 ;
////          Registro_TasFlot.RegDes.Dias_Base_Variables    := Reg_Descriptor.Dias_Base_Variables               ;
////          Registro_TasFlot.RegDes.bSin_Tasa_en_Flujos    := Reg_Descriptor.bSin_Tasa_en_Flujos               ;
//
//         Registro_TasFlot.ConCupon          := bConCupon;
//

         if i =  1 then
            Registro_Fechas.Fecha_Inic_Periodo := Registro_Fechas.Fecha_Emision
         else
            Registro_Fechas.Fecha_Inic_Periodo := Array_Mem_Desarr[i-1].Fecha_Vcto;

         Registro_Fechas.Fecha_Vcto_Periodo := Array_Mem_Desarr[i].Fecha_Vcto;

         dAux_fecha_Calculo := 0;
         if Array_Mem_Desarr[i].Fecha_Vcto < Registro_Fechas.Fecha_Calculo then
         begin
            dAux_fecha_Calculo            := Registro_Fechas.Fecha_Calculo;
            Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[i].Fecha_Vcto;
         end;
         // Tuve que usar la variable fPeriodos
         // Para distinguir si es tasa base variable con la marca "Tasa Depende de Periodo"
         // Por descriptor o por la tasa flotante
         fPeriodos := 1;
          if (Registro_TasFlot.Codigo_Tasa <> NULL) AND
            (Registro_TasFlot.Codigo_Tasa  <> '')   AND
            (Registro_TasFlot.Codigo_Tasa  <> ' ')  THEN
          begin
             if (Registro_TasFlot.Codigo_Tasa <> sCodigo_Tasa_Cupon_Ant) then
             begin
               sCodigo_Tasa_Cupon_Ant := Registro_TasFlot.Codigo_Tasa;
               Obtener_Tasa_base_Mem(Registro_TasFlot.Codigo_Tasa
                                    ,iDiasBaseTasFlot
                                    ,sTipoInteresTasFlot
                                    ,iBaseMensualTasFlot
                                    ,sTipoCalculoDiasTasFlot
                                    ,iVigenciaValorTasFlot
                                    ,iVigenciaMesesTasFlot
                                    ,sPais_Tasa
                                    ,sModulo_err
                                    ,sString_err
                                    ,Result
                                    );
             end;
             /// Dejo los dias Base de la tasa flotante
             // 03-07-2007
             // El array mem desarr queda con las tasas convertidas a la TASA BASE del descriptor
             // Por ende los Dias_Base_PAR del array_mem_desarr deben quedar con lo del desciptor
             //Array_Mem_Desarr[i].Dias_Base_PAR := iDiasBaseTasFlot;
             //Registro_TasFlot.Array_Mem_Desarr[i].Dias_Base_PAR  := Array_Mem_Desarr[i].Dias_Base_PAR;

              if NOT Result then
              begin
                 if sValorizacion_Proceso <> 'SI' then
                 begin
                    DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.Close;
                //    Table_Ult_Tasa.DeleteTable;
                //    Table_Ult_Tasa.Free;

                    DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.Close;
                //    Table_FutImplicit.DeleteTable;
                 //   Table_FutImplicit.Free;
                 end;
                 exit;
              end;
              // Por si es tasa base variable !!!
              Existe_Tasa_base_Mem( Trim(Registro_TasFlot.Codigo_Tasa)
                                   ,bBase_Dias_Variable
                                   );
              Registro_TasFlot.Base_TasFlot_Variable := bBase_Dias_Variable;
              if bBase_Dias_Variable then
              begin
                //Registro_Fechas.Fecha_Calculo := Array_Mem_Desarr[1].Fecha_Vcto_Anterior;
                Obtener_Tasa_base_Variable(Registro_TasFlot.Codigo_Tasa
                                          ,Registro_Fechas
                                          ,Reg_Descriptor
                                          ,Array_Mem_Desarr
                                          ,sPais_Tasa
                                          ,iDiasBaseTasFlot
                                          ,fPeriodos
                                          ,sModulo_Err
                                          ,sString_Err
                                          ,Result);

                // Dejo los dias Base de la tasa flotante (Base Dias Variable)
                Array_Mem_Desarr[i].Dias_Base_PAR := iDiasBaseTasFlot;
//                Registro_TasFlot.Array_Mem_Desarr[i].Dias_Base_PAR  := Array_Mem_Desarr[i].Dias_Base_PAR;

                if NOT Result then
                   exit;
              end;
            end
         else
         begin
            // Para el Caso que venga el codigo Tasa en blanco
            iDiasBaseTasFlot         := Array_Mem_Desarr[i].Dias_Base_PAR;
            fPeriodos                := Array_Mem_Desarr[i].Periodos_Tasa_Base_Variable;
            sTipoInteresTasFlot      := sTipoInteresDescriptor;
            iBaseMensualTasFlot      := iBaseMensualDescriptor;
            sTipoCalculoDiasTasFlot  := sTipoCalculoDiasDescriptor;
            // Esta lo pongo constante para que tome de siempre un solo periodo
            // y no intente leer tasa cuando esta viene como blanco
            iVigenciaValorTasFlot    := 0;
            iVigenciaMesesTasFlot    := iVigenciaMesesDescriptor;
         end;
//
         if NOT bTasas_Cargadas then  // Esta variable esta en True solo si el metodo de proyección
         begin                     // de flujos futuros implicitos ya cargo los valores
           Obtiene_Tasa_Flotante(Registro_TasFlot
                                ,Reg_Descriptor
                                ,Registro_Fechas
                                ,sMetodo_Tasa_Referencia
                                ,DM_Tabla_Mem_Desarr_TFija.FDLocalSQL1.DataSets[0].Name
                                ,iDiasBaseDescriptor
                                ,sTipoInteresDescriptor
                                ,Array_Mem_Desarr
                                ,bTasas_Cargadas
                                ,fValorTasa
                                ,sModulo_Err
                                ,sString_Err
                                ,Result);

           if NOT Result then
           begin
              if sValorizacion_Proceso <> 'SI' then
              begin
                  DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.Close;
               //   Table_Ult_Tasa.DeleteTable;
              //    Table_Ult_Tasa.Free;

                  DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.Close;
               //   Table_FutImplicit.DeleteTable;
               //   Table_FutImplicit.Free;
              end;
              Exit;
           end;


           //Array_Mem_Desarr := Registro_TasFlot.Array_Mem_Desarr; 12-09-2022
//           Array_Mem_Desarr := copy(Registro_TasFlot.Array_Mem_Desarr);

           Array_Mem_Desarr[i].Fecha_Tasa    := Registro_Fechas.Fecha_Tasa;
           if NOT bTasas_Cargadas then
           begin
              // Ojo si no es el caso de tasa base variable con la marca "Tasa Depende de Periodo"
              // La variable Array_Mem_Desarr[i].Periodos_Tasa_Base_Variable viene en 1
              if fPeriodos = 0 then
                 fPeriodos := 1;
              Array_Mem_Desarr[i].Valor_Tasa    := fValorTasa / fPeriodos;
              Array_Mem_Desarr[i].Tasa_Flujo    := Registro_TasFlot.Tasa_Flujo;
              Array_Mem_Desarr[i].Real_Estimado := Registro_TasFlot.Real_Estimada;
           end;
         end;
//
//         // Se cambia el calculo de intereses segun los parametrois del decriptor
//         // Se entiende que la tasa obtenida en el "Obtiene_Tasa_Flotante" viene convertida a
//         // la tasa base del descriptor !!! 17/08/2005 filigara
         Calcula_Interes(dFechaVctoAnt
                        ,Array_Mem_Desarr[i].Fecha_Vcto
                        ,Reg_Descriptor
                        ,Registro_TasFlot
                        ,Registro_Fechas
                        ,Array_Mem_Desarr
                        ,True    // Es tasa Flotante
                        ,Reg_Descriptor.TASA_VALOR_PAR
                        ,Array_Mem_Desarr[i].Valor_Tasa
                        ,iDiasBaseDescriptor
                        ,sTipoInteresDescriptor
                        ,iBaseMensualDescriptor
                        ,fBase_Porcen_Conver_Descriptor
                        ,sTipoCalculoDiasDescriptor
                        ,sPais_Tasa
                        ,iVigenciaValorTasFlot
                        ,False                // bDesagio
                        ,sMetodo_Tasa_Referencia
                        //,Table_FutImplicit.TableName
                        ,DM_Tabla_Mem_Desarr_TFija.FDLocalSQL1.DataSets[0].Name
                        ,Registro_TasFlot.Real_Estimada
                        ,Interes
                        ,sModulo_Err
                        ,sString_Err
                        ,Result);

         if NOT Result then
         begin
            if sValorizacion_Proceso <> 'SI' then
            begin
               DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.Close;
             //  Table_Ult_Tasa.DeleteTable;
            //  Table_Ult_Tasa.Free;

               DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.Close;
             //  Table_FutImplicit.DeleteTable;
             //  Table_FutImplicit.Free;
            end;
            Exit;
         end;


         if i = 1 then
           Interes := Interes * Reg_Descriptor.BASE_ORIGINAL
         else
           Interes := Interes * Array_Mem_Desarr[i-1].Saldo_Insoluto;

         Interes := ajusta_decimales(Reg_Descriptor.Tipo_Ajuste
                                      ,Interes
                                      ,Trunc(Reg_Descriptor.Decimal_Ajuste));

         // Nuevo Capitaliza la parte flotante o parte fija de los intereses
         // Se dejo fijo que si el factor de capitalizacion define que tomar
         // 9 capitaliza solo la parte flotante
         // 8 capitaliza solo la parte fija (spread) // Argentina 23-09-09 F.I.

         // Lo determina por regla de 3 Ej. Si para Tasa_Flujo tenemos interes cuanto tenemos para Valor_Tasa

         if Array_Mem_Desarr[i].Factor_cap = 9 then    // Capitaliza solo lo flotante
            Array_Mem_Desarr[i].Capitalizado_Cupon := Array_Mem_Desarr[i].Tasa_Flujo *
                                                      Interes /
                                                      Array_Mem_Desarr[i].Valor_Tasa
         else
            if Array_Mem_Desarr[i].Factor_cap = 8 then  // Capitaliza solo lo fijo
               Array_Mem_Desarr[i].Capitalizado_Cupon := Array_Mem_Desarr[i].Factor *
                                                         Interes /
                                                         Array_Mem_Desarr[i].Valor_Tasa
            else // Capitaliza como siempre
               Array_Mem_Desarr[i].Capitalizado_Cupon := Interes *
                                                         Array_Mem_Desarr[i].Factor_cap;

         Array_Mem_Desarr[i].Capitalizado_Cupon := ajusta_decimales(Reg_Descriptor.Tipo_Ajuste
                                                             ,Array_Mem_Desarr[i].Capitalizado_Cupon
                                                             ,Trunc(Reg_Descriptor.Decimal_Ajuste));

         Array_Mem_Desarr[i].Saldo_insoluto_Sin_Capitalizaciones := Array_Mem_Desarr[i].Saldo_Insoluto;

         if i = 1 then
         begin
           Array_Mem_Desarr[i].Capitalizado := Array_Mem_Desarr[i].Capitalizado_Cupon;

           Array_Mem_Desarr[i].Saldo_Insoluto := Reg_Descriptor.BASE_ORIGINAL +
                                                 Array_Mem_Desarr[i].Capitalizado_Cupon;
         end
         else
         begin
           Array_Mem_Desarr[i].Capitalizado := Array_Mem_Desarr[i-1].Capitalizado +
                                               Array_Mem_Desarr[i].Capitalizado_Cupon;

           Array_Mem_Desarr[i].Saldo_Insoluto := Array_Mem_Desarr[i-1].Saldo_Insoluto +
                                                 Array_Mem_Desarr[i].Capitalizado_Cupon;
         end;

         Array_Mem_Desarr[i].Capitalizado := ajusta_decimales(Reg_Descriptor.Tipo_Ajuste
                                                             ,Array_Mem_Desarr[i].Capitalizado
                                                             ,Trunc(Reg_Descriptor.Decimal_Ajuste));

         Array_Mem_Desarr[i].Saldo_Insoluto := ajusta_decimales(Reg_Descriptor.Tipo_Ajuste
                                                               ,Array_Mem_Desarr[i].Saldo_Insoluto
                                                               ,Trunc(Reg_Descriptor.Decimal_Ajuste));

         // Se cambia para adaptarse a la capitalizacion de solo Tasa flotante
         // Interes := Interes - (Interes * Array_Mem_Desarr[i].Factor_cap);
         Interes := Interes - Array_Mem_Desarr[i].Capitalizado_Cupon;

         Array_Mem_Desarr[i].Interes := ajusta_decimales( Reg_Descriptor.Tipo_Ajuste
                                                         ,Interes
                                                         ,Trunc(Reg_Descriptor.Decimal_Ajuste));

         Array_Mem_Desarr[i].Amortizacion := Array_Mem_Desarr[i].Amortizacion +
                                            (Array_Mem_Desarr[i].Amortizacion *
                                             Array_Mem_Desarr[i].Capitalizado /
                                             Reg_Descriptor.BASE_ORIGINAL);

         Array_Mem_Desarr[i].Amortizacion := ajusta_decimales(Reg_Descriptor.Tipo_Ajuste
                                                             ,Array_Mem_Desarr[i].Amortizacion
                                                             ,Trunc(Reg_Descriptor.Decimal_Ajuste));

         if i = Reg_Descriptor.NRO_CUPONES then
            Array_Mem_Desarr[i].Amortizacion := Array_Mem_Desarr[i].Saldo_Insoluto;


         if Array_Mem_Desarr[i].Nro_Cupon = Reg_Descriptor.Nro_Cupones then
         begin
           // Si Titulo es Anticipado NO PAGA INTERES DEL ULTIMO CUPON
           if sAnualidad_Conver_Descriptor = 'A' then
           begin
              Array_Mem_Desarr[i].Valor_Cupon := Array_Mem_Desarr[i].Amortizacion;
              Array_Mem_Desarr[i].interes     := 0;
           end
           else
              Array_Mem_Desarr[i].Valor_Cupon := Array_Mem_Desarr[i].Interes +
                                                 Array_Mem_Desarr[i].Amortizacion;
         end
         else
            Array_Mem_Desarr[i].Valor_Cupon := Array_Mem_Desarr[i].Interes +
                                               Array_Mem_Desarr[i].Amortizacion;

         Array_Mem_Desarr[i].Saldo_Insoluto := Array_Mem_Desarr[i].Saldo_Insoluto -
                                               Array_Mem_Desarr[i].Amortizacion;

       end;

       if (Array_Mem_Desarr[i].Fecha_Vcto <= Registro_Fechas.Fecha_Compra) then
       begin
         Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra := Array_Mem_Desarr[i].Amortizacion;
         Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra := Array_Mem_Desarr[i].Saldo_Insoluto;
         Array_Mem_Desarr[i].Capitalizado_Segun_Fecha_de_Compra   := Array_Mem_Desarr[i].Capitalizado;
       end
       else
       begin
         if (i = 1) then
         begin
            Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra := Reg_Descriptor.BASE_ORIGINAL -
                                                                        Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra;
         end
         else
         begin
            Array_Mem_Desarr[i].Capitalizado_Segun_Fecha_de_Compra := Array_Mem_Desarr[i-1].Capitalizado_Segun_Fecha_de_Compra;


            Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra := Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra +
                                                                        (Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra *
                                                                         Array_Mem_Desarr[i].Capitalizado_Segun_Fecha_de_Compra /
                                                                         Reg_Descriptor.BASE_ORIGINAL);

            if i = Reg_Descriptor.NRO_CUPONES then
               Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra := Array_Mem_Desarr[i-1].Saldo_Insoluto_Segun_Fecha_de_Compra;

            Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra := Array_Mem_Desarr[i-1].Saldo_Insoluto_Segun_Fecha_de_Compra -
                                                                        Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra;


         end;
       end;

      // Datos Capitalizaciones entre la compra y el calculo
      if (Array_Mem_Desarr[i].Fecha_Vcto > Registro_Fechas.Fecha_Compra) and
         (Array_Mem_Desarr[i].Fecha_Vcto <= dFecha_Calculo) then
      begin
        if i = 1 then
           Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo := Array_Mem_Desarr[i].Capitalizado_Cupon
        else
           Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo := Array_Mem_Desarr[i-1].Capitalizado_Entre_Compra_y_Calculo +
                                                                      Array_Mem_Desarr[i].Capitalizado_Cupon;

        // Proporcion de amortización sobre lo capitalizado desde la compra
        // La Amortizacion estandar esta calculada sobre
        //    Reg_Descriptor.BASE_ORIGINAL + Array_Mem_Desarr[i].Capitalizado

        if i = 1 then  // Ojo si es el primer cupon no existe nada capitalizado con anterioridad
        begin
           Array_Mem_Desarr[i].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado :=
                                                                 Array_Mem_Desarr[i].Capitalizado_Cupon;
        end
        else
        begin
           Array_Mem_Desarr[i].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo :=
                                               Array_Mem_Desarr[i].Amortizacion *
                                               Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo /
                                               (Reg_Descriptor.BASE_ORIGINAL + Array_Mem_Desarr[i].Capitalizado);

           Array_Mem_Desarr[i].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado :=
                 Array_Mem_Desarr[i-1].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado +
                 Array_Mem_Desarr[i].Capitalizado_Cupon -
                 Array_Mem_Desarr[i].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo;
        end;


      end
      else
      begin
        if i > 1 then
        begin
           Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo :=
                                 Array_Mem_Desarr[i-1].Capitalizado_Entre_Compra_y_Calculo;

        //   Array_Mem_Desarr[i].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo :=
        //                         Array_Mem_Desarr[i-1].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo;

           Array_Mem_Desarr[i].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado :=
                                 Array_Mem_Desarr[i-1].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado;
        end;
      end;

      Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra := ajusta_decimales(Reg_Descriptor.Tipo_Ajuste
                                                               ,Array_Mem_Desarr[i].Amortizaciones_Segun_Fecha_de_Compra
                                                               ,Trunc(Reg_Descriptor.Decimal_Ajuste));

      Array_Mem_Desarr[i].Capitalizado_Segun_Fecha_de_Compra := ajusta_decimales( Reg_Descriptor.Tipo_Ajuste
                                                                     ,Array_Mem_Desarr[i].Capitalizado_Segun_Fecha_de_Compra
                                                                     ,Trunc(Reg_Descriptor.Decimal_Ajuste));

      Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra := ajusta_decimales( Reg_Descriptor.Tipo_Ajuste
                                                                       ,Array_Mem_Desarr[i].Saldo_Insoluto_Segun_Fecha_de_Compra
                                                                       ,Trunc(Reg_Descriptor.Decimal_Ajuste));

      Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo :=
                   ajusta_decimales( Reg_Descriptor.Tipo_Ajuste
                                    ,Array_Mem_Desarr[i].Capitalizado_Entre_Compra_y_Calculo
                                    ,Trunc(Reg_Descriptor.Decimal_Ajuste));

      Array_Mem_Desarr[i].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo :=
                   ajusta_decimales( Reg_Descriptor.Tipo_Ajuste
                                    ,Array_Mem_Desarr[i].Amortizaciones_de_Capitalizado_Entre_Compra_y_Calculo
                                    ,Trunc(Reg_Descriptor.Decimal_Ajuste));

      Array_Mem_Desarr[i].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado :=
                   ajusta_decimales( Reg_Descriptor.Tipo_Ajuste
                                    ,Array_Mem_Desarr[i].Capitalizado_Acumulado_Entre_Compra_y_Calculo_No_Amortizado
                                    ,Trunc(Reg_Descriptor.Decimal_Ajuste));

      dFechaVctoAnt := Array_Mem_Desarr[i].Fecha_Vcto;

      if dAux_fecha_Calculo <> 0 Then
         Registro_Fechas.Fecha_Calculo := dAux_fecha_Calculo;

       inc(i);
     end;

  if sValorizacion_Proceso <> 'SI' then
  begin
     DM_Tabla_Mem_Desarr_TFija.Table_Ult_Tasa.Close;
   //  Table_Ult_Tasa.DeleteTable;
   //  Table_Ult_Tasa.Free;

     DM_Tabla_Mem_Desarr_TFija.Table_FutImplicit.Close;
   //  Table_FutImplicit.DeleteTable;
   //  Table_FutImplicit.Free;
  end;

end;
//------------------------------------------------------------------------------
function Capitaliza_Intereses(var Array_Mem_Desarr : TArray_Mem_Desarr) : Boolean;
var
   i : Integer;
begin
  i := 1;
  Result := False;
//  While i = Array_Mem_Desarr[i].Nro_Cupon do
    While i < Max_Nro_Cupones do
    begin
       if Array_Mem_Desarr[i].Factor_cap <> 0 then
          begin
            Result := True;
            exit;
          end;
       Inc(i);
       if i > Max_Nro_Cupones then
          exit;
    end;
end;
//------------------------------------------------------------------------------
function Con_Cupones_Cortados(dFecha_Calculo : TDateTime;
                              RegDes         : TReg_descriptor;
                              bConCupon      : Boolean;
                              var Array_Mem_Desarr : TArray_Mem_Desarr;
                              var Modulo_Err       : String;
                              var String_Err       : String;
                              var Err_Result           : Boolean) : Boolean;
var
  i : Integer;
begin
   Result := False;
{ Se reemplazo la llamada al Cupon Vigente, ya que tras el cambio
en el cual se considera vigente el siguiente cupon a pagar y no el cortado
nos impedia determinar se habia cambiado el nemotecnico, correctamente
   Cupon_Vigente(Array_Mem_Desarr
                ,RegDes
                ,dFecha_Calculo
                ,bConCupon
                ,i
                ,Modulo_Err
                ,String_Err
                ,Err_Result);

   if NOT Err_Result then
      exit;
}

  // inicio Determinación del cupon vigente
//  iCuponVigente := 1;
//  While (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto < dFecha) do
  for i := 1 to Max_Nro_Cupones do
  begin
    if Array_Mem_Desarr[i].Fecha_Vcto >= dFecha_Calculo  then
       Break;

    if i > Max_Nro_Cupones then
    begin
       Modulo_Err := 'Cupon vigente en Tabla de Desarrollo';
       String_Err := 'Se detecto problema con maximo de cupones.'#10
                    +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                    +'Se aborta proceso. Contactese con el Administrador';
       Result := False;
       exit;
    end;

    if Array_Mem_Desarr[i].Nro_Cupon = 0 then
       begin
          Modulo_Err := 'Cupon vigente en Tabla de Desarrollo';
          String_Err := 'No se encontro cupon vigente con fecha:'
                       +datetostr(dFecha_Calculo)+#10
                       +'Para Emisor      : '+RegDes.Codigo_Emisor+#10
                       +'     Instrumento : '+RegDes.Codigo_Instrumento+#10
                       +'     Serie       : '+RegDes.Serie+'.';
          Result := False;
         exit;
       end;
  end;
  {
  if NOT bConCupon then
  begin
     if iCuponVigente < RegDes.Nro_Cupones then
        if Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = dFecha_Calculo then
           iCuponVigente := iCuponVigente + 1
  end
  else
  begin
     // Si el cupon Viene Marcado Cortado !!!!!NO SE CONSIDERA!!!!!!
     if iCuponVigente < RegDes.Nro_Cupones then
        if (Array_Mem_Desarr[iCuponVigente].Fecha_Vcto = dFecha_Calculo) and
           (Array_Mem_Desarr[iCuponVigente].Cupon_Cortado)  then
           iCuponVigente := iCuponVigente + 1
  end;
  // fin Determinación del cupon vigente
  }
   While Array_Mem_Desarr[i].Nro_Cupon = i do
   begin
      if Array_Mem_Desarr[i].Cupon_Cortado then
      begin
         if Array_Mem_Desarr[i].Fecha_Vcto <> dFecha_Calculo then
         begin
            Result := True;
            Break;
         end;
      end;
      Inc(i);
      if i > Max_Nro_Cupones then
         Break;
   end;
end;

procedure carga_Mem_Desarr_Prepago(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                   sCodigo_Emisor,
                                   sCodigo_Instrumento,
                                   sSerie,
                                   sTipoAmortizacion      : String;
                                   iNroCupones            : Integer;
                                   fTasa_Emision          : Double;
                                   var Modulo_Err         : String;
                                   var String_Err         : String;
                                   var Result             : Boolean);
var
   i : Integer;
begin
    Result := True;

     Asigna_Numero_de_cupones ( Array_Mem_Desarr
                               ,'PREPAGO'
                               ,sCodigo_Emisor
                               ,sCodigo_Instrumento
                               ,sSerie
                               ,0
                               ,Modulo_Err
                               ,String_Err
                               ,Result    );
     if NOT Result then
        exit;


    i := 1;
    Inicializa_Mem_Desarr(Array_Mem_Desarr);
    WITH DM_Tabla_Mem_Desarr_TFija.Query1 do
    begin
       SQL.Clear;
       SQL.Add('SELECT Numero_de_Cupon'
              +'      ,Interes_Cupon'
              +'      ,Amortiz_Cupon'
              +'      ,Saldo_Insol_Cupon'
              +'      ,Tasa_Prepago'
              +'  FROM QS_FIN_DESARR_PREPAG'
              +' WHERE Serie              = :Serie'
              +'   AND Codigo_Instrumento = :Codigo_Instrumento'
              +'   AND Codigo_Emisor      = :Codigo_Emisor'
              +' ORDER By Numero_de_Cupon'    // Los Ordeno para que sea igual al indice
              );
       ParamByName('Codigo_Emisor').AsString      := sCodigo_Emisor;
       ParamByName('Codigo_Instrumento').AsString := sCodigo_Instrumento;
       ParamByName('Serie').AsString              := sSerie;
       Open;
       i := 1;
       WHILE NOT EOF DO
       begin
          if i > Max_Nro_Cupones then
          begin
            Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
            String_Err := 'Se detecto problema con maximo de cupones.'#10
                         +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                         +'Emisor      : '+sCodigo_Emisor+' '#10
                         +'Instrumento : '+sCodigo_Instrumento+' '#10
                         +'Serie       : '+sSerie+' '#10
                         +'Se aborta proceso. Contactese con soporte PMS';
            Close;
            Result := False;
            exit;
          end;

          Array_Mem_Desarr[i].Nro_Cupon         := FieldByName('Numero_de_Cupon').AsInteger;
          Array_Mem_Desarr[i].Tasa_Flujo        := FieldByName('Tasa_Prepago').AsFloat;//fTasa_Emision;
          Array_Mem_Desarr[i].Valor_Tasa        := FieldByName('Tasa_Prepago').AsFloat;
          Array_Mem_Desarr[i].Interes           := FieldByName('Interes_Cupon').AsFloat;
          Array_Mem_Desarr[i].Amortizacion      := FieldByName('Amortiz_Cupon').AsFloat;
          Array_Mem_Desarr[i].Saldo_Insoluto    := FieldByName('Saldo_Insol_Cupon').AsFloat;
          Array_Mem_Desarr[i].Valor_Cupon       := Array_Mem_Desarr[i].Interes +
                                                         Array_Mem_Desarr[i].Amortizacion;

          inc(i);
          Next;
       end;
       Close;
    end;//end with

    i := i - 1;
    if (NOT Result) and
     (i > Max_Nro_Cupones) then
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
        String_Err := 'Se detecto problema con maximo de cupones.'#10
                     +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                      +'Emisor      : '+sCodigo_Emisor+' '#10
                      +'Instrumento : '+sCodigo_Instrumento+' '#10
                      +'Serie       : '+sSerie+' '#10
                     +'Se aborta proceso. Contactese con el Administrador';
        Result := False;
        exit;
     end;

     if (i = 0) then  // No encontro ningun cupon
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
        String_Err := 'No se encontró Tabla de Desarrollo para: '#10
                      +'Emisor      : '+sCodigo_Emisor+' '#10
                      +'Instrumento : '+sCodigo_Instrumento+' '#10
                      +'Serie       : '+sSerie+' '#10;
        Result := False;
        exit;
     end;

  if (i <> iNroCupones) then  // Inconsistencia
  begin
     Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
     String_Err := 'Existe una inconsistencia entre los cupones (Prepago)'#10
                   +'indicados en el descriptor y los encontrados'#10
                   +'en la tabla de desarrollo para:'#10
                   +'Emisor      : '+sCodigo_Emisor+' '#10
                   +'Instrumento : '+sCodigo_Instrumento+' '#10
                   +'Serie       : '+sSerie+' '#10
                   +'En Descriptor : '+inttostr(iNroCupones)+' cupones.'#10
                   +'En Tabla de desarrollo : '+inttostr(i)+' cupones.';
     Result := False;
     exit;
  end;
end;

procedure carga_Mem_Desarr_Prepago_Vig(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                       sCodigo_Emisor,
                                       sCodigo_Instrumento,
                                       sSerie,
                                       sTipoAmortizacion      : String;
                                       iNroCupones            : Integer;
                                       fTasa_Emision          : Double;
                                       dFecha_Vig             : TDateTime;
                                       var Modulo_Err         : String;
                                       var String_Err         : String;
                                       var Result             : Boolean);
var
   i : Integer;
begin
    Result := True;

     Asigna_Numero_de_cupones ( Array_Mem_Desarr
                               ,'PREPAGO-VIG'
                               ,sCodigo_Emisor
                               ,sCodigo_Instrumento
                               ,sSerie
                               ,dFecha_Vig
                               ,Modulo_Err
                               ,String_Err
                               ,Result    );
     if NOT Result then
        exit;


    Inicializa_Mem_Desarr(Array_Mem_Desarr);
    WITH DM_Tabla_Mem_Desarr_TFija.Query1 do
    begin
       SQL.Clear;
       SQL.Add('SELECT a.Numero_de_Cupon'
              +'      ,a.Interes_Cupon'
              +'      ,a.Amortiz_Cupon'
              +'      ,a.Saldo_Insol_Cupon'
              +'      ,a.Tasa_Prepago'
              +'  FROM QS_FIN_DESARR_PREPAG a'
              +' WHERE a.Serie              = :Serie'
              +'   AND a.Codigo_Instrumento = :Codigo_Instrumento'
              +'   AND a.Codigo_Emisor      = :Codigo_Emisor');
       if sDriver = 'ORACLE' then
          SQL.Add('   AND trunc(a.Fecha_Vig) in (SELECT MAX(trunc(x.Fecha_Vig))')
       else
          SQL.Add('   AND convert(CHAR(10),a.Fecha_Vig,103) in (SELECT MAX(convert(CHAR(10),x.Fecha_Vig,103))');
       SQL.Add('                               FROM qs_fin_descriptor x'
              +'                              WHERE x.Serie              = a.Serie'
              +'                                AND x.Codigo_Instrumento = a.Codigo_Instrumento'
              +'                                AND x.Codigo_Emisor      = a.Codigo_Emisor'
              +'      	                        AND x.Fecha_Vig    <= :Fecha_Vig)'
              +' ORDER By Numero_de_Cupon'    // Los Ordeno para que sea igual al indice
              );
       ParamByName('Codigo_Emisor').AsString      := sCodigo_Emisor;
       ParamByName('Codigo_Instrumento').AsString := sCodigo_Instrumento;
       ParamByName('Serie').AsString              := sSerie;
       ParamByName('Fecha_Vig').AsDate        := dFecha_Vig;
       Open;

       i := 1;
       WHILE NOT EOF DO
       begin
          if i > Max_Nro_Cupones then
          begin
            Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
            String_Err := 'Se detecto problema con maximo de cupones.'#10
                         +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                         +'Emisor      : '+sCodigo_Emisor+' '#10
                         +'Instrumento : '+sCodigo_Instrumento+' '#10
                         +'Serie       : '+sSerie+' '#10
                         +'Se aborta proceso. Contactese con soporte PMS';
            Close;
            Result := False;
            exit;
          end;

          Array_Mem_Desarr[i].Nro_Cupon         := FieldByName('Numero_de_Cupon').AsInteger;
          Array_Mem_Desarr[i].Tasa_Flujo        := FieldByName('Tasa_Prepago').AsFloat;//fTasa_Emision;
          Array_Mem_Desarr[i].Valor_Tasa        := FieldByName('Tasa_Prepago').AsFloat;
          Array_Mem_Desarr[i].Interes           := FieldByName('Interes_Cupon').AsFloat;
          Array_Mem_Desarr[i].Amortizacion      := FieldByName('Amortiz_Cupon').AsFloat;
          Array_Mem_Desarr[i].Saldo_Insoluto    := FieldByName('Saldo_Insol_Cupon').AsFloat;
          Array_Mem_Desarr[i].Valor_Cupon       := Array_Mem_Desarr[i].Interes +
                                                         Array_Mem_Desarr[i].Amortizacion;

          inc(i);
          Next;
       end;
       Close;
    end;//end with

     i := i - 1;
    if (NOT Result) and
     (i > Max_Nro_Cupones) then
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
        String_Err := 'Se detecto problema con maximo de cupones.'#10
                     +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                      +'Emisor      : '+sCodigo_Emisor+' '#10
                      +'Instrumento : '+sCodigo_Instrumento+' '#10
                      +'Serie       : '+sSerie+' '#10
                     +'Se aborta proceso. Contactese con el Administrador';
        Result := False;
        exit;
     end;

     if (i = 0) then  // No encontro ningun cupon
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
        String_Err := 'No se encontró Tabla de Desarrollo para: '#10
                      +'Emisor      : '+sCodigo_Emisor+' '#10
                      +'Instrumento : '+sCodigo_Instrumento+' '#10
                      +'Serie       : '+sSerie+' '#10;
        Result := False;
        exit;
     end;

  if (i <> iNroCupones) then  // Inconsistencia
  begin
     Modulo_Err := 'Carga en Memoria Tabla de Desarrollo(Prepago)';
     String_Err := 'Existe una inconsistencia entre los cupones'#10
                   +'indicados en el descriptor y los encontrados'#10
                   +'en la tabla de desarrollo para:'#10
                   +'Emisor      : '+sCodigo_Emisor+' '#10
                   +'Instrumento : '+sCodigo_Instrumento+' '#10
                   +'Serie       : '+sSerie+' '#10
                   +'En Descriptor : '+inttostr(iNroCupones)+' cupones.'#10
                   +'En Tabla de desarrollo : '+inttostr(i)+' cupones.';
     Result := False;
     exit;
  end;
end;

procedure Verifica_Cupones_Cortados(sEmpresa          : String;
                                    sCartera          : String;
                                    sTransaccion      : String;
                                    sFolio_Interno    : String;
                                    fItem_Omd         : Double;
                                    dFecha_Analisis   : TDateTime;
                                    Reg_Val_Out       : TRegistro_Valoriza_Out;
                                var iCupones_cortados : Integer;
                                var Modulo_Err        : String;
                                var String_Err        : String;
                                var Result            : Boolean
                                    );
var
iDif             : Integer;
iCupon_Vigente_1 : Integer;
iCupon_Vigente_2 : Integer;
dFecha_Compra    : TDateTime;
begin
  with dmComunInversiones.Qry_General do
  begin
    Close;
    Sql.Clear;
    Sql.Add('Select a.fecha_Operacion  '
           +'      ,b.Cupones_Cortados '
           +' from qs_tra_omd_det_rf b '
           +'     ,qs_tra_omd a '
           +' WHERE b.Folio_Interno  = :Folio_Interno '
           +'   and b.Item_Omd       = :Item_Omd '
           +'   and b.Transaccion    = :Transaccion '
           +'   and b.Empresa        = :Empresa '
           +'   and b.Cartera        = :Cartera '
           +'   and a.Folio_Interno  = b.Folio_Interno '
           +'   and a.Transaccion    = b.Transaccion '
           +'   and a.Empresa        = b.Empresa '
           );
     ParamByName('Folio_Interno').AsString := sFolio_Interno;
     ParamByName('Item_Omd').AsFloat       := fItem_Omd;
     ParamByName('Transaccion').AsString   := sTransaccion;
     ParamByName('Cartera').AsString       := sCartera;
     ParamByName('Empresa').AsString       := sEmpresa;
     Prepare;
     Open;
     if (FieldByName('Cupones_Cortados').IsNull) or
        (FieldByName('Cupones_Cortados').AsFloat = 0) then
        iCupones_cortados := 0
     else
        begin
          iCupones_cortados := FieldByName('Cupones_Cortados').AsInteger;
          dFecha_Compra     := FieldByName('Fecha_Operacion').AsDateTime;
        end;
     Close;
     Unprepare;
     if iCupones_cortados > 0 then
     begin
       {determinar cupon vigente a la fecha de compra }
       Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                     Reg_Val_Out.RegDes,
                     dFecha_Compra,
                     False,
                     iCupon_Vigente_1,
                     Modulo_Err,
                     String_Err,
                     Result
                     );
       {determinar cupon vigente a la fecha de Analisis }
       Cupon_Vigente(Reg_Val_Out.Array_Mem_Desarr,
                     Reg_Val_Out.RegDes,
                     dFecha_Analisis,
                     False,
                     iCupon_Vigente_2,
                     Modulo_Err,
                     String_Err,
                     Result
                     );
       iDif := iCupon_Vigente_2 - iCupon_Vigente_1;
       if iDif > iCupones_cortados then
          iCupones_cortados := 0
       else
          iCupones_cortados := iCupones_cortados - iDif;
     end;
  end;{with}
end;

Function Existe_Tabla_Desarr_Prepago( sCodigo_Emisor,
                                      sCodigo_Instrumento,
                                      sSerie    : String
                                     ) : Boolean ;
begin
    Result := False;
    WITH DM_Tabla_Mem_Desarr_TFija.Query1 do
    begin
       SQL.Clear;
       SQL.Add('SELECT Numero_de_Cupon'
              +'  FROM QS_FIN_DESARR_PREPAG'
              +' WHERE Serie              = :Serie'
              +'   AND Codigo_Instrumento = :Codigo_Instrumento'
              +'   AND Codigo_Emisor      = :Codigo_Emisor'
              );
       ParamByName('Codigo_Emisor').AsString      := sCodigo_Emisor;
       ParamByName('Codigo_Instrumento').AsString := sCodigo_Instrumento;
       ParamByName('Serie').AsString              := sSerie;

       try
         Open;
         if NOT Fieldbyname('Numero_de_Cupon').isNull then
            Result := True;
       except
          Result := False;
       end;
       Close;
    end;//end with
end;

Function Existe_Tabla_Desarr_Prepago_Vig( sCodigo_Emisor,
                                          sCodigo_Instrumento,
                                          sSerie    : String;
                                          dFecha_Vig :TDateTime
                                         ) : Boolean ;
begin
    Result := False;
    WITH DM_Tabla_Mem_Desarr_TFija.Query1 do
    begin
       SQL.Clear;
       SQL.Add('SELECT a.Numero_de_Cupon'
              +'  FROM QS_FIN_DESARR_PREPAG a'
              +' WHERE a.Serie              = :Serie'
              +'   AND a.Codigo_Instrumento = :Codigo_Instrumento'
              +'   AND a.Codigo_Emisor      = :Codigo_Emisor');
       if sDriver = 'ORACLE' then
          SQL.Add('   AND TRUNC(a.Fecha_Vig) in (SELECT MAX(TRUNC(x.Fecha_Vig))')
       else
          SQL.Add('   AND CONVERT(CHAR(10),a.Fecha_Vig,103) in (SELECT MAX(CONVERT(CHAR(10),x.Fecha_Vig,103))');
       SQL.Add('                               FROM qs_fin_descriptor x'
              +'                              WHERE x.Serie              = a.Serie'
              +'                                AND x.Codigo_Instrumento = a.Codigo_Instrumento'
              +'                                AND x.Codigo_Emisor      = a.Codigo_Emisor'
              +'      	                        AND x.Fecha_Vig    <= :Fecha_Vig)'
              );

       ParamByName('Codigo_Emisor').AsString      := sCodigo_Emisor;
       ParamByName('Codigo_Instrumento').AsString := sCodigo_Instrumento;
       ParamByName('Serie').AsString              := sSerie;
       ParamByName('Fecha_Vig').AsDate        := dFecha_Vig;

       try
         Open;
         if NOT Fieldbyname('Numero_de_Cupon').isNull then
            Result := True;
       except
          Result := False;
       end;
       Close;
    end;//end with
end;

 procedure carga_Mem_Desarr_TFija_Prdx(var Array_Mem_Desarr : TArray_Mem_Desarr;
                                       sCodigo_Emisor,
                                       sCodigo_Instrumento,
                                       sSerie,
                                       sTipoAmortizacion      : String;
                                       iNroCupones            : Integer;
                                       fTasa_Emision          : Double;
                                       var Modulo_Err         : String;
                                       var String_Err         : String;
                                       var Result             : Boolean
                                       );
var
   i : Integer;
begin
    Result := True;
    Inicializa_Mem_Desarr(Array_Mem_Desarr);
    WITH DM_Tabla_Mem_Desarr_TFija.Qry_Tabla_Desarr_Prdx do
    begin
       Sql.Clear;
       Sql.Add( 'SELECT Numero_de_Cupon'
               +'     ,Interes_Cupon'
               +'     ,Amortiz_Cupon'
               +'     ,Saldo_Insol_Cupon'
               +' FROM '+ sNombre_Tabla_Flujos_Pdrx
               +' WHERE Serie = :Serie'
               +'    AND Codigo_Emisor = :Codigo_Emisor'
               +'    AND Codigo_Instrumento = :Codigo_Instrumento'
               +'   ORDER By Numero_de_Cupon'
               );
       ParamByName('Serie').AsString              := sSerie;
       ParamByName('Codigo_Instrumento').AsString := sCodigo_Instrumento;
       ParamByName('Codigo_Emisor').AsString      := sCodigo_Emisor;
       Open;
       i := 1;
       WHILE NOT EOF DO
       begin
          if i > Max_Nro_Cupones then
          begin
            Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
            String_Err := 'Se detecto problema con máximo de cupones.'#10
                         +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                         +'Se aborta proceso. Contactese con soporte PMS';
            Close;
            Result := False;
            exit;
          end;

          Array_Mem_Desarr[i].Nro_Cupon         := FieldByName('Numero_de_Cupon').AsInteger;
          Array_Mem_Desarr[i].Tasa_Flujo        := fTasa_Emision;
          Array_Mem_Desarr[i].Valor_Tasa        := fTasa_Emision;
          Array_Mem_Desarr[i].Interes           := FieldByName('Interes_Cupon').AsFloat;
          Array_Mem_Desarr[i].Amortizacion      := FieldByName('Amortiz_Cupon').AsFloat;
          Array_Mem_Desarr[i].Saldo_Insoluto    := FieldByName('Saldo_Insol_Cupon').AsFloat;
          Array_Mem_Desarr[i].Valor_Cupon       := Array_Mem_Desarr[i].Interes +
                                                         Array_Mem_Desarr[i].Amortizacion;
          Next;
          Inc(i);
       end;
       Close;
    end;//end with

     i := i - 1;
    if (NOT Result) and
     (i > Max_Nro_Cupones) then
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
        String_Err := 'Se detecto problema con maximo de cupones.'#10
                     +'Maximo: '+inttostr(Max_Nro_Cupones)+#10
                     +'Se aborta proceso. Contactese con el Administrador';
        Result := False;
        exit;
     end;

     if (i = 0) then  // No encontro ningun cupon
     begin
        Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
        String_Err := 'No se encontró Tabla de Desarrollo para: '#10
                      +'Emisor      : '+sCodigo_Emisor+' '#10
                      +'Instrumento : '+sCodigo_Instrumento+' '#10
                      +'Serie       : '+sSerie+' '#10;
        Result := False;
        exit;
     end;

  if (i <> iNroCupones) then  // Inconsistencia
  begin
     Modulo_Err := 'Carga en Memoria Tabla de Desarrollo';
     String_Err := 'Existe una inconsistencia entre los cupones'#10
                   +'indicados en el descriptor y los encontrados'#10
                   +'en la tabla de desarrollo para:'#10
                   +'Emisor      : '+sCodigo_Emisor+' '#10
                   +'Instrumento : '+sCodigo_Instrumento+' '#10
                   +'Serie       : '+sSerie+' '#10
                   +'En Descriptor : '+inttostr(iNroCupones)+' cupones.'#10
                   +'En Tabla de desarrollo : '+inttostr(i)+' cupones.';
     Result := False;
     exit;
  end;
end;


end.


