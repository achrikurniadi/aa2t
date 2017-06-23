unit UData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, JvJCLUtils,
  HelperGeneral, UMemory, UMemoryHelper, UObjectArray;

type
  TStrCode = record
    //address  : dword;
    base     : dword;
    offset   : TOffsets;
    bits     : integer;
    bitLength: integer;
    isUnicode: boolean;
  end;

  TCodeAddress = record
    name     : string;
    code     : string;
    //address  : dword;
    base     : dword;
    offset   : TOffsets;
    bits     : integer;
    bitLength: integer;
    isUnicode: boolean;
  end;

  TFreezeData = record
    types     : string;
    seatNumber: integer;
    toSeat    : integer;
    field     : string;

    isValid  : boolean;
    unixID   : string;
    codes    : TCodeAddress;

    isFreeze : boolean;
    FreezeValue: string;
  end;
  
  TMultiCode = record
    codes    : array of TCodeAddress;
  end;

  TDataCode = record
    NameCode  : array of string;
    SingleCode: array of TCodeAddress;
    MultiCode : array of TMultiCode;
  end;

  TRegenCode = record
    KeyName  : array of string;
    DataCode : array of TDataCode;
  end;

  TData = class
    Process: TPMemory;
    CharCode: TObjectArray;
    CodeKey: array of string;
    StrCode: TStrCode;
    RegenCode: array of TRegenCode;
    FreezeData: array of TFreezeData;
    private
      function filterOffsetCode(ID: integer; value: string; const multiCode: boolean = false): string;
    public
      constructor Create;
      destructor Destroy; override;

      procedure parseCodeToData(code: string);
      function getValueByCode(strAddress: string; const isNumber: boolean = false; const isNull: boolean = false): string;
      procedure setValueByCode(strAddress, value: string);

      procedure clearAllData;
      procedure generateCode(types: integer; lstCode: TStrings);
      function getCodes(types: integer; codeName:string; const ID: integer =-1;
        const asValue: boolean = false; const isNumber: boolean = false; const ID2: integer =-1; const isNull: boolean = false): string;
      function getValue(Address: dword; VarType: integer; const Bit: Byte = 20;
        const Unicode: boolean = false; const isNumber: boolean = false): string;
      procedure setValue(value: string; Address: dword; VarType: integer; const Bit: Byte = 20;
        const Unicode: boolean = false);

      procedure regenerateAddress;
      function getRegenAddress(types, ID, CodeIdx: integer; const ID2: integer = -1; const posCodeIdx: integer = -1): dword; overload; virtual;
      function getRegenAddress(types, ID: integer; CodeName: string; const ID2: integer = -1; const posCodeIdx: integer = -1): dword; overload; virtual;
      function getRegenCode(types, ID, CodeIdx: integer; const ID2: integer = -1; const posCodeIdx: integer = -1): string; overload; virtual;
      function getRegenCode(types, ID: integer; CodeName: string; const ID2: integer = -1): string; overload; virtual;
      function getRegenValue(types, ID, CodeIdx: integer; const isNumber: boolean = false; const ID2: integer = -1; const posCodeIdx: integer = -1; const isNull: boolean = false): string; overload; virtual;
      function getRegenValue(types, ID: integer; CodeName: string; const isNumber: boolean = false; const ID2: integer = -1; const posCodeIdx: integer = -1; const isNull: boolean = false): string; overload; virtual;
      procedure setRegenValue(types, ID, CodeIdx: integer; value: string; const ID2: integer = -1; const posCodeIdx: integer = -1); overload; virtual;
      procedure setRegenValue(types, ID: integer; CodeName, value: string; const ID2: integer = -1; const posCodeIdx: integer = -1); overload; virtual;
  end;

implementation

constructor TData.Create;
begin
  Process:= TPMemory.Create;
  CharCode:= TObjectArray.Create;

  // generate regen code
  SetLength(RegenCode,25);
end;

destructor TData.Destroy;
begin
  clearAllData;
  Process.Free;
  CharCode.Free;
end;

{ =================================================================== PROCESS MEMORY ========================================================== }
function TData.filterOffsetCode(ID: integer; value: string; const multiCode: boolean = false): string;
var
  i, posChange: integer;
  tempStr0, tempStr1, tempStr2, tempPos: TStrings;
