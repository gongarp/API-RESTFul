unit DM_Comun_Gestion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,  Wwtable, DM_Variables_Valorizacion, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, DM_Base_Datos;
const
  MAXREGTMPFLOT = 500;  // Maximo de registros posibles para tablas de desarrollos

type
 TOmd_RV = Record
             sEmpresa            : String;
             sCartera            : String;
             sTransaccion        : String;
             sNemotecnico        : String;
             sNemotecnico_Actual : String;
             sFolio              : String;
             fItem_Omd           : Double;
             dFecha_Operacion    : TDateTime;
             fNominales          : Double;
             fCosto_Promedio_UM  : Double;
             fCosto_Promedio     : Double;
             fCosto_Promedio_UM_SinRea : Double;
             fCosto_Promedio_SinRea    : Double;
             sInstrumento        : String;
             sMoneda_OMD         : String;
             fTipo_Cambio        : Double;
             fPrecio_Cpa         : Double;
             sMoneda_Ins         : String;
             sEspecifica_Reajuste : String; // Lo estoy usando para determinar si existe Reajuste indicado por cada OMD
             sIndice_Reajuste    : String;
             sProceso            : String;
             fTipo_Cambio_Original  : Double;
             dFecha_Inicio_Reajuste : TDateTime;
             dFecha_Final_Reajuste  : TDateTime;
             fRedondeo_Reajuste     : Double;
             bFecha_Exacta          : Boolean;
             sMoneda_Conversion     : String;
           end;
// TOmd_Renta_V  = Array[1..99000] of TOmd_RV;
// TOmd_Renta_V  = Array[1..199000] of TOmd_RV;    // DC 16/05/2023   Array[1..160000] of TOmd_RV;
 TOmd_Renta_V  = Array[1..299000] of TOmd_RV;    // ES 08/02/2024   BiceVida pasó los 199.000
 TOmd_Renta_VP = ^TOmd_Renta_V;

 TIPC = Array[1900..2050,1..12] of Double;

 TDesarrollo = Record
                  fNro_Cupon        : Double;
                  dFecha_vcto_cupon : TDateTime;
                  fInteres          : Extended;
                  fAmortizacion     : Extended;
                  fFlujo            : Extended;
                  fSaldo_Insoluto   : Extended;

                  sTipo_Tasa        : String;
                  sTratamiento      : String;
                  sOperacion        : String;
                  fFactor           : Double;
                  fTasa_Flotante    : Double;
                  fFactor_cap       : Double;
                end;

  TDescriptor = Record
                  dFecha_Emision    : TDateTime;
                  dFecha_Vencimiento: TDateTime;
                  fTasa_emision     : Double;
                  fTasa_real        : Double;
                  sUnidad_titulo    : String;
                  sTipo_Interes_par : String;
                  sTipo_Interes_tir : String;
                  fDias_ref_tasa_par: Double;
                  fDias_ref_tasa_tir: Double;
                  iBaseCalculodias_p: Integer;
                  iBaseCalculodias_t: Integer;
                  fDia_pago         : Double;
                  fPeriodo_pago     : Double;
                  sTipo_Vcto        : String;
                  sTipo_Anualidad   : String;
                  fPeriodos_gracia  : Double;
                  fBase_Conversion  : Double;
                  sFormula_par      : String;
                  sFormula_Tir      : String;
                  fNro_Cupones      : Double;
                  fCupon_Vigente    : Double;
                  dFecha_Last_cupon : TDateTime;
                  dFecha_Next_cupon : TDateTime;
                  fSaldo_Insoluto   : Double;
                  sTasa_base_Par    : String;
                  sTasa_Base_Tir    : String;
                end;

  TReg_Stock_rv = Record
                     sNemotecnico : String;
                     fCantidad    : Double;
                  end;
  TStock_rv =  Array[1..500] of TReg_Stock_rv;
  TFechas_Tramos = Array[1..500] of TDateTime;
  TTipo_Tramos = Array[1..500] of String;

  TDm_Comun_Gestion_F = class(TDataModule)
    Qry_Varios: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Calculo_Stock_Dividendos_Nemo_Rv(var sNemotecnico            : String;
                                               sCartera                : String;
                                               sEmpresa                : String;
                                               sTransaccion            : String;
                                               dFecha_Cierre           : TDateTime;
                                               dFecha_Inicio_Dividendo : TDatetime;
                                           var fCompras                : Double;
                                           var fCompras_Sin_Derecho    : Double;
                                           var fVentas                 : Double;
                                           var fVentas_Sin_Derecho     : Double;
                                           var fStock                  : Double
                                           );

procedure Calculo_Compras_Pendientes_Rv(sNemotecnico   : String;
                                        sCartera       : String;
                                        sEmpresa       : String;
                                        dFecha_Cierre  : TDateTime;
                                        sFolio_Interno : String;
                                    var fCompras       : Double
                                       );

procedure Descripcion_Nemotecnico_RV(sNemotecnico  : String;
                                  var sDescripcion : String;
                                  var bResultado   : Boolean
                                    );                                       
                                    
procedure Calculo_Ventas_Pendientes_Rv(sNemotecnico   : String;
                                       sCartera       : String;
                                       sEmpresa       : String;
                                       dFecha_Cierre  : TDateTime;
                                       sFolio_Interno : String;
                                  var fVentas         : Double
                                       );
  
function Busca_Precio_Rv(sNemotecnico : String;
                         sTipo_Precio : String;
                         dFecha_Precio: TDateTime;
                     var Resultado    : Boolean): Double;

function Es_dia_Habil(sCodigo_Division : String;
                      dFecha           : TDatetime) : Boolean;


//Function Clasif_Riesgo(sEmisor      : String;
//                       sInstrumento : String;
//                       sSerie       : String;
//                       dFecha       : TDateTime):String;

//Procedure Clasif_Riesgo_P(sEmisor      : string;
//                          sInstrumento : String;
//                          sSerie       : String;
//                          dFecha       : TDateTime;
//                      var sClasif_riesgo: String;
//                      var fFactor_riesgo: Double
//                          );

function Valor(c:String):Integer;
function Codigo_Riesgo(f:Double):String;

Function Codigo_Riesgo_f(iNumero : Integer): String;
function Precio_Rv(sNemotecnico : String;
                   sTipo_Precio : String;
                   dFecha_Precio: TDateTime): Double;


procedure Datos_Nemotecnico(sNemotecnico : String;
                            dFecha       : TDateTime;
                        var sEmisor      : String;
                        var sInstrumento : String;
                        var sSerie       : String;
                        var sSector      : String;
                        var sPais        : String;
                        var sRun         : String;
                        var sMoneda      : String;
                        var bResultado   : Boolean
                        );


procedure Fecha_Fin_Tramo(dFecha_Input : TDateTime;
                          sUnidad      : STring;
                          iCantidad    : Integer;
                      var dFecha_Output: TDateTime);

procedure Fechas_Tramificacion(sCodigo_Tramifica: String;
                               dFecha_Cierre    : TDateTime;
                          var  aFechas_Tramos   : TFechas_Tramos;
                          var  iNro_Tramos      : Integer);

procedure Fechas_Tramificacion_Gestion(sCodigo_Tramifica: String;
                               dFecha_Cierre    : TDateTime;
                          var  aFechas_TramosI  : TFechas_Tramos;
                          var  aTipo_TramosI    : TTipo_Tramos;
                          var  aFechas_TramosF  : TFechas_Tramos;
                          var  aTipo_TramosF    : TTipo_Tramos;
                          var  iNro_Tramos      : Integer);

//Procedure Borrar_Tabla_Tmp_Prdox(sNombre_Tabla:String; var TTabla : TwwTable);

procedure Desplegar_Arbol(sObjeto : String;
                          fNodo   : Double;
                          fNivel  : Double;
                      var sLista  : TStringList);

procedure Desplegar_Arbol_Nodo(sObjeto : String;
                               fNodo   : Double;
                               fNivel  : Double;
                           var sLista  : TStringList);                      

function dia_habil_anterior(sCodigo_Division : String;
                            dFecha           : TDatetime) : TDatetime;

function dia_habil_siguiente(sCodigo_Division : String;
                             dFecha           : TDatetime) : TDatetime;

procedure Grabar_Indice(sIndice : String;
                        dFecha  : TDateTime;
                        fValor  : Double);

procedure Total_Inversiones(sEmpresa       : String;
                            sCartera       : String;
                            bConsolida     : Boolean;
                            fHandle        : Double;
                            sMoneda_Cartera: String;
                            dFecha_Cierre  : TDateTime;
                            sTipo_Inversion: String; // 'TT' = Todo, 'RF' = Renta Fija, 'RV' = Renta Variable, 'BR' = Bienes Raices
                            sTipo          : String; // 'C' = Contable, 'M' = Mercado
                        var fValor_Cartera : Double
                            );

procedure Descripcion_Codigo(sCod_General: String;
                             sCod_Detalle: String;
                        var  Descripcion : String);

procedure Calculo_Stock_Nemo_Rv(sTransaccion  : String;
                                sNemotecnico  : String;
                                sCartera      : String;
                                sEmpresa      : String;
                                dFecha_Cierre : TDateTime;
                            var fStock        : Double
                                );
function Calcula_dias(mesmenor,mestope,ano:word; base:boolean):integer;
procedure Diferencia_Dias(dFecha_menor: TDateTime;
                          dFecha_Mayor: TDateTime;
                          iDias_ano   : Integer;
                      var fDias       : Double);

procedure leer_valor_Tasa(sCodigo_Tasa : String;
                          dfecha       : TDatetime;
                      var fValor       : Double;
                      var Result       : Boolean);

procedure Carga_Clasificaciones_Riesgos;

function Division ( Numerador, Denominador : Double ) : Double;

function  Moneda_Consolidacion(sEmpresa : String;
                               fHandle  : Double) : String;

function Chk_Consistencia_Rv(sNemotecnico : String;
                             sCartera     : String;
                             sEmpresa     : String;
                             dFecha_stk   : TDateTime ): Double;

function Busca_Nivel_Rv(sNemotecnico : String;
                        sTipo_Precio : String;
                        dFecha_Precio: TDateTime;
                    var Resultado    : Boolean): String;

function Fecha_stock_rv(sEmpresa : String; sCartera : String): TDateTime;
function Fecha_stock_rv_con_nemotecnico(sEmpresa : String; sCartera : String; sNemotecnico : String): TDateTime;

function String_equiv(dfecha :TdateTime; sString : String): String;

{
const
  Clasif : Array[1..40] of string = ('N/R' ,'N-5-','N-5','N-5+','E-'  ,'E'  ,'E+'  ,
                                     'D-'  ,'D'   ,'D+' ,'C-'  ,'C'   ,'C+' ,
                                     'N-4-','N-4','N-4+','B-'  ,'B'  ,'B+'  ,'BB-','BB','BB+',
                                     'N-3-','N-3','N-3+','BBB-','BBB','BBB+',
                                     'N-2-','N-2','N-2+','A-'  ,'A'  ,'A+',
                                     'N-1-','N-1','AA-' ,'AA'  ,'AA+','AAA');}
