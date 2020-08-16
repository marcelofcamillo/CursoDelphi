unit uCadAcaoAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, uEnum, cAcaoAcesso, uDTMConexao;

type
  TfrmCadAcaoAcesso = class(TfrmTelaHeranca)
    qryListagemacaoAcessoId: TIntegerField;
    qryListagemdescricao: TWideStringField;
    qryListagemchave: TWideStringField;
    edtDescricao: TLabeledEdit;
    edtAcaoAcessoId: TLabeledEdit;
    edtChave: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    oAcaoAcesso: TAcaoAcesso;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
  end;

var
  frmCadAcaoAcesso: TfrmCadAcaoAcesso;

implementation

{$R *.dfm}

{$region 'OVERRIDE'}
function TfrmCadAcaoAcesso.Apagar: Boolean;
begin
  if oAcaoAcesso.Selecionar(qryListagem.FieldByName('acaoAcessoId').AsInteger) then begin
     Result := oAcaoAcesso.Apagar;
  end;
end;

function TfrmCadAcaoAcesso.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
     Result := oAcaoAcesso.Inserir
  else if EstadoDoCadastro = ecAlterar then
     Result := oAcaoAcesso.Atualizar;
end;
{$endregion}

{$region 'EVENTS'}
procedure TfrmCadAcaoAcesso.btnAlterarClick(Sender: TObject);
begin
  if oAcaoAcesso.Selecionar(qryListagem.FieldByName('acaoAcessoId').AsInteger) then begin
     edtAcaoAcessoId.Text := IntToStr(oAcaoAcesso.codigo);
     edtDescricao.Text    := oAcaoAcesso.descricao;
     edtChave.Text        := oAcaoAcesso.chave;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;

end;

procedure TfrmCadAcaoAcesso.btnGravarClick(Sender: TObject);
begin
  if oAcaoAcesso.ChaveExiste(edtChave.Text) then begin
    MessageDlg('Chave j� cadastrada', mtInformation, [mbok], 0);
    edtChave.SetFocus;
    Abort;
  end;

  if edtacaoAcessoId.Text <> EmptyStr then
     oAcaoAcesso.codigo := StrToInt(edtAcaoAcessoId.Text)
  else
     oAcaoAcesso.codigo := 0;

  oAcaoAcesso.descricao := edtDescricao.Text;
  oAcaoAcesso.chave     := edtChave.Text;

  inherited;
end;

procedure TfrmCadAcaoAcesso.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDescricao.SetFocus;
end;

procedure TfrmCadAcaoAcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(oAcaoAcesso) then
     FreeAndNil(oAcaoAcesso);
end;

procedure TfrmCadAcaoAcesso.FormCreate(Sender: TObject);
begin
  inherited;

  oAcaoAcesso := TAcaoAcesso.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'descricao';
end;
{$endregion}
end.