begin
  Result:= value;
  tempStr0:= TStringList.Create;
  try
    tempStr0:= Explode('+',value); // split address
    tempStr1:= TStringList.Create;
    tempPos := TStringList.Create;
    try
      // check if posChange offset included in core
      posChange:= -1;
      i:= AnsiPos('|',tempStr0.Strings[1]);
      if not(i=0) then
      begin
        tempPos:= Explode('|',tempStr0.Strings[1]);
        tempStr2:= TStringList.Create;
        try
          tempStr2:= Explode(',',tempPos.Strings[1]);
          if multiCode then posChange:= strtoint(tempStr2.Strings[1])
          else posChange:= strtoint(tempStr2.Strings[0]);
        finally
          tempStr2.Free;
        end;
      end;

      if not(posChange=-1) then tempStr1:= Explode('-',tempPos.Strings[0])
      else tempStr1:= Explode('-',tempStr0.Strings[1]);

      for i:= 0 to tempStr1.Count-1 do
      if ((posChange=-1) OR (posChange=i)) then
      begin
        tempStr2:= TStringList.Create;
        try
          tempStr2:= Explode('^',tempStr1.Strings[i]);
          if (tempStr2.Count=2) then
            tempStr1.Strings[i]:= dec2hex((Hex2Dec(tempStr2.Strings[0])+(ID*Hex2Dec(tempStr2.Strings[1]))),4);
        finally
          tempStr2.Free;
        end;
      end;
    finally
      tempStr0.Strings[1]:= Implode('-',tempStr1);
      tempStr1.Free;
      tempPos.Free;
    end;
  finally
    Result:= Implode('+',tempStr0);
    tempStr0.Free;
  end;
end;

procedure TData.parseCodeToData(code: string);
var
  address : dword;
  getOffset : TOffsets;
  tempStr: TStrings;
  strAddr: string;
  count: integer;
begin
  tempStr:= Explode('+',code);
  try
    strAddr:= copy(tempStr.Strings[0],2,length(tempStr.Strings[0])-1);
    StrCode.bits:= getTypeByte(tempStr.Strings[0][1]);

    StrCode.bitLength:= 20;
    if (StrCode.bits=11) then StrCode.bitLength:= 104;
    if (tempStr.Count=4) then StrCode.bitLength:= strtoint(tempStr.Strings[3]);

    StrCode.isUnicode:= false;
    if (tempStr.Count=3) then
      if (tempStr.Strings[2]='1') then
        StrCode.isUnicode:= true;

    ConvertStringToOffset(tempStr.Strings[1],getOffset,'-');
    val(ConvertHexStrToRealStr(strAddr),address,count);
    StrCode.base   := address;
    StrCode.offset := getOffset;
    //StrCode.address:= Process.GetRealAddress(address+Process.PBaseAddress,getOffset);
  finally
    tempStr.Free;
  end;
end;

function TData.getValueByCode(strAddress: string; const isNumber: boolean = false; const isNull: boolean = false): string;
var
  strCheck: TStrings;
  strRet, getVal: string;
begin
  strRet:= '????????';
  if isNumber then strRet:= '-1';

  strCheck:= Explode('+',strAddress);
  try
    if (strCheck.Count>1) then
    begin
      parseCodeToData(strAddress);
      getVal:= Process.GetValues(Process.GetRealAddress(StrCode.base+Process.PBaseAddress,StrCode.offset),StrCode.bits,StrCode.bitLength,StrCode.isUnicode);
      if not(getVal='') AND not(getVal[1]='?') then
        strRet:= getVal;
    end;
  finally
    strCheck.Free;
    Result:= strRet;
  end;
  if isNull AND (not(Result='') AND (Result[1]='?')) then
    Result:= '';
end;

procedure TData.setValueByCode(strAddress, value: string);
var
  checkVal: string;
begin
  checkVal:= getValueByCode(strAddress);
  if not(checkVal='') AND not(checkVal[1]='?') then
    Process.SetValues(Process.GetRealAddress(StrCode.base+Process.PBaseAddress,StrCode.offset),StrCode.bits,value,StrCode.isUnicode);
end;

function TData.getValue(Address: dword; VarType: integer; const Bit: Byte = 20;
  const Unicode: boolean = false; const isNumber: boolean = false): string;
var
  strRet, getVal: string;
begin
  strRet:= '????????';
  if isNumber then strRet:= '-1';

  getVal:= Process.GetValues(Address,VarType,Bit,Unicode);
  if not(getVal='') AND not(getVal[1]='?') then
    strRet:= getVal;

  Result:= strRet;
end;

procedure TData.setValue(value: string; Address: dword; VarType: integer; const Bit: Byte = 20;
  const Unicode: boolean = false);
