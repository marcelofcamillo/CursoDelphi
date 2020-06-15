unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, Vcl.Grids, Vcl.DBCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, uDTMConexao, uDTMVenda, RxToolEdit, RxCurrEdit,
  uEnum, cProVenda;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    qryListagemvendaId: TIntegerField;
    qryListagemclienteId: TIntegerField;
    qryListagemnome: TWideStringField;
    qryListagemdataVenda: TDateTimeField;
    qryListagemtotalVenda: TFloatField;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label4: TLabel;
    edtDataVenda: TDateEdit;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    edtValorTotal: TCurrencyEdit;
    Label2: TLabel;
    dbGridItensVenda: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    Label1: TLabel;
    edtValorUnitario: TCurrencyEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtQuantidade: TCurrencyEdit;
    btnAdicionarItem: TBitBtn;
    edtTotalProduto: TCurrencyEdit;
    btnRemoverItem: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure dbGridItensVendaDblClick(Sender: TObject);
  private
    { Private declarations }
    dtmVendas: TdtmVendas;
    oVenda: TVenda;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
    function TotalizarProduto(valorUnitario, quantidade: Double): Double;
    procedure LimparCds;
    procedure LimparComponenteItem;
    function TotalizarVenda: Double;
    procedure CarregarRegistroSelecionado;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}

{$region 'OVERRIDE'}
{
function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger) then begin
     Result := oVenda.Apagar;
  end;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtVendaId.Text <> EmptyStr then
     oVenda.VendaId := StrToInt(edtVendaId.Text)
  else
     oVenda.VendaId := 0;

  oVenda.ClienteId  := lkpCliente.KeyValue;
  oVenda.DataVenda  := edtDataVenda.Date;
  oVenda.TotalVenda := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
     Result := oVenda.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
     Result := oVenda.Atualizar;
end;
}

function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger, dtmVendas.cdsItensVenda) then begin
     Result := oVenda.Apagar;
  end;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtVendaId.Text <> EmptyStr then
     oVenda.VendaId:=StrToInt(edtVendaId.Text)
  else
     oVenda.vendaId := 0;

  oVenda.ClienteId  := lkpCliente.KeyValue;
  oVenda.DataVenda  := edtDataVenda.Date;
  oVenda.TotalVenda := edtValorTotal.Value;

  if EstadoDoCadastro = ecInserir then
     Result := oVenda.Inserir(dtmVendas.cdsItensVenda)
  else if EstadoDoCadastro = ecAlterar then
     Result := oVenda.Atualizar(dtmVendas.cdsItensVenda);
end;

{$endregion}

{$region 'EVENTS'}
procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;

  //if lkpProduto.KeyValue = null then begin
  if TDBLookupComboBox(Sender).KeyValue <> null then begin  
    edtValorUnitario.Value := dtmVendas.qryProdutos.FieldByName('valor').AsFloat;
    edtQuantidade.Value := 1;
    edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  end;
end;

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;

  if lkpProduto.KeyValue = null then begin
     MessageDlg('Produto é um campo obrigatório', mtInformation, [mbOK], 0);
     lkpProduto.SetFocus;
     Abort;
  end;

  if edtValorUnitario.value <= 0 then begin
     MessageDlg('Valor Unitário não pode ser zero', mtInformation, [mbOK], 0);
     edtValorUnitario.SetFocus;
     Abort;
  end;

  if edtQuantidade.value <= 0 then begin
     MessageDlg('Quantidade não pode ser zero', mtInformation, [mbOK], 0);
     edtQuantidade.SetFocus;
     Abort;
  end;

  // não repete o produto
  if dtmVendas.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
     MessageDlg('Este produto já foi selecionado.', mtInformation, [mbOK], 0);
     lkpProduto.SetFocus;
     Abort;
  end;

  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  with dtmVendas.cdsItensVenda do begin
    Append;
    FieldByName('produtoId').AsString        := lkpProduto.KeyValue;
    FieldByName('nomeProduto').AsString      := dtmVendas.qryProdutos.FieldByName('nome').AsString;
    FieldByName('quantidade').AsFloat        := edtQuantidade.Value;
    FieldByName('valorUnitario').AsFloat     := edtValorUnitario.Value;
    FieldByName('valorTotalProduto').AsFloat := edtTotalProduto.Value;
    Post;
  end;

  edtValorTotal.Value := TotalizarVenda;
  LimparComponenteItem;
  lkpProduto.SetFocus;

end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger, dtmVendas.cdsItensVenda) then begin
     edtVendaId.Text     := IntToStr(oVenda.vendaId);
     lkpCliente.KeyValue := oVenda.clienteId;
     edtDataVenda.Date   := oVenda.dataVenda;
     edtValorTotal.Value := oVenda.totalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;

  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.btnRemoverItemClick(Sender: TObject);
begin
  inherited;

  // verifica se o produto está selecionado
  if lkpProduto.KeyValue = null then begin
     MessageDlg('Selecione o produto a ser excluído.', mtInformation, [mbOK], 0);
     dbgridItensVenda.SetFocus;
     Abort;
  end;

  // localiza o produto dentro do ClientDataSet
  if dtmVendas.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
     dtmVendas.cdsItensVenda.Delete;
     LimparComponenteItem;
  end;

  edtValorTotal.Value := TotalizarVenda;
end;

procedure TfrmProVenda.dbGridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  bloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;

  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVendas) then
    FreeAndNil(dtmVendas);

  if Assigned(oVenda) then
     FreeAndNil(oVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVendas := TdtmVendas.Create(Self);

  oVenda := TVenda.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual := 'clienteId';
end;
{$endregion}

{$region 'FUNÇÕES E PROCEDURES'}
procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue    := dtmVendas.cdsItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.Value    := dtmVendas.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value := dtmVendas.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtTotalProduto.Value  := dtmVendas.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.KeyValue    := null;
  edtQuantidade.Value    := 0;
  edtValorUnitario.Value := 0;
  edtTotalProduto.Value  := 0;
end;

procedure TfrmProVenda.LimparCds;
begin
  while not dtmVendas.cdsItensVenda.Eof do
    dtmVendas.cdsItensVenda.Delete;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, quantidade:Double): Double;
begin
  result := valorUnitario * Quantidade;
end;

function TfrmProVenda.TotalizarVenda: Double;
begin
  Result := 0;
  dtmVendas.cdsItensVenda.First;

  while not dtmVendas.cdsItensVenda.Eof do begin
    Result := result + dtmVendas.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVendas.cdsItensVenda.Next;
  end;
end;

{$endregion}

end.
