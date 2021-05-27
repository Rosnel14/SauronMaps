//
//  GameScene.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import "GameScene.h"
#import "Graph.h"
#import "Vertex.h"
#import "Edge.h"
#import "Path.h"
#import "PriorityQueue.h"

@implementation GameScene {
    Graph * gameGraph;
    NSMutableArray<Path *> * pathCostTable;
    int VERTEX_RADIUS;
    int storedValueFontSize;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    [self setBackgroundColor:[UIColor blackColor]];
    
    //show map
    SKSpriteNode * map =[SKSpriteNode spriteNodeWithImageNamed:@"Image"];
    [map setSize:CGSizeMake(653, 398)];
    [self addChild:map];
    
    //init instance variables
    VERTEX_RADIUS = 16;
    storedValueFontSize = 12;
    
    // init data structures
            gameGraph = [[Graph alloc] init];
            [gameGraph constructFromFile];
    
            Vertex * testVertexSrc = [gameGraph.vertexList objectAtIndex:0];
    
            pathCostTable = [gameGraph shortestPath:testVertexSrc];

    //draw vertices
    [self drawVertices];
    //draw paths
    [self drawPaths];
}

-(void)drawVertices{
    for (int i=0; i<14; i++) {
        SKShapeNode * tempVertex = [SKShapeNode shapeNodeWithCircleOfRadius:VERTEX_RADIUS];
        [tempVertex setFillColor:[UIColor redColor]];
        SKLabelNode *nodeStoredValue = [SKLabelNode labelNodeWithFontNamed:@"Arial"];nodeStoredValue.text = [gameGraph.vertexList objectAtIndex:i].name;nodeStoredValue.fontSize = storedValueFontSize;
        [nodeStoredValue setColor:[UIColor blackColor]];
        [tempVertex setPosition:(CGPointMake([gameGraph.vertexList objectAtIndex:i].yCord, 300-[gameGraph.vertexList objectAtIndex:i].xCord))];
        [nodeStoredValue setPosition:CGPointMake([gameGraph.vertexList objectAtIndex:i].yCord, 300-[gameGraph.vertexList objectAtIndex:i].xCord)];
        [self addChild:tempVertex];
        [self addChild:nodeStoredValue];
    }
}

-(void)drawPaths{
    for(int i =0; i<17;i++){
    Edge * tempEdge = [[Edge alloc] init];
    tempEdge = [gameGraph.edgeList objectAtIndex:i];
        SKLabelNode *weightValue = [SKLabelNode labelNodeWithFontNamed:@"Arial"];weightValue.text = [NSString stringWithFormat:@"%i",tempEdge.weight];weightValue.fontSize = storedValueFontSize;
        [weightValue setPosition:CGPointMake(([self getVertexYcord:tempEdge.startVertex] + [self getVertexYcord:tempEdge.endVertex])/2, (300-[self getVertexXcord:tempEdge.startVertex] +300-[self getVertexXcord:tempEdge.endVertex])/2)];
    SKShapeNode *tempLine = [SKShapeNode node];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, [self getVertexYcord:tempEdge.startVertex], 300-[self getVertexXcord:tempEdge.startVertex]);
    CGPathAddLineToPoint(pathToDraw, NULL,[self getVertexYcord:tempEdge.endVertex], 300-[self getVertexXcord:tempEdge.endVertex]);
    tempLine.path = pathToDraw;
    [tempLine setStrokeColor:[SKColor blueColor]];
    [self addChild:tempLine];
    [self addChild:weightValue];
        
    }
}

-(Vertex *)getVertexObj:(NSString *)name{
    for(int i=0;i<13;i++){
        if([[gameGraph.vertexList objectAtIndex:i].name isEqualToString:name]){
            return [gameGraph.vertexList objectAtIndex:i];
            break;
        }
    }
    return nil;
}

//remember to flip declarations, coordinates are wrong
-(int)getVertexXcord:(NSString *)name{
    
    for(int i=0;i<13;i++){
        if([[gameGraph.vertexList objectAtIndex:i].name isEqualToString:name]){
            return [gameGraph.vertexList objectAtIndex:i].xCord;
            break;
        }
    }
    return -1;
}

//remember to flip declarations, coordinates are wrong
-(int)getVertexYcord:(NSString *)name{
    
    for(int i=0;i<13;i++){
        if([[gameGraph.vertexList objectAtIndex:i].name isEqualToString:name]){
            return [gameGraph.vertexList objectAtIndex:i].yCord;
            break;
        }
    }
    return -1;
}

//this will draw path from hobbiton to mount doom
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Vertex * src = [[Vertex alloc] init];
    src = [gameGraph.vertexList firstObject];
    NSMutableArray<NSString*> * pathToBeDrawn = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[pathCostTable count]-1;i++){
        if([src.name isEqualToString:[pathCostTable objectAtIndex:i].sourceV]){
            
            //add to path to be drawn
            [pathToBeDrawn addObject:[pathCostTable objectAtIndex:i].sourceV];
            [pathToBeDrawn addObject:[pathCostTable objectAtIndex:i].previousV];
            
            //make src the previousV
            src = [self getVertexObj:[pathCostTable objectAtIndex:i].previousV];
        }
    }
    pathToBeDrawn = [self removeDuplicates:pathToBeDrawn];
    [self drawShortestPath:pathToBeDrawn];
    
}

-(void)drawShortestPath:(NSMutableArray <NSString*>*)pathTobeDrawn{
    for (int i=0; i<[pathTobeDrawn count]-1; i++) {
        SKShapeNode * tempVertex = [SKShapeNode shapeNodeWithCircleOfRadius:VERTEX_RADIUS];
        [tempVertex setFillColor:[UIColor blueColor]];
        SKLabelNode *nodeStoredValue = [SKLabelNode labelNodeWithFontNamed:@"Arial"];nodeStoredValue.text = [pathTobeDrawn objectAtIndex:i];nodeStoredValue.fontSize = storedValueFontSize;
        [nodeStoredValue setColor:[UIColor blackColor]];
        [tempVertex setPosition:(CGPointMake([self getVertexYcord:[pathTobeDrawn objectAtIndex:i]], 300-[self getVertexXcord:[pathTobeDrawn objectAtIndex:i]]))];
        [nodeStoredValue setPosition:CGPointMake([self getVertexYcord:[pathTobeDrawn objectAtIndex:i]], 300-[self getVertexXcord:[pathTobeDrawn objectAtIndex:i]])];
        
        [self addChild:tempVertex];
        [self addChild:nodeStoredValue];
    }
    
    //should also print recipe (for mr.bakker to verify my paths are right!)
    for(int i=0; i<[pathTobeDrawn count];i++){
        NSLog(@"%@",[pathTobeDrawn objectAtIndex:i]);
    }
    
}

-(NSMutableArray *)removeDuplicates:(NSMutableArray<NSString *>*)array{
    for(int i=0;i<[array count]-1;i++){
        if([[array objectAtIndex:i] isEqualToString:[array objectAtIndex:i+1]]){
            
            [array removeObjectAtIndex:i];
        }
    }
    return array;
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
