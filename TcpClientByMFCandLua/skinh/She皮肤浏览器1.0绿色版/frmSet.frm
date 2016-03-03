VERSION 5.00
Begin VB.Form frmSet 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "密码打开"
   ClientHeight    =   2730
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4305
   Icon            =   "frmSet.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2730
   ScaleWidth      =   4305
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  '屏幕中心
   Begin VB.CommandButton btnOpen 
      Caption         =   "打开"
      Height          =   375
      Left            =   2760
      TabIndex        =   3
      Top             =   1680
      Width           =   1095
   End
   Begin VB.TextBox txtPwd 
      Height          =   375
      Left            =   2280
      TabIndex        =   1
      Top             =   1080
      Width           =   1815
   End
   Begin VB.FileListBox File1 
      Height          =   2250
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "密码:"
      Height          =   180
      Left            =   2280
      TabIndex        =   2
      Top             =   720
      Width           =   450
   End
End
Attribute VB_Name = "frmSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub btnOpen_Click()
SkinH_AttachEx File1.FileName, txtPwd.Text
End Sub


Private Sub Form_Load()
File1.Path = App.Path
File1.Pattern = "*.she"
End Sub
