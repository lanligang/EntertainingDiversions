//
//  ViewController.m
//  RunCircleView
//
//  Created by ios2 on 2020/11/20.
//

#import "ViewController.h"
#import "CyCleCustomHeader.h"
#import "CycleItemViewTwo.h"

@interface ViewController ()<CycleCustomViewDataSource,CycleCustomViewDelegate>
@property (nonatomic,strong)NSArray *texts;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.cycleView.dataSource = self;
	self.cycleView.deleate = self;
	[self.cycleView registItem:[CycleItemViewTwo class] withIdentifier:@"CycleItemViewTwo"];
	self.texts = @[@"make.left.right.bottom.ma",@"make.top.equalTo(self.navView.mas_bottom);", @"self.videoTool = [VideoTool ne",
					   @"CycleCustomView *customV",
					   @"view addSubvi",
					   @"omV r",@"make.top.equalTo(self.navView.mas_bottom);", @"self.videoTool = [VideoTool ne",
					   @"CycleCustomView *customV",
					   @"view addSubvi",
					   @"omV r",@"make.top.equalTo(self.navView.mas_bottom);", @"self.videoTool = [VideoTool ne",
					   @"CycleCustomView *customV",
					   @"view addSubvi",
					   @"omV r",@"make.top.equalTo(self.navView.mas_bottom);", @"self.videoTool = [VideoTool ne",
					   @"CycleCustomView *customV",
					   @"view addSubvi",
					   @"omV r",@"make.top.equalTo(self.navView.mas_bottom);", @"self.videoTool = [VideoTool ne",
					   @"CycleCustomView *customV",
					   @"view addSubvi",
					   @"omV r",@"make.top.equalTo(self.navView.mas_bottom);", @"self.videoTool = [VideoTool ne",
					   @"CycleCustomView *customV",
					   @"view addSubvi",
					   @"omV r",@"make.top.equalTo(self.navView.mas_bottom);", @"self.videoTool = [VideoTool ne",
					   @"CycleCustomView *customV",
					   @"view addSubvi",
					   @"omV r"
	];
	[self.cycleView reloadData];
}
-(NSInteger)runItemCountWithCycleCustomView:(CycleCustomView *)cycleView
{
	return self.texts.count;
}
//运转的是那个
-(CycleItem *)cycleCustomView:(CycleCustomView *)cycleView andIndex:(NSInteger)index {
	NSString *identifier = @"CycleItemViewTwo";
	CycleItemViewTwo *item = (CycleItemViewTwo *)[cycleView dequestWithIdentifier:identifier andIndex:index];
	[item configerText:self.texts[index]];
	item.backgroundColor = self.radomColor;
	return item;
}
////宽度
-(CGFloat)runWidthWithCycleCustomView:(CycleCustomView *)cycleView
								 andIndex:(NSInteger)index {
	return [self widthWithText:self.texts[index] andFont:[UIFont systemFontOfSize:15]];
}
-(CGFloat)cycleCustomView:(CycleCustomView *)cycleView
	  itemMarginLeftWithIndex:(NSInteger)index {
	return  5 + arc4random() %30;
}
//选中的是第几个
-(void)cycleCustomView:(CycleCustomView *)cycleView
			didSeletedItem:(CycleItem *)iten
				 withIndex:(NSInteger)index {
	NSLog(@"点击了第 %@ 个",@(index));
}
//起始值的第一个间距
-(CGFloat)startItemLeftMargin:(CycleCustomView *)cycleView
{
	return CGRectGetWidth(self.view.bounds);
}

-(CGFloat)widthWithText:(NSString *)text andFont:(UIFont *)font {
	NSAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:text attributes:@{
		NSFontAttributeName:font
	}];
	CGSize size =  [abs boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 10) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
	return fabs(size.width) + 20;
}

-(UIColor *)radomColor {
	int r,g,b;
	r = arc4random() %100 + 155;
	g = arc4random() %100 + 155;
	b = arc4random() %100 + 155;
	return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:r/255.0f];
}


@end
