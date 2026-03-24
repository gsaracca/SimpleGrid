    MEMBER()

    INCLUDE('SimpleGrid.inc'),ONCE

    MAP
        MODULE('KERNEL32.DLL')
            GetModuleHandleA(*CSTRING lpModuleName),SGHANDLE,RAW,NAME('GetModuleHandleA')
        END
        MODULE('SimpleGrid.dll')
            InitSimpleGrid(SGHANDLE hInst),SGHANDLE,RAW,NAME('InitSimpleGrid'),DLL(TRUE)
            New_SimpleGrid(SGHANDLE hParent, UNSIGNED dwID),SGHANDLE,RAW,NAME('New_SimpleGrid'),DLL(TRUE)
        END
        ExampleSimpleGrid()
    END

  CODE
  ExampleSimpleGrid()

! =======================================================
! ExampleSimpleGrid
!
! Flujo completo: SQL → Queue → SimpleGrid
!
! Características demostradas:
!   - Carga rápida con BeginLoad / EndLoad
!   - Índice de Queue oculto en row header
!   - Acceso directo al registro con GetQueueRow
!   - Sort por click en header (SGN_HEADERCLICK)
!   - Toggle ASC/DESC con triángulo nativo (DLL)
!   - Reversa de Queue para orden DESC
! =======================================================
ExampleSimpleGrid PROCEDURE()

! --- Queue que simula el resultado de una consulta SQL ---
ClienteQ    QUEUE
ID            LONG
Nombre        STRING(50)
Ciudad        STRING(30)
Ventas        LONG
            END

window WINDOW('Clientes - SimpleGrid + Queue'),AT(,,600,360),GRAY,SYSTEM,RESIZE
         STRING('Hacé click en un encabezado de columna para ordenar'), |
                AT(8,344,584,12),LEFT
         STRING(''),AT(8,329,584,12),USE(sStatus),LEFT
       END

hGrid       SGHANDLE
col         LIKE(SGCOLUMN)
sHeader     CSTRING(64)
sStatus     STRING(200)
nullStr     CSTRING('')
nm          &NMGRID
qRow        LONG
gridRow     LONG
rowIdx      STRING(10)    ! Índice del Queue guardado en el row header

! Estado del sort
sortCol     LONG          ! Columna actualmente ordenada (0-based, -1 = ninguna)
sortDir     LONG          ! SGS_ASC o SGS_DESC

