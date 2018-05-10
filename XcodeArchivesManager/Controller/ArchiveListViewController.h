//
//  ArchiveListViewController.h
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/17.
//  Copyright © 2016年 7M. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ArchiveObject;
@interface ArchiveListViewController : NSViewController

@property (nonatomic, strong) NSMutableArray<ArchiveObject*> *archiveArray;

@end
