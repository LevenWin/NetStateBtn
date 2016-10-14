#NetStateBtn


模仿网易的btn在没网络下，自动更换属性。demo有点粗糙，不过展现了其中的原理。只要要添加一个分类。并且在添加Btn的时候写上 没有图片要展示的image即可。

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




另外没有网络下，btn 的action也可以转换。我那里写了一点。


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


这里是将userInteractionEnabled作为标志，换一个标志即可，不要设userInteractionEnabled为NO。

![](https://github.com/LevenWin/NetStateBtn/raw/master/screen.gif)
