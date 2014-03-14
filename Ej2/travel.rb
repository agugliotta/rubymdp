require './digraph.rb'

class Travel
    
    def read_flights(flights_file)
        f = File.open(flights_file)
        groups = f.readline.chomp.to_i
        person = 1
        while groups > 0
            f.readline
            @graph = Digraph.new
            info = read_flight(f)
            puts "Persona #{person}"
            result = @graph.shortest_path_between('A', 'Z')
            print_data(info, result)
            groups -= 1
            person +=1
        end

    end

    def read_flight(file)
        stopovers = file.readline.chomp.to_i
        data = []
        while stopovers > 0
            step = file.readline.chomp.split
            @graph.push_edge(step[0].upcase,step[1].upcase,step[4].to_i)
            data.push({'o' => step[0].upcase, 
                       'd' => step[1].upcase,
                       'oh'=> step[2],
                       'dh'=> step[3],
                       'v' => step[4].to_i})
            stopovers -= 1
        end
        data
    end

    def print_data(info, result)
        info = info.sort_by{|field| field['v']}
        data_origin = info.detect{|flight| flight['o'] == result['path'][0] and flight['d'] == result['path'][1]}
        data_destination = info.detect{|flight| flight['o'] == result['path'][-2] and flight['d'] == result['path'][-1]}
        puts "#{data_origin['oh']} #{data_destination['dh']} #{result['cost']}"
    end

end

T = Travel.new
T.read_flights("input.txt")