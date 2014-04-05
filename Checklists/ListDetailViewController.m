//
//  ListDetailViewController.m
//  Checklists
//
//  Created by Ryan Robinson on 4/4/14.
//  Copyright (c) 2014 RRobinson. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
{
    NSString *_iconName;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self == [super initWithCoder:aDecoder]) {
        _iconName = @"Folder";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.checklistToEdit != nil){
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
        _iconName = self.checklistToEdit.iconName;
    }
    
    self.iconImageView.image = [UIImage imageNamed:_iconName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        
        controller.delegate = self;
    }
}

- (IBAction)done
{
    if(self.checklistToEdit != nil) {
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = _iconName;
        [self.delegate listDetailViewcontroller:self didFinishEditingChecklist:self.checklistToEdit];
    } else {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = self.textField.text;
        checklist.iconName = _iconName;
        [self.delegate listDetailViewcontroller:self didFinishAddingChecklist:checklist];
    }
}

- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName
{
    _iconName = iconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
