//
//  NoticeAPIRequest.swift
//  Minning
//
//  Created by denny on 2022/02/20.
//  Copyright © 2022 Minning. All rights reserved.
//

import Alamofire
import CommonSystem
import Pageboy

public struct NoticeRequest {
    let category: RoutineCategory
    let days: [Day]
    let goal: String
    let startTime: String
    let title: String
}

public struct NoticeAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case noticeList
        case noticeDetail(id: Int64)
        
        var requestURL: URL {
            switch self {
            case .noticeList:
                return MinningAPIConstant.noticeURL.appendingPathComponent("")
            case let .noticeDetail(id):
                return MinningAPIConstant.noticeURL.appendingPathComponent("\(id)")
            }
        }
        
        var httpMethod: HTTPMethod {
            .get
        }
        
        var image: UIImage? {
            return nil
        }
        
        var parameters: [String: Any]? {
            nil
        }
        
        var requestEncoding: RequestEncoding {
            .url
        }
    }
    
    public static func getNoticeList(completion: @escaping (Result<NoticeResponseModel, MinningAPIError>) -> Void) {
        perform(.noticeList, completion: completion)
    }
                
    public static func getNoticeDetail(id: Int64, completion: @escaping (Result<NoticeDetailResponseModel, MinningAPIError>) -> Void) {
        perform(.noticeDetail(id: id), completion: completion)
    }
}
