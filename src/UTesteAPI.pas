unit UTesteAPI;

interface
uses
  DUnitX.TestFramework,
  UModelProduto;
type

  [TestFixture]
  TTestAPI = class(TObject)
  public
     xBaseUrl : string;
     xProdutoValidacao : Tproduto;

    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [test]
    procedure ApagaTodosProdutos();

     [test]
    procedure Post();

    [test]
    procedure Get();

    [test]
    procedure GetByID();

    [test]
    procedure Put();

    [test]
    procedure Delete();


  end;

implementation

uses
   DataSet.Serialize.Adapter.RESTRequest4D, RESTRequest4D,System.JSON,
   System.SysUtils,IpPeerClient,REST.Client,uConfig,REST.json;

procedure TTestAPI.ApagaTodosProdutos;
var
  xResponse: IResponse;
  xJSON: TJSONArray;
  I: Integer;
  xID : Integer;
begin
     //Apaga todos os produtos para começar o teste
     xResponse := TRequest.New.BaseURL(xBaseUrl)
                               .Resource('/produtos/')//+aID.ToString())
                               .Accept('application/json').AcceptCharset('UTF-8')
                               .Get;

     xJSON := (TJSONObject.Create.ParseJSONValue(XResponse.Content) as TJSONArray);

     for I := 0 to xJSON.count -1 do
     begin
          xID:= xJSON.items[i].GetValue<integer>('id');
          xResponse := TRequest.New.BaseURL(xBaseUrl)
                                    .Resource('/produto/'+xID.ToString())
                                    .Accept('application/json').AcceptCharset('UTF-8')
                                    .Delete;

          if not(xResponse.StatusCode = 204) then
          begin
               raise Exception.Create('Erro ao apagar os produtos: Status deveria retornar 204, mas retornou'+
                                      XResponse.StatusCode.ToString());
          end;
     end;

end;

procedure TTestAPI.Delete;
begin
     ApagaTodosProdutos;
end;

procedure TTestAPI.Get;
var
  xProduto: Tproduto;
  xResponse: IResponse;
  xJSON: TJSONArray;
begin
     xResponse := TRequest.New.BaseURL(xBaseUrl)
                               .Resource('/produtos/')
                               .Accept('application/json').AcceptCharset('UTF-8')
                               .Get;

     if not(XResponse.StatusCode = 200) then
     begin
          raise Exception.Create('Erro ao obter produtos: Status deveria retornar 200, mas retornou'
                                +XResponse.StatusCode.ToString());
     end;

     try
        xJSON := (TJSONObject.Create.ParseJSONValue(XResponse.Content) as TJSONArray);

        if not(xJSON.Count > 1) then
        begin
             raise Exception.Create('Erro ao obter produtos: Json deveria ter mais de um registro, mas tem '
                                    +xJSON.Count.ToString());
        end;

        xProdutoValidacao := Tjson.JsonToObject<TProduto>(TJSONObject(xJSON.Items[0]))
     finally
         FreeAndNil(xJSON);
     end;
end;

procedure TTestAPI.GetByID;
var
  xProduto: Tproduto;
  xResponse: IResponse;
  xJSON: TJSONArray;
