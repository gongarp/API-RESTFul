program API_Form;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DataSnapForm in 'DataSnapForm.pas' {Frm_ServidorDataSnapForm},
  MetodosServidor in 'MetodosServidor.pas' {ServerMethods1: TDataModule},
  MetodosServidor2 in 'MetodosServidor2.pas' {ServerMethods2: TDataModule},
  ServidorDataSnap in 'ServidorDataSnap.pas' {WebModule1: TWebModule},
  DM_Variables_Valorizacion in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\DM_Variables_Valorizacion.pas',
  DM_Variables_Menu in '..\DM_Modulos_comunes\DM_Variables_Menu.pas',
  DM_Valorizacion in '..\Transacciones\Valorizacion Stock\DM_Valorizacion.pas' {DMValorizacion: TDataModule},
  DM_Base_Datos in '..\DM_Modulos_comunes\DM_Base_Datos.pas' {dmBaseDatos: TDataModule},
  DM_FuncionesMemory in '..\DM_Modulos_comunes\DM_FuncionesMemory.pas' {DMFuncionesMemory: TDataModule},
  DM_Global_Var in '..\DM_Modulos_comunes\DM_Global_Var.pas',
  DM_Comun in '..\DM_Modulos_comunes\DM_Comun.pas' {DataModule_Comun: TDataModule},
  DM_Paises in '..\DM_Modulos_comunes\DM Ayudas\DM_Paises.pas' {dmPaises: TDataModule},
  DM_Encripta in '..\DM_Modulos_comunes\DM_Encripta.pas',
  MensajesDialog in '..\DM_Modulos_comunes\MensajesDialog.pas',
  DMLeer_valor_Cambio in '..\DM_Modulos_comunes\DMLeer_valor_Cambio.pas' {DM_Leer_Valor_Cambio: TDataModule},
  DM_ComunInversiones in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\DM_ComunInversiones.pas' {dmComunInversiones: TDataModule},
  DM_Codigos_generales in '..\DM_Modulos_comunes\DM Ayudas\DM_Codigos_generales.pas' {dmCodigos_Generales: TDataModule},
  DM_Identidad_Direccion in '..\DM_Modulos_comunes\DM Ayudas\DM_Identidad_Direccion.pas' {dmIdentidad_Direccion: TDataModule},
  Dateutil in '..\DM_Modulos_comunes\Dateutil.pas',
  DM_Ayuda_Nemotecnicos in '..\DM_Modulos_comunes\DM Ayudas\DM_Ayuda_Nemotecnicos.pas' {dmAyuda_Nemotecnicos: TDataModule},
  Frm_Aprueba_Limites in '..\Transacciones\Mantenedor Transacciones\Frm_Aprueba_Limites.pas' {FrmApruebaLimites},
  Tabla_Mem_Desarr_TFija in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\Tabla_Mem_Desarr_TFija.pas' {DM_Tabla_Mem_Desarr_TFija: TDataModule},
  DM_Excepcion_Calculos in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\DM_Excepcion_Calculos.pas' {dmManejaExcepcion: TDataModule},
  Funciones_Valorizacion in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\Funciones_Valorizacion.pas' {dmFunciones_Valorizacion: TDataModule},
  Valoriza_General in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\Valoriza_General.pas',
  Rutinas_Informes in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\Rutinas_Informes.pas' {DM_Rutinas_Informes: TDataModule},
  DM_Ayuda_Monedas in '..\DM_Modulos_comunes\DM Ayudas\DM_Ayuda_Monedas.pas' {DMAyuda_Monedas: TDataModule},
  DM_Carteras in '..\DM_Modulos_comunes\DM Ayudas\DM_Carteras.pas' {dmCarteras: TDataModule},
  Muestra_Mensaje in '..\DM_Modulos_comunes\Muestra_Mensaje.pas' {MuestraMensaje},
  FrmConsolidaEmp in '..\MASTER\informes\FrmConsolidaEmp.pas' {FrmConsolidaEmpresa},
  DM_Comun_Gestion in '..\DM_Modulos_comunes\Modulos Comunes Inversiones\DM_Comun_Gestion.pas' {Dm_Comun_Gestion_F: TDataModule},
  Frm_SeleccionDatos in '..\Transacciones\Valorizacion Stock\Frm_SeleccionDatos.pas' {FrmSeleccionDatos},
  Mensajes_Procesos in '..\DM_Modulos_comunes\Mensajes_Procesos.pas' {FrmMensajesProcesos},
  Registro_Log in '..\Varios\Identificacion Equipo\Registro_Log.pas' {FrmRegistro_Log},
  uSystemInfo in '..\DM_Modulos_comunes\uSystemInfo.pas',
  Finaliza_Valorizacion in '..\DM_Modulos_comunes\Finaliza_Valorizacion.pas' {Frm_FinalizaValorizacion},
  DM_Ayuda_Tipo_Empresas in '..\DM_Modulos_comunes\DM Ayudas\DM_Ayuda_Tipo_Empresas.pas' {dmAyuda_Tipo_Empresa: TDataModule},
  DM_Clasif_Riesgo in '..\DM_Modulos_comunes\DM Ayudas\DM_Clasif_Riesgo.pas' {DM_Clasificacion_Riesgo: TDataModule},
  DM_Ayuda_Custodios in '..\DM_Modulos_comunes\DM Ayudas\DM_Ayuda_Custodios.pas' {dmAyuda_Custodios: TDataModule},
  NB in '..\Varios\Identificacion Equipo\NB.PAS',
  Frm_CalculoLimites in '..\Superintendencia\Circular 251\Frm_CalculoLimites.pas' {FrmCalculoLimites},
  DM_Ayuda_Clasificacion in '..\DM_Modulos_comunes\DM Ayudas\DM_Ayuda_Clasificacion.pas' {DMAyuda_Clasificacion: TDataModule},
  DM_Margenes_Legales in '..\Mantencion de Tablas\Margenes\DM_Margenes_Legales.pas' {DM_Margenes: TDataModule},
  DM_Holding_Empresas in '..\DM_Modulos_comunes\DM_Holding_Empresas.pas' {DM_Holding: TDataModule},
  JD_Tools in '..\DM_Modulos_comunes\JD_Tools.pas',
  Frm_DatosLimites in '..\Superintendencia\Circular 251\Frm_DatosLimites.pas' {FrmDatosLimites},
  RPreview in '..\DM_Modulos_comunes\Previews\RPreview.pas' {FrmRPreview},
  ConsultaGeneracionExcel in '..\DM_Modulos_comunes\Previews\ConsultaGeneracionExcel.pas' {frmConsultaGeneraExcel},
  Frm_ReportLimites in '..\Superintendencia\Circular 251\Frm_ReportLimites.pas' {FrmReportLimites},
  Frm_ReportLimitesDetalle in '..\Superintendencia\Circular 251\Frm_ReportLimitesDetalle.pas' {FrmReportLimitesDetalle},
  Frm_ReportPorEmisorInstrumentoSeries in '..\Superintendencia\Circular 251\Frm_ReportPorEmisorInstrumentoSeries.pas' {FrmReportPorEmisorInstrumentoSeries},
  Frm_ReportPorEmisorInstrumento in '..\Superintendencia\Circular 251\Frm_ReportPorEmisorInstrumento.pas' {FrmReportPorEmisorInstrumento},
  Frm_ReportLimitesGrupo in '..\Superintendencia\Circular 251\Frm_ReportLimitesGrupo.pas' {FrmReportLimitesGrupo},
  Frm_ReportPorGrupo in '..\Superintendencia\Circular 251\Frm_ReportPorGrupo.pas' {FrmReportPorGrupo},
  FRM_ReportErrores in '..\Informes_Zurich\FRM_ReportErrores.pas' {FrmReportErrores},
  Frm_AyudaMARS in '..\Informes_Zurich\Mars_CNT16\Frm_AyudaMARS.pas' {FrmAyudaMARS},
  Rutinas_CalculoLimites in '..\Superintendencia\Circular 251\Rutinas_CalculoLimites.pas' {DM_Rutinas_CalculoLimites: TDataModule},
  DM_Threadvar in '..\DM_Modulos_comunes\DM_Threadvar.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
     WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFrm_ServidorDataSnapForm, Frm_ServidorDataSnapForm);
  Application.CreateForm(TDataModule_Comun, DataModule_Comun);
  Application.CreateForm(TdmComunInversiones, dmComunInversiones);
  Application.CreateForm(TFrmReportErrores, FrmReportErrores);
  Application.CreateForm(TDMValorizacion, DMValorizacion);
  Application.CreateForm(TdmAyuda_Tipo_Empresa, dmAyuda_Tipo_Empresa);
  Application.CreateForm(TDMFuncionesMemory, DMFuncionesMemory);
  Application.CreateForm(TdmPaises, dmPaises);
  Application.CreateForm(TDM_Leer_Valor_Cambio, DM_Leer_Valor_Cambio);
  Application.CreateForm(TdmCodigos_Generales, dmCodigos_Generales);
  Application.CreateForm(TdmIdentidad_Direccion, dmIdentidad_Direccion);
  Application.CreateForm(TdmAyuda_Nemotecnicos, dmAyuda_Nemotecnicos);
  Application.CreateForm(TDM_Tabla_Mem_Desarr_TFija, DM_Tabla_Mem_Desarr_TFija);
  Application.CreateForm(TdmManejaExcepcion, dmManejaExcepcion);
  Application.CreateForm(TdmFunciones_Valorizacion, dmFunciones_Valorizacion);
  Application.CreateForm(TDM_Rutinas_Informes, DM_Rutinas_Informes);
  Application.CreateForm(TDMAyuda_Monedas, DMAyuda_Monedas);
  Application.CreateForm(TdmCarteras, dmCarteras);
  Application.CreateForm(TDm_Comun_Gestion_F, Dm_Comun_Gestion_F);
  Application.CreateForm(TFrmRegistro_Log, FrmRegistro_Log);
  Application.CreateForm(TDM_Clasificacion_Riesgo, DM_Clasificacion_Riesgo);
  Application.CreateForm(TdmAyuda_Custodios, dmAyuda_Custodios);
  Application.CreateForm(TDMAyuda_Clasificacion, DMAyuda_Clasificacion);
  Application.CreateForm(TDM_Margenes, DM_Margenes);
  Application.CreateForm(TDM_Holding, DM_Holding);
  Application.CreateForm(TDM_Rutinas_CalculoLimites, DM_Rutinas_CalculoLimites);
  Application.Run;
end.
