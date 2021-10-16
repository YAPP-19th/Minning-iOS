//
//  RoutineView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import SnapKit

protocol RoutineViewDelegate: AnyObject {
    func didSelectPhraseGuide()
    func didSelectRoutineCell()
    func didSelectEditOrder()
}

final class RoutineView: UIView {
    enum TableViewSection: Int, CaseIterable {
        case header
        case phraseGuide
        case routine
        case review
    }
    
    weak var delegate: RoutineViewDelegate?
    
    lazy var mainTableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(PhraseGuideCell.self, forCellReuseIdentifier: PhraseGuideCell.identifier)
        $0.register(RoutineCell.self, forCellReuseIdentifier: RoutineCell.identifier)
        return $0
    }(UITableView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        mainTableView.backgroundColor = .clear
        
        [mainTableView].forEach {
            addSubview($0)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RoutineView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch TableViewSection(rawValue: section) {
        case .header:
            let header = RoutineHeaderView()
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch TableViewSection(rawValue: section) {
        case .routine:
            let footer = RoutineFooterView()
            footer.delegate = self
            return footer
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch TableViewSection(rawValue: indexPath.section) {
        case .header:
            break
        case .phraseGuide:
            delegate?.didSelectPhraseGuide()
        case .routine:
            delegate?.didSelectRoutineCell()
        case .review:
            break
        default:
            break
        }
    }
}

extension RoutineView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewSection(rawValue: section) {
        case .header:
            return 0
        case .phraseGuide:
            return 1
        case .routine:
            return 3
        case .review:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableViewSection(rawValue: indexPath.section) {
        case .header:
            return .init()
        case .phraseGuide:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: PhraseGuideCell.identifier, for: indexPath) as? PhraseGuideCell else {
                return .init()
            }
            return cell
        case .routine:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: RoutineCell.identifier, for: indexPath) as? RoutineCell else {
                return .init()
            }
            cell.configure()
            return cell
        case .review:
            return .init()
        default:
            return .init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch TableViewSection(rawValue: indexPath.section) {
        case .phraseGuide:
            return 58
        case .routine:
            return 78
        default:
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch TableViewSection(rawValue: section) {
        case .header:
            return 70
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch TableViewSection(rawValue: section) {
        case .routine:
            return 37
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        return nil
        
        let completeAction = UIContextualAction(style: .normal, title: "완료") { (_, _, completion) in
            print("complete")
            completion(true)
        }
        completeAction.backgroundColor = .minningBlue100
        
        let halfAction = UIContextualAction(style: .normal, title: "부분완료") { (_, _, completion) in
            print("half")
            completion(true)
        }
        halfAction.backgroundColor = .minningGray100
        
        return .init(actions: [completeAction, halfAction])
    }
}

extension RoutineView: RoutineFooterViewDelegate {
    func didSelectEditOrder() {
        delegate?.didSelectEditOrder()
    }
}
