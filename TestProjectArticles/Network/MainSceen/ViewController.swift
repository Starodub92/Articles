//
//  ViewController.swift
//  TestProjectArticles
//
//  Created by Дмитрий Стародубцев on 16.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var networkHotelManeger = NetworkArticlesManager()
    var articles: [CurrentAtriclesData] = []
    private var mainTableView: UITableView = UITableView(frame: .zero)
    var selectedIds: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkHotelManeger.fetchCurrentArticles { [weak self]  articles in
            guard let self = self else { return }
            self.articles = articles
            self.mainTableView.reloadData()
        } failure: { error in
            print(error.localizedDescription)
        }
        
        mainTableView.backgroundColor = .clear
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 200
        self.view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.register(MainTotalCell.self, forCellReuseIdentifier: "MyCell")
        setupMainTableVeiwConstrats()
        mainTableView.tableFooterView = UIView()
        
    }
    
    
    func setupMainTableVeiwConstrats() {
        
        let topMainTableView = NSLayoutConstraint(item:mainTableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
        
        let bottomMainTableView = NSLayoutConstraint(item: mainTableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
        
        let leftMainTableView = NSLayoutConstraint(item: mainTableView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
        
        let rightMainTableView = NSLayoutConstraint(item: mainTableView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
        
        view.addConstraints ([topMainTableView, bottomMainTableView, leftMainTableView, rightMainTableView])
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MainTotalCell
        let section = indexPath.section
        let article = articles[section]
        
        cell.setup(images: article.items)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let atricle = articles[section]
        return atricle.header
    }
}

extension ViewController: CellDelegate {
    func itemSelected(id: String) -> Bool {
        selectedIds.contains(id)
    }
    
    func didChoosed(info: Information) {
        
        
        let id = info.id
        if selectedIds.contains(id) {
            selectedIds.remove(id)
        } else {
            if selectedIds.count > 5 {
                let alert = UIAlertController(title: "Внимание", message: "Много", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            selectedIds.insert(id)
        }
        mainTableView.reloadData()
    }
}

