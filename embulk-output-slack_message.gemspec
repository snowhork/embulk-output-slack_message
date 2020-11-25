Gem::Specification.new do |spec|
  spec.name          = "embulk-output-slack_message"
  spec.version       = "0.1.1"
  spec.authors       = ["snowhork"]
  spec.summary       = "Slack Message output plugin for Embulk"
  spec.description   = "Send records to Slack Message."
  spec.email         = ["YOUR_NAME"]
  spec.licenses      = ["MIT"]
  # TODO set this: spec.homepage      = "https://github.com/YOUR_NAME/embulk-output-slack_message"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', ['>= 0.8.39']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']

  # faradey 1.1.0 uses ruby 2.4. It compatible embulk ruby.
  spec.add_dependency 'faraday', ['< 1.1.0']
end
