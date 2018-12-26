//
//  DGRunLoopTaskDistribution.h
//  DGTool
//
//  Created by david on 2018/10/9.
//  Copyright © 2018 david. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef BOOL(^DGRunLoopTaskDistributionBlock)(void);

//用于tableview的cell内容延迟加载, 用kCFRunLoopDefaultMode
@interface DGRunLoopTaskDistribution : NSObject

+ (instancetype)sharedTaskDistribution;

@property (nonatomic,assign) NSUInteger maxTaskCount;

- (void)addTask:(DGRunLoopTaskDistributionBlock)taskBlock withKey:(id<NSCopying>)key;

- (void)removeAllTasks;

@end




#pragma mark - cell
@interface UITableViewCell (DGRunLoopTaskDistribution)

@property (nonatomic, strong) NSIndexPath *currentRunloopIndexPath;

@end
