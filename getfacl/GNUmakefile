.DEFAULT_GOAL := all

include $(CURDIR)/../kbuild.mk

CC ?= cc
CPPFLAGS += -D_POSIX_C_SOURCE=200809L
CFLAGS ?= -O2
CFLAGS += -std=c17 -g -Wall -Wextra -Wpedantic
LDFLAGS ?=
LDLIBS ?=

OBJDIR := $(CURDIR)/build
OUTDIR := $(CURDIR)/out
TARGET := $(OUTDIR)/getfacl
OBJS := $(OBJDIR)/getfacl.o

.PHONY: all clean dirs test status

all: $(TARGET)

dirs:
	@mkdir -p "$(OBJDIR)" "$(OUTDIR)"

$(TARGET): $(OBJS) | dirs
	$(E) 'LD' '$(notdir $@)' && $(CC) $(LDFLAGS) -o "$@" $(OBJS) $(LDLIBS)

$(OBJDIR)/getfacl.o: $(CURDIR)/getfacl.c | dirs
	$(E) 'CC' '$(notdir $<)' && $(CC) $(CPPFLAGS) $(CFLAGS) -c "$(CURDIR)/getfacl.c" -o "$@"

test: $(TARGET)
	GETFACL_BIN="$(TARGET)" sh "$(CURDIR)/tests/test.sh"

status:
	@printf '%s\n' "$(TARGET)"

clean:
	@rm -rf "$(CURDIR)/build" "$(CURDIR)/out" "$(CURDIR)/.tmp-tests"
