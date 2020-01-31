require "./spec_helper"

describe RendezvousHash do
  it "adds a node" do
    r_hash = RendezvousHash.new
    r_hash.nodes.size.should eq 0

    r_hash.add("node0").should eq ["node0"]
    r_hash.nodes.size.should eq 1
    r_hash.find("node0").should eq "node0"
  end

  it "deletes a nodes" do
    r_hash = RendezvousHash.new(nodes: ["node0"])
    r_hash.nodes.size.should eq 1

    r_hash.remove?("node0").should eq "node0"
    r_hash.nodes.size.should eq 0

    r_hash.remove?("node0").should be_nil

    expect_raises(ArgumentError) do
      r_hash.remove("node0")
    end
  end

  it "replaces nodes" do
    r_hash = RendezvousHash.new(nodes: ["node0"])
    r_hash.nodes.size.should eq 1

    r_hash.nodes = ["node0", "node1", "node2"]
    r_hash.remove?("node0").should_not be_nil
  end

  describe "find" do
    it "locates a node" do
      r_hash = RendezvousHash.new(nodes: ["node0", "node1"])
      r_hash.find("Ebert").should eq "node0"
    end

    it "works after adding a node" do
      r_hash = RendezvousHash.new(nodes: ["node0"])
      r_hash.find("Stratton").should eq "node0"
      r_hash.add("node1")
      r_hash.find("Stratton").should eq "node1"
    end

    it "works after removing a node" do
      r_hash = RendezvousHash.new(nodes: ["node0", "node1"])
      r_hash.find("Pomeranz").should eq "node0"
      r_hash.remove("node0")
      r_hash.find("Pomeranz").should eq "node1"
    end
  end
end
