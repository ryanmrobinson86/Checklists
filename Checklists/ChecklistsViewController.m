//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by Ryan Robinson on 3/29/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "ChecklistsViewController.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController
{
    NSString *_row0Text;
    NSString *_row1Text;
    NSString *_row2Text;
    NSString *_row3Text;
    NSString *_row4Text;
    
    BOOL _row0Checked;
    BOOL _row1Checked;
    BOOL _row2Checked;
    BOOL _row3Checked;
    BOOL _row4Checked;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _row0Text = @"Walk the Dog";
    _row1Text = @"Brush my teeth";
    _row2Text = @"Learn iOS development";
    _row3Text = @"Soccer practice";
    _row4Text = @"Eat ice cream";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    BOOL isChecked = NO;
    if(indexPath.row == 0) {
        isChecked = _row0Checked;
    } else if (indexPath.row == 1) {
        isChecked = _row1Checked;
    } else if(indexPath.row == 2) {
        isChecked = _row2Checked;
    } else if(indexPath.row == 3) {
        isChecked = _row3Checked;
    } else if(indexPath.row == 4) {
        isChecked = _row4Checked;
    }
    
    if(isChecked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    [self configureCheckmarkForCell:cell atIndexPath:indexPath];
    
    if(indexPath.row == 0){
        label.text = _row0Text;
    }else if(indexPath.row == 1){
        label.text = _row1Text;
    }else if(indexPath.row == 2){
        label.text = _row2Text;
    }else if(indexPath.row == 3){
        label.text = _row3Text;
    }else if(indexPath.row == 4){
        label.text = _row4Text;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isChecked = NO;
    
    if (indexPath.row == 0) {
        isChecked = _row0Checked;
        _row0Checked = !_row0Checked;
    } else if (indexPath.row == 1) {
        isChecked = _row1Checked;
        _row1Checked = !_row1Checked;
    } else if (indexPath.row == 2) {
        isChecked = _row2Checked;
        _row2Checked = !_row2Checked;
    } else if (indexPath.row == 3) {
        isChecked = _row3Checked;
        _row3Checked = !_row3Checked;
    } else if (indexPath.row == 4) {
        isChecked = _row4Checked;
        _row4Checked = !_row4Checked;
    }
    
    [self configureCheckmarkForCell:cell atIndexPath:indexPath];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