! Variables para reversa del queue (usadas en la ROUTINE ReverseQueue)
revI        LONG
revJ        LONG
tmpID       LONG
tmpNombre   STRING(50)
tmpCiudad   STRING(30)
tmpVentas   LONG

    CODE
    ! -------------------------------------------------------
    ! Simular carga desde SQL
    ! En producción: reemplazar con consulta real al driver SQL
    ! -------------------------------------------------------
    CLEAR(ClienteQ)
    ClienteQ.ID=1 ; ClienteQ.Nombre='García, Juan'     ; ClienteQ.Ciudad='Buenos Aires' ; ClienteQ.Ventas=150000 ; ADD(ClienteQ)
    ClienteQ.ID=2 ; ClienteQ.Nombre='López, María'     ; ClienteQ.Ciudad='Córdoba'       ; ClienteQ.Ventas=320000 ; ADD(ClienteQ)
    ClienteQ.ID=3 ; ClienteQ.Nombre='Rodríguez, Ana'   ; ClienteQ.Ciudad='Rosario'       ; ClienteQ.Ventas= 98000 ; ADD(ClienteQ)
    ClienteQ.ID=4 ; ClienteQ.Nombre='Martínez, Luis'   ; ClienteQ.Ciudad='Mendoza'       ; ClienteQ.Ventas=210000 ; ADD(ClienteQ)
    ClienteQ.ID=5 ; ClienteQ.Nombre='Fernández, Pablo' ; ClienteQ.Ciudad='Buenos Aires'  ; ClienteQ.Ventas=450000 ; ADD(ClienteQ)
    ClienteQ.ID=6 ; ClienteQ.Nombre='Díaz, Carolina'   ; ClienteQ.Ciudad='La Plata'      ; ClienteQ.Ventas= 75000 ; ADD(ClienteQ)
    ClienteQ.ID=7 ; ClienteQ.Nombre='Sánchez, Roberto' ; ClienteQ.Ciudad='Córdoba'       ; ClienteQ.Ventas=180000 ; ADD(ClienteQ)

    OPEN(window)

    IF NOT InitSimpleGrid(GetModuleHandleA(nullStr))
        RETURN
    END

    hGrid   = New_SimpleGrid(window{PROP:Handle}, 1001)
    sortCol = -1
    sortDir = SGS_NONE

    ! -------------------------------------------------------
    ! Definir columnas del grid
    ! -------------------------------------------------------
    sHeader = 'ID'
    col.dwType = GCT_EDIT ; col.lpszHeader = ADDRESS(sHeader) ; col.pOptional = 0
    SimpleGrid_AddColumn(hGrid, col)
    SimpleGrid_SetColWidth(hGrid, 0, 50)

    sHeader = 'Nombre'
    col.dwType = GCT_EDIT ; col.lpszHeader = ADDRESS(sHeader) ; col.pOptional = 0
    SimpleGrid_AddColumn(hGrid, col)
    SimpleGrid_SetColWidth(hGrid, 1, 180)

    sHeader = 'Ciudad'
    col.dwType = GCT_EDIT ; col.lpszHeader = ADDRESS(sHeader) ; col.pOptional = 0
    SimpleGrid_AddColumn(hGrid, col)
    SimpleGrid_SetColWidth(hGrid, 2, 130)

    sHeader = 'Ventas'
    col.dwType = GCT_EDIT ; col.lpszHeader = ADDRESS(sHeader) ; col.pOptional = 0
    SimpleGrid_AddColumn(hGrid, col)
    SimpleGrid_SetColWidth(hGrid, 3, 100)

    ! -------------------------------------------------------
    ! Configuración general (solo lectura, selección por fila)
    ! -------------------------------------------------------
    SimpleGrid_EnableEdit(hGrid, 0)
    SimpleGrid_SetSelectionMode(hGrid, GSO_FULLROW)
    SimpleGrid_SetDoubleBuffer(hGrid, 1)
    SimpleGrid_SetEllipsis(hGrid, 1)
    SimpleGrid_ExtendLastColumn(hGrid, 1)
    SimpleGrid_SetRowHeaderWidth(hGrid, 0)   ! Ocultar row header (solo es índice interno)

    ! -------------------------------------------------------
    ! Carga inicial: Queue → Grid
    ! -------------------------------------------------------
    DO LoadQueueToGrid

    ACCEPT
        CASE EVENT()

        OF EVENT:Notify
            IF NOTIFYCONTROL() = 1001
                CASE NOTIFYCODE()

                ! ------------------------------------------
                ! SGN_SELCHANGE: acceder al registro del Queue
                ! que corresponde a la fila seleccionada
                ! ------------------------------------------
                OF SGN_SELCHANGE
                    qRow = SimpleGrid_GetQueueRow(hGrid)
                    IF qRow > 0 AND qRow <= RECORDS(ClienteQ)
                        GET(ClienteQ, qRow)
                        sStatus = 'ID: '        & FORMAT(ClienteQ.ID, @N5)     & |
                                  '  Nombre: '  & CLIP(ClienteQ.Nombre)        & |
                                  '  Ciudad: '  & CLIP(ClienteQ.Ciudad)        & |
                                  '  Ventas: $' & FORMAT(ClienteQ.Ventas, @N10)
                    END

                ! ------------------------------------------
                ! SGN_HEADERCLICK: ordenar por la columna
                ! clickeada con comportamiento toggle ASC/DESC
                ! ------------------------------------------
                OF SGN_HEADERCLICK
                    nm &= (NOTIFYDATA())

                    IF nm.col = sortCol
                        ! Misma columna: toggle de dirección
                        IF sortDir = SGS_ASC
                            sortDir = SGS_DESC
                        ELSE
                            sortDir = SGS_ASC
                        END
                    ELSE
                        ! Columna nueva: siempre empieza en ASC
                        sortCol = nm.col
                        sortDir = SGS_ASC
                    END

                    ! Ordenar el Queue según la columna seleccionada
                    CASE sortCol
                    OF 0 ; SORT(ClienteQ, ClienteQ.ID)
                    OF 1 ; SORT(ClienteQ, ClienteQ.Nombre)
                    OF 2 ; SORT(ClienteQ, ClienteQ.Ciudad)
                    OF 3 ; SORT(ClienteQ, ClienteQ.Ventas)
                    END

                    ! Para DESC: SORT() solo va ASC, así que revertimos el queue
                    IF sortDir = SGS_DESC
                        DO ReverseQueue
                    END

                    ! Actualizar triángulo nativo en el header (dibujado por el DLL)
                    SimpleGrid_SetSortColumn(hGrid, sortCol, sortDir)

                    ! Recargar el grid con el queue ya reordenado
                    DO LoadQueueToGrid

                END  ! CASE NOTIFYCODE()
            END  ! IF NOTIFYCONTROL()

        END  ! CASE EVENT()
    END  ! ACCEPT

    CLOSE(window)

