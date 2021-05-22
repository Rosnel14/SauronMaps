//
//  Vertex.h
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#ifndef Vertex_h
#define Vertex_h

@interface Vertex : NSObject

@property NSString * name; //name in middle earth

@property int xCord; //x coordinate for the map

@property int yCord; //y coordinate for the map

//constructor
-(instancetype)initWithParameters:(NSString *)Name xCoordinate:(int)Xcoord yCoordinate:(int)Ycoord;



@end

#endif /* Vertex_h */
