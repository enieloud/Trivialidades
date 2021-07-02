Estos serían los Tests:

```swift
class FizzBuzzTests {
    let fizzBuzz = FizzBuzz()

    func testN(n: Int, expectedAnswer: String) {
        if fizzBuzz.fizzBuzz(n: n) == expectedAnswer {
            print("test \(n) passed")
        } else {
            print("test \(n) failed")
        }
    }

    func testAll() {
        testN(n: 0,expectedAnswer: "0")
        testN(n: 1,expectedAnswer: "1")
        testN(n: 2,expectedAnswer: "2")
        testN(n: 3,expectedAnswer: "Fizz")
        testN(n: 4,expectedAnswer: "4")
        testN(n: 5,expectedAnswer: "Fuzz")
        testN(n: 6,expectedAnswer: "Fizz")
        testN(n: 7,expectedAnswer: "7")
        testN(n: 8,expectedAnswer: "8")
        testN(n: 9,expectedAnswer: "Fizz")
        testN(n: 10,expectedAnswer: "Fuzz")
        testN(n: 11,expectedAnswer: "11")
        testN(n: 12,expectedAnswer: "Fizz")
        testN(n: 13,expectedAnswer: "13")
        testN(n: 14,expectedAnswer: "14")
        testN(n: 15,expectedAnswer: "FizzFuzz")
    }
}

let fizbuzzTester = FizzBuzzTests()
fizbuzzTester.testAll()
```
## Iteración 1: Falla todos los tests

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        return ""
    }
}
```

Resultado de los Test:
```
test 0 failed
test 1 failed
test 2 failed
test 3 failed
test 4 failed
test 5 failed
test 6 failed
test 7 failed
test 8 failed
test 9 failed
test 10 failed
test 11 failed
test 12 failed
test 13 failed
test 14 failed
test 15 failed
```

## Iteración 2: Pasa el caso 0

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        if n == 0 {
            return "0"
        }
        return ""
    }
}
```

Resultado de los Test:
```
test 0 passed
test 1 failed
test 2 failed
test 3 failed
test 4 failed
test 5 failed
test 6 failed
test 7 failed
test 8 failed
test 9 failed
test 10 failed
test 11 failed
test 12 failed
test 13 failed
test 14 failed
test 15 failed
```

## Iteración 3: Pasa el caso 0, 1

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        if n == 0  || n == 1 {
            return String(n)
        }
        return ""
    }
}
```

Resultado de los Test:
```
test 0 passed
test 1 passed
test 2 failed
test 3 failed
test 4 failed
test 5 failed
test 6 failed
test 7 failed
test 8 failed
test 9 failed
test 10 failed
test 11 failed
test 12 failed
test 13 failed
test 14 failed
test 15 failed
```

## Iteración 4: Pasa el caso 0, 1, 2

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        if n == 0  || n == 1 || n == 2 {
            return String(n)
        }
        return ""
    }
}
```

Resultado de los Test:
```
test 0 passed
test 1 passed
test 2 passed
test 3 failed
test 4 failed
test 5 failed
test 6 failed
test 7 failed
test 8 failed
test 9 failed
test 10 failed
test 11 failed
test 12 failed
test 13 failed
test 14 failed
test 15 failed
```

## Iteración 5: Pasa el caso 0, 1, 2, 3

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        if n == 0  || n == 1 || n == 2 {
            return String(n)
        }
        if n == 3 {
            return "Fizz"
        }
        return ""
    }
}
```

Resultado de los Test:
```
test 0 passed
test 1 passed
test 2 passed
test 3 passed
test 4 failed
test 5 failed
test 6 failed
test 7 failed
test 8 failed
test 9 failed
test 10 failed
test 11 failed
test 12 failed
test 13 failed
test 14 failed
test 15 failed
```

## Iteración 6: Usando la función módulo 3 hacemos que pase todos salvo mult. de 5

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        if n != 0  && n % 3 == 0 {
            return "Fizz"
        } else {
            return String(n)
        }
    }
}
```

Resultado de los Test:
```
test 0 passed
test 1 passed
test 2 passed
test 3 passed
test 4 passed
test 5 failed
test 6 passed
test 7 passed
test 8 passed
test 9 passed
test 10 failed
test 11 passed
test 12 passed
test 13 passed
test 14 passed
test 15 failed
```

## Iteración 7: Agregamos la función módulo 5, ahora pasa todos los tests salvo el 15

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        if n != 0  && n % 3 == 0 {
            return "Fizz"
        } else {
            return String(n)
        }
    }
}
```

Resultado de los Test:
```
test 0 passed
test 1 passed
test 2 passed
test 3 passed
test 4 passed
test 5 passed
test 6 passed
test 7 passed
test 8 passed
test 9 passed
test 10 passed
test 11 passed
test 12 passed
test 13 passed
test 14 passed
test 15 failed
```
## Iteración 8: Consideramos cuando es múltiplo de 3 y 5 simultáneamente

```swift
class FizzBuzz {
    func fizzBuzz(n: Int) -> String {
        if n == 0 {
            return "0"
        }
        if n % 3 == 0 && n % 5 == 0 {
            return "FizzFuzz"
        }
        if n % 3 == 0 {
            return "Fizz"
        }
        if n % 5 == 0 {
            return "Fuzz"
        }
        return String(n)
    }
}
```

Resultado de los Test:
```
test 0 passed
test 1 passed
test 2 passed
test 3 passed
test 4 passed
test 5 passed
test 6 passed
test 7 passed
test 8 passed
test 9 passed
test 10 passed
test 11 passed
test 12 passed
test 13 passed
test 14 passed
test 15 passed
```
