object frmRelCadProduto: TfrmRelCadProduto
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Produtos'
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
        Width = 229
        Height = 24
        Caption = 'Listagem de Produtos'
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
      Top = 118
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
    object detail: TRLBand
      Left = 38
      Top = 102
      Width = 718
      Height = 16
      object RLDBText1: TRLDBText
        Left = 3
        Top = 0
        Width = 49
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
    object RLBand1: TRLBand
      Left = 38
      Top = 83
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
  end
  object qryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT produtoId, nome, valor, quantidade FROM produtos ORDER BY' +
        ' nome')
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
    object qryProdutosvalor: TFloatField
      FieldName = 'valor'
      DisplayFormat = '#0.00'
    end
    object qryProdutosquantidade: TFloatField
      FieldName = 'quantidade'
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
