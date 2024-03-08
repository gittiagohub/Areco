program Frontend;

uses
  Vcl.Forms,
  UMainForm in 'src\UMainForm.pas' {Form2},
  UServiceProduto in 'src\Service\UServiceProduto.pas',
  UUtils in 'src\UUtils.pas',
  UConfig in 'src\UConfig.pas',
  UModelProduto in 'src\Models\UModelProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
