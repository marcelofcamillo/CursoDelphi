unit uRelCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport, RLFilters,
  RLPDFFilter, RLXLSXFilter, RLXLSFilter;

type
  TfrmRelCadCliente = class(TForm)
    qryClientes: TZQuery;
    dtsClientes: TDataSource;
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
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    detail: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand1: TRLBand;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    qryClientesclienteId: TIntegerField;
    qryClientesnome: TWideStringField;
    qryClientesemail: TWideStringField;
    qryClientestelefone: TWideStringField;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLPanel1: TRLPanel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadCliente: TfrmRelCadCliente;

implementation

{$R *.dfm}

procedure TfrmRelCadCliente.FormCreate(Sender: TObject);
begin
  qryClientes.Open;
end;

procedure TfrmRelCadCliente.FormDestroy(Sender: TObject);
begin
  qryClientes.Close;
end;

end.
