//
//  LeftTableViewController.m
//  XEL_CustomDelete
//
//  Created by Tronsis－mac on 17/3/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "LeftTableViewController.h"
#import "LeftTableViewCell.h"

@interface LeftTableViewController ()<LeftTableViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *datasArray;
@end
static NSString *identifier = @"LeftTableViewCell";
@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasArray = [NSMutableArray arrayWithArray:@[@(1),
                                                   @(2),
                                                   @(3),
                                                   @(4),
                                                   @(5),
                                                   @(6)]];
}

- (IBAction)editCell:(id)sender {
    self.tableView.editing = !self.tableView.editing;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _datasArray[indexPath.row]];
    
    return cell;
}

- (void)LeftTableViewCellDidDelete:(LeftTableViewCell *)cell {
    [self tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[self.tableView indexPathForCell:cell]];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据源
        [_datasArray removeObjectAtIndex:indexPath.row];
        //刷新cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
