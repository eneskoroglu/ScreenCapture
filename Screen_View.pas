unit Screen_View;

interface

uses
  Winapi.Windows, Vcl.Graphics,
  Vcl.Forms, Vcl.ExtCtrls, System.Classes, Vcl.Controls;

type
  Tfrm_Screen_View = class(TForm)
    imgScreenShot: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
      Image_Showed: Boolean;
      procedure Get_Screen_Shot;
    { Public declarations }
  end;

var
  frm_Screen_View: Tfrm_Screen_View;

implementation

{$R *.dfm}

uses Screen_Shot_Select;

{ Tfrm_Screen_View }

function WindowSnap(windowHandle: HWND; bmp: TBitmap): boolean;
var
  r: TRect;
  user32DLLHandle: THandle;
  printWindowAPI: function(sourceHandle: HWND; destinationHandle: HDC;
    nFlags: UINT): BOOL; stdcall;
begin
  result := False;
  user32DLLHandle := GetModuleHandle(user32) ;
  if user32DLLHandle <> 0 then
  begin
    @printWindowAPI := GetProcAddress(user32DLLHandle, 'PrintWindow') ;
    if @printWindowAPI <> nil then
    begin
      GetWindowRect(windowHandle, r) ;
      bmp.Width := Screen.Width;// r.Right - r.Left;
      bmp.Height := Screen.Height;// r.Bottom - r.Top;
      bmp.Canvas.Lock;
      try
        result := printWindowAPI(windowHandle, bmp.Canvas.Handle, 0) ;
      finally
        bmp.Canvas.Unlock;
      end;
    end;
  end;
end; (*WindowSnap*)

procedure ScreenShot(Bild: TBitMap);
var
  c: TCanvas;
  r: TRect;
begin
  c := TCanvas.Create;
  c.Handle := GetWindowDC(GetDesktopWindow);
  try
    r := Rect(0, 0, Screen.Width, Screen.Height);
    Bild.Width := Screen.Width;
    Bild.Height := Screen.Height;
    Bild.Canvas.CopyRect(r, c, r);
  finally
    ReleaseDC(0, c.Handle);
    c.Free;
  end;
end;

procedure Tfrm_Screen_View.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure Tfrm_Screen_View.Get_Screen_Shot;
begin
   Self := Tfrm_Screen_View.Create(nil);

   ScreenShot(imgScreenShot.Picture.BitMap);

   Show;
   Application.Restore;
   Application.BringToFront;

   frm_Screen_Shot_Select.Select(Self);
end;

end.
