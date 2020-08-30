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
    
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuPresenter = MenuPresenter(view: self)
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.separatorColor = .black
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
        
        return menuCell
    }
    
}
