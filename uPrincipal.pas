unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter, uCadCategoria, uCadCliente,
  uCadProduto, uFrmAtualizaDB, uProVenda, uRelCadCategoria, uRelCadCliente, uRelCadClienteFicha,
  uRelCadProduto, uRelCadProdutoComGrupoCategoria, uSelecionarData, uRelProVendaPorData, uCadUsuario,
  uLogin, uAlterarSenha, cUsuarioLogado, Vcl.ComCtrls, ZDbcIntfs, cAtualizacaoBancoDeDados,
  uCadAcaoAcesso, cAcaoAcesso, uDTMGrafico, uTelaHeranca, RLReport, uUsuarioVsAcoes, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, Data.DB, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, Vcl.StdCtrls, cFuncao;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    Cadsatro1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrio1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    mnuFechar: TMenuItem;
    Vendas1: TMenuItem;
    Cliente2: TMenuItem;
    N3: TMenuItem;
    Produto2: TMenuItem;
    N4: TMenuItem;
    Vendapordata1: TMenuItem;
    Categorias1: TMenuItem;
    FichadeClientes1: TMenuItem;
    ProdutosporCategoria1: TMenuItem;
    Usurios1: TMenuItem;
    N5: TMenuItem;
    Alterarsenha1: TMenuItem;
    stbPrincipal: TStatusBar;
    AcaodeAcesso1: TMenuItem;
    N6: TMenuItem;
    UsuriosvsAes1: TMenuItem;
    gridPanel: TGridPanel;
    pnlDashboard: TPanel;
    DBChart1: TDBChart;
    Label1: TLabel;
    Series1: TBarSeries;
    DBChart2: TDBChart;
    Series2: TPieSeries;
    DBChart3: TDBChart;
    PieSeries1: TPieSeries;
    DBChart4: TDBChart;
    Series3: TFastLineSeries;
    tmrAtualizacaoDashboard: TTimer;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure Categorias1Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure FichadeClientes1Click(Sender: TObject);
    procedure Produto2Click(Sender: TObject);
    procedure ProdutosporCategoria1Click(Sender: TObject);
    procedure Vendapordata1Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Alterarsenha1Click(Sender: TObject);
    procedure AcaodeAcesso1Click(Sender: TObject);
    procedure UsuriosvsAes1Click(Sender: TObject);
    procedure pnlDashboardClick(Sender: TObject);
    procedure tmrAtualizacaoDashboardTimer(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure AtualizarDashboard;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  oUsuarioLogado: TUsuarioLogado;

implementation

{$R *.dfm}

{$region 'EVENTS'}
procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Categorias1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.FichadeClientes1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadClienteFicha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
  FreeAndNil(dtmGrafico);

  if Assigned(oUsuarioLogado) then
     FreeAndNil(oUsuarioLogado);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmAtualizaDB := TfrmAtualizaDB.Create(Self);
  frmAtualizaDB.Show;
  frmAtualizaDB.Refresh;

  dtmPrincipal := TdtmPrincipal.Create(Self); // cria o formul�rio
  with dtmPrincipal.ConexaoDB do begin
    SQLHourGlass := false; // muda a ampulheta quando processar o banco
    Protocol := 'mssql'; // protocolo
    LibraryLocation := 'D:\Cursos\CursoDelphi\ntwdblib.dll'; // biblioteca
    HostName := '.\SERVERCURSO'; // hostname
    Port := 1433; // porta do sql
    User := 'sa'; // usu�rio do banco de dados
    Password := 'mudar@123'; // senha do banco de dados
    Database := 'vendas'; // nome do banco de dados
    AutoCommit := true;
    TransactIsolationLevel := tiReadCommitted;
    Connected := true; // conex�o com o banco de dados
  end;

  AtualizacaoBancoDados(frmAtualizaDB);

  TAcaoAcesso.CriarAcoes(TfrmCadCategoria, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmCadCliente, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmCadProduto, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmCadUsuario, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmAlterarSenha, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmProVenda, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmRelProVendaPorData, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmRelCadClienteFicha, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmRelCadCliente, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmRelCadProdutoComGrupoCategoria, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmRelCadProduto, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmRelCadCategoria, dtmPrincipal.ConexaoDB);
  TAcaoAcesso.CriarAcoes(TfrmUsuarioVsAcoes, dtmPrincipal.ConexaoDB);

  TAcaoAcesso.PreencherUsuariosVsAcoes(DtmPrincipal.ConexaoDB);

  dtmGrafico := TdtmGrafico.Create(Self);
  AtualizarDashboard;

  frmAtualizaDB.Free;

  TeclaEnter := TMREnter.Create(Self);
  TeclaEnter.FocusEnabled := true;
  TeclaEnter.FocusColor := clInfoBk; // cor (amarelo claro)
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  try
    oUsuarioLogado := TUsuarioLogado.Create;

    frmLogin := TfrmLogin.Create(Self);
    frmLogin.ShowModal;

  finally
    frmLogin.Release;
    stbPrincipal.Panels[0].Text := 'Usu�rio: ' + oUsuarioLogado.nome;
  end;
end;

{$endregion}

{$region 'BOT�ES'}
procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;

procedure TfrmPrincipal.pnlDashboardClick(Sender: TObject);
begin
  AtualizarDashboard;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.ProdutosporCategoria1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadProdutoComGrupoCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.tmrAtualizacaoDashboardTimer(Sender: TObject);
begin
  AtualizarDashboard;
end;

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadUsuario, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.UsuriosvsAes1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmUsuarioVsAcoes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Vendapordata1Click(Sender: TObject);
begin  
  try
    frmSelecionarData := TfrmSelecionarData.Create(Self);
    frmSelecionarData.ShowModal;

    frmRelProVendaPorData := TfrmRelProVendaPorData.Create(Self);
      frmRelProVendaPorData.qryVendas.Close;
      frmRelProVendaPorData.qryVendas.ParamByName('dataInicial').AsDate := frmSelecionarData.edtDataInicial.Date;
      frmRelProVendaPorData.qryVendas.ParamByName('dataFinal').AsDate := frmSelecionarData.edtDataFinal.Date;
      frmRelProVendaPorData.qryVendas.Open;
      frmRelProVendaPorData.relatorio.PreviewModal;
  finally
    frmSelecionarData.Release;
    frmRelProVendaPorData.Release;
  end;
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmProVenda, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

{$endregion}

{$region 'FUN��ES E PROCEDURES'}
procedure TfrmPrincipal.Alterarsenha1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmAlterarSenha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AcaodeAcesso1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadAcaoAcesso, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
var oAtualizarMSSQL: TAtualizaBancoDadosMSSQL;
begin
  aForm.Refresh;

  try
    oAtualizarMSSQL := TAtualizaBancoDadosMSSQL.Create(dtmPrincipal.ConexaoDB);
    oAtualizarMSSQL.AtualizarBancoDeDadosMSSQL;
  finally
    if Assigned(oAtualizarMSSQL) then
       FreeAndNil(oAtualizarMSSQL);
  end;
end;

procedure TfrmPrincipal.AtualizarDashboard;
begin
  try
    Screen.Cursor := crSQLWait;

    if dtmGrafico.qryProdutoEstoque.Active then
      dtmGrafico.qryProdutoEstoque.Close;

    if dtmGrafico.qryVendaValorPorCliente.Active then
      dtmGrafico.qryVendaValorPorCliente.Close;

    if dtmGrafico.qryVendasUltimaSemana.Active then
      dtmGrafico.qryVendasUltimaSemana.Close;

    if dtmGrafico.qry10ProdutosMaisVendidos.Active then
      dtmGrafico.qry10ProdutosMaisVendidos.Close;

    dtmGrafico.qryProdutoEstoque.Open;
    dtmGrafico.qryVendaValorPorCliente.Open;
    dtmGrafico.qryVendasUltimaSemana.Open;
    dtmGrafico.qry10ProdutosMaisVendidos.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;
{$endregion}

end.
