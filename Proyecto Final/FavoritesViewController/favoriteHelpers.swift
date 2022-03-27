//
//  favoriteHelpers.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 20/3/22.
//

import Foundation
import UIKit

// Get saved favorites from UserDefaults
func getFavorites() -> [Launch] {
    if let data = UserDefaults.standard.data(forKey: "favorites") {
        do {
            let decoder = JSONDecoder()

            let favoritos = try decoder.decode([Launch].self, from: data)
            
            return favoritos
        } catch {
            print("Unable to Decode Favorites (\(error))")
        }
    }
    
    return [Launch]()
}

// Remove launch from favorites
func removeFromFavorites(launch: Launch?) {
        if let data = UserDefaults.standard.data(forKey: "favorites") {
            do {
                let decoder = JSONDecoder()
                let encoder = JSONEncoder()

                let favorites = try decoder.decode([Launch].self, from: data)

                guard let launch = launch else {
                    return
                }

                var newFavoritos = favorites
                
                if let index = newFavoritos.firstIndex(where: { $0.id == launch.id }) {
                    newFavoritos.remove(at: index)
                }
                
                let newData = try encoder.encode(newFavoritos)
                
                UserDefaults.standard.set(newData, forKey: "favorites")
                                
            } catch {
                print("Unable to Decode Favorites (\(error))")
            }
        }
}

// Save favorites to UserDefaults
func saveFavorite(launch: Launch?) {
    if let data = UserDefaults.standard.data(forKey: "favorites") {
        do {
            let decoder = JSONDecoder()
            let encoder = JSONEncoder()

            let favorites = try decoder.decode([Launch].self, from: data)

            guard let launch = launch else {
                return
            }

            var newFavorites = favorites
            newFavorites.append(launch)
            
            let newData = try encoder.encode(newFavorites)
            
            UserDefaults.standard.set(newData, forKey: "favorites")
            
        } catch {
            print("Unable to Decode Favorites (\(error))")
        }
    } else {
        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode([launch])

            UserDefaults.standard.set(data, forKey: "favorites")

        } catch {
            print("Unable to Encode Array of Favorites (\(error))")
        }
    }
    
}
