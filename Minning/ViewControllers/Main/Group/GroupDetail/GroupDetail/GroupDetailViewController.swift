//
//  GroupDetailViewController.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupDetailViewController: BaseViewController {
    
    enum GroupViewType {
        case openedGroup, myGroup, closedGroup
    }
    
    private let navigationBar: PlainUINavigationBar = PlainUINavigationBar()
    
    private let scrollView: UIScrollView = {
        $0.keyboardDismissMode = .interactive
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = UIView()
    private let contentStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let groupTitleContainerView = GroupTitleContainerView()
    private let myInfoConatainerView = GroupMyInfoContainerView()
    private let ruleContainerView = GroupRuleContainerView()
    private let groupPhotoPreviewContainerView = GroupPhotoPreviewContainerView()
    private let groupInfoContainerView = GroupInfoCollectionView()
    private let groupPhotoContainerView = GroupPhotoContainerView()
    private let groupQuitView = GroupQuitView()
    
    private let joinButton: PlainButton = {
        $0.setTitle("참여하기", for: .normal)
        $0.addTarget(self, action: #selector(onClickJoinButton(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    var viewType: GroupViewType?
    
    private let viewModel: GroupDetailViewModel
    
    public init(viewModel: GroupDetailViewModel, viewType: GroupViewType) {
        self.viewModel = viewModel
        self.viewType = viewType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        DebugLog("ViewWillLayoutSubviews")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // SAMPLE
        viewModel.groupItem.accept(Group(title: "새벽 운동 그룹"))
    }
    
    override func bindViewModel() {
        viewModel.groupItem.bind { [weak self] group in
            guard let `self` = self else { return }
            self.navigationBar.titleContent = group?.title ?? ""
        }
    }
    
    override func setupViewLayout() {
        [navigationBar, scrollView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        
        [contentStackView, joinButton].forEach {
            contentView.addSubview($0)
        }
        
        setViewsByViewType()
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
                
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        joinButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    private func setViewsByViewType() {
        switch viewType {
        case .openedGroup:
            [groupTitleContainerView, ruleContainerView, groupPhotoPreviewContainerView, groupInfoContainerView].forEach {
                contentStackView.addArrangedSubview($0)
            }
        case .myGroup:
            [groupTitleContainerView, myInfoConatainerView, groupInfoContainerView, ruleContainerView, groupPhotoContainerView, groupQuitView].forEach {
                contentStackView.addArrangedSubview($0)
            }
        case .closedGroup:
            [groupTitleContainerView, myInfoConatainerView, groupPhotoContainerView, groupQuitView].forEach {
                contentStackView.addArrangedSubview($0)
            }
        case .none:
            break
        }
    }
    
    private func setupNavigationBar() {
        navigationBar.removeDefaultShadowImage()
        
        let navigationItem = UINavigationItem()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "close"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onClickJoinButton(_ sender: Any?) {
        viewModel.showJoinGroup(completion: { [weak self] isSuccess in
//            guard let `self` = self else { return }
            DebugLog("Group Popup 닫기 Result : \(isSuccess)")
        })
    }
}