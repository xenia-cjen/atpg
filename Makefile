#############################################################################
# File       [ Makefile ]
# Author     [ littleshamoo ]
# Synopsis   [ top makefile for the whole project, generated by script ]
# Date       [ 2010/10/07 created ]
#############################################################################

include common.mk
include info.mk

# targets
OWNINS   = $(addprefix install_,$(OWNPKGS))
OWNCLN   = $(addprefix clean_,$(OWNPKGS))
OWNUNINS = $(addprefix uninstall_,$(OWNPKGS))


.PHONY: all install uninstall tags clean distclean

all : install
	@echo -n

install : $(OWNINS)
	@echo -n

uninstall : $(OWNUNINS)
	@echo -n

tags :
	ctags -R .

clean : $(OWNCLN)
	@echo -n

distclean :
	@echo "  RM    $(LIBDIR)"
	@rm -Rf $(LIBDIR)
	@echo "  RM    $(INCDIR)"
	@rm -Rf $(INCDIR)
	@echo "  RM    $(BINDIR)"
	@rm -Rf $(BINDIR)
	@for pkg in $(OWNPKGS); do \
		if [ ! -d $(PKGDIR)/$$pkg ]; then \
			echo "!! Warning: package \`$$pkg' not found and ignored"; \
			continue; \
		fi; \
		cd $(PKGDIR)/$$pkg; \
		echo "  CLN   $$pkg"; \
		rm -Rf $(LIBDIR); \
		rm -Rf $(BINDIR); \
		cd ../..; \
	done


install_% :
	@if [ ! -d $(INCDIR) ]; then \
		mkdir $(INCDIR); \
	fi
	@if [ ! -d $(LIBDIR)/$(OPTDIR) ]; then \
		mkdir -p $(LIBDIR)/$(OPTDIR); \
	fi
	@if [ ! -d $(LIBDIR)/$(DBGDIR) ]; then \
		mkdir -p $(LIBDIR)/$(DBGDIR); \
	fi
	@if [ ! -d $(BINDIR)/$(OPTDIR) ]; then \
		mkdir -p $(BINDIR)/$(OPTDIR); \
	fi
	@if [ ! -d $(BINDIR)/$(DBGDIR) ]; then \
		mkdir -p $(BINDIR)/$(DBGDIR); \
	fi
	@pkg=$(filter $(subst install_,, $@), $(OWNPKGS)); \
	if [ ! -d $(PKGDIR)/$$pkg ]; then \
		echo "!! Warning: package \`$$pkg' not found and is ignored"; \
	elif [ "$$pkg" = "" ]; then \
		echo "!! Warning: package empty"; \
	else \
		cd $(PKGDIR)/$$pkg; \
		make install --no-print-directory MODE="$(MODE)";  \
	fi

uninstall_% :
	@pkg=$(filter $(subst uninstall_,, $@), $(OWNPKGS)); \
	if [ ! -d $(PKGDIR)/$$pkg ]; then \
		echo "!! Warning: package \`$$pkg' not found and is ignored"; \
	elif [ "$$pkg" = "" ]; then \
		echo "!! Warning: package empty"; \
	else \
		cd $(PKGDIR)/$$pkg; \
		make uninstall --no-print-directory MODE="$(MODE)"; \
	fi

clean_% :
	@pkg=$(filter $(subst clean_,, $@), $(OWNPKGS)); \
	if [ ! -d $(PKGDIR)/$$pkg ]; then \
		echo "!! Warning: package \`$$pkg' not found and is ignored"; \
	elif [ "$$pkg" = "" ]; then \
		echo "!! Warning: package empty"; \
	else \
		cd $(PKGDIR)/$$pkg; \
		make clean --no-print-directory MODE="$(MODE)"; \
	fi


