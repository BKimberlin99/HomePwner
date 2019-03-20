//
//  ItemStore.swift
//  HomePwner
//
//  Created by Brandon Kimberlin on 3/20/19.
//  Copyright © 2019 Brandon Kimberlin. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}
