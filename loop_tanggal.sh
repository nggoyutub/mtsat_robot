#MTS213041810IR1

hari=20130419
mulai=$(date --date "$hari -14 hours" "+%s")
akhir=$(date --date "$hari +12 day -1 hours" "+%s")
jam=$(date --date "@$mulai" "+%s")

while [ $jam -lt $akhir ]
do
  jam=$(($jam + 3600))
  #echo $(date -d "@$jam" "+MTS213%m%d%HIR1.pgm.gz")
  `wget -e  robots=off -r   -c --no-parent http://weather.is.kochi-u.ac.jp/sat/GAME/2013/Apr/IR1/$(date -d "@$jam" "+MTS213%m%d%HIR1.pgm.gz")`
done

#MTS213041218IR1.pgm.gz
