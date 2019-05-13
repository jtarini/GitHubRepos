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
import SkeletonView

class RepositoriesViewController: UIViewController {

  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Public and internal attributes
  
  var presenter: RepositoriesPresenter!
  private var repositories: [Repository]!
  
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
    
    tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")
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
    presenter.fetchData()
  }
  
}

extension RepositoriesViewController: RepositoriesView {
  
  func reloadRepositories(_ repositories: [Repository]) {
    self.repositories = repositories
    
    tableView.reloadData()

    tableView.pullToRefreshView.stopAnimating()
  }
  
  func showEmptyView() {
    repositories = []
    
    tableView.contentOffset = CGPoint.zero
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
    
    tableView.reloadData()

    tableView.pullToRefreshView.stopAnimating()
  }
  
  func showError(_ error: Error) {
    let alert = UIAlertController(title: NSLocalizedString("general.error.message.title", value: "", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
    let ok = UIAlertAction(title: NSLocalizedString("ok", value: "", comment: ""), style: .default, handler: { (action) -> Void in
      alert.dismiss(animated: true, completion: nil)
    })
    alert.addAction(ok)
    
    present(alert, animated: true, completion: nil)
  }
  
}
  
extension RepositoriesViewController: SkeletonTableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let items = repositories else {
      return 14
    }
    
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell") as! RepositoryTableViewCell
    
    guard let items = repositories else {
      return cell
    }
    
    cell.hideSkeleton()
    
    let repository = items[indexPath.row]
    cell.name.text = repository.name
    
    return cell
  }
  
  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return "RepositoryTableViewCell"
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
