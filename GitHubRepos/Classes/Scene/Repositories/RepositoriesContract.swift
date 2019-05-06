//
//  RepositoriesContract.swift
//  jtarini
//
//  Created by Juliano Tarini on 25/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import Foundation

protocol RepositoriesView: class {
  
  var presenter: RepositoriesPresenter! { get set }
  
  func reloadRepositories(_ repositories: [Repository])
  func showEmptyView()
  func showError(_ error: Error)
  
}

protocol RepositoriesPresenter {
  
  var view: RepositoriesView! { get set }
  
  func fetchData()
  
}
