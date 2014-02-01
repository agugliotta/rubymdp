require 'graph.rb'

class Travel

    def read_flights
        f = File.open()
        groups = f.readline.chomp
        f.readline #linea en blanco
        #por cada grupo
        read_flight(file,group)
    end

    def read_flight(file, group)
        
    end

end