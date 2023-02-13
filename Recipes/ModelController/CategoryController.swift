//
//  CategoryController.swift
//  Recipes
//
//  Created by Karl Pfister on 2/13/23.
//

import Foundation
class CategoryController {
    
    // MARK: - Properties
    static let shared = CategoryController()
    
    private(set) var categories: [RecipeCategory] = []
    
    // MARK: - Initializers
    init() {
        loadRecipesFromDisk()
    }
    
    // MARK: - Categories
    func createRecipeCategory(title: String = "Untitled Category", recipes: [Recipe] = []) {
        let category = RecipeCategory(title: title, recipes: recipes)
        categories.append(category)
        saveRecipesToDisk()
    }
    
    func updateRecipeCategory(category: RecipeCategory, title: String) {
        category.title = title
        saveRecipesToDisk()
    }
    
    func delete(category: RecipeCategory) {
        guard let index = categories.firstIndex(of: category) else { return }
        categories.remove(at: index)
        saveRecipesToDisk()
    }

    // MARK: - Persistance
    func saveRecipesToDisk() {
        // 1. Get the address to save the file to
        guard let url = fileURL else { return }
        do {
            // 2. Convert the swift struct or class into raw data
            let data = try JSONEncoder().encode(categories)
            // 3. Save the data to the address from step 1
            try data.write(to: url)
        } catch let error {
            print(error)
        }
    }
    
    func loadRecipesFromDisk() {
        // 1. Get the address your data is saved at
        guard let url = fileURL else { return }
        do {
            // 2. Load the data from the address
            let data = try Data(contentsOf: url)
            // 3. Decode that data into our Swift model object
            let categories = try JSONDecoder().decode([RecipeCategory].self, from: data)
            self.categories = categories
        } catch let error {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("recipes.json")
        return url
    }
}
