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
  
  func showEmptyView()
  func reloadRepositories(_ repositories: [Repository])
  
}

protocol RepositoriesPresenter {
  
  var view: RepositoriesView! { get set }
  
  func fetchData()
  
}
