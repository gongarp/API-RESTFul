unit Frm_AyudaMARS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmAyudaMARS = class(TForm)
    Panel4: TPanel;
    BtnAcepta: TBitBtn;
    BtnCancelar: TBitBtn;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    datafecha: TDataSource;
    DataSource1: TDataSource;
    DBGrid2: TDBGrid;
    Query1: TFDQuery;
    Query2: TFDQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAceptaClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BTN_SalirClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
  private
    { Private declarations }
    bAyuda_Sin_Empresa : Boolean;
  public
    { Public declarations }
      bDPart1,
      bDPart2,
      bDPart3,
      bDPart4,
      bDPart5  : Boolean;
      dfechaCierre,
      dfechaCierreAnterior,
      dFechaInicio    : TDatetime;
      sMonedaConver,
      sEmpresa,
      xTipos_Conversion,
      sTipoconversion : String;
  end;
 function Leer_FechaCierreGAAP_Sin_Empresa(  var dFecha0 : Tdatetime;
                                 var dFecha1 : Tdatetime;
                                 var dFecha2 : Tdatetime;
                                 var sTipo   : String;
                                 var sMoneda : String;
                                     DPart1  : Boolean;
                                     DPart2  : Boolean;
                                     DPart3  : Boolean;
                                     DPart4  : Boolean;
                                     DPart5  : Boolean;
                                 sTipos_Conversion : String
                                ): boolean;


  function Leer_FechaCierreGAAP(  var sEmpresa_GAAP : String;
                                  var dFecha0 : Tdatetime;
                                  var dFecha1 : Tdatetime;
                                  var dFecha2 : Tdatetime;
                                  var sTipo   : String;
                                  var sMoneda : String;
                                      DPart1  : Boolean;
                                      DPart2  : Boolean;
                                      DPart3  : Boolean;
                                      DPart4  : Boolean;
                                      DPart5  : Boolean
                                 ): boolean;
var
  FrmAyudaMARS: TFrmAyudaMARS;



implementation
uses DM_Variables_Menu,
     DM_Base_Datos;

{$R *.DFM}

function Leer_FechaCierreGAAP_Sin_Empresa(  var dFecha0 : Tdatetime;
                                var dFecha1 : Tdatetime;
                                var dFecha2 : Tdatetime;
                                var sTipo   : String;
                                var sMoneda : String;
                                    DPart1  : Boolean;
                                    DPart2  : Boolean;
                                    DPart3  : Boolean;
                                    DPart4  : Boolean;
                                    DPart5  : Boolean;
                                sTipos_Conversion : String
                               ): boolean;
begin
   with TFrmAyudaMARS.Create(Application.Owner) do
   begin
      bDPart1 := DPart1;
      bDPart2 := DPart3;
      bDPart3 := DPart3;
      bDPart4 := DPart4;
      bDPart5 := DPart5;
      bAyuda_Sin_Empresa := True;
      xTipos_Conversion := sTipos_Conversion;
      
      ShowModal;
      dFecha0 := dfechaCierre;
      dFecha1 := dfechaCierreAnterior;
      dFecha2 := dFechaInicio;
      stipo   := sTipoconversion;
      sMoneda := sMonedaConver;
      Result  := ModalResult = mrOk;
      Free;
   end;
end;


function Leer_FechaCierreGAAP(  var sEmpresa_GAAP : String;
                                var dFecha0 : Tdatetime;
                                var dFecha1 : Tdatetime;
                                var dFecha2 : Tdatetime;
                                var sTipo   : String;
                                var sMoneda : String;
                                    DPart1  : Boolean;
                                    DPart2  : Boolean;
                                    DPart3  : Boolean;
                                    DPart4  : Boolean;
                                    DPart5  : Boolean
                               ): boolean;
begin
   with TFrmAyudaMARS.Create(Application.Owner) do
   begin
      sEmpresa := sEmpresa_Gaap;
      bDPart1 := DPart1;
      bDPart2 := DPart3;
      bDPart3 := DPart3;
      bDPart4 := DPart4;
      bDPart5 := DPart5;
      bAyuda_Sin_Empresa := False;
      ShowModal;
      sEmpresa_Gaap := sEmpresa;
      dFecha0 := dfechaCierre;
      dFecha1 := dfechaCierreAnterior;
      dFecha2 := dFechaInicio;
      stipo   := sTipoconversion;
      sMoneda := sMonedaConver;
      Result  := ModalResult = mrOk;
      Free;
   end;
end;

