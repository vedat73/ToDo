//
//  SoundPlayer.swift
//  ToDo
//
//  Created by Vedat Ozlu on 26.07.2023.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound : String, type : String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) { // It will get the sound file path
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file.")
        }
    }
}
