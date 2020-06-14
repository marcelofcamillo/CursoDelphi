unit cProVenda;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection,
     ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils;

type
  TVenda = class
  private
    ConexaoDB: TZConnection;
    F_vendaId: Integer;
    F_clienteId: Integer;
    F_dataVenda: TDateTime;
    F_totalVenda: Double;

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
  published
    property vendaId    : Integer   read F_vendaId    write F_vendaId;
    property clienteId  : Integer   read F_clienteId  write F_clienteId;
    property dataVenda  : TDateTime read F_dataVenda  write F_dataVenda;
    property totalVenda : Double    read F_totalVenda write F_totalVenda;
  end;

implementation

{ TProVenda }

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TVenda.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TVenda.Destroy;
begin

  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TVenda.Apagar: Boolean;
var qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Venda Nro: ' + IntToStr(F_vendaId), mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
     Result := false;
     Abort;
  end;

  try
    Result := true;
    qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    // apaga os itens primeiro
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM vendasItens WHERE vendaId = :vendaId');
    qry.ParamByName('vendaId').AsInteger := F_vendaId;

    try
      qry.ExecSQL;
      // apaga a tabela master
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM vendas WHERE vendaId = :vendaId');
      qry.ParamByName('vendaId').AsInteger := F_vendaId;
      qry.ExecSQL;

    Except
      Result := false;
    End;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.Atualizar: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE vendas SET clienteId = :clienteId, dataVenda = :dataVenda, totalVenda = :totalVenda WHERE vendaId = :vendaId');
    qry.ParamByName('vendaId').AsInteger    := Self.F_vendaId;
    qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    try
      Qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.Inserir: Boolean;
var qry: TZQuery;
    idVendaGerado: Integer;
begin
  try
    Result := true;
    ConexaoDB.StartTransaction;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    //Faz a Inclusão no Banco de Dados
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO vendas (clienteId, dataVenda, totalVenda) VALUES (:clienteId,:dataVenda,:totalVenda)');
    qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    try
      qry.ExecSQL;
      // recupera o ID gerado no insert
      qry.SQL.Clear;
      qry.SQL.Add('SELECT SCOPE_IDENTITY() AS ID');
      qry.Open;

      //Id da tabela Master (Venda)
      idVendaGerado := qry.FieldByName('ID').AsInteger;

      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.Selecionar(id: Integer): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT vendaId, clienteId, dataVenda, totalVenda FROM vendas WHERE vendaId = :vendaId');
    qry.ParamByName('vendaId').AsInteger := id;

    try
      qry.Open;

      Self.F_vendaId    := qry.FieldByName('vendaId').AsInteger;
      Self.F_clienteId  := qry.FieldByName('clienteId').AsInteger;
      Self.F_dataVenda  := qry.FieldByName('dataVenda').AsDateTime;
      Self.F_totalVenda := qry.FieldByName('totalVenda').AsFloat;

    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;
{$endregion}

end.
