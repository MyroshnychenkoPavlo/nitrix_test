//
//  FavouritesViewModel.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 07.02.2024.
//

import Foundation

typealias FavouritesMovieCellActionHandler = ((FavouritesDetailsViewData) -> Void)

protocol FavouritesViewModelProtocol: AnyObject {
    var onCellTap: FavouritesMovieCellActionHandler? { get set }
    
    func didSelectCell(movie: Movie)
    func getFavouritesMovie() -> [Movie]
    func deleteFromFavourites(movie: Movie) -> [Movie]
}

class FavouritesViewModel {
    private let fileManager: MyFileManager
 
    var onCellTap: FavouritesMovieCellActionHandler?
    
    init() {
        fileManager = MyFileManager.shared
    }
}

extension FavouritesViewModel: FavouritesViewModelProtocol {
    func deleteFromFavourites(movie: Movie) -> [Movie] {
        if fileManager.contains(movie) {
            fileManager.delete(movie)
        }
        return fileManager.getFiles()
    }
    
    func getFavouritesMovie() -> [Movie] {
        return fileManager.getFiles()
    }
    
    func didSelectCell(movie: Movie) {
        NetworkManager().fetchGenre { [weak self] result in
            switch result {
            case .success(let genreList):
                DispatchQueue.main.async { [weak self] in
                    let genre = genreList.genres.filter { genre in
                        let ids = Array(movie.genreIDS)
                        return ids.contains(genre.id)
                    }
                    let data = FavouritesDetailsViewData(year: movie.releaseDate,
                                                         name: movie.title,
                                                         genre: genre.map({ $0.name }).joined(separator: ", "))
                    self?.onCellTap?(data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
