import UIKit

// RSIShareViewController is vendored into this target (see RSIShareViewController.swift).
class ShareViewController: RSIShareViewController {
    override func shouldAutoRedirect() -> Bool {
        return true
    }
}
