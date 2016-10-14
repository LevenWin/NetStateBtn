//
//  UIButton+net.m
//  NetBtn
//
//  Created by 吴狄 on 16/10/13.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UIButton+net.h"
#import <objc/runtime.h>
#import "Reachability.h"
@implementation UIButton (net)
+(void)load{
    
}
static char *netSensitiveChar;
static char *noNetActionChar;
static char *noNetImageChar;

-(void)setNetSensitive:(BOOL)netSensitive{
    objc_setAssociatedObject(self, &netSensitive, @(netSensitive), OBJC_ASSOCIATION_RETAIN);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}
-(void)setNoNetResearchBlock:(void (^)(void))noNetResearchBlock{
    objc_setAssociatedObject(self, &noNetActionChar, noNetResearchBlock, OBJC_ASSOCIATION_COPY);

}
-(void)setNoNetImage:(NSString *)noNetImage{
    objc_setAssociatedObject(self, &noNetImageChar, noNetImage, OBJC_ASSOCIATION_RETAIN);

}
-(void (^)(void))noNetResearchBlock{
    return objc_getAssociatedObject(self, &noNetActionChar);
}
-(BOOL)netSensitive{
    NSNumber *num=  objc_getAssociatedObject(self, &netSensitiveChar);
    return num.boolValue;
}
- (void) reachabilityChanged: (NSNotification* )noti {
    Reachability *reachability = [noti object];
    NetworkStatus status = [reachability currentReachabilityStatus];
   
    if (status == NotReachable) {
      
        if (self.userInteractionEnabled) {
             [self storeState];
            self.userInteractionEnabled=NO;

        }
        
        NSString *str=objc_getAssociatedObject(self, &noNetImageChar);
        [self setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        
    }else{
        if (!self.userInteractionEnabled) {
            
            [self storeState];
            self.userInteractionEnabled=YES;

        }
 
    }
    
}
-(void)storeState{
    static NSMutableArray *dataArr;
    if (self.userInteractionEnabled) {
        dataArr=[NSMutableArray array];
        [dataArr addObject:self.imageView.image];

    }else{
        [self setImage:dataArr.firstObject forState:UIControlStateNormal] ;
        [dataArr removeAllObjects];
    }
    
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"taggets  %@",self.allTargets);
//    NSLog(@"eventstate  %lu",(unsigned long)self.allControlEvents);
//    NSLog(@"action  %@",[self actionsForTarget:self.allTargets.allObjects.firstObject forControlEvent:self.allControlEvents]);
    if(self.userInteractionEnabled==NO){
        if (self.noNetResearchBlock) {
            self.noNetResearchBlock();
        }
    }
    
    return YES;
}

@end
