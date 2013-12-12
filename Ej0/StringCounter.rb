class StringCounter
    attr_reader :phrase, :words, :occurrences

    def initialize(phrase)
        @phrase = phrase
        @occurrences = Hash.new(0)
    end

    def count
        @words = phrase.split
        while not words.empty?
            occurrences[words.first] += 1
            words.shift
        end
    end

    def show
        occurrences.each {|key, value| puts "#{key} => #{value}"}
    end
end

s = StringCounter.new("Lorem ipsum dolor sit amet. Vivamus gravida convallis porta. Etiam ut ante sagittis, lobortis magna sit amet.")
s.count
s.show