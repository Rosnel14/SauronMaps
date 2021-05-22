//
//  main.m
//  SauronMaps
//
//  Created by Rosnel Leyva-Cortés on 5/20/21.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Graph.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        Graph * myGraph = [[Graph alloc] init];
        [myGraph constructFromFile];
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
