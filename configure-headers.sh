#!/bin/sh

set -ex

cp src/MailCore.h ./include/MailCore

cp src/core/MCCore.h ./include/MailCore

cp src/core/abstract/MCAbstract.h ./include/MailCore
cp src/core/abstract/MCAbstractMessage.h ./include/MailCore
cp src/core/abstract/MCAbstractMessagePart.h ./include/MailCore
cp src/core/abstract/MCAbstractMultipart.h ./include/MailCore
cp src/core/abstract/MCAbstractPart.h ./include/MailCore
cp src/core/abstract/MCAddress.h ./include/MailCore
cp src/core/abstract/MCMessageConstants.h ./include/MailCore
cp src/core/abstract/MCMessageHeader.h ./include/MailCore
cp src/core/abstract/MCErrorMessage.h ./include/MailCore

cp src/core/basetypes/MCArray.h ./include/MailCore
cp src/core/basetypes/MCAssert.h ./include/MailCore
cp src/core/basetypes/MCAutoreleasePool.h ./include/MailCore
cp src/core/basetypes/MCBaseTypes.h ./include/MailCore
cp src/core/basetypes/MCBasicLock.h ./include/MailCore
cp src/core/basetypes/MCConnectionLogger.h ./include/MailCore
cp src/core/basetypes/MCData.h ./include/MailCore
cp src/core/basetypes/MCDataDecoderUtils.h ./include/MailCore
cp src/core/basetypes/MCHash.h ./include/MailCore
cp src/core/basetypes/MCHashMap.h ./include/MailCore
cp src/core/basetypes/MCHTMLCleaner.h ./include/MailCore
cp src/core/basetypes/MCICUTypes.h ./include/MailCore
cp src/core/basetypes/MCIndexSet.h ./include/MailCore
cp src/core/basetypes/MCIterator.h ./include/MailCore
cp src/core/basetypes/MCJSON.h ./include/MailCore
cp src/core/basetypes/MCLibetpan.h ./include/MailCore
cp src/core/basetypes/MCLibetpanTypes.h ./include/MailCore
cp src/core/basetypes/MCLog.h ./include/MailCore
cp src/core/basetypes/MCNull.h ./include/MailCore
cp src/core/basetypes/MCObject.h ./include/MailCore
cp src/core/basetypes/MCOperation.h ./include/MailCore
cp src/core/basetypes/MCOperationCallback.h ./include/MailCore
cp src/core/basetypes/MCOperationQueue.h ./include/MailCore
cp src/core/basetypes/MCRange.h ./include/MailCore
cp src/core/basetypes/MCSet.h ./include/MailCore
cp src/core/basetypes/MCString.h ./include/MailCore
cp src/core/basetypes/MCUtils.h ./include/MailCore
cp src/core/basetypes/MCValue.h ./include/MailCore
cp src/core/basetypes/MCDataStreamDecoder.h ./include/MailCore
cp src/core/basetypes/MCDefines.h ./include/MailCore
cp src/core/basetypes/MCMD5.h ./include/MailCore
cp src/core/basetypes/MCOperationQueueCallback.h ./include/MailCore
cp src/core/basetypes/MCBase64.h ./include/MailCore
cp src/core/basetypes/MCLock.h ./include/MailCore
cp src/core/basetypes/MCMainThread.h ./include/MailCore
cp src/core/basetypes/MCWin32.h ./include/MailCore

cp src/core/imap/MCIMAP.h ./include/MailCore
cp src/core/imap/MCIMAPFolder.h ./include/MailCore
cp src/core/imap/MCIMAPFolderStatus.h ./include/MailCore
cp src/core/imap/MCIMAPIdentity.h ./include/MailCore
cp src/core/imap/MCIMAPMessage.h ./include/MailCore
cp src/core/imap/MCIMAPMessagePart.h ./include/MailCore
cp src/core/imap/MCIMAPMultipart.h ./include/MailCore
cp src/core/imap/MCIMAPNamespace.h ./include/MailCore
cp src/core/imap/MCIMAPNamespaceItem.h ./include/MailCore
cp src/core/imap/MCIMAPPart.h ./include/MailCore
cp src/core/imap/MCIMAPProgressCallback.h ./include/MailCore
cp src/core/imap/MCIMAPSearchExpression.h ./include/MailCore
cp src/core/imap/MCIMAPSession.h ./include/MailCore
cp src/core/imap/MCIMAPSyncResult.h ./include/MailCore

