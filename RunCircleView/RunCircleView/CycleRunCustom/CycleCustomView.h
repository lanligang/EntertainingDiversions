//
//  CycleCustomView.h
//  cyApp
//
//  Created by ios2 on 2020/11/16.
//

#import <UIKit/UIKit.h>
#import "CycleItem.h"

NS_ASSUME_NONNULL_BEGIN
@class CycleCustomView;
@protocol CycleCustomViewDataSource <NSObject>

@required
/** 返回数据个数 */
-(NSInteger)runItemCountWithCycleCustomView:(CycleCustomView *)cycleView;
/* 添加子控件以及一些其他数据 */
-(CycleItem *)cycleCustomView:(CycleCustomView *)cycleView andIndex:(NSInteger)index;

@end

@protocol CycleCustomViewDelegate <NSObject>
@optional
/* 返回每个的宽度 默认是一半的宽度 */
-(CGFloat)runWidthWithCycleCustomView:(CycleCustomView *)cycleView
							 andIndex:(NSInteger)index;
/** 返回第二个的间距 默认为 5 */
-(CGFloat)cycleCustomView:(CycleCustomView *)cycleView itemMarginLeftWithIndex:(NSInteger)index;

/** 点击了第几个 */
-(void)cycleCustomView:(CycleCustomView *)cycleView didSeletedItem:(CycleItem *)item withIndex:(NSInteger)index;
/** 起始时的相对位置 默认为 0*/
-(CGFloat)startItemLeftMargin:(CycleCustomView *)cycleView;

@end

@interface CycleCustomView : UIView

@property(nonatomic,weak)id <CycleCustomViewDataSource>dataSource;
@property(nonatomic,weak)id <CycleCustomViewDelegate>deleate;

//注册item类型
-(void)registItem:(Class /** CycleItem class*/ )itemClass withIdentifier:(NSString *)idenfitier;
//查找item
-(CycleItem *)dequestWithIdentifier:(NSString *)identifier andIndex:(NSInteger)index;
//暂停
-(void)passue;
//没有数据将不会运行
-(void)run;

//解决重新启动后前后数据不一致的问题
-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
