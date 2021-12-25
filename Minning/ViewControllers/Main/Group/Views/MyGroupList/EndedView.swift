//
//  EndedViewController.swift
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

final class EndedView: UIView, UITableViewDataSource, UITableViewDelegate {
    var groups = [MissionModel]()
    
    lazy var mainTableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .minningLightGray100
        $0.register(EndedGroupTableViewCell.self, forCellReuseIdentifier: EndedGroupTableViewCell.identifier)
        return $0
    }(UITableView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEndedViewWithGroups(groupDetails: [MissionModel]) {
        self.groups = groupDetails
        mainTableView.reloadData()
    }
    
    private func setUpView() {
        backgroundColor = .minningLightGray100
        addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateTableView() {
        mainTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: EndedGroupTableViewCell.identifier, for: indexPath) as? EndedGroupTableViewCell
        else {
            return .init()
        }
        cell.configure(groups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
