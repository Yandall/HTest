import htest

let html = """
<!DOCTYPE html>
<html>
  <head><title>Example</title></head>
  <body>
    <p id="unique">1</p>
    <p>2</p>
    <p>3</p>
    <p>4</p>
  </body>
</html>
"""

suite "Testing different statements":
  test "Contains at least one 'p' element":
    check(html).toContainElement("p")

  test "Contains exactly four 'p' elements":
    check(html).toContainNthElements("p", 4)

  test "Contains at least three 'p' elements":
    check(html).toContainElementsGreaterThanOrEqual("p", 3)

  test "Doesn't contains any 'a' element":
    check(html).not.toContainElement("a")

  test "Select contains 'title' element inside 'head' element":
    check(html).select("head").toContainElement("title")

  test "Tag of element is 'p'":
    check(html).select("p").tagToBe("p")

  test "Inner text of 'p' is 3":
    check(html).selectNth("p", 2).innerTextToBe("3")

  test "Inner text contains 'Example'":
    check(html).toContainInnerText("Example")

  test "Element have attributes":
    check(html).select("#unique").toHaveAttribute("id")

  test "Element has exactly 1 attributes":
    check(html).select("#unique").toHaveNthAttributes(1)

  test "Throw error 'IndexDeffect'":
    expect IndexDefect:
      check(html).selectNth("p", 5).innerTextToBe("3")
