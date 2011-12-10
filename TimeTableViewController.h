//
//  TimeTableViewController.h
//  Timetable
//
//  Created by Ashley Connor on 01/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    //interface attributes
    UITableView *dayTableView;
    UILabel *yearLabel;
    UIButton *launchModalView;
    UILabel *semesterLabel;
    
    //data source attributes
    NSDictionary *timeTableDataSource;
    NSArray *daysOfWeek, *timeTable;
    NSDictionary *timeTableSemesterInfo;
    NSMutableArray *timeTableSelections;
    NSData *savedTimeTable;
}

-(NSMutableArray *)createSelectionDataModel:(NSDictionary *)withDict;

@property (atomic, retain) IBOutlet UITableView *dayTableView;
@property (atomic, retain) IBOutlet UILabel *yearLabel;
@property (atomic, retain) IBOutlet UILabel *semesterLabel;
@property (atomic, retain) UIButton *launchModalView;

@property (atomic, retain) NSDictionary *timeTableDataSource;
@property (atomic, retain) NSArray *timeTable;
@property (atomic, retain) NSDictionary *timeTableSemesterInfo;
@property (atomic, retain) NSMutableArray *timeTableSelections;

@end
