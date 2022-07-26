//
//  MainViewController.swift
//  NewsAPI
//
//  Created by kadir on 21.07.2022.
//

import UIKit

class MainViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
  var viewModel = MainViewModel(state: MainState())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
        viewModel.fetchData()
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
    }
    
    func configureViewModel() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch change {
                case .reloadTableView:
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func showToDetail(show news: NewsPresentation) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        vc.news = news
        show(vc, sender: nil)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainCell
        cell.configure(with: viewModel.dataModel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showToDetail(show: viewModel.dataModel[indexPath.row] )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            if viewModel.testquery == "" {
                viewModel.fetchData()
            } else {
                viewModel.searchData()
            }
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text, !searchBarText.isEmpty  else { return }
        viewModel.testquery  = searchBarText
        viewModel.searchData()
    }
}
