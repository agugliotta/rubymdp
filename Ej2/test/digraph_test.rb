require_relative 'minitest_helper'
require 'digraph.rb'

class DiagraphTest < Minitest::Test

    def test_show
        g = Digraph.new
        g.push_edge("A", "B", "50")
        g.push_edge("A", "B", "300")
        g.push_edge("A", "C", "175")
        g.push_edge("B", "C", "75")
        g.push_edge("B", "Z", "250")
        g.push_edge("C", "B", "50")
        g.push_edge("C", "Z", "100")

        output = ["A", "B", "C", "Z"]

        assert_equal output, g.show
    end

    def test_shortest_path_between
        g = Digraph.new
        g.push_edge('A', 'B', '100')
        g.push_edge('B', 'Z', '100')
        g.push_edge('A', 'Z', '300')

        origin = 'A'
        destination = 'Z'
        output = {"path"=>["A", "B", "Z"], "cost"=>200}

        assert_equal(output, g.shortest_path_between(origin, destination))
    end
end

class EdgeTest < Minitest::Test

    def test_size
        e = Edge.new('A')
        e.push_neighbor('B',5)

        output = 1

        assert_equal output, e.size


        e.push_neighbor('C',5)

        output = 2

        assert_equal output, e.size
    end

    def test_has_destinations?
        e = Edge.new('A')
        e.push_neighbor('B',5)

        output = true

        assert_equal output, e.has_destinations?


        e = Edge.new('A')

        output = false
        
        assert_equal output, e.has_destinations?
    end
end