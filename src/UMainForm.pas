unit UMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons;

type
  TForm2 = class(TForm)
    LabelID: TLabel;
    LabelCodigo: TLabel;
    LabelNome: TLabel;
    LabelUnidade: TLabel;
    LabelPreco: TLabel;
    LabelEstoque: TLabel;
    DBEditID: TDBEdit;
    DBEditCodigo: TDBEdit;
    DBEditNome: TDBEdit;
    DBEditUnidade: TDBEdit;
    DBEditPreco: TDBEdit;
    DBEditEstoque: TDBEdit;
    GroupBoxPrincipal: TGroupBox;
    GroupBoxLista: TGroupBox;
    DBGridProduto: TDBGrid;
    DataSourceProduto: TDataSource;
    FDMemTableProduto: TFDMemTable;
    BitBtnNovo: TBitBtn;
    GroupBoxAcoes: TGroupBox;
    BitBtnAtualizar: TBitBtn;
    BitBtnApagar: TBitBtn;
    BitBtnBuscaTodos: TBitBtn;
    BitBtnBuscaPorID: TBitBtn;
    EditID: TEdit;
    GroupBox1: TGroupBox;
    BitBtnCancelar: TBitBtn;
    procedure BitBtnNovoClick(Sender: TObject);
    procedure BitBtnAtualizarClick(Sender: TObject);
    procedure BitBtnApagarClick(Sender: TObject);
    procedure BitBtnBuscaPorIDClick(Sender: TObject);
    procedure BitBtnBuscaTodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
  private
     procedure AtivaBotoes(AAtiva: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses UUtils,UServiceProduto;

{$R *.dfm}

procedure TForm2.BitBtnBuscaPorIDClick(Sender: TObject);
var xResult : TResult;
    XID : Integer;
begin
     try
        XID :=  StrToInt(EditID.Text);
        xResult := TServiceProduto.SendGetProdutoByID(XID,
                                                      FDMemTableProduto);
        if not(xResult.OK) then
        begin
            ShowMessage(xResult.MSGError);
        end;
        EditID.Clear;
     except on E: Exception do
          showMessage('ID inválido para buscar.');
     end;
end;

procedure TForm2.BitBtnBuscaTodosClick(Sender: TObject);
var
  xResult: TResult;
begin
     xResult := TServiceProduto.SendGetAllProdutos(FDMemTableProduto);
     if not(xResult.OK) then
     begin
         ShowMessage(xResult.MSGError);
     end;
end;

procedure TForm2.BitBtnCancelarClick(Sender: TObject);
begin
     AtivaBotoes(true);
     if ((FDMemTableProduto.State = dsEdit) or
         (FDMemTableProduto.State = dsInsert)) then
     begin
          FDMemTableProduto.Cancel;
     end;
     BitBtnNovo.Caption := 'Novo';
     TServiceProduto.SendGetAllProdutos(FDMemTableProduto);
end;

procedure TForm2.AtivaBotoes(aAtiva:boolean);
begin
     BitBtnAtualizar.Visible  :=aAtiva;
     BitBtnApagar.Visible     :=aAtiva;
     BitBtnBuscaPorID.Visible :=aAtiva;
     BitBtnBuscaTodos .Visible:=aAtiva;
     EditID.Visible           :=aAtiva;

     BitBtnCancelar.Visible   := not(aAtiva);
end;

procedure TForm2.BitBtnApagarClick(Sender: TObject);
var xResult : TResult;
  xID: String;
begin
     xID := DBEditID.text;

     if xID.Trim.IsEmpty then
     begin
          Showmessage('Não há registro para atualizar.');
          Exit;
     end;

     xResult := TServiceProduto.SendDeleteProduto(StrToInt(xID),
                                                  FDMemTableProduto);
     if not(xResult.OK) then
     begin
         ShowMessage(xResult.MSGError);
     end;
end;

procedure TForm2.BitBtnAtualizarClick(Sender: TObject);
var xResult: TResult;
  xID: String;
begin
     xID := DBEditID.text;

     if xID.Trim.IsEmpty then
     begin
          Showmessage('Não há registro para atualizar.');
          Exit;
     end;

     xResult:= TServiceProduto.SendUpdateProduto(strToint(xID),
                                                 DBEditCodigo.Text,
                                                 DBEditNome.Text,
                                                 DBEditUnidade.Text,
                                                 StrToFloatdef(DBEditPreco.Text,0),
                                                 StrToFloatdef(DBEditEstoque.Text,0));
     if not(xResult.OK) then
     begin
         ShowMessage(xResult.MSGError);
     end
     else
     begin
          if FDMemTableProduto.State = dsEdit then
          begin
               FDMemTableProduto.Post;
          end;
     end;
end;

procedure TForm2.BitBtnNovoClick(Sender: TObject);
var xResult : TResult;
begin
    if BitBtnNovo.Caption = 'Novo' then
    begin
         if not(FDMemTableProduto.active) then
         begin
              FDMemTableProduto.Active := True;
         end;

         FDMemTableProduto.Append;
         BitBtnNovo.Caption := 'Gravar';
         AtivaBotoes(False);
    end
    else
    begin
         xResult:= TServiceProduto.SendpostProduto(DBEditCodigo.Text,
                                                   DBEditNome.Text,
                                                   DBEditUnidade.Text,
                                                   StrToFloatdef(DBEditPreco.Text,0),
                                                   StrToFloatdef(DBEditEstoque.Text,0));
         if xResult.OK then
         begin
              BitBtnNovo.Caption := 'Novo';
              AtivaBotoes(True);
              TServiceProduto.SendGetAllProdutos(FDMemTableProduto);
         end
         else
         begin
              ShowMessage(xResult.MSGError);
         end;
    end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
     TServiceProduto.SendGetAllProdutos(FDMemTableProduto);
     AtivaBotoes(True);
end;

end.
