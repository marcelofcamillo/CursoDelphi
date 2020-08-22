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
end
