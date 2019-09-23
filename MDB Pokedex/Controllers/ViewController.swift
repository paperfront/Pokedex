//
//  ViewController.swift
//  MDB Pokedex
//
//  Created by Matthew Lacayo on 9/15/19.
//  Copyright © 2019 Matthew Lacayo. All rights reserved.
//

import UIKit

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}



class ViewController: UIViewController {
    
    let pokemonList = PokemonGenerator.getPokemonArray()
    
    var typesSelected = [String]()
    
    var searchedPokemon = [Pokemon]()
    
    var currentStats = [0, 0, 0, 0, 0, 0]
    
    
    @IBOutlet weak var pokemonSearchField: UITextField!
    
    
    @IBOutlet weak var SpAtkOutlet: UITextField!
    
    @IBOutlet weak var AtkOutlet: UITextField!
    
    @IBOutlet weak var HPOutlet: UITextField!
    
    @IBOutlet weak var SpdOutlet: UITextField!
    
    @IBOutlet weak var SpDefOutlet: UITextField!
    
    @IBOutlet weak var DefOutlet: UITextField!
    
    @IBAction func TypeSelected(_ sender: UIButton) {
        if(typesSelected.contains(sender.currentTitle!)){
            sender.backgroundColor = UIColor.lightGray
            while let idx = typesSelected.firstIndex(of:sender.currentTitle!) {
                typesSelected.remove(at: idx)
            }
        }
        else{
            typesSelected.append(sender.currentTitle!)
            sender.backgroundColor = UIColor.green
        }
        print(typesSelected)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPokemonList") {
            // pass data to next view
            let resultsView = segue.destination as! PokemonResultsTableViewController
            resultsView.pokemonList = searchedPokemon
        }
        
    }
    

    // SEARCH BAR SUBMIT
    @IBAction func submitClicked(_ sender: Any) {
        searchedPokemon = getSearchedPokemon()
        if(searchedPokemon.count == 0){
            let alert = UIAlertController(title: "No Pokemon Found", message: "Please modify your search criteria and try again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        else{
        performSegue(withIdentifier: "toPokemonList", sender: self)
        }
    }
    
    func getSearchedPokemon() -> [Pokemon]{
        var returnedMons : [Pokemon]
        guard let currentText = pokemonSearchField.text else{
            return [Pokemon]()
        }
        
        updateStats()
        if(typesSelected.count > 0 || currentStats.contains {$0 > 0}){
            //searchByType()
            returnedMons = findPokemonByCategory()
        }
        else if(currentText.isInt){
            //search by number
            returnedMons = findPokemonByNumber(number: Int(currentText)!)

        }
        else{
            //search by name
            returnedMons = findPokemonByName(name: currentText)
        }
        
        
        return returnedMons
    }
    
    
    func findPokemonByName(name: String) -> [Pokemon]{
        let nameLength = name.count
        var results = [Pokemon]()
        for pokemon in pokemonList{
            if(pokemon.name.count >= nameLength && pokemon.name[0..<nameLength].lowercased() == name.lowercased()){
                results.append(pokemon)
            }
        }
        return results
    }
    
    func findPokemonByNumber(number: Int) -> [Pokemon]{
        var results = [Pokemon]()
        for pokemon in pokemonList{
            if(pokemon.number == number){
                results.append(pokemon)
            }
        }
        return results
    }
    
    func updateStats(){
        if(isValidInput(varName: AtkOutlet)){
            currentStats[0] = Int(AtkOutlet.text!)!
        }
        else{
            currentStats[0] = 0
        }
        if(isValidInput(varName: SpAtkOutlet)){
            currentStats[1] = Int(SpAtkOutlet.text!)!
        }
        else{
            currentStats[1] = 0
        }
        if(isValidInput(varName: HPOutlet)){
            currentStats[2] = Int(HPOutlet.text!)!
        }
        else{
            currentStats[2] = 0
        }
        if(isValidInput(varName: SpdOutlet)){
            currentStats[3] = Int(SpdOutlet.text!)!
        }
        else{
            currentStats[3] = 0
        }
        if(isValidInput(varName: DefOutlet)){
            currentStats[4] = Int(DefOutlet.text!)!
        }
        else{
            currentStats[4] = 0
        }
        if(isValidInput(varName: SpDefOutlet)){
            currentStats[5] = Int(SpDefOutlet.text!)!
        }
        else{
            currentStats[5] = 0
        }
    }
    
    
    
    func isValidInput(varName: UITextField) -> Bool{
        return varName.text != nil && varName.text!.isInt
    }
    
    
    func findPokemonByCategory() -> [Pokemon]{
        
        var stats = currentStats
        var results = [Pokemon]()
        
        
        func compareStats(statArr: [Int], pokemon: Pokemon) -> Bool{
            
            return pokemon.attack >= statArr[0] && pokemon.specialAttack >= statArr[1] && pokemon.health >= statArr[2] && pokemon.speed >= statArr[3] && pokemon.defense >= statArr[4] &&
                pokemon.specialDefense >= statArr[5]
        }
        
        func compareTypes(types: [String], pokemon: Pokemon) -> Bool{
            let currentTypes1 = pokemon.types
            let currentTypes2 = types
            var testCondition = false
            for type in currentTypes1{
                if(currentTypes2.contains(type)){
                    testCondition = true
                }
            }
            if(testCondition){
                return true
            }
            return false

        }
        
        
        
        
        
        for pokemon in pokemonList{
            if(compareStats(statArr: stats, pokemon: pokemon) && compareTypes(types: typesSelected, pokemon: pokemon)){
                
                results.append(pokemon)
            }
        }
        return results
        
        
    }
    
    

}


