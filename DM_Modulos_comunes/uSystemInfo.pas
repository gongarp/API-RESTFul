unit uSystemInfo;

interface

  function GetLocalMacAddress: String;
  function GetWindowsUserName: string;
  function GetWindowsComputerName: string;
  function GetIPFromHost(const HostName: string): string;
  function GetMachineInfo(out Host : string; out Usuario : string; out IpAddress : string; out MACAddress : string) : Boolean;

implementation

uses
 System.SysUtils,
 Winapi.IpHlpApi,
 Winapi.IpTypes,
 Winapi.WinSock,
 Winapi.Windows;

function GetMachineInfo(out Host : string; out Usuario : string; out IpAddress : string; out MACAddress : string) : Boolean;
begin
   try
     Result := True;
     Host :=  Trim(GetWindowsComputerName());
     Usuario := Trim(GetWindowsUserName());
     IpAddress := Trim(GetIPFromHost(Host));
     MACAddress := Trim(GetLocalMacAddress());
   except
     Result := False;
   end;
end;

function GetLocalMacAddress: String;
var
  LAdaptersList, LAdapterInfo: PIP_ADAPTER_INFO;
  BufLen, Status: DWORD;
  I: Integer;
begin
  try
    Result := '';
    BufLen := 1024*15;
    GetMem(LAdaptersList, BufLen);
    try
      repeat
        Status := GetAdaptersInfo(LAdaptersList, BufLen);
        case Status of

          ERROR_SUCCESS:
          begin
            if BufLen = 0 then
            begin
              raise Exception.Create('No network adapter on the local computer.');
            end;
            Break;
          end;

          ERROR_NOT_SUPPORTED:
          begin
            raise Exception.Create('GetAdaptersInfo is not supported by the operating system running on the local computer.');
          end;

          ERROR_NO_DATA:
          begin
            raise Exception.Create('No network adapter on the local computer.');
          end;

          ERROR_BUFFER_OVERFLOW:
          begin
            ReallocMem(LAdaptersList, BufLen);
          end;
        else
          SetLastError(Status);
          RaiseLastOSError;
        end;
      until False;

      LAdapterInfo := LAdaptersList;
      while LAdapterInfo <> nil do
      begin
        if LAdapterInfo^.AddressLength > 0 then
        begin
          for I := 0 to LAdapterInfo^.AddressLength - 1 do begin
            Result := Result + IntToHex(LAdapterInfo^.Address[I], 2);
            if i < LAdapterInfo^.AddressLength - 1 then
              Result := Result + '-';
          end;
          Exit;
        end;
        LAdapterInfo := LAdapterInfo^.next;
      end;
    finally
      FreeMem(LAdaptersList);
    end;
  except
     Result := '000000000000';
  end;
end;

function GetWindowsUserName: string;
var
  Count: Cardinal;
begin
  Count := 256;
  Result := StringOfChar(#0, Count);
  if GetUserName(PChar(Result), Count) then
    SetLength(Result, Count)
  else
    Result := '';
end;

function GetWindowsComputerName: string;
var
  Count: Cardinal;
begin
  Count := MAX_COMPUTERNAME_LENGTH + 1;
  Result := StringOfChar(#0, Count);
  if GetComputerName(PChar(Result), Count) then
   SetLength(Result, Count)
  else
   Result := '';
end;

function GetIPFromHost(const HostName: string): string;
var
  LWSAData: TWSAData;
  LHostEnt: PHostEnt;
  LInAddr: TInAddr;
begin
  Result := '0.0.0.0';
  WSAStartup($101, LWSAData);
  LHostEnt := GetHostByName(PAnsiChar(AnsiString(HostName)));
  if Assigned(LHostEnt) then
  begin
    LInAddr := PInAddr(LHostEnt^.h_Addr_List^)^;
    Result :=  string(inet_ntoa(LInAddr));
  end;
end;



end.
