lui	t0,	0x20
mv	t1,	zero
sw	t1,	0(t0)
lw	t1,	0(t0)
not	t1,	t1
sw	t1,	0(t0)
addi	t1,	zero,	1
sw	t1,	0(t0)
j		-0x20
