#!/usr/bin/make -f
# Makefile for eg-amp.lv2 #
# ----------------------- #
# Created by falkTX
#

AR  ?= ar
CC  ?= gcc
CXX ?= g++

# --------------------------------------------------------------
# Fallback to Linux if no other OS defined

ifneq ($(MACOS),true)
ifneq ($(WIN32),true)
LINUX=true
endif
endif

# --------------------------------------------------------------
# Set build and link flags

BASE_FLAGS = -Wall -Wextra -pipe -Wno-unused-parameter
BASE_OPTS  = -O3 -ffast-math

ifeq ($(MACOS),true)
# MacOS linker flags
LINK_OPTS  = -Wl,-dead_strip -Wl,-dead_strip_dylibs
else
# Common linker flags
LINK_OPTS  = -Wl,-O1 -Wl,--as-needed -Wl,--strip-all
endif

ifneq ($(WIN32),true)
# not needed for Windows
BASE_FLAGS += -fPIC -DPIC
endif

ifeq ($(DEBUG),true)
BASE_FLAGS += -DDEBUG -O0 -g
LINK_OPTS   =
else
BASE_FLAGS += -DNDEBUG $(BASE_OPTS) -fvisibility=hidden
CXXFLAGS   += -fvisibility-inlines-hidden
endif

BUILD_C_FLAGS   = $(BASE_FLAGS) -std=c99 -std=gnu99 $(CFLAGS)
BUILD_CXX_FLAGS = $(BASE_FLAGS) -std=c++11 $(CXXFLAGS) $(CPPFLAGS)

ifeq ($(MACOS),true)
# 'no-undefined' is always enabled on MacOS
LINK_FLAGS      = $(LINK_OPTS) $(LDFLAGS)
else
# add 'no-undefined'
LINK_FLAGS      = $(LINK_OPTS) -Wl,--no-undefined $(LDFLAGS)
endif

# --------------------------------------------------------------
# Set shared lib extension

LIB_EXT = .so

ifeq ($(MACOS),true)
LIB_EXT = .dylib
endif

ifeq ($(WIN32),true)
LIB_EXT = .dll
endif

# --------------------------------------------------------------
# Set shared library CLI arg

SHARED = -shared

ifeq ($(MACOS),true)
SHARED = -dynamiclib
endif

# --------------------------------------------------------------
# Basic DPF setup

TARGET_DIR = build

BUILD_C_FLAGS   += -I.
BUILD_CXX_FLAGS += -I. -I../dpf/distrho

# --------------------------------------------------------------
# Set plugin binary file targets

lv2_dsp = $(TARGET_DIR)/$(NAME).lv2/$(NAME)_dsp$(LIB_EXT)
lv2_ttl = $(TARGET_DIR)/$(NAME).lv2/manifest.ttl

# --------------------------------------------------------------
# Set distrho code files

DISTRHO_PLUGIN_FILES = ../dpf/distrho/DistrhoPluginMain.cpp

# --------------------------------------------------------------
# all needs to be first

all: lv2_dsp lv2_ttl

# --------------------------------------------------------------
# Common

%.c.o: %.c
	$(CC) $< $(BUILD_C_FLAGS) -MD -MP -c -o $@

%.cpp.o: %.cpp
	$(CXX) $< $(BUILD_CXX_FLAGS) -MD -MP -c -o $@

clean:
	rm -f *.d *.o
	rm -f $(TARGET_DIR)/$(NAME).lv2/manifest.ttl
	rm -f $(TARGET_DIR)/$(NAME).lv2/$(NAME)_dsp.so
	rm -f $(TARGET_DIR)/$(NAME).lv2/$(NAME)_dsp.ttl
	rm -f $(TARGET_DIR)/lv2_ttl_generator

install:
	install -d $(DESTDIR)/usr/lib/lv2
	cp -r $(TARGET_DIR)/$(NAME).lv2 $(DESTDIR)/usr/lib/lv2/

# --------------------------------------------------------------
# LV2

lv2_dsp: $(lv2_dsp)
lv2_ttl: $(lv2_ttl)

$(lv2_dsp): $(OBJS_DSP) $(DISTRHO_PLUGIN_FILES)
	mkdir -p $(shell dirname $@)
	$(CXX) $^ $(BUILD_CXX_FLAGS) $(LINK_FLAGS) $(SHARED) -DDISTRHO_PLUGIN_TARGET_LV2 -o $@

$(lv2_ttl): $(lv2_dsp) $(TARGET_DIR)/lv2_ttl_generator
	cd $(TARGET_DIR)/$(NAME).lv2/ && \
	../lv2_ttl_generator ./$(NAME)_dsp$(LIB_EXT)

$(TARGET_DIR)/lv2_ttl_generator:
	mkdir -p $(shell dirname $@)
	$(MAKE) -C ../dpf/utils/lv2-ttl-generator/ && \
	mv ../dpf/utils/lv2_ttl_generator $@

# --------------------------------------------------------------

-include $(OBJS_DSP:%.o=%.d)

# --------------------------------------------------------------
