//
//  ResetPasswordViewController.swift
//  Minning
//
//  Created by denny on 2021/10/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class ResetPasswordViewController: BaseViewController {
    private let viewModel: ResetPasswordViewModel
    
    public init(viewModel: ResetPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
