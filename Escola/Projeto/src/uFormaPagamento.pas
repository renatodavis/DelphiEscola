unit uFormaPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_cadastropadrao, FMTBcd, SqlExpr, Provider, DB, DBClient,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, Grids, DBGrids, ComCtrls;

type
  TFormFormaPagamento = class(TFormPadrao)
    cdsCadastroIDPAGAMENTO: TIntegerField;
    cdsCadastroDESCRICAO: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel3: TBevel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    sedtProcura: TEdit;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    cdsCadastroCODEMPRESA: TIntegerField;
    sqlCadastroIDPAGAMENTO: TIntegerField;
    sqlCadastroDESCRICAO: TStringField;
    sqlCadastroCODEMPRESA: TIntegerField;
    procedure cdsCadastroBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sedtProcuraChange(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure sedtProcuraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;
  TCorLinha = class(TCustomDBGrid);

var
  FormFormaPagamento: TFormFormaPagamento;

implementation

uses uDm;

{$R *.dfm}


procedure TFormFormaPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  caption := 'Cadastro de Forma de pagamentos';

end;

procedure TFormFormaPagamento.FormShow(Sender: TObject);
begin
  inherited;

  TabSheet1.Show;
  sedtProcura.SetFocus;

end;

procedure TFormFormaPagamento.btnNovoClick(Sender: TObject);
begin
  TabSheet2.Show;
  inherited;
  sqlMax.Close;
  sqlMax.SQL.Clear;
  sqlMax.SQLConnection:=dmGeral.SQLConnection;
  sqlMax.SQL.Text := 'SELECT MAX(IDPAGAMENTO)+1 as ID FROM FORMA_PAGAMENTO ';
  sqlMax.Params[0].Value := iCodEmpresa;
  sqlMax.open;
  if sqlMax.Fields[0].IsNull then
     cdsCadastroIDPAGAMENTO.Value := 1
  else
     cdsCadastroIDPAGAMENTO.Value :=sqlMax.Fields[0].Value;
  cdsCadastroDESCRICAO.FocusControl;
  sqlMax.Close

end;









procedure TFormFormaPagamento.cdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
//  cdsCadastroIDTURMA.Value :=
  cdsCadastroCODEMPRESA.Value := iCodEmpresa;

end;


procedure TFormFormaPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   inherited;
   FormFormaPagamento := nil;
end;

procedure TFormFormaPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
     34:PageControl1.TabIndex :=1;
     33:PageControl1.TabIndex :=0;
  end;

end;

procedure TFormFormaPagamento.sedtProcuraChange(Sender: TObject);
begin
  inherited;
   cdsCadastro.Filtered := true;
   cdsCadastro.Filter := 'DESCRICAO LIKE '+''''+'%'+sedtProcura.Text+'%'+'''';
end;

procedure TFormFormaPagamento.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
   with TCorLinha(Sender) do
   if DataLink.ActiveRecord = Row -1  then
   begin
      Canvas.Brush.Color := iCorLinhaAtiva;
      Canvas.Font.Color  := clHighlightText;
   end
   else
   begin
      Canvas.Brush.Color := iCorLinha;
      Canvas.Font.Color  := clWindowText;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFormFormaPagamento.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   case key of
      VK_RETURN :DBGrid1.OnDblClick(self);
   end;

end;

procedure TFormFormaPagamento.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  TabSheet2.show;
end;

procedure TFormFormaPagamento.sedtProcuraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
     VK_RETURN:DBGrid1.SetFocus;
  end;
end;

end.
