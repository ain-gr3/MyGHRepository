//
//  RepositoryCell.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit

final class RepositoryCell: UICollectionViewCell {

    private let repositoryImageView = UIImageView(image: UIImage(systemName: "person.circle"))
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let starCountLabel = UILabel()
    private let separator = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.text = "title"
        subTitleLabel.text = "subtitle"
        starCountLabel.text = "1,000"

        let titlesStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subTitleLabel
        ])
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        subTitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        subTitleLabel.font = .preferredFont(forTextStyle: .caption1)
        titlesStackView.spacing = 4
        titlesStackView.axis = .vertical
        titlesStackView.alignment = .fill
        titlesStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let starImageView = UIImageView(image: .init(systemName: "star.fill"))
        let starStackView = UIStackView(arrangedSubviews: [
            starImageView,
            starCountLabel
        ])
        starCountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        starImageView.tintColor = UIColor.label
        starStackView.spacing = 4
        starStackView.axis = .horizontal
        starStackView.alignment = .center

        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .gray

        let stackView = UIStackView(arrangedSubviews: [
            repositoryImageView,
            titlesStackView,
            starStackView,
            chevronImageView
        ])
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .center

        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),
            chevronImageView.heightAnchor.constraint(equalToConstant: 24),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
            repositoryImageView.widthAnchor.constraint(equalToConstant: 40),
            repositoryImageView.heightAnchor.constraint(equalToConstant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        separator.backgroundColor = .separator

        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.8),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let newHeight = contentView.systemLayoutSizeFitting(layoutAttributes.size).height
        let newsize = CGSize(width: layoutAttributes.size.width, height: newHeight)

        let newAttributes = layoutAttributes
        newAttributes.size = newsize
        return newAttributes
    }

extension UIImageView {

    func downlodeImage(from url: URL) -> Single<Void> {
        Single.create { obsever in
            do {
                let data = try Data(contentsOf: url)
                self.image = UIImage(data: data) ?? .defaultRepositoryImage
            } catch {
                self.image = .defaultRepositoryImage
            }
            obsever(.success(()))
            return Disposables.create {
                self.image = .defaultRepositoryImage
            }
        }
    }
}
