//
//  PlaySoundsViewController.swift
//  Training
//
//  Created by iTexico Dev on 9/3/15.
//  Copyright (c) 2015 Giovas. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
//        if var path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var pathInURL = NSURL(fileURLWithPath: path)
//            
//        }else{
//            println("File not found")
//        }
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        player.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        player.rate = 0.5
        player.prepareToPlay()
        player.play()
    }

    @IBAction func playFast(sender: UIButton) {
        player.rate = 2
        player.prepareToPlay()
        player.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        player.stop()
    }
    
    
    @IBAction func playChimpmunkAudio(sender: UIButton) {
        playAudioWithPitch(1000)
    }
    @IBAction func playDarthVaderVoice(sender: UIButton) {
        playAudioWithPitch(-1000)
    }
    
    func playAudioWithPitch(pitch : Float){
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
