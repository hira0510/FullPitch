//
//  MenuViewController.swift
//  FullPitch
//
//  Created by  on 2021/10/1.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var views: MenuViews!

    private let viewModel = MenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        views.addTextView()
        views.arrowImageView.layer.add(viewModel.iconImgAnimate(self.view.frame.width), forKey: "image")
    }
}
