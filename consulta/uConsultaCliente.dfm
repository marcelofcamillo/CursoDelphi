inherited frmConsultaCliente: TfrmConsultaCliente
  Caption = 'frmConsultaCliente'
  ClientWidth = 805
  ExplicitWidth = 811
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 805
  end
  inherited Panel2: TPanel
    Width = 805
    inherited btnFechar: TBitBtn
      Left = 717
    end
  end
  inherited Panel3: TPanel
    Width = 805
    inherited grdPesquisa: TDBGrid
      Width = 803
      Columns = <
        item
          Expanded = False
          FieldName = 'clienteId'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Width = 176
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'endereco'
          Width = 186
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cidade'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'bairro'
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'estado'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cep'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'telefone'
          Visible = True
        end>
    end
  end
  inherited qryListagem: TZQuery
    Active = True
    SQL.Strings = (
      'SELECT clienteId,'
      '       nome,'
      '       endereco,'
      '       cidade,'
      '       bairro,'
      '       estado,'
      '       cep,'
      '       telefone,'
      '       email,'
      '       dataNascimento'
      'FROM clientes')
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
      DisplayLabel = 'Email'
      FieldName = 'email'
      Size = 100
    end
    object qryListagemdataNascimento: TDateTimeField
      DisplayLabel = 'Data de Nascimento'
      FieldName = 'dataNascimento'
    end
  end
end
