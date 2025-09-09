unit Registro_Log;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmRegistro_Log = class(TForm)
    Qry_inserta: TFDQuery;
    Qry_General_Frm: TFDQuery;
    Qry_inserta_det: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRegistro_Log         : TFrmRegistro_Log;
  procedure limpia_array_Mod;
  procedure inicializa_Log;
  procedure Inserta_Log(bTransaccion : Boolean);
  procedure Inserta_Log_Det(bTransaccion : Boolean;Item:Integer);
  procedure carga_estado(estado : Integer);
  procedure agrega_datosarray_cartera(var x : Integer);
  procedure actualiza_RegMod;
  procedure agrega_datosarray(var x : Integer
                             ;sTipo : String);
  procedure grabar_editar;
  procedure llenar_log(descripcion  : String;
                       sTransaccion : String;
                       sFolio       : String;
                       bTransaccion : Boolean);
  procedure llenar_log2(sOpcion_Menu : String;
                        descripcion  : String;
                        sTransaccion : String;
                        sFolio       : String;
                        bTransaccion : Boolean);

  procedure Graba_Log_GAAP(sProceso_Market   : String;
                           sD_Part1          : String;
                           sD_Part3          : String;
                           sD_Part4          : String;
                           sD_Part5          : String;
                           sDA_Part1         : String;
                           sDA_Part3         : String;
                           sDA_Part4         : String;
                           sDA_Part5         : String;
                           sTipo_Conversion  : String;
                           dFecha_Cierre     : TDateTime;
                           dFecha_Cierre_Ant : TDateTime;
                           dFecha_Inicio_Ant : TDateTime);

implementation
Uses DM_Base_Datos,
     DM_Global_Var,
     DM_Variables_Menu,
     uSystemInfo,
     DM_Comun;

{$R *.DFM}


procedure limpia_array_Mod;
var i : Integer;
begin
   for i := 1 to 1000 do
   begin
   Array_Reg_Mod[i].Pid           := 0;
   Array_Reg_Mod[i].Fecha_hora    := 0;
   Array_Reg_Mod[i].Descr_Campo   := '';
   Array_Reg_Mod[i].Campo         := '';
   Array_Reg_Mod[i].Valor_antes   := '';
   Array_Reg_Mod[i].Valor_despues := '';
   end;
end;

procedure inicializa_Log;
var i : Integer;
begin
   for i := 1 to 1000 do
   begin
   Array_Reg_Log[i].Pid        := 0;
   Array_Reg_Log[i].Fecha_hora := 0;
   Array_Reg_Log[i].Campo      := '';
   Array_Reg_Log[i].valor      := '';
   end;
end;

procedure Inserta_Log(bTransaccion : Boolean);
var
  sUserName, sHostName, sIPaddr, sMacAddr : String;
  i   : Integer;
  Sarchivo  : String;
//  DatosOk : Boolean;
begin
  //Info_Conexion(sUserName, sHostName, sIPaddr, sMacAddr);
  //Se reemplaza por funcion compatible a XE5 para los distintos Windows.
