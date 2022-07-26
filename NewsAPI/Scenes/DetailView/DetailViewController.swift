//
//  DetailViewController.swift
//  NewsAPI
//
//  Created by kadir on 22.07.2022.
//

import UIKit
import SDWebImage
import SafariServices

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var sourButton: UIButton!
    
    var favButton: UIBarButtonItem?
    
    var news: NewsPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView()
    }
    
    func setupView() {
        titleLabel.text = news?.title
        newsImage.sd_setImage(with: news?.imageURL)
        dateLabel.text = news?.publishedAt
        authorLabel.text = news?.author
        contentView.text = news?.content
    }
    
    func configureView() {
        favButton = UIBarButtonItem(image: UIImage(named: news?.isFavorite == true ? "fav" : "unFav"), style: .done, target: self, action: #selector(favTapped))
        let shareButton = UIBarButtonItem(image: UIImage(named: "share"), style: .done, target: self, action: #selector(shareTapped))

        navigationItem.rightBarButtonItems = [favButton!, shareButton]
    }
    
    @objc func favTapped(sender: UIBarButtonItem) {
        guard let news = news else { return }
        let isFavorite = FavoriteManager.shared.isFavorite(news)
        if isFavorite {
            FavoriteManager.shared.deleteNews(news)
        } else {
            FavoriteManager.shared.addFavorite(news)
        }
        
        favButton?.image = UIImage(named: !isFavorite ? "fav" : "unFav")
    }
    
    @objc func shareTapped() {
        let activityVC =  UIActivityViewController(activityItems: [news?.url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true)
    }
    
    @IBAction func sourceButtonTapped(_ sender: Any) {
        guard let url = URL(string: news?.url ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}
