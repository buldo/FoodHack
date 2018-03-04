import UIKit
import YYWebImage

class RecipeViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var complexityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var goButton: UIButton!

    private let recipe: RecipeInfo

    init(recipe: RecipeInfo) {
        self.recipe = recipe

        super.init(nibName: "RecipeViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.textContainerInset = UIEdgeInsetsMake(0, 20, 24, 20)

        nameLabel.text = recipe.title
        complexityLabel.text = recipe.complexity
        timeLabel.text = recipe.duration
        descriptionTextView.text = recipe.ingredients.joined(separator: "\n") + "\n\n" + recipe.devices.joined(separator: "\n") + "\n\n" + recipe.description

        imageView.yy_setImage(with: recipe.previewUrl, options: .setImageWithFadeAnimation)
    }

    private var firstTime: Bool = true

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if firstTime {
            descriptionTextView.setContentOffset(.zero, animated: false)

            firstTime = false
        }
    }

    @IBAction func didTapOnGoBtn(_ sender: Any) {
        let vc = RecipeStepViewController(recipe: recipe)

        present(vc, animated: true, completion: nil)
    }
}
