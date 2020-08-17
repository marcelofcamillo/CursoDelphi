unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter,
  uCadCategoria, uCadCliente, uCadProduto, uFrmAtualizaDB, uProVenda, uRelCadCategoria,
  uRelCadCliente, uRelCadClienteFicha, uRelCadProduto, uRelCadProdutoComGrupoCategoria,
  uSelecionarData, uRelProVendaPorData, uCadUsuario, uLogin, uAlterarSenha, cUsuarioLogado,
  Vcl.ComCtrls, ZDbcIntfs, cAtualizacaoBancoDeDados, uCadAcaoAcesso, cAcaoAcesso,
  uTelaHeranca, RLReport, uUsuarioVsAcoes;

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
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure CriarForm(aNomeForm: TFormClass);
    procedure CriarRelatorio(aNomeForm: TFormClass);
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
  CriarForm(TfrmCadCategoria);
end;

procedure TfrmPrincipal.Categorias1Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadCategoria);
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  CriarForm(TfrmCadCliente);
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadCliente);
end;

procedure TfrmPrincipal.FichadeClientes1Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadClienteFicha);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);

  if Assigned(oUsuarioLogado) then
     FreeAndNil(oUsuarioLogado);
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
    LibraryLocation := 'D:\Cursos\CursoDelphi\ntwdblib.dll'; // biblioteca
    HostName := '.\SERVERCURSO'; // hostname
    Port := 1433; // porta do sql
    User := 'sa'; // usuário do banco de dados
    Password := 'mudar@123'; // senha do banco de dados
    Database := 'vendas'; // nome do banco de dados
    AutoCommit := true;
    TransactIsolationLevel := tiReadCommitted;
    Connected := true; // conexão com o banco de dados
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
    stbPrincipal.Panels[0].Text := 'Usuário: ' + oUsuarioLogado.nome;
  end;
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
  CriarForm(TfrmCadProduto);
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadProduto);
end;

procedure TfrmPrincipal.ProdutosporCategoria1Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadProdutoComGrupoCategoria);
end;

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  CriarForm(TfrmCadUsuario);
end;

procedure TfrmPrincipal.UsuriosvsAes1Click(Sender: TObject);
begin
  CriarForm(TfrmUsuarioVsAcoes);
end;

procedure TfrmPrincipal.Vendapordata1Click(Sender: TObject);
begin  
  try
    frmSelecionarData := TfrmSelecionarData.Create(Self);
    
    if TfrmTelaHeranca.TenhoAcesso(oUsuarioLogado.codigo, frmSelecionarData.Name, dtmPrincipal.ConexaoDB) then
    begin
      frmSelecionarData.ShowModal;

      frmRelProVendaPorData := TfrmRelProVendaPorData.Create(Self);
      frmRelProVendaPorData.qryVendas.Close;
      frmRelProVendaPorData.qryVendas.ParamByName('dataInicial').AsDate := frmSelecionarData.edtDataInicial.Date;
      frmRelProVendaPorData.qryVendas.ParamByName('dataFinal').AsDate := frmSelecionarData.edtDataFinal.Date;
      frmRelProVendaPorData.qryVendas.Open;
      frmRelProVendaPorData.relatorio.PreviewModal;
    end
    else begin
       MessageDlg('Usuário: ' +oUsuarioLogado.nome+ ' não tem permissão de acesso!', mtWarning, [mbOK], 0);
    end;
  finally
    if Assigned(frmSelecionarData) then
      frmSelecionarData.Release;
    if Assigned(frmRelProVendaPorData) then
      frmRelProVendaPorData.Release;
  end;
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
begin
  CriarForm(TfrmProVenda);
end;

{$endregion}

{$region 'FUNÇÕES E PROCEDURES'}
procedure TfrmPrincipal.Alterarsenha1Click(Sender: TObject);
begin
  CriarForm(TfrmAlterarSenha);
end;

procedure TfrmPrincipal.AcaodeAcesso1Click(Sender: TObject);
begin
  CriarForm(TfrmCadAcaoAcesso);
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

procedure TfrmPrincipal.CriarForm(aNomeForm: TFormClass);
var form: TForm;
begin
  try
    form := aNomeForm.Create(Application);
    if TfrmTelaHeranca.TenhoAcesso(oUsuarioLogado.codigo, form.Name, dtmPrincipal.ConexaoDB) then
    begin
      form.ShowModal;
    end
    else begin
       MessageDlg('Usuário: ' +oUsuarioLogado.nome+ ' não tem permissão de acesso!', mtWarning, [mbOK], 0);
    end;
  finally
    if Assigned(form) then
       form.Release;
  end;
end;

procedure TfrmPrincipal.CriarRelatorio(aNomeForm: TFormClass);
var form: TForm;
    aRelatorio: TRLReport;
    i: Integer;
begin
  try
    form := aNomeForm.Create(Application);
    if TfrmTelaHeranca.TenhoAcesso(oUsuarioLogado.codigo, form.Name,DtmPrincipal.ConexaoDB) then
    begin
      for I := 0 to form.ComponentCount-1 do
      begin
        if form.Components[i] is TRLReport then
        begin
           TRLReport(form.Components[i]).PreviewModal;
           Break;
        end;
      end;
    end
    else begin
       MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso!',mtWarning,[mbOK],0);
    end;
  finally
    if Assigned(form) then
       form.Release;
  end;
end;
{$endregion}

end.
