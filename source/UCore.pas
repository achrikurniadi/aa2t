unit UCore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, math,
  JvJCLUtils, JvTimer, JvSpin, JvLabel, JvImage, JvPanel, JvComCtrls, JvCheckBox, JvSpeedButton,
  Registry,
  UData, HelperGeneral, UMemoryHelper, UXMLData, pngimage, Graphics;

type
  TSavedData = (FilePlanAction,FilePasteBin);
  TActType = (ActStatus,ActAction,ActTarget,ActRefer,ActResponse,ActInteract,ActNpcInteract,ActLocation,ActIntWait,ActIntTime,
    ActFired,ActVirtue,ActSingleMind,ActLucky);
  TActionState = (IsNA,IsIdle,IsGoingInteract,IsDecide,IsChat,IsDoSingleAct,IsStalking,IsWalking,IsFollow,IsDoSex);
  TAppState = (IsAdd,IsDelete,IsClear,IsClearAll,IsPause,IsAppControl,IsRefresh,IsValidate,IsNavControl,IsCancel,IsLoad,IsSave,
    IsCopy,IsPaste,IsIgnored,IsCheck);

  TVoiceConfig = record
    VoiceID : TJvCheckBox;
    VoiceVal: TJvTrackBar;
  end;
  
  TGameInfo = record
    isRunning : boolean;
    ExeName   : string;
    ExePath   : string;
    Version   : string;
  end;

  TForceAction = record
    Action     : integer;
    Active     : boolean;
    ForceToNPC : boolean;
  end;

  TRandomAction = record
    setChoice  : boolean;
    isChoice   : boolean;
    SetMod     : boolean;
    ValMod     : integer;
    Active     : boolean;
    Action     : integer;
    toSeat     : integer;
    toCharID   : integer;
    toAddress  : string;
    trigger    : boolean;
    killerMode : boolean;
    killerDay  : integer;
    isLucky    : boolean;
  end;

  TActionAddress = record
    status     : dword;
    action     : dword;
    target     : dword;
    targetRef  : dword;
    response   : dword;
    isInteract : dword;
    npcInteract: dword;
    location   : dword;
    IntWait    : dword;
    IntTime    : dword;
    fireAction : dword;

    virtue     : dword;
    singleMind : dword;
    lucky      : dword;
  end;

  TCharAction = record
    UnixID   : string;
    oldUnixID: string;
    onState  : TActionState;
    shortMsg : string;
    EventLogs: TStrings;
    syncEvent: TJvTimer;

    NPCAddress: string;
    Status   : int64;
    Action   : int64;
    oldAction: int64;
    Response : int64;
    Location : integer;
    OldLocation : integer;
    ToSeat       : integer;
    ToSeatAddr   : string;
    ToSeatRef    : integer;
    ToSeatRefAddr: string;
    PCInteract   : integer;
    NPCInteract  : integer;

    cancelType   : string;
    cancelIsRun  : boolean;
  end;

  TListAction = record
    Active   : boolean;
    Seat     : integer;
    CharID   : integer;
    Action   : integer;
    Triggered: boolean;
  end;

  TPlanAction = record
    No: Integer;
    Started: boolean;
    Looping: boolean;
    Shuffle: boolean;
    Forced : boolean;
    Quicked: boolean;

    runOnAction: boolean;
    runIndex: integer;
    runTargetSeat: integer;
    runTargetAction: integer;
    runTargetAddress: string;

    lastselected: Integer;
    FirstShiftSelected: Integer;
    Selected  : Array of Boolean;
    ListAction: array of TListAction;
    syncAction: TJvTimer;

    tempPlanID: array of integer;
    TotActive : integer;
    indexRunID: array of integer;
    isDoubleCheck: boolean;
  end;

  TClassView = record
    seatBox  : TJvPanel;
    seatNum  : TJvLabel;

    location : TJvImage;

    firstName: TJvLabel;
    lastName : TJvLabel;
    clubName : TJvLabel;
    feelings : TJvLabel;
    personality : TJvLabel;
    pThumb   : TJvPanel;
    thumb    : TJvImage;
    potrait  : TJvImage;
    isLover  : TJvImage;

    toNPC    : TJvImage;
    toNPCRef : TJvImage;

    isStatus : TJvImage;
    isRespon : TJvImage; 

    isLocation: TJvLabel;
    isAction : TJvLabel;

    isIgnore : TJvImage;
  end;

  TClassSeat = record
    isEmpty  : boolean;
    seatNumber: integer;
    charID   : integer;

    charName : string;
    listName : string;

    doStatus : boolean;
    doRespon : boolean;

    views    : TClassView;

    actions   : TCharAction;
    actAddress: TActionAddress;

    planAction: TPlanAction;

    forceAction: TForceAction;
    randomAction: TRandomAction;

    ignoredSeat: TStrings;
    limitActions: TStrings;
  end;

  TIgnoreNPC = record
    seatNumber: integer;
    seatBox   : TJvSpeedButton;
  end;

  TPasteData = record
    SeatNo      : integer;
    Thumbnail   : TJVImage;
    Description : string;
    ValueData : array of string;
  end;

  TPasteBin = record
    No: Integer;
    lastSelected: integer;
    
    Selected  : array of Boolean;
    ListData  : array of TPasteData;
    FieldData : array of string;
    MaxField  : integer;
    listUnixID: array of string;
    createField: boolean;
  end;

  TCore = class
    GameInfo: TGameInfo;
    GameData: TData;
    XMLData : TXMLData;
    ClassSeat: array of TClassSeat;
    IgnoreSeat: array of TIgnoreNPC;
    PlanDropBox: TPlanAction;
    PasteBin: TPasteBin;
    voiceConfig: array of TVoiceConfig;
    private
      gameFiles: TStringList;

      freezeCounter: integer;

      function getAA2PathReg: string;

    public
      initGameFired, PlanActionCreated: boolean;
      maxChar,selectedSeat, selectedChar, playedChar, playedSeat, setPlayedSeat: integer;
      
      tempSeatID, SeatID: array of integer;   // for current seat list

      NPCPlayAddress: array of string;
      NPCTargetAddress: array of string;  // for current npc target address
      NPCRefTargetAddress: array of string;  // for current npc reference target address

      constructor Create;
      destructor Destroy; override;

      procedure clearAll;
      procedure clearSeatData;

      function initGame: boolean;
      function findGame: boolean;

      procedure createIgnoreSeat;
      procedure createSeat;
      procedure fillSeatID;
      procedure initClassData;
      procedure showClassSeat(const forceVisible: boolean = false);
      procedure refreshClassData;

      function countSeat: integer;
      function getCharID(idSeat: integer): integer;
      function getSeatID(idChar: integer): integer;
      procedure getThumbnail(ID: integer; const isPotrait: boolean = false; const saveTo: string = '');

      procedure setFreezeData(types, field, codes, value: string; freezeState: boolean; const seatNo: integer = -1; const toSeat: integer = -1);
      procedure runtimeFreezeData;
      function freezeCheck(i: integer; const numTry: integer = 3): boolean;

      // action
      procedure setActionAddress;
      function getCharAction(seatID: integer; types: TActType; const isNumber: boolean = false): string;
      function getNPCState(seatID: integer): TActionState;

      // plan action
      procedure planActionMem(const seatNumber: integer = -1);

      procedure pasteBinMem;
      procedure copyBinData(charID: integer);
      procedure removeBinData;
      procedure pasteBinData(charID: integer; pbBody,pbOutfit,pbBase: boolean);
      procedure clearPasteBin;

      procedure manageSavedItems(state: TSavedData; nodes: IXMLNode);
      function manageSavedData(state: TSavedData; fileName: string; const doSave: boolean = true): boolean;

      function parseStrBinData(encode: boolean; const idx: integer = -1; const value: string = ''): string;
      function parseStrFreezeData(encode: boolean; const idx: integer = -1; const value: string = ''): string;
      procedure clearFreezeData;
  end;

const
  seatIndex: array [0..24] of integer = (0,1,2,3,4,5,6,7,8,9,24,10,11,12,13,14,15,16,17,18,19,20,21,22,23);
  GameState: array [0..22] of string = (
  '0','1','2','Illusion Into','Title Screen','Char Outfit','6','7','Load save game','Loading screen ...',
  'Config / Maps / NewGame','Home Screen','12','Class Roaster','Profile Student','Status Chemistry','Ranking Screen','Add Student',
  'Club Name','Select / Change Club','20','21','Choice Yes / No'
  );

implementation

uses UMain, UMemory, JvStringHolder;

constructor TCore.Create;
begin
  GameData:= TData.Create;
  XMLData := TXMLData.Create;

  selectedSeat:= -1;
  selectedChar:= -1;
  PasteBin.MaxField:= 342;
end;

destructor TCore.Destroy;
begin
  clearAll;
  clearPasteBin;
  
  GameData.Free;
  XMLData.Free;
end;

