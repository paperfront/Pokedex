//
//  PokemonResultsTableViewController.swift
//  
//
//  Created by Matthew Lacayo on 9/17/19.
//

import UIKit

class PokemonResultsTableViewController: UITableViewController {

    var pokemonList = [Pokemon]()
    let defaultdata = try? Data(contentsOf: URL(string: PokemonGenerator.getPokemonArray()[0].imageUrl)!)
    var selectedCell = PokemonCell()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(pokemonList.count == 1){
            performSegue(withIdentifier: "toProfilePage", sender: self)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProfilePage") {
            // pass data to next view
            let resultsView = segue.destination as! PokemonProfilePage
            resultsView.currentPokemon = pokemonList[selectedIndex]
            guard let url = URL(string: pokemonList[selectedIndex].imageUrl) else {
                return
            }
            let data = try? Data(contentsOf: url)
            var pokeImg = UIImage(data: data ?? defaultdata!)
            resultsView.image = pokeImg!
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PokemonCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PokemonCell  else {
            fatalError("The dequeued cell is not an instance of PokemonCell.")
        }
        // Configure the cell...
        let pokemon = pokemonList[indexPath.row]
        cell.pokemonName.text = pokemon.name
        cell.pokemonNumber.text = String(pokemon.number)
        
        guard let url = URL(string: pokemon.imageUrl) else {
            return cell
        }
        let data = try? Data(contentsOf: url)
        cell.pokemonImage.image = UIImage(data: data ?? defaultdata!)
       
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = tableView.cellForRow(at: indexPath)! as! PokemonCell
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toProfilePage", sender: self)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
