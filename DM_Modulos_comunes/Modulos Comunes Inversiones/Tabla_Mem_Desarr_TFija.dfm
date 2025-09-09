object DM_Tabla_Mem_Desarr_TFija: TDM_Tabla_Mem_Desarr_TFija
  Height = 364
  Width = 634
  PixelsPerInch = 96
  object Qry_Tabla_Desarr_Prdx: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand]
    ResourceOptions.MacroCreate = False
    ResourceOptions.MacroExpand = False
    Left = 440
    Top = 26
  end
  object FDLocalSQL1: TFDLocalSQL
    Connection = FDConnection1
    Active = True
    DataSets = <>
    Left = 392
    Top = 168
  end
  object Table_FutImplicit: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    LocalSQL = FDLocalSQL1
    Left = 392
    Top = 104
    object Table_FutImplicitItem: TFloatField
      FieldName = 'Item'
    end
    object Table_FutImplicitDias_Desde: TFloatField
      FieldName = 'Dias_Desde'
    end
    object Table_FutImplicitDias_Hasta: TFloatField
      FieldName = 'Dias_Hasta'
    end
    object Table_FutImplicitValor: TFloatField
      FieldName = 'Valor'
    end
    object Table_FutImplicitValor_Implicito: TFloatField
      FieldName = 'Valor_Implicito'
    end
    object Table_FutImplicitBase_Porcentual: TFloatField
      FieldName = 'Base_Porcentual'
    end
  end
  object Table_Ult_Tasa: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Codigo_Tasa'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Fecha_Calculo'
        DataType = ftDateTime
      end
      item
        Name = 'ValorTasa'
        DataType = ftFloat
      end
      item
        Name = 'Fecha_Inic_Periodo'
        DataType = ftDateTime
      end
      item
        Name = 'Fecha_Vcto_Periodo'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    LocalSQL = FDLocalSQL1
    StoreDefs = True
    Left = 280
    Top = 104
    object Table_Ult_TasaCodigo_Tasa: TStringField
      FieldName = 'Codigo_Tasa'
      Size = 10
    end
    object Table_Ult_TasaFecha_Calculo: TDateTimeField
      FieldName = 'Fecha_Calculo'
    end
    object Table_Ult_TasaValorTasa: TFloatField
      FieldName = 'ValorTasa'
    end
    object Table_Ult_TasaFecha_Inic_Periodo: TDateTimeField
      FieldName = 'Fecha_Inic_Periodo'
    end
    object Table_Ult_TasaFecha_Vcto_Periodo: TDateTimeField
      FieldName = 'Fecha_Vcto_Periodo'
    end
  end
  object Qry_Tabla_Desarr: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand]
    ResourceOptions.MacroCreate = False
    ResourceOptions.MacroExpand = False
    SQL.Strings = (
      'SELECT Numero_de_Cupon'
      '              ,Interes_Cupon'
      '              ,Amortiz_Cupon'
      '             ,Saldo_Insol_Cupon'
      '   FROM QS_FIN_DESARR'
      ' WHERE Serie = :Serie'
      '       AND Codigo_Instrumento = :Codigo_Instrumento'
      '       AND Codigo_Emisor = :Codigo_Emisor'
      '  ORDER By Numero_de_Cupon')
    Left = 96
    Top = 122
    ParamData = <
      item
        Name = 'SERIE'
        ParamType = ptInput
      end
      item
        Name = 'CODIGO_INSTRUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'CODIGO_EMISOR'
        ParamType = ptInput
      end>
  end
  object Query1: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand]
    ResourceOptions.MacroCreate = False
    ResourceOptions.MacroExpand = False
    Left = 88
    Top = 50
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 288
    Top = 168
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 168
    Top = 176
  end
  object Qry_Carga_mem_desarr_TFlot: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand]
    ResourceOptions.MacroCreate = False
    ResourceOptions.MacroExpand = False
    SQL.Strings = (
      'SELECT Cupon_Desde                    '
      '      ,Cupon_Hasta                     '
      '      ,Tipo_Tasa                       '
      '      ,Tratamiento                     '
      '      ,Operacion                       '
      '      ,Factor                          '
      '      ,Amortizacion                    '
      '      ,Factor_Cap                      '
      '  FROM QS_FIN_DEF_DESFLOT              '
      ' WHERE Serie              = :xSerie    '
      '   AND Codigo_Instrumento = :Instrumento'
      '   AND Codigo_Identidad   = :Emisor    '
      ' ORDER BY Cupon_Desde')
    Left = 200
    Top = 10
    ParamData = <
      item
        Name = 'XSERIE'
        ParamType = ptInput
      end
      item
        Name = 'INSTRUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'EMISOR'
        ParamType = ptInput
      end>
  end
  object Qry_carga_Mem_Desarr_TFija: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'SELECT Numero_de_Cupon'
      '      ,Interes_Cupon   '
      '      ,Amortiz_Cupon   '
      '      ,Saldo_Insol_Cupon '
      '  FROM QS_FIN_DESARR     '
      ' WHERE Serie = :Serie     '
      '   AND Codigo_Instrumento = :Codigo_Instrumento '
      '   AND Codigo_Emisor = :Codigo_Emisor           '
      'ORDER By Numero_de_Cupon')
    Left = 204
    Top = 66
    ParamData = <
      item
        Name = 'SERIE'
        ParamType = ptInput
      end
      item
        Name = 'CODIGO_INSTRUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'CODIGO_EMISOR'
        ParamType = ptInput
      end>
  end
  object Qry_NemFechas: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand]
    ResourceOptions.MacroCreate = False
    ResourceOptions.MacroExpand = False
    SQL.Strings = (
      'SELECT  Nro_Cupon '
      '       ,Fecha_Vencimiento'
      ' FROM QS_FIN_Nem_Fechas '
      ' WHERE Codigo_Nemotecnico = :Nemotecnico')
    Left = 444
    Top = 149
    ParamData = <
      item
        Name = 'NEMOTECNICO'
        ParamType = ptInput
      end>
  end
  object Qry_Max_Fija: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'SELECT MAX(NUMERO_DE_CUPON) as Ultimo_Cupon'
      'from QS_FIN_DESARR '
      'WHERE SERIE = :SERIE '
      'AND CODIGO_INSTRUMENTO = :INSTRUMENTO '
      'AND CODIGO_EMISOR = :EMISOR ')
    Left = 20
    Top = 106
    ParamData = <
      item
        Name = 'SERIE'
        ParamType = ptInput
      end
      item
        Name = 'INSTRUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'EMISOR'
        ParamType = ptInput
      end>
  end
  object Qry_Max_Flotante: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'select MAX(CUPON_HASTA) as Ultimo_Cupon '
      'from QS_FIN_DEF_DESFLOT '
      'WHERE SERIE = :SERIE '
      'AND CODIGO_INSTRUMENTO = :INSTRUMENTO '
      'AND CODIGO_IDENTIDAD = :EMISOR ')
    Left = 20
    Top = 178
    ParamData = <
      item
        Name = 'SERIE'
        ParamType = ptInput
      end
      item
        Name = 'INSTRUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'EMISOR'
        ParamType = ptInput
      end>
  end
  object Qry_TasaBaseVar: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'SELECT Cod_Tasa_base                            '
      '  FROM QS_FIN_TASA_BASE_VARIABLE '
      ' WHERE Cod_Tasa_Base = :Tasa_Base '
      '   AND  Fecha_Desde  <= :Fecha '
      '   AND (Fecha_Hasta IS NULL OR Fecha_Hasta >= :Fecha)')
    Left = 456
    Top = 88
    ParamData = <
      item
        Name = 'TASA_BASE'
        ParamType = ptInput
      end
      item
        Name = 'FECHA'
        ParamType = ptInput
      end>
  end
  object Qry_Max_Prepago: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand]
    ResourceOptions.MacroCreate = False
    ResourceOptions.MacroExpand = False
    SQL.Strings = (
      'SELECT MAX(NUMERO_DE_CUPON) as Ultimo_Cupon'
      'from QS_FIN_DESARR_PREPAG'
      'WHERE SERIE = :SERIE '
      'AND CODIGO_INSTRUMENTO = :INSTRUMENTO '
      'AND CODIGO_EMISOR = :EMISOR ')
    Left = 144
    Top = 234
    ParamData = <
      item
        Name = 'SERIE'
        ParamType = ptInput
      end
      item
        Name = 'INSTRUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'EMISOR'
        ParamType = ptInput
      end>
  end
  object Qry_Max_Fija_Vig: TFDQuery
    Connection = dmBaseDatos.Conexion_BaseDatos
    SQL.Strings = (
      'SELECT MAX(NUMERO_DE_CUPON) as Ultimo_Cupon'
      'from QS_FIN_DESARR '
      'WHERE SERIE = :SERIE '
      'AND CODIGO_INSTRUMENTO = :INSTRUMENTO '
      'AND CODIGO_EMISOR = :EMISOR'
      'AND FECHA_VIG <= :FECHA_VIG')
    Left = 258
    Top = 251
    ParamData = <
      item
        Name = 'SERIE'
        ParamType = ptInput
      end
      item
        Name = 'INSTRUMENTO'
        ParamType = ptInput
      end
      item
        Name = 'EMISOR'
        ParamType = ptInput
      end
      item
        Name = 'FECHA_VIG'
        ParamType = ptInput
      end>
  end
end
