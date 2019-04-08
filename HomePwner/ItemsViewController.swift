//
//  ItemsViewController.swift
//  HomePwner
//
//  Created by Brandon Kimberlin on 3/18/19.
//  Copyright © 2019 Brandon Kimberlin. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    //tableView functions
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1 //Changed to +1 for silver challenge
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < itemStore.allItems.count {
            //Get a new or recycled cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
            //Set the text on the cell with the description of the item
            //that is at the nth index of items, where n = row this cell
            //will appear in on the tableview
            let item = itemStore.allItems[indexPath.row]
        
            //Configure the cell with the Item
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
        
        //Bronze Challenge Cell Colors: Change valueLabel to be red if valueInDollars is >= 50 but change it
        // to green if it is less than 50.
            if item.valueInDollars >= 50 {
                cell.valueLabel.textColor = UIColor.red
            } else {
                cell.valueLabel.textColor = UIColor.green
            }
        
            cell.backgroundColor = UIColor.clear //Set cell background to clear so table background is visible
            return cell
        //Create "No more items!" cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! customItemCell
            cell.noItemsLabel.text = "No more items!"
            cell.backgroundColor = UIColor.clear //Set cell background to clear so table background is visible
            return cell
        }
    }
    
    //Gold Challenge: Really preventing reordering, keeps track of item's original row and checks to see
    // if it passes the row that "No more items!" is in and if it does, returns it to it's original row
    // otherwise, moves it to the proposed row
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath:
        IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if (proposedDestinationIndexPath.row >= itemStore.allItems.count){
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    //Make sure that the "No more items!" cell can't be edited
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row >= itemStore.allItems.count){
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Remove \(item.name)?"
            let message = "Are you sure you want to remove this item?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive,
                                             handler: { (action) -> Void in
                                    
                // Remove the item from the store
                self.itemStore.removeItem(item)
                                                
                // Remove the item's image from the image store
                self.imageStore.deleteImage(forKey: item.itemKey)
            
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    //Bronze Challenge: Rename delete button to Remove
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "Remove"
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered seque is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                //Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        //Gold Challenge: Set custom background picture for table
        let imageView = UIImageView(image: UIImage(named: "Zelda"))
        imageView.contentMode = .scaleAspectFit
        tableView.backgroundView = imageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
