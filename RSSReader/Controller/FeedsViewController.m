//
//  TableOfFeedsViewController.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "FeedsViewController.h"
#import "FeedsView.h"
#import "FeedsModel.h"
#import "FeedsTableViewCell.h"
#import "WebPageViewController.h"

@interface FeedsViewController () <UITabBarDelegate, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate, FeedsModelDelegate> {
    BOOL firstLoad; //To Prevent Data refresh after view change
}

@property (nonatomic,strong) FeedsView *feedsView;
@property (nonatomic,strong) FeedsModel *feedsModel;
@property (nonatomic, strong) NSString *rssURL;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation FeedsViewController

- (instancetype) initWithURL:(NSString *)rssURL {
    self = [super init];
    if (self) {
        _rssURL = rssURL;
    }
    return self;
}
// MARK: Setting Up View LifeCycle
- (void) viewDidLoad {
    [super viewDidLoad];
    [self dataSetup];
    [self viewSetup];
    [self spinner];
    [self applyConstraints];
    firstLoad = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (firstLoad) {
        [_activityIndicator startAnimating];
        //Asynchronously fetching Data Using Other threads While Main Thread Display Activity Indicator
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                [self.feedsModel getJSONData];

                dispatch_async(dispatch_get_main_queue(), ^{
               //When json is loaded stop the indicator
               [self.activityIndicator stopAnimating];
               [self.feedsView.feedsTableView reloadData];
                self.navigationItem.title = self.feedsModel.rssTitle;
                });
            });
    }
    firstLoad = NO;
    
}

// MARK: Setting Up Model
- (void) dataSetup {
    _feedsModel = [[FeedsModel alloc] initWithURL:_rssURL];
    _feedsModel.delegate = self;
}

// MARK: Setting Up View
- (void) viewSetup {
    _feedsView = [[FeedsView alloc] initWithFrame:CGRectZero];
    _feedsView.translatesAutoresizingMaskIntoConstraints = NO;
    _feedsView.delegate = self;
    [self.view addSubview:_feedsView];
    
// MARK: Setting Up UINavigationBar
    UINavigationBarAppearance* navBarAppearance = [self.navigationController.navigationBar standardAppearance];
    [navBarAppearance configureWithOpaqueBackground];
    navBarAppearance.backgroundColor = UIColor.systemGray3Color;
    self.navigationController.navigationBar.standardAppearance = navBarAppearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance;

// MARK: Setting Up UITable
    _feedsView.feedsTableView.delegate = self;
    _feedsView.feedsTableView.dataSource = self;
    [_feedsView.feedsTableView registerClass:[FeedsTableViewCell class] forCellReuseIdentifier:@"FeedsCellIdentifier"];
    _feedsView.feedsTableView.rowHeight = UITableViewAutomaticDimension;
    _feedsView.feedsTableView.estimatedRowHeight = 300;
    _feedsView.tabBarView.myTabBar.delegate = self;
    [self addToTabBar];
}

// MARK: Applying Constraints
- (void) applyConstraints {
    [_feedsView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_feedsView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_feedsView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_feedsView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

// MARK: Setting Up Methods
- (void) spinner {
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    _activityIndicator.center = self.view.center;
    [self.view addSubview:_activityIndicator];
}

- (void) dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) invalidURL {
    //Using Main Thread Only
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *inValidURLAlert = [UIAlertController alertControllerWithTitle:@"Invalid URL" message:@"Please Sent RSS Link Only" preferredStyle:UIAlertControllerStyleAlert];
        [inValidURLAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){[self dismissView];}]];
        [self presentViewController:inValidURLAlert animated:YES completion:nil];
    });
}

- (void) addToTabBar {
    UITabBarItem *backButton = [[UITabBarItem alloc] initWithTitle:@"Back" image:[UIImage systemImageNamed:@"chevron.backward"] tag:1];
    [_feedsView.tabBarView.myTabBar setItems:@[backButton] animated:YES];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(item.tag == 1) {
        [self dismissView];
    }
}


// MARK: UITableView DataSource & Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedsTableViewCell *cell = [_feedsView.feedsTableView dequeueReusableCellWithIdentifier:@"FeedsCellIdentifier" forIndexPath:indexPath];
    if ([_feedsModel.readStatus[indexPath.row] isEqualToString:@"YES"]) {
        cell.backgroundColor = UIColor.systemGray5Color;
    } else {
        cell.backgroundColor = UIColor.whiteColor;
    }
    cell.feedTitle.text = _feedsModel.feedTitle[indexPath.row];
    cell.feedDescription.text = _feedsModel.feedDescription[indexPath.row];
    NSString *imageLink = _feedsModel.feedThumbnail[indexPath.row];
    NSString *imageLink2 = _feedsModel.feedThumbnail2[indexPath.row];
    if (![imageLink isEqualToString:@""]) {
        imageLink = [imageLink stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageLink]];
        cell.imageHolder.image = [UIImage imageWithData:imageData];
    } else if (![imageLink2 isEqualToString:@""]) {
        imageLink2 = [imageLink2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageLink2]];
        cell.imageHolder.image = [UIImage imageWithData:imageData];
    } else {
        cell.imageHolder.image = [UIImage imageNamed:@"logo"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _feedsModel.feeds.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Mark Cell as Read if user selected the cell
    [_feedsModel.readStatus replaceObjectAtIndex:indexPath.row withObject:@"YES"];
    [tableView reloadData];
    
    NSString *articleURL = [_feedsModel.feedLink objectAtIndex:indexPath.row];
    WebPageViewController *webpageVC = [[WebPageViewController alloc] initWithArticle:articleURL];
    webpageVC.navigationItem.title = [_feedsModel.feedTitle objectAtIndex:indexPath.row];
    webpageVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController pushViewController:webpageVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleNone) {
        NSString *status = @"YES";
        if ([_feedsModel.readStatus[indexPath.row] isEqualToString:@"YES"]) {
            status = @"NO";
        }
        [_feedsModel.readStatus replaceObjectAtIndex:indexPath.row withObject:status];
        [tableView reloadData];
    }
}

- (UISwipeActionsConfiguration *) tableView:(UITableView *)tableView
    trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* title = @"Mark As Read";
    if([_feedsModel.readStatus[indexPath.row] isEqualToString: @"YES"]) {
        title = @"Mark As Unread";
    }
    UIContextualAction *readAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:title handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self tableView:tableView commitEditingStyle:UITableViewCellEditingStyleNone forRowAtIndexPath:indexPath ];
        }];
    readAction.backgroundColor = UIColor.systemGreenColor;
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[readAction]];
    config.performsFirstActionWithFullSwipe=FALSE;
    return config;
}

@end
