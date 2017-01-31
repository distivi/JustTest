//
//  ModelTableViewCell.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

class CarModelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var viewModel: CarModelViewModel? {
        didSet {
            self.titleLabel.text = self.viewModel?.title
        }
    }    
}
