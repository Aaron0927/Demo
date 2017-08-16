//
//  ViewController.m
//  LocalStringDemo
//
//  Created by Tronsis－mac on 17/8/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManager.h"
#import "AppDelegate.h"


#define storyboardWithName(storyboard, sid) [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:sid];


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _currentLabel.text = [LanguageManager currentLanguageString];
    
}

- (IBAction)changeLanguage:(id)sender {
    NSInteger index = 0;
    if ([[LanguageManager currentLanguageCode] isEqualToString:@"en"]) {
        index = 1;
    } else {
        index = 0;
    }
    [LanguageManager saveLanguageByIndex:index];
    // 修改完语言后需要切换根视图控制器才能生效
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    delegate.window.rootViewController = storyboardWithName(@"Main", @"VC");
    [delegate.window makeKeyAndVisible];
}


@end
