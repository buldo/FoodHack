import UIKit
import YYWebImage
import RxSwift

class RecipeStepViewController: UIViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var textToImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var textToTimerConstraint: NSLayoutConstraint!

    private let speechService = SpeechService()!

    private let steps: [RecipeStepInfo]

    init(steps: [RecipeStepInfo]) {
        assert(steps.count > 0)

        self.steps = steps

        super.init(nibName: "RecipeStepViewController", bundle: nil)

        speechService.utteranceCallback = { [weak self] in
            self?.didFinishedSpeaking()
        }

        speechService.recognitionCallback = { [weak self] (text, segments) in
            self?.didRecognized(text: text, segments: segments)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = steps.count

        timeSubject
            .flatMapLatest({ time -> Observable<(String, UIColor)?> in
                guard let time = time else {
                    return .just(nil)
                }

                return Observable<Int>.interval(1, scheduler: MainScheduler.instance).startWith(0).map({ value -> (String, UIColor)? in
                    let x = time - value

                    if x > 0 {
                        let str = String(format: "%02d:%02d", x/60, x%60)
                        return (str, UIColor.black)
                    } else {
                        return ("00:00", UIColor.red)
                    }
                })
            })
            .subscribe(onNext: { [weak self] tuple in
                guard let strongSelf = self else { return }

                guard let tuple = tuple else {
                    strongSelf.timerLabel.text = nil

                    return
                }

                strongSelf.timerLabel.text = tuple.0
                strongSelf.timerLabel.textColor = tuple.1
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isBeingPresented {
            currentStepIndex = 0
        }
    }

    // MARK: -

    private let timeSubject = PublishSubject<Int?>()

    private var currentStepIndex: Int = 0 {
        didSet {
            Notifications.cancelAll()

            if currentStepIndex < steps.count {
                let step = steps[currentStepIndex]

                timeSubject.onNext(step.timeInSec)

                if let time = step.timeInSec, let pushText = step.pushText {
                    showLocalNotification(text: pushText, after: time)
                }

                UIView.transition(with: self.view, duration: 0.2, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                    self.show(step: step)
                }, completion: { (_) in
                    self.speechService.startUtterance(text: step.voiceDescription)
                })
            } else {
                dismiss(animated: true, completion: {
                    let alert = UIAlertController(title: "Вуаля!", message: "Как говорится, охапка дров и ваше блюдо готово!", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                })
            }
        }
    }

    private func show(step: RecipeStepInfo) {
        if step.timeInSec != nil {
            textToImageConstraint.isActive = false
            textToTimerConstraint.isActive = true
        } else {
            textToTimerConstraint.isActive = false
            textToImageConstraint.isActive = true
        }

        textLabel.text = step.description

        pageControl.currentPage = currentStepIndex

        imageView.yy_setImage(with: step.pictureUrl, options: .setImageWithFadeAnimation)
    }

    // MARK: -

    private func showLocalNotification(text: String, after: Int) {
        Notifications.show(text: text, after: after)
    }

    private func didFinishedSpeaking() {
        speechService.startRecognition()

        isRecognizing = true
    }

    var isRecognizing: Bool = false

    private func didRecognized(text: String, segments: [String]) {
        guard isRecognizing else {
            return
        }

        let segments = Set(segments.map({ $0.lowercased() }))

        if Set(["продолжить", "готово", "готова", "далее", "дальше", "следующий"]).intersection(segments).count > 0 {
            isRecognizing = false

            speechService.stopRecognition()

            currentStepIndex += 1
        }

        if Set(["повторить", "повтори"]).intersection(segments).count > 0 && currentStepIndex < steps.count {
            isRecognizing = false

            speechService.stopRecognition()
            
            speechService.startUtterance(text: steps[currentStepIndex].voiceDescription)
        }
    }
}
