inherited frmConsultaProduto: TfrmConsultaProduto
  Caption = 'frmConsultaProduto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    ExplicitWidth = 721
  end
  inherited Panel2: TPanel
    ExplicitLeft = 0
    ExplicitTop = 356
    ExplicitWidth = 721
  end
  inherited Panel3: TPanel
    ExplicitTop = 58
    ExplicitWidth = 721
    ExplicitHeight = 298
    inherited grdPesquisa: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'produtoId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Width = 373
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'categoriaId'
          Visible = True
        end>
    end
  end
  inherited qryListagem: TZQuery
    Active = True
    SQL.Strings = (
      'SELECT produtoId,'
      '       nome,'
      '       descricao,'
      '       valor,'
      '       quantidade,'
      '       categoriaId'
      'FROM produtos')
    object qryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object qryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object qryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object qryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object qryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'd. Categoria'
      FieldName = 'categoriaId'
    end
  end
end
