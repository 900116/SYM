// The MIT License (MIT)
//
// Copyright (c) 2016 zqqf16
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import Cocoa


class TabViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //self.tabView.selectTabViewItem(at: 0)

        NotificationCenter.default.addObserver(self, selector: #selector(self.handleSwitchViewMode), name: .switchViewMode, object: nil)
    }
    
    var currentViewMode: ViewMode {
        if let item = self.tabView.selectedTabViewItem {
            if item == self.tabView.tabViewItem(at: 1) {
                return .thread
            }
        }
        
        return .text
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let mode = self.windowController()?.viewMode {
            if self.currentViewMode != mode {
                self.tabView.selectTabViewItem(at: mode.rawValue)
            }
        } else {
            self.tabView.selectTabViewItem(at: 0)
        }
    }
    
    func handleSwitchViewMode(notification: Notification) {
        if let wc = notification.object as? MainWindowController, wc == self.windowController() {
            self.tabView.selectTabViewItem(at: wc.viewMode.rawValue)
        }
    }
}
