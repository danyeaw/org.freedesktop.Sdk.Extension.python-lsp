ID := org.freedesktop.Sdk.Extension.python-lsp

BUILD := build
DIST := dist
REPO := $(BUILD)/repo

all: dist

dist: $(DIST)/$(ID).flatpak

update: clean
	$(MAKE) clean all
	bash update-dependencies.sh

$(DIST)/$(ID).flatpak: $(REPO)
	mkdir -p dist
	flatpak build-bundle $(REPO) $@ org.freedesktop.Sdk.Extension.python-lsp 23.08

$(REPO): *.json $(ID).yml
	flatpak-builder --force-clean --repo=$@ $(BUILD)/build $(ID).yml
	flatpak build-update-repo $(REPO)

clean:
	rm -rf $(BUILD)
	rm -rf $(DIST)
	rm -rf .flatpak-builder

# for local testing:

setup:
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub org.freedesktop.Sdk//23.08

install: $(DIST)/$(ID).flatpak
	flatpak install --user --reinstall $(DIST)/$(ID).flatpak

uninstall:
	flatpak uninstall $(ID)//master

.PHONY: all dist update clean setup install uninstall

