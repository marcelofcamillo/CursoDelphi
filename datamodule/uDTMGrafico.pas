unit uDTMGrafico;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TdtmGrafico = class(TDataModule)
    dtsProdutoEstoque: TDataSource;
    qryProdutoEstoque: TZQuery;
    qryVendaValorPorCliente: TZQuery;
    qryVendaValorPorClienteLabel: TWideStringField;
    qryVendaValorPorClienteValue: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmGrafico: TdtmGrafico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