//  DatosOk :=

  GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);

   if btransaccion then
      if NOT (dmBaseDatos.Conexion_BaseDatos.inTransaction) then
         dmBaseDatos.Conexion_BaseDatos.StartTransaction;

   With FrmRegistro_Log.Qry_inserta do
   begin
     Close;
     Sql.Clear;
     sql.add('INSERT INTO QS_SYS_LOG ');
     sql.add('( ');
     sql.add(' Pid ');
     sql.add(',Fecha_hora ');
     sql.add(',Proceso ');
     sql.add(',Usuario_PMS ');
     sql.add(',Perfil_PMS ');
     sql.add(',Usuario_WIN ');
     sql.add(',Nombre_MAQ ');
     sql.add(',Direccion_IP ');
     sql.add(',MAC ');
     sql.add(',Tipo ');
     sql.add(',Evento ');
     sql.add(') ');
     sql.add(' VALUES ');
     sql.add('( ');
     sql.add('  :Pid ');
     sql.add(' ,:Fecha_hora ');
     sql.add(' ,:Proceso ');
     sql.add(' ,:Usuario_PMS ');
     sql.add(' ,:Perfil_PMS ');
     sql.add(' ,:Usuario_WIN ');
     sql.add(' ,:Nombre_MAQ ');
     sql.add(' ,:Direccion_IP ');
     sql.add(' ,:MAC ');
     sql.add(' ,:Tipo ');
     sql.add(' ,:Evento ');
     sql.add(') ');

     ParamByName('Pid').AsFloat           := fPid;
     ParamByName('Fecha_hora').AsDatetime := dfecha_hora;
     ParamByName('Proceso').AsString      := copy(trim(sPrograma),1,50);  //ggarcia 15-01-2015 trim(sPrograma)
     ParamByName('Usuario_PMS').AsString  := trim(sLogin_Sistema);
     ParamByName('Perfil_PMS').AsString   := trim(sperfil_usuario);
     ParamByName('Usuario_WIN').AsString  := trim(sUserName);
     ParamByName('Nombre_MAQ').AsString   := sHostName;
     ParamByName('Direccion_IP').AsString := sIPaddr;
     ParamByName('MAC').AsString          := sMacAddr;
     ParamByName('Tipo').AsString         := 'P';
     ParamByName('Evento').AsString       := copy(trim(sEvento),1,100);

     try
       ExecSql;
     except on E:EFDDBEngineException do
       begin
          ShowError(E);
          Close;
          if btransaccion then
             if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                 dmBaseDatos.Conexion_BaseDatos.Rollback;
          Exit;
       end;
     end;
     Close;
   end;

   With FrmRegistro_Log.Qry_inserta_det do
   begin
     Close;
     i := 1;
     while trim(Array_Reg_Log[i].Campo) <> '' do
     begin
        Close;
        Sql.Clear;
        sql.add('INSERT INTO QS_SYS_LOG_DET ');
        sql.add('( ');
        sql.add(' Pid ');
        sql.add(',Fecha_hora ');
        sql.add(',Item ');
        sql.add(',Campo ');
        sql.add(',Valor ');
        sql.add(') ');
        sql.add(' VALUES ');
        sql.add('( ');
        sql.add('  :pPid ');
        sql.add(' ,:pFecha_hora ');
        sql.add(' ,:pItem ');
        sql.add(' ,:pCampo ');
        sql.add(' ,:pValor ');
        sql.add(') ');
        ParamByName('pPid').AsFloat           := Array_Reg_Log[i].Pid;
        ParamByName('pFecha_hora').AsDatetime := Array_Reg_Log[i].Fecha_hora;
        ParamByName('pItem').AsInteger        := i;
        ParamByName('pCampo').AsString        := copy(Array_Reg_Log[i].Campo,1,60);    //Array_Reg_Log[i].Campo;
        ParamByName('pValor').AsString        := Array_Reg_Log[i].Valor;
        i := i + 1;
        try
          ExecSql;
        except on E:EFDDBEngineException do
          begin
             ShowError(E);
             Close;
             if btransaccion then
                if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                   dmBaseDatos.Conexion_BaseDatos.Rollback;
             Exit;
          end;
        end;
        Close;
     end;

     if fileDate_Log > -1 then
     begin
          if fileDate_Log = 999 then
             Sarchivo := fileName_Log     // El no,bre viene con la fecha
          else
             Sarchivo := fileName_Log+' '+formatdatetime('dd/mm/yyyy HH:MM',FileDateToDateTime(fileDate_Log));

        if trim(Array_Reg_Log[1].Campo) <> '' then
        begin
          Close;
          Sql.Clear;
          sql.add('INSERT INTO QS_SYS_LOG_DET ');
          sql.add('( ');
          sql.add(' Pid ');
          sql.add(',Fecha_hora ');
          sql.add(',Item ');
          sql.add(',Campo ');
          sql.add(',Valor ');
          sql.add(') ');
          sql.add(' VALUES ');
          sql.add('( ');
          sql.add('  :pPid ');
          sql.add(' ,:pFecha_hora ');
          sql.add(' ,:pItem ');
          sql.add(' ,:pCampo ');
          sql.add(' ,:pValor ');
          sql.add(') ');
          ParamByName('pPid').AsFloat           := Array_Reg_Log[1].Pid;
          ParamByName('pFecha_hora').AsDatetime := Array_Reg_Log[1].Fecha_hora;
          ParamByName('pItem').AsInteger        := i;
          ParamByName('pCampo').AsString        := 'Modulo y Fecha Archivo';
          ParamByName('pValor').AsString        := Sarchivo;
          i := i + 1;
          try
            ExecSql;
          except on E:EFDDBEngineException do
            begin
               ShowError(E);
               Close;
               if btransaccion then
                  if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                    dmBaseDatos.Conexion_BaseDatos.Rollback;
               Exit;
            end;
          end;
          Close;
        end;
     end;

     Close;
     Sql.Clear;
     sql.add('INSERT INTO QS_SYS_LOG_DET ');
     sql.add('( ');
     sql.add(' Pid ');
     sql.add(',Fecha_hora ');
     sql.add(',Item ');
     sql.add(',Campo ');
     sql.add(',Valor ');
     sql.add(') ');
     sql.add(' VALUES ');
     sql.add('( ');
     sql.add('  :pPid ');
     sql.add(' ,:pFecha_hora ');
     sql.add(' ,:pItem ');
     sql.add(' ,:pCampo ');
     sql.add(' ,:pValor ');
     sql.add(') ');
     ParamByName('pPid').AsFloat           := Array_Reg_Log[1].Pid;
     ParamByName('pFecha_hora').AsDatetime := Array_Reg_Log[1].Fecha_hora;
     ParamByName('pItem').AsInteger        := i;            //997;
     ParamByName('pCampo').AsString        := 'Empresa';    //Array_Reg_Log[i].Campo;
     ParamByName('pValor').AsString        := sEmpresa_usuario;
     try
       ExecSql;
     except on E:EFDDBEngineException do
       begin
          ShowError(E);
          Close;
          if btransaccion then
             if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                 dmBaseDatos.Conexion_BaseDatos.Rollback;
          Exit;
       end;
     end;
     Close;

   end;

   if btransaccion then
      if dmBaseDatos.Conexion_BaseDatos.inTransaction then
        dmBaseDatos.Conexion_BaseDatos.Commit;
