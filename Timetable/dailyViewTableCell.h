//
//  dailyViewCell.h
//  Timetable
//
//  Created by Ashley Connor on 01/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dailyViewTableCell : UITableViewCell {
    UILabel *courseLabel;
    UILabel *moduleLabel;
    UILabel *roomLabel;
    UIImageView *eventImage;
}

@property (nonatomic, retain) IBOutlet UILabel *courseLabel;
@property (nonatomic, retain) IBOutlet UILabel *moduleLabel;
@property (nonatomic, retain) IBOutlet UILabel *roomLabel;
@property (nonatomic, retain) IBOutlet UIImageView *eventImage;

@end