procedure TCore.clearPasteBin;
begin
  // pasteBin
  if (length(pasteBin.ListData)>0) then
  begin
    PasteBin.No:=0;
    pasteBinMem;
  end;
end;

procedure TCore.ClearAll;
var i: integer;
begin
  setlength(NPCPlayAddress,0);
  setlength(NPCTargetAddress,0);
  setlength(NPCRefTargetAddress,0);
  SetLength(PlanDropBox.ListAction,0);
  setlength(SeatID,0);
  // class seat
  if (length(ClassSeat)>0) then
  begin
    for i:= 0 to (length(ClassSeat)-1) do
    begin
      if not(ClassSeat[i].views.Location = nil) then ClassSeat[i].views.Location.Free;
      if not(ClassSeat[i].views.firstName = nil) then ClassSeat[i].views.firstName.Free;
      if not(ClassSeat[i].views.lastName = nil) then ClassSeat[i].views.lastName.Free;
      if not(ClassSeat[i].views.clubName = nil) then ClassSeat[i].views.clubName.Free;
      if not(ClassSeat[i].views.feelings = nil) then ClassSeat[i].views.feelings.Free;
      if not(ClassSeat[i].views.personality = nil) then ClassSeat[i].views.personality.Free;
      if not(ClassSeat[i].views.thumb = nil) then ClassSeat[i].views.thumb.Free;
      if not(ClassSeat[i].views.isLover = nil) then ClassSeat[i].views.isLover.Free;
      if not(ClassSeat[i].views.toNPC = nil) then ClassSeat[i].views.toNPC.Free;
      if not(ClassSeat[i].views.toNPCRef = nil) then ClassSeat[i].views.toNPCRef.Free;
      if not(ClassSeat[i].views.isStatus = nil) then ClassSeat[i].views.isStatus.Free;
      if not(ClassSeat[i].views.isRespon = nil) then ClassSeat[i].views.isRespon.Free;
      if not(ClassSeat[i].views.isLocation = nil) then ClassSeat[i].views.isLocation.Free;
      if not(ClassSeat[i].views.isAction = nil) then ClassSeat[i].views.isAction.Free;
      if not(ClassSeat[i].views.seatNum = nil) then ClassSeat[i].views.seatNum.Free;

      if not(ClassSeat[i].views.pThumb = nil) then ClassSeat[i].views.pThumb.Free;
      if not(ClassSeat[i].views.seatBox = nil) then ClassSeat[i].views.seatBox.Free;
      {
      if not(ClassSeat[i].isIgnore = nil) then ClassSeat[i].isIgnore.Free;
      if not(ClassSeat[i].ignoredSeat = nil) then ClassSeat[i].ignoredSeat.free;
       }
      // action
      if not(ClassSeat[i].actions.EventLogs = nil) then ClassSeat[i].actions.EventLogs.Free;
      if not(ClassSeat[i].actions.syncEvent = nil) then ClassSeat[i].actions.syncEvent.Free;

      // plan action
      if (length(ClassSeat[i].planAction.ListAction)>0) then
      begin
        ClassSeat[i].planAction.No:=0;
        planActionMem(i);
      end;
      if not(ClassSeat[i].planAction.syncAction=nil) then ClassSeat[i].planAction.syncAction.Free;
    end;
    SetLength(ClassSeat,0);
  end;

  // ignore seat
  if (length(IgnoreSeat)>0) then
  begin
    for i:= 0 to (length(IgnoreSeat)-1) do
      if not(IgnoreSeat[i].seatBox = nil) then IgnoreSeat[i].seatBox.Free;
    SetLength(IgnoreSeat,0);
  end;

  clearFreezeData;
end;

procedure TCore.clearFreezeData;
var i: integer;
begin
  if (length(GameData.FreezeData)>0) then
  if GameData.CharCode.Delete['FreezeData'] then
  begin
    for i:= 0 to length(GameData.FreezeData)-1 do
      setlength(GameData.FreezeData[i].codes.offset,0);
    setlength(GameData.FreezeData,0);
  end;
end;

procedure TCore.clearSeatData;
var i: integer;
begin
  for i:= 0 to 24 do
  begin
    // event
    if not(ClassSeat[i].actions.EventLogs=nil)then
      ClassSeat[i].actions.EventLogs.Clear;
    // ignore
    if not(ClassSeat[i].ignoredSeat=nil)then
      ClassSeat[i].ignoredSeat.Clear;
    // plan
    ClassSeat[i].planAction.No:= 0;
    SetLength(ClassSeat[i].planAction.Selected,0);
    SetLength(ClassSeat[i].planAction.ListAction,0);
    ClassSeat[i].planAction.Started:= false;
    ClassSeat[i].planAction.runOnAction:= false;
    ClassSeat[i].planAction.runIndex:= -1;
    ClassSeat[i].planAction.runTargetAddress:= '0';
    // forced act
    ClassSeat[i].forceAction.Active:= false;
    ClassSeat[i].forceAction.Action:= -1;
    ClassSeat[i].forceAction.ForceToNPC:= false;
    // limit act
    if not(ClassSeat[i].limitActions=nil)then
      ClassSeat[i].limitActions.Clear;
  end;

  clearFreezeData;
end;

function TCore.getAA2PathReg: string;
var
  R: TRegistry;
begin
  Result:= '';
  R:= TRegistry.Create;
  Try
    R.RootKey:= HKEY_CURRENT_USER;
    If R.OpenKey('SOFTWARE\illusion\AA2Play',False) then
    begin
      if Not (R.ReadString('INSTALLDIR') = '') then
        Result:= R.ReadString('INSTALLDIR');
      R.CloseKey;
    end;
  Finally
    R.Free;
  end;
end;

function TCore.initGame: boolean;
var
  pathGame: string;
begin
  Result:= false;

  // find game registry
  pathGame:= getAA2PathReg;
  if (pathGame='') OR not(DirectoryExists(pathGame)) then exit;

  // fill game file
  gameFiles:= TStringList.Create;
  FileSearch(pathGame,'.exe',gameFiles);
  if (gameFiles.Count>0) then Result:= true;
  initGameFired:= Result;
end;

function TCore.findGame: boolean;
const
  gameStateAddr: dword = $0038F6B0;
var
  i: integer;
  aa2off: string;
begin
  Result:= false;
  // first check game exe in path game
  if not(GameInfo.isRunning) AND (gameFiles.Count>0) then
  begin
    for i:= 0 to gameFiles.Count-1 do
    if GameData.Process.GetProcess(ExtractFileName(gameFiles.Strings[i])) then
    begin
      aa2off:= GameData.Process.GetValues(gameStateAddr+GameData.Process.PBaseAddress,4);
      if not(aa2off='0') AND not(aa2off[1]='?') then
      begin
        GameInfo.isRunning:= true;
        GameInfo.ExeName  := ExtractFileName(gameFiles.Strings[i]);
        GameInfo.ExePath  := ExtractFilePath(gameFiles.Strings[i]);
        GameInfo.Version  := getFileVersion(gameFiles.Strings[i]);
        Result:= true;
        break;
      end;
    end;
  end else
  // routine check current game process
  if GameInfo.isRunning then   //GameData.Process.GetProcess(GameInfo.ExeName)
  begin
    aa2off:= GameData.Process.GetValues(gameStateAddr+GameData.Process.PBaseAddress,4);
    if (aa2off='0') OR (aa2off[1]='?') then
    begin
      GameInfo.isRunning:= false;
      Result:= findGame;
    end else Result:= true;
  end;
end;

procedure TCore.createIgnoreSeat;
var i, seatNumber, ptop, pleft: integer;
begin
  SetLength(IgnoreSeat,25);
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    IgnoreSeat[i].seatNumber:= seatNumber;

    if (i=0) then pleft:= MainForm.pIgnoredNPC.Width - MainForm.defIgnoreNPC.Width - 16;
    if (i mod 5=0) then
    begin
      ptop:= 16;
      pleft:= pleft - MainForm.defIgnoreNPC.Width - 16;
    end else
      ptop:= ptop + MainForm.defIgnoreNPC.Height;

    IgnoreSeat[seatNumber].seatBox:= TJvSpeedButton.Create(MainForm.pIgnoredNPC);
    with IgnoreSeat[seatNumber].seatBox do
    begin
      top:= ptop;
      left:= pleft;
      width:= MainForm.defIgnoreNPC.Width;
      Height:= MainForm.defIgnoreNPC.Height;
      Cursor:= MainForm.defIgnoreNPC.Cursor;
      name:= 'ignoreSeat_'+inttostr(seatNumber);
      parent:= MainForm.pIgnoredNPC;
      GroupIndex:=seatNumber+1;
      AllowAllUp:= true;
      Flat:= true;
      //Transparent:= true;
      Tag:= seatNumber;
      OnClick:= MainForm.ignoreNPCClick;
      Alignment:= taCenter;
      Caption:= inttostr(seatNumber);
      ParentFont:= false;
      Font.Size:= 12;
      Font.Color:= $006C6C6C;//$000D0D0D;
      Font.Name:= 'Arial'; //'Times New Roman';
      Alignment:= taCenter;
      Enabled:= false;
    end;
  end;
