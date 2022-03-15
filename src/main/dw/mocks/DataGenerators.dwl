/**
* This module condenses functions to generate random data in commonly used formats.
*/

%dw 2.0

import * from mocks::helpers::RandomHelpers
import * from mocks::constants::DataConstants


import lower, substringBeforeLast, withMaxSize from dw::core::Strings



/**
*
* Returns a random age ranging from `base` to `top`.
*
* Defaults to `base` if `top` is less than `base`.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type   | Description
* | `base` | `Number` | Minimum value for the generated age.
* | `top`  | `Number` | Maximum value for the generated age. Default: `100`.
* |===
*
* === Example
*
* This example shows how the `randomAge` function behaves when generating a teenager age.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomAge from from mocks::DataGeneratores
* ---
* randomAge(13, 19)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 15
* ----
**/

fun randomAge(base: Number, top: Number = 100): Number = randomIntWithBase(base, top)

/**
* Helper function that enables `randomAge` to work with a `null` value.
*/
fun randomAge(base: Null, top: Any = null): Null = null

/**
* Helper function that enables `randomAge` to work with a `null` value.
*/
fun randomAge(base: Any, top: Null): Null = null




/**
*
* Returns a random percentage rate.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type | Description
* | `base` | `Number` | Minimum range value. Default: `0`.
* | `top` | `Number` | Maximum range value. Default: `100`.
* |===
*
* === Example
*
* This example shows how the `randomRate` function behaves when setting only a minimun value.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomRate from from mocks::DataGenerators
* ---
*  randomRate(45)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "68%"
* ----
**/

fun randomRate(base: Number = 0, top: Number = 100): String = "$(randomIntWithBase(base, top))%"

/**
* Helper function that enables `randomRate` to work with a `null` value.
*/
fun randomRate(base: Null, top: Any = null): Null = null

/**
* Helper function that enables `randomRate` to work with a `null` value.
*/
fun randomRate(base: Any, top: Null): Null = null




/**
*
* Returns a random URL, represented as a `baseUrl` (optional) and an additional randomized path.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type | Description
* | `baseUrl` | `String` | The base URL used to generate the URLs. Default: "http://acme.com/"
* |===
*
* === Example
*
* This example shows a possible result of `randomUrl`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* ---
* randomUrl()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "http://acme.com/c9c2c24/06816/27068f""
* ----
**/

fun randomUrl(baseUrl: String = "http://acme.com/"): String = do {
    var numberOfElements = randomIntWithBase(2, 4)
    var cleanUrl = if (baseUrl[-1] == "/") substringBeforeLast(baseUrl, "/") else baseUrl
    var finalUrl = [cleanUrl] ++ ((0 to numberOfElements) map ((item, index) -> randomId(randomIntWithBase(5, 9))))
    ---
    finalUrl joinBy "/"
}

/**
* Helper function that enables `randomUrl` to work with a `null` value.
*/
fun randomUrl(baseUrl: Null): Null = null



/**
*
* Returns a random phone number in the US format.
*
* === Example
*
* This example shows a possible result of `randomPhoneNumber`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomPhoneNumber from mocks::DataGenerators
* ---
* randomPhoneNumber()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "656-541-1908"
* ----
**/

fun randomPhoneNumber(): String =
    "$(randomIntWithBase(1, 8))$(randomInt(8))$(randomInt(8))-$(randomIntWithBase(100, 743))-$(randomIntWithBase(1000, 9999))"

/**
*
* Returns a random zip code consisting of a String representation of an integer between 10000 and 20000.
*
* === Example
*
* This example shows a possible result of `randomZipCode`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomZipCode from mocks::DataGenerators
* ---
* randomZipCode() as String
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "17727"
* ----
**/

fun randomZipCode(): Number = randomIntWithBase(10000, 20000)


/**
*
* Returns a random address comprised of a door number (from 1 to 10000) and a street name.
*
* === Example
*
* This example shows a possible result of `randomAddress`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomAddress from mocks::DataGenerators
* ---
* randomAddress()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "5008 BRIARLAKE AVE"
* ----
**/

fun randomAddress(): String = "$(randomIntWithBase(1, 10000)) $(pickRandom(STREET_NAMES))"


/**
*
* Returns a random credit card number based on the criteria outlined
* in https://www.freeformatter.com/credit-card-number-generator-validator.html[Credit Card Number Generator & Validator].
*
* === Example
*
* This example shows a possible result of `randomCreditCardNumber`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomCreditCardNumber from mocks::DataGenerators
* ---
* randomCreditCardNumber() as String
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "371694040638537"
*
* ----
**/

fun randomCreditCardNumber(): Number = do {
    var format: Array<Number> =  pickRandom(CREDIT_CARD_FORMATS)
    var start: Number = pickRandom(format[0 to -2])
    var remainder: Number = randomIntWithLength(format[-1] - sizeOf(start as String))
    ---
    "$(start)$(remainder)" as Number
}




/**
*
* Returns a random social security number (SSN) based on the criteria outlined in 
* https://en.wikipedia.org/wiki/Social_Security_number#Structure[Wikipedia].
*
* === Example
*
* This example shows a possible result of `randomSSN`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomSSN from mocks::DataGenerators
* ---
* randomSSN()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "232-48-5235"
* ----
**/

