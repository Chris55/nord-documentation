\newpage
## Nord Electro 5 Program File Structure

This mapping corresponds to the Nord Electro 5 program file (file extension ne5p). A live file (ne5l) has the
same body, see [Nord Electro 5 Live File Structure](#nord-electro-5-live-file-structure).

Offset 0x04 defines the file header format.

| type  | size  | description
| :---: | :---: | :------------------------
| 0     |  147  | Legacy format: bytes 0x18 to 0x2B are missing, and a CRC-16 is added at the end of the file. The factory programs use it.
| 1     |  165  | New format with bytes 0x18 to 0x2B (20 bytes), written by Nord Sound Manager 7.40 and later.

The offsets below are for type 1. In a type 0 file the body starts at 0x18, so every body offset is 0x14 lower.

Unlike the Nord Stage program file, the Electro 5 program keeps the complete state of all four organ models and
both of their presets at all times, not only the selected one.

Each memory offset corresponds to an 8-bit value. In the documentation below `--xxxxxx` means bit 5 to bit 0 are
used. A value that spans bytes is read most significant bit first: the bits in the earlier byte are the high bits.

| offset   | bits       | description
| :---:    |   :----:   | :-------------------------------------------------
| `0x0000` | `cccccccc` | (c) 4-byte Clavia ID, ascii C - 0x43
| `0x0001` | `cccccccc` | ascii B - 0x42
| `0x0002` | `cccccccc` | ascii I - 0x49
| `0x0003` | `cccccccc` | ascii N - 0x4E
| `0x0004` | `ffffffff` | [(f) file format (32-bit, little endian)](#ne5-file-format)
| `0x0005` | `ffffffff` |
| `0x0006` | `ffffffff` |
| `0x0007` | `ffffffff` |
| `0x0008` | `iiiiiiii` | (i) 4-byte file ID, ascii n - 0x6E
| `0x0009` | `iiiiiiii` | ascii e - 0x65
| `0x000A` | `iiiiiiii` | ascii 5 - 0x35
| `0x000B` | `iiiiiiii` | ascii p - 0x70
| `0x000C` | `bbbbbbbb` | (b) bank (16-bit, little endian), 0 = bank 1 . . . 7 = bank 8
| `0x000D` | `bbbbbbbb` |
| `0x000E` | `llllllll` | (l) location (16-bit, little endian), 0 = location 1 . . . 49 = location 50
| `0x000F` | `llllllll` |
| `0x0010` | `--------` | 0xFF
| `0x0011` | `--------` | 0xFF
| `0x0012` | `--------` | 0xFF
| `0x0013` | `--------` | 0xFF
| `0x0014` | `vvvvvvvv` | [(v) version (32-bit, little endian)](#ne5-program-version)
| `0x0015` | `vvvvvvvv` |
| `0x0016` | `vvvvvvvv` |
| `0x0017` | `vvvvvvvv` |
| `0x0018` | `cccccccc` | [(c) CRC-32 (32-bit, little endian)](#ne5-file-format)
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
| `0x002C` | `vvvvvvvv` | [(v) version (16-bit, big endian), repeated - start of body](#ne5-program-version)
| `0x002D` | `vvvvvvvv` |
| `0x002E` | `llluuuoo` | [(l) lower part](#ne5-part), [(u) upper part](#ne5-part), [(o) lower octave shift](#ne5-octave-shift)
| `0x002F` | `oouuuust` | [(o) lower octave shift](#ne5-octave-shift), [(u) upper octave shift](#ne5-octave-shift), (s) lower sustain pedal, (t) upper sustain pedal
| `0x0030` | `cd-spppt` | (c) lower control pedal, (d) upper control pedal, (s) split on, [(p) split point](#ne5-split-point), [(t) transpose on](#ne5-transpose)
| `0x0031` | `ttttmmmm` | [(t) transpose](#ne5-transpose), [(m) part mix](#ne5-part-mix)
| `0x0032` | `mmmggggg` | [(m) part mix](#ne5-part-mix), [(g) gain](#ne5-knob-scale)
| `0x0033` | `ggooolud` | [(g) gain](#ne5-knob-scale), [(o) organ model](#ne5-organ-model), (l) lower enabled, (u) upper enabled, [(d) drawbar live](#ne5-drawbar-live)
| `0x0034` | `--------` | 0
| `0x0035` | `--------` | 0
| `0x0036` | `--------` | 0
| `0x0037` | `--------` | 0
| `0x0038` | `--------` | 0
| `0x0039` | `--------` | 0
| `0x003A` | `ccc--mmm` | [(c) piano category](#ne5-piano-category), [(m) piano model](#ne5-piano-model), start of Piano section
| `0x003B` | `mm-----c` | [(m) piano model](#ne5-piano-model), [(c) clavinet model](#ne5-clavinet-model)
| `0x003C` | `caattmii` | [(c) clavinet model](#ne5-clavinet-model), [(a) piano acoustics](#ne5-piano-acoustics), [(t) piano touch](#ne5-piano-touch), (m) piano mono, [(i) piano id (32-bit)](#ne5-piano-and-sample-id)
| `0x003D` | `iiiiiiii` |
| `0x003E` | `iiiiiiii` |
| `0x003F` | `iiiiiiii` |
| `0x0040` | `iiiiii--` |
| `0x0041` | `--------` | 0
| `0x0042` | `--------` | 0
| `0x0043` | `--------` | 0
| `0x0044` | `--------` | 0
| `0x0045` | `--------` | 0
| `0x0046` | `aaaaaaad` | [(a) sample attack](#ne5-sample-attack), [(d) sample decay release](#ne5-sample-decay-release), start of Sample section
| `0x0047` | `ddddddnn` | [(d) sample decay release](#ne5-sample-decay-release), [(n) sample number](#ne5-sample-number)
| `0x0048` | `nnnnnnii` | [(n) sample number](#ne5-sample-number), [(i) sample id (32-bit)](#ne5-piano-and-sample-id)
| `0x0049` | `iiiiiiii` |
| `0x004A` | `iiiiiiii` |
| `0x004B` | `iiiiiiii` |
| `0x004C` | `iiiiiidd` | [(i) sample id (32-bit)](#ne5-piano-and-sample-id), (d) sample dynamics (0 to 3)
| `0x004D` | `f-------` | (f) sample filter
| `0x004E` | `--------` | start of Organ section
| `0x004F` | `--------` |
| `0x0050` | `--------` |
| `0x0051` | `vvvhss--` | [(v) B3 vibrato chorus type](#ne5-vibrato-chorus-type), [(h) B3 percussion third harmonic](#ne5-b3-percussion), [(s) B3 percussion speed](#ne5-b3-percussion)
| `0x0052` | `--------` |
| `0x0053` | `-p------` | [(p) B3 selected preset](#ne5-organ-preset)
| `0x0054` | `--------` | [unused](#ne5-organ-unused-bits)
| `0x0055` | `dddddddd` | [(d) B3 preset 1 drawbars](#ne5-drawbars)
| `0x0056` | `dddddddd` |
| `0x0057` | `dddddddd` |
| `0x0058` | `dddddddd` |
| `0x0059` | `ddddvpbb` | [(d) B3 preset 1 drawbars](#ne5-drawbars), (v) B3 preset 1 vibrato chorus on, [(p) B3 preset 1 percussion on](#ne5-b3-percussion), [(b) B3 + Bass bass drawbar 1](#ne5-b3-bass-drawbars)
| `0x005A` | `bbcccc--` | [(b) B3 + Bass bass drawbar 1](#ne5-b3-bass-drawbars), [(c) B3 + Bass bass drawbar 2](#ne5-b3-bass-drawbars)
| `0x005B` | `--------` |
| `0x005C` | `dddddddd` | [(d) B3 preset 2 drawbars](#ne5-drawbars)
| `0x005D` | `dddddddd` |
| `0x005E` | `dddddddd` |
| `0x005F` | `dddddddd` |
| `0x0060` | `ddddvp--` | [(d) B3 preset 2 drawbars](#ne5-drawbars), (v) B3 preset 2 vibrato chorus on, [(p) B3 preset 2 percussion on](#ne5-b3-percussion), [unused](#ne5-organ-unused-bits)
| `0x0061` | `--------` | [unused](#ne5-organ-unused-bits)
| `0x0062` | `--------` |
| `0x0063` | `vvv-----` | [(v) Vox vibrato chorus type](#ne5-vibrato-chorus-type)
| `0x0064` | `--------` |
| `0x0065` | `-p------` | [(p) Vox selected preset](#ne5-organ-preset)
| `0x0066` | `--------` |
| `0x0067` | `dddddddd` | [(d) Vox preset 1 drawbars](#ne5-drawbars)
| `0x0068` | `dddddddd` |
| `0x0069` | `dddddddd` |
| `0x006A` | `dddddddd` |
| `0x006B` | `ddddv---` | [(d) Vox preset 1 drawbars](#ne5-drawbars), (v) Vox preset 1 vibrato chorus on
| `0x006C` | `--------` |
| `0x006D` | `dddddddd` | [(d) Vox preset 2 drawbars](#ne5-drawbars)
| `0x006E` | `dddddddd` |
| `0x006F` | `dddddddd` |
| `0x0070` | `dddddddd` |
| `0x0071` | `ddddv---` | [(d) Vox preset 2 drawbars](#ne5-drawbars), (v) Vox preset 2 vibrato chorus on
| `0x0072` | `--------` |
| `0x0073` | `vvv-----` | [(v) Farfisa vibrato chorus type](#ne5-vibrato-chorus-type)
| `0x0074` | `--------` |
| `0x0075` | `-p------` | [(p) Farfisa selected preset](#ne5-organ-preset)
| `0x0076` | `--------` |
| `0x0077` | `dddddddd` | [(d) Farfisa preset 1 tabs](#ne5-drawbars)
| `0x0078` | `dddddddd` |
| `0x0079` | `dddddddd` |
| `0x007A` | `dddddddd` |
| `0x007B` | `ddddv---` | [(d) Farfisa preset 1 tabs](#ne5-drawbars), (v) Farfisa preset 1 vibrato chorus on
| `0x007C` | `--------` |
| `0x007D` | `dddddddd` | [(d) Farfisa preset 2 tabs](#ne5-drawbars)
| `0x007E` | `dddddddd` |
| `0x007F` | `dddddddd` |
| `0x0080` | `dddddddd` |
| `0x0081` | `ddddv---` | [(d) Farfisa preset 2 tabs](#ne5-drawbars), (v) Farfisa preset 2 vibrato chorus on
| `0x0082` | `--------` |
| `0x0083` | `--------` |
| `0x0084` | `--------` |
| `0x0085` | `-p------` | [(p) Pipe selected preset](#ne5-organ-preset)
| `0x0086` | `--------` |
| `0x0087` | `dddddddd` | [(d) Pipe preset 1 drawbars](#ne5-drawbars)
| `0x0088` | `dddddddd` |
| `0x0089` | `dddddddd` |
| `0x008A` | `dddddddd` |
| `0x008B` | `dddd----` | [unused](#ne5-organ-unused-bits)
| `0x008C` | `--------` |
| `0x008D` | `dddddddd` | [(d) Pipe preset 2 drawbars](#ne5-drawbars)
| `0x008E` | `dddddddd` |
| `0x008F` | `dddddddd` |
| `0x0090` | `dddddddd` |
| `0x0091` | `dddd----` |
| `0x0092` | `--------` |
| `0x0093` | `ppttttrr` | [(p) effect 1 part select](#ne5-effect-part-select), [(t) effect 1 type](#ne5-effect-1-type), [(r) effect 1 rate](#ne5-effect-1-rate), start of Effects section
| `0x0094` | `rrrrrppt` | [(r) effect 1 rate](#ne5-effect-1-rate), [(p) effect 2 part select](#ne5-effect-part-select), [(t) effect 2 type](#ne5-effect-2-type)
| `0x0095` | `tttrrrrr` | [(t) effect 2 type](#ne5-effect-2-type), [(r) effect 2 rate](#ne5-effect-2-rate)
| `0x0096` | `rrppfftt` | [(r) effect 2 rate](#ne5-effect-2-rate), [(p) delay part select](#ne5-effect-part-select), (f) delay feedback (0 to 3), [(t) delay tempo](#ne5-delay-tempo)
| `0x0097` | `tttttwww` | [(t) delay tempo](#ne5-delay-tempo), [(w) delay wet dry](#ne5-knob-scale)
| `0x0098` | `wwwwpe-f` | [(w) delay wet dry](#ne5-knob-scale), (p) delay ping pong, [(e) equalizer on](#ne5-equalizer), [(f) equalizer mid frequency](#ne5-equalizer)
| `0x0099` | `fffffftt` | [(f) equalizer mid frequency](#ne5-equalizer), [(t) equalizer treble](#ne5-equalizer)
| `0x009A` | `tttttmmm` | [(t) equalizer treble](#ne5-equalizer), [(m) equalizer mid gain](#ne5-equalizer)
| `0x009B` | `mmmmbbbb` | [(m) equalizer mid gain](#ne5-equalizer), [(b) equalizer bass](#ne5-equalizer)
| `0x009C` | `bbbppttt` | [(b) equalizer bass](#ne5-equalizer), [(p) effect 3 part select](#ne5-effect-part-select), [(t) effect 3 type](#ne5-effect-3-type)
| `0x009D` | `cccccccr` | [(c) effect 3 compression](#ne5-knob-scale), (r) reverb on
| `0x009E` | `tttwwwww` | [(t) reverb type](#ne5-reverb-type), [(w) reverb wet dry](#ne5-knob-scale)
| `0x009F` | `wwms----` | [(w) reverb wet dry](#ne5-knob-scale), (m) rotary speaker stop mode, (s) rotary speaker speed (0 = slow, 1 = fast), [unused](#ne5-dead-trailing-bits)
| `0x00A0` | `--------` | [unused](#ne5-dead-trailing-bits)
| `0x00A1` | `---cdee-` | [unused](#ne5-dead-trailing-bits), (c) effect 1 control pedal, (d) effect 2 deep, [(e) equalizer part select](#ne5-equalizer)
| `0x00A2` | `--------` | 0
| `0x00A3` | `--------` | 0
| `0x00A4` | `--------` | 0


Single bit settings without a link are 0 = off, 1 = on.

### NE5 File Format

| type | description
| :--- | :-------------------------------------------------
| 0    | Legacy header, 24 bytes. Bytes 0x18 to 0x2B are missing, so the body starts at 0x18. The file ends with a 2-byte CRC-16 (IBM-3740, also called CCITT-FALSE, little endian) over every byte before it, header included.
| 1    | Header with checksum, 44 bytes. 0x18 to 0x1B is a CRC-32 (ISO-HDLC / zlib, little endian) over the body only, 0x2C to the end of the file. 0x1C to 0x2B are 0.

The factory programs are type 0. Nord Sound Manager 7.40 and later writes type 1.


### NE5 Program Version

Always 4 on every file seen. The body repeats it at 0x2C (16-bit, big endian).


### NE5 Part

|value | part
| :--- | :---
| 0    | Organ
| 1    | Piano
| 2    | Sample


### NE5 Octave Shift

Stored as the shift plus 7: 1 = -6 . . . 7 = 0 . . . 13 = +6.


### NE5 Split Point

|value | split point
| :--- | :---
| 0    | C3
| 1    | F3
| 2    | C4
| 3    | F4
| 4    | C5
| 5    | F5
| 6    | Upper
| 7    | Lower


### NE5 Transpose

Transpose is stored as the transposition plus 6: 0 = -6 . . . 6 = 0 . . . 12 = +6.

Transpose on is set the first time the transpose is changed and is never cleared again, so it stays on after the
transpose is put back to 0. The transpose light is on only when transpose on is set and the transpose is not 0.
While transpose on is clear, transpose holds 7 (+1) and means nothing.


### NE5 Part Mix

0 - 127. 64 = both parts at full level. Above 64 the lower part is turned down, below 64 the upper part.


### NE5 Knob Scale

Gain, delay wet dry, reverb wet dry and effect 3 compression are 0 - 127 on a linear scale, shown as 0 - 10 on the
panel.


### NE5 Organ Model

|value | organ model
| :--- | :---
| 0    | B3
| 1    | B3 + Bass
| 2    | Pipe
| 3    | Vox
| 4    | Farfisa


### NE5 Drawbar Live

0 = off, 1 = on. Drawbar Sync is a momentary command and is not stored.


### NE5 Piano Category

|value | category
| :--- | :---
| 0    | Grand
| 1    | Upright
| 2    | Electric Piano 1
| 3    | Electric Piano 2
| 4    | Clavinet
| 5    | Harpsichord


### NE5 Piano Model

0 = first model in the category, 1 = second . . .

Category and model together are the piano's position in the instrument's library. The library is organised one
bank per category, so category is the bank and model is the slot within it, both counted from 0: the piano in bank 3
slot 2 stores 2/1. These are positions, so they move if the library is reorganised - the piano id is the stable
reference.


### NE5 Clavinet Model

0 to 3. Only set when the piano category is Clavinet, 0 otherwise.


### NE5 Piano Acoustics

|value | acoustics
| :--- | :---
| 0    | Off
| 1    | String Resonance
| 2    | Long Release
| 3    | String Resonance and Long Release

The names come from the settings the test files were made with. String Resonance was confirmed by ear; Long Release
made no audible difference on the piano it was tried with.


### NE5 Piano Touch

0 = off, 1 = touch 1, 2 = touch 2, 3 = touch 3.

Touch remaps the velocity played rather than the level. All three settings lift soft notes by about 10 velocity
steps; the higher the setting, the more the middle of the range is lifted too.


### NE5 Piano and Sample ID

32-bit identifier of the piano (npno) or sample (nsmp) the program depends on, 0 = none.

This is the identity of the piano or sample, independent of where it sits in the library. The instrument reports
the same value when asked for a program's dependencies over USB, which is how a program can be matched to what it
needs.


### NE5 Sample Attack

0 - 127, 0 = 0.5 ms to 127 = 45 s. The curve in between is not known.


### NE5 Sample Decay Release

One knob covers both: 0 = 3 ms decay . . . 64 = sustain . . . 127 = longest release. Below 64 it sets a decay,
above 64 a release, and 64 (sustain) is the knob's centre detent.


### NE5 Sample Number

Position of the sample in the Samp Lib, counted from 0 (0 = the sample shown as 1 on the panel).

This is a panel position only. It does not match the sample's slot in the instrument's sample library, and it is
reused - the same number appears against different samples, and the same sample appears under different numbers.
The instrument does not use it to pick the sample: a program whose number and id disagree plays the sample the id
names. Use the sample id to identify a sample.


### NE5 Organ Preset

0 = preset 1, 1 = preset 2. One per organ model.


### NE5 Drawbars

9 drawbars per model and preset, packed one per nibble, high nibble first. Each nibble is the physical drawbar
position, 0 to 8, stored as its own value.

Farfisa has on/off tabs rather than continuous drawbars. The file still stores a 0 to 8 position per tab, and 5 or
higher reads as on, below 5 as off. The exact position below or above the threshold varies between files that show
the same tab state.

In B3 + Bass, preset 1's first two nibbles are not used, see [NE5 B3 Bass Drawbars](#ne5-b3-bass-drawbars).


### NE5 Vibrato Chorus Type

One per model, shared by both presets. Each model offers a different set of modes, so the same stored value means
different things depending on the model. Pipe has no vibrato chorus.

|value | B3  | Vox | Farfisa
| :--- | :-- | :-- | :------
| 0    | V1  | V1  | V1
| 1    | C1  | V2  | V2
| 2    | V2  | V3  | C2
| 3    | C2  |     | C3
| 4    | V3  |     |
| 5    | C3  |     |


### NE5 B3 Percussion

Percussion on is per preset (0x59 b2 for preset 1, 0x60 b2 for preset 2). Third harmonic and speed are shared.

Third harmonic: 0 = off (second harmonic), 1 = on (third harmonic).

|value | speed
| :--- | :---
| 0    | Off
| 1    | Fast
| 2    | Soft
| 3    | Both

The stored speed values are not in panel order.


### NE5 B3 Bass Drawbars

When the organ model is B3 + Bass, the two presets are different instruments. Preset 1 is the bass manual and only
has the two bass drawbars; preset 2 is an ordinary B3 and uses the normal nine nibbles at 0x5C.

The bass registration is not in preset 1's nine-nibble block at 0x55, which holds stale values in this mode: moving
the bass drawbars leaves its first two nibbles unchanged, neither 0 nor the bass values. The two bass drawbars are
0 to 8, stored as themselves:

```
bass drawbar 1 = ((byte at 0x59 AND 0x03) << 2) OR (byte at 0x5A >> 6)
bass drawbar 2 = (byte at 0x5A >> 2) AND 0x0F
```

0x59 b3 and b2 are the B3 preset 1 vibrato chorus and percussion bits, so mask them off. Whether the bass manual
responds to them is not known.


### NE5 Organ Unused Bits

- 0x54: always 0. The keyboard writes 0 here every time a program is stored.
- 0x60 b1-0 and 0x61 b7-2: these sit where a preset 2 copy of the B3 + Bass bass drawbars would be, with the same
  layout, and fresh programs hold 8 and 8 in them (0x60 b1-0 = 2, 0x61 = 0x20). The keyboard (firmware 2.04) neither
  reads nor writes them: other values put here change nothing, and storing the program keeps them.
- 0x8B b3: where the other models keep their preset 1 vibrato chorus on. It is 1 in almost every file, but the
  vibrato chorus button does not respond while Pipe is selected, so it cannot be changed from the panel.


### NE5 Effect Part Select

Effects 1, 2, 3 and the delay each have a part select that doubles as their on/off.

|value | part
| :--- | :---
| 0    | Off
| 1    | Off, as written by older firmware
| 2    | Lower
| 3    | Upper

The keyboard treats a stored 1 as off and keeps it when the program is stored again. Current firmware writes 0.


### NE5 Effect 1 Type

|value | type
| :--- | :---
| 0    | TREM1
| 1    | TREM2
| 2    | TREM1&2
| 3    | PAN1
| 4    | PAN2
| 5    | PAN1&2
| 6    | WAH
| 7    | RM

The stored values are not in panel order.


### NE5 Effect 1 Rate

0 - 127 on a linear scale, shown as 1 - 10 on the panel.


### NE5 Effect 2 Type

|value | type
| :--- | :---
| 0    | PHAS1
| 1    | PHAS2
| 2    | FLANGE
| 3    | CHOR1
| 4    | CHOR2
| 5    | VIBE

The stored values are not in panel order.


### NE5 Effect 2 Rate

0 - 127, 0 = 0 Hz to 127 = 10.5 Hz. The curve in between is not known.


### NE5 Effect 3 Type

|value | type
| :--- | :---
| 0    | None
| 1    | Small
| 2    | JC
| 3    | Twin
| 4    | Rotary
| 5    | Comp

The stored values are not in panel order.


### NE5 Delay Tempo

0 - 127, running backwards: 0 = 750 ms and 127 = 20 ms.


### NE5 Reverb Type

|value | type
| :--- | :---
| 0    | Room
| 1    | Stage Soft
| 2    | Stage
| 3    | Hall Soft
| 4    | Hall

The stored values are not in panel order.


### NE5 Equalizer

Equalizer on (0x98 b2) and the equalizer part select (0xA1 b2-1) are in different bytes and have to be read
together: part select 0 means Lower, not off.

|value | part
| :--- | :---
| 0    | Lower
| 1    | Upper
| 2    | Lower + Upper

Bass, mid gain and treble: 0 - 127, 0 = -15 dB, 64 = 0 dB (centre), 127 = +15 dB.

Mid frequency: 0 - 127, 0 = 200 Hz to 127 = 8 kHz. The curve in between is not known.


### NE5 Dead Trailing Bits

0x9F b2-0, 0xA0 and 0xA1 b7-5 are not read by the keyboard. Usually 0, but some older files carry other values here.
They make no difference to the sound or the panel, and storing the program on the keyboard keeps them unchanged.
