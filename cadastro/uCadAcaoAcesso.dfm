inherited frmCadAcaoAcesso: TfrmCadAcaoAcesso
  Caption = 'Cadastro de A'#231#227'o de Acesso'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 726
      ExplicitHeight = 375
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 726
      ExplicitHeight = 375
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 12
        Top = 80
        Width = 702
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 0
      end
      object edtAcaoAcessoId: TLabeledEdit
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
        TabOrder = 1
      end
      object edtChave: TLabeledEdit
        Tag = 2
        Left = 12
        Top = 136
        Width = 493
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Chave'
        MaxLength = 60
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT acaoAcessoId,'
      '       descricao,'
      '       chave'
      'FROM acaoAcesso')
    object qryListagemacaoAcessoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'acaoAcessoId'
      ReadOnly = True
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 61
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object qryListagemchave: TWideStringField
      DisplayLabel = 'Chave'
      DisplayWidth = 44
      FieldName = 'chave'
      Required = True
      Size = 60
    end
  end
end
