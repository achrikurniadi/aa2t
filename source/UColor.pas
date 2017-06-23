unit UColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvFullColorDialogs, StdCtrls, JvExControls, JvSpeedButton, JvJCLUtils,
  JvFullColorSpaces, JvFullColorCtrls, JvFullColorForm,
  ExtCtrls;

type
  TcolorBin = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    procedure btnDefColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDefColorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    btnColor: array [0..11] of TJvSpeedButton;

    function convertColor(coltype: integer; color: TColor): TJvFullColor;
  end;

var
  colorBin: TcolorBin;

implementation

uses UMain, UMemoryHelper;

{$R *.dfm}
function TcolorBin.convertColor(coltype: integer; color: TColor): TJvFullColor;
begin
  with ColorSpaceManager do
  case coltype of
    0: Result:= ColorSpace[csRGB].ConvertFromColor(color);
    1: Result:= ColorSpace[csHLS].ConvertFromColor(color);
    2: Result:= ColorSpace[csCMY].ConvertFromColor(color);
    3: Result:= ColorSpace[csYUV].ConvertFromColor(color);
    4: Result:= ColorSpace[csHSV].ConvertFromColor(color);
    5: Result:= ColorSpace[csYIQ].ConvertFromColor(color);
    6: Result:= ColorSpace[csYCC].ConvertFromColor(color);
    7: Result:= ColorSpace[csXYZ].ConvertFromColor(color);
    8: Result:= ColorSpace[csLAB].ConvertFromColor(color);
    9: Result:= ColorSpace[csDEF].ConvertFromColor(color);
  end;
end;

procedure TcolorBin.btnDefColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (button=mbRight) then
  begin
    MainForm.colorDlg.FullColor:= convertColor(0,TJvSpeedButton(sender).Color);
    if MainForm.colorDlg.Execute then
      TJvSpeedButton(sender).Color:= MainForm.colorDlg.FullColor;
  end;
end;

procedure TcolorBin.btnDefColorClick(Sender: TObject);
begin
  MainForm.clipboardColor.setColor:= true;
  MainForm.clipboardColor.tempColor:= (sender as TJvSpeedButton).color;
  colorBin.Close;
end;

procedure TcolorBin.FormShow(Sender: TObject);
var i, ptop, pleft: integer;
begin
  for i:= 0 to 11 do
  begin
    if (btnColor[i]=nil) then
    begin
      if (i=0) then
      begin
        ptop:= 8;
        pLeft:= 8;
      end else
      if (i mod 3=0) then
      begin
        pleft:= 8;
        ptop:= ptop + 49 + 7;
      end else
        pleft:= pleft + 97 + 7;

      btnColor[i]:= TJvSpeedButton.Create(panel1);
      btnColor[i].Parent:= Panel1;
      btnColor[i].OnClick:= btnDefColorClick;
      btnColor[i].OnMouseDown:= btnDefColorMouseDown;
      btnColor[i].Top:= ptop;
      btnColor[i].Left:= pleft;
      btnColor[i].Width:= 97;
      btnColor[i].Height:= 49;
      btnColor[i].Visible:= true;
    end;

    btnColor[i].Caption:= MainForm.clipboardColor.name[i];
    btnColor[i].Color  := MainForm.clipboardColor.color[i];
  end;
end;

procedure TcolorBin.Button1Click(Sender: TObject);
begin
  colorBin.Close;
end;

end.
