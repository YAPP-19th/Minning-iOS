//
//  MygroupViewController.swift
//  Minning
//
//  Created by 박지윤 on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class MygroupView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var groupTableView = UITableView()
    
    public init() {
        super.init(frame: .zero, style: .plain)
        setUpView()
        updateTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .minningLightGray100
        addSubview(groupTableView)
        
        updateTableView()
        
        groupTableView.register(GroupListCellViewController.self, forCellReuseIdentifier: GroupListCellViewController.identifier)
        groupTableView.dataSource = self
        groupTableView.delegate = self
        groupTableView.backgroundColor = .minningLightGray100
        groupTableView.separatorStyle = .none
        
        groupTableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func updateTableView() {
        groupTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: GroupListCellViewController.identifier) as? GroupListCellViewController ?? GroupListCellViewController()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
