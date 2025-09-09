unit DM_Holding_Empresas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DM_Base_Datos, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM_Holding = class(TDataModule)
    Qry_Multiuso: TFDQuery;
    Qry_Holding: TFDQuery;
    Qry_Update: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure Tipo_Relacion_Padre(var sEmpresa : String;
                                var Result   : Boolean);

 procedure Descripcion_Relacion(sEmpresa     : String;
                                var sDescripcion : String;
                                var Result       : Boolean);
  function Holding_Empresa(sEmpresa : String): String;

  function Ultimo_Nodo(sHolding : String): Double;

  procedure Actualiza_Empresas_Padres(sHolding:String);

  procedure Borrar_Nodo(sHolding :String; fNodo:Double);
    
var
  DM_Holding: TDM_Holding;

implementation

{$R *.DFM}

procedure Tipo_Relacion_Padre(var sEmpresa : String;
                              var Result   : Boolean);
begin
  Result := True;
  WITH DM_Holding.Qry_Holding do
    begin
      SQL.Clear;
      SQL.Add('SELECT * '
             +'  FROM QS_SYS_DEF_HOLDING '
             +' WHERE CODIGO_EMPRESA = :Codigo_Empresa'
             );
      ParamByName('Codigo_Empresa').AsString := trim(sEmpresa);

      Prepare;
      Open;
      if NOT FieldByName('CODIGO_EMPRESA').IsNull then
         begin
           if FieldByName('TIPO_REL_HOLDING').AsString = 'MATRIZ' then
              begin
              Result := False;
              sEmpresa := FieldByName('CODIGO_HOLDING').AsString;
              end
           else
              sEmpresa := FieldByName('SYS_CODIGO_EMPRESA').AsString;
         end
      else
         Result := False;

      Close;
      UnPrepare;
    end;
end;

procedure Descripcion_Relacion(sEmpresa     : String;
                           var sDescripcion : String;
                           var Result       : Boolean);
begin
  Result := True;
  sDescripcion := '';

  WITH DM_Holding.Qry_Holding do
    begin
      SQL.Clear;
      SQL.Add('SELECT TIPO_REL_HOLDING'
             +'  FROM QS_SYS_DEF_HOLDING'
             +' WHERE CODIGO_EMPRESA = :Codigo_Empresa'
             );
      ParamByName('Codigo_Empresa').AsString := sEmpresa;
      Prepare;
      Open;
      if FieldByName('TIPO_REL_HOLDING').IsNull then
         Result := False
      else
         sDescripcion := FieldByName('TIPO_REL_HOLDING').AsString;

      Close;
      UnPrepare;
    end;
end;

{ Se requiere saber a que holding pertenece una empresa}
function Holding_Empresa(sEmpresa : String): String;
begin
  with DM_Holding.Qry_Holding do
   begin
     SQL.Clear;
     SQL.Add('Select * '
            +'  from qs_sys_def_holding '
            +' where codigo_empresa = :Empresa  ');
      ParamByName('Empresa').AsString := sEmpresa;
      Prepare;
      Open;
      if FieldByName('codigo_holding').IsNull then
         Result := ''
      else
         Result := FieldByName('codigo_holding').AsString;
      Close;
      UnPrepare;
   end;
end;

function Ultimo_Nodo(sHolding : String): Double;
begin
  with DM_Holding.Qry_Holding do
    begin
      Sql.Clear;
      Sql.Add('Select Max(nodo) as Nodito from qs_sys_des_holding '
             +' where codigo_holding = :Holding ');
      ParamByName('Holding').AsString := sHolding;
      Prepare;
      Open;
      if NOT FieldByName('Nodito').Isnull then
         Result := FieldByName('Nodito').AsFloat
      else
         Result := 0;
      Close;
      Unprepare;
    end;
end;
{dado el nodo digame la empresa que representa}
function Empresa_Nodo(fNodo   : Double;
                      sHolding:String):String;
begin
  With DM_Holding,Qry_Multiuso do
    begin
      Sql.Clear;
      Sql.Add('Select empresa as Empresa from qs_sys_des_holding '
             +' where nodo = :nodo '
             +'   and codigo_holding = :Holding ');
      ParamByName('Nodo').AsFloat     := fNodo;
      ParamByName('Holding').AsString := sHolding;
      Prepare;
      Open;
      If FieldByName('Empresa').Isnull then
         Result := ''
      else
         Result := FieldByName('Empresa').AsString;
      Close;
      Unprepare;
    end;
end;


{Esta rutina regulariza las empresas padres por si hubo movimientos de drag and drop}
procedure Actualiza_Empresas_Padres(sHolding:String);
var sEmpresa : String;
begin
  With  DM_Holding do
  begin
    with Qry_Holding do
      begin
        Sql.Clear;
        Sql.Add('Select * from qs_sys_des_holding '
               +' where codigo_holding = :Holding ');
        ParambyName('Holding').AsString := sHolding;
        Prepare;
        Open;
        while NOT EOF do
          begin
            Qry_Update.Sql.Clear;
            Qry_Update.Sql.Add('Update qs_sys_des_holding '
                              +' set sys_empresa = :Empresa_padre '
                              +' where Nodo    = :Nodo '
                              +'   and empresa = :empresa '
                              +'   and codigo_holding = :Holding ');
            sEmpresa :=Empresa_Nodo(FieldByName('Nodo_padre').AsFloat
                                   ,sHolding);

            Qry_Update.ParambyName('Empresa_padre').AsString := sEmpresa;
            Qry_Update.ParambyName('Nodo').AsFloat     := FieldByName('Nodo').AsFloat;
            Qry_Update.ParambyName('empresa').AsString := FieldByName('Empresa').AsString;
            Qry_Update.ParambyName('Holding').AsString := sHolding;
            Qry_Update.Prepare;
            Qry_Update.ExecSql;
            Qry_Update.Close;
            Qry_Update.Unprepare;
            Next;
          end;{while}
          Close;
          Unprepare;
        end;
   end;
end;

procedure Delete_Nodo(sHolding :String; fNodo:Double);
begin
  With DM_Holding,Qry_Update do
   begin
     Sql.Clear;
     Sql.Add('Delete from qs_sys_des_holding where nodo = :nodo '
            +'   and codigo_holding = :holding ');
     ParamByName('nodo').AsFloat     := fNodo;
     ParamByName('holding').AsString := sHolding;
     Prepare;
     ExecSql;
     Close;
     Unprepare;
   end;
end;

procedure Borrar_Nodo(sHolding :String; fNodo:Double);
var
  Qry : TFDQuery;
begin
  Qry := TFDQuery.Create(DM_Holding);
  Qry.Connection := dmBaseDatos.Conexion_BaseDatos;
  Qry.ConnectionName := 'PMSSERVER';

  Qry.Name := 'Name'+floattostr(fnodo);
  With DM_Holding,Qry do
    begin
      Sql.Clear;
      Sql.Add('Select * from qs_sys_des_holding '
             +' Where nodo_padre     = :nodo '
             +'   and codigo_Holding = :holding '
             );
      ParamByName('nodo').AsFloat     := fNodo;
      ParamByName('holding').AsString := sHolding;
      Prepare;
      Open;
      While NOT EOF do
        begin
          Borrar_Nodo(sHolding,FieldByName('Nodo').AsFloat);//hijos
          Delete_Nodo(sHolding,FieldByName('Nodo').AsFloat);//Padre
          Next;
        end;
      Close;
      Unprepare;
      Free;
      Delete_Nodo(sHolding,fNodo);//Nodo principal
    end;
end;

end.
