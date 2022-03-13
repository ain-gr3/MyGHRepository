//
//  MainTabBarController.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit

public final class MainTabBarController: UITabBarController {

    private let viewModel: MainTabBarViewModel

    public init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllers = MainTab.allCases.enumerated().map { index, tab -> UIViewController in
            let viewController = viewController(of: tab)
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

private extension MainTabBarController {

    func viewController(of tab: MainTab) -> UIViewController {
        switch tab {
        case .search:
            return SearchViewController(
                viewModel: SearchViewModel(
                    repositoryList: viewModel.repositoryList,
                    output: viewModel.output
                )
            )
        case .favorite:
            return RepositoryListViewController(
                viewModel: FavoriteRepositoryListViewModel(
                    repositoryList: viewModel.repositoryList,
                    output: viewModel.output
                )
            )
        }
    }
}
