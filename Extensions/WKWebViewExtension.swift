//
//  WKWebViewExtension.swift
//  ARKitImageRecognition
//
//  Created by Sam DuBois on 10/13/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true);
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snapshotImage;
    }
}
