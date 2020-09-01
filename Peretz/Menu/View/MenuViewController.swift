//
//  MenuViewController.swift
//  Peretz
//
//  Created by Рамазан on 26.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {

    var menuPresenter: MenuPresenterProtocol?
    var menuItems: [MenuItem] = [] {
        didSet {
            menuTableView.reloadData()
        }
    }
    
    var korzinaViewXib = KorzinaViewClass()
    var korzinaBottom = NSLayoutConstraint()
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuPresenter = MenuPresenter(view: self)
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.separatorColor = .black
        menuTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
        createKorzinaXib()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKorzinaXib), name: .showKorzinaKey, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        showKorzinaXib()
    }
    
    func createKorzinaXib() {
        self.view.addSubview(korzinaViewXib)
        korzinaViewXib.translatesAutoresizingMaskIntoConstraints = false
        korzinaViewXib.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
        korzinaViewXib.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
        korzinaViewXib.heightAnchor.constraint(equalToConstant: 60).isActive = true
        korzinaBottom = korzinaViewXib.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100)
        korzinaBottom.isActive = true
    }
    
}


// MARK: - TableView Delegate

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = menuTableView.dequeueReusableCell(withIdentifier: "MyMenuCell", for: indexPath) as! MenuCell
        let index = indexPath.row
        let menuItem = menuItems[index]
        
        menuCell.delegate = self
        menuCell.index = indexPath
        menuCell.setData(item: menuItem)
        menuCell.selectionStyle = .none
        
        return menuCell
    }
    
    
}
