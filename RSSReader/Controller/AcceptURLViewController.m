//
//  AcceptURLViewController.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "AcceptURLViewController.h"
#import "AcceptURLView.h"
#import "AcceptURLModel.h"
#import "AcceptURLTableViewCell.h"
#import "FeedsViewController.h"

@interface AcceptURLViewController () <AcceptURLViewDelegate, UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) AcceptURLView *acceptURLView;
@property (nonatomic,strong) AcceptURLModel *acceptURLModel;

@end

@implementation AcceptURLViewController

// MARK: Setting Up View LifeCycle
- (void) viewDidLoad {
    [super viewDidLoad];
    [self dataSetup];
    [self viewSetup];
    [self applyConstraints];
}

// MARK: Setting Up Model
- (void) dataSetup {
    self.acceptURLModel = [[AcceptURLModel alloc] init];
}

// MARK: Setting Up View
- (void) viewSetup {
    _acceptURLView = [[AcceptURLView alloc] initWithFrame:CGRectZero];
    _acceptURLView.translatesAutoresizingMaskIntoConstraints = NO;
    _acceptURLView.delegate = self;
    [self.view addSubview:_acceptURLView];
    
// MARK: Setting Up UITable
    _acceptURLView.urlTableView.delegate = self;
    _acceptURLView.urlTableView.dataSource = self;
    _acceptURLView.urlTableView.rowHeight = 50;
    [_acceptURLView.urlTableView registerClass:[AcceptURLTableViewCell class] forCellReuseIdentifier:@"URLCellIdentifier"];
}

// MARK: Applying Constraints
- (void) applyConstraints {
    [_acceptURLView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_acceptURLView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_acceptURLView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_acceptURLView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

// MARK: Setting Up Methods
- (void) addURLToTable {
    NSString *url = _acceptURLView.enterURLTextField.text;
    if ([url length] == 0) {
        // Clicked Button Without Typing Any Link
        UIAlertController *emptyTextFieldAlert = [UIAlertController alertControllerWithTitle:@"Empty Field" message:@"Text Field is Empty" preferredStyle:UIAlertControllerStyleAlert];
        [emptyTextFieldAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:emptyTextFieldAlert animated:YES completion:nil];
    }
    //Pasted Duplicate Link
    else if ([_acceptURLModel.listOfURL containsObject:url]) {
        UIAlertController *duplicateURLAlert = [UIAlertController alertControllerWithTitle:@"Duplicate URL" message:@"This URL Already Subscribed" preferredStyle:UIAlertControllerStyleAlert];
        [duplicateURLAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:duplicateURLAlert animated:YES completion:nil];
    }
    else {
        [_acceptURLModel.listOfURL insertObject:url atIndex:0];
        [_acceptURLView.urlTableView reloadData];
    }
    
    //To Remove Text from The TextBox after adding it to Table & Array
    _acceptURLView.enterURLTextField.text = @"";
}


// MARK: UITableView DataSource & Delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AcceptURLTableViewCell *cell = [_acceptURLView.urlTableView dequeueReusableCellWithIdentifier:@"URLCellIdentifier"];
    NSString *rssURL =  _acceptURLModel.listOfURL[indexPath.row];
    cell.url.text = rssURL;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _acceptURLModel.listOfURL.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *rssURL =  _acceptURLModel.listOfURL[indexPath.row];
    FeedsViewController *feedsVC = [[FeedsViewController alloc]initWithURL:rssURL];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedsVC];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navigationController animated:YES completion:nil];
}

//Delete Cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_acceptURLModel.listOfURL removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//Prevent Full Swipe Gesture
- (UISwipeActionsConfiguration *) tableView:(UITableView *)tableView
    trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                [self tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath ];
        }];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    config.performsFirstActionWithFullSwipe=FALSE;
    return config;
}


@end
