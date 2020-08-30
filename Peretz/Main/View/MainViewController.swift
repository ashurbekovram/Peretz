//
//  ViewController.swift
//  Peretz
//
//  Created by Рамазан on 26.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showMenuButton(_ sender: Any) {
        
        if let menuVC = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(identifier: "MenuStoryboard") as? MenuViewController {
            if let navController = navigationController {
                navController.pushViewController(menuVC, animated: true)
            }
        }

        //        let menuStoryboard = UIStoryboard(name: "Menu", bundle: nil)
        //        let menuVC = menuStoryboard.instantiateViewController(identifier: "MenuStoryboard")
        //        navigationController?.pushViewController(menuVC, animated: true)
    }
    
}

