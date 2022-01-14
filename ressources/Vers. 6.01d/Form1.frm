VERSION 5.00
Begin VB.Form Frm_Main 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mise à Jour LECLERC                              vers 6.01D"
   ClientHeight    =   6510
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   7980
   ControlBox      =   0   'False
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   6510
   ScaleWidth      =   7980
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton CmdFileError 
      Caption         =   "&Erreur"
      Height          =   495
      Left            =   4920
      MaskColor       =   &H8000000F&
      Style           =   1  'Graphical
      TabIndex        =   28
      Top             =   5880
      Width           =   855
   End
   Begin VB.CommandButton CmdLog 
      Caption         =   "&Log"
      Height          =   495
      Left            =   5880
      TabIndex        =   16
      ToolTipText     =   "Visualisation Log"
      Top             =   5880
      Width           =   855
   End
   Begin VB.ListBox EtatJour 
      Height          =   1230
      Left            =   240
      TabIndex        =   7
      ToolTipText     =   "Dernière mise à jour"
      Top             =   840
      Width           =   7455
   End
   Begin VB.Timer Timer1 
      Left            =   0
      Top             =   2400
   End
   Begin VB.CommandButton Cmd_quit 
      Caption         =   "&Quitter"
      Enabled         =   0   'False
      Height          =   495
      Left            =   6840
      TabIndex        =   1
      ToolTipText     =   "Quitter le programme"
      Top             =   5880
      Width           =   855
   End
   Begin VB.Image Image1 
      Height          =   615
      Index           =   1
      Left            =   360
      Picture         =   "Form1.frx":0442
      Stretch         =   -1  'True
      Top             =   4800
      Width           =   2415
   End
   Begin VB.Label Label11 
      Caption         =   "Temps avant impression (sec.) : "
      Height          =   255
      Left            =   360
      TabIndex        =   27
      Top             =   480
      Width           =   2535
   End
   Begin VB.Label LblTpsRestPrint 
      Height          =   255
      Left            =   2880
      TabIndex        =   26
      ToolTipText     =   "Temps en seconde"
      Top             =   480
      Width           =   735
   End
   Begin VB.Label Lbl_ImpOk 
      Caption         =   "0"
      Height          =   255
      Left            =   6960
      TabIndex        =   25
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label Lbl_ImpTotal 
      Caption         =   "0"
      Height          =   255
      Left            =   6960
      TabIndex        =   24
      Top             =   4080
      Width           =   615
   End
   Begin VB.Label Lbl_ImpNon 
      Caption         =   "0"
      Height          =   255
      Left            =   6960
      TabIndex        =   23
      Top             =   3720
      Width           =   615
   End
   Begin VB.Label Label13 
      Caption         =   "Impressions effectuées :"
      Height          =   255
      Left            =   4080
      TabIndex        =   22
      Top             =   3360
      Width           =   2775
   End
   Begin VB.Label Label14 
      Caption         =   "Impressions totales :"
      Height          =   255
      Left            =   4080
      TabIndex        =   21
      Top             =   4080
      Width           =   2775
   End
   Begin VB.Label Label15 
      Caption         =   "Impressions échouées :"
      Height          =   255
      Left            =   4080
      TabIndex        =   20
      Top             =   3720
      Width           =   2895
   End
   Begin VB.Image Image1 
      Height          =   615
      Index           =   0
      Left            =   5160
      Picture         =   "Form1.frx":196608
      Stretch         =   -1  'True
      Top             =   4800
      Width           =   1935
   End
   Begin VB.Label LblTpsRest 
      Height          =   255
      Left            =   2880
      TabIndex        =   19
      ToolTipText     =   "Temps en seconde"
      Top             =   120
      Width           =   735
   End
   Begin VB.Label Label6 
      Caption         =   "Temps avant mise à jour (sec.) : "
      Height          =   255
      Left            =   360
      TabIndex        =   18
      Top             =   120
      Width           =   2535
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Caption         =   " for"
      BeginProperty Font 
         Name            =   "Script"
         Size            =   36
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   3360
      TabIndex        =   17
      Top             =   4680
      Width           =   1215
   End
   Begin VB.Line Line4 
      X1              =   7680
      X2              =   7680
      Y1              =   3120
      Y2              =   4560
   End
   Begin VB.Line Line3 
      X1              =   240
      X2              =   7680
      Y1              =   4560
      Y2              =   4560
   End
   Begin VB.Line Line2 
      X1              =   240
      X2              =   7680
      Y1              =   3120
      Y2              =   3120
   End
   Begin VB.Line Line1 
      X1              =   240
      X2              =   240
      Y1              =   3120
      Y2              =   4560
   End
   Begin VB.Label Lbl_MajOk 
      Caption         =   "0"
      Height          =   255
      Left            =   3360
      TabIndex        =   15
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label Lbl_MajTotal 
      Caption         =   "0"
      Height          =   255
      Left            =   3360
      TabIndex        =   14
      Top             =   4080
      Width           =   615
   End
   Begin VB.Label Lbl_MajNon 
      Caption         =   "0"
      Height          =   255
      Left            =   3360
      TabIndex        =   13
      Top             =   3720
      Width           =   615
   End
   Begin VB.Label Label9 
      Caption         =   "Mises à jours effectués : "
      Height          =   255
      Left            =   480
      TabIndex        =   12
      Top             =   3360
      Width           =   2775
   End
   Begin VB.Label Label8 
      Caption         =   "Mises à jours total : "
      Height          =   255
      Left            =   480
      TabIndex        =   11
      Top             =   4080
      Width           =   2775
   End
   Begin VB.Label Label7 
      Caption         =   "Mises à jours avec erreur : "
      Height          =   255
      Left            =   480
      TabIndex        =   10
      Top             =   3720
      Width           =   2895
   End
   Begin VB.Shape feux 
      BackColor       =   &H80000004&
      BackStyle       =   1  'Opaque
      FillColor       =   &H80000005&
      Height          =   255
      Index           =   1
      Left            =   240
      Shape           =   3  'Circle
      Top             =   6000
      Width           =   375
   End
   Begin VB.Shape feux 
      BackColor       =   &H80000004&
      BackStyle       =   1  'Opaque
      FillColor       =   &H80000005&
      Height          =   255
      Index           =   2
      Left            =   600
      Shape           =   3  'Circle
      Top             =   6000
      Width           =   375
   End
   Begin VB.Shape feux 
      BackColor       =   &H80000004&
      BackStyle       =   1  'Opaque
      FillColor       =   &H80000005&
      Height          =   255
      Index           =   3
      Left            =   960
      Shape           =   3  'Circle
      Top             =   6000
      Width           =   375
   End
   Begin VB.Label Label5 
      Caption         =   "Articles total :"
      Height          =   255
      Left            =   480
      TabIndex        =   9
      Top             =   2640
      Width           =   2895
   End
   Begin VB.Label Lbl_Total 
      Caption         =   "0"
      Height          =   255
      Left            =   3360
      TabIndex        =   8
      Top             =   2640
      Width           =   615
   End
   Begin VB.Label Label3 
      Caption         =   "Article en cours :"
      Height          =   255
      Left            =   480
      TabIndex        =   6
      Top             =   2280
      Width           =   1935
   End
   Begin VB.Label Label2 
      Caption         =   "Le"
      Height          =   255
      Left            =   5400
      TabIndex        =   5
      Top             =   120
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "à"
      Height          =   255
      Left            =   6720
      TabIndex        =   4
      Top             =   120
      Width           =   135
   End
   Begin VB.Label LblTime 
      Alignment       =   2  'Center
      Height          =   255
      Left            =   6960
      TabIndex        =   3
      Top             =   120
      Width           =   615
   End
   Begin VB.Label LblDate 
      Alignment       =   1  'Right Justify
      Height          =   255
      Left            =   5760
      TabIndex        =   2
      Top             =   120
      Width           =   855
   End
   Begin VB.Label LblAff 
      Alignment       =   2  'Center
      Height          =   255
      Left            =   2400
      TabIndex        =   0
      Top             =   2280
      Width           =   5295
   End
