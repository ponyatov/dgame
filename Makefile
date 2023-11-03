# tool
CURL = curl -L -o
DC   = dmd
RUN  = dub run --compiler=$(DC)

# src
D += $(wildcard src/*.d*)

# all
.PHONY: all
all: $(D)
	$(RUN)

# format
format: tmp/format_d
tmp/format_d: $(D)
	$(RUN) dfmt -- -i $? && touch $@

# install
ETC_APT = /etc/apt/sources.list.d/d-apt.list
.PHONY: install update gz
install: doc gz $(ETC_APT)
	$(MAKE) update
	dub fetch dfmt
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
$(ETC_APT): tmp/d-apt.list
	sudo cp $< $@ ; sudo apt update &&\
	sudo apt --allow-unauthenticated install -yu d-apt-keyring
tmp/d-apt.list:
	sudo $(CURL) $@ http://master.dl.sourceforge.net/project/d-apt/files/d-apt.list

gz:
