//
//  UserDefaults.swift
//  Peretz
//
//  Created by Рамазан on 30.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation

struct KorzinaModel: Codable {
    var menuItem: MenuItem
    var countInCart: Int
}

final class Korzina {

    static let shared = Korzina()

    private let key = "korzina_peretz"
    private var menu: [KorzinaModel] = [] {
        didSet {
            NotificationCenter.default.post(name: .showKorzinaKey, object: nil)
        }
        
    }
    
    private init() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let menuFromDataBase = try? JSONDecoder().decode([KorzinaModel].self, from: data)
        else { return }
        menu.append(contentsOf: menuFromDataBase)
    }
    
    // Проверка на нахождение в ЮзерДефаултс
    func isAddedToCart(item: MenuItem?) -> Bool {
        if let _ = menu.firstIndex(where: { $0.menuItem.id == item?.id}) {
            return true
        } else {
            return false
        }
    }
    
    
    // Проверка и добавление элемента или увеличение уличества
    func addToCart(item: MenuItem) -> Int {
        if let index = menu.firstIndex(where: { $0.menuItem.id == item.id}) {
            menu[index].countInCart += 1
            synchronize()
            return menu[index].countInCart
        } else {
            let newItemKorzina = KorzinaModel(menuItem: item, countInCart: 1)
            menu.append(newItemKorzina)
            synchronize()
            return 1
        }
    }
    
    
    // Проверка количества
    func checkCount(item: MenuItem) -> Int {
        if let index = menu.firstIndex(where: { $0.menuItem.id == item.id}) {
            let countInCart = menu[index].countInCart
            return countInCart
        } else {
            return 0
        }
    }
    
    
    // Проверка и удаление записи
    func removeFromCart(item: MenuItem) -> Int {
        if let index = menu.firstIndex(where: { $0.menuItem.id == item.id}) {
            if menu[index].countInCart > 1 {
                menu[index].countInCart -= 1
                synchronize()
                return menu[index].countInCart
            } else {
                menu.remove(at: index)
                synchronize()
                return 0
            }
        } else {
            return 0
        }
    }
    
    
    // Очистка
    func clear() {
        menu.removeAll()
        synchronize()
    }
    
    
    // Обновление данных
    private func synchronize() {
        guard
            let menu = try? JSONEncoder().encode(menu)
        else { return }
        UserDefaults.standard.set(menu, forKey: key)
    }
    
    
    // Подсчет общей суммы корзины
    func countAllPrice() -> Int {
        var allPrice = 0
        for item in menu {
            let count = item.countInCart
            let price = item.menuItem.price
            allPrice += count * price
        }
        return allPrice
    }
    
    
    // Подсчет количества позиций в корзине
    func countItems() -> Int {
        return menu.count
    }
}
