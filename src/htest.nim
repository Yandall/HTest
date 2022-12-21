import strutils, unittest, nimquery, xmltree
from htmlparser import parseHtml

export unittest, nimquery, xmltree

type
  HTest = ref object
    html: XmlNode
    useNot: bool

proc check*(html: string): HTest =
  let xml = html.parseHtml()
  result = HTest(html: xml, useNot: false)

func select*(hTest: HTest; cssQuery: string;
            options: set[QueryOption] = DefaultQueryOptions): HTest =
  hTest.html = hTest.html.querySelector(cssQuery, options)
  result = hTest

func selectNth*(hTest: HTest; cssQuery: string; n: int;
               options: set[QueryOption] = DefaultQueryOptions): HTest =
  hTest.html = hTest.html.querySelectorAll(cssQuery, options)[n]
  result = hTest

func `not`*(hTest: HTest): HTest =
  hTest.useNot = true
  result = hTest

template toContainElement*(hTest: HTest; cssQuery: string) =
  check hTest.html.querySelector(cssQuery) != nil xor hTest.useNot

template toContainElementsGreaterThan*(hTest: HTest; cssQuery: string; amount: int) =
  check hTest.html.querySelectorAll(cssQuery).len > amount xor hTest.useNot

template toContainElementsGreaterThanOrEqual*(hTest: HTest; cssQuery: string; amount: int) =
  check hTest.html.querySelectorAll(cssQuery).len >= amount xor hTest.useNot

template toContainElementsLessThan*(hTest: HTest; cssQuery: string; amount: int) =
  check hTest.html.querySelectorAll(cssQuery).len < amount xor hTest.useNot

template toContainElementsLessThanOrEqual*(hTest: HTest; cssQuery: string; amount: int) =
  check hTest.html.querySelectorAll(cssQuery).len <= amount xor hTest.useNot

template toContainNthElements*(hTest: HTest; cssQuery: string; amount: int) =
  check hTest.html.querySelectorAll(cssQuery).len == amount xor hTest.useNot

template toHaveAttribute*(hTest: HTest; attribute: string) =
  check hTest.html.attr(attribute) != "" xor hTest.useNot

template toHaveNthAttributes*(hTest: HTest; amount: int) =
  check hTest.html.attrsLen == amount xor hTest.useNot

template innerTextToBe*(hTest: HTest; text: string) =
  check hTest.html.innerText == text xor hTest.useNot

template toContainInnerText*(hTest: HTest; text: string) =
  check hTest.html.innerText.contains(text) xor hTest.useNot

template tagToBe*(hTest: HTest; tag: string) =
  check hTest.html.rawTag == tag xor hTest.useNot
