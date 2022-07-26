//
//  FavoriteView.swift
//  NewsAPI
//
//  Created by kadir on 23.07.2022.
//

import UIKit

class FavoriteView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataModel: [NewsPresentation] {
        FavoriteManager.shared.favNews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    func showToDetail(show news: NewsPresentation) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        vc.news = news
        show(vc, sender: nil)
    }
    
}

extension FavoriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        cell.configure(with: dataModel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showToDetail(show: dataModel[indexPath.row] )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
