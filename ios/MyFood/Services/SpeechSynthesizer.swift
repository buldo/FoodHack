//
//  SpeechSynthesizer.swift
//  MyFood
//
//  Created by Georgy Kasapidi on 03.03.18.
//  Copyright © 2018 NoName. All rights reserved.
//

import Foundation
import AVFoundation

final class SpeechSynthesizer {
    private class SpeechSynthesizerDelegate: NSObject, AVSpeechSynthesizerDelegate {
        var completion: ((Bool) -> Void)?

        func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
            completion?(true)
        }

        func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
            completion?(false)
        }
    }

    private let operationQueue = DispatchQueue(label: "")

    private let synthesizer = AVSpeechSynthesizer()
    private let delegate = SpeechSynthesizerDelegate()

    init() {
        delegate.completion = { [weak self] _ in
            DispatchQueue.main.async {
                self?.synthesisCallback?()
            }
        }
        
        synthesizer.delegate = delegate
    }

    // MARK: -

    var synthesisCallback: (() -> Void)? = nil

    // MARK: -

    var isActive: Bool {
        return operationQueue.sync { [weak self] in
            self?.synthesizer.isSpeaking ?? false
        }
    }

    func start(text: String) {
        operationQueue.async { [weak self] in
            self?.startInternal(text: text)
        }
    }
    
    func stop(now: Bool) {
        operationQueue.async { [weak self] in
            self?.stopInternal(now: now)
        }
    }

    // MARK: -

    private func startInternal(text: String) {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])

        let utterance = AVSpeechUtterance(string: text)

        synthesizer.speak(utterance)
    }

    private func stopInternal(now: Bool) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: now ? .immediate : .word)
        }
    }
}

//        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])

//var utteranceCallback: (() -> Void)? = nil {
//    didSet {
//        let _utteranceCallback = utteranceCallback
//
//        synthesizerDelegate.didFinishUtterance = { _ in
//            _utteranceCallback?()
//        }
//    }
//}


