//
//  ViewController.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// `ArticlesViewController` is a view controller that manages and displays a list of articles and categories in a table view format.
final class ArticlesViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: ArticlesViewModelProtocol?
    
    // MARK: - Private properties
    
    private let articlesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
        viewModel?.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.articlesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        articlesTableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    
    private func fetchData() {
        viewModel?.fetchArticles()
        viewModel?.fetchCategories()
    }
    
    private func setupTableView() {
        view.addSubview(articlesTableView)
        NSLayoutConstraint.activate([
            articlesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articlesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            articlesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articlesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
            
        articlesTableView.register(ArticlesTableViewCell.self, forCellReuseIdentifier: ArticlesTableViewCell.identifier)
        articlesTableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        
        let headerView = LeclonecoinView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        articlesTableView.tableHeaderView = headerView
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        articlesTableView.estimatedRowHeight = 150
        articlesTableView.rowHeight = UITableView.automaticDimension
    }
}


// MARK: - UITableViewDataSource

extension ArticlesViewController: UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
    return 2
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : viewModel?.numberOfArticles() ?? 0
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell else {
                return UITableViewCell()
            }
        cell.categories = viewModel?.categories ?? []
        cell.onCategorySelected = { [weak self] category in
            self?.viewModel?.pushToSelectedCategoryViewConroller(category: category)
        }
        return cell
    }
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesTableViewCell.identifier, for: indexPath) as? ArticlesTableViewCell else {
        return UITableViewCell()
    }
        
    if indexPath.section == 1, let article = viewModel?.item(at: indexPath.row) {
        let category = viewModel?.category(for: article.categoryId)
        cell.configure(with: article, category: category)
    }

    return cell
}
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return UITableView.automaticDimension
        }
    }
}


    // MARK: - UITableViewDelegate

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.pushToDetailViewController(indexPath: indexPath.row)
        }
}
