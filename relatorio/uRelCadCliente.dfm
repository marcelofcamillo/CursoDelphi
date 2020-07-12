object frmRelCadCliente: TfrmRelCadCliente
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Clientes'
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
    DataSource = dtsClientes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Transparent = False
    object cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 45
      BandType = btHeader
      Transparent = False
      object RLLabel1: TRLLabel
        Left = 0
        Top = 10
        Width = 217
        Height = 24
        Caption = 'Listagem de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 34
        Width = 718
        Height = 11
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
    end
    object rodape: TRLBand
      Left = 38
      Top = 118
      Width = 718
      Height = 30
      BandType = btFooter
      Transparent = False
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 11
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 0
        Top = 11
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
        Transparent = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 651
        Top = 11
        Width = 27
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
        Transparent = False
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 688
        Top = 11
        Width = 27
        Height = 16
        Info = itPageNumber
        Text = ''
        Transparent = False
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
      object RLLabel3: TRLLabel
        Left = 607
        Top = 11
        Width = 44
        Height = 16
        Caption = 'P'#225'gina'
        Transparent = False
      end
    end
    object detail: TRLBand
      Left = 38
      Top = 102
      Width = 718
      Height = 16
      Transparent = False
      object RLDBText1: TRLDBText
        Left = 2
        Top = 0
        Width = 52
        Height = 16
        Alignment = taCenter
        DataField = 'clienteId'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLDBText2: TRLDBText
        Left = 84
        Top = 0
        Width = 181
        Height = 16
        DataField = 'nome'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLDBText3: TRLDBText
        Left = 301
        Top = 0
        Width = 210
        Height = 16
        DataField = 'email'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLDBText4: TRLDBText
        Left = 610
        Top = 0
        Width = 90
        Height = 16
        DataField = 'telefone'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 83
      Width = 718
      Height = 19
      BandType = btColumnHeader
      Transparent = False
      object RLPanel1: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 19
        Align = faClient
        Color = clInfoBk
        ParentColor = False
        Transparent = False
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
          Left = 301
          Top = 3
          Width = 44
          Height = 16
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 610
          Top = 3
          Width = 60
          Height = 16
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object qryClientes: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT clienteId, nome, email, telefone FROM clientes order by n' +
        'ome'
      '')
    Params = <>
    Left = 600
    Top = 16
    object qryClientesclienteId: TIntegerField
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object qryClientesnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object qryClientesemail: TWideStringField
      FieldName = 'email'
      Size = 100
    end
    object qryClientestelefone: TWideStringField
      FieldName = 'telefone'
      Size = 14
    end
  end
  object dtsClientes: TDataSource
    DataSet = qryClientes
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
