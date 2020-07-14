import UIKit
import AVFoundation
import AVKit

/*
 * Button to play a sound file available in
 * main bundle
 */
class SoundPlayerButton: UIButton, AVPlayerViewControllerDelegate {
    var controller:PoemViewController?
    var audioPlayerController:AVPlayerViewController
    /*
     * sets audio file to play.
     * if nil, the button is disabled
     */
    var audio:String? {
        didSet {
            self.isEnabled = (audio != nil)
            let name:String = self.isEnabled ? "speaker": "speaker.slash"
            setImage(UIImage(systemName:name),for:.normal)
        }
    }
    
    init() {
        audioPlayerController = AVPlayerViewController()
        super.init(frame:.zero)
        self.isUserInteractionEnabled = true
        
        audioPlayerController.delegate = self
        audioPlayerController.view.isOpaque = false
        audioPlayerController.showsPlaybackControls = true
        audioPlayerController.view.frame = CGRect(x:0,y:100, width:200, height:40)
    
        NotificationCenter.default.addObserver(
                  self,
                  selector:#selector(close),
                  name:.AVPlayerItemDidPlayToEndTime,
                  object:nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     *
     */
    func play() {
        if audio == nil {return}
        NSLog("playing \(String(describing: audio))")
        let path = Bundle.main.path(forResource: audio, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        let player:AVPlayer = AVPlayer(url:url)
        audioPlayerController.player = player
        DispatchQueue.main.async {
            self.audioPlayerController.player?.play()
        }
    }
    
    /*
     *
     */
    @objc func close() {
        audioPlayerController.player?.pause()
        audioPlayerController.player?.replaceCurrentItem(with: nil)
        audioPlayerController.dismiss(animated:false)
        /*
        controller?.navigationController?
            .popViewController(animated: false)
        */
    }
    
    

}


