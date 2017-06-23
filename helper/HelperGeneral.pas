unit HelperGeneral;

interface

uses
  Windows, Messages, Dialogs, Classes, StdCtrls, SysUtils, StrUtils, ComCtrls, Controls, CommCtrl,
  JvJCLUtils, JvComCtrls, UVerInfoClass;

type
  TIntArr = array of longint;
  SIntArr = ^TintArr;
  TStrArr = array of widestring;

// integer helper
function inTArrayDiff(const intArr1, intArr2: TIntArr; var intArrRes: TIntArr; const compareBoth: boolean = false): boolean;
function inTArray(const AInt: integer; const AValues: array of integer): Boolean;
procedure invArrayInt(var intArray: TIntArr);
procedure popINTArray(var intArray: TIntArr; const value: integer = 0; const clear: boolean = false);

function copyArrayInt(const source: array of integer): TIntArr;
function arrayMulti(value: integer; const data: array of integer): TIntArr;
function arrayMulti2(value: integer; const data: array of integer): TIntArr;
function syncTrackbar(mouseX: cardinal; barWidth, barClientWidth, barLeft, barMin, barMax: int64;
  const Space: integer = 11): cardinal;

function copyArray2List(const source: array of string): TStringList;

// text helper
function walkString(delim, strings: string): string;
function boolStr(checked: boolean): string;
function strBool(str: string): boolean;
function ArrayContainText(const AText: string; const AValues: array of string; const sameText: boolean = false): Boolean;
function ArrayContainVariant(const AText: Variant; const AValues: array of Variant; const isInteger: boolean = false): Boolean;
function ArrayContainTextList(const AText: string; const AValues: TStrings; const sameText: boolean = false): Boolean;
function ArrayIndexContainText(const AText: string; const AValues: array of string; const sameText: boolean = false): integer;
function ArrayIndexContainTextList(const AText: string; const AValues: TStringList; const sameText: boolean = false): integer;
function ArrayIndexContainInteger(const AInt: integer; const AValues: array of integer): integer;
function ArrayToText(delim: string; var arrText: array of string): string;
function ArrayDiffTextList(ASource, ATarget: TStringList; const sameText: boolean = true): TStringList;
function findLineSingle(find: string; SMemo: TMemo): integer;
function findLine(find: string; SMemo: TMemo; nested: boolean): TIntArr;
function findIndexStr(S: string; Str: TStrings): integer;
function findIndex(S: string; Str: TStringList):integer;
procedure sortMemo(memo: TMemo);
procedure Split(const Delimiter: string; Input: string; const Strings: TStrings);
procedure SplitInt(const Delimiter, Input: string; var arrInt: TIntArr);
function splitChar(delimiter: char; s: string; limit: integer): string;
function trimStr(const Delimiter: string; Input: string): string;
function trimPos(const Delimiter: char; Input: string): string;
function stripQuote(Input: string): string;
function strPad(value: string; limit: integer; const middle: boolean = false): string;
procedure parsePath(fullPath: string; var strList: TStringList; const addLast: boolean = false);
function Explode(const Delimiter: string; Input: string): TStrings;
function Implode(const Delimiter: string; strList: TStrings; const pathDelim: string = ''): string;
function ImplodeStr(const Delimiter: string; strList: array of string): widestring;
function ImplodeInt(const Delimiter: string; intList: array of integer): widestring;
function renamaFile(str, add: string; const delim: string = ''): string;
function checkDoubleExt(filename, maskExt: string; const removeLast: boolean = true): boolean;
function mediaTimer(pos, length: longint; const reverse: boolean = false; const sparate: string = ':'): string;
function padFileDrive(fullPath: string):string;
function microTime(fullTime: string): int64;
// other helper

// win32 helper
function getFileVersion(fileName:string): string;
function asAdmin(appExePath: string): boolean;
function FileSize(fileName : wideString): Int64;
function FormatByteSize(const bytes: Longint): string;
function shellRun(FileName: string; const Visibility: Boolean = false; const Wait: Boolean = false): Longword;
function shellRun1(FileName: string; const Visibility: Boolean = false; const Wait: Boolean = false): Longword;
function shellRun2(CommandLine, Workdir: string; Visibility, Wait: Boolean): Longword;
procedure LoadTextFile(const FileName:string; const Strings: TStrings);
Procedure FileSearch(PathName, Extensions: string; var lstFiles: TStringList; const numDir: integer = -1; const limitDir: integer = 3);
Procedure countFiles(const PathName, Extensions: string; var totFiles: integer);
procedure GetSubFolder(const directory : string; list : TStrings; isDirectory: boolean);
procedure movingForm(form: HWND; const enabled: boolean = true);
function WindowIsActive(): boolean;

