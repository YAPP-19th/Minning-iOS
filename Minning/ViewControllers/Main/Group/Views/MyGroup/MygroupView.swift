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
    var tableCellDataSource = GroupListCellViewModel()
    var groupTableView = UITableView()
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.setUpView()
        self.updateTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .minningLightGray100
        addSubview(groupTableView)
        
        updateTableView()
        
        groupTableView.register(GroupListCell.self, forCellReuseIdentifier: GroupListCell.identifier)
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
//        return tableCellDataSource.cellCount()
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: GroupListCell.identifier) as? GroupListCell ?? GroupListCell()
        cell.iconBackgroundView.backgroundColor = tableCellDataSource.cellColors[indexPath.row]
        cell.contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
        cell.layer.cornerRadius = 10
//        cell.bind(model: tableCellDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
