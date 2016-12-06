import Foundation

public class Attachment : AbstractPart {

    internal var nativeInstance: CAttachment;
    
    public var data: Data {
        get { return self.data; }
        set {
            let bytes: UnsafePointer<Int8>? = newValue.withUnsafeBytes{(bytes: UnsafePointer<Int8>)-> UnsafePointer<Int8> in
                return bytes;
            }
            nativeInstance.setData(nativeInstance, bytes, UInt32(newValue.count));
        }
    }
    
    internal init(_ attachment: CAttachment) {
        self.nativeInstance = attachment;
        super.init(attachment.abstractPart);
    }
    
    required public init(_ obj: CObject) {
        fatalError("init has not been implemented")
    }
    
    public func decodedString() -> String? {
        return String(utf16: nativeInstance.decodedString(nativeInstance));
    }
    
    /** Returns a MIME type for a filename.*/
    public static func mimeTypeForFilename(filename: String) -> String? {
        return String(utf16: filename.utf16({ CmimeTypeForFilename($0) }));
    }
    
    /** Returns a file attachment with the content of the given file.*/
    public static func attachmentWithContentsOfFile(filename: String) -> Attachment {
        return Attachment(filename.utf16({ CattachmentWithContentsOfFile($0) }));
    }
    
    /** Returns a file attachment with the given data and filename.*/
    public static func attachmentWithData( data: Data, filename: String) -> Attachment {
        return Attachment(filename.utf16({ CattachmentWithData(data.bytes(), data.length(), $0) }));
    }
    
    /** Returns a part with an HTML content.*/
    public static func attachmentWithHTMLString(htmlString: String) -> Attachment {
        return Attachment(htmlString.utf16({ CattachmentWithHTMLString($0) }));
    }
    
    /** Returns a part with a RFC 822 messsage attachment.*/
    public static func attachmentWithRFC822Message(messageData: Data) -> Attachment {
        return Attachment(CattachmentWithRFC822Message(messageData.bytes(), messageData.length()));
    }
    
    /** Returns a part with an plain text content.*/
    public static func attachmentWithText(text: String) -> Attachment {
        return Attachment(text.utf16({ CattachmentWithText($0) }));
    }
    
}