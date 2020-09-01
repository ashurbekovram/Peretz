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



// MARK: - Menu view protocol
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


// MARK: - Cell buttons protocol
extension MenuViewController: MenuCellButtonsProtocol {
    
    func plusFunc(index: Int, senderCell: MenuCell) {
        senderCell.showCountKorzina()
        let countInCart = Korzina.shared.addToCart(item: menuItems[index])
        senderCell.countLabel.text = String(countInCart)
        //self.showKorzinaView()
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
        //self.showKorzinaView()
    }
    
}


// MARK: - Korzina view protocol

extension MenuViewController: KorzinaViewProtocol {
    
    
    @objc func showKorzinaXib() {
        korzinaViewXib.countAllCart()
        
        let allPrice = Korzina.shared.countAllPrice()
        if allPrice > 0 {
            self.korzinaBottom.constant = -60
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            self.korzinaBottom.constant = 100
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
}

