# Description: Sample RSpec test script to run a test on Selenium with ChromeDriver.
# Run: rspec bstackdemo_spec.rb

require 'selenium-webdriver'
require 'json'
require 'rspec'

describe 'BStack Demo' do
  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @vars = {}
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @driver.get('https://bstackdemo.com/')
  end
  after(:each) do
    @driver.quit
  end

  it 'loads the correct page' do
    expect(@driver.title).to eq('StackDemo')
  end

  it 'logs in' do
    @driver.find_element(:id, 'signin').click
    @driver.find_element(:id, 'username').click
    @driver.find_element(:id, 'react-select-2-option-0-0').click
    @driver.find_element(:id, 'password').click
    @driver.find_element(:id, 'react-select-3-option-0-0').click
    @driver.find_element(:id, 'login-btn').click
    expect(@driver.find_element(:id, 'signin').text).to eq('Logout')
  end

  it 'logs in and adds Galaxy S20+ to favorites' do
    @driver.find_element(:id, 'signin').click
    @driver.find_element(:id, 'username').click
    @driver.find_element(:id, 'react-select-2-option-0-0').click
    @driver.find_element(:id, 'password').click
    @driver.find_element(:id, 'react-select-3-option-0-0').click
    @driver.find_element(:id, 'login-btn').click
    @driver.find_element(:css, 'input[type="checkbox"][value="Samsung"] + span').click
    expect(@driver.find_element(:css, 'input[type="checkbox"][value="Samsung"]').selected?).to be_truthy
    @driver.find_element(:xpath, '//*[@id="11"]/div[1]/button').click
    @driver.find_element(:css, '#favourites > strong').click
    expect(@driver.find_element(:xpath, '//*[@id="11"]').displayed?).to be_truthy
    expect(@driver.find_element(:xpath, '//*[@id="11"]/p').text).to eq('Galaxy S20+')
  end
end
