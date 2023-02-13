//
//  RecipeController.swift
//  Recipe1
//
//  Created by Stateful on 10/12/21.
//

import Foundation

class RecipeController {
    
    // MARK: - Recipes
    static func createRecipe(title: String = "Untitled Recipe",
                   description: String = "Recipe Description",
                   calories: Int = 0,
                   cookTime: Int = 0,
                   in category: RecipeCategory) {
        let recipe = Recipe(title: title, description: description, calories: calories, cookTime: cookTime)
        category.recipes.append(recipe)
        CategoryController.shared.saveRecipesToDisk()
    }
    
    static func delete(recipe: Recipe, in category: RecipeCategory) {
        guard let index = category.recipes.firstIndex(of: recipe) else { return }
        category.recipes.remove(at: index)
        CategoryController.shared.saveRecipesToDisk()
    }
    
    static func update(recipe: Recipe,
                title: String,
                description: String,
                calories: Int?,
                cookTime: Int?) {
        recipe.title = title
        recipe.description = description
        recipe.calories = calories
        recipe.cookTime = cookTime
        CategoryController.shared.saveRecipesToDisk()
    }
    
    static func toggleFavorite(recipe: Recipe) {
        recipe.isFavorite.toggle()
        CategoryController.shared.saveRecipesToDisk()
    }
}