end;

procedure TCore.createSeat;
var i, seatNumber, ptop, pleft: integer;
begin
  SetLength(ClassSeat,25);
  for i:= 0 to 24 do
  begin
    ClassSeat[i].isEmpty:= true;
    ClassSeat[i].charID:= -1;

    seatNumber:= seatIndex[i];
    ClassSeat[i].seatNumber:= seatNumber;

    if (i=0) then pleft:= MainForm.pClass.Width;
    if (i mod 5=0) then
    begin
      ptop:= 10;
      pleft:= pleft - MainForm.defSeat.Width - 7;
    end else
      ptop:= (ptop+7) + 89;

    core.ClassSeat[seatNumber].views.seatBox:= TJvPanel.CreateParented(MainForm.pClass.Handle);
    with core.ClassSeat[seatNumber].views.seatBox do
    begin
      top:= ptop;
      left:= pleft;
      width:= MainForm.defSeat.Width;
      Height:= MainForm.defSeat.Height;
      Cursor:= MainForm.defSeat.Cursor;
      Caption:= inttostr(seatNumber);
      name:= 'seat_'+inttostr(seatNumber);
      parent:= MainForm.pClass;
      BorderWidth:= 2;
      Color:= MainForm.cdefBEmpty.Color; //$00C4C4C4;
      ParentFont:= false;
      Font.Size:= 24;
      Font.Color:= $006C6C6C;//$000D0D0D;
      Font.Name:= 'Arial'; //'Times New Roman';
      Alignment:= taCenter;
      FlatBorder:= true;
      FlatBorderColor:= MainForm.cdefOSelSeat.Color; //$004367A3;
      {HotTrack:= true;
      HotTrackOptions.Enabled:= true;
      HotTrackOptions.Color:= $00FFBFFF;
      HotTrackOptions.FrameVisible:= true;
      HotTrackOptions.FrameColor:= $0039588A; }
      Tag:= seatNumber;
      OnClick:= MainForm.selectedNPC;
      OnDblClick:= MainForm.selectedNPCDblClick;
      PopupMenu:= MainForm.pCharList;
      OnContextPopup:= MainForm.menuContextPopup;
      Enabled:= false;
    end;

    core.ClassSeat[seatNumber].views.location:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.location do
    begin
      //Align:= alClient;
      top:= MainForm.defLocThumb.Top;
      left:= MainForm.defLocThumb.Left;
      width:= MainForm.defLocThumb.Width;
      height:= MainForm.defLocThumb.Height;
      name:= 'seatLoca_'+inttostr(seatNumber);
      Center:= true;
      Proportional:= true;
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      ShowHint:= true;
      Hint:= 'Location';
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.seatNum:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.seatNum do
    begin
      AutoSize:= false;
      left:= MainForm.defSeatNo.Left;
      top := MainForm.defSeatNo.Top;
      Width := MainForm.defSeatNo.Width;
      Height := MainForm.defSeatNo.Height;
      Font.Size:= MainForm.defSeatNo.Font.Size;
      Font.Name:= MainForm.defSeatNo.Font.Name;
      Font.Style:= MainForm.defSeatNo.Font.Style;
      Font.Color:= MainForm.defSeatNo.Font.Color;
      Font.Pitch:= MainForm.defSeatNo.Font.Pitch;
      Font.Style:= MainForm.defSeatNo.Font.Style;
      Alignment:= MainForm.defSeatNo.Alignment;
      Caption:= inttostr(seatNumber);
      name:= 'seatNum_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.firstName:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.firstName do
    begin
      left:= MainForm.defFName.Left;
      top := MainForm.defFName.Top;
      Font.Size:= MainForm.defFName.Font.Size;
      Font.Name:= MainForm.defFName.Font.Name;
      Font.Style:= MainForm.defFName.Font.Style;
      Font.Color:= MainForm.defFName.Font.Color;
      Font.Pitch:= MainForm.defFName.Font.Pitch;
      Font.Style:= MainForm.defFName.Font.Style;
      Alignment:= MainForm.defFName.Alignment;
      Caption:= 'First Name';
      name:= 'seatFName_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.lastName:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.lastName do
    begin
      left:= MainForm.defLName.Left;
      top := MainForm.defLName.Top;
      Font.Size:= MainForm.defLName.Font.Size;
      Font.Name:= MainForm.defLName.Font.Name;
      Font.Style:= MainForm.defLName.Font.Style;
      Font.Color:= MainForm.defLName.Font.Color;
      Font.Pitch:= MainForm.defLName.Font.Pitch;
      Font.Style:= MainForm.defLName.Font.Style;
      Alignment:= MainForm.defLName.Alignment;
      Caption:= 'Last Name';
      name:= 'seatLName_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.pThumb:= TJvPanel.CreateParented(core.ClassSeat[seatNumber].views.seatBox.Handle);
    with core.ClassSeat[seatNumber].views.pThumb do
    begin
      left:= MainForm.defPThumb.Left;
      top := MainForm.defPThumb.Top;
      Width:= MainForm.defPThumb.Width;
      Height:= MainForm.defPThumb.Height;
      Caption:= inttostr(i);
      name:= 'seatPThumb_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      ParentFont:= false;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;
    
    core.ClassSeat[seatNumber].views.thumb:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.thumb do
    begin
      //Align:= alClient;
      top:= MainForm.defThumb.Top;
      left:= MainForm.defThumb.Left;
      width:= MainForm.defThumb.Width;
      height:= MainForm.defThumb.Height;
      name:= 'seatThumb_'+inttostr(seatNumber);
      Center:= true;
      Proportional:= true;
      Parent:= core.ClassSeat[seatNumber].views.pThumb;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.personality:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.personality do
    begin
      Align:= MainForm.defPersonal.Align;
      Alignment := MainForm.defPersonal.Alignment;
      AutoOpenURL:= false;
      Font.Size:= MainForm.defPersonal.Font.Size;
      Font.Name:= MainForm.defPersonal.Font.Name;
      Font.Style:= MainForm.defPersonal.Font.Style;
      Font.Color:= MainForm.defPersonal.Font.Color;
      Font.Pitch:= MainForm.defPersonal.Font.Pitch;
      Font.Style:= MainForm.defPersonal.Font.Style;
      Alignment:= MainForm.defPersonal.Alignment;
      Caption:= 'Personality';
      name:= 'seatPersonal_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.pThumb;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.isIgnore:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.isIgnore do
    begin
      top:= MainForm.defIgnore.Top;
      left:= MainForm.defIgnore.Left;
      Width:= MainForm.defIgnore.Width;
      Height:= MainForm.defIgnore.Height;
      name:= 'seatIgnore_'+inttostr(seatNumber);
      Hint:= 'Ignore this Character';
      ShowHint:= true;
      Picture:= MainForm.defIgnore.Picture;
      Parent:= core.ClassSeat[seatNumber].views.pThumb;//core.ClassSeat[seatNumber].views.seatBox;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.isLover:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.isLover do
    begin
      top:= MainForm.defLove.Top;
      left:= MainForm.defLove.Left;
      Width:= MainForm.defLove.Width;
      Height:= MainForm.defLove.Height;
      name:= 'seatLover_'+inttostr(seatNumber);
      Hint:= 'Your Lover';
      ShowHint:= true;
      Picture:= MainForm.defLove.Picture;
      Parent:= core.ClassSeat[seatNumber].views.pThumb;//core.ClassSeat[seatNumber].views.seatBox;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.clubName:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.clubName do
    begin
      Align:= MainForm.defClub.Align;
      Alignment := MainForm.defClub.Alignment;
      AutoOpenURL:= false;
      Font.Size:= MainForm.defClub.Font.Size;
      Font.Name:= MainForm.defClub.Font.Name;
      Font.Style:= MainForm.defClub.Font.Style;
      Font.Color:= MainForm.defClub.Font.Color;
      Font.Pitch:= MainForm.defClub.Font.Pitch;
      Font.Style:= MainForm.defClub.Font.Style;
      Alignment:= MainForm.defClub.Alignment;
      Caption:= 'Club';
      name:= 'seatClubN_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.pThumb;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    // this is useless till read data card available
    core.ClassSeat[seatNumber].views.potrait:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.potrait do
    begin
      Align:= alClient;
      name:= 'seatPotrait_'+inttostr(seatNumber);
      Center:= true;
      Proportional:= true;
      Parent:= core.ClassSeat[seatNumber].views.pThumb;
      ShowHint:= true;
      Hint:= 'Seat '+inttostr(seatNumber);
      Cursor:= MainForm.defSeat.Cursor;
      visible:= false;
    end;

    core.ClassSeat[seatNumber].views.toNPC:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.toNPC do
    begin
      top:= MainForm.defTo.Top;
      left:= MainForm.defTo.Left;
      Width:= MainForm.defTo.Width;
      Height:= MainForm.defTo.Height;
      Center:= true;
      Proportional:= true;
      name:= 'seatToNpc_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.pThumb;
      Cursor:= MainForm.defSeat.Cursor;
      ShowHint:= true;
      visible:= false;
    end;

    core.ClassSeat[seatNumber].views.isStatus:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.isStatus do
    begin
      top:= MainForm.defStatus.Top;
      left:= MainForm.defStatus.Left;
      Width:= MainForm.defStatus.Width;
      Height:= MainForm.defStatus.Height;
      Center:= true;
      Proportional:= true;
      name:= 'seatToMove_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.pThumb;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.isAction:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.isAction do
    begin
      left:= MainForm.defAction.Left;
      top := MainForm.defAction.Top;
      Font.Size:= MainForm.defAction.Font.Size;
      Font.Name:= MainForm.defAction.Font.Name;
      Font.Style:= MainForm.defAction.Font.Style;
      Font.Color:= MainForm.defAction.Font.Color;
      Font.Pitch:= MainForm.defAction.Font.Pitch;
      Font.Style:= MainForm.defAction.Font.Style;
      Alignment:= MainForm.defAction.Alignment;
      Caption:= 'Actions';
      name:= 'seatIsAct_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.isLocation:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.isLocation do
    begin
      left:= MainForm.defLocation.Left;
      top := MainForm.defLocation.Top;
      Font.Size:= MainForm.defLocation.Font.Size;
      Font.Name:= MainForm.defLocation.Font.Name;
      Font.Style:= MainForm.defLocation.Font.Style;
      Font.Color:= MainForm.defLocation.Font.Color;
      Font.Pitch:= MainForm.defLocation.Font.Pitch;
      Font.Style:= MainForm.defLocation.Font.Style;
      Alignment:= MainForm.defLocation.Alignment;
      Caption:= 'Location';
      name:= 'seatIsLoc_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.isRespon:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox); //TJvLabel.Create(core.ClassSeat[seatNumber].seatBox);
    with core.ClassSeat[seatNumber].views.isRespon do
    begin
      left:= MainForm.defRespon.Left;//-5;
      top := MainForm.defRespon.Top;
      Width:= MainForm.defRespon.Width;
      Height:= MainForm.defRespon.Height;
      Center:= true;
      Proportional:= true;
      Hint:= 'Action Response';
      ShowHint:= true;
      name:= 'seatIsRespon_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.feelings:= TJvLabel.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.feelings do
    begin
      AutoSize:= true;
      left:= MainForm.defFeels.Left;
      top := MainForm.defFeels.Top;
      Width := MainForm.defFeels.Width;
      Height := MainForm.defFeels.Height;
      Font.Size:= MainForm.defFeels.Font.Size;
      Font.Name:= MainForm.defFeels.Font.Name;
      Font.Style:= MainForm.defFeels.Font.Style;
      Font.Color:= MainForm.defFeels.Font.Color;
      Font.Pitch:= MainForm.defFeels.Font.Pitch;
      Font.Style:= MainForm.defFeels.Font.Style;
      Alignment:= MainForm.defFeels.Alignment;
      Caption:= 'Feelings';
      name:= 'seatfeelings_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      ShowHint:= true;
      ParentFont:= false;
      Transparent:= true;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;

    core.ClassSeat[seatNumber].views.toNPCRef:= TJvImage.Create(core.ClassSeat[seatNumber].views.seatBox);
    with core.ClassSeat[seatNumber].views.toNPCRef do
    begin
      top:= MainForm.defRef.Top;
      left:= MainForm.defRef.Left;
      Width:= MainForm.defRef.Width;
      Height:= MainForm.defRef.Height;
      Center:= true;
      Proportional:= true;
      Hint:= 'Action Reference to';
      ShowHint:= true;
      name:= 'seatToNpcRef_'+inttostr(seatNumber);
      Parent:= core.ClassSeat[seatNumber].views.seatBox;
      visible:= false;
      OnClick:= MainForm.selectedNPCW;
      OnDblClick:= MainForm.selectedNPCDblClickW;
      Cursor:= MainForm.defSeat.Cursor;
      Tag:= seatNumber;
    end;
  end;
