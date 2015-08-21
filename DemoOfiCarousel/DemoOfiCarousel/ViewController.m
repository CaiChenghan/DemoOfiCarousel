//
//  ViewController.m
//  DemoOfiCarousel
//
//  Created by 蔡成汉 on 15/8/21.
//  Copyright (c) 2015年 蔡成汉. All rights reserved.
//

#import "ViewController.h"
#import "iCarousel.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<iCarouselDataSource,iCarouselDelegate>
{
    iCarousel *myICarousel;
    NSMutableArray *dataArray;
}
@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        dataArray = [NSMutableArray array];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSArray *tpArray = [NSArray arrayWithObjects:@"http://a.hiphotos.baidu.com/image/pic/item/48540923dd54564e8a195839b1de9c82d1584fb5.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/ac345982b2b7d0a2b1739e71cfef76094a369aa0.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/caef76094b36acafed510c1078d98d1000e99cad.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/eaf81a4c510fd9f94c4bcf85212dd42a2934a4fa.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/55e736d12f2eb9384be4e01ed1628535e4dd6f55.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/023b5bb5c9ea15ce93ba7ae5b2003af33b87b282.jpg",@"http://e.hiphotos.baidu.com/image/pic/item/b2de9c82d158ccbfb8a851d61dd8bc3eb03541c2.jpg", nil];
    
    
    [dataArray removeAllObjects];
    [dataArray addObjectsFromArray:tpArray];
    
    
    
    myICarousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 200)];
    myICarousel.backgroundColor = [UIColor clearColor];
    myICarousel.type = iCarouselTypeRotary;
    myICarousel.dataSource = self;
    myICarousel.delegate = self;
    [self.view addSubview:myICarousel];
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return dataArray.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    if (view == nil)
    {
        view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, myICarousel.frame.size.width*0.4, myICarousel.frame.size.height)];
        view.backgroundColor = [UIColor clearColor];
        [((UIImageView *)view) sd_setImageWithURL:[NSURL URLWithString:[dataArray objectAtIndex:index]] placeholderImage:nil];
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.clipsToBounds = YES;
    }
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}


#pragma mark - iCarouselDelegate

-(CGFloat)carouselItemWidth:(iCarousel * __nonnull)carousel
{
    return myICarousel.frame.size.width*0.6;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * myICarousel.itemWidth);
}


#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Tapped view number: %ld", index);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(myICarousel.currentItemIndex));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
