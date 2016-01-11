//
//  TUKeyboardManager.m
//  CYKJ_APP
//
//  Created by 徐继垚 on 16/1/11.
//  Copyright © 2016年 Sunny土. All rights reserved.
//

#import "TUKeyboardManager.h"

static TUKeyboardManager * manager = nil;
static CGFloat _textViewHight;

@interface TUKeyboardManager ()


@property (nonatomic ,retain) UITextView * textView;


@end

@implementation TUKeyboardManager

+ (TUKeyboardManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TUKeyboardManager alloc]init];
    });
    return manager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
  
    }
    return  self;
    
}
- (void)addKeyboardObserver {
    [self addKeyboardObserverTextView:nil];
}

- (void)addKeyboardObserverTextView:(UITextView *)textView{
    
    if (textView) {
        
        self.textView = textView;
         _textViewHight = textView.bounds.size.height;
        
    }else {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)textFieldViewDidBeginEditing:(NSNotification *)notification {
    
    if ([notification.object isKindOfClass:[UITextView class]]) {
        self.textView = (UITextView *)notification.object;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _textViewHight = self.textView.bounds.size.height;
        });
    }
    
}
- (void)keyboardWillShowOrHide:(NSNotification *)notification {
    
    // 屏幕方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    //用户信息
    NSDictionary *info = notification.userInfo;
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyboardEnd = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 键盘尺寸
    CGFloat keyboardHeight = UIInterfaceOrientationIsLandscape(orientation) ? keyboardEnd.size.width : keyboardEnd.size.height;
    // 动画
    UIViewAnimationOptions animationOptions = curve << 16;
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            CGRect editorFrame = self.textView.frame;
            editorFrame.size.height = (_textViewHight - keyboardHeight)  ;
            self.textView.frame = editorFrame;
            
        } completion:nil];
        
    } else {
        
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
            CGRect editorFrame = self.textView.frame;
            editorFrame.size.height = _textViewHight;
            self.textView.frame = editorFrame;
            
        } completion:nil];
        
    }
    
}

@end
