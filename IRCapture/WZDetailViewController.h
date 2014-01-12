//
//  WZDetailViewController.h
//  IRCapture
//
//  Copyright (c) 2014 makoto_kw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZSignalLog;

@interface WZDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) WZSignalLog *detailItem;

@property (weak, nonatomic) IBOutlet UITextView *detailDescriptionTextView;
@end