begin
     xResponse := TRequest.New.BaseURL(xBaseUrl)
                               .Resource('/produto/'+xProdutoValidacao.iD.ToString())
                               .Accept('application/json').AcceptCharset('UTF-8')
                               .Get;

     if not(XResponse.StatusCode = 200) then
     begin
          raise Exception.Create('Erro ao obter produto por id: Status deveria retornar 200, mas retornou'
                                +XResponse.StatusCode.ToString());
     end;

     xJSON := (TJSONObject.Create.ParseJSONValue(XResponse.Content) as TJSONArray);

     if not(xJSON.Count = 1) then
     begin
          raise Exception.Create('Erro ao obter produto por id: Json deveria ter um registro, mas tem '
                                 +xJSON.Count.ToString());
     end;


     xProduto := Tjson.JsonToObject<TProduto>(TJSONObject(xJSON.Items[0]));

     if not(xProduto.Codigo = xProdutoValidacao.codigo) then
     begin
          raise Exception.Create('Erro ao obter produto por id: Codigo deveria ser ABC123, mas retornou '
                                 +xProduto.Codigo);
     end;

     if not(xProduto.nome = xProdutoValidacao.nome) then
     begin
          raise Exception.Create('Erro ao obter produto por id: Nome deveria ser Arroz, mas retornou '
                                 +xProduto.nome);
     end;

     if not(xProduto.Unidade = xProdutoValidacao.unidade) then
     begin
          raise Exception.Create('Erro ao obter produto por id: Unidade deveria ser KG, mas retornou '
                                 +xProduto.Unidade);
     end;

     if not(xProduto.Preco = xProdutoValidacao.preco) then
     begin
          raise Exception.Create('Erro ao obter produto por id: Preço deveria ser 35.99, mas retornou '
                                 +xProduto.Preco.ToString());
     end;

     if not(xProduto.Estoque = xProdutoValidacao.Estoque) then
     begin
          raise Exception.Create('Erro ao obter produto por id: Estoque deveria ser 100, mas retornou '
                                 +xProduto.Estoque.ToString());
     end;
end;

procedure TTestAPI.Post;
var
  xProduto1,xProduto2: Tproduto;
  XResponse: IResponse;
begin
     xProduto1 := Tproduto.Create;
     xProduto1.Codigo  := 'ABC123';
     xProduto1.Nome    := 'Arroz';
     xProduto1.Unidade := 'KG';
     xProduto1.Preco   := 40;
     xProduto1.Estoque := 100;

     XResponse := TRequest.New.BaseURL(xBaseUrl)
                  .AddBody(xProduto1)
                  .Resource('/produtos')
                  .Accept('application/json')
                  .AcceptCharset('utf-8')
                  .Post;


      if not(XResponse.StatusCode = 200) then
      begin
           raise Exception.Create('Erro ao inserir produto: Status deveria retornar 200, mas retornou '
                                  +XResponse.StatusCode.ToString());
      end;

     xProduto2 := Tproduto.Create;
     xProduto2.Codigo  := 'ABC456';
     xProduto2.Nome    := 'Cenoura';
     xProduto2.Unidade := 'KG';
     xProduto2.Preco   := 5;
     xProduto2.Estoque := 10;

     XResponse := TRequest.New.BaseURL(xBaseUrl)
                  .AddBody(xProduto2)
                  .Resource('/produtos')
                  .Accept('application/json')
                  .AcceptCharset('utf-8')
                  .Post;


      if not(XResponse.StatusCode = 200) then
      begin
           raise Exception.Create('Erro ao inserir produto: Status deveria retornar 200, mas retornou '
                                  +XResponse.StatusCode.ToString());
      end;
end;

procedure TTestAPI.Put;
var
  xProduto: Tproduto;
  XResponse: IResponse;
begin
     xProduto := Tproduto.Create;

     xProduto.ID := xProdutoValidacao.ID;
     xProduto.Codigo  := 'AAA';
     xProduto.Nome   := 'Detergente';
     xProduto.Unidade   := 'UN';
      xProduto.Preco   := 50.99;
     xProduto.Estoque := 200;

     XResponse := TRequest.New.BaseURL(xBaseUrl)
                  .AddBody(xProduto)
                  .Resource('/produto')
                  .Accept('application/json')
                  .AcceptCharset('utf-8')
                  .put;


      if not(XResponse.StatusCode = 200) then
      begin
           raise Exception.Create('Erro ao alterar o produto: Status deveria retornar 200, mas retornou '
                                  +XResponse.StatusCode.ToString());
      end;
end;

procedure TTestAPI.Setup;
begin
     Tconfig.LoadVariables;
     xBaseUrl := Tconfig.APIHost + ':' + Tconfig.APIPort.ToString() + '/v1';
end;

procedure TTestAPI.TearDown;
begin

end;


initialization

  TDUnitX.RegisterTestFixture(TTestAPI);
end.
