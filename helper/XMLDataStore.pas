unit XMLDataStore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, UObjectArray;

type
  TXMLCode = record
    CodeID : int64;
    Name   : string;
    Code   : string;
    ID2    : integer;
    Address: dword;
    VarType: integer;
    Length : integer;
    OffStr : string;
    Offset : array of dword;
    RealAddress: dword;
  end;

  TXMLData = record
    Name   : string;
    Codes  : array of TXMLCode;
    Total  : integer;
  end;

  TXMLChar = record
    ID     : integer;
    Data   : array of TXMLData;
  end;

  TArrResult = record
    ID     : integer;
    Table  : string;
    Total  : integer;

    CodeID : int64;
    ID2    : integer;
    Name   : string;
    Address: dword;
    VarType: integer;
    Length : integer;
    OffStr : string;
    Offset : array of dword;
    RealAddress: dword;
  end;

  TXMLDataStore = class
    TextObj: TObjectArray;
    private
      NoChar, NoData, NoCodes: integer;
      ArrChar: array of TXMLChar;

      procedure reiXML(node: IXMLNode);
      procedure parseXML(node: IXMLNode);
      procedure newCharacter;
    public
      UnixID: int64;
      MaxChar: integer;
      Data: array of TArrResult;

      procedure XMLData(node: IXMLNode);
      procedure XMLREIData(node: IXMLNode);
      procedure XMLREI(handle: TComponent; path: widestring; const isXMLFile: boolean = false);
      procedure getTable(Table: string; const MaxChar: integer = -1); overload;
      procedure getTable(ID: integer; Table: string; const MaxChar: integer = -1; const clear: boolean = true); overload;
      procedure XMLManager(handle: Tcomponent; xmlFile: string; const keys: TStrings = nil; const save: boolean = false);

      constructor Create;
      destructor Destroy; override;

      procedure clearData;
      procedure clearResult;
  end;

const
  BitAddr : array [0..6] of string = ('3','4','7','8','9','5','6');
  BitMem  : array [0..6] of integer = (1,4,11,2,12,5,6);

implementation

uses HelperGeneral, UMemoryHelper;

constructor TXMLDataStore.Create;
begin
  TextObj:= TObjectArray.Create;

  NoChar:= 0;
  UnixID:= 0;

  clearResult;
  clearData;
end;

destructor TXMLDataStore.Destroy;
begin
  clearResult;
  clearData;
  TextObj.Free;
end;

procedure TXMLDataStore.clearData;
var
  i, ii, iii: integer;
begin
  if length(ArrChar) > 0 then
  begin
    for i:= 0 to length(ArrChar)-1 do
    begin
      for ii:= 0 to length(ArrChar[i].Data)-1 do
      begin
        for iii:= 0 to length(ArrChar[i].Data[ii].Codes)-1 do
          SetLength(ArrChar[i].Data[ii].Codes[iii].Offset,0);
        SetLength(ArrChar[i].Data[ii].Codes,0);
      end;
      setlength(ArrChar[i].Data,0);
    end;
    setLength(ArrChar,0);
  end;
end;

procedure TXMLDataStore.newCharacter;
var
  i, before: integer;
begin
  before:=length(ArrChar);

  setlength(ArrChar,NoChar);

  if NoChar>before then
  for i:=before to NoChar-1 do
    zeromemory(@ArrChar[i],sizeof(ArrChar[i]));
end;

procedure TXMLDataStore.parseXML(node: IXMLNode);
var
  recNode: IXMLNode;
  recAttr: IXMLNodeList;
  i, ii, id2, VarType: integer;
  isMulti, isFieldID: boolean;
  tableName: string;

  strAddr, strOffset: TStrings;
  count: dword;
  strAddr2: string;
