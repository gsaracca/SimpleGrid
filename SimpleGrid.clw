    MEMBER()  ! replace with your APP CLW file name
    
    INCLUDE('SimpleGrid.inc'),ONCE
    
SimpleGrid_SendMessage PROCEDURE(SGHANDLE hWnd, UNSIGNED Msg1, SGWPARAM wParam, SGLPARAM lParam)!,SGLPARAM
  CODE
  IF SIMPLEGRID_USE_UNICODE
    RETURN SendMessageW(hWnd, Msg1, wParam, lParam)
  ELSE
    RETURN SendMessageA(hWnd, Msg1, wParam, lParam)
  END

SimpleGrid_AddColumn PROCEDURE(SGHANDLE hGrid, *SGCOLUMN pCol)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_ADDCOLUMN, 0, ADDRESS(pCol))

SimpleGrid_AddRow PROCEDURE(SGHANDLE hGrid, SGSTR header)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_ADDROW, 0, ADDRESS(header))

SimpleGrid_AddRowData PROCEDURE(SGHANDLE hGrid, *SGSTR header, ULONG alignment, LONG[] data, LONG count)!,LONG
sgi     like(SGITEM)
i       LONG
row     LONG
  CODE
  row = SimpleGrid_AddRow(hGrid, header)
  IF row = SG_ERROR
    RETURN SG_ERROR
  END
  LOOP i = 1 TO count
    sgi.col = i - 1
    sgi.row = row
    sgi.lpCurValue = data[i]
    IF SimpleGrid_SetItemData(hGrid, sgi) = SG_ERROR
      BREAK
    END
    SimpleGrid_SetItemTextAlignment(hGrid, sgi, alignment)
  END
  RETURN row

SimpleGrid_EnableEdit PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_ENABLEEDIT, fSet, 0)

SimpleGrid_ExtendLastColumn PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_EXTENDLASTCOLUMN, fSet, 0)

SimpleGrid_GetColCount PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETCOLCOUNT, 0, 0)

SimpleGrid_GetColumnHeaderText PROCEDURE(SGHANDLE hGrid, LONG iCol, *SGSTR buf)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETCOLUMNHEADERTEXT, iCol, ADDRESS(buf))

SimpleGrid_GetColumnHeaderTextLen PROCEDURE(SGHANDLE hGrid, LONG iCol)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETCOLUMNHEADERTEXTLENGTH, iCol, 0)

SimpleGrid_GetColumnType PROCEDURE(SGHANDLE hGrid, LONG iCol)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETCOLUMNTYPE, iCol, 0)

SimpleGrid_GetColWidth PROCEDURE(SGHANDLE hGrid, LONG iCol)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETCOLWIDTH, iCol, 0)

SimpleGrid_GetCursorCol PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETCURSORCOL, 0, 0)

SimpleGrid_GetCursorRow PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETCURSORROW, 0, 0)

SimpleGrid_GetHeaderRowHeight PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETHEADERROWHEIGHT, 0, 0)

SimpleGrid_GetImageColumnImageList PROCEDURE(SGHANDLE hGrid, LONG iCol)!,SGLPARAM
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETIMAGELIST, iCol, 0)

SimpleGrid_GetItemData PROCEDURE(SGHANDLE hGrid, *SGITEM pItem)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETITEMDATA, 0, ADDRESS(pItem))

SimpleGrid_GetItemText PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow, *SGSTR text)!,LONG
sgi like(SGITEM)
  CODE
  sgi.col = iCol
  sgi.row = iRow
  sgi.lpCurValue = ADDRESS(text)
  RETURN SimpleGrid_GetItemData(hGrid, sgi)

SimpleGrid_GetItemDataLen PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETITEMDATALENGTH, iCol, iRow)

SimpleGrid_GetItemProtection PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETITEMPROTECTION, iCol, iRow)

SimpleGrid_GetRowCount PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETROWCOUNT, 0, 0)

SimpleGrid_GetRowHeaderText PROCEDURE(SGHANDLE hGrid, LONG iRow, *SGSTR buf)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETROWHEADERTEXT, iRow, ADDRESS(buf))

SimpleGrid_GetRowHeaderTextLen PROCEDURE(SGHANDLE hGrid, LONG iRow)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETROWHEADERTEXTLENGTH, iRow, 0)

SimpleGrid_GetRowHeight PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_GETROWHEIGHT, 0, 0)

SimpleGrid_GetTitle PROCEDURE(SGHANDLE hGrid, *SGSTR buf, LONG cchMax)!,LONG
  CODE
  IF SIMPLEGRID_USE_UNICODE
    RETURN GetWindowTextW(hGrid, buf, cchMax)
  ELSE
    RETURN GetWindowTextA(hGrid, buf, cchMax)
  END

SimpleGrid_GetTitleLength PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  IF SIMPLEGRID_USE_UNICODE
    RETURN GetWindowTextLengthW(hGrid)
  ELSE
    RETURN GetWindowTextLengthA(hGrid)
  END

