//
//  MainTabBarController.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit

public final class MainTabBarController: UITabBarController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllers = MainTab.allCases.enumerated().map { index, tab -> UIViewController in
            let viewController = tab.viewController()
            viewController.tabBarItem = UITabBarItem(
                title: tab.title,
                image: UIImage(systemName: tab.systemImageName),
                tag: index
            )
            return UINavigationController(rootViewController: viewController)
        }

        setViewControllers(viewControllers, animated: false)
    }
}

private extension MainTab {

    func viewController() -> UIViewController {
        switch self {
        case .search:
            return SearchViewController(viewModel: SearchViewModel())
        case .favorite:
            return RepositoryListViewController()
        }
    }
}
