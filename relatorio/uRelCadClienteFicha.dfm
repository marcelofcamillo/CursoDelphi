object frmRelCadClienteFicha: TfrmRelCadClienteFicha
  Left = 0
  Top = 0
  Caption = 'Ficha de Clientes'
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
        Width = 179
        Height = 24
        Caption = 'Ficha de Clientes'
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
      Top = 177
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
      Top = 83
      Width = 718
      Height = 94
      Transparent = False
      object RLDBText1: TRLDBText
        Left = 56
        Top = 0
        Width = 52
        Height = 16
        DataField = 'clienteId'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLDBText2: TRLDBText
        Left = 208
        Top = 0
        Width = 181
        Height = 16
        DataField = 'nome'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLDBText3: TRLDBText
        Left = 51
        Top = 64
        Width = 210
        Height = 16
        DataField = 'email'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLDBText4: TRLDBText
        Left = 517
        Top = 64
        Width = 90
        Height = 16
        DataField = 'telefone'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 0
        Top = 0
        Width = 53
        Height = 16
        Caption = 'C'#243'digo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 160
        Top = 0
        Width = 45
        Height = 16
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 0
        Top = 64
        Width = 48
        Height = 16
        Caption = 'E-mail:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 452
        Top = 64
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
      object RLLabel8: TRLLabel
        Left = 0
        Top = 22
        Width = 34
        Height = 16
        Caption = 'CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText5: TRLDBText
        Left = 37
        Top = 22
        Width = 66
        Height = 16
        DataField = 'cep'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLLabel9: TRLLabel
        Left = 160
        Top = 22
        Width = 82
        Height = 16
        Caption = 'Logradouro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText6: TRLDBText
        Left = 247
        Top = 22
        Width = 57
        Height = 16
        DataField = 'endereco'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLLabel10: TRLLabel
        Left = 0
        Top = 43
        Width = 47
        Height = 16
        Caption = 'Bairro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText7: TRLDBText
        Left = 50
        Top = 43
        Width = 36
        Height = 16
        DataField = 'bairro'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLLabel11: TRLLabel
        Left = 160
        Top = 43
        Width = 53
        Height = 16
        Caption = 'Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText8: TRLDBText
        Left = 215
        Top = 43
        Width = 42
        Height = 16
        DataField = 'cidade'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLLabel12: TRLLabel
        Left = 452
        Top = 43
        Width = 25
        Height = 16
        Caption = 'UF:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText9: TRLDBText
        Left = 483
        Top = 43
        Width = 43
        Height = 16
        DataField = 'estado'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLLabel13: TRLLabel
        Left = 452
        Top = 0
        Width = 135
        Height = 16
        Caption = 'Data de Nascimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText10: TRLDBText
        Left = 591
        Top = 0
        Width = 98
        Height = 16
        DataField = 'dataNascimento'
        DataSource = dtsClientes
        Text = ''
        Transparent = False
      end
      object RLDraw3: TRLDraw
        Left = 0
        Top = 83
        Width = 718
        Height = 11
        Align = faBottom
        DrawKind = dkLine
        Pen.Style = psDot
        Transparent = False
      end
      object RLAngleLabel1: TRLAngleLabel
        Left = 701
        Top = 2
        Width = 14
        Height = 79
        Angle = 90.000000000000000000
        Caption = 'Ficha do Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object qryClientes: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT clienteId, nome, cep, endereco, bairro, cidade, estado, e' +
        'mail, telefone, dataNascimento FROM clientes ORDER BY nome')
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
    object qryClientescep: TWideStringField
      FieldName = 'cep'
      Size = 10
    end
    object qryClientesendereco: TWideStringField
      FieldName = 'endereco'
      Size = 60
    end
    object qryClientesbairro: TWideStringField
      FieldName = 'bairro'
      Size = 40
    end
    object qryClientescidade: TWideStringField
      FieldName = 'cidade'
      Size = 50
    end
    object qryClientesestado: TWideStringField
      FieldName = 'estado'
      Size = 2
    end
    object qryClientesemail: TWideStringField
      FieldName = 'email'
      Size = 100
    end
    object qryClientestelefone: TWideStringField
      FieldName = 'telefone'
      Size = 14
    end
    object qryClientesdataNascimento: TDateTimeField
      FieldName = 'dataNascimento'
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
