//
//  UIButton+net.h
//  NetBtn
//
//  Created by 吴狄 on 16/10/13.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (net)
@property (nonatomic,assign)BOOL netSensitive;
@property (nonatomic,copy)void(^noNetResearchBlock)(void);
@property (nonatomic,copy)NSString *noNetImage;

//-(void)addNoNetSearchTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
