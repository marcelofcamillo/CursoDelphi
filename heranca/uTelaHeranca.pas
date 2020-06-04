unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, uDTMConexao, uEnum;

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
  private
    { Private declarations }
    EstadoDoCadastro: TEstadoDoCadastro;

    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
              btnApagar: TBitBtn; navegador: TDBNavigator; pgcPrincipal: TPageControl; flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(campo: String; aLabel: TLabel);
  public
    { Public declarations }
    IndiceAtual: String;
    function Excluir: Boolean; virtual;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; virtual;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

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
  // verifica se o tab está visível
  if (pgcPrincipal.Pages[indice].TabVisible) then
    pgcPrincipal.TabIndex := indice; // se estiver, coloca 0
end;
{$endregion}

{$region 'FUNÇÕES E PROCEDURES'}
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
{$endregion}

{$region 'MÉTODOS VIRTUAIS'}
function TfrmTelaHeranca.Excluir: Boolean;
begin
  ShowMessage('Deletado');
  Result := true;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro = ecInserir) then
      ShowMessage('Inserido')
  else if (EstadoDoCadastro = ecAlterar) then
      ShowMessage('Alterado');

  Result := true;
end;
{$endregion}

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if Excluir then begin
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
    ControlarIndiceTab(pgcPrincipal, 0); // não precisava
    EstadoDoCadastro := ecNenhum;
  end;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  try
    if Gravar(EstadoDoCadastro) then begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
    end;
  finally
    EstadoDoCadastro := ecNenhum;
  end;
end;

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecInserir;
end;

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close; // fecha a consulta
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  // garante que será setado quando o formulário for criado em tempo de execução
  qryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet    := qryListagem;
  grdListagem.DataSource := dtsListagem;
  grdListagem.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines,
                          dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection,
                          dgCancelOnExit, dgTitleClick, dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  // verifica se a consulta SQL está vazia ou não
  if (qryListagem.SQL.Text <> EmptyStr) then begin
    qryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    qryListagem.Open; // abre a consulta
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
end;

// pega o campo do grid que foi clicado
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

end.
