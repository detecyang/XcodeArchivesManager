//
//  ArchiveListCellView.h
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/18.
//  Copyright © 2016年 7M. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern const CGFloat kArchiveListCellViewHeight;
extern const NSString *kArchiveListColumnName;
extern const NSString *kArchiveListColumnVersion;
extern const NSString *kArchiveListColumnCreationDate;
extern const NSString *kArchiveListColumnPath;
extern const NSString *kArchiveListColumnNull;

@interface ArchiveListCellView : NSView

@property (nonatomic, copy) NSString *iconPath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *creationDate;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) void (^buttonAction)();

- (id)initWithTableColumn:(NSTableColumn *)tableColumn;

@end
