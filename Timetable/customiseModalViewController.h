//
//  customiseModalViewController.h
//  Timetable
//
//  Created by Ashley Connor on 02/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeTableViewController.h"

@interface customiseModalViewController : UITableViewController {
    NSArray *timeTable;
    NSMutableArray *moduleSelections;
}

- (IBAction)dissmissModalView:(id)sender;
- (void)filterTimeTable:(NSMutableArray*)withSelections;

@property (atomic, retain) NSMutableArray *moduleSelections;
@property (atomic, retain) NSArray *timeTable;

@end
