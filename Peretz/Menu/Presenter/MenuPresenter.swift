//
//  MenuPresenter.swift
//  Peretz
//
//  Created by Рамазан on 28.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation
import Alamofire



protocol MenuPresenterProtocol {
    func getMenuItems()
    
    init(view: MenuViewProtocol)
}



class MenuPresenter: MenuPresenterProtocol {
    
    private let service = MenuService()
    
    // MARK: - init
    
    required init (view: MenuViewProtocol) {
        self.view = view
        getMenuItems()
    }
    
    // MARK: - getItems
    
    var view: MenuViewProtocol?
    
    func getMenuItems() {
        
        self.view?.showLoading()
            
        service.getDishs(onSuccess: { (items) in
            self.view?.setMenuItems(items: items)
            self.view?.hideLoading()
        }, onFailure: { (error) in
            
        })
        
        
    }
    
}
