//
//  DGAlertController.m
//  DGTool
//
//  Created by david on 2018/10/29.
//  Copyright © 2018 david. All rights reserved.
//

#import "DGAlertController.h"
#import "DGButton.h"

@interface DGAlertController (){
    CGSize _displayViewCornerRadii;
    CGFloat _btnHeight;
    CGFloat _garBarHeight;
    CGFloat _cancelGrayBarHeight;
    CGFloat _fontSize;
}

@property (nonatomic,copy) NSString *ppTitle;
@property (nonatomic,copy) NSString *ppMsg;
@property (nonatomic,assign) DGAlertControllerStyle style;
@property (nonatomic,copy) NSArray <DGAlertAction *>*ppActions;

@property (nonatomic,weak) UIView *displayView;

@end

@implementation DGAlertController


#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDimension];
    [self setupUI];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.style == DGAlertControllerStyleActionSheet) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.displayView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:_displayViewCornerRadii];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = self.displayView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.displayView.layer.mask = maskLayer;
    }
}

#pragma mark - init
- (instancetype)initWithStyle:(DGAlertControllerStyle)style ppActions:(NSArray <DGAlertAction *>*)ppActions {
    return [self initWithTitle:nil message:nil style:style ppActions:ppActions];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(DGAlertControllerStyle)style ppActions:(NSArray <DGAlertAction *>* _Nonnull)ppActions {
    self = [super init];
    if (self) {
        self.touchDismissEnabled = YES;
        self.ppTitle = title;
        self.ppMsg = message;
        self.style = style;
        self.ppActions = ppActions;
//        self.definesPresentationContext = YES;
//        self.providesPresentationContextTransitionStyle = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;//UIModalPresentationOverFullScreen不会使vc的preferredStatusBarStyle方法被调用,因为它是被app的rootvc推出present的
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

#pragma mark - statusBar
-(UIStatusBarStyle)preferredStatusBarStyle {
    
    UIViewController *presentingVC;
    if ([self.presentingViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)self.presentingViewController;
       presentingVC = navi.topViewController;
    }else{
        presentingVC = self.presentingViewController;
    }
    
    if (presentingVC == self) {
        return UIStatusBarStyleDefault;
    }
    return presentingVC.preferredStatusBarStyle;
}

#pragma mark - UI
/** 常用尺寸变量 */
- (void)setDimension{
    _displayViewCornerRadii = CGSizeMake(8, 8);
    _btnHeight = 47;
    _cancelGrayBarHeight = 10;
    _garBarHeight = 1;
    _fontSize = 15;
}

/** 设置UI */
- (void)setupUI {
    self.view.backgroundColor = RGBA(0, 0, 0, 0.65);
    
    if(self.style == DGAlertControllerStyleActionSheet){
        [self setupActionSheet];
        return ;
    }
}

/** 设置ActionSheet */
- (void)setupActionSheet {
    //1.actionSheetV
    UIView *actionSheetV = [[UIView alloc]init];
    self.displayView = actionSheetV;
    actionSheetV.backgroundColor = RGB(241, 241, 241);
    actionSheetV.alpha = 1.0;
    
    [self.view addSubview:actionSheetV];
    [actionSheetV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(100+HOME_INDICATOR_H).with.priorityLow();
    }];
    
    //2.actionBtns
   DGButton *topBtn = [self setupActionSheetButtons];
    
    //3.title
    if (self.ppTitle.length > 0) {
        
    }
    
    //4.msg
    if (self.ppMsg.length > 0) {
        
    }
}

/** 设置actionSheet的buttons */
- (DGButton *)setupActionSheetButtons {
    
    WeakS(weakSelf);
    DGButton *topBtn;
    CGFloat btnH = _btnHeight;
    CGFloat garBarH = _garBarHeight;
    CGFloat cancelGrayBarH = _cancelGrayBarHeight;
    
    //0.创建actions的可变数组
    NSMutableArray *mutActions = [NSMutableArray arrayWithArray:self.ppActions];
    //1.cancelBtn
    for (DGAlertAction *action in mutActions) {
        if (action.style == DGAlertActionStyleCancel) {
            //1.1添加cancelBtn
            topBtn = [self btnWithTitle:action.title];
            [topBtn addClickBlock:^(DGButton *btn) {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            
            [self.displayView addSubview:topBtn];
            [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.bottom.mas_equalTo(-HOME_INDICATOR_H);
                make.height.mas_equalTo(btnH);
            }];
            //1.2移除此action
            [mutActions removeObject:action];
        }
    }
    
    //2.otherBtns
    NSInteger maxIndex = mutActions.count-1;
    for (NSInteger i=maxIndex; i>=0; i--) {
        //2.1 添加btn
        DGAlertAction *action = mutActions[i];
        DGButton *btn = [self btnWithTitle:action.title];
        
        if(action.style == DGAlertActionStyleConfirm){
            [btn setTitleColor:RGBA(240, 105, 105, 1) forState:UIControlStateNormal];
        }
        
        [btn addClickBlock:^(UIButton *button) {
            //先撤销
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
            //在操作, 因为操作可能也是present
            action.handler(action);
        }];
        
        [self.displayView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(btnH);
            if (topBtn) {
                CGFloat bottomSpace = i==maxIndex ? -cancelGrayBarH : -garBarH;
                make.bottom.mas_equalTo(topBtn.mas_top).mas_offset(bottomSpace);
            }else{
                make.bottom.mas_equalTo(0);
            }
            if (i==0) {
                make.top.mas_equalTo(0);
            }
        }];
        
        //2.2 赋值topBtn
        topBtn = btn;
    }
    
    //3.return
    return topBtn;
}

#pragma mark - tool
- (DGButton *)btnWithTitle:(NSString *)title {
   return [DGButton btnWithFontSize:_fontSize title:title titleColor:COLOR_BLACK_TEXT bgColor:UIColor.whiteColor];
}

#pragma mark - interaction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.touchDismissEnabled) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
