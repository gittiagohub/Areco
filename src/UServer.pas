unit UServer;

interface

uses Horse,
     Horse.jhonson;

type
   TServer = class
   private
    { private declarations }
   protected
    { protected declarations }
   public
   class procedure Start(Horse : THorse);
    { public declarations }

   published
    { published declarations }
   end;

implementation
uses System.SysUtils,UConfig,UControllerProduto;

{ TServer }

class procedure TServer.Start(Horse : THorse);
begin
     TConfig.LoadVariables;

     Horse.Use(Jhonson());

     TControllerProduto.RegistryRoutes(Horse);

     Horse.Listen(TConfig.ApiPort,
                  TConfig.APIHost,
                  procedure
                  begin
                     Writeln('Backend Iniciado em ' + Horse.Host + ':' + Horse.Port.ToString);
                  end,
                  procedure
                  begin
                     Writeln('Finalizado server ' + Horse.Host + ':' +
                       Horse.Port.ToString);
                  end);
end;

end.
