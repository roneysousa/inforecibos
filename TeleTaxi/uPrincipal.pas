// Sistema : InfoRecibos
// Empresa : InfoG2 Sistemas
// Objetivo: gerar recibos
// PROGRAMADOR : Roney Erdemann
// Date : 14/03/2005
// hora: 10:45

unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ImgList, Buttons, ExtCtrls, 
  QuickRpt, QRCtrls, jpeg;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnuArquivo: TMenuItem;
    mnuNovoItem: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    ToolBar1: TToolBar;
    Info: TStatusBar;
    mnuReciboSubItem: TMenuItem;
    DespesasInternas1: TMenuItem;
    mnuReceitaSubItem: TMenuItem;
    Ajuda1: TMenuItem;
    mnuSobreItem: TMenuItem;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    BtnClientes: TSpeedButton;
    SpeedButton1: TSpeedButton;
    spUsoTaxi: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Image1: TImage;
    SpeedButton4: TSpeedButton;
    mnuUsodoTaxaItem: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mnuReciboSubItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DespesasInternas1Click(Sender: TObject);
    procedure mnuReceitaSubItemClick(Sender: TObject);
    procedure mnuSobreItemClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure spUsoTaxiClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DisplayHint(Sender: TObject);
    procedure ImprimirNaVertical(AQuick: TQuickRep; ABanda: TQrBand;
        ATexto: string);
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uRecibo, uSobre, uSplash, uRecibo2;

{$R *.dfm}

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
     If Application.MessageBox('Sair do Programa?',
         'ATEN��O', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = idYes then
          Application.Terminate;
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     CanClose := False;
     If Application.MessageBox('Sair do Programa?',
         'ATEN��O', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = idYes then
     begin
          CanClose := True;
          Application.Terminate;
     End;
end;

procedure TfrmPrincipal.mnuReciboSubItemClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmRecibo, frmRecibo);
      frmRecibo.Caption := 'Recibo';
      frmRecibo.ShowModal;
  Finally
      frmRecibo.Free;
  End;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
Var
   M_DTEXPI : Tdate;
begin
     //
     {M_DTEXPI := StrtoDate('22/09/2005');
     //
     If (Date() > M_DTEXPI) Then
     begin
           Application.MessageBox('A validade deste programa expirou!!!'+#13
                                 +'Entre em contato com a InfoG2:'+#13
                                 +'Telefone: (86)226-4510'+#13
                                 +'E_mail...: infog2@globo.com' ,
              'Aten��o',MB_DEFBUTTON2+MB_OK+MB_ICONINFORMATION);
           Application.Terminate;
     End;}
     //
     Application.Title := 'InfoRecibos 1.0';
     ShortDateFormat := 'dd/mm/yyyy';
     //
     Image1.Left := (FrmPrincipal.Width Div 2) - (Image1.Width Div 2);
     Image1.Top := (FrmPrincipal.Height Div 2) - (Image1.Height Div 2 + Info.Height);
     Info.Panels.Items[2].Text := 'InfoRecibos 1.0 � - InfoG2 Sistemas';
end;

procedure TfrmPrincipal.DespesasInternas1Click(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmRecibo, frmRecibo);
      frmRecibo.Caption := 'Despesas Internas';
      frmRecibo.ShowModal;
  Finally
      frmRecibo.Free;
  End;
end;

procedure TfrmPrincipal.mnuReceitaSubItemClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmRecibo, frmRecibo);
      frmRecibo.Caption := 'Receita';
      frmRecibo.ShowModal;
  Finally
      frmRecibo.Free;
  End;
end;

procedure TfrmPrincipal.mnuSobreItemClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmSobre, frmSobre);
      frmSobre.ShowModal;
  Finally
      frmSobre.Free;
  End;
end;

procedure TfrmPrincipal.DisplayHint(Sender: TObject);
begin
      Info.Panels[1].Text := Application.Hint;
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
     Image1.Left := (FrmPrincipal.Width Div 2) - (Image1.Width Div 2);
     Image1.Top := (FrmPrincipal.Height Div 2) - (Image1.Height Div 2 + Info.Height);
end;

procedure TfrmPrincipal.spUsoTaxiClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmRecibo2, frmRecibo2);
      frmRecibo2.ShowModal;
  Finally
      frmRecibo2.Free;
  End;
end;

procedure TfrmPrincipal.ImprimirNaVertical(AQuick: TQuickRep;
  ABanda: TQrBand; ATexto: string);
var
  lf: TLogFont;
  tf: TFont;
  xQrImage: TQrImage;
begin
  xQrImage := TQrImage.Create(AQuick);
  xQrImage.Parent := ABanda;
  xQrImage.Align := alLeft;
  xQrImage.Width := 10;
  xQrImage.BringToFront;
  with xQrImage.Canvas do
  begin
    Font.Name := 'Arial';
    Font.Size := 7;
    tf := TFont.Create;
    tf.Assign(Font);
    GetObject(tf.Handle, Sizeof(lf), @lf);
    lf.lfEscapement := 900;
    lf.lfOrientation := 450;
    tf.Handle := CreateFontIndirect(lf);
    Font.Assign(tf);
    tf.Free;
    TextOut(0, xQrImage.Height div 2, ATexto);
  end;
end;

end.
