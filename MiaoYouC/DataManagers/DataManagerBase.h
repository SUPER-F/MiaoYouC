//
//  DataManagerBase.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/12/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManagerBase : NSObject

@property (nonatomic, assign) NSInteger updateInterval;
@property (nonatomic, strong, readonly) NSTimer *updateTimer;
@property (nonatomic, assign, readonly) NSInteger updatePauseCount;

- (NSString *) getManagerName;

- (void) startUpdate;
- (void) stopUpdate;
- (void) pauseUpdate;
- (void) resumeUpdate;
- (BOOL) isPaused;

- (BOOL) canUpdate;

- (void) performUpdate;
- (void) performFirstUpdate;

- (void) clearData;

@end
