object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 201
  ClientWidth = 447
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
    Top = 182
    Width = 447
    Height = 19
    Panels = <
      item
        Width = 150
      end>
    ExplicitLeft = 328
    ExplicitTop = 152
    ExplicitWidth = 0
  end
  object mainPrincipal: TMainMenu
    Left = 328
    Top = 24
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
