//
//  DetailsViewModel.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 06.02.2024.
//

import Foundation

// MARK: - DetailsViewModelProtocol
protocol DetailsViewModelProtocol: AnyObject {
    var data: DetailsTableViewData { get }
}

// MARK: - DetailsViewModel
final class DetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Private propertie
    private(set) var data: DetailsTableViewData
    
    // MARK: - Life cycle
    init(data: DetailsTableViewData) {
        self.data = data
    }
}
