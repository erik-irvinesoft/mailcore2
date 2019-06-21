import Foundation
import CMailCore

public class MCOIMAPOperation : MCOIMAPBaseOperation {
    
    public typealias CompletionBlock = (Error?) -> Void
    
    private let cancelLock = NSLock()
    private var completionBlock: CompletionBlock?
    
    internal init(operation:CIMAPBaseOperation) {
        super.init(baseOperation: operation)
    }
    
    public func start(completionBlock: CompletionBlock?) {
        self.completionBlock = completionBlock
        start()
    }
    
    public override func cancel() {
        cancelLock.lock()
        completionBlock?(MailCoreError.error(code: ErrorCanceled))
        self.completionBlock = nil
        cancelLock.unlock()
        super.cancel()
    }
    
    public override func operationCompleted() {
        cancelLock.lock()
        guard let completionBlock = self.completionBlock else {
            cancelLock.unlock()
            return
        }
        self.completionBlock = nil
        cancelLock.unlock()
        let errorCode = error()
        if errorCode == ErrorNone {
            completionBlock(nil)
        }
        else {
            completionBlock(MailCoreError.error(code: errorCode))
        }
        
    }
    
}
