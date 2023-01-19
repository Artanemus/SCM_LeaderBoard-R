unit dlgSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSplash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    lblProgress: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Splash: TSplash;

implementation

{$R *.dfm}

end.
