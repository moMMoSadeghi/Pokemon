//
//  DetailsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit



protocol DetailsPokemonViewControllerDelegate {
    func didSendFavoritePokemon(favoritePokemon : FavoritePokemonModel)
}



class DetailsPokemonViewController: UIViewController {
    
    
    
    private let detailsScrollView              = UIScrollView()
    private let pokemonProfileView             = UIView()
    private let pokemonDetailsStackView        = UIStackView()
//    var pokemonSelected                        = ""
    var delegate                               : DetailsPokemonViewControllerDelegate?
    var pokemon                                : PokemonDataModel
    var id                                     : Int
    
    init(pokemon : PokemonDataModel, id : Int) {
        self.pokemon = pokemon
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = "Pokemon Details"
//        let favoriteRightNavBarButtonItem  =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavoritePokemons))
//        navigationItem.rightBarButtonItem = favoriteRightNavBarButtonItem
        navigationController?.navigationBar.tintColor = .yellow
        configurePokemonDetailsScrollView()
        configurePokemonProfileUIView()
        configureDetailsStackView()
        
    }
    
    
//    private func setupNavBarButtonItem () {
//        navigationController?.navigationBar.topItem?.rightBarButtonItem = favoriteRightNavBarButtonItem
//    }
    @objc func addTapped() {
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectedPokemonImageConstraint()
        selectedPokemonNameLableConstraint()
    }
    
   
    
    @objc func addToFavoritePokemons() {
        
    }
    
    
//    Configuring DetailsScrollView
    private func configurePokemonDetailsScrollView() {
        view.addSubview(detailsScrollView)
        detailsScrollView.layer.cornerRadius = 15
        addProfileUIViewAndDetailsStackViewToScrollView()
        setupPokemonDetailsScrollViewConstraint()
    }
    
//    Configuring DetailsScrollView Constraint
    private func setupPokemonDetailsScrollViewConstraint() {
        detailsScrollView.translatesAutoresizingMaskIntoConstraints = false
        detailsScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        detailsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
//    Adding ProfileUIView and StackView to the ScrollView
    private func addProfileUIViewAndDetailsStackViewToScrollView() {
        detailsScrollView.addSubview(pokemonProfileView)
        detailsScrollView.addSubview(pokemonDetailsStackView)
    }
    
    
    
//        Creating Selected Pokemon UIImage
    private let selectedPokemonImage : UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.image = UIImage(named: "2")
        image.layer.cornerRadius = (image.frame.size.width ) / 5
        image.layer.borderWidth = 3.0
//        image.backgroundColor = .white
        image.layer.borderColor = UIColor.systemRed.cgColor
        return image
    }()
    
    
//        Creating Selected Pokemon UINameLable
    private let selectedPokemonNameLable : UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.text = "Selected Pokemon"
        lable.font = .boldSystemFont(ofSize: 35)
        lable.textAlignment = .center
        lable.font = .systemFont(ofSize: 25)
        return lable
    }()
    
//        Setting Selected Pokemon Image Constraint
    private func selectedPokemonImageConstraint() {
        
        selectedPokemonImage.translatesAutoresizingMaskIntoConstraints = false
        selectedPokemonImage.centerXAnchor.constraint(equalTo: pokemonProfileView.centerXAnchor).isActive = true
        selectedPokemonImage.topAnchor.constraint(equalTo: pokemonProfileView.topAnchor, constant: 30).isActive = true
        selectedPokemonImage.widthAnchor.constraint(equalTo: pokemonProfileView.widthAnchor, multiplier: 0.3).isActive = true
        selectedPokemonImage.heightAnchor.constraint(equalTo: selectedPokemonImage.widthAnchor).isActive = true
    }
    
//        Seting Selected Pokemon Name Lable Constraint
    private func selectedPokemonNameLableConstraint() {
        
        selectedPokemonNameLable.translatesAutoresizingMaskIntoConstraints = false
        selectedPokemonNameLable.centerXAnchor.constraint(equalTo: pokemonProfileView.centerXAnchor).isActive = true
        selectedPokemonNameLable.topAnchor.constraint(equalTo: selectedPokemonImage.bottomAnchor, constant: 5).isActive = true
        selectedPokemonNameLable.widthAnchor.constraint(greaterThanOrEqualTo: pokemonProfileView.widthAnchor, multiplier: 0.4).isActive = true
        selectedPokemonNameLable.heightAnchor.constraint(equalTo: selectedPokemonImage.widthAnchor).isActive = true
        
//
//        selectedPokemonNameLable.bottomAnchor.constraint(equalTo: pokemonProfileView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    
//    Configuring Selected Pokemon Profile UIView
    private func configurePokemonProfileUIView() {
        pokemonProfileView.layer.cornerRadius = 15
        pokemonProfileView.backgroundColor = .blue
        setupPokemonProfileUIViewConstraint()
        addPokemonImageAndNameToProfileUIView()
        
    }
    
    
//    Configuring Selected Pokemon Profile UIView Constraint
    private func setupPokemonProfileUIViewConstraint() {
        pokemonProfileView.translatesAutoresizingMaskIntoConstraints = false
        pokemonProfileView.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor).isActive = true
        pokemonProfileView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 5).isActive = true
