#ifndef AP_H2_EDGE_MATRIX_H_
#define AP_H2_EDGE_MATRIX_H_

#include <vector>
#include <utility>

using namespace std;

template<class E>
// Store edges in a matrix structure
class EdgeMatrix{
private:
    vector<int> _matrix; //  Matrix represention. (x,y)-> x * vertix_nr + y
    vector<E> _edge;
    int _vertex_nr;
    int _edge_nr;

    enum {NO_EDGE, EDGE_EXISTS};

    // Return the index in Matrix for a pair ( x,y )
    // In an unidirected graph the matrix is symetric.
    int getIdx(int node_x, int node_y) const{
        if ( node_x < node_y )
            return node_x * _vertex_nr + node_y;
        return node_x + node_y * _vertex_nr;
    }

public:
    EdgeMatrix(int vertex_nr): _matrix(vertex_nr*vertex_nr), _edge(vertex_nr*vertex_nr),  _vertex_nr(vertex_nr),_edge_nr(0) {
    }

    int getEdgeNumber(){
        return _edge_nr;
    }
    // Add a new Edge. New value overwrite the old one.
    void addEdge(E e){
        int idx = getIdx(e.getNodeX(), e.getNodeY());
        if (NO_EDGE == _matrix.at(idx)){
            ++_edge_nr;
        }
        _matrix.at(idx)= EDGE_EXISTS;
        _edge.at(idx)= e;
    }

    // Return a list of adjacents edges for one node
    vector<E> getEdgeList(int node) const{
        vector<E> res;
        for(int i=0; i< _vertex_nr; ++i){
            int idx = getIdx(i, node);
            if (EDGE_EXISTS == _matrix.at(idx))
                res.push_back(_edge.at(idx));
        }
        return res;
    }
};

#endif // AP_H2_EDGE_MATRIX_H_
