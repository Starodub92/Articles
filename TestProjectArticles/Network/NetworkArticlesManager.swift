//
//  NetworkArticlesManager.swift
//  TestProjectArticles
//
//  Created by Дмитрий Стародубцев on 16.03.2022.
//

import UIKit

struct NetworkArticlesManager {
    
    func fetchCurrentArticles(success: @escaping (([CurrentAtriclesData]) -> Void), failure: @escaping ((Error) -> Void)) {
        
        let urlString = "https://api.jsonbin.io/b/620ca6bc1b38ee4b33bd9656"
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
                
                do {
                    let decoder = JSONDecoder()
                    let artcles = try decoder.decode(ArticlesData.self, from: data)
                    DispatchQueue.main.async {
                        success(artcles.sections)
                    }
                } catch let error as NSError {
                    
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    failure(error ?? NSError(domain: "fetchCurrentArticles", code: -1, userInfo: [:]))
                }
            }
        }
        task.resume()
    }
}
