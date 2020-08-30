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
        
    }
    
    func hideLoading() {
        
    }
    
}


extension MenuViewController: MenuCellButtonsProtocol {
    
    func plusFunc(index: Int, senderCell: MenuCell) {
        print("PLUS")
        let countInCart = Korzina.shared.addToCart(item: menuItems[index])
        if countInCart > 0 {
            senderCell.countLabel.text = String(countInCart)
            senderCell.showCountKorzina()
        } else {
            print("error")
        }
    }
    
    
    func minusFunc(index: Int, senderCell: MenuCell) {
        print("MINUS")
        if Korzina.shared.isAddedToCart(item: menuItems[index]) {
            let countInCart = Korzina.shared.removeFromCart(item: menuItems[index])
            if countInCart > 0 {
                senderCell.countLabel.text = String(countInCart)
            } else {
                senderCell.hideCountCorzina()
            }
        }
    }
    
}


extension MenuViewController {
    
    func showKorzinaView1() {
        let myFirstLabel = UILabel()
        myFirstLabel.text = "I made a label on the screen #toogood4you"
        myFirstLabel.font = UIFont(name: "MarkerFelt-Thin", size: 45)
        myFirstLabel.textColor = UIColor.red
        myFirstLabel.textAlignment = .center
        myFirstLabel.numberOfLines = 5
        myFirstLabel.frame = CGRect(x: 15, y: 54, width: 300, height: 500)
        self.view.addSubview(myFirstLabel)
    }
}
