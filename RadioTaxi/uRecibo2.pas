unit uRecibo2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit;

type
  TfrmRecibo2 = class(TForm)
    pnlSuperior: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    edtNome: TEdit;
    Panel2: TPanel;
    btVisualizar: TBitBtn;
    btFechar: TBitBtn;
    btLimpar: TBitBtn;
    Label2: TLabel;
    dteDTINIC: TDateEdit;
    dteDTFINA: TDateEdit;
    Label3: TLabel;
    procedure btFecharClick(Sender: TObject);
    procedure btVisualizarClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure dteDTFINAExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dteDTINICKeyPress(Sender: TObject; var Key: Char);
    procedure dteDTFINAKeyPress(Sender: TObject; var Key: Char);
    procedure dteDTINICExit(Sender: TObject);
  private
    Procedure Limpa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecibo2: TfrmRecibo2;

implementation

uses uRecibo, uFuncoes, uRelRecido2;

{$R *.dfm}

procedure TfrmRecibo2.btFecharClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmRecibo2.btVisualizarClick(Sender: TObject);
begin
     If uFuncoes.Empty(edtNome.Text) Then
     begin
          ShowMessage('Campo obrigat�rio!');
          edtNome.SetFocus;
          Exit;
     End;
     //
     If uFuncoes.Empty(dteDTINIC.Text) or (dteDTINIC.Text = '  /  /    ') Then
     begin
          ShowMessage('Campo obrigat�rio!');
          dteDTINIC.SetFocus;
          Exit;
     End;
     //
     If uFuncoes.Empty(dteDTFINA.Text) or (dteDTFINA.Text = '  /  /    ') Then
     begin
          ShowMessage('Campo obrigat�rio!');
          dteDTFINA.SetFocus;
          Exit;
     End;
     //
         Application.CreateForm(TfrmRelRecibo2, frmRelRecibo2);  // Carrega form na mem�ria
         //
         With frmRelRecibo2 do
         begin
              //
              txtTexto.Lines.Clear;
              //
              txtTexto.Lines.Add(uFuncoes.Replicate(' ',30)+'Solicitamos do(a)  '+edtNome.Text);
              txtTexto.Lines.Add(uFuncoes.Replicate(' ',32)+'  o  pagamento   referente  ao   uso  do  taxi   aos  funcion�rios  desta');
              txtTexto.Lines.Add(uFuncoes.Replicate(' ',0)+'secretaria  no  per�odo  de   '+ dteDTINIC.Text+ '  a  '+dteDTFINA.Text
                                       +'  do  corrente ano.');
              txtData.Caption     := 'Teresina  -  PI, _______ de _______________ de __________';

              //
              {txtData.Caption     := 'Teresina  -  PI,  '+Copy(DatetoStr(Date),1,2)+
                                     '   de   '+ uFuncoes.MesExtenso(Date())+'  de  '+Copy(DatetoStr(Date),7,4)+'.';}
              //
              txtTexto2.Lines.Clear;
              //
              txtTexto2.Lines.Add(uFuncoes.Replicate(' ',30)+'Solicitamos do(a)  '+edtNome.Text);
              txtTexto2.Lines.Add(uFuncoes.Replicate(' ',32)+'  o  pagamento   referente  ao   uso  do  taxi   aos  funcion�rios  desta');
              txtTexto2.Lines.Add(uFuncoes.Replicate(' ',0)+'secretaria  no  per�odo  de   '+ dteDTINIC.Text+ '  a  '+dteDTFINA.Text
                                       +'  do  corrente ano.');
              txtData2.Caption     := 'Teresina  -  PI, _______ de _______________ de __________';
              //
              {txtData2.Caption     := 'Teresina  -  PI,  '+Copy(DatetoStr(Date),1,2)+
                                     '   de   '+ uFuncoes.MesExtenso(Date())+'  de  '+Copy(DatetoStr(Date),7,4)+'.';}
              //
              qrRelatorio.Preview;
              Close;
         End;   // fim-do-with
end;

procedure TfrmRecibo2.btLimparClick(Sender: TObject);
begin
     Limpa;
end;

procedure TfrmRecibo2.dteDTFINAExit(Sender: TObject);
begin
   If (dteDTFINA.Text <> '  /  /    ') Then
   Begin
    try
       dteDTFINA.Date := StrToDate(dteDTFINA.Text);
    except
      on EConvertError do
      Begin
          ShowMessage ('Data Inv�lida!');
          dteDTFINA.SetFocus;
          Exit;
      End;
    end;
    //
     If (dteDTFINA.Date < dteDTINIC.Date) Then
     begin
         Application.MessageBox('Data final menor que a inicial!!!',
            'ATEN��O', MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
         //
         dteDTFINA.Text := dteDTINIC.Text;
         dteDTFINA.SetFocus;
     End;
   End;
end;

procedure TfrmRecibo2.Limpa;
begin
     edtNome.Clear;
     dteDTINIC.Clear;
     dteDTFINA.Clear;
     //
     edtNome.SetFocus;
end;

procedure TfrmRecibo2.FormActivate(Sender: TObject);
begin
    Limpa;
end;

procedure TfrmRecibo2.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = #13) and not uFuncoes.Empty(edtNome.Text) Then
     Begin
          key := #0;
          dteDTINIC.SetFocus;
     End;
end;

procedure TfrmRecibo2.dteDTINICKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = #13) and (dteDTINIC.Text <> '  /  /    ') Then
     Begin
          key := #0;
          dteDTFINA.SetFocus;
     End;
end;

procedure TfrmRecibo2.dteDTFINAKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = #13) and (dteDTFINA.Text <> '  /  /    ') Then
     Begin
          key := #0;
          btVisualizar.SetFocus;
     End;
end;

procedure TfrmRecibo2.dteDTINICExit(Sender: TObject);
begin
   If (dteDTINIC.Text <> '  /  /    ') Then
   Begin
    try
      dteDTINIC.Date := StrToDate(dteDTINIC.Text);
    except
      on EConvertError do
      Begin
          ShowMessage ('Data Inv�lida!');
          dteDTINIC.SetFocus;
          Exit;
      End;
    end;
  End;
end;

end.
