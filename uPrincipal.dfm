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
      end
      item
        Column = 1
        Control = DBChart2
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
    object DBChart1: TDBChart
      Left = 1
      Top = 1
      Width = 456
      Height = 202
      Title.Text.Strings = (
        'Produto em Estoque')
      Align = alClient
      TabOrder = 0
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
    object DBChart2: TDBChart
      Left = 457
      Top = 1
      Width = 456
      Height = 202
      Title.Text.Strings = (
        'Valor de Venda por Cliente na '#218'ltima Semana')
      Legend.TextStyle = ltsXAndText
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series2: TPieSeries
        Marks.Brush.Gradient.Colors = <
          item
            Color = clRed
          end
          item
            Color = 819443
            Offset = 0.067915690866510540
          end
          item
            Color = clYellow
            Offset = 1.000000000000000000
          end>
        Marks.Brush.Gradient.Direction = gdTopBottom
        Marks.Brush.Gradient.EndColor = clYellow
        Marks.Brush.Gradient.MidColor = 819443
        Marks.Brush.Gradient.StartColor = clRed
        Marks.Brush.Gradient.Visible = True
        Marks.Font.Color = 159
        Marks.Font.Name = 'Tahoma'
        Marks.Font.Style = [fsBold, fsItalic]
        Marks.Frame.Color = 33023
        Marks.RoundSize = 14
        Marks.Style = smsPercent
        Marks.Callout.Length = 20
        DataSource = dtmGrafico.qryVendaValorPorCliente
        Title = 'ValorDeVendaPorCliente'
        ValueFormat = '#,##0.00'
        XLabelsSource = 'Label'
        XValues.Order = loAscending
        YValues.Name = 'Pie'
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
        Frame.InnerBrush.BackColor = clRed
        Frame.InnerBrush.Gradient.EndColor = clGray
        Frame.InnerBrush.Gradient.MidColor = clWhite
        Frame.InnerBrush.Gradient.StartColor = 4210752
        Frame.InnerBrush.Gradient.Visible = True
        Frame.MiddleBrush.BackColor = clYellow
        Frame.MiddleBrush.Gradient.EndColor = 8553090
        Frame.MiddleBrush.Gradient.MidColor = clWhite
        Frame.MiddleBrush.Gradient.StartColor = clGray
        Frame.MiddleBrush.Gradient.Visible = True
        Frame.OuterBrush.BackColor = clGreen
        Frame.OuterBrush.Gradient.EndColor = 4210752
        Frame.OuterBrush.Gradient.MidColor = clWhite
        Frame.OuterBrush.Gradient.StartColor = clSilver
        Frame.OuterBrush.Gradient.Visible = True
        Frame.Width = 4
        OtherSlice.Legend.Visible = False
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
