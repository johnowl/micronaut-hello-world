rm jvm.png
rm native.png
rm calls.log
rm jvm.txt
rm native.txt

echo "starting JVM"
java -jar hello-0.1-all.jar --port=8081 &
pid1=$(echo -n $!)
echo "pid1=$pid1"
sleep 5
psrecord "$pid1" --log jvm.txt --plot jvm.png &
echo "Esperando 3 segundos pro psrecord se conectar com $pid1"
sleep 3
fortio load -t 10m -qps 0 -c 10 http://localhost:8081
echo "Esperando 3 segundos antes de matar o processo"
sleep 3
kill "$pid1"

echo "Esperando alguns segundos para o próximo teste"
sleep 5

echo "starting Native"
./hello-native --port=8082 &
pid2=$(echo -n $!)
echo "pid2=$pid2"
sleep 5
psrecord "$pid2" --log native.txt --plot native.png &
echo "Esperando 3 segundos pro psrecord se conectar com $pid2"
sleep 3
fortio load -t 10m -qps 0 -c 10 http://localhost:8082
echo "Esperando 3 segundos antes de matar o processo"
sleep 3
kill "$pid2"