end;

procedure TCore.getThumbnail(ID: integer; const isPotrait: boolean = false; const saveTo: string = '');
var
  png      : TPNGObject;
  stream   : TMemoryStream;
  thumbAddr, thumbSize, getByte: string;
  address: dword;
  vByte: byte;
  count,i : integer;
  isValid: boolean;
begin
  if isPotrait then
  begin
    thumbSize:= GameData.getCodes(1,'PotraitSize',ID,true);
    thumbAddr:= GameData.getCodes(1,'PotraitAddr',ID,true);
  end else
  begin
    thumbSize:= GameData.getCodes(1,'ThumbSize',ID,true);
    thumbAddr:= GameData.getCodes(1,'ThumbAddr',ID,true);
  end;

  val(ConvertHexStrToRealStr(dec2hex(strtoint64(thumbAddr),8)),address,count);

  // check valid address
  getByte:= GameData.Process.GetValues(address,2);
  if (count = 0) AND not(getByte[1]='?') then
  begin
    png:= TPNGObject.Create;
    try
      isValid:= true;
      stream:= TMemoryStream.Create;
      try
        for i:= 0 to strtoint(thumbSize)-1 do
        begin
          getByte:= GameData.Process.GetValues(address,2);
          if (getByte='') OR (getByte[1]='?') then
          begin
            isValid:= false;
            break;
          end;
          val(ConvertHexStrToRealStr(dec2hex(strtoint(getByte),2)),vByte,count);
          stream.Write(vByte, sizeOf(vByte));
          address:= address+1;
        end;
        stream.Position:= 0;

        if isValid then
          png.LoadFromStream(stream);
      finally
        stream.Free;
        if isValid then
          if not(saveTo = '') then
            png.SaveToFile(saveTo)
          else if isPotrait then
            ClassSeat[getSeatID(ID)].views.potrait.Picture.Assign(png)
          else
            ClassSeat[getSeatID(ID)].views.thumb.Picture.Assign(png);
      end;
    finally
      png.Free;
    end;
  end;

end;

procedure TCore.showClassSeat(const forceVisible: boolean = false);
var
  i, seatNumber: integer;
  visibled: boolean;
begin
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];

    visibled:= false;
    if not(forceVisible) AND not(getcharID(seatNumber)=-1) then
      visibled:= true;

    ClassSeat[seatNumber].views.toNPC.Visible:= false;
    ClassSeat[seatNumber].views.toNPCRef.Visible:= false;
    ClassSeat[seatNumber].views.isStatus.Visible:= false;

    ClassSeat[seatNumber].views.isRespon.Visible:= false;
    ClassSeat[seatNumber].views.isLover.Visible:= false;
    ClassSeat[seatNumber].views.isIgnore.Visible:= false;

    ClassSeat[seatNumber].views.pThumb.Visible:= visibled;
    ClassSeat[seatNumber].views.thumb.Visible:= visibled;
    ClassSeat[seatNumber].views.firstName.Visible:= visibled;
    ClassSeat[seatNumber].views.lastName.Visible:= visibled;
    ClassSeat[seatNumber].views.personality.Visible:= visibled;
    ClassSeat[seatNumber].views.feelings.Visible:= visibled;
    ClassSeat[seatNumber].views.clubName.Visible:= visibled;
    ClassSeat[seatNumber].views.isLocation.Visible:= visibled;
    ClassSeat[seatNumber].views.Location.Visible:= visibled;
    ClassSeat[seatNumber].views.isAction.Visible:= visibled;
    ClassSeat[seatNumber].views.seatNum.Visible:= visibled;
    ClassSeat[seatNumber].views.seatBox.Visible:= true;
    ClassSeat[seatNumber].views.seatBox.Enabled:= visibled;
  end;
end;

procedure TCore.fillSeatID;
var
  i, charID: integer;
begin
  SetLength(seatID,0);
  for i:= 0 to 24 do
  begin
    // create List NPC Address
    setlength(NPCPlayAddress,i+1);
    NPCPlayAddress[i]:= '0';
    setlength(NPCTargetAddress,i+1);
    NPCTargetAddress[i]:= '0';
    setlength(NPCRefTargetAddress,i+1);
    NPCRefTargetAddress[i]:= '0';

    SetLength(seatID,i+1);
    charID:= ArrayIndexContainInteger(i,tempSeatID);
    if not(charID=-1) then
      SeatID[i]:= charID
    else SeatID[i]:= -1;
  end;
end;

procedure TCore.refreshClassData;
var i, seatNumber, charID: integer;
  getVal, fName, lName, personal: string;
