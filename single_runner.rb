require_relative 'lib/bstack'

environment = {
  'bstack:options' => {
    'osVersion' => '12.0',
    'deviceName' => 'Samsung Galaxy S20',
    'buildName' => 'demo-browserstack-galaxy',
    'sessionName' => 'single ruby'
  },
  'browserName' => 'chrome',
  'browserVersion' => 'latest'
}

run_test(environment)

puts "Test completed"