inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ExplicitWidth = 734
    ExplicitHeight = 403
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 726
      ExplicitHeight = 375
      inherited pnlListagemTopo: TPanel
        ExplicitWidth = 726
      end
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Width = 77
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 220
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 726
      ExplicitHeight = 375
    end
  end
  inherited pnlRodape: TPanel
    inherited btnFechar: TBitBtn
      ExplicitLeft = 643
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT categoriaId,'
      '       descricao'
      'FROM categorias'
      '             ')
    object qryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
end
