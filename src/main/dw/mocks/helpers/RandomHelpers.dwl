/**
*
* This module condenses helper functions for Number randomization in different formats.
*
*/

%dw 2.0
import * from dw::core::Arrays


/**
*
* Returns a random value from an array.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type   | Description
* | options | Array<T> | Array of values from which to pick.
* |===
*
* === Example
*
* This example shows how the `pickRandom` behaves under an arbitrary array.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* import * from mocks::helpers::RandomHelpers
* ---
* pickRandom([1, "Nacho", 3])
*
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
* 3
* ----
**/
fun pickRandom<T>(options: Array<T>): T =
    options[randomInt(sizeOf(options))]

/**
* Helper function that enables `pickRandom` to work with a `null` value.
*/
fun pickRandom(options: Null): Null = null


/**
*
* Returns a random integer between two respective base and ceiling values.
* If the base value is greater than the ceiling value, `base` is returned.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type   | Description
* | base | Number | The base value.
* | max | Number | The ceiling value.
* |===
*
* === Example
*
* This example shows how the `randomIntWithBase` function behaves for two arbitrary values.
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* output application/json
* import randomIntWithBase from mocks::helpers::RandomHelpers
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

fun randomIntWithBase(base: Number, max: Number): Number  =
    if (base > max)
        base
    else
        floor(base) + randomInt(max - base)

/**
* Helper function that enables `randomIntWithBase` to work with a `null` value.
*/
fun randomIntWithBase(base: Null, max: Any = null):  Null = null

/**
* Helper function that enables `randomIntWithBase` to work with a `null` value.
*/
fun randomIntWithBase(base: Any, max: Null):  Null = null

/**
*
* Returns a random number between two respective base and ceiling values,
* with the capability to specify the desired amount of decimal places.
* 
* If `base` > `max`, `base` is returned. If `precision` is a negative number, no decimal part is added.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type   | Description
* | base | Number | The base value.
* | max | Number | The ceiling value.
* | precision | Number | The desired amount of decimal places to be returned.
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
* import * from mocks::helpers::RandomHelpers
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
    if (base > max)
        base
    else
        do {
            var integerPart = randomIntWithBase(base, max)
            var decimalPart = if ((integerPart == max) or (precision <= 0)) 0 else randomIntWithBase(pow(10, precision - 1 ), pow(10, precision))
            ---
            "$(integerPart).$(decimalPart)" as Number
        }
        
/**
* Helper function that enables `randomNumber` to work with a `null` value.
*/
fun randomNumber(base: Null, max: Any, precision: Any):  Null = null

/**
* Helper function that enables `randomNumber` to work with a `null` value.
*/
fun randomNumber(base: Any, max: Null, precision: Any):  Null = null

/**
* Helper function that enables `randomNumber` to work with a `null` value.
*/
fun randomNumber(base: Any, max: Any, precision: Null):  Null = null



/**
*
* Returns a random integer of a certain digit length.
* Or `0` if the length is less than `1`.
*
* === Parameters
*
* [%header, cols="1,3"]
* |===
* | Name | Type   | Description
* | len | Number | The desired lenght for the output number.
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
* import * from mocks::helpers::RandomHelpers
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
fun randomIntWithLength(len: Number): Number = 
    if (len < 1)
        0
    else
        randomIntWithBase(pow(10, len - 1), pow(10, len))

/**
* Helper function that enables `randomIntWithLength` to work with a `null` value.
*/
fun randomIntWithLength(len: Null):  Null = null

