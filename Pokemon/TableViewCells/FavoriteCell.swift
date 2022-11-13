//
//  FavoriteCell.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit
import Kingfisher

class FavoriteCell: UITableViewCell {
    
    
    //MARK: -   Variables
    
    private let favoriteCellStackView = UIStackView()
    
    
    
    //MARK: -   LifeCycles
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favoritePokemonNameLableConstraint()
//        favoritePokemonImageConstraint()
        contentView.layer.cornerRadius = 15
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMainStackView()
        //        detailsPokemonViewController.delegate = self
        contentView.backgroundColor = Colors.cellColors.randomElement() as? UIColor
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
   
    
    
    
    //MARK: -   UI Outlets
    
    /// Creating favoritePokemonImage
    private lazy var favoritePokemonImage     : UIImageView = {
        let image                             = UIImageView()
        image.contentMode                     = .scaleAspectFit
        image.clipsToBounds                   = false
        image.tintColor                       = .white
        image.layer.cornerRadius = 15
        return image
    }()
    
    
    /// Creating favoritePokemonImageIcon
    private lazy var favoritePokemonImageIcon : UIImageView = {
        let image                             = UIImageView()
        image.contentMode                     = .scaleAspectFit
        image.frame.size = CGSize(width: 10, height: 10)
        image.clipsToBounds                   = false
        image.tintColor                       = .systemRed
        image.image                           = UIImage(systemName: "heart.fill")
        return image
    }()
    
    
    
    /// Creating favoritePokemonName
    private lazy var favoritePokemonName      : UILabel = {
        let lable                             = UILabel()
        lable.textColor                       = .white
        lable.textAlignment                   = .center
        lable.font                            = UIFont(name:"Chalkboard SE", size: 28)
        return lable
    }()
    
    
    
    /// Configuring configureMainStackView
    private func configureMainStackView() {
        contentView.addSubview(favoriteCellStackView)
        favoriteCellStackView.axis         = .horizontal
        favoriteCellStackView.distribution = .fill
        favoriteCellStackView.spacing      = 30
        setupMainStackViewConstraint()
        addPokemonImageAndNameToStackView()
    }
    
    
    /// Configuring setupMainStackViewConstraint
    private func setupMainStackViewConstraint() {
        favoriteCellStackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteCellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        favoriteCellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        favoriteCellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        favoriteCellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    
    /// Configuring addPokemonImageAndNameToStackView
    private func addPokemonImageAndNameToStackView() {
        favoriteCellStackView.addArrangedSubview(favoritePokemonImage)
        favoriteCellStackView.addArrangedSubview(favoritePokemonName)
        favoriteCellStackView.addArrangedSubview(favoritePokemonImageIcon)
    }
    
    
   
    
    
    
//    private func favoritePokemonImageConstraint() {
//        favoritePokemonImage.translatesAutoresizingMaskIntoConstraints = false
//        favoritePokemonImage.centerYAnchor.constraint(equalTo: favoriteCellStackView.centerYAnchor).isActive = true
//    }
//
    private func favoritePokemonNameLableConstraint() {

        favoritePokemonName.translatesAutoresizingMaskIntoConstraints = false
//        favoritePokemonName.centerXAnchor.constraint(equalTo: favoriteCellStackView.centerXAnchor).isActive = true
        favoritePokemonName.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
    }
    
    
    //MARK: -   Methods
    
    
    
    /// Fill FavoritePokemonCell Data
    /// - Parameters:
    ///   - pokID:  SelectedPokemonID
    ///   - pokName: SelectedPokemonName
    func fillFavoritePokemonData(pokID : String, pokName : String) {
        favoritePokemonName.text = pokName
        favoritePokemonImage.kf.setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokID).png"), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
    }
}





//MARK: -   Extension


extension FavoriteCell {
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        favoritePokemonImage.image = nil
    }

}

