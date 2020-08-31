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
    @IBOutlet weak var menuActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var korzinaView: UIView!
    @IBOutlet weak var allPriceLabel: UILabel!
    @IBOutlet weak var itemsInCartLabel: UILabel!
    
    @IBOutlet weak var korzinaBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuPresenter = MenuPresenter(view: self)
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.separatorColor = .black
        
        korzinaBottomConstraint.constant = -100
        menuTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        korzinaView.layer.borderWidth = 4
        korzinaView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        showKorzinaView()
    }
}


// MARK: - Korzina view

extension MenuViewController {
    
    // Подсчет цены и вывод ее на вью корзины
    func countAllCart() {
        let allPrice = Korzina.shared.countAllPrice()
        let itemsInCart = Korzina.shared.countItems()
        
        var text = ""
        switch itemsInCart {
        case 1:
            text = " блюдо"
        case 2, 3, 4:
            text = " блюда"
        default:
            text = " блюд"
        }
        
        allPriceLabel.text = String(allPrice) + " ₽"
        itemsInCartLabel.text = String(itemsInCart) + text
    }
    
    // Отображение или сокрытие вью корзины
    func showKorzinaView() {
        countAllCart()
        
        let allPrice = Korzina.shared.countAllPrice()
        if allPrice > 0 {
            korzinaBottomConstraint?.constant = 20
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            korzinaBottomConstraint?.constant = -100
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
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
