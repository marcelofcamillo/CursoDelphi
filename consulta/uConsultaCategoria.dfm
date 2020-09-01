inherited frmConsultaCategoria: TfrmConsultaCategoria
  Caption = 'Consulta de Categorias'
  ClientWidth = 651
  ExplicitWidth = 657
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 651
    ExplicitWidth = 721
  end
  inherited Panel2: TPanel
    Width = 651
    ExplicitLeft = 0
    ExplicitTop = 356
    ExplicitWidth = 721
    DesignSize = (
      651
      41)
    inherited btnFechar: TBitBtn
      Left = 563
    end
  end
  inherited Panel3: TPanel
    Width = 651
    ExplicitTop = 58
    ExplicitWidth = 721
    ExplicitHeight = 298
    inherited grdPesquisa: TDBGrid
      Width = 649
      Columns = <
        item
          Expanded = False
          FieldName = 'categoriaId'
          Width = 114
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Width = 408
          Visible = True
        end>
    end
  end
  inherited qryListagem: TZQuery
    Active = True
    SQL.Strings = (
      'SELECT categoriaId,'
      '       descricao'
      'FROM categorias')
    Left = 532
    Top = 0
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
  inherited dtsListagem: TDataSource
    Left = 596
    Top = 0
  end
end
