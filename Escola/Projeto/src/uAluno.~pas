//$00EAE9CE
unit uAluno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_cadastropadrao, FMTBcd, SqlExpr, Provider, DB, DBClient,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Mask, DBCtrls,
  SimpleDS, Menus;

type
  TFormAluno = class(TFormPadrao)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    sedtProcura: TEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    sqlCadastroIDALUNO: TIntegerField;
    sqlCadastroNOME: TStringField;
    sqlCadastroENDE: TStringField;
    sqlCadastroTURMA: TIntegerField;
    cdsCadastroNOME: TStringField;
    cdsCadastroTURMA: TIntegerField;
    TabSheet2: TTabSheet;
    cdsCadastroIDALUNO: TIntegerField;
    cdsCadastroENDE: TStringField;
    sdsTurma: TSimpleDataSet;
    dsTurma: TDataSource;
    DBNavigator1: TDBNavigator;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    TabSheet4: TTabSheet;
    sqlCadastroDATA_VENCIMENTO: TDateField;
    cdsCadastroDATA_VENCIMENTO: TDateField;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    sqlCadastroDATA_NASC: TDateField;
    sqlCadastroNACIONALIDADE: TStringField;
    sqlCadastroSEXO: TStringField;
    sqlCadastroN_MATRICULA: TStringField;
    sqlCadastroDATA_MATRICULA: TDateField;
    sqlCadastroDATA_DESLIGAMENTO: TDateField;
    sqlCadastroDATA_INCLUSAO: TDateField;
    sqlCadastroBAIRRO: TStringField;
    sqlCadastroCIDADE: TStringField;
    sqlCadastroUF: TStringField;
    sqlCadastroCEP: TStringField;
    sqlCadastroFONE: TStringField;
    sqlCadastroTURMA_ATUAL: TStringField;
    cdsCadastroDATA_NASC: TDateField;
    cdsCadastroNACIONALIDADE: TStringField;
    cdsCadastroSEXO: TStringField;
    cdsCadastroN_MATRICULA: TStringField;
    cdsCadastroDATA_MATRICULA: TDateField;
    cdsCadastroDATA_DESLIGAMENTO: TDateField;
    cdsCadastroDATA_INCLUSAO: TDateField;
    cdsCadastroBAIRRO: TStringField;
    cdsCadastroCIDADE: TStringField;
    cdsCadastroUF: TStringField;
    cdsCadastroCEP: TStringField;
    cdsCadastroFONE: TStringField;
    cdsCadastroTURMA_ATUAL: TStringField;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit11: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit12: TDBEdit;
    Label15: TLabel;
    DBEdit13: TDBEdit;
    Label16: TLabel;
    DBEdit14: TDBEdit;
    Label17: TLabel;
    DBEdit15: TDBEdit;
    Label18: TLabel;
    DBEdit16: TDBEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    sqlCadastroCODEMPRESA: TIntegerField;
    cdsCadastroCODEMPRESA: TIntegerField;
    TabSheet5: TTabSheet;
    Atividades: TPanel;
    sqlEventos: TSQLQuery;
    dsLink: TDataSource;
    cdsEventos: TClientDataSet;
    cdsCadastrosqlEventos: TDataSetField;
    dsEventos: TDataSource;
    gridEventos: TDBGrid;
    sdsEventos: TSimpleDataSet;
    sdsEventosID: TIntegerField;
    sdsEventosDESCRICAO: TStringField;
    sdsEventosDATA_INI: TDateField;
    sdsEventosDATA_FIM: TDateField;
    sdsEventosVALOR: TFloatField;
    sdsEventosCODEMPRESA: TIntegerField;
    dsListaEventos: TDataSource;
    Panel1: TPanel;
    Label19: TLabel;
    LookupEvento: TDBLookupComboBox;
    Label20: TLabel;
    DBEdit17: TDBEdit;
    Label21: TLabel;
    DBEdit18: TDBEdit;
    Label22: TLabel;
    DBEdit19: TDBEdit;
    btnIncluir: TBitBtn;
    btnDeletar: TBitBtn;
    PopupMenu1: TPopupMenu;
    Exclur1: TMenuItem;
    sqlEventosCODEVENTO: TIntegerField;
    sqlEventosCODALUNO: TIntegerField;
    sqlEventosVALOR_MENSAL: TFloatField;
    sqlEventosCODEMPRESA: TIntegerField;
    sqlEventosDATA_INI: TDateField;
    sqlEventosDATA_FIM: TDateField;
    cdsEventosCODEVENTO: TIntegerField;
    cdsEventosCODALUNO: TIntegerField;
    cdsEventosVALOR_MENSAL: TFloatField;
    cdsEventosCODEMPRESA: TIntegerField;
    cdsEventosDATA_INI: TDateField;
    cdsEventosDATA_FIM: TDateField;
    cdsEventosDescricao: TStringField;
    sqlMensalidadeTotal: TSQLQuery;
    sqlTurmaAluno: TSQLQuery;
    cdsTurmaAlunos: TClientDataSet;
    dsTurmaAluno: TDataSource;
    cdsCadastrosqlTurmaAluno: TDataSetField;
    cdsTurmaAlunosDESCRICAO: TStringField;
    cdsTurmaAlunosCOD_TURMA: TIntegerField;
    cdsTurmaAlunosCOD_ALUNO: TIntegerField;
    cdsTurmaAlunosCODEMPRESA: TIntegerField;
    DBLookupComboBox1: TDBLookupComboBox;
    sqlEventosCODTURMA: TIntegerField;
    cdsEventosCODTURMA: TIntegerField;
    procedure sedtProcuraChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsCadastroBeforePost(DataSet: TDataSet);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridEventosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnIncluirClick(Sender: TObject);
    procedure LookupEventoExit(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure Exclur1Click(Sender: TObject);
    procedure DBEdit19Exit(Sender: TObject);
    procedure cdsEventosAfterApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsEventosBeforePost(DataSet: TDataSet);
    procedure dsEventosStateChange(Sender: TObject);
    procedure gridEventosDblClick(Sender: TObject);
    procedure cdsEventosAfterPost(DataSet: TDataSet);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsEventosAfterDelete(DataSet: TDataSet);
    procedure LookupEventoCloseUp(Sender: TObject);
    procedure cdsEventosAfterOpen(DataSet: TDataSet);
    procedure sdsEventosAfterOpen(DataSet: TDataSet);
    procedure sdsTurmaAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsTurmaAlunosAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TCorLinha = class(TCustomDBGrid);

var
  FormAluno: TFormAluno;

implementation

uses uDm;

{$R *.dfm}

procedure TFormAluno.sedtProcuraChange(Sender: TObject);
begin
  inherited;
   cdsCadastro.Filtered := true;
   cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa)+' and NOME LIKE '+''''+'%'+sedtProcura.Text+'%'+'''';
