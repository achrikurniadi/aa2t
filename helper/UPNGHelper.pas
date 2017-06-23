unit UPNGHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Dialogs, Graphics,
  ComCtrls, StdCtrls, ExtCtrls, JvJCLUtils, JvImage,
  HelperGeneral, pngimage;

procedure GraphicToPNG(source: TJvImage; var target: TPNGObject);
procedure GraphicToBitmap(source: TJvImage; var target: TBitmap); 

implementation

procedure GraphicToPNG(source: TJvImage; var target: TPNGObject);
var
  BMP: TBitmap;
begin
  target:= TPNGObject.Create;
  try
    if source.Picture.Graphic is TBitmap then
      target.Assign(TBitmap(source.Picture.Graphic))    //Convert bitmap data into png
    else begin
      //Otherwise try to assign first to a TBimap
      BMP := TBitmap.Create;
      try
        BMP.Assign(source.Picture.Graphic);
        target.Assign(BMP);
      finally
        BMP.Free;
      end;
    end;
  finally
  
  end;
end;

procedure GraphicToBitmap(source: TJvImage; var target: TBitmap);
var
  Png: TPNGObject;
  BMP, Bitm: TBitmap;
begin
  Png := TPNGObject.Create;
  Bitm:= TBitmap.Create;
  target:= TBitmap.Create;
  try
    if source.Picture.Graphic is TBitmap then
      PNG.Assign(TBitmap(source.Picture.Graphic))    //Convert bitmap data into png
    else begin
      //Otherwise try to assign first to a TBimap
      BMP := TBitmap.Create;
      try
        BMP.Assign(source.Picture.Graphic);
        PNG.Assign(BMP);
      finally
        BMP.Free;
      end;
    end;

    Bitm.Assign(PNG);
    target.Assign(Bitm);
  finally
    Png.Free;
    Bitm.Free;
  end;
end;

end.
