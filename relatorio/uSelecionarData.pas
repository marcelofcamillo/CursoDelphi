unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, RxToolEdit,
  System.DateUtils;

type
  TfrmSelecionarData = class(TForm)
    edtDataInicial: TDateEdit;
    Label3: TLabel;
    Label1: TLabel;
    DateEdit1: TDateEdit;
    edtDataFinal: TDateEdit;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

procedure TfrmSelecionarData.btnOkClick(Sender: TObject);
begin
  if (edtDataFinal.Date) < (edtDataInicial.Date) then begin
    MessageDlg('Data final não pode ser maior que a data inicial!', mtInformation, [mbok], 0);
    edtDataFinal.SetFocus;
    Abort;
  end;

  if (edtDataFinal.Date = 0) OR (edtDataInicial.Date = 0) then begin
    MessageDlg('Data inicial ou final são campos obrigatórios!', mtInformation, [mbok], 0);
    edtDataInicial.SetFocus;
    Abort;
  end;

  Close;
end;

procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  edtDataInicial.Date := StartOfTheMonth(Date);
  edtDataFinal.Date  := EndOfTheMonth(Date);
end;

end.
