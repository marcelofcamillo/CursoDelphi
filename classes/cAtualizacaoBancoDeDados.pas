unit cAtualizacaoBancoDeDados;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection,
     ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, Data.DB, System.SysUtils;

type
  TAtualizaBancoDados = class

  private

  public
    ConexaoDB: TZConnection;
    constructor Create(aConexao: TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
end;

Type
  TAtualizaBancoDadosMSSQL = class
    private
      ConexaoDB: TZConnection;
    public
      function AtualizarBancoDeDadosMSSQL: Boolean;
      constructor Create(aConexao: TZConnection);
  End;

implementation

{ TAtualizaBancoDados }

uses cAtualizacaoTabelaMSSQL, cAtualizacaoCampoMSSQL;

constructor TAtualizaBancoDados.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

procedure TAtualizaBancoDados.ExecutaDiretoBancoDeDados(aScript: String);
var qry: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add(aScript);

    try
      ConexaoDB.StartTransaction;
      qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
    end;
  finally
    qry.Close;

    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

{ TAtualizaBancoDadosMSSQL }

function TAtualizaBancoDadosMSSQL.AtualizarBancoDeDadosMSSQL: Boolean;
var oAtualizarDB: TAtualizaBancoDados;
    oTabela: TAtualizacaoTableMSSQL;
    oCampo: TAtualizacaoCampoMSSQL;
begin
  try
    // classe principal de atualização
    oAtualizarDB := TAtualizaBancoDados.Create(ConexaoDB);

    // sub-classe de atualização
    oTabela := TAtualizacaoTableMSSQL.Create(ConexaoDB);
    oCampo  := TAtualizacaoCampoMSSQL.Create(ConexaoDB);

  finally
    FreeAndNil(oCampo);
    FreeAndNil(oTabela);
    FreeAndNil(oAtualizarDB);
  end;
end;

constructor TAtualizaBancoDadosMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

end.
