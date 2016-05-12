program InfoRecidos;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uSplash in 'uSplash.pas' {frmSplash},
  uSobre in 'uSobre.pas' {frmSobre},
  uRelRecibo in 'uRelRecibo.pas' {frmRelRecibo},
  uRecibo in 'uRecibo.pas' {frmRecibo},
  uFuncoes in 'uFuncoes.pas',
  uRecibo2 in 'uRecibo2.pas' {frmRecibo2},
  uRelRecido2 in 'uRelRecido2.pas' {frmRelRecibo2};

{$R *.res}

begin
     frmSplash := TfrmSplash.create(application);
     frmSplash.show;
     frmSplash.update;
     Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmRelRecibo, frmRelRecibo);
  Application.CreateForm(TfrmRecibo, frmRecibo);
  Application.CreateForm(TfrmRecibo2, frmRecibo2);
  Application.CreateForm(TfrmRelRecibo2, frmRelRecibo2);
  frmSplash.Hide;
     frmSplash.Free;
     Application.Run;
end.
