#include <MailCore/MCCore.h>
#include "CObject.h"
#include "CBase+Private.h"
#include "CDictionary.h"

#define nativeType mailcore::Object
#define structName CObject

C_SYNTHESIZE_CONSTRUCTOR()
C_SYNTHESIZE_FUNC_WITH_OBJ(CDictionary, serializable)
C_SYNTHESIZE_STATIC_FUNC_WITH_OBJ(CObject, objectWithSerializable, CDictionary)

CObject CObject_new_WithUInt32(uint32_t value) {
    return CObject_new(mailcore::Value::valueWithUnsignedIntValue(value));
}

uint32_t CObject_castToUInt32(struct CObject self) {
    return (reinterpret_cast<mailcore::Value*>(self.instance))->unsignedIntValue();
}
