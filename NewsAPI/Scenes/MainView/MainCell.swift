//
//  MainCell.swift
//  NewsAPI
//
//  Created by kadir on 21.07.2022.
//

import UIKit
import SDWebImage

class MainCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with viewModel: NewsPresentation) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.subTitle
        newsImage?.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(named: "appcent"))
    }

}