const
{$j+}
   dias_mes : array [1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
{$j-}
   Nombre_Mes: array [1..12] of String  = ('ENERO','FEBRERO','MARZO'     ,'ABRIL'  ,'MAYO'     ,'JUNIO'
                                          ,'JULIO','AGOSTO' ,'SEPTIEMBRE','OCTUBRE','NOVIEMBRE','DICIEMBRE');

var
  Dm_Comun_Gestion_F: TDm_Comun_Gestion_F;
  aClasif :Array[1..90] of String;   // este array era de 40 y se cayo en BBVA pq la tabla con que se llena tenia mas de 40 reg. 30-04-2015

implementation
uses dm_Comun,
     dm_Carteras,
     DM_Codigos_generales,
     DM_ComunInversiones,
     DM_Variables_Menu,
     DM_FuncionesMemory,
     DMLeer_valor_Cambio;
{$R *.DFM}

function Division ( Numerador, Denominador : Double ) : Double;
begin
  if Denominador <> 0 then
     Result := Numerador / Denominador
  else
     Result := 0;
end;


function Es_dia_Habil(sCodigo_Division : String;
                      dFecha           : TDatetime): Boolean;
begin
  Result := True;
  if (DayOfWeek(dFecha) in [1,7]) then
      Result := False
  else
     if Feriado(sCodigo_Division, dFecha) then
        Result := False;

end;



{Esta funcion determina la Clasificacion de Riesgo vigente del Instrumento}
{ DC 27/08/2014
Function Clasif_Riesgo(sEmisor      : string;
                       sInstrumento : String;
                       sSerie       : String;
                       dFecha       : TDateTime):String;
var
  bResult       : Boolean;
  dFecha_clasif : TDateTime;
begin
   bResult := True;
   with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Sql.Clear;
       Sql.Add(' SELECT MAX(F_CLASIF_SERIE) as Fecha_clasif '
              +'   FROM QS_FIN_CL_RIESGOS '
              +'  WHERE COD_INST_SERIE = :sCOD_INST_SERIE '
              +'    AND COD_EMP_SERIE  = :sCOD_EMP_SERIE  '
              +'    AND F_CLASIF_SERIE < :dF_CLASIF_SERIE ');

       if sSerie <> '' then
          begin
            Sql.Add(' AND SERIE_CLASIF = :sSERIE_CLASIF ');
            ParamByName('sSERIE_CLASIF').AsString := sSerie;
          end;
       Sql.Add('    AND ORIGEN <= :Origen ');

       ParamByName('sCOD_INST_SERIE').AsString   := sInstrumento;
       ParamByName('sCOD_EMP_SERIE' ).AsString   := sEmisor;
       ParamByName('dF_CLASIF_SERIE').AsDateTime := dFecha;
       ParamByName('Origen').AsString            := default_codgen('AGENCIACLA','FI','');
       Prepare;
       Open;
       if FieldByName('Fecha_clasif').IsNull then
          bResult := False
       else
          dFecha_clasif := FieldByName('Fecha_clasif').AsDateTime;
       Close;
       Unprepare;
       if bResult then
          begin
            Sql.Clear;
            Sql.Add(' SELECT *  FROM QS_FIN_CL_RIESGOS        '
                   +' WHERE COD_INST_SERIE = :sCOD_INST_SERIE '
                   +'   AND COD_EMP_SERIE  = :sCOD_EMP_SERIE  '
                   +'   AND F_CLASIF_SERIE = :dF_CLASIF_SERIE ');

            if sSerie <> '' then
               begin
                 Sql.Add(' AND SERIE_CLASIF = :sSERIE_CLASIF ');
                 ParamByName('sSERIE_CLASIF').AsString := sSerie;
               end;
            Sql.Add('    AND ORIGEN <= :Origen ');

            ParamByName('sCOD_INST_SERIE').AsString   := sInstrumento;
            ParamByName('sCOD_EMP_SERIE').AsString    := sEmisor;
            ParamByName('dF_CLASIF_SERIE').AsDateTime := dFecha_clasif;
            ParamByName('Origen').AsString            := default_codgen('AGENCIACLA','FI','');
            Prepare;
            Open;
            Result := FieldByName('CLASIF_SERIE').AsString;
            Close;
            Unprepare;
          end
      else
          //La funcion retorará Clasificación N/R a todos los instrumentos
          // que no tengan clasificación
          Result := 'N/R';
     end;
end;
}
function Valor(c:String):Integer;
var i :integer;
begin
   i := 1;
   while (c <> aClasif[i]) and (i < 40) do inc(i);
   Result := i;
end;

function Codigo_Riesgo(f:Double):String;
var i :integer;
begin
  if f <> 0 then
     begin
       i := 1;
       while (i <> f) and (i < 40) do inc(i);
       Result := aClasif[i];
     end
  else
       Result := '';
end;

Function Codigo_Riesgo_f(iNumero : Integer): String;
begin
if iNumero > 0 then
   Result  := aClasif[iNumero]
else
   Result  := 'S/CR';
end;

procedure Carga_Clasificaciones_Riesgos;
begin
  with Dm_Comun_Gestion_F.Qry_Varios do
  begin
    Sql.Clear;
    Sql.Add('Select * from qs_fin_nro_riesgos order by nro_riesgo ');
    Prepare;
    Open;
    while NOT EOF do
    begin
      aClasif[FieldByName('nro_riesgo').AsInteger] := FieldByName('Codigo').AsString;
      Next;
    end;
    Close;
    Unprepare;
  end;
end;

{Esta funcion establece la Clasificacion de Riesgo y factor de riesgo del Instrumento}
{ DC 27/08/2014
Procedure Clasif_Riesgo_P(sEmisor      : string;
                          sInstrumento : String;
                          sSerie       : String;
                          dFecha       : TDateTime;
                      var sClasif_riesgo: String;
                      var fFactor_riesgo: Double
                          );
var
  bResult       : Boolean;
  dFecha_clasif : TDateTime;
begin
   bResult := True;
   with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Sql.Clear;
       Sql.Add(' SELECT MAX(F_CLASIF_SERIE) as Fecha_clasif '
              +'   FROM QS_FIN_CL_RIESGOS '
              +'  WHERE COD_INST_SERIE = :sCOD_INST_SERIE '
              +'    AND COD_EMP_SERIE  = :sCOD_EMP_SERIE  '
              +'    AND F_CLASIF_SERIE < :dF_CLASIF_SERIE ');

       if sSerie <> '' then
          begin
            Sql.Add(' AND SERIE_CLASIF = :sSERIE_CLASIF ');
            ParamByName('sSERIE_CLASIF').AsString := sSerie;
          end;
       Sql.Add('    AND ORIGEN <= :Origen ');

       ParamByName('sCOD_INST_SERIE').AsString   := sInstrumento;
       ParamByName('sCOD_EMP_SERIE' ).AsString   := sEmisor;
       ParamByName('dF_CLASIF_SERIE').AsDateTime := dFecha;
       ParamByName('Origen').AsString            := default_codgen('AGENCIACLA','FI','');
       Prepare;
       Open;
       if FieldByName('Fecha_clasif').IsNull then
          bResult := False
       else
          dFecha_clasif := FieldByName('Fecha_clasif').AsDateTime;
       Close;
//       Unprepare;
       if bResult then
          begin
            Sql.Clear;
            Sql.Add(' SELECT *  FROM QS_FIN_CL_RIESGOS        '
                   +' WHERE COD_INST_SERIE = :sCOD_INST_SERIE '
                   +'   AND COD_EMP_SERIE  = :sCOD_EMP_SERIE  '
                   +'   AND F_CLASIF_SERIE = :dF_CLASIF_SERIE ');

            if sSerie <> '' then
               begin
                 Sql.Add(' AND SERIE_CLASIF = :sSERIE_CLASIF ');
                 ParamByName('sSERIE_CLASIF').AsString := sSerie;
               end;
            Sql.Add('    AND ORIGEN <= :Origen ');

            ParamByName('sCOD_INST_SERIE').AsString   := sInstrumento;
            ParamByName('sCOD_EMP_SERIE').AsString    := sEmisor;
            ParamByName('dF_CLASIF_SERIE').AsDateTime := dFecha_clasif;
            ParamByName('Origen').AsString            := default_codgen('AGENCIACLA','FI','');
            Prepare;
            Open;
            sClasif_riesgo := FieldByName('CLASIF_SERIE').AsString;
            Close;
//            Unprepare;
          end
      else
          //La funcion retorará Clasificación N/R a todos los instrumentos
          (( que no tengan clasificación
          sClasif_riesgo := 'N/R';

      sql.Clear;
      sql.Add('Select factor from qs_fin_nro_riesgos where Codigo = :codigo ');
      ParamByName('codigo').AsString := sClasif_riesgo;
      Prepare;
      Open;
      fFactor_riesgo := FieldByName('Factor').AsFloat;
      Close;
     end;
end;
}
{------------------------------------------------------------------------------}
procedure Datos_Nemotecnico(sNemotecnico : String;
                            dFecha       : TDateTime;
                        var sEmisor      : String;
                        var sInstrumento : String;
                        var sSerie       : String;
                        var sSector      : String;
                        var sPais        : String;
                        var sRun         : String;
                        var sMoneda      : String;
                        var bResultado   : Boolean
                        );
begin
     with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Sql.Clear;
       Sql.Add('Select * from qs_fin_nem_rvari '
              +' where codigo_nemotecnico = :nemotecnico '
              +'   and fecha_desde  <= :Fecha'
              +'   and (fecha_hasta >= :Fecha or fecha_hasta is null)'
                            );
       ParamByName('Nemotecnico').AsString    := sNemotecnico;
       ParamByName('Fecha').AsDate            := dFecha;
       Prepare;
       Open;
       if RecordCount <> 0 then
       begin
         sEmisor      := FieldByName('Codigo_Identidad').AsString;
         sInstrumento := FieldByName('Codigo_Instrumento').AsString;
         sSerie       := FieldByName('Serie').AsString;
         sSector      := FieldByName('Sector').AsString;
         sPais        := FieldByName('Pais').AsString;
         sRun         := FieldByName('Run').AsString;
         sMoneda      := FieldByName('Moneda').AsString;
         bResultado   := True;
       end
       else
       begin
         sEmisor       := '***';
         sInstrumento  := '***';
         sSerie        := '***';
         sSector       := '***';
         sPais         := '';
         sRun          := '';
         sMoneda       := '';
         bResultado    := False;
       end;
       Close;
     end;
end;

function Precio_Rv(sNemotecnico : String;
                   sTipo_Precio : String;
                   dFecha_Precio: TDateTime): Double;
var dFecha : TDateTime;
begin
   dFecha := dFecha_Precio;
   if NOT Es_dia_Habil( sPais_Usuario, dFecha_Precio) then
       dFecha := dia_habil_anterior( sPais_Usuario, dFecha_Precio);

   with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       SQL.Clear;
       SQL.Add('select * from QS_FIN_PRECIOS '
              +' where  Fecha_Precio = :fecha_cierre '
              +'   and  Nemotecnico  = :Nemotecnico '
              +'   and  Tipo_Precio  = :Tipo_Precio '
              );
       ParamByName('Fecha_Cierre').AsDateTime   := dFecha;
       ParamByName('Nemotecnico').AsString      := sNemotecnico;
       ParamByName('Tipo_Precio').AsString      := sTipo_Precio;
       Prepare;
       Open;
       if RecordCount <> 0 then
          Result := FieldByName('Precio').AsFloat
       else
          Result := 0;
       Close;
       Unprepare;
     end;
end;

function AgregaMeses(Dia: word; Fecha:TDateTime; Meses:integer):TDateTime;
var
  Ano,Mes,DiasDeMes : word;
 begin
  DecodeDate(Fecha,Ano,Mes,Dia);

  Ano := Ano + Meses div 12;
  Mes := Mes + Meses mod 12;
  if Mes > 12 then
  begin
    Inc(Ano);
    Mes := Mes mod 12;
  end;
  DiasDeMes:= ultimo_dia_mes(Mes,Ano);
  if (Dia > DiasDeMes) then
      Dia := DiasDeMes;
  Result := EncodeDate(Ano,Mes,Dia);
 end;

procedure Fecha_Fin_Tramo(dFecha_Input : TDateTime;
                          sUnidad      : STring;
                          iCantidad    : Integer;
                      var dFecha_Output: TDateTime
                          );
var
  yy,mm,dd      : word;
  ano,mes,dia   : word;  // ggarcia 01-07-2013
  iAnos         : Integer;
begin
  if sUnidad = 'DIA' then
     dFecha_Output   := dFecha_Input + iCantidad;

  // ggarcia 01-07-2013
  decodedate(dFecha_Input,ano,mes,dia);

  decodedate(dFecha_Input,yy,mm,dd);

  if sUnidad = 'ANO' then
  begin
    yy         := yy + iCantidad;
    case mm of
    2          :if dd > 28 then dFecha_Output := encodedate(yy,03,01) - 1
                           else dFecha_Output := encodedate(yy,mm,dd);

    4,6,9,11   :if dd = 31 then dFecha_Output := encodedate(yy,mm,30)
                           else dFecha_Output := encodedate(yy,mm,dd);
    else   dFecha_Output := encodedate(yy,mm,dd);
    end;{case}
  end;{año}

  if sUnidad = 'MES' then
  begin
    if iCantidad > 11 then
    begin
      iAnos     := Trunc(iCantidad / 12);
      yy        := yy + iAnos;
      iCantidad := iCantidad - Trunc(iAnos * 12);
    end;

    mm := mm + iCantidad;

    if mm > 12 then
    begin
      yy := yy + 1;
      mm := mm - 12;
    end;

    // ggarcia 01-07-2013
    if dia = ultimo_dia_mes(mes,ano) then
       dd := ultimo_dia_mes(mm,yy);
    //fin

    case mm of
    2               :if dd > 28 then dFecha_Output := encodedate(yy,03,01) - 1
                                else dFecha_Output := encodedate(yy,mm,dd);

    4,6,9,11        :if dd = 31 then dFecha_Output := encodedate(yy,mm,30)
                                else dFecha_Output := encodedate(yy,mm,dd);
    else   dFecha_Output := encodedate(yy,mm,dd);
    end;{case}

  end;{mes}
end;{procedure}

procedure Fechas_Tramificacion(sCodigo_Tramifica: String;
                               dFecha_Cierre    : TDateTime;
                          var  aFechas_Tramos   : TFechas_Tramos;
                          var  iNro_Tramos      : Integer);
var
i                : Integer;
dFecha_wss       : TDateTime;
dFecha_fin_tramo : TDateTime;
sUnidad          : String;
iCantidad        : Integer;
begin
  {debemos obtener el detalle de la tramificacion }
  iNro_Tramos := 0;
  dFecha_wss  := dFecha_Cierre;
  with Dm_Comun_Gestion_F.Qry_Varios do
  begin
    Sql.Clear;
    Sql.Add('Select * from qs_fin_det_tramos '
           +' where codigo_tramifica = :codigo_tramifica '
           +' order by item_orden '
            );
    ParamByName('codigo_tramifica').AsString    := sCodigo_Tramifica;
    Open;
    if RecordCount <> 0 then
    begin
      iNro_Tramos := RecordCount;
      i := 1;
      while NOT EOF do
      begin
        sUnidad   := FieldByName('Unidad_medida').AsString;
        iCantidad := FieldByName('Nro_de_Veces').AsInteger;
        Fecha_Fin_Tramo(dFecha_wss ,sUnidad ,iCantidad ,dFecha_fin_tramo);//fecha fin de tramo
        aFechas_Tramos[i]:= dFecha_fin_tramo;
        dFecha_wss       := dFecha_fin_tramo;
        inc(i);
        Next;
      end;
    end;
    Close;
  end;{with}
end;

procedure Fechas_Tramificacion_Gestion(sCodigo_Tramifica: String;
                               dFecha_Cierre    : TDateTime;
                          var  aFechas_TramosI  : TFechas_Tramos;
                          var  aTipo_TramosI    : TTipo_Tramos;
                          var  aFechas_TramosF  : TFechas_Tramos;
                          var  aTipo_TramosF    : TTipo_Tramos;
                          var  iNro_Tramos      : Integer);
var
i                : Integer;
dFecha_ini_tramo : TDateTime;
dFecha_fin_tramo : TDateTime;
dFecha_ini_calc  : TDateTime;
sUnidad          : String;
iCantidad        : Integer;
stipo_ini        : String;
stipo_fin        : String;
Reg_Fechas       : TRegistro_Fechas;
dFecha_Calculo   : TDateTime;
sModulo_Err      : String;
sString_Err      : String;
Result           : Boolean;
begin
  {debemos obtener el detalle de la tramificacion }
  iNro_Tramos := 0;
  dFecha_ini_tramo := dFecha_Cierre;
  dFecha_ini_calc  := dFecha_Cierre;
  with Dm_Comun_Gestion_F.Qry_Varios do
  begin
    Sql.Clear;
    Sql.Add('Select * from qs_fin_det_tramos '
           +' where codigo_tramifica = :codigo_tramifica '
           +' order by item_orden '
            );
    ParamByName('codigo_tramifica').AsString    := sCodigo_Tramifica;
    Open;
    if RecordCount <> 0 then
    begin
      iNro_Tramos := RecordCount;
      i := 1;
      while NOT EOF do
      begin
        sUnidad   := FieldByName('Unidad_medida').AsString;
        iCantidad := FieldByName('Nro_de_Veces').AsInteger;
        stipo_ini := FieldByName('Tipo_Tramo_ini').AsString;
        stipo_fin := FieldByName('Tipo_Tramo_fin').AsString;

        Fecha_Fin_Tramo(dFecha_ini_calc ,sUnidad ,iCantidad ,dFecha_fin_tramo);//fecha fin de tramo

        Reg_Fechas.Fecha_Calculo := dFecha_fin_tramo;
        Tratamiento_Fecha(FieldByName('Tratam_fin').AsString
                         ,Reg_Fechas
                         ,dFecha_Calculo
                         ,sModulo_Err
                         ,sString_Err
                         ,Result);
        if Result then
           dFecha_fin_tramo := dFecha_Calculo;

        if stipo_ini = '[' then
           aFechas_TramosI[i]:= dFecha_ini_tramo
        else
           aFechas_TramosI[i]:= dFecha_ini_tramo-1;
        if stipo_fin = ']' then
           aFechas_TramosF[i]:= dFecha_fin_tramo
        else
           aFechas_TramosF[i]:= dFecha_fin_tramo+1;

        aTipo_TramosI[i]:= FieldByName('Tipo_Tramo_ini').AsString;
        aTipo_TramosF[i]:= FieldByName('Tipo_Tramo_fin').AsString;

        inc(i);
        Next;

        if trim(FieldByName('Tratam_ini').AsString) <> '' then
        begin
           Reg_Fechas.Fecha_Calculo := dFecha_fin_tramo;
           Tratamiento_Fecha(FieldByName('Tratam_ini').AsString
                            ,Reg_Fechas
                            ,dFecha_Calculo
                            ,sModulo_Err
                            ,sString_Err
                            ,Result);
           if Result then
           begin
              dFecha_ini_tramo := dFecha_Calculo;
              dFecha_ini_calc  := dFecha_Calculo;
           end;
        end
        else
        begin
           dFecha_ini_tramo := dFecha_fin_tramo+1;
           dFecha_ini_calc  := dFecha_fin_tramo;
        end;

      end;
    end;
    Close;
  end;{with}
end;

//Procedure Borrar_Tabla_Tmp_Prdox(sNombre_Tabla:String; var TTabla : TwwTable);
//var
// MyStringList : TStringList;
// sPath        : String;
// i            : Integer;
//begin
//  try
//    MyStringList := TStringList.Create;
//    Session.GetAliasParams('Alias_Paradox',MyStringList);
//    for i :=0  to MyStringList.count -1 do
//    begin
//      if (copy(MyStringList[i],1,4) = 'PATH') then
//      begin
//        sPath := copy(MyStringList[i],6,(length(MyStringList[i]) - 1));
//        Break;
//      end;
//    end;
//  finally
//       MyStringList.Free;
//  end;

//  if FileExists(sPath+'\'+sNombre_Tabla+'.db') then           // Verifica si existe
//     begin
//       TTabla.Close;
//       try
//         TTabla.DeleteTable;
//       except
//       end;
//     end;

//end;

procedure Desplegar_Arbol(sObjeto : String;
                          fNodo   : Double;
                          fNivel  : Double;
                      var sLista  : TStringList);
var
  Qry : TFDQuery;
begin
  Qry := TFDQuery.Create(Dm_Comun_Gestion_F);
  Qry.Connection     := dmBaseDatos.Conexion_BaseDatos;
  Qry.ConnectionName := 'PMSSERVER';
  Qry.Name := 'Name'+floattostr(fNodo);
  With Dm_Comun_Gestion_F,Qry do
    begin
      {Obtener los hijos del nodo}
      Sql.Clear;
      Sql.Add('Select * from qs_sys_est_cla     '
             +' Where qs_nodo        = :nodo    '
             +'   and codigo_Objeto  = :objeto  '
             +' Order by Orden '
             );
      ParamByName('nodo').AsFloat     := fNodo;
      ParamByName('objeto').AsString  := sObjeto;
      Prepare;
      Open;
      While NOT EOF do
        begin
          if FieldByName('Nivel').AsFloat <= fNivel then
             sLista.Add(FormatFloat('000',FieldByName('qs_nodo').AsFloat)
                       +FormatFloat('000',FieldByName('nivel').AsFloat)
                       +FieldByName('Descripcion_Nodo').AsString);
          Desplegar_Arbol(sObjeto,FieldByName('Nodo').AsFloat,fNivel,sLista); //hijos
          Next;
        end;
      Close;
      Unprepare;
      Free;
    end;
end;

procedure Desplegar_Arbol_Nodo(sObjeto : String;
                               fNodo   : Double;
                               fNivel  : Double;
                           var sLista  : TStringList);
var
  Qry : TFDQuery;
begin
  Qry := TFDQuery.Create(Dm_Comun_Gestion_F);
  Qry.Connection     := dmBaseDatos.Conexion_BaseDatos;
  Qry.ConnectionName := 'PMSSERVER';
  Qry.Name := 'Name'+floattostr(fNodo);
  With Dm_Comun_Gestion_F,Qry do
    begin
      {Obtener los hijos del nodo}
      Sql.Clear;
      Sql.Add('Select * from qs_sys_est_cla     '
             +' Where qs_nodo        = :nodo    '
             +'   and codigo_Objeto  = :objeto  '
             +' Order by Orden '
             );
      ParamByName('nodo').AsFloat     := fNodo;
      ParamByName('objeto').AsString  := sObjeto;
      Prepare;
      Open;
      While NOT EOF do
        begin
          if FieldByName('Nivel').AsFloat <= fNivel then
             sLista.Add(FormatFloat('000',FieldByName('nodo').AsFloat)
                       +FormatFloat('000',FieldByName('nivel').AsFloat)
                       +FieldByName('Descripcion_Nodo').AsString);
          Desplegar_Arbol_Nodo(sObjeto,FieldByName('Nodo').AsFloat,fNivel,sLista); //hijos
          Next;
        end;
      Close;
      Unprepare;
      Free;
    end;
end;

function dia_habil_anterior(sCodigo_Division : String;
                            dFecha           : TDatetime) : TDatetime;
var
  dia_habil : Boolean;
begin
   dia_habil := False;
   dFecha := dFecha - 1;
   WHILE NOT dia_habil do
     begin
       if NOT (DayOfWeek(dFecha) in [1,7]) then
          if NOT Feriado(sCodigo_Division, dFecha) then
             dia_habil := True
          else
             dFecha := dFecha - 1
       else
          dFecha := dFecha - 1;
     end;
   Result := dFecha;
end;

function dia_habil_siguiente(sCodigo_Division : String;
                             dFecha           : TDatetime) : TDatetime;
var
  dia_habil : Boolean;
begin
   dia_habil := False;
   WHILE NOT dia_habil do
     begin
       if NOT (DayOfWeek(dFecha) in [1,7]) then
          if NOT Feriado(sCodigo_Division,
                         dFecha) then
             dia_habil := True
          else
             dFecha := dFecha + 1
       else
          dFecha := dFecha + 1;
     end;
   Result := dFecha;
end;

procedure Grabar_Indice(sIndice : String;
                        dFecha  : TDateTime;
                        fValor  : Double);
var
 smoneda : String;
begin
  {debemos Eliminar el valor }
   with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Sql.Clear;
       Sql.Add('Delete from qs_sys_val_cambio       '
              +' where cod_Moneda     = :cod_moneda '
              +'   and Tipo_de_Paridad= :tipo       '
              +'   and Moneda_Paridad = :Moneda_paridad '
              +'   and fecha_paridad  = :fecha '
               );
       ParamByName('cod_moneda').AsString     := sIndice;
       ParamByName('tipo').AsString           := 'BC';
       //ParamByName('Moneda_paridad').AsString := 'CLP'; 23/12/2004 AdolfoB, se dejo la moneda del Pais para que fuera general
       smoneda := moneda_nacional;
       ParamByName('Moneda_paridad').AsString := smoneda;
       ParamByName('fecha').AsDateTime        := dFecha;
       Prepare;
       ExecSql;
       close;
       Unprepare;

       Sql.Clear;
       Sql.Add('Insert into qs_sys_val_cambio  '
              +' ( Cod_Moneda      '
              +'  ,Tipo_de_Paridad '
              +'  ,Moneda_Paridad  '
              +'  ,fecha_paridad   '
              +'  ,Valor_Moneda    '
              +' ) values ( '
              +'   :Cod_Moneda      '
              +'  ,:Tipo_de_Paridad '
              +'  ,:Moneda_Paridad  '
              +'  ,:fecha_paridad   '
              +'  ,:Valor_Moneda   )'
               );
       ParamByName('cod_moneda').AsString     := sIndice;
       ParamByName('Tipo_de_Paridad').AsString:= 'BC';
       //ParamByName('Moneda_paridad').AsString := 'CLP'; 23/12/2004 AdolfoB, se dejo la moneda del Pais para que fuera general
       ParamByName('Moneda_paridad').AsString := smoneda;
       ParamByName('fecha_paridad').AsDateTime:= dFecha;
       ParamByName('Valor_Moneda').AsFloat    := fValor;
       Prepare;
       ExecSql;
       Close;
       Unprepare;
    end;
end;

procedure Total_Inversiones(sEmpresa       : String;
                            sCartera       : String;
                            bConsolida     : Boolean;
                            fHandle        : Double;
                            sMoneda_Cartera: String;
                            dFecha_Cierre  : TDateTime;
                            sTipo_Inversion: String; // 'TT' = Todo, 'RF' = Renta Fija, 'RV' = Renta Variable, 'BR' = Bienes Raices
                            sTipo          : String; // 'C' = Contable, 'M' = Mercado
                        var fValor_Cartera : Double
                            );
var
 fAux_Valor   : Double;
 Modulo_Error : String;
 String_Error : String;
 Result       : Boolean;
 pchar_modulo : Array[0..250] of char;
 pchar_error  : Array[0..250] of char;

begin
  fValor_Cartera := 1;
  with Dm_Comun_Gestion_F.Qry_Varios do
  begin
    Sql.Clear;
    if (sTipo_Inversion = 'TT') or (sTipo_Inversion = 'RF') then
    begin
       { RENTA FIJA}
       if sTipo = 'C' then
         Sql.Add('Select '''+Format('%-15s',[sMoneda_Cartera])+''' as Moneda '
                +'      , sum(valor_pte_mc_cpa) as Valor ')
       else
         Sql.Add('Select '''+Format('%-15s',[sMoneda_Cartera])+''' as Moneda '
                +'      , sum(valor_pte_mc_Mdo) as Valor ');
       Sql.Add(' from qs_res_mercado  '
              +'where fecha_cierre  = :fecha_cierre '
              +'   AND TRANSACCION = ''C'' ');
       if bConsolida then
         Sql.Add('   and cartera in (select b.cartera from QS_SYS_PARAM_EMPRESA b '
                +'                    where b.pid     = :pid '
                +'                      and b.empresa = :empresa )')
       else
         Sql.Add('   and cartera  = :Cartera ');

       Sql.Add('  and empresa       = :empresa '  );
       //Sql.Add('  AND INSTRUMENTO not in (select cod_instrumento from qs_fin_instrum  where tipo_instrumento = ''RV'') ');
    end;
    if (sTipo_Inversion = 'TT') then
       Sql.Add(' union ');
    if (sTipo_Inversion = 'TT') or (sTipo_Inversion = 'RV') then
    begin
       { RENTA VARIABLE }
       if sTipo = 'C' then
          Sql.Add('Select '''+sMoneda_Cartera+''' as Moneda '
                 +'     , sum(costo_corregido) as Valor ')
       else
          Sql.Add('Select '''+sMoneda_Cartera+''' as Moneda '
                 +'     , sum(valor_Mercado) as Valor ');
       Sql.Add(' from qs_res_valoriza_rv  '
              +' where fecha_cierre  = :fecha_cierre ');
       if bConsolida then
          Sql.Add('   and cartera in (select b.cartera from QS_SYS_PARAM_EMPRESA b '
                 +'                    where b.pid     = :pid '
                 +'                      and b.empresa = :empresa )')
       else
          Sql.Add('   and cartera  = :Cartera ');
       Sql.Add('  and empresa       = :empresa ');
    end;
    if (sTipo_Inversion = 'TT') then
       Sql.Add(' union ');
    if (sTipo_Inversion = 'TT') or (sTipo_Inversion = 'BR') then
    begin
       { BIENES RAICES }
       Sql.Add('Select a.Moneda As Moneda       '
              +'      ,sum(a.saldo) as Valor    '
              +'  from qs_mcub_braiz_valo a     '
              +'      ,qs_mcub_braiz b          '
              +' where a.codigo_entidad = b.codigo_entidad  '
              +'   and a.fecha_cierre  = :fecha_cierre      ');
       if bConsolida then
          Sql.Add('   and b.cartera in (select c.cartera from QS_SYS_PARAM_EMPRESA c '
                 +'                    where c.pid     = :pid '
                 +'                      and c.empresa = :empresa )')
       else
          Sql.Add('   and b.cartera  = :Cartera ');

       Sql.Add('   and b.empresa       = :empresa    ');
       Sql.Add(' Group by a.Moneda ');
    end;
    ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
    if bConsolida then
       ParamByName('pid').AsFloat      := fHandle
    else
       ParamByName('cartera').AsString := sCartera;
    ParamByName('empresa').AsString    := sEmpresa;
    Prepare;
    Open;
    fValor_Cartera := 0;
    while NOT EOF do
    begin
      { Recordar que debemos hacer conversiones en caso de monedas distintas}
      if FieldByName('Moneda').AsString <> sMoneda_Cartera then
      begin
         conversion_unidad_mon(trim(FieldByName('Moneda').AsString)
                              ,sMoneda_Cartera
                              ,'BC'
                              ,dFecha_Cierre
                              ,FieldByName('Valor').AsFloat
                              ,fAux_Valor
                              ,Modulo_Error
                              ,String_Error
                              ,Result);
         if Not Result then
         begin
           StrPcopy(pchar_modulo ,Modulo_Error);
           StrPcopy(pchar_Error  ,String_Error);
           Application.MessageBox(pchar_Error ,pchar_Modulo ,mb_Ok);
           exit;
         end;
      end
      else
        fAux_Valor := FieldByName('Valor').AsFloat;

      fValor_Cartera := fValor_Cartera + fAux_Valor;
      Next;
    End;{while}
    Close;
    UnPrepare;
  End;
end;{procedure}


procedure Descripcion_Codigo(sCod_General: String;
                             sCod_Detalle: String;
                        var  Descripcion : String);
begin
  {debemos obtener el codigo }
   with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Sql.Clear;
       Sql.Add('Select * from qs_sys_cod_det '
              +' where cod_general = :cod_general '
              +'   and cod_detail  = :cod_detalle '
               );
       ParamByName('cod_general').AsString    := sCod_General;
       ParamByName('cod_detalle').AsString    := sCod_Detalle;
       Prepare;
       Open;
       if RecordCount <> 0 then
          Descripcion  := FieldByName('DESC_DETAIL').AsString
       else
          Descripcion   := '***';
       Close;
       Unprepare;
    end;
end;

procedure Calculo_Stock_Nemo_Rv(sTransaccion  : String;
                                sNemotecnico  : String;
                                sCartera      : String;
                                sEmpresa      : String;
                                dFecha_Cierre : TDateTime;
                            var fStock        : Double
                                );
var
  fCompras,fVentas     : Double;
  sNemotecnico_Nuevo   : String;
  bExiste_Equivalencia : Boolean;
  sImplicancia_Pacto   : String;
begin
  if Transaccion_Implica(sTransaccion,'DIVISA') then
  begin
    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
    // El nemotecnico de la OMD debe actualizarse al equivalente vigente lo anterior porque podria tratarse de una anulación
    // DC & FI 05-09-2012
    Busca_Equivalencia_Mem( 'RV',
                            'NEMOTEC',
                             sNemotecnico,
                             dFecha_Cierre,
                             sNemotecnico,
                             bExiste_Equivalencia
                           );

      sql.Clear;
      sql.Add(' SELECT  a.Nemotecnico'
             +'        ,sum(a.Valor_Nominal) as compras '
             +' from qs_tra_omd_det_rf a  '
             +'     ,qs_tra_omd e '
             +'where a.folio_interno = e.Folio_interno  '
             +'  and a.transaccion   = e.transaccion    '
             +'  and a.empresa       = e.empresa  '
             +'  and e.Folio_Preimpreso <> '' '' '
             +'  and a.transaccion      = :Compras       '
             +'  and a.tipo_instrum = ''R'''
             +'  and e.fecha_operacion <=    :fecha_cierre  '
             +'  and a.empresa          = :Empresa     '
             +'  and a.Cartera          = :Cartera'
             +'  and a.folio_interno not in (Select b.folio '
             +'                                 from qs_ctr_anulacion b '
             +'                                where b.folio       = a.folio_interno '
             +'                                  and b.empresa     = a.empresa '
             +'                                  and b.transaccion = a.transaccion) '
             +' GROUP BY a.Nemotecnico'
             );
      if Transaccion_Implica(sTransaccion,'DIVISA') then
         ParamByName('Compras').AsString        := 'CDI'
      else
         ParamByName('Compras').AsString        := 'CRV';
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      Open;

      fCompras := 0;
      While Not Eof do
      begin
          sNemotecnico_Nuevo := Fieldbyname('Nemotecnico').asString;
          Busca_Equivalencia_Mem( 'RV',
                                  'NEMOTEC',
                                   FieldByName('Nemotecnico').AsString,
                                   dFecha_Cierre,
                                   sNemotecnico_Nuevo,
                                   bExiste_Equivalencia
                                 );
         if (     sNemotecnico_Nuevo = sNemotecnico )  and
            ( Not FieldByName('Compras').IsNull     ) then
            fCompras := fCompras +  FieldByName('Compras').asFloat;

         Next;
      end;
      Close;

      sql.Clear;
      sql.Add(' SELECT  a.Nemotecnico'
             +'        ,sum(a.Valor_Nominal) as Ventas      '
             +' from qs_tra_omd_det_rf a  '
             +'     ,qs_tra_omd e '
             +'where a.folio_interno = e.Folio_interno  '
             +'  and a.transaccion   = e.transaccion    '
             +'  and a.empresa       = e.empresa  '
             +'  and e.Folio_Preimpreso <> '' '' '
             +'  and a.transaccion      = :Ventas       '
             +'  and a.tipo_instrum = ''R'''
             +'  and e.fecha_operacion <= :fecha_cierre  '
             +'  and a.empresa          = :Empresa     '
             +'  and a.Cartera          = :Cartera'
             +'  and a.folio_interno not in (Select b.folio '
             +'                                 from qs_ctr_anulacion b '
             +'                                where b.folio       = a.folio_interno '
             +'                                  and b.empresa     = a.empresa '
             +'                                  and b.transaccion = a.transaccion) '
             +' GROUP BY a.Nemotecnico'
             );
      if Transaccion_Implica(sTransaccion,'DIVISA') then
         ParamByName('Ventas').AsString         := 'VDI'
      else
         ParamByName('Ventas').AsString         := 'VRV';
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      Open;

      fVentas := 0;
      While Not Eof do
      begin
          sNemotecnico_Nuevo := Fieldbyname('Nemotecnico').asString;
          Busca_Equivalencia_Mem( 'RV',
                                  'NEMOTEC',
                                   FieldByName('Nemotecnico').AsString,
                                   dFecha_Cierre,
                                   sNemotecnico_Nuevo,
                                   bExiste_Equivalencia
                                 );
         if (     sNemotecnico_Nuevo = sNemotecnico )  and
            ( Not FieldByName('Ventas').IsNull     ) then
            fVentas := fVentas +  FieldByName('Ventas').asFloat;

         Next;
      end;
      Close;
    end;
    fStock := 0;
    fstock := fCompras - fVentas;
  end
  else
  begin
    sImplicancia_Pacto    := LLena_String_Implicancia('PACTO');
    sNemotecnico := String_equiv(dFecha_Cierre,''''+sNemotecnico+'''');
    sNemotecnico := '('+sNemotecnico+')';

    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
      Close;
      sql.Clear;
      sql.Add(' SELECT a.transaccion'
             +'       ,a.Valor_Nominal '
             +'       ,e.fecha_operacion '
             +'       ,e.fecha_hora '
             +'       ,e.folio_interno '
             +'   from qs_tra_omd_det_rf a  '
             +'       ,qs_tra_omd e '
             +'  where a.folio_interno    = e.Folio_interno '
             +'    and a.transaccion      = e.transaccion  '
             +'    and a.empresa          = e.empresa  '
             +'    and e.Folio_Preimpreso <> '' '' '
             +'    and a.tipo_instrum     = ''R'''
             +'    and e.fecha_operacion <= :fecha_cierre '
             +'    and a.empresa          = :Empresa '
             +'    and a.Cartera          = :Cartera'
             +'    and a.nemotecnico IN '+sNemotecnico
             +'    and a.folio_interno not in (Select b.folio_interno '
             +'                                  from qs_tra_omd b '
             +'                                 where b.transaccion   IN '+sImplicancia_Pacto
             +'                                   and b.fecha_vcto_pacto <= :fecha_cierre '
             +'                                   and b.folio_interno = a.folio_interno '
             +'                                   and b.transaccion   = a.transaccion '
             +'                                   and b.empresa       = a.empresa) '
             +'    and a.folio_interno not in (Select b.folio '
             +'                                  from qs_ctr_anulacion b '
             +'                                 where b.folio       = a.folio_interno '
             +'                                   and b.empresa     = a.empresa '
             +'                                   and b.transaccion = a.transaccion) ' );

      // D.C. & F.I. 24-05-2018
      // El orden debe ser por Fecha_operacion y dentro del día por fecha_hora
      // No puede ser por folio_interno ya que existen compañías que tienen foliación
      // por transacción.

      if (Transaccion_implica_Mem('FECHAHORA','RV')) then
      begin
        if sDriver = 'ORACLE' then
           SQL.ADD('  ORDER BY e.fecha_operacion,e.Fecha_hora, TO_NUMBER(e.folio_interno) ')
        else
           SQL.ADD('  ORDER BY e.fecha_operacion,e.Fecha_Hora, CAST(e.folio_interno As Float)  ');
      end
      else
      begin
        if sDriver = 'ORACLE' then
           SQL.ADD('  ORDER BY e.fecha_operacion, TO_NUMBER(e.folio_interno) ')
        else
           SQL.ADD('  ORDER BY e.fecha_operacion, CAST(e.folio_interno As Float)  ');
      end;

      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      Open;

      fstock := 0;
      While Not Dm_Comun_Gestion_F.Qry_Varios.Eof do
      begin
        if Transaccion_Implica(FieldByName('transaccion').asString,'COMPRA') then
           fstock := fstock +  FieldByName('Valor_Nominal').asFloat
        else
           fstock := fstock -  FieldByName('Valor_Nominal').asFloat;

        if ABS(fstock) < 0.00009 then
           fstock := 0;

         Dm_Comun_Gestion_F.Qry_Varios.Next;
      end;
      Close;
    end;
  end;
//////DC
end;{fin}

function String_equiv(dfecha :TdateTime; sString : String): String;
begin
  Result :=  sString;
  Dm_Comun_Gestion_F.Qry_Varios.Close;
  Dm_Comun_Gestion_F.Qry_Varios.sql.Clear;
  Dm_Comun_Gestion_F.Qry_Varios.sql.Add(' SELECT a.Codigo_Sistema   '
         +'       ,a.Codigo_Equiv     '
         +'       ,a.Fecha_Desde      '
         +'   FROM QS_SYS_EQUIVALEN a '
         +'  WHERE a.Codigo_Objeto   = ''NEMOTEC'''
         +'    AND a.Codigo_Proceso  = ''RV'''
         +'    AND A.Codigo_Equiv IN ('+sString+') '
         +'    AND A.Codigo_Sistema NOT in ('+sString+')'
         +'    AND a.Fecha_Desde    <= :fecha '
         +'    AND (a.Fecha_Hasta   >= :fecha OR a.Fecha_Hasta IS NULL) '
         +'    AND a.Fecha_desde IN ( SELECT MAX(b.Fecha_desde) '
                                   +'   FROM QS_SYS_EQUIVALEN b '
                                   +'  WHERE a.Codigo_Objeto  = b.Codigo_Objeto  '
                                   +'    AND a.Codigo_Proceso = b.Codigo_Proceso '
                                   +'    AND a.Codigo_Sistema = b.Codigo_Sistema '
                                   +'    AND b.Fecha_Desde    <= :fecha '
                                   +'    AND (b.Fecha_Hasta   >= :fecha OR b.Fecha_Hasta IS NULL) )');

  Dm_Comun_Gestion_F.Qry_Varios.ParamByName('fecha').AsDateTime       := dfecha;
  Dm_Comun_Gestion_F.Qry_Varios.Open;
  while Not Dm_Comun_Gestion_F.Qry_Varios.Eof do
  begin
     Result :=  Result+', '''+ Dm_Comun_Gestion_F.Qry_Varios.FieldByName('Codigo_Sistema').asString+'''';
     Dm_Comun_Gestion_F.Qry_Varios.Next;
  end;
  if Dm_Comun_Gestion_F.Qry_Varios.recordcount > 0 then
  begin
     Dm_Comun_Gestion_F.Qry_Varios.Close;
     Result := String_equiv(dfecha,Result);
  end
  else
  Dm_Comun_Gestion_F.Qry_Varios.Close;
end;


function Calcula_dias(mesmenor,mestope,ano:word; base:boolean):integer;
 var    { Esta funcion calcula los dias entre los meses de un ano}
     i,resto  :integer;
 begin
   {determinacion de áno bisiesto}
     resto := ano div 4;
     if (ano * 4) = (resto * ano) then
        dias_mes[2]:=29;
     mesmenor    := mesmenor + 1;
     calcula_dias:=0;
     i:=0;
     while mesmenor <= mestope do
     begin
       if base then
         i := i + dias_mes[mesmenor]
      else
         i := i + 30;
      mesmenor:=mesmenor + 1;
     end;
     calcula_dias:=i;
end;{funcion}


procedure Diferencia_Dias(dFecha_menor: TDateTime;
                       dFecha_Mayor: TDateTime;
                       iDias_ano   : Integer;
                   var fDias       : Double);
var
   ano1,mes1,dia1 :word;
   ano2,mes2,dia2 :word;
   ano_auxiliar   :word;

begin
 { si la variable "Base" es 0 : dias exactos
                           1 : dias base 360
                           2 : dias base 365}

     decodedate(dfecha_menor,ano1,mes1,dia1);
     decodedate(dfecha_mayor,ano2,mes2,dia2);
     fDias:=0;
     {Calculo de días exactos}
     case  iDias_ano of
     0 : fDias:=dfecha_mayor - dfecha_menor;
     1 : begin
         {Calculo de los dias por los anos}
          ano_auxiliar:=ano1;
          while ano_auxiliar <= ano2 do
          begin
              fDias :=fDias + 360;
              ano_auxiliar :=ano_auxiliar + 1;
          end;
          {Calculo de dias en base 360}

          {Se restan los dias transcurridos del ano hasta la fecha menor}
          if (dias_mes[mes1] <> dia1) or (mes1 = 2) then
             fDias:=fDias -(calcula_dias(0,mes1,ano1,false) - (30 - dia1))
          else
             fDias:=fDias - calcula_dias(0,mes1,ano1,false);

         {Se restan los dias que faltan para completar el ano de la fecha mayor}
          if (dias_mes[mes2] <> dia2) or (mes2 = 2) then
            fDias:=fDias - (calcula_dias(mes2-1,12,ano2,false) - dia2)
          else
            fDias:=fDias - (calcula_dias(mes2-1,12,ano2,false) - 30);
        end;
    2  :begin
        {Calculo de los dias por los anos}
          ano_auxiliar:=ano1;
          while ano_auxiliar <= ano2 do
          begin
              fDias :=fDias + 365;
              ano_auxiliar :=ano_auxiliar + 1;
          end;
       {Calculo de días en base 365}
       {Se restan los dias transcurridos del ano hasta la fecha menor}
       fDias:=fDias -(calcula_dias(0,mes1,ano1,true) - (dias_mes[mes1] - dia1));
       {Se restan los dias que faltan para completar el ano de la fecha mayor}
       fDias:=fDias - (calcula_dias(mes2-1,12,ano2,true) - dia2);
       end;
    end; {case}
end;{procedure calculo de dias}

procedure leer_valor_Tasa(sCodigo_Tasa : String;
                          dfecha       : TDatetime;
                      var fValor       : Double;
                      var Result       : Boolean);
var
 sTipo_Moneda,
 sTipo_Unidad,
 sUnidad,
 sTipo_Variacion : String;
 aux_pchar : Array[0..250] of Char;
begin
  Result := True;
  WITH Dm_Comun_Gestion_F.Qry_Varios do
    begin
      SQL.Clear;
      SQL.Add('SELECT a.Tipo_moneda As Tipo_Moneda'
             +'      ,b.Tipo_Unidad As Tipo_Unidad'
             +'      ,b.Unidad      As Unidad'
             +'      ,b.Tipo_Variacion As Tipo_Variacion'
             +'  FROM QS_SYS_MONEDAS a'
             +'      ,QS_SYS_PERIODO b'
             +' WHERE a.Cod_Moneda         = :Codigo_Tasa'
             +'   AND a.Tipo_Uni_Variacion = b.Tipo_Unidad'
             +'   AND a.Unidad_Medida_Mon  = b.Unidad'
             );
      Prepare;
      ParamByName('Codigo_Tasa').AsString := sCodigo_Tasa;
      Open;

      sTipo_Moneda    := FieldByName('Tipo_Moneda').AsString;
      sTipo_Unidad    := FieldByName('Tipo_Unidad').AsString;
      sUnidad         := FieldByName('Unidad').AsString;
      sTipo_Variacion := FieldByName('Tipo_Variacion').AsString;
      Close;
      UnPrepare;
    end;

    if (sTipo_Moneda <> 'T') then
       begin
         fValor := 0;
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
             strpcopy(aux_pchar ,'Error en definicion de periodo para '+sCodigo_Tasa
                     +#10'con fecha: '+datetostr(dfecha_Periodo));

             Application.MessageBox(aux_pchar,'Valor Paridad',mb_OK);

            Result := False;
            exit;
          end;
       end
    else
       dfecha_Periodo := dfecha;

    {Busco Paridad}

    with Dm_Comun_Gestion_F.Qry_Varios do
      begin
        SQL.Clear;
        SQL.Add('SELECT Valor_Moneda As Valor_Moneda '
               +'  FROM QS_SYS_VAL_CAMBIO            '
               +' WHERE Cod_moneda      = :cod_moneda   '
               +'   AND Tipo_De_Paridad = :Tipo_Paridad '
               +'   AND Fecha_Paridad   = :pfecha       '
               );
        ParamByName('cod_moneda').AsString   := sCodigo_Tasa;
        ParamByName('Tipo_Paridad').AsString := 'BC';
        ParamByName('pfecha').AsDateTime     := dfecha_Periodo;
        Prepare;
        Open;
        if (FieldByName('Valor_Moneda').IsNull) or
           (FieldByName('Valor_Moneda').Asfloat = 0) then
           begin
             Result := False;
             fValor := 0;
           end
        else
           begin
             fValor := FieldByName('Valor_Moneda').AsFloat;
           end;
        Close;
        UnPrepare;
      end;
end;

function Busca_Precio_Rv(sNemotecnico : String;
                         sTipo_Precio : String;
                         dFecha_Precio: TDateTime;
                     var Resultado    : Boolean): Double;
begin
   Resultado       := False;
   Busca_Precio_Rv := 0;
   with Dm_Comun_Gestion_F.Qry_Varios do
   begin
     SQL.Clear;
     SQL.Add('SELECT * FROM QS_FIN_PRECIOS '
            +' WHERE  Fecha_Precio = :fecha_cierre '
            +'   and  Nemotecnico  = :Nemotecnico '
            +'   and  Tipo_Precio  = :Tipo_Precio '
            );
     ParamByName('Fecha_Cierre').AsDateTime   := dFecha_Precio;
     ParamByName('Nemotecnico').AsString      := sNemotecnico;
     ParamByName('Tipo_Precio').AsString      := sTipo_Precio;
     Open;
     if RecordCount <> 0 then
     begin
        Busca_Precio_Rv := FieldByName('Precio').AsFloat;
        Resultado       := True;
     end;
     Close;
   end;
end;

function Busca_Nivel_Rv(sNemotecnico : String;
                        sTipo_Precio : String;
                        dFecha_Precio: TDateTime;
                    var Resultado    : Boolean): String;
begin
   Resultado      := False;
   Busca_Nivel_Rv := '';
   with Dm_Comun_Gestion_F.Qry_Varios do
   begin
     SQL.Clear;
     SQL.Add('SELECT * FROM QS_FIN_PRECIOS '
            +' WHERE  Fecha_Precio = :fecha_cierre '
            +'   and  Nemotecnico  = :Nemotecnico '
            +'   and  Tipo_Precio  = :Tipo_Precio '
            );
     ParamByName('Fecha_Cierre').AsDateTime   := dFecha_Precio;
     ParamByName('Nemotecnico').AsString      := sNemotecnico;
     ParamByName('Tipo_Precio').AsString      := sTipo_Precio;
     Open;
     if RecordCount <> 0 then
     begin
        Busca_Nivel_Rv := FieldByName('Tipo').AsString;
        Resultado      := True;
     end;
     Close;
   end;
end;

function  Moneda_Consolidacion(sEmpresa : String;
                               fHandle  : Double) : String;
var
   bResult    : Boolean;
   aux_string : String;
   sMoneda    : String;
Begin
  Result := '';
  With Dm_Comun_Gestion_F,Qry_Varios do
  begin
    Sql.Clear;
    Sql.Add('select cartera from QS_SYS_PARAM_EMPRESA b '
           +' where b.pid     = '+floattostr(fHandle)
           +'   and b.empresa = :empresa ' 
           +'   and (b.cartera is not null and b.cartera <> '''') '
           );
    //ParamByName('pid').AsString     := floattostr(fHandle);
    ParamByName('Empresa').AsString := sEmpresa;
    Prepare;
    Open;
    Leer_Cartera(sEmpresa
                ,FieldByName('cartera').AsString
                ,aux_string
                ,aux_string
                ,sMoneda
                ,aux_string
                ,bResult);
    Result := sMoneda;
    Close;
    Unprepare;
  end;
end;

function Chk_Consistencia_Rv(sNemotecnico : String;
                             sCartera     : String;
                             sEmpresa     : String;
                             dFecha_stk   : TDateTime ): Double;
var
  fCompras, fVentas : Double;
  dFecha_Hora_Cpa   : TDateTime;
  dFecha_Next_Cpa   : TDateTime;
  fVentas_between   : Double;
begin
   Result    := 0;
   fCompras  := 0; //compras desde la 1ra compra posterior al stock
   fVentas   := 0; //ventas  desde la 1ra compra posterior al stock
   fVentas_between := 0; //ventas entre el stock y la 1ra compra posterior al stock
   with Dm_Comun_Gestion_F.Qry_Varios do
   begin
     { Determinar la proxima compra de este nemotecnico}
     Close;
     Sql.Clear;
     Sql.add('Select A.FECHA_OPERACION as fecha_compra '
            +'      ,min(a.fecha_hora) as fecha_hora_compra '
            +'  from qs_tra_omd a  '
            +'      ,qs_tra_omd_det_rf b '
            +' where a.folio_interno = b.folio_interno '
            +'   and a.transaccion   = b.transaccion   '
            +'   and a.cartera       = b.cartera  '
            +'   and a.empresa       = b.empresa '
            +'   and a.transaccion in (SELECT d.Codigo_Transaccion '
            +'                           FROM qs_sys_tran_implic d '
            +'                          WHERE d.Codigo_transaccion = a.transaccion '
            +'                            AND d.implicancia = ''COMPRA'' ) '
            +'   and a.folio_interno not in (Select e.folio '
            +'                                 from qs_ctr_anulacion e '
            +'                                where e.folio       = a.folio_interno '
            +'                                  and e.empresa     = a.empresa '
            +'                                  and e.transaccion = a.transaccion) '
            +'   and a.fecha_operacion > :Fecha_stock '
            +'   and b.nemotecnico = :nemotecnico '
            +'   and a.cartera     = :cartera '
            +'   and a.empresa     = :Empresa '
            +'   and a.fecha_operacion = (Select min(a.fecha_operacion) as fecha_compra '
            +' from qs_tra_omd a '
            +'     ,qs_tra_omd_det_rf b '
            +' where a.folio_interno = b.folio_interno '
            +'   and a.transaccion   = b.transaccion   '
            +'   and a.cartera       = b.cartera       '
            +'   and a.empresa       = b.empresa       '
            +'   and a.transaccion in (SELECT d.Codigo_Transaccion '
            +'                           FROM qs_sys_tran_implic d '
            +'                          WHERE d.Codigo_transaccion = a.transaccion '
            +'                            AND d.implicancia = ''COMPRA'' ) '
            +'   and a.folio_interno not in (Select e.folio '
            +'                                 from qs_ctr_anulacion e '
            +'                                where e.folio       = a.folio_interno '
            +'                                  and e.empresa     = a.empresa '
            +'                                  and e.transaccion = a.transaccion) '
            +'   and a.fecha_operacion > :fecha_stock '
            +'   and b.nemotecnico = :nemotecnico '
            +'   and a.cartera     = :cartera '
            +'   and a.empresa     = :empresa ) '
            +' GROUP BY A.FECHA_OPERACION '
            );

     ParamByName('fecha_stock').AsDateTime:= dFecha_stk;
     ParamByName('Nemotecnico').AsString  := sNemotecnico;
     ParamByName('cartera').AsString      := sCartera;
     ParamByName('empresa').AsString      := sEmpresa;
     Prepare;
     Open;
     if RecordCount <> 0 then
     begin
       dFecha_Next_Cpa := FieldByName('fecha_compra').AsDateTime;
       dFecha_Hora_Cpa := FieldByName('fecha_hora_compra').AsDateTime;
       Close;
       { Determinar las ventas antes de la proxima compra}
       SQL.Clear;
       SQL.Add('Select sum(b.Valor_nominal) as Valor_Ventas '
              +'  from qs_tra_omd a '
              +'      ,qs_tra_omd_det_rf b '
              +' where a.folio_interno = b.folio_interno '
              +'   and a.transaccion   = b.transaccion '
              +'   and a.cartera       = b.cartera '
              +'   and a.empresa       = b.empresa '
              +'   and a.transaccion in (SELECT d.Codigo_Transaccion '
              +'                           FROM qs_sys_tran_implic d '
              +'                          WHERE d.Codigo_transaccion = a.transaccion '
              +'                            AND d.implicancia = :implica ) '
              +'   and a.folio_interno not in (Select e.folio               '
              +'                                 from qs_ctr_anulacion e    '
              +'                                where e.folio       = a.folio_interno '
              +'                                  and e.empresa     = a.empresa  '
              +'                                  and e.transaccion = a.transaccion) '
              +'   and a.fecha_operacion <= :fecha_compra '
              +'   and a.fecha_hora  < :fecha_hora_compra '
              +'   and b.nemotecnico = :nemotecnico '
              +'   and a.cartera     = :cartera '
              +'   and a.empresa     = :empresa '
              );
       ParamByName('Nemotecnico').AsString         := sNemotecnico;
       ParamByName('implica').AsString             := 'VENTA';
       ParamByName('fecha_compra').AsDateTime      := dFecha_Next_Cpa;
       ParamByName('fecha_hora_compra').AsDateTime := dFecha_Hora_Cpa;
       ParamByName('cartera').AsString             := sCartera;
       ParamByName('empresa').AsString             := sEmpresa;
       Prepare;
       Open;
       if RecordCount <> 0 then
          fVentas_between := FieldByName('Valor_Ventas').AsFloat;
       Close;

      {determinar las ventas posteriores a la primera compra }
       SQL.Clear;
       SQL.Add('Select sum(b.Valor_nominal) as Valor_Ventas '
              +'  from qs_tra_omd a '
              +'      ,qs_tra_omd_det_rf b '
              +' where a.folio_interno = b.folio_interno '
              +'   and a.transaccion   = b.transaccion '
              +'   and a.cartera       = b.cartera '
              +'   and a.empresa       = b.empresa '
              +'   and a.transaccion in (SELECT d.Codigo_Transaccion '
              +'                           FROM qs_sys_tran_implic d '
              +'                          WHERE d.Codigo_transaccion = a.transaccion '
              +'                            AND d.implicancia = ''VENTA'' ) '
              +'   and a.folio_interno not in (Select e.folio               '
              +'                                 from qs_ctr_anulacion e    '
              +'                                where e.folio       = a.folio_interno '
              +'                                  and e.empresa     = a.empresa  '
              +'                                  and e.transaccion = a.transaccion) '
              +'   and a.fecha_operacion > :fecha_compra '
              +'   and b.nemotecnico = :nemotecnico '
              +'   and a.cartera     = :cartera '
              +'   and a.empresa     = :empresa '
              );
       ParamByName('Nemotecnico').AsString         := sNemotecnico;
       ParamByName('fecha_compra').AsDateTime      := dFecha_Next_Cpa;
       ParamByName('cartera').AsString             := sCartera;
       ParamByName('empresa').AsString             := sEmpresa;
       Prepare;
       Open;
       if RecordCount <> 0 then
          fVentas := FieldByName('Valor_Ventas').AsFloat;
       Close;
      {Determinar las compras iguales y superiores a la fecha de la primera compra }
      {posterior al stock }
       SQL.Clear;
       SQL.Add('Select sum(b.Valor_nominal) as Valor_Compras '
              +'  from qs_tra_omd a '
              +'      ,qs_tra_omd_det_rf b '
              +' where a.folio_interno = b.folio_interno '
              +'   and a.transaccion   = b.transaccion '
              +'   and a.cartera       = b.cartera '
              +'   and a.empresa       = b.empresa '
              +'   and a.transaccion in (SELECT d.Codigo_Transaccion '
              +'                           FROM qs_sys_tran_implic d '
              +'                          WHERE d.Codigo_transaccion = a.transaccion '
              +'                            AND d.implicancia = ''COMPRA'' ) '
              +'   and a.folio_interno not in (Select e.folio               '
              +'                                 from qs_ctr_anulacion e    '
              +'                                where e.folio       = a.folio_interno '
              +'                                  and e.empresa     = a.empresa  '
              +'                                  and e.transaccion = a.transaccion) '
              +'   and a.fecha_operacion >= :fecha_compra '
              +'   and b.nemotecnico = :nemotecnico '
              +'   and a.cartera     = :cartera '
              +'   and a.empresa     = :empresa '
              );

       ParamByName('Nemotecnico').AsString     := sNemotecnico;
       ParamByName('fecha_compra').AsDateTime  := dFecha_Next_Cpa;
       ParamByName('cartera').AsString         := sCartera;
       ParamByName('empresa').AsString         := sEmpresa;
       prepare;
       Open;
       if RecordCount <> 0 then
         fCompras := FieldByName('Valor_Compras').AsFloat;
       Close;
       Unprepare;
     end;{if recordcount <> 0 }
     Result := fCompras - fVentas;
   end;{with qry}
end;

function Fecha_stock_rv(sEmpresa : String; sCartera : String): TDateTime;
begin
   with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT * FROM QS_TRA_OMD_STK_AC'
               +' WHERE Cartera = :Cartera '
               +'   AND Empresa = :Empresa '
               );
        ParamByName('Cartera').AsString := sCartera;
        ParamByName('Empresa').AsString := sEmpresa;
        Prepare;
        Open;
        if RecordCount = 0 then
           Result := 0
        else
           Result :=  FieldByName('Fecha_stock').AsDateTime;
     end;
end;

function Fecha_stock_rv_con_nemotecnico(sEmpresa : String; sCartera : String; sNemotecnico : String): TDateTime;
begin
   with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT * FROM QS_TRA_OMD_STK_AC'
               +' WHERE Cartera     = :Cartera '
               +'   AND Empresa     = :Empresa '
               +'   AND NEMOTECNICO = :Nemotecnico '
               );
        ParamByName('Cartera').AsString := sCartera;
        ParamByName('Empresa').AsString := sEmpresa;
        ParamByName('Nemotecnico').AsString := sNemotecnico;
        Prepare;
        Open;
        if RecordCount = 0 then
           Result := 0
        else
           Result :=  FieldByName('Fecha_stock').AsDateTime;
     end;
end;

{procedure Calculo_Ventas_Pendientes_Rv(sNemotecnico   : String;
                                       sCartera       : String;
                                       sEmpresa       : String;
                                       dFecha_Cierre  : TDateTime;
                                       sFolio_Interno : String;
                                   var fVentas        : Double
                                       );
var
  sNemotecnico_Nuevo   : String;
  bExiste_Equivalencia : Boolean;
begin
    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
      sql.Clear;
      sql.Add(' SELECT  a.Nemotecnico'
             +'        ,sum(a.Valor_Nominal) as Ventas      '
             +' from qs_tra_omd_det_rf a  '
             +'     ,qs_tra_omd e '
             +'where a.folio_interno = e.Folio_interno  '
             +'  and a.transaccion   = e.transaccion    '
             +'  and a.empresa       = e.empresa  '
             +'  and a.tipo_instrum = ''R'''
             +'  and e.fecha_operacion  <= :fecha_cierre  '
             +'  and a.empresa           = :Empresa     '
             +'  and a.Cartera           = :Cartera'
             +'  and NOT a.Folio_Interno = :Folio_Interno'
             +'  and a.folio_interno not in (Select b.folio '
             +'                                 from qs_ctr_anulacion b '
             +'                                where b.folio       = a.folio_interno '
             +'                                  and b.empresa     = a.empresa '
             +'                                  and b.transaccion = a.transaccion) '
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''COMPV'')'
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''RV'')'
             +' GROUP BY a.Nemotecnico'
             );
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      ParamByName('Folio_Interno').AsString  := sFolio_Interno;
      Open;

      fVentas := 0;
      While Not Eof do
      begin
          sNemotecnico_Nuevo := Fieldbyname('Nemotecnico').asString;
          Busca_Equivalencia_Mem( 'RV',
                                  'NEMOTEC',
                                   FieldByName('Nemotecnico').AsString,
                                   dFecha_Cierre,
                                   sNemotecnico_Nuevo,
                                   bExiste_Equivalencia
                                 );
         if (     sNemotecnico_Nuevo = sNemotecnico )  and
            ( Not FieldByName('Ventas').IsNull     ) then
            fVentas := fVentas +  FieldByName('Ventas').asFloat;

         Next;
      end;
      Close;
    end;
