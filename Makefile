SOURCE="https://www.mindomo.com/download/9.3/Mindomo_v.9.3.0_x64.AppImage"
OUTPUT="Mindomo.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	wget --output-document=$(OUTPUT) --continue $(SOURCE)
	chmod +x $(OUTPUT)

