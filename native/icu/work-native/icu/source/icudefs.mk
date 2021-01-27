# Make definitions that are shared by the different subprojects of ICU.
#
# Yves Arrouye.
#
# Copyright (C) 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html
# Copyright (C) 2000-2016, International Business Machines Corporation and others.
# All Rights Reserved.

#
# Some of these variables are overridden in the config/mh-* files.
#
# Please be sure to update config/Makefile.inc.in  if you add something here.
#

# Shell to use

SHELL = /bin/bash

# Instruct Python to never write any byte code to the ICU source tree.
export PYTHONDONTWRITEBYTECODE = 1

# Standard directories

prefix = /usr/local
exec_prefix = ${prefix}

bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
datarootdir = ${prefix}/share
datadir = ${datarootdir}
libdir = ${exec_prefix}/lib
includedir = ${prefix}/include
mandir = ${datarootdir}/man
sysconfdir = ${prefix}/etc
# controls the include of $(top_builddir)/icucross.mk at bottom of file
cross_compiling = no
cross_buildroot = 

# Package information

PACKAGE_ICU_DESCRIPTION = "International Components for Unicode"
PACKAGE_ICU_URL = "http://icu-project.org"
PACKAGE = icu
VERSION = 65.1
UNICODE_VERSION = 12.1
SO_TARGET_VERSION = 65.1
SO_TARGET_VERSION_MAJOR = 65

# The ICU data external name is usually icudata; the entry point name is
# the version-dependent name (for no particular reason except it was easier
# to change the build this way). When building in common mode, the data
# name is the versioned platform-dependent one. 

ICUDATA_DIR = ${datarootdir}/$(PACKAGE)$(ICULIBSUFFIX)/$(VERSION)

ICUDATA_BASENAME_VERSION = $(ICUPREFIX)dt65
# the entry point is almost like the basename, but has the lib suffix.  
ICUDATA_ENTRY_POINT = $(ICUPREFIX)dt65 
ICUDATA_CHAR = l
ICUDATA_PLATFORM_NAME = $(ICUDATA_BASENAME_VERSION)$(ICUDATA_CHAR)
PKGDATA_LIBSTATICNAME = -L $(STATIC_PREFIX)$(ICUPREFIX)$(DATA_STUBNAME)$(ICULIBSUFFIX)
ifeq ($(strip $(PKGDATA_MODE)),)
PKGDATA_MODE=static
endif
ifeq ($(PKGDATA_MODE),common)
ICUDATA_NAME = $(ICUDATA_PLATFORM_NAME)
ICUPKGDATA_DIR = $(ICUDATA_DIR)
else
ifeq ($(PKGDATA_MODE),dll)
ICUDATA_NAME = $(ICUDATA_PLATFORM_NAME)
PKGDATA_LIBNAME = -L $(ICUPREFIX)$(DATA_STUBNAME)$(ICULIBSUFFIX)
ICUPKGDATA_DIR = $(libdir)
else
ifeq ($(PKGDATA_MODE),static)
ICUDATA_NAME = $(ICUDATA_PLATFORM_NAME)
PKGDATA_LIBNAME = -L $(ICUPREFIX)$(DATA_STUBNAME)$(ICULIBSUFFIX)
ICUPKGDATA_DIR = $(libdir)
else
ICUDATA_NAME = $(ICUDATA_PLATFORM_NAME)
ICUPKGDATA_DIR = $(ICUDATA_DIR)
endif
endif
endif

# These are defined here because mh-cygwin-msvc needs to override these values.
ICUPKGDATA_INSTALL_DIR = $(DESTDIR)$(ICUPKGDATA_DIR)
ICUPKGDATA_INSTALL_LIBDIR = $(DESTDIR)$(libdir)

# If defined to a valid value, pkgdata will generate a data library more quickly
GENCCODE_ASSEMBLY = -a gcc

# ICU specific directories

pkgdatadir = $(datadir)/$(PACKAGE)$(ICULIBSUFFIX)/$(VERSION)
pkglibdir = $(libdir)/$(PACKAGE)$(ICULIBSUFFIX)/$(VERSION)
pkgsysconfdir = $(sysconfdir)/$(PACKAGE)$(ICULIBSUFFIX)

