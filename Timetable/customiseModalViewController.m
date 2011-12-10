//
//  customiseModalViewController.m
//  Timetable
//
//  Created by Ashley Connor on 02/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "customiseModalViewController.h"
#import "TimeTableViewController.h"

@implementation customiseModalViewController

@synthesize timeTable, moduleSelections;

// method that takes module selections and filters against all modules, run method when dismissing modal
- (void)filterTimeTable:(NSMutableArray *)withSelections {
    
    // this is horrible but ok with small data sets
    NSMutableArray *discardedEvents = [NSMutableArray array];
    for (NSArray *day in timeTable) {
        for (NSDictionary *time in day) {
            for (NSDictionary *events in [time objectForKey:@"events"]) {
                for (NSDictionary *selection in withSelections) {
                    if ([[selection objectForKey:@"moduleCode"] isEqualToString:[events objectForKey:@"module"]]) {
                        if ([[selection objectForKey:@"selected"] boolValue] == NO) {
                            [discardedEvents addObject:events];
                       }
                   }
               }
           }
           [[time objectForKey:@"events"] removeObjectsInArray:discardedEvents];
        }
    }
}

// button press method, returns to previous view
- (IBAction)dissmissModalView:(id)sender {
    [self filterTimeTable:moduleSelections];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
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
    [self setTitle:@"Modules"];
    
    // set done button on right of nav bar, clicking returns to previous view
    UIBarButtonItem *dissmissButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dissmissModalView:)];
    self.navigationItem.rightBarButtonItem = dissmissButton;
    [dissmissButton release];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [moduleSelections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // set labels
    [[cell textLabel] setText:[[moduleSelections objectAtIndex:[indexPath row]] objectForKey:@"moduleCode"]];
    [[cell detailTextLabel] setText:[[moduleSelections objectAtIndex:[indexPath row]] objectForKey:@"moduleTitle"]];
    
    
    // display a checkmark if module is selected
    if ([[[moduleSelections objectAtIndex:[indexPath row]] objectForKey:@"selected"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
        [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
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
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    
    //if cell is selected, deselect it else select it
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[moduleSelections objectAtIndex:[indexPath row]] setObject:[NSNumber numberWithBool:YES] forKey:@"selected"];
    }
    else {
        newCell.accessoryType = UITableViewCellAccessoryNone;
        [[moduleSelections objectAtIndex:[indexPath row]] setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
