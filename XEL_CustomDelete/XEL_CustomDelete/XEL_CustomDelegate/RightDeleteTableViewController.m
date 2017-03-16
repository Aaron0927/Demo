//
//  RightDeleteTableViewController.m
//  XEL_CustomDelete
//
//  Created by Tronsis－mac on 17/3/16.
//  Copyright © 2017年 Kim－pc. All rights reserved.
//

#import "RightDeleteTableViewController.h"
#import "RightDeleteTableViewCell.h"

@interface RightDeleteTableViewController () <RightDeleteTableViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *datasArray;
@end
static NSString *identifer = @"RightDeleteTableViewCell";
@implementation RightDeleteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasArray = [NSMutableArray arrayWithArray:@[@(1),
                                                   @(2),
                                                   @(3),
                                                   @(4),
                                                   @(5),
                                                   @(6)]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RightDeleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    cell.delegate = self;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _datasArray[indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除数据源
    [_datasArray removeObjectAtIndex:indexPath.row];
    //刷新cell
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didDeleteCell:(RightDeleteTableViewCell *)cell {
    [self tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[self.tableView indexPathForCell:cell]];
}


@end
