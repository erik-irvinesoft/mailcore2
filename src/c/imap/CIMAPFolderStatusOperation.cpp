#include "CIMAPFolderStatusOperation.h"
#include "CBase+Private.h"
#include <MailCore/MCAsync.h>

#define nativeType mailcore::IMAPFolderStatusOperation
#define structName CIMAPFolderStatusOperation

C_SYNTHESIZE_CONSTRUCTOR()
C_SYNTHESIZE_COBJECT_CAST()

C_SYNTHESIZE_FUNC_WITH_OBJ(CIMAPFolderStatus, status)
