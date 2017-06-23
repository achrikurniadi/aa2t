unit UMemoryHelper;

interface

uses
  Windows, messages, dialogs, classes, SysUtils, StrUtils, Math, JvJCLUtils;

Type
  TBytes = array of integer;
  TOffsets = array of Dword;

function ConvertHexStrToRealStr(const s: string): string;

procedure ConvertStringToBytes(scanvalue:string; hex:boolean;var bytes: TBytes; const delim: char = '-');
procedure ConvertStringToOffset(scanvalue:string; var bytes: TOffsets; const delim: char = '-');

function HexStringToColor(s: string; const addzero: boolean = false): Dword;

function ByteStringToText(s: string;hex: boolean):string;
function ByteStringToDouble(s: string;hex: boolean):double;
function ByteStringToSingle(s: string;hex: boolean):single;
function ByteStringToInt(s: string;hex: boolean):int64;
function VarToBytes(v: pointer; size: integer): string;
function RawToString(const buf: array of byte; vartype: integer;showashex: boolean; bufsize: integer):string;
function IntToBin(i: int64):string;
function BinToInt(s: string): int64;

function getTypeByte(value: string): integer;

const
  BitAddr : array [0..6] of integer = (3,4,7,8,9,5,6);
  BitMem  : array [0..6] of integer = (1,4,11,2,12,5,6);

implementation

uses HelperGeneral;

function getTypeByte(value: string): integer;
var
  tipe, check: integer;
begin
  Result:= -1;

  if (length(value)>1) then
    value:= value[1];

  val(value,tipe,check);
  if (check=0) then
    Result:= bitmem[ArrayIndexContainInteger(tipe,bitaddr)];
end;


function HexStringToColor(s: string; const addzero: boolean = false): Dword;
var
  temp: TBytes;
  tstr: string;
  i: integer;
begin
  tstr:= s;
  //tstr:= splitChar('-',s,2);
  ConvertStringToBytes(tstr,true,temp);

  if addzero then
  begin
    setlength(temp,length(temp)+1);
    temp[length(temp)-1]:= $FF;
  end;

  tstr:= '';
  for i:= length(temp)-1 downto 1 do
    tstr:= tstr+dec2hex(temp[i],2);
  
  val('$'+tstr,Result,i);
end;

procedure ConvertStringToOffset(scanvalue:string; var bytes: TOffsets; const delim: char = '-');
{
Converts a given string into a array of TBytes.
TBytes are not pure bytes, they can hold -1, which indicates a wildcard
}
var i,j,k: integer;
    helpstr:string;
begin
  setlength(bytes,0);
  if length(scanvalue)=0 then exit;

  while scanvalue[length(scanvalue)]=' ' do
    scanvalue:=copy(scanvalue,1,length(scanvalue)-1);

  if (pos(delim,scanvalue)>0) or (pos(' ',scanvalue)>0) then
  begin
    //syntax is xx-xx-xx or xx xx xx
    j:=1;
    k:=0;
    scanvalue:=scanvalue+' ';

    for i:=1 to length(scanvalue) do
    begin
      if (scanvalue[i]=' ') or (scanvalue[i]=delim) then
      begin
        helpstr:=copy(scanvalue,j,i-j);
        j:=i+1;
        setlength(bytes,k+1);
        //try
          bytes[k]:=strtoint('$'+helpstr);
        //except
        //  bytes[k]:=-1;
          //if it is not a '-' or ' ' or a valid value then I assume it is a wildcard.(I know, retarded)
        //end;
        inc(k);
      end;
    end;
  end else
  begin
    //syntax is xxxxxx
    k:=0;
    j:=1;
    for i:=1 to length(scanvalue) do
    begin
      if (i mod 2)=0 then
      begin
        helpstr:=copy(scanvalue,j,i-j+1);
        j:=i+1;
        setlength(bytes,k+1);
        //try
          bytes[k]:=strtoint('$'+helpstr);
        //except
        //  bytes[k]:=-1;
        //end;
        inc(k);
      end;
    end;
  end;
end;

procedure ConvertStringToBytes(scanvalue:string; hex:boolean;var bytes: TBytes; const delim: char = '-');
{
Converts a given string into a array of TBytes.
TBytes are not pure bytes, they can hold -1, which indicates a wildcard
}
var i,j,k: integer;
    helpstr:string;
begin
  setlength(bytes,0);
  if length(scanvalue)=0 then exit;

  while scanvalue[length(scanvalue)]=' ' do
    scanvalue:=copy(scanvalue,1,length(scanvalue)-1);

  if (pos(delim,scanvalue)>0) or (pos(' ',scanvalue)>0) then
  begin
    //syntax is xx-xx-xx or xx xx xx
    j:=1;
    k:=0;
    scanvalue:=scanvalue+' ';

    for i:=1 to length(scanvalue) do
    begin
      if (scanvalue[i]=' ') or (scanvalue[i]=delim) then
      begin
        helpstr:=copy(scanvalue,j,i-j);
        j:=i+1;
        setlength(bytes,k+1);
        try
          if hex then bytes[k]:=strtoint('$'+helpstr)
                 else bytes[k]:=strtoint(helpstr);
        except
          bytes[k]:=-1;
          //if it is not a '-' or ' ' or a valid value then I assume it is a wildcard.(I know, retarded)
        end;
        inc(k);
      end;
    end;
  end else
  begin
    //syntax is xxxxxx
    k:=0;
    j:=1;
    for i:=1 to length(scanvalue) do
    begin
      if (i mod 2)=0 then
      begin
        helpstr:=copy(scanvalue,j,i-j+1);
        j:=i+1;
        setlength(bytes,k+1);
        try
          bytes[k]:=strtoint('$'+helpstr);
        except
          bytes[k]:=-1;
        end;
        inc(k);
      end;
    end;
  end;