var
  getVal: string;
begin
  getVal:= Process.GetValues(Address,VarType,Bit,Unicode);
  if not(getVal='') AND not(getVal[1]='?') then
    Process.SetValues(Address,VarType,value,Unicode);
end;


{ ================================================================== DATA CODE ================================================================= }

procedure TData.clearAllData;
var i, ii,iii: integer;
begin
  SetLength(CodeKey,0);

  if (length(FreezeData)>0) then
  begin
    for i:= 0 to length(FreezeData)-1 do
      SetLength(FreezeData[i].codes.offset,0);
    SetLength(FreezeData,0);
  end;

  // code regeneration address
  if (length(RegenCode)>0) then
  begin
    for i:= 0 to length(RegenCode)-1 do
    begin
      SetLength(RegenCode[i].KeyName,0);
      if (length(RegenCode[i].DataCode)>0) then
        for ii:= 0 to length(RegenCode[i].DataCode)-1 do
        begin
          SetLength(RegenCode[i].DataCode[ii].NameCode,0);
          SetLength(RegenCode[i].DataCode[ii].SingleCode,0);
          if (length(RegenCode[i].DataCode[ii].MultiCode)>0) then
          for iii:= 0 to length(RegenCode[i].DataCode[ii].MultiCode)-1 do
            SetLength(RegenCode[i].DataCode[ii].MultiCode[iii].codes,0);
        end;
    end;
    SetLength(RegenCode,0);
  end;
end;

procedure TData.generateCode(types: integer; lstCode: TStrings);
var
  posCode, i, ii, iii, idxCode: integer;
  lstSplit: TStrings;
  str: string;
begin
  lstSplit:= TStringList.Create;
  try
  case types of
    // main code
    0,8: for i:= 0 to lstCode.Count-1 do
      if (AnsiPos('\',lstCode.Strings[i])=0) then
      begin
        lstSplit:= Explode('=',lstCode.Strings[i]);
        if (lstSplit.Count>1) then
          CharCode.Data[CodeKey[types],lstSplit.Strings[0]]:= lstSplit.Strings[1];
      end;
    // single code
    else
      for i:= 0 to 24 do
      begin
        posCode:= ArrayIndexContainText(codeKey[types],RegenCode[i].KeyName,true);
        if (posCode=-1) then
        begin
          SetLength(RegenCode[i].KeyName,length(RegenCode[i].KeyName)+1);
          RegenCode[i].KeyName[length(RegenCode[i].KeyName)-1]:= codeKey[types];
          posCode:= length(RegenCode[i].DataCode);
          SetLength(RegenCode[i].DataCode,posCode+1);
        end;

        for ii:= 0 to lstCode.Count-1 do
        if (AnsiPos('\',lstCode.Strings[ii])=0) then
        begin          
          lstSplit:= Explode('=',lstCode.Strings[ii]);
          if (lstSplit.Count>1) then
          begin
            str:= filterOffsetCode(i,lstSplit.Strings[1]);

            idxCode:= length(RegenCode[i].DataCode[posCode].NameCode);
            SetLength(RegenCode[i].DataCode[posCode].NameCode,idxCode+1);
            RegenCode[i].DataCode[posCode].NameCode[idxCode]:= lstSplit.Strings[0];

            // single id
            if (AnsiPos('|',lstSplit.Strings[1])=0) then
            begin
              SetLength(RegenCode[i].DataCode[posCode].SingleCode,idxCode+1);
              RegenCode[i].DataCode[posCode].SingleCode[idxCode].name:= lstSplit.Strings[0];
              RegenCode[i].DataCode[posCode].SingleCode[idxCode].code:= str;
              parseCodeToData(RegenCode[i].DataCode[posCode].SingleCode[idxCode].code);
              RegenCode[i].DataCode[posCode].SingleCode[idxCode].base     := strCode.base;
              RegenCode[i].DataCode[posCode].SingleCode[idxCode].offset   := strCode.offset;
              //RegenCode[i].DataCode[posCode].SingleCode[idxCode].address  := strCode.address;
              RegenCode[i].DataCode[posCode].SingleCode[idxCode].bits     := strCode.bits;
              RegenCode[i].DataCode[posCode].SingleCode[idxCode].bitLength:= strCode.bitLength;
              RegenCode[i].DataCode[posCode].SingleCode[idxCode].isUnicode:= strCode.isUnicode;
            end else
            // multiple id, id2
            for iii:= 0 to 24 do
            begin
              // one set for each char
              if (length(RegenCode[i].DataCode[posCode].MultiCode)=0) then
                SetLength(RegenCode[i].DataCode[posCode].MultiCode,25);

              if (idxCode=length(RegenCode[i].DataCode[posCode].MultiCode[iii].codes)) then
                SetLength(RegenCode[i].DataCode[posCode].MultiCode[iii].codes,idxCode+1);

              RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].name     := lstSplit.Strings[0];
              RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].code     := filterOffsetCode(iii,str,true);
              parseCodeToData(RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].code);
              RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].base     := strCode.base;
              RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].offset   := strCode.offset;
              //RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].address  := strCode.address;
              RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].bits     := strCode.bits;
              RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].bitLength:= strCode.bitLength;
              RegenCode[i].DataCode[posCode].MultiCode[iii].codes[idxCode].isUnicode:= strCode.isUnicode;
            end;
          end;
        end;
      end;
  end;
  finally
    lstSplit.Free;
  end;
