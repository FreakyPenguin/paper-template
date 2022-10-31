load "common.gnuplot"

set boxwidth 0.4
set style fill solid
set ylabel "Simulation Time [Min.]"
set yrange [0:120]
set xlabel "PCIe latency [ns]"
set xrange [-0.5:2]
unset xtics
set xtics nomirror
set xtics ("1" 0, "10" 0.5, "100" 1, "1000" 1.5)
set boxwidth 0.25
set errorbars linecolor black
unset key
plot \
'example.dat' using ($0*0.5):2:3 with boxerrorbars ls 4
