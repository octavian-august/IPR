# frozen_string_literal: true
# запусти irb
# подключи require './1.rb'
# start_browser
# смотри в селеноид сессию и дебажь тесты http://azondocker:9010

require 'selenium-webdriver'

def start_browser
  caps = Selenium::WebDriver::Remote::Capabilities.new
  caps['browserName'] = 'chrome'
  caps['enableVNC'] = true
  @browser = Selenium::WebDriver.for(:remote,
                                     url: 'http://azondocker:4555/wd/hub',
                                     desired_capabilities: caps)
  @browser.navigate.to 'http://ufrmsdev1/ufr-sandbox-versions-ui'
  ele = @browser.find_element :xpath, '(//*[contains(.,"abonds")])[last()]'
  ele.click
end

def quit_browser
  @browser.quit
end
