/**
* This module condenses functions to generate random data in commonly used formats.
*/

%dw 2.0

import * from org::mule::weave::generators::helpers::RandomHelpers
import * from org::mule::weave::generators::constants::DataConstants
import lower from dw::core::Strings

/**
* FormattedNumber type definition.
*
* [%header, cols="1,3"]
* |===
* | Type | Values
* | FormattedNumber | { asString: String, asNumber: Number}
* |===
*
**/

type FormattedNumber = { asString: String, asNumber: Number}

/**
*
* Decorator function to provide outputs as either Number or String.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | o | Result from the decorated function <Number>
* |===
*
* === Example
*
* This example shows how the `out` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import out from from org::mule::weave::generators::DataGeneratores
* ---
* out(45)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* {
*   "asString": "45",
*   "asNumber": 45
* }
* ----
**/

fun out(o: Number): FormattedNumber = {
        asString: o as String,
        asNumber: o
  }


/**
*
* Returns a random age represented as an Integer value ranging from 0 to 100.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | base | Floor value which represents the minimum for all values generated. Type: Number
* |===
*
* === Example
*
* This example shows how the `randomAge` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomAge from from org::mule::weave::generators::DataGeneratores
* ---
* randomAge(10).asNumber
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 84
* ----
**/

fun randomAge(base: Number): FormattedNumber = out (base + randomInt(100 - base))


/**
*
* Returns a random percentage rate.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | base | Floor value which represents the minimum for all values generated. Type: Number
* |===
*
* === Example
*
* This example shows how the `randomRate` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomRate from from org::mule::weave::generators::DataGenerators
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

fun randomRate(base: Number = 0): String = "$(base + randomInt(100 - base))%"


/**
*
* Returns a random URL, represented as a baseUrl (optional) and an additional randomized path.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | baseUrl | The base URL used to generate the URLs. Type: String. Default: "http://acme.com/"
* |===
*
* === Example
*
* This example shows how the `randomUrl` function behaves under different inputs.
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
* "http://acme.com/1252558""
* ----
**/

fun randomUrl(baseUrl: String = "http://acme.com/"): String = "$(baseUrl ++ randomInt(9999999) as String)"

/**
*
* Returns a random phone number in US format.
*
* === Example
*
* This example shows how the `randomPhoneNumber` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomPhoneNumber from org::mule::weave::generators::DataGenerators
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
* Returns a random zip code consisting on the String representation of an Integer between 10000 and 2000.
*
* === Example
*
* This example shows how the `randomZipCode` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomZipCode from org::mule::weave::generators::DataGenerators
* ---
* randomZipCode().asString
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

fun randomZipCode(): FormattedNumber =
    out (randomIntWithBase(10000, 20000))


/**
*
* Returns a random address comprised of a door number (Number from 0 to 10000) and a street name
*
* === Example
*
* This example shows how the `randomAddress` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomAddress from org::mule::weave::generators::DataGenerators
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

fun randomAddress(): String = "$(randomInt(10000)) $(pickRandom(STREET_NAMES))"


/**
*
* Returns a random credit card number, based on the criteria outlined in https://www.freeformatter.com/credit-card-number-generator-validator.html
*
* === Example
*
* This example shows how the `randomCreditCardNumber` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomCreditCardNumber from org::mule::weave::generators::DataGenerators
* ---
* randomCreditCardNumber().asString
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

fun randomCreditCardNumber(): FormattedNumber = do {
    var format: Array<Number> =  pickRandom(CREDIT_CARD_FORMATS)
    var start: Number = pickRandom(format[0 to -2])
    var remainder: Number = randomIntWithLength(format[-1] - sizeOf(start as String))
    ---
    out("$(start)$(remainder)")
}




/**
*
* Returns a random SSN based on the criteria outlined in https://en.wikipedia.org/wiki/Social_Security_number#Structure
*
* === Example
*
* This example shows how the `randomSSN` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomSSN from org::mule::weave::generators::DataGenerators
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
    var SSNPrefixes: Array<Number> = (100 to 999) -- [666] -- (900 to 999)
    var first: Number = pickRandom(SSNPrefixes)
    var second: Number = pickRandom((10 to 99))
    var third: Number = pickRandom((1000 to 9999))
    ---
    "$(first)-$(second)-$(third)"
}

/**
*
* Retuns a random gender type.
*
* === Example
*
* This example shows how the `randomGender` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomGender from org::mule::weave::generators::DataGenerators
* ---
* randomGender()
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "female"
* ----
**/