end;

procedure Inserta_Log_Det(bTransaccion : Boolean;Item:Integer);
var
  sUserName, sHostName, sIPaddr, sMacAddr : String;
//  Sarchivo  : String;
//  DatosOk : Boolean;
begin
//   Info_Conexion(sUserName, sHostName, sIPaddr, sMacAddr);
   //Se reemplaza por funcion compatible a XE5 para los distintos Windows.
//  DatosOk :=
  GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);

   if bTransaccion then
      if NOT (dmBaseDatos.Conexion_BaseDatos.inTransaction) then
        dmBaseDatos.Conexion_BaseDatos.StartTransaction;

   With FrmRegistro_Log.Qry_inserta_det do
   begin
        Close;
        Sql.Clear;
        sql.add('INSERT INTO QS_SYS_LOG_DET ');
        sql.add('( ');
        sql.add(' Pid ');
        sql.add(',Fecha_hora ');
        sql.add(',Item ');
        sql.add(',Campo ');
        sql.add(',Valor ');
        sql.add(') ');
        sql.add(' VALUES ');
        sql.add('( ');
        sql.add('  :pPid ');
        sql.add(' ,:pFecha_hora ');
        sql.add(' ,:pItem ');
        sql.add(' ,:pCampo ');
        sql.add(' ,:pValor ');
        sql.add(') ');

        ParamByName('pPid').AsFloat           := Array_Reg_Log[Item].Pid;
        ParamByName('pFecha_hora').AsDatetime := Array_Reg_Log[Item].Fecha_hora;
        ParamByName('pItem').AsInteger        := Item;
        ParamByName('pCampo').AsString        := copy(Array_Reg_Log[Item].Campo,1,60);    //Array_Reg_Log[i].Campo;
        ParamByName('pValor').AsString        := Array_Reg_Log[Item].Valor;

        try
          ExecSql;
        except on E:EFDDBEngineException do
          begin
             ShowError(E);
             Close;
             if bTransaccion then
                if (dmBaseDatos.Conexion_BaseDatos.InTransaction) then
                    dmBaseDatos.Conexion_BaseDatos.Rollback;
             Exit;
          end;
        end;
        Close;
   end;

   if bTransaccion then
      if (dmBaseDatos.Conexion_BaseDatos.InTransaction) then
          dmBaseDatos.Conexion_BaseDatos.Commit;
end;

procedure carga_estado(estado : Integer);
var
  i                   : Integer;
  dif_fecha_hora      : TDateTime;
  dfecha_hora_termino : TDateTime;
  dif_hora            : String;
