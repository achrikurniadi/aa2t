program TAA2;

uses
  Forms,
  UMain in 'UMain.pas' {MainForm},
  UCore in 'UCore.pas',
  HelperGeneral in '..\helper\HelperGeneral.pas',
  UMemory in '..\helper\UMemory.pas',
  UMemoryHelper in '..\helper\UMemoryHelper.pas',
  UObjectArray in '..\helper\UObjectArray.pas',
  UVerInfoClass in '..\helper\UVerInfoClass.pas',
  UVerInfoRoutines in '..\helper\UVerInfoRoutines.pas',
  UVerInfoTypes in '..\helper\UVerInfoTypes.pas',
  UData in 'UData.pas',
  UXMLData in 'UXMLData.pas',
  UPNGHelper in '..\helper\UPNGHelper.pas',
  pngimage in '..\helper\png\PNGImage.pas',
  pnglang in '..\helper\png\pnglang.pas',
  zlibpas in '..\helper\png\zlibpas.pas',
  USelAction in 'USelAction.pas' {forceNPCAction},
  UColor in 'UColor.pas' {colorBin};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AA2 Trainer v2';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TforceNPCAction, forceNPCAction);
  Application.CreateForm(TcolorBin, colorBin);
  Application.Run;
end.
