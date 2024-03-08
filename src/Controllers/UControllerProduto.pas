unit UControllerProduto;

interface

uses
    Horse,
    System.JSON;

type
   TControllerProduto = class
      private

          { private declarations }
      protected

      class procedure InsertProduto(req: THorseRequest;
                                     res: THorseResponse;
                                     next: TNextProc);

       class procedure GetProduto(req: THorseRequest;
                                  res: THorseResponse;
                                  next: TNextProc);

       class procedure GetProdutoByID(req: THorseRequest;
                                      res: THorseResponse;
                                      next: TNextProc);

       class procedure DeleteProdutoByID(req: THorseRequest;
                                         res: THorseResponse;
                                         next: TNextProc);

       class procedure UpdateProduto(req: THorseRequest;
                                     res: THorseResponse;
                                     next: TNextProc);
       { protected declarations }
      public
         class procedure RegistryRoutes(App: Thorse);
       { public declarations }

      published
       { published declarations }
      end;

implementation

uses
  UUtils, URepositoryProduto, System.SysUtils;

{ TControllerProduto }

class procedure TControllerProduto.DeleteProdutoByID(req: THorseRequest;
  res: THorseResponse; next: TNextProc);
   var
   xResult: TResult;
begin
     try
        xResult := TRepositoryProduto.Delete('id', req.Params.items['id']);

        if not(xResult.OK) then
        begin
             Writeln('Erro: ', xResult.MSGError);
             res.Send<TJSONObject>(xResult.JSONObject).Status(xResult.HTTPStatus);
        end
        else
        begin
             res.Send<TJSONArray>(xResult.JSONArray).Status(xResult.HTTPStatus);
        end;

     except on E: Exception do
        begin
             Writeln(E.ClassName, ': ', E.Message);
             res.Send<TJSONObject>(TJSONObject.Create.AddPair('Erro','Erro ao apagar produto')).Status(500);
        end;
     end;
end;

class procedure TControllerProduto.GetProduto(req: THorseRequest;
  res: THorseResponse; next: TNextProc);
   var
   xResult: TResult;
begin
     try
        xResult := TRepositoryProduto.Get('','');
        if not(xResult.OK) then
        begin
             Writeln('Erro: ', xResult.MSGError);
             res.Send<TJSONObject>(xResult.JSONObject).Status(xResult.HTTPStatus);
        end
        else
        begin
             res.Send<TJSONArray>(xResult.JSONArray).Status(xResult.HTTPStatus);
        end;

     except on E: Exception do
         begin
              Writeln(E.ClassName, ': ', E.Message);
              res.Send<TJSONObject>(TJSONObject.Create.AddPair('Erro','Erro ao obter produtos')).Status(500);
         end;
     end;
end;

class procedure TControllerProduto.GetProdutoByID(req: THorseRequest;
  res: THorseResponse; next: TNextProc);
  var
   xResult: TResult;
begin
     try
        xResult := TRepositoryProduto.Get('id',req.Params.items['id'].tointeger());
        if not(xResult.OK) then
        begin
             Writeln('Erro: ', xResult.MSGError);
             res.Send<TJSONObject>(xResult.JSONObject).Status(xResult.HTTPStatus);
        end
        else
        begin
             res.Send<TJSONArray>(xResult.JSONArray).Status(xResult.HTTPStatus);
        end;

     except on E: Exception do
         begin
              Writeln(E.ClassName, ': ', E.Message);
              res.Send<TJSONObject>(TJSONObject.Create.AddPair('Erro','Erro ao obter produto')).Status(500);
         end;
     end;
end;

class procedure TControllerProduto.InsertProduto(req: THorseRequest;
  res: THorseResponse; next: TNextProc);
  var
   JSON: TJSONArray;
   xResult : TResult;
begin
     try
        try
           JSON := (TJSONObject.Create.ParseJSONValue(req.Body) as TJSONArray);
        except
            on E: Exception do
            begin
               try
                  JSON := TJSONArray.Create;
                  JSON.add(TJSONObject.Create.ParseJSONValue(req.Body) as TJSONObject);
               except
                  on E: Exception do
                   raise Exception.Create('Error ao converter json em objeto ');
               end;
            end;
        end;

        xResult := TRepositoryProduto.insert(JSON);

        if not(xResult.OK) then
        begin
             Writeln('Erro: ', xResult.MSGError);
             res.Send<TJSONObject>(xResult.JSONObject).Status(xResult.HTTPStatus);
        end
        else
        begin
             res.Send<TJSONObject>(xResult.JSONObject).Status(xResult.HTTPStatus);
        end;

     except on E: Exception do
        begin
             Writeln(E.ClassName, ': ', E.Message);
             res.Send<TJSONObject>(TJSONObject.Create.AddPair('Erro','Erro ao inserir produto')).Status(500);
        end;
     end;
end;

class procedure TControllerProduto.RegistryRoutes(App: Thorse);
begin
     App.Group.Prefix('v1')
     .Get('/produtos', GetProduto)
     .Get('/produto/:id', GetProdutoByID)
     .Post('/produtos', InsertProduto)
     .Put('/produto', UpdateProduto)
     .Delete('/produto/:id', DeleteProdutoByID);
end;

class procedure TControllerProduto.UpdateProduto(req: THorseRequest;
  res: THorseResponse; next: TNextProc);
var
   xResult: TResult;
   JSON: TJSONObject;
begin
     try
        JSON   := (TJSONObject.Create.ParseJSONValue(req.Body) as TJSONObject);
        xResult:= TRepositoryProduto.Update(JSON);

        if not(xResult.OK) then
        begin
             Writeln('Erro: ', xResult.MSGError);
        end;

        res.Send<TJSONObject>(xResult.JSONObject).Status(xResult.HTTPStatus);

     except on E: Exception do
        begin
             Writeln(E.ClassName, ': ', E.Message);
             res.Send<TJSONObject>(TJSONObject.Create.AddPair('Erro','Erro ao atualizar produto')).Status(500);
        end;
     end;
end;

end.
