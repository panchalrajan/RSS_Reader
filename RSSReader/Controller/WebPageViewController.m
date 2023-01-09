//
//  WebPageViewController.m
//  RSSReader
//
//  Created by Rajan Panchal on 31/12/22.
//

#import "WebPageViewController.h"
#import "WebPageModel.h"
#import "WebPageView.h"

@interface WebPageViewController () <UITabBarDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WebPageView *webPageView;
@property (nonatomic, strong) WebPageModel *webPageModel;
@property (nonatomic, strong) NSString *articleURL;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation WebPageViewController

- (instancetype)initWithArticle:(NSString *)articleURL {
    self = [super init];
    if (self) {
        _articleURL = articleURL;
    }
    return self;
}
// MARK: Setting Up View LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSetup];
    [self viewSetup];
    [self spinner];
    [self applyConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Start Showing Data
    NSURLRequest *request = [NSURLRequest requestWithURL:_webPageModel.webPageURL];
    [_webPageView.articleView loadRequest:request];
}

// MARK: Setting Up Data
- (void) dataSetup {
    _webPageModel = [[WebPageModel alloc] initWithArticleURL:_articleURL];
}

// MARK: Setting Up View
- (void) viewSetup {
    _webPageView = [[WebPageView alloc] initWithFrame:CGRectZero];
    _webPageView.translatesAutoresizingMaskIntoConstraints = NO;
    _webPageView.articleView.navigationDelegate = self;
    [self.view addSubview:_webPageView];
    
// MARK: Setting Up UINavigationBar
    UINavigationBarAppearance* navBarAppearance = [self.navigationController.navigationBar standardAppearance];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [navBarAppearance configureWithOpaqueBackground];
    navBarAppearance.backgroundColor = UIColor.systemGray3Color;
    self.navigationController.navigationBar.standardAppearance = navBarAppearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance;
    
    _webPageView.tabBarView.myTabBar.delegate = self;
    [self addToTabBar];
}

// MARK: Setting Up Constraints
- (void) applyConstraints {
    [_webPageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_webPageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_webPageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_webPageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}

// MARK: Setting Up Methods
- (void) spinner {
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    _activityIndicator.center = self.view.center;
    [self.view addSubview:_activityIndicator];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [_activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_activityIndicator stopAnimating];
}

- (void) addToTabBar {
    UITabBarItem *backButton = [[UITabBarItem alloc] initWithTitle:@"Back" image:[UIImage systemImageNamed:@"chevron.backward"] tag:1];
    [_webPageView.tabBarView.myTabBar setItems:@[backButton] animated:YES];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(item.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
