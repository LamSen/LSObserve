//
//  NSObject+LSObeserver.m
//  observe
//
//  Created by 林小文 on 15/02/22.
//  Copyright © 2015年 林小文. All rights reserved.
//

#import "NSObject+LSObserver.h"
#import <objc/message.h>


static NSString * const LS_DICT_KEY = @"OB_DICT";
static char * const  LS_DICT_KEY_C = "OB_DICT";
static NSString *const LS_TARGET_KEY = @"target";


typedef void(^completionBlock)(NSDictionary<NSString *,id> *change);

@implementation NSObject (LSObserver)

/// 程序加载的时候,交互dealloc方法的实现.
+(void)load{
    Method dealloc  = class_getInstanceMethod([self class], sel_registerName("dealloc"));
    Method ls_dealloc = class_getInstanceMethod([self class], sel_registerName("ls_dealloc"));
    method_exchangeImplementations(dealloc, ls_dealloc);
}

/// 自定义的dealloc方法,添加了移除观察者的功能.
- (void)ls_dealloc{
    if (objc_getAssociatedObject(self, LS_DICT_KEY_C)) {
         NSLog(@"%@对象销毁了",  NSStringFromClass([self class]));
        [self.observerDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key containsString:LS_TARGET_KEY]){
                key =   [key stringByReplacingOccurrencesOfString:LS_TARGET_KEY withString:@""];
                [obj removeObserver:self forKeyPath:key];
            }
        }];
    }
    objc_msgSend(self, sel_registerName("ls_dealloc"));
}

/**
 *  去观察某个对象的某个属性,如果属性发生变化,就会调用completionBlock里面的代码.会在对象销毁的时候,自动清除观察者.
 *
 *  @param target     观察某个对象
 *  @param keyPath    属性名
 *  @param options    观察设置
 *  @param completion 属性发生变化时会调用该方法.
 */
- (void)ls_observeTarget:(NSObject *)target forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options completion:(void (^)(NSDictionary<NSString *,id> *))completion{
    [target addObserver:self forKeyPath:keyPath options:options context:nil];
    [self.observerDict setValue:completion forKey:keyPath];
    NSString *keyPathTarget = [keyPath stringByAppendingString:LS_TARGET_KEY];
    [self.observerDict setValue:target forKey:keyPathTarget];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (objc_getAssociatedObject(self, LS_DICT_KEY_C)) {
        [self.observerDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, void (^completion)(NSDictionary<NSString *,id> *) , BOOL * _Nonnull stop) {
            if (![key isEqualToString:keyPath]) return ;
            completion(change);
        }];
    }
}

- (NSMutableDictionary *)observerDict{
    if (!objc_getAssociatedObject(self, LS_DICT_KEY_C)) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, LS_DICT_KEY_C, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return (NSMutableDictionary *)objc_getAssociatedObject(self, LS_DICT_KEY_C);
}


@end
