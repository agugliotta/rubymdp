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
end