#ifndef AP_H2_DIJKSTRA_H_
#define AP_H2_DIJKSTRA_H_

#include <vector>
#include <functional>

#include "graph.h"
#include "priority_queue.h"

using namespace std;

// V = Vertex, E = Edge
template < class V, class E>
// Implementation of Dijkstra algorithm as a "Service" class
class Dijkstra {
private:
    Graph<V,E>& _graph;
    PriorityQueue<V, std::vector<V>, std::less<V> > _priorityq;

    // black = discovered Vertex, white = undiscovered Vertex, weigh = Edge's weight
    void relax(V& black,V& white, double weight){
        int candidateDist = black.getDistance() + weight;
        if ( candidateDist  < white.getDistance() ||  white.isAtInfiniteDistance() ) {
            white.setAsDiscovered(candidateDist, black.getNode());
        }
    }
public:
    // Initialize algorithm with g Graph
    Dijkstra(Graph<V,E>& g):_graph(g),_priorityq(){
    }
    // Dijkstra algorith implementation
    // Cormen & Co - Introduction to Algorithms - 3rd ed
    // DIJKSTRA( G, w, s)
    // 1 INITIALIZE-SINGLE-SOURCE(G, s)
    // 2 S = 0
    // 3 Q=G.V
    // 4 while Q != 0
    // 5   u = EXTRACT-MIN(Q)
    // 6   S = S +u
    // 7   for each vertex v-> G.Adj(u)
    // 8     RELAX(u,v,w)
    // Execute the algorithm
    // Default starting node = 0 (Initial Nod)
    void run(int s_id=0){
        // 1. INITIALIZE-SINGLE-SOURCE(G, s) - Done
        // 2. S=0 - Not necesary
        // 3. Q=G.V
        V& s  = _graph.getNodeValue(s_id);
        s.setAsStartNode();
        _priorityq.addValue(s);
        // 4. while Q != 0
        while( ! _priorityq.isEmpty() ){
            //5. u = EXTRACT-MIN(Q)
            V min = _priorityq.getMin();
            //6.S = S +u  - I don't keep a close set
            //7   for each vertex v-> G.Adj(u)
            vector<E> adj = _graph.getAdjacentEdgeList(min.getNode());
            for(typename vector<E>::iterator it = adj.begin(); it != adj.end(); ++it){
                //8     RELAX(u,v,w)
                V& node_x  = _graph.getNodeValue(it->getNodeX());
                V& node_y  = _graph.getNodeValue(it->getNodeY());
                if ( node_x.isBlack() ) {
                    // It is rather an assert condition. Should be allways black
                    if ( ! node_y.isBlack() ) {
                        relax(node_x,node_y,it->getWeight());
                        _priorityq.addValue(node_y);
                    }
                } else {
                    // It is rather an assert condition. Should be allways black
                    if ( node_y.isBlack() ) {
                        relax(node_y,node_x,it->getWeight());
                        _priorityq.addValue(node_x);
                    }
                }
            }
        }
    }
};
#endif // AP_H2_DIJKSTRA_H_
