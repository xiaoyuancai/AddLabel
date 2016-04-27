//
//  LabelField.m
//  
//
//  Created by 互动 on 16/4/22.
//
//

#import "LabelField.h"

@interface LabelField ()
@end

@implementation LabelField
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
        _label.font = [UIFont systemFontOfSize:FONTSIZE];
        _label.textColor = [UIColor grayColor];
         _label.text = @"输入标签，使用空格隔开";
        _label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_label];
    }
    return self;
}
@end
