//
//  CurrentAtriclesData.swift
//  TestProjectArticles
//
//  Created by Дмитрий Стародубцев on 16.03.2022.
//

import Foundation

struct CurrentAtriclesData: Decodable {
    let id: String
    let header: String
    let itemsTotal: Int
    let itemsToShow: Int
    let items: [Information]
}

struct Information: Decodable {

    let id : String
    let image: ImageData
    let title: String
}

struct ArticlesData: Decodable {
    let sections: [CurrentAtriclesData]
}

struct ImageData : Decodable {
    let oneX: String
    let twoX: String
    let threeX: String
    
    enum CodingKeys: String, CodingKey {
        case oneX = "1x", twoX = "2x", threeX = "3x"
    }
}
