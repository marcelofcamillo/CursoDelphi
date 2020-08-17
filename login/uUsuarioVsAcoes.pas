unit uUsuarioVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, uDTMConexao,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmUsuarioVsAcoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    qryUsuario: TZQuery;
    qryAcoes: TZQuery;
    dtsUsuario: TDataSource;
    dtsAcoes: TDataSource;
    qryUsuariousuarioId: TIntegerField;
    qryUsuarionome: TWideStringField;
    qryAcoesusuarioId: TIntegerField;
    qryAcoesacaoAcessoId: TIntegerField;
    qryAcoesdescricao: TWideStringField;
    qryAcoesativo: TBooleanField;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure qryUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

{$R *.dfm}

procedure TfrmUsuarioVsAcoes.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDblClick(Sender: TObject);
var qry: TZQuery;
    bmRegistroAtual: TBookmark;
begin
  try
    bmRegistroAtual := qryAcoes.GetBookMark;
    qry := TZQuery.Create(nil);
    qry.Connection := dtmPrincipal.ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE usuariosAcaoAcesso SET ativo= :ativo '+
                'WHERE usuarioId = :usuarioId AND acaoAcessoId = :acaoAcessoId');
    qry.ParamByName('usuarioId').AsInteger    := qryAcoes.FieldByName('usuarioId').AsInteger;
    qry.ParamByName('acaoAcessoId').AsInteger := qryAcoes.FieldByName('acaoAcessoId').AsInteger;
    qry.ParamByName('ativo').AsBoolean        := not qryAcoes.FieldByName('ativo').AsBoolean;

    try
      dtmPrincipal.ConexaoDB.StartTransaction;
      qry.ExecSQL;
      dtmPrincipal.ConexaoDB.Commit;
    except
      dtmPrincipal.ConexaoDB.Rollback;
    end;

  finally
    SelecionarAcoesAcessoPorUsuario;
    qryAcoes.GotoBookMark(bmRegistroAtual);

    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not qryAcoes.FieldByName('ativo').AsBoolean then
  begin
    TDBGrid(Sender).Canvas.Font.Color := clWhite;
    TDBGrid(Sender).Canvas.Brush.Color := clRed
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].field, State);
end;

procedure TfrmUsuarioVsAcoes.FormShow(Sender: TObject);
begin
  try
    qryUsuario.DisableControls;
    qryUsuario.Open;
    SelecionarAcoesAcessoPorUsuario;
  finally
    qryUsuario.EnableControls;
  end;
end;

procedure TfrmUsuarioVsAcoes.qryUsuarioAfterScroll(DataSet: TDataSet);
begin
  SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuarioVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
  qryAcoes.Close;
  qryAcoes.ParamByName('usuarioId').AsInteger := qryUsuario.FieldByName('usuarioId').AsInteger;
  qryAcoes.Open;
end;

end.
