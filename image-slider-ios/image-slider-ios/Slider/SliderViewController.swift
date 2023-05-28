//
//  SliderViewController.swift
//  image-slider-ios
//
//  Created by user on 28/05/23.
//

import UIKit

class SliderViewController: UIViewController {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var sliderPageControl: UIPageControl!
    
    struct Hero {
        var name: String
        var image: String
    }
    
    let data: [Hero] = [
        Hero(name: "Ancient Apparition", image: "ancient_apparition"),
        Hero(name: "Bounty Hunter", image: "bounty_hunter"),
        Hero(name: "Centaur", image: "centaur"),
        Hero(name: "Ember Spirit", image: "ember_spirit"),
        Hero(name: "Invoker", image: "invoker"),
        Hero(name: "Troll Warlord", image: "troll_warlord"),
    ]
    
    var currentIndex = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.hidesBackButton = true  
        
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        sliderCollectionView.register(UINib(nibName: String(describing: SliderCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SliderCollectionViewCell.self))
        
        sliderPageControl.currentPage = 0
        sliderPageControl.numberOfPages = data.count
        
        startTimer()
    }
    
    func startTimer() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.doSlideImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func doSlideImage() {
        if currentIndex < data.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            sliderPageControl.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            sliderPageControl.currentPage = currentIndex
            currentIndex = 1
        }
    }
}

extension SliderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = data[indexPath.row]
        let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SliderCollectionViewCell.self), for: indexPath) as! SliderCollectionViewCell
        
        cell.heroImageView.image = UIImage(named: item.image)
        
        return cell
    }
}

extension SliderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(data[indexPath.row].name)
    }
}

extension SliderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
