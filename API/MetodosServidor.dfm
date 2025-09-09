object ServerMethods1: TServerMethods1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  PixelsPerInch = 96
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 80
    Top = 40
  end
  object Qry_General: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'select *'
      'from qs_sys_identidad')
    Left = 80
    Top = 136
  end
  object Qry_General2: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'select *'
      'from qs_sys_identidad')
    Left = 208
    Top = 144
  end
end
