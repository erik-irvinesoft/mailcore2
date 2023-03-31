import Foundation
import CMailCore

public class MCOIMAPSearchOperation : MCOIMAPBaseOperation {
    
    public typealias CompletionBlock = (Error?, MCOIndexSet?) -> Void
	
    private var operation: CIMAPSearchOperation
    private let lock = NSLock()
    private var completionBlock : CompletionBlock?
    
    internal init(operation:CIMAPSearchOperation) {
        self.operation = operation
        self.operation.retain()
        super.init(baseOperation: CIMAPBaseOperation.init(cobject: operation.toCObject()));
    }

	deinit {
        self.operation.release()
        lock.lock()
        completionBlock = nil
        lock.unlock()
	}
    
    /**
     Starts the asynchronous search operation.
     
     @param completionBlock Called when the operation is finished.
     
     - On success `error` will be nil and `searchResults` will contain the UIDs of any matching messages
     
     - On failure, `error` will be set with `MCOErrorDomain` as domain and an
     error code available in MCOConstants.h, `searchResult` will be nil
     */
    public func start(completionBlock: CompletionBlock?) {
        lock.lock()
        self.completionBlock = completionBlock
        lock.unlock()
        start()
    }
    
    public override func cancel() {
        lock.lock()
        completionBlock?(MailCoreError.error(code: ErrorCanceled), nil)
        completionBlock = nil
        lock.unlock()
        super.cancel()
    }
    
    public override func operationCompleted() {
        lock.lock()
        guard let completionBlock = self.completionBlock else {
            lock.unlock()
            return
        }
        self.completionBlock = nil
        lock.unlock()
        
        mailCoreAutoreleasePool {
            let errorCode = error()
            if errorCode == ErrorNone {
                completionBlock(nil, MCOIndexSet(operation.uids()))
            }
            else {
                completionBlock(MailCoreError.error(code: errorCode), nil)
            }
        }
    }
}
