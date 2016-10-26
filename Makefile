.PHONY: all
all:
	echo 'mode: atomic' > coverage.txt
	
	go test -v -c -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic -o foo.test github.com/gocross/foo
	go test -v -c -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic -o bar.test github.com/gocross/bar
	go test -v -c -coverpkg github.com/kwk/gocross,github.com/kwk/gocross/bar,github.com/kwk/gocross/foo -covermode=atomic -o main.test github.com/gocross
	
	./foo.test -test.v -test.coverprofile=foo.cov
	./bar.test -test.v -test.coverprofile=bar.cov
	./main.test -test.v -test.coverprofile=main.cov
	
	tail -n +2 foo.cov >> coverage.txt
	tail -n +2 bar.cov >> coverage.txt
	tail -n +2 main.cov >> coverage.txt
	
	go tool cover -func=coverage.txt

.PHONY: clean
clean:
	-rm -f foo.test bar.test main.test
	-rm -f foo.cov bar.cov main.cov
	-rm -f coverage.txt
