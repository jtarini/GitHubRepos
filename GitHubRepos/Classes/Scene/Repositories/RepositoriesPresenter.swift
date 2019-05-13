//
//  RepositoriesPresenter.swift
//  jtarini
//
//  Created by Juliano Tarini on 24/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import RxSwift

class RepositoriesPresenterImplementation: RepositoriesPresenter {
  
  var view: RepositoriesView!
  var service: RepositoryService!
  
  private let disposeBag = DisposeBag()
  
  func fetchData() {
    let username = "mikermcneil"

    service.getRepositories(username)
      .subscribe { event in
        switch event {
          case .success(let repositories):
            if !repositories.isEmpty {
              self.view.reloadRepositories(repositories)
            }
            else {
              self.view.showEmptyView()
            }
          case .error(let error):
            self.view.showError(error)
            self.view.showEmptyView()
          }
      }
      .disposed(by: disposeBag)
  }
  
}
