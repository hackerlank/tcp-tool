VERSION 5.00
Begin VB.Form frmOCX 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "标准控件预览"
   ClientHeight    =   3030
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4740
   Icon            =   "frmOCX.frx":0000
   MaxButton       =   0   'False
   ScaleHeight     =   3030
   ScaleWidth      =   4740
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  '屏幕中心
   Begin VB.OptionButton Option1 
      Caption         =   "Option1"
      Height          =   495
      Left            =   360
      TabIndex        =   10
      Top             =   2160
      Width           =   975
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   495
      Left            =   360
      TabIndex        =   9
      Top             =   1680
      Width           =   975
   End
   Begin VB.FileListBox File1 
      Height          =   990
      Left            =   3000
      TabIndex        =   8
      Top             =   1680
      Width           =   1215
   End
   Begin VB.DirListBox Dir1 
      Height          =   510
      Left            =   1680
      TabIndex        =   7
      Top             =   2040
      Width           =   1215
   End
   Begin VB.DriveListBox Drive1 
      Height          =   300
      Left            =   1680
      TabIndex        =   6
      Top             =   1680
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   300
      Left            =   1440
      TabIndex        =   5
      Text            =   "Combo1"
      Top             =   1200
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   2535
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   4215
      Begin VB.TextBox Text1 
         Height          =   270
         Left            =   1200
         Locked          =   -1  'True
         TabIndex        =   4
         Text            =   "Text1"
         Top             =   600
         Width           =   975
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Command1"
         Height          =   495
         Left            =   3240
         TabIndex        =   3
         Top             =   360
         Width           =   855
      End
      Begin VB.PictureBox Picture1 
         Height          =   855
         Left            =   240
         Picture         =   "frmOCX.frx":700A
         ScaleHeight     =   795
         ScaleWidth      =   675
         TabIndex        =   1
         Top             =   360
         Width           =   735
      End
      Begin VB.Line Line2 
         BorderWidth     =   2
         X1              =   120
         X2              =   4080
         Y1              =   1320
         Y2              =   1320
      End
      Begin VB.Line Line1 
         BorderWidth     =   2
         X1              =   1320
         X2              =   1320
         Y1              =   1320
         Y2              =   2400
      End
      Begin VB.Label Label1 
         Caption         =   "Label1"
         Height          =   255
         Left            =   1200
         TabIndex        =   2
         Top             =   360
         Width           =   975
      End
   End
End
Attribute VB_Name = "frmOCX"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

