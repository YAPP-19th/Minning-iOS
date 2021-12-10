//
//  UIView+Extensions.swift
//  DesignSystem
//
//  Created by denny on 2021/12/08.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

public extension UIView {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DebugLog(response?.suggestedFilename ?? url.lastPathComponent)
            DebugLog("Download Finished")
            
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
