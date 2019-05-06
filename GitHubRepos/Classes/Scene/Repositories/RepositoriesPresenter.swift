//
//  RepositoriesPresenter.swift
//  jtarini
//
//  Created by Juliano Tarini on 24/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

class RepositoriesPresenterImplementation: RepositoriesPresenter {
  
  var view: RepositoriesView!
  var service: RepositoryService!
  
  func fetchData() {
    service.getRepositories() { (data) in
      if let repositories = data, !repositories.isEmpty {
        self.view.reloadRepositories(repositories)
      }
      else {
        self.view.showEmptyView()
      }
    }
  }
  
}
