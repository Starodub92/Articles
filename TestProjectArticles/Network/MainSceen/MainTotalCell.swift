//
//  MainTotalCell.swift
//  TestProjectArticles
//
//  Created by Дмитрий Стародубцев on 16.03.2022.
//

import UIKit

protocol CellDelegate: AnyObject {
    func didChoosed(info: Information)
    func itemSelected(id: String) -> Bool
}

class MainTotalCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    
    var items: [Information] = []
    weak var delegate: CellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 180)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        contentView.addSubview(collectionView)
        setupConstraint()
        
    }
    
    func setup(images: [Information]) {
        items = images
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info = items[indexPath.row]
        self.delegate?.didChoosed(info: info)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        let info = items[indexPath.row]
        cell.imageView.loadImage(info.image.oneX)
        cell.imageView.kf.indicatorType = .activity
        cell.label.text = info.title
        cell.backgroundColor = .clear
        cell.cellSelected = delegate?.itemSelected(id: info.id) ?? false
        
        return cell
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let topCollectionView = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        
        let heightAnchor = collectionView.heightAnchor.constraint(equalToConstant: 180)
        
        let bottomImageView = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let leftCollectionView = NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0)
        
        let rightCollectionView = NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0)
        
        addConstraints([topCollectionView, heightAnchor, bottomImageView, leftCollectionView, rightCollectionView])
        
    }
    
}