End
Attribute VB_Name = "Frm_Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public TpsBclKey
Public BoucleCleanOk As Integer
Public BoucleUSBOk As Integer
Public BoucleScreenOk As Integer
Private Sub Cmd_quit_Click()
    Frm_Pwd.Show
End Sub

Private Sub CmdFileError_Click()
    Frm_Error.Show
End Sub

Private Sub CmdLog_Click()
    Frm_Log.Show
End Sub

Private Sub Form_Load()


TestLancementAppli
F = Fso.FileExists(App.Path + "\preference.ini")
If F = True Then
    Lecture_ini
    Lecture_ini_Format
Else
    MsgBox "Erreur Ouverture Fichier Preference.ini", vbCritical, "Attention"
    OuvertureLog ("Erreur Ouverture Fichier Preference.ini")
    End
End If

F = Fso.FileExists(App.Path + "\Code_Rayon.txt")
If F = True Then
    Lecture_Rayon
Else
    MsgBox "Erreur Ouverture Fichier Code_Rayon.txt", vbCritical, "Attention"
    OuvertureLog ("Erreur Ouverture Fichier Code_Rayon.txt")
    End
End If

CreationHistory
CreateBatFileFTP
InitialisationVariable
OuvertureLog ("--------------------")
OuvertureLog ("Initialisation Complète")
OuvertureLog ("Lancement MAJ")

