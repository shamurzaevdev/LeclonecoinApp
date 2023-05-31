//
//  SelectedCategoryViewController.swift
//  LeclonecoinApp
//
//  Created by Эл on 30.05.2023.
//

import UIKit

/// A view controller responsible for displaying articles of a selected category
final class SelectedCategoryViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: SelectedCategoryViewModel?
    private var articlesViewModel: ArticlesViewModelProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = viewModel?.category.name
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
            
        tableView.register(ArticlesTableViewCell.self, forCellReuseIdentifier: ArticlesTableViewCell.identifier)
    }
    
    // MARK: - Methods

    func configure(with viewModel: SelectedCategoryViewModel?) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SelectedCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfArticles() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesTableViewCell.identifier, for: indexPath) as? ArticlesTableViewCell else {
            return UITableViewCell()
        }
        guard let article = viewModel?.articleAt(indexPath.row) else { return UITableViewCell() }
        cell.configure(with: article, category: viewModel?.category)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SelectedCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectArticle(at: indexPath.row)
            }
}
