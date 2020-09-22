//
//  MenuService.swift
//  Peretz
//
//  Created by Рамазан on 02.09.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation
import Alamofire

final class MenuService {
    
    func getDishs(onSuccess: @escaping ([MenuItem]) -> Void, onFailure: @escaping (String) -> Void) {
        
        AF.request("https://peretz-group.ru/api/v2/products?category=93&key=47be9031474183ea92958d5e255d888e47bdad44afd5d7b7201d0eb572be5278").responseData { response in
            switch response.result {
            case .success(let resultJSON):
                let resultArray = try? JSONDecoder().decode([MenuItem].self, from: resultJSON)
                onSuccess(resultArray ?? [])
            case .failure(let error):
                onFailure(error.localizedDescription)
            }
        }
    }
}