end;{fin}

{procedure Calculo_Compras_Pendientes_Rv(sNemotecnico   : String;
                                        sCartera       : String;
                                        sEmpresa       : String;
                                        dFecha_Cierre  : TDateTime;
                                        sFolio_Interno : String;
                                        fItem_Omd      : Double;
                                    var fCompras       : Double
                                       );
var
  sNemotecnico_Nuevo   : String;
  bExiste_Equivalencia : Boolean;
begin
    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
      sql.Clear;
      sql.Add(' SELECT  a.Nemotecnico'
             +'        ,sum(a.Valor_Nominal) as Compras '
             +' from qs_tra_omd_det_rf a  '
             +'     ,qs_tra_omd e '
             +'where a.folio_interno = e.Folio_interno  '
             +'  and a.transaccion   = e.transaccion    '
             +'  and a.empresa       = e.empresa  '
             +'  and a.tipo_instrum = ''R'''
             +'  and e.fecha_operacion <= :fecha_cierre  '
             +'  and a.empresa          = :Empresa     '
             +'  and a.Cartera          = :Cartera'
             +'  and NOT ( a.Folio_Interno = :Folio_Interno'
             +'       and  a.Item_Omd      = :Item_Omd'
             +'          )'
             +'  and a.folio_interno not in (Select b.folio '
             +'                                 from qs_ctr_anulacion b '
             +'                                where b.folio       = a.folio_interno '
             +'                                  and b.empresa     = a.empresa '
             +'                                  and b.transaccion = a.transaccion) '
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''COMPC'')'
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''RV'')'
             +' GROUP BY a.Nemotecnico'
             );
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      ParamByName('Folio_Interno').AsString  := sFolio_Interno;
      ParamByName('Item_Omd').Asfloat        := fItem_Omd;
      Open;

      fCompras := 0;
      While Not Eof do
      begin
          sNemotecnico_Nuevo := Fieldbyname('Nemotecnico').asString;
          Busca_Equivalencia_Mem( 'RV',
                                  'NEMOTEC',
                                   FieldByName('Nemotecnico').AsString,
                                   dFecha_Cierre,
                                   sNemotecnico_Nuevo,
                                   bExiste_Equivalencia
                                 );
         if (     sNemotecnico_Nuevo = sNemotecnico )  and
            ( Not FieldByName('Compras').IsNull     ) then
            fCompras := fCompras +  FieldByName('Compras').asFloat;

         Next;
      end;
      Close;
    end;
