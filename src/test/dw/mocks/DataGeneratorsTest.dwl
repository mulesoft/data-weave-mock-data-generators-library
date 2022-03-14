
%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts
import * from mocks::DataGenerators
import * from mocks::constants::DataConstants
---

"DataGenerators" describedBy [
    "randomAge" describedBy [
        "randomAge - Number format" in do {
            var base: Number = 5
            ---
            randomAge(base) must [
                beGreaterThan(base - 1)
            ]
        },
        "It should return null on null values" in do {
            randomAge(null) must beNull()
        },
    ],
        "randomRate" describedBy [
        "randomRate - String format" in do {
            randomRate() must [
                $ matches /[0-1]{0,1}[0-9]{0,1}[0-9]%/
            ]
        },
        "It should return null on null values" in do {
            randomRate(null, null) must beNull()
        },
    ],
    "randomUrl" describedBy [
        "randomUrl - URL format" in do{
            randomUrl() must [
                $ matches (/http:\/\/acme\.com(\/[\w0-9]{5,9}){2,4}/)
            ]
        },
        "Other baseUrl" in do {
            randomUrl("www.dwlang.fun") must [
                $ matches (/www\.dwlang\.fun(\/[\w0-9]{5,9}){2,4}/)
            ]
        },
        "It should return null on null value" in do {
            randomUrl(null) must beNull()
        },
    ],
    "randomPhoneNumber" describedBy [
        "randomPhoneNumber - String Format" in do {
            randomPhoneNumber() must [
                $ matches /[1-8]{1}[0-8]{1}[0-8]{1}-[0-9]{3}-[0-9]{4}/
             ]
        },
    ],
    "randomZipCode" describedBy [
        "randomZipCode - String format" in do {
            randomZipCode() as String must [
                $ matches /[1-2]{1}[0-9]{4}/
            ]
        },
       "randomZipCode - Number format" in do {
            randomZipCode() must [
                beGreaterThan(10000),
                beLowerThan(20000)
            ]
        },
    ],
        "randomAddress" describedBy [
        "randomAddress - String format" in do {
            randomAddress() must [
                $ matches /([1-9][0-9]{0,4})(\s[\w\.]*)*/
            ]
        },
    ],
    "randomCreditCardNumber" describedBy [
        "randomCreditCardNumber - Number format" in do {
            randomCreditCardNumber() must [
                beGreaterThan(3*pow(10,13)),
                beLowerThan(5*pow(10,17))
            ]
        },
    ],
    "randomSSN" describedBy [
        "randomSSN - String format" in do{
            randomSSN() must  [
                $ matches /[0-9]{3}-[0-9]{2}-[0-9]{4}/
            ]
        },
    ],
    "randomCity" describedBy [
        "randomCity - String format" in do{
            randomCity() must [
                beString(),
                beOneOf(CITY_NAMES)
            ]
        },
    ],
    "randomPrice" describedBy [
        "randomPrice - Number format" in do {
            randomPrice(100) must [
                $ is Number,
                $ > 0,
                $ < 100
            ]
      },
        "It should return null on null value" in do {
            randomPrice(3, null) must beNull()
        },
    ],
    "randomId" describedBy [
        "randomId - String format" in do {
            randomId(32) must [
                beString(),
                $ matches /(\w){0,32}/
            ]
        },
        "It should return empty string on neg input" in do {
            randomId(-32) must [
                beString(),
                beEmpty(),
            ]
        },
        "It should return null on null" in do {
            randomId(null) must beNull()
        },
    ],
    "randomFirstName" describedBy [
        "randomFirstName - String format" in do{
            randomFirstName() must [
                beString(),
                beOneOf(FIRST_NAMES)
            ]
        },
    ],
    "randomLastName" describedBy [
        "randomLastName - String format" in do{
            randomLastName() must [
                beString(),
                beOneOf(LAST_NAMES)
            ]
        },
    ],
    "randomFullName" describedBy [
        "randomFullName - String format" in do{
            randomFullName() must [
                beString(),
                $ matches /(\w*)\s(\w*)/
            ]
        },
    ],
    "randomDescription" describedBy [
        "randomDescription - String format" in do{
            var len: Number = 100
            ---
            randomDescription(len) must [
                beString(),
                sizeOf($) <= len
            ]
        },
        "It should return empty string on negative length" in do {
            randomDescription(-7) must [
                beString(),
                beEmpty()
            ]
        },
        "It should return null on null value" in do {
            randomDescription(null) must beNull()
        },
    ],
    "randomEmailAddress" describedBy [
        "randomEmailAddress - String format" in do{
                randomEmailAddress() must [
                    beString(),
                    $ matches /([a-z]*)[0-9]{1,4}@([a-z0-9_-]*)\.([a-z0-9\_\-\.]*)/
                ]
        }
    ],
    "randomUserName" describedBy [
        "It should do something" in do {
            randomUserName() must beString()
        },
    ],
]
