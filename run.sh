for d in cqe-challenges/*; do
	make -C $d clean
	make -C $d build
done