end;

function ConvertHexStrToRealStr(const s: string): string;
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

function RawToString(const buf: array of byte; vartype: integer;showashex: boolean; bufsize: integer):string;
var x: pchar;
    i: integer;
begin
  //buffsize has to match the type else error
  if bufsize=0 then
  begin
    result:='???';
    exit;
  end;

  try
  case vartype of
    0: if bufsize<>1 then result:='???' else if showashex then result:=inttohex(buf[0],2) else result:=inttostr(buf[0]);
    1: if bufsize<>2 then result:='???' else if showashex then result:=inttohex(pshortint(@buf[0])^,2) else result:=inttostr(pshortint(@buf[0])^);
    2: if bufsize<>4 then result:='???' else if showashex then result:=inttohex(pint(@buf[0])^,4) else result:=inttostr(pint(@buf[0])^);
    3: if bufsize<>4 then result:='???' else result:=floattostr(psingle(@buf[0])^);
    4: if bufsize<>8 then result:='???' else result:=floattostr(pdouble(@buf[0])^);
    6: if bufsize<>4 then result:='???' else if showashex then result:=inttohex(pint64(@buf[0])^,8) else result:=inttostr(pint64(@buf[0])^);
    7:
    begin
      getmem(x,bufsize+1);
      x[bufsize]:=#0;
      result:=x;
      freemem(x);
    end;

    8: //array of bytes
    begin
      result:='';
      for i:=0 to bufsize-1 do
        result:=result+'-'+inttohex(buf[bufsize],2);
    end;

    else result:='not supported in this version';
  end;
  except
    result:='Not convertable';
  end;
end;



function HexStrToInt(const S: string): Integer;
begin
  result:=StrToint(ConvertHexStrToRealStr(s));
end;

function HexStrToInt64(const S: string): Int64;
begin
  result:=StrToint64(ConvertHexStrToRealStr(s));
end;

function ByteStringToText(s: string;hex: boolean):string;
var temp: tbytes;
    i: integer;
begin
  ConvertStringToBytes(s,hex,temp);
  result:='';

  for i:=0 to length(temp)-1 do
    if temp[i]>$13 then
      result:=result+chr(temp[i]);
end;


function ByteStringToDouble(s: string;hex: boolean):double;
var temp: tbytes;
    temp2: double;
    p: ^byte;
    i,j: integer;
begin
  ConvertStringToBytes(s,hex,temp);
  p:=@temp2;

  if length(temp)<8 then
  begin
    j:=length(temp);
    setlength(temp,8);
    for i:=j to 7 do
      temp[i]:=0;
  end;

  for i:=0 to length(temp)-1 do
  begin
    if temp[i]=-1 then temp[i]:=0;

    p^:=byte(temp[i]);
    inc(p);
  end;

  result:=temp2;
end;


function ByteStringToSingle(s: string;hex: boolean):single;
var temp: tbytes;
    temp2: single;
    p: ^byte;
    i,j: integer;
begin
  ConvertStringToBytes(s,hex,temp);
  p:=@temp2;

  if length(temp)<4 then
  begin
    j:=length(temp);
    setlength(temp,4);
    for i:=j to 3 do
      temp[i]:=0;
  end;

  for i:=0 to length(temp)-1 do
  begin
    if temp[i]=-1 then temp[i]:=0;

    p^:=byte(temp[i]);
    inc(p);
  end;

  result:=temp2;
end;

function ByteStringToInt(s: string;hex: boolean):int64;
var temp: tbytes;
    i: integer;
    power: integer;

begin
  ConvertStringToBytes(s,hex,temp);
  power:=0;
  result:=0;

  for i:=0 to length(temp)-1 do
  begin
    result:=result+(temp[i]*trunc(math.power(256,power)));
    inc(power);
  end;
end;

function VarToBytes(v: pointer; size: integer): string;
var p: ^byte;
    j,k: integer;
    res: array of string;
begin
  result:='';
  p:=v;

  setlength(res,size);

  for k:=0 to size-1 do
  begin
    res[k]:=inttohex(p^,2);
    inc(p);
  end;

  j:=size;
  for k:=size-1 to 1 do
    if res[k]='00' then dec(j);

  for k:=0 to j-1 do
    result:=result+res[k]+' ';

  result:=copy(result,1,length(result)-1);
end;

function BinToInt(s: string): int64;
var i: integer;
begin
  result:=0;
  for i:=length(s) downto 1 do
    if s[i]='1' then result:=result+trunc(power(2,length(s)-i ));
end;

function Inttobin(i: int64): string;
var temp,temp2: string;
    j: integer;
begin
  temp:='';
  while i>0 do
  begin
    if (i mod 2)>0 then temp:=temp+'1'
                   else temp:=temp+'0';
    i:=i div 2;
  end;

  temp2:='';
  for j:=length(temp) downto 1 do
    temp2:=temp2+temp[j];
  result:=temp2;
end;

end.
 