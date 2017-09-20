# HiddenNavigationBar
how to hidden navigationBar correctly


最近项目里折腾了下隐藏导航栏的问题。折腾的难度没有预期的那么低。。。
现在在这里总结一下：
###基础版 
```
- (void)viewWillAppear:(BOOL)animated {
[super viewWillAppear:animated];
[self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
[super viewWillDisappear:animated];
[self.navigationController setNavigationBarHidden:NO animated:animated];
}
```
基础版使用系统自带的方法，优点是简单实用，能够解决返回的时候隐藏导航栏动画问题。这在隐藏页面在导航控制器中间的时候没有问题。但是如果页面是导航控制器的根视图控制器，而这个导航栏又处于tabbar控制器的某一栏里，当你从别的tabbar切换到这个控制器就会发现导航栏会跳一下。这里的处理就不那么简单了。
###进阶版
进阶版是我找到的别人做法
[iOS透明导航栏的平滑过渡（进阶版）](http://blog.csdn.net/cloudox_/article/details/64924176)大概看了下，这位哥们的思路是把导航栏搞成透明的。然后我就把他的category拖到了工程里。试用了下，结果发现不行。。。不行。。。恩，好吧，那我再换另一个教程，于是就找到了下面这位大哥的教程:
[【iOS】让我们一次性解决导航栏的所有问题](https://juejin.im/entry/57fcd57a67f356005886e867)看标题就高大上啊。受此影响，我也给自己的这篇教程取了个高大上又装逼，然而并没有多少内涵的标题。。。好吧，这不是重点。重点是，我把它的东西拖进来了，发现还是不行。。。难道是我的姿势不对？- -，除了显示有问题之外，它用起来还特别卡。。。还要继承它的类，对我自己原来的项目倾入性还很大。
###终极大招
恩， 好吧。经过一番思考，我自己提出了一套解决方案，基本思路如下:
这套方案里，我使用的还是`setNavigationBarHidden: animated:`还是这个方法。假设我们tabbar控制器里有3个控制器 A、B、C，C控制器需要隐藏导航栏，并且C控制器里有个按钮，可以push到D控制器，且D控制器需要显示导航栏。但是所以我们需要实现的就是，从A、B到C的时候，`setNavigationBarHidden: animated:`的`animated`参数需要设置为`NO`，而从D控制器pop回C控制器的时候，需要设置为`YES`。这样就能完美解决动画问题。为了能够统一控制，且易于以后扩展到别的控制器，我把tabbarController跟navigationController做了继承，通过在navigationcontroller的代理方法`- navigationController: willShowViewController: animated:`里完成隐藏与现实导航栏的操作。这里我们需要判断我们是从A、B控制器到C控制器，还是从D控制器pop回C控制器。我的实现思路如下：我给`BaseTabBarViewController`设置了一个`delayIndex`属性来记录上一次tabbarController所在的index。然后我在`BaseTabBarViewController`的代理方法里设置delayIndex
```
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
self.delayIndex = self.selectedIndex;
return YES;
}
```
由于这个代理方法执行的时候，页面还没有跳到选中的控制器，就完成了记录上一次选中标签的工作。这样，在navigationcontroller的代理方法里判断`delayIndex`如果是0或者1，那么就是从A或者B控制器过来的，这时候就不需要动画：
```
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
BOOL hiddenAnimate = NO;
NSInteger count = ((BaseTabBarViewController *)viewController.tabBarController).delayIndex;
if (count == 2) {
hiddenAnimate = YES;
}
BOOL isShowHomePage = [viewController isKindOfClass:[SecondViewController class]];
[self setNavigationBarHidden:isShowHomePage animated:hiddenAnimate];
}
```
接下来解决从D控制器pop回去需要动画的问题。这里我想到去判断navigationController的栈里如果有大于1个的控制器，那就说明是push出去了。这时候让delayIndex等于当前tabbarController的selectedIndex。就可以解决了。代码如下：
```
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
if (viewController.tabBarController.selectedIndex == 2 && [self.viewControllers count] > 1) {
((BaseTabBarViewController *)viewController.tabBarController).delayIndex = viewController.tabBarController.selectedIndex;

}
}

```
完成效果如下:

![效果.gif](http://upload-images.jianshu.io/upload_images/1598196-b2dd4e99ec1dbabd.gif?imageMogr2/auto-orient/strip)
