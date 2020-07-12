object frmRelProVendaPorData: TfrmRelProVendaPorData
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Venda por Data'
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
    DataSource = dtsVendas
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
        Width = 291
        Height = 24
        Caption = 'Listagem de Venda por Data'
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
      Top = 211
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
      Height = 92
      DataFields = 'dataVenda'
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
          Width = 37
          Height = 16
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText6: TRLDBText
          Left = 42
          Top = 1
          Width = 66
          Height = 16
          DataField = 'dataVenda'
          DataSource = dtsVendas
          Text = ''
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
          Width = 110
          Height = 16
          Caption = 'Nome do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 612
          Top = 3
          Width = 103
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor da Venda'
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
          Left = 2
          Top = 0
          Width = 52
          Height = 16
          Alignment = taCenter
          DataField = 'clienteId'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 84
          Top = 0
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 649
          Top = 0
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVendas
          Text = ''
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 54
        Width = 718
        Height = 38
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 610
          Top = 11
          Width = 105
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVendas
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 504
          Top = 0
          Width = 218
          Height = 11
          DrawKind = dkLine
        end
        object RLLabel10: TRLLabel
          Left = 507
          Top = 11
          Width = 94
          Height = 16
          Alignment = taRightJustify
          Caption = 'Total por Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 175
      Width = 718
      Height = 36
      BandType = btSummary
      object RLDBResult2: TRLDBResult
        Left = 601
        Top = 10
        Width = 114
        Height = 16
        Alignment = taRightJustify
        DataField = 'totalVenda'
        DataSource = dtsVendas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = riSum
        ParentFont = False
        Text = ''
      end
      object RLDraw4: TRLDraw
        Left = 440
        Top = 0
        Width = 278
        Height = 11
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLLabel6: TRLLabel
        Left = 443
        Top = 10
        Width = 75
        Height = 16
        Alignment = taRightJustify
        Caption = 'Total Geral'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object qryVendas: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT vendas.vendaId, vendas.clienteId, clientes.nome, vendas.d' +
        'ataVenda, vendas.totalVenda'
      
        'FROM vendas INNER JOIN clientes ON clientes.clienteId = vendas.c' +
        'lienteId WHERE vendas.dataVenda'
      
        'BETWEEN :dataInicial AND :dataFinal ORDER BY vendas.dataVenda, v' +
        'endas.clienteId')
    Params = <
      item
        DataType = ftDate
        Name = 'dataInicial'
        ParamType = ptInput
        Value = 43101d
      end
      item
        DataType = ftDate
        Name = 'dataFinal'
        ParamType = ptInput
        Value = 44024d
      end>
    Left = 600
    Top = 16
    ParamData = <
      item
        DataType = ftDate
        Name = 'dataInicial'
        ParamType = ptInput
        Value = 43101d
      end
      item
        DataType = ftDate
        Name = 'dataFinal'
        ParamType = ptInput
        Value = 44024d
      end>
    object qryVendasvendaId: TIntegerField
      FieldName = 'vendaId'
      ReadOnly = True
    end
    object qryVendasclienteId: TIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object qryVendasnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object qryVendasdataVenda: TDateTimeField
      FieldName = 'dataVenda'
    end
    object qryVendastotalVenda: TFloatField
      FieldName = 'totalVenda'
      DisplayFormat = '#0.00'
    end
  end
  object dtsVendas: TDataSource
    DataSet = qryVendas
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
