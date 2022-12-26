# Package

version       = "0.1.1"
author        = "Yandall"
description   = "Library to test html strings using css query selectors"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.8", "nimquery"

task test, "Run tests":
  exec "nim c -r --verbosity:0 tests/tests"
  rmFile "tests/tests"

task docs, "Write the package docs":
  exec "nim doc --verbosity:0 --project --index:on " &
    "--git.url:https://github.com/Yandall/HTest " &
    "--git.commit:main " &
    "-o:htmldocs " &
    "src/htest.nim"
