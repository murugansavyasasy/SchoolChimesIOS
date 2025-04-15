//
//  ConfettiEmitter.swift
//  KirchbergConfetti
//
//  Created by Kirill Kostarev on 12.06.2023.
//

import UIKit

public enum ConfettiEmitter {

    // MARK: - Public Types

    public enum Shape: Hashable {
        case circle
        case square
        case rectangle
        case ribbon  // New ribbon shape
        case custom(CGPath)

        private static var shapesCache: [Shape: UIImage] = [:]
    }

    case shape(Shape, color: UIColor?, id: String = UUID().uuidString)
    case image(UIImage, color: UIColor?, id: String = UUID().uuidString)

    // MARK: - Internal Properties

    var id: String {
        switch self {
        case let .shape(_, _, id), let .image(_, _, id):
            return id
        }
    }

    var color: UIColor? {
        switch self {
        case let .image(_, color, _), let .shape(_, color, _):
            return color
        }
    }

    var image: UIImage {
        switch self {
        case let .shape(shape, _, _):
            return shape.image
        case let .image(image, _, _):
            return image
        }
    }

}

// MARK: - Support Properties

extension ConfettiEmitter.Shape {

    fileprivate var image: UIImage {
        if let imageFromCache = Self.shapesCache[self] {
            return imageFromCache
        } else {
            let rect = CGRect(origin: .zero, size: CGSize(width: 20.0, height: 20.0))
            let image = UIGraphicsImageRenderer(size: rect.size).image { context in
                context.cgContext.setFillColor(UIColor.white.cgColor)
                context.cgContext.addPath(path(in: rect))
                context.cgContext.fillPath()
            }
            Self.shapesCache[self] = image
            return image
        }
    }

}

// MARK: - Support Methods

extension ConfettiEmitter.Shape {
    fileprivate func path(in rect: CGRect) -> CGPath {
        switch self {
        case .circle, .square:
            return CGPath(ellipseIn: rect, transform: nil)
        case .rectangle:
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: rect.maxX, y: 0),
                CGPoint(x: rect.maxX, y: rect.maxY / 2),
                CGPoint(x: 0, y: rect.maxY / 2)
            ])
            path.closeSubpath()
            return path
        case .ribbon:
            return ribbonPath(in: rect)  // Call the new ribbon path method
        case let .custom(path):
            return path
        }
    }

    /// Creates a Ribbon-like path
    private func ribbonPath(in rect: CGRect) -> CGPath {
        let path = CGMutablePath()
        let width = rect.width * 0.2  // Make ribbons thinner
        let height = rect.height * 3  // Increase length for wavy effect

        // Start from the bottom left
        path.move(to: CGPoint(x: 0, y: height * 0.05))

        // Create multiple smooth curves to make it look like a flowing ribbon
        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.3),
                      control1: CGPoint(x: width * 0.2, y: height * -0.2),
                      control2: CGPoint(x: width * 0.4, y: height * 0.6))

        path.addCurve(to: CGPoint(x: width, y: height * 0.6),
                      control1: CGPoint(x: width * 0.7, y: height * 0.2),
                      control2: CGPoint(x: width * 0.9, y: height * 0.9))

        path.addCurve(to: CGPoint(x: width * 0.5, y: height * 0.9),
                      control1: CGPoint(x: width * 0.8, y: height * 1.2),
                      control2: CGPoint(x: width * 0.6, y: height * 0.7))

        path.addCurve(to: CGPoint(x: 0, y: height),
                      control1: CGPoint(x: width * 0.4, y: height * 1.3),
                      control2: CGPoint(x: width * 0.2, y: height * 0.9))

        path.closeSubpath()
        return path
    }


}

