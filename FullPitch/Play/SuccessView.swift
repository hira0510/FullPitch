//
//  SuccessView.swift
//  FullPitch
//
//  Created by Hira on 2021/10/4.
//

import UIKit

class SuccessView: UIView {
    
    @IBOutlet var mView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    private var mTime: String = ""
    private var mCount: Int = 0
    internal var clickContinueBtnHandler: (() -> Void)? = { }
    internal var clickBackBtnHandler: (() -> Void)? = { }
    
    init(frame: CGRect, time: String, count: Int) {
        super.init(frame: frame)
        mTime = time
        mCount = count
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SuccessView", owner: self, options: nil)
        addSubview(mView!)
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        infoView.layer.cornerRadius = 10
        
        continueButton.layer.cornerRadius = 10
        continueButton.layer.borderColor = #colorLiteral(red: 0.1411764706, green: 0.2470588235, blue: 0.3647058824, alpha: 1)
        continueButton.layer.borderWidth = 1.5
        continueButton.addTarget(self, action: #selector(didClickContinueBtnHandler), for: .touchUpInside)
        
        backButton.layer.cornerRadius = 10
        backButton.layer.borderColor = #colorLiteral(red: 0.1411764706, green: 0.2470588235, blue: 0.3647058824, alpha: 1)
        backButton.layer.borderWidth = 1.5
        backButton.addTarget(self, action: #selector(didClickBackBtnHandler), for: .touchUpInside)
        
        let formatter = DateFormatter()
        let now = Date()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        timeLabel.text = "移动次数：\(mCount)\n时间：\(mTime)\n日期：\(formatter.string(from: now))"
        
        let record: [String] = UserDefaults.standard.stringArray(forKey: "Record") ?? []
        UserDefaults.standard.setValue(record + [timeLabel.text!], forKey: "Record")
    }
    
    /// 點擊繼續按鈕
    @objc private func didClickContinueBtnHandler() {
        clickContinueBtnHandler?()
        self.removeFromSuperview()
    }
    
    /// 點擊關閉按鈕
    @objc private func didClickBackBtnHandler() {
        clickBackBtnHandler?()
        self.removeFromSuperview()
    }
}
