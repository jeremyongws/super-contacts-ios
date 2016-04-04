//
//  ViewController.m
//  SpecialContacts
//
//  Created by Jeremy Ong on 04/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource >
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *contacts;
@end

@implementation RootViewController

- (void)viewDidLoad {
	Contact *mingXiang = [[Contact alloc] initWithName:@"Ming Xiang" andNumber:@"012547492"];
	Contact *daniel = [[Contact alloc] initWithName:@"Daniel " andNumber:@"0125474922"];
	Contact *jeremy = [[Contact alloc] initWithName:@"Jeremy " andNumber:@"0189890522"];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	// Do any additional setup after loading the view, typically from a nib.
	self.contacts = [[NSMutableArray alloc] initWithObjects:mingXiang, jeremy, daniel, nil];
	[super viewDidLoad];

}

- (IBAction)onEditButtonPressed:(id)sender {
	if ([self.tableView isEditing]){
		[self.tableView setEditing:NO];
	} else {
		[self.tableView setEditing:YES];
	}
}

- (IBAction)onSwipeRight:(id)sender {
	UITableViewCell *cell = (UITableViewCell *)[sender view];
	cell.backgroundColor = [UIColor redColor];
	cell.textLabel.backgroundColor = [UIColor redColor];
}

- (IBAction)onSwipeLeft:(id)sender {
	for (UITableViewCell *cell in [self.tableView visibleCells]){
		cell.backgroundColor = [UIColor clearColor];
		cell.textLabel.backgroundColor = [UIColor clearColor];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [[self contacts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	NSString *contactName = [[[self contacts] objectAtIndex:[indexPath row]] name];
	NSString *contactNumber = [[[self contacts] objectAtIndex:[indexPath row]] number];
	NSString *contactDetails = [[contactName stringByAppendingString:@", "] stringByAppendingString:contactNumber];
	[[cell textLabel] setText:contactDetails];
	UISwipeGestureRecognizer *gestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeRight:)];
	[gestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
	UISwipeGestureRecognizer *gestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
	[gestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];

	[cell addGestureRecognizer:gestureRecognizerRight];
	[tableView addGestureRecognizer:gestureRecognizerLeft];

	return cell;
}
- (IBAction)onPlusButtonPressed:(id)sender {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Contact" message:@"Add It" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *add = [UIAlertAction actionWithTitle:@"Add Contact" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
		Contact *contact = [[Contact alloc] initWithName:[[[alert textFields] objectAtIndex:0] text]  andNumber:[[[alert textFields] objectAtIndex:1] text]];
		[[self contacts] addObject:contact];
		[[self tableView] reloadData];
	}];
	[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		[textField setPlaceholder:@"Name"];
	}];
	 [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		 [textField setPlaceholder:@"Number"];
	 }];
	
	[alert addAction:add];
	[self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	UIAlertController *deleteController = [UIAlertController alertControllerWithTitle:@"Are you sure" message:@"you want to delete this?" preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"DELETE" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
		[self.contacts removeObjectAtIndex:[indexPath row]];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
	}];;
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
		[self.tableView setEditing:NO];
	}];;
	
	[deleteController addAction:deleteAction];
	[deleteController addAction:cancelAction];
	[self presentViewController:deleteController animated:YES completion:nil];


	
}

@end
