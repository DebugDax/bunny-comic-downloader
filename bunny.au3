#include <inet.au3>
#include <string.au3>

$url = 'http://www.bunny-comic.com/'
Global $i = 1

DirCreate(@ScriptDir & "\comics")

While 1
	TraySetToolTip("Bunny Comic" & @CRLF & $i & "...")
	$source = _INetGetSource($url & $i & ".html", True)
	If StringInStr($source, "<img src='") Then
		$img = _StringBetween($source, "<img src='", "'")
		If IsArray($img) Then
			$name = _StringBetween($img[0], "strips/", ".")
			If IsArray($name) Then
				$ext = StringRight($img[0], 4)
				$name[0] = StringReplace($name[0], "/", " ")
				$name[0] = StringReplace($name[0], "\", " ")
				$name[0] = StringReplace($name[0], "&", "")
				$name[0] = StringReplace($name[0], "*", "")
				$name[0] = StringReplace($name[0], "?", "")
				$name[0] = StringReplace($name[0], ")", "")
				$name[0] = StringReplace($name[0], "(", "")
				If Not FileExists(@ScriptDir & "\comics\" & $i & " " & $name[0] & $ext) Then
					ConsoleWrite($i & ": " & $name[0] & $ext & @CRLF)
					InetGet($url & $img[0], @ScriptDir & "\comics\" & $i & " " & $name[0] & $ext, 3, 0)
				Else
					ConsoleWrite('Skipping: ' & $i & @CRLF)
				EndIf
			Else
				ConsoleWrite('Skipping: ' & $i & @CRLF)
			EndIf
		EndIf
	Else
		ConsoleWrite('Skipping: ' & $i & @CRLF)
	EndIf
	$i = $i + 1
	;sleep(Random(1000,2400,1))
WEnd
