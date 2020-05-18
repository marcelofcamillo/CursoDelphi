unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao;

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
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
              btnApagar: TBitBtn; navegador: TDBNavigator; pgcPrincipal: TPageControl; flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; indice: Integer);
  public
    { Public declarations }
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

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0); // não precisava
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
end;

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, false);
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  // garante que será setado quando o formulário for criado em tempo de execução
  qryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet := qryListagem;
  grdListagem.DataSource := dtsListagem;
end;

end.
