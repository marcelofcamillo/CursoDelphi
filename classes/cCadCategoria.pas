unit cCadCategoria;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs;

type
  TCategoria = class
    private

    public
      constructor Create;
      destructor Destroy; override;
    published
  end;

implementation

{ TCategoria }

constructor TCategoria.Create;
begin
  ShowMessage('Objeto criado.');
end;

destructor TCategoria.Destroy;
begin
  ShowMessage('Objeto destru�do.');
  inherited;
end;

end.
