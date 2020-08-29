inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 313
  ClientWidth = 691
  ExplicitWidth = 697
  ExplicitHeight = 342
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 691
    Height = 268
    ExplicitWidth = 691
    ExplicitHeight = 268
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 683
      ExplicitHeight = 240
      inherited pnlListagemTopo: TPanel
        Width = 683
        ExplicitWidth = 683
      end
      inherited grdListagem: TDBGrid
        Width = 683
        Height = 181
        Columns = <
          item
            Expanded = False
            FieldName = 'usuarioId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'senha'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 683
      ExplicitHeight = 240
      object edtUsuarioId: TLabeledEdit
        Tag = 1
        Left = 12
        Top = 26
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 12
        Top = 80
        Width = 501
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Usu'#225'rio'
        MaxLength = 50
        TabOrder = 1
      end
      object edtSenha: TLabeledEdit
        Tag = 2
        Left = 12
        Top = 137
        Width = 501
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        MaxLength = 40
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 268
    Width = 691
    ExplicitTop = 268
    ExplicitWidth = 691
    inherited btnFechar: TBitBtn
      Left = 600
      ExplicitLeft = 600
    end
    inherited btnNavigator: TDBNavigator
      Left = 429
      Hints.Strings = ()
      ExplicitLeft = 429
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT usuarioId,'
      '       nome,'
      '       senha'
      'FROM usuarios')
    Left = 560
    object qryListagemusuarioId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioId'
      ReadOnly = True
    end
    object qryListagemnome: TWideStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object qryListagemsenha: TWideStringField
      DisplayLabel = 'Senha'
      FieldName = 'senha'
      Required = True
      Size = 40
    end
  end
  inherited dtsListagem: TDataSource
    Left = 627
  end
end
