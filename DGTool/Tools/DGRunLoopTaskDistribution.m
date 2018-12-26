//
//  DGRunLoopTaskDistribution.m
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGRunLoopTaskDistribution.h"
#import <objc/runtime.h>

@interface DGRunLoopTaskDistribution ()

@property (nonatomic, strong) NSMutableArray *tasks;

@property (nonatomic, strong) NSMutableArray *tasksKeys;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DGRunLoopTaskDistribution

#pragma mark - life cirle
static DGRunLoopTaskDistribution *_singleton = nil;

+ (instancetype)sharedTaskDistribution {
    if (!_singleton) {
        _singleton = [[self alloc] init];
    }
    return _singleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _maxTaskCount = 20;
        _tasks = [NSMutableArray array];
        _tasksKeys = [NSMutableArray array];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _singleton  = [super allocWithZone:zone];
    });
    return _singleton;
}


#pragma mark - task
- (void)removeAllTasks {
    [self.tasks removeAllObjects];
    [self.tasksKeys removeAllObjects];
}

- (void)addTask:(DGRunLoopTaskDistributionBlock)unit withKey:(id)key{
    [self.tasks addObject:unit];
    [self.tasksKeys addObject:key];
    if (self.tasks.count > self.maxTaskCount) {
        [self.tasks removeObjectAtIndex:0];
        [self.tasksKeys removeObjectAtIndex:0];
    }
}


#pragma mark - runloop
-(void)timerMethod:(NSTimer *)timer {
    //什么也不写, 仅仅用来保持runloop
}


/** 注册RunloopObserver */
+ (void)registerRunloopTaskDistributionAsMainRunloopObserver:(DGRunLoopTaskDistribution *)runloopTaskDistribution {
    
    static CFRunLoopObserverRef observer;
    registerObserver(kCFRunLoopBeforeWaiting, observer, NSIntegerMax-999 , kCFRunLoopDefaultMode, (__bridge void *)(runloopTaskDistribution), &defaultModeRunloopObserverCallBack);
}

/** C语言:注册RunloopObserver */
static void registerObserver(CFOptionFlags activities, CFRunLoopObserverRef observer, CFIndex order, CFStringRef mode, void *info, CFRunLoopObserverCallBack callback){
    
    //1.获取当前
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //2.创建context结构体
    CFRunLoopObserverContext context = {
        0,          //CFIndex version;
        info,       //void *info;
        &CFRetain,  //const void *(*retain)(const void *info);
        &CFRelease, //void (*release)(const void *info);
        NULL //CFStringRef (*copyDescription)(const void *info);
    };
    
    //3.创建observer
    observer = CFRunLoopObserverCreate(NULL, activities, YES, order, callback, &context);
    
    //4.添加Observer
    CFRunLoopAddObserver(runloop, observer, mode);
    
    //5.release操作
    CFRelease(observer);
}

/** 注册的defaultMode环境下的callBack */
static void defaultModeRunloopObserverCallBack (CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    runloopTaskDistributionCallBack(observer, activity, info);
}

/** 具体执行的callBack */
static void runloopTaskDistributionCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    
    DGRunLoopTaskDistribution *runloopTaskDistribution = (__bridge DGRunLoopTaskDistribution *)info;
    
    if (runloopTaskDistribution.tasks.count < 1) {
        return;
    }
    
    BOOL result = NO;
    while (result == NO && runloopTaskDistribution.tasks.count) {
        DGRunLoopTaskDistributionBlock block = runloopTaskDistribution.tasks.firstObject;
        result = block();
        [runloopTaskDistribution.tasks removeObjectAtIndex:0];
        [runloopTaskDistribution.tasksKeys removeObjectAtIndex:0];
    }
}

@end



#pragma mark - cell
@implementation UITableViewCell (DWURunLoopWorkDistribution)

- (NSIndexPath *)currentRunloopIndexPath {
    NSIndexPath *indexPath = objc_getAssociatedObject(self, @selector(currentRunloopIndexPath));
    return indexPath;
}

- (void)setCurrentRunloopIndexPath:(NSIndexPath *)currentRunloopIndexPath{
    objc_setAssociatedObject(self, @selector(currentRunloopIndexPath), currentRunloopIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