begin
  tableName:= node.NodeName;
  recNode:= node.ChildNodes.First;

  while (recNode <> nil) do
  begin
    ID2:= -1;
    isMulti:= false;
    isFieldID:= false;
    recAttr:= recNode.AttributeNodes;

    for i:= 0 to (recAttr.Count-1) do
    if (recAttr.Nodes[i].NodeName = 'Fid') then
    begin
      NoChar:= recAttr.Nodes[i].NodeValue+1;
      if (NoChar > length(ArrChar)) then
        newCharacter;
      ArrChar[NoChar-1].ID:= recAttr.Nodes[i].NodeValue;
    end else
    if (recAttr.Nodes[i].NodeName = 'Fid2') then
    begin
      id2:= recAttr.Nodes[i].NodeValue;
      isMulti:= true;
    end else
    if not(recAttr.Nodes[i].NodeName = 'Fna') then
    begin
      // set table name
      NoData:= length(ArrChar[NoChar-1].Data);
      if (NoData=0) OR (ArrChar[NoChar-1].Data[NoData-1].Name <> tableName) then
      begin
        setLength(ArrChar[NoChar-1].Data, NoData+1);
        NoData:= length(ArrChar[NoChar-1].Data);
        ArrChar[NoChar-1].Data[NoData-1].Name:= tableName;
      end;

      NoCodes:= length(ArrChar[NoChar-1].Data[NoData-1].Codes);
      setLength(ArrChar[NoChar-1].Data[NoData-1].Codes, NoCodes+1);
      NoCodes:= length(ArrChar[NoChar-1].Data[NoData-1].Codes);

      ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].CodeID:= UnixID;
      ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Name:= copy(recAttr.Nodes[i].NodeName,2,length(recAttr.Nodes[i].NodeName)-1);
      ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Code:= recAttr.Nodes[i].NodeValue;

      ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].ID2:= -1;
      if isMulti then
        ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].ID2:= ID2
      else if isFieldID OR ((recAttr.Nodes[i].NodeName = 'F0') OR (recAttr.Nodes[i].NodeName = 'F1')) then
      begin
        ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].ID2:= strtoint(ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Name);
        isFieldID:= true;
      end;

      ArrChar[NoChar-1].Data[NoData-1].Total:= NoCodes;
      inc(UnixID);

      // set address
      setlength(ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Offset,0);
      strAddr:= Explode('+',recAttr.Nodes[i].NodeValue);
      strAddr2:= copy(strAddr.Strings[0],2,length(strAddr.Strings[0])-1);
      VarType:= bitmem[ArrayIndexContainText(strAddr.Strings[0][1],bitaddr,true)];
      ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].VarType:= VarType;

      if (VarType = 11) then ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Length:= 104;

      ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].OffStr:= strAddr.Strings[1];
      strOffset:= Explode('|',strAddr.Strings[1]);

      setlength(ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Offset, strOffset.Count);
      for ii:= 0 to strOffset.count-1 do
        val('$'+strOffset.Strings[ii],ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Offset[ii],count);

      val(ConvertHexStrToRealStr(strAddr2),ArrChar[NoChar-1].Data[NoData-1].Codes[NoCodes-1].Address,count);
    end;

    recNode:= recNode.NextSibling;
  end;
end;

procedure TXMLDataStore.XMLData(node: IXMLNode);
var
  childs, child: IXMLNode;
begin
  childs:= node.ChildNodes.FindNode('DataStore');
  if childs <> nil then
  begin
    child:= childs.ChildNodes.first;
    while child <> nil do
    begin
      parseXml(child);
      child:= child.NextSibling;
    end;
  end;

  MaxChar:= length(ArrChar);
end;

procedure TXMLDataStore.clearResult;
var
  i: integer;
begin
  if length(Data) > 0 then
  begin
    for i:= 0 to length(data)-1 do
      setlength(data[i].Offset,0);
    setLength(Data,0);
  end;
end;

procedure TXMLDataStore.getTable(Table: string; const MaxChar: integer = -1);
var
  i, limitChar: integer;
begin
  clearResult;
  limitChar:= length(ArrChar)-1;
  if (MaxChar > 0) then limitChar:= MaxChar;
  for i:= 0 to limitChar do
    getTable(i,Table,MaxChar,false);
end;

procedure TXMLDataStore.getTable(ID: integer; Table: string; const MaxChar: integer = -1; const clear: boolean = true);
var
  i, ii, iii, NewDataID: integer;
