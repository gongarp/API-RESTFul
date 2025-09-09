object ServerMethods2: TServerMethods2
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
  object Qry_Estado: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'select *'
      'from qs_sys_identidad')
    Left = 192
    Top = 136
  end
end
