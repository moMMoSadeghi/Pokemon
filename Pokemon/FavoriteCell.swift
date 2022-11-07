//
//  FavoriteCell.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

class FavoriteCell: UITableViewCell, DetailsPokemonViewControllerDelegate {
   
    
    
//    var detailsPokemonViewController = DetailsPokemonViewController()

    
    private let cellColors = [UIColor(red: 0.2, green: 0.3, blue: 0.2, alpha: 0.4), UIColor(red: 0.6, green: 0.2, blue: 0.5, alpha: 0.4), UIColor(red: 0.3, green: 0.2, blue: 0.7, alpha: 0.4), UIColor(red: 0.5, green: 0.1, blue: 0.5, alpha: 0.4), UIColor(red: 0.4, green: 0.2, blue: 0.3, alpha: 0.4)]
    
    private let favoriteCellStackView = UIStackView()
    
    private func configureMainStackView() {
        contentView.addSubview(favoriteCellStackView)
        favoriteCellStackView.axis = .horizontal
        favoriteCellStackView.distribution = .fill
        favoriteCellStackView.spacing = 10
        setupMainStackViewConstraint()
        addPokemonImageAndNameToStackView()
    }

    private func setupMainStackViewConstraint() {
        favoriteCellStackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteCellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        favoriteCellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        favoriteCellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        favoriteCellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
    }
    
    private func addPokemonImageAndNameToStackView() {
        favoriteCellStackView.addArrangedSubview(favoritePokemonImage)
        favoriteCellStackView.addArrangedSubview(favoritePokemonName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 15
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        favoritePokemonImageConstraint()
        favoritePokemonNameLableConstraint()
    }
    
    
    private let favoritePokemonImage : UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
//        image.layer.borderWidth = 3.0
//        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
   
    
//    Pokemon Number lable in the Cell
    private let favoritePokemonName : UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.textAlignment = .center
        lable.font = .systemFont(ofSize: 25)
        return lable
    }()
    
    
    private func favoritePokemonImageConstraint() {
        favoritePokemonImage.translatesAutoresizingMaskIntoConstraints = false
//        favoritePokemonImage.topAnchor.constraint(equalTo: favoriteCellStackView.topAnchor, constant: 5).isActive = true
//        favoritePokemonImage.bottomAnchor.constraint(equalTo: favoriteCellStackView.bottomAnchor, constant: -5).isActive = true
//        favoritePokemonImage.leadingAnchor.constraint(equalTo: favoriteCellStackView.leadingAnchor, constant: 5).isActive = true
        favoritePokemonImage.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        favoritePokemonImage.heightAnchor.constraint(equalTo: favoritePokemonImage.widthAnchor).isActive = true
       
    }
    
    private func favoritePokemonNameLableConstraint() {
        
        favoritePokemonName.translatesAutoresizingMaskIntoConstraints = false
//        favoritePokemonName.topAnchor.constraint(equalTo: favoriteCellStackView.topAnchor, constant: 2).isActive = true
//        favoritePokemonName.bottomAnchor.constraint(equalTo: favoriteCellStackView.bottomAnchor, constant: 2).isActive = true
//        favoritePokemonName.leadingAnchor.constraint(equalTo: favoritePokemonImage.trailingAnchor, constant: 2).isActive = true
//        favoritePokemonName.trailingAnchor.constraint(equalTo: favoriteCellStackView.trailingAnchor, constant: 2).isActive = true
//        favoritePokemonName.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
//        favoritePokemonName.heightAnchor.constraint(equalTo: favoritePokemonImage.widthAnchor).isActive = true
    }
    
    func didSendFavoritePokemon(favoritePokemon: FavoritePokemonModel) {
        favoritePokemonImage.image = UIImage(named: favoritePokemon.image) 
        favoritePokemonName.text = favoritePokemon.name
    }
    

    
//    Delegate Method comes from the Protocol to receive the pokemon coming from the DetailsPokemonViewController
    func fillFavoritePokemonData(pokImg : String, pokName : String) {
        favoritePokemonImage.image = UIImage(named: "2")
        favoritePokemonName.text = pokName
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMainStackView()
//        detailsPokemonViewController.delegate = self
        contentView.backgroundColor = cellColors.randomElement()
       
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
