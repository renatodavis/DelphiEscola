unit uTurmaAluno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_cadastropadrao, FMTBcd, SqlExpr, Provider, DB, DBClient,
  StdCtrls, Buttons, ExtCtrls, SimpleDS, DBCtrls, Mask, Grids, DBGrids,
  Menus,dateUtils;

type
  TFormTurmaAluno = class(TFormPadrao)
    sdsAluno: TSimpleDataSet;
    dsAluno: TDataSource;
    sdsTurma: TSimpleDataSet;
    dsturma: TDataSource;
    sdsTurmaIDTURMA: TIntegerField;
    sdsTurmaDESCRICAO: TStringField;
    sqlCadastroID: TIntegerField;
    sqlCadastroCOD_ALUNO: TIntegerField;
    sqlCadastroCOD_TURMA: TIntegerField;
    sqlCadastroANO: TIntegerField;
    sqlCadastroPERIODO: TStringField;
    cdsCadastroID: TIntegerField;
    cdsCadastroCOD_ALUNO: TIntegerField;
    cdsCadastroCOD_TURMA: TIntegerField;
    cdsCadastroANO: TIntegerField;
    cdsCadastroPERIODO: TStringField;
    sdsAlunoNOME: TStringField;
    sdsAlunoIDALUNO: TIntegerField;
    sdsAlunoENDE: TStringField;
    sdsAlunoTURMA: TIntegerField;
    cdsCadastroNomeAluno: TStringField;
    DBGrid1: TDBGrid;
    pnAlunos: TPanel;
    sdsMensalidade: TSimpleDataSet;
    sdsMensalidadeID: TIntegerField;
    sdsMensalidadeCODALUNO: TIntegerField;
    sdsMensalidadeVENCIMENTO: TDateField;
    sdsMensalidadePAGAMENTO: TDateField;
    sdsMensalidadeVALOR_MENSALIDADE: TFMTBCDField;
    sdsMensalidadeVALOR_PAGO: TFMTBCDField;
    sdsMensalidadeOBSER: TStringField;
    sdsMensalidadeSITUACAO: TStringField;
    sdsMensalidadeCODEMPRESA: TIntegerField;
    sdsAlunoDATA_VENCIMENTO: TDateField;
    sdsTurmaVALOR_MENSALIDADE: TFMTBCDField;
    sdsMensalidadeCOD_TURMA: TIntegerField;
    sqlCadastroCODEMPRESA: TIntegerField;
    cdsCadastroCODEMPRESA: TIntegerField;
    PopupMenu1: TPopupMenu;
    deletaaluno1: TMenuItem;
    sdsTurmaCODEMPRESA: TIntegerField;
    sdsAlunoCODEMPRESA: TIntegerField;
    Panel1: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnGerar: TSpeedButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    cbbturma: TComboBox;
    BitBtn1: TBitBtn;
    sqlCadastroCOBRAR_EVENTO: TStringField;
    cdsCadastroCOBRAR_EVENTO: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure cdsCadastroBeforePost(DataSet: TDataSet);
    procedure sdsTurmaAfterOpen(DataSet: TDataSet);
    procedure cbbturmaChange(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
    procedure sdsMensalidadeAfterPost(DataSet: TDataSet);
    procedure deletaaluno1Click(Sender: TObject);
    procedure cdsCadastroAfterPost(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure cdsCadastroAfterOpen(DataSet: TDataSet);
    procedure sdsAlunoAfterOpen(DataSet: TDataSet);
    procedure sdsMensalidadeAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TCorLinha = Class(TCustomDBGrid);

var
  FormTurmaAluno: TFormTurmaAluno;

implementation

uses uDm, uTurmaAlunoIncluir;

{$R *.dfm}

procedure TFormTurmaAluno.FormShow(Sender: TObject);
begin
  inherited;
  sdsAluno.Close;
  sdsAluno.dataset.Params[0].Value := iCodEmpresa;
  sdsAluno.open;
  sdsTurma.Close;
  sdsTurma.dataset.Params[0].Value := iCodEmpresa;
  sdsTurma.open;
  Edit1.Text := intTostr(YearOf(now));
//  cdsCadastro.Filtered := true;
//  cdsCadastro.Filter := 'COD_TURMA='+sdsTurmaIDTURMA.AsString;

end;

procedure TFormTurmaAluno.btnNovoClick(Sender: TObject);
begin
  inherited;
  sqlMax.Close;
  sqlMax.SQL.Clear;
  sqlMax.SQLConnection:=dmGeral.SQLConnection;
  sqlMax.SQL.Text := 'SELECT MAX(ID) +1 AS ID FROM TURMA_ALUNO';
  sqlMax.open;
  if sqlMax.Fields[0].IsNull then
     cdsCadastroID.Value :=1
  else
     cdsCadastroID.Value :=sqlMax.Fields[0].Value;
  cdsCadastroCOD_TURMA.FocusControl;
  sqlMax.Close

end;

procedure TFormTurmaAluno.DBEdit1Exit(Sender: TObject);
begin
  inherited;
  btnNovo.Click;
end;

procedure TFormTurmaAluno.cdsCadastroBeforePost(DataSet: TDataSet);
begin
   inherited;
   cdsCadastroANO.AsString := Edit1.Text;
   cdsCadastroPERIODO.AsString := ComboBox1.Text;
   cdsCadastroCODEMPRESA.Value := iCodEmpresa;
end;

procedure TFormTurmaAluno.sdsTurmaAfterOpen(DataSet: TDataSet);
begin
  inherited;
   sdsTurma.Filtered:=true;
   sdsTurma.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

   sdsTurma.First;
   while not sdsTurma.Eof do
   begin
      cbbturma.AddItem(sdsTurmaDESCRICAO.AsString,self);
      sdsTurma.Next;
   end;
end;

procedure TFormTurmaAluno.cbbturmaChange(Sender: TObject);
begin
  inherited;
  sdsTurma.Locate('DESCRICAO',cbbturma.Text,[]);
  cdsCadastro.Filtered := true;
  cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa)+' and COD_TURMA='+sdsTurmaIDTURMA.AsString + ' AND ANO = '+Edit1.Text+' AND PERIODO ='+''''+ComboBox1.Text+'''';
  pnAlunos.Caption := 'Alunos da Turma '+sdsTurmaIDTURMA.AsString;

end;

procedure TFormTurmaAluno.Edit1Exit(Sender: TObject);
begin
  inherited;
  if (sdsTurmaIDTURMA.AsString <> '') and (Edit1.Text<>'') then
  begin
     sdsTurma.Locate('DESCRICAO',cbbturma.Text,[]);
     cdsCadastro.Filtered := true;
     cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa)+' and COD_TURMA='+sdsTurmaIDTURMA.AsString + ' AND ANO = '+Edit1.Text+' AND PERIODO ='+''''+ComboBox1.Text+'''';
  end;
