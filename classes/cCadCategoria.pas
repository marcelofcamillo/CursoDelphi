unit cCadCategoria;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, uDTMConexao,
  ZAbstractConnection, ZConnection;

type
  TCategoria = class
    private
      ConexaoDB: TZConnection;
      F_categoriaId: Integer;
      F_descricao: String;

      function getCodigo: Integer;
      function getDescricao: String;
      procedure setCodigo(const Value: Integer);
      procedure setDescricao(const Value: String);

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Gravar: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer): Boolean;

    published
      property codigo: Integer   read getCodigo    write setCodigo;
      property descricao: String read getDescricao write setDescricao;
  end;

implementation

{ TCategoria }

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TCategoria.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  //ShowMessage('Objeto criado.');
end;

destructor TCategoria.Destroy;
begin
  //ShowMessage('Objeto destruído.');
  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TCategoria.Apagar: Boolean;
begin
  ShowMessage('Apagado.');
  Result := true;
end;

function TCategoria.Atualizar: Boolean;
begin
  ShowMessage('Atualizado.');
  Result := true;
end;

function TCategoria.Gravar: Boolean;
begin
  //ShowMessage('Gravado.');
  //Result := true;
  Result := false;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
begin
  Result := true;
end;
{$endregion}

{$region 'GETS'}
function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;
{$endregion}

{$region 'SETS'}
procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := value;
end;
{$endregion}

end.
