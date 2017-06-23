unit UMain;

interface

uses
  UCore, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  jpeg, ExtCtrls, JvExExtCtrls, JvImage, JvExControls, JvLabel, StdCtrls, Math,
  JvRollOut, JvExtComponent, JvPanel, ComCtrls, JvExComCtrls, JvStatusBar,
  Dialogs, JvJCLUtils, JvStringHolder, JvGIF, JvComCtrls, Grids, JvExGrids,
  JvStringGrid, JvExStdCtrls, JvCombobox, JvListComb, JvColorBox,
  JvColorButton, Mask, JvExMask, JvSpin, JvMemo, JvArrowButton, JvExForms,
  JvScrollBox, JvNetscapeSplitter, JvTimer, JvTimerList, ImgList,
  JvImageList, JvListView, PngImage, PngImageList, Menus, JvFooter, JvCheckBox,
  JvComponentBase, JvBalloonHint, UxTheme, JvSwitch, JvSpecialProgress,
  JvDialogs, JvSpeedButton, JvFullColorDialogs, JvBaseDlg, JvBrowseFolder,
  JvCaptionPanel, JvLED, JvHotKey, JvAppHotKey;

type
  TForcedAct = record
    Toggled   : boolean;
    Active    : boolean;
    seatNumber: integer;
    Action    : integer;
    NPCAddress: string;
  end;

  TClipboardColor = record
    tempName : string;
    tempColor: TColor;
    setColor : boolean;
    LastIndex: integer;
    Name  : array [0..11] of string;
    Color : array [0..11] of TColor;
  end;

  TSeatColor = record
    isLoaded: boolean;
    defColor: array [0..16] of TColor;
    newColor: array [0..16] of TColor;
  end;
  
  TPragnantCheck = record
    Active     : boolean;
    Reset      : boolean;
    DayNumber  : integer;
  end;
  
  TFreezeCBox = record
    Behavior, Relationship: array [0..24] of boolean;
  end;

  TPlayerAction = record
    Seat       : integer;
    CharAddress: string;
    toSeat     : integer;
    toCharID   : integer;
    toCharAddress: string;
    VirtueID   : integer;
    SingleMind : boolean;
    Compatible : boolean;
    Triggered  : boolean;
    RunProces  : boolean;
    BeginSex   : boolean;
    Active     : boolean;
  end;

  TPlanItems = record
    ActiveHead: boolean;
    TotalRow  : integer;
    Selected  : array of TLabel;
    Active    : array of TCheckbox;
    Seat      : array of TCombobox;
    Action    : array of TCombobox;
    Triggered : array of TCheckbox;
    Remove    : array of TButton;
  end;

  TSenderGrid = record
    CharID   : integer;
    toCharID : integer;
    indexCode: integer;
    selCol: integer;
    selRow: integer;
  end;

  TSenderData = record
    seatNumber : integer;
    Types : string;
    Name  : string;
    Value : string;
    Tag   : integer;
  end;

  TMainForm = class(TForm)
    statusBar: TJvStatusBar;
    wrap: TJvPanel;
    header: TJvPanel;
    container: TPanel;
    personalData: TJvRollOut;
    JvPanel2: TJvPanel;
    actionData: TJvRollOut;
    pClass: TJvPanel;
    defSeat: TJvPanel;
    defFName: TJvLabel;
    defLName: TJvLabel;
    defPThumb: TJvPanel;
    defThumb: TJvImage;
    codeStore: TJvMultiStringHolder;
    tabs: TJvPageControl;
    tabPersonal: TTabSheet;
    Panel6: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label67: TLabel;
    Social: TComboBox;
    FightingStyle: TComboBox;
    Virtue: TComboBox;
    Oriented: TComboBox;
    SexExp: TCheckBox;
    AnalExp: TCheckBox;
    VoicePitch: TComboBox;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    IntLevel: TComboBox;
    StrLevel: TComboBox;
    IntRank: TJvSpinEdit;
    IntValue: TJvSpinEdit;
    StrRank: TJvSpinEdit;
    StrValue: TJvSpinEdit;
    ClubRank: TJvSpinEdit;
    ClubValue: TJvSpinEdit;
    IntGrade: TComboBox;
    IntTopRank: TJvSpinEdit;
    StrGrade: TComboBox;
    StrTopRank: TJvSpinEdit;
    ClubGrade: TComboBox;
    tabTrait: TTabSheet;
    CPersonal2: TPanel;
    GTrait: TGroupBox;
    Easygoing: TCheckBox;
    Affable: TCheckBox;
    BadwithGuys: TCheckBox;
    BadwithGirls: TCheckBox;
    Charming: TCheckBox;
    Tsundare: TCheckBox;
    Chivalrous: TCheckBox;
    Trendy: TCheckBox;
    Obedient: TCheckBox;
    Positive: TCheckBox;
    Shy: TCheckBox;
    Jealous: TCheckBox;
    Melancholy: TCheckBox;
    Preverted: TCheckBox;
    Serious: TCheckBox;
    Calm: TCheckBox;
    Impulsive: TCheckBox;
    Absentmind: TCheckBox;
    Violent: TCheckBox;
    Passive: TCheckBox;
    Maddlesome: TCheckBox;
    ClassInco: TCheckBox;
    Chatty: TCheckBox;
    Hungry: TCheckBox;
    Romantic: TCheckBox;
    Singlemind: TCheckBox;
    Indencisive: TCheckBox;
    Competitive: TCheckBox;
    Scheming: TCheckBox;
    Diligent: TCheckBox;
    Wild: TCheckBox;
    Masochist: TCheckBox;
    Sweaty: TCheckBox;
    Evil: TCheckBox;
    Deaf: TCheckBox;
    Exploitable: TCheckBox;
    ASexual: TCheckBox;
    Lucky: TCheckBox;
    GPrefer: TGroupBox;
    RainbowCard: TCheckBox;
    Kissing: TCheckBox;
    BreastCares: TCheckBox;
    VaginaCares: TCheckBox;
    PenisCares: TCheckBox;
    Cunninglus: TCheckBox;
    Fellation: TCheckBox;
    DoggyStyle: TCheckBox;
    Fendom: TCheckBox;
    Anal: TCheckBox;
    NoCondom: TCheckBox;
    Swallow: TCheckBox;
    Creampies: TCheckBox;
    Bukake: TCheckBox;
    tabBody: TTabSheet;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label114: TLabel;
    BodyType: TComboBox;
    Heights: TComboBox;
    Figure: TComboBox;
    BreastShape: TComboBox;
    BreastSoftness: TComboBox;
    HeadSize: TJvSpinEdit;
    HeadLength: TJvSpinEdit;
    Waist: TJvSpinEdit;
    BreastSize: TJvSpinEdit;
    BreastRoundness: TJvSpinEdit;
    BreastDirection: TJvSpinEdit;
    BreastHeight: TJvSpinEdit;
    BreastSpacing: TJvSpinEdit;
    AreolaSize: TJvSpinEdit;
    BreastDepth: TJvSpinEdit;
    PubHairType: TComboBox;
    NippleType: TComboBox;
    NippleColor: TComboBox;
    TanMark: TComboBox;
    PussyMosaic: TComboBox;
    PubHairOpa: TJvSpinEdit;
    NippleOpa: TJvSpinEdit;
    TanOpa: TJvSpinEdit;
    SkinColor: TJvColorButton;
    PubHairColor: TJvColorButton;
    tabFace: TTabSheet;
    GroupBox6: TGroupBox;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label113: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    FaceType: TComboBox;
    IrisType: TComboBox;
    IrisShape: TComboBox;
    EyeWidth: TJvSpinEdit;
    EyeHeight: TJvSpinEdit;
    EyePos: TJvSpinEdit;
    EyeSpacing: TJvSpinEdit;
    EyeAngle: TJvSpinEdit;
    IrisWidth: TJvSpinEdit;
    IrisHeight: TJvSpinEdit;
    IrisPos: TJvSpinEdit;
    BrowAngle: TJvSpinEdit;
    HightlightType: TComboBox;
    BrowShape: TComboBox;
    Eyelid: TComboBox;
    MoleLEye: TCheckBox;
    MoleREye: TCheckBox;
    MoleLMouth: TCheckBox;
    MoleRMouth: TCheckBox;
    UpperEyelid: TComboBox;
    LowerEyelid: TComboBox;
    LipsticColor: TComboBox;
    LipsticOpa: TJvSpinEdit;
    FrontHairL: TJvSpinEdit;
    SideHairL: TJvSpinEdit;
    BackHairL: TJvSpinEdit;
    ExtHairL: TJvSpinEdit;
    FlipFrontHair: TCheckBox;
    FlipSideHair: TCheckBox;
    FlipBackHair: TCheckBox;
    FlipExtHair: TCheckBox;
    HairColor: TJvColorButton;
    LeftEyeColor: TJvColorButton;
    RightEyeColor: TJvColorButton;
    BrowColor: TJvColorButton;
    GlassesColor: TJvColorButton;
    FrontHair: TJvImageComboBox;
    SideHair: TJvImageComboBox;
    BackHair: TJvImageComboBox;
    ExtHair: TJvImageComboBox;
    Glasses: TJvImageComboBox;
    tabOutfits: TTabSheet;
    tOutfits: TJvTabControl;
    GroupBox17: TGroupBox;
    Label130: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    UType: TComboBox;
    Top1C: TJvColorButton;
    Top2C: TJvColorButton;
    Top3C: TJvColorButton;
    Top4C: TJvColorButton;
    Onepiece: TCheckBox;
    Undie: TCheckBox;
    Skirt: TCheckBox;
    GroupBox18: TGroupBox;
    Label133: TLabel;
    Label134: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    InShoes: TComboBox;
    OutShoes: TComboBox;
    InShoesC: TJvColorButton;
    OutShoesC: TJvColorButton;
    GroupBox19: TGroupBox;                                                                                                          
    Label131: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    SkirtLen: TComboBox;
    Bottom1C: TJvColorButton;
    Bottom2C: TJvColorButton;
    SkirtT: TJvSpinEdit;
    SkirtH: TJvSpinEdit;
    SkirtL: TJvSpinEdit;
    SkirtShdH: TJvSpinEdit;
    SkirtShdL: TJvSpinEdit;
    GroupBox21: TGroupBox;
    Label144: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    UndieC: TJvColorButton;
    UndieT: TJvSpinEdit;
    UndieH: TJvSpinEdit;
    UndieL: TJvSpinEdit;
    UndieShdH: TJvSpinEdit;
    UndieShdL: TJvSpinEdit;
    GroupBox20: TGroupBox;
    Label132: TLabel;
    Label145: TLabel;
    Socks: TComboBox;
    SocksC: TJvColorButton;
    tabBehavior: TTabSheet;
    tabRelationship: TTabSheet;
    tabLovers: TTabSheet;
    tabFeelings: TTabSheet;
    tabStatus: TTabSheet;
    DayName: TComboBox;
    DayWeek: TComboBox;
    TimeScreen: TComboBox;
    ClassName: TEdit;
    Year: TEdit;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Classess: TEdit;
    Label158: TLabel;
    SaveName: TEdit;
    Panel1: TPanel;
    checkGame: TJvTimer;
    routine: TJvTimerList;
    EGMin: TEdit;
    Label51: TLabel;
    EGSec: TEdit;
    cbTime: TCheckBox;
    GRisk: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label50: TLabel;
    RiskSunWeek1: TComboBox;
    RiskMonWeek1: TComboBox;
    RiskTueWeek1: TComboBox;
    RiskWedWeek1: TComboBox;
    RiskThuWeek1: TComboBox;
    RiskFriWeek1: TComboBox;
    RiskSatWeek1: TComboBox;
    RiskSunWeek2: TComboBox;
    RiskMonWeek2: TComboBox;
    RiskTueWeek2: TComboBox;
    RiskWedWeek2: TComboBox;
    RiskThuWeek2: TComboBox;
    RiskFriWeek2: TComboBox;
    RiskSatWeek2: TComboBox;
    FirstName: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    LastName: TEdit;
    Personality: TComboBox;
    Label16: TLabel;
    Label17: TLabel;
    Club: TComboBox;
    btnChangeClub: TButton;
    GroupBox9: TGroupBox;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label129: TLabel;
    Mood10: TJvSpinEdit;
    Mood11: TJvSpinEdit;
    Mood12: TJvSpinEdit;
    Mood13: TJvSpinEdit;
    Mood14: TJvSpinEdit;
    Mood15: TJvSpinEdit;
    Mood16: TJvSpinEdit;
    Mood17: TJvSpinEdit;
    Mood18: TJvSpinEdit;
    Mood20: TJvSpinEdit;
    Mood21: TJvSpinEdit;
    Mood22: TJvSpinEdit;
    setMoods: TJvSpinEdit;
    lstChar: TJvImageListBox;
    defAction: TJvLabel;
    defTo: TJvImage;
    defStatus: TJvImage;
    defRef: TJvImage;
    defRespon: TJvImage;
    defLocation: TJvLabel;
    defPersonal: TJvLabel;
    overlay: TJvPanel;
    JvImage1: TJvImage;
    thumbNPC: TPngImageList;
    gridRelationship: TJvStringGrid;
    cbGridMood: TComboBox;
    cbGridPoin: TJvSpinEdit;
    cbGridMax: TComboBox;
    cbGridLover: TComboBox;
    pGridRelationship: TPopupMenu;
    Love1: TMenuItem;
    Like1: TMenuItem;
    Dislike1: TMenuItem;
    Hate1: TMenuItem;
    N1: TMenuItem;
    LoveAll1: TMenuItem;
    LikeAll1: TMenuItem;
    DislikeAll1: TMenuItem;
    HateAll1: TMenuItem;
    N2: TMenuItem;
    FreezeAll1: TMenuItem;
    UnFreezeAll1: TMenuItem;
    gridBehavior: TJvStringGrid;
    pGridBehavior: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    gridFeeling: TJvStringGrid;
    cbGridCheck: TCheckBox;
    StringStore: TJvMultiStringHolder;
    gridLover: TJvStringGrid;
    gridStatus: TJvStringGrid;
    pMenuFreeze: TPopupMenu;
    MenuItem10: TMenuItem;
    pManualOpen: TJvFooter;
    EGTot: TEdit;
    pMisc: TJvRollOut;
    JvPageControl1: TJvPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ConfigPage: TJvPageControl;
    TabSheet21: TTabSheet;
    GroupBox15: TGroupBox;
    eReiPath: TEdit;
    Button3: TButton;
    GroupBox16: TGroupBox;
    cLowestVirtue: TCheckBox;
    cResetPregnant: TCheckBox;
    cDebug: TCheckBox;
    cDisableBackup: TCheckBox;
    cLowestVirtueSet: TComboBox;
    cAlphaBlendVal: TJvTrackBar;
    cAlphaBlend: TCheckBox;
    cDisableNPCEventFile: TCheckBox;
    cb_limitActionAll: TCheckBox;
    Panel9: TPanel;
    lst_limitAll: TListBox;
    cb_limitAll: TComboBox;
    btnLimitAddAll: TButton;
    btnLimitAddAllAct: TButton;
    btnLimitRemAll: TButton;
    btnLimitClearAll: TButton;
    autoPauseChar: TCheckBox;
    autoCreateClass: TCheckBox;
    cDisableInteractiveEvent: TCheckBox;
    TabSheet3: TTabSheet;
    GroupBox22: TGroupBox;
    DisplayShadow: TCheckBox;
    DisplayOutline: TCheckBox;
    DisplayCrosshair: TCheckBox;
    GroupBox24: TGroupBox;
    DisplayPlayer: TCheckBox;
    DisplayNPC: TCheckBox;
    DisplayPenis: TCheckBox;
    CameraAngle: TCheckBox;
    DisplayBGChar: TCheckBox;
    Display3D: TCheckBox;
    ClickFocus: TCheckBox;
    GroupBox25: TGroupBox;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    MonoMan: TCheckBox;
    MonoManRed: TJvTrackBar;
    MonoManGreen: TJvTrackBar;
    MonoManBlue: TJvTrackBar;
    MonoManOpa: TJvTrackBar;
    tabMiscSound: TTabSheet;
    gGeneralSound: TGroupBox;
    BGM: TCheckBox;
    Sound: TCheckBox;
    Voice: TCheckBox;
    HSound: TCheckBox;
    BGMVal: TJvTrackBar;
    SoundVal: TJvTrackBar;
    VoiceVal: TJvTrackBar;
    HSoundVal: TJvTrackBar;
    gVoiceSound: TGroupBox;
    JvScrollBox3: TJvScrollBox;
    pNPCVoice: TPanel;
    LVoice1: TLabel;
    LVoice2: TLabel;
    LVoice3: TLabel;
    LVoice4: TLabel;
    TabSheet23: TTabSheet;
    NPCConversion: TCheckBox;
    NPCConversionVal: TJvTrackBar;
    BGExternal: TCheckBox;
    ReleaseMouse: TCheckBox;
    PlayerMove: TCheckBox;
    PlayerMoveVal: TJvTrackBar;
    NPCMove: TCheckBox;
    NPCMoveVal: TJvTrackBar;
    WorldMove: TCheckBox;
    WorldMoveVal: TJvTrackBar;
    CustomBell: TCheckBox;
    CustomBellVal: TJvTrackBar;
    OverrideRisk: TCheckBox;
    OverrideRiskVal: TRadioGroup;
    OverrideCondom: TCheckBox;
    OverrideCondomVal: TRadioGroup;
    TabSheet24: TTabSheet;
    DisableInteractionNPCtoPlayer: TCheckBox;
    DisableInteruptionNPCtoPlayer: TCheckBox;
    DisableInteruptionNPCtoNPC: TCheckBox;
    DisableInteractionNPCtoNPC: TCheckBox;
    DisableInteractionAutoPCtoNPC: TCheckBox;
    DisableInteruptionAutoPCtoNPC: TCheckBox;
    DisableABUSEActions: TCheckBox;
    DisableViolenceActions: TCheckBox;
    DisableContestActions: TCheckBox;
    DisableNPCEscape: TCheckBox;
    DisableCOMMANDActions: TCheckBox;
    DisableJOINCLUBActions: TCheckBox;
    DisableBELOVERAction: TCheckBox;
    DisableBREAKUPAction: TCheckBox;
    DisableSKINSHIP: TCheckBox;
    DisableSEXAction: TCheckBox;
    DisableSexualExceptSex: TCheckBox;
    DisableEveryoneCommand: TCheckBox;
    DisableNPCGoingHome: TCheckBox;
    DisableNPCTraining: TCheckBox;
    TabSheet25: TTabSheet;
    LOVEorLIKEModPlayertoNPC: TCheckBox;
    PositiveRespontoPlayer: TCheckBox;
    LOVEorLIKEModPlayertoNPCVal: TJvTrackBar;
    DISLIKEorHATEModPlayertoNPC: TCheckBox;
    DISLIKEorHATEModPlayertoNPCVal: TJvTrackBar;
    LOVEorLIKEModNPCtoPlayer: TCheckBox;
    LOVEorLIKEModNPCtoPlayerVal: TJvTrackBar;
    DISLIKEorHATEModNPCtoPlayer: TCheckBox;
    DISLIKEorHATEModNPCtoPlayerVal: TJvTrackBar;
    LOVEorLIKEModNPCtoNPC: TCheckBox;
    LOVEorLIKEModNPCtoNPCval: TJvTrackBar;
    DISLIKEorHATEModNPCtoNPC: TCheckBox;
    DISLIKEorHATEModNPCtoNPCval: TJvTrackBar;
    SuccessfulTraining: TCheckBox;
    SkipHScane: TCheckBox;
    EveryoneHMood: TCheckBox;
    pCharList: TPopupMenu;
    PlaythisCharacter1: TMenuItem;
    N3: TMenuItem;
    SetLover1: TMenuItem;
    IgnorethisCharacter1: TMenuItem;
    N4: TMenuItem;
    AddtoPlanAction1: TMenuItem;
    AddtoFunMode1: TMenuItem;
    N5: TMenuItem;
    IgnorethisCharacter2: TMenuItem;
    SetLove1: TMenuItem;
    SetLike1: TMenuItem;
    SetDislike1: TMenuItem;
    SetHate1: TMenuItem;
    N6: TMenuItem;
    PersonalData1: TMenuItem;
    JvBalloonHint1: TJvBalloonHint;
    TabSheet4: TTabSheet;
    JvPageControl2: TJvPageControl;
    TabSheet5: TTabSheet;
    defWait: TJvImage;
    defYes: TJvImage;
    defEye: TJvImage;
    defChatTo: TJvImage;
    defMove: TJvImage;
    defChat: TJvImage;
    defNo: TJvImage;
    defHuh: TJvImage;
    defLovers: TJvImage;
    Label49: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label119: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    GroupBox8: TGroupBox;
    Label161: TLabel;
    Label162: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    LVoice5: TLabel;
    autoPC: TJvSwitch;
    featureTabs: TJvPageControl;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    gridFreeze: TJvStringGrid;
    Button2: TButton;
    Button4: TButton;
    Top1O: TJvTrackBar;
    Top2O: TJvTrackBar;
    Top3O: TJvTrackBar;
    Top4O: TJvTrackBar;
    UndieO: TJvTrackBar;
    InShoesO: TJvTrackBar;
    OutShoesO: TJvTrackBar;
    SocksO: TJvTrackBar;
    Bottom1O: TJvTrackBar;
    Bottom2O: TJvTrackBar;
    Panel3: TPanel;
    lstCharAct: TJvImageListBox;
    progress: TJvSpecialProgress;
    loadTrainer: TJvTimer;
    Panel5: TPanel;
    readClass: TButton;
    globalEvenLogs: TJvMemo;
    panelAction: TPanel;
    pSplit: TJvNetscapeSplitter;
    pActionBox: TJvScrollBox;
    pActionContent: TPanel;
    gActionRight: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label94: TLabel;
    Label128: TLabel;
    Label163: TLabel;
    IntructionTime: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label168: TLabel;
    Status: TComboBox;
    Action: TComboBox;
    DestLoc: TComboBox;
    ActRespon: TComboBox;
    setNPC: TComboBox;
    btnPlanAct: TButton;
    btnTerminateAct: TButton;
    cLoopAct: TCheckBox;
    btnForceStop: TButton;
    cForceAct: TCheckBox;
    ActionRefNPC: TComboBox;
    cRunShuffled: TCheckBox;
    cForcePerform: TCheckBox;
    gActionLeft: TJvPageControl;
    tp_action: TTabSheet;
    tp_limit: TTabSheet;
    Label181: TLabel;
    cb_limitAct: TComboBox;
    btnLimitAct: TButton;
    lst_limitAct: TListBox;
    btnLimitRem: TButton;
    btnLimitClear: TButton;
    btnLimitCopy: TButton;
    btnLimitPaste: TButton;
    btnLimitActAll: TButton;
    eventNote: TJvMemo;
    PactionList: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    SortByFrozenButton: TButton;
    SortByDescriptionButton: TButton;
    SortByAddressButton: TButton;
    SortByTypeButton: TButton;
    SortByValueButton: TButton;
    ScrollBox1: TScrollBox;
    HeaderControl1: THeaderControl;
    pPlanItems: TPanel;
    vscrollpanel: TPanel;
    ActScrollbar: TScrollBar;
    pPlanActions: TPopupMenu;
    Add1: TMenuItem;
    N7: TMenuItem;
    AddPlan1: TMenuItem;
    N8: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Clear1: TMenuItem;
    ClearAll1: TMenuItem;
    N10: TMenuItem;
    PausePlanAction1: TMenuItem;
    openDlg: TJvOpenDialog;
    saveDlg: TJvSaveDialog;
    pMainGame: TPopupMenu;
    LoadAllData1: TMenuItem;
    SaveAllData1: TMenuItem;
    GroupBox4: TGroupBox;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    FirstSex: TEdit;
    FirstAnal: TEdit;
    LastSex: TEdit;
    GroupBox7: TGroupBox;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Lover: TEdit;
    Friend: TEdit;
    Sexual: TEdit;
    GroupBox5: TGroupBox;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Victory: TJvSpinEdit;
    ClassSkip: TJvSpinEdit;
    WinningOver: TJvSpinEdit;
    Partner: TJvSpinEdit;
    Rejected: TJvSpinEdit;
    SexIntercouse: TJvSpinEdit;
    SexPartner: TJvSpinEdit;
    Label180: TLabel;
    freezeTot: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    lowestStatus: TLabel;
    cStayOnTop: TCheckBox;
    TabSheet9: TTabSheet;
    pIgnoredNPC: TJvPanel;
    defIgnoreNPC: TJvSpeedButton;
    Label184: TLabel;
    JvImage2: TJvImage;
    Label185: TLabel;
    btnClearAct: TButton;
    btnCopyAct: TButton;
    btnPasteAct: TButton;
    cHeadAction: TComboBox;
    Label186: TLabel;
    gridFunMode: TJvListView;
    pFunMode: TPopupMenu;
    FunAction1: TMenuItem;
    N9: TMenuItem;
    forcedAction: TMenuItem;
    N11: TMenuItem;
    PauseTimer1: TMenuItem;
    pColor: TPopupMenu;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    colorDlg: TJvFullColorDialog;
    FullColorMode1: TMenuItem;
    N12: TMenuItem;
    cHeadForceAction: TComboBox;
    folderDlg: TJvBrowseForFolderDialog;
    N13: TMenuItem;
    closeData: TMenuItem;
    N14: TMenuItem;
    Exit2: TMenuItem;
    Panel10: TPanel;
    randomAction: TCheckBox;
    randomActionTime: TJvTrackBar;
    Label187: TLabel;
    ShowSeatOnly1: TMenuItem;
    N15: TMenuItem;
    emptys: TJvImage;
    locationThumb: TPngImageList;
    defLocThumb: TJvImage;
    N16: TMenuItem;
    CancelCurrentAction1: TMenuItem;
    disableAutoMode: TCheckBox;
    defSeatNo: TJvLabel;
    cResetPregnantVal: TComboBox;
    FreezeRelationship1: TMenuItem;
    tabPromise: TTabSheet;
    gMeetPromiseTo: TJvListView;
    gLewdPromiseTo: TJvListView;
    gDatePromiseTo: TJvListView;
    Button1: TButton;
    pRandomAction: TJvCaptionPanel;
    randomActionVal: TListBox;
    randomActionSel: TComboBox;
    Button6: TButton;
    Button5: TButton;
    Button8: TButton;
    Button9: TButton;
    pChangeClub: TJvCaptionPanel;
    Club1Name: TEdit;
    Club1Type: TComboBox;
    Club2Name: TEdit;
    Club2Type: TComboBox;
    Club3Name: TEdit;
    Club3Type: TComboBox;
    Club4Name: TEdit;
    Club4Type: TComboBox;
    Club5Name: TEdit;
    Club5Type: TComboBox;
    Club6Name: TEdit;
    Club6Type: TComboBox;
    Club7Name: TEdit;
    Club7Type: TComboBox;
    Button7: TButton;
    Club8Name: TEdit;
    Club8Type: TComboBox;
    gMeetPromiseFrom: TJvListView;
    gLewdPromiseFrom: TJvListView;
    gDatePromiseFrom: TJvListView;
    defClub: TJvLabel;
    defIgnore: TJvImage;
    defLove: TJvImage;
    defFeels: TJvLabel;
    cdefOLove: TPanel;
    cdefOLike: TPanel;
    cdefODislike: TPanel;
    cdefOHate: TPanel;
    cdefONever: TPanel;
    cdefBFemale: TPanel;
    cdefBMale: TPanel;
    cdefBTeacher: TPanel;
    cdefBPlayed: TPanel;
    cdefTHetro: TPanel;
    cdefTLHetro: TPanel;
    cdefTBisex: TPanel;
    cdefTLHomo: TPanel;
    cdefTHomo: TPanel;
    cdefBEmpty: TPanel;
    Label188: TLabel;
    cdefOSelSeat: TPanel;
    asdadsad: TLabel;
    Label189: TLabel;
    cdefOSeat: TPanel;
    Label190: TLabel;
    ViewType1: TMenuItem;
    CharacterToOther: TMenuItem;
    OtherToCharacter1: TMenuItem;
    pPasteBin: TJvCaptionPanel;
    lstBin: TJvImageListBox;
    pPasteBinData: TPopupMenu;
    CopyCharacterData1: TMenuItem;
    ViewCharacterData1: TMenuItem;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    cpbinbase: TCheckBox;
    cpbinoutfit: TCheckBox;
    Button13: TButton;
    cpbinbody: TCheckBox;
    cPCIsInteract: TCheckBox;
    cNPCIsInteract: TCheckBox;
    Label191: TLabel;
    profile: TMemo;
    ExtHTexture: TCheckBox;
    ExtIrisTexture: TCheckBox;
    ExtIrisTextureName: TEdit;
    ExtHTextureName: TEdit;
    N17: TMenuItem;
    SaveAllData2: TMenuItem;
    LoadBinData1: TMenuItem;
    CopyAllCharacter1: TMenuItem;
    N18: TMenuItem;
    CharRawData: TTabSheet;
    gGameData1: TJvStringGrid;
    gameData1: TComboBox;
    gameData2: TComboBox;
    gameDataSeat: TComboBox;
    gGameData2: TJvStringGrid;
    pConsole: TJvCaptionPanel;
    GroupBox10: TGroupBox;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    Label195: TLabel;
    ledGame: TJvLED;
    ledClassOpen: TJvLED;
    ledClassCreate: TJvLED;
    ledRedrawSeat: TJvLED;
    ledPauseTimer: TJvLED;
    Label196: TLabel;
    Label197: TLabel;
    ledRead: TJvLED;
    Label198: TLabel;
    ledWrite: TJvLED;
    keyConsole: TJvHotKey;
    keyAutoPC: TJvHotKey;
    GroupBox11: TGroupBox;
    Label199: TLabel;
    actTimerActive: TLabel;
    lblMaxChar: TLabel;
    Label201: TLabel;
    Label200: TLabel;
    ledCheckGame: TJvLED;
    pOutfit: TPopupMenu;
    CopyOutfit1: TMenuItem;
    PasteOutfit1: TMenuItem;
    Label202: TLabel;
    ledRefData: TJvLED;
    Label203: TLabel;
    ledFreeze: TJvLED;
    Label204: TLabel;
    ledLowest: TJvLED;
    Label205: TLabel;
    LedGameT: TJvLED;
    Label206: TLabel;
    ledDelay: TJvLED;
    randomTarget: TCheckBox;
    randomToPlayer: TCheckBox;
    N19: TMenuItem;
    ExportCard1: TMenuItem;
    { OWN FUNCTION }
    procedure hit_me (var msg : twmnchittest);
    message wm_nchittest;
    procedure selectedNPC(Sender: TObject);
    procedure selectedNPCDblClick(Sender: TObject);
    procedure selectedNPCW(Sender: TObject);
    procedure selectedNPCDblClickW(Sender: TObject);
    procedure getEvent(Sender: TObject); virtual;
    procedure getPlanAction(Sender: TObject); virtual;
    procedure getActions(Sender: TObject); virtual;
    procedure setCompPause(Sender: TObject);
    procedure setCompResume(Sender: TObject);
    procedure setCompValue(Sender: TObject);
    procedure setCompCboxValue(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure setCompEditDownValue(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure setCompEditValue(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGridDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGridScroll(Sender: TObject);
    procedure StringGridClick(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure StringGridShowEditor(Sender: TJvStringGrid; ACol,
      ARow: Integer; var AllowEdit: Boolean);
    procedure StringGridContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure StringGridPopupClick(Sender: TObject);
    procedure ManageFreezeData(Sender: TObject);
    procedure setCharList(Sender: TObject);
    procedure menuContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure VoiceConfigTips(Sender: TObject;
      var ToolTipText: String);
    procedure voiceConfigChange(Sender: TObject);
    procedure voiceConfigChanged(Sender: TObject);
    procedure planSelected(sender: TObject);
    procedure planChange(sender: TObject);
    procedure planMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure planRemoveButton(Sender: TObject);
    procedure planHeaderClick(HeaderControl: THeaderControl; Section: THeaderSection);
    procedure ignoreNPCClick(sender:TObject);
    procedure doHotKey(Sender:TObject);
    procedure StringGridCaptionClick(Sender: TJvStringGrid; AColumn,
      ARow: Integer);
    { END OWN FUNCTION}
    procedure FormCreate(Sender: TObject);
    procedure readClassClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabsChange(Sender: TObject);
    procedure checkGameTimer(Sender: TObject);
    procedure routineEvents0Timer(Sender: TObject);
    procedure cDisableInteractiveEventMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure routineEvents1Timer(Sender: TObject);
    procedure routineEvents2Timer(Sender: TObject);
    procedure PersonalData1Click(Sender: TObject);
    procedure ConfigPageChange(Sender: TObject);
    procedure cbTimeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure routineEvents3Timer(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure btnChangeClubClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure loadTrainerTimer(Sender: TObject);
    procedure autoPCClick(Sender: TObject);
    procedure ActScrollbarChange(Sender: TObject);
    procedure btnPlanActClick(Sender: TObject);
    procedure personalDataExpand(Sender: TObject);
    procedure lstCharActClick(Sender: TObject);
    procedure btnTerminateActClick(Sender: TObject);
    procedure cLoopActMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure ClearAll1Click(Sender: TObject);
    procedure PausePlanAction1Click(Sender: TObject);
    procedure IgnorethisCharacter2Click(Sender: TObject);
    procedure LoadAllData1Click(Sender: TObject);
    procedure SaveAllData1Click(Sender: TObject);
    procedure btnLimitActClick(Sender: TObject);
    procedure btnLimitActAllClick(Sender: TObject);
    procedure btnLimitCopyClick(Sender: TObject);
    procedure btnLimitPasteClick(Sender: TObject);
    procedure btnLimitRemClick(Sender: TObject);
    procedure btnLimitClearClick(Sender: TObject);
    procedure btnLimitAddAllClick(Sender: TObject);
    procedure btnLimitAddAllActClick(Sender: TObject);
    procedure btnLimitRemAllClick(Sender: TObject);
    procedure btnLimitClearAllClick(Sender: TObject);
    procedure routineEvents4Timer(Sender: TObject);
    procedure AddtoPlanAction1Click(Sender: TObject);
    procedure cHeadActionChange(Sender: TObject);
    procedure cHeadActionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnForceStopClick(Sender: TObject);
    procedure cAlphaBlendValChanged(Sender: TObject);
    procedure cStayOnTopClick(Sender: TObject);
    procedure FunAction1Click(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure gridFunModeColumnClick(Sender: TObject; Column: TListColumn);
    procedure cHeadForceActionChange(Sender: TObject);
    procedure cHeadForceActionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button4Click(Sender: TObject);
    procedure featureTabsChange(Sender: TObject);
    procedure gridFunModeItemDblClick(Sender: TObject; Item: TListItem;
      SubItemIndex, X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure closeDataClick(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure ShowSeatOnly1Click(Sender: TObject);
    procedure AddtoFunMode1Click(Sender: TObject);
    procedure CancelCurrentAction1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure pChangeClubButtonClick(Sender: TObject;
      Button: TJvCapBtnStyle);
    procedure cdefOLoveDblClick(Sender: TObject);
    procedure setMoodsChange(Sender: TObject);
    procedure gridRelationshipMouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure lstBinClick(Sender: TObject);
    procedure CopyCharacterData1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure gameData1Change(Sender: TObject);
    procedure pConsoleButtonClick(Sender: TObject; Button: TJvCapBtnStyle);
    procedure routineEvents5Timer(Sender: TObject);
    procedure CopyOutfit1Click(Sender: TObject);
    procedure PasteOutfit1Click(Sender: TObject);
  private
    { Private declarations }
    seatColor: TSeatColor;
    freezeCBox: array [0..24] of TFreezeCBox;
    senderGrid: TSenderGrid;
    PlanItems: TPlanItems;
    PlayerAct: TPlayerAction;
    ForcedAct: TForcedAct;
    counter, counterDelay, gameStateID, gameStateOldID, lastTimeScreen: integer;
    trainerReady, initGames, gameReady, gameRunning, firstRun, runOnce,
    classExist, classReady, initClass,
    pauseNPCTimer, isReadData, isWriteData, disableInteractiveEvent, respawnSeat, skipAutoBackup,
    isBinView: boolean;

    getTimes, freezeTime, lastSaveData, SaveGameName, lstActName: string;

    HEXAClothF, HEXAClothFF, HEXAClothM, HEXAClothMM, LimitCopy: TStringList;

    gridToCharID, behaviorTotal: array of integer;
    playedCharAddress, targetCharAddress, AutoPCAddress, classNameAddress, timeAddress, timeStateAddress: dword;

    tempOutfitSet: boolean;
    tempOutfit: array [0..37] of string;

    procedure checkGames;
    procedure getGameScreen;

    procedure resetAllComponent;
    procedure setDefault;
    procedure setOverlay(const showing: boolean = true);

    procedure manageConfig(const save: boolean = false);
    procedure generateCode;
    procedure setReiComponent;
    procedure setComponent;
    procedure prepareTrainer;
    procedure initTrainer;
    procedure checkClassChange;
    procedure manageClass(const readClass: boolean = true; const hideOverlay: boolean = false; const forceAuto: boolean = false);

    procedure planRemoveItem;
    procedure planAddItem(const isDefault: boolean = true);
    procedure planRefreshItem;

    procedure initTabComponent;
    procedure initMainAddress;

    procedure createThumbList;

    procedure clearGridID;
    procedure configTabs;
    procedure setBinData(fieldName,value: string);
    function getBinData(fieldName: string; const isNumber: boolean = false; const isNull: boolean = false): string;
    procedure parseBinCode;
    procedure parseTabCode;
    procedure initTabCode;
    procedure redrawSeatBox;
    procedure loadCharacter;
    procedure MainGameData;
    procedure StringGridHideEditor;
    procedure PopupGridSetValue(codeType, codeIndex: integer; value: string; const Rows: integer = -1);
    procedure StringGridSetValue(codeType: integer; value: string);

    function checkClassExist: boolean;

    procedure manageTimer(enabled: boolean = true);

    procedure parseSenderData(sender: TObject);
    function validateValue: boolean;

    procedure menuFreezeChecked(MenuItem: TMenuItem; codeType: string);
    procedure showCharMenu;

    procedure playedCharacter(const setPlay: boolean = false);
    procedure autoMode(const setAuto: boolean = false);

    procedure refreshCharacterSeat;
    procedure getClubName;

    procedure initPlanAction;
    procedure LoadPlanAction(const fileName: string = ''; const overide: boolean = false);
    procedure SavePlanAction(const fileName: string = ''; const overide: boolean = false);
    procedure limitActionAll(state: TAppState);
    procedure limitAction(state: TAppState);

    procedure manageRandomAction(state: TAppState; const SeatID: integer=-1; const actived: boolean = false); virtual;
    procedure manageForceAction(state: TAppState; const SeatID: integer=-1; const actived: boolean = false); virtual;
    procedure manageClipboardColor(state: TAppState);
    procedure manageOutfits(state: TAppState);

    procedure npcAction;
    procedure playerAction;
    procedure resetplayerAct;
    procedure resetPragnantEndWeek;

    procedure seatMode(const showed: boolean = true);

    procedure generateEventLogs;

    procedure getBehaviorTotal(const charID: integer = -1);
    function getRandomFeeling(relID,charID,toCharID: integer): string;

    procedure resizeForm;
    procedure pasteBinRefresh;

    procedure setHotkey;
  public
    { Public declarations }
    senderData: TSenderData;
    clipboardColor: TClipboardColor;
    REIPersonality: TStringList;
    NPCListName   : TStrings;
    PlanActionName: TStrings;
    FreezeGroupCount: integer;
    function managePlanAction(state: TAppState; const actived: boolean = true; const seatno: integer = -1; const toSeat: integer = -1): boolean; virtual;
  end;

const
  appTitle: string = 'AA2Trainer';
  NPCEventFile: string = 'Events_';
  ConfigFile: string = 'config.dat';
  backUpFile: string = 'autoBackup.dat';
  tabTagRange: integer = 1000;
  configTagRange: integer = 20000;
  GameAddress: dword = $00376164;
  cBoxColF: array [3..4] of integer = (1,1); // for freeze checkbox col

  setLove   : array [0..9] of string = ('0','0','2','2','2','30','30','0','0','0');
  setLike   : array [0..9] of string = ('1','2','0','2','2','30','0','30','0','0');
  setDislike: array [0..9] of string = ('2','2','2','0','2','30','0','0','30','0');
  setHate   : array [0..9] of string = ('3','2','2','2','0','30','0','0','0','30');

var
  MainForm: TMainForm;
  core: TCore;
  appDir: string;
  trainerCaption: string;

implementation

uses HelperGeneral, UData, UMemoryHelper, UPNGHelper, UMemory, USelAction,
  UColor, StrUtils;

{$R *.dfm}

procedure TMainForm.hit_me(var msg:twmnchittest);
begin
 inherited;
 if (msg.Result = htclient) then
  if msg.Ypos <= top + pClass.Height then
   msg.Result := htcaption;
end;

procedure TMainForm.doHotKey(Sender:TObject);
begin
  case (Sender as TJvApplicationHotKey).Tag of
    1: begin
      pConsole.Top:= ceil(MainForm.Height/2)-ceil(pConsole.Height/2);
      pConsole.Left:= ceil(MainForm.Width/2)-ceil(pConsole.Width/2);
      pConsole.Visible:= true;
    end;
    2: begin
      if autoPC.StateOn then autoPC.StateOn:= false
      else autoPC.StateOn:= true;
      autoMode(true);
    end;
  end;
end;

procedure TMainForm.setHotKey;
var
  AppTop, ModePC: TJvApplicationHotKey;
begin
  AppTop:= TJvApplicationHotKey.Create(self);
  with AppTop do
  begin
    Tag    := 1;
    HotKey := keyConsole.HotKey;
    Active := true;
    OnHotKey := doHotKey;
  end;
  ModePC:= TJvApplicationHotKey.Create(self);
  with ModePC do
  begin
    Tag    := 2;
    HotKey := keyAutoPC.HotKey;
    Active := true;
    OnHotKey := doHotKey;
  end;
end;

procedure TMainForm.seatMode(const showed: boolean = true);
begin
  if showed then
  begin
    pMisc.Visible:= false;
    personalData.Visible:= false;
    actionData.Visible:= false;
    statusBar.Visible:= false;
    header.Visible:= false;
    MainForm.Constraints.MinWidth:= 969;
    MainForm.Constraints.MinHeight:= 492;
    MainForm.ClientWidth:= 969;
    MainForm.ClientHeight:= 492;
    //MainForm.BorderStyle:= bsNone;
    wrap.Top:= 0;
    wrap.Left:= 0;
    wrap.Align:= alClient;
    container.Align:= alClient;
    container.Top:= 0;
    container.Left:= 0;
    pclass.Left:= 0;
  end else
  begin
    MainForm.Width:= 1016;
    MainForm.Height:= 633;
    MainForm.Constraints.MinWidth:= 1014;
    MainForm.Constraints.MinHeight:= 633;
    //MainForm.BorderStyle:= bsSingle;
    wrap.Align:= alNone;
    wrap.Top:= 8;
    wrap.Left:= 8;
    wrap.Width:= 990;
    wrap.Height:= 569;
    container.Align:= alNone;
    container.Top:= 33;
    container.Height:= 536;
    container.Width:= 989;
    pclass.Left:= 22;
    pMisc.Visible:= true;
    actionData.Visible:= true;
    personalData.Visible:= true;
    statusBar.Visible:= true;
    header.Visible:= true;
  end;
end;

procedure TMainForm.manageOutfits(state: TAppState);
var i, start: integer;
begin
  if (core.selectedSeat=-1) then exit;

  case tOutfits.TabIndex of
    0: start:= 191;
    1: start:= 229;
    2: start:= 267;
    3: start:= 305;
  end;

  case state of
    IsCopy: begin
      for i:= 0 to 37 do
        tempOutfit[i]:= core.GameData.getRegenValue(1,core.selectedChar,(i+start),false,-1,0);
      tempOutfitSet:= true;
    end;
    IsPaste: if not(tempOutfitSet) then showmessage('Copy outfit first!')
      else for i:= 0 to 37 do
        core.GameData.setRegenValue(1,core.selectedChar,(i+start),tempOutfit[i],-1,0);
  end;
end;

procedure TMainForm.manageClipboardColor(state: TAppState);
var
  i: integer;
begin
  case state of
    IsAdd:
    begin
      colorDlg.FullColor:= colorBin.convertColor(0,clipboardColor.tempColor);
      if colorDlg.Execute then
      for i:= 0 to ComponentCount-1 do
      if (Components[i].Name = clipboardColor.tempName) then
      begin
        if (Components[i] is TJvColorButton) then TJvColorButton(Components[i]).Color:= colorDlg.FullColor
        else if (Components[i] is TPanel) then TPanel(Components[i]).Color:= colorDlg.FullColor;
        break;
      end;
    end;
    IsCopy:
    begin
      if (clipboardColor.LastIndex>11) then clipboardColor.LastIndex:= 0;
      clipboardColor.Name[clipboardColor.LastIndex]:= clipboardColor.tempName;
      clipboardColor.Color[clipboardColor.LastIndex]:= clipboardColor.tempColor;
      inc(clipboardColor.LastIndex);
    end;
    IsPaste:
    begin
      clipboardColor.setColor:= false;
      colorBin.ShowModal;
      if clipboardColor.setColor then
      for i:= 0 to ComponentCount-1 do
      if (Components[i].Name = clipboardColor.tempName) then
      begin
        if (Components[i] is TJvColorButton) then TJvColorButton(Components[i]).Color:= clipboardColor.tempColor
        else if (Components[i] is TPanel) then TPanel(Components[i]).Color:= clipboardColor.tempColor;
        break;
      end;
    end;
  end;
end;

{ =============================================================== PLAN ACTION =============================================================== }
{
  random method
  - each timer must doing random mod to decide when do action
  - then
}
procedure TMainForm.manageRandomAction(state: TAppState; const seatID: integer=-1; const actived: boolean = false);
const maxRand: integer = 100;
var
  randCharID,randNum,randBall,randLogic: integer;
begin
  // played character do not doing random action
  if not(randomToPlayer.Checked) AND (seatID=core.playedSeat) then exit;
  //not(autoPC.StateOn) AND 

  case state of
    // decide if npc doing random action
    IsNavControl: if not(SeatID=-1) then
      if not(randomAction.Checked) OR (randomActionVal.Count=0) then manageRandomAction(IsClear,SeatID) else
      begin
        if not(core.ClassSeat[seatID].randomAction.isChoice) then
        if (counter mod randomActionTime.Position=0) AND not(core.ClassSeat[seatID].randomAction.setChoice) then
        begin
          core.ClassSeat[seatID].randomAction.setChoice:= true;

          randNum  := RandomRange(0,maxRand);
          randBall := ceil(maxRand/2);
          randLogic:= randomRange(0,1);
          case randLogic of
            0: if (randNum<randBall) then core.ClassSeat[seatID].randomAction.isChoice:= true;
            else if (randNum>=randBall) then core.ClassSeat[seatID].randomAction.isChoice:= true;
          end;

          core.ClassSeat[seatID].randomAction.setChoice:= false;
        end;

        if core.ClassSeat[seatID].randomAction.isChoice then
          manageRandomAction(IsAppControl,seatID);
      end;
    // prepare to random action
    IsAppControl: if not(SeatID=-1) then
      if not(randomAction.Checked) then manageRandomAction(IsClear,SeatID) else
      if core.ClassSeat[seatID].randomAction.isChoice AND not(core.ClassSeat[seatID].randomAction.SetMod) then
      begin
        core.ClassSeat[seatID].randomAction.SetMod:= true;
        core.ClassSeat[seatID].randomAction.ValMod:= RandomRange(50,500);

        randCharID:= -1;
        while ((randCharID=-1) OR (not(randomToPlayer.Checked) AND (randCharID=core.playedChar)) OR (randCharID=core.getCharID(seatID))) do
          randCharID:= RandomFrom(core.SeatID);

        core.ClassSeat[seatID].randomAction.toCharID:= randCharID;
        core.ClassSeat[seatID].randomAction.toSeat:= core.getSeatID(randCharID);
        core.ClassSeat[seatID].randomAction.toAddress:= core.NPCTargetAddress[core.ClassSeat[seatID].randomAction.toSeat];
        core.ClassSeat[seatID].randomAction.Action:= strtoint(randomActionVal.Items.Names[randomRange(0,randomActionVal.Count-1)]);
        if (core.ClassSeat[seatID].randomAction.Action in [81,82]) then core.ClassSeat[seatID].randomAction.KillerMode:= true;
        core.ClassSeat[seatID].randomAction.Active:= false;
      end else
      if (counter mod core.ClassSeat[seatID].randomAction.ValMod=0) and not(core.ClassSeat[seatID].randomAction.Active) then
        core.ClassSeat[seatID].randomAction.Active:= true;

    IsValidate: if not(SeatID=-1) then
      if not(randomAction.Checked) or (randomActionVal.Count=0) then manageRandomAction(IsClear,SeatID) else
      // don't mess with plan action is absolute
      if not(core.ClassSeat[SeatID].planAction.runOnAction) AND core.ClassSeat[seatID].randomAction.isChoice AND core.ClassSeat[seatID].randomAction.Active then
      case core.getNPCState(SeatID) of
        IsGoingInteract:
        begin
          // cancel if not effect to player
          if (not(randomToPlayer.Checked) AND (core.ClassSeat[seatID].actions.toSeat=core.playedSeat)) then
          begin
            manageRandomAction(IsClear,SeatID);
            exit;
          end;

          if core.ClassSeat[seatID].randomAction.KillerMode then
            if not(core.getCharAction(seatID,ActLucky)='1') then
            begin
              core.GameData.setValue('1',core.ClassSeat[seatID].actAddress.lucky,1);
              core.ClassSeat[seatID].randomAction.isLucky:= true;
            end;

          // effect to random target
          if randomTarget.Checked then
          begin
            if not(core.ClassSeat[seatID].actions.ToSeatAddr=core.ClassSeat[seatID].randomAction.toAddress) then
            begin
              core.GameData.setValue(core.ClassSeat[seatID].randomAction.toAddress,core.ClassSeat[seatID].actAddress.target,4);
              core.ClassSeat[seatID].actions.ToSeat    := core.ClassSeat[seatID].randomAction.toSeat;
              core.ClassSeat[seatID].actions.ToSeatAddr:= core.ClassSeat[seatID].randomAction.toAddress;
              core.ClassSeat[seatID].actions.cancelIsRun:= true;
            end;
          end else
          begin
            core.ClassSeat[seatID].randomAction.toSeat    := core.ClassSeat[seatID].actions.toSeat;
            core.ClassSeat[seatID].randomAction.toAddress := core.ClassSeat[seatID].actions.ToSeatAddr;
          end;
          
          if not(core.ClassSeat[seatID].actions.Action=core.ClassSeat[seatID].randomAction.Action) then
          begin
            core.ClassSeat[seatID].actions.cancelType:= '[RAC]';
            core.GameData.setValue(inttostr(core.ClassSeat[seatID].randomAction.Action),core.ClassSeat[seatID].actAddress.action,4);
            core.ClassSeat[seatID].actions.Action    := strtoint64(core.getCharAction(seatID,ActAction,true));
            core.ClassSeat[seatID].actions.cancelIsRun:= true;
          end;
        end;
        IsDecide: if (core.ClassSeat[seatID].actions.ToSeatAddr=core.ClassSeat[seatID].randomAction.toAddress) AND
          not(core.ClassSeat[seatID].actions.Action=core.ClassSeat[seatID].randomAction.Action) then
          begin
            core.ClassSeat[seatID].actions.cancelType:= '[RAC]';
            core.GameData.setValue(inttostr(core.ClassSeat[seatID].randomAction.Action),core.ClassSeat[seatID].actAddress.action,4);
            core.ClassSeat[seatID].actions.Action    := strtoint64(core.getCharAction(seatID,ActAction,true));
          end;
        IsChat: if (core.ClassSeat[seatID].actions.ToSeatAddr=core.ClassSeat[seatID].randomAction.toAddress) then core.ClassSeat[seatID].randomAction.trigger:= true;
        IsIdle,IsStalking: if not(core.ClassSeat[seatID].actions.ToSeatAddr=core.ClassSeat[seatID].randomAction.toAddress) then manageRandomAction(IsClear,SeatID);
      end;

    IsClear: if not(SeatID=-1) then
    if core.ClassSeat[seatID].randomAction.killerMode AND core.ClassSeat[seatID].randomAction.trigger then
    begin
      if (TimeScreen.ItemIndex=0) then
      begin
        if core.ClassSeat[seatID].randomAction.isLucky then core.GameData.setValue('0',core.ClassSeat[seatID].actAddress.lucky,1);
        manageRandomAction(IsClearAll,SeatID);
      end else
      if not(randomAction.Checked) then manageRandomAction(IsClearAll,SeatID);
    end else manageRandomAction(IsClearAll,SeatID);
    IsClearAll: if not(SeatID=-1) then
    if not(core.ClassSeat[seatID].randomAction.toSeat=-1) then //core.ClassSeat[seatID].randomAction.SetMod then
    begin
      core.ClassSeat[seatID].randomAction.Active:= false;
      core.ClassSeat[seatID].randomAction.SetMod:= false;
      core.ClassSeat[seatID].randomAction.setChoice:= false;
      core.ClassSeat[seatID].randomAction.isChoice:= false;
      core.ClassSeat[seatID].randomAction.toCharID:= -1;
      core.ClassSeat[seatID].randomAction.toSeat  := -1;
      core.ClassSeat[seatID].randomAction.toAddress:= '0';
      core.ClassSeat[seatID].randomAction.Action  := -1;
      core.ClassSeat[seatID].randomAction.trigger:= false;
      core.ClassSeat[seatID].randomAction.KillerMode:= false;
      core.ClassSeat[seatID].randomAction.killerDay:= -1;
      core.ClassSeat[seatID].randomAction.isLucky:= false;
    end;
  end;
end;

procedure TMainForm.manageForceAction(state: TAppState; const seatID: integer=-1; const actived: boolean = false);
var
  i, actID, seatNumber, charID: integer;
begin
  if not(state in [IsAppControl]) AND (core.getCharID(SeatID)=-1) then exit;

  case state of
    IsValidate: if not(SeatID=-1) AND not(not(autoPC.StateOn) AND (seatID=core.playedSeat)) then
    // don't mess with plan action is absolute
    if not(core.ClassSeat[SeatID].planAction.runOnAction) AND (core.getNPCState(SeatID) in [IsDecide,IsGoingInteract]) then
    begin
      if ForcedAct.Active then
      begin
        seatNumber:= ForcedAct.seatNumber;
        if not(seatNumber=-1) AND not(seatNumber=seatID) AND core.ClassSeat[seatNumber].forceAction.Active AND
          not(ForcedAct.seatNumber=-1) then
        begin
          if not(core.ClassSeat[seatID].actions.ToSeatAddr=ForcedAct.NPCAddress) then
          begin
            core.GameData.setValue(ForcedAct.NPCAddress,core.ClassSeat[seatID].actAddress.target,4);
            core.ClassSeat[seatID].actions.ToSeat    := seatNumber;
            core.ClassSeat[seatID].actions.ToSeatAddr:= ForcedAct.NPCAddress;
            core.ClassSeat[seatID].actions.cancelIsRun:= true;
          end;

          if not(core.ClassSeat[seatID].actions.Action=ForcedAct.Action) then
          begin
            core.ClassSeat[seatNumber].actions.cancelType:= '[FAF]';
            core.GameData.setValue(inttostr(ForcedAct.Action),core.ClassSeat[seatID].actAddress.action,4);
            core.ClassSeat[seatID].actions.Action    := ForcedAct.Action;
            core.ClassSeat[seatID].actions.cancelIsRun:= true;
          end;
        end;
      end else
      begin
        seatNumber:= core.ClassSeat[SeatID].actions.ToSeat;
        if not(seatNumber=-1) AND not(seatNumber=seatID) AND core.ClassSeat[seatNumber].forceAction.Active then
          if not(core.ClassSeat[SeatID].actions.Action=core.ClassSeat[seatNumber].forceAction.Action) then
          begin
            core.ClassSeat[seatNumber].actions.cancelType:= '[FAC]';
            core.GameData.setValue(inttostr(core.ClassSeat[seatNumber].forceAction.Action),core.ClassSeat[SeatID].actAddress.action,4);
            core.ClassSeat[seatID].actions.Action    := core.ClassSeat[seatNumber].forceAction.Action;
            core.ClassSeat[seatID].actions.cancelIsRun:= true;
          end;
      end;
    end;
    IsClearAll: if not(seatID=-1) then
    begin
      ForcedAct.Active    := actived;
      ForcedAct.seatNumber:=-1;
      ForcedAct.Action    :=-1;
      ForcedAct.NPCAddress:= '0';
      for i:= 0 to 24 do
      begin
        seatNumber:= seatIndex[i];
        charID:= core.getCharID(seatNumber);
        if not(charID=-1) then
          if actived AND (seatNumber=senderData.seatNumber) then
          begin
            ForcedAct.seatNumber:=seatNumber;
            ForcedAct.Action    :=core.ClassSeat[seatNumber].forceAction.Action;
            ForcedAct.NPCAddress:= core.ClassSeat[seatNumber].actions.NPCAddress;
            core.ClassSeat[seatNumber].forceAction.ForceToNPC:= true;
          end else
            core.ClassSeat[seatNumber].forceAction.ForceToNPC:= false;
      end;
      manageForceAction(IsAppControl);
    end;
    IsAdd: if not(seatID=-1) then
    begin
      forceNPCAction.ShowModal;
      actID:= strtoint(forceNPCAction.forceAction.Items.Names[forceNPCAction.forceAction.ItemIndex]);
      if not(actID=-1) then
      begin
        core.ClassSeat[seatID].forceAction.Active:= true;
        core.ClassSeat[seatID].forceAction.Action:= actID;
        manageForceAction(IsAppControl);
      end;
    end;
    IsCancel: if not(seatID=-1) then
    begin
      core.ClassSeat[seatID].forceAction.Active:= false;
      //core.ClassSeat[seatID].forceAction.Action:= -1;
      manageForceAction(IsAppControl);
    end;
    IsNavControl: if not(seatID=-1) then
    begin
      pFunMode.Items.Items[0].Checked:= core.ClassSeat[seatID].forceAction.Active;
      pFunMode.Items.Items[2].Checked:= core.ClassSeat[seatID].forceAction.ForceToNPC;
    end;
    IsAppControl:
    begin
      for i:= 0 to 24 do
      begin
        seatNumber:= seatIndex[i];
        charID:= core.getCharID(seatNumber);
        if not(charID=-1) then
        begin
          if (core.ClassSeat[seatNumber].forceAction.Action<-1) AND (core.ClassSeat[seatNumber].forceAction.Action>255) then
            core.ClassSeat[seatNumber].forceAction.Action:= -1;
          gridFunMode.Items.Item[i].SubItems.Strings[0]:= forceNPCAction.forceAction.Items.Values[inttostr(core.ClassSeat[seatNumber].forceAction.Action)];
          gridFunMode.Items.Item[i].SubItems.Strings[1]:= BoolToStr(core.ClassSeat[seatNumber].forceAction.Active,true);
          gridFunMode.Items.Item[i].SubItems.Strings[2]:= BoolToStr(core.ClassSeat[seatNumber].forceAction.ForceToNPC,true);
          gridFunMode.Items.Item[i].SubItems.Strings[3]:= '- None -';
          gridFunMode.Items.Item[i].SubItems.Strings[4]:= '- None -';
          gridFunMode.Items.Item[i].SubItems.Strings[5]:= 'False';
          if core.ClassSeat[seatNumber].randomAction.Active then
          begin
            gridFunMode.Items.Item[i].SubItems.Strings[3]:= randomActionVal.Items.Values[inttostr(core.ClassSeat[seatNumber].randomAction.Action)];
            gridFunMode.Items.Item[i].SubItems.Strings[4]:= core.ClassSeat[core.ClassSeat[seatNumber].randomAction.toSeat].listName;
            gridFunMode.Items.Item[i].SubItems.Strings[5]:= BoolToStr(core.ClassSeat[seatNumber].randomAction.trigger,true);
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.managePlanAction(state: TAppState; const actived: boolean = true; const seatno: integer = -1; const toSeat: integer = -1): boolean;
resourcestring
  validPlan   = 'Not valid Plan Actions !, First recheck plan list with none value or self target or one must active.';
  clearPlan   = 'All current plan action will be cleared?';
  clearPlanAll= 'All charater plan action will be cleared?';
var
  seat, i, tempInt: integer;
begin
  Result:= true;

  seat:= core.selectedSeat;
  if not(seatNo=-1) then seat:= seatNo;
  
  if not(state in [IsSave,IsLoad,IsCancel,IsClear,IsClearAll]) AND (seat=-1) then exit;

  case state of
    IsCheck: if not(seat=-1) then
    if (length(core.ClassSeat[seat].planAction.ListAction)>0) then
    begin
      core.ClassSeat[seat].planAction.TotActive:= 0;
      for i:= 0 to length(core.ClassSeat[seat].planAction.ListAction)-1 do
      if core.ClassSeat[seat].planAction.ListAction[i].Active then inc(core.ClassSeat[seat].planAction.TotActive);
    end;
    IsIgnored:
    if not(senderData.seatNumber=-1) then
    begin
      if (core.ClassSeat[seat].ignoredSeat=nil) then
        core.ClassSeat[seat].ignoredSeat:= TStringList.Create;

      // if in list delete
      if (core.ClassSeat[seat].ignoredSeat.IndexOfName(inttostr(senderData.seatNumber))>=0) then
        core.ClassSeat[seat].ignoredSeat.Delete(core.ClassSeat[seat].ignoredSeat.IndexOfName(inttostr(senderData.seatNumber)))
      else core.ClassSeat[seat].ignoredSeat.Values[inttostr(senderData.seatNumber)]:= inttostr(senderData.seatNumber);
      redrawSeatBox;
    end;
    IsAdd:
    begin
      planAddItem(actived);
      managePlanAction(IsAppControl,true,seat);
    end;
    IsCopy:
      if not(managePlanAction(IsValidate,false,seat)) then
        ShowMessage(validPlan)
      else
      if (length(core.ClassSeat[seat].planAction.ListAction)>0) then
      begin
        core.PlanDropBox.Started:= core.ClassSeat[seat].planAction.Started;
        core.PlanDropBox.Looping:= core.ClassSeat[seat].planAction.Looping;
        core.PlanDropBox.Shuffle:= core.ClassSeat[seat].planAction.Shuffle;
        core.PlanDropBox.Forced:= core.ClassSeat[seat].planAction.Forced;
        core.PlanDropBox.Quicked:= core.ClassSeat[seat].planAction.Quicked;
        SetLength(core.PlanDropBox.ListAction,0);
        for i:= 0 to length(core.ClassSeat[seat].planAction.ListAction)-1 do
        if not(core.ClassSeat[seat].planAction.ListAction[i].Seat=seat) then
        begin
          SetLength(core.PlanDropBox.ListAction,i+1);
          core.PlanDropBox.ListAction[i].Active:= core.ClassSeat[seat].planAction.ListAction[i].Active;
          core.PlanDropBox.ListAction[i].Seat:= core.ClassSeat[seat].planAction.ListAction[i].Seat;
          core.PlanDropBox.ListAction[i].CharID:= core.ClassSeat[seat].planAction.ListAction[i].CharID;
          core.PlanDropBox.ListAction[i].Action:= core.ClassSeat[seat].planAction.ListAction[i].Action;
        end;
      end;
    IsPaste:
      if (length(core.PlanDropBox.ListAction)>0) AND (messagedlg(clearPlan,mtconfirmation,[mbyes,mbno],0)=mryes) then
      begin
        core.ClassSeat[seat].planAction.Started:= core.PlanDropBox.Started;
        core.ClassSeat[seat].planAction.Looping:= core.PlanDropBox.Looping;
        core.ClassSeat[seat].planAction.Shuffle:= core.PlanDropBox.Shuffle;
        core.ClassSeat[seat].planAction.Forced := core.PlanDropBox.Forced;
        core.ClassSeat[seat].planAction.Quicked:= core.PlanDropBox.Quicked;
        managePlanAction(IsClear,true,seat);
        for i:= 0 to length(core.PlanDropBox.ListAction)-1 do
        if not(core.PlanDropBox.ListAction[i].Seat=seat) then
        begin
          inc(core.ClassSeat[seat].planAction.No);
          tempInt:= core.ClassSeat[seat].planAction.No;
          core.planActionMem(seat);
          core.ClassSeat[seat].planAction.ListAction[tempInt-1].Active:= core.PlanDropBox.ListAction[i].Active;
          core.ClassSeat[seat].planAction.ListAction[tempInt-1].Seat  := core.PlanDropBox.ListAction[i].Seat;
          core.ClassSeat[seat].planAction.ListAction[tempInt-1].CharID:= core.PlanDropBox.ListAction[i].CharID;
          core.ClassSeat[seat].planAction.ListAction[tempInt-1].Action:= core.PlanDropBox.ListAction[i].Action;
        end;
        if actived then managePlanAction(IsAppControl,true,seat);
      end;
    IsClear: if not(seat=-1) then
    begin
      if (core.ClassSeat[seat].planAction.No>0) AND (actived OR (messagedlg(clearPlan,mtconfirmation,[mbyes,mbno],0)=mryes)) then
      begin
        if not(core.ClassSeat[seat].planAction.syncAction=nil) then
          core.ClassSeat[seat].planAction.syncAction.Enabled:= false;
          
        core.ClassSeat[seat].planAction.No:=0;
        core.planActionMem(seat);
      end;
      if not(actived) then managePlanAction(IsAppControl,true,seat);
    end;
    IsClearAll:
    if (length(core.ClassSeat)>0) AND (actived OR (messagedlg(clearPlanAll,mtconfirmation,[mbyes,mbno],0)=mryes)) then
    begin
      for i:= 0 to 24 do
        managePlanAction(IsClear,true,core.getSeatID(i));
      if not(actived) then managePlanAction(IsAppControl,true,seat);
    end;
    IsSave: savePlanAction;
    IsLoad: begin
      loadPlanAction;
      if actived then planRefreshItem;
    end;
    IsValidate:
      if (length(core.ClassSeat[seat].planAction.ListAction)>0) then
      begin
        // check valid value
        for i:= 0 to length(core.ClassSeat[seat].planAction.ListAction)-1 do
        if (core.ClassSeat[seat].planAction.ListAction[i].Seat=-1) OR (core.ClassSeat[seat].planAction.ListAction[i].Seat=seat) OR
          (core.ClassSeat[seat].planAction.ListAction[i].Action=-1) then
        begin
          Result:= false;
          break;
        end;

        // check one must active
        tempInt:= 0;
        for i:= 0 to length(core.ClassSeat[seat].planAction.ListAction)-1 do
        if core.ClassSeat[seat].planAction.ListAction[i].Active then
        begin
          tempInt:= 1;
          break;
        end;
        if (tempInt=0) then Result:= false;
      end;
    IsRefresh:
    begin
      if (length(core.ClassSeat[seat].planAction.ListAction)>0) then
      for i:= 0 to length(core.ClassSeat[seat].planAction.ListAction)-1 do
        core.ClassSeat[seat].planAction.ListAction[i].Triggered:= false;
      core.ClassSeat[seat].planAction.runOnAction:= false;
      core.ClassSeat[seat].planAction.runIndex:= -1;
      core.ClassSeat[seat].planAction.runTargetAction:= -1;
      core.ClassSeat[seat].planAction.runTargetSeat:= -1;
      core.ClassSeat[seat].planAction.runTargetAddress:= '0';
      SetLength(core.ClassSeat[seat].planAction.tempPlanID,0);
      SetLength(core.ClassSeat[seat].planAction.indexRunID,0);
    end;
    IsNavControl:
      if actived and not(managePlanAction(IsValidate,false,seat)) then
        ShowMessage(validPlan)
      else
      begin
        if not(core.ClassSeat[seat].planAction.syncAction=nil) then
          core.ClassSeat[seat].planAction.syncAction.Enabled:= actived;
        core.ClassSeat[seat].planAction.Started:= actived;
        managePlanAction(IsRefresh,false,seat);
        managePlanAction(IsAppControl,true,seat);
      end;
    IsAppControl:
      if actived then
      begin
        cLoopAct.Checked     := core.ClassSeat[seat].planAction.Looping;
        cForceAct.Checked    := core.ClassSeat[seat].planAction.Forced;
        cForcePerform.Checked:= core.ClassSeat[seat].planAction.Quicked;
        cRunShuffled.Checked := core.ClassSeat[seat].planAction.Shuffle;

        // plan action is not empty
        if (length(core.ClassSeat[seat].planAction.ListAction)>0) then
        begin
          btnTerminateAct.Enabled:= actived;
          cLoopAct.Enabled       := actived;
          cForceAct.Enabled      := actived;
          cForcePerform.Enabled  := actived;
          cRunShuffled.Enabled   := actived;
          btnClearAct.Enabled    := actived;
          btnCopyAct.Enabled     := actived;
        end else
        // plan action is empty
        begin
          core.ClassSeat[seat].planAction.Started:= false;
          btnTerminateAct.Enabled:= not actived;
          cLoopAct.Checked       := not actived;
          cForceAct.Checked      := not actived;
          cForcePerform.Checked  := not actived;
          cRunShuffled.Checked   := not actived;
          cLoopAct.Enabled       := not actived;
          cForceAct.Enabled      := not actived;
          cForcePerform.Enabled  := not actived;
          cRunShuffled.Enabled   := not actived;
          btnClearAct.Enabled    := not actived;
          btnCopyAct.Enabled     := not actived;
        end;

        // pasted from clipboard
        btnPasteAct.Enabled:= false;
        if length(core.PlanDropBox.ListAction)>0 then
          btnPasteAct.Enabled:= true;

        // plan action is active
        if core.ClassSeat[seat].planAction.Started then
        begin
          btnTerminateAct.Caption:= 'Stop Actions';
          btnPlanAct.Enabled     := not actived;
          ScrollBox1.Enabled     := not actived;

          {
          cLoopAct.Enabled       := not actived;
          cForceAct.Enabled      := not actived;
          cForcePerform.Enabled  := not actived;
          cRunShuffled.Enabled   := not actived;
          }
          if not(core.ClassSeat[seat].planAction.syncAction = nil) then
            if not(core.ClassSeat[seat].planAction.syncAction.Enabled) then
              core.ClassSeat[seat].planAction.syncAction.Enabled:= true;
        end else
        begin
          btnTerminateAct.Caption:= 'Play Actions';
          btnPlanAct.Enabled := true;
          ScrollBox1.Enabled:= true;
          managePlanAction(IsRefresh,false,seat);
        end;

        planRefreshItem;
      end else
      begin
        core.ClassSeat[seat].planAction.Looping:= cLoopAct.Checked;
        core.ClassSeat[seat].planAction.Forced := cForceAct.Checked;
        core.ClassSeat[seat].planAction.Quicked:= cForcePerform.Checked;
        core.ClassSeat[seat].planAction.Shuffle:= cRunShuffled.Checked;

        if cForceAct.Checked or cLoopAct.Checked then managePlanAction(IsRefresh);

        planRefreshItem;
      end;
    IsCancel: if not(seat=-1) AND not(core.ClassSeat[seat].actions.Status>255) then
      if not actived AND not(core.getNPCState(seat) in [IsChat,IsFollow,IsDoSex]) then
      begin
        core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.status,4,'0');
        core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.fireAction,4,'1000');
      end else
      if not(core.ClassSeat[seat].actions.Status=4) then //AND not(core.ClassSeat[seatNumber].actions.cancelIsRun) then
      begin
        // bypass limit action if included in target limit action
        if not(ToSeat=-1) AND not(core.ClassSeat[ToSeat].limitActions = nil) AND
          (core.ClassSeat[ToSeat].limitActions.IndexOfName(inttostr(core.ClassSeat[seat].actions.Action))>=0) then
        begin
          core.ClassSeat[seat].actions.cancelType:= '[SLA]';
          exit;
        end;

        // normal mode
        if not(core.ClassSeat[seat].planAction.runOnAction) then
        case core.ClassSeat[seat].actions.Status of
          2: if (core.ClassSeat[seat].actions.ToSeatAddr='0') then
          begin
            core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.status,4,'0');
            core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.fireAction,4,'1000');
          end;
          3: if not(core.ClassSeat[seat].actions.ToSeatAddr='0') then
          begin
            core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.status,4,'0');
            core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.fireAction,4,'1000');
          end;
          5,6,7: if not(core.ClassSeat[seat].actions.ToSeatAddr='0') AND (core.ClassSeat[seat].actions.PCInteract=1) then
            core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.action,4,'52');
        end else
        if (core.ClassSeat[seat].actions.Status in [5,6,7]) then
          if not(core.ClassSeat[seat].actions.ToSeatAddr='0') AND (core.ClassSeat[seat].actions.PCInteract=1) then
            core.GameData.Process.SetValues(core.ClassSeat[seat].actAddress.action,4,'52');

        core.ClassSeat[seat].actions.cancelIsRun:= true;
      end;
  end;
end;

procedure TMainForm.planRefreshItem;
var rec,i: Integer;
begin
  if (core.selectedSeat=-1) then exit;

  if core.ClassSeat[core.selectedSeat].planAction.No>=PlanItems.TotalRow then
  begin
    if not ActScrollbar.Enabled then
      ActScrollbar.enabled:=true;

    try
      //sometimes on resolion changes this causes a problem, so in a try except to try and fix it on error
      if ActScrollbar.max<>core.ClassSeat[core.selectedSeat].planAction.No-1 then
        ActScrollbar.max:=core.ClassSeat[core.selectedSeat].planAction.No-1;

      if ActScrollbar.PageSize<>PlanItems.TotalRow-1 then
        ActScrollbar.pagesize:=PlanItems.TotalRow-1;

      if ActScrollbar.LargeChange<>PlanItems.TotalRow-1 then
        ActScrollbar.LargeChange:=PlanItems.TotalRow-1;

    except
      try
        ActScrollbar.Position:=0;
        ActScrollbar.max:=core.ClassSeat[core.selectedSeat].planAction.No-1;
        ActScrollbar.PageSize:=PlanItems.TotalRow-1;
        ActScrollbar.LargeChange:=PlanItems.TotalRow-1;
      except

      end;
    end;

  end else
  begin
    try
      if ActScrollbar.Enabled then
        ActScrollbar.enabled:=false;

      if ActScrollbar.Position<>0 then
        ActScrollbar.position:=0;
    except
      
    end;
  end;

  cLoopAct.Checked:= core.ClassSeat[core.selectedSeat].planAction.Looping;
  cRunShuffled.Checked:= core.ClassSeat[core.selectedSeat].planAction.Shuffle;
  cForceAct.Checked:= core.ClassSeat[core.selectedSeat].planAction.Forced;
  cForcePerform.Checked:= core.ClassSeat[core.selectedSeat].planAction.Quicked;

  for i:=0 to PlanItems.TotalRow-1 do
  begin
    rec:=ActScrollbar.Position+i;
    if rec<core.ClassSeat[core.selectedSeat].planAction.No then
    begin
      PlanItems.Active[i].checked:= core.ClassSeat[core.selectedSeat].planAction.ListAction[rec].Active;
      PlanItems.Seat[i].ItemIndex:= ArrayIndexContainInteger(core.ClassSeat[core.selectedSeat].planAction.ListAction[rec].Seat,seatIndex)+1;
      PlanItems.Action[i].ItemIndex:= StringStore.StringsByName[lstActName].IndexOfName(inttostr(core.ClassSeat[core.selectedSeat].planAction.ListAction[rec].Action))+1;
      PlanItems.Triggered[i].checked:=core.ClassSeat[core.selectedSeat].planAction.ListAction[rec].Triggered;

      PlanItems.Active[i].Visible:= true;
      PlanItems.Seat[i].Visible:= true;
      PlanItems.Action[i].Visible:= true;
      PlanItems.Triggered[i].Visible:= true;
      PlanItems.Remove[i].Visible:= true;

      PlanItems.Selected[i].Hint:= BoolToStr(PlanItems.Active[i].checked,true)+' '+inttostr(core.ClassSeat[core.selectedSeat].planAction.ListAction[rec].Seat)+' '+
        inttostr(core.ClassSeat[core.selectedSeat].planAction.ListAction[rec].CharID)+' '+inttostr(core.ClassSeat[core.selectedSeat].planAction.ListAction[rec].Action);
      if not(PlanItems.Selected[i].ShowHint) then
        PlanItems.Selected[i].ShowHint:= true;

      if (rec=core.ClassSeat[core.selectedSeat].planAction.runIndex) then
      begin
        PlanItems.Selected[i].Color:=clGradientActiveCaption;
        PlanItems.Selected[i].Font.Color:=clGradientActiveCaption;
      end else
      begin
        PlanItems.Selected[i].Color:=clBtnFace;
        PlanItems.Selected[i].Font.Color:=clBtnFace;
      end;

      {
      if core.ClassSeat[core.selectedSeat].planAction.selected[rec] then
      begin
        if core.ClassSeat[core.selectedSeat].planAction.lastselected=rec then
        begin
          PlanRow[i].Color:=clActiveCaption;
          PlanRow[i].Font.Color:=clActiveCaption;
          PlanActive[i].Color:=clActiveCaption;
        end
        else
        begin
          select[i].Color:=clGradientActiveCaption;
          select[i].Font.Color:=clGradientActiveCaption;
          isActive[i].Color:=clGradientActiveCaption;
        end;
      end
      else
      begin
        select[i].Color:=clBtnFace;
        select[i].Font.Color:=clBtnFace;
        isActive[i].Color:=clBtnFace;
      end;
      }
    end else
    begin
      PlanItems.Selected[i].Color:=clBtnFace;
      PlanItems.Selected[i].Font.Color:=clBtnFace;

      PlanItems.Active[i].Visible:= false;
      PlanItems.Seat[i].Visible:= false;
      PlanItems.Action[i].Visible:= false;
      PlanItems.Triggered[i].Visible:= false;
      PlanItems.Remove[i].Visible:= false;
    end;
  end;
end;

procedure TMainForm.planSelected(sender: TObject);
var sel: Integer;
    i: Integer;
begin
  if (core.selectedSeat=-1) then exit;

  sel:=0;
  if sender is TLabel then sel:=(Sender as TLabel).Tag+ActScrollbar.Position
  else if sender is TCheckBox then sel:=(Sender as TCheckBox).Tag+ActScrollbar.Position
  else if sender is TComboBox then sel:=(Sender as TComboBox).Tag+ActScrollbar.Position
  else if sender is TButton then sel:=(Sender as TButton).Tag+ActScrollbar.Position;

  if (sel>=core.ClassSeat[core.selectedSeat].planAction.No) then
  begin
    planRefreshItem;
    exit;
  end;

  if not core.ClassSeat[core.selectedSeat].planAction.selected[sel] then //clear all other selected items except this one
  begin
    for i:=0 to core.ClassSeat[core.selectedSeat].planAction.No-1 do core.ClassSeat[core.selectedSeat].planAction.selected[i]:=false;
  end;

  core.ClassSeat[core.selectedSeat].planAction.selected[sel]:=true;

  core.ClassSeat[core.selectedSeat].planAction.lastselected:=sel;

  planRefreshItem;
end;

procedure TMainForm.planChange(sender: TObject);
var
  tag: integer;
  types: string;
begin
  if (length(core.ClassSeat)=0) OR (core.selectedSeat=-1) then exit;
  
  if (sender is TComboBox) then
  begin
    tag:= (sender as TComboBox).Tag;
    types:= (sender as TComboBox).Hint;
  end else
  if (sender is TCheckBox) then
  begin
    tag:= (sender as TCheckBox).Tag;
    types:= (sender as TCheckBox).Hint;
  end;

  if core.ClassSeat[core.selectedSeat].planAction.lastselected<>ActScrollbar.position+tag then exit;

  if (types='Active') then
  begin
    core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].Active:=(sender as TCheckBox).Checked;
    managePlanAction(IsCheck,true,core.selectedSeat);
  end else
  if (types='ToNPC') then
  begin
    core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].Seat:=-1;
    core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].CharID:=-1;
    if ((sender as TComboBox).ItemIndex=0) then
      showmessage('Select Targeted NPC!')
    else
    begin
      core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].Seat:=seatIndex[(sender as TComboBox).ItemIndex-1];
      core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].CharID:= core.getCharID(core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].Seat);
    end;
  end else
  if (types='Actions') then
  begin
    core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].Action:=-1;
    if ((sender as TComboBox).ItemIndex=0) then
      showmessage('Select one Action to perform!')
    else
      core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].Action:=strtoint(StringStore.StringsByName[lstActName].Names[(sender as TComboBox).ItemIndex-1]);
  end else
  if (types='Running') then
    core.ClassSeat[core.selectedSeat].planAction.ListAction[ActScrollbar.position+tag].Triggered:=(sender as TCheckBox).Checked;

  planRefreshItem;
