//
//  ReportViewController.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class ReportViewController: BaseViewController {
    private let weekTabButton: UIButton = {
        $0.setTitle("주", for: .normal)
        $0.titleLabel?.font = .font20PExBold
        return $0
    }(UIButton())
    
    private let monthTabButton: UIButton = {
        $0.setTitle("월", for: .normal)
        $0.titleLabel?.font = .font20PExBold
        return $0
    }(UIButton())
    
    private let viewModel: ReportViewModel
    
    public init(viewModel: ReportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func setupViewLayout() {
        
    }
    
    override func bindViewModel() {
        viewModel.tabType.bindAndFire { [weak self] type in
            guard let `self` = self else { return }
            self.weekTabButton.isEnabled = type == .week
            self.weekTabButton.setTitleColor(type == .week ? .primaryBlack : .primaryGray, for: .normal)
            
            self.monthTabButton.isEnabled = type == .month
            self.monthTabButton.setTitleColor(type == .month ? .primaryBlack : .primaryGray, for: .normal)
        }
    }
}
