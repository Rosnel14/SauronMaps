//
//  Graph.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import <Foundation/Foundation.h>
#import "Graph.h"
#import "Vertex.h"
#import "Edge.h"
#import "Path.h"
#import "PriorityQueue.h"

@implementation Graph

-(instancetype)init{
    if(self){
        self = [super init];
        self.edgeList = [[NSMutableArray alloc] init];
        self.vertexList = [[NSMutableArray alloc] init];
        VERTICES_COUNT = 14;
        EDGES_COUNT = 19;
    }
    return self;
}

//encode the file into a graph data-structure 
-(void)constructFromFile{
    NSArray * fileContents = [self readFile]; //read file
    
    [self parseVertexData:fileContents]; //store verticess
    [self parseEdgeData:fileContents]; //store edges
    

}

//read in file
-(NSArray *)readFile{
    NSString *myfilePath = [[NSBundle mainBundle] pathForResource:@"map-middleearth" ofType:@"txt"];

    NSString *linesFromFile = [[NSString alloc] initWithContentsOfFile:myfilePath encoding:NSUTF8StringEncoding error:nil];

    NSArray* rawGraph = [linesFromFile componentsSeparatedByString:@"\n"];
    
    return rawGraph;
}

//parse vertex and add to structure
-(void)parseVertexData:(NSArray *)contents{
    int count = 0;
    
    //until we break past the vertices section and we don't go out of bounds
    while (![[contents objectAtIndex:count] isEqualToString:@"EDGES"] && count <= [contents count]) {
        
        //ignore the vertice label and increment
        if([[contents objectAtIndex:count] isEqualToString:@"VERTICES"]) {
            count++;
            continue;
        }
        
        //store the vertices and increment
        
        //index 0 is always name, index 1 is x coord, index 2 is y cord
        NSArray * tempVertexProperties = [[contents objectAtIndex:count] componentsSeparatedByString:@";"];
        
        NSString * name = tempVertexProperties[0]; //name
        int xCord = [tempVertexProperties[1]intValue]; //xCord
        int yCord = [tempVertexProperties[2]intValue]; //yCord
        
        //contructs new vertex to be inserted
        Vertex * tempVertex = [[Vertex alloc] initWithParameters:name xCoordinate:xCord yCoordinate:yCord];
        
        //add to vertex list
        [self.vertexList addObject:tempVertex];
        
        count++;
    }
}

//parse edges and add to structure
-(void)parseEdgeData:(NSArray *)contents{
    int count = 0;
    
    //until we break past the edge section and we don't go out of bounds
    while (![[contents objectAtIndex:count] isEqualToString:@""] && count <= [contents count]) {
        
        //ignore the vertice label and increment (past the vertices section)
        if([[contents objectAtIndex:count] isEqualToString:@"VERTICES"]) {
            count += VERTICES_COUNT+1;//eh, bit lazy but works 
            continue;
        }
        
        //ignore the edges label and increment to actual edge objects
        if([[contents objectAtIndex:count] isEqualToString:@"EDGES"]) {
            count++;
            continue;
        }
        
        //store the edges and increment (below)
        
        //index 0 is always firstVertex, index 1 is secondVertex, index 2 is weight
        NSArray * tempEdgeProperties = [[contents objectAtIndex:count] componentsSeparatedByString:@";"];
        
        NSString * firstVertex = tempEdgeProperties[0]; //firstVertex
        NSString * secondVertex = tempEdgeProperties[1]; //secondVertex
        int weight = [tempEdgeProperties[2]intValue]; //weight
        
        //contructs new edge to be inserted
        Edge * tempEdge = [[Edge alloc] initWithParameters:firstVertex nextVertex:secondVertex weight:weight];
        
        //add to vertex list
        [self.edgeList addObject:tempEdge];
        count++;
    }
}

//dijkstra's algorithim,
-(NSMutableArray *)shortestPath:(Vertex *)src{
    
    //creating a pq to store path being preprocessed
    PriorityQueue * priorityQ = [[PriorityQueue alloc] init];

    //path cost array, from src vertex to other vertex
    NSMutableArray<Path *> * pathCostArray = [self initalizePathCostArr];
    
    //make path from src to src INFTY, because that doesn't make sense
    pathCostArray = [self initalizePCArr:pathCostArray vertex:src];
    
    //add all adjacent nodes from the src into PQ (satisfy loop condition)
    priorityQ = [self addAllAdjacentVertices:priorityQ vertex:src];
    
    //initalize Unvisited array
    NSMutableArray * unvisitedVertices = [[NSMutableArray alloc] init];
    
    for(int i =0; i<VERTICES_COUNT; i++){
        [unvisitedVertices addObject:[self.vertexList objectAtIndex:i].name];
    }
    
    
    //while priority queue is not empty, i.e. all paths have not been found or we're not done
    while ([priorityQ isEmpty] == false) {
        
        
        Edge * MinimumEdge = [priorityQ poll];
        
        //go through path cost array, update if path from previous to src is now less than initially instantiated
        //NSLog(@"%i",[pathCostArray count]);
        for(int i=0; i < [pathCostArray count]; i++){
            //NSLog(@"%@",[pathCostArray objectAtIndex:i]);
            if([[pathCostArray objectAtIndex:i].sourceV isEqualToString:MinimumEdge.startVertex]){
                
                //check if weight is less than the current short path from previous vertex
                //NSLog(@"%i",i);
                if(MinimumEdge.weight < [pathCostArray objectAtIndex:i].weight){
                    Path * newPath = [[Path alloc] initWithParameters:MinimumEdge.startVertex parent:MinimumEdge.endVertex weight:MinimumEdge.weight];
                    
                    [pathCostArray replaceObjectAtIndex:i withObject:newPath]; //replace with the newest smallest distance
                    
                    //remove sourceV from unvisited array
                    [unvisitedVertices removeObject:[pathCostArray objectAtIndex:i].sourceV];
                    
                    //make endpoint(of min) the new src
                    
                    for (int i=0; i<VERTICES_COUNT; i++){
                        if([[self.vertexList objectAtIndex:i].name isEqualToString:MinimumEdge.endVertex]){
                            src = [self.vertexList objectAtIndex:i];
                            priorityQ = [self addAllAdjacentVertices:priorityQ vertex:src];
                            break;
                        }
                    }
                
                    break;

                    
                }
                else { //if it is not less than current shortest path from prev, remove from queue

                    [priorityQ remove:MinimumEdge]; //remove from pq
                    break;
                }
            }
        }
    }
    
    pathCostArray = [self fillPathCostTable:pathCostArray UnvisitedList:unvisitedVertices];//make unvisited list
    return pathCostArray;
}

