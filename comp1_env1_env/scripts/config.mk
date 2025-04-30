ifndef ENV1_ENV_PATH
$(info Variable ENV1_ENV_PATH is not defined. Usually shall be done in project_config.mk or Makefile)
$(info Variable ENV1_ENV_PATH shall point to  verification environment location)
$(error Please set ENV1_ENV_PATH makefile variable)
endif

# include here sub-configs:
# E.g. : include $(EXAMPLE_PATH)/example/config.mk

# Incdirs
SV_TB_INCDIRS += $(ENV1_ENV_PATH)/include
SV_TB_INCDIRS += $(ENV1_ENV_PATH)/include/env
SV_TB_INCDIRS += $(ENV1_ENV_PATH)/include/seq
SV_TB_INCDIRS += $(ENV1_ENV_PATH)/include/test
SV_TB_INCDIRS += $(ENV1_ENV_PATH)/include/utils

SV_TB_SRC     += $(ENV1_ENV_PATH)/comp1_env1_tb_if.sv
SV_TB_SRC     += $(ENV1_ENV_PATH)/comp1_env1_env_pkg.sv
SV_TB_SRC     += $(ENV1_ENV_PATH)/comp1_env1_test_pkg.sv
SV_TB_SRC     += $(ENV1_ENV_PATH)/comp1_env1_wrapper.sv
SV_TB_SRC     += $(ENV1_ENV_PATH)/comp1_env1_tb.sv
