unit TextMemo;

interface

uses
  Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls;


type
  TCtrl = class(TWinControl);
  TTranslateMemo = class(TCustomMemo)
  private
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CNCtlColorEdit(var Message: TWMCtlColorEdit); message CN_CTLCOLOREDIT;
    procedure WMMouseDown(var Message: TMessage); message WM_LBUTTONDOWN;
    procedure WMMouseUp(var Message: TMessage); message WM_LBUTTONUP;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

  protected

    procedure Change; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure prin(canvas: TCanvas);


  published
     { Published declarations }
  end;

implementation

constructor TTranslateMemo.Create(AOwner: TComponent);
begin
 // inherited Create(Aowner);
  inherited;
  Ctl3D := False;
  DoubleBuffered := true;
  ParentCtl3D := False;
  font.Color := clred;
  font.Size := 18;
  font.Name := 'ËÎÌו';
  BorderStyle := bsNone;
  self.Parent := twincontrol(AOwner);



  //SetWindowLong(Parent.Handle, GWL_STYLE,
  //  GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
end;

procedure TTranslateMemo.WMMouseDown(var Message: TMessage);
begin
  inherited;
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
 // Cursor := crSizeAll;
end;

procedure TTranslateMemo.WMMouseUp(var Message: TMessage);
begin
  inherited;
 // Cursor := crDefault;
end;


procedure TTranslateMemo.WMEraseBkGnd(var Message: TWMEraseBkGnd);
var
  SaveIndex: integer;
  TempCanvas: TCanvas;
  p: TPoint;
begin

  with Message do
  begin
    SaveIndex := SaveDC(DC);


    MoveWindowOrg(DC, -Left, -Top);
    SendMessage(Parent.Handle, WM_PAINT, DC, 0);



    RestoreDC(DC, SaveIndex);

    TempCanvas := TCanvas.Create;
    TempCanvas.Handle := DC;
    with TempCanvas do
    begin
      Brush.Style := bsClear;
      pen.Color := clwhite;
      pen.Style := psSolid;
      Rectangle(ClientRect);
      pen.Color := 0;
      pen.Style := psDashDot;
      Rectangle(ClientRect);
    end;
    TempCanvas.Handle := 0;
    TempCanvas.Free;

    Result := 1;
  end;
 //
end;


procedure TTranslateMemo.WMMove(var Message: TWMMove);
begin
  inherited;
  Invalidate;
end;

procedure TTranslateMemo.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

procedure TTranslateMemo.CNCtlColorEdit(var Message: TWMCtlColorEdit);
begin
  inherited;
  with Message do
  begin
    SetBkMode(ChildDC, TRANSPARENT);
    Result := GetStockObject(NULL_BRUSH)
  end;
end;

procedure TTranslateMemo.Change;
var
  w, I, j: integer;
begin
  inherited Change;
  Invalidate;

  TForm(Parent).Canvas.Font := self.Font;
  w := 40;
  for i := 0 to Lines.Count - 1 do
  begin
    j := TForm(Parent).canvas.TextWidth(self.Lines[I]) + 40;
    if j > w then w := j;
  end;
  Height := TForm(Parent).canvas.TextHeight('A') * SendMessage(Handle, EM_GETLINECOUNT, 0, 0);
  Width := w;
end;


procedure TTranslateMemo.prin(canvas: TCanvas);
var
  i, h: Integer;
begin
  canvas.Font := FOnt;
  h := canvas.TextHeight('A');
  for i := 0 to Lines.Count - 1 do
  begin
    canvas.TextOut(left, top + i * h, lines[i]);
  end;
end;








procedure TTranslateMemo.WMPaint(var Message: TWMPaint);
begin


  inherited;
   // message.Result:=1;
end;



end.

