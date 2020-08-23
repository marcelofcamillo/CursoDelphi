object dtmGrafico: TdtmGrafico
  OldCreateOrder = False
  Height = 271
  Width = 500
  object dtsProdutoEstoque: TDataSource
    DataSet = qryProdutoEstoque
    Left = 135
    Top = 16
  end
  object qryProdutoEstoque: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT CONVERT(VARCHAR, produtoId) + '#39' - '#39' + nome AS Label, Quan' +
        'tidade AS Value FROM produtos;')
    Params = <>
    Left = 39
    Top = 16
  end
  object qryVendaValorPorCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT CONVERT(VARCHAR, vendas.clienteId) + '#39' - '#39' + clientes.nom' +
        'e AS Label, SUM(vendas.totalVenda) AS Value'
      
        'FROM vendas INNER JOIN clientes ON clientes.clienteId = vendas.c' +
        'lienteId WHERE vendas.dataVenda'
      
        'BETWEEN CONVERT(DATE, GETDATE()-7) AND CONVERT(DATE, GETDATE()) ' +
        'GROUP BY vendas.clienteId, clientes.nome')
    Params = <>
    Left = 248
    Top = 16
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
  object qry10ProdutosMaisVendidos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT TOP 10 CONVERT(VARCHAR, vi.produtoId) + '#39' - '#39' + p.nome AS' +
        ' Label, SUM(vi.totalProduto) AS Value'
      
        'FROM vendasItens AS vi INNER JOIN produtos AS p ON p.produtoId =' +
        ' vi.produtoId GROUP BY vi.produtoId, p.nome'
      'ORDER BY Label DESC')
    Params = <>
    Left = 56
    Top = 80
    object qry10ProdutosMaisVendidosLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object qry10ProdutosMaisVendidosValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
  object qryVendasUltimaSemana: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT vendas.dataVenda AS Label, SUM(vendas.totalVenda) AS Valu' +
        'e FROM vendas WHERE vendas.dataVenda BETWEEN '
      
        'CONVERT(DATE, GETDATE()-7) AND CONVERT(DATE, GETDATE()) GROUP BY' +
        ' vendas.dataVenda;')
    Params = <>
    Left = 184
    Top = 80
    object qryVendasUltimaSemanaLabel: TDateTimeField
      FieldName = 'Label'
      Required = True
    end
    object qryVendasUltimaSemanaValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
end
