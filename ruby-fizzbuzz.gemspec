# -*- encoding: utf-8 -*-

# :enddoc:

#
# ruby-fizzbuzz.gemspec
#
# Copyright 2012-2017 Krzysztof Wilczynski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

signing_key = File.expand_path('~/.gem/kwilczynski-private.pem')

Gem::Specification.new do |s|
  s.name    = 'ruby-fizzbuzz'
  s.summary = 'Yet another FizzBuzz in Ruby'

  s.description = <<-EOS
Yet another FizzBuzz in Ruby.

Provides simple and fast solution to a popular FizzBuzz problem for Ruby.

Written in C as an example of using Ruby's C API - with the support for
arbitrary large numeric values via the Bignum class, or the Integer class
starting from Ruby version 2.4 onwards.
  EOS

  s.platform = Gem::Platform::RUBY
  s.version  = File.read('VERSION').strip
  s.license  = 'Apache License, Version 2.0'
  s.author   = 'Krzysztof Wilczynski'
  s.email    = 'krzysztof.wilczynski@linux.com'
  s.homepage = 'http://about.me/kwilczynski'
  s.has_rdoc = true

  s.required_ruby_version = '>= 2.1.10'
  s.rubygems_version      = '~> 2.2.0'

  s.files = Dir['ext/**/*.{c,h,rb}'] +
            Dir['lib/**/*.rb']       +
            Dir['benchmark/**/*.rb'] +
            Dir['test/**/*.rb']      +
            %w(Rakefile Gemfile Guardfile Vagrantfile
               AUTHORS CHANGES CHANGES.rdoc COPYRIGHT
               LICENSE README README.rdoc TODO VERSION
               ruby-fizzbuzz.gemspec kwilczynski.asc
               kwilczynski-public.pem)

  s.executables   << 'fizzbuzz'
  s.require_paths << 'lib'
  s.extensions    << 'ext/fizzbuzz/extconf.rb'

  s.signing_key = signing_key if File.exist?(signing_key)
end

# vim: set ts=2 sw=2 sts=2 et :
# encoding: utf-8