end;

procedure TMainForm.planRemoveItem;
var i,j: Integer;
begin
  if (core.selectedSeat=-1) then exit;
  
  i:=0;
  while i<core.ClassSeat[core.selectedSeat].planAction.No do
  begin
    if core.ClassSeat[core.selectedSeat].planAction.selected[i] then
    begin
      for j:=i to core.ClassSeat[core.selectedSeat].planAction.No-2 do
      begin
        core.ClassSeat[core.selectedSeat].planAction.ListAction[j]:=core.ClassSeat[core.selectedSeat].planAction.ListAction[j+1];
        core.ClassSeat[core.selectedSeat].planAction.selected[j]:=core.ClassSeat[core.selectedSeat].planAction.selected[j+1];
      end;

      dec(core.ClassSeat[core.selectedSeat].planAction.No);
      dec(i);
      core.planActionMem;

      if core.ClassSeat[core.selectedSeat].planAction.firstshiftselected>core.ClassSeat[core.selectedSeat].planAction.no-1 then
        core.ClassSeat[core.selectedSeat].planAction.firstshiftselected:=-1;
    end;

    inc(i);
  end;

  If core.ClassSeat[core.selectedSeat].planAction.lastselected>core.ClassSeat[core.selectedSeat].planAction.No-1 then
    core.ClassSeat[core.selectedSeat].planAction.lastselected:=core.ClassSeat[core.selectedSeat].planAction.No-1;
  if core.ClassSeat[core.selectedSeat].planAction.lastselected>-1 then
    core.ClassSeat[core.selectedSeat].planAction.selected[core.ClassSeat[core.selectedSeat].planAction.lastselected]:=true;
  planRefreshItem;
