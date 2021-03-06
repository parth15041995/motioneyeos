################################################################################
#
# leveldb
#
################################################################################

LEVELDB_VERSION = v1.18
LEVELDB_SITE = $(call github,google,leveldb,$(LEVELDB_VERSION))
LEVELDB_LICENSE = BSD-3c
LEVELDB_LICENSE_FILES = LICENSE
LEVELDB_INSTALL_STAGING = YES
LEVELDB_DEPENDENCIES = snappy

# We will pass optimisation level via CFLAGS so remove leveldb default
LEVELDB_MAKE_ARGS += OPTIM=

# Disable the static library for shared only build
ifeq ($(BR2_SHARED_LIBS),y)
LEVELDB_MAKE_ARGS += LIBRARY=
endif

# Disable the shared library for static only build
ifeq ($(BR2_STATIC_LIBS),y)
LEVELDB_MAKE_ARGS += SHARED=
endif

define LEVELDB_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) \
		$(LEVELDB_MAKE_ARGS) -C $(@D)
endef

define LEVELDB_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		INSTALL_ROOT=$(STAGING_DIR) INSTALL_PREFIX=/usr \
		$(LEVELDB_MAKE_ARGS) -C $(@D) install
endef

define LEVELDB_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		INSTALL_ROOT=$(TARGET_DIR) INSTALL_PREFIX=/usr \
		$(LEVELDB_MAKE_ARGS) -C $(@D) install
endef

$(eval $(generic-package))
