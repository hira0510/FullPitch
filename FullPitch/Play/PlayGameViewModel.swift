//
//  PlayGameViewModel.swift
//  FullPitch
//
//  Created by  on 2021/10/1.
//

import UIKit

enum ColorModel {
    case zero
    case one
    case two
    case three
    case fore
    case five
    case six
    case seven
    case eight
}

class PlayGameViewModel: NSObject {
    private let colorModel: [ColorModel] = [.zero, .zero, .zero, .zero, .one, .one, .one, .one, .two, .two, .two, .two, .three, .three, .three, .three, .fore, .fore, .fore, .fore, .five, .five, .five, .five, .six, .six, .six, .six, .seven, .seven, .seven, .seven, .eight, .eight, .eight, .eight]
    var tempModel: [[ColorModel]] = []
    /// 是否有選擇一個
    var selectFirstItem: Int?
    var mTimes: Int = 0
    var mCount: Int = 0
    let bottleBounds: CGRect = {
        let w: CGFloat = 50 / 375 * UIScreen.main.bounds.width
        let h: CGFloat = 160 / 375 * UIScreen.main.bounds.width
        return CGRect(x: 0, y: 0, width: w, height: h)
    }()

    /// 隨機顏色
    func randomColor() {
        tempModel = [[ColorModel]](repeating: [], count: 11)
        var index: Int = 0
        for value in colorModel.shuffled() {
            if tempModel[index].count < 4 {
                tempModel[index].append(value)
            } else {
                index += 1
                tempModel[index].append(value)
            }
        }
    }

    /// 是否通關
    func isSuccess() -> Bool {
        var successCount: Int = 0
        for values in tempModel {
            guard values.count >= 4 else { continue }
            if values[0] == values[1] && values[0] == values[2] && values[0] == values[3] {
                successCount += 1
            }
        }
        return successCount >= 9
    }

//    /// 波浪layer
//    func addWaveLayer(_ color: UIColor = .clear, _ view: UIView, _ y: CGFloat) -> CAShapeLayer {
//        let layer1 = CAShapeLayer()
//        layer1.bounds = view.bounds
//        layer1.position = CGPoint(x: 0, y: y)
//        layer1.anchorPoint = CGPoint.zero
//        layer1.path = frontLayerPath(view)
//        layer1.fillColor = color.cgColor
//        return layer1
//    }
//
//    /// 繪製波浪
//    func frontLayerPath(_ view: UIView) -> CGPath? {
//        let w: CGFloat = view.frame.width
//        let h: CGFloat = 25
//        let bezierFristWave = UIBezierPath()
//        let waveHeight: CGFloat = 3
//        let pathRef = CGMutablePath()
//        let startOffY = waveHeight * CGFloat(sinf(0 * .pi * 2 / Float(w)))
//        var orignOffY: CGFloat = 0.0
//        pathRef.move(to: CGPoint(x: 0, y: startOffY), transform: .identity)
//        bezierFristWave.move(to: CGPoint(x: 0, y: startOffY))
//
//        for i in stride(from: 0 as CGFloat, to: w * 2, by: +1 as CGFloat) {
//            orignOffY = waveHeight * CGFloat(sinf(Float(2 * .pi / w * i)))
//            bezierFristWave.addLine(to: CGPoint(x: CGFloat(i), y: orignOffY))
//        }
//
//        bezierFristWave.addLine(to: CGPoint(x: w * 2, y: orignOffY))
//        bezierFristWave.addLine(to: CGPoint(x: w * 2, y: h))
//        bezierFristWave.addLine(to: CGPoint(x: 0, y: h))
//        bezierFristWave.addLine(to: CGPoint(x: 0, y: startOffY))
//        bezierFristWave.close()
//        return bezierFristWave.cgPath
//    }

    /// 波浪layer
    func addWaveLayer(_ color: UIColor = .clear, _ view: UIView, _ y: CGFloat) -> CAShapeLayer {
        // 設定半徑
        let radius: CGFloat = bottleBounds.height / 6 / 2

        let layer1 = CAShapeLayer()
        layer1.bounds = bottleBounds
        layer1.position = CGPoint(x: (bottleBounds.width / 2), y: y)
        layer1.anchorPoint = CGPoint.zero
        // 設定圓心
        let arcCenter: CGPoint = CGPoint(x: 0, y: 0)
        // 剩下沒設置到的參數就為起始角度跟結束角度，最後為是否順時針
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
        layer1.path = path.cgPath
        layer1.fillColor = color.cgColor
        return layer1
    }
}

extension ColorModel: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case #colorLiteral(red: 0.9490196078, green: 0.9960784314, blue: 0.3960784314, alpha: 1): self = .zero
        case #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1): self = .one
        case #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1): self = .two
        case #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1): self = .three
        case #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1): self = .fore
        case #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1): self = .five
        case #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1): self = .six
        case #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1): self = .seven
        case #colorLiteral(red: 0.664901793, green: 0.5623478293, blue: 0.5573009849, alpha: 1): self = .eight
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .zero: return #colorLiteral(red: 0.9490196078, green: 0.9960784314, blue: 0.3960784314, alpha: 1)
        case .one: return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .two: return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .three: return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .fore: return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case .five: return #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        case .six: return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case .seven: return #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        case .eight: return #colorLiteral(red: 0.664901793, green: 0.5623478293, blue: 0.5573009849, alpha: 1)
        }
    }
}
