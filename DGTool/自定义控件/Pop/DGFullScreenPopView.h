//
//  DGFullScreenPopView.h
//  DGTool
//
//  Created by david on 2018/11/13.
//  Copyright © 2018 david. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGFullScreenPopView : UIView

/** 必传参数 */
@property (nonatomic,copy) NSArray *imageNameArr;
/** 必传参数 */
@property (nonatomic,copy) NSArray *titleArr;

-(void)showPopViewWithBlock:(void(^)(NSInteger index))block;

@end
