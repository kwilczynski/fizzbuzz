# frozen_string_literal: true

require 'json'

require_relative 'fizzbuzz/fizzbuzz'
require_relative 'fizzbuzz/version'
require_relative 'fizzbuzz/core/integer'
require_relative 'fizzbuzz/core/array'
require_relative 'fizzbuzz/core/range'

#
# Yet another _FizzBuzz_ in Ruby.
#
# Provides simple and fast solution to a popular _FizzBuzz_ problem for Ruby.
#
class FizzBuzz
  #
  # call-seq:
  #    FizzBuzz.fizzbuzz( start, stop, reverse ) {|value| block } -> self
  #    FizzBuzz.fizzbuzz( start, stop, reverse )                  -> array
  #
  # Returns either an +array+ or accepts a block if such is given. When a block is
  # given then it will call the block once for each subsequent value for a given
  # range from +start+ to +stop+, passing the value as a parameter to the block.
  #
  # Additionally, if the value of +reverse+ is set to be +true+ then the results will
  # be given in an <em>reverse order</em> whether in a resulting array or when passing
  # values to a block given.
  #
  # Example:
  #
  #    FizzBuzz.fizzbuzz(1, 15)          #=> [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]
  #    FizzBuzz.fizzbuzz(1, 15, true)    #=> ["FizzBuzz", 14, 13, "Fizz", 11, "Buzz", "Fizz", 8, 7, "Fizz", "Buzz", 4, "Fizz", 2, 1]
  #
  # Example:
  #
  #    FizzBuzz.fizzbuzz(1, 15) {|value| puts "Got #{value}" }
  #
  # Produces:
  #
  #    Got 1
  #    Got 2
  #    Got Fizz
  #    Got 4
  #    Got Buzz
  #    Got Fizz
  #    Got 7
  #    Got 8
  #    Got Fizz
  #    Got Buzz
  #    Got 11
  #    Got Fizz
  #    Got 13
  #    Got 14
  #    Got FizzBuzz
  #
  # See also: FizzBuzz::[], FizzBuzz::new, FizzBuzz#to_a, FizzBuzz#each and FizzBuzz#reverse_each
  #
  def self.fizzbuzz(start, stop, reverse = false, &block)
    fb = new(start, stop)

    if block_given?
      fb.send(reverse ? :reverse_each : :each, &block)
      self
    else
      fb.to_a.send(reverse ? :reverse : :to_a)
    end
  end

  #
  # call-seq:
  #    FizzBuzz.step( start, stop, step ) {|value| block } -> an integer
  #    FizzBuzz.step( start, stop, step )                  -> an Enumerator
  #
  # Calls the block _once_ for each subsequent value for a given range
  # from +start+ to +stop+, passing the value as a parameter to the block
  # in the increments of +step+.
  #
  # If no block is given, an +Enumerator+ is returned instead.
  #
  # Example:
  #
  #    s = FizzBuzz.step    #=> #<Enumerator: #<Enumerator::Generator:0x559db8e7>:each>
  #    s.take(15).each {|value| puts "Got #{value}" }
  #
  # Produces:
  #
  #    Got 1
  #    Got 2
  #    Got Fizz
  #    Got 4
  #    Got Buzz
  #    Got Fizz
  #    Got 7
  #    Got 8
  #    Got Fizz
  #    Got Buzz
  #    Got 11
  #    Got Fizz
  #    Got 13
  #    Got 14
  #    Got FizzBuzz
  #
  # See also: FizzBuzz::fizzbuzz, FizzBuzz::[] and FizzBuzz#step
  #
  def self.step(start = 1, stop = nil, step = 1, &block)
    if block_given?
      start.step(stop, step) do |n|
        yield FB[n]
      end
    else
      Enumerator.new do |y|
        start.step(stop, step).each do |n|
          y << FB[n]
        end
      end
    end
  end

  #
  # call-seq:
  #    fizzbuzz.step( start, stop, step ) {|value| block } -> an integer
  #    fizzbuzz.step( start, stop, step )                  -> an Enumerator
  #
  # Calls the block _once_ for each subsequent value for a given range
  # from +start+ to +stop+, passing the value as a parameter to the block
  # in the increments of +step+.
  #
  # If no block is given, an +Enumerator+ is returned instead.
  #
  # Example:
  #
  #    fb = FizzBuzz.new(1, 15)    #=> #<FizzBuzz:0x5653a2d1 @start=1, @stop=15>
  #    s = fb.step                 #=> #<Enumerator: #<Enumerator::Generator:0x559db8e7>:each>
  #    s.take(15).each {|value| puts "Got #{value}" }
  #
  # Produces:
  #
  #    Got 1
  #    Got 2
  #    Got Fizz
  #    Got 4
  #    Got Buzz
  #    Got Fizz
  #    Got 7
  #    Got 8
  #    Got Fizz
  #    Got Buzz
  #    Got 11
  #    Got Fizz
  #    Got 13
  #    Got 14
  #    Got FizzBuzz
  #
  # See also: FizzBuzz::step, FizzBuzz::fizzbuzz and FizzBuzz::[]
  #
  def step(start = @start, stop = @stop, step = 1, &block)
    self.class.step(start, stop, step, &block)
  end

  #
  # call-seq:
  #    fizzbuzz.to_hash -> hash
  #
  # Returns a +hash+ representing the _FizzBuzz_ object.
  #
  # Example:
  #
  #    fb = FizzBuzz.new(1, 15)    #=> #<FizzBuzz:0x007fbe84 @start=1, @stop=15>
  #    fb.to_hash
  #
  # Produces:
  #
  #    {
  #      "fizzbuzz" => {
  #        "start" => 1,
  #         "stop" => 15
  #      }
  #    }
  #
  # See also: FizzBuzz#as_json and FizzBuzz#to_json
  #
  def to_hash
    {
      'fizzbuzz' => {
        'start' => @start,
        'stop' => @stop
      }
    }
  end

  #
  # call-seq:
  #    fizzbuzz.as_json( arguments ) -> hash
  #
  # Returns a +hash+ representing the _FizzBuzz_ object that will be
  # used when generating a _JSON_ string representation.
  #
  # Example:
  #
  #    fb = FizzBuzz.new(1, 15)    #=> #<FizzBuzz:0x007f90c1 @start=1, @stop=15>
  #    fb.as_json
  #
  # Produces:
  #
  #    {
  #      "json_class" => "FizzBuzz",
  #        "fizzbuzz" => {
  #        "start" => 1,
  #         "stop" => 15
  #      }
  #    }
  #
  # See also: FizzBuzz#to_json and FizzBuzz#to_hash
  #
  def as_json(*)
    { JSON.create_id => self.class.name }.merge(to_hash)
  end

  #
  # call-seq:
  #    fizzbuzz.to_json( arguments ) -> string
  #
  # Returns a _JSON_ string representing the _FizzBuzz_ object.
  #
  # Example:
  #
  #    fb = FizzBuzz.new(1, 15)    #=> #<FizzBuzz:0x007fce83 @start=1, @stop=15>
  #    fb.to_json
  #
  # Produces:
  #
  #    {
  #      "json_class": "FizzBuzz",
  #      "fizzbuzz": {
  #        "start": 1,
  #        "stop": 15
  #      }
  #    }
  #
  # See also: FizzBuzz::json_create, FizzBuzz#as_json and FizzBuzz#to_hash
  #
  def to_json(*arguments)
    as_json.to_json(*arguments)
  end

  #
  # call-seq:
  #    FizzBuzz.json_create( object ) -> FizzBuzz
  #
  # Creates a new _FizzBuzz_ object with both the +start+ and +stop+ values
  # set accordingly given a _JSON_ string that is an representation of the
  # _FizzBuzz_ object.
  #
  # Example:
  #
  #    json = <<-EOS
  #      {
  #        "json_class": "FizzBuzz",
  #        "fizzbuzz": {
  #          "start": 1,
  #          "stop": 15
  #        }
  #      }
  #    EOS
  #
  #    fb = JSON.load(json)    #=> #<FizzBuzz:0x007fc082 @start=1, @stop=15>
  #    fb.to_hash
  #
  # Produces:
  #
  #    {
  #      "fizzbuzz" => {
  #        "start" => 1,
  #         "stop" => 15
  #      }
  #    }
  #
  # See also: FizzBuzz#to_json, FizzBuzz::[], FizzBuzz::new and FizzBuzz::fizzbuzz
  #
  def self.json_create(object)
    new(*object['fizzbuzz'].values_at('start', 'stop'))
  end

  alias to_h to_hash
end

FB = FizzBuzz
