//
//  Path.h
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/23/21.
// to be used for djisktra's algorithim

#ifndef Path_h
#define Path_h


@interface Path: NSObject

@property NSString * sourceV;

@property NSString * previousV;

@property int weight;

-(instancetype)initWithParameters:(NSString *)sourceVertex parent:(NSString *)previousVertex weight:(int)weight; 

-(instancetype)initWithSource:(NSString *)sourceVertex; 
@end

#endif /* Path_h */
