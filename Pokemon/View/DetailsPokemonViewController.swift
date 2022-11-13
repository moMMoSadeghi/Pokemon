//
//  DetailsViewController.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit
import Kingfisher




class DetailsPokemonViewController: UIViewController {
    
    
    //MARK: - Outlets
    
    private let pokemonUITabBarStackView = UIStackView()
    private let detailsScrollView        = UIScrollView()
    private let pokemonProfileView       = UIView()
    private let pokemonDetailsStackView  = UIStackView()
    
    
    
    //MARK: - Variables
    
    
    var pokemon                 : PokemonDataModel!
    var id                      : Int!
    var preparedID              : Int  {
        ((id ?? 0) + 1)
    }
    var stats                   = [Stats]()
    var pokAbilities            : [Ability]?
    var detailsPokemonViewModel = DetailsPokemonViewModel()
    var allFavoritePokemons     : [FavoritePokemonModel]?
    let userDefaultsManager     = UserDefaulsManager()
    
    //    var pokemonSelected   : PokemonDataModel
    //    var delegate          : DetailsPokemonViewControllerDelegate?
    
    
    
    init(pokemon : PokemonDataModel, id : Int) {
        self.pokemon = pokemon
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {}
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(named: "detailsViewControllerBackground")
        view.layer.cornerRadius = 15
        
        configureTabBarStackView()
        configurePokemonDetailsScrollView()
        configurePokemonProfileUIView()
        configureDetailsStackView()
        fetchPokemonsDetails()
        selectedPokemonImageConstraint()
        selectedPokemonNameLableConstraint()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //MARK: -   UI IBOutlets
    
    
    //MARK: -   TabBar IBOutlets
    
    ///        Creating Cancel Bar Button
    private lazy var cancelButton : UIButton = {
        let button                = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(cancelModalpage), for: .touchUpInside)
        return button
    }()
    
