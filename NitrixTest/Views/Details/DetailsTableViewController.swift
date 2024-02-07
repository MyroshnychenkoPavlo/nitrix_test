//
//  DetailsTableViewController.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 06.02.2024.
//

import UIKit
import Kingfisher

// MARK: - DetailsTableViewData
struct DetailsTableViewData {
    let year: String?
    let filmURL: String?
    let description: String?
}

// MARK: - DetailsTableViewController
class DetailsTableViewController: UITableViewController {
    
    // MARK: - Public propertie
    var viewModel: DetailsViewModelProtocol?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var filmImage: UIImageView!
    @IBOutlet private weak var filmDescriptionLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        yearLabel.text = viewModel?.data.year
        filmImage.kf.setImage(with: URL(string: viewModel?.data.filmURL ?? ""))
        filmDescriptionLabel.text = viewModel?.data.description
    }
}