begin
  // fill class data per seat
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    charID:= getCharID(seatNumber);
    if not(charID=-1) then
    begin
      fname:= GameData.getCodes(1,'FirstName',charID,true);
      ClassSeat[seatNumber].views.firstName.Caption:= fname;
      lname:= GameData.getCodes(1,'LastName',charID,true);
      ClassSeat[seatNumber].views.lastName.Caption:= lname;

      personal:= GameData.getCodes(1,'Personality',charID,true);
      if (strtoint(personal)>=0) AND (strtoint(personal) < 10) then personal:= '0'+personal;
        personal:= XMLData.TextObj.Data['PERSONALITY',personal];
      ClassSeat[seatNumber].views.personality.Caption:= personal;

      getVal:= GameData.getCodes(1,'Club',charID,true);
      if not(getVal[1]='?') then
        getVal:= MainForm.Club.Items.Strings[strtoint(getVal)];
      ClassSeat[seatNumber].views.clubName.Caption:= getVal;

      ClassSeat[seatNumber].charName:= fname+' '+lname;
      ClassSeat[seatNumber].listName:= inttostr(seatNumber)+'. '+ClassSeat[seatNumber].charName+' ('+personal+')';
      ClassSeat[seatNumber].views.seatBox.Caption:= '';//inttostr(seatNumber)+'  ';
      ClassSeat[seatNumber].views.seatBox.Alignment:= taRightJustify;

      // for oriented color
      case strtoint(GameData.getRegenValue(1,charID,'Oriented',true)) of
        0: ClassSeat[seatNumber].views.pThumb.Color:= MainForm.cdefTHetro.Brush.Color;
        1: ClassSeat[seatNumber].views.pThumb.Color:= MainForm.cdefTLHetro.Brush.Color;
        2: ClassSeat[seatNumber].views.pThumb.Color:= MainForm.cdefTBisex.Brush.Color;
        3: ClassSeat[seatNumber].views.pThumb.Color:= MainForm.cdefTLHomo.Brush.Color;
        4: ClassSeat[seatNumber].views.pThumb.Color:= MainForm.cdefTHomo.Brush.Color;
      end;
    end;
  end;
end;

procedure TCore.initClassData;
var i, seatNumber, charID: integer;
begin
  fillSeatID;

  // fill class data per seat
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    charID:= getCharID(seatNumber);
    if not(charID=-1) then
    begin
      NPCPlayAddress[seatnumber]:= GameData.getCodes(2,'CharAddress',charID,true);
      NPCTargetAddress[seatnumber]:= GameData.getCodes(2,'NPCAddress',charID,true);
      NPCRefTargetAddress[seatnumber]:= GameData.getCodes(2,'CharTarget',charID,true);

      // create class seat detail
      ClassSeat[seatNumber].isEmpty:= false;
      ClassSeat[seatNumber].charID:= charID;
      ClassSeat[seatNumber].actions.NPCAddress:= NPCTargetAddress[seatnumber];

      ClassSeat[seatNumber].ignoredSeat:= TStringlist.Create;

      ClassSeat[seatNumber].limitActions:= TStringlist.Create;

      ClassSeat[seatNumber].forceAction.Action:= -1;

      getThumbnail(charID);
      //getThumbnail(i,true);
    end;
  end;
end;

function TCore.countSeat: integer;
const gameAddress: dword = $00376164;
var
  valOffset: TOffsets;
  setOffset, getVal: string;
  i, seatNo, check: integer;
begin
  SetLength(tempSeatID,0);
  for i:= 0 to 24 do
  begin
    // npc address
    setOffset:= '00E4|0018|0F70|'+Dec2Hex((i*4),4)+'|006C';
    ConvertStringToOffset(setOffset,valOffset,'|');

    getVal:= GameData.Process.GetValues(GameData.Process.GetRealAddress(GameAddress+GameData.Process.PBaseAddress,valOffset),4);
    if not(getVal[1]='?') then
    begin
      // seat number
      setOffset:= '003C|'+Dec2Hex((i*4),4)+'|006C';
      ConvertStringToOffset(setOffset,valOffset,'|');
      getVal:= GameData.Process.GetValues(GameData.Process.GetRealAddress(GameAddress+GameData.Process.PBaseAddress,valOffset),4);
      val(getVal, seatNo, check);
      if (check=0) AND ((seatNo>=0) AND (seatNo<=24)) then
      begin
        if not(inTArray(seatNo,tempSeatID)) then
        begin
          // charID
          SetLength(tempSeatID,i+1);
          tempSeatID[i]:= seatNo;
        end;
      end;
    end;
  end;

  Result:= length(tempSeatID);
end;

function TCore.getCharID(idSeat: integer): integer;
begin
  Result:= -1;
  if not(idSeat=-1) then Result:= seatID[idSeat];
end;

function TCore.getSeatID(idChar: integer): integer;
begin
  Result:= -1;
  if not(idChar=-1) then Result:= ArrayIndexContainInteger(idChar,SeatID);
end;

{ ======================================================================ACTIONS ===========================================================}
procedure TCore.setActionAddress;
var i, seatNumber,charID: integer;
begin
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    charID:= getCharID(seatNumber);
    if not(charID=-1) then
    begin
      ClassSeat[seatnumber].actAddress.status     := GameData.getRegenAddress(2,charID,'Status',-1,1);
      ClassSeat[seatnumber].actAddress.action     := GameData.getRegenAddress(2,charID,'Action',-1,1);
      ClassSeat[seatnumber].actAddress.target     := GameData.getRegenAddress(2,charID,'NPCTarget',-1,1);
      ClassSeat[seatnumber].actAddress.targetRef  := GameData.getRegenAddress(2,charID,'ReffTo',-1,1);
      ClassSeat[seatnumber].actAddress.response   := GameData.getRegenAddress(2,charID,'Response',-1,1);
      ClassSeat[seatnumber].actAddress.isInteract := GameData.getRegenAddress(2,charID,'PCInteract',-1,1);
      ClassSeat[seatnumber].actAddress.npcInteract:= GameData.getRegenAddress(2,charID,'NPCInteract',-1,1);
      ClassSeat[seatnumber].actAddress.location   := GameData.getRegenAddress(2,charID,'Location',-1,1);
      ClassSeat[seatnumber].actAddress.IntWait    := GameData.getRegenAddress(2,charID,'IntructionWait',-1,1);
      ClassSeat[seatnumber].actAddress.IntTime    := GameData.getRegenAddress(2,charID,'IntructionTime',-1,1);
      ClassSeat[seatnumber].actAddress.fireAction := GameData.getRegenAddress(2,charID,'FireAction',-1,1);

      ClassSeat[seatnumber].actAddress.virtue     := GameData.getRegenAddress(1,charID,'Virtue',-1,0);
      ClassSeat[seatnumber].actAddress.SingleMind := GameData.getRegenAddress(1,charID,'Singlemind',-1,0);
      ClassSeat[seatnumber].actAddress.lucky      := GameData.getRegenAddress(1,charID,'Lucky',-1,0);
    end;
  end;
end;

function TCore.getCharAction(seatID: integer; types: TActType; const isNumber: boolean = false): string;
var getVal,strRet: string;
begin
  strRet:= '????????';
  getVal:= strRet;
  if isNumber then strRet:= '-1';

  case types of
    ActStatus     : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.status,4);
    ActAction     : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.action,4);
    ActTarget     : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.target,4);
    ActRefer      : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.targetRef,4);
    ActResponse   : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.response,1);
    ActInteract   : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.isInteract,1);
    ActNpcInteract: getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.npcInteract,1);
    ActLocation   : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.location,1);
    ActIntWait    : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.IntWait,4);
    ActIntTime    : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.IntTime,4);
    ActFired      : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.fireAction,4);
    ActVirtue     : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.virtue,1);
    ActSingleMind : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.singleMind,1);
    ActLucky      : getVal:= GameData.Process.GetValues(ClassSeat[seatID].actAddress.lucky,1);
  end;

  if not(getVal[1]='?') then
    strRet:= getVal;

  Result:= strRet;
end;

{
0.Wait
1.Roaming Around
2.Go Location
3.Moving to Character
4.Train
5.?
6.?
7.Chat
8.Facing To
}
function TCore.getNPCState(seatID: integer): TActionState;
var s,a,t: int64;
begin
  Result:= IsNA;

  if (getCharID(seatID)=-1) then exit;

  s:= strtoint64(getCharAction(seatID,ActStatus,true));
  a:= strtoint64(getCharAction(seatID,ActAction,true));
  t:= strtoint64(getCharAction(seatID,ActTarget,true));

  // chating
  if ((s in [0,7]) and (a<255) and not(t=0)) then Result:= IsChat
  // follow interact
  else if ((s in [1,2,4]) and (a<255) and not(t=0)) then Result:= IsFollow
  // stalking
  else if ((s in [1,4,8]) and (a in [106,107]) and not(t=0)) then Result:= IsStalking
  // going interact
  else if ((s in [1,3,8]) and not(t=0)) then Result:= IsGoingInteract
  // going interact decide action
  else if ((s in [5,6]) and not(t=0)) then Result:= IsDecide
  // do single act
  else if ((s in [1,2]) and (a<255) and (t=0)) then Result:= IsDoSingleAct
  // do sex
  else if (((s=0) OR (s=4294967295)) and (a in [32,38,48,73,74,102]) and not(t=0)) then Result:= IsDoSex
  // else idle
  else if (s in [0,1,2]) AND (a>255) AND ((seatID=core.playedSeat) OR (t=0)) then Result:= IsIdle;
