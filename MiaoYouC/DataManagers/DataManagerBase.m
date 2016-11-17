//
//  DataManagerBase.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/12/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "DataManagerBase.h"

@implementation DataManagerBase

@synthesize updateInterval, updateTimer, updatePauseCount;

- (NSString *) getManagerName
{
    return NSStringFromClass([self class]);
}
- (BOOL) isPaused {
    return updatePauseCount > 0;
}

- (void) startUpdate
{
    /*
     updatePauseCount = 0;
     NSInteger intervalSecs;
     if (updateInterval > 0)
     intervalSecs = updateInterval;
     else
     intervalSecs = appConfigInstance.fetchMarketDataInterval;
     // Perform first update before start timer
     [self performFirstUpdate];
     // Start timer
     INTTimer *intTimer = [INTTimer initWithRealTarget:self];
     intTimer.selectorName = @"onTick";
     
     updateTimer = [NSTimer scheduledTimerWithTimeInterval:intervalSecs
     target:intTimer
     selector:@selector(timerFired)
     userInfo:nil
     repeats:YES];
     */
}

- (void) stopUpdate
{
    if (self.updateTimer) {
        [updateTimer invalidate];
        updateTimer = nil;
    }
    updatePauseCount = 0;
}

- (void) pauseUpdate
{
    updatePauseCount++;
}

- (void) resumeUpdate
{
    updatePauseCount--;
    if (updatePauseCount < 0)
        updatePauseCount = 0;
}

- (void) onTick
{
    if ([self isPaused])
        return;
    
    if ([self canUpdate]){
        //DLog(@"performUpdate current time %@",[NSDate date]);
        [self performUpdate];
    }
    
}

- (BOOL) canUpdate
{
    // Run update if loggedon
    return false;
}

- (void) performUpdate
{
    //DLog(@"%@ performUpdate", [self class]);
}

- (void) performFirstUpdate
{
    if ([self canUpdate])
        [self performUpdate];
}

- (void) dealloc
{
    //NOTE: ensure the timer is stop
    [self stopUpdate];
}

- (void) clearData
{
    
}


@end
