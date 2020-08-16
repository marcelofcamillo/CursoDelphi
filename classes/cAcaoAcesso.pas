unit cAcaoAcesso;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Forms, Vcl.Buttons,
     ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
     ZDataset, System.SysUtils;

type
  TAcaoAcesso = class

  private
    ConexaoDB: TZConnection;
    F_acaoAcessoId: Integer;
    F_descricao: String;
    F_chave: String;
    class procedure PreencherAcoes(aForm: TForm; aConexao: TZConnection); static;

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
    function ChaveExiste(aChave: String): Boolean;

    class procedure CriarAcoes(aNomeForm: TFormClass; aConexao: TZConnection); static;

  published
    property codigo    : Integer read F_acaoAcessoId write F_acaoAcessoId;
    property descricao : string  read F_descricao    write F_descricao;
    property chave     : string  read F_chave        write F_chave;

  end;

implementation

{ TCategoria }

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TAcaoAcesso.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TAcaoAcesso.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TAcaoAcesso.Apagar: Boolean;
var qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' +#13+#13+
                'Código: ' +IntToStr(F_acaoAcessoId) +#13+
                'Nome: '  + F_descricao, mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
     Result := false;
     Abort;
  end;

  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM acaoAcesso WHERE acaoAcessoId = :acaoAcessoId');
    qry.ParamByName('acaoAcessoId').AsInteger := F_acaoAcessoId;

    try
      ConexaoDB.StartTransaction;
      qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TAcaoAcesso.Atualizar: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE acaoAcesso SET descricao = :descricao, '+
                'chave = :chave WHERE acaoAcessoId = :acaoAcessoId');
    qry.ParamByName('acaoAcessoId').AsInteger := Self.F_acaoAcessoId;
    qry.ParamByName('descricao').AsString     := Self.F_descricao;
    qry.ParamByName('chave').AsString         := Self.F_chave;

    try
      ConexaoDB.StartTransaction;
      qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TAcaoAcesso.Inserir: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO acaoAcesso (descricao, chave) VALUES (:descricao, :chave )');

    qry.ParamByName('descricao').AsString := Self.F_descricao;
    qry.ParamByName('chave').AsString     := Self.F_chave;

    try
      ConexaoDB.StartTransaction;
      qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TAcaoAcesso.Selecionar(id: Integer): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT acaoAcessoId, descricao, chave FROM acaoAcesso '+
                'WHERE acaoAcessoId = :acaoAcessoId');
    qry.ParamByName('acaoAcessoId').AsInteger := id;

    try
      qry.Open;
      Self.F_acaoAcessoId := Qry.FieldByName('acaoAcessoId').AsInteger;
      Self.F_descricao    := Qry.FieldByName('descricao').AsString;
      Self.F_chave        := Qry.FieldByName('chave').AsString;;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TAcaoAcesso.ChaveExiste(aChave: String): Boolean;
var qry: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT COUNT(acaoAcessoId) AS Qtde FROM acaoAcesso WHERE chave = :chave');
    qry.ParamByName('chave').AsString := aChave;

    try
      qry.Open;

      if qry.FieldByName('Qtde').AsInteger > 0 then
         result := true
      else
         result := false;

    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

class procedure TAcaoAcesso.PreencherAcoes(aForm: TForm; aConexao: TZConnection);
var i: Integer;
    oAcaoAcesso: TAcaoAcesso;
begin
  try
    oAcaoAcesso := TAcaoAcesso.Create(aConexao);
    oAcaoAcesso.descricao := aForm.Caption;
    oAcaoAcesso.Chave := aForm.Name;

    if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.Chave) then
       oAcaoAcesso.Inserir;

    for I := 0 to aForm.ComponentCount -1 do
    begin
      if (aForm.Components[i] is TBitBtn) then
      begin
        if TBitBtn(aForm.Components[i]).Tag = 99 then
        begin
          oAcaoAcesso.descricao := TBitBtn(aForm.Components[i]).Caption;
          oAcaoAcesso.Chave     := aForm.Name+'_'+TBitBtn(aForm.Components[i]).Name;
          if not oAcaoAcesso.ChaveExiste(oAcaoAcesso.Chave) then
             oAcaoAcesso.Inserir;
        end;
      end;
    end;
  finally
    if Assigned(oAcaoAcesso) then
       FreeAndNil(oAcaoAcesso);
  end;
end;

class procedure TAcaoAcesso.CriarAcoes(aNomeForm: TFormClass; aConexao: TZConnection);
var
  form: TForm;
begin
  try
    form := aNomeForm.Create(Application);
    PreencherAcoes(form,aConexao);
  finally
    if Assigned(form) then
       form.Release;
  end;
end;
{$endregion}

end.
