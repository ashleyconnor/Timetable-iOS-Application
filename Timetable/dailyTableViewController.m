//
//  dailyTableViewController.m
//  Timetable
//
//  Created by Ashley Connor on 01/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "dailyTableViewController.h"
#import "dailyViewTableCell.h"
#import "ModuleDetailViewController.h"

@implementation dailyTableViewController

@synthesize timeTable, semesterModules;

// use nib to customise cell
- (dailyViewTableCell *)getDailyViewCellFromNib {
    dailyViewTableCell *cell = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle]
                                loadNibNamed:@"dailyViewTableCell"
                                owner:self
                                options:nil];
    for (id currentObject in topLevelObjects){
        if ([currentObject isKindOfClass:[UITableViewCell class]]) {
            cell = (dailyViewTableCell *) currentObject;
            break;
        }
    }
    return cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dailyViewTableCell *cell = [self getDailyViewCellFromNib];
    CGRect cellRect = [cell bounds];
    [[self tableView] setRowHeight:cellRect.size.height];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [timeTable count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *events = [timeTable objectAtIndex:section];
    return [[events objectForKey:@"events"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Set the header for each cell group
    return [[timeTable objectAtIndex:section] objectForKey:@"time"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"dailyViewCell";
    
    dailyViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [self getDailyViewCellFromNib];
    }
    //Configure cell
    NSArray *timeTableEvents = [[timeTable objectAtIndex:[indexPath section]] objectForKey:@"events"];
    NSDictionary *events = [timeTableEvents objectAtIndex:[indexPath row]];
    
    //Set cell labels
    [[cell moduleLabel] setText:[events objectForKey:@"module"]];
    [[cell roomLabel] setText:[events objectForKey:@"room"]];
    
    //Get and set course title from JSON Semester Data Source
    NSDictionary *moduleInfo = [semesterModules objectForKey:[events objectForKey:@"module"]];
    [[cell courseLabel] setText:[moduleInfo objectForKey:@"moduleTitle"]];
    
    // find the type of event and set the image for it
    // this is horrible please forgive me
    NSString *eventType = [events objectForKey:@"type"];
    if ([eventType isEqualToString:@"lecture"]) {
        UIImage *eventImageThumb = [UIImage imageNamed:@"lecture"];
        [[cell eventImage] setImage:eventImageThumb];
    }
    else if ([eventType isEqualToString:@"lab"]) {
        UIImage *eventImageThumb = [UIImage imageNamed:@"lab"];
        [[cell eventImage] setImage:eventImageThumb];
    }
    else if ([eventType isEqualToString:@"tutorial"]) {
        UIImage *eventImageThumb = [UIImage imageNamed:@"tutorial"];
        [[cell eventImage] setImage:eventImageThumb];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    ModuleDetailViewController *detailViewController = [[ModuleDetailViewController alloc] initWithNibName:@"ModuleDetailViewController" bundle:nil];
    
    NSArray *timeTableEvents = [[timeTable objectAtIndex:[indexPath section]] objectForKey:@"events"];
    NSDictionary *events = [timeTableEvents objectAtIndex:[indexPath row]];    
    NSDictionary *moduleInfo = [semesterModules objectForKey:[events objectForKey:@"module"]];
    
    //Pass the info needed to make a detail view
    [detailViewController setModuleDetailsData:moduleInfo];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
     
}

@end
