//
//  ArchiveObject.m
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/17.
//  Copyright © 2016年 7M. All rights reserved.
//

#import "ArchiveObject.h"

#define STRING_NULL             @"(null)"
#define STRING_BROKEN_ARCHIVE   @"Broken Archive"

@implementation ArchiveObject

+ (instancetype)objectFromPlist:(NSDictionary *)dic archivePath:(NSString *)archivePath
{
    ArchiveObject *archive = [ArchiveObject new];
    
    if (dic && archivePath.length > 0) {
        archive.name = dic[@"Name"] ? : STRING_NULL;
        archive.version = dic[@"ApplicationProperties"][@"CFBundleShortVersionString"] ? : STRING_NULL;
        archive.bundleID = dic[@"ApplicationProperties"][@"CFBundleIdentifier"] ? : STRING_NULL;
        
        // icon file path
        NSArray *icons = dic[@"ApplicationProperties"][@"IconPaths"];
        if (icons.count > 0) {
            NSString *path = [archivePath stringByAppendingPathComponent:@"Products"];
            path = [path stringByAppendingPathComponent:icons[0]];
            archive.iconPath = path;
        }
        
        // archive path
        archive.archiveFullPath = archivePath;
        
        // creation date
        NSDate *date = dic[@"CreationDate"];
        if (date) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.timeZone = [NSTimeZone localTimeZone];
            fmt.dateFormat = @"yyyy年MM月dd日 HH:mm:ss";
            archive.buildDate = [fmt stringFromDate:date];
        }
        else {
            archive.buildDate = STRING_NULL;
        }
        
        // display name
        NSString *subPath = dic[@"ApplicationProperties"][@"ApplicationPath"];
        if (subPath) {
            NSString *path = [archivePath stringByAppendingPathComponent:@"Products"];
            path = [path stringByAppendingPathComponent:subPath];
            path = [path stringByAppendingPathComponent:@"Info.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
            if (dic) {
                archive.displayName = dic[@"CFBundleDisplayName"] ? : STRING_NULL;
            }
        }
    }
    else {
        archive.name = STRING_BROKEN_ARCHIVE;
    }
    
    return archive;
}

- (id)init
{
    self = [super init];
    if (self) {
        _name = STRING_NULL;
        _displayName = STRING_NULL;
        _version = STRING_NULL;
        _bundleID = STRING_NULL;
        _iconPath = STRING_NULL;
        _archiveFullPath = STRING_NULL;
        _buildDate = STRING_NULL;
    }
    return self;
}
@end