function HDecodeString(const Key, Value: AnsiString): AnsiString;
function HEncodeString(const Key, Value: AnsiString): AnsiString;
procedure HDecode(const Key: AnsiString; Buf: PAnsiChar; Size: Cardinal);
procedure HEncode(const Key: AnsiString; Buf: PAnsiChar; Size: Cardinal);

implementation

uses DateUtils;

{ ========================================================== ENCRIPT =========================================================== }
function HDecodeString(const Key, Value: AnsiString): AnsiString;
var
  Tmp: PAnsiChar;
begin
  GetMem(Tmp, Length(Value) + 1);
  try
    StrPCopy(Tmp, Value);
    HDecode(Key, Tmp, Length(Value));
    SetString(Result, Tmp, Length(Value));
  finally
    FreeMem(Tmp);
  end;
end;

function HEncodeString(const Key, Value: AnsiString): AnsiString;
var
  Tmp: PAnsiChar;
begin
  GetMem(Tmp, Length(Value) + 1);
  try
    StrPCopy(Tmp, Value);
    HEncode(Key, Tmp, Length(Value));
    SetString(Result, Tmp, Length(Value));
  finally
    FreeMem(Tmp);
  end;
end;

procedure HDecode(const Key: AnsiString; Buf: PAnsiChar; Size: Cardinal);
var
  N: Integer;
  I: Cardinal;
begin
  if Size > 0 then
  begin
    N := StrToIntDef(string(Key), 13);
    if (N <= 0) or (N > 256) then
      N := 13;
    for I := 0 to Size - 1 do
      Buf[I] := AnsiChar(Cardinal(Buf[I]) - Cardinal(N));
  end;
end;

procedure HEncode(const Key: AnsiString; Buf: PAnsiChar; Size: Cardinal);
var
  N: Integer;
  I: Cardinal;
begin
  if Size > 0 then
  begin
    N := StrToIntDef(string(Key), 13);
    if (N <= 0) or (N > 256) then
      N := 13;
    for I := 0 to Size - 1 do
      Buf[I] := AnsiChar(Cardinal(Buf[I]) + Cardinal(N));
  end;
end;

{ ========================================================== WINDOWS PROCESS =================================================== }

function getFileVersion(fileName:string): string;
var
  VI: TVerInfo;
  FFI: TVSFixedFileInfo;
begin
  VI := TVerInfo.Create(fileName);
  try
    if VI.HasVerInfo then
    begin
      FFI := VI.FixedFileInfo;
      Result:= Format('%d.%d.%d.%d',
        [HiWord(FFI.dwProductVersionMS), LoWord(FFI.dwProductVersionMS),
        HiWord(FFI.dwProductVersionLS), LoWord(FFI.dwFileVersionLS)]);
    end;
  finally
    VI.Free;
  end;
end;

function WindowIsActive(): boolean;
begin
  if (FindControl(GetForegroundWindow()) <> nil) then
    Result:= true
  else Result:= false;
end;

procedure movingForm(form: HWND; const enabled: boolean = true);
begin
  if enabled then
  begin
    ReleaseCapture;
    SendMessage(form, WM_SYSCOMMAND, 61458, 0) ;
  end;
end;

{ ADMIN PRIVELAGE}

function asAdmin(appExePath: string): boolean;
const
  batFile: string = 'admin.bat';
  uacFile: string = 'admin.vbs';
var
  lstUAC: TStringList;
  appPath : string;
begin
  Result:= true;

  appPath:= ExtractFilePath(appExePath);

  lstUAC:= TStringList.Create;
  lstUAC.Add('@echo off');
  lstUAC.Add('>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"');
  lstUAC.Add('if ''%errorlevel%'' NEQ ''0'' ( goto UACPrompt ) else ( goto gotAdmin )');
  lstUAC.Add(':UACPrompt');
  lstUAC.Add('echo Set UAC = CreateObject^("Shell.Application"^) > "'+appPath+uacFile+'"');
  lstUAC.Add('echo UAC.ShellExecute "'+appExePath+'", "", "", "runas", 1 >> "'+appPath+uacFile+'"');
  lstUAC.Add('"'+appPath+uacFile+'"');
  lstUAC.Add('goto gotAdmin');
  lstUAC.Add(':gotAdmin');
  lstUAC.Add('if exist "'+appPath+uacFile+'" ( del "'+appPath+uacFile+'" )');
  lstUAC.Add('exit');

  lstUAC.SaveToFile(appPath+batFile);
  shellrun1(appPath+batFile,false,false);
end;

{ GET FILE SIZE }
function FormatByteSize(const bytes: Longint): string;
const
  B = 1; //byte
  KB = 1024 * B; //kilobyte
  MB = 1024 * KB; //megabyte
  GB = 1024 * MB; //gigabyte
