unit UConfig;

interface

uses
   System.IniFiles;

// var
// Database: String;
// DatabaseHost: String;
// DatabasePort: integer;
// DatabaseName: String;
// DatabaseUserName: String;
// DatabasePassword: String;

type
   TConfig = class
   private

   const
      constConfig: String = 'Config.ini';

   const
      constDatabaseSection: String = 'DataBaseConnection';

   const
      constDatabase: String = 'Database';

   const
      constDatabaseHost: String = 'Host';

   const
      constDatabasePort: String = 'Port';

   const
      constDatabaseName: String = 'DatabaseName';

   const
      constDatabaseUserName: String = 'User';

   const
      constDatabasePassword: String = 'Pass';

   const
      constDatabaseDLL: String = 'DLL';

      // Default values to create the file
   const
      constDefaultValueDatabase: String = 'PG';

   const
      constDefaultValueDatabaseHost: String = 'localhost';

   const
      constDefaultValueDatabasePort: integer = 5432;

   const
      constDefaultValueDatabaseName: String = 'areco';

   const
      constDefaultValueDatabaseUserName: String = 'postgres';

   const
      constDefaultValueDatabasePassword: String = 'masterkey';

   const
      constDefaultValueDatabaseDLL: String = 'libpq.dll';

      class var FDatabase: String;
      class var FDatabaseHost: String;
      class var FDatabasePort: integer;
      class var FDatabaseName: String;
      class var FDatabaseUserName: String;
      class var FDatabasePassword: String;

   const
      constAPISection: String = 'API';

   const
      constAPIPort: String = 'Port';

   const
      constAPIHost: String = 'Host';

      // Default values to create the file

   const
      constDefaultValueAPIPort: integer = 9001;

   const
      constDefaultValueAPIHost: String = '127.0.0.1';

      class var FAPIPort: integer;
      class var FAPIHost: String;
      class var FDatabaseDLL: String;

      class function LoadFile(aFileDir: String): TIniFile;

      { private declarations }
   protected
      { protected declarations }
   public
      class property Database: String read FDatabase;
      class property DatabaseHost: String read FDatabaseHost;
      class property DatabasePort: integer read FDatabasePort;
      class property DatabaseName: String read FDatabaseName;
      class property DatabaseUserName: String read FDatabaseUserName;
      class property DatabasePassword: String read FDatabasePassword;
      class property DatabaseDLL: String read FDatabaseDLL;

      class property APIPort: integer read FAPIPort;
      class property APIHost: String read FAPIHost;
      class Procedure LoadVariables();
      { public declarations }

   published
      { published declarations }
   end;

implementation

uses
   System.Classes, System.IOUtils, System.SysUtils;

{ TConfig }

class function TConfig.LoadFile(aFileDir: string): TIniFile;
begin
   Result := TIniFile.Create(aFileDir);

   // if there ins't a API Section, create with default values
   if not(Result.SectionExists(constAPISection)) then
   begin
      Result.WriteInteger(constAPISection, constAPIPort,
        constDefaultValueAPIPort);

      Result.WriteString(constAPISection, constAPIHost,
        constDefaultValueAPIHost);

   end;

   // if there ins't a Database Section, create with default values
   if not(Result.SectionExists(constDatabaseSection)) then
   begin
      Result.WriteString(constDatabaseSection, constDatabase,
        constDefaultValueDatabase);

      Result.WriteString(constDatabaseSection, constDatabaseHost,
        constDefaultValueDatabaseHost);

      Result.WriteInteger(constDatabaseSection, constDatabasePort,
        constDefaultValueDatabasePort);

      Result.WriteString(constDatabaseSection, constDatabaseName,
        constDefaultValueDatabaseName);

      Result.WriteString(constDatabaseSection, constDatabaseUserName,
        constDefaultValueDatabaseUserName);

      Result.WriteString(constDatabaseSection, constDatabasePassword,
        constDefaultValueDatabasePassword);

      Result.WriteString(constDatabaseSection, constDatabaseDLL,
        constDefaultValueDatabaseDLL);
   end;
end;

class procedure TConfig.LoadVariables;
var
   xPathConfigFile: String;
   xConfigFile: TIniFile;
begin
   xPathConfigFile := TPath.Combine(ExtractFilePath(ParamStr(0)), constConfig);

   xConfigFile := LoadFile(xPathConfigFile);
   try
      FDatabase := xConfigFile.ReadString(constDatabaseSection,
        constDatabase, '');

      FDatabaseHost := xConfigFile.ReadString(constDatabaseSection,
        constDatabaseHost, '');

      FDatabasePort := xConfigFile.ReadInteger(constDatabaseSection,
        constDatabasePort, 0);

      FDatabaseName := xConfigFile.ReadString(constDatabaseSection,
        constDatabaseName, '');

      FDatabaseUserName := xConfigFile.ReadString(constDatabaseSection,
        constDatabaseUserName, '');

      FDatabasePassword := xConfigFile.ReadString(constDatabaseSection,
        constDatabasePassword, '');

      FDatabaseDLL := xConfigFile.ReadString(constDatabaseSection,
        constDatabaseDLL, '');

      FAPIPort := xConfigFile.ReadInteger(constAPISection, constAPIPort, 0);

      FAPIHost := xConfigFile.ReadString(constAPISection,
        constAPIHost, '');  

   finally
      FreeandNil(xConfigFile);
   end;
end;

end.
