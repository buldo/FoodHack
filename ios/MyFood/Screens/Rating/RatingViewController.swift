import UIKit
import YYWebImage

class RatingViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var dodoLabel: UILabel!

    private let recipe: RecipeInfo

    init(recipe: RecipeInfo) {
        self.recipe = recipe

        super.init(nibName: "RatingViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let dodoText = NSMutableAttributedString()

        dodoText.append(NSAttributedString(string: "Не получилось? Еще не поздно заказать пиццу", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
            ]))

        dodoText.append(NSAttributedString(string: "\n"))

        dodoText.append(NSAttributedString(string: "https://dodopizza.ru", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.blue,
            .underlineStyle: 1
            ]))

        dodoLabel.attributedText = dodoText

        imageView.yy_setImage(with: recipe.previewUrl, options: .setImageWithFadeAnimation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func star1BtnTapped(_ sender: Any) {
        starLabel.text = "⭐︎☆☆☆☆"
    }

    @IBAction func star2BtnTapped(_ sender: Any) {
        starLabel.text = "⭐︎⭐︎☆☆☆"
    }

    @IBAction func star3BtnTapped(_ sender: Any) {
        starLabel.text = "⭐︎⭐︎⭐︎☆☆"
    }

    @IBAction func star4BtnTapped(_ sender: Any) {
        starLabel.text = "⭐︎⭐︎⭐︎⭐︎☆"
    }

    @IBAction func star5BtnTapped(_ sender: Any) {
        starLabel.text = "⭐︎⭐︎⭐︎⭐︎⭐︎"
    }
}
