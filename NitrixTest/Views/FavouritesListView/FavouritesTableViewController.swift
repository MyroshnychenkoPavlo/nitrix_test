//
//  FavouritesTableViewController.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 07.02.2024.
//

import UIKit

class FavouritesTableViewController: UIViewController {
    
    // MARK: - Private propertie
    private var dataSource: [Movie] = []
    private let viewModel: FavouritesViewModelProtocol
    
    private(set) lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        tableView.rowHeight = 132
        return tableView
    }()
    
    // MARK: - Lifecycle
    init(viewModel: FavouritesViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        configureMVVM()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = viewModel.getFavouritesMovie()
        movieTableView.reloadData()
    }
    // MARK: - Private method
    private func configureTableView() {
        view.addSubview(movieTableView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.topAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureMVVM() {
        viewModel.onCellTap = { [weak self] data in
            guard let self else { return }
            presentDetailVC(with: data)
        }
    }
    
    private func presentDetailVC(with data: FavouritesDetailsViewData) {
        let viewModel = FavouritesDetailsViewModel(data: data)
        let detailsVC = FavouritesDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension FavouritesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.configureWith(image: Constants.NetworkManager.imageBaseURL + dataSource[indexPath.row].posterPath,
                           text: dataSource[indexPath.row].title)
        return cell
    }
}

extension FavouritesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            dataSource = viewModel.deleteFromFavourites(movie: dataSource[indexPath.row])
            movieTableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(movie: dataSource[indexPath.row])
    }
}
