//
//  MenuViewProtocols.swift
//  Peretz
//
//  Created by Рамазан on 28.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation
import UIKit

protocol MenuViewProtocol {
    func setMenuItems(items: [MenuItem])
    func showLoading()
    func hideLoading()
}

extension MenuViewController: MenuViewProtocol {
    func setMenuItems(items: [MenuItem]) {
        menuItems.append(contentsOf: items)
    }
    
    func showLoading() {
        self.menuTableView.separatorStyle = .none
        menuActivityIndicator.startAnimating()
        menuActivityIndicator.isHidden = false
    }
    
    func hideLoading() {
        self.menuTableView.separatorStyle = .singleLine
        menuActivityIndicator.stopAnimating()
        menuActivityIndicator.isHidden = true
    }
    
}


extension MenuViewController: MenuCellButtonsProtocol {
    
    func plusFunc(index: Int, senderCell: MenuCell) {
        senderCell.showCountKorzina()
        let countInCart = Korzina.shared.addToCart(item: menuItems[index])
        senderCell.countLabel.text = String(countInCart)
        self.showKorzinaView()
    }
    
    
    func minusFunc(index: Int, senderCell: MenuCell) {
        if Korzina.shared.isAddedToCart(item: menuItems[index]) {
            let countInCart = Korzina.shared.removeFromCart(item: menuItems[index])
            if countInCart > 0 {
                senderCell.countLabel.text = String(countInCart)
            } else {
                senderCell.hideCountCorzina()
            }
        }
        self.showKorzinaView()
    }
    
}
