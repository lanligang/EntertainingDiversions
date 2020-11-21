//
//  CycleCustomView.m
//  cyApp
//
//  Created by ios2 on 2020/11/16.
//

#import "CycleCustomView.h"
@interface CycleCustomView ()
@property (nonatomic,strong)NSMutableArray <CycleItem *>*itemCache;
@property (nonatomic,strong)NSMutableDictionary *itemClass;
@property(nonatomic,assign)BOOL isRun;
@end

@implementation CycleCustomView{
	CGFloat _bg_width;
	CADisplayLink *_timer;
}
- (void)awakeFromNib {
	[super awakeFromNib];
	_bg_width = CGRectGetWidth(self.frame);
	self.clipsToBounds = YES;
}
-(instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_bg_width = CGRectGetWidth(self.frame);
		self.clipsToBounds = YES;
	}
	return self;
}

-(void)startTimer {
	_timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(onTimer)];
	[_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
	if (@available(iOS 10.0,*)) {
		_timer.preferredFramesPerSecond = 40;
	}else{
		_timer.frameInterval = 1/40.0;
	}
}

-(void)stopTimer {
	if (_timer) {
		[_timer invalidate];
		_timer = nil;
	}
}
-(void)onTimer {
	NSArray *itemVs =  self.subviews;
	for (CycleItem *itemV in itemVs) {
		[itemV addOffSetX:1.0];
	}
	if ([self runCount] <=0) {
		if (self.subviews.count <=0) {
			[self stopTimer];
		}
		return;
	}
	UIView *lastV;
	CGFloat maxX;
	NSInteger lastIndex;
	[self curentLastIndex:&lastV andMaxX:&maxX andLastIndex:&lastIndex]; //从缓存中查找数据
	if (lastV) {
		if (maxX < _bg_width) {
			NSInteger currentIndex = (lastIndex + 1) % [self runCount];
			CGFloat itemWidth = [self itemWidthWithIndex:currentIndex];
			CGFloat leftMargin = [self leftMarginWithIndex:currentIndex];
			CycleItem *item =  [self checkViewWithIndex:currentIndex];
			[self addSubview:item];
			item.frame = CGRectMake(maxX + leftMargin, 0, itemWidth, CGRectGetHeight(self.bounds));
		}
	}else{
		NSInteger index = -1;
		CGFloat maxX = 0;
		while (maxX < _bg_width) {
			index ++;
			index = index%self.runCount;

			CGFloat itemWidth = [self itemWidthWithIndex:index];
			CGFloat leftMargin = (maxX == 0)?[self startItemLeftMargain]:[self leftMarginWithIndex:index];
			CycleItem *item =  [self checkViewWithIndex:index];
			[self addSubview:item];
			item.frame = CGRectMake(maxX + leftMargin, 0, itemWidth, CGRectGetHeight(self.bounds));
			maxX = CGRectGetMaxX(item.frame);
		}
	}
}
-(void)willMoveToSuperview:(UIView *)newSuperview {
	if (newSuperview) {
		if (self.isRun) {
			[self startTimer];
		}
	}else{
		[self stopTimer];
	}
	[super willMoveToSuperview:newSuperview];
}

//重新计算宽度 并清理掉所有数据
-(void)layoutSubviews {
	[super layoutSubviews];
	CGFloat w = CGRectGetWidth(self.bounds);
	if (w != _bg_width) {
		_bg_width = CGRectGetWidth(self.bounds);
		[self resetWidth]; //重新修改宽度
	}
}
-(void)resetWidth {
	[self stopTimer];
	[self.itemCache removeAllObjects]; //释放所有的数据
	for (UIView *v in self.subviews) {
		[v removeFromSuperview];
	}
	if (self.isRun) {
	  [self startTimer];
	}
}
-(void)run {
	if ([self runCount] <=0) return;
	self.isRun = YES;
	[self startTimer];
}
-(void)passue {
	self.isRun = NO;
	[self stopTimer];
}
-(void)stop {
	self.isRun = NO;
	[self resetWidth];
}
-(CycleItem *)checkViewWithIndex:(NSInteger)index {
	NSAssert([self.dataSource respondsToSelector:@selector(cycleCustomView:andIndex:)], @"cycleCustomView:andIndex: 方法 未实现");
	return [self.dataSource cycleCustomView:self andIndex:index];
}
#pragma mark - 查找最后一个View 以及最大的 x 值
-(void)curentLastIndex:(UIView **)lastView andMaxX:(CGFloat *)maxX andLastIndex:(NSInteger *)lastIndex {
	CGFloat lastX = 0;
	CycleItem *lastV = nil;
	for (CycleItem *v in self.subviews) {
		 CGFloat x = CGRectGetMaxX(v.frame);
		if (x > lastX) {
			lastV = v;
			lastX = x;
		}
	}
	if (lastV) {
		*lastView = lastV;
		*maxX = lastX;
		*lastIndex = lastV.index;
	}
}

