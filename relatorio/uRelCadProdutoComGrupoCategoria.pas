unit uRelCadProdutoComGrupoCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport, RLFilters,
  RLPDFFilter, RLXLSXFilter, RLXLSFilter;

type
  TfrmRelCadProdutoComGrupoCategoria = class(TForm)
    qryProdutos: TZQuery;
    dtsProdutos: TDataSource;
    relatorio: TRLReport;
    cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel3: TRLLabel;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    RLLabel2: TRLLabel;
    qryProdutosprodutoId: TIntegerField;
    qryProdutosnome: TWideStringField;
    qryProdutosdescricao: TWideStringField;
    qryProdutosvalor: TFloatField;
    qryProdutosquantidade: TFloatField;
    qryProdutoscategoriaId: TIntegerField;
    qryProdutosDescricaoCategoria: TWideStringField;
    bandaDoGrupo: TRLGroup;
    RLBand2: TRLBand;
    RLBand1: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    detail: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel8: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel9: TRLLabel;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDraw3: TRLDraw;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBResult2: TRLDBResult;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadProdutoComGrupoCategoria: TfrmRelCadProdutoComGrupoCategoria;

implementation

{$R *.dfm}

procedure TfrmRelCadProdutoComGrupoCategoria.FormCreate(Sender: TObject);
begin
  qryProdutos.Open;
end;

procedure TfrmRelCadProdutoComGrupoCategoria.FormDestroy(Sender: TObject);
begin
  qryProdutos.Close;
end;

end.
