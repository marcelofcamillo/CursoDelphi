unit cCadUsuario;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection,
     ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils,
     uFuncaoCriptografia;

type
  TUsuario = class
  private
    ConexaoDB: TZConnection;
    F_usuarioId: Integer;
    F_nome: String;
    F_senha: String;
    function getSenha: String;
    procedure setSenha(const Value: String);

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
    function Logar(aUsuario, aSenha: String): Boolean;
    function UsuarioExiste(aUsuario: String): Boolean;
    function AlterarSenha: Boolean;
  published
    property codigo : Integer read F_usuarioId write F_usuarioId;
    property nome   : String  read F_nome      write F_nome;
    property senha  : String  read getSenha    write setSenha;
  end;

implementation

{ TUsuario }

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TUsuario.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TUsuario.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TUsuario.Apagar: Boolean;
var qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' +#13+#13+
                'Código: ' + IntToStr(F_usuarioId) +#13+
                'Nome: '  + F_nome, mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
     Result := false;
     Abort;
  end;

  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM usuarios WHERE usuarioId = :usuarioId');
    qry.ParamByName('usuarioId').AsInteger := F_usuarioId;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TUsuario.Atualizar: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE usuarios SET nome = :nome, senha =:senha WHERE usuarioId = :usuarioId');
    qry.ParamByName('usuarioId').AsInteger := Self.F_usuarioId;
    qry.ParamByName('nome').AsString       := Self.F_nome;
    qry.ParamByName('senha').AsString      := Self.F_Senha;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TUsuario.Inserir: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO usuarios (nome, senha ) VALUES (:nome, :senha)');
    qry.ParamByName('nome').AsString  := Self.F_nome;
    qry.ParamByName('senha').AsString := Self.F_senha;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TUsuario.Selecionar(id: Integer): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT usuarioId, nome, senha FROM usuarios WHERE usuarioId = :usuarioId');
    qry.ParamByName('usuarioId').AsInteger := id;

    try
      qry.Open;

      Self.F_usuarioId := qry.FieldByName('usuarioId').AsInteger;
      Self.F_nome      := qry.FieldByName('nome').AsString;
      Self.F_Senha     := qry.FieldByName('senha').AsString;;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

function TUsuario.UsuarioExiste(aUsuario: String): Boolean;
var qry: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT COUNT(usuarioId) AS Qtde FROM usuarios WHERE nome = :nome');
    qry.ParamByName('nome').AsString := aUsuario;

    try
      qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
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
{$endregion}

{$region 'GET E SET'}
function TUsuario.getSenha: String;
begin
  Result := Descriptografar(Self.F_senha);
end;

procedure TUsuario.setSenha(const Value: String);
begin
  Self.F_senha := Criptografar(Value);
end;
{$endregion}

{$region 'LOGIN'}
function TUsuario.Logar(aUsuario: String; aSenha: String): Boolean;
var qry: TZQuery;
begin
  try
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT usuarioId, nome, senha FROM usuarios WHERE nome = :nome AND senha = :senha');
    qry.ParamByName('nome').AsString  := aUsuario;
    qry.ParamByName('senha').AsString := Criptografar(aSenha);

    try
      qry.Open;

      if qry.FieldByName('usuarioId').AsInteger > 0 then begin
         Result := true;
         F_usuarioId := qry.FieldByName('usuarioId').AsInteger;
         F_nome      := qry.FieldByName('nome').AsString;
         F_senha     := qry.FieldByName('senha').AsString;
      end
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

{$region 'ALTERAÇÃO DE SENHA'}
function TUsuario.AlterarSenha: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE usuarios SET senha = :senha WHERE usuarioId = :usuarioId');
    qry.ParamByName('usuarioId').AsInteger := Self.F_usuarioId;
    qry.ParamByName('senha').AsString      := Self.F_Senha;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;
{$endregion}

end.
