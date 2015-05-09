install:
	@echo "==> Installing symlinks"
	@git ls-tree HEAD \
		| awk '{print $$NF}' \
		| grep -v Makefile \
		| while read l; do \
			test -L $(HOME)/$$l && unlink $(HOME)/$$l; \
			ln -sF $(PWD)/$$l $(HOME)/$$l; \
			done
