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
  PixelsPerInch = 96
  TextHeight = 13
  object mainPrincipal: TMainMenu
    Left = 328
    Top = 24
    object Cadsatro1: TMenuItem
      Caption = 'Cadastro'
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Categoria1: TMenuItem
        Caption = 'Categoria'
        OnClick = Categoria1Click
      end
      object Produto1: TMenuItem
        Caption = 'Produto'
        OnClick = Produto1Click
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
        Caption = 'Venda'
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rio'
      object Cliente2: TMenuItem
        Caption = 'Cliente'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Produto2: TMenuItem
        Caption = 'Produto'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Vendapordata1: TMenuItem
        Caption = 'Venda por data'
      end
    end
  end
end
