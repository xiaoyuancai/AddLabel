//
//  LabelView.h
//  
//
//  Created by 互动 on 16/4/10.
//
//

#import <UIKit/UIKit.h>

@protocol LabelViewDelegate <NSObject>

-(void)refreshData:(NSArray*)data height:(float)height;

@end

@interface LabelView : UIView
@property(nonatomic,assign)id<LabelViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
@end
