//
//  RecommendViewController.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class RecommendViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    private let viewModel: RecommendViewModel
    
    private let closeButton: UIButton = {
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(RecommendViewCell.self, forCellReuseIdentifier: RecommendViewCell.identifier)
        $0.isScrollEnabled = true
        return $0
    }(UITableView())

    init(viewModel: RecommendViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewLayout()
    }
    
    override func bindViewModel() {
        
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(38)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendViewCell.identifier) as! RecommendViewCell
        
        cell.setRecommendTitle(title: viewModel.titleInfo(at: indexPath.row))
        cell.setRecommendData(subtitle: viewModel.subTitleInfo(at: indexPath.row), contents: viewModel.subContentsInfo(at: indexPath.row), color: viewModel.cellColorInfo(at: indexPath.row))
        cell.contentView.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTitles
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
}
