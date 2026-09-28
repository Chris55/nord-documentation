\newpage
## Nord Electro 5 Song File Structure

This mapping corresponds to the Nord Electro 5 song file (file extension ne5t). A song is a set of four program
slots, A to D. The Electro 5 holds 4 banks of 50 songs.

Offset 0x04 defines the file header format.

| type  | size  | description
| :---: | :---: | :------------------------
| 0     |  44   | Legacy format: bytes 0x18 to 0x2B are missing, and a CRC-16 is added at the end of the file. The factory songs use it.
| 1     |  62   | New format with bytes 0x18 to 0x2B (20 bytes), written by Nord Sound Manager 7.40 and later.

The offsets below are for type 1. In a type 0 file the body starts at 0x18, so every body offset is 0x14 lower.

The song name is not stored in the file. The instrument keeps it separately (16 bytes) and sends it next to the
body over USB.

| offset   | bits       | description
| :---:    |   :----:   | :-------------------------------------------------
| `0x0000` | `cccccccc` | (c) 4-byte Clavia ID, ascii C - 0x43
| `0x0001` | `cccccccc` | ascii B - 0x42
| `0x0002` | `cccccccc` | ascii I - 0x49
| `0x0003` | `cccccccc` | ascii N - 0x4E
| `0x0004` | `ffffffff` | [(f) file format (32-bit, little endian)](#ne5-song-file-format)
| `0x0005` | `ffffffff` |
| `0x0006` | `ffffffff` |
| `0x0007` | `ffffffff` |
| `0x0008` | `iiiiiiii` | (i) 4-byte file ID, ascii n - 0x6E
| `0x0009` | `iiiiiiii` | ascii e - 0x65
| `0x000A` | `iiiiiiii` | ascii 5 - 0x35
| `0x000B` | `iiiiiiii` | ascii t - 0x74
| `0x000C` | `bbbbbbbb` | (b) bank (16-bit, little endian), 0 = bank 1 . . . 3 = bank 4
| `0x000D` | `bbbbbbbb` |
| `0x000E` | `llllllll` | (l) location (16-bit, little endian), 0 = location 1 . . . 49 = location 50
| `0x000F` | `llllllll` |
| `0x0010` | `--------` | 0xFF
| `0x0011` | `--------` | 0xFF
| `0x0012` | `--------` | 0xFF
| `0x0013` | `--------` | 0xFF
| `0x0014` | `vvvvvvvv` | [(v) version (32-bit, little endian)](#ne5-song-version)
| `0x0015` | `vvvvvvvv` |
| `0x0016` | `vvvvvvvv` |
| `0x0017` | `vvvvvvvv` |
| `0x0018` | `cccccccc` | [(c) CRC-32 (32-bit, little endian)](#ne5-song-file-format)
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
| `0x002C` | `vvvvvvvv` | [(v) version (16-bit, big endian), repeated - start of body](#ne5-song-version)
| `0x002D` | `vvvvvvvv` |
| `0x002E` | `aaaaaaaa` | [(a) program slot A](#ne5-song-program-slot)
| `0x002F` | `abbbbbbb` | [(a) program slot A](#ne5-song-program-slot), [(b) program slot B](#ne5-song-program-slot)
| `0x0030` | `bbcccccc` | [(b) program slot B](#ne5-song-program-slot), [(c) program slot C](#ne5-song-program-slot)
| `0x0031` | `cccddddd` | [(c) program slot C](#ne5-song-program-slot), [(d) program slot D](#ne5-song-program-slot)
| `0x0032` | `dddd----` |
| `0x0033` | `--------` | 0
| `0x0034` | `--------` | 0
| `0x0035` | `--------` | 0
| `0x0036` | `--------` | 0
| `0x0037` | `--------` | 0
| `0x0038` | `--------` | 0
| `0x0039` | `--------` | 0
| `0x003A` | `--------` | 0
| `0x003B` | `--------` | 0
| `0x003C` | `--------` | 0
| `0x003D` | `--------` | 0


### NE5 Song File Format

| type | description
| :--- | :-------------------------------------------------
| 0    | Legacy header, 24 bytes. Bytes 0x18 to 0x2B are missing, so the body starts at 0x18. The file ends with a 2-byte CRC-16 (IBM-3740, also called CCITT-FALSE, little endian) at 0x2A over every byte before it, header included.
| 1    | Header with checksum, 44 bytes. 0x18 to 0x1B is a CRC-32 (ISO-HDLC / zlib, little endian) over the body only, 0x2C to 0x3D. 0x1C to 0x2B are 0.


### NE5 Song Version

|value | version
| :--- | :---
| 0    | the songs shipped on the instrument from the factory
| 1    | any song the instrument has written, by the user or as a side effect

The instrument never writes version 0. A factory song becomes version 1 as soon as the instrument rewrites it, even
when nothing asked for that: moving a program rewrites every song that uses it.

The body repeats the version at 0x2C (16-bit, big endian). Only 0 and 1 have been seen, so in practice this is a
single bit, 0x2D b0. Apart from the header field at 0x14 (and so the checksum), this is the only difference between
a version 0 and a version 1 song: the two copies always agree, and nothing else in the body changes with the
version. The body is also the only part the instrument sends when a song is read from it - the header is not
transmitted - so this looks like the version being carried where the receiving side can see it.


### NE5 Song Program Slot

Each slot is a 9-bit program location, counted straight through the program banks:

```
value = (program bank - 1) * 50 + (program location - 1)
```

so 0 = program 1:1, 49 = program 1:50, 50 = program 2:1 . . . 399 = program 8:50. 400 to 511 are never seen.

Moving a program on the instrument rewrites the slots of every song that uses it, so they follow the program.
Deleting a program does not: the slots keep pointing at the now empty location.
