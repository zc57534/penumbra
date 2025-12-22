!include MUI2.nsh

!define PRODUCT_NAME "Penumbra WinUSB drivers installer"
!define PRODUCT_DESCRIPTION "Installs WinUSB drivers for various devices, for use with Penumbra."
!define PRODUCT_VERSION "1.0.0.0"

name "${PRODUCT_NAME}"
OutFile "PenumbraDrivers.exe"
RequestExecutionLevel admin

VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion" "${PRODUCT_VERSION}"
VIAddVersionKey "FileDescription" "${PRODUCT_DESCRIPTION}"


!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Section "Install WinUSB Drivers" SecInstall
  SetOutPath "$TEMP\PenumbraWinUSB"
  File "wdi-simple.exe"

  DetailPrint "Installing WinUSB drivers..."

  ; MediaTek
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0E8D -p 0x0003 -t 0 -n "MediaTek USB Port (BROM)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0E8D -p 0x6000 -t 0 -n "MediaTek USB Port (Preloader)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0E8D -p 0x2000 -t 0 -n "MediaTek USB Port (Preloader)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0E8D -p 0x2001 -t 0 -n "MediaTek USB Port (DA)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0E8D -p 0x20FF -t 0 -n "MediaTek USB Port (Preloader)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0E8D -p 0x3000 -t 0 -n "MediaTek USB Port (Preloader)"'

  ; LG
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x1004 -p 0x6000 -t 0 -n "LG USB Port (Preloader)"'

  ; OPPO
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x22D9 -p 0x0006 -t 0 -n "OPPO USB Port (Preloader)"'

  ; Sony
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0FCE -p 0xF200 -t 0 -n "Sony USB Port (BROM)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0FCE -p 0xD1E9 -t 0 -n "Sony XA1 USB Port (BROM)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0FCE -p 0xD1E2 -t 0 -n "Sony USB Port (BROM)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0FCE -p 0xD1EC -t 0 -n "Sony L1 USB Port (BROM)"'
  nsExec::ExecToLog '"$TEMP\PenumbraWinUSB\wdi-simple.exe" -v 0x0FCE -p 0xD1DD -t 0 -n "Sony F3111 USB Port (BROM)"'

  MessageBox MB_OK "WinUSB driver installation finished."

  RMDir /r "$TEMP\PenumbraWinUSB"
SectionEnd
