object dtmVenda: TdtmVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 200
  Width = 335
  object qryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT clienteId, nome FROM clientes')
    Params = <>
    Left = 64
    Top = 40
    object qryClienteclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object qryClientenome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
  end
  object qryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT produtoId, nome, valor, quantidade FROM produtos')
    Params = <>
    Left = 136
    Top = 40
    object qryProdutosprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object qryProdutosnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object qryProdutosvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object qryProdutosquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 40
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object cdsItensVendanomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'nomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorUnitario'
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Valor Total Produto'
      FieldName = 'valorTotalProduto'
    end
    object cdsItensVendavalorTotalVenda: TAggregateField
      FieldName = 'valorTotalVenda'
      DisplayName = ''
      Expression = 'SUM(valorTotalProduto)'
    end
  end
  object dtsCliente: TDataSource
    DataSet = qryCliente
    Left = 64
    Top = 96
  end
  object dtsProdutos: TDataSource
    DataSet = qryProdutos
    Left = 136
    Top = 96
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 232
    Top = 96
  end
end
