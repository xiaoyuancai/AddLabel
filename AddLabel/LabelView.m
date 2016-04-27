 //
//  LabelView.m
//  
//
//  Created by 互动 on 16/4/10.
//
//

#import "LabelView.h"
#import "ButtonView.h"
#import "LabelField.h"

#define btn_tag 2016
@interface LabelView ()<UITextFieldDelegate,ButtonViewDelegate>
@property(nonatomic,strong)LabelField* labeF;
@property(nonatomic,strong)NSMutableArray* dataAry;
@property(nonatomic,strong)NSMutableArray* resutlData;/**<保存最后的标签数据*/

@end

@implementation LabelView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeText:) name:UITextFieldTextDidChangeNotification object:nil];
        self.backgroundColor = [UIColor clearColor];
        _dataAry = [NSMutableArray new];
        _resutlData = [NSMutableArray new];
        [self addSubview:self.labeF];
    }
    return self;
}

#pragma mark- textNotifacation
-(void)changeText:(NSNotification*)notify{
    LabelField* tmp = (LabelField*)notify.object;
    if (tmp==_labeF) {
        if (tmp.text.length>0) {
            if ([tmp.text isEqualToString:@" "]) {
                tmp.text = @"";
                tmp.label.alpha = 1;
                
            }else{
                tmp.label.alpha = 0;
            }
        }
        else{
            tmp.label.alpha = 1;
        }
    }
    
}

#pragma mark- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"text = %@",string);
    if ([string isEqualToString:@" "]&&textField.text.length>0) {
//判断是否是空字符串
        if([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
            NSLog(@"输入了空格");
            return YES;
            
        }
        
        CGSize size =  [self labelAutoCalculateRectWith:textField.text Font:[UIFont systemFontOfSize:FONTSIZE] MaxSize:CGSizeMake(self.width, ButtonHeight)];
        [self createButton:size];
        
        [_labeF removeFromSuperview];
        _labeF = nil;
        [self addSubview:self.labeF];
        [_labeF becomeFirstResponder];
        ButtonView* last = [_dataAry lastObject];
        _labeF.frame = CGRectMake(last.right+midleSpace, last.top, _labeF.width, _labeF.height);
        //折行操作
        if (_dataAry.count>0&&_labeF.right>self.width) {
            //确定labeF坐标
            ButtonView* last = [_dataAry lastObject];
            _labeF.frame = CGRectMake(headSpace, last.bottom+5, _labeF.width, _labeF.height);
            //改变主视图改变主视图frame(LableView)
            if (self.height<_labeF.bottom) {
                self.frame = CGRectMake(self.left, self.top, self.width, self.height+ViewHeight);
            }
        }
        [_delegate refreshData:_resutlData height:self.height];//刷新主视图
        
    }
    return YES;
}

#pragma mark- private method
-(void)createButton:(CGSize)size{
    ButtonView* tmp = [_dataAry lastObject];
    float width = headSpace+size.width+midleSpace+15/*图片尺寸*/+endSpace;
    ButtonView* button = [[ButtonView alloc]initWithFrame:CGRectMake(tmp?tmp.right+midleSpace:headSpace,tmp?tmp.top:BTopSpace , width, ButtonHeight)];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button setValue:_labeF.text];
    [self addSubview:button];
    button.delegate = self;
    //重新排序时用到
    if (_dataAry.count==0) {
        button.tag = 0+btn_tag;
    }else
        button.tag = _dataAry.count+btn_tag;
    NSLog(@"wif = %f",button.right);
    //保存创建按键
    [_dataAry addObject:button];
    [_resutlData addObject:_labeF.text];
    //折行操作
    if (_dataAry.count>0&&button.right>self.width) {
        button.frame = CGRectMake(headSpace, tmp.bottom+5, width, tmp.height);
        //改变主视图frame(LableView)
        if (button.bottom>self.height) {
            self.frame = CGRectMake(self.left, self.top, self.width, self.height+ViewHeight);
        }
        [_dataAry removeLastObject];
        [_dataAry addObject:button];
    }
    
}


-(void)freshUi:(ButtonView*)bv{
    for (long i = bv.tag-btn_tag; i<_dataAry.count; i++) {
        
        ButtonView* tmp = [_dataAry objectAtIndex:i];
        ButtonView* last = nil;
        if (i!=0) {
            last = [_dataAry objectAtIndex:i-1];//这里注意找到删除视力之前的视图
        }else{//表示删除第一个
            last = bv;
            last.frame = CGRectMake(0, bv.top, 0, 0);
        }

        tmp.frame = CGRectMake(last?last.right+midleSpace:headSpace,last?last.top:tmp.top, tmp.width, tmp.height);
        tmp.tag = tmp.tag-1;
        if (tmp.right>self.width) {
            tmp.frame = CGRectMake(headSpace, tmp.bottom+5, tmp.width, tmp.height);//headSpace有问题
        }
        bv = tmp;
    }
    
    ButtonView* last = [_dataAry lastObject];
    _labeF.frame = CGRectMake(last.right+midleSpace, last.top, _labeF.width, _labeF.height);
    //折行操作
    if (_labeF.right>self.width) {
        //确定labeF坐标
        _labeF.frame = CGRectMake(headSpace, last.bottom+5, _labeF.width, _labeF.height);
        //改变主视图改变主视图frame(LableView)
        if (self.height<_labeF.bottom) {
            self.frame = CGRectMake(self.left, self.top, self.width, self.height+ViewHeight);
        }
    }else{
        //改变主视图frame(LableView)
        if (self.height-_labeF.bottom>20) {
            self.frame = CGRectMake(self.left, self.top, self.width, self.height-20);
        }else
        self.frame = CGRectMake(self.left, self.top, self.width, self.height);
    }
    [_delegate refreshData:_resutlData height:self.height];//刷新主视图
}

#pragma mark - ButtonViewDelegate
-(void)removeButtonView:(id)bV{
    ButtonView* buttonV = (ButtonView*)bV;
    [buttonV removeFromSuperview];
    [_dataAry removeObjectAtIndex:buttonV.tag-btn_tag];
    [_resutlData removeObjectAtIndex:buttonV.tag - btn_tag ];
    [self freshUi:buttonV];
}

#pragma mark- getter and setter
-(UITextField *)labeF{
    if (_labeF) {
        return _labeF;
    }
    _labeF = [[LabelField alloc]initWithFrame:CGRectMake(headSpace, BTopSpace, 160, ButtonHeight)];
    _labeF.font = [UIFont systemFontOfSize:FONTSIZE];
    _labeF.textColor = [UIColor blackColor];
    _labeF.delegate = self;
    //    _labeF.placeholder = @"输入标签，使用空格隔开";
    return _labeF;
}
@end