begin
   if NOT (dmBaseDatos.Conexion_BaseDatos.inTransaction) then
      dmBaseDatos.Conexion_BaseDatos.StartTransaction;

   With FrmRegistro_Log.Qry_inserta_det do
   begin
     dfecha_hora_termino := Fecha_Hora_Servidor;
     dif_fecha_hora := dfecha_hora_termino - Array_Reg_Log[1].Fecha_hora;
     dif_hora := FormatDateTime('hh:mm:ss',dif_fecha_hora);

     Close;
     Sql.Clear;
     sql.add('INSERT INTO QS_SYS_LOG_DET ');
     sql.add('( ');
     sql.add(' Pid ');
     sql.add(',Fecha_hora ');
     sql.add(',Item ');
     sql.add(',Campo ');
     sql.add(',Valor ');
     sql.add(') ');
     sql.add(' VALUES ');
     sql.add('( ');
     sql.add('  :pPid ');
     sql.add(' ,:pFecha_hora ');
     sql.add(' ,:pItem ');
     sql.add(' ,:pCampo ');
     sql.add(' ,:pValor ');
     sql.add(') ');

     // ggarcia 07-11-2016
     i := 997;
     dfecha_hora_termino := Fecha_Hora_Servidor;
     ParamByName('pPid').AsFloat           := Array_Reg_Log[1].Pid;
     ParamByName('pFecha_hora').AsDatetime := Array_Reg_Log[1].Fecha_hora;
     ParamByName('pItem').AsInteger        := i;
     ParamByName('pCampo').AsString        := 'FECHA HORA DE TERMINO';
     ParamByName('pValor').AsString        := formatdatetime('dd/mm/yyyy HH:MM:SS',dfecha_hora_termino);
     try
       ExecSql;
     except on E:EFDDBEngineException do
       begin
          ShowError(E);
          Close;
          if (dmBaseDatos.Conexion_BaseDatos.InTransaction) then
              dmBaseDatos.Conexion_BaseDatos.Rollback;
          Exit;
       end;
     end;
     Close;

     i := 998;
     dif_fecha_hora := dfecha_hora_termino - Array_Reg_Log[1].Fecha_hora;
     dif_hora := FormatDateTime('hh:mm:ss',dif_fecha_hora);
     ParamByName('pPid').AsFloat           := Array_Reg_Log[1].Pid;
     ParamByName('pFecha_hora').AsDatetime := Array_Reg_Log[1].Fecha_hora;
     ParamByName('pItem').AsInteger        := i;
     ParamByName('pCampo').AsString        := 'TIEMPO PROCESO';
     ParamByName('pValor').AsString        := dif_hora;
     try
       ExecSql;
     except on E:EFDDBEngineException do
       begin
          ShowError(E);
          Close;
          if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                 dmBaseDatos.Conexion_BaseDatos.Rollback;
          Exit;
       end;
     end;
     Close;

     i := 999;
     if estado=3 then
        i := 1000;
     ParamByName('pPid').AsFloat           := Array_Reg_Log[1].Pid;
     ParamByName('pFecha_hora').AsDatetime := Array_Reg_Log[1].Fecha_hora;
     ParamByName('pItem').AsInteger        := i;
     ParamByName('pCampo').AsString        := 'ESTADO DE TERMINO';
     case estado of
       0 :
         ParamByName('pValor').AsString    := 'Proceso Abortado';
       1 :
         ParamByName('pValor').AsString    := 'Proceso Terminado Normalmente';
       2 :
         ParamByName('pValor').AsString    := 'Proceso Abortado';  //se repitio por equivocacion ya no se puede eliminar
       3 :
         ParamByName('pValor').AsString    := 'Proceso Terminado con Errores';
       4 :
         ParamByName('pValor').AsString    := 'Proceso Terminado Sin Informacion';
     end;
     try
       ExecSql;
     except on E:EFDDBEngineException do
       begin
          ShowError(E);
          Close;
          if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                 dmBaseDatos.Conexion_BaseDatos.Rollback;
          Exit;
       end;
     end;
     Close;
   end;

   if dmBaseDatos.Conexion_BaseDatos.inTransaction then
     dmBaseDatos.Conexion_BaseDatos.Commit;
end;

procedure agrega_datosarray_cartera(var x : Integer);
begin
   with FrmRegistro_Log.Qry_General_Frm do
   begin
     Close;
     Sql.Clear;
     Sql.Add('SELECT cartera '
            + ' FROM QS_SYS_PARAM_EMPRESA '
            +' WHERE pid = :Pid'
             );
     ParamByName('pid').asString := IntToStr(Application.Handle);

     open;

     while not eof do
     begin
       x := x + 1;
       Array_Reg_Log[x].Pid        := fPid;
       Array_Reg_Log[x].Fecha_hora := dfecha_hora;
       Array_Reg_Log[x].Campo      := 'CARTERA';
       Array_Reg_Log[x].valor      := Trim(FieldByname('CARTERA').AsString);
       Next;
     end;
     Close;
   end;
