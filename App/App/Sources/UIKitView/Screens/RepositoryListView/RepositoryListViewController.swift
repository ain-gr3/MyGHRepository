//
//  RepositoryListViewController.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit
import RxSwift
import RxCocoa

final class RepositoryListViewController: UIViewController {

    private let viewModel: RepositoryListViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Collection View
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(RepositoryCell.self, forCellWithReuseIdentifier: String(describing: RepositoryCell.self))

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // MARK: - Error Label
        let label = UILabel()
        label.textColor = .secondaryLabel

        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // MARK: - Indicator
        let indicator = UIActivityIndicatorView(style: .large)

        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        title = viewModel.type.title

        viewModel.state
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { state in
            indicator.isHidden = true
            indicator.stopAnimating()

            label.isHidden = true

            switch state {
            case .normal:
                break
            case .isLoading:
                indicator.isHidden = false
                indicator.startAnimating()
            case .hasError(let error):
                label.isHidden = false
                label.text = error.description
            }
        })
            .disposed(by: disposeBag)

        viewModel.repositories
            .bind(to: collectionView.rx.items(
                cellIdentifier: String(describing: RepositoryCell.self), cellType: RepositoryCell.self)) { _, entity, cell in
                cell.bind(RepositoryCellData(entity: entity))
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .withLatestFrom(viewModel.repositories) { indexPath, repositories in
                return repositories[indexPath.row]
            }
            .subscribe { [weak self] repositoryEvent in
                guard let self = self, let repository = repositoryEvent.element else {
                    return
                }
                let detailViewController = RepositoryDetailViewController(
                    viewModel: .init(repositoryList: self.viewModel.repositoryList, output: self.viewModel.output, repository: repository)
                )
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.reloadRepositories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.reloadRepositories()
    }
}

extension RepositoryListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: 100)
    }
}