end;

function TData.getCodes(types: integer; codeName:string; const ID: integer =-1;
  const asValue: boolean = false; const isNumber: boolean = false; const ID2: integer =-1; const isNull: boolean = false): string;
begin
  case types of
    0,8: if asValue then Result:= getValueByCode(CharCode.Data[codeKey[types],codeName], isNumber)
       else Result:= CharCode.Data[codeKey[types],codeName];
    else
    begin
      Result:= getRegenCode(types,ID,codeName,ID2);
      if asValue then Result:= getValueByCode(Result,isNumber);
    end;
  end;

  if isNull AND (not(Result='') AND (Result[1]='?')) then
    Result:= '';
end;

procedure TData.regenerateAddress;
var
  codeID, charID, toCharID, codeIdx: integer;
  address: dword;
begin
  for charID:= 0 to 24 do
    if (length(RegenCode[charID].KeyName)>0) then
    for codeID:= 0 to length(RegenCode[charID].KeyName)-1 do
    case codeID of
      // char action address
      0,1: if (length(RegenCode[charID].DataCode[codeID].SingleCode)>0) then
      for codeIdx:= 0 to length(RegenCode[charID].DataCode[codeID].SingleCode)-1 do
      begin
        //parseCodeToData(RegenCode[charID].DataCode[codeID].SingleCode[codeIdx].code);
        address:= Process.GetRealAddress(RegenCode[charID].DataCode[codeID].SingleCode[codeIdx].base+Process.PBaseAddress,RegenCode[charID].DataCode[codeID].SingleCode[codeIdx].offset);
        //RegenCode[charID].DataCode[codeID].SingleCode[codeIdx].address  := address;
        //RegenCode[charID].DataCode[codeID].SingleCode[codeIdx].bits     := strCode.bits;
        //RegenCode[charID].DataCode[codeID].SingleCode[codeIdx].bitLength:= strCode.bitLength;
        //RegenCode[charID].DataCode[codeID].SingleCode[codeIdx].isUnicode:= strCode.isUnicode;
      end;
      else
      if (length(RegenCode[charID].DataCode[codeID].MultiCode)>0) then
      for toCharID:= 0 to length(RegenCode[charID].DataCode[codeID].MultiCode)-1 do
        if (length(RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes)>0) then
        for codeIdx:= 0 to length(RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes)-1 do
        begin
          //parseCodeToData(RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes[codeIdx].code);
          address:= Process.GetRealAddress(RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes[codeIdx].base+Process.PBaseAddress,RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes[codeIdx].offset);
          //RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes[codeIdx].address  := address;
          //RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes[codeIdx].bits     := strCode.bits;
          //RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes[codeIdx].bitLength:= strCode.bitLength;
          //RegenCode[charID].DataCode[codeID].MultiCode[toCharID].codes[codeIdx].isUnicode:= strCode.isUnicode;
        end;
    end;
end;

function TData.getRegenAddress(types, ID, CodeIdx: integer; const ID2: integer = -1; const posCodeIdx: integer = -1): dword;
var
  posCode: integer;
begin
  posCode:= posCodeIdx;
  if (posCode=-1) then posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  case types of
    // single code
    1,2: Result:= //RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].address;
      Process.GetRealAddress(RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].base+Process.PBaseAddress,RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].offset);
    // multi code
    else Result:= //RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].address;
      Process.GetRealAddress(RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].base+Process.PBaseAddress,RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].offset);
  end;
end;

