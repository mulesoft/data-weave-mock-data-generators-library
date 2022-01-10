%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts
import * from org::mule::weave::generators::helpers::RandomHelpers
---
"Random Helper functions" describedBy [
    "pickRandom - Number format" in do{
    var list: Array<Number> = [1,2,3,4,5]
    ---
        pickRandom(list) must [
            beNumber(),
            beOneOf(list)
        ]
    },
    "randomIntWithBase - Number format" in do{
    var base: Number = 10
    var max: Number = 1000
    ---
        randomIntWithBase(base, max) must [
            beNumber(),
            beGreaterThan(base),
            beLowerThan(max)
        ]
    },
    "randomNumber - Number format" in do {
    var base: Number = 10
    var max: Number = 4000
    var precision: Number = 3
    ---
        randomNumber(base, max, precision) must [
            beNumber(),
            beGreaterThan(base),
            beLowerThan(max),
            beLowerThan(max),
            ($ as String) matches /[0-9]{2,4}\.[0-9]{0,3}/
        ]
    },
    "randomIntWithLength - Number format" in do {
     var len: Number = 10
     ---
        randomIntWithLength(len) must [
            beNumber(),
            ($ as String) matches /[0-9]{10}/,
            !(($ as String) matches /[0-9]{1,10}\.[0-9]+/)
        ]
    }


]