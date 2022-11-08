//
//  ViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

class ViewController: UIViewController {
    
//    let networkManager = NetworkManager()
    let mainTabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTabBarController()
        view.backgroundColor = .black
        
    }
    
    
    private func configureTabBarController() {
        mainTabBarController.tabBar.backgroundColor = .systemGray5
        mainTabBarController.tabBar.tintColor = .white
    }
    
    private func setupTabBarController() {
        
//        let viewModel = PokemonsViewModel(networkManaget: networkManager)
        
        let pokemonsViewController = UINavigationController(rootViewController: PokemonsViewController())
        pokemonsViewController.tabBarItem.image = UIImage(systemName: "folder")
        pokemonsViewController.tabBarItem.title = "Pokemons"
        pokemonsViewController.tabBarItem.selectedImage = UIImage(systemName: "folder.fill")
        
        let favoritePokemonsViewController = UINavigationController(rootViewController: FavoritePokemonsViewController()) 
        favoritePokemonsViewController.tabBarItem.image = UIImage(systemName: "heart")
        favoritePokemonsViewController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favoritePokemonsViewController.tabBarItem.title = "Favorite Pokemons"
        
        mainTabBarController.setViewControllers([pokemonsViewController, favoritePokemonsViewController], animated: false)
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true)
    }
    
}





