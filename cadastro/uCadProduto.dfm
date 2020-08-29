inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 726
      ExplicitHeight = 375
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 274
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Width = 82
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricaoCategoria'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 726
      ExplicitHeight = 375
      object Label1: TLabel
        Left = 12
        Top = 120
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label2: TLabel
        Left = 12
        Top = 221
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label3: TLabel
        Left = 225
        Top = 221
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 455
        Top = 65
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 12
        Top = 26
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 12
        Top = 80
        Width = 421
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtDescricao: TMemo
        Left = 12
        Top = 136
        Width = 702
        Height = 65
        Lines.Strings = (
          'edtDescricao')
        MaxLength = 255
        TabOrder = 3
      end
      object edtValor: TCurrencyEdit
        Left = 12
        Top = 240
        Width = 173
        Height = 21
        TabOrder = 4
      end
      object edtQuantidade: TCurrencyEdit
        Left = 225
        Top = 240
        Width = 173
        Height = 21
        DisplayFormat = ' ,0.00;- ,0.00'
        TabOrder = 5
      end
      object lkpCategoria: TDBLookupComboBox
        Left = 455
        Top = 80
        Width = 259
        Height = 21
        KeyField = 'categoriaId'
        ListField = 'descricao'
        ListSource = dtsCategoria
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT p.produtoId,'
      '       p.nome,'
      '       p.descricao,'
      '       p.valor,'
      '       p.quantidade,'
      '       p.categoriaId,'
      '       c.descricao AS descricaoCategoria'
      'FROM produtos AS p'
      'LEFT JOIN categorias AS c ON c.categoriaId = p.categoriaId')
    object qryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'produtoId'
      Origin = 'p'
      ReadOnly = True
    end
    object qryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 40
      FieldName = 'nome'
      Origin = 'p'
      Size = 60
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 255
      FieldName = 'descricao'
      Origin = 'p'
      Size = 255
    end
    object qryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      DisplayWidth = 10
      FieldName = 'valor'
      Origin = 'p'
    end
    object qryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 10
      FieldName = 'quantidade'
      Origin = 'p'
    end
    object qryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'd. Categoria'
      DisplayWidth = 10
      FieldName = 'categoriaId'
      Origin = 'p'
    end
    object qryListagemdescricaoCategoria: TWideStringField
      DisplayLabel = 'Descri'#231#227'o Categoria'
      DisplayWidth = 30
      FieldName = 'descricaoCategoria'
      Origin = 'c.descricao'
      Size = 30
    end
  end
  object qryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT categoriaId,'
      '       descricao'
      'FROM categorias')
    Params = <>
    Left = 468
    Top = 32
    object qryCategoriacategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object qryCategoriadescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = qryCategoria
    Left = 540
    Top = 32
  end
end
