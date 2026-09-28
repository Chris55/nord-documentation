\newpage
## Nord Electro 5 Live File Structure

This mapping corresponds to the Nord Electro 5 live file (file extension ne5l). The Electro 5 has three Live slots,
Live 1 to Live 3, and a live file holds one of them. Nord Sound Manager exports them as Live 1.ne5l to Live 3.ne5l,
and a full backup (ne5b) carries them as Live/Live/Live 1.ne5l and so on.

The body is the program body. A live file and a program file (ne5p) have the same size and the same 121-byte body
at 0x2C to 0xA4, byte for byte, so every body offset in the
[Nord Electro 5 Program File Structure](#nord-electro-5-program-file-structure) applies unchanged. The same panel
state read from the instrument once as Live 1 and once as a program gave identical bodies.

Only the header differs: the file ID is ne5l, and the location addresses the three Live slots, not the 8 banks of
50 programs. A live file has no program bank or program location.

| offset   | bits       | description
| :---:    |   :----:   | :-------------------------------------------------
| `0x0000` | `cccccccc` | (c) 4-byte Clavia ID, ascii C - 0x43
| `0x0001` | `cccccccc` | ascii B - 0x42
| `0x0002` | `cccccccc` | ascii I - 0x49
| `0x0003` | `cccccccc` | ascii N - 0x4E
| `0x0004` | `ffffffff` | [(f) file format (32-bit, little endian)](#ne5-live-file-format)
| `0x0005` | `ffffffff` |
| `0x0006` | `ffffffff` |
| `0x0007` | `ffffffff` |
| `0x0008` | `iiiiiiii` | (i) 4-byte file ID, ascii n - 0x6E
| `0x0009` | `iiiiiiii` | ascii e - 0x65
| `0x000A` | `iiiiiiii` | ascii 5 - 0x35
| `0x000B` | `iiiiiiii` | ascii l - 0x6C
| `0x000C` | `bbbbbbbb` | (b) bank (16-bit, little endian), always 0
| `0x000D` | `bbbbbbbb` |
| `0x000E` | `llllllll` | (l) location (16-bit, little endian), 0 = Live 1, 1 = Live 2, 2 = Live 3
| `0x000F` | `llllllll` |
| `0x0010` | `--------` | 0xFF
| `0x0011` | `--------` | 0xFF
| `0x0012` | `--------` | 0xFF
| `0x0013` | `--------` | 0xFF
| `0x0014` | `vvvvvvvv` | [(v) version (32-bit, little endian)](#ne5-live-version)
| `0x0015` | `vvvvvvvv` |
| `0x0016` | `vvvvvvvv` |
| `0x0017` | `vvvvvvvv` |
| `0x0018` | `cccccccc` | [(c) CRC-32 (32-bit, little endian)](#ne5-live-file-format)
| `0x0019` | `cccccccc` |
| `0x001A` | `cccccccc` |
| `0x001B` | `cccccccc` |
| `0x001C` | `--------` | 0
| `0x001D` | `--------` | 0
| `0x001E` | `--------` | 0
| `0x001F` | `--------` | 0
| `0x0020` | `--------` | 0
| `0x0021` | `--------` | 0
| `0x0022` | `--------` | 0
| `0x0023` | `--------` | 0
| `0x0024` | `--------` | 0
| `0x0025` | `--------` | 0
| `0x0026` | `--------` | 0
| `0x0027` | `--------` | 0
| `0x0028` | `--------` | 0
| `0x0029` | `--------` | 0
| `0x002A` | `--------` | 0
| `0x002B` | `--------` | 0
| `0x002C` | `vvvvvvvv` | [(v) version (16-bit, big endian), repeated - start of body](#ne5-live-version)
| `0x002D` | `vvvvvvvv` | 0x002E to 0x00A4: same as the program body


### NE5 Live File Format

The same two header types as the program file: type 0 (147 bytes, no 0x18 to 0x2B, body at 0x18, CRC-16 at the end
of the file over every byte before it) and type 1 (165 bytes, CRC-32 at 0x18 over the body only). The factory live
files are type 0.

Because the type 1 CRC-32 only covers the body, a type 1 live file and a type 1 program file with the same body and
the same location word differ in one byte only, 0x0B (l against p). To turn one into the other, change the file ID
and set the location for the new slot space; the checksum at 0x18 stays valid. In a type 0 file the CRC-16 covers
the header as well, so it must be recomputed after any header change.


### NE5 Live Version

Always 4 on every file seen, the same as a program. The body repeats it at 0x2C (16-bit, big endian).
