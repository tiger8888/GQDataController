GQDataController
=================

GQDataController是一款符合MVVM模式的网络框架，通过混合AFNetworking和Mantle让你更方便的处理网络交互。

## 基本使用

GQDataController是一个抽象类，使用前需要先创建新的子类。每个子类表示一种接口交互。

首先，子类必须实现这个接口，并返回请求的接口字符串。

```objc
- (NSArray *)requestURLStrings;
```

通过初始化方法创建实例。

```objc
- (instancetype)initWithDelegate:(id <GQDataControllerDelegate>)aDelegate;
```

### GQDataControllerDelegate委托方法

GQDataControllerDelegate定义了3个方法用于回调，当然你也可以选择Block风格的回调。

```objc
- (void)dataControllerWillStartLoading:(GQDataController *)controller;

- (void)dataControllerDidFinishLoading:(GQDataController *)controller;

- (void)dataController:(GQDataController *)controller didFailWithError:(NSError *)error;
```

### 接口请求

创建完实例后，你可以发起请求接口

不带参数的接口请求。

```objc
- (void)request;
```

带参数的接口请求

```objc
- (void)requestWithParams:(NSDictionary *)params;
```

Block风格

```objc
- (void)requestWithParams:(nullable NSDictionary *)params
                  success:(nullable GQRequestSuccessBlock)success
                  failure:(nullable GQRequestFailureBlock)failure;
```

### 其它配置

```objc
- (NSString *)requestMethod;
```

### 结果处理

原始对象，即AFNetworking返回的responseObject。

```objc
@property (nonatomic, copy, readonly) id responseObject;
```

检测返回的结果是否有效，如果返回NO，会进入失败流程，即使接口请求成功。

```objc
- (BOOL)isValidWithObject:(id)object;
```

## Mantle

GQDataController可以自动的将AFNetworking返回的结果转换成Mantle对象。在GQDataController中定义了mantleObject和mantleObjectList 2个实例属性。如果转换的JSON是字典，会将结果赋值到mantleObject；如果转换的JSON是数组，则会将结果赋值到mantleObjectList。

### 启用Mantle转换

mantleObject和mantleObjectList都有相对应的配置方法，你需要手动指定转换用的Class和JSON路径(可选)。

默认实现中mantleObjectListKeyPath和mantleListModelClass会返回mantleObjectKeyPath和mantleModelClass的值。

```objc
- (Class)mantleModelClass;

- (NSString *)mantleObjectKeyPath;

- (Class)mantleListModelClass;

- (NSString *)mantleObjectListKeyPath;
```

### 内置DataSource

GQDataController声现UITableViewDataSource和UICollectionViewDataSource，你可以快速的创建DataSource。

```objc
@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) GQTableViewCellConfigureBlock tableViewCellConfigureBlock;

@property (nonatomic, copy) GQCollectionViewCellConfigureBlock collectionViewCellConfigureBlock;
```

### 分页

GQDataController提供的便捷的分页请求方法：

```objc
- (void)requestMore;
```

这个方法会复制之前的接口请求参数，然后对当前页的参数值进行+1处理。

#### 自定义当前页参数名称

返回接口分页请求时第几页的参数名称，默认返回值是p。

```objc
- (NSString *)pageParameterName;
```

## 其它

### 接口重试

可以设置多个请求地址，方便在接口请求失败时，使用另外的地址继续请求。

```objc
- (NSArray *)requestURLStrings;
```

### 接口Stub

GQDataController也集成了OHHTTPStubs，允许你使用本地JSON文件来做为接口返回，该功能只在定义过DEBUG宏的条件下开启。

### 复制

GQDataController也实现NSCopying协议，你可以快速的复制当前的实例。

### 单例

```objc
+ (instancetype)sharedDataController;
```

这个子类都可以类方法来获取自己的单例。

## GQDynamicDataController

GQDynamicDataController是GQDataController的子类，它允许在不创建子类的情况下，初始化请求的地址和请求的方法，但不能定义其它的东西。通常在接口请求逻辑比较简单的情况下使用。

```objc
+ (instancetype)dataControllerWithURLString:(NSString *)URLString;

+ (instancetype)dataControllerWithURLString:(NSString *)URLString requestMethod:(NSString *)method;
```

## 系统要求

需要iOS 8以上

第三库依赖：

* AFNetworking 3.X
* Mantle 2.X
* OHHTTPStubs 4.0 or higher

## 安装

### CocoaPods

```
pod 'GQDataController'
```


## 例子

请参考Demo工程中的例子：

1. 基本使用
2. 使用Block风格的回调
3. 使用Mantle处理返回结果
4. DataSource
5. 分页
6. 接口的Stub



## FAQ

**是否支持XML的返回格式？**

当前只支持JSON格式。

**如何为接口添加公共参数？**

自定义AFHTTPRequestSerializer，然后在初始化方法中设置

```objc
self.requestOperationManager.requestSerializer
```

**如何自定义接口的响应**

自定义AFJSONResponseSerializer，然后在初始化方法中设置

```objc
self.requestOperationManager.responseSerializer
```

你甚至可以自定义子类，用于将任意格式的结果转换成JSON。

**是否需要创建自己的基类？**

总是继承自己的基类是最好的实践。你可以在基类里配置AFNetworking及其它自定义属性。

## LICENSE

See LICENSE
