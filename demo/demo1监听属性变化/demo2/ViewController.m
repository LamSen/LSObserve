//
//  ViewController.m
//  demo2
//
//  Created by 林小文 on 16/1/23.
//  Copyright © 2016年 林小文. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+LSObserver.h"

@interface ViewController ()

/// 被观察的对象
@property (strong, nonatomic)  Person*target;

/// 观察者
@property (strong, nonatomic) Person *observer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /// 强引用,不会被销毁.
    self.observer = [Person person];
    
    /// 强引用,不会被销毁.
    self.target = [Person person];
    
    /*
     方法的调用者去观察某个对象的某个属性,当被观察的对象的该属性发生变化,就会调用block里面的代码.
     
    change : 和 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context中的change一样.
     */
   [self.observer ls_observeTarget:self.target forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld completion:^(NSDictionary<NSString *,id> *change) {
       
       NSLog(@"属性发生变化 \n %@",change);
       
   }];
    
    /// target的被观察的属性发生变化.
    self.target.name = @"new_name";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    /// 观察者没有被销毁,依然可以监听该属性的变化.
    self.target.name = @"new_name2";
    
}
@end
