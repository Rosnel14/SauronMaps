//
//  Graph.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import <Foundation/Foundation.h>
#import "Graph.h"

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
        
        
        
    }
}

//parse edges and add to structure
-(void)parseEdgeData:(NSArray *)contents{
    
}

//seperate strings based on ";" seperator
-(NSString *)parseEdgeData:(NSArray *)contents{
    
}

@end
