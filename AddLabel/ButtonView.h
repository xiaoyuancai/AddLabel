//
//  buttonView.h
//  
//
//  Created by 互动 on 16/4/10.
//
//

#import <UIKit/UIKit.h>

@protocol ButtonViewDelegate <NSObject>

-(void)removeButtonView:(id)bV;

@end

@interface ButtonView : UIView

@property(nonatomic,assign)id<ButtonViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)setValue:(NSString*)tit;
@end