end;

procedure TFormTurmaAluno.ComboBox1Change(Sender: TObject);
begin
  inherited;
  if (sdsTurmaIDTURMA.AsString <> '') and (Edit1.Text<>'') then
  begin
     sdsTurma.Locate('DESCRICAO',cbbturma.Text,[]);
     cdsCadastro.Filtered := true;
     cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa)+' and COD_TURMA='+sdsTurmaIDTURMA.AsString + ' AND ANO = '+Edit1.Text+' AND PERIODO ='+''''+ComboBox1.Text+'''';
  end;
end;

procedure TFormTurmaAluno.BitBtn1Click(Sender: TObject);
begin
   inherited;
   if FormTurmaAlunoIncluir = nil then
      application.CreateForm(TFormTurmaAlunoIncluir,FormTurmaAlunoIncluir);
   FormTurmaAlunoIncluir.Empresa:= iCodEmpresa;
   FormTurmaAlunoIncluir.showModal;
      //   while not sdsAluno.Eof do
//   begin
//      FormTurmaAlunoIncluir.chlAlunos.Items.Add(sdsAlunoNOME.AsString);
//      sdsAluno.Next;
//   end;

{   with FormTurmaAlunoIncluir do
   for i:= 1 to chlAlunos.Count do
      if chlAlunos.Checked[i] then
      begin
         cdsCadastro.Insert;
         cdsCadastroCOD_ALUNO.Value :=

      end;  }
