unit uRelProVendaPorData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport, RLFilters,
  RLPDFFilter, RLXLSXFilter, RLXLSFilter;

type
  TfrmRelProVendaPorData = class(TForm)
    qryVendas: TZQuery;
    dtsVendas: TDataSource;
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
    bandaDoGrupo: TRLGroup;
    RLBand2: TRLBand;
    RLBand1: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    detail: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel8: TRLLabel;
    RLDBText6: TRLDBText;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDraw3: TRLDraw;
    RLLabel10: TRLLabel;
    qryVendasvendaId: TIntegerField;
    qryVendasclienteId: TIntegerField;
    qryVendasnome: TWideStringField;
    qryVendasdataVenda: TDateTimeField;
    qryVendastotalVenda: TFloatField;
    RLBand3: TRLBand;
    RLDBResult2: TRLDBResult;
    RLDraw4: TRLDraw;
    RLLabel6: TRLLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelProVendaPorData: TfrmRelProVendaPorData;

implementation

{$R *.dfm}

procedure TfrmRelProVendaPorData.FormCreate(Sender: TObject);
begin
  qryVendas.Open;
end;

procedure TfrmRelProVendaPorData.FormDestroy(Sender: TObject);
begin
  qryVendas.Close;
end;

end.
