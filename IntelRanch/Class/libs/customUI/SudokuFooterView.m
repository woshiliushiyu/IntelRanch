
//
//  SudokuFooterView.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/21.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "SudokuFooterView.h"


@interface SudokuFooterView ()
{
    NSMutableArray * imags;
}
@end


@implementation SudokuFooterView

- (instancetype)initWithImgs:(NSArray *)imgs
{
    self = [super init];
    if (self) {
        

        imags = [[NSMutableArray alloc] init];
        
        CGFloat margin = 10;
        int totalColumns = 2;
        
        for (int i=0; i<imgs.count; i++) {
            
            int row = i / totalColumns;
            int col = i % totalColumns;
            CGFloat cellW = ((Width-50)-(2*margin))/2;
            CGFloat cellX = col*(margin + cellW);
            CGFloat cellY = row * (cellW+margin+10)+10;
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cellX, cellY, cellW, cellW-20)];
            
            imageView.image = GetImage(imgs[i]);
            imageView.backgroundColor = [UIColor grayColor];
            imageView.layer.cornerRadius = 5;
            imageView.layer.masksToBounds = YES;
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+i;
            
            UILabel * lab = Label.str(@"1.牛眼睛有病,看到了吗").fnt(10.0f).color(@"186,186,188").lines(0).xywh(cellX+5,cellY+(cellW-15),cellW-10,15);
            [self addSubview:lab];
            
            UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchSmallImage:)];
            [imageView addGestureRecognizer:tapGes];
            
            [self addSubview:imageView];
            [imags addObject:imageView];
        }
    }
    return self;
}
-(void)touchSmallImage:(UITapGestureRecognizer*)tap
{
    NSInteger clickedImageView = tap.view.tag-100;
    
    NSMutableArray *items = [NSMutableArray array];
    
    UIView *fromView = nil;
    
    for (int i =0; i < imags.count; i++) {
        
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        
        item.thumbView = imags[i];
        
        [items addObject:item];
        
        if (i == clickedImageView) {
            
            fromView =  imags[i];
        }
    }
    YYPhotoBrowseView *groupView = [[YYPhotoBrowseView alloc]initWithGroupItems:items];
    
    [groupView presentFromImageView:fromView toContainer:self.superview.window animated:YES completion:nil];
    
}

@end
