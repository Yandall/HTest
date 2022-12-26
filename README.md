# HTest
A library to make simple test on html strings using css querys
```nim
check(html).toContainElement("p.myClass")
```
# Installation
Use nimble to install HTest 

```shell 
nimble install htest
```

# Usage

```nim
import htest

let html = """
<html>
  <head><title>HTest</title></head>
  <body>
    <a id="unique">1</a>
    <a>2</a>
    <a>3</a>
    <a>4</a>
  </body>
</html>
"""

test "Contains at least one 'a' element":
 	check(html).toContainElement("a")

test "Contains exactly four 'a' elements":
	check(html).toContainNthElements("a", 4)

test "Doesn't contains any 'p' element":
	check(html).not.toContainElement("p")
  
test "Element has exactly 1 attributes":
	check(html).select("#unique").toHaveNthAttributes(1)
```

For more examples see `tests/tests.nim`

# API Reference

```nim
proc check(html: string): HTest 
```
Use it to start making a test

```nim
func select(hTest: HTest, cssQuery: string,
            options: set[QueryOption] = DefaultQueryOptions): HTest
```

Use it to select a element inside the html with a css selector. To know more about `options` see [nimquery](https://github.com/GULPF/nimquery "nimquery")

```nim
func selectNth(hTest: HTest, cssQuery: string, n: int,
               options: set[QueryOption] = DefaultQueryOptions): HTest
```
Selects the `n` element found by the given `cssQuery`. Throws `IndexDeffect` if `n` is larger than the lenght of the seq found by
the css selector

```nim
func `not`(hTest: HTest): HTest 
```
Negates the following assert statement

```nim
template toContainElement(hTest: HTest, cssQuery: string)
```
Checks if there is a element described by `cssQuery`

```nim
template toContainElementsGreaterThan(hTest: HTest, cssQuery: string, amount: int)
```
Checks if there are more than n `amount` of elements described by `cssQuery`

```nim
template toContainElementsGreaterThanOrEqual(hTest: HTest, cssQuery: string, amount: int)
```
Checks if there are n `amount` or more elements described by `cssQuery`

```nim
template toContainElementsLessThan(hTest: HTest, cssQuery: string, amount: int)
```
Checks if there are less than n `amount` of elements described by `cssQuery`

```nim
template toContainElementsLessThanOrEqual(hTest: HTest, cssQuery: string, amount: int)
```
Checks if there are n `amount` or less of elements described by `cssQuery`

```nim
template toContainNthElements(hTest: HTest, cssQuery: string, amount: int) 
```
Checks if there are n `amount` of elements described by `cssQuery`

```nim
template toHaveAttribute(hTest: HTest, attribute: string, value = "")
```
Checks if the element have the given `attribute`.
If you set `value` it will check if the `attribute` has `value`

```nim
template toHaveNthAttributes(hTest: HTest, amount: int)
```
Checks if the element have n `amount` of attributes

```nim
template innerTextToBe(hTest: HTest, text: string)
```
Checks for the element inner text is equal to `text`

```nim
template toContainInnerText(hTest: HTest, text: string) 
```
Checks if the inner text of the element contains `text`

```nim
template tagToBe(hTest: HTest, tag: string) 
```
Checks for the element tag is equal to `tag`

