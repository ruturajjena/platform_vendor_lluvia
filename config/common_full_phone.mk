# Inherit common stuff
$(call inherit-product, vendor/lluvia/config/common.mk)
$(call inherit-product, vendor/lluvia/config/common_apn.mk)

# Telephony 
PRODUCT_PACKAGES += \
    Stk 

# SMS
PRODUCT_PACKAGES += \
	messaging

# LLuviaOTA
PRODUCT_PACKAGES += \
    LLuviaOTA
