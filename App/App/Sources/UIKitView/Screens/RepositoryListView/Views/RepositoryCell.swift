//
//  RepositoryCell.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit
import RxSwift

final class RepositoryCell: UICollectionViewCell {

    private let repositoryImageView = UIImageView(image: .defaultRepositoryImage)
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let starCountLabel = UILabel()

    private lazy var numberFormatter = NumberFormatter.comma

    private var disposable: Disposable?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposable?.dispose()
        repositoryImageView.image = .defaultRepositoryImage
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let newHeight = contentView.systemLayoutSizeFitting(layoutAttributes.size).height
        let newsize = CGSize(width: layoutAttributes.size.width, height: newHeight)

        let newAttributes = layoutAttributes
        newAttributes.size = newsize
        return newAttributes
    }

    func bind(_ repository: RepositoryCellData) {
        titleLabel.text = repository.title
        subTitleLabel.text = repository.subtitle
        starCountLabel.text = numberFormatter.string(from: NSNumber(value: repository.starCount)) ?? "?"

        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.disposable = self?.repositoryImageView.downlodeImage(from: repository.imageURL).subscribe()
        }
    }
}

private extension RepositoryCell {

    func setupViews() {

        // MARK: - ImageView
        repositoryImageView.layer.cornerRadius = 8
        repositoryImageView.clipsToBounds = true

        // MARK: - Text
        titleLabel.text = "title"
        subTitleLabel.text = "subtitle"
        starCountLabel.text = "1,000"

        // MARK: - Titles
        let titlesStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subTitleLabel
        ])
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        subTitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        subTitleLabel.textColor = .secondaryLabel
        titlesStackView.spacing = 4
        titlesStackView.axis = .vertical
        titlesStackView.alignment = .fill
        titlesStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        // MARK: - StarCount
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

        // MARK: - Chevron
        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .gray

        // MARK: - Entire Stack View
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
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
            repositoryImageView.widthAnchor.constraint(equalToConstant: 48),
            repositoryImageView.heightAnchor.constraint(equalToConstant: 48),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        clipsToBounds = true

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .secondarySystemBackground
        self.selectedBackgroundView = selectedBackgroundView
    }
}

private extension UIImageView {

    func downlodeImage(from url: URL) -> Single<Void> {
        Single.create { obsever in
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data) ?? .defaultRepositoryImage
                }
            } catch {
                DispatchQueue.main.async {
                    self.image = .defaultRepositoryImage
                }
            }
            obsever(.success(()))
            return Disposables.create {}
        }
    }
}

private extension UIImage {

    static let defaultRepositoryImage = UIImage(systemName: "person.circle")
}

private extension NumberFormatter {

    static let comma: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.groupingSize = 3
        return formatter
    }()
}
