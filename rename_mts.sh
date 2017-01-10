#!/bin/bash

#MT1R10040102IR1.pgm.gz


cd 2010/Dec
for namafile in MT1R*
do
    
    mv -i "${namafile}" "${namafile/MT1R/MTS2}"

done
cd ../../..
