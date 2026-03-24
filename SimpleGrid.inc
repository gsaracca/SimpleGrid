!========================
! SimpleGrid.inc
!========================
  OMIT('_endOfInclude_', _SimpleGrid_ )
_SimpleGrid_  EQUATE(1)

    include( 'svapi.inc' ),once

SIMPLEGRID_USE_UNICODE       EQUATE(0)  ! set to 1 for UNICODE build
SG_ERROR                     EQUATE(-1)

WC_SIMPLEGRIDA               EQUATE('SimpleGridCtl')
WC_SIMPLEGRIDW               EQUATE('SimpleGridCtl')
WC_SIMPLEGRID                EQUATE('SimpleGridCtl')

SGHANDLE                     equate(UNSIGNED)
SGSTR                        equate(STRING)
SGWPARAM                     equate(UNSIGNED)
SGLPARAM                     equate(LONG)

SGCOLUMN        GROUP,TYPE
dwType              ULONG 
lpszHeader          SGLPARAM
pOptional           SGLPARAM  
                END

SGITEM          GROUP,TYPE
col                 LONG
row                 LONG
lpCurValue          SGLPARAM
                END

NMGRID          GROUP,TYPE
hdr                 like(NMHDR)
col                 LONG
row                 LONG
dwType              ULONG
                END

NMSGKEYDOWN     GROUP,TYPE
hdr                 like(NMHDR)
col                 LONG
row                 LONG
dwType              ULONG
wVKey               USHORT
                END 

NMSGFOCUS       GROUP,TYPE
hdr                 like(NMHDR)
col                 LONG
row                 LONG
dwType              ULONG
hFocus              SGHANDLE
                END

GCT_EDIT                    EQUATE(1)
GCT_COMBO                   EQUATE(2)
GCT_BUTTON                  EQUATE(3)
GCT_CHECK                   EQUATE(4)
GCT_LINK                    EQUATE(5)
GCT_IMAGE                   EQUATE(6)

GSO_ROWHEADER               EQUATE(1)
GSO_CELL                    EQUATE(2)
GSO_FULLROW                 EQUATE(3)

GSA_LEFT                    EQUATE(1)
GSA_GENERAL                 EQUATE(2)
GSA_RIGHT                   EQUATE(3)

SGN_SELCHANGE               EQUATE(0003h)
SGN_EDITBEGIN               EQUATE(0004h)
SGN_EDITEND                 EQUATE(0005h)
SGN_KEYDOWN                 EQUATE(0006h)
SGN_GOTFOCUS                EQUATE(0012h)
SGN_LOSTFOCUS               EQUATE(0013h)
SGN_ITEMCLICK               EQUATE(0015h)
SGN_HEADERCLICK             EQUATE(0016h)  ! Click en encabezado de columna (col=0-based, row=-1)