! -------------------------------------------------------
! LoadQueueToGrid  (ROUTINE local)
!
! Carga el contenido de ClienteQ en el grid.
! Patrón estándar para el flujo SQL → Queue → Grid.
! -------------------------------------------------------
LoadQueueToGrid ROUTINE
    SimpleGrid_BeginLoad(hGrid)
    SimpleGrid_ResetContent(hGrid)
    LOOP qRow = 1 TO RECORDS(ClienteQ)
        GET(ClienteQ, qRow)
        rowIdx  = FORMAT(qRow, @N10)          ! Índice del Queue, invisible al usuario
        gridRow = SimpleGrid_AddRow(hGrid, rowIdx)
        SimpleGrid_SetItemText(hGrid, 0, gridRow, FORMAT(ClienteQ.ID,     @N10))
        SimpleGrid_SetItemText(hGrid, 1, gridRow, CLIP(ClienteQ.Nombre))
        SimpleGrid_SetItemText(hGrid, 2, gridRow, CLIP(ClienteQ.Ciudad))
        SimpleGrid_SetItemText(hGrid, 3, gridRow, FORMAT(ClienteQ.Ventas, @N10))
    END
    SimpleGrid_EndLoad(hGrid)

! -------------------------------------------------------
! ReverseQueue  (ROUTINE local)
!
! Invierte el orden de ClienteQ para implementar DESC.
! Usada después de SORT() (que siempre es ASC) cuando
! el usuario pide orden descendente.
!
! NOTA: En producción con SQL real, preferir re-consultar
! con ORDER BY ... DESC en lugar de invertir en memoria.
! -------------------------------------------------------
ReverseQueue ROUTINE
    LOOP revI = 1 TO RECORDS(ClienteQ) / 2
        revJ = RECORDS(ClienteQ) - revI + 1
        ! Cargar registro de la posición inferior (revI) en temp
        GET(ClienteQ, revI)
        tmpID     = ClienteQ.ID
        tmpNombre = ClienteQ.Nombre
        tmpCiudad = ClienteQ.Ciudad
        tmpVentas = ClienteQ.Ventas
        ! Cargar registro de la posición superior (revJ) y escribirlo en revI
        GET(ClienteQ, revJ)
        PUT(ClienteQ, revI)
        ! Escribir el registro guardado en temp en la posición revJ
        ClienteQ.ID     = tmpID
        ClienteQ.Nombre = tmpNombre
        ClienteQ.Ciudad = tmpCiudad
        ClienteQ.Ventas = tmpVentas
        PUT(ClienteQ, revJ)
    END

