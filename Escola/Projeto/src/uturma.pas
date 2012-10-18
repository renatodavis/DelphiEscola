unit uturma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_cadastropadrao, FMTBcd, SqlExpr, Provider, DB, DBClient,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, Grids, DBGrids, ComCtrls;

type
  TFormTurma = class(TFormPadrao)
    cdsCadastroIDTURMA: TIntegerField;
    cdsCadastroDESCRICAO: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    Label5: TLabel;
    sedtProcura: TEdit;
    sqlCadastroIDTURMA: TIntegerField;
    sqlCadastroDESCRICAO: TStringField;
    sqlCadastroVALOR_MENSALIDADE: TFMTBCDField;
    cdsCadastroVALOR_MENSALIDADE: TFMTBCDField;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Bevel3: TBevel;
    Bevel1: TBevel;
    sqlCadastroCODEMPRESA: TIntegerField;
    cdsCadastroCODEMPRESA: TIntegerField;
    procedure sedtProcuraChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsCadastroBeforePost(DataSet: TDataSet);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sedtProcuraExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TCorLinha = class(TCustomDBGrid);

var
  FormTurma: TFormTurma;

implementation

uses uDm;

{$R *.dfm}

procedure TFormTurma.sedtProcuraChange(Sender: TObject);
begin
  inherited;
   cdsCadastro.Filtered := true;
   cdsCadastro.Filter := 'DESCRICAO LIKE '+''''+'%'+sedtProcura.Text+'%'+'''';

end;

procedure TFormTurma.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  TabSheet2.show;
end;

procedure TFormTurma.FormCreate(Sender: TObject);
begin
  inherited;
  caption := 'Cadastro de Turmas';

end;

procedure TFormTurma.FormShow(Sender: TObject);
begin
  inherited;
  TabSheet1.Show;
  sedtProcura.SetFocus;

end;

procedure TFormTurma.btnNovoClick(Sender: TObject);
begin
  TabSheet2.Show;
  inherited;
  sqlMax.Close;
  sqlMax.SQL.Clear;
  sqlMax.SQLConnection:=dmGeral.SQLConnection;
  sqlMax.SQL.Text := 'SELECT MAX(IDTURMA)+1 as ID FROM TURMA WHERE CODEMPRESA = :EMPRESA';
  sqlMax.Params[0].Value := iCodEmpresa;
  sqlMax.open;
  if sqlMax.Fields[0].IsNull then
     cdsCadastroIDTURMA.Value := 1
  else
     cdsCadastroIDTURMA.Value :=sqlMax.Fields[0].Value;
  cdsCadastroDESCRICAO.FocusControl;
  sqlMax.Close

end;

procedure TFormTurma.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TFormTurma.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FormTurma := nil;

end;

procedure TFormTurma.cdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
//  cdsCadastroIDTURMA.Value :=
  cdsCadastroCODEMPRESA.Value := iCodEmpresa;
end;

procedure TFormTurma.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   case key of
      VK_RETURN :DBGrid1.OnDblClick(self);
   end;
end;

procedure TFormTurma.sedtProcuraExit(Sender: TObject);
begin
  inherited;
  DBGrid1.SetFocus;   
end;

procedure TFormTurma.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
     34:PageControl1.TabIndex :=1;
     33:PageControl1.TabIndex :=0;
  end;

end;

end.
