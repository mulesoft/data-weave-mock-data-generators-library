# DataWeave Mock Data Generators Library

[![Development Branch](https://github.com/mulesoft/data-weave-mock-data-generators-library/actions/workflows/master_workflow.yml/badge.svg?branch=master)](https://github.com/mulesoft/data-weave-mock-data-generators-library/actions/workflows/master_workflow.yml)

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

## Overview

The following example shows some randomly generated mock data:

```dataweave
%dw 2.0
output application/json
import * from mocks::DataGenerators
---
(0 to 2) as Array map (v, i) -> {
    name: randomFirstName(),
    lastName: randomLastName(),
    email: randomEmailAddress(),
    age: randomAge(10) as String,
    addresses: (0 to 1) as Array map (v2, i2) -> {
        address: randomAddress(),
        city: randomCity(),
        country: randomCountry(),
        zipCode: randomZipCode() as String,
      }
}

```

Output:

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
  }
]
```
## Contributions Welcome

Contributions to this project can be made through Pull Requests and Issues on the
[GitHub Repository](https://github.com/mulesoft/data-weave-mock-data-generators-library).

Before creating a pull request review the following:

* [LICENSE](https://github.com/mulesoft/data-weave-mock-data-generators-library/blob/master/LICENSE.txt)
* [SECURITY](https://github.com/mulesoft/data-weave-mock-data-generators-library/blob/master/SECURITY.md)
* [CODE_OF_CONDUCT](https://github.com/mulesoft/data-weave-mock-data-generators-library/blob/master/CODE_OF_CONDUCT.md)

When you submit your pull request, you are asked to sign a contributor license agreement (CLA) if we don't have one on file for you.