end;

procedure TFormTurmaAluno.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;FormTurmaAluno := nil;

end;

procedure TFormTurmaAluno.btnGerarClick(Sender: TObject);
begin
  inherited;
  if messagedlg('Deseja gerar a 1º mensalidade dos alunos ?',mtInformation,[mbYes,mbNo],0) = mrYes then
  begin
     cdsCadastro.First;
     sdsMensalidade.close;
     sdsMensalidade.open;
     while not cdsCadastro.Eof do
     begin
        if not sdsMensalidade.Locate('CODALUNO;COD_TURMA;CODEMPRESA',VarArrayOf([cdsCadastroCOD_ALUNO.Value,cdsCadastroCOD_TURMA.value,iCodEmpresa]),[]) then
        begin
           sdsAluno.Locate('IDALUNO',cdsCadastroCOD_ALUNO.Value,[]);
           sdsTurma.Locate('idturma',cdsCadastroCOD_TURMA.Value,[]);
           sdsMensalidade.append;;
           sdsMensalidadeID.Value := 0;
           sdsMensalidadeCODALUNO.Value := cdsCadastroCOD_ALUNO.Value;
           sdsMensalidadeVENCIMENTO.Value := sdsAlunoDATA_VENCIMENTO.Value;
           sdsMensalidadeVALOR_MENSALIDADE.AsCurrency := sdsTurmaVALOR_MENSALIDADE.AsCurrency;//cdsCadastroVALOR_EMPRESTIMO.AsCurrency * cdsCadastroPERC_JUROS.AsCurrency/100;
           sdsMensalidadeCODEMPRESA.Value := iCodEmpresa;
           sdsMensalidadeCOD_TURMA.Value  := cdsCadastroCOD_TURMA.Value;
           sdsMensalidade.post;
        end;
        cdsCadastro.Next;
     end;
     sdsMensalidade.close;
  end;
end;

procedure TFormTurmaAluno.sdsMensalidadeAfterPost(DataSet: TDataSet);
begin
  inherited;
  sdsMensalidade.ApplyUpdates(0)
end;

procedure TFormTurmaAluno.deletaaluno1Click(Sender: TObject);
begin
  inherited;
   cdsCadastro.Delete;   
end;

procedure TFormTurmaAluno.cdsCadastroAfterPost(DataSet: TDataSet);
begin
   inherited;
   btnGerar.Click;
end;

procedure TFormTurmaAluno.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
   with TCorLinha(Sender) do
   begin
      if DataLink.ActiveRecord = Row -1  then
      begin
         Canvas.Font.Color  := $00F4F4EA;
         Canvas.Brush.Color := clBlack;
      end
      else
      begin
         Canvas.Font.Color  := clBlack;
         Canvas.Brush.Color := iCorLinha;
      end;

   end;

   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFormTurmaAluno.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   inherited;
//   if not(key in ['0'..'9',#13,#8]) then
//      key := #0;
end;

procedure TFormTurmaAluno.cdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
   cdsCadastro.Filtered:=true;
   cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

end;

procedure TFormTurmaAluno.sdsAlunoAfterOpen(DataSet: TDataSet);
begin
  inherited;
   sdsAluno.Filtered:=true;
   sdsAluno.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

end;

procedure TFormTurmaAluno.sdsMensalidadeAfterOpen(DataSet: TDataSet);
begin
  inherited;

   sdsMensalidade.Filtered:=true;
   sdsMensalidade.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

end;

end.
