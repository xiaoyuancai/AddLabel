//
//  buttonView.m
//  
//
//  Created by 互动 on 16/4/10.
//
//

#import "buttonView.h"

@interface ButtonView ()
@property(nonatomic,strong)UILabel* title;
@property(nonatomic,strong)UIButton* button;
@end

@implementation ButtonView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.title];
        [self addSubview:self.button];
    }
    return self;
}




-(UILabel *)title{
    if (_title) {
        return _title;
    }
    _title = [[UILabel alloc]initWithFrame:CGRectMake(headSpace, 0, 40, ButtonHeight)];
    _title.font = [UIFont systemFontOfSize:FONTSIZE];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = [UIColor grayColor];
    return _title;
}

-(UIButton *)button{
    if (_button) {
        return _button;
    }
    _button = [[UIButton alloc]initWithFrame:CGRectMake(_title.right+midleSpace, _title.top, _title.height,_title.height)];
    [_button setImage:[UIImage imageNamed:@"delete_link"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
    return _button;
    
}

-(void)removeSelf{
    [_delegate removeButtonView:self];
}
-(void)setValue:(NSString*)tit{
    CGSize size =  [self labelAutoCalculateRectWith:tit Font:[UIFont systemFontOfSize:FONTSIZE] MaxSize:CGSizeMake(SCREEN_WIDTH, ButtonHeight)];
    CGRect rect = _title.frame;
    rect.size.width = size.width;
    _title.frame  = rect;
    _title.text = tit;
    _button.frame = CGRectMake(_title.right+midleSpace, _title.top, _title.height,_title.height);
}

@end
