object dtmGrafico: TdtmGrafico
  OldCreateOrder = False
  Height = 218
  Width = 321
  object dtsProdutoEstoque: TDataSource
    DataSet = qryProdutoEstoque
    Left = 207
    Top = 56
  end
  object qryProdutoEstoque: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT CONVERT(VARCHAR, produtoId) + '#39' - '#39' + nome AS Label, Quan' +
        'tidade AS Value FROM produtos;')
    Params = <>
    Left = 95
    Top = 56
  end
  object qryVendaValorPorCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT CONVERT(VARCHAR, vendas.clienteId) + '#39' - '#39' + clientes.nom' +
        'e AS Label, SUM(vendas.totalVenda) AS Value'
      
        'FROM vendas INNER JOIN clientes ON clientes.clienteId = vendas.c' +
        'lienteId WHERE vendas.dataVenda'
      
        'BETWEEN CONVERT(DATE, GETDATE()-7) AND CONVERT(DATE, GETDATE()) ' +
        'GROUP BY vendas.clienteId, clientes.nome')
    Params = <>
    Left = 80
    Top = 120
    object qryVendaValorPorClienteLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object qryVendaValorPorClienteValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
end
