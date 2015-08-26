#ifndef AP_H2_VERTEX_H_
#define AP_H2_VERTEX_H_

#include <iostream>

using namespace std;

// This class represent a node in a graph
class Vertex {
private:
    // Instead of setter/getter, i just made them public
    int _node; // id
    double _distance;  // Distance from source to this node
    int _parent; // parent node, on the shortest path 

    enum Parent{ START = -1, UNREACHABLE = -2 };
    void print(ostream& os) const{
        os << " Node: " << _node << "(dist: " << _distance << " par: " << _parent << ")" ;
    }
public:
// node < 0 -> uninitialized
// distance < 0 -> infinity
    Vertex(int node = -1, double distance=-1., int parent=UNREACHABLE):_node(node),_distance(distance),_parent(parent) {
    }
    //Accessors
    int getNode() const {
        return _node;
    }
    int getParent() const {
        return _parent;
    }
    double getDistance() const {
        return _distance;
    }
    // It's discovered ?
    bool isBlack() const{
        if (_parent == UNREACHABLE )
            return false;
        return true;
    }
    
    bool isAtInfiniteDistance() const{
        if (_distance < 0 )
            return true;
        return false;
    }
    // Set the initial Starting Node
    void setAsStartNode() {
        _distance = 0;
        _parent = START;
    }
    // Called when a new shorter path is discovered
    // Set new value for distance and parent.
    void setAsDiscovered(double distance, int parent){
        _distance = distance;
        _parent = parent;
    }
    //  std::less<V> point to this operator
    bool operator< (const Vertex& than) const{
        return _distance < than.getDistance();
    }
    friend ostream& operator<<(ostream& os, const Vertex& v) {
        v.print(os);
        return os;
    }
};

#endif // AP_H2_VERTEX_H_