end;

{ ================================================================================== FREEZING ============================================= }

procedure TCore.setFreezeData(types, field, codes, value: string; freezeState: boolean; const seatNo: integer = -1; const toSeat: integer = -1);
var
  nID: integer;
  unixID, freezeID: string;
begin
  if (value='') OR (value[1]='?') then exit;

  unixID:= types+'_'+field+'_'+inttostr(seatNo)+'_'+inttostr(toSeat);

  freezeID:= GameData.CharCode.Data['FreezeData',unixID];
  // add freeze data
  if (freezeID = '') then
  begin
    nID:= length(GameData.FreezeData);
    SetLength(GameData.FreezeData,nID+1);

    GameData.FreezeData[nID].types:= types;
    GameData.FreezeData[nID].field:= field;
    GameData.FreezeData[nID].seatNumber:= seatNo;
    GameData.FreezeData[nID].toSeat:= toSeat;

    GameData.FreezeData[nID].unixID:= unixID;
    GameData.FreezeData[nID].FreezeValue:= value;
    GameData.FreezeData[nID].isFreeze:= freezeState;

    GameData.parseCodeToData(codes);
    GameData.FreezeData[nID].codes.code     := codes;
    GameData.FreezeData[nID].codes.base     := GameData.strCode.base;
    GameData.FreezeData[nID].codes.offset   := GameData.strCode.offset;
    //GameData.FreezeData[nID].codes.address  := GameData.strCode.address;
    GameData.FreezeData[nID].codes.bits     := GameData.strCode.bits;
    GameData.FreezeData[nID].codes.bitLength:= GameData.strCode.bitLength;
    GameData.FreezeData[nID].codes.isUnicode:= GameData.strCode.isUnicode;

    GameData.CharCode.Data['FreezeData',unixID]:= inttostr(nID);
  end else
  // set freeze state
  begin
    nID:= strtoint(freezeID);
    GameData.FreezeData[nID].FreezeValue:= value;
    GameData.FreezeData[nID].isFreeze:= freezeState;
  end;
end;

function TCore.freezeCheck(i: integer; const numTry: integer = 3): boolean;
var
  getVal: string;
  setTry: integer;
  address: dword;
begin
  Result:= false;

  setTry:= numTry;

  address:= GameData.Process.GetRealAddress(GameData.FreezeData[i].codes.base+GameData.Process.PBaseAddress,GameData.FreezeData[i].codes.offset);
  getVal:= GameData.Process.GetValues(address,GameData.FreezeData[i].codes.bits);
  if (getVal='') OR (getVal[1]='?') then GameData.FreezeData[i].isValid:= false
  else GameData.FreezeData[i].isValid:= true;

  if not(GameData.FreezeData[i].isValid) then
  begin
    dec(setTry);
    if (setTry>=0) then Result:= freezeCheck(i,setTry);
  end else
    Result:= true;
end;

procedure TCore.runtimeFreezeData;
var
  i: integer;
  getVal: string;
  address: dword;
begin
  freezeCounter:= 0;
  if (length(GameData.FreezeData) > 0) then
  for i:= 0 to length(GameData.FreezeData)-1 do
  begin
    if not(freezeCheck(i)) then
    begin
      GameData.FreezeData[i].isFreeze := false;
    end else
    if GameData.FreezeData[i].isFreeze then
    begin
      // double check value
      address:= GameData.Process.GetRealAddress(GameData.FreezeData[i].codes.base+GameData.Process.PBaseAddress,GameData.FreezeData[i].codes.offset);
      getVal:= GameData.Process.GetValues(address,GameData.FreezeData[i].codes.bits);
      if not(getVal='') AND not(getVal[1]='?') AND not(GameData.FreezeData[i].FreezeValue='') AND not(GameData.FreezeData[i].FreezeValue[1]='?') then
        GameData.Process.SetValues(address,GameData.FreezeData[i].codes.bits,GameData.FreezeData[i].FreezeValue)
      else begin
        GameData.FreezeData[i].isValid := false;
        GameData.FreezeData[i].isFreeze:= false;
      end;
    end;
  end;
end;

{ ============================================================================= PLAN ACTION =============================================== }

procedure TCore.planActionMem(const seatNumber: integer = -1);
var before: integer;
    i, seatNo: integer;
begin
  seatNo:= selectedSeat;
  if not(seatNumber=-1) then seatNo:= seatNumber;

  before:=length(ClassSeat[seatNo].planAction.ListAction);

  if ClassSeat[seatNo].planAction.No<before then
  begin
    //cleanup some extra memory
    for i:=ClassSeat[seatNo].planAction.No to before-1 do
    begin
      //setlength(memrec[i].pointers,0);
      //setlength(memrec[i].allocs,0);
    end;
  end;

  setlength(ClassSeat[seatNo].planAction.ListAction,ClassSeat[seatNo].planAction.No);
  setlength(ClassSeat[seatNo].planAction.selected,ClassSeat[seatNo].planAction.No);

  if ClassSeat[seatNo].planAction.No>before then
  begin
    //initialize the new memory
    for i:=before to ClassSeat[seatNo].planAction.No-1 do
    begin
      zeromemory(@ClassSeat[seatNo].planAction.ListAction[i],sizeof(ClassSeat[seatNo].planAction.ListAction[i]));
      zeromemory(@ClassSeat[seatNo].planAction.selected[i],sizeof(ClassSeat[seatNo].planAction.selected[i]));
    end;
  end;

  PlanActionCreated:= true;
end;

{ ================================================================================== PASTE BIN =============================================== }

procedure TCore.pasteBinMem;
var before: integer;
    i: integer;
begin
  before:=length(pasteBin.ListData);

  if pasteBin.No<before then
  begin
    //cleanup some extra memory
    for i:=pasteBin.No to before-1 do
    begin
      setlength(pasteBin.ListData[i].ValueData,0);
      //if not(pasteBin.ListData[i].Thumbnail=nil) then
      //  pasteBin.ListData[i].Thumbnail.Free;
    end;
  end;

  setlength(pasteBin.ListData,pasteBin.No);
  setlength(pasteBin.Selected,pasteBin.No);
  //setlength(pasteBin.listUnixID,pasteBin.No);

  if pasteBin.No>before then
  begin
    //initialize the new memory
    for i:=before to pasteBin.No-1 do
    begin
      zeromemory(@pasteBin.ListData[i],sizeof(pasteBin.ListData[i]));
      zeromemory(@pasteBin.Selected[i],sizeof(pasteBin.Selected[i]));
      //zeromemory(@pasteBin.listUnixID[i],sizeof(pasteBin.listUnixID[i]));
    end;
  end;
end;

procedure TCore.copyBinData(charID: integer);
var i: integer;
  description, unixID, tempVal: string;
begin
  if (charID=-1) or (getSeatID(charID)=-1) then exit;

  description:= core.classSeat[getSeatID(charID)].listName;
  {unixID:= inttostr(charID)+description;
  if (ArrayContainText(unixID,PasteBin.listUnixID,true)) then exit;
  }
  inc(PasteBin.No);
  pasteBinMem;

  //PasteBin.listUnixID[PasteBin.No-1]:= unixID;
  PasteBin.ListData[PasteBin.No-1].Thumbnail:= TJvImage.Create(MainForm);
  PasteBin.ListData[PasteBin.No-1].Thumbnail.Picture.Assign(core.classSeat[getSeatID(charID)].views.thumb.Picture);
  PasteBin.ListData[PasteBin.No-1].SeatNo:= getSeatID(charID);
  PasteBin.ListData[PasteBin.No-1].Description:= description;
  setlength(PasteBin.ListData[PasteBin.No-1].ValueData,PasteBin.MaxField);

  // all char base data is 342
  for i:= 0 to PasteBin.MaxField-1 do
  begin
    // prepare field name
    if not(PasteBin.createField) then
    begin
      SetLength(PasteBin.FieldData,i+1);
      PasteBin.FieldData[i]:= core.GameData.RegenCode[charID].DataCode[0].NameCode[i];
      if (length(PasteBin.FieldData)>=PasteBin.MaxField) then
        PasteBin.createField:= true;
    end;
    tempVal:= core.GameData.getRegenValue(1,charID,i,false,-1,0);
    if not(tempVal='') AND not(tempVal[1]='?') then
      PasteBin.ListData[PasteBin.No-1].ValueData[i]:= tempVal
    else PasteBin.ListData[PasteBin.No-1].ValueData[i]:= '';
  end;

end;

procedure TCore.pasteBinData(charID: integer; pbBody,pbOutfit,pbBase: boolean);
const
  dprofile: integer = 120;
  dbody   : integer = 190;
  doutfit : integer = 342;
