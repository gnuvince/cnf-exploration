all: cnf.pdf cnf.erl cnf cnf_test

cnf.pdf: cnf.tex
	pdflatex $<
	pdflatex $<

cnf.tex: cnf.nw
	noweave -index -delay $< > $@

cnf_test: cnf.rs
	rustc -O --test $< -o $@

cnf: cnf.rs
	rustc -O $< -o $@

cnf.rs: cnf.nw
	notangle -R"cnf.rs" $< > $@

cnf.erl: cnf.nw
	notangle -R"cnf.erl" $< > $@

clean:
	rm -f *.tex *.pdf *.out *.log *.nav *.aux
	rm -f cnf cnf.rs

.PHONY: all clean
