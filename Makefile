.PHONY: all
all:
	@echo -n "[INFO] Getting gocovmerge..."
	@go get -u github.com/wadey/gocovmerge
	@echo "DONE"
	
	@echo -n "[INFO] Compiling test binaries without executing them..."
	@go test -c -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic -o foo.test github.com/kwk/gocross/foo
	@go test -c -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic -o bar.test github.com/kwk/gocross/bar
	@go test -c -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic -o main.test github.com/kwk/gocross
	@echo "DONE"
	
	@echo -n "[INFO] Executing test binaries"
	@./foo.test -test.v -test.coverprofile=foo.cov
	@./bar.test -test.v -test.coverprofile=bar.cov
	@./main.test -test.v -test.coverprofile=main.cov
	@echo "DONE"
	
	@echo "[INFO] Merging coverage profiles..."
	@gocovmerge foo.cov bar.cov main.cov > coverage.txt
	@echo "DONE"
	
	@echo "[INFO] Collecting coverage information for each package..."
	@go tool cover -func=coverage.txt
	@echo "DONE"

.PHONY: clean
clean:
	-rm -f foo.test bar.test main.test
	-rm -f foo.cov bar.cov main.cov
	-rm -f coverage.txt
