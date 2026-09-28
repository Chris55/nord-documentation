\newpage
## Nord Electro 5 Settings File Structure

This mapping corresponds to the Nord Electro 5 system settings file (file extension ne5s). The instrument holds
exactly one. It carries the System, MIDI and Sound menus, plus the selection the instrument restores at power-up.
Nord Sound Manager exports it as Settings.ne5s, and a full backup (ne5b) carries it as
Settings/Settings/Settings.ne5s.

Offset 0x04 defines the file header format.

| type  | size  | description
| :---: | :---: | :------------------------
| 0     |  60   | Legacy format: bytes 0x18 to 0x2B are missing, and a CRC-16 is added at the end of the file. The factory settings use it.
| 1     |  78   | New format with bytes 0x18 to 0x2B (20 bytes), written by Nord Sound Manager 7.40 and later.

The offsets below are for type 1. In a type 0 file the body starts at 0x18, so every body offset is 0x14 lower.

Every setting in the System, MIDI and Sound menus is in this file except two: Memory Protect (System) and Local
Control (MIDI) are not stored here at all. Toggling either one on the panel and reading the settings back changes
no bit of the file, so they are absent, not undecoded. Each setting below was found by changing that one setting
on the panel and reading the file back; the change moves exactly the bits listed and nothing else.

