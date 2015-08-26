#ifndef AP_H2_EDGE_H_
#define AP_H2_EDGE_H_

#include <iostream>

using namespace std;
// All the information regarding an Edge.
// At minimum we need : node_x, node_y and weight

const int INVALID_NODE = -1;
class Edge {
private:
    int _node_x;
    int _node_y;
    double _weight;
private:
    void print(ostream& os) const{
        os << "(" << _node_x << ":" << _node_y << "w:" << _weight << ")";
    }

public:
    Edge(int node_x=INVALID_NODE, int node_y=INVALID_NODE, double weight = 0.0):_node_x(node_x),_node_y(node_y),_weight(weight){
    }

// Accessors
    int getNodeX() const{
        return _node_x;
    }
    int getNodeY() const{
        return _node_y;
    }
    double getWeight() const {
        return _weight;
    }
    friend ostream& operator<<(ostream& os, const Edge& e) {
        e.print(os);
        return os;
    }

};

#endif // AP_H2_EDGE_H_
