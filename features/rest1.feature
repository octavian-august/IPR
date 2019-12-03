Feature: rest1test

   Feature Description

   Scenario: Scenario 1
     When Отправить get "http://ufrmsdev1/ufr-zpfl-settings/admin/health" запрос
     And проверяем, что значение "status" есть в ответе 
     