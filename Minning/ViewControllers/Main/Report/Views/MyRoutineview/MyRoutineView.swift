//
//  MyRoutineView.swift
//  Minning
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class MyRoutineView: UIView {
    private var sampleRoutineData: [[Routine]] = []
    
    private var separatorView: UIView = {
        $0.backgroundColor = .primaryLightGray
        return $0
    }(UIView())
    
    private let sectionTitleLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        $0.text = "내 루틴"
        return $0
    }(UILabel())
    
    lazy var routineTableView: NonScrollTableView = {
        $0.backgroundColor = .grayEEF1F5
        $0.delegate = self
        $0.dataSource = self
        $0.estimatedRowHeight = 46
        $0.isScrollEnabled = false
        $0.register(MyRoutineTitleCell.self, forCellReuseIdentifier: MyRoutineTitleCell.identifier)
        $0.register(MyRoutineContentCell.self, forCellReuseIdentifier: MyRoutineContentCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        return $0
    }(NonScrollTableView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        // SAMPLE
        createSampleData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSampleData() {
        let sampleCategory: [RoutineCategory] = [.health, .life, .miracle, .selfDev]
        let sampleResult: [RoutineResult] = [.done, .tried, .relax, .failure]
        var sampleDataList: [Routine] = []
        
        for index in 0..<28 {
            if index > 0, index % 7 == 0 {
                sampleRoutineData.append(sampleDataList)
                sampleDataList.removeAll()
            }
            
            let randomIndex = Int.random(in: 0..<4)
            
            sampleDataList.append(Routine(title: "샘플\(index)",
                                          category: sampleCategory[index / 7],
                                          result: sampleResult[randomIndex]))
            
            if index == 27 {
                sampleRoutineData.append(sampleDataList)
                sampleDataList.removeAll()
            }
        }
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        
        [separatorView, sectionTitleLabel, routineTableView].forEach {
            addSubview($0)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(12)
        }
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        routineTableView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-105)
        }
    }
}

extension MyRoutineView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 35
        }
        return 37
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MyRoutineTitleCell.identifier) as? MyRoutineTitleCell {
                cell.selectionStyle = .none
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MyRoutineContentCell.identifier) as? MyRoutineContentCell {
                cell.selectionStyle = .none
                cell.weeklyRoutineData = sampleRoutineData[indexPath.row - 1]
                return cell
            }
        }
        return UITableViewCell()
    }
}
