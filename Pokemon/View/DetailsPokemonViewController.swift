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
    var preparedID              : Int           {
                                                  ((id ?? 0) + 1)
                                              }
    var pok                     = [Stats]()
    var pokAbilities            : Species?
    var detailsPokemonViewModel = DetailsPokemonViewModel()
    var allFavoritePokemons     : [FavoritePokemonModel]?
    let userDefaultsManager      = UserDefaulsManager()
                            
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
    
    deinit {}
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(named: "detailsViewControllerBackground")
        
        configureTabBarStackView()
        configurePokemonDetailsScrollView()
        configurePokemonProfileUIView()
        configureDetailsStackView()
        print(id)
        fetchPokemonsDetails()
        setProfileImageAndName()
        view.layer.cornerRadius = 15
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
    
    //        Creating Cancel Bar Button
    private lazy var cancelButton : UIButton = {
        let button                = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(cancelModalpage), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var selectedPokemonNumberLable : UILabel = {
        let lable           = UILabel()
        lable.textColor     = UIColor(named: "detailsNumLable")
        lable.text          = String("# \((id ?? 0) + 1)")
        lable.textAlignment = .center
        lable.font          = UIFont(name:"Chalkboard SE", size: 28)
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
    
    
    
    
    private func configureTabBarStackView() {
        detailsScrollView.addSubview(pokemonUITabBarStackView)
        pokemonUITabBarStackView.axis         = .horizontal
        pokemonUITabBarStackView.distribution = .fillEqually
        pokemonUITabBarStackView.spacing      = 30
        setupPokemonUITabBarStackViewConstraint()
        addElementsPokemonUITabBarStackView()
    }
    
    private func setupPokemonUITabBarStackViewConstraint() {
        pokemonUITabBarStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonUITabBarStackView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 25).isActive = true
        pokemonUITabBarStackView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor).isActive       = true
        pokemonUITabBarStackView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor).isActive     = true
    }
    
    private func addElementsPokemonUITabBarStackView() {
        pokemonUITabBarStackView.addArrangedSubview(cancelButton)
        pokemonUITabBarStackView.addArrangedSubview(selectedPokemonNumberLable)
        pokemonUITabBarStackView.addArrangedSubview(addButton)
        
    }
    
    //MARK: -   Profile IBOutlets
    
    
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
        pokemonProfileView.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor).isActive                 = true
        pokemonProfileView.topAnchor.constraint(equalTo: pokemonUITabBarStackView.bottomAnchor, constant: 30).isActive = true
        pokemonProfileView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 5).isActive    = true
        pokemonProfileView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor, constant: -5).isActive = true
    }
    
    
    //        Creating Selected Pokemon UIImage
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
    
    
    private lazy var selectedPokemonNameLable : UILabel = {
        let lable           = UILabel()
        lable.textColor     = .white
        lable.textAlignment = .center
        lable.font          = UIFont(name:"Chalkboard SE", size: 28)
        return lable
    }()
    
    
    //        Setting Selected Pokemon Image Constraint
    private func selectedPokemonImageConstraint() {
        
        selectedPokemonImage.translatesAutoresizingMaskIntoConstraints = false
        selectedPokemonImage.centerXAnchor.constraint(equalTo: pokemonProfileView.centerXAnchor).isActive              = true
        selectedPokemonImage.topAnchor.constraint(equalTo: pokemonProfileView.topAnchor, constant: 30).isActive        = true
        selectedPokemonImage.widthAnchor.constraint(equalTo: pokemonProfileView.widthAnchor, multiplier: 0.3).isActive = true
        selectedPokemonImage.heightAnchor.constraint(equalTo: selectedPokemonImage.widthAnchor).isActive = true
    }
    
    
    //        Seting Selected Pokemon Name Lable Constraint
    private func selectedPokemonNameLableConstraint() {
        
        selectedPokemonNameLable.translatesAutoresizingMaskIntoConstraints = false
        selectedPokemonNameLable.centerXAnchor.constraint(equalTo: pokemonProfileView.centerXAnchor).isActive           = true
        selectedPokemonNameLable.topAnchor.constraint(equalTo: selectedPokemonImage.bottomAnchor, constant: 5).isActive = true
        selectedPokemonNameLable.widthAnchor.constraint(greaterThanOrEqualTo: pokemonProfileView.widthAnchor, multiplier: 0.4).isActive = true
        selectedPokemonNameLable.heightAnchor.constraint(equalTo: selectedPokemonImage.widthAnchor).isActive            = true
    }
    
    
    //    Adding Selected Pokemon Image and Name to ProfileUIView
    private func addPokemonImageAndNameToProfileUIView() {
        pokemonProfileView.addSubview(selectedPokemonImage)
        pokemonProfileView.addSubview(selectedPokemonNameLable)
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
        detailsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive        = true
        detailsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive      = true
        detailsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive    = true
    }
    
    
    //    Adding ProfileUIView and StackView to the ScrollView
    private func addpokemonDetailsStackViewAndProfileUIViewAndDetailsStackViewToScrollView() {
        detailsScrollView.addSubview(pokemonProfileView)
        detailsScrollView.addSubview(pokemonUITabBarStackView)
        detailsScrollView.addSubview(pokemonDetailsStackView)
    }
    
    
    //        Creating Selected Pokemon UINameLable
    
    
    //    Configuring Details StackView
    private func configureDetailsStackView() {
        detailsScrollView.addSubview(pokemonDetailsStackView)
        pokemonDetailsStackView.axis = .vertical
        pokemonDetailsStackView.distribution = .fill
        pokemonDetailsStackView.spacing = 30
        setupDetailsStackViewConstraint()
        addPokemonDetailsLableToStackView()
    }
    
    //    Setting Details StackView Constraint
    private func setupDetailsStackViewConstraint() {
        pokemonDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonDetailsStackView.topAnchor.constraint(equalTo: selectedPokemonNameLable.bottomAnchor, constant: 20).isActive  = true
        pokemonDetailsStackView.bottomAnchor.constraint(equalTo: detailsScrollView.bottomAnchor, constant: -10).isActive     = true
        pokemonDetailsStackView.leadingAnchor.constraint(equalTo: detailsScrollView.leadingAnchor, constant: 20).isActive    = true
        pokemonDetailsStackView.trailingAnchor.constraint(equalTo: detailsScrollView.trailingAnchor, constant: -20).isActive = true
    }
    
    
    
    private lazy var abilitiesLable : UILabel = {
        let lable            = UILabel()
        lable.textColor      = .darkGray
        lable.font           = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment  = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    private lazy var hpLable : UILabel = {
        let lable            = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor      = .darkGray
        lable.text           = "hp"
        lable.font           = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment  = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    
    
    //    Creating HP ProgressBar View
    private lazy var hpProgressBar      :  UIProgressView = {
        let progressBar                 = UIProgressView()
        progressBar.progressViewStyle   = .bar
        progressBar.transform           = progressBar.transform.scaledBy(x: 1, y: 4)
        progressBar.trackTintColor      = .gray
        progressBar.tintColor           = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    private lazy var attackLable : UILabel = {
        let lable                = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor          = .darkGray
        lable.text               = "attack"
        lable.font               = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment      = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    //       Creating Attack ProgressBar View
    private lazy var attackProgressBar :  UIProgressView = {
        let progressBar                = UIProgressView()
        progressBar.progressViewStyle  = .bar
        progressBar.transform          = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor     = .gray
        progressBar.tintColor          = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    private lazy var defenseLable        : UILabel = {
        let lable                        = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor                  = .darkGray
        lable.text                       = "defense"
        lable.font                       = UIFont(name:"Chalkboard SE", size: 28)
        lable.adjustsFontSizeToFitWidth  = true
        lable.textAlignment              = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    //        Creating Defense ProgressBar View
    private lazy var defenseProgressBar :  UIProgressView = {
        let progressBar                 = UIProgressView()
        progressBar.progressViewStyle   = .bar
        progressBar.transform           = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor      = .gray
        progressBar.tintColor           = UIColor(named: "progressBarTintColor")
        return progressBar
    }()
    
    
    private lazy var specialAttackLable : UILabel = {
        let lable                       = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        lable.textColor                 = .darkGray
        lable.text                      = "special attack"
        lable.font                      = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment             = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    //        Creating Special Attack ProgressBar View
    private lazy var specialAttackProgressBar :  UIProgressView = {
        let progressBar                       = UIProgressView()
        progressBar.progressViewStyle         = .bar
        progressBar.transform                 = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor            = .gray
        progressBar.tintColor                 = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    
    private lazy var specialDefenseLable : UILabel = {
        let lable                        = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor                  = .darkGray
        lable.text                       = "special defense"
        lable.font                       = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment              = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    //    Creating Special Defense ProgressBar View
    private lazy var specialDefenseProgressBar :  UIProgressView = {
        let progressBar                        = UIProgressView()
        progressBar.progressViewStyle          = .bar
        progressBar.transform                  = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor             = .gray
        progressBar.tintColor                  = UIColor(named: "progressBarTintColor")
        return progressBar
    }()
    
    
    private lazy var speedLable : UILabel = {
        let lable               = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        lable.textColor         = .darkGray
        lable.text              = "speed"
        lable.font              = UIFont(name:"Chalkboard SE", size: 28)
        lable.textAlignment     = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    private lazy var speedProgressBar :  UIProgressView = {
        let progressBar               = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.transform         = CGAffineTransformMakeScale(1, 4)
        progressBar.trackTintColor    = .gray
        progressBar.tintColor         = UIColor(named: "progressBarTintColor")
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    
    
    
    //    Adding Selected Pokemons Details Progress TabBar to ScrollView
    private func addPokemonDetailsLableToStackView() {
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
    
    
    private func setProfileImageAndName() {
        selectedPokemonImage.kf.setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(preparedID).png"),
                                         placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil
        )
        selectedPokemonNameLable.text = pokemon?.name.uppercased()

    }
    
    private func setPokemonNameAndAbilitiesText() {
        selectedPokemonNameLable.text = pokemon?.name.uppercased()

        guard let firstAbility = pokAbilities?.name else { return }
//        let secondAbility = pokAbilities.name
        abilitiesLable.text = "\(firstAbility) and \(firstAbility)"
    }
    
     func addToFavoritePokemons() {
         let favoritePokemon = [FavoritePokemonModel(id: preparedID, name: pokemon.name)]
         userDefaultsManager.savedPokemons(pokemon: favoritePokemon)
         print(favoritePokemon)
    }
    
    
    
    
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
    
    func fetchPokemonsDetails()  {
        URLSession.shared.request(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(preparedID)/"), expecting: PokemonDetailsDataModel.self){
            [weak self] result in
            switch result {
            case .success(let receivedPokemonsData):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.pok = receivedPokemonsData.stats
                    self.setProgresses()
                    self.setPokemonNameAndAbilitiesText()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
    @objc func cancelModalpage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    private func setProgresses() {
        let hp              : Int = pok[0].base_stat
        let attack          : Int = pok[1].base_stat 
        let defense         : Int = pok[2].base_stat 
        let specialAttack   : Int = pok[3].base_stat 
        let specialDefense  : Int = pok[4].base_stat 
        let speed           : Int = pok[5].base_stat 
        
        hpProgressBar.setProgress(formatProgressesValues(value: hp), animated: true)
        attackProgressBar.setProgress(formatProgressesValues(value: attack), animated: true)
        defenseProgressBar.setProgress(formatProgressesValues(value: defense), animated: true)
        specialAttackProgressBar.setProgress(formatProgressesValues(value: specialAttack), animated: true)
        specialDefenseProgressBar.setProgress(formatProgressesValues(value: specialDefense), animated: true)
        speedProgressBar.setProgress(formatProgressesValues(value: speed), animated: true)
        
        
    }
    
    private func formatProgressesValues(value: Int) -> Float {
        let formatedValue: Float = (Float(value) * 1.0) / 100
        return formatedValue
    }
    
    
    
}
