VERSION 5.00
Begin VB.Form Frm_Pwd 
   Caption         =   "Password"
   ClientHeight    =   1785
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3705
   ControlBox      =   0   'False
   LinkTopic       =   "Form3"
   ScaleHeight     =   1785
   ScaleWidth      =   3705
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Cmd_OK 
      Caption         =   "&Ok"
      Height          =   495
      Left            =   1320
      TabIndex        =   2
      Top             =   1080
      Width           =   975
   End
   Begin VB.TextBox TxtPassWord 
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   960
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   480
      Width           =   1695
   End
   Begin VB.Label Label1 
      Caption         =   "Quel est votre mot de passe ?"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3495
   End
End
Attribute VB_Name = "Frm_Pwd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Cmd_OK_Click()
Dim DirStop, DriveStop, StopSys As String
Dim reponse As String

reponse = TxtPassWord.Text
If reponse <> motPasse Then
    MsgBox "Mot de passe incorrect", vbCritical, "Attention!!"
    OuvertureLog ("Mauvais mot de passe")
    Flag_Quit = True
    Unload Me
    Frm_Main.Timer1.Enabled = True
Else
   OuvertureLog ("Quitter MAJ")
   OuvertureLog ("--------------------")
   End
End If

End Sub
Private Sub TxtPassWord_KeyPress(KeyAscii As Integer)

If KeyAscii = vbKeyReturn Then Cmd_OK_Click

End Sub