end;

procedure TFormAluno.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  PageControl1.TabIndex := 1;
  TabSheet3.show;
  DBEdit1.SetFocus;
end;

procedure TFormAluno.FormCreate(Sender: TObject);
begin

  inherited;
  caption := 'Cadastro de Alunos';
  TabSheet3.Show;
  
  sdsTurma.Open;

end;

procedure TFormAluno.FormShow(Sender: TObject);
begin
  inherited;
  TabSheet1.Show;
  sedtProcura.SetFocus;
end;

procedure TFormAluno.btnNovoClick(Sender: TObject);
begin
  TabSheet2.Show;
  inherited;
  sqlMax.Close;
  sqlMax.SQL.Clear;
  sqlMax.SQLConnection:=dmGeral.SQLConnection;
  sqlMax.SQL.Text := 'SELECT MAX(IDALUNO)+1 as ID FROM ALUNO WHERE CODEMPRESA = :EMPRESA';
  sqlMax.Params[0].Value := iCodEmpresa;
  sqlMax.open;
  if sqlMax.Fields[0].IsNull then
     cdsCadastroIDALUNO.Value := 1
  else
   cdsCadastroIDALUNO.Value :=sqlMax.Fields[0].Value;
  cdsCadastroN_MATRICULA.FocusControl;
  sqlMax.Close
end;

procedure TFormAluno.FormDestroy(Sender: TObject);
begin
  inherited;
  sdsTurma.Close;
end;

procedure TFormAluno.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TFormAluno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FormAluno := nil;
end;

procedure TFormAluno.cdsCadastroBeforePost(DataSet: TDataSet);
begin
   inherited;
   cdsCadastroCODEMPRESA.Value := iCodEmpresa;
   cdsCadastroTURMA.Value := 0;
end;

procedure TFormAluno.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   case key of
      VK_RETURN :DBGrid1.OnDblClick(self);
   end;

end;

