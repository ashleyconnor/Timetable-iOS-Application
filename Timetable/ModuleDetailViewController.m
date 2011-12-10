//
//  ModuleDetailViewController.m
//  Timetable
//
//  Created by Ashley Connor on 02/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ModuleDetailViewController.h"

@implementation ModuleDetailViewController

@synthesize moduleHeader, moduleDetails, moduleDetailsData;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set labels
    [self setTitle:[moduleDetailsData objectForKey:@"moduleCode"]];
    [moduleHeader setText:[moduleDetailsData objectForKey:@"moduleTitle"]];
    [moduleDetails setText:[moduleDetailsData objectForKey:@"moduleDescription"]];
    
    //resize label to fit content
    [moduleDetails setNumberOfLines:0];
    [moduleDetails setFrame:CGRectMake(20, 80, 280, 800)];
    [moduleDetails sizeToFit];
    
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
