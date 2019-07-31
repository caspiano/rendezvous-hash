# rendezvous-hash

Rendezvous hashing for crystal that utilises the [murmur3](https://github.com/kuende/murmur3) hashing algorithm.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     rendezvous-hash:
       github: caspiano/rendezvous-hash
   ```

2. Run `shards install`

## Usage

```crystal

require "rendezvous-hash"

hash = RendezvousHash.new(nodes: ["node1", "node2", "node3"])

hash.find("device1")  # => "node3"

hash.remove("node3")  # => "node3"

hash.nodes            # => ["node1", "node2"]

hash.find("device1")  # => "node1"

hash.remove?("node3") # => nil

hash.add("node3")     # => ["node1", "node2", "node3"]

hash.find("device1")  # => "node3"

```

## Credit

- [clandestined](https://github.com/ewdurbin/clandestined-ruby)

## Contributing

1. [Fork it](https://github.com/caspiano/rendezvous-hash/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Caspian Baska](https://github.com/caspiano) - creator and maintainer
