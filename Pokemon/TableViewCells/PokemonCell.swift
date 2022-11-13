//
//  PokemonCell.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit
import Kingfisher

class PokemonCell: UITableViewCell {
    
    
    
    
    
    //MARK: - Application LifeCycle
    
    /// Layout SubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        pokImageConstraint()
        pokNameLableConstraint()
    }
    
    /// Initializing Cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pokImage)
        contentView.addSubview(pokNameLable)
        contentView.backgroundColor = Colors.cellColors.randomElement() as? UIColor
        
    }
    
    /// Required Cell NSCoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: -   UI Outlets
    
    
    
    /// Creating Pokemon Image Cell
    private lazy var pokImage       : UIImageView = {
        let image                   = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        image.contentMode           = .scaleAspectFit
        image.clipsToBounds         = false
        image.layer.cornerRadius    = (image.frame.size.width ) / 2
        image.layer.borderWidth     = 3.0
        image.backgroundColor       = UIColor(red: 0.6, green: 0.2, blue: 0.5, alpha: 0.4)
        image.layer.borderColor     = UIColor.green.cgColor
        return image
    }()
    
    
    
    /// Creating Pokemon NameLable Cell
    private lazy var pokNameLable   : UILabel = {
        let lable                   = UILabel()
        lable.textColor             = .white
        lable.textAlignment         = .center
        lable.font                  = UIFont(name:"Chalkboard SE", size: 28)
        return lable
    }()
    
    
    
    /// Set Pokemon Image Constraint
    private func pokImageConstraint() {
        
        pokImage.translatesAutoresizingMaskIntoConstraints                                                        = false
        pokImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive                            = true
        pokImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive                      = true
        pokImage.widthAnchor.constraint(greaterThanOrEqualTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        pokImage.heightAnchor.constraint(equalTo: pokImage.widthAnchor).isActive                                  = true
    }
    
    
    
    /// Set Pokemon Name Lable Constraint
    private func pokNameLableConstraint() {
        
        pokNameLable.translatesAutoresizingMaskIntoConstraints                                                       = false
        pokNameLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive                           = true
        pokNameLable.topAnchor.constraint(equalTo: pokImage.bottomAnchor, constant: 10).isActive                     = true
        pokNameLable.widthAnchor.constraint(greaterThanOrEqualTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        pokNameLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive              = true
        
    }
    
    
    
    
    //MARK: -   Methods
    
    
    
    /// Filling Cell Data
    func fillPokemonsData(pokName : String, pokID: String) {
        pokNameLable.text = "#\(pokID). \(pokName)"
        pokImage.kf.setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokID).png"), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil
        )
    }
    
    
    
    
}




//MARK: -   Extension

extension PokemonCell {
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        pokImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
