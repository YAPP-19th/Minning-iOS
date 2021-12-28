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

final class OnGoingView: UIView, UITableViewDataSource, UITableViewDelegate {
    var ongoingGroups = [MissionModel]()
    
    lazy var mainTableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .minningLightGray100
        $0.register(OngoingTableViewCell.self, forCellReuseIdentifier: OngoingTableViewCell.identifier)
        return $0
    }(UITableView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateOnGoingViewWithGroups(groupDetails: [MissionModel]) {
        self.ongoingGroups = groupDetails
        mainTableView.reloadData()
        print("updateONGOINGVIEW, \(ongoingGroups.description)")
    }
    
    private func setUpView() {
        backgroundColor = .minningLightGray100
        addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ongoingGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: OngoingTableViewCell.identifier, for: indexPath) as? OngoingTableViewCell
        else {
            return .init()
        }
        cell.configure(ongoingGroups[indexPath.row])
        print(ongoingGroups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
