//
//  LargeContentsViewController.swift
//  Minning
//
//  Created by denny on 2021/10/31.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class LargeContentsViewController: BaseViewController {
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = .font16P
        textView.textColor = .black
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    private let viewModel: LargeContentsViewModel
    
    public init(viewModel: LargeContentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getLargeContentData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        updateViewContent()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    private func updateViewContent() {
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = viewModel.contentType.value.displayText
            navBar.removeDefaultShadowImage()
        }
    }
    
    override func bindViewModel() {
        viewModel.contentType.bind { [weak self] _ in
            guard let `self` = self else { return }
            self.updateViewContent()
        }
        
        viewModel.largeContent.bind { [weak self] content in
            guard let `self` = self else { return }
            self.textView.text = content
        }
    }
    
    override func setupViewLayout() {
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
}
