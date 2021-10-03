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
    
    private let sectionTitle: UILabel = {
        $0.font = .font12PBold
        $0.textColor = .gray787C84
        $0.text = "내 루틴"
        return $0
    }(UILabel())
    
    lazy var routineTableView: NonScrollTableView = {
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
        let sampleCategory: [RoutineCategory] = [.exercise, .life, .miracle, .selfDev]
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
        
        [sectionTitle, routineTableView].forEach {
            addSubview($0)
        }
        
        sectionTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        routineTableView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitle.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension MyRoutineView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
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
