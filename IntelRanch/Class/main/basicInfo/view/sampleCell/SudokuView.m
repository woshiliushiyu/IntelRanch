//
//  SudokuView.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/6.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "SudokuView.h"

@interface SudokuView ()
@property(nonatomic,strong)NSMutableArray * imgs;
@end


@implementation SudokuView
-(NSMutableArray *)imgs
{
    if (!_imgs) {
        
        _imgs = [[NSMutableArray alloc] init];
    }
    return _imgs;
}
- (instancetype)initWithFrame:(CGRect)frame Imgs:(NSMutableArray*)imgs
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        CGFloat margin = 10;
        int totalColumns = 3;
        
        for (int i=0; i<imgs.count; i++) {
            
            int row = i / totalColumns;
            int col = i % totalColumns;
            CGFloat cellW = (frame.size.width-(3*margin))/3;
            CGFloat cellX = col*(margin + cellW);
            CGFloat cellY = row * (cellW+margin)-50;
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cellX, cellY, cellW, cellW)];
            imageView.image = [UIImage imageNamed:imgs[i]];
            imageView.backgroundColor = [UIColor grayColor];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+i;

            
            UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchSmallImage:)];
            [imageView addGestureRecognizer:tapGes];
            
            [self addSubview:imageView];
            [self.imgs addObject:imageView];
            
            if (i==imgs.count-1) {
                
                self.itemHeight = CGRectGetMaxY(imageView.frame)+70;
                
                NSLog(@"高度为%f",self.itemHeight);
            }
        }
    }
    return self;
}
-(void)touchSmallImage:(UITapGestureRecognizer*)tap
{
    NSLog(@"这是点击的吧");
    NSInteger clickedImageView = tap.view.tag-100;
    
    NSMutableArray *items = [NSMutableArray array];
    
    UIView *fromView = nil;
    
    for (int i =0; i < self.imgs.count; i++) {
        
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        
        item.thumbView = self.imgs[i];
        
//        NSURL *url = [NSURL URLWithString:self.imgs[i]];
//        
//        item.largeImageURL = url;
        
        [items addObject:item];
        
        if (i == clickedImageView) {
            
            fromView =  self.imgs[i];
        }
    }
    YYPhotoBrowseView *groupView = [[YYPhotoBrowseView alloc]initWithGroupItems:items];
    [groupView presentFromImageView:fromView toContainer:self.superview animated:YES completion:nil];
}
@end
