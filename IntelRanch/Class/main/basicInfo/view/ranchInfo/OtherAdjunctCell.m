//
//  OtherAdjunctCell.m
//  IntelRanch
//
//  Created by 流诗语 on 2017/7/5.
//  Copyright © 2017年 刘世玉. All rights reserved.
//

#import "OtherAdjunctCell.h"
#import "SudokuView.h"
@interface OtherAdjunctCell ()
{
    CGFloat cellHeight;
}
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *photoHeight;
@property (strong, nonatomic) IBOutlet UIButton *photoDelectBtn;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *videoHeight;
@property (strong, nonatomic) IBOutlet UIButton *videoDelectBtn;

@property(nonatomic,strong,readwrite)NSMutableArray * imags;
@end


@implementation OtherAdjunctCell
-(NSMutableArray *)imags
{
    if (!_imags) {
        
        _imags = [[NSMutableArray alloc] init];
    }
    return _imags;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self=  [[NSBundle mainBundle] loadNibNamed:[NSString stringWithString:NSStringFromClass([self class])] owner:self options:nil].firstObject;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
        [self addShadowToCell:_bgView];
        
        [self addSudokuView];
        
        [self.addBtn addTarget:self action:@selector(touchAddBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.photoDelectBtn addTarget:self action:@selector(touchImgDelect) forControlEvents:UIControlEventTouchUpInside];
        [self.videoDelectBtn addTarget:self action:@selector(touchVideoDelect) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *image = [UIImage imageNamed:@"ywjf"];
        self.videoView.layer.contents = (__bridge id _Nullable)(image.CGImage);
        self.videoView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
        
        self.cellHeight =  cellHeight+(self.videoView.layer.contents==nil?20:180.0f);
    }
    return self;
}
-(void)touchAddBtn
{
    self.TouchAddBlock();
}
-(void)touchImgDelect
{
    
}
-(void)touchVideoDelect
{
    
}
-(void)addShadowToCell:(UIView*)bgView
{
    bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    bgView.layer.shadowOpacity = 0.8f;
    bgView.layer.shadowOffset = CGSizeMake(0, 0);
    bgView.layer.shadowRadius = 5.0f;
}
-(void)addSudokuView
{
    CGFloat margin = 10;
    int totalColumns = 3;
    
    _photoView.userInteractionEnabled = YES;
    
    NSArray * tempArray = @[@"ywjf",@"ywjf",@"ywjf",@"ywjf"];
    
    for (int i=0; i<tempArray.count; i++) {
        
        int row = i / totalColumns;
        int col = i % totalColumns;
        CGFloat cellW = ((Width-92)-(3*margin))/3;
        CGFloat cellX = col*(margin + cellW);
        CGFloat cellY = row * (cellW+margin)+10;
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cellX, cellY, cellW, cellW)];
        imageView.image = [UIImage imageNamed:tempArray[i]];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100+i;
        
        
        UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchSmallImage:)];
        [imageView addGestureRecognizer:tapGes];
        
        [_photoView addSubview:imageView];
        [self.imags addObject:imageView];
        
        if (i==tempArray.count-1) {
            
           cellHeight = CGRectGetMaxY(imageView.frame)+10;
            
            NSLog(@"高度为%f",cellHeight);
            
            _photoHeight.constant = cellHeight;
        }
    }
}
-(void)touchSmallImage:(UITapGestureRecognizer*)tap
{
    NSInteger clickedImageView = tap.view.tag-100;

    NSMutableArray *items = [NSMutableArray array];

    UIView *fromView = nil;

    for (int i =0; i < self.imags.count; i++) {

        YYPhotoGroupItem *item = [YYPhotoGroupItem new];

        item.thumbView = self.imags[i];

//        NSURL *url = [NSURL URLWithString:self.imgs[i]];
//
//        item.largeImageURL = url;

        [items addObject:item];

        if (i == clickedImageView) {

            fromView =  self.imags[i];
        }
    }
    YYPhotoBrowseView *groupView = [[YYPhotoBrowseView alloc]initWithGroupItems:items];
    
    [groupView presentFromImageView:fromView toContainer:self.superview.superview.superview.superview animated:YES completion:nil];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end