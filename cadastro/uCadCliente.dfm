inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientWidth = 738
  ExplicitWidth = 744
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 738
    ActivePage = tabManutencao
    ExplicitWidth = 738
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 730
      ExplicitHeight = 375
      inherited pnlListagemTopo: TPanel
        Width = 730
        ExplicitWidth = 730
      end
      inherited grdListagem: TDBGrid
        Width = 730
        Columns = <
          item
            Expanded = False
            FieldName = 'clienteId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 261
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Width = 103
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 730
      ExplicitHeight = 375
      object Label1: TLabel
        Left = 536
        Top = 64
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label2: TLabel
        Left = 536
        Top = 183
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label3: TLabel
        Left = 536
        Top = 244
        Width = 95
        Height = 13
        Caption = 'Data de nascimento'
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 12
        Top = 80
        Width = 501
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtClienteId: TLabeledEdit
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
      object edtCEP: TMaskEdit
        Left = 536
        Top = 80
        Width = 177
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 12
        Top = 137
        Width = 501
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        TabOrder = 3
      end
      object edtBairro: TLabeledEdit
        Left = 536
        Top = 137
        Width = 177
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 40
        TabOrder = 4
      end
      object edtCidade: TLabeledEdit
        Left = 12
        Top = 198
        Width = 237
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 50
        TabOrder = 5
      end
      object edtEmail: TLabeledEdit
        Left = 12
        Top = 259
        Width = 501
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'E-mail'
        MaxLength = 100
        TabOrder = 8
      end
      object edtDataNascimento: TDateEdit
        Left = 536
        Top = 259
        Width = 177
        Height = 21
        DialogTitle = 'Selecione a data'
        NumGlyphs = 2
        TabOrder = 9
      end
      object edtTelefone: TMaskEdit
        Left = 536
        Top = 198
        Width = 175
        Height = 21
        EditMask = '(99) 9999-9999;1;_'
        MaxLength = 14
        TabOrder = 7
        Text = '(  )     -    '
      end
      object edtEstado: TLabeledEdit
        Left = 276
        Top = 198
        Width = 237
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Estado'
        MaxLength = 2
        TabOrder = 6
      end
    end
  end
  inherited pnlRodape: TPanel
    Width = 738
    ExplicitWidth = 738
    inherited btnFechar: TBitBtn
      Left = 647
      ExplicitLeft = 647
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      
        'SELECT clienteId, nome, endereco, cidade, bairro, estado, cep, t' +
        'elefone, email, dataNascimento FROM clientes')
    Left = 608
    object qryListagemclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object qryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object qryListagemendereco: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'endereco'
      Size = 60
    end
    object qryListagemcidade: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Size = 50
    end
    object qryListagembairro: TWideStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Size = 40
    end
    object qryListagemestado: TWideStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Size = 2
    end
    object qryListagemcep: TWideStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
    object qryListagemtelefone: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 14
    end
    object qryListagememail: TWideStringField
      DisplayLabel = 'E-mail'
      FieldName = 'email'
      Size = 100
    end
    object qryListagemdataNascimento: TDateTimeField
      DisplayLabel = 'Data de Nascimento'
      FieldName = 'dataNascimento'
    end
  end
  inherited dtsListagem: TDataSource
    Left = 675
  end
end
