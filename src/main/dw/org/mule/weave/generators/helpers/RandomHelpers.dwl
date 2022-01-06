/**
*
* This module condenses helper functions for Number randomization in different formats.
*
*/

%dw 2.0
import * from dw::core::Arrays

@Internal(permits = [])
fun baseMatcher(b: Number, m: Number, p: Number,  f1: (Number, Number, Number) -> Number, f2: (Number, Number) -> Number): Number =
    b match {
        case c if (c <= m) -> f1(b,m,p)
        else -> f2(m, p)
    }


/**
*
* Returns a random value from an array.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | options | Array of values from which to pick.
* |===
*
* === Example
*
* This example shows how the `pickRandom` behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* import * from org::mule::weave::generators::helpers::RandomHelpers
* ---
* pickRandom([1, 2, 3])
*
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 2
* ----
**/

fun pickRandom<T>(options: Array<T>): T =
    options[randomInt(sizeOf(options))]


/**
*
* Returns a random integer between two respective base and ceiling values.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | base | The base value. Type: Number
* | max | The ceiling value. Type: Number
* |===
*
* === Example
*
* This example shows how the `randomIntWithBase` function behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomIntWithBase from org::mule::weave::generators::helpers::RandomHelpers
* ---
* randomIntWithBase(2,10)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 4
* ----
**/

fun randomIntWithBase(base: Number, max: Number): Number =
    baseMatcher(
    base,
     max,
      0,
       (u,v,w) -> floor(u) + randomInt(v - u),
        (z, p) -> randomInt(z)
        )


/**
*
* Returns a random number between two respective base and ceiling values, with the capability to specify the desired amount of decimal places.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | base | The base value. Type: Number
* | max | The ceiling value. Type: Number
* | precision | The desired amount of decimal places to be returned. Type: Number
* |===
*
* === Example
*
* This example shows how the `randomNumber` behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import * from org::mule::weave::generators::helpers::RandomHelpers
* ---
* randomNumber(0,1,10)
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 0.3294639395
* ----
**/

fun randomNumber(base: Number, max: Number, precision: Number): Number =
    baseMatcher(
    base,
     max,
      precision,
      (u,v,w) -> "$((u + randomInt(v - 1))).$(randomIntWithBase(pow(10, w - 1 ), pow(10, w)))" as Number,
       (x, p) -> "$((randomInt(x - 1))).$(randomIntWithBase(pow(10, p - 1), pow(10, p)))" as Number
       )



/**
*
* Returns a random number of a certain digit length.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name   | Description
* | len | The desired lenght for the output number. Type: Number
* |===
*
* === Example
*
* This example shows how the `randomIntWithLength` behaves under different inputs.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import * from org::mule::weave::generators::helpers::RandomHelpers
* ---
* randomIntWithLength(20)
*
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 71020173281033233000
* ----
**/
fun randomIntWithLength(len: Number): Number = randomIntWithBase(pow(10, len - 1), pow(10, len))

