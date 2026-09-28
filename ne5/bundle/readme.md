\newpage
## Nord Electro 5 Bundle and Backup File Structure

This mapping corresponds to the Nord Electro 5 bundle and backup files.

| extension  | description
| :--------- | :-------------------------------------------------
| ne5pbundle | program bundle: the chosen programs plus every piano and sample they use
| ne5tbundle | song (set list) bundle: the song, the programs it uses, and every piano and sample those programs use
| ne5b       | full backup: settings, live slots, programs, songs, pianos and samples

All three are ordinary ZIP archives. They are not CBIN files and have no Nord header of their own. Every member is
a normal Nord file, byte for byte the same as the standalone file (ne5p, ne5t, ne5s, ne5l, npno, nsmp), so the
other Electro 5 structures apply to the members unchanged. The only extra member is a small XML manifest called
meta.xml.

This layout is not Electro 5 specific. Backups of other Nord models seen so far are the same stored ZIP with a
meta.xml, so the extension (or the member file extensions) is what identifies the model, not meta.xml.

### NE5 Bundle ZIP Layer

Every member is stored (ZIP compression method 0), never deflated, so each member's bytes follow its local file
header unchanged.

Member paths are `<folder>/<sub folder>/<name>.<ext>`, for example:

```
Program/Bank 7/<program name>.ne5p
Set List/Set List 1/<song name>.ne5t
Piano/Grand/<piano name>.npno
Samp Lib/Samp Lib/<sample name>.nsmp
Settings/Settings/Settings.ne5s
Live/Live/Live 1.ne5l
meta.xml
```

For programs and songs the file name is the program or song name, which the file itself does not store anywhere.
The folder names the bank; the location inside the bank is only in the member's own header (0x0C to 0x0F). For
pianos the sub folder is the piano category.

Every central directory entry carries a 1-byte extra field, ascii "0" (0x30) or "1" (0x31). The local file headers
carry no extra field. Its meaning is unknown. It is not alignment padding (no link to name length or offset) and not
"shared by several programs"; both values appear across every kind of member. The ZIP specification asks for at
least 4 bytes in an extra field, so this 1-byte field is a Nord Sound Manager quirk.

### NE5 Bundle Manifest

meta.xml in a bundle (ne5pbundle, ne5tbundle) has a `<bundle>` root element, then one `<file>` element per program
or song:

```
<bundle version="1" product="39" product_version="204"
        content_version="1" source="-1">
  <file name="Program/Bank 7/<program name>.ne5p" depCnt="2"
        dep0="Piano/Harps/<piano name>.npno"
        dep1="Samp Lib/Samp Lib/<sample name>.nsmp"/>
  . . .
</bundle>
```

| attribute | description
| :-------- | :-------------------------------------------------
| name      | member path of the program or song
| depCnt    | number of dependencies that follow
| dep0 . . .| member path of each dependency, in the same archive: for a song its programs (up to 4), for a program its piano and/or sample

On every Electro 5 bundle seen so far the root attributes are version="1", product="39", content_version="1" and
source="-1". product="39" is the same number as product_id in an Electro 5 backup. product_version="204" matches the
instrument's OS version (2.04) when those bundles were made. The meaning of version, content_version and source is
unknown.

### NE5 Backup Manifest

meta.xml in a backup (ne5b) is a single empty `<backup>` element with attributes only and no file list (a backup
holds everything, so no dependency list is needed):

```
<backup file_version="1" backup_format_version="1" product_id="39"
        product_version="204" product_build="592"
        product_content_version="1" manager_version="920"
        manager_build="1462"/>
```

| attribute                | description
| :----------------------- | :-------------------------------------------------
| product_id               | 39 on every Electro 5 backup seen. Backups of other models carry other numbers, so this identifies the model.
| product_version          | instrument OS version x 100: 204 = OS 2.04, 144 on the factory backup whose content is OS 1.44
| manager_version          | Nord Sound Manager version x 100 (920 = 9.20)
| product_build            | build number that goes with product_version (592 with 204, 532 with 144)
| manager_build            | build number that goes with manager_version (1462 with 920, 890 with 731)
| file_version, backup_format_version, product_content_version | always 1 on Electro 5 backups; meaning unknown
