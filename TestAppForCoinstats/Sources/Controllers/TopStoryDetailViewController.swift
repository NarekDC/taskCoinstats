//
//  TopStoryDetailViewController.swift
//  CodingTest
//
//  Created by faizal on 07/10/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation
import UIKit

class TopStoryDetailViewController: UIViewController {
    
    var selectedFeed : FeedInfoData?
    
    @IBOutlet weak var imageTopstory: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var ldlDescription: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI()  {
        self.navigationController?.navigationBar.topItem?.title = ""
        
        guard let selectedFeed = selectedFeed else {
           return
        }
        
        self.imageTopstory.loadImageUsingUrlString(urlString: selectedFeed.coverPhotoURL)
        self.lblTittle.text = selectedFeed.title.decoded
        self.ldlDescription.text = selectedFeed.body.decoded
    }
    
}
