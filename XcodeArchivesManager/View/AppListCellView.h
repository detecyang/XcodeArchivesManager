//
//  AppListCellView.h
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/18.
//  Copyright © 2016年 7M. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern const CGFloat kAppListCellViewHeight;

@interface AppListCellView : NSTableRowView
@property (nonatomic, copy) NSString *iconPath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@end
