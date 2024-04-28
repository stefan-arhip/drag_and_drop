unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    lbDestination: TListBox;
    lvSource: TListView;
    procedure lbDestinationDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbDestinationDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lvSourceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.lbDestinationDragDrop(Sender, Source: TObject; X, Y: Integer);
Var i, DropPosition: Integer;
    DropPoint: TPoint;
    List: String;
Begin
  DropPoint:= Point(X, Y);

  List:= '';
  For i:= 1 To lvSource.Items.Count Do
    If lvSource.Items[i- 1].Selected Then
      If Length(List)= 0 Then
        List:= lvSource.Items[i- 1].SubItems[0]
      Else
        List:= List+ ','+ lvSource.Items[i- 1].SubItems[0];
  DropPosition := lbDestination.ItemAtPos(DropPoint, True);
  If DropPosition= -1 Then
    MessageDlg('Nici un item selectat!', mtWarning, [mbOk], 0);

  Label1.Caption:= Format('S-au mutat persoanele %s in %s', [List, lbDestination.Items[DropPosition]]);
end;

procedure TForm1.lbDestinationDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TForm1.lvSourceMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button= mbLeft Then
    lvSource.BeginDrag(True);
end;

end.