end;

procedure agrega_datosarray(var x : Integer
                           ;sTipo : String);
var campo  : String;
begin
   if sTipo = 'STK_EMISOR' then
      campo := 'EMISOR'
   else
      if sTipo = 'EMPRESA' then
         campo := 'EMPRESA'
      else
         if sTipo = 'STK_INST' then
            campo := 'INSTRUMENTO'
         else
            if sTipo = 'STK_SERIE' then
               campo := 'SERIE'
            else
               campo := 'NEMOTECNICO';

   with FrmRegistro_Log.Qry_General_Frm do
   begin
     Close;
     Sql.Clear;
     Sql.Add('SELECT Valor '
            + ' FROM QS_SYS_PARAM_PROCESO '
            +' WHERE Parametro = :Parametro'
            +'   AND Proceso   = :Proceso'
            );

     ParamByName('Parametro').AsString := sTipo;
     ParamByName('Proceso').asString   := IntToStr(Application.Handle);

     open;
     
     while not eof do
     begin
       x := x + 1;
       Array_Reg_Log[x].Pid        := fPid;
       Array_Reg_Log[x].Fecha_hora := dfecha_hora;
       Array_Reg_Log[x].Campo      := campo;
       Array_Reg_Log[x].valor      := Trim(FieldByname('Valor').AsString);
       Next;
     end;
     Close;
   end;
end;

procedure grabar_editar;
var
  sUserName,
  sHostName,
  sIPaddr,
  sMacAddr,
  sevento : String;
  i,y : Integer;
//  DatosOk : Boolean;
begin

   sevento := saccion;
   //SS 29-09-2022 Default sevento
   sevento := Array_Reg_Mod[1].Descr_Campo;
   
//   PERFIL
   if copy(Array_Reg_Mod[1].Descr_Campo,1,12) = 'Ejecuta para' then
       sevento := 'MODIFICA Opciones para Perfil';

   if (Array_Reg_Mod[1].Descr_Campo) = 'Codigo Perfil AGR' then
      sevento := 'CREACION PERFIL '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Codigo Perfil UPD' then
         sevento := 'MODIFICACION PERFIL '+ Array_Reg_Mod[1].Campo;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Codigo Perfil DEL' then
       sevento := 'ELIMINACION PERFIL '+ Array_Reg_Mod[1].Campo;

//   LOGIN
   if (Array_Reg_Mod[1].Descr_Campo) = 'Login AGR' then
      sevento := 'CREACION USUARIO '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Login UPD' then
//      if Array_Reg_Mod[11].Descr_Campo = 'Fecha Expiracion' then
//         if Array_Reg_Mod[11].Valor_antes <> Array_Reg_Mod[11].Valor_despues then
//            sevento := 'MODIFICACION, FECHA DE EXPIRACION '+ Array_Reg_Mod[1].Campo
//      else
         sevento := 'MODIFICACION, LOGIN '+ Array_Reg_Mod[1].Campo;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Login DEL' then
       sevento := 'ELIMINACION USUARIO '+ Array_Reg_Mod[1].Campo;

////  Opciones Menu
   if (Array_Reg_Mod[1].Descr_Campo) = 'Ejecuta ' then
       sevento :=  'MOD. OPCIONES DE MENU';

//   DESCRIPTOR

   if (Array_Reg_Mod[1].Descr_Campo) = 'DESCRIPTOR AGR' then
      sevento := 'CREACION DESCRIPTOR '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'DESCRIPTOR UPD' then
         sevento := 'MODIFICACION DESCRIPTOR '+ Array_Reg_Mod[1].Campo;

   if (Array_Reg_Mod[1].Descr_Campo) = 'DESCRIPTOR DEL' then
       sevento := 'ELIMINACION DESCRIPTOR '+ Array_Reg_Mod[1].Campo;

   if (Array_Reg_Mod[1].Descr_Campo) = 'TABLA DE DESARROLLO UPD' then
         sevento := 'MODIFICACION TABLA DESARROLLO ';

   if (Array_Reg_Mod[1].Descr_Campo) = 'TABLA DE DESARR MULTIPLE TASA UPD' then
         sevento := 'TABLA DE DESARR MULTIPLE TASA';

   if (Array_Reg_Mod[1].Descr_Campo) = 'TABLA DE DESARROLLO AGR' then
         sevento := 'INGRESO TABLA DESARROLLO ';

   if (Array_Reg_Mod[1].Descr_Campo) = 'TABLA DE DESARR MULTIPLE TASA AGR' then
         sevento := 'TABLA DE DESARR MULTIPLE TASA';

