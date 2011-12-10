//
//  dailyTableViewController.h
//  Timetable
//
//  Created by Ashley Connor on 01/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dailyTableViewController : UITableViewController {
    NSArray *timeTable;
    NSDictionary *semesterModules;
}

@property (atomic, retain) NSArray *timeTable;
@property (atomic, retain) NSDictionary *semesterModules;

@end
