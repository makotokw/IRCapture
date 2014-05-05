//
//  WZMasterViewController.m
//  IRCapture
//
//  Copyright (c) 2014 makoto_kw. All rights reserved.
//

#import "WZMasterViewController.h"
#import "WZDetailViewController.h"
#import "WZSignalLog.h"

#import <IRKit/IRHTTPClient.h>
#import <TMCache/TMCache.h>

@interface WZMasterViewController () <IRNewPeripheralViewControllerDelegate> {
    IRHTTPClient *_httpClient;
    NSMutableArray *_objects;
    NSDateFormatter *_dateFormatter;
}
@end

@implementation WZMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _objects = [NSMutableArray array];
    [self loadLogs];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *langs = [NSLocale preferredLanguages];
    if (langs.count) {
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:langs[0]];
    }
    _dateFormatter.dateFormat = @"Y/M/d(EEE) HH:mm:ss.SSSS";
	
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearAllObject:)];
    self.navigationItem.rightBarButtonItem = clearButton;
    
    self.detailViewController = (WZDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // find IRKit if none is known
    if ([IRKit sharedInstance].countOfReadyPeripherals == 0) {
        
        __weak WZMasterViewController *me = self;
        
        IRNewPeripheralViewController *vc = [[IRNewPeripheralViewController alloc] init];
        vc.delegate = self;
        [self presentViewController:vc
                           animated:YES
                         completion:^{
                             [me startCapturing];
                         }];
    } else {
        [self startCapturing];
    }
}

- (void)startCapturing
{
    if ([IRKit sharedInstance].countOfReadyPeripherals == 0) {
        return;
    }
    
    __weak WZMasterViewController *me = self;
    if (!_httpClient) {
        _httpClient = [IRHTTPClient waitForSignalWithCompletion:^(NSHTTPURLResponse *res, IRSignal *signal, NSError *error) {
            if (signal) {
                [me didReceiveSignal:signal];
            }
        }];
    }
}

- (void)didReceiveSignal:(IRSignal *)signal
{
    WZSignalLog *log = [[WZSignalLog alloc] initWithSignal:signal];
    [_objects insertObject:log atIndex:0];
    [self.tableView reloadData];
    [self saveLog];
    
    NSLog( @"signal: %@", log );
    
    _httpClient = nil;
    __weak WZMasterViewController *me = self;
    [self bk_performBlock:^(id obj) {
        [me startCapturing];
    } afterDelay:1];
}

- (void)clearAllObject:(id)sender
{
    [_objects removeAllObjects];
    [self.tableView reloadData];
    
    [self deleteLogs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    WZSignalLog *object = _objects[indexPath.row];
    
    cell.textLabel.text = [_dateFormatter stringFromDate:object.date];
    cell.detailTextLabel.text = object.signalDataString;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        WZSignalLog *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WZSignalLog *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - IRNewPeripheralViewControllerDelegate

- (void)newPeripheralViewController:(IRNewPeripheralViewController *)viewController
            didFinishWithPeripheral:(IRPeripheral *)peripheral
{
    NSLog( @"peripheral: %@", peripheral );
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 NSLog(@"dismissed");
                             }];
}

#pragma mark - Save Log

- (void)saveLog
{
    [[TMCache sharedCache] setObject:_objects forKey:@"signalLog"];
}

- (void)loadLogs
{
    NSArray *logs = [[TMCache sharedCache] objectForKey:@"signalLog"];
    if (logs.count > 0) {
        [_objects addObjectsFromArray:logs];
    }
}

- (void)deleteLogs
{
    [[TMCache sharedCache] removeObjectForKey:@"signalLog"];
}


@end