cp src/core/nntp/MCNNTP.h ./include/MailCore
cp src/core/nntp/MCNNTPGroupInfo.h ./include/MailCore
cp src/core/nntp/MCNNTPProgressCallback.h ./include/MailCore
cp src/core/nntp/MCNNTPSession.h ./include/MailCore

cp src/core/pop/MCPOP.h ./include/MailCore
cp src/core/pop/MCPOPMessageInfo.h ./include/MailCore
cp src/core/pop/MCPOPProgressCallback.h ./include/MailCore
cp src/core/pop/MCPOPSession.h ./include/MailCore

cp src/core/provider/MCAccountValidator.h ./include/MailCore
cp src/core/provider/MCMailProvider.h ./include/MailCore
cp src/core/provider/MCMailProvidersManager.h ./include/MailCore
cp src/core/provider/MCNetService.h ./include/MailCore
cp src/core/provider/MCProvider.h ./include/MailCore
cp src/core/provider/MCMXRecordResolverOperation.h ./include/MailCore

cp src/core/renderer/MCAddressDisplay.h ./include/MailCore
cp src/core/renderer/MCDateFormatter.h ./include/MailCore
cp src/core/renderer/MCHTMLBodyRendererTemplateCallback.h ./include/MailCore
cp src/core/renderer/MCHTMLRenderer.h ./include/MailCore
cp src/core/renderer/MCHTMLRendererCallback.h ./include/MailCore
cp src/core/renderer/MCRenderer.h ./include/MailCore
cp src/core/renderer/MCHTMLRendererIMAPDataCallback.h ./include/MailCore
cp src/core/renderer/MCSizeFormatter.h ./include/MailCore

cp src/core/rfc822/MCAttachment.h ./include/MailCore
cp src/core/rfc822/MCMessageBuilder.h ./include/MailCore
cp src/core/rfc822/MCMessageParser.h ./include/MailCore
cp src/core/rfc822/MCMessagePart.h ./include/MailCore
cp src/core/rfc822/MCMultipart.h ./include/MailCore
cp src/core/rfc822/MCRFC822.h ./include/MailCore

cp src/core/smtp/MCSMTP.h ./include/MailCore
cp src/core/smtp/MCSMTPProgressCallback.h ./include/MailCore
cp src/core/smtp/MCSMTPSession.h ./include/MailCore

cp src/core/zip/MCZip.h ./include/MailCore

cp src/async/MCAsync.h ./include/MailCore

