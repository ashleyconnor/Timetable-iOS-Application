//
//  TimeTableViewController.m
//  Timetable
//
//  Created by Ashley Connor on 01/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeTableViewController.h"
#import "SBJson.h"
#import "dailyTableViewController.h"
#import "customiseModalViewController.h"

@implementation TimeTableViewController

@synthesize dayTableView, yearLabel, semesterLabel, timeTableDataSource, timeTableSemesterInfo, timeTable, timeTableSelections, launchModalView;

// creates the array used to store user selections and module info needed by modal view

-(NSMutableArray *)createSelectionDataModel:(NSDictionary *)withDict {
    
    NSString *key;
    NSMutableArray *newArray = [NSMutableArray new];
    
    // loop through module info data. create new dictionary with module code, title and boolean selection 
    for (key in [withDict allKeys]) {
        NSMutableDictionary *module = [[NSMutableDictionary new] autorelease];
        [module setObject:key forKey:@"moduleCode"];
        [module setObject:[[withDict objectForKey:key] objectForKey:@"moduleTitle"] forKey:@"moduleTitle"];
        [module setObject:[NSNumber numberWithBool:YES] forKey:@"selected"];
        [newArray addObject:module];
    }
    return [newArray autorelease];
}

// restores the timetable to it's original state
// there are other ways this could have been done, ideally serializing the timetable to disk
- (void)restoreTimeTable {
        NSURL *url = [NSURL URLWithString:@"http://www.csc.liv.ac.uk/people/trp/Teaching_Resources/COMP327/TimeTable.json"];
        NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    if (jsonString) {
        NSDictionary *someDict = [jsonString JSONValue];
        [timeTable release];
        timeTable = [someDict objectForKey:@"timetable"];
        [timeTable retain];
    }
}

//loads the data from external sources, sends data to be parsed, sets data ivars
- (void) loadTimeTableDataModel {
    
    timeTableDataSource = nil;
    
    NSURL *url = [NSURL URLWithString:@"http://www.csc.liv.ac.uk/people/trp/Teaching_Resources/COMP327/TimeTable.json"];
    NSURL *url2 = [NSURL URLWithString:@"http://www.csc.liv.ac.uk/people/trp/Teaching_Resources/COMP327/Semester1Modules.json"];
    
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSString *jsonString2 = [NSString stringWithContentsOfURL:url2 encoding:NSUTF8StringEncoding error:nil];

    if (jsonString) {
        timeTableDataSource = [jsonString JSONValue];
        [timeTableDataSource retain];
    }
    
    if (jsonString2) {
        timeTableSemesterInfo = [jsonString2 JSONValue];
        [timeTableSemesterInfo retain];
    }
    
    //chances of changing small so hardcoded
    daysOfWeek = [NSArray arrayWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", nil];
    [daysOfWeek retain];    //Retain to set title later
    
    timeTable = [timeTableDataSource objectForKey:@"timetable"];
    
    timeTableSelections = [self createSelectionDataModel:timeTableSemesterInfo];
    [timeTableSelections retain];
}

//Display modal view to allow user selections
- (IBAction)buttonPressed:(id)sender {
    
    customiseModalViewController *modal = [[customiseModalViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    //Give modal access to data models
    [self restoreTimeTable];
    [modal setModuleSelections:timeTableSelections];
    [modal setTimeTable:timeTable];
    
    UINavigationController *myNavCon = [[UINavigationController alloc] initWithRootViewController:modal];
    [modal release];
    [self presentModalViewController:myNavCon animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Only 1 section needed
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [timeTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //configure the cell
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@", [daysOfWeek objectAtIndex:[indexPath row]]]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dailyTableViewController *dailyView = [[dailyTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    //pass info to next view
    [dailyView setTitle:[daysOfWeek objectAtIndex:[indexPath row]]];
    [dailyView setSemesterModules:timeTableSemesterInfo];
    [dailyView setTimeTable:[timeTable objectAtIndex:[indexPath row]]];
    
    [self.navigationController pushViewController:dailyView animated:YES];
    [dailyView release];
    
    [dayTableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Timetable"];
        [self loadTimeTableDataModel];
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
    // set labels for week view
    [yearLabel setText:[timeTableDataSource objectForKey:@"year"]];
    [semesterLabel setText:[timeTableDataSource objectForKey:@"semester"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [daysOfWeek release];
    [timeTableSelections release];
    [timeTableDataSource release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
