//
//  RecipeListViewController.swift
//  MyFood
//
//  Created by Georgy Kasapidi on 04.03.18.
//  Copyright © 2018 NoName. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    init(recipes: [RecipeListInfo]){
        super.init(nibName: "RecipeListViewController", bundle: nil)
        self.recipes = recipes
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Рецепты"
        tableView.rowHeight=96
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "RecipeListTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
    }

    var recipes: [RecipeListInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! RecipeListTableViewCell
        cell.configure(recipe: recipes[indexPath.row])
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let recipeURL = URL(string: "https://myfood-dev-as.azurewebsites.net/api/Recipes/\(recipe.id)")!

        URLSession.shared.dataTask(with: recipeURL) { [weak self] (data, _, _) in
            guard let data = data else {
                return
            }
            
            guard let recipe = try? JSONDecoder().decode(RecipeInfo.self, from: data) else {
                return
            }
            
            DispatchQueue.main.async {
                let vc = RecipeViewController(recipe: recipe)
                
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            }.resume()
    }
}
