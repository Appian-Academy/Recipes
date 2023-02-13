//
//  RecipeDetailViewController.swift
//  Recipe1
//
//  Created by Stateful on 10/12/21.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var recipeTitleTextField: UITextField!
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var recipeDescriptionTextField: UITextView!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    // MARK: - Properties
    var recipe: Recipe?
    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        guard let recipe = recipe else { return }
        recipeTitleTextField.text = recipe.title
        recipeDescriptionTextField.text = recipe.description
        if let calories = recipe.calories {
            calorieTextField.text = "\(calories)"
        }
        if let cookTime = recipe.cookTime {
            cookTimeTextField.text = "\(cookTime)"
        }
        updateFavoriteButton()
    }
    
    func updateFavoriteButton() {
        guard let recipe = recipe else { return }
        let favoriteImageName = recipe.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        isFavoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let recipe = recipe,
              let title = recipeTitleTextField.text,
              let description = recipeDescriptionTextField.text else { return }
        let calories = Int(calorieTextField.text ?? "")
        let cookTime = Int(cookTimeTextField.text ?? "")
        RecipeController.update(recipe: recipe,
                                title: title,
                                description: description,
                                calories: calories,
                                cookTime: cookTime)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func isFavoriteButtonTapped(_ sender: UIButton) {
        guard let recipe = recipe else { return }
        RecipeController.toggleFavorite(recipe: recipe)
        updateFavoriteButton()
    }
}
