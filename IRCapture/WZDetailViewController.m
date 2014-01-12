//
//  WZDetailViewController.m
//  IRCapture
//
//  Copyright (c) 2014 makoto_kw. All rights reserved.
//

#import "WZDetailViewController.h"
#import "WZSignalLog.h"

@interface WZDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation WZDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    _detailDescriptionTextView.editable = NO;

    if (_detailItem) {
        _detailDescriptionTextView.text = _detailItem.description;
    } else {
        _detailDescriptionTextView.text = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"send" style:UIBarButtonItemStylePlain target:self action:@selector(sendSignal:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    [self configureView];
    NSLog(@"%@", self.detailItem.description);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendSignal:(id)sender
{
    [_detailItem.signal sendWithCompletion:^(NSError *error) {
        NSLog(@"sent error: %@", error);
    }];
}


@end
