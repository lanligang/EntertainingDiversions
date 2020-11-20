//
//  CycleItem.h
//  cyApp
//
//  Created by ios2 on 2020/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CycleItem : UIControl
@property(nonatomic,assign)NSInteger index;

//子类可重写此方法进行自定义
-(instancetype)initWithFrame:(CGRect)frame andIdentifier:(NSString *)identifier;

-(void)addOffSetX:(CGFloat)offSetX;

@end

NS_ASSUME_NONNULL_END
