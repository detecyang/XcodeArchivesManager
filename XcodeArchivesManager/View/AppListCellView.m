//
//  AppListCellView.m
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/18.
//  Copyright © 2016年 7M. All rights reserved.
//

#import "AppListCellView.h"
#import "Utils.h"

const CGFloat kAppListCellViewHeight = 60;

@interface AppListCellView ()
@property (strong) NSImageView *imgView;
@property (strong) NSTextField *titleLabel;
@property (strong) NSTextField *detailLabel;
@end



@implementation AppListCellView

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        NSSize cellSize = frameRect.size;
        // icon
        _imgView = [[NSImageView alloc] initWithFrame:NSMakeRect(10, 10, cellSize.height-20, cellSize.height-20)];
        _imgView.wantsLayer = YES;
        _imgView.layer.backgroundColor = RGB(240,240,240).CGColor;
        _imgView.layer.borderColor = RGB(230,230,230).CGColor;
        _imgView.layer.borderWidth = 1;
        _imgView.layer.cornerRadius = 5;
        _imgView.layer.masksToBounds = YES;
        [self addSubview:_imgView];
        
        // title
        _titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(cellSize.height, 10, cellSize.width-cellSize.height-10, 25)];
        _titleLabel.font = [NSFont systemFontOfSize:14];
        _titleLabel.textColor = [NSColor darkGrayColor];
        _titleLabel.backgroundColor = [NSColor clearColor];
        _titleLabel.autoresizingMask = NSViewWidthSizable;
        _titleLabel.selectable = NO;
        _titleLabel.editable = NO;
        _titleLabel.bordered = NO;
        [self addSubview:_titleLabel];
        
        // detail
        _detailLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(cellSize.height, 35, cellSize.width-cellSize.height-10, 15)];
        _detailLabel.font = [NSFont systemFontOfSize:12];
        _detailLabel.textColor = RGB(180,180,180);
        _detailLabel.backgroundColor = [NSColor clearColor];
        _detailLabel.autoresizingMask = NSViewWidthSizable;
        _detailLabel.selectable = NO;
        _detailLabel.editable = NO;
        _detailLabel.bordered = NO;
        [self addSubview:_detailLabel];
    }
    return self;
}

#pragma mark - setter

- (void)setIconPath:(NSString *)iconPath {
    _iconPath = iconPath;
    _imgView.image = [[NSImage alloc] initWithContentsOfFile:iconPath];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.objectValue = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    _detailLabel.objectValue = detail;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
