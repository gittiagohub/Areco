unit UServiceProduto;

interface

uses
  FireDAC.Comp.Client,
  UUtils,
  UConfig;

type

 TServiceProduto = class
   private
    { private declarations }
   protected
    { protected declarations }
   public
    class function SendPostProduto(aCodigo,aNome,aUnidade : String; aPreco,aEstoque : Double): TResult;
    class function SendGetProduto(aID : integer;  const aFDMemTable : TFDMemTable): TResult;
    class function SendGetProdutoByID(aID : integer;  const aFDMemTable : TFDMemTable): TResult;
    class function SendGetAllProdutos(const aFDMemTable : TFDMemTable): TResult;
    class function SendUpdateProduto(aID: integer;aCodigo,aNome,aUnidade : String;aPreco,aEstoque : Double): TResult;

    class function SendDeleteProduto(aID : integer;  const aFDMemTable : TFDMemTable): TResult;

    { public declarations }

   published
    { published declarations }
   end;

implementation
uses
   DataSet.Serialize.Adapter.RESTRequest4D, RESTRequest4D,UModelProduto,System.JSON,
   System.SysUtils,IpPeerClient,REST.Client;
 var
   xBaseUrl: String;
{ TServiceProduto }

class function TServiceProduto.SendDeleteProduto(aID: integer;
  const aFDMemTable: TFDMemTable): TResult;
   var
   LResponse: IResponse;
begin
     try
      Result.IniVars;

      LResponse := TRequest.New.BaseURL(xBaseUrl)
        .Resource('/produto/'+aID.ToString())
        .Accept('application/json').AcceptCharset('UTF-8')
        .Delete;

      if LResponse.StatusCode = 204 then
      begin
           SendGetAllProdutos(aFDMemTable);

           Result.MSGError :='Sucesso ao apagar o produto.';
           Result.OK       := True;
      end
      else
      begin
         Result.MSGError :='Erro ao apagar o produto.';
      end;
   except on E: Exception do
      begin
         Result.MSGError :='Erro ao apagar o produto.';
      end;
   end;
end;

class function TServiceProduto.SendGetAllProdutos(
  const aFDMemTable: TFDMemTable): TResult;
var
  LResponse: IResponse;
begin
   try
      Result.IniVars;

      LResponse := TRequest.New.BaseURL(xBaseUrl)
        .Adapters(TDataSetSerializeAdapter.New(aFDMemTable))
        .Resource('/produtos')
        .Accept('application/json')
        .AcceptCharset('UTF-8')
        .Get;

      if LResponse.StatusCode = 200 then
      begin
         Result.MSGError := 'Sucesso ao Obter os produtos.';
         Result.OK := True;
      end
      else
      begin
         Result.MSGError := 'Erro ao Obter os produtos.';
      end;
   except
      on E: Exception do
      begin
         Result.MSGError := 'Erro ao Obter os produtos.';
      end;
   end;
end;

class function TServiceProduto.SendGetProduto(aID: integer;
  const aFDMemTable: TFDMemTable): TResult;
  var
   LResponse: IResponse;
begin
     try
      Result.IniVars;

      if aID = 0 then
      begin
           Result.MSGError:= 'Preencha o ID Para Buscar o Produto.';
           Exit;
      end;

      LResponse := TRequest.New.BaseURL(xBaseUrl)
        .Adapters(TDataSetSerializeAdapter.New(aFDMemTable))
        .Resource('/produto/'+aID.ToString())
        .Accept('application/json').AcceptCharset('UTF-8')
        .Get;

      if LResponse.StatusCode = 200 then
      begin
           Result.MSGError :='Sucesso ao Obter o Produto.';
           Result.OK       := True;
      end
      else
      begin
         Result.MSGError :='Erro ao Obter o Produto.';
      end;
   except on E: Exception do
      begin
         Result.MSGError :='Erro ao Obter o Produto.';
      end;
   end;
end;

class function TServiceProduto.SendGetProdutoByID(aID: integer;
  const aFDMemTable: TFDMemTable): TResult;
  var
   LResponse: IResponse;
begin
     try
        Result.IniVars;

        LResponse := TRequest.New.BaseURL(xBaseUrl)
          .Adapters(TDataSetSerializeAdapter.New(aFDMemTable))
          .Resource('/produto/'+aID.ToString())
          .Accept('application/json').AcceptCharset('UTF-8')
          .Get;

        if LResponse.StatusCode = 200 then
        begin
             Result.MSGError :='Sucesso ao Obter o produto.';
             Result.OK       := True;
        end
        else
        begin
             Result.MSGError :='Erro ao Obter o produto.';
        end;
     except on E: Exception do
      begin
         Result.MSGError :='Erro ao Obter o produto.';
      end;
     end;
end;

class function TServiceProduto.SendPostProduto(aCodigo,aNome, aUnidade: String; aPreco,
  aEstoque: Double): TResult;
   var
   LResponse: IResponse;
   xProduto : TProduto;
begin
     try
        Result.IniVars;

        xProduto := Tproduto.Create;
        xProduto.Codigo  := aCodigo;
        xProduto.Nome    := aNome;
        xProduto.Unidade := aUnidade;
        xProduto.Preco   := aPreco;
        xProduto.Estoque := aEstoque;

        LResponse := TRequest.New.BaseURL(xBaseUrl)
                     .AddBody(xProduto)
                     .Resource('/produtos')
                     .Accept('application/json')
                     .AcceptCharset('utf-8')
                     .Post;

        if LResponse.StatusCode = 200 then
        begin
             Result.MSGError :='Sucesso ao inserir o produto.';
             Result.OK       := True;
        end
        else
        begin
           Result.MSGError :='Erro ao inserir o produto.'+slinebreak+
            LResponse.JSONValue.GetValue<string>('Dados inválidos: ')  ;
        end;
   except on E: Exception do
      begin
         Result.MSGError :='Erro ao inserir produtos.';
      end;
   end;
end;

class function TServiceProduto.SendUpdateProduto(aID: integer;aCodigo, aNome,
  aUnidade: String; aPreco, aEstoque: Double): TResult;
  var
   LResponse: IResponse;
   xProduto : TProduto;
begin
     try
        Result.IniVars;

        xProduto  := Tproduto.Create;

        xProduto.Codigo  := aCodigo;
        xProduto.id      := aID;
        xProduto.Nome    := aNome;
        xProduto.Unidade := aUnidade;
        xProduto.Preco   := aPreco;
        xProduto.Estoque := aEstoque;

        LResponse := TRequest.New.BaseURL(xBaseUrl)
                                  .AddBody(xProduto)
                                  .Resource('/produto/')
                                  .Accept('application/json')
                                  .AcceptCharset('utf-8')
                                  .Put;

        if LResponse.StatusCode = 200 then
        begin
             Result.MSGError :='Sucesso ao atualizar o produto.';
             Result.OK       := True;
        end
        else
        begin
             Result.MSGError :='Erro ao atualizar o produto.'+slinebreak+
             LResponse.JSONValue.GetValue<string>('Dados inválidos: ')  ;
        end;
     except on E: Exception do
        begin
             Result.MSGError :='Erro ao atualizar o produto.';
        end;
     end;
end;

initialization
 Tconfig.LoadVariables;
 xBaseUrl := Tconfig.APIHost + ':' + Tconfig.APIPort.ToString() + '/v1';

end.
