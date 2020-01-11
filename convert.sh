for d in cqe-challenges/*; do
    name=$(basename $d)
	cp  ${d}/build/release/bin/${name} cgc2elf/cqe-challenges/
done
