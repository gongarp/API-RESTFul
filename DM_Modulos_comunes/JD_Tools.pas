unit JD_Tools;

interface

function PadL( cOrigen, cLlena: string; nCant: integer ): string;
function PadR( cOrigen, cLlena: string; nCant: integer ): string;
function StrTran(cString, cSearch, cReplace: string): string;
function StrRemove(cString, cRemove: string): string;
function Transform( cStr, cFmto: string ): string;

function Year( dFecha: TDateTime ): integer;
function Month( dFecha: TDateTime ): integer;

procedure Inc_Month( var nYear, nMonth: word );
procedure Inc_Year( var nYear: word );

procedure Dec_Month( var nYear, nMonth: word );
procedure Dec_Year( var nYear: word );

implementation

uses {Windows,} SysUtils;

//===========================================================================
// Rutina    : PadL(cOrigen, cLlena, nCant ) -> String
// Argumentos:
// Objetivo  :
//===========================================================================
Function PadL( cOrigen, cLlena: string; nCant: integer ): string;
var
   i: integer;
   cAux1: string;
begin
   cAux1 := '';
   for i := 1 to Length(cOrigen) do
   begin
      if Copy(cOrigen, i, 1) <> ' ' then
         cAux1 := cAux1 + Copy(cOrigen, i, 1);
   end;

   Result := '';
   for i := 1 to nCant-Length(cAux1) do
   begin
      Result := Result + cLlena;
   end;

   Result := Result + cAux1;
end;

//===========================================================================
// Rutina    : PadR(cOrigen, cLlena, nCant ) -> String
// Argumentos:
// Objetivo  :
//===========================================================================
function PadR( cOrigen, cLlena: string; nCant: integer ): string;
var
   i: integer;
   cAux1: string;
begin
   cAux1 := cOrigen;
   (*
   for i := 1 to Length(cOrigen) do
   begin
      if Copy(cOrigen, i, 1) <> ' ' then
         cAux1 := cAux1 + Copy(cOrigen, i, 1);
   end;
   *)
   Result := '';
   for i := 1 to nCant-Length(cAux1) do
   begin
      Result := Result + cLlena;
   end;

   Result := cAux1 + Result;
end;

//===========================================================================
// Rutina    :
// Argumentos:
// Objetivo  :
//===========================================================================
function StrRemove(cString, cRemove: string): string;
var
   i: integer;
begin
   Result := '';
   for i := 1 to Length(cString) do
      if cString[i] <> cRemove then
        Result := Result + cString[i];
end;

//===========================================================================
// Rutina    :
// Argumentos:
// Objetivo  :
//===========================================================================
function StrTran(cString, cSearch, cReplace: string): string;
var
   i: integer;
begin
   Result := '';
   for i := 1 to Length(cString) do
      if cString[i] = cSearch then
        Result := Result + cReplace[1]
      else
        Result := Result + cString[i];
end;

//===========================================================================
// Rutina    :
// Argumentos:
// Objetivo  :
//===========================================================================
function Transform( cStr, cFmto: string ): string;
var
  nVal : Extended;
  cVal: string;
begin
  cVal := StrRemove(cStr,',');
  if cVal = '' then
     cVal := '0';
  nVal := StrToFloat(cVal);
  Transform := Trim(Format(cFmto,[nVal]));
end;

function Year( dFecha: TDateTime ): integer;
var
  nYear, nMonth, nDay: word;
begin
  result := 0;
  try
     DecodeDate( dFecha, nYear, nMonth, nDay );
     if nYear = 1899 then exit;
     Result := nYear;
  except
  end;
end;

function Month( dFecha: TDateTime ): integer;
var
  nYear, nMonth, nDay: word;
begin
  result := 0;
  try
     DecodeDate( dFecha, nYear, nMonth, nDay );
     if nYear = 1899 then exit;
     Result := nMonth;
  except
  end;
end;

procedure Dec_Month( var nYear, nMonth: word );
begin
  Dec( nMonth );
  if nMonth < 1 then
  begin
     nMonth := 12;
     Dec( nYear );
  end;
end;

procedure Dec_Year( var nYear: word );
begin
  if nYear > 0 then
     Dec( nYear );
end;


procedure Inc_Month( var nYear, nMonth: word );
begin
  Inc( nMonth );
  if nMonth > 12 then
  begin
     nMonth := 1;
     Inc( nYear );
  end;
end;

procedure Inc_Year( var nYear: word );
begin
  if nYear > 0 then
     Inc( nYear );
end;

end.
