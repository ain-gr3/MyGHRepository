//
//  SearchViewController.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit

final class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let textField = UITextField()
        textField.placeholder = "キーワードを入力"
        textField.textAlignment = .center
        textField.delegate = self

        var buttonConfigration = UIButton.Configuration.borderedProminent()
        buttonConfigration.buttonSize = .large
        buttonConfigration.attributedTitle = AttributedString("検索")
        buttonConfigration.attributedTitle?.font = .preferredFont(forTextStyle: .headline)


        let button = UIButton(configuration: buttonConfigration, primaryAction: .init { _ in
            textField.resignFirstResponder()
            // TODO: validate text and transition
        })

        let stackView = UIStackView(arrangedSubviews: [textField, button])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 40

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
