unit cProVenda;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection, ZConnection,
     ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils, Data.DB, Datasnap.DBClient,
     cControleEstoque, uEnum;

type
  TVenda = class
  private
    ConexaoDB: TZConnection;
    F_vendaId: Integer;
    F_clienteId: Integer;
    F_dataVenda: TDateTime;
    F_totalVenda: Double;
    function EsteItemExiste(vendaId, produtoId: Integer): Boolean;
    function InNot(cds: TClientDataSet): String;
    function AtualizarItem(cds: TClientDataSet): Boolean;
    function ApagaItens(cds: TClientDataSet): Boolean;
    function InserirItens(cds: TClientDataSet; idVenda: Integer): Boolean;
    procedure RetornarEstoque(sCodigo: String; Acao: TAcaoExcluirEstoque);
    procedure BaixarEstoque(produtoId: Integer; Quantidade: Double);

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir(cds: TClientDataSet): Integer;
    function Atualizar(cds: TClientDataSet): Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer; var cds: TClientDataSet): Boolean;

  published
    property VendaId    : Integer   read F_vendaId    write F_vendaId;
    property ClienteId  : Integer   read F_clienteId  write F_clienteId;
    property DataVenda  : TDateTime read F_dataVenda  write F_dataVenda;
    property TotalVenda : Double    read F_totalVenda write F_totalVenda;
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
{$endregion}

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
    qry.Connection := ConexaoDB;
    // apaga os itens primeiro
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM vendasItens WHERE vendaId = :vendaId');
    qry.ParamByName('vendaId').AsInteger := F_vendaId;

    try
      qry.ExecSQL;
      // apaga a tabela master
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM vendas WHERE vendaId= :vendaId');
      qry.ParamByName('vendaId').AsInteger := F_vendaId;
      qry.ExecSQL;

    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.InNot(cds: TClientDataSet): String;
var sInNot: String;
begin
  sInNot := EmptyStr;
  cds.First;

  while not cds.Eof do begin
    if sInNot = EmptyStr then
       sInNot := cds.FieldByName('produtoId').AsString
    else
       sInNot := sInNot + ',' + cds.FieldByName('produtoId').AsString;

    cds.Next;
  end;
  Result := sInNot;
end;

