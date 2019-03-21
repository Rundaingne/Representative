//
//  Representative.swift
//  Representatives
//
//  Created by Brooke Kumpunen on 3/21/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import Foundation

struct Representative {
    
    let name: String
    let party: String
    let state: String
    let district: String
    let phone: String
    let office: String
    let link: String
    
    //I'll need to create a failable initializer here to help me pull info from the api as a dictionary.
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let party = dictionary["party"] as? String,
            let state = dictionary["state"] as? String,
            let district = dictionary["state"] as? String,
            let phone = dictionary["phone"] as? String,
            let office = dictionary["office"] as? String,
            let link = dictionary["link"] as? String else {return nil}
        
        self.name = name
        self.party = party
        self.state = state
        self.district = district
        self.phone = phone
        self.office = office
        self.link = link
    }
}

//Alright, I've got my failable initializer. Now I can successfully pull information out of the API. Remember that you aren't using Codable here; I can try to use that in the second build. Now I need to create the model controller. This will be where I create my fetch
