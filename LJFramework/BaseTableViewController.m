//
//  BaseTableViewController.m
//  NEWRRT
//
//  Created by lijian on 14/11/6.
//
//

#import "BaseTableViewController.h"
#import "MJRefresh.h"

@interface BaseTableViewController ()
{
    BOOL needSectionIndex;  //需不需要添加索引
    BOOL needGroup;  //是不是分组形式的tableview
    UITableView *mainTableView;
    BOOL useNib;
    int DEFAULT_TABLE_HEIGHT;
}
@end

@implementation BaseTableViewController

@synthesize dataSource,sectionArray,baseSearchDisplayController;

- (void)viewDidLoad {
    [super viewDidLoad];
    useNib = NO;
    // Do any additional setup after loading the view.
    needSectionIndex = NO;    //默认不需要索引
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//添加下拉刷新
- (void)addRefreshFooter:(void (^)())callback
{
    [mainTableView addFooterWithCallback:callback];
}

//添加上提加载
- (void)addRefreshHeader:(void (^)())callback
{
    [mainTableView addHeaderWithCallback:callback];
}
#pragma mark - 注册 tableView
- (void)registCellFromNibWithNibName:(NSString *)nibName
{
    useNib = YES;
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [mainTableView registerNib:nib forCellReuseIdentifier:reuserIdentify];
}

- (void)registMainTableView:(UITableView *)aTableView needGroup:(BOOL)isGroup nibName:(NSString *)nibName;
{
    NSAssert(aTableView, @"当你继承该类时请确保tableview的存在！");
    mainTableView = aTableView;
    if (nibName && nibName.length>0) {
        [self registCellFromNibWithNibName:nibName];
    }
    mainTableView.delegate = self;  //设置tableview的代理
    mainTableView.dataSource = self;   //设置tableview的数据源
    mainTableView.sectionIndexBackgroundColor=[UIColor clearColor];
//    if (isGroup) {
//        NSAssert(self.sectionArray && self.sectionArray.count>0 , @"您如果选用了分组模式，那么您必须确保sectionArray 有至少一个以上的值存在");
//    }
    [self modifyTableViewNeedGroup:isGroup];
}

- (void)registSectionIndex
{
    needSectionIndex = YES;
}

- (void)modifyTableCellHeight:(NSInteger)aTableHeight
{
    DEFAULT_TABLE_HEIGHT = (int)aTableHeight;
}

- (void)modifyTableViewNeedGroup:(BOOL)aNeed
{
    needGroup = aNeed;
    if (!needGroup) {
        needSectionIndex = NO;
    }
}

#pragma mark - 注册searchDisplayController
- (void)registSearchDisplayControllerWithSearchBar:(UISearchBar *)aSearchBar
{
    self.baseSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:aSearchBar contentsController:self];
    [self.baseSearchDisplayController setDelegate:self];
    [self.baseSearchDisplayController setSearchResultsDataSource:self];
    [self.baseSearchDisplayController setSearchResultsDelegate:self];
}

//**************************************************tableview*****************************************
#pragma mark - Base method for tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (needGroup) {
        if ((!self.sectionArray) || (self.sectionArray.count == 0)) {
            return 0;
        }
        return self.sectionArray.count;
    }
    else
    {
        if (self.dataSource == nil || self.dataSource.count == 0) {
            return 0;
        }
         return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!needGroup) {  //当不需要分组时，不需要给section title 赋值
        return nil;
    }
    if ((!self.sectionArray) || (self.sectionArray.count == 0)) {
        return nil;
    }
    return sectionArray[section];
}

//索引字母
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (needSectionIndex) { //如果需要索引，那么必存在分组
        NSAssert(needGroup, @"当需要索引时，必须是在分组的情况下");
        return sectionArray;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (needGroup) {  //分组情况下
        NSArray *temp = dataSource[section];
        return temp.count;
    }
    else
    {
        return dataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEFAULT_TABLE_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //该方法的可配置度较高需要在具体的子类中实现
    UITableViewCell *cell;
    if (useNib) {
        if (tableView == mainTableView) {//该处主要是为了防止内含searchDisplay的tableview
            cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentify forIndexPath:indexPath];
        }
    }
    cell = [self drawTableView:tableView cell:cell withIndex:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (needSectionIndex) {
        return index;
    }
    return 0;
}

#pragma mark -helper
- (UITableViewCell *)drawTableView:(UITableView *)tableView cell:(UITableViewCell *)cell withIndex:(NSIndexPath *)indexPath
{
    return cell;
}


//开始刷新
- (void)startHeaderRefresh
{
    [mainTableView headerBeginRefreshing];
}

- (void)startFooterRefresh
{
    [mainTableView footerBeginRefreshing];
}

//停止刷新
- (void)endRefresh
{
    [mainTableView headerEndRefreshing];
    [mainTableView footerEndRefreshing];
}

- (void)endRefreshAfterDelay:(double)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endRefresh];
    });
}

- (void)scrollToBottom
{
    float originY = fabs(mainTableView.contentSize.height - [UIScreen mainScreen].bounds.size.height);
    [mainTableView setContentOffset:CGPointMake(0, originY) animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
