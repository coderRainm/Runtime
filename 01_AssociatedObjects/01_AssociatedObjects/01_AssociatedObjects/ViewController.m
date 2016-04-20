//
//  ViewController.m
//  01_AssociatedObjects
//
//  Created by CXY on 16/4/19.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertView+AssociatedObjects.h"

typedef void (^AssociatedBock)(NSInteger);

@interface ViewController ()<UIAlertViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doCancel
{
    NSLog(@"cancel..............");
}

- (void)doContinue
{
    NSLog(@"continue...............");
}

- (IBAction)showAlertView
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Question"
                          message:@"What do you want to do?"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Continue", nil];
    __weak typeof(self) weakSelf = self;
    AssociatedBock block = ^(NSInteger buttonIndex){
        if (0 == buttonIndex) {
            [weakSelf doCancel];
        } else {
            [weakSelf doContinue];
        }
    };
    alert.associatedObject = block;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AssociatedBock block = (AssociatedBock)alertView.associatedObject;
    block(buttonIndex);
}
@end
