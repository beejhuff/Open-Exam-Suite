; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Open Exam Suite"
!define PRODUCT_VERSION "3.1.2"
!define PRODUCT_PUBLISHER "Bolorunduro Winner-Timothy"
!define PRODUCT_WEB_SITE "http://www.github.com/bolorundurowb/Open-Exam-Suite"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Creator.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "FileAssociation.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "LICENSE"
; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\Simulator.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "OES-Setup.exe"
InstallDir "$PROGRAMFILES\Open Exam Suite"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "Creator" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "Creator\bin\Release\Shared.dll"
  File "Creator\bin\Release\Newtonsoft.Json.dll"
  File "Creator\bin\Release\Creator.exe"
  CreateDirectory "$SMPROGRAMS\Open Exam Suite"
  CreateShortCut "$SMPROGRAMS\Open Exam Suite\Creator.lnk" "$INSTDIR\Creator.exe"
  CreateShortCut "$DESKTOP\Creator.lnk" "$INSTDIR\Creator.exe"
SectionEnd

Section "Simulator" SEC02
  File "Simulator\bin\Release\Simulator.exe"
  CreateShortCut "$SMPROGRAMS\Open Exam Suite\Simulator.lnk" "$INSTDIR\Simulator.exe"
  CreateShortCut "$DESKTOP\Simulator.lnk" "$INSTDIR\Simulator.exe"
  File "Simulator\bin\Release\Shared.dll"
  ${registerExtension} "$INSTDIR\Simulator.exe" ".oef" "Open Exam Files"
SectionEnd

Section "Samples" SEC03
  File "OEF Files\GMAT Sample.oef"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Open Exam Suite\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Open Exam Suite\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Creator.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Creator.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} ""
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} ""
!insertmacro MUI_FUNCTION_DESCRIPTION_END


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\GMAT Sample.oef"
  Delete "$INSTDIR\Shared.dll"
  Delete "$INSTDIR\Simulator.exe"
  Delete "$INSTDIR\Creator.exe"
  Delete "$INSTDIR\Shared.dll"
  Delete "$INSTDIR\Newtonsoft.Json.dll"

  Delete "$SMPROGRAMS\Open Exam Suite\Uninstall.lnk"
  Delete "$SMPROGRAMS\Open Exam Suite\Website.lnk"
  Delete "$DESKTOP\Simulator.lnk"
  Delete "$SMPROGRAMS\Open Exam Suite\Simulator.lnk"
  Delete "$DESKTOP\Creator.lnk"
  Delete "$SMPROGRAMS\Open Exam Suite\Creator.lnk"

  RMDir "$SMPROGRAMS\Open Exam Suite"
  RMDir "$INSTDIR"

  ${unregisterExtension} ".oef" "Open Exam Files"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd