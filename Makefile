.PHONY: build run clean debug release run-release logs

build:
	swift build

debug:
	swift build

release:
	swift build -c release

run: build
	scripts/package-app.sh debug --launch

run-release: release
	scripts/package-app.sh release --launch

clean:
	rm -rf .build

logs:
	ls -t ~/Library/Logs/EarthDrift/*.log 2>/dev/null | head -1 | xargs tail -f
