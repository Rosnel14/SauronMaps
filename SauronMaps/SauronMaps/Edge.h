//
//  Edge.h
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#ifndef Edge_h
#define Edge_h

@interface Edge : NSObject

@property int startVertex; //index of the vertex list

@property int endVertex; //index of the vertex list 

@property int weight;

//constructor 
-(instancetype)initWithParameters:(int)vertexOne nextVertex:(int)vertexTwo weight:(int)Weight;

@end

#endif /* Edge_h */