end;

procedure TMainForm.planAddItem(const isDefault: boolean = true);
var
  No, toseat, tocharID: integer;
begin
  if (core.selectedSeat=-1) then exit;

  toseat:= -1;
  tocharID:= -1;
  if not(isDefault) then
  begin
    toseat:= senderData.seatNumber;
    tocharID:= core.getCharID(toSeat);
  end;

  inc(core.ClassSeat[core.selectedSeat].planAction.No);
  No:= core.ClassSeat[core.selectedSeat].planAction.No;

  core.planActionMem;

  core.ClassSeat[core.selectedSeat].planAction.ListAction[No-1].Active:=true;
  core.ClassSeat[core.selectedSeat].planAction.ListAction[No-1].Seat:=toseat;
  core.ClassSeat[core.selectedSeat].planAction.ListAction[No-1].CharID:=tocharID;
  core.ClassSeat[core.selectedSeat].planAction.ListAction[No-1].Action:=-1;
  core.ClassSeat[core.selectedSeat].planAction.ListAction[No-1].Triggered:=false;

  planRefreshItem;
end;

procedure TMainForm.planMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  planSelected(sender);
end;

procedure TMainForm.planRemoveButton(Sender: TObject);
begin
  planSelected(sender);
  planRemoveItem;
end;

procedure TMainForm.planHeaderClick(HeaderControl: THeaderControl; Section: THeaderSection);
var i: integer;
begin
  if not(core.selectedSeat=-1) then
    if (length(core.ClassSeat[core.selectedSeat].planAction.ListAction)>0) then
    begin
      case Section.Index of
        0: begin
          PlanItems.ActiveHead:= not(PlanItems.ActiveHead);
          for i:= 0 to length(core.ClassSeat[core.selectedSeat].planAction.ListAction)-1 do core.ClassSeat[core.selectedSeat].planAction.ListAction[i].Active:= PlanItems.ActiveHead;
        end;
        2: begin
          cHeadAction.Visible:= true;
          cHeadAction.ItemIndex:= 0;
        end;
        3: for i:= 0 to length(core.ClassSeat[core.selectedSeat].planAction.ListAction)-1 do core.ClassSeat[core.selectedSeat].planAction.ListAction[i].Triggered:= false;
      end;
      planRefreshItem;
    end;
end;

procedure TMainForm.initPlanAction;
var i, topPos: integer;
begin
  PlanItems.TotalRow:=10;

  for i:= 0 to PlanItems.TotalRow-1 do
  begin
    if (i=0) then topPos:= 0
    else topPos:= topPos + 25;

    SetLength(PlanItems.Selected,i+1);
    PlanItems.Selected[i]:= TLabel.Create(pPlanItems);
    with PlanItems.Selected[i] do
    begin
      top:= topPos;
      left:= 0;
      Height:= 25;
      Width:= 505;
      OnMouseDown:= planMouseDown;
      Tag:= i;
      Visible:= false;
      Parent:= pPlanItems;
    end;

    SetLength(PlanItems.Active,i+1);
    PlanItems.Active[i]:= TCheckBox.Create(pPlanItems);
    with PlanItems.Active[i] do
    begin
      Top:= topPos+3;
      Height:= 17;
      Width:= 17;
      Hint:= 'Active';
      Left:= 16;
      Cursor:= crHandPoint;
      OnClick:= planChange;
      OnMouseDown:= planMouseDown;
      Tag:= i;
      Visible:= false;
      Parent:= pPlanItems;
    end;

    SetLength(PlanItems.Seat,i+1);
    PlanItems.Seat[i]:= TComboBox.Create(pPlanItems);
    with PlanItems.Seat[i] do
    begin
      Height:= 21;
      Width:= 145;
      Hint:= 'ToNPC';
      top:= topPos+1;
      left:= 43;
      Style:= csDropDownList;
      OnChange:= planChange;
      OnDropDown:= planSelected;
      Tag:= i;
      Visible:= false;
      Parent:= pPlanItems;
      Items.AddStrings(NPCListName);
    end;

    SetLength(PlanItems.Action,i+1);
    PlanItems.Action[i]:= TComboBox.Create(pPlanItems);
    with PlanItems.Action[i] do
    begin
      Height:= 21;
      Width:= 130;
      Hint:= 'Actions';
      top:= topPos+1;
      left:= 196;
      Style:= csDropDownList;
      OnChange:= planChange;
      OnDropDown:= planSelected;
      Tag:= i;
      Visible:= false;
      Parent:= pPlanItems;
      Items.AddStrings(PlanActionName);
    end;

    SetLength(PlanItems.Triggered,i+1);
    PlanItems.Triggered[i]:= TCheckBox.Create(pPlanItems);
    with PlanItems.Triggered[i] do
    begin
      Top:= topPos+3;
      Height:= 17;
      Width:= 17;
      Hint:= 'Running';
      Left:= 336;
      Cursor:= crHandPoint;
      OnClick:= planChange;
      OnMouseDown:= planMouseDown;
      Tag:= i;
      Visible:= false;
      Parent:= pPlanItems;
      enabled:= false;
    end;

    SetLength(PlanItems.Remove,i+1);
    PlanItems.Remove[i]:= TButton.Create(pPlanItems);
    with PlanItems.Remove[i] do
    begin
      Top:= topPos+3;
      Height:= 18;
      Width:= 59;
      Left:= 359;
      Caption:= 'Remove';
      Cursor:= crHandPoint;
      OnClick:= planRemoveButton;
      Tag:= i;
      Visible:= false;
      Parent:= pPlanItems;
    end;

  end;
end;

procedure TMainForm.LoadPlanAction(const fileName: string = ''; const overide: boolean = false);
var
  isSaved: boolean;
begin
  pauseNPCTimer:= true;

  isSaved:= overide;
  openDlg.DefaultExt:= '.dat';
  openDlg.InitialDir:= appDir+'save';
  openDlg.FileName:= ExtractFileName(SaveName.Text)+'.dat';
  openDlg.Filter:= 'AA2T Data|*.dat';

  // notice to save
  if not(isSaved) AND core.PlanActionCreated AND (MessageDlg('Save All Current Data before Clear?',mtconfirmation,[mbyes,mbno],0) = mryes) then
    isSaved:= true;

  // save action plan
  if isSaved then SavePlanAction(fileName,overide);

  // load action plan
  if isSaved OR not(core.PlanActionCreated) OR (MessageDlg('Not Saving All Current Data!, continue?',mtconfirmation,[mbyes,mbno],0) = mryes) then
  begin
    isSaved:= false;
    if not(fileName='') then
    begin
      isSaved:= core.manageSavedData(FilePlanAction,fileName,false);
      lastSaveData:= fileName;
    end else
    if openDlg.Execute then
    begin
      isSaved:= core.manageSavedData(FilePlanAction,openDlg.FileName,false);
      lastSaveData:= openDlg.FileName;
    end;

    if isSaved then managePlanAction(IsAppControl);
  end;

  statusBar.Panels[2].Text:= 'Trainer Data : '+ExtractFileName(lastSaveData);

  pauseNPCTimer:= false;
end;

procedure TMainForm.SavePlanAction(const fileName: string = ''; const overide: boolean = false);
var
  ext: string;
begin
  pauseNPCTimer:= true;

  saveDlg.DefaultExt:= '.dat';
  saveDlg.InitialDir:= appDir+'save';
  saveDlg.Filter:= 'AA2T Data|*.dat';
  saveDlg.FileName:= ExtractFileName(SaveName.Text)+'.dat';

  if core.PlanActionCreated then
  if not(fileName='') then
  begin
    ext:= '';
    if not(ExtractFileExt(fileName)='.dat') then
      ext:= '.dat';
    core.manageSavedData(FilePlanAction,fileName+ext);
  end else
  if saveDlg.Execute then
  begin
    ext:= '';
    if not(ExtractFileExt(saveDlg.FileName)='.dat') then
      ext:= '.dat';
    core.manageSavedData(FilePlanAction,saveDlg.FileName+ext);
  end;

  pauseNPCTimer:= false;
end;

procedure TMainForm.limitActionAll(state: TAppState);
var
  i: integer;
begin
  case state of
    IsAdd:
    if not(cb_limitAll.ItemIndex=-1) then
    begin
      if (lst_limitAll.Items.IndexOfName(cb_limitAll.Items.Names[cb_limitAll.ItemIndex])=-1) then
        lst_limitAll.Items.Values[cb_limitAll.Items.Names[cb_limitAll.ItemIndex]]:= cb_limitAll.Items.ValueFromIndex[cb_limitAll.ItemIndex]
      else showmessage('All ready in list.');
    end;
    IsDelete: if not(lst_limitAll.ItemIndex=-1) then lst_limitAll.Items.Delete(lst_limitAll.ItemIndex);
    IsClearAll:
    begin
      lst_limitAll.Items.Clear;
      for i:= 0 to cb_limitAll.Items.Count-1 do
        lst_limitAll.Items.Values[inttostr(i)]:= trimPos('.',cb_limitAll.Items.Strings[i]);
    end;
    IsClear: if not(lst_limitAll.Items.Count=0) then lst_limitAll.Items.Clear;
  end;
end;

procedure TMainForm.limitAction(state: TAppState);
var i: integer;
begin
  if core.ClassSeat[core.selectedSeat].limitActions = nil then
    core.ClassSeat[core.selectedSeat].limitActions:= TStringList.Create;

  case state of
    IsAdd:
    if not(cb_limitAct.ItemIndex=-1) then
    begin
      if (core.ClassSeat[core.selectedSeat].limitActions.IndexOfName(cb_limitAct.Items.Names[cb_limitAct.ItemIndex])=-1) then
        core.ClassSeat[core.selectedSeat].limitActions.Values[cb_limitAct.Items.Names[cb_limitAct.ItemIndex]]:= cb_limitAct.Items.ValueFromIndex[cb_limitAct.ItemIndex]
      else showmessage('All ready in list.');
    end;
    IsDelete: if not(lst_limitAct.ItemIndex=-1) then core.ClassSeat[core.selectedSeat].limitActions.Delete(lst_limitAct.ItemIndex);
    IsClearAll:
    begin
      core.ClassSeat[core.selectedSeat].limitActions.Clear;
      for i:= 0 to cb_limitAct.Items.Count-1 do
        core.ClassSeat[core.selectedSeat].limitActions.Values[inttostr(i)]:= trimPos('.',cb_limitAct.Items.Strings[i]);
    end;
    IsClear: if not(core.ClassSeat[core.selectedSeat].limitActions.Count=0) then core.ClassSeat[core.selectedSeat].limitActions.Clear;
    IsCopy:
    if not(core.ClassSeat[core.selectedSeat].limitActions.Count=0) then
    begin
      if (LimitCopy=nil) then LimitCopy:= TStringList.Create
      else LimitCopy.Clear;

      LimitCopy.AddStrings(core.ClassSeat[core.selectedSeat].limitActions);
    end;
    IsPaste:
    if not(LimitCopy.Count=0) then
    begin
      core.ClassSeat[core.selectedSeat].limitActions:= LimitCopy;
    end;
  end;
  lst_limitAct.Clear;
  lst_limitAct.Items.AddStrings(core.ClassSeat[core.selectedSeat].limitActions);
end;

{ ================================================================= MAIN GAME DATA =========================================================== }

procedure TMainForm.getClubName;
var codeKey: string;
begin
  if classReady AND isReadData then
  begin
    if (core.GameData.CharCode.Contain(core.GameData.codekey[0])) then
    begin
      codeKey:= core.GameData.codekey[0];

      Club1Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club1Name']);
      Club2Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club2Name']);
      Club3Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club3Name']);
      Club4Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club4Name']);
      Club5Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club5Name']);
      Club6Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club6Name']);
      Club7Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club7Name']);
      Club8Name.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club8Name']);

      Club1Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club1Type'],true));
      Club2Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club2Type'],true));
      Club3Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club3Type'],true));
      Club4Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club4Type'],true));
      Club5Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club5Type'],true));
      Club6Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club6Type'],true));
      Club7Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club7Type'],true));
      Club8Type.ItemIndex:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Club8Type'],true));
    end;
  end;
end;

procedure TMainForm.refreshCharacterSeat;
var i, idx, seatNumber, charID: integer;
  items,itemsAct: TJvImageItem;
  gridItem: TListItem;
  BMP: TBitmap;
begin
  // CLUB NAME
  for i:= 1 to 8 do
  begin
    idx:= strtoint(core.GameData.getValueByCode(core.GameData.CharCode.Data['MainData','Club'+inttostr(i)+'Type'],true));
    if not(idx=-1) then
      Club.Items.Strings[idx]:= core.GameData.getValueByCode(core.GameData.CharCode.Data['MainData','Club'+inttostr(i)+'Name']);
  end;

  core.refreshClassData;

  // THUMB LIST IMAGE
  lstChar.Items.Clear;
  lstCharAct.Items.Clear;
  gridFunMode.Items.Clear;
  NPCListName:= TStringList.Create;
  NPCListName.Add('- Select Seat -');
  setNPC.Items.Clear;
  setNPC.Items.Add('-1.None');
  ActionRefNPC.Items.Clear;
  ActionRefNPC.Items.Add('-1.None');
  for i:= 0 to 24 do
  begin
    items:= lstChar.Items.Add;
    itemsAct:= lstCharAct.Items.Add;
    gridItem:= gridFunMode.Items.Add;
    gridItem.ImageIndex:= -1;
    seatNumber:= seatIndex[i];
    items.Text := inttostr(seatNumber)+'. - Empty - ';
    itemsAct.Text:= items.Text;

    charID:= core.getCharID(seatNumber);
    if not(charID=-1) then
    begin
      items.Text := core.Classseat[seatNumber].listName;
      gridItem.ImageIndex:= seatNumber;
      BMP:= TBitmap.Create;
      try
        GraphicToBitmap(core.ClassSeat[seatNumber].views.thumb, BMP);
        items.Glyph.Assign(BMP);
        itemsAct.Glyph.Assign(BMP);
        core.IgnoreSeat[seatNumber].seatBox.Enabled:= true;
        core.IgnoreSeat[seatNumber].seatBox.Glyph.Assign(BMP);
      finally
        BMP.Free;
      end;
    end;
    itemsAct.Text:= items.Text;
    gridItem.Caption:= items.Text;
    gridItem.SubItems.Add('- None -');
    gridItem.SubItems.Add('False');
    gridItem.SubItems.Add('False');
    gridItem.SubItems.Add('- None -');
    gridItem.SubItems.Add('- None -');
    gridItem.SubItems.Add('False');
    NPCListName.Add(items.Text);
    setNPC.Items.Add(items.Text);
    ActionRefNPC.Items.Add(items.Text);
  end;
end;

procedure TMainForm.ignoreNPCClick(sender:TObject);
var seatNumber: integer;
begin
  seatNumber:= TJvSpeedButton(sender).Tag;

  if (core.ClassSeat[core.selectedSeat].ignoredSeat=nil) then
    core.ClassSeat[core.selectedSeat].ignoredSeat:= TStringList.Create;

  // if in list delete first
  if (core.ClassSeat[core.selectedSeat].ignoredSeat.IndexOfName(inttostr(seatNumber))>=0) then
    core.ClassSeat[core.selectedSeat].ignoredSeat.Delete(core.ClassSeat[core.selectedSeat].ignoredSeat.IndexOfName(inttostr(seatNumber)));

  if TJvSpeedButton(sender).Down then
  begin
    TJvSpeedButton(sender).Flat:= false;
    core.ClassSeat[core.selectedSeat].ignoredSeat.Values[inttostr(seatNumber)]:= inttostr(seatNumber);
  end else
    TJvSpeedButton(sender).Flat:= true;

  redrawSeatBox;
end;

procedure TMainForm.initMainAddress;
const
  Address: dword = $00376164;
  CharOffset  : array [0..0] of dword = ($88);
  TargetOffset: array [0..0] of dword = ($8C);
  AutoPCOffset: array [0..1] of dword = ($2E3, $38);
  ClassOffset : array [0..1] of dword = ($64,$28);
  timeOffset  : array [0..1] of dword = ($2C,$2C);
  timeScrnOff : array [0..1] of dword = ($20,$2C);
begin
  playedCharAddress:= core.GameData.Process.GetRealAddress(Address+core.GameData.Process.PBaseAddress,CharOffset);
  targetCharAddress:= core.GameData.Process.GetRealAddress(Address+core.GameData.Process.PBaseAddress,TargetOffset);
  AutoPCAddress    := core.GameData.Process.GetRealAddress(Address+core.GameData.Process.PBaseAddress,AutoPCOffset);
  classNameAddress := core.GameData.Process.GetRealAddress(Address+core.GameData.Process.PBaseAddress,ClassOffset);
  timeAddress      := core.GameData.Process.GetRealAddress(Address+core.GameData.Process.PBaseAddress,timeOffset);
  timeStateAddress := core.GameData.Process.GetRealAddress(Address+core.GameData.Process.PBaseAddress,timeScrnOff);
end;

procedure TMainForm.playedCharacter(const setPlay: boolean = false);
var getPlayAddr: string;
begin
  if setPlay then
  begin
    if not(core.setPlayedSeat=-1) AND not(core.setPlayedSeat=core.playedSeat) AND
      not(core.getNPCState(core.setPlayedSeat) in [IsChat,IsFollow,IsDoSex]) then
    begin
      getPlayAddr:= core.NPCPlayAddress[core.setPlayedSeat];
      if not(getPlayAddr='0') then
        core.GameData.Process.SetValues(playedCharAddress,4,getPlayAddr);
    end;
  end else
  begin
    getPlayAddr:= core.GameData.Process.GetValues(playedCharAddress,4);
    core.setPlayedSeat:= ArrayIndexContainText(getPlayAddr,core.NPCPlayAddress,true);
  end;

  if not(core.setPlayedSeat=-1) AND not(core.playedSeat=core.setPlayedSeat) then
  begin
    core.playedSeat:= core.setPlayedSeat;
    core.playedChar:= core.getCharID(core.playedSeat);
    core.selectedChar:= core.playedChar;
    core.selectedSeat:= core.playedSeat;
    redrawSeatBox;

    PlayerAct.Seat:= core.playedSeat;
    PlayerAct.CharAddress:= core.ClassSeat[PlayerAct.Seat].actions.NPCAddress;

    core.setPlayedSeat:= -1;
  end;
end;

procedure TMainForm.autoMode(const setAuto: boolean = false);
var
  getVal: string;
begin
  if not(classReady) then exit;

  if setAuto then
  begin
    isReadData:= false;
    if not(core.getNPCState(core.playedSeat) in [IsChat,IsFollow,IsDoSex]) then
      core.GameData.Process.SetValues(AutoPCAddress,1,boolStr(autoPC.StateOn));
    isReadData:= true;
  end else
  if isReadData then
  begin
    getVal:= core.GameData.Process.GetValues(AutoPCAddress,1);
    if not(getVal='') AND not(getVal[1]='?') then
      autoPC.StateOn:= strBool(getVal);
  end;
end;

procedure TMainForm.showCharMenu;
var i: integer;
  enabled: boolean;
  unixID,freezeID: string;
begin
  enabled:= true;
  if (senderData.seatNumber=core.selectedSeat) then
    enabled:= false;

  for i:= 0 to pCharList.Items.Count-1 do
  if (pCharList.Items.Items[i].Hint='hidden') then
  begin
    pCharList.Items.Items[i].Visible:= enabled;
    if pCharList.Items.Items[i].Visible AND (pCharList.Items.Items[i].Tag = 11) then
    begin
      unixID:= 'Relationship_LoveMax_'+inttostr(core.selectedSeat)+'_'+inttostr(senderData.seatNumber);
      freezeID:= core.GameData.CharCode.Data['FreezeData',unixID];
      pCharList.Items.Items[i].Checked:= false;
      if not(freezeID='') then pCharList.Items.Items[i].Checked:= core.GameData.FreezeData[strtoint(freezeID)].isFreeze;
    end;
  end;
end;

{ ======================================================================= FREEZER ========================================================= }

procedure TMainForm.menuFreezeChecked(MenuItem: TMenuItem; codeType: string);
var
  i,codeID,posCode,charID,toCharID,selCol: integer;
  unixID,freezeID: string;
  enabled: boolean;
begin
  for i:= 0 to MenuItem.Count-1 do
  // single freeze data
  if (MenuItem.Items[i].Tag=99) then
  begin
    MenuItem.Items[i].Hint:= codeType;
    codeID:= codeStore.ItemByName[MenuItem.Items[i].Hint].Index;
    charID:= core.selectedChar;
    case codeID of
      // personalCode
      1: unixID:= codeType+'_'+senderData.Name+'_'+inttostr(core.selectedSeat)+'_-1';
      // lover
      6: begin
        selCol:= senderGrid.selCol-1;
        toCharID:= seatIndex[senderGrid.selRow-1];
        posCode:= ArrayIndexContainText(codeType,core.GameData.RegenCode[charID].KeyName,true);
        unixID:= codeType+'_'+core.GameData.RegenCode[charID].DataCode[posCode].NameCode[selCol]+'_'+inttostr(core.selectedSeat)+'_'+inttostr(seatIndex[senderGrid.selRow-1]);
      end;
      // statusH
      7: begin
        selCol:= senderGrid.selCol-1;
        charID:= core.selectedSeat;
        toCharID:= core.getCharID(seatIndex[senderGrid.selRow-1]);
        posCode:= ArrayIndexContainText(codeType,core.GameData.RegenCode[charID].KeyName,true);
        unixID:= codeType+'_'+core.GameData.RegenCode[charID].DataCode[posCode].NameCode[selCol]+'_'+inttostr(core.selectedSeat)+'_'+inttostr(seatIndex[senderGrid.selRow-1]);
      end;
      else begin
        selCol:= senderGrid.selCol-1;
        toCharID:= gridToCharID[senderGrid.selRow-1];
        posCode:= ArrayIndexContainText(codeType,core.GameData.RegenCode[charID].KeyName,true);
        unixID:= codeType+'_'+core.GameData.RegenCode[charID].DataCode[posCode].NameCode[selCol]+'_'+inttostr(core.selectedSeat)+'_'+inttostr(senderGrid.selRow-1);
      end;
    end;

    enabled:= false;
    freezeID:= core.GameData.CharCode.Data['FreezeData',unixID];
    if not(freezeID='') then enabled:= core.GameData.FreezeData[strtoint(freezeID)].isFreeze;
    MenuItem.Items[i].Checked:= enabled;
    MenuItem.Items[i].Enabled:= true;
    if (codeID=3) then MenuItem.Items[i].Enabled:= false;
    break;
  end;
end;

procedure TMainForm.menuContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  isFreezeComp: boolean;
  MenuItems: TMenuItem;
  codeType: string;
  i: integer;
begin
  if (core.selectedChar=-1) then exit;
  isFreezeComp:= true;

  //senderData.seatNumber:= -1;

  // first get required menu
  if (sender is TJvStringGrid) then
  begin
    codeType:= TJvStringGrid(sender).Hint;
    if not(TJvStringGrid(sender).PopupMenu=nil) then
      MenuItems:= TJvStringGrid(sender).PopupMenu.Items;
  end else
  if (sender is TComboBox) then
  begin
    codeType:= TComboBox(sender).Hint;
    if not(TComboBox(sender).PopupMenu=nil) then
      MenuItems:= TComboBox(sender).PopupMenu.Items;
  end else
  if (sender is TJvSpinEdit) then
  begin
    codeType:= TJvSpinEdit(sender).Hint;
    if not(TJvSpinEdit(sender).PopupMenu=nil) then
      MenuItems:= TJvSpinEdit(sender).PopupMenu.Items;
  end else
  if (sender is TCheckBox) then
  begin
    codeType:= TCheckBox(sender).Hint;
    if not(TCheckBox(sender).PopupMenu=nil) then
      MenuItems:= TCheckBox(sender).PopupMenu.Items;
  end else
  // for get seatID in class seat
  if (sender is TjvPanel) then
  begin
    isFreezeComp:= false;
    senderData.seatNumber:= TjvPanel(sender).tag;//strtoint(explode('_',TjvPanel(sender).Name).Strings[1]);
    showCharMenu;
  end else
  // for copy/paste color
  if (sender is TJvColorButton) then
  begin
    isFreezeComp:= false;
    clipboardColor.tempName := TJvColorButton(sender).Name;
    clipboardColor.tempColor:= (sender as TJvColorButton).color;
  end else
  if (sender is TPanel) AND (TPanel(sender).Tag=4131) then
  begin
    isFreezeComp:= false;
    clipboardColor.tempName := TPanel(sender).Name;
    clipboardColor.tempColor:= TPanel(sender).Color;
  end;

  // then set menuitem hint point to parent codeType
  if isFreezeComp AND not(MenuItems=nil) then
  begin
    parseSenderData(sender);
    menuFreezeChecked(MenuItems,codeType);
  end;
end;
                                                 
procedure TMainForm.ManageFreezeData(Sender: TObject);
var
  codeType, freezeType, i, ii, charID, toCharID, posCode: integer;
  codeGroup, unixIDP, unixID, value, codes: string;
  enabled: boolean;
begin
  if not(classReady) then exit;

  isReadData:= false;

  if (sender is TJvStringGrid) then
  begin
    freezeType:= 1;
    codeGroup:= TJvStringGrid(sender).Hint
  end else
  if (sender is TMenuItem) then
  begin
    freezeType:= 1;
    enabled:= not TMenuItem(sender).Checked;
    codeGroup:= TMenuItem(sender).Hint;

    // this for relationship grid popmenu
    if (TMenuItem(sender).Tag in [9,10]) then freezeType:= 2;
    if (TMenuItem(sender).Tag=9) then enabled:= true
    else if (TMenuItem(sender).Tag=10) then enabled:= false;
  end else
  if (sender is TCheckBox) then
  begin
    freezeType:= TCheckBox(sender).tag;
    codeGroup:= TCheckBox(sender).Hint;
    enabled:= TCheckBox(sender).Checked;
  end;

  codeType:= codeStore.ItemByName[codeGroup].Index;
  posCode:= ArrayIndexContainText(codeGroup,core.GameData.RegenCode[core.selectedChar].KeyName,true);
  charID:= core.selectedChar;
  case codeType of
    // personalcode
    1: if not(core.selectedChar=-1) then
    begin
      i:= ArrayIndexContainText(senderData.Name,core.GameData.RegenCode[charID].DataCode[posCode].NameCode,true);
      value:= core.GameData.getRegenValue(codeType,charID,i,true);
      codes:= core.GameData.getRegenCode(codeType,charID,i);
      core.setFreezeData(codeGroup,senderData.Name,codes,value,enabled,core.selectedSeat);
    end;
    // relationship
    3: if not(core.selectedChar=-1) then
    case freezeType of
      1: begin
        senderGrid.toCharID:= gridToCharID[senderGrid.selRow-1]; //core.getCharID(seatIndex[senderGrid.selRow-1]);
        if not(senderGrid.toCharID=-1) then
          for i:= 0 to length(core.GameData.RegenCode[charID].DataCode[posCode].NameCode)-1 do
          begin
            value:= core.GameData.getRegenValue(codeType,charID,i,true,senderGrid.toCharID);
            codes:= core.GameData.getRegenCode(codeType,charID,i,senderGrid.toCharID);
            core.setFreezeData(codeGroup,core.GameData.RegenCode[charID].DataCode[posCode].NameCode[i],codes,value,
              freezeCBox[charID].Relationship[senderGrid.selRow-1],core.selectedSeat,senderGrid.selRow-1);
          end;
      end;
      2: begin
        for i:= 0 to 24 do
        begin
          toCharID:= gridToCharID[i];
          freezeCBox[charID].Relationship[i]:= enabled;
          if (toCharID=-1) OR (i=lstChar.ItemIndex) then // grid not accept set self value and empty seat
          begin
            freezeCBox[charID].Relationship[i]:= false;
            continue;
          end;

          for ii:= 0 to length(core.GameData.RegenCode[charID].DataCode[posCode].NameCode)-1 do
          begin
            value:= core.GameData.getRegenValue(codeType,charID,ii,true,toCharID);
            codes:= core.GameData.getRegenCode(codeType,charID,ii,toCharID);
            core.setFreezeData(codeGroup,core.GameData.RegenCode[charID].DataCode[posCode].NameCode[ii],codes,value,
              freezeCBox[charID].Relationship[i],core.selectedSeat,i);
          end;
        end;
        gridRelationship.Invalidate;
      end;
    end;
    // behavior
    4: if not(core.selectedChar=-1) then
    case freezeType of
      1: begin
        senderGrid.toCharID:= gridToCharID[senderGrid.selRow-1]; //core.getCharID(seatIndex[senderGrid.selRow-1]);
        if not(senderGrid.toCharID=-1) then
          for i:= 0 to length(core.GameData.RegenCode[charID].DataCode[posCode].NameCode)-1 do
          begin
            value:= core.GameData.getRegenValue(codeType,charID,i,true,senderGrid.toCharID);
            // filter valid value must [0,1,2,3]
            if (strtoint(value) in [0,1,2,3]) then
            begin
              codes:= core.GameData.getRegenCode(codeType,charID,i,senderGrid.toCharID);
              core.setFreezeData(codeGroup,core.GameData.RegenCode[charID].DataCode[posCode].NameCode[i],codes,value,
                freezeCBox[charID].Behavior[senderGrid.selRow-1],core.selectedSeat,senderGrid.selRow-1);
            end else
            // not valid value force break
              break;
          end;
      end;
    end;
    // feeling
    5: if not(core.selectedChar=-1) then
    begin
      senderGrid.toCharID:= gridToCharID[senderGrid.selRow-1];
      if not(senderGrid.toCharID=-1) then
      begin
        i:= senderGrid.selCol-1;
        value:= core.GameData.getRegenValue(codeType,charID,i,true,senderGrid.toCharID);
        codes:= core.GameData.getRegenCode(codeType,charID,i,senderGrid.toCharID);
        core.setFreezeData(codeGroup,core.GameData.RegenCode[charID].DataCode[posCode].NameCode[i],codes,value,
          enabled,core.selectedSeat,senderGrid.selRow-1);
      end;
    end;
    // lover
    6: if not(core.selectedChar=-1) then
    begin
      senderGrid.toCharID:= seatIndex[senderGrid.selRow-1];
      if not(senderGrid.toCharID=-1) then
      begin
        i:= senderGrid.selCol-1;
        unixID:= inttostr(codeType)+'_'+inttostr(charID)+'_'+inttostr(senderGrid.toCharID)+'_'+inttostr(i);
        value:= core.GameData.getRegenValue(codeType,charID,i,true,senderGrid.toCharID);
        codes:= core.GameData.getRegenCode(codeType,charID,i,senderGrid.toCharID);
        core.setFreezeData(codeGroup,core.GameData.RegenCode[charID].DataCode[posCode].NameCode[i],codes,value,
          enabled,core.selectedSeat,senderGrid.toCharID);
      end;
    end;
    // statusH
    7: if not(core.selectedChar=-1) then
    begin
      charID:= core.selectedSeat;
      senderGrid.toCharID:= core.getCharID(seatIndex[senderGrid.selRow-1]);
      if not(senderGrid.toCharID=-1) then
      begin
        i:= senderGrid.selCol-1;
        value:= core.GameData.getRegenValue(codeType,charID,i,true,senderGrid.toCharID);
        codes:= core.GameData.getRegenCode(codeType,charID,i,senderGrid.toCharID);
        core.setFreezeData(codeGroup,core.GameData.RegenCode[charID].DataCode[posCode].NameCode[i],codes,value,
          enabled,core.selectedSeat,seatIndex[senderGrid.selRow-1]);
      end;
    end;
  end;

  sleep(500);
  parseTabCode;
