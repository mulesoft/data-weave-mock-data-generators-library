%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts
import * from org::mule::weave::generators::helpers::RandomHelpers
---
"RandomHelpers" describedBy [
    "pickRandom" describedBy [
        "pickRandom - Number format" in do{
        var list: Array<Number> = [1,2,3,4,5]
        ---
            pickRandom(list) must [
                beNumber(),
                beOneOf(list)
            ]
        },
        "It should return null on empty array" in do {
            pickRandom([]) must beNull()
        },
        "It should return null on null" in do {
            pickRandom(null) must beNull()
        },
    ],
    "randomIntWithBase" describedBy [
        "randomIntWithBase - Number format" in do{
        var base: Number = 10
        var max: Number = 1000
        ---
            randomIntWithBase(base, max) must [
                $ is Number,
                $ >= base,
                $ <= max
            ]
        },
        "It should return null on invalid inputs" in do {
            randomIntWithBase(3, 1) must equalTo(3)
        },
        "It should return null on null" in do {
            randomIntWithBase(null, "testing") must beNull()
        },
        "It should return null on null" in do {
            randomIntWithBase("testing", null) must beNull()
        },
    ],
    "randomNumber" describedBy [
        "randomNumber - Number format" in do {
        var base: Number = 10
        var max: Number = 4000
        var precision: Number = 3
        ---
            randomNumber(base, max, precision) must [
                $ is Number,
                $ >= base,
                $ <= max,
                ($ as String) matches /[0-9]{2,4}\.[0-9]{0,3}/
            ]
        },
        "It should have empty decimal part on closed range" in do {
            randomNumber(2, 2, 33) must equalTo(2)
        },
        "It should return null on invalid range" in do {
            randomNumber(2, 1, 1) must equalTo(2)
        },
        "It should return null on invalid precision" in do {
            randomNumber(3, 3, -3) must equalTo(3)
        },
        "It should return null on null input" in do {
            randomNumber(null, "test", true) must beNull()
        },
        "It should return null on null input" in do {
            randomNumber("test", null, true) must beNull()
        },
        "It should return null on null input" in do {
            randomNumber("test", true, null) must beNull()
        },
    ],
    "randomIntWithLength" describedBy [
        "randomIntWithLength - Number format" in do {
        var len: Number = 10
        ---
            randomIntWithLength(len) must [
                beNumber(),
                ($ as String) matches /[0-9]{10}/,
                !(($ as String) matches /[0-9]{1,10}\.[0-9]+/)
            ]
        },
        "It return null on invalid input" in do {
            randomIntWithLength(0) must equalTo(0)
        },
        "It should return null on null" in do {
            randomIntWithLength(null) must beNull()
        },
    ],
]