unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TextMemo, StdCtrls, jpeg, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    memo1: TTranslateMemo;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1 := TTranslateMemo.create(self);


  Memo1.Visible := true;
  memo1.Text := '拖动时闪烁怎么解决？';
  memo1.SetBounds(20,20,300,260);

end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  memo1.Visible := not memo1.Visible;
  if memo1.Visible then
  begin
    Memo1.Clear;
    Memo1.SetFocus;
    Memo1.Left := x;
    Memo1.Top := y;

  end else
  begin

  end;
end;

procedure TForm1.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
 // inherited;
  message.Result := 1;
end;

end.