//        pokemonProfileView.bottomAnchor.constraint(equalTo: pokemonDetailsStackView.topAnchor, constant: 10).isActive = true
//        pokemonProfileView.widthAnchor.constraint(greaterThanOrEqualTo: pokemonProfileView.widthAnchor, multiplier: 0.4).isActive = true
        pokemonProfileView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 5).isActive = true
        pokemonProfileView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor, constant: -5).isActive = true
    }
    
//    Adding Selected Pokemon Image and Name to ProfileUIView
    private func addPokemonImageAndNameToProfileUIView() {
        pokemonProfileView.addSubview(selectedPokemonImage)
        pokemonProfileView.addSubview(selectedPokemonNameLable)
    }
    
//    Configuring Details StackView
    private func configureDetailsStackView() {
        detailsScrollView.addSubview(pokemonDetailsStackView)
        pokemonDetailsStackView.axis = .vertical
//        pokemonDetailsStackView.backgroundColor = .red
        pokemonDetailsStackView.distribution = .fillEqually
        pokemonDetailsStackView.spacing = 50
        setupDetailsStackViewConstraint()
        addPokemonDetailsLableToStackView()
    }
    
//    Setting Details StackView Constraint
    private func setupDetailsStackViewConstraint() {
        pokemonDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonDetailsStackView.topAnchor.constraint(equalTo: selectedPokemonNameLable.bottomAnchor, constant: 20).isActive = true
        pokemonDetailsStackView.bottomAnchor.constraint(equalTo: detailsScrollView.bottomAnchor, constant: -10).isActive = true
        pokemonDetailsStackView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 10).isActive = true
        pokemonDetailsStackView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor, constant: -40).isActive = true
    }
    
    
//    Creating HP ProgressBar View
    private let hpProgressBar :  UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 4)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.setProgress(0.5, animated: true)
        progressBar.trackTintColor = .darkGray
        progressBar.tintColor = .green
        return progressBar
    }()
    
//    private func hpProgressBarConstraint() {
//        hpProgressBar.translatesAutoresizingMaskIntoConstraints = false
//        hpProgressBar.topAnchor.constraint(equalTo: pokemonDetailsStackView.topAnchor, constant: 5).isActive = true
//        hpProgressBar.leadingAnchor.constraint(equalTo: pokemonDetailsStackView.leadingAnchor, constant: 5).isActive = true
//        hpProgressBar.trailingAnchor.constraint(equalTo: pokemonDetailsStackView.trailingAnchor, constant: 5).isActive = true
//    }
    
    
//       Creating Attack ProgressBar View
    private let attackProgressBar :  UIProgressView = {
        let progressBar = UIProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progressBar.progressViewStyle = .bar
        progressBar.transform = CGAffineTransformMakeScale(1, 4)
        progressBar.setProgress(0.1, animated: true)
        progressBar.trackTintColor = .darkGray
        progressBar.tintColor = .green
        return progressBar
    }()
    
    
//        Creating Defense ProgressBar View
    private let defenseProgressBar :  UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.transform = CGAffineTransformMakeScale(1, 4)
        progressBar.setProgress(0.2, animated: true)
        progressBar.trackTintColor = .darkGray
        progressBar.tintColor = .green
        return progressBar
    }()
    
//        Creating Special Attack ProgressBar View
    private let specialAttackProgressBar :  UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.transform = CGAffineTransformMakeScale(1, 4)
        progressBar.setProgress(0.3, animated: true)
        progressBar.trackTintColor = .darkGray
        progressBar.tintColor = .green
        return progressBar
    }()
    
    
//    Creating Special Defense ProgressBar View
    private let specialDefenseProgressBar :  UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.transform = CGAffineTransformMakeScale(1, 4)
        progressBar.setProgress(0.4, animated: true)
        progressBar.trackTintColor = .darkGray
        progressBar.tintColor = .green
        return progressBar
    }()
    
    
//    Adding Selected Pokemons Details Progress TabBar to ScrollView
    private func addPokemonDetailsLableToStackView() {
        pokemonDetailsStackView.addArrangedSubview(hpProgressBar)
        pokemonDetailsStackView.addArrangedSubview(attackProgressBar)
        pokemonDetailsStackView.addArrangedSubview(defenseProgressBar)
        pokemonDetailsStackView.addArrangedSubview(specialAttackProgressBar)
        pokemonDetailsStackView.addArrangedSubview(specialDefenseProgressBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layer.cornerRadius = 15

    }
    
    
    
}
