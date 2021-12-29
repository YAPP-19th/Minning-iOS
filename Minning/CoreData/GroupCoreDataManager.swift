//
//  GroupCoreDataManager.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/29.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import CoreData
import Foundation

class GroupCoreDataManager {
    static var group: [EndedGroup] = []
    
    static let shared: GroupCoreDataManager = GroupCoreDataManager()
//    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
//    lazy var context = appDelegate?.persistentContainer
//    lazy var context = AppDelegate().persistentContainer
//
//    static func createEndedGroup(count: Int32) {
//        let endedGroup = EndedGroup(context: <#T##NSManagedObjectContext#>)
//        endedGroup.endedGroupCount = count
//    }
}