fun randomSSN(): String = do {
    var SSNPrefixes: Array<Number> = (100 to 899) -- [666]
    var first: Number = pickRandom(SSNPrefixes)
    var second: Number = randomIntWithBase(10, 99)
    var third: Number = randomIntWithBase(1000, 9999)
    ---
    "$(first)-$(second)-$(third)"
}

/**
*
* Returns a random city name.
*
* === Example
*
* This example shows a possible result of `randomCity`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomCity from mocks::DataGenerators
* ---
* randomCity()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "Tālcher"
* ----
**/

fun randomCity(): String = pickRandom(CITY_NAMES)

/**
*
* Returns a random price.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type | Description
* | `base` | `Number` | Floor value that represents the minimum for all values generated. Default: `0`.
* | `max` | `Number` | Ceiling value that represents the maximum for all values generated.
* |===
*
* === Example
*
* This example shows how the `randomPrice` function behaves with different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomPrice from mocks::DataGenerators
* ---
* randomPrice(10,1000)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 677.87
* ----
**/

fun randomPrice(base: Number = 0, max: Number): Number = randomNumber(base, max, 2 )

/**
* Helper function that enables `randomPrice` to work with a `null` value.
*/
fun randomPrice(base: Null, max: Any = null): Null = null

/**
* Helper function that enables `randomPrice` to work with a `null` value.
*/
fun randomPrice(base: Any, max: Null): Null = null



/**
*
* Returns a random country name.
*
* === Example
*
* This example shows a possible result of `randomCountry`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomCountry from mocks::DataGenerators
* ---
* randomCountry()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "Saudi Arabia"
* ----
**/

fun randomCountry(): String = pickRandom(COUNTRY_NAMES)


/**
*
* Returns a random identifier with the given `length`.
* Returns `""` if `length` is less than 1.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type | Description
* | `length` | `Number` | Length of the desired output.
* |===
*
* === Example
*
* This example shows how the `randomId` function behaves with different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomId from mocks::DataGenerators
* ---
* randomId(50)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "e7be08ef6bd54c25babef14a8011156d43f57be5fbfe448dbe"
*
* ----
**/

fun randomId(length: Number): String = do {
    fun loop(acc: String, l: Number) = 
        if (l <= 0)
            acc
        else do {
            var smallId = uuid() replace  "-" with "" withMaxSize l
            ---
            loop(acc ++ smallId, l - sizeOf(smallId))
        }
    ---
    loop("", length)
}

/**
* Helper function that enables `randomId` to work with a `null` value.
*/
fun randomId(length: Null): Null = null



/**
*
* Returns a random first name.
*
* === Example
*
* This example shows a possible result of `randomFirstName`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomFirstName from mocks::DataGenerators
* ---
* randomFirstName()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "Teodosi"
* ----
**/

fun randomFirstName(): String = pickRandom(FIRST_NAMES)


/**
*
* Returns a random last name.
*
* === Example
*
* This example shows a possible result of `randomLastName`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomLastName from mocks::DataGenerators
* ---
* randomLastName()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "Gagliardi"
* ----
**/

fun randomLastName(): String = pickRandom(LAST_NAMES)


/**
*
* Returns a random full name, based on the combination of `randomFirstName` and `randomLastName`.
*
* === Example
*
* This example shows a possible result of `randomFullName`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomFullName from mocks::DataGenerators
* ---
* randomFullName()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "Arielle Sajan"
* ----
**/

fun randomFullName(): String = "$(randomFirstName()) $(randomLastName())"


/**
*
* Returns a random user name.
*
* === Example
*
* This example shows a possible result of `randomUserName`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomUserName from mocks::DataGenerators
* ---
* randomUserName()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "khalfaoui260"
*
* ----
**/

fun randomUserName(): String = "$(lower(randomLastName()))$(randomIntWithBase(100, 1000))"


/**
*
* Returns random text up to a given `length`.
* If `length` is negative, `""` is returned.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type | Description
* | `length` | `Number` | The maximum length of the text to return.
* |===
*
* === Example
*
* This example shows how the `randomDescription` function behaves with different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomDescription from mocks::DataGenerators
* ---
* randomDescription(20)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* // Yes, this was randomly generated
* "dataweave is great"
* ----
**/
fun randomDescription(length: Number): String = do{
    fun go(acc: Array<String>, len: Number): String =
        if (len <= 0)
            ((acc[0 to -2] default []) joinBy " ")
        else do {
            var randomWord = pickRandom(WORDS)
            ---
            go(acc << randomWord, len - 1 - sizeOf(randomWord))
        }
    ---
    go([], length)
}

/**
* Helper function that enables `randomDescription` to work with a `null` value.
*/
fun randomDescription(length: Null): Null = null


/**
*
* Returns a random email address.
*
* === Example
*
* This example shows a possible result of `randomEmailAddress`.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomEmailAddress from mocks::DataGenerators
* ---
* randomEmailAddress()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "guerrinha349@anonymous.to"
* ----
**/

fun randomEmailAddress(): String = "$(randomUserName())@$(pickRandom(DOMAIN_NAMES))"


