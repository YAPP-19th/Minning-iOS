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
    static var endedGroupArray: [EndedGroup] = []
    
    static let shared: GroupCoreDataManager = GroupCoreDataManager()
    lazy var context = AppDelegate().persistentContainer.viewContext
    
    static func initEndedGroup() {
        let data = NSEntityDescription.entity(forEntityName: "EndedGroup", in: GroupCoreDataManager.shared.context)!
        
        let endedGroup = NSManagedObject(entity: data, insertInto: GroupCoreDataManager.shared.context)
        endedGroup.setValue(true, forKeyPath: "isChecked")
        endedGroup.setValue(0, forKeyPath: "endedGroupCount")
    }

    static func updateEndedGroup(count: Int16) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EndedGroup")
        
        do {
            let data = try GroupCoreDataManager.shared.context.fetch(fetchRequest)
            let entityModel = data[0] as! NSManagedObject
            
            if entityModel.value(forKey: "endedGroupCount") as! Int16 != count {
                entityModel.setValue(count, forKey: "endedGroupCount")
                entityModel.setValue(false, forKey: "isChecked")
                
                do {
                    try GroupCoreDataManager.shared.context.save()
                } catch {
                    ErrorLog("\(error)")
                }
            }
        } catch {
            ErrorLog("\(error)")
        }
        
    }
    
    static func updateIsChecked() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EndedGroup")
        
        do {
            let data = try GroupCoreDataManager.shared.context.fetch(fetchRequest)
            let entityModel = data[0] as! NSManagedObject
            
            if entityModel.value(forKey: "isChecked") as! Bool == false {
                entityModel.setValue(true, forKey: "isChecked")
                
                do {
                    try GroupCoreDataManager.shared.context.save()
                } catch {
                    ErrorLog("\(error)")
                }
            }
        } catch {
            ErrorLog("\(error)")
        }
    }

}
