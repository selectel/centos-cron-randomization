ARCH = noarch
VERSION = 1
RELEASE = 2.selectel

RPMDIR = $(shell rpm --eval '%{_rpmdir}')
RPMBUILD = rpmbuild -v --clean \
		        --target "$(ARCH)-selectel-linux" \
				--define "version $(VERSION)" \
				--define "arch $(ARCH)" \
				--define "target $(ARCH)" \
				--define "release $(RELEASE)"

.PHONY: all targz clean mrproper

all: crontab-randomizer-$(VERSION)-$(RELEASE).$(ARCH).rpm clean
targz: crontab-randomizer-$(VERSION).tar.gz
crontab-randomizer-$(VERSION).tar.gz:
	mkdir "crontab-randomizer-$(VERSION)"
	cp -r "src/usr" "crontab-randomizer-$(VERSION)"
	tar czhf "crontab-randomizer-$(VERSION).tar.gz" "crontab-randomizer-$(VERSION)" crontab-randomizer.spec
	rm -rf "crontab-randomizer-$(VERSION)"

$(RPMDIR)/$(ARCH)/crontab-randomizer-$(VERSION)-$(RELEASE).$(ARCH).rpm: crontab-randomizer-$(VERSION).tar.gz
	$(RPMBUILD) -tb crontab-randomizer-$(VERSION).tar.gz

crontab-randomizer-$(VERSION)-$(RELEASE).$(ARCH).rpm: $(RPMDIR)/$(ARCH)/crontab-randomizer-$(VERSION)-$(RELEASE).$(ARCH).rpm
	mv "$(RPMDIR)/$(ARCH)/crontab-randomizer-$(VERSION)-$(RELEASE).$(ARCH).rpm" ./

clean:
	rm -f crontab-randomizer-*.tar.gz

mrproper: clean
	rm -f crontab-randomizer-*.rpm
