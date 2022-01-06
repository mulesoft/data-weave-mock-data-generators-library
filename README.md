# DataWeave Mock Data Generators Library

![badge](https://github.com/mulesoft-consulting/data-weave-mock-data-generators/workflows/Pipeline/badge.svg)

This library consolidates functions to generate random mock data for testing purposes.

Some of the use cases covered:

- **Different number format types**
- **Age**
- **Rate**
- **Phone numbers**
- **Zip Codes**
- **Credit card numbers**
- **User names**
- **Email addresses**

__________________________________________
## Example

The script:

```javascript
%dw 2.0
output application/json
import * from org::mule::weave::generators::DataGenerators
---
(0 to 5) as Array map (v, i) -> {
    name: randomFirstName(),
    lastName: randomLastName(),
    email: randomEmailAddress(),
    age: randomAge(10).asString,
    addresses: (0 to 1) as Array map (v2, i2) -> {
        address: randomAddress(),
        city: randomCity(),
        country: randomCountry(),
        zipCode: randomZipCode().asString
      }
}

```

lays down:

```json
[
  {
    "name": "Geertruida",
    "lastName": "Izarra",
    "email": "mendraca306@hotbrev.com",
    "age": "88",
    "addresses": [
      {
        "address": "7494 WHITE SHADOWS DR",
        "city": "Gonesse",
        "country": "Netherlands",
        "zipCode": "12121"
      },
      {
        "address": "4932 SPANISH CT",
        "city": "Künzell",
        "country": "United Kingdom",
        "zipCode": "19174"
      }
    ]
  },
  {
    "name": "Huihui",
    "lastName": "Goupil",
    "email": "weyerhauser295@mail2atom.com",
    "age": "93",
    "addresses": [
      {
        "address": "7083 EMORY AVE",
        "city": "Jawor",
        "country": "Bhutan",
        "zipCode": "18944"
      },
      {
        "address": "4868 BLUE WING LN",
        "city": "Airoli",
        "country": "Montserrat",
        "zipCode": "17981"
      }
    ]
  },
  {
    "name": "Margene",
    "lastName": "Raich",
    "email": "hamenkov394@ig.com.br",
    "age": "22",
    "addresses": [
      {
        "address": "1139 ROCKYBROOK DR",
        "city": "Reigate",
        "country": "Botswana",
        "zipCode": "17932"
      },
      {
        "address": "6695 BEAUTYBERRY AVE",
        "city": "Palakkad",
        "country": "Curacao",
        "zipCode": "10171"
      }
    ]
  },
  {
    "name": "Keltouma",
    "lastName": "Brizuela",
    "email": "atorf349@hairdresser.net",
    "age": "40",
    "addresses": [
      {
        "address": "9783 LANGER AVE",
        "city": "Battle Creek",
        "country": "United Arab Emirates",
        "zipCode": "12124"
      },
      {
        "address": "7579 GINGER PLACE DR",
        "city": "Palo Alto",
        "country": "Vietnam",
        "zipCode": "10385"
      }
    ]
  },
  {
    "name": "Beth",
    "lastName": "Ranea",
    "email": "winder137@tfz.net",
    "age": "20",
    "addresses": [
      {
        "address": "7612 REDMAN LAKE DR",
        "city": "Voerde",
        "country": "Guernsey",
        "zipCode": "11412"
      },
      {
        "address": "9555 WHITE OAK TRACE DR",
        "city": "Kairouan",
        "country": "French Polynesia",
        "zipCode": "11920"
      }
    ]
  },
  {
    "name": "Anait",
    "lastName": "Bedia",
    "email": "chanov795@supergreatmail.com",
    "age": "48",
    "addresses": [
      {
        "address": "2049 ALBERT HART DR",
        "city": "Karakoçan",
        "country": "Swaziland",
        "zipCode": "12463"
      },
      {
        "address": "8640 THICKET PASS",
        "city": "Maner",
        "country": "Switzerland",
        "zipCode": "16246"
      }
    ]
  }
]
```


__________________________________________
## Consumption

Include the following dependency in you project's POM.xml file:

```
<dependency>
    <groupId>1e0dbdda-5cda-4968-a636-0980a2c42cb1</groupId>
    <artifactId>dw-mock-data-generators</artifactId>
    <version>1.0.1</version>
    <classifier>dw-library</classifier>
</dependency>
```

__________________________________________

## Issues
We use GitHub Issues for tracking. Please submit your bugs or issues there. We also accept PR's ;)

## Final Thoughts

Try it! Explore the docs! Don't forget to submit your improvements or feedback :)





