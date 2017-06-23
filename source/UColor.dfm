object colorBin: TcolorBin
  Left = 192
  Top = 117
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Clipboard Color'
  ClientHeight = 266
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 323
    Height = 266
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 240
      Width = 108
      Height = 13
      Caption = 'Right click to edit color'
    end
    object Button1: TButton
      Left = 240
      Top = 232
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
