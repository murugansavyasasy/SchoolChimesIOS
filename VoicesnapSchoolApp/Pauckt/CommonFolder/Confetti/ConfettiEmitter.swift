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
        let width = rect.width
        let height = rect.height

        // Start point (top left)
        path.move(to: CGPoint(x: 0, y: height / 4))

        // Curved edges to simulate a waving ribbon
        path.addQuadCurve(to: CGPoint(x: width / 3, y: 0), control: CGPoint(x: width / 6, y: -height / 4))
        path.addQuadCurve(to: CGPoint(x: 2 * width / 3, y: height / 2), control: CGPoint(x: width / 2, y: height + height / 4))
        path.addQuadCurve(to: CGPoint(x: width, y: height / 4), control: CGPoint(x: 5 * width / 6, y: -height / 4))

        // Bottom part mirroring the top for a wavy ribbon
        path.addQuadCurve(to: CGPoint(x: 2 * width / 3, y: height), control: CGPoint(x: 5 * width / 6, y: height + height / 4))
        path.addQuadCurve(to: CGPoint(x: width / 3, y: height / 2), control: CGPoint(x: width / 2, y: -height / 4))
        path.addQuadCurve(to: CGPoint(x: 0, y: height * 3 / 4), control: CGPoint(x: width / 6, y: height + height / 4))

        path.closeSubpath()
        return path
    }
}

