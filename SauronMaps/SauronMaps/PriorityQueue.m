//
//  PriorityQueue.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/23/21.
//

#import "PriorityQueue.h"
#import <Foundation/Foundation.h>
#import "Edge.h"

@interface PriorityQueue ()
@property (nonatomic, strong) NSMutableArray<Edge*>* queue;
@end

@implementation PriorityQueue

- (instancetype)init {
    if (self = [super init]) {
        _queue = [@[] mutableCopy];
    }
    return self;
}

- (instancetype)initWithCapacity:(int)capacity
{
    if (self = [super init]) {
        _queue = [NSMutableArray arrayWithCapacity:capacity];
    }
    return self;
}

- (BOOL)isEmpty
{
    return [self size] == 0 ;
}

- (NSUInteger)size
{
    return [self.queue count];
}


//- (void)add:(id<NSObject>)object
//{
//    [self insert:object];
//}


- (Edge *)peek //returns min
{
    return [self.queue lastObject];
}

- (Edge *)poll
{
    Edge * object = [self peek];
    [self.queue removeObject:object];
    return object;
}

- (NSArray*)toArray //will be useful for drawing later
{
    return self.queue.copy;
}

- (void)remove:(Edge *)object
{
    [self.queue removeObject:object];
}

- (void)insert:(Edge *)object
{
    if (self.size == 0) {
        [self.queue addObject:object];
        return;
    }
    
    NSUInteger mid = 0;
    NSUInteger min = 0;
    NSUInteger max = self.queue.count - 1;
    BOOL found = NO;
    
    while (min <= max) {
        
        mid = (min + max) / 2;
        
        //NSComparisonResult result = self.comparator(object, self.queue[mid]);
        
        if (object.weight == self.queue[mid].weight) { //if obj = mid
            mid++;
            found = YES;
            break;
        } else if (object.weight > self.queue[mid].weight) { //if obj > mid
            max = mid - 1;
            if (max == NSUIntegerMax) {
                found = YES;
                break;
            }
        } else if (object.weight < self.queue[mid].weight) { //if obj < mid
            min = mid + 1;
        }
    }
    
    if (found) {
        // Index found at mid
        [self.queue insertObject:object atIndex:mid];
    } else {
        // Index not found, use min
        [self.queue insertObject:object atIndex:min];
    }
}

@end
