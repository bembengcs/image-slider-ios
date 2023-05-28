//
//  ViewController.swift
//  image-slider-ios
//
//  Created by user on 17/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc = SliderViewController(nibName: String(describing: SliderViewController.self), bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

