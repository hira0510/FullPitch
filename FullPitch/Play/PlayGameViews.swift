//
//  PlayGameViews.swift
//  FullPitch
//
//  Created by  on 2021/10/1.
//

import UIKit

class PlayGameViews: NSObject {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bottomView0: UIView!
    @IBOutlet weak var bottomView1: UIView!
    @IBOutlet weak var bottomView2: UIView!
    @IBOutlet weak var bottomView3: UIView!
    @IBOutlet weak var bottomView4: UIView!
    @IBOutlet weak var bottomView5: UIView!
    @IBOutlet weak var bottomView6: UIView!
    @IBOutlet weak var bottomView7: UIView!
    @IBOutlet weak var bottomView8: UIView!
    @IBOutlet weak var bottomView9: UIView!
    @IBOutlet weak var bottomView10: UIView!
    @IBOutlet weak var timesLabel: UILabel!
    
    public var bottomArray: [UIView] = []
    public var mTimer: Timer?
}
