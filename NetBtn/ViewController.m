//
//  ViewController.m
//  NetBtn
//
//  Created by 吴狄 on 16/10/13.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+net.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn.noNetImage=@"big-Star.png";
    self.btn.netSensitive=YES;
    self.btn.noNetResearchBlock=^(){
        NSLog(@"没有网络拉!!!");
    };
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
    NSLog(@"点击!");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
