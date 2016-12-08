//
//  Destination_shufflingCell.h
//  MiaoYouC
//
//  Created by drupem on 16/11/30.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CurrentImageClick)(NSInteger index);

@interface Destination_shufflingCell : UITableViewCell


//时间控制器
@property (nonatomic, strong) NSTimer           *timer;
//计时器的间隔时间
@property (nonatomic, assign) CGFloat           timeInterval;
//当前图片点击的block
@property (nonatomic, copy  ) CurrentImageClick currentImageClickBlock;

/**
 *  传入照片和轮播方式,返回单击图片的回调block
 *
 *  @param imagesArray            传入本地图片或者网络图片源
 *  @param currentImageClickBlock 图片点击的回调
 */
- (void)addImagesArray:(NSArray *)imagesArray currentImageClick:(CurrentImageClick)currentImageClickBlock;

/**
 *  添加一个时间控制器(用于手动控制)
 */
- (void)addTimer;
/**
 *  清除事件控制器(用于手动控制)
 */
- (void)clearTimer;


@end
