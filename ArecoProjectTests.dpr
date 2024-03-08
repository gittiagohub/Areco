program ArecoProjectTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  UUtils in 'src\UUtils.pas',
  DUnitTestRunner,
  TestUControllerProduto in 'src\Controllers\TestUControllerProduto.pas',
  UControllerProduto in 'src\Controllers\UControllerProduto.pas',
  UConfig in 'src\UConfig.pas',
  URepositoryProduto in 'src\Repository\URepositoryProduto.pas',
  UModelProduto in 'src\Models\UModelProduto.pas',
  UModelConnection in 'src\Models\UModelConnection.pas',
  UModelDAO in 'src\Models\UModelDAO.pas',
  TestUServer in 'src\TestUServer.pas',
  UServer in 'src\UServer.pas';

begin
  DUnitTestRunner.RunRegisteredTests;
end.

