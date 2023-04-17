import UIKit
import CoreImage
import AVFoundation

class VideoView: GPUImageView {
    var movie: GPUImageMovie!
    var filter: GPUImageChromaKeyBlendFilter!
    var sourcePicture: GPUImagePicture!
    var player = AVPlayer()

    func configureAndPlay(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp4") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)

        filter = GPUImageChromaKeyBlendFilter()
        filter.thresholdSensitivity = 0.15
        filter.smoothing = 0.3
        filter.setColorToReplaceRed(1, green: 0, blue: 1)

        movie = GPUImageMovie(playerItem: playerItem)
        movie.playAtActualSpeed = true
        movie.addTarget(filter)
        movie.startProcessing()

        let backgroundImage = UIImage(named: "transparent.png")
        sourcePicture = GPUImagePicture(image: backgroundImage, smoothlyScaleOutput: true)!
        sourcePicture.addTarget(filter)
        sourcePicture.processImage()

        filter.addTarget(self)
        player.play()
    }
}
