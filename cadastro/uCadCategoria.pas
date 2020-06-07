unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, uDTMConexao,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, cCadCategoria, uEnum;

type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    qryListagemcategoriaId: TIntegerField;
    qryListagemdescricao: TWideStringField;
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    oCategoria: TCategoria;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'OVERRIDE'}
function TfrmCadCategoria.Apagar: Boolean;
begin
  Result := oCategoria.Apagar;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
    Result := oCategoria.Gravar
  else if EstadoDoCadastro = ecAlterar then
    Result := oCategoria.Atualizar;
end;
{$endregion}

{$region 'EVENTS'}
procedure TfrmCadCategoria.btnGravarClick(Sender: TObject);
begin
  {oCategoria.codigo := 100;
  oCategoria.descricao := 'Teste';

  ShowMessage(oCategoria.descricao);}
  inherited;

end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCategoria) then
    FreeAndNil(oCategoria);
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria  := TCategoria.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'descricao';
end;
{$endregion}

end.