end;

procedure TMainForm.setOverlay(const showing: boolean = true);
begin
  if showing then
  begin
    if not(overlay.Visible) then
    begin
      overlay.Align:= alClient;
      overlay.Visible:= true;
      container.Visible:= false;
    end;
  end else
  begin
    if overlay.Visible then
    begin
      container.Visible:= true;
      sleep(500);
      overlay.Visible:= false;
      overlay.Align:= alNone;
      overlay.Width:= 10;
      overlay.Height:= 10;
    end;
  end;
end;

procedure TMainForm.resetAllComponent;
var i: integer;
begin
  for i:= 0 to ComponentCount-1 do
  if not(Components[i].tag=4131) then
  if (Components[i] is TEdit) then (Components[i] as TEdit).Text:= ''
  else if (Components[i] is TComboBox) then (Components[i] as TComboBox).ItemIndex:= -1
  else if (Components[i] is TJvSpinEdit) then (Components[i] as TJvSpinEdit).Value:= 0
  else if (Components[i] is TCheckBox) then (Components[i] as TCheckBox).Checked:= false
  else if (Components[i] is TJvColorButton) then (Components[i] as TJvColorButton).color:= clWhite
  else if (Components[i] is TJvTrackBar) then (Components[i] as TJvTrackBar).Position:= 0;

  for i:= 0 to PlanItems.TotalRow-1 do
  begin
    if not(PlanItems.Active[i]=nil) then PlanItems.Active[i].Free;
    if not(PlanItems.Seat[i]=nil) then PlanItems.Seat[i].Free;
    if not(PlanItems.Action[i]=nil) then PlanItems.Action[i].Free;
    if not(PlanItems.Triggered[i]=nil) then PlanItems.Triggered[i].Free;
    if not(PlanItems.Remove[i]=nil) then PlanItems.Remove[i].Free;
    if not(PlanItems.Selected[i]=nil) then PlanItems.Selected[i].Free;
  end;

  for i:= 0 to 2 do statusBar.Panels[i].Text:= '';
end;

procedure TMainForm.resizeForm;
begin
  container.Width:= 990;
end;

procedure TMainForm.setDefault;
begin
  resizeForm;
  
  core.clearAll;
  core.maxChar:= -1;
  classReady:= false;
  isReadData:= false;
  isWriteData:= false;
  pauseNPCTimer:= false;
  FreezeGroupCount:= 0;
  resetAllComponent;
  resetPlayerAct;

  readClass.Enabled:= false;
  if classExist AND (not(autoCreateClass.Checked) OR overlay.Visible) then
    readClass.Enabled:= true;
end;

procedure TMainForm.generateCode;
var i: integer;
begin
  for i:= 0 to codeStore.MultipleStrings.Count-1 do
  begin
    setlength(core.GameData.CodeKey,i+1);
    core.GameData.CodeKey[i]:= codeStore.MultipleStrings.Items[i].Name;
    core.GameData.generateCode(i,codeStore.MultipleStrings.Items[i].Strings);
  end;
end;

procedure TMainForm.createThumbList;
var i, seatNumber, charID: integer;
  PNG: TPNGObject;
begin
  thumbNPC.Clear;
  //exit;
  
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    charID:= core.getCharID(seatNumber);
    
    PNG:= TPNGObject.Create;
    try
      if not(charID=-1) then
        GraphicToPNG(core.ClassSeat[seatNumber].views.thumb, PNG)
      else
        GraphicToPNG(emptys, PNG);
      thumbNPC.InsertPng(seatNumber,PNG);
    finally
      PNG.Free;
    end;
  end;
end;

procedure TMainForm.initTabComponent;
const
  colRelationShip: array [0..11] of string = (
    'To NPC','Freeze',
    'Current','Love','Like','Dislike','Hate',
    'Poin','Love','Like','Dislike','Hate'
  );
  colLover: array [0..3] of string = ('To NPC','Lover','Days','Compatible');
  colStatusH: array [0..11] of string = ('To NPC','[1]Sex','[1]Vag','[1]Anal','[1]Condom','[1]Climax','[1]Stimulate','[2]Cum','[2]Vag','[2]Anal','[2]Swallow','[2]InRisk');
var i, ii, seatNumber: integer;
begin
  // unfreeze all grid checkbox
  for i:= 0 to 24 do
    for ii:= 0 to 24 do
      freezeCBox[i].Relationship[ii]:= false;

  // GRID RELATIONSHIP
  gridRelationship.Clear;
  gridRelationship.ColCount:= length(colRelationShip);
  gridRelationship.RowCount:= 26;
  gridRelationship.FixedCols:= 1;
  gridRelationship.FixedRows:= 1;
  gridRelationship.DefaultColWidth:= 50;
  gridRelationship.ColWidths[0]:= 130;
  for i:= 0 to gridRelationship.ColCount-1 do
    gridRelationship.Cols[i].Strings[0]:= colRelationShip[i];

  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    gridRelationship.Cols[0].Strings[i+1]:= inttostr(seatNumber)+'. - Empty - ';
  end;

  // GRID BEHAVIOR
  gridBehavior.Clear;
  gridBehavior.ColCount:= 32;
  gridBehavior.RowCount:= 26;
  gridBehavior.FixedCols:= 1;
  gridBehavior.FixedRows:= 1;
  gridBehavior.DefaultColWidth:= 50;

  gridBehavior.ColWidths[0]:= 130;

  gridBehavior.Cols[0].Strings[0]:= 'To NPC';
  gridBehavior.Cols[1].Strings[0]:= 'Freeze';
  for i:= 0 to gridBehavior.ColCount-1 do
    gridBehavior.Cols[i+2].Strings[0]:= inttostr(i+1);

  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    gridBehavior.Cols[0].Strings[i+1]:= inttostr(seatNumber)+'. - Empty - ';
  end;

  // GRID FEELINGS
  gridFeeling.Clear;
  gridFeeling.ColCount:= 87;
  gridFeeling.RowCount:= 26;
  gridFeeling.FixedCols:= 1;
  gridFeeling.FixedRows:= 1;
  gridFeeling.DefaultColWidth:= 50;

  gridFeeling.ColWidths[0]:= 130;

  gridFeeling.Cols[0].Strings[0]:= 'To NPC';
  for i:= 0 to gridFeeling.ColCount-2 do
    gridFeeling.Cols[i+1].Strings[0]:= inttostr(i)+'.'+StringStore.ItemByName['Feeling'].Strings[i];

  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    gridFeeling.Cols[0].Strings[i+1]:= inttostr(seatNumber)+'. - Empty - ';
  end;

  // GRID Lover
  gridLover.Clear;
  gridLover.ColCount:= length(collover);
  gridLover.RowCount:= 26;
  gridLover.FixedCols:= 1;
  gridLover.FixedRows:= 1;
  gridLover.DefaultColWidth:= 50;

  gridLover.ColWidths[0]:= 130;
  for i:= 0 to gridLover.ColCount-1 do
    gridLover.Cols[i].Strings[0]:= collover[i];

  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    gridLover.Cols[0].Strings[i+1]:= inttostr(seatNumber)+'. - Empty - ';
  end;

  // GRID StatusH
  gridStatus.Clear;
  gridStatus.ColCount:= length(colStatusH);
  gridStatus.RowCount:= 26;
  gridStatus.FixedCols:= 1;
  gridStatus.FixedRows:= 1;
  gridStatus.DefaultColWidth:= 50;

  gridStatus.ColWidths[0]:= 130;
  for i:= 0 to gridStatus.ColCount-1 do
    gridStatus.Cols[i].Strings[0]:= colStatusH[i];

  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    gridStatus.Cols[0].Strings[i+1]:= inttostr(seatNumber)+'. - Empty - ';
  end;
end;

procedure TMainForm.initTabCode;
begin
  UType.Clear;
  case strtoint(core.GameData.getValueByCode(core.GameData.getRegenCode(1,core.selectedChar,'Gender'),true)) of
    0: UType.Items.AddStrings(HEXAClothMM);
    1: UType.Items.AddStrings(HEXAClothFF);
  end;
end;

procedure TMainForm.clearGridID;
var i: integer;
begin
  if (length(gridToCharID)=0) then setlength(gridToCharID,25);
  for i:= 0 to 24 do
    gridToCharID[i]:= -1;
end;

procedure TMainForm.configTabs;
var
  tabTag, i: integer;
  codeName,StrValue: string;
begin
  isWriteData:= false;

  tabTag:= ConfigPage.Pages[ConfigPage.TabIndex].Tag;
  case tabTag of
    1,2,3,4,5:
    begin
      if (tabTag=2) AND (length(core.voiceConfig)>0) then
      for i:= 0 to 127 do
      begin
        if not(core.voiceConfig[i].VoiceID=nil) then
        core.voiceConfig[i].VoiceID.Checked:= strBool(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',core.voiceConfig[i].VoiceID.Name],true));
        if not(core.voiceConfig[i].VoiceVal=nil) then
        core.voiceConfig[i].VoiceVal.Position:= round(StrToFloat(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',core.voiceConfig[i].VoiceVal.Name],true)) * 100);
      end;

      for i:= 0 to ComponentCount-1 do
      begin
        codeName:= Components[i].Name;

        if (Components[i].Tag=((configTagRange)+4)) then TCheckBox(Components[i]).Checked:= strBool(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',codeName],true))
        else if (Components[i].Tag=((configTagRange)+5)) then TCheckBox(Components[i]).Checked:= not(strBool(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',codeName],true)))
        else if (Components[i].Tag=((configTagRange)+9)) then TJvTrackBar(Components[i]).Position:= StrToInt64(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',codeName],true))
        else if (Components[i].Tag=((configTagRange)+6)) then TRadioGroup(Components[i]).ItemIndex:= StrToInt(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',codeName],true))
        else if (Components[i].Tag=((configTagRange)+1)) then TJvTrackBar(Components[i]).Position:= round(StrToFloat(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',codeName],true)) * 100)
        else if (Components[i].Tag=((configTagRange)+3)) then TJvTrackBar(Components[i]).Position:= round(StrToFloat(core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',codeName],true)) * 10)
        else if (Components[i].Tag=((configTagRange)+2)) then
        begin
          strValue:= core.GameData.getValueByCode(core.GameData.CharCode.Data['gameConfig',codeName],true);
          if StrValue='0' then TJvTrackBar(Components[i]).Position:= 4000
          else TJvTrackBar(Components[i]).Position:= (StrToint64(StrValue)-4294963296);
        end;
      end;
    end;
  end;

  sleep(200);
  isWriteData:= true;
  isReadData:= true;

end;

{useless T_T}
procedure TMainForm.getBehaviorTotal(const charID: integer = -1);
var selChar,i,ii,t,tot: integer;
begin
  selChar:= core.selectedChar;
  if not(charID=-1)then selChar:= charID;

  SetLength(behaviorTotal,0);
  for i:= 0 to 24 do
  begin
    SetLength(behaviorTotal,i+1);
    tot:= 0;
    for ii:= 6 to 9 do
    begin
      if not(selChar=-1) then
        t:= strtoint(core.GameData.getRegenValue(3,selChar,ii,true,i,2));
      if (t=-1) then t:= 0;
      tot:= tot + t;
    end;
    behaviorTotal[i]:= tot;
  end;
end;

procedure TMainForm.setBinData(fieldName,value: string);
var fieldID: integer;
begin
  if (length(core.PasteBin.ListData)=0) then exit;
  
  fieldID:= ArrayIndexContainText(fieldName,core.PasteBin.FieldData,true);
  if not(fieldID=-1) then
    core.PasteBin.ListData[core.PasteBin.lastSelected].ValueData[fieldID]:= value;
end;

function TMainForm.getBinData(fieldName: string; const isNumber: boolean = false; const isNull: boolean = false): string;
var fieldID: integer;
begin
  Result:= '?????';
  if isNumber then Result:= '-1';

  fieldID:= ArrayIndexContainText(fieldName,core.PasteBin.FieldData,true);
  if not(fieldID=-1) then
    Result:= core.PasteBin.ListData[core.PasteBin.lastSelected].ValueData[fieldID];

  if isNull AND ((Result='')OR(Result[1]='?')) then
    Result:= '';
end;

procedure TMainForm.parseBinCode;
var
  tabTag,i: integer;
  strValue,codename: string;
begin
  if (length(core.PasteBin.ListData)=0) then exit;

  tabTag:= tabs.Pages[tabs.TabIndex].Tag;
  case tabTag of
    1,2,3,4,5:
    begin
      for i:= 0 to ComponentCount-1 do
      begin
        codeName:= Components[i].Name;
        if (tabTag=5) then
        case tOutfits.TabIndex of
          0: codeName:= 'Outfit'+codeName;
          1: codeName:= 'Sport'+codeName;
          2: codeName:= 'Swim'+codeName;
          3: codeName:= 'Club'+codeName;
        end;

        // edit
        if (Components[i].Tag=((tabTag*tabTagRange)+1)) then TEdit(Components[i]).Text:= getBinData(codeName,false,true)
        // memo
        else if (Components[i].Tag=((tabTag*tabTagRange)+15)) then TMemo(Components[i]).Lines.Text:= getBinData(codeName,false,true)
        // combo
        else if (Components[i].Tag=((tabTag*tabTagRange)+2)) then TComboBox(Components[i]).ItemIndex:= strtoint(getBinData(codeName,true))
        // spin
        else if (Components[i].Tag=((tabTag*tabTagRange)+3)) then TJvSpinEdit(Components[i]).Value:= strtoint(getBinData(codeName,true))
        // checkbox
        else if (Components[i].Tag=((tabTag*tabTagRange)+4)) then TCheckBox(Components[i]).Checked:= strBool(getBinData(codeName,true))
        // color
        else if (Components[i].Tag=((tabTag*tabTagRange)+5)) then TJvColorButton(Components[i]).Color:= HexStringToColor(dec2hex(strtoint64(getBinData(codeName,true)),8))
        // image box
        else if (Components[i].Tag=((tabTag*tabTagRange)+6)) then TJvImageComboBox(Components[i]).ItemIndex:= strtoint(getBinData(codeName,true))
        // trackbar
        else if (Components[i].Tag=((tabTag*tabTagRange)+7)) then TJvTrackBar(Components[i]).Position:= strtoint(getBinData(codeName,true))
        // academic value
        else if (Components[i].Tag=((tabTag*tabTagRange)+8)) then TComboBox(Components[i]).ItemIndex:= strtoint(getBinData(codeName,true))+1
        // rei personal
        else if (Components[i].Tag=((tabTag*tabTagRange)+9)) then
        begin
          strValue:= getBinData(codeName,true);
          if (StrToInt(strValue)<10) then strValue:= '0'+strValue;
          TComboBox(Components[i]).ItemIndex:= REIPersonality.IndexOfName(strValue);
        end
        // hexa cloth
        else if (Components[i].Tag=((tabTag*tabTagRange)+10)) then
        begin
          strValue:= getBinData(codeName,true);
          if (StrToInt(strValue)<10) then strValue:= '0'+strValue;
          case strtoint(getBinData('Gender',true)) of
            0: TComboBox(Components[i]).ItemIndex:= HEXAClothM.IndexOfName(strValue);
            1: TComboBox(Components[i]).ItemIndex:= HEXAClothF.IndexOfName(strValue);
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.parseTabCode;
type
  TTempGrid = record
   setBreak: boolean;
   setValue: array [0..10] of integer;
   setSeat : array of integer;
  end;
const
  setLove: array [0..3] of string = ('Love','Like','Dislike','Hate');
  setMax : array [0..2] of string = ('Max','Medium','Low');
  setFact: array [0..2] of string = ('Academic','Sport','Club');
  setMeet: array [0..2] of string = ('Result','Seat','Location');
  setLewd: array [0..2] of string = ('Seat','Fact','Righ');
var i, ii, tabTag, seatNumber, toCharID, codeID: integer;
  strValue, codeName, freezeID, unixID: string;
  skipedCol, freezeCol: boolean;
  lstItem: TListItem;
  tempGrid : array [0..5] of TTempGrid;
begin
  StringGridHideEditor;

  if isBinView then exit;
  isWriteData:= false;

  tabTag:= tabs.Pages[tabs.TabIndex].Tag;
  case tabTag of
    1,2,3,4,5:
    begin
      codeID:= ArrayIndexContainText('PersonalCode',core.GameData.codeKey,true);
      for i:= 0 to ComponentCount-1 do
      begin
        codeName:= Components[i].Name;
        if (tabTag=5) then
        case tOutfits.TabIndex of
          0: codeName:= 'Outfit'+codeName;
          1: codeName:= 'Sport'+codeName;
          2: codeName:= 'Swim'+codeName;
          3: codeName:= 'Club'+codeName;
        end;

        // edit
        if (Components[i].Tag=((tabTag*tabTagRange)+1)) then TEdit(Components[i]).Text:= core.GameData.getRegenValue(codeID,core.selectedChar,codeName,false,-1,0,true) //core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),false,true)
        // memo
        else if (Components[i].Tag=((tabTag*tabTagRange)+15)) then TMemo(Components[i]).Lines.Text:= core.GameData.getRegenValue(codeID,core.selectedChar,codeName,false,-1,0,true) //core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),false,true)
        // combo
        else if (Components[i].Tag=((tabTag*tabTagRange)+2)) then TComboBox(Components[i]).ItemIndex:= strtoint(core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0)) //strtoint(core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true))
        // spin
        else if (Components[i].Tag=((tabTag*tabTagRange)+3)) then TJvSpinEdit(Components[i]).Value:= strtoint(core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0)) //strtoint(core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true))
        // checkbox
        else if (Components[i].Tag=((tabTag*tabTagRange)+4)) then TCheckBox(Components[i]).Checked:= strBool(core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0)) //strBool(core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true))
        // color
        else if (Components[i].Tag=((tabTag*tabTagRange)+5)) then TJvColorButton(Components[i]).Color:= HexStringToColor(dec2hex(strtoint64(core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0)),8)) //HexStringToColor(dec2hex(strtoint64(core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true)),8))
        // image box
        else if (Components[i].Tag=((tabTag*tabTagRange)+6)) then TJvImageComboBox(Components[i]).ItemIndex:= strtoint(core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0)) //strtoint(core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true))
        // trackbar
        else if (Components[i].Tag=((tabTag*tabTagRange)+7)) then TJvTrackBar(Components[i]).Position:= strtoint(core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0)) //strtoint(core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true))
        // academic value
        else if (Components[i].Tag=((tabTag*tabTagRange)+8)) then TComboBox(Components[i]).ItemIndex:= strtoint(core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0))+1 //strtoint(core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true))+1
        // rei personal
        else if (Components[i].Tag=((tabTag*tabTagRange)+9)) then
        begin
          strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0); //core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true);
          if (StrToInt(strValue)<10) then strValue:= '0'+strValue;
          TComboBox(Components[i]).ItemIndex:= REIPersonality.IndexOfName(strValue);
        end
        // hexa cloth
        else if (Components[i].Tag=((tabTag*tabTagRange)+10)) then
        begin
          strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,codeName,true,-1,0);// core.GameData.getValueByCode(core.GameData.getRegenCode(codeID,core.selectedChar,codeName),true);
          if (StrToInt(strValue)<10) then strValue:= '0'+strValue;
          case strtoint(core.GameData.getRegenValue(codeID,core.selectedChar,'Gender',true,-1,0)) of
            0: TComboBox(Components[i]).ItemIndex:= HEXAClothM.IndexOfName(strValue);
            1: TComboBox(Components[i]).ItemIndex:= HEXAClothF.IndexOfName(strValue);
          end;
        end;

        //freezeID:= core.GameData.CharCode.Data['FreezeData',inttostr(codeID)+'_'+inttostr(core.selectedChar)+'_-1_'+codeName];
        //if not(freezeID='') then if core.GameData.FreezeData[strtoint(freezeID)].isFreeze then
      end;
    end;
    // behavior grid
    6: begin
      //getBehaviorTotal;
      clearGridID;
      codeID:= ArrayIndexContainText('Behavior',core.GameData.codeKey,true);
      toCharID:= 0;
      for i:= 0 to 24 do
      begin
        freezeCol:= false;
        seatNumber:= core.getSeatID(i);

        if not(seatNumber=-1) then
        begin
          // skip current selected char
          if (i=core.selectedChar) then
          begin
            gridBehavior.Rows[seatNumber+1].Strings[0]:= inttostr(seatNumber)+'.- Self -';
            for ii:= 2 to gridBehavior.ColCount-1 do
              gridBehavior.Rows[seatNumber+1].Strings[ii]:= '';
            continue;
          end;

          gridToCharID[seatNumber]:= toCharID;
          gridBehavior.Rows[seatNumber+1].Strings[0]:= core.Classseat[seatNumber].listName;
          skipedCol:= false;
          for ii:= 2 to gridBehavior.ColCount-1 do
          begin

            if not(skipedCol) then
            begin
              // first check number of behavior from array
              {if (ii > behaviorTotal[toCharID]) then skipedCol:= true
              else
              begin}
                strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,ii-2,true,toCharID);
                if (strValue='') OR (strValue[1]='?') OR not(strtoint64(strValue) in [0,1,2,3]) then
                  skipedCol:= true
                else gridBehavior.Rows[seatNumber+1].Strings[ii]:= setLove[strtoint(strValue)];
              //end;

              if not(freezeCol) AND (ii=2) then
              begin
                unixID:= 'Behavior_Level0_'+inttostr(core.selectedSeat)+'_'+inttostr(seatNumber);
                freezeID:= core.GameData.CharCode.Data['FreezeData',unixID];
                if not(freezeID='') then if core.GameData.FreezeData[strtoint(freezeID)].isFreeze then freezeCol:= true;
              end;
            end;
            if skipedCol then gridBehavior.Rows[seatNumber+1].Strings[ii]:= '';
          end;
          // @todo: checked if one col freeze
          freezeCBox[core.selectedChar].Behavior[seatNumber]:= freezeCol;
        end;
        inc(toCharID);
      end;
      gridBehavior.Invalidate;
    end;
    // relationship grid
    7: begin
      clearGridID;
      codeID:= ArrayIndexContainText('Relationship',core.GameData.codeKey,true);
      toCharID:= 0;
      for i:= 0 to 24 do
      begin
        skipedCol:= false;
        seatNumber:= core.getSeatID(i);

        if not(seatNumber=-1) and not(toCharID>=24) then
        begin
          // skip current selected char
          if (i=core.selectedChar) then
          begin
            gridRelationship.Rows[seatNumber+1].Strings[0]:= inttostr(seatNumber)+'.- Self -';
            for ii:= 2 to gridRelationship.ColCount-1 do
              gridRelationship.Rows[seatNumber+1].Strings[ii]:= '';
            continue;
          end;

          gridToCharID[seatNumber]:= toCharID;
          gridRelationship.Rows[seatNumber+1].Strings[0]:= core.Classseat[seatNumber].listName;
          for ii:= 2 to gridRelationship.ColCount-1 do
          begin
            strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,ii-2,true,toCharID);
            if not(strValue='') AND not(strValue[1]='?') AND (strtoint(strvalue)>=0) AND (strtoint(strvalue)<=30) then
            begin
              case (ii-2) of
                0: strValue:= setLove[strtoint(strValue)];
                1,2,3,4: strValue:= setMax[strtoint(strValue)];
              end;

              if not(skipedCol) AND (ii=3) then
              begin
                unixID:= 'Relationship_LoveMax_'+inttostr(core.selectedSeat)+'_'+inttostr(seatNumber);
                freezeID:= core.GameData.CharCode.Data['FreezeData',unixID];
                if not(freezeID='') then if core.GameData.FreezeData[strtoint(freezeID)].isFreeze then skipedCol:= true;
              end;
            end else
            case (ii-2) of
              0,1,2,3,4: strValue:= '';
              else strValue:= '0';
            end;

            gridRelationship.Rows[seatNumber+1].Strings[ii]:= strValue;
          end;

          // @todo: checked if one col freeze
          freezeCBox[core.selectedChar].Relationship[seatNumber]:= skipedCol;

        end;
        inc(toCharID);
      end;

      gridRelationship.Invalidate;
    end;
    // lover grid
    8: begin
      codeID:= ArrayIndexContainText('Lovers',core.GameData.codeKey,true);
      for i:= 0 to 24 do
      begin
        seatNumber:= seatIndex[i];
        toCharID:= core.getCharID(seatNumber);

        // skip current selected char
        if (toCharID=core.selectedChar) then
        begin
          gridLover.Rows[i+1].Strings[0]:= inttostr(seatNumber)+'.- Self -';
          for ii:= 1 to gridLover.ColCount-1 do
            gridLover.Rows[i+1].Strings[ii]:= '';
          continue;
        end;

        if not(toCharID=-1) then
        begin
          gridLover.Rows[i+1].Strings[0]:= core.Classseat[seatNumber].listName;
          for ii:= 1 to gridLover.ColCount-1 do
          begin
            gridLover.Rows[i+1].Strings[ii]:= '';
            strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,ii-1,true,seatNumber);
            if (strValue='') OR (strValue[1]='?') then
              strValue:= '0';

            if not(strValue='0') then
            begin
              //unixID:= 'Lovers_'+core.GameData.RegenCode[core.selectedChar].DataCode[3].NameCode[ii-1]+'_'+inttostr(core.selectedSeat)+'_'+inttostr(seatNumber);
              //freezeID:= core.GameData.CharCode.Data['FreezeData',unixID];
              //if not(freezeID='') then if core.GameData.FreezeData[strtoint(freezeID)].isFreeze then strValue:= '[*] '+strValue;
            end;

            gridLover.Rows[i+1].Strings[ii]:= strValue;
          end;
        end;
      end;
    end;
    // feeling grid
    9: begin
      clearGridID;
      codeID:= ArrayIndexContainText('Feeling',core.GameData.codeKey,true);
      toCharID:= 0; 
      for i:= 0 to 24 do
      begin
        seatNumber:= core.getSeatID(i);

        if not(seatNumber=-1) then
        begin
          // skip current selected char
          if (i=core.selectedChar) then
          begin
            gridFeeling.Rows[seatNumber+1].Strings[0]:= inttostr(seatNumber)+'.- Self -';
            for ii:= 1 to gridFeeling.ColCount-1 do
              gridFeeling.Rows[seatNumber+1].Strings[ii]:= '';
            continue;
          end;

          gridToCharID[seatNumber]:= toCharID;
          gridFeeling.Rows[seatNumber+1].Strings[0]:= core.Classseat[seatNumber].listName;
          for ii:= 1 to gridFeeling.ColCount-1 do
          begin
            gridFeeling.Rows[seatNumber+1].Strings[ii]:= '';
            strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,ii-1,true,toCharID);
            if not(strValue='') AND not(strValue[1]='?') then
            begin
              if (strtoint(strValue) in [0,1,2,3]) then
              begin
                {case strtoint(strValue) of
                  0: strValue:= 'False';
                  1: strValue:= 'True';
                end;}

                // check freeze state
                //freezeID:= core.GameData.CharCode.Data['FreezeData',inttostr(codeID)+'_'+inttostr(core.selectedChar)+'_'+inttostr(toCharID)+'_'+inttostr(ii-1)];
                //if not(freezeID='') then if core.GameData.FreezeData[strtoint(freezeID)].isFreeze then strValue:= '[*] '+strValue;

                gridFeeling.Rows[seatNumber+1].Strings[ii]:= strValue;
              end;
            end;
          end;
        end;
        inc(toCharID);
      end;
    end;
    // statusH grid
    10: begin
      codeID:= ArrayIndexContainText('StatusH',core.GameData.codeKey,true);
      for i:= 0 to 24 do
      begin
        seatNumber:= seatIndex[i];
        toCharID:= core.getCharID(seatNumber);

        // skip current selected char
        if (toCharID=core.selectedChar) then
        begin
          gridStatus.Rows[i+1].Strings[0]:= inttostr(seatNumber)+'.- Self -';
          for ii:= 1 to gridStatus.ColCount-1 do
            gridStatus.Rows[i+1].Strings[ii]:= '';
          continue;
        end;

        if not(toCharID=-1) then
        begin
          gridStatus.Rows[i+1].Strings[0]:= core.Classseat[seatNumber].listName;
          for ii:= 1 to gridStatus.ColCount-1 do
          begin
            gridStatus.Rows[i+1].Strings[ii]:= '';
            strValue:= core.GameData.getRegenValue(codeID,core.selectedSeat,ii-1,true,toCharID);
            if (strValue='') OR (strValue[1]='?') then
              strValue:= '0';

            if not(strValue='0') then
            begin
              //unixID:= 'StatusH_'+core.GameData.RegenCode[core.selectedChar].DataCode[4].NameCode[ii-1]+'_'+inttostr(core.selectedSeat)+'_'+inttostr(seatNumber);
              //freezeID:= core.GameData.CharCode.Data['FreezeData',unixID];
              //if not(freezeID='') then if core.GameData.FreezeData[strtoint(freezeID)].isFreeze then strValue:= '[*] '+strValue;
            end;

            gridStatus.Rows[i+1].Strings[ii]:= strValue;
          end;
        end;
      end;
    end;
    // Promise
    11: begin
      // prepairing
      gMeetPromiseTo.Items.Clear;
      gLewdPromiseTo.Items.Clear;
      gDatePromiseTo.Items.Clear;
      gMeetPromiseFrom.Items.Clear;
      gLewdPromiseFrom.Items.Clear;
      gDatePromiseFrom.Items.Clear;
      for i:= 0 to 5 do
      begin
        tempGrid[i].setBreak:= false;
        SetLength(tempGrid[i].setSeat,0);
        for ii:= 0 to 10 do
          tempGrid[i].setValue[ii]:= -1;
      end;

      codeID:= ArrayIndexContainText('Promise',core.GameData.codeKey,true);
      for i:= 0 to 24 do
      begin
        seatNumber:= seatIndex[i];
        toCharID:= core.getCharID(seatNumber);
        if not(toCharID=-1) then
        begin

          // MEET TO GRID
          if not(tempGrid[0].setBreak) then
          begin
            
            // first check the valid value
            for ii:= 0 to 2 do
            begin
              strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,'MeetTo'+setMeet[ii],true,i,7);
              if not(strValue='') AND not(strValue[1]='?') AND not(strtoint64(strValue)>56) then
              begin
                case ii of
                0: if (strtoint(strValue) in [0,1]) then tempGrid[0].setValue[ii]:= strtoint(strValue)
                  else tempGrid[0].setBreak:= true;
                1: if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=24)) then
                  if not(inTArray(strtoint(strValue),tempGrid[0].setSeat)) then
                  begin
                    SetLength(tempGrid[0].setSeat,length(tempGrid[0].setSeat)+1);
                    tempGrid[0].setSeat[length(tempGrid[0].setSeat)-1]:= strtoint(strValue);
                    tempGrid[0].setValue[ii]:= strtoint(strValue);
                  end else tempGrid[0].setBreak:= true;
                2: if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=56)) then tempGrid[0].setValue[ii]:= strtoint(strValue)
                  else tempGrid[0].setBreak:= true;
                end;
              end else
                tempGrid[0].setBreak:= true;
            end;

            // set to grid
            if not(tempGrid[0].setBreak) then
            begin
              lstItem:= gMeetPromiseTo.Items.Add;
              lstItem.StateIndex:= tempGrid[0].setValue[2];
              lstItem.ImageIndex:= tempGrid[0].setValue[1];
              lstItem.Caption:= '  False';
              if (tempGrid[0].setValue[0]=1) then lstItem.Caption:= '  True';
            end;
          end;

          // MEET FROM GRID
          if not(tempGrid[1].setBreak) then
          begin
            
            // first check the valid value
            for ii:= 0 to 2 do
            begin
              strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,'MeetFrom'+setMeet[ii],true,i,7);
              if not(strValue='') AND not(strValue[1]='?') AND not(strtoint64(strValue)>56) then
              begin
                case ii of
                0: if (strtoint(strValue) in [0,1]) then tempGrid[1].setValue[ii]:= strtoint(strValue)
                  else tempGrid[1].setBreak:= true;
                1: if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=24)) then
                  if not(inTArray(strtoint(strValue),tempGrid[1].setSeat)) then
                  begin
                    SetLength(tempGrid[1].setSeat,length(tempGrid[1].setSeat)+1);
                    tempGrid[1].setSeat[length(tempGrid[1].setSeat)-1]:= strtoint(strValue);
                    tempGrid[1].setValue[ii]:= strtoint(strValue);
                  end else tempGrid[1].setBreak:= true;
                2: if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=56)) then tempGrid[1].setValue[ii]:= strtoint(strValue)
                  else tempGrid[1].setBreak:= true;
                end;
              end else
                tempGrid[1].setBreak:= true;
            end;

            // set to grid
            if not(tempGrid[1].setBreak) then
            begin
              lstItem:= gMeetPromiseFrom.Items.Add;
              lstItem.StateIndex:= tempGrid[1].setValue[2];
              lstItem.ImageIndex:= tempGrid[1].setValue[1];
              lstItem.Caption:= '  False';
              if (tempGrid[1].setValue[0]=1) then lstItem.Caption:= '  True';
            end;
          end;

          // LEWD TO GRID
          if not(tempGrid[2].setBreak) then
          begin

            // first check the valid value
            for ii:= 0 to 2 do
            begin
              strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,'LewdTo'+setLewd[ii],true,i,7);
              if not(strValue='') AND not(strValue[1]='?') AND not(strValue='-1') AND not(strtoint64(strValue)>24) then
              begin
                case ii of
                0: if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=24)) then
                  if not(inTArray(strtoint(strValue),tempGrid[2].setSeat)) then
                  begin
                    SetLength(tempGrid[2].setSeat,length(tempGrid[2].setSeat)+1);
                    tempGrid[2].setSeat[length(tempGrid[2].setSeat)-1]:= strtoint(strValue);
                    tempGrid[2].setValue[ii]:= strtoint(strValue);
                  end else tempGrid[2].setBreak:= true;
                1: if (strtoint(strValue) in [0,1,2]) then tempGrid[2].setValue[ii]:= strtoint(strValue)
                  else tempGrid[2].setBreak:= true;
                2: if (strtoint(strValue) in [0,1]) then tempGrid[2].setValue[ii]:= strtoint(strValue)
                  else tempGrid[2].setBreak:= true;
                end;
              end else
                tempGrid[2].setBreak:= true;
            end;

            // set to grid
            if not(tempGrid[2].setBreak) then
            begin
              lstItem:= gLewdPromiseTo.Items.Add;
              lstItem.ImageIndex:= tempGrid[2].setValue[0];
              lstItem.Caption:= '  '+setFact[tempGrid[2].setValue[1]]+' - Not Now';
              if (tempGrid[2].setValue[2]=1) then lstItem.Caption:= '  '+setFact[tempGrid[2].setValue[1]]+' - Yes';
            end;
          end;

          // LEWD FROM GRID
          if not(tempGrid[3].setBreak) then
          begin

            // first check the valid value
            for ii:= 0 to 2 do
            begin
              strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,'LewdFrom'+setLewd[ii],true,i,7);
              if not(strValue='') AND not(strValue[1]='?') AND not(strValue='-1') AND not(strtoint64(strValue)>24) then
              begin
                case ii of
                0: if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=24)) then
                  if not(inTArray(strtoint(strValue),tempGrid[3].setSeat)) then
                  begin
                    SetLength(tempGrid[3].setSeat,length(tempGrid[3].setSeat)+1);
                    tempGrid[3].setSeat[length(tempGrid[3].setSeat)-1]:= strtoint(strValue);
                    tempGrid[3].setValue[ii]:= strtoint(strValue);
                  end else tempGrid[3].setBreak:= true;
                1: if (strtoint(strValue) in [0,1,2]) then tempGrid[3].setValue[ii]:= strtoint(strValue)
                  else tempGrid[3].setBreak:= true;
                2: if (strtoint(strValue) in [0,1]) then tempGrid[3].setValue[ii]:= strtoint(strValue)
                  else tempGrid[3].setBreak:= true;
                end;
              end else
                tempGrid[3].setBreak:= true;
            end;

            // set to grid
            if not(tempGrid[3].setBreak) then
            begin
              lstItem:= gLewdPromiseFrom.Items.Add;
              lstItem.ImageIndex:= tempGrid[3].setValue[0];
              lstItem.Caption:= '  '+setFact[tempGrid[3].setValue[1]]+' - Not Now';
              if (tempGrid[3].setValue[2]=1) then lstItem.Caption:= '  '+setFact[tempGrid[3].setValue[1]]+' - Yes';
            end;
          end;

          // DATE TO GRID
          if not(tempGrid[4].setBreak) then
          begin
            tempGrid[4].setBreak:= true;

            // first check the valid value
            strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,'DateTo',true,i,7);
            if not(strValue='') AND not(strValue[1]='?') AND not(strValue='-1') AND not(strtoint64(strValue)>24) then
              if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=24)) then
                if not(inTArray(strtoint(strValue),tempGrid[4].setSeat)) then
                begin
                  SetLength(tempGrid[4].setSeat,length(tempGrid[4].setSeat)+1);
                  tempGrid[4].setSeat[length(tempGrid[4].setSeat)-1]:= strtoint(strValue);
                  tempGrid[4].setValue[0]:= strtoint(strValue);
                  tempGrid[4].setBreak:= false;
                end;

            // set to grid
            if not(tempGrid[4].setBreak) then
            begin
              lstItem:= gDatePromiseTo.Items.Add;
              lstItem.ImageIndex:= tempGrid[4].setValue[0];
              lstItem.Caption:= '  '+core.ClassSeat[tempGrid[4].setValue[0]].listName;
            end;
          end;

          // DATE FROM GRID
          if not(tempGrid[5].setBreak) then
          begin
            tempGrid[5].setBreak:= true;

            // first check the valid value
            strValue:= core.GameData.getRegenValue(codeID,core.selectedChar,'DateFrom',true,i,7);
            if not(strValue='') AND not(strValue[1]='?') AND not(strValue='-1') AND not(strtoint64(strValue)>24) then
              if ((strtoint(strValue)>=0) AND (strtoint(strValue)<=24)) then
                if not(inTArray(strtoint(strValue),tempGrid[5].setSeat)) then
                begin
                  SetLength(tempGrid[5].setSeat,length(tempGrid[5].setSeat)+1);
                  tempGrid[5].setSeat[length(tempGrid[5].setSeat)-1]:= strtoint(strValue);
                  tempGrid[5].setValue[0]:= strtoint(strValue);
                  tempGrid[5].setBreak:= false;
                end;

            // set to grid
            if not(tempGrid[5].setBreak) then
            begin
              lstItem:= gDatePromiseFrom.Items.Add;
              lstItem.ImageIndex:= tempGrid[5].setValue[0];
              lstItem.Caption:= '  '+core.ClassSeat[tempGrid[5].setValue[0]].listName;
            end;
          end;

        end;
      end;
    end;
  end;

  sleep(200);
  isReadData:= true;
  isWriteData:= true;
