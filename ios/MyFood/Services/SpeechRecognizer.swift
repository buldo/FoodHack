import Foundation
import Speech

struct SpeechRecognitionResult {
    let text: String
    let segments: [String]
}

final class SpeechRecognizer {
    private struct Consts {
        static let bus: AVAudioNodeBus = 0
        static let bufferSize: AVAudioFrameCount = 1024
    }

    private let operationQueue = DispatchQueue(label: "")

    private let audioEngine: AVAudioEngine
    private let speechRecognizer: SFSpeechRecognizer
    private let request: SFSpeechAudioBufferRecognitionRequest
    
    init?(locale: Locale = Locale(identifier: "ru_RU")) {
        guard let speechRecognizer = SFSpeechRecognizer(locale: locale), speechRecognizer.isAvailable else {
            return nil
        }

        self.audioEngine = AVAudioEngine()
        self.speechRecognizer = speechRecognizer
        self.request = SFSpeechAudioBufferRecognitionRequest()
    }

    // MARK: -

    var recognitionCallback: ((SpeechRecognitionResult) -> Void)? = nil

    // MARK: -

    var isActive: Bool {
        return operationQueue.sync { [weak self] in
            self?.recognitionTask != nil
        }
    }

    func start() {
        operationQueue.async { [weak self] in
            self?.startRecognitionInternal()
        }
    }

    func stop() {
        operationQueue.async { [weak self] in
            self?.stopRecognitionInternal()
        }
    }

    // MARK: -

    private var recognitionTask: SFSpeechRecognitionTask? = nil

    private func startRecognitionInternal() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryRecord, with: [])

        let node = audioEngine.inputNode
        let format = node.outputFormat(forBus: Consts.bus)

        node.installTap(onBus: Consts.bus, bufferSize: Consts.bufferSize, format: format, block: { [weak self] (buffer, _) in
            self?.request.append(buffer)
        })

        audioEngine.prepare()

        try? audioEngine.start()

        speechRecognizer.recognitionTask(with: request) { [weak self] (result, error) in
            guard let result = result else {
                return
            }

            let bestTranscription = result.bestTranscription

            let text = bestTranscription.formattedString
            let segments = bestTranscription.segments.map { $0.substring }

            DispatchQueue.main.async {
                self?.recognitionCallback?(SpeechRecognitionResult(text: text, segments: segments))
            }
        }
    }

    private func stopRecognitionInternal() {
        recognitionTask?.cancel()
        recognitionTask = nil

        request.endAudio()

        audioEngine.inputNode.removeTap(onBus: Consts.bus)

        audioEngine.stop()
    }
}
