//
//  SampleViewController.swift
//  OurApp
//
//  Created by denny on 2021/08/28.
//

import UIKit
import SnapKit

class SampleViewController: UIViewController {
    private let titleLabel: UILabel = {
        $0.text = "Hello World"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return $0
    }(UILabel())
    
    private let viewModel: SampleViewModel
    
    public init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
}
