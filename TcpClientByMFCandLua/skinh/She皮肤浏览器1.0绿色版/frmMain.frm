VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "She皮肤浏览器 v1.0"
   ClientHeight    =   4410
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   5370
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4410
   ScaleWidth      =   5370
   StartUpPosition =   2  '屏幕中心
   Begin VB.CommandButton btnSet 
      Caption         =   "高级设置"
      Height          =   495
      Left            =   3960
      TabIndex        =   7
      Top             =   2760
      Width           =   1215
   End
   Begin VB.CommandButton btnBlog 
      Caption         =   "官方博客"
      Height          =   495
      Left            =   3960
      TabIndex        =   6
      Top             =   1920
      Width           =   1215
   End
   Begin VB.CommandButton btnEnd 
      Caption         =   "退出"
      Height          =   495
      Left            =   3960
      TabIndex        =   4
      Top             =   3600
      Width           =   1215
   End
   Begin VB.CommandButton btnOCX 
      Caption         =   "标准控件"
      Height          =   495
      Left            =   3960
      TabIndex        =   3
      Top             =   1080
      Width           =   1215
   End
   Begin VB.CommandButton btnShes 
      Caption         =   "She皮肤库"
      Height          =   495
      Left            =   3960
      TabIndex        =   2
      Top             =   240
      Width           =   1215
   End
   Begin VB.FileListBox File1 
      Height          =   3330
      Left            =   120
      Pattern         =   "*.she"
      TabIndex        =   0
      Top             =   600
      Width           =   3495
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "AirCorn(C) 版权所有"
      Height          =   180
      Left            =   240
      MousePointer    =   99  'Custom
      TabIndex        =   5
      Top             =   4080
      Width           =   1710
   End
   Begin VB.Label lblSkinList 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "所有皮肤↓"
      Height          =   180
      Left            =   120
      TabIndex        =   1
      Top             =   240
      Width           =   915
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Const IDC_HAND As Long = 32649&
Private Declare Function LoadCursorA Lib "user32" (ByVal hInstance As Long, ByVal lpCursorName As Long) As Long
Private Declare Function SetCursor Lib "user32" (ByVal hCursor As Long) As Long
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private hHandCur As Long

Private Sub btnBlog_Click()
Dim rtn As Long
rtn = ShellExecute(0, "open", "http://Aircorn.blog.163.com", 0, 0, 1)
End Sub


Private Sub btnEnd_Click()
End
End Sub



Private Sub btnOCX_Click()
frmOCX.Show
End Sub

Private Sub btnSet_Click()
frmSet.Show
End Sub

Private Sub btnShes_Click()
Dim rtn As Long
rtn = ShellExecute(0, "open", "http://pan.baidu.com/share/home?uk=895173674", 0, 0, 1)
End Sub






Private Sub File1_DblClick()
SkinH_AttachEx File1.Path & "\" & File1.FileName, ""
End Sub

Private Sub Form_Load()
SkinH_SetAero 1
SkinH_AdjustAero 255, 0, 0, 0, 0, 0, 0, 0, 0
File1.Path = App.Path
SkinH_AttachEx App.Path & "\Black.she", ""
hHandCur = LoadCursorA(0&, IDC_HAND)
End Sub

Private Sub Form_Unload(Cancel As Integer)
Unload frmOCX
Unload frmSet
Unload frmMain
End
End Sub

Private Sub Label1_Click()
Dim rtn As Long
rtn = ShellExecute(0, "open", "http://Aircorn.blog.163.com", 0, 0, 1)
End Sub

Private Sub Label1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
SetCursor hHandCur
End Sub