// Carga de Valores y Precios RV    SS 31-03-2023
   if (Array_Reg_Mod[1].Descr_Campo) = 'Actualiza precio RV' then
         sevento := 'Carga Precios RV: '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Agrega precio RV' then
         sevento := 'Carga Precios RV: '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Agrega Valores' then
         sevento := 'Carga Valores para: '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Modifica valores' then
         sevento := 'Carga Valores para: '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Inserta valores TC' then
         sevento := 'Carga Valores para: '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Elimina precio RV' then
         sevento := 'Carga Precios RV: '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Modifica precio RV' then
         sevento := 'Carga Precios RV: '+ Array_Reg_Mod[1].Valor_despues;

   if (Array_Reg_Mod[1].Descr_Campo) = 'Copia precio RV' then
         sevento := 'Carga Precios RV: '+ Array_Reg_Mod[1].Valor_despues;

/// SE INHIBIO POR AHORA ES PARA TODAS LAS COMPAÑIAS  DC 23/09/2022
//   With FrmRegistro_Log.Qry_General_Frm do
//   begin
//     Close;
//     Sql.Clear;
//     sql.add('SELECT * FROM QS_SYS_PARAM_PROCESO ');
//     sql.add(' WHERE proceso = ''REGISTRO'' ');
//     Open;
//
//     if NOT FrmRegistro_Log.Qry_General_Frm.FieldByName('Valor').IsNull then
//     begin
      //Info_Conexion(sUserName, sHostName, sIPaddr, sMacAddr);
      //Se reemplaza por funcion compatible a XE5 para los distintos Windows.

//      DatosOk :=
      GetMachineInfo(sHostName, sUserName, sIPaddr, sMacAddr);

        if NOT (dmBaseDatos.Conexion_BaseDatos.inTransaction) then
           dmBaseDatos.Conexion_BaseDatos.StartTransaction;

        With FrmRegistro_Log.Qry_inserta do
        begin
          Close;
          Sql.Clear;
          sql.add('INSERT INTO QS_SYS_LOG ');
          sql.add('( ');
          sql.add(' Pid ');
          sql.add(',Fecha_hora ');
          sql.add(',Proceso ');
          sql.add(',Usuario_PMS ');
          sql.add(',Perfil_PMS ');
          sql.add(',Usuario_WIN ');
          sql.add(',Nombre_MAQ ');
          sql.add(',Direccion_IP ');
          sql.add(',MAC ');
          sql.add(',Tipo ');
          sql.add(',Evento ');
          sql.add(') ');
          sql.add(' VALUES ');
          sql.add('( ');
          sql.add('  :Pid ');
          sql.add(' ,:Fecha_hora ');
          sql.add(' ,:Proceso ');
          sql.add(' ,:Usuario_PMS ');
          sql.add(' ,:Perfil_PMS ');
          sql.add(' ,:Usuario_WIN ');
          sql.add(' ,:Nombre_MAQ ');
          sql.add(' ,:Direccion_IP ');
          sql.add(' ,:MAC ');
          sql.add(' ,:Tipo ');
          sql.add(' ,:Evento ');
          sql.add(') ');

          ParamByName('Pid').AsFloat           := fPid;
          ParamByName('Fecha_hora').AsDatetime := dfecha_hora;
          ParamByName('Proceso').AsString      := sPrograma;
          ParamByName('Usuario_PMS').AsString  := sLogin_Sistema;
          ParamByName('Perfil_PMS').AsString   := sperfil_usuario;
          ParamByName('Usuario_WIN').AsString  := sUserName;
          ParamByName('Nombre_MAQ').AsString   := sHostName;
          ParamByName('Direccion_IP').AsString := sIPaddr;
          ParamByName('MAC').AsString          := sMacAddr;
          ParamByName('Tipo').AsString         := 'R';
          ParamByName('Evento').AsString       := copy(trim(sEvento),1,100);

          try
            ExecSql;
          except on E:EFDDBEngineException do
            begin
               ShowError(E);
               Close;
               if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                 dmBaseDatos.Conexion_BaseDatos.Rollback;
               Exit;
            end;
          end;
          Close;
        end;

        With FrmRegistro_Log.Qry_inserta_det do
        begin
          i := 1;
          y := 1;
          while trim(Array_Reg_Mod[i].Descr_Campo) <> '' do
          begin
             if Array_Reg_Mod[i].Valor_antes <> Array_Reg_Mod[i].Valor_despues then
             begin
                Close;
                Sql.Clear;
                sql.add('INSERT INTO QS_SYS_REGISTRO_DET ');
                sql.add('( ');
                sql.add(' Pid ');
                sql.add(',Fecha_hora ');
                sql.add(',Item ');
                sql.add(',Campo ');
                sql.add(',Descr_Campo ');
                sql.add(',Valor_Antes ');
                sql.add(',Valor_Despues ');
                sql.add(') ');
                sql.add(' VALUES ');
                sql.add('( ');
                sql.add('  :pPid ');
                sql.add(' ,:pFecha_hora ');
                sql.add(' ,:pItem ');
                sql.add(' ,:pCampo ');
                sql.add(' ,:pDescr_Campo ');
                sql.add(' ,:pValor_Antes ');
                sql.add(' ,:pValor_Despues ');
                sql.add(') ');

                ParamByName('pPid').AsFloat            := Array_Reg_Mod[i].Pid;
                ParamByName('pFecha_hora').AsDatetime  := Array_Reg_Mod[i].Fecha_hora;
                ParamByName('pItem').AsInteger         := y;
                ParamByName('pCampo').AsString         := copy(Array_Reg_Mod[i].Campo,1,60);
                ParamByName('pDescr_Campo').AsString   := copy(Array_Reg_Mod[i].Descr_Campo,1,60);
                if (Array_Reg_Mod[i].Descr_Campo = 'Password Sistema') or (Array_Reg_Mod[i].Descr_Campo = 'Password Servidor') then
                begin
                  ParamByName('pValor_Antes').AsString   := '*******';
                  ParamByName('pValor_Despues').AsString := '*********';
                end
                else
                begin
                  ParamByName('pValor_Antes').AsString   := Array_Reg_Mod[i].Valor_antes;
                  ParamByName('pValor_Despues').AsString := Array_Reg_Mod[i].Valor_despues;
                end;

                y := y + 1;

                try
                  ExecSql;
                except on E:EFDDBEngineException do
                  begin
                    ShowError(E);
                    Close;
                    if dmBaseDatos.Conexion_BaseDatos.inTransaction then
                      dmBaseDatos.Conexion_BaseDatos.Rollback;
                    Exit;
                  end;
                end;
                Close;
             end;
             i := i + 1;
          end;
        end;

        if dmBaseDatos.Conexion_BaseDatos.inTransaction then
           dmBaseDatos.Conexion_BaseDatos.Commit;

