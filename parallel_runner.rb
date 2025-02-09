require_relative 'lib/bstack'

environments = [
  {
    'bstack:options' => {
      'os' => 'OS X',
      'osVersion' => 'Ventura',
      'buildName' => 'browserstack-osx',
      'sessionName' => 'parallel ruby'
    },
    'browserName' => 'firefox',
    'browserVersion' => 'latest'
  },
  {
    'bstack:options' => {
      'os' => 'Windows',
      'osVersion' => '10',
      'buildName' => 'demo-browserstack-windows',
      'sessionName' => 'parallel ruby'
    },
    'browserName' => 'chrome',
    'browserVersion' => 'latest'
  },
  {
    'bstack:options' => {
      'osVersion' => '12.0',
      'deviceName' => 'Samsung Galaxy S20',
      'buildName' => 'demo-browserstack-galaxy',
      'sessionName' => 'parallel ruby'
    },
    'browserName' => 'chrome',
    'browserVersion' => 'latest'
  }
]

threads = environments.map do |env|
  Thread.new { run_test(env) }
end

threads.map(&:join)

puts "All tests completed"