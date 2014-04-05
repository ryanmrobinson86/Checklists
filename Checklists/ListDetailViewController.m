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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    }
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

- (IBAction)done
{
    if(self.checklistToEdit != nil) {
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewcontroller:self didFinishEditingChecklist:self.checklistToEdit];
    } else {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = self.textField.text;
        [self.delegate listDetailViewcontroller:self didFinishAddingChecklist:checklist];
    }
}

- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}
@end