end;{fin}

procedure Calculo_Compras_Pendientes_Rv(sNemotecnico   : String;
                                        sCartera       : String;
                                        sEmpresa       : String;
                                        dFecha_Cierre  : TDateTime;
                                        sFolio_Interno : String;
                                    var fCompras       : Double
                                       );
var
  sNemotecnico_Nuevo   : String;
  bExiste_Equivalencia : Boolean;
begin
    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
      sql.Clear;
      sql.Add(' SELECT  sum(a.Valor_Nominal) as Compras '
             +' from qs_tra_omd_det_rf a  '
             +'     ,qs_tra_omd e '
             +'where a.folio_interno = e.Folio_interno  '
             +'  and a.transaccion   = e.transaccion    '
             +'  and a.empresa       = e.empresa  '
             +'  and a.tipo_instrum = ''R'''
             +'  and a.empresa            = :Empresa     '
             +'  and a.Cartera            = :Cartera'
             +'  and e.fecha_operacion   <= :fecha_cierre  '
             +'  and NOT  a.Folio_Interno = :Folio_Interno'
             +'  AND a.Nemotecnico        = :Nemotecnico'
             +'  and a.folio_interno not in (Select b.folio '
             +'                                 from qs_ctr_anulacion b '
             +'                                where b.folio       = a.folio_interno '
             +'                                  and b.empresa     = a.empresa '
             +'                                  and b.transaccion = a.transaccion) '
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''COMPC'')'
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''RV'')'
             +' GROUP BY a.Nemotecnico'
             );
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('Folio_Interno').AsString  := sFolio_Interno;
      ParamByName('Nemotecnico').AsString    := sNemotecnico;
      Open;

      fCompras := 0;
      if Not FieldByName('Compras').IsNull   then
         fCompras := FieldByName('Compras').asFloat;
      Close;
    end;
