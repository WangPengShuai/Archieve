# Archieve
对归档的封装，使用方便简单，轻松实现数据本地化。

```
@interface ViewController ()
@property (nonatomic, strong) BDLocalModelAgent *agent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 10; i ++) {
        Person *p = [[Person alloc] init];
        p.name = [NSString stringWithFormat:@"我是%d",i];
        p.age  = [NSString stringWithFormat:@"年龄%d",i];
        p.area = [NSString stringWithFormat:@"地区%d",i];
        [array addObject:p];
    }
    //缓存
    self.agent = [[BDLocalModelAgent alloc] init];
    self.agent.domain = @"233333";
    [self.agent removeAllInfos];
    [self.agent addInfos:array];
    [self.agent saveInfos];
}

@end
```
