require "murmur3"

class RendezvousHash
  getter nodes : Array(String)
  getter hash_function : Proc(String, UInt64)

  def initialize(@nodes = [] of String)
    @nodes = nodes || [] of String

    @hash_function = ->Murmur3.h1(String)
  end

  def add(node : String) : Array(String)
    @nodes.push(node) unless @nodes.includes?(node)
    @nodes
  end

  def remove(node : String) : String
    deleted = @nodes.delete(node)
    raise ArgumentError.new("Missing rendezvous hash node: #{node}") unless deleted

    deleted
  end

  def remove?(node : String) : String?
    @nodes.delete(node)
  end

  def find(key : String) : String
    @nodes.reduce({"", -1}) do |(best_node, best_score), current_node|
      score = @hash_function.call("#{current_node}-#{key}")
      if score > best_score
        ({current_node, score})
      elsif score == best_score
        # Pick longest key with best score
        ({ {best_node, current_node}.max, best_score })
      else
        ({best_node, best_score})
      end
    end.first
  end
end
