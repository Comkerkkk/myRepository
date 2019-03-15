//
//  NewsViewController.m
//  枣
//
//  Created by Comker on 2019/2/23.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

@implementation NewsViewController

//计算标题label高度
-(CGFloat)titleHeight{
    if(_titleHeight==0){

        //文本宽度
        CGFloat textW=CGRectGetWidth([UIScreen mainScreen].bounds);
        
        //文本样式字典
        NSDictionary *textAttr=@{NSFontAttributeName:[UIFont systemFontOfSize:19]};
        
        //文本最大尺寸限制
        CGSize textMaxSize=CGSizeMake(textW, MAXFLOAT);
        
        //计算高度
        CGFloat textH=[self.t boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size.height;
        _titleHeight=textH;
    }
    return _titleHeight;
}


//计算时间label高度
-(CGFloat)timeHeight{
    if(_timeHeight==0){
        
        
        CGFloat textW=CGRectGetWidth([UIScreen mainScreen].bounds);
        NSDictionary *textAttr=@{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGSize textMaxSize=CGSizeMake(textW, MAXFLOAT);
        CGFloat textH=[self.time boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size.height;
        _timeHeight=textH;
    }
    return _timeHeight;
}

//计算内容label高度
-(CGFloat)contentHeight{
    if(_contentHeight==0){
        
        
        CGFloat textW=CGRectGetWidth([UIScreen mainScreen].bounds);
        NSDictionary *textAttr=@{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGSize textMaxSize=CGSizeMake(textW, MAXFLOAT);
        CGFloat textH=[self.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size.height;
        _contentHeight=textH;
    }
    return _contentHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timeLabel.text=self.time;
    self.titleLabel.text=self.t;
    self.contentLabel.text=self.content;
    NSLog(@"%f",self.titleHeight);
    NSLog(@"%f",self.timeHeight);
    NSLog(@"%f",self.contentHeight);
   
    //对内容高度进行适配
    self.height.constant=(60+self.titleHeight+self.contentHeight)*0.5-0.5*self.view.bounds.size.height;
}

//控制tabBar隐藏和出现
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}
@end
