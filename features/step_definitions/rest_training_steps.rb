# encoding: utf-8

  Then(/^Складываю число (.*) и число (.*)$/) do |x, y|
    @sum = x + y
  end

  Then(/^Умножаю результат сложения на число (.*)$/) do |z|
    @multiplication = @sum * z
  end

  Then(/^Результат умножения == (.*)$/) do |result|
    expect(@multiplication).to eq(result)
  end