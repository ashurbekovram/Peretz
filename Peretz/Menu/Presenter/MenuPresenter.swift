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
    
    // MARK: - init
    
    required init (view: MenuViewProtocol) {
        self.view = view
        getMenuItems()
    }
    
    // MARK: - getItems
    
    var view: MenuViewProtocol?
    
    func getMenuItems() {
        self.view?.showLoading()
        AF.request("https://peretz-group.ru/api/v2/products?category=93&key=47be9031474183ea92958d5e255d888e47bdad44afd5d7b7201d0eb572be5278").responseData { response in
            switch response.result {
            case .success(let resultJSON):
                let resultArray = try? JSONDecoder().decode([MenuItem].self, from: resultJSON)
                print(resultArray ?? "resultArray = nil")
                self.view?.setMenuItems(items: resultArray ?? [])
            case .failure(let error):
                print(error)
            }
            self.view?.hideLoading()
        }
    }
    
}
