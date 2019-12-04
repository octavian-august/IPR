Feature: rest1test

  Feature Description

  @run2
  Scenario Outline: Scenario Outline 1
    When Послали POST на URL "http://ufrmsdev1/ufr-azon-reports-api/reports" с параметрами:
      | key          | value      |
      | orid         | 000AJN     |
      | usid         | 0000000I0L |
      | channel      | AZON       |
      | type         | <type>     |
      | employeeType | E          |
    And Проверяем статус код == <s_code>
    And ответ ~= <response>

    Examples:
      | type | s_code | response         |
      | R00A | 200    | {"rpid":".{10}"} |
      | R00K | 500    | {"rpid":".{10}"} |