# Installation programs

MKINSTALLDIRS = $(SHELL) $(top_srcdir)/mkinstalldirs

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_SCRIPT = ${INSTALL}

# Library suffix (to support different C++ compilers)

ICULIBSUFFIX=

# Compiler and tools

ENABLE_DEBUG = 0
ENABLE_RELEASE = 1
EXEEXT = 
CC = gcc
CXX = g++
AR = ar
ARFLAGS =  r
RANLIB = ranlib
COMPILE_LINK_ENVVAR = 
UCLN_NO_AUTO_CLEANUP = 1
SED = /bin/sed

# Various flags for the tools

# DEFS is for common macro definitions.
# configure prevents user defined DEFS, and configure's DEFS is not needed
# So we ignore the DEFS that comes from configure
# U_ATTRIBUTE_DEPRECATED is defined to hide warnings about deprecated API warnings.
DEFS = -DU_ATTRIBUTE_DEPRECATED=
# CFLAGS is for C only flags
CFLAGS =  -O2 $(THREADSCFLAGS) 
# CXXFLAGS is for C++ only flags
CXXFLAGS =  -O2 -std=c++11 $(THREADSCXXFLAGS) 
# CPPFLAGS is for C Pre-Processor flags
CPPFLAGS = -O3 -fno-short-wchar -DU_USING_ICU_NAMESPACE=1 -fno-short-enums -DU_HAVE_NL_LANGINFO_CODESET=0 -D__STDC_INT64__ -DU_TIMEZONE=0 -DUCONFIG_NO_LEGACY_CONVERSION=1 -DUCONFIG_NO_BREAK_ITERATION=1 -DUCONFIG_NO_COLLATION=1 -DUCONFIG_NO_FORMATTING=1 -DUCONFIG_NO_TRANSLITERATION=0 -DUCONFIG_NO_REGULAR_EXPRESSIONS=1 -ffunction-sections -fdata-sections $(THREADSCPPFLAGS)  -DU_HAVE_ELF_H=1 -DU_ENABLE_DYLOAD=0 -DU_HAVE_STRTOD_L=1 -DU_HAVE_XLOCALE_H=0 
# LIBCFLAGS are the flags for static and shared libraries.
LIBCFLAGS = 
# LIBCXXFLAGS are the flags for static and shared libraries.
LIBCXXFLAGS = 
# DEFAULT_LIBS are the default libraries to link against
DEFAULT_LIBS = -lpthread -lm 
# LIB_M is for linking against the math library
LIB_M = 
# LIB_THREAD is for linking against the threading library
LIB_THREAD = 
# OUTOPT is for creating a specific output name
OUTOPT = -o # The extra space after the argument is needed.
# AR_OUTOPT is for creating a specific output name for static libraries.
AR_OUTOPT =

ENABLE_RPATH = NO
ifeq ($(ENABLE_RPATH),YES)
RPATHLDFLAGS = $(LD_RPATH)$(LD_RPATH_PRE)$(libdir)
endif
LDFLAGS =  -Wl,--gc-sections $(RPATHLDFLAGS)

# What kind of libraries are we building and linking against?
ENABLE_STATIC = YES
ENABLE_SHARED = 

# Echo w/o newline

#ECHO_N = -n
#ECHO_C = 

# Commands to compile
COMPILE.c=    $(CC) $(CPPFLAGS) $(DEFS) $(CFLAGS) -c
COMPILE.cc=   $(CXX) $(CPPFLAGS) $(DEFS) $(CXXFLAGS) -c

# Commands to link
LINK.c=       $(CC) $(CFLAGS) $(LDFLAGS) $(LINKFLAGS)
LINK.cc=      $(CXX) $(CXXFLAGS) $(LDFLAGS) $(LINKFLAGS)

# Commands to make a shared library
SHLIB.c=      $(CC) $(CFLAGS) $(LDFLAGS) -shared $(LD_SOOPTIONS)
SHLIB.cc=     $(CXX) $(CXXFLAGS) $(LDFLAGS) -shared $(LD_SOOPTIONS)

# ICU_MSG
ICU_MSG=@echo "   $(1)	"

