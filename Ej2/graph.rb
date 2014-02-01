require 'algorithms'

class Graph

    def initialize
        @vertices = {}
    end

    def add_vertex(name, edges)
        @vertices[name] = edges
    end

    def shortest_path(start, finish)
        infinite = 2 << 63
        distance = {}
        previous = {}
        blk = lambda { |x, y| (y <=> x) == 1 }
        nodes = Containers::PriorityQueue.new(&blk)

        #add all the vertex to nodes
        @vertices.each do | vertex, value |
            if vertex == start
                distance[vertex] = 0
                nodes.push(vertex,0)
            else
                distance[vertex] = infinite
                nodes.push(vertex,infinite)
            end

            previous[vertex] = nil
        end

        #start the search
        while nodes.size != 0
            smallest = nodes.pop

            if smallest == finish
                path = []
                while previous[smallest]
                    path.push(smallest)
                    smallest = previous[smallest]
                end
                path.push(start)
                return path
            end

            if distance[smallest] == infinite
                break
            end
            #find the neighbors
            @vertices[smallest].each do | neighbor, value |
                alt = distance[smallest] + @vertices[smallest][neighbor]
                if alt < distance[neighbor]
                    distance[neighbor] = alt
                    previous[neighbor] = smallest
                    nodes.push(neighbor, alt)
                end
            end
        end

        return distance.inspect

    end

    def to_s
        return @vertices.inspect
    end

end


g = Graph.new
#ejemplo
# g.add_vertex('A', {'B' => 7, 'C' => 8})
# g.add_vertex('B', {'A' => 7, 'F' => 2})
# g.add_vertex('C', {'A' => 8, 'F' => 6, 'G' => 4})
# g.add_vertex('D', {'F' => 8})
# g.add_vertex('E', {'H' => 1})
# g.add_vertex('F', {'B' => 2, 'C' => 6, 'D' => 8, 'G' => 9, 'H' => 3})
# g.add_vertex('G', {'C' => 4, 'F' => 9})
# g.add_vertex('H', {'E' => 1, 'F' => 3})
# puts g.shortest_path('A', 'H')

#ejemplo rubymdp mas barato
# g.add_vertex('A', {'B' => 100, 'Z' => 300})
# g.add_vertex('B', {'A' => 100 ,'Z' => 100})
# g.add_vertex('Z', {'A' => 300, 'B' => 100})
# puts g.shortest_path('A','Z')
# Z
# B
# A
# [Finished in 1.8s]

#ejemplo rubymdp mas rapido
# g.add_vertex('A', {'B' => 1, 'Z' => 2})
# g.add_vertex('B', {'A' => 1 ,'Z' => 2})
# g.add_vertex('Z', {'A' => 2, 'B' => 2})
# puts g.shortest_path('A','Z')
# Z
# A
# [Finished in 0.9s]