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
    
    
    //MARK: - Outlets
    
    private let pokemonUITabBarStackView = UIStackView()
    private let detailsScrollView        = UIScrollView()
    private let pokemonProfileView       = UIView()
    private let pokemonDetailsStackView  = UIStackView()
    
    
    
    //MARK: - Variables
    
    
    var pokemon                          : PokemonDataModel
    var id                               : Int
    //    var pokemonSelected                  : PokemonDataModel
    //    var delegate                         : DetailsPokemonViewControllerDelegate?
    
    
    
    init(pokemon : PokemonDataModel, id : Int) {
        self.pokemon = pokemon
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGreen
        
        configureTabBarStackView()
        configurePokemonDetailsScrollView()
        configurePokemonProfileUIView()
        configureDetailsStackView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        selectedPokemonImageConstraint()
        selectedPokemonNameLableConstraint()
        
    }
    
    
    //MARK: -   UI Outlets
    
    
    //        Creating Cancel Bar Button
    private lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(cancelModalpage), for: .touchUpInside)
        return button
    }()
    
    //        Creating info Bar Lable
    private lazy var tabBarTitleLable : UILabel = {
        let lable           = UILabel()
        lable.textColor     = .darkGray
        lable.text          = "info"
        lable.font          = .boldSystemFont(ofSize: 35)
        lable.textAlignment = .center
        return lable
    }()
    
    
    //        Creating Add Bar Button
    private lazy var addButton : UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    
    
    //        Creating Selected Pokemon UIImage
    private lazy var selectedPokemonImage : UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, 90, 90))
        image.contentMode        = .scaleAspectFit
        image.clipsToBounds      = true
        image.layer.borderWidth  = 3.0
        image.layer.cornerRadius = (image.frame.size.width ) / 2
        image.backgroundColor    = UIColor(red: 0.9, green: 0.5, blue: 0.4, alpha: 0.4)
        image.layer.borderColor  = UIColor.systemRed.cgColor
        image.image              = UIImage(named: "2")
        return image
    }()
    
    
    
    
    
    
    @objc func addToFavoritePokemons() {
        
    }
    
    
    
    
    //    Configuring DetailsScrollView
    private func configurePokemonDetailsScrollView() {
        view.addSubview(detailsScrollView)
        detailsScrollView.layer.cornerRadius = 15
        setupPokemonDetailsScrollViewConstraint()
        addpokemonDetailsStackViewAndProfileUIViewAndDetailsStackViewToScrollView()
    }
    
    //    Configuring DetailsScrollView Constraint
    private func setupPokemonDetailsScrollViewConstraint() {
        detailsScrollView.translatesAutoresizingMaskIntoConstraints = false
        detailsScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        detailsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    //    Adding ProfileUIView and StackView to the ScrollView
    private func addpokemonDetailsStackViewAndProfileUIViewAndDetailsStackViewToScrollView() {
        detailsScrollView.addSubview(pokemonProfileView)
        detailsScrollView.addSubview(pokemonUITabBarStackView)
        detailsScrollView.addSubview(pokemonDetailsStackView)
    }
    
    
    //        Creating Selected Pokemon UINameLable
    private lazy var selectedPokemonNameLable : UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.text = pokemon.name.uppercased()
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
        pokemonProfileView.topAnchor.constraint(equalTo: pokemonUITabBarStackView.bottomAnchor, constant: 30).isActive = true
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
    
    
    private func configureTabBarStackView() {
        detailsScrollView.addSubview(pokemonUITabBarStackView)
        pokemonUITabBarStackView.axis = .horizontal
        //        pokemonUITabBarStackView.backgroundColor = .red
        pokemonUITabBarStackView.distribution = .fillEqually
        pokemonUITabBarStackView.spacing = 10
        setupPokemonUITabBarStackViewConstraint()
        addElementsPokemonUITabBarStackView()
    }
    
    
    private func setupPokemonUITabBarStackViewConstraint() {
        pokemonUITabBarStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonUITabBarStackView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 25).isActive = true
        //        pokemonUITabBarStackView.bottomAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 10).isActive = true
        pokemonUITabBarStackView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor).isActive = true
        pokemonUITabBarStackView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor).isActive = true
    }
    
    private func addElementsPokemonUITabBarStackView() {
        pokemonUITabBarStackView.addArrangedSubview(cancelButton)
        pokemonUITabBarStackView.addArrangedSubview(tabBarTitleLable)
        pokemonUITabBarStackView.addArrangedSubview(addButton)
        
    }
    
    
    
    @objc func addToFavorite() {
        let addButtonAlert = UIAlertController(title: "Add Pokemons?", message: "Would you like to add this pokemon to your favorite ones?", preferredStyle: UIAlertController.Style.alert)
        
        addButtonAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        addButtonAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(addButtonAlert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    @objc func cancelModalpage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //    Creating HP ProgressBar View
    private let hpProgressBar :  UIProgressView = {
        let progressBar                                       = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressViewStyle                         = .bar
        progressBar.transform                                 = progressBar.transform.scaledBy(x: 1, y: 4)
        progressBar.trackTintColor                            = .darkGray
        progressBar.tintColor                                 = .green
        progressBar.setProgress(0.5, animated: true)
        return progressBar
    }()
    
    
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
