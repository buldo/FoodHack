import UIKit
import FLAnimatedImage

class SplashViewController: UIViewController {
    @IBOutlet weak var gifImageview: FLAnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageData = try! Data(contentsOf: Bundle.main.url(forResource: "dancing_turkey", withExtension: "gif")!)

        gifImageview.animatedImage = FLAnimatedImage(animatedGIFData: imageData)
    }
}
