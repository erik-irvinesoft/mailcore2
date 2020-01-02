set(CMAILCORE_ABSTRACT_HEADERS
	c/abstract/CAbstractMessage.h
	c/abstract/CAbstractMessagePart.h
	c/abstract/CAbstractMessageRendererCallback.h
	c/abstract/CAbstractMessageRendererCallbackWrapper.h
	c/abstract/CAbstractMultipart.h
	c/abstract/CAbstractPart.h
	c/abstract/CAddress.h
	c/abstract/CMessageConstants.h
	c/abstract/CMessageHeader.h
)

set(CMAILCORE_BASETYPES_HEADERS
	c/basetypes/CArray.h
	c/basetypes/CData.h
	c/basetypes/CDictionary.h
	c/basetypes/CIndexSet.h
	c/basetypes/CObject.h
	c/basetypes/MailCoreString.h
)

set(CMAILCORE_IMAP_HEADERS
	c/imap/CIMAPAppendMessageOperation.h
	c/imap/CIMAPAsyncSession.h
	c/imap/CIMAPBaseOperation.h
	c/imap/CIMAPCapabilityOperation.h
	c/imap/CIMAPCheckAccountOperation.h
	c/imap/CIMAPCopyMessagesOperation.h
	c/imap/CIMAPCustomCommandOperation.h
	c/imap/CIMAPFetchContentOperation.h
	c/imap/CIMAPFetchContentToFileOperation.h
	c/imap/CIMAPFetchFoldersOperation.h
	c/imap/CIMAPFetchMessagesOperation.h
	c/imap/CIMAPFetchNamespaceOperation.h
	c/imap/CIMAPFetchParsedContentOperation.h
	c/imap/CIMAPFolder.h
	c/imap/CIMAPFolderInfo.h
	c/imap/CIMAPFolderInfoOperation.h
	c/imap/CIMAPFolderStatus.h
	c/imap/CIMAPFolderStatusOperation.h
	c/imap/CIMAPIdentity.h
	c/imap/CIMAPIdentityOperation.h
	c/imap/CIMAPIdleOperation.h
	c/imap/CIMAPMessage.h
	c/imap/CIMAPMessagePart.h
	c/imap/CIMAPMessageRenderingOperation.h
	c/imap/CIMAPMoveMessagesOperation.h
	c/imap/CIMAPMultipart.h
	c/imap/CIMAPNamespace.h
	c/imap/CIMAPNamespaceItem.h
	c/imap/CIMAPPart.h
	c/imap/CIMAPQuotaOperation.h
	c/imap/CIMAPSearchExpression.h
	c/imap/CIMAPSearchOperation.h
)

set(CMAILCORE_PROVIDER_HEADERS
	c/provider/CMailProvider.h
	c/provider/CMailProvidersManager.h
	c/provider/CNetService.h
)

set(CMAILCORE_RFC822_HEADERS
	c/rfc822/CAttachment.h
	c/rfc822/CMessageBuilder.h
	c/rfc822/CMessageParser.h
	c/rfc822/CMessagePart.h
	c/rfc822/CMultipart.h
)

set(CMAILCORE_SMTP_HEADERS
	c/smtp/CSMTPOperation.h
	c/smtp/CSMTPSession.h
)

set(CMAILCORE_UTILS_HEADERS
	c/utils/CAutoreleasePool.h
	c/utils/COperation.h
)

set(CMAILCORE_HEADERS
	../build-android-swift/CMailCore/include/CMailCore.h
	c/CBase+Private.h
	c/CBase.h
	c/CCore.h
	${CMAILCORE_ABSTRACT_HEADERS}
	${CMAILCORE_BASETYPES_HEADERS}
	${CMAILCORE_IMAP_HEADERS}
	${CMAILCORE_PROVIDER_HEADERS}
	${CMAILCORE_RFC822_HEADERS}
	${CMAILCORE_SMTP_HEADERS}
	${CMAILCORE_UTILS_HEADERS}
)

set(CMAILCORE_MODULEMAP
	../build-android-swift/CMailCore/include/module.modulemap
)