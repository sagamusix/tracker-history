
AMIGA_TRACKERS	= soundtracker noisetracker startrekker protracker med \
		  digibooster other-amiga

# these are actually the MS-DOS trackers
PC_TRACKERS	= fasttracker screamtracker impulsetracker digitrakker \
		  other-pc

WIN_TRACKERS	= modplugtracker renoise skale buzz

LINUX_TRACKERS	= other-linux.txt


TODOT		= ./todot
TRACKERS	= $(addsuffix .txt, $(AMIGA_TRACKERS)) \
		  $(addsuffix .txt, $(PC_TRACKERS)) \
		  $(addsuffix .txt, $(WIN_TRACKERS)) 

DATE		= `date +%Y%m%d`
THPKG		= tracker-history
THDIR		= tracker-history-$(DATE)


all: trackers.svg trackers.ps

trackers.svg: trackers.dot
	dot -Tsvg -o$@ trackers.dot
	
trackers.ps: trackers.dot
	dot -Tps -o$@ trackers.dot
	
trackers.dot: $(TRACKERS) $(TODOT) Makefile
	$(TODOT) $(TRACKERS) > $@

dist:
	rm -Rf $(THDIR)
	mkdir $(THDIR)
	cp Makefile README $(TODOT) $(TRACKERS) $(THDIR)/
	tar cf - $(THDIR) | gzip -c > $(THPKG)
	rm -Rf $(THDIR)
	ls -l $(THPKG)