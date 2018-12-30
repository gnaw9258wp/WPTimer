//
//  ViewController.m
//  解决NSTimer的循环引用
//
//  Created by wp on 2018/12/30.
//  Copyright © 2018年 wp. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "WPProxy.h"

@interface ViewController ()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)id target;
@property (nonatomic,strong)WPProxy *proxy;
@end

@implementation ViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    #pragma mark 方法二
    /*
     self.target = [NSObject new];
     Method method = class_getInstanceMethod([self class], @selector(fire));
     //    class_addMethod([self.target class], @selector(fire), (IMP)cMethod, "v@:");
     class_addMethod([self.target class], @selector(fire), method_getImplementation(method), "v@:");
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self.target selector:@selector(fire) userInfo:nil repeats:YES];

     */
#pragma mark 方法三
    
    self.proxy = [WPProxy alloc];
    self.proxy.target = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self.proxy selector:@selector(fire) userInfo:nil repeats:YES];

    // Do any additional setup after loading the view, typically from a nib.
}



void cMethod(id self,SEL _cmd){
    NSLog(@"CMethod %@",NSStringFromClass([self class]));
}

//方法实现
- (void)fire{
    NSLog(@"fire");
}

#pragma mark - 方法一
- (void)didMoveToParentViewController:(UIViewController *)parent
{
    
    NSLog(@"didMoveToParentViewController %@",parent);
    if (parent == nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
