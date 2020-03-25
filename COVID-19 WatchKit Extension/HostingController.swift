//
//  HostingController.swift
//  COVID-19 WatchKit Extension
//
//  Created by michael.chan on 23/03/2020.
//  Copyright © 2020 michael.chan. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<WatchCOVID19ListView> {

    override var body: WatchCOVID19ListView {

        return WatchCOVID19ListView()

    }

}
