unit UMemory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, tlhelp32, StdCtrls, ExtCtrls, JvJCLUtils;

type
  TProcessList = record
    ID: dword;
    Name: string;
    FilePath: widestring;
    BaseAddress: dword;
    BaseSize: dword;
  end;

  TPMemory = class
    ProcessList: array of TProcessList;
    protected
      oldPID: integer;
    private
      procedure Clear;
      procedure GetBaseAddress(processName: string);
    public
      PReady: boolean;
      AppPID, PIdx, PID: integer;
      PBaseAddress: dword;
      PName: string;
      procedure GetProcessList;
      function ViewProcessList: TStrings;
      function GetIndexProcessByName(ProcessName: string):integer;
      function GetRealAddress(BaseAddress: dword; offset: array of dword):dword; overload;
      function GetRealAddress(ProcessID,BaseAddress: dword; offset: array of dword):dword; overload;
      function ConvertHexStrToRealStr(const s: string): string;
      function GetValues(Address: dword; VarType: integer; const Bit: Byte = 20;
        const Unicode: boolean = false): string; overload;
      function GetValues(ProcessID,Address: dword; VarType: integer; const Bits: Byte = 20;
        const Unicode: boolean = false): string; overload;
      procedure SetValues(Address: dword; VarType: integer; Value: string;
        const unicode: boolean = false; const addzero: boolean = false); overload;
      procedure SetValues(ProcessID,Address: dword; VarType: integer; Value: string;
        const unicode: boolean = false; const addzero: boolean = false); overload;
      function GetProcess(ProcessName: string): boolean;
      constructor Create;
      destructor Destroy; override;

      property Pin[ProcessName: string]: boolean read GetProcess;

      function SetPrivileges: boolean;
  end;

implementation

constructor TPMemory.Create;
begin
  Clear;
end;

destructor TPMemory.Destroy;
begin
  Clear;
end;

procedure TPMemory.Clear;
begin
  PReady:= false;
  PIdx := -1;
  PID  := 0;
  PName:= '';
  PBaseAddress := 0;
  SetLength(ProcessList,0);
end;

function TPMemory.SetPrivileges: boolean;
var
  appHandle: integer;
  tp, prev: TTokenPrivileges;
  tokenhandle: thandle;
  ReturnLength: Dword;
  minworkingsize, maxworkingsize: dword;
begin
  Result:= false;

  apphandle:=OpenProcess(PROCESS_ALL_ACCESS,true,AppPID);
  tokenhandle := 0;

  if appHandle <> 0 then
  begin

    if OpenProcessToken(appHandle, TOKEN_QUERY or TOKEN_ADJUST_PRIVILEGES,
      tokenhandle) then
    begin
    
      ZeroMemory(@tp, sizeof(tp));
      if lookupPrivilegeValue(nil, 'SeDebugPrivilege', tp.Privileges[0].Luid) then
      begin
        tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        tp.PrivilegeCount := 1; // One privilege to set
        if not AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp),
          prev, returnlength) then
          ShowMessage('Failure setting the debug privilege. Debugging may be limited.');
      end;

      {
      ZeroMemory(@tp, sizeof(tp));
      if lookupPrivilegeValue(nil, SE_LOAD_DRIVER_NAME, tp.Privileges[0].Luid) then
      begin
        tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        tp.PrivilegeCount := 1; // One privilege to set
        if not AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp),
          prev, returnlength) then
          ShowMessage('Failure setting the load driver privilege. Debugging may be limited.');
      end;
      }

      { windows 7 }
      ZeroMemory(@tp, sizeof(tp));
      if lookupPrivilegeValue(nil, 'SeCreateGlobalPrivilege',
        tp.Privileges[0].Luid) then
      begin
        tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        tp.PrivilegeCount := 1; // One privilege to set
        if not AdjustTokenPrivileges(tokenhandle, False, tp,
          sizeof(tp), prev, returnlength) then
          ShowMessage('Failure setting the CreateGlobal privilege.');
      end;

      {$ifdef cpu64}
      ZeroMemory(@tp, sizeof(tp));
      ZeroMemory(@prev, sizeof(prev));
      if lookupPrivilegeValue(nil, 'SeLockMemoryPrivilege', tp.Privileges[0].Luid) then
      begin
        tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        tp.PrivilegeCount := 1; // One privilege to set
        AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
      end;
      {$endif}

      ZeroMemory(@tp, sizeof(tp));
      ZeroMemory(@prev, sizeof(prev));
      if lookupPrivilegeValue(nil, 'SeIncreaseWorkingSetPrivilege',
        tp.Privileges[0].Luid) then
      begin
        tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        tp.PrivilegeCount := 1; // One privilege to set
        AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
      end;
    end;

    ZeroMemory(@tp, sizeof(tp));
    ZeroMemory(@prev, sizeof(prev));
    if lookupPrivilegeValue(nil, 'SeSecurityPrivilege', tp.Privileges[0].Luid) then
    begin
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      tp.PrivilegeCount := 1; // One privilege to set
      AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
    end;


    ZeroMemory(@tp, sizeof(tp));
    ZeroMemory(@prev, sizeof(prev));
    if lookupPrivilegeValue(nil, 'SeTakeOwnershipPrivilege', tp.Privileges[0].Luid) then
    begin
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      tp.PrivilegeCount := 1; // One privilege to set
      AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
    end;

    ZeroMemory(@tp, sizeof(tp));
    ZeroMemory(@prev, sizeof(prev));
    if lookupPrivilegeValue(nil, 'SeManageVolumePrivilege', tp.Privileges[0].Luid) then
    begin
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      tp.PrivilegeCount := 1; // One privilege to set
      AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
    end;

    ZeroMemory(@tp, sizeof(tp));
    ZeroMemory(@prev, sizeof(prev));
    if lookupPrivilegeValue(nil, 'SeBackupPrivilege', tp.Privileges[0].Luid) then
    begin
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      tp.PrivilegeCount := 1; // One privilege to set
      AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
    end;

    ZeroMemory(@tp, sizeof(tp));
    ZeroMemory(@prev, sizeof(prev));
    if lookupPrivilegeValue(nil, 'SeCreatePagefilePrivilege', tp.Privileges[0].Luid) then
    begin
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      tp.PrivilegeCount := 1; // One privilege to set
      AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
    end;

    ZeroMemory(@tp, sizeof(tp));
    ZeroMemory(@prev, sizeof(prev));
    if lookupPrivilegeValue(nil, 'SeShutdownPrivilege', tp.Privileges[0].Luid) then
    begin
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      tp.PrivilegeCount := 1; // One privilege to set
      AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
    end;

    ZeroMemory(@tp, sizeof(tp));
    ZeroMemory(@prev, sizeof(prev));
    if lookupPrivilegeValue(nil, 'SeRestorePrivilege', tp.Privileges[0].Luid) then
    begin
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      tp.PrivilegeCount := 1; // One privilege to set
      AdjustTokenPrivileges(tokenhandle, False, tp, sizeof(tp), prev, returnlength);
    end;

    if GetProcessWorkingSetSize(apphandle, minworkingsize, maxworkingsize) then
      SetProcessWorkingSetSize(apphandle, 16 * 1024 * 1024, 64 * 1024 * 1024);

    Result:= true;
  end;
end;

procedure TPMemory.GetBaseAddress(processName: string);
var
  ths: thandle;
  me32:MODULEENTRY32;
  x: pchar;
  modulename: string;
begin
  if PID = 0 then exit;
  ths:=CreateToolhelp32Snapshot(TH32CS_SNAPMODULE,PID);
  try
    if ths<>0 then
    begin
      me32.dwSize:=sizeof(MODULEENTRY32);
      if ths<>0 then
      begin
        try
          if module32first(ths,me32) then
          repeat
            x:=me32.szExePath;
            modulename:=extractfilename(x);
            if modulename = ProcessName then
            begin
              ProcessList[PIdx].FilePath:= me32.szExePath;
              ProcessList[PIdx].BaseAddress:= integer(me32.modBaseAddr);
              ProcessList[PIdx].BaseSize:= integer(me32.modBaseSize);
              exit;
            end;
          until not module32next(ths,me32);
        finally
          closehandle(ths);
        end;
      end;
    end;
  finally

  end;
end;

procedure TPMemory.GetProcessList;
Var SNAPHandle: THandle;
    ProcessEntry: ProcessEntry32;
    Check: Boolean;
begin
  SetLength(ProcessList,0);
  SNAPHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  try
  If SnapHandle>0 then
  begin
    ProcessEntry.dwSize:=SizeOf(ProcessEntry);
    Check:=Process32First(SnapHandle,ProcessEntry);
    while check do
    begin
      if (processentry.th32ProcessID<>0) then
      begin
        SetLength(ProcessList,length(ProcessList)+1);
        PIdx := length(ProcessList)-1;
        PID  := processentry.th32ProcessID;
        PName:= ExtractFilename(processentry.szExeFile);

        ProcessList[PIdx].ID  := PID;
        ProcessList[PIdx].Name:= PName;
        GetBaseAddress(PName);
      end;
      check:=Process32Next(SnapHandle,ProcessEntry);
    end;
    PIdx := -1;
    PID  := 0;
    PName:= '';
  end else raise exception.Create('Use Windows Process');
  finally
    closehandle(snaphandle);
  end;
end;

function TPMemory.GetIndexProcessByName(ProcessName: string):integer;
var
  i: integer;
begin
  Result:= -1;
  if length(ProcessList) > 0 then
  for i:= 0 to length(ProcessList)-1 do
    if AnsiSameText(ProcessList[i].Name,ProcessName) then
      Result:= i;
end;

function TPMemory.GetProcess(ProcessName: string): boolean;
var
  getPID: Integer;
begin
  Result:= false;
  GetProcessList;
  PIdx := GetIndexProcessByName(ProcessName);
  if (PIdx>=0) then
  begin
    getPID := Processlist[PIdx].ID;
    //if not(oldPID=PID) then
    //begin
      PID   := getPID;
      PName := ProcessList[PIdx].Name;
      PBaseAddress:= ProcessList[PIdx].BaseAddress;
      oldPID:= getPID;
    //end;
    Result:= true;
  end else
    clear;

  PReady:= Result;
end;

function TPMemory.ViewProcessList: TStrings;
var
  i: integer;
begin
  Result:= TStringList.Create;
  if (Length(ProcessList) > 0) then
  for i:= 0 to Length(ProcessList)-1 do
    Result.Add(inttostr(oldPID)+':'+inttostr(ProcessList[i].ID)+'|'+ProcessList[i].Name+'|'+dec2hex(ProcessList[i].BaseAddress,8));
end;

{ ========================================================================================= }

function  TPMemory.ConvertHexStrToRealStr(const s: string): string;
{
Converts a string meant to be a hexadeimcal string to the real way delphi reads
it
e.g:
123 > $123
-123 > -$123
+123 > +$123
#123 > 123
+#123 > +123
}
var ishex: string;
    start: integer;
    i,j,k: integer;

    bytes: string;
begin
  if s='' then
  begin
    result:=s;
    exit;
  end;
  start:=1;

  ishex:='$';
  for i:=start to length(s) do
    case s[i] of
      '''' , '"' :
      begin
        //char
        if (i+2)<=length(s) then
        begin
          bytes:='';
          for j:=i+2 to length(s) do
            if s[j] in ['''','"'] then
            begin
              bytes:=copy(s,i+1,j-(i+1));

              result:='$';
              for k:=length(bytes) downto 1 do
                result:=result+inttohex(byte(bytes[k]),2);

              //result := '$'+inttohex(byte(s[i+1]),2);
              exit; //this is it, no further process required, or appreciated...

            end;
        end;
      end;

      '#' :
      begin
        ishex:='';
        start:=2;
        break;
      end;
    end;


  if s[1]='-' then
  begin
    result:='-'+ishex+copy(s,start+1,length(s))
  end
  else
  if s[1]='+' then
  begin
    result:='+'+ishex+copy(s,start+1,length(s));
  end
  else result:=ishex+copy(s,start,length(s));
end;

function TPMemory.GetRealAddress(BaseAddress: dword; offset: array of dword):dword;
begin
  Result:= GetRealAddress(PID,BaseAddress,offset);
