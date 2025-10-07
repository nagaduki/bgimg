# var
HOME:=/mnt/c/Users/August
ONEDRIVE:=/mnt/c/Users/August/OneDrive/Dev
CLASSFILES=Image BackGroundManager Path Logger P 
DEBUGFILES=imagedebug pathdebug backgrounddebug classdebug
TIMESTAMP=$(shell date "+%Y%m%d_%H%M_%S")

# base
.PHONY: clean build run deploy clean

## backup
.PHONY: backup
# backup: lua/bgimg/util/*.lua
backup: 
define BACKUP
lua/bgimg/util/$(1).lua: 
	@cp lua/bgimg/util/$(1).lua $(ONEDRIVE)/backup/$(1).lua.backup.$(TIMESTAMP)
	@echo $(1).lua is backuped in onedrive.
endef
$(foreach CLASS, $(CLASSFILES),$(eval $(call BACKUP,$(CLASS))))
# $(foreach DEBUG, $(DEBUGFILES),$(eval $(call BACKUP,$(DEBUG))))