SG_ADDCOLUMN                EQUATE(WM_USER + 001h)
SG_ADDROW                   EQUATE(WM_USER + 002h)
SG_ENABLEEDIT               EQUATE(WM_USER + 003h)
SG_EXTENDLASTCOLUMN         EQUATE(WM_USER + 004h)
SG_GETCOLCOUNT              EQUATE(WM_USER + 005h)
SG_GETCOLUMNHEADERTEXT      EQUATE(WM_USER + 006h)
SG_GETCOLUMNHEADERTEXTLENGTH EQUATE(WM_USER + 007h)
SG_GETCOLUMNTYPE             EQUATE(WM_USER + 008h)
SG_GETCOLWIDTH              EQUATE(WM_USER + 009h)
SG_GETCURSORCOL             EQUATE(WM_USER + 00Ah)
SG_GETCURSORROW             EQUATE(WM_USER + 00Bh)
SG_GETHEADERROWHEIGHT       EQUATE(WM_USER + 00Ch)
SG_GETIMAGELIST             EQUATE(WM_USER + 00Dh)
SG_GETITEMDATA              EQUATE(WM_USER + 00Eh)
SG_GETITEMDATALENGTH        EQUATE(WM_USER + 00Fh)
SG_GETITEMPROTECTION        EQUATE(WM_USER + 010h)
SG_GETROWCOUNT              EQUATE(WM_USER + 011h)
SG_GETROWHEADERTEXT         EQUATE(WM_USER + 012h)
SG_GETROWHEADERTEXTLENGTH   EQUATE(WM_USER + 013h)
SG_GETROWHEIGHT             EQUATE(WM_USER + 014h)
SG_REFRESHGRID              EQUATE(WM_USER + 015h)
SG_RESETCONTENT             EQUATE(WM_USER + 016h)
SG_SELECTCELL               EQUATE(WM_USER + 017h)
SG_SETALLOWCOLRESIZE        EQUATE(WM_USER + 018h)
SG_SETCOLAUTOWIDTH          EQUATE(WM_USER + 019h)
SG_SETCOLSNUMBERED          EQUATE(WM_USER + 01Ah)
SG_SETCOLUMNHEADERTEXT      EQUATE(WM_USER + 01Bh)
SG_SETCOLWIDTH              EQUATE(WM_USER + 01Ch)
SG_SETCURSORPOS             EQUATE(WM_USER + 01Dh)
SG_SETDOUBLEBUFFER          EQUATE(WM_USER + 01Eh)
SG_SETELLIPSIS              EQUATE(WM_USER + 01Fh)
SG_SETGRIDLINECOLOR         EQUATE(WM_USER + 020h)
SG_SETHEADERROWHEIGHT       EQUATE(WM_USER + 021h)
SG_SETHEADINGFONT           EQUATE(WM_USER + 022h)
SG_SETHILIGHTCOLOR          EQUATE(WM_USER + 023h)
SG_SETHILIGHTTEXTCOLOR      EQUATE(WM_USER + 024h)
SG_SETIMAGELIST             EQUATE(WM_USER + 025h)
SG_SETITEMDATA              EQUATE(WM_USER + 026h)
SG_SETITEMTEXTALIGNMENT     EQUATE(WM_USER + 027h)
SG_SETITEMPROTECTION        EQUATE(WM_USER + 028h)
SG_SETPROTECTCOLOR          EQUATE(WM_USER + 029h)
SG_SETROWHEADERTEXT         EQUATE(WM_USER + 02Ah)
SG_SETROWHEADERWIDTH        EQUATE(WM_USER + 02Bh)
SG_SETROWHEIGHT             EQUATE(WM_USER + 02Ch)
SG_SETROWSNUMBERED          EQUATE(WM_USER + 02Dh)
SG_SETSELECTIONMODE         EQUATE(WM_USER + 02Eh)
SG_SETTITLEFONT             EQUATE(WM_USER + 02Fh)
SG_SETTITLEHEIGHT           EQUATE(WM_USER + 030h)
SG_SHOWINTEGRALROWS         EQUATE(WM_USER + 031h)
SG_RIGHTJUSTIFYNUMERICS     EQUATE(WM_USER + 032h)
SG_INSERTROW                EQUATE(WM_USER + 033h)
SG_DELETEROW                EQUATE(WM_USER + 034h)
SG_SETSORTCOLUMN            EQUATE(WM_USER + 035h)  ! Marcar columna con flecha de sort nativa

! -------------------------------------------------------
! Constantes para carga rápida (BeginLoad / EndLoad)
! -------------------------------------------------------
WM_SETREDRAW                EQUATE(00Bh)