cp src/async/imap/MCAsyncIMAP.h ./include/MailCore
cp src/async/imap/MCIMAPAppendMessageOperation.h ./include/MailCore
cp src/async/imap/MCIMAPAsyncSession.h ./include/MailCore
cp src/async/imap/MCIMAPCapabilityOperation.h ./include/MailCore
cp src/async/imap/MCIMAPCheckAccountOperation.h ./include/MailCore
cp src/async/imap/MCIMAPCopyMessagesOperation.h ./include/MailCore
cp src/async/imap/MCIMAPCustomCommandOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFetchContentOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFetchContentToFileOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFetchFoldersOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFetchMessagesOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFetchNamespaceOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFetchParsedContentOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFolderInfo.h ./include/MailCore
cp src/async/imap/MCIMAPFolderInfoOperation.h ./include/MailCore
cp src/async/imap/MCIMAPFolderStatusOperation.h ./include/MailCore
cp src/async/imap/MCIMAPIdentityOperation.h ./include/MailCore
cp src/async/imap/MCIMAPIdleOperation.h ./include/MailCore
cp src/async/imap/MCIMAPMessageRenderingOperation.h ./include/MailCore
cp src/async/imap/MCIMAPMoveMessagesOperation.h ./include/MailCore
cp src/async/imap/MCIMAPOperation.h ./include/MailCore
cp src/async/imap/MCIMAPOperationCallback.h ./include/MailCore
cp src/async/imap/MCIMAPQuotaOperation.h ./include/MailCore
cp src/async/imap/MCIMAPSearchOperation.h ./include/MailCore
cp src/async/imap/MCIMAPAsyncConnection.h ./include/MailCore
cp src/async/imap/MCIMAPConnectOperation.h ./include/MailCore
cp src/async/imap/MCIMAPCreateFolderOperation.h ./include/MailCore
cp src/async/imap/MCIMAPDeleteFolderOperation.h ./include/MailCore
cp src/async/imap/MCIMAPDisconnectOperation.h ./include/MailCore
cp src/async/imap/MCIMAPExpungeOperation.h ./include/MailCore
cp src/async/imap/MCIMAPMultiDisconnectOperation.h ./include/MailCore
cp src/async/imap/MCIMAPNoopOperation.h ./include/MailCore
cp src/async/imap/MCIMAPRenameFolderOperation.h ./include/MailCore
cp src/async/imap/MCIMAPStoreFlagsOperation.h ./include/MailCore
cp src/async/imap/MCIMAPStoreLabelsOperation.h ./include/MailCore
cp src/async/imap/MCIMAPSubscribeFolderOperation.h ./include/MailCore

cp src/async/nntp/MCAsyncNNTP.h ./include/MailCore
cp src/async/nntp/MCNNTPAsyncSession.h ./include/MailCore
cp src/async/nntp/MCNNTPFetchAllArticlesOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPFetchArticleOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPFetchHeaderOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPFetchOverviewOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPFetchServerTimeOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPListNewsgroupsOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPOperationCallback.h ./include/MailCore
cp src/async/nntp/MCNNTPPostOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPCheckAccountOperation.h ./include/MailCore
cp src/async/nntp/MCNNTPDisconnectOperation.h ./include/MailCore

cp src/async/pop/MCAsyncPOP.h ./include/MailCore
cp src/async/pop/MCPOPAsyncSession.h ./include/MailCore
cp src/async/pop/MCPOPFetchHeaderOperation.h ./include/MailCore
cp src/async/pop/MCPOPFetchMessageOperation.h ./include/MailCore
cp src/async/pop/MCPOPFetchMessagesOperation.h ./include/MailCore
cp src/async/pop/MCPOPOperation.h ./include/MailCore
cp src/async/pop/MCPOPOperationCallback.h ./include/MailCore
cp src/async/pop/MCPOPCheckAccountOperation.h ./include/MailCore
cp src/async/pop/MCPOPDeleteMessagesOperation.h ./include/MailCore
cp src/async/pop/MCPOPNoopOperation.h ./include/MailCore

cp src/async/smtp/MCAsyncSMTP.h ./include/MailCore
cp src/async/smtp/MCSMTPAsyncSession.h ./include/MailCore
cp src/async/smtp/MCSMTPOperation.h ./include/MailCore
cp src/async/smtp/MCSMTPOperationCallback.h ./include/MailCore
cp src/async/smtp/MCSMTPCheckAccountOperation.h ./include/MailCore
cp src/async/smtp/MCSMTPDisconnectOperation.h ./include/MailCore
cp src/async/smtp/MCSMTPLoginOperation.h ./include/MailCore
cp src/async/smtp/MCSMTPNoopOperation.h ./include/MailCore
cp src/async/smtp/MCSMTPSendWithDataOperation.h ./include/MailCore

cp src/c/CBase.h ./include/MailCore
cp src/c/CCore.h ./include/MailCore
cp src/c/CMailCore.h ./include/MailCore

cp src/c/abstract/CAbstractMessage.h ./include/MailCore
cp src/c/abstract/CAbstractMessagePart.h ./include/MailCore
cp src/c/abstract/CAbstractMessageRendererCallback.h ./include/MailCore
cp src/c/abstract/CAbstractMessageRendererCallbackWrapper.h ./include/MailCore
cp src/c/abstract/CAbstractMultipart.h ./include/MailCore
cp src/c/abstract/CAbstractPart.h ./include/MailCore
cp src/c/abstract/CAddress.h ./include/MailCore
cp src/c/abstract/CMessageConstants.h ./include/MailCore
cp src/c/abstract/CMessageHeader.h ./include/MailCore