begin
  if bytes > GB then
    result := FormatFloat('#.## GB', bytes / GB)
  else
    if bytes > MB then
      result := FormatFloat('#.## MB', bytes / MB)
    else
      if bytes > KB then
        result := FormatFloat('#.## KB', bytes / KB)
      else
        result := FormatFloat('#.## bytes', bytes) ;
end;

function FileSize(fileName : wideString): Int64;
begin
  with TFileStream.Create(fileName, fmOpenRead or fmShareDenyNone) do
  begin
    try
      Result := Size;
    finally
      Free;
    end;
  end;
end;

{ RUN SHELL COMMAND }
function shellRun(FileName: string; const Visibility: Boolean = false; const Wait: Boolean = false): Longword;
begin
  ///SW_HIDE
  if (Wait) then
    Result:= ExecuteAndWait(FileName, '', BooleanToInteger(Visibility))
  else
    Result:= shellRun1(FileName, Visibility, false);
end;

{ RUN SHELL COMMAND }
function shellRun1(FileName: string; const Visibility: Boolean = false; const Wait: Boolean = false): Longword;
var
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  if Visibility then
    StartupInfo.wShowWindow := 1
  else
    StartupInfo.wShowWindow := 0;
  if not CreateProcess(nil,
    zAppName, // pointer to command line string
    nil, // pointer to process security attributes
    nil, // pointer to thread security attributes
    False, // handle inheritance flag
    CREATE_NEW_CONSOLE or // creation flags
    NORMAL_PRIORITY_CLASS,
    nil, //pointer to new environment block
    nil, // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInfo) // pointer to PROCESS_INF
    then Result := WAIT_FAILED
  else
  begin
    if Wait then
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

{ RUN SHELL COMMAND 2 PROBLEM WITH SECURITY REASON}
function shellRun2(CommandLine, Workdir: string; Visibility, Wait: Boolean): Longword;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  Handle: Boolean;
begin
  //GetDir(0, WorkDir);
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      if Visibility then
        wShowWindow := SW_SHOW
      else
        wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
            Buffer[BytesRead] := #0;
        until not WasOK or (BytesRead = 0);
        if Wait then
          WaitForSingleObject(PI.hProcess, INFINITE);
        GetExitCodeProcess(PI.hProcess, Result);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end
    else Result := WAIT_FAILED;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

{ RECURSIVE SEARCH DIRECTORY AND FILES WITH MASKING EXTENSION }
Procedure FileSearch(PathName, Extensions: string; var lstFiles: TStringList;
  const numDir: integer = -1; const limitDir: integer = 3);
const
  FileMask = '*.*';
var
  Rec: TSearchRec;
  Path: string;
  countDir: integer;
begin
  countDir:= numDir;
  lstFiles.Sorted:= false;
  Path := IncludeTrailingPathDelimiter(PathName);
  if FindFirst(Path + FileMask, faAnyFile - faDirectory, Rec) = 0 then
    try
      repeat
        if AnsiPos(ExtractFileExt(Rec.Name), Extensions) > 0 then
        begin
          lstFiles.Add(Path + Rec.Name);
          if countDir >= limitDir then
            break;
        end;
      until FindNext(Rec) <> 0;
    finally
      SysUtils.FindClose(Rec);
    end;

  if FindFirst(Path + FileMask, faDirectory, Rec) = 0 then
    try
      repeat
        if ((Rec.Attr and faDirectory) <> 0) and (Rec.Name <> '.') and
          (Rec.Name <> '..') then
        begin
          if countDir >= limitDir then
            break;
          if countDir <> -1 then
            inc(countDir);
          FileSearch(Path + Rec.Name, Extensions, lstFiles, countDir);
        end;
      until FindNext(Rec) <> 0;
    finally
      FindClose(Rec);
    end;
end;

{ RECURSIVE COUNT FILES WITH MASKING EXTENSION }
Procedure countFiles(const PathName, Extensions: string; var totFiles: integer);
const
  FileMask = '*.*';
var
  Rec: TSearchRec;
  Path: string;
begin
  Path := IncludeTrailingPathDelimiter(PathName);
  if FindFirst(Path + FileMask, faAnyFile - faDirectory, Rec) = 0 then
    try
      repeat
        if AnsiPos(ExtractFileExt(Rec.Name), Extensions) > 0 then
          inc(totFiles);
      until FindNext(Rec) <> 0;
    finally
      SysUtils.FindClose(Rec);
    end;

  if FindFirst(Path + FileMask, faDirectory, Rec) = 0 then
    try
      repeat
        if ((Rec.Attr and faDirectory) <> 0) and (Rec.Name <> '.') and
          (Rec.Name <> '..') then
          countFiles(Path + Rec.Name, Extensions, totFiles);
      until FindNext(Rec) <> 0;
    finally
      FindClose(Rec);
    end;
end;

{ GET SUB DIRECTORY }
procedure GetSubFolder(const directory : string; list : TStrings; isDirectory: boolean);
var
  sr : TSearchRec;
  stype: dword;
begin
  try
    stype:= faAnyFile;
    if isDirectory then
      stype:= faDirectory;

    if FindFirst(IncludeTrailingPathDelimiter(directory) + '*.*', stype, sr) < 0 then
      Exit
    else
    repeat
      if ((sr.Attr and stype <> 0) AND (sr.Name <> '.') AND (sr.Name <> '..')) then
        List.Add(IncludeTrailingPathDelimiter(directory) + sr.Name) ;
    until FindNext(sr) <> 0;
  finally
    SysUtils.FindClose(sr) ;
  end;
end;

{ ============================================================= GENERAL FUNCTION =============================================== }

function copyArray2List(const source: array of string): TStringList;
var I: integer;
begin
  Result:= TStringList.Create;
  for I:= Low(source) to High(source) do
    Result.Add(Source[I]);
end;

{ LOAD STRING FILES WITH UNICODE }
procedure LoadTextFile(const FileName:string; const Strings: TStrings);
var FS: TFileStream;
    Buff: PByteArray;
begin
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    if FS.Size = 0 then Exit;
    Buff := AllocMem(FS.Size + 2); // Enough space to read the whole file and space to add a terminator
    try
      // Read the file
      FS.ReadBuffer(Buff^, FS.Size);
      // Init the NULL terminator
      Buff[FS.Size] := 0;
      Buff[FS.Size+1] := 0;
      // Check the BOM
      if (Buff[0] = $ff) and (Buff[1] = $fe) then
        begin
          // UTF-16, Little Endian encoding
          Strings.Text := PWideChar(@Buff[2]); // Skip BOM, automatic UTF16->ANSI encoding
        end
      else if (Buff[0] = $ef) and (Buff[1] = $bb) and (BUff[2] = $bf) then
        begin
          // UTF8 Encoding
          Strings.Text := Utf8ToAnsi(UTF8String(PAnsiChar(@Buff[3]))); // Skip BOM, explicit UTF8->ANSI
        end
      else
        begin
          // Unknown or unsupported BOM, assume Plain Ansi File
          Strings.Text := PAnsiChar(Buff);
        end
    finally FreeMemory(Buff);
    end;
  finally FS.Free;
  end;
end;

{ CONVERT BOOLEAN TO STRING }
function boolStr(checked: boolean): string;
begin
  result:= '1';
  if not(checked) then
    result:= '0';
end;

function strBool(str: string): boolean;
begin
  Result:= false;
  if (str = '1') then
    Result:= true;
end;

{ SORT MEMO ALPHABETH }
procedure sortMemo(memo: TMemo);
var sMemo: TStringList;
begin
  sMemo:= TStringList.Create;
  sMemo.AddStrings(memo.Lines);
  sMemo.Sort;
  memo.Clear;
  memo.Lines.AddStrings(sMemo);
end;

procedure popINTArray(var intArray: TIntArr; const value: integer = 0; const clear: boolean = false);
begin
  if clear then
    SetLength(intArray,0)
  else
  begin
    SetLength(intArray,length(intArray)+1);
    intArray[length(intArray)-1]:= value;
  end;
end;

{ FIND SAME INTEGER IN ARRAY }
function inTArray(const AInt: integer; const AValues: array of integer): Boolean;
var I: integer;
begin
  Result:= false;
  for I := Low(AValues) to High(AValues) do
    if (AInt = AValues[I]) then
    begin
      Result:= true;
      break;
    end;
end;

function inTArrayDiff(const intArr1, intArr2: TIntArr; var intArrRes: TIntArr; const compareBoth: boolean = false): boolean;
var I: integer;
begin
  Result:= false;
  setLength(intArrRes,0);
  // compare array 1 to array 2
  for I := Low(intArr1) to High(intArr1) do
    if not(inTArray(intArr1[I],intArr2)) then
      popINTArray(intArrRes,intArr1[I]);

  // compare array 2 to array 1
  if compareBoth then
  for I := Low(intArr2) to High(intArr2) do
    if not(inTArray(intArr2[I],intArr1)) then
      popINTArray(intArrRes,intArr2[I]);

  if length(intArrRes) > 0 then
    Result:= true;
end;

{ FIND TEXT IN ARRAY }
function ArrayContainText(const AText: string;
  const AValues: array of string; const sameText: boolean = false): Boolean;
var I: integer;
begin
  Result:= false;
  for I := Low(AValues) to High(AValues) do
    if sameText then
    begin
      if AnsiSameText(AText,Avalues[I]) then
      begin
        Result:= true;
        break;
      end;
    end else
    begin
      if AnsiStartsText(Avalues[I],AText) then
      begin
        Result:= true;
        break;
      end else
      if AnsiContainsText(AText,Avalues[I]) then
      begin
        Result:= true;
        break;
      end;
    end;
end;

{ FIND TEXT IN ARRAY }
function ArrayContainVariant(const AText: Variant;
  const AValues: array of Variant; const isInteger: boolean = false): Boolean;
var
  I: integer;
begin
  Result:= false;
  for I := Low(AValues) to High(AValues) do
  begin
    if isInteger then
    begin
      if (AText = Avalues[I]) then
      begin
        Result:= true;
        break;
      end;
    end else
    if AnsiSameText(AText,Avalues[I]) then
    begin
      Result:= true;
      break;
    end;
  end;
end;

function ArrayContainTextList(const AText: string; const AValues: TStrings; const sameText: boolean = false): Boolean;
var I: integer;
begin
  Result:= false;
  for I := 0 to AValues.Count-1 do
    if sameText then
    begin
      if AnsiSameText(AText,Avalues.Strings[I]) then
      begin
        Result:= true;
        break;
      end;
    end else
    begin
      if AnsiStartsText(Avalues.Strings[I],AText) then
      begin
        Result:= true;
        break;
      end else
      if AnsiContainsText(AText,Avalues.Strings[I]) then
      begin
        Result:= true;
        break;
      end;
    end;
end;

function ArrayDiffTextList(ASource, ATarget: TStringList; const sameText: boolean = true): TStringList;
var I: Integer;
begin
  Result:= TStringList.Create;
  for I:= 0 to (ASource.Count - 1) do
    if not(ArrayContainTextList(ASource.Strings[I], ATarget, sameText)) then
      Result.Add(ASource.Strings[I]);
end;

{ FIND INDEX OF TEXT IN ARRAY }
function ArrayIndexContainText(const AText: string;
  const AValues: array of string; const sameText: boolean = false): integer;
var I: integer;
begin
  Result:= -1;
  if (length(AValues)=0) then exit;
  for I := Low(AValues) to High(AValues) do
    if sameText then
    begin
      if AnsiSameText(AText,Avalues[I]) then
      begin
        Result:= I;
        break;
      end;
    end else
    begin
      if AnsiStartsText(Avalues[I],AText) then
      begin
        Result:= I;
        break;
      end;
    end;
end;

function ArrayIndexContainInteger(const AInt: integer; const AValues: array of integer): integer;
var I: integer;
begin
  Result:= -1;
  for I := Low(AValues) to High(AValues) do
    if (AInt=Avalues[I]) then
    begin
      Result:= I;
      break;
    end;
end;

function ArrayIndexContainTextList(const AText: string;
  const AValues: TStringList; const sameText: boolean = false): integer;
var I: integer;
begin
  Result:= -1;
  for I := 0 to AValues.Count-1 do
    if sameText then
    begin
      if AnsiSameText(AText,Avalues.Strings[I]) then
      begin
        Result:= I;
        break;
      end;
    end else
    begin
      if AnsiStartsText(Avalues.Strings[I],AText) then
      begin
        Result:= I;
        break;
      end;
    end;
end;

function ArrayToText(delim: string; var arrText: array of string): string;
var i: integer;
    text: string;
begin
  text:= '';
  for i:= 0 to length(arrText)-1 do
    text:= text + arrText[i] + delim;
  Result:= text;
end;

{ FIND LINE NUMBER ON MEMO }
function findLineSingle(find: string; SMemo: TMemo): integer;
var I, line: integer;
begin
  Result:= -1;
  I:= Pos(find, SMemo.Text);
  if I > 0 then
  begin
    line := SendMessage(SMemo.Handle, EM_LINEFROMCHAR, I - 1, 0);
    Result:= line;
  end;
end;

function findLine(find: string; SMemo: TMemo; nested: boolean): TIntArr;
var I,II,line,nextLine: integer;
    strLine: string;
    stop: boolean;
begin
  I:= Pos(find, SMemo.Text);
  if I > 0 then
  begin
    line := SendMessage(SMemo.Handle, EM_LINEFROMCHAR, I - 1, 0);
    if nested then
    begin
      stop:= false;
      inc(line);
      nextLine:= line;
      repeat
        inc(nextLine);
        strLine:= SMemo.Lines.ValueFromIndex[nextLine];
        for II := 1 to length(strLine) do
          if strLine[II] = ']' then
          begin
            stop := true;
            dec(nextLine);
          end;
      until stop;

      result[0]:= line;
      result[1]:= nextLine;
    end else
      result[0]:= line;
  end;
end;

{ SPLIT TEXT TO STRING LIST }
{
procedure Split (const Delimiter: string; Input: string; const Strings: TStrings);
var pos,len: integer;
    str: string;
begin
  Strings.Clear;
  pos:= 1;
  len:= length(Input);
  while pos <= len do
  begin
    if Input[pos] <> Delimiter then
      str:= str + Input[pos]
    else
    begin
      Strings.Add(Trim(str));
      str:='';
    end;
    inc(pos);
  end;
  Strings.Add(Trim(str));
end;
}

procedure Split (const Delimiter: string; Input: string; const Strings: TStrings);
var
  i: integer;
  str: string;
begin
  Strings.Clear;
  str:= Input;
  while not(i=0) do
  begin
    i:= AnsiPos(Delimiter, str);
    if not(i=0) then
    begin
      Strings.Add(Trim(copy(str,0,i-1)));
      str:= copy(str,i+1,length(str));
    end else
      break;
  end;
  Strings.Add(Trim(str));
end;

{ SPLIT TEXT TO STRING LIST }
procedure SplitInt(const Delimiter, Input: string; var arrInt: TIntArr);
var pos,len: integer;
    str: string;
begin
  SetLength(arrInt,0);
  pos:= 1;
  len:= length(Input);
  while pos <= len do
  begin
    if Input[pos] <> Delimiter then
      str:= str + Input[pos]
    else
    begin
      SetLength(arrInt, length(arrInt)+1);
      arrInt[length(arrInt)-1]:= strtoint(Trim(str));
      str:='';
    end;
    inc(pos);
  end;
  SetLength(arrInt, length(arrInt)+1);
  arrInt[length(arrInt)-1]:= strtoint(Trim(str));
end;

function splitChar(delimiter: char; s: string; limit: integer): string;
var
  pos, len: integer;
  lststr: tstrings;
  str: string;
begin
  Result:= s;
  lststr:= TStringList.Create;
  pos:= 1;
  len:= length(s);
  while pos <= len do
  begin
    str:= str + s[pos];
    if pos mod limit = 0 then
    begin
      lststr.Add(str);
      str:= '';
    end;
    inc(pos);
  end;

  Result:= implode(delimiter,lststr);
end;

function trimPos(const Delimiter: char; Input: string): string;
var
  spos: integer;
begin
  result:= input;
  spos:= pos(Delimiter,input);
  if (spos > 0) then
    result:= copy(input,spos+1,length(input));
end;

{ Join Text sparate with delimiter }
function trimStr(const Delimiter: string; Input: string): string;
var pos,len: integer;
    str: string;
begin
  Result:= '';
  pos:= 1;
  len:= length(Input);
  while pos <= len do
  begin
    if Input[pos] <> Delimiter then
      str:= str + Input[pos]
    else
    begin
      Result:= Result + Trim(str);
      str:='';
    end;
    inc(pos);
  end;
  Result:= Result + Trim(str);
end;

{ add extra quote to string }
function stripQuote(Input: string): string;
var pos,len: integer;
    str: string;
begin
  Result:= '';
  pos:= 1;
  len:= length(Input);
  while pos <= len do
  begin
    if Input[pos] <> '''' then
      str:= str + Input[pos]
    else
    begin
      Result:= Result + Trim(str) + '''''';
      str:='';
    end;
    inc(pos);
  end;
  Result:= Result + Trim(str);
end;

{  }
function Explode(const Delimiter: string; Input: string): TStrings;
begin
  Result:= TStringList.Create;
  split(Delimiter, Input, Result);
end;

{ MERGE STRINGLIST TO STRING WITH DELIMITER }
function Implode(const Delimiter: string; strList: TStrings; const pathDelim: string = ''): string;
var i: integer;
begin
  Result:= '';
  if (strList.Count > 0) then
    for i:= 0 to strList.Count-1 do
    begin
      Result:= Result + pathDelim + strList.Strings[i] + pathDelim;
      if (i <= strList.Count-2) then
        Result:= Result + Delimiter;
    end;
end;

{ MERGE STRINGLIST TO STRING WITH DELIMITER }
function ImplodeStr(const Delimiter: string; strList: array of string): widestring;
var i: integer;
begin
  Result:= '';
  if (length(strList) = 0) then
    Result:= 'N/A'
  else
    for i:= Low(strList) to High(strList) do
    begin
      Result:= Result + strList[i];
      if (i <= length(strList)-2) then
        Result:= Result + Delimiter;
    end;
end;

{ MERGE STRINGLIST TO STRING WITH DELIMITER }
function ImplodeInt(const Delimiter: string; intList: array of integer): widestring;
var i: integer;
begin
  Result:= '';
  if (length(intList) = 0) then
    Result:= '-1'
  else
    for i:= Low(intList) to High(intList) do
    begin
      Result:= Result + inttostr(intList[i]);
      if (i <= length(intList)-2) then
        Result:= Result + Delimiter;
    end;
end;

{ GET INDEX OF STRING IN LIST }
function findIndexStr(S: string; Str: TStrings): integer;
var i, catidx: integer;
    checkcat: TStringList;
begin
  Result:= -1;
  catidx:= -1;
  checkcat:= TStringList.Create;
  if str.Count > 0 then
  begin
    for i:= 0 to str.Count-1 do
      if AnsiStartsStr(S,str.Strings[i]) then
        catidx:= i;

    if catidx >= 0 then
    begin
      split('|',str.Strings[catidx],checkcat);
      Result:= StrToInt(checkcat[1]);
    end;
  end;
end;

function findIndex(S: string; Str: TStringList): integer;
begin
  Result:= findIndex(S,Str);
end;

{ PAD THE STRING }
function strPad(value: string; limit:integer; const middle: boolean = false): string;
const rPad: integer = 8;
      sPad: string = '...';
var lPad, sMax: integer;
    sLPad, sRPad: string;
begin
  lPad:= limit - rPad;
  sMax:= length(value);

  If middle and (sMax > (limit + length(sPad))) then
  begin
    sLPad:= copy(value,1,lPad);
    sRPad:= copy(value,(sMax-rPad),sMax);
    Result:= sLPad + sPad + sRPad;
  end
  else If not(middle) and (sMax > limit) then
    Result:= copy(value,1,limit) + sPad
  else
    Result:= value;
end;

{ PARSE FULLPATH TO STRINGLIST }
{ drive+(path+folder) if path 1 or last set folder}
procedure parsePath(fullPath: string; var strList: TStringList; const addLast: boolean = false);
var parse: TStringList;
    i, lastPos: integer;
    temp, path, filen: string;
begin
  temp:= '';
  lastPos:= 2;
  if (addLast) then
    lastPos:= 1;

  fullPath:= ExcludeTrailingPathDelimiter(fullPath);
  if FileExists(fullPath) then
  begin
    path:= ExtractFilePath(fullPath);
    filen:= ExtractFileName(fullPath);
  end else
  begin
    path:= fullPath;
    filen:= path;
  end;
  parse:= TStringList.Create;
  strList:= TStringList.Create;
  Split('\',path,parse);
  if (parse.Count > 0) then
    for i:= 0 to parse.Count-1 do
    begin
      if ((parse.Count >= 2) and (i >= 1) and (i <= (parse.Count-lastPos)))then
      begin
        temp:= temp + parse.Strings[i] + '\';
        if (i >= (parse.Count-lastPos)) then
          strList.Add(temp);
      end else
        strList.Add(parse.Strings[i]);
    end;

  if FileExists(filen) then
    strList.Add(filen);
end;

function walkString(delim, strings: string): string;
begin
    //
end;

function renamaFile(str, add: string; const delim: string = ''): string;
var ext, newString: string;
begin
  ext:= ExtractFileExt(str);
  newString:= StringReplace(str,ext,delim+add,[rfReplaceAll,rfIgnoreCase]);
  newString:= newString+ext;
  Result:= newString;
end;

function checkDoubleExt(filename, maskExt: string; const removeLast: boolean = true): boolean;
var
  strSplit, strExt: TStringList;
  ext, newfile: string;
begin
  Result:= false;
  strExt:= TStringList.Create;
  strSplit:= TStringList.Create;
  if (FileExists(filename)) then
  begin
    Split(';',maskExt,strExt);
    Split('.',filename,strSplit);
    if (strSplit.Count > 2) then
    begin
      ext:= '.'+strSplit.Strings[strSplit.count-2]; // check second last ext in filename
      if (ArrayContainTextList(LowerCase(ext),strExt,true)) then // rename if its extention (.mp4|.wmv to .mp4)
      begin
        strSplit.Delete(strSplit.Count-1);
        newfile:= Implode('.',strSplit);
        if (RenameFile(filename,newfile)) then
          checkDoubleExt(newfile,maskExt,removeLast); // loop case multi ext
        Result:= true;
      end;
    end;
  end;
end;

procedure invArrayInt(var intArray: TIntArr);
var i: integer;
    invArray: TIntArr;
begin
  setLength(invArray,0);
  for i:= High(intArray) downto Low(intArray) do
  begin
    setLength(invArray,length(invArray)+1);
    invArray[length(invArray)-1]:= intArray[i];
  end;
  setLength(intArray,0);
  intArray:= invArray;
end;

function copyArrayInt(const source: array of integer): TIntArr;
var i: integer;
begin
  setLength(Result,0);
  for i:= Low(source) to High(source) do
  begin
    setLength(Result,length(Result)+1);
    Result[length(Result)-1]:= source[i];
  end;
end;

{
  ARRAY SELECTION (GET SELECTION KEY INCLUDED)
  =====================================
  M = N + N;
  const data: array of integer = (1,2,4,8,16,32);
  result:= arrayMulti(7,data);
  7  = 1+2+4 = [1,2,4]
  29 = 1+4+8+16 = [1,4,8,16]
}
function arrayMulti(value: integer; const data: array of integer): TIntArr;
var
  i, idx : integer;
  subval, sumval, highval: longint;
  dataTemp: TIntArr;
begin
  setLength(Result,0);
  if ((length(data) > 0) AND (value > 0)) then
  begin
    // copy array to temp
    dataTemp:= copyArrayInt(data);

    // case when value bigger than array data
    highval:= dataTemp[High(dataTemp)];
    if (value > highval) then
    begin
      SetLength(dataTemp,length(dataTemp)+1);
      dataTemp[length(dataTemp)-1]:= highval * 2;
    end;

    // search index
    idx:= 0;
    for i:= Low(dataTemp) to High(dataTemp) do
    begin
      if (dataTemp[i] >= value) then
      begin
        idx:= i - 1;
        if (dataTemp[i] = value) then
          idx:= i;
        break;
      end;
    end;

    // get
    subval:= 0;
    for i:= idx downto 0 do
    begin
      sumval:= subval + dataTemp[i];
      if (sumval <= value) then
      begin
        subval:= sumval;
        setLength(Result,length(Result)+1);
        Result[length(Result)-1]:= dataTemp[i];
      end;
    end;

    invArrayInt(Result);
  end;
end;

{
  ARRAY SELECTION 2 (GET SELECTION INCLUDED KEY)
  =====================================
  const data: array of integer = (1,2,4,8);
  result:= arrayMulti2(data[1],data);
  2 = [2,3,6,7,10,11,14,15]
  4 = [4,5,6,7,12,13,14,15]
}
function arrayMulti2(value: integer; const data: array of integer): TIntArr;
var
  idx, eidx: integer;
  i, ii, lcount, scount, subval: longint;
begin
  setLength(Result,0);
  if ((length(data) > 0) AND (value > 0)) then
  begin
    // get index from data
    idx:= 0;
    for i:= Low(data) to High(data) do
      if (data[i] = value) then
      begin
        idx:= i;
        break;
      end;

    // get loop idx
    eidx:= High(data) - idx;
    lcount:= data[eidx];
    scount:= data[idx];

    subval:= scount;
    for i:= 1 to lcount do
    begin
      for ii:= 1 to scount do
      begin
        setLength(Result,length(Result)+1);
        Result[length(Result)-1]:= subval;
        inc(subval);
      end;
      subval:= subval + scount;
    end;

    invArrayInt(Result);
  end;
end;

{ MEDIA TIMER }
function mediaTimer(pos, length: longint; const reverse: boolean = false; const sparate: string = ':'): string;
var
  maxl, tdet, hrs, mnt, det: longint;
  shrs, smnt, sdet: string;
begin
  maxl:= length div 1000;
  if not(reverse) then tdet:= pos div 1000
  else tdet := maxl - (pos div 1000);

  hrs:= tdet div 3600;
  mnt:= (tdet mod 3600) div 60;
  det:= tdet mod 60;
  if (hrs < 10) then shrs:= '0'+inttostr(hrs)
  else shrs:= inttostr(hrs);
  if (mnt < 10) then smnt:= '0'+inttostr(mnt)
  else smnt:= inttostr(mnt);
  if (det < 10) then sdet:= '0'+inttostr(det)
  else sdet:= inttostr(det);

  Result:= shrs+sparate+smnt+sparate+sdet;
end;

function microTime(fullTime: string): int64;
var lstSplit: TstringList;
    h,m,s,n: int64;
begin
  Result:= 0;
  lstSplit:= TStringList.Create;
  Split(':',fullTime,lstSplit);
  if lstSplit.Count = 3 then
  begin
    h:= strtoint(lstSplit.Strings[0]) * 3600000;
    m:= strtoint(lstSplit.Strings[1]) * 60000;
    s:= strtoint(lstSplit.Strings[2]) * 1000;
    Result:= h+m+s;
  end else
  if lstSplit.Count = 4 then
  begin
    h:= strtoint(lstSplit.Strings[0]) * 3600000;
    m:= strtoint(lstSplit.Strings[1]) * 60000;
    s:= strtoint(lstSplit.Strings[2]) * 1000;
    n:= strtoint(lstSplit.Strings[3]);
    Result:= h+m+s+n;
  end;
end;

function padFileDrive(fullPath: string): string;
begin
  Result:= StringReplace(fullPath,ExtractFileDrive(fullPath),'',[rfReplaceAll,rfIgnoreCase]);
end;

{ MOVE TRACKBAR TICK TO CLICK POSITION }
function syncTrackbar(mouseX: cardinal; barWidth, barClientWidth, barLeft, barMin, barMax: int64;
  const Space: integer = 11): cardinal;
var
  Offset, Position:Integer;
begin
  Offset:= (mouseX+4) - (barWidth-barClientwidth) div 2 - barLeft - Space;
  Position:= Round(barMin+Offset/(barWidth-2*Space)*(barMax-barMin));
  Result:= Position;
end;

end.



