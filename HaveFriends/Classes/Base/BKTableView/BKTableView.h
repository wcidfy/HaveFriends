//
//  BKTableView.h
//  HaveFriends
//
//  Created by lxx on 16/6/9.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKTableViewAdapter.h"

/**
 *  包装tableview，将datasource和delegate封装到adapter中
 *  将生成cell的逻辑拆分到adapter中，明确逻辑内容，减少文件中的代码长度
 */
@interface BKTableView : UIView

@property (nonatomic, strong, readonly) UITableView *dataTableView;

- (void)setAdapter:(BKTableViewAdapter *)tableViewAdapter;
- (void)refreshTableView;
-(void)ScrollBotton:(NSArray *)array;
-(void)SetSeparatorStyle;

@end
