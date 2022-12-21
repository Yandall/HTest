# Package

version       = "0.1.0"
author        = "Yandall"
description   = "Library to test html strings using css query selectors"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.8", "nimquery"

task test, "Run tests":
  exec "nim c -r --verbosity:0 tests/tests"
  rmFile "tests/tests"
