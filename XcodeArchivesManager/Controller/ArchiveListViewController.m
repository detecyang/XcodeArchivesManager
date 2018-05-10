//
//  ArchiveListViewController.m
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/17.
//  Copyright © 2016年 7M. All rights reserved.
//

#import "ArchiveListViewController.h"
#import "ArchiveObject.h"
#import "Utils.h"
#import "ArchiveListCellView.h"


@interface ArchiveListViewController () <
NSTableViewDataSource, NSTableViewDelegate
>
@property (strong) NSTableView *table;
@end




@implementation ArchiveListViewController

- (id)init {
    self = [super init];
    if (self) {
        self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 800, 600)];
        self.title = @"list";
        _archiveArray = [NSMutableArray array];
        
        NSSize windowSize = self.view.frame.size;
        
        // button
        NSButton *buttonDelete = [[NSButton alloc] initWithFrame:NSMakeRect(windowSize.width-90-10, 10, 90, 25)];
        buttonDelete.autoresizingMask = NSViewMinXMargin;
        buttonDelete.title = @"Delete All";
        buttonDelete.target = self;
        buttonDelete.action = @selector(buttonDeleteTapped);
        buttonDelete.bezelStyle = NSRoundedBezelStyle;
        [buttonDelete setButtonType:NSMomentaryLightButton];
        [self.view addSubview:buttonDelete];
        
        // scrollview
        NSScrollView *scroll = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 45, windowSize.width, windowSize.height - 45)];
        scroll.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        scroll.hasHorizontalScroller = YES;
        scroll.hasVerticalScroller = YES;
        [self.view addSubview:scroll];
        
        _table = [[NSTableView alloc] initWithFrame:scroll.bounds];
        _table.delegate = self;
        _table.dataSource = self;
        _table.gridStyleMask = NSTableViewSolidVerticalGridLineMask | NSTableViewSolidHorizontalGridLineMask;
        _table.gridColor = RGB(230, 230, 230);
        scroll.documentView = _table;
        
        // header
        NSArray *headWidthArray =@[@{kArchiveListColumnName           : @0.25f},
                                   @{kArchiveListColumnVersion        : @0.15f},
                                   @{kArchiveListColumnCreationDate   : @0.15f},
                                   @{kArchiveListColumnPath           : @0.3f},
                                   @{kArchiveListColumnNull           : @0.15f}];
        for (NSDictionary *dic in headWidthArray) {
            NSString *name = dic.allKeys.firstObject;
            NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:name];
            column.title = name;
            column.width = windowSize.width * [dic[name] floatValue];
            [_table addTableColumn:column];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)buttonDeleteTapped {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Do you want delete all of these archives?";
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"Cancel"];
    NSModalResponse res = [alert runModal];
    if (res == NSAlertFirstButtonReturn) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *fm = [NSFileManager defaultManager];
            NSInteger count = self.archiveArray.count;
            while ([self.archiveArray lastObject]) {
                ArchiveObject *archive = [self.archiveArray lastObject];
                [fm removeItemAtPath:archive.archiveFullPath error:nil];
                if (archive) {
                    [self.archiveArray removeObject:archive];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_table reloadData];
                NSAlert *alert = [[NSAlert alloc] init];
                alert.messageText = [NSString stringWithFormat:@"%@ archives have been deleted.", @(count)];
                [alert addButtonWithTitle:@"OK"];
                [alert runModal];
            });
        });
    }
}

- (void)setArchiveArray:(NSMutableArray<ArchiveObject *> *)archiveArray {
    _archiveArray = archiveArray;
    [_table reloadData];
}

#pragma mark - tableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.archiveArray.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return kArchiveListCellViewHeight;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    ArchiveListCellView *view = [tableView makeViewWithIdentifier:tableColumn.identifier owner:nil];
    if (!view) {
        view = [[ArchiveListCellView alloc] initWithTableColumn:tableColumn];
    }
    
    ArchiveObject *archive = self.archiveArray[row];
    
    if ([tableColumn.identifier isEqualToString:(NSString *)kArchiveListColumnName]) {
        view.iconPath = archive.iconPath;
        view.name = archive.displayName;
    }
    else if ([tableColumn.identifier isEqualToString:(NSString *)kArchiveListColumnVersion]) {
        view.version = archive.version;
    }
    else if ([tableColumn.identifier isEqualToString:(NSString *)kArchiveListColumnCreationDate]) {
        view.creationDate = archive.buildDate;
    }
    else if ([tableColumn.identifier isEqualToString:(NSString *)kArchiveListColumnPath]) {
        view.path = archive.archiveFullPath;
    }
    else if ([tableColumn.identifier isEqualToString:(NSString *)kArchiveListColumnNull]) {
        view.buttonAction = ^{
            NSAlert *alert = [[NSAlert alloc] init];
            alert.messageText = @"Do you want delete this archive?";
            [alert addButtonWithTitle:@"Yes"];
            [alert addButtonWithTitle:@"Cancel"];
            NSModalResponse res = [alert runModal];
            if (res == NSAlertFirstButtonReturn) {
                NSFileManager *fm = [NSFileManager defaultManager];
                [fm removeItemAtPath:archive.archiveFullPath error:nil];
                [self.archiveArray removeObject:archive];
                [_table reloadData];
            }
        };
    }
    
    return view;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    return YES;
}

@end
