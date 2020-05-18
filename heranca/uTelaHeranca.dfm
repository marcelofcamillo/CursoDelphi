object frmTelaHeranca: TfrmTelaHeranca
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Informe aqui o t'#237'tulo'
  ClientHeight = 443
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 795
    Height = 405
    ActivePage = tabListagem
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 749
    ExplicitHeight = 351
    object tabListagem: TTabSheet
      Caption = 'Listagem'
      ExplicitWidth = 741
      ExplicitHeight = 323
      object pnlListagemTopo: TPanel
        Left = 0
        Top = 0
        Width = 787
        Height = 65
        Align = alTop
        TabOrder = 0
      end
      object grdListagem: TDBGrid
        Left = 0
        Top = 65
        Width = 787
        Height = 312
        Align = alClient
        DataSource = dtsListagem
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabManutencao: TTabSheet
      Caption = 'Manuten'#231#227'o'
      ImageIndex = 1
      ExplicitWidth = 741
      ExplicitHeight = 305
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 405
    Width = 795
    Height = 38
    Align = alBottom
    TabOrder = 1
    object btnNovo: TBitBtn
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Novo'
      TabOrder = 0
    end
    object btnAlterar: TBitBtn
      Left = 97
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 1
    end
    object btnCancelar: TBitBtn
      Left = 178
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 2
    end
    object btnGravar: TBitBtn
      Left = 259
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 3
    end
    object btnApagar: TBitBtn
      Left = 340
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Apaga&r'
      TabOrder = 4
    end
    object btnFechar: TBitBtn
      Left = 704
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
    object btnNavigator: TDBNavigator
      Left = 448
      Top = 6
      Width = 216
      Height = 25
      DataSource = dtsListagem
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 6
    end
  end
  object mskPesquisar: TMaskEdit
    Left = 16
    Top = 57
    Width = 265
    Height = 21
    TabOrder = 2
    Text = ''
    TextHint = 'Digite sua pesquisa...'
  end
  object btnPesquisar: TBitBtn
    Left = 296
    Top = 55
    Width = 75
    Height = 25
    Caption = '&Pesquisar'
    TabOrder = 3
  end
  object qryListagem: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Params = <>
    Left = 552
    Top = 32
  end
  object dtsListagem: TDataSource
    DataSet = qryListagem
    Left = 619
    Top = 33
  end
end
