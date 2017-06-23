unit UObjectArray;

interface

uses
  Windows, Messages, Dialogs, Classes, StdCtrls, SysUtils, StrUtils, ComCtrls, Controls, CommCtrl,
  JvJCLUtils, JvComCtrls;

type
  PAItem = ^TAItem;
  TAItem = record
    FKey, FValue: string;
    FObject: TStrings;
  end;

  PAItemList = ^TAItemList;
  TAItemList = array [0..100] of TAItem;

  TObjectArray = class
    protected
      FItems: PAItemList;
      FIndex, FCapacity, FCount: integer;
      IKey, IValue: string;
      IObject: TStrings;
      procedure Grow;
      procedure SetCapacity(NewCapacity: Integer);
    private
      function remove(index: integer): boolean;
      procedure setData(index: integer; value: string);
      function getData(index: integer): string;
      function delData(key: string): boolean;
      procedure setItems(key, value: string);
      function getItems(key: string): string;
      procedure setObject(key1,key2: string; value: string);
      function getObject(key1,key2: string): string;
      procedure newObjects(key: string; const value: TStrings = nil);
      function getObjects(key: string): TStrings;
      function removeList(key1, key2: string): boolean;
    public
      No: integer;
      function Find(const value: string; var Index: Integer; const byValue: boolean = false): Boolean;
      function Contain(const key: string): boolean;

      function getKeys: TStrings;

      property Key: string index 1 read getData write setData;
      property Value: string index 2 read getData write setData;
      property Data[key1,key2: string]: string read getObject write setObject;
      property Strings[key: string]: TStrings read getObjects;// write newObjects;
      property DeleteList[key1, key2: string]: boolean read removeList;

      property Items[key: string]: string read getItems write setItems; default;
      property Delete[key: string]: boolean read delData;
      
      procedure Clear;
      procedure New;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

constructor TObjectArray.Create;
begin
  IKey:= '';
  IValue:= '';
  IObject:= TStringList.Create;
end;

destructor TObjectArray.Destroy;
begin
  IObject.Free;
  Clear;
end;

procedure TObjectArray.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4 else
    if FCapacity > 8 then Delta := 16 else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

procedure TObjectArray.SetCapacity(NewCapacity: Integer);
begin
  ReallocMem(FItems, NewCapacity * SizeOf(TAItem));
  FCapacity := NewCapacity;
end;

procedure TObjectArray.New;
begin
  if FCount = FCapacity then Grow;

  if FIndex < FCount then
    System.Move(FItems^[FIndex], FItems^[FIndex + 1],
      (FCount - FIndex) * SizeOf(TAItem));

  with FItems^[FIndex] do
  begin
    Pointer(FKey) := nil;
    Pointer(FValue) := nil;
    FKey := IKey;
    FValue := IValue;
    FObject:= TStringList.Create;
    if IObject.Count > 0 then
      FObject.AddStrings(IObject);
    IObject.Clear;
    IKey:= '';
    IValue:= '';
  end;
  inc(FCount);
  inc(FIndex);
end;

function TObjectArray.remove(index: integer): boolean;
begin
  Result:= true;
  if (Index < 0) or (Index >= FCount) then
  begin
    showmessage('Error index not found');
    Result:= false;
    exit;
  end;

  Finalize(FItems^[Index]);
  Dec(FCount);
  if Index < FCount then
    System.Move(FItems^[Index + 1], FItems^[Index],
      (FCount - Index) * SizeOf(TAItem));
  Dec(FIndex);
end;

procedure TObjectArray.Clear;
begin
  if FCount <> 0 then
  begin
    Finalize(FItems^[0], FCount);
    FCount := 0;
    FIndex:= 0;
    SetCapacity(0);
  end;
end;

{ ==================================================================================================== }

procedure TObjectArray.setData(index: integer; value: string);
begin
  case index of
    1: IKey:= value;
    2: IValue:= value;
  end;

  if ((IKey <> '') AND (IValue <> '')) then
    New;
end;

function TObjectArray.getData(index: integer): string;
begin
  case index of
    1: Result:= FItems^[No].FKey;
    2: Result:= FItems^[No].FValue;
  end;
end;

procedure TObjectArray.setItems(key, value: string);
begin
  if (Find(key,No)) then
  with FItems^[No] do
  begin
    Pointer(FValue):= nil;
    FItems^[No].FValue:= value;
  end else
  begin
    IKey:= key;
    IValue:= value;
    New;
  end;
end;

function TObjectArray.getItems(key: string): string;
begin
  Result:= '';
  if (Find(key,No)) then
    Result:= FItems^[No].FValue;
end;

procedure TObjectArray.setObject(key1, key2: string; value: string);
begin
  if (Find(key1,No)) then
  with FItems^[No] do
  begin
    FItems^[No].FObject.Values[key2]:= value;
  end else
  begin
    IKey:= key1;
    IObject.Values[key2]:= value;
    New;
  end;
end;

function TObjectArray.getObject(key1, key2: string): string;
begin
  Result:= '';
  if (Find(key1,No)) then
    Result:= FItems^[No].FObject.Values[key2];
end;

procedure TObjectArray.newObjects(key: string; const value: TStrings = nil);
begin
  if Not(Find(key,No)) then
  begin
    IKey:= key;
    New;
  end;
end;

function TObjectArray.getObjects(key: string): TStrings;
begin
  Result:= nil;
  if (Find(key,No)) then
    Result:= FItems^[No].FObject
  else begin
    newObjects(key);
    Result:= getObjects(key);
  end;
end;

function TObjectArray.removeList(key1, key2: string): boolean;
var
  idx: integer;
begin
  Result:= false;
  if (Find(key1,No)) then
  begin
    idx:= FItems^[No].FObject.IndexOfName(key2);
    FItems^[No].FObject.Delete(idx);
    Result:= true;
  end;
end;

function TObjectArray.delData(key: string): boolean;
begin
  Result:= false;
  if Find(key,No) then
    Result:= remove(No);
end;

function TObjectArray.getKeys: TStrings;
var
  I: Integer;
begin
  Result:= TStringList.Create;
  for I:= 0 to (FCount - 1) do
    Result.Add(FItems^[I].FKey);
end;

function TObjectArray.Find(const value: string; var Index: Integer; const byValue: boolean = false): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := -1;
  H := FCount - 1;
  for I:= 0 to H do
  begin
    if byValue then C := AnsiCompareText(FItems^[I].FValue, value)
    else C:= AnsiCompareText(FItems^[I].FKey, value);
    if (C = 0) then
    begin
      L:= I;
      Result:= true;
      break;
    end;
  end;
  index:= L;
end;

function TObjectArray.Contain(const key: string): boolean;
begin
  Result:= Find(key,no);
end;

end.
 