end;

function TPMemory.GetRealAddress(ProcessID,BaseAddress: dword; offset: array of dword):dword;
var
  i, PidHandle: integer;
  realAddress, realAddress2, count: dword;
  check: boolean;
begin
  Result:= 0;

  if ((BaseAddress>0) AND (length(offset) > 0)) then
  begin
    PidHandle:= OpenProcess(PROCESS_ALL_ACCESS,False,ProcessID);
    try
      realAddress2:= BaseAddress;
      for i:= length(offset)-1 downto 0 do
      begin
        check:=readprocessmemory(PidHandle,pointer(realAddress2),@realAddress,4,count);
        if check and (count=4) then
          realAddress2:= realAddress+offset[i]
        else begin
          Result:= 0;
          exit;
        end;
      end;
      Result:= realAddress2;
    finally
      CloseHandle(PidHandle);
    end;
  end;
end;

function TPMemory.GetValues(Address: dword; VarType: integer; const Bit: Byte = 20;
  const Unicode: boolean = false): string;
begin
  Result:= GetValues(PID, Address, VarType, Bit, Unicode);
end;

function TPMemory.GetValues(ProcessID, Address: dword; VarType: integer; const Bits: Byte = 20;
  const Unicode: boolean = false): string;
var
  count: dword;

  bytes: byte;
  words: word;
  dwords: dword;
  floats: single;
  doubles: double;
  int64s: Int64;
  texts: pchar;
  unicodes: pwidechar;
  arrayOfBits: array of byte;

  j, PidHandle: integer;
  temp: string;
  check: boolean;
begin
  Result:= '????????';

  PidHandle:= OpenProcess(PROCESS_ALL_ACCESS,False,ProcessID);
  try
  case VarType of
    1 : begin // byte
      check:= readprocessmemory(PidHandle,pointer(Address),addr(bytes),1,count);
      if (not check) or (count=0) then result:='??' else
        Result:= inttostr(bytes);
    end;
    2 : begin // 2 bytes
      check:= readprocessmemory(PidHandle,pointer(Address),addr(words),2,count);
      if (not check) or (count=0) then result:='??' else
        Result:= inttostr(words);
    end;
    3 : begin // 3 bytes
      check:= readprocessmemory(PidHandle,pointer(Address),addr(dwords),3,count);
      if (not check) or (count=0) then result:='??' else
        Result:= inttostr(dwords);
    end;
    4,8 : begin // 4 bytes
      check:= readprocessmemory(PidHandle,pointer(Address),addr(dwords),4,count);
      if (not check) or (count=0) then result:='??' else
        Result:= inttostr(dwords);
    end;
    5 : begin    // float
      check:= readprocessmemory(PidHandle,pointer(Address),addr(floats),4,count);
      if (not check) or (count=0) then result:='??' else
        Result:= floattostr(floats);
    end;
    6 : begin   // double
      check:= readprocessmemory(PidHandle,pointer(Address),addr(doubles),8,count);
      if (not check) or (count=0) then result:='??' else
        Result:= floattostr(doubles);
    end;
    11 : begin    // text
      if Unicode then
      begin
        getmem(unicodes,Bits*2+2);
        check:=readprocessmemory(PidHandle,pointer(Address),unicodes,Bits*2,count);
        if (not check) or (count<Bits) then result:='??' else
        begin
          unicodes[Bits]:=chr(0);
          result:= unicodes;
        end;
        freemem(unicodes);
      end else
      begin
        getmem(texts,Bits+1);
        check:=readprocessmemory(PidHandle,pointer(Address),texts,Bits,count);
        if (not check) or (count<Bits) then result:='??' else
        begin
          texts[Bits]:=chr(0);
          result:= texts;
        end;
        freemem(texts);
      end;
    end;
    12 : begin //array of byte
      setlength(arrayOfBits,Bits);
      check:=readprocessmemory(PidHandle,pointer(Address),arrayOfBits,Bits,count);

      if (not check) or (count<Bits) then result:='??' else
      begin
        temp:='';
        for j:=0 to Bits-1 do
          temp:=temp+IntToHex(arrayOfBits[j],2);//+' ';
        result:=temp;
      end;
      setlength(arrayOfBits,0);
    end;
    13 : begin //Int64
      check:=readprocessmemory(PidHandle,pointer(Address),addr(int64s),8,count);
      if (not check) or (count=0) then result:='??' else
      begin
        //if memrec[rec].ShowAsHex then
        //  result:='0x'+IntToHex(int64s,16)
        //else
          result:=IntToStr(int64s);
      end;
    end;
  end;
  finally
    CloseHandle(PidHandle);
  end;
