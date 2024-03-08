program Backend;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  UModelConnection in 'src\Models\UModelConnection.pas',
  UModelDAO in 'src\Models\UModelDAO.pas',
  UConfig in 'src\UConfig.pas',
  URepositoryProduto in 'src\Repository\URepositoryProduto.pas',
  UModelProduto in 'src\Models\UModelProduto.pas',
  UUtils in 'src\UUtils.pas',
  UControllerProduto in 'src\Controllers\UControllerProduto.pas',
  UServer in 'src\UServer.pas';

var
     Horse : THorse;
begin
  try
     Horse := THorse.Create();
     TServer.Start(Horse);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
