//
//  ReportAPIRequest.swift
//  Minning
//
//  Created by denny on 2021/11/23.
//  Copyright © 2021 Minning. All rights reserved.
//

import Alamofire
import CommonSystem

public struct ReportAPIRequest: MinningAPIRequestable {
    enum RequestType: APIRouteable {
        case monthlyReport(year: Int, month: Int)
        case weeklyReport(lastDate: String)
        
        var requestURL: URL {
            switch self {
            case let .monthlyReport(year, month):
                return MinningAPIConstant.reportURL.appendingPathComponent("month")
                    .appendingPathComponent("\(year)").appendingPathComponent("\(month)")
            case let.weeklyReport(lastDate):
                return MinningAPIConstant.reportURL.appendingPathComponent("week").appendingPathComponent("\(lastDate)")
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
    
    public static func monthlyReport(year: Int, month: Int,
                                     completion: @escaping (Result<ReportResponseModel, Error>) -> Void) {
        perform(.monthlyReport(year: year, month: month), completion: completion)
    }
    
    public static func weeklyReport(lastDate: String,
                                    completion: @escaping (Result<ReportWeekResponseModel, Error>) -> Void) {
        perform(.weeklyReport(lastDate: lastDate), completion: completion)
    }
}

