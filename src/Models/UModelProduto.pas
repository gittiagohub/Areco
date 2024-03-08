unit UModelProduto;

interface
uses
SimpleAttributes;

type

[tabela('produto')]
TProduto = class
private
    FID: integer;
    FCodigo: String;
    FUnidade: String;
    FPreco: double;
    FEstoque: double;
    FNome: string;
    procedure SetID(const Value: integer);
    procedure SetCodigo(const Value: String);
    procedure SetUnidade(const Value: String);
    procedure SetEstoque(const Value: double);
    procedure SetNome(const Value: string);
    procedure SetPreco(const Value: double);

 { private declarations }
protected
 { protected declarations }
public
   [campo('ID'),autoinc,pk]
   property ID :integer read Fid write Setid;

   [campo('Codigo'),notnull]
   property Codigo : string read FCodigo write SetCodigo;

   [campo('Nome'),notnull]
   property Nome : string read FNome write SetNome;

   [campo('Preco'),notnull]
   property Preco : double read FPreco write SetPreco;

   [campo('Unidade')]
   property Unidade : string read FUnidade write SetUnidade;

   [campo('Estoque')]
   property Estoque : double read FEstoque write SetEstoque;
 { public declarations }

published
 { published declarations }
end;

implementation
{ TProduto }

procedure TProduto.SetCodigo(const Value: String);
begin
     FCodigo := Value;
end;

procedure TProduto.SetEstoque(const Value: double);
begin
     FEstoque := Value;
end;

procedure TProduto.SetID(const Value: integer);
begin
     FID := Value;
end;

procedure TProduto.SetNome(const Value: string);
begin
     FNome := Value;
end;

procedure TProduto.SetPreco(const Value: double);
begin
     FPreco := Value;
end;

procedure TProduto.SetUnidade(const Value: String);
begin
     FUnidade := Value;
end;

end.
