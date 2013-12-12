require_relative 'minitest_helper'
require 'compare.rb'

class CompareTest < Minitest::Test
    def test_dHamming
        comp = Compare.new

        input1 = 'GAGCCTACTAACGGGAT'
        input2 = 'CATCGTAATGACGGCCT'
        output = 7

        assert_equal output, comp.dHamming(input1, input2)


        input1 = 'AAAAAAAAAAAAAAAAA'
        input2 = 'AAAAAAAAAAAAAAAAB'
        output = 1

        assert_equal output, comp.dHamming(input1, input2)

        input1 = 'AAAAAAAAAAAAAAAAA'
        input2 = 'AAAAAAAAAAAAAAAAA'
        output = 0

        assert_equal output, comp.dHamming(input1, input2)
    end
end
