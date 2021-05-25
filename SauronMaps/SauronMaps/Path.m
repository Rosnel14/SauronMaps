//
//  Path.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/23/21.
//

#import <Foundation/Foundation.h>
#import "Path.h"

@implementation Path

-(instancetype)initWithParameters:(NSString *)sourceVertex parent:(NSString *)previousVertex weight:(int)weight{
    if(self){
        self = [super init];
        self.sourceV = sourceVertex;
        self.previousV = previousVertex;
        self.weight = weight;
    }
    return self;
}

-(instancetype)initWithSource:(NSString *)sourceVertex{
    if(self){
        self = [super init];
        self.sourceV = sourceVertex;
        self.previousV = nil;
        self.weight = INFINITY; 
    }
    return self;
}

@end
