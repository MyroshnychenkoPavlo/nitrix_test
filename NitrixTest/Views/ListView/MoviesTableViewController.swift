//
//  MoviesTableViewController.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 06.02.2024.
//

import UIKit

// MARK: - MoviesTableViewController
class MoviesTableViewController: UITableViewController {
    
    // MARK: - Private propertie
    private var dataSource: [Movie] = []
    private let viewModel: MoviesViewModelProtocol
    
    // MARK: - IBOutlet
    @IBOutlet var movieTableView: UITableView!
    
    // MARK: - Lifecycle
    init(viewModel: MoviesViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        configureMVVM()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMovies()
    }
    
    // MARK: - Private methods
    private func configureTableView() {
        movieTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        movieTableView.rowHeight = 132
    }
    
    private func configureMVVM() {
        viewModel.completion = { [weak self] movies in
            self?.dataSource = movies
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                movieTableView.reloadData()
            }
        }
        
        viewModel.onCellTap = { [weak self] data in
            guard let self else { return }
            presentDetailVC(with: data)
        }
    }
    
    private func presentDetailVC(with data: DetailsTableViewData) {
        let detailsVC = UIStoryboard(name: "DetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailsTableViewController") as! DetailsTableViewController
        let viewModel = DetailsViewModel(data: data)
        detailsVC.viewModel = viewModel
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - ListTableViewCellDataSource implementation
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.configureWith(image: Constants.NetworkManager.imageBaseURL + dataSource[indexPath.row].posterPath,
                           text: dataSource[indexPath.row].title)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = DetailsTableViewData(
            year: dataSource[indexPath.row].releaseDate,
            filmURL: Constants.NetworkManager.imageBaseURL + dataSource[indexPath.row].backdropPath,
            description: dataSource[indexPath.row].overview
        )
        viewModel.didSelectCell(data: data)
    }
}

// MARK: - ListTableViewCellDelegate implementation
extension MoviesTableViewController: ListTableViewCellDelegate {
    func longPressed(cell: UITableViewCell) {
        if let indexPath = movieTableView.indexPath(for: cell) {
            let item = dataSource[indexPath.row]
            viewModel.addToFavourite(movie: item)
        }
    }
}
