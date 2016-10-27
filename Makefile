.PHONY: all
all:
	@echo -n "[INFO] Getting gocovmerge..."
	@go get -u github.com/wadey/gocovmerge
	@echo "DONE"
	
	@echo -n "[INFO] Compiling AND executing test binaries..."
	@go test -coverprofile=foo.cov -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic github.com/kwk/gocross/foo
	@go test -coverprofile=bar.cov -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic github.com/kwk/gocross/bar
	@go test -coverprofile=main.cov -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic github.com/kwk/gocross
	@echo "DONE"
	
	@echo "[INFO] Merging coverage profiles..."
	@gocovmerge foo.cov bar.cov main.cov > coverage.txt
	@echo "DONE"
	
	@echo "[INFO] Collecting coverage information for each package..."
	@go tool cover -func=coverage.txt
	@echo "DONE"



.PHONY: clean
clean:
	-rm -f foo.cov bar.cov main.cov
	-rm -f coverage.txt
