//
//  GroupListCellView.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/24.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import CoreGraphics
import DesignSystem
import SharedAssets
import SnapKit
import UIKit

final class GroupListCellView: UIView {
    var groups = [GroupModel]()
    
    lazy var mainTableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.register(GroupListTableViewCell.self, forCellReuseIdentifier: GroupListTableViewCell.identifier)
        return $0
    }(UITableView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViewWithGroups(groupDetails: [GroupModel]) {
        self.groups = groupDetails
        mainTableView.reloadData()
    }
    
    private func setupViewLayout() {
        mainTableView.backgroundColor = .minningLightGray100
        addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension GroupListCellView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: GroupListTableViewCell.identifier, for: indexPath) as? GroupListTableViewCell else {
                return .init()
        }
        cell.configure(groups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }

}