procedure TFormAluno.gridEventosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
   with TCorLinha(Sender) do
   if DataLink.ActiveRecord = Row -1  then
   begin
      Canvas.Brush.Color := clBlack;
      Canvas.Font.Color  := clHighlightText;
   end
   else
   begin
      Canvas.Brush.Color := iCorLinha;
      Canvas.Font.Color  := clWindowText;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFormAluno.btnIncluirClick(Sender: TObject);
begin
  inherited;
  cdsEventos.Insert;
  LookupEvento.SetFocus;
end;

procedure TFormAluno.LookupEventoExit(Sender: TObject);
begin
  inherited;

   if dsEventos.State = dsInsert then
   begin
      cdsEventosVALOR_MENSAL.AsCurrency :=sdsEventosVALOR.AsCurrency;
      cdsEventosDATA_INI.AsDateTime     := sdsEventosDATA_INI.AsDateTime;
      cdsEventosDATA_FIM.AsDateTime     := sdsEventosDATA_FIM.AsDateTime;
   end;
end;

procedure TFormAluno.btnDeletarClick(Sender: TObject);
begin
   if not messagedlg('Deseja evento Selecionado?',mtConfirmation,[mbYes,mbNo],0)= mrNo then Exit;
      cdsEventos.Delete;
end;

procedure TFormAluno.Exclur1Click(Sender: TObject);
begin
  inherited;
  btnDeletar.OnClick(self);
end;                

procedure TFormAluno.DBEdit19Exit(Sender: TObject);
begin
  inherited;
   cdsEventos.Post;
end;

procedure TFormAluno.cdsEventosAfterApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;
  cdsCadastro.ApplyUpdates(0);
end;

procedure TFormAluno.cdsEventosBeforePost(DataSet: TDataSet);
begin
  inherited;
   cdsEventosCODALUNO.Value :=cdsCadastroIDALUNO.Value ;
   cdsEventosCODEMPRESA.Value := cdsCadastroCODEMPRESA.Value;
//   cdsEventosCODTURMA.Value   := SDS
end;

procedure TFormAluno.dsEventosStateChange(Sender: TObject);
begin
  inherited;
  Atividades.Enabled :=  dsEventos.State in[dsEdit,dsInsert];
end;

procedure TFormAluno.gridEventosDblClick(Sender: TObject);
begin
  inherited;
   cdsEventos.Edit;
end;

procedure TFormAluno.cdsEventosAfterPost(DataSet: TDataSet);
begin
  inherited;
   cdsCadastro.ApplyUpdates(0);
   gridEventos.SetFocus;
end;

procedure TFormAluno.btnGravarClick(Sender: TObject);
begin
  inherited;
  TabSheet3.Show;
end;

procedure TFormAluno.cdsEventosAfterDelete(DataSet: TDataSet);
begin
  inherited;
   cdsCadastro.ApplyUpdates(0)
end;

procedure TFormAluno.LookupEventoCloseUp(Sender: TObject);
begin
  inherited;
   sqlMax.close;
   sqlMax.SQL.Text := 'SELECT COUNT(*) FROM EVENTO_ALUNO WHERE CODALUNO = :ALUNO AND CODEVENTO=:EVENTO and CODEMPRESA = :EMP';
   sqlMax.Params[0].Value := cdsCadastroIDALUNO.Value;
   sqlMax.Params[1].Value := cdsEventosCODEVENTO.Value;
   sqlMax.Params[2].Value := iCodEmpresa;
   sqlMax.open;
   if sqlMax.Fields[0].Value > 0 then
   begin
      messagedlg('Evento já cadastrado!',mtConfirmation,[mbOk],0);
      LookupEvento.SetFocus;
      exit;
   end;

end;

procedure TFormAluno.cdsEventosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cdsEventos.Filtered:=true;
  cdsEventos.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);
end;

procedure TFormAluno.sdsEventosAfterOpen(DataSet: TDataSet);
begin
  inherited;
   sdsEventos.Filtered:=true;
   sdsEventos.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);
end;

procedure TFormAluno.sdsTurmaAfterOpen(DataSet: TDataSet);
begin
  inherited;
   sdsTurma.Filtered:=true;
   sdsTurma.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

end;

procedure TFormAluno.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
     34:PageControl1.ActivePageIndex :=1;
     33:PageControl1.ActivePageIndex :=0;
  end;
end;

procedure TFormAluno.cdsTurmaAlunosAfterOpen(DataSet: TDataSet);
begin
  inherited;
//   cdsTurmaAlunos.Filtered:=true;
//   cdsTurmaAlunos.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

end;

end.
