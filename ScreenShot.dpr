program ScreenShot;

uses
   Vcl.ExtCtrls,
  Vcl.Forms,
  Main in 'Main.pas' {frm_Main},
  Screen_View in 'Screen_View.pas' {frm_Screen_View},
  Screen_Shot_Select in 'Screen_Shot_Select.pas' {frm_Screen_Shot_Select};

{$R *.res}

begin
   ReportMemoryLeaksOnShutdown := True;
   Application.Initialize;
   Application.MainFormOnTaskbar := True;
   Application.CreateForm(Tfrm_Main, frm_Main);
   //Application.CreateForm(Tfrm_Screen_View, frm_Screen_View);
   //Application.CreateForm(Tfrm_Screen_Shot_Select, frm_Screen_Shot_Select);
   Application.Run;
end.
