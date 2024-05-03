# Quick-RRD

The tiny scripts in this folder are for quick measuring values collected by shell commands, the data is stored with RRDTool.

1. `mkdb` -- Create a database with one value, interval 1 minute.
2. `update 200` -- Write a value with cuurent timestamp into messwerte.rrd.
3. `mkgraph` -- Export a PNG image with the chart.
4. `export > data.txt` -- Writes the values of the last 24 hours into a text file.
5. `plot` -- Plots the data from `data.txt` as ASCII on terminal.

