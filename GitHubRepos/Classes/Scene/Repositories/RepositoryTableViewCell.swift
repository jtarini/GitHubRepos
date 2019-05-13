//
//  RepositoryTableViewCell.swift
//  jtarini
//
//  Created by Juliano Tarini on 25/04/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var name: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    showAnimatedSkeleton()
  }
  
}
