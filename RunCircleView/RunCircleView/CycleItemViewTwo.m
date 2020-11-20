//
//  CycleItemViewTwo.m
//  cyApp
//
//  Created by ios2 on 2020/11/20.
//

#import "CycleItemViewTwo.h"

@implementation CycleItemViewTwo{
	UILabel * _lable;
}

-(instancetype)initWithFrame:(CGRect)frame andIdentifier:(NSString *)identifier
{
	self = [super initWithFrame:frame andIdentifier:identifier];
	if (self) {
		UILabel *lable = [[UILabel alloc]init];
		lable.textAlignment = NSTextAlignmentCenter;
		lable.font =[UIFont systemFontOfSize:15];
		lable.textColor = [UIColor blackColor];
		[self addSubview:lable];
		_lable = lable;

		self.backgroundColor = [UIColor redColor];
	}
	return self;
}
-(void)layoutSubviews
{
	[super layoutSubviews];
	_lable.frame = self.bounds;
}
-(void)configerText:(NSString *)text {
	_lable.text = text;
}


@end