! -------------------------------------------------------
! Constantes de dirección de ordenamiento (SetColumnSortMark)
! -------------------------------------------------------
SGS_NONE                    EQUATE(0)   ! Sin marca de sort
SGS_ASC                     EQUATE(1)   ! Orden ascendente  ( ^)
SGS_DESC                    EQUATE(2)   ! Orden descendente ( v)

    map
        module('USER32.DLL')
            SendMessageA(SGHANDLE hWnd, UNSIGNED Msg, SGWPARAM wParam, SGLPARAM lParam),SGLPARAM,RAW,NAME('SendMessageA')
            SendMessageW(SGHANDLE hWnd, UNSIGNED Msg, SGWPARAM wParam, SGLPARAM lParam),SGLPARAM,RAW,NAME('SendMessageW')
            GetWindowTextA(SGHANDLE hWnd, *SGSTR lpString, LONG cchMax),LONG,RAW,NAME('GetWindowTextA')
            GetWindowTextW(SGHANDLE hWnd, *SGSTR lpString, LONG cchMax),LONG,RAW,NAME('GetWindowTextW')
            GetWindowTextLengthA(SGHANDLE hWnd),LONG,RAW,NAME('GetWindowTextLengthA')
            GetWindowTextLengthW(SGHANDLE hWnd),LONG,RAW,NAME('GetWindowTextLengthW')
            SetWindowTextA(SGHANDLE hWnd, *SGSTR lpString),LONG,RAW,NAME('SetWindowTextA')
            SetWindowTextW(SGHANDLE hWnd, *SGSTR lpString),LONG,RAW,NAME('SetWindowTextW')
            EnableWindow(SGHANDLE hWnd, LONG fEnable),LONG,RAW,NAME('EnableWindow')
            InvalidateRect(SGHANDLE hWnd, LONG lpRect, LONG bErase),LONG,RAW,NAME('InvalidateRect')
            UpdateWindow(SGHANDLE hWnd),LONG,RAW,NAME('UpdateWindow')
        end
        module( 'SimpleGrid.clw' )
            SimpleGrid_SendMessage(SGHANDLE hWnd, UNSIGNED Msg, SGWPARAM wParam, SGLPARAM lParam),SGLPARAM
            SimpleGrid_AddColumn(SGHANDLE hGrid, *SGCOLUMN pCol),LONG,proc
            SimpleGrid_AddRow(SGHANDLE hGrid, SGSTR header),LONG,proc
            SimpleGrid_AddRowData(SGHANDLE hGrid, *SGSTR header, ULONG alignment, LONG[] data, LONG count),LONG
            SimpleGrid_EnableEdit(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_ExtendLastColumn(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_GetColCount(SGHANDLE hGrid),LONG
            SimpleGrid_GetColumnHeaderText(SGHANDLE hGrid, LONG iCol, *SGSTR buf),LONG
            SimpleGrid_GetColumnHeaderTextLen(SGHANDLE hGrid, LONG iCol),LONG
            SimpleGrid_GetColumnType(SGHANDLE hGrid, LONG iCol),LONG
            SimpleGrid_GetColWidth(SGHANDLE hGrid, LONG iCol),LONG
            SimpleGrid_GetCursorCol(SGHANDLE hGrid),LONG
            SimpleGrid_GetCursorRow(SGHANDLE hGrid),LONG
            SimpleGrid_GetHeaderRowHeight(SGHANDLE hGrid),LONG
            SimpleGrid_GetImageColumnImageList(SGHANDLE hGrid, LONG iCol),SGLPARAM
            SimpleGrid_GetItemData(SGHANDLE hGrid, *SGITEM pItem),LONG
            SimpleGrid_GetItemText(SGHANDLE hGrid, LONG iCol, LONG iRow, *SGSTR text),LONG,proc
            SimpleGrid_GetItemDataLen(SGHANDLE hGrid, LONG iCol, LONG iRow),LONG
            SimpleGrid_GetItemProtection(SGHANDLE hGrid, LONG iCol, LONG iRow),LONG
            SimpleGrid_GetRowCount(SGHANDLE hGrid),LONG
            SimpleGrid_GetRowHeaderText(SGHANDLE hGrid, LONG iRow, *SGSTR buf),LONG
            SimpleGrid_GetRowHeaderTextLen(SGHANDLE hGrid, LONG iRow),LONG
            SimpleGrid_GetRowHeight(SGHANDLE hGrid),LONG
            SimpleGrid_GetTitle(SGHANDLE hGrid, *SGSTR buf, LONG cchMax),LONG
            SimpleGrid_GetTitleLength(SGHANDLE hGrid),LONG
            SimpleGrid_RefreshGrid(SGHANDLE hGrid),LONG
            SimpleGrid_ResetContent(SGHANDLE hGrid),LONG
            SimpleGrid_SelectCell(SGHANDLE hGrid, LONG iCol, LONG iRow, LONG overwriteMode),LONG
            SimpleGrid_SetAllowColResize(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_SetColAutoWidth(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_SetColsNumbered(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_SetColumnHeaderText(SGHANDLE hGrid, LONG iCol, *SGSTR text),LONG
            SimpleGrid_SetColWidth(SGHANDLE hGrid, LONG iCol, LONG nWidth),LONG
            SimpleGrid_SetCursorPos(SGHANDLE hGrid, LONG iCol, LONG iRow),LONG
            SimpleGrid_SetDoubleBuffer(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_SetEllipsis(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_SetGridLineColor(SGHANDLE hGrid, ULONG clr),LONG
            SimpleGrid_SetHeaderRowHeight(SGHANDLE hGrid, LONG height),LONG
            SimpleGrid_SetHeadingFont(SGHANDLE hGrid, SGHANDLE hFont),LONG
            SimpleGrid_SetHilightColor(SGHANDLE hGrid, ULONG clr),LONG
            SimpleGrid_SetHilightTextColor(SGHANDLE hGrid, ULONG clr),LONG
            SimpleGrid_SetImageColumnImageList(SGHANDLE hGrid, LONG iCol, SGHANDLE himl),SGLPARAM
            SimpleGrid_SetItemData(SGHANDLE hGrid, *SGITEM pItem),LONG
            SimpleGrid_SetItemText(SGHANDLE hGrid, LONG iCol, LONG iRow, SGSTR text),LONG,proc
            SimpleGrid_SetItemTextAlignment(SGHANDLE hGrid, *SGITEM pItem, ULONG align),LONG,proc
            SimpleGrid_SetItemTextAlignmentEx(SGHANDLE hGrid, LONG iCol, LONG iRow, ULONG align),LONG,proc
            SimpleGrid_SetItemProtection(SGHANDLE hGrid, *SGITEM pItem, LONG fSet),LONG
            SimpleGrid_SetItemProtectionEx(SGHANDLE hGrid, LONG iCol, LONG iRow, LONG fSet),LONG
            SimpleGrid_SetProtectColor(SGHANDLE hGrid, ULONG clr),LONG
            SimpleGrid_SetRowHeaderText(SGHANDLE hGrid, LONG iRow, *SGSTR text),LONG
            SimpleGrid_SetRowHeaderWidth(SGHANDLE hGrid, LONG nWidth),LONG
            SimpleGrid_SetRowHeight(SGHANDLE hGrid, LONG height),LONG
            SimpleGrid_SetRowsNumbered(SGHANDLE hGrid, LONG fSet),LONG
            SimpleGrid_SetSelectionMode(SGHANDLE hGrid, LONG mode),LONG
            SimpleGrid_SetTitle(SGHANDLE hGrid, *SGSTR text),LONG
            SimpleGrid_SetTitleFont(SGHANDLE hGrid, SGHANDLE hFont),LONG
            SimpleGrid_SetTitleHeight(SGHANDLE hGrid, LONG height),LONG
            SimpleGrid_ShowIntegralRows(SGHANDLE hGrid, LONG fShow),LONG
            SimpleGrid_InsertRow(SGHANDLE hGrid, LONG position, *SGSTR header),LONG
            SimpleGrid_DeleteRow(SGHANDLE hGrid, LONG position),LONG
            SimpleGrid_Enable(SGHANDLE hGrid, LONG fEnable),LONG
            ! --- Helpers para flujo Queue → Grid ---
            SimpleGrid_BeginLoad(SGHANDLE hGrid),LONG
            SimpleGrid_EndLoad(SGHANDLE hGrid),LONG
            SimpleGrid_GetQueueRow(SGHANDLE hGrid),LONG
            SimpleGrid_SetColumnSortMark(SGHANDLE hGrid, LONG iCol, LONG direction, SGSTR baseText),LONG
            SimpleGrid_SetSortColumn(SGHANDLE hGrid, LONG iCol, LONG direction),LONG
        end
    end

_endOfInclude_