//
//  Element.swift
//  DAM-TD4
//
//  Created by MACIOLEK Sebastian on 31/01/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import Foundation

class Element {
    var image = String()
    var nom = String()
    var description = String()
    var imageLarge = String()
    
    init(image: String, nom: String, description: String, imageLarge: String){
        self.image = image
        self.nom = nom
        self.description = description
        self.imageLarge = imageLarge
    }
    
    init(){
        
    }
}
