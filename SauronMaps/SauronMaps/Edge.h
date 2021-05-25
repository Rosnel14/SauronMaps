//
//  Edge.h
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#ifndef Edge_h
#define Edge_h
#import <Foundation/Foundation.h>

@interface Edge: NSObject

@property NSString * startVertex; //index of the vertex list

@property NSString * endVertex; //index of the vertex list 

@property int weight;

//constructor 
-(instancetype)initWithParameters:(NSString *)vertexOne nextVertex:(NSString *)vertexTwo weight:(int)Weight;

@end

#endif /* Edge_h */