end;

function TMainForm.getRandomFeeling(relID,charID,toCharID: integer): string;
var i: integer;
  getValue: string;
  getFeels: array of integer;
begin
  Result:= '8. '+StringStore.ItemByName['feeling'].Strings.Strings[8];

  for i:= 0 to 64 do
  begin
    getValue:= core.GameData.getRegenValue(5,charID,i,true,toCharID);
    if (getValue='1') then
    begin
      SetLength(getFeels,length(getFeels)+1);
      getFeels[length(getFeels)-1]:= i;
    end;
  end;

  if (Length(getFeels)>0) then
  begin
    i:= RandomFrom(getFeels);
    Result:= inttostr(i)+'. '+StringStore.ItemByName['feeling'].Strings.Strings[i];
  end;
end;

procedure TMainForm.redrawSeatBox;
var
  i, seatNumber, charID, toCharID, skipID,
  sstate, slove, slike, sdislike, shate: integer;
  tempStr: string;
begin
  skipID:= 0;
  if not(core.selectedChar=-1) then
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    toCharID:= core.getCharID(seatNumber);
    if not(toCharID=-1) then
    begin
      // for lover
      core.ClassSeat[seatNumber].views.isLover.Visible:= false;
      if not(seatNumber=core.selectedSeat) AND (core.GameData.getRegenValue(6,core.selectedChar,'Love',true,seatNumber) = '1') then
        core.ClassSeat[seatNumber].views.isLover.Visible:= true;

      // for ignored
      core.ClassSeat[seatNumber].views.isIgnore.Visible:= false;
      if not(seatNumber=core.selectedSeat) AND (core.ClassSeat[core.selectedSeat].ignoredSeat.IndexOfName(inttostr(seatNumber))>=0) then
        core.ClassSeat[seatNumber].views.isIgnore.Visible:= true;

      // for box color
      if (seatNumber=24) then
        core.ClassSeat[seatNumber].views.seatBox.Color:= cdefBTeacher.Color
      else
      case strtoint(core.GameData.getCodes(1,'Gender',tocharID,true)) of
        0: core.ClassSeat[seatNumber].views.seatBox.Color:= cdefBMale.Color;
        1: core.ClassSeat[seatNumber].views.seatBox.Color:= cdefBFemale.Color;
      end;
      core.ClassSeat[seatNumber].views.seatBox.HotTrackOptions.Color:= core.ClassSeat[seatNumber].views.seatBox.Color;

      // for played char box color
      if (toCharID=core.playedChar) then
        core.ClassSeat[seatNumber].views.seatBox.Color:= cdefBPlayed.Color;
    end;

    // for relationship & feeling
    seatNumber:= core.getSeatID(i);
    if not(seatNumber=-1) then
    if (seatNumber=core.selectedSeat) then core.ClassSeat[seatNumber].views.feelings.Visible:= false
    else
    begin
      if CharacterToOther.Checked then
      begin
        slove:= strtoint(core.GameData.getRegenValue(3,core.selectedChar,1,true,skipID));
        slike:= strtoint(core.GameData.getRegenValue(3,core.selectedChar,2,true,skipID));
        sdislike:= strtoint(core.GameData.getRegenValue(3,core.selectedChar,3,true,skipID));
        shate:= strtoint(core.GameData.getRegenValue(3,core.selectedChar,4,true,skipID));
        tempStr:= getRandomFeeling(sstate,core.selectedChar,skipID);
        //core.ClassSeat[seatNumber].views.seatNum.Caption:= '['+inttostr(seatNumber)+'|'+inttostr(core.getCharID(seatNumber))+']'+inttostr(skipID);
      end else
      begin
        charID:= core.selectedChar;
        toCharID:= core.getCharID(seatNumber);
        if (charID > toCharID) then dec(charID);
        slove:= strtoint(core.GameData.getRegenValue(3,toCharID,1,true,charID));
        slike:= strtoint(core.GameData.getRegenValue(3,toCharID,2,true,charID));
        sdislike:= strtoint(core.GameData.getRegenValue(3,toCharID,3,true,charID));
        shate:= strtoint(core.GameData.getRegenValue(3,toCharID,4,true,charID));
        tempStr:= getRandomFeeling(sstate,toCharID,charID);
        //core.ClassSeat[seatNumber].views.seatNum.Caption:= '['+inttostr(seatNumber)+'|'+inttostr(core.getCharID(seatNumber))+']'+inttostr(charID)+'|'+inttostr(toCharID);
      end;

      sstate:= 4;
      if (slove in [0,1]) then sstate:= 0
      else if (slike in [0,1]) then sstate:= 1
      else if (sdislike in [0,1]) then sstate:= 2
      else if (shate in [0,1]) then sstate:= 3;

      case sstate of
        0: core.ClassSeat[seatNumber].views.seatBox.FlatBorderColor:= cdefOLove.Color;
        1: core.ClassSeat[seatNumber].views.seatBox.FlatBorderColor:= cdefOLike.Color;
        2: core.ClassSeat[seatNumber].views.seatBox.FlatBorderColor:= cdefODislike.Color;
        3: core.ClassSeat[seatNumber].views.seatBox.FlatBorderColor:= cdefOHate.Color;
        else core.ClassSeat[seatNumber].views.seatBox.FlatBorderColor:= cdefONever.Color;
      end;

      if not(core.ClassSeat[seatNumber].views.feelings.Visible) then
        core.ClassSeat[seatNumber].views.feelings.Visible:= true;

      core.ClassSeat[seatNumber].views.feelings.Hint:= tempStr;
      core.ClassSeat[seatNumber].views.feelings.Caption:= strPad(tempStr,25);

      inc(skipID);
    end;
  end;
end;

procedure TMainForm.loadCharacter;
begin
  if classReady and not(core.getCharID(core.selectedSeat)=-1) then
  begin
    if not(core.ClassSeat[core.selectedSeat].isEmpty) then
    begin
      personalData.Caption:= '.:: Personal Data ( '+inttostr(core.selectedSeat)+'. '+core.ClassSeat[core.selectedSeat].views.firstName.Caption+' '+core.ClassSeat[core.selectedSeat].views.lastName.Caption+' )';
      //potraitImage.Picture:= core.ClassSeat[core.selectedSeat].views.thumb.Picture;
      
      {
      if not(core.ClassSeat[core.selectedSeat].potrait=nil) then
      begin
        if core.ClassSeat[core.selectedSeat].potrait.ShowHint then
        begin
          core.getThumbnail(core.selectedChar,true);
          core.ClassSeat[core.selectedSeat].potrait.ShowHint:= false;
        end;

        potraitImage.Picture:= core.ClassSeat[core.selectedSeat].potrait.Picture;
      end;
      }

      initTabCode;
      parseTabCode;
    end;
  end else
  begin
    personalData.Caption:= '.:: Personal Data ( - Empty Seat - )';
  end;
end;

procedure TMainForm.selectedNPC(Sender: TObject);
var
  i: integer;
  lstStr: TStrings;
begin
  // lst char
  if (Sender is TJvImageListBox) then
  begin
    core.selectedSeat:= seatIndex[TJvImageListBox(sender).ItemIndex];
    core.selectedChar:= core.getCharID(core.selectedSeat);
  end;

  // disable all selected
  for i:= 0 to 24 do
  begin
    core.ClassSeat[i].views.seatBox.BorderWidth:= 3;
    core.ClassSeat[i].views.seatBox.FlatBorderColor:= cdefOSeat.Color;
    if (Sender is TJvImageListBox) then
      if (i=core.selectedSeat) then
      begin
        core.ClassSeat[i].views.seatBox.BorderWidth:= 4;
        core.ClassSeat[i].views.seatBox.FlatBorderColor:= cdefOSelSeat.Color;
      end;
  end;

  // selected seat
  if (Sender is TJvPanel) then
  begin
    TJvPanel(Sender).BorderWidth:= 4;
    TJvPanel(Sender).FlatBorderColor:= cdefOSelSeat.Color;

    lstStr:= TStringList.Create;
    try
      lstStr.AddStrings(Explode('_',TJvPanel(Sender).Name));
      core.selectedSeat:= strtoint(lstStr.Strings[1]);
      core.selectedChar:= core.getCharID(core.selectedSeat);

      if (lstChar.Count>0) then
        lstChar.ItemIndex:= ArrayIndexContainInteger(core.selectedSeat,seatIndex);
    finally
      lstStr.Free;
    end;
  end;

  if (core.selectedChar=-1) then core.selectedSeat:= -1;

  redrawSeatBox;
end;

procedure TMainForm.selectedNPCW(Sender: TObject);
begin
  if (TComponent(sender).Tag>=0) AND (TComponent(sender).Tag<=24) then
    selectedNPC(core.ClassSeat[TComponent(sender).Tag].views.seatBox);
end;

procedure TMainForm.selectedNPCDblClick(Sender: TObject);
begin
  selectedNPC(Sender);
  loadCharacter;

  if personalData.Collapsed then
    personalData.Expand;
end;

procedure TMainForm.selectedNPCDblClickW(Sender: TObject);
begin
  if (TComponent(sender).Tag>=0) AND (TComponent(sender).Tag<=25) then
    selectedNPCDblClick(core.ClassSeat[TComponent(sender).Tag].views.seatBox);
end;

procedure TMainForm.PopupGridSetValue(codeType, codeIndex: integer; value: string; const Rows: integer = -1);
var
  toCharID: integer;
begin
  toCharID:= Rows;
  if (toCharID=-1) then
    toCharID:= senderGrid.selRow-1;

  senderGrid.toCharID:= gridToCharID[toCharID];
  case codeType of
    6: senderGrid.toCharID:= seatIndex[toCharID];
    7: senderGrid.toCharID:= core.getCharID(seatIndex[toCharID]);
  end;

  if not(senderGrid.toCharID=-1) then
    core.GameData.setRegenValue(codeType,core.selectedChar,codeIndex,value,senderGrid.toCharID);
end;

procedure TMainForm.StringGridSetValue(codeType: integer; value: string);
var i, posCode, lenCode: integer;
begin
  // col caption edit
  if (senderData.Tag=778) then
  begin
    for i:= 0 to 24 do
    if not(core.getCharID(i)=-1) then
      core.GameData.setRegenValue(codeType,senderGrid.CharID,senderGrid.indexCode,value,core.getCharID(i));
  end else
  // row caption edit
  if (senderData.Tag=779) then
  begin
    if not(senderGrid.toCharID=-1) then
    begin
      posCode:= ArrayIndexContainText(core.GameData.codeKey[codeType],core.GameData.RegenCode[senderGrid.CharID].KeyName,true);
      lenCode:=82;
      if not(codeType=5) then
        lenCode:= length(core.GameData.RegenCode[senderGrid.CharID].DataCode[posCode].NameCode);
      for i:= 0 to lenCode-1 do
        core.GameData.setRegenValue(codeType,senderGrid.CharID,i,value,senderGrid.toCharID);
    end;
  end else
  begin
    senderGrid.CharID:= core.selectedChar;
    senderGrid.indexCode:= senderGrid.selCol-1;
    case codeType of
      3: begin
        senderGrid.indexCode:= senderGrid.selCol-2;
        senderGrid.toCharID:= gridToCharID[senderGrid.selRow-1];
      end;
      6: senderGrid.toCharID:= seatIndex[senderGrid.selRow-1];
      7: begin
        senderGrid.CharID:= core.selectedSeat;
        senderGrid.toCharID:= core.getCharID(seatIndex[senderGrid.selRow-1]);
      end;
      else senderGrid.toCharID:= gridToCharID[senderGrid.selRow-1];
    end;

    if not(senderGrid.toCharID=-1) then
      core.GameData.setRegenValue(codeType,senderGrid.CharID,senderGrid.indexCode,value,senderGrid.toCharID);
  end;
end;

function TMainForm.validateValue: boolean;
var isValid: boolean;
begin
  isValid:= true;
  if (senderData.Types='GameConfig') then
  begin
    case senderData.Tag of
      20005: senderData.value:= boolStr(not(StrToBool(senderData.value)));
      20001: senderData.value:= FloatToStr(strtoint(senderData.value)/100);
      20003: senderData.value:= FloatToStr(strtoint(senderData.value)/10);
      20002:
        if not(senderData.value='4000') then
          senderData.value:= intToStr(strtoint(senderData.value)+4294963296)
        else senderData.value:= '0';
    end;
  end else
  if (senderData.Types='PersonalCode') then
  begin
    case senderData.Tag of
      // Academic Grade
      1010: senderData.value:= inttostr(strtoint(senderData.value)-1);
      // Personality Name
      1009: senderData.value:= REIPersonality.Names[Personality.itemindex];
      // Hexa Cloth
      5010:
        case strtoint(core.GameData.getValueByCode(core.GameData.getRegenCode(1,core.selectedChar,'Gender'),true)) of
          0: senderData.value:= HEXAClothM.Names[UType.itemindex];
          1: senderData.value:= HEXAClothF.Names[UType.itemindex];
        end;
    end;
  end else
  if (senderData.Types='MainData') then
  begin
    case senderData.Tag of
      // time
      95: begin
        senderData.Name:= 'TimeGame';
        senderData.value:= inttostr(strtoint(EGMin.Text)*60000);
      end;
      // day name
      //98: showmessage(senderData.Value);
      // day week
      99: senderData.Value:= inttostr((DayName.ItemIndex+1)+((DayWeek.ItemIndex*6)+DayWeek.ItemIndex));
      // time state
      100: if not(cDebug.Checked) then
      begin
        senderData.Name:= 'TimeScreen';

        // playable played character must not doing any animation
        if not(core.playedSeat=-1) AND (gameStateID=11) AND not(strtoint(senderData.value) in [0,9]) then
          if not(autoPC.StateOn) AND (core.getNPCState(core.playedSeat) in [IsChat,IsFollow,IsDoSex]) then //((core.ClassSeat[core.playedSeat].actions.Status=7) OR not(core.ClassSeat[core.playedSeat].actions.Status>255)) then
            isValid:= false;

        if not(strtoint(senderData.value) in [2,5,7,10]) then
          isValid:= false;
      end;
    end;
  end;
  Result:= isValid;
end;

procedure TMainForm.parseSenderData(sender: TObject);
begin
  if (Sender is TEdit) then
  begin
    senderData.Tag:= (Sender as TEdit).Tag;
    senderData.Types:= (Sender as TEdit).Hint;
    senderData.Name:= (Sender as TEdit).Name;
    senderData.Value:= (Sender as TEdit).Text;
  end else
  if (Sender is TMemo) then
  begin
    senderData.Tag:= (Sender as TMemo).Tag;
    senderData.Types:= (Sender as TMemo).Hint;
    senderData.Name:= (Sender as TMemo).Name;
    senderData.Value:= (Sender as TMemo).Lines.Text;
  end else
  if (Sender is TComboBox) then
  begin
    senderData.Tag:= (Sender as TComboBox).Tag;
    senderData.Types:= (Sender as TComboBox).Hint;
    senderData.Name:= (Sender as TComboBox).Name;
    senderData.Value:= inttostr((Sender as TComboBox).ItemIndex);
  end else
  if (Sender is TJvSpinEdit) then
  begin
    senderData.Tag:= (Sender as TJvSpinEdit).Tag;
    senderData.Types:= (Sender as TJvSpinEdit).Hint;
    senderData.Name:= (Sender as TJvSpinEdit).Name;
    senderData.Value:= floattostr((Sender as TJvSpinEdit).Value);
  end else
  if (Sender is TCheckBox) then
  begin
    senderData.Tag:= (Sender as TCheckBox).Tag;
    senderData.Types:= (Sender as TCheckBox).Hint;
    senderData.Name:= (Sender as TCheckBox).Name;
    senderData.Value:= boolStr((Sender as TCheckBox).Checked);
  end else
  if (Sender is TJvColorButton) then
  begin
    senderData.Tag:= (Sender as TJvColorButton).Tag;
    senderData.Types:= (Sender as TJvColorButton).Hint;
    senderData.Name:= (Sender as TJvColorButton).Name;
    senderData.Value:= inttostr(HexStringToColor(dec2hex((sender as TJvColorButton).color,8),true));
  end else
  if (sender is TJvTrackBar) then
  begin
    senderData.Tag:= (Sender as TJvTrackBar).Tag;
    senderData.value:= inttoStr((sender as TJvTrackBar).Position);
    senderData.Types:= (Sender as TJvTrackBar).Hint;
    senderData.Name:= (Sender as TJvTrackBar).Name;
  end else
  if (sender is TJvImageComboBox) then
  begin
    senderData.Tag:= (Sender as TJvImageComboBox).Tag;
    senderData.value:= inttoStr((sender as TJvImageComboBox).ItemIndex);
    senderData.Types:= (Sender as TJvImageComboBox).Hint;
    senderData.Name:= (Sender as TJvImageComboBox).Name;
  end else
  if (sender is TRadioGroup) then
  begin
    senderData.Tag:= (Sender as TRadioGroup).Tag;
    senderData.value:= inttoStr((sender as TRadioGroup).ItemIndex);
    senderData.Types:= (Sender as TRadioGroup).Hint;
    senderData.Name:= (Sender as TRadioGroup).Name;
  end;

  // for different name in outfit
  if (tabs.Pages[tabs.TabIndex].Tag=5) then
  case tOutfits.TabIndex of
    0: senderData.Name:= 'Outfit'+senderData.Name;
    1: senderData.Name:= 'Sport'+senderData.Name;
    2: senderData.Name:= 'Swim'+senderData.Name;
    3: senderData.Name:= 'Club'+senderData.Name;
  end;
end;

procedure TMainForm.setCompPause(Sender: TObject);
begin
  isReadData:= false;
end;

procedure TMainForm.setCompResume(Sender: TObject);
begin
  sleep(200);
  isReadData:= true;
end;

procedure TMainForm.setCompValue(Sender: TObject);
var codeType: integer;
begin
  StringGridHideEditor;

  if not(classReady) OR not(isWriteData) then exit;
  isReadData:= false;

  parseSenderData(sender);
  codeType:= codeStore.ItemByName[senderData.Types].Index;
  if validateValue then //AND ((codeType in [0,8]) OR not(core.selectedChar=-1)) then
  if isBinView then
  begin
    setBinData(senderData.Name,senderData.Value);
    parseBinCode;
  end else
  begin
    case codeType of
      0,8: core.GameData.setValueByCode(core.GameData.CharCode.Data[senderData.Types,senderData.Name],senderData.Value);
      1: if not(core.selectedChar=-1) then
          core.GameData.setRegenValue(codeType,core.selectedChar,senderData.Name,senderData.Value);
      else StringGridSetValue(codeType, senderData.Value);
    end;

    sleep(200);

    if (codeType=1) AND ((senderData.Name='Personality') or (senderData.Name='Oriented') or
      (senderData.Name='FirstName') or (senderData.Name='LastName')) then
    begin
      refreshCharacterSeat;
      personalData.Expand;
    end else
    if pauseNPCTimer then
    if (codeType=8) AND (not(senderData.Tag=20001) AND not(senderData.Tag=20002) AND
        not(senderData.Tag=20003) AND not(senderData.Tag=20009)) then configTabs
    else parseTabCode;

  end;
  sleep(200);
  isReadData:= true;
end;

procedure TMainForm.setCharList(Sender: TObject);
var
  i, charID, charIDRef: integer;
  getval,codes: string;
begin
  case TMenuItem(sender).Tag of
    1: begin
      charID:= core.getCharID(senderData.seatNumber);
      if not(charID=-1) and (messagedlg('Play this Character?',mtconfirmation,[mbyes,mbno],0)=mryes) then
      begin
        core.setPlayedSeat:= senderData.seatNumber;
        playedCharacter(true);
        redrawSeatBox;
      end;
    end;
    2,3: begin
      charID:= core.getCharID(core.selectedSeat);
      charIDRef:= core.getCharID(senderData.seatNumber);
      if (charIDRef=charID) then exit; // can't targeted self
      if not(charID=-1) AND not(charIDRef=-1) then
      if (TMenuItem(sender).Tag=2) then
      begin
        core.GameData.setRegenValue(6,charID,0,'1',senderData.seatNumber);
        core.GameData.setRegenValue(6,charIDRef,0,'1',core.selectedSeat);
      end else
      begin
        core.GameData.setRegenValue(6,charID,0,'0',senderData.seatNumber);
        core.GameData.setRegenValue(6,charIDRef,0,'0',core.selectedSeat);
      end;
      redrawSeatBox;
    end;
    4,5,6,7: begin
      charID:= core.selectedChar;
      charIDRef:= core.getCharID(senderData.seatNumber);
      if (charIDRef=charID) then exit; // can't targeted self
      if (charIDRef>charID) then dec(charIDRef);
      if not(charID=-1) AND not(charIDRef=-1) then
      begin
        // set relationship
        case TMenuItem(sender).Tag of
          4: for i:= 0 to gridRelationship.ColCount-3 do core.GameData.setRegenValue(3,charID,i,setLove[i],charIDRef);
          5: for i:= 0 to gridRelationship.ColCount-3 do core.GameData.setRegenValue(3,charID,i,setLike[i],charIDRef);
          6: for i:= 0 to gridRelationship.ColCount-3 do core.GameData.setRegenValue(3,charID,i,setDislike[i],charIDRef);
          7: for i:= 0 to gridRelationship.ColCount-3 do core.GameData.setRegenValue(3,charID,i,setHate[i],charIDRef);
        end;

        // set behavior (buggy)
        {
        for i:= 0 to gridBehavior.ColCount-2 do
        begin
          getval:= core.GameData.getRegenValue(4,charID,i,true,charIDRef);
          if not(getVal='') AND not(getVal[1]='?') AND (strtoint(getVal) in [0,1,2,3]) then
            core.GameData.setRegenValue(4,charID,i,inttostr(TMenuItem(sender).Tag-4),charIDRef)
          else break;
        end;
        }

        redrawSeatBox;
      end;
    end;
    // freeze relationship
    11: begin
      TMenuItem(sender).Checked:= not TMenuItem(sender).Checked;
      charID:= core.selectedChar;
      charIDRef:= core.getCharID(senderData.seatNumber);
      if (charIDRef=charID) then exit; // can't targeted self
      if (charIDRef>charID) then dec(charIDRef);
      if not(charID=-1) AND not(charIDRef=-1) then
        for i:= 0 to length(core.GameData.RegenCode[charID].DataCode[2].NameCode)-1 do
        begin
          getval:= core.GameData.getRegenValue(3,charID,i,true,charIDRef);
          codes:= core.GameData.getRegenCode(3,charID,i,charIDRef);
          core.setFreezeData('Relationship',core.GameData.RegenCode[charID].DataCode[2].NameCode[i],codes,getval,
            TMenuItem(sender).Checked,core.selectedSeat,senderData.seatNumber);
        end;
    end;
  end;
end;

procedure TMainForm.StringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  PADDING = 4;
var
  h: HTHEME;
  s: TSize;
  r: TRect;
  cBoxState: boolean;
  checked, codeType: integer;
begin
  if (core.selectedChar=-1) then exit;
  
  codeType:= codeStore.ItemByName[TJvStringGrid(sender).Hint].Index;
  if (ACol = cBoxColF[codeType]) and (ARow >= 1) then
  begin
    FillRect(TJvStringGrid(Sender).Canvas.Handle, Rect, GetStockObject(WHITE_BRUSH));
    s.cx := GetSystemMetrics(SM_CXMENUCHECK);
    s.cy := GetSystemMetrics(SM_CYMENUCHECK);
    if UseThemes then
    begin
      h := OpenThemeData(TJvStringGrid(Sender).Handle, 'BUTTON');
      if h <> 0 then
        try
          GetThemePartSize(h,
            TJvStringGrid(Sender).Canvas.Handle,
            BP_CHECKBOX,
            CBS_CHECKEDNORMAL,
            nil,
            TS_DRAW,
            s);
          r.Top := Rect.Top + (Rect.Bottom - Rect.Top - s.cy) div 2;
          r.Bottom := r.Top + s.cy;
          r.Left := Rect.Left + PADDING;
          r.Right := r.Left + s.cx;

          case codeType of
            3: cBoxState:= freezeCBox[core.selectedChar].Relationship[ARow-1];
            4: cBoxState:= freezeCBox[core.selectedChar].Behavior[ARow-1];
          end;

          checked:= CBS_UNCHECKEDNORMAL;
          If cBoxState then checked:= CBS_CHECKEDNORMAL;

          DrawThemeBackground(h,
            TJvStringGrid(Sender).Canvas.Handle,
            BP_CHECKBOX,
            checked,
            r,
            nil);
        finally
          CloseThemeData(h);
        end;
    end
    else
    begin
      r.Top := Rect.Top + (Rect.Bottom - Rect.Top - s.cy) div 2;
      r.Bottom := r.Top + s.cy;
      r.Left := Rect.Left + PADDING;
      r.Right := r.Left + s.cx;

      case codeType of
        3: cBoxState:= freezeCBox[core.selectedChar].Relationship[ARow-1];
        4: cBoxState:= freezeCBox[core.selectedChar].Behavior[ARow-1];
      end;

      checked:= DFCS_BUTTONCHECK;
      If cBoxState then checked:= DFCS_CHECKED;

      DrawFrameControl(TJvStringGrid(Sender).Canvas.Handle,
        r,
        DFC_BUTTON,
        checked);
    end;
    r := Classes.Rect(r.Right + PADDING, Rect.Top, Rect.Right, Rect.Bottom);
    DrawText(TJvStringGrid(Sender).Canvas.Handle,
      TJvStringGrid(Sender).Cells[ACol, ARow],
      length(TJvStringGrid(Sender).Cells[ACol, ARow]),
      r,
      DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS);
  end;
end;

procedure TMainForm.StringGridScroll(Sender: TObject);
begin
  StringGridHideEditor;
end;

procedure TMainForm.StringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  senderGrid.selCol:= ACol;
  senderGrid.selRow:= ARow;

  StringGridHideEditor;
end;

procedure TMainForm.StringGridClick(Sender: TObject);
var codeType: integer;
begin
  codeType:= codeStore.ItemByName[TJvStringGrid(sender).hint].Index;
  if (senderGrid.selCol=cBoxColF[codeType]) then
  begin
    case codeType of
      3: freezeCBox[core.selectedChar].Relationship[senderGrid.selRow-1]:=not freezeCBox[core.selectedChar].Relationship[senderGrid.selRow-1];
      4: freezeCBox[core.selectedChar].Behavior[senderGrid.selRow-1]:=not freezeCBox[core.selectedChar].Behavior[senderGrid.selRow-1];
    end;
    ManageFreezeData(sender);
    TJvStringGrid(sender).Invalidate;
  end;
end;

procedure TMainForm.StringGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_SPACE) then
  begin
    StringGridClick(Sender);
    key:=0;
  end;
end;

procedure TMainForm.StringGridHideEditor;
begin
  if cbGridMood.Visible then cbGridMood.Visible  := false;
  if cbGridMax.Visible then cbGridMax.Visible    := false;
  if cbGridLover.Visible then cbGridLover.Visible:= false;
  if cbGridPoin.Visible then cbGridPoin.Visible  := false;
  if cbGridCheck.Visible then cbGridCheck.Visible:= false;
end;

// set component cell stringgrid
procedure TMainForm.StringGridShowEditor(Sender: TJvStringGrid; ACol,
  ARow: Integer; var AllowEdit: Boolean);
var
  getRect: TRect;
  tMode, tMax, cleft, ctop, cwidth, CodeKey, charID, toCharID, Cols: integer;
  getVal, tableName: string;
begin
  if (core.selectedChar=-1) then exit;

  tMode:= 0;
  tMax:= 30;
  isReadData:= false;
  
  getRect:= sender.CellRect(acol,arow);

  //getVal := sender.Cells[ACol,ARow];
  //if (getVal='') then exit;   // dont edit null value in cols

  cleft:= getRect.Left+3;
  ctop:= getRect.Top+3;
  cwidth:= (getRect.Right-getRect.Left)-2;

  // mapping col component
  tableName:= TJvStringGrid(sender).Hint;
  CodeKey:= codeStore.ItemByName[tableName].Index;
  case CodeKey of
  // relationship
    3: case ACol of
        1: begin
          AllowEdit:= false;
          exit;
        end;
        2: tMode:= 1;
        3,4,5,6: tMode:= 2;
        else tMode:= 4;
    end;
  // behavior
    4: case ACol of
        1: begin
          AllowEdit:= false;
          exit;
        end;
        else tMode:= 1;
    end;
  // feeling
    5: if (ACol>=82) then
      begin
        tmode:= 4;
        tMax:= 2;
      end else tmode:= 5;
  // lover
    6: begin
      tMax:= 999999;
      case ACol of
        1: tmode:= 5;
        else tmode:= 4;
      end;
    end;
  // statusH
    7: begin
      tmode:= 4;
      tMax:= 999999;
    end;
  end;

  // get real value
  cols:= ACol-1;
  charID:= core.selectedChar;
  case CodeKey of
    3,4: begin
      cols:= ACol-2;
      toCharID:= gridToCharID[ARow-1];
    end;
    6: toCharID:= seatIndex[ARow-1];
    7: begin
      charID:= core.selectedSeat;
      toCharID:= core.getCharID(seatIndex[ARow-1]);
    end;
    else toCharID:= gridToCharID[ARow-1];
  end;

  if (toCharID=-1) then exit;

  getVal:= core.GameData.getRegenValue(CodeKey,charID,cols,true,toCharID);

  if (getVal='') OR (getVal[1]='?') then exit;

  //ListBox1.Items.Add(inttostr(CodeKey)+'|'+inttostr(charID)+'|'+inttostr(cols)+'|'+inttostr(toCharID)+'>'+getVal);

  case tMode of
    1: begin
      cbGridMood.Hint:= tableName;
      cbGridMood.ItemIndex:= strtoint(getVal); //cbGridMood.Items.IndexOf(getVal);
      cbGridMood.Parent:= sender.Parent;
      cbGridMood.Left:= cleft;
      cbGridMood.Top:= ctop;
      cbGridMood.Width:= cwidth;
      cbGridMood.Visible:= true;
      cbGridMood.SetFocus;
      cbGridMood.Tag:= 777;
    end;
    2: begin
      cbGridMax.Hint:= tableName;
      cbGridMax.ItemIndex:= strtoint(getVal); //cbGridMax.Items.IndexOf(getVal);
      cbGridMax.Parent:= sender.Parent;
      cbGridMax.Left:= cleft;
      cbGridMax.Top:= ctop;
      cbGridMax.Width:= cwidth;
      cbGridMax.Visible:= true;
      cbGridMax.SetFocus;
      cbGridMax.Tag:= 777;
    end;
    3: begin
      cbGridLover.Hint:= tableName;
      cbGridLover.ItemIndex:= strtoint(getVal); //cbGridLover.Items.IndexOf(getVal);
      cbGridLover.Parent:= sender.Parent;
      cbGridLover.Left:= cleft;
      cbGridLover.Top:= ctop;
      cbGridLover.Width:= cwidth;
      cbGridLover.Visible:= true;
      cbGridLover.SetFocus;
      cbGridLover.Tag:= 777;
    end;
    4: begin
      cbGridPoin.Hint:= tableName;
      cbGridPoin.MaxValue:= tMax;
      cbGridPoin.Text:= getVal;
      cbGridPoin.Parent:= sender.Parent;
      cbGridPoin.Left:= cleft;
      cbGridPoin.Top:= ctop;
      cbGridPoin.Width:= cwidth;
      cbGridPoin.Visible:= true;
      cbGridPoin.SetFocus;
      cbGridPoin.Tag:= 777;
    end;
    5: begin
      cbGridCheck.Hint:= tableName;
      cbGridCheck.Checked:= strBool(getVal);
      cbGridCheck.Parent:= sender.Parent;
      cbGridCheck.Left:= cleft;
      cbGridCheck.Top:= ctop;
      cbGridCheck.Width:= cwidth;
      cbGridCheck.Visible:= true;
      cbGridCheck.SetFocus;
      cbGridCheck.Tag:= 777;
    end;
  end;
end;

// set component caption stringgrid
procedure TMainForm.StringGridCaptionClick(Sender: TJvStringGrid; AColumn,
  ARow: Integer);
var getRect: TRect;
  tMode, tMax, cleft, ctop, cwidth, CodeKey, charID, toCharID, Cols, cTag: integer;
  getVal, tableName: string;
begin
  StringGridHideEditor;
  
  if (core.selectedChar=-1) then exit;

  ctag:= 778; // col edit
  if (ARow>0) then cTag:= 779; // rowedit

  tMode:= 0;
  tMax:= 30;
  isReadData:= false;

  getRect:= sender.CellRect(AColumn,ARow);

  //getVal := sender.Cells[ACol,ARow];
  //if (getVal='') then exit;   // dont edit null value in cols

  cleft:= getRect.Left+3;
  ctop:= getRect.Top+3;
  cwidth:= (getRect.Right-getRect.Left)-2;

  // mapping col component
  tableName:= TJvStringGrid(sender).Hint;
  CodeKey:= codeStore.ItemByName[tableName].Index;

  if (ARow>0) then
    if (CodeKey=7) AND (core.selectedSeat=seatIndex[ARow-1]) then exit
    else if not(CodeKey=7) AND (core.selectedChar=core.getCharID(ARow-1)) then exit;

  case CodeKey of
  // relationship
    3: begin
      if (cTag=779) then exit;
      case AColumn of
        1: exit;
        2: tMode:= 1;
        3,4,5,6: tMode:= 2;
        else tMode:= 4;
      end;
    end;
  // behavior
    4: tMode:= 1;
  // feeling
    5: if (AColumn>=82) then
      begin
        tmode:= 4;
        tMax:= 2;
      end else tmode:= 5;
  // lover
    6: begin
      if (cTag=779) then exit;
      tMax:= 999999;
      case AColumn of
        1: tmode:= 5;
        else tmode:= 4;
      end;
    end;
  // statusH
    7: begin
      tmode:= 4;
      tMax:= 999999;
    end;
  end;

  // get charID
  cols:= AColumn-1;
  charID:= core.selectedChar;
  case CodeKey of
    3: begin
      cols:= AColumn-2;
      if (cTag=779) then
      toCharID:= gridToCharID[ARow-1];
    end;
    6: begin
      if (cTag=779) then
      toCharID:= seatIndex[ARow-1];
    end;
    7: begin
      charID:= core.selectedSeat;
      if (cTag=779) then
      toCharID:= core.getCharID(seatIndex[ARow-1]);
    end;
    else begin
      if (cTag=779) then
      toCharID:= gridToCharID[ARow-1];
    end;
  end;

  if (cTag=779) AND (toCharID=-1) then exit;

  senderGrid.CharID:= charID;
  senderGrid.toCharID:= toCharID;
  senderGrid.indexCode:= cols;

  case tMode of
    1: begin
      cbGridMood.Hint:= tableName;
      cbGridMood.ItemIndex:= 0;
      cbGridMood.Parent:= sender.Parent;
      cbGridMood.Left:= cleft;
      cbGridMood.Top:= ctop;
      cbGridMood.Width:= cwidth;
      cbGridMood.Visible:= true;
      cbGridMood.SetFocus;
      cbGridMood.Tag:= cTag;
    end;
    2: begin
      cbGridMax.Hint:= tableName;
      cbGridMax.ItemIndex:= 0;
      cbGridMax.Parent:= sender.Parent;
      cbGridMax.Left:= cleft;
      cbGridMax.Top:= ctop;
      cbGridMax.Width:= cwidth;
      cbGridMax.Visible:= true;
      cbGridMax.SetFocus;
      cbGridMax.Tag:= cTag;
    end;
    3: begin
      cbGridLover.Hint:= tableName;
      cbGridLover.ItemIndex:= 0;
      cbGridLover.Parent:= sender.Parent;
      cbGridLover.Left:= cleft;
      cbGridLover.Top:= ctop;
      cbGridLover.Width:= cwidth;
      cbGridLover.Visible:= true;
      cbGridLover.SetFocus;
      cbGridLover.Tag:= cTag;
    end;
    4: begin
      cbGridPoin.Hint:= tableName;
      cbGridPoin.MaxValue:= tMax;
      cbGridPoin.Text:= '0';
      cbGridPoin.Parent:= sender.Parent;
      cbGridPoin.Left:= cleft;
      cbGridPoin.Top:= ctop;
      cbGridPoin.Width:= cwidth;
      cbGridPoin.Visible:= true;
      cbGridPoin.SetFocus;
      cbGridPoin.Tag:= cTag;
    end;
    5: begin
      cbGridCheck.Hint:= tableName;
      //cbGridCheck.Checked:= false;
      cbGridCheck.Parent:= sender.Parent;
      cbGridCheck.Left:= cleft;
      cbGridCheck.Top:= ctop;
      cbGridCheck.Width:= cwidth;
      cbGridCheck.Visible:= true;
      cbGridCheck.SetFocus;
      cbGridCheck.Tag:= cTag;
    end;
  end;
