//
//  AppListViewController.m
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/17.
//  Copyright © 2016年 7M. All rights reserved.
//

#import "AppListViewController.h"
#import "ArchiveObject.h"
#import "ArchiveListViewController.h"
#import "Utils.h"
#import "AppListCellView.h"



@interface AppListViewController () <
NSTableViewDataSource, NSTableViewDelegate
>
/**
 * 字典结构:
 * @{archive_name_key : archive_object_array,
 *   archive_name_key : archive_object_array,
 *   ...
 *  }
 */
@property (strong) NSMutableDictionary<NSString*, NSMutableArray<ArchiveObject*>*> *dataDictionary;
@property (strong) NSTableView *table;
@property (strong) NSTextField *status;
@end






@implementation AppListViewController

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSSize windowSize = self.view.frame.size;
    
    NSScrollView *scroll = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 25, windowSize.width, windowSize.height - 25)];
    scroll.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    scroll.hasVerticalScroller = YES;
    [self.view addSubview:scroll];
    
    _table = [[NSTableView alloc] initWithFrame:scroll.bounds];
    _table.delegate = self;
    _table.dataSource = self;
    _table.headerView = nil;
    _table.gridStyleMask = NSTableViewSolidVerticalGridLineMask | NSTableViewSolidHorizontalGridLineMask;
    _table.gridColor = RGB(230, 230, 230);
    _table.doubleAction = @selector(tableDoubleAction);
    _table.target = self;
    scroll.documentView = _table;
    
    _status = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 0, windowSize.width-20, 21)];
    _status.autoresizingMask = NSViewWidthSizable;
    _status.font = [NSFont systemFontOfSize:12];
    _status.backgroundColor = [NSColor clearColor];
    _status.textColor = [NSColor darkGrayColor];
    _status.selectable = NO;
    _status.editable = NO;
    _status.bordered = NO;
    _status.objectValue = @"Ready";
    [self.view addSubview:_status];
    
    [self loadData];
}

- (void)tableDoubleAction {
    if (self.dataDictionary.allValues.count > 0) {
        ArchiveListViewController *list = [[ArchiveListViewController alloc] init];
        list.archiveArray = self.dataDictionary[self.dataDictionary.allKeys[_table.clickedRow]];
        [self presentViewControllerAsModalWindow:list];
    }
}

- (void)loadData {
    self.dataDictionary = [NSMutableDictionary dictionary];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *basePath = [NSString stringWithFormat:@"/Users/%@/Library/Developer/Xcode/Archives/",NSUserName()];
        //archives目录下查找子目录
        NSArray *subPathArray = [fm contentsOfDirectoryAtPath:basePath error:nil];
        for (int i = 0; i < subPathArray.count; i++) {
            NSString *subPath = subPathArray[i];
            NSString *subFullPath = [basePath stringByAppendingPathComponent:subPath];
            //子目录下查找archive目录
            NSArray *archivePathArray = [fm contentsOfDirectoryAtPath:subFullPath error:nil];
            for (int j = 0; j < archivePathArray.count; j++) {
                NSString *archivePath = archivePathArray[j];
                if ([archivePath rangeOfString:@".xcarchive"].length > 0) {
                    NSString *archiveFullPath = [subFullPath stringByAppendingPathComponent:archivePath];
                    NSString *path = archiveFullPath;
                    NSString *plistPath = [path stringByAppendingPathComponent:@"Info.plist"];
                    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
                    ArchiveObject *archive = [ArchiveObject objectFromPlist:plist archivePath:path];
                    NSMutableArray<ArchiveObject*> *array = self.dataDictionary[archive.name];
                    if (!array) {
                        array = [NSMutableArray array];
                        [self.dataDictionary setObject:array forKey:archive.name];
                    }
                    [array addObject:archive];
                }
                
                // 统计进度
                float count = i / (float)subPathArray.count;
                float subCount = j / (float)archivePathArray.count;
                count += 1 / (float)subPathArray.count * subCount;
                dispatch_async(dispatch_get_main_queue(), ^{
                    _status.objectValue = [NSString stringWithFormat:@"%.0f%% completed", count*100];
                });
            }
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
            _status.objectValue = @"Done";
        });
    });
}

#pragma mark - tableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.dataDictionary.allKeys.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return kAppListCellViewHeight;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    return nil;
}

- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    AppListCellView *view = [[AppListCellView alloc] initWithFrame:NSMakeRect(0, 0, self.table.frame.size.width, kAppListCellViewHeight)];
    
    NSString *name = self.dataDictionary.allKeys[row];
    NSMutableArray *array = self.dataDictionary[name];
    if (array.count > 0) {
        ArchiveObject *archive = [array lastObject];
        view.iconPath = archive.iconPath;
        view.detail = [NSString stringWithFormat:@"BundleID: %@     %@ achive(s)", archive.bundleID, @(array.count)];
    }
    else {
        view.detail = [NSString stringWithFormat:@"%@ achive(s)", @(array.count)];
    }
    view.title = name;
    
    return view;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    return YES;
}

@end
