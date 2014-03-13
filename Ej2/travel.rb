require './graph.rb'

class Travel

    def initialize(flights_file)
        read_flights(flights_file)
    end
    
    def read_flights(flights_file)
        f = File.open(flights_file)
        groups = f.readline.chomp.to_i
        f.readline #linea en blanco
        #por cada grupo
        while groups > 0
            @graph = Graph.new
            read_flight(f)
            puts "Persona #{groups}"
            puts @graph
            puts @graph.shortest_path('A', 'Z')
            f.readline #quita linea en blanco
        end

    end

    def read_flight(file)
        stopovers = file.readline.chomp.to_i
        while stopovers > 0
            step = file.readline.chomp.split
            @graph.add_vertex(step[0].upcase,{step[1].upcase => step[4].to_i})
            stopovers -= 1
        end
    end

end

T = Travel.new("input.txt")