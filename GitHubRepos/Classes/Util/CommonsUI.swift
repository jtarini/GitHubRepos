//
//  CommonsUI.swift
//  jtarini
//
//  Created by Juliano Tarini on 23/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import UIKit
import SVProgressHUD

class CommonsUI {
  
  /**
   Show loading view and networkActivityIndicator.
  */
  func showLoading() {
    DispatchQueue.main.async {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
      SVProgressHUD.setForegroundColor(UIColor.white)
      SVProgressHUD.setBackgroundColor(UIColor(red: 254 / 255, green: 85 / 255, blue: 49 / 255, alpha: 1.0))
      SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
      SVProgressHUD.show()
    }
  }
  
  /**
   Hide loading view and networkActivityIndicator.
  */
  func hideLoading() {
    DispatchQueue.main.async {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      SVProgressHUD.dismiss()
    }
  }

}
