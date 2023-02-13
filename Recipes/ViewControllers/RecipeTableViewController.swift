//
//  RecipeTableViewController.swift
//  Recipe1
//
//  Created by Stateful on 10/12/21.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    @IBOutlet weak var categoryNameTextField: UITextField!
    
    let categoryController = CategoryController.shared
    var category: RecipeCategory?

    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryNameTextField.text = category?.title
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let category = category,
            let newTitle = categoryNameTextField.text else { return }
        categoryController.updateRecipeCategory(category: category, title: newTitle)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.recipes.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell,
              let recipe = category?.recipes[indexPath.row] else { return UITableViewCell() }
        cell.recipe = recipe
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let category = category else { return }
            let recipe = category.recipes[indexPath.row]
                RecipeController.delete(recipe: recipe, in: category)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toRecipeDetail",
              let recipeDetailViewController = segue.destination as? RecipeDetailViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        let recipe = category?.recipes[selectedRow]
        recipeDetailViewController.recipe = recipe
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let category = category else { return }
        RecipeController.createRecipe(in: category)
        let newRow = category.recipes.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
}

// MARK: RecipeTableViewCellDelegate Conformance
extension RecipeTableViewController: RecipeTableViewCellDelegate {
    
    func toggleFavoriteButtonWasTapped(cell: RecipeTableViewCell) {
        guard let recipe = cell.recipe else { return }
        RecipeController.toggleFavorite(recipe: recipe)
        cell.updateViews()
    }
}