end;{fin}

procedure Calculo_Ventas_Pendientes_Rv(sNemotecnico   : String;
                                       sCartera       : String;
                                       sEmpresa       : String;
                                       dFecha_Cierre  : TDateTime;
                                       sFolio_Interno : String;
                                   var fVentas        : Double
                                       );
var
  sNemotecnico_Nuevo   : String;
  //bExiste_Equivalencia : Boolean;
begin
    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
      sql.Clear;
      sql.Add(' SELECT sum(a.Valor_Nominal) as Ventas      '
             +' from qs_tra_omd_det_rf a  '
             +'     ,qs_tra_omd e '
             +'where a.folio_interno = e.Folio_interno  '
             +'  and a.transaccion   = e.transaccion    '
             +'  and a.empresa       = e.empresa  '
             +'  and a.tipo_instrum = ''R'''
             +'  and a.empresa           = :Empresa     '
             +'  and a.Cartera           = :Cartera'
             +'  and e.fecha_operacion  <= :fecha_cierre  '
             +'  and NOT a.Folio_Interno = :Folio_Interno'
             +'  AND a.Nemotecnico       = :Nemotecnico'
             +'  and a.folio_interno not in (Select b.folio '
             +'                                 from qs_ctr_anulacion b '
             +'                                where b.folio       = a.folio_interno '
             +'                                  and b.empresa     = a.empresa '
             +'                                  and b.transaccion = a.transaccion) '
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''COMPV'')'
             +'  AND e.transaccion in (SELECT d.Codigo_Transaccion'
                                +'    FROM qs_sys_tran_implic d'
                                +'   WHERE d.Codigo_transaccion = a.transaccion'
                                +'    AND d.implicancia = ''RV'')'
             +' GROUP BY a.Nemotecnico'
             );
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('Folio_Interno').AsString  := sFolio_Interno;
      ParamByName('Nemotecnico').AsString    := sNemotecnico;
      Open;

      fVentas := 0;
      if Not FieldByName('Ventas').IsNull   then
         fVentas := FieldByName('Ventas').asFloat;
      Close;
    end;
