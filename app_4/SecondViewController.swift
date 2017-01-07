//
//  SecondViewController.swift
//  app_4
//
//  Created by pavel baluev on 06.01.17.
//  Copyright © 2017 pavel baluev. All rights reserved.
//

import UIKit
import CoreData

class Profile: NSManagedObject {
    @NSManaged var pictureData: NSData
}

class SecondViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var explanationText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layer = profilePicture.layer
        //        layer.cornerRadius = layer.bounds.size.width / 2
        layer.borderWidth = 3
        layer.borderColor = UIColor.blue.cgColor
        
        // add database (core data)
//        let container = NSPersistentContainer(name: "Model")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        // open Photo Library
        vc.sourceType = .photoLibrary
        // open Camera (test it on real device only)
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//           vc.sourceType = .camera
//        }
        
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        // метод вызывается при каждом ресайзе
        super.viewDidLayoutSubviews()
        let layer = profilePicture.layer
        layer.cornerRadius = profilePicture.bounds.size.width / 2
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: {})
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicture.image = image
            explanationText.isHidden = true
            
//            let context = container.viewContext
//            let descr = container.manageObjects
//            let profile = Profile(entity: descr, insertPhoto: context)
//            profile.pictureData =
        }
        dismiss(animated: true, completion: {})
        
    }
    
    


}

