    program

    include('SimpleGrid.inc'),once
    map
        module('KERNEL32.DLL')
            GetModuleHandleA(*CSTRING lpModuleName),SGHANDLE,RAW,NAME('GetModuleHandleA')
        end
        module('SimpleGrid.dll')
            InitSimpleGrid( SGHANDLE hInst ),SGHANDLE,RAW,NAME('InitSimpleGrid'),dll(true)
            New_SimpleGrid( SGHANDLE hParent, UNSIGNED dwID ),SGHANDLE,RAW,NAME('New_SimpleGrid'),dll(true)
        end        
        ExampleSimpleGrid()
        module( 'SimpleGrid.h' )
        
        end 
    end

  code
  ExampleSimpleGrid()

ExampleSimpleGrid procedure()

window WINDOW('SimpleGrid Example'),AT(,,520,300),GRAY,SYSTEM,RESIZE
       END

hGrid           SGHANDLE
col             like(SGCOLUMN)
sHeader         CSTRING(32)
comboItems      STRING(64)
cellText        STRING(256)
nm              &NMGRID
nullStr         cstring('')
    code
    open(window)

    if not InitSimpleGrid(GetModuleHandleA( nullStr ))
        return
    end    

    hGrid = New_SimpleGrid(window{PROP:Handle}, 1001)

    sHeader = 'Nombre'
    col.dwType     = GCT_EDIT
    col.lpszHeader = ADDRESS(sHeader)
    col.pOptional  = 0
    SimpleGrid_AddColumn(hGrid, col)

    sHeader = 'Activo'
    col.dwType     = GCT_CHECK
    col.lpszHeader = ADDRESS(sHeader)
    col.pOptional  = 0
    SimpleGrid_AddColumn(hGrid, col)

    comboItems = 'Admin' & CHR(0) & 'User' & CHR(0) & 'Guest' & CHR(0) & CHR(0)
    sHeader = 'Rol'
    col.dwType     = GCT_COMBO
    col.lpszHeader = ADDRESS(sHeader)
    col.pOptional  = ADDRESS(comboItems)
    SimpleGrid_AddColumn(hGrid, col)

    SimpleGrid_AddRow(hGrid, 'Fila 1')
    SimpleGrid_SetItemText(hGrid, 0, 0, 'Juan')
    SimpleGrid_SetItemText(hGrid, 1, 0, 'T')
    SimpleGrid_SetItemText(hGrid, 2, 0, 'Admin')

    SimpleGrid_AddRow(hGrid, 'Fila 2')
    SimpleGrid_SetItemText(hGrid, 0, 1, 'Ana')
    SimpleGrid_SetItemText(hGrid, 1, 1, 'F')
    SimpleGrid_SetItemText(hGrid, 2, 1, 'User')

    ACCEPT
        CASE EVENT()
        OF EVENT:Notify
!            IF NOTIFYCONTROL() = 1001
!                CASE NOTIFYCODE()
!                OF SGN_SELCHANGE
!                OF SGN_ITEMCLICK
!                OF SGN_KEYDOWN
!                OF SGN_EDITBEGIN
!                OF SGN_EDITEND
!                    cellText = ''
!                    SimpleGrid_GetItemText( hGrid, nm.col, nm.row, cellText )
!                    ! MESSAGE('Edited: ' & cellText)
!                END
!            END
        END
    END
    CLOSE(window)
    
    
