.DEFAULT_GOAL := all

include $(CURDIR)/../kbuild.mk

CC ?= cc
CPPFLAGS += -D_GNU_SOURCE
CFLAGS ?= -O2
CFLAGS += -g -Wall -Wextra -Wno-unused-parameter
LDFLAGS ?=
LDLIBS ?=

OBJDIR := $(CURDIR)/build
OUTDIR := $(CURDIR)/out
TARGET := $(OUTDIR)/chmod
OBJS := $(OBJDIR)/chmod.o $(OBJDIR)/mode.o

.PHONY: all clean dirs test status

all: $(TARGET)

dirs:
	@mkdir -p "$(OBJDIR)" "$(OUTDIR)"

$(TARGET): $(OBJS) | dirs
	$(E) 'LD' '$(notdir $@)' && $(CC) $(LDFLAGS) -o "$@" $(OBJS) $(LDLIBS)

$(OBJDIR)/chmod.o: $(CURDIR)/chmod.c $(CURDIR)/mode.h | dirs
	$(E) 'CC' '$(notdir $<)' && $(CC) $(CPPFLAGS) $(CFLAGS) -c "$(CURDIR)/chmod.c" -o "$@"

$(OBJDIR)/mode.o: $(CURDIR)/mode.c $(CURDIR)/mode.h | dirs
	$(E) 'CC' '$(notdir $<)' && $(CC) $(CPPFLAGS) $(CFLAGS) -c "$(CURDIR)/mode.c" -o "$@"

test: $(TARGET)
	CHMOD_BIN="$(TARGET)" sh "$(CURDIR)/tests/test.sh"

status:
	@printf '%s\n' "$(TARGET)"

clean:
	@rm -rf "$(CURDIR)/build" "$(CURDIR)/out"
