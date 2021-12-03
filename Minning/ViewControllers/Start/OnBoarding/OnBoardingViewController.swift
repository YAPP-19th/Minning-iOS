//
//  OnBoardingViewController.swift
//  Minning
//
//  Created by denny on 2021/12/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

class OnBoardingViewController: BaseViewController {
    private let viewModel: OnBoardingViewModel
    
    public init(viewModel: OnBoardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        
    }
    
    override func setupViewLayout() {
        
    }
}