# Do not show the large compiling arguments by default.
# To use:
# change
#    $(CC) -o foo
# to
#    $(call SILENT_COMPILE,$(CC) -o foo)
ifndef VERBOSE
    SILENT_COMPILE=$(call ICU_MSG,$(notdir $(firstword $(1)))) "... " $< && $(1) || \
			( echo "*** Failed compilation command follows: ----------------------------------------------------------" ; \
			  echo "$(1)" ; \
		          echo "--- ( rebuild with \"$(MAKE) VERBOSE=1 $(MAKECMDGOALS)\" to show all parameters ) --------" ; \
			false )
else
    SILENT_COMPILE=$(1)
endif

# Environment variable to set a runtime search path
LDLIBRARYPATH_ENVVAR = LD_LIBRARY_PATH

# Versioned target for a shared library.
FINAL_SO_TARGET = $(SO_TARGET).$(SO_TARGET_VERSION)
MIDDLE_SO_TARGET = $(SO_TARGET).$(SO_TARGET_VERSION_MAJOR)
SHARED_OBJECT = $(FINAL_SO_TARGET)

##  How ICU libraries are named...  ex. $(LIBICU)uc$(SO)
# Prefix for the ICU library names
ICUPREFIX = icu
LIBPREFIX = lib
LIBICU = $(LIBPREFIX)$(ICUPREFIX)

## If we can't use the shared libraries, use the static libraries
ifneq ($(ENABLE_SHARED),YES)
STATIC_PREFIX_WHEN_USED = s
else
STATIC_PREFIX_WHEN_USED = 
endif

# Static library prefix and file extension
STATIC_PREFIX = s
LIBSICU = $(LIBPREFIX)$(STATIC_PREFIX)$(ICUPREFIX)
A = a
SOBJ = $(SO)

# Force removal [for make clean]
RMV = rm -rf

# Platform commands to remove or move executable and library targets
# INSTALL-L installs libraries. Override in mh-* file to INSTALL_PROGRAM
#           when the library needs to have executable permissions
INSTALL-S = $(INSTALL_PROGRAM)
INSTALL-L = $(INSTALL_PROGRAM)
#INSTALL-L = $(INSTALL_DATA)

# Location of the libraries before "make install" is used
LIBDIR=$(top_builddir)/lib

# Location of the executables before "make install" is used
BINDIR=$(top_builddir)/bin

# overridden by icucross.mk
TOOLBINDIR=$(BINDIR)
TOOLLIBDIR=$(LIBDIR)

# Name flexibility for the library naming scheme.  Any modifications should
# be made in the mh- file for the specific platform.
DATA_STUBNAME = data
COMMON_STUBNAME = uc
I18N_STUBNAME = i18n
LAYOUTEX_STUBNAME = lx
IO_STUBNAME = io
TOOLUTIL_STUBNAME = tu
CTESTFW_STUBNAME = test

# get these from pkg-config, if available
ICULEHB_CFLAGS=
ICULEHB_LIBS=
ifneq ($(ICULEHB_CFLAGS),)
USING_ICULEHB=yes
ICULEHB_TRUE=
ICULEHB_FALSE=#
ICULIBS_LE=$(ICULEHB_LIBS)
ICULE_CFLAGS=$(ICULEHB_CFLAGS) -DUSING_ICULEHB
else
USING_ICULEHB=no
ICULEHB_TRUE=#
ICULEHB_FALSE=
endif