end;{fin}

procedure Descripcion_Nemotecnico_RV(sNemotecnico  : String;
                                  var sDescripcion : String;
                                  var bResultado   : Boolean
                                    );
begin
     with Dm_Comun_Gestion_F.Qry_Varios do
     begin
       Sql.Clear;
       Sql.Add('Select Descripcion from qs_fin_nem_rvari '
              +' where codigo_nemotecnico = :nemotecnico '
              );
       ParamByName('Nemotecnico').AsString    := sNemotecnico;
       Open;
       if RecordCount <> 0 then
       begin
         sDescripcion := FieldByName('Descripcion').AsString;
         bResultado   := True;
       end
       else
       begin
         sDescripcion  := '';
         bResultado    := False;
       end;
       Close;
     end;
end;

procedure Calculo_Stock_Dividendos_Nemo_Rv(var sNemotecnico            : String;
                                               sCartera                : String;
                                               sEmpresa                : String;
                                               sTransaccion            : String;
                                               dFecha_Cierre           : TDateTime;
                                               dFecha_Inicio_Dividendo : TDatetime;
                                           var fCompras                : Double;
                                           var fCompras_Sin_Derecho    : Double;
                                           var fVentas                 : Double;
                                           var fVentas_Sin_Derecho     : Double;
                                           var fStock                  : Double);