var i, start, ends: integer;
begin
  if (charID=-1) OR (PasteBin.lastSelected>PasteBin.No) then exit;

  // change picture is error T_T
  for i:= 0 to PasteBin.MaxField-1 do
  if not(PasteBin.ListData[PasteBin.lastSelected].ValueData[i]='') then
  if not(i in [0,1,2,3]) AND ((pbBase AND ((i >= 0) AND (i <= (dprofile-25)))) OR (pbBody AND ((i > dprofile) AND (i <= dbody))) OR (pbOutfit AND ((i > dbody) AND (i <= doutfit)))) then
  begin
    //if (core.GameData.RegenCode[charID].DataCode[0].SingleCode[i].bits=11) then
    if (i in [5,6,7,103,104,105,106,107,108,160,161]) then continue;
    GameData.setRegenValue(1,charID,i,PasteBin.ListData[PasteBin.lastSelected].ValueData[i],-1,0);
  end;
end;

procedure TCore.removeBinData;
var i,j: Integer;
begin

  i:=0;
  while i<pasteBin.No do
  begin
    if pasteBin.selected[i] then
    begin
      for j:=i to pasteBin.No-2 do
      begin
        pasteBin.ListData[j]:=pasteBin.ListData[j+1];
        pasteBin.selected[j]:=pasteBin.selected[j+1];
        //PasteBin.listUnixID[j]:=PasteBin.listUnixID[j+1];
      end;

      dec(pasteBin.No);
      dec(i);
      pasteBinMem;

    end;

    inc(i);
  end;

  If pasteBin.lastselected>pasteBin.No-1 then
    pasteBin.lastselected:=pasteBin.No-1;
  if pasteBin.lastselected>-1 then
    pasteBin.selected[pasteBin.lastselected]:=true;

end;

{ ========================================================================= MANAGE SAVE FILE ================================================= }

function TCore.parseStrBinData(encode: boolean; const idx: integer = -1; const value: string = ''):string;
const
  seriKey: string = '1A2B3C4D5E';
var
  strVal: string;
  lstStr: TStrings;
  i: integer;
begin

  if encode then
  begin
    strVal:= PasteBin.ListData[idx].Description+'|';
    for i:= 0 to length(PasteBin.ListData[idx].ValueData)-1 do
      strVal:= strVal + PasteBin.ListData[idx].ValueData[i] +'|';
    Result:= HEncodeString(seriKey,strVal);
  end else
  begin
    strVal:= HDecodeString(seriKey,value);
    lstStr:= Explode('|',strVal);
    if (lstStr.Count=(PasteBin.MaxField+2)) then
    begin
      inc(PasteBin.No);
      pasteBinMem;
      //PasteBin.ListData[PasteBin.No-1].Thumbnail:= TJvImage.Create(MainForm);
      PasteBin.ListData[PasteBin.No-1].Description:= lstStr.Strings[0];
      setlength(PasteBin.ListData[PasteBin.No-1].ValueData,PasteBin.MaxField);

      // all char base data is 342
      for i:= 0 to PasteBin.MaxField-1 do
      begin
        // prepare field name
        if not(PasteBin.createField) then
        begin
          SetLength(PasteBin.FieldData,i+1);
          PasteBin.FieldData[i]:= core.GameData.RegenCode[0].DataCode[0].NameCode[i];
          if (length(PasteBin.FieldData)>=PasteBin.MaxField) then
            PasteBin.createField:= true;
        end;

        if not(lstStr.Strings[i+1]='') AND not(lstStr.Strings[i+1][1]='?') then
          PasteBin.ListData[PasteBin.No-1].ValueData[i]:= lstStr.Strings[i+1]
        else PasteBin.ListData[PasteBin.No-1].ValueData[i]:= '';
      end;
    end;
  end;

end;

function TCore.parseStrFreezeData(encode: boolean; const idx: integer = -1; const value: string = ''):string;
const
  seriKey: string = 'A1B2C3D4E5';
var
  strVal: string;
  lstStr: TStrings;
  newid: integer;
begin

  if encode then
  begin
    strVal:= GameData.FreezeData[idx].types+'|';                              // tipe
    strVal:= strVal+GameData.FreezeData[idx].field+'|';                       // field
    strVal:= strVal+inttostr(GameData.FreezeData[idx].seatNumber)+'|';        // seatNumber
    strVal:= strVal+inttostr(GameData.FreezeData[idx].toSeat)+'|';            // toseat
    strVal:= strVal+GameData.FreezeData[idx].unixID+'|';                      // unixID
    strVal:= strVal+GameData.FreezeData[idx].codes.code+'|';                  // code
    strVal:= strVal+GameData.FreezeData[idx].FreezeValue;                     // freeze value
    Result:= HEncodeString(seriKey,strVal);
  end else
  begin
    strVal:= HDecodeString(seriKey,value);
    lstStr:= Explode('|',strVal);

    // versi 2.0.22 must 7 field
    if (lstStr.Count=7) then
    if not(getCharID(StrToInt(lstStr.Strings[2]))=-1) AND (GameData.CharCode.Data['FreezeData',lstStr.Strings[4]]='') then
    begin
      GameData.parseCodeToData(lstStr.Strings[5]);
      if not(GameData.strCode.base=0) then
      begin
        newID:= length(GameData.FreezeData);
        SetLength(GameData.FreezeData,newID+1);

        GameData.FreezeData[newID].types:= lstStr.Strings[0];
        GameData.FreezeData[newID].field:= lstStr.Strings[1];
        GameData.FreezeData[newID].seatNumber:= strtoint(lstStr.Strings[2]);
        GameData.FreezeData[newID].toSeat:= strtoint(lstStr.Strings[3]);
        GameData.FreezeData[newID].unixID:= lstStr.Strings[4];
        GameData.FreezeData[newID].FreezeValue:= lstStr.Strings[6];
        GameData.FreezeData[newID].isFreeze:= True;

        GameData.FreezeData[newID].codes.code     := lstStr.Strings[5];
        GameData.FreezeData[newID].codes.base     := GameData.strCode.base;
        GameData.FreezeData[newID].codes.offset   := GameData.strCode.offset;
        //GameData.FreezeData[newID].codes.address  := GameData.strCode.address;
        GameData.FreezeData[newID].codes.bits     := GameData.strCode.bits;
        GameData.FreezeData[newID].codes.bitLength:= GameData.strCode.bitLength;
        GameData.FreezeData[newID].codes.isUnicode:= GameData.strCode.isUnicode;

        GameData.CharCode.Data['FreezeData',lstStr.Strings[4]]:= inttostr(newID);
      end;
    end;
  end;

end;

procedure TCore.manageSavedItems(state: TSavedData; nodes: IXMLNode);
var
  seatNumber,No: integer;
  node: IXMLNode;
begin
  case state of
    FilePlanAction:
    if not(getCharID(nodes.Attributes['Seat'])=-1) then
    begin
      seatNumber:= nodes.Attributes['Seat'];
      ClassSeat[seatNumber].planAction.Started:= StrToBoolDef(nodes.Attributes['Active'],true);
      ClassSeat[seatNumber].planAction.Looping:= StrToBoolDef(nodes.Attributes['Looping'],true);
      ClassSeat[seatNumber].planAction.Shuffle:= StrToBoolDef(nodes.Attributes['Shuffle'],true);
      ClassSeat[seatNumber].planAction.Forced := StrToBoolDef(nodes.Attributes['ForceNPC'],true);
      ClassSeat[seatNumber].planAction.Quicked:= StrToBoolDef(nodes.Attributes['ForcePerform'],true);

      ClassSeat[seatNumber].planAction.TotActive:= 0;

      node:= nodes.ChildNodes.First;
      while (node <> nil) do
      begin
        if not(getCharID(node.Attributes['Seat'])=-1) then
        begin
          inc(ClassSeat[seatNumber].planAction.No);
          No:= ClassSeat[seatNumber].planAction.No;
          planActionMem(seatNumber);

          ClassSeat[seatNumber].planAction.ListAction[No-1].Active:= StrToBoolDef(node.Attributes['Active'],true);
          ClassSeat[seatNumber].planAction.ListAction[No-1].Seat  := node.Attributes['Seat'];
          ClassSeat[seatNumber].planAction.ListAction[No-1].CharID:= getCharID(node.Attributes['Seat']);
          ClassSeat[seatNumber].planAction.ListAction[No-1].Action:= node.Attributes['Action'];

          if not(core.PlanActionCreated) then core.PlanActionCreated:= true;
          if StrToBoolDef(node.Attributes['Active'],true) then inc(ClassSeat[seatNumber].planAction.TotActive);
        end;
        node:= node.NextSibling;
      end;

      MainForm.managePlanAction(IsRefresh,true,seatNumber);

      if not(ClassSeat[seatNumber].planAction.syncAction = nil) then
        ClassSeat[seatNumber].planAction.syncAction.Enabled:= ClassSeat[seatNumber].planAction.Started;
    end;
  end;
end;

