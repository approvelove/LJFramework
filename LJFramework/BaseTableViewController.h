//
//  BaseTableViewController.h
//  NEWRRT
//
//  Created by lijian on 14/11/6.
//
//

/***************************************************Notice**********************************************
 
    1、在使用分组的tableview时，您需要确保dataSource中的值和sectionArray中的值是保持一致的。
 
    2、如果您想要添加索引给tableView，那么您必须要实现方法- (void)registSectionIndex;
 
    3、该类的适用环境为该页面存在需要配置的tableview。所以当您选择继承本类时，请您确保您tableview的存在。并将该tableview注册到本类中，注册方法为调用- (void)registMainTableView:(UITableView *)aTableView needGroup:(BOOL)isGroup。
    
    4、当需要更改tableview的高度的时候，调用方法- (void)modifyTableCellHeight:(NSInteger)aTableHeight。该方法要在初始化tableview之前设置好
*/
#import "BaseViewController.h"

static NSString *reuserIdentify = @"flowCircle_Cell";

@interface BaseTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

//tableView的内容
@property (nonatomic, strong) NSArray *dataSource;  //tableView的数据源
@property (nonatomic, strong) NSArray *sectionArray;   //tableView 的索引源

//searchDisplayController的内容。该模块儿非必需
@property (nonatomic, strong) UISearchDisplayController *baseSearchDisplayController;


/**
 *	@brief	需要注册tableview的索引, 默认不添加索引
 */
- (void)registSectionIndex;

/**
 *	@brief	注册需要设置的tableView. 继承该类时，请先注册好tableview
 *
 *	@param 	aTableView 	待注册的tableview
 *
 *	@param 	isGroup   是否是分组的tableview
 *
 *	@param 	nibName   如果是导入自定义cell则需要填写nib名
 */
- (void)registMainTableView:(UITableView *)aTableView needGroup:(BOOL)isGroup nibName:(NSString *)nibName;

/**
 *	@brief	修改tableview的 cell高度
 *
 *	@param 	aTableHeight cell的新高度
 */
- (void)modifyTableCellHeight:(NSInteger)aTableHeight;

/**
 *	@brief	初始化tableView cell
 *
 *	@param 	cell 	待初始化的cell
 *	@param 	indexPath 	cell的索引
 *
 *	@return	初始化好的cell
 */
- (UITableViewCell *)drawTableView:(UITableView *)tableView cell:(UITableViewCell *)cell withIndex:(NSIndexPath *)indexPath;


//searchDisplayController

/**
 *	@brief	给一个searchBar生成一个SearchDisplayController
 *
 *	@param 	aSearchBar 	待注册的searchBar
 */
- (void)registSearchDisplayControllerWithSearchBar:(UISearchBar *)aSearchBar;

- (void)modifyTableViewNeedGroup:(BOOL)aNeed;

/**
 *	@brief	注册一个自定义的cell
 *
 *	@param 	nibName 	nib名
 */
- (void)registCellFromNibWithNibName:(NSString *)nibName;

/**
 *	@brief    添加下拉刷新
 *  @brief    刷新时的操作
 */
- (void)addRefreshHeader:(void (^)())callback;

/**
 *	@brief	添加下拉加载
 *  @brief  刷新时的操作
 */
- (void)addRefreshFooter:(void (^)())callback;

/**
 *	@brief	结束刷新
 */
- (void)endRefresh;

/**
 *	@brief	在指定的时间之后结束刷新
 *
 *	@param 	delay 	时间间隔
 */
- (void)endRefreshAfterDelay:(double)delay;

/**
 *	@brief	开始下拉刷新
 */
- (void)startHeaderRefresh;


/**
 *	@brief	开始上提刷新
 */
- (void)startFooterRefresh;

- (void)scrollToBottom;
@end
