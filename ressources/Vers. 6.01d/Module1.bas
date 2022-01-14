Attribute VB_Name = "Module1"
Option Explicit
Public LigneRayon As String
Public VersionAdapter As String
Public Flag_Quit As Boolean
Public ItemExistDB As Boolean
Public rstTable As ADODB.Recordset
Public MaConn As ADODB.Connection
Public rstTable2 As ADODB.Recordset
Public MaConn2 As ADODB.Connection
'Initialisations Nom Fichier
Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Public tab_remplir(1 To 42) As String
Public tab_remp() As String
Public tab_rayon() As String
Public CodeRayon(1 To 99) As String
Public NomRayon(1 To 99) As String
Public LongTab As Integer
Public temp As String
Public CodeFic As Integer
Public RepFicError As String
Public NumFicOut As String
Public NumFicOutPrint As String
Public NomFic As String
Public NomFicStock As String
Public NomFicPrint As String
Public FicSav As String
Public Message As String
Public NomFicOut As String
Public NomFicOutPrint As String
Public motPasse As String
Public DirFic As String
Public Result As String
Public Fic As String
Public PrefIni As String
Public RepHisto As String
Public RepTemp As String
Public Log As String
Public LogSav As String
Public Fso As New FileSystemObject
Public F As Boolean
Public TpsRestant As String
Public TpsRestantPrint As String
Public Taille_Fic As Long
Public Taille_FicTot As Long
Public taille_champ As Integer
'Initialisations stat Article
Public TotalArt As String
Public TotalArtError As String
'Initialisations Message Réussite/Echoué
Public mesres As String
'Initialisations Heure+date
Public Etat As String
'Initialisations Disk Local
Public rep As String
Public rep_source As String
Public rep_source_Stock As String
Public rep_source_Print As String
Public ConfirmPrint As String
Public rep_input As String
Public rep_message As String
Public rep_Result As String
Public rep_InputPFI As String
Public rep_ResultPFI As String
Public rep_Log As String
Public Loc_Pricer As String
Public EnableBackUp As String
Public DiskUSB As String
Public FileToBackUp As String
Public FolderOfBackUp As String
Public BackUpDay As String
Public FileNotReady As Boolean
'Initialisations stat MAJ
Public MajOk As String
Public MajTotal As String
Public MajNon As String
Public ImpNon As String
Public ImpOk As String
Public ImpTotal As String
Public NumSav As String
Public FlagColor As String
Public Ligne As String
Public LigneLog As String
'Initialisations Format EEG
Public Form_EEG As String 'Nom dans Preference.ini
Public Code_EEG As String 'Code dans Fichier Source
Public Code_Form_EEG As String 'Code dans preference.ini
Public GenCode As String
Public LigneForm As String
'Initialisation Heure
Public NumBoucle As String
Public NumBouclePrint As Integer
Public TpsBouSec As String
Public TpsBouSecPrint As String
Public PrecDay As String
Public NumDay As String
Public NumDate As String
Public NumDayClean As String
'Variable reseau
Public i As Integer
Public LocalAppli As String
Public IPInfo As String
Public NomServeur As String
Public RepAbaco As String
Public Letter As String
Public FlagPass As String
Public PassReseau  As String
Public UserName As String
Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" _
                                                (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, _
                                                 ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long

'Variable FTP

Public Const SEE_MASK_DOENVSUBST As Long = &H200
Public Const SEE_MASK_IDLIST As Long = &H4
Public Const SEE_MASK_NOCLOSEPROCESS As Long = &H40
Public Const SW_HIDE As Long = 0
Public Const SW_SHOW As Long = 5
Public Const WAIT_TIMEOUT As Long = 258&

Public Type SHELLEXECUTEINFOA
    cbSize As Long
    fMask As Long
    hwnd As Long
    lpVerb As String
    lpFile As String
    lpParameters As String
    lpDirectory As String
    nShow As Long
    hInstApp As Long
    lpIDList As Long
    lpClass As String
    hkeyClass As Long
    dwHotKey As Long
    hIcon As Long
    hProcess As Long
End Type

Public Declare Function CloseHandle Lib "kernel32.dll" (ByVal hObject As Long) As Long
Public Declare Function GetExitCodeProcess Lib "kernel32.dll" (ByVal hProcess As Long, ByRef lpExitCode As Long) As Long
Public Declare Function ShellExecuteEx Lib "shell32.dll" (ByRef lpExecInfo As SHELLEXECUTEINFOA) As Long
Public Declare Function WaitForSingleObject Lib "kernel32.dll" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long

Public Function Lecture_ini()

'fonction servant a lire les differents parametre qui sont dans le
'fichier preference.ini tel que le repertoire ou se trouve pricer
'Répertoire + fichier
VersionAdapter = LitDansFichierIni("Version", "VersionAdapter")
rep = LitDansFichierIni("rep_location", "location")
rep_input = LitDansFichierIni("rep_location", "rep input")
rep_message = LitDansFichierIni("rep_location", "rep Message") + "\message"
rep_Result = LitDansFichierIni("rep_location", "rep result") + "\result"
rep_InputPFI = LitDansFichierIni("rep_MessagePFI", "rep input")
rep_ResultPFI = LitDansFichierIni("rep_MessagePFI", "rep result")
rep_source = LitDansFichierIni("rep_source", "source")
rep_source_Stock = LitDansFichierIni("rep_source_stock", "sourceStock")
rep_Log = LitDansFichierIni("rep_log", "log")
rep_source_Print = LitDansFichierIni("rep_source_print", "SourcePrint")
ConfirmPrint = LitDansFichierIni("rep_source_print", "ConfirmPrint")
NomFic = LitDansFichierIni("Nom Fichier", "NomFic")
NomFicStock = LitDansFichierIni("Nom FichierStock", "NomFicStock")
NomFicPrint = LitDansFichierIni("Nom FichierPrint", "NomFicPrint")
motPasse = LitDansFichierIni("password", "Password")
NumDay = LitDansFichierIni("LastDay", "LastDay")
NumDayClean = LitDansFichierIni("Daykeep", "Daykeep")
EnableBackUp = LitDansFichierIni("BackUp", "EnableBackup")
DiskUSB = LitDansFichierIni("BackUp", "DiskUSBKey")
FolderOfBackUp = LitDansFichierIni("BackUp", "FolderOfBackUp")
FileToBackUp = LitDansFichierIni("BackUp", "FileToBackUp")
BackUpDay = LitDansFichierIni("BackUp", "BackUpDay")
TpsBouSec = LitDansFichierIni("TpsBoucleSec", "TpsBoucleSec")
TpsBouSecPrint = LitDansFichierIni("TpsBoucleSecPrint", "TpsBoucleSecPrint")
'Réseaux
LocalAppli = LitDansFichierIni("ParamReseau", "LocalAppli")
IPInfo = LitDansFichierIni("ParamReseau", "IPInfo")
RepAbaco = LitDansFichierIni("ParamReseau", "RepAbaco")
FlagPass = LitDansFichierIni("ParamReseau", "FlagPassword")
UserName = LitDansFichierIni("ParamReseau", "UserName")
PassReseau = LitDansFichierIni("ParamReseau", "PassReseau")

End Function

Private Function LitDansFichierIni(Section As String, Cle As String, _
    Optional ValeurParDefaut As String = "") As String

Dim strReturn As String
Dim Fichier
DoEvents
Fichier = App.Path + "\preference.ini"
strReturn = String(255, 0)
GetPrivateProfileString Section, Cle, ValeurParDefaut, strReturn, Len(strReturn), Fichier
LitDansFichierIni = Left(strReturn, InStr(strReturn, Chr(0)) - 1)

End Function

Public Function Lecture(CodeFic)
' si CodeFic = 1 ------> traitement original
' si CodeFic = 2 ------> traitement impression
' si codefic = 3 ------> traitement stock

TotalArt = 0
TotalArtError = 0
FlagColor = 0

'Ouverture Read fichier Source
Open Fic For Binary As #1
Do While EOF(1) = False
    VidageVariable
    LectureLigne
    If Ligne = "" Then GoTo Fin
    Ligne = Replace(Ligne, "", " ")

    Select Case CodeFic
        Case 1
            If Mid(Ligne, 1, 1) = "E" Then GoTo Fin
            If Mid(Ligne, 1, 1) = "U" Then
                tab_remp() = Split(Ligne, ";")
                LongTab = UBound(tab_remp())
                If LongTab = 15 Then
                    If tab_remp(13) = "0" Then
                        If Replace(tab_remp(1), " ", "") = "" Then
                            EnvoiFicError
                        Else
                            If VersionAdapter = 0 Then TraitementFileSocamil
                            If VersionAdapter = 1 Then TraitementFileSocamaine
                            RemplissageTableau
                            EcritureFic
                            TotalArt = TotalArt + 1
                        End If
                    Else
                        EnvoiFicError
                    End If
                Else
                    EnvoiFicError
                End If
            End If
        Case 2
            If VersionAdapter = 0 Then TraitementVidageSocamil
            If VersionAdapter = 1 Then TraitementVidageSocamaine
            RemplissageTableau
            EcritureFic
            TotalArt = TotalArt + 1
        Case 3
        tab_remp() = Split(Ligne, ";")
        Dim r
        r = tab_remp(0)
        'CheckItemExist
        ItemExistDB = True
        tab_remplir(1) = tab_remp(0)
        If ItemExistDB = True Then
            If VersionAdapter = 0 Then TraitementFileStockSocamil
            If VersionAdapter = 1 Then TraitementFileStockSocamaine
            RemplissageTableau
            EcritureFic
            TotalArt = TotalArt + 1
        Else
            TotalArtError = TotalArtError + 1
        End If
    End Select
        
    'Affichage Temps Réel
    Frm_Main.LblAff.Caption = tab_remplir(1)
    Frm_Main.Lbl_Total.Caption = TotalArt
    Frm_Main.LblAff.Refresh
    Frm_Main.Lbl_Total.Refresh
    DoEvents
Loop
Fin:
'Affichage label
Frm_Main.LblAff.Caption = "  "
Frm_Main.LblAff.Refresh
Select Case CodeFic
    Case 1
        If FlagColor = 0 Then mesres = "Mise à jour caisses effectuée avec succès"
        If FlagColor = 1 Then mesres = "Mise à jour caisses effectuée avec succès, " & TotalArtError & " erreur, " + TotalArt + " ok"
        Message = rep + rep_message + NumFicOut + ".m1"
        Open Message For Output As #2
        Print #2, "UPDATE" + "," + NumFicOut + ",," + rep_InputPFI + "\data" + NumFicOut + ".i1," + rep_ResultPFI + "\result" + NumFicOut + ".r7"
    Case 2
        mesres = "Impression étiquettes effectuée avec succès"
        Message = rep + rep_message + NumFicOutPrint + ".m1"
        Open Message For Output As #2
        Print #2, "PRINT" + "," + NumFicOutPrint + ",," + rep_InputPFI + "\print" + NumFicOutPrint + ".i1," + rep_ResultPFI + "\print" + NumFicOutPrint + ".r7"
    Case 3
        If FlagColor = 0 Then mesres = "Mise à jour stock effectuée avec succès"
        If FlagColor = 1 Then mesres = "Mise à jour stock effectuée avec succès, " & TotalArtError & " inexistants, " + TotalArt + " ok"
        Message = rep + rep_message + NumFicOut + ".m1"
        Open Message For Output As #2
        Print #2, "UPDATE" + "," + NumFicOut + ",," + rep_InputPFI + "\data" + NumFicOut + ".i1," + rep_ResultPFI + "\result" + NumFicOut + ".r7"

End Select
    
Close #1, #2, #3, #4, #6
Frm_Main.EtatJour.AddItem (Etat + mesres)
Frm_Main.EtatJour.ListIndex = Frm_Main.EtatJour.ListCount - 1
OuvertureLog ("Debut suppression : " + Str(CodeFic))
Kill (Fic)
If CodeFic = 3 And VersionAdapter = 1 Then DelRcpCommand
OuvertureLog ("Fin suppression : " + Str(CodeFic))
If LocalAppli = 1 Then DeleteFunction Fso.GetFileName(Fic)
End Function

Public Function DeleteFunction(NameFic As String)
    Open App.Path & "\ftpdelete.txt" For Output As #123
    Print #123, "open " & IPInfo
    Print #123, UserName
    Print #123, PassReseau
    Print #123, "cd " & Trim(RepAbaco) & "\"
    Print #123, "delete " & NameFic
    Print #123, "quit"
    Close #123
    ExecCmd App.Path & "\delete.bat", , , vbHide
End Function
Public Function GetFunction()
    Open App.Path & "\ftpcommand.txt" For Output As #123
    Print #123, "open " & IPInfo
    Print #123, UserName
    Print #123, PassReseau
    Print #123, "lcd " & RepTemp
    Print #123, "cd " & Trim(RepAbaco) & "\"
    Print #123, "mget " + NomFic + "*"
    Print #123, "quit"
    Close #123
    ExecCmd App.Path & "\mget.bat", , , vbHide
End Function

Public Function AffichFin(CodeFic)

Frm_Main.Lbl_Total.Caption = TotalArt
If FlagColor = 0 Then CoulFeux ("green")
If FlagColor = 1 Then CoulFeux ("orange")
If FlagColor = 2 Then CoulFeux ("red")
       
Select Case CodeFic
    Case 1
        MajOk = MajOk + 1
        Frm_Main.Lbl_MajOk.Caption = MajOk
        MajTotal = MajTotal + 1
        Frm_Main.Lbl_MajTotal.Caption = MajTotal
    Case 2
        ImpOk = ImpOk + 1
        Frm_Main.Lbl_ImpOk.Caption = ImpOk
        ImpTotal = ImpTotal + 1
        Frm_Main.Lbl_ImpTotal.Caption = ImpTotal
End Select

OuvertureLog (mesres + " , " + TotalArt + " OK")
FlagColor = 0
    
End Function

Public Function CoulFeux(Couleur As String)
   Dim VbOrange As String
   VbOrange = &H80C0FF
   'Mise a Jour Rouge:Non Vert:Ok Orange:Pb 1 art.
    Frm_Main.feux(3).BackColor = Frm_Main.feux(2).BackColor
    Frm_Main.feux(2).BackColor = Frm_Main.feux(1).BackColor
    
    If Couleur = "red" Then Frm_Main.feux(1).BackColor = vbRed
    If Couleur = "green" Then Frm_Main.feux(1).BackColor = vbGreen
    If Couleur = "orange" Then Frm_Main.feux(1).BackColor = VbOrange
    
End Function
Public Function OuvertureLog(EcrLog As String)
'Ouverture Read/Write du fichier LOG
Date_Heure
Log = rep_Log + "\LogMaj.txt"
Open Log For Append As #5
Print #5, Etat + EcrLog
Close #5

End Function
Public Function Date_Heure()
'Récupération date et heure courante
    Etat = Format(Date, "dd/mm/yyyy") + "  " + Str(Time) + "  "

End Function

Public Function FindSav()
Dim FicSav1, FicSav2 As String
Dim NumSavTmp As String
'Boucle de recherche du numéro de création xx (sauvegarde)
NumSav = "01"
NumSavTmp = "01"
FicSav = rep_source + "\history" + "\01"
F = Fso.FileExists(FicSav)
FicSav1 = FicSav
Do While (F = True)
DoEvents
    NumSav = Format((NumSav + 1), "0#")
    FicSav2 = rep_source + "\history\" + NumSav
    F = Fso.FileExists(FicSav2)
    If F = True Then
        If FileDateTime(FicSav2) > FileDateTime(FicSav1) Then FicSav1 = FicSav2
        
        NumSavTmp = Mid(FicSav1, Len(FicSav1) - 1, 2)
        If NumSavTmp = "99" Then
            NumSavTmp = "01"
        Else
            NumSavTmp = Format((NumSavTmp + 1), "0#")
        End If

        If NumSav = "99" Then F = False
    Else
        NumSavTmp = NumSav
    End If
Loop

NumSav = NumSavTmp
FicSav = rep_source + "\history\" + NumSav

End Function

Public Function CreationHistory()

F = Fso.FolderExists(rep_source + "\history")
If F = False Then
    MkDir rep_source + "\history"
End If
RepHisto = rep_source + "\history"

F = Fso.FolderExists(rep_source + "\temporary")
If F = False Then
    MkDir rep_source + "\temporary"
End If
RepTemp = rep_source + "\temporary"

F = Fso.FolderExists(rep_source + "\erreur")
If F = False Then
    MkDir rep_source + "\erreur"
End If
RepFicError = rep_source + "\erreur"

End Function

Public Function SaveFic(CodeFic)

Select Case CodeFic
    Case 1
        F = Fso.FolderExists(FicSav)
        If F = True Then Kill FicSav
        FileCopy (rep_source + "\" + DirFic), FicSav
        OuvertureLog ("Sauvegarde de " + DirFic + " en " + FicSav)
    Case 2

    Case 3
        F = Fso.FolderExists(FicSav)
        If F = True Then Kill FicSav
        FileCopy (rep_source_Stock + "\Tmp_" + DirFic), FicSav
        OuvertureLog ("Sauvegarde de " + DirFic + " en " + FicSav)
End Select

End Function

Public Function choix_lect(RepSearch As String)

DirFic = Dir(RepSearch)
Do While DirFic$ <> ""
    OuvertureLog ("--------------------")
    OuvertureLog ("Attente Réception Fichier : " + DirFic)
    AttenteFinRecepFic
    DoEvents
    Select Case CodeFic
        Case 1
            FindSav
            FindData
        Case 2
            If ConfirmPrint = 1 Then
                Dim Confirm
                Confirm = MsgBox("Veuillez fermer l'application de vidage ?", vbOK + vbExclamation, "Confirmation")
                If Confirm <> vbOK Then GoTo EndChoixLect
            End If
            FindPrint
        Case 3
            RenameFileStock
            FindSav
            FindData
    End Select
    SaveFic (CodeFic)
    OuvertureLog ("Traitement Fichier : " + DirFic)
    If CodeFic = 3 Then
        If FileNotReady = True Then
            Lecture (CodeFic)
            AffichFin (CodeFic)
            DirFic$ = Dir
        Else
            OuvertureLog ("Fichier non libéré: " + DirFic)
            Frm_Main.EtatJour.AddItem ("Fichier non libéré: " + DirFic)
            Frm_Main.EtatJour.ListIndex = Frm_Main.EtatJour.ListCount - 1
        End If
    Else
        Lecture (CodeFic)
        AffichFin (CodeFic)
        DirFic$ = Dir
    End If
Loop

EndChoixLect:
End Function

Public Function RenameFileStock()
On Error Resume Next
FileNotReady = False
Fso.MoveFile (rep_source + "\" + DirFic), (rep_source + "\Tmp_" + DirFic)
FileNotReady = True
Fic = rep_source_Stock + "\Tmp_" + DirFic
End Function
Public Function Lecture_ini_Format()
'fonction servant a lire les differents parametre qui sont dans le
'fichier preference.ini tel que le repertoire ou se trouve pricer
PrefIni = CurDir
Open "preference.ini" For Input As #10
LigneForm = 0

Do While EOF(10) = False
    Line Input #10, LigneForm

    If LigneForm = "[Format_EEG]" Then
      If IsNumeric(Code_EEG) = False Then Code_EEG = "XXXXXX"
           Do While Code_EEG <> Code_Form_EEG
               Line Input #10, LigneForm
               Code_Form_EEG = Replace(Mid(LigneForm, 1, 6), " ", "")
               If Code_Form_EEG = "XXXXXX" Then Code_EEG = "XXXXXX"
               Form_EEG = Trim(Mid(LigneForm, 9))
           Loop
        Form_EEG = Trim(Mid(LigneForm, 9))
    End If
 
Loop

Close #10

End Function
Public Function Lecture_Rayon()
'fonction servant a lire les differents parametre qui sont dans le
'fichier preference.ini tel que le repertoire ou se trouve pricer
Dim r As Integer
PrefIni = CurDir
Open "Code_rayon.txt" For Input As #50
LigneRayon = ""
r = 1

Do While EOF(50) = False
    Line Input #50, LigneRayon
    tab_rayon() = Split(LigneRayon, "=")
    CodeRayon(r) = tab_rayon(0)
    NomRayon(r) = tab_rayon(1)
    r = r + 1
Loop

Close #50

End Function


Public Function Attendre(Intervalle As String, Indice As Integer) As Integer
Dim Valeur, tmp As String

    Valeur = Time
    tmp = DateAdd(Intervalle, Indice, Valeur)
    Do While Time < tmp
    Loop
    
End Function

Public Function CleanLog()
Dim DayLog As String
'Ouverture Read/Write du fichier LOG
Log = rep_Log + "\LogMaj.txt"
LogSav = rep_Log + "\LogMajSav.txt"

FileCopy (Log), LogSav
Kill (Log)
NumDate = Mid(Date - NumDayClean, 7, 4) + Mid(Date - NumDayClean, 4, 2) + Mid(Date - NumDayClean, 1, 2)
LigneLog = ""

Open Log For Output As #5
Open LogSav For Input As #6

Do While EOF(6) = False
    Line Input #6, LigneLog
    DayLog = Mid(LigneLog, 7, 4) + Mid(LigneLog, 4, 2) + Mid(LigneLog, 1, 2)
    If NumDate < DayLog Then Print #5, LigneLog
Loop

Close #5, #6
Kill (LogSav)
End Function

Public Function EnvoiFicError()
Dim FicError As String
    FicError = RepFicError + "\" + Replace(Date, "/", "") + ".err"
    Open FicError For Append As #8
    Print #8, Ligne
    Close #8
    FlagColor = 1
    Frm_Main.CmdFileError.BackColor = &HFF&
    TotalArtError = TotalArtError + 1
End Function

Public Function AttenteFinRecepFic()
    Taille_Fic = 0
    Taille_FicTot = 1
Select Case CodeFic
    Case 1
        'Fin de transmission fichier ????
        Do While Taille_Fic <> Taille_FicTot
            Taille_Fic = FileLen(rep_source + "\" + DirFic)
            DoEvents
            Call Sleep(2000)
            Taille_FicTot = FileLen(rep_source + "\" + DirFic)
        Loop
        Fic = rep_source + "\" + DirFic
    Case 2
        'Fin de transmission fichier ????
        Do While Taille_Fic <> Taille_FicTot
            Taille_Fic = FileLen(rep_source_Print + "\" + DirFic)
            DoEvents
            Call Sleep(2000)
            Taille_FicTot = FileLen(rep_source_Print + "\" + DirFic)
        Loop
        Fic = rep_source_Print + "\" + DirFic
    Case 3
        'Fin de transmission fichier ????
        Do While Taille_Fic <> Taille_FicTot
            Taille_Fic = FileLen(rep_source_Stock + "\" + DirFic)
            DoEvents
            Call Sleep(20000)
            Taille_FicTot = FileLen(rep_source_Stock + "\" + DirFic)
        Loop
        Fic = rep_source_Stock + "\" + DirFic
        
End Select
End Function

Public Function VidageVariable()
    'Vidage Tableau
    For i = 1 To 42
        tab_remplir(i) = ""
    Next i
    temp = ""
    Ligne = ""
End Function


Public Function LectureLigne()
Dim tampon As String * 1
Dim OctetLu As Byte

OctetSuivant:
    Get #1, , OctetLu
    If EOF(1) Then GoTo LigneComplete
    If OctetLu = 13 Then GoTo OctetSuivant
    If OctetLu = 10 Then GoTo LigneComplete
    
    If OctetLu < 32 Then
        tampon = " "
    Else
        tampon = Chr(OctetLu)
    End If
    Ligne = Ligne + tampon
    GoTo OctetSuivant
    
LigneComplete:
End Function

Public Function TraitementFileSocamil()
    tab_remplir(1) = tab_remp(1) 'Ean
    tab_remplir(2) = " 7 0 |" + Replace(tab_remp(2), "'", "`") 'Libel
    tab_remplir(3) = "| 23 0 |" + Trim(Str(Int(Replace(Mid(tab_remp(3), 1, 8), ".", "")))) 'Price Euro
    tab_remplir(4) = "| 47 0 |" + tab_remp(4) 'Code TVA
    tab_remplir(5) = "| 48 0 |" + Mid(tab_remp(5), 1, 1) 'Saisie Quantité Obligatoire
    tab_remplir(6) = "| 49 0 |" + Mid(tab_remp(5), 2, 1) 'Saisie prix de vente
    tab_remplir(7) = "| 50 0 |" + Mid(tab_remp(5), 3, 1) 'Article chaîné sur un autre
    tab_remplir(8) = "| 51 0 |" + tab_remp(6) 'Article consigné
    tab_remplir(9) = "| 52 0 |" + tab_remp(7) 'Orgine Price
    tab_remplir(10) = "| 53 0 |" + tab_remp(8) 'Article consigne
    tab_remplir(11) = "| 5 0 |" + tab_remp(9) 'Rayon
    tab_remplir(12) = "| 6 0 |" + tab_remp(10) 'Famille
    tab_remplir(13) = "| 3 0 |" + tab_remp(11) 'Sous-famille
    tab_remplir(14) = "| 45 0 |" + Trim(Str(Int(Replace(Mid(tab_remp(12), 1, 8), ".", "")))) 'Unit Price Euro
    tab_remplir(15) = "| 71 0 |" + Mid(tab_remp(12), 9, 1) 'Unit Code
    tab_remplir(16) = "| 54 0 |" + Mid(tab_remp(12), 10, 8) 'Ancien Prix avant promo
    tab_remplir(17) = "| 55 0 |" + Mid(tab_remp(12), 18, 1) 'Flag ancien prix promo
    tab_remplir(18) = "| 46 0 |" + Mid(tab_remp(12), 19, 8) 'Prix unitaire lot
    tab_remplir(19) = "| 37 0 |" + Mid(tab_remp(12), 27, 1) 'Promo Flag
    tab_remplir(20) = "| 12 0 |" + Trim(Mid(tab_remp(12), 29, 12)) 'Item size
    tab_remplir(21) = "| 35 0 |" + Trim(Str(Int(Replace(Mid(tab_remp(12), 41, 8), ".", "")))) 'DEEE
    tab_remplir(22) = "| 9 0 |" + Trim(Mid(tab_remp(12), 49, 24)) 'Supplier
    tab_remplir(23) = "| 57 0 |" + Mid(tab_remp(12), 73, 1) 'Marge Article
    tab_remplir(24) = "| 56 0 |" + Mid(tab_remp(12), 74, 30) + "|" 'FREE
End Function
Public Function RemplissageTableau()
    For i = 1 To 42
        temp = temp + tab_remplir(i)
    Next i
End Function

Public Function TraitementFileSocamaine()
Dim RayonName As String
    tab_remplir(1) = tab_remp(1) 'Ean
    tab_remplir(2) = " 7 0 |" + Replace(tab_remp(2), "'", "`") 'Libel
    tab_remplir(3) = "| 23 0 |" + Trim(Str(Int(Replace(Mid(tab_remp(3), 1, 8), ".", "")))) 'Price Euro
    tab_remplir(4) = "| 47 0 |" + tab_remp(4) 'Code TVA
    tab_remplir(5) = "| 48 0 |" + Mid(tab_remp(5), 1, 1) 'Saisie Quantité Obligatoire
    tab_remplir(6) = "| 49 0 |" + Mid(tab_remp(5), 2, 1) 'Saisie prix de vente
    tab_remplir(7) = "| 50 0 |" + Mid(tab_remp(5), 3, 1) 'Article chaîné sur un autre
    tab_remplir(8) = "| 51 0 |" + tab_remp(6) 'Article consigné
    tab_remplir(9) = "| 52 0 |" + tab_remp(7) 'Orgine Price
    tab_remplir(10) = "| 53 0 |" + tab_remp(8) 'Article consigne
    'Previous version
    'tab_remplir(11) = "| 5 0 |" + tab_remp(9) 'Rayon
    For i = 1 To UBound(CodeRayon())
        If Trim(tab_remp(9)) = CodeRayon(i) Then
            RayonName = NomRayon(i)
            GoTo EndRayon
        End If
    Next i
    
EndRayon:
    tab_remplir(11) = "| 5 0 |" + Trim(RayonName) 'Rayon
    tab_remplir(12) = "| 6 0 |" + tab_remp(10) 'Famille
    tab_remplir(13) = "| 3 0 |" + tab_remp(11) 'Sous-famille
    tab_remplir(14) = "| 45 0 |" + Trim(Str(Int(Replace(Mid(tab_remp(12), 1, 8), ".", "")))) 'Unit Price Euro
    tab_remplir(15) = "| 71 0 |" + Mid(tab_remp(12), 9, 1) 'Unit Code
    'IF flag = 1 show DEEE
    If Mid(tab_remp(12), 18, 1) = "1" Then
        tab_remplir(16) = "| 35 0 |" + Trim(Str(Int(Replace(Mid(tab_remp(12), 10, 8), ".", ""))))
    Else
        tab_remplir(16) = "| 35 0 |"
    End If
    tab_remplir(17) = "| 34 0 |" + Mid(tab_remp(12), 18, 1) 'FLAG_DEEE
    tab_remplir(18) = "| 46 0 |" + Mid(tab_remp(12), 19, 8) 'Prix unitaire lot
    tab_remplir(19) = "| 37 0 |" + Mid(tab_remp(12), 27, 1) 'Promo Flag
    tab_remplir(20) = "| 12 0 |" + Trim(Mid(tab_remp(12), 29, 12)) + "|" 'Item size
 
End Function

Public Function TraitementFileStockSocamil()

    tab_remplir(1) = tab_remp(0) 'Ean
    tab_remplir(2) = " 323 0 |" + Trim(Str(Int(tab_remp(1)))) 'Quantité en stock
    tab_remplir(3) = "| 325 0 |" + Trim(tab_remp(2)) 'Unité Stock
    tab_remplir(4) = "| 321 0 |" + Trim(tab_remp(3)) 'Date
    
    If Trim(tab_remp(4)) <> "" Then
        tab_remplir(5) = "| 320 0 |" + Trim(Str(Int(Replace(tab_remp(4), "-", "")))) 'Quantité Commandée
    Else
        tab_remplir(5) = "| 320 0 |" + Trim(tab_remp(4)) 'Quantité Commandée
    End If
    
    tab_remplir(6) = "| 326 0 |" + Trim(tab_remp(5)) 'Unité Commandée
    tab_remplir(7) = "| 327 0 |" + Trim(Str(Int(tab_remp(6)))) 'UVC par carton
    tab_remplir(8) = "| 322 0 |" + Trim(Str(Int(tab_remp(7)))) 'Quantité Vendue
    tab_remplir(9) = "| 328 0 |" + Trim(tab_remp(8)) 'Unité Quantité Vendue
    tab_remplir(10) = "| 4 0 |" + Trim(tab_remp(9)) 'Commandable
    tab_remplir(11) = "| 318 0 |" + Trim(Str(Int(tab_remp(10)))) + "|" 'Stock Optimal

End Function
Public Function TraitementFileStockSocamaine()

    tab_remplir(1) = tab_remp(2) 'Ean
    tab_remplir(2) = " 340 0 |" + Trim(tab_remp(7)) 'Nature du Produit
    tab_remplir(3) = "| 323 0 |" + Replace(Trim(Str(tab_remp(14))), ",", "") 'Quantité en Stock
    tab_remplir(4) = "| 325 0 |" + Trim(tab_remp(15)) 'Unité Quantité en stock
    tab_remplir(5) = "| 341 0 |" + Replace(Trim(tab_remp(18)), ",", "") 'En cours de commande
    tab_remplir(6) = "| 342 0 |" + Trim(tab_remp(19)) 'Unité de l'en cours de Commandée
    tab_remplir(7) = "| 321 0 |" + Trim(tab_remp(22)) 'Date Prochaine livraison
    tab_remplir(8) = "| 320 0 |" + Replace(Trim(tab_remp(23)), ",", "") 'Prochaine quantité livré
    tab_remplir(9) = "| 326 0 |" + Trim(tab_remp(24)) 'Unité Prochaine quantité livré
    tab_remplir(10) = "| 327 0 |" + Trim(Str(Int(tab_remp(25)))) 'UVC par carton
    tab_remplir(11) = "| 318 0 |" + Trim(Str(Int(tab_remp(26)))) 'Fond de rayon
    tab_remplir(12) = "| 343 0 |" + Trim(Str(Int(tab_remp(27)))) 'Nbr Jour réserve
    tab_remplir(13) = "| 344 0 |" + Replace(Trim(tab_remp(28)), ",", "") 'Qty de réserve
    tab_remplir(14) = "| 345 0 |" + Trim(tab_remp(29)) 'Unité Qty de réserve
    tab_remplir(15) = "| 4 0 |" + Trim(tab_remp(30)) + Trim(tab_remp(30)) 'Etat centrale + Etat magasin
    tab_remplir(16) = "| 346 0 |" + Trim(tab_remp(32)) 'Date de dernière vente
    tab_remplir(17) = "| 322 0 |" + Replace(Trim(tab_remp(33)), ",", "") 'Qty de dernière vente
    tab_remplir(18) = "| 328 0 |" + Trim(tab_remp(34))  'Unite de dernière vente
    'Add 2014-11-26 for Gestmag
    tab_remplir(19) = "| 400 0 |" + Trim(tab_remp(35))  'Numéro de pesé
    tab_remplir(20) = "| 401 0 |" + Replace(Trim(tab_remp(36)), "'", "`")  'Désignation affichette
    tab_remplir(21) = "| 402 0 |" + Trim(tab_remp(37))  'Provenance
    tab_remplir(22) = "| 403 0 |" + Trim(tab_remp(38))  'Catégorie
    tab_remplir(23) = "| 404 0 |" + Trim(tab_remp(39))  'Variété
    tab_remplir(24) = "| 405 0 |" + Trim(tab_remp(40))  'calibre
    tab_remplir(25) = "| 406 0 |" + Trim(tab_remp(41))  'Code Pays
    tab_remplir(26) = "| 407 0 |" + Trim(tab_remp(42))  'Libellé Pays
    tab_remplir(27) = "| 408 0 |" + Trim(tab_remp(43))  'Traitement
    tab_remplir(28) = "| 409 0 |" + Trim(tab_remp(44))  'Qty lot
    tab_remplir(29) = "| 410 0 |" + Trim(tab_remp(45))  'Contenance article
    tab_remplir(30) = "| 411 0 |" + Trim(tab_remp(46))  'Unité de contenance
    tab_remplir(31) = "| 412 0 |" + Trim(tab_remp(47))  'taille
    tab_remplir(32) = "| 413 0 |" + Trim(tab_remp(48))  'colori
    tab_remplir(33) = "| 414 0 |" + Trim(tab_remp(49))  'gondole
    tab_remplir(34) = "| 415 0 |" + Trim(tab_remp(50))  'élément
    tab_remplir(35) = "| 416 0 |" + Trim(tab_remp(51))  'niveau
    tab_remplir(36) = "| 417 0 |" + Trim(tab_remp(3))  'gondole
    tab_remplir(37) = "| 418 0 |" + Replace(Trim(tab_remp(11)), "'", "`")  'Libelle 2
    tab_remplir(38) = "| 419 0 |" + Replace(Trim(tab_remp(12)), "'", "`") + "|"  'Libelle 3

End Function

Public Function TraitementVidageSocamaine()
    Dim NbrCopies As String
    Code_EEG = 0
    Code_Form_EEG = 0
    GenCode = Mid(Ligne, 9, 13)
    Code_EEG = Mid(Ligne, 6, 3) + "000"
    NbrCopies = Mid(Ligne, 25, 1)
    If NbrCopies = "0" Then NbrCopies = "1"
    Lecture_ini_Format
    tab_remplir(1) = GenCode
    tab_remplir(2) = " 124 0 |" + Form_EEG
    tab_remplir(3) = "| 77 0 |" + NbrCopies + "|"
End Function

Public Function TraitementVidageSocamil()
    Code_EEG = 0
    Code_Form_EEG = 0
    GenCode = Mid(Ligne, 1, 13)
    Code_EEG = Replace(Mid(Ligne, 14), ".", "")
    Lecture_ini_Format
    tab_remplir(1) = GenCode
    tab_remplir(2) = " 124 0 |" + Form_EEG
    tab_remplir(3) = "| 77 0 |1|"
End Function

Public Function FindData()
Dim NomFicOut1, NomFicOut2 As String
Dim NumFicOutTmp As String
'Boucle de recherche du numéro de création data00xx.i1
NumFicOut = "0001"
NumFicOutTmp = "0001"
NomFicOut = rep + rep_input + "\data0001.i1"
F = Fso.FileExists(NomFicOut)
NomFicOut1 = NomFicOut
Do While (F = True)
    DoEvents
    NumFicOut = Format((NumFicOut + 1), "0###")
    
    NomFicOut2 = rep + rep_input + "\data" + NumFicOut + ".i1"
    F = Fso.FileExists(NomFicOut2)
    If F = True Then
        If FileDateTime(NomFicOut2) > FileDateTime(NomFicOut1) Then NomFicOut1 = NomFicOut2
        
        NumFicOutTmp = Mid(NomFicOut1, Len(NomFicOut1) - 6, 4)
        If NumFicOutTmp = "0099" Then
            NumFicOutTmp = "0001"
        Else
            NumFicOutTmp = Format((NumFicOutTmp + 1), "0###")
        End If

        If NumFicOut = "0099" Then F = False
    Else
        NumFicOutTmp = NumFicOut
    End If
Loop

NumFicOut = NumFicOutTmp
NomFicOut = rep + rep_input + "\data" + NumFicOut + ".i1"
F = Fso.FileExists(NomFicOut)
If F = True Then Kill (NomFicOut)

End Function

Public Function FindPrint()
Dim NomFicOutPrint1, NomFicOutPrint2 As String
Dim NumFicOutTmpPrint As String
'Boucle de recherche du numéro de création print00xx.i1
NumFicOutPrint = "0001"
NumFicOutTmpPrint = "0001"
NomFicOutPrint = rep + rep_input + "\print0001.i1"
F = Fso.FileExists(NomFicOutPrint)
NomFicOutPrint1 = NomFicOutPrint
Do While (F = True)
    DoEvents
    NumFicOutPrint = Format((NumFicOutPrint + 1), "0###")
    NomFicOutPrint2 = rep + rep_input + "\print" + NumFicOutPrint + ".i1"
    F = Fso.FileExists(NomFicOutPrint2)
    If F = True Then
        If FileDateTime(NomFicOutPrint2) > FileDateTime(NomFicOutPrint1) Then NomFicOutPrint1 = NomFicOutPrint2
        
        NumFicOutTmpPrint = Mid(NomFicOutPrint1, Len(NomFicOutPrint1) - 6, 4)
        If NumFicOutTmpPrint = "0099" Then
            NumFicOutTmpPrint = "0001"
        Else
            NumFicOutTmpPrint = Format((NumFicOutTmpPrint + 1), "0###")
        End If

        If NumFicOutPrint = "0099" Then F = False
    Else
        NumFicOutTmpPrint = NumFicOutPrint
    End If
Loop

NumFicOutPrint = NumFicOutTmpPrint
NomFicOutPrint = rep + rep_input + "\print" + NumFicOutPrint + ".i1"
F = Fso.FileExists(NomFicOutPrint)
If F = True Then Kill (NomFicOutPrint)


End Function

Public Function EcritureFic()

Select Case CodeFic
    Case 1
        'Ouverture Add du fichier Data
        Open NomFicOut For Append As #3
        Print #3, NumFicOut + " " + temp + ","
        Close #3
    Case 2
        'Ouverture Add du fichier Print
        Open NomFicOutPrint For Append As #4
        Print #4, NumFicOutPrint + " " + temp + ","
        Close #4
    Case 3
        'Ouverture Add du fichier Data
        Open NomFicOut For Append As #3
        Print #3, NumFicOut + " " + temp + ","
        Close #3
End Select

End Function

Public Function ExecCmd(ByRef vsCmdLine As String, Optional ByRef vsParameters As String, Optional ByRef vsCurrentDirectory As String = vbNullString, Optional ByVal vnShowCmd As Long = SW_SHOW, Optional ByVal vnTimeOut As Long = 200) As Long
    Dim lpShellExInfo As SHELLEXECUTEINFOA
    With lpShellExInfo
        .cbSize = Len(lpShellExInfo)
        .lpDirectory = vsCurrentDirectory
        .lpVerb = "open"
        .lpFile = vsCmdLine
        .lpParameters = vsParameters
        .nShow = vnShowCmd
        .fMask = SEE_MASK_DOENVSUBST Or SEE_MASK_NOCLOSEPROCESS Or SEE_MASK_IDLIST
    End With

    If ShellExecuteEx(lpShellExInfo) Then
        Do While WaitForSingleObject(lpShellExInfo.hProcess, vnTimeOut) = WAIT_TIMEOUT
            DoEvents
        Loop

        GetExitCodeProcess lpShellExInfo.hProcess, ExecCmd
        CloseHandle lpShellExInfo.hProcess
    Else
        ExecCmd = vbError
    End If
End Function

Public Function CreateBatFileFTP()
    'Creation delete bat file
    Open App.Path & "\delete.bat" For Output As #111
    Print #111, "ftp -s:" & App.Path & "\ftpdelete.txt -i"
    Print #111, "del " & App.Path & "\ftpdelete.txt"
    Close #111
    
    'Creation Get bat file
    Open App.Path & "\mget.bat" For Output As #112
    Print #112, "ftp -s:" & App.Path & "\ftpcommand.txt -i"
    Print #112, "move " & RepTemp & "\* " & rep_source
    Close #112
    
End Function
Public Function CheckItemExist()
    
    Dim SelectSQL As String
    Dim ItemTmp As String
    ItemExistDB = False
    
    Set MaConn = New ADODB.Connection
    MaConn.Open "DSN=myodbc"
    If VersionAdapter = 0 Then ItemTmp = tab_remp(0)
    If VersionAdapter = 1 Then ItemTmp = tab_remp(2)
    
    SelectSQL = "select ITEMID from ITEM where ITEMID=" + Chr(34) + ItemTmp + Chr(34) + ";"
           
    Set rstTable = New ADODB.Recordset
    rstTable.Open SelectSQL, MaConn
    If rstTable.EOF = False Then
        ItemExistDB = True
    Else
        ItemExistDB = False
    End If

    rstTable.Close
    DoEvents
    
End Function

Public Function CleanItemReplica()
    
    Dim SelectSQL As String
    Dim GetInfoDB As String
    Dim ReturnItemEEG As String
    Dim Tab_Price() As String
    Dim Tab_Ligne() As String
    Dim Ligne_DB As String
    Dim DateCleanItemReplica
    
    Set MaConn2 = New ADODB.Connection
    MaConn2.Open "DSN=myodbc"

 '   DateCleanItemReplica = (Year(Now - 2) & "-" & Month(Now - 2) & "-" & Day(Now - 2))

'    SelectSQL = "delete from ITEM_REPLICA where PFI_UPDATE_TIME < " & Chr(34) & DateCleanItemReplica & Chr(34) & ";"
    SelectSQL = "delete from ITEM_REPLICA;"
    Set rstTable2 = New ADODB.Recordset
    rstTable2.Open SelectSQL, MaConn2


End Function
Public Function GetRcpCommand()
    ExecCmd App.Path & "\Appel.bat", , , vbHide
End Function

Public Function DelRcpCommand()
    ExecCmd App.Path & "\Erase.bat", , , vbHide
End Function

