require 'algorithms'

class Edge

    attr_accessor :name

    def initialize(name)
        @name = name
        @destinations = Containers::Queue.new()
        # blk = lambda { |x, y| (y <=> x) == 1 }
        # @destinations = Containers::PriorityQueue.new(&blk)
    end

    def push_neighbor(node,value)
        neighbor = Hash.new()
        neighbor['destination'] = node
        neighbor['value'] = value
        @destinations.push(neighbor)
    end

    def pop_neighbor
        @destinations.pop
    end

    def has_destinations?
        if @destinations.size > 0
            true
        else
            false
        end
    end

    def size
        @destinations.size
    end

    def show
        puts name.to_s + '=>' + destination.to_s
    end

end

class Digraph

    attr_accessor :list

    def initialize
        blk = lambda { |x, y| (y <=> x) == 1 }
        # @edges = Containers::PriorityQueue.new(&blk)
        # @edges = Hash.new
        @list = []
        # @vertices = []
        @vertices = Hash.new
    end

    def push_edge(node, destination, value)
        # @edges[node] = edge
        # @edges.push(destination,value)
        # @vertices.push(node)
        @list.push({'origin' => node, 'destination' => destination, 'value' => value})
        if @vertices.has_key?(node)
            @vertices[node].push_neighbor(destination,value)
            puts "adding #{node} => #{destination}"
        else
            puts "adding #{node} => #{destination}"
            edge = Edge.new(node)
            edge.push_neighbor(destination,value)
            @vertices[node] = edge
        end

        if !@vertices.has_key?(destination)
            @vertices[destination] = Edge.new(destination)
        end
    end


    def show
        v = []
        @vertices.each do |vertex, edges|
            v << vertex
        end
        v
    end

    # def edge_value(origin,destination)
    #     #always return the minimun value
    #     values = []
    #     @list.each do |info|
    #         if info['origin'] == origin and info['destination'] == destination
    #             values.push info['value'].to_i
    #         end
    #     end
    #     values.sort.first
    # end

    def shortest_path_between(origin,destination)
        infinite = 2 << 63
        distance = {}
        previous = {}
        # value = 0
        blk = lambda { |x, y| (y <=> x) == 1 }
        nodes = Containers::PriorityQueue.new(&blk)

        #add all the vertex to nodes
        @vertices.each do | vertex, neighbor |
            if vertex == origin
                distance[vertex] = 0
                nodes.push(vertex,0)
            else
                distance[vertex] = infinite
                nodes.push(vertex,infinite)
            end

            previous[vertex] = nil
        end

        puts "========================================="
        puts distance.inspect
        puts "Destination #{destination}"
        puts "========================================="

        #start the search
        while nodes.size != 0
            smallest = nodes.pop
            puts "Smallest #{smallest} Node size #{nodes.size}"
            puts "Distance #{distance.inspect}"

            if smallest == destination
                path = []
                #distance[smallest]} tiene el valor
                #puts "Valor #{distance[smallest]}"
                while previous[smallest]
                    ##### Calculate amount ######
                    # value += edge_value(previous[smallest],smallest)
                    ##############################
                    path.push(smallest)
                    smallest = previous[smallest]
                end
                path.push(origin)
                return "Path #{path.reverse} #{distance[destination]}"
            end

            if distance[smallest] == infinite
                break
            end
            if !(@vertices[smallest] == nil)
                while @vertices[smallest].has_destinations?
                    neighbor = @vertices[smallest].pop_neighbor
                    alt = distance[smallest].to_i + neighbor['value'].to_i
                    puts "Dest #{neighbor['destination']} #{nodes.size}"
                    if alt < distance[neighbor['destination']].to_i
                        distance[neighbor['destination']] = alt
                        previous[neighbor['destination']] = smallest
                        nodes.push(neighbor['destination'], alt)
                    end
                end
            end
        end

        return "Dist #{distance.inspect}"
    end


end

g = Digraph.new

#POR PRECIO
# g.push_edge('A', 'B', '100')
# g.push_edge('B', 'Z', '100')
# g.push_edge('A', 'Z', '300')

g.push_edge("A", "B", "50")
g.push_edge("A", "B", "300")
g.push_edge("A", "C", "175")
g.push_edge("B", "C", "75")
g.push_edge("B", "Z", "250")
g.push_edge("C", "B", "50")
g.push_edge("C", "Z", "100")

#POR HORARIO
#el camino lo hace bien pero no calculo bien las horas
#no se puede usar la diferencia entre el horario de llegada y de salida
# se debería tomar la primera hora de A=>B (si son 2 cual se toma?)
#y la ultima hora de B=>Z
# g.push_edge("A", "B", "1")
# g.push_edge("A", "B", "1")
# g.push_edge("A", "C", "1.5")
# g.push_edge("B", "C", "1")
# g.push_edge("B", "Z", "1.5")
# g.push_edge("C", "B", "1")
# g.push_edge("C", "Z", "3")
# Path ["A", "B", "Z"]

# g.push_edge('A', 'B', '1')
# g.push_edge('B', 'Z', '2')
# g.push_edge('A', 'Z', '2')
# Path ["A", "Z"]
puts g.shortest_path_between('A','Z')
