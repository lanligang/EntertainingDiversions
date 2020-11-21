//
//  CycleItem.m
//  cyApp
//
//  Created by ios2 on 2020/11/20.
//
#import "CycleItem.h"
@interface CycleItem()
@property (nonatomic,strong)NSString *reuserIdentifier;
@end


@implementation CycleItem

-(instancetype)initWithFrame:(CGRect)frame andIdentifier:(NSString *)identifier {
	self = [super initWithFrame:frame];
	if (self) {
		[self configerSet];
		self.reuserIdentifier = identifier;
	}
	return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self configerSet];
	}
	return self;
}
-(void)configerSet {
	self.index = -1; //默认索引值 为 -1;
	self.backgroundColor = [UIColor whiteColor];
	self.clipsToBounds = YES;
}
//修改偏移量
-(void)addOffSetX:(CGFloat)offSetX {
	CGRect rect = self.frame;
	rect.origin.x -= offSetX * 2;
	self.frame = rect;
	if (CGRectGetMaxX(self.frame) < 0) { //如果比 0 还小 自动移除
		[self removeFromSuperview];
	}
}

-(void)throwAwaySelf
{
	[UIView animateWithDuration:2 animations:^{
		self.alpha = 0;
		self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
	} completion:^(BOOL finished) {
		if (finished) {
			CGRect rect = self.frame;
			rect.origin.x =  - CGRectGetWidth(rect) - 1;
			[self addOffSetX:1.0];
		}
	}];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
	if (newSuperview) {
		self.alpha = 1;
		self.layer.transform = CATransform3DMakeScale(1, 1, 1);
	}
}


@end
