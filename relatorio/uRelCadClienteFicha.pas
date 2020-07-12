unit uRelCadClienteFicha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDTMConexao, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RLReport, RLFilters,
  RLPDFFilter, RLXLSXFilter, RLXLSFilter;

type
  TfrmRelCadClienteFicha = class(TForm)
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
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    qryClientesclienteId: TIntegerField;
    qryClientesnome: TWideStringField;
    qryClientescep: TWideStringField;
    qryClientesendereco: TWideStringField;
    qryClientesbairro: TWideStringField;
    qryClientescidade: TWideStringField;
    qryClientesestado: TWideStringField;
    qryClientesemail: TWideStringField;
    qryClientestelefone: TWideStringField;
    qryClientesdataNascimento: TDateTimeField;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel9: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText10: TRLDBText;
    RLDraw3: TRLDraw;
    RLAngleLabel1: TRLAngleLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadClienteFicha: TfrmRelCadClienteFicha;

implementation

{$R *.dfm}

procedure TfrmRelCadClienteFicha.FormCreate(Sender: TObject);
begin
  qryClientes.Open;
end;

procedure TfrmRelCadClienteFicha.FormDestroy(Sender: TObject);
begin
  qryClientes.Close;
end;

end.
