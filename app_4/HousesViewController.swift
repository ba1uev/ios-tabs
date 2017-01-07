//
//  HousesViewController.swift
//  app_4
//
//  Created by pavel baluev on 07.01.17.
//  Copyright © 2017 pavel baluev. All rights reserved.
//

import Foundation
import UIKit



struct House {
    let pictureURL: String
    let text: String
    let size: Int
    
    init(dict: NSDictionary) {
        pictureURL = dict["picture"] as! String
        text = dict["text"] as! String
        size = dict["size"] as! Int
    }
}


func LoadHouses() -> [House] {
    if let jsonUrl = URL(string: "https://raw.githubusercontent.com/ba1uev/ios-tabs/master/app_4/houses.json")
    {
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            let array = json as! [NSDictionary]

            return array.map { dict in
                House(dict: dict)
            }
        } catch {}
    }
    return []
}

class HouseCell: UITableViewCell {
    @IBOutlet weak var housePicture: UIImageView!
    @IBOutlet weak var houseText: UILabel!
}

class HousesViewController: UITableViewController {
    
    let houses = LoadHouses()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }

    // For async shit [1]
    let queue = DispatchQueue(label: "retrieve-urls")
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "House", for: indexPath) as! HouseCell
        
        let house = houses[indexPath.row]
        cell.houseText.text = house.text
        
        // For async shit [2]
        queue.async {
            do {
                if let url   = URL(string: house.pictureURL) {
                    let data  = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.housePicture.image = image
                    }
                }
            } catch {}
        }
        
        return cell
    }

    // TODO: make individual screen for each cell
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        let vc = segue.destination as! HousesViewController
//        
//        vc.loadViewIfNeeded()
//        
//        if let indexPath = tableView.indexPathForSelectedRow {
//            
//            let index  = indexPath.row
//            let person = persons[index]
//            
//            person.greet()
//            
//            vc.personName.text = person.firstName
//            vc.personLastName.text  = person.lastName
//            
//            if let photo = person.figure {
//                let image = UIImage(named: photo)
//                vc.personPicture.image = image
//            }
//        }
//    }
}



