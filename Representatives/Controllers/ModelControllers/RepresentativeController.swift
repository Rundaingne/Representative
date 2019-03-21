//
//  RepresentativeController.swift
//  Representatives
//
//  Created by Brooke Kumpunen on 3/21/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let baseUrl = URL(string: "https://whoismyrepresentative.com/getall_mems.php")
    
    static func fetchRepresentatives(forState state: String, completion: @escaping([Representative]?) -> Void) {
        //Alright, let's see...I need to create the url.
        guard let url = baseUrl?.appendingPathComponent("getall_reps_bystate.php") else {completion([]); return}
        //Alrighty, got the url with the path component attached. Now I need the query items, and then the path extension.
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let querySearchItem = URLQueryItem(name: "state", value: state)
        components?.queryItems = [querySearchItem]
        guard let finalUrl = components?.url else {completion([]); return}
        //Now that we have the url with all of its components, let's create the data task.
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            //Now if we've gotten here, we have data. What do I do with the data?
            guard let data = data else {completion([]); return}
            do {
                guard let topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let resultsArray = topLevelDictionary["results"] as? [[String: Any]] else {completion([]); return}
                let representatives = resultsArray.compactMap{ Representative(dictionary: $0)}
                completion(representatives)
            } catch {
                print("There was an error in \(#function): \(error) \(error.localizedDescription)")
                completion([])
                return
            }
        } .resume()
        
    }
}