end;

procedure TMainForm.StringGridPopupClick(Sender: TObject);
var
  codeType, tagID, i, ii: integer;
  tagName: string;
begin
  isReadData:= false;
  
  tagID:= (Sender as TMenuItem).Tag;
  tagname:= (Sender as TMenuItem).Hint;

  codeType:= codeStore.ItemByName[tagname].Index;
  case codeType of
    // relationship
    3:
    case tagID of
      1: for i:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,i,setLove[i]);
      2: for i:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,i,setLike[i]);
      3: for i:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,i,setDislike[i]);
      4: for i:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,i,setHate[i]);
      5: for i:= 0 to 24 do for ii:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,ii,setLove[ii],i);
      6: for i:= 0 to 24 do for ii:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,ii,setLike[ii],i);
      7: for i:= 0 to 24 do for ii:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,ii,setDislike[ii],i);
      8: for i:= 0 to 24 do for ii:= 0 to gridRelationship.ColCount-3 do PopupGridSetValue(codeType,ii,setHate[ii],i);
    end;
    // behavior
    4:
    case tagID of
      1,2,3,4: for i:= 0 to gridBehavior.ColCount-3 do PopupGridSetValue(codeType,i,inttostr(tagID-1));
      5,6,7,8: for i:= 0 to 24 do for ii:= 0 to gridBehavior.ColCount-3 do PopupGridSetValue(codeType,ii,inttostr((tagID-4)-1),i);
    end;
  end;

  parseTabCode;
end;

procedure TMainForm.StringGridContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  CanSelect: boolean;
  Cols, Rows: integer;
  gridItem: TListItem;
begin
  if (sender is TJvStringGrid) then
  begin
    TJvStringGrid(Sender).MouseToCell(MousePos.X,MousePos.Y,Cols,Rows); // bind selected cell
    StringGridSelectCell(Sender,Cols,Rows,CanSelect); // fire selected cell
    //  menuContextPopup(sender,MousePos,Handled);
  end else
  if (sender is TJvListView) then
  begin
    gridItem:= TJvListView(sender).GetItemAt(MousePos.X,MousePos.Y);
    senderData.seatNumber:= gridItem.ImageIndex;
    manageForceAction(IsNavControl,senderData.seatNumber);
  end;
end;

procedure TMainForm.setCompCboxValue(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then setCompValue(Sender);
end;

procedure TMainForm.setCompEditDownValue(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  isReadData:= false;
  if not(routine.Events.ItemByName('setDelay').Enabled) then
  begin
    counterDelay:= 0;
    routine.Events.ItemByName('setDelay').Enabled:= true;
  end;
end;

procedure TMainForm.setCompEditValue(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key in [vk_return,vk_tab]) then
  begin
    setCompValue(Sender);
    sleep(180);
    routine.Events.ItemByName('setDelay').Enabled:= false;
    isReadData:= true;
  end;
end;

{ ==================================================================================== FEATURE CLASS ============================================}

var PragnantCheck: TPragnantCheck;
procedure TMainForm.resetPragnantEndWeek;
const
  HRiskOffset: array [0..3] of dword = ($20,$E4,$38,$28);
  HRiskAddress: dword = $003761CC;
  dayOffset: array [0..1] of dword = ($0024,$002C);
  dayAddress: dword = $00376164;
var
  address: dword;
  getVal: string;
begin
  if not(cResetPregnant.Checked) then
    PragnantCheck.Reset:= true
  else
  // always reset in H Mode
  if (cResetPregnantVal.ItemIndex=1) then
  begin
    address:= Core.GameData.Process.GetRealAddress(HRiskAddress+core.GameData.Process.PBaseAddress,HRiskOffset);
    getVal:= Core.GameData.Process.GetValues(address,4);
    if not(getVal='') AND not(getVal[1]='?') AND not(getVal='0') then Core.GameData.Process.SetValues(address,4,'0');
  end else
  // bypass sunday to monday
  if (DayName.ItemIndex=0) AND (TimeScreen.ItemIndex=9) then
  begin
    if not(PragnantCheck.Active) then
    begin
      address:= Core.GameData.Process.GetRealAddress(dayAddress+core.GameData.Process.PBaseAddress,dayOffset);
      Core.GameData.Process.SetValues(address,1,'1');
      PragnantCheck.Active:= true;
    end;
  end else
  if (TimeScreen.ItemIndex<9) AND PragnantCheck.Active then
    PragnantCheck.Reset:= true;

  if PragnantCheck.Reset then
  begin
    PragnantCheck.Reset:= false;
    if PragnantCheck.Active then
    begin
      address:= Core.GameData.Process.GetRealAddress(dayAddress+core.GameData.Process.PBaseAddress,dayOffset);
      Core.GameData.Process.SetValues(address,1,'1');
      PragnantCheck.Active:= false;
    end;
  end;
end;

procedure TMainForm.resetPlayerAct;
begin
  if classExist AND classReady AND PlayerAct.RunProces AND not(PlayerAct.toSeat=-1) then
  begin
    if not(PlayerAct.VirtueID=-1) then
      core.GameData.Process.SetValues(core.ClassSeat[PlayerAct.toSeat].actAddress.virtue,1,inttostr(PlayerAct.VirtueID));

    if PlayerAct.SingleMind then
      core.GameData.Process.SetValues(core.ClassSeat[PlayerAct.toSeat].actAddress.singleMind,1,'1');
  end;

  PlayerAct.toSeat:= -1;
  PlayerAct.toCharID:= -1;
  PlayerAct.toCharAddress:= '0';
  PlayerAct.VirtueID:= -1;
  PlayerAct.SingleMind:= false;
  PlayerAct.Compatible:= false;
  PlayerAct.Triggered:= false;
  PlayerAct.Active:= false;
  PlayerAct.BeginSex:= false;
  PlayerAct.RunProces:= false;
  lowestStatus.Caption:= '[Idle]';
end;

procedure TMainForm.npcAction;
begin
  if (core.selectedSeat=-1) OR (core.selectedChar=-1) then exit;
  
  // show real action in Action tab
  if not(actionData.Collapsed) and (featureTabs.TabIndex=0) then
  begin
    if (core.ClassSeat[core.selectedSeat].actions.Status>255) then
      Status.ItemIndex:= 0
    else Status.ItemIndex:= core.ClassSeat[core.selectedSeat].actions.Status;

    Action.ItemIndex:= core.ClassSeat[core.selectedSeat].actions.Action+1;
    DestLoc.ItemIndex:= core.ClassSeat[core.selectedSeat].actions.Location;
    ActRespon.ItemIndex:= core.ClassSeat[core.selectedSeat].actions.Response;
    ActionRefNPC.ItemIndex:= ArrayIndexContainInteger(core.ClassSeat[core.selectedSeat].actions.ToSeatRef,seatIndex)+1;
    setNPC.ItemIndex:= ArrayIndexContainInteger(core.ClassSeat[core.selectedSeat].actions.ToSeat,seatIndex)+1;

    if cDebug.Checked then
    begin
      if not(cPCIsInteract.Visible) then cPCIsInteract.Visible:= true;
      if not(cNPCIsInteract.Visible) then cNPCIsInteract.Visible:= true;
      cPCIsInteract.Checked:= strBool(inttostr(core.ClassSeat[core.selectedSeat].actions.PCInteract));
      cNPCIsInteract.Checked:= strBool(inttostr(core.ClassSeat[core.selectedSeat].actions.NPCInteract));
    end else
    begin
      if cPCIsInteract.Visible then cPCIsInteract.Visible:= false;
      if cNPCIsInteract.Visible then cNPCIsInteract.Visible:= false;
    end;
  end;
end;

procedure TMainForm.playerAction;
begin
  if not(cLowestVirtue.Checked) then
  begin
    if not(PlayerAct.toSeat=-1) then resetPlayerAct;
  end else
  // get information player interacted
  if not(PlayerAct.Active) AND not(core.ClassSeat[core.PlayedSeat].actions.Action in [52,63,64,66,67,68,101]) then
  begin
    if not(core.ClassSeat[core.PlayedSeat].actions.ToSeat=-1) then
    begin
      PlayerAct.RunProces:= false;
      if not(PlayerAct.RunProces) AND (core.ClassSeat[core.ClassSeat[core.PlayedSeat].actions.ToSeat].actions.ToSeatAddr=PlayerAct.CharAddress) then
        if not(autoPC.StateOn) AND
        ((core.ClassSeat[core.PlayedSeat].actions.Status=7) OR (core.ClassSeat[core.PlayedSeat].actions.Status=4294967295)) then
          PlayerAct.RunProces:= true
        else if autoPC.StateOn AND ((core.ClassSeat[core.PlayedSeat].actions.Status in [5,6]) AND
        not(core.ClassSeat[core.PlayedSeat].actions.ToSeat=-1)) then 
          PlayerAct.RunProces:= true;

      if PlayerAct.RunProces then
      begin
        PlayerAct.toSeat:= core.ClassSeat[core.PlayedSeat].actions.ToSeat;
        PlayerAct.toCharID:= core.getCharID(PlayerAct.toSeat);
        PlayerAct.toCharAddress:= core.ClassSeat[core.PlayedSeat].actions.ToSeatAddr;
        PlayerAct.VirtueID:= strtoint(core.getCharAction(PlayerAct.toSeat,ActVirtue,true));
        PlayerAct.Active:= true;
        PlayerAct.Triggered:= false;
        lowestStatus.Caption:= '[Lock] '+core.classseat[PlayerAct.toSeat].listName;
      end;
    end;
  end else
  if PlayerAct.Active then
  begin
    // for change data to lowest for pc or auto mode
    if not(PlayerAct.Triggered) then
    begin
      // check if teacher normal virtue need change to low
      if (core.getSeatID(PlayerAct.toSeat)=24) AND (cLowestVirtueSet.ItemIndex > 1) then
        core.GameData.Process.SetValues(core.ClassSeat[PlayerAct.toSeat].actAddress.virtue,1,inttostr(1))
      else if (PlayerAct.VirtueID > 1) then
        core.GameData.Process.SetValues(core.ClassSeat[PlayerAct.toSeat].actAddress.virtue,1,inttostr(MainForm.cLowestVirtueSet.ItemIndex));

      // check singlemind
      PlayerAct.SingleMind:= strBool(core.getCharAction(PlayerAct.toSeat,ActSingleMind,true));
      if PlayerAct.SingleMind then
        core.GameData.Process.SetValues(core.ClassSeat[PlayerAct.toSeat].actAddress.singleMind,1,'0');

      PlayerAct.Triggered:= true;
      lowestStatus.Caption:= lowestStatus.Caption+' [Set] Virtue: '+core.getCharAction(PlayerAct.toSeat,ActVirtue,true)+' SingleMind: '+core.getCharAction(PlayerAct.toSeat,ActSingleMind,true);
    end else
    // for h action
    if PlayerAct.Triggered AND not(PlayerAct.BeginSex) AND (core.ClassSeat[core.PlayedSeat].actions.Action in [32,38,48,73,74,80,99,102]) AND (core.ClassSeat[core.PlayedSeat].actions.Response=1) then
    begin
      // set both compatible
      core.GameData.Process.SetValues(core.GameData.getRegenAddress(6,core.playedChar,2,PlayerAct.toSeat),2,'999');
      core.GameData.Process.SetValues(core.GameData.getRegenAddress(6,PlayerAct.toCharID,2,core.PlayedSeat),2,'999');

      // lowest H
      core.GameData.Process.SetValues(core.ClassSeat[PlayerAct.toSeat].actAddress.virtue,1,inttostr(0));
      lowestStatus.Caption:= lowestStatus.Caption+' [Do] H Action';
      PlayerAct.BeginSex:= true;
    end else
    // h end or interupted
    if PlayerAct.BeginSex AND (core.ClassSeat[core.PlayedSeat].actions.Action in [66,67,68,101,113]) then
      resetPlayerAct
    else
    // reset if target idle
    if (core.getNPCState(PlayerAct.toSeat) in [IsIdle,IsDoSingleAct]) then
      resetPlayerAct;

    // how many possible to reset T_T for autopc
    if not(PlayerAct.toSeat=-1) AND not(PlayerAct.BeginSex) AND (((core.ClassSeat[PlayerAct.toSeat].actions.PCInteract=0) AND (core.ClassSeat[PlayerAct.toSeat].actions.NPCInteract=0)) OR
      ((core.ClassSeat[core.PlayedSeat].actions.PCInteract=0) AND (core.ClassSeat[core.PlayedSeat].actions.NPCInteract=0))) AND
      ((core.ClassSeat[core.PlayedSeat].actions.Action>255) AND (core.ClassSeat[PlayerAct.toSeat].actions.Action>255)) then
      resetPlayerAct;
  end;
end;

procedure TMainForm.manageTimer(enabled: boolean = true);
var i, seatNumber, charID: integer;
begin
  pauseNPCTimer:= true;
  sleep(200);
  if (length(core.ClassSeat)>0) then
  for i:= 0 to 24 do
  begin
    seatNumber:= seatIndex[i];
    charID:= core.getCharID(seatNumber);
    if not(charID=-1) then
    begin
      // Class Event Timer
      if (core.ClassSeat[seatNumber].actions.syncEvent=nil) then
      begin
        core.ClassSeat[seatNumber].actions.syncEvent:= TJvTimer.Create(self);
        core.ClassSeat[seatNumber].actions.syncEvent.Threaded:= true;
        core.ClassSeat[seatNumber].actions.syncEvent.ThreadPriority:= tpHigher;
        core.ClassSeat[seatNumber].actions.syncEvent.Tag:= core.getSeatID(charID);
        core.ClassSeat[seatNumber].actions.syncEvent.Interval:= 36;
        core.ClassSeat[seatNumber].actions.syncEvent.OnTimer:= getEvent;
      end;
      core.ClassSeat[seatNumber].actions.syncEvent.Enabled:= enabled;

       // Plan Action Timer
      if (core.ClassSeat[seatNumber].planAction.syncAction=nil) then
      begin
        core.ClassSeat[seatNumber].planAction.syncAction:= TJvTimer.Create(self);
        core.ClassSeat[seatNumber].planAction.syncAction.Threaded:= true;
        core.ClassSeat[seatNumber].planAction.syncAction.ThreadPriority:= tpHigher;
        core.ClassSeat[seatNumber].planAction.syncAction.Tag:= core.getSeatID(charID);
        core.ClassSeat[seatNumber].planAction.syncAction.Interval:= 36;
        core.ClassSeat[seatNumber].planAction.syncAction.OnTimer:= getPlanAction;
      end;
      if core.ClassSeat[seatNumber].planAction.Started then
        core.ClassSeat[seatNumber].planAction.syncAction.Enabled:= true
      else
        core.ClassSeat[seatNumber].planAction.syncAction.Enabled:= false;
    end;
  end;
  sleep(200);
  pauseNPCTimer:= false;
end;

procedure TMainForm.generateEventLogs;
var
  tempMemo: TStringList;
  i, seatnumber, charID: integer;
begin
  if (globalEvenLogs.Lines.Count=0) OR cDisableNPCEventFile.Checked then exit;

  tempMemo:= TStringList.Create;

  try
    if FileExists(appDir+NPCEventFile+'.txt') then
      LoadTextFile(appDir+NPCEventFile+'.txt',tempMemo);

    tempMemo.Add('');
    tempMemo.Add('========================================== ['+DateTimeToStr(Now)+'] '+ClassName.Text+' - '+DayName.Text+' | '+DayWeek.Text+' | '+TimeScreen.Items.Strings[TimeScreen.Itemindex-1]+' ==========================================');
    tempMemo.Add('');
    tempMemo.AddStrings(globalEvenLogs.Lines);
    tempMemo.SaveToFile(appDir+NPCEventFile+'.txt');
  finally
    tempMemo.Free;

    globalEvenLogs.Lines.Clear;

    eventNote.Clear;
    for i:= 0 to 24 do
    begin
      seatnumber:= seatIndex[i];
      charID:= core.getCharID(seatnumber);
      if not(charID=-1) then
        if not(core.ClassSeat[seatnumber].actions.EventLogs=nil) then
          core.ClassSeat[seatnumber].actions.EventLogs.Clear;
    end;
  end;
end;

procedure TMainForm.getActions(Sender: TObject);
var
  seatNumber: integer;
begin
  seatNumber:= (sender as TJVTimer).tag;
  
  // == > THIS IS REAL NPC ACTION DATA [don't touch this/make duplicate outside this procedure]

  core.ClassSeat[seatNumber].actions.Status       := strtoint64(core.getCharAction(seatNumber,ActStatus,true));
  core.ClassSeat[seatNumber].actions.Action       := strtoint64(core.getCharAction(seatNumber,ActAction,true));
  core.ClassSeat[seatNumber].actions.Response     := strtoint64(core.getCharAction(seatNumber,ActResponse,true));
  core.ClassSeat[seatNumber].actions.PCInteract   := strtoint64(core.getCharAction(seatNumber,ActInteract,true));
  core.ClassSeat[seatNumber].actions.NPCInteract  := strtoint64(core.getCharAction(seatNumber,ActNpcInteract,true));

  core.ClassSeat[seatNumber].actions.ToSeatAddr   := core.getCharAction(seatNumber,ActTarget);
  core.ClassSeat[seatNumber].actions.ToSeatRefAddr:= core.getCharAction(seatNumber,ActRefer);

  core.ClassSeat[seatNumber].actions.ToSeat       := ArrayIndexContainText(core.ClassSeat[seatNumber].actions.ToSeatAddr,core.NPCTargetAddress,true);
  core.ClassSeat[seatNumber].actions.ToSeatRef    := ArrayIndexContainText(core.ClassSeat[seatNumber].actions.ToSeatRefAddr,core.NPCRefTargetAddress,true);

  core.ClassSeat[seatNumber].actions.Location     := strtoint64(core.getCharAction(seatNumber,ActLocation,true));

  // make sure if NPC targeted must change to their location priodicly
  if not(core.ClassSeat[seatNumber].actions.ToSeat=-1) then
  begin
    if (core.ClassSeat[seatNumber].actions.Status=4) AND
      not(core.ClassSeat[seatNumber].actions.Location=core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].actions.location) then
      core.ClassSeat[seatNumber].actions.Location:= core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].actions.location;

    core.ClassSeat[seatNumber].views.isLocation.Caption:= DestLoc.Items.Strings[core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].actions.location]
  end else
    core.ClassSeat[seatNumber].views.isLocation.Caption:= '';

  //  core.ClassSeat[seatNumber].actions.Location   := strtoint64(core.getCharAction(core.ClassSeat[seatNumber].actions.ToSeat,ActLocation,true));

  // <== END NPC ACTION DATA
end;

procedure TMainForm.getEvent(Sender: TObject);
var
  seatNumber: integer;
  dontShow: boolean;
begin
  seatNumber:= (sender as TJVTimer).tag;//core.getSeatID((sender as TJVTimer).tag);

  if not(gameRunning) OR not(classExist) OR not(classReady) OR (seatNumber=-1) then
  begin
    (sender as TJVTimer).Enabled:= false;
    exit;
  end;

  if not(pauseNPCTimer) then
  begin

  // prepare random action
  manageRandomAction(IsNavControl,seatNumber);

  getActions(sender);

  core.ClassSeat[seatNumber].actions.UnixID:= inttostr(core.ClassSeat[seatNumber].actions.Status)+IntToStr(core.ClassSeat[seatNumber].actions.Action)+
    inttostr(core.ClassSeat[seatNumber].actions.Location)+IntToStr(core.ClassSeat[seatNumber].actions.Response)+
    core.ClassSeat[seatNumber].actions.ToSeatAddr+core.ClassSeat[seatNumber].actions.ToSeatRefAddr;
  if not(core.ClassSeat[seatNumber].actions.UnixID = core.ClassSeat[seatNumber].actions.OldUnixID) then
  begin
    core.ClassSeat[seatNumber].actions.OldUnixID:= core.ClassSeat[seatNumber].actions.UnixID;

    if not(core.ClassSeat[seatNumber].views.isStatus.Picture=nil) then
      core.ClassSeat[seatNumber].views.isStatus.Picture:= nil;
    if not(core.ClassSeat[seatNumber].views.toNPC.Picture=nil) then
      core.ClassSeat[seatNumber].views.toNPC.Picture:= nil;
    if core.ClassSeat[seatNumber].views.toNPC.Visible then
      core.ClassSeat[seatNumber].views.toNPC.Visible:= false;
    if not(core.ClassSeat[seatNumber].views.toNPCRef.Picture=nil) then
      core.ClassSeat[seatNumber].views.toNPCRef.Picture:= nil;
    if core.ClassSeat[seatNumber].views.toNPCRef.Visible then
      core.ClassSeat[seatNumber].views.toNPCRef.Visible:= false;
    if (core.ClassSeat[seatNumber].views.isRespon.Visible) then
      core.ClassSeat[seatNumber].views.isRespon.Visible:= false;
    core.ClassSeat[seatNumber].views.toNPC.Hint:= '';
    core.ClassSeat[seatNumber].views.isAction.Caption:= 'No Action';
    //core.ClassSeat[seatNumber].isLocation.Caption:= 'Home';

    // FUn Mode Random Action
    manageRandomAction(IsValidate,seatNumber);

    // FUn Mode Forced Action
    if not(randomAction.Checked) then
      manageForceAction(IsValidate,seatNumber);

    // don't interact with ignore charater
    if not(core.ClassSeat[seatNumber].actions.Status in [0,4]) then
    if not(core.ClassSeat[seatNumber].actions.ToSeat=-1) AND not(core.ClassSeat[seatNumber].ignoredSeat=nil) AND
      (core.ClassSeat[seatNumber].ignoredSeat.IndexOfName(inttostr(core.ClassSeat[seatNumber].actions.ToSeat))>=0) then
    begin
      core.ClassSeat[seatNumber].actions.cancelType:= '[IGN]';
      managePlanAction(IsCancel,true,seatNumber);
    end else
    // played npc not in auto mode will bypass this
    if (autoPC.StateOn OR not(seatNumber=core.playedSeat)) then
    begin
      // bind limit global actions
      if cb_limitActionAll.Checked AND not(lst_limitAll.Items.Count=0) AND
        (lst_limitAll.Items.IndexOfName(inttostr(core.ClassSeat[seatNumber].actions.Action))>=0) then
      begin
        core.ClassSeat[seatNumber].actions.cancelType:= '[GLA]';
        managePlanAction(IsCancel,true,seatNumber,core.ClassSeat[seatNumber].actions.ToSeat);
      end else
      // bind limit action if action include to char interact
      if not(core.ClassSeat[seatNumber].actions.ToSeat=-1) AND not(core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].limitActions = nil) AND
        (core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].limitActions.IndexOfName(inttostr(core.ClassSeat[seatNumber].actions.Action))>=0) then
      begin
        core.ClassSeat[seatNumber].actions.cancelType:= '[TLA]';
        managePlanAction(IsCancel,true,seatNumber);
      end else
      // bind limit action current seat
      if not(core.ClassSeat[seatNumber].limitActions = nil) AND
        (core.ClassSeat[seatNumber].limitActions.IndexOfName(inttostr(core.ClassSeat[seatNumber].actions.Action))>=0) then
      begin
        core.ClassSeat[seatNumber].actions.cancelType:= '[CLA]';
        managePlanAction(IsCancel,true,seatNumber);
      end;
    end;

    core.ClassSeat[seatNumber].actions.shortMsg:= '';
    dontShow:= false;

    try
      if not(core.ClassSeat[seatNumber].actions.ToSeat=-1) then
      begin
        {
        // save last action
        if not(core.ClassSeat[seatNumber].actions.Action>255) then
        case core.ClassSeat[seatNumber].actions.Status of
          3  : if not(core.ClassSeat[seatNumber].actions.Action=core.ClassSeat[seatNumber].actions.oldAction) then
            core.ClassSeat[seatNumber].actions.oldAction:= core.ClassSeat[seatNumber].actions.Action;
          1,8: core.ClassSeat[seatNumber].actions.Action:= core.ClassSeat[seatNumber].actions.oldAction;
        end;
        }

        // Interaction to
        if not(disableInteractiveEvent) then
        begin
          core.ClassSeat[seatNumber].views.toNPC.Picture:= TPicture.Create;
          core.ClassSeat[seatNumber].views.toNPC.Picture.Assign(core.ClassSeat[core.ClassSeat[seatNumber].actions.toSeat].views.thumb.Picture);
          core.ClassSeat[seatNumber].views.toNPC.Visible:= true;
        end;

        // Reffer To
        if not(core.ClassSeat[seatNumber].actions.Status in [4]) AND not(disableInteractiveEvent) AND not(core.ClassSeat[seatNumber].actions.ToSeatRef=-1) and (core.ClassSeat[seatNumber].actions.Action in [10,11,12,13,14,35,61,75,93,94,95,96,97,106,107]) then
        begin
          core.ClassSeat[seatNumber].views.toNPCRef.Picture:= TPicture.Create;
          core.ClassSeat[seatNumber].views.toNPCRef.Picture.Assign(core.ClassSeat[core.ClassSeat[seatNumber].actions.toSeatRef].views.thumb.Picture);
          core.ClassSeat[seatNumber].views.toNPCRef.Visible:= true;
          core.ClassSeat[seatNumber].views.toNPCRef.Hint:= core.ClassSeat[core.ClassSeat[seatNumber].actions.toSeatRef].listName;
        end;

        // bind target location to character
        //if (core.ClassSeat[seatNumber].actions.Status in [3,4]) AND not(core.ClassSeat[seatNumber].actions.Status>255) then //and not(core.ClassSeat[seatNumber].actions.Action>255) then
        //  core.ClassSeat[seatNumber].actions.Location:= core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].actions.Location;

        // Text Action
        case (core.ClassSeat[seatNumber].actions.Status) of // status
          // going interact
          1,3: begin
            if (core.ClassSeat[seatNumber].actions.Action>=0) AND (core.ClassSeat[seatNumber].actions.Action<255) then
              core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " '+Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1]+' "'
            else
              core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' "';
          end;
          // stalking AND wathing
          2,4: if (core.ClassSeat[seatNumber].actions.action<0) OR (core.ClassSeat[seatNumber].actions.action>=255) then
              core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " watching to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' "'
            else if (core.ClassSeat[seatNumber].actions.action=106) then
              core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " stalking " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' "'
            else core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " '+Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1]+' " response " '+ActRespon.Items.Strings[core.ClassSeat[seatNumber].actions.response]+' "';
          // decide status most not useless execept for cancel action
          5,6: core.ClassSeat[seatNumber].views.isRespon.Visible:= false;
          // doing interact or just faceing
          7,8: begin
            // just faceing before start interact
            if not((core.ClassSeat[seatNumber].actions.Action>=0) AND (core.ClassSeat[seatNumber].actions.Action<255)) then
              core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' "'
            else
            // chating or faceing with everyone lets
            begin
              // show response image
              if not(disableInteractiveEvent) AND ((core.ClassSeat[seatNumber].actions.Status=7)OR((core.ClassSeat[seatNumber].actions.Status=8) AND ((core.ClassSeat[seatNumber].actions.Action>=255) OR ((core.ClassSeat[seatNumber].actions.action>=53) AND (core.ClassSeat[seatNumber].actions.action<=62))))) then
              begin
                core.ClassSeat[seatNumber].views.isRespon.Visible:= false;
                case core.ClassSeat[seatNumber].actions.Response of
                  0: core.ClassSeat[seatNumber].views.isRespon.Picture:= defNo.Picture;
                  1: core.ClassSeat[seatNumber].views.isRespon.Picture:= defYes.Picture;
                  2: core.ClassSeat[seatNumber].views.isRespon.Picture:= defHuh.Picture;
                end;
                core.ClassSeat[seatNumber].views.isRespon.Visible:= true;
              end;

              // PC is start interact
              if (core.ClassSeat[seatNumber].actions.PCInteract=1) then //and (core.ClassSeat[seatNumber].actions.NPCInteract=1)) then
              begin
                if not(core.ClassSeat[seatNumber].actions.ToSeatRef=-1) and (core.ClassSeat[seatNumber].actions.action in [10,11,12,13,14,35,61,75,93,94,95,96,97,106,107]) then
                begin
                  {if (core.ClassSeat[seatNumber].actions.action=61) then
                    core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " Everyone Let''s ... " refer " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseatref].CharName+' " response " '+ActRespon.Items.Strings[core.ClassSeat[seatNumber].actions.response]+' "'
                  else}
                    core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " '+Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1]+' " refer " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseatref].CharName+' " response " '+ActRespon.Items.Strings[core.ClassSeat[seatNumber].actions.response]+' "';
                end else
                if not(core.ClassSeat[seatNumber].actions.action>255) then
                begin
                  {if (core.ClassSeat[seatNumber].actions.action>=53) AND (core.ClassSeat[seatNumber].actions.action<=62) then
                    core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " Everyone Let''s ... " response " '+ActRespon.Items.Strings[core.ClassSeat[seatNumber].actions.response]+' "'
                  else}
                    core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " '+Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1]+' " response " '+ActRespon.Items.Strings[core.ClassSeat[seatNumber].actions.response]+' "';
                end;
              end else
              // npc respon interact
              begin
                if not(core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].actions.ToSeatRef=-1) and (core.ClassSeat[seatNumber].actions.action in [10,11,12,13,14,35,61,75,93,94,95,96,97,106,107]) then
                begin
                  if not(disableInteractiveEvent) then
                  begin
                    core.ClassSeat[seatNumber].views.toNPCRef.Picture:= TPicture.Create;
                    core.ClassSeat[seatNumber].views.toNPCRef.Picture.Assign(core.ClassSeat[core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].actions.ToSeatRef].views.thumb.Picture);
                    core.ClassSeat[seatNumber].views.toNPCRef.Visible:= true;
                  end;

                  core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " with " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " '+Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1]+' " refer " '+core.ClassSeat[core.ClassSeat[core.ClassSeat[seatNumber].actions.ToSeat].actions.ToSeatRef].listName+' " response " '+ActRespon.Items.Strings[core.ClassSeat[seatNumber].actions.response]+' "';
                end else
                begin
                  core.ClassSeat[seatNumber].views.toNPCRef.Visible:= false;
                  if not(core.ClassSeat[seatNumber].actions.action>255) then
                    core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " with " '+core.ClassSeat[core.ClassSeat[seatNumber].actions.toseat].listName+' " action " '+Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1]+' " response " '+ActRespon.Items.Strings[core.ClassSeat[seatNumber].actions.response]+' "';
                end;
              end;
            end;
          end;// else
          //msgStats:= Status.Items.Strings[s];
        end;
      end else
      // single action
      begin
        dontShow:= true;
        case (core.ClassSeat[seatNumber].actions.Status) of // status
          2: begin  // go location
            // with action
            if (core.ClassSeat[seatNumber].actions.action>=0) AND (core.ClassSeat[seatNumber].actions.action<255) then
              core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+DestLoc.Items.Strings[core.ClassSeat[seatNumber].actions.location]+' " action " '+Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1]+' "'
            else
              core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' " to " '+DestLoc.Items.Strings[core.ClassSeat[seatNumber].actions.location]+' "';
          end else
            core.ClassSeat[seatNumber].actions.shortMsg:= '" '+Status.Items.Strings[core.ClassSeat[seatNumber].actions.status]+' "';
        end;
      end;
    finally

      if not(disableInteractiveEvent) then
      begin
        if not(core.ClassSeat[seatNumber].views.isStatus.Visible) then
          core.ClassSeat[seatNumber].views.isStatus.Visible:= true;
        if (core.ClassSeat[seatNumber].actions.status>=0) AND (core.ClassSeat[seatNumber].actions.status<20) then
        begin
          core.ClassSeat[seatNumber].views.isStatus.Picture:= TPicture.Create;
          case (core.ClassSeat[seatNumber].actions.status) of
            0: core.ClassSeat[seatNumber].views.isStatus.Picture.Assign(defWait.Picture);
            1,2,3,8: core.ClassSeat[seatNumber].views.isStatus.Picture.Assign(defMove.Picture);
            4: core.ClassSeat[seatNumber].views.isStatus.Picture.Assign(defEye.Picture);
            7: if (core.ClassSeat[seatNumber].actions.PCInteract=0) then
              core.ClassSeat[seatNumber].views.isStatus.Picture.Assign(defChat.Picture)
            else core.ClassSeat[seatNumber].views.isStatus.Picture.Assign(defChatTo.Picture);
          end;
        end;
      end;

      // current location image
      if not(core.ClassSeat[seatNumber].views.location.Visible) then
        core.ClassSeat[seatNumber].views.location.Visible:= true;

      if not(core.ClassSeat[seatNumber].actions.Location>=40) then
        core.ClassSeat[seatNumber].views.location.Picture.Bitmap.Assign(locationThumb.PngImages.Items[core.ClassSeat[seatNumber].actions.Location].PngImage)
      else core.ClassSeat[seatNumber].views.location.Picture:= nil;//emptys.Picture;
      core.ClassSeat[seatNumber].views.location.Hint:= DestLoc.Items.Strings[core.ClassSeat[seatNumber].actions.location];

      // current action text
      if not(core.ClassSeat[seatNumber].views.isAction.Visible) then
        core.ClassSeat[seatNumber].views.isAction.Visible:= true;
      if (core.ClassSeat[seatNumber].actions.action>=0) AND (core.ClassSeat[seatNumber].actions.action<255) then
      begin
        if not(core.ClassSeat[seatNumber].actions.ToSeat=-1) AND (core.ClassSeat[seatNumber].actions.PCInteract=1) AND
          ((core.ClassSeat[seatNumber].actions.action>=53) AND (core.ClassSeat[seatNumber].actions.action<=62)) then
          core.ClassSeat[seatNumber].views.isAction.Caption:= 'Everyone Let''s ...'
        else core.ClassSeat[seatNumber].views.isAction.Caption:= Action.Items.Strings[core.ClassSeat[seatNumber].actions.action+1];
      end else
      if (core.ClassSeat[seatNumber].actions.Status=4) then core.ClassSeat[seatNumber].views.isAction.Caption:= 'Watching ...';

      // text action mode
      if not(core.ClassSeat[seatNumber].actions.shortMsg='') then
      begin
        // added cancel type
        core.ClassSeat[seatNumber].actions.shortMsg:= core.ClassSeat[seatNumber].actions.cancelType+' '+core.ClassSeat[seatNumber].actions.shortMsg;

        if (core.ClassSeat[seatNumber].actions.EventLogs=nil) then
          core.ClassSeat[seatNumber].actions.EventLogs:= TStringList.Create;

        if (core.ClassSeat[seatNumber].actions.EventLogs.Count>500) then
          core.ClassSeat[seatNumber].actions.EventLogs.Clear;

        if not(dontshow) then
        begin
          core.ClassSeat[seatNumber].actions.EventLogs.Add(core.ClassSeat[seatNumber].actions.shortMsg);

          // show hint
          core.ClassSeat[seatNumber].views.toNPC.Hint:= core.ClassSeat[seatNumber].actions.shortMsg;
          if (core.selectedSeat=seatNumber) AND (featureTabs.TabIndex=0) AND (gActionLeft.TabIndex=0) then
          begin
            eventNote.Lines.Add(core.ClassSeat[seatNumber].actions.shortMsg);
            eventNote.CurrentLine:= eventNote.Lines.Count-1;
          end;

          core.ClassSeat[seatNumber].actions.shortMsg:= '['+EGmin.Text+':'+EGSec.Text+'] '+core.ClassSeat[seatNumber].listName+'::'+core.ClassSeat[seatNumber].actions.shortMsg;

          if (globalEvenLogs.Lines.Count>1000) then
            globalEvenLogs.Clear;

          globalEvenLogs.Lines.Add(core.ClassSeat[seatNumber].actions.shortMsg);
          globalEvenLogs.CurrentLine:= globalEvenLogs.Lines.Count-1;
        end;
      end;
      core.ClassSeat[seatNumber].actions.cancelType:= '';
      core.ClassSeat[seatNumber].actions.cancelIsRun:= false;
    end;
  end;

  end;
end;

procedure TMainForm.getPlanAction(Sender: TObject);
const
  ignoreAct: array [0..8] of integer = (63,64,65,66,67,68,106,112,113);
var
  seatNumber,i: integer;