End Sub

Private Sub Timer1_Timer()

    'Affcihage temps réel
    InitialisationScreen

    'Attente 5sec avant desactivation bouton Quitter
    If Cmd_quit.Enabled = True Then
        If (Timer - TpsBclKey) > 5 Then
            Cmd_quit.Enabled = False
            OuvertureLog ("--------------------")
            OuvertureLog ("Désactivation Bouton Quitter")
        End If
    End If
        

    'Boucle Print
    If TpsBouSecPrint = NumBouclePrint Then
        StartSearch
        CodeFic = 2
        choix_lect (rep_source_Print + "\*" + NomFicPrint + "*")
        EndSearch
        NumBouclePrint = 0
    End If
    
    'Boucle Update
    If TpsBouSec = NumBoucle Then
        StartSearch
        If LocalAppli = 1 Then GetFunction
        CodeFic = 1
        choix_lect (rep_source + "\*" + NomFic + "*")
        CodeFic = 3
        If VersionAdapter = 0 Then choix_lect (rep_source_Stock + "\*" + NomFicStock + "*.txt")
        If VersionAdapter = 1 Then
            GetRcpCommand
            choix_lect (rep_source_Stock + "\" + NomFicStock)
        End If
        EndSearch
        NumBoucle = 0
    End If
    
       'si 1er du mois nettoyage du log
    If Mid(Date, 1, 2) = "01" And BoucleCleanOk <> -1 Then
        CleanLog
        BoucleCleanOk = -1
    End If

    If Mid(Date, 1, 2) <> "01" And BoucleCleanOk = -1 Then
        BoucleCleanOk = 0
    End If

    'Nettoyage à Minuit de l'affichage
    If Mid(Time, 1, 2) = "01" And BoucleScreenOk <> -1 Then
        CleanScreen
        BoucleScreenOk = -1
      '  CleanItemReplica
    End If

    If Mid(Time, 1, 2) <> "01" And BoucleScreenOk = -1 Then
        BoucleScreenOk = 0
    End If

    'BackUP sur Clé USB
    If Mid(Time, 1, 2) = "11" And BoucleUSBOk <> -1 Then
        If EnableBackUp = 0 Then
            BackUpUsb
            CleanUsb
        End If
        BoucleUSBOk = -1
    End If

    If Mid(Time, 1, 2) <> "11" And BoucleUSBOk = -1 Then
        BoucleUSBOk = 0
    End If
    
End Sub

Private Sub TestLancementAppli()
'
' Empêcher l'application de se lancer 2 fois
'
If App.PrevInstance Then
    MsgBox "Cette application est déjà ouverte.", vbInformation, vbOKOnly, "Mon appli"
    End
End If

End Sub

Private Sub EtatJour_KeyDown(KeyCode As Integer, Shift As Integer)

'Activation du bouton quitter F1
If KeyCode = vbKeyF1 Then
    Cmd_quit.Enabled = True
    TpsBclKey = Timer
    OuvertureLog ("--------------------")
    OuvertureLog ("Activation Bouton Quitter")
End If

End Sub

Public Sub InitialisationVariable()
    FileNotReady = False
    NumBoucle = 0
    TpsRestant = 0
    MajOk = 0
    MajTotal = 0
    MajNon = 0
    ImpOk = 0
    ImpTotal = 0
    ImpNon = 0
    Frm_Main.Timer1.Interval = 1000
    Date_Heure
End Sub

Private Sub CleanScreen()
With Frm_Main
    .EtatJour.Clear
    .Lbl_MajNon.Caption = ""
    .Lbl_MajTotal.Caption = ""
    .Lbl_Total.Caption = ""
    .Lbl_MajOk.Caption = ""
    .Lbl_ImpNon.Caption = ""
    .Lbl_ImpTotal.Caption = ""
    .Lbl_ImpOk.Caption = ""
    .CmdFileError.BackColor = &H8000000F
End With
    OuvertureLog ("Nettoyage liste")
End Sub

Private Sub BackUpUsb()
    Dim DateBck As String
On Error GoTo BackUpUsbFunc

    OuvertureLog ("BackUP sur disk : " + DiskUSB)
    Frm_Main.EtatJour.AddItem (Etat + "BackUP sur disk : " + DiskUSB)
    F = Fso.FolderExists(DiskUSB)
    If F = True Then
        F = Fso.FileExists(FolderOfBackUp + FileToBackUp)
        If F = True Then
            DateBck = Format(Now, "yyyymmdd")
            FileCopy (FolderOfBackUp + FileToBackUp), DiskUSB + Mid(FileToBackUp, 1, Len(FileToBackUp) - 3) + DateBck
            OuvertureLog ("BackUP effectué!")
            Frm_Main.EtatJour.AddItem (Etat + "BackUP effectué!")
        Else
            OuvertureLog ("BackUP échoué! Le fichier à sauvegarder n'existe pas")
            Frm_Main.EtatJour.AddItem (Etat + "BackUP échoué! Le fichier à sauvegarder n'existe pas ")
        End If
    Else
        OuvertureLog ("BackUP échoué! Le répertoire de sauvegarde n'existe pas")
        Frm_Main.EtatJour.AddItem (Etat + "BackUP échoué! Le répertoire de sauvegarde n'existe pas")
    End If

On Error GoTo 0
Exit Sub
BackUpUsbFunc:
    OuvertureLog ("Error " & Err.Number & " (" & Err.Description & ") in procedure BackUpUsbFunc of Feuille Frm_Main")
    Frm_Main.EtatJour.AddItem (Etat + "BackUP échoué! Problème de clé USB")
End Sub

Private Sub CleanUsb()
    Dim DayDiffBck As String
   
    OuvertureLog ("Nettoyage Sauvegarde sur : " + DiskUSB)
    Frm_Main.EtatJour.AddItem (Etat + "Nettoyage Sauvegarde sur : " + DiskUSB)
    F = Fso.FolderExists(DiskUSB)
    If F = True Then
        DirFic = Dir(DiskUSB + Mid(FileToBackUp, 1, Len(FileToBackUp) - 3) + "*")
        Do While DirFic$ <> ""
            DayDiffBck = Mid(Right(DiskUSB + DirFic, 8), 7, 2) + "/" + Mid(Right(DiskUSB + DirFic, 8), 5, 2) + "/" + Mid(Right(DiskUSB + DirFic, 8), 1, 4)
            OuvertureLog ("Fichier Testé : " + DirFic)
            OuvertureLog ("Format date : " + DayDiffBck)
            OuvertureLog ("Différence date actuelle : " & DateDiff("d", DayDiffBck, Now))
            If Int(BackUpDay) < DateDiff("d", DayDiffBck, Now) Then
                Kill DiskUSB + DirFic
                OuvertureLog ("Nettoyage effectué : " + DirFic)
                Frm_Main.EtatJour.AddItem (Etat + "Nettoyage effectué : " + DirFic)
            End If
            DirFic$ = Dir
        Loop
               
    Else
        OuvertureLog ("Nettoyage échoué! Le répertoire de sauvegarde n'existe pas")
        Frm_Main.EtatJour.AddItem (Etat + "Nettoyage échoué! Le répertoire de sauvegarde n'existe pas")
    End If
End Sub

Private Sub StartSearch()
    Cmd_quit.Caption = "En Cours"
    CmdLog.Enabled = False
    CmdFileError.Enabled = False
    LblTpsRest.Caption = "En Cours"
    LblTpsRestPrint.Caption = "En Cours"
    
End Sub

Private Sub EndSearch()
    Cmd_quit.Caption = "Quitter"
    CmdLog.Enabled = True
    CmdFileError.Enabled = True
End Sub

Private Sub InitialisationScreen()
    NumBoucle = NumBoucle + 1
    TpsRestant = TpsBouSec - NumBoucle
    NumBouclePrint = NumBouclePrint + 1
    TpsRestantPrint = TpsBouSecPrint - NumBouclePrint
    LblTpsRest.Caption = TpsRestant
    LblTpsRestPrint.Caption = TpsRestantPrint
    LblTpsRest.Refresh
    LblTpsRestPrint.Refresh
    LblTime.Caption = Time
    LblDate.Caption = Date
End Sub

