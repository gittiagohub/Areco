object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Cadastro de Produtos'
  ClientHeight = 419
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxPrincipal: TGroupBox
    Left = 0
    Top = 0
    Width = 689
    Height = 419
    Align = alClient
    Caption = 'Produto'
    TabOrder = 0
    object LabelCodigo: TLabel
      Left = 32
      Top = 51
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object LabelEstoque: TLabel
      Left = 32
      Top = 159
      Width = 39
      Height = 13
      Caption = 'Estoque'
    end
    object LabelID: TLabel
      Left = 33
      Top = 24
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object LabelNome: TLabel
      Left = 33
      Top = 78
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object LabelPreco: TLabel
      Left = 33
      Top = 132
      Width = 27
      Height = 13
      Caption = 'Pre'#231'o'
    end
    object LabelUnidade: TLabel
      Left = 32
      Top = 105
      Width = 39
      Height = 13
      Caption = 'Unidade'
    end
    object DBEditCodigo: TDBEdit
      Left = 129
      Top = 48
      Width = 232
      Height = 21
      DataField = 'codigo'
      DataSource = DataSourceProduto
      TabOrder = 0
    end
    object DBEditEstoque: TDBEdit
      Left = 128
      Top = 156
      Width = 81
      Height = 21
      DataField = 'estoque'
      DataSource = DataSourceProduto
      TabOrder = 1
    end
    object DBEditID: TDBEdit
      Left = 129
      Top = 21
      Width = 80
      Height = 21
      DataField = 'ID'
      DataSource = DataSourceProduto
      ReadOnly = True
      TabOrder = 2
    end
    object DBEditNome: TDBEdit
      Left = 129
      Top = 75
      Width = 232
      Height = 21
      DataField = 'nome'
      DataSource = DataSourceProduto
      TabOrder = 3
    end
    object DBEditPreco: TDBEdit
      Left = 129
      Top = 129
      Width = 80
      Height = 21
      DataField = 'preco'
      DataSource = DataSourceProduto
      TabOrder = 4
    end
    object DBEditUnidade: TDBEdit
      Left = 129
      Top = 102
      Width = 232
      Height = 21
      DataField = 'unidade'
      DataSource = DataSourceProduto
      TabOrder = 5
    end
    object GroupBoxLista: TGroupBox
      Left = 2
      Top = 210
      Width = 685
      Height = 207
      Align = alBottom
      Caption = 'Lista de Produtos'
      TabOrder = 6
      object DBGridProduto: TDBGrid
        Left = 2
        Top = 15
        Width = 681
        Height = 190
        Align = alClient
        DataSource = DataSourceProduto
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Codigo'
            Title.Caption = 'C'#243'digo'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Width = 225
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'unidade'
            Title.Caption = 'Unidade'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Preco'
            Title.Caption = 'Pre'#231'o'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'estoque'
            Title.Caption = 'Estoque'
            Width = 157
            Visible = True
          end>
      end
    end
    object GroupBoxAcoes: TGroupBox
      Left = 408
      Top = 21
      Width = 265
      Height = 158
      Caption = 'A'#231#245'es'
      TabOrder = 7
      object BitBtnNovo: TBitBtn
        Left = 5
        Top = 20
        Width = 75
        Height = 25
        Caption = 'Novo'
        TabOrder = 0
        OnClick = BitBtnNovoClick
      end
      object BitBtnAtualizar: TBitBtn
        Left = 6
        Top = 83
        Width = 75
        Height = 25
        Caption = 'Atualizar'
        TabOrder = 1
        OnClick = BitBtnAtualizarClick
      end
      object BitBtnApagar: TBitBtn
        Left = 6
        Top = 115
        Width = 75
        Height = 25
        Caption = 'Apagar'
        TabOrder = 2
        OnClick = BitBtnApagarClick
      end
      object GroupBox1: TGroupBox
        Left = 86
        Top = 4
        Width = 175
        Height = 152
        Caption = 'Busca Produtos'
        TabOrder = 3
        object BitBtnBuscaPorID: TBitBtn
          Left = 4
          Top = 18
          Width = 75
          Height = 25
          Caption = 'Buscar por ID'
          TabOrder = 0
          OnClick = BitBtnBuscaPorIDClick
        end
        object EditID: TEdit
          Left = 83
          Top = 18
          Width = 89
          Height = 21
          NumbersOnly = True
          TabOrder = 1
        end
        object BitBtnBuscaTodos: TBitBtn
          Left = 3
          Top = 49
          Width = 169
          Height = 92
          Caption = 'Buscar Todos'
          TabOrder = 2
          OnClick = BitBtnBuscaTodosClick
        end
      end
      object BitBtnCancelar: TBitBtn
        Left = 5
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 4
        OnClick = BitBtnCancelarClick
      end
    end
  end
  object DataSourceProduto: TDataSource
    DataSet = FDMemTableProduto
    Left = 128
    Top = 320
  end
  object FDMemTableProduto: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'unidade'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'preco'
        DataType = ftFloat
      end
      item
        Name = 'estoque'
        DataType = ftFloat
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 130
    Top = 264
  end
end
