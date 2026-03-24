# SimpleGrid

A lightweight, low-overhead Windows grid control implemented as a Win32 custom control DLL. Provides in-place cell editing, multiple column types, and a message-based API compatible with both C/Win32 and Clarion applications.

Based on David Hillard's award-winning 2002 CodeGuru article *"Win32 Grid Control with Low Overhead (BABYGRID)"*, heavily rewritten and extended by David MacDermot.

---

## Features

- **Multiple column types:** text edit, combobox, checkbox, button, hyperlink, and image
- **Selection modes:** single cell, full row, or row header
- **In-place cell editing** with keyboard and mouse navigation
- **Dynamic rows and columns:** add, insert, delete at runtime
- **Cell protection** (read-only) with visual indicator
- **Custom styling:** fonts, colors, gridline styles, column widths, row heights
- **Text alignment:** left, right, or auto (general)
- **WM_NOTIFY notifications** for selection, edit, focus, and key events
- **Double-buffered rendering** for flicker-free display
- **Clarion language bindings** included

---

## Column Types

| Constant     | Description               |
|--------------|---------------------------|
| `GCT_EDIT`   | Editable text field       |
| `GCT_COMBO`  | Dropdown combobox         |
| `GCT_BUTTON` | Push button               |
| `GCT_CHECK`  | Checkbox                  |
| `GCT_LINK`   | Clickable hyperlink       |
| `GCT_IMAGE`  | Bitmap image display      |

---

## Notification Messages

| Message          | When fired                      |
|------------------|---------------------------------|
| `SGN_SELCHANGE`  | Selection changed               |
| `SGN_EDITBEGIN`  | Cell edit started               |
| `SGN_EDITEND`    | Cell edit finished              |
| `SGN_KEYDOWN`    | Key pressed inside the grid     |
| `SGN_GOTFOCUS`   | Grid received focus             |
| `SGN_LOSTFOCUS`  | Grid lost focus                 |
| `SGN_ITEMCLICK`  | Cell item clicked (button/link) |

---

## Project Structure

```
SimpleGrid/
├── simpleGrid.c          # Core grid control implementation (~4,700 lines)
├── simpleGrid.h          # Public API — messages, structures, constants
├── SimpleGrid.clw        # Clarion procedure wrappers
├── SimpleGrid.inc        # Clarion EQUATEs and GROUP definitions
├── ExampleSimpleGrid.clw # Clarion usage example
├── ExampleSimpleGrid.cwproj
├── ExampleSimpleGrid.sln
├── Grids/
│   └── SimpleGrid/
│       ├── main.c        # Win32 C demo application (5 grid examples)
│       ├── dllmain.c     # DLL entry point
│       ├── main.h / main.rc / resource.h
│       └── *.bmp / *.ico # Demo resources
├── map/                  # Linker map output (build artifact)
└── obj/                  # Compiled object files (build artifact)
```

---

## Building

### Requirements

- **Visual Studio 2012** or later (Win32 C compiler)
- **Pelles C 13.x** or later (Win32 C compiler)
- **Clarion** (optional, for Clarion bindings and example)

### Visual Studio

Open `ExampleSimpleGrid.sln` and build in **Release** or **Debug** configuration for the Win32 platform.

The output DLL (`SimpleGrid.dll`) and import library (`SimpleGrid.lib`) will be placed in the project output directory.

### Clarion

Open `ExampleSimpleGrid.cwproj` in the Clarion IDE and build normally. The project links against `SimpleGrid.lib`.

---

## Usage (C / Win32)

### 1. Register and create the control

```c
#include "simpleGrid.h"

// The control window class is "SimpleGridCtl"
HWND hGrid = CreateWindowEx(
    WS_EX_CLIENTEDGE,
    TEXT("SimpleGridCtl"),
    NULL,
    WS_CHILD | WS_VISIBLE | WS_TABSTOP,
    x, y, width, height,
    hParent, (HMENU)IDC_GRID, hInstance, NULL
);
```

### 2. Add columns

```c
SGCOLUMN col = {0};
col.dwType    = GCT_EDIT;
col.pszHeader = TEXT("Name");
col.pOptional = NULL;

SendMessage(hGrid, SG_ADDCOLUMN, 0, (LPARAM)&col);
```

### 3. Add rows and set cell data

```c
SendMessage(hGrid, SG_ADDROW, 0, 0);

SGITEM item = {0};
item.col      = 0;
item.row      = 1;
item.pszVal   = TEXT("John Doe");

SendMessage(hGrid, SG_SETITEMTEXT, 0, (LPARAM)&item);
```

### 4. Handle notifications

```c
case WM_NOTIFY: {
    NMHDR *pNmhdr = (NMHDR *)lParam;
    if (pNmhdr->idFrom == IDC_GRID) {
        switch (pNmhdr->code) {
        case SGN_SELCHANGE:
            // selection changed
            break;
        case SGN_EDITEND:
            // cell edit finished
            break;
        }
    }
    break;
}
```

---

## Usage (Clarion)

Include the bindings and call the wrapper procedures:

```clarion
INCLUDE('SimpleGrid.inc'), ONCE

! Add a column
SGAddColumn(hGrid, GCT_EDIT, 'Name', 0)

! Add a row and set cell text
SGAddRow(hGrid)
SGSetItemText(hGrid, 0, 1, 'John Doe')
```

---

## Key API Messages (SG_*)

| Category       | Messages                                                         |
|----------------|------------------------------------------------------------------|
| Columns        | `SG_ADDCOLUMN`, `SG_DELETECOLUMN`, `SG_GETCOLCOUNT`             |
| Rows           | `SG_ADDROW`, `SG_INSERTROW`, `SG_DELETEROW`, `SG_GETROWCOUNT`   |
| Cell data      | `SG_SETITEMTEXT`, `SG_GETITEMTEXT`, `SG_SETPROTECT`             |
| Layout         | `SG_SETCOLWIDTH`, `SG_SETROWHEIGHT`, `SG_RESETCONTENT`          |
| Selection      | `SG_SETSELECTIONMODE`, `SG_GETROW`, `SG_GETCOL`                 |
| Styling        | `SG_SETGRIDLINECOLOR`, `SG_SETHILIGHTCOLOR`, `SG_SETFONT`       |
| Behavior       | `SG_SETELLIPSIS`, `SG_SETROWNUMBERING`, `SG_SETHEADERROWHEIGHT` |

See [simpleGrid.h](simpleGrid.h) for the full list of messages and structures.

---

## Data Structures

```c
// Column definition
typedef struct tagSGCOLUMN {
    DWORD  dwType;      // Column type (GCT_*)
    LPTSTR pszHeader;   // Header text
    LPVOID pOptional;   // Optional data (e.g. combobox items)
} SGCOLUMN, *PSGCOLUMN;

// Cell reference and value
typedef struct tagSGITEM {
    int    col;         // Zero-based column index
    int    row;         // One-based row index
    LPTSTR pszVal;      // Cell text value
} SGITEM, *PSGITEM;

// Notification data
typedef struct tagNMGRID {
    NMHDR hdr;
    int   col;
    int   row;
} NMGRID, *PNMGRID;
```

---

## Credits

- **Original concept:** David Hillard — *BABYGRID* (CodeGuru, 2002)
- **Rewrite and extensions:** David MacDermot (versions 1.1 – 2.2)

---

## License

See source file headers for original license terms.
