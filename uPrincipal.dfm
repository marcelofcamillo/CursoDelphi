object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 467
  ClientWidth = 914
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mainPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object stbPrincipal: TStatusBar
    Left = 0
    Top = 448
    Width = 914
    Height = 19
    Panels = <
      item
        Width = 150
      end>
    ExplicitTop = 182
    ExplicitWidth = 447
  end
  object gridPanel: TGridPanel
    Left = 0
    Top = 41
    Width = 914
    Height = 407
    Align = alClient
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = DBChart1
        Row = 0
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 1
    ExplicitLeft = 448
    ExplicitTop = 128
    ExplicitWidth = 185
    ExplicitHeight = 41
    object DBChart1: TDBChart
      Left = 1
      Top = 1
      Width = 456
      Height = 202
      Title.Text.Strings = (
        'Produto em Estoque')
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 288
      ExplicitTop = 80
      ExplicitWidth = 400
      ExplicitHeight = 250
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: TBarSeries
        ColorEachPoint = True
        Marks.Visible = False
        DataSource = dtmGrafico.qryProdutoEstoque
        Title = 'ProdutoEstoque'
        XLabelsSource = 'Label'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 914
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 584
    ExplicitTop = 32
    ExplicitWidth = 185
    object Label1: TLabel
      Left = 11
      Top = 7
      Width = 114
      Height = 25
      Caption = 'Dashboard'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object mainPrincipal: TMainMenu
    Left = 856
    Top = 8
    object Cadsatro1: TMenuItem
      Caption = 'Cadastro'
      object Cliente1: TMenuItem
        Caption = 'Clientes'
        OnClick = Cliente1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Categoria1: TMenuItem
        Caption = 'Categorias'
        OnClick = Categoria1Click
      end
      object Produto1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produto1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Usurios1: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = Usurios1Click
      end
      object Alterarsenha1: TMenuItem
        Caption = 'Alterar senha'
        OnClick = Alterarsenha1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object AcaodeAcesso1: TMenuItem
        Caption = 'A'#231#245'es de Acesso'
        OnClick = AcaodeAcesso1Click
      end
      object UsuriosvsAes1: TMenuItem
        Caption = 'Usu'#225'rios vs A'#231#245'es'
        OnClick = UsuriosvsAes1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnuFechar: TMenuItem
        Caption = 'Fechar'
        OnClick = mnuFecharClick
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Vendas1: TMenuItem
        Caption = 'Vendas'
        OnClick = Vendas1Click
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rio'
      object Cliente2: TMenuItem
        Caption = 'Clientes'
        OnClick = Cliente2Click
      end
      object FichadeClientes1: TMenuItem
        Caption = 'Ficha de Clientes'
        OnClick = FichadeClientes1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Categorias1: TMenuItem
        Caption = 'Categorias'
        OnClick = Categorias1Click
      end
      object Produto2: TMenuItem
        Caption = 'Produtos'
        OnClick = Produto2Click
      end
      object ProdutosporCategoria1: TMenuItem
        Caption = 'Produtos por Categoria'
        OnClick = ProdutosporCategoria1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Vendapordata1: TMenuItem
        Caption = 'Vendas por data'
        OnClick = Vendapordata1Click
      end
    end
  end
end
