//
//  ArchiveObject.h
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/17.
//  Copyright © 2016年 7M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchiveObject : NSObject
@property (copy) NSString *name;
@property (copy) NSString *displayName;
@property (copy) NSString *version;
@property (copy) NSString *bundleID;
@property (strong) NSString *iconPath;
@property (copy) NSString *archiveFullPath;
@property (copy) NSString *buildDate;

+ (instancetype)objectFromPlist:(NSDictionary *)dic archivePath:(NSString *)archivePath;

@end