var
  sNemotecnico_Anterior : String;
  sNemotecnico_Nuevo    : String;
  bExiste_Equivalencia  : Boolean;
  sNemotecnicos         : String;
begin

    sNemotecnicos := '('''+sNemotecnico;
    {//ggarcia 21-11-2019 se comenta porque lo hace mas abajo por sql.
     //                   ya que esta funcion llena cada vez que la llaman el array por que la fecha es distinta en cada registro.
    Busca_Equivalencia_Mem( 'RV',
                            'NEMOTEC',
                             sNemotecnico,
                             dFecha_Cierre,                                                                       2636
                             sNemotecnico_Nuevo,
                             bExiste_Equivalencia
                           );
    if bExiste_Equivalencia then
       sNemotecnicos :=  sNemotecnicos +''' , '''+ sNemotecnico_Nuevo;
    }
    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
      sql.Clear;
      sql.Add(' SELECT a.Codigo_Sistema'
             +'   FROM QS_SYS_EQUIVALEN a'
             +'  WHERE a.CODIGO_PROCESO = ''RV'' '
             +'    AND a.CODIGO_OBJETO  = ''NEMOTEC'' '
             +'    AND a.CODIGO_EQUIV   = :Codigo_Equiv '
             +'    AND a.FECHA_DESDE   <= :Fecha_Cierre '
             +'    AND (a.FECHA_HASTA  >= :Fecha_Cierre OR a.FECHA_HASTA is Null) ');
      ParamByName('Codigo_Equiv').AsString   := sNemotecnico;
      ParamByName('Fecha_Cierre').AsDateTime := dFecha_Cierre;
      Open;
