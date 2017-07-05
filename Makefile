# OldSNES Makefile for GNU/Linux
# Override the variables by passing them to make

TITLE=JFC
LONGTITLE=HOLY SHIT
PUBLISHER=GEEZUS
PRODUCT_CODE=SNS-DE-EUR
UNIQUE_ID=54333
ROM=rom.smc
FILENAME=rom.cia

rom.cia: input/${ROM} icon.bin banner.bin tools/snes9x_3ds.elf
	rm -rf romfs
	mkdir romfs
	cp input/${ROM} romfs/rom.smc
	echo ${TITLE} > romfs/rom.txt
	makerom -f cia -target t -rsf custom.rsf -o rom.cia -exefslogo -icon icon.bin -banner banner.bin -elf tools/snes9x_3ds.elf -DAPP_TITLE="${TITLE}" -DAPP_PRODUCT_CODE="${PRODUCT_CODE}" -DAPP_UNIQUE_ID="0x${UNIQUE_ID}" -DAPP_ROMFS="romfs"


# -exefslogo

icon.bin: input/icon.png
	rm -rf output
	mkdir output
	convert input/icon.png -resize 40x40! output/tempicon.png
	convert tools/icon.png output/tempicon.png -gravity center -composite output/icon.png
	rm output/tempicon.png
	bannertool makesmdh -s ${TITLE} -l ${LONGTITLE} -p ${PUBLISHER} -i output/icon.png -o icon.bin

banner.bin: input/banner.png input/jingle.wav
	bannertool makebanner -i input/banner.png -a input/jingle.wav -o banner.bin

.PHONY: clean
clean:
	rm -rf banner.bin icon.bin romfs rom.cia
