//
//  KorzinaViewClass.swift
//  Peretz
//
//  Created by Рамазан on 01.09.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit


protocol KorzinaViewProtocol {
    func showKorzinaXib()
}



class KorzinaViewClass: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var itemsInCartLabel: UILabel!
    @IBOutlet weak var allPriceLabel: UILabel!
    
    
    // Переопределяем стандартные инициализаторы View для кода и сторибоарда
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // Прописываем собственный инициализатор
    func commonInit() {
        Bundle.main.loadNibNamed("KorzinaView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        countAllCart()
    }
    
    
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
        
        self.allPriceLabel.text = String(allPrice) + " ₽"
        self.itemsInCartLabel.text = String(itemsInCart) + text
    }
}