/// SE INHIBIO POR AHORA ES PARA TODAS LAS COMPAÑIAS  DC 23/09/2022
//     end;
//   end;
end;

procedure actualiza_RegMod;
var i : Integer;
begin

  i := 1;
  while trim(Array_Reg_Mod[i].Descr_Campo) <> '' do
  begin
     if Array_Reg_Mod[i].Valor_antes <> Array_Reg_Mod[i].Valor_despues then
        Array_Reg_Mod[i].Valor_antes := Array_Reg_Mod[i].Valor_despues;
     i := i + 1;
  end;

end;

procedure llenar_log(descripcion  : String;
                     sTransaccion : String;
                     sFolio       : String;
                     bTransaccion : Boolean);
var i : Integer;
begin
   fPid        := Application.Handle;
   sPrograma   := 'MD - Transacciones '+sTransaccion;
   dfecha_hora := Fecha_Hora_Servidor;

   i := 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;
   Array_Reg_Log[i].Campo      := descripcion;
   Array_Reg_Log[i].Valor      := sTransaccion+', '+sFolio;
   inserta_Log(bTransaccion);

end;

procedure llenar_log2(sOpcion_Menu : String;
                      descripcion  : String;
                      sTransaccion : String;
                      sFolio       : String;
                      bTransaccion : Boolean);
var i : Integer;
begin
   fPid        := Application.Handle;
   sPrograma   := sOpcion_Menu;
   dfecha_hora := Fecha_Hora_Servidor;

   i := 1;
   Array_Reg_Log[i].Pid        := fPid;
   Array_Reg_Log[i].Fecha_hora := dfecha_hora;
   Array_Reg_Log[i].Campo      := descripcion;
   Array_Reg_Log[i].Valor      := sTransaccion+', '+sFolio;
   inserta_Log(bTransaccion);

end;

