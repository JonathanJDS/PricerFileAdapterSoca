VERSION 5.00
Begin VB.Form Frm_Log 
   Caption         =   "Visualisation Log"
   ClientHeight    =   9210
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6330
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   9210
   ScaleWidth      =   6330
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Cmd_Exit 
      Caption         =   "&Quitter"
      Height          =   495
      Left            =   2520
      TabIndex        =   1
      ToolTipText     =   "Quitter Log"
      Top             =   8520
      Width           =   1215
   End
   Begin VB.ListBox ListLog 
      Height          =   8250
      Left            =   0
      TabIndex        =   0
      ToolTipText     =   "Log"
      Top             =   120
      Width           =   6375
   End
End
Attribute VB_Name = "Frm_Log"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Cmd_Exit_Click()
Unload Frm_Log
End Sub

Private Sub Form_ACTIVATE()

LigneLog = ""
'Ouverture Read/Write du fichier LOG
Log = rep_Log + "\LogMaj.txt"
Open Log For Input As #5

'ATTENTION DE VERIFIER SI LA POSITION EST PAREIL DANS LE MAG
Do While NumDay <> -1
PrecDay = Date - NumDay
    Do While EOF(5) = False
 '     Line Input #5, LigneLog
        If PrecDay = Mid(LigneLog, 1, 10) Then
            Do While EOF(5) = False
                Frm_Log.ListLog.AddItem (LigneLog)
                Frm_Log.ListLog.Refresh
                Line Input #5, LigneLog
            Loop
        Frm_Log.ListLog.AddItem (LigneLog)
        Frm_Log.ListLog.Refresh
        GoTo Fin
        End If
        Line Input #5, LigneLog
    Loop

    toto = Seek(5)
    Seek 5, 1
    LigneLog = ""
    NumDay = NumDay - 1
Loop

Fin:
Close #5

End Sub
