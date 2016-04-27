//
//  LabelField.h
//  
//
//  Created by 互动 on 16/4/22.
//
//

#import <UIKit/UIKit.h>

@interface LabelField : UITextField
@property(nonatomic,strong)UILabel* label;
-(instancetype)initWithFrame:(CGRect)frame;
@end
