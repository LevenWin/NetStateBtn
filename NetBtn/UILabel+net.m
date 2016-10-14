//
//  UILabel+net.m
//  NetBtn
//
//  Created by 吴狄 on 16/10/13.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UILabel+net.h"
#import <objc/runtime.h>
#import "Reachability.h"
@implementation UILabel (net)
+(void)load{
    
}
static char *netSensitiveChar;

-(void)setNetSensitive:(BOOL)netSensitive{
    objc_setAssociatedObject(self, &netSensitive, @(netSensitive), OBJC_ASSOCIATION_RETAIN);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}
-(BOOL)netSensitive{
    NSNumber *num=  objc_getAssociatedObject(self, &netSensitiveChar);
    return num.boolValue;
}
- (void) reachabilityChanged: (NSNotification* )noti {
    Reachability *reachability = [noti object];
    NetworkStatus status = [reachability currentReachabilityStatus];
    NSString *string = @"HasNetwork";
    static NSMutableDictionary*dic;
    if (status == NotReachable) {
        string = @"HasNoNetwork";
        self.userInteractionEnabled=NO;
        NSLog(@"没有网络");
        [dic  setObject:self.textColor forKey:[NSString stringWithFormat:@"%lu",[self hash]]];
       
        self.textColor=[UIColor lightGrayColor];
       
    }else{
        self.textColor=dic[[NSString stringWithFormat:@"%lu",[self hash]]];

    }
    
}

@end
