program cubebox_menu;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main, about;

{$R *.res}

begin
  Application.Title := 'Cubebox';
  Application.Initialize;
  Application.CreateForm( TForm1, Form1) ;
  Application.CreateForm(TaboutForm, aboutForm);
  Application.Run;
end.

