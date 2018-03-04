import Foundation
import AVFoundation
import Speech

final class SpeechService {
    private final class Recognizer {
        private class Task {
            private struct Consts {
                static let bus: AVAudioNodeBus = 0
                static let bufferSize: AVAudioFrameCount = 1024
            }

            private let speechRecognizer: SFSpeechRecognizer
            private let audioEngine = AVAudioEngine()
            private let request = SFSpeechAudioBufferRecognitionRequest()

            init(speechRecognizer: SFSpeechRecognizer) {
                self.speechRecognizer = speechRecognizer

                let node = audioEngine.inputNode
                let format = node.outputFormat(forBus: Consts.bus)

                node.installTap(onBus: Consts.bus, bufferSize: Consts.bufferSize, format: format, block: { [weak self] (buffer, _) in
                    self?.request.append(buffer)
                })
            }

            deinit {
                task?.finish()

                request.endAudio()

                audioEngine.inputNode.removeTap(onBus: Consts.bus)

                if audioEngine.isRunning {
                    audioEngine.reset()
                    audioEngine.stop()
                }
            }

            private var task: SFSpeechRecognitionTask? = nil

            func run(_ completion: @escaping (SFSpeechRecognitionResult?) -> Void) {
                audioEngine.prepare()

                do {
                    try audioEngine.start()

                    task = speechRecognizer.recognitionTask(with: request, resultHandler: { (result, _) in
                        completion(result)
                    })
                }
                catch {
                    completion(nil)
                }
            }
        }

        private let speechRecognizer: SFSpeechRecognizer

        init(speechRecognizer: SFSpeechRecognizer) {
            self.speechRecognizer = speechRecognizer
        }

        // MARK: -

        private var task: Task?

        func start(_ completion: @escaping (SFSpeechRecognitionResult?) -> Void) {
            task = Task(speechRecognizer: speechRecognizer)

            task?.run(completion)
        }

        func stop() {
            task = nil
        }
    }

    private final class Synthesizer {
        private final class SynthesizerDelegate: NSObject, AVSpeechSynthesizerDelegate {
            var completion: ((Bool) -> Void)?

            func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
                completion?(true)
            }

            func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
                completion?(false)
            }
        }

        private final class Task {
            private let synthesizer = AVSpeechSynthesizer()
            private let delegate = SynthesizerDelegate()

            init(text: String, callback: (() -> Void)?) {
                delegate.completion = { _ in
                    DispatchQueue.main.async {
                        callback?()
                    }
                }

                synthesizer.delegate = delegate

                let utterance = AVSpeechUtterance(string: text)

                synthesizer.speak(utterance)
            }

            deinit {
                synthesizer.stopSpeaking(at: .immediate)
            }
        }

        // MARK: -

        var callback: (() -> Void)? = nil

        // MARK: -

        private var task: Task?

        func start(text: String) {
            task = Task(text: text, callback: callback)
        }

        func stop() {
            task = nil
        }
    }

    private let operationQueue = DispatchQueue(label: "")

    private let audioSession: AVAudioSession

    private let recognizer: Recognizer
    private let synthesizer: Synthesizer

    private init(audioSession: AVAudioSession, speechRecognizer: SFSpeechRecognizer) {
        self.audioSession = audioSession

        self.recognizer = Recognizer(speechRecognizer: speechRecognizer)
        self.synthesizer = Synthesizer()
    }

    convenience init?(locale: Locale = Locale(identifier: "ru_RU")) {
        guard let speechRecognizer = SFSpeechRecognizer(locale: locale), speechRecognizer.isAvailable else {
            return nil
        }

        self.init(audioSession: AVAudioSession.sharedInstance(), speechRecognizer: speechRecognizer)
    }

    // MARK: -

    var recognitionCallback: ((String, [String]) -> Void)? = nil {
        willSet {
            assert(Thread.isMainThread)
        }
    }
    
    var utteranceCallback: (() -> Void)? = nil {
        willSet {
            assert(Thread.isMainThread)
        }
        didSet {
            synthesizer.callback = utteranceCallback
        }
    }

    // MARK: -

    func startRecognition() {
        operationQueue.async { [weak self] in
            try? self?.audioSession.setCategory(AVAudioSessionCategoryRecord)

            self?.recognizer.start { result in
                guard let result = result else {
                    return
                }

                let bestTranscription = result.bestTranscription

                let text = bestTranscription.formattedString
                let segments = bestTranscription.segments.map { $0.substring }

                DispatchQueue.main.async {
                    self?.recognitionCallback?(text, segments)
                }
            }
        }
    }

    func stopRecognition() {
        operationQueue.async { [weak self] in
            self?.recognizer.stop()
        }
    }

    func startUtterance(text: String) {
        operationQueue.async { [weak self] in
            try? self?.audioSession.setCategory(AVAudioSessionCategoryPlayback)

            self?.synthesizer.start(text: text)
        }
    }

    func stopUtterance() {
        operationQueue.async { [weak self] in
            self?.synthesizer.stop()
        }
    }
}
