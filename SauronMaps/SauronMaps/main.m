//
//  main.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Graph.h"
#import "Vertex.h"
#import "Edge.h"
#import "Path.h"
#import "PriorityQueue.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);

        Graph * myGraph = [[Graph alloc] init];
        [myGraph constructFromFile];

        Vertex * testVertexSrc = [myGraph.vertexList objectAtIndex:0];


        NSMutableArray<Path *> * allPaths = [[NSMutableArray alloc] init];

        allPaths = [myGraph shortestPath:testVertexSrc];

        for(int i=0; i<[allPaths count]-1; i++){
            NSLog(@"%@:%@:%i",[allPaths objectAtIndex:i].sourceV,[allPaths objectAtIndex:i].previousV,[allPaths objectAtIndex:i].weight);
        }

        

    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
