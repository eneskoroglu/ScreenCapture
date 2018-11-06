unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  Vcl.Forms,
  Vcl.ExtCtrls, Vcl.Menus, System.Classes;

type
  Tfrm_Main = class(TForm)
    TrayIcon: TTrayIcon;
    popTray: TPopupMenu;
    mi_Restore: TMenuItem;
    mi_Exit: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure mi_ExitClick(Sender: TObject);
    procedure mi_RestoreClick(Sender: TObject);
  private
    { Private declarations }
      HotKey1: Integer;
      procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
      procedure ApplicationEvents1Minimize(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frm_Main: Tfrm_Main;

implementation

{$R *.dfm}

uses Screen_View;

procedure Tfrm_Main.mi_RestoreClick(Sender: TObject);
begin
   TrayIcon.Visible := False;
   Show();
   WindowState := wsNormal;
end;

procedure Tfrm_Main.mi_ExitClick(Sender: TObject);
begin
   Close;
end;

procedure Tfrm_Main.FormCreate(Sender: TObject);
begin
   Application.OnMinimize := ApplicationEvents1Minimize;

   HotKey1 := GlobalAddAtom('NskPrintScreenHotkey1');
   RegisterHotKey(Handle, HotKey1, MOD_CONTROL, VK_SNAPSHOT);
   WindowState := wsMinimized;
end;

procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
   UnRegisterHotKey(Handle, HotKey1);
   GlobalDeleteAtom(HotKey1);
end;

procedure Tfrm_Main.TrayIconDblClick(Sender: TObject);
begin
   mi_Restore.Click;
end;

procedure Tfrm_Main.WMHotKey(var Msg: TWMHotKey);
begin
   if Msg.HotKey = HotKey1 then
   begin
      frm_Screen_View.Get_Screen_Shot;
      //TFile.WriteAllText('mytest.txt', 'Test mesajý', TEncoding.Unicode);
      //ShowMessage('Start to PrintScreen');
   end;
end;

procedure Tfrm_Main.ApplicationEvents1Minimize(Sender: TObject);
begin
  { Hide the window and set its state variable to wsMinimized. }
  Hide();
  WindowState := wsMinimized;

  { Show the animated tray icon and also a hint balloon. }
  TrayIcon.Visible := True;
  //TrayIcon1.Animate := True;
  TrayIcon.ShowBalloonHint;
end;

end.