begin
  seatNumber:= (sender as TJVTimer).tag;

  if not(gameRunning) OR not(classExist) OR not(classReady) OR (seatNumber=-1) then
  begin
    (sender as TJVTimer).Enabled:= false;
    exit;
  end;

  if not(pauseNPCTimer) AND (autoPC.StateOn OR not(seatNumber=core.playedSeat)) AND not(length(core.ClassSeat[seatNumber].planAction.ListAction)=0) then
  begin

    getActions(sender);
    
    if core.ClassSeat[seatNumber].planAction.Started AND not(core.ClassSeat[seatNumber].actions.cancelIsRun) then
    begin
      // state run action
      if not(core.ClassSeat[seatNumber].planAction.runOnAction) then
      begin

        // reset if lastrunaction same as total action
        if (length(core.ClassSeat[seatNumber].planAction.indexRunID)>=core.ClassSeat[seatNumber].planAction.TotActive) then
          if core.ClassSeat[seatNumber].planAction.Looping OR core.ClassSeat[seatNumber].planAction.Shuffle then
            managePlanAction(IsRefresh,false,seatNumber)
          else if not(core.ClassSeat[seatNumber].planAction.Looping) then
          begin
            managePlanAction(IsNavControl,false,seatNumber);
            exit;
          end;

        // force perform
        if core.ClassSeat[seatNumber].planAction.Quicked AND (
          // single act cancel
          ((core.ClassSeat[seatNumber].actions.Status in [1,2]) AND (core.ClassSeat[seatNumber].actions.ToSeat=-1)) OR
          // going interact cancel
          ((core.ClassSeat[seatNumber].actions.Status in [1,8]) AND (core.ClassSeat[seatNumber].actions.Action>=255) AND not(core.ClassSeat[seatNumber].actions.ToSeat=-1)) ) then
          begin
            core.ClassSeat[seatNumber].actions.cancelType:= '[FPA]';
            managePlanAction(IsCancel,true,seatNumber);
          end;

        // character must going interact
        if not(core.ClassSeat[seatNumber].actions.ToSeat=-1) AND ((core.ClassSeat[seatNumber].actions.Status in [3,5,6]) AND (core.ClassSeat[seatNumber].actions.Action<255)) then
        begin
          // forced mode
          if core.ClassSeat[seatNumber].planAction.Forced then
          begin
            // shuffle mode
            if core.ClassSeat[seatNumber].planAction.Shuffle then
            begin
              setLength(core.ClassSeat[seatNumber].planAction.tempPlanID,0);
              for i:= 0 to length(core.ClassSeat[seatNumber].planAction.ListAction)-1 do
              if core.ClassSeat[seatNumber].planAction.ListAction[i].Active and not(core.ClassSeat[seatNumber].planAction.ListAction[i].Triggered) then
              begin
                SetLength(core.ClassSeat[seatNumber].planAction.tempPlanID,length(core.ClassSeat[seatNumber].planAction.tempPlanID)+1);
                core.ClassSeat[seatNumber].planAction.tempPlanID[length(core.ClassSeat[seatNumber].planAction.tempPlanID)-1]:= i;
              end;

              if (length(core.ClassSeat[seatNumber].planAction.tempPlanID)>0) then
              begin
                core.ClassSeat[seatNumber].planAction.runIndex:= core.ClassSeat[seatNumber].planAction.tempPlanID[RandomRange(0,length(core.ClassSeat[seatNumber].planAction.tempPlanID)-1)];
                core.ClassSeat[seatNumber].planAction.runTargetSeat:= core.ClassSeat[seatNumber].planAction.ListAction[core.ClassSeat[seatNumber].planAction.runIndex].Seat;
                core.ClassSeat[seatNumber].planAction.runTargetAddress:= core.ClassSeat[core.ClassSeat[seatNumber].planAction.runTargetSeat].actions.NPCAddress;
                core.ClassSeat[seatNumber].planAction.runTargetAction:= core.ClassSeat[seatNumber].planAction.ListAction[core.ClassSeat[seatNumber].planAction.runIndex].Action;
                core.ClassSeat[seatNumber].planAction.runOnAction:= true;
              end;

            end else
            // runing one by one
            begin
              for i:= 0 to length(core.ClassSeat[seatNumber].planAction.ListAction)-1 do
              if core.ClassSeat[seatNumber].planAction.ListAction[i].Active and not(core.ClassSeat[seatNumber].planAction.ListAction[i].Triggered) AND
                not(inTArray(i,core.ClassSeat[seatNumber].planAction.indexRunID)) then
              begin
                core.ClassSeat[seatNumber].planAction.runIndex:= i;
                core.ClassSeat[seatNumber].planAction.runTargetSeat:= core.ClassSeat[seatNumber].planAction.ListAction[i].Seat;
                core.ClassSeat[seatNumber].planAction.runTargetAddress:= core.ClassSeat[core.ClassSeat[seatNumber].planAction.runTargetSeat].actions.NPCAddress;
                core.ClassSeat[seatNumber].planAction.runTargetAction:= core.ClassSeat[seatNumber].planAction.ListAction[i].Action;
                core.ClassSeat[seatNumber].planAction.runOnAction:= true;
                break;
              end;
            end;
          end else
          // normal mode if interact
          begin
            core.ClassSeat[seatNumber].planAction.isDoubleCheck:= false;
            for i:= 0 to length(core.ClassSeat[seatNumber].planAction.ListAction)-1 do
            if (core.ClassSeat[seatNumber].planAction.ListAction[i].Seat=core.ClassSeat[seatNumber].actions.ToSeat) AND core.ClassSeat[seatNumber].planAction.ListAction[i].Active then
            begin
              if not(core.ClassSeat[seatNumber].planAction.ListAction[i].Triggered) then
              begin
                if not(inTArray(i,core.ClassSeat[seatNumber].planAction.tempPlanID)) then
                begin
                  SetLength(core.ClassSeat[seatNumber].planAction.tempPlanID,length(core.ClassSeat[seatNumber].planAction.tempPlanID)+1);
                  core.ClassSeat[seatNumber].planAction.tempPlanID[length(core.ClassSeat[seatNumber].planAction.tempPlanID)-1]:= i;
                end;

                core.ClassSeat[seatNumber].planAction.runIndex:= i;
                core.ClassSeat[seatNumber].planAction.runTargetSeat:= core.ClassSeat[seatNumber].actions.ToSeat;
                core.ClassSeat[seatNumber].planAction.runTargetAddress:= core.ClassSeat[seatNumber].actions.ToSeatAddr;
                core.ClassSeat[seatNumber].planAction.runTargetAction:= core.ClassSeat[seatNumber].planAction.ListAction[i].Action;
                core.ClassSeat[seatNumber].planAction.runOnAction:= true;
                core.ClassSeat[seatNumber].planAction.isDoubleCheck:= false;
                break;
              end;
              core.ClassSeat[seatNumber].planAction.isDoubleCheck:= true;
            end;

            // uncheck if looping and not shuffle per last seat is trigered
            if core.ClassSeat[seatNumber].planAction.Looping AND core.ClassSeat[seatNumber].planAction.isDoubleCheck AND
              (length(core.ClassSeat[seatNumber].planAction.tempPlanID)>0) then
            begin
              for i:= 0 to length(core.ClassSeat[seatNumber].planAction.tempPlanID)-1 do
              if (core.ClassSeat[seatNumber].planAction.ListAction[core.ClassSeat[seatNumber].planAction.tempPlanID[i]].Seat=core.ClassSeat[seatNumber].actions.ToSeat) then
                core.ClassSeat[seatNumber].planAction.ListAction[core.ClassSeat[seatNumber].planAction.tempPlanID[i]].Triggered:= false;
              //setlength(core.ClassSeat[seatNumber].planAction.tempPlanID,0);
            end;
          end;
        end;
      end else
      // run the action
      if core.ClassSeat[seatNumber].planAction.runOnAction AND not(core.ClassSeat[seatNumber].planAction.runIndex=-1) then
      begin

         // reset if stalk or action in action default ignored and not in planed action
        if (core.getNPCState(seatNumber)=IsStalking) OR
          (inTArray(core.ClassSeat[seatNumber].actions.Action,ignoreAct) AND not(inTArray(core.ClassSeat[seatNumber].planAction.runTargetAction,ignoreAct))) then
        begin
          core.ClassSeat[seatNumber].planAction.runOnAction:= false;
          core.ClassSeat[seatNumber].planAction.runIndex:=-1;
        end else
        begin

        // change target on force mode
        if core.ClassSeat[seatNumber].planAction.Forced AND ((core.ClassSeat[seatNumber].actions.Status=3) AND
          not(core.ClassSeat[seatNumber].actions.ToSeatAddr=core.ClassSeat[seatNumber].planAction.runTargetAddress)) then
        begin
          core.GameData.Process.SetValues(core.ClassSeat[seatnumber].actAddress.target,4,core.ClassSeat[seatNumber].planAction.runTargetAddress);
          core.ClassSeat[seatNumber].actions.ToSeat:= core.ClassSeat[seatNumber].planAction.runTargetSeat;
          core.ClassSeat[seatNumber].actions.ToSeatAddr:= core.ClassSeat[seatNumber].planAction.runTargetAddress;
        end;

        // Check if fullfil
        if not(core.ClassSeat[seatNumber].actions.ToSeat=-1) AND (core.ClassSeat[seatNumber].actions.ToSeatAddr=core.ClassSeat[seatNumber].planAction.runTargetAddress) then
        begin

          // change action
          if (core.ClassSeat[seatNumber].actions.Status in [3,5,6]) and not(core.ClassSeat[seatNumber].actions.ToSeat=-1) AND
            not((core.ClassSeat[seatNumber].actions.Action>=53) AND (core.ClassSeat[seatNumber].actions.Action<=62)) AND
            (core.ClassSeat[seatNumber].actions.ToSeatAddr=core.ClassSeat[seatNumber].planAction.runTargetAddress) then
          begin
            core.ClassSeat[seatNumber].actions.cancelType:= '[PAC]';
            core.GameData.Process.SetValues(core.ClassSeat[seatnumber].actAddress.action,4,inttostr(core.ClassSeat[seatNumber].planAction.runTargetAction));
            core.ClassSeat[seatNumber].actions.Action:= core.ClassSeat[seatNumber].planAction.runTargetAction;
          end;

          // reset if chating
          if (core.ClassSeat[seatNumber].actions.Status in [0,7]) AND (core.ClassSeat[seatNumber].actions.Action=core.ClassSeat[seatNumber].planAction.runTargetAction) then
          begin
            core.ClassSeat[seatNumber].actions.cancelType:= '[PAC]';
            core.ClassSeat[seatNumber].planAction.ListAction[core.ClassSeat[seatNumber].planAction.runIndex].Triggered:= true;
            core.ClassSeat[seatNumber].planAction.runOnAction:= false;
          end;
        end else
        // interupt from other
        if ((core.ClassSeat[seatNumber].actions.Status in [0,7]) OR (core.ClassSeat[seatNumber].actions.Status=4294967295)) AND
          not(core.ClassSeat[seatNumber].actions.ToSeatAddr=core.ClassSeat[seatNumber].planAction.runTargetAddress) then
        begin
          core.ClassSeat[seatNumber].planAction.runOnAction:= false;
          core.ClassSeat[seatNumber].planAction.runIndex:=-1;
        end;
      end;
      end;

      // all trigered action must added to list run array
      if not(core.ClassSeat[seatNumber].planAction.runIndex=-1) then
        if core.ClassSeat[seatNumber].planAction.ListAction[core.ClassSeat[seatNumber].planAction.runIndex].Triggered AND
        not(inTArray(core.ClassSeat[seatNumber].planAction.runIndex,core.ClassSeat[seatNumber].planAction.indexRunID)) then
        begin
          SetLength(core.ClassSeat[seatNumber].planAction.indexRunID,length(core.ClassSeat[seatNumber].planAction.indexRunID)+1);
          core.ClassSeat[seatNumber].planAction.indexRunID[length(core.ClassSeat[seatNumber].planAction.indexRunID)-1]:= core.ClassSeat[seatNumber].planAction.runIndex;
          core.ClassSeat[seatNumber].planAction.runIndex:= -1;
        end;
    end;

  end;
end;

{ ==================================================================================== LOADER CLASS ============================================}

procedure TMainForm.setReiComponent;
var
  i: integer;
  S: TStringList;
  D: TStrings;
  setName: string;
begin
  // get all rei override xml
  core.XMLData.TextObj.Delete['PERSONALITY'];
  setName:= core.XMLData.TextObj.Items['reiPath'];
  if DirectoryExists(setName) then
    core.XMLData.XMLREI(MainForm,setName);

  // FOR PERSONALITY

  // save default personality
  if not(core.XMLData.TextObj.Contain('defaultPersonality')) then
  for i:= 0 to Personality.Items.Count-1 do
  begin
    setName:= inttostr(i);
    if (i < 10) then setName:= '0'+setName;
    core.XMLData.TextObj.Data['defaultPersonality',setName]:= Personality.Items.Strings[i];
  end;

  // get rei xml and sort
  D:= TStringList.Create;
  try
    D.AddStrings(core.XMLData.TextObj.Strings['defaultPersonality']);
    for i:= 0 to D.Count-1 do
      core.XMLData.TextObj.Data['PERSONALITY',D.Names[i]]:= D.Values[D.Names[i]];
    REIPersonality:= TStringList.Create;
    REIPersonality.AddStrings(core.XMLData.TextObj.Strings['PERSONALITY']);
    REIPersonality.Sort;
  finally
    D.Free;
  end;

  S:= TStringList.Create;
  try
    for i:= 0 to REIPersonality.Count-1 do
      S.Add(REIPersonality.Names[i]+'.'+REIPersonality.Values[REIPersonality.Names[i]]);
    Personality.Clear;
    Personality.Items.AddStrings(S);
  finally
    S.Free;
  end;

  // FOR FEMALE CLOTH
  HEXAClothF:= TStringList.Create;
  if core.XMLData.TextObj.Contain('CLOTHES_F') then
    HEXAClothF.AddStrings(core.XMLData.TextObj.Strings['CLOTHES_F'])
  else
  begin
    HEXAClothF.add('00=Uniform');
    HEXAClothF.add('01=Sport');
    HEXAClothF.add('02=Swimsuit');
    HEXAClothF.add('03=Suit');
    HEXAClothF.add('04=Blazer');
    HEXAClothF.add('05=Naked');
    HEXAClothF.add('06=Underwear');
    HEXAClothF.add('07=Uniform 2');
  end;
  HEXAClothF.sort;
  S:= TStringList.Create;
  try
    for i:= 0 to HEXAClothF.Count-1 do
      S.Add(HEXAClothF.Names[i]+'.'+HEXAClothF.Values[HEXAClothF.Names[i]]);
    HEXAClothFF:= TStringList.Create;
    HEXAClothFF.AddStrings(S);
  finally
    S.Free;
  end;

  // FOR MALE CLOTH
  HEXAClothM:= TStringList.Create;
  if core.XMLData.TextObj.Contain('CLOTHES_M') then
    HEXAClothM.AddStrings(core.XMLData.TextObj.Strings['CLOTHES_M'])
  else
  begin
    HEXAClothM.add('00=Uniform');
    HEXAClothM.add('01=Sport');
    HEXAClothM.add('02=Swimsuit');
    HEXAClothM.add('03=Naked');
  end;
  HEXAClothM.sort;
  S:= TStringList.Create;
  try
    for i:= 0 to HEXAClothM.Count-1 do
      S.Add(HEXAClothM.Names[i]+'.'+HEXAClothM.Values[HEXAClothM.Names[i]]);
    HEXAClothMM:= TStringList.Create;
    HEXAClothMM.AddStrings(S);
  finally
    S.Free;
  end;
  
  // FOR PlanAction
  lstActName:= 'planAction';
  if (cDebug.Visible) then lstActName:= 'allAction';
  S:= TStringList.Create;
  try
    for i:= 0 to StringStore.StringsByName[lstActName].Count-1 do
      S.Add(StringStore.StringsByName[lstActName].Names[i]+'.'+StringStore.StringsByName[lstActName].Values[StringStore.StringsByName[lstActName].Names[i]]);
    PlanActionName:= TStringList.Create;
    PlanActionName.Add('- Select Action -');
    PlanActionName.AddStrings(S);
  finally
    S.Free;
  end;

  // FOR Limit Action
  cb_limitAll.Clear;
  cb_limitAct.Clear;
  cb_limitAll.Items.AddStrings(StringStore.StringsByName['allAction']);
  cb_limitAct.Items.AddStrings(StringStore.StringsByName['allAction']);

  // FOR Force Action
  forceNPCAction.forceAction.Clear;
  forceNPCAction.forceAction.Items.Add('-1=- Select Action -');
  forceNPCAction.forceAction.Items.AddStrings(StringStore.StringsByName[lstActName]);

  // FOR Random Action
  randomActionSel.Clear;
  randomActionSel.Items.AddStrings(StringStore.StringsByName[lstActName]);

  // FOR ACTION
  {
  S.Clear;
  D.Clear;
  D:= core.Codes.TextObj.Strings['ACTION_KEY'];
  for i:= 0 to D.Count-1 do
    S.Add(D.Names[i]+'.'+D.Values[D.Names[i]]);

  Action.Clear;
  Action.Items.AddStrings(S);
  }
end;

procedure TMainForm.VoiceConfigTips(Sender: TObject;
      var ToolTipText: String);
begin
  case (Sender as TJvTrackBar).Tag of
    20001: ToolTipText:= FloatToStr(strtoint(ToolTipText)/100);
    20003: ToolTipText:= FloatToStr(strtoint(ToolTipText)/10);
    20002: ToolTipText:= intToStr(ceil(strtoint(ToolTipText)/40))+'%';
    4131: ToolTipText:= intToStr(ceil((strtoint(ToolTipText)*100)/255))+'%';
  end;
end;

procedure TMainForm.voiceConfigChange(Sender: TObject);
begin
  isReadData:= false;
end;

procedure TMainForm.voiceConfigChanged(Sender: TObject);
begin
  isWriteData:= true;
  setCompValue(Sender);
end;

procedure TMainForm.setComponent;
var
  i, rowTop, rowLeft: integer;
  perID: string;
begin
  // gfeelings
  {
  for i:= 0 to 85 do
  begin
    perID:= inttostr(i);
    if (i <= StrHolders.ItemByName['Feelings'].Strings.Count-1) then
      perID:= StrHolders.ItemByName['Feelings'].Strings[i];

     m:= TMenuItem.Create(pFeelings);
     m.Caption:= perID;
     m.Name:= 'bFeeling_'+inttostr(i);
     //m.OnClick:= setOutfits;

     pFreezeFeel.Add(m);
  end;
  }

  // clipboard color
  clipboardColor.LastIndex:= 0;
  for i:= 0 to 11 do
  begin
    clipboardColor.Name[i]:= '[Name]';
    clipboardColor.Color[i]:= clBtnFace;
  end;

  // seat color
  for i:= 0 to ComponentCount-1 do
  if (Components[i] is TPanel) AND (Components[i].Tag=4131) then
  begin
    seatColor.defColor[TPanel(Components[i]).TabOrder]:= TPanel(Components[i]).Color;
    if seatColor.isLoaded then
      TPanel(Components[i]).Color:= seatColor.newColor[TPanel(Components[i]).TabOrder];
  end;

  if (FrontHair.Items.Count<200) then
  begin
    for i:= FrontHair.Items.Count to 200 do
      FrontHair.Items.AddText(inttostr(i)); //130 do
    for i:= SideHair.Items.Count to 200 do
      SideHair.Items.AddText(inttostr(i)); //134 do
    for i:= BackHair.Items.Count to 200 do
      BackHair.Items.AddText(inttostr(i)); //131 do
    for i:= ExtHair.Items.Count to 200 do
      ExtHair.Items.AddText(inttostr(i));   //134 do
  end;

  setReiComponent;

  sleep(36);

  if (length(core.voiceConfig)>0) then
  for i:= 0 to 127 do
  begin
    if not(core.voiceConfig[i].VoiceID=nil) then core.voiceConfig[i].VoiceID.Free;
    if not(core.voiceConfig[i].VoiceVal=nil) then core.voiceConfig[i].VoiceVal.Free;
  end;

  // config personality voice
  SetLength(core.voiceConfig,128);
  rowTop:= LVoice1.Top;
  for i:= 0 to length(core.voiceConfig)-1 do
  begin
    case (i mod 5) of
      0: begin
        if (i>=5) then
        begin
          rowTop:= rowTop + 48;
          pNPCVoice.Height:= rowTop + 48;
        end;
        rowLeft:= LVoice1.Left;
      end;
      1: rowLeft:= LVoice2.Left;
      2: rowLeft:= LVoice3.Left;
      3: rowLeft:= LVoice4.Left;
      4: rowLeft:= LVoice5.Left;
    end;

    core.voiceConfig[i].VoiceID:= TJvCheckBox.CreateParented(pNPCVoice.Handle);
    with core.voiceConfig[i].VoiceID do
    begin
      left:= rowLeft;
      top:= rowTop;
      Width:= 161;
      Height:= 17;
      parent:= pNPCVoice;

      perID:= inttostr(i);
      if i<10 then perID:= '0'+inttostr(i);
      Caption:= core.XMLData.TextObj.Data['PERSONALITY',perID];

      if not(length(Caption)=0) then
      begin
        Caption:= perID+'. '+Caption;
        Font.Color:= clRed;
        Font.Style:= [fsBold];
      end else
        Caption:= 'Number '+IntToStr(i);

      name:= 'VO'+inttostr(i+1);
      OnMouseUp:= setCompCboxValue;
      Hint:= 'gameConfig';
      Tag:= 20005;
    end;

    core.voiceConfig[i].VoiceVal:= TJvTrackBar.CreateParented(pNPCVoice.Handle);
    with core.voiceConfig[i].VoiceVal do
    begin
      left:= rowLeft-7;
      top:= rowTop+20;
      Width:= 161;
      Height:= 25;
      parent:= pNPCVoice;
      ShowRange:= false;
      ToolTips:= true;
      ToolTipSide:= tsBottom;
      TickStyle:= tsManual;
      OnToolTip:= voiceConfigTips;
      OnChange:= voiceConfigChange;
      OnChanged:= voiceConfigChanged;
      Name:= 'VOV'+inttostr(i+1);
      Max:= 100;
      Hint:= 'gameConfig';
      Tag:= 20001;
    end;
  end;
end;

procedure TMainForm.manageConfig(const save: boolean = false);
var
  lstConfig: TStrings;
  i, ii: integer;
begin
  lstConfig:= TStringList.Create;

  try

  if save then
  begin
    lstConfig.Clear;
    for i:= 0 to ComponentCount-1 do
    if (Components[i] is TPanel) AND (Components[i].Tag=4131) then
      lstConfig.Values[inttostr(TPanel(Components[i]).TabOrder)]:= inttostr(HexStringToColor(dec2hex(TPanel(Components[i]).Color,8),true));

    core.XMLData.TextObj.Items['disableInteractiveEvent']:= BoolToStr(disableInteractiveEvent,true);

    //core.XMLData.TextObj.Items['debug']:= BoolToStr(cDebug.Enabled,true);
    core.XMLData.TextObj.Items['disableAutoBackup']:= BoolToStr(cDisableBackup.Checked,true);
    core.XMLData.TextObj.Items['lowestVirtue']:= BoolToStr(cLowestVirtue.Checked,true);
    core.XMLData.TextObj.Items['lowestVirtueVal']:= IntToStr(cLowestVirtueSet.ItemIndex);
    core.XMLData.TextObj.Items['disablePregnantCheck']:= BoolToStr(cResetPregnant.Checked,true);
    core.XMLData.TextObj.Items['disablePregnantCheckVal']:= inttostr(cResetPregnantVal.ItemIndex);
    core.XMLData.TextObj.Items['formAlphaBlend']:= BoolToStr(cAlphaBlend.Checked,true);
    core.XMLData.TextObj.Items['formAlphaBlendVal']:= IntToStr(cAlphaBlendVal.Position);
    core.XMLData.TextObj.Items['formStayOnTop']:= BoolToStr(cStayOnTop.Checked,true);
    core.XMLData.TextObj.Items['limitActionSet']:= BoolToStr(cb_limitActionAll.Checked,true);
    core.XMLData.TextObj.Items['limitAction']:= Implode(',',lst_limitAll.Items);
    core.XMLData.TextObj.Items['autoPauseTimer']:= BoolToStr(autoPauseChar.Checked,true);
    core.XMLData.TextObj.Items['autoCreateClass']:= BoolToStr(autoCreateClass.Checked,true);
    core.XMLData.TextObj.Items['randomAction']:= BoolToStr(randomAction.Checked,true);
    core.XMLData.TextObj.Items['randomTarget']:= BoolToStr(randomAction.Checked,true);
    core.XMLData.TextObj.Items['randomPlayer']:= BoolToStr(randomAction.Checked,true);
    core.XMLData.TextObj.Items['randomActionVal']:= Implode(',',randomActionVal.Items);
    core.XMLData.TextObj.Items['randomActionTime']:= IntToStr(randomActionTime.Position);
    core.XMLData.TextObj.Items['disableAutoMode']:= BoolToStr(disableAutoMode.Checked,true);
    core.XMLData.TextObj.Items['disableCreateLogs']:= BoolToStr(cDisableNPCEventFile.Checked,true);
    core.XMLData.TextObj.Items['seatColor']:= Implode(',',lstConfig);

    sleep(100);

    lstConfig.Clear;
    //lstConfig.Add('debug');
    lstConfig.Add('reiPath');
    lstConfig.Add('disableInteractiveEvent');

    lstConfig.Add('lowestVirtue');
    lstConfig.Add('lowestVirtueVal');
    lstConfig.Add('disablePregnantCheck');
    lstConfig.Add('disablePregnantCheckVal');
    lstConfig.Add('disableAutoBackup');
    lstConfig.Add('formAlphaBlend');
    lstConfig.Add('formAlphaBlendVal');
    lstConfig.Add('formStayOnTop');
    lstConfig.Add('limitActionSet');
    lstConfig.Add('limitAction');
    lstConfig.Add('autoPauseTimer');
    lstConfig.Add('autoCreateClass');
    lstConfig.Add('randomAction');
    lstConfig.Add('randomTarget');
    lstConfig.Add('randomPlayer');
    lstConfig.Add('randomActionVal');
    lstConfig.Add('randomActionTime');
    lstConfig.Add('disableAutoMode');
    lstConfig.Add('disableCreateLogs');
    lstConfig.Add('seatColor');
    core.XMLData.XMLManager(MainForm,appDir+configFile,lstConfig,true);
  end else
  begin
    core.XMLData.XMLManager(MainForm,appDir+configFile);
    if core.XMLData.TextObj.Contain('reiPath') then
      eReiPath.Text:= core.XMLData.TextObj.Items['reiPath'];
      
    if core.XMLData.TextObj.Contain('disableInteractiveEvent') then
    begin
      disableInteractiveEvent:= StrToBoolDef(core.XMLData.TextObj.Items['disableInteractiveEvent'],false);
      cDisableInteractiveEvent.Checked:= disableInteractiveEvent;
    end;

    if core.XMLData.TextObj.Contain('disableCreateLogs') then
      cDisableNPCEventFile.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['disableCreateLogs'],false);

    if core.XMLData.TextObj.Contain('disableAutoMode') then
      disableAutoMode.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['disableAutoMode'],false);

    if core.XMLData.TextObj.Contain('lowestVirtue') then
      cLowestVirtue.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['lowestVirtue'],false);

    if core.XMLData.TextObj.Contain('lowestVirtueVal') then
      cLowestVirtueSet.ItemIndex:= strtoint(core.XMLData.TextObj.Items['lowestVirtueVal']);

    if core.XMLData.TextObj.Contain('randomAction') then
    begin
      randomAction.Checked     := StrToBoolDef(core.XMLData.TextObj.Items['randomAction'],false);
      randomTarget.Checked     := StrToBoolDef(core.XMLData.TextObj.Items['randomTarget'],true);
      randomToPlayer.Checked     := StrToBoolDef(core.XMLData.TextObj.Items['randomPlayer'],false);
      randomActionTime.Position:= strtoint(core.XMLData.TextObj.Items['randomActionTime']);
      randomActionVal.Clear;
      lstConfig.Clear;
      lstConfig.AddStrings(Explode(',',core.XMLData.TextObj.Items['randomActionVal']));
      if (lstConfig.Count>0) then
      for i:= 0 to lstConfig.Count-1 do
      if not(lstConfig.Names[i]='') AND not(lstConfig.Names[i]='-1') then
        randomActionVal.Items.Add(lstConfig.Strings[i]);
    end;

    if core.XMLData.TextObj.Contain('seatColor') then
    begin
      lstConfig.Clear;
      lstConfig.AddStrings(Explode(',',core.XMLData.TextObj.Items['seatColor']));
      if (lstConfig.Count>0) then
      for i:= 0 to lstConfig.Count-1 do
        seatColor.newColor[strtoint(lstConfig.Names[i])]:= HexStringToColor(dec2hex(strtoint64(lstConfig.ValueFromIndex[i]),8));
      seatColor.isLoaded:= true;
    end;

    //cStayOnTop.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['formStayOnTop'],false);
    //if cStayOnTop.Checked then mainform.FormStyle:= fsStayOnTop
    //else mainform.FormStyle:= fsNormal;

    cAlphaBlend.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['formAlphaBlend'],false);
    if core.XMLData.TextObj.Contain('formAlphaBlendVal') then
    begin
      cAlphaBlendVal.Position:= strtoint(core.XMLData.TextObj.Items['formAlphaBlendVal']);
      MainForm.AlphaBlend:= cAlphaBlend.Checked;
      if cAlphaBlend.Checked then
        MainForm.AlphaBlendValue:= cAlphaBlendVal.Position;
    end;

    cResetPregnant.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['disablePregnantCheck'],false);
    if core.XMLData.TextObj.Contain('disablePregnantCheckVal') then
      cResetPregnantVal.ItemIndex:= strtoint(core.XMLData.TextObj.Items['disablePregnantCheckVal']);
    cDisableBackup.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['disableAutoBackup'],false);
    cDisableNPCEventFile.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['disableEventFile'],false);
    if core.XMLData.TextObj.Contain('limitActionSet') then
      cb_limitActionAll.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['limitActionSet'],false);
    if core.XMLData.TextObj.Contain('limitAction') then
    begin
      lst_limitAll.Clear;
      lst_limitAll.Items.AddStrings(Explode(',',core.XMLData.TextObj.Items['limitAction']));
    end;

    if core.XMLData.TextObj.Contain('autoPauseTimer') then
      autoPauseChar.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['autoPauseTimer'],false);

    if core.XMLData.TextObj.Contain('autoCreateClass') then
      autoCreateClass.Checked:= StrToBoolDef(core.XMLData.TextObj.Items['autoCreateClass'],false);

    if FileExists(appDir+'dev') OR core.XMLData.TextObj.Contain('debug') then
      cDebug.Visible:= true
    else cDebug.Visible:= false;
  end;

  finally
    lstConfig.Free;
  end;
end;

procedure TMainForm.prepareTrainer;
begin
  if not(trainerReady) then
  if (counter=0) then
  begin
    inc(counterDelay);
    if (counterDelay mod 15=0) then
      if core.findGame then counter:= 1
      else begin
        progress.Caption:= 'Checking Game ...';
        statusBar.Panels[0].Text:= 'Waiting for Game Running...';
      end;
  end else
  if (counter=1) then
  begin
    progress.Caption:= 'Initialing ...';
    if (progress.Position<=15) then
      progress.Position:= progress.Position+1
    else counter:= 10;
  end else
  if (counter=10) then
  begin
    loadTrainer.Enabled:= false;
    counter:= 2;
    progress.Caption:= 'Load Config ...';
    setDefault;
    progress.Position:= 20;
    manageConfig;
    progress.Position:= 30;
    loadTrainer.Enabled:= true;
  end else
  if (progress.Position=30) then
  begin
    loadTrainer.Enabled:= false;
    progress.Caption:= 'Create Component ...';
    setComponent;
    progress.Position:= 55;
    loadTrainer.Enabled:= true;
  end else
  if (progress.Position=55) then
  begin
    loadTrainer.Enabled:= false;
    progress.Caption:= 'Populate Codes ...';
    generateCode;
    progress.Position:= 80;
    loadTrainer.Enabled:= true;
  end else
  if (progress.Position>=80) then
  begin
    progress.Caption:= 'Checking invalid data ...';
    progress.Position:= progress.Position+1;
    if (progress.Position>=100) then
    begin
      loadTrainer.Enabled:= false;
      trainerReady:= true;
      checkGame.Enabled:= true;
      progress.Caption:= 'All Finish, ready to use.';
    end;
  end;
end;

procedure TMainForm.initTrainer;
resourcestring gameNotInstall = 'Registry Game AA2 Not Found!';
resourcestring gameNotRunning = 'Game AA2 Is not Running!';
var
  appVersion: string;
begin
  counter:= 0;
  counterDelay:= 0;
  gameReady:= false;
  classExist:= false;
  trainerReady:= false;
  firstRun:= true;
  respawnSeat:= false;
  skipAutoBackup:= false;

  setOverlay;
  setHotkey;

  appDir:= ExtractFilePath(Application.ExeName);

  if not(DirectoryExists(appDir+'\Save')) then
    CreateDir(appDir+'\Save');

  core:= TCore.Create;
  //exit;
  if core.initGame then
  begin
    //if core.findGame then
    //begin
      appVersion:= ExtractFileName(Application.ExeName)+' Build('+getFileVersion(Application.ExeName)+')';
      core.XMLData.TextObj.Items['version']:= appVersion;
      core.XMLData.TextObj.Items['shortVersion']:= getFileVersion(Application.ExeName);
      MainForm.Caption:= appTitle+' ('+Core.XMLData.TextObj.Items['shortVersion']+')';
    //end else
    //if MessageDlg(gameNotRunning,mterror,[mbok],0) = mrok then
    //begin
    //  core.Free;
    //  Application.Terminate;
    //end;
  end else
  if MessageDlg(gameNotInstall,mterror,[mbok],0) = mrok then
  begin
    core.Free;
    Application.Terminate;
  end;
end;

procedure TMainForm.manageClass(const readClass: boolean = true; const hideOverlay: boolean = false; const forceAuto: boolean = false);
begin
  if initClass then
  begin
    initClass:= false;

    if checkGame.Enabled then checkGame.Enabled:= false;

    // open class
    if readClass then
    begin
      //initClass:= true;
      //manageClass(false,true);

      //sleep(200);
      core.createSeat;
      core.createIgnoreSeat;
      sleep(200);
      core.countSeat;
      core.initClassData;
      core.setActionAddress;
      createThumbList;
      initTabComponent;
      refreshCharacterSeat;

      core.showClassSeat;
      playedCharacter;
      initPlanAction;

      if not cDisableBackup.Checked and not(skipAutoBackup) then
      begin
        if FileExists(appdir+'Save\'+SaveGameName+'.dat') then
          LoadPlanAction(appdir+'Save\'+SaveGameName+'.dat',true)
        else LoadPlanAction(appdir+'Save\'+backupFile,true);
      end else statusBar.Panels[2].Text:= 'Trainer Data: empty';

      classReady:= true;
      isReadData:= true;
      firstRun:= false;
      skipAutoBackup:= false;

      initClass:= true;

      setOverlay(false);
      statusBar.Panels[0].Text:= 'Class Ready.';

      if not(checkGame.Enabled) then
        checkGame.Enabled:= true;

      sleep(300);
      manageTimer;
      redrawSeatBox;
      isWriteData:= true;
    end else
    // close class
    begin
      if not(hideOverlay) then setOverlay;

      // clear the class data
      if classReady then
      begin
        pauseNPCTimer:= true;
        classReady:= false;
        resetplayerAct;

        if not(cDisableBackup.Checked) AND (forceAuto OR not(hideOverlay)) AND not(skipAutoBackup) then
          SavePlanAction(appdir+'Save\'+backupFile,true);

        manageTimer(false);

        generateEventLogs;

        sleep(200);
        setDefault;
      end;

      if not(hideOverlay) AND not(checkGame.Enabled) then
        checkGame.Enabled:= true;
    end;
  end;
end;

procedure TMainForm.checkClassChange;
var
  countSeat: integer;
begin
  if ((gameStateID=5) OR (gameStateID>=10)) AND not(respawnSeat) then
  begin
    if autoCreateClass.Checked then
    begin
      countSeat:= core.countSeat;
      if not(CountSeat=0) AND not(CountSeat=core.maxChar) then
      begin
        initClass:= true;
        manageClass;
        core.maxChar:= countseat;
        core.XMLData.TextObj.Items['maxClass']:= inttostr(core.maxChar);
        sleep(200);
      end else
      if (countSeat=0) then
        setOverlay;
    end else
    begin
      if not(readClass.Enabled) then
        readClass.Enabled:= true;
      statusBar.Panels[0].Text:= 'Waiting for Class Ready ...';
    end;

  end else
  if (gameStateID=9) then
  begin
    manageClass(false);
    statusBar.Panels[0].Text:= 'Waiting for loading screen ...';
  end;
end;

function TMainForm.checkClassExist: boolean;
var
  lstClassName: TStrings;
begin
  Result:= false;
  lstClassName:= TStringList.Create;
  try
    SaveGameName:= core.GameData.Process.GetValues(classNameAddress,11,255,true);
    lstClassName:= explode('.',SaveGameName);
    if (lstClassName.Count > 1) then
      Result:= true;
  finally
    lstClassName.Free;
  end;
end;

procedure tmainform.getGameScreen;
const
  gameStateAddr: dword = $0038F6B0;
var
  getval: string;
  check: integer;
begin
  // For game behavior
  getval:= core.GameData.Process.GetValues(gameStateAddr+core.GameData.Process.PBaseAddress,4);
  val(getval,gameStateID,check);

  // for one run checked
  if not(gameStateID=gameStateOldID) then
    gameStateOldID:= gameStateID;

  // for statue bar
  if (gameStateID>0) AND (gameStateID<length(GameState)-1) then
    MainForm.Caption:= trainerCaption+' | Screen: '+GameState[gameStateID];
  //else statusBar.Panels[0].Text:= ' Screen: '+inttostr(gameStateID)+'. ???';

  // auto pause timer
  if autoPauseChar.Checked then
    if (gameStateID=11) AND ((TimeScreen.ItemIndex>0) AND (TimeScreen.ItemIndex<9)) then
      pauseNPCTimer:= false
    else pauseNPCTimer:= true;

  // stop read class if screen not in homescreen and time fallsleep,morning
  if classExist AND not(gameStateID=11) AND (TimeScreen.ItemIndex=9) then
  begin
    respawnSeat:= true;
    if (gameStateID=12) then skipAutoBackup:= true;
  end else
    respawnSeat:= false;
end;

procedure TMainForm.checkGames;
resourcestring
  notVersion = 'This trainer not tested for Game version ';
  stillContinue = ' , continue?';
begin
  inc(counter);

  if (counter mod 15 = 0) then
  begin
    gameRunning:= core.findGame;
    if gameRunning then
    begin
      
      if not(initGames) then
      begin
        initGames:= true;

        initMainAddress;

        trainerCaption:= appTitle+' ('+Core.XMLData.TextObj.Items['shortVersion']+') - '+core.GameInfo.ExeName+' ('+core.GameInfo.Version+')';
        MainForm.Caption:= trainerCaption;

        // check game version
        if not(core.GameInfo.Version = '2.0.1.0') then
        begin
          checkGame.Enabled:= false;
          if messagedlg(notVersion+core.GameInfo.Version+stillContinue,mtwarning,[mbyes,mbno],0) = mrno then
          begin
            Application.Terminate;
            exit;
          end;
        end;

        routine.Active:= true;
      end;

      getGameScreen;

      // check class
      classExist:= checkClassExist;
      if classExist then
      begin
        checkClassChange;
      end else
      begin
        manageClass(false);
        statusBar.Panels[0].Text:= 'Waiting for Class Ready ...';
      end;

    end else
    if initGames or firstRun then
    begin
      initGames:= false;
      manageClass(false);
      statusBar.Panels[0].Text:= 'Waiting for Game Running ...';
    end;
  end;
end;

procedure TMainForm.MainGameData;
var codeKey: string;
begin
  if classReady AND isReadData then
  begin
    if (core.GameData.CharCode.Contain(core.GameData.codekey[0])) then
    begin
      codeKey:= core.GameData.codekey[0];
      dayName.ItemIndex:= strtoint64(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'DayName'],true));
      dayWeek.ItemIndex:= ((strtoint64(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'DayWeek'],true))-1) div 7);
      TimeScreen.ItemIndex:= strtoint64(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'TimeScreen'],true));
      ClassName.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'ClassName']);
      Year.Text:= inttostr(strtoint64(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Year'],true))-48);
      Classess.Text:= inttostr(strtoint64(core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'Classess'],true))-48);
      SaveName.Text:= core.GameData.getValueByCode(core.GameData.CharCode.Data[codeKey,'SaveName']);
    end;
  end;
