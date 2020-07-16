unit uFuncaoCriptografia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs;

{$region 'FUNÇÕES'}
function Criptografar(const aEntrada: String): String;
function Descriptografar(const aEntrada: String): String;
{$endregion}

implementation

{$region 'CRIPTOGRAFAR'}
function Criptografar(const aEntrada: String): String;
var i, iQtdeEnt, iIntervalo: Integer;
    sSaida: String;
    sProximoCaracter: String;
begin
  iIntervalo := 6;
  i := 0;
  iQtdeEnt := 0;

  if (aEntrada <> EmptyStr) then
  begin
    iQtdeEnt := Length(aEntrada);
    for i := iQtdeEnt downto 1 do // faz o loop contrário
    begin
      sProximoCaracter := Copy(aEntrada, i, 1);
      sSaida := sSaida + (char(ord(sProximoCaracter[1]) + iIntervalo));
    end;
  end;

  Result := sSaida;
end;
{$endregion}

{$region 'DESCRIPTOGRAFAR'}
function Descriptografar(const aEntrada: String): String;
var i, iQtdeEnt, iIntervalo: Integer;
    sSaida: String;
    sProximoCaracter: String;
begin
  iIntervalo := 6;
  i := 0;
  iQtdeEnt := 0;

  if (aEntrada <> EmptyStr) then begin
    iQtdeEnt := Length(aEntrada);

    for i := iQtdeEnt downto 1 do
    begin
      sProximoCaracter := Copy(aEntrada, i, 1);
      sSaida := sSaida + (char(ord(sProximoCaracter[1]) - iIntervalo));
    end;
  end;

  Result := sSaida;
end;
{$endregion}
end.