function TCore.manageSavedData(state: TSavedData; fileName: string; const doSave: boolean = true): boolean;
var
  XMLDocs: TXMLDocument;
  childs, child, subChilds, subChild: IXMLNode;
  i, ii: integer;
begin
  Result:= false;
  XMLDocs:= TXMLDocument.Create(MainForm);

  if doSave then
  begin
    XMLDocs.Active:= True;
    XMLDocs.Encoding:= 'utf-8';
    XMLDocs.Options:=[doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doAutoPrefix,doNamespaceDecl];
    childs:= XMLDocs.AddChild('Trainer');
    childs.Attributes['Version']:= XMLData.TextObj.Items['version'];
    childs.Attributes['Game']:= 'Arificial Academy 2';
  end else
  if FileExists(fileName) then
    XMLDocs.LoadFromFile(fileName)
  else exit;

  case state of
    FilePasteBin:
      if doSave then
      begin
        if length(PasteBin.ListData)>0 then
        begin
          child:= childs.AddChild('PasteBin');
          for i:= 0 to length(PasteBin.ListData)-1 do
          begin
            subChilds:= child.AddChild('Characters');
            subChilds.Attributes['Data']:= parseStrBinData(true,i);
          end;
        end;
      end else
      begin
        childs:= XMLDocs.DocumentElement.ChildNodes.FindNode('PasteBin');
        if childs <> nil then
        begin
          child:= childs.ChildNodes.first;
          while child <> nil do
          begin
            parseStrBinData(false,0,child.Attributes['Data']);
            child:= child.NextSibling;
          end;
        end;
      end;
    FilePlanAction:
      if doSave then
      begin
        // Plan Action
        if PlanActionCreated then
        begin
          child:= childs.AddChild('Plan');
          for i:= 0 to 24 do
          if (length(ClassSeat[ClassSeat[i].seatNumber].planAction.ListAction)>0) then
          begin
            subChilds:= child.AddChild('Actions');
            subChilds.Attributes['Seat']:= ClassSeat[i].seatNumber;
            subChilds.Attributes['Active']:= BoolToStr(ClassSeat[ClassSeat[i].seatNumber].planAction.Started,true);
            subChilds.Attributes['Looping']:= BoolToStr(ClassSeat[ClassSeat[i].seatNumber].planAction.Looping,true);
            subChilds.Attributes['Shuffle']:= BoolToStr(ClassSeat[ClassSeat[i].seatNumber].planAction.Shuffle,true);
            subChilds.Attributes['ForceNPC']:= BoolToStr(ClassSeat[ClassSeat[i].seatNumber].planAction.Forced,true);
            subChilds.Attributes['ForcePerform']:= BoolToStr(ClassSeat[ClassSeat[i].seatNumber].planAction.Quicked,true);
            for ii:= 0 to length(ClassSeat[ClassSeat[i].seatNumber].planAction.ListAction)-1 do
            begin
              subChild:= subChilds.AddChild('Action');
              subChild.Attributes['Active']:= BoolToStr(ClassSeat[ClassSeat[i].seatNumber].planAction.ListAction[ii].Active,true);
              subChild.Attributes['Seat']:= ClassSeat[ClassSeat[i].seatNumber].planAction.ListAction[ii].Seat;
              subChild.Attributes['Action']:= ClassSeat[ClassSeat[i].seatNumber].planAction.ListAction[ii].Action;
            end;
          end;
        end;

        // Ignored char
        child:= childs.AddChild('Ignored');
        for i:= 0 to 24 do
        if not(ClassSeat[i].isEmpty) then
        if (ClassSeat[ClassSeat[i].seatNumber].ignoredSeat.Count>0) then
        begin
          subChilds:= child.AddChild('From');
          subChilds.Attributes['Seat']:= ClassSeat[i].seatNumber;
          for ii:= 0 to ClassSeat[ClassSeat[i].seatNumber].ignoredSeat.Count-1 do
          begin
            subChild:= subChilds.AddChild('ToNPC');
            subChild.Attributes['Seat']:= ClassSeat[ClassSeat[i].seatNumber].ignoredSeat.Names[ii];
          end;
        end;

        // Force Action
        child:= childs.AddChild('ForceAction');
        for i:= 0 to 24 do
        if not(ClassSeat[i].isEmpty) then
        if ClassSeat[ClassSeat[i].seatNumber].forceAction.Active then
        begin
          subChilds:= child.AddChild('Target');
          subChilds.Attributes['Seat']:= ClassSeat[i].seatNumber;
          subChilds.Attributes['Action']:= ClassSeat[ClassSeat[i].seatNumber].forceAction.Action;
        end;

        // Limit Actions
        child:= childs.AddChild('LimitActions');
        for i:= 0 to 24 do
        if not(ClassSeat[i].isEmpty) then
        if (ClassSeat[ClassSeat[i].seatNumber].limitActions.Count>0) then
        begin
          subChilds:= child.AddChild('Actions');
          subChilds.Attributes['Seat']:= ClassSeat[i].seatNumber;
          for ii:= 0 to ClassSeat[ClassSeat[i].seatNumber].limitActions.count-1 do
          begin
            subChild:= subChilds.AddChild('Action');
            subChild.Attributes['Action']:= ClassSeat[ClassSeat[i].seatNumber].limitActions.Names[ii];
            subChild.Attributes['Name']:= ClassSeat[ClassSeat[i].seatNumber].limitActions.ValueFromIndex[ii];
          end;
        end;

        // Freeze Data
        if length(GameData.FreezeData)>0 then
        begin
          child:= childs.AddChild('Freezing');
          for i:= 0 to length(GameData.FreezeData)-1 do
          if GameData.FreezeData[i].isFreeze then
          begin
            subChilds:= child.AddChild('Codes');
            subChilds.Attributes['Key']:= parseStrFreezeData(true,i);
          end;
        end;

      end else
      begin
        if PlanActionCreated then MainForm.managePlanAction(IsClearAll);
        core.clearSeatData;
        
        // plan action
        childs:= XMLDocs.DocumentElement.ChildNodes.FindNode('Plan');
        if childs <> nil then
        begin
          child:= childs.ChildNodes.first;
          while child <> nil do
          begin
            manageSavedItems(state,child);
            child:= child.NextSibling;
          end;
        end;

        // ForceAction
        childs:= XMLDocs.DocumentElement.ChildNodes.FindNode('ForceAction');
        if childs <> nil then
        begin
          child:= childs.ChildNodes.first;
          while child <> nil do
          begin
            if not(getCharID(child.Attributes['Seat'])=-1) then
            begin
              ii:= child.Attributes['Seat'];
              ClassSeat[ii].forceAction.Action:= child.Attributes['Action'];
              ClassSeat[ii].forceAction.Active:= true;
            end;
            child:= child.NextSibling;
          end;
        end;

        // Ignored char
        childs:= XMLDocs.DocumentElement.ChildNodes.FindNode('Ignored');
        if childs <> nil then
        begin
          child:= childs.ChildNodes.first;
          while child <> nil do
          begin
            if not(getCharID(child.Attributes['Seat'])=-1) then
            begin
              ii:= child.Attributes['Seat'];
              if (ClassSeat[ii].ignoredSeat=nil) then
                ClassSeat[ii].ignoredSeat:= TStringList.Create
              else ClassSeat[ii].ignoredSeat.Clear;

              subChilds:= child.ChildNodes.First;
              while (subChilds <> nil) do
              begin
                ClassSeat[ii].ignoredSeat.Values[subChilds.Attributes['Seat']]:= subChilds.Attributes['Seat'];
                subChilds:= subChilds.NextSibling;
              end;
            end;
            child:= child.NextSibling;
          end;
        end;

        // limit action
        childs:= XMLDocs.DocumentElement.ChildNodes.FindNode('LimitActions');
        if childs <> nil then
        begin
          child:= childs.ChildNodes.first;
          while child <> nil do
          begin
            if not(getCharID(child.Attributes['Seat'])=-1) then
            begin
              ii:= child.Attributes['Seat'];
              if (ClassSeat[ii].limitActions=nil) then
                ClassSeat[ii].limitActions:= TStringList.Create
              else ClassSeat[ii].limitActions.Clear;

              subChilds:= child.ChildNodes.First;
              while (subChilds <> nil) do
              begin
                ClassSeat[ii].limitActions.Values[subChilds.Attributes['Action']]:= subChilds.Attributes['Name'];
                subChilds:= subChilds.NextSibling;
              end;
            end;
            child:= child.NextSibling;
          end;
        end;

        // freeze data
        childs:= XMLDocs.DocumentElement.ChildNodes.FindNode('Freezing');
        if childs <> nil then
        begin
          child:= childs.ChildNodes.first;
          while child <> nil do
          begin
            parseStrFreezeData(false,0,child.Attributes['Key']);
            child:= child.NextSibling;
          end;
        end;
      end;
  end;

  if doSave then XMLDocs.SaveToFile(fileName);
  Result:= true;
end;

end.
