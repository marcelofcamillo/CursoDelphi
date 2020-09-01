unit uConsultaCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaCategoria = class(TfrmTelaHerancaConsulta)
    qryListagemcategoriaId: TIntegerField;
    qryListagemdescricao: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCategoria: TfrmConsultaCategoria;

implementation

{$R *.dfm}

procedure TfrmConsultaCategoria.FormCreate(Sender: TObject);
begin
  aCampoId := 'categoriaId';
  IndiceAtual := 'descricao';

  inherited;

end;

end.