fun randomGender(): String = pickRandom(["male", "female"])

/**
*
* Returns a random city name from the list of cities defined in https://datahub.io/core/world-cities
*
* === Example
*
* This example shows how the `randomCity` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomCity from org::mule::weave::generators::DataGenerators
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
* | Name   | Description
* | base | Floor value which represents the minimum for all values generated. Type: Number
* | max | Ceiling value which represents the maximum for all values generated. Type: Number
* |===
*
* === Example
*
* This example shows how the `randomPrice` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomPrice from org::mule::weave::generators::DataGenerators
* ---
* randomPrice(10,1000).asNumber
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

fun randomPrice(base: Number = 0, max: Number): FormattedNumber = out(randomNumber(base, max, 2 ))


/**
*
* Returns a random country from the list defined in https://gist.github.com/keeguon/2310008
*
* === Example
*
* This example shows how the `randomCountry` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomCountry from org::mule::weave::generators::DataGenerators
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
* Returns a randomId up to 4000 characters
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | length | Length of the desired output. Type: Number.
* |===
*
* === Example
*
* This example shows how the `randomId` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomId from org::mule::weave::generators::DataGenerators
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

fun randomId(length: Number = -1): String = do {
    var MAX_CHARS: Number = 4000
    fun loop(acc: String, l: Number, max: Number = MAX_CHARS) =
        if (l > 0)
            sizeOf(acc) match {
                case s1 if (s1 >= max) -> acc[0 to max - 1]
                case s2 if (s2 >= l) -> acc[0 to l - 1]
                else -> loop(acc ++ (uuid() replace "-" with ""), l)
            }
        else (uuid() replace "-" with "")
    ---
    loop("", length)
}

/**
*
* Returns a random first name from the list defined in https://github.com/smashew/NameDatabases
*
* === Example
*
* This example shows how the `randomFirstName` behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomFirstName from org::mule::weave::generators::DataGenerators
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
* Returns a random last name from the list defined in https://github.com/smashew/NameDatabases
*
* === Example
*
* This example shows how the `randomLastName` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomLastName from org::mule::weave::generators::DataGenerators
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
* Returns a random full name, based on the combination of randomFirstName and randomLastName
*
* === Example
*
* This example shows how the `randomFullName` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomFullName from org::mule::weave::generators::DataGenerators
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
* This example shows how the `randomUserName` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomUserName from org::mule::weave::generators::DataGenerators
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
* Returns random text up to `length` characters
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | length | The maximum length of the text to return. Type <Number>
* |===
*
* === Example
*
* This example shows how the `randomDescription` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomDescription from org::mule::weave::generators::DataGenerators
* ---
* randomDescription(200)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* "calvary acetophenone starving pennipotent unplenteous tensome curelessness snubbingly dashee anthosiderite entwist distinguishability falcade semilyrically bookwards procombat malar singer breenge"
* ----
**/

fun randomDescription(length: Number): String = do{
    fun go(acc: Array<String>, len: Number): String =
        sizeOf(acc joinBy " ") match {
            case l if (l > len) -> (acc[0 to -2] joinBy " ")
            else -> go(acc << pickRandom(WORDS), len)
        }
    ---
    go([], length)
}



/**
*
* Returns a random email address
*
* === Example
*
* This example shows how the `randomEmailAddress` behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomEmailAddress from org::mule::weave::generators::DataGenerators
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


