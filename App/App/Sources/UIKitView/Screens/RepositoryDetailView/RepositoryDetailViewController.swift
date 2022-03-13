//
//  RepositoryDetailViewController.swift
//  
//
//  Created by Ain Obara on 2022/03/07.
//

import UIKit
import WebKit
import RxSwift

final class RepositoryDetailViewController: UIViewController, WKUIDelegate {

    private let viewModel: RepositoryDetailViewModel
    private let disposeBag = DisposeBag()
    var webView: WKWebView!

    init(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.backgroundColor = .systemBackground
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.isOpaque = false

        let button = UIButton(frame: .init(origin: .zero, size: .init(width: 28, height: 28)), primaryAction: .init { [weak self] _ in
            self?.viewModel.toggleIsLiked()
        })
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.isSelected = viewModel.repository.isLiked
        viewModel.isLiked.bind(to: button.rx.isSelected)
            .disposed(by: disposeBag)

        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.setRightBarButton(barButtonItem, animated: false)

        title = viewModel.repository.name

        webView.load(URLRequest(url: viewModel.repository.url))
    }
}
