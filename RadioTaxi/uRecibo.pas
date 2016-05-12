unit uRecibo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TfrmRecibo = class(TForm)
    pnlSuperior: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtReceber: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    memObservacao: TMemo;
    btVisualizar: TBitBtn;
    btFechar: TBitBtn;
    edtImportancia: TCurrencyEdit;
    btLimpar: TBitBtn;
    edtReferente: TMemo;
    cbxEsporte: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btVisualizarClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure edtReferenteKeyPress(Sender: TObject; var Key: Char);
    procedure memObservacaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtReceberKeyPress(Sender: TObject; var Key: Char);
    procedure edtImportanciaKeyPress(Sender: TObject; var Key: Char);
    procedure btFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecibo: TfrmRecibo;

implementation

uses uRelRecibo,uFuncoes, uPrincipal;

{$R *.dfm}

procedure TfrmRecibo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
end;

procedure TfrmRecibo.btVisualizarClick(Sender: TObject);
begin
     If uFuncoes.Empty(edtReceber.Text) Then
     begin
          ShowMessage('Campo obrigatório!');
          edtReceber.SetFocus;
          Exit;
     End;
     //
     If uFuncoes.Empty(edtImportancia.Text) Then
     begin
          ShowMessage('Campo obrigatório!');
          edtImportancia.SetFocus;
          Exit;
     End;
     //
     If uFuncoes.Empty(edtReferente.Text) Then
     begin
          ShowMessage('Campo obrigatório!');
          edtReferente.SetFocus;
          Exit;
     End;
     //
     If (frmRecibo.Caption = 'Recibo') Then
     begin
         Application.CreateForm(TfrmRelRecibo, frmRelRecibo);  // Carrega form na memória
         //
         With frmRelRecibo do
         begin
              txtNMRECIBO.Caption    := 'RECIBO';
              txtRecibo2.Caption     := 'RECIBO';
              txtRecebemos.Caption   := edtReceber.Text;
              txtValor.Caption       := FormatFloat('###,##0.#0',edtImportancia.Value);
              //
              txtImportancia.Caption := FormatFloat('###,##0.#0',edtImportancia.Value)+' ('+uFuncoes.extenso(edtImportancia.Value)+')';
              txtReferente.Lines.Text := edtReferente.Lines.Text;
              txtObs.Lines.Text      := memObservacao.Lines.Text;
              // 2º formulario
              txtRecebemos2.Caption   := txtRecebemos.Caption;
              txtImportancia2.Caption := txtImportancia.Caption;
              txtReferentes2.Lines.Text := edtReferente.Lines.Text;
              txtObs2.Lines.Text      := memObservacao.Lines.Text;
              txtVALOR2.Caption       := txtValor.Caption;
              //
              {txtDia.Caption := Copy(DatetoStr(Date),1,2);
              txtMes.Caption := uFuncoes.MesExtenso(Date());
              txtAno.Caption := Copy(DatetoStr(Date),7,4);
              //
              txtDia2.Caption := Copy(DatetoStr(Date),1,2);
              txtMes2.Caption := uFuncoes.MesExtenso(Date());
              txtAno2.Caption := Copy(DatetoStr(Date),7,4);}
              //
              qrRecibo.Preview;
              Close;
         End;   // fim-do-with
     End;
     //
     If (frmRecibo.Caption = 'Despesas Internas') Then
     begin
         Application.CreateForm(TfrmRelRecibo, frmRelRecibo);  // Carrega form na memória
         With frmRelRecibo do
         begin
              If not (cbxEsporte.Checked) Then
                  txtNMRECIBO.Caption    := 'RECIBO DE DESPESAS INTERNAS RÁDIO TÁXI COOTAC'
              Else
                  txtNMRECIBO.Caption    := 'RECIBO DE DESPESAS INTERNAS ESPORTE RÁDIO TÁXI';
              txtRecibo2.Caption     := txtNMRECIBO.Caption;
              txtRecebemos.Caption   := edtReceber.Text;
              txtValor.Caption       := FormatFloat('###,##0.#0',edtImportancia.Value);
              txtImportancia.Caption := FormatFloat('###,##0.#0',edtImportancia.Value)+' ('+uFuncoes.extenso(edtImportancia.Value)+')';
              txtReferente.Lines.Text := edtReferente.Lines.Text;
              txtObs.Lines.Text      := memObservacao.Lines.Text;
              // 2º formulario
              txtRecebemos2.Caption   := txtRecebemos.Caption;
              txtImportancia2.Caption := txtImportancia.Caption;
              txtReferentes2.Lines.Text := edtReferente.Lines.Text;
              txtObs2.Lines.Text      := memObservacao.Lines.Text;
              txtVALOR2.Caption       := txtValor.Caption;
              //
              qrRecibo.Preview;
              Close;
         End;   // fim-do-with
     End;
     //
     If (frmRecibo.Caption = 'Receita') Then
     begin
         Application.CreateForm(TfrmRelRecibo, frmRelRecibo);  // Carrega form na memória
         With frmRelRecibo do
         begin
              txtNMRECIBO.Caption    := 'RECIBO DE RECEITA';
              txtRecibo2.Caption     := txtNMRECIBO.Caption;
              txtRecebemos.Caption   := edtReceber.Text;
              txtValor.Caption       := FormatFloat('###,##0.#0',edtImportancia.Value);
              txtImportancia.Caption := FormatFloat('###,##0.#0',edtImportancia.Value)+' ('+uFuncoes.extenso(edtImportancia.Value)+')';
              txtReferente.Lines.Text := edtReferente.Lines.Text;
              txtObs.Lines.Text      := memObservacao.Lines.Text;
              // 2º formulario
              txtRecebemos2.Caption   := txtRecebemos.Caption;
              txtImportancia2.Caption := txtImportancia.Caption;
              txtReferentes2.Lines.Text := edtReferente.Lines.Text;
              txtObs2.Lines.Text      := memObservacao.Lines.Text;
              txtVALOR2.Caption       := txtValor.Caption;
              //
              {txtDia.Caption := Copy(DatetoStr(Date),1,2);
              txtMes.Caption := uFuncoes.MesExtenso(Date());
              txtAno.Caption := Copy(DatetoStr(Date),7,4);
              //
              txtDia2.Caption := Copy(DatetoStr(Date),1,2);
              txtMes2.Caption := uFuncoes.MesExtenso(Date());
              txtAno2.Caption := Copy(DatetoStr(Date),7,4);}
              //
              qrRecibo.Preview;
              Close;
         End;   // fim-do-with
     End;
end;

procedure TfrmRecibo.btLimparClick(Sender: TObject);
begin
    edtReceber.Clear;
    edtImportancia.Clear;
    edtReferente.Clear;
    memObservacao.Clear;

end;

procedure TfrmRecibo.edtReferenteKeyPress(Sender: TObject; var Key: Char);
begin
     Key:= Upcase(Key);
end;

procedure TfrmRecibo.memObservacaoKeyPress(Sender: TObject; var Key: Char);
begin
     Key:= Upcase(Key);
end;

procedure TfrmRecibo.edtReceberKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = #13) and not uFuncoes.Empty(edtReceber.Text) Then
     Begin
          key := #0;
          edtImportancia.SetFocus;
     End;
end;

procedure TfrmRecibo.edtImportanciaKeyPress(Sender: TObject;
  var Key: Char);
begin
     If (Key = #13) and not uFuncoes.Empty(edtImportancia.Text) Then
     Begin
          key := #0;
          edtReferente.SetFocus;
     End;
end;

procedure TfrmRecibo.btFecharClick(Sender: TObject);
begin
     Close;
end;

end.
