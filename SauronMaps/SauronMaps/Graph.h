//
//  Graph.h
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#ifndef Graph_h
#define Graph_h

@interface Graph : NSObject{
     int VERTICES_COUNT; //modify here, specifc to middle earth
     int EDGES_COUNT; //modify here, specifc to middle earth
}

@property NSMutableArray * vertexList; //store indexed names of vertice

@property NSMutableArray * edgeList; //store an edge object

//constructor
-(instancetype)init;

//reads the middle earth file and then constructs a graph based on its data 
-(void)constructFromFile;

@end

#endif /* Graph_h */
