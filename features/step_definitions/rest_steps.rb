# encoding: utf-8

  Then(/^Проверяем статус код == (\d+)$/) do |statuscode|
    expect(statuscode.to_s).to eq(@last_response.code.to_s)
  end
  
  And(/^Проверяем что ответ пришел в формате JSON$/) do
    expect(json_string? @last_response).to be true
  end
  
  When(/^Послали "([^"]*)" на URL "([^"]*)" с параметрами:$/) do |request_type, urn, table|
    puts request_type
    payload_hash = {}
    headers_hash = {}
    table.hashes.each {|param| payload_hash = payload_hash.merge(Hash[param[:key], param[:value]])}
    send_post(urn, payload_hash, headers_hash)
  end
  
  Then(/^Проверяем что значение "([^"]*)" равно "([^"]*)"$/) do |key, value|
    validate_auth(key, value)
  end
  
  When(/^Послали "([^"]*)" без headers на URL "([^"]*)" с параметрами:$/) do |request_type, urn, table|
    puts request_type
    payload_hash = {}
    headers_hash = {}
    table.hashes.each {|param| payload_hash = payload_hash.merge(Hash[param[:key], param[:value]])}
    send_post(urn, payload_hash, headers_hash)
  end
  
  When(/^Послали POST на URL "([^"]*)" с параметрами:$/) do |urn, table|
    payload_hash = {}
    headers_hash = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    table.hashes.each {|param| payload_hash = payload_hash.merge(Hash[param[:key], param[:value]])}
    payload_hash = payload_hash.to_json
    send_post(urn, payload_hash, headers_hash)
  end
  
  
  When(/^Отправить get "([^"]*)" запрос$/) do |url|
    @response = send_get("#{url}/?")
    log_response_params @last_response.code, @last_response.headers, @last_response.body
    @last_response = @response
  end
  
  
  Then(/^Проверяем сообщения об ощибках$/) do
    puts JSON.parse(@last_response.body)['errors'].each do |error|
      puts error.class
    end
  end
  
  Then(/^проверяем, что значение "([^"]*)" есть в ответе$/) do |key|
    expect((JSON.parse @last_response.body).keys).to include(key)
  end
  
  Then(/^проверяем, что в ответе существует параметр "([^"]*)" со значением "([^"]*)"$/) do |key, value|
    finded = (JSON.parse @last_response.body).find {|obj| obj[key]==value}
    actual = finded[key]
    expected = value
    expect(actual).to eq expected
  end
  
  Then(/^проверяем, что в ответе существует параметр с ключом ([^"]*)$/) do |key|
    actual = ((JSON.parse @last_response.body).find {|obj| obj.keys.include? key}).nil?
    expect(actual).to eq (false)
  end
  
  When(/^get "([^"]*)" запрос$/) do |url|
    headers_hash = {'X-CSRF-Token': @alfa_csrf_token, cookies: {access_token: @access_token, 'alfa-csrf-token': @alfa_csrf_token}}
    @response = send_get(url,headers_hash)
    @last_response = @response
  end
  
  When(/^подождали "([^"]*)" секунд$/) do |sec|
    sleep sec.to_i
  end
  
  Then (/В ответе проверяем, что в теле есть значение ([^"]*) есть ключ ([^"]*) который равен значению ([^"]*)$/) do |body, key, value|
    response = JSON.parse(@last_response.body)
    response_hash = response[body]
    response_hash = response_hash[0].select{|k,v| k==key}
    response_value_key = response_hash[key]
    puts response_value_key
    expect(response_value_key).to eq(value)
  end
  
  
  Then(/^Проверяем что в ответе есть объект со значением "([^"]*)" равно "([^"]*)"$/) do |key, value|
  
    s_array = JSON.parse(@last_response.body)
    expect(s_array.find { |item| item["#{key}"] == value }).to_not be_nil,lambda { 'obj not found in body' }
  end
  
  Then(/^Проверяем что в ответе нет объекта со значением "([^"]*)" равно "([^"]*)"$/) do |key, value|
    s_array = JSON.parse(@last_response.body)
    expect(s_array.find { |item| item["#{key}"] == value }).to be_nil,lambda { 'obj not found in body' }
  end

  When(/^ответ ~= (.*)$/) do |key|
    expect(@last_response.body).to match(key)
  end