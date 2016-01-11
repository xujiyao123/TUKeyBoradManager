//
//  TUKeyboardManager.h
//  CYKJ_APP
//
//  Created by 徐继垚 on 16/1/11.
//  Copyright © 2016年 Sunny土. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUKeyboardManager : NSObject

+ (TUKeyboardManager *)sharedManager;

- (void)addKeyboardObserver;

- (void)addKeyboardObserverTextView:(UITextView *)textView;

@end
