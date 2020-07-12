object frmRelCadProdutoComGrupoCategoria: TfrmRelCadProdutoComGrupoCategoria
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Produtos por Categorias'
  ClientHeight = 494
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object relatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsProdutos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 45
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 0
        Top = 10
        Width = 372
        Height = 24
        Caption = 'Listagem de Produtos por Categoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 34
        Width = 718
        Height = 11
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object rodape: TRLBand
      Left = 38
      Top = 187
      Width = 718
      Height = 30
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 11
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 0
        Top = 11
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 651
        Top = 11
        Width = 27
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 688
        Top = 11
        Width = 27
        Height = 16
        Info = itPageNumber
        Text = ''
      end
      object RLLabel3: TRLLabel
        Left = 607
        Top = 11
        Width = 44
        Height = 16
        Caption = 'P'#225'gina'
      end
      object RLLabel2: TRLLabel
        Left = 680
        Top = 11
        Width = 5
        Height = 16
        Alignment = taCenter
        Caption = '/'
        Transparent = False
      end
    end
    object bandaDoGrupo: TRLGroup
      Left = 38
      Top = 83
      Width = 718
      Height = 104
      DataFields = 'categoriaId'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 19
        BandType = btHeader
        Color = clSilver
        ParentColor = False
        Transparent = False
        object RLLabel8: TRLLabel
          Left = 3
          Top = 1
          Width = 70
          Height = 16
          Caption = 'Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText5: TRLDBText
          Left = 100
          Top = 1
          Width = 117
          Height = 16
          DataField = 'DescricaoCategoria'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText6: TRLDBText
          Left = 77
          Top = 1
          Width = 15
          Height = 16
          DataField = 'categoriaId'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLLabel9: TRLLabel
          Left = 90
          Top = 1
          Width = 8
          Height = 16
          Caption = '-'
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 19
        Width = 718
        Height = 19
        BandType = btColumnHeader
        object RLPanel1: TRLPanel
          Left = 0
          Top = 0
          Width = 718
          Height = 19
          Align = faClient
          Color = clInfoBk
          ParentColor = False
          Transparent = False
        end
        object RLLabel4: TRLLabel
          Left = 3
          Top = 3
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel5: TRLLabel
          Left = 84
          Top = 3
          Width = 41
          Height = 16
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel6: TRLLabel
          Left = 396
          Top = 3
          Width = 152
          Height = 16
          Alignment = taRightJustify
          Caption = 'Quantidade de Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 677
          Top = 3
          Width = 38
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object detail: TRLBand
        Left = 0
        Top = 38
        Width = 718
        Height = 16
        object RLDBText1: TRLDBText
          Left = -1
          Top = 0
          Width = 58
          Height = 16
          Alignment = taCenter
          DataField = 'produtoId'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 84
          Top = 0
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 396
          Top = 0
          Width = 152
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProdutos
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 685
          Top = 0
          Width = 30
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProdutos
          Text = ''
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 54
        Width = 718
        Height = 53
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 609
          Top = 11
          Width = 106
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProdutos
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 396
          Top = 0
          Width = 326
          Height = 11
          DrawKind = dkLine
        end
        object RLLabel10: TRLLabel
          Left = 397
          Top = 11
          Width = 243
          Height = 16
          Alignment = taRightJustify
          Caption = 'Quantidade de Estoque por Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel11: TRLLabel
          Left = 397
          Top = 29
          Width = 192
          Height = 16
          Alignment = taRightJustify
          Caption = 'M'#233'dia de Valor por Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBResult2: TRLDBResult
          Left = 627
          Top = 29
          Width = 88
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProdutos
          Info = riAverage
          Text = ''
        end
      end
    end
  end
  object qryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT produtos.produtoId, produtos.nome, produtos.descricao, pr' +
        'odutos.valor,'
      
        'produtos.quantidade, produtos.categoriaId, categorias.descricao ' +
        'AS DescricaoCategoria'
      
        'FROM produtos LEFT JOIN categorias ON categorias.categoriaId = p' +
        'rodutos.categoriaId'
      'ORDER BY produtos.categoriaId, produtos.produtoId')
    Params = <>
    Left = 600
    Top = 16
    object qryProdutosprodutoId: TIntegerField
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object qryProdutosnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object qryProdutosdescricao: TWideStringField
      FieldName = 'descricao'
      Size = 255
    end
    object qryProdutosvalor: TFloatField
      FieldName = 'valor'
      DisplayFormat = '#0.00'
    end
    object qryProdutosquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object qryProdutoscategoriaId: TIntegerField
      FieldName = 'categoriaId'
    end
    object qryProdutosDescricaoCategoria: TWideStringField
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  object dtsProdutos: TDataSource
    DataSet = qryProdutos
    Left = 672
    Top = 16
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 530
    Top = 16
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 463
    Top = 16
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 396
    Top = 15
  end
end
