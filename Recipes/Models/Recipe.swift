//
//  Recipe.swift
//  Recipe1
//
//  Created by Stateful on 10/12/21.
//

import Foundation

class Recipe: Codable {
    let id: UUID
    var title: String
    var description: String
    var calories: Int?
    var cookTime: Int?
    var isFavorite: Bool
    
    init(id: UUID = UUID(),
         title: String,
         description: String,
         calories: Int?,
         cookTime: Int?,
         isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.calories = calories
        self.cookTime = cookTime
        self.isFavorite = isFavorite
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}
