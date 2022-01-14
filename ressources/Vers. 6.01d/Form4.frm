VERSION 5.00
Begin VB.Form Frm_Error 
   Caption         =   "Liste Fichier Avec Erreur"
   ClientHeight    =   2790
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4440
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   ScaleHeight     =   2790
   ScaleWidth      =   4440
   StartUpPosition =   2  'CenterScreen
   Begin VB.FileListBox DirFile 
      Height          =   2820
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4455
   End
End
Attribute VB_Name = "Frm_Error"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public CmdNotepad As String

Private Sub DirFile_dblClick()
    CmdNotepad = Shell("notepad.exe " & RepFicError & "\" & DirFile.FileName, vbMaximizedFocus)
End Sub

Private Sub Form_Load()
     DirFile.Path = RepFicError
End Sub

