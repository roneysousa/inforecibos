unit uFrmGraficoDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Mask, ToolEdit, TeEngine, Series,
  DB, TeeProcs, Chart, DbChart, Grids, DBGrids, ComCtrls;

type
  TfrmGraHora = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    edtDTINIC: TDateEdit;
    edtDTFINA: TDateEdit;
    btnFiltar: TBitBtn;
    btFechar: TBitBtn;
    dsDados: TDataSource;
    grdConsultar: TDBGrid;
    btnGrafico: TBitBtn;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btnFiltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGraficoClick(Sender: TObject);
    procedure edtDTINICExit(Sender: TObject);
    procedure edtDTFINAExit(Sender: TObject);
    procedure edtDTFINAKeyPress(Sender: TObject; var Key: Char);
    procedure edtDTINICKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGraHora: TfrmGraHora;


implementation

uses udmDados, DBTables, DBClient, ppReport, uFrmRelGraficoDia, uPrincipal;

{$R *.dfm}

procedure TfrmGraHora.FormShow(Sender: TObject);
begin
     edtDTINIC.Date := Date;
     edtDTFINA.Date := edtDTINIC.Date;
     //
     dmDados.LimparDataSet;
     {If not(dmDados.cdsDados.Active) Then
        dmDados.cdsDados.Open;} 
end;

procedure TfrmGraHora.btFecharClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmGraHora.btnFiltarClick(Sender: TObject);
Var
   iHora, i, iQuant : Integer;
   Hora : String;
begin
  StatusBar1.SimpleText := 'Aguarde geração de dados...';
  try
     btnFiltar.Enabled := False;
     //
     Screen.Cursor := crHourGlass;
     //
     dmDados.LimparDataSet;
     //
     If (edtDTINIC.Text <> '  /  /    ') and
         (edtDTFINA.Text <> '  /  /    ' ) Then
         begin
            try
                for i := 0 to 23 do
                  begin
                       dmDados.ConsultaAux(edtDTINIC.Date, edtDTFINA.Date, dmDados.StrZero(inttoStr(i),2));
                       //
                       If not (dmDados.qryAux.IsEmpty) Then
                          If not dmDados.Empty(dmDados.qryAux.FieldByname('ATE_HOATEN').AsString) then
                            Begin
                                 With dmDados.qryAux do
                                 begin
                                     First;
                                     iQuant := 0;
                                     While not (dmDados.qryAux.Eof) do
                                     begin
                                          iQuant := iQuant + FieldbyName('QUANT').AsInteger;
                                          //
                                          dmDados.qryAux.next;
                                     End;
                                     // dmDados.qryAux.FieldByname('ATE_DTATEN').AsString
                                     dmDados.AdicionarDados(
                                           Date(),
                                           dmDados.StrZero(InttoStr(i),2),
                                           iQuant);
                                     //
                                     //ShowMessage('Quant '+ inttoStr(iQuant));
                                 End;
                            End;
                  End;   // fim-do-para
                //
            Except
                ShowMessage ('Erro ao tentar gerar dados.');
            End;
         End;
  finally
    Screen.Cursor := crDefault;
    btnFiltar.Enabled := True;
    StatusBar1.SimpleText := '';
  end;
  Application.ProcessMessages;
end;

procedure TfrmGraHora.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      dmDados.cdsDados.Close; 
end;

procedure TfrmGraHora.btnGraficoClick(Sender: TObject);
begin
    if not (dmDados.cdsDados.IsEmpty) then
    begin
        Application.CreateForm(TfrmRelGarfico, frmRelGarfico);  // Carrega form na memória
        try
            uFrmRelGraficoDia.aData1 := edtDTINIC.Text;
            uFrmRelGraficoDia.aData2 := edtDTFINA.Text;
            frmRelGarfico.Caption := frmRelGarfico.Caption + '  -  Período :'+edtDTINIC.Text + ' à ' +edtDTFINA.Text;
            frmRelGarfico.ShowModal;  // Mostra form em modo exclusivo
        finally
            frmRelGarfico.Free; //  Libera Memória
        End;
        {With dmDados.ppReport1 do
          begin
               PrintReport;
          End;}
    End
    Else
        ShowMessage('Não há dados para geração de gráfico.');
end;

procedure TfrmGraHora.edtDTINICExit(Sender: TObject);
begin
     If (edtDTINIC.Text <> '  /  /    ') Then
     begin
        try
            StrToDate(edtDTINIC.Text);
            edtDTINIC.Date := StrToDate(edtDTINIC.Text);
        except
            on EConvertError do
                ShowMessage ('Data Inválida!');
        end;
     End;
end;

procedure TfrmGraHora.edtDTFINAExit(Sender: TObject);
begin
     If (edtDTFINA.Text <> '  /  /    ') Then
     begin
        try
            StrToDate(edtDTFINA.Text);
            edtDTFINA.Date := StrToDate(edtDTFINA.Text);
            //
            If (edtDTFINA.Date < edtDTINIC.Date) Then
               edtDTFINA.Date := edtDTINIC.Date;
            //
        except
            on EConvertError do
                ShowMessage ('Data Inválida!');
        end;
     End;

end;

procedure TfrmGraHora.edtDTFINAKeyPress(Sender: TObject; var Key: Char);
begin
     If (key = #13) and (edtDTFINA.Text <> '  /  /    ') Then
       begin
          key:=#0;
          btnFiltar.SetFocus;
       End;

end;

procedure TfrmGraHora.edtDTINICKeyPress(Sender: TObject; var Key: Char);
begin
     If (key = #13) and (edtDTINIC.Text <> '  /  /    ') Then
       begin
          key:=#0;
          edtDTFINA.SetFocus;
       End;
end;

end.
