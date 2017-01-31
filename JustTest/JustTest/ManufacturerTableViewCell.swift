//
//  ManufacturerTableViewCell.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

class ManufacturerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    weak var viewModel: ManufacturerTableViewCellModel? {
        didSet {
            self.titleLabel.text = viewModel?.title
        }
    }
}
