#ifndef AP_H2_PRIORITY_QUEUE_H_
#define AP_H2_PRIORITY_QUEUE_H_

#include <queue>          // std::priority_queue
#include <vector> 
#include <functional> // less, greater

using namespace std;

template <class T, class Container = vector<T>, class Compare = less<typename Container::value_type> >

// A helper class for Dijkstra algorithm.
// Implementation based on std::priority_queue
class PriorityQueue {
private:
    priority_queue<T, Container, Compare> _pq;
public:
    PriorityQueue(){
    }
    void addValue(T value){
        _pq.push(value);
    }
    bool isEmpty(){
        return _pq.empty();
    }
    T getMin() {
        T min = _pq.top();
        _pq.pop();
        return min;
    }
};
#endif // AP_H2_PRIORITY_QUEUE_H_
