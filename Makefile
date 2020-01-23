default: build_run

builds_mkdir:
	if [ ! -d "./builds" ]; then mkdir "builds"; fi

build: builds_mkdir
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build src/gsw.cr -o builds/gsw

build_release: builds_mkdir
	env LIBRARY_PATH="$(PWD)/lib_ext" crystal build --release --no-debug src/gsw.cr -o builds/gsw_release

build_run: build run

build_release_run: build_release run_release

run:
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./builds/gsw

run_release:
	env LD_LIBRARY_PATH="$(PWD)/lib_ext" ./builds/gsw_release
