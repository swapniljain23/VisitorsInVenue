//
//  FSQPeopleHereTableViewController.m
//  ios-interview
//
//  Created by Samuel Grossberg on 3/17/16.
//  Copyright © 2016 Foursquare. All rights reserved.
//

#import "FSQPeopleHereTableViewController.h"
#import "ios_interview-Swift.h"

@interface FSQPeopleHereTableViewController (){
    VenueModel *mVenuleMode;
}

@end

@implementation FSQPeopleHereTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"people-here" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    mVenuleMode = [[VenueModel alloc] initWithVenueDict:jsonDictionary[@"venue"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mVenuleMode.visitors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    VisitorModel *model = [mVenuleMode.visitors objectAtIndex:indexPath.row];
    
    // Configure the cell...
    NSString *visitorName = [NSString stringWithFormat:@"%@",model.visitorName];
    NSString *timeInterval = [NSString stringWithFormat:@"%@ - %@", [model time24HrDisplayFormatWithTimeInSeconds:model.arriveTime], [model time24HrDisplayFormatWithTimeInSeconds:model.leaveTime]];
    
    if ([model isNoVisitor]){
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:visitorName attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        cell.detailTextLabel.attributedText = [[NSAttributedString alloc] initWithString:timeInterval attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    }else{
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:visitorName attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        cell.detailTextLabel.attributedText = [[NSAttributedString alloc] initWithString:timeInterval attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
