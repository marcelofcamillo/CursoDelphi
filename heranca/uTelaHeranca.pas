unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, uDTMConexao, uEnum, RxToolEdit, RxCurrEdit, ZConnection;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    qryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
              btnApagar: TBitBtn; navegador: TDBNavigator; pgcPrincipal: TPageControl; flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(campo: String; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
    procedure mskPesquisaChange(Sender: TObject);
  public
    { Public declarations }
    IndiceAtual: String;
    EstadoDoCadastro: TEstadoDoCadastro;
    function Apagar: Boolean; virtual;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; virtual;
    procedure bloqueiaCTRL_DEL_DBGrid(var key: Word; shift: TShiftState);
    class function TenhoAcesso(aUsuarioId: Integer; aChave: String; aConexao: TZConnection): Boolean; static;

  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

{$region 'OBSERVA��ES'}
 // TAG: 1 - chave prim�ria - PK
 // TAG: 2 - campos obrigat�rios
{$endregion}

{$region 'PROCEDIMENTOS DE CONTROLE DE TELA'}
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
          btnApagar: TBitBtn; navegador: TDBNavigator; pgcPrincipal: TPageControl; flag: Boolean);
begin
  btnNovo.Enabled     := flag;
  btnApagar.Enabled   := flag;
  btnAlterar.Enabled  := flag;
  navegador.Enabled   := flag;
  pgcPrincipal.Pages[0].TabVisible := flag;
  btnCancelar.Enabled := not(flag);
  btnGravar.Enabled   := not(flag);
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; indice: Integer);
begin
  // verifica se o tab est� vis�vel
  if (pgcPrincipal.Pages[indice].TabVisible) then
    pgcPrincipal.TabIndex := indice; // se estiver, coloca 0
end;
{$endregion}

{$region 'FUN��ES E PROCEDURES'}
function TfrmTelaHeranca.RetornarCampoTraduzido(campo: String): String;
var i: Integer;
begin
  for i := 0 to qryListagem.Fields.Count-1 do begin
    if lowercase(qryListagem.Fields[i].FieldName) = lowercase(campo) then begin
      Result := qryListagem.Fields[i].DisplayLabel;
      Break;
    end;                                           
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(campo: String; aLabel: TLabel);
begin
  aLabel.Caption := RetornarCampoTraduzido(campo);
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio: Boolean;
var i: Integer;
begin
  Result := false;

  for i := 0 to ComponentCount -1 do begin
    if Components[i] is TLabeledEdit then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
      (TLabeledEdit(Components[i]).Text = EmptyStr) then begin
        MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
          ' � um campo obrigat�rio.', mtInformation, [mbOK], 0);

        TLabeledEdit(Components[i]).SetFocus;
        Result := true;
        Break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.DesabilitarEditPK;
var i: Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if Components[i] is TLabeledEdit then begin
      if TLabeledEdit(Components[i]).Tag = 1 then begin
        TLabeledEdit(Components[i]).Enabled := false;

        Break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i: Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if Components[i] is TLabeledEdit then
      TLabeledEdit(Components[i]).Text := EmptyStr
    else if Components[i] is TEdit then
      TEdit(Components[i]).Text := EmptyStr
    else if Components[i] is TMemo then
      TMemo(Components[i]).Text := EmptyStr
    else if Components[i] is TDBLookupComboBox then
      TDBLookupComboBox(Components[i]).KeyValue := null
    else if Components[i] is TCurrencyEdit then
      TCurrencyEdit(Components[i]).Value := 0
    else if Components[i] is TDateEdit then
      TDateEdit(Components[i]).Date := 0
    else if Components[i] is TMaskEdit then
      TMaskEdit(Components[i]).Text := EmptyStr;
  end;
end;

procedure TfrmTelaHeranca.mskPesquisaChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text,[loPartialKey])
end;

procedure TfrmTelaHeranca.bloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
  // bloqueia o CRTL + DEL
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;
end;

class function TfrmTelaHeranca.TenhoAcesso(aUsuarioId: Integer; aChave: String; aConexao: TZConnection): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := aConexao;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT usuarioId FROM usuariosAcaoAcesso WHERE usuarioId = :usuarioId '+
                'AND acaoAcessoId = (SELECT TOP 1 acaoAcessoId FROM acaoAcesso '+
                'WHERE chave = :chave) AND ativo = 1');
    qry.ParamByName('usuarioId').AsInteger := aUsuarioId;
    qry.ParamByName('chave').AsString      := aChave;
    qry.Open;

    if qry.IsEmpty then
       Result := false

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;
{$endregion}

// est�o sobrescritos, n�o tem mais funcionalidade
{$region 'M�TODOS VIRTUAIS'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
  ShowMessage('Deletado.');
  Result := true;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro = ecInserir) then
      ShowMessage('Inserido.')
  else if (EstadoDoCadastro = ecAlterar) then
      ShowMessage('Alterado.');

  Result := true;
end;
{$endregion}

{$region 'BOT�ES'}
procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  try
    if Apagar then begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0); // n�o precisava
      LimparEdits;
      qryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na exclus�o.', mtError, [mbOK], 0);
    end;
  finally
    EstadoDoCadastro := ecNenhum;
  end;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if ExisteCampoObrigatorio then
    Abort;

  try
    if Gravar(EstadoDoCadastro) then begin // m�todo virtual
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      qryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na grava��o.', mtError, [mbOK], 0);
    end;
  finally

  end;
end;

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecInserir;
  LimparEdits;
end;
{$endregion}

{$region 'EVENTS'}
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close; // fecha a consulta
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  // garante que ser� setado quando o formul�rio for criado em tempo de execu��o
  qryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet    := qryListagem;
  grdListagem.DataSource := dtsListagem;
  grdListagem.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines,
                          dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection,
                          dgCancelOnExit, dgTitleClick, dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  // verifica se a consulta SQL est� vazia ou n�o
  if (qryListagem.SQL.Text <> EmptyStr) then begin
    qryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    qryListagem.Open; // abre a consulta
  end;

  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
end;

// pega o campo do grid que foi clicado
procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  bloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  qryListagem.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;
procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  qryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;
{$endregion}

end.
