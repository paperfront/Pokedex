//
//  PokemonProfilePage.swift
//  
//
//  Created by Matthew Lacayo on 9/19/19.
//

import UIKit

class PokemonProfilePage: UIViewController {
    
    
    var image = UIImage()
    var currentPokemon : Pokemon?
    @IBOutlet weak var atkOutlet: UILabel!
    @IBOutlet weak var spAtkOutlet: UILabel!
    @IBOutlet weak var HPOutlet: UILabel!
    @IBOutlet weak var spdOutlet: UILabel!
    @IBOutlet weak var defOutlet: UILabel!
    @IBOutlet weak var spDefOutlet: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var numberOutlet: UILabel!
    
    @IBOutlet weak var pokemonPictureOutlet: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameOutlet.text = currentPokemon!.name
        numberOutlet.text = String(currentPokemon!.number)
        atkOutlet.text = "Attack: \(currentPokemon!.attack!)"
        spAtkOutlet.text = "Special Attack: \(currentPokemon!.specialAttack!)"
        HPOutlet.text = "HP: \(currentPokemon!.health!)"
        spdOutlet.text = "Speed: \(currentPokemon!.speed!)"
        defOutlet.text = "Defense: \(currentPokemon!.defense!)"
        spDefOutlet.text = "Special Defense: \(currentPokemon!.specialDefense!)"
        pokemonPictureOutlet.image = image
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
