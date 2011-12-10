//
//  ModuleDetailViewController.h
//  Timetable
//
//  Created by Ashley Connor on 02/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleDetailViewController : UIViewController {
    UILabel *moduleHeader;
    UILabel *moduleDetails;
    NSDictionary *moduleDetailsData;
}

@property (atomic, retain) IBOutlet UILabel *moduleHeader;
@property (atomic, retain) IBOutlet UILabel *moduleDetails;
@property (atomic, retain) NSDictionary *moduleDetailsData;

@end