//      If Not Eof then
//      begin
//         bExiste_Equivalencia := True;
//         sNemotecnicos :=  sNemotecnicos +''' , '''+ FieldByName('Codigo_Sistema').asString;
//        // sNemotecnico  :=  FieldByName('Codigo_Sistema').asString;  FI & DC se estaba quedando con el nemo original y no con el vigente
//      end;
      while Not eof do
      begin
         bExiste_Equivalencia := True;
         sNemotecnicos :=  sNemotecnicos +''' , '''+ FieldByName('Codigo_Sistema').asString;
         Next;
      end;
    end;

    sNemotecnicos := sNemotecnicos+''')';

    fStock               := 0;
    fCompras             := 0;
    fCompras_Sin_Derecho := 0;
    fVentas              := 0;
    fVentas_Sin_Derecho  := 0;
    with Dm_Comun_Gestion_F.Qry_Varios do
    begin
      sql.Clear;
      sql.Add('SELECT a.Nemotecnico'
             +'      ,a.Tipo_Nominales'
             +'      ,e.Fecha_Operacion'
             +'      ,sum(a.Valor_Nominal) as compras '
             +'  from qs_tra_omd_det_rf a '
             +'      ,qs_tra_omd        e ');
      if bExiste_Equivalencia then
      sql.Add(' where a.nemotecnico       IN '+sNemotecnicos)
      else
      sql.Add(' where a.nemotecnico       = :nemotecnico ');
      sql.Add('   and a.folio_interno     = e.Folio_interno  '
             +'   and a.transaccion       = e.transaccion    '
             +'   and a.empresa           = e.empresa  '
             +'   and e.Folio_Preimpreso  <> '' '' '
             +'   and a.transaccion       = :Compras       '
             +'   and a.tipo_instrum      = ''R'''
             +'   and e.fecha_operacion   <= :fecha_cierre  '
             +'   and a.empresa           = :Empresa     '
             +'   and a.Cartera           = :Cartera'
             +'   and a.folio_interno not in (Select b.folio '
             +'                                  from qs_ctr_anulacion b '
             +'                                 where b.folio       = a.folio_interno '
             +'                                   and b.empresa     = a.empresa '
             +'                                   and b.transaccion = a.transaccion) '
             +' GROUP BY a.Nemotecnico'
             +'         ,a.Tipo_Nominales'
             +'         ,e.Fecha_Operacion'
             );
      if sTransaccion = 'MOVNAV' then
         ParamByName('Compras').AsString        := 'AC'
      else
         ParamByName('Compras').AsString        := 'CRV';
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      if not bExiste_Equivalencia then
         ParamByName('Nemotecnico').AsString    := sNemotecnico;
      Open;

      While Not Eof do
      begin
         if   ( Not FieldByName('Compras').IsNull     )  then  // E.S. 29-08-2016
         begin
            fCompras := fCompras +  FieldByName('Compras').asFloat;

            if ( Fieldbyname('Fecha_Operacion').asDatetime >= dFecha_Inicio_Dividendo ) and
               ( Fieldbyname('Tipo_Nominales').asString = 'S' ) then // Sin derecho a Dividendo
               fCompras_Sin_Derecho := fCompras_Sin_Derecho + FieldByName('Compras').asFloat;
         end;

         Next;
      end;
      Close;

      sql.Clear;
      sql.Add('SELECT a.Nemotecnico'
             +'      ,a.Tipo_Nominales'
             +'      ,e.Fecha_Operacion'
             +'      ,sum(a.Valor_Nominal) as Ventas '
             +'  from qs_tra_omd_det_rf a '
             +'      ,qs_tra_omd        e ');
      if bExiste_Equivalencia then
      sql.Add(' where a.nemotecnico       IN '+sNemotecnicos)
      else
      sql.Add(' where a.nemotecnico       = :nemotecnico ');
      sql.Add('   and a.folio_interno = e.Folio_interno  '
             +'   and a.transaccion   = e.transaccion    '
             +'   and a.empresa       = e.empresa  '
             +'   and a.transaccion      = :Ventas       '
             +'   and e.Folio_Preimpreso <> '' '' '
             +'   and a.tipo_instrum = ''R'''
             +'   and e.fecha_operacion <= :fecha_cierre  '
             +'   and a.empresa          = :Empresa     '
             +'   and a.Cartera          = :Cartera'
             +'   and a.folio_interno not in (Select b.folio '
             +'                                  from qs_ctr_anulacion b '
             +'                                 where b.folio       = a.folio_interno '
             +'                                   and b.empresa     = a.empresa '
             +'                                   and b.transaccion = a.transaccion) '
             +' GROUP BY a.Nemotecnico'
             +'         ,a.Tipo_Nominales'
             +'         ,e.Fecha_Operacion'
             );
      if sTransaccion = 'MOVNAV' then
         ParamByName('Ventas').AsString         := 'RC'
      else
         ParamByName('Ventas').AsString         := 'VRV';
      ParamByName('fecha_cierre').AsDateTime := dFecha_Cierre;
      ParamByName('empresa').AsString        := sEmpresa;
      ParamByName('Cartera').AsString        := sCartera;
      if not bExiste_Equivalencia then
         ParamByName('Nemotecnico').AsString    := sNemotecnico;
      Open;

      While Not Eof do
      begin
         if  ( Not FieldByName('Ventas').IsNull     )  then   // E.S. 29-08-2016
         begin
            fVentas := fVentas +  FieldByName('Ventas').asFloat;

            if ( Fieldbyname('Fecha_Operacion').asDatetime >= dFecha_Inicio_Dividendo ) and
               ( Fieldbyname('Tipo_Nominales').asString = 'S' ) then // Sin derecho a Dividendo
               fVentas_Sin_Derecho := fVentas_Sin_Derecho + FieldByName('Ventas').asFloat;
         end;
         Next;
      end;
      Close;
    end;
    fStock := fCompras - fCompras_Sin_Derecho - fVentas + fVentas_Sin_Derecho;
end;{fin}


end.
