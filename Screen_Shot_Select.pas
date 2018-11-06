unit Screen_Shot_Select;

interface

uses
  Winapi.messages,
  Screen_View,
  Winapi.Windows,
  System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
  Clipbrd;

type
  Tfrm_Screen_Shot_Select = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    //L_Mouse_Down: Boolean;
    //L_Old_X, L_Old_Y: Integer;
    L_Screen_View: Tfrm_Screen_View;

    L_BitMap: TBitmap;
    procedure Save_Image;
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override; // ADD THIS LINE!
  public
    procedure Select(AScreen_View: Tfrm_Screen_View);
    { Public declarations }
  end;

var
  frm_Screen_Shot_Select: Tfrm_Screen_Shot_Select;

implementation

{$R *.dfm}

procedure Tfrm_Screen_Shot_Select.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_BORDER or WS_THICKFRAME;
  //Params.Style := Params.Style or WS_BORDER or WS_SYSMENU;
  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST;
  //Params.WndParent := 0;
end;

procedure CropBitmap(InBitmap, OutBitMap : TBitmap; X, Y, W, H :Integer);
begin
  OutBitMap.PixelFormat := InBitmap.PixelFormat;
  OutBitMap.Width  := W;
  OutBitMap.Height := H;
  BitBlt(OutBitMap.Canvas.Handle, 0, 0, W, H, InBitmap.Canvas.Handle, X, Y, SRCCOPY);
end;

function DateStrFormatted: string;
var
  L_Result: string;
begin
   DateTimeToString(L_Result, 'yyyymmddhhnnss', Now);
   Result := L_Result;
end;

procedure Tfrm_Screen_Shot_Select.Save_Image;
Var
  Bmp : TBitmap;
begin
   Bmp:=TBitmap.Create;
   try
      CropBitmap(L_BitMap, Bmp,  Left, Top, Width, Height);
      //do something with the cropped image
      //Bmp.SaveToFile('Foo.bmp');
      Clipboard.Assign(Bmp);
      Bmp.SaveToFile(DateStrFormatted + '.bmp');
   finally
      Bmp.Free;
   end;
end;

procedure Tfrm_Screen_Shot_Select.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
   begin
      Save_Image;
      Close;
   end
   else if Key = VK_ESCAPE then
   begin
      Close;
   end
   else
   begin
      Key := 0;
   end;
end;

procedure Tfrm_Screen_Shot_Select.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//   Cursor := crSizeAll;
//   L_Mouse_Down := True;
end;

procedure Tfrm_Screen_Shot_Select.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//   if L_Mouse_Down then
//   begin
//      Top := Top + (Y - L_Old_Y);
//      Left := Left + (X - L_Old_X);
//   end;
//   L_Old_Y := Y;
//   L_Old_X := X;
end;

procedure Tfrm_Screen_Shot_Select.FormMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//   Cursor := crDefault;
//   L_Mouse_Down := False;
end;

procedure Tfrm_Screen_Shot_Select.Select(AScreen_View: Tfrm_Screen_View);
begin
   Self := Tfrm_Screen_Shot_Select.Create(nil);
   L_Screen_View := AScreen_View;

//   Left := Mouse.CursorPos.X;
//   Top := Mouse.CursorPos.Y;

   //L_BitMap := TBitmap.Create;
   L_BitMap := AScreen_View.imgScreenShot.Picture.Bitmap;
//   Top := 0;
//   Left := 0;
//   Height := Screen.Height;
//   Width := Screen.Width;
   ShowModal;
end;

procedure Tfrm_Screen_Shot_Select.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   if Assigned(L_Screen_View) then
   begin
      L_Screen_View.Close;
   end;
   Action := caFree;
end;

procedure Tfrm_Screen_Shot_Select.FormCreate(Sender: TObject);
begin
//   L_Mouse_Down := False;
//   L_Old_X := Mouse.CursorPos.X;
//   L_Old_Y := Mouse.CursorPos.Y;
end;

end.