end;


{ ================================================================= AUTO CREATE ================================================================= }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  initTrainer;
end;

procedure TMainForm.readClassClick(Sender: TObject);
var countSeat: integer;
begin
  if gameRunning AND classExist then
  begin
    countSeat:= core.countSeat;
    if not(CountSeat=0) AND not(CountSeat=core.maxChar) then
    begin
      initClass:= true;
      manageClass;
      core.maxChar:= countseat;
      core.XMLData.TextObj.Items['maxClass']:= inttostr(core.maxChar);
    end;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  manageConfig(true);
  pauseNPCTimer:= true;
  routine.Active:= false;
  checkGame.Enabled:= false;
  manageClass(false,true,true);
  sleep(500);
  core.Free;
end;

procedure TMainForm.tabsChange(Sender: TObject);
begin
  if not(core.selectedChar=-1) AND not(isBinView) then
    parseTabCode
  else if isBinView AND not(lstBin.ItemIndex=-1) AND not(core.PasteBin.lastSelected=-1) then
    parseBinCode;
end;

procedure TMainForm.checkGameTimer(Sender: TObject);
begin
  checkGames;
end;

procedure TMainForm.routineEvents0Timer(Sender: TObject);
begin
  if classExist AND classReady and not(gameStateID in [9]) then
  begin
    // for header panel main game data
    MainGameData;
    // for bypass pragnant check
    resetPragnantEndWeek;

    // for disable autopc mode
    if disableAutoMode.Checked AND autoPC.StateOn and (TimeScreen.ItemIndex>=9) then
    begin
      autoPC.StateOn:= false;
      autoMode(true);
    end;

    if (counter mod 30 = 0) then
    begin
      // for autopc mode
      autoMode;

      // for read tabs data
      if isReadData and not(pauseNPCTimer) then
        if not(personalData.Collapsed) then
          parseTabCode
        else if not(actionData.Collapsed) and (featureTabs.TabIndex=1) then
          manageForceAction(IsAppControl);

      // for generate event logs
      if (TimeScreen.ItemIndex in [2,5,7,9]) AND not(lastTimeScreen=TimeScreen.ItemIndex) then
      begin
        lastTimeScreen:= TimeScreen.ItemIndex;
        generateEventLogs;
      end;
    end;

    if (counter mod 50 = 0) AND isReadData and not(pauseNPCTimer) and not(disableInteractiveEvent) AND
      personalData.Collapsed AND actionData.Collapsed AND pMisc.Collapsed then
      redrawSeatBox;
  end;
end;

procedure TMainForm.cDisableInteractiveEventMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (button=mbleft) then
    disableInteractiveEvent:= cDisableInteractiveEvent.Checked;
end;

procedure TMainForm.routineEvents1Timer(Sender: TObject);
begin
  if classReady and not(pauseNPCTimer) then core.runtimeFreezeData;
end;

procedure TMainForm.routineEvents2Timer(Sender: TObject);
const
  timeOff  : array [0..1] of dword = ($2C,$2C);
  timeTot  : array [0..1] of dword = ($34,$2C);
  timeAddr : dword = $00376164;
var
  realTimeAddr: dword;
  getVal: string;
begin
  if classReady and isReadData then
  begin
    realTimeAddr:= core.GameData.Process.GetRealAddress(timeAddr+core.GameData.Process.PBaseAddress,timeTot);
    getval:= core.GameData.Process.GetValues(realTimeAddr,4);
    if not(getVal='') OR not(getVal[1]='?') then
      EGTot.Text:= getVal;

    realTimeAddr:= core.GameData.Process.GetRealAddress(timeAddr+core.GameData.Process.PBaseAddress,timeOff);
    getTimes:= core.GameData.Process.GetValues(realTimeAddr,4);
    if not(getTimes='') AND not(getTimes[1]='?') then
    begin
      if cbTime.Checked then
        core.GameData.Process.SetValues(realTimeAddr,4,freezeTime);

      EGMin.Text:= inttostr(strtoint64(getTimes) div 60000);
      EGSec.Text:= inttostr((strtoint64(getTimes) div 1000) mod 60);
    end;
  end;
end;

procedure TMainForm.PersonalData1Click(Sender: TObject);
begin
  if not(senderGrid.toCharID=-1) then
    selectedNPCDblClick(core.ClassSeat[senderGrid.toCharID].views.seatBox);
end;

procedure TMainForm.ConfigPageChange(Sender: TObject);
begin
  configTabs;
end;

procedure TMainForm.cbTimeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button=mbLeft then
    freezeTime:= getTimes;
end;

procedure TMainForm.Button2Click(Sender: TObject);
var i: integer;
begin
  gridFreeze.Clear;
  //if (gridFreeze.ColCount=1) then
 // begin
    gridFreeze.ColCount:= 8;
    gridFreeze.RowCount:= 2;
    gridFreeze.FixedRows:= 1;
    gridFreeze.ColWidths[0]:= 40;
    gridFreeze.Cols[0].Add('No');
    gridFreeze.ColWidths[1]:= 160;
    gridFreeze.Cols[1].Add('Type');
    gridFreeze.ColWidths[2]:= 120;
    gridFreeze.Cols[2].Add('Name');
    gridFreeze.ColWidths[3]:= 60;
    gridFreeze.Cols[3].Add('Seat');
    gridFreeze.ColWidths[4]:= 60;
    gridFreeze.Cols[4].Add('ToSeat');
    gridFreeze.ColWidths[5]:= 50;
    gridFreeze.Cols[5].Add('Freeze');
    gridFreeze.ColWidths[6]:= 50;
    gridFreeze.Cols[6].Add('IsValid');
    gridFreeze.ColWidths[7]:= 200;
    gridFreeze.Cols[7].Add('Value');
  //end;

  if (length(core.GameData.FreezeData)>0) then
  begin
    gridFreeze.RowCount:= length(core.GameData.FreezeData)+1;
    for i:= 0 to length(core.GameData.FreezeData)-1 do
    begin
      gridFreeze.Rows[i+1].Strings[0]:= inttostr(i+1);
      gridFreeze.Rows[i+1].Strings[1]:= core.GameData.FreezeData[i].types;
      gridFreeze.Rows[i+1].Strings[2]:= core.GameData.FreezeData[i].field;
      gridFreeze.Rows[i+1].Strings[3]:= inttostr(core.GameData.FreezeData[i].seatNumber);
      gridFreeze.Rows[i+1].Strings[4]:= inttostr(core.GameData.FreezeData[i].toSeat);
      //gridFreeze.Rows[i+1].Strings[2]:= core.GameData.FreezeData[i].codes.code;
      //gridFreeze.Rows[i+1].Strings[3]:= Dec2Hex(core.GameData.FreezeData[i].codes.address,8);
      gridFreeze.Rows[i+1].Strings[5]:= BoolToStr(core.GameData.FreezeData[i].isFreeze,true);
      gridFreeze.Rows[i+1].Strings[6]:= BoolToStr(core.GameData.FreezeData[i].isValid,true);
      gridFreeze.Rows[i+1].Strings[7]:= core.GameData.FreezeData[i].FreezeValue;
    end;
    freezeTot.Caption:= inttostr(gridFreeze.RowCount-1);
  end;
end;

procedure TMainForm.routineEvents3Timer(Sender: TObject);
begin
  inc(counterDelay);
  if (counterDelay mod 100=0) then
  begin
    isReadData:= true;
    TJvTimer(sender).Enabled:= false;
  end;
end;

procedure TMainForm.Button7Click(Sender: TObject);
begin
  pChangeClub.Visible:= false;
  refreshCharacterSeat;
end;

procedure TMainForm.btnChangeClubClick(Sender: TObject);
begin
  getClubName;
  pChangeClub.Visible:= true;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if core.initGameFired AND not(trainerReady) then loadTrainer.Enabled:= true;
end;

procedure TMainForm.loadTrainerTimer(Sender: TObject);
begin
  prepareTrainer;
end;

procedure TMainForm.autoPCClick(Sender: TObject);
begin
  autoMode(true);
end;

procedure TMainForm.ActScrollbarChange(Sender: TObject);
begin
  planRefreshItem;
end;

procedure TMainForm.btnPlanActClick(Sender: TObject);
begin
  managePlanAction(IsAdd);
end;

procedure TMainForm.personalDataExpand(Sender: TObject);
begin
  if (core.selectedSeat=-1) OR (core.selectedChar=-1) then exit;

  case TJvRollOut(sender).tag of
    0: begin
      lstChar.ItemIndex:= ArrayIndexContainInteger(core.selectedSeat,seatIndex);
      lstCharActClick(lstChar);
    end;
    1: begin
      lstCharAct.ItemIndex:= ArrayIndexContainInteger(core.selectedSeat,seatIndex);
      lstCharActClick(lstCharAct);
    end;
  end;
end;

procedure TMainForm.lstCharActClick(Sender: TObject);
var
  showTab: boolean;
  i,seatNumber: integer;
begin
  showTab:= true;
  isBinView:= false;
  if (sender is TJvImageListBox) then
  begin
    selectedNPC(sender);
    if (core.selectedSeat=-1) OR (core.selectedChar=-1) then
    begin
      showTab:= false;
      tabs.Enabled:= false;
      panelAction.Enabled:= false;
    end else
    case TJvImageListBox(sender).Tag of
      0: begin
        if not(tabs.Enabled) then
          tabs.Enabled:= true;
        loadCharacter;
        showTab:= false;
      end;
      1: begin
        if not(panelAction.Enabled) then
          panelAction.Enabled:= true;
        managePlanAction(IsAppControl);
        limitAction(IsRefresh);

        if (core.classSeat[core.selectedSeat].actions.EventLogs=nil) then
          core.classSeat[core.selectedSeat].actions.EventLogs:= TStringList.Create;

        eventNote.Clear;
        eventNote.Lines.AddStrings(core.classSeat[core.selectedSeat].actions.EventLogs);
        eventNote.CurrentLine:= eventNote.Lines.Count-1;
      end;
    end;
  end;

  if showTab then
  if not(core.selectedSeat=-1) AND not(core.selectedChar=-1) then
  case gActionLeft.TabIndex of
    0:begin
      managePlanAction(IsAppControl);
    end;
    1: begin
      lst_limitAct.Clear;
      lst_limitAct.Items.AddStrings(core.classSeat[core.selectedSeat].limitActions);
    end;
    2:
    for i:= 0 to 24 do
    begin
      seatNumber:= seatIndex[i];
      core.IgnoreSeat[seatNumber].seatBox.Down:= false;
      core.IgnoreSeat[seatNumber].seatBox.Flat:= true;
      sleep(10);
      if not(core.ClassSeat[core.selectedSeat].ignoredSeat=nil) AND
        (core.ClassSeat[core.selectedSeat].ignoredSeat.IndexOfName(inttostr(seatNumber))>=0) then
      begin
        core.IgnoreSeat[seatNumber].seatBox.Down:= true;
        core.IgnoreSeat[seatNumber].seatBox.Flat:= false;
      end;
    end;
  end;
end;

procedure TMainForm.btnTerminateActClick(Sender: TObject);
begin
  if ((sender as TButton).Caption = 'Play Actions') then managePlanAction(IsNavControl)
  else managePlanAction(IsNavControl,false);
end;

procedure TMainForm.cLoopActMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button=mbleft) then managePlanAction(IsAppControl,false);
end;

procedure TMainForm.Copy1Click(Sender: TObject);
begin
  managePlanAction(IsCopy);
end;

procedure TMainForm.Paste1Click(Sender: TObject);
begin
  managePlanAction(IsPaste);
end;

procedure TMainForm.Clear1Click(Sender: TObject);
begin
  managePlanAction(IsClear,false,core.selectedSeat);
end;

procedure TMainForm.ClearAll1Click(Sender: TObject);
begin
  managePlanAction(IsClearAll,false);
end;

procedure TMainForm.PausePlanAction1Click(Sender: TObject);
begin
  managePlanAction(IsPause);
end;

procedure TMainForm.IgnorethisCharacter2Click(Sender: TObject);
begin
  managePlanAction(IsIgnored);
end;

procedure TMainForm.LoadAllData1Click(Sender: TObject);
begin
  managePlanAction(IsLoad);
end;

procedure TMainForm.SaveAllData1Click(Sender: TObject);
begin
  managePlanAction(IsSave);
end;

procedure TMainForm.btnLimitActClick(Sender: TObject);
begin
  limitAction(IsAdd);
end;

procedure TMainForm.btnLimitActAllClick(Sender: TObject);
begin
  limitAction(IsClearAll);
end;

procedure TMainForm.btnLimitCopyClick(Sender: TObject);
begin
  limitAction(IsCopy);
end;

procedure TMainForm.btnLimitPasteClick(Sender: TObject);
begin
  limitAction(IsPaste);
end;

procedure TMainForm.btnLimitRemClick(Sender: TObject);
begin
  limitAction(IsDelete);
end;

procedure TMainForm.btnLimitClearClick(Sender: TObject);
begin
  limitAction(IsClear);
end;

procedure TMainForm.btnLimitAddAllClick(Sender: TObject);
begin
  limitActionAll(IsAdd);
end;

procedure TMainForm.btnLimitAddAllActClick(Sender: TObject);
begin
  limitActionAll(IsClearAll);
end;

procedure TMainForm.btnLimitRemAllClick(Sender: TObject);
begin
  limitActionAll(IsDelete);
end;

procedure TMainForm.btnLimitClearAllClick(Sender: TObject);
begin
  limitActionAll(IsClear);
end;

procedure TMainForm.routineEvents4Timer(Sender: TObject);
begin
  if classExist AND classReady then
  begin
    if not(pauseNPCTimer) then playerAction;
    npcAction;
  end;
end;

procedure TMainForm.AddtoPlanAction1Click(Sender: TObject);
begin
  managePlanAction(IsAdd,false);
  {featureTabs.TabIndex:= 0;
  gActionLeft.TabIndex:= 0;
  if actionData.Collapsed then
    actionData.Expand;}
end;

procedure TMainForm.cHeadActionChange(Sender: TObject);
var i: integer;
begin
  if (core.selectedSeat=-1) or (TComboBox(sender).ItemIndex=0) then exit;

  if (length(core.ClassSeat[core.selectedSeat].planAction.ListAction)>0) then
  for i:= 0 to length(core.ClassSeat[core.selectedSeat].planAction.ListAction)-1 do
    core.ClassSeat[core.selectedSeat].planAction.ListAction[i].Action:= strtoint(TComboBox(sender).Items.Names[TComboBox(sender).ItemIndex]);

  planRefreshItem;
  cHeadAction.Visible:= false;
end;

procedure TMainForm.cHeadActionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in [vk_return,vk_tab] then
    cHeadActionChange(Sender)
  else if key=VK_ESCAPE then
    cHeadAction.Visible:= false;
end;

procedure TMainForm.btnForceStopClick(Sender: TObject);
begin
  if not(core.selectedSeat=-1) then
  begin
    core.ClassSeat[core.selectedSeat].actions.cancelType:= '[MCA]';
    managePlanAction(IsCancel,false,core.selectedSeat);
  end;
end;

procedure TMainForm.cAlphaBlendValChanged(Sender: TObject);
begin
  if MainForm.AlphaBlend then
    MainForm.AlphaBlendValue:= cAlphaBlendVal.Position;
end;

procedure TMainForm.cStayOnTopClick(Sender: TObject);
begin
  if (TCheckBox(sender).Name = 'cStayOnTop') then
  begin
    if TCheckBox(sender).Checked then mainform.FormStyle:= fsStayOnTop
    else mainform.FormStyle:= fsNormal;
  end else
  if (TCheckBox(sender).Name = 'cAlphaBlend') then
  begin
    MainForm.AlphaBlend:= TCheckBox(sender).Checked;
    if TCheckBox(sender).Checked then
      MainForm.AlphaBlendValue:= cAlphaBlendVal.Position;
  end;
end;

procedure TMainForm.FunAction1Click(Sender: TObject);
begin
  case TMenuItem(sender).MenuIndex of
    0: begin
      TMenuItem(sender).Checked:= not TMenuItem(sender).Checked;
      if TMenuItem(sender).Checked then manageForceAction(isAdd,senderData.seatNumber)
      else manageForceAction(IsCancel,senderData.seatNumber);
    end;
    2: begin
      TMenuItem(sender).Checked:= not TMenuItem(sender).Checked;
      manageForceAction(IsClearAll,senderData.seatNumber,TMenuItem(sender).Checked);
    end;
  end;
end;

procedure TMainForm.Copy2Click(Sender: TObject);
begin
  case TMenuItem(sender).MenuIndex of
    0: manageClipboardColor(IsAdd);
    2: manageClipboardColor(IsCopy);
    3: manageClipboardColor(IsPaste);
  end;
end;

procedure TMainForm.gridFunModeColumnClick(Sender: TObject;
  Column: TListColumn);
var i: integer;
begin
  case Column.Index of
    1: begin
      cHeadForceAction.Visible:= true;
      cHeadForceAction.ItemIndex:= 0;
    end;
    2: begin
      ForcedAct.Toggled:= not ForcedAct.Toggled;
      for i:= 0 to 24 do
        if not(core.ClassSeat[i].forceAction.Action<0) AND not(core.ClassSeat[i].forceAction.Action>255) then
          core.ClassSeat[i].forceAction.Active:= ForcedAct.Toggled;
    end;
  end;
  manageForceAction(IsAppControl);
end;

procedure TMainForm.cHeadForceActionChange(Sender: TObject);
var i: integer;
begin
  if (TComboBox(sender).ItemIndex=0) then
  begin
    cHeadForceAction.Visible:= false;
    exit;
  end;

  for i:= 0 to 24 do
  if core.ClassSeat[i].forceAction.Active then
    core.ClassSeat[i].forceAction.Action:= strtoint(TComboBox(sender).Items.Names[TComboBox(sender).ItemIndex])
  else core.ClassSeat[i].forceAction.Action:= -1;

  manageForceAction(IsAppControl);
  cHeadForceAction.Visible:= false;
end;

procedure TMainForm.cHeadForceActionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in [vk_return,vk_tab] then
    cHeadForceActionChange(Sender)
  else if (key=VK_ESCAPE) then
    cHeadForceAction.Visible:= false;
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  if (length(core.GameData.FreezeData)>0) and (messageDlg('All Freeze data will be cleared?',mtconfirmation,[mbyes,mbno],0)=mryes) then
  begin
    core.clearFreezeData;
    Button2.Click;
  end;
end;

procedure TMainForm.featureTabsChange(Sender: TObject);
begin
  case TJvPageControl(sender).TabIndex of
    0,2: lstCharActClick(lstCharAct);
    1: manageForceAction(IsAppControl);
  end;
end;

procedure TMainForm.gridFunModeItemDblClick(Sender: TObject;
  Item: TListItem; SubItemIndex, X, Y: Integer);
begin
  if not(core.getCharID(Item.ImageIndex)=-1) then
  begin
    manageForceAction(isAdd,Item.ImageIndex);
    //else manageForceAction(IsCancel,gridItem.ImageIndex);

    //senderData.seatNumber:= gridItem.ImageIndex;
    //manageForceAction(IsNavControl,senderData.seatNumber);
  end;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  folderDlg.Directory:= appDir;
  If folderDlg.Execute then
  begin
    eReiPath.Text:= folderDlg.Directory;
    core.XMLData.TextObj.Items['reiPath']:= eReiPath.Text;
    setComponent;
    manageClass(true,true);
  end;
end;

procedure TMainForm.closeDataClick(Sender: TObject);
begin
  if core.PlanActionCreated AND (messageDlg('All class data will be cleared!, save class data?',mtconfirmation,[mbyes,mbno],0)=mrYes) then
    managePlanAction(IsSave,false);

  case messageDlg('Reopen class data?',mtconfirmation,[mbyes,mbno,mbcancel],0) of
    mrYes: begin
      initClass:= true;
      manageClass(false);
      sleep(200);
      initClass:= true;
      manageClass(true);
    end;
    mrNo: begin
      initClass:= true;
      manageClass(false);
      sleep(200);
      core.GameData.regenerateAddress;
    end;
  end;
end;

procedure TMainForm.Exit2Click(Sender: TObject);
begin
  if (messageDlg('Exit trainer?',mtconfirmation,[mbyes,mbno],0)=mrYes) then
    MainForm.Close;
  //Application.Terminate;
end;

procedure TMainForm.ShowSeatOnly1Click(Sender: TObject);
begin
  TMenuItem(sender).Checked:= not TMenuItem(sender).Checked;
  seatMode(TMenuItem(sender).Checked); 
end;

procedure TMainForm.AddtoFunMode1Click(Sender: TObject);
begin
  manageForceAction(isAdd,senderData.seatNumber);
end;

procedure TMainForm.CancelCurrentAction1Click(Sender: TObject);
begin
  if not(senderData.seatNumber=-1) then
  begin
    core.ClassSeat[senderData.seatNumber].actions.cancelType:= '[MCA]';
    managePlanAction(IsCancel,false,senderData.seatNumber);
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  pRandomAction.Visible:= true;
end;

procedure TMainForm.Button9Click(Sender: TObject);
begin
  pRandomAction.Visible:= false;
end;

procedure TMainForm.Button6Click(Sender: TObject);
begin
  if (randomActionVal.Items.IndexOfName(randomActionSel.Items.Names[randomActionSel.Itemindex])=-1) then
    randomActionVal.Items.Add(randomActionSel.Items.Strings[randomActionSel.Itemindex]);
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
  if not(randomActionVal.ItemIndex=-1) then
    randomActionVal.DeleteSelected;
end;

procedure TMainForm.Button8Click(Sender: TObject);
begin
  randomActionVal.Clear;
end;

procedure TMainForm.pChangeClubButtonClick(Sender: TObject;
  Button: TJvCapBtnStyle);
begin
  if (Button=capClose) then Button7.Click;
end;

procedure TMainForm.cdefOLoveDblClick(Sender: TObject);
var i: integer;
begin
  if messagedlg('Restore All Color to Default?',mtconfirmation,[mbyes,mbno],0)=mryes then
    for i:= 0 to ComponentCount-1 do
    if (Components[i] is TPanel) AND (TPanel(Components[i]).Tag=4131) then
      TPanel(Components[i]).Color:= seatColor.defColor[TPanel(Components[i]).TabOrder];
end;

procedure TMainForm.setMoodsChange(Sender: TObject);
var i: integer;
begin
  if (core.selectedChar=-1) then exit;

  isReadData:= false;
  for i:= 10 to 22 do
    if not(i=19) then core.GameData.setRegenValue(1,core.selectedChar,'Mood'+inttostr(i),FloatToStr(TJvSpinEdit(sender).Value),-1,0);

  sleep(100);
  isReadData:= true;

  parseTabCode;
end;

procedure TMainForm.gridRelationshipMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  ACol, ARow: integer;
begin
  // prevent checkbox checked if scroll in col 1
  TJvStringGrid(sender).MouseToCell(MousePos.X,MousePos.Y,ACol,ARow);
  if (ACol=1) then Handled:= false
  else Handled:= true;
end;

procedure TMainForm.lstBinClick(Sender: TObject);
var i,sel: integer;
begin
  sel:= TJvImageListBox(sender).ItemIndex;
  if (sel=-1) OR (sel>=length(core.PasteBin.Selected)) then exit;

  for i:= 0 to length(core.PasteBin.ListData)-1 do
    core.PasteBin.Selected[i]:= false;

  core.PasteBin.Selected[sel]:= true;
  core.PasteBin.lastSelected:= sel;

  isBinView:= true;
  parseBinCode;
end;

procedure TMainForm.pasteBinRefresh;
var i: integer; listItem: TJvImageItem; BMP: TBitmap;
begin
  lstBin.items.Clear;
  if (core.PasteBin.No>0) then
  begin
    for i:= 0 to core.PasteBin.No-1 do
    begin
      listItem:= lstBin.Items.Add;
      listItem.Text:= core.pasteBin.ListData[i].Description;

      if (core.pasteBin.ListData[i].Thumbnail=nil) then continue;
      
      BMP:= TBitmap.Create;
      try
        GraphicToBitmap(core.pasteBin.ListData[i].Thumbnail, BMP);
        listItem.Glyph.Assign(BMP);
      finally
        BMP.Free;
      end;
    end;
    lstBin.ItemIndex:= core.PasteBin.lastSelected;
  end;
end;

procedure TMainForm.CopyCharacterData1Click(Sender: TObject);
var i: integer;
begin
  case TMenuItem(sender).MenuIndex of
    0: if not(core.selectedChar=-1) then
      core.copyBinData(core.selectedChar);
    1: begin
      pPasteBin.Left:= 0;
      pPasteBin.Top:= 0;
      pPasteBin.Visible:= true;
    end;
    3: if length(core.PasteBin.ListData)>0 then
    begin
      saveDlg.InitialDir:= appDir+'save';
      saveDlg.FileName:= SaveName.Text +'.pbin';
      saveDlg.Filter:= 'AA2 Bin Data|*.pbin';
      saveDlg.DefaultExt:= '.pbin';
      if saveDlg.Execute then core.manageSavedData(FilePasteBin,saveDlg.FileName);
    end;
    4: begin
      openDlg.InitialDir:= appDir+'save';
      openDlg.Filter:= 'AA2 Bin Data|*.pbin';
      openDlg.DefaultExt:= '.pbin';
      if openDlg.Execute then core.manageSavedData(FilePasteBin,openDlg.FileName,false);
    end;
    6: for i:= 0 to 24 do
       if not(core.getSeatID(i)=-1) then core.copyBinData(i);
    8: if not(core.selectedChar=-1) then
    begin
      if not(DirectoryExists(appDir+'\card')) then
        CreateDir(appDir+'\card');
      saveDlg.InitialDir:= appDir+'card';
      saveDlg.FileName:= SaveName.Text +'.png';
      saveDlg.Filter:= 'Portable Network Graphic|*.png';
      saveDlg.DefaultExt:= '.png';
      if saveDlg.Execute then
        core.getThumbnail(core.selectedChar,true,saveDlg.FileName);
    end;
  end;

  pasteBinRefresh;
end;

procedure TMainForm.Button10Click(Sender: TObject);
begin
  if (core.selectedChar=-1) OR (lstBin.ItemIndex=-1) OR (not(cpbinbase.Checked) AND not(cpbinoutfit.Checked) AND not(cpbinbody.Checked)) then exit;
  {if not(gameStateID=11) then
  begin
    showmessage('Must in Home Screen');
    exit;
  end; }
  if (MessageDlg('Are you sure want to overide this character?',mtconfirmation,[mbyes,mbno],0) = mrno) then exit;

  isReadData:= false;

  if (MessageDlg('Do you want make copy before overide this character?',mtconfirmation,[mbyes,mbno],0) = mryes) then
    core.copyBinData(core.selectedChar);

  sleep(100);
  core.pasteBinData(core.selectedChar,cpbinbody.Checked,cpbinoutfit.Checked,cpbinbase.Checked);

  sleep(100);
  refreshCharacterSeat;
  sleep(100);
  isReadData:= true;
  parseTabCode;
end;

procedure TMainForm.Button11Click(Sender: TObject);
begin
  if (lstBin.ItemIndex=-1) OR (MessageDlg('Are you sure want to delete this character bin data?',mtconfirmation,[mbyes,mbno],0) = mrno) then exit;
  core.removeBinData;
  lstBin.Items.Delete(lstBin.ItemIndex);
  sleep(150);
  pasteBinRefresh;
end;

procedure TMainForm.Button12Click(Sender: TObject);
begin
  pPasteBin.Visible:= false;
end;

procedure TMainForm.Button13Click(Sender: TObject);
var
  PNG: TPNGObject;
begin
  if not(core.selectedSeat=-1) then
  begin
    core.getThumbnail(core.selectedChar,true);

    if not(DirectoryExists(appDir+'cards')) then
      createDir(appDir+'cards');

    saveDlg.InitialDir:= appDir+'cards';
    saveDlg.FileName:= core.ClassSeat[core.selectedSeat].listName+'.png';
    saveDlg.Filter:= 'Portable Network Graphic|*.png';
    saveDlg.DefaultExt:= '*.png';
    if saveDlg.Execute then
    begin
      PNG := TPNGObject.Create;
      try
        GraphicToPNG(core.ClassSeat[core.selectedSeat].views.potrait,PNG);
        PNG.SaveToFile(saveDlg.InitialDir+'\'+saveDlg.FileName);
      finally
        PNG.Free;
      end;
    end;
  end;
end;

procedure TMainForm.gameData1Change(Sender: TObject);
var
  lstStr: TStrings;
  codeType: string;
  i,ii,codeID,codeReg,charID,nrow: integer;
begin
  if (TComboBox(sender).ItemIndex<=0) then exit;
  case TComponent(sender).Tag of
    151: begin
      codeType:= TComboBox(sender).Items.ValueFromIndex[TComboBox(sender).ItemIndex];
      codeID:= strtoint(TComboBox(sender).Items.Names[TComboBox(sender).ItemIndex]);
      gGameData1.Clear;
      gGameData1.ColCount:= 3;
      gGameData1.FixedCols:= 1;
      gGameData1.RowCount:= 2;
      gGameData1.FixedRows:= 1;
      gGameData1.ColWidths[0]:= 160;
      gGameData1.Cols[0].Strings[0]:= 'Code Name';
      gGameData1.ColWidths[1]:= 200;
      gGameData1.Cols[1].Strings[0]:= 'Offset';
      gGameData1.ColWidths[2]:= 160;
      gGameData1.Cols[2].Strings[0]:= 'Value';

      lstStr:= TStringList.Create;
      try
        lstStr.AddStrings(core.GameData.CharCode.Strings[codeType]);
        if lstStr.Count>0 then
        begin
          gGameData1.RowCount:= lstStr.Count+1;
          for i:= 0 to lstStr.Count-1 do
          begin
            gGameData1.Rows[i+1].Strings[0]:= lstStr.Names[i];
            gGameData1.Rows[i+1].Strings[1]:= lstStr.ValueFromIndex[i];
            gGameData1.Rows[i+1].Strings[2]:= core.GameData.getCodes(codeID,lstStr.Names[i],-1,true);
          end;
        end;
      finally
        lstStr.Free;
      end;
    end;
    152,153: begin
      if (gameData2.ItemIndex<=0) OR (gameDataSeat.ItemIndex<=0) then exit;
      charID:= core.getCharID(seatIndex[gameDataSeat.ItemIndex-1]);
      if (charID=-1) then exit;
      codeType:= gameData2.Items.ValueFromIndex[gameData2.ItemIndex];
      codeID:= strtoint(gameData2.Items.Names[gameData2.ItemIndex]);
      codeReg:= ArrayIndexContainText(codeType,core.GameData.RegenCode[charID].KeyName,true);
      gGameData2.Clear;
      gGameData2.ColCount:= 2;
      gGameData2.FixedCols:= 1;
      gGameData2.RowCount:= 2;
      gGameData2.FixedRows:= 1;

      case codeID of
        1,2: begin
          gGameData2.ColCount:= 3;
          gGameData2.FixedCols:= 1;
          gGameData2.ColWidths[0]:= 120;
          gGameData2.Cols[0].Strings[0]:= 'Code Name';
          gGameData2.ColWidths[1]:= 200;
          gGameData2.Cols[1].Strings[0]:= 'Offset';
          gGameData2.ColWidths[2]:= 140;
          gGameData2.Cols[2].Strings[0]:= 'Value';
          gGameData2.RowCount:= length(core.GameData.RegenCode[charID].DataCode[codeReg].NameCode)+1;
          for i:= 0 to length(core.GameData.RegenCode[charID].DataCode[codeReg].NameCode)-1 do
          begin
            gGameData2.Rows[i+1].Strings[0]:= core.GameData.RegenCode[charID].DataCode[codeReg].NameCode[i];
            gGameData2.Rows[i+1].Strings[1]:= core.GameData.getRegenCode(codeID,charID,i,-1,codeReg);
            gGameData2.Rows[i+1].Strings[2]:= core.GameData.getRegenValue(codeID,charID,i,false,-1,codeReg);
          end;
        end;
        else
        begin
          gGameData2.ColCount:= 4;
          gGameData2.FixedCols:= 1;
          gGameData2.ColWidths[0]:= 120;
          gGameData2.Cols[0].Strings[0]:= 'Code Name';
          gGameData2.ColWidths[1]:= 200;
          gGameData2.Cols[1].Strings[0]:= 'Offset';
          gGameData2.ColWidths[2]:= 30;
          gGameData2.Cols[2].Strings[0]:= 'ID2';
          gGameData2.ColWidths[3]:= 140;
          gGameData2.Cols[3].Strings[0]:= 'Value';
          nrow:= 0;
          gGameData2.RowCount:= (length(core.GameData.RegenCode[charID].DataCode[codeReg].NameCode)*24)+1;
          for i:= 0 to 23 do
          for ii:= 0 to length(core.GameData.RegenCode[charID].DataCode[codeReg].NameCode)-1 do
          begin
            gGameData2.Rows[nrow+1].Strings[0]:= core.GameData.RegenCode[charID].DataCode[codeReg].NameCode[ii];
            gGameData2.Rows[nrow+1].Strings[1]:= core.GameData.getRegenCode(codeID,charID,ii,i,codeReg);
            gGameData2.Rows[nrow+1].Strings[2]:= inttostr(i);
            gGameData2.Rows[nrow+1].Strings[3]:= core.GameData.getRegenValue(codeID,charID,ii,false,i,codeReg);
            inc(nrow);
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.pConsoleButtonClick(Sender: TObject;
  Button: TJvCapBtnStyle);
begin
  if Button=capClose then
    pConsole.Visible:= false;
end;

procedure TMainForm.routineEvents5Timer(Sender: TObject);
var i,tot: integer;
begin
  // for led indicator
  if core.initGameFired then
    if pConsole.Visible then
    begin
      ledCheckGame.Status:= checkGame.Enabled;
      ledGame.Status:= gameRunning;
      ledClassOpen.Status:= classExist;
      ledClassCreate.Status:= classReady;
      ledRedrawSeat.Status:= respawnSeat;
      ledPauseTimer.Status:= pauseNPCTimer;
      ledRead.Status:= isReadData;
      ledWrite.Status:= isWriteData;
      ledRefData.Status:= routine.Events.Items[0].Enabled;
      ledFreeze.Status:= routine.Events.Items[1].Enabled;
      LedGameT.Status:= routine.Events.Items[2].Enabled;
      ledDelay.Status:= routine.Events.Items[3].Enabled;
      ledLowest.Status:= routine.Events.Items[4].Enabled;

      if (counter mod 20=0) then
      begin
        lblMaxChar.Caption:= inttostr(core.maxChar);
        tot:= 0;
        if classReady then
        begin
          for i:= 0 to 24 do
          if not(core.ClassSeat[i].actions.syncEvent=nil) AND core.ClassSeat[i].actions.syncEvent.Enabled then
            inc(tot);
          actTimerActive.Caption:= inttostr(tot)+' is active';
        end;
      end;
    end;
end;

procedure TMainForm.CopyOutfit1Click(Sender: TObject);
begin
  manageOutfits(isCopy);
end;

procedure TMainForm.PasteOutfit1Click(Sender: TObject);
begin
  manageOutfits(isPaste);
  sleep(200);
  isReadData:= true;
  parseTabCode;
end;

end.
