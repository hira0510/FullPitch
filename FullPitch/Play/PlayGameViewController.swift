//
//  PlayGameViewController.swift
//  FullPitch
//
//  Created by  on 2021/10/1.
//

import UIKit

class PlayGameViewController: UIViewController {

    @IBOutlet var views: PlayGameViews!
    
    private let viewModel = PlayGameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        views.bottomArray = [views.bottomView0, views.bottomView1, views.bottomView2, views.bottomView3, views.bottomView4, views.bottomView5, views.bottomView6, views.bottomView7, views.bottomView8, views.bottomView9, views.bottomView10]
        setupUI()
    }
    
    private func setupUI() {
        viewModel.randomColor()
        
        for (i, values) in viewModel.tempModel.enumerated() {
            let firstBottom = views.bottomArray[0]
            let bottom = views.bottomArray[i]
            
            bottom.tag = i
            bottom.isUserInteractionEnabled = true
            bottom.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didClickBottom(_:))))
            
            for layer in bottom.layer.sublayers! {
                if layer.isKind(of: CAShapeLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
            
            guard i <= 8 else { continue }
            for (i, value) in values.enumerated() {
                // 圓半徑
                let radius: CGFloat = viewModel.bottleBounds.height / 6 / 2
                bottom.layer.addSublayer(viewModel.addWaveLayer(value.rawValue, firstBottom, (viewModel.bottleBounds.height) - (10 + radius) - (CGFloat(i) * (radius * 2 + 2))))
            }
            bottom.bringSubviewToFront(bottom.subviews.first!)
        }
        
        views.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        views.mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounts), userInfo: nil, repeats: true)
    }
    
    /// 返回
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    /// 計時
    @objc func timerCounts() {
        viewModel.mTimes += 1
        let times = String(format: "%02d:%02d", viewModel.mTimes / 60, viewModel.mTimes % 60)
        views.timesLabel.text = "时间：\(times)\n次數：\(viewModel.mCount)"
    }
    
    /// 點擊瓶子
    @objc func didClickBottom(_ sender: UITapGestureRecognizer) {
        guard let selectItem = viewModel.selectFirstItem, let view = sender.view else {
            guard viewModel.tempModel[sender.view!.tag].count > 0 else { return }
            viewModel.selectFirstItem = sender.view?.tag
            (sender.view?.subviews.first as? UIImageView)?.image = UIImage(named: "Image2")
            return
        }
        
        guard selectItem != view.tag else {
            viewModel.selectFirstItem = nil
            (view.subviews.first as? UIImageView)?.image = UIImage(named: "Image")
            return
        }
        
        let layerIndex = (self.views.bottomArray[selectItem].layer.sublayers?.count ?? 0) - 2
        guard layerIndex >= 0, let sublayersCount = view.layer.sublayers?.count, sublayersCount < 5, let color = viewModel.tempModel[selectItem].last else { return }
        
        views.bottomArray[selectItem].layer.sublayers?[layerIndex].removeFromSuperlayer()
        // 圓半徑
        let radius: CGFloat = viewModel.bottleBounds.height / 6 / 2
        view.layer.addSublayer(viewModel.addWaveLayer(color.rawValue, view, viewModel.bottleBounds.height - (10 + radius) - (CGFloat(sublayersCount - 1) * (radius * 2 + 2))))
        view.bringSubviewToFront(view.subviews.first!)
        (views.bottomArray[selectItem].subviews.first as? UIImageView)?.image = UIImage(named: "Image")
        
        viewModel.selectFirstItem = nil
        viewModel.tempModel[selectItem].removeLast()
        viewModel.tempModel[view.tag].append(color)
        viewModel.mCount += 1
        
        let times = String(format: "%02d:%02d", viewModel.mTimes / 60, viewModel.mTimes % 60)
        views.timesLabel.text = "时间：\(times)\n次數：\(viewModel.mCount)"
        
        guard viewModel.isSuccess() else { return }
        
        views.mTimer?.invalidate()
        views.mTimer = nil
        
        views.bottomArray.forEach { view in
            view.isUserInteractionEnabled = false
        }
        
        let mView = SuccessView(frame: self.view.frame, time: times, count: viewModel.mCount)
        mView.clickBackBtnHandler = { [weak self] in
            guard let `self` = self else { return }
            self.back()
        }
        
        mView.clickContinueBtnHandler = { [weak self] in
            guard let `self` = self else { return }
            self.views.timesLabel.text = "时间：00:00\n次數：0"
            self.viewModel.mTimes = 0
            self.viewModel.mCount = 0
            self.setupUI()
        }
        self.view.addSubview(mView)
    }
}
