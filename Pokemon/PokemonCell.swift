//
//  PokemonCell.swift
//  Pokemon
//
//  Created by iMommo on 01/11/22.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    let cellColors = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemOrange]
    
    
    //    Pokemon Image in the Cell
    private let pokImage : UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.layer.cornerRadius = (image.frame.size.width ) / 2
        image.layer.borderWidth = 3.0
        image.backgroundColor = .white
        image.layer.borderColor = UIColor.green.cgColor
        return image
    }()
    
    
    //    Pokemon Number lable in the Cell
    private let pokNumLable : UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.text = "#222"
        lable.textAlignment = .center
        lable.font = .systemFont(ofSize: 25)
        return lable
    }()
    
    //    Pokemon Name lable in the Cell
    private let pokNameLable : UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.textAlignment = .center
        lable.font = .systemFont(ofSize: 25)
        return lable
    }()
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        pokImageConstraint()
        pokNumLableConstraint()
        pokNameLableConstraint()
        
    }
    
    func fillPokemonData(pokName : String, pokImg : String) {
        pokImage.image = UIImage(named: "2")
        pokNameLable.text = pokName
        
    }
    
    
//    Set Pokemon Image Constraint
    private func pokImageConstraint() {
        
        pokImage.translatesAutoresizingMaskIntoConstraints = false
        pokImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pokImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        pokImage.bottomAnchor.constraint(lessThanOrEqualTo: pokNumLable.topAnchor, constant: -10).isActive = true
        pokImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        pokImage.heightAnchor.constraint(equalTo: pokImage.widthAnchor).isActive = true
    }
    
    
    //    Set Pokemon Number Lable Constraint
    private func pokNumLableConstraint() {
        
        pokNumLable.translatesAutoresizingMaskIntoConstraints = false
        pokNumLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pokNumLable.topAnchor.constraint(lessThanOrEqualTo: pokImage.bottomAnchor, constant: 20).isActive = true
        pokNumLable.bottomAnchor.constraint(equalTo: pokNameLable.topAnchor, constant: 10).isActive = true
        pokNumLable.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        pokNumLable.heightAnchor.constraint(equalTo: pokNumLable.widthAnchor).isActive = true
    }
    
    //    Set Pokemon Name Lable Constraint
    private func pokNameLableConstraint() {
        
        pokNameLable.translatesAutoresizingMaskIntoConstraints = false
        pokNameLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pokNameLable.topAnchor.constraint(equalTo: pokNameLable.bottomAnchor, constant: 10).isActive = true
        pokNameLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        pokNameLable.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        pokNameLable.heightAnchor.constraint(equalTo: pokNameLable.widthAnchor, multiplier: 0.5).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pokImage)
        contentView.addSubview(pokNumLable)
        contentView.addSubview(pokNameLable)
        contentView.backgroundColor = cellColors.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