procedure Graba_Log_GAAP(sProceso_Market   : String;
                         sD_Part1          : String;
                         sD_Part3          : String;
                         sD_Part4          : String;
                         sD_Part5          : String;
                         sDA_Part1         : String;
                         sDA_Part3         : String;
                         sDA_Part4         : String;
                         sDA_Part5         : String;
                         sTipo_Conversion  : String;
                         dFecha_Cierre     : TDateTime;
                         dFecha_Cierre_Ant : TDateTime;
                         dFecha_Inicio_Ant : TDateTime);
begin

 if NOT (dmBaseDatos.Conexion_BaseDatos.inTransaction) then
   dmBaseDatos.Conexion_BaseDatos.StartTransaction;
 //Elimino registros en caso de existir
 With FrmRegistro_Log.Qry_inserta_det do
 begin
  Close;
  Sql.Clear;
  Sql.Add('DELETE FROM QS_SYS_LOG_GAAP '
         +' WHERE EMPRESA        = :Empresa '
         +' AND PROCESO_MARKET   = :Proceso '
         +' AND FECHA_CIERRE     = :Fecha_Cierre '
         +' AND FECHA_CIERRE_ANT = :Fecha_Cierre_Ant '
         +' AND FECHA_INICIO_ANT = :Fecha_Inicio_Ant ');

  ParamByName('Empresa').AsString            := sEmpresa_usuario;
  ParamByName('Proceso').AsString            := sProceso_Market;
  ParamByName('Fecha_Cierre').AsDatetime     := dFecha_Cierre;
  ParamByName('Fecha_Cierre_Ant').AsDatetime := dFecha_Cierre_Ant;
  ParamByName('Fecha_Inicio_Ant').AsDatetime := dFecha_Inicio_Ant;

  try
    ExecSql;
  except on E:EFDDBEngineException do
    begin
      ShowError(E);
      Close;
      if dmBaseDatos.Conexion_BaseDatos.inTransaction then
        dmBaseDatos.Conexion_BaseDatos.Rollback;
      Exit;
    end;
  end;
  Close;
 end;
 //Inserto registros
 With FrmRegistro_Log.Qry_inserta_det do
 begin
  Close;
  Sql.Clear;
  Sql.Add(' INSERT INTO QS_SYS_LOG_GAAP VALUES ('
         +' :EMPRESA,'
         +' :PROCESO_MARKET,'
         +' :D_PART1,'
         +' :D_PART3,'
         +' :D_PART4,'
         +' :D_PART5,'
         +' :DA_PART1,'
         +' :DA_PART3,'
         +' :DA_PART4,'
         +' :DA_PART5,'
         +' :TIPO_CONVERSION,'
         +' :FECHA_LOG,'
         +' :FECHA_CIERRE,'
         +' :FECHA_CIERRE_ANT,'
         +' :FECHA_INICIO_ANT)');

  ParamByName('EMPRESA').AsString            := sEmpresa_usuario;
  ParamByName('PROCESO_MARKET').AsString     := sProceso_Market;
  ParamByName('D_PART1').AsString            := sD_Part1;
  ParamByName('D_PART3').AsString            := sD_Part3;
  ParamByName('D_PART4').AsString            := sD_Part4;
  ParamByName('D_PART5').AsString            := sD_Part5;
  ParamByName('DA_PART1').AsString           := sDA_Part1;
  ParamByName('DA_PART3').AsString           := sDA_Part3;
  ParamByName('DA_PART4').AsString           := sDA_Part4;
  ParamByName('DA_PART5').AsString           := sDA_Part5;
  ParamByName('TIPO_CONVERSION').AsString    := sTipo_Conversion;
  ParamByName('FECHA_LOG').AsDatetime        := Fecha_Hora_Servidor;
  ParamByName('Fecha_Cierre').AsDatetime     := dFecha_Cierre;
  ParamByName('Fecha_Cierre_Ant').AsDatetime := dFecha_Cierre_Ant;
  ParamByName('Fecha_Inicio_Ant').AsDatetime := dFecha_Inicio_Ant;

  try
    ExecSql;
  except on E:EFDDBEngineException do
    begin
      ShowError(E);
      Close;
      if dmBaseDatos.Conexion_BaseDatos.inTransaction then
        dmBaseDatos.Conexion_BaseDatos.Rollback;
      Exit;
    end;
  end;
  Close;
 end;

 if dmBaseDatos.Conexion_BaseDatos.inTransaction then
    dmBaseDatos.Conexion_BaseDatos.Commit;
end;

end.
