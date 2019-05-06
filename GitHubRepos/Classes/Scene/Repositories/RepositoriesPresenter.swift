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
  
  fileprivate let disposeBag = DisposeBag()
  
  func fetchData() {
    let username = "jtarini"
    service.getRepositories(username)
      .asObservable()
      .subscribe { event in
        switch event {
          case .next(let repositories):
            if !repositories.isEmpty {
              self.view.reloadRepositories(repositories)
            }
            else {
              self.view.showEmptyView()
          }
          case .error(let error):
            self.view.showError(error)
            self.view.showEmptyView()
          case .completed:
            break
        }
      }
      .disposed(by: disposeBag)
  }
  
}
