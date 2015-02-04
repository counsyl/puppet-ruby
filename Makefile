# Puppet module build configuration

.PHONY: clean dist install

clean:
	rm -rf pkg/*

dist:
	puppet module build

install:
	 puppet module install -f `ls -1t pkg/*.tar.gz | head -n 1`
