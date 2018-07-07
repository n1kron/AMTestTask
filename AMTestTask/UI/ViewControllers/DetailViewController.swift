//
//  DetailViewController.swift
//  AMTestTask
//
//  Created by  Kostantin Zarubin on 06.07.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
    @IBOutlet weak var detailImageView: UIImageView!
    var selectedImageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.kf.setImage(with: URL(string: selectedImageUrl), completionHandler: { (image, error, cacheType, imageUrl) in
        })
    }

}
