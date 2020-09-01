unit uConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaProduto = class(TfrmTelaHerancaConsulta)
    qryListagemprodutoId: TIntegerField;
    qryListagemnome: TWideStringField;
    qryListagemdescricao: TWideStringField;
    qryListagemvalor: TFloatField;
    qryListagemquantidade: TFloatField;
    qryListagemcategoriaId: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaProduto: TfrmConsultaProduto;

implementation

{$R *.dfm}

procedure TfrmConsultaProduto.FormCreate(Sender: TObject);
begin
  aCampoId := 'produtoId';
  IndiceAtual := 'nome';

  inherited;

end;

end.
