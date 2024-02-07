//
//  TabController.swift
//  NitrixTest
//
//  Created by Pavlo Myroshnychenko on 01.02.2024.
//

import UIKit

// MARK: - TabController
class TabController: UITabBarController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabs()
        self.tabBar.barTintColor = .white
    }
    
    // MARK: - Private methods
    private func setupTabs() {
        let list = self.createNavigation(with: "Movies List", and: UIImage(systemName: "film"), vc: setupListVC())
        let favourites = self.createNavigation(with: "Favourites", and: UIImage(systemName: "star"), vc: setupFavouriteListVC())
        self.setViewControllers([list, favourites], animated: true)
    }
    
    private func createNavigation(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        return navigation
    }
    
    private func setupListVC() -> UIViewController {
        let viewModel = MoviesViewModel()
        let listvc = MoviesTableViewController(viewModel: viewModel)
        return listvc
    }
    
    private func setupFavouriteListVC() -> UIViewController {
        let viewModel = FavouritesViewModel()
        let listvc = FavouritesTableViewController(viewModel: viewModel)
        return listvc
    }
}
