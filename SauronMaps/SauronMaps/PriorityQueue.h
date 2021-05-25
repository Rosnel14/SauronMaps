//
//  PriorityQueue.h
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#ifndef PriorityQueue_h
#define PriorityQueue_h
#import "Edge.h"
#import <Foundation/Foundation.h>

@interface PriorityQueue : NSObject

-(instancetype)init;

- (instancetype)initWithCapacity:(int)capacity;


//return true if pq is empty, false if not
- (BOOL)isEmpty;

//returns the # of objects in the pq
- (NSUInteger)size;



//adds object to pq
- (void)insert:(Edge *)object;


//Gets but does not remove the head of the queue.

- (Edge *)peek;


//Gets and removes the head of the queue.
- (Edge *)poll;


//Creates and returns an NSArray from the contents of the queue.
- (NSArray*)toArray;

//removes item from queue
- (void)remove:(Edge *)object;

@end


#endif /* PriorityQueue_h */
