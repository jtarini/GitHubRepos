//
//  RepositoryService.swift
//  jtarini
//
//  Created by Juliano Tarini on 24/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import RxSwift
import Moya_ObjectMapper

class RepositoryService {

  typealias GetRepositoriesCompletionHandler = ([Repository]?) -> Void
  
  let disposeBag = DisposeBag()
  
  func getRepositories(completionHandler: @escaping GetRepositoriesCompletionHandler) {
    let username = "mikermcneil"
    moyaProvider.rx.request(.userRepositories(username))
      .mapArray(Repository.self)
      .subscribe { event -> Void in
        switch event {
          case .success(let repositories):
            completionHandler(repositories)
            break
          case .error(let error):
            print(error)
            completionHandler([Repository]())
          break
        }
      }.disposed(by: disposeBag)
  }
  
}