| offset   | bits       | description
| :---:    |   :----:   | :-------------------------------------------------
| `0x0000` | `cccccccc` | (c) 4-byte Clavia ID, ascii C - 0x43
| `0x0001` | `cccccccc` | ascii B - 0x42
| `0x0002` | `cccccccc` | ascii I - 0x49
| `0x0003` | `cccccccc` | ascii N - 0x4E
| `0x0004` | `ffffffff` | [(f) file format (32-bit, little endian)](#ne5-settings-file-format)
| `0x0005` | `ffffffff` |
| `0x0006` | `ffffffff` |
| `0x0007` | `ffffffff` |
| `0x0008` | `iiiiiiii` | (i) 4-byte file ID, ascii n - 0x6E
| `0x0009` | `iiiiiiii` | ascii e - 0x65
| `0x000A` | `iiiiiiii` | ascii 5 - 0x35
| `0x000B` | `iiiiiiii` | ascii s - 0x73
| `0x000C` | `bbbbbbbb` | (b) bank (16-bit, little endian), always 0
| `0x000D` | `bbbbbbbb` |
| `0x000E` | `llllllll` | (l) location (16-bit, little endian), always 0
| `0x000F` | `llllllll` |
| `0x0010` | `--------` | 0xFF
| `0x0011` | `--------` | 0xFF
| `0x0012` | `--------` | 0xFF
| `0x0013` | `--------` | 0xFF
| `0x0014` | `vvvvvvvv` | [(v) version (32-bit, little endian)](#ne5-settings-version)
| `0x0015` | `vvvvvvvv` |
| `0x0016` | `vvvvvvvv` |
| `0x0017` | `vvvvvvvv` |
| `0x0018` | `cccccccc` | [(c) CRC-32 (32-bit, little endian)](#ne5-settings-file-format)
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
| `0x002C` | `vvvvvvvv` | [(v) version (16-bit, big endian), repeated - start of body](#ne5-settings-version)
| `0x002D` | `vvvvvvvv` |
| `0x002E` | `sl-nnppp` | [(s) set list mode](#ne5-settings-power-up-selection), [(l) live mode](#ne5-settings-power-up-selection), [(n) live slot](#ne5-settings-power-up-selection), [(p) program](#ne5-settings-power-up-selection)
| `0x002F` | `ppppppss` | [(p) program](#ne5-settings-power-up-selection), [(s) song](#ne5-settings-power-up-selection)
| `0x0030` | `sssssscc` | [(s) song](#ne5-settings-power-up-selection), [(c) MIDI control change mode](#ne5-settings-midi-message-mode)
| `0x0031` | `pp-ssccc` | [(p) MIDI program change mode](#ne5-settings-midi-message-mode), [(s) sustain pedal type](#ne5-settings-pedals), [(c) control pedal type](#ne5-settings-pedals)
| `0x0032` | `----rrmf` | [(r) rotary pedal type](#ne5-settings-pedals), [(m) rotary pedal mode](#ne5-settings-pedals), [(f) fine tune](#ne5-settings-fine-tune)
| `0x0033` | `ffffff--` |
| `0x0034` | `rrrrtttt` | [(r) piano string resonance](#ne5-settings-transpose-and-resonance), [(t) global transpose](#ne5-settings-transpose-and-resonance)
| `0x0035` | `ggggg--r` | [(g) MIDI global channel](#ne5-settings-midi-channel), [(r) rotary speaker type](#ne5-settings-rotary-speaker)
| `0x0036` | `rrhhhsss` | [(r) rotary speaker type](#ne5-settings-rotary-speaker), [(h) rotary horn speed](#ne5-settings-rotary-speaker), [(s) rotary rotor speed](#ne5-settings-rotary-speaker)
| `0x0037` | `hhhaaabb` | [(h) rotary horn acceleration](#ne5-settings-rotary-speaker), [(a) rotary rotor acceleration](#ne5-settings-rotary-speaker), [(b) rotary balance](#ne5-settings-rotary-speaker)
| `0x0038` | `bfffsssn` | [(b) rotary balance](#ne5-settings-rotary-speaker), [(f) B3 percussion decay fast](#ne5-settings-b3-organ), [(s) B3 percussion decay slow](#ne5-settings-b3-organ), [(n) B3 percussion volume normal](#ne5-settings-b3-organ)
| `0x0039` | `nnsssttt` | [(n) B3 percussion volume normal](#ne5-settings-b3-organ), [(s) B3 percussion volume soft](#ne5-settings-b3-organ), [(t) B3 tonewheel mode](#ne5-settings-b3-organ)
| `0x003A` | `mkk-btll` | (m) B3 percussion drawbar 9 mute, [(k) B3 key click level](#ne5-settings-b3-organ), (b) B3 key bounce, (t) B3 trig mode (0 = normal, 1 = fast), [(l) MIDI lower part receive channel](#ne5-settings-midi-channel)
| `0x003B` | `llluuuuu` | [(l) MIDI lower part receive channel](#ne5-settings-midi-channel), [(u) MIDI upper part receive channel](#ne5-settings-midi-channel)
| `0x003C` | `osssssmm` | (o) output routing (0 = stereo, 1 = lower left / upper right), [(s) MIDI upper split channel](#ne5-settings-midi-channel), [(m) sustain pedal mode](#ne5-settings-pedals)
| `0x003D` | `-tgggg--` | (t) MIDI transpose at (0 = MIDI in, 1 = MIDI out), [(g) control pedal gain](#ne5-settings-pedals)
| `0x003E` | `--------` | 0
| `0x003F` | `--------` | 0
| `0x0040` | `--------` | 0
| `0x0041` | `--------` | 0
| `0x0042` | `--------` | 0
| `0x0043` | `--------` | 0
| `0x0044` | `--------` | 0
| `0x0045` | `--------` | 0
| `0x0046` | `--------` | 0
| `0x0047` | `--------` | 0
| `0x0048` | `--------` | 0
| `0x0049` | `--------` | 0
| `0x004A` | `--------` | 0
| `0x004B` | `--------` | 0
| `0x004C` | `--------` | 0
| `0x004D` | `--------` | 0


Single bit settings without a link are 0 = off, 1 = on.

### NE5 Settings File Format

| type | description
| :--- | :-------------------------------------------------
| 0    | Legacy header, 24 bytes. Bytes 0x18 to 0x2B are missing, so the body starts at 0x18. The file ends with a 2-byte CRC-16 (IBM-3740, also called CCITT-FALSE, little endian) over every byte before it, header included.
| 1    | Header with checksum, 44 bytes. 0x18 to 0x1B is a CRC-32 (ISO-HDLC / zlib, little endian) over the body only, 0x2C to 0x4D. 0x1C to 0x2B are 0.


### NE5 Settings Version

Always 0 on every file seen. The body repeats it at 0x2C (16-bit, big endian).


### NE5 Settings Power Up Selection

These are not menu settings. They are where the instrument was, and what it returns to when switched on. Each keeps
the last selection of its own mode, so for example the live slot is kept while live mode is off.

Set list mode and live mode: 0 = off, 1 = on. Set list mode is inferred from the files, not confirmed at the panel:
the one file taken in set list mode has it set, while other files have a different song selected with it clear, so
it follows the mode rather than the song.

Live slot: 0 = Live 1, 1 = Live 2, 2 = Live 3. 3 is never seen.

Program is a 9-bit program location, counted straight through the program banks, the same way the song file counts
them:

```
value = (program bank - 1) * 50 + (program location - 1)
```

so 0 = program 1:1, 49 = program 1:50, 50 = program 2:1 . . . 399 = program 8:50.

Song is an 8-bit song location, counted the same way over the 4 song banks: 0 = song 1:1 . . . 199 = song 4:50.
Inferred from the files, not confirmed at the panel.


### NE5 Settings MIDI Message Mode

Control change mode and program change mode.

|value | mode
| :--- | :---
| 0    | Off
| 1    | Send
| 2    | Receive
| 3    | Send & Receive


### NE5 Settings MIDI Channel

Global channel, lower and upper part receive channel, and upper split channel.

0 = channel 1, 1 = channel 2 . . . 15 = channel 16, 16 = off.


### NE5 Settings Pedals

|value | sustain pedal type | control pedal type | rotary pedal type
| :--- | :----------------- | :----------------- | :----------------
| 0    | Auto               | Roland EV-7        | Closed
| 1    | Closed             | Yamaha FC-7        | Open
| 2    | Open               | Korg EXP-2         | Half Moon
| 3    |                    | Korg XVP-10        |
| 4    |                    | Boss FV-500L       |
| 5    |                    | Fatar SL           |

Rotary pedal mode: 0 = Hold, 1 = Toggle.

Sustain pedal mode: 0 = Sustain, 1 = Sustain + Rotor Hold, 2 = Sustain + Rotor Toggle.

Control pedal gain is stored one less than the panel shows: 0 = 1, 1 = 2 . . . 9 = 10. 1 and 10 were captured;
2 to 9 are assumed to follow the same scale.


### NE5 Settings Fine Tune

0 = -50 cents . . . 50 = 0 . . . 100 = +50 cents. -50, 0, +5 and +50 were captured, and -50, 0 and +5 were
written back to the instrument and measured as that many cents of pitch change. The values in between follow the
same scale but were not each captured.


### NE5 Settings Transpose and Resonance

Global transpose: 0 = -6 . . . 6 = 0 . . . 12 = +6 semitones.

Piano string resonance: 0 = -6 dB . . . 6 = 0 dB . . . 12 = +6 dB. Only -6, 0 and +6 dB were captured; the values
in between are assumed to follow the same encoding as global transpose.


### NE5 Settings Rotary Speaker

Rotary speaker type: 0 = 122, 1 = 122 Close. The panel offers more types; their values were not captured.

Horn speed, rotor speed, horn acceleration and rotor acceleration: 0 = Low, 1 = Normal, 2 = High.

|value | balance (bass / horn)
| :--- | :---
| 0    | 70/30
| 1    | 60/40
| 2    | 50/50
| 3    | 40/60
| 4    | 30/70


### NE5 Settings B3 Organ

Percussion decay fast and slow: 0 = Short, 1 = Medium, 2 = Long.

Percussion volume normal and soft: 0 = Low, 1 = Medium, 2 = High.

Tonewheel mode: 0 = Clean, 1 = Vintage 1, 2 = Vintage 2, 3 = Vintage 3.

Key click level: 0 = Low, 1 = Normal, 2 = High, 3 = Higher.
