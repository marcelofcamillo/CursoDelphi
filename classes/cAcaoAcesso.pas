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
    class procedure VerificarUsuarioAcao(aUsuarioId, aAcaoAcessoId: Integer; aConexao: TZConnection); static;

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
    function ChaveExiste(aChave: String; aId: Integer=0): Boolean;

    class procedure CriarAcoes(aNomeForm: TFormClass; aConexao: TZConnection); static;
    class procedure PreencherUsuariosVsAcoes(aConexao: TZConnection); static;
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
                'C�digo: ' +IntToStr(F_acaoAcessoId) +#13+
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

class procedure TAcaoAcesso.VerificarUsuarioAcao(aUsuarioId: Integer; aAcaoAcessoId: Integer; aConexao: TZConnection);
var qry: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := aConexao;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT usuarioId FROM usuariosAcaoAcesso '+
                'WHERE usuarioId = :usuarioId AND acaoAcessoId = :acaoAcessoId');
    qry.ParamByName('usuarioId').AsInteger := aUsuarioId;
    qry.ParamByName('acaoAcessoId').AsInteger := aAcaoAcessoId;
    qry.Open;

    if qry.IsEmpty then
    begin
       qry.Close;
       qry.SQL.Clear;
       qry.SQL.Add('INSERT INTO usuariosAcaoAcesso (usuarioId, acaoAcessoId, ativo) '+
                   'VALUES (:usuarioId, :acaoAcessoId, :ativo)');
       qry.ParamByName('usuarioId').AsInteger := aUsuarioId;
       qry.ParamByName('acaoAcessoId').AsInteger := aAcaoAcessoId;
       qry.ParamByName('ativo').AsBoolean := true;

       try
         aConexao.StartTransaction;
         qry.ExecSQL;
         aConexao.Commit;
       except
         aConexao.Rollback;
       end;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TAcaoAcesso.ChaveExiste(aChave: String; aId: Integer): Boolean;
var qry: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT COUNT(acaoAcessoId) AS Qtde FROM acaoAcesso WHERE chave = :chave ');

    if aId > 0 then
    begin
      qry.SQL.Add(' AND acaoAcessoId <> :acaoAcessoId');
      qry.ParamByName('acaoAcessoId').AsInteger := aId;
    end;

    qry.ParamByName('chave').AsString := aChave;

    try
      qry.Open;

      if qry.FieldByName('Qtde').AsInteger > 0 then
         Result := true
      else
         Result := false;

    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;
{$endregion}

{$region 'A��ES'}
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
        oAcaoAcesso.descricao := '    - Bot�o ' + StringReplace(TBitBtn(aForm.Components[i]).Caption, '&', '', [rfReplaceAll]);
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

class procedure TAcaoAcesso.PreencherUsuariosVsAcoes(aConexao: TZConnection);
var qry: TZQuery;
    qryAcaoAcesso: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := aConexao;
    qry.SQL.Clear;

    qryAcaoAcesso := TZQuery.Create(nil);
    qryAcaoAcesso.Connection := aConexao;
    qryAcaoAcesso.SQL.Clear;

    qry.SQL.Add('SELECT usuarioId FROM usuarios');
    qry.Open;

    qryAcaoAcesso.SQL.Add('SELECT acaoAcessoId FROM acaoAcesso');
    qryAcaoAcesso.Open;

    qry.First;

    while not qry.Eof do // usu�rios
    begin
      qryAcaoAcesso.First;

      while not qryAcaoAcesso.Eof do // a��o de acesso
      begin
        VerificarUsuarioAcao(qry.FieldByName('usuarioId').AsInteger, qryAcaoAcesso.FieldByName('acaoAcessoId').AsInteger, aConexao);
        qryAcaoAcesso.Next;
      end;

      qry.Next;
    end;
  finally
    if Assigned(qry) then
       FreeAndNil(qry);
    if Assigned(qryAcaoAcesso) then
       FreeAndNil(qryAcaoAcesso);
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
