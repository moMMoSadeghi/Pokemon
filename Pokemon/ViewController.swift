//
//  ViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    let mainTabBarController = UITabBarController()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTabBarController()
        view.backgroundColor = .black
        
    }
    
    
    func setupTabBarController() {
        mainTabBarController.tabBar.backgroundColor = .darkGray
        mainTabBarController.tabBar.tintColor = .white
          let pokemonsViewController = UINavigationController(rootViewController: PokemonsViewController())
          let favoritePokemonsViewController = UINavigationController(rootViewController: FavoritePokemonsViewController())
        mainTabBarController.setViewControllers([pokemonsViewController, favoritePokemonsViewController], animated: false)
        mainTabBarController.modalPresentationStyle = .fullScreen
          present(mainTabBarController, animated: true)
      }
    

}

