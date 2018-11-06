object frm_Main: Tfrm_Main
  Left = 0
  Top = 0
  Caption = 'frm_Main'
  ClientHeight = 519
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TrayIcon: TTrayIcon
    PopupMenu = popTray
    OnDblClick = TrayIconDblClick
    Left = 312
    Top = 156
  end
  object popTray: TPopupMenu
    Left = 240
    Top = 264
    object mi_Restore: TMenuItem
      Caption = 'Configure'
      OnClick = mi_RestoreClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mi_Exit: TMenuItem
      Caption = 'Exit'
      OnClick = mi_ExitClick
    end
  end
end