function TData.getRegenAddress(types, ID: integer; codeName: string; const ID2: integer = -1; const posCodeIdx: integer = -1): dword;
var posCode, CodeIdx: integer;
begin
  posCode:= posCodeIdx;
  if (posCode=-1) then posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  CodeIdx:= ArrayIndexContainText(codeName,RegenCode[ID].DataCode[posCode].NameCode,true);
  Result:= getRegenAddress(types,ID,CodeIdx,ID2,posCode);
end;

function TData.getRegenCode(types, ID, CodeIdx: integer; const ID2: integer = -1; const posCodeIdx: integer = -1): string;
var
  posCode: integer;
begin
  posCode:= posCodeIdx;
  if (posCode=-1) then posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  case types of
    // single code
    1,2: Result:= RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].code;
    // multi code
    else Result:=RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].code;
  end;
end;

function TData.getRegenCode(types, ID: integer; codeName: string; const ID2: integer = -1): string;
var posCode, CodeIdx: integer;
begin
  posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  CodeIdx:= ArrayIndexContainText(codeName,RegenCode[ID].DataCode[posCode].NameCode,true);
  Result:= getRegenCode(types,ID,CodeIdx,ID2,posCode);
end;

function TData.getRegenValue(types, ID, CodeIdx: integer; const isNumber: boolean = false; const ID2: integer = -1; const posCodeIdx: integer = -1; const isNull: boolean = false): string;
var
  strRet, getVal: string;
  posCode: integer;
begin
  strRet:= '????????';
  getVal:= strRet;
  if isNumber then strRet:= '-1';

  posCode:= posCodeIdx;
  if (posCode=-1) then posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  case types of
    // single code
    1,2: getVal:= //getValue(RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].address,
      getValue(Process.GetRealAddress(RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].base+Process.PBaseAddress,RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].offset),
      RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].bits,RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].bitLength,RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].isUnicode,isNumber);
    // multi code
    else
      getVal:= //getValue(RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].address,
      getValue(Process.GetRealAddress(RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].base+Process.PBaseAddress,RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].offset),
        RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].bits,RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].bitLength,RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].isUnicode,isNumber);
  end;

  if isNull AND (not(getVal='') AND (getVal[1]='?')) then
    strRet:= ''
  else if not(getVal[1]='?') then
    strRet:= getVal;

  Result:= strRet;
end;

function TData.getRegenValue(types, ID: integer; codeName: string; const isNumber: boolean = false; const ID2: integer = -1; const posCodeIdx: integer = -1; const isNull: boolean = false): string;
var CodeIdx,posCode: integer;
begin
  posCode:= posCodeIdx;
  if (posCode=-1) then posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  CodeIdx:= ArrayIndexContainText(codeName,RegenCode[ID].DataCode[posCode].NameCode,true);
  Result:= getRegenValue(types,ID,CodeIdx,isNumber,ID2,posCode,isNull);
end;

procedure TData.setRegenValue(types, ID, CodeIdx: integer; value: string; const ID2: integer = -1; const posCodeIdx: integer = -1);
var
  getVal: string;
  posCode: integer;
begin
  getVal:= getRegenValue(types, ID, CodeIdx, false, ID2);
  posCode:= posCodeIdx;
  if (posCode=-1) then posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  if not(getVal='') AND not(getVal[1]='?') then
  case types of
    // single code
    1,2: //setValue(value, RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].address,
      setValue(value,Process.GetRealAddress(RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].base+Process.PBaseAddress,RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].offset),
      RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].bits,RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].bitLength,RegenCode[ID].DataCode[posCode].SingleCode[CodeIdx].isUnicode);
    else
    // multi code
      //setValue(value, RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].address,
      setValue(value,Process.GetRealAddress(RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].base+Process.PBaseAddress,RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].offset),
      RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].bits,RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].bitLength,RegenCode[ID].DataCode[posCode].MultiCode[ID2].codes[CodeIdx].isUnicode);
  end;
end;

procedure TData.setRegenValue(types, ID: integer; codeName, value: string; const ID2: integer = -1; const posCodeIdx: integer = -1);
var CodeIdx,posCode: integer;
begin
  posCode:= posCodeIdx;
  if (posCode=-1) then posCode:= ArrayIndexContainText(codeKey[types],RegenCode[ID].KeyName,true);
  CodeIdx:= ArrayIndexContainText(codeName,RegenCode[ID].DataCode[posCode].NameCode,true);
  setRegenValue(types,ID,CodeIdx,value,ID2,posCode);
end;

end.