procedure TFrmAyudaMARS.FormActivate(Sender: TObject);
begin
   // OJO: COn fecha 03-09-2007 se elimina moneda de conversion cuando el tipo de conversion sea moneda_caja
   // Estaba malo desde siempre al parecer .... (F.I.)
   if NOT bAyuda_Sin_Empresa then
   begin
      with Query1 do
      begin
         Close;
         SQL.Clear;
         if bDPart1 then
         begin
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );

            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

         end;

         if bDPart3 then
         begin
            if Trim(SQL.Text) <> '' then
               Sql.Add( ' UNION ' );
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

         end;

         if bDPart4 then
         begin
            if Trim(SQL.Text) <> '' then
               Sql.Add( ' UNION ' );
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

         end;

         if bDPart5 then
         begin
            if Trim(SQL.Text) <> '' then
               Sql.Add( ' UNION ' );
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Empresa,Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if (sEmpresa <> '') then
                SQL.Add(' AND empresa = :empresa ');
         end;
         if (sEmpresa <> '') then
            ParamByname('empresa').AsString := sEmpresa;

         SQL.Add(' ORDER BY  Empresa,Fecha_de_cierre DESC, Fecha_cierre_anterior DESC, Fecha_Inicio_anterior DESC, Tipo_conversion, Moneda_conversion');
         Open;
      end;
      datafecha.DataSet := Query1;
   end
   else
   begin
      DBGrid2.Visible := True;
      with Query2 do
      begin
         Close;
         SQL.Clear;
         if bDPart1 then
         begin
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as Moneda_conversion '
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );
            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as Moneda_conversion '
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as Moneda_conversion '
                   +' FROM  QS_GAAP_DPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART1 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

         end;

         if bDPart3 then
         begin
            if Trim(SQL.Text) <> '' then
               Sql.Add( ' UNION ' );
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );


            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART3 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

         end;

         if bDPart4 then
         begin
            if Trim(SQL.Text) <> '' then
               Sql.Add( ' UNION ' );

            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );


            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );


            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART4 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );
         end;

         if bDPart5 then
         begin
            if Trim(SQL.Text) <> '' then
               Sql.Add( ' UNION ' );
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Origen'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );


            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Cartera'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion, Moneda_conversion'
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Conversion'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

            SQL.Add(' UNION ');
            SQL.Add(' SELECT DISTINCT Fecha_de_cierre, Fecha_cierre_anterior, Fecha_Inicio_anterior, Tipo_conversion'
                   +' ,''               '' as   Moneda_conversion '
                   +' FROM  QS_GAAP_DAPART5 '
                   +' WHERE Tipo_conversion = ''Moneda_Caja'''
                   );
            if trim(xTipos_Conversion) <> '' then
               Sql.Add( 'AND Tipo_conversion NOT IN '+xTipos_Conversion );

         end;
         SQL.Add(' ORDER BY  Fecha_de_cierre desc, Fecha_cierre_anterior desc, Fecha_Inicio_anterior desc, Tipo_conversion, Moneda_conversion ');

//         if bdesarrollo then
//            SQL.SaveToFile('C:\select.sql');
         Open;
      end;
   end;
end;

procedure TFrmAyudaMARS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Query1.Close;
end;

procedure TFrmAyudaMARS.BtnAceptaClick(Sender: TObject);
begin
   if NOT bAyuda_Sin_Empresa then
   begin
//      if not Query1.eof then
//      if Query1.RECORDCOUNT > 0  then  // Comentado el 31-07-2009 Muy lentoooo F.I.
      if NOT Query1.FieldByName('Fecha_de_cierre').IsNull then
      begin
         BtnAcepta.modalresult := mrOk;
         sEmpresa              := Query1.FieldByName('Empresa').AsString;
         dFechaCierre          := Query1.FieldByName('Fecha_de_cierre').AsDatetime;
         dfechaCierreAnterior  := Query1.FieldByName('Fecha_cierre_anterior').AsDatetime;
         dFechaInicio          := Query1.FieldByName('Fecha_Inicio_anterior').AsDatetime;
         sTipoconversion       := Query1.FieldByName('Tipo_conversion').AsString;
         sMonedaConver         := Query1.FieldByName('Moneda_conversion').AsString;
      end
   end
   else
//      if not Query2.eof then
//      if Query2.RECORDCOUNT > 0  then
      if NOT Query2.FieldByName('Fecha_de_cierre').IsNull then
      begin
         BtnAcepta.modalresult := mrOk;
         dFechaCierre          := Query2.FieldByName('Fecha_de_cierre').AsDatetime;
         dfechaCierreAnterior  := Query2.FieldByName('Fecha_cierre_anterior').AsDatetime;
         dFechaInicio          := Query2.FieldByName('Fecha_Inicio_anterior').AsDatetime;
         sTipoconversion       := Query2.FieldByName('Tipo_conversion').AsString;
         sMonedaConver         := Query2.FieldByName('Moneda_conversion').AsString;
      end
end;

procedure TFrmAyudaMARS.BtnCancelarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmAyudaMARS.BTN_SalirClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmAyudaMARS.DBGrid2DblClick(Sender: TObject);
begin
   // BtnAceptaClick(Sender);
 //  FrmAyudaMARS.ModalResult := mrOk;
end;

end.
