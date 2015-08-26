#ifndef AP_H2_GRAPH_H_
#define AP_H2_GRAPH_H_

#include <vector>
#include <utility>
#include <iostream>

#include "edge_matrix.h"

using namespace std;

// V = Vertex, E = Edge
template <class V, class E>
// ADT for a Graph
class Graph {
private:
    int _vertex_nr;
    EdgeMatrix<E> _edge;
    //Vertices are represented as int and object.
    vector<V> _vertex;
    vector<int> _vertex_id;

public:

    Graph(int vertex_nr):_vertex_nr(vertex_nr), _edge(_vertex_nr), _vertex(_vertex_nr),   _vertex_id(_vertex_nr){
        for(int i=0; i < _vertex_nr; ++i){
            setNodeValue(Vertex(i));
        }
    }

    vector<E> getAdjacentEdgeList(int node){
        return _edge.getEdgeList(node);
    }

    void addEdge(E e){
        _edge.addEdge(e);
    }

    int getEdgeNumber(){
        return _edge.getEdgeNumber();
    }

    V& getNodeValue(int node){
        return _vertex.at(node);
    }

    void setNodeValue(V v){
        _vertex.at(v.getNode()) = v;
    }

    friend ostream& operator<< (ostream& os, const Graph<V,E>& g){
        g.print(os);
        return os;
    }
private:
    void print(ostream& os) const{
        for(int i = 0; i<_vertex_nr; ++i) {
            os << "Vertex at :" << i << _vertex[i] << " adj. vert. : (";
            vector<E> res = _edge.getEdgeList(i);
            for(typename vector<E>::const_iterator it = res.begin(); it != res.end(); ++it)
                cout << *it << " ";
            os << ")" << endl;
        }
    }
public:
    // Get the Average distance between nodes
    double getAvgDistance(){
        double all_routes = 0.;
        int nr_reached_node = 0;
        for(typename vector<V>::const_iterator it = _vertex.begin(); it != _vertex.end(); ++it) {
            if ( it->isBlack() ){
                all_routes += it->getDistance();
                ++nr_reached_node;
            }
        }
        double avg = all_routes / (nr_reached_node == 0 ? 1 : nr_reached_node );
        return avg;
    }

 };

#endif //AP_H2_GRAPH_H_
