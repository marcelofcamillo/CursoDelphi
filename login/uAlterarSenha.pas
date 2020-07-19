unit uAlterarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  cCadUsuario, uDTMConexao;

type
  TfrmAlterarSenha = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnFechar: TBitBtn;
    btnAlterar: TBitBtn;
    edtSenhaAtual: TEdit;
    edtNovaSenha: TEdit;
    edtRepeteNovaSenha: TEdit;
    Label3: TLabel;
    lblUsuarioLogado: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparEdits;
  public
    { Public declarations }
  end;

var
  frmAlterarSenha: TfrmAlterarSenha;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmAlterarSenha.btnAlterarClick(Sender: TObject);
var oUsuario: TUsuario;
begin
  if (edtSenhaAtual.Text = oUsuarioLogado.senha) then begin
    if (edtNovaSenha.Text = edtRepeteNovaSenha.Text) then begin
      try
        oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB);
        oUsuario.codigo := oUsuarioLogado.codigo;
        oUsuario.senha  := edtNovaSenha.Text;
        oUsuario.AlterarSenha;
        oUsuarioLogado.senha := edtNovaSenha.Text;
        MessageDlg('Senha alterada com sucesso!', mtInformation, [mbok], 0);
        LimparEdits;
      finally
        FreeAndNil(oUsuario);
      end;
    end
    else begin
      MessageDlg('As senhas digitadas não coincidem!', mtinformation, [mbok], 0);
      edtNovaSenha.SetFocus;
    end;
  end
  else begin
    MessageDlg('Senha atual inválida!', mtinformation, [mbok], 0);
  end;
end;

procedure TfrmAlterarSenha.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAlterarSenha.FormShow(Sender: TObject);
begin
  LimparEdits;
end;

procedure TfrmAlterarSenha.LimparEdits;
begin
  edtSenhaAtual.Clear;
  edtNovaSenha.Clear;
  edtRepeteNovaSenha.Clear;
  lblUsuarioLogado.Caption := oUsuarioLogado.nome;
end;

end.
