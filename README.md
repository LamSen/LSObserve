# LSObserve
快速的使用观察者方法.

observe文件里面.

该工具使用了runtime的方法.因此需要在 Build Settings -->  Enable Strict Checking of objc_msgSend Calls --> 设置为NO.

该工具重写了
    - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context 方法 , 因此如果观察者重写了-observeValueForKeyPath,那么可能会出现某些功能不能使用
  - (void)dealloc 方法,因此,.如果重写了- (void)dealloc方法,可能会导致一些错误.

该工具的作用是 : 
    1. 当被观察的属性发生变化的时候,不需要实现 - (void)observeValueForKeyPath方法,会通过block回调,返回一个change字典.
    2. 当观察者被销毁的时候,不需要手动的清除观察者.会自动的在观察者被销毁的时候清除观察者.
