//
//  AppDelegate.m
//  XcodeArchivesManager
//
//  Created by XAM on 16/2/17.
//  Copyright © 2016年 7M. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSArray *windows = [NSApplication sharedApplication].windows;
    if (windows.count > 0) {
        NSWindow *window = windows[0];
        NSSize screen = [NSScreen mainScreen].frame.size;
        [window setFrame:NSMakeRect(screen.width/2-200, screen.height/2-300, 400, 600) display:YES];
        window.title = [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
    }
    
    // Menu
    NSMenu *mainMenu = [[NSMenu alloc] init];
    NSMenuItem *appItem = [[NSMenuItem alloc] initWithTitle:@"Application" action:Nil keyEquivalent:@""];
    [mainMenu addItem:appItem];
    NSApp.mainMenu = mainMenu;
    
    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"Application"];
    NSMenuItem *aboutItem  = [[NSMenuItem alloc] initWithTitle:@"About..." action:Nil keyEquivalent:@""];
    aboutItem.target = self;
    aboutItem.action = @selector(aboutItemTapped);
    [appMenu addItem:aboutItem];
    
    [appMenu addItem:[NSMenuItem separatorItem]];
    
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:Nil keyEquivalent:@""];
    quitItem.target = self;
    quitItem.action = @selector(quitItemTapped);
    [appMenu addItem:quitItem];
    
    [mainMenu setSubmenu:appMenu forItem:appItem];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

- (void)aboutItemTapped {
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
    alert.informativeText = [NSString stringWithFormat:@"v%@\n\nThis is a tool used to manage achives in Xcode.", version];
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
}

- (void)quitItemTapped {
    [NSApp terminate:self];
}

@end
