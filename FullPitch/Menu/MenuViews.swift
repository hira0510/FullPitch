//
//  MenuViews.swift
//  FullPitch
//
//  Created by Hira on 2021/10/1.
//

import UIKit

class MenuViews: NSObject {

    @IBOutlet weak var textView: ShimmeringView!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    func addTextView() {
        let label = UILabel(frame: textView.bounds)
        label.text = "开始游戏"
        label.textColor = #colorLiteral(red: 0.8431372549, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: "PingFangTC-Regular", size: 40)!

        textView.contentView = label
        textView.isShimmering = true
        textView.shimmerSpeed = 200
        textView.shimmerPauseDuration = 0.5
    }
}
