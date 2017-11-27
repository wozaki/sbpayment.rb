module GetTokensHelper
  def get_tokens
    # Get token from https://jsbin.com/wufoded
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    driver.get('https://jsbin.com/wufoded')

    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    token = wait.until { driver.find_element(id: 'token').text }
    token_key = wait.until { driver.find_element(id: 'tokenKey').text }
    driver.quit

    [token, token_key]
  end
end