function TVenda.Atualizar(cds: TClientDataSet): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    ConexaoDB.StartTransaction;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE vendas SET clienteId = :clienteId, dataVenda = :dataVenda, ' +
                'totalVenda = :totalVenda WHERE vendaId = :vendaId');
    qry.ParamByName('vendaId').AsInteger    := Self.F_vendaId;
    qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    try
      // update
      qry.ExecSQL;

      // apaga os itens no banco que foram apagados na tela
      ApagaItens(cds);

      cds.First;

      while not cds.Eof do begin
        if EsteItemExiste(Self.F_vendaId, cds.FieldByName('produtoId').AsInteger) then begin
          AtualizarItem(cds);
        end
        else begin
          InserirItens(cds, Self.F_vendaId);
        end;
        cds.Next;
      end;
      ConexaoDB.Commit;
    except
      Result := false;
      ConexaoDB.Rollback;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.AtualizarItem(cds: TClientDataSet): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    RetornarEstoque(cds.FieldByName('produtoId').AsString, aeeAlterar);
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE vendasItens SET valorUnitario = :valorUnitario, quantidade = :quantidade, '+
                'totalProduto = :totalProduto WHERE vendaId = :vendaId AND produtoId = :produtoId');
    qry.ParamByName('vendaId').AsInteger     := Self.F_vendaId;
    qry.ParamByName('produtoId').AsInteger   := cds.FieldByName('produtoId').AsInteger;
    qry.ParamByName('valorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    qry.ParamByName('quantidade').AsFloat    := cds.FieldByName('quantidade').AsFloat;
    qry.ParamByName('totalProduto').AsFloat  := cds.FieldByName('valorTotalProduto').AsFloat;

    try
      qry.ExecSQL;
      BaixarEstoque(cds.FieldByName('produtoId').AsInteger, cds.FieldByName('quantidade').AsFloat);
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.ApagaItens(cds: TClientDataSet): Boolean;
var qry: TZQuery;
    sCodNoCds: String;
begin
  try
    Result := true;

    // pega os codigos que estão no cliente para sSelecionar o In Not no banco de dados
    sCodNoCds := InNot(cds);
    // retorna ao estoque
    RetornarEstoque(sCodNoCds, aeeApagar);

    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add(' DELETE FROM vendasItens WHERE vendaId = :vendaId '+
                'AND produtoId NOT IN ('+sCodNoCds+')');
    qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.Inserir(cds: TClientDataSet): Integer;
var qry: TZQuery;
    idVendaGerado: Integer;
begin
  try
    ConexaoDB.StartTransaction;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    // faz a inclusão no banco de dados
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO vendas (clienteId, dataVenda, totalVenda) VALUES (:clienteId, :dataVenda, :totalVenda)');
    qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    try
      qry.ExecSQL;
      // recupera o ID gerado no insert
      qry.SQL.Clear;
      qry.SQL.Add('SELECT SCOPE_IDENTITY() AS ID');
      qry.Open;

      // ID da tabela master (venda)
      idVendaGerado := qry.FieldByName('ID').AsInteger;

      {$region 'GRAVAR NA TABELA VendasItens'}
      cds.First;

      while not cds.Eof do begin
        InserirItens(cds, idVendaGerado);
        cds.Next;
      end;
      {$endRegion}

      ConexaoDB.Commit;
      Result := idVendaGerado;
    except
      ConexaoDB.Rollback;
      Result := -1;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.InserirItens(cds: TClientDataSet; idVenda: Integer): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO vendasItens ( vendaId, produtoId, valorUnitario, quantidade, totalProduto) '+
                'VALUES (:vendaId, :produtoId, :valorUnitario, :quantidade, :totalProduto)');
    qry.ParamByName('vendaId').AsInteger     := IdVenda;
    qry.ParamByName('produtoId').AsInteger   := cds.FieldByName('produtoId').AsInteger;
    qry.ParamByName('valorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    qry.ParamByName('quantidade').AsFloat    := cds.FieldByName('quantidade').AsFloat;
    qry.ParamByName('totalProduto').AsFloat  := cds.FieldByName('valorTotalProduto').AsFloat;

    try
      qry.ExecSQL;
      BaixarEstoque(cds.FieldByName('produtoId').AsInteger, cds.FieldByName('quantidade').AsFloat);
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.Selecionar(id: Integer; var cds: TClientDataSet): Boolean;
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

      {$region 'SELECIONAR NA TABELA VendasItens'}
      // apaga o ClientDataSet caso esteja com registro
      cds.First;

      while not cds.Eof do begin
        cds.Delete;
      end;

      // seleciona os itens do banco de dados com a propriedade F_vendaId
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT vendasItens.produtoId, produtos.nome, vendasItens.valorUnitario, '+
                  'vendasItens.quantidade, vendasItens.totalProduto FROM vendasItens  '+
                  'INNER JOIN produtos ON produtos.produtoId = vendasItens.produtoId '+
                  'WHERE vendasItens.vendaId = :vendaId');
      qry.ParamByName('VendaID').AsInteger    := Self.F_vendaId;
      qry.Open;

      // pega da query e coloca no ClientDataSet
      qry.First;

      while not qry.Eof do begin
        cds.Append;
        cds.FieldByName('produtoId').AsInteger       := qry.FieldByName('produtoId').AsInteger;
        cds.FieldByName('nomeProduto').AsString      := qry.FieldByName('nome').AsString;
        cds.FieldByName('valorUnitario').AsFloat     := qry.FieldByName('valorUnitario').AsFloat;
        cds.FieldByName('quantidade').AsFloat        := qry.FieldByName('quantidade').AsFloat;
        cds.FieldByName('valorTotalProduto').AsFloat := qry.FieldByName('totalProduto').AsFloat;
        cds.Post;
        qry.Next;
      end;

      cds.First;
      {$endRegion}

    Except
      Result := false;
    End;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TVenda.EsteItemExiste(vendaId: Integer; produtoId: Integer): Boolean;
var qry: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Count(vendaId) AS Qtde FROM VendasItens WHERE vendaId = :vendaId and produtoId = :produtoId');
    qry.ParamByName('vendaId').AsInteger   := vendaId;
    qry.ParamByName('produtoId').AsInteger := produtoId;

    try
      qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
         Result := true
      else
         Result := False;

    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

{$endregion}

{$region 'CONTROLE DE ESTOQUE'}
Procedure TVenda.RetornarEstoque(sCodigo: String; Acao: TAcaoExcluirEstoque);
var qry: TZQuery;
    oControleEstoque: TControleEstoque;
begin
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT produtoId, quantidade FROM VendasItens WHERE vendaId = :vendaId ');

    if Acao = aeeApagar then
       qry.SQL.Add('AND produtoId NOT IN ('+sCodigo+')')
    else
       qry.SQL.Add('AND produtoId = ('+sCodigo+')');

    qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;

    try
      oControleEstoque := TControleEstoque.Create(ConexaoDB);
      qry.Open;
      qry.First;

      while not Qry.Eof do begin
         oControleEstoque.produtoId  := qry.FieldByName('produtoId').AsInteger;
         oControleEstoque.quantidade := qry.FieldByName('quantidade').AsFloat;
         oControleEstoque.RetornarEstoque;
         qry.Next;
      end;

    finally
      if Assigned(oControleEstoque) then
         FreeAndNil(oControleEstoque);
    end;
end;

Procedure TVenda.BaixarEstoque(produtoId: Integer; quantidade: Double);
var oControleEstoque: TControleEstoque;
begin
    try
      oControleEstoque := TControleEstoque.Create(ConexaoDB);
      oControleEstoque.ProdutoId  := produtoId;
      oControleEstoque.Quantidade := Quantidade;
      oControleEstoque.BaixarEstoque;
    finally
      if Assigned(oControleEstoque) then
         FreeAndNil(oControleEstoque);
    end;
end;
{$endregion}

end.
