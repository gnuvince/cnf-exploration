all: cnf.pdf cnf.erl cargo

cnf.pdf: cnf.tex
	pdflatex $<
	pdflatex $<

cnf.tex: cnf.nw
	noweave -index -delay $< > $@

cargo: cnf.nw
	notangle -R"cnf.rs" $< > cnf/src/main.rs
	cargo build --release --manifest-path cnf/Cargo.toml

cnf.erl: cnf.nw
	notangle -R"cnf.erl" $< > $@

experiments: cargo
	./cnf/target/release/cnf match1 <exprs.txt >results/match1.txt
	./cnf/target/release/cnf match2 <exprs.txt >results/match2.txt
	./cnf/target/release/cnf match3 <exprs.txt >results/match3.txt

clean:
	rm -f *.tex *.pdf *.out *.log *.nav *.aux
	rm -f cnf.erl cnf.beam

.PHONY: all clean cargo experiments
