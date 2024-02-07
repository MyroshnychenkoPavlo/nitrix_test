//
//  MoviesViewModel.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 06.02.2024.
//

import Foundation

typealias MoviesHandler = (([Movie]) -> Void)
typealias MovieCellActionHandler = ((DetailsTableViewData) -> Void)

// MARK: - MoviesViewModelProtocol
protocol MoviesViewModelProtocol: AnyObject {
    var completion: MoviesHandler? { get set }
    var onCellTap: MovieCellActionHandler? { get set }
    
    func didSelectCell(data: DetailsTableViewData)
    func addToFavourite(movie: Movie)
    func getMovies()
}

// MARK: - MoviesViewModel
class MoviesViewModel {

    // MARK: - Private propertie
    private let fileManager: MyFileManager
    
    // MARK: - Public properties
    var completion: MoviesHandler?
    var onCellTap: MovieCellActionHandler?
    
    // MARK: - Life cycle
    init() {
        fileManager = MyFileManager.shared
    }
}

// MARK: - MoviesViewModelProtocol implementation
extension MoviesViewModel: MoviesViewModelProtocol {
    func getMovies() {
       NetworkManager().fetchData { [weak self] result in
           switch result {
           case .success(let success):
               self?.completion?(success.results.map({ $0 }))
           case .failure(let failure):
               print(failure.localizedDescription)
           }
       }
   }
    
    func addToFavourite(movie: Movie) {
        if !fileManager.contains(movie) {
            fileManager.add(movie)
        }
    }
    
    func didSelectCell(data: DetailsTableViewData) {
        onCellTap?(data)
    }
}
