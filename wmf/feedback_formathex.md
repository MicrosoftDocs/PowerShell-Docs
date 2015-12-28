# Format-Hex
**Format-Hex** lets you view text or binary data in hexadecimal format. Here is an example, looking at the hexadecimal representation of a string, as well as the binary contents of a Word document.

PS C:\\&gt; "hello world" | Format-Hex

0 1 2 3 4 5 6 7 8 9 A B C D E F

00000000 68 65 6C 6C 6F 20 77 6F 72 6C 64 hello world

PS C:\\&gt; Format-Hex -Path 'C:\\Users\\slee\\Downloads\\DSP1009\_1 1 1.doc'

Path: C:\\Users\\slee\\Downloads\\DSP1009\_1 1 1.doc

0 1 2 3 4 5 6 7 8 9 A B C D E F

00000000 D0 CF 11 E0 A1 B1 1A E1 00 00 00 00 00 00 00 00 ÐÏ.à¡±.á........

00000010 00 00 00 00 00 00 00 00 3E 00 03 00 FE FF 09 00 ........&gt;...þ...

00000020 06 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00 ................

00000030 DF 01 00 00 00 00 00 00 00 10 00 00 E1 01 00 00 ß...........á...

00000040 01 00 00 00 FE FF FF FF 00 00 00 00 DB 01 00 00 ....þ.......Û...

00000050 DC 01 00 00 DD 01 00 00 DE 01 00 00 E3 01 00 00 Ü...Ý...Þ...ã...

00000060 4F 02 00 00 D8 02 00 00 79 03 00 00 FF FF FF FF O...Ø...y.......
