# Shared KBuild-style verbosity controls for corebinutils subprojects.
#
# Usage in a subproject GNUmakefile:
#
#   include $(CURDIR)/../kbuild.mk
#   ...
#   $(TARGET): $(OBJS) | dirs
#           $(call cmd_link,$@,$(CC) $(LDFLAGS) -o "$@" $(OBJS) $(LDLIBS))
#
#   $(OBJDIR)/%.o: $(CURDIR)/%.c | dirs
#           $(call cmd_cc,$<,$(CC) $(CPPFLAGS) $(CFLAGS) -c "$<" -o "$@")
#
# Set V=1 for the full command line, V=0 (default) for the short form.

V ?= 0

# Verbosity:
#   V=0 (default): print only a one-line "CC foo.c" summary, hide the full
#                  command and its stderr unless it fails (make's default
#                  behavior surfaces stderr on nonzero exit).
#   V=1:           print the full command and let everything stream through.
#
# Usage pattern (single recipe line, so make treats the whole thing as one
# shell command and the leading '@' in $(E) silences it):
#
#     $(OBJDIR)/foo.o: $(CURDIR)/foo.c | dirs
#             $(E) 'CC' '$(notdir $<)' && $(CC) $(CPPFLAGS) $(CFLAGS) -c "$<" -o "$@"
#
ifeq ($(V),1)
  # V=1: do not prefix the recipe with '@', so make echoes the actual command.
  # The leading 'true' is a harmless no-op that consumes the label/target
  # arguments emitted by the recipe template.
  E := true
else
  # V=0: '@' silences both the printf and the chained command on the same line,
  # leaving only the one-line summary visible.
  E := @printf '  %-7s %s\n'
endif

# Backwards-compatible $(Q): empty in both modes because $(E) already carries
# the '@' silencer for V=0. Kept so callers may write $(Q)<cmd> on its own
# line; in that case the command is *not* silenced under V=0 — prefer the
# single-line "$(E) ... && <cmd>" pattern instead.
Q :=