cp src/c/basetypes/CArray.h ./include/MailCore
cp src/c/basetypes/CData.h ./include/MailCore
cp src/c/basetypes/CDictionary.h ./include/MailCore
cp src/c/basetypes/CIndexSet.h ./include/MailCore
cp src/c/basetypes/CObject.h ./include/MailCore
cp src/c/basetypes/MailCoreString.h ./include/MailCore

cp src/c/rfc822/CAttachment.h ./include/MailCore
cp src/c/rfc822/CMessageBuilder.h ./include/MailCore
cp src/c/rfc822/CMessageParser.h ./include/MailCore
cp src/c/rfc822/CMessagePart.h ./include/MailCore
cp src/c/rfc822/CMultipart.h ./include/MailCore

cp src/c/provider/CMailProvider.h ./include/MailCore
cp src/c/provider/CMailProvidersManager.h ./include/MailCore
cp src/c/provider/CNetService.h ./include/MailCore

cp src/c/smtp/CSMTPOperation.h ./include/MailCore
cp src/c/smtp/CSMTPSession.h ./include/MailCore

cp src/c/imap/CIMAPAppendMessageOperation.h ./include/MailCore
cp src/c/imap/CIMAPAsyncSession.h ./include/MailCore
cp src/c/imap/CIMAPBaseOperation.h ./include/MailCore
cp src/c/imap/CIMAPCapabilityOperation.h ./include/MailCore
cp src/c/imap/CIMAPCheckAccountOperation.h ./include/MailCore
cp src/c/imap/CIMAPCopyMessagesOperation.h ./include/MailCore
cp src/c/imap/CIMAPCustomCommandOperation.h ./include/MailCore
cp src/c/imap/CIMAPFetchContentOperation.h ./include/MailCore
cp src/c/imap/CIMAPFetchContentToFileOperation.h ./include/MailCore
cp src/c/imap/CIMAPFetchFoldersOperation.h ./include/MailCore
cp src/c/imap/CIMAPFetchMessagesOperation.h ./include/MailCore
cp src/c/imap/CIMAPFetchNamespaceOperation.h ./include/MailCore
cp src/c/imap/CIMAPFetchParsedContentOperation.h ./include/MailCore
cp src/c/imap/CIMAPFolder.h ./include/MailCore
cp src/c/imap/CIMAPFolderInfo.h ./include/MailCore
cp src/c/imap/CIMAPFolderInfoOperation.h ./include/MailCore
cp src/c/imap/CIMAPFolderStatus.h ./include/MailCore
cp src/c/imap/CIMAPFolderStatusOperation.h ./include/MailCore
cp src/c/imap/CIMAPIdentity.h ./include/MailCore
cp src/c/imap/CIMAPIdentityOperation.h ./include/MailCore
cp src/c/imap/CIMAPIdleOperation.h ./include/MailCore
cp src/c/imap/CIMAPMessage.h ./include/MailCore
cp src/c/imap/CIMAPMessagePart.h ./include/MailCore
cp src/c/imap/CIMAPMessageRenderingOperation.h ./include/MailCore
cp src/c/imap/CIMAPMoveMessagesOperation.h ./include/MailCore
cp src/c/imap/CIMAPMultipart.h ./include/MailCore
cp src/c/imap/CIMAPNamespace.h ./include/MailCore
cp src/c/imap/CIMAPNamespaceItem.h ./include/MailCore
cp src/c/imap/CIMAPPart.h ./include/MailCore
cp src/c/imap/CIMAPQuotaOperation.h ./include/MailCore
cp src/c/imap/CIMAPSearchExpression.h ./include/MailCore
cp src/c/imap/CIMAPSearchOperation.h ./include/MailCore

cp src/c/utils/COperation.h ./include/MailCore
cp src/c/utils/CAutoreleasePool.h ./include/MailCore
