unit URepositoryProduto;

interface
uses
UUtils,System.JSON;

type
// TRepositoryProduto =class

   TRepositoryProduto = class
   private
    { private declarations }
   protected
    { protected declarations }
   public
     class function Insert(aJSON : TJSONArray): TResult;
     class function Update(aJSON : TJSONObject): TResult;
     class function Get(): TResult;overload;
     class function Get(aField: String ;aValue: Variant ): TResult;overload;
     class function Delete(aField: String = '';aValue: String =''): TResult;
    { public declarations }

   published
    { published declarations }
   end;
implementation

uses
  UModelProduto,UModeldao,System.SysUtils,Rest.JSON, System.Classes,SimpleValidator;

{ TRepositoryProduto }

class function TRepositoryProduto.Delete(aField, aValue: String): TResult;
var
 xDAO: iDAO<TProduto>;
begin
     Result.IniVars;
     try
        xDAO := TDAO<TProduto>.Create;

        xDAO.Delete(aField, QuotedStr(aValue));

        Result.JSONObject := TJSONObject.Create.AddPair('Sucesso', '');
        Result.OK := True;
        Result.HTTPStatus := 204;

     except on E: Exception do
        begin
             Result.JSONObject := TJSONObject.Create.AddPair('Erro','Erro ao apagar o produto.');
             Result.OK := False;
             Result.HTTPStatus := 500;
        end;
     end;
end;

class function TRepositoryProduto.Get(): TResult;
begin
     Result.IniVars;
     Result:= TRepositoryProduto.Get('',Variant(''));
end;

class function TRepositoryProduto.Get(aField: String; aValue: Variant): TResult;
var
   xDAO: iDAO<TProduto>;
   i: Integer;
begin
     Result.IniVars;
     try
        xDAO := TDAO<TProduto>.Create;

        if aField.IsEmpty then
        begin
           xDAO.Find();
        end
        else
        begin
           xDAO.Find(aField,aValue);
        end;

        Result.JSONArray := xDAO.ToJSONArray;

        Result.JSONObject := TJSONObject.Create.AddPair('Sucesso', '');
        Result.HTTPStatus := 200;
        Result.OK := True;
     except
        on E: Exception do
        begin
             Result.JSONObject := TJSONObject.Create.AddPair('Erro','Erro ao obter produto.');
             Result.OK := False;
             Result.HTTPStatus := 500;
             Result.MSGError := E.Message;
        end;
     end;
end;

class function TRepositoryProduto.Insert(aJSON: TJSONArray): TResult;
var
  XErrosValidate: TStringList;
  i: Integer;
  xProduto: TProduto;
   xDAO: iDAO<TProduto>;
begin
     Result.IniVars;
     try
        XErrosValidate := TStringList.Create;
        xDAO := TDAO<TProduto>.Create;
        try
           for i := 0 to aJSON.count - 1 do
           begin
              TSimpleValidator.Validate
                (TJson.JsonToObject<TProduto>(TJSONObject(aJSON.items[i])),
                XErrosValidate);
           end;

           if XErrosValidate.count > 0 then
           begin
                Result.JSONObject := TJSONObject.Create.AddPair('Dados inválidos: ',XErrosValidate.Text);
                Result.OK := False;
                Result.HTTPStatus := 201;
                Exit;
           end;

           for i := 0 to aJSON.count - 1 do
           begin
                xProduto := TJson.JsonToObject<TProduto>(TJSONObject(aJSON.items[i]));
                xDAO.insert(xProduto);
           end;

           Result.JSONObject := TJSONObject.Create.AddPair('Sucesso','');
           Result.OK := True;
           Result.HTTPStatus := 200;

        finally
           FreeAndNil(XErrosValidate);
        end;
     except on E: Exception do
          begin
               Result.JSONObject := TJSONObject.Create.AddPair('Erro','Erro ao inserir o produto.');
               Result.JSONArray := nil;
               Result.OK := False;
               Result.HTTPStatus := 500;
               Result.MSGError   := E.message;
          end;
     end;
end;

class function TRepositoryProduto.Update(aJSON: TJSONObject): TResult;
var xDAO : iDAO<TProduto>;
begin
     Result.IniVars;
     try
        xDAO := TDAO<TProduto>.Create;

        xDAO.Update(TJson.JsonToObject<TProduto>(aJSON));

        Result.JSONObject := TJSONObject.Create.AddPair('Sucesso', '');
        Result.OK := True;
        Result.HTTPStatus := 200;
     except
        on E: Exception do
        begin
             Result.JSONObject := TJSONObject.Create.AddPair('Erro','Erro ao atualizar o produto.');
             Result.OK := False;
             Result.HTTPStatus := 500;
        end;
     end;
end;

end.
