//
//  SearchViewController.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let textField = UITextField()
        textField.placeholder = "キーワードを入力"
        textField.textAlignment = .center
        textField.delegate = self
        textField.font = .preferredFont(forTextStyle: .body)
        textField.rx.text.bind(to: viewModel.text)
            .disposed(by: disposeBag)

        var buttonConfigration = UIButton.Configuration.borderedProminent()
        buttonConfigration.buttonSize = .large
        buttonConfigration.attributedTitle = AttributedString("検索")
        buttonConfigration.attributedTitle?.font = .preferredFont(forTextStyle: .headline)

        let button = UIButton(configuration: buttonConfigration, primaryAction: .init { [weak self] _ in
            textField.resignFirstResponder()
            guard let self = self else {
                return
            }
            self.navigationController?.pushViewController(RepositoryListViewController(
                viewModel: SearchRepositoryListViewModel(
                    keyword: self.viewModel.text.value ?? "nil",
                    repositoryList: self.viewModel.repositoryList,
                    output: self.viewModel.output
                )
            ), animated: true)
            print(self.viewModel.text.value ?? "nil")
        })
        viewModel.isButtonEnabled.bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)

        let stackView = UIStackView(arrangedSubviews: [textField, button])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 48

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
