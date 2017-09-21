//
//  ViewController.m
//  Coreanimation
//
//  Created by 周佳兴 on 2017/4/29.
//  Copyright © 2017年 周佳兴. All rights reserved.
//

#import "ViewController.h"
//#import "Masonry.h"
#import <GLKit/GLKit.h>

@interface ViewController ()<CALayerDelegate>{
    CALayer *blueLayer;
    CALayer *hourHand;
    CALayer *minuteHand;
    CALayer *secondHand;

}
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic)NSMutableArray *faces;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _layerView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor grayColor];
    
    /**
     *周佳兴
     *简单图层 创建
     **/
    
    [self createSimpleLayer];
    
    /**
     *周佳兴
     *  contents 图层的 寄宿图  
     *  CGImage 必须是
     **/
    [self contentsCGImage];
    
    /**
     *周佳兴
     *自适应
     **/
    
    [self likeContenrMode];
    
    /**
     *周佳兴
     *属性定义了寄宿图的像素尺寸和视图大小的比例，默认情况下它 是一个值为1.0
     *的浮点数。
     **/
    
    
    /**
     *周佳兴
     *是否绘制超出边界内容
     **/
    
    blueLayer.masksToBounds = YES;
    
    /**
     *周佳兴
     * contentsRect  裁切 显示范围 性允许我们在图层边框里显示寄宿图的一个子域。这 涉及到图片是如何显示和拉伸的，所以要比 contentsGravity 灵活多了
     **/
    
    
    [self contentsRect];
    /**
     *周佳兴
     *图层的 边框
     **/
    [self contentsCenter];

    /**
     *周佳兴
     *代理
     **/
    
    [self delegate];
    
    
    /**
     *周佳兴
     *锚点 旋转
     **/
    [self appointment];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(appointment1) userInfo:nil repeats:YES];
    [timer fire];
    
    /**
     *周佳兴
     *zposition z
     **/
    
    [self zPosition];
    
    /**
     *周佳兴
     *图层边框
     **/
    
    [self border];
    
    
    /**
     *周佳兴
     *阴影
     **/
    [self shadel];
}

/**代码块说明
 *shadowColor   shadowOffset    shadowRadius属性控制着阴影的模糊度
 */
-(void)shadel{
    _layerView.layer.shadowOpacity = 0.5;
    _layerView.layer.shadowColor = [UIColor blackColor].CGColor;
    _layerView.layer.shadowOffset = CGSizeMake(0, 0);
    _layerView.layer.shadowRadius = 10;
    
    /**
     *周佳兴
     *到这里你会看到 blueView 会有一个阴影的 不显示 不用担心 不是你写的代码出错了 是 masktobou 必须这么做 裁切手法
     **/
    blueLayer.shadowOpacity = 0.5;
    blueLayer.shadowColor = [UIColor yellowColor].CGColor;
    blueLayer.shadowOffset = CGSizeMake(0, 10);
    
    /**
     *周佳兴
     *图层蒙版
     **/
    
    [self mengban];
    
    /**
     *周佳兴
     *为了启用   属性，我们设置了图层
     的   属性。默认情况下，所有图层拉伸都是1.0， 所以如果你 使用了   属性，你就要确保你设置了 rasterizationScale 属 性去匹配屏幕，以防止出现Retina屏幕像素化的问题。
     **/
    
//    [self touming];
    
    /**
     *周佳兴
     *transform
     **/
    
//    [self transform];
    
    /**
     *周佳兴
     *3D变换
     **/
    [self thrDtran];
    
    /**
     *周佳兴
     *灭点
     **/
    
    /**
     *周佳兴
     *是否绘制双面
     **/
    
    [self shuangmian];
    
    /**
     *周佳兴
     *六面体
     **/
    
    [self liumianti];
    
    /**
     *周佳兴
     *富文本
     **/
    
    [self fuwenben];
    
    /**
     *周佳兴
     *热区 这个东西 相信很多人用不到 所以 也就 暂时 这个 原理就是 通过 self.view 获取点击时间的 位置 来判断 点击的 地方是否在 你需要的图层上
     */
    
    
    /**
     *周佳兴
     * CAShapeLayer 划线
     */
    
    [self CAShapeLayer:blueLayer];
    
    /**
     *周佳兴
     *单独的圆角
     */
    
    [self radio];
    
    /**
     * CATransformLayer 用这个来 做相当于 正方体的 变换 区别是什么呢  区别是 可以当做 一个整体 来做动作 而并不是 单个 是 视图
     */
    
    [self catransformLayer];
}


