//
//  RecipeListTableViewCell.swift
//  MyFood
//
//  Created by Georgy Kasapidi on 04.03.18.
//  Copyright © 2018 NoName. All rights reserved.
//

import UIKit
import YYWebImage

class RecipeListTableViewCell: UITableViewCell {
    @IBOutlet weak var complexityLabel: UILabel!

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        previewImage.yy_cancelCurrentImageRequest()
    }

    func configure(recipe: RecipeListInfo){
        previewImage.yy_setImage(with: recipe.previewUrl, options: .setImageWithFadeAnimation)
        timeLabel.text = recipe.duration
        complexityLabel.text = recipe.complexity
        titleLabel.text = recipe.title
    }

    
}
