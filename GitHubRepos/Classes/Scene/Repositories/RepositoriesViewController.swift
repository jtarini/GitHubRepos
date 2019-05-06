//
//  RepositoriesViewController.swift
//  jtarini
//
//  Created by Juliano Tarini on 23/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import UIKit
import SVPullToRefresh
import DZNEmptyDataSet

class RepositoriesViewController: UIViewController {

  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Internal Attributes
  
  var presenter: RepositoriesPresenter!
  var commonsUI: CommonsUI!
  var repositories: [Repository]!
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeView()
    
    fetchRepositories()
  }

  // MARK: - Internal functions
  
  /**
   Initialize and customize the UI elements.
  */
  fileprivate func initializeView() {
    navigationController?.navigationBar.topItem?.title = NSLocalizedString("repositories", value: "", comment: "")
    
    tableView.tableFooterView = UIView(frame: CGRect.zero)
    tableView.cellLayoutMarginsFollowReadableWidth = false
    
    tableView.addPullToRefresh(actionHandler: {() -> Void in
      self.fetchRepositories()
    })
    
    tableView.pullToRefreshView.titleLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 12)
    tableView.pullToRefreshView.arrowColor = UIColor(red: 254 / 255, green: 85 / 255, blue: 49 / 255, alpha: 1.0)
  }
  
  /**
   Fetch repositories data.
  */
  fileprivate func fetchRepositories() {
    commonsUI.showLoading()
    
    presenter.fetchData()
  }
  
}

extension RepositoriesViewController: RepositoriesView {
  
  func showEmptyView() {
    repositories = []
    
    tableView.contentOffset = CGPoint.zero
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
    
    tableView.reloadData()
    
    commonsUI.hideLoading()
    tableView.pullToRefreshView.stopAnimating()
  }
  
  func reloadRepositories(_ repositories: [Repository]) {
    self.repositories = repositories
    
    tableView.reloadData()
    
    commonsUI.hideLoading()
    tableView.pullToRefreshView.stopAnimating()
  }
  
}
  
extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if repositories != nil {
      return repositories.count
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell") as! RepositoryTableViewCell
    
    let repository = repositories[indexPath.row]
    
    cell.name.text = repository.name
    
    return cell
  }
  
}
  
extension RepositoriesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
  
  func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
    return UIImage(named: "empty-results")
  }
  
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: NSLocalizedString("empty.repositories.message", value: "", comment: ""), attributes: [NSAttributedString.Key.font: UIFont(name: "GTEestiProDisplay-Medium", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.black])
  }
  
  func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
    return true
  }

}
