unit cCadCategoria;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs;

type
  TCategoria = class
    private
      F_categoriaId: Integer;
      F_descricao: String;
    function getCodigo: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);

    public
      constructor Create;
      destructor Destroy; override;

    published
      property codigo: Integer   read getCodigo    write setCodigo;
      property descricao: String read getDescricao write setDescricao;
  end;

implementation

{ TCategoria }

constructor TCategoria.Create;
begin
  //ShowMessage('Objeto criado.');
end;

destructor TCategoria.Destroy;
begin
  //ShowMessage('Objeto destruído.');
  inherited;
end;

function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;

procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := value;
end;

end.
