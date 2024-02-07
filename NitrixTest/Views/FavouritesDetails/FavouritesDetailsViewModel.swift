//
//  FavouritesDetailsViewModel.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 07.02.2024.
//

import Foundation

// MARK: - FavouritesDetailsViewModelProtocol
protocol FavouritesDetailsViewModelProtocol: AnyObject {
    var data: FavouritesDetailsViewData { get }
}

// MARK: - FavouritesDetailsViewModel
final class FavouritesDetailsViewModel: FavouritesDetailsViewModelProtocol {
    
    // MARK: - Private propertie
    private(set) var data: FavouritesDetailsViewData
    
    // MARK: - Life cycle
    init(data: FavouritesDetailsViewData) {
        self.data = data
    }
}