    ///        Creating selectedPokemonNumberLable
    private lazy var selectedPokemonNumberLable : UILabel = {
        let lable           = UILabel()
        lable.textColor     = UIColor(named: "detailsNumLable")
        lable.text          = String("#\(preparedID)")
        lable.textAlignment = .center
        lable.font          = UIFont(name:"Chalkboard SE", size: 28)
        return lable
    }()
    
    
    ///        Creating Add Bar Button
    private lazy var addButton : UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    
    
    
    /// Setting up TabBarStackView
    private func configureTabBarStackView() {
        detailsScrollView.addSubview(pokemonUITabBarStackView)
        pokemonUITabBarStackView.axis         = .horizontal
        pokemonUITabBarStackView.distribution = .fillEqually
        pokemonUITabBarStackView.spacing      = 30
        setupPokemonUITabBarStackViewConstraint()
        addElementsPokemonUITabBarStackView()
    }
    
    
    /// Setting up the TabBar StackView Constraints
    private func setupPokemonUITabBarStackViewConstraint() {
        pokemonUITabBarStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonUITabBarStackView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 25).isActive = true
        pokemonUITabBarStackView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor).isActive       = true
        pokemonUITabBarStackView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor).isActive     = true
    }
    
    /// Adding custom TabBar Elements to StackView
    private func addElementsPokemonUITabBarStackView() {
        pokemonUITabBarStackView.addArrangedSubview(cancelButton)
        pokemonUITabBarStackView.addArrangedSubview(selectedPokemonNumberLable)
        pokemonUITabBarStackView.addArrangedSubview(addButton)
        
    }
    
    //MARK: -   Profile IBOutlets
    
    
    ///    Configuring Selected Pokemon Profile UIView
    private func configurePokemonProfileUIView() {
        pokemonProfileView.layer.cornerRadius = 15
        pokemonProfileView.backgroundColor = .blue
        setupPokemonProfileUIViewConstraint()
        addPokemonImageAndNameToProfileUIView()
    }
    
    
    ///    Configuring Selected Pokemon Profile UIView Constraint
    private func setupPokemonProfileUIViewConstraint() {
        pokemonProfileView.translatesAutoresizingMaskIntoConstraints = false
        pokemonProfileView.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor).isActive                 = true
        pokemonProfileView.topAnchor.constraint(equalTo: pokemonUITabBarStackView.bottomAnchor, constant: 30).isActive = true
        pokemonProfileView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 5).isActive    = true
        pokemonProfileView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor, constant: -5).isActive = true
    }
    
    
    ///        Creating Selected Pokemon UIImage
    private lazy var selectedPokemonImage : UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, 90, 90))
        image.contentMode        = .scaleAspectFit
        image.clipsToBounds      = true
        image.layer.borderWidth  = 3.0
        image.layer.cornerRadius = (image.frame.size.width ) / 2
        image.backgroundColor    = UIColor(red: 0.9, green: 0.5, blue: 0.4, alpha: 0.4)
        image.layer.borderColor  = UIColor.systemRed.cgColor
        return image
    }()
    
    ///        Creating Selected Pokemon Name Lable
    private lazy var selectedPokemonNameLable : UILabel = {
        let lable           = UILabel()
        lable.textColor     = .white
        lable.textAlignment = .center
        lable.font          = UIFont(name:"Chalkboard SE", size: 28)
        return lable
    }()
    
    
    ///       Setting Selected Pokemon Image Constraint
    private func selectedPokemonImageConstraint() {
        
        selectedPokemonImage.translatesAutoresizingMaskIntoConstraints = false
        selectedPokemonImage.centerXAnchor.constraint(equalTo: pokemonProfileView.centerXAnchor).isActive              = true
        selectedPokemonImage.topAnchor.constraint(equalTo: pokemonProfileView.topAnchor, constant: 30).isActive        = true
        selectedPokemonImage.widthAnchor.constraint(equalTo: pokemonProfileView.widthAnchor, multiplier: 0.3).isActive = true
        selectedPokemonImage.heightAnchor.constraint(equalTo: selectedPokemonImage.widthAnchor).isActive = true
    }
    
    
    ///        Seting Selected Pokemon Name Lable Constraint
    private func selectedPokemonNameLableConstraint() {
        
        selectedPokemonNameLable.translatesAutoresizingMaskIntoConstraints = false
        selectedPokemonNameLable.centerXAnchor.constraint(equalTo: pokemonProfileView.centerXAnchor).isActive           = true
        selectedPokemonNameLable.topAnchor.constraint(equalTo: selectedPokemonImage.bottomAnchor, constant: 5).isActive = true
        selectedPokemonNameLable.widthAnchor.constraint(greaterThanOrEqualTo: pokemonProfileView.widthAnchor, multiplier: 0.4).isActive = true
        selectedPokemonNameLable.heightAnchor.constraint(equalTo: selectedPokemonImage.widthAnchor).isActive            = true
    }
    
    
    ///    Adding Selected Pokemon Image and Name to ProfileUIView
    private func addPokemonImageAndNameToProfileUIView() {
        pokemonProfileView.addSubview(selectedPokemonImage)
        pokemonProfileView.addSubview(selectedPokemonNameLable)
    }
    
    ///    Configuring DetailsScrollView
    private func configurePokemonDetailsScrollView() {
        view.addSubview(detailsScrollView)
        detailsScrollView.layer.cornerRadius = 15
        setupPokemonDetailsScrollViewConstraint()
        addpokemonDetailsStackViewAndProfileUIViewAndDetailsStackViewToScrollView()
    }
    
    ///    Configuring DetailsScrollView Constraint
    private func setupPokemonDetailsScrollViewConstraint() {
        detailsScrollView.translatesAutoresizingMaskIntoConstraints = false
        detailsScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        detailsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive        = true
        detailsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive      = true
        detailsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive    = true
    }
    
    
    ///    Adding ProfileUIView and StackView to the ScrollView
    private func addpokemonDetailsStackViewAndProfileUIViewAndDetailsStackViewToScrollView() {
        detailsScrollView.addSubview(pokemonProfileView)
        detailsScrollView.addSubview(pokemonUITabBarStackView)
        detailsScrollView.addSubview(pokemonDetailsStackView)
    }
    
    
    
    ///    Configuring Details StackView
    private func configureDetailsStackView() {
        detailsScrollView.addSubview(pokemonDetailsStackView)
        pokemonDetailsStackView.axis = .vertical
        pokemonDetailsStackView.distribution = .fill
        pokemonDetailsStackView.spacing = 30
        setupDetailsStackViewConstraint()
        addPokemonDetailsElementsToStackView()
    }
    
    ///    Setting Details StackView Constraint
    private func setupDetailsStackViewConstraint() {
        pokemonDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonDetailsStackView.topAnchor.constraint(equalTo: selectedPokemonNameLable.bottomAnchor, constant: 20).isActive  = true
        pokemonDetailsStackView.bottomAnchor.constraint(equalTo: detailsScrollView.bottomAnchor, constant: -10).isActive     = true
        pokemonDetailsStackView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 20).isActive    = true
        pokemonDetailsStackView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor, constant: -20).isActive = true
    }
    
    
    ///    Creating Selected Pokemon Abilities Lable
    private lazy var abilitiesLable : UILabel = {
        let lable            = UILabel()
        lable.textColor      = UIColor(named: "abilitiesLableColors")
        lable.font           = UIFont(name:"Chalkboard SE", size: 33)
        lable.textAlignment  = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    ///    Creating Selected Pokemon hpLable
    private lazy var hpLable : UILabel = {
        let lable            = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor      = UIColor(named: "DetailsLable")
        lable.text           = "hp"
        lable.font           = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment  = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    
    
    ///    Creating Selected Pokemon hpProgressBar
    private lazy var hpProgressBar      :  UIProgressView = {
        let progressBar                 = UIProgressView()
        progressBar.progressViewStyle   = .bar
        progressBar.transform           = progressBar.transform.scaledBy(x: 1, y: 4)
        progressBar.trackTintColor      = .gray
        progressBar.tintColor           = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    ///    Creating Selected Pokemon attackLable
    private lazy var attackLable : UILabel = {
        let lable                = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor          = UIColor(named: "DetailsLable")
        lable.text               = "attack"
        lable.font               = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment      = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    ///    Creating Selected Pokemon attackProgressBar
    private lazy var attackProgressBar :  UIProgressView = {
        let progressBar                = UIProgressView()
        progressBar.progressViewStyle  = .bar
        progressBar.transform          = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor     = .gray
        progressBar.tintColor          = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    ///    Creating Selected Pokemon defenseLable
    private lazy var defenseLable        : UILabel = {
        let lable                        = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor                  = UIColor(named: "DetailsLable")
        lable.text                       = "defense"
        lable.font                       = UIFont(name:"Chalkboard SE", size: 28)
        lable.adjustsFontSizeToFitWidth  = true
        lable.textAlignment              = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    ///    Creating Selected Pokemon defenseProgressBar
    private lazy var defenseProgressBar :  UIProgressView = {
        let progressBar                 = UIProgressView()
        progressBar.progressViewStyle   = .bar
        progressBar.transform           = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor      = .gray
        progressBar.tintColor           = UIColor(named: "progressBarTintColor")
        return progressBar
    }()
    
    ///    Creating Selected Pokemon specialAttackLable
    private lazy var specialAttackLable : UILabel = {
        let lable                       = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        lable.textColor                 = UIColor(named: "DetailsLable")
        lable.text                      = "special attack"
        lable.font                      = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment             = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    ///    Creating Selected Pokemon specialAttackProgressBar
    private lazy var specialAttackProgressBar :  UIProgressView = {
        let progressBar                       = UIProgressView()
        progressBar.progressViewStyle         = .bar
        progressBar.transform                 = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor            = .gray
        progressBar.tintColor                 = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    ///    Creating Selected Pokemon specialDefenseLable
    private lazy var specialDefenseLable : UILabel = {
        let lable                        = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor                  = UIColor(named: "DetailsLable")
        lable.text                       = "special defense"
        lable.font                       = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment              = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    ///    Creating Selected Pokemon specialDefenseProgressBar
    private lazy var specialDefenseProgressBar :  UIProgressView = {
        let progressBar                        = UIProgressView()
        progressBar.progressViewStyle          = .bar
        progressBar.transform                  = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor             = .gray
        progressBar.tintColor                  = UIColor(named: "progressBarTintColor")
        return progressBar
    }()
    
    ///    Creating Selected Pokemon speedLable
    private lazy var speedLable : UILabel = {
        let lable               = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor         = UIColor(named: "DetailsLable")
        lable.text              = "speed"
        lable.font              = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment     = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    ///    Creating Selected Pokemon speedProgressBar
    private lazy var speedProgressBar :  UIProgressView = {
        let progressBar               = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.transform         = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor    = .gray
        progressBar.tintColor         = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    
    
    ///    Adding Selected Pokemons Details Elements to StackView
    private func addPokemonDetailsElementsToStackView() {
        pokemonDetailsStackView.addArrangedSubview(abilitiesLable)
        pokemonDetailsStackView.addArrangedSubview(hpLable)
        pokemonDetailsStackView.addArrangedSubview(hpProgressBar)
        
        pokemonDetailsStackView.addArrangedSubview(attackLable)
        pokemonDetailsStackView.addArrangedSubview(attackProgressBar)
        
        pokemonDetailsStackView.addArrangedSubview(defenseLable)
        pokemonDetailsStackView.addArrangedSubview(defenseProgressBar)
        
        pokemonDetailsStackView.addArrangedSubview(specialAttackLable)
        pokemonDetailsStackView.addArrangedSubview(specialAttackProgressBar)
        
        pokemonDetailsStackView.addArrangedSubview(specialDefenseLable)
        pokemonDetailsStackView.addArrangedSubview(specialDefenseProgressBar)
        
        pokemonDetailsStackView.addArrangedSubview(speedLable)
        pokemonDetailsStackView.addArrangedSubview(speedProgressBar)
        
    }
    
    
    
    
    //MARK: - Methods
    
    
    
    /// Setting up Selected Pokemon Image and Name
    private func setProfileImageAndNameAndAbilities() {
        selectedPokemonImage.kf.setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(preparedID).png"),
                                         placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil
        )
        selectedPokemonNameLable.text = pokemon?.name.uppercased()
        guard let firstAbility = pokAbilities?[0].ability.name else { return }
        if ( pokAbilities?[1].ability.name != nil) {
            let secondAbility = pokAbilities?[1].ability.name
            abilitiesLable.text = "\(firstAbility)    \(secondAbility ?? "")"
        } else {
            abilitiesLable.text = "\(firstAbility)"
            
        }
    }
    
    
    
    /// Adding Selected Pokemon to Favorite ones using UserDefaults
    func addToFavoritePokemons() {
        let favoritePokemon = FavoritePokemonModel(id: preparedID, name: pokemon.name)
        userDefaultsManager.savedPokemons(pokemon: favoritePokemon)
        print(favoritePokemon)
    }
    
    
    
    /// Setting up Selected Pokemon "Add" button tapped
    @objc func addToFavorite() {
        let addButtonAlert = UIAlertController(title: "Add Pokemons?", message: "Would you like to add this pokemon to your favorite ones?", preferredStyle: UIAlertController.Style.alert)
        
        addButtonAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {
            [weak self] (handler) in
            guard let self = self else { return }
            self.addToFavoritePokemons()
        }))
        addButtonAlert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(addButtonAlert, animated: true, completion: nil)
    }
    
    /// Fetching Selected Pokemon Details
    func fetchPokemonsDetails()  {
        URLSession.shared.request(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(preparedID)/"), expecting: PokemonDetailsDataModel.self){
            [weak self] result in
            switch result {
            case .success(let receivedPokemonsData):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.stats = receivedPokemonsData.stats
                    self.pokAbilities = receivedPokemonsData.abilities
                    self.setProgresses()
                    self.setProfileImageAndNameAndAbilities()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    /// Setting up Selected Pokemon Cancel button tapped
    @objc func cancelModalpage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    ///  Formatting up Values received for ProgressBars
    private func formatProgressesValues(value: Int) -> Float {
        let formatedValue: Float = (Float(value) * 1.0) / 100
        return formatedValue
    }
    
    
    
    /// Setting up Selected ProgressBar Values
    private func setProgresses() {
        let hp              : Int = stats[0].base_stat
        let attack          : Int = stats[1].base_stat
        let defense         : Int = stats[2].base_stat
        let specialAttack   : Int = stats[3].base_stat
        let specialDefense  : Int = stats[4].base_stat
        let speed           : Int = stats[5].base_stat
        
        hpProgressBar.setProgress(formatProgressesValues(value: hp), animated: true)
        attackProgressBar.setProgress(formatProgressesValues(value: attack), animated: true)
        defenseProgressBar.setProgress(formatProgressesValues(value: defense), animated: true)
        specialAttackProgressBar.setProgress(formatProgressesValues(value: specialAttack), animated: true)
        specialDefenseProgressBar.setProgress(formatProgressesValues(value: specialDefense), animated: true)
        speedProgressBar.setProgress(formatProgressesValues(value: speed), animated: true)
    }
    
}