//there will be paths that are not considered by this algorithim,
//to account for that the unvisted source vertices must be acounted for
-(NSMutableArray *)fillPathCostTable:(NSMutableArray *)currentPathCostArray UnvisitedList:(NSMutableArray<NSString*>*)unvisitedVertices{
   
    //path cost array init
    NSMutableArray<Path *>* newPathCostArray = [[NSMutableArray alloc] init];
    newPathCostArray = currentPathCostArray;
    
    int count = 0; //lazy incrementing
    
    //get the first src vertex
    Vertex * src = [[Vertex alloc] init];
    
    //priority queue init
    PriorityQueue * PQ = [[PriorityQueue alloc] init];
    
    //init src
    for(int i=0;i<VERTICES_COUNT;i++){
        if([[self.vertexList objectAtIndex:i].name isEqualToString:[unvisitedVertices firstObject]]){
            src = [self.vertexList objectAtIndex:i];
            break;
        }
        
}
    while ([unvisitedVertices count] != 0 && count < VERTICES_COUNT) { //while not empty
        
       //add all adjacent nodes
        [self addAllAdjacentVertices:PQ vertex:src];
        
        
        //get minimum path
        Edge * MinimumEdge = [PQ poll];
        
        //if less than current weight update path cost array
        //else remove from pq
        if([[newPathCostArray objectAtIndex:count].sourceV isEqualToString:MinimumEdge.startVertex]){
            if(MinimumEdge.weight < [newPathCostArray objectAtIndex:count].weight){
            
                Path * newPath = [[Path alloc] initWithParameters:MinimumEdge.startVertex parent:MinimumEdge.endVertex weight:MinimumEdge.weight];
                
                [newPathCostArray replaceObjectAtIndex:count withObject:newPath]; //replace with the newest smallest distance
            } else {
            [PQ remove:MinimumEdge];
            count++;
        }
        }else{
            count++;
            continue;
        }
        
        //remove src from univisited list
        [unvisitedVertices removeObject:[unvisitedVertices firstObject]];
        
        //make src next vertex on unvisited list
        for(int i=0;i<VERTICES_COUNT;i++){
            if([[self.vertexList objectAtIndex:i].name isEqualToString: [unvisitedVertices firstObject]]){
                src = [self.vertexList objectAtIndex:i];
                break;
            }
        }
        //count++;
}
    return newPathCostArray;
}


//make it so that the inital costs of paths will be infty, so that way any intial comparison will work as desired
-(NSMutableArray *)initalizePCArr:(NSMutableArray<Path *> *)pathCostArray vertex:(Vertex *)src{
    for(int i=0; i< [pathCostArray count]-1; i++){
        if([[pathCostArray objectAtIndex:i].sourceV isEqualToString:src.name]){
            Path * tempPath = [[Path alloc]initWithSource:[self.vertexList objectAtIndex:i].name]; //won't get smaller than that
            [pathCostArray replaceObjectAtIndex:i withObject:tempPath];
            break; //worst case n time, but hopefully won't get that bad
        }
    }
    
    return pathCostArray;
}

-(PriorityQueue *)addAllAdjacentVertices:(PriorityQueue *)currentStatePQ vertex:(Vertex*)src{
    for(int i=0; i<EDGES_COUNT; i++){
        if([[self.edgeList objectAtIndex:i].startVertex isEqualToString:src.name]){
            [currentStatePQ insert:[self.edgeList objectAtIndex:i]];
        }
    }
    return currentStatePQ;
}


//to be used in dijkstra's algorithim
-(NSMutableArray *)initalizePathCostArr{
    NSMutableArray * pathCostArr = [[NSMutableArray alloc] init];
    for(int i = 0; i< VERTICES_COUNT; i++){
        Path * tempPath = [[Path alloc] initWithSource:[self.vertexList objectAtIndex:i].name];
        [pathCostArr addObject:tempPath];
    }
    return pathCostArr;
}

//debugging pq (might be useufl later)
//-(NSArray *)testPQ{
//    PriorityQueue * myPQ = [[PriorityQueue alloc] init];
//
//    Edge * tempEdge1 = [self.edgeList objectAtIndex:0];
//    Edge * tempEdge2 = [self.edgeList objectAtIndex:1];
//
//    [myPQ insert:tempEdge1];
//    [myPQ insert:tempEdge2];
//
//    NSArray * displayArr = [myPQ toArray];
//
//    return displayArr;
//}

@end