begin
  if clear then clearResult;

  for i:= 0 to length(ArrChar[ID].Data)-1 do
  for ii:= 0 to length(ArrChar[ID].Data[i].Codes)-1 do
    if (ArrChar[ID].Data[i].Name = Table) then
    begin
      if (MaxChar > -1) AND (ArrChar[ID].Data[i].Codes[ii].ID2 = MaxChar+1) then
        break;

      NewDataID:= length(Data);
      setLength(Data, NewDataID+1);

      Data[NewDataID].ID      := ArrChar[ID].ID;
      Data[NewDataID].ID2     := ArrChar[ID].Data[i].Codes[ii].ID2;
      Data[NewDataID].Table   := ArrChar[ID].Data[i].Name;
      Data[NewDataID].Total   := ArrChar[ID].Data[i].Total;
      
      Data[NewDataID].CodeID  := ArrChar[ID].Data[i].Codes[ii].CodeID;
      Data[NewDataID].Name    := ArrChar[ID].Data[i].Codes[ii].Name;
      Data[NewDataID].OffStr  := ArrChar[ID].Data[i].Codes[ii].OffStr;
      Data[NewDataID].Address := ArrChar[ID].Data[i].Codes[ii].Address;
      Data[NewDataID].VarType := ArrChar[ID].Data[i].Codes[ii].VarType;
      Data[NewDataID].Length  := ArrChar[ID].Data[i].Codes[ii].Length;

      setlength(Data[NewDataID].Offset,length(ArrChar[ID].Data[i].Codes[ii].Offset));
      for iii:= 0 to length(ArrChar[ID].Data[i].Codes[ii].Offset)-1 do
        Data[NewDataID].Offset[iii] := ArrChar[ID].Data[i].Codes[ii].Offset[iii];

    end;
end;

procedure TXMLDataStore.reiXML(node: IXMLNode);
var
  enumRec: IXMLNode;
  enumName, key, val: string;
begin
  enumName:= node.Attributes['key'];
  enumRec := node.ChildNodes.First;
  while (enumRec <> nil) do
  begin
      key:= enumRec.Attributes['key'];
      if (strtoint(key)<10) then key:= '0'+key;
      val:= enumRec.Attributes['value'];
      TextObj.Data[enumName,key]:= val;
      enumRec:= enumRec.NextSibling;
  end;
end;

procedure TXMLDataStore.XMLREIData(node: IXMLNode);
var
  childs, child: IXMLNode;
begin
  childs:= node.ChildNodes.FindNode('enumerables');
  if childs <> nil then
  begin
    child:= childs.ChildNodes.first;
    while child <> nil do
    begin
      reiXml(child);
      child:= child.NextSibling;
    end;
  end;
end;

procedure TXMLDataStore.XMLREI(handle: TComponent; path: widestring; const isXMLFile: boolean = false);
var
  XMLDocs: TXMLDocument;
  lstItem: TStringList;
  i: integer;
begin
  XMLDocs:= TXMLDocument.Create(handle);

  if not(isXMLFile) then
  begin
    lstItem:= TStringList.Create;
    FileSearch(path,'.xml', lstItem);
    if (lstItem.Count > 0) then
    for i:= 0 to lstItem.Count-1 do
    begin
      XMLDocs.LoadFromFile(lstItem.Strings[i]);
      XMLREIData(XMLDocs.DocumentElement);
    end;
  end else
  begin
    XMLDocs.LoadFromFile(path);
    XMLREIData(XMLDocs.DocumentElement);
  end;
end;

procedure TXMLDataStore.XMLManager(handle: Tcomponent; xmlFile: string; const keys: TStrings = nil; const save: boolean = false);
var
  XMLDocs: TXMLDocument;
  childs, child, items: IXMLNode;
  i: integer;
begin
  XMLDocs:= TXMLDocument.Create(handle);

  if save then
  begin
    XMLDocs.Active:= True;
    XMLDocs.Encoding:= 'utf-8';
    XMLDocs.Options:=[doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doAutoPrefix,doNamespaceDecl];

    childs:= XMLDocs.AddChild('trainer');
    childs.Attributes['build']:= TextObj.Items['version'];
    childs.Attributes['game']:= 'Arificial Academy 2';

    child:= childs.AddChild('records');

    for i:= 0 to keys.Count-1 do
    begin
      items:= child.AddChild('record');
      items.Attributes['key']:= keys.strings[i];
      items.NodeValue:= TextObj.Items[keys.strings[i]];
    end;

    XMLDocs.SaveToFile(xmlFile);
  end else
  if FileExists(xmlFile) then
  begin
    XMLDocs.LoadFromFile(xmlFile);

    childs:= XMLDocs.DocumentElement.ChildNodes.FindNode('records');
    if childs <> nil then
    begin
      child:= childs.ChildNodes.first;
      while child <> nil do
      begin
        if child.HasAttribute('key') AND not(child.NodeValue=null) then
          TextObj.Items[child.Attributes['key']]:= child.NodeValue;
        child:= child.NextSibling;     
      end;
    end;
  end;

end;

end.
