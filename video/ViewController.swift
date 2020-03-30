//
//  ViewController.swift
//  video
//
//  Created by Melaka Atalugamage on 29/3/20.
//  Copyright © 2020 Melaka Atalugamage. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var lblVidCount: UILabel!
    
    private lazy var videoPicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
        picker.mediaTypes = ["public.movie"]
        picker.allowsEditing = false
        return picker
    }()
    
    var videos: [URL] = [] {
        didSet {
            let playerItems = videos.map { AVPlayerItem(url: $0) }
            let player = AVQueuePlayer(items: playerItems)
            //player.insert(<#T##item: AVPlayerItem##AVPlayerItem#>, after: <#T##AVPlayerItem?#>)
            //player.remove(<#T##item: AVPlayerItem##AVPlayerItem#>)
            let playerLayer = AVPlayerLayer(player: player)
            videoContainer.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            videoContainer.layer.addSublayer(playerLayer)
            playerLayer.videoGravity = .resizeAspect
            playerLayer.frame = videoContainer.frame
            player.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnAddDidTap(_ sender: UIButton) {
        present(videoPicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.mediaURL] as? URL {
            videos.append(url)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate { }

