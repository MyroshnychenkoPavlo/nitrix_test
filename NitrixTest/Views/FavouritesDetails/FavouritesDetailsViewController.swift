//
//  FavouritesDetailsViewController.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 07.02.2024.
//

import UIKit

// MARK: - FavouritesDetailsViewData
struct FavouritesDetailsViewData {
    let year: String
    let name: String
    let genre: String
}

// MARK: - FavouritesDetailsViewController
class FavouritesDetailsViewController: UIViewController {
    
    // MARK: - Private propertie
    private let viewModel: FavouritesDetailsViewModelProtocol
    
    // MARK: - IBOutlets
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var filmName: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    
    // MARK: - Life cycle
    init(viewModel: FavouritesDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yearLabel.text = viewModel.data.year
        filmName.text = viewModel.data.name
        genreLabel.text = viewModel.data.genre
    }
}
