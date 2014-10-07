//
//  ViewController.m
//  Deprocrastinator
//
//  Created by roshan on 06/10/2014.
//  Copyright (c) 2014 learningIOS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource    >
@property NSMutableArray *toDoItems;
@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *editDoneButton;
@property int priority;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoItems = [NSMutableArray arrayWithObjects: @"Give clothes to laundry",
                                                @"Get car serviced",
                                                @"Read up on auto-layouts",
                                                @"Optimize code",
                                                @"Go to the gym",
                                                nil];

    [self.tableView setAllowsSelection:YES];
    [self.tableView setAllowsMultipleSelection:YES];


}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.toDoItems count];
}

//Task1
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];

    cell.textLabel.text = [self.toDoItems objectAtIndex:indexPath.row];
    cell.editing = YES;

       return cell;
}

//Task 2
- (IBAction)onAddButtonPressed:(UIButton *)sender {

    NSString *toDoText = self.toDoTextField.text;
    [self.toDoItems addObject:toDoText];
    NSLog(@"%@", self.toDoItems);
    [self.tableView reloadData];

}

//Task3
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexPath = indexPath;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    [self.tableView reloadData];

}

//Task4
- (IBAction)onEditButtonPressed:(UIButton *)sender {

        [self.tableView setEditing:YES];




    [sender setTitle:@"Done" forState:UIControlStateNormal];

}

//Task 4 - 5
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

            [[self.tableView cellForRowAtIndexPath:indexPath] showsReorderControl];
    [self.toDoItems removeObjectAtIndex:indexPath.row];
    NSArray *indexPathArray = [NSArray arrayWithObject:indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self.tableView setEditing:NO];

    [self.editDoneButton setTitle:@"Edit" forState:UIControlStateNormal];

}

-(IBAction)swipeToChangePriority:(UISwipeGestureRecognizer *)sender{


    if (sender.state == UIGestureRecognizerStateEnded)
        {
        CGPoint swipeLocation = [sender locationInView:self.tableView];
        NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
        UITableViewCell* swipedCell = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
        swipedCell.textLabel.textColor = [UIColor redColor];
        }

}

- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath { return YES; }
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {}



@end
