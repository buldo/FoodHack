import UIKit
import Speech

private class View: UIView {
    var touchStart: (() -> Void)?
    var touchEnd: (() -> Void)?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        touchStart?()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        touchEnd?()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        touchEnd?()
    }
}

class ViewController: UIViewController {
    private let speechSynthesizer = SpeechSynthesizer()

    private var speechRecognizer: SpeechRecognizer?

    override func loadView() {
        self.view = View()
    }

    private var lastText: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        speechSynthesizer.synthesisCallback = {
            print("did finish utterance")
        }

        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            guard status == .authorized else {
                return
            }

            guard let speechRecognizer = SpeechRecognizer() else {
                return
            }

            speechRecognizer.recognitionCallback = { [weak self] result in
                print(result.text)

                self?.lastText = result.text
//                speechService?.utter(text: "Привет! Это твой первый рецепт?")
            }

            self?.speechRecognizer = speechRecognizer
        }

        let v = self.view as! View

        v.touchStart = { [weak self] in
            self?.speechSynthesizer.stop(now: true)

            self?.view.backgroundColor = UIColor.green

            self?.speechRecognizer?.start()
        }

        v.touchEnd = { [weak self] in
            self?.view.backgroundColor = UIColor.white

            self?.speechRecognizer?.stop()

            if let text = self?.lastText {
                self?.speechSynthesizer.start(text: text)
            }
        }
    }
}
