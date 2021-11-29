find ./ -name 'ingress.yaml' -type f > list.txt
ingress_list=$(< list.txt)

for val in $ingress_list; do

kubectl-convert -f $val --output-version networking.k8s.io/v1 > temp.txt
gsed -i '/status:\|  loadBalancer: {}/d' temp.txt
gsed -i '/creationTimestamp:/d' temp.txt
gsed -i 's/ImplementationSpecific/Prefix/' temp.txt
echo '---' > $val
cat temp.txt >> $val			
echo $val
done
