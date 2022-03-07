//
//  RepositoryListViewController.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit

final class RepositoryListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RepositoryCell.self, forCellWithReuseIdentifier: String(describing: RepositoryCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RepositoryListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RepositoryCell.self), for: indexPath) as! RepositoryCell
        cell.bind(.sample)
        return cell
    }
}

extension RepositoryListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
