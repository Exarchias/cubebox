unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, ShellApi;

type

  { TForm1 }

  TForm1 = class( TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click( Sender: TObject) ;
    procedure Button2Click( Sender: TObject) ;
    procedure Button3Click( Sender: TObject) ;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  config: TStringlist;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click( Sender: TObject) ;
begin
  close();
end;

procedure TForm1.Button2Click( Sender: TObject) ;
begin
try

config := TStringlist.Create();
config.Add('username'+ #9 + #9 + Edit1.Text);
config.Add('password' + #9 + #9 + Edit2.Text);
config.Add('server_ip' + #9 + #9 + Edit3.Text);
config.Add('server_port' + #9 + #9 + Edit4.Text);
config.SaveToFile('res/client.conf');

except
    showmessage('Could not save configurations!');
end;

try

ShellExecute(handle, 'open', PChar('cubebox.exe'), '', '', 1);
Sleep(100);
close();


except
    showmessage('Could not start cubebox!');
end;
end;

procedure TForm1.Button3Click( Sender: TObject) ;
begin
     ShellExecute(handle, 'open', PChar('updater.exe'), '', '', 1);
     Sleep(100);
     close();
end;

end.

