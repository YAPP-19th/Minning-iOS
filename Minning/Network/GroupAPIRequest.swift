//
//  GroupAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public struct GroupAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case groupList
        case groupListByCategory(category: RoutineCategory)
        case groupDetail(id: Int64)
        
        var requestURL: URL {
            switch self {
            case .groupList:
                return MinningAPIConstant.groupURL
            case let .groupListByCategory(category):
                return MinningAPIConstant.groupURL.appendingPathComponent("category").appendingPathComponent("\(category.title)")
            case let .groupDetail(id):
                return MinningAPIConstant.groupURL.appendingPathComponent("detail").appendingPathComponent("\(id)")
            }
        }
        
        var httpMethod: HTTPMethod {
            return .get
        }
        
        var image: UIImage? {
            return nil
        }
        
        var parameters: [String: Any]? {
            return nil
        }
        
        var requestEncoding: RequestEncoding {
            return .url
        }
    }
    
    public static func getGroupList(completion: @escaping (Result<GroupResponseModel, MinningAPIError>) -> Void) {
        perform(.groupList, completion: completion)
    }
    
    public static func getGroupListByCategory(category: RoutineCategory,
                                              completion: @escaping (Result<GroupResponseModel, MinningAPIError>) -> Void) {
        perform(.groupListByCategory(category: category), completion: completion)
    }
    
    public static func getGroupDetail(groupId: Int64,
                                      completion: @escaping (Result<GroupDetailResponseModel, MinningAPIError>) -> Void) {
        perform(.groupDetail(id: groupId), completion: completion)
    }
}