SimpleGrid_RefreshGrid PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_REFRESHGRID, 0, 0)

SimpleGrid_ResetContent PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_RESETCONTENT, 0, 0)

SimpleGrid_SelectCell PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow, LONG overwriteMode)!,LONG
sgi like(SGITEM)
  CODE
  sgi.col = iCol
  sgi.row = iRow
  RETURN SimpleGrid_SendMessage(hGrid, SG_SELECTCELL, overwriteMode, ADDRESS(sgi))

SimpleGrid_SetAllowColResize PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETALLOWCOLRESIZE, fSet, 0)

SimpleGrid_SetColAutoWidth PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETCOLAUTOWIDTH, fSet, 0)

SimpleGrid_SetColsNumbered PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETCOLSNUMBERED, fSet, 0)

SimpleGrid_SetColumnHeaderText PROCEDURE(SGHANDLE hGrid, LONG iCol, *SGSTR text)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETCOLUMNHEADERTEXT, iCol, ADDRESS(text))

SimpleGrid_SetColWidth PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG nWidth)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETCOLWIDTH, iCol, nWidth)

SimpleGrid_SetCursorPos PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETCURSORPOS, iCol, iRow)

SimpleGrid_SetDoubleBuffer PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETDOUBLEBUFFER, fSet, 0)

SimpleGrid_SetEllipsis PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETELLIPSIS, fSet, 0)

SimpleGrid_SetGridLineColor PROCEDURE(SGHANDLE hGrid, ULONG clr)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETGRIDLINECOLOR, clr, 0)

SimpleGrid_SetHeaderRowHeight PROCEDURE(SGHANDLE hGrid, LONG height)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETHEADERROWHEIGHT, height, 0)

SimpleGrid_SetHeadingFont PROCEDURE(SGHANDLE hGrid, SGHANDLE hFont)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETHEADINGFONT, hFont, 0)

SimpleGrid_SetHilightColor PROCEDURE(SGHANDLE hGrid, ULONG clr)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETHILIGHTCOLOR, clr, 0)

SimpleGrid_SetHilightTextColor PROCEDURE(SGHANDLE hGrid, ULONG clr)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETHILIGHTTEXTCOLOR, clr, 0)

SimpleGrid_SetImageColumnImageList PROCEDURE(SGHANDLE hGrid, LONG iCol, SGHANDLE himl)!,SGLPARAM
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETIMAGELIST, iCol, himl)

SimpleGrid_SetItemData PROCEDURE(SGHANDLE hGrid, *SGITEM pItem)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETITEMDATA, 0, ADDRESS(pItem))

SimpleGrid_SetItemText PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow, SGSTR text)!,LONG
sgi like(SGITEM)
  CODE
  sgi.col = iCol
  sgi.row = iRow
  sgi.lpCurValue = ADDRESS(text)
  RETURN SimpleGrid_SetItemData(hGrid, sgi)

SimpleGrid_SetItemTextAlignment PROCEDURE(SGHANDLE hGrid, *SGITEM pItem, ULONG align)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETITEMTEXTALIGNMENT, align, ADDRESS(pItem))

SimpleGrid_SetItemTextAlignmentEx PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow, ULONG align)!,LONG
sgi like(SGITEM)
  CODE
  sgi.col = iCol
  sgi.row = iRow
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETITEMTEXTALIGNMENT, align, ADDRESS(sgi))

SimpleGrid_SetItemProtection PROCEDURE(SGHANDLE hGrid, *SGITEM pItem, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETITEMPROTECTION, fSet, ADDRESS(pItem))

SimpleGrid_SetItemProtectionEx PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG iRow, LONG fSet)!,LONG
sgi like(SGITEM)
  CODE
  sgi.col = iCol
  sgi.row = iRow
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETITEMPROTECTION, fSet, ADDRESS(sgi))

SimpleGrid_SetProtectColor PROCEDURE(SGHANDLE hGrid, ULONG clr)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETPROTECTCOLOR, clr, 0)

SimpleGrid_SetRowHeaderText PROCEDURE(SGHANDLE hGrid, LONG iRow, *SGSTR text)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETROWHEADERTEXT, iRow, ADDRESS(text))

SimpleGrid_SetRowHeaderWidth PROCEDURE(SGHANDLE hGrid, LONG nWidth)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETROWHEADERWIDTH, 0, nWidth)

SimpleGrid_SetRowHeight PROCEDURE(SGHANDLE hGrid, LONG height)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETROWHEIGHT, height, 0)

SimpleGrid_SetRowsNumbered PROCEDURE(SGHANDLE hGrid, LONG fSet)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETROWSNUMBERED, fSet, 0)

SimpleGrid_SetSelectionMode PROCEDURE(SGHANDLE hGrid, LONG mode)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETSELECTIONMODE, mode, 0)

SimpleGrid_SetTitle PROCEDURE(SGHANDLE hGrid, *SGSTR text)!,LONG
  CODE
  IF SIMPLEGRID_USE_UNICODE
    RETURN SetWindowTextW(hGrid, text)
  ELSE
    RETURN SetWindowTextA(hGrid, text)
  END

SimpleGrid_SetTitleFont PROCEDURE(SGHANDLE hGrid, SGHANDLE hFont)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETTITLEFONT, hFont, 0)

SimpleGrid_SetTitleHeight PROCEDURE(SGHANDLE hGrid, LONG height)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETTITLEHEIGHT, height, 0)

SimpleGrid_ShowIntegralRows PROCEDURE(SGHANDLE hGrid, LONG fShow)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SHOWINTEGRALROWS, fShow, 0)

SimpleGrid_InsertRow PROCEDURE(SGHANDLE hGrid, LONG position, *SGSTR header)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_INSERTROW, position, ADDRESS(header))

SimpleGrid_DeleteRow PROCEDURE(SGHANDLE hGrid, LONG position)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_DELETEROW, position, 0)

SimpleGrid_Enable PROCEDURE(SGHANDLE hGrid, LONG fEnable)!,LONG
  CODE
  RETURN EnableWindow(hGrid, fEnable)

! -------------------------------------------------------
! SimpleGrid_BeginLoad
!
! Congela el repintado del grid antes de cargar datos.
! Llamar antes de ResetContent + bucle de AddRow/SetItemText.
! Evita el parpadeo y acelera la carga significativamente.
! -------------------------------------------------------
SimpleGrid_BeginLoad PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, WM_SETREDRAW, 0, 0)

! -------------------------------------------------------
! SimpleGrid_EndLoad
!
! Re-habilita el repintado y fuerza un repintado inmediato.
! Llamar después de que termine el bucle de carga.
! -------------------------------------------------------
SimpleGrid_EndLoad PROCEDURE(SGHANDLE hGrid)!,LONG
  CODE
  SimpleGrid_SendMessage(hGrid, WM_SETREDRAW, 1, 0)
  InvalidateRect(hGrid, 0, 1)
  UpdateWindow(hGrid)
  RETURN 1

! -------------------------------------------------------
! SimpleGrid_GetQueueRow
!
! Devuelve el número de fila del Queue Clarion que corresponde
! a la fila actualmente seleccionada en el grid.
!
! REQUIERE que al hacer AddRow se haya guardado el índice
! del queue en el row header:
!   rowIdx = FORMAT(qRow, @N10)
!   SimpleGrid_AddRow(hGrid, rowIdx)
!
! Retorna: número de fila del Queue (1-based), o 0 si error.
! -------------------------------------------------------
SimpleGrid_GetQueueRow PROCEDURE(SGHANDLE hGrid)!,LONG
buf   STRING(20)
  CODE
  SimpleGrid_GetRowHeaderText(hGrid, SimpleGrid_GetCursorRow(hGrid), buf)
  RETURN VAL(CLIP(buf))

! -------------------------------------------------------
! SimpleGrid_SetColumnSortMark
!
! Actualiza el texto del encabezado de una columna para
! mostrar visualmente la dirección de ordenamiento.
!
! direction: SGS_NONE  → 'Nombre'
!            SGS_ASC   → 'Nombre ^'
!            SGS_DESC  → 'Nombre v'
!
! Parámetros:
!   hGrid    - handle del grid
!   iCol     - columna a marcar (0-based)
!   direction- SGS_NONE, SGS_ASC o SGS_DESC
!   baseText - texto base del encabezado (sin marca previa)
! -------------------------------------------------------
! -------------------------------------------------------
! SimpleGrid_SetSortColumn
!
! Dibuja un triángulo nativo (▲/▼) en el encabezado de la
! columna indicada. El triángulo es renderizado por el DLL.
! Llama a SG_RESETCONTENT o a esta función con direction=0
! para limpiar todas las flechas.
!
! Parámetros:
!   hGrid    - handle del grid
!   iCol     - columna a marcar (0-based); -1 = limpiar todas
!   direction- SGS_NONE (0), SGS_ASC (1) o SGS_DESC (2)
! -------------------------------------------------------
SimpleGrid_SetSortColumn PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG direction)!,LONG
  CODE
  RETURN SimpleGrid_SendMessage(hGrid, SG_SETSORTCOLUMN, iCol, direction)

SimpleGrid_SetColumnSortMark PROCEDURE(SGHANDLE hGrid, LONG iCol, LONG direction, SGSTR baseText)!,LONG
newText   STRING(256)
  CODE
  CASE direction
  OF SGS_ASC
    newText = CLIP(baseText) & ' ^'
  OF SGS_DESC
    newText = CLIP(baseText) & ' v'
  ELSE
    newText = CLIP(baseText)
  END
  RETURN SimpleGrid_SetColumnHeaderText(hGrid, iCol, newText)

