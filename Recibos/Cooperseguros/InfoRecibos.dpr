program InfoRecibos;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uRecibo in 'uRecibo.pas' {frmRecibo},
  uFuncoes in 'uFuncoes.pas',
  uRelRecibo in 'uRelRecibo.pas' {frmRelRecibo},
  uSobre in 'uSobre.pas' {frmSobre},
  uSplash in 'uSplash.pas' {frmSplash},
  uRecibo2 in 'uRecibo2.pas' {frmRecibo2},
  uRelRecido2 in 'uRelRecido2.pas' {frmRelRecibo2};

{$R *.res}

begin
     frmSplash := TfrmSplash.create(application);
     frmSplash.show;
     frmSplash.update;
     Application.CreateForm(TfrmPrincipal, frmPrincipal);
  frmSplash.Hide;
     frmSplash.Free;
     Application.Run;
end.
