unit uEventoAtividade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_cadastropadrao, FMTBcd, SqlExpr, Provider, DB, DBClient,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, Grids, DBGrids, ComCtrls;

type
  TFormEventoAtividade = class(TFormPadrao)
    cdsCadastroID: TIntegerField;
    cdsCadastroDESCRICAO: TStringField;
    cdsCadastroDATA_INI: TDateField;
    cdsCadastroDATA_FIM: TDateField;
    cdsCadastroVALOR: TFloatField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel3: TBevel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    sedtProcura: TEdit;
    TabSheet2: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel1: TBevel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    cdsCadastroCODEMPRESA: TIntegerField;
    sqlCadastroID: TIntegerField;
    sqlCadastroDESCRICAO: TStringField;
    sqlCadastroDATA_INI: TDateField;
    sqlCadastroDATA_FIM: TDateField;
    sqlCadastroVALOR: TFloatField;
    sqlCadastroCODEMPRESA: TIntegerField;
    procedure btnNovoClick(Sender: TObject);
    procedure cdsCadastroBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure sedtProcuraChange(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsCadastroAfterApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TCorLinha = class(TCustomDBGrid);

var
  FormEventoAtividade: TFormEventoAtividade;

implementation

{$R *.dfm}

procedure TFormEventoAtividade.btnNovoClick(Sender: TObject);
begin
  inherited;
   TabSheet2.Show;
   DBEdit6.SetFocus;
end;

procedure TFormEventoAtividade.cdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
   cdsCadastroCODEMPRESA.Value := iCodEmpresa;
end;

procedure TFormEventoAtividade.FormShow(Sender: TObject);
begin
  inherited;
  TabSheet1.Show;
  sedtProcura.SetFocus;

end;

procedure TFormEventoAtividade.sedtProcuraChange(Sender: TObject);
begin
  inherited;
  cdsCadastro.Filtered := true;
  cdsCadastro.Filter := 'DESCRICAO LIKE '+''''+'%'+sedtProcura.Text+'%'+'''';

end;

procedure TFormEventoAtividade.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   case key of
      VK_RETURN :DBGrid1.OnDblClick(self);
   end;

end;

procedure TFormEventoAtividade.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TFormEventoAtividade.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  PageControl1.TabIndex := 1;
  DBEdit6.SetFocus;

end;

procedure TFormEventoAtividade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FormEventoAtividade := nil
end;

procedure TFormEventoAtividade.cdsCadastroAfterApplyUpdates(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;
   cdsCadastro.close;
   cdsCadastro.open;
end;

end.
