//
//  ViewController.swift
//  AMTestTask
//
//  Created by  Kostantin Zarubin on 05.07.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    let images = ImageList()
    var selectedImageUrl = ""
    private let cellSize = (UIScreen.main.bounds.size.width/3) - 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.load()
        animateLoading()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: Notification.Name("imageListLoaded"), object: nil)
    }

    @objc func updateCollectionView() {
        stopAnimateLoading()
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    private func animateLoading() {
        loadingLabel.isHidden = false
        collectionView.isHidden = true
        loadingLabel.alpha = 1.0
        UIView.animate(withDuration: 1, delay: 0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: { [weak self] () -> Void in
            self?.loadingLabel.alpha = 0.0
            return
        }, completion: nil)
    }
    
    private func stopAnimateLoading() {
        loadingLabel.isHidden = true
        loadingLabel.layer.removeAllAnimations()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "selectedImage" {
            let vc:DetailViewController = segue.destination as! DetailViewController
            vc.selectedImageUrl = selectedImageUrl
        }
    }
}

extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: images.imageUrls[indexPath.row]), completionHandler: { (image, error, cacheType, imageUrl) in
        })
        
        //MARK: - if the kingfisher is not allowed to use, uncomment this lines and comment kf usage
        
        //        cell.imageView.image = nil
        //        ImageLoader().image(for: URL(string: images.imageUrls[indexPath.row])!, completionHandler: { image in
        //            cell.imageView.image = image
        //        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageUrl = images.imageUrls[indexPath.row]
        performSegue(withIdentifier: "selectedImage", sender: self)
    }
}
