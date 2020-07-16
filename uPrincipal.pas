unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter,
  uCadCategoria, uCadCliente, uCadProduto, uFrmAtualizaDB, uProVenda, uRelCategoria,
  uRelCadCliente, uRelCadClienteFicha, uRelCadProduto, uRelCadProdutoComGrupoCategoria,
  uSelecionarData, uRelProVendaPorData;

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
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

{$region 'EVENTS'}
procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(Self); // cria na memória
  frmCadCategoria.ShowModal; // mostra na tela
  frmCadCategoria.Release; // tira da memória
end;

procedure TfrmPrincipal.Categorias1Click(Sender: TObject);
begin
  frmRelCategoria := TfrmRelCategoria.Create(Self);
  frmRelCategoria.relatorio.PreviewModal;
  frmRelCategoria.Release;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(Self);
  frmCadCliente.ShowModal;
  frmCadCliente.Release;
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  frmRelCadCliente := TfrmRelCadCliente.Create(Self);
  frmRelCadCliente.relatorio.PreviewModal;
  frmRelCadCliente.Release;
end;

procedure TfrmPrincipal.FichadeClientes1Click(Sender: TObject);
begin
  frmRelCadClienteFicha := TfrmRelCadClienteFicha.Create(Self);
  frmRelCadClienteFicha.relatorio.PreviewModal;
  frmRelCadClienteFicha.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmAtualizaDB := TfrmAtualizaDB.Create(Self);
  frmAtualizaDB.Show;
  frmAtualizaDB.Refresh;

  dtmPrincipal := TdtmPrincipal.Create(Self); // cria o formulário
  with dtmPrincipal.ConexaoDB do begin
    SQLHourGlass := false; // muda a ampulheta quando processar o banco
    Protocol := 'mssql'; // protocolo
    LibraryLocation := 'C:\CursoDelphi\ntwdblib.dll'; // biblioteca
    HostName := '.\SERVERCURSO'; // hostname
    Port := 1433; // porta do sql
    User := 'sa'; // usuário do banco de dados
    Password := 'mudar@123'; // senha do banco de dados
    Database := 'vendas'; // nome do banco de dados
    Connected := true; // conexão com o banco de dados
  end;

  AtualizacaoBancoDados(frmAtualizaDB);

  frmAtualizaDB.Free;

  TeclaEnter := TMREnter.Create(Self);
  TeclaEnter.FocusEnabled := true;
  TeclaEnter.FocusColor := clInfoBk; // cor (amarelo claro)
end;
{$endregion}

{$region 'BOTÕES'}
procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;
procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  frmCadProduto := TfrmCadProduto.Create(Self);
  frmCadProduto.ShowModal;
  frmCadProduto.Release;
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
begin
  frmRelCadProduto := TfrmRelCadProduto.Create(Self);
  frmRelCadProduto.relatorio.PreviewModal;
  frmRelCadProduto.Release;
end;

procedure TfrmPrincipal.ProdutosporCategoria1Click(Sender: TObject);
begin
  frmRelCadProdutoComGrupoCategoria := TfrmRelCadProdutoComGrupoCategoria.Create(Self);
  frmRelCadProdutoComGrupoCategoria.relatorio.PreviewModal;
  frmRelCadProdutoComGrupoCategoria.Release;
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
  frmProVenda := TfrmProVenda.Create(Self);
  frmProVenda.ShowModal;
  frmProVenda.Release;
end;

{$endregion}

{$region 'FUNÇÕES E PROCEDURES'}
procedure TfrmPrincipal.AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
begin
  aForm.chkConexao.Checked := true;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptCategorias.ExecSQL;
  aForm.chkCategoria.Checked := true;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptProdutos.ExecSQL;
  aForm.chkProduto.Checked := true;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptClientes.ExecSQL;
  aForm.chkCliente.Checked := true;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptVendas.ExecSQL;
  aForm.chkVendas.Checked := true;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptItensVendas.ExecSQL;
  aForm.chkItensVenda.Checked := true;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptUsuarios.ExecSQL;
  aForm.chkUsuarios.Checked := true;
  aForm.Refresh;
  Sleep(100);
end;
{$endregion}
end.
