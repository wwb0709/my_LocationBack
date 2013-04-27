//
//  OneViewController.m
//  Notification
//
//  Created by KangQiJun My on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OneViewController.h"

@implementation OneViewController

@synthesize m_label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
        //显示导航栏
    [self.navigationController setNavigationBarHidden:NO];
        //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 100)];
    [label setBackgroundColor:[UIColor blackColor]];
    label.font = [UIFont boldSystemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    self.m_label = label;
    [self.view addSubview:label];
    [label release];
}

-(void)setLabelText:(NSString *)str{
    m_label.text = str;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
