//
//  SearchResultCell.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/16.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit
import Cosmos

class AppStoreResultCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingStarView: CosmosView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet var previewImageViews: [UIImageView]!
    
}
