//
//  RoutineView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import SnapKit

protocol RoutineViewDelegate: AnyObject {
    func didSelectSection(_ section: RoutineView.TableViewSection)
    func didSelectEditOrder()
    func didSelectTab(_ tabType: HomeViewModel.RoutineTabType)
}

final class RoutineView: UIView {
    enum TableViewSection: Int, CaseIterable {
        case header
        case phraseGuide
        case routine
        case review
    }
    
    weak var delegate: RoutineViewDelegate?
    var tabType: HomeViewModel.RoutineTabType = .routine
    
    lazy var mainTableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(PhraseGuideCell.self, forCellReuseIdentifier: PhraseGuideCell.identifier)
        $0.register(RoutineCell.self, forCellReuseIdentifier: RoutineCell.identifier)
        $0.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        return $0
    }(UITableView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        mainTableView.reloadData()
    }
    
    private func setupViewLayout() {
        mainTableView.backgroundColor = .clear
        addSubview(mainTableView)

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
            header.delegate = self
            header.configure(tabType: tabType)
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch TableViewSection(rawValue: section) {
        case .routine:
            let footer = RoutineFooterView()
            footer.editOrderButtonHandler = { [weak self] in
                guard let delegate = self?.delegate else { return }
                return delegate.didSelectEditOrder()
            }
            return footer
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let section = TableViewSection(rawValue: indexPath.section) {
            delegate?.didSelectSection(section)
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
            return tabType == .routine ? 1 : .zero
        case .routine:
            return tabType == .routine ? 3 : .zero
        case .review:
            return tabType == .routine ? .zero : 2
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
            return cell
        case .review:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell else {
                return .init()
            }
            return cell
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
        case .review:
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
            return tabType == .routine ? 37 : .zero
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == TableViewSection.routine.rawValue else { return nil }
        return nil
//
//        let completeAction = UIContextualAction(style: .normal, title: "") { (_, _, completion) in
//            print("complete")
//            completion(true)
//        }
//        completeAction.backgroundColor = .minningLightGray100
//        completeAction.image = UIImage(sharedNamed: "complete_action.png")
//
//        let halfAction = UIContextualAction(style: .normal, title: "") { (_, _, completion) in
//            print("half")
//            completion(true)
//        }
//        halfAction.backgroundColor = .minningLightGray100
//        halfAction.image = UIImage(sharedNamed: "half_action.png")
//
//        let dismissAction = UIContextualAction(style: .normal, title: "") { (_, _, completion) in
//            print("dismiss")
//            completion(true)
//        }
//        dismissAction.backgroundColor = .minningLightGray100
//        dismissAction.image = UIImage(sharedNamed: "dismiss_action.png")
//
//        return .init(actions: [halfAction, completeAction])
//
//        return .init(actions: [dismissAction])
    }
}

extension RoutineView: RoutineHeaderViewDelegate {
    func didSelectRoutineTab() {
        delegate?.didSelectTab(.routine)
    }
    
    func didSelectReviewTab() {
        delegate?.didSelectTab(.review)
    }
}