#pragma mark - targetMethod
-(void)onClickedItem:(CycleItem*)item {
	if ([self runCount] <=0) return;
	if ([self.deleate respondsToSelector:@selector(cycleCustomView:didSeletedItem:withIndex:)]) {
		[self.deleate cycleCustomView:self didSeletedItem:item withIndex:item.index];
	}
}
#pragma mark - getter
-(NSMutableArray *)itemCache {
	if (!_itemCache) {
		_itemCache = [[NSMutableArray alloc]init];
	 }
	return _itemCache;
}
-(void)reloadData {
	[self resetWidth];
	self.isRun = ([self runCount] > 0)?YES:NO;
	if (self.isRun) {
		[self startTimer];
	}
}
#pragma mark - dataSource && delegate call method
-(NSInteger)runCount {
	NSAssert([self.dataSource respondsToSelector:@selector(runItemCountWithCycleCustomView:)], @"runItemCountWithCycleCustomView: 方法 未实现");
	return  [self.dataSource runItemCountWithCycleCustomView:self];
}

-(CGFloat)itemWidthWithIndex:(NSInteger)index
{
	if ([self.deleate respondsToSelector:@selector(runWidthWithCycleCustomView:andIndex:)]) {
		return [self.deleate runWidthWithCycleCustomView:self andIndex:index];
	}
	return CGRectGetWidth(self.bounds)/2.0;
}
-(CGFloat)leftMarginWithIndex:(NSInteger)index
{
	if ([self.deleate respondsToSelector:@selector(cycleCustomView:itemMarginLeftWithIndex:)]) {
		return [self.deleate cycleCustomView:self itemMarginLeftWithIndex:index];
	}
	return 5; //默认为 5
}
-(CGFloat)startItemLeftMargain {
	if ([self.deleate respondsToSelector:@selector(startItemLeftMargin:)]) {
		return [self.deleate startItemLeftMargin:self];
	}
	return 0;
}

-(NSMutableDictionary *)itemClass
{
	if (!_itemClass) {
		_itemClass = [[NSMutableDictionary alloc]init];
	 }
	return _itemClass;
}

//注册item类型
-(void)registItem:(Class)itemClass withIdentifier:(NSString *)idenfitier
{
	self.itemClass[idenfitier] = itemClass;
}
//外部注册Item
-(CycleItem *)dequestWithIdentifier:(NSString *)identifier andIndex:(NSInteger)index
{
	CycleItem *item = [self findItemWithIdentifier:identifier andIndex:index];
	item.alpha = 1;
	item.layer.transform = CATransform3DMakeScale(1, 1, 1);
	return item;
}
-(CycleItem *)findItemWithIdentifier:(NSString *)identifier andIndex:(NSInteger)index
{
	CycleItem *cv = nil; //找消失的 需要找左边
	for (CycleItem *v  in self.itemCache) {
		NSString *aidentifier = [v valueForKeyPath:@"reuserIdentifier"];
		if (CGRectGetMaxX(v.frame) < 0 && [aidentifier isEqualToString:identifier]) {
			cv = v;
			break;
		}
	}
	if (!cv) {
		Class c = self.itemClass[identifier]; //从注册中查对象的类
		NSAssert(c, @"请检查是否有注册该类型的重用标记符");
		cv = [[c alloc]initWithFrame:CGRectZero andIdentifier:identifier];
		[cv addTarget:self action:@selector(onClickedItem:) forControlEvents:UIControlEventTouchUpInside];
		[self.itemCache addObject:cv];
	}
	cv.index = index;
	return cv;
}

@end

