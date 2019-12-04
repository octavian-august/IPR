# frozen_string_literal: true

def send_get(path, headers = {})
    # в url русские символы кодируем в unicode
    path = URI.escape(path)
  
    url = path
    log_rest_params "Url = #{url} ", 'payload = NULL ', "headers = #{headers} "
    RestClient.get(url, headers) do |response, _request, _result|
      log_response_params response.code, response.headers, response.body
      case response.code
      when 301, 302, 307
        @last_response = response.follow_redirection
      else
        log_response_params response.code, response.headers, response.body
        @last_response = response
      end
    end
  end
  
  def send_post(urn, payload, headers = {})
    url = urn
    log_rest_params "Url = #{url} ", "payload = #{payload} ", "headers = #{headers} "
    RestClient.post(url, payload, headers) { |response, _code| @last_response = response }
    log_response_params @last_response.code, @last_response.headers, @last_response.body
    @last_response
  end
  
  def send_delete(path, headers = {})
    puts url = path
    log_rest_params "Url = #{url} ", 'payload = NULL ', "headers = #{headers} "
    RestClient.delete(url, headers) do |response, _request, _result|
      case response.code
      when 301, 302, 307
        @last_response = response.follow_redirection
      else
        @last_response = response
      end
    end
  end
  
  def validate_auth(key = '', value = '')
    data = JSON.parse(@last_response.body)
    expect(data[key]).to eq(value)
  end
  
  def get_csrf_token
    @response = send_get('/ufr-zpfl-front/', Cookie: "access_token=#{get_token_for_browser}")
    puts "BODY  #{@response.body}"
    puts "SCODE  #{@response.code}"
    puts "TOKEN[alfa-csrf-token]  #{@response.cookies['alfa-csrf-token']}"
    puts "TOKEN[access_token]  #{@response.cookies['access_token']}"
    @response.cookies['alfa-csrf-token']
  end
  
  def log_test(message = '__________')
    puts message
  end
  
  def log_rest_params(url, payload, headers)
    puts __method__.to_s
    puts url
    puts payload
    puts headers
  end
  
  def log_response_params(code, headers, body)
    puts __method__.to_s
    puts "response_code = #{code} "
    puts "response_head = #{headers} "
    parsed = body && body.length >= 2 && (json_string? body) ? JSON.parse(body) : {}
    puts "response_body = #{JSON.parse(parsed.to_json)} "
  end
  
  
  # Проверяем валидность json
  def json_string?(foo)
    JSON.parse(foo)
    true
  rescue StandardError
    false
  end