-(void)catransformLayer{

    NSArray *arr = [_containerView.layer sublayers];
    NSLog(@"%lu", (unsigned long)arr.count);
    for (CALayer *layer in arr) {
//        [layer removeFromSuperlayer];
        
        layer.hidden = YES;
        NSLog(@"1111");
    }
    
    CATransform3D ct1 = CATransform3DIdentity;
    ct1 = CATransform3DTranslate(ct1, -100, 0, 0);
    
    CALayer *cube1 = [self cubeWithTransform:ct1];
    
      [self.containerView.layer addSublayer:cube1];

}

- (CALayer *)faceWithTransform:(CATransform3D)transform{

    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    
    face.transform = transform; return face;

}

- (CALayer *)cubeWithTransform:(CATransform3D)transform{
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = self.containerView.bounds.size;
    
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height/2.0);
    //apply the transform and return
    cube.transform = transform;
    return cube;

}
/**代码块说明
 *单独的圆角
 */
-(void)radio{

    //define path parameters
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20); // 圆角的 rect
    //create path
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
}

/**代码块说明
 *划线
 */
-(void)CAShapeLayer:(CALayer *)layer{
    /* 初始化一个layer */
    CAShapeLayer *border = [CAShapeLayer layer];
    
    
    /* 虚线的颜色 */
//    border.strokeColor = RGBFromHexColor(0xfe527a).CGColor;
    /* 填充虚线内的颜色 */
    border.fillColor = nil;
    /* 贝塞尔曲线路径 */
    border.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(4, 4, 200- 8, 40 - 8) cornerRadius:20].CGPath;
    /* 虚线宽度 */
    border.lineWidth = 0.7f;
    border.lineCap = @"square";
    /* 虚线的每个点长  和 两个点之间的空隙 */
    border.lineDashPattern = @[@3];
    /* 添加到你的控件上 */
    [layer addSublayer:border];

}

/**代码块说明
 *
 */
-(void)fuwenben{
    
}
/**代码块说明
 *
 */
-(void)liumianti{
    _faces = [[NSMutableArray alloc]init];
    [_faces addObject:_view1];
    [_faces addObject:_view2];
    [_faces addObject:_view3];
    [_faces addObject:_view4];
    [_faces addObject:_view5];
    [_faces addObject:_view6];
    
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;

    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    
    [self addFace:0 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);    [self addFace:2 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, 0, -50);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];

}


#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    UIView *view = self.faces[index];
    
    [self.containerView addSubview:view];
    CGSize containerSize = self.containerView.bounds.size;
    
    view.center = CGPointMake(containerSize.width / 2.0, containerSize.height/2);
    view.layer.transform = transform;
    
    view.layer.doubleSided = NO;
    
    [self applyLightingToFace:view.layer];
    
    
}
- (void)applyLightingToFace:(CALayer *)face{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
    
    [face addSublayer:layer];

}

/**代码块说明
 *
 */
-(void)shuangmian{
    blueLayer.doubleSided = NO;
}

/**代码块说明
 *绕 Y 轴旋转 75 ）
 */
-(void)thrDtran{
    
        CATransform3D _3Dtran = CATransform3DIdentity;
        _3Dtran.m34 = - 1.0 / 500.0;
    
        _3Dtran =  CATransform3DRotate(_3Dtran, M_PI/180 * 75, 0, 1, 0);

//    blueLayer.transform = _3Dtran;
    
    /**
     *周佳兴
     *透视投影          500   ---- 1000
     **/
    
}
// #define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)

/**
 *周佳兴
 *旋转 90 ）
 */
-(void)transform{
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    _layerView.transform = transform;
    
    // CGAffineTransformRotate 从什么变换引入而来
}
-(void)touming{
//blueLayer.
    
    _layerView.alpha = 0.5;
    _layerView.layer.shouldRasterize = YES;
    _layerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
-(void)mengban{
//mask
//    blueLayer.mask = [CALayer layer];
}
-(void)border{
    blueLayer.borderWidth = 10;
    blueLayer.borderColor = [UIColor redColor].CGColor;
}
-(void)zPosition{
    blueLayer.zPosition = 1; // 让他显示的大一点 但是 只是看起来 显示在前面了 而已 式计算过 图层树中他还是 在原来的 位置上显示的
}
-(void)delegate{
    blueLayer.delegate = self;
    
    /**
     *周佳兴
     *手动调用代理方法用了此方法之后寄宿图会失效应该是会被盖住
     **/
    [blueLayer display];
}

/**代码块说明
 *时钟
 */
-(void)appointment1{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 日历  公历
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
        //rotate hands
    //    CGAffineTransformMakeRotation(<#CGFloat angle#>)
    hourHand.transform =CATransform3DMakeRotation(hoursAngle, 0, 0, 1);
    //    CGAffineTransformMakeRotation(hoursAngle);
    minuteHand.transform =CATransform3DMakeRotation(minsAngle, 0, 0, 1);
    //    CGAffineTransformMakeRotation(minsAngle);
    secondHand.transform =CATransform3DMakeRotation(secsAngle, 0, 0, 1);
    //    CGAffineTransformMakeRotation(secsAngle);
    
   
}

/**代码块说明
 *时钟
 */
-(void)appointment{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 日历  公历
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
    secondHand.anchorPoint = CGPointMake(0.5f, 0.9f);
    minuteHand.anchorPoint = CGPointMake(0.5f, 0.9f);
    hourHand.anchorPoint = CGPointMake(0.5f, 0.9f);
    //rotate hands
//    CGAffineTransformMakeRotation(<#CGFloat angle#>)
    hourHand.transform =CATransform3DMakeRotation(hoursAngle, 0, 0, 1);
//    CGAffineTransformMakeRotation(hoursAngle);
    minuteHand.transform =CATransform3DMakeRotation(minsAngle, 0, 0, 1);
//    CGAffineTransformMakeRotation(minsAngle);
    secondHand.transform =CATransform3DMakeRotation(secsAngle, 0, 0, 1);
//    CGAffineTransformMakeRotation(secsAngle);

}
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    /**
     *周佳兴
     *线宽
     **/
    CGContextSetLineWidth(ctx, 10);
    
    /**
     *周佳兴
     *线颜色
     **/
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);

    /**
     *周佳兴
     *形状  椭圆  位置
     **/
    CGContextStrokeEllipseInRect(ctx, CGRectMake(6, 16, 50, 50));
}
/**代码块说明
 *contentsCenter 拉抻
 */
-(void)contentsCenter{
    blueLayer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
}
/**代码块说明
 *maskToBounds
 */
-(void)contentsRect{
//    blueLayer.contentsRect = CGRectMake(0, 0, 0.5,0.5);
}
/**代码块说明
 * contentScall
 */
-(void)contentScal{
}
/**代码块说明
 * 让图片更适合的展示contentsGravity
 */

-(void)likeContenrMode{
    blueLayer.contentsGravity = kCAGravityResizeAspect;
}
/**代码块说明
 *图层上的图片
 */ 
-(void)contentsCGImage{
    
//    NSURL *url = [NSURL URLWithString:@"http://uploadpic.55.la/upload/temp/2017/05/02/11/56814338588273.png"];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:data];
    UIImage *image = [UIImage imageNamed:@"屏幕快照 2017-04-29 15.49.56"];
    
    UIImage *image1 = [UIImage imageNamed:@"时针"];

    UIImage *image2 = [UIImage imageNamed:@"时针"];

    UIImage *image3 = [UIImage imageNamed:@"时针"];

    blueLayer.contents =  (__bridge id)(image.CGImage);
    
    
    hourHand.contents =  (__bridge id)(image1.CGImage);
    minuteHand.contents =  (__bridge id)(image2.CGImage);
    secondHand.contents =  (__bridge id)(image3.CGImage);

    _layerView.layer.contentsScale = image.scale;
}
/**
 * Core Animation是一个复合引擎，它的职责就是尽可能快地组合屏幕上不同的可 视内容，这个内容是被分解成独立的图层，存储在一个叫做图层树的体系之中。
 *阴影，圆角，带颜色的边框 3D变换
 *非矩形范围
 *透明遮罩
 *多级非线性动画
 */
-(void)createSimpleLayer{
    blueLayer = [CALayer layer];
    [_layerView.layer addSublayer:blueLayer];
    
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    
    
    
    hourHand = [CALayer layer];
    [_layerView.layer addSublayer:hourHand];
    
    hourHand.backgroundColor = [UIColor clearColor].CGColor;
    hourHand.frame = CGRectMake(100, 50, 10, 70);
//    hourHand.contentsCenter = CGRectMake(0.4, 0, 0.1, 0.8);
    hourHand.contentsRect = CGRectMake(0.45, 0.03, 0.08, 0.7);

    minuteHand = [CALayer layer];
    [_layerView.layer addSublayer:minuteHand];
    
    minuteHand.backgroundColor = [UIColor clearColor].CGColor;
    minuteHand.frame = CGRectMake(100, 50, 10, 70);
//    minuteHand.contentsCenter = CGRectMake(0.4, 0, 0.1, 0.8);
    minuteHand.contentsRect = CGRectMake(0.45, 0.03, 0.08, 0.7);

    secondHand = [CALayer layer];
    [_layerView.layer addSublayer:secondHand];
    
    secondHand.backgroundColor = [UIColor clearColor].CGColor;
    secondHand.frame = CGRectMake(100, 50, 10, 70);
//    secondHand.contentsCenter = CGRectMake(0.4, 0, 0.1, 0.8);
    secondHand.contentsRect = CGRectMake(0.45, 0.03, 0.08, 0.7);

    
//    blueLayer.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