# Just the libs.
ICULIBS_DT	= -l$(STATIC_PREFIX_WHEN_USED)$(ICUPREFIX)$(DATA_STUBNAME)$(ICULIBSUFFIX)$(SO_TARGET_VERSION_SUFFIX)
ICULIBS_UC	= -l$(STATIC_PREFIX_WHEN_USED)$(ICUPREFIX)$(COMMON_STUBNAME)$(ICULIBSUFFIX)$(SO_TARGET_VERSION_SUFFIX)
ICULIBS_I18N	= -l$(STATIC_PREFIX_WHEN_USED)$(ICUPREFIX)$(I18N_STUBNAME)$(ICULIBSUFFIX)$(SO_TARGET_VERSION_SUFFIX)
ICULIBS_LX	= -l$(STATIC_PREFIX_WHEN_USED)$(ICUPREFIX)$(LAYOUTEX_STUBNAME)$(ICULIBSUFFIX)$(SO_TARGET_VERSION_SUFFIX)
ICULIBS_IO	= -l$(STATIC_PREFIX_WHEN_USED)$(ICUPREFIX)$(IO_STUBNAME)$(ICULIBSUFFIX)$(SO_TARGET_VERSION_SUFFIX)
ICULIBS_CTESTFW	= -l$(STATIC_PREFIX_WHEN_USED)$(ICUPREFIX)$(CTESTFW_STUBNAME)$(ICULIBSUFFIX)$(SO_TARGET_VERSION_SUFFIX)
ICULIBS_TOOLUTIL = -l$(STATIC_PREFIX_WHEN_USED)$(ICUPREFIX)$(TOOLUTIL_STUBNAME)$(ICULIBSUFFIX)$(SO_TARGET_VERSION_SUFFIX)
# Link commands to link to ICU libs
LLIBDIR		= -L$(LIBDIR)
LSTUBDIR	= -L$(top_builddir)/stubdata
LCTESTFW	= -L$(top_builddir)/tools/ctestfw

LIBICUDT	= $(LLIBDIR) $(LSTUBDIR) $(ICULIBS_DT)
LIBICUUC	= $(LLIBDIR) $(ICULIBS_UC) $(LSTUBDIR) $(ICULIBS_DT)
LIBICUI18N	= $(LLIBDIR) $(ICULIBS_I18N)
LIBICULE	= $(ICULEHB_CFLAGS) $(LLIBDIR) $(ICULIBS_LE)
LIBICULX	= $(LLIBDIR) $(ICULIBS_LX)
LIBCTESTFW	= $(LCTESTFW) $(ICULIBS_CTESTFW)
LIBICUTOOLUTIL	= $(LLIBDIR) $(ICULIBS_TOOLUTIL)
LIBICUIO	= $(LLIBDIR) $(ICULIBS_IO)

# Invoke, set library path for all ICU libraries.
# overridden by icucross.mk
INVOKE = $(LDLIBRARYPATH_ENVVAR)=$(LIBRARY_PATH_PREFIX)$(LIBDIR):$(top_builddir)/stubdata:$(top_builddir)/tools/ctestfw:$$$(LDLIBRARYPATH_ENVVAR) $(LEAK_CHECKER)
# prefer stubdata
PKGDATA_INVOKE = $(LDLIBRARYPATH_ENVVAR)=$(top_builddir)/stubdata:$(top_builddir)/tools/ctestfw:$(LIBRARY_PATH_PREFIX)$(LIBDIR):$$$(LDLIBRARYPATH_ENVVAR) $(LEAK_CHECKER)
INSTALLED_INVOKE = $(LDLIBRARYPATH_ENVVAR)=$(libdir):$$$(LDLIBRARYPATH_ENVVAR)

# Current full path directory for cross compilation
ifneq ($(strip $(cross_buildroot)),)
include $(cross_buildroot)/config/icucross.inc
endif

# Platform-specific setup
include $(top_srcdir)/config/mh-linux

# Current full path directory.
CURR_FULL_DIR?=$(shell pwd | sed 's/ /\\ /g')
# Current full path directory for use in source code in a -D compiler option.
CURR_SRCCODE_FULL_DIR?=$(shell pwd | sed 's/ /\\ /')

# When shared libraries are disabled and static libraries are enabled,
# the C++ compiler must be used to link in the libraries for the tools.
ifneq ($(ENABLE_SHARED),YES)
LINK.c = $(LINK.cc)
endif

# some imported things from the cross env
TOOLEXEEXT = $(EXEEXT)
ifneq ($(strip $(cross_buildroot)),)
include $(cross_buildroot)/config/icucross.mk
else
cross_buildroot = $(top_builddir)
endif

# for tests
ifneq ($(TEST_STATUS_FILE),)
TEST_OUTPUT_OPTS="-E$(TEST_STATUS_FILE)"
endif

# optional include at top
-include $(top_builddir)/icudefs.local
