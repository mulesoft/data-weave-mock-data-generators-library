%dw 2.0

/**
* Source: https://www.freeformatter.com/credit-card-number-generator-validator.html
*/
var CREDIT_CARD_FORMATS: Array<Array<Number>> = [ [34, 37, 15], [300, 301, 302, 303, 304, 305, 14], [36, 14], [51, 52, 53, 54, 55, 16], [4, 18] ]

/**
* Source: https://data.amerigeoss.org/es/dataset/street-names
*/
var STREET_NAMES: Array<String> = readUrl('classpath://datasets/street-names/street-names.json', 'application/json') as Array<String>

/**
* Source: https://datahub.io/core/world-cities
*/
var CITY_NAMES: Array<String> = readUrl('classpath://datasets/city-names/city-names.json', 'application/json') as Array<String>


/**
* Source: https://gist.github.com/keeguon/2310008
*/
var COUNTRY_NAMES: Array<String> = readUrl('classpath://datasets/country-names/country-names.json', 'application/json') as Array<String>


/**
* Source: https://github.com/smashew/NameDatabases
*/
var FIRST_NAMES: Array<String> = readUrl('classpath://datasets/first-names/first-names.json', 'application/json') as Array<String>


/**
* Source: https://github.com/smashew/NameDatabases
*/
var LAST_NAMES: Array<String> = readUrl('classpath://datasets/last-names/last-names.json', 'application/json') as Array<String>

/**
* Source: https://gist.github.com/ammarshah/f5c2624d767f91a7cbdc4e54db8dd0bf
*/
var DOMAIN_NAMES: Array<String> = readUrl('classpath://datasets/domains/domains.json', 'application/json') as Array<String>


/**
* Source: https://github.com/dwyl/english-words/blob/master/words_alpha.txt
*/
var WORDS: Array<String> = readUrl("classpath://datasets/words/words.json", "application/json") as Array<String>