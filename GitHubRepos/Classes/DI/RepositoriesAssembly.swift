//
//  RepositoriesAssembly.swift
//  jtarini
//
//  Created by Juliano Tarini on 24/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class RepositoriesAssembly: Assembly {
  
  func assemble(container: Container) {
    container.storyboardInitCompleted(RepositoriesViewController.self) { r, c in
      c.presenter = r.resolve(RepositoriesPresenter.self)
      c.commonsUI = r.resolve(CommonsUI.self)
      c.presenter.view = c
    }
    
    container.register(RepositoriesPresenter.self) { _ in RepositoriesPresenterImplementation() }
      .initCompleted { r, c in
        let repositoriesPresenter = c as! RepositoriesPresenterImplementation
        repositoriesPresenter.service = r.resolve(RepositoryService.self)
      }
      .inObjectScope(.container)
    
    container.register(RepositoryService.self) {_ in RepositoryService() }
      .inObjectScope(.container)
    
    container.register(CommonsUI.self) { _ in CommonsUI() }
      .inObjectScope(.container)
  }
  
}
