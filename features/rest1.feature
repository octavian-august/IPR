Feature: rest1test

  Feature Description

  Scenario: Scenario 1
    When Отправить get "http://ufrmsdev1/ufr-zpfl-settings/admin/health" запрос
    And проверяем, что значение "status" есть в ответе
    And ответ ~= {"status":"UP"}

  @run
  Scenario: Scenario 2
    When Послали POST на URL "http://ufrmsdev1/ufr-azon-reports-api/reports" с параметрами:
      | key          | value      |
      | orid         | 000AJN     |
      | usid         | 0000000I0L |
      | channel      | AZON       |
      | type         | R00A       |
      | employeeType | E          |
    And Проверяем статус код == 200
    And ответ ~= {"rpid":".{10}"}
