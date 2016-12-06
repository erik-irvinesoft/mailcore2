import Foundation

public class IMAPFetchFoldersOperation : IMAPBaseOperation {
    
    public typealias CompletionBlock = (Error?,  [IMAPFolder]?) -> Void
    
    internal var operation: CIMAPFetchFoldersOperation
    private var completionBlock : CompletionBlock?
    
    internal init(operation:CIMAPFetchFoldersOperation) {
        self.operation = operation
        super.init(baseOperation: operation.baseOperation)
    }
    
    deinit {
        completionBlock = nil;
    }
    
    public func start(completionBlock: CompletionBlock?) {
        self.completionBlock = completionBlock
        start()
    }
    
    public override func cancel() {
        completionBlock = nil
        super.cancel()
    }
    
    public override func operationCompleted() {
        if (completionBlock == nil) {
            return
        }
        
        let errorCode = error()
        if errorCode == ErrorNone {
            completionBlock!(nil, Array<IMAPFolder>.cast(operation.folders(operation)))
        }
        else {
            completionBlock!(MailCoreError(code: errorCode), nil)
        }
        completionBlock = nil
    }
    
}