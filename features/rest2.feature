Feature: rest1test

  Feature Description

  @run3
  Scenario: Scenario 3
    When Послали POST на URL "http://ufrmsdev1/ufr-zpfl-registration-api/organizations/000AJN/employees/?usid=0000000I0L" с параметрами:
      | key                      | value                                  |
      | crf                      | 7806722967                             |
      | inf                      | 000                                    |
      | secondName               | ЧУВАК                             |
      | firstName                | ЧУВАК                             |
      | middleName               | ЧУВАК                             |
      | birthDay                 | 1990-01-04                             |
      | sex                      | F                                      |
      | birthPlace               | г. Москва                       |
      | mobilePhone              | 79180010203                            |
      | personnelNumber          | 15                                     |
      | documentTypeCode         | 21                                     |
      | documentSeries           | 1234                                   |
      | documentNumber           | 123456                                 |
      | documentIssuedDate       | 2010-02-01                             |
      | documentIssuedWho        | Выдан городом Москва |
      | documentSubdivisionCode  | 123456                                 |
      | embossingName            | Spiridonova Ekaterina                  |
      | deliveryDepartmentNumber | 0726                                   |
      | bonus1                   | 0000029438                             |
      | bonus2                   | 1234567890                             |
    And Проверяем статус код == 200
    And ответ ~= Successfully created employee
