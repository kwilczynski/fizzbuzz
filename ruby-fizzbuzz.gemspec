signing_key = File.expand_path('~/.gem/kwilczynski-private.pem')

Gem::Specification.new do |s|
  s.name = 'ruby-fizzbuzz'
  s.summary = 'Yet another FizzBuzz in Ruby'

  s.description = (<<-EOS).gsub(/^[ ]+/, '')
    Yet another FizzBuzz in Ruby.

    Provides simple and fast solution to a popular FizzBuzz problem for Ruby.

    Written in C as an example of using Ruby's C API - with the support for
    arbitrary large numeric values via the Bignum class, or the Integer class
    starting from Ruby version 2.4 onwards.
  EOS

  s.platform = Gem::Platform::RUBY
  s.version = File.read('VERSION').strip
  s.license = 'Apache-2.0'
  s.author = 'Krzysztof Wilczynski'
  s.email = 'kw@linux.com'
  s.homepage = 'http://about.me/kwilczynski'

  s.required_ruby_version = '>= 2.1.10'
  s.rubygems_version = '~> 2.2.0'

  s.files = Dir['ext/**/*.{c,h,rb}'] +
            Dir['lib/**/*.rb'] +
            Dir['benchmark/**/*.rb'] +
            Dir['test/**/*.rb'] + %w(
              AUTHORS
              CHANGELOG.md
              CODE_OF_CONDUCT.md
              CONTRIBUTING.md
              COPYRIGHT
              Gemfile
              Guardfile
              LICENSE
              README.md
              Rakefile
              TODO
              VERSION
              Vagrantfile
              kwilczynski-public.pem
              kwilczynski.asc
              ruby-fizzbuzz.gemspec
            )

  s.executables << 'fizzbuzz'
  s.require_paths << 'lib'
  s.extensions << 'ext/fizzbuzz/extconf.rb'

  s.signing_key = signing_key if File.exist?(signing_key)
end
