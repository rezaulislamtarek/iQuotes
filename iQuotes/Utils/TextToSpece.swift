import SwiftUI
import AVFoundation

// MARK: - Text-to-Speech Extension
extension String {
    enum SpeechVoiceGender {
        case male
        case female
    }
    
    enum SpeechRate: String, CaseIterable, Identifiable {
        case slow = "Slow"
        case normal = "Normal"
        case fast = "Fast"
        
        var id: String { self.rawValue }
        
        var value: Float {
            switch self {
            case .slow: return 0.4
            case .normal: return 0.5
            case .fast: return 0.6
            }
        }
    }
}

// MARK: - Speech Manager
class SpeechManager: ObservableObject {
    static let shared = SpeechManager()
    private let synthesizer = AVSpeechSynthesizer()
    
    @Published var isSpeaking = false
    @Published var isPaused = false
    
    private var currentUtterance: AVSpeechUtterance?
    
    // Speak the provided text
    func speak(_ text: String,
               language: String = "en-US",
               gender: String.SpeechVoiceGender = .female,
               rate: String.SpeechRate = .normal) {
        
        // Stop any ongoing speech
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = rate.value
        
        // Select appropriate voice based on gender
        if let voice = getVoice(for: language, gender: gender) {
            utterance.voice = voice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: language)
        }
        
        currentUtterance = utterance
        synthesizer.speak(utterance)
        isSpeaking = true
        isPaused = false
    }
    
    // Pause the current speech
    func pauseSpeech() {
        if synthesizer.isSpeaking && !isPaused {
            synthesizer.pauseSpeaking(at: .word)
            isPaused = true
        }
    }
    
    // Resume the paused speech
    func resumeSpeech() {
        if isPaused {
            synthesizer.continueSpeaking()
            isPaused = false
        }
    }
    
    // Toggle between pause and resume
    func toggleSpeech() {
        if isPaused {
            resumeSpeech()
        } else if isSpeaking {
            pauseSpeech()
        }
    }
    
    // Stop the current speech
    func stopSpeech() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
            isPaused = false
        }
    }
    
    // Get appropriate voice based on gender preference
    private func getVoice(for language: String, gender: String.SpeechVoiceGender) -> AVSpeechSynthesisVoice? {
        let voices = AVSpeechSynthesisVoice.speechVoices().filter { $0.language.starts(with: language) }
        
        // Try to find a voice that matches the gender preference
        if gender == .male {
            // First check for voices with "male" in the name
            let maleVoices = voices.filter { $0.name.lowercased().contains("male") || $0.name.lowercased().contains("man") }
            if let firstMale = maleVoices.first {
                return firstMale
            }
        } else {
            // First check for voices with "female" in the name
            let femaleVoices = voices.filter { $0.name.lowercased().contains("female") || $0.name.lowercased().contains("woman") }
            if let firstFemale = femaleVoices.first {
                return firstFemale
            }
        }
        
        // If no gender-specific voice is found, return the first available voice for the language
        return voices.first
    }
    
    // Get all available languages
    func availableLanguages() -> [String] {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let languages = voices.map { $0.language }
        return Array(Set(languages)).sorted()
    }
}

// MARK: - String Extension for TTS
extension String {
    // Speak the string
    func speak(language: String = "en-US",
               gender: SpeechVoiceGender = .female,
               rate: SpeechRate = .normal) {
        SpeechManager.shared.speak(self, language: language, gender: gender, rate: rate)
    }
    
    // Static method to pause current speech
    static func pauseSpeech() {
        SpeechManager.shared.pauseSpeech()
    }
    
    // Static method to resume current speech
    static func resumeSpeech() {
        SpeechManager.shared.resumeSpeech()
    }
    
    // Static method to toggle between pause and resume
    static func toggleSpeech() {
        SpeechManager.shared.toggleSpeech()
    }
    
    // Static method to stop current speech
    static func stopSpeech() {
        SpeechManager.shared.stopSpeech()
    }
}
