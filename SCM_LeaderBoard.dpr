program SCM_LeaderBoard;

uses
  Vcl.Forms,
  frmLeaderBoard in 'frmLeaderBoard.pas' {LeaderBoard},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  dlgSplash in 'dlgSplash.pas' {Splash},
  dlgOptions in 'dlgOptions.pas' {Options},
  dmReports in 'dmReports.pas' {RPTS: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  exeinfo in '..\SCM_SHARED\exeinfo.pas',
  SCMUtility in '..\SCM_SHARED\SCMUtility.pas',
  dlgAbout in '..\SCM_SHARED\dlgAbout.pas' {About},
  dlgBasicLogin in '..\SCM_SHARED\dlgBasicLogin.pas' {BasicLogin},
  SCMSimpleConnect in '..\SCM_SHARED\SCMSimpleConnect.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_LeaderBoard';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TLeaderBoard, LeaderBoard);
  Application.Run;
end.
