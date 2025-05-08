//
//  JsonLoader.swift
//  Workouts
//
//  Created by Ferdows on 5/7/25.
//

import UIKit

class JsonLoader {
    
    private static func loadFile(_ filename: String) -> Data {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            return try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }
    
    private static func loadAsset(_ filename: String) -> Data {
        let asset = NSDataAsset(name: filename, bundle: Bundle.main)
        return asset!.data
    }
    
    static func load<T: Decodable>(fromFile file: String) -> T {
        let data = loadFile(file)
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    static func load<T: Decodable>(fromAsset asset: String) -> T {
        let data = loadAsset(asset)
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
