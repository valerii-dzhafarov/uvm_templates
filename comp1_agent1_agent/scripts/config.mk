ifndef AGENT1_PATH
$(info Variable AGENT1_PATH is not defined. Usually shall be done in project_config.mk or Makefile)
$(info Variable AGENT1_PATH shall point to an agent location)
$(error Please set AGENT1_PATH makefile variable)
endif

# include here sub-configs:
# E.g. : include $(EXAMPLE_PATH)/example/config.mk

# Incdirs

SV_TB_INCDIRS += $(AGENT1_PATH)/src
SV_TB_INCDIRS += $(AGENT1_PATH)/src/include
SV_TB_INCDIRS += $(AGENT1_PATH)/src/include/analysis
SV_TB_INCDIRS += $(AGENT1_PATH)/src/include/seq

SV_TB_SRC     += $(AGENT1_PATH)/src/comp1_agent1_if.sv
SV_TB_SRC     += $(AGENT1_PATH)/src/comp1_agent1_pkg.sv
