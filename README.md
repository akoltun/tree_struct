# TreeStruct

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/tree_struct`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tree_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tree_struct

## Usage

It is used as the parent class for [FormObj::Form](https://github.com/akoltun/form_obj)

### Table of Contents

1. [Definition](#1-definition)
   1. [Nested TreeStruct](11-nested-tree-struct)
   2. [Array of TreeStruct](12-array-of-tree-struct)
2. [Serialize to Hash](2-serialize-to-hash)
   1. [Nested TreeStruct](21-nested-tree-struct)
   2. [Array of TreeStruct](22-array-of-tree-struct)
3. [Reference Guide](3-reference-guide-attribute-parameters)

### 1. Definition

Inherit your class from `TreeStruct` and define its attributes.

```ruby
class SimpleTreeStruct < TreeStruct
  attribute :name
  attribute :year
end
```

Access attributes via dot notation.

```ruby
simple_tree_struct = SimpleTreeStruct.new
simple_tree_struct.name = 'Ferrari'         # => "Ferrari"
simple_tree_struct.year = 1950              # => 1950
```

#### 1.1. Nested TreeStruct Objects

Use blocks to define nested TreeStruct.

```ruby
class NestedTreeStruct < TreeStruct
  attribute :name
  attribute :year
  attribute :car do
    attribute :model
    attribute :driver
    attribute :engine do
      attribute :power
      attribute :volume
    end
  end
end
```

Or explicitly define nested TreeStruct classes.

```ruby
class EngineTreeStruct < TreeStruct
  attribute :power
  attribute :volume
end
class CarTreeStruct < TreeStruct
  attribute :model
  attribute :driver
  attribute :engine, class: EngineTreeStruct
end
class NestedTreeStruct < TreeStruct
  attribute :name
  attribute :year
  attribute :car, class: CarTreeStruct
end
```

Access attributes via dot notation.

```ruby
nested_tree_struct = NestedTreeStruct.new
nested_tree_struct.name = 'Ferrari'         # => "Ferrari"
nested_tree_struct.year = 1950              # => 1950
nested_tree_struct.car.model = '340 F1'     # => "340 F1"
nested_tree_struct.car.driver = 'Ascari'    # => "Ascari"
nested_tree_struct.car.engine.power = 335   # => 335
nested_tree_struct.car.engine.volume = 4.1  # => 4.1
```

#### 1.2. Array of TreeStruct Objects

Specify attribute parameter `array: true` in order to define an array of TreeStruct objects

```ruby
class ArrayTreeStruct < TreeStruct
  attribute :name
  attribute :year
  attribute :cars, array: true do
    attribute :model
    attribute :driver
    attribute :engine do
      attribute :power
      attribute :volume
    end
  end
end
```

or

```ruby
class EngineTreeStruct < TreeStruct
  attribute :power
  attribute :volume
end
class CarTreeStruct < TreeStruct
  attribute :model
  attribute :driver
  attribute :engine, class: EngineTreeStruct
end
class ArrayTreeStruct < TreeStruct
  attribute :name
  attribute :year
  attribute :cars, array: true, class: CarTreeStruct
end
```

Add new elements in the array by using method :create which adds a new it.

```ruby
array_tree_struct = ArrayTreeStruct.new
array_tree_struct.name = 'Ferrari'              # => "Ferrari"
array_tree_struct.year = 1950                   # => 1950
array_tree_struct.size 				            # => 0
array_tree_struct.cars.create
array_tree_struct.size 				            # => 1
array_tree_struct.cars[0].model = '340 F1'      # => "340 F1"
array_tree_struct.cars[0].driver = 'Ascari'     # => "Ascari"
array_tree_struct.cars[0].engine.power = 335    # => 335
array_tree_struct.cars[0].engine.volume = 4.1   # => 4.1
```

### 2. Serialize to Hash

Call `to_hash` method in order to get hash representation of the TreeStruct object

```ruby
simple_tree_struct.to_hash      # => {
                                # =>    :name => "Ferrari",
                                # =>    :year => 1950  
                                # => }
```

#### 2.1. Nested TreeStruct Objects

```ruby
nested_tree_struct.to_hash      # => {
                                # =>    :name => "Ferrari",
                                # =>    :year => 1950,
                                # =>    :car  => {
                                # =>      :model => "340 F1",
                                # =>      :driver => "Ascari",
                                # =>      :engine => {
                                # =>        :power => 335,
                                # =>        :volume => 4.1
                                # =>      }   
                                # =>    }
                                # => }
```

#### 3.2. Array of TreeStruct Objects

```ruby
array_tree_struct.to_hash       # => {
                                # =>    :name => "Ferrari",
                                # =>    :year => 1950,
                                # =>    :cars => [{
                                # =>      :model => "340 F1",
                                # =>      :driver => "Ascari",
                                # =>      :engine => {
                                # =>        :power => 335,
                                # =>        :volume => 4.1
                                # =>      }
                                # =>    }] 
                                # => }
```

### 3. Reference Guide: `attribute` parameters

| Parameter | Condition | Default value | Description |
| --- |:---:|:---:| --- |
| array | block* or `:class`** | `false` | This attribute is an array of TreeStruct objects. The structure of array element is described either in the block or in the separate class referenced by `:class` parameter |
| class | - | - | This attribute is either nested TreeStruct object or an array of TreeStruct objects. The value of this parameter is a class or a name of a class of this TreeStruct object. |
\* block - means that there is block definition for the attribute

\** `:class` - means that this attribute has `:class` parameter specified
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akoltun/tree_struct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
