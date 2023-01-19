program SCM_LeaderBoard;

uses
  Vcl.Forms,
  frmLeaderBoard in 'frmLeaderBoard.pas' {LeaderBoard},
  exeinfo in 'exeinfo.pas',
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  dlgSplash in 'dlgSplash.pas' {Splash},
  dlgBasicLogin in 'dlgBasicLogin.pas' {BasicLogin},
  dlgAbout in 'dlgAbout.pas' {About},
  dlgOptions in 'dlgOptions.pas' {Options},
  Utility in 'Utility.pas',
  dmReports in 'dmReports.pas' {RPTS: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_LeaderBoard';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TLeaderBoard, LeaderBoard);
  Application.Run;
end.
