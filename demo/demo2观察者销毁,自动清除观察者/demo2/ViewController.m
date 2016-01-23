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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /// 弱引用,过后销毁.
    Person *observer = [Person person];
    
    /// 强引用,不会被销毁.
    self.target = [Person person];
    
    /*
     
     方法的调用者去观察某个对象的某个属性,当被观察的对象的该属性发生变化,就会调用block里面的代码.
     
    change : 和 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context中的change一样.
     
     */
   [observer ls_observeTarget:self.target forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld completion:^(NSDictionary<NSString *,id> *change) {
       
       NSLog(@"属性发生变化 \n %@",change);
       
   }];
    
    /// target的被观察的属性发生变化.
    self.target.name = @"new_name";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    /// observer对象已经被销毁了,但是target的属性发生变化,不会报错.因为已经移除了观察者.
    self.target.name = @"new_name2";
    
}
@end
