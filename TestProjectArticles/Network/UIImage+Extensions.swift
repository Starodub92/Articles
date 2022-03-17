//
//  UIImage+Extensions.swift
//  TestProjectArticles
//
//  Created by Дмитрий Стародубцев on 16.03.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ urlString: String) {
        let url = URL(string: urlString)
        kf.setImage(with: url)
    }
    
    func loadImage(url: URL) {
        kf.setImage(with: url)
    }
}
