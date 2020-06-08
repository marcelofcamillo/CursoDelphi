unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, uCadCategoria, uCadCliente, Enter;

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
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
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

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(Self);
  frmCadCliente.ShowModal;
  frmCadCliente.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
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
{$endregion}

end.
