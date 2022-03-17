//
//  CollectionViewCell.swift
//  TestProjectArticles
//
//  Created by Дмитрий Стародубцев on 16.03.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var cellSelected: Bool = false {
        didSet {
            let color: UIColor = cellSelected ? .blue : .clear
            imageView.layer.borderColor = color.cgColor
        }
    }
    
    static let identifier = "CollectionViewCell"
    
    let label : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear.withAlphaComponent(0.05)
        label.textColor = .black
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.numberOfLines = 0
        return label
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addSubview(label)
        
        setupConstraintImageView()
        setupConstraintLabel()
        
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
    
    func setupConstraintImageView() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let topImageView = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        
        let leftImageView = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0)
        
        let rightImageView = NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0)
        
        let bottomImageView = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        contentView.addConstraints([topImageView, leftImageView, rightImageView, bottomImageView])
    }
    
    func setupConstraintLabel() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let leftLabel = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: imageView, attribute: .left, multiplier: 1.0, constant: 0)
        
        let rightLabel = NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: imageView, attribute: .right, multiplier: 1.0, constant: 0)
        
        let bottomLabel = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        imageView.addConstraints([leftLabel, rightLabel, bottomLabel])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

