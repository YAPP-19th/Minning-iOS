//
//  EndedGroup+CoreDataProperties.swift
//  
//
//  Created by 박지윤 on 2021/12/29.
//
//

import Foundation
import CoreData


extension EndedGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EndedGroup> {
        return NSFetchRequest<EndedGroup>(entityName: "EndedGroup")
    }

    @NSManaged public var endedGroupCount: Int16
    @NSManaged public var isChecked: Bool

}
