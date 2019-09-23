//
//  PokemonCell.swift
//  
//
//  Created by Matthew Lacayo on 9/17/19.
//

import UIKit

class PokemonCell: UITableViewCell {

    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
