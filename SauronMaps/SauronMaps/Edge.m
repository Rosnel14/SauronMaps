//
//  Edge.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import <Foundation/Foundation.h>
#import "Edge.h"

@implementation Edge

-(instancetype)initWithParameters:(NSString *)vertexOne nextVertex:(NSString *)vertexTwo weight:(int)Weight{
    if(self){
        self = [super init];
        self.startVertex = vertexOne;
        self.endVertex = vertexTwo;
        self.weight =Weight;
    }
    return self;
}

@end
