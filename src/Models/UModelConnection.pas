unit UModelConnection;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
   FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
   FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
   Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
   System.Classes, Inifiles;

type
   Tconnection = class(TFDConnection)
   private
      FDPhysPGDriverLink: TFDPhysPGDriverLink;
      procedure CriaBancoDados();
      { private declarations }
   protected
      { protected declarations }
   public
      { public declarations }
      constructor Create(AOwner: TComponent); override;

   published
      { published declarations }
   end;

implementation

uses
   System.SysUtils, System.IOUtils,UConfig,FireDAC.Phys.PGWrapper;

{ Tconnection }

constructor Tconnection.Create(AOwner: TComponent);
begin
   inherited;
   try
      Self.Params.DriverID := TConfig.Database;
      Self.Params.add('Server=' +TConfig.DatabaseHost);
      Self.Params.add('Port=' +IntToStr(TConfig.DatabasePort));
      Self.Params.Database := TConfig.DatabaseName;
      Self.Params.UserName := TConfig.DatabaseUserName;
      Self.Params.Password := TConfig.DatabasePassword;

//         To work with uuid in PG  delphi version 12
//         Self.Params.add('GUIDEndian=Big');

      Self.ResourceOptions.Persistent := True;
      Self.UpdateOptions.AutoCommitUpdates :=True;

      FDPhysPGDriverLink := TFDPhysPGDriverLink.Create(AOwner);
      FDPhysPGDriverLink.VendorLib := ExtractFilePath(ParamStr(0)) +TConfig.DatabaseDLL;

       try
          Self.Connected := True;
        except
            on E : EPgNativeException do
            begin
                 if ((pos('não existe',E.message)> 0) or (pos('not exists',E.message)> 0))  then
                 begin
                      CriaBancoDados();
                 end;
            end;
            on E: Exception do
            begin
                 Writeln('Falha ao conectar no banco: '+E.ClassName, ': ', E.Message);
            end;
        end;

   except
      on E: Exception do
         raise Exception.Create('Erro fazer  conexão com o banco de dados ' +
           TConfig.DatabaseName + '.');
   end;

end;
procedure Tconnection.CriaBancoDados;
begin
     try
        //Conecta no banco padrao pra criar o banco de dados.
        Self.Params.Database :='postgres';
        Self.Connected := True;

        //Cria banco de dados
        Self.ExecSQL('CREATE DATABASE '+ TConfig.DatabaseName);

        //Conecta no banco criado
        Self.Params.Database := TConfig.DatabaseName;
        Self.Connected := True;

        //Cria tabela
        Self.ExecSQL('CREATE TABLE IF NOT EXISTS produto ( '
                    +'    id SERIAL PRIMARY KEY, '
                    +'    codigo VARCHAR(50) UNIQUE NOT NULL, '
                    +'    nome VARCHAR(100) NOT NULL, '
                    +'    unidade VARCHAR(20), '
                    +'    preco NUMERIC(10, 2) NOT NULL, '
                    +'    estoque NUMERIC '
                    +');');

        Self.ExecSQL('CREATE INDEX IF NOT EXISTS idx_codigo ON produto (codigo);');
        Self.ExecSQL('CREATE INDEX IF NOT EXISTS idx_nome   ON produto (nome);');

     except on E: Exception do
         begin
              Writeln('Falha ao criar o banco de dados: '+E.ClassName, ': ', E.Message);
         end;
     end;

end;

end.
