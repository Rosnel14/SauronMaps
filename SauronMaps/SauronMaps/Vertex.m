//
//  Vertex.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@implementation Vertex

-(instancetype)initWithParameters:(NSString *)Name xCoordinate:(int)Xcoord yCoordinate:(int)Ycoord{
    if(self){
        self = [super init];
        self.name = Name;
        self.xCord = Xcoord;
        self.yCord = Ycoord;
    }
    return self;
}

@end
