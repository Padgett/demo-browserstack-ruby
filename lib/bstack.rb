require 'selenium-webdriver'
require 'logger'

USER_NAME = ENV['BROWSERSTACK_USERNAME']
ACCESS_KEY = ENV['BROWSERSTACK_ACCESS_KEY']

def run_test(env)
  logger = Logger.new(STDOUT)

  options = Selenium::WebDriver::Options.send env['browserName']
  options.browser_version = env['browserVersion']
  options.add_option('bstack:options', env['bstack:options'])

  driver = Selenium::WebDriver.for(
    :remote,
    :url => "https://#{USER_NAME}:#{ACCESS_KEY}@hub.browserstack.com/wd/hub",
    :capabilities => options
  )

  begin
    # Sometimes the site is slow to load, so we need to wait for the page to load
    driver.manage.timeouts.implicit_wait = 5 # seconds

    # Load the URL
    driver.get('https://bstackdemo.com/')

    # Check if the title of the page is 'StackDemo'
    if driver.title != 'StackDemo'
      logger.error('Page title is incorrect')
      raise 'Page title is incorrect'
    end

    # Click the 'Sign In' button
    driver.find_element(:id, 'signin').click

    # Enter the username
    driver.find_element(:id, 'username').click
    user_input = driver.find_element(:id, 'react-select-2-input')
    user_input.send_keys('demouser')
    user_input.send_keys(:return)

    # Enter the password
    driver.find_element(:id, 'password').click
    pw_input = driver.find_element(:id, 'react-select-3-input')
    pw_input.send_keys('testingisfun99')
    pw_input.send_keys(:return)
    
    # Click the 'Login' button
    driver.find_element(:id, 'login-btn').click

    # Click the 'Samsung' filter
    driver.find_element(:css, 'input[type="checkbox"][value="Samsung"] + span').click
    
    # Check if the 'Samsung' checkbox is selected
    samsung = driver.find_element(:css, 'input[type="checkbox"][value="Samsung"]')
    if samsung.selected? == false
      logger.error('Samsung checkbox not selected')
      raise 'Samsung checkbox not selected'
    end
    
    # Click the 'Add to Favorites' button for the Galaxy S20+
    driver.find_element(:xpath, '//*[@id="11"]/div[1]/button').click

    # Click the 'Favorites' link
    driver.find_element(:css, '#favourites > strong').click
    
    # Ensure we are on the Favorites page
    favorites_url = driver.current_url
    if favorites_url != 'https://bstackdemo.com/favourites'
      logger.error 'Favorites page not loaded'
      raise 'Favorites page not loaded'
    end
    
    # Check if the 'Galaxy S20+' is in the favorites
    galaxy = driver.find_element(:xpath, '//*[@id="11"]/p')
    if galaxy.text != 'Galaxy S20+'
      logger.error 'Galaxy S20+ not found in favorites'
      raise 'Galaxy S20+ not found in favorites'
    end
    
    logger.info('Test passed')
    # Mark the status of the test as 'passed' if the test runs successfully
    driver.execute_script(
      'browserstack_executor: {"action": "setSessionStatus", "arguments": {"status": "passed", "reason": "Assertions passed"}}'
    )
  rescue StandardError => e
    puts "Exception occured: #{e.message}"
    # Mark the status of the test as 'failed' if an exception occurs
    driver.execute_script(
      'browserstack_executor: {"action": "setSessionStatus", "arguments": {"status": "failed", "reason":' +  "\"#{e.message}\"" + ' }}'
    )
  ensure
    driver.quit
  end
end