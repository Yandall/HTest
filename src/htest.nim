import strutils, unittest, nimquery, xmltree
from htmlparser import parseHtml

export unittest, nimquery, xmltree

type
  HTest = ref object
    html: XmlNode
    useNot: bool

proc check*(html: string): HTest =
  ## Use when you want to test for a `html` string
  let xml = html.parseHtml()
  result = HTest(html: xml, useNot: false)

func select*(hTest: HTest, cssQuery: string,
            options: set[QueryOption] = DefaultQueryOptions): HTest =
  ## Selects the first matching element given `cssQuery` or `nil` if can't find anything
  hTest.html = hTest.html.querySelector(cssQuery, options)
  result = hTest

func selectNth*(hTest: HTest, cssQuery: string, n: int,
               options: set[QueryOption] = DefaultQueryOptions): HTest =
  ## Selects the `n` element found by the given `cssQuery`
  hTest.html = hTest.html.querySelectorAll(cssQuery, options)[n]
  result = hTest

func `not`*(hTest: HTest): HTest =
  ## Negates the following assert statement
  hTest.useNot = true
  result = hTest

template toContainElement*(hTest: HTest, cssQuery: string) =
  ## Checks if there is a element described by `cssQuery`
  check hTest.html.querySelector(cssQuery) != nil xor hTest.useNot

template toContainElementsGreaterThan*(hTest: HTest, cssQuery: string, amount: int) =
  ## Checks if there are more than n `amount` of elements described by `cssQuery`
  check hTest.html.querySelectorAll(cssQuery).len > amount xor hTest.useNot

template toContainElementsGreaterThanOrEqual*(hTest: HTest, cssQuery: string, amount: int) =
  ## Checks if there are n `amount` or more elements described by `cssQuery`
  check hTest.html.querySelectorAll(cssQuery).len >= amount xor hTest.useNot

template toContainElementsLessThan*(hTest: HTest, cssQuery: string, amount: int) =
  ## Checks if there are less than n `amount` of elements described by `cssQuery`
  check hTest.html.querySelectorAll(cssQuery).len < amount xor hTest.useNot

template toContainElementsLessThanOrEqual*(hTest: HTest, cssQuery: string, amount: int) =
  ## Checks if there are n `amount` or less of elements described by `cssQuery`
  check hTest.html.querySelectorAll(cssQuery).len <= amount xor hTest.useNot

template toContainNthElements*(hTest: HTest, cssQuery: string, amount: int) =
  ## Checks if there are n `amount` of elements described by `cssQuery`
  check hTest.html.querySelectorAll(cssQuery).len == amount xor hTest.useNot

template toHaveAttribute*(hTest: HTest, attribute: string, value = "") =
  ## Checks if the element have the given `attribute`
  ## If you set `value` it will check if the `attribute` has `value`
  check hTest.html.attr(attribute) != "" xor hTest.useNot 
  if (value != ""):
    check hTest.html.attr(attribute) == value

template toHaveNthAttributes*(hTest: HTest, amount: int) =
  ## Checks if the element have n `amount` of attribute`
  check hTest.html.attrsLen == amount xor hTest.useNot

template innerTextToBe*(hTest: HTest, text: string) =
  ## Checks for the element inner text is equal to `text`
  check hTest.html.innerText == text xor hTest.useNot

template toContainInnerText*(hTest: HTest, text: string) =
  ## Checks if the inner text of the element contains `text`
  check hTest.html.innerText.contains(text) xor hTest.useNot

template tagToBe*(hTest: HTest, tag: string) =
  ## Checks for the element tag is equal to `tag`
  check hTest.html.rawTag == tag xor hTest.useNot
