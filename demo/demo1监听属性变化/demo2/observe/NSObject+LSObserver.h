//
//  NSObject+LSObeserver.h
//  observe
//
//  Created by 林小文 on 15/02/22.
//  Copyright © 2015年 林小文. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (LSObserver)

//- (void)ls_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options completion:(void(^)(NSDictionary<NSString *,id> *change))completion;

/// 观察属性字典(target,keyPath,completionBlock)
@property (strong, nonatomic ,readonly) NSMutableDictionary *observerDict;

/**
 *  去观察某个对象的某个属性,如果属性发生变化,就会调用completionBlock里面的代码.会在对象销毁的时候,自动清除观察者.
 *
 *  @param target     观察某个对象
 *  @param keyPath    属性名
 *  @param options    观察设置
 *  @param completion 属性发生变化时会调用该方法.
 */
- (void)ls_observeTarget:(NSObject *)target forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options completion:(void(^)(NSDictionary<NSString *,id> *change))completion;


@end
