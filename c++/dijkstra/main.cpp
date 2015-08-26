
#include <cstdlib> //srand
#include <ctime> //clock
#include <iostream>

#include "vertex.h"
#include "edge.h"
#include "graph.h"
#include "dijkstra.h"

using namespace std;
// Some kind of unit test, used during development
void test(){
    const int N = 5;
    Graph<Vertex,Edge> g(N);

    // Cormen sample : s = 0, f =1, x = 2, y = 3, z = 4
    g.addEdge(Edge(0,1,10.));
    g.addEdge(Edge(0,3,5.));

    g.addEdge(Edge(1,2,1.));
    g.addEdge(Edge(1,3,3));

    g.addEdge(Edge(2,3,9));
    g.addEdge(Edge(2,4,4));

    g.addEdge(Edge(3,4,2));

    Dijkstra<Vertex,Edge> dj(g);
    dj.run(0);
    cout << "Graph after " << endl << g << endl;
}
// return a random nr from (min, max) interval
int get_random_nr(int min, int max){
    return min + rand()%(max-min==0?1:max-min);
}
// Run Dijkstra with some random data
void run_monte_carlo_graph(int vertices_nr, double edge_density, int dist_min, int dist_max){
    Graph<Vertex,Edge> g(vertices_nr);
    int edge_nr = vertices_nr * vertices_nr * edge_density;
    while( g.getEdgeNumber() < edge_nr ) {
        int node_x = get_random_nr(0,vertices_nr);
        int node_y = get_random_nr(0,vertices_nr);
        double dist = static_cast<double> ( get_random_nr(dist_min, dist_max) );
        g.addEdge(Edge(node_x, node_y, dist));
    }
    Dijkstra<Vertex,Edge> dj(g);
    dj.run(); // Run starting with node with id = 0
    cout << "Avg dist:" << g.getAvgDistance() << endl;

}
// Run algorithm for a number of times
void run_simulation() {
    const int nr_run = 10;
    cout << " First set : Verices,Edge Density, Dist Min, Dist Max: (50, 0.2, 1, 10) " << endl;
    for(int i=0; i < nr_run; ++i){
        run_monte_carlo_graph(50, 0.2, 1, 10 );
    }
    cout << " First set : Verices,Edge Density, Dist Min, Dist Max: (50, 0.4, 1, 10) " << endl;
    for(int i=0; i < nr_run; ++i){
        run_monte_carlo_graph(50, 0.4, 1, 10 );
    }
}
// Main program
int main() {
//    test();
    srand(clock()); // Initialize random nr generator
    run_simulation();
    return 0;
}
