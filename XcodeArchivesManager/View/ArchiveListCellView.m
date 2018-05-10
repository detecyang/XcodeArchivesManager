//
//  ArchiveListCellView.m
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/18.
//  Copyright © 2016年 7M. All rights reserved.
//

#import "ArchiveListCellView.h"
#import "Utils.h"

const CGFloat kArchiveListCellViewHeight = 44;
const NSString *kArchiveListColumnName = @"Name";
const NSString *kArchiveListColumnVersion = @"Version";
const NSString *kArchiveListColumnCreationDate = @"Creation Date";
const NSString *kArchiveListColumnPath = @"Path";
const NSString *kArchiveListColumnNull = @"";



@interface ArchiveListCellView ()
@property (strong) NSImageView *imgView;
@property (strong) NSTextField *titleLabel;
@property (strong) NSButton *button;
@end




@implementation ArchiveListCellView

- (id)initWithTableColumn:(NSTableColumn *)tableColumn {
    self = [super initWithFrame:NSMakeRect(0, 0, tableColumn.width, kArchiveListCellViewHeight)];
    if (self) {
        if ([tableColumn.title isEqualToString:(NSString *)kArchiveListColumnName]) {
            [self initColumnName];
        }
        else if ([tableColumn.title isEqualToString:(NSString *)kArchiveListColumnVersion]) {
            [self initColumnVersion];
        }
        else if ([tableColumn.title isEqualToString:(NSString *)kArchiveListColumnCreationDate]) {
            [self initColumnCreationDate];
        }
        else if ([tableColumn.title isEqualToString:(NSString *)kArchiveListColumnPath]) {
            [self initColumnPath];
        }
        else if ([tableColumn.title isEqualToString:(NSString *)kArchiveListColumnNull]) {
            [self initColumnNull];
        }
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

#pragma mark - initialize

- (void)initColumnName {
    // icon
    _imgView = [[NSImageView alloc] initWithFrame:NSMakeRect(5, 5, kArchiveListCellViewHeight-10, kArchiveListCellViewHeight-10)];
    _imgView.wantsLayer = YES;
    _imgView.layer.backgroundColor = RGB(240,240,240).CGColor;
    _imgView.layer.borderColor = RGB(230,230,230).CGColor;
    _imgView.layer.borderWidth = 1;
    _imgView.layer.cornerRadius = 5;
    _imgView.layer.masksToBounds = YES;
    [self addSubview:_imgView];
    
    // title
    _titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(kArchiveListCellViewHeight, kArchiveListCellViewHeight/2-10, self.frame.size.width-kArchiveListCellViewHeight-10-10, 20)];
    _titleLabel.font = [NSFont systemFontOfSize:14];
    _titleLabel.textColor = [NSColor darkGrayColor];
    _titleLabel.backgroundColor = [NSColor clearColor];
    _titleLabel.autoresizingMask = NSViewWidthSizable;
    _titleLabel.selectable = NO;
    _titleLabel.editable = NO;
    _titleLabel.bordered = NO;
    [self addSubview:_titleLabel];
}

- (void)initColumnVersion {
    // title
    _titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, kArchiveListCellViewHeight/2-10, self.frame.size.width, 20)];
    _titleLabel.font = [NSFont systemFontOfSize:14];
    _titleLabel.textColor = [NSColor darkGrayColor];
    _titleLabel.backgroundColor = [NSColor clearColor];
    _titleLabel.autoresizingMask = NSViewWidthSizable;
    _titleLabel.selectable = NO;
    _titleLabel.editable = NO;
    _titleLabel.bordered = NO;
    [self addSubview:_titleLabel];
}

- (void)initColumnCreationDate {
    // title
    _titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, kArchiveListCellViewHeight/2-10, self.frame.size.width, 20)];
    _titleLabel.font = [NSFont systemFontOfSize:14];
    _titleLabel.textColor = [NSColor darkGrayColor];
    _titleLabel.backgroundColor = [NSColor clearColor];
    _titleLabel.autoresizingMask = NSViewWidthSizable;
    _titleLabel.selectable = NO;
    _titleLabel.editable = NO;
    _titleLabel.bordered = NO;
    [self addSubview:_titleLabel];
}

- (void)initColumnPath {
    // title
    _titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, kArchiveListCellViewHeight/2-10, self.frame.size.width, 20)];
    _titleLabel.font = [NSFont systemFontOfSize:14];
    _titleLabel.textColor = [NSColor darkGrayColor];
    _titleLabel.backgroundColor = [NSColor clearColor];
    _titleLabel.autoresizingMask = NSViewWidthSizable;
    _titleLabel.selectable = NO;
    _titleLabel.editable = NO;
    _titleLabel.bordered = NO;
    [self addSubview:_titleLabel];
}

- (void)initColumnNull {
    NSSize size = self.frame.size;
    _button = [[NSButton alloc] initWithFrame:NSMakeRect(size.width/2-25, size.height/2-10, 50, 20)];
    _button.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin;
    _button.title = @"Delete";
    _button.bezelStyle = NSRecessedBezelStyle;
    [_button setButtonType:NSMomentaryLightButton];
    _button.target = self;
    _button.action = @selector(buttonTapped);
    [self addSubview:_button];
}

#pragma mark - setter

- (void)setIconPath:(NSString *)iconPath {
    _iconPath = iconPath;
    _imgView.image = [[NSImage alloc] initWithContentsOfFile:iconPath];
}

- (void)setName:(NSString *)name {
    _name = name;
    _titleLabel.objectValue = name;
}

- (void)setVersion:(NSString *)version {
    _version = version;
    _titleLabel.objectValue = version;
}

- (void)setCreationDate:(NSString *)creationDate {
    _creationDate = creationDate;
    _titleLabel.objectValue = creationDate;
}

- (void)setPath:(NSString *)path {
    _path = path;
    _titleLabel.objectValue = path;
}

- (void)buttonTapped {
    if (self.buttonAction) {
        self.buttonAction();
    }
}

@end
