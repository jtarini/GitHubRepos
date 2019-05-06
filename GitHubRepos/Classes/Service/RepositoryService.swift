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

  typealias GetRepositoriesCompletionHandler = Single<[Repository]>
  
  func getRepositories(_ username: String) -> GetRepositoriesCompletionHandler {
    return moyaProvider.rx.request(.userRepositories(username))
      .mapArray(Repository.self)
  }
  
}
