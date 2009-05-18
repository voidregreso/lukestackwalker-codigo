; Script generated by the HM NIS Edit Script Wizard.


!searchparse /file lukesw-version.h `#define STRINGVERSION "` VER_MAJOR `.` VER_MINOR `.` VER_BUGFIX `"`

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Luke Stackwalker"
!define PRODUCT_VERSION "${VER_MAJOR}.${VER_MINOR}.${VER_BUGFIX}"
!define PRODUCT_PUBLISHER "Sami Sallinen."
!define PRODUCT_WEB_SITE "http://lukestackwalker.sourceforge.net/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\luke_sw.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "bitmaps\installer.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "license.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\luke_sw.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "LukeStackWalkerSetup-${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\Luke Stackwalker"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "luke_sw.exe"
  CreateDirectory "$SMPROGRAMS\Luke Stackwalker"
  CreateShortCut "$SMPROGRAMS\Luke Stackwalker\Luke Stackwalker.lnk" "$INSTDIR\luke_sw.exe"
  CreateShortCut "$DESKTOP\Luke Stackwalker.lnk" "$INSTDIR\luke_sw.exe"
  File "srcsrv.dll"
  File "symsrv.dll"
  File "gvc.dll"
  File "pathplan.dll"
  File "graph.dll"
  File "cdt.dll"
  File "libexpat.dll"
  File "zlib1.dll"
  File "ltdl.dll"
  File "gvplugin_pango.dll"
  File "libcairo-2.dll"
  File "libfontconfig-1.dll"
  File "libfreetype-6.dll"
  File "libxml2.dll"
  File "iconv.dll"
  File "libpng12.dll"
  File "libpango-1.0-0.dll"
  File "libglib-2.0-0.dll"
  File "intl.dll"
  File "libgmodule-2.0-0.dll"
  File "libgobject-2.0-0.dll"
  File "libpangocairo-1.0-0.dll"
  File "libpangoft2-1.0-0.dll"
  File "libpangowin32-1.0-0.dll"
  File "gvplugin_dot_layout.dll"
  File "gvplugin_core.dll"
  File "dbghelp.dll"
  File "config"
  File "props.txt"
  File "bitmaps\lsp.ico"
  File "bitmaps\lsd.ico"
  File "manual\luke stackwalker manual.pdf"
  File "relnotes.txt"
  File "vcredist_x86.exe"

SectionEnd

Function RefreshShellIcons
  !define SHCNE_ASSOCCHANGED 0x08000000
  !define SHCNF_IDLIST 0
  System::Call 'shell32.dll::SHChangeNotify(i, i, i, i) v (${SHCNE_ASSOCCHANGED}, ${SHCNF_IDLIST}, 0, 0)'
FunctionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Luke Stackwalker\Luke Stackwalker Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Luke Stackwalker\Uninstall.lnk" "$INSTDIR\uninst.exe"
  CreateShortCut "$SMPROGRAMS\Luke Stackwalker\Luke Stackwalker Manual.lnk" "$INSTDIR\luke stackwalker manual.pdf"
  
  WriteRegStr HKCR ".lsp" "" "LukeStackwalker.Project"
  WriteRegStr HKCR ".lsd" "" "LukeStackwalker.Data"
  WriteRegStr HKCR "LukeStackwalker.Project" ""  "Luke Stackwalker project settings"
  WriteRegStr HKCR "LukeStackwalker.Project\DefaultIcon" ""  "$INSTDIR\lsp.ico"

  WriteRegStr HKCR "LukeStackwalker.Data" ""  "Luke Stackwalker profile data"
  WriteRegStr HKCR "LukeStackwalker.Data\DefaultIcon" ""  "$INSTDIR\lsd.ico"

  WriteRegStr HKCR "LukeStackwalker.Project\shell\open\command" "" '"$INSTDIR\luke_sw.exe" "%1"'
  WriteRegStr HKCR "LukeStackwalker.Data\shell\open\command" "" '"$INSTDIR\luke_sw.exe" "%1"'

  Call RefreshShellIcons

  
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\luke_sw.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\luke_sw.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  ExecWait "$INSTDIR\vcredist_x86.exe"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "Luke Stackwalker was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove Luke Stackwalker and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\symsrv.dll"
  Delete "$INSTDIR\srcsrv.dll"
  Delete "$INSTDIR\luke_sw.exe"
  Delete "$INSTDIR\gvc.dll"
  Delete "$INSTDIR\pathplan.dll"
  Delete "$INSTDIR\graph.dll"
  Delete "$INSTDIR\cdt.dll"
  Delete "$INSTDIR\libexpat.dll"
  Delete "$INSTDIR\zlib1.dll"
  Delete "$INSTDIR\ltdl.dll"
  Delete "$INSTDIR\gvplugin_pango.dll"
  Delete "$INSTDIR\libcairo-2.dll"
  Delete "$INSTDIR\libfontconfig-1.dll"
  Delete "$INSTDIR\libfreetype-6.dll"
  Delete "$INSTDIR\libxml2.dll"
  Delete "$INSTDIR\iconv.dll"
  Delete "$INSTDIR\libpng12.dll"
  Delete "$INSTDIR\libpango-1.0-0.dll"
  Delete "$INSTDIR\libglib-2.0-0.dll"
  Delete "$INSTDIR\intl.dll"
  Delete "$INSTDIR\libgmodule-2.0-0.dll"
  Delete "$INSTDIR\libgobject-2.0-0.dll"
  Delete "$INSTDIR\libpangocairo-1.0-0.dll"
  Delete "$INSTDIR\libpangoft2-1.0-0.dll"
  Delete "$INSTDIR\libpangowin32-1.0-0.dll"
  Delete "$INSTDIR\gvplugin_dot_layout.dll"
  Delete "$INSTDIR\gvplugin_core.dll"
  Delete "$INSTDIR\dbghelp.dll"
  Delete "$INSTDIR\symsrv.yes"
  Delete "$INSTDIR\config"
  Delete "$INSTDIR\props.txt"
  Delete "$INSTDIR\msvcr80.dll"
  Delete "$INSTDIR\msvcp80.dll"
  Delete "$INSTDIR\x86_Microsoft.VC80.CRT_1fc8b3b9a1e18e3b_8.0.50727.3053_x-ww_b80fa8ca.manifest"
  Delete "$INSTDIR\lsp.ico"
  Delete "$INSTDIR\lsd.ico"
  Delete "$INSTDIR\luke stackwalker manual.pdf"
  Delete "$INSTDIR\relnotes.txt"
  Delete "$INSTDIR\vcredist_x86.exe"



  Delete "$SMPROGRAMS\Luke Stackwalker\Uninstall.lnk"
  Delete "$SMPROGRAMS\Luke Stackwalker\Luke Stackwalker Website.lnk"
  Delete "$SMPROGRAMS\Luke Stackwalker\Luke Stackwalker.lnk"
  Delete "$SMPROGRAMS\Luke Stackwalker\Luke Stackwalker Manual.lnk"

  Delete "$DESKTOP\Luke Stackwalker.lnk"

  RMDir "$SMPROGRAMS\Luke Stackwalker"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd