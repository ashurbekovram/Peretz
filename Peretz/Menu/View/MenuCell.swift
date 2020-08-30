//
//  MenuCell.swift
//  Peretz
//
//  Created by Рамазан on 26.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit
import SDWebImage


protocol MenuCellButtonsProtocol {
    func plusFunc(index: Int, senderCell: MenuCell)
    func minusFunc(index: Int, senderCell: MenuCell)
}


class MenuCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var delegate: MenuCellButtonsProtocol?
    var index: IndexPath?
    
    // Заполнение ячейки данными
    func setData(item: MenuItem) {
        let imageURL = item.image
        self.itemImage.sd_setImage(with: URL(string: imageURL), completed: nil)
        self.titleLabel.text = item.name
        self.descrLabel.text = item.description
        self.priceLabel.text = String(item.price) + " ₽"
        
        if Korzina.shared.isAddedToCart(item: item) {
            self.showCountKorzina()
            let countInCart = Korzina.shared.checkCount(item: item)
            self.countLabel.text = String(countInCart)
        } else {
            self.hideCountCorzina()
        }
    }
    
    // Отображение счетчика корзины
    func showCountKorzina() {
        countLabel.isHidden = false
        minusButton.isHidden = false
    }
    
    // Сокрытие счетчика корзины
    func hideCountCorzina() {
        countLabel.isHidden = true
        minusButton.isHidden = true
    }
    
    
    // MARK: - Default func
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func plusAction(_ sender: Any) {
        delegate?.plusFunc(index: index?.row ?? 0, senderCell: self)
    }
    
    @IBAction func minusAction(_ sender: Any) {
        delegate?.minusFunc(index: index?.row ?? 0, senderCell: self)
    }
    
}
