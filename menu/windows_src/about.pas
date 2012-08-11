unit about;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TaboutForm }

  TaboutForm = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  aboutForm: TaboutForm;
  version_file: TStringlist;

implementation

{$R *.lfm}

{ TaboutForm }

{ TaboutForm }

procedure TaboutForm.FormCreate(Sender: TObject);
begin
   try
       version_file := TStringlist.Create();
       version_file.LoadFromFile('version');
       Label4.Caption := version_file.Strings[0];
       version_file.Destroy();
   except
     Label4.Caption := '';
   end;
end;

end.