end;

procedure TPMemory.setValues(Address: dword; VarType: integer; Value: string; const unicode: boolean = false;
  const addzero: boolean = false);
begin
  SetValues(PID,Address,VarType,Value,unicode);
end;

procedure TPMemory.setValues(ProcessID,Address: dword; VarType: integer; Value: string;
  const unicode: boolean = false; const addzero: boolean = false);
var
  bytes: byte;
  words: word;
  dwords: dword;
  singles: Single;
  doubles: Double;

  newValue, tempVal: string;
  newvalueSt: widestring;
  newValue6: int64;

  text: pchar;

  Written  : dword;
  err: integer;

  PidHandle: integer;
  original: dword;
  forceZero: boolean;
resourcestring
  strNotValid = 'Value not valid!';
begin
  newValue:= Value;

  case VarType of
    1,2,3,4: begin
            val(newValue, newValue6, err);
            if err=0 then
            begin
              bytes  := byte(newValue6);
              words  := word(newValue6);
              dwords := dword(newValue6);
            end;
    end;
    5,6: begin
      val(newvalue,doubles,err);
      if err<>0 then
      begin
        if newvalue[err]=',' then newvalue[err]:='.'
        else
        if newvalue[err]='.' then newvalue[err]:=',';

        err:=0;
        val(newvalue,doubles,err);
      end;

      singles:= doubles;
    end;
    11: begin
      // check different size
      forceZero:= false;
      tempVal:= GetValues(Address,VarType,20,unicode);
      if (tempVal='') OR (tempVal[1]='?') then err:= 1
      else
      begin
        err:= 0;
        if (length(newValue)<length(tempVal)) then
          forceZero:= true;
      end;
      if not(forceZero) then forceZero:= addzero;
    end;
  end;

  if err>0 then raise Exception.Create(strNotValid);

  PidHandle:= OpenProcess(PROCESS_ALL_ACCESS,False,ProcessID);

  try

  VirtualProtectEx(pidhandle,  pointer(Address),1,PAGE_EXECUTE_READWRITE,original);

  case VarType of
    1: WriteProcessMemory(PidHandle, Pointer(Address), @bytes, 1, written);
    2: WriteProcessMemory(PidHandle, Pointer(Address), @words, 2, written);
    3: WriteProcessMemory(PidHandle, Pointer(Address), @dwords, 3, written);
    4: WriteProcessMemory(PidHandle, Pointer(Address), @dwords, 4, written);
    5: writeprocessmemory(PidHandle, Pointer(Address), addr(singles),4,written);
    6: writeprocessmemory(PidHandle, Pointer(Address), addr(doubles),8,written);
    11: begin
      Bytes:=0;
      Words:=0;
      if unicode then
      begin
        newvalueSt:=newvalue;
        writeprocessmemory(PidHandle,pointer(address),@newvalueSt[1],length(newvalueSt)*2,written);
        //if forceZero then
        writeprocessmemory(PidHandle,pointer(address+length(newvalue)*2),addr(Words),2,written);
      end else
      begin
        getmem(text,length(newvalue));
        StrCopy(text, PChar(newvalue));
        writeprocessmemory(PidHandle,pointer(Address),text,length(newvalue),written);
        //if forceZero then
        writeprocessmemory(PidHandle,pointer(address+length(newvalue)),addr(Bytes),1,written);
        freemem(text);
      end;
    end;
  end;

  VirtualProtectEx(pidhandle,  pointer(Address),1,original,written);

  finally
    CloseHandle(PidHandle);
  end;
end;

end.
 