# syntax: shell

swift_operator_chars() {

  emulate -L zsh
  setopt cbases

  print -- "Swift Programming Language: Valid Identifier/Operator Characters\n\n"

  print -- "Latin-1 Supplement: "
  for i in 0x00A1 0x00A2 0x00A3 0x00A4 0x00A5 0x00A6 0x00A7 0x00A9 0x00AB 0x00AC 0x00AE 0x00B0 0x00B1 0x00B6 0x00BB 0x00BF 0x00D7 0x00F7 0x2016 0x2017; do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  for (( i = 0x2020; i <= 0x2027; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nGeneral Punctuation: "
  for (( i = 0x2030; i <= 0X203E; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  for (( i = 0x2041; i <= 0x2053; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  for (( i = 0x2055; i <= 0X205E; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nArrows: "
  for (( i = 0x2190; i <= 0X21FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nMathematical Operators: "
  for (( i = 0x2200; i <= 0X22FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nMiscellaneous Technical: "
  for (( i = 0x2300; i <= 0X23FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nBox Drawing: "
  for (( i = 0x2500; i <= 0x257F; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nBlock Elements: "
  for (( i = 0x2580; i <= 0x259F; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nGeometric Shapes: "
  for (( i = 0x25A0; i <= 0x25FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nMiscellaneous Symbols: "
  for (( i = 0x2600; i <= 0X26FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nDingbats: "
  for (( i = 0x2700; i <= 0X27BF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nMiscellaneous Math Symbols-A: "
  for (( i = 0x27C0; i <= 0X27EF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nSupplemental Arrows-A: "
  for (( i = 0x27F0; i <= 0X27FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nBraille Patterns: "
  for (( i = 0x2800; i <= 0X28FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nSupplemental Arrows-B: "
  for (( i = 0x2900; i <= 0X29FF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nMiscellaneous Math Symbols-B: "
  for (( i = 0x2B80; i <= 0X2BFF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nSupplemental Math Operators: "
  for (( i = 0x2A00; i <= 0X2AFF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nMiscellaneous Symbols and Arrows: "
  for (( i = 0x2B00; i <= 0X2BFF; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nSupplemental Punctuation: "
  for (( i = 0X2E00; i <= 0X2E7F; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n\nCJK Symbols and Punctuation: "
  for (( i = 0x3001; i <= 0x3003; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done
  for (( i = 0x3008; i <= 0x3030; i++ )); do
    print -n -- "\\u"$(( [##16] $i ))" "
  done

  print -- "\n"

